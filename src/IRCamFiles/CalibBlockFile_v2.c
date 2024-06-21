/**
 * @file CalibBlockFile_v2.c
 * Camera calibration block file structure v2 definition.
 *
 * This file defines the camera calibration block file structure v2.
 *
 * Auto-generated calibration block file library.
 * Generated from the calibration block file structure definition XLS file version 2.6.0
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

#include "CalibBlockFile_v2.h"
#include "CRC.h"
#include "utils.h"
#include "verbose.h"
#include <string.h>
#include <float.h>

/**
 * BlockFileHeader default values.
 */
CalibBlock_BlockFileHeader_v2_t CalibBlock_BlockFileHeader_v2_default = {
   /* FileSignature = */ "TSBL",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* FileHeaderLength = */ 512,
   /* DeviceSerialNumber = */ 0,
   /* POSIXTime = */ 0,
   /* FileDescription = */ "",
   /* DeviceDataFlowMajorVersion = */ 1,
   /* DeviceDataFlowMinorVersion = */ 1,
   /* SensorID = */ 0,
   /* CalibrationSource = */ 0,
   /* CalibrationType = */ 0,
   /* IntegrationMode = */ 0,
   /* SensorWellDepth = */ 0,
   /* PixelDataResolution = */ 16,
   /* Width = */ 0,
   /* Height = */ 0,
   /* OffsetX = */ 0,
   /* OffsetY = */ 0,
   /* ReverseX = */ 0,
   /* ReverseY = */ 0,
   /* ExternalLensFocalLength = */ 0,
   /* ExternalLensSerialNumber = */ 0,
   /* ExternalLensName = */ "",
   /* ManualFilterSerialNumber = */ 0,
   /* ManualFilterName = */ "",
   /* ExposureTime = */ 0,
   /* AcquisitionFrameRate = */ 0,
   /* FWPosition = */ 0,
   /* NDFPosition = */ 0,
   /* SensorWidth = */ 0,
   /* SensorHeight = */ 0,
   /* PixelDynamicRangeMin = */ 0,
   /* PixelDynamicRangeMax = */ 65535,
   /* SaturationThreshold = */ 65535,
   /* BlockBadPixelCount = */ 0,
   /* MaximumTotalFlux = */ 0.000000F,
   /* NUCMultFactor = */ 1.000000F,
   /* T0 = */ 0,
   /* Nu = */ 1.000000F,
   /* DeviceTemperatureSensor = */ 0,
   /* SpectralResponsePOSIXTime = */ 0,
   /* ReferencePOSIXTime = */ 0,
   /* FWFilterID = */ 0,
   /* NDFilterID = */ 0,
   /* ManualFilterID = */ 0,
   /* LensID = */ 0,
   /* LowCut = */ 0.000000F,
   /* HighCut = */ 0.000000F,
   /* LowReferenceTemperature = */ -273.15F,
   /* HighReferenceTemperature = */ -273.15F,
   /* LowExtrapolationTemperature = */ -273.15F,
   /* HighExtrapolationTemperature = */ -273.15F,
   /* FluxOffset = */ 0.000000F,
   /* FluxSaturation = */ 0.000000F,
   /* LowExtrapolationFactor = */ 0.000000F,
   /* HighExtrapolationFactor = */ 0.000000F,
   /* LowValidTemperature = */ -273.15F,
   /* HighValidTemperature = */ -273.15F,
   /* BinningMode = */ 0,
   /* FOVPosition = */ 255,
   /* FocusPositionRaw = */ 0,
   /* ImageCorrectionFocusPositionRaw = */ 0,
   /* ExternalLensMagnification = */ 0.000000F,
   /* SensorPixelPitch = */ 0,
   /* CompensatedBlock = */ 0,
   /* CalibrationReferenceSourceID = */ 0,
   /* CalibrationReferenceSourceEmissivity = */ 1.000000F,
   /* CalibrationReferenceSourceDistance = */ 0.000000F,
   /* CalibrationChamberTemperature = */ 25.000000F,
   /* CalibrationChamberRelativeHumidity = */ 0.000000F,
   /* CalibrationChamberCO2MixingRatio = */ 0.000000F,
   /* SSEParameter1 = */ 1.000000F,
   /* SSEParameter2 = */ 0.000000F,
   /* SSEParameter3 = */ 1.000000F,
   /* SSEModel = */ 0,
   /* SensorIDMSB = */ 0,
   /* ExtenderRingID = */ 0,
   /* ExtenderRingSerialNumber = */ 0,
   /* ExtenderRingName = */ "",
   /* FNumber = */ 0.000000F,
   /* CompressionAlgorithm = */ 0,
   /* CompressionParameter = */ 0.000000F,
   /* CalibrationROI = */ 100.000000F,
   /* CalibrationMethod = */ 0,
   /* PixelDataPresence = */ 0,
   /* MaxTKDataPresence = */ 0,
   /* LUTNLDataPresence = */ 0,
   /* LUTRQDataPresence = */ 0,
   /* NumberOfLUTRQ = */ 0,
   /* KPixDataPresence = */ 0,
   /* FileHeaderCRC16 = */ 0,
};

/**
 * PixelDataHeader default values.
 */
