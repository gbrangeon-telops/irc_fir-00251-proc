/**
 * @file FlashSettingsFile_v2.c
 * Camera flash settings file structure v2 definition.
 *
 * This file defines the camera flash settings file structure v2.
 *
 * Auto-generated flash settings file library.
 * Generated from the flash settings file structure definition XLS file version 2.12.0
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
   /* AECPlusExpTimeMargin = */ 0.600000F,
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
   /* MotorizedLensType = */ 0,
   /* AutofocusModuleType = */ 0,
   /* FOVNumberOfPositions = */ 0,
   /* FOV1ToLensFOV = */ 255,
   /* FOV2ToLensFOV = */ 255,
   /* FOV3ToLensFOV = */ 255,
   /* FOV4ToLensFOV = */ 255,
   /* LensFOV1DeltaFocusPositionMin = */ 0,
   /* LensFOV1DeltaFocusPositionMax = */ 0,
   /* LensFOV2DeltaFocusPositionMin = */ 0,
   /* LensFOV2DeltaFocusPositionMax = */ 0,
   /* LensFOV3DeltaFocusPositionMin = */ 0,
   /* LensFOV3DeltaFocusPositionMax = */ 0,
   /* LensFOV4DeltaFocusPositionMin = */ 0,
   /* LensFOV4DeltaFocusPositionMax = */ 0,
   /* LensFOV5DeltaFocusPositionMin = */ 0,
   /* LensFOV5DeltaFocusPositionMax = */ 0,
   /* AcquisitionFrameRateMaxDivider = */ 1.0F,
   /* ExposureTimeOffset = */ 0,
   /* FWReferenceTemperatureGain = */ 0.0F,
   /* FWReferenceTemperatureOffset = */ 0.0F,
   /* ExposureTimeMin = */ 0.0F,
   /* ClConfiguration = */ 2,
   /* SaveConfigurationEnabled = */ 0,
   /* FPATemperatureConversionCoef0 = */ 0.0F,
   /* FPATemperatureConversionCoef1 = */ 0.0F,
   /* FPATemperatureConversionCoef2 = */ 0.0F,
   /* FPATemperatureConversionCoef3 = */ 0.0F,
   /* FPATemperatureConversionCoef4 = */ 0.0F,
   /* FPATemperatureConversionCoef5 = */ 0.0F,
   /* ElCorrMeasAtStarvation = */ 0,
   /* ElCorrMeasAtSaturation = */ 0,
   /* ElCorrMeasAtReference1 = */ 0,
   /* ElCorrMeasAtReference2 = */ 0,
   /* FpaScdDiodeBiasEnum = */ 255,
   /* EHDRIDisabled = */ 0,
   /* BufferingDisabled = */ 0,
   /* AdvTrigDisabled = */ 0,
   /* FlaggingDisabled = */ 0,
   /* GatingDisabled = */ 0,
   /* ADCReadoutDisabled = */ 0,
   /* IRIGBDisabled = */ 0,
   /* GPSDisabled = */ 0,
   /* SFWDisabled = */ 0,
   /* SDIDisabled = */ 0,
   /* CenterImageForced = */ 0,
   /* FpaXroDetectSub = */ 2900,
   /* FpaXroCtiaRef = */ 2600,
   /* FpaXroCM = */ 1750,
   /* FpaXroCtiaBiasEnum = */ 15,
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
      memcpy(&hdr->MotorizedLensType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->AutofocusModuleType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FOVNumberOfPositions, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FOV1ToLensFOV, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FOV2ToLensFOV, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FOV3ToLensFOV, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FOV4ToLensFOV, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->LensFOV1DeltaFocusPositionMin, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV1DeltaFocusPositionMax, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV2DeltaFocusPositionMin, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV2DeltaFocusPositionMax, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV3DeltaFocusPositionMin, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV3DeltaFocusPositionMax, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV4DeltaFocusPositionMin, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV4DeltaFocusPositionMax, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV5DeltaFocusPositionMin, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->LensFOV5DeltaFocusPositionMax, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&hdr->AcquisitionFrameRateMaxDivider, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ExposureTimeOffset, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&hdr->FWReferenceTemperatureGain, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FWReferenceTemperatureOffset, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ExposureTimeMin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ClConfiguration, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->SaveConfigurationEnabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 2; // Skip FREE space
      memcpy(&hdr->FPATemperatureConversionCoef0, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FPATemperatureConversionCoef1, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FPATemperatureConversionCoef2, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FPATemperatureConversionCoef3, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FPATemperatureConversionCoef4, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->FPATemperatureConversionCoef5, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
      memcpy(&hdr->ElCorrMeasAtStarvation, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->ElCorrMeasAtSaturation, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->ElCorrMeasAtReference1, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->ElCorrMeasAtReference2, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FpaScdDiodeBiasEnum, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->EHDRIDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->BufferingDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->AdvTrigDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FlaggingDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->GatingDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->ADCReadoutDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->IRIGBDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->GPSDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->SFWDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->SDIDisabled, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->CenterImageForced, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&hdr->FpaXroDetectSub, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FpaXroCtiaRef, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FpaXroCM, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&hdr->FpaXroCtiaBiasEnum, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      numBytes += 57; // Skip FREE space

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
      memcpy(&buffer[numBytes], &hdr->MotorizedLensType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->AutofocusModuleType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FOVNumberOfPositions, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FOV1ToLensFOV, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FOV2ToLensFOV, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FOV3ToLensFOV, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FOV4ToLensFOV, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV1DeltaFocusPositionMin, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV1DeltaFocusPositionMax, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV2DeltaFocusPositionMin, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV2DeltaFocusPositionMax, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV3DeltaFocusPositionMin, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV3DeltaFocusPositionMax, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV4DeltaFocusPositionMin, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV4DeltaFocusPositionMax, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV5DeltaFocusPositionMin, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->LensFOV5DeltaFocusPositionMax, sizeof(int16_t)); numBytes += sizeof(int16_t);
      memcpy(&buffer[numBytes], &hdr->AcquisitionFrameRateMaxDivider, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ExposureTimeOffset, sizeof(int32_t)); numBytes += sizeof(int32_t);
      memcpy(&buffer[numBytes], &hdr->FWReferenceTemperatureGain, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FWReferenceTemperatureOffset, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ExposureTimeMin, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ClConfiguration, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->SaveConfigurationEnabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
      memcpy(&buffer[numBytes], &hdr->FPATemperatureConversionCoef0, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FPATemperatureConversionCoef1, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FPATemperatureConversionCoef2, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FPATemperatureConversionCoef3, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FPATemperatureConversionCoef4, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->FPATemperatureConversionCoef5, sizeof(float)); numBytes += sizeof(float);
      memcpy(&buffer[numBytes], &hdr->ElCorrMeasAtStarvation, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->ElCorrMeasAtSaturation, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->ElCorrMeasAtReference1, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->ElCorrMeasAtReference2, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FpaScdDiodeBiasEnum, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->EHDRIDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->BufferingDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->AdvTrigDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FlaggingDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->GatingDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->ADCReadoutDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->IRIGBDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->GPSDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->SFWDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->SDIDisabled, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->CenterImageForced, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memcpy(&buffer[numBytes], &hdr->FpaXroDetectSub, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FpaXroCtiaRef, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FpaXroCM, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
      memcpy(&buffer[numBytes], &hdr->FpaXroCtiaBiasEnum, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
      memset(&buffer[numBytes], 0, 57); numBytes += 57; // FREE space

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
   FPGA_PRINTF("FileStructureMajorVersion: %u\n", hdr->FileStructureMajorVersion);
   FPGA_PRINTF("FileStructureMinorVersion: %u\n", hdr->FileStructureMinorVersion);
   FPGA_PRINTF("FileStructureSubMinorVersion: %u\n", hdr->FileStructureSubMinorVersion);
   FPGA_PRINTF("FileHeaderLength: %u bytes\n", hdr->FileHeaderLength);
   FPGA_PRINTF("DeviceSerialNumber: %u\n", hdr->DeviceSerialNumber);
   FPGA_PRINTF("DeviceModelName: %s\n", hdr->DeviceModelName);
   FPGA_PRINTF("SensorID: %u\n", hdr->SensorID);
   FPGA_PRINTF("PixelDataResolution: %u bpp\n", hdr->PixelDataResolution);
   FPGA_PRINTF("ReverseX: %u\n", hdr->ReverseX);
   FPGA_PRINTF("ReverseY: %u\n", hdr->ReverseY);
   FPGA_PRINTF("ICUPresent: %u\n", hdr->ICUPresent);
   FPGA_PRINTF("ICUMode: %u\n", hdr->ICUMode);
   FPGA_PRINTF("ICUCalibPosition: %u\n", hdr->ICUCalibPosition);
   FPGA_PRINTF("ICUPulseWidth: %u ms\n", hdr->ICUPulseWidth);
   FPGA_PRINTF("ICUPeriod: %u ms\n", hdr->ICUPeriod);
   FPGA_PRINTF("ICUTransitionDuration: %u ms\n", hdr->ICUTransitionDuration);
   FPGA_PRINTF("ImageCorrectionEnabled: %u\n", hdr->ImageCorrectionEnabled);
   FPGA_PRINTF("ImageCorrectionAtPowerOn: %u\n", hdr->ImageCorrectionAtPowerOn);
   FPGA_PRINTF("ImageCorrectionNumberOfImagesCoadd: %u\n", hdr->ImageCorrectionNumberOfImagesCoadd);
   FPGA_PRINTF("ImageCorrectionAECImageFraction: " _PCF(3) " %%\n", _FFMT(hdr->ImageCorrectionAECImageFraction, 3));
   FPGA_PRINTF("ImageCorrectionAECTargetWellFilling: " _PCF(3) " %%\n", _FFMT(hdr->ImageCorrectionAECTargetWellFilling, 3));
   FPGA_PRINTF("ImageCorrectionAECResponseTime: " _PCF(3) " ms\n", _FFMT(hdr->ImageCorrectionAECResponseTime, 3));
   FPGA_PRINTF("FWPresent: %u\n", hdr->FWPresent);
   FPGA_PRINTF("FWNumberOfFilters: %u\n", hdr->FWNumberOfFilters);
   FPGA_PRINTF("FWType: %u\n", hdr->FWType);
   FPGA_PRINTF("FW0CenterPosition: %d counts\n", hdr->FW0CenterPosition);
   FPGA_PRINTF("FW1CenterPosition: %d counts\n", hdr->FW1CenterPosition);
   FPGA_PRINTF("FW2CenterPosition: %d counts\n", hdr->FW2CenterPosition);
   FPGA_PRINTF("FW3CenterPosition: %d counts\n", hdr->FW3CenterPosition);
   FPGA_PRINTF("FW4CenterPosition: %d counts\n", hdr->FW4CenterPosition);
   FPGA_PRINTF("FW5CenterPosition: %d counts\n", hdr->FW5CenterPosition);
   FPGA_PRINTF("FW6CenterPosition: %d counts\n", hdr->FW6CenterPosition);
   FPGA_PRINTF("FW7CenterPosition: %d counts\n", hdr->FW7CenterPosition);
   FPGA_PRINTF("ImageCorrectionTemperatureSelector: %u\n", hdr->ImageCorrectionTemperatureSelector);
   FPGA_PRINTF("ImageCorrectionDiscardOffset: %u\n", hdr->ImageCorrectionDiscardOffset);
   FPGA_PRINTF("ImageCorrectionWaitTime1: %u ms\n", hdr->ImageCorrectionWaitTime1);
   FPGA_PRINTF("ImageCorrectionTemperatureTolerance1: %d cC\n", hdr->ImageCorrectionTemperatureTolerance1);
   FPGA_PRINTF("ImageCorrectionStabilizationTime1: %u ms\n", hdr->ImageCorrectionStabilizationTime1);
   FPGA_PRINTF("ImageCorrectionTimeout1: %u ms\n", hdr->ImageCorrectionTimeout1);
   FPGA_PRINTF("ImageCorrectionWaitTime2: %u ms\n", hdr->ImageCorrectionWaitTime2);
   FPGA_PRINTF("ImageCorrectionTemperatureTolerance2: %d cC\n", hdr->ImageCorrectionTemperatureTolerance2);
   FPGA_PRINTF("ImageCorrectionStabilizationTime2: %u ms\n", hdr->ImageCorrectionStabilizationTime2);
   FPGA_PRINTF("ImageCorrectionTimeout2: %u ms\n", hdr->ImageCorrectionTimeout2);
   FPGA_PRINTF("DetectorPolarizationVoltage: %d mV\n", hdr->DetectorPolarizationVoltage);
   FPGA_PRINTF("ExternalMemoryBufferPresent: %u\n", hdr->ExternalMemoryBufferPresent);
   FPGA_PRINTF("NDFPresent: %u\n", hdr->NDFPresent);
   FPGA_PRINTF("NDFNumberOfFilters: %u\n", hdr->NDFNumberOfFilters);
   FPGA_PRINTF("NDFClearFOVWidth: %u counts\n", hdr->NDFClearFOVWidth);
   FPGA_PRINTF("NDF0CenterPosition: %d counts\n", hdr->NDF0CenterPosition);
   FPGA_PRINTF("NDF1CenterPosition: %d counts\n", hdr->NDF1CenterPosition);
   FPGA_PRINTF("NDF2CenterPosition: %d counts\n", hdr->NDF2CenterPosition);
   FPGA_PRINTF("FWSpeedMax: %u RPM\n", hdr->FWSpeedMax);
   FPGA_PRINTF("FWEncoderCyclePerTurn: %u counts\n", hdr->FWEncoderCyclePerTurn);
   FPGA_PRINTF("FWOpticalAxisPosX: " _PCF(3) " inches\n", _FFMT(hdr->FWOpticalAxisPosX, 3));
   FPGA_PRINTF("FWOpticalAxisPosY: " _PCF(3) " inches\n", _FFMT(hdr->FWOpticalAxisPosY, 3));
   FPGA_PRINTF("FWMountingHoleRadius: " _PCF(3) " inches\n", _FFMT(hdr->FWMountingHoleRadius, 3));
   FPGA_PRINTF("FWBeamMarging: " _PCF(3) " inches\n", _FFMT(hdr->FWBeamMarging, 3));
   FPGA_PRINTF("FWCornerPixDistX: " _PCF(3) " inches\n", _FFMT(hdr->FWCornerPixDistX, 3));
   FPGA_PRINTF("FWCornerPixDistY: " _PCF(3) " inches\n", _FFMT(hdr->FWCornerPixDistY, 3));
   FPGA_PRINTF("FWCenterPixRadius: " _PCF(3) " inches\n", _FFMT(hdr->FWCenterPixRadius, 3));
   FPGA_PRINTF("FWCornerPixRadius: " _PCF(3) " inches\n", _FFMT(hdr->FWCornerPixRadius, 3));
   FPGA_PRINTF("FWPositionControllerPP: %u\n", hdr->FWPositionControllerPP);
   FPGA_PRINTF("FWPositionControllerPD: %u\n", hdr->FWPositionControllerPD);
   FPGA_PRINTF("FWPositionControllerPOR: %u\n", hdr->FWPositionControllerPOR);
   FPGA_PRINTF("FWPositionControllerI: %u\n", hdr->FWPositionControllerI);
   FPGA_PRINTF("FWSlowSpeedControllerPP: %u\n", hdr->FWSlowSpeedControllerPP);
   FPGA_PRINTF("FWSlowSpeedControllerPD: %u\n", hdr->FWSlowSpeedControllerPD);
   FPGA_PRINTF("FWSlowSpeedControllerPOR: %u\n", hdr->FWSlowSpeedControllerPOR);
   FPGA_PRINTF("FWSlowSpeedControllerPI: %u\n", hdr->FWSlowSpeedControllerPI);
   FPGA_PRINTF("FWFastSpeedControllerPP: %u\n", hdr->FWFastSpeedControllerPP);
   FPGA_PRINTF("FWFastSpeedControllerPD: %u\n", hdr->FWFastSpeedControllerPD);
   FPGA_PRINTF("FWFastSpeedControllerPOR: %u\n", hdr->FWFastSpeedControllerPOR);
   FPGA_PRINTF("FWFastSpeedControllerI: %u\n", hdr->FWFastSpeedControllerI);
   FPGA_PRINTF("FWSpeedControllerSwitchingThreshold: %u RPM\n", hdr->FWSpeedControllerSwitchingThreshold);
   FPGA_PRINTF("FWExposureTimeMaxMargin: " _PCF(3) " %%\n", _FFMT(hdr->FWExposureTimeMaxMargin, 3));
   FPGA_PRINTF("ExternalFanSpeedSetpoint: " _PCF(3) " %%\n", _FFMT(hdr->ExternalFanSpeedSetpoint, 3));
   FPGA_PRINTF("BPDetectionEnabled: %u\n", hdr->BPDetectionEnabled);
   FPGA_PRINTF("BPNumSamples: %u frames\n", hdr->BPNumSamples);
   FPGA_PRINTF("BPFlickerThreshold: " _PCF(3) "\n", _FFMT(hdr->BPFlickerThreshold, 3));
   FPGA_PRINTF("BPNoiseThreshold: " _PCF(3) "\n", _FFMT(hdr->BPNoiseThreshold, 3));
   FPGA_PRINTF("BPDuration: %u ms\n", hdr->BPDuration);
   FPGA_PRINTF("BPNCoadd: %u frames\n", hdr->BPNCoadd);
   FPGA_PRINTF("MaximumTotalFlux: " _PCF(3) " DL/us\n", _FFMT(hdr->MaximumTotalFlux, 3));
   FPGA_PRINTF("FluxRatio01: " _PCF(3) "\n", _FFMT(hdr->FluxRatio01, 3));
   FPGA_PRINTF("FluxRatio12: " _PCF(3) "\n", _FFMT(hdr->FluxRatio12, 3));
   FPGA_PRINTF("AECPlusExpTimeMargin: " _PCF(3) "\n", _FFMT(hdr->AECPlusExpTimeMargin, 3));
   FPGA_PRINTF("AECPlusFluxMargin: " _PCF(3) "\n", _FFMT(hdr->AECPlusFluxMargin, 3));
   FPGA_PRINTF("BPOutlierThreshold: " _PCF(3) "\n", _FFMT(hdr->BPOutlierThreshold, 3));
   FPGA_PRINTF("BPAECImageFraction: " _PCF(3) " %%\n", _FFMT(hdr->BPAECImageFraction, 3));
   FPGA_PRINTF("BPAECWellFilling: " _PCF(3) " %%\n", _FFMT(hdr->BPAECWellFilling, 3));
   FPGA_PRINTF("BPAECResponseTime: " _PCF(3) " ms\n", _FFMT(hdr->BPAECResponseTime, 3));
   FPGA_PRINTF("DeviceKeyExpirationPOSIXTime: %u s\n", hdr->DeviceKeyExpirationPOSIXTime);
   FPGA_PRINTF("DeviceKeyLow: %u\n", hdr->DeviceKeyLow);
   FPGA_PRINTF("DeviceKeyHigh: %u\n", hdr->DeviceKeyHigh);
   FPGA_PRINTF("DetectorElectricalTapsRef: " _PCF(3) " mV\n", _FFMT(hdr->DetectorElectricalTapsRef, 3));
   FPGA_PRINTF("DetectorElectricalRefOffset: " _PCF(3) " mV\n", _FFMT(hdr->DetectorElectricalRefOffset, 3));
   FPGA_PRINTF("ADCReadoutEnabled: %u\n", hdr->ADCReadoutEnabled);
   FPGA_PRINTF("ADCReadout_b: %d counts\n", hdr->ADCReadout_b);
   FPGA_PRINTF("ADCReadout_m: " _PCF(3) " counts/mV\n", _FFMT(hdr->ADCReadout_m, 3));
   FPGA_PRINTF("AECPlusExposureTimeMin: " _PCF(3) " us\n", _FFMT(hdr->AECPlusExposureTimeMin, 3));
   FPGA_PRINTF("AECSaturatedCorrectionFactor: " _PCF(3) "\n", _FFMT(hdr->AECSaturatedCorrectionFactor, 3));
   FPGA_PRINTF("FWFramePeriodMinMargin: " _PCF(3) "\n", _FFMT(hdr->FWFramePeriodMinMargin, 3));
   FPGA_PRINTF("InternalLensThType: %u\n", hdr->InternalLensThType);
   FPGA_PRINTF("ExternalLensThType: %u\n", hdr->ExternalLensThType);
   FPGA_PRINTF("ICUThType: %u\n", hdr->ICUThType);
   FPGA_PRINTF("SFWThType: %u\n", hdr->SFWThType);
   FPGA_PRINTF("CompressorThType: %u\n", hdr->CompressorThType);
   FPGA_PRINTF("ColdfingerThType: %u\n", hdr->ColdfingerThType);
   FPGA_PRINTF("SpareThType: %u\n", hdr->SpareThType);
   FPGA_PRINTF("ExternalTempThType: %u\n", hdr->ExternalTempThType);
   FPGA_PRINTF("XADCRefVoltage1: " _PCF(3) " V\n", _FFMT(hdr->XADCRefVoltage1, 3));
   FPGA_PRINTF("XADCRefVoltage2: " _PCF(3) " V\n", _FFMT(hdr->XADCRefVoltage2, 3));
   FPGA_PRINTF("XADCRefVoltage3: " _PCF(3) " V\n", _FFMT(hdr->XADCRefVoltage3, 3));
   FPGA_PRINTF("SFWOptoswitchPresent: %u\n", hdr->SFWOptoswitchPresent);
   FPGA_PRINTF("MotorizedLensType: %u\n", hdr->MotorizedLensType);
   FPGA_PRINTF("AutofocusModuleType: %u\n", hdr->AutofocusModuleType);
   FPGA_PRINTF("FOVNumberOfPositions: %u\n", hdr->FOVNumberOfPositions);
   FPGA_PRINTF("FOV1ToLensFOV: %u\n", hdr->FOV1ToLensFOV);
   FPGA_PRINTF("FOV2ToLensFOV: %u\n", hdr->FOV2ToLensFOV);
   FPGA_PRINTF("FOV3ToLensFOV: %u\n", hdr->FOV3ToLensFOV);
   FPGA_PRINTF("FOV4ToLensFOV: %u\n", hdr->FOV4ToLensFOV);
   FPGA_PRINTF("LensFOV1DeltaFocusPositionMin: %d counts\n", hdr->LensFOV1DeltaFocusPositionMin);
   FPGA_PRINTF("LensFOV1DeltaFocusPositionMax: %d counts\n", hdr->LensFOV1DeltaFocusPositionMax);
   FPGA_PRINTF("LensFOV2DeltaFocusPositionMin: %d counts\n", hdr->LensFOV2DeltaFocusPositionMin);
   FPGA_PRINTF("LensFOV2DeltaFocusPositionMax: %d counts\n", hdr->LensFOV2DeltaFocusPositionMax);
   FPGA_PRINTF("LensFOV3DeltaFocusPositionMin: %d counts\n", hdr->LensFOV3DeltaFocusPositionMin);
   FPGA_PRINTF("LensFOV3DeltaFocusPositionMax: %d counts\n", hdr->LensFOV3DeltaFocusPositionMax);
   FPGA_PRINTF("LensFOV4DeltaFocusPositionMin: %d counts\n", hdr->LensFOV4DeltaFocusPositionMin);
   FPGA_PRINTF("LensFOV4DeltaFocusPositionMax: %d counts\n", hdr->LensFOV4DeltaFocusPositionMax);
   FPGA_PRINTF("LensFOV5DeltaFocusPositionMin: %d counts\n", hdr->LensFOV5DeltaFocusPositionMin);
   FPGA_PRINTF("LensFOV5DeltaFocusPositionMax: %d counts\n", hdr->LensFOV5DeltaFocusPositionMax);
   FPGA_PRINTF("AcquisitionFrameRateMaxDivider: " _PCF(3) "\n", _FFMT(hdr->AcquisitionFrameRateMaxDivider, 3));
   FPGA_PRINTF("ExposureTimeOffset: %d e-8 s\n", hdr->ExposureTimeOffset);
   FPGA_PRINTF("FWReferenceTemperatureGain: " _PCF(3) " °C/RPM\n", _FFMT(hdr->FWReferenceTemperatureGain, 3));
   FPGA_PRINTF("FWReferenceTemperatureOffset: " _PCF(3) " °C\n", _FFMT(hdr->FWReferenceTemperatureOffset, 3));
   FPGA_PRINTF("ExposureTimeMin: " _PCF(3) " us\n", _FFMT(hdr->ExposureTimeMin, 3));
   FPGA_PRINTF("ClConfiguration: %u\n", hdr->ClConfiguration);
   FPGA_PRINTF("SaveConfigurationEnabled: %u\n", hdr->SaveConfigurationEnabled);
   FPGA_PRINTF("FPATemperatureConversionCoef0: " _PCF(3) " K\n", _FFMT(hdr->FPATemperatureConversionCoef0, 3));
   FPGA_PRINTF("FPATemperatureConversionCoef1: " _PCF(3) " K/V\n", _FFMT(hdr->FPATemperatureConversionCoef1, 3));
   FPGA_PRINTF("FPATemperatureConversionCoef2: " _PCF(3) " K/V^2\n", _FFMT(hdr->FPATemperatureConversionCoef2, 3));
   FPGA_PRINTF("FPATemperatureConversionCoef3: " _PCF(3) " K/V^3\n", _FFMT(hdr->FPATemperatureConversionCoef3, 3));
   FPGA_PRINTF("FPATemperatureConversionCoef4: " _PCF(3) " K/V^4\n", _FFMT(hdr->FPATemperatureConversionCoef4, 3));
   FPGA_PRINTF("FPATemperatureConversionCoef5: " _PCF(3) " K/V^5\n", _FFMT(hdr->FPATemperatureConversionCoef5, 3));
   FPGA_PRINTF("ElCorrMeasAtStarvation: %u counts\n", hdr->ElCorrMeasAtStarvation);
   FPGA_PRINTF("ElCorrMeasAtSaturation: %u counts\n", hdr->ElCorrMeasAtSaturation);
   FPGA_PRINTF("ElCorrMeasAtReference1: %u counts\n", hdr->ElCorrMeasAtReference1);
   FPGA_PRINTF("ElCorrMeasAtReference2: %u counts\n", hdr->ElCorrMeasAtReference2);
   FPGA_PRINTF("FpaScdDiodeBiasEnum: %u\n", hdr->FpaScdDiodeBiasEnum);
   FPGA_PRINTF("EHDRIDisabled: %u\n", hdr->EHDRIDisabled);
   FPGA_PRINTF("BufferingDisabled: %u\n", hdr->BufferingDisabled);
   FPGA_PRINTF("AdvTrigDisabled: %u\n", hdr->AdvTrigDisabled);
   FPGA_PRINTF("FlaggingDisabled: %u\n", hdr->FlaggingDisabled);
   FPGA_PRINTF("GatingDisabled: %u\n", hdr->GatingDisabled);
   FPGA_PRINTF("ADCReadoutDisabled: %u\n", hdr->ADCReadoutDisabled);
   FPGA_PRINTF("IRIGBDisabled: %u\n", hdr->IRIGBDisabled);
   FPGA_PRINTF("GPSDisabled: %u\n", hdr->GPSDisabled);
   FPGA_PRINTF("SFWDisabled: %u\n", hdr->SFWDisabled);
   FPGA_PRINTF("SDIDisabled: %u\n", hdr->SDIDisabled);
   FPGA_PRINTF("CenterImageForced: %u\n", hdr->CenterImageForced);
   FPGA_PRINTF("FpaXroDetectSub: %u mV\n", hdr->FpaXroDetectSub);
   FPGA_PRINTF("FpaXroCtiaRef: %u mV\n", hdr->FpaXroCtiaRef);
   FPGA_PRINTF("FpaXroCM: %u mV\n", hdr->FpaXroCM);
   FPGA_PRINTF("FpaXroCtiaBiasEnum: %u\n", hdr->FpaXroCtiaBiasEnum);
   FPGA_PRINTF("FileHeaderCRC16: %u\n", hdr->FileHeaderCRC16);
}

