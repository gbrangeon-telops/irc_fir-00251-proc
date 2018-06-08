/**
 * @file FileInfo.c
 * File manager module implementation.
 *
 * This file implements the file manager module.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (Wed, 06 Jul 2016) $
 * $Id: FileInfo.c 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/IRCamFiles/FileInfo.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "FileInfo.h"
#include <string.h>

#define FILE_TYPE_SIZE 4
#define NUM_OF_FILETYPES 7

char gFI_FileSignature[NUM_OF_FILETYPES][5] = {
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
IRC_Status_t FI_GetFileInfo(const char *buffer /*instead of filename we take the file in a buffer*/, fileInfo_t *fileInfo)
{
	char fileType[FILE_TYPE_SIZE + 1];
	fileInfo->type = FT_NONE;

	memcpy(fileType, &buffer[0], FILE_TYPE_SIZE);
	fileType[FILE_TYPE_SIZE] = '\0';

	 // Skip "None" file type
	for(int i = 1; i < NUM_OF_FILETYPES; i++ )
	{
		if (strcmp(fileType, gFI_FileSignature[i]) == 0)
		{
			fileInfo->type = (fileType_t) i;
			break;
		}
	}

	if (fileInfo->type != FT_NONE)
	{
		fileInfo->version.major = buffer[4];
		fileInfo->version.minor = buffer[5];
		fileInfo->version.subMinor = buffer[6];
		memcpy(&fileInfo->deviceSerialNumber, &buffer[12], sizeof(uint32_t));
		memcpy(&fileInfo->posixTime, &buffer[16], sizeof(uint32_t));
	}
	else
	{
		fileInfo->version.major = 0;
		fileInfo->version.minor = 0;
		fileInfo->version.subMinor = 0;
		fileInfo->deviceSerialNumber = 0;
		fileInfo->posixTime = 0;
	}

   return IRC_SUCCESS;
}

/**
 * Parse file info and place back the file cursor to its initial position.
 *
 * @param fd is the file descriptor.
 * @param fileInfo is the pointer to the file info data structure to be returned.
 *
 * @return IRC_SUCCESS if file info was successfully parsed.
 * @return IRC_FAILURE if failed to parse file info.
 */
IRC_Status_t FI_ParseFileInfo(int fd, fileInfo_t *fileInfo)
{
   return IRC_SUCCESS;
}