CalibBlock_PixelDataHeader_v2_t CalibBlock_PixelDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* Offset_Off = */ 0.000000F,
   /* Offset_Median = */ 0.000000F,
   /* Offset_Exp = */ 0,
   /* Offset_Nbits = */ 12,
   /* Offset_Signed = */ 0,
   /* Range_Off = */ 0.000000F,
   /* Range_Median = */ 0.000000F,
   /* Range_Exp = */ 0,
   /* Range_Nbits = */ 12,
   /* Range_Signed = */ 0,
   /* Kappa_Off = */ 0.000000F,
   /* Kappa_Median = */ 0.000000F,
   /* Kappa_Exp = */ 0,
   /* Kappa_Nbits = */ 10,
   /* Kappa_Signed = */ 0,
   /* Beta0_Off = */ 0.000000F,
   /* Beta0_Median = */ 0.000000F,
   /* Beta0_Exp = */ 0,
   /* Beta0_Nbits = */ 11,
   /* Beta0_Signed = */ 1,
   /* Alpha_Off = */ 0.000000F,
   /* Alpha_Median = */ 0.000000F,
   /* Alpha_Exp = */ 0,
   /* Alpha_Nbits = */ 12,
   /* Alpha_Signed = */ 0,
   /* LUTNLIndex_Nbits = */ 6,
   /* LUTNLIndex_Signed = */ 0,
   /* BadPixel_Nbits = */ 1,
   /* BadPixel_Signed = */ 0,
   /* PixelDataLength = */ 0,
   /* PixelDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * MaxTKDataHeader default values.
 */
CalibBlock_MaxTKDataHeader_v2_t CalibBlock_MaxTKDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* TCalMin = */ 0.000000F,
   /* TCalMax = */ 0.000000F,
   /* TCalMinExpTimeMin = */ 0.000000F,
   /* TCalMinExpTimeMax = */ 0.000000F,
   /* TCalMaxExpTimeMin = */ 0.000000F,
   /* TCalMaxExpTimeMax = */ 0.000000F,
   /* TvsINT_FitOrder = */ 0,
   /* INTvsT_FitOrder = */ 0,
   /* MaxTKDataLength = */ 0,
   /* MaxTKDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * LUTNLDataHeader default values.
 */
CalibBlock_LUTNLDataHeader_v2_t CalibBlock_LUTNLDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* LUT_Xmin = */ 0.000000F,
   /* LUT_Xrange = */ 0.000000F,
   /* LUT_Size = */ 0,
   /* M_Exp = */ 0,
   /* B_Exp = */ 0,
   /* M_Nbits = */ 16,
   /* B_Nbits = */ 16,
   /* M_Signed = */ 0,
   /* B_Signed = */ 0,
   /* NumberOfLUTNL = */ 0,
   /* LUTNLDataLength = */ 0,
   /* LUTNLDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * LUTRQDataHeader default values.
 */
CalibBlock_LUTRQDataHeader_v2_t CalibBlock_LUTRQDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* LUT_Xmin = */ 0.000000F,
   /* LUT_Xrange = */ 0.000000F,
   /* LUT_Size = */ 0,
   /* M_Exp = */ 0,
   /* B_Exp = */ 0,
   /* Data_Off = */ 0.000000F,
   /* Data_Exp = */ 1,
   /* RadiometricQuantityType = */ 0,
   /* M_Nbits = */ 16,
   /* B_Nbits = */ 16,
   /* M_Signed = */ 0,
   /* B_Signed = */ 0,
   /* LUTRQDataLength = */ 0,
   /* LUTRQDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * KPixDataHeader default values.
 */
