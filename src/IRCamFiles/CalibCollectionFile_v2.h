/**
 * @file CalibCollectionFile_v2.h
 * Camera calibration collection file structure v2 declaration.
 *
 * This file declares the camera calibration collection file structure v2.
 *
 * Auto-generated calibration collection file library.
 * Generated from the calibration collection file structure definition XLS file version 2.3.0
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

#ifndef CALIBCOLLECTIONFILE_V2_H
#define CALIBCOLLECTIONFILE_V2_H

#include <stdint.h>

#define CALIBCOLLECTION_FILEMAJORVERSION_V2      2
#define CALIBCOLLECTION_FILEMINORVERSION_V2      3
#define CALIBCOLLECTION_FILESUBMINORVERSION_V2   0

#define CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2   512

/**
 * CollectionFileHeader data structure.
 */
struct CalibCollection_CollectionFileHeader_v2Struct {
   char FileSignature[5];   /**< File signature */
   uint8_t FileStructureMajorVersion;   /**< File structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< File structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< File structure SubMinor Version */
   uint32_t FileHeaderLength;   /**< File header length */
   uint32_t DeviceSerialNumber;   /**< Unique Telops 32-bit device serial number */
   uint32_t POSIXTime;   /**< Collection file generation date and time */
   char FileDescription[65];   /**< File description */
   uint8_t DeviceDataFlowMajorVersion;   /**< Major version of the calibration data flow of the camera */
   uint8_t DeviceDataFlowMinorVersion;   /**< Minor version of the calibration data flow of the camera */
   uint8_t SensorID;   /**< Sensor ID */
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
   uint8_t FOVPosition;   /**< Motorized FOV lens position */
   uint32_t ExtenderRingSerialNumber;   /**< Unique Telops 32-bit extender ring serial number */
   char ExtenderRingName[65];   /**< Extender ring name */
   int16_t Block1ImageShiftX;   /**< Block #1: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block1ImageShiftY;   /**< Block #1: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block1ImageRotation;   /**< Block #1: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block2ImageShiftX;   /**< Block #2: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block2ImageShiftY;   /**< Block #2: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block2ImageRotation;   /**< Block #2: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block3ImageShiftX;   /**< Block #3: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block3ImageShiftY;   /**< Block #3: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block3ImageRotation;   /**< Block #3: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block4ImageShiftX;   /**< Block #4: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block4ImageShiftY;   /**< Block #4: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block4ImageRotation;   /**< Block #4: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block5ImageShiftX;   /**< Block #5: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block5ImageShiftY;   /**< Block #5: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block5ImageRotation;   /**< Block #5: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block6ImageShiftX;   /**< Block #6: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block6ImageShiftY;   /**< Block #6: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block6ImageRotation;   /**< Block #6: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block7ImageShiftX;   /**< Block #7: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block7ImageShiftY;   /**< Block #7: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block7ImageRotation;   /**< Block #7: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   int16_t Block8ImageShiftX;   /**< Block #8: horizontal (X) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block8ImageShiftY;   /**< Block #8: vertical (Y) shift that must be applied to the unflipped image to ensure co-registration of the sequence */
   int16_t Block8ImageRotation;   /**< Block #8: clockwise rotation that must be applied to the unflipped image to ensure co-registration of the sequence* */
   uint32_t CollectionDataLength;   /**< Collection data length */
   uint8_t NumberOfBlocks;   /**< Number of calibration blocks in collection file */
   uint16_t CollectionDataCRC16;   /**< Collection data CRC-16 */
   uint16_t FileHeaderCRC16;   /**< File header CRC-16 */
};

/**
 * CollectionFileHeader data type.
 */
typedef struct CalibCollection_CollectionFileHeader_v2Struct CalibCollection_CollectionFileHeader_v2_t;

uint32_t CalibCollection_ParseCollectionFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibCollection_CollectionFileHeader_v2_t *hdr);
uint32_t CalibCollection_WriteCollectionFileHeader_v2(CalibCollection_CollectionFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibCollection_PrintCollectionFileHeader_v2(CalibCollection_CollectionFileHeader_v2_t *hdr);

#endif // CALIBCOLLECTIONFILE_V2_H