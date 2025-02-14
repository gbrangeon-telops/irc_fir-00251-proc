/**
 * @file CalibCollectionFile_v2.c
 * Camera calibration collection file structure v2 definition.
 *
 * This file defines the camera calibration collection file structure v2.
 *
 * Auto-generated calibration collection file library.
 * Generated from the calibration collection file structure definition XLS file version 2.6.0
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

#include "CalibCollectionFile_v2.h"
#include "CRC.h"
#include "utils.h"
#include "verbose.h"
#include <string.h>
#include <float.h>

/**
 * CollectionFileHeader default values.
 */
CalibCollection_CollectionFileHeader_v2_t CalibCollection_CollectionFileHeader_v2_default = {
   /* FileSignature = */ "TSCO",
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
   /* CollectionType = */ 0,
   /* CalibrationType = */ 3,
   /* IntegrationMode = */ 0,
   /* SensorWellDepth = */ 0,
   /* PixelDataResolution = */ 16,
   /* Width = */ 0,
   /* Height = */ 0,
   /* OffsetX = */ 0,
   /* OffsetY = */ 0,
   /* ReverseX = */ 0,
   /* ReverseY = */ 0,
   /* FWPosition = */ 0,
   /* NDFPosition = */ 0,
   /* ExternalLensSerialNumber = */ 0,
   /* ExternalLensName = */ "",
   /* ManualFilterSerialNumber = */ 0,
   /* ManualFilterName = */ "",
   /* ReferencePOSIXTime = */ 0,
   /* FluxRatio01 = */ 0.000000F,
   /* FluxRatio12 = */ 0.000000F,
   /* FOVPosition = */ 255,
   /* SensorIDMSB = */ 0,
   /* BinningMode = */ 0,
   /* ExtenderRingSerialNumber = */ 0,
   /* ExtenderRingName = */ "",
   /* Block1ImageShiftX = */ 0,
   /* Block1ImageShiftY = */ 0,
   /* Block1ImageRotation = */ 0,
   /* Block2ImageShiftX = */ 0,
   /* Block2ImageShiftY = */ 0,
   /* Block2ImageRotation = */ 0,
   /* Block3ImageShiftX = */ 0,
   /* Block3ImageShiftY = */ 0,
   /* Block3ImageRotation = */ 0,
   /* Block4ImageShiftX = */ 0,
   /* Block4ImageShiftY = */ 0,
   /* Block4ImageRotation = */ 0,
   /* Block5ImageShiftX = */ 0,
   /* Block5ImageShiftY = */ 0,
   /* Block5ImageRotation = */ 0,
   /* Block6ImageShiftX = */ 0,
   /* Block6ImageShiftY = */ 0,
   /* Block6ImageRotation = */ 0,
   /* Block7ImageShiftX = */ 0,
   /* Block7ImageShiftY = */ 0,
   /* Block7ImageRotation = */ 0,
   /* Block8ImageShiftX = */ 0,
   /* Block8ImageShiftY = */ 0,
   /* Block8ImageRotation = */ 0,
   /* CollectionDataLength = */ 0,
   /* NumberOfBlocks = */ 0,
   /* CollectionDataCRC16 = */ 0,
   /* FileHeaderCRC16 = */ 0,
};

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

   if (buflen < CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSCO") != 0)
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

   if (hdr->FileHeaderLength != CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2)
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
   memcpy(&hdr->CollectionType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
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
   memcpy(&hdr->FWPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->NDFPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->ExternalLensSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ExternalLensName, &buffer[numBytes], 64); numBytes += 64;
   hdr->ExternalLensName[64] = '\0';
   memcpy(&hdr->ManualFilterSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ManualFilterName, &buffer[numBytes], 64); numBytes += 64;
   hdr->ManualFilterName[64] = '\0';
   memcpy(&hdr->ReferencePOSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FluxRatio01, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->FluxRatio12, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->FOVPosition, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->SensorIDMSB, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->BinningMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 129; // Skip FREE space
   memcpy(&hdr->ExtenderRingSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(hdr->ExtenderRingName, &buffer[numBytes], 64); numBytes += 64;
   hdr->ExtenderRingName[64] = '\0';
   memcpy(&hdr->Block1ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block1ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block1ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block2ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block2ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block2ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block3ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block3ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block3ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block4ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block4ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block4ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block5ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block5ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block5ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block6ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block6ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block6ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block7ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block7ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block7ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block8ImageShiftX, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block8ImageShiftY, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->Block8ImageRotation, &buffer[numBytes], sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&hdr->CollectionDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   numBytes += 3; // Skip FREE space
   memcpy(&hdr->NumberOfBlocks, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CollectionDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->FileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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

   if (buflen < CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSCO", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBCOLLECTION_FILEMAJORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBCOLLECTION_FILEMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBCOLLECTION_FILESUBMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->FileHeaderLength = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->FileDescription, 64); numBytes += 64;

   hdr->DeviceDataFlowMajorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->DeviceDataFlowMinorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CollectionType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
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
   memcpy(&buffer[numBytes], &hdr->FWPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->NDFPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->ExternalLensSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->ExternalLensName, 64); numBytes += 64;
   memcpy(&buffer[numBytes], &hdr->ManualFilterSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->ManualFilterName, 64); numBytes += 64;
   memcpy(&buffer[numBytes], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->FluxRatio01, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->FluxRatio12, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->FOVPosition, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorIDMSB, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->BinningMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 129); numBytes += 129; // FREE space
   memcpy(&buffer[numBytes], &hdr->ExtenderRingSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->ExtenderRingName, 64); numBytes += 64;
   memcpy(&buffer[numBytes], &hdr->Block1ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block1ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block1ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block2ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block2ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block2ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block3ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block3ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block3ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block4ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block4ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block4ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block5ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block5ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block5ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block6ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block6ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block6ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block7ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block7ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block7ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block8ImageShiftX, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block8ImageShiftY, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->Block8ImageRotation, sizeof(int16_t)); numBytes += sizeof(int16_t);
   memcpy(&buffer[numBytes], &hdr->CollectionDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memset(&buffer[numBytes], 0, 3); numBytes += 3; // FREE space
   memcpy(&buffer[numBytes], &hdr->NumberOfBlocks, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CollectionDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * CollectionFileHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibCollection_PrintCollectionFileHeader_v2(CalibCollection_CollectionFileHeader_v2_t *hdr)
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
   FPGA_PRINTF("CollectionType: %u enum\n", hdr->CollectionType);
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
   FPGA_PRINTF("FWPosition: %u enum\n", hdr->FWPosition);
   FPGA_PRINTF("NDFPosition: %u enum\n", hdr->NDFPosition);
   FPGA_PRINTF("ExternalLensSerialNumber: %u\n", hdr->ExternalLensSerialNumber);
   FPGA_PRINTF("ExternalLensName: %s\n", hdr->ExternalLensName);
   FPGA_PRINTF("ManualFilterSerialNumber: %u\n", hdr->ManualFilterSerialNumber);
   FPGA_PRINTF("ManualFilterName: %s\n", hdr->ManualFilterName);
   FPGA_PRINTF("ReferencePOSIXTime: %u s\n", hdr->ReferencePOSIXTime);
   FPGA_PRINTF("FluxRatio01: " _PCF(3) "\n", _FFMT(hdr->FluxRatio01, 3));
   FPGA_PRINTF("FluxRatio12: " _PCF(3) "\n", _FFMT(hdr->FluxRatio12, 3));
   FPGA_PRINTF("FOVPosition: %u enum\n", hdr->FOVPosition);
   FPGA_PRINTF("SensorIDMSB: %u\n", hdr->SensorIDMSB);
   FPGA_PRINTF("BinningMode: %u enum\n", hdr->BinningMode);
   FPGA_PRINTF("ExtenderRingSerialNumber: %u\n", hdr->ExtenderRingSerialNumber);
   FPGA_PRINTF("ExtenderRingName: %s\n", hdr->ExtenderRingName);
   FPGA_PRINTF("Block1ImageShiftX: %d 0.01 px\n", hdr->Block1ImageShiftX);
   FPGA_PRINTF("Block1ImageShiftY: %d 0.01 px\n", hdr->Block1ImageShiftY);
   FPGA_PRINTF("Block1ImageRotation: %d 0.01 deg\n", hdr->Block1ImageRotation);
   FPGA_PRINTF("Block2ImageShiftX: %d 0.01 px\n", hdr->Block2ImageShiftX);
   FPGA_PRINTF("Block2ImageShiftY: %d 0.01 px\n", hdr->Block2ImageShiftY);
   FPGA_PRINTF("Block2ImageRotation: %d 0.01 deg\n", hdr->Block2ImageRotation);
   FPGA_PRINTF("Block3ImageShiftX: %d 0.01 px\n", hdr->Block3ImageShiftX);
   FPGA_PRINTF("Block3ImageShiftY: %d 0.01 px\n", hdr->Block3ImageShiftY);
   FPGA_PRINTF("Block3ImageRotation: %d 0.01 deg\n", hdr->Block3ImageRotation);
   FPGA_PRINTF("Block4ImageShiftX: %d 0.01 px\n", hdr->Block4ImageShiftX);
   FPGA_PRINTF("Block4ImageShiftY: %d 0.01 px\n", hdr->Block4ImageShiftY);
   FPGA_PRINTF("Block4ImageRotation: %d 0.01 deg\n", hdr->Block4ImageRotation);
   FPGA_PRINTF("Block5ImageShiftX: %d 0.01 px\n", hdr->Block5ImageShiftX);
   FPGA_PRINTF("Block5ImageShiftY: %d 0.01 px\n", hdr->Block5ImageShiftY);
   FPGA_PRINTF("Block5ImageRotation: %d 0.01 deg\n", hdr->Block5ImageRotation);
   FPGA_PRINTF("Block6ImageShiftX: %d 0.01 px\n", hdr->Block6ImageShiftX);
   FPGA_PRINTF("Block6ImageShiftY: %d 0.01 px\n", hdr->Block6ImageShiftY);
   FPGA_PRINTF("Block6ImageRotation: %d 0.01 deg\n", hdr->Block6ImageRotation);
   FPGA_PRINTF("Block7ImageShiftX: %d 0.01 px\n", hdr->Block7ImageShiftX);
   FPGA_PRINTF("Block7ImageShiftY: %d 0.01 px\n", hdr->Block7ImageShiftY);
   FPGA_PRINTF("Block7ImageRotation: %d 0.01 deg\n", hdr->Block7ImageRotation);
   FPGA_PRINTF("Block8ImageShiftX: %d 0.01 px\n", hdr->Block8ImageShiftX);
   FPGA_PRINTF("Block8ImageShiftY: %d 0.01 px\n", hdr->Block8ImageShiftY);
   FPGA_PRINTF("Block8ImageRotation: %d 0.01 deg\n", hdr->Block8ImageRotation);
   FPGA_PRINTF("CollectionDataLength: %u bytes\n", hdr->CollectionDataLength);
   FPGA_PRINTF("NumberOfBlocks: %u\n", hdr->NumberOfBlocks);
   FPGA_PRINTF("CollectionDataCRC16: %u\n", hdr->CollectionDataCRC16);
   FPGA_PRINTF("FileHeaderCRC16: %u\n", hdr->FileHeaderCRC16);
}

