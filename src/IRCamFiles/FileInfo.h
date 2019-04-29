/**
 * @file FileInfo.h
 * File information module header.
 *
 * This file defines the file information module interface.
 *
 * $Rev: 18925 $
 * $Author: dalain $
 * $Date: 2016-06-22 16:11:55 -0400 (mer., 22 juin 2016) $
 * $Id: FileInfo.h 18925 2016-06-22 20:11:55Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/FileInfo.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef FILE_INFO_H
#define FILE_INFO_H

#include "IRC_Status.h"
#include <stdint.h>

/**
 * File type.
 */
enum fileTypeEnum {
   FT_NONE = 0,         /**< None */
   FT_TSAC,             /**< Actualization file */
   FT_TSBL,             /**< Calibration bloc file */
   FT_TSCO,             /**< Calibration collection file */
   FT_TSDV,             /**< Flash dynamic values file */
   FT_TSFS,             /**< Flash settings file */
   FT_TSIC              /**< Image correction file */
};

/**
 * File type data type.
 */
typedef enum fileTypeEnum fileType_t;

/**
 * File version data structure.
 */
struct fileVersionStruct {
   uint8_t major;       /**< File structure major version */
   uint8_t minor;       /**< File structure minor version */
   uint8_t subMinor;    /**< File structure sub-minor version */
};

/**
 * File version data type.
 */
typedef struct fileVersionStruct fileVersion_t;

/**
 * File info data structure.
 */
struct fileInfoStruct {
   fileType_t type;                    /**< File type */
   fileVersion_t version;              /**< File version */
   uint32_t deviceSerialNumber;        /**< Device serial number */
   uint32_t posixTime;                 /**< File POSIX time */
};

/**
 * File info data type.
 */
typedef struct fileInfoStruct fileInfo_t;

IRC_Status_t FI_GetFileInfo(const char *filename, fileInfo_t *fileInfo);
IRC_Status_t FI_ParseFileInfo(int fd, fileInfo_t *fileInfo);

#endif // FILE_INFO_H


