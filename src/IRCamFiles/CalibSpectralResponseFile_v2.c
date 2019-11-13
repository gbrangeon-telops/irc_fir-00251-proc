/**
 * @file CalibSpectralResponseFile_v2.c
 * Camera calibration spectral response file structure v2 definition.
 *
 * This file defines the camera calibration spectral response file structure v2.
 *
 * Auto-generated calibration spectral response file library.
 * Generated from the calibration spectral response file structure definition XLS file version 2.0.0
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

#include "CalibSpectralResponseFile_v2.h"
#include "CRC.h"
#include "utils.h"
#include "verbose.h"
#include <string.h>
#include <float.h>

/**
 * SpectralResponseFileHeader default values.
 */
CalibSpectralResponse_SpectralResponseFileHeader_v2_t CalibSpectralResponse_SpectralResponseFileHeader_v2_default = {
   /* FileSignature = */ "TSSR",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* FileHeaderLength = */ 512,
   /* DeviceSerialNumber = */ 0,
   /* POSIXTime = */ 0,
   /* FileDescription = */ "",
   /* SensorID = */ 0,
   /* ExternalLensSerialNumber = */ 0,
   /* ManualFilterSerialNumber = */ 0,
   /* FWPosition = */ 0,
   /* NDFPosition = */ 0,
   /* FWFilterID = */ 0,
   /* NDFilterID = */ 0,
   /* ManualFilterID = */ 0,
   /* LensID = */ 0,
   /* LowCut = */ 0.000000F,
   /* HighCut = */ 0.000000F,
   /* FileHeaderCRC16 = */ 0,
};

/**
 * SpectralResponseDataHeader default values.
 */
