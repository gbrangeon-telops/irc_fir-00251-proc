/**
 * @file CalibBlockFile_v1.c
 * Camera image correction calibration file structure v1 definition.
 *
 * This file defines camera image correction calibration file structure v1.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 1.1.0
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

#include "CalibBlockFile_v1.h"
#include "CRC.h"
#include <string.h>
#include <float.h>

/**
 * BlockFileHeader default values.
 */
CalibBlock_BlockFileHeader_v1_t CalibBlock_BlockFileHeader_v1_default = {
   /* FileSignature = */ "TSBL",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* BlockFileHeaderLength = */ 512,
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
   /* PixelDataPresence = */ 0,
   /* MaxTKDataPresence = */ 0,
   /* LUTNLDataPresence = */ 0,
   /* LUTRQDataPresence = */ 0,
   /* NumberOfLUTRQ = */ 0,
   /* BlockFileHeaderCRC16 = */ 0,
};

/**
 * PixelDataHeader default values.
 */
CalibBlock_PixelDataHeader_v1_t CalibBlock_PixelDataHeader_v1_default = {
   /* PixelDataHeaderLength = */ 256,
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
   /* PixelDataHeaderCRC16 = */ 0,
};

/**
 * MaxTKDataHeader default values.
 */
CalibBlock_MaxTKDataHeader_v1_t CalibBlock_MaxTKDataHeader_v1_default = {
   /* MaxTKDataHeaderLength = */ 256,
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
   /* MaxTKDataHeaderCRC16 = */ 0,
};

/**
 * LUTNLDataHeader default values.
 */
CalibBlock_LUTNLDataHeader_v1_t CalibBlock_LUTNLDataHeader_v1_default = {
   /* LUTNLDataHeaderLength = */ 256,
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
   /* LUTNLDataHeaderCRC16 = */ 0,
};

/**
 * LUTRQDataHeader default values.
 */
