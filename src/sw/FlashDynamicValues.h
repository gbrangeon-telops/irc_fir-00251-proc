/**
 * @file FlashDynamicValues.h
 * Camera flash dynamic values structure declaration.
 *
 * This file declares the camera flash dynamic values structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FLASHDYNAMICVALUES_H
#define FLASHDYNAMICVALUES_H

#include <stdint.h>
#include "IRC_Status.h"
#include "verbose.h"

#ifdef FDV_VERBOSE
   #define FDV_PRINTF(fmt, ...)  PRINTF("FDV: " fmt, ##__VA_ARGS__)
#else
   #define FDV_PRINTF(fmt, ...)  DUMMY_PRINTF("FDV: " fmt, ##__VA_ARGS__)
#endif

#define FDV_ERR(fmt, ...)        PRINTF("FDV: Error: " fmt "\n", ##__VA_ARGS__)
#define FDV_INF(fmt, ...)        PRINTF("FDV: Info: " fmt "\n", ##__VA_ARGS__)
#define FDV_DBG(fmt, ...)        FDV_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)


#define FDV_FILENAME             "FlashDynamicValues.tsdv"
#define FDV_TMP_FILENAME         "FlashDynamicValuesTmp.tsdv"
#define FDV_LONG_FILENAME        FM_UFFS_MOUNT_POINT FDV_FILENAME
#define FDV_LONG_TMP_FILENAME    FM_UFFS_MOUNT_POINT FDV_TMP_FILENAME


/* AUTO-CODE BEGIN */
// Auto-generated Flash Dynamic Values library.
// Generated from the Flash Dynamic Values definition XLS file version 1.4.0
// using generateFlashDynamicValuesCLib.m Matlab script.

#define FDV_FILESTRUCTUREMAJORVERSION      1
#define FDV_FILESTRUCTUREMINORVERSION      4
#define FDV_FILESTRUCTURESUBMINORVERSION   0

/**
 * Flash dynamic values fields definition
 */
#define FDV_FILESIGNATURE_OFFSET   0
#define FDV_FILESIGNATURE_LENGTH   4

#define FDV_FILESTRUCTUREMAJORVERSION_OFFSET   4
#define FDV_FILESTRUCTUREMAJORVERSION_LENGTH   1

#define FDV_FILESTRUCTUREMINORVERSION_OFFSET   5
#define FDV_FILESTRUCTUREMINORVERSION_LENGTH   1

#define FDV_FILESTRUCTURESUBMINORVERSION_OFFSET   6
#define FDV_FILESTRUCTURESUBMINORVERSION_LENGTH   1

#define FDV_FLASHDYNAMICVALUESFILELENGTH_OFFSET   8
#define FDV_FLASHDYNAMICVALUESFILELENGTH_LENGTH   4

#define FDV_DEVICESERIALNUMBER_OFFSET   12
#define FDV_DEVICESERIALNUMBER_LENGTH   4

#define FDV_POSIXTIME_OFFSET   16
#define FDV_POSIXTIME_LENGTH   4

#define FDV_DEVICEPOWERONCYCLES_OFFSET   20
#define FDV_DEVICEPOWERONCYCLES_LENGTH   4

#define FDV_DEVICECOOLERPOWERONCYCLES_OFFSET   24
#define FDV_DEVICECOOLERPOWERONCYCLES_LENGTH   4

#define FDV_DEVICERUNNINGTIME_OFFSET   28
#define FDV_DEVICERUNNINGTIME_LENGTH   4

#define FDV_DEVICECOOLERRUNNINGTIME_OFFSET   32
#define FDV_DEVICECOOLERRUNNINGTIME_LENGTH   4

#define FDV_POWERONATSTARTUP_OFFSET   36
#define FDV_POWERONATSTARTUP_LENGTH   1

#define FDV_ACQUISITIONSTARTATSTARTUP_OFFSET   37
#define FDV_ACQUISITIONSTARTATSTARTUP_LENGTH   1

