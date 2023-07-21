/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 25818 $
-- $Author: pcouture $
-- $LastChangedDate: 2020-10-19 15:09:27 -0400 (Mon, 19 Oct 2020) $
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include "IRC_status.h"
#include "CRC.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "exposure_time_ctrl.h"
#include "proc_init.h"

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

// la structure Command_t a 4 bytes d'overhead(CmdID et CmdCharNum)

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 


//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x19      // 0x19 -> 0804 . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd. La valeur 0x03 est celle de LVTTL50

 // adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                    0xAF0
#define FLOW_CTLER_DVAL_ADDR               0x000
#define FLOW_CTLER_STALLED_CNT_ADDR        0x004
#define FLOW_CTLER_VALID_CNT_ADDR          0x008
#define FLOW_CTLER_LVAL_PAUSE_CNT_ADDR     0x01C
#define FLOW_CTLER_FVAL_PAUSE_CNT_ADDR     0x020
#define FLOW_CTLER_WIDTH_ADDR              0x024
#define FPA_HEIGHT_ADDR                    0x028
#define FPA_WIDTH_ADDR                     0x02C


// structure interne pour les parametres du 0804
struct mockfpa_param_s             //
{	
   float frame_period_min_usec;
   float frame_rate_max_hz;
};
typedef struct mockfpa_param_s  mockfpa_param_t;

// Global variables
t_FpaStatus gStat;                        // devient une variable globale
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint32_t sw_init_done = 0;
uint32_t sw_init_success = 0;

// Prototypes fonctions internes
void FPA_Reset(const t_FpaIntf *ptrA);
void FPA_SpecificParams(mockfpa_param_t *ptrH, t_FpaIntf *ptrA, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   sw_init_done = 0;
   sw_init_success = 0;
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd permet de populer gStat
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // FPA_SendConfigGC appelle toujours FPA_SpecificParams avant d'envoyer les configs
   FPA_Reset(ptrA);                                                         // le reste après l'envoi de la nouvelle cfg permetau module FPA de demarrer avec une config d'initialiation = celle envoyée 
   FPA_GetTemperature(ptrA);                                                // demande de lecture
}
 


//--------------------------------------------------------------------------
// pour reset du module
//--------------------------------------------------------------------------
// retenir qu'après reset, les IO sont en 'Z' après cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
void  FPA_Reset(const t_FpaIntf *ptrA)
{
   uint16_t ii;
   for(ii = 0; ii <= 100 ; ii++)
   { 
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);             //on active le reset
   }
   for(ii = 0; ii <= 100 ; ii++)
   { 
      AXI4L_write32(0, ptrA->ADD + AW_CTRLED_RESET);             //on active l'effacement
   }
}
 
//--------------------------------------------------------------------------
// pour power down (power management)
//--------------------------------------------------------------------------
void  FPA_PowerDown(const t_FpaIntf *ptrA)
{
  FPA_Reset(ptrA);   
}


