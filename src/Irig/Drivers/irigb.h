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
#define AW_IRIG_DELAY               0x04


/**************************** Type Definitions ******************************/
typedef struct
{
   bool Irig_Valid_Source;				   
   bool Irig_B122;
   bool Irig_B126;
   bool Irig_PPC_Late;
} IRIG_Global_Status_t;


/************************** Function Prototypes *****************************/

void IRIG_Initialize(flashSettings_t *p_flashSettings);

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
