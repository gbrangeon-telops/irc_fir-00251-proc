/* $Id: irig.cpp 12286 2013-01-25 19:24:16Z pdaraiche $ */

/***************************** Include Files ********************************/

#include <stdlib.h>
#include <time.h>
#include "IRIGB.h"      
#include "GeniCam.h"
#include "trig_gen.h"
#include "tel2000_param.h"
#include "mb_axi4l_bridge.h"
#include "hder_inserter.h"
#include "xparameters.h"


//************************** Global variables ****************************/
extern t_Trig gTrig;
IRIG_POSIXTime_t IRIG_POSIXTime;
struct tm rTClock;

//***************************** Private Functions prototypes**************/
void IRIG_Enable(TimeSource_t TimeSource);
void IRIG_Read_Status();
void IRIG_Read_Time();
uint16_t UnsignedBcd16ToDec(uint16_t unsignedBCD16);


//-------------------------------------------------------------------------    
//  Fonction   IRIG_Processing                                                                                 
//-------------------------------------------------------------------------

void IRIG_Processing(gcRegistersData_t *pGCRegs)
{
   static uint32_t prevTimeSource = 0xFFFFFFFF; //Undefined value to trigger a change
   extern t_HderInserter gHderInserter;
   uint32_t POSIXSecAtNextPPS;
  
   if(pGCRegs->TimeSource != TS_GPS)       // rien à faire si GPS présent
   {
      // Lecture du statut IRIG
      IRIG_Read_Status();
          
      if (IRIG_POSIXTime.Status.Valid_Source == 1)
      {
         pGCRegs->TimeSource = TS_IRIGB;         // on specifie IRIG tant qu'une source valide est detectée

         if (IRIG_POSIXTime.Status.Valid_Data == 1)  // Un POSIX time a été décodé et est prêt à être lue 
         {
            IRIG_Read_Time();  // Lecture du POSIX time
            POSIXSecAtNextPPS = IRIG_POSIXTime.Seconds + 2;
            TRIG_OverWritePOSIXNextPPS(POSIXSecAtNextPPS, IRIG_POSIXTime.MilliSeconds, &gTrig);
         }
      }
      else
      {
         pGCRegs->TimeSource = TS_InternalRealTimeClock;  // Si IRIG et GPS ne sont pas détectés
      }
   }

   // Update if necessary
   if (prevTimeSource != pGCRegs->TimeSource)
   {
      // Update header
      HDER_UpdateTimeSourceHeader(&gHderInserter, pGCRegs->TimeSource);
      // Update PPS source
      TRIG_PpsSrcSelect(pGCRegs->TimeSource, &gTrig);
      // Enable/disable
      IRIG_Enable(pGCRegs->TimeSource);
   }

   prevTimeSource = pGCRegs->TimeSource;
}

//--------------------------------------------------------------------------
//  Fonction   IRIG_Enable
//--------------------------------------------------------------------------
void IRIG_Enable(TimeSource_t TimeSource)
{
   if (TimeSource == TS_IRIGB)
      AXI4L_write32(1, XPAR_IRIG_CTRL_BASEADDR + AW_IRIG_ENABLE); // Activation du module HW
   else
      AXI4L_write32(0, XPAR_IRIG_CTRL_BASEADDR + AW_IRIG_ENABLE); // Désactivation du module HW
}

//---------------------------------------------------------------------------------    
//  Fonction   IRIG_Read_Status                                                                                 
//---------------------------------------------------------------------------------
void IRIG_Read_Status()
{
   if (TDCFlagsTst(IRIGBIsImplementedMask))
   {
      IRIG_POSIXTime.Status.Valid_Source   = (uint8_t)AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_VALID_SOURCE);
      IRIG_POSIXTime.Status.Valid_Data     = (uint8_t)AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_VALID_DATA);
   }
   else
   {
      IRIG_POSIXTime.Status.Valid_Source   = 0;
      IRIG_POSIXTime.Status.Valid_Data     = 0;
   }
}

