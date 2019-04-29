/**
 * @file FlashSettingsFile.c
 * Camera flash settings file structure definition.
 *
 * This file defines camera flash settings values structure.
 * 
 * $Rev: 23158 $
 * $Author: elarouche $
 * $Date: 2019-04-02 16:09:55 -0400 (mar., 02 avr. 2019) $
 * $Id: FlashSettingsFile.c 23158 2019-04-02 20:09:55Z elarouche $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/FlashSettingsFile.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "FlashSettingsFile.h"
#include "FileManager.h"
#include <string.h>


/**
 * Flash settings file header parser.
 *
 * @param fd is the flash settings file descriptor.
 * @param hdr is the pointer to the flash settings file header structure to fill.
 * @param fileInfo is a pointer to the file info data structure to fill (optional).
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
IRC_Status_t FlashSettings_ParseFlashSettingsFileHeader(int fd, FlashSettings_FlashSettingsFileHeader_t *hdr, fileInfo_t *fileInfo)
{
   extern FlashSettings_FlashSettingsFileHeader_t FlashSettings_FlashSettingsFileHeader_default;

   static fileInfo_t fi;
   static FlashSettings_FlashSettingsFile_v1_t hdr_v1;
   static uint32_t idxChunk = 0;
   static uint16_t crc16;

   uint32_t chunkSize;
   uint32_t chunkCount;
   uint8_t error;
   uint32_t minorVersion;

   if ((fd == -1) || (hdr == NULL))
   {
      return IRC_FAILURE;
   }

   if (idxChunk == 0)
   {
      if ((FI_ParseFileInfo(fd, &fi) != IRC_SUCCESS) || (fi.type != FT_TSFS))
      {
         return IRC_FAILURE;
      }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   error = 0;
   switch (fi.version.major)
   {
      case 1:
         chunkSize = MIN(FLASHSETTINGS_FLASHSETTINGSFILE_CHUNKSIZE_V1,
               (FLASHSETTINGS_FLASHSETTINGSFILE_SIZE_V1 - (idxChunk * FLASHSETTINGS_FLASHSETTINGSFILE_CHUNKSIZE_V1)));
         chunkCount = FLASHSETTINGS_FLASHSETTINGSFILE_CHUNKCOUNT_V1;
         if (FM_ReadFileToTmpFileDataBuffer(fd, chunkSize) == chunkSize)
         {
            if (FlashSettings_ParseFlashSettingsFile_v1(tmpFileDataBuffer, chunkSize, idxChunk, &hdr_v1, &crc16) == chunkSize)
            {
               break;
            }
         }
         error = 1;
         break;

      case 2:
         chunkSize = MIN(FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2,
               (FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE_V2 - (idxChunk * FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)));
         chunkCount = FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKCOUNT_V2;
         if (FM_ReadFileToTmpFileDataBuffer(fd, chunkSize) == chunkSize)
         {
            if (FlashSettings_ParseFlashSettingsFileHeader_v2(tmpFileDataBuffer, chunkSize, idxChunk, hdr, &crc16) == chunkSize)
            {
               break;
            }
         }
         error = 1;
         break;

      default:
         error = 1;
         break;
   }

   if (error == 1)
   {
      idxChunk = 0;
      return IRC_FAILURE;
   }

   if (++idxChunk < chunkCount)
   {
      return IRC_NOT_DONE;
   }
   else
   {
      minorVersion = fi.version.minor;
      switch (fi.version.major)
      {
         case 1:
            // 1.x.x
            switch (minorVersion)
            {
               case 0:
                  // 1.0.x -> 1.1.x
                  hdr_v1.ActualizationAECImageFraction = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionAECImageFraction;
                  hdr_v1.ActualizationAECTargetWellFilling = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionAECTargetWellFilling;
                  hdr_v1.ActualizationAECResponseTime = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionAECResponseTime;
                  // ActualizationNumerOfImagesCoadd replaced by ActualizationNumberOfImagesCoadd in version 1.2.x
                  // ActualizationICUTemperatureTol has been removed in version 1.3.x
                  hdr_v1.ActualizationEnabled = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionEnabled;
                  hdr_v1.ActualizationAtPowerOn = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionAtPowerOn;
                  // PowerOnAtStartup has been removed in version 1.3.x
                  // AcquisitionStartAtStartup has been removed in version 1.3.x
                  hdr_v1.ReverseX = FlashSettings_FlashSettingsFileHeader_default.ReverseX;
                  hdr_v1.ReverseY = FlashSettings_FlashSettingsFileHeader_default.ReverseY;
                  hdr_v1.FileStructureMinorVersion = 1;

               case 1:
                  // 1.1.x -> 1.2.x
                  hdr_v1.ActualizationNumberOfImagesCoadd = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionNumberOfImagesCoadd;
                  hdr_v1.FWPresent = FlashSettings_FlashSettingsFileHeader_default.FWPresent;
                  hdr_v1.FWNumberOfFilters = FlashSettings_FlashSettingsFileHeader_default.FWNumberOfFilters;
                  hdr_v1.FW0CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW0CenterPosition;
                  hdr_v1.FW1CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW1CenterPosition;
                  hdr_v1.FW2CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW2CenterPosition;
                  hdr_v1.FW3CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW3CenterPosition;
                  hdr_v1.FW4CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW4CenterPosition;
                  hdr_v1.FW5CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW5CenterPosition;
                  hdr_v1.FW6CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW6CenterPosition;
                  hdr_v1.FW7CenterPosition = FlashSettings_FlashSettingsFileHeader_default.FW7CenterPosition;
                  hdr_v1.FileStructureMinorVersion = 2;

               case 2:
                  // 1.2.x -> 1.3.x
                  hdr_v1.ActualizationTemperatureSelector = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionTemperatureSelector;
                  hdr_v1.ActualizationWaitTime1 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionWaitTime1;
                  hdr_v1.ActualizationTemperatureTolerance1 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionTemperatureTolerance1;
                  hdr_v1.ActualizationStabilizationTime1 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionStabilizationTime1;
                  hdr_v1.ActualizationTimeout1 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionTimeout1;
                  hdr_v1.ActualizationWaitTime2 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionWaitTime2;
                  hdr_v1.ActualizationTemperatureTolerance2 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionTemperatureTolerance2;
                  hdr_v1.ActualizationStabilizationTime2 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionStabilizationTime2;
                  hdr_v1.ActualizationTimeout2 = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionTimeout2;
                  hdr_v1.DetectorPolarizationVoltage = FlashSettings_FlashSettingsFileHeader_default.DetectorPolarizationVoltage;
                  hdr_v1.FileStructureMinorVersion = 3;

               case 3:
                  // 1.3.x -> 1.4.x
                  hdr_v1.ExternalMemoryBufferPresent = FlashSettings_FlashSettingsFileHeader_default.ExternalMemoryBufferPresent;
                  hdr_v1.FileStructureMinorVersion = 4;

               case 4:
                  // 1.4.x -> 1.5.x
                  hdr_v1.NDFPresent = FlashSettings_FlashSettingsFileHeader_default.NDFPresent;
                  hdr_v1.NDFNumberOfFilters = FlashSettings_FlashSettingsFileHeader_default.NDFNumberOfFilters;
                  hdr_v1.NDFClearFOVWidth = FlashSettings_FlashSettingsFileHeader_default.NDFClearFOVWidth;
                  hdr_v1.NDF0CenterPosition = FlashSettings_FlashSettingsFileHeader_default.NDF0CenterPosition;
                  hdr_v1.NDF1CenterPosition = FlashSettings_FlashSettingsFileHeader_default.NDF1CenterPosition;
                  hdr_v1.NDF2CenterPosition = FlashSettings_FlashSettingsFileHeader_default.NDF2CenterPosition;
                  hdr_v1.FileStructureMinorVersion = 5;

               case 5:
                  // 1.5.x -> 1.6.x
                  hdr_v1.FWType = FlashSettings_FlashSettingsFileHeader_default.FWType;
                  hdr_v1.FWSpeedMax = FlashSettings_FlashSettingsFileHeader_default.FWSpeedMax;
                  hdr_v1.FWEncoderCyclePerTurn = FlashSettings_FlashSettingsFileHeader_default.FWEncoderCyclePerTurn;
                  hdr_v1.FWOpticalAxisPosX = FlashSettings_FlashSettingsFileHeader_default.FWOpticalAxisPosX;
                  hdr_v1.FWOpticalAxisPosY = FlashSettings_FlashSettingsFileHeader_default.FWOpticalAxisPosY;
                  hdr_v1.FWMountingHoleRadius = FlashSettings_FlashSettingsFileHeader_default.FWMountingHoleRadius;
                  hdr_v1.FWBeamMarging = FlashSettings_FlashSettingsFileHeader_default.FWBeamMarging;
                  hdr_v1.FWCornerPixDistX = FlashSettings_FlashSettingsFileHeader_default.FWCornerPixDistX;
                  hdr_v1.FWCornerPixDistY = FlashSettings_FlashSettingsFileHeader_default.FWCornerPixDistY;
                  hdr_v1.FWCenterPixRadius = FlashSettings_FlashSettingsFileHeader_default.FWCenterPixRadius;
                  hdr_v1.FWCornerPixRadius = FlashSettings_FlashSettingsFileHeader_default.FWCornerPixRadius;
                  hdr_v1.FWPositionControllerPP = FlashSettings_FlashSettingsFileHeader_default.FWPositionControllerPP;
                  hdr_v1.FWPositionControllerPD = FlashSettings_FlashSettingsFileHeader_default.FWPositionControllerPD;
                  hdr_v1.FWPositionControllerPOR = FlashSettings_FlashSettingsFileHeader_default.FWPositionControllerPOR;
                  hdr_v1.FWPositionControllerI = FlashSettings_FlashSettingsFileHeader_default.FWPositionControllerI;
                  hdr_v1.FWSlowSpeedControllerPP = FlashSettings_FlashSettingsFileHeader_default.FWSlowSpeedControllerPP;
                  hdr_v1.FWSlowSpeedControllerPD = FlashSettings_FlashSettingsFileHeader_default.FWSlowSpeedControllerPD;
                  hdr_v1.FWSlowSpeedControllerPOR = FlashSettings_FlashSettingsFileHeader_default.FWSlowSpeedControllerPOR;
                  hdr_v1.FWSlowSpeedControllerPI = FlashSettings_FlashSettingsFileHeader_default.FWSlowSpeedControllerPI;
                  hdr_v1.FWFastSpeedControllerPP = FlashSettings_FlashSettingsFileHeader_default.FWFastSpeedControllerPP;
                  hdr_v1.FWFastSpeedControllerPD = FlashSettings_FlashSettingsFileHeader_default.FWFastSpeedControllerPD;
                  hdr_v1.FWFastSpeedControllerPOR = FlashSettings_FlashSettingsFileHeader_default.FWFastSpeedControllerPOR;
                  hdr_v1.FWFastSpeedControllerI = FlashSettings_FlashSettingsFileHeader_default.FWFastSpeedControllerI;
                  hdr_v1.FWSpeedControllerSwitchingThreshold = FlashSettings_FlashSettingsFileHeader_default.FWSpeedControllerSwitchingThreshold;
                  hdr_v1.FileStructureMinorVersion = 6;

               case 6:
                  // 1.6.x -> 1.7.x
                  hdr_v1.FWExposureTimeMaxMargin = FlashSettings_FlashSettingsFileHeader_default.FWExposureTimeMaxMargin;
                  hdr_v1.ExternalFanSpeedSetpoint = FlashSettings_FlashSettingsFileHeader_default.ExternalFanSpeedSetpoint;
                  hdr_v1.FileStructureMinorVersion = 7;

               case 7:
                  // 1.7.x -> 1.8.x
                  hdr_v1.BPDetectionEnabled = FlashSettings_FlashSettingsFileHeader_default.BPDetectionEnabled;
                  hdr_v1.BPNumSamples = FlashSettings_FlashSettingsFileHeader_default.BPNumSamples;
                  hdr_v1.BPFlickerThreshold = FlashSettings_FlashSettingsFileHeader_default.BPFlickerThreshold;
                  hdr_v1.BPNoiseThreshold = FlashSettings_FlashSettingsFileHeader_default.BPNoiseThreshold;
                  hdr_v1.BPDuration = FlashSettings_FlashSettingsFileHeader_default.BPDuration;
                  hdr_v1.BPNCoadd = FlashSettings_FlashSettingsFileHeader_default.BPNCoadd;
                  hdr_v1.MaximumTotalFlux = FlashSettings_FlashSettingsFileHeader_default.MaximumTotalFlux;
                  hdr_v1.FluxRatio01 = FlashSettings_FlashSettingsFileHeader_default.FluxRatio01;
                  hdr_v1.FluxRatio12 = FlashSettings_FlashSettingsFileHeader_default.FluxRatio12;
                  hdr_v1.AECPlusExpTimeMargin = FlashSettings_FlashSettingsFileHeader_default.AECPlusExpTimeMargin;
                  hdr_v1.AECPlusFluxMargin = FlashSettings_FlashSettingsFileHeader_default.AECPlusFluxMargin;
                  hdr_v1.FileStructureMinorVersion = 8;

               case 8:
                  // 1.8.x -> 1.9.x
                  hdr_v1.BPOutlierThreshold = FlashSettings_FlashSettingsFileHeader_default.BPOutlierThreshold;
                  hdr_v1.BPAECImageFraction = FlashSettings_FlashSettingsFileHeader_default.BPAECImageFraction;
                  hdr_v1.BPAECWellFilling = FlashSettings_FlashSettingsFileHeader_default.BPAECWellFilling;
                  hdr_v1.BPAECResponseTime = FlashSettings_FlashSettingsFileHeader_default.BPAECResponseTime;
                  hdr_v1.FileStructureMinorVersion = 9;

               case 9:
                  // 1.9.x -> 1.10.x
                  hdr_v1.DeviceKeyExpirationPOSIXTime = FlashSettings_FlashSettingsFileHeader_default.DeviceKeyExpirationPOSIXTime;
                  hdr_v1.DeviceKeyLow = FlashSettings_FlashSettingsFileHeader_default.DeviceKeyLow;
                  hdr_v1.DeviceKeyHigh = FlashSettings_FlashSettingsFileHeader_default.DeviceKeyHigh;
                  hdr_v1.FileStructureMinorVersion = 10;

               case 10:
                  // 1.10.x -> 1.11.x
                  hdr_v1.ActualizationDiscardOffset = FlashSettings_FlashSettingsFileHeader_default.ImageCorrectionDiscardOffset;
                  hdr_v1.FileStructureMinorVersion = 11;

               case 11:
                  // 1.11.x -> 1.12.x
                  hdr_v1.DetectorElectricalTapsRef = FlashSettings_FlashSettingsFileHeader_default.DetectorElectricalTapsRef;
                  hdr_v1.DetectorElectricalRefOffset = FlashSettings_FlashSettingsFileHeader_default.DetectorElectricalRefOffset;
                  hdr_v1.FileStructureMinorVersion = 12;

               case 12:
                  // 1.12.x -> 1.13.x
                  hdr_v1.AECPlusExpTimeMargin = FlashSettings_FlashSettingsFileHeader_default.AECPlusExposureTimeMin;
                  hdr_v1.FileStructureMinorVersion = 13;

               case 13:
               default:
                  // 1.13.x -> 2.0.x
                  memcpy(hdr->FileSignature, hdr_v1.FileSignature, 5);
                  hdr->DeviceSerialNumber = hdr_v1.DeviceSerialNumber;
                  memcpy(hdr->DeviceModelName, hdr_v1.DeviceModelName, 21);
                  hdr->SensorID = hdr_v1.SensorID;
                  hdr->PixelDataResolution = hdr_v1.PixelDataResolution;
                  hdr->ReverseX = hdr_v1.ReverseX;
                  hdr->ReverseY = hdr_v1.ReverseY;
                  hdr->ICUPresent = hdr_v1.ICUPresent;
                  hdr->ICUMode = hdr_v1.ICUMode;
                  hdr->ICUCalibPosition = hdr_v1.ICUCalibPosition;
                  hdr->ICUPulseWidth = hdr_v1.ICUPulseWidth;
                  hdr->ICUPeriod = hdr_v1.ICUPeriod;
                  hdr->ICUTransitionDuration = hdr_v1.ICUTransitionDuration;
                  hdr->ImageCorrectionEnabled = hdr_v1.ActualizationEnabled;
                  hdr->ImageCorrectionAtPowerOn = hdr_v1.ActualizationAtPowerOn;
                  hdr->ImageCorrectionNumberOfImagesCoadd = hdr_v1.ActualizationNumberOfImagesCoadd;
                  hdr->ImageCorrectionAECImageFraction = hdr_v1.ActualizationAECImageFraction;
                  hdr->ImageCorrectionAECTargetWellFilling = hdr_v1.ActualizationAECTargetWellFilling;
                  hdr->ImageCorrectionAECResponseTime = hdr_v1.ActualizationAECResponseTime;
                  hdr->FWPresent = hdr_v1.FWPresent;
                  hdr->FWNumberOfFilters = hdr_v1.FWNumberOfFilters;
                  hdr->FWType = hdr_v1.FWType;
                  hdr->FW0CenterPosition = hdr_v1.FW0CenterPosition;
                  hdr->FW1CenterPosition = hdr_v1.FW1CenterPosition;
                  hdr->FW2CenterPosition = hdr_v1.FW2CenterPosition;
                  hdr->FW3CenterPosition = hdr_v1.FW3CenterPosition;
                  hdr->FW4CenterPosition = hdr_v1.FW4CenterPosition;
                  hdr->FW5CenterPosition = hdr_v1.FW5CenterPosition;
                  hdr->FW6CenterPosition = hdr_v1.FW6CenterPosition;
                  hdr->FW7CenterPosition = hdr_v1.FW7CenterPosition;
                  hdr->ImageCorrectionTemperatureSelector = hdr_v1.ActualizationTemperatureSelector;
                  hdr->ImageCorrectionDiscardOffset = hdr_v1.ActualizationDiscardOffset;
                  hdr->ImageCorrectionWaitTime1 = hdr_v1.ActualizationWaitTime1;
                  hdr->ImageCorrectionTemperatureTolerance1 = hdr_v1.ActualizationTemperatureTolerance1;
                  hdr->ImageCorrectionStabilizationTime1 = hdr_v1.ActualizationStabilizationTime1;
                  hdr->ImageCorrectionTimeout1 = hdr_v1.ActualizationTimeout1;
                  hdr->ImageCorrectionWaitTime2 = hdr_v1.ActualizationWaitTime2;
                  hdr->ImageCorrectionTemperatureTolerance2 = hdr_v1.ActualizationTemperatureTolerance2;
                  hdr->ImageCorrectionStabilizationTime2 = hdr_v1.ActualizationStabilizationTime2;
                  hdr->ImageCorrectionTimeout2 = hdr_v1.ActualizationTimeout2;
                  hdr->DetectorPolarizationVoltage = hdr_v1.DetectorPolarizationVoltage;
                  hdr->ExternalMemoryBufferPresent = hdr_v1.ExternalMemoryBufferPresent;
                  hdr->NDFPresent = hdr_v1.NDFPresent;
                  hdr->NDFNumberOfFilters = hdr_v1.NDFNumberOfFilters;
                  hdr->NDFClearFOVWidth = hdr_v1.NDFClearFOVWidth;
                  hdr->NDF0CenterPosition = hdr_v1.NDF0CenterPosition;
                  hdr->NDF1CenterPosition = hdr_v1.NDF1CenterPosition;
                  hdr->NDF2CenterPosition = hdr_v1.NDF2CenterPosition;
                  hdr->FWSpeedMax = hdr_v1.FWSpeedMax;
                  hdr->FWEncoderCyclePerTurn = hdr_v1.FWEncoderCyclePerTurn;
                  hdr->FWOpticalAxisPosX = hdr_v1.FWOpticalAxisPosX;
                  hdr->FWOpticalAxisPosY = hdr_v1.FWOpticalAxisPosY;
                  hdr->FWMountingHoleRadius = hdr_v1.FWMountingHoleRadius;
                  hdr->FWBeamMarging = hdr_v1.FWBeamMarging;
                  hdr->FWCornerPixDistX = hdr_v1.FWCornerPixDistX;
                  hdr->FWCornerPixDistY = hdr_v1.FWCornerPixDistY;
                  hdr->FWCenterPixRadius = hdr_v1.FWCenterPixRadius;
                  hdr->FWCornerPixRadius = hdr_v1.FWCornerPixRadius;
                  hdr->FWPositionControllerPP = hdr_v1.FWPositionControllerPP;
                  hdr->FWPositionControllerPD = hdr_v1.FWPositionControllerPD;
                  hdr->FWPositionControllerPOR = hdr_v1.FWPositionControllerPOR;
                  hdr->FWPositionControllerI = hdr_v1.FWPositionControllerI;
                  hdr->FWSlowSpeedControllerPP = hdr_v1.FWSlowSpeedControllerPP;
                  hdr->FWSlowSpeedControllerPD = hdr_v1.FWSlowSpeedControllerPD;
                  hdr->FWSlowSpeedControllerPOR = hdr_v1.FWSlowSpeedControllerPOR;
                  hdr->FWSlowSpeedControllerPI = hdr_v1.FWSlowSpeedControllerPI;
                  hdr->FWFastSpeedControllerPP = hdr_v1.FWFastSpeedControllerPP;
                  hdr->FWFastSpeedControllerPD = hdr_v1.FWFastSpeedControllerPD;
                  hdr->FWFastSpeedControllerPOR = hdr_v1.FWFastSpeedControllerPOR;
                  hdr->FWFastSpeedControllerI = hdr_v1.FWFastSpeedControllerI;
                  hdr->FWSpeedControllerSwitchingThreshold = hdr_v1.FWSpeedControllerSwitchingThreshold;
                  hdr->FWExposureTimeMaxMargin = hdr_v1.FWExposureTimeMaxMargin;
                  hdr->ExternalFanSpeedSetpoint = hdr_v1.ExternalFanSpeedSetpoint;
                  hdr->BPDetectionEnabled = hdr_v1.BPDetectionEnabled;
                  hdr->BPNumSamples = hdr_v1.BPNumSamples;
                  hdr->BPFlickerThreshold = hdr_v1.BPFlickerThreshold;
                  hdr->BPNoiseThreshold = hdr_v1.BPNoiseThreshold;
                  hdr->BPDuration = hdr_v1.BPDuration;
                  hdr->BPNCoadd = hdr_v1.BPNCoadd;
                  hdr->MaximumTotalFlux = hdr_v1.MaximumTotalFlux;
                  hdr->FluxRatio01 = hdr_v1.FluxRatio01;
                  hdr->FluxRatio12 = hdr_v1.FluxRatio12;
                  hdr->AECPlusExpTimeMargin = hdr_v1.AECPlusExpTimeMargin;
                  hdr->AECPlusFluxMargin = hdr_v1.AECPlusFluxMargin;
                  hdr->BPOutlierThreshold = hdr_v1.BPOutlierThreshold;
                  hdr->BPAECImageFraction = hdr_v1.BPAECImageFraction;
                  hdr->BPAECWellFilling = hdr_v1.BPAECWellFilling;
                  hdr->BPAECResponseTime = hdr_v1.BPAECResponseTime;
                  hdr->DeviceKeyExpirationPOSIXTime = hdr_v1.DeviceKeyExpirationPOSIXTime;
                  hdr->DeviceKeyLow = hdr_v1.DeviceKeyLow;
                  hdr->DeviceKeyHigh = hdr_v1.DeviceKeyHigh;
                  hdr->DetectorElectricalTapsRef = hdr_v1.DetectorElectricalTapsRef;
                  hdr->DetectorElectricalRefOffset = hdr_v1.DetectorElectricalRefOffset;
                  hdr->ADCReadoutEnabled = FlashSettings_FlashSettingsFileHeader_default.ADCReadoutEnabled;
                  hdr->ADCReadout_b = FlashSettings_FlashSettingsFileHeader_default.ADCReadout_b;
                  hdr->ADCReadout_m = FlashSettings_FlashSettingsFileHeader_default.ADCReadout_m;
                  hdr->AECPlusExposureTimeMin = hdr_v1.AECPlusExposureTimeMin;

                  hdr->FileStructureMajorVersion = 2;
                  hdr->FileStructureMinorVersion = 0;
                  hdr->FileHeaderLength = FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE;
                  hdr->FileHeaderCRC16 = 0;

                  minorVersion = 0;
            }

         case 2:
            // 2.x.x
            switch (minorVersion)
            {
               case 0:
                  // 2.0.x -> 2.1.x
                  if (fi.version.major == 2)
                  {
                     // Set AECPlusExpTimeMargin field to its default value only if it is a 2.0.0 flash settings file version
                     // to make sure 1.13.0 flash settings file version AECPlusExposureTimeMin field value is not overwritten.
                     hdr->AECPlusExpTimeMargin = FlashSettings_FlashSettingsFileHeader_default.AECPlusExposureTimeMin;
                  }
                  hdr->AECSaturatedCorrectionFactor = FlashSettings_FlashSettingsFileHeader_default.AECSaturatedCorrectionFactor;
                  hdr->FWFramePeriodMinMargin = FlashSettings_FlashSettingsFileHeader_default.FWFramePeriodMinMargin;
                  hdr->FileStructureMinorVersion = 1;

               case 1:
                  // 2.1.x -> 2.2.x
                  hdr->InternalLensThType = FlashSettings_FlashSettingsFileHeader_default.InternalLensThType;
                  hdr->ExternalLensThType = FlashSettings_FlashSettingsFileHeader_default.ExternalLensThType;
                  hdr->ICUThType = FlashSettings_FlashSettingsFileHeader_default.ICUThType;
                  hdr->SFWThType = FlashSettings_FlashSettingsFileHeader_default.SFWThType;
                  hdr->CompressorThType = FlashSettings_FlashSettingsFileHeader_default.CompressorThType;
                  hdr->ColdfingerThType = FlashSettings_FlashSettingsFileHeader_default.ColdfingerThType;
                  hdr->SpareThType = FlashSettings_FlashSettingsFileHeader_default.SpareThType;
                  hdr->ExternalTempThType = FlashSettings_FlashSettingsFileHeader_default.ExternalTempThType;
                  hdr->XADCRefVoltage1 = FlashSettings_FlashSettingsFileHeader_default.XADCRefVoltage1;
                  hdr->XADCRefVoltage2 = FlashSettings_FlashSettingsFileHeader_default.XADCRefVoltage2;
                  hdr->XADCRefVoltage3 = FlashSettings_FlashSettingsFileHeader_default.XADCRefVoltage3;
                  hdr->FileStructureMinorVersion = 2;

               case 2:
                  // 2.2.x -> 2.3.x
                  hdr->SFWOptoswitchPresent = FlashSettings_FlashSettingsFileHeader_default.SFWOptoswitchPresent;
                  hdr->FileStructureMinorVersion = 3;

               case 3:
                  // 2.3.x -> 2.4.x
                  hdr->MotorizedLensType = FlashSettings_FlashSettingsFileHeader_default.MotorizedLensType;
                  hdr->AutofocusModuleType = FlashSettings_FlashSettingsFileHeader_default.AutofocusModuleType;
                  hdr->FOVNumberOfPositions = FlashSettings_FlashSettingsFileHeader_default.FOVNumberOfPositions;
                  hdr->FOV1ToLensFOV = FlashSettings_FlashSettingsFileHeader_default.FOV1ToLensFOV;
                  hdr->FOV2ToLensFOV = FlashSettings_FlashSettingsFileHeader_default.FOV2ToLensFOV;
                  hdr->FOV3ToLensFOV = FlashSettings_FlashSettingsFileHeader_default.FOV3ToLensFOV;
                  hdr->FOV4ToLensFOV = FlashSettings_FlashSettingsFileHeader_default.FOV4ToLensFOV;
                  hdr->LensFOV1DeltaFocusPositionMin = FlashSettings_FlashSettingsFileHeader_default.LensFOV1DeltaFocusPositionMin;
                  hdr->LensFOV1DeltaFocusPositionMax = FlashSettings_FlashSettingsFileHeader_default.LensFOV1DeltaFocusPositionMax;
                  hdr->LensFOV2DeltaFocusPositionMin = FlashSettings_FlashSettingsFileHeader_default.LensFOV2DeltaFocusPositionMin;
                  hdr->LensFOV2DeltaFocusPositionMax = FlashSettings_FlashSettingsFileHeader_default.LensFOV2DeltaFocusPositionMax;
                  hdr->LensFOV3DeltaFocusPositionMin = FlashSettings_FlashSettingsFileHeader_default.LensFOV3DeltaFocusPositionMin;
                  hdr->LensFOV3DeltaFocusPositionMax = FlashSettings_FlashSettingsFileHeader_default.LensFOV3DeltaFocusPositionMax;
                  hdr->LensFOV4DeltaFocusPositionMin = FlashSettings_FlashSettingsFileHeader_default.LensFOV4DeltaFocusPositionMin;
                  hdr->LensFOV4DeltaFocusPositionMax = FlashSettings_FlashSettingsFileHeader_default.LensFOV4DeltaFocusPositionMax;
                  hdr->LensFOV5DeltaFocusPositionMin = FlashSettings_FlashSettingsFileHeader_default.LensFOV5DeltaFocusPositionMin;
                  hdr->LensFOV5DeltaFocusPositionMax = FlashSettings_FlashSettingsFileHeader_default.LensFOV5DeltaFocusPositionMax;
                  hdr->AcquisitionFrameRateMaxDivider = FlashSettings_FlashSettingsFileHeader_default.AcquisitionFrameRateMaxDivider;
                  hdr->FileStructureMinorVersion = 4;

               case 4:
                  // 2.4.x -> 2.5.x
                  hdr->ExposureTimeOffset = FlashSettings_FlashSettingsFileHeader_default.ExposureTimeOffset;
                  hdr->FWReferenceTemperatureGain = FlashSettings_FlashSettingsFileHeader_default.FWReferenceTemperatureGain;
                  hdr->FWReferenceTemperatureOffset = FlashSettings_FlashSettingsFileHeader_default.FWReferenceTemperatureOffset;
                  hdr->FileStructureMinorVersion = 5;

               case 5:
                  // 2.5.x -> 2.6.x
                  hdr->ExposureTimeMin = FlashSettings_FlashSettingsFileHeader_default.ExposureTimeMin;
                  hdr->ClConfiguration = FlashSettings_FlashSettingsFileHeader_default.ClConfiguration;
                  hdr->FileStructureMinorVersion = 6;

               case 6:
                  // 2.6.x -> 2.7.x
                  hdr->SaveConfigurationEnabled = FlashSettings_FlashSettingsFileHeader_default.SaveConfigurationEnabled;
                  hdr->FPATemperatureConversionCoef0 = FlashSettings_FlashSettingsFileHeader_default.FPATemperatureConversionCoef0;
                  hdr->FPATemperatureConversionCoef1 = FlashSettings_FlashSettingsFileHeader_default.FPATemperatureConversionCoef1;
                  hdr->FPATemperatureConversionCoef2 = FlashSettings_FlashSettingsFileHeader_default.FPATemperatureConversionCoef2;
                  hdr->FPATemperatureConversionCoef3 = FlashSettings_FlashSettingsFileHeader_default.FPATemperatureConversionCoef3;
                  hdr->FPATemperatureConversionCoef4 = FlashSettings_FlashSettingsFileHeader_default.FPATemperatureConversionCoef4;
                  hdr->FPATemperatureConversionCoef5 = FlashSettings_FlashSettingsFileHeader_default.FPATemperatureConversionCoef5;
                  hdr->FileStructureMinorVersion = 7;

               case 7:
                  // 2.7.x -> 2.8.x
                  hdr->ElCorrMeasAtStarvation = FlashSettings_FlashSettingsFileHeader_default.ElCorrMeasAtStarvation;
                  hdr->ElCorrMeasAtSaturation = FlashSettings_FlashSettingsFileHeader_default.ElCorrMeasAtSaturation;
                  hdr->ElCorrMeasAtReference1 = FlashSettings_FlashSettingsFileHeader_default.ElCorrMeasAtReference1;
                  hdr->ElCorrMeasAtReference2 = FlashSettings_FlashSettingsFileHeader_default.ElCorrMeasAtReference2;
                  hdr->FileStructureMinorVersion = 8;

               case 8:
                  // Up to date, nothing to do
                  hdr->FileStructureSubMinorVersion = FLASHSETTINGS_FILESUBMINORVERSION;
                  break;
            }
      }

      idxChunk = 0;
      return IRC_DONE;
   }
}
