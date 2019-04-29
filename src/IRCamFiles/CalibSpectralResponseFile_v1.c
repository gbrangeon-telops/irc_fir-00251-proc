/**
 * @file CalibSpectralResponseFile_v1.c
 * Camera image correction calibration file structure v1 definition.
 *
 * This file defines camera image correction calibration file structure v1.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 1.1.0
 * using generateIRCamFileCLib.m Matlab script.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (mer., 06 juil. 2016) $
 * $Id: CalibSpectralResponseFile_v1.c 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/CalibSpectralResponseFile_v1.c $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "CalibSpectralResponseFile_v1.h"
#include "CRC.h"
#include <string.h>
#include <float.h>

/**
 * SpectralResponseFileHeader default values.
 */
CalibSpectralResponse_SpectralResponseFileHeader_v1_t CalibSpectralResponse_SpectralResponseFileHeader_v1_default = {
   /* FileSignature = */ "TSSR",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* SpectralResponseFileHeaderLength = */ 512,
   /* DeviceSerialNumber = */ 0,
   /* POSIXTime = */ 0,
   /* FileDescription = */ "",
   /* SensorID = */ 0,
   /* ExternalLensSerialNumber = */ 0,
   /* ManualFilterSerialNumber = */ 0,
   /* FWPosition = */ 0,
   /* NDFPosition = */ 0,
   /* SpectralResponseFileHeaderCRC16 = */ 0,
};

/**
 * SpectralResponseDataHeader default values.
 */
CalibSpectralResponse_SpectralResponseDataHeader_v1_t CalibSpectralResponse_SpectralResponseDataHeader_v1_default = {
   /* SpectralResponseDataHeaderLength = */ 256,
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
   /* SpectralResponseDataHeaderCRC16 = */ 0,
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
uint32_t CalibSpectralResponse_ParseSpectralResponseFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseFileHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V1)
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

   if (hdr->FileStructureMajorVersion != 1)
   {
      // Wrong file major version
      return 0;
   }

   memcpy(&hdr->FileStructureMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileStructureSubMinorVersion, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->SpectralResponseFileHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->SpectralResponseFileHeaderLength != CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V1)
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
   numBytes += 412; // Skip FREE space
   memcpy(&hdr->SpectralResponseFileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->SpectralResponseFileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibSpectralResponse_WriteSpectralResponseFileHeader_v1(CalibSpectralResponse_SpectralResponseFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSSR", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBSPECTRALRESPONSE_FILEMAJORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBSPECTRALRESPONSE_FILEMINORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBSPECTRALRESPONSE_FILESUBMINORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->SpectralResponseFileHeaderLength = CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->SpectralResponseFileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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
   memset(&buffer[numBytes], 0, 412); numBytes += 412; // FREE space

   hdr->SpectralResponseFileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->SpectralResponseFileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
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
uint32_t CalibSpectralResponse_ParseSpectralResponseDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseDataHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->SpectralResponseDataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->SpectralResponseDataHeaderLength != CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V1)
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
   memcpy(&hdr->SpectralResponseDataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->SpectralResponseDataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
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
uint32_t CalibSpectralResponse_WriteSpectralResponseDataHeader_v1(CalibSpectralResponse_SpectralResponseDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->SpectralResponseDataHeaderLength = CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->SpectralResponseDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
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

   hdr->SpectralResponseDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->SpectralResponseDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
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
uint32_t CalibSpectralResponse_ParseSpectralResponseData_v1(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseData_v1_t *data)
{
   uint32_t numBytes = 0;
   uint32_t rawData;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   data->lambda = ((rawData & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_MASK_V1) >> CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_SHIFT_V1);
   data->SR = ((rawData & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_MASK_V1) >> CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_SHIFT_V1);

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
uint32_t CalibSpectralResponse_WriteSpectralResponseData_v1(CalibSpectralResponse_SpectralResponseData_v1_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint32_t tmpData;
   uint32_t rawData = 0;

   if (buflen < CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->lambda;
   rawData |= ((tmpData << CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_SHIFT_V1) & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_MASK_V1);
   tmpData = data->SR;
   rawData |= ((tmpData << CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_SHIFT_V1) & CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_MASK_V1);

   memcpy(buffer, &rawData, sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   return numBytes;
}

