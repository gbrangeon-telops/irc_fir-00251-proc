/**
 * @file FlashSettingsFile_v2.c
 * Camera image correction calibration file structure v2 definition.
 *
 * This file defines camera image correction calibration file structure v2.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 2.0.0
 * using generateIRCamFileCLib.m Matlab script.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "FlashSettingsFile_v2.h"
#include "CRC.h"
#include <string.h>
#include <float.h>

/**
 * FlashSettingsFileHeader default values.
 */
FlashSettings_FlashSettingsFileHeader_v2_t FlashSettings_FlashSettingsFileHeader_v2_default = {
   /* FileSignature = */ "TSFS",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* FileHeaderLength = */ 65536,
   /* DeviceSerialNumber = */ 0,
   /* DeviceModelName = */ "",
   /* SensorID = */ 0,
   /* PixelDataResolution = */ 16,
   /* ReverseX = */ 0,
   /* ReverseY = */ 0,
   /* ICUPresent = */ 0,
   /* ICUMode = */ 1,
   /* ICUCalibPosition = */ 0,
   /* ICUPulseWidth = */ 80,
   /* ICUPeriod = */ 350,
   /* ICUTransitionDuration = */ 500,
   /* ImageCorrectionEnabled = */ 1,
   /* ImageCorrectionAtPowerOn = */ 0,
   /* ImageCorrectionNumberOfImagesCoadd = */ 16,
   /* ImageCorrectionAECImageFraction = */ 50.000000F,
   /* ImageCorrectionAECTargetWellFilling = */ 50.000000F,
   /* ImageCorrectionAECResponseTime = */ 500.000000F,
   /* FWPresent = */ 1,
   /* FWNumberOfFilters = */ 4,
   /* FWType = */ 0,
   /* FW0CenterPosition = */ 0,
   /* FW1CenterPosition = */ 47652,
   /* FW2CenterPosition = */ 31768,
   /* FW3CenterPosition = */ 15884,
   /* FW4CenterPosition = */ 0,
   /* FW5CenterPosition = */ 0,
   /* FW6CenterPosition = */ 0,
   /* FW7CenterPosition = */ 0,
   /* ImageCorrectionTemperatureSelector = */ 0,
   /* ImageCorrectionDiscardOffset = */ 0,
   /* ImageCorrectionWaitTime1 = */ 0,
   /* ImageCorrectionTemperatureTolerance1 = */ 20,
   /* ImageCorrectionStabilizationTime1 = */ 60000,
   /* ImageCorrectionTimeout1 = */ 300000,
   /* ImageCorrectionWaitTime2 = */ 5000,
   /* ImageCorrectionTemperatureTolerance2 = */ 20,
   /* ImageCorrectionStabilizationTime2 = */ 0,
   /* ImageCorrectionTimeout2 = */ 300000,
   /* DetectorPolarizationVoltage = */ 0,
   /* ExternalMemoryBufferPresent = */ 0,
   /* NDFPresent = */ 0,
   /* NDFNumberOfFilters = */ 3,
   /* NDFClearFOVWidth = */ 40,
   /* NDF0CenterPosition = */ 442,
   /* NDF1CenterPosition = */ 222,
   /* NDF2CenterPosition = */ 2,
   /* FWSpeedMax = */ 5000,
   /* FWEncoderCyclePerTurn = */ 4096,
   /* FWOpticalAxisPosX = */ -1.351F,
   /* FWOpticalAxisPosY = */ -0.492F,
   /* FWMountingHoleRadius = */ 0.902/2.0F,
   /* FWBeamMarging = */ 0.1/2.54F,
   /* FWCornerPixDistX = */ -5.098/25.4F,
   /* FWCornerPixDistY = */ 4.078/25.4F,
   /* FWCenterPixRadius = */ (3.4/2.0)/25.4F,
   /* FWCornerPixRadius = */ (3.24/2.0)/25.4F,
   /* FWPositionControllerPP = */ 64,
   /* FWPositionControllerPD = */ 2,
   /* FWPositionControllerPOR = */ 3,
   /* FWPositionControllerI = */ 9,
   /* FWSlowSpeedControllerPP = */ 5,
   /* FWSlowSpeedControllerPD = */ 2,
   /* FWSlowSpeedControllerPOR = */ 37,
   /* FWSlowSpeedControllerPI = */ 11,
   /* FWFastSpeedControllerPP = */ 5,
   /* FWFastSpeedControllerPD = */ 2,
   /* FWFastSpeedControllerPOR = */ 11,
   /* FWFastSpeedControllerI = */ 13,
   /* FWSpeedControllerSwitchingThreshold = */ 50,
   /* FWExposureTimeMaxMargin = */ 95.000000F,
   /* ExternalFanSpeedSetpoint = */ 50.000000F,
   /* BPDetectionEnabled = */ 0,
   /* BPNumSamples = */ 500,
   /* BPFlickerThreshold = */  0.346486F,
   /* BPNoiseThreshold = */ 1.333147F,
   /* BPDuration = */ 60000,
   /* BPNCoadd = */ 64,
   /* MaximumTotalFlux = */ FLT_MAX,
   /* FluxRatio01 = */ 1.0F,
   /* FluxRatio12 = */ 1.0F,
   /* AECPlusExpTimeMargin = */ 0.2F,
   /* AECPlusFluxMargin = */ 0.9F,
   /* BPOutlierThreshold = */ 3.306613F,
   /* BPAECImageFraction = */ 50.000000F,
   /* BPAECWellFilling = */ 50.000000F,
   /* BPAECResponseTime = */ 1000.000000F,
   /* DeviceKeyExpirationPOSIXTime = */ 0xFFFFFFFF,
   /* DeviceKeyLow = */ 0x00000000,
   /* DeviceKeyHigh = */ 0x00000000,
   /* DetectorElectricalTapsRef = */ 0.000000F,
   /* DetectorElectricalRefOffset = */ 0.000000F,
   /* ADCReadoutEnabled = */ 0,
   /* ADCReadout_b = */ 0,
   /* ADCReadout_m = */ 1.0F,
   /* FileHeaderCRC16 = */ 0,
};

/**
 * FlashSettingsFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param idxChunk is the header chunk index.
 * @param hdr is the pointer to the header structure to fill.
 * @param crc16 is a pointer to the crc16 value.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t FlashSettings_ParseFlashSettingsFileHeader_v2(uint8_t *buffer, uint32_t buflen, uint32_t idxChunk, FlashSettings_FlashSettingsFileHeader_v2_t *hdr, uint16_t *crc16)
{
   uint32_t numBytes = 0;

   if (idxChunk == 0)
   {
      if (buflen < FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)
      {
         // Not enough bytes in buffer
         return 0;
      }

      memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
      hdr->FileSignature[4] = '\0';

      if (strcmp(hdr->FileSignature, "TSFS") != 0)
      {
         // Wrong file signature
         return 0;
      }

      memcpy(&hdr->FileStructureMajorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);

      if (hdr->FileStructureMajorVersion != 2)
      {
         // Wrong file major version
         return 0;
      }

      memcpy(&hdr->FileStructureMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FileStructureSubMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->FileHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

      if (hdr->FileHeaderLength != FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE_V2)
      {
         // File header length mismatch
         return 0;
      }

      memcpy(&hdr->DeviceSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(hdr->DeviceModelName, &buffer[numBytes], 20); numBytes += 20;
      hdr->DeviceModelName[20] = '\0';
      memcpy(&hdr->SensorID, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->PixelDataResolution, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ReverseX, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ReverseY, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ICUPresent, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ICUMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ICUCalibPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->ICUPulseWidth, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->ICUPeriod, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->ICUTransitionDuration, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      numBytes += 2; // Skip FREE space
      numBytes += 1; // Skip FREE space
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->ImageCorrectionEnabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ImageCorrectionAtPowerOn, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ImageCorrectionNumberOfImagesCoadd, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->ImageCorrectionAECImageFraction, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ImageCorrectionAECTargetWellFilling, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ImageCorrectionAECResponseTime, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWPresent, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FWNumberOfFilters, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FWType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->FW0CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW1CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW2CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW3CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW4CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW5CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW6CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FW7CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->ImageCorrectionTemperatureSelector, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ImageCorrectionDiscardOffset, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->ImageCorrectionWaitTime1, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->ImageCorrectionTemperatureTolerance1, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->ImageCorrectionStabilizationTime1, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->ImageCorrectionTimeout1, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->ImageCorrectionWaitTime2, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->ImageCorrectionTemperatureTolerance2, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->ImageCorrectionStabilizationTime2, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->ImageCorrectionTimeout2, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->DetectorPolarizationVoltage, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->ExternalMemoryBufferPresent, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->NDFPresent, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->NDFNumberOfFilters, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->NDFClearFOVWidth, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->NDF0CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->NDF1CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->NDF2CenterPosition, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FWSpeedMax, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWEncoderCyclePerTurn, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWOpticalAxisPosX, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWOpticalAxisPosY, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWMountingHoleRadius, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWBeamMarging, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWCornerPixDistX, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWCornerPixDistY, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWCenterPixRadius, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWCornerPixRadius, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWPositionControllerPP, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWPositionControllerPD, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWPositionControllerPOR, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWPositionControllerI, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWSlowSpeedControllerPP, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWSlowSpeedControllerPD, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWSlowSpeedControllerPOR, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWSlowSpeedControllerPI, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWFastSpeedControllerPP, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWFastSpeedControllerPD, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWFastSpeedControllerPOR, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWFastSpeedControllerI, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FWSpeedControllerSwitchingThreshold, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->FWExposureTimeMaxMargin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ExternalFanSpeedSetpoint, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPDetectionEnabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->BPNumSamples, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->BPFlickerThreshold, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPNoiseThreshold, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPDuration, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->BPNCoadd, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->MaximumTotalFlux, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FluxRatio01, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FluxRatio12, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->AECPlusExpTimeMargin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->AECPlusFluxMargin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPOutlierThreshold, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPAECImageFraction, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPAECWellFilling, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->BPAECResponseTime, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->DeviceKeyExpirationPOSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->DeviceKeyLow, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->DeviceKeyHigh, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&hdr->DetectorElectricalTapsRef, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->DetectorElectricalRefOffset, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      numBytes += 1; // Skip FREE space
      memcpy(&hdr->ADCReadoutEnabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ADCReadout_b, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->ADCReadout_m, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      numBytes += 192; // Skip FREE space

      *crc16 = CRC16(0xFFFF, buffer, numBytes);
   }
   else if ((idxChunk >= 1) && (idxChunk <= 126))
   {
      if (buflen < FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)
      {
         // Not enough bytes in buffer
         return 0;
      }

      numBytes += 512; // Skip FREE space

      *crc16 = CRC16(*crc16, buffer, numBytes);
   }
   else if (idxChunk == 127)
   {
      if (buflen < FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)
      {
         // Not enough bytes in buffer
         return 0;
      }

      numBytes += 510; // Skip FREE space
      memcpy(&hdr->FileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

      if (hdr->FileHeaderCRC16 != CRC16(*crc16, buffer, numBytes - sizeof(uint16_t)))
      {
         // CRC-16 test failed
         return 0;
      }


      *crc16 = CRC16(*crc16, buffer, numBytes);
   }
   else
   {
      // Invalid header chunk index
      return 0;
   }

   return numBytes;
}

/**
 * FlashSettingsFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param idxChunk is the header chunk index.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 * @param crc16 is a pointer to the crc16 value.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t FlashSettings_WriteFlashSettingsFileHeader_v2(FlashSettings_FlashSettingsFileHeader_v2_t *hdr, uint32_t idxChunk, uint8_t *buffer, uint32_t buflen, uint16_t *crc16)
{
   uint32_t numBytes = 0;

   if (idxChunk == 0)
   {
      if (buflen < FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)
      {
         // Not enough bytes in buffer
         return 0;
      }


      strncpy(hdr->FileSignature, "TSFS", 4);

      memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

      hdr->FileStructureMajorVersion = FLASHSETTINGS_FILEMAJORVERSION_V2;

      memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

      hdr->FileStructureMinorVersion = FLASHSETTINGS_FILEMINORVERSION_V2;

      memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

      hdr->FileStructureSubMinorVersion = FLASHSETTINGS_FILESUBMINORVERSION_V2;

      memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

      hdr->FileHeaderLength = FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE_V2;

      memcpy(&buffer[numBytes], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], hdr->DeviceModelName, 20); numBytes += 20;
      memcpy(&buffer[numBytes], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->PixelDataResolution, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ReverseX, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ReverseY, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ICUPresent, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ICUMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ICUCalibPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memcpy(&buffer[numBytes], &hdr->ICUPulseWidth, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->ICUPeriod, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->ICUTransitionDuration, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionEnabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionAtPowerOn, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionNumberOfImagesCoadd, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionAECImageFraction, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionAECTargetWellFilling, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionAECResponseTime, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWPresent, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FWNumberOfFilters, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FWType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memcpy(&buffer[numBytes], &hdr->FW0CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW1CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW2CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW3CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW4CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW5CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW6CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FW7CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionTemperatureSelector, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionDiscardOffset, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionWaitTime1, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionTemperatureTolerance1, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionStabilizationTime1, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionTimeout1, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionWaitTime2, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionTemperatureTolerance2, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionStabilizationTime2, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->ImageCorrectionTimeout2, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->DetectorPolarizationVoltage, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->ExternalMemoryBufferPresent, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memcpy(&buffer[numBytes], &hdr->NDFPresent, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->NDFNumberOfFilters, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->NDFClearFOVWidth, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->NDF0CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->NDF1CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->NDF2CenterPosition, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FWSpeedMax, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWEncoderCyclePerTurn, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWOpticalAxisPosX, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWOpticalAxisPosY, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWMountingHoleRadius, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWBeamMarging, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWCornerPixDistX, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWCornerPixDistY, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWCenterPixRadius, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWCornerPixRadius, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWPositionControllerPP, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWPositionControllerPD, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWPositionControllerPOR, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWPositionControllerI, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWSlowSpeedControllerPP, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWSlowSpeedControllerPD, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWSlowSpeedControllerPOR, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWSlowSpeedControllerPI, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWFastSpeedControllerPP, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWFastSpeedControllerPD, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWFastSpeedControllerPOR, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWFastSpeedControllerI, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FWSpeedControllerSwitchingThreshold, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->FWExposureTimeMaxMargin, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ExternalFanSpeedSetpoint, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPDetectionEnabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->BPNumSamples, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memcpy(&buffer[numBytes], &hdr->BPFlickerThreshold, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPNoiseThreshold, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPDuration, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->BPNCoadd, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->MaximumTotalFlux, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FluxRatio01, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FluxRatio12, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->AECPlusExpTimeMargin, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->AECPlusFluxMargin, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPOutlierThreshold, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPAECImageFraction, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPAECWellFilling, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->BPAECResponseTime, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->DeviceKeyExpirationPOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->DeviceKeyLow, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->DeviceKeyHigh, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
      memcpy(&buffer[numBytes], &hdr->DetectorElectricalTapsRef, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->DetectorElectricalRefOffset, sizeof(float)); numBytes += sizeof(float);
      memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
      memcpy(&buffer[numBytes], &hdr->ADCReadoutEnabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ADCReadout_b, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->ADCReadout_m, sizeof(float)); numBytes += sizeof(float);
      memset(&buffer[numBytes], 0, 192); numBytes += 192; // FREE space

      *crc16 = CRC16(0xFFFF, buffer, numBytes);
   }
   else if ((idxChunk >= 1) && (idxChunk <= 126))
   {
      if (buflen < FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)
      {
         // Not enough bytes in buffer
         return 0;
      }

      memset(&buffer[numBytes], 0, 512); numBytes += 512; // FREE space

      *crc16 = CRC16(*crc16, buffer, numBytes);
   }
   else if (idxChunk == 127)
   {
      if (buflen < FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2)
      {
         // Not enough bytes in buffer
         return 0;
      }

      memset(&buffer[numBytes], 0, 510); numBytes += 510; // FREE space

      hdr->FileHeaderCRC16 = CRC16(*crc16, buffer, numBytes);
      memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);


      *crc16 = CRC16(*crc16, buffer, numBytes);
   }
   else
   {
      // Invalid header chunk index
      return 0;
   }

   return numBytes;
}

