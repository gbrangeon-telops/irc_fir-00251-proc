/**
 * @file Calibration.c
 * Camera calibration module implementation.
 *
 * This file implements camera calibration module.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "Calibration.h"
#include "FileInfo.h"
#include "calib.h"
#include "FlashSettings.h"
#include "GC_Registers.h"
#include "Actualization.h"
#include "GPS.h"
#include "string.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "CRC.h"
#include "tel2000_param.h"
#include "proc_memory.h"
#include "EHDRI_Manager.h"
#include "mb_axi4l_bridge.h"
#include "BuiltInTests.h"
#include "FlashDynamicValues.h"

extern t_calib gCal;
extern int8_t gActualisationLoadBlockIdx;
extern bool gStartBetaQuantization;

static uint32_t CalibrationMode_backup;

/**
 * Calibration block information
 */
calibrationInfo_t calibrationInfo;

/**
 * Load calibration command flag
 */
static uint32_t cmLoadCalibration;

/**
 * Calibration file to load
 */
static fileRecord_t *cmCalibrationFile;


// Private function prototypes
static void Calibration_Init();
static IRC_Status_t Calibration_ValidateCollectionType();
static IRC_Status_t Calibration_LoadBlockLUTRQ(uint32_t blockIndex, uint32_t lutRQIndex);
static IRC_Status_t Calibration_CopyLUTRQData(uint8_t *buffer, uint32_t buflen, uint32_t offset, uint8_t lut_page);
static void disableGPSInterrupts(void);
static void enableGPSInterrupts(void);



/**
 * Start loading calibration file.
 *
 * @param file is a pointer to the file record of the calibration file to load.
 *
 * @return IRC_SUCCESS if successfully started to load calibration file.
 * @return IRC_FAILURE if failed to start to loading calibration file.
 */
IRC_Status_t Calibration_LoadCalibrationFile(fileRecord_t *file)
{
   if ((cmCalibrationFile != NULL) || (file == NULL))
   {
      return IRC_FAILURE;
   }

   cmLoadCalibration = 1;
   cmCalibrationFile = file;

   return IRC_SUCCESS;
}

/**
 * Start loading calibration file based on POSIX time.
 *
 * @param posixTime is the POSIX time of calibration file to load.
 *
 * @return IRC_SUCCESS if successfully started to load calibration file.
 * @return IRC_FAILURE if failed to start to loading calibration file.
 */
IRC_Status_t Calibration_LoadCalibrationFilePOSIXTime(uint32_t posixTime)
{
   fileRecord_t *file = NULL;

   file = FM_FindFilePOSIXTimeInList(posixTime, &gFM_collections);

   if (file == NULL)
   {
      file = FM_FindFilePOSIXTimeInList(posixTime, &gFM_calibrationBlocks);

      if (file == NULL)
      {
         CM_ERR("Cannot find calibration file (POSIX time = %d).", posixTime);
         return IRC_FAILURE;
      }
   }

   return Calibration_LoadCalibrationFile(file);
}

/**
 * Load collection file.
 *
 * @param file is a pointer to the file record of the collection file to load.
 * @param collectionInfo is a pointer to the collection information data structure to fill.
 *
 * @return IRC_SUCCESS if successfully started to load collection file.
 * @return IRC_FAILURE if failed to start to loading collection file.
 */
IRC_Status_t Calibration_LoadCollectionFile(fileRecord_t *file, calibCollectionInfo_t *collectionInfo)
{
   int fd;
   int byteCount;
   uint8_t error = 0;
   CalibCollection_CollectionFileHeader_t collectionFileHeader;
   uint16_t crc16;
   uint32_t i;
   uint32_t *p_uint32;
   extern bool gDisableFilterWheel;

   CM_INF("Loading calibration collection file %s (v%d.%d.%d, POSIX time = %d)...", file->name,
         file->version.major, file->version.minor, file->version.subMinor,
         file->posixTime);

   // Open collection file
   fd = FM_OpenFile(file->name, UO_RDONLY);
   if (fd == -1)
   {
      CM_ERR("Failed to open %s.", file->name);
      return IRC_FAILURE;
   }

   collectionInfo->file = file;

   // Read collection file header
   if (CalibCollection_ParseCollectionFileHeader(fd, &collectionFileHeader, NULL) == 0)
   {
      CM_ERR("Failed to parse collection file header.");

      // Close collection file
      if (uffs_close(fd) == -1)
      {
         CM_ERR("Failed to close collection file.");
      }

      return IRC_FAILURE;
   }

   if (collectionFileHeader.DeviceSerialNumber != flashSettings.DeviceSerialNumber)
   {
      CM_ERR("Wrong collection DeviceSerialNumber TEL%05d. Device serial number is TEL%05d.",
            collectionFileHeader.DeviceSerialNumber, flashSettings.DeviceSerialNumber);
      error = 1;
   }

   if (collectionFileHeader.DeviceDataFlowMajorVersion > CALIB_DATAFLOWMAJORVERSION)
   {
      CM_ERR("Collection data flow major version %d is not supported. Collection data is supported up to major version %d.",
            collectionFileHeader.DeviceDataFlowMajorVersion,
            CALIB_DATAFLOWMAJORVERSION);
      error = 1;
   }

   if ((collectionFileHeader.CalibrationType == CALT_NL) || (collectionFileHeader.CalibrationType == CALT_ICU))
   {
      CM_ERR("Collection cannot contain reference blocks (calibration type: %d).", collectionFileHeader.CalibrationType);
      error = 1;
   }

   // Transformation of a MPEHDRI collection into a MPFixed collection if EHDRI is not implemented
   if (!GC_EHDRIIsImplemented && collectionFileHeader.CollectionType == CCT_MultipointEHDRI)
   {
      collectionFileHeader.CollectionType = CCT_MultipointFixed;
   }

   if (((collectionFileHeader.CollectionType == CCT_TelopsFixed) && (collectionFileHeader.CalibrationType != CALT_TELOPS)) ||
         ((collectionFileHeader.CollectionType == CCT_TelopsFW) && (collectionFileHeader.CalibrationType != CALT_TELOPS)) ||
         ((collectionFileHeader.CollectionType == CCT_TelopsNDF) && (collectionFileHeader.CalibrationType != CALT_TELOPS)) ||
         ((collectionFileHeader.CollectionType == CCT_TelopsFOV) && (collectionFileHeader.CalibrationType != CALT_TELOPS)) ||
         ((collectionFileHeader.CollectionType == CCT_MultipointFixed) && (collectionFileHeader.CalibrationType != CALT_MULTIPOINT)) ||
         ((collectionFileHeader.CollectionType == CCT_MultipointEHDRI) && (collectionFileHeader.CalibrationType != CALT_MULTIPOINT)) ||
         ((collectionFileHeader.CollectionType == CCT_MultipointFW) && (collectionFileHeader.CalibrationType != CALT_MULTIPOINT)) ||
         ((collectionFileHeader.CollectionType == CCT_MultipointNDF) && (collectionFileHeader.CalibrationType != CALT_MULTIPOINT)) ||
         ((collectionFileHeader.CollectionType == CCT_MultipointFOV) && (collectionFileHeader.CalibrationType != CALT_MULTIPOINT)))
   {
      CM_ERR("CollectionType does not match CalibrationType (CollectionType: %d, CalibrationType: %d).",
            collectionFileHeader.CollectionType, collectionFileHeader.CalibrationType);
      error = 1;
   }

   if ((gDisableFilterWheel == 0) && (flashSettings.FWPresent == 0) && ((collectionFileHeader.CollectionType == CCT_TelopsFW) || (collectionFileHeader.CollectionType == CCT_MultipointFW)))
   {
      CM_ERR("Invalid CollectionType (FWPresent = %d, CollectionType = %d).", flashSettings.FWPresent, collectionFileHeader.CollectionType);
      error = 1;
   }

   if ((flashSettings.NDFPresent == 0) && ((collectionFileHeader.CollectionType == CCT_TelopsNDF) || (collectionFileHeader.CollectionType == CCT_MultipointNDF)))
   {
      CM_ERR("Invalid CollectionType (NDFPresent = %d, CollectionType = %d).", flashSettings.NDFPresent, collectionFileHeader.CollectionType);
      error = 1;
   }

   if ((!TDCFlagsTst(MotorizedFOVLensIsImplementedMask)) && ((collectionFileHeader.CollectionType == CCT_TelopsFOV) || (collectionFileHeader.CollectionType == CCT_MultipointFOV)))
   {
      CM_ERR("Invalid CollectionType (MotorizedLensType = %d, CollectionType = %d).", flashSettings.MotorizedLensType, collectionFileHeader.CollectionType);
      error = 1;
   }

   if (((collectionFileHeader.IntegrationMode != IM_IntegrateThenRead) || (!TDCFlagsTst(ITRIsImplementedMask))) &&
         ((collectionFileHeader.IntegrationMode != IM_IntegrateWhileRead) || (!TDCFlagsTst(IWRIsImplementedMask))))
   {
      CM_ERR("Invalid integration mode (%d).", collectionFileHeader.IntegrationMode);
      error = 1;
   }

   if ((collectionFileHeader.SensorWellDepth != SWD_LowGain) &&
         ((collectionFileHeader.SensorWellDepth != SWD_HighGain) || (!TDCFlagsTst(HighGainSWDIsImplementedMask))))
   {
      CM_ERR("Invalid sensor well depth (%d).", collectionFileHeader.SensorWellDepth);
      error = 1;
   }

   if (((collectionFileHeader.OffsetX + collectionFileHeader.Width) > FPA_WIDTH_MAX) ||
         ((collectionFileHeader.OffsetY + collectionFileHeader.Height) > FPA_HEIGHT_MAX))
   {
      CM_ERR("Calibrated area is outside FPA sensor area (OffsetX = %d, OffsetY = %d, Width = %d, Height = %d).",
            collectionFileHeader.OffsetX, collectionFileHeader.OffsetY,
            collectionFileHeader.Width, collectionFileHeader.Height);
      error = 1;
   }

   // Do not allow sub-window calibrations
   if ((collectionFileHeader.OffsetX > 0) || (collectionFileHeader.Width < FPA_WIDTH_MAX) ||
         (collectionFileHeader.OffsetY > 0) || (collectionFileHeader.Height < FPA_HEIGHT_MAX))
   {
      CM_ERR("Sub-window calibrations are not supported (OffsetX = %d, OffsetY = %d, Width = %d, Height = %d).",
            collectionFileHeader.OffsetX, collectionFileHeader.OffsetY,
            collectionFileHeader.Width, collectionFileHeader.Height);
      error = 1;
   }

   if (collectionFileHeader.PixelDataResolution != flashSettings.PixelDataResolution)
   {
      CM_ERR("Invalid pixel data resolution (%d).", collectionFileHeader.PixelDataResolution);
      error = 1;
   }

   if (((gDisableFilterWheel == 0) && (flashSettings.FWPresent == 0) && (collectionFileHeader.FWPosition != FWP_FilterWheelNotImplemented)) ||
         ((flashSettings.FWPresent == 1) &&
          (collectionFileHeader.FWPosition >= flashSettings.FWNumberOfFilters) &&
          (collectionFileHeader.FWPosition != FWP_FilterWheelInTransition)))
   {
      CM_ERR("Invalid filter wheel position (FWPosition = %d, FWPresent = %d, FWNumberOfFilters = %d).",
            collectionFileHeader.FWPosition, flashSettings.FWPresent, flashSettings.FWNumberOfFilters);
      error = 1;
   }

   if (((flashSettings.NDFPresent == 0) && (collectionFileHeader.NDFPosition != NDFP_NDFilterNotImplemented)) ||
         ((flashSettings.NDFPresent == 1) &&
          (collectionFileHeader.NDFPosition >= flashSettings.NDFNumberOfFilters) &&
          (collectionFileHeader.NDFPosition != NDFP_NDFilterInTransition)))
   {
      CM_ERR("Invalid neutral density filter position (NDFPosition = %d, NDFPresent = %d, NDFNumberOfFilters = %d).",
            collectionFileHeader.NDFPosition, flashSettings.NDFPresent, flashSettings.NDFNumberOfFilters);
      error = 1;
   }

   if (((!TDCFlagsTst(MotorizedFOVLensIsImplementedMask)) && (collectionFileHeader.FOVPosition != FOVP_FOVNotImplemented)) ||
         ((TDCFlagsTst(MotorizedFOVLensIsImplementedMask)) &&
          (collectionFileHeader.FOVPosition >= flashSettings.FOVNumberOfPositions) &&
          (collectionFileHeader.FOVPosition != FOVP_FOVInTransition)))
   {
      CM_ERR("Invalid field of view position (FOVPosition = %d, MotorizedLensType = %d, FOVNumberOfPositions = %d).",
            collectionFileHeader.FOVPosition, flashSettings.MotorizedLensType, flashSettings.FOVNumberOfPositions);
      error = 1;
   }

   if ((collectionFileHeader.NumberOfBlocks < 1) || (collectionFileHeader.NumberOfBlocks > CALIB_MAX_NUM_OF_BLOCKS))
   {
      CM_ERR("Number of calibration blocks in collection (%d) must be between 1 and %d.", collectionFileHeader.NumberOfBlocks, CALIB_MAX_NUM_OF_BLOCKS);
      error = 1;
   }

   // Check for error
   if (error)
   {
      // Close collection file
      if (uffs_close(fd) == -1)
      {
         CM_ERR("Failed to close collection file.");
      }

      return IRC_FAILURE;
   }

   collectionInfo->POSIXTime = collectionFileHeader.POSIXTime;
   collectionInfo->CollectionType = collectionFileHeader.CollectionType;
   collectionInfo->CalibrationType = collectionFileHeader.CalibrationType;
   collectionInfo->SensorID = collectionFileHeader.SensorID;
   collectionInfo->IntegrationMode = collectionFileHeader.IntegrationMode;
   collectionInfo->SensorWellDepth = collectionFileHeader.SensorWellDepth;
   collectionInfo->PixelDataResolution = collectionFileHeader.PixelDataResolution;
   collectionInfo->Width = collectionFileHeader.Width;
   collectionInfo->Height = collectionFileHeader.Height;
   collectionInfo->OffsetX = collectionFileHeader.OffsetX;
   collectionInfo->OffsetY = collectionFileHeader.OffsetY;
   collectionInfo->ReverseX = collectionFileHeader.ReverseX;
   collectionInfo->ReverseY = collectionFileHeader.ReverseY;
   collectionInfo->FWPosition = collectionFileHeader.FWPosition;
   collectionInfo->NDFPosition = collectionFileHeader.NDFPosition;
   collectionInfo->FOVPosition = collectionFileHeader.FOVPosition;
   collectionInfo->ExternalLensSerialNumber = collectionFileHeader.ExternalLensSerialNumber;
   collectionInfo->ManualFilterSerialNumber = collectionFileHeader.ManualFilterSerialNumber;
   collectionInfo->ReferencePOSIXTime = collectionFileHeader.ReferencePOSIXTime;
   collectionInfo->FluxRatio01 = collectionFileHeader.FluxRatio01;
   collectionInfo->FluxRatio12 = collectionFileHeader.FluxRatio12;
   collectionInfo->NumberOfBlocks = collectionFileHeader.NumberOfBlocks;

   CM_INF("Collection file header loaded.");

   byteCount = FM_ReadFileToTmpFileDataBuffer(fd, collectionFileHeader.CollectionDataLength);
   if (byteCount != collectionFileHeader.CollectionDataLength)
   {
      CM_ERR("Failed to read collection data.");
      error = 1;
   }
   else
   {
      // Test collection file data CRC-16
      crc16 = CRC16(0xFFFF, (uint8_t *) tmpFileDataBuffer, collectionFileHeader.CollectionDataLength);
      if (crc16 != collectionFileHeader.CollectionDataCRC16)
      {
         CM_ERR("Collection file data CRC-16 mismatch (computed:0x%04X, file:0x%04X).", crc16, collectionFileHeader.CollectionDataCRC16);
         error = 1;
      }
      else
      {
         p_uint32 = (uint32_t *) tmpFileDataBuffer;
         for (i = 0; i < collectionInfo->NumberOfBlocks; i++)
         {
            collectionInfo->BlockPOSIXTime[i] = p_uint32[i];
         }

         CM_INF("Collection file data loaded.");
      }
   }

   // Close collection file
   if (uffs_close(fd) == -1)
   {
      CM_ERR("Failed to close collection file.");
      error = 1;
   }

   if (error)
   {
      return IRC_FAILURE;
   }
   else
   {
      collectionInfo->isValid = 1;
      return IRC_SUCCESS;
   }
}

