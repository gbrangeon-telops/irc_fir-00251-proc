/**
 * @file CalibCollectionFile_v1.h
 * Camera calibration collection file structure v1 declaration.
 *
 * This file declares the camera calibration collection file structure v1.
 *
 * Auto-generated calibration collection file library.
 * Generated from the calibration collection file structure definition XLS file version 1.1.0
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

#ifndef CALIBCOLLECTIONFILE_V1_H
#define CALIBCOLLECTIONFILE_V1_H

#include <stdint.h>

#define CALIBCOLLECTION_FILEMAJORVERSION_V1      1
#define CALIBCOLLECTION_FILEMINORVERSION_V1      1
#define CALIBCOLLECTION_FILESUBMINORVERSION_V1   0

#define CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V1   512

/**
 * CollectionFileHeader data structure.
 */
struct CalibCollection_CollectionFileHeader_v1Struct {
   char FileSignature[5];   /**< Calibration collection file signature */
   uint8_t FileStructureMajorVersion;   /**< Calibration file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Calibration file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Calibration file structure SubMinor Version */
   uint32_t CollectionFileHeaderLength;   /**< Collection file header length */
   uint32_t DeviceSerialNumber;   /**< Unique Telops 32-bit device serial number */
   uint32_t POSIXTime;   /**< Collection file generation date and time. */
   char FileDescription[65];   /**< Calibration collection file description */
   uint8_t DeviceDataFlowMajorVersion;   /**< Major version of the calibration data flow of the camera */
   uint8_t DeviceDataFlowMinorVersion;   /**< Minor version of the calibration data flow of the camera */
   uint8_t SensorID;   /**< Sensor ID. */
   uint8_t CollectionType;   /**< Collection type */
   uint8_t CalibrationType;   /**< Calibration type */
   uint8_t IntegrationMode;   /**< Integration mode */
   uint8_t SensorWellDepth;   /**< Sensor well depth */
   uint8_t PixelDataResolution;   /**< Effective size in bits of a pixel of the image */
   uint16_t Width;   /**< Width of the image provided by the device in pixels */
   uint16_t Height;   /**< Height of the image provided by the device in pixels */
   uint16_t OffsetX;   /**< Horizontal offset from the origin to the region of interest in pixels */
   uint16_t OffsetY;   /**< Vertical offset from the origin to the region of interest in pixels */
   uint8_t ReverseX;   /**< Indicates whether the image is horizontally flipped */
   uint8_t ReverseY;   /**< Indicates whether the image is vertically flipped */
   uint8_t FWPosition;   /**< Filter wheel position */
   uint8_t NDFPosition;   /**< Neutral density filter position */
   uint32_t ExternalLensSerialNumber;   /**< Unique Telops 32-bit external lens serial number */
   char ExternalLensName[65];   /**< External Lens Name */
   uint32_t ManualFilterSerialNumber;   /**< Unique Telops 32-bit manual filter serial number */
   char ManualFilterName[65];   /**< Manual filter name */
   uint32_t ReferencePOSIXTime;   /**< Camera reference file generation date and time */
   float FluxRatio01;   /**< Ratio de flux entre NDF0 et NDF1 */
   float FluxRatio12;   /**< Ratio de flux entre NDF1 et NDF2 */
   uint32_t CollectionFileDataLength;   /**< Collection file data length */
   uint8_t NumberOfBlocks;   /**< Number of calibration blocks in collection file */
   uint16_t CollectionFileDataCRC16;   /**< Collection file data CRC-16 */
   uint16_t CollectionFileHeaderCRC16;   /**< Collection file header CRC-16 */
};

/**
 * CollectionFileHeader data type.
 */
typedef struct CalibCollection_CollectionFileHeader_v1Struct CalibCollection_CollectionFileHeader_v1_t;

uint32_t CalibCollection_ParseCollectionFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibCollection_CollectionFileHeader_v1_t *hdr);
uint32_t CalibCollection_WriteCollectionFileHeader_v1(CalibCollection_CollectionFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);

#endif // CALIBCOLLECTIONFILE_V1_H