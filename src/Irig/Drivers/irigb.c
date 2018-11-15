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




//************************** Constant Definitions ****************************/
#define IRIG_HW_DELAY               750U

#define AR_IRIG_REG1_ADD            0x00

#define AR_IRIG_VALID_SOURCE   		0x18
#define AR_IRIG_VALID_DATA 	     	0x1C
#define AR_IRIG_PPC_LATE        	   0x20
#define AR_IRIG_STATUS              0xF0

#define AW_IRIG_ENABLE              0x00



//#define IRIG_//PRINTF             //PRINTF       //define or undefine this to enable or disable IRIG realted //PRINTF



/**************************** Type Definitions ******************************/

typedef struct
{					   
   uint8_t Valid_Source;                
   uint8_t Valid_Data;
   uint8_t PPC_Late;
} Status_Reg_t;

typedef struct
{					   
   uint32_t MilliSeconds;
   uint32_t Seconds;
   uint32_t Year;
   Status_Reg_t Status;
} IRIG_POSIXTime_t;

//************************** Global variables ****************************/
extern t_Trig gTrig;
IRIG_POSIXTime_t IRIG_POSIXTime;
IRIG_Global_Status_t IRIG_Global_Status;
struct tm rTClock;
   
   
//***************************** Private Functions prototypes**************/
void IRIG_Read_Status(Status_Reg_t *pStatus_Reg);
void IRIG_Enable_Vhd(gcRegistersData_t *pGCRegs); 
void IRIG_Read_Time();
uint16_t UnsignedBcd16ToDec(uint16_t unsignedBCD16);

  

//***************************** definition des fonctions*******************/





//-------------------------------------------------------------------------    
//  Fonction   IRIG_Processing                                                                                 
//-------------------------------------------------------------------------

void IRIG_Processing(gcRegistersData_t *pGCRegs)
{
   extern t_HderInserter gHderInserter;
   uint32_t POSIXSecAtNextPPS;
   Status_Reg_t Status;
  
  
   if(pGCRegs->TimeSource != TS_GPS)       // rien à faire si GPS présent
   {
      // lecture du statut IRIG
      IRIG_Read_Status(&Status); 
          
      if (Status.Valid_Source == 1)
      {
         if (Status.Valid_Data == 1)
         {
            // lecture des données
            IRIG_Read_Time();      
            // on envoie les données au stamper             
            if (IRIG_POSIXTime.Status.Valid_Data == 1)   
            {
               POSIXSecAtNextPPS = IRIG_POSIXTime.Seconds + 2;               
               //Overwrite of RTC time by the GPS at the next PPS
               TRIG_OverWritePOSIXNextPPS(POSIXSecAtNextPPS, IRIG_POSIXTime.MilliSeconds, &gTrig); 
            }
         }
         // la source du PPS est IRIG  
         pGCRegs->TimeSource = TS_IRIGB;         // on specifie IRIG tant qu'une source valide est detectée
         TRIG_PpsSrcSelect(TS_IRIGB, &gTrig);

         // Update header
         HDER_UpdateTimeSourceHeader(&gHderInserter, pGCRegs->TimeSource);
      }
      else if (pGCRegs->TimeSource == TS_IRIGB)
      {
         pGCRegs->TimeSource = TS_InternalRealTimeClock;

         // Update header
         HDER_UpdateTimeSourceHeader(&gHderInserter, pGCRegs->TimeSource);
      }
   } 
   
   // on signifie au vhd si le module IRIG est le Timsource ou pas
   IRIG_Enable_Vhd(pGCRegs); 
   
   // on met à jour les statuts pour les modules externes à Irig
   IRIG_Global_Status.Irig_Valid_Source = Status.Valid_Source;
   
   if (Status.Valid_Source == 1)
   {
      if ((2010 < IRIG_POSIXTime.Year) && (IRIG_POSIXTime.Year < 2100))     // c'est le domaine de definition de la donnée sur l'année qui valide le B126
      {
         IRIG_Global_Status.Irig_B122 = false;
         IRIG_Global_Status.Irig_B126 = true;                                   
      }
      else
      {      
         IRIG_Global_Status.Irig_B122 = true;
         IRIG_Global_Status.Irig_B126 = false; 
      }
   }
   else
   {
      IRIG_Global_Status.Irig_B122 = false;
      IRIG_Global_Status.Irig_B126 = false; 
   }   
} 


//---------------------------------------------------------------------------------    
//  Fonction   IRIG_Read_Status                                                                                 
//---------------------------------------------------------------------------------

void IRIG_Read_Status(Status_Reg_t *pStatus_Reg)
{
   pStatus_Reg->Valid_Source = (uint8_t)AXI4L_read32(TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AR_IRIG_VALID_SOURCE);    
   pStatus_Reg->Valid_Data   = (uint8_t)AXI4L_read32(TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AR_IRIG_VALID_DATA);
   pStatus_Reg->PPC_Late     = (uint8_t)AXI4L_read32(TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AR_IRIG_PPC_LATE);
} 
 


//---------------------------------------------------------------------------------
//  Fonction   Initialize IRIGB
//---------------------------------------------------------------------------------
 
void IRIG_Initialize(flashSettings_t *p_flashSettings)
{
   // For now, the HW delay is hardcoded.
   AXI4L_write32(IRIG_HW_DELAY, TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AW_IRIG_DELAY);
   // TODO Eventually, the delay will have to be set in the flash setting.
   //AXI4L_write32(p_flashSettings->IRIG_HW_DELAY, TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AW_IRIG_DELAY);

}


//---------------------------------------------------------------------------------    
//  Fonction   IRIG_Enable_Vhd                                                                                 
//---------------------------------------------------------------------------------
 
void IRIG_Enable_Vhd(gcRegistersData_t *pGCRegs)
{

   if(pGCRegs->TimeSource == TS_IRIGB)  
   {
      AXI4L_write32(1, TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AW_IRIG_ENABLE);                                                                       
   }
   else
   {
      AXI4L_write32(0, TEL_PAR_TEL_IRIG_CTRL_BASEADDR + AW_IRIG_ENABLE);  
   }
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
      reg_data =  (uint16_t)AXI4L_read32(TEL_PAR_TEL_IRIG_CTRL_BASEADDR + reg_add);
     
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
    IRIG_Read_Status(&IRIG_POSIXTime.Status);     
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