//---------------------------------------------------------------------------------
//  Fonction   IRIG_Read_Gobal_Status
//---------------------------------------------------------------------------------
void IRIG_Read_Global_Status()
{
   if (TDCFlagsTst(IRIGBIsImplementedMask))
   {
      IRIG_POSIXTime.Status.Valid_Source   = (uint8_t)AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_VALID_SOURCE);
      IRIG_POSIXTime.Status.Valid_Data     = (uint8_t)AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_VALID_DATA);
      IRIG_POSIXTime.Status.Global_Status  = AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_GLOBAL_STATUS);
      IRIG_POSIXTime.Status.PPS_Delay      = AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_PPS_DELAY);
      IRIG_POSIXTime.Status.MB_Speed_Error = (uint8_t)AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + AR_IRIG_MB_SPEED_ERR);
   }
   else
   {
      IRIG_POSIXTime.Status.Valid_Source   = 0;
      IRIG_POSIXTime.Status.Valid_Data     = 0;
      IRIG_POSIXTime.Status.Global_Status  = 0;
      IRIG_POSIXTime.Status.PPS_Delay      = 0;
      IRIG_POSIXTime.Status.MB_Speed_Error = 0;
   }
} 

//---------------------------------------------------------------------------------
//  Fonction   Initialize IRIGB
//---------------------------------------------------------------------------------
 
void IRIG_Initialize(gcRegistersData_t *pGCRegs)
{
   AXI4L_write32(IRIG_HW_DELAY, XPAR_IRIG_CTRL_BASEADDR + AW_IRIG_DELAY);
   // TODO Eventually, the delay will have to be set in the flash setting.
   //AXI4L_write32(flashSettings.IRIG_HW_DELAY, XPAR_IRIG_CTRL_BASEADDR + AW_IRIG_DELAY);

   IRIG_Enable(pGCRegs->TimeSource);
}
 
 
//---------------------------------------------------------------------------------    
//  Fonction   IRIG_Read_Time                                                                                 
//---------------------------------------------------------------------------------
 
void IRIG_Read_Time()
{
   uint8_t reg_index;
   uint32_t reg_add;
   uint16_t reg_data;   
   
   // remplissage des champs de rTClock
   rTClock.tm_isdst = -1;                                    // l'info n'est pas disponible 
   
   for (reg_index = 1; reg_index <= 6; reg_index++) 
   {
      reg_add =   (uint8_t)AR_IRIG_REG1_ADD + 4*(reg_index - 1);
      reg_data =  (uint16_t)AXI4L_read32(XPAR_IRIG_CTRL_BASEADDR + reg_add);
     
      switch (reg_index)
      {
         case 1:       // registre des secondes
            rTClock.tm_sec  = UnsignedBcd16ToDec(reg_data); 
            break;
         case 2:       // registre des minutes
            rTClock.tm_min  = UnsignedBcd16ToDec(reg_data);
            break;      
         case 3:       // registre des heures
            rTClock.tm_hour = UnsignedBcd16ToDec(reg_data);
            break;    
         case 4:       // registre du jour de l'année
            rTClock.tm_mon = 0;
            rTClock.tm_mday = UnsignedBcd16ToDec(reg_data);
            break;     
         case 5:       // registre des millisecondes
            IRIG_POSIXTime.MilliSeconds = 100*UnsignedBcd16ToDec(reg_data);   // en fait 1000 * X/10  [ms]
            break; 
         case 6:       // registre des années
            rTClock.tm_year = (UnsignedBcd16ToDec(reg_data) + 2000) - 1900;                 // nombre d'années ecoulées depuis 1900
            break;
         default:
            break;
      }
   }

   IRIG_POSIXTime.Seconds = mktime(&rTClock);
   IRIG_POSIXTime.Year = rTClock.tm_year + 1900;                                 // reference = 2000
}


//---------------------------------------------------------------------------------    
//  Fonction   UnsignedBcd16ToDec                                                                                 
//---------------------------------------------------------------------------------
uint16_t UnsignedBcd16ToDec(uint16_t unsignedBCD16)
{
   uint16_t dec_value;
   // oui une boucle for aurait été plus elegante.
   dec_value =  (uint16_t)((unsignedBCD16 & 0x000F) + 10*((unsignedBCD16 & 0x00F0)>> 4) + 100*((unsignedBCD16 & 0x0F00)>>8) + 1000*((unsignedBCD16 & 0xF000)>>12));
   return dec_value;
}


