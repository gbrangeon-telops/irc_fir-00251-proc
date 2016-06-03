/**
 * @file FlashDynamicValues.c
 * Camera flash dynamic values structure definition.
 *
 * This file defines camera flash dynamic values structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "FlashDynamicValues.h"
#include "FileManager.h"
#include "GC_Registers.h"
#include "trig_gen.h"
#include "CRC.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include <string.h> // For memcpy

/* AUTO-CODE BEGIN */
// Auto-generated Flash Dynamic Values library.
// Generated from the Flash Dynamic Values definition XLS file version 1.6.0
// using generateFlashDynamicValuesCLib.m Matlab script.

/**
 * Flash dynamic values default values
 */
flashDynamicValues_t flashDynamicValuesDefault = {
   /* isValid */ 0,
   /* FlashDynamicValuesFileLength = */ 512,
   /* DeviceSerialNumber = */ 0,
   /* POSIXTime = */ 0,
   /* DevicePowerOnCycles = */ 0,
   /* DeviceCoolerPowerOnCycles = */ 0,
   /* DeviceRunningTime = */ 0,
   /* DeviceCoolerRunningTime = */ 0,
   /* CalibrationCollectionPOSIXTimeAtStartup = */ 0,
   /* CalibrationCollectionBlockPOSIXTimeAtStartup = */ 0,
   /* DeviceKeyValidationLow = */ 0xF01BCA90,
   /* DeviceKeyValidationHigh = */ 0x77CFA1EE,
   /* FlashDynamicValuesFileCRC16 = */ 0,
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* PowerOnAtStartup = */ 0,
   /* AcquisitionStartAtStartup = */ 0,
   /* StealthMode = */ 0,
   /* BadPixelReplacement = */ 0,
   /* FileOrderKey1 = */ 1,
   /* FileOrderKey2 = */ 0,
   /* FileOrderKey3 = */ 0,
   /* FileOrderKey4 = */ 0,
   /* CalibrationCollectionFileOrderKey1 = */ 4,
   /* CalibrationCollectionFileOrderKey2 = */ 0,
   /* CalibrationCollectionFileOrderKey3 = */ 0,
   /* CalibrationCollectionFileOrderKey4 = */ 0,
   /* FileSignature = */ "TSDV"
};

/* AUTO-CODE END */

IRC_Status_t FlashDynamicValues_Read(uint8_t *buffer, uint32_t buflen, flashDynamicValues_t *p_flashDynamicValues);
IRC_Status_t FlashDynamicValues_Write(uint8_t *buffer, uint32_t buflen, flashDynamicValues_t *p_flashDynamicValues);
void FlashDynamicValues_UpdateVersion(flashDynamicValues_t *p_flashDynamicValues);

/**
 * Initializes the flash dynamic values.
 */
IRC_Status_t FlashDynamicValues_Init(flashDynamicValues_t *p_flashDynamicValues)
{
   if (FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH > FM_TEMP_FILE_DATA_BUFFER_SIZE)
   {
      FDV_ERR("Flash dynamic values file size (%d) is greater than temporary file buffer size (%d).",
            FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH, FM_TEMP_FILE_DATA_BUFFER_SIZE);
      return IRC_FAILURE;
   }

   if (FM_FileExists(FDV_FILENAME))
   {
      if (FM_ReadDataFromFile(tmpFileDataBuffer, FDV_FILENAME, 0, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH) != IRC_SUCCESS)
      {
         FDV_ERR("Cannot read flash dynamic values file.");
         return IRC_FAILURE;
      }

      if (FlashDynamicValues_Read(tmpFileDataBuffer, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH, p_flashDynamicValues) != IRC_SUCCESS)
      {
         FDV_ERR("Cannot parse flash dynamic values data.");
         return IRC_FAILURE;
      }
   }
   else
   {
      // Initialize flash dynamic values
      *p_flashDynamicValues = flashDynamicValuesDefault;
   }

   return IRC_SUCCESS;
}

