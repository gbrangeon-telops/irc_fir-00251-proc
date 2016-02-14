/**
 * @file CalibBlockFile.c
 * Camera calibration block file structure definition.
 *
 * This file defines camera calibration block file structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "CalibBlockFile.h"
#include "verbose.h"
#include "CRC.h"
#include <string.h>

void CalibBlockFileHeader_UpdateVersion(BlockFileHeader_t *hdr);

/* AUTO-CODE BEGIN */
// Auto-generated Calibration Block File library.
// Generated from the calibration block file structure definition XLS file version 1.1.0
// using generateIRCamBlockCalibrationFileCLib.m Matlab script.

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
uint32_t ParseCalibBlockFileHeader(uint8_t *buffer, uint32_t buflen, BlockFileHeader_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 12)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[0], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSBL") != 0)   {
      // Wrong file signature
      return 0;
   }

   memcpy(&hdr->FileStructureMajorVersion, &buffer[4], sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   if (hdr->FileStructureMajorVersion != 1)   {
      // Wrong file major version
      return 0;
   }

   memcpy(&hdr->FileStructureMinorVersion, &buffer[5], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileStructureSubMinorVersion, &buffer[6], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->BlockFileHeaderLength, &buffer[8], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->BlockFileHeaderLength)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DeviceSerialNumber, &buffer[12], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->POSIXTime, &buffer[16], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->FileDescription, &buffer[20], 64); numBytes += 64;
   hdr->FileDescription[64] = '\0';
   memcpy(&hdr->DeviceDataFlowMajorVersion, &buffer[84], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->DeviceDataFlowMinorVersion, &buffer[85], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorID, &buffer[86], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationSource, &buffer[87], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationType, &buffer[88], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->IntegrationMode, &buffer[89], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorWellDepth, &buffer[90], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->PixelDataResolution, &buffer[91], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Width, &buffer[92], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->Height, &buffer[94], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetX, &buffer[96], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetY, &buffer[98], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ReverseX, &buffer[100], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->ReverseY, &buffer[101], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->ExternalLensSerialNumber, &buffer[104], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ExternalLensName, &buffer[108], 64); numBytes += 64;
   hdr->ExternalLensName[64] = '\0';
   memcpy(&hdr->ManualFilterSerialNumber, &buffer[172], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ManualFilterName, &buffer[176], 64); numBytes += 64;
   hdr->ManualFilterName[64] = '\0';
   memcpy(&hdr->ExposureTime, &buffer[240], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->AcquisitionFrameRate, &buffer[244], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FWPosition, &buffer[248], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NDFPosition, &buffer[249], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorWidth, &buffer[250], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->SensorHeight, &buffer[252], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->PixelDynamicRangeMin, &buffer[254], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->PixelDynamicRangeMax, &buffer[256], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->SaturationThreshold, &buffer[258], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->BlockBadPixelCount, &buffer[260], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->MaximumTotalFlux, &buffer[264], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->NUCMultFactor, &buffer[268], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->T0, &buffer[272], sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&hdr->Nu, &buffer[276], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->DeviceTemperatureSensor, &buffer[280], sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&hdr->SpectralResponsePOSIXTime, &buffer[284], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->ReferencePOSIXTime, &buffer[288], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   numBytes += 210; // Skip FREE space
   memcpy(&hdr->PixelDataPresence, &buffer[502], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->MaxTKDataPresence, &buffer[503], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLDataPresence, &buffer[504], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTRQDataPresence, &buffer[505], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NumberOfLUTRQ, &buffer[506], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 3; // Skip FREE space
   memcpy(&hdr->BlockFileHeaderCRC16, &buffer[510], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->BlockFileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   CalibBlockFileHeader_UpdateVersion(hdr);

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
uint32_t WriteCalibBlockFileHeader(BlockFileHeader_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   strncpy(hdr->FileSignature, "TSBL", 4);
   hdr->FileStructureMajorVersion = 1;
   hdr->FileStructureMinorVersion = 1;
   hdr->FileStructureSubMinorVersion = 0;
   hdr->DeviceDataFlowMajorVersion = 1;
   hdr->DeviceDataFlowMinorVersion = 1;
   hdr->BlockFileHeaderLength = 512;

   memcpy(&buffer[0], hdr->FileSignature, 4); numBytes += 4;
   memcpy(&buffer[4], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[5], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[6], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[7], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[8], &hdr->BlockFileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[12], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[16], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[20], hdr->FileDescription, 64); numBytes += 64;
   memcpy(&buffer[84], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[85], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[86], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[87], &hdr->CalibrationSource, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[88], &hdr->CalibrationType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[89], &hdr->IntegrationMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[90], &hdr->SensorWellDepth, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[91], &hdr->PixelDataResolution, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[92], &hdr->Width, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[94], &hdr->Height, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[96], &hdr->OffsetX, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[98], &hdr->OffsetY, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[100], &hdr->ReverseX, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[101], &hdr->ReverseY, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[102], 0, 2); numBytes += 2; // FREE space
   memcpy(&buffer[104], &hdr->ExternalLensSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[108], hdr->ExternalLensName, 64); numBytes += 64;
   memcpy(&buffer[172], &hdr->ManualFilterSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[176], hdr->ManualFilterName, 64); numBytes += 64;
   memcpy(&buffer[240], &hdr->ExposureTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[244], &hdr->AcquisitionFrameRate, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[248], &hdr->FWPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[249], &hdr->NDFPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[250], &hdr->SensorWidth, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[252], &hdr->SensorHeight, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[254], &hdr->PixelDynamicRangeMin, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[256], &hdr->PixelDynamicRangeMax, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[258], &hdr->SaturationThreshold, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[260], &hdr->BlockBadPixelCount, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[264], &hdr->MaximumTotalFlux, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[268], &hdr->NUCMultFactor, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[272], &hdr->T0, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&buffer[276], &hdr->Nu, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[280], &hdr->DeviceTemperatureSensor, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memcpy(&buffer[284], &hdr->SpectralResponsePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[288], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memset(&buffer[292], 0, 210); numBytes += 210; // FREE space
   memcpy(&buffer[502], &hdr->PixelDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[503], &hdr->MaxTKDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[504], &hdr->LUTNLDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[505], &hdr->LUTRQDataPresence, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[506], &hdr->NumberOfLUTRQ, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[507], 0, 3); numBytes += 3; // FREE space

   hdr->BlockFileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[510], &hdr->BlockFileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t ParseCalibPixelDataHeader(uint8_t *buffer, uint32_t buflen, PixelDataHeader_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->PixelDataHeaderLength, &buffer[0], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->PixelDataHeaderLength)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->Offset_Off, &buffer[4], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Offset_Median, &buffer[8], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Offset_Exp, &buffer[12], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Offset_Nbits, &buffer[13], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Offset_Signed, &buffer[14], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Range_Off, &buffer[16], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Range_Median, &buffer[20], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Range_Exp, &buffer[24], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Range_Nbits, &buffer[25], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Range_Signed, &buffer[26], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Kappa_Off, &buffer[28], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Kappa_Median, &buffer[32], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Kappa_Exp, &buffer[36], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Kappa_Nbits, &buffer[37], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Kappa_Signed, &buffer[38], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Beta0_Off, &buffer[40], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Median, &buffer[44], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Exp, &buffer[48], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Beta0_Nbits, &buffer[49], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Beta0_Signed, &buffer[50], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Alpha_Off, &buffer[52], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Alpha_Median, &buffer[56], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Alpha_Exp, &buffer[60], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Alpha_Nbits, &buffer[61], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Alpha_Signed, &buffer[62], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->LUTNLIndex_Nbits, &buffer[64], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLIndex_Signed, &buffer[65], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->BadPixel_Nbits, &buffer[68], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->BadPixel_Signed, &buffer[69], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 178; // Skip FREE space
   memcpy(&hdr->PixelDataLength, &buffer[248], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->PixelDataCRC16, &buffer[252], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->PixelDataHeaderCRC16, &buffer[254], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t WriteCalibPixelDataHeader(PixelDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   hdr->PixelDataHeaderLength = 256;

   memcpy(&buffer[0], &hdr->PixelDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[4], &hdr->Offset_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[8], &hdr->Offset_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[12], &hdr->Offset_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[13], &hdr->Offset_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[14], &hdr->Offset_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[15], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[16], &hdr->Range_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[20], &hdr->Range_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[24], &hdr->Range_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[25], &hdr->Range_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[26], &hdr->Range_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[27], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[28], &hdr->Kappa_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[32], &hdr->Kappa_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[36], &hdr->Kappa_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[37], &hdr->Kappa_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[38], &hdr->Kappa_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[39], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[40], &hdr->Beta0_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[44], &hdr->Beta0_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[48], &hdr->Beta0_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[49], &hdr->Beta0_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[50], &hdr->Beta0_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[51], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[52], &hdr->Alpha_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[56], &hdr->Alpha_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[60], &hdr->Alpha_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[61], &hdr->Alpha_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[62], &hdr->Alpha_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[63], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[64], &hdr->LUTNLIndex_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[65], &hdr->LUTNLIndex_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[66], 0, 2); numBytes += 2; // FREE space
   memcpy(&buffer[68], &hdr->BadPixel_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[69], &hdr->BadPixel_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[70], 0, 178); numBytes += 178; // FREE space
   memcpy(&buffer[248], &hdr->PixelDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[252], &hdr->PixelDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->PixelDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[254], &hdr->PixelDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t ParseCalibPixelData(uint8_t *buffer, uint32_t buflen, PixelData_t *data)
{
   uint32_t numBytes = 0;
   uint64_t rawData;

   if (buflen < 8)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint64_t)); numBytes += sizeof(uint64_t);

   data->Offset = ((rawData & CALIB_PIXELDATA_OFFSET_MASK) >> CALIB_PIXELDATA_OFFSET_SHIFT);
   data->Range = ((rawData & CALIB_PIXELDATA_RANGE_MASK) >> CALIB_PIXELDATA_RANGE_SHIFT);
   data->LUTNLIndex = ((rawData & CALIB_PIXELDATA_LUTNLINDEX_MASK) >> CALIB_PIXELDATA_LUTNLINDEX_SHIFT);
   data->Kappa = ((rawData & CALIB_PIXELDATA_KAPPA_MASK) >> CALIB_PIXELDATA_KAPPA_SHIFT);
   data->Beta0 = ((rawData & CALIB_PIXELDATA_BETA0_MASK) >> CALIB_PIXELDATA_BETA0_SHIFT);
   if ((data->Beta0 & CALIB_PIXELDATA_BETA0_SIGNPOS) == CALIB_PIXELDATA_BETA0_SIGNPOS)
   {
      // Sign extension
      data->Beta0 |= 0xF800;
   }
   data->Alpha = ((rawData & CALIB_PIXELDATA_ALPHA_MASK) >> CALIB_PIXELDATA_ALPHA_SHIFT);
   data->BadPixel = ((rawData & CALIB_PIXELDATA_BADPIXEL_MASK) >> CALIB_PIXELDATA_BADPIXEL_SHIFT);

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
uint32_t WriteCalibPixelData(PixelData_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint64_t tmpData;
   uint64_t rawData = 0;

   if (buflen < 8)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->Offset;
   rawData |= ((tmpData << CALIB_PIXELDATA_OFFSET_SHIFT) & CALIB_PIXELDATA_OFFSET_MASK);
   tmpData = data->Range;
   rawData |= ((tmpData << CALIB_PIXELDATA_RANGE_SHIFT) & CALIB_PIXELDATA_RANGE_MASK);
   tmpData = data->LUTNLIndex;
   rawData |= ((tmpData << CALIB_PIXELDATA_LUTNLINDEX_SHIFT) & CALIB_PIXELDATA_LUTNLINDEX_MASK);
   tmpData = data->Kappa;
   rawData |= ((tmpData << CALIB_PIXELDATA_KAPPA_SHIFT) & CALIB_PIXELDATA_KAPPA_MASK);
   tmpData = data->Beta0;
   rawData |= ((tmpData << CALIB_PIXELDATA_BETA0_SHIFT) & CALIB_PIXELDATA_BETA0_MASK);
   tmpData = data->Alpha;
   rawData |= ((tmpData << CALIB_PIXELDATA_ALPHA_SHIFT) & CALIB_PIXELDATA_ALPHA_MASK);
   tmpData = data->BadPixel;
   rawData |= ((tmpData << CALIB_PIXELDATA_BADPIXEL_SHIFT) & CALIB_PIXELDATA_BADPIXEL_MASK);

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
uint32_t ParseCalibMaxTKDataHeader(uint8_t *buffer, uint32_t buflen, MaxTKDataHeader_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->MaxTKDataHeaderLength, &buffer[0], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->MaxTKDataHeaderLength)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->TCalMin, &buffer[4], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMax, &buffer[8], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMinExpTimeMin, &buffer[12], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMinExpTimeMax, &buffer[16], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMaxExpTimeMin, &buffer[20], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TCalMaxExpTimeMax, &buffer[24], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TvsINT_FitOrder, &buffer[28], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->INTvsT_FitOrder, &buffer[29], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 218; // Skip FREE space
   memcpy(&hdr->MaxTKDataLength, &buffer[248], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->MaxTKDataCRC16, &buffer[252], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->MaxTKDataHeaderCRC16, &buffer[254], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t WriteCalibMaxTKDataHeader(MaxTKDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   hdr->MaxTKDataHeaderLength = 256;

   memcpy(&buffer[0], &hdr->MaxTKDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[4], &hdr->TCalMin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[8], &hdr->TCalMax, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[12], &hdr->TCalMinExpTimeMin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[16], &hdr->TCalMinExpTimeMax, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[20], &hdr->TCalMaxExpTimeMin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[24], &hdr->TCalMaxExpTimeMax, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[28], &hdr->TvsINT_FitOrder, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[29], &hdr->INTvsT_FitOrder, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[30], 0, 218); numBytes += 218; // FREE space
   memcpy(&buffer[248], &hdr->MaxTKDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[252], &hdr->MaxTKDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->MaxTKDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[254], &hdr->MaxTKDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t ParseCalibLUTNLDataHeader(uint8_t *buffer, uint32_t buflen, LUTNLDataHeader_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->LUTNLDataHeaderLength, &buffer[0], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->LUTNLDataHeaderLength)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->LUT_Xmin, &buffer[4], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Xrange, &buffer[8], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Size, &buffer[12], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->M_Exp, &buffer[14], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->B_Exp, &buffer[15], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->M_Nbits, &buffer[16], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Nbits, &buffer[17], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->M_Signed, &buffer[18], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Signed, &buffer[19], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 227; // Skip FREE space
   memcpy(&hdr->NumberOfLUTNL, &buffer[247], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->LUTNLDataLength, &buffer[248], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->LUTNLDataCRC16, &buffer[252], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->LUTNLDataHeaderCRC16, &buffer[254], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t WriteCalibLUTNLDataHeader(LUTNLDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   hdr->LUTNLDataHeaderLength = 256;

   memcpy(&buffer[0], &hdr->LUTNLDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[4], &hdr->LUT_Xmin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[8], &hdr->LUT_Xrange, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[12], &hdr->LUT_Size, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[14], &hdr->M_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[15], &hdr->B_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[16], &hdr->M_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[17], &hdr->B_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[18], &hdr->M_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[19], &hdr->B_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[20], 0, 227); numBytes += 227; // FREE space
   memcpy(&buffer[247], &hdr->NumberOfLUTNL, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[248], &hdr->LUTNLDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[252], &hdr->LUTNLDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->LUTNLDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[254], &hdr->LUTNLDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t ParseCalibLUTNLData(uint8_t *buffer, uint32_t buflen, LUTNLData_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->m = ((rawData & CALIB_LUTNLDATA_M_MASK) >> CALIB_LUTNLDATA_M_SHIFT);
   data->b = ((rawData & CALIB_LUTNLDATA_B_MASK) >> CALIB_LUTNLDATA_B_SHIFT);

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
uint32_t WriteCalibLUTNLData(LUTNLData_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->m;
   rawData |= ((tmpData << CALIB_LUTNLDATA_M_SHIFT) & CALIB_LUTNLDATA_M_MASK);
   tmpData = data->b;
   rawData |= ((tmpData << CALIB_LUTNLDATA_B_SHIFT) & CALIB_LUTNLDATA_B_MASK);

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
uint32_t ParseCalibLUTRQDataHeader(uint8_t *buffer, uint32_t buflen, LUTRQDataHeader_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->LUTRQDataHeaderLength, &buffer[0], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->LUTRQDataHeaderLength)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->LUT_Xmin, &buffer[4], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Xrange, &buffer[8], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->LUT_Size, &buffer[12], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->M_Exp, &buffer[14], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->B_Exp, &buffer[15], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Data_Off, &buffer[16], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Data_Exp, &buffer[20], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->RadiometricQuantityType, &buffer[21], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->M_Nbits, &buffer[22], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Nbits, &buffer[23], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->M_Signed, &buffer[24], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->B_Signed, &buffer[25], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 222; // Skip FREE space
   memcpy(&hdr->LUTRQDataLength, &buffer[248], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->LUTRQDataCRC16, &buffer[252], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->LUTRQDataHeaderCRC16, &buffer[254], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t WriteCalibLUTRQDataHeader(LUTRQDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   hdr->LUTRQDataHeaderLength = 256;

   memcpy(&buffer[0], &hdr->LUTRQDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[4], &hdr->LUT_Xmin, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[8], &hdr->LUT_Xrange, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[12], &hdr->LUT_Size, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[14], &hdr->M_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[15], &hdr->B_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[16], &hdr->Data_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[20], &hdr->Data_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[21], &hdr->RadiometricQuantityType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[22], &hdr->M_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[23], &hdr->B_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[24], &hdr->M_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[25], &hdr->B_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[26], 0, 222); numBytes += 222; // FREE space
   memcpy(&buffer[248], &hdr->LUTRQDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[252], &hdr->LUTRQDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->LUTRQDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[254], &hdr->LUTRQDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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
uint32_t ParseCalibLUTRQData(uint8_t *buffer, uint32_t buflen, LUTRQData_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->m = ((rawData & CALIB_LUTRQDATA_M_MASK) >> CALIB_LUTRQDATA_M_SHIFT);
   data->b = ((rawData & CALIB_LUTRQDATA_B_MASK) >> CALIB_LUTRQDATA_B_SHIFT);

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
uint32_t WriteCalibLUTRQData(LUTRQData_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->m;
   rawData |= ((tmpData << CALIB_LUTRQDATA_M_SHIFT) & CALIB_LUTRQDATA_M_MASK);
   tmpData = data->b;
   rawData |= ((tmpData << CALIB_LUTRQDATA_B_SHIFT) & CALIB_LUTRQDATA_B_MASK);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

/* AUTO-CODE END */


void CalibBlockFileHeader_UpdateVersion(BlockFileHeader_t *hdr)
{
   switch (hdr->FileStructureMajorVersion)
   {
      case 1:
         // 1.x.x
         switch (hdr->FileStructureMinorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x
               hdr->SensorID = 0;

               break; // Break after the last minor version only

            default:
               // Up to date, nothing to do
               return;
         }

         break; // Break after the last major version only

      default:
         // Up to date, nothing to do
         return;
   }

   PRINTF("Calibration block file structure version %d.%d.%d has been updated to version %d.%d.%d.\n",
         hdr->FileStructureMajorVersion,
         hdr->FileStructureMinorVersion,
         hdr->FileStructureSubMinorVersion,
         CALIB_BLOCKFILEMAJORVERSION,
         CALIB_BLOCKFILEMINORVERSION,
         CALIB_BLOCKFILESUBMINORVERSION);

   hdr->FileStructureMinorVersion = CALIB_BLOCKFILEMINORVERSION;
   hdr->FileStructureSubMinorVersion = CALIB_BLOCKFILESUBMINORVERSION;
}
