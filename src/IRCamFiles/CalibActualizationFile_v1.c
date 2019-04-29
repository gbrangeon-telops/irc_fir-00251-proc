/**
 * @file CalibActualizationFile_v1.c
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
 * $Id: CalibActualizationFile_v1.c 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/CalibActualizationFile_v1.c $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "CalibActualizationFile_v1.h"
#include "CRC.h"
#include <string.h>
#include <float.h>

/**
 * ActualizationFileHeader default values.
 */
CalibActualization_ActualizationFileHeader_v1_t CalibActualization_ActualizationFileHeader_v1_default = {
   /* FileSignature = */ "TSAC",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* ActualizationFileHeaderLength = */ 512,
   /* DeviceSerialNumber = */ 0,
   /* POSIXTime = */ 0,
   /* FileDescription = */ "",
   /* DeviceDataFlowMajorVersion = */ 1,
   /* DeviceDataFlowMinorVersion = */ 1,
   /* SensorID = */ 0,
   /* Width = */ 0,
   /* Height = */ 0,
   /* OffsetX = */ 0,
   /* OffsetY = */ 0,
   /* ReferencePOSIXTime = */ 0,
   /* ActualizationFileHeaderCRC16 = */ 0,
};

/**
 * ActualizationDataHeader default values.
 */
CalibActualization_ActualizationDataHeader_v1_t CalibActualization_ActualizationDataHeader_v1_default = {
   /* ActualizationDataHeaderLength = */ 256,
   /* Beta0_Off = */ 0.000000F,
   /* Beta0_Median = */ 0.000000F,
   /* Beta0_Exp = */ 0,
   /* Beta0_Nbits = */ 11,
   /* Beta0_Signed = */ 1,
   /* ActualizationDataLength = */ 0,
   /* ActualizationDataCRC16 = */ 0,
   /* ActualizationDataHeaderCRC16 = */ 0,
};

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

   if (buflen < CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSAC") != 0)
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
   memcpy(&hdr->ActualizationFileHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->ActualizationFileHeaderLength != CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1)
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
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->Width, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->Height, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetX, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->OffsetY, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ReferencePOSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   numBytes += 410; // Skip FREE space
   memcpy(&hdr->ActualizationFileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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

   if (buflen < CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSAC", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = CALIBACTUALIZATION_FILEMAJORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = CALIBACTUALIZATION_FILEMINORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = CALIBACTUALIZATION_FILESUBMINORVERSION_V1;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->ActualizationFileHeaderLength = CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->ActualizationFileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], hdr->FileDescription, 64); numBytes += 64;

   hdr->DeviceDataFlowMajorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->DeviceDataFlowMinorVersion = 1;

   memcpy(&buffer[numBytes], &hdr->DeviceDataFlowMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->SensorID, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->Width, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->Height, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->OffsetX, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->OffsetY, sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&buffer[numBytes], &hdr->ReferencePOSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memset(&buffer[numBytes], 0, 410); numBytes += 410; // FREE space

   hdr->ActualizationFileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->ActualizationFileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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

   if (buflen < CALIBACTUALIZATION_ACTUALIZATIONDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(&hdr->ActualizationDataHeaderLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);

   if (hdr->ActualizationDataHeaderLength != CALIBACTUALIZATION_ACTUALIZATIONDATAHEADER_SIZE_V1)
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
   memcpy(&hdr->ActualizationDataLength, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->ActualizationDataCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);
   memcpy(&hdr->ActualizationDataHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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

   if (buflen < CALIBACTUALIZATION_ACTUALIZATIONDATAHEADER_SIZE_V1)
   {
      // Not enough bytes in buffer
      return 0;
   }


   hdr->ActualizationDataHeaderLength = CALIBACTUALIZATION_ACTUALIZATIONDATAHEADER_SIZE_V1;

   memcpy(&buffer[numBytes], &hdr->ActualizationDataHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Off, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Beta0_Median, sizeof(float)); numBytes += sizeof(float);
   memcpy(&buffer[numBytes], &hdr->Beta0_Exp, sizeof(int8_t)); numBytes += sizeof(int8_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Nbits, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->Beta0_Signed, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 233); numBytes += 233; // FREE space
   memcpy(&buffer[numBytes], &hdr->ActualizationDataLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->ActualizationDataCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   hdr->ActualizationDataHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->ActualizationDataHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

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

   if (buflen < CALIBACTUALIZATION_ACTUALIZATIONDATA_SIZE_V1)
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

   if (buflen < CALIBACTUALIZATION_ACTUALIZATIONDATA_SIZE_V1)
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

