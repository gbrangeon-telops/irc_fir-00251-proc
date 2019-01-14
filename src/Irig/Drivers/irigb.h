/* $Id: irig.h 12286 2013-01-25 19:24:16Z pdaraiche $ */
/****************************************************************************/
/**
*
* @file IRIG.h
* 
* This driver controls the external IRIG interface.
* 
* 
* Author(s) : Edem Nofodjie
*
*****************************************************************************/
#ifndef __IRIGB_H__
#define __IRIGB_H__

/***************************** Include Files ********************************/
#include <stdbool.h>
#include <stdint.h>
#include "GC_Registers.h"  
#include "IRC_status.h" 
#include "GeniCam.h"
#include "FlashSettings.h"

/************************** Constant Definitions ****************************/
#define AW_IRIG_ENABLE              0x00
#define AW_IRIG_DELAY               0x04

#define AR_IRIG_REG1_ADD            0x00
#define AR_IRIG_VALID_SOURCE        0x18
#define AR_IRIG_VALID_DATA          0x1C
#define AR_IRIG_GLOBAL_STATUS       0x20
#define AR_IRIG_PPS_DELAY           0x24
#define AR_IRIG_MB_SPEED_ERR        0x28

#define IRIG_HW_DELAY               750U // TODO Eventually, thIS delay will have to be set in the flash settings.

/**************************** Type Definitions ******************************/
typedef struct
{
   uint8_t Valid_Source;
   uint8_t Valid_Data;
   uint32_t Global_Status;
   uint32_t PPS_Delay;
   uint8_t MB_Speed_Error;
} Status_Reg_t;


typedef struct
{
   uint32_t MilliSeconds;
   uint32_t Seconds;
   uint32_t Year;
   Status_Reg_t Status;
} IRIG_POSIXTime_t;

/************************** Function Prototypes *****************************/

void IRIG_Initialize(flashSettings_t *p_flashSettings);
void IRIG_Read_Global_Status();
void IRIG_Processing(gcRegistersData_t *pGCRegs);

/***************************************************************************
Cette fonction se charge de :
   * verifier l'etat de l'interface IRIG
   * decoder la trame IRIG
   * d'initialiser les compteurs de secondes et subsecondes du Stamper
   * de sortir les statuts relatifs au module IRIG et à la vitesse de la boucle du PPC 
   
   @param IRIG Pointer to the IRIG object
   @param pGCRegs Pointer to the Genicam registers      
 
****************************************************************************/
														 
#endif // __IRIGB_H__
