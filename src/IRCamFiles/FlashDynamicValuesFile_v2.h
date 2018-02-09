/**
 * @file FlashDynamicValuesFile_v2.h
 * Camera flash dynamic values file structure v2 declaration.
 *
 * This file declares the camera flash dynamic values file structure v2.
 *
 * Auto-generated flash dynamic values file library.
 * Generated from the flash dynamic values file structure definition XLS file version 2.2.0
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

#ifndef FLASHDYNAMICVALUESFILE_V2_H
#define FLASHDYNAMICVALUESFILE_V2_H

#include <stdint.h>

#define FLASHDYNAMICVALUES_FILEMAJORVERSION_V2      2
#define FLASHDYNAMICVALUES_FILEMINORVERSION_V2      2
#define FLASHDYNAMICVALUES_FILESUBMINORVERSION_V2   0

#define FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE_V2   512

/**
 * FlashDynamicValuesFileHeader data structure.
 */
struct FlashDynamicValues_FlashDynamicValuesFileHeader_v2Struct {
   char FileSignature[5];   /**< File signature. */
   uint8_t FileStructureMajorVersion;   /**< File structure Major Version. */
   uint8_t FileStructureMinorVersion;   /**< File structure Minor Version. */
   uint8_t FileStructureSubMinorVersion;   /**< File structure SubMinor Version. */
   uint32_t FileHeaderLength;   /**< File header length. */
   uint32_t DeviceSerialNumber;   /**< Unique Telops 32-bit device serial number. */
   uint32_t POSIXTime;   /**< Camera flash dynamic values file generation date and time. */
   uint32_t DevicePowerOnCycles;   /**< Number of times the device has been power cycled. It corresponds to the number of times the device passes from Off power state to Standby power state. */
   uint32_t DeviceCoolerPowerOnCycles;   /**< Number of times the device cooler has been power cycled. It corresponds to the number of times the device passes from Standby power state to On power state. */
   uint32_t DeviceRunningTime;   /**< Running time of the device. */
   uint32_t DeviceCoolerRunningTime;   /**< Running time of the device cooler. */
   uint8_t PowerOnAtStartup;   /**< Indicates whether the device is powered on at device startup. */
   uint8_t AcquisitionStartAtStartup;   /**< Indicates whether an acquisition is started at device startup. */
   uint8_t StealthMode;   /**< Indicates whether the device is in stealth mode. */
   uint8_t BadPixelReplacement;   /**< Indicates whether the Bad Pixels Replacement is enabled. */
   uint32_t CalibrationCollectionPOSIXTimeAtStartup;   /**< POSIX time of the calibration collection to load at camera startup. */
   uint32_t CalibrationCollectionBlockPOSIXTimeAtStartup;   /**< POSIX time of the calibration block to load at camera startup. */
   uint32_t DeviceKeyValidationLow;   /**< Device 64-bit key validation value (LSB). */
   uint32_t DeviceKeyValidationHigh;   /**< Device 64-bit key validation value (MSB). */
   uint8_t FileOrderKey1;   /**< First key for files ordering. */
   uint8_t FileOrderKey2;   /**< Second key for files ordering. */
   uint8_t FileOrderKey3;   /**< Third key for files ordering. */
   uint8_t FileOrderKey4;   /**< Fourth key for files ordering. */
   uint8_t CalibrationCollectionFileOrderKey1;   /**< First key for calibration collection files ordering. */
   uint8_t CalibrationCollectionFileOrderKey2;   /**< Second key for calibration collection files ordering. */
   uint8_t CalibrationCollectionFileOrderKey3;   /**< Third key for calibration collection files ordering. */
   uint8_t CalibrationCollectionFileOrderKey4;   /**< Fourth key for calibration collection files ordering. */
   uint8_t DeviceSerialPortFunctionRS232;   /**< RS-232 device serial port function. */
   uint8_t FileOrderKey5;   /**< Fifth key for files ordering. */
   uint8_t CalibrationCollectionFileOrderKey5;   /**< Fifth key for calibration collection files ordering. */
   float AutofocusROI;   /**< Centered portion (in %) of image used as region of interest by the automatic focus algorithm. */
   uint16_t FileHeaderCRC16;   /**< File header CRC-16 */
};

/**
 * FlashDynamicValuesFileHeader data type.
 */
typedef struct FlashDynamicValues_FlashDynamicValuesFileHeader_v2Struct FlashDynamicValues_FlashDynamicValuesFileHeader_v2_t;

uint32_t FlashDynamicValues_ParseFlashDynamicValuesFileHeader_v2(uint8_t *buffer, uint32_t buflen, FlashDynamicValues_FlashDynamicValuesFileHeader_v2_t *hdr);
uint32_t FlashDynamicValues_WriteFlashDynamicValuesFileHeader_v2(FlashDynamicValues_FlashDynamicValuesFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);

#endif // FLASHDYNAMICVALUESFILE_V2_H