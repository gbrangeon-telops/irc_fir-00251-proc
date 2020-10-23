/**
 * @file FlashSettings.c
 * Camera flash settings structure definition.
 *
 * This file defines camera flash settings structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include <string.h>
#include <float.h>
#include "FlashSettings.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "FileManager.h"
#include "GC_Registers.h"
#include "GenICam.h"
#include "CRC.h"
#include "ICU.h"
#include "BufferManager.h"
#include "Calibration.h"
#include "FPA_intf.h"
#include "BuiltInTests.h"
#include "utils.h"
#include "FWController.h"
#include "DeviceKey.h"
#include "FlashDynamicValues.h"
#include "adc_readout.h"
#include "RpOpticalProtocol.h"
#include "XADC_Channels.h"
#include "IRIGB.h"


/*
 * Defines to block advanced features.
 *    Advanced features can be disabled/enabled by Flash Settings.
 *    if the FEATURE_DISABLED are defined, then the Flash Settings are ignored
 *    and the features are always disabled.
 *    Each feature can be disabled individually.
 */
//#define EHDRI_DISABLED
//#define BUFFERING_DISABLED
//#define ADV_TRIG_DISABLED
//#define FLAGGING_DISABLED
//#define GATING_DISABLED
//#define ADC_READOUT_DISABLED
//#define IRIGB_DISABLED
//#define GPS_DISABLED
//#define SFW_DISABLED
//#define SDI_DISABLED


/**
 * Indicates whether flash settings have to be loaded immediately
 */
fslImmediate_t fsLoadImmediately;

/**
 * Flash settings file descriptor to load
 */
int fdFlashSettings;

/**
 * Flash settings values
 */
flashSettings_t flashSettings;

static IRC_Status_t FlashSettings_UpdateCameraSettings(flashSettings_t *p_flashSettings);

/**
 * Initializes the flash settings loader.
 */
IRC_Status_t FlashSettings_Init()
{
   fdFlashSettings = -1;
   fsLoadImmediately = FSLI_DEFERRED_LOADING;

   return IRC_SUCCESS;
}

/**
 * Start flash settings file loading.
 *
 * @param file is a pointer to the the flash settings file record to load.
 * @param immediate indicates whether the flash setting data is immediately loaded.
 *
 * @return IRC_SUCCESS if successfully started to load flash settings file.
 * @return IRC_FAILURE if failed to start to loading flash settings file.
 */
IRC_Status_t FlashSettings_Load(fileRecord_t *file, fslImmediate_t immediate)
{
   if (fdFlashSettings != -1)
   {
      FS_ERR("There is already a flash setting file loading.");
      return IRC_FAILURE;
   }

   fdFlashSettings = FM_OpenFile(file->name, UO_RDONLY);
   if (fdFlashSettings == -1)
   {
      FS_ERR("Failed to open %s.", file->name);
      return IRC_FAILURE;
   }

   FS_INF("Loading flash settings file %s (v%d.%d.%d)...", file->name,
         file->version.major, file->version.minor, file->version.subMinor);
   fsLoadImmediately = immediate;

   if (immediate == FSLI_LOAD_IMMEDIATELY)
   {
      // Execute state machine
      FlashSettings_SM();
   }

   return IRC_SUCCESS;
}


/**
 * Flash setting loader state machine.
 */
