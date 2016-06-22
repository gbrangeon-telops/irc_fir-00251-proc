/**
 * @file CalibActualizationFile_v1.c
 * Camera image correction calibration file structure v1 definition.
 *
 * This file defines camera image correction calibration file structure v1.
 *
 * Auto-generated Image Correction Calibration File library.
 * Generated from the image correction calibration file structure definition XLS file version 1.1.0
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

#include "CalibActualizationFile_v1.h"
#include "CRC.h"
#include <string.h>

/**
 * ActualizationFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibActualization_ParseActualizationFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibActualization_ActualizationFileHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 12)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[0], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSAC") != 0)   {
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
   memcpy(&hdr->ActualizationFileHeaderLength, &buffer[8], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->ActualizationFileHeaderLength)
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
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Width, &buffer[88], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->Height, &buffer[90], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetX, &buffer[92], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetY, &buffer[94], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ReferencePOSIXTime, &buffer[96], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   numBytes += 410; // Skip FREE space
   memcpy(&hdr->ActualizationFileHeaderCRC16, &buffer[510], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->ActualizationFileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * ActualizationFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibActualization_WriteActualizationFileHeader_v1(CalibActualization_ActualizationFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   strncpy(hdr->FileSignature, "TSAC", 4);
   hdr->FileStructureMajorVersion = 1;
   hdr->FileStructureMinorVersion = 1;
   hdr->FileStructureSubMinorVersion = 0;
   hdr->DeviceDataFlowMajorVersion = 1;
   hdr->DeviceDataFlowMinorVersion = 1;
   hdr->ActualizationFileHeaderLength = 512;

   memcpy(&buffer[0], hdr->FileSignature, 4); numBytes += 4;
   memcpy(&buffer[4], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[5], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[6], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[7], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[8], &hdr->ActualizationFileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[12], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[16], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[20], hdr->FileDescription, 64); numBytes += 64;
   memcpy(&buffer[84], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[85], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[86], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[87], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[88], &hdr->Width, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[90], &hdr->Height, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[92], &hdr->OffsetX, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[94], &hdr->OffsetY, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[96], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memset(&buffer[100], 0, 410); numBytes += 410; // FREE space

   hdr->ActualizationFileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[510], &hdr->ActualizationFileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   
   return numBytes;
}

/**
 * ActualizationDataHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibActualization_ParseActualizationDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibActualization_ActualizationDataHeader_v1_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < 4)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->ActualizationDataHeaderLength, &buffer[0], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (buflen < hdr->ActualizationDataHeaderLength)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->Beta0_Off, &buffer[4], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Median, &buffer[8], sizeof(float)); numBytes += sizeof(float);
   memcpy(&hdr->Beta0_Exp, &buffer[12], sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&hdr->Beta0_Nbits, &buffer[13], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->Beta0_Signed, &buffer[14], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 233; // Skip FREE space
   memcpy(&hdr->ActualizationDataLength, &buffer[248], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->ActualizationDataCRC16, &buffer[252], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ActualizationDataHeaderCRC16, &buffer[254], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->ActualizationDataHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * ActualizationDataHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibActualization_WriteActualizationDataHeader_v1(CalibActualization_ActualizationDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   hdr->ActualizationDataHeaderLength = 256;

   memcpy(&buffer[0], &hdr->ActualizationDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[4], &hdr->Beta0_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[8], &hdr->Beta0_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[12], &hdr->Beta0_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[13], &hdr->Beta0_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[14], &hdr->Beta0_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[15], 0, 233); numBytes += 233; // FREE space
   memcpy(&buffer[248], &hdr->ActualizationDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[252], &hdr->ActualizationDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->ActualizationDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[254], &hdr->ActualizationDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   
   return numBytes;
}

/**
 * ActualizationData data parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param data is the pointer to the data structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibActualization_ParseActualizationData_v1(uint8_t *buffer, uint32_t buflen, CalibActualization_ActualizationData_v1_t *data)
{
   uint32_t numBytes = 0;
   uint16_t rawData;

   if (buflen < 2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&rawData, buffer, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   data->DeltaBeta = ((rawData & CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_MASK_V1) >> CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_SHIFT_V1);
   if ((data->DeltaBeta & CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_SIGNPOS_V1) == CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_SIGNPOS_V1)
   {
      // Sign extension
      data->DeltaBeta |= 0xF800;
   }
   data->NewBadPixel = ((rawData & CALIBACTUALIZATION_ACTUALIZATIONDATA_NEWBADPIXEL_MASK_V1) >> CALIBACTUALIZATION_ACTUALIZATIONDATA_NEWBADPIXEL_SHIFT_V1);

   return numBytes;
}

/**
 * ActualizationData data writer.
 *
 * @param data is the pointer to the data structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t CalibActualization_WriteActualizationData_v1(CalibActualization_ActualizationData_v1_t *data, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;
   uint16_t tmpData;
   uint16_t rawData = 0;

   if (buflen < 2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   tmpData = data->DeltaBeta;
   rawData |= ((tmpData << CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_SHIFT_V1) & CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_MASK_V1);
   tmpData = data->NewBadPixel;
   rawData |= ((tmpData << CALIBACTUALIZATION_ACTUALIZATIONDATA_NEWBADPIXEL_SHIFT_V1) & CALIBACTUALIZATION_ACTUALIZATIONDATA_NEWBADPIXEL_MASK_V1);

   memcpy(buffer, &rawData, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

