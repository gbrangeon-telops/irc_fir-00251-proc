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

#define GC_AcquisitionStarted TDCStatusTst(AcquisitionStartedMask)


// EHDRINumberOfExposures must be greater than one and filter wheel mode must be set to fixed to activate EHDRI
#define EHDRIIsActive ((gcRegsData.EHDRINumberOfExposures > 1) && (gcRegsData.FWMode == FWM_Fixed))

// EHDRINumberOfExposures must equal one and filter wheel mode must be set to synchronously rotating to activate filter wheel synchronously rotating mode
#define FWSynchronoulyRotatingModeIsActive ((gcRegsData.EHDRINumberOfExposures == 1) && (gcRegsData.FWMode == FWM_SynchronouslyRotating))


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
   (((gcRegsData.FWPositionSetpoint == calibrationInfo.collection.FWPosition) || (gcRegsData.CalibrationMode == CM_Raw) || (gcRegsData.CalibrationMode == CM_Raw0))) ||  !GC_FWIsImplemented && \
   (AvailabilityFlagsTst(NDFilter2IsAvailableMask) && (AvailabilityFlagsTst(NDFilter1IsAvailableMask) || AvailabilityFlagsTst(NDFilter3IsAvailableMask))) \
)
#define GC_UpdateAECPlusIsAvailable() AvailabilityFlagsClr(AECPlusIsAvailableMask); if (GC_AECPlusIsAvailable) AvailabilityFlagsSet(AECPlusIsAvailableMask)

extern uint8_t gGC_RegistersStreaming;
extern uint8_t gGC_ProprietaryFeatureKeyIsValid;


/* AUTO-CODE BEGIN */
// Auto-generated GeniCam library.
// Generated from XML camera definition file version 12.5.1
// using generateGenICamCLib.m Matlab script.