void FlashSettings_SM()
{
   static fsState_t fsCurrentState = FSS_INIT;
   static flashSettings_t tmpFlashSettings;
   static uint64_t tic_flashSettings;
   IRC_Status_t status;

   switch (fsCurrentState)
   {
       case FSS_INIT:
          if (fdFlashSettings != -1)
          {
             TDCStatusSet(WaitingForFlashSettingsInitMask);

             memset(&tmpFlashSettings, 0, sizeof(tmpFlashSettings));

             GETTIME(&tic_flashSettings);

             builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Pending;

             fsCurrentState = FSS_LOADING;
          }
          else
          {
             break;
          }

       case FSS_LOADING:
          do
          {
             status = FlashSettings_ParseFlashSettingsFileHeader(fdFlashSettings, &tmpFlashSettings, NULL);
          }
          while ((fsLoadImmediately == FSLI_LOAD_IMMEDIATELY) && (status == IRC_NOT_DONE));

          if (status != IRC_NOT_DONE)
          {
             if (status == IRC_FAILURE)
             {
                FS_ERR("Failed to read flash settings file.");
                FlashSettings_Reset(&flashSettings);
                builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Failed;
             }
             else
             {
                flashSettings = tmpFlashSettings;
                if (FlashSettings_UpdateCameraSettings(&flashSettings) == IRC_SUCCESS)
                {
                   TDCStatusClr(WaitingForFlashSettingsInitMask);
                   builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Passed;
                   FS_INF("Flash settings file has been successfully loaded (%dms).",
                         elapsed_time_us(tic_flashSettings) / 1000);
                }
                else
                {
                   FlashSettings_Reset(&flashSettings);
                   builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Failed;
                }
             }

             if (fdFlashSettings != -1)
             {
                if (uffs_close(fdFlashSettings) == -1)
                {
                   FS_ERR("Failed to close flash settings file.");
                }
                fdFlashSettings = -1;
             }

             fsCurrentState = FSS_INIT;
          }
          break;
   }
}

/**
 * Flash settings reset.
 *
 * @param p_flashSettings is the pointer to flash settings data structure to reset.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t FlashSettings_Reset(flashSettings_t *p_flashSettings)
{
   extern flashSettings_t flashSettings_default;

   *p_flashSettings = flashSettings_default;
   TDCStatusSet(WaitingForFlashSettingsInitMask);

   return FlashSettings_UpdateCameraSettings(p_flashSettings);
}

/**
 * Update camera using flash settings data.
 */
