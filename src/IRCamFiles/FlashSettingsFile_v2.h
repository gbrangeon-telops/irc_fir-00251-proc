/**
 * @file FlashSettingsFile_v2.h
 * Camera flash settings file structure v2 declaration.
 *
 * This file declares the camera flash settings file structure v2.
 *
 * Auto-generated flash settings file library.
 * Generated from the flash settings file structure definition XLS file version 2.6.0
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

#ifndef FLASHSETTINGSFILE_V2_H
#define FLASHSETTINGSFILE_V2_H

#include <stdint.h>

#define FLASHSETTINGS_FILEMAJORVERSION_V2      2
#define FLASHSETTINGS_FILEMINORVERSION_V2      6
#define FLASHSETTINGS_FILESUBMINORVERSION_V2   0

#define FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE_V2   65536
#define FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE_V2   512
#define FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKCOUNT_V2   128

/**
 * FlashSettingsFileHeader data structure.
 */
struct FlashSettings_FlashSettingsFileHeader_v2Struct {
   char FileSignature[5];   /**< File signature. */
   uint8_t FileStructureMajorVersion;   /**< File structure Major Version. */
   uint8_t FileStructureMinorVersion;   /**< File structure Minor Version. */
   uint8_t FileStructureSubMinorVersion;   /**< File structure SubMinor Version. */
   uint32_t FileHeaderLength;   /**< File header length. */
   uint32_t DeviceSerialNumber;   /**< Device serial number. */
   char DeviceModelName[21];   /**< Device model name. */
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
   uint8_t ImageCorrectionEnabled;   /**< Indicates whether the image correction is enabled. */
   uint8_t ImageCorrectionAtPowerOn;   /**< Indicates whether the image correction is performed at power on. */
   uint16_t ImageCorrectionNumberOfImagesCoadd;   /**< Number of images to co-add for calibration update. */
   float ImageCorrectionAECImageFraction;   /**< AEC image fraction used during calibration update. */
   float ImageCorrectionAECTargetWellFilling;   /**< AEC target well filling used during calibration update. */
   float ImageCorrectionAECResponseTime;   /**< AEC response time used during calibration update. */
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
   uint8_t ImageCorrectionTemperatureSelector;   /**< Indicates which temperature is used for image correction stabilization. */
   uint8_t ImageCorrectionDiscardOffset;   /**< Indicates whether a zero-mean beta correction is applied. */
   uint32_t ImageCorrectionWaitTime1;   /**< Waiting time before first stabilization phase. */
   int16_t ImageCorrectionTemperatureTolerance1;   /**< Temperature variation tolerance during the first stabilization phase (prior to placing the ICU in front of the detector). */
   uint32_t ImageCorrectionStabilizationTime1;   /**< Minimum stabilisation time in first stabilization phase. */
   uint32_t ImageCorrectionTimeout1;   /**< Maximum waiting time during first stabilization phase. */
   uint32_t ImageCorrectionWaitTime2;   /**< Waiting time before second stabilization phase. */
   int16_t ImageCorrectionTemperatureTolerance2;   /**< Temperature variation tolerance during the second stabilization phase (prior to acquiring ICU measurements). */
   uint32_t ImageCorrectionStabilizationTime2;   /**< Minimum stabilisation time in second stabilization phase. */
   uint32_t ImageCorrectionTimeout2;   /**< Maximum waiting time during second stabilization phase. */
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
   uint8_t BPDetectionEnabled;   /**< Indicates whether the bad pixel detection is enabled. */
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
   uint8_t ADCReadoutEnabled;   /**< Indicates whether the ADC channel readout is enabled. */
   int16_t ADCReadout_b;   /**< ADC channel readout calibration offset. */
   float ADCReadout_m;   /**< ADC channel readout calibration gain. */
   float AECPlusExposureTimeMin;   /**< Minimum exposure time when AEC+ is active. */
   float AECSaturatedCorrectionFactor;   /**< AEC correction factor when image is saturated. */
   float FWFramePeriodMinMargin;   /**< Minimum frame period margin. */
   uint8_t InternalLensThType;   /**< Internal lens thermistor type. */
   uint8_t ExternalLensThType;   /**< External lens thermistor type. */
   uint8_t ICUThType;   /**< ICU  thermistor type. */
   uint8_t SFWThType;   /**< SFW thermistor type. */
   uint8_t CompressorThType;   /**< Compressor thermistor type. */
   uint8_t ColdfingerThType;   /**< ColdFinger lens thermistor type. */
   uint8_t SpareThType;   /**< Spare lens thermistor type. */
   uint8_t ExternalTempThType;   /**< External temperature thermistor type. */
   float XADCRefVoltage1;   /**< Reference voltage At pin 21 of the analog mux. */
   float XADCRefVoltage2;   /**< Reference voltage At pin 20 of the analog mux. */
   float XADCRefVoltage3;   /**< Reference voltage At pin 19 of the analog mux. */
   uint8_t SFWOptoswitchPresent;   /**< Presence or absence of the SFW optoswitch used for SFW homing method. */
   uint8_t MotorizedLensType;   /**< Type of the motorized lens. */
   uint8_t AutofocusModuleType;   /**< Type of the autofocus module. */
   uint8_t FOVNumberOfPositions;   /**< Number of user-defined FOV positions on the motorized lens. */
   uint8_t FOV1ToLensFOV;   /**< Lens-defined FOV position corresponding to user-defined FOV1. */
   uint8_t FOV2ToLensFOV;   /**< Lens-defined FOV position corresponding to user-defined FOV2. */
   uint8_t FOV3ToLensFOV;   /**< Lens-defined FOV position corresponding to user-defined FOV3. */
   uint8_t FOV4ToLensFOV;   /**< Lens-defined FOV position corresponding to user-defined FOV4. */
   int16_t LensFOV1DeltaFocusPositionMin;   /**< Difference between minimal and nominal focus positions for lens-defined FOV1. */
   int16_t LensFOV1DeltaFocusPositionMax;   /**< Difference between maximal and nominal focus positions for lens-defined FOV1. */
   int16_t LensFOV2DeltaFocusPositionMin;   /**< Difference between minimal and nominal focus positions for lens-defined FOV2. */
   int16_t LensFOV2DeltaFocusPositionMax;   /**< Difference between maximal and nominal focus positions for lens-defined FOV2. */
   int16_t LensFOV3DeltaFocusPositionMin;   /**< Difference between minimal and nominal focus positions for lens-defined FOV3. */
   int16_t LensFOV3DeltaFocusPositionMax;   /**< Difference between maximal and nominal focus positions for lens-defined FOV3. */
   int16_t LensFOV4DeltaFocusPositionMin;   /**< Difference between minimal and nominal focus positions for lens-defined FOV4. */
   int16_t LensFOV4DeltaFocusPositionMax;   /**< Difference between maximal and nominal focus positions for lens-defined FOV4. */
   int16_t LensFOV5DeltaFocusPositionMin;   /**< Difference between minimal and nominal focus positions for lens-defined FOV5. */
   int16_t LensFOV5DeltaFocusPositionMax;   /**< Difference between maximal and nominal focus positions for lens-defined FOV5. */
   float AcquisitionFrameRateMaxDivider;   /**< Division factor to limit maximum acquisition frame rate. */
   int32_t ExposureTimeOffset;   /**< Offset applied to the exposure time command to the FPA. */
   float FWReferenceTemperatureGain;   /**< Filter wheel reference temperature gain. */
   float FWReferenceTemperatureOffset;   /**< Filter wheel reference temperature offset. */
   float ExposureTimeMin;   /**< Minimum exposure time to overwrite value from FPA driver. */
   uint8_t ClConfiguration;   /**< Camera link configuration. */
   uint16_t FileHeaderCRC16;   /**< File header CRC-16 */
};

/**
 * FlashSettingsFileHeader data type.
 */
typedef struct FlashSettings_FlashSettingsFileHeader_v2Struct FlashSettings_FlashSettingsFileHeader_v2_t;

uint32_t FlashSettings_ParseFlashSettingsFileHeader_v2(uint8_t *buffer, uint32_t buflen, uint32_t idxChunk, FlashSettings_FlashSettingsFileHeader_v2_t *hdr, uint16_t *crc16);
uint32_t FlashSettings_WriteFlashSettingsFileHeader_v2(FlashSettings_FlashSettingsFileHeader_v2_t *hdr, uint32_t idxChunk, uint8_t *buffer, uint32_t buflen, uint16_t *crc16);
void FlashSettings_PrintFlashSettingsFileHeader_v2(FlashSettings_FlashSettingsFileHeader_v2_t *hdr);

#endif // FLASHSETTINGSFILE_V2_H