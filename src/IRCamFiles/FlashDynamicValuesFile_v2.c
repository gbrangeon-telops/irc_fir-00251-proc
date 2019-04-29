/**
 * @file FlashDynamicValuesFile_v2.c
 * Camera flash dynamic values file structure v2 definition.
 *
 * This file defines the camera flash dynamic values file structure v2.
 *
 * Auto-generated flash dynamic values file library.
 * Generated from the flash dynamic values file structure definition XLS file version 2.2.0
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

#include "FlashDynamicValuesFile_v2.h"
#include "CRC.h"
#include "utils.h"
#include "verbose.h"
#include <string.h>
#include <float.h>

/**
 * FlashDynamicValuesFileHeader default values.
 */
FlashDynamicValues_FlashDynamicValuesFileHeader_v2_t FlashDynamicValues_FlashDynamicValuesFileHeader_v2_default = {
   /* FileSignature = */ "TSDV",
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* FileHeaderLength = */ 512,
   /* DeviceSerialNumber = */ 0,
   /* POSIXTime = */ 0,
   /* DevicePowerOnCycles = */ 0,
   /* DeviceCoolerPowerOnCycles = */ 0,
   /* DeviceRunningTime = */ 0,
   /* DeviceCoolerRunningTime = */ 0,
   /* PowerOnAtStartup = */ 0,
   /* AcquisitionStartAtStartup = */ 0,
   /* StealthMode = */ 0,
   /* BadPixelReplacement = */ 0,
   /* CalibrationCollectionPOSIXTimeAtStartup = */ 0,
   /* CalibrationCollectionBlockPOSIXTimeAtStartup = */ 0,
   /* DeviceKeyValidationLow = */ 0xF01BCA90,
   /* DeviceKeyValidationHigh = */ 0x77CFA1EE,
   /* FileOrderKey1 = */ 1,
   /* FileOrderKey2 = */ 0,
   /* FileOrderKey3 = */ 0,
   /* FileOrderKey4 = */ 0,
   /* CalibrationCollectionFileOrderKey1 = */ 4,
   /* CalibrationCollectionFileOrderKey2 = */ 0,
   /* CalibrationCollectionFileOrderKey3 = */ 0,
   /* CalibrationCollectionFileOrderKey4 = */ 0,
   /* DeviceSerialPortFunctionRS232 = */ 1,
   /* FileOrderKey5 = */ 0,
   /* CalibrationCollectionFileOrderKey5 = */ 0,
   /* AutofocusROI = */ 50.0F,
   /* FileHeaderCRC16 = */ 0,
};

/**
 * FlashDynamicValuesFileHeader parser.
 *
 * @param buffer is the byte buffer to parse.
 * @param buflen is the byte buffer length.
 * @param hdr is the pointer to the header structure to fill.
 *
 * @return the number of byte read from the buffer.
 * @return 0 if an error occurred.
 */