IRC_Status_t FlashSettings_UpdateCameraSettings(flashSettings_t *p_flashSettings)
{
   extern ICU_config_t gICU_ctrl;
   extern uint8_t gFpaScdDiodeBiasEnum;
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaExposureTimeOffset;
   extern t_FpaIntf gFpaIntf;
   extern uint16_t gFpaElCorrMeasAtStarvation;
   extern uint16_t gFpaElCorrMeasAtSaturation;
   extern uint16_t gFpaElCorrMeasAtReference1;
   extern uint16_t gFpaElCorrMeasAtReference2;
   extern bool gDisableFilterWheel;
   extern flashSettings_t flashSettings_default;
   extern t_bufferManager gBufManager;
   uint8_t externalMemoryBufferDetected;
   t_bufferStatus bufStat;
   uint8_t i;

   // Overwrite Flash Settings when blocking advanced features is hard coded
#ifdef EHDRI_DISABLED
   p_flashSettings->EHDRIDisabled = 1;
#endif
#ifdef BUFFERING_DISABLED
   p_flashSettings->BufferingDisabled = 1;
#endif
#ifdef ADV_TRIG_DISABLED
   p_flashSettings->AdvTrigDisabled = 1;
#endif
#ifdef FLAGGING_DISABLED
   p_flashSettings->FlaggingDisabled = 1;
#endif
#ifdef GATING_DISABLED
   p_flashSettings->GatingDisabled = 1;
#endif
#ifdef ADC_READOUT_DISABLED
   p_flashSettings->ADCReadoutDisabled = 1;
#endif
#ifdef IRIGB_DISABLED
   p_flashSettings->IRIGBDisabled = 1;
#endif
#ifdef GPS_DISABLED
   p_flashSettings->GPSDisabled = 1;
#endif
#ifdef SFW_DISABLED
   p_flashSettings->SFWDisabled = 1;
#endif
#ifdef SDI_DISABLED
   p_flashSettings->SDIDisabled = 1;
#endif

   BufferManager_GetStatus(&gBufManager, &bufStat);
   externalMemoryBufferDetected = bufStat.ext_buf_prsnt;

   // Update device serial number
   gcRegsData.DeviceSerialNumber = p_flashSettings->DeviceSerialNumber;
   if (p_flashSettings->DeviceSerialNumber <= 99999)
   {
      sprintf(gcRegsData.DeviceID, "TEL%05d", (int) p_flashSettings->DeviceSerialNumber);
   }

   // Update device model name
   memset(gcRegsData.DeviceModelName, 0 , gcRegsDef[DeviceModelNameIdx].dataLength + 1);
   strcpy(gcRegsData.DeviceModelName, p_flashSettings->DeviceModelName);

   // Update pixel data resolution
   gcRegsData.PixelDataResolution = p_flashSettings->PixelDataResolution;

   // Update sensor ID
   gcRegsData.SensorID = p_flashSettings->SensorID;

   // Update reverse X/Y
   if (calibrationInfo.isValid)
   {
      GC_SetReverseX(flashSettings.ReverseX ^ calibrationInfo.collection.ReverseX);
      GC_SetReverseY(flashSettings.ReverseY ^ calibrationInfo.collection.ReverseY);
   }
   else
   {
      GC_SetReverseX(flashSettings.ReverseX);
      GC_SetReverseY(flashSettings.ReverseY);
   }

   // Update ICU
   if (p_flashSettings->ICUPresent)
   {
      TDCFlagsSet(ICUIsImplementedMask);
      gcRegsData.ImageCorrectionMode = ICM_ICU;
   }
   else
   {
      TDCFlagsClr(ICUIsImplementedMask);
      gcRegsData.ImageCorrectionMode = ICM_BlackBody;
   }

   // Update FW
   p_flashSettings->FWPresent &= ~gDisableFilterWheel;
   gcRegsData.FWFilterNumber = p_flashSettings->FWNumberOfFilters;
   TDCFlagsClr(FWIsImplementedMask | FWSynchronouslyRotatingModeIsImplementedMask);
   if (p_flashSettings->FWPresent && (p_flashSettings->FWNumberOfFilters > 0))
   {
      // Validate default fixed filter wheel PID settings
      if (  (p_flashSettings->FWType == FW_FIX) &&
            (p_flashSettings->FWPositionControllerI == 3) &&
            (p_flashSettings->FWPositionControllerPD == 5) &&
            (p_flashSettings->FWPositionControllerPOR == 30) &&
            (p_flashSettings->FWPositionControllerPP == 5) )
      {
         // Had the wrong default fixed filter wheel PID settings, force to new default values
         p_flashSettings->FWPositionControllerI = flashSettings_default.FWPositionControllerI;
         p_flashSettings->FWPositionControllerPD = flashSettings_default.FWPositionControllerPD;
         p_flashSettings->FWPositionControllerPOR = flashSettings_default.FWPositionControllerPOR;
         p_flashSettings->FWPositionControllerPP = flashSettings_default.FWPositionControllerPP;
      }

      TDCFlagsSet(FWIsImplementedMask);
      if (p_flashSettings->FWType == FW_SYNC)
      {
         if (p_flashSettings->SFWDisabled)
            GC_SetFWMode(FWM_Fixed);   // stop SFW
         else
            TDCFlagsSet(FWSynchronouslyRotatingModeIsImplementedMask);
      }
   }
   else if (p_flashSettings->FWPresent && (p_flashSettings->FWNumberOfFilters == 0))
   {
      FS_ERR("FWNumberOfFilters must be greater than 0 when FWPresent is set.");
   }

   gcRegsData.FWSpeedMax = p_flashSettings->FWSpeedMax;

   // Update NDF
   gcRegsData.NDFilterNumber = p_flashSettings->NDFNumberOfFilters;
   TDCFlagsClr(NDFilterIsImplementedMask | AECPlusIsImplementedMask);
   if (p_flashSettings->NDFPresent && (p_flashSettings->NDFNumberOfFilters > 0))
   {
      TDCFlagsSet(NDFilterIsImplementedMask | AECPlusIsImplementedMask);
   }
   else if (p_flashSettings->NDFPresent && (p_flashSettings->NDFNumberOfFilters == 0))
   {
      FS_ERR("NDFNumberOfFilters must be greater than 0 when NDFPresent is set.");
   }

   // Update actualization
   TDCFlagsClr(ImageCorrectionIsImplementedMask | ExternalZeroMeanBetaCorrectionIsImplementedMask);
   if (p_flashSettings->ImageCorrectionEnabled)
   {
      TDCFlagsSet(ImageCorrectionIsImplementedMask);

      if (BitTst(p_flashSettings->ImageCorrectionDiscardOffset, 1))
      {
         TDCFlagsSet(ExternalZeroMeanBetaCorrectionIsImplementedMask);
      }
   }

   // Update detector parameters
   gFpaScdDiodeBiasEnum = p_flashSettings->FpaScdDiodeBiasEnum;
   gFpaDetectorPolarizationVoltage = p_flashSettings->DetectorPolarizationVoltage;
   gFpaDetectorElectricalTapsRef = p_flashSettings->DetectorElectricalTapsRef;
   gFpaDetectorElectricalRefOffset = p_flashSettings->DetectorElectricalRefOffset;
   gFpaExposureTimeOffset = p_flashSettings->ExposureTimeOffset;
   gFpaElCorrMeasAtStarvation = p_flashSettings->ElCorrMeasAtStarvation; 
   gFpaElCorrMeasAtSaturation = p_flashSettings->ElCorrMeasAtSaturation;
   gFpaElCorrMeasAtReference1 = p_flashSettings->ElCorrMeasAtReference1;
   gFpaElCorrMeasAtReference2 = p_flashSettings->ElCorrMeasAtReference2;   

   // Validate ExternalMemoryBufferPresent field
   if (XOR(p_flashSettings->ExternalMemoryBufferPresent, externalMemoryBufferDetected))
   {
      FS_ERR("ExternalMemoryBufferPresent field value (%d) doesn't match external memory buffer detection (%d).",
            p_flashSettings->ExternalMemoryBufferPresent, externalMemoryBufferDetected);
   }

   // Update external fan speed setpoint
   gcRegsData.ExternalFanSpeedSetpoint = p_flashSettings->ExternalFanSpeedSetpoint;

   // Validate device key
   if (builtInTests[BITID_FlashDynamicValuesInitialization].result == BITR_Passed)
   {
      BuiltInTest_Execute(BITID_DeviceKeyValidation);
   }

   // Update ADC readout
   ADC_readout_init();

   // Update IRIGB
   if (p_flashSettings->IRIGBDisabled)
      TDCFlagsClr(IRIGBIsImplementedMask);
   else
      TDCFlagsSet(IRIGBIsImplementedMask);
   IRIG_Initialize();

   // Update Thermistor model type
   xadcSetphyConverter(&extAdcChannels[XEC_INTERNAL_LENS] , p_flashSettings->InternalLensThType);
   xadcSetphyConverter(&extAdcChannels[XEC_EXTERNAL_LENS] , p_flashSettings->ExternalLensThType);
   xadcSetphyConverter(&extAdcChannels[XEC_ICU]           , p_flashSettings->ICUThType);
   xadcSetphyConverter(&extAdcChannels[XEC_SFW]           , p_flashSettings->SFWThType);
   xadcSetphyConverter(&extAdcChannels[XEC_COMPRESSOR]    , p_flashSettings->CompressorThType);
   xadcSetphyConverter(&extAdcChannels[XEC_COLD_FINGER]   , p_flashSettings->ColdfingerThType);
   xadcSetphyConverter(&extAdcChannels[XEC_SPARE]         , p_flashSettings->SpareThType);
   xadcSetphyConverter(&extAdcChannels[XEC_EXT_THERMISTOR], p_flashSettings->ExternalTempThType);

   // Update motorized FOV and focus
   gcRegsData.FOVPositionNumber = p_flashSettings->FOVNumberOfPositions;
   TDCFlagsClr(MotorizedFOVLensIsImplementedMask | MotorizedFocusLensIsImplementedMask);
   switch (p_flashSettings->MotorizedLensType)
   {
      case MLT_RPOpticalODEM660:
         if (p_flashSettings->FOVNumberOfPositions > 0)
            TDCFlagsSet(MotorizedFOVLensIsImplementedMask);
         else
            FS_ERR("FOVNumberOfPositions must be greater than 0 with MotorizedLensType RPOpticalODEM660.");
         TDCFlagsSet(MotorizedFocusLensIsImplementedMask);
         RPOpt_UpdateLensTableFromFlash();
         RPOpt_CalcFOVPositionLimits(&gcRegsData);
         break;

      case MLT_None:
      default:
         break;
   }

   // Update autofocus
   TDCFlagsClr(AutofocusIsImplementedMask);
   gcRegsData.AutofocusMode = AM_Off;
   if (TDCFlagsTst(MotorizedFocusLensIsImplementedMask))
   {
      switch (p_flashSettings->AutofocusModuleType)
      {
         case AMT_SightlineSLA1500:
            TDCFlagsSet(AutofocusIsImplementedMask);
            gcRegsData.AutofocusMode = AM_Once;

            if (TDCFlagsTst(NDFilterIsImplementedMask))
               FS_ERR("NDF cannot be implemented with AutofocusModuleType SightlineSLA1500.");
            break;

         case AMT_None:
         default:
            break;
      }
   }

   // Update EHDRI
   if (p_flashSettings->EHDRIDisabled)
   {
      TDCFlagsClr(EHDRIIsImplementedMask);
      GC_SetEHDRINumberOfExposures(1);    // disable EHDRI
   }
   else
      TDCFlagsSet(EHDRIIsImplementedMask);

   // Update Memory Buffer
   if (p_flashSettings->BufferingDisabled)
   {
      TDCFlagsClr(MemoryBufferIsImplementedMask);
      if (!externalMemoryBufferDetected)
      {
         GC_SetMemoryBufferSequenceClearAll(1);
         GC_SetMemoryBufferSequenceDownloadMode(MBSDM_Off);
         GC_SetMemoryBufferMode(MBM_Off);    // disable Memory Buffer
      }
   }
   else
      TDCFlagsSet(MemoryBufferIsImplementedMask);

   // Update Advanced Trigger
   if (p_flashSettings->AdvTrigDisabled)
   {
      TDCFlagsClr(AdvancedTriggerIsImplementedMask);
      for (i = 0; i < TriggerDelayAryLen; i++)
         TriggerDelayAry[i] = 0.0F;    // reset all delays
      for (i = 0; i < TriggerFrameCountAryLen; i++)
         TriggerFrameCountAry[i] = 1;  // reset all frame counts
   }
   else
      TDCFlagsSet(AdvancedTriggerIsImplementedMask);

   // Update Flagging
   if (p_flashSettings->FlaggingDisabled)
   {
      TDCFlagsClr(FlaggingIsImplementedMask);
      TriggerModeAry[TS_Flagging] = TM_Off;    // disable Flagging
   }
   else
      TDCFlagsSet(FlaggingIsImplementedMask);

   // Update Gating
   if (p_flashSettings->GatingDisabled)
   {
      TDCFlagsClr(GatingIsImplementedMask);
      TriggerModeAry[TS_Gating] = TM_Off;    // disable Gating
   }
   else
      TDCFlagsSet(GatingIsImplementedMask);

   // Update GPS
   if (p_flashSettings->GPSDisabled)
      TDCFlags2Clr(GPSIsImplementedMask);
   else
      TDCFlags2Set(GPSIsImplementedMask);

   // Update Video Output
   if (p_flashSettings->SDIDisabled)
   {
      GC_SetVideoFreeze(1);
      TDCFlags2Clr(VideoOutputIsImplementedMask);
   }
   else
   {
      GC_SetVideoFreeze(0);
      TDCFlags2Set(VideoOutputIsImplementedMask);
   }

   // Update ExposureTimeMin register
   GC_UpdateExposureTimeMin();

   // Update Camera Link configuration registers
   GC_UpdateCameraLinkConfig();

   // Update Save Configuration
   if (p_flashSettings->SaveConfigurationEnabled)
   {
      TDCFlagsSet(SaveConfigurationIsImplementedMask);
   }
   else
   {
      TDCFlagsClr(SaveConfigurationIsImplementedMask);
      if (gcRegsData.LoadSavedConfigurationAtStartup)
         GC_SetLoadSavedConfigurationAtStartup(0);    // Disable feature for next start up
   }

   // Update camera state if initialization is done
   if (!TDCStatusTst(WaitingForInitMask))
   {
      ICU_init(&gcRegsData, &gICU_ctrl);
      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
      GC_UpdateExternalFanSpeed();
   }

   // Share new TDCFlags and TDCFlags2 values
   GC_SetTDCFlags(gcRegsData.TDCFlags);
   GC_SetTDCFlags2(gcRegsData.TDCFlags2);

   return IRC_SUCCESS;
}
