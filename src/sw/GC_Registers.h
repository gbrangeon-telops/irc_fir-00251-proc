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
#include "ReleaseInfo.h"
#include "FlashSettings.h"
#include "utils.h"
#include <stdint.h>


#define TDCFlagsSet(mask) BitMaskSet(gcRegsData.TDCFlags, mask)  /**< Set masked bits in TDCFlags register */
#define TDCFlagsClr(mask) BitMaskClr(gcRegsData.TDCFlags, mask)  /**< Clear masked bits in TDCFlags register */
#define TDCFlagsTst(mask) BitMaskTst(gcRegsData.TDCFlags, mask)  /**< Test if masked bits in TDCFlags register are all set */
#define TDCFlagsTstAny(mask) BitMaskTstAny(gcRegsData.TDCFlags, mask)  /**< Test if at least one of the masked bits in TDCFlags register is set */

#define TDCStatusSet(mask) BitMaskSet(gcRegsData.TDCStatus, mask)  /**< Set masked bits in TDCStatus register */
#define TDCStatusClr(mask) BitMaskClr(gcRegsData.TDCStatus, mask)  /**< Clear masked bits in TDCStatus register */
#define TDCStatusTst(mask) BitMaskTst(gcRegsData.TDCStatus, mask)  /**< Test if masked bits in TDCStatus register are all set */
#define TDCStatusTstAny(mask) BitMaskTstAny(gcRegsData.TDCStatus, mask)  /**< Test if at least one of the masked bits in TDCStatus register is set */

#define AvailabilityFlagsSet(mask) BitMaskSet(gcRegsData.AvailabilityFlags, mask)  /**< Set masked bits in AvailabilityFlags register */
#define AvailabilityFlagsClr(mask) BitMaskClr(gcRegsData.AvailabilityFlags, mask)  /**< Clear masked bits in AvailabilityFlags register */
#define AvailabilityFlagsTst(mask) BitMaskTst(gcRegsData.AvailabilityFlags, mask)  /**< Test if masked bits in AvailabilityFlags register are all set */
#define AvailabilityFlagsTstAny(mask) BitMaskTstAny(gcRegsData.AvailabilityFlags, mask)  /**< Test if at least one of the masked bits in AvailabilityFlags register is set */

// EHDRINumberOfExposures must be greater than one and filter wheel mode must be set to fixed to activate EHDRI
#define EHDRIIsActive ((gcRegsData.EHDRINumberOfExposures > 1) && (gcRegsData.FWMode == FWM_Fixed))

// EHDRINumberOfExposures must equal one and filter wheel mode must be set to synchronously rotating to activate filter wheel synchronously rotating mode
#define FWSynchronoulyRotatingModeIsActive ((gcRegsData.EHDRINumberOfExposures == 1) && (gcRegsData.FWMode == FWM_SynchronouslyRotating))

extern uint8_t gGC_RegistersStreaming;
extern uint8_t gGC_ProprietaryFeatureKeyIsValid;

/* AUTO-CODE BEGIN */
// Auto-generated GeniCam library.
// Generated from XML camera definition file version 11.1.0
// using generateGenICamCLib.m Matlab script.

#if ((GC_XMLMAJORVERSION != 11) || (GC_XMLMINORVERSION != 1) || (GC_XMLSUBMINORVERSION != 0))
#error "XML version mismatch."
#endif

// Registers data structure and data type
////////////////////////////////////////////////////////////////////////////////

/**
 * Registers data structure
 */
struct gcRegistersDataStruct {
   float AECImageFraction;
   float AECResponseTime;
   float AECTargetWellFilling;
   float AcquisitionFrameRate;
   float AcquisitionFrameRateMax;
   float AcquisitionFrameRateMaxFG;
   float AcquisitionFrameRateMin;
   float DeviceClockFrequency;
   float DeviceCurrent;
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
   float MemoryBufferSequenceDownloadBitRateMax;
   float TriggerDelay;
   int32_t DeviceFirmwareModuleRevision;
   int32_t FWPositionRaw;
   int32_t FWPositionRawSetpoint;
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
   uint32_t AutomaticExternalFanSpeedMode;
   uint32_t AvailabilityFlags;
   uint32_t CalibrationActualizationMode;
   uint32_t CalibrationActualize;
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
   uint32_t DeviceBuiltInTestsGlobalResult;
   uint32_t DeviceBuiltInTestsResults1;
   uint32_t DeviceBuiltInTestsResults2;
   uint32_t DeviceBuiltInTestsResults3;
   uint32_t DeviceBuiltInTestsResults4;
   uint32_t DeviceBuiltInTestsResults5;
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
   uint32_t ExternalLensSerialNumber;
   uint32_t FValSize;
   uint32_t FWFilterNumber;
   uint32_t FWMode;
   uint32_t FWPosition;
   uint32_t FWPositionSetpoint;
   uint32_t FWSpeed;
   uint32_t FWSpeedMax;
   uint32_t FWSpeedSetpoint;
   uint32_t GPSModeIndicator;
   uint32_t GPSNumberOfSatellitesInUse;
   uint32_t Height;
   uint32_t HeightInc;
   uint32_t HeightMax;
   uint32_t HeightMin;
   uint32_t ICUPosition;
   uint32_t ICUPositionSetpoint;
   uint32_t IntegrationMode;
   uint32_t LockedCenterImage;
   uint32_t ManualFilterSerialNumber;
   uint32_t MemoryBufferMOIActivation;
   uint32_t MemoryBufferMOISoftware;
   uint32_t MemoryBufferMOISource;
   uint32_t MemoryBufferMode;
   uint32_t MemoryBufferNumberOfImagesMax;
   uint32_t MemoryBufferNumberOfSequences;
   uint32_t MemoryBufferNumberOfSequencesMax;
   uint32_t MemoryBufferSequenceClearAll;
   uint32_t MemoryBufferSequenceCount;
   uint32_t MemoryBufferSequenceDownloadImageFrameID;
   uint32_t MemoryBufferSequenceDownloadMode;
   uint32_t MemoryBufferSequenceFirstFrameID;
   uint32_t MemoryBufferSequenceMOIFrameID;
   uint32_t MemoryBufferSequencePreMOISize;
   uint32_t MemoryBufferSequenceRecordedSize;
   uint32_t MemoryBufferSequenceSelector;
   uint32_t MemoryBufferSequenceSize;
   uint32_t MemoryBufferSequenceSizeMax;
   uint32_t NDFilterNumber;
   uint32_t NDFilterPosition;
   uint32_t NDFilterPositionSetpoint;
   uint32_t OffsetX;
   uint32_t OffsetXInc;
   uint32_t OffsetY;
   uint32_t OffsetYInc;
   uint32_t POSIXTime;
   uint32_t PixelDataResolution;
   uint32_t PixelFormat;
   uint32_t PowerOnAtStartup;
   uint32_t ProprietaryFeature;
   uint32_t ReverseX;
   uint32_t ReverseY;
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

#define DeviceClockFrequencyAryLen 3
extern float DeviceClockFrequencyAry[DeviceClockFrequencyAryLen];

#define DeviceTemperatureAryLen 13
extern float DeviceTemperatureAry[DeviceTemperatureAryLen];

#define DeviceVoltageAryLen 31
extern float DeviceVoltageAry[DeviceVoltageAryLen];

#define DeviceCurrentAryLen 2
extern float DeviceCurrentAry[DeviceCurrentAryLen];

#define DeviceSerialPortBaudRateAryLen 4
extern uint32_t DeviceSerialPortBaudRateAry[DeviceSerialPortBaudRateAryLen];

#define EventNotificationAryLen 33
extern uint32_t EventNotificationAry[EventNotificationAryLen];

#define DeviceFirmwareModuleRevisionAryLen 12
extern int32_t DeviceFirmwareModuleRevisionAry[DeviceFirmwareModuleRevisionAryLen];

#define TriggerModeAryLen 2
extern uint32_t TriggerModeAry[TriggerModeAryLen];

#define TriggerSourceAryLen 2
extern uint32_t TriggerSourceAry[TriggerSourceAryLen];

#define TriggerActivationAryLen 2
extern uint32_t TriggerActivationAry[TriggerActivationAryLen];

#define TriggerDelayAryLen 2
extern float TriggerDelayAry[TriggerDelayAryLen];

#define TriggerFrameCountAryLen 2
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
#define GC_SetReverseX(val) GC_RegisterWriteUI32(&gcRegsDef[ReverseXIdx], val)
#define GC_SetReverseY(val) GC_RegisterWriteUI32(&gcRegsDef[ReverseYIdx], val)
#define GC_SetTriggerSelector(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerSelectorIdx], val)
#define GC_SetTriggerMode(val) GC_RegisterWriteUI32(&gcRegsDef[TriggerModeIdx], val)
#define GC_SetMemoryBufferMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferModeIdx], val)
#define GC_SetMemoryBufferSequenceCount(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceCountIdx], val)
#define GC_SetMemoryBufferSequenceDownloadMode(val) GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceDownloadModeIdx], val)
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
#define GC_SetDeviceFirmwareModuleSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceFirmwareModuleSelectorIdx], val)
#define GC_SetDeviceFirmwareModuleRevision(val) GC_RegisterWriteI32(&gcRegsDef[DeviceFirmwareModuleRevisionIdx], val)
#define GC_SetDeviceTemperatureSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceTemperatureSelectorIdx], val)
#define GC_SetDeviceTemperature(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceTemperatureIdx], val)
#define GC_SetDeviceVoltageSelector(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceVoltageSelectorIdx], val)
#define GC_SetDeviceVoltage(val) GC_RegisterWriteFloat(&gcRegsDef[DeviceVoltageIdx], val)
#define GC_SetDeviceBuiltInTestsResults7(val) GC_RegisterWriteUI32(&gcRegsDef[DeviceBuiltInTestsResults7Idx], val)

// Locked registers utility macros
////////////////////////////////////////////////////////////////////////////////
#define GC_FWIsImplemented TDCFlagsTst(FWIsImplementedMask)
#define GC_FWSynchronouslyRotatingModeIsImplemented (GC_FWIsImplemented && TDCFlagsTst(FWSynchronouslyRotatingModeIsImplementedMask))
#define GC_FWSynchronouslyRotatingModeIsActive (GC_FWSynchronouslyRotatingModeIsImplemented && (gcRegsData.FWMode == FWM_SynchronouslyRotating))
#define GC_CalibrationCollectionTypeFWIsActive ((gcRegsData.CalibrationCollectionActiveType == CCAT_TelopsFW) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointFW))
#define GC_CalibrationCollectionTypeNDFIsActive ((gcRegsData.CalibrationCollectionActiveType == CCAT_TelopsNDF) || (gcRegsData.CalibrationCollectionActiveType == CCAT_MultipointNDF))
#define GC_ExternalMemoryBufferIsImplemented TDCFlagsTst(ExternalMemoryBufferIsImplementedMask)
#define GC_FWFixedModeIsActive (gcRegsData.FWMode == FWM_Fixed)
#define GC_WaitingForCalibrationInit TDCStatusTst(WaitingForCalibrationInitMask)
#define GC_EHDRIIsActive (gcRegsData.EHDRINumberOfExposures > 1)
#define GC_DiscreteExposureTimeIsAvailable AvailabilityFlagsTst(DiscreteExposureTimeIsAvailableMask)
#define GC_AECPlusIsImplemented TDCFlagsTst(AECPlusIsImplementedMask)
#define GC_AECPlusIsActive (GC_AECPlusIsImplemented && ((gcRegsData.ExposureAuto == EA_OnceNDFilter) || (gcRegsData.ExposureAuto == EA_ContinuousNDFilter)))
#define GC_AECIsActive ((gcRegsData.ExposureAuto == EA_Once) || (gcRegsData.ExposureAuto == EA_Continuous))
#define GC_CalibrationCollectionTypeMultipointIsActive (gcRegsData.CalibrationCollectionActiveType >= CCAT_MultipointFixed)
#define GC_CalibrationIsActive ((gcRegsData.CalibrationMode != CM_Raw0) && (gcRegsData.CalibrationMode != CM_Raw))
#define GC_AcquisitionStarted TDCStatusTst(AcquisitionStartedMask)
#define GC_WaitingForCalibrationActualization TDCStatusTst(WaitingForCalibrationActualizationMask)

void GC_Registers_Init();

/* AUTO-CODE END */

void GC_UpdateLockedFlag();
void GC_CalibrationUpdateRegisters();
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

#endif // GC_REGISTERS_H