/**
 * Calibration manager state machine.

\dot
digraph G {
   CMS_INIT -> CMS_IDLE -> CMS_LOAD_COLLECTION_FILE_HEADER -> CMS_LOAD_COLLECTION_DATA -> CMS_OPEN_BLOCK_FILE -> CMS_LOAD_BLOCK_FILE_HEADER -> CMS_LOAD_PIXEL_DATA_HEADER
   CMS_LOAD_PIXEL_DATA_HEADER -> CMS_LOAD_PIXEL_DATA -> CMS_LOAD_MAXTK_DATA_HEADER
   CMS_LOAD_PIXEL_DATA_HEADER -> CMS_LOAD_MAXTK_DATA_HEADER
   CMS_LOAD_MAXTK_DATA_HEADER -> CMS_LOAD_MAXTK_DATA -> CMS_LOAD_LUTNL_DATA_HEADER
   CMS_LOAD_MAXTK_DATA_HEADER -> CMS_LOAD_LUTNL_DATA_HEADER
   CMS_LOAD_LUTNL_DATA_HEADER -> CMS_LOAD_LUTNL_DATA -> CMS_LOAD_LUTRQ_DATA_HEADER
   CMS_LOAD_LUTNL_DATA_HEADER -> CMS_LOAD_LUTRQ_DATA_HEADER
   CMS_LOAD_LUTRQ_DATA_HEADER -> CMS_LOAD_LUTRQ_DATA -> CMS_FINALIZE_BLOCK
   CMS_LOAD_LUTRQ_DATA_HEADER -> CMS_FINALIZE_BLOCK
   CMS_FINALIZE_BLOCK -> CMS_OPEN_BLOCK_FILE
   CMS_FINALIZE_BLOCK -> CMS_FINALIZE_COLLECTION
   CMS_FINALIZE_COLLECTION -> CMS_IDLE
   CMS_LOAD_COLLECTION_FILE_HEADER -> CMS_ERROR
   CMS_LOAD_COLLECTION_DATA -> CMS_ERROR
   CMS_OPEN_BLOCK_FILE -> CMS_ERROR
   CMS_LOAD_BLOCK_FILE_HEADER -> CMS_ERROR
   CMS_LOAD_PIXEL_DATA_HEADER -> CMS_ERROR
   CMS_LOAD_PIXEL_DATA -> CMS_ERROR
   CMS_LOAD_MAXTK_DATA_HEADER -> CMS_ERROR
   CMS_LOAD_MAXTK_DATA -> CMS_ERROR
   CMS_LOAD_LUTNL_DATA_HEADER -> CMS_ERROR
   CMS_LOAD_LUTNL_DATA -> CMS_ERROR
   CMS_LOAD_LUTRQ_DATA_HEADER -> CMS_ERROR
   CMS_LOAD_LUTRQ_DATA -> CMS_ERROR
   CMS_FINALIZE_BLOCK -> CMS_ERROR
}
\enddot

 */