#if ((GC_XMLMAJORVERSION != 12) || (GC_XMLMINORVERSION != 5) || (GC_XMLSUBMINORVERSION != 1))
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
#define GC_SetExposureMode(val) GC_RegisterWriteUI32(&gcRegsDef[ExposureModeIdx], val)
#define GC_SetExposureTime(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeIdx], val)
#define GC_SetExposureTime1(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime1Idx], val)
#define GC_SetExposureTime2(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime2Idx], val)
#define GC_SetExposureTime3(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime3Idx], val)
#define GC_SetExposureTime4(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime4Idx], val)
#define GC_SetExposureTime5(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime5Idx], val)
#define GC_SetExposureTime6(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime6Idx], val)
#define GC_SetExposureTime7(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime7Idx], val)
#define GC_SetExposureTime8(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTime8Idx], val)
#define GC_SetExposureTimeSetToMin(val) GC_RegisterWriteUI32(&gcRegsDef[ExposureTimeSetToMinIdx], val)
#define GC_SetExposureTimeSetToMax(val) GC_RegisterWriteUI32(&gcRegsDef[ExposureTimeSetToMaxIdx], val)
#define GC_SetAcquisitionFrameRate(val) GC_RegisterWriteFloat(&gcRegsDef[AcquisitionFrameRateIdx], val)
#define GC_SetAcquisitionFrameRateSetToMax(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionFrameRateSetToMaxIdx], val)
#define GC_SetAcquisitionMode(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionModeIdx], val)
#define GC_SetAcquisitionFrameRateMode(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionFrameRateModeIdx], val)
#define GC_SetLoadSavedConfigurationAtStartup(val) GC_RegisterWriteUI32(&gcRegsDef[LoadSavedConfigurationAtStartupIdx], val)
#define GC_SetSaveConfiguration(val) GC_RegisterWriteUI32(&gcRegsDef[SaveConfigurationIdx], val)
#define GC_SetExposureAuto(val) GC_RegisterWriteUI32(&gcRegsDef[ExposureAutoIdx], val)
#define GC_SetAECImageFraction(val) GC_RegisterWriteFloat(&gcRegsDef[AECImageFractionIdx], val)
#define GC_SetAECTargetWellFilling(val) GC_RegisterWriteFloat(&gcRegsDef[AECTargetWellFillingIdx], val)
#define GC_SetAECResponseTime(val) GC_RegisterWriteFloat(&gcRegsDef[AECResponseTimeIdx], val)
#define GC_SetAECPlusExtrapolationWeight(val) GC_RegisterWriteFloat(&gcRegsDef[AECPlusExtrapolationWeightIdx], val)
#define GC_SetNDFilterArmedPositionSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[NDFilterArmedPositionSetpointIdx], val)
#define GC_SetEHDRIMode(val) GC_RegisterWriteUI32(&gcRegsDef[EHDRIModeIdx], val)
#define GC_SetEHDRIExpectedTemperatureMin(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExpectedTemperatureMinIdx], val)
#define GC_SetEHDRIExpectedTemperatureMinMax(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExpectedTemperatureMinMaxIdx], val)
#define GC_SetEHDRIExpectedTemperatureMax(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExpectedTemperatureMaxIdx], val)
#define GC_SetEHDRIExpectedTemperatureMaxMin(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExpectedTemperatureMaxMinIdx], val)
#define GC_SetEHDRINumberOfExposures(val) GC_RegisterWriteUI32(&gcRegsDef[EHDRINumberOfExposuresIdx], val)
#define GC_SetEHDRIResetToDefault(val) GC_RegisterWriteUI32(&gcRegsDef[EHDRIResetToDefaultIdx], val)
#define GC_SetEHDRIExposureOccurrence1(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExposureOccurrence1Idx], val)
#define GC_SetEHDRIExposureOccurrence2(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExposureOccurrence2Idx], val)
#define GC_SetEHDRIExposureOccurrence3(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExposureOccurrence3Idx], val)
#define GC_SetEHDRIExposureOccurrence4(val) GC_RegisterWriteFloat(&gcRegsDef[EHDRIExposureOccurrence4Idx], val)
#define GC_SetCalibrationMode(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationModeIdx], val)
#define GC_SetCalibrationCollectionCount(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionCountIdx], val)
#define GC_SetCalibrationCollectionSelector(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionSelectorIdx], val)
#define GC_SetCalibrationCollectionPOSIXTime(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionPOSIXTimeIdx], val)
#define GC_SetCalibrationCollectionType(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionTypeIdx], val)
#define GC_SetCalibrationCollectionLoad(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionLoadIdx], val)
#define GC_SetCalibrationCollectionBlockCount(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionBlockCountIdx], val)
#define GC_SetCalibrationCollectionBlockSelector(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionBlockSelectorIdx], val)
#define GC_SetCalibrationCollectionBlockPOSIXTime(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionBlockPOSIXTimeIdx], val)
#define GC_SetCalibrationCollectionBlockLoad(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionBlockLoadIdx], val)
#define GC_SetCalibrationCollectionActivePOSIXTime(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionActivePOSIXTimeIdx], val)
#define GC_SetCalibrationCollectionActiveType(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionActiveTypeIdx], val)
#define GC_SetCalibrationCollectionActiveBlockPOSIXTime(val) GC_RegisterWriteUI32(&gcRegsDef[CalibrationCollectionActiveBlockPOSIXTimeIdx], val)
#define GC_SetImageCorrectionMode(val) GC_RegisterWriteUI32(&gcRegsDef[ImageCorrectionModeIdx], val)
#define GC_SetImageCorrectionBlockSelector(val) GC_RegisterWriteUI32(&gcRegsDef[ImageCorrectionBlockSelectorIdx], val)
#define GC_SetImageCorrectionFWMode(val) GC_RegisterWriteUI32(&gcRegsDef[ImageCorrectionFWModeIdx], val)
#define GC_SetImageCorrectionFWAcquisitionFrameRate(val) GC_RegisterWriteFloat(&gcRegsDef[ImageCorrectionFWAcquisitionFrameRateIdx], val)
#define GC_SetImageCorrection(val) GC_RegisterWriteUI32(&gcRegsDef[ImageCorrectionIdx], val)
#define GC_SetNDFilterPositionSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[NDFilterPositionSetpointIdx], val)
#define GC_SetNDFilterPosition(val) GC_RegisterWriteUI32(&gcRegsDef[NDFilterPositionIdx], val)
#define GC_SetNDFilterNumber(val) GC_RegisterWriteUI32(&gcRegsDef[NDFilterNumberIdx], val)
#define GC_SetNDFilterPositionRawSetpoint(val) GC_RegisterWriteI32(&gcRegsDef[NDFilterPositionRawSetpointIdx], val)
#define GC_SetNDFilterPositionRaw(val) GC_RegisterWriteI32(&gcRegsDef[NDFilterPositionRawIdx], val)
#define GC_SetFWMode(val) GC_RegisterWriteUI32(&gcRegsDef[FWModeIdx], val)
#define GC_SetFWPositionSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[FWPositionSetpointIdx], val)
#define GC_SetFWPosition(val) GC_RegisterWriteUI32(&gcRegsDef[FWPositionIdx], val)
#define GC_SetFWFilterNumber(val) GC_RegisterWriteUI32(&gcRegsDef[FWFilterNumberIdx], val)
#define GC_SetFWPositionRawSetpoint(val) GC_RegisterWriteI32(&gcRegsDef[FWPositionRawSetpointIdx], val)
#define GC_SetFWPositionRaw(val) GC_RegisterWriteI32(&gcRegsDef[FWPositionRawIdx], val)
#define GC_SetFWSpeedSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[FWSpeedSetpointIdx], val)
#define GC_SetFWSpeed(val) GC_RegisterWriteUI32(&gcRegsDef[FWSpeedIdx], val)
#define GC_SetFWSpeedMax(val) GC_RegisterWriteUI32(&gcRegsDef[FWSpeedMaxIdx], val)
#define GC_SetFOVPositionSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[FOVPositionSetpointIdx], val)
#define GC_SetFOVPosition(val) GC_RegisterWriteUI32(&gcRegsDef[FOVPositionIdx], val)
#define GC_SetFOVPositionNumber(val) GC_RegisterWriteUI32(&gcRegsDef[FOVPositionNumberIdx], val)
#define GC_SetZoomInFast(val) GC_RegisterWriteUI32(&gcRegsDef[ZoomInFastIdx], val)
#define GC_SetZoomInSlow(val) GC_RegisterWriteUI32(&gcRegsDef[ZoomInSlowIdx], val)
#define GC_SetZoomOutSlow(val) GC_RegisterWriteUI32(&gcRegsDef[ZoomOutSlowIdx], val)
#define GC_SetZoomOutFast(val) GC_RegisterWriteUI32(&gcRegsDef[ZoomOutFastIdx], val)
#define GC_SetHFOV(val) GC_RegisterWriteFloat(&gcRegsDef[HFOVIdx], val)
#define GC_SetVFOV(val) GC_RegisterWriteFloat(&gcRegsDef[VFOVIdx], val)
#define GC_SetFOVPositionRawSetpoint(val) GC_RegisterWriteI32(&gcRegsDef[FOVPositionRawSetpointIdx], val)
#define GC_SetFOVPositionRaw(val) GC_RegisterWriteI32(&gcRegsDef[FOVPositionRawIdx], val)
#define GC_SetFOVPositionRawMin(val) GC_RegisterWriteI32(&gcRegsDef[FOVPositionRawMinIdx], val)
#define GC_SetFOVPositionRawMax(val) GC_RegisterWriteI32(&gcRegsDef[FOVPositionRawMaxIdx], val)
#define GC_SetAutofocusMode(val) GC_RegisterWriteUI32(&gcRegsDef[AutofocusModeIdx], val)
#define GC_SetAutofocusROI(val) GC_RegisterWriteFloat(&gcRegsDef[AutofocusROIIdx], val)
#define GC_SetAutofocus(val) GC_RegisterWriteUI32(&gcRegsDef[AutofocusIdx], val)
#define GC_SetFocusNearFast(val) GC_RegisterWriteUI32(&gcRegsDef[FocusNearFastIdx], val)
#define GC_SetFocusNearSlow(val) GC_RegisterWriteUI32(&gcRegsDef[FocusNearSlowIdx], val)
#define GC_SetFocusFarSlow(val) GC_RegisterWriteUI32(&gcRegsDef[FocusFarSlowIdx], val)
#define GC_SetFocusFarFast(val) GC_RegisterWriteUI32(&gcRegsDef[FocusFarFastIdx], val)
#define GC_SetFocusPositionRawSetpoint(val) GC_RegisterWriteI32(&gcRegsDef[FocusPositionRawSetpointIdx], val)
#define GC_SetFocusPositionRaw(val) GC_RegisterWriteI32(&gcRegsDef[FocusPositionRawIdx], val)
#define GC_SetFocusPositionRawMin(val) GC_RegisterWriteI32(&gcRegsDef[FocusPositionRawMinIdx], val)
#define GC_SetFocusPositionRawMax(val) GC_RegisterWriteI32(&gcRegsDef[FocusPositionRawMaxIdx], val)
#define GC_SetExternalLensSerialNumber(val) GC_RegisterWriteUI32(&gcRegsDef[ExternalLensSerialNumberIdx], val)
#define GC_SetManualFilterSerialNumber(val) GC_RegisterWriteUI32(&gcRegsDef[ManualFilterSerialNumberIdx], val)
#define GC_SetICUPositionSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[ICUPositionSetpointIdx], val)
#define GC_SetICUPosition(val) GC_RegisterWriteUI32(&gcRegsDef[ICUPositionIdx], val)
#define GC_SetCenterImage(val) GC_RegisterWriteUI32(&gcRegsDef[CenterImageIdx], val)
#define GC_SetLockedCenterImage(val) GC_RegisterWriteUI32(&gcRegsDef[LockedCenterImageIdx], val)
#define GC_SetOffsetX(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetXIdx], val)
#define GC_SetOffsetY(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetYIdx], val)
#define GC_SetReverseX(val) GC_RegisterWriteUI32(&gcRegsDef[ReverseXIdx], val)
#define GC_SetReverseY(val) GC_RegisterWriteUI32(&gcRegsDef[ReverseYIdx], val)
#define GC_SetPixelFormat(val) GC_RegisterWriteUI32(&gcRegsDef[PixelFormatIdx], val)
#define GC_SetTestImageSelector(val) GC_RegisterWriteUI32(&gcRegsDef[TestImageSelectorIdx], val)
#define GC_SetSensorWellDepth(val) GC_RegisterWriteUI32(&gcRegsDef[SensorWellDepthIdx], val)
#define GC_SetIntegrationMode(val) GC_RegisterWriteUI32(&gcRegsDef[IntegrationModeIdx], val)
#define GC_SetAcquisitionStartAtStartup(val) GC_RegisterWriteUI32(&gcRegsDef[AcquisitionStartAtStartupIdx], val)
#define GC_SetExternalBlackBodyTemperature(val) GC_RegisterWriteFloat(&gcRegsDef[ExternalBlackBodyTemperatureIdx], val)
#define GC_SetBadPixelReplacement(val) GC_RegisterWriteUI32(&gcRegsDef[BadPixelReplacementIdx], val)
#define GC_SetTriggerSelector(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerSelectorIdx], val)
#define GC_SetTriggerMode(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerModeIdx], val)
#define GC_SetTriggerSoftware(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerSoftwareIdx], val)
#define GC_SetTriggerSource(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerSourceIdx], val)
#define GC_SetTriggerActivation(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerActivationIdx], val)
#define GC_SetTriggerDelay(val) GC_RegisterWriteFloat(&gcRegsDef[TriggerDelayIdx], val)
#define GC_SetTriggerFrameCount(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerFrameCountIdx], val)
#define GC_SetMemoryBufferMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferModeIdx], val)
#define GC_SetMemoryBufferLegacyMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferLegacyModeIdx], val)
#define GC_SetMemoryBufferStatus(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferStatusIdx], val)
#define GC_SetMemoryBufferAvailableFreeSpaceHigh(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferAvailableFreeSpaceHighIdx], val)
#define GC_SetMemoryBufferAvailableFreeSpaceLow(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferAvailableFreeSpaceLowIdx], val)
#define GC_SetMemoryBufferFragmentedFreeSpaceHigh(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferFragmentedFreeSpaceHighIdx], val)
#define GC_SetMemoryBufferFragmentedFreeSpaceLow(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferFragmentedFreeSpaceLowIdx], val)
#define GC_SetMemoryBufferTotalSpaceHigh(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferTotalSpaceHighIdx], val)
#define GC_SetMemoryBufferTotalSpaceLow(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferTotalSpaceLowIdx], val)
#define GC_SetMemoryBufferNumberOfImagesMax(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferNumberOfImagesMaxIdx], val)
#define GC_SetMemoryBufferNumberOfSequencesMax(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferNumberOfSequencesMaxIdx], val)
#define GC_SetMemoryBufferNumberOfSequences(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferNumberOfSequencesIdx], val)
#define GC_SetMemoryBufferSequenceSize(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceSizeIdx], val)
#define GC_SetMemoryBufferSequenceSizeMin(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceSizeMinIdx], val)
#define GC_SetMemoryBufferSequenceSizeMax(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceSizeMaxIdx], val)
#define GC_SetMemoryBufferSequenceSizeInc(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceSizeIncIdx], val)
#define GC_SetMemoryBufferSequencePreMOISize(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequencePreMOISizeIdx], val)
#define GC_SetMemoryBufferMOISource(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferMOISourceIdx], val)
#define GC_SetMemoryBufferMOIActivation(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferMOIActivationIdx], val)
#define GC_SetMemoryBufferMOISoftware(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferMOISoftwareIdx], val)
#define GC_SetMemoryBufferSequenceCount(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceCountIdx], val)
#define GC_SetMemoryBufferSequenceSelector(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceSelectorIdx], val)
#define GC_SetMemoryBufferSequenceOffsetX(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceOffsetXIdx], val)
#define GC_SetMemoryBufferSequenceOffsetY(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceOffsetYIdx], val)
#define GC_SetMemoryBufferSequenceWidth(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceWidthIdx], val)
#define GC_SetMemoryBufferSequenceHeight(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceHeightIdx], val)
#define GC_SetMemoryBufferSequenceFirstFrameID(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceFirstFrameIDIdx], val)
#define GC_SetMemoryBufferSequenceMOIFrameID(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceMOIFrameIDIdx], val)
#define GC_SetMemoryBufferSequenceRecordedSize(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceRecordedSizeIdx], val)
#define GC_SetMemoryBufferSequenceDownloadImageFrameID(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDownloadImageFrameIDIdx], val)
#define GC_SetMemoryBufferSequenceDownloadFrameID(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDownloadFrameIDIdx], val)
#define GC_SetMemoryBufferSequenceDownloadFrameCount(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDownloadFrameCountIdx], val)
#define GC_SetMemoryBufferSequenceDownloadMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDownloadModeIdx], val)
#define GC_SetMemoryBufferSequenceDownloadBitRateMax(val) GC_RegisterWriteFloat(&gcRegsDef[MemoryBufferSequenceDownloadBitRateMaxIdx], val)
#define GC_SetMemoryBufferSequenceClear(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceClearIdx], val)
#define GC_SetMemoryBufferSequenceClearAll(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceClearAllIdx], val)
#define GC_SetMemoryBufferSequenceDefrag(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDefragIdx], val)
#define GC_SetGPSLongitude(val) GC_RegisterWriteI32(&gcRegsDef[GPSLongitudeIdx], val)
#define GC_SetGPSLatitude(val) GC_RegisterWriteI32(&gcRegsDef[GPSLatitudeIdx], val)
#define GC_SetGPSAltitude(val) GC_RegisterWriteI32(&gcRegsDef[GPSAltitudeIdx], val)
#define GC_SetGPSModeIndicator(val) GC_RegisterWriteUI32(&gcRegsDef[GPSModeIndicatorIdx], val)
#define GC_SetGPSNumberOfSatellitesInUse(val) GC_RegisterWriteUI32(&gcRegsDef[GPSNumberOfSatellitesInUseIdx], val)
#define GC_SetAutomaticExternalFanSpeedMode(val) GC_RegisterWriteUI32(&gcRegsDef[AutomaticExternalFanSpeedModeIdx], val)
#define GC_SetExternalFanSpeedSetpoint(val) GC_RegisterWriteFloat(&gcRegsDef[ExternalFanSpeedSetpointIdx], val)
#define GC_SetExternalFanSpeed(val) GC_RegisterWriteFloat(&gcRegsDef[ExternalFanSpeedIdx], val)
#define GC_SetTimeSource(val) GC_RegisterWriteUI32(&gcRegsDef[TimeSourceIdx], val)
#define GC_SetPOSIXTime(val) GC_RegisterWriteUI32(&gcRegsDef[POSIXTimeIdx], val)
#define GC_SetSubSecondTime(val) GC_RegisterWriteUI32(&gcRegsDef[SubSecondTimeIdx], val)
#define GC_SetVideoAGC(val) GC_RegisterWriteUI32(&gcRegsDef[VideoAGCIdx], val)
#define GC_SetVideoBadPixelReplacement(val) GC_RegisterWriteUI32(&gcRegsDef[VideoBadPixelReplacementIdx], val)
#define GC_SetVideoFreeze(val) GC_RegisterWriteUI32(&gcRegsDef[VideoFreezeIdx], val)
#define GC_SetDeviceRegistersStreamingStart(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceRegistersStreamingStartIdx], val)
#define GC_SetDeviceRegistersStreamingEnd(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceRegistersStreamingEndIdx], val)
#define GC_SetDeviceSerialPortSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceSerialPortSelectorIdx], val)
#define GC_SetDeviceSerialPortBaudRate(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceSerialPortBaudRateIdx], val)
#define GC_SetDeviceSerialPortFunction(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceSerialPortFunctionIdx], val)
#define GC_SetProprietaryFeature(val) GC_RegisterWriteUI32(&gcRegsDef[ProprietaryFeatureIdx], val)
#define GC_SetDeviceSerialNumber(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceSerialNumberIdx], val)
#define GC_SetSensorID(val) GC_RegisterWriteUI32(&gcRegsDef[SensorIDIdx], val)
#define GC_SetSensorWidth(val) GC_RegisterWriteUI32(&gcRegsDef[SensorWidthIdx], val)
#define GC_SetSensorHeight(val) GC_RegisterWriteUI32(&gcRegsDef[SensorHeightIdx], val)
#define GC_SetWidthMax(val) GC_RegisterWriteUI32(&gcRegsDef[WidthMaxIdx], val)
#define GC_SetHeightMax(val) GC_RegisterWriteUI32(&gcRegsDef[HeightMaxIdx], val)
#define GC_SetWidthMin(val) GC_RegisterWriteUI32(&gcRegsDef[WidthMinIdx], val)
#define GC_SetWidthInc(val) GC_RegisterWriteUI32(&gcRegsDef[WidthIncIdx], val)
#define GC_SetHeightMin(val) GC_RegisterWriteUI32(&gcRegsDef[HeightMinIdx], val)
#define GC_SetHeightInc(val) GC_RegisterWriteUI32(&gcRegsDef[HeightIncIdx], val)
#define GC_SetOffsetXMin(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetXMinIdx], val)
#define GC_SetOffsetXMax(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetXMaxIdx], val)
#define GC_SetOffsetXInc(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetXIncIdx], val)
#define GC_SetOffsetYMin(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetYMinIdx], val)
#define GC_SetOffsetYMax(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetYMaxIdx], val)
#define GC_SetOffsetYInc(val) GC_RegisterWriteUI32(&gcRegsDef[OffsetYIncIdx], val)
#define GC_SetPixelDataResolution(val) GC_RegisterWriteUI32(&gcRegsDef[PixelDataResolutionIdx], val)
#define GC_SetEventSelector(val) GC_RegisterWriteUI32(&gcRegsDef[EventSelectorIdx], val)
#define GC_SetEventNotification(val) GC_RegisterWriteUI32(&gcRegsDef[EventNotificationIdx], val)
#define GC_SetEventError(val) GC_RegisterWriteUI32(&gcRegsDef[EventErrorIdx], val)
#define GC_SetEventErrorTimestamp(val) GC_RegisterWriteUI32(&gcRegsDef[EventErrorTimestampIdx], val)
#define GC_SetEventErrorCode(val) GC_RegisterWriteUI32(&gcRegsDef[EventErrorCodeIdx], val)
#define GC_SetEventTelops(val) GC_RegisterWriteUI32(&gcRegsDef[EventTelopsIdx], val)
#define GC_SetEventTelopsTimestamp(val) GC_RegisterWriteUI32(&gcRegsDef[EventTelopsTimestampIdx], val)
#define GC_SetEventTelopsCode(val) GC_RegisterWriteUI32(&gcRegsDef[EventTelopsCodeIdx], val)
#define GC_SetClConfiguration(val) GC_RegisterWriteUI32(&gcRegsDef[ClConfigurationIdx], val)
#define GC_SetDeviceXMLMajorVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceXMLMajorVersionIdx], val)
#define GC_SetDeviceXMLMinorVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceXMLMinorVersionIdx], val)
#define GC_SetDeviceXMLSubMinorVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceXMLSubMinorVersionIdx], val)
#define GC_SetDeviceFirmwareMajorVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareMajorVersionIdx], val)
#define GC_SetDeviceFirmwareMinorVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareMinorVersionIdx], val)
#define GC_SetDeviceFirmwareSubMinorVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareSubMinorVersionIdx], val)
#define GC_SetDeviceFirmwareBuildVersion(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareBuildVersionIdx], val)
#define GC_SetDeviceFirmwareModuleSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareModuleSelectorIdx], val)
#define GC_SetDeviceFirmwareModuleRevision(val) GC_RegisterWriteI32(&gcRegsDef[DeviceFirmwareModuleRevisionIdx], val)
#define GC_SetDeviceTemperatureSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceTemperatureSelectorIdx], val)
#define GC_SetDeviceTemperature(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceTemperatureIdx], val)
#define GC_SetDeviceClockSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceClockSelectorIdx], val)
#define GC_SetDeviceClockFrequency(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceClockFrequencyIdx], val)
#define GC_SetDeviceRegistersCheck(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceRegistersCheckIdx], val)
#define GC_SetDeviceRegistersValid(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceRegistersValidIdx], val)
#define GC_SetDeviceNotReady(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceNotReadyIdx], val)
#define GC_SetDeviceVoltageSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceVoltageSelectorIdx], val)
#define GC_SetDeviceVoltage(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceVoltageIdx], val)
#define GC_SetDeviceCurrentSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceCurrentSelectorIdx], val)
#define GC_SetDeviceCurrent(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceCurrentIdx], val)
#define GC_SetDeviceRunningTime(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceRunningTimeIdx], val)
#define GC_SetDeviceCoolerRunningTime(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceCoolerRunningTimeIdx], val)
#define GC_SetDevicePowerOnCycles(val) GC_RegisterWriteUI32(&gcRegsDef[DevicePowerOnCyclesIdx], val)
#define GC_SetDeviceCoolerPowerOnCycles(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceCoolerPowerOnCyclesIdx], val)
#define GC_SetDeviceDetectorPolarizationVoltage(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceDetectorPolarizationVoltageIdx], val)
#define GC_SetDeviceDetectorElectricalTapsRef(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceDetectorElectricalTapsRefIdx], val)
#define GC_SetDeviceDetectorElectricalRefOffset(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceDetectorElectricalRefOffsetIdx], val)
#define GC_SetDeviceKeyValidationLow(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceKeyValidationLowIdx], val)
#define GC_SetDeviceKeyValidationHigh(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceKeyValidationHighIdx], val)
#define GC_SetTDCFlags(val) GC_RegisterWriteUI32(&gcRegsDef[TDCFlagsIdx], val)
#define GC_SetTDCStatus(val) GC_RegisterWriteUI32(&gcRegsDef[TDCStatusIdx], val)
#define GC_SetAvailabilityFlags(val) GC_RegisterWriteUI32(&gcRegsDef[AvailabilityFlagsIdx], val)
#define GC_SetIsActiveFlags(val) GC_RegisterWriteUI32(&gcRegsDef[IsActiveFlagsIdx], val)
#define GC_SetAcquisitionFrameRateMin(val) GC_RegisterWriteFloat(&gcRegsDef[AcquisitionFrameRateMinIdx], val)
#define GC_SetAcquisitionFrameRateMax(val) GC_RegisterWriteFloat(&gcRegsDef[AcquisitionFrameRateMaxIdx], val)
#define GC_SetImageCorrectionFWAcquisitionFrameRateMin(val) GC_RegisterWriteFloat(&gcRegsDef[ImageCorrectionFWAcquisitionFrameRateMinIdx], val)
#define GC_SetImageCorrectionFWAcquisitionFrameRateMax(val) GC_RegisterWriteFloat(&gcRegsDef[ImageCorrectionFWAcquisitionFrameRateMaxIdx], val)
#define GC_SetExposureTimeMin(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeMinIdx], val)
#define GC_SetExposureTimeMax(val) GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeMaxIdx], val)
#define GC_SetDeviceBuiltInTestsResults1(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults1Idx], val)
#define GC_SetDeviceBuiltInTestsResults2(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults2Idx], val)
#define GC_SetDeviceBuiltInTestsResults3(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults3Idx], val)
#define GC_SetDeviceBuiltInTestsResults4(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults4Idx], val)
#define GC_SetDeviceBuiltInTestsResults7(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults7Idx], val)
#define GC_SetDeviceBuiltInTestsResults8(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults8Idx], val)
#define GC_SetDeviceReset(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceResetIdx], val)
#define GC_SetDevicePowerStateSetpoint(val) GC_RegisterWriteUI32(&gcRegsDef[DevicePowerStateSetpointIdx], val)
#define GC_SetDevicePowerState(val) GC_RegisterWriteUI32(&gcRegsDef[DevicePowerStateIdx], val)
#define GC_SetDeviceLedIndicatorState(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceLedIndicatorStateIdx], val)
#define GC_SetStealthMode(val) GC_RegisterWriteUI32(&gcRegsDef[StealthModeIdx], val)
#define GC_SetPowerOnAtStartup(val) GC_RegisterWriteUI32(&gcRegsDef[PowerOnAtStartupIdx], val)

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
#define GC_MemoryBufferBusy (GC_MemoryBufferRecording || GC_MemoryBufferTransmitting || GC_MemoryBufferDefraging || GC_MemoryBufferUpdating)
#define GC_MemoryBufferDefraging MemoryBufferStatusTst(MemoryBufferDefragingMask)
#define GC_MemoryBufferNotEmpty (GC_MemoryBufferBusy || (gcRegsData.MemoryBufferSequenceCount > 0))
#define GC_MemoryBufferNotEmptyLegacy ((gcRegsData.MemoryBufferLegacyMode == MBLM_On) && GC_MemoryBufferNotEmpty)
#define GC_MemoryBufferProcessingData (GC_MemoryBufferUpdating || GC_MemoryBufferDefraging)
#define GC_MemoryBufferRecording MemoryBufferStatusTst(MemoryBufferRecordingMask)
#define GC_MemoryBufferTransmitting MemoryBufferStatusTst(MemoryBufferTransmittingMask)
#define GC_MemoryBufferUpdating MemoryBufferStatusTst(MemoryBufferUpdatingMask)
#define GC_MemoryBufferWritingProcess (GC_MemoryBufferRecording || GC_MemoryBufferUpdating)
#define GC_OffsetIsLocked (gcRegsData.CenterImage || GC_WaitingForImageCorrection)
#define GC_WaitingForImageCorrection TDCStatusTst(WaitingForImageCorrectionMask)

