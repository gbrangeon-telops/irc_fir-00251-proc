/**
 * @file CalibActualizationFile_v1.h
 * Camera actualization calibration file structure v1 declaration.
 *
 * This file declares the camera actualization calibration file structure v1.
 *
 * Auto-generated actualization calibration file library.
 * Generated from the actualization calibration file structure definition XLS file version 1.1.0
 * using generateIRCamFileCLib.m Matlab script.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (mer., 06 juil. 2016) $
 * $Id: CalibActualizationFile_v1.h 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/CalibActualizationFile_v1.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef CALIBACTUALIZATIONFILE_V1_H
#define CALIBACTUALIZATIONFILE_V1_H

#include <stdint.h>

#define CALIBACTUALIZATION_FILEMAJORVERSION_V1      1
#define CALIBACTUALIZATION_FILEMINORVERSION_V1      1
#define CALIBACTUALIZATION_FILESUBMINORVERSION_V1   0

#define CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1   512

#define CALIBACTUALIZATION_ACTUALIZATIONDATAHEADER_SIZE_V1   256
#define CALIBACTUALIZATION_ACTUALIZATIONDATA_SIZE_V1   2
#define CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_MASK_V1    (uint16_t)(0x07FF)
#define CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_SHIFT_V1   0
#define CALIBACTUALIZATION_ACTUALIZATIONDATA_DELTABETA_SIGNPOS_V1 (1 << 10)
#define CALIBACTUALIZATION_ACTUALIZATIONDATA_NEWBADPIXEL_MASK_V1    (uint16_t)(0x0800)
#define CALIBACTUALIZATION_ACTUALIZATIONDATA_NEWBADPIXEL_SHIFT_V1   11

/**
 * ActualizationFileHeader data structure.
 */
struct CalibActualization_ActualizationFileHeader_v1Struct {
   char FileSignature[5];   /**< Calibration actualization file signature */
   uint8_t FileStructureMajorVersion;   /**< Calibration file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Calibration file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Calibration file structure SubMinor Version */
   uint32_t ActualizationFileHeaderLength;   /**< Actualization file header length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t POSIXTime;   /**< File generation date and time */
   char FileDescription[65];   /**< Actualization file description */
   uint8_t DeviceDataFlowMajorVersion;   /**< Major version of the calibration data flow of the camera */
   uint8_t DeviceDataFlowMinorVersion;   /**< Minor version of the calibration data flow of the camera */
   uint8_t SensorID;   /**< Sensor ID. */
   uint16_t Width;   /**< Width of the image provided by the device in pixels */
   uint16_t Height;   /**< Height of the image provided by the device in pixels */
   uint16_t OffsetX;   /**< Horizontal offset from the origin to the region of interest in pixels */
   uint16_t OffsetY;   /**< Vertical offset from the origin to the region of interest in pixels */
   uint32_t ReferencePOSIXTime;   /**< Camera reference (ICU) file generation date and time */
   uint16_t ActualizationFileHeaderCRC16;   /**< Actualization file header CRC-16 */
};

/**
 * ActualizationFileHeader data type.
 */
typedef struct CalibActualization_ActualizationFileHeader_v1Struct CalibActualization_ActualizationFileHeader_v1_t;

/**
 * ActualizationDataHeader data structure.
 */
struct CalibActualization_ActualizationDataHeader_v1Struct {
   uint32_t ActualizationDataHeaderLength;   /**< Actualization data header length */
   float Beta0_Off;   /**< Beta0 offset */
   float Beta0_Median;   /**< Beta0 median */
   int8_t Beta0_Exp;   /**< Beta0 exponent */
   uint8_t Beta0_Nbits;   /**< Beta0 data filed bit width */
   uint8_t Beta0_Signed;   /**< Indicates whether the beta0 data field is signed. */
   uint32_t ActualizationDataLength;   /**< Actualization data length */
   uint16_t ActualizationDataCRC16;   /**< Actualization data CRC-16 */
   uint16_t ActualizationDataHeaderCRC16;   /**< Actualization data header CRC-16 */
};

/**
 * ActualizationDataHeader data type.
 */
typedef struct CalibActualization_ActualizationDataHeader_v1Struct CalibActualization_ActualizationDataHeader_v1_t;

/**
 * ActualizationData data structure.
 */
struct CalibActualization_ActualizationData_v1Struct {
   int16_t DeltaBeta;   /**< Difference between corrected and original beta values. */
   uint8_t NewBadPixel;   /**< Indicate whether the pixel has been detected as bad when it was originally good. */
};

/**
 * ActualizationData data type.
 */
typedef struct CalibActualization_ActualizationData_v1Struct CalibActualization_ActualizationData_v1_t;

uint32_t CalibActualization_ParseActualizationFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibActualization_ActualizationFileHeader_v1_t *hdr);
uint32_t CalibActualization_WriteActualizationFileHeader_v1(CalibActualization_ActualizationFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibActualization_ParseActualizationDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibActualization_ActualizationDataHeader_v1_t *hdr);
uint32_t CalibActualization_WriteActualizationDataHeader_v1(CalibActualization_ActualizationDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibActualization_ParseActualizationData_v1(uint8_t *buffer, uint32_t buflen, CalibActualization_ActualizationData_v1_t *data);
uint32_t CalibActualization_WriteActualizationData_v1(CalibActualization_ActualizationData_v1_t *data, uint8_t *buffer, uint32_t buflen);

#endif // CALIBACTUALIZATIONFILE_V1_H