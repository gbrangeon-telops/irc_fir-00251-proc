/**
 * @file FlashSettings.h
 * Camera flash settings structure declaration.
 *
 * This file declares the camera flash settings structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FLASHSETTINGS_H
#define FLASHSETTINGS_H

#include <stdint.h>
#include "IRC_Status.h"
#include "verbose.h"

#ifdef FS_VERBOSE
   #define FS_PRINTF(fmt, ...)   FPGA_PRINTF("FS: " fmt, ##__VA_ARGS__)
#else
   #define FS_PRINTF(fmt, ...)   DUMMY_PRINTF("FS: " fmt, ##__VA_ARGS__)
#endif

#define FS_ERR(fmt, ...)         FPGA_PRINTF("FS: Error: " fmt "\n", ##__VA_ARGS__)
#define FS_INF(fmt, ...)         FPGA_PRINTF("FS: Info: " fmt "\n", ##__VA_ARGS__)
#define FS_DBG(fmt, ...)         FS_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define FS_MAX_SPARE_FREE_SPACE_READ_BYTES   512

/**
 * Flash settings loader state.
 */
enum fslStateEnum {
   FSLS_IDLE = 0,                      /**< Flash settings loader idle state */
   FSLS_LOAD_FLASH_HEADER,             /**< Load flash settings file header state */
   FSLS_LOAD_FLASH_DATA,               /**< Load flash settings fields data state */
   FSLS_SKIP_SPARE_FREE_SPACE,         /**< Skip spare free space state */
   FSLS_VALIDATE_CRC16,                /**< Validate CRC-16 value state */
   FSLS_FINALIZE,                      /**< Finalize flash settings data */
   FSLS_ERROR                          /**< Executed when an error occurs while loading flash settings data */
};

/**
 * Flash settings loader state data type.
 */
typedef enum fslStateEnum fslState_t;

/**
 * Flash settings loader Immediate.
 */
enum fslImmediateEnum {
   FSLI_DEFERRED_LOADING = 0,          /**< Flash settings file loading is deferred */
   FSLI_LOAD_IMMEDIATELY = 1           /**< Flash settings file is loaded immediately */
};

/**
 * Flash settings loader immediate data type.
 */
typedef enum fslImmediateEnum fslImmediate_t;

/* AUTO-CODE BEGIN */
// Auto-generated Flash Settings library.
// Generated from the Flash Settings definition XLS file version 1.11.0
// using generateFlashSettingsCLib.m Matlab script.

#define FS_FILESTRUCTUREMAJORVERSION      1
#define FS_FILESTRUCTUREMINORVERSION      11
#define FS_FILESTRUCTURESUBMINORVERSION   0

/**
 * Flash settings fields definition
 */
#define FS_FILESIGNATURE_OFFSET   0
#define FS_FILESIGNATURE_LENGTH   4

#define FS_FILESTRUCTUREMAJORVERSION_OFFSET   4
#define FS_FILESTRUCTUREMAJORVERSION_LENGTH   1

#define FS_FILESTRUCTUREMINORVERSION_OFFSET   5
#define FS_FILESTRUCTUREMINORVERSION_LENGTH   1

#define FS_FILESTRUCTURESUBMINORVERSION_OFFSET   6
#define FS_FILESTRUCTURESUBMINORVERSION_LENGTH   1

#define FS_FLASHSETTINGSFILELENGTH_OFFSET   8
#define FS_FLASHSETTINGSFILELENGTH_LENGTH   4

#define FS_DEVICESERIALNUMBER_OFFSET   12
#define FS_DEVICESERIALNUMBER_LENGTH   4

#define FS_DEVICEMODELNAME_OFFSET   16
#define FS_DEVICEMODELNAME_LENGTH   20

#define FS_SENSORID_OFFSET   36
#define FS_SENSORID_LENGTH   1

#define FS_PIXELDATARESOLUTION_OFFSET   37
#define FS_PIXELDATARESOLUTION_LENGTH   1

#define FS_REVERSEX_OFFSET   38
#define FS_REVERSEX_LENGTH   1

#define FS_REVERSEY_OFFSET   39
#define FS_REVERSEY_LENGTH   1

#define FS_ICUPRESENT_OFFSET   40
#define FS_ICUPRESENT_LENGTH   1

