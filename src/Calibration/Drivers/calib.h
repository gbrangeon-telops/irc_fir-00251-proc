/* $Id: calibration.h 12286 2013-01-25 19:24:16Z pdaraiche $ */
/****************************************************************************/
/**
*
* @file calibration.h
* 
* This driver controls the module CalibrationController via Axi lite32.
* Please see the following documentation about details of this module:
* 
* 
* Author(s) : Edem Nofodjie
*
*****************************************************************************/
#ifndef __calib_H__
#define __calib_H__

/***************************** Include Files ********************************/
#include <stdint.h>
#include "xbasic_types.h"  
#include "GC_Registers.h"
#include "IRC_status.h"
#include "Calibration.h"
#include "CalibCollectionFile.h"
#include "axil32_lut.h"
#include "verbose.h"

#ifdef CAL_VERBOSE
   #define CAL_PRINTF(fmt, ...)  FPGA_PRINTF("CAL: " fmt, ##__VA_ARGS__)
#else
   #define CAL_PRINTF(fmt, ...)  DUMMY_PRINTF("CAL: " fmt, ##__VA_ARGS__)
#endif

#define CAL_ERR(fmt, ...)        FPGA_PRINTF("CAL: Error: " fmt "\n", ##__VA_ARGS__)
#define CAL_INF(fmt, ...)        FPGA_PRINTF("CAL: Info: " fmt "\n", ##__VA_ARGS__)
#define CAL_DBG(fmt, ...)        CAL_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

/************************** Constant Definitions ****************************/

#define DELTA_TEMP_PARAM_OFFSET (sizeof(t_lut) + 6 * sizeof(uint32_t))  // in bytes

#define CALIB_DATAFLOWMAJORVERSION 1
//#define CALIB_DATAFLOWMINORVERSION 0
#define CALIB_DATAFLOWMINORVERSION 1   // Multi-bloc

#define NLC_LUT_PAGE_SIZE (1 << 8)      // 2^8 (largeur bus d'addresse) = 256 valeurs (uint32_t) par page
#define RQC_LUT_PAGE_SIZE (1 << 12)     // 2^12 (largeur bus d'addresse) = 4096 valeurs (uint32_t) par page

/**************************** Type Definitions ******************************/

/**
 * Calibration block select mode values.
 */
enum calibBlockSelModeEnum
{
   CBSM_USER_SEL_0 = 0,
   CBSM_USER_SEL_1 = 1,
   CBSM_USER_SEL_2 = 2,
   CBSM_USER_SEL_3 = 3,
   CBSM_USER_SEL_4 = 4,
   CBSM_USER_SEL_5 = 5,
   CBSM_USER_SEL_6 = 6,
   CBSM_USER_SEL_7 = 7,
   CBSM_EXPOSURE_TIME = 8,
   CBSM_FW_POSITION = 9,
   CBSM_NDF_POSITION = 10
};
typedef enum calibBlockSelModeEnum calibBlockSelMode_t;

/**
 * Calibration block info stored in the RAM.
 */
struct calibBlockRamInfoStruct
{
   uint32_t  SIZE;                   /**< Number of config elements, excluding SIZE and ADD. */
   uint32_t  ADD;                    /**< AXIL base address. */

   // Saturation
   uint32_t  saturation_threshold;
   // NLC
   t_lut     nlc_lut_param;
   float     range_offset_fp32;
   float     pow2_offset_exp_fp32;
   float     pow2_range_exp_fp32;
   float     nlc_pow2_m_exp_fp32;
   float     nlc_pow2_b_exp_fp32;
   // FSU
   float     delta_temp_fp32;
   float     alpha_offset_fp32;
   float     pow2_alpha_exp_fp32;
   float     pow2_beta0_exp_fp32;
   float     pow2_kappa_exp_fp32;
   // FCC
   float     nuc_mult_factor_fp32;
   // RQC
   t_lut     rqc_lut_param;
   float     rqc_pow2_m_exp_fp32;
   float     rqc_pow2_b_exp_fp32;
   // CFF
   float     offset_fp32;
   float     pow2_lsb_fp32;
};
typedef struct calibBlockRamInfoStruct calibBlockRamInfo_t;

/**
 * Calibration block info needed to fill the header.
 */
struct calibBlockHdrInfoStruct
{
   uint32_t SIZE;                   /**< Number of config elements, excluding SIZE and ADD. */
   uint32_t ADD;                    /**< AXIL base address. */

   uint32_t sel_value;
   uint32_t POSIXTime;
   float    offset_fp32;
   int32_t  data_exponent;
   uint32_t actualizationPOSIXTime; // todo sera activé lors de l'ajout du champ rapide du posix time de l'actualisation
};
typedef struct calibBlockHdrInfoStruct calibBlockHdrInfo_t;

/**
 * CAL driver object
 */
typedef struct
{
   uint32_t SIZE;                   /**< Number of config elements, excluding SIZE and ADD. */
   uint32_t ADD;                    /**< AXIL base address. */
   
   uint32_t calib_ram_block_offset; // in RAM data width (32bit)
   uint32_t pixel_data_base_addr;   // in bytes
   uint32_t width;
   uint32_t height;
   uint32_t offsetx;
   uint32_t offsety;
   float    exposure_time_mult_fp32;
   uint32_t calib_block_index_max;
   calibBlockSelMode_t calib_block_sel_mode;
   calibBlockHdrInfo_t* calib_block; // not to be written by WriteStruct (see associated Ctor macro)
} t_calib;

// statuts provenant du vhd
struct s_CalStatus    // 
{					            
  uint32_t  done;
  uint32_t  error_set[5];
};
typedef struct s_CalStatus t_CalStatus;


/***************** Macros (Inline Functions) Definitions ********************/
#define CAL_Config_Ctor(add) {sizeof(t_calib)/4 - 4, add}//, 0, 0, 0, 0, 0, 0, 0.0F, 0, 0, 0} // CR_WARNING le pointeur à la fin n'est pas inclu
#define CAL_Param_Ctor(add) {sizeof(calibBlockRamInfo_t)/4 - 2, add}//, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0, 0}

/************************** Prototypes des fonctions *****************************/
void CAL_Init(t_calib *pA, const gcRegistersData_t *pGCRegs);
void CAL_UpdateDeltaF(const t_calib *pA);
IRC_Status_t CAL_SendConfigGC(t_calib *pA, gcRegistersData_t *pGCRegs);
void CAL_UpdateCalibBlockSelMode(t_calib *pA, gcRegistersData_t *pGCRegs);
void CAL_ApplyCalibBlockSelMode(const t_calib *pA, gcRegistersData_t *pGCRegs);
IRC_Status_t CAL_WriteBlockParam(const t_calib *pA, const gcRegistersData_t *pGCRegs);
void CAL_GetStatus(t_CalStatus *Stat, const t_calib *pA);
void CAL_UpdateVideo(const t_calib *pA, gcRegistersData_t *pGCRegs);
 
#endif // __calib_H__