/**
 * Read flash dynamic values data from buffer.
 *
 * @param buffer is the bytes buffer used to fill flash dynamic values data structure.
 * @param buflen is the length of the buffer in bytes.
 * @param p_flashDynamicValues is the flash dynamic values data structure to fill
 *        using the flash dynamic values data buffer.
 *
 * @return IRC_SUCCESS if flash dynamic values were successfully read.
 * @return IRC_FAILURE if failed to read flash dynamic values.
 */
IRC_Status_t FlashDynamicValues_Read(uint8_t *buffer, uint32_t buflen, flashDynamicValues_t *p_flashDynamicValues)
{
   uint16_t crc16;

   if (buflen < FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH)
   {
      FDV_ERR("Not enough bytes to read flash dynamic values data.");
      return IRC_FAILURE;
   }

   // Read file signature and validate it
   memcpy(p_flashDynamicValues->FileSignature, &buffer[FDV_FILESIGNATURE_OFFSET], FDV_FILESIGNATURE_LENGTH);
   p_flashDynamicValues->FileSignature[FDV_FILESIGNATURE_LENGTH] = '\0'; // Ensure the string is NULL terminated

   if (strcmp(p_flashDynamicValues->FileSignature, "TSDV") != 0)
   {
      FDV_ERR("Wrong flash dynamic values file signature.");
      return IRC_FAILURE;
   }

   // Read file structure version and validate it
   memcpy(&p_flashDynamicValues->FileStructureMajorVersion, &buffer[FDV_FILESTRUCTUREMAJORVERSION_OFFSET], FDV_FILESTRUCTUREMAJORVERSION_LENGTH);
   memcpy(&p_flashDynamicValues->FileStructureMinorVersion, &buffer[FDV_FILESTRUCTUREMINORVERSION_OFFSET], FDV_FILESTRUCTUREMINORVERSION_LENGTH);
   memcpy(&p_flashDynamicValues->FileStructureSubMinorVersion, &buffer[FDV_FILESTRUCTURESUBMINORVERSION_OFFSET], FDV_FILESTRUCTURESUBMINORVERSION_LENGTH);

   if (p_flashDynamicValues->FileStructureMajorVersion != FDV_FILESTRUCTUREMAJORVERSION)
   {
      FDV_ERR("Flash dynamic values file structure version %d.%d.%d is not supported. The supported version is %d.%d.%d.",
            p_flashDynamicValues->FileStructureMajorVersion,
            p_flashDynamicValues->FileStructureMinorVersion,
            p_flashDynamicValues->FileStructureSubMinorVersion,
            FDV_FILESTRUCTUREMAJORVERSION,
            FDV_FILESTRUCTUREMINORVERSION,
            FDV_FILESTRUCTURESUBMINORVERSION);
      return IRC_FAILURE;
   }

   // Read file length and validate it
   memcpy(&p_flashDynamicValues->FlashDynamicValuesFileLength, &buffer[FDV_FLASHDYNAMICVALUESFILELENGTH_OFFSET], FDV_FLASHDYNAMICVALUESFILELENGTH_LENGTH);

   if (p_flashDynamicValues->FlashDynamicValuesFileLength != FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH)
   {
      FDV_ERR("Wrong flash dynamic values file length.");
      return IRC_FAILURE;
   }

/* AUTO-CODE READ BEGIN */
// Auto-generated Flash Dynamic Values library.
// Generated from the Flash Dynamic Values definition XLS file version 1.6.0
// using generateFlashDynamicValuesCLib.m Matlab script.

   memcpy(&p_flashDynamicValues->DeviceSerialNumber, &buffer[FDV_DEVICESERIALNUMBER_OFFSET], FDV_DEVICESERIALNUMBER_LENGTH);
   memcpy(&p_flashDynamicValues->POSIXTime, &buffer[FDV_POSIXTIME_OFFSET], FDV_POSIXTIME_LENGTH);
   memcpy(&p_flashDynamicValues->DevicePowerOnCycles, &buffer[FDV_DEVICEPOWERONCYCLES_OFFSET], FDV_DEVICEPOWERONCYCLES_LENGTH);
   memcpy(&p_flashDynamicValues->DeviceCoolerPowerOnCycles, &buffer[FDV_DEVICECOOLERPOWERONCYCLES_OFFSET], FDV_DEVICECOOLERPOWERONCYCLES_LENGTH);
   memcpy(&p_flashDynamicValues->DeviceRunningTime, &buffer[FDV_DEVICERUNNINGTIME_OFFSET], FDV_DEVICERUNNINGTIME_LENGTH);
   memcpy(&p_flashDynamicValues->DeviceCoolerRunningTime, &buffer[FDV_DEVICECOOLERRUNNINGTIME_OFFSET], FDV_DEVICECOOLERRUNNINGTIME_LENGTH);
   memcpy(&p_flashDynamicValues->PowerOnAtStartup, &buffer[FDV_POWERONATSTARTUP_OFFSET], FDV_POWERONATSTARTUP_LENGTH);
   memcpy(&p_flashDynamicValues->AcquisitionStartAtStartup, &buffer[FDV_ACQUISITIONSTARTATSTARTUP_OFFSET], FDV_ACQUISITIONSTARTATSTARTUP_LENGTH);
   memcpy(&p_flashDynamicValues->StealthMode, &buffer[FDV_STEALTHMODE_OFFSET], FDV_STEALTHMODE_LENGTH);
   memcpy(&p_flashDynamicValues->BadPixelReplacement, &buffer[FDV_BADPIXELREPLACEMENT_OFFSET], FDV_BADPIXELREPLACEMENT_LENGTH);
   memcpy(&p_flashDynamicValues->CalibrationCollectionPOSIXTimeAtStartup, &buffer[FDV_CALIBRATIONCOLLECTIONPOSIXTIMEATSTARTUP_OFFSET], FDV_CALIBRATIONCOLLECTIONPOSIXTIMEATSTARTUP_LENGTH);
   memcpy(&p_flashDynamicValues->CalibrationCollectionBlockPOSIXTimeAtStartup, &buffer[FDV_CALIBRATIONCOLLECTIONBLOCKPOSIXTIMEATSTARTUP_OFFSET], FDV_CALIBRATIONCOLLECTIONBLOCKPOSIXTIMEATSTARTUP_LENGTH);
   memcpy(&p_flashDynamicValues->DeviceKeyValidationLow, &buffer[FDV_DEVICEKEYVALIDATIONLOW_OFFSET], FDV_DEVICEKEYVALIDATIONLOW_LENGTH);
   memcpy(&p_flashDynamicValues->DeviceKeyValidationHigh, &buffer[FDV_DEVICEKEYVALIDATIONHIGH_OFFSET], FDV_DEVICEKEYVALIDATIONHIGH_LENGTH);
   memcpy(&p_flashDynamicValues->FileOrderKey1, &buffer[FDV_FILEORDERKEY1_OFFSET], FDV_FILEORDERKEY1_LENGTH);
   memcpy(&p_flashDynamicValues->FileOrderKey2, &buffer[FDV_FILEORDERKEY2_OFFSET], FDV_FILEORDERKEY2_LENGTH);
   memcpy(&p_flashDynamicValues->FileOrderKey3, &buffer[FDV_FILEORDERKEY3_OFFSET], FDV_FILEORDERKEY3_LENGTH);
   memcpy(&p_flashDynamicValues->FileOrderKey4, &buffer[FDV_FILEORDERKEY4_OFFSET], FDV_FILEORDERKEY4_LENGTH);
   memcpy(&p_flashDynamicValues->CalibrationCollectionFileOrderKey1, &buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY1_OFFSET], FDV_CALIBRATIONCOLLECTIONFILEORDERKEY1_LENGTH);
   memcpy(&p_flashDynamicValues->CalibrationCollectionFileOrderKey2, &buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY2_OFFSET], FDV_CALIBRATIONCOLLECTIONFILEORDERKEY2_LENGTH);
   memcpy(&p_flashDynamicValues->CalibrationCollectionFileOrderKey3, &buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY3_OFFSET], FDV_CALIBRATIONCOLLECTIONFILEORDERKEY3_LENGTH);
   memcpy(&p_flashDynamicValues->CalibrationCollectionFileOrderKey4, &buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY4_OFFSET], FDV_CALIBRATIONCOLLECTIONFILEORDERKEY4_LENGTH);
   memcpy(&p_flashDynamicValues->FlashDynamicValuesFileCRC16, &buffer[FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET], FDV_FLASHDYNAMICVALUESFILECRC16_LENGTH);