void GC_Registers_Init();

/* AUTO-CODE END */

void GC_UpdateLockedFlag();
void GC_UpdateCalibrationRegisters();
void GC_UpdateFpaPeriodMinMargin();
void GC_UpdateParameterLimits();
IRC_Status_t GC_DeviceRegistersVerification();
void GC_UpdateImageLimits();
void GC_UpdateExternalFanSpeed();
void GC_UpdateMemoryBufferSequenceSizeLimits();
void GC_UpdateMemoryBufferNumberOfSequenceLimits();
void GC_UpdateMemoryBufferSequencePreMOISizeLimits();
void GC_UnlockCamera();
void GC_UpdateMemoryBufferRegistersOwner();
void GC_UpdateFWPositionSetpoint(uint32_t prevFWPositionSetpoint, uint32_t newFWPositionSetpoint);
void GC_UpdateNDFPositionSetpoint(uint32_t prevNDFPositionSetpoint, uint32_t newNDFPositionSetpoint);
uint32_t GC_GetTimestamp();
void GC_UpdateExposureTimeXRegisters(float* p_src, uint32_t len);
void GC_UpdateExposureTimeRegisters(float exposureTime);
void GC_UpdateDeviceSerialPortFunction(DeviceSerialPortSelector_t updatedPort);
void GC_UpdateFOV();
void GC_UpdateExposureTimeMin();
void GC_UpdateCameraLinkConfig();

#endif // GC_REGISTERS_H
