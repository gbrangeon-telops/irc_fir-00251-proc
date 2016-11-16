/**
 * @file CalibImageCorrectionFile_v2.c
 * Camera image correction calibration file structure v2 definition.
 *
 * This file defines camera image correction calibration file structure v2.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 2.1.0
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

#include "CalibImageCorrectionFile_v2.h"
#include "CRC.h"
#include "utils.h"
#include "verbose.h"
#include <string.h>
#include <float.h>

/**
 * ImageCorrectionFileHeader default values.
 */
CalibImageCorrection_ImageCorrectionFileHeader_v2_t CalibImageCorrection_ImageCorrectionFileHeader_v2_default = {
   /* FileSignature = */ "TSIC",
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
   /* ImageCorrectionType = */ 0,
   /* Width = */ 0,
   /* Height = */ 0,
   /* OffsetX = */ 0,
   /* OffsetY = */ 0,
   /* ReferencePOSIXTime = */ 0,
   /* TemperatureInternalLens = */ 0.000000F,
   /* TemperatureReference = */ 0.000000F,
   /* ExposureTime = */ 0.000000F,
   /* FileHeaderCRC16 = */ 0,
};

/**
 * ImageCorrectionDataHeader default values.
 */
CalibImageCorrection_ImageCorrectionDataHeader_v2_t CalibImageCorrection_ImageCorrectionDataHeader_v2_default = {
   /* DataHeaderLength = */ 256,
   /* Beta0_Off = */ 0.000000F,
   /* Beta0_Median = */ 0.000000F,
   /* Beta0_Exp = */ 0,
   /* Beta0_Nbits = */ 11,
   /* Beta0_Signed = */ 1,
   /* ImageCorrectionDataLength = */ 0,
   /* ImageCorrectionDataCRC16 = */ 0,
   /* DataHeaderCRC16 = */ 0,
};

/**
 * ImageCorrectionFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_ParseImageCorrectionFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibImageCorrection_ImageCorrectionFileHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSIC") != 0)
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

   if (hdr->FileHeaderLength != CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2)
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
   memcpy(&hdr->ImageCorrectionType, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Width, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->Height, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetX, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetY, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ReferencePOSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->TemperatureInternalLens, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->TemperatureReference, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->ExposureTime, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   numBytes += 398; // Skip FREE space
   memcpy(&hdr->FileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->FileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * ImageCorrectionFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_WriteImageCorrectionFileHeader_v2(CalibImageCorrection_ImageCorrectionFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSIC", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBIMAGECORRECTION_FILEMAJORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBIMAGECORRECTION_FILEMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBIMAGECORRECTION_FILESUBMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->FileHeaderLength = CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->FileDescription, 64); numBytes += 64;

   hdr->DeviceDataFlowMajorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->DeviceDataFlowMinorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->ImageCorrectionType, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Width, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->Height, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->OffsetX, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->OffsetY, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->TemperatureInternalLens, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->TemperatureReference, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->ExposureTime, sizeof(float)); numBytes += sizeof(float);
   memset(&buffer[numBytes], 0, 398); numBytes += 398; // FREE space

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * ImageCorrectionDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_ParseImageCorrectionDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibImageCorrection_ImageCorrectionDataHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->DataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->DataHeaderLength != CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2)
   {
      // Data header length mismatch
      return 0;
   }

   memcpy(&hdr->Beta0_Off, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Median, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Exp, &buffer[numBytes], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Beta0_Nbits, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Beta0_Signed, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 233; // Skip FREE space
   memcpy(&hdr->ImageCorrectionDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->ImageCorrectionDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->DataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->DataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * ImageCorrectionDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_WriteImageCorrectionDataHeader_v2(CalibImageCorrection_ImageCorrectionDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->DataHeaderLength = CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->DataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Beta0_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Beta0_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 233); numBytes += 233; // FREE space
   memcpy(&buffer[numBytes], &hdr->ImageCorrectionDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->ImageCorrectionDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->DataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->DataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * ImageCorrectionData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_ParseImageCorrectionData_v2(uint8_t *buffer, uint32_t buflen, CalibImageCorrection_ImageCorrectionData_v2_t *data)
{
   uint32_t numBytes = 0;
   uint16_t rawData;

   if (buflen < CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   data->DeltaBeta = ((rawData & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK_V2) >> CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SHIFT_V2);
   if ((data->DeltaBeta & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS_V2) == CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS_V2)
   {
      // Sign extension
      data->DeltaBeta |= 0xF800;
   }
   data->NewBadPixel = ((rawData & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_MASK_V2) >> CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT_V2);

   return numBytes;
}

/**
 * ImageCorrectionData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_WriteImageCorrectionData_v2(CalibImageCorrection_ImageCorrectionData_v2_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint16_t tmpData;
   uint16_t rawData = 0;

   if (buflen < CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->DeltaBeta;
   rawData |= ((tmpData << CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SHIFT_V2) & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK_V2);
   tmpData = data->NewBadPixel;
   rawData |= ((tmpData << CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT_V2) & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

