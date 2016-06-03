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
#include "GC_Registers.h"
#include "CRC.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "FirmwareUpdater.h"
#include "SREC.h"
#include "IntelHEX.h"
#include "Calibration.h"
#include "FlashDynamicValues.h"
#include "FlashSettings.h"
#include <string.h> // For memcpy and strcmp

int FM_filecmp(const fileRecord_t *file1, const fileRecord_t *file2, const fileOrder_t *keys, uint32_t keyCount);

char gFM_FileSignature[][F1F2_FILE_TYPE_SIZE + 1] = {
      "",
      "TSAC",
      "TSBL",
      "TSCO",
      "TSDV",
      "TSFS"
};

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


static IRC_Status_t FM_FillCollectionInfo(fileRecord_t *file);

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

   // Recover flash dynamic values file update
   if (FlashDynamicValues_Recover() != IRC_SUCCESS)
   {
      FM_ERR("Failed to recover flash dynamic values file update.");
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
   static uint32_t fileSize;
   static uint16_t fileCRC16;
   IRC_Status_t status;
   fileRecord_t *file;
   uint32_t length;

   F1F2_CommandClear(&fmResponse.f1f2);

   switch (fmCurresntState)
   {
      case FMS_INIT:
         // Clear file manager commands
         F1F2_CommandClear(&fmRequest.f1f2);
         F1F2_CommandClear(&fmResponse.f1f2);
         
         fmCurresntState = FMS_WAITING_FOR_REQUEST;
         break;

      case FMS_WAITING_FOR_REQUEST:
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
                        memcpy(fmResponse.f1f2.payload.fileInfo.type, gFM_FileSignature[gFM_files.item[fileIndex]->type], F1F2_FILE_TYPE_SIZE);
                     }
                     else
                     {
                        FM_ERR("Invalid file index.");
                        F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                     }
                     break;

                  case F1F2_CMD_FILE_CREATE_REQ:
                     // Create file
                     file = FM_CreateFile(fmRequest.f1f2.payload.fileName.name);
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
                                 gFM_files.item[fileIndex]->size = FM_GetFileSize(gFM_files.item[fileIndex]->name);
                                 F1F2_BuildACKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
                              }
                              else
                              {
                                 FM_ERR("File write request failed.");
                                 F1F2_BuildNAKResponse(&fmRequest.f1f2, &fmResponse.f1f2);
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
                           (gFM_files.item[fileIndex]->type == FT_TSFS) ||
                           (gFM_files.item[fileIndex]->type == FT_TSDV)))
                        {
                           FM_ERR("%s files are protected.", gFM_FileSignature[gFM_files.item[fileIndex]->type]);
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
                     if (gGC_ProprietaryFeatureKeyIsValid == 1)
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
   int retval;
   IRC_Status_t status;
   uint32_t fileCount;
   uint32_t i;

   // Clear file lists
   memset(&gFM_files, 0, sizeof(gFM_files));
   memset(&gFM_collections, 0, sizeof(gFM_collections));
   memset(&gFM_calibrationBlocks, 0, sizeof(gFM_calibrationBlocks));
   memset(&gFM_nlBlocks, 0, sizeof(gFM_nlBlocks));
   memset(&gFM_icuBlocks, 0, sizeof(gFM_icuBlocks));
   memset(&gFM_calibrationActualizationFiles, 0, sizeof(gFM_calibrationActualizationFiles));

   // TODO Set collection file order keys using flash dynamic values

   // Clear file pointers
   gFM_flashSettingsFile = NULL;

   // Clear file database
   memset(gFM_fileDB, 0, sizeof(gFM_fileDB));

   fileCount = 0;

   dir = uffs_opendir(FM_UFFS_MOUNT_POINT);
   if (dir != NULL)
   {
      while ((de = uffs_readdir(dir)) != NULL)
      {
         FM_PRINTF("%s file found.\n", de->d_name);

         if (fileCount < FM_MAX_NUM_FILE)
         {
            sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, de->d_name);
            retval = uffs_stat(filelongname, &filestat);
            if (retval == 0)
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

      if (gFM_flashSettingsFile == NULL)
      {
         FM_ERR("Cannot find valid flash setting file.");
      }

      // Validate collection files and fill information
      i = 0;
      while (i < gFM_collections.count)
      {
         if (FM_FillCollectionInfo(gFM_collections.item[i]) != IRC_SUCCESS)
         {
            // Remove file from collection list
            FM_RemoveFileFromList(gFM_collections.item[i], &gFM_collections);
         }
         else
         {
            i++;
         }
      }
   }
   else
   {
      FM_ERR("Open dir failed.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * List file database.
 */
void FM_ListFileDB()
{
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
               gFM_FileSignature[gFM_fileDB[i].type]);
      }
      else
      {
         PRINTF("%d [Empty]\n", i);
      }
   }
}

/**
 * Indicate whether file exists.
 *
 * @param filename is the name of the file.
 *
 * @return 1 if file exists.
 * @return 0 if file does not exist.
 */
uint8_t FM_FileExists(const char *filename)
{
   char filelongname[FM_LONG_FILENAME_SIZE];
   struct uffs_stat filestat;
   int retval;

   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, filename);
   retval = uffs_stat(filelongname, &filestat);

   return (retval == 0);
}

/**
 * Return file size.
 *
 * @param filename is the name of the file.
 *
 * @return the file size.
 * @return 0 if failed to get file size.
 */
uint32_t FM_GetFileSize(const char *filename)
{
   char filelongname[FM_LONG_FILENAME_SIZE];
   struct uffs_stat filestat;
   int retval;

   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, filename);
   retval = uffs_stat(filelongname, &filestat);
   if (retval == -1)
   {
      FM_ERR("File stat failed.");
      return 0;
   }

   return filestat.st_size;
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
   int fd;
   char filelongname[FM_LONG_FILENAME_SIZE];
   int retval;

   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, filename);
   fd = uffs_open(filelongname, UO_RDONLY);
   if (fd == -1)
   {
      FM_ERR("File open failed.");
      return IRC_FAILURE;
   }

   retval = uffs_seek(fd, offset, USEEK_SET);
   if (retval == -1)
   {
      FM_ERR("File seek failed.");
      return IRC_FAILURE;
   }

   retval = uffs_read(fd, data, length);
   if (retval != length)
   {
      FM_ERR("File read failed.");
      return IRC_FAILURE;
   }

   retval = uffs_close(fd);
   if (retval == -1)
   {
      FM_ERR("File close failed.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
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
   int fd;
   char filelongname[FM_LONG_FILENAME_SIZE];
   int retval;

   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, filename);
   fd = uffs_open(filelongname, UO_WRONLY);
   if (fd == -1)
   {
      FM_ERR("Failed to open %s.", filelongname);
      return IRC_FAILURE;
   }

   retval = uffs_seek(fd, offset, USEEK_SET);
   if (retval == -1)
   {
      FM_ERR("File seek failed.");
      return IRC_FAILURE;
   }

   retval = uffs_write(fd, data, length);
   if (retval != length)
   {
      FM_ERR("File write failed.");
      return IRC_FAILURE;
   }

   retval = uffs_close(fd);
   if (retval == -1)
   {
      FM_ERR("File close failed.\n");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Create zero length file in file system.
 *
 * @param filename is the name of the file to create.
 *
 * @return file record pointer if file was successfully created.
 * @return NULL if failed to create file.
 */
fileRecord_t *FM_CreateFile(const char *filename)
{
   int fd;
   char filelongname[FM_LONG_FILENAME_SIZE];
   int retval;
   uint32_t i;

   // Check if file exists
   if (FM_FileExists(filename))
   {
      FM_ERR("File already exists.");
      return NULL;
   }

   // Find empty file record index
   i = 0;
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
   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, filename);
   fd = uffs_open(filelongname, UO_WRONLY | UO_CREATE | UO_TRUNC);
   if (fd == -1)
   {
      FM_ERR("File open failed.");
      return NULL;
   }

   retval = uffs_close(fd);
   if (retval == -1)
   {
      FM_ERR("File close failed.");

      retval = uffs_remove(filelongname);
      if (retval == -1)
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
   uint32_t dataLength;
   BlockFileHeader_t blockFileHeader;
   char fileType[F1F2_FILE_TYPE_SIZE + 1];
   uint32_t i;

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

   file->type = FT_NONE;

   dataLength = MIN(file->size, FM_TEMP_FILE_DATA_BUFFER_SIZE);
   status = FM_ReadDataFromFile(tmpFileDataBuffer, file->name, 0, dataLength);
   if ((status == IRC_SUCCESS) && (dataLength >= 20))
   {
      // Detect Telops file types
      memcpy(fileType, tmpFileDataBuffer, F1F2_FILE_TYPE_SIZE);
      fileType[F1F2_FILE_TYPE_SIZE] = '\0';

      i = 1; // Skip "None" file type
      while (i < NUM_OF(gFM_FileSignature))
      {
         if (strcmp(fileType, gFM_FileSignature[i]) == 0)
         {
            file->type = i;
            break;
         }

         i++;
      }

      if (file->type != FT_NONE)
      {
         memcpy(&file->deviceSerialNumber, &tmpFileDataBuffer[12], sizeof(uint32_t));
         memcpy(&file->posixTime, &tmpFileDataBuffer[16], sizeof(uint32_t));

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
               if (ParseCalibBlockFileHeader(tmpFileDataBuffer, dataLength, &blockFileHeader) > 0)
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
               break;

            case FT_TSAC:
               FM_AddFileToList(file, &gFM_calibrationActualizationFiles, NULL);
               break;

            case FT_TSFS:
               if (phase == FMP_INIT)
               {
                  status = FlashSettings_Load(file->name, FSLI_LOAD_IMMEDIATELY);
               }
               else
               {
                  status = FlashSettings_Load(file->name, FSLI_DEFERRED_LOADING);
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

   char filelongname[FM_LONG_FILENAME_SIZE];
   int retval;

   if ((file == NULL) || (file->name[0] == '\0'))
   {
      FM_ERR("Invalid file.");
      return IRC_FAILURE;
   }

   // Remove file from file system
   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, file->name);
   retval = uffs_remove(filelongname);
   if (retval == -1)
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
      FlashSettings_Reset(&flashSettings);
   }

   // Check if its the flash dynamic values file
   if (file == gFM_flashDynamicValuesFile)
   {
      gFM_flashDynamicValuesFile = NULL;
   }

   // Check if the file is used by current calibration
   if (CM_FileUsedByActualCalibration(file))
   {
      PRINTF("FM: Warning: Removed file was used by current calibration. Calibration is reset.\n");
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


IRC_Status_t FM_Format()
{
   extern flashDynamicValues_t gFlashDynamicValues;

   IRC_Status_t status = IRC_SUCCESS;

   Calibration_Reset();
   FlashSettings_Reset(&flashSettings);

   if (uffs_format(FM_UFFS_MOUNT_POINT) != 0)
   {
      FM_ERR("Failed to format file system.");
      status =  IRC_FAILURE;
   }

   if (FM_InitFileDB() != IRC_SUCCESS)
   {
      FM_ERR("Failed to initialize file database.");
      status =  IRC_FAILURE;
   }

   if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
   {
      FM_ERR("Failed to update flash dynamic values.");
      status =  IRC_FAILURE;
   }

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

   if ((fileList->keyCount == 0) || (fileList->keys[0] == FO_NONE))
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
   fileOrder_t tmpKeys[3];
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
                           tmpKeys[2] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 3);
                           break;

                        case CCT_TelopsFW:
                        case CCT_MultipointFW:
                           tmpKeys[0] = FO_NDF_POSITION;
                           tmpKeys[1] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 2);
                           break;

                        case CCT_TelopsNDF:
                        case CCT_MultipointNDF:
                           tmpKeys[0] = FO_FW_POSITION;
                           tmpKeys[1] = FO_EXT_LENS_SERIAL;
                           retval = FM_filecmp(file1, file2, tmpKeys, 2);
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
