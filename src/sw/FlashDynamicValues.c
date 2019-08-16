/**
 * @file FlashDynamicValues.c
 * Camera flash dynamic values module implementation.
 *
 * This file implements camera flash dynamic values module.
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
#include "GC_Registers.h"
#include "trig_gen.h"
#include "FileManager.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include <string.h> // For memcpy

uint8_t gDisableFlashDynamicValuesUpdate = 0;

IRC_Status_t FlashDynamicValues_ReadFlashDynamicValuesFile(const char *filename, flashDynamicValues_t *p_flashDynamicValues);


/**
 * Read flash dynamic values file.
 *
 * @param filename is the flash dynamic values fle name to read.
 * @param p_flashDynamicValues is the pointer to the flash dynamic values data structure to fill.
 *
 * @return IRC_SUCCESS if successfully read flash dynamic values file.
 * @return IRC_FAILURE if failed to read flash dynamic values file.
 */
IRC_Status_t FlashDynamicValues_ReadFlashDynamicValuesFile(const char *filename, flashDynamicValues_t *p_flashDynamicValues)
{
   int fd;

   fd = FM_OpenFile(filename, UO_RDONLY);
   if (fd == -1)
   {
      return IRC_FAILURE;
   }

   if (FlashDynamicValues_ParseFlashDynamicValuesFileHeader(fd, p_flashDynamicValues, NULL) == 0)
   {
      return IRC_FAILURE;
   }

   if (uffs_close(fd) == -1)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes the flash dynamic values.
 *
 * @param p_flashDynamicValues is the pointer to the flash dynamic values data structure to fill.
 */
IRC_Status_t FlashDynamicValues_Init(flashDynamicValues_t *p_flashDynamicValues)
{
   extern flashDynamicValues_t flashDynamicValues_default;

   if (FM_FileExists(FDV_FILENAME))
   {
      if (FlashDynamicValues_ReadFlashDynamicValuesFile(FDV_FILENAME, p_flashDynamicValues) != IRC_SUCCESS)
      {
         FDV_ERR("Cannot read flash dynamic values file.");
         return IRC_FAILURE;
      }
   }
   else
   {
      // Initialize flash dynamic values
      *p_flashDynamicValues = flashDynamicValues_default;
   }

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
   char filelongname[FM_LONG_FILENAME_SIZE];

   if (gDisableFlashDynamicValuesUpdate != 0)
   {
      FDV_ERR("Flash dynamic values update is disabled.");
      return IRC_FAILURE;
   }
   
   GETTIME(&tic);

   // Update GenICam registers
   gcRegsData.DeviceRunningTime = p_flashDynamicValues->DeviceRunningTime;
   gcRegsData.DevicePowerOnCycles = p_flashDynamicValues->DevicePowerOnCycles;
   gcRegsData.DeviceCoolerRunningTime = p_flashDynamicValues->DeviceCoolerRunningTime;
   gcRegsData.DeviceCoolerPowerOnCycles = p_flashDynamicValues->DeviceCoolerPowerOnCycles;

   // Build flash dynamic values data
   p_flashDynamicValues->DeviceSerialNumber = gcRegsData.DeviceSerialNumber;
   p_flashDynamicValues->POSIXTime = p_flashDynamicValues->DeviceRunningTime + (TRIG_GetRTC(&gTrig).Seconds % 60);

   if (FlashDynamicValues_WriteFlashDynamicValuesFileHeader(p_flashDynamicValues, tmpFileDataBuffer, FM_TEMP_FILE_DATA_BUFFER_SIZE) == 0)
   {
      FDV_ERR("Cannot build data buffer.");
      return IRC_FAILURE;
   }

   if (FM_FileExists(FDV_FILENAME))
   {
      // Create flash dynamic values temporary file
      fd = FM_OpenFile(FDV_TMP_FILENAME, UO_WRONLY | UO_CREATE | UO_TRUNC);
      if (fd == -1)
      {
         FDV_ERR("Temporary file create failed.");
         return IRC_FAILURE;
      }

      // Write flash dynamic values file
      if (uffs_write(fd, tmpFileDataBuffer, FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE) != FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE)
      {
         FM_ERR("File write failed.");
         uffs_close(fd);
         sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, FDV_TMP_FILENAME);
         uffs_remove(filelongname);
         return IRC_FAILURE;
      }

      // Close flash dynamic values temporary file
      if (uffs_close(fd) == -1)
      {
         FM_ERR("Temporary file close failed.\n");
         return IRC_FAILURE;
      }

      // Remove old flash dynamic values file
      if (uffs_remove(FM_UFFS_MOUNT_POINT FDV_FILENAME) == -1)
      {
         FDV_ERR("Cannot remove old file.");
         return IRC_FAILURE;
      }

      // Rename flash dynamic values temporary file
      if (uffs_rename(FM_UFFS_MOUNT_POINT FDV_TMP_FILENAME, FM_UFFS_MOUNT_POINT FDV_FILENAME) == -1)
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
      fd = FM_OpenFile(FDV_FILENAME, UO_WRONLY | UO_CREATE | UO_TRUNC);
      if (fd == -1)
      {
         FDV_ERR("File create failed.");
         return IRC_FAILURE;
      }

      // Write flash dynamic values file
      if (uffs_write(fd, tmpFileDataBuffer, FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE) != FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE)
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
   flashDynamicValues_t tmpFlashDynamicValues;

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
            if (FlashDynamicValues_ReadFlashDynamicValuesFile(FDV_TMP_FILENAME, &tmpFlashDynamicValues) == IRC_SUCCESS)
            {
               // Finish flash dynamic values file update
               if (FM_FileExists(FDV_FILENAME))
               {
                  // Remove old flash dynamic values file
                  if (uffs_remove(FM_UFFS_MOUNT_POINT FDV_FILENAME) == -1)
                  {
                     FDV_ERR("Cannot remove file.");
                     return IRC_FAILURE;
                  }
               }

               // Rename flash dynamic values temporary file
               if (uffs_rename(FM_UFFS_MOUNT_POINT FDV_TMP_FILENAME, FM_UFFS_MOUNT_POINT FDV_FILENAME) == -1)
               {
                  FDV_ERR("Cannot rename temporary file.");
                  return IRC_FAILURE;
               }
            }
            else
            {
               // Remove flash dynamic values temporary file
               if (uffs_remove(FM_UFFS_MOUNT_POINT FDV_TMP_FILENAME) == -1)
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
