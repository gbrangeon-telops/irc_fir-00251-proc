/*-----------------------------------------------------------------------------
--
-- Title       : calibration Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "utils.h"
#include "IRC_status.h"
#include "calib.h"
#include <math.h>
#include <string.h>
#include "exposure_time_ctrl.h"
#include "GC_Registers.h"
#include "hder_inserter.h"
#include "Actualization.h"
#include "FlashSettings.h"
#include "FlashDynamicValues.h"
#include "proc_memory.h"
#include "tel2000_param.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
   #include "calibration_tb.h"
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"
   #include "mb_axi4l_bridge.h"
#endif


// ADRESSES
#define AW_BLOCK_SEL_MODE  0x20
#define AW_BLOCK_IDX_ADDR  0x24
#define AW_BLOCK_CFG_DONE  0x28
#define AW_BLOCK_OFFSET    0x2C

#define AW_FLUSHPIPE       0xD0
#define AW_RESET_ERR       0xD4

#define AR_DONE            0xE8
#define AR_ERR_REG0        0xEC
#define AR_ERR_REG1        0xF0
#define AR_ERR_REG2        0xF4
#define AR_ERR_REG3        0xF8
#define AR_ERR_REG4        0xFC


// Adresse des  switchs et trous
#define AW_INPUT_SW        0xA4
#define AW_DATATYPE_SW     0xA8
#define AW_OUTPUT_SW       0xAC
#define AW_NLC_FALL        0xB0
#define AW_RQC_FALL        0xB4
#define AW_FCC_FALL        0xB8

// Ctrl Video
#define AW_VIDEO_BPR_MODE           0xCC
#define AW_CALIB_BPR_MODE           0xD8

// Lut switch control
#define AW_CALIB_LUT_SWITCH         0xDC
#define CALIB_NLC_LUT_SWITCH_MASK   0x00000001
#define CALIB_RQC_LUT_SWITCH_MASK   0x00000002


// CONTROLE des switches : definition generale 
#define SW_TO_PATH0        0x00                            // switch dirigé vers son entree/sortie 0 (voir vhd des switch)
#define SW_TO_PATH1        0x01                            // switch dirigé vers son entree/sortie 1 (voir vhd des switch)
#define SW_TO_PATH2        0x02                            // switch dirigé vers son entree/sortie 2 (voir vhd des switch)
#define SW_BLOCKED         0x03                            // blocage des switches
#define FALL_OFF           0x00
#define FALL_ON            0x01




// quelques definitions de types
typedef enum
{       
  Mode_block,                                              
  Mode_NonLinRaw,                                      
  Mode_LinRaw,                                       
  Mode_NucOnly,
  Mode_FullCalib  
} cal_mode_t;

														

// Variables globales
// public
bool blockLoadCmdFlag = false;  // Reset command of block load
// privé
static calibBlockRamInfo_t blockRam = CAL_Param_Ctor(0);
static calibBlockHdrInfo_t calib_blocks[CALIB_MAX_NUM_OF_BLOCKS];


// declaration fonctions internes
static void CAL_flushPipe(const t_calib *pA, const gcRegistersData_t *pGCRegs);
static void CAL_configSwitchesAndHoles(const t_calib *pA, cal_mode_t calib_mode, const gcRegistersData_t *pGCRegs);
static void CAL_resetErr(const t_calib *pA);
static void CAL_initCalBlockInfo(calibBlockHdrInfo_t* b, uint32_t n);

void CAL_initCalBlockInfo(calibBlockHdrInfo_t* b, uint32_t n)
{
   int i;

   for (i=0; i<n; ++i)
   {
      b->SIZE = sizeof(calibBlockHdrInfo_t)/4 - 2;
      b->ADD = XPAR_CALIBCONFIG_AXI_BASEADDR + AW_BLOCK_OFFSET;
      b->sel_value = 0;
      b->POSIXTime = 0;
      b->offset_fp32 = 0;
      b->data_exponent = 0;
      b->actualizationPOSIXTime = 0;
      b->low_cut = 0;
      b->high_cut = 0;
      b++;
   }
}

void CAL_Init(t_calib *pA, const gcRegistersData_t *pGCRegs)
{
   // Init constant values
   pA->calib_ram_block_offset = blockRam.SIZE;
   pA->pixel_data_base_addr = PROC_MEM_PIXEL_DATA_BASEADDR;

   pA->calib_block = calib_blocks;
   CAL_initCalBlockInfo(pA->calib_block, CALIB_MAX_NUM_OF_BLOCKS);

   // bloquer les SW
   CAL_configSwitchesAndHoles(pA, Mode_block, pGCRegs);
   
   // flusher le pipe
   CAL_flushPipe(pA, pGCRegs);
   
   // reset des erreurs
   CAL_resetErr(pA);

   AXI4L_write32(pGCRegs->VideoBadPixelReplacement, pA->ADD + AW_VIDEO_BPR_MODE);

   CAL_UpdateCalibBprMode(pA, pGCRegs);
}


void CAL_UpdateDeltaF(const t_calib *pA, const gcRegistersData_t *pGCRegs)
{
   float DeltaF;
   uint32_t *p_DeltaF = (uint32_t *)(&DeltaF);
   uint32_t blockIndex;
   uint32_t DeltaF_RamAddr;
   float FWReferenceTemperature;     //in Celsius

   FWReferenceTemperature = (flashSettings.FWReferenceTemperatureGain * (float)pGCRegs->FWSpeed) + flashSettings.FWReferenceTemperatureOffset;

   for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
   {
      // param addr = ram base addr + block offset + param offset (inside the block)
      DeltaF_RamAddr = XPAR_CALIB_RAM_AXI_BASEADDR + (blockIndex * pA->calib_ram_block_offset * sizeof(uint32_t)) + DELTA_TEMP_PARAM_OFFSET;

      if ((calibrationInfo.blocks[blockIndex].isValid) && (calibrationInfo.blocks[blockIndex].T0 != 0))
      {
         if (flashSettings.FWPresent && (pGCRegs->FWMode == FWM_SynchronouslyRotating) && (flashSettings.FWReferenceTemperatureGain != 0.0F))
         {
            DeltaF = powf(C_TO_K(DeviceTemperatureAry[DTS_InternalLens]) / C_TO_K(FWReferenceTemperature), calibrationInfo.blocks[blockIndex].Nu) - 1.0F;
            CAL_DBG("FWReferenceTemperature = %dC", FWReferenceTemperature);
         }
         else
         {
            DeltaF = powf(C_TO_K(DeviceTemperatureAry[DTS_InternalLens]) / CC_TO_K(calibrationInfo.blocks[blockIndex].T0), calibrationInfo.blocks[blockIndex].Nu) - 1.0F;
            CAL_DBG("calibrationInfo.blocks[%d].T0 = %dcC", blockIndex, calibrationInfo.blocks[blockIndex].T0);
         }

         CAL_DBG("DeviceTemperatureAry[DTS_InternalLens] = %dcC", C_TO_CC(DeviceTemperatureAry[DTS_InternalLens]));
         CAL_DBG("calibrationInfo.blocks[%d].Nu x 1000 = %d", blockIndex, (uint32_t)(calibrationInfo.blocks[blockIndex].Nu * 1000.0F));
      }
      else
      {
         DeltaF = 0.0F;
      }
      CAL_DBG("Block[%d] DeltaF x 1000 = %d", blockIndex, (uint32_t)(DeltaF * 1000.0F));

      CAL_DBG("*p_DeltaF = 0x%08X", (*p_DeltaF));
      AXI4L_write32(*p_DeltaF, DeltaF_RamAddr);
   }
}

 
//------------------------------------------------- 
// FONCTION : CAL_SendConfigGC
//-------------------------------------------------
IRC_Status_t CAL_SendConfigGC(t_calib *pA, gcRegistersData_t *pGCRegs)
{
   cal_mode_t calib_mode;
   enum lutRQIndexEnum lutRQIndex;
   uint32_t blockIndex;

   switch (pGCRegs->CalibrationMode)
   {
      case CM_IBI:
         calib_mode = Mode_FullCalib;
         lutRQIndex = LUTRQI_IBI;
         break;

      case CM_IBR:
         calib_mode = Mode_FullCalib;
         lutRQIndex = LUTRQI_IBR;
         break;

      case CM_RT:
         calib_mode = Mode_FullCalib;
         lutRQIndex = LUTRQI_RT;
         break;

      case CM_NUC:
         calib_mode = Mode_NucOnly;
         lutRQIndex = LUTRQI_MAX_NUM_OF_LUTRQ;
         break;

      case CM_Raw:
         calib_mode = Mode_LinRaw;
         lutRQIndex = LUTRQI_MAX_NUM_OF_LUTRQ;
         break;

      case CM_Raw0:
      default:
         calib_mode = Mode_NonLinRaw;
         lutRQIndex = LUTRQI_MAX_NUM_OF_LUTRQ;
   }

   CAL_INF("CalibrationMode = %d", pGCRegs->CalibrationMode);
   CAL_DBG("calib_mode = %d", (uint32_t)calib_mode);

   pA->width = pGCRegs->Width;
   pA->height = pGCRegs->Height;
   pA->offsetx = pGCRegs->OffsetX;
   pA->offsety = pGCRegs->OffsetY;
   pA->exposure_time_mult_fp32 = (1.0F / EXPOSURE_TIME_FACTOR);  // facteur de multiplication pour avoir le temps d'exposition en µsec

   // Reset header info of all blocks
   CAL_initCalBlockInfo(pA->calib_block, CALIB_MAX_NUM_OF_BLOCKS);

   pA->calib_block_index_max = 0;
   CAL_INF("calib_block_sel_mode = %d", (uint32_t)pA->calib_block_sel_mode);

   if (calibrationInfo.isValid)
   {
      pA->calib_block_index_max = calibrationInfo.collection.NumberOfBlocks - 1;

      // Fill header info of valid blocks
      // header info of other blocks stays to 0
      for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
      {
         // Fill selection value depending on selection mode
         switch (pA->calib_block_sel_mode)
         {
            case CBSM_EXPOSURE_TIME:
               pA->calib_block[blockIndex].sel_value = calibrationInfo.blocks[blockIndex].ExposureTime;  // same units
               break;

            case CBSM_FW_POSITION:
               pA->calib_block[blockIndex].sel_value = calibrationInfo.blocks[blockIndex].FWPosition;
               break;

            case CBSM_NDF_POSITION:
               pA->calib_block[blockIndex].sel_value = calibrationInfo.blocks[blockIndex].NDFPosition;
               break;

            case CBSM_USER_SEL_0:
            case CBSM_USER_SEL_1:
            case CBSM_USER_SEL_2:
            case CBSM_USER_SEL_3:
            case CBSM_USER_SEL_4:
            case CBSM_USER_SEL_5:
            case CBSM_USER_SEL_6:
            case CBSM_USER_SEL_7:
            default:
               // selection value is not used so stays to 0
               break;
         }
         CAL_INF("Block[%d] sel_value = %d", blockIndex, pA->calib_block[blockIndex].sel_value);

         pA->calib_block[blockIndex].POSIXTime = calibrationInfo.blocks[blockIndex].POSIXTime;

         if ((lutRQIndex < LUTRQI_MAX_NUM_OF_LUTRQ) &&
             (calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].isValid))
         {
            pA->calib_block[blockIndex].offset_fp32 = calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].Data_Off;
            pA->calib_block[blockIndex].data_exponent = (int32_t)calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].Data_Exp;
         }
         // else, info stays to 0

         deltabeta_t* data = ACT_getSuitableDeltaBetaForBlock(&calibrationInfo, blockIndex);
         if (data)
            pA->calib_block[blockIndex].actualizationPOSIXTime = data->dbEntry->info.POSIXTime;
         else
            pA->calib_block[blockIndex].actualizationPOSIXTime = 0;

         pA->calib_block[blockIndex].low_cut = calibrationInfo.blocks[blockIndex].LowCut;
         pA->calib_block[blockIndex].high_cut = calibrationInfo.blocks[blockIndex].HighCut;
      }
   }

   WriteStruct(pA);

   // write all block configurations
   for (blockIndex = 0; blockIndex < CALIB_MAX_NUM_OF_BLOCKS; blockIndex++)
   {
      AXI4L_write32(blockIndex, pA->ADD + AW_BLOCK_IDX_ADDR);
      WriteStruct(&pA->calib_block[blockIndex]);
   }
   AXI4L_write32(1, pA->ADD + AW_BLOCK_CFG_DONE);

   // on reconfigure les switches
   CAL_configSwitchesAndHoles(pA, calib_mode, pGCRegs);
   
   // on flush le pipe
   //CAL_flushPipe(pA, pGCRegs);

   return IRC_SUCCESS;
}


void CAL_UpdateCalibBlockSelMode(t_calib *pA, gcRegistersData_t *pGCRegs)
{
   uint32_t blockIndex;

   if (!calibrationInfo.isValid)
   {
      pA->calib_block_sel_mode = CBSM_USER_SEL_0;
      return;
   }

   switch (calibrationInfo.collection.CollectionType)
   {
      case CCT_MultipointFixed:
      case CCT_TelopsFixed:
         if (blockLoadCmdFlag)
         {
            // Take block selector as selected mode
            pA->calib_block_sel_mode = pGCRegs->CalibrationCollectionBlockSelector + CBSM_USER_SEL_0;
         }
         else
         {
            pA->calib_block_sel_mode = CBSM_USER_SEL_0;
         }
         break;

      case CCT_MultipointFW:
      case CCT_TelopsFW:
         if (pGCRegs->FWMode != FWM_Fixed)
         {
            pA->calib_block_sel_mode = CBSM_FW_POSITION;
         }
         else if (blockLoadCmdFlag)
         {
            // Take block selector as selected mode
            pA->calib_block_sel_mode = pGCRegs->CalibrationCollectionBlockSelector + CBSM_USER_SEL_0;
         }
         else
         {
            pA->calib_block_sel_mode = CBSM_USER_SEL_0;
            // Find block corresponding to FW Position Setpoint
            for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
            {
               if (pGCRegs->FWPositionSetpoint == calibrationInfo.blocks[blockIndex].FWPosition)
               {
                  pA->calib_block_sel_mode = blockIndex + CBSM_USER_SEL_0;
                  break;
               }
            }
         }
         break;

      case CCT_MultipointNDF:
      case CCT_TelopsNDF:
         if (blockLoadCmdFlag)
         {
            // Take block selector as selected mode
            pA->calib_block_sel_mode = pGCRegs->CalibrationCollectionBlockSelector + CBSM_USER_SEL_0;
         }
         else
         {
            pA->calib_block_sel_mode = CBSM_USER_SEL_0;
            // Find block corresponding to NDF Position Setpoint
            for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
            {
               if (pGCRegs->NDFilterPositionSetpoint == calibrationInfo.blocks[blockIndex].NDFPosition)
               {
                  pA->calib_block_sel_mode = blockIndex + CBSM_USER_SEL_0;
                  break;
               }
            }
         }
         break;

      case CCT_MultipointFOV:
      case CCT_TelopsFOV:
         if (blockLoadCmdFlag)
         {
            // Take block selector as selected mode
            pA->calib_block_sel_mode = pGCRegs->CalibrationCollectionBlockSelector + CBSM_USER_SEL_0;
         }
         else
         {
            pA->calib_block_sel_mode = CBSM_USER_SEL_0;
            // Find block corresponding to FOV Position
            for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
            {
               if (pGCRegs->FOVPosition == calibrationInfo.blocks[blockIndex].FOVPosition)
               {
                  pA->calib_block_sel_mode = blockIndex + CBSM_USER_SEL_0;
                  break;
               }
            }
         }
         break;

      case CCT_MultipointEHDRI:
         pA->calib_block_sel_mode = CBSM_EXPOSURE_TIME;
         break;
   }

   // Reset command of block load
   blockLoadCmdFlag = false;
   
   // Apply changes related to selected mode
   CAL_ApplyCalibBlockSelMode(pA, pGCRegs);
}


void CAL_ApplyCalibBlockSelMode(const t_calib *pA, gcRegistersData_t *pGCRegs)
{
   extern t_HderInserter gHderInserter;
   extern flashDynamicValues_t gFlashDynamicValues;
   uint32_t blockIndex;
   
   if (!calibrationInfo.isValid)
      return;
   
   // Update other parameters only if µBlaze is master
   if ((pA->calib_block_sel_mode >= CBSM_USER_SEL_0) && (pA->calib_block_sel_mode <= CBSM_USER_SEL_7))
   {
      blockIndex = pA->calib_block_sel_mode - CBSM_USER_SEL_0;

      // Update active block POSIX time
      pGCRegs->CalibrationCollectionActiveBlockPOSIXTime = calibrationInfo.blocks[blockIndex].POSIXTime;

      // Update FW position if necessary
      if (flashSettings.FWPresent &&
            (GC_CalibrationIsActive || GC_CalibrationCollectionTypeFWIsActive))
         GC_UpdateFWPositionSetpoint(pGCRegs->FWPositionSetpoint, (uint32_t)calibrationInfo.blocks[blockIndex].FWPosition);

      // Update NDF position if necessary
      if (flashSettings.NDFPresent &&
            (GC_CalibrationIsActive || GC_CalibrationCollectionTypeNDFIsActive) &&
            (pGCRegs->NDFilterPositionSetpoint != (uint32_t)calibrationInfo.blocks[blockIndex].NDFPosition))
         GC_UpdateNDFPositionSetpoint(pGCRegs->NDFilterPositionSetpoint, (uint32_t)calibrationInfo.blocks[blockIndex].NDFPosition);

      // Update FOV position if necessary
      if (TDCFlagsTst(MotorizedFOVLensIsImplementedMask) &&
            (GC_CalibrationIsActive || GC_CalibrationCollectionTypeFOVIsActive) &&
            (pGCRegs->FOVPosition != (uint32_t)calibrationInfo.blocks[blockIndex].FOVPosition))
         GC_SetFOVPositionSetpoint((uint32_t)calibrationInfo.blocks[blockIndex].FOVPosition);

      // Update optical serial numbers with block values
      if (pGCRegs->LoadSavedConfigurationAtStartup == 0)
      {
         pGCRegs->ExternalLensSerialNumber = calibrationInfo.blocks[blockIndex].ExternalLensSerialNumber;
         pGCRegs->ManualFilterSerialNumber = calibrationInfo.blocks[blockIndex].ManualFilterSerialNumber;
      }
      HDER_UpdateOpticalSerialNumbersHeader(&gHderInserter, pGCRegs);

      // Update exposure time if necessary
      if (calibrationInfo.collection.CalibrationType == CALT_MULTIPOINT)
         GC_SetExposureTime((float)calibrationInfo.blocks[blockIndex].ExposureTime * CALIBBLOCK_EXP_TIME_TO_US);

      // Save calibration block POSIX time
      if (gFlashDynamicValues.CalibrationCollectionBlockPOSIXTimeAtStartup != calibrationInfo.blocks[blockIndex].POSIXTime)
      {
         gFlashDynamicValues.CalibrationCollectionBlockPOSIXTimeAtStartup = calibrationInfo.blocks[blockIndex].POSIXTime;
         if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
         {
            CAL_ERR("Failed to update flash dynamic values.");
         }
      }

      // Live update is supported only for a specific block.
      // For other selection modes, it will be updated on next acq arm (in CAL_SendConfigGC).
      AXI4L_write32((uint32_t)pA->calib_block_sel_mode, pA->ADD + AW_BLOCK_SEL_MODE);
      CAL_INF("calib_block_sel_mode = %d", (uint32_t)pA->calib_block_sel_mode);
   }
   else
   {
      // Update active block POSIX time
      pGCRegs->CalibrationCollectionActiveBlockPOSIXTime = 0;

      // Update optical serial numbers with collection values
      pGCRegs->ExternalLensSerialNumber = calibrationInfo.collection.ExternalLensSerialNumber;
      pGCRegs->ManualFilterSerialNumber = calibrationInfo.collection.ManualFilterSerialNumber;
      // Will be updated on next acq arm (in HDER_SendHeaderGC).
   }
}


IRC_Status_t CAL_WriteBlockParam(const t_calib *pA, const gcRegistersData_t *pGCRegs)
{
   calibBlockInfo_t *p_blockInfo = NULL;
   enum lutRQIndexEnum lutRQIndex;
   uint32_t blockIndex;

   if (!calibrationInfo.isValid)
      return IRC_FAILURE;

   switch (pGCRegs->CalibrationMode)
   {
      case CM_IBI:
         lutRQIndex = LUTRQI_IBI;
         break;

      case CM_IBR:
         lutRQIndex = LUTRQI_IBR;
         break;

      case CM_RT:
         lutRQIndex = LUTRQI_RT;
         break;

      case CM_NUC:
      case CM_Raw:
      case CM_Raw0:
      default:
         lutRQIndex = LUTRQI_MAX_NUM_OF_LUTRQ;
   }

   for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
   {
      // Point to the right calibration block
      p_blockInfo = &calibrationInfo.blocks[blockIndex];

      // Assign address corresponding to the right calibration block
      blockRam.ADD = XPAR_CALIB_RAM_AXI_BASEADDR + (blockIndex * pA->calib_ram_block_offset * sizeof(uint32_t));

      blockRam.saturation_threshold    = (uint32_t)p_blockInfo->SaturationThreshold;
      LUT_BuildConfig(&blockRam.nlc_lut_param,
            p_blockInfo->lutNLData.LUT_Xmin,
            p_blockInfo->lutNLData.LUT_Xrange,
            p_blockInfo->lutNLData.LUT_Size);
      blockRam.range_offset_fp32       = p_blockInfo->pixelData.Range_Off;
      blockRam.pow2_offset_exp_fp32    = exp2f((float)p_blockInfo->pixelData.Offset_Exp);
      blockRam.pow2_range_exp_fp32     = exp2f((float)p_blockInfo->pixelData.Range_Exp);
      blockRam.nlc_pow2_m_exp_fp32     = exp2f((float)p_blockInfo->lutNLData.M_Exp);
      blockRam.nlc_pow2_b_exp_fp32     = exp2f((float)p_blockInfo->lutNLData.B_Exp);
      blockRam.delta_temp_fp32         = 0.0F;  // written in CAL_UpdateDeltaF
      blockRam.alpha_offset_fp32       = p_blockInfo->pixelData.Alpha_Off;
      blockRam.pow2_alpha_exp_fp32     = exp2f((float)p_blockInfo->pixelData.Alpha_Exp);
      blockRam.pow2_beta0_exp_fp32     = exp2f((float)p_blockInfo->pixelData.Beta0_Exp);
      blockRam.pow2_kappa_exp_fp32     = exp2f((float)p_blockInfo->pixelData.Kappa_Exp);
      blockRam.nuc_mult_factor_fp32    = p_blockInfo->NUCMultFactor;

      if ((lutRQIndex < LUTRQI_MAX_NUM_OF_LUTRQ) && (p_blockInfo->lutRQData[lutRQIndex].isValid))
      {
         LUT_BuildConfig(&blockRam.rqc_lut_param,
               p_blockInfo->lutRQData[lutRQIndex].LUT_Xmin,
               p_blockInfo->lutRQData[lutRQIndex].LUT_Xrange,
               p_blockInfo->lutRQData[lutRQIndex].LUT_Size);
         blockRam.rqc_pow2_m_exp_fp32     = exp2f((float)p_blockInfo->lutRQData[lutRQIndex].M_Exp);
         blockRam.rqc_pow2_b_exp_fp32     = exp2f((float)p_blockInfo->lutRQData[lutRQIndex].B_Exp);
         blockRam.offset_fp32             = p_blockInfo->lutRQData[lutRQIndex].Data_Off;
         blockRam.pow2_lsb_fp32           = exp2f((float)p_blockInfo->lutRQData[lutRQIndex].Data_Exp);
      }
      else
      {
         LUT_BuildConfig(&blockRam.rqc_lut_param, 0.0F, 1.0F, 1.0F);
         blockRam.rqc_pow2_m_exp_fp32     = 0.0F;
         blockRam.rqc_pow2_b_exp_fp32     = 0.0F;
         blockRam.offset_fp32             = 0.0F;
         blockRam.pow2_lsb_fp32           = 1.0F;
      }

      CAL_DBG("CAL_WriteBlockParam of block[%d]", blockIndex);
      CAL_DBG("pow2_kappa_exp_fp32 x 1000000 = %d", (uint32_t)(blockRam.pow2_kappa_exp_fp32 * 1000000.0F));
      CAL_DBG("offset_fp32 x 1000 = %d", (int32_t)(blockRam.offset_fp32 * 1000.0F));
      CAL_DBG("pow2_lsb_fp32 x 1000000 = %d", (int32_t)(blockRam.pow2_lsb_fp32 * 1000000.0F));
      CAL_DBG("rqc_pow2_m_exp_fp32 x 1000000 = %d", (int32_t)(blockRam.rqc_pow2_m_exp_fp32 * 1000000.0F));
      CAL_DBG("rqc_pow2_b_exp_fp32 x 1000000 = %d", (int32_t)(blockRam.rqc_pow2_b_exp_fp32 * 1000000.0F));


      WriteStruct(&blockRam);
   }

   // Make sure delta temp is valid
   CAL_UpdateDeltaF(pA, pGCRegs);

   return IRC_SUCCESS;
}

//------------------------------------------------- 
// FONCTION : CAL_Status 
//------------------------------------------------- 
void CAL_GetStatus(t_CalStatus *Stat, const t_calib *pA)
{ 
  Stat->done = AXI4L_read32(pA->ADD + AR_DONE); 
  Stat->error_set[0] = AXI4L_read32(pA->ADD + AR_ERR_REG0); 
  Stat->error_set[1] = AXI4L_read32(pA->ADD + AR_ERR_REG1); 
  Stat->error_set[2] = AXI4L_read32(pA->ADD + AR_ERR_REG2); 
  Stat->error_set[3] = AXI4L_read32(pA->ADD + AR_ERR_REG3);
  Stat->error_set[4] = AXI4L_read32(pA->ADD + AR_ERR_REG4);

  // reset des erreurs
   CAL_resetErr(pA);
} 

//--------------------------------------------------------- 
// FONCTION : CAL_flushPipe (durée du flush > 2 transactions)
//---------------------------------------------------------
static void CAL_flushPipe(const t_calib *pA, const gcRegistersData_t *pGCRegs)
{ 
   uint8_t ii;                                         
   for (ii = 0; ii < 3; ii++) 
   {
      AXI4L_write32(1, pA->ADD + AW_FLUSHPIPE); 	      // ecriture de 1 pour flusher le pipe (dure le temps de 3 transactions ) 
   }
   for (ii=0; ii<3; ii++)                  		         // delai pour donner du temps pour retour de reset des blocs resetés
   {
      AXI4L_write32(0, pA->ADD + AW_FLUSHPIPE); 	      // ecriture de 0 pour arreter le flush
   } 
}
  
//--------------------------------------------------------- 
// FONCTION : Reset Des erreurs latchées
//---------------------------------------------------------
static void CAL_resetErr(const t_calib *pA)
{ 
   uint8_t ii;                                         
   for (ii = 0; ii < 3; ii++) 
   {
      AXI4L_write32(1, pA->ADD + AW_RESET_ERR); 	      // ecriture de 1 pour flusher le pipe (dure le temps de 3 transactions ) 
   }
   for (ii=0; ii<3; ii++)                  		         // delai pour donner du temps pour retour de reset des blocs resetés
   {
      AXI4L_write32(0, pA->ADD + AW_RESET_ERR); 	      // ecriture de 0 pour arreter le flush
   } 
}  
  
//--------------------------------------------------------- 
// FONCTION : CAL_configSwitchesAndHoles
//---------------------------------------------------------
// permet de configurer les switches et les trous du module calibration.bde
static void CAL_configSwitchesAndHoles(const t_calib *pA, cal_mode_t calib_mode, const gcRegistersData_t *pGCRegs )
{ 
   
   // declarations
   uint8_t         inputSwitch;         // switch en entrée du module de calibration
   uint8_t         dataTypeSwitch;      // switch du type de données sortant du module calibration
   uint8_t         outputSwitch;        // switch à la sortie du module de calibration
   uint8_t         nlcFall;             // 
   uint8_t         rqcFall;             // 
   uint8_t         fccFall;             // 
   
   // trouver la configuration des switches
   switch (calib_mode)
   {
      case Mode_block :      // bloquer le module de calibration. au complet
      
         inputSwitch     = SW_BLOCKED;        // entrée désactivée
         dataTypeSwitch  = SW_BLOCKED;        // type de données non defini  
         outputSwitch    = SW_BLOCKED;        // sortie désactivée
         nlcFall         = FALL_ON;           // tous les holes fall
         rqcFall         = FALL_ON;           // tous les holes fall 
         fccFall         = FALL_ON;           // tous les holes fall 
         break;
           
      case Mode_NonLinRaw :  // mode raw non lineaire (sans correction de NL)
      
         inputSwitch     = SW_TO_PATH0;       //           
         dataTypeSwitch  = SW_BLOCKED;        //  
         outputSwitch    = SW_TO_PATH0;       //          
         nlcFall         = FALL_ON;           //
         rqcFall         = FALL_ON;           //
         fccFall         = FALL_ON;           //       
         break;
      
      case Mode_LinRaw :     // mode raw lineaire
   
         inputSwitch     = SW_TO_PATH1;       //           
         dataTypeSwitch  = SW_TO_PATH1;       //  
         outputSwitch    = SW_TO_PATH1;       //          
         nlcFall         = FALL_OFF;           //
         rqcFall         = FALL_ON;           //
         fccFall         = FALL_ON;           //  
         break;
        
      case Mode_NucOnly :    // mode NUC uniquement
      
         inputSwitch     = SW_TO_PATH1;       //           
         dataTypeSwitch  = SW_TO_PATH2;       //  
         outputSwitch    = SW_TO_PATH1;       //          
         nlcFall         = FALL_ON;           //
         rqcFall         = FALL_ON;           //
         fccFall         = FALL_OFF;          //  
         break;
        
      case Mode_FullCalib : // mode Calibratyion complète
         
         inputSwitch     = SW_TO_PATH1;       //           
         dataTypeSwitch  = SW_TO_PATH0;       //  
         outputSwitch    = SW_TO_PATH1;       //          
         nlcFall         = FALL_ON;           //
         rqcFall         = FALL_OFF;          //
         fccFall         = FALL_ON;           //            
         break;
                    
      default :               // par defaut: bloquer tout
         
         inputSwitch     = SW_BLOCKED;        // 
         dataTypeSwitch  = SW_BLOCKED;        //  
         outputSwitch    = SW_BLOCKED;        // 
         nlcFall         = FALL_ON;           //
         rqcFall         = FALL_ON;           // 
         fccFall         = FALL_ON;           // 
         break;           
   }
   
   // envoyer la configuration des switches
   AXI4L_write32(inputSwitch, pA->ADD + AW_INPUT_SW);     
   AXI4L_write32(dataTypeSwitch, pA->ADD + AW_DATATYPE_SW);
   AXI4L_write32(outputSwitch, pA->ADD + AW_OUTPUT_SW);     
   AXI4L_write32(nlcFall, pA->ADD + AW_NLC_FALL); 
   AXI4L_write32(rqcFall, pA->ADD + AW_RQC_FALL);
   AXI4L_write32(fccFall, pA->ADD + AW_FCC_FALL);

}

void CAL_UpdateVideo(const t_calib *pA, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write32(pGCRegs->VideoBadPixelReplacement, pA->ADD + AW_VIDEO_BPR_MODE);
}

void CAL_UpdateCalibBprMode(const t_calib *pA, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write32(pGCRegs->BadPixelReplacement, pA->ADD + AW_CALIB_BPR_MODE);
}

/*
 * Configure LUT switch for NLC calibration
 * LUT_SWITCH_TO_AXI_LITE = switch configure to read BRAM from axi-lite (register write to 1)
 * LUT_SWITCH_TO_FPGA = switch configure to read BRAM from FPGA (register write to 0)
 */