//--------------------------------------------------------------------------                                                                            
//pour configuer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   mockfpa_param_t hh;

      extern int32_t gFpaDebugRegA;
   extern int32_t gFpaDebugRegB;
   extern int32_t gFpaDebugRegC;
   extern int32_t gFpaDebugRegD;

    AXI4L_write32(0, XPAR_FPA_CTRL_BASEADDR + AW_CTRLED_RESET);             // mb_ctrled_reset_i

    AXI4L_write32((uint32_t)0, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_DVAL_ADDR);   //dval to 0, user-config in progress = 1

   if(gFpaDebugRegA == 0)
        {  AXI4L_write32((uint32_t)STALLED_CNT_DEFAULT, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_STALLED_CNT_ADDR);        //flow controller config : stalled_count
        ptrA->flow_ctler_stalled_cnt = (uint32_t)STALLED_CNT_DEFAULT; }
     else
        { AXI4L_write32((uint32_t)gFpaDebugRegA, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_STALLED_CNT_ADDR);
        ptrA->flow_ctler_stalled_cnt = (uint32_t)gFpaDebugRegA; }

   if(gFpaDebugRegB == 0)
	    { AXI4L_write32((uint32_t)VALID_CNT_DEFAULT, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_VALID_CNT_ADDR);          //flow controller config : valid_cnt
	    ptrA->flow_ctler_valid_cnt = (uint32_t)VALID_CNT_DEFAULT; }
     else
	    { AXI4L_write32((uint32_t)gFpaDebugRegB, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_VALID_CNT_ADDR);
	    ptrA->flow_ctler_valid_cnt = (uint32_t)gFpaDebugRegB; }

   if(gFpaDebugRegC == 0)
	    { AXI4L_write32((uint32_t)LVAL_PAUSE_MIN_DEFAULT, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_LVAL_PAUSE_CNT_ADDR);   //flow controller config : lval_pause_min
	    ptrA->flow_ctler_lval_pause_cnt = (uint32_t)LVAL_PAUSE_MIN_DEFAULT; }
     else 
	    { AXI4L_write32((uint32_t)gFpaDebugRegC, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_LVAL_PAUSE_CNT_ADDR);
	    ptrA->flow_ctler_lval_pause_cnt = (uint32_t)gFpaDebugRegC;  }

   if(gFpaDebugRegD == 0)
	     { AXI4L_write32((uint32_t)FVAL_PAUSE_MIN_DEFAULT, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_FVAL_PAUSE_CNT_ADDR);  //flow controller config : fval_pause_min
	     ptrA->flow_ctler_fval_pause_cnt = (uint32_t)FVAL_PAUSE_MIN_DEFAULT; }
     else 
	    {  AXI4L_write32((uint32_t)gFpaDebugRegD, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_FVAL_PAUSE_CNT_ADDR);
	    ptrA->flow_ctler_fval_pause_cnt = (uint32_t)gFpaDebugRegD;}

   AXI4L_write32((uint32_t)pGCRegs->Width, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_WIDTH_ADDR);               //flow controller config : width
   AXI4L_write32((uint32_t)1, XPAR_FPA_CTRL_BASEADDR + FLOW_CTLER_DVAL_ADDR);   //dval to 0, user-config in progress = 1, flow controller config : dval to 1

   ptrA->fpa_height            = (uint32_t)pGCRegs->Height;
   ptrA->fpa_width            = (uint32_t)pGCRegs->Width;

	AXI4L_write32(ptrA->fpa_height  , XPAR_FPA_CTRL_BASEADDR + FPA_HEIGHT_ADDR);
	AXI4L_write32(ptrA->fpa_width, XPAR_FPA_CTRL_BASEADDR + FPA_WIDTH_ADDR);

   FPA_SpecificParams(&hh, ptrA, 0.0F, pGCRegs);
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(t_FpaIntf *ptrA)
{
     return -18000; // Centi celsius
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au isc0804 avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(mockfpa_param_t *ptrH, t_FpaIntf *ptrA,  float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   float bus_width = 8;
   float DIN_CLK = 100E6F;
   float Tclk = 1/ DIN_CLK;
   float A_corr_tro = 5;
   float B_corr_tro = 2*((((1920*1536)/((float)pGCRegs->Width*(float)pGCRegs->Height))/bus_width)*Tclk);


   float tro = (((float)pGCRegs->Height * (float)pGCRegs->Width) / bus_width)*Tclk;
   float lval_pause_s = (float)ptrA->flow_ctler_lval_pause_cnt*(float)pGCRegs->Height*Tclk;
   float fval_pause_s = (float)ptrA->flow_ctler_fval_pause_cnt*Tclk;
   float stall_pause_s = ((((float)pGCRegs->Height * (float)pGCRegs->Width) / bus_width) / (float)ptrA->flow_ctler_valid_cnt)*(float)ptrA->flow_ctler_stalled_cnt*Tclk;
   float A_corr =( tro+lval_pause_s + fval_pause_s+ stall_pause_s+B_corr_tro)*(A_corr_tro/100);

   ptrH->frame_period_min_usec =(A_corr + B_corr_tro + tro + lval_pause_s + fval_pause_s + stall_pause_s)*1E6F + exposureTime_usec;
   ptrH->frame_rate_max_hz = 1.0F / (ptrH->frame_period_min_usec/1E6F);
}                                                                           
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs )
{
     extern t_FpaIntf gFpaIntf;
     extern int32_t gFpaDebugRegE;
     float MaxFrameRate, MaxFrameRate_limit;
     mockfpa_param_t hh;

     // Find max frame rate limit at null exposure time
     FPA_SpecificParams(&hh, &gFpaIntf, 0.0F, pGCRegs);
     MaxFrameRate_limit = hh.frame_rate_max_hz;

     // Find max frame rate at current exposure time and limit the result
     FPA_SpecificParams(&hh, &gFpaIntf,(float)pGCRegs->ExposureTime, pGCRegs);
     MaxFrameRate = MIN(hh.frame_rate_max_hz, MaxFrameRate_limit);

     // Round maximum frame rate
     MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

     if (gFpaDebugRegE != 0)
        return 10000.0F;
     else
        return MaxFrameRate;

}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   mockfpa_param_t hh;
   extern t_FpaIntf gFpaIntf;
   extern int32_t gFpaDebugRegF;
     float periodMinWithNullExposure_usec;
     float presentPeriod_sec;
     float max_exposure_usec;
     float fpaAcquisitionFrameRate;

     // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
     fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate;

     // ENO: 10 sept 2016: tout reste inchangé
     FPA_SpecificParams(&hh, &gFpaIntf, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
     periodMinWithNullExposure_usec = hh.frame_period_min_usec;
     presentPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.

 

     max_exposure_usec = (presentPeriod_sec*1e6F - periodMinWithNullExposure_usec);

     // Round exposure time
     max_exposure_usec = floorMultiple(max_exposure_usec, 0.1);

     // Limit exposure time
     max_exposure_usec = MIN(MAX(max_exposure_usec, pGCRegs->ExposureTimeMin), FPA_MAX_EXPOSURE);

     if (gFpaDebugRegF != 0)
        return FPA_MAX_EXPOSURE;
     else
        return max_exposure_usec;


}

