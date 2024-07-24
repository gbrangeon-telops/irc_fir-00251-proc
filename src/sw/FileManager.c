/**
 * @file FileManager.c
 * File manager module implementation.
 *
 * This file implements the file manager module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "FileManager.h"
#include "FileInfo.h"
#include "GenICam.h"
#include "GC_Registers.h"
#include "CRC.h"
#include "uffs\uffs.h"
#include "uffs\uffs_core.h"
#include "uffs\uffs_device.h"
#include "uffs\uffs_fd.h"
#include "uffs\uffs_mtb.h"
#include "FirmwareUpdater.h"
#include "SREC.h"
#include "IntelHEX.h"
#include "Calibration.h"
#include "CalibImageCorrectionFile.h"
#include "FlashDynamicValues.h"
#include "FlashSettings.h"
#include <string.h> // For memcpy and strcmp
#include <math.h>


/**
 * File data struct used in private.
 */

typedef struct file_struct  {
   union {
      struct  {
         char mount[FM_UFFS_MOUNT_POINT_SIZE];
         char filename[FM_FILENAME_SIZE];
      };
      char longFilename[FM_LONG_FILENAME_SIZE];
   };

   int fd;
   long size;
} file_struct_t ;

/**
 * File manager network port.
 */
netIntfPort_t fmPort;

/**
 * File manager file database.
 */
fileRecord_t gFM_fileDB[FM_MAX_NUM_FILE];

/**
 * File manager file list.
 */
fileList_t gFM_files;

/**
 * File manager collection list.
 */
fileList_t gFM_collections;

/**
 * File manager calibration block list.
 */
fileList_t gFM_calibrationBlocks;

/**
 * File manager nonlinearity only block list.
 */
fileList_t gFM_nlBlocks;

/**
 * File manager internal calibration unit block list.
 */
fileList_t gFM_icuBlocks;

/**
 * File manager calibration actualization file list.
 */
fileList_t gFM_calibrationActualizationFiles;

/**
 * File manager flash settings file pointer.
 */
fileRecord_t *gFM_flashSettingsFile;

/**
 * File manager flash dynamic values file pointer.
 */
fileRecord_t *gFM_flashDynamicValuesFile;

/**
 * Temporary file data buffer.
 */
uint8_t tmpFileDataBuffer[FM_TEMP_FILE_DATA_BUFFER_SIZE];

/*
 * collection file loaded
 */
uint8_t gCollectionIdx = 0;

void FM_ClearFileDB();
int FM_filecmp(const fileRecord_t *file1, const fileRecord_t *file2, const fileOrder_t *keys, uint32_t keyCount);
static IRC_Status_t FM_FillCollectionInfo(fileRecord_t *file);
uint64_t FM_GetMinimalReservedSpace(const uffs_Device *dev);
uint64_t FM_GetRequieredSpace(const char *name);
/**
 * Initializes the file manager.
 *
 * @param netIntf is the pointer to the network interface data structure.
 * @param cmdQueue is the pointer to the file manager command queue.
 *
 * @return IRC_SUCCESS if successfully initialized
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t File_Manager_Init(netIntf_t *netIntf, circBuffer_t *cmdQueue)
{
   fmPort.port = NIP_FILE_MANAGER;
   fmPort.cmdQueue = cmdQueue;

   // Connect file manager to network interface
   if (NetIntf_Connect(netIntf, &fmPort) != IRC_SUCCESS)
   {
      FM_ERR("Failed to connect to network interface.");
      return IRC_FAILURE;
   }

   // Initialize file database
   if (FM_InitFileDB() != IRC_SUCCESS)
   {
      FM_ERR("Failed to initialize file DB.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}


/**
 * File manager state machine.

\dot
digraph G {
FMS_WAITING_REQUEST_FROM_MASTER -> FMS_SENDING_RESPONSE_TO_MASTER -> FMS_WAITING_REQUEST_FROM_MASTER;
}
\enddot

 */
