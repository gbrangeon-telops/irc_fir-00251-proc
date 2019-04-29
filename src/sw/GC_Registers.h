/**
 * @file GC_Registers.h
 * GenICam registers data declaration.
 *
 * This file declares the GenICam registers data.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef GC_REGISTERS_H
#define GC_REGISTERS_H

#include "IRC_Status.h"
#include "GenICam.h"
#include "GC_Manager.h"
#include "utils.h"
#include <stdint.h>

/*
 * Sensor code (based on firmware minor version number definition)
 */
#define Isc0207ASensor     1
#define HawkASensor        2
#define HerculesDSensor    3
#define PelicanDSensor     4
#define MarsASensor        5
#define JupiterASensor     6
#define ScorpiolwDSensor   7
#define MarsDSensor        8
#define ScorpiomwDSensor   9
// ScorpiolwD_230HzSensor is not defined since it's using ScorpiomwDSensor
#define Isc0209ASensor     11
#define ScorpiomwASensor   12

/*
 * TDCStatus register bit field definition
 */
#define WaitingForCoolerMask                    0x00000001  /**< TDCStatus register bit mask for WaitingForCooler field */
#define WaitingForSensorMask                    0x00000002  /**< TDCStatus register bit mask for WaitingForSensor field */
#define WaitingForInitMask                      0x00000004  /**< TDCStatus register bit mask for WaitingForInit field */
// #define WaitingForCameraLinkMask                0x00000008  /**< TDCStatus register bit mask for WaitingForCameraLink field */
#define WaitingForICUMask                       0x00000010  /**< TDCStatus register bit mask for WaitingForICU field */
#define WaitingForNDFilterMask                  0x00000020  /**< TDCStatus register bit mask for WaitingForNDFilter field */
#define WaitingForCalibrationInitMask           0x00000040  /**< TDCStatus register bit mask for WaitingForCalibrationInit field */
#define WaitingForFilterWheelMask               0x00000080  /**< TDCStatus register bit mask for WaitingForFilterWheel field */
#define WaitingForArmMask                       0x00000100  /**< TDCStatus register bit mask for WaitingForArm field */
#define WaitingForValidParametersMask           0x00000200  /**< TDCStatus register bit mask for WaitingForValidParameters field */
#define AcquisitionStartedMask                  0x00000400  /**< TDCStatus register bit mask for AcquisitionStarted field */
// #define WaitingForSCDCmdAckMask                 0x00000800  /**< TDCStatus register bit mask for WaitingForSCDCmdAck field */
#define WaitingForCalibrationDataMask           0x00001000  /**< TDCStatus register bit mask for WaitingForCalibrationData field */
#define WaitingForImageCorrectionMask           0x00002000  /**< TDCStatus register bit mask for WaitingForImageCorrection field */
#define WaitingForOutputFPGAMask                0x00004000  /**< TDCStatus register bit mask for WaitingForOutputFPGA field */
#define WaitingForPowerMask                     0x00008000  /**< TDCStatus register bit mask for WaitingForPower field */
#define WaitingForFlashSettingsInitMask         0x00010000  /**< TDCStatus register bit mask for WaitingForFlashSettingsInit field */

#define TDC_STATUS_INIT                         (WaitingForCoolerMask | WaitingForInitMask | WaitingForCalibrationInitMask | WaitingForArmMask | \
                                                WaitingForOutputFPGAMask | WaitingForFlashSettingsInitMask)

#define TDCStatusSet(mask) BitMaskSet(gcRegsData.TDCStatus, mask)  /**< Set masked bits in TDCStatus register */
#define TDCStatusClr(mask) BitMaskClr(gcRegsData.TDCStatus, mask)  /**< Clear masked bits in TDCStatus register */
#define TDCStatusTst(mask) BitMaskTst(gcRegsData.TDCStatus, mask)  /**< Test if masked bits in TDCStatus register are all set */
#define TDCStatusTstAny(mask) BitMaskTstAny(gcRegsData.TDCStatus, mask)  /**< Test if at least one of the masked bits in TDCStatus register is set */

#define GC_AcquisitionStarted TDCStatusTst(AcquisitionStartedMask)

/*
 * AvailabilityFlags register bit field definition
 */
#define DiscreteExposureTimeIsAvailableMask     0x00000001  /**< AvailabilityFlags register bit mask for DiscreteExposureTimeIsAvailable field */
#define CalibrationIsAvailableMask              0x00000002  /**< AvailabilityFlags register bit mask for CalibrationIsAvailable field */
#define Raw0IsAvailableMask                     0x00000004  /**< AvailabilityFlags register bit mask for Raw0IsAvailable field */
#define RawIsAvailableMask                      0x00000008  /**< AvailabilityFlags register bit mask for RawIsAvailable field */
#define NUCIsAvailableMask                      0x00000010  /**< AvailabilityFlags register bit mask for NUCIsAvailable field */
#define RTIsAvailableMask                       0x00000020  /**< AvailabilityFlags register bit mask for RTIsAvailable field */
#define IBRIsAvailableMask                      0x00000040  /**< AvailabilityFlags register bit mask for IBRIsAvailable field */
#define IBIIsAvailableMask                      0x00000080  /**< AvailabilityFlags register bit mask for CalibrationIsAvailable field */
#define AECPlusIsAvailableMask                  0x00000100  /**< AvailabilityFlags register bit mask for AECPlusIsAvailable field */
#define NDFilter1IsAvailableMask                0x00000200  /**< AvailabilityFlags register bit mask for NDFilter1IsAvailable field */
#define NDFilter2IsAvailableMask                0x00000400  /**< AvailabilityFlags register bit mask for NDFilter2IsAvailable field */
#define NDFilter3IsAvailableMask                0x00000800  /**< AvailabilityFlags register bit mask for NDFilter3IsAvailable field */
#define ManufacturerTestImageIsAvailableMask    0x00001000  /**< AvailabilityFlags register bit mask for ManufacturerTestImageIsAvailable field */
#define ExternalFanControlIsAvailableMask       0x00002000  /**< AvailabilityFlags register bit mask for ExternalFanControlIsAvailable field */

#define AvailabilityFlagsSet(mask) BitMaskSet(gcRegsData.AvailabilityFlags, mask)  /**< Set masked bits in AvailabilityFlags register */
#define AvailabilityFlagsClr(mask) BitMaskClr(gcRegsData.AvailabilityFlags, mask)  /**< Clear masked bits in AvailabilityFlags register */
#define AvailabilityFlagsTst(mask) BitMaskTst(gcRegsData.AvailabilityFlags, mask)  /**< Test if masked bits in AvailabilityFlags register are all set */
#define AvailabilityFlagsTstAny(mask) BitMaskTstAny(gcRegsData.AvailabilityFlags, mask)  /**< Test if at least one of the masked bits in AvailabilityFlags register is set */

/*
 * IsActiveFlags register bit field definition
 */
#define AcquisitionStartTriggerIsActiveMask     0x00000001  /**< IsActiveFlags register bit mask for AcquisitionStartTriggerIsActive field */
#define FlaggingTriggerIsActiveMask             0x00000002  /**< IsActiveFlags register bit mask for FlaggingTriggerIsActive field */
#define GatingTriggerIsActiveMask               0x00000004  /**< IsActiveFlags register bit mask for GatingTriggerIsActive field */
#define AutofocusIsActiveMask                   0x00000008  /**< IsActiveFlags register bit mask for AutofocusIsActive field */

#define IsActiveFlagsSet(mask) BitMaskSet(gcRegsData.IsActiveFlags, mask)  /**< Set masked bits in IsActiveFlags register */
#define IsActiveFlagsClr(mask) BitMaskClr(gcRegsData.IsActiveFlags, mask)  /**< Clear masked bits in IsActiveFlags register */
#define IsActiveFlagsTst(mask) BitMaskTst(gcRegsData.IsActiveFlags, mask)  /**< Test if masked bits in IsActiveFlags register are all set */
#define IsActiveFlagsTstAny(mask) BitMaskTstAny(gcRegsData.IsActiveFlags, mask)  /**< Test if at least one of the masked bits in IsActiveFlags register is set */

/*
 * TDCFlags register bit field definition
 */
#define ITRIsImplementedMask                             0x00000001  /**< TDCFlags register bit mask for ITRIsImplemented field */
#define IWRIsImplementedMask                             0x00000002  /**< TDCFlags register bit mask for IWRIsImplemented field */
#define ClBaseIsImplementedMask                          0x00000004  /**< TDCFlags register bit mask for ClBaseIsImplemented field */
#define ClFullIsImplementedMask                          0x00000008  /**< TDCFlags register bit mask for ClFullIsImplemented field */
#define ImageCorrectionIsImplementedMask                 0x00000010  /**< TDCFlags register bit mask for ImageCorrectionIsImplemented field */
#define HighGainSWDIsImplementedMask                     0x00000020  /**< TDCFlags register bit mask for HighGainSWDIsImplemented field */
#define ICUIsImplementedMask                             0x00000040  /**< TDCFlags register bit mask for ICUIsImplemented field */
#define NDFilterIsImplementedMask                        0x00000080  /**< TDCFlags register bit mask for NDFilterIsImplemented field */
#define FWIsImplementedMask                              0x00000100  /**< TDCFlags register bit mask for FWIsImplemented field */
#define FWAsynchronouslyRotatingModeIsImplementedMask    0x00000200  /**< TDCFlags register bit mask for FWAsynchronouslyRotatingModeIsImplemented field */
#define FWSynchronouslyRotatingModeIsImplementedMask     0x00000400  /**< TDCFlags register bit mask for FWSynchronouslyRotatingModeIsImplemented field */
#define AECPlusIsImplementedMask                         0x00000800  /**< TDCFlags register bit mask for AECPlusIsImplemented field */
#define ExternalMemoryBufferIsImplementedMask            0x00001000  /**< TDCFlags register bit mask for ExternalMemoryBufferIsImplemented field */
#define ExternalZeroMeanBetaCorrectionIsImplementedMask  0x00002000  /**< TDCFlags register bit mask for ExternalZeroMeanBetaCorrectionIsImplemented field */
#define ADCReadoutIsImplementedMask                      0x00004000  /**< TDCFlags register bit mask for ADCReadoutIsImplemented field */
#define MotorizedFOVLensIsImplementedMask                0x00008000  /**< TDCFlags register bit mask for MotorizedFOVLensIsImplemented field */
#define MotorizedFocusLensIsImplementedMask              0x00010000  /**< TDCFlags register bit mask for MotorizedFocusLensIsImplemented field */
#define AutofocusIsImplementedMask                       0x00020000  /**< TDCFlags register bit mask for AutofocusIsImplemented field */
#define ClDualBaseIsImplementedMask                      0x00040000  /**< TDCFlags register bit mask for ClDualBaseIsImplementedMask field */
#define SaveConfigurationIsImplementedMask               0x00080000  /**< TDCFlags register bit mask for SaveConfigurationIsImplementedMask field */
#define SensorIsImplementedMask                          0xF8000000  /**< TDCFlags register bit mask for SensorIsImplemented field */
#define SensorIsImplementedBitPos                        27          /**< TDCFlags register bit position for SensorIsImplemented field */

#define SensorIsImplemented(sensorCode)   ((sensorCode << SensorIsImplementedBitPos) & SensorIsImplementedMask)

#define Isc0207AIsImplemented          SensorIsImplemented(Isc0207ASensor)
#define HawkAIsImplemented             SensorIsImplemented(HawkASensor)
#define HerculesDIsImplemented         SensorIsImplemented(HerculesDSensor)
#define PelicanDIsImplemented          SensorIsImplemented(PelicanDSensor)
#define MarsAIsImplemented             SensorIsImplemented(MarsASensor)
#define JupiterAIsImplemented          SensorIsImplemented(JupiterASensor)
#define ScorpiolwDIsImplemented        SensorIsImplemented(ScorpiolwDSensor)
#define MarsDIsImplemented             SensorIsImplemented(MarsDSensor)
#define ScorpiomwDIsImplemented        SensorIsImplemented(ScorpiomwDSensor)
#define Isc0209AIsImplemented          SensorIsImplemented(Isc0209ASensor)
#define ScorpiomwAIsImplemented        SensorIsImplemented(ScorpiomwASensor)

#define TDCFlagsSet(mask) BitMaskSet(gcRegsData.TDCFlags, mask)  /**< Set masked bits in TDCFlags register */
#define TDCFlagsClr(mask) BitMaskClr(gcRegsData.TDCFlags, mask)  /**< Clear masked bits in TDCFlags register */
#define TDCFlagsTst(mask) BitMaskTst(gcRegsData.TDCFlags, mask)  /**< Test if masked bits in TDCFlags register are all set */
#define TDCFlagsTstAny(mask) BitMaskTstAny(gcRegsData.TDCFlags, mask)  /**< Test if at least one of the masked bits in TDCFlags register is set */

// EHDRINumberOfExposures must be greater than one and filter wheel mode must be set to fixed to activate EHDRI
#define EHDRIIsActive ((gcRegsData.EHDRINumberOfExposures > 1) && (gcRegsData.FWMode == FWM_Fixed))

// EHDRINumberOfExposures must equal one and filter wheel mode must be set to synchronously rotating to activate filter wheel synchronously rotating mode
#define FWSynchronoulyRotatingModeIsActive ((gcRegsData.EHDRINumberOfExposures == 1) && (gcRegsData.FWMode == FWM_SynchronouslyRotating))

extern uint8_t gGC_RegistersStreaming;
extern uint8_t gGC_ProprietaryFeatureKeyIsValid;

/* AUTO-CODE BEGIN */
// Auto-generated GeniCam library.
// Generated from XML camera definition file version 12.4.0
// using generateGenICamCLib.m Matlab script.

#if ((GC_XMLMAJORVERSION != 12) || (GC_XMLMINORVERSION != 4) || (GC_XMLSUBMINORVERSION != 0))
#error "XML version mismatch."
#endif

// Registers data structure and data type
////////////////////////////////////////////////////////////////////////////////

/**
 * Registers data structure
 */
struct gcRegistersDataStruct {
   float AECImageFraction;
   float AECPlusExtrapolationWeight;
   float AECResponseTime;
   float AECTargetWellFilling;
   float AcquisitionFrameRate;
   float AcquisitionFrameRateMax;
   float AcquisitionFrameRateMaxFG;
   float AcquisitionFrameRateMin;
   float AutofocusROI;
   float DeviceClockFrequency;
   float DeviceCurrent;
   float DeviceDetectorElectricalRefOffset;
   float DeviceDetectorElectricalTapsRef;
   float DeviceDetectorPolarizationVoltage;
   float DeviceTemperature;
   float DeviceVoltage;
   float EHDRIExpectedTemperatureMax;
   float EHDRIExpectedTemperatureMaxMin;
   float EHDRIExpectedTemperatureMin;
   float EHDRIExpectedTemperatureMinMax;
   float EHDRIExposureOccurrence1;
   float EHDRIExposureOccurrence2;
   float EHDRIExposureOccurrence3;
   float EHDRIExposureOccurrence4;
   float ExposureTime;
   float ExposureTime1;
   float ExposureTime2;
   float ExposureTime3;
   float ExposureTime4;
   float ExposureTime5;
   float ExposureTime6;
   float ExposureTime7;
   float ExposureTime8;
   float ExposureTimeMax;
   float ExposureTimeMin;
   float ExternalBlackBodyTemperature;
   float ExternalFanSpeed;
   float ExternalFanSpeedSetpoint;
   float HFOV;
   float ImageCorrectionFWAcquisitionFrameRate;
   float ImageCorrectionFWAcquisitionFrameRateMax;
   float ImageCorrectionFWAcquisitionFrameRateMin;
   float MemoryBufferSequenceDownloadBitRateMax;
   float TriggerDelay;
   float VFOV;
   int32_t DeviceFirmwareModuleRevision;
   int32_t FOVPositionRaw;
   int32_t FOVPositionRawMax;
   int32_t FOVPositionRawMin;
   int32_t FOVPositionRawSetpoint;
   int32_t FWPositionRaw;
   int32_t FWPositionRawSetpoint;
   int32_t FocusPositionRaw;
   int32_t FocusPositionRawMax;
   int32_t FocusPositionRawMin;
   int32_t FocusPositionRawSetpoint;
   int32_t GPSAltitude;
   int32_t GPSLatitude;
   int32_t GPSLongitude;
   int32_t NDFilterPositionRaw;
   int32_t NDFilterPositionRawSetpoint;
   uint32_t AcquisitionArm;
   uint32_t AcquisitionFrameRateMode;
   uint32_t AcquisitionFrameRateSetToMax;
   uint32_t AcquisitionMode;
   uint32_t AcquisitionStart;
   uint32_t AcquisitionStartAtStartup;
   uint32_t AcquisitionStop;
   uint32_t Autofocus;
   uint32_t AutofocusMode;
   uint32_t AutomaticExternalFanSpeedMode;
   uint32_t AvailabilityFlags;
   uint32_t BadPixelReplacement;
   uint32_t CalibrationCollectionActiveBlockPOSIXTime;
   uint32_t CalibrationCollectionActivePOSIXTime;
   uint32_t CalibrationCollectionActiveType;
   uint32_t CalibrationCollectionBlockCount;
   uint32_t CalibrationCollectionBlockLoad;
   uint32_t CalibrationCollectionBlockPOSIXTime;
   uint32_t CalibrationCollectionBlockSelector;
   uint32_t CalibrationCollectionCount;
   uint32_t CalibrationCollectionLoad;
   uint32_t CalibrationCollectionPOSIXTime;
   uint32_t CalibrationCollectionSelector;
   uint32_t CalibrationCollectionType;
   uint32_t CalibrationMode;
   uint32_t CenterImage;
   uint32_t ClConfiguration;
   uint32_t DeviceBuiltInTestsResults1;
   uint32_t DeviceBuiltInTestsResults2;
   uint32_t DeviceBuiltInTestsResults3;
   uint32_t DeviceBuiltInTestsResults4;
   uint32_t DeviceBuiltInTestsResults7;
   uint32_t DeviceBuiltInTestsResults8;
   uint32_t DeviceClockSelector;
   uint32_t DeviceCoolerPowerOnCycles;
   uint32_t DeviceCoolerRunningTime;
   uint32_t DeviceCurrentSelector;
   uint32_t DeviceFirmwareBuildVersion;
   uint32_t DeviceFirmwareMajorVersion;
   uint32_t DeviceFirmwareMinorVersion;
   uint32_t DeviceFirmwareModuleSelector;
   uint32_t DeviceFirmwareSubMinorVersion;
   uint32_t DeviceKeyValidationHigh;
   uint32_t DeviceKeyValidationLow;
   uint32_t DeviceLedIndicatorState;
   uint32_t DeviceNotReady;
   uint32_t DevicePowerOnCycles;
   uint32_t DevicePowerState;
   uint32_t DevicePowerStateSetpoint;
   uint32_t DeviceRegistersCheck;
   uint32_t DeviceRegistersStreamingEnd;
   uint32_t DeviceRegistersStreamingStart;
   uint32_t DeviceRegistersValid;
   uint32_t DeviceReset;
   uint32_t DeviceRunningTime;
   uint32_t DeviceSerialNumber;
   uint32_t DeviceSerialPortBaudRate;
   uint32_t DeviceSerialPortFunction;
   uint32_t DeviceSerialPortSelector;
   uint32_t DeviceTemperatureSelector;
   uint32_t DeviceVoltageSelector;
   uint32_t DeviceXMLMajorVersion;
   uint32_t DeviceXMLMinorVersion;
   uint32_t DeviceXMLSubMinorVersion;
   uint32_t EHDRIMode;
   uint32_t EHDRINumberOfExposures;
   uint32_t EHDRIResetToDefault;
   uint32_t EventError;
   uint32_t EventErrorCode;
   uint32_t EventErrorTimestamp;
   uint32_t EventNotification;
   uint32_t EventSelector;
   uint32_t EventTelops;
   uint32_t EventTelopsCode;
   uint32_t EventTelopsTimestamp;
   uint32_t ExposureAuto;
   uint32_t ExposureMode;
   uint32_t ExposureTimeSetToMax;
   uint32_t ExposureTimeSetToMin;
   uint32_t ExternalLensSerialNumber;
   uint32_t FOVPosition;
   uint32_t FOVPositionNumber;
   uint32_t FOVPositionSetpoint;
   uint32_t FValSize;
   uint32_t FWFilterNumber;
   uint32_t FWMode;
   uint32_t FWPosition;
   uint32_t FWPositionSetpoint;
   uint32_t FWSpeed;
   uint32_t FWSpeedMax;
   uint32_t FWSpeedSetpoint;
   uint32_t FocusFarFast;
   uint32_t FocusFarSlow;
   uint32_t FocusNearFast;
   uint32_t FocusNearSlow;
   uint32_t GPSModeIndicator;
   uint32_t GPSNumberOfSatellitesInUse;
   uint32_t Height;
   uint32_t HeightInc;
   uint32_t HeightMax;
   uint32_t HeightMin;
   uint32_t ICUPosition;
   uint32_t ICUPositionSetpoint;
   uint32_t ImageCorrection;
   uint32_t ImageCorrectionBlockSelector;
   uint32_t ImageCorrectionFWMode;
   uint32_t ImageCorrectionMode;
   uint32_t IntegrationMode;
   uint32_t IsActiveFlags;
   uint32_t LoadSavedConfigurationAtStartup;
   uint32_t LockedCenterImage;
   uint32_t ManualFilterSerialNumber;
   uint32_t MemoryBufferAvailableFreeSpaceHigh;
   uint32_t MemoryBufferAvailableFreeSpaceLow;
   uint32_t MemoryBufferFragmentedFreeSpaceHigh;
   uint32_t MemoryBufferFragmentedFreeSpaceLow;
   uint32_t MemoryBufferLegacyMode;
   uint32_t MemoryBufferMOIActivation;
   uint32_t MemoryBufferMOISoftware;
   uint32_t MemoryBufferMOISource;
   uint32_t MemoryBufferMode;
   uint32_t MemoryBufferNumberOfImagesMax;
   uint32_t MemoryBufferNumberOfSequences;
   uint32_t MemoryBufferNumberOfSequencesMax;
   uint32_t MemoryBufferSequenceClear;
   uint32_t MemoryBufferSequenceClearAll;
   uint32_t MemoryBufferSequenceCount;
   uint32_t MemoryBufferSequenceDefrag;
   uint32_t MemoryBufferSequenceDownloadFrameCount;
   uint32_t MemoryBufferSequenceDownloadFrameID;
   uint32_t MemoryBufferSequenceDownloadImageFrameID;
   uint32_t MemoryBufferSequenceDownloadMode;
   uint32_t MemoryBufferSequenceFirstFrameID;
   uint32_t MemoryBufferSequenceHeight;
   uint32_t MemoryBufferSequenceMOIFrameID;
   uint32_t MemoryBufferSequenceOffsetX;
   uint32_t MemoryBufferSequenceOffsetY;
   uint32_t MemoryBufferSequencePreMOISize;
   uint32_t MemoryBufferSequenceRecordedSize;
   uint32_t MemoryBufferSequenceSelector;
   uint32_t MemoryBufferSequenceSize;
   uint32_t MemoryBufferSequenceSizeInc;
   uint32_t MemoryBufferSequenceSizeMax;
   uint32_t MemoryBufferSequenceSizeMin;
   uint32_t MemoryBufferSequenceWidth;
   uint32_t MemoryBufferStatus;
   uint32_t MemoryBufferTotalSpaceHigh;
   uint32_t MemoryBufferTotalSpaceLow;
   uint32_t NDFilterArmedPositionSetpoint;
   uint32_t NDFilterNumber;
   uint32_t NDFilterPosition;
   uint32_t NDFilterPositionSetpoint;
   uint32_t OffsetX;
   uint32_t OffsetXInc;
   uint32_t OffsetXMax;
   uint32_t OffsetXMin;
   uint32_t OffsetY;
   uint32_t OffsetYInc;
   uint32_t OffsetYMax;
   uint32_t OffsetYMin;
   uint32_t POSIXTime;
   uint32_t PixelDataResolution;
   uint32_t PixelFormat;
   uint32_t PowerOnAtStartup;
   uint32_t ProprietaryFeature;
   uint32_t ReverseX;
   uint32_t ReverseY;
   uint32_t SaveConfiguration;
   uint32_t SensorHeight;
   uint32_t SensorID;
   uint32_t SensorWellDepth;
   uint32_t SensorWidth;
   uint32_t StealthMode;
   uint32_t SubSecondTime;
   uint32_t TDCFlags;
   uint32_t TDCStatus;
   uint32_t TestImageSelector;
   uint32_t TimeSource;
   uint32_t TriggerActivation;
   uint32_t TriggerFrameCount;
   uint32_t TriggerMode;
   uint32_t TriggerSelector;
   uint32_t TriggerSoftware;
   uint32_t TriggerSource;
   uint32_t VideoAGC;
   uint32_t VideoBadPixelReplacement;
   uint32_t VideoEHDRIExposureIndex;
   uint32_t VideoFWPosition;
   uint32_t VideoFreeze;
   uint32_t Width;
   uint32_t WidthInc;
   uint32_t WidthMax;
   uint32_t WidthMin;
   uint32_t ZoomInFast;
   uint32_t ZoomInSlow;
   uint32_t ZoomOutFast;
   uint32_t ZoomOutSlow;
   char DeviceID[17];
   char DeviceManufacturerInfo[49];
   char DeviceModelName[33];
   char DeviceVendorName[33];
   char DeviceVersion[33];
   char GevFirstURL[GC_GEVFIRSTURL_DATA_LENGTH];
   char GevSecondURL[1];
};

/**
 * Registers data type
 */
typedef struct gcRegistersDataStruct gcRegistersData_t;

// GenICam global variables declaration
////////////////////////////////////////////////////////////////////////////////

extern gcRegistersData_t gcRegsDataFactory;

extern gcRegistersData_t gcRegsData;

#define gcSelectedRegListLen 13
extern gcSelectedReg_t gcSelectedRegList[gcSelectedRegListLen];

#define DeviceClockFrequencyAryLen 3
extern float DeviceClockFrequencyAry[DeviceClockFrequencyAryLen];

#define DeviceTemperatureAryLen 13
extern float DeviceTemperatureAry[DeviceTemperatureAryLen];

#define DeviceVoltageAryLen 31
extern float DeviceVoltageAry[DeviceVoltageAryLen];

#define DeviceCurrentAryLen 2
extern float DeviceCurrentAry[DeviceCurrentAryLen];

#define DeviceSerialPortBaudRateAryLen 3
extern uint32_t DeviceSerialPortBaudRateAry[DeviceSerialPortBaudRateAryLen];

#define DeviceSerialPortFunctionAryLen 3
extern uint32_t DeviceSerialPortFunctionAry[DeviceSerialPortFunctionAryLen];

#define EventNotificationAryLen 33
extern uint32_t EventNotificationAry[EventNotificationAryLen];

#define DeviceFirmwareModuleRevisionAryLen 12
extern int32_t DeviceFirmwareModuleRevisionAry[DeviceFirmwareModuleRevisionAryLen];

#define TriggerModeAryLen 3
extern uint32_t TriggerModeAry[TriggerModeAryLen];

#define TriggerSourceAryLen 3
extern uint32_t TriggerSourceAry[TriggerSourceAryLen];

#define TriggerActivationAryLen 3
extern uint32_t TriggerActivationAry[TriggerActivationAryLen];

#define TriggerDelayAryLen 3
extern float TriggerDelayAry[TriggerDelayAryLen];

#define TriggerFrameCountAryLen 3
extern uint32_t TriggerFrameCountAry[TriggerFrameCountAryLen];

// Shared registers write macros
////////////////////////////////////////////////////////////////////////////////

#define GC_SetWidth(val) GC_RegisterWriteUI32(&gcRegsDef[WidthIdx], val)
#define GC_SetHeight(val) GC_RegisterWriteUI32(&gcRegsDef[HeightIdx], val + 2)
#define GC_SetAcquisitionStart(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionStartIdx], val)
#define GC_SetAcquisitionStop(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionStopIdx], val)
#define GC_SetAcquisitionArm(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionArmIdx], val)
#define GC_SetAcquisitionFrameRate(val) GC_RegisterWriteFloat(&gcRegsDef[AcquisitionFrameRateIdx], val)
#define GC_SetAcquisitionFrameRateMode(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionFrameRateModeIdx], val)
#define GC_SetCalibrationMode(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationModeIdx], val)
#define GC_SetOffsetX(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetXIdx], val)
#define GC_SetOffsetY(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetYIdx], val)
#define GC_SetReverseX(val) GC_RegisterWriteUI32(&gcRegsDef[ReverseXIdx], val)
#define GC_SetReverseY(val) GC_RegisterWriteUI32(&gcRegsDef[ReverseYIdx], val)
#define GC_SetMemoryBufferMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferModeIdx], val)
#define GC_SetMemoryBufferLegacyMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferLegacyModeIdx], val)
#define GC_SetMemoryBufferStatus(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferStatusIdx], val)
#define GC_SetMemoryBufferMOISource(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferMOISourceIdx], val)
#define GC_SetMemoryBufferMOIActivation(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferMOIActivationIdx], val)
#define GC_SetMemoryBufferSequenceCount(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceCountIdx], val)
#define GC_SetMemoryBufferSequenceDownloadMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDownloadModeIdx], val)
#define GC_SetVideoAGC(val) GC_RegisterWriteUI32(&gcRegsDef[VideoAGCIdx], val)
#define GC_SetVideoFreeze(val) GC_RegisterWriteUI32(&gcRegsDef[VideoFreezeIdx], val)
#define GC_SetSensorWidth(val) GC_RegisterWriteUI32(&gcRegsDef[SensorWidthIdx], val)
#define GC_SetSensorHeight(val) GC_RegisterWriteUI32(&gcRegsDef[SensorHeightIdx], val)
#define GC_SetEventSelector(val) GC_RegisterWriteUI32(&gcRegsDef[EventSelectorIdx], val)
#define GC_SetEventNotification(val) GC_RegisterWriteUI32(&gcRegsDef[EventNotificationIdx], val)
#define GC_SetEventError(val) GC_RegisterWriteUI32(&gcRegsDef[EventErrorIdx], val)
#define GC_SetEventErrorTimestamp(val) GC_RegisterWriteUI32(&gcRegsDef[EventErrorTimestampIdx], val)
#define GC_SetEventErrorCode(val) GC_RegisterWriteUI32(&gcRegsDef[EventErrorCodeIdx], val)
#define GC_SetEventTelops(val) GC_RegisterWriteUI32(&gcRegsDef[EventTelopsIdx], val)
#define GC_SetEventTelopsTimestamp(val) GC_RegisterWriteUI32(&gcRegsDef[EventTelopsTimestampIdx], val)
#define GC_SetEventTelopsCode(val) GC_RegisterWriteUI32(&gcRegsDef[EventTelopsCodeIdx], val)
#define GC_SetClConfiguration(val) GC_RegisterWriteUI32(&gcRegsDef[ClConfigurationIdx], val)
#define GC_SetDeviceFirmwareModuleSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareModuleSelectorIdx], val)
#define GC_SetDeviceFirmwareModuleRevision(val) GC_RegisterWriteI32(&gcRegsDef[DeviceFirmwareModuleRevisionIdx], val)
#define GC_SetDeviceTemperatureSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceTemperatureSelectorIdx], val)
#define GC_SetDeviceTemperature(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceTemperatureIdx], val)
#define GC_SetDeviceClockSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceClockSelectorIdx], val)
#define GC_SetDeviceClockFrequency(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceClockFrequencyIdx], val)
#define GC_SetDeviceVoltageSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceVoltageSelectorIdx], val)
#define GC_SetDeviceVoltage(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceVoltageIdx], val)
#define GC_SetIsActiveFlags(val) GC_RegisterWriteUI32(&gcRegsDef[IsActiveFlagsIdx], val)

// Locked registers utility macros
////////////////////////////////////////////////////////////////////////////////
#define GC_AECIsActive ((gcRegsData.ExposureAuto == EA_Once) || (gcRegsData.ExposureAuto == EA_Continuous))
#define GC_AECPlusIsActive (GC_AECPlusIsImplemented && ((gcRegsData.ExposureAuto == EA_OnceNDFilter) || (gcRegsData.ExposureAuto == EA_ContinuousNDFilter) || (gcRegsData.ExposureAuto == EA_ArmedNDFilter)))
#define GC_AECPlusIsImplemented TDCFlagsTst(AECPlusIsImplementedMask)
#define GC_AcquisitionFrameRateIsLocked ((GC_AcquisitionStarted && (gcRegsData.AcquisitionFrameRateMode == AFRM_FixedLocked)) || GC_WaitingForImageCorrection)
#define GC_AcquisitionStartTriggerIsActive IsActiveFlagsTst(AcquisitionStartTriggerIsActiveMask)
#define GC_AcquisitionStartTriggerIsLocked ((gcRegsData.TriggerSelector == TS_AcquisitionStart) && (GC_FWSynchronouslyRotatingModeIsActive || GC_GatingTriggerIsActive))
#define GC_AutofocusIsActive IsActiveFlagsTst(AutofocusIsActiveMask)
#define GC_CalibrationCollectionTypeFOVIsActive ((gcRegsData.CalibrationCollectionActiveType == CCAT_TelopsFOV) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointFOV))
#define GC_CalibrationCollectionTypeFWIsActive ((gcRegsData.CalibrationCollectionActiveType == CCAT_TelopsFW) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointFW))
#define GC_CalibrationCollectionTypeMultipointIsActive ((gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointFixed) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointEHDRI) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointFW) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointNDF) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointFOV))
#define GC_CalibrationCollectionTypeNDFIsActive ((gcRegsData.CalibrationCollectionActiveType == CCAT_TelopsNDF) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointNDF))
#define GC_CalibrationIsActive ((gcRegsData.CalibrationMode != CM_Raw0) && (gcRegsData.CalibrationMode != CM_Raw))
#define GC_DiscreteExposureTimeIsAvailable AvailabilityFlagsTst(DiscreteExposureTimeIsAvailableMask)
#define GC_EHDRIAdvancedSettingsAreLocked (gcRegsData.EHDRIMode == EHDRIM_Simple)
#define GC_EHDRIExposureTimeIsLocked (GC_ExposureTimeIsLocked || (GC_EHDRIIsActive && (GC_AcquisitionStarted || GC_EHDRIAdvancedSettingsAreLocked)))
#define GC_EHDRIIsActive (gcRegsData.EHDRINumberOfExposures > 1)
#define GC_EHDRISimpleSettingsAreLocked (gcRegsData.EHDRIMode == EHDRIM_Advanced)
#define GC_ExposureTimeIsLocked (GC_AECIsActive || GC_AECPlusIsActive || GC_DiscreteExposureTimeIsAvailable || (GC_CalibrationIsActive && GC_CalibrationCollectionTypeMultipointIsActive) || GC_WaitingForImageCorrection || GC_AutofocusIsActive)
#define GC_ExternalMemoryBufferIsImplemented TDCFlagsTst(ExternalMemoryBufferIsImplementedMask)
#define GC_FWAsynchronouslyRotatingModeIsActive (GC_FWAsynchronouslyRotatingModeIsImplemented && (gcRegsData.FWMode == FWM_AsynchronouslyRotating))
#define GC_FWAsynchronouslyRotatingModeIsImplemented (GC_FWIsImplemented && TDCFlagsTst(FWAsynchronouslyRotatingModeIsImplementedMask))
#define GC_FWFixedModeIsActive (gcRegsData.FWMode == FWM_Fixed)
#define GC_FWIsImplemented TDCFlagsTst(FWIsImplementedMask)
#define GC_FWRotatingModeIsActive (GC_FWAsynchronouslyRotatingModeIsActive || GC_FWSynchronouslyRotatingModeIsActive)
#define GC_FWSynchronouslyRotatingModeIsActive (GC_FWSynchronouslyRotatingModeIsImplemented && (gcRegsData.FWMode == FWM_SynchronouslyRotating))
#define GC_FWSynchronouslyRotatingModeIsImplemented (GC_FWIsImplemented && TDCFlagsTst(FWSynchronouslyRotatingModeIsImplementedMask))
#define GC_FlaggingTriggerIsActive IsActiveFlagsTst(FlaggingTriggerIsActiveMask)
#define GC_FlaggingTriggerIsLocked ((gcRegsData.TriggerSelector == TS_Flagging) && GC_GatingTriggerIsActive)
#define GC_GatingTriggerIsActive IsActiveFlagsTst(GatingTriggerIsActiveMask)
#define GC_GatingTriggerIsLocked ((gcRegsData.TriggerSelector == TS_Gating) && (GC_FWRotatingModeIsActive || GC_AcquisitionStartTriggerIsActive || GC_FlaggingTriggerIsActive || GC_AECPlusIsActive))
#define GC_MemoryBufferNotEmpty (gcRegsData.MemoryBufferSequenceCount > 0)
#define GC_OffsetIsLocked (gcRegsData.CenterImage || GC_WaitingForImageCorrection)
#define GC_WaitingForImageCorrection TDCStatusTst(WaitingForImageCorrectionMask)

void GC_Registers_Init();

/* AUTO-CODE END */

// AEC+ is available when;
//  - EHDRI is not active.
//  - FW rotating modes are not active.
//  - Gating trigger is not active.
//  - Valid collection is loaded.
//  - Active collection type is TelopsNDF.
//  - FW position is the one that is calibrated.
//  - NDF positions are consecutive. Valid combinations are [NDfilter1 NDfilter2], [NDfilter2 NDfilter3] or
//    [NDfilter1 NDfilter2 NDfilter3] but not [NDfilter1 NDfilter3]. So it must contain NDFilter2 and at least
//    one of the two other positions.
#define GC_AECPlusIsAvailable ( \
   !GC_EHDRIIsActive && \
   !GC_FWRotatingModeIsActive && \
   !GC_GatingTriggerIsActive && \
   (calibrationInfo.isValid == 1) && \
   (calibrationInfo.collection.CollectionType == CCT_TelopsNDF) && \
   ((gcRegsData.FWPositionSetpoint == calibrationInfo.collection.FWPosition) || (gcRegsData.CalibrationMode == CM_Raw) || (gcRegsData.CalibrationMode == CM_Raw0)) && \
   (AvailabilityFlagsTst(NDFilter2IsAvailableMask) && (AvailabilityFlagsTst(NDFilter1IsAvailableMask) || AvailabilityFlagsTst(NDFilter3IsAvailableMask))) \
)
#define GC_UpdateAECPlusIsAvailable() AvailabilityFlagsClr(AECPlusIsAvailableMask); if (GC_AECPlusIsAvailable) AvailabilityFlagsSet(AECPlusIsAvailableMask)

void GC_UpdateLockedFlag();
void GC_CalibrationUpdateRegisters();
void GC_UpdateFpaPeriodMinMargin();
void GC_UpdateParameterLimits();
IRC_Status_t GC_DeviceRegistersVerification();
void GC_ComputeImageLimits();
void GC_SetExternalFanSpeed();
void GC_UpdateMemoryBufferSequenceSizeLimits();
void GC_UpdateMemoryBufferNumberOfSequenceLimits();
void GC_UpdateMemoryBufferSequencePreMOISizeLimits();
void GC_UnlockCamera();
void GC_SetMemoryBufferRegistersOwner();
void GC_SetFWPositionSetpoint(uint32_t prevFWPositionSetpoint, uint32_t newFWPositionSetpoint);
void GC_SetNDFPositionSetpoint(uint32_t prevNDFPositionSetpoint, uint32_t newNDFPositionSetpoint);
uint32_t GC_GetTimestamp();
void GC_UpdateExposureTimeXRegisters(float* p_src, uint32_t len);
void GC_SetExposureTimeRegisters(float exposureTime);
void GC_SetDeviceSerialPortFunction(DeviceSerialPortSelector_t updatedPort);
void GC_UpdateFOV();
void GC_UpdateExposureTimeMin();
void GC_UpdateCameraLinkConfig();

#endif // GC_REGISTERS_H