CalibSpectralResponse_SpectralResponseDataHeader_v2_t CalibSpectralResponse_SpectralResponseDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* SpectralResponseCurveSize = */ 0,
   /* Lambda_Exp = */ 0,
   /* SR_Exp = */ 0,
   /* Lambda_Off = */ 0.000000F,
   /* SR_Off = */ 1.000000F,
   /* Lambda_Nbits = */ 16,
   /* SR_Nbits = */ 16,
   /* Lambda_Signed = */ 0,
   /* SR_Signed = */ 0,
   /* SpectralResponseDataLength = */ 0,
   /* SpectralResponseDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * SpectralResponseFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibSpectralResponse_ParseSpectralResponseFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseFileHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSSR") != 0)
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

   if (hdr->FileHeaderLength != CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V2)
   {
      // File header length mismatch
      return 0;
   }

   memcpy(&hdr->DeviceSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->POSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->FileDescription, &buffer[numBytes], 64); numBytes += 64;
   hdr->FileDescription[64] = '\0';
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->SensorID, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->ExternalLensSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->ManualFilterSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FWPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NDFPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 2; // Skip FREE space
   memcpy(&hdr->FWFilterID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->NDFilterID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ManualFilterID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->LensID, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->LowCut, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->HighCut, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   numBytes += 394; // Skip FREE space
   memcpy(&hdr->FileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->FileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * SpectralResponseFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibSpectralResponse_WriteSpectralResponseFileHeader_v2(CalibSpectralResponse_SpectralResponseFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSSR", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBSPECTRALRESPONSE_FILEMAJORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBSPECTRALRESPONSE_FILEMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBSPECTRALRESPONSE_FILESUBMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->FileHeaderLength = CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->FileDescription, 64); numBytes += 64;
   memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
   memcpy(&buffer[numBytes], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->ExternalLensSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->ManualFilterSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->FWPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->NDFPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 2); numBytes += 2; // FREE space
   memcpy(&buffer[numBytes], &hdr->FWFilterID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->NDFilterID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ManualFilterID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->LensID, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->LowCut, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->HighCut, sizeof(float)); numBytes += sizeof(float);
   memset(&buffer[numBytes], 0, 394); numBytes += 394; // FREE space

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * SpectralResponseFileHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibSpectralResponse_PrintSpectralResponseFileHeader_v2(CalibSpectralResponse_SpectralResponseFileHeader_v2_t *hdr)
{
   FPGA_PRINTF("FileSignature: %s\n", hdr->FileSignature);
   FPGA_PRINTF("FileStructureMajorVersion: %d\n", hdr->FileStructureMajorVersion);
   FPGA_PRINTF("FileStructureMinorVersion: %d\n", hdr->FileStructureMinorVersion);
   FPGA_PRINTF("FileStructureSubMinorVersion: %d\n", hdr->FileStructureSubMinorVersion);
   FPGA_PRINTF("FileHeaderLength: %d bytes\n", hdr->FileHeaderLength);
   FPGA_PRINTF("DeviceSerialNumber: %d\n", hdr->DeviceSerialNumber);
   FPGA_PRINTF("POSIXTime: %d s\n", hdr->POSIXTime);
   FPGA_PRINTF("FileDescription: %s\n", hdr->FileDescription);
   FPGA_PRINTF("SensorID: %d\n", hdr->SensorID);
   FPGA_PRINTF("ExternalLensSerialNumber: %d\n", hdr->ExternalLensSerialNumber);
   FPGA_PRINTF("ManualFilterSerialNumber: %d\n", hdr->ManualFilterSerialNumber);
   FPGA_PRINTF("FWPosition: %d enum\n", hdr->FWPosition);
   FPGA_PRINTF("NDFPosition: %d enum\n", hdr->NDFPosition);
   FPGA_PRINTF("FWFilterID: %d\n", hdr->FWFilterID);
   FPGA_PRINTF("NDFilterID: %d\n", hdr->NDFilterID);
   FPGA_PRINTF("ManualFilterID: %d\n", hdr->ManualFilterID);
   FPGA_PRINTF("LensID: %d\n", hdr->LensID);
   FPGA_PRINTF("LowCut: " _PCF(3) " um\n", _FFMT(hdr->LowCut, 3));
   FPGA_PRINTF("HighCut: " _PCF(3) " um\n", _FFMT(hdr->HighCut, 3));
   FPGA_PRINTF("FileHeaderCRC16: %d\n", hdr->FileHeaderCRC16);
}

/**
 * SpectralResponseDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibSpectralResponse_ParseSpectralResponseDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->SpectralResponseCurveSize, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->Lambda_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->SR_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Lambda_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->SR_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Lambda_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SR_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Lambda_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SR_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 228; // Skip FREE space
   memcpy(&hdr->SpectralResponseDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->SpectralResponseDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * SpectralResponseDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibSpectralResponse_WriteSpectralResponseDataHeader_v2(CalibSpectralResponse_SpectralResponseDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->SpectralResponseCurveSize, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->Lambda_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->SR_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Lambda_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->SR_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Lambda_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SR_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Lambda_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SR_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 228); numBytes += 228; // FREE space
   memcpy(&buffer[numBytes], &hdr->SpectralResponseDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->SpectralResponseDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * SpectralResponseDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibSpectralResponse_PrintSpectralResponseDataHeader_v2(CalibSpectralResponse_SpectralResponseDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %d bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("SpectralResponseCurveSize: %d unit\n", hdr->SpectralResponseCurveSize);
   FPGA_PRINTF("Lambda_Exp: %d\n", hdr->Lambda_Exp);
   FPGA_PRINTF("SR_Exp: %d\n", hdr->SR_Exp);
   FPGA_PRINTF("Lambda_Off: " _PCF(3) "\n", _FFMT(hdr->Lambda_Off, 3));
   FPGA_PRINTF("SR_Off: " _PCF(3) "\n", _FFMT(hdr->SR_Off, 3));
   FPGA_PRINTF("Lambda_Nbits: %d bits\n", hdr->Lambda_Nbits);
   FPGA_PRINTF("SR_Nbits: %d bits\n", hdr->SR_Nbits);
   FPGA_PRINTF("Lambda_Signed: %d 0 / 1\n", hdr->Lambda_Signed);
   FPGA_PRINTF("SR_Signed: %d 0 / 1\n", hdr->SR_Signed);
   FPGA_PRINTF("SpectralResponseDataLength: %d bytes\n", hdr->SpectralResponseDataLength);
   FPGA_PRINTF("SpectralResponseDataCRC16: %d\n", hdr->SpectralResponseDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %d\n", hdr->DataHeaderCRC16);
}

/**
 * SpectralResponseData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibSpectralResponse_ParseSpectralResponseData_v2(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->lambda = ((rawData & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_MASK_V2) >> CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_SHIFT_V2);
   data->SR = ((rawData & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_MASK_V2) >> CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_SHIFT_V2);

   return numBytes;
}

/**
 * SpectralResponseData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibSpectralResponse_WriteSpectralResponseData_v2(CalibSpectralResponse_SpectralResponseData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->lambda;
   rawData |= ((tmpData << CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_SHIFT_V2) & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_MASK_V2);
   tmpData = data->SR;
   rawData |= ((tmpData << CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_SHIFT_V2) & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

