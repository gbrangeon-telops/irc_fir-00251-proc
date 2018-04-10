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
#include <string.h>
#include <float.h>

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
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern t_FpaIntf gFpaIntf;
   extern bool gDisableFilterWheel;
   extern flashSettings_t flashSettings_default;
   uint8_t externalMemoryBufferDetected = BufferManager_DetectExternalMemoryBuffer();

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
      GC_RegisterWriteUI32(&gcRegsDef[ReverseXIdx], flashSettings.ReverseX ^ calibrationInfo.collection.ReverseX);
      GC_RegisterWriteUI32(&gcRegsDef[ReverseYIdx], flashSettings.ReverseY ^ calibrationInfo.collection.ReverseY);
   }
   else
   {
      GC_RegisterWriteUI32(&gcRegsDef[ReverseXIdx], flashSettings.ReverseX);
      GC_RegisterWriteUI32(&gcRegsDef[ReverseYIdx], flashSettings.ReverseY);
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
      if(p_flashSettings->FWType == FW_SYNC)
      {
         TDCFlagsSet(FWSynchronouslyRotatingModeIsImplementedMask);
      }
      else
      {
         TDCFlagsClr(FWSynchronouslyRotatingModeIsImplementedMask);
      }
   }
   else
   {
      TDCFlagsClr(FWIsImplementedMask);

      if (p_flashSettings->FWPresent && (p_flashSettings->FWNumberOfFilters == 0))
      {
         FS_ERR("FWNumberOfFilters must be greater than 0 when FWPresent is set.");
      }
   }

   gcRegsData.FWSpeedMax = p_flashSettings->FWSpeedMax;

   // Update NDF
   gcRegsData.NDFilterNumber = p_flashSettings->NDFNumberOfFilters;
   if (p_flashSettings->NDFPresent && (p_flashSettings->NDFNumberOfFilters > 0))
   {
      TDCFlagsSet(NDFilterIsImplementedMask);
      TDCFlagsSet(AECPlusIsImplementedMask);
   }
   else
   {
      TDCFlagsClr(NDFilterIsImplementedMask);
      TDCFlagsClr(AECPlusIsImplementedMask);

      if (p_flashSettings->NDFPresent && (p_flashSettings->NDFNumberOfFilters == 0))
      {
         FS_ERR("NDFNumberOfFilters must be greater than 0 when NDFPresent is set.");
      }
   }

   // Update actualization
   TDCFlagsClr(ImageCorrectionIsImplementedMask);
   TDCFlagsClr(ExternalZeroMeanBetaCorrectionIsImplementedMask);
   if (p_flashSettings->ImageCorrectionEnabled)
   {
      TDCFlagsSet(ImageCorrectionIsImplementedMask);

      if (BitTst(p_flashSettings->ImageCorrectionDiscardOffset, 1))
      {
         TDCFlagsSet(ExternalZeroMeanBetaCorrectionIsImplementedMask);
      }
   }

   // Update detector parameters
   gFpaDetectorPolarizationVoltage = p_flashSettings->DetectorPolarizationVoltage;
   gFpaDetectorElectricalTapsRef = p_flashSettings->DetectorElectricalTapsRef;
   gFpaDetectorElectricalRefOffset = p_flashSettings->DetectorElectricalRefOffset;

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

   // Update ADC readout calibration
   TDCFlagsClr(ADCReadoutIsImplementedMask);
   if (p_flashSettings->ADCReadoutEnabled)
   {
      TDCFlagsSet(ADCReadoutIsImplementedMask);
   }
   ADC_readout_init(p_flashSettings);

   // Update Thermistor model type
   xadcSetphyConverter(&extAdcChannels[XEC_INTERNAL_LENS] , p_flashSettings->InternalLensThType);
   xadcSetphyConverter(&extAdcChannels[XEC_EXTERNAL_LENS] , p_flashSettings->ExternalLensThType);
   xadcSetphyConverter(&extAdcChannels[XEC_ICU]           , p_flashSettings->ICUThType);
   xadcSetphyConverter(&extAdcChannels[XEC_SFW]           , p_flashSettings->SFWThType);
   xadcSetphyConverter(&extAdcChannels[XEC_COMPRESSOR]    , p_flashSettings->CompressorThType);
   xadcSetphyConverter(&extAdcChannels[XEC_COLD_FINGER]   , p_flashSettings->ColdfingerThType);
   xadcSetphyConverter(&extAdcChannels[XEC_SPARE]         , p_flashSettings->SpareThType);
   xadcSetphyConverter(&extAdcChannels[XEC_EXT_THERMISTOR] ,p_flashSettings->ExternalTempThType);

   // Update motorized FOV and focus
   gcRegsData.FOVPositionNumber = p_flashSettings->FOVNumberOfPositions;
   TDCFlagsClr(MotorizedFOVLensIsImplementedMask);
   TDCFlagsClr(MotorizedFocusLensIsImplementedMask);
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

   // Update camera state if initialization is done
   if (!TDCStatusTst(WaitingForInitMask))
   {
      ICU_init(&gcRegsData, &gICU_ctrl);
      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
      GC_SetExternalFanSpeed();
   }

   return IRC_SUCCESS;
}
