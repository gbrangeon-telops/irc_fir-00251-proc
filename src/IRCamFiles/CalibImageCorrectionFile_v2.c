/**
 * @file CalibImageCorrectionFile_v2.c
 * Camera image correction calibration file structure v2 definition.
 *
 * This file defines the camera image correction calibration file structure v2.
 *
 * Auto-generated image correction calibration file library.
 * Generated from the image correction calibration file structure definition XLS file version 2.6.0
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
   /* AcquisitionFrameRate = */ 0,
   /* BinningMode = */ 0,
   /* SensorIDMSB = */ 0,
   /* FWMode = */ 0,
   /* FocusPositionRaw = */ 0,
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
   memcpy(&hdr->AcquisitionFrameRate, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->BinningMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->SensorIDMSB, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FWMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FocusPositionRaw, &buffer[numBytes], sizeof(int32_t)); numBytes += sizeof(int32_t);
   numBytes += 386; // Skip FREE space
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
   memcpy(&buffer[numBytes], &hdr->AcquisitionFrameRate, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->BinningMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->SensorIDMSB, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FWMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FocusPositionRaw, sizeof(int32_t)); numBytes += sizeof(int32_t);
   memset(&buffer[numBytes], 0, 386); numBytes += 386; // FREE space

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

/**
 * ImageCorrectionFileHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibImageCorrection_PrintImageCorrectionFileHeader_v2(CalibImageCorrection_ImageCorrectionFileHeader_v2_t *hdr)
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
   FPGA_PRINTF("ImageCorrectionType: %u\n", hdr->ImageCorrectionType);
   FPGA_PRINTF("Width: %u pixels\n", hdr->Width);
   FPGA_PRINTF("Height: %u pixels\n", hdr->Height);
   FPGA_PRINTF("OffsetX: %u pixels\n", hdr->OffsetX);
   FPGA_PRINTF("OffsetY: %u pixels\n", hdr->OffsetY);
   FPGA_PRINTF("ReferencePOSIXTime: %u s\n", hdr->ReferencePOSIXTime);
   FPGA_PRINTF("TemperatureInternalLens: " _PCF(3) " K\n", _FFMT(hdr->TemperatureInternalLens, 3));
   FPGA_PRINTF("TemperatureReference: " _PCF(3) " K\n", _FFMT(hdr->TemperatureReference, 3));
   FPGA_PRINTF("ExposureTime: " _PCF(3) " us\n", _FFMT(hdr->ExposureTime, 3));
   FPGA_PRINTF("AcquisitionFrameRate: %u mHz\n", hdr->AcquisitionFrameRate);
   FPGA_PRINTF("BinningMode: %u enum\n", hdr->BinningMode);
   FPGA_PRINTF("SensorIDMSB: %u\n", hdr->SensorIDMSB);
   FPGA_PRINTF("FWMode: %u enum\n", hdr->FWMode);
   FPGA_PRINTF("FocusPositionRaw: %d counts\n", hdr->FocusPositionRaw);
   FPGA_PRINTF("FileHeaderCRC16: %u\n", hdr->FileHeaderCRC16);
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
 * ImageCorrectionDataHeader printer.
 *
 * @param hdr is the pointer to the header structure to print.
 */
void CalibImageCorrection_PrintImageCorrectionDataHeader_v2(CalibImageCorrection_ImageCorrectionDataHeader_v2_t *hdr)
{
   FPGA_PRINTF("DataHeaderLength: %u bytes\n", hdr->DataHeaderLength);
   FPGA_PRINTF("Beta0_Off: " _PCF(3) "\n", _FFMT(hdr->Beta0_Off, 3));
   FPGA_PRINTF("Beta0_Median: " _PCF(3) "\n", _FFMT(hdr->Beta0_Median, 3));
   FPGA_PRINTF("Beta0_Exp: %d\n", hdr->Beta0_Exp);
   FPGA_PRINTF("Beta0_Nbits: %u bits\n", hdr->Beta0_Nbits);
   FPGA_PRINTF("Beta0_Signed: %u 0 / 1\n", hdr->Beta0_Signed);
   FPGA_PRINTF("ImageCorrectionDataLength: %u bytes\n", hdr->ImageCorrectionDataLength);
   FPGA_PRINTF("ImageCorrectionDataCRC16: %u\n", hdr->ImageCorrectionDataCRC16);
   FPGA_PRINTF("DataHeaderCRC16: %u\n", hdr->DataHeaderCRC16);
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
   data->NoisyBadPixel = ((rawData & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NOISYBADPIXEL_MASK_V2) >> CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NOISYBADPIXEL_SHIFT_V2);
   data->FlickerBadPixel = ((rawData & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_FLICKERBADPIXEL_MASK_V2) >> CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_FLICKERBADPIXEL_SHIFT_V2);
   data->OutlierBadPixel = ((rawData & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_OUTLIERBADPIXEL_MASK_V2) >> CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_OUTLIERBADPIXEL_SHIFT_V2);

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
   tmpData = data->NoisyBadPixel;
   rawData |= ((tmpData << CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NOISYBADPIXEL_SHIFT_V2) & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NOISYBADPIXEL_MASK_V2);
   tmpData = data->FlickerBadPixel;
   rawData |= ((tmpData << CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_FLICKERBADPIXEL_SHIFT_V2) & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_FLICKERBADPIXEL_MASK_V2);
   tmpData = data->OutlierBadPixel;
   rawData |= ((tmpData << CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_OUTLIERBADPIXEL_SHIFT_V2) & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_OUTLIERBADPIXEL_MASK_V2);

   memcpy(buffer, &rawData, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