uint32_t FlashDynamicValues_ParseFlashDynamicValuesFileHeader_v2(uint8_t *buffer, uint32_t buflen, FlashDynamicValues_FlashDynamicValuesFileHeader_v2_t *hdr)
{
   uint32_t numBytes = 0;

   if (buflen < FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }

   memcpy(hdr->FileSignature, &buffer[numBytes], 4); numBytes += 4;
   hdr->FileSignature[4] = '\0';

   if (strcmp(hdr->FileSignature, "TSDV") != 0)
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

   if (hdr->FileHeaderLength != FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE_V2)
   {
      // File header length mismatch
      return 0;
   }

   memcpy(&hdr->DeviceSerialNumber, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->POSIXTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->DevicePowerOnCycles, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->DeviceCoolerPowerOnCycles, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->DeviceRunningTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->DeviceCoolerRunningTime, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->PowerOnAtStartup, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->AcquisitionStartAtStartup, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->StealthMode, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->BadPixelReplacement, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationCollectionPOSIXTimeAtStartup, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->CalibrationCollectionBlockPOSIXTimeAtStartup, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->DeviceKeyValidationLow, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->DeviceKeyValidationHigh, &buffer[numBytes], sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&hdr->FileOrderKey1, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileOrderKey2, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileOrderKey3, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileOrderKey4, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationCollectionFileOrderKey1, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationCollectionFileOrderKey2, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationCollectionFileOrderKey3, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationCollectionFileOrderKey4, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->DeviceSerialPortFunctionRS232, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->FileOrderKey5, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&hdr->CalibrationCollectionFileOrderKey5, &buffer[numBytes], sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   numBytes += 1; // Skip FREE space
   memcpy(&hdr->AutofocusROI, &buffer[numBytes], sizeof(float)); numBytes += sizeof(float);
   numBytes += 438; // Skip FREE space
   memcpy(&hdr->FileHeaderCRC16, &buffer[numBytes], sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   if (hdr->FileHeaderCRC16 != CRC16(0xFFFF, buffer, numBytes - sizeof(uint16_t)))
   {
      // CRC-16 test failed
      return 0;
   }

   return numBytes;
}

/**
 * FlashDynamicValuesFileHeader writer.
 *
 * @param hdr is the pointer to the header structure to write.
 * @param buffer is the byte buffer to write.
 * @param buflen is the byte buffer length.
 *
 * @return the number of byte written to the buffer.
 * @return 0 if an error occurred.
 */
uint32_t FlashDynamicValues_WriteFlashDynamicValuesFileHeader_v2(FlashDynamicValues_FlashDynamicValuesFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen)
{
   uint32_t numBytes = 0;

   if (buflen < FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE_V2)
   {
      // Not enough bytes in buffer
      return 0;
   }


   strncpy(hdr->FileSignature, "TSDV", 4);

   memcpy(&buffer[numBytes], hdr->FileSignature, 4); numBytes += 4;

   hdr->FileStructureMajorVersion = FLASHDYNAMICVALUES_FILEMAJORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMajorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureMinorVersion = FLASHDYNAMICVALUES_FILEMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);

   hdr->FileStructureSubMinorVersion = FLASHDYNAMICVALUES_FILESUBMINORVERSION_V2;

   memcpy(&buffer[numBytes], &hdr->FileStructureSubMinorVersion, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space

   hdr->FileHeaderLength = FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE_V2;

   memcpy(&buffer[numBytes], &hdr->FileHeaderLength, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialNumber, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->POSIXTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DevicePowerOnCycles, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceCoolerPowerOnCycles, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceRunningTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceCoolerRunningTime, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->PowerOnAtStartup, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->AcquisitionStartAtStartup, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->StealthMode, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->BadPixelReplacement, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionPOSIXTimeAtStartup, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionBlockPOSIXTimeAtStartup, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceKeyValidationLow, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->DeviceKeyValidationHigh, sizeof(uint32_t)); numBytes += sizeof(uint32_t);
   memcpy(&buffer[numBytes], &hdr->FileOrderKey1, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FileOrderKey2, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FileOrderKey3, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FileOrderKey4, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionFileOrderKey1, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionFileOrderKey2, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionFileOrderKey3, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionFileOrderKey4, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->DeviceSerialPortFunctionRS232, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->FileOrderKey5, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memcpy(&buffer[numBytes], &hdr->CalibrationCollectionFileOrderKey5, sizeof(uint8_t)); numBytes += sizeof(uint8_t);
   memset(&buffer[numBytes], 0, 1); numBytes += 1; // FREE space
   memcpy(&buffer[numBytes], &hdr->AutofocusROI, sizeof(float)); numBytes += sizeof(float);
   memset(&buffer[numBytes], 0, 438); numBytes += 438; // FREE space

   hdr->FileHeaderCRC16 = CRC16(0xFFFF, buffer, numBytes);
   memcpy(&buffer[numBytes], &hdr->FileHeaderCRC16, sizeof(uint16_t)); numBytes += sizeof(uint16_t);

   return numBytes;
}