/* AUTO-CODE READ END */

   // Validate flash dynamic values file CRC-16
   crc16 = CRC16(0xFFFF, buffer, FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET);
   if (crc16 != p_flashDynamicValues->FlashDynamicValuesFileCRC16)
   {
      FDV_ERR("Wrong flash dynamic values file CRC-16.");
      return IRC_FAILURE;
   }

   FlashDynamicValues_UpdateVersion(p_flashDynamicValues);

   return IRC_SUCCESS;
}

/**
 * Write flash dynamic values data to buffer.
 *
 * @param buffer is the bytes buffer to fill using flash dynamic values data.
 * @param buflen is the length of the buffer in bytes.
 * @param p_flashDynamicValues is the flash dynamic values data structure used to
 *        build the flash dynamic values data buffer.
 *
 * @return IRC_SUCCESS if flash dynamic values were successfully written.
 * @return IRC_FAILURE if failed to write flash dynamic values.
 */
IRC_Status_t FlashDynamicValues_Write(uint8_t *buffer, uint32_t buflen, flashDynamicValues_t *p_flashDynamicValues)
{
   uint16_t crc16;
   
   if (buflen < FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH)
   {
      FDV_ERR("Not enough bytes to write flash dynamic values data.");
      return IRC_FAILURE;
   }

   memset(buffer, 0, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH);

   strncpy(p_flashDynamicValues->FileSignature, "TSDV", FDV_FILESIGNATURE_LENGTH);
   memcpy(&buffer[FDV_FILESIGNATURE_OFFSET], p_flashDynamicValues->FileSignature, FDV_FILESIGNATURE_LENGTH);

   p_flashDynamicValues->FileStructureMajorVersion = FDV_FILESTRUCTUREMAJORVERSION;
   p_flashDynamicValues->FileStructureMinorVersion = FDV_FILESTRUCTUREMINORVERSION;
   p_flashDynamicValues->FileStructureSubMinorVersion = FDV_FILESTRUCTURESUBMINORVERSION;
   memcpy(&buffer[FDV_FILESTRUCTUREMAJORVERSION_OFFSET], &p_flashDynamicValues->FileStructureMajorVersion, FDV_FILESTRUCTUREMAJORVERSION_LENGTH);
   memcpy(&buffer[FDV_FILESTRUCTUREMINORVERSION_OFFSET], &p_flashDynamicValues->FileStructureMinorVersion, FDV_FILESTRUCTUREMINORVERSION_LENGTH);
   memcpy(&buffer[FDV_FILESTRUCTURESUBMINORVERSION_OFFSET], &p_flashDynamicValues->FileStructureSubMinorVersion, FDV_FILESTRUCTURESUBMINORVERSION_LENGTH);

   p_flashDynamicValues->FlashDynamicValuesFileLength = FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH;
   memcpy(&buffer[FDV_FLASHDYNAMICVALUESFILELENGTH_OFFSET], &p_flashDynamicValues->FlashDynamicValuesFileLength , FDV_FLASHDYNAMICVALUESFILELENGTH_LENGTH);

/* AUTO-CODE WRITE BEGIN */
// Auto-generated Flash Dynamic Values library.
// Generated from the Flash Dynamic Values definition XLS file version 1.6.0
// using generateFlashDynamicValuesCLib.m Matlab script.

   memcpy(&buffer[FDV_DEVICESERIALNUMBER_OFFSET], &p_flashDynamicValues->DeviceSerialNumber, FDV_DEVICESERIALNUMBER_LENGTH);
   memcpy(&buffer[FDV_POSIXTIME_OFFSET], &p_flashDynamicValues->POSIXTime, FDV_POSIXTIME_LENGTH);
   memcpy(&buffer[FDV_DEVICEPOWERONCYCLES_OFFSET], &p_flashDynamicValues->DevicePowerOnCycles, FDV_DEVICEPOWERONCYCLES_LENGTH);
   memcpy(&buffer[FDV_DEVICECOOLERPOWERONCYCLES_OFFSET], &p_flashDynamicValues->DeviceCoolerPowerOnCycles, FDV_DEVICECOOLERPOWERONCYCLES_LENGTH);
   memcpy(&buffer[FDV_DEVICERUNNINGTIME_OFFSET], &p_flashDynamicValues->DeviceRunningTime, FDV_DEVICERUNNINGTIME_LENGTH);
   memcpy(&buffer[FDV_DEVICECOOLERRUNNINGTIME_OFFSET], &p_flashDynamicValues->DeviceCoolerRunningTime, FDV_DEVICECOOLERRUNNINGTIME_LENGTH);
   memcpy(&buffer[FDV_POWERONATSTARTUP_OFFSET], &p_flashDynamicValues->PowerOnAtStartup, FDV_POWERONATSTARTUP_LENGTH);
   memcpy(&buffer[FDV_ACQUISITIONSTARTATSTARTUP_OFFSET], &p_flashDynamicValues->AcquisitionStartAtStartup, FDV_ACQUISITIONSTARTATSTARTUP_LENGTH);
   memcpy(&buffer[FDV_STEALTHMODE_OFFSET], &p_flashDynamicValues->StealthMode, FDV_STEALTHMODE_LENGTH);
   memcpy(&buffer[FDV_BADPIXELREPLACEMENT_OFFSET], &p_flashDynamicValues->BadPixelReplacement, FDV_BADPIXELREPLACEMENT_LENGTH);
   memcpy(&buffer[FDV_CALIBRATIONCOLLECTIONPOSIXTIMEATSTARTUP_OFFSET], &p_flashDynamicValues->CalibrationCollectionPOSIXTimeAtStartup, FDV_CALIBRATIONCOLLECTIONPOSIXTIMEATSTARTUP_LENGTH);
   memcpy(&buffer[FDV_CALIBRATIONCOLLECTIONBLOCKPOSIXTIMEATSTARTUP_OFFSET], &p_flashDynamicValues->CalibrationCollectionBlockPOSIXTimeAtStartup, FDV_CALIBRATIONCOLLECTIONBLOCKPOSIXTIMEATSTARTUP_LENGTH);
   memcpy(&buffer[FDV_DEVICEKEYVALIDATIONLOW_OFFSET], &p_flashDynamicValues->DeviceKeyValidationLow, FDV_DEVICEKEYVALIDATIONLOW_LENGTH);
   memcpy(&buffer[FDV_DEVICEKEYVALIDATIONHIGH_OFFSET], &p_flashDynamicValues->DeviceKeyValidationHigh, FDV_DEVICEKEYVALIDATIONHIGH_LENGTH);
   memcpy(&buffer[FDV_FILEORDERKEY1_OFFSET], &p_flashDynamicValues->FileOrderKey1, FDV_FILEORDERKEY1_LENGTH);
   memcpy(&buffer[FDV_FILEORDERKEY2_OFFSET], &p_flashDynamicValues->FileOrderKey2, FDV_FILEORDERKEY2_LENGTH);
   memcpy(&buffer[FDV_FILEORDERKEY3_OFFSET], &p_flashDynamicValues->FileOrderKey3, FDV_FILEORDERKEY3_LENGTH);
   memcpy(&buffer[FDV_FILEORDERKEY4_OFFSET], &p_flashDynamicValues->FileOrderKey4, FDV_FILEORDERKEY4_LENGTH);
   memcpy(&buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY1_OFFSET], &p_flashDynamicValues->CalibrationCollectionFileOrderKey1, FDV_CALIBRATIONCOLLECTIONFILEORDERKEY1_LENGTH);
   memcpy(&buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY2_OFFSET], &p_flashDynamicValues->CalibrationCollectionFileOrderKey2, FDV_CALIBRATIONCOLLECTIONFILEORDERKEY2_LENGTH);
   memcpy(&buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY3_OFFSET], &p_flashDynamicValues->CalibrationCollectionFileOrderKey3, FDV_CALIBRATIONCOLLECTIONFILEORDERKEY3_LENGTH);
   memcpy(&buffer[FDV_CALIBRATIONCOLLECTIONFILEORDERKEY4_OFFSET], &p_flashDynamicValues->CalibrationCollectionFileOrderKey4, FDV_CALIBRATIONCOLLECTIONFILEORDERKEY4_LENGTH);
