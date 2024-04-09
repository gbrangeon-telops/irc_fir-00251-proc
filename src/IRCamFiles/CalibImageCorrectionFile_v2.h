/**
 * @file CalibImageCorrectionFile_v2.h
 * Camera image correction calibration file structure v2 declaration.
 *
 * This file declares the camera image correction calibration file structure v2.
 *
 * Auto-generated image correction calibration file library.
 * Generated from the image correction calibration file structure definition XLS file version 2.6.0
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

#ifndef CALIBIMAGECORRECTIONFILE_V2_H
#define CALIBIMAGECORRECTIONFILE_V2_H

#include <stdint.h>

#define CALIBIMAGECORRECTION_FILEMAJORVERSION_V2      2
#define CALIBIMAGECORRECTION_FILEMINORVERSION_V2      6
#define CALIBIMAGECORRECTION_FILESUBMINORVERSION_V2   0

#define CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2   512

#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2   256
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE_V2   2
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK_V2    (uint16_t)(0x07FF)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SHIFT_V2   0
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS_V2 (1 << 10)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_MASK_V2    (uint16_t)(0x0800)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT_V2   11
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NOISYBADPIXEL_MASK_V2    (uint16_t)(0x1000)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NOISYBADPIXEL_SHIFT_V2   12
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_FLICKERBADPIXEL_MASK_V2    (uint16_t)(0x2000)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_FLICKERBADPIXEL_SHIFT_V2   13
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_OUTLIERBADPIXEL_MASK_V2    (uint16_t)(0x4000)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_OUTLIERBADPIXEL_SHIFT_V2   14

/**
 * ImageCorrectionFileHeader data structure.
 */
struct CalibImageCorrection_ImageCorrectionFileHeader_v2Struct {
   char FileSignature[5];   /**< File signature */
   uint8_t FileStructureMajorVersion;   /**< File structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< File structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< File structure SubMinor Version */
   uint32_t FileHeaderLength;   /**< File header length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t POSIXTime;   /**< File generation date and time */
   char FileDescription[65];   /**< File description */
   uint8_t DeviceDataFlowMajorVersion;   /**< Major version of the calibration data flow of the camera */
   uint8_t DeviceDataFlowMinorVersion;   /**< Minor version of the calibration data flow of the camera */
   uint8_t SensorID;   /**< Sensor ID */
   uint8_t ImageCorrectionType;   /**< Type of image correction performed */
   uint16_t Width;   /**< Width of the image provided by the device in pixels */
   uint16_t Height;   /**< Height of the image provided by the device in pixels */
   uint16_t OffsetX;   /**< Horizontal offset from the origin to the region of interest in pixels */
   uint16_t OffsetY;   /**< Vertical offset from the origin to the region of interest in pixels */
   uint32_t ReferencePOSIXTime;   /**< Camera reference file generation date and time */
   float TemperatureInternalLens;   /**< Temperature of internal lense at time of image correction */
   float TemperatureReference;   /**< Temperature of the reference surface */
   float ExposureTime;   /**< Exposure time used for image correction acquisition */
   uint32_t AcquisitionFrameRate;   /**< Acquisition rate (in millihertz) */
   uint8_t BinningMode;   /**< In binning mode, pixels are joined into a single large pixel */
   uint8_t SensorIDMSB;   /**< Sensor ID Most Significant Byte */
   uint8_t FWMode;   /**< Acquisition mode of the filter wheel */
   int32_t FocusPositionRaw;   /**< Motorized focus lens encoder position */
   uint16_t FileHeaderCRC16;   /**< File header CRC-16 */
};

/**
 * ImageCorrectionFileHeader data type.
 */
typedef struct CalibImageCorrection_ImageCorrectionFileHeader_v2Struct CalibImageCorrection_ImageCorrectionFileHeader_v2_t;

/**
 * ImageCorrectionDataHeader data structure.
 */
struct CalibImageCorrection_ImageCorrectionDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
   float Beta0_Off;   /**< Beta0 offset */
   float Beta0_Median;   /**< Beta0 median */
   int8_t Beta0_Exp;   /**< Beta0 exponent */
   uint8_t Beta0_Nbits;   /**< Beta0 data field bit width */
   uint8_t Beta0_Signed;   /**< Indicates whether the beta0 data field is signed */
   uint32_t ImageCorrectionDataLength;   /**< Image correction data length */
   uint16_t ImageCorrectionDataCRC16;   /**< Image correction data CRC-16 */
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * ImageCorrectionDataHeader data type.
 */
typedef struct CalibImageCorrection_ImageCorrectionDataHeader_v2Struct CalibImageCorrection_ImageCorrectionDataHeader_v2_t;

/**
 * ImageCorrectionData data structure.
 */
struct CalibImageCorrection_ImageCorrectionData_v2Struct {
   int16_t DeltaBeta;   /**< Difference between corrected and original beta values */
   uint8_t NewBadPixel;   /**< Indicate whether the pixel has been detected as bad (including original bad pixels from block) */
   uint8_t NoisyBadPixel;   /**< Bad pixel identified as noisy */
   uint8_t FlickerBadPixel;   /**< Bad pixel identified as flicker */
   uint8_t OutlierBadPixel;   /**< Bad pixel identified as outlier */
};

/**
 * ImageCorrectionData data type.
 */
typedef struct CalibImageCorrection_ImageCorrectionData_v2Struct CalibImageCorrection_ImageCorrectionData_v2_t;

uint32_t CalibImageCorrection_ParseImageCorrectionFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibImageCorrection_ImageCorrectionFileHeader_v2_t *hdr);
uint32_t CalibImageCorrection_WriteImageCorrectionFileHeader_v2(CalibImageCorrection_ImageCorrectionFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibImageCorrection_PrintImageCorrectionFileHeader_v2(CalibImageCorrection_ImageCorrectionFileHeader_v2_t *hdr);
uint32_t CalibImageCorrection_ParseImageCorrectionDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibImageCorrection_ImageCorrectionDataHeader_v2_t *hdr);
uint32_t CalibImageCorrection_WriteImageCorrectionDataHeader_v2(CalibImageCorrection_ImageCorrectionDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibImageCorrection_PrintImageCorrectionDataHeader_v2(CalibImageCorrection_ImageCorrectionDataHeader_v2_t *hdr);
uint32_t CalibImageCorrection_ParseImageCorrectionData_v2(uint8_t *buffer, uint32_t buflen, CalibImageCorrection_ImageCorrectionData_v2_t *data);
uint32_t CalibImageCorrection_WriteImageCorrectionData_v2(CalibImageCorrection_ImageCorrectionData_v2_t *data, uint8_t *buffer, uint32_t buflen);

#endif // CALIBIMAGECORRECTIONFILE_V2_H