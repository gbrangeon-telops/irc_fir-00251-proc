/**
 * @file FlashSettingsFile_v2.c
 * Camera image correction calibration file structure v2 definition.
 *
 * This file defines camera image correction calibration file structure v2.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 2.3.0
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
#include "utils.h"
#include "verbose.h"
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
   /* ICUPulseWidth = */ 150,
   /* ICUPeriod = */ 1000,
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
   /* AECPlusExposureTimeMin = */ 0.000000F,
   /* AECSaturatedCorrectionFactor = */ 0.2F,
   /* FWFramePeriodMinMargin = */ 0.05F,
   /* InternalLensThType = */ 0,
   /* ExternalLensThType = */ 0,
   /* ICUThType = */ 0,
   /* SFWThType = */ 0,
   /* CompressorThType = */ 0,
   /* ColdfingerThType = */ 0,
   /* SpareThType = */ 0,
   /* ExternalTempThType = */ 0,
   /* XADCRefVoltage1 = */ 0.000000F,
   /* XADCRefVoltage2 = */ 0.000000F,
   /* XADCRefVoltage3 = */ 0.000000F,
   /* SFWOptoswitchPresent = */ 0,
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
      memcpy(&hdr->AECPlusExposureTimeMin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->AECSaturatedCorrectionFactor, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWFramePeriodMinMargin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->InternalLensThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ExternalLensThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ICUThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->SFWThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->CompressorThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ColdfingerThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->SpareThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ExternalTempThType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->XADCRefVoltage1, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->XADCRefVoltage2, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->XADCRefVoltage3, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->SFWOptoswitchPresent, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 159; // Skip FREE space

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
      memcpy(&buffer[numBytes], &hdr->AECPlusExposureTimeMin, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->AECSaturatedCorrectionFactor, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWFramePeriodMinMargin, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->InternalLensThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ExternalLensThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ICUThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->SFWThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->CompressorThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ColdfingerThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->SpareThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ExternalTempThType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->XADCRefVoltage1, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->XADCRefVoltage2, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->XADCRefVoltage3, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->SFWOptoswitchPresent, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 159); numBytes += 159; // FREE space

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

/**
 * FlashSettingsFileHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void FlashSettings_PrintFlashSettingsFileHeader_v2(FlashSettings_FlashSettingsFileHeader_v2_t *hdr)
{
   FPGA_PRINTF("FileSignature: %s\n", hdr->FileSignature);
   FPGA_PRINTF("FileStructureMajorVersion: %d\n", hdr->FileStructureMajorVersion);
   FPGA_PRINTF("FileStructureMinorVersion: %d\n", hdr->FileStructureMinorVersion);
   FPGA_PRINTF("FileStructureSubMinorVersion: %d\n", hdr->FileStructureSubMinorVersion);
   FPGA_PRINTF("FileHeaderLength: %d\n", hdr->FileHeaderLength);
   FPGA_PRINTF("DeviceSerialNumber: %d\n", hdr->DeviceSerialNumber);
   FPGA_PRINTF("DeviceModelName: %s\n", hdr->DeviceModelName);
   FPGA_PRINTF("SensorID: %d\n", hdr->SensorID);
   FPGA_PRINTF("PixelDataResolution: %d\n", hdr->PixelDataResolution);
   FPGA_PRINTF("ReverseX: %d\n", hdr->ReverseX);
   FPGA_PRINTF("ReverseY: %d\n", hdr->ReverseY);
   FPGA_PRINTF("ICUPresent: %d\n", hdr->ICUPresent);
   FPGA_PRINTF("ICUMode: %d\n", hdr->ICUMode);
   FPGA_PRINTF("ICUCalibPosition: %d\n", hdr->ICUCalibPosition);
   FPGA_PRINTF("ICUPulseWidth: %d\n", hdr->ICUPulseWidth);
   FPGA_PRINTF("ICUPeriod: %d\n", hdr->ICUPeriod);
   FPGA_PRINTF("ICUTransitionDuration: %d\n", hdr->ICUTransitionDuration);
   FPGA_PRINTF("ImageCorrectionEnabled: %d\n", hdr->ImageCorrectionEnabled);
   FPGA_PRINTF("ImageCorrectionAtPowerOn: %d\n", hdr->ImageCorrectionAtPowerOn);
   FPGA_PRINTF("ImageCorrectionNumberOfImagesCoadd: %d\n", hdr->ImageCorrectionNumberOfImagesCoadd);
   FPGA_PRINTF("ImageCorrectionAECImageFraction: " _PCF(3) "\n", _FFMT(hdr->ImageCorrectionAECImageFraction, 3));
   FPGA_PRINTF("ImageCorrectionAECTargetWellFilling: " _PCF(3) "\n", _FFMT(hdr->ImageCorrectionAECTargetWellFilling, 3));
   FPGA_PRINTF("ImageCorrectionAECResponseTime: " _PCF(3) "\n", _FFMT(hdr->ImageCorrectionAECResponseTime, 3));
   FPGA_PRINTF("FWPresent: %d\n", hdr->FWPresent);
   FPGA_PRINTF("FWNumberOfFilters: %d\n", hdr->FWNumberOfFilters);
   FPGA_PRINTF("FWType: %d\n", hdr->FWType);
   FPGA_PRINTF("FW0CenterPosition: %d\n", hdr->FW0CenterPosition);
   FPGA_PRINTF("FW1CenterPosition: %d\n", hdr->FW1CenterPosition);
   FPGA_PRINTF("FW2CenterPosition: %d\n", hdr->FW2CenterPosition);
   FPGA_PRINTF("FW3CenterPosition: %d\n", hdr->FW3CenterPosition);
   FPGA_PRINTF("FW4CenterPosition: %d\n", hdr->FW4CenterPosition);
   FPGA_PRINTF("FW5CenterPosition: %d\n", hdr->FW5CenterPosition);
   FPGA_PRINTF("FW6CenterPosition: %d\n", hdr->FW6CenterPosition);
   FPGA_PRINTF("FW7CenterPosition: %d\n", hdr->FW7CenterPosition);
   FPGA_PRINTF("ImageCorrectionTemperatureSelector: %d\n", hdr->ImageCorrectionTemperatureSelector);
   FPGA_PRINTF("ImageCorrectionDiscardOffset: %d\n", hdr->ImageCorrectionDiscardOffset);
   FPGA_PRINTF("ImageCorrectionWaitTime1: %d\n", hdr->ImageCorrectionWaitTime1);
   FPGA_PRINTF("ImageCorrectionTemperatureTolerance1: %d\n", hdr->ImageCorrectionTemperatureTolerance1);
   FPGA_PRINTF("ImageCorrectionStabilizationTime1: %d\n", hdr->ImageCorrectionStabilizationTime1);
   FPGA_PRINTF("ImageCorrectionTimeout1: %d\n", hdr->ImageCorrectionTimeout1);
   FPGA_PRINTF("ImageCorrectionWaitTime2: %d\n", hdr->ImageCorrectionWaitTime2);
   FPGA_PRINTF("ImageCorrectionTemperatureTolerance2: %d\n", hdr->ImageCorrectionTemperatureTolerance2);
   FPGA_PRINTF("ImageCorrectionStabilizationTime2: %d\n", hdr->ImageCorrectionStabilizationTime2);
   FPGA_PRINTF("ImageCorrectionTimeout2: %d\n", hdr->ImageCorrectionTimeout2);
   FPGA_PRINTF("DetectorPolarizationVoltage: %d\n", hdr->DetectorPolarizationVoltage);
   FPGA_PRINTF("ExternalMemoryBufferPresent: %d\n", hdr->ExternalMemoryBufferPresent);
   FPGA_PRINTF("NDFPresent: %d\n", hdr->NDFPresent);
   FPGA_PRINTF("NDFNumberOfFilters: %d\n", hdr->NDFNumberOfFilters);
   FPGA_PRINTF("NDFClearFOVWidth: %d\n", hdr->NDFClearFOVWidth);
   FPGA_PRINTF("NDF0CenterPosition: %d\n", hdr->NDF0CenterPosition);
   FPGA_PRINTF("NDF1CenterPosition: %d\n", hdr->NDF1CenterPosition);
   FPGA_PRINTF("NDF2CenterPosition: %d\n", hdr->NDF2CenterPosition);
   FPGA_PRINTF("FWSpeedMax: %d\n", hdr->FWSpeedMax);
   FPGA_PRINTF("FWEncoderCyclePerTurn: %d\n", hdr->FWEncoderCyclePerTurn);
   FPGA_PRINTF("FWOpticalAxisPosX: " _PCF(3) "\n", _FFMT(hdr->FWOpticalAxisPosX, 3));
   FPGA_PRINTF("FWOpticalAxisPosY: " _PCF(3) "\n", _FFMT(hdr->FWOpticalAxisPosY, 3));
   FPGA_PRINTF("FWMountingHoleRadius: " _PCF(3) "\n", _FFMT(hdr->FWMountingHoleRadius, 3));
   FPGA_PRINTF("FWBeamMarging: " _PCF(3) "\n", _FFMT(hdr->FWBeamMarging, 3));
   FPGA_PRINTF("FWCornerPixDistX: " _PCF(3) "\n", _FFMT(hdr->FWCornerPixDistX, 3));
   FPGA_PRINTF("FWCornerPixDistY: " _PCF(3) "\n", _FFMT(hdr->FWCornerPixDistY, 3));
   FPGA_PRINTF("FWCenterPixRadius: " _PCF(3) "\n", _FFMT(hdr->FWCenterPixRadius, 3));
   FPGA_PRINTF("FWCornerPixRadius: " _PCF(3) "\n", _FFMT(hdr->FWCornerPixRadius, 3));
   FPGA_PRINTF("FWPositionControllerPP: %d\n", hdr->FWPositionControllerPP);
   FPGA_PRINTF("FWPositionControllerPD: %d\n", hdr->FWPositionControllerPD);
   FPGA_PRINTF("FWPositionControllerPOR: %d\n", hdr->FWPositionControllerPOR);
   FPGA_PRINTF("FWPositionControllerI: %d\n", hdr->FWPositionControllerI);
   FPGA_PRINTF("FWSlowSpeedControllerPP: %d\n", hdr->FWSlowSpeedControllerPP);
   FPGA_PRINTF("FWSlowSpeedControllerPD: %d\n", hdr->FWSlowSpeedControllerPD);
   FPGA_PRINTF("FWSlowSpeedControllerPOR: %d\n", hdr->FWSlowSpeedControllerPOR);
   FPGA_PRINTF("FWSlowSpeedControllerPI: %d\n", hdr->FWSlowSpeedControllerPI);
   FPGA_PRINTF("FWFastSpeedControllerPP: %d\n", hdr->FWFastSpeedControllerPP);
   FPGA_PRINTF("FWFastSpeedControllerPD: %d\n", hdr->FWFastSpeedControllerPD);
   FPGA_PRINTF("FWFastSpeedControllerPOR: %d\n", hdr->FWFastSpeedControllerPOR);
   FPGA_PRINTF("FWFastSpeedControllerI: %d\n", hdr->FWFastSpeedControllerI);
   FPGA_PRINTF("FWSpeedControllerSwitchingThreshold: %d\n", hdr->FWSpeedControllerSwitchingThreshold);
   FPGA_PRINTF("FWExposureTimeMaxMargin: " _PCF(3) "\n", _FFMT(hdr->FWExposureTimeMaxMargin, 3));
   FPGA_PRINTF("ExternalFanSpeedSetpoint: " _PCF(3) "\n", _FFMT(hdr->ExternalFanSpeedSetpoint, 3));
   FPGA_PRINTF("BPDetectionEnabled: %d\n", hdr->BPDetectionEnabled);
   FPGA_PRINTF("BPNumSamples: %d\n", hdr->BPNumSamples);
   FPGA_PRINTF("BPFlickerThreshold: " _PCF(3) "\n", _FFMT(hdr->BPFlickerThreshold, 3));
   FPGA_PRINTF("BPNoiseThreshold: " _PCF(3) "\n", _FFMT(hdr->BPNoiseThreshold, 3));
   FPGA_PRINTF("BPDuration: %d\n", hdr->BPDuration);
   FPGA_PRINTF("BPNCoadd: %d\n", hdr->BPNCoadd);
   FPGA_PRINTF("MaximumTotalFlux: " _PCF(3) "\n", _FFMT(hdr->MaximumTotalFlux, 3));
   FPGA_PRINTF("FluxRatio01: " _PCF(3) "\n", _FFMT(hdr->FluxRatio01, 3));
   FPGA_PRINTF("FluxRatio12: " _PCF(3) "\n", _FFMT(hdr->FluxRatio12, 3));
   FPGA_PRINTF("AECPlusExpTimeMargin: " _PCF(3) "\n", _FFMT(hdr->AECPlusExpTimeMargin, 3));
   FPGA_PRINTF("AECPlusFluxMargin: " _PCF(3) "\n", _FFMT(hdr->AECPlusFluxMargin, 3));
   FPGA_PRINTF("BPOutlierThreshold: " _PCF(3) "\n", _FFMT(hdr->BPOutlierThreshold, 3));
   FPGA_PRINTF("BPAECImageFraction: " _PCF(3) "\n", _FFMT(hdr->BPAECImageFraction, 3));
   FPGA_PRINTF("BPAECWellFilling: " _PCF(3) "\n", _FFMT(hdr->BPAECWellFilling, 3));
   FPGA_PRINTF("BPAECResponseTime: " _PCF(3) "\n", _FFMT(hdr->BPAECResponseTime, 3));
   FPGA_PRINTF("DeviceKeyExpirationPOSIXTime: %d\n", hdr->DeviceKeyExpirationPOSIXTime);
   FPGA_PRINTF("DeviceKeyLow: %d\n", hdr->DeviceKeyLow);
   FPGA_PRINTF("DeviceKeyHigh: %d\n", hdr->DeviceKeyHigh);
   FPGA_PRINTF("DetectorElectricalTapsRef: " _PCF(3) "\n", _FFMT(hdr->DetectorElectricalTapsRef, 3));
   FPGA_PRINTF("DetectorElectricalRefOffset: " _PCF(3) "\n", _FFMT(hdr->DetectorElectricalRefOffset, 3));
   FPGA_PRINTF("ADCReadoutEnabled: %d\n", hdr->ADCReadoutEnabled);
   FPGA_PRINTF("ADCReadout_b: %d\n", hdr->ADCReadout_b);
   FPGA_PRINTF("ADCReadout_m: " _PCF(3) "\n", _FFMT(hdr->ADCReadout_m, 3));
   FPGA_PRINTF("AECPlusExposureTimeMin: " _PCF(3) "\n", _FFMT(hdr->AECPlusExposureTimeMin, 3));
   FPGA_PRINTF("AECSaturatedCorrectionFactor: " _PCF(3) "\n", _FFMT(hdr->AECSaturatedCorrectionFactor, 3));
   FPGA_PRINTF("FWFramePeriodMinMargin: " _PCF(3) "\n", _FFMT(hdr->FWFramePeriodMinMargin, 3));
   FPGA_PRINTF("InternalLensThType: %d\n", hdr->InternalLensThType);
   FPGA_PRINTF("ExternalLensThType: %d\n", hdr->ExternalLensThType);
   FPGA_PRINTF("ICUThType: %d\n", hdr->ICUThType);
   FPGA_PRINTF("SFWThType: %d\n", hdr->SFWThType);
   FPGA_PRINTF("CompressorThType: %d\n", hdr->CompressorThType);
   FPGA_PRINTF("ColdfingerThType: %d\n", hdr->ColdfingerThType);
   FPGA_PRINTF("SpareThType: %d\n", hdr->SpareThType);
   FPGA_PRINTF("ExternalTempThType: %d\n", hdr->ExternalTempThType);
   FPGA_PRINTF("XADCRefVoltage1: " _PCF(3) "\n", _FFMT(hdr->XADCRefVoltage1, 3));
   FPGA_PRINTF("XADCRefVoltage2: " _PCF(3) "\n", _FFMT(hdr->XADCRefVoltage2, 3));
   FPGA_PRINTF("XADCRefVoltage3: " _PCF(3) "\n", _FFMT(hdr->XADCRefVoltage3, 3));
   FPGA_PRINTF("SFWOptoswitchPresent: %d\n", hdr->SFWOptoswitchPresent);
   FPGA_PRINTF("FileHeaderCRC16: %d\n", hdr->FileHeaderCRC16);
}