CalibBlock_LUTRQDataHeader_v1_t CalibBlock_LUTRQDataHeader_v1_default = {
   /* LUTRQDataHeaderLength = */ 256,
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
   /* LUTRQDataHeaderCRC16 = */ 0,
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
uint32_t CalibBlock_ParseBlockFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_BlockFileHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1)
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

   if (hdr->FileStructureMajorVersion != 1)
   {
      // Wrong file major version
      return 0;
   }

   memcpy(&hdr->FileStructureMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileStructureSubMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->BlockFileHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->BlockFileHeaderLength != CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1)
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
   numBytes += 2; // Skip FREE space
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
   numBytes += 210; // Skip FREE space
   memcpy(&hdr->PixelDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->MaxTKDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTRQDataPresence, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NumberOfLUTRQ, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 3; // Skip FREE space
   memcpy(&hdr->BlockFileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->BlockFileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibBlock_WriteBlockFileHeader_v1(CalibBlock_BlockFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSBL", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBBLOCK_FILEMAJORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBBLOCK_FILEMINORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBBLOCK_FILESUBMINORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->BlockFileHeaderLength = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->BlockFileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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
   memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
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
   memset(&buffer[numBytes], 0, 210); numBytes += 210; // FREE space
   memcpy(&buffer[numBytes], &hdr->PixelDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->MaxTKDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->LUTNLDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->LUTRQDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->NumberOfLUTRQ, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 3); numBytes += 3; // FREE space

   hdr->BlockFileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->BlockFileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
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
uint32_t CalibBlock_ParsePixelDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelDataHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_PIXELDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->PixelDataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->PixelDataHeaderLength != CALIBBLOCK_PIXELDATAHEADER_SIZE_V1)
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
   memcpy(&hdr->PixelDataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->PixelDataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibBlock_WritePixelDataHeader_v1(CalibBlock_PixelDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_PIXELDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->PixelDataHeaderLength = CALIBBLOCK_PIXELDATAHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->PixelDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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

   hdr->PixelDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->PixelDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
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
uint32_t CalibBlock_ParsePixelData_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelData_v1_t *data)
{
   uint32_t numBytes = 0;
   uint64_t rawData;

   if (buflen < CALIBBLOCK_PIXELDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint64_t)); numBytes += sizeof(uint64_t);

   data->Offset = ((rawData & CALIBBLOCK_PIXELDATA_OFFSET_MASK_V1) >> CALIBBLOCK_PIXELDATA_OFFSET_SHIFT_V1);
   data->Range = ((rawData & CALIBBLOCK_PIXELDATA_RANGE_MASK_V1) >> CALIBBLOCK_PIXELDATA_RANGE_SHIFT_V1);
   data->LUTNLIndex = ((rawData & CALIBBLOCK_PIXELDATA_LUTNLINDEX_MASK_V1) >> CALIBBLOCK_PIXELDATA_LUTNLINDEX_SHIFT_V1);
   data->Kappa = ((rawData & CALIBBLOCK_PIXELDATA_KAPPA_MASK_V1) >> CALIBBLOCK_PIXELDATA_KAPPA_SHIFT_V1);
   data->Beta0 = ((rawData & CALIBBLOCK_PIXELDATA_BETA0_MASK_V1) >> CALIBBLOCK_PIXELDATA_BETA0_SHIFT_V1);
   if ((data->Beta0 & CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS_V1) == CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS_V1)
   {
      // Sign extension
      data->Beta0 |= 0xF800;
   }
   data->Alpha = ((rawData & CALIBBLOCK_PIXELDATA_ALPHA_MASK_V1) >> CALIBBLOCK_PIXELDATA_ALPHA_SHIFT_V1);
   data->BadPixel = ((rawData & CALIBBLOCK_PIXELDATA_BADPIXEL_MASK_V1) >> CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT_V1);

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
uint32_t CalibBlock_WritePixelData_v1(CalibBlock_PixelData_v1_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint64_t tmpData;
   uint64_t rawData = 0;

   if (buflen < CALIBBLOCK_PIXELDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->Offset;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_OFFSET_SHIFT_V1) & CALIBBLOCK_PIXELDATA_OFFSET_MASK_V1);
   tmpData = data->Range;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_RANGE_SHIFT_V1) & CALIBBLOCK_PIXELDATA_RANGE_MASK_V1);
   tmpData = data->LUTNLIndex;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_LUTNLINDEX_SHIFT_V1) & CALIBBLOCK_PIXELDATA_LUTNLINDEX_MASK_V1);
   tmpData = data->Kappa;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_KAPPA_SHIFT_V1) & CALIBBLOCK_PIXELDATA_KAPPA_MASK_V1);
   tmpData = data->Beta0;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_BETA0_SHIFT_V1) & CALIBBLOCK_PIXELDATA_BETA0_MASK_V1);
   tmpData = data->Alpha;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_ALPHA_SHIFT_V1) & CALIBBLOCK_PIXELDATA_ALPHA_MASK_V1);
   tmpData = data->BadPixel;
   rawData |= ((tmpData << CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT_V1) & CALIBBLOCK_PIXELDATA_BADPIXEL_MASK_V1);

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
uint32_t CalibBlock_ParseMaxTKDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_MaxTKDataHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->MaxTKDataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->MaxTKDataHeaderLength != CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1)
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
   memcpy(&hdr->MaxTKDataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->MaxTKDataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibBlock_WriteMaxTKDataHeader_v1(CalibBlock_MaxTKDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->MaxTKDataHeaderLength = CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->MaxTKDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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

   hdr->MaxTKDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->MaxTKDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t CalibBlock_ParseLUTNLDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLDataHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->LUTNLDataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->LUTNLDataHeaderLength != CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1)
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
   memcpy(&hdr->LUTNLDataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->LUTNLDataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibBlock_WriteLUTNLDataHeader_v1(CalibBlock_LUTNLDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->LUTNLDataHeaderLength = CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->LUTNLDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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

   hdr->LUTNLDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->LUTNLDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
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
uint32_t CalibBlock_ParseLUTNLData_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLData_v1_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBBLOCK_LUTNLDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->m = ((rawData & CALIBBLOCK_LUTNLDATA_M_MASK_V1) >> CALIBBLOCK_LUTNLDATA_M_SHIFT_V1);
   data->b = ((rawData & CALIBBLOCK_LUTNLDATA_B_MASK_V1) >> CALIBBLOCK_LUTNLDATA_B_SHIFT_V1);

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
uint32_t CalibBlock_WriteLUTNLData_v1(CalibBlock_LUTNLData_v1_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBBLOCK_LUTNLDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->m;
   rawData |= ((tmpData << CALIBBLOCK_LUTNLDATA_M_SHIFT_V1) & CALIBBLOCK_LUTNLDATA_M_MASK_V1);
   tmpData = data->b;
   rawData |= ((tmpData << CALIBBLOCK_LUTNLDATA_B_SHIFT_V1) & CALIBBLOCK_LUTNLDATA_B_MASK_V1);

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
uint32_t CalibBlock_ParseLUTRQDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQDataHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->LUTRQDataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->LUTRQDataHeaderLength != CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1)
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
   memcpy(&hdr->LUTRQDataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->LUTRQDataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibBlock_WriteLUTRQDataHeader_v1(CalibBlock_LUTRQDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->LUTRQDataHeaderLength = CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->LUTRQDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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

   hdr->LUTRQDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->LUTRQDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
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
uint32_t CalibBlock_ParseLUTRQData_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQData_v1_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBBLOCK_LUTRQDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->m = ((rawData & CALIBBLOCK_LUTRQDATA_M_MASK_V1) >> CALIBBLOCK_LUTRQDATA_M_SHIFT_V1);
   data->b = ((rawData & CALIBBLOCK_LUTRQDATA_B_MASK_V1) >> CALIBBLOCK_LUTRQDATA_B_SHIFT_V1);

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
uint32_t CalibBlock_WriteLUTRQData_v1(CalibBlock_LUTRQData_v1_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBBLOCK_LUTRQDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->m;
   rawData |= ((tmpData << CALIBBLOCK_LUTRQDATA_M_SHIFT_V1) & CALIBBLOCK_LUTRQDATA_M_MASK_V1);
   tmpData = data->b;
   rawData |= ((tmpData << CALIBBLOCK_LUTRQDATA_B_SHIFT_V1) & CALIBBLOCK_LUTRQDATA_B_MASK_V1);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