/* AUTO-CODE WRITE END */

   crc16 = CRC16(0xFFFF, buffer, FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET);
   memcpy(&buffer[FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET], &crc16, FDV_FLASHDYNAMICVALUESFILECRC16_LENGTH);

   return IRC_SUCCESS;
}

/**
 * Update flash dynamic values file.
 *
 * @param p_flashDynamicValues is the flash dynamic values data structure used to
 *        update flash dynamic values file.
 *
 * @return IRC_SUCCESS if flash dynamic values were successfully updated.
 * @return IRC_FAILURE if failed to update flash dynamic values.
 */
IRC_Status_t FlashDynamicValues_Update(flashDynamicValues_t *p_flashDynamicValues)
{
   extern t_Trig gTrig;
   int fd;
   uint64_t tic;
   uint32_t i;
   fileRecord_t *p_file;

   GETTIME(&tic);

   // Update GenICam registers
   gcRegsData.DeviceRunningTime = p_flashDynamicValues->DeviceRunningTime;
   gcRegsData.DevicePowerOnCycles = p_flashDynamicValues->DevicePowerOnCycles;
   gcRegsData.DeviceCoolerRunningTime = p_flashDynamicValues->DeviceCoolerRunningTime;
   gcRegsData.DeviceCoolerPowerOnCycles = p_flashDynamicValues->DeviceCoolerPowerOnCycles;

   // Build flash dynamic values data
   p_flashDynamicValues->DeviceSerialNumber = gcRegsData.DeviceSerialNumber;
   p_flashDynamicValues->POSIXTime = p_flashDynamicValues->DeviceRunningTime + (TRIG_GetRTC(&gTrig).Seconds % 60);

   if (FlashDynamicValues_Write(tmpFileDataBuffer, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH, p_flashDynamicValues) != IRC_SUCCESS)
   {
      FDV_ERR("Cannot build data buffer.");
      return IRC_FAILURE;
   }

   if (FM_FileExists(FDV_FILENAME))
   {
      // Create flash dynamic values temporary file
      fd = uffs_open(FDV_LONG_TMP_FILENAME, UO_WRONLY | UO_CREATE | UO_TRUNC);
      if (fd == -1)
      {
         FDV_ERR("Temporary file create failed.");
         return IRC_FAILURE;
      }

      // Write flash dynamic values file
      if (uffs_write(fd, tmpFileDataBuffer, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH) != FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH)
      {
         FM_ERR("File write failed.");
         return IRC_FAILURE;
      }

      // Close flash dynamic values temporary file
      if (uffs_close(fd) == -1)
      {
         FM_ERR("Temporary file close failed.\n");
         return IRC_FAILURE;
      }

      // Remove old flash dynamic values file
      if (uffs_remove(FDV_LONG_FILENAME) == -1)
      {
         FDV_ERR("Cannot remove old file.");
         return IRC_FAILURE;
      }

      // Rename flash dynamic values temporary file
      if (uffs_rename(FDV_LONG_TMP_FILENAME, FDV_LONG_FILENAME) == -1)
      {
         FDV_ERR("Cannot rename temporary file.");
         return IRC_FAILURE;
      }

      // Update flash dynamic values file POSIX time and device serial number
      p_file = FM_FindFileNameInList(FDV_FILENAME, &gFM_files);
      if (p_file == NULL)
      {
         FDV_ERR("Cannot update file POSIX time.");
         return IRC_FAILURE;
      }

      p_file->deviceSerialNumber = p_flashDynamicValues->DeviceSerialNumber;
      p_file->posixTime = p_flashDynamicValues->POSIXTime;
   }
   else
   {
      // Find empty file record index
      i = 0;
      while ((i < FM_MAX_NUM_FILE) && (gFM_fileDB[i].name[0] != '\0'))
      {
         i++;
      }

      if (i == FM_MAX_NUM_FILE)
      {
         FDV_ERR("File system is full.");
         return IRC_FAILURE;
      }

      // Create flash dynamic values file
      fd = uffs_open(FDV_LONG_FILENAME, UO_WRONLY | UO_CREATE | UO_TRUNC);
      if (fd == -1)
      {
         FDV_ERR("File create failed.");
         return IRC_FAILURE;
      }

      // Write flash dynamic values file
      if (uffs_write(fd, tmpFileDataBuffer, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH) != FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH)
      {
         FM_ERR("Initial file write failed.");
         return IRC_FAILURE;
      }

      // Close flash dynamic values file
      if (uffs_close(fd) == -1)
      {
         FM_ERR("File close failed.\n");
         return IRC_FAILURE;
      }

      strcpy(gFM_fileDB[i].name, FDV_FILENAME);
      gFM_fileDB[i].size = FM_GetFileSize(gFM_fileDB[i].name);

      // Close flash dynamic values file data
      if (FM_CloseFile(&gFM_fileDB[i], FMP_RUNNING) != IRC_SUCCESS)
      {
         FDV_ERR("Cannot close flash dynamic values file.");
         return IRC_FAILURE;
      }

      // Add file to list
      FM_AddFileToList(&gFM_fileDB[i], &gFM_files, NULL);
   }

   FDV_DBG("Flash dynamic values file has been successfully updated (%dms).", elapsed_time_us(tic) / 1000);

   return IRC_SUCCESS;
}

