/* $Id$ */
/****************************************************************************/
/**
*
* @file AEC.h
* 
* This driver controls the module AEC via AXIL.
* 
* Author(s) : Jean-Alexis Boulet
*
*****************************************************************************/
#ifndef __AEC_H__
#define __AEC_H__

/***************************** Include Files ********************************/

#include "Genicam.h"
#include "GC_Registers.h"
#include "xintc.h"
#include "irc_status.h"
#include "tel2000_param.h"
#include "verbose.h"
#include "fpa_intf.h"

#include <math.h>

#ifdef AEC_VERBOSE
   #define AEC_PRINTF(fmt, ...)  FPGA_PRINTF("AEC: " fmt, ##__VA_ARGS__)
#else
   #define AEC_PRINTF(fmt, ...)  DUMMY_PRINTF("AEC: " fmt, ##__VA_ARGS__)
#endif


// ADRESSE du registre des statuts
#define AEC_BASE_ADDR XPAR_AEC_CTRL_BASEADDR

#define AEC_IMAGEFRACTION_OFFSET	      0x00
#define AEC_MODE_OFFSET       		   0x04
#define AEC_NBBIN_OFFSET        	      0x08
#define AEC_MSB_POS_OFFSET         	   0x0C
#define AEC_CLEARMEM_OFFSET			   0x10
#define AEC_NEW_CONFIG_FLAG_OFFSET     0x14
#define AEC_UPPERCUMSUM_OFFSET 		   0x18
#define AEC_LOWERBINID_OFFSET		      0x1C
#define AEC_LOWERCUMSUM_OFFSET 		   0x20
#define AEC_EXPOSURETIME_OFFSET		   0x24
#define AEC_TIMESTAMP_OFFSET       	   0x28
#define AEC_NB_PIXEL_OFFSET			   0x2C
#define AEC_CUMSUM_ERR_OFFSET		      0x30
#define AEC_IMAGEFRACTION_FBCK_OFFSET  0x34
#define AEC_FWPOSITION_OFFSET          0x38
#define AECP_EXPTIME_OFFSET            0x3C
#define AECP_SUMCNT_MSB_OFFSET         0x40
#define AECP_SUMCNT_LSB_OFFSET         0x44
#define AECP_NBPIXELS_OFFSET           0x48
#define AECP_DATAVALID_OFFSET          0x4C
#define DECIMATOR_INPUT_WIDTH_OFFSET   0x50
#define DECIMATOR_ENABLE_OFFSET        0x54

/************************** Constant Definitions ****************************/
#define AEC_INTR_ID		XPAR_MCU_MICROBLAZE_1_AXI_INTC_SYSTEM_AEC_INTC_INTR // TO CONFIRM
#define AEC_NB_BIN		                  128
#define AEC_EXPOSURE_TIME_RESOLUTION      0.1f // in us.

/* Explication sur l'ajustement du AEC_EXPTIME_THRESHOLD
1. On veut un seuil qui représente le pire écart entre le PET et la valeur qui sera écrite dans le header.
2. Un premier tronquage est fait par l'AEC en fonction du AEC_EXPOSURE_TIME_RESOLUTION.
2. On envoi ensuite le ET au vhdl en clks de EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ.
3. Le fpa_mblaze_intf arrondi le ET en clks de FPA_MCLK_RATE_HZ
4. Le data_dispatcher arrondi le ET en clks de EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ et l'envoi au header inserter.
*/
#define AEC_EXPTIME_THRESHOLD             (float)(AEC_EXPOSURE_TIME_RESOLUTION + (1E6F/FPA_MCLK_RATE_HZ) + (1E6F/EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ))//in us

#define CORRECTION_FACTOR_MIN             0.1f
#define CORRECTION_FACTOR_MAX             10.0f
#define AEC_BASE_CLOCK_FREQ_HZ     CLK_DATA_FREQ_HZ

#define DEFAULT_PIXDYNRANGEMIN 0
#define DEFAULT_PIXDYNRANGEMAX ((1 << FPA_DATA_RESOLUTION)-1)

#define DECIMATOR_THRESHOLD             exp2f(21.0f)-1
#define DECIMATOR_INPUT_WIDTH_MIN       64
#define DECIMATOR_INPUT_HEIGHT_MIN      4
#define DECIMATOR_DESACTIVATED_MASK     0x00000000
#define DECIMATOR_ROW_MASK              0x00000001
#define DECIMATOR_COLUMN_MASK           0x00000002
#define DECIMATOR_ACTIVATED_MASK        0x00000003

/**************************** Type Definitions ******************************/

// structure de configuration de AEC
struct s_AEC
{
   uint32_t SIZE;                // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;

   uint32_t AEC_Mode;            // le mode de fonctionnement
   uint32_t AEC_ImageFraction;   // le nombe de pixel a trouver
   uint32_t AEC_NB_Bin;				// NB bin de l'histogram
   uint32_t AEC_MSB_Pos;			// Nb de bit de l'image raw0 (13bits = 0, 14bits=1, 15bits =2, 16 bits= 3)
   uint32_t AEC_clearmem;			// Histogram Clear mem signal
   uint32_t AEC_NewConfigFlag;   // new config flag
   uint32_t AEC_DecimatorInputWidth;
   uint32_t AEC_DecimatorEnable;
  };
typedef struct s_AEC t_AEC;

//MSB POS ENUM
enum AEC_MsbPos_Enum {
   AEC_13B = 0,
   AEC_14B = 1,
   AEC_15B = 2,
   AEC_16B = 3
};

/**
 * MSB_POS enumeration values data type
 */
typedef enum AEC_MsbPos_Enum AEC_MSBPOS_t;

//MSB POS ENUM
enum AEC_Mode_Enum {
   AEC_OFF = 0,
   AEC_ON = 1
};

/**
 * MSB_POS enumeration values data type
 */
typedef enum AEC_Mode_Enum AEC_Mode_t;

/***************** Macros (Inline Functions) Definitions ********************/
#define AEC_Intf_Ctor(add) {sizeof(t_AEC)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0}

/************************** Function Prototypes *****************************/

/***************************************************************************//**
   Initializes the AEC module.
   
   @param pGCRegs Pointer to the Genicam registers
 
   @return void
   
*******************************************************************************/
IRC_Status_t AEC_Init(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL);


/***************************************************************************//**
   Reset the AEC for a new acquisition

   @return void

*******************************************************************************/
void AEC_Arm(void);

/***************************************************************************//**
   Configures the AEC module.
   
   @return void
   
*******************************************************************************/
void AEC_SendConfigGC(gcRegistersData_t *pGCRegs);


/***************************************************************************//**
   Clear the histogram

   @return void

*******************************************************************************/

void AEC_ClearMem(t_AEC *pAEC_CTRL);

/***************************************************************************//**
   Updates the AEC Mode
   
   @return void
   
*******************************************************************************/
void AEC_UpdateMode(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL);

/***************************************************************************//**
   Updates Image Fraction
   
   @return void
   
*******************************************************************************/
void AEC_UpdateImageFraction(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL);


/***************************************************************************//**
   Interrupt of the AEC module.
   
   @return void
   
*******************************************************************************/

void XAEC_InterruptHandler(XIntc * InterruptController);
void AEC_InterruptProcess(gcRegistersData_t *pGCRegs,t_AEC *gAEC_Ctrl);

AEC_MSBPOS_t AEC_GetMsbPos();

/***************************************************************************//**
   Update AEC Plus parameters from blocks and collection.

   @return void

*******************************************************************************/
void AEC_UpdateAECPlusParameters(void);



#endif // __AEC_H__