void File_Manager_SM()
{
   static fmState_t fmCurresntState = FMS_INIT;
   static networkCommand_t fmRequest;
   static networkCommand_t fmResponse;
   static uint32_t byteCount;
   static uint32_t fileIndex;
   static uint32_t fileSize = 0;
   static uint16_t fileCRC16;
   static uint64_t memorySpace, spaceFree;
   static uint32_t length;
   extern char gFI_FileSignature[][5];
   extern flashIntfCtrl_t gflashIntfCtrl;
   extern flashDynamicValues_t gFlashDynamicValues;
   IRC_Status_t status;
   fileRecord_t *file;
   static char mountname[FM_MOUNT_POINT_STRING_SIZE];
   static uffs_Device *dev ;
   F1F2_CommandClear(&fmResponse.f1f2);

   switch (fmCurresntState)
   {
      case FMS_INIT:
         // Clear file manager commands
         F1F2_CommandClear(&fmRequest.f1f2);
         F1F2_CommandClear(&fmResponse.f1f2);

         fmCurresntState = FMS_FILL_COLLECTION;
         /*no break*/
      case FMS_FILL_COLLECTION:
         // Validate collection files and fill information
         if(gCollectionIdx < gFM_collections.count) {
            //already load in initDB
            if((gFM_collections.item[gCollectionIdx]->posixTime != gFlashDynamicValues.CalibrationCollectionPOSIXTimeAtStartup)) {
               if (FM_FillCollectionInfo(gFM_collections.item[gCollectionIdx]) != IRC_SUCCESS)
               {
                  // Remove file from collection list
                  FM_RemoveFileFromList(gFM_collections.item[gCollectionIdx], &gFM_collections);

                  FM_ERR("Error to fill collection item %d",gCollectionIdx);
                  status = IRC_FAILURE;
               }
            }
            gCollectionIdx++;

         }
         else {
            //SET key
            fileOrder_t keys[FM_MAX_NUM_FILE_ORDER_KEY];
            keys[0] = gFlashDynamicValues.CalibrationCollectionFileOrderKey1;
            keys[1] = gFlashDynamicValues.CalibrationCollectionFileOrderKey2;
            keys[2] = gFlashDynamicValues.CalibrationCollectionFileOrderKey3;
            keys[3] = gFlashDynamicValues.CalibrationCollectionFileOrderKey4;
            keys[4] = gFlashDynamicValues.CalibrationCollectionFileOrderKey5;
            FM_SetFileListKeys(&gFM_collections, keys, FM_MAX_NUM_FILE_ORDER_KEY);

            fmCurresntState = FMS_WAITING_FOR_REQUEST;
            FM_DBG("SM:Fill Collection Done.Go to waiting for request state");

         }
         break;
      case FMS_WAITING_FOR_REQUEST:
         //check collection is read,because gCollectionIdx can be reset
         if(gCollectionIdx < gFM_collections.count) {
            fmCurresntState = FMS_FILL_COLLECTION;
            break;
         }

         // Check for new request
         if (CB_Pop(fmPort.cmdQueue, &fmRequest) == IRC_SUCCESS)
         {
            if (fmRequest.f1f2.destAddr != NIA_BROADCAST)
            {
               FM_DBG("Request has been received (cmd: 0x%02X).", fmRequest.f1f2.cmd);

               // Process request
               switch (fmRequest.f1f2.cmd)
               {
                  case F1F2_CMD_FILE_COUNT_REQ:
                     F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     fmResponse.f1f2.cmd = F1F2_CMD_FILE_COUNT_RSP;
                     fmResponse.f1f2.payload.fileCount.count = gFM_files.count;
                     break;

                  case F1F2_CMD_FILE_INFO_REQ:
                     fileIndex = fmRequest.f1f2.payload.fileIndex.index;
                     if (fileIndex < gFM_files.count)
                     {
                        F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        fmResponse.f1f2.cmd = F1F2_CMD_FILE_INFO_RSP;
                        fmResponse.f1f2.payload.fileInfo.index = fileIndex;
                        memcpy(fmResponse.f1f2.payload.fileInfo.name, gFM_files.item[fileIndex]->name, F1F2_FILE_NAME_SIZE);
                        fmResponse.f1f2.payload.fileInfo.size = gFM_files.item[fileIndex]->size;
                        fmResponse.f1f2.payload.fileInfo.attributes = gFM_files.item[fileIndex]->attributes;
                        fmResponse.f1f2.payload.fileInfo.id = GetFileID(gFM_files.item[fileIndex]);
                        memcpy(fmResponse.f1f2.payload.fileInfo.type, gFI_FileSignature[gFM_files.item[fileIndex]->type], F1F2_FILE_TYPE_SIZE);
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_CREATE_REQ:
                     // Create file, minimum size for mount_points (can be 0 or 1)
                     memorySpace =  FM_GetRequieredSpace(fmRequest.f1f2.payload.fileName.name);

                     file = FM_CreateFile(fmRequest.f1f2.payload.fileName.name,memorySpace);
                     if (file != NULL)
                     {
                        // Add file to list
                        status = FM_AddFileToList(file, &gFM_files, &fileIndex);
                        if (status == IRC_SUCCESS)
                        {
                           F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                           fmResponse.f1f2.cmd = F1F2_CMD_FILE_CREATE_RSP;
                           fmResponse.f1f2.payload.fileIndex.index = fileIndex;
                        }
                        else
                        {
                           FM_ERR("Failed to add file to list.");
                           F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                     }
                     else
                     {
                        FM_ERR("File create request failed.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_READ_REQ:
                     fileIndex = fmRequest.f1f2.payload.fileRW.index;
                     if (fileIndex < gFM_files.count)
                     {
                        if (fmRequest.f1f2.payload.fileRW.dataLength <= F1F2_MAX_FILE_DATA_SIZE)
                        {
                           if (fmRequest.f1f2.payload.fileRW.offset + fmRequest.f1f2.payload.fileRW.dataLength <= gFM_files.item[fileIndex]->size)
                           {
                              status = FM_ReadDataFromFile(tmpFileDataBuffer,
                                    gFM_files.item[fileIndex]->name,
                                    fmRequest.f1f2.payload.fileRW.offset,
                                    fmRequest.f1f2.payload.fileRW.dataLength);

                              if (status == IRC_SUCCESS)
                              {
                                 F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                                 fmResponse.f1f2.cmd = F1F2_CMD_FILE_READ_RSP;
                                 fmResponse.f1f2.payload.fileRW.index = fmRequest.f1f2.payload.fileRW.index;
                                 fmResponse.f1f2.payload.fileRW.offset = fmRequest.f1f2.payload.fileRW.offset;
                                 fmResponse.f1f2.payload.fileRW.dataLength = fmRequest.f1f2.payload.fileRW.dataLength;
                                 memcpy(fmResponse.f1f2.payload.fileRW.data, tmpFileDataBuffer, fmRequest.f1f2.payload.fileRW.dataLength);
                              }
                              else
                              {
                                 FM_ERR("File read request failed.");
                                 F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                              }
                           }
                           else
                           {
                              FM_ERR("Invalid data offset.");
                              F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                           }
                        }
                        else
                        {
                           FM_ERR("Invalid data length.");
                           F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_WRITE:
                     fileIndex = fmRequest.f1f2.payload.fileRW.index;
                     if (fileIndex < gFM_files.count)
                     {
                        if (fmRequest.f1f2.payload.fileRW.dataLength <= F1F2_MAX_FILE_DATA_SIZE)
                        {
                           if (gFM_files.item[fileIndex]->isClosed == 0)
                           {
                              status = FM_WriteDataToFile(fmRequest.f1f2.payload.fileRW.data,
                                    gFM_files.item[fileIndex]->name,
                                    fmRequest.f1f2.payload.fileRW.offset,
                                    fmRequest.f1f2.payload.fileRW.dataLength);

                              if (status == IRC_SUCCESS)
                              {
                                 fileInfo_t fileInfo;

                                 /* Check if file is a type with reserved space */
                                 FI_GetFileInfo(gFM_files.item[fileIndex]->name, &fileInfo);
                                 if (fileInfo.type == FT_TSFS || fileInfo.type == FT_TSDV ||
                                     fileInfo.type == FT_TSIC)
                                 {
                                    gFM_files.item[fileIndex]->size = FM_GetFileSize(gFM_files.item[fileIndex]->name);
                                    F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                                 }
                                 else
                                 {
                                    //In this case we want the freespace of the current mount point
                                    status = FM_GetMountPoint(gFM_files.item[fileIndex]->name,mountname);
                                    if(status == IRC_SUCCESS) {
                                       spaceFree = flash_space_free(mountname);
                                       dev = uffs_GetDeviceFromMountPoint(mountname);

                                    }
                                    else {
                                       FM_ERR("File %s is not found, mount point set to default",gFM_files.item[fileIndex]->name);
                                       spaceFree = FM_GetFreeSpace();
                                       //get device info from any mount point
                                       dev = uffs_GetDeviceFromMountPoint(gflashIntfCtrl.mount_points[0]);
                                    }
                                    memorySpace = FM_GetMinimalReservedSpace(dev);
                                    if (spaceFree >= memorySpace)
                                    {
                                       gFM_files.item[fileIndex]->size = FM_GetFileSize(gFM_files.item[fileIndex]->name);
                                       F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                                    }
                                    else
                                    {
                                       FM_ERR("Filesystem full.");
                                       F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                                       file = FM_GetFileRecord(fileIndex);
                                       FM_RemoveFile(file);
                                    }
                                 }
                              }
                              else
                              {
                                 FM_ERR("File write request failed.");
                                 F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                                 file = FM_GetFileRecord(fileIndex);
                                 FM_RemoveFile(file);
                              }
                           }
                           else
                           {
                              FM_ERR("File is closed.");
                              F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                           }
                        }
                        else
                        {
                           FM_ERR("Invalid data length.");
                           F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_CLOSE:
                     fileIndex = fmRequest.f1f2.payload.fileRW.index;
                     if (fileIndex < gFM_files.count)
                     {
                        if (FM_CloseFile(gFM_files.item[fileIndex], FMP_RUNNING) == IRC_SUCCESS)
                        {
                           FM_SortFileList(&gFM_files);
                           F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                        else
                        {
                           FM_ERR("Failed to close %s.", gFM_files.item[fileIndex]->name);
                           F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_CHECK_REQ:
                     fileIndex = fmRequest.f1f2.payload.fileIndex.index;
                     if (fileIndex < gFM_files.count)
                     {
                        byteCount = 0;
                        fileSize = FM_GetFileSize(gFM_files.item[fileIndex]->name);
                        fileCRC16 = 0xFFFF;
                        fmCurresntState = FMS_CHECKING_FILE_DATA;
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_DELETE:
                     fileIndex = fmRequest.f1f2.payload.fileIndex.index;
                     if (fileIndex < gFM_files.count)
                     {
                        if ((gGC_ProprietaryFeatureKeyIsValid == 0) &&
                           ((gFM_files.item[fileIndex]->type == FT_TSAC) ||
                           (gFM_files.item[fileIndex]->type == FT_TSIC) ||
                           (gFM_files.item[fileIndex]->type == FT_TSFS) ||
                           (gFM_files.item[fileIndex]->type == FT_TSDV)))
                        {
                           FM_ERR("%s files are protected.", gFI_FileSignature[gFM_files.item[fileIndex]->type]);
                           F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                        else
                        {
                           if (FM_RemoveFile(gFM_files.item[fileIndex]) == IRC_SUCCESS)
                           {
                              F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                           }
                           else
                           {
                              FM_ERR("File delete request failed.");
                              F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                           }
                        }
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_FORMAT:
                     if (gGC_ProprietaryFeatureKeyIsValid)
                     {
                        if (FM_Format() == IRC_SUCCESS)
                        {
                           F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                        else
                        {
                           FM_ERR("File system format request failed.");
                           F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                        }
                     }
                     else
                     {
                        FM_ERR("Camera needs to be unlocked in order to format File system.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_USED_SPACE_REQ:
                     memorySpace = flash_all_space_used();
                     F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     fmResponse.f1f2.cmd = F1F2_CMD_FILE_USED_SPACE_RSP;
                     fmResponse.f1f2.payload.fileSpace.space = memorySpace;
                     break;

                  case F1F2_CMD_FILE_FREE_SPACE_REQ:
                     spaceFree = flash_all_space_free();
                     F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     fmResponse.f1f2.cmd = F1F2_CMD_FILE_FREE_SPACE_RSP;
                     fmResponse.f1f2.payload.fileSpace.space = spaceFree;
                     break;

                  case F1F2_CMD_FILE_TOTAL_SPACE_REQ:
                     memorySpace = flash_all_space_total();
                     F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     fmResponse.f1f2.cmd = F1F2_CMD_FILE_TOTAL_SPACE_RSP;
                     fmResponse.f1f2.payload.fileSpace.space = memorySpace;
                     break;

                  case F1F2_CMD_PING:
                     // Return PING response to master device
                     F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     break;

                  default:
                     FM_ERR("Invalid file manager request command code.");
                     F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     break;
               }
            }
            else
            {
               FM_ERR("Broadcasted commands are not supported.");
            }
         }
         break;

      case FMS_CHECKING_FILE_DATA:
         if (byteCount < fileSize)
         {
            length = MIN(FM_TEMP_FILE_DATA_BUFFER_SIZE, fileSize - byteCount);
            status = FM_ReadDataFromFile(tmpFileDataBuffer, gFM_files.item[fileIndex]->name, byteCount, length);
            if (status == IRC_SUCCESS)
            {
               fileCRC16 = CRC16(fileCRC16, tmpFileDataBuffer, length);
               byteCount += length;
            }
            else
            {
               FM_ERR("File read failed.");
               F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
               fmCurresntState = FMS_WAITING_FOR_REQUEST;
            }
         }

         if (byteCount == fileSize)
         {
            F1F2_BuildResponse(&fmRequest.f1f2, &fmResponse.f1f2);
            fmResponse.f1f2.cmd = F1F2_CMD_FILE_CHECK_RSP;
            fmResponse.f1f2.payload.fileCheck.index = fileIndex;
            fmResponse.f1f2.payload.fileCheck.crc16 = fileCRC16;

            fmCurresntState = FMS_WAITING_FOR_REQUEST;
         }
         break;
   }

   if (fmResponse.f1f2.cmd != F1F2_CMD_NONE)
   {
      // Transmit response to master
      fmResponse.port = &fmPort;
      if (NetIntf_EnqueueCmd(fmPort.netIntf, &fmResponse) == IRC_SUCCESS)
      {
         FM_DBG("Response is transmitted to master device.");
      }
      else
      {
         FM_ERR("Failed to push command in network interface command queue.");
      }
   }
}

/**
 * Initialize file database from file contained in file system (UFFS).
 *
 * @return IRC_SUCCESS if file database was successfully initialized.
 * @return IRC_FAILURE if failed to initialize file database.
 */
IRC_Status_t FM_InitFileDB()
{
   uffs_DIR *dir;
   struct uffs_dirent *de;
   struct uffs_stat filestat;
   char filelongname[FM_LONG_FILENAME_SIZE];
   IRC_Status_t status = IRC_SUCCESS;
   uint32_t fileCount;
   extern flashDynamicValues_t gFlashDynamicValues;
   extern flashIntfCtrl_t gflashIntfCtrl;
   int retlen;

   FM_ClearFileDB();

   fileCount = 0;
   for(int idx = 0 ; idx < gflashIntfCtrl.nr_partition ; idx++)
   {
      FM_PRINTF("Open mount %d: %s\n", idx,gflashIntfCtrl.mount_points[idx]);

      dir = uffs_opendir(gflashIntfCtrl.mount_points[idx]);
      if (dir != NULL)
      {

          while ((de = uffs_readdir(dir)) != NULL)
          {
             FM_PRINTF("%s file found.\n", de->d_name);

             if (fileCount < FM_MAX_NUM_FILE)
             {
                retlen = snprintf(filelongname,FM_LONG_FILENAME_SIZE, "%s%s", gflashIntfCtrl.mount_points[idx], de->d_name);
                /* ensure generated "filename" string is valid */
                if (retlen <= 0 || FM_LONG_FILENAME_SIZE <= retlen)
                    continue;
                if (uffs_stat(filelongname, &filestat) == 0)
                {
                   // Add file in database
                   strcpy(gFM_fileDB[fileCount].name, de->d_name);
                   gFM_fileDB[fileCount].size = filestat.st_size;

                   // Close file
                   status = FM_CloseFile(&gFM_fileDB[fileCount], FMP_INIT);
                   if (status != IRC_SUCCESS)
                   {
                      FM_ERR("File %s failed to close.", filelongname);
                   }

                   // Add file to list
                   FM_AddFileToList(&gFM_fileDB[fileCount], &gFM_files, NULL);

                   fileCount++;
                }
                else
                {
                   FM_ERR("File stat failed for %s.", filelongname);
                }
             }
             else
             {
                FM_INF("File %s dropped because file DB size is limited to %d.", de->d_name, FM_MAX_NUM_FILE);
             }
          }

          uffs_closedir(dir);
         }
         else
         {
            FM_ERR("Open dir failed.");
            return IRC_FAILURE;
         }
      }
       if (gFM_flashSettingsFile == NULL)
       {
          FM_ERR("Cannot find valid flash setting file.");
          FlashSettings_Reset(&flashSettings);
       }


       gCollectionIdx = 0;
       //set last collection for Calibration SM if found
       for (int i = gFM_collections.count - 1; i >= 0; i--)
       {
          if ((gFM_collections.item[i]->posixTime == gFlashDynamicValues.CalibrationCollectionPOSIXTimeAtStartup) || (i == 0))
          {
             FM_DBG("Try to fill collection at posix %d",gFM_collections.item[i]->posixTime );
             if (FM_FillCollectionInfo(gFM_collections.item[i]) != IRC_SUCCESS)
             {
                // Remove file from collection list
                FM_RemoveFileFromList(gFM_collections.item[i], &gFM_collections);

                FM_ERR("Unable to fill collection item %d",i);
                status = IRC_FAILURE;
             }
             else {
                //skip the 0 for the next one
                if(i==0) {
                   gCollectionIdx++;
                }
             }
             break;
          }

       }

       if(status != IRC_SUCCESS) {
          FM_ERR("Failed to load first collection.");
       }


   return status;
}

/**
 * List file database.
 */
void FM_ListFileDB()
{
   extern char gFI_FileSignature[][5];
   uint32_t i;

   for (i = 0; i < FM_MAX_NUM_FILE; i++)
   {
      if (gFM_fileDB[i].name[0] != '\0')
      {
         PRINTF("%d %s (%d) [%08X] TEL%05d %d %s\n",
               i,
               gFM_fileDB[i].name,
               gFM_fileDB[i].size,
               gFM_fileDB[i].attributes,
               gFM_fileDB[i].deviceSerialNumber,
               gFM_fileDB[i].posixTime,
               gFI_FileSignature[gFM_fileDB[i].type]);
      }
      else
      {
         PRINTF("%d [Empty]\n", i);
      }
   }
}

/**
 * Print file_data fields
 *
 * @param file_struct to be print
 * @param add text to be print

 */
static void FM_PrintFileData(const file_struct_t *file_data,const char* function)
{
   FM_INF("File data info in %s:\n",function);
   FM_INF("          -fd: %d \n",file_data->fd);
   FM_INF("          -filename: %s \n",file_data->filename);
   FM_INF("          -mount: %c%c%c%c%c \n",file_data->mount[0],file_data->mount[1],file_data->mount[2],file_data->mount[3],file_data->mount[4]);
   FM_INF("          -longfilename: %s \n",file_data->longFilename);
   FM_INF("          -size: %d \n",file_data->size);

}
/**
*  Set the size field of file_struct_t, if file not present size is set to 0
* @param file_struct to be read
*
* @return IRC_SUCCESS if file exists.
* @return IRC_FAILURE if file does not exist.
*/
static IRC_Status_t FM_GetFileDataSize(file_struct_t* file_data)
{
   struct uffs_stat filestat;

   /* judge file type, dir is to be delete by uffs_rmdir, others by uffs_remove */
   if (uffs_lstat(file_data->longFilename, &filestat) < 0)
   {
      //FM_INF(" %s: not present %s",__func__, file_data->longFilename);
      file_data->size = 0;
      return  IRC_FAILURE;
   }
   else {
      //FM_INF(" %s: size is %d, reading %s",__func__, filestat.st_size,file_data->longFilename);
      file_data->size = filestat.st_size;
   }
   return IRC_SUCCESS;
}


/**
 * Open an file using the filename and flag parameters, file_data must be initialized.
 *
 *
 * @param file_struct.
 * @param flag
 */
static IRC_Status_t FM_OpenFileData(file_struct_t* file_data, int oflag)
{
   if((file_data->fd = uffs_open( file_data->longFilename, oflag)) == -1) {
      FM_ERR("Failed to open %s.Error %ld", file_data->longFilename,uffs_get_error());
      return IRC_FAILURE;
   }
   return IRC_SUCCESS;
}


/**
 *  Set the file data structure in input using the file name:
 *  if file already exist get the size of the existent file and set the name
 *  If no exist, set the size with the input if enough space within one of the mount else set with 0
 *     then set the name with filename input
 *
 *    @param file_struct to be set
 *    @param filename of the file to be create
 *    @param minimum size of the file.
 *
 */
static IRC_Status_t FM_InitFileData(file_struct_t* file_data,const char *filename, long size)
{
   extern flashIntfCtrl_t gflashIntfCtrl;

   //init variables
   file_data->fd = -1;
   file_data->size = 0;
   //memset(file_data->longFilename,0,FM_LONG_FILENAME_SIZE);

   for (int i = 0; i <gflashIntfCtrl.nr_partition ; i++) {
      snprintf(file_data->longFilename,FM_LONG_FILENAME_SIZE, "%s%s", gflashIntfCtrl.mount_points[i], filename);

      if( FM_GetFileDataSize(file_data)== IRC_SUCCESS) {
         //at this point file struct is set
         return IRC_SUCCESS;
      }
      //clear name
      //memset(file_data->longFilename,0,FM_LONG_FILENAME_SIZE);
   }


   //try found mount available
   for (int i = 0; i <gflashIntfCtrl.nr_partition ; i++) {
       if( (flash_space_free(gflashIntfCtrl.mount_points[i])) > size) {
          strncpy(file_data->mount,gflashIntfCtrl.mount_points[i],FM_MOUNT_POINT_STRING_SIZE);
          file_data->size = size;
          break;
       }
    }

   if(file_data->size == 0) {
      FM_ERR("%s :Not enough space to create %s !\n",__func__,filename);
      return IRC_FAILURE;
   }

   strncat(file_data->longFilename, filename,FM_FILENAME_SIZE);

   return IRC_SUCCESS;
}

/**
 *  Call the InitFileDAta function with size of 1, the purpose is to get the file data info from an existant file
 *  In the case, the file doesn't exist in the flash, function will return Failure
 *    @param file_struct to be get
 *    @param filename of the file to be get
 *
 *    @return IRC_SUCCESS if file exists.
 *    @return IRC_FAILURE if file does not exist.
 */
static IRC_Status_t FM_GetFileData(file_struct_t* file_data,const char *filename)
{
   FM_InitFileData(file_data,filename,1);
   if(file_data->size == 1 ) {
      FM_DBG("%s :Warning: File is not present %s \n",__func__,file_data->longFilename);
      return IRC_FAILURE;
   }
   return IRC_SUCCESS;
}

/**
 * The Generic Write function open, seek, write and close the file
 * @param data to be write
 * @param filename of the file
 * @param offset and length :writes up to length from the buffer starting at offset
 * @param flag: flag must include UO_WRONLY
 *
 *  @return IRC_SUCCESS if data are added to the file
 *  @return IRC_FAILURE if failed during the write process.
 */
static IRC_Status_t FM_GenericWriteDataToFile(uint8_t *data, const char *filename, uint32_t offset, uint32_t length,int oflag)
{
   int fd = FM_OpenFile(filename, oflag);
   if (fd == -1)
   {
      FM_ERR("Failed to open %s.", filename);
      return IRC_FAILURE;
   }

   if (uffs_seek(fd, offset, USEEK_SET) == -1)
   {
      FM_ERR("File seek failed.");
      return IRC_FAILURE;
   }

   if (uffs_write(fd, data, length) != length)
   {
      FM_ERR("File write failed.");
      uffs_close(fd);
      return IRC_FAILURE;
   }


   if (uffs_close(fd) == -1)
   {
      FM_ERR("File close failed.\n");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}



/**
 * Indicate whether file exists in one of the mount.
 *
 * @param filename is the name of the file.
 *
 * @return 1 if file exists in one.
 * @return 0 if file does not exist.
 */
uint8_t FM_FileExists(const char *filename)
{

  file_struct_t file_data;
  extern flashIntfCtrl_t gflashIntfCtrl;
  for (int i = 0; i <gflashIntfCtrl.nr_partition ; i++) {
     snprintf(file_data.longFilename,FM_LONG_FILENAME_SIZE, "%s%s", gflashIntfCtrl.mount_points[i], filename);
     if( FM_GetFileDataSize(&file_data) == IRC_SUCCESS) {

        return 1;
     }
  }

   return 0;

}

/**
 * Remove file in any mount using the filename.
 *
 * @param filename is the name of the file.
 *
 * @return 0 if remove successfully
 * @return -1 if file doesn t exist or can't be remove
 */
int FM_Remove(const char *filename)
{
   file_struct_t file_data;
   if(FM_GetFileData(&file_data,filename) == IRC_FAILURE)
   {
      FM_ERR("File remove failed.");
      FM_PrintFileData(&file_data,__func__);
   }
   else {
      return uffs_remove(file_data.longFilename);
   }

   return -1;
}

/**
 * Indicate free space from the largest mount space
 *
 * @return Space available of the largest mount space
 */
uint64_t FM_GetFreeSpace()
{
   extern flashIntfCtrl_t gflashIntfCtrl;
   long largeFreeSpace = 0,freeSpace;
   for (int i = 0; i <gflashIntfCtrl.nr_partition ; i++) {
      if( (freeSpace = flash_space_free(gflashIntfCtrl.mount_points[i])) > largeFreeSpace) {
         largeFreeSpace = freeSpace;
      }
   }
   return largeFreeSpace;
}

/**
 * Get the mount point for a file.
 *
 * @param filename is the name of the file
 * @param mount_point to set
 *
 * @return 0 if set successfully
 * @return -1 if file doesn t exist
 */
IRC_Status_t FM_GetMountPoint(const char *filename,char mount_point[FM_MOUNT_POINT_STRING_SIZE])
{
   file_struct_t file_data;
   if(FM_GetFileData(&file_data,filename) == IRC_FAILURE)
   {
      FM_ERR("File get mount point failed.");
      FM_PrintFileData(&file_data,__func__);
      return IRC_FAILURE;
   }
   else {
      strncpy(mount_point,file_data.mount,FM_UFFS_MOUNT_POINT_SIZE);
      mount_point[FM_UFFS_MOUNT_POINT_SIZE] = '\0';
   }
   return IRC_SUCCESS;
}

/**
 * Return file size. The function GetFileData fill all the file_data fields
 *
 * @param filename is the name of the file.
 *
 * @return the file size.
 * @return 0 if failed to get file size.
 */
uint32_t FM_GetFileSize(const char *filename)
{
   file_struct_t file_data;

   if(FM_GetFileData(&file_data,filename)  == IRC_FAILURE)
   {
      FM_ERR("File %s get size failed.");
      FM_PrintFileData(&file_data,__func__);
      return 0;
   }

   return (uint32_t)file_data.size;
}

/**
 * Create file data and add UO_CREATE flag then call the open function
 *    @param: filename to be created and opened
 *    @param: flag for the open function
 *    @param: minimum length of the file
 *
 *    @return the file descriptor
 *
 */
int FM_CreateAndOpenFile(const char *filename, int oflag,uint32_t length)
{
   file_struct_t file_data;
   IRC_Status_t status;
   oflag |= UO_CREATE;
   status = FM_InitFileData(&file_data,filename,length);
   if (status == IRC_FAILURE)
   {
      FDV_ERR("%s:Can't init file data",__func__);
      return -1;
   }
   status = FM_OpenFileData(&file_data,oflag);
   if (status == IRC_FAILURE)
   {
      FDV_ERR("%s: Can't open file data",__func__);
   }
   return file_data.fd;
}

/**
 * Rename a file (old_name) in flash, using the new_name in input.
 * The file will stay in the same mount directory.
 *
 *  @param: old name of the file to be changed
 *  @param: new name to apply
 */
int FM_Rename(const char *old_name, const char *new_name)
{
   file_struct_t old_file_data,new_file_data;
   if(FM_GetFileData(&old_file_data,old_name) == IRC_FAILURE)
   {
      FM_ERR("File rename failed.");
      FM_PrintFileData(&old_file_data,__func__);
      return -1;
   }
   //set new name with mount of the old file
   strncpy(new_file_data.mount,old_file_data.mount,FM_UFFS_MOUNT_POINT_SIZE);
   strncpy(new_file_data.filename,new_name,FM_FILENAME_SIZE);
   return uffs_rename(old_file_data.longFilename,new_file_data.longFilename) ;

}
/**
 * Open file and return file descriptor.
 *
 * @param filename is the name of the file.
 * @param oflag is the file open flag specification (see uffs.h).
 *
 * @return the file descriptor.
 * @return -1 if failed to open file.
 */
int FM_OpenFile(const char *filename, int oflag)
{

   file_struct_t file_data;
   if(oflag & UO_CREATE) {
      FM_INF("Warning:Call FM_CreateAndOpenFile function instead of set UO_CREATE flag.");

   }

   if(FM_GetFileData(&file_data,filename) == IRC_FAILURE) {
      FM_ERR("%s:Failed to get file",__func__);
      FM_PrintFileData(&file_data,__func__);
      return -1;
   }

   if(FM_OpenFileData(&file_data,oflag) == IRC_FAILURE) {
      FM_ERR("Error using open with %s", filename);

   }

   return file_data.fd;
}


/**
 * Read data from file specified by the file descriptor and
 * write it in the temporary file data buffer.
 * The buffer is protected.
 *
 * @param fd is the file descriptor.
 * @param length is the number of bytes to read from the file.
 *
 * @return the number of bytes read from file.
 * @return 0 if failed to read file.
 */
int FM_ReadFileToTmpFileDataBuffer(int fd, uint32_t length)
{
   if (length > FM_TEMP_FILE_DATA_BUFFER_SIZE)
   {
      return 0;
   }

   return uffs_read(fd, tmpFileDataBuffer, length);
}

/**
 * Read data from file stored in file system.
 *
 * @param data is a pointer to the byte buffer used to store read data.
 * @param filename is the name of the file to read.
 * @param offset is the data byte offset in the file.
 * @param length is the number of bytes to read from the file.
 *
 * @return IRC_SUCCESS if data was successfully read.
 * @return IRC_FAILURE if failed to read data.
 */
IRC_Status_t FM_ReadDataFromFile(uint8_t *data, const char *filename, uint32_t offset, uint32_t length)
{
   int fd = FM_OpenFile(filename, UO_RDONLY);
   if (fd == -1)
   {
      FM_ERR("File open failed.");
      return IRC_FAILURE;
   }

   if (uffs_seek(fd, offset, USEEK_SET) == -1)
   {
      FM_ERR("File seek failed.");
      return IRC_FAILURE;
   }

   if (uffs_read(fd, data, length) != length)
   {
      FM_ERR("File read failed.");
      return IRC_FAILURE;
   }

   if (uffs_close(fd) == -1)
   {
      FM_ERR("File close failed.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}
/**
 * Append data to file stored in file system.
 *
 * @param data is a pointer to the byte buffer that contains data to be written.
 * @param filename is the name of the file to write.
 * @param length is the number of bytes to write to the file.
 *
 * @return IRC_SUCCESS if data was successfully written.
 * @return IRC_FAILURE if failed to write data.
 */
IRC_Status_t FM_AppendDataToFile(uint8_t *data, const char *filename, uint32_t length)
{
   return FM_GenericWriteDataToFile(data,filename, 0, length,UO_WRONLY | UO_APPEND);
}
/**
 * Write data to file stored in file system.
 *
 * @param data is a pointer to the byte buffer that contains data to be written.
 * @param filename is the name of the file to write.
 * @param offset is the data byte offset in the file.
 * @param length is the number of bytes to write to the file.
 *
 * @return IRC_SUCCESS if data was successfully written.
 * @return IRC_FAILURE if failed to write data.
 */
IRC_Status_t FM_WriteDataToFile(uint8_t *data, const char *filename, uint32_t offset, uint32_t length)
{
   return FM_GenericWriteDataToFile(data,filename, offset, length,UO_WRONLY );
}


/**
 * Create preallocate length file in file system.
 *
 * @param filename is the name of the file to create.
 *
 * @return file record pointer if file was successfully created.
 * @return NULL if failed to create file.
 */
fileRecord_t *FM_CreateFile(const char *filename, uint32_t length)
{

   // Check if file exists
   if (FM_FileExists(filename))
   {
      FM_ERR("File already exists.");
      return NULL;
   }

   // Find empty file record index
   int i = 0;
   while ((i < FM_MAX_NUM_FILE) && (gFM_fileDB[i].name[0] != '\0'))
   {
      i++;
   }

   if (i == FM_MAX_NUM_FILE)
   {
      FM_ERR("File system is full.");
      return NULL;
   }

   // Create file
   file_struct_t file_data;
   FM_InitFileData(&file_data,filename,length);

   if(file_data.size == 0) {
      FM_ERR("File creation failed, not enough size");
      return NULL;
   }

   FM_OpenFileData(&file_data, UO_WRONLY | UO_CREATE | UO_TRUNC);
   if (file_data.fd == -1)
   {
      FM_ERR("File open failed.");
      return NULL;
   }


   if (uffs_close(file_data.fd ) == -1)
   {
      FM_ERR("File close failed.");
      if (uffs_remove(file_data.longFilename) == -1)
      {
         FM_ERR("File remove failed.");
      }

      return NULL;
   }

   strcpy(gFM_fileDB[i].name, filename);

   return &gFM_fileDB[i];
}

/**
 * Close file. Try to parse file and take action.
 *
 * @param file is a pointer to the file to close.
 * @param phase indicates whether the file database
 *        is in initialization or running phase.
 *
 * @return IRC_SUCCESS if file was successfully closed.
 * @return IRC_FAILURE if failed to close file.
 */
IRC_Status_t FM_CloseFile(fileRecord_t *file, fmDBPhase_t phase)
{
   IRC_Status_t status;
   CalibBlock_BlockFileHeader_t blockFileHeader;
   fileInfo_t fileInfo;
   int fd;

   if ((file == NULL) || (file->name[0] == '\0'))
   {
      FM_ERR("Invalid file.");
      return IRC_FAILURE;
   }

   if (file->isClosed)
   {
      FM_ERR("File is already closed.");
      return IRC_FAILURE;
   }

   FI_GetFileInfo(file->name, &fileInfo);
   file->type = fileInfo.type;

   if (file->type != FT_NONE)
   {
      file->deviceSerialNumber = fileInfo.deviceSerialNumber;
      file->posixTime = fileInfo.posixTime;
      file->version = fileInfo.version;

      switch(file->type)
      {
         case FT_TSCO:
            if (phase == FMP_RUNNING)
            {
               if (FM_FillCollectionInfo(file) == IRC_SUCCESS)
               {
                  // Add file to collection list
                  FM_AddFileToList(file, &gFM_collections, NULL);
               }
            }
            else
            {
               // Add file to collection list
               FM_AddFileToList(file, &gFM_collections, NULL);
            }
            break;

         case FT_TSBL:
            fd = FM_OpenFile(file->name, UO_RDONLY);
            if (CalibBlock_ParseBlockFileHeader(fd, &blockFileHeader, NULL) > 0)
            {
               switch (blockFileHeader.CalibrationType)
               {
                  case CALT_NL:
                     FM_AddFileToList(file, &gFM_nlBlocks, NULL);
                     break;

                  case CALT_ICU:
                     FM_AddFileToList(file, &gFM_icuBlocks, NULL);
                     break;

                  case CALT_MULTIPOINT:
                  case CALT_TELOPS:
                     FM_AddFileToList(file, &gFM_calibrationBlocks, NULL);
                     break;

                  default:
                     FM_ERR("Unknown block calibration type (%s).", file->name);
                     break;
               }
            }
            else
            {
               FM_ERR("Failed to parse block file header (%s).", file->name);
            }
            uffs_close(fd);
            break;

         case FT_TSAC:
         case FT_TSIC:
            FM_AddFileToList(file, &gFM_calibrationActualizationFiles, NULL);
            break;

         case FT_TSFS:
            if (phase == FMP_INIT)
            {
               status = FlashSettings_Load(file, FSLI_LOAD_IMMEDIATELY);
            }
            else
            {
               status = FlashSettings_Load(file, FSLI_DEFERRED_LOADING);
            }

            if (status != IRC_SUCCESS)
            {
               FM_ERR("Failed to load flash settings.");
            }

            // Remove existing flash settings file
            if ((gFM_flashSettingsFile != NULL) && (gFM_flashSettingsFile != file))
            {
               status = FM_RemoveFile(gFM_flashSettingsFile);
               if (status != IRC_SUCCESS)
               {
                  FM_ERR("Failed to remove %s.", gFM_flashSettingsFile->name);
               }
            }

            gFM_flashSettingsFile = file;
            break;

         case FT_TSDV:
            gFM_flashDynamicValuesFile = file;
            break;

         case FT_NONE:
            // Do nothing
            break;
      }
   }

   file->isClosed = 1;

   return IRC_SUCCESS;
}

/**
 * Remove file from file system and from file database.
 *
 * @param file is a pointer to the file to close.
 *
 * @return IRC_SUCCESS if file was successfully removed.
 * @return IRC_FAILURE if failed to remove file.
 */
IRC_Status_t FM_RemoveFile(fileRecord_t *file)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   if ((file == NULL) || (file->name[0] == '\0'))
   {
      FM_ERR("Invalid file.");
      return IRC_FAILURE;
   }

   if (FM_Remove(file->name) == -1)
   {
      FM_ERR("File remove failed.");
      return IRC_FAILURE;
   }

   // Remove file from file list
   FM_RemoveFileFromList(file, &gFM_files);

   // Remove file from collection and calibration block lists
   FM_RemoveFileFromList(file, &gFM_collections);
   FM_RemoveFileFromList(file, &gFM_calibrationBlocks);
   FM_RemoveFileFromList(file, &gFM_nlBlocks);
   FM_RemoveFileFromList(file, &gFM_icuBlocks);
   FM_RemoveFileFromList(file, &gFM_calibrationActualizationFiles);

   // Check if its the flash settings file
   if (file == gFM_flashSettingsFile)
   {
      gFM_flashSettingsFile = NULL;
   }

   // Check if its the flash dynamic values file
   if (file == gFM_flashDynamicValuesFile)
   {
      gFM_flashDynamicValuesFile = NULL;
   }

   // Check if the file is used by current calibration
   if (CM_FileUsedByActualCalibration(file))
   {
      FM_INF("Removed file was used by current calibration. Calibration is reset.\n");
      Calibration_Reset();
   }

   // Remove file record from file database
   memset(file, 0, sizeof(fileRecord_t));

   // Recreate flash dynamic values file if needed
   if (gFM_flashDynamicValuesFile == NULL)
   {
      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         FM_ERR("Failed to update flash dynamic values.");
      }
   }

   return IRC_SUCCESS;
}

/**
 * Format file system.
 *
 * @return IRC_SUCCESS if file system was successfully formated.
 * @return IRC_FAILURE if failed to format file system.
 */
IRC_Status_t FM_Format()
{
   extern flashDynamicValues_t gFlashDynamicValues;
   extern flashIntfCtrl_t gflashIntfCtrl;

   IRC_Status_t status = IRC_SUCCESS;

   Calibration_Reset();

   for (int i = 0; i <gflashIntfCtrl.nr_partition ; i++) {
      if (uffs_format(gflashIntfCtrl.mount_points[i]) != 0)
      {
         FM_ERR("Failed to format file system.");
         status =  IRC_FAILURE;
      }
   }

   FM_ClearFileDB();

   if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
   {
      FM_ERR("Failed to update flash dynamic values.");
      status =  IRC_FAILURE;
   }

   FM_INF("File format done.");

   return status;
}

/**
 * Add file at the end of the file list.
 *
 * @param file is a pointer to the file to add.
 * @param fileList is a pointer to the file list.
 * @param fileIndex is a pointer to the file index to be returned.
 *
 * @return IRC_SUCCESS if file was successfully added.
 * @return IRC_FAILURE if failed to add file.
 */
IRC_Status_t FM_AddFileToList(fileRecord_t *file, fileList_t *fileList, uint32_t *fileIndex)
{
   uint32_t fi;
   uint32_t i;

   if ((file == NULL) || (file->name[0] == '\0'))
   {
      return IRC_FAILURE;
   }

   if (fileList->count < FM_MAX_NUM_FILE)
   {
      if ((fileList->keyCount == 0) || (fileList->keys[0] == FO_NONE))
      {
         fi = fileList->count;
      }
      else
      {
         fi = 0;

         while ((fi < fileList->count) && (FM_filecmp(file, fileList->item[fi], fileList->keys, fileList->keyCount) > 0))
         {
            fi++;
         }

         // Shift other files to insert the new file
         for (i = fileList->count; i > fi; i--)
         {
            fileList->item[i] = fileList->item[i - 1];
         }
      }

      fileList->item[fi] = file;

      fileList->count++;

      if (fileIndex != NULL)
      {
         *fileIndex = fi;
      }
   }
   else
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Remove file from file list.
 *
 * @param file is a pointer to the file to remove.
 * @param fileList is a pointer to the file list.
 *
 * @return IRC_SUCCESS if file was successfully removed.
 * @return IRC_FAILURE if failed to remove file.
 */
IRC_Status_t FM_RemoveFileFromList(fileRecord_t *file, fileList_t *fileList)
{
   uint32_t i;
   uint8_t found = 0;

   if (file == NULL)
   {
      return IRC_FAILURE;
   }

   i = 0;
   while ((i < fileList->count) && !found)
   {
	   if (fileList->item[i] == file)
	   {
		   found = 1;
	   }
	   else
		   ++i;
   }

   if (found)
   {
      while ((i + 1) < fileList->count)
      {
         fileList->item[i] = fileList->item[i + 1];
         i++;
      }
      fileList->count--;
   }

   return found ? IRC_SUCCESS : IRC_FAILURE;
}

/**
 * Set file list file order keys and sort it.
 *
 * @param fileList is a pointer to the file list.
 * @param keys is an array of file order keys.
 * @param keyCount is the number of file order keys in the keys array.
 */
void FM_SetFileListKeys(fileList_t *fileList, const fileOrder_t *keys, const uint32_t keyCount)
{
   // Update file list file order keys and sort it
   memset(fileList->keys, 0, sizeof(fileList->keys));
   fileList->keyCount = 0;

   while ((fileList->keyCount < MIN(keyCount, FM_MAX_NUM_FILE_ORDER_KEY)) && (keys[fileList->keyCount] != FO_NONE) && (keys[fileList->keyCount] < FO_COUNT))
   {
      fileList->keys[fileList->keyCount] = keys[fileList->keyCount];
      fileList->keyCount++;
   }
   FM_SortFileList(fileList);
}

/**
 * Sort file list.
 *
 * @param fileList is a pointer to the file list.
 */
void FM_SortFileList(fileList_t *fileList)
{
   fileRecord_t *tmpFileRecord;
   uint32_t fileMovedCount;
   uint32_t i;

   if ((fileList->count <= 1) || (fileList->keyCount == 0) || (fileList->keys[0] == FO_NONE))
   {
      return;
   }

   do
   {
      fileMovedCount = 0;

      for (i = 0; i < (fileList->count - 1); i++)
      {
         if (FM_filecmp(fileList->item[i], fileList->item[i + 1], fileList->keys, fileList->keyCount) > 0)
         {
            tmpFileRecord = fileList->item[i];
            fileList->item[i] = fileList->item[i + 1];
            fileList->item[i + 1] = tmpFileRecord;
            fileMovedCount++;
         }
      }

   }
   while (fileMovedCount != 0);
}

/**
 * Compare two files key using specified file order keys.
 *
 * @param file1 is the pointer to the first file to be compared.
 * @param file2 is the pointer to the second file to be compared.
 * @param keys is an array of file order keys to use.
 * @param keyCount is the number of file order keys in the keys array.
 *
 * @return <0 the file key has a lower value in file1 than in file2
 * @return 0 the file key of both files are equal
 * @return >0 the file key has a greater value in file1 than in file2
 */
int FM_filecmp(const fileRecord_t *file1, const fileRecord_t *file2, const fileOrder_t *keys, uint32_t keyCount)
{
   int retval = 0;
   fileOrder_t tmpKeys[FM_MAX_NUM_FILE_ORDER_KEY - 1];
   fileOrder_t key = FO_NONE;

   if (keyCount > 0)
   {
      key = keys[0];

      if (key == FO_NONE)
      {
         keyCount = 0;
      }
   }

   switch (key)
   {
      case FO_NONE:
      case FO_FILE_NAME:
      default:
         retval = strcmp(file1->name, file2->name);
         break;

      case FO_POSIX_TIME:
         retval = (file1->posixTime - file2->posixTime);
         break;

      case FO_FILE_TYPE:
         retval = file1->type - file2->type;
         break;

      case FO_COLLECTION_TYPE:
      case FO_FW_POSITION:
      case FO_NDF_POSITION:
      case FO_EXT_LENS_SERIAL:
      case FO_FOV_POSITION:
         if ((file1->type == FT_TSCO) && (file2->type == FT_TSCO))
         {
            switch (key)
            {
               case FO_COLLECTION_TYPE:
                  retval = file1->info.collection.CollectionType - file2->info.collection.CollectionType;

                  if ((retval == 0) && (keyCount == 1))
                  {
                     // Smart mode
                     switch (file1->info.collection.CollectionType)
                     {
                        case CCT_TelopsFixed:
                        case CCT_MultipointFixed:
                        case CCT_MultipointEHDRI:
                           tmpKeys[0] = FO_FW_POSITION;
                           tmpKeys[1] = FO_NDF_POSITION;
                           tmpKeys[2] = FO_FOV_POSITION;
                           tmpKeys[3] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 4);
                           break;

                        case CCT_TelopsFW:
                        case CCT_MultipointFW:
                           tmpKeys[0] = FO_NDF_POSITION;
                           tmpKeys[1] = FO_FOV_POSITION;
                           tmpKeys[2] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 3);
                           break;

                        case CCT_TelopsNDF:
                        case CCT_MultipointNDF:
                           tmpKeys[0] = FO_FW_POSITION;
                           tmpKeys[1] = FO_FOV_POSITION;
                           tmpKeys[2] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 3);
                           break;

                        case CCT_TelopsFOV:
                        case CCT_MultipointFOV:
                           tmpKeys[0] = FO_FW_POSITION;
                           tmpKeys[1] = FO_NDF_POSITION;
                           tmpKeys[2] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 3);
                           break;
                     }
                  }
                  break;

               case FO_FW_POSITION:
                  retval = file1->info.collection.FWPosition - file2->info.collection.FWPosition;
                  break;

               case FO_NDF_POSITION:
                  retval = file1->info.collection.NDFPosition - file2->info.collection.NDFPosition;
                  break;

               case FO_EXT_LENS_SERIAL:
                  retval = file1->info.collection.ExternalLensSerialNumber - file2->info.collection.ExternalLensSerialNumber;
                  break;

               case FO_FOV_POSITION:
                  retval = file1->info.collection.FOVPosition - file2->info.collection.FOVPosition;
                  break;

               default:
                  // Not supposed to get there.
                  break;
            }
         }
         else
         {
            retval = (int)(file1->type == FT_TSCO) - (int)(file2->type == FT_TSCO);
         }
         break;
   }

   if ((retval == 0) && (keyCount > 0))
   {
      keyCount--;
      keys++;

      if (keyCount == 0)
      {
         keys = NULL;
      }

      retval = FM_filecmp(file1, file2, keys, keyCount);
   }

   return retval;
}

/**
 * Find file based on its POSIX time in file list.
 *
 * @param posixTime is the file POSIX time to find.
 * @param fileList is a pointer to the file list.
 *
 * @return a pointer to the file record.
 * @return NULL if not found.
 */
fileRecord_t *FM_FindFilePOSIXTimeInList(uint32_t posixTime, const fileList_t *fileList)
{
   uint32_t fileIndex = 0;

   while (fileIndex < fileList->count)
   {
	   if (fileList->item[fileIndex]->posixTime == posixTime)
		   return fileList->item[fileIndex];

	   ++fileIndex;
   }

   return NULL;
}

/**
 * Find file based on its name in file list.
 *
 * @param filename is the file name to find.
 * @param fileList is a pointer to the file list.
 *
 * @return a pointer to the file record.
 * @return NULL if not found.
 */
fileRecord_t *FM_FindFileNameInList(const char *filename, const fileList_t *fileList)
{
   uint32_t fileIndex = 0;

   while (fileIndex < fileList->count)
   {
      if (strcmp(fileList->item[fileIndex]->name, filename) == 0)
         return fileList->item[fileIndex];

      ++fileIndex;
   }

   return NULL;
}

/**
 * Retrieve the file record at a given index.
 *
 * @param fileIndex the index of the file record to retrieve.
 *
 * @return a pointer to the requested file record.
 *         0 if the file does not exist at specified index
 */
fileRecord_t *FM_GetFileRecord(uint32_t fileIndex)
{
   if (fileIndex < gFM_files.count)
      return gFM_files.item[fileIndex];
   else
      return NULL;
}

/**
 * Fill collection file information.
 *
 * @param file is a pointer to the collection file.
 *
 * @return IRC_SUCCESS if collection file information was successfully filled.
 * @return IRC_FAILURE if failed to fill collection file information.
 */
IRC_Status_t FM_FillCollectionInfo(fileRecord_t *file)
{
   calibCollectionInfo_t collectionInfo;
   uint32_t i;

   if (Calibration_LoadCollectionFile(file, &collectionInfo) == IRC_SUCCESS)
   {
      // Copy collection file information in file record data structure
      file->info.collection.CollectionType = collectionInfo.CollectionType;
      file->info.collection.CalibrationType = collectionInfo.CalibrationType;
      file->info.collection.FWPosition = collectionInfo.FWPosition;
      file->info.collection.NDFPosition = collectionInfo.NDFPosition;
      file->info.collection.FOVPosition = collectionInfo.FOVPosition;
      file->info.collection.ExternalLensSerialNumber = collectionInfo.ExternalLensSerialNumber;
      file->info.collection.NumberOfBlocks = collectionInfo.NumberOfBlocks;

      for (i = 0; i < collectionInfo.NumberOfBlocks; i++)
      {
         file->info.collection.BlockPOSIXTime[i] = collectionInfo.BlockPOSIXTime[i];
      }
   }
   else
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}


   //Compute the right value using the extension of the file

uint64_t FM_GetRequieredSpace(const char *name)
{
   extern flashIntfCtrl_t gflashIntfCtrl;
   //define from Calibration Files Structure.xlsx
   const uint32_t  MaxOfLUTRQ = 3,LUTRQSizeMax = 4096,MaxNumberOfLUTNL = 64,LUTSizeMax = 256,MAXTKSizeMax = 256;
   const uint64_t LUTNLMaxLength = CALIBBLOCK_LUTNLDATA_SIZE*LUTSizeMax*MaxNumberOfLUTNL, LUTRQLUTMaxLength = LUTRQSizeMax*CALIBBLOCK_LUTRQDATA_SIZE_V2*MaxOfLUTRQ, MAXTKMaxLength = MAXTKSizeMax*CALIBBLOCK_MAXTKDATA_SIZE_V2 , PixelDataMaxLength =  gcRegsData.SensorWidth * gcRegsData.SensorHeight*CALIBBLOCK_PIXELDATA_SIZE;
   uint64_t size = 0;

   if(name == NULL)
   {
      FM_ERR ("name is null\n");
      size =  0;
   }

   char * ext;
   ext=strstr (name,".tsco");
   if (ext != NULL) {
      size += (CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE + 4 );
      FM_DBG("TSCO minimum size %lu B\n",size);
   }
   else {
      ext=strstr (name,".tsbl");
      if(ext != NULL) {

         //block file header in bytes
         size += CALIBBLOCK_BLOCKFILEHEADER_SIZE + CALIBBLOCK_PIXELDATAHEADER_SIZE + CALIBBLOCK_MAXTKDATAHEADER_SIZE + CALIBBLOCK_LUTNLDATAHEADER_SIZE + CALIBBLOCK_LUTRQDATAHEADER_SIZE*MaxOfLUTRQ  ;
         //block file data
         size += PixelDataMaxLength + LUTNLMaxLength + LUTRQLUTMaxLength + MAXTKMaxLength ;
#ifdef CALCIUM_PROXY
         //Calcium has KPixData
         size += CALIBBLOCK_KPIXDATAHEADER_SIZE + CALIBBLOCK_KPIXDATA_SIZE*gcRegsData.SensorWidth * gcRegsData.SensorHeight;
#endif
      }
      FM_DBG("TSBL minimum size %lu B\n",size);

   }

   // Assure to let minimal
   uffs_Device *dev = uffs_GetDeviceFromMountPoint(gflashIntfCtrl.mount_points[0]);
   size += FM_GetMinimalReservedSpace(dev) ;//bytes
   FM_DBG("Minimal size for %s: %lu B\n",ext,size);

   return size;
}

uint64_t FM_GetMinimalReservedSpace(const uffs_Device *dev)
{
   if(dev == NULL)
   {
      FM_ERR("dev is null");
      return 0;
   }
   long blkSize = dev->attr->page_data_size * dev->attr->pages_per_block;
   uint32_t numDataToProcess = gcRegsData.SensorWidth * gcRegsData.SensorHeight;
   long tsfsLen, tsdvLen, tsicLen;

   /* Reserve space for flash settings, flash dynamic values and
    * actualization files, rounded up to UFFS's block granularity.
    */
   tsfsLen = ceil((double) FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE / blkSize) * blkSize;
   tsdvLen = ceil((double) FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE / blkSize) * blkSize;
   tsicLen = ceil((double) (CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE +
                            CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE +
                            numDataToProcess * CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE) / blkSize) * blkSize;
   return (uint64_t)(tsfsLen + tsdvLen + tsicLen * MAX(gFM_icuBlocks.count,1));


}


/**
 * Clear file manager file database.
 **/
void FM_ClearFileDB()
{
   memset(&gFM_files, 0, sizeof(gFM_files));
   memset(&gFM_collections, 0, sizeof(gFM_collections));
   memset(&gFM_calibrationBlocks, 0, sizeof(gFM_calibrationBlocks));
   memset(&gFM_nlBlocks, 0, sizeof(gFM_nlBlocks));
   memset(&gFM_icuBlocks, 0, sizeof(gFM_icuBlocks));
   memset(&gFM_calibrationActualizationFiles, 0, sizeof(gFM_calibrationActualizationFiles));

   // Clear file pointers
   gFM_flashSettingsFile = NULL;
   gFM_flashDynamicValuesFile = NULL;

   // Clear file database
   memset(gFM_fileDB, 0, sizeof(gFM_fileDB));
}

uint64_t flash_all_space_used()
{
   extern flashIntfCtrl_t gflashIntfCtrl;
   uint64_t space_used = 0;
   for(int idx = 0 ; idx < gflashIntfCtrl.nr_partition ; idx++) {
      space_used += flash_space_used(gflashIntfCtrl.mount_points[idx]);
   }

   return space_used;
}
uint64_t flash_all_space_free()
{
   extern flashIntfCtrl_t gflashIntfCtrl;
   uint64_t space_free = 0;
   for(int idx = 0 ; idx < gflashIntfCtrl.nr_partition ; idx++) {
      space_free += flash_space_free(gflashIntfCtrl.mount_points[idx]);

   }

   return space_free;
}
uint64_t flash_all_space_total()
{
   extern flashIntfCtrl_t gflashIntfCtrl;
   uint64_t space_total = 0;
   for(int idx = 0 ; idx < gflashIntfCtrl.nr_partition ; idx++) {
      space_total += uffs_space_total(gflashIntfCtrl.mount_points[idx]);
   }

   return space_total;
}

/**
 * Return NAND flash used space, corrected for reserved blocks
 **/
uint64_t flash_space_used(const char mount_point[FM_MOUNT_POINT_STRING_SIZE])
{
   uffs_Device *dev = uffs_GetDeviceFromMountPoint(mount_point);
   long blkSize = dev->attr->page_data_size * dev->attr->pages_per_block;
   uint64_t spaceUsed = uffs_space_used(mount_point);

   /* Compensate for reserved blocks */
   spaceUsed += (dev->cfg.reserved_free_blocks-1) * blkSize;
   return spaceUsed;
}

/**
 * Return NAND flash free space, corrected for reserved blocks
 **/
uint64_t flash_space_free(const char mount_point[FM_MOUNT_POINT_STRING_SIZE])
{
   uffs_Device *dev = uffs_GetDeviceFromMountPoint(mount_point);

   long blkSize = dev->attr->page_data_size * dev->attr->pages_per_block;
   uint64_t spaceFree = uffs_space_free(mount_point);


   /* Compensate for reserved blocks */
   spaceFree -= (dev->cfg.reserved_free_blocks-1) * blkSize;
   return spaceFree;
}
