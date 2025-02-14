/**
 * @file FlashSettingsFile_v1.h
 * Camera flash settings file structure v1 declaration.
 *
 * This file declares the camera flash settings file structure v1.
 *
 * Auto-generated flash settings file library.
 * Generated from the flash settings file structure definition XLS file version 1.12.0
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

#ifndef FLASHSETTINGSFILE_V1_H
#define FLASHSETTINGSFILE_V1_H

#include <stdint.h>

#define FLASHSETTINGS_FILEMAJORVERSION_V1      1
#define FLASHSETTINGS_FILEMINORVERSION_V1      13
#define FLASHSETTINGS_FILESUBMINORVERSION_V1   0

#define FLASHSETTINGS_FLASHSETTINGSFILE_SIZE_V1   65536
#define FLASHSETTINGS_FLASHSETTINGSFILE_CHUNKSIZE_V1   512
#define FLASHSETTINGS_FLASHSETTINGSFILE_CHUNKCOUNT_V1   128

/**
 * FlashSettingsFile data structure.
 */
struct FlashSettings_FlashSettingsFile_v1Struct {
   char FileSignature[5];   /**< Camera flash settings file signature */
   uint8_t FileStructureMajorVersion;   /**< Camera flash settings file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Camera flash settings file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Camera flash settings file structure SubMinor Version */
   uint32_t FlashSettingsFileLength;   /**< Camera flash settings file length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   char DeviceModelName[21];   /**< Device model name */
   uint8_t SensorID;   /**< Sensor  ID. */
   uint8_t PixelDataResolution;   /**< Default pixel data resolution. */
   uint8_t ReverseX;   /**< Flip horizontally the image sent by the device. */
   uint8_t ReverseY;   /**< Flip vertically the image sent by the device. */
   uint8_t ICUPresent;   /**< Indicates whether a ICU is installed in the camera. */
   uint8_t ICUMode;   /**< ICU mode. */
   uint8_t ICUCalibPosition;   /**< Direction of the ICU command for calibration position. */
   uint16_t ICUPulseWidth;   /**< Duration of the command. */
   uint16_t ICUPeriod;   /**< Period of the pulse in repeat mode. */
   uint16_t ICUTransitionDuration;   /**< Duration of the moving state after a newly commanded set point. */
   uint8_t ActualizationEnabled;   /**< Indicates whether the actualization is enabled. */
   uint8_t ActualizationAtPowerOn;   /**< Indicates whether the actualization is performed at power on. */
   uint16_t ActualizationNumberOfImagesCoadd;   /**< Number of images to co-add for calibration update. */
   float ActualizationAECImageFraction;   /**< AEC image fraction used during calibration update. */
   float ActualizationAECTargetWellFilling;   /**< AEC target well filling used during calibration update. */
   float ActualizationAECResponseTime;   /**< AEC response time used during calibration update. */
   uint8_t FWPresent;   /**< Indicates whether a filter wheel is installed in the camera. */
   uint8_t FWNumberOfFilters;   /**< Indicates the number of filters in the camera head filter wheel. */
   uint8_t FWType;   /**< Indicates whether the filter wheel supports  the synchronously rotating mode. */
   int32_t FW0CenterPosition;   /**< Raw position of the first filter wheel filter center. */
   int32_t FW1CenterPosition;   /**< Raw position of the second filter wheel filter center. */
   int32_t FW2CenterPosition;   /**< Raw position of the third filter wheel filter center. */
   int32_t FW3CenterPosition;   /**< Raw position of the fourth filter wheel filter center. */
   int32_t FW4CenterPosition;   /**< Raw position of the fifth filter wheel filter center. */
   int32_t FW5CenterPosition;   /**< Raw position of the sixth filter wheel filter center. */
   int32_t FW6CenterPosition;   /**< Raw position of the seventh filter wheel filter center. */
   int32_t FW7CenterPosition;   /**< Raw position of the eighth filter wheel filter center. */
   uint8_t ActualizationTemperatureSelector;   /**< Indicates which temperature is used for actualization stabilization. */
   uint8_t ActualizationDiscardOffset;   /**< Indicates whether a zero-mean beta correction is applied. */
   uint32_t ActualizationWaitTime1;   /**< Waiting time before first stabilization phase. */
   int16_t ActualizationTemperatureTolerance1;   /**< Temperature variation tolerance during the first stabilization phase (prior to placing the ICU in front of the detector). */
   uint32_t ActualizationStabilizationTime1;   /**< Minimum stabilisation time in first stabilization phase. */
   uint32_t ActualizationTimeout1;   /**< Maximum waiting time during first stabilization phase. */
   uint32_t ActualizationWaitTime2;   /**< Waiting time before second stabilization phase. */
   int16_t ActualizationTemperatureTolerance2;   /**< Temperature variation tolerance during the second stabilization phase (prior to acquiring ICU measurements). */
   uint32_t ActualizationStabilizationTime2;   /**< Minimum stabilisation time in second stabilization phase. */
   uint32_t ActualizationTimeout2;   /**< Maximum waiting time during second stabilization phase. */
   int16_t DetectorPolarizationVoltage;   /**< Detector photodiodes polarization voltage. */
   uint8_t ExternalMemoryBufferPresent;   /**< Indicates whether an external memory buffer board is installed in the camera. */
   uint8_t NDFPresent;   /**< Indicates whether a neutral density filter fan is installed in the camera. */
   uint8_t NDFNumberOfFilters;   /**< Indicates the number of neutral density filters in the camera head  neutral density filter fan. */
   uint16_t NDFClearFOVWidth;   /**< Edge to edge raw distance of clear FOV. */
   int32_t NDF0CenterPosition;   /**< Raw position of the first neutral density filter center. */
   int32_t NDF1CenterPosition;   /**< Raw position of the second neutral density filter center. */
   int32_t NDF2CenterPosition;   /**< Raw position of the third neutral density filter center. */
   uint16_t FWSpeedMax;   /**< Indicates the maximum filter wheel rotation speed in RPM. */
   uint16_t FWEncoderCyclePerTurn;   /**< Number of counts for external encoder. */
   float FWOpticalAxisPosX;   /**< X position of the optical axis relative to filter wheel's center. */
   float FWOpticalAxisPosY;   /**< Y position of the optical axis relative to filter wheel's center. */
   float FWMountingHoleRadius;   /**< Filter wheel filter's mounting hole radius. */
   float FWBeamMarging;   /**< Filter wheel optical beam marging. */
   float FWCornerPixDistX;   /**< X position of corner pixel. */
   float FWCornerPixDistY;   /**< Y position of corner pixel. */
   float FWCenterPixRadius;   /**< Center pixel radius. */
   float FWCornerPixRadius;   /**< Corner pixel radius. */
   uint16_t FWPositionControllerPP;   /**< Filter wheel position controller position proportional gain. */
   uint16_t FWPositionControllerPD;   /**< Filter wheel position controller position differential gain. */
   uint16_t FWPositionControllerPOR;   /**< Filter wheel position controller velocity proportional gain. */
   uint16_t FWPositionControllerI;   /**< Filter wheel position controller velocity integral gain. */
   uint16_t FWSlowSpeedControllerPP;   /**< Filter wheel slow speed controller position proportional gain. */
   uint16_t FWSlowSpeedControllerPD;   /**< Filter wheel slow speed controller position differential gain. */
   uint16_t FWSlowSpeedControllerPOR;   /**< Filter wheel slow speed controller velocity proportional gain. */
   uint16_t FWSlowSpeedControllerPI;   /**< Filter wheel slow speed controller velocity integral gain. */
   uint16_t FWFastSpeedControllerPP;   /**< Filter wheel fast speed controller position proportional gain. */
   uint16_t FWFastSpeedControllerPD;   /**< Filter wheel fast speed controller position differential gain. */
   uint16_t FWFastSpeedControllerPOR;   /**< Filter wheel fast speed controller velocity proportional gain. */
   uint16_t FWFastSpeedControllerI;   /**< Filter wheel fast speed controller velocity integral gain. */
   uint16_t FWSpeedControllerSwitchingThreshold;   /**< Indicates the speed at which fast filter wheel speed controller is used instead of the slow filter wheel speed controller. */
   float FWExposureTimeMaxMargin;   /**< Limits ExposureTimeMax to account for Synchronous filter wheel velocity instability. */
   float ExternalFanSpeedSetpoint;   /**< Default external fan speed setpoint. */
   uint8_t BPDetectionEnabled;   /**< Indicates whether the actualization is enabled. */
   uint16_t BPNumSamples;   /**< Number of images to acquire. */
   float BPFlickerThreshold;   /**< Threshold for tagging a pixel as flicker  (abs(T) > threshold). */
   float BPNoiseThreshold;   /**< Threshold for tagging a pixel as flicker (T > threshold). */
   uint32_t BPDuration;   /**< Duration of the acquisition. */
   uint16_t BPNCoadd;   /**< Number of frames to use for average estimation. */
   float MaximumTotalFlux;   /**< The maximum flux the detector can support without current saturation. */
   float FluxRatio01;   /**< Flux ratio between filter 0 and filter 1. */
   float FluxRatio12;   /**< Flux ratio between filter 1 and filter 2. */
   float AECPlusExpTimeMargin;   /**< Margin on the exposure time for hysteresis purpose of the AEC+. */
   float AECPlusFluxMargin;   /**< Margin on the detector's flux for hysteresis purpose of the AEC+. */
   float BPOutlierThreshold;   /**< Threshold for tagging a pixel as an outlier. */
   float BPAECImageFraction;   /**< AEC image fraction used during bad pixel measurement. */
   float BPAECWellFilling;   /**< AEC target well filling used during bad pixel measurement. */
   float BPAECResponseTime;   /**< AEC response time used during bad pixel measurement. */
   uint32_t DeviceKeyExpirationPOSIXTime;   /**< Device key expiration POSIX time. */
   uint32_t DeviceKeyLow;   /**< Device 64-bit key (LSB). */
   uint32_t DeviceKeyHigh;   /**< Device 64-bit key (MSB). */
   float DetectorElectricalTapsRef;   /**< Electrical reference of detector taps. */
   float DetectorElectricalRefOffset;   /**< Electrical offset of detector taps reference opamp. */
   float AECPlusExposureTimeMin;   /**< Minimum exposure time when AEC+ is active. */
   uint16_t FlashSettingsFileCRC16;   /**< Camera flash settings file CRC-16 */
};

/**
 * FlashSettingsFile data type.
 */
typedef struct FlashSettings_FlashSettingsFile_v1Struct FlashSettings_FlashSettingsFile_v1_t;

uint32_t FlashSettings_ParseFlashSettingsFile_v1(uint8_t *buffer, uint32_t buflen, uint32_t idxChunk, FlashSettings_FlashSettingsFile_v1_t *hdr, uint16_t *crc16);
uint32_t FlashSettings_WriteFlashSettingsFile_v1(FlashSettings_FlashSettingsFile_v1_t *hdr, uint32_t idxChunk, uint8_t *buffer, uint32_t buflen, uint16_t *crc16);

#endif // FLASHSETTINGSFILE_V1_H
