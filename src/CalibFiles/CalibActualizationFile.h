/**
 * @file CalibActualizationFile.h
 * Camera calibration actualization file structure declaration.
 *
 * This file declares the camera calibration actualization file structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef CALIBACTUALIZATIONFILE_H
#define CALIBACTUALIZATIONFILE_H

#include "IRC_Status.h"
#include <stdint.h>

/* AUTO-CODE BEGIN */
// Auto-generated Calibration Actualization File library.
// Generated from the calibration actualization file structure definition XLS file version 1.1.0
// using generateIRCamActualizationCalibrationFileCLib.m Matlab script.

#define CALIB_ACTUALIZATIONFILEMAJORVERSION      1
#define CALIB_ACTUALIZATIONFILEMINORVERSION      1
#define CALIB_ACTUALIZATIONFILESUBMINORVERSION   0

#define CALIB_ACTUALIZATIONFILEHEADER_SIZE   512
#define CALIB_ACTUALIZATIONDATAHEADER_SIZE   256
#define CALIB_ACTUALIZATIONDATA_SIZE   2
#define CALIB_ACTUALIZATIONDATA_DELTABETA_MASK    (uint16_t)(0x07FF)
#define CALIB_ACTUALIZATIONDATA_DELTABETA_SHIFT   0
#define CALIB_ACTUALIZATIONDATA_DELTABETA_SIGNPOS (1 << 10)
#define CALIB_ACTUALIZATIONDATA_NEWBADPIXEL_MASK    (uint16_t)(0x0800)
#define CALIB_ACTUALIZATIONDATA_NEWBADPIXEL_SHIFT   11

/**
 * ActualizationFileHeader data structure.
 */
struct ActualizationFileHeaderStruct {
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
typedef struct ActualizationFileHeaderStruct ActualizationFileHeader_t;

/**
 * ActualizationDataHeader data structure.
 */
struct ActualizationDataHeaderStruct {
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
typedef struct ActualizationDataHeaderStruct ActualizationDataHeader_t;

/**
 * ActualizationData data structure.
 */
struct ActualizationDataStruct {
   int16_t DeltaBeta;   /**< Difference between corrected and original beta values. */
   uint8_t NewBadPixel;   /**< Indicate whether the pixel has been detected as bad when it was originally good. */
};

/**
 * ActualizationData data type.
 */
typedef struct ActualizationDataStruct ActualizationData_t;

uint32_t ParseCalibActualizationFileHeader(uint8_t *buffer, uint32_t buflen, ActualizationFileHeader_t *hdr);
uint32_t WriteCalibActualizationFileHeader(ActualizationFileHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibActualizationDataHeader(uint8_t *buffer, uint32_t buflen, ActualizationDataHeader_t *hdr);
uint32_t WriteCalibActualizationDataHeader(ActualizationDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibActualizationData(uint8_t *buffer, uint32_t buflen, ActualizationData_t *data);
uint32_t WriteCalibActualizationData(ActualizationData_t *data, uint8_t *buffer, uint32_t buflen);

/* AUTO-CODE END */

#endif // CALIBACTUALIZATIONFILE_H
