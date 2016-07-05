/**
 * @file FileInfo.c
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

#include "FileInfo.h"
#include "FileManager.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include <string.h>

char gFI_FileSignature[][5] = {
      "",
      "TSAC",
      "TSBL",
      "TSCO",
      "TSDV",
      "TSFS",
      "TSIC"
};

/**
 * Return file info.
 *
 * @param filename is the name of the file.
 * @param fileInfo is the pointer to the file info data structure to be returned.
 *
 * @return IRC_SUCCESS if file info was successfully read.
 * @return IRC_FAILURE if failed to read file info.
 */
IRC_Status_t FI_GetFileInfo(const char *filename, fileInfo_t *fileInfo)
{
   int fd;

   fd = FM_OpenFile(filename, UO_RDONLY);
   if (fd == -1)
   {
      return IRC_FAILURE;
   }

   FI_ParseFileInfo(fd, fileInfo);

   if (uffs_close(fd) == -1)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Parse file info.
 *
 * @param fd is the file descriptor.
 * @param fileInfo is the pointer to the file info data structure to be returned.
 *
 * @return IRC_SUCCESS if file info was successfully parsed.
 * @return IRC_FAILURE if failed to parse file info.
 */
IRC_Status_t FI_ParseFileInfo(int fd, fileInfo_t *fileInfo)
{
   char fileType[F1F2_FILE_TYPE_SIZE + 1];
   uint32_t i;

   fileInfo->type = FT_NONE;

   if (uffs_read(fd, tmpFileDataBuffer, 20) != 20)
   {
      return IRC_FAILURE;
   }

   memcpy(fileType, &tmpFileDataBuffer[0], F1F2_FILE_TYPE_SIZE);
   fileType[F1F2_FILE_TYPE_SIZE] = '\0';

   i = 1; // Skip "None" file type
   while (i < NUM_OF(gFI_FileSignature))
   {
      if (strcmp(fileType, gFI_FileSignature[i]) == 0)
      {
         fileInfo->type = i;
         break;
      }

      i++;
   }

   if (fileInfo->type != FT_NONE)
   {
      fileInfo->version.major = tmpFileDataBuffer[4];
      fileInfo->version.minor = tmpFileDataBuffer[5];
      fileInfo->version.subMinor = tmpFileDataBuffer[6];
      memcpy(&fileInfo->deviceSerialNumber, &tmpFileDataBuffer[12], sizeof(uint32_t));
      memcpy(&fileInfo->posixTime, &tmpFileDataBuffer[16], sizeof(uint32_t));
   }

   return IRC_SUCCESS;
}
