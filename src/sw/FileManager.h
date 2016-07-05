/**
 * @file FileManager.h
 * File manager module header.
 *
 * This file defines the file manager module interface.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FILE_MANAGER_H
#define FILE_MANAGER_H

#include "FileInfo.h"
#include "CtrlInterface.h"
#include "CircularBuffer.h"
#include "CalibCollectionFile.h"
#include "CalibBlockFile.h"
#include "NetworkInterface.h"
#include "Protocol_F1F2.h"
#include "IRC_Status.h"
#include "xparameters.h"
#include "FlashSettings.h"
#include "verbose.h"
#include <stdint.h>


#ifdef FM_VERBOSE
   #define FM_PRINTF(fmt, ...)   FPGA_PRINTF("FM: " fmt, ##__VA_ARGS__)
#else
   #define FM_PRINTF(fmt, ...)   DUMMY_PRINTF("FM: " fmt, ##__VA_ARGS__)
#endif

#define FM_ERR(fmt, ...)         FPGA_PRINTF("FM: Error: " fmt "\n", ##__VA_ARGS__)
#define FM_INF(fmt, ...)         FPGA_PRINTF("FM: Info: " fmt "\n", ##__VA_ARGS__)
#define FM_DBG(fmt, ...)         FM_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define FM_MAX_NUM_FILE          128    /**< Maximum number of file */

#define FM_TEMP_FILE_DATA_BUFFER_SIZE  512

#define FM_UFFS_MOUNT_POINT            "/cs0/"
#define FM_UFFS_MOUNT_POINT_SIZE       5
#define FM_LONG_FILENAME_SIZE          (FM_UFFS_MOUNT_POINT_SIZE + F1F2_FILE_NAME_SIZE + 1) /** mount point + filename + null char */

#define FM_MAX_NUM_FILE_ORDER_KEY      4    /**< Maximum number of file order key */

#define GetFileID(fr) ((((uint64_t) fr->deviceSerialNumber) << 32) | (uint64_t) fr->posixTime)

/**
 * File manager state.
 */
enum fmState {
   FMS_INIT = 0,                       /**< Initializing file manager */
   FMS_WAITING_FOR_REQUEST,            /**< Waiting for request from master */
   FMS_CHECKING_FILE_DATA              /**< Checking file data (CRC-16) */
};

/**
 * File manager state data type.
 */
typedef enum fmState fmState_t;

/**
 * File manager phase.
 */
enum fmDBPhaseEnum {
   FMP_INIT = 0,        /**< File manage initialization phase */
   FMP_RUNNING          /**< File manage running phase */
};

/**
 * File manager phase data type.
 */
typedef enum fmDBPhaseEnum fmDBPhase_t;

/**
 * File record data structure.
 */
struct fileRecordStruct {
   uint32_t size;                      /**< File size in bytes */
   uint32_t attributes;                /**< File attributes */
   uint32_t deviceSerialNumber;        /**< File device serial number */
   uint32_t posixTime;                 /**< File POSIX time */
   fileType_t type;                    /**< File type */
   char name[F1F2_FILE_NAME_SIZE + 1]; /**< File name (F1F2_FILE_NAME_SIZE + NULL char) */
   uint8_t isClosed;                   /**< Indicates whether the file is closed */
   union {
      struct {
         CalibrationCollectionType_t CollectionType;
         calibrationType_t CalibrationType;
         uint32_t ExternalLensSerialNumber;
         uint8_t FWPosition;
         uint8_t NDFPosition;
         uint8_t NumberOfBlocks;
         uint32_t BlockPOSIXTime[CALIB_MAX_NUM_OF_BLOCKS];
      } collection;                    /**< Collection file info */
      // Other file info structure here if necessary
   } info;                             /**< File info (based on file type) */
};

/**
 * File record data type.
 */
typedef struct fileRecordStruct fileRecord_t;

/**
 * File order.
 */
enum fileOrderEnum {
   FO_NONE = 0,         /**< None */
   FO_POSIX_TIME,       /**< Files are ordered by their POSIX time */
   FO_FILE_TYPE,        /**< Files are ordered by their file type */
   FO_FILE_NAME,        /**< Files are ordered by their file name */
   FO_COLLECTION_TYPE,  /**< Collection files are ordered by their collection type */
   FO_FW_POSITION,      /**< Collection files are ordered by their FW position */
   FO_NDF_POSITION,     /**< Collection files are ordered by their ND filer position */
   FO_EXT_LENS_SERIAL,  /**< Collection files are ordered by their external lens serial number */
   FO_COUNT             /**< File order count */
};

/**
 * File order data type.
 */
typedef enum fileOrderEnum fileOrder_t;

/**
 * File list data structure.
 */
struct fileListStruct {
   uint32_t count;                                    /**< File count */
   fileRecord_t *item[FM_MAX_NUM_FILE];               /**< File record pointer list */
   uint32_t keyCount;                                 /**< File order key count */
   fileOrder_t keys[FM_MAX_NUM_FILE_ORDER_KEY];       /**< File order key list */
};

/**
 * File list data type.
 */
typedef struct fileListStruct fileList_t;

/**
 * Global variables declaration.
 */
extern fileRecord_t gFM_fileDB[FM_MAX_NUM_FILE];

extern fileList_t gFM_files;
extern fileList_t gFM_collections;
extern fileList_t gFM_calibrationBlocks;
extern fileList_t gFM_nlBlocks;
extern fileList_t gFM_icuBlocks;
extern fileList_t gFM_calibrationActualizationFiles;

extern fileRecord_t *gFM_flashSettingsFile;

extern uint8_t tmpFileDataBuffer[FM_TEMP_FILE_DATA_BUFFER_SIZE];


IRC_Status_t File_Manager_Init(netIntf_t *netIntf, circBuffer_t *cmdQueue);
void File_Manager_SM();
IRC_Status_t FM_InitFileDB();
void FM_ListFileDB();
uint8_t FM_FileExists(const char *filename);
uint32_t FM_GetFileSize(const char *filename);
int FM_OpenFile(const char *filename, int oflag);
fileRecord_t *FM_CreateFile(const char *filename);
IRC_Status_t FM_ReadDataFromFile(uint8_t *data, const char *filename, uint32_t offset, uint32_t length);
IRC_Status_t FM_WriteDataToFile(uint8_t *data, const char *filename, uint32_t offset, uint32_t length);
IRC_Status_t FM_CloseFile(fileRecord_t *file, fmDBPhase_t phase);
IRC_Status_t FM_RemoveFile(fileRecord_t *file);
IRC_Status_t FM_Format();
IRC_Status_t FM_AddFileToList(fileRecord_t *file, fileList_t *fileList, uint32_t *fileIndex);
IRC_Status_t FM_RemoveFileFromList(fileRecord_t *file, fileList_t *fileList);
void FM_SetFileListKeys(fileList_t *fileList, const fileOrder_t *keys, const uint32_t keyCount);
void FM_SortFileList(fileList_t *fileList);
fileRecord_t *FM_FindFilePOSIXTimeInList(uint32_t posixTime, const fileList_t *fileList);
fileRecord_t *FM_FindFileNameInList(const char *filename, const fileList_t *fileList);
fileRecord_t *FM_GetFileRecord(uint32_t fileIndex);

#endif // FILE_MANAGER_H


