/**
 * @file CalibCollectionFile_v2.c
 * Camera image correction calibration file structure v2 definition.
 *
 * This file defines camera image correction calibration file structure v2.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 2.0.0
 * using generateIRCamCalibrationFileCLib.m Matlab script.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "CalibCollectionFile_v2.h"
#include "CRC.h"
#include <string.h>

/**
 * CollectionFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibCollection_ParseCollectionFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibCollection_CollectionFileHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 12)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[0], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSCO") != 0)   {
      // Wrong file signature
      return 0;
   }

   memcpy(&hdr->FileStructureMajorVersion, &buffer[4], sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   if (hdr->FileStructureMajorVersion != 2)   {
      // Wrong file major version
      return 0;
   }

   memcpy(&hdr->FileStructureMinorVersion, &buffer[5], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileStructureSubMinorVersion, &buffer[6], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->FileHeaderLength, &buffer[8], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->FileHeaderLength)
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
   memcpy(&hdr->CollectionType, &buffer[87], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
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
   memcpy(&hdr->FWPosition, &buffer[102], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NDFPosition, &buffer[103], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->ExternalLensSerialNumber, &buffer[104], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ExternalLensName, &buffer[108], 64); numBytes += 64;
   hdr->ExternalLensName[64] = '\0';
   memcpy(&hdr->ManualFilterSerialNumber, &buffer[172], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ManualFilterName, &buffer[176], 64); numBytes += 64;
   hdr->ManualFilterName[64] = '\0';
   memcpy(&hdr->ReferencePOSIXTime, &buffer[240], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FluxRatio01, &buffer[244], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->FluxRatio12, &buffer[248], sizeof(float)); numBytes += sizeof(float);
   numBytes += 248; // Skip FREE space
   memcpy(&hdr->CollectionDataLength, &buffer[500], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   numBytes += 3; // Skip FREE space
   memcpy(&hdr->NumberOfBlocks, &buffer[507], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CollectionDataCRC16, &buffer[508], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->FileHeaderCRC16, &buffer[510], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->FileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * CollectionFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibCollection_WriteCollectionFileHeader_v2(CalibCollection_CollectionFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   strncpy(hdr->FileSignature, "TSCO", 4);
   hdr->FileStructureMajorVersion = 2;
   hdr->FileStructureMinorVersion = 0;
   hdr->FileStructureSubMinorVersion = 0;
   hdr->DeviceDataFlowMajorVersion = 1;
   hdr->DeviceDataFlowMinorVersion = 1;
   hdr->FileHeaderLength = 512;

   memcpy(&buffer[0], hdr->FileSignature, 4); numBytes += 4;
   memcpy(&buffer[4], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[5], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[6], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[7], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[8], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[12], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[16], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[20], hdr->FileDescription, 64); numBytes += 64;
   memcpy(&buffer[84], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[85], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[86], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[87], &hdr->CollectionType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
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
   memcpy(&buffer[102], &hdr->FWPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[103], &hdr->NDFPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[104], &hdr->ExternalLensSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[108], hdr->ExternalLensName, 64); numBytes += 64;
   memcpy(&buffer[172], &hdr->ManualFilterSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[176], hdr->ManualFilterName, 64); numBytes += 64;
   memcpy(&buffer[240], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[244], &hdr->FluxRatio01, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[248], &hdr->FluxRatio12, sizeof(float)); numBytes += sizeof(float);
   memset(&buffer[252], 0, 248); numBytes += 248; // FREE space
   memcpy(&buffer[500], &hdr->CollectionDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memset(&buffer[504], 0, 3); numBytes += 3; // FREE space
   memcpy(&buffer[507], &hdr->NumberOfBlocks, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[508], &hdr->CollectionDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[510], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