#define FS_ICUMODE_OFFSET   41
#define FS_ICUMODE_LENGTH   1

#define FS_ICUCALIBPOSITION_OFFSET   42
#define FS_ICUCALIBPOSITION_LENGTH   1

#define FS_ICUPULSEWIDTH_OFFSET   44
#define FS_ICUPULSEWIDTH_LENGTH   2

#define FS_ICUPERIOD_OFFSET   46
#define FS_ICUPERIOD_LENGTH   2

#define FS_ICUTRANSITIONDURATION_OFFSET   48
#define FS_ICUTRANSITIONDURATION_LENGTH   2

#define FS_ACTUALIZATIONENABLED_OFFSET   54
#define FS_ACTUALIZATIONENABLED_LENGTH   1

#define FS_ACTUALIZATIONATPOWERON_OFFSET   55
#define FS_ACTUALIZATIONATPOWERON_LENGTH   1

#define FS_ACTUALIZATIONNUMBEROFIMAGESCOADD_OFFSET   56
#define FS_ACTUALIZATIONNUMBEROFIMAGESCOADD_LENGTH   2

#define FS_ACTUALIZATIONAECIMAGEFRACTION_OFFSET   60
#define FS_ACTUALIZATIONAECIMAGEFRACTION_LENGTH   4

#define FS_ACTUALIZATIONAECTARGETWELLFILLING_OFFSET   64
#define FS_ACTUALIZATIONAECTARGETWELLFILLING_LENGTH   4

#define FS_ACTUALIZATIONAECRESPONSETIME_OFFSET   68
#define FS_ACTUALIZATIONAECRESPONSETIME_LENGTH   4

#define FS_FWPRESENT_OFFSET   72
#define FS_FWPRESENT_LENGTH   1

#define FS_FWNUMBEROFFILTERS_OFFSET   73
#define FS_FWNUMBEROFFILTERS_LENGTH   1

#define FS_FWTYPE_OFFSET   74
#define FS_FWTYPE_LENGTH   1

#define FS_FW0CENTERPOSITION_OFFSET   76
#define FS_FW0CENTERPOSITION_LENGTH   4

#define FS_FW1CENTERPOSITION_OFFSET   80
#define FS_FW1CENTERPOSITION_LENGTH   4

#define FS_FW2CENTERPOSITION_OFFSET   84
#define FS_FW2CENTERPOSITION_LENGTH   4

#define FS_FW3CENTERPOSITION_OFFSET   88
#define FS_FW3CENTERPOSITION_LENGTH   4

#define FS_FW4CENTERPOSITION_OFFSET   92
#define FS_FW4CENTERPOSITION_LENGTH   4

#define FS_FW5CENTERPOSITION_OFFSET   96
#define FS_FW5CENTERPOSITION_LENGTH   4

#define FS_FW6CENTERPOSITION_OFFSET   100
#define FS_FW6CENTERPOSITION_LENGTH   4

#define FS_FW7CENTERPOSITION_OFFSET   104
#define FS_FW7CENTERPOSITION_LENGTH   4

#define FS_ACTUALIZATIONTEMPERATURESELECTOR_OFFSET   108
#define FS_ACTUALIZATIONTEMPERATURESELECTOR_LENGTH   1

#define FS_ACTUALIZATIONDISCARDOFFSET_OFFSET   109
#define FS_ACTUALIZATIONDISCARDOFFSET_LENGTH   1

#define FS_ACTUALIZATIONWAITTIME1_OFFSET   112
#define FS_ACTUALIZATIONWAITTIME1_LENGTH   4

#define FS_ACTUALIZATIONTEMPERATURETOLERANCE1_OFFSET   116
#define FS_ACTUALIZATIONTEMPERATURETOLERANCE1_LENGTH   2

#define FS_ACTUALIZATIONSTABILIZATIONTIME1_OFFSET   120
#define FS_ACTUALIZATIONSTABILIZATIONTIME1_LENGTH   4

#define FS_ACTUALIZATIONTIMEOUT1_OFFSET   124
#define FS_ACTUALIZATIONTIMEOUT1_LENGTH   4

#define FS_ACTUALIZATIONWAITTIME2_OFFSET   128
#define FS_ACTUALIZATIONWAITTIME2_LENGTH   4

#define FS_ACTUALIZATIONTEMPERATURETOLERANCE2_OFFSET   132
#define FS_ACTUALIZATIONTEMPERATURETOLERANCE2_LENGTH   2

#define FS_ACTUALIZATIONSTABILIZATIONTIME2_OFFSET   136
#define FS_ACTUALIZATIONSTABILIZATIONTIME2_LENGTH   4

#define FS_ACTUALIZATIONTIMEOUT2_OFFSET   140
#define FS_ACTUALIZATIONTIMEOUT2_LENGTH   4

#define FS_DETECTORPOLARIZATIONVOLTAGE_OFFSET   144
#define FS_DETECTORPOLARIZATIONVOLTAGE_LENGTH   2

#define FS_EXTERNALMEMORYBUFFERPRESENT_OFFSET   146
#define FS_EXTERNALMEMORYBUFFERPRESENT_LENGTH   1

#define FS_NDFPRESENT_OFFSET   148
#define FS_NDFPRESENT_LENGTH   1

#define FS_NDFNUMBEROFFILTERS_OFFSET   149
#define FS_NDFNUMBEROFFILTERS_LENGTH   1

#define FS_NDFCLEARFOVWIDTH_OFFSET   150
#define FS_NDFCLEARFOVWIDTH_LENGTH   2

#define FS_NDF0CENTERPOSITION_OFFSET   152
#define FS_NDF0CENTERPOSITION_LENGTH   4

#define FS_NDF1CENTERPOSITION_OFFSET   156
#define FS_NDF1CENTERPOSITION_LENGTH   4

#define FS_NDF2CENTERPOSITION_OFFSET   160
#define FS_NDF2CENTERPOSITION_LENGTH   4

#define FS_FWSPEEDMAX_OFFSET   164
#define FS_FWSPEEDMAX_LENGTH   2

#define FS_FWENCODERCYCLEPERTURN_OFFSET   166
#define FS_FWENCODERCYCLEPERTURN_LENGTH   2

#define FS_FWOPTICALAXISPOSX_OFFSET   168
#define FS_FWOPTICALAXISPOSX_LENGTH   4

#define FS_FWOPTICALAXISPOSY_OFFSET   172
#define FS_FWOPTICALAXISPOSY_LENGTH   4

#define FS_FWMOUNTINGHOLERADIUS_OFFSET   176
#define FS_FWMOUNTINGHOLERADIUS_LENGTH   4

#define FS_FWBEAMMARGING_OFFSET   180
#define FS_FWBEAMMARGING_LENGTH   4

#define FS_FWCORNERPIXDISTX_OFFSET   184
#define FS_FWCORNERPIXDISTX_LENGTH   4

#define FS_FWCORNERPIXDISTY_OFFSET   188
#define FS_FWCORNERPIXDISTY_LENGTH   4

#define FS_FWCENTERPIXRADIUS_OFFSET   192
#define FS_FWCENTERPIXRADIUS_LENGTH   4

#define FS_FWCORNERPIXRADIUS_OFFSET   196
#define FS_FWCORNERPIXRADIUS_LENGTH   4

#define FS_FWPOSITIONCONTROLLERPP_OFFSET   200
#define FS_FWPOSITIONCONTROLLERPP_LENGTH   2

#define FS_FWPOSITIONCONTROLLERPD_OFFSET   202
#define FS_FWPOSITIONCONTROLLERPD_LENGTH   2

#define FS_FWPOSITIONCONTROLLERPOR_OFFSET   204
#define FS_FWPOSITIONCONTROLLERPOR_LENGTH   2

#define FS_FWPOSITIONCONTROLLERI_OFFSET   206
#define FS_FWPOSITIONCONTROLLERI_LENGTH   2

#define FS_FWSLOWSPEEDCONTROLLERPP_OFFSET   208
#define FS_FWSLOWSPEEDCONTROLLERPP_LENGTH   2

#define FS_FWSLOWSPEEDCONTROLLERPD_OFFSET   210
#define FS_FWSLOWSPEEDCONTROLLERPD_LENGTH   2

#define FS_FWSLOWSPEEDCONTROLLERPOR_OFFSET   212
#define FS_FWSLOWSPEEDCONTROLLERPOR_LENGTH   2

#define FS_FWSLOWSPEEDCONTROLLERPI_OFFSET   214
#define FS_FWSLOWSPEEDCONTROLLERPI_LENGTH   2

#define FS_FWFASTSPEEDCONTROLLERPP_OFFSET   216
#define FS_FWFASTSPEEDCONTROLLERPP_LENGTH   2

#define FS_FWFASTSPEEDCONTROLLERPD_OFFSET   218
#define FS_FWFASTSPEEDCONTROLLERPD_LENGTH   2

#define FS_FWFASTSPEEDCONTROLLERPOR_OFFSET   220
#define FS_FWFASTSPEEDCONTROLLERPOR_LENGTH   2

#define FS_FWFASTSPEEDCONTROLLERI_OFFSET   222
#define FS_FWFASTSPEEDCONTROLLERI_LENGTH   2

#define FS_FWSPEEDCONTROLLERSWITCHINGTHRESHOLD_OFFSET   224
#define FS_FWSPEEDCONTROLLERSWITCHINGTHRESHOLD_LENGTH   2

#define FS_FWEXPOSURETIMEMAXMARGIN_OFFSET   228
#define FS_FWEXPOSURETIMEMAXMARGIN_LENGTH   4

#define FS_EXTERNALFANSPEEDSETPOINT_OFFSET   232
#define FS_EXTERNALFANSPEEDSETPOINT_LENGTH   4

#define FS_BPDETECTIONENABLED_OFFSET   236
#define FS_BPDETECTIONENABLED_LENGTH   1

#define FS_BPNUMSAMPLES_OFFSET   237
#define FS_BPNUMSAMPLES_LENGTH   2

#define FS_BPFLICKERTHRESHOLD_OFFSET   240
#define FS_BPFLICKERTHRESHOLD_LENGTH   4

#define FS_BPNOISETHRESHOLD_OFFSET   244
#define FS_BPNOISETHRESHOLD_LENGTH   4

#define FS_BPDURATION_OFFSET   248
#define FS_BPDURATION_LENGTH   4

#define FS_BPNCOADD_OFFSET   252
#define FS_BPNCOADD_LENGTH   2

#define FS_MAXIMUMTOTALFLUX_OFFSET   256
#define FS_MAXIMUMTOTALFLUX_LENGTH   4

#define FS_FLUXRATIO01_OFFSET   260
#define FS_FLUXRATIO01_LENGTH   4

#define FS_FLUXRATIO12_OFFSET   264
#define FS_FLUXRATIO12_LENGTH   4

#define FS_AECPLUSEXPTIMEMARGIN_OFFSET   268
#define FS_AECPLUSEXPTIMEMARGIN_LENGTH   4

#define FS_AECPLUSFLUXMARGIN_OFFSET   272
#define FS_AECPLUSFLUXMARGIN_LENGTH   4

#define FS_BPOUTLIERTHRESHOLD_OFFSET   276
#define FS_BPOUTLIERTHRESHOLD_LENGTH   4

#define FS_BPAECIMAGEFRACTION_OFFSET   280
#define FS_BPAECIMAGEFRACTION_LENGTH   4

#define FS_BPAECWELLFILLING_OFFSET   284
#define FS_BPAECWELLFILLING_LENGTH   4

#define FS_BPAECRESPONSETIME_OFFSET   288
#define FS_BPAECRESPONSETIME_LENGTH   4

#define FS_DEVICEKEYEXPIRATIONPOSIXTIME_OFFSET   292
#define FS_DEVICEKEYEXPIRATIONPOSIXTIME_LENGTH   4

#define FS_DEVICEKEYLOW_OFFSET   296
#define FS_DEVICEKEYLOW_LENGTH   4

#define FS_DEVICEKEYHIGH_OFFSET   300
#define FS_DEVICEKEYHIGH_LENGTH   4

#define FS_SPARE_FREE_SPACE_OFFSET   304
#define FS_SPARE_FREE_SPACE_LENGTH   65230

#define FS_FLASHSETTINGSFILECRC16_OFFSET   65534
#define FS_FLASHSETTINGSFILECRC16_LENGTH   2

#define FS_FLASH_SETTINGS_FILE_LENGTH   65536

/**
 * Flash settings data structure declaration
 */
struct flashSettingsStruct {
   uint8_t isValid;   /* Indicate whether the flash settings data is valid */
   float ActualizationAECImageFraction;   /**< AEC image fraction used during calibration update. */
   float ActualizationAECTargetWellFilling;   /**< AEC target well filling used during calibration update. */
   float ActualizationAECResponseTime;   /**< AEC response time used during calibration update. */
   float FWOpticalAxisPosX;   /**< X position of the optical axis relative to filter wheel's center. */
   float FWOpticalAxisPosY;   /**< Y position of the optical axis relative to filter wheel's center. */
   float FWMountingHoleRadius;   /**< Filter wheel filter's mounting hole radius. */
   float FWBeamMarging;   /**< Filter wheel optical beam marging. */
   float FWCornerPixDistX;   /**< X position of corner pixel. */
   float FWCornerPixDistY;   /**< Y position of corner pixel. */
   float FWCenterPixRadius;   /**< Center pixel radius. */
   float FWCornerPixRadius;   /**< Corner pixel radius. */
   float FWExposureTimeMaxMargin;   /**< Limits ExposureTimeMax to account for Synchronous filter wheel velocity instability. */
   float ExternalFanSpeedSetpoint;   /**< Default external fan speed setpoint. */
   float BPFlickerThreshold;   /**< Threshold for tagging a pixel as flicker  (abs(T) > threshold). */
   float BPNoiseThreshold;   /**< Threshold for tagging a pixel as flicker (T > threshold). */
   float MaximumTotalFlux;   /**< The maximum flux the detector can support without current saturation. */
   float FluxRatio01;   /**< Flux ratio between filter 0 and filter 1. */
   float FluxRatio12;   /**< Flux ratio between filter 1 and filter 2. */
   float AECPlusExpTimeMargin;   /**< Margin on the exposure time for hysteresis purpose of the AEC+. */
   float AECPlusFluxMargin;   /**< Margin on the detector's flux for hysteresis purpose of the AEC+. */
   float BPOutlierThreshold;   /**< Threshold for tagging a pixel as an outlier. */
   float BPAECImageFraction;   /**< AEC image fraction used during bad pixel measurement. */
   float BPAECWellFilling;   /**< AEC target well filling used during bad pixel measurement. */
   float BPAECResponseTime;   /**< AEC response time used during bad pixel measurement. */
   int32_t FW0CenterPosition;   /**< Raw position of the first filter wheel filter center. */
   int32_t FW1CenterPosition;   /**< Raw position of the second filter wheel filter center. */
   int32_t FW2CenterPosition;   /**< Raw position of the third filter wheel filter center. */
   int32_t FW3CenterPosition;   /**< Raw position of the fourth filter wheel filter center. */
   int32_t FW4CenterPosition;   /**< Raw position of the fifth filter wheel filter center. */
   int32_t FW5CenterPosition;   /**< Raw position of the sixth filter wheel filter center. */
   int32_t FW6CenterPosition;   /**< Raw position of the seventh filter wheel filter center. */
   int32_t FW7CenterPosition;   /**< Raw position of the eighth filter wheel filter center. */
   int32_t NDF0CenterPosition;   /**< Raw position of the first neutral density filter center. */
   int32_t NDF1CenterPosition;   /**< Raw position of the second neutral density filter center. */
   int32_t NDF2CenterPosition;   /**< Raw position of the third neutral density filter center. */
   uint32_t FlashSettingsFileLength;   /**< Camera flash settings file length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t ActualizationWaitTime1;   /**< Waiting time before first stabilization phase. */
   uint32_t ActualizationStabilizationTime1;   /**< Minimum stabilisation time in first stabilization phase. */
   uint32_t ActualizationTimeout1;   /**< Maximum waiting time during first stabilization phase. */
   uint32_t ActualizationWaitTime2;   /**< Waiting time before second stabilization phase. */
   uint32_t ActualizationStabilizationTime2;   /**< Minimum stabilisation time in second stabilization phase. */
   uint32_t ActualizationTimeout2;   /**< Maximum waiting time during second stabilization phase. */
   uint32_t BPDuration;   /**< Duration of the acquisition. */
   uint32_t DeviceKeyExpirationPOSIXTime;   /**< Device key expiration POSIX time. */
   uint32_t DeviceKeyLow;   /**< Device 64-bit key (LSB). */
   uint32_t DeviceKeyHigh;   /**< Device 64-bit key (MSB). */
   int16_t ActualizationTemperatureTolerance1;   /**< Temperature variation tolerance during the first stabilization phase (prior to placing the ICU in front of the detector). */
   int16_t ActualizationTemperatureTolerance2;   /**< Temperature variation tolerance during the second stabilization phase (prior to acquiring ICU measurements). */
   int16_t DetectorPolarizationVoltage;   /**< Detector photodiodes polarization voltage. */
   uint16_t ICUPulseWidth;   /**< Duration of the command. */
   uint16_t ICUPeriod;   /**< Period of the pulse in repeat mode. */
   uint16_t ICUTransitionDuration;   /**< Duration of the moving state after a newly commanded set point. */
   uint16_t ActualizationNumberOfImagesCoadd;   /**< Number of images to co-add for calibration update. */
   uint16_t NDFClearFOVWidth;   /**< Edge to edge raw distance of clear FOV. */
   uint16_t FWSpeedMax;   /**< Indicates the maximum filter wheel rotation speed in RPM. */
   uint16_t FWEncoderCyclePerTurn;   /**< Number of counts for external encoder. */
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
   uint16_t BPNumSamples;   /**< Number of images to acquire. */
   uint16_t BPNCoadd;   /**< Number of frames to use for average estimation. */
   uint16_t FlashSettingsFileCRC16;   /**< Camera flash settings file CRC-16 */
   uint8_t FileStructureMajorVersion;   /**< Camera flash settings file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Camera flash settings file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Camera flash settings file structure SubMinor Version */
   uint8_t SensorID;   /**< Sensor  ID. */
   uint8_t PixelDataResolution;   /**< Default pixel data resolution. */
   uint8_t ReverseX;   /**< Flip horizontally the image sent by the device. */
   uint8_t ReverseY;   /**< Flip vertically the image sent by the device. */
   uint8_t ICUPresent;   /**< Indicates whether a ICU is installed in the camera. */
   uint8_t ICUMode;   /**< ICU mode. */
   uint8_t ICUCalibPosition;   /**< Direction of the ICU command for calibration position. */
   uint8_t ActualizationEnabled;   /**< Indicates whether the actualization is enabled. */
   uint8_t ActualizationAtPowerOn;   /**< Indicates whether the actualization is performed at power on. */
   uint8_t FWPresent;   /**< Indicates whether a filter wheel is installed in the camera. */
   uint8_t FWNumberOfFilters;   /**< Indicates the number of filters in the camera head filter wheel. */
   uint8_t FWType;   /**< Indicates whether the filter wheel supports  the synchronously rotating mode. */
   uint8_t ActualizationTemperatureSelector;   /**< Indicates which temperature is used for actualization stabilization. */
   uint8_t ActualizationDiscardOffset;   /**< Indicates whether a zero-mean beta correction is applied. */
   uint8_t ExternalMemoryBufferPresent;   /**< Indicates whether an external memory buffer board is installed in the camera. */
   uint8_t NDFPresent;   /**< Indicates whether a neutral density filter fan is installed in the camera. */
   uint8_t NDFNumberOfFilters;   /**< Indicates the number of neutral density filters in the camera head  neutral density filter fan. */
   uint8_t BPDetectionEnabled;   /**< Indicates whether the actualization is enabled. */
   char FileSignature[5];   /**< Camera flash settings file signature */
   char DeviceModelName[21];   /**< Device model name */
};

/**
 * Flash settings data type
 */
typedef struct flashSettingsStruct flashSettings_t;

/**
 * Flash settings global variable declaration
 */
extern flashSettings_t flashSettings;

/* AUTO-CODE END */

IRC_Status_t FlashSettings_Init();
IRC_Status_t FlashSettings_Load(char *filename, fslImmediate_t immediate);
void FlashSettings_SM();
IRC_Status_t FlashSettings_Reset(flashSettings_t *p_flashSettings);

#endif // FLASHSETTINGS_H