/**
 * Recover interrupted flash dynamic values file update by
 * searching for temporary file and finishing the update.
 */
IRC_Status_t FlashDynamicValues_Recover()
{
   uffs_DIR *dir;
   struct uffs_dirent *de;
   uint16_t crc16;
   uint8_t tmpFileIsValid = 0;

   // Search temporary flash dynamic values file
   dir = uffs_opendir(FM_UFFS_MOUNT_POINT);
   if (dir != NULL)
   {
      while ((de = uffs_readdir(dir)) != NULL)
      {
         if (strcmp(de->d_name, FDV_TMP_FILENAME) == 0)
         {
            FM_ERR("Flash dynamic values temporary file found. Recovering...");

            // Check if flash dynamic values temporary file is valid
            if (FM_ReadDataFromFile(tmpFileDataBuffer, FDV_TMP_FILENAME, 0, FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH) == IRC_SUCCESS)
            {
               memcpy(&crc16, &tmpFileDataBuffer[FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET], FDV_FLASHDYNAMICVALUESFILECRC16_LENGTH);
               if (crc16 == CRC16(0xFFFF, tmpFileDataBuffer, FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET))
               {
                  tmpFileIsValid = 1;
               }
            }

            // Finish flash dynamic values file update
            if (tmpFileIsValid == 1)
            {
               if (FM_FileExists(FDV_FILENAME))
               {
                  // Remove old flash dynamic values file
                  if (uffs_remove(FDV_LONG_FILENAME) == -1)
                  {
                     FDV_ERR("Cannot remove file.");
                     return IRC_FAILURE;
                  }
               }

               // Rename flash dynamic values temporary file
               if (uffs_rename(FDV_LONG_TMP_FILENAME, FDV_LONG_FILENAME) == -1)
               {
                  FDV_ERR("Cannot rename temporary file.");
                  return IRC_FAILURE;
               }
            }
            else
            {
               // Remove flash dynamic values temporary file
               if (uffs_remove(FDV_LONG_TMP_FILENAME) == -1)
               {
                  FDV_ERR("Cannot remove temporary file.");
                  return IRC_FAILURE;
               }
            }
         }
      }
   }

   return IRC_SUCCESS;
}