void Calibration_SM()
{
   static cmState_t cmCurrentState = CMS_INIT;
   static fileInfo_t fileInfo;
   static int fdCalib;
   static uint32_t dataOffset;
   static uint16_t crc16;
   static uint16_t dataCRC16;
   static uint32_t dataLength;
   static uint64_t tic_collection;
   static uint64_t tic_block;
   static uint64_t tic_calibUpdate;
   static uint32_t blockIndex;
   static fileRecord_t *blockFiles[CALIB_MAX_NUM_OF_BLOCKS];
   static uint32_t lutRQIndex;
   static uint32_t lutRQCount;
   static uint32_t lutNLCount;
   static uint8_t startup = 1;
   static deltabeta_t* deltaBetaDataAddr = NULL;
   static bool once = false;
   static bool gpsDisabled;

   extern flashDynamicValues_t gFlashDynamicValues;
   extern bool blockLoadCmdFlag;
   extern bool gDisableFilterWheel;

   int byteCount;
   int retval;
   uint32_t length;
   uint32_t i;
   uint32_t *p_uint32;
   union {
      CalibBlock_BlockFileHeader_t blockFile;
      CalibBlock_PixelDataHeader_t pixelData;
      CalibBlock_MaxTKDataHeader_t maxTKData;
      CalibBlock_LUTNLDataHeader_t lutNLData;
      CalibBlock_LUTRQDataHeader_t lutRQData;
   } headerData;

   switch (cmCurrentState)
   {
      case CMS_INIT:
         cmLoadCalibration = 0;
         cmCalibrationFile = NULL;
         fdCalib = -1;

         Calibration_Reset();

         // Load first calibration collection
         if (gFM_collections.count > 0)
         {
            i = 0;

            if (gFlashDynamicValues.CalibrationCollectionPOSIXTimeAtStartup != 0)
            {
               for (i = gFM_collections.count - 1; i > 0; i--)
               {
                  if (gFM_collections.item[i]->posixTime == gFlashDynamicValues.CalibrationCollectionPOSIXTimeAtStartup)
                  {
                     break;
                  }
               }
            }

            gcRegsData.CalibrationCollectionSelector = i;
            cmCalibrationFile = gFM_collections.item[i];
            cmLoadCalibration = 1;
         }
         else
         {
            builtInTests[BITID_CalibrationFilesLoading].result = BITR_Failed;
            CM_ERR("Cannot find calibration data.");
            startup = 0;
         }

         cmCurrentState = CMS_IDLE;
         break;

      case CMS_IDLE:
         if (gpsDisabled)
         {
            enableGPSInterrupts();
            gpsDisabled = false;
         }

         if (cmLoadCalibration)
         {
            cmLoadCalibration = 0;

            TDCStatusSet(WaitingForCalibrationDataMask);
            builtInTests[BITID_CalibrationFilesLoading].result = BITR_Pending;

            Calibration_Init();

            blockIndex = 0;
            lutRQCount = 0;
            lutNLCount = 0;

            // Initialize average
            calibrationInfo.collection.DeviceTemperatureSensor = 0;

            if (cmCalibrationFile->type == FT_TSCO)
            {
               cmCurrentState = CMS_LOAD_COLLECTION_FILE;
               disableGPSInterrupts();
               gpsDisabled = true;
            }
            else if (cmCalibrationFile->type == FT_TSBL)
            {
               calibrationInfo.collection.NumberOfBlocks = 1;
               blockFiles[0] = cmCalibrationFile;
               cmCurrentState = CMS_OPEN_BLOCK_FILE;
               disableGPSInterrupts();
               gpsDisabled = true;
            }
            else
            {
               CM_ERR("Specified file is not a calibration file.");
               cmCurrentState = CMS_ERROR;
            }
         }
         break;

      case CMS_LOAD_COLLECTION_FILE:
         GETTIME(&tic_collection);

         cmCurrentState = CMS_OPEN_BLOCK_FILE;

         if (Calibration_LoadCollectionFile(cmCalibrationFile, &calibrationInfo.collection) == IRC_SUCCESS)
         {
            for (i = 0; i < calibrationInfo.collection.NumberOfBlocks; i++)
            {
               blockFiles[i] = FM_FindFilePOSIXTimeInList(calibrationInfo.collection.BlockPOSIXTime[i], &gFM_calibrationBlocks);
               if (blockFiles[i] == NULL)
               {
                  CM_ERR("Cannot find calibration block file (POSIX time = %d).", calibrationInfo.collection.BlockPOSIXTime[i]);
                  cmCurrentState = CMS_ERROR;
                  break;
               }
            }
         }
         else
         {
            cmCurrentState = CMS_ERROR;
         }
         break;

      case CMS_OPEN_BLOCK_FILE:
         CM_INF("Loading calibration block file %s (v%d.%d.%d, POSIX time = %d)...", blockFiles[blockIndex]->name,
               blockFiles[blockIndex]->version.major, blockFiles[blockIndex]->version.minor, blockFiles[blockIndex]->version.subMinor,
               blockFiles[blockIndex]->posixTime);
         GETTIME(&tic_block);

         fdCalib = FM_OpenFile(blockFiles[blockIndex]->name, UO_RDONLY);
         if (fdCalib != -1)
         {
            calibrationInfo.blocks[blockIndex].file = blockFiles[blockIndex];
            cmCurrentState = CMS_LOAD_BLOCK_FILE_HEADER;
         }
         else
         {
            CM_ERR("Failed to open %s.", blockFiles[blockIndex]->name);
            cmCurrentState = CMS_ERROR;
         }
         break;

      case CMS_LOAD_BLOCK_FILE_HEADER:
         byteCount = CalibBlock_ParseBlockFileHeader(fdCalib, &headerData.blockFile, &fileInfo);
         if (byteCount == 0)
         {
            CM_ERR("Failed to parse calibration block file header.");
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            cmCurrentState = CMS_LOAD_PIXEL_DATA_HEADER;

            if (headerData.blockFile.DeviceSerialNumber != flashSettings.DeviceSerialNumber)
            {
               CM_ERR("Block %d: Wrong block DeviceSerialNumber TEL%05d. Device serial number is TEL%05d.",
                     headerData.blockFile.POSIXTime, headerData.blockFile.DeviceSerialNumber, flashSettings.DeviceSerialNumber);
               cmCurrentState = CMS_ERROR;
            }

            if (headerData.blockFile.DeviceDataFlowMajorVersion > CALIB_DATAFLOWMAJORVERSION)
            {
               CM_ERR("Block data flow major version %d is not supported. Block data is supported up to major version %d.",
                     headerData.blockFile.DeviceDataFlowMajorVersion,
                     CALIB_DATAFLOWMAJORVERSION);
               cmCurrentState = CMS_ERROR;
            }

            // Validate calibration collection/block consistency
            if (cmCalibrationFile->type == FT_TSCO)
            {
               if (headerData.blockFile.CalibrationType != calibrationInfo.collection.CalibrationType)
               {
                  CM_ERR("Block %d: Calibration type mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.CalibrationType, headerData.blockFile.CalibrationType);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.SensorID != calibrationInfo.collection.SensorID)
               {
                  CM_ERR("Block %d: Sensor ID mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.SensorID, headerData.blockFile.SensorID);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.IntegrationMode != calibrationInfo.collection.IntegrationMode)
               {
                  CM_ERR("Block %d: Integration mode mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.IntegrationMode, headerData.blockFile.IntegrationMode);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.SensorWellDepth != calibrationInfo.collection.SensorWellDepth)
               {
                  CM_ERR("Block %d: Sensor well depth mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.SensorWellDepth, headerData.blockFile.SensorWellDepth);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.PixelDataResolution != calibrationInfo.collection.PixelDataResolution)
               {
                  CM_ERR("Block %d: Pixel data resolution mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.PixelDataResolution, headerData.blockFile.PixelDataResolution);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.Width != calibrationInfo.collection.Width)
               {
                  CM_ERR("Block %d: Width mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.Width, headerData.blockFile.Width);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.Height != calibrationInfo.collection.Height)
               {
                  CM_ERR("Block %d: Height mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.Height, headerData.blockFile.Height);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.OffsetX != calibrationInfo.collection.OffsetX)
               {
                  CM_ERR("Block %d: OffsetX mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.OffsetX, headerData.blockFile.OffsetX);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.OffsetY != calibrationInfo.collection.OffsetY)
               {
                  CM_ERR("Block %d: OffsetY mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.OffsetY, headerData.blockFile.OffsetY);
                  cmCurrentState = CMS_ERROR;
               }

               if ((calibrationInfo.collection.FWPosition != FWP_FilterWheelInTransition) && (headerData.blockFile.FWPosition != calibrationInfo.collection.FWPosition))
               {
                  CM_ERR("Block %d: Filter wheel position mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.FWPosition, headerData.blockFile.FWPosition);
                  cmCurrentState = CMS_ERROR;
               }

               if ((calibrationInfo.collection.NDFPosition != NDFP_NDFilterInTransition) && (headerData.blockFile.NDFPosition != calibrationInfo.collection.NDFPosition))
               {
                  CM_ERR("Block %d: Neutral density filter position mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.NDFPosition, headerData.blockFile.NDFPosition);
                  cmCurrentState = CMS_ERROR;
               }

               if ((calibrationInfo.collection.FOVPosition != FOVP_FOVInTransition) && (headerData.blockFile.FOVPosition != calibrationInfo.collection.FOVPosition))
               {
                  CM_ERR("Block %d: Field of view position mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.FOVPosition, headerData.blockFile.FOVPosition);
                  cmCurrentState = CMS_ERROR;
               }

               if (headerData.blockFile.ReferencePOSIXTime != calibrationInfo.collection.ReferencePOSIXTime)
               {
                  CM_ERR("Block %d: Reference POSIX time mismatch (C: %d, B: %d).", headerData.blockFile.POSIXTime, calibrationInfo.collection.ReferencePOSIXTime, headerData.blockFile.ReferencePOSIXTime);
                  cmCurrentState = CMS_ERROR;
               }
            }

            if ((((gDisableFilterWheel == 0) && flashSettings.FWPresent == 0) && (headerData.blockFile.FWPosition != FWP_FilterWheelNotImplemented)) ||
                  ((flashSettings.FWPresent == 1) &&
                   (headerData.blockFile.FWPosition >= flashSettings.FWNumberOfFilters) &&
                   (headerData.blockFile.FWPosition != FWP_FilterWheelInTransition)))
            {
               CM_ERR("Block %d: Invalid filter wheel position (FWPosition = %d, FWPresent = %d, FWNumberOfFilters = %d).",
                     headerData.blockFile.POSIXTime, headerData.blockFile.FWPosition, flashSettings.FWPresent, flashSettings.FWNumberOfFilters);
               cmCurrentState = CMS_ERROR;
            }

            if (((flashSettings.NDFPresent == 0) && (headerData.blockFile.NDFPosition != NDFP_NDFilterNotImplemented)) ||
                  ((flashSettings.NDFPresent == 1) &&
                   (headerData.blockFile.NDFPosition >= flashSettings.NDFNumberOfFilters) &&
                   (headerData.blockFile.NDFPosition != NDFP_NDFilterInTransition)))
            {
               CM_ERR("Block %d: Invalid neutral density filter position (NDFPosition = %d, NDFPresent = %d, NDFNumberOfFilters = %d).",
                     headerData.blockFile.POSIXTime, headerData.blockFile.NDFPosition, flashSettings.NDFPresent, flashSettings.NDFNumberOfFilters);
               cmCurrentState = CMS_ERROR;
            }

            if (((!TDCFlagsTst(MotorizedFOVLensIsImplementedMask)) && (headerData.blockFile.FOVPosition != FOVP_FOVNotImplemented)) ||
                  ((TDCFlagsTst(MotorizedFOVLensIsImplementedMask)) &&
                   (headerData.blockFile.FOVPosition >= flashSettings.FOVNumberOfPositions) &&
                   (headerData.blockFile.FOVPosition != FOVP_FOVInTransition)))
            {
               CM_ERR("Block %d: Invalid field of view position (FOVPosition = %d, MotorizedLensType = %d, FOVNumberOfPositions = %d).",
                     headerData.blockFile.POSIXTime, headerData.blockFile.FOVPosition, flashSettings.MotorizedLensType, flashSettings.FOVNumberOfPositions);
               cmCurrentState = CMS_ERROR;
            }

            if ((headerData.blockFile.LUTRQDataPresence) && ((headerData.blockFile.NumberOfLUTRQ < 1) || (headerData.blockFile.NumberOfLUTRQ > LUTRQI_MAX_NUM_OF_LUTRQ)))
            {
               CM_ERR("Number of radiometric LUT in block (%d) must be between 1 and %d (block POSIX time = %d).", headerData.blockFile.NumberOfLUTRQ, LUTRQI_MAX_NUM_OF_LUTRQ, headerData.blockFile.POSIXTime);
               cmCurrentState = CMS_ERROR;
            }

            uint8_t fpa_pixel_pitch_um = (uint8_t)(FPA_PIXEL_PITCH * 1E+6F);

            if (headerData.blockFile.SensorPixelPitch != fpa_pixel_pitch_um)
            {
               CM_ERR("Block %d: Wrong block SensorPixelPitch (%d um). FPA_PIXEL_PITCH is %d um.",
                     headerData.blockFile.POSIXTime, headerData.blockFile.SensorPixelPitch, fpa_pixel_pitch_um);
               cmCurrentState = CMS_ERROR;
            }

            if (cmCurrentState != CMS_ERROR)
            {
               if (cmCalibrationFile->type == FT_TSBL)
               {
                  // Emulate calibration collection
                  calibrationInfo.collection.POSIXTime = headerData.blockFile.POSIXTime;
                  calibrationInfo.collection.CollectionType =  DefaultCollectionType(headerData.blockFile.CalibrationType);
                  calibrationInfo.collection.CalibrationType = headerData.blockFile.CalibrationType;
                  calibrationInfo.collection.SensorID = headerData.blockFile.SensorID;
                  calibrationInfo.collection.IntegrationMode = headerData.blockFile.IntegrationMode;
                  calibrationInfo.collection.SensorWellDepth = headerData.blockFile.SensorWellDepth;
                  calibrationInfo.collection.PixelDataResolution = headerData.blockFile.PixelDataResolution;
                  calibrationInfo.collection.Width = headerData.blockFile.Width;
                  calibrationInfo.collection.Height = headerData.blockFile.Height;
                  calibrationInfo.collection.OffsetX = headerData.blockFile.OffsetX;
                  calibrationInfo.collection.OffsetY = headerData.blockFile.OffsetY;
                  calibrationInfo.collection.ReverseX = headerData.blockFile.ReverseX;
                  calibrationInfo.collection.ReverseY = headerData.blockFile.ReverseY;
                  calibrationInfo.collection.FWPosition = headerData.blockFile.FWPosition;
                  calibrationInfo.collection.NDFPosition = headerData.blockFile.NDFPosition;
                  calibrationInfo.collection.FOVPosition = headerData.blockFile.FOVPosition;
                  calibrationInfo.collection.ExternalLensSerialNumber = headerData.blockFile.ExternalLensSerialNumber;
                  calibrationInfo.collection.ManualFilterSerialNumber = headerData.blockFile.ManualFilterSerialNumber;
                  calibrationInfo.collection.ReferencePOSIXTime = headerData.blockFile.ReferencePOSIXTime;
                  calibrationInfo.collection.FluxRatio01 = 0;
                  calibrationInfo.collection.FluxRatio12 = 0;
                  calibrationInfo.collection.isValid = 1;
               }

               calibrationInfo.collection.DeviceTemperatureSensor += headerData.blockFile.DeviceTemperatureSensor;
               calibrationInfo.blocks[blockIndex].POSIXTime = headerData.blockFile.POSIXTime;
               calibrationInfo.blocks[blockIndex].ExposureTime = headerData.blockFile.ExposureTime;
               calibrationInfo.blocks[blockIndex].AcquisitionFrameRate = headerData.blockFile.AcquisitionFrameRate;
               calibrationInfo.blocks[blockIndex].FWPosition = headerData.blockFile.FWPosition;
               calibrationInfo.blocks[blockIndex].NDFPosition = headerData.blockFile.NDFPosition;
               calibrationInfo.blocks[blockIndex].FOVPosition = headerData.blockFile.FOVPosition;
               calibrationInfo.blocks[blockIndex].ImageCorrectionFocusPositionRaw = headerData.blockFile.ImageCorrectionFocusPositionRaw;
               calibrationInfo.blocks[blockIndex].ExternalLensFocalLength = headerData.blockFile.ExternalLensFocalLength;
               calibrationInfo.blocks[blockIndex].ExternalLensSerialNumber = headerData.blockFile.ExternalLensSerialNumber;
               calibrationInfo.blocks[blockIndex].ManualFilterSerialNumber = headerData.blockFile.ManualFilterSerialNumber;
               calibrationInfo.blocks[blockIndex].PixelDynamicRangeMin = headerData.blockFile.PixelDynamicRangeMin;
               calibrationInfo.blocks[blockIndex].PixelDynamicRangeMax = headerData.blockFile.PixelDynamicRangeMax;
               calibrationInfo.blocks[blockIndex].SaturationThreshold = headerData.blockFile.SaturationThreshold;
               calibrationInfo.blocks[blockIndex].BlockBadPixelCount = headerData.blockFile.BlockBadPixelCount;
               calibrationInfo.blocks[blockIndex].MaximumTotalFlux = headerData.blockFile.MaximumTotalFlux;
               calibrationInfo.blocks[blockIndex].NUCMultFactor = headerData.blockFile.NUCMultFactor;
               calibrationInfo.blocks[blockIndex].T0 = headerData.blockFile.T0;
               calibrationInfo.blocks[blockIndex].Nu = headerData.blockFile.Nu;
               calibrationInfo.blocks[blockIndex].DeviceTemperatureSensor = headerData.blockFile.DeviceTemperatureSensor;
               calibrationInfo.blocks[blockIndex].PixelDataPresence = headerData.blockFile.PixelDataPresence;
               calibrationInfo.blocks[blockIndex].MaxTKDataPresence = headerData.blockFile.MaxTKDataPresence;
               calibrationInfo.blocks[blockIndex].LUTNLDataPresence = headerData.blockFile.LUTNLDataPresence;
               calibrationInfo.blocks[blockIndex].LUTRQDataPresence = headerData.blockFile.LUTRQDataPresence;
               calibrationInfo.blocks[blockIndex].NumberOfLUTRQ = headerData.blockFile.NumberOfLUTRQ;
               calibrationInfo.blocks[blockIndex].CalibrationSource = headerData.blockFile.CalibrationSource;
               calibrationInfo.blocks[blockIndex].LowCut = headerData.blockFile.LowCut;
               calibrationInfo.blocks[blockIndex].HighCut = headerData.blockFile.HighCut;

               CM_INF("Calibration block file header loaded.");
            }
         }
         break;

      case CMS_LOAD_PIXEL_DATA_HEADER:
         if (calibrationInfo.blocks[blockIndex].PixelDataPresence == 1)
         {
            byteCount = CalibBlock_ParsePixelDataHeader(fdCalib, &fileInfo, &headerData.pixelData);
            if (byteCount == 0)
            {
               CM_ERR("Failed to parse pixel data header.");
               cmCurrentState = CMS_ERROR;
            }
            else
            {
               if (headerData.pixelData.PixelDataLength > CM_CALIB_BLOCK_PIXEL_DATA_SIZE)  //memory for one block
               {
                  CM_ERR("Pixel data length exceeds DDR memory pixel data buffer size.");
                  cmCurrentState = CMS_ERROR;
               }
               else
               {
                  calibrationInfo.blocks[blockIndex].pixelData.Offset_Off = headerData.pixelData.Offset_Off;
                  calibrationInfo.blocks[blockIndex].pixelData.Offset_Median = headerData.pixelData.Offset_Median;
                  calibrationInfo.blocks[blockIndex].pixelData.Offset_Exp = headerData.pixelData.Offset_Exp;
                  calibrationInfo.blocks[blockIndex].pixelData.Offset_Nbits = headerData.pixelData.Offset_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.Offset_Signed = headerData.pixelData.Offset_Signed;
                  calibrationInfo.blocks[blockIndex].pixelData.Range_Off = headerData.pixelData.Range_Off;
                  calibrationInfo.blocks[blockIndex].pixelData.Range_Median = headerData.pixelData.Range_Median;
                  calibrationInfo.blocks[blockIndex].pixelData.Range_Exp = headerData.pixelData.Range_Exp;
                  calibrationInfo.blocks[blockIndex].pixelData.Range_Nbits = headerData.pixelData.Range_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.Range_Signed = headerData.pixelData.Range_Signed;
                  calibrationInfo.blocks[blockIndex].pixelData.Kappa_Off = headerData.pixelData.Kappa_Off;
                  calibrationInfo.blocks[blockIndex].pixelData.Kappa_Median = headerData.pixelData.Kappa_Median;
                  calibrationInfo.blocks[blockIndex].pixelData.Kappa_Exp = headerData.pixelData.Kappa_Exp;
                  calibrationInfo.blocks[blockIndex].pixelData.Kappa_Nbits = headerData.pixelData.Kappa_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.Kappa_Signed = headerData.pixelData.Kappa_Signed;
                  calibrationInfo.blocks[blockIndex].pixelData.Beta0_Off = headerData.pixelData.Beta0_Off;
                  calibrationInfo.blocks[blockIndex].pixelData.Beta0_Median = headerData.pixelData.Beta0_Median;
                  calibrationInfo.blocks[blockIndex].pixelData.Beta0_Exp = headerData.pixelData.Beta0_Exp;
                  calibrationInfo.blocks[blockIndex].pixelData.Beta0_Nbits = headerData.pixelData.Beta0_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.Beta0_Signed = headerData.pixelData.Beta0_Signed;
                  calibrationInfo.blocks[blockIndex].pixelData.Alpha_Off = headerData.pixelData.Alpha_Off;
                  calibrationInfo.blocks[blockIndex].pixelData.Alpha_Median = headerData.pixelData.Alpha_Median;
                  calibrationInfo.blocks[blockIndex].pixelData.Alpha_Exp = headerData.pixelData.Alpha_Exp;
                  calibrationInfo.blocks[blockIndex].pixelData.Alpha_Nbits = headerData.pixelData.Alpha_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.Alpha_Signed = headerData.pixelData.Alpha_Signed;
                  calibrationInfo.blocks[blockIndex].pixelData.LUTNLIndex_Nbits = headerData.pixelData.LUTNLIndex_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.LUTNLIndex_Signed = headerData.pixelData.LUTNLIndex_Signed;
                  calibrationInfo.blocks[blockIndex].pixelData.BadPixel_Nbits = headerData.pixelData.BadPixel_Nbits;
                  calibrationInfo.blocks[blockIndex].pixelData.BadPixel_Signed = headerData.pixelData.BadPixel_Signed;

                  dataLength = headerData.pixelData.PixelDataLength;
                  dataCRC16 = headerData.pixelData.PixelDataCRC16;
                  dataOffset = 0;
                  crc16 = 0xFFFF;

                  CM_INF("Pixel data header loaded.");
                  cmCurrentState = CMS_LOAD_PIXEL_DATA;
               }
            }
         }
         else
         {
            cmCurrentState = CMS_LOAD_MAXTK_DATA_HEADER;
         }
         break;

      case CMS_LOAD_PIXEL_DATA:
         length = MIN(CM_MAX_FILE_READ_SIZE, dataLength - dataOffset);

         byteCount = uffs_read(fdCalib, (void *) PROC_MEM_PIXEL_DATA_BASEADDR + (blockIndex * CM_CALIB_BLOCK_PIXEL_DATA_SIZE) + dataOffset, length);
         if (byteCount != length)
         {
            CM_ERR("Failed to read pixel data.");
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            // Compute CRC-16 value
            crc16 = CRC16(crc16, (void *) PROC_MEM_PIXEL_DATA_BASEADDR + (blockIndex * CM_CALIB_BLOCK_PIXEL_DATA_SIZE) + dataOffset, length);

            dataOffset += length;

            if (dataOffset % (dataLength/4) == 0)  // print each 25%
               CM_INF( "Loading pixel data...");

            if (dataOffset == dataLength)
            {
               // Test pixel data CRC-16
               if (crc16 != dataCRC16)
               {
                  CM_ERR("Pixel data CRC-16 mismatch (computed:0x%04X, file:0x%04X).", crc16, dataCRC16);
                  cmCurrentState = CMS_ERROR;
               }
               else
               {
                  CM_INF("Pixel data loaded.");
                  if (ACT_shouldUpdateCurrentCalibration(&calibrationInfo, blockIndex))
                  {
                     cmCurrentState = CMS_UPDATE_PIXEL_DATA;
                     gStartBetaQuantization = true;
                     dataOffset = 0;
                     deltaBetaDataAddr = ACT_getSuitableDeltaBetaForBlock(&calibrationInfo, blockIndex);
                     if (deltaBetaDataAddr == NULL)
                     {
                        CM_ERR("No actualisation found");
                        cmCurrentState = CMS_LOAD_MAXTK_DATA_HEADER;
                     }
                     GETTIME(&tic_calibUpdate);
                  }
                  else
                  {
                     cmCurrentState = CMS_LOAD_MAXTK_DATA_HEADER;
                  }
               }
            }
         }
         break;

      case CMS_UPDATE_PIXEL_DATA:
         {
            IRC_Status_t bq_status = BetaQuantizer_SM(blockIndex);

            if (bq_status == IRC_DONE)
            {
               calibrationInfo.blocks[blockIndex].CalibrationSource = CS_ACTUALIZED;
               cmCurrentState = CMS_LOAD_MAXTK_DATA_HEADER;
            }

            if (bq_status == IRC_FAILURE)
            {
               CM_ERR("Failed to update pixel data.");
               cmCurrentState = CMS_ERROR;
            }
         }
         break;

      case CMS_LOAD_MAXTK_DATA_HEADER:
         if (calibrationInfo.blocks[blockIndex].MaxTKDataPresence == 1)
         {
            byteCount = CalibBlock_ParseMaxTKDataHeader(fdCalib, &fileInfo, &headerData.maxTKData);
            if (byteCount == 0)
            {
               CM_ERR("Failed to parse MaxTK data header.");
               cmCurrentState = CMS_ERROR;
            }
            else
            {
               calibrationInfo.blocks[blockIndex].maxTKData.TCalMin = headerData.maxTKData.TCalMin;
               calibrationInfo.blocks[blockIndex].maxTKData.TCalMax = headerData.maxTKData.TCalMax;
               calibrationInfo.blocks[blockIndex].maxTKData.TCalMinExpTimeMin = headerData.maxTKData.TCalMinExpTimeMin;
               calibrationInfo.blocks[blockIndex].maxTKData.TCalMinExpTimeMax = headerData.maxTKData.TCalMinExpTimeMax;
               calibrationInfo.blocks[blockIndex].maxTKData.TCalMaxExpTimeMin = headerData.maxTKData.TCalMaxExpTimeMin;
               calibrationInfo.blocks[blockIndex].maxTKData.TCalMaxExpTimeMax = headerData.maxTKData.TCalMaxExpTimeMax;
               calibrationInfo.blocks[blockIndex].maxTKData.TvsINT_FitOrder = headerData.maxTKData.TvsINT_FitOrder;
               calibrationInfo.blocks[blockIndex].maxTKData.INTvsT_FitOrder = headerData.maxTKData.INTvsT_FitOrder;

               dataLength = headerData.maxTKData.MaxTKDataLength;
               dataCRC16 = headerData.maxTKData.MaxTKDataCRC16;
               dataOffset = 0;
               crc16 = 0xFFFF;

               CM_INF("MaxTK data header loaded.");
               cmCurrentState = CMS_LOAD_MAXTK_DATA;
            }
         }
         else
         {
            cmCurrentState = CMS_LOAD_LUTNL_DATA_HEADER;
         }
         break;

      case CMS_LOAD_MAXTK_DATA:
         length = MIN(CM_MAX_FILE_READ_SIZE, dataLength - dataOffset);

         byteCount = uffs_read(fdCalib, (void *) calibrationInfo.blocks[blockIndex].maxTKData.coeffs + dataOffset, length);
         if (byteCount != length)
         {
            CM_ERR("Failed to read MaxTK data.");
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            // Compute CRC-16 value
            crc16 = CRC16(crc16, (void *) calibrationInfo.blocks[blockIndex].maxTKData.coeffs + dataOffset, length);

            dataOffset += length;
            if (dataOffset == dataLength)
            {
               // Test maxTK data CRC-16
               if (crc16 != dataCRC16)
               {
                  CM_ERR("MaxTK data CRC-16 mismatch (computed:0x%04X, file:0x%04X).", crc16, dataCRC16);
                  cmCurrentState = CMS_ERROR;
               }
               else
               {
                  CM_INF("MaxTK data loaded.");
                  cmCurrentState = CMS_LOAD_LUTNL_DATA_HEADER;
               }
            }
         }
         break;

      case CMS_LOAD_LUTNL_DATA_HEADER:
         if (calibrationInfo.blocks[blockIndex].LUTNLDataPresence == 1)
         {
            byteCount = CalibBlock_ParseLUTNLDataHeader(fdCalib, &fileInfo, &headerData.lutNLData);
            if (byteCount == 0)
            {
               CM_ERR("Failed to parse LUTNL data header.");
               cmCurrentState = CMS_ERROR;
            }
            else
            {
               calibrationInfo.blocks[blockIndex].lutNLData.LUT_Xmin = headerData.lutNLData.LUT_Xmin;
               calibrationInfo.blocks[blockIndex].lutNLData.LUT_Xrange = headerData.lutNLData.LUT_Xrange;
               calibrationInfo.blocks[blockIndex].lutNLData.LUT_Size = headerData.lutNLData.LUT_Size;
               calibrationInfo.blocks[blockIndex].lutNLData.M_Exp = headerData.lutNLData.M_Exp;
               calibrationInfo.blocks[blockIndex].lutNLData.B_Exp = headerData.lutNLData.B_Exp;
               calibrationInfo.blocks[blockIndex].lutNLData.M_Nbits = headerData.lutNLData.M_Nbits;
               calibrationInfo.blocks[blockIndex].lutNLData.B_Nbits = headerData.lutNLData.B_Nbits;
               calibrationInfo.blocks[blockIndex].lutNLData.M_Signed = headerData.lutNLData.M_Signed;
               calibrationInfo.blocks[blockIndex].lutNLData.B_Signed = headerData.lutNLData.B_Signed;
               calibrationInfo.blocks[blockIndex].lutNLData.NumberOfLUTNL = headerData.lutNLData.NumberOfLUTNL;

               dataLength = headerData.lutNLData.LUT_Size * sizeof(uint32_t);    //read 1 LUT at a time
               dataCRC16 = headerData.lutNLData.LUTNLDataCRC16;
               dataOffset = 0;
               crc16 = 0xFFFF;

               CM_INF("LUTNL data header loaded.");
               cmCurrentState = CMS_LOAD_LUTNL_DATA;
            }
         }
         else
         {
            cmCurrentState = CMS_LOAD_LUTRQ_DATA_HEADER;
         }
         break;

      case CMS_LOAD_LUTNL_DATA:
         length = MIN(FM_TEMP_FILE_DATA_BUFFER_SIZE, dataLength - dataOffset);

         byteCount = FM_ReadFileToTmpFileDataBuffer(fdCalib, length);
         if (byteCount != length)
         {
            CM_ERR("Failed to read LUTNL data.");
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            // Copy LUTNL data into RAM block
            p_uint32 = (uint32_t *)tmpFileDataBuffer;

            for (i = 0; i < (length / sizeof(uint32_t)); i++)
            {
               AXI4L_write32(p_uint32[i], (XPAR_NLC_LUT_AXI_BASEADDR + (lutNLCount * NLC_LUT_PAGE_SIZE) + (dataOffset / sizeof(uint32_t)) + i));
            }

            // Compute CRC-16 value
            crc16 = CRC16(crc16, tmpFileDataBuffer, length);

            dataOffset += length;
            if (dataOffset == dataLength)
            {
               lutNLCount++;
               if (lutNLCount < calibrationInfo.blocks[blockIndex].lutNLData.NumberOfLUTNL)
               {
                  cmCurrentState = CMS_LOAD_LUTNL_DATA;
                  dataOffset = 0;
               }
               else
               {
                  // Test LUTNL data CRC-16 for all LUTNL
                  if (crc16 != dataCRC16)
                  {
                     CM_ERR("LUTNL data CRC-16 mismatch (computed:0x%04X, file:0x%04X).", crc16, dataCRC16);
                     cmCurrentState = CMS_ERROR;
                  }
                  else
                  {
                     CM_INF("LUTNL data loaded.");

                     cmCurrentState = CMS_LOAD_LUTRQ_DATA_HEADER;
                     lutNLCount = 0;   // Reset for next block
                  }
               }
            }
         }
         break;

      case CMS_LOAD_LUTRQ_DATA_HEADER:
         if (calibrationInfo.blocks[blockIndex].LUTRQDataPresence == 1)
         {
            byteCount = CalibBlock_ParseLUTRQDataHeader(fdCalib, &fileInfo, &headerData.lutRQData);
            if (byteCount == 0)
            {
               CM_ERR("Failed to parse LUTRQ data header.");
               cmCurrentState = CMS_ERROR;
            }
            else
            {
               switch (headerData.lutRQData.RadiometricQuantityType)
               {
                  case RQT_RT:
                     lutRQIndex = LUTRQI_RT;
                     break;

                  case RQT_IBR:
                     lutRQIndex = LUTRQI_IBR;
                     break;

                  case RQT_IBI:
                     lutRQIndex = LUTRQI_IBI;
                     break;
               }

               if (calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].isValid)
               {
                  CM_ERR("Calibration block cannot have more than one LUTRQ of the same radiometric quantity type (RQT=%d).",
                        headerData.lutRQData.RadiometricQuantityType);
                  cmCurrentState = CMS_ERROR;
               }
               else
               {
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].LUT_Xmin = headerData.lutRQData.LUT_Xmin;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].LUT_Xrange = headerData.lutRQData.LUT_Xrange;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].LUT_Size = headerData.lutRQData.LUT_Size;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].M_Exp = headerData.lutRQData.M_Exp;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].B_Exp = headerData.lutRQData.B_Exp;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].Data_Off = headerData.lutRQData.Data_Off;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].Data_Exp = headerData.lutRQData.Data_Exp;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].RadiometricQuantityType = headerData.lutRQData.RadiometricQuantityType;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].M_Nbits = headerData.lutRQData.M_Nbits;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].B_Nbits = headerData.lutRQData.B_Nbits;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].M_Signed = headerData.lutRQData.M_Signed;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].B_Signed = headerData.lutRQData.B_Signed;

                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataOffset = uffs_tell(fdCalib);
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataLength = headerData.lutRQData.LUTRQDataLength;
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataCRC16 = headerData.lutRQData.LUTRQDataCRC16;
                  dataOffset = 0;
                  crc16 = 0xFFFF;

                  CM_INF("LUTRQ data header loaded.");
                  cmCurrentState = CMS_LOAD_LUTRQ_DATA;
               }
            }
         }
         else
         {
            cmCurrentState = CMS_FINALIZE_BLOCK_FILE;
         }
         break;

      case CMS_LOAD_LUTRQ_DATA:
         length = MIN(FM_TEMP_FILE_DATA_BUFFER_SIZE, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataLength - dataOffset);

         byteCount = FM_ReadFileToTmpFileDataBuffer(fdCalib, length);
         if (byteCount != length)
         {
            CM_ERR("Failed to read LUTRQ data.");
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            // Compute CRC-16 value
            crc16 = CRC16(crc16, tmpFileDataBuffer, length);

            dataOffset += length;
            if (dataOffset == calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataLength)
            {
               // Test LUTRQ data CRC-16
               if (crc16 != calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataCRC16)
               {
                  CM_ERR("LUTRQ data CRC-16 mismatch (computed:0x%04X, file:0x%04X).",
                        crc16, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataCRC16);
                  cmCurrentState = CMS_ERROR;
               }
               else
               {
                  calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].isValid = 1;

                  CM_INF("LUTRQ data validated (LUTidx=%d, RQT=%d).", lutRQCount, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].RadiometricQuantityType);

                  lutRQCount++;
                  if (lutRQCount < calibrationInfo.blocks[blockIndex].NumberOfLUTRQ)
                  {
                     cmCurrentState = CMS_LOAD_LUTRQ_DATA_HEADER;
                  }
                  else
                  {
                     cmCurrentState = CMS_FINALIZE_BLOCK_FILE;
                     lutRQCount = 0;   // Reset for next block
                  }
               }
            }
         }
         break;

      case CMS_FINALIZE_BLOCK_FILE:
         // Close calibration block file
         retval = uffs_close(fdCalib);
         if (retval == -1)
         {
            CM_ERR("Failed to close calibration block file.");
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            calibrationInfo.blocks[blockIndex].isValid = 1;

            CM_INF("Calibration block has been successfully loaded (%dms).", elapsed_time_us(tic_block) / 1000);

            fdCalib = -1;
            blockIndex++;
            if (blockIndex < calibrationInfo.collection.NumberOfBlocks)
            {
               cmCurrentState = CMS_OPEN_BLOCK_FILE;
            }
            else
            {
               cmCurrentState = CMS_FINALIZE_COLLECTION_FILE;
            }
         }
         break;

      case CMS_FINALIZE_COLLECTION_FILE:
         calibrationInfo.collection.DeviceTemperatureSensor /= calibrationInfo.collection.NumberOfBlocks;
         calibrationInfo.isValid = 1;
         builtInTests[BITID_CalibrationFilesLoading].result = BITR_Passed;

         TDCStatusClr(WaitingForCalibrationInitMask | WaitingForCalibrationDataMask);

         // Update AvailabilityFlags register
         AvailabilityFlagsSet(CalibrationIsAvailableMask | Raw0IsAvailableMask | RawIsAvailableMask |
               NUCIsAvailableMask | RTIsAvailableMask | IBRIsAvailableMask | IBIIsAvailableMask);

         if (gGC_ProprietaryFeatureKeyIsValid == 0)
         {
            AvailabilityFlagsClr(Raw0IsAvailableMask);
         }

         // Disable calibration mode if not all of the block have a corresponding LUTRQ data
         for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
         {
            if (!calibrationInfo.blocks[blockIndex].lutRQData[LUTRQI_RT].isValid)
            {
               AvailabilityFlagsClr(RTIsAvailableMask);
            }

            if (!calibrationInfo.blocks[blockIndex].lutRQData[LUTRQI_IBR].isValid)
            {
               AvailabilityFlagsClr(IBRIsAvailableMask);
            }

            if (!calibrationInfo.blocks[blockIndex].lutRQData[LUTRQI_IBI].isValid)
            {
               AvailabilityFlagsClr(IBIIsAvailableMask);
            }
         }

         // Update CalibrationMode register
         if (!once) {
            gcRegsData.CalibrationMode = CalibrationMode_backup;
            once = true;
         }

         if ((gcRegsData.CalibrationMode == CM_Raw0) && (gGC_ProprietaryFeatureKeyIsValid == 0))
         {
            GC_SetCalibrationMode(CM_RT);
         }

         if (((gcRegsData.CalibrationMode == CM_RT) && (!AvailabilityFlagsTst(RTIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_IBR) && (!AvailabilityFlagsTst(IBRIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_IBI) && (!AvailabilityFlagsTst(IBIIsAvailableMask))))
         {
            GC_SetCalibrationMode(CM_NUC);
         }

         if ((Calibration_ValidateCollectionType() != IRC_SUCCESS) ||
               (CAL_WriteBlockParam(&gCal, &gcRegsData) != IRC_SUCCESS) ||
               (Calibration_LoadLUTRQ(1) != IRC_SUCCESS))
         {
            cmCurrentState = CMS_ERROR;
         }
         else
         {
            gcRegsData.IntegrationMode = calibrationInfo.collection.IntegrationMode;
            gcRegsData.SensorWellDepth = calibrationInfo.collection.SensorWellDepth;
            gcRegsData.PixelDataResolution = calibrationInfo.collection.PixelDataResolution;
            // GC_SetWidth(calibrationInfo.collection.Width);
            // GC_SetHeight(calibrationInfo.collection.Height);
            // GC_SetOffsetX(calibrationInfo.collection.OffsetX);
            // GC_SetOffsetY(calibrationInfo.collection.OffsetY);
            GC_SetReverseX(flashSettings.ReverseX ^ calibrationInfo.collection.ReverseX);
            GC_SetReverseY(flashSettings.ReverseY ^ calibrationInfo.collection.ReverseY);

            // Update active calibration collection registers
            gcRegsData.CalibrationCollectionActivePOSIXTime = calibrationInfo.collection.POSIXTime;
            gcRegsData.CalibrationCollectionActiveType = calibrationInfo.collection.CollectionType;

            // Update default actualization modes
            if (calibrationInfo.collection.CollectionType == CCT_MultipointEHDRI)
               gcRegsData.ImageCorrectionBlockSelector = ICBS_AllBlocks;   //No active block with this collection type

            if ((calibrationInfo.collection.CollectionType != CCT_TelopsFW) && (calibrationInfo.collection.CollectionType != CCT_MultipointFW))
               gcRegsData.ImageCorrectionFWMode = ICFWM_Fixed;   //Only mode available with these collection types

            // Update NDF position availability
            if (flashSettings.NDFPresent == 1)
            {
               for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
               {
                  switch (calibrationInfo.blocks[blockIndex].NDFPosition)
                  {
                     case NDFP_NDFilter1:
                        AvailabilityFlagsSet(NDFilter1IsAvailableMask);
                        break;

                     case NDFP_NDFilter2:
                        AvailabilityFlagsSet(NDFilter2IsAvailableMask);
                        break;

                     case NDFP_NDFilter3:
                        AvailabilityFlagsSet(NDFilter3IsAvailableMask);
                        break;
                  }
               }
            }

            blockIndex = 0;

            if (startup)
            {
               uint8_t LowerNDFIndex = 0;

               for (blockIndex = calibrationInfo.collection.NumberOfBlocks - 1; blockIndex > 0 ; blockIndex--)
               {
                  if (calibrationInfo.collection.CollectionType == CCT_TelopsNDF)
                  {
                     if (calibrationInfo.blocks[blockIndex].NDFPosition < calibrationInfo.blocks[LowerNDFIndex].NDFPosition)
                     {
                        LowerNDFIndex = blockIndex;
                     }
                  }
                  else
                  {
                     if (calibrationInfo.blocks[blockIndex].POSIXTime == gFlashDynamicValues.CalibrationCollectionBlockPOSIXTimeAtStartup)
                     {
                        break;
                     }
                  }
               }

               gcRegsData.CalibrationCollectionBlockSelector = ((calibrationInfo.collection.CollectionType == CCT_TelopsNDF) ? LowerNDFIndex : blockIndex);
               blockLoadCmdFlag = true;

               startup = 0;
            }

            // allows the actualisation process to load the right block when it requests the reloading of a collection
            if (gActualisationLoadBlockIdx > -1)
            {
               gcRegsData.CalibrationCollectionBlockSelector = gActualisationLoadBlockIdx;
               blockLoadCmdFlag = true;
               gActualisationLoadBlockIdx = -1;
            }

            if (flashSettings.FWPresent == 1)
            {
               GC_SetFWPositionSetpoint(calibrationInfo.blocks[blockIndex].FWPosition);
            }

            if (flashSettings.NDFPresent == 1)
            {
               GC_SetNDFilterPositionSetpoint(calibrationInfo.blocks[blockIndex].NDFPosition);

               // Update AEC+ parameters coming from blocks and collection
               AEC_UpdateAECPlusParameters();
            }

            if (TDCFlagsTst(MotorizedFOVLensIsImplementedMask) &&
                  ((calibrationInfo.collection.CollectionType == CCT_TelopsFOV) || (calibrationInfo.collection.CollectionType == CCT_MultipointFOV)))
            {
               gcRegsData.CalibrationCollectionBlockSelector = blockIndex;
               blockLoadCmdFlag = true;
            }

            // Update registers related to calibration control
            GC_UpdateCalibrationRegisters();
            GC_UpdateParameterLimits();
            CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);
            GC_UpdateAECPlusIsAvailable();

            if (cmCalibrationFile->type == FT_TSCO)
            {
               CM_INF("Calibration collection has been successfully loaded (%dms).", elapsed_time_us(tic_collection) / 1000);
            }

            // Save calibration collection POSIX time
            if (gFlashDynamicValues.CalibrationCollectionPOSIXTimeAtStartup != calibrationInfo.collection.POSIXTime)
            {
               gFlashDynamicValues.CalibrationCollectionPOSIXTimeAtStartup = calibrationInfo.collection.POSIXTime;
               if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
               {
                  CM_ERR("Failed to update flash dynamic values.");
               }
            }

            cmCalibrationFile = NULL;

            cmCurrentState = CMS_IDLE;
         }
         break;

      case CMS_ERROR:
         if (fdCalib != -1)
         {
            retval = uffs_close(fdCalib);
            if (retval == -1)
            {
               CM_ERR("Failed to close calibration file.");
            }
         }

         Calibration_Reset();

         cmCalibrationFile = NULL;

         TDCStatusClr(WaitingForCalibrationDataMask);

         builtInTests[BITID_CalibrationFilesLoading].result = BITR_Failed;

         startup = 0;
         cmCurrentState = CMS_IDLE;
         break;
   }
}

/**
 * Initialize calibration data and availability flags.
 */
static void Calibration_Init()
{
   memset(&calibrationInfo, 0, sizeof(calibrationInfo_t));
   TDCStatusSet(WaitingForCalibrationInitMask);

   // Update AvailabilityFlags register
   AvailabilityFlagsClr(CalibrationIsAvailableMask | Raw0IsAvailableMask | RawIsAvailableMask |
         NUCIsAvailableMask | RTIsAvailableMask | IBRIsAvailableMask | IBIIsAvailableMask |
         NDFilter1IsAvailableMask | NDFilter2IsAvailableMask | NDFilter3IsAvailableMask);

   // Update active calibration collection registers
   gcRegsData.CalibrationCollectionActivePOSIXTime = 0;
   gcRegsData.CalibrationCollectionActiveType = CCAT_TelopsFixed;
   gcRegsData.CalibrationCollectionActiveBlockPOSIXTime = 0;

   // Update registers related to calibration control
   GC_UpdateParameterLimits();
   CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);

   // default LUT switch is configure to read from FPGA
   CAL_ConfigureNlcLutSwitch(&gCal, LUT_SWITCH_TO_FPGA);
   CAL_ConfigureRqcLutSwitch(&gCal, LUT_SWITCH_TO_FPGA);
}

/**
 * Reset camera calibration.
 */
void Calibration_Reset()
{
   Calibration_Init();

   AvailabilityFlagsSet(Raw0IsAvailableMask);

   // Update CalibrationMode register
   CalibrationMode_backup = gcRegsData.CalibrationMode;
   GC_SetCalibrationMode(CM_Raw0);

   // Show Raw0 only in Telops mode
   if (gGC_ProprietaryFeatureKeyIsValid)
   {
      AvailabilityFlagsSet(CalibrationIsAvailableMask);
   }

   // Update AECPlusIsAvailable flag
   GC_UpdateAECPlusIsAvailable();
}

/**
 * Validate parameters related to CollectionType.
 *
 * @return IRC_SUCCESS if CollectionType is valid.
 * @return IRC_FAILURE if CollectionType is invalid.
 */
static IRC_Status_t Calibration_ValidateCollectionType()
{
   uint32_t block_index;
   uint32_t block_index_2;

   switch (calibrationInfo.collection.CollectionType)
   {
      case CCT_MultipointFixed:
      case CCT_TelopsFixed:
         break;

      case CCT_MultipointFW:
      case CCT_TelopsFW:
         // Validate number of blocks
         if (calibrationInfo.collection.NumberOfBlocks != flashSettings.FWNumberOfFilters)
         {
            CM_ERR("FW collection block count mismatch (%d Block(s), %d Filter(s)).",
                  calibrationInfo.collection.NumberOfBlocks, flashSettings.FWNumberOfFilters);
            return IRC_FAILURE;
         }
         // All FWPosition must be different
         for (block_index = 1; block_index < calibrationInfo.collection.NumberOfBlocks; block_index++)
         {
            for (block_index_2 = 0; block_index_2 < block_index; block_index_2++)
            {
               if (calibrationInfo.blocks[block_index_2].FWPosition == calibrationInfo.blocks[block_index].FWPosition)
               {
                  CM_ERR("More than one block for FW position %d in FW collection (Block indices: %d, %d).",
                        calibrationInfo.blocks[block_index].FWPosition, block_index, block_index_2);
                  return IRC_FAILURE;
               }
            }
         }
         break;

      case CCT_MultipointNDF:
         // Validate number of blocks
         if (calibrationInfo.collection.NumberOfBlocks < 2)
         {
            CM_ERR("Invalid NDF collection block count (%d Block(s)).",
                  calibrationInfo.collection.NumberOfBlocks);
            return IRC_FAILURE;
         }
         // All (NDFPosition, ExposureTime) pairs must be different
         for (block_index = 1; block_index < calibrationInfo.collection.NumberOfBlocks; block_index++)
         {
            for (block_index_2 = 0; block_index_2 < block_index; block_index_2++)
            {
               if ((calibrationInfo.blocks[block_index_2].NDFPosition == calibrationInfo.blocks[block_index].NDFPosition) &&
                   (calibrationInfo.blocks[block_index_2].ExposureTime == calibrationInfo.blocks[block_index].ExposureTime))
               {
                  CM_ERR("More than one block for NDF position %d and exposure time %d in NDF collection (Block indices: %d, %d).",
                        calibrationInfo.blocks[block_index].NDFPosition, calibrationInfo.blocks[block_index].ExposureTime,
                        block_index, block_index_2);
                  return IRC_FAILURE;
               }
            }
         }
         break;

      case CCT_TelopsNDF:
         // Validate number of blocks
         if ((calibrationInfo.collection.NumberOfBlocks < 2) || (calibrationInfo.collection.NumberOfBlocks > flashSettings.NDFNumberOfFilters))
         {
            CM_ERR("Invalid NDF collection block count (%d Block(s), %d Filter(s)).",
                  calibrationInfo.collection.NumberOfBlocks, flashSettings.NDFNumberOfFilters);
            return IRC_FAILURE;
         }
         // All NDFPosition must be different
         for (block_index = 1; block_index < calibrationInfo.collection.NumberOfBlocks; block_index++)
         {
            for (block_index_2 = 0; block_index_2 < block_index; block_index_2++)
            {
               if (calibrationInfo.blocks[block_index_2].NDFPosition == calibrationInfo.blocks[block_index].NDFPosition)
               {
                  CM_ERR("More than one block for NDF position %d in NDF collection (Block indices: %d, %d).",
                        calibrationInfo.blocks[block_index].NDFPosition, block_index, block_index_2);
                  return IRC_FAILURE;
               }
            }
         }
         break;

      case CCT_MultipointFOV:
      case CCT_TelopsFOV:
         // Validate number of blocks
         if (calibrationInfo.collection.NumberOfBlocks != flashSettings.FOVNumberOfPositions)
         {
            CM_ERR("Invalid FOV collection block count (%d Block(s), %d FOV(s)).",
                  calibrationInfo.collection.NumberOfBlocks, flashSettings.FOVNumberOfPositions);
            return IRC_FAILURE;
         }
         // All FOVPosition must be different
         for (block_index = 1; block_index < calibrationInfo.collection.NumberOfBlocks; block_index++)
         {
            for (block_index_2 = 0; block_index_2 < block_index; block_index_2++)
            {
               if (calibrationInfo.blocks[block_index_2].FOVPosition == calibrationInfo.blocks[block_index].FOVPosition)
               {
                  CM_ERR("More than one block for FOV position %d in FOV collection (Block indices: %d, %d).",
                        calibrationInfo.blocks[block_index].FOVPosition, block_index, block_index_2);
                  return IRC_FAILURE;
               }
            }
         }
         break;

      case CCT_MultipointEHDRI:
         // Validate number of blocks
         if ((calibrationInfo.collection.NumberOfBlocks < 2) || (calibrationInfo.collection.NumberOfBlocks > EHDRI_IDX_NBR))
         {
            CM_ERR("Invalid EHDRI collection block count (%d Block(s)).",
                  calibrationInfo.collection.NumberOfBlocks);
            return IRC_FAILURE;
         }
         // All ExposureTime must be different
         for (block_index = 1; block_index < calibrationInfo.collection.NumberOfBlocks; block_index++)
         {
            for (block_index_2 = 0; block_index_2 < block_index; block_index_2++)
            {
               if (calibrationInfo.blocks[block_index_2].ExposureTime == calibrationInfo.blocks[block_index].ExposureTime)
               {
                  CM_ERR("More than one block for exposure time %d in EHDRI collection (Block indices: %d, %d).",
                        calibrationInfo.blocks[block_index].ExposureTime, block_index, block_index_2);
                  return IRC_FAILURE;
               }
            }
         }
         break;
   }

   return IRC_SUCCESS;
}

/**
 * Load LUTRQ data from each calibration blocks according to Calibration mode register value.
 *
 * @param initLUTRQ indicates if LUTRQ initialization is needed.
 *
 * @return IRC_SUCCESS if successfully loaded LUTRQ data.
 * @return IRC_FAILURE if failed to load LUTRQ data.
 */
IRC_Status_t Calibration_LoadLUTRQ(uint8_t initLUTRQ)
{
   uint32_t blockIndex;
   uint32_t lutRQIndex = LUTRQI_RT;
   uint32_t waitingForCalibrationDataState;

   switch (gcRegsData.CalibrationMode)
   {
      case CM_RT:
         lutRQIndex = LUTRQI_RT;
         break;

      case CM_IBR:
         lutRQIndex = LUTRQI_IBR;
         break;

      case CM_IBI:
         lutRQIndex = LUTRQI_IBI;
         break;

      case CM_Raw0:
      case CM_Raw:
      case CM_NUC:
      default:
         if (initLUTRQ == 0)
         {
            return IRC_SUCCESS;
         }

         if (AvailabilityFlagsTst(RTIsAvailableMask))
         {
            lutRQIndex = LUTRQI_RT;
         }
         else if (AvailabilityFlagsTst(IBRIsAvailableMask))
         {
            lutRQIndex = LUTRQI_IBR;
         }
         else if (AvailabilityFlagsTst(IBRIsAvailableMask))
         {
            lutRQIndex = LUTRQI_IBI;
         }
         else
         {
            CM_ERR("No LUTRQ data is available.");
            return IRC_FAILURE;
         }
   }


   // Ensure WaitingForCalibrationData flag is raised
   waitingForCalibrationDataState = TDCStatusTst(WaitingForCalibrationDataMask);
   TDCStatusSet(WaitingForCalibrationDataMask);

   for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
   {
      if (Calibration_LoadBlockLUTRQ(blockIndex, lutRQIndex) != IRC_SUCCESS)
      {
         CM_ERR("Failed to load LUTRQ data (BlockIdx=%d, LUTidx=%d, RQT=%d).",
               blockIndex, lutRQIndex,
               calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].RadiometricQuantityType);
         return IRC_FAILURE;
      }
   }

   // Clear WaitingForCalibrationData flag if needed
   if (!waitingForCalibrationDataState)
   {
      TDCStatusClr(WaitingForCalibrationDataMask);
   }

   return IRC_SUCCESS;
}

/**
 * Load calibration block LUTRQ data.
 *
 * @param blockIndex is the index calibration block that contains the LUTRQ to load.
 * @param lutRQIndex is the index of the LUTRQ to load inside the specified calibration block.
 *
 * @return IRC_SUCCESS if successfully loaded LUTRQ data.
 * @return IRC_FAILURE if failed to load LUTRQ data.
 */
static IRC_Status_t Calibration_LoadBlockLUTRQ(uint32_t blockIndex, uint32_t lutRQIndex)
{
   int fdCalib;
   uint32_t dataOffset;
   uint32_t length;
   uint16_t crc16;
   int byteCount;
   int retval;
   uint64_t tic;

   if (!calibrationInfo.isValid)
   {
      CM_ERR("Calibration data is not valid.");
      return IRC_FAILURE;
   }

   if (blockIndex >= calibrationInfo.collection.NumberOfBlocks)
   {
      CM_ERR("Block index exceed the number of block in calibration data.");
      return IRC_FAILURE;
   }

   if (lutRQIndex >= LUTRQI_MAX_NUM_OF_LUTRQ)
   {
      CM_ERR("Radiometric LUT index exceed the maximum number of radiometric LUT.");
      return IRC_FAILURE;
   }

   CM_INF("Loading LUTRQ data (BlockIdx=%d, LUTidx=%d, RQT=%d)...",
         blockIndex, lutRQIndex, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].RadiometricQuantityType);

   GETTIME(&tic);

   if (!calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].isValid)
   {
      CM_ERR("LUTRQ is not valid.");
      return IRC_FAILURE;
   }

   // Open block file
   fdCalib = FM_OpenFile(calibrationInfo.blocks[blockIndex].file->name, UO_RDONLY);
   if (fdCalib == -1)
   {
      CM_ERR("Failed to open block file.");
      return IRC_FAILURE;
   }

   // Position block file cursor at the beginning of LUTRQ data
   uffs_seek(fdCalib, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataOffset, USEEK_SET);

   dataOffset = 0;
   crc16 = 0xFFFF;
   while (dataOffset < calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataLength)
   {
      length = MIN(FM_TEMP_FILE_DATA_BUFFER_SIZE, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataLength - dataOffset);

      // Read LUTRQ data
      byteCount = FM_ReadFileToTmpFileDataBuffer(fdCalib, length);
      if (byteCount != length)
      {
         CM_ERR("Failed to read LUTRQ data.");
         retval = uffs_close(fdCalib);
         if (retval == -1)
         {
            CM_ERR("Failed to close calibration block file.");
         }
         return IRC_FAILURE;
      }

      // Compute CRC-16 value
      crc16 = CRC16(crc16, tmpFileDataBuffer, length);

      // Copy LUTRQ data into RAM block
      Calibration_CopyLUTRQData(tmpFileDataBuffer, length, dataOffset, blockIndex);

      dataOffset += length;
   }

   // Close block file
   retval = uffs_close(fdCalib);
   if (retval == -1)
   {
      CM_ERR("Failed to close calibration block file.");
      return IRC_FAILURE;
   }

   // Test LUTRQ data CRC-16
   if (crc16 != calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataCRC16)
   {
      CM_ERR("LUTRQ data CRC-16 mismatch (computed:0x%04X, file:0x%04X).",
            crc16, calibrationInfo.blocks[blockIndex].lutRQData[lutRQIndex].DataCRC16);
      return IRC_FAILURE;
   }

   CM_INF("LUTRQ data has been successfully loaded (%dms).", elapsed_time_us(tic) / 1000);

   return IRC_SUCCESS;
}

/**
 * Copy LUTRQ data in RAM block.
 *
 * @param buffer is the byte buffer containing LUTRQ data to copy in RAM block.
 * @param buflen is the size in bytes of the byte buffer containing LUTRQ.
 * @param offset is the byte offset where to copy LUTRQ data in RAM block.
 * @param lut_page is the index of the page where to copy LUTRQ data in RAM block.
 *
 * @return IRC_SUCCESS if successfully copied LUTRQ data.
 * @return IRC_FAILURE if failed to copy LUTRQ data.
 */
static IRC_Status_t Calibration_CopyLUTRQData(uint8_t *buffer, uint32_t buflen, uint32_t offset, uint8_t lut_page)
{
   uint32_t i;
   uint32_t *buffer32;
   uint32_t buflen32;
   uint32_t offset32;

   if (buffer == NULL)
   {
      return IRC_FAILURE;
   }

   if ((buflen % sizeof(uint32_t) != 0) || (offset % sizeof(uint32_t) != 0))
   {
      return IRC_FAILURE;
   }

   buffer32 = (uint32_t *)buffer;
   buflen32 = buflen / sizeof(uint32_t);
   offset32 = offset / sizeof(uint32_t);

   for (i = 0; i < buflen32; i++)
   {
      AXI4L_write32(buffer32[i], (XPAR_RQC_LUT_AXI_BASEADDR + (lut_page * RQC_LUT_PAGE_SIZE) + offset32 + i));
   }

   return IRC_SUCCESS;
}

/**
 * Indicate whether file is used by calibration actually loaded.
 *
 * @param file is a pointer to the file.
 *
 * @return 1 if file exists.
 * @return 0 if file does not exist.
 */
uint8_t CM_FileUsedByActualCalibration(fileRecord_t *file)
{
   uint32_t blockIndex;

   if (calibrationInfo.isValid)
   {
      if ((calibrationInfo.collection.isValid) && (calibrationInfo.collection.file == file))
      {
         return 1;
      }

      for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks; blockIndex++)
      {
         if ((calibrationInfo.blocks[blockIndex].isValid) && (calibrationInfo.blocks[blockIndex].file == file))
         {
            return 1;
         }
      }
   }
   return 0;
}

/**
 * Determine the active calibration block
 *
 * @param calibration info structure
 * @param block index found (0 if not found)
 *
 * @return true if block found.
 * @return false if block not found.
 */
bool Calibration_GetActiveBlockIdx(const calibrationInfo_t* calibInfo, uint8_t* blockIdx)
{
   uint8_t i = calibInfo->collection.NumberOfBlocks - 1;

   while (i >= 0)
   {
      if (calibInfo->blocks[i].POSIXTime == gcRegsData.CalibrationCollectionActiveBlockPOSIXTime)
      {
         *blockIdx = i;
         return true;
      }

      --i;
   }

   // return 0 if not found
   *blockIdx = 0;
   return false;
}

static void disableGPSInterrupts(void)
{
   extern t_GPS Gps_struct;
   XIntc_Disable(Gps_struct.uart.intc, Gps_struct.uart.uartIntrId);
}

static void enableGPSInterrupts(void)
{
   extern t_GPS Gps_struct;
   XIntc_Enable(Gps_struct.uart.intc, Gps_struct.uart.uartIntrId);
}