//--------------------------------------------------------------------------                                                                            
// Pour avoir les statuts au complet
//--------------------------------------------------------------------------
void FPA_GetStatus(t_FpaStatus *Stat, t_FpaIntf *ptrA)
{ 
   uint32_t temp_32b;
   extern gcRegistersData_t gcRegsData;

   Stat->adc_oper_freq_max_khz   = 0; // copié de isc0804A
   Stat->adc_analog_channel_num  = 0; // copié de isc0804A
   Stat->adc_resolution          = 0; // copié de isc0804A
   Stat->adc_brd_spare           = 0; // copié de isc0804A
   Stat->ddc_fpa_roic            = 255; // copié de isc0804A
   Stat->ddc_brd_spare           = 0; // copié de isc0804A
   Stat->flex_fpa_roic           = 0; // copié de isc0804A
   Stat->flex_fpa_input          = 0; // copié de isc0804A
   Stat->flex_ch_diversity_num   = 0; // copié de isc0804A
   Stat->cooler_volt_min_mV      = 1; // copié de isc0804A
   Stat->cooler_volt_max_mV      = 0; // copié de isc0804A
   Stat->fpa_temp_raw            = -1; // copié de isc0804A
   Stat->global_done             = 1; // copié de isc0804A
   Stat->fpa_powered             = 0; // copié de isc0804A
   Stat->cooler_powered          = 1; // copié de isc0804A
   Stat->errors_latchs           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x3C);
   Stat->adc_ddc_detect_process_done   = 0; // copié de isc0804A
   Stat->adc_ddc_present               = 0; // copié de isc0804A
   Stat->flex_flegx_detect_process_done      = 0; // copié de isc0804A
   Stat->flex_flegx_present                  = 0; // copié de isc0804A
   Stat->id_cmd_in_error               = 0; // copié de isc0804A
   Stat->fpa_serdes_done               = 0x8; // copié de isc0804A
   Stat->fpa_serdes_success            = 0; // copié de isc0804A
   temp_32b                            = 0; // copié de isc0804A
   memcpy(Stat->fpa_serdes_delay, (uint8_t *)&temp_32b, sizeof(Stat->fpa_serdes_delay));
   Stat->fpa_serdes_edges[0]           = 0xFFFFFFFF; // copié de isc0804A
   Stat->fpa_serdes_edges[1]           = 0xFFFFFFFF; // copié de isc0804A
   Stat->fpa_serdes_edges[2]           = 0xFFFFFFFF; // copié de isc0804A
   Stat->fpa_serdes_edges[3]           = 0xFFFFFFFF; // copié de isc0804A
   Stat->hw_init_done                  = 0; // copié de isc0804A
   Stat->hw_init_success               = 0; // copié de isc0804A
   Stat->flegx_present                 =((Stat->flex_flegx_present & Stat->adc_brd_spare) & 0x01);
   
   Stat->prog_init_done                = 0; // copié de isc0804A
   Stat->cooler_on_curr_min_mA         = 8000; // copié de isc0804A
   Stat->cooler_off_curr_max_mA        = 8000; // copié de isc0804A
                 
   Stat->acq_trig_cnt                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x94);
   Stat->acq_int_cnt                   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x98);
   Stat->fpa_readout_cnt               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x9C);
   Stat->acq_readout_cnt               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA0);
   Stat->out_pix_cnt_min               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA4);
   Stat->out_pix_cnt_max               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA8);
   Stat->trig_to_int_delay_min         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xAC);
   Stat->trig_to_int_delay_max         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB0);
   Stat->int_to_int_delay_min          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB4);
   Stat->int_to_int_delay_max          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB8);
   Stat->fast_hder_cnt                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xBC);

   // generation de fpa_init_done et fpa_init_success
   Stat->fpa_init_success = (Stat->hw_init_success & sw_init_success);
   Stat->fpa_init_done = (Stat->hw_init_done & sw_init_done);
   
   // profiter pour mettre à jour la variable globale (interne au driver) de statut  
   gStat = *Stat;
  
  // generation de sw_init_done et sw_init_success
   if ((gStat.hw_init_done == 1) && (sw_init_done == 0)){
      FPA_SendConfigGC(ptrA, &gcRegsData);    // cet envoi permet de reinitialiser le vhd avec les params requis puisque le type de hw présent est conniu maintenant (Stat->hw_init_done == 1).
      sw_init_done = 1;                       // le sw est initialisé. il ne restera que le vhd qui doit s'initialiser de nouveau 
      sw_init_success = 1;
   }  
}