/**
 * Update flash dynamic values data to current version using default values.
 *
 * @param p_flashSettings is the pointer to flash dynamic values data structure to update.
 */
void FlashDynamicValues_UpdateVersion(flashDynamicValues_t *p_flashDynamicValues)
{
   switch (p_flashDynamicValues->FileStructureMajorVersion)
   {
      case 1:
         // 1.x.x
         switch (p_flashDynamicValues->FileStructureMinorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x
               p_flashDynamicValues->PowerOnAtStartup = flashDynamicValuesDefault.PowerOnAtStartup;
               p_flashDynamicValues->AcquisitionStartAtStartup = flashDynamicValuesDefault.AcquisitionStartAtStartup;

            case 1:
               // 1.1.x -> 1.2.x
               p_flashDynamicValues->StealthMode = flashDynamicValuesDefault.StealthMode;

            case 2:
               // 1.2.x -> 1.3.x
               p_flashDynamicValues->CalibrationCollectionPOSIXTimeAtStartup = flashDynamicValuesDefault.CalibrationCollectionPOSIXTimeAtStartup;
               p_flashDynamicValues->CalibrationCollectionBlockPOSIXTimeAtStartup = flashDynamicValuesDefault.CalibrationCollectionBlockPOSIXTimeAtStartup;

             case 3:
               // 1.3.x -> 1.4.x
               p_flashDynamicValues->DeviceKeyValidationLow = flashDynamicValuesDefault.DeviceKeyValidationLow;
               p_flashDynamicValues->DeviceKeyValidationHigh = flashDynamicValuesDefault.DeviceKeyValidationHigh;

             case 4:
               // 1.4.x -> 1.5.x
               p_flashDynamicValues->BadPixelReplacement = flashDynamicValuesDefault.BadPixelReplacement;

             case 5:
               // 1.5.x -> 1.6.x
               p_flashDynamicValues->FileOrderKey1 = flashDynamicValuesDefault.FileOrderKey1;
               p_flashDynamicValues->FileOrderKey2 = flashDynamicValuesDefault.FileOrderKey2;
               p_flashDynamicValues->FileOrderKey3 = flashDynamicValuesDefault.FileOrderKey3;
               p_flashDynamicValues->FileOrderKey4 = flashDynamicValuesDefault.FileOrderKey4;
               p_flashDynamicValues->CalibrationCollectionFileOrderKey1 = flashDynamicValuesDefault.CalibrationCollectionFileOrderKey1;
               p_flashDynamicValues->CalibrationCollectionFileOrderKey2 = flashDynamicValuesDefault.CalibrationCollectionFileOrderKey2;
               p_flashDynamicValues->CalibrationCollectionFileOrderKey3 = flashDynamicValuesDefault.CalibrationCollectionFileOrderKey3;
               p_flashDynamicValues->CalibrationCollectionFileOrderKey4 = flashDynamicValuesDefault.CalibrationCollectionFileOrderKey4;

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

   FDV_INF("File structure version %d.%d.%d has been updated to version %d.%d.%d.",
         p_flashDynamicValues->FileStructureMajorVersion,
         p_flashDynamicValues->FileStructureMinorVersion,
         p_flashDynamicValues->FileStructureSubMinorVersion,
         FDV_FILESTRUCTUREMAJORVERSION,
         FDV_FILESTRUCTUREMINORVERSION,
         FDV_FILESTRUCTURESUBMINORVERSION);

   p_flashDynamicValues->FileStructureMinorVersion = FDV_FILESTRUCTUREMINORVERSION;
   p_flashDynamicValues->FileStructureSubMinorVersion = FDV_FILESTRUCTURESUBMINORVERSION;
}