CalibBlock_KPixDataHeader_v2_t CalibBlock_KPixDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* KPix_Median = */ 32768,
   /* KPix_Nbits = */ 16,
   /* KPix_EffectiveBitWidth = */ 13,
   /* KPix_Signed = */ 1,
   /* KPixDataLength = */ 0,
   /* KPixDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * BlockFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseBlockFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_BlockFileHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSBL") != 0)
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

   if (hdr->FileHeaderLength != CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2)
   {
      // File header length mismatch
      return 0;
   }

   memcpy(&hdr->DeviceSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->POSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->FileDescription, &buffer[numBytes], 64); numBytes += 64;
   hdr->FileDescription[64] = '\0';
   memcpy(&hdr->DeviceDataFlowMajorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->DeviceDataFlowMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorID, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationSource, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->IntegrationMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorWellDepth, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->PixelDataResolution, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Width, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->Height, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetX, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetY, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ReverseX, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->ReverseY, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->ExternalLensFocalLength, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ExternalLensSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ExternalLensName, &buffer[numBytes], 64); numBytes += 64;
   hdr->ExternalLensName[64] = '\0';
   memcpy(&hdr->ManualFilterSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ManualFilterName, &buffer[numBytes], 64); numBytes += 64;
   hdr->ManualFilterName[64] = '\0';
   memcpy(&hdr->ExposureTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->AcquisitionFrameRate, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FWPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NDFPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorWidth, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->SensorHeight, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->PixelDynamicRangeMin, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->PixelDynamicRangeMax, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->SaturationThreshold, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->BlockBadPixelCount, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->MaximumTotalFlux, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->NUCMultFactor, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->T0, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&hdr->Nu, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->DeviceTemperatureSensor, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&hdr->SpectralResponsePOSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->ReferencePOSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FWFilterID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->NDFilterID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ManualFilterID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->LensID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->LowCut, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->HighCut, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LowReferenceTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->HighReferenceTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LowExtrapolationTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->HighExtrapolationTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->FluxOffset, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->FluxSaturation, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LowExtrapolationFactor, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->HighExtrapolationFactor, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LowValidTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->HighValidTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->BinningMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FOVPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FocusPositionRaw, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&hdr->ImageCorrectionFocusPositionRaw, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&hdr->ExternalLensMagnification, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->SensorPixelPitch, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CompensatedBlock, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationReferenceSourceID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->CalibrationReferenceSourceEmissivity, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->CalibrationReferenceSourceDistance, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->CalibrationChamberTemperature, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->CalibrationChamberRelativeHumidity, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->CalibrationChamberCO2MixingRatio, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->SSEParameter1, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->SSEParameter2, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->SSEParameter3, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->SSEModel, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorIDMSB, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->ExtenderRingID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ExtenderRingSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ExtenderRingName, &buffer[numBytes], 64); numBytes += 64;
   hdr->ExtenderRingName[64] = '\0';
   memcpy(&hdr->FNumber, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   numBytes += 3; // Skip FREE space
   memcpy(&hdr->CompressionAlgorithm, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CompressionParameter, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->CalibrationROI, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->CalibrationMethod, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 13; // Skip FREE space
   memcpy(&hdr->PixelDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->MaxTKDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTRQDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NumberOfLUTRQ, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->KPixDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->FileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->FileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * BlockFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteBlockFileHeader_v2(CalibBlock_BlockFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSBL", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBBLOCK_FILEMAJORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBBLOCK_FILEMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBBLOCK_FILESUBMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->FileHeaderLength = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->FileDescription, 64); numBytes += 64;

   hdr->DeviceDataFlowMajorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->DeviceDataFlowMinorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationSource, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->IntegrationMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorWellDepth, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->PixelDataResolution, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Width, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->Height, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->OffsetX, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->OffsetY, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ReverseX, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->ReverseY, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->ExternalLensFocalLength, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ExternalLensSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->ExternalLensName, 64); numBytes += 64;
   memcpy(&buffer[numBytes], &hdr->ManualFilterSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->ManualFilterName, 64); numBytes += 64;
   memcpy(&buffer[numBytes], &hdr->ExposureTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->AcquisitionFrameRate, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->FWPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->NDFPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorWidth, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->SensorHeight, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->PixelDynamicRangeMin, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->PixelDynamicRangeMax, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->SaturationThreshold, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->BlockBadPixelCount, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->MaximumTotalFlux, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->NUCMultFactor, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->T0, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&buffer[numBytes], &hdr->Nu, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->DeviceTemperatureSensor, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&buffer[numBytes], &hdr->SpectralResponsePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->FWFilterID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->NDFilterID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ManualFilterID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->LensID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->LowCut, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->HighCut, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LowReferenceTemperature, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->HighReferenceTemperature, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LowExtrapolationTemperature, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->HighExtrapolationTemperature, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->FluxOffset, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->FluxSaturation, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LowExtrapolationFactor, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->HighExtrapolationFactor, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LowValidTemperature, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->HighValidTemperature, sizeof(float)); numBytes += sizeof(float);
   memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
   memcpy(&buffer[numBytes], &hdr->BinningMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FOVPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FocusPositionRaw, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&buffer[numBytes], &hdr->ImageCorrectionFocusPositionRaw, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&buffer[numBytes], &hdr->ExternalLensMagnification, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->SensorPixelPitch, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CompensatedBlock, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationReferenceSourceID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationReferenceSourceEmissivity, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->CalibrationReferenceSourceDistance, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->CalibrationChamberTemperature, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->CalibrationChamberRelativeHumidity, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->CalibrationChamberCO2MixingRatio, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->SSEParameter1, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->SSEParameter2, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->SSEParameter3, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->SSEModel, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorIDMSB, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->ExtenderRingID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ExtenderRingSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->ExtenderRingName, 64); numBytes += 64;
   memcpy(&buffer[numBytes], &hdr->FNumber, sizeof(float)); numBytes += sizeof(float);
   memset(&buffer[numBytes], 0, 3); numBytes += 3; // FREE space
   memcpy(&buffer[numBytes], &hdr->CompressionAlgorithm, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CompressionParameter, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->CalibrationROI, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->CalibrationMethod, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 13); numBytes += 13; // FREE space
   memcpy(&buffer[numBytes], &hdr->PixelDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->MaxTKDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->LUTNLDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->LUTRQDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->NumberOfLUTRQ, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->KPixDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * BlockFileHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibBlock_PrintBlockFileHeader_v2(CalibBlock_BlockFileHeader_v2_t *hdr)
{
   FPGA_PRINTF("FileSignature: %s\n", hdr->FileSignature);
   FPGA_PRINTF("FileStructureMajorVersion: %u\n", hdr->FileStructureMajorVersion);
   FPGA_PRINTF("FileStructureMinorVersion: %u\n", hdr->FileStructureMinorVersion);
   FPGA_PRINTF("FileStructureSubMinorVersion: %u\n", hdr->FileStructureSubMinorVersion);
   FPGA_PRINTF("FileHeaderLength: %u bytes\n", hdr->FileHeaderLength);
   FPGA_PRINTF("DeviceSerialNumber: %u\n", hdr->DeviceSerialNumber);
   FPGA_PRINTF("POSIXTime: %u s\n", hdr->POSIXTime);
   FPGA_PRINTF("FileDescription: %s\n", hdr->FileDescription);
   FPGA_PRINTF("DeviceDataFlowMajorVersion: %u\n", hdr->DeviceDataFlowMajorVersion);
   FPGA_PRINTF("DeviceDataFlowMinorVersion: %u\n", hdr->DeviceDataFlowMinorVersion);
   FPGA_PRINTF("SensorID: %u\n", hdr->SensorID);
   FPGA_PRINTF("CalibrationSource: %u enum\n", hdr->CalibrationSource);
   FPGA_PRINTF("CalibrationType: %u enum\n", hdr->CalibrationType);
   FPGA_PRINTF("IntegrationMode: %u enum\n", hdr->IntegrationMode);
   FPGA_PRINTF("SensorWellDepth: %u enum\n", hdr->SensorWellDepth);
   FPGA_PRINTF("PixelDataResolution: %u bits\n", hdr->PixelDataResolution);
   FPGA_PRINTF("Width: %u pixels\n", hdr->Width);
   FPGA_PRINTF("Height: %u pixels\n", hdr->Height);
   FPGA_PRINTF("OffsetX: %u pixels\n", hdr->OffsetX);
   FPGA_PRINTF("OffsetY: %u pixels\n", hdr->OffsetY);
   FPGA_PRINTF("ReverseX: %u 0 / 1\n", hdr->ReverseX);
   FPGA_PRINTF("ReverseY: %u 0 / 1\n", hdr->ReverseY);
   FPGA_PRINTF("ExternalLensFocalLength: %u mm\n", hdr->ExternalLensFocalLength);
   FPGA_PRINTF("ExternalLensSerialNumber: %u\n", hdr->ExternalLensSerialNumber);
   FPGA_PRINTF("ExternalLensName: %s\n", hdr->ExternalLensName);
   FPGA_PRINTF("ManualFilterSerialNumber: %u\n", hdr->ManualFilterSerialNumber);
   FPGA_PRINTF("ManualFilterName: %s\n", hdr->ManualFilterName);
   FPGA_PRINTF("ExposureTime: %u 1e-8 s\n", hdr->ExposureTime);
   FPGA_PRINTF("AcquisitionFrameRate: %u mHz\n", hdr->AcquisitionFrameRate);
   FPGA_PRINTF("FWPosition: %u enum\n", hdr->FWPosition);
   FPGA_PRINTF("NDFPosition: %u enum\n", hdr->NDFPosition);
   FPGA_PRINTF("SensorWidth: %u pixels\n", hdr->SensorWidth);
   FPGA_PRINTF("SensorHeight: %u pixels\n", hdr->SensorHeight);
   FPGA_PRINTF("PixelDynamicRangeMin: %u DL\n", hdr->PixelDynamicRangeMin);
   FPGA_PRINTF("PixelDynamicRangeMax: %u DL\n", hdr->PixelDynamicRangeMax);
   FPGA_PRINTF("SaturationThreshold: %u DL\n", hdr->SaturationThreshold);
   FPGA_PRINTF("BlockBadPixelCount: %u pixels\n", hdr->BlockBadPixelCount);
   FPGA_PRINTF("MaximumTotalFlux: " _PCF(3) " DL/us\n", _FFMT(hdr->MaximumTotalFlux, 3));
   FPGA_PRINTF("NUCMultFactor: " _PCF(3) "\n", _FFMT(hdr->NUCMultFactor, 3));
   FPGA_PRINTF("T0: %d cC\n", hdr->T0);
   FPGA_PRINTF("Nu: " _PCF(3) "\n", _FFMT(hdr->Nu, 3));
   FPGA_PRINTF("DeviceTemperatureSensor: %d cC\n", hdr->DeviceTemperatureSensor);
   FPGA_PRINTF("SpectralResponsePOSIXTime: %u s\n", hdr->SpectralResponsePOSIXTime);
   FPGA_PRINTF("ReferencePOSIXTime: %u s\n", hdr->ReferencePOSIXTime);
   FPGA_PRINTF("FWFilterID: %u\n", hdr->FWFilterID);
   FPGA_PRINTF("NDFilterID: %u\n", hdr->NDFilterID);
   FPGA_PRINTF("ManualFilterID: %u\n", hdr->ManualFilterID);
   FPGA_PRINTF("LensID: %u\n", hdr->LensID);
   FPGA_PRINTF("LowCut: " _PCF(3) " um\n", _FFMT(hdr->LowCut, 3));
   FPGA_PRINTF("HighCut: " _PCF(3) " um\n", _FFMT(hdr->HighCut, 3));
   FPGA_PRINTF("LowReferenceTemperature: " _PCF(3) " °C\n", _FFMT(hdr->LowReferenceTemperature, 3));
   FPGA_PRINTF("HighReferenceTemperature: " _PCF(3) " °C\n", _FFMT(hdr->HighReferenceTemperature, 3));
   FPGA_PRINTF("LowExtrapolationTemperature: " _PCF(3) " °C\n", _FFMT(hdr->LowExtrapolationTemperature, 3));
   FPGA_PRINTF("HighExtrapolationTemperature: " _PCF(3) " °C\n", _FFMT(hdr->HighExtrapolationTemperature, 3));
   FPGA_PRINTF("FluxOffset: " _PCF(3) " DL/us\n", _FFMT(hdr->FluxOffset, 3));
   FPGA_PRINTF("FluxSaturation: " _PCF(3) " DL/us\n", _FFMT(hdr->FluxSaturation, 3));
   FPGA_PRINTF("LowExtrapolationFactor: " _PCF(3) "\n", _FFMT(hdr->LowExtrapolationFactor, 3));
   FPGA_PRINTF("HighExtrapolationFactor: " _PCF(3) "\n", _FFMT(hdr->HighExtrapolationFactor, 3));
   FPGA_PRINTF("LowValidTemperature: " _PCF(3) " °C\n", _FFMT(hdr->LowValidTemperature, 3));
   FPGA_PRINTF("HighValidTemperature: " _PCF(3) " °C\n", _FFMT(hdr->HighValidTemperature, 3));
   FPGA_PRINTF("BinningMode: %u enum\n", hdr->BinningMode);
   FPGA_PRINTF("FOVPosition: %u enum\n", hdr->FOVPosition);
   FPGA_PRINTF("FocusPositionRaw: %d counts\n", hdr->FocusPositionRaw);
   FPGA_PRINTF("ImageCorrectionFocusPositionRaw: %d counts\n", hdr->ImageCorrectionFocusPositionRaw);
   FPGA_PRINTF("ExternalLensMagnification: " _PCF(3) "\n", _FFMT(hdr->ExternalLensMagnification, 3));
   FPGA_PRINTF("SensorPixelPitch: %u um\n", hdr->SensorPixelPitch);
   FPGA_PRINTF("CompensatedBlock: %u 0 / 1\n", hdr->CompensatedBlock);
   FPGA_PRINTF("CalibrationReferenceSourceID: %u\n", hdr->CalibrationReferenceSourceID);
   FPGA_PRINTF("CalibrationReferenceSourceEmissivity: " _PCF(3) "\n", _FFMT(hdr->CalibrationReferenceSourceEmissivity, 3));
   FPGA_PRINTF("CalibrationReferenceSourceDistance: " _PCF(3) " m\n", _FFMT(hdr->CalibrationReferenceSourceDistance, 3));
   FPGA_PRINTF("CalibrationChamberTemperature: " _PCF(3) " °C\n", _FFMT(hdr->CalibrationChamberTemperature, 3));
   FPGA_PRINTF("CalibrationChamberRelativeHumidity: " _PCF(3) " %%\n", _FFMT(hdr->CalibrationChamberRelativeHumidity, 3));
   FPGA_PRINTF("CalibrationChamberCO2MixingRatio: " _PCF(3) " ppm\n", _FFMT(hdr->CalibrationChamberCO2MixingRatio, 3));
   FPGA_PRINTF("SSEParameter1: " _PCF(3) "\n", _FFMT(hdr->SSEParameter1, 3));
   FPGA_PRINTF("SSEParameter2: " _PCF(3) "\n", _FFMT(hdr->SSEParameter2, 3));
   FPGA_PRINTF("SSEParameter3: " _PCF(3) "\n", _FFMT(hdr->SSEParameter3, 3));
   FPGA_PRINTF("SSEModel: %u enum\n", hdr->SSEModel);
   FPGA_PRINTF("SensorIDMSB: %u\n", hdr->SensorIDMSB);
   FPGA_PRINTF("ExtenderRingID: %u\n", hdr->ExtenderRingID);
   FPGA_PRINTF("ExtenderRingSerialNumber: %u\n", hdr->ExtenderRingSerialNumber);
   FPGA_PRINTF("ExtenderRingName: %s\n", hdr->ExtenderRingName);
   FPGA_PRINTF("FNumber: " _PCF(3) "\n", _FFMT(hdr->FNumber, 3));
   FPGA_PRINTF("CompressionAlgorithm: %u enum\n", hdr->CompressionAlgorithm);
   FPGA_PRINTF("CompressionParameter: " _PCF(3) "\n", _FFMT(hdr->CompressionParameter, 3));
   FPGA_PRINTF("CalibrationROI: " _PCF(3) " %%\n", _FFMT(hdr->CalibrationROI, 3));
   FPGA_PRINTF("CalibrationMethod: %u enum\n", hdr->CalibrationMethod);
   FPGA_PRINTF("PixelDataPresence: %u 0 / 1\n", hdr->PixelDataPresence);
   FPGA_PRINTF("MaxTKDataPresence: %u 0 / 1\n", hdr->MaxTKDataPresence);
   FPGA_PRINTF("LUTNLDataPresence: %u 0 / 1\n", hdr->LUTNLDataPresence);
   FPGA_PRINTF("LUTRQDataPresence: %u 0 / 1\n", hdr->LUTRQDataPresence);
   FPGA_PRINTF("NumberOfLUTRQ: %u\n", hdr->NumberOfLUTRQ);
   FPGA_PRINTF("KPixDataPresence: %u 0 / 1\n", hdr->KPixDataPresence);
   FPGA_PRINTF("FileHeaderCRC16: %u\n", hdr->FileHeaderCRC16);
}

/**
 * PixelDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParsePixelDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_PIXELDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBBLOCK_PIXELDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->Offset_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Offset_Median, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Offset_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Offset_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Offset_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Range_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Range_Median, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Range_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Range_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Range_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Kappa_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Kappa_Median, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Kappa_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Kappa_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Kappa_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Beta0_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Median, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Beta0_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Beta0_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Alpha_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Alpha_Median, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Alpha_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Alpha_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Alpha_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->LUTNLIndex_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLIndex_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->BadPixel_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->BadPixel_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 178; // Skip FREE space
   memcpy(&hdr->PixelDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->PixelDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * PixelDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WritePixelDataHeader_v2(CalibBlock_PixelDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_PIXELDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBBLOCK_PIXELDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->Offset_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Offset_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Offset_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Offset_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Offset_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->Range_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Range_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Range_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Range_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Range_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->Kappa_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Kappa_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Kappa_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Kappa_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Kappa_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->Beta0_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Beta0_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Beta0_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->Alpha_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Alpha_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Alpha_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Alpha_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Alpha_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->LUTNLIndex_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->LUTNLIndex_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
   memcpy(&buffer[numBytes], &hdr->BadPixel_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->BadPixel_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 178); numBytes += 178; // FREE space
   memcpy(&buffer[numBytes], &hdr->PixelDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->PixelDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * PixelDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibBlock_PrintPixelDataHeader_v2(CalibBlock_PixelDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %u bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("Offset_Off: " _PCF(3) "\n", _FFMT(hdr->Offset_Off, 3));
   FPGA_PRINTF("Offset_Median: " _PCF(3) "\n", _FFMT(hdr->Offset_Median, 3));
   FPGA_PRINTF("Offset_Exp: %d\n", hdr->Offset_Exp);
   FPGA_PRINTF("Offset_Nbits: %u bits\n", hdr->Offset_Nbits);
   FPGA_PRINTF("Offset_Signed: %u 0 / 1\n", hdr->Offset_Signed);
   FPGA_PRINTF("Range_Off: " _PCF(3) "\n", _FFMT(hdr->Range_Off, 3));
   FPGA_PRINTF("Range_Median: " _PCF(3) "\n", _FFMT(hdr->Range_Median, 3));
   FPGA_PRINTF("Range_Exp: %d\n", hdr->Range_Exp);
   FPGA_PRINTF("Range_Nbits: %u bits\n", hdr->Range_Nbits);
   FPGA_PRINTF("Range_Signed: %u 0 / 1\n", hdr->Range_Signed);
   FPGA_PRINTF("Kappa_Off: " _PCF(3) "\n", _FFMT(hdr->Kappa_Off, 3));
   FPGA_PRINTF("Kappa_Median: " _PCF(3) "\n", _FFMT(hdr->Kappa_Median, 3));
   FPGA_PRINTF("Kappa_Exp: %d\n", hdr->Kappa_Exp);
   FPGA_PRINTF("Kappa_Nbits: %u bits\n", hdr->Kappa_Nbits);
   FPGA_PRINTF("Kappa_Signed: %u 0 / 1\n", hdr->Kappa_Signed);
   FPGA_PRINTF("Beta0_Off: " _PCF(3) "\n", _FFMT(hdr->Beta0_Off, 3));
   FPGA_PRINTF("Beta0_Median: " _PCF(3) "\n", _FFMT(hdr->Beta0_Median, 3));
   FPGA_PRINTF("Beta0_Exp: %d\n", hdr->Beta0_Exp);
   FPGA_PRINTF("Beta0_Nbits: %u bits\n", hdr->Beta0_Nbits);
   FPGA_PRINTF("Beta0_Signed: %u 0 / 1\n", hdr->Beta0_Signed);
   FPGA_PRINTF("Alpha_Off: " _PCF(3) "\n", _FFMT(hdr->Alpha_Off, 3));
   FPGA_PRINTF("Alpha_Median: " _PCF(3) "\n", _FFMT(hdr->Alpha_Median, 3));
   FPGA_PRINTF("Alpha_Exp: %d\n", hdr->Alpha_Exp);
   FPGA_PRINTF("Alpha_Nbits: %u bits\n", hdr->Alpha_Nbits);
   FPGA_PRINTF("Alpha_Signed: %u 0 / 1\n", hdr->Alpha_Signed);
   FPGA_PRINTF("LUTNLIndex_Nbits: %u bits\n", hdr->LUTNLIndex_Nbits);
   FPGA_PRINTF("LUTNLIndex_Signed: %u 0 / 1\n", hdr->LUTNLIndex_Signed);
   FPGA_PRINTF("BadPixel_Nbits: %u bits\n", hdr->BadPixel_Nbits);
   FPGA_PRINTF("BadPixel_Signed: %u 0 / 1\n", hdr->BadPixel_Signed);
   FPGA_PRINTF("PixelDataLength: %u bytes\n", hdr->PixelDataLength);
   FPGA_PRINTF("PixelDataCRC16: %u\n", hdr->PixelDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %u\n", hdr->DataHeaderCRC16);
}

/**
 * PixelData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParsePixelData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint64_t rawData;

   if (buflen < CALIBBLOCK_PIXELDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint64_t)); numBytes += sizeof(uint64_t);

   data->Offset = ((rawData & CALIBBLOCK_PIXELDATA_OFFSET_MASK_V2) >> CALIBBLOCK_PIXELDATA_OFFSET_SHIFT_V2);
   data->Range = ((rawData & CALIBBLOCK_PIXELDATA_RANGE_MASK_V2) >> CALIBBLOCK_PIXELDATA_RANGE_SHIFT_V2);
   data->LUTNLIndex = ((rawData & CALIBBLOCK_PIXELDATA_LUTNLINDEX_MASK_V2) >> CALIBBLOCK_PIXELDATA_LUTNLINDEX_SHIFT_V2);
   data->Kappa = ((rawData & CALIBBLOCK_PIXELDATA_KAPPA_MASK_V2) >> CALIBBLOCK_PIXELDATA_KAPPA_SHIFT_V2);
   data->Beta0 = ((rawData & CALIBBLOCK_PIXELDATA_BETA0_MASK_V2) >> CALIBBLOCK_PIXELDATA_BETA0_SHIFT_V2);
   if ((data->Beta0 & CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS_V2) == CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS_V2)
   {
      // Sign extension
      data->Beta0 |= 0xF800;
   }
   data->Alpha = ((rawData & CALIBBLOCK_PIXELDATA_ALPHA_MASK_V2) >> CALIBBLOCK_PIXELDATA_ALPHA_SHIFT_V2);
   data->BadPixel = ((rawData & CALIBBLOCK_PIXELDATA_BADPIXEL_MASK_V2) >> CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT_V2);

   return numBytes;
}

/**
 * PixelData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WritePixelData_v2(CalibBlock_PixelData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint64_t tmpData;
   uint64_t rawData = 0;

   if (buflen < CALIBBLOCK_PIXELDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->Offset;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_OFFSET_SHIFT_V2) & CALIBBLOCK_PIXELDATA_OFFSET_MASK_V2);
   tmpData = data->Range;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_RANGE_SHIFT_V2) & CALIBBLOCK_PIXELDATA_RANGE_MASK_V2);
   tmpData = data->LUTNLIndex;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_LUTNLINDEX_SHIFT_V2) & CALIBBLOCK_PIXELDATA_LUTNLINDEX_MASK_V2);
   tmpData = data->Kappa;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_KAPPA_SHIFT_V2) & CALIBBLOCK_PIXELDATA_KAPPA_MASK_V2);
   tmpData = data->Beta0;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_BETA0_SHIFT_V2) & CALIBBLOCK_PIXELDATA_BETA0_MASK_V2);
   tmpData = data->Alpha;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_ALPHA_SHIFT_V2) & CALIBBLOCK_PIXELDATA_ALPHA_MASK_V2);
   tmpData = data->BadPixel;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT_V2) & CALIBBLOCK_PIXELDATA_BADPIXEL_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint64_t)); numBytes += sizeof(uint64_t);

   return numBytes;
}

/**
 * MaxTKDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseMaxTKDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_MaxTKDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->TCalMin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMax, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMinExpTimeMin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMinExpTimeMax, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMaxExpTimeMin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMaxExpTimeMax, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TvsINT_FitOrder, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->INTvsT_FitOrder, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 218; // Skip FREE space
   memcpy(&hdr->MaxTKDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->MaxTKDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * MaxTKDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteMaxTKDataHeader_v2(CalibBlock_MaxTKDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->TCalMin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TCalMax, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TCalMinExpTimeMin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TCalMinExpTimeMax, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TCalMaxExpTimeMin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TCalMaxExpTimeMax, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TvsINT_FitOrder, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->INTvsT_FitOrder, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 218); numBytes += 218; // FREE space
   memcpy(&buffer[numBytes], &hdr->MaxTKDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->MaxTKDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * MaxTKDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibBlock_PrintMaxTKDataHeader_v2(CalibBlock_MaxTKDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %u bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("TCalMin: " _PCF(3) " K\n", _FFMT(hdr->TCalMin, 3));
   FPGA_PRINTF("TCalMax: " _PCF(3) " K\n", _FFMT(hdr->TCalMax, 3));
   FPGA_PRINTF("TCalMinExpTimeMin: " _PCF(3) " us\n", _FFMT(hdr->TCalMinExpTimeMin, 3));
   FPGA_PRINTF("TCalMinExpTimeMax: " _PCF(3) " us\n", _FFMT(hdr->TCalMinExpTimeMax, 3));
   FPGA_PRINTF("TCalMaxExpTimeMin: " _PCF(3) " us\n", _FFMT(hdr->TCalMaxExpTimeMin, 3));
   FPGA_PRINTF("TCalMaxExpTimeMax: " _PCF(3) " us\n", _FFMT(hdr->TCalMaxExpTimeMax, 3));
   FPGA_PRINTF("TvsINT_FitOrder: %u\n", hdr->TvsINT_FitOrder);
   FPGA_PRINTF("INTvsT_FitOrder: %u\n", hdr->INTvsT_FitOrder);
   FPGA_PRINTF("MaxTKDataLength: %u bytes\n", hdr->MaxTKDataLength);
   FPGA_PRINTF("MaxTKDataCRC16: %u\n", hdr->MaxTKDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %u\n", hdr->DataHeaderCRC16);
}

/**
 * MaxTKData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseMaxTKData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_MaxTKData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBBLOCK_MAXTKDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->MaxTK_Data = ((rawData & CALIBBLOCK_MAXTKDATA_MAXTK_DATA_MASK_V2) >> CALIBBLOCK_MAXTKDATA_MAXTK_DATA_SHIFT_V2);
   if ((data->MaxTK_Data & CALIBBLOCK_MAXTKDATA_MAXTK_DATA_SIGNPOS_V2) == CALIBBLOCK_MAXTKDATA_MAXTK_DATA_SIGNPOS_V2)
   {
      // Sign extension
      data->MaxTK_Data |= 0x00000000;
   }

   return numBytes;
}

/**
 * MaxTKData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteMaxTKData_v2(CalibBlock_MaxTKData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBBLOCK_MAXTKDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->MaxTK_Data;
   rawData |= ((tmpData << CALIBBLOCK_MAXTKDATA_MAXTK_DATA_SHIFT_V2) & CALIBBLOCK_MAXTKDATA_MAXTK_DATA_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

/**
 * LUTNLDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseLUTNLDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->LUT_Xmin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Xrange, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Size, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->M_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->B_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->M_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->M_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 227; // Skip FREE space
   memcpy(&hdr->NumberOfLUTNL, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->LUTNLDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * LUTNLDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteLUTNLDataHeader_v2(CalibBlock_LUTNLDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->LUT_Xmin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LUT_Xrange, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LUT_Size, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->M_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->B_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->M_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->B_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->M_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->B_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 227); numBytes += 227; // FREE space
   memcpy(&buffer[numBytes], &hdr->NumberOfLUTNL, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->LUTNLDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->LUTNLDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * LUTNLDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibBlock_PrintLUTNLDataHeader_v2(CalibBlock_LUTNLDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %u bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("LUT_Xmin: " _PCF(3) "\n", _FFMT(hdr->LUT_Xmin, 3));
   FPGA_PRINTF("LUT_Xrange: " _PCF(3) "\n", _FFMT(hdr->LUT_Xrange, 3));
   FPGA_PRINTF("LUT_Size: %u\n", hdr->LUT_Size);
   FPGA_PRINTF("M_Exp: %d\n", hdr->M_Exp);
   FPGA_PRINTF("B_Exp: %d\n", hdr->B_Exp);
   FPGA_PRINTF("M_Nbits: %u bits\n", hdr->M_Nbits);
   FPGA_PRINTF("B_Nbits: %u bits\n", hdr->B_Nbits);
   FPGA_PRINTF("M_Signed: %u 0 / 1\n", hdr->M_Signed);
   FPGA_PRINTF("B_Signed: %u 0 / 1\n", hdr->B_Signed);
   FPGA_PRINTF("NumberOfLUTNL: %u\n", hdr->NumberOfLUTNL);
   FPGA_PRINTF("LUTNLDataLength: %u bytes\n", hdr->LUTNLDataLength);
   FPGA_PRINTF("LUTNLDataCRC16: %u\n", hdr->LUTNLDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %u\n", hdr->DataHeaderCRC16);
}

/**
 * LUTNLData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseLUTNLData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBBLOCK_LUTNLDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->m = ((rawData & CALIBBLOCK_LUTNLDATA_M_MASK_V2) >> CALIBBLOCK_LUTNLDATA_M_SHIFT_V2);
   data->b = ((rawData & CALIBBLOCK_LUTNLDATA_B_MASK_V2) >> CALIBBLOCK_LUTNLDATA_B_SHIFT_V2);

   return numBytes;
}

/**
 * LUTNLData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteLUTNLData_v2(CalibBlock_LUTNLData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBBLOCK_LUTNLDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->m;
   rawData |= ((tmpData << CALIBBLOCK_LUTNLDATA_M_SHIFT_V2) & CALIBBLOCK_LUTNLDATA_M_MASK_V2);
   tmpData = data->b;
   rawData |= ((tmpData << CALIBBLOCK_LUTNLDATA_B_SHIFT_V2) & CALIBBLOCK_LUTNLDATA_B_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

/**
 * LUTRQDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseLUTRQDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->LUT_Xmin, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Xrange, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Size, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->M_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->B_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Data_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Data_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->RadiometricQuantityType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->M_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->M_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 222; // Skip FREE space
   memcpy(&hdr->LUTRQDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->LUTRQDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * LUTRQDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteLUTRQDataHeader_v2(CalibBlock_LUTRQDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->LUT_Xmin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LUT_Xrange, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->LUT_Size, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->M_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->B_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Data_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Data_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->RadiometricQuantityType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->M_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->B_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->M_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->B_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 222); numBytes += 222; // FREE space
   memcpy(&buffer[numBytes], &hdr->LUTRQDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->LUTRQDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * LUTRQDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibBlock_PrintLUTRQDataHeader_v2(CalibBlock_LUTRQDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %u bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("LUT_Xmin: " _PCF(3) "\n", _FFMT(hdr->LUT_Xmin, 3));
   FPGA_PRINTF("LUT_Xrange: " _PCF(3) "\n", _FFMT(hdr->LUT_Xrange, 3));
   FPGA_PRINTF("LUT_Size: %u unit\n", hdr->LUT_Size);
   FPGA_PRINTF("M_Exp: %d\n", hdr->M_Exp);
   FPGA_PRINTF("B_Exp: %d\n", hdr->B_Exp);
   FPGA_PRINTF("Data_Off: " _PCF(3) "\n", _FFMT(hdr->Data_Off, 3));
   FPGA_PRINTF("Data_Exp: %d\n", hdr->Data_Exp);
   FPGA_PRINTF("RadiometricQuantityType: %u\n", hdr->RadiometricQuantityType);
   FPGA_PRINTF("M_Nbits: %u bits\n", hdr->M_Nbits);
   FPGA_PRINTF("B_Nbits: %u bits\n", hdr->B_Nbits);
   FPGA_PRINTF("M_Signed: %u 0 / 1\n", hdr->M_Signed);
   FPGA_PRINTF("B_Signed: %u 0 / 1\n", hdr->B_Signed);
   FPGA_PRINTF("LUTRQDataLength: %u bytes\n", hdr->LUTRQDataLength);
   FPGA_PRINTF("LUTRQDataCRC16: %u\n", hdr->LUTRQDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %u\n", hdr->DataHeaderCRC16);
}

/**
 * LUTRQData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseLUTRQData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBBLOCK_LUTRQDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->m = ((rawData & CALIBBLOCK_LUTRQDATA_M_MASK_V2) >> CALIBBLOCK_LUTRQDATA_M_SHIFT_V2);
   data->b = ((rawData & CALIBBLOCK_LUTRQDATA_B_MASK_V2) >> CALIBBLOCK_LUTRQDATA_B_SHIFT_V2);

   return numBytes;
}

/**
 * LUTRQData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteLUTRQData_v2(CalibBlock_LUTRQData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBBLOCK_LUTRQDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->m;
   rawData |= ((tmpData << CALIBBLOCK_LUTRQDATA_M_SHIFT_V2) & CALIBBLOCK_LUTRQDATA_M_MASK_V2);
   tmpData = data->b;
   rawData |= ((tmpData << CALIBBLOCK_LUTRQDATA_B_SHIFT_V2) & CALIBBLOCK_LUTRQDATA_B_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

/**
 * KPixDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseKPixDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_KPixDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_KPIXDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBBLOCK_KPIXDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->KPix_Median, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->KPix_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->KPix_EffectiveBitWidth, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->KPix_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 237; // Skip FREE space
   memcpy(&hdr->KPixDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->KPixDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * KPixDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteKPixDataHeader_v2(CalibBlock_KPixDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_KPIXDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBBLOCK_KPIXDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->KPix_Median, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->KPix_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->KPix_EffectiveBitWidth, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->KPix_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 237); numBytes += 237; // FREE space
   memcpy(&buffer[numBytes], &hdr->KPixDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->KPixDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * KPixDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibBlock_PrintKPixDataHeader_v2(CalibBlock_KPixDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %u bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("KPix_Median: %u\n", hdr->KPix_Median);
   FPGA_PRINTF("KPix_Nbits: %u bits\n", hdr->KPix_Nbits);
   FPGA_PRINTF("KPix_EffectiveBitWidth: %u bits\n", hdr->KPix_EffectiveBitWidth);
   FPGA_PRINTF("KPix_Signed: %u 0 / 1\n", hdr->KPix_Signed);
   FPGA_PRINTF("KPixDataLength: %u bytes\n", hdr->KPixDataLength);
   FPGA_PRINTF("KPixDataCRC16: %u\n", hdr->KPixDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %u\n", hdr->DataHeaderCRC16);
}

/**
 * KPixData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseKPixData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_KPixData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint16_t rawData;

   if (buflen < CALIBBLOCK_KPIXDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   data->KPix_Data = ((rawData & CALIBBLOCK_KPIXDATA_KPIX_DATA_MASK_V2) >> CALIBBLOCK_KPIXDATA_KPIX_DATA_SHIFT_V2);
   if ((data->KPix_Data & CALIBBLOCK_KPIXDATA_KPIX_DATA_SIGNPOS_V2) == CALIBBLOCK_KPIXDATA_KPIX_DATA_SIGNPOS_V2)
   {
      // Sign extension
      data->KPix_Data |= 0x0000;
   }

   return numBytes;
}

/**
 * KPixData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_WriteKPixData_v2(CalibBlock_KPixData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint16_t tmpData;
   uint16_t rawData = 0;

   if (buflen < CALIBBLOCK_KPIXDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->KPix_Data;
   rawData |= ((tmpData << CALIBBLOCK_KPIXDATA_KPIX_DATA_SHIFT_V2) & CALIBBLOCK_KPIXDATA_KPIX_DATA_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

