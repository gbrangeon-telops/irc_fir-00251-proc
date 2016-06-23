/*-----------------------------------------------------------------------------
--
-- Title       : Trig Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 12286 $
-- $Author: pdaraiche $
-- $LastChangedDate: 2013-01-25 14:24:16 -0500 (ven., 25 janv. 2013) $
--
-------------------------------------------------------------------------------
--
-- Description :
--
------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "trig_gen.h"
#include "utils.h"
#include "IRC_status.h"
#include "fpa_intf.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
   #include "mb_axi4l_bridge.h"
#endif


#define SUBSEC_BASE_CLOCK_FREQ_HZ  10000000.0   // les subsecondes sont en coups d'horloge de 100ns 


// adresse des registres du temps RTC
#define A_RTC_SECONDS         0x000000D0
#define A_RTC_SUBSECOND       0x000000D4

// adresse des registres du time stamp
//#define A_STAMP_SECONDS       0xD8
//#define A_STAMP_SUBSECOND     0xDC

// adresse du registre des statuts
#define A_STATUS              0x50

// adresse du registre de PPC_Time_Sec et PPC_Time_SubSec
#define A_PPC_TIME_SEC        0x30 // Write only
#define A_PPC_TIME_SUBSEC     0x34

// adresse de l'overwrite
#define A_PPC_OVERWRITE       0x38 // Write only

// adresse de l'overwrite permit window signal
#define A_START_PPS_PERMIT_WINDOW       0x3C // Write only

// adresse du register pour PPS Time out
#define A_PPS_TIMEOUT         0x40 // Read only

// adresse du registre de contrôle
#define A_CONTROL             0x000000C0

#define A_TRIG_MODE           0x00
#define A_PERIOD              0x04
#define A_ACQ_WINDOW          0x18
#define A_PPS_SOURCE          0xE0
#define A_SEQSOFT_TRIG        0x24

// STATUS masks
#define M_TRIG_DONE           0x01
#define M_TIMESTAMP_RDY       0x02   // pour savoir si un TimeStamp est prêt
#define M_OVERWRITE_DONE      0x04
#define M_STAMPER_FLUSHED     0x08

#define M_OVERWRITE_ERR       0x10
#define M_STAMPER_WR_ERR      0x20

// CONTROL
#define C_TRIG_STOP           0x00000000
#define C_TRIG_START          0x01
#define C_RESET_ERR           0x02
#define C_FLUSH_STAMPER       0x04             // pour flusher le fifo du stamper

// les differents modes d'operation du controleur
#define VHD_INTTRIG           0x00 
#define VHD_EXTTRIG           0x01
#define VHD_SINGLE_TRIG       0x02 
#define VHD_SFW_TRIG          0x03
#define VHD_SEQ_TRIG          0x04
#define VHD_GATING            0x05

// Define des trigs d'activation dans le VHD
#define VHD_RisingEdge        0x00
#define VHD_FallingEdge       0x01
#define VHD_AnyEdge           0x02
#define VHD_LevelHigh         0x03
#define VHD_LevelLow          0x04 

#define VHD_TRIGSEQ_HARDWARE      0x0
#define VHD_TRIGSEG_SOFTWARE      0x1

extern uint32_t ProcessingTimeOutPeriod;

// Prototypes des fonctions internes
//pour stoper assez rapidement le bloc TRIGGER
uint32_t TRIG_Stop(const t_Trig *a);
//pour lancer le bloc TRIGGER avec une config precedemment envoyée
uint32_t TRIG_Start(const t_Trig *a);


//--------------------------------------------------------------------------
// Initialisation du Trigger
//--------------------------------------------------------------------------
void TRIG_Init(t_Trig *a, const gcRegistersData_t *pGCRegs)
{
   TRIG_ClearErr(a);
   TRIG_SendConfigGC(a, pGCRegs);
   TRIG_ChangeAcqWindow(a, TRIG_ExtraTrig, pGCRegs);
}

//--------------------------------------------------------------------------
// pour connaitre l'etat du Done
//--------------------------------------------------------------------------
uint32_t TRIG_Done(const t_Trig *a)
{
   uint32_t Status;
   Status = AXI4L_read32(a->ADD + A_STATUS);
   if ((Status & M_TRIG_DONE) == 0)
   {
      return IRC_NOT_DONE;
   }
   else
   {
      return IRC_DONE;
   }
}

//--------------------------------------------------------------------------
// pour stopper le bloc (ne plus envoyer de trigs et revenir à l'etat Idle)
//--------------------------------------------------------------------------
uint32_t  TRIG_Stop(const t_Trig *a)
{
   AXI4L_write32(C_TRIG_STOP, a->ADD + A_CONTROL);
   return IRC_SUCCESS;

}

//--------------------------------------------------------------------------
// pour lancer le bloc (accepter les trigs)
//--------------------------------------------------------------------------
uint32_t TRIG_Start(const t_Trig *a)
{
   uint32_t Status;                              // il faut absolûment le stopper d'abord (trigger uniquement, pas le Stamper)
   Status = TRIG_Stop(a);                     // ainsi il pourra redemarrer avec la nouvelle Config
   if (Status == IRC_SUCCESS)
   {
      AXI4L_write32(C_TRIG_START, a->ADD + A_CONTROL);
     return IRC_SUCCESS;
   }
   else
   {
      return IRC_FAILURE;                        // en principe, on ne viendra jamais ici.
   }
}

//--------------------------------------------------------------------------
// pour reset des registres d'erreur : à utiliser seulement lorsque le bloc est arrêté
//--------------------------------------------------------------------------
 void  TRIG_ClearErr(const t_Trig *a)
{
   AXI4L_write32(C_RESET_ERR, a->ADD + A_CONTROL);  //on active l'effacement
   AXI4L_write32(0x00, a->ADD + A_CONTROL);         //on desactive l'effacement mais attention on a aussi arrêté le bloc
}

//--------------------------------------------------------------------------
// Changement du frame rate
//--------------------------------------------------------------------------
void TRIG_ChangeFrameRate(t_Trig *a, t_FpaIntf *b, const gcRegistersData_t *pGCRegs)
{
   #ifdef SCD_PROXY
      FPA_SendConfigGC(b, pGCRegs);  // requis pour les SCD (à rendre plus robuste plus tard en ajoutant le temps d'integration dans la cmd operationnelle)
      FPA_GetTemperature(b);         // donne un delai supplémentaire pour la programmation du détecteur avant changement du frame rate
      FPA_SendConfigGC(b, pGCRegs);  // donne un delai supplémentaire pour la programmation du détecteur avant changement du frame rate
   #endif   
   a->TRIG_Period = (uint32_t) ( (float) TRIG_BASE_CLOCK_FREQ_HZ / pGCRegs->AcquisitionFrameRate );
   AXI4L_write32(a->TRIG_Period, a->ADD + A_PERIOD);
   TRIG_Start(a);
}

//--------------------------------------------------------------------------
//  Envoi de la confifuration(sans execution
//--------------------------------------------------------------------------
void TRIG_SendConfigGC(t_Trig *a, const gcRegistersData_t *pGCRegs)
{
   float delay_us;

   // mode du trigger
   switch (TriggerModeAry[TS_AcquisitionStart])
   {
      case TM_Off:
         //Check for the filter wheel state
         if(pGCRegs->FWMode == FWM_SynchronouslyRotating){
            a->TRIG_Mode = VHD_SFW_TRIG;
         }
         else // FWM_Fixed or FWM_AsynchronouslyRotating
         {
            // Internal trigs
            if ((TriggerModeAry[TS_Gating] == TM_On) && (TriggerModeAry[TS_Flagging] == TM_Off))
               a->TRIG_Mode = VHD_GATING; // GATE input is enabled
            else
               a->TRIG_Mode = VHD_INTTRIG; // GATE input is disabled
         }

         a->TRIG_FpaTrigDly = 0;
         a->TRIG_TrigOutDly = 0;
         a->TRIG_Activation = VHD_RisingEdge;
         a->TRIG_SeqFrameCount = 0;
         a->TRIG_SeqTrigSource = VHD_TRIGSEQ_HARDWARE;
         break;

      case TM_On:
         delay_us = MAX(0, TriggerDelayAry[TS_AcquisitionStart])*1.0e-6F;
         a->TRIG_FpaTrigDly = (uint32_t)(delay_us * (float)TRIG_BASE_CLOCK_FREQ_HZ);
         a->TRIG_TrigOutDly = (uint32_t)(delay_us * (float)TRIG_BASE_CLOCK_FREQ_HZ);

         // modes d'activation des trigs
         switch (TriggerActivationAry[TS_AcquisitionStart])                   // modes d'activation du trigger
         {
            case TA_RisingEdge :
               a->TRIG_Activation = VHD_RisingEdge;
               break;
            case TA_FallingEdge :
               a->TRIG_Activation = VHD_FallingEdge;
               break;
            case TA_AnyEdge :
               a->TRIG_Activation = VHD_AnyEdge;
               break;
            case TA_LevelHigh :
               a->TRIG_Activation = VHD_LevelHigh;
               break;
            case TA_LevelLow :
               a->TRIG_Activation = VHD_LevelLow;
               break;
            default:
               a->TRIG_Activation = VHD_RisingEdge;
               break;
         }

         // mode trig de sequence (on considère frameCount==1 comme une séquence
         a->TRIG_Mode = VHD_SEQ_TRIG;
         a->TRIG_SeqFrameCount = TriggerFrameCountAry[TS_AcquisitionStart];

         if (TriggerSourceAry[TS_AcquisitionStart] == TS_Software)
         {
            a->TRIG_SeqTrigSource = VHD_TRIGSEG_SOFTWARE;

            // En mode Trig Software on utilise toujours le rising edge
            a->TRIG_Activation = VHD_RisingEdge;
         }
         else if (TriggerSourceAry[TS_AcquisitionStart] == TS_ExternalSignal)
         {
            a->TRIG_SeqTrigSource = VHD_TRIGSEQ_HARDWARE;
         }

         break;         
      default:
         a->TRIG_Mode = VHD_INTTRIG;
         break;
   } 
   
   // autres param de configs
   a->TRIG_Period = (uint32_t)((float)TRIG_BASE_CLOCK_FREQ_HZ / pGCRegs->AcquisitionFrameRate);
   a->TRIG_ForceHigh = 0;

   //FPGA_PRINTF("TriggerActivation = %d, a->TRIG_Activation = %d\n", TriggerActivationAry[T_AcquisitionStart_Sel], a->TRIG_Activation);
   a->TRIG_AcqWindow      = TRIG_ExtraTrig; // TRIG_ExtraTrig permet de generer des extra_trigs (images non envoyées dans la chaine)   

   WriteStruct(a);
   TRIG_Start(a);
   
}

//--------------------------------------------------------------------------
//  Envoi du trig Soft
//--------------------------------------------------------------------------
void TRIG_SendTrigSoft(t_Trig *a, const gcRegistersData_t *pGCRegs)
{
   if ((TriggerModeAry[TS_AcquisitionStart] == TM_On) && (TriggerSourceAry[TS_AcquisitionStart] == TS_Software))
   {
      TRIG_SeqTrig(a);
   }
}

//--------------------------------------------------------------------------
//pour connaitre le temps réel
//--------------------------------------------------------------------------
t_PosixTime TRIG_GetRTC(const t_Trig *a)
{
t_PosixTime RTC;
   RTC.Seconds = AXI4L_read32(a->ADD + A_RTC_SECONDS);
   RTC.SubSeconds = AXI4L_read32(a->ADD + A_RTC_SUBSECOND);
   return RTC;
}

//--------------------------------------------------------------------------
//pour Overwrite du RTC
//--------------------------------------------------------------------------
void TRIG_OverWritePOSIXNow(uint32_t Time_Sec, const t_Trig *a)
{ 
   AXI4L_write32(Time_Sec, a->ADD + A_PPC_TIME_SEC);
   AXI4L_write32(0, a->ADD + A_PPC_TIME_SUBSEC);           // le subsec vaut toujours 0
   AXI4L_write32(0x00000001, a->ADD + A_PPC_OVERWRITE);
   AXI4L_write32(0x00000000, a->ADD + A_PPC_OVERWRITE);    // desactiver l'overwrite
}

//--------------------------------------------------------------------------
//pour Overwrite du RTC par le GPS et IRIG
//--------------------------------------------------------------------------
void TRIG_OverWritePOSIXNextPPS(uint32_t Time_Sec, uint32_t Time_mSec, const t_Trig *a)
{   
   uint32_t Time_Subsec;
   
   Time_Subsec = (uint32_t)((float)Time_mSec * (float)SUBSEC_BASE_CLOCK_FREQ_HZ / 1000.0F);  // conversion des millisecond en coups de clocks pour le compteur subsec
   
   AXI4L_write32(Time_Sec, a->ADD + A_PPC_TIME_SEC);
   AXI4L_write32(Time_Subsec, a->ADD + A_PPC_TIME_SUBSEC);
   // Toogle  START_PPS_PERMIT_WINDOW signal to send a pulse 
   AXI4L_write32(0x00000001, a->ADD + A_START_PPS_PERMIT_WINDOW);
   AXI4L_write32(0x00000000, a->ADD + A_START_PPS_PERMIT_WINDOW);   

}

//--------------------------------------------------------------------------
//pour Overwrite du RTC par le GPS et IRIG
//--------------------------------------------------------------------------
uint32_t TRIG_PpsTimeOut(const t_Trig *a)
{
   uint32_t PpsTimeOut;
   PpsTimeOut = AXI4L_read32(a->ADD + A_PPS_TIMEOUT);
   return PpsTimeOut;
}

//--------------------------------------------------------------------------
// pour commuter entre les modes extratrig et acqtrig en live
//--------------------------------------------------------------------------
void TRIG_ChangeAcqWindow(t_Trig *a, const enum TRIG_AcqWindow AcqWindow, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write32(AcqWindow, a->ADD + A_ACQ_WINDOW);       //AcqWindow = 0 <=> trig generés = extratrig, AcqWindow = 1 <=> trig generés = acqtrig
}

//--------------------------------------------------------------------------
//pour selectionner la source du PPS
//--------------------------------------------------------------------------
void TRIG_PpsSrcSelect(TimeSource_t TimeSource, const t_Trig *a)
{
   if (TimeSource == TS_IRIGB)
      AXI4L_write32(1, a->ADD + A_PPS_SOURCE);  // source pps = irig 
   else
      AXI4L_write32(0, a->ADD + A_PPS_SOURCE);   // source pps = gps 
}

//--------------------------------------------------------------------------
//pour lire la source du PPS
//--------------------------------------------------------------------------
uint32_t TRIG_GetPpsSrc(const t_Trig *a)
{
   return AXI4L_read32(a->ADD + A_PPS_SOURCE);
}

//--------------------------------------------------------------------------
//pour trigger une sequence
//--------------------------------------------------------------------------
void TRIG_SeqTrig(const t_Trig *a)
{
   AXI4L_write32(1, a->ADD + A_SEQSOFT_TRIG);  // source pps = irig
}