void CAL_ConfigureNlcLutSwitch(const t_calib *pA, calibLutSwitchMode_t switchMode)
{
   u32 value = AXI4L_read32(pA->ADD + AW_CALIB_LUT_SWITCH);

   if(switchMode == LUT_SWITCH_TO_AXI_LITE)
   {
      // axi-lite switch mode
      // set bit
      value |= CALIB_NLC_LUT_SWITCH_MASK;
   }else
   {
      // fpga switch mode
      // clear bit
      value &= ~CALIB_NLC_LUT_SWITCH_MASK;
   }

   // write register
   AXI4L_write32(value, pA->ADD + AW_CALIB_LUT_SWITCH);
}

/*
 * Configure LUT switch for RQC calibration
 * LUT_SWITCH_TO_AXI_LITE = switch configure to read BRAM from axi-lite (register write to 1)
 * LUT_SWITCH_TO_FPGA = switch configure to read BRAM from FPGA (register write to 0)
 */
void CAL_ConfigureRqcLutSwitch(const t_calib *pA, calibLutSwitchMode_t switchMode)
{
   u32 value = AXI4L_read32(pA->ADD + AW_CALIB_LUT_SWITCH);

   if(switchMode == LUT_SWITCH_TO_AXI_LITE)
   {
      // axi-lite switch mode
      // set bit
      value |= CALIB_RQC_LUT_SWITCH_MASK;
   }else
   {
      // fpga switch mode
      // clear bit
      value &= ~CALIB_RQC_LUT_SWITCH_MASK;
   }

   // write register
   AXI4L_write32(value, pA->ADD + AW_CALIB_LUT_SWITCH);
}