#define FDV_STEALTHMODE_OFFSET   38
#define FDV_STEALTHMODE_LENGTH   1

#define FDV_CALIBRATIONCOLLECTIONPOSIXTIMEATSTARTUP_OFFSET   40
#define FDV_CALIBRATIONCOLLECTIONPOSIXTIMEATSTARTUP_LENGTH   4

#define FDV_CALIBRATIONCOLLECTIONBLOCKPOSIXTIMEATSTARTUP_OFFSET   44
#define FDV_CALIBRATIONCOLLECTIONBLOCKPOSIXTIMEATSTARTUP_LENGTH   4

#define FDV_DEVICEKEYVALIDATIONLOW_OFFSET   48
#define FDV_DEVICEKEYVALIDATIONLOW_LENGTH   4

#define FDV_DEVICEKEYVALIDATIONHIGH_OFFSET   52
#define FDV_DEVICEKEYVALIDATIONHIGH_LENGTH   4

#define FDV_FLASHDYNAMICVALUESFILECRC16_OFFSET   510
#define FDV_FLASHDYNAMICVALUESFILECRC16_LENGTH   2

#define FDV_FLASH_DYNAMIC_VALUES_FILE_LENGTH   512

/**
 * Flash dynamic values data structure declaration
 */
struct flashDynamicValuesStruct {
   uint8_t isValid;   /* Indicate whether the flash dynamic values data is valid */
   uint32_t FlashDynamicValuesFileLength;   /**< Camera flash dynamic values file length */
   uint32_t DeviceSerialNumber;   /**< Unique Telops 32-bit device serial number */
   uint32_t POSIXTime;   /**< Camera flash dynamic values file generation date and time. */
   uint32_t DevicePowerOnCycles;   /**< Number of times the device has been power cycled. It corresponds to the number of times the device passes from Off power state to Standby power state. */
   uint32_t DeviceCoolerPowerOnCycles;   /**< Number of times the device cooler has been power cycled. It corresponds to the number of times the device passes from Standby power state to On power state. */
   uint32_t DeviceRunningTime;   /**< Running time of the device. */
   uint32_t DeviceCoolerRunningTime;   /**< Running time of the device cooler. */
   uint32_t CalibrationCollectionPOSIXTimeAtStartup;   /**< POSIX time of the calibration collection to load at camera startup. */
   uint32_t CalibrationCollectionBlockPOSIXTimeAtStartup;   /**< POSIX time of the calibration block to load at camera startup. */
   uint32_t DeviceKeyValidationLow;   /**< Device 64-bit key validation value (LSB) */
   uint32_t DeviceKeyValidationHigh;   /**< Device 64-bit key validation value (MSB) */
   uint16_t FlashDynamicValuesFileCRC16;   /**< Camera flash dynamic values file CRC-16 */
   uint8_t FileStructureMajorVersion;   /**< Camera flash dynamic values file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Camera flash dynamic values file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Camera flash dynamic values file structure SubMinor Version */
   uint8_t PowerOnAtStartup;   /**< Indicates whether the device is powered on at device startup. */
   uint8_t AcquisitionStartAtStartup;   /**< Indicates whether an acquisition is started at device startup. */
   uint8_t StealthMode;   /**< Indicates whether the device is in stealth mode. */
   char FileSignature[5];   /**< Camera flash dynamic values file signature */
};

/**
 * Flash dynamic values data type
 */
typedef struct flashDynamicValuesStruct flashDynamicValues_t;

/* AUTO-CODE END */

IRC_Status_t FlashDynamicValues_Init(flashDynamicValues_t *p_flashDynamicValues);
IRC_Status_t FlashDynamicValues_Update(flashDynamicValues_t *p_flashDynamicValues);
IRC_Status_t FlashDynamicValues_Recover();

#endif // FLASHDYNAMICVALUES_H
