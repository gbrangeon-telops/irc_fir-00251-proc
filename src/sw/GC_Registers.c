/**
 * @file GC_Registers.c
 * GenICam registers data definition.
 *
 * This file defines the GenICam registers data.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "GC_Registers.h"
#include "GC_Callback.h"
#include "GC_Events.h"
#include "hder_inserter.h"
#include "fpa_intf.h"
#include "Trig_gen.h"
#include "fan_ctrl.h"
#include "Acquisition.h"
#include "Actualization.h"
#include "Autofocus.h"
#include "BufferManager.h"
#include "BuildInfo.h"
#include "EHDRI_Manager.h"
#include "Calibration.h"
#include "FWController.h"
#include "NDFController.h"
#include "SFW_MathematicalModel.h"
#include "exposure_time_ctrl.h"
#include "DebugTerminal.h"
#include "FlashDynamicValues.h"
#include "utils.h"
#include <string.h>
#include <math.h>

#define SVN_REVISIONS_INIT {SVN_HARDWARE_REV, SVN_SOFTWARE_REV, SVN_BOOTLOADER_REV, SVN_COMMON_REV, 0, 0, 0, 0, 0, 0, 0, 0}

#define DEFAULT_FRAME_RATE_MIN   0.1F
#define DEFAULT_FRAME_RATE_MAX   1500.0F

uint8_t gGC_RegistersStreaming = 0;
uint8_t gGC_ProprietaryFeatureKeyIsValid = 0;

float EHDRIExposureTime[EHDRI_IDX_NBR] = {FPA_EHDRI_EXP_0, FPA_EHDRI_EXP_1, FPA_EHDRI_EXP_2, FPA_EHDRI_EXP_3};
float FWExposureTime[MAX_NUM_FILTER] = {FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE, FPA_DEFAULT_EXPOSURE};
gcRegister_t* pGcRegsDefExposureTimeX[MAX_NUM_FILTER];

extern float SFW_AcquisitionFrameRateMax;
extern float SFW_ExposureTimeMax;

/* AUTO-CODE BEGIN */
// Auto-generated GeniCam library.
// Generated from XML camera definition file version 13.4.0
// using generateGenICamCLib.m Matlab script.

// GenICam global variables definition
////////////////////////////////////////////////////////////////////////////////

/**
 * Factory registers data
 */
gcRegistersData_t gcRegsDataFactory = {
   /* AECImageFraction = */ 90.0F,
   /* AECPlusExtrapolationWeight = */ 0.0F,
   /* AECResponseTime = */ 100.0F,
   /* AECTargetWellFilling = */ 60.0F,
   /* AcquisitionFrameRate = */ FPA_DEFAULT_FRAME_RATE,
   /* AcquisitionFrameRateMax = */ DEFAULT_FRAME_RATE_MAX,
   /* AcquisitionFrameRateMaxFG = */ 0.0F,
   /* AcquisitionFrameRateMin = */ DEFAULT_FRAME_RATE_MIN,
   /* AcquisitionFrameRateUnrestrictedMax = */ DEFAULT_FRAME_RATE_MAX,
   /* AcquisitionFrameRateUnrestrictedMin = */ DEFAULT_FRAME_RATE_MIN,
   /* AutofocusROI = */ AUTOFOCUS_ROI_DEFAULT,
   /* DeviceClockFrequency = */ 0.0F,
   /* DeviceCurrent = */ 0.0F,
   /* DeviceDetectorElectricalRefOffset = */ 0.0F,
   /* DeviceDetectorElectricalTapsRef = */ 0.0F,
   /* DeviceDetectorPolarizationVoltage = */ 0.0F,
   /* DeviceStabilizationDeltaTemperature = */ 0.0F,
   /* DeviceTemperature = */ 0.0F,
   /* DeviceVoltage = */ 0.0F,
   /* EHDRIExpectedTemperatureMax = */ 200.0F,
   /* EHDRIExpectedTemperatureMaxMin = */ 10.0F,
   /* EHDRIExpectedTemperatureMin = */ 10.0F,
   /* EHDRIExpectedTemperatureMinMax = */ 200.0F,
   /* EHDRIExposureOccurrence1 = */ 25.00F,
   /* EHDRIExposureOccurrence2 = */ 25.00F,
   /* EHDRIExposureOccurrence3 = */ 25.00F,
   /* EHDRIExposureOccurrence4 = */ 25.00F,
   /* ExposureTime = */ FPA_DEFAULT_EXPOSURE,
   /* ExposureTime1 = */ 0.0F,
   /* ExposureTime2 = */ 0.0F,
   /* ExposureTime3 = */ 0.0F,
   /* ExposureTime4 = */ 0.0F,
   /* ExposureTime5 = */ 0.0F,
   /* ExposureTime6 = */ 0.0F,
   /* ExposureTime7 = */ 0.0F,
   /* ExposureTime8 = */ 0.0F,
   /* ExposureTimeMax = */ FPA_MAX_EXPOSURE,
   /* ExposureTimeMin = */ FPA_MIN_EXPOSURE,
   /* ExternalBlackBodyTemperature = */ 25.00F,
   /* ExternalFanSpeed = */ 0.0F,
   /* ExternalFanSpeedSetpoint = */ 50.0F,
   /* HFOV = */ 0.0F,
   /* ImageCorrectionFWAcquisitionFrameRate = */ ACT_DEFAULT_FPS,
   /* ImageCorrectionFWAcquisitionFrameRateMax = */ DEFAULT_FRAME_RATE_MAX,
   /* ImageCorrectionFWAcquisitionFrameRateMin = */ DEFAULT_FRAME_RATE_MIN,
   /* MemoryBufferSequenceDownloadBitRateMax = */ 20.0F,
   /* TriggerDelay = */ 0.0F,
   /* VFOV = */ 0.0F,
   /* DeviceFirmwareModuleRevision = */ 0,
   /* FOVPositionRaw = */ 0,
   /* FOVPositionRawMax = */ 0,
   /* FOVPositionRawMin = */ 0,
   /* FOVPositionRawSetpoint = */ 0,
   /* FWPositionRaw = */ 0,
   /* FWPositionRawSetpoint = */ 0,
   /* FocusPositionRaw = */ 0,
   /* FocusPositionRawMax = */ 0,
   /* FocusPositionRawMin = */ 0,
   /* FocusPositionRawSetpoint = */ 0,
   /* GPSAltitude = */ 0,
   /* GPSLatitude = */ 0,
   /* GPSLongitude = */ 0,
   /* NDFilterPositionRaw = */ 0,
   /* NDFilterPositionRawSetpoint = */ 0,
   /* AcquisitionArm = */ 0,
   /* AcquisitionFrameRateMode = */ AFRM_Fixed,
   /* AcquisitionFrameRateSetToMax = */ 0,
   /* AcquisitionMode = */ AM_Continuous,
   /* AcquisitionStart = */ 0,
   /* AcquisitionStartAtStartup = */ 0,
   /* AcquisitionStop = */ 0,
   /* Autofocus = */ 0,
   /* AutofocusMode = */ AM_Off,
   /* AutomaticExternalFanSpeedMode = */ AEFSM_Off,
   /* AvailabilityFlags = */ 0,
   /* BadPixelReplacement = */ 0,
   /* BinningMode = */ BM_NoBinning,
   /* CalibrationCollectionActiveBlockPOSIXTime = */ 0,
   /* CalibrationCollectionActivePOSIXTime = */ 0,
   /* CalibrationCollectionActiveType = */ 0,
   /* CalibrationCollectionBlockCount = */ 0,
   /* CalibrationCollectionBlockLoad = */ 0,
   /* CalibrationCollectionBlockPOSIXTime = */ 0,
   /* CalibrationCollectionBlockSelector = */ 0,
   /* CalibrationCollectionCount = */ 0,
   /* CalibrationCollectionLoad = */ 0,
   /* CalibrationCollectionPOSIXTime = */ 0,
   /* CalibrationCollectionSelector = */ 0,
   /* CalibrationCollectionType = */ 0,
   /* CalibrationMode = */ CM_Raw0,
   /* CenterImage = */ 1,
   /* ClConfiguration = */ CC_Full,
   /* DetectorMode = */ DM_Normal,
   /* DeviceBuiltInTestsResults1 = */ 0,
   /* DeviceBuiltInTestsResults2 = */ 0,
   /* DeviceBuiltInTestsResults3 = */ 0,
   /* DeviceBuiltInTestsResults4 = */ 0,
   /* DeviceBuiltInTestsResults7 = */ 0,
   /* DeviceBuiltInTestsResults8 = */ 0,
   /* DeviceClockSelector = */ 0,
   /* DeviceCoolerPowerOnCycles = */ 0,
   /* DeviceCoolerRunningTime = */ 0,
   /* DeviceCurrentSelector = */ DCS_Cooler,
   /* DeviceFirmwareBuildVersion = */ 0,
   /* DeviceFirmwareMajorVersion = */ 0,
   /* DeviceFirmwareMinorVersion = */ 0,
   /* DeviceFirmwareModuleSelector = */ 0,
   /* DeviceFirmwareSubMinorVersion = */ 0,
   /* DeviceKeyValidationHigh = */ 0,
   /* DeviceKeyValidationLow = */ 0,
   /* DeviceLedIndicatorState = */ DLIS_Busy,
   /* DeviceNotReady = */ 0,
   /* DevicePowerOnCycles = */ 0,
   /* DevicePowerState = */ DPS_PowerStandby,
   /* DevicePowerStateSetpoint = */ DPSS_PowerStandby,
   /* DeviceRegistersCheck = */ 0,
   /* DeviceRegistersStreamingEnd = */ 0,
   /* DeviceRegistersStreamingStart = */ 0,
   /* DeviceRegistersValid = */ 0,
   /* DeviceReset = */ 0,
   /* DeviceRunningTime = */ 0,
   /* DeviceSerialNumber = */ 0,
   /* DeviceSerialPortBaudRate = */ 0,
   /* DeviceSerialPortFunction = */ 0,
   /* DeviceSerialPortSelector = */ DSPS_CameraLink,
   /* DeviceStabilizationTime = */ 0,
   /* DeviceTemperatureSelector = */ DTS_Sensor,
   /* DeviceVoltageSelector = */ DVS_ProcessingFPGA_VCCINT,
   /* DeviceXMLMajorVersion = */ GC_XMLMAJORVERSION,
   /* DeviceXMLMinorVersion = */ GC_XMLMINORVERSION,
   /* DeviceXMLSubMinorVersion = */ GC_XMLSUBMINORVERSION,
   /* EHDRIMode = */ EHDRIM_Advanced,
   /* EHDRINumberOfExposures = */ 1,
   /* EHDRIResetToDefault = */ 0,
   /* EventError = */ EECD_NoError,
   /* EventErrorCode = */ EECD_NoError,
   /* EventErrorTimestamp = */ 0,
   /* EventNotification = */ 0,
   /* EventSelector = */ ES_Error,
   /* EventTelops = */ 0,
   /* EventTelopsCode = */ 0,
   /* EventTelopsTimestamp = */ 0,
   /* ExposureAuto = */ EA_Continuous,
   /* ExposureMode = */ EM_Timed,
   /* ExposureTimeSetToMax = */ 0,
   /* ExposureTimeSetToMin = */ 0,
   /* ExternalLensSerialNumber = */ 0,
   /* FOVPosition = */ FOVP_FOVNotImplemented,
   /* FOVPositionNumber = */ 0,
   /* FOVPositionSetpoint = */ FOVPS_FOV1,
   /* FValSize = */ 0,
   /* FWFilterNumber = */ 0,
   /* FWMode = */ FWM_Fixed,
   /* FWPosition = */ FWP_FilterWheelNotImplemented,
   /* FWPositionSetpoint = */ FWPS_Filter1,
   /* FWSpeed = */ 0,
   /* FWSpeedMax = */ 5000,
   /* FWSpeedSetpoint = */ 0,
   /* FocusFarFast = */ 0,
   /* FocusFarSlow = */ 0,
   /* FocusNearFast = */ 0,
   /* FocusNearSlow = */ 0,
   /* GPSModeIndicator = */ GPSMI_NotAvailable,
   /* GPSNumberOfSatellitesInUse = */ 0,
   /* Height = */ FPA_HEIGHT_MAX,
   /* HeightInc = */ FPA_HEIGHT_MULT,
   /* HeightMax = */ FPA_HEIGHT_MAX,
   /* HeightMin = */ FPA_HEIGHT_MIN,
   /* ICUPosition = */ ICUP_ICUNotImplemented,
   /* ICUPositionSetpoint = */ ICUPS_Scene,
   /* ImageCorrection = */ 0,
   /* ImageCorrectionBlockSelector = */ ICBS_AllBlocks,
   /* ImageCorrectionFWMode = */ ICFWM_Fixed,
   /* ImageCorrectionMode = */ ICM_BlackBody,
   /* IntegrationMode = */ FPA_INTEGRATION_MODE,
   /* IsActiveFlags = */ 0,
   /* LoadSavedConfigurationAtStartup = */ 0,
   /* LockedCenterImage = */ FPA_FORCE_CENTER,
   /* ManualFilterSerialNumber = */ 0,
   /* MemoryBufferAvailableFreeSpaceHigh = */ 0,
   /* MemoryBufferAvailableFreeSpaceLow = */ 0,
   /* MemoryBufferFragmentedFreeSpaceHigh = */ 0,
   /* MemoryBufferFragmentedFreeSpaceLow = */ 0,
   /* MemoryBufferLegacyMode = */ MBLM_Off,
   /* MemoryBufferMOIActivation = */ MBMOIA_RisingEdge,
   /* MemoryBufferMOISoftware = */ 0,
   /* MemoryBufferMOISource = */ MBMOIS_Software,
   /* MemoryBufferMode = */ MBM_Off,
   /* MemoryBufferNumberOfImagesMax = */ 0,
   /* MemoryBufferNumberOfSequences = */ 1,
   /* MemoryBufferNumberOfSequencesMax = */ 0,
   /* MemoryBufferNumberOfSequencesMin = */ 0,
   /* MemoryBufferSequenceBadPixelReplacement = */ 0,
   /* MemoryBufferSequenceCalibrationMode = */ MBSCM_Raw0,
   /* MemoryBufferSequenceClear = */ 0,
   /* MemoryBufferSequenceClearAll = */ 0,
   /* MemoryBufferSequenceCount = */ 0,
   /* MemoryBufferSequenceDefrag = */ 0,
   /* MemoryBufferSequenceDownloadFrameCount = */ 1,
   /* MemoryBufferSequenceDownloadFrameID = */ 0,
   /* MemoryBufferSequenceDownloadFrameImageCount = */ 1,
   /* MemoryBufferSequenceDownloadImageFrameID = */ 0,
   /* MemoryBufferSequenceDownloadMode = */ MBSDM_Off,
   /* MemoryBufferSequenceDownloadSuggestedFrameImageCount = */ 1,
   /* MemoryBufferSequenceFirstFrameID = */ 0,
   /* MemoryBufferSequenceHeight = */ 0,
   /* MemoryBufferSequenceMOIFrameID = */ 0,
   /* MemoryBufferSequenceOffsetX = */ 0,
   /* MemoryBufferSequenceOffsetY = */ 0,
   /* MemoryBufferSequencePreMOISize = */ 0,
   /* MemoryBufferSequenceRecordedSize = */ 0,
   /* MemoryBufferSequenceSelector = */ 0,
   /* MemoryBufferSequenceSize = */ 2,
   /* MemoryBufferSequenceSizeInc = */ 0,
   /* MemoryBufferSequenceSizeMax = */ 0,
   /* MemoryBufferSequenceSizeMin = */ 0,
   /* MemoryBufferSequenceWidth = */ 0,
   /* MemoryBufferStatus = */ MBS_Deactivated,
   /* MemoryBufferTotalSpaceHigh = */ 0,
   /* MemoryBufferTotalSpaceLow = */ 0,
   /* NDFilterArmedPositionSetpoint = */ NDFAPS_NDFilter1,
   /* NDFilterNumber = */ 0,
   /* NDFilterPosition = */ NDFP_NDFilterNotImplemented,
   /* NDFilterPositionSetpoint = */ NDFPS_NDFilter1,
   /* OffsetX = */ 0,
   /* OffsetXInc = */ FPA_OFFSETX_MULT,
   /* OffsetXMax = */ 0,
   /* OffsetXMin = */ 0,
   /* OffsetY = */ 0,
   /* OffsetYInc = */ FPA_OFFSETY_MULT,
   /* OffsetYMax = */ 0,
   /* OffsetYMin = */ 0,
   /* POSIXTime = */ 0,
   /* PayloadSizeMinFG = */ 0,
   /* PixelDataResolution = */ PDR_Bpp16,
   /* PixelFormat = */ PF_Mono16,
   /* PowerOnAtStartup = */ 0,
   /* ProprietaryFeature = */ 0,
   /* ReverseX = */ FPA_FLIP_LR,
   /* ReverseY = */ FPA_FLIP_UD,
   /* SaveConfiguration = */ 0,
   /* SensorHeight = */ FPA_HEIGHT_MAX,
   /* SensorID = */ 0,
   /* SensorWellDepth = */ FPA_SENSOR_WELL_DEPTH,
   /* SensorWidth = */ FPA_WIDTH_MAX,
   /* StealthMode = */ 0,
   /* SubSecondTime = */ 0,
   /* TDCFlags = */ FPA_TDC_FLAGS,
   /* TDCFlags2 = */ FPA_TDC_FLAGS2,
   /* TDCStatus = */ TDC_STATUS_INIT,
   /* TestImageSelector = */ TIS_TelopsStaticShade,
   /* TimeSource = */ TS_InternalRealTimeClock,
   /* TriggerActivation = */ 0,
   /* TriggerFrameCount = */ 0,
   /* TriggerMode = */ 0,
   /* TriggerSelector = */ TS_AcquisitionStart,
   /* TriggerSoftware = */ 0,
   /* TriggerSource = */ 0,
   /* VideoAGC = */ VAGC_Continuous,
   /* VideoBadPixelReplacement = */ 1,
   /* VideoFreeze = */ 0,
   /* Width = */ FPA_WIDTH_MAX,
   /* WidthInc = */ FPA_WIDTH_MULT,
   /* WidthMax = */ FPA_WIDTH_MAX,
   /* WidthMin = */ FPA_WIDTH_MIN,
   /* ZoomInFast = */ 0,
   /* ZoomInSlow = */ 0,
   /* ZoomOutFast = */ 0,
   /* ZoomOutSlow = */ 0,
   /* DeviceID = */ "TEL00000",
   /* DeviceManufacturerInfo = */ "Thermal Scientific IR Camera",
   /* DeviceModelName = */ "TS-IR",
   /* DeviceVendorName = */ "Telops Inc.",
   /* DeviceVersion = */ "0.0.0.0",
   /* GevFirstURL = */ GC_GEVFIRSTURL,
   /* GevSecondURL = */ ""
};

/**
 * Registers data
 */
gcRegistersData_t gcRegsData;

/**
 * Selected registers list
 */
gcSelectedReg_t gcSelectedRegList[gcSelectedRegListLen] = {
   {DeviceClockFrequencyIdx, DeviceClockSelectorIdx, 3},
   {DeviceTemperatureIdx, DeviceTemperatureSelectorIdx, 13},
   {DeviceVoltageIdx, DeviceVoltageSelectorIdx, 31},
   {DeviceCurrentIdx, DeviceCurrentSelectorIdx, 2},
   {DeviceSerialPortBaudRateIdx, DeviceSerialPortSelectorIdx, 3},
   {DeviceSerialPortFunctionIdx, DeviceSerialPortSelectorIdx, 3},
   {EventNotificationIdx, EventSelectorIdx, 33},
   {DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, 12},
   {TriggerModeIdx, TriggerSelectorIdx, 3},
   {TriggerSourceIdx, TriggerSelectorIdx, 3},
   {TriggerActivationIdx, TriggerSelectorIdx, 3},
   {TriggerDelayIdx, TriggerSelectorIdx, 3},
   {TriggerFrameCountIdx, TriggerSelectorIdx, 3}
};

/**
 * DeviceClockFrequency data array
 */
float DeviceClockFrequencyAry[DeviceClockFrequencyAryLen] = {0.0F, 0.0F, 0.0F};
const float DeviceClockFrequencyAryFactory[DeviceClockFrequencyAryLen] = {0.0F, 0.0F, 0.0F};

/**
 * DeviceTemperature data array
 */
float DeviceTemperatureAry[DeviceTemperatureAryLen] = {0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F};
const float DeviceTemperatureAryFactory[DeviceTemperatureAryLen] = {0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F};

/**
 * DeviceVoltage data array
 */
float DeviceVoltageAry[DeviceVoltageAryLen] = {0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F};
const float DeviceVoltageAryFactory[DeviceVoltageAryLen] = {0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F, 0.0F};

/**
 * DeviceCurrent data array
 */
float DeviceCurrentAry[DeviceCurrentAryLen] = {0.0F, 0.0F};
const float DeviceCurrentAryFactory[DeviceCurrentAryLen] = {0.0F, 0.0F};

/**
 * DeviceSerialPortBaudRate data array
 */
uint32_t DeviceSerialPortBaudRateAry[DeviceSerialPortBaudRateAryLen] = {DSPBR_Baud115200, DSPBR_Baud115200, DSPBR_Baud115200};
const uint32_t DeviceSerialPortBaudRateAryFactory[DeviceSerialPortBaudRateAryLen] = {DSPBR_Baud115200, DSPBR_Baud115200, DSPBR_Baud115200};

/**
 * DeviceSerialPortFunction data array
 */
uint32_t DeviceSerialPortFunctionAry[DeviceSerialPortFunctionAryLen] = {DSPF_Control, DSPF_Control, DSPF_Terminal};
const uint32_t DeviceSerialPortFunctionAryFactory[DeviceSerialPortFunctionAryLen] = {DSPF_Control, DSPF_Control, DSPF_Terminal};

/**
 * EventNotification data array
 */
uint32_t EventNotificationAry[EventNotificationAryLen] = {0, 0, EN_On, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, EN_On};
const uint32_t EventNotificationAryFactory[EventNotificationAryLen] = {0, 0, EN_On, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, EN_On};

/**
 * DeviceFirmwareModuleRevision data array
 */
int32_t DeviceFirmwareModuleRevisionAry[DeviceFirmwareModuleRevisionAryLen] = SVN_REVISIONS_INIT;
const int32_t DeviceFirmwareModuleRevisionAryFactory[DeviceFirmwareModuleRevisionAryLen] = SVN_REVISIONS_INIT;

/**
 * TriggerMode data array
 */
uint32_t TriggerModeAry[TriggerModeAryLen] = {TM_Off, TM_Off, TM_Off};
const uint32_t TriggerModeAryFactory[TriggerModeAryLen] = {TM_Off, TM_Off, TM_Off};

/**
 * TriggerSource data array
 */
uint32_t TriggerSourceAry[TriggerSourceAryLen] = {TS_Software, TS_Software, TS_Software};
const uint32_t TriggerSourceAryFactory[TriggerSourceAryLen] = {TS_Software, TS_Software, TS_Software};

/**
 * TriggerActivation data array
 */
uint32_t TriggerActivationAry[TriggerActivationAryLen] = {TA_RisingEdge, TA_RisingEdge, TA_LevelHigh};
const uint32_t TriggerActivationAryFactory[TriggerActivationAryLen] = {TA_RisingEdge, TA_RisingEdge, TA_LevelHigh};

/**
 * TriggerDelay data array
 */
float TriggerDelayAry[TriggerDelayAryLen] = {0.0F, 0.0F, 0.0F};
const float TriggerDelayAryFactory[TriggerDelayAryLen] = {0.0F, 0.0F, 0.0F};

/**
 * TriggerFrameCount data array
 */
uint32_t TriggerFrameCountAry[TriggerFrameCountAryLen] = {1, 1, 1};
const uint32_t TriggerFrameCountAryFactory[TriggerFrameCountAryLen] = {1, 1, 1};

/**
 * GenICam registers data pointer initialization.
 */
void GC_Registers_Init()
{
   gcRegsDef[AECImageFractionIdx].p_data = &gcRegsData.AECImageFraction;
   gcRegsDef[AECPlusExtrapolationWeightIdx].p_data = &gcRegsData.AECPlusExtrapolationWeight;
   gcRegsDef[AECResponseTimeIdx].p_data = &gcRegsData.AECResponseTime;
   gcRegsDef[AECTargetWellFillingIdx].p_data = &gcRegsData.AECTargetWellFilling;
   gcRegsDef[AcquisitionFrameRateIdx].p_data = &gcRegsData.AcquisitionFrameRate;
   gcRegsDef[AcquisitionFrameRateMaxIdx].p_data = &gcRegsData.AcquisitionFrameRateMax;
   gcRegsDef[AcquisitionFrameRateMaxFGIdx].p_data = &gcRegsData.AcquisitionFrameRateMaxFG;
   gcRegsDef[AcquisitionFrameRateMinIdx].p_data = &gcRegsData.AcquisitionFrameRateMin;
   gcRegsDef[AcquisitionFrameRateUnrestrictedMaxIdx].p_data = &gcRegsData.AcquisitionFrameRateUnrestrictedMax;
   gcRegsDef[AcquisitionFrameRateUnrestrictedMinIdx].p_data = &gcRegsData.AcquisitionFrameRateUnrestrictedMin;
   gcRegsDef[AutofocusROIIdx].p_data = &gcRegsData.AutofocusROI;
   gcRegsDef[DeviceClockFrequencyIdx].p_data = &gcRegsData.DeviceClockFrequency;
   gcRegsDef[DeviceCurrentIdx].p_data = &gcRegsData.DeviceCurrent;
   gcRegsDef[DeviceDetectorElectricalRefOffsetIdx].p_data = &gcRegsData.DeviceDetectorElectricalRefOffset;
   gcRegsDef[DeviceDetectorElectricalTapsRefIdx].p_data = &gcRegsData.DeviceDetectorElectricalTapsRef;
   gcRegsDef[DeviceDetectorPolarizationVoltageIdx].p_data = &gcRegsData.DeviceDetectorPolarizationVoltage;
   gcRegsDef[DeviceStabilizationDeltaTemperatureIdx].p_data = &gcRegsData.DeviceStabilizationDeltaTemperature;
   gcRegsDef[DeviceTemperatureIdx].p_data = &gcRegsData.DeviceTemperature;
   gcRegsDef[DeviceVoltageIdx].p_data = &gcRegsData.DeviceVoltage;
   gcRegsDef[EHDRIExpectedTemperatureMaxIdx].p_data = &gcRegsData.EHDRIExpectedTemperatureMax;
   gcRegsDef[EHDRIExpectedTemperatureMaxMinIdx].p_data = &gcRegsData.EHDRIExpectedTemperatureMaxMin;
   gcRegsDef[EHDRIExpectedTemperatureMinIdx].p_data = &gcRegsData.EHDRIExpectedTemperatureMin;
   gcRegsDef[EHDRIExpectedTemperatureMinMaxIdx].p_data = &gcRegsData.EHDRIExpectedTemperatureMinMax;
   gcRegsDef[EHDRIExposureOccurrence1Idx].p_data = &gcRegsData.EHDRIExposureOccurrence1;
   gcRegsDef[EHDRIExposureOccurrence2Idx].p_data = &gcRegsData.EHDRIExposureOccurrence2;
   gcRegsDef[EHDRIExposureOccurrence3Idx].p_data = &gcRegsData.EHDRIExposureOccurrence3;
   gcRegsDef[EHDRIExposureOccurrence4Idx].p_data = &gcRegsData.EHDRIExposureOccurrence4;
   gcRegsDef[ExposureTimeIdx].p_data = &gcRegsData.ExposureTime;
   gcRegsDef[ExposureTime1Idx].p_data = &gcRegsData.ExposureTime1;
   gcRegsDef[ExposureTime2Idx].p_data = &gcRegsData.ExposureTime2;
   gcRegsDef[ExposureTime3Idx].p_data = &gcRegsData.ExposureTime3;
   gcRegsDef[ExposureTime4Idx].p_data = &gcRegsData.ExposureTime4;
   gcRegsDef[ExposureTime5Idx].p_data = &gcRegsData.ExposureTime5;
   gcRegsDef[ExposureTime6Idx].p_data = &gcRegsData.ExposureTime6;
   gcRegsDef[ExposureTime7Idx].p_data = &gcRegsData.ExposureTime7;
   gcRegsDef[ExposureTime8Idx].p_data = &gcRegsData.ExposureTime8;
   gcRegsDef[ExposureTimeMaxIdx].p_data = &gcRegsData.ExposureTimeMax;
   gcRegsDef[ExposureTimeMinIdx].p_data = &gcRegsData.ExposureTimeMin;
   gcRegsDef[ExternalBlackBodyTemperatureIdx].p_data = &gcRegsData.ExternalBlackBodyTemperature;
   gcRegsDef[ExternalFanSpeedIdx].p_data = &gcRegsData.ExternalFanSpeed;
   gcRegsDef[ExternalFanSpeedSetpointIdx].p_data = &gcRegsData.ExternalFanSpeedSetpoint;
   gcRegsDef[HFOVIdx].p_data = &gcRegsData.HFOV;
   gcRegsDef[ImageCorrectionFWAcquisitionFrameRateIdx].p_data = &gcRegsData.ImageCorrectionFWAcquisitionFrameRate;
   gcRegsDef[ImageCorrectionFWAcquisitionFrameRateMaxIdx].p_data = &gcRegsData.ImageCorrectionFWAcquisitionFrameRateMax;
   gcRegsDef[ImageCorrectionFWAcquisitionFrameRateMinIdx].p_data = &gcRegsData.ImageCorrectionFWAcquisitionFrameRateMin;
   gcRegsDef[MemoryBufferSequenceDownloadBitRateMaxIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadBitRateMax;
   gcRegsDef[TriggerDelayIdx].p_data = &gcRegsData.TriggerDelay;
   gcRegsDef[VFOVIdx].p_data = &gcRegsData.VFOV;
   gcRegsDef[DeviceFirmwareModuleRevisionIdx].p_data = &gcRegsData.DeviceFirmwareModuleRevision;
   gcRegsDef[FOVPositionRawIdx].p_data = &gcRegsData.FOVPositionRaw;
   gcRegsDef[FOVPositionRawMaxIdx].p_data = &gcRegsData.FOVPositionRawMax;
   gcRegsDef[FOVPositionRawMinIdx].p_data = &gcRegsData.FOVPositionRawMin;
   gcRegsDef[FOVPositionRawSetpointIdx].p_data = &gcRegsData.FOVPositionRawSetpoint;
   gcRegsDef[FWPositionRawIdx].p_data = &gcRegsData.FWPositionRaw;
   gcRegsDef[FWPositionRawSetpointIdx].p_data = &gcRegsData.FWPositionRawSetpoint;
   gcRegsDef[FocusPositionRawIdx].p_data = &gcRegsData.FocusPositionRaw;
   gcRegsDef[FocusPositionRawMaxIdx].p_data = &gcRegsData.FocusPositionRawMax;
   gcRegsDef[FocusPositionRawMinIdx].p_data = &gcRegsData.FocusPositionRawMin;
   gcRegsDef[FocusPositionRawSetpointIdx].p_data = &gcRegsData.FocusPositionRawSetpoint;
   gcRegsDef[GPSAltitudeIdx].p_data = &gcRegsData.GPSAltitude;
   gcRegsDef[GPSLatitudeIdx].p_data = &gcRegsData.GPSLatitude;
   gcRegsDef[GPSLongitudeIdx].p_data = &gcRegsData.GPSLongitude;
   gcRegsDef[NDFilterPositionRawIdx].p_data = &gcRegsData.NDFilterPositionRaw;
   gcRegsDef[NDFilterPositionRawSetpointIdx].p_data = &gcRegsData.NDFilterPositionRawSetpoint;
   gcRegsDef[AcquisitionArmIdx].p_data = &gcRegsData.AcquisitionArm;
   gcRegsDef[AcquisitionFrameRateModeIdx].p_data = &gcRegsData.AcquisitionFrameRateMode;
   gcRegsDef[AcquisitionFrameRateSetToMaxIdx].p_data = &gcRegsData.AcquisitionFrameRateSetToMax;
   gcRegsDef[AcquisitionModeIdx].p_data = &gcRegsData.AcquisitionMode;
   gcRegsDef[AcquisitionStartIdx].p_data = &gcRegsData.AcquisitionStart;
   gcRegsDef[AcquisitionStartAtStartupIdx].p_data = &gcRegsData.AcquisitionStartAtStartup;
   gcRegsDef[AcquisitionStopIdx].p_data = &gcRegsData.AcquisitionStop;
   gcRegsDef[AutofocusIdx].p_data = &gcRegsData.Autofocus;
   gcRegsDef[AutofocusModeIdx].p_data = &gcRegsData.AutofocusMode;
   gcRegsDef[AutomaticExternalFanSpeedModeIdx].p_data = &gcRegsData.AutomaticExternalFanSpeedMode;
   gcRegsDef[AvailabilityFlagsIdx].p_data = &gcRegsData.AvailabilityFlags;
   gcRegsDef[BadPixelReplacementIdx].p_data = &gcRegsData.BadPixelReplacement;
   gcRegsDef[BinningModeIdx].p_data = &gcRegsData.BinningMode;
   gcRegsDef[CalibrationCollectionActiveBlockPOSIXTimeIdx].p_data = &gcRegsData.CalibrationCollectionActiveBlockPOSIXTime;
   gcRegsDef[CalibrationCollectionActivePOSIXTimeIdx].p_data = &gcRegsData.CalibrationCollectionActivePOSIXTime;
   gcRegsDef[CalibrationCollectionActiveTypeIdx].p_data = &gcRegsData.CalibrationCollectionActiveType;
   gcRegsDef[CalibrationCollectionBlockCountIdx].p_data = &gcRegsData.CalibrationCollectionBlockCount;
   gcRegsDef[CalibrationCollectionBlockLoadIdx].p_data = &gcRegsData.CalibrationCollectionBlockLoad;
   gcRegsDef[CalibrationCollectionBlockPOSIXTimeIdx].p_data = &gcRegsData.CalibrationCollectionBlockPOSIXTime;
   gcRegsDef[CalibrationCollectionBlockSelectorIdx].p_data = &gcRegsData.CalibrationCollectionBlockSelector;
   gcRegsDef[CalibrationCollectionCountIdx].p_data = &gcRegsData.CalibrationCollectionCount;
   gcRegsDef[CalibrationCollectionLoadIdx].p_data = &gcRegsData.CalibrationCollectionLoad;
   gcRegsDef[CalibrationCollectionPOSIXTimeIdx].p_data = &gcRegsData.CalibrationCollectionPOSIXTime;
   gcRegsDef[CalibrationCollectionSelectorIdx].p_data = &gcRegsData.CalibrationCollectionSelector;
   gcRegsDef[CalibrationCollectionTypeIdx].p_data = &gcRegsData.CalibrationCollectionType;
   gcRegsDef[CalibrationModeIdx].p_data = &gcRegsData.CalibrationMode;
   gcRegsDef[CenterImageIdx].p_data = &gcRegsData.CenterImage;
   gcRegsDef[ClConfigurationIdx].p_data = &gcRegsData.ClConfiguration;
   gcRegsDef[DetectorModeIdx].p_data = &gcRegsData.DetectorMode;
   gcRegsDef[DeviceBuiltInTestsResults1Idx].p_data = &gcRegsData.DeviceBuiltInTestsResults1;
   gcRegsDef[DeviceBuiltInTestsResults2Idx].p_data = &gcRegsData.DeviceBuiltInTestsResults2;
   gcRegsDef[DeviceBuiltInTestsResults3Idx].p_data = &gcRegsData.DeviceBuiltInTestsResults3;
   gcRegsDef[DeviceBuiltInTestsResults4Idx].p_data = &gcRegsData.DeviceBuiltInTestsResults4;
   gcRegsDef[DeviceBuiltInTestsResults7Idx].p_data = &gcRegsData.DeviceBuiltInTestsResults7;
   gcRegsDef[DeviceBuiltInTestsResults8Idx].p_data = &gcRegsData.DeviceBuiltInTestsResults8;
   gcRegsDef[DeviceClockSelectorIdx].p_data = &gcRegsData.DeviceClockSelector;
   gcRegsDef[DeviceCoolerPowerOnCyclesIdx].p_data = &gcRegsData.DeviceCoolerPowerOnCycles;
   gcRegsDef[DeviceCoolerRunningTimeIdx].p_data = &gcRegsData.DeviceCoolerRunningTime;
   gcRegsDef[DeviceCurrentSelectorIdx].p_data = &gcRegsData.DeviceCurrentSelector;
   gcRegsDef[DeviceFirmwareBuildVersionIdx].p_data = &gcRegsData.DeviceFirmwareBuildVersion;
   gcRegsDef[DeviceFirmwareMajorVersionIdx].p_data = &gcRegsData.DeviceFirmwareMajorVersion;
   gcRegsDef[DeviceFirmwareMinorVersionIdx].p_data = &gcRegsData.DeviceFirmwareMinorVersion;
   gcRegsDef[DeviceFirmwareModuleSelectorIdx].p_data = &gcRegsData.DeviceFirmwareModuleSelector;
   gcRegsDef[DeviceFirmwareSubMinorVersionIdx].p_data = &gcRegsData.DeviceFirmwareSubMinorVersion;
   gcRegsDef[DeviceKeyValidationHighIdx].p_data = &gcRegsData.DeviceKeyValidationHigh;
   gcRegsDef[DeviceKeyValidationLowIdx].p_data = &gcRegsData.DeviceKeyValidationLow;
   gcRegsDef[DeviceLedIndicatorStateIdx].p_data = &gcRegsData.DeviceLedIndicatorState;
   gcRegsDef[DeviceNotReadyIdx].p_data = &gcRegsData.DeviceNotReady;
   gcRegsDef[DevicePowerOnCyclesIdx].p_data = &gcRegsData.DevicePowerOnCycles;
   gcRegsDef[DevicePowerStateIdx].p_data = &gcRegsData.DevicePowerState;
   gcRegsDef[DevicePowerStateSetpointIdx].p_data = &gcRegsData.DevicePowerStateSetpoint;
   gcRegsDef[DeviceRegistersCheckIdx].p_data = &gcRegsData.DeviceRegistersCheck;
   gcRegsDef[DeviceRegistersStreamingEndIdx].p_data = &gcRegsData.DeviceRegistersStreamingEnd;
   gcRegsDef[DeviceRegistersStreamingStartIdx].p_data = &gcRegsData.DeviceRegistersStreamingStart;
   gcRegsDef[DeviceRegistersValidIdx].p_data = &gcRegsData.DeviceRegistersValid;
   gcRegsDef[DeviceResetIdx].p_data = &gcRegsData.DeviceReset;
   gcRegsDef[DeviceRunningTimeIdx].p_data = &gcRegsData.DeviceRunningTime;
   gcRegsDef[DeviceSerialNumberIdx].p_data = &gcRegsData.DeviceSerialNumber;
   gcRegsDef[DeviceSerialPortBaudRateIdx].p_data = &gcRegsData.DeviceSerialPortBaudRate;
   gcRegsDef[DeviceSerialPortFunctionIdx].p_data = &gcRegsData.DeviceSerialPortFunction;
   gcRegsDef[DeviceSerialPortSelectorIdx].p_data = &gcRegsData.DeviceSerialPortSelector;
   gcRegsDef[DeviceStabilizationTimeIdx].p_data = &gcRegsData.DeviceStabilizationTime;
   gcRegsDef[DeviceTemperatureSelectorIdx].p_data = &gcRegsData.DeviceTemperatureSelector;
   gcRegsDef[DeviceVoltageSelectorIdx].p_data = &gcRegsData.DeviceVoltageSelector;
   gcRegsDef[DeviceXMLMajorVersionIdx].p_data = &gcRegsData.DeviceXMLMajorVersion;
   gcRegsDef[DeviceXMLMinorVersionIdx].p_data = &gcRegsData.DeviceXMLMinorVersion;
   gcRegsDef[DeviceXMLSubMinorVersionIdx].p_data = &gcRegsData.DeviceXMLSubMinorVersion;
   gcRegsDef[EHDRIModeIdx].p_data = &gcRegsData.EHDRIMode;
   gcRegsDef[EHDRINumberOfExposuresIdx].p_data = &gcRegsData.EHDRINumberOfExposures;
   gcRegsDef[EHDRIResetToDefaultIdx].p_data = &gcRegsData.EHDRIResetToDefault;
   gcRegsDef[EventErrorIdx].p_data = &gcRegsData.EventError;
   gcRegsDef[EventErrorCodeIdx].p_data = &gcRegsData.EventErrorCode;
   gcRegsDef[EventErrorTimestampIdx].p_data = &gcRegsData.EventErrorTimestamp;
   gcRegsDef[EventNotificationIdx].p_data = &gcRegsData.EventNotification;
   gcRegsDef[EventSelectorIdx].p_data = &gcRegsData.EventSelector;
   gcRegsDef[EventTelopsIdx].p_data = &gcRegsData.EventTelops;
   gcRegsDef[EventTelopsCodeIdx].p_data = &gcRegsData.EventTelopsCode;
   gcRegsDef[EventTelopsTimestampIdx].p_data = &gcRegsData.EventTelopsTimestamp;
   gcRegsDef[ExposureAutoIdx].p_data = &gcRegsData.ExposureAuto;
   gcRegsDef[ExposureModeIdx].p_data = &gcRegsData.ExposureMode;
   gcRegsDef[ExposureTimeSetToMaxIdx].p_data = &gcRegsData.ExposureTimeSetToMax;
   gcRegsDef[ExposureTimeSetToMinIdx].p_data = &gcRegsData.ExposureTimeSetToMin;
   gcRegsDef[ExternalLensSerialNumberIdx].p_data = &gcRegsData.ExternalLensSerialNumber;
   gcRegsDef[FOVPositionIdx].p_data = &gcRegsData.FOVPosition;
   gcRegsDef[FOVPositionNumberIdx].p_data = &gcRegsData.FOVPositionNumber;
   gcRegsDef[FOVPositionSetpointIdx].p_data = &gcRegsData.FOVPositionSetpoint;
   gcRegsDef[FValSizeIdx].p_data = &gcRegsData.FValSize;
   gcRegsDef[FWFilterNumberIdx].p_data = &gcRegsData.FWFilterNumber;
   gcRegsDef[FWModeIdx].p_data = &gcRegsData.FWMode;
   gcRegsDef[FWPositionIdx].p_data = &gcRegsData.FWPosition;
   gcRegsDef[FWPositionSetpointIdx].p_data = &gcRegsData.FWPositionSetpoint;
   gcRegsDef[FWSpeedIdx].p_data = &gcRegsData.FWSpeed;
   gcRegsDef[FWSpeedMaxIdx].p_data = &gcRegsData.FWSpeedMax;
   gcRegsDef[FWSpeedSetpointIdx].p_data = &gcRegsData.FWSpeedSetpoint;
   gcRegsDef[FocusFarFastIdx].p_data = &gcRegsData.FocusFarFast;
   gcRegsDef[FocusFarSlowIdx].p_data = &gcRegsData.FocusFarSlow;
   gcRegsDef[FocusNearFastIdx].p_data = &gcRegsData.FocusNearFast;
   gcRegsDef[FocusNearSlowIdx].p_data = &gcRegsData.FocusNearSlow;
   gcRegsDef[GPSModeIndicatorIdx].p_data = &gcRegsData.GPSModeIndicator;
   gcRegsDef[GPSNumberOfSatellitesInUseIdx].p_data = &gcRegsData.GPSNumberOfSatellitesInUse;
   gcRegsDef[HeightIdx].p_data = &gcRegsData.Height;
   gcRegsDef[HeightIncIdx].p_data = &gcRegsData.HeightInc;
   gcRegsDef[HeightMaxIdx].p_data = &gcRegsData.HeightMax;
   gcRegsDef[HeightMinIdx].p_data = &gcRegsData.HeightMin;
   gcRegsDef[ICUPositionIdx].p_data = &gcRegsData.ICUPosition;
   gcRegsDef[ICUPositionSetpointIdx].p_data = &gcRegsData.ICUPositionSetpoint;
   gcRegsDef[ImageCorrectionIdx].p_data = &gcRegsData.ImageCorrection;
   gcRegsDef[ImageCorrectionBlockSelectorIdx].p_data = &gcRegsData.ImageCorrectionBlockSelector;
   gcRegsDef[ImageCorrectionFWModeIdx].p_data = &gcRegsData.ImageCorrectionFWMode;
   gcRegsDef[ImageCorrectionModeIdx].p_data = &gcRegsData.ImageCorrectionMode;
   gcRegsDef[IntegrationModeIdx].p_data = &gcRegsData.IntegrationMode;
   gcRegsDef[IsActiveFlagsIdx].p_data = &gcRegsData.IsActiveFlags;
   gcRegsDef[LoadSavedConfigurationAtStartupIdx].p_data = &gcRegsData.LoadSavedConfigurationAtStartup;
   gcRegsDef[LockedCenterImageIdx].p_data = &gcRegsData.LockedCenterImage;
   gcRegsDef[ManualFilterSerialNumberIdx].p_data = &gcRegsData.ManualFilterSerialNumber;
   gcRegsDef[MemoryBufferAvailableFreeSpaceHighIdx].p_data = &gcRegsData.MemoryBufferAvailableFreeSpaceHigh;
   gcRegsDef[MemoryBufferAvailableFreeSpaceLowIdx].p_data = &gcRegsData.MemoryBufferAvailableFreeSpaceLow;
   gcRegsDef[MemoryBufferFragmentedFreeSpaceHighIdx].p_data = &gcRegsData.MemoryBufferFragmentedFreeSpaceHigh;
   gcRegsDef[MemoryBufferFragmentedFreeSpaceLowIdx].p_data = &gcRegsData.MemoryBufferFragmentedFreeSpaceLow;
   gcRegsDef[MemoryBufferLegacyModeIdx].p_data = &gcRegsData.MemoryBufferLegacyMode;
   gcRegsDef[MemoryBufferMOIActivationIdx].p_data = &gcRegsData.MemoryBufferMOIActivation;
   gcRegsDef[MemoryBufferMOISoftwareIdx].p_data = &gcRegsData.MemoryBufferMOISoftware;
   gcRegsDef[MemoryBufferMOISourceIdx].p_data = &gcRegsData.MemoryBufferMOISource;
   gcRegsDef[MemoryBufferModeIdx].p_data = &gcRegsData.MemoryBufferMode;
   gcRegsDef[MemoryBufferNumberOfImagesMaxIdx].p_data = &gcRegsData.MemoryBufferNumberOfImagesMax;
   gcRegsDef[MemoryBufferNumberOfSequencesIdx].p_data = &gcRegsData.MemoryBufferNumberOfSequences;
   gcRegsDef[MemoryBufferNumberOfSequencesMaxIdx].p_data = &gcRegsData.MemoryBufferNumberOfSequencesMax;
   gcRegsDef[MemoryBufferNumberOfSequencesMinIdx].p_data = &gcRegsData.MemoryBufferNumberOfSequencesMin;
   gcRegsDef[MemoryBufferSequenceBadPixelReplacementIdx].p_data = &gcRegsData.MemoryBufferSequenceBadPixelReplacement;
   gcRegsDef[MemoryBufferSequenceCalibrationModeIdx].p_data = &gcRegsData.MemoryBufferSequenceCalibrationMode;
   gcRegsDef[MemoryBufferSequenceClearIdx].p_data = &gcRegsData.MemoryBufferSequenceClear;
   gcRegsDef[MemoryBufferSequenceClearAllIdx].p_data = &gcRegsData.MemoryBufferSequenceClearAll;
   gcRegsDef[MemoryBufferSequenceCountIdx].p_data = &gcRegsData.MemoryBufferSequenceCount;
   gcRegsDef[MemoryBufferSequenceDefragIdx].p_data = &gcRegsData.MemoryBufferSequenceDefrag;
   gcRegsDef[MemoryBufferSequenceDownloadFrameCountIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadFrameCount;
   gcRegsDef[MemoryBufferSequenceDownloadFrameIDIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadFrameID;
   gcRegsDef[MemoryBufferSequenceDownloadFrameImageCountIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadFrameImageCount;
   gcRegsDef[MemoryBufferSequenceDownloadImageFrameIDIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadImageFrameID;
   gcRegsDef[MemoryBufferSequenceDownloadModeIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadMode;
   gcRegsDef[MemoryBufferSequenceDownloadSuggestedFrameImageCountIdx].p_data = &gcRegsData.MemoryBufferSequenceDownloadSuggestedFrameImageCount;
   gcRegsDef[MemoryBufferSequenceFirstFrameIDIdx].p_data = &gcRegsData.MemoryBufferSequenceFirstFrameID;
   gcRegsDef[MemoryBufferSequenceHeightIdx].p_data = &gcRegsData.MemoryBufferSequenceHeight;
   gcRegsDef[MemoryBufferSequenceMOIFrameIDIdx].p_data = &gcRegsData.MemoryBufferSequenceMOIFrameID;
   gcRegsDef[MemoryBufferSequenceOffsetXIdx].p_data = &gcRegsData.MemoryBufferSequenceOffsetX;
   gcRegsDef[MemoryBufferSequenceOffsetYIdx].p_data = &gcRegsData.MemoryBufferSequenceOffsetY;
   gcRegsDef[MemoryBufferSequencePreMOISizeIdx].p_data = &gcRegsData.MemoryBufferSequencePreMOISize;
   gcRegsDef[MemoryBufferSequenceRecordedSizeIdx].p_data = &gcRegsData.MemoryBufferSequenceRecordedSize;
   gcRegsDef[MemoryBufferSequenceSelectorIdx].p_data = &gcRegsData.MemoryBufferSequenceSelector;
   gcRegsDef[MemoryBufferSequenceSizeIdx].p_data = &gcRegsData.MemoryBufferSequenceSize;
   gcRegsDef[MemoryBufferSequenceSizeIncIdx].p_data = &gcRegsData.MemoryBufferSequenceSizeInc;
   gcRegsDef[MemoryBufferSequenceSizeMaxIdx].p_data = &gcRegsData.MemoryBufferSequenceSizeMax;
   gcRegsDef[MemoryBufferSequenceSizeMinIdx].p_data = &gcRegsData.MemoryBufferSequenceSizeMin;
   gcRegsDef[MemoryBufferSequenceWidthIdx].p_data = &gcRegsData.MemoryBufferSequenceWidth;
   gcRegsDef[MemoryBufferStatusIdx].p_data = &gcRegsData.MemoryBufferStatus;
   gcRegsDef[MemoryBufferTotalSpaceHighIdx].p_data = &gcRegsData.MemoryBufferTotalSpaceHigh;
   gcRegsDef[MemoryBufferTotalSpaceLowIdx].p_data = &gcRegsData.MemoryBufferTotalSpaceLow;
   gcRegsDef[NDFilterArmedPositionSetpointIdx].p_data = &gcRegsData.NDFilterArmedPositionSetpoint;
   gcRegsDef[NDFilterNumberIdx].p_data = &gcRegsData.NDFilterNumber;
   gcRegsDef[NDFilterPositionIdx].p_data = &gcRegsData.NDFilterPosition;
   gcRegsDef[NDFilterPositionSetpointIdx].p_data = &gcRegsData.NDFilterPositionSetpoint;
   gcRegsDef[OffsetXIdx].p_data = &gcRegsData.OffsetX;
   gcRegsDef[OffsetXIncIdx].p_data = &gcRegsData.OffsetXInc;
   gcRegsDef[OffsetXMaxIdx].p_data = &gcRegsData.OffsetXMax;
   gcRegsDef[OffsetXMinIdx].p_data = &gcRegsData.OffsetXMin;
   gcRegsDef[OffsetYIdx].p_data = &gcRegsData.OffsetY;
   gcRegsDef[OffsetYIncIdx].p_data = &gcRegsData.OffsetYInc;
   gcRegsDef[OffsetYMaxIdx].p_data = &gcRegsData.OffsetYMax;
   gcRegsDef[OffsetYMinIdx].p_data = &gcRegsData.OffsetYMin;
   gcRegsDef[POSIXTimeIdx].p_data = &gcRegsData.POSIXTime;
   gcRegsDef[PayloadSizeMinFGIdx].p_data = &gcRegsData.PayloadSizeMinFG;
   gcRegsDef[PixelDataResolutionIdx].p_data = &gcRegsData.PixelDataResolution;
   gcRegsDef[PixelFormatIdx].p_data = &gcRegsData.PixelFormat;
   gcRegsDef[PowerOnAtStartupIdx].p_data = &gcRegsData.PowerOnAtStartup;
   gcRegsDef[ProprietaryFeatureIdx].p_data = &gcRegsData.ProprietaryFeature;
   gcRegsDef[ReverseXIdx].p_data = &gcRegsData.ReverseX;
   gcRegsDef[ReverseYIdx].p_data = &gcRegsData.ReverseY;
   gcRegsDef[SaveConfigurationIdx].p_data = &gcRegsData.SaveConfiguration;
   gcRegsDef[SensorHeightIdx].p_data = &gcRegsData.SensorHeight;
   gcRegsDef[SensorIDIdx].p_data = &gcRegsData.SensorID;
   gcRegsDef[SensorWellDepthIdx].p_data = &gcRegsData.SensorWellDepth;
   gcRegsDef[SensorWidthIdx].p_data = &gcRegsData.SensorWidth;
   gcRegsDef[StealthModeIdx].p_data = &gcRegsData.StealthMode;
   gcRegsDef[SubSecondTimeIdx].p_data = &gcRegsData.SubSecondTime;
   gcRegsDef[TDCFlagsIdx].p_data = &gcRegsData.TDCFlags;
   gcRegsDef[TDCFlags2Idx].p_data = &gcRegsData.TDCFlags2;
   gcRegsDef[TDCStatusIdx].p_data = &gcRegsData.TDCStatus;
   gcRegsDef[TestImageSelectorIdx].p_data = &gcRegsData.TestImageSelector;
   gcRegsDef[TimeSourceIdx].p_data = &gcRegsData.TimeSource;
   gcRegsDef[TriggerActivationIdx].p_data = &gcRegsData.TriggerActivation;
   gcRegsDef[TriggerFrameCountIdx].p_data = &gcRegsData.TriggerFrameCount;
   gcRegsDef[TriggerModeIdx].p_data = &gcRegsData.TriggerMode;
   gcRegsDef[TriggerSelectorIdx].p_data = &gcRegsData.TriggerSelector;
   gcRegsDef[TriggerSoftwareIdx].p_data = &gcRegsData.TriggerSoftware;
   gcRegsDef[TriggerSourceIdx].p_data = &gcRegsData.TriggerSource;
   gcRegsDef[VideoAGCIdx].p_data = &gcRegsData.VideoAGC;
   gcRegsDef[VideoBadPixelReplacementIdx].p_data = &gcRegsData.VideoBadPixelReplacement;
   gcRegsDef[VideoFreezeIdx].p_data = &gcRegsData.VideoFreeze;
   gcRegsDef[WidthIdx].p_data = &gcRegsData.Width;
   gcRegsDef[WidthIncIdx].p_data = &gcRegsData.WidthInc;
   gcRegsDef[WidthMaxIdx].p_data = &gcRegsData.WidthMax;
   gcRegsDef[WidthMinIdx].p_data = &gcRegsData.WidthMin;
   gcRegsDef[ZoomInFastIdx].p_data = &gcRegsData.ZoomInFast;
   gcRegsDef[ZoomInSlowIdx].p_data = &gcRegsData.ZoomInSlow;
   gcRegsDef[ZoomOutFastIdx].p_data = &gcRegsData.ZoomOutFast;
   gcRegsDef[ZoomOutSlowIdx].p_data = &gcRegsData.ZoomOutSlow;
   gcRegsDef[DeviceIDIdx].p_data = &gcRegsData.DeviceID;
   gcRegsDef[DeviceManufacturerInfoIdx].p_data = &gcRegsData.DeviceManufacturerInfo;
   gcRegsDef[DeviceModelNameIdx].p_data = &gcRegsData.DeviceModelName;
   gcRegsDef[DeviceVendorNameIdx].p_data = &gcRegsData.DeviceVendorName;
   gcRegsDef[DeviceVersionIdx].p_data = &gcRegsData.DeviceVersion;
   gcRegsDef[GevFirstURLIdx].p_data = &gcRegsData.GevFirstURL;
   gcRegsDef[GevSecondURLIdx].p_data = &gcRegsData.GevSecondURL;
}

/**
 * Restore GenICam registers data factory values.
 */
void GC_RestoreDataFactory()
{
   gcRegsData = gcRegsDataFactory;
   memcpy(DeviceClockFrequencyAry, DeviceClockFrequencyAryFactory, sizeof(DeviceClockFrequencyAry));
   memcpy(DeviceTemperatureAry, DeviceTemperatureAryFactory, sizeof(DeviceTemperatureAry));
   memcpy(DeviceVoltageAry, DeviceVoltageAryFactory, sizeof(DeviceVoltageAry));
   memcpy(DeviceCurrentAry, DeviceCurrentAryFactory, sizeof(DeviceCurrentAry));
   memcpy(DeviceSerialPortBaudRateAry, DeviceSerialPortBaudRateAryFactory, sizeof(DeviceSerialPortBaudRateAry));
   memcpy(DeviceSerialPortFunctionAry, DeviceSerialPortFunctionAryFactory, sizeof(DeviceSerialPortFunctionAry));
   memcpy(EventNotificationAry, EventNotificationAryFactory, sizeof(EventNotificationAry));
   memcpy(DeviceFirmwareModuleRevisionAry, DeviceFirmwareModuleRevisionAryFactory, sizeof(DeviceFirmwareModuleRevisionAry));
   memcpy(TriggerModeAry, TriggerModeAryFactory, sizeof(TriggerModeAry));
   memcpy(TriggerSourceAry, TriggerSourceAryFactory, sizeof(TriggerSourceAry));
   memcpy(TriggerActivationAry, TriggerActivationAryFactory, sizeof(TriggerActivationAry));
   memcpy(TriggerDelayAry, TriggerDelayAryFactory, sizeof(TriggerDelayAry));
   memcpy(TriggerFrameCountAry, TriggerFrameCountAryFactory, sizeof(TriggerFrameCountAry));
}

/* AUTO-CODE END */


/**
 * Update GenICam registers lock flag.
 * This function is called every time a write is performed and updates the locked
 * flag for ALL registers.
 */
void GC_UpdateLockedFlag()
{
   // Update registers value.
   GC_DeviceNotReadyCallback(GCCP_BEFORE, GCCA_READ);
   GC_CalibrationCollectionTypeCallback(GCCP_BEFORE, GCCA_READ);
   GC_CalibrationCollectionActiveTypeCallback(GCCP_BEFORE, GCCA_READ);
   GC_CalibrationCollectionPOSIXTimeCallback(GCCP_BEFORE, GCCA_READ);
   GC_CalibrationCollectionActivePOSIXTimeCallback(GCCP_BEFORE, GCCA_READ);

/* AUTO-CODE REGLOCKED BEGIN */
   SetRegLocked(&gcRegsDef[WidthIdx], ((GC_MemoryBufferBusy || GC_MemoryBufferNotEmptyLegacy || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[HeightIdx], ((GC_MemoryBufferBusy || GC_MemoryBufferNotEmptyLegacy || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[AcquisitionStartIdx], (GC_MemoryBufferProcessingData || gcRegsData.DeviceNotReady));
   SetRegLocked(&gcRegsDef[AcquisitionStopIdx], (GC_WaitingForImageCorrection || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[AcquisitionArmIdx], ((GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[DetectorModeIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[ExposureModeIdx], (((GC_CalibrationIsActive && GC_CalibrationCollectionTypeMultipointIsActive) || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[ExposureTimeIdx], GC_ExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime1Idx], GC_EHDRIExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime2Idx], GC_EHDRIExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime3Idx], GC_EHDRIExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime4Idx], GC_EHDRIExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime5Idx], GC_ExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime6Idx], GC_ExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime7Idx], GC_ExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTime8Idx], GC_ExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTimeSetToMinIdx], GC_EHDRIExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[ExposureTimeSetToMaxIdx], GC_EHDRIExposureTimeIsLocked);
   SetRegLocked(&gcRegsDef[AcquisitionFrameRateIdx], GC_AcquisitionFrameRateIsLocked);
   SetRegLocked(&gcRegsDef[AcquisitionFrameRateSetToMaxIdx], GC_AcquisitionFrameRateIsLocked);
   SetRegLocked(&gcRegsDef[AcquisitionModeIdx], (GC_WaitingForImageCorrection || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[AcquisitionFrameRateModeIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[LoadSavedConfigurationAtStartupIdx], (GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[SaveConfigurationIdx], (GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[ExposureAutoIdx], ((GC_CalibrationIsActive && GC_CalibrationCollectionTypeMultipointIsActive) || GC_WaitingForImageCorrection || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[AECImageFractionIdx], (GC_WaitingForImageCorrection || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[AECTargetWellFillingIdx], (GC_WaitingForImageCorrection || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[AECResponseTimeIdx], (GC_WaitingForImageCorrection || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[EHDRIModeIdx], (((GC_CalibrationIsActive && GC_CalibrationCollectionTypeMultipointIsActive) || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[EHDRIExpectedTemperatureMinIdx], (GC_EHDRISimpleSettingsAreLocked || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[EHDRIExpectedTemperatureMaxIdx], (GC_EHDRISimpleSettingsAreLocked || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[EHDRINumberOfExposuresIdx], (((GC_CalibrationIsActive && GC_CalibrationCollectionTypeMultipointIsActive) || GC_WaitingForImageCorrection || (GC_EHDRIIsImplemented == 0)) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[EHDRIResetToDefaultIdx], (((GC_CalibrationIsActive && GC_CalibrationCollectionTypeMultipointIsActive) || GC_WaitingForImageCorrection || (GC_EHDRIIsImplemented == 0)) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[EHDRIExposureOccurrence1Idx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[EHDRIExposureOccurrence2Idx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[EHDRIExposureOccurrence3Idx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[EHDRIExposureOccurrence4Idx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[CalibrationModeIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[CalibrationCollectionLoadIdx], (((gcRegsData.CalibrationCollectionActivePOSIXTime == gcRegsData.CalibrationCollectionPOSIXTime) || GC_WaitingForImageCorrection || GC_MemoryBufferNotEmpty) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[CalibrationCollectionBlockLoadIdx], ((gcRegsData.CalibrationCollectionActiveBlockPOSIXTime == gcRegsData.CalibrationCollectionBlockPOSIXTime) || ((gcRegsData.CalibrationCollectionActivePOSIXTime != gcRegsData.CalibrationCollectionPOSIXTime) && (GC_AcquisitionStarted)) || (GC_FWFixedModeIsActive == 0) || (gcRegsData.CalibrationCollectionType == CCT_MultipointEHDRI) || GC_WaitingForImageCorrection || GC_AECPlusIsActive));
   SetRegLocked(&gcRegsDef[ImageCorrectionModeIdx], GC_WaitingForImageCorrection);
   SetRegLocked(&gcRegsDef[ImageCorrectionBlockSelectorIdx], GC_WaitingForImageCorrection);
   SetRegLocked(&gcRegsDef[ImageCorrectionFWModeIdx], GC_WaitingForImageCorrection);
   SetRegLocked(&gcRegsDef[ImageCorrectionFWAcquisitionFrameRateIdx], GC_WaitingForImageCorrection);
   SetRegLocked(&gcRegsDef[ImageCorrectionIdx], ((GC_WaitingForImageCorrection || GC_MemoryBufferNotEmpty || GC_AECPlusIsActive || GC_FWRotatingModeIsActive) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[NDFilterPositionSetpointIdx], ((GC_CalibrationIsActive && (GC_CalibrationCollectionTypeNDFIsActive == 0)) || GC_WaitingForImageCorrection || GC_AECPlusIsActive || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[FWModeIdx], (((GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFWIsActive == 0)) || GC_WaitingForImageCorrection || GC_AutofocusIsActive) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[FWPositionSetpointIdx], (((GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFWIsActive == 0)) || GC_AECPlusIsActive || GC_WaitingForImageCorrection || GC_AutofocusIsActive) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[FWSpeedSetpointIdx], GC_FWSynchronouslyRotatingModeIsActive);
   SetRegLocked(&gcRegsDef[FOVPositionSetpointIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection || (GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFOVIsActive == 0))));
   SetRegLocked(&gcRegsDef[ZoomInFastIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection || (GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFOVIsActive == 0))));
   SetRegLocked(&gcRegsDef[ZoomInSlowIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection || (GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFOVIsActive == 0))));
   SetRegLocked(&gcRegsDef[ZoomOutSlowIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection || (GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFOVIsActive == 0))));
   SetRegLocked(&gcRegsDef[ZoomOutFastIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection || (GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFOVIsActive == 0))));
   SetRegLocked(&gcRegsDef[FOVPositionRawSetpointIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection || (GC_CalibrationIsActive && (GC_CalibrationCollectionTypeFOVIsActive == 0))));
   SetRegLocked(&gcRegsDef[AutofocusModeIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[AutofocusROIIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[AutofocusIdx], (GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[FocusNearFastIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[FocusNearSlowIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[FocusFarSlowIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[FocusFarFastIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[FocusPositionRawSetpointIdx], (GC_AutofocusIsActive || GC_WaitingForImageCorrection));
   SetRegLocked(&gcRegsDef[ExternalLensSerialNumberIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[ManualFilterSerialNumberIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[ICUPositionSetpointIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[CenterImageIdx], ((gcRegsData.LockedCenterImage || GC_WaitingForImageCorrection || GC_FWSynchronouslyRotatingModeIsActive) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[OffsetXIdx], (GC_OffsetIsLocked || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[OffsetYIdx], (GC_OffsetIsLocked || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[PixelFormatIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[TestImageSelectorIdx], (((gcRegsData.DevicePowerState == DPS_PowerInTransition) || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[SensorWellDepthIdx], (((gcRegsData.CalibrationMode != CM_Raw0) || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[IntegrationModeIdx], (((gcRegsData.CalibrationMode != CM_Raw0) || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[BinningModeIdx], (((gcRegsData.CalibrationMode != CM_Raw0) || GC_WaitingForImageCorrection) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[TriggerModeIdx], ((GC_AcquisitionStartTriggerIsLocked || GC_FlaggingTriggerIsLocked || GC_GatingTriggerIsLocked) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[TriggerSourceIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[TriggerActivationIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[TriggerDelayIdx], (((GC_AdvancedTriggerIsImplemented == 0)) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[TriggerFrameCountIdx], (((GC_AdvancedTriggerIsImplemented == 0)) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[MemoryBufferModeIdx], ((GC_MemoryBufferNotEmpty || GC_WaitingForImageCorrection || (GC_MemoryBufferIsImplemented == 0)) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[MemoryBufferNumberOfSequencesIdx], (GC_MemoryBufferWritingProcess || (gcRegsData.MemoryBufferNumberOfSequencesMax == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceSizeIdx], (GC_MemoryBufferNotEmptyLegacy || GC_MemoryBufferWritingProcess || (gcRegsData.MemoryBufferSequenceSizeMax == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferSequencePreMOISizeIdx], (GC_MemoryBufferWritingProcess || (gcRegsData.MemoryBufferSequenceSizeMax == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferMOISourceIdx], GC_WaitingForImageCorrection);
   SetRegLocked(&gcRegsDef[MemoryBufferMOIActivationIdx], GC_MemoryBufferBusy);
   SetRegLocked(&gcRegsDef[MemoryBufferMOISoftwareIdx], (gcRegsData.MemoryBufferStatus != MBS_Recording));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceSelectorIdx], GC_MemoryBufferBusy);
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceDownloadImageFrameIDIdx], ((gcRegsData.MemoryBufferSequenceDownloadMode != MBSDM_Image) || (gcRegsData.MemoryBufferSequenceRecordedSize == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceDownloadFrameIDIdx], ((gcRegsData.MemoryBufferSequenceDownloadMode != MBSDM_Sequence) || (gcRegsData.MemoryBufferSequenceRecordedSize == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceDownloadFrameCountIdx], ((gcRegsData.MemoryBufferSequenceDownloadMode != MBSDM_Sequence) || (gcRegsData.MemoryBufferSequenceRecordedSize == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceDownloadModeIdx], (GC_MemoryBufferBusy || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceDownloadBitRateMaxIdx], (gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Off));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceClearIdx], (GC_MemoryBufferBusy || (gcRegsData.MemoryBufferSequenceRecordedSize == 0)));
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceClearAllIdx], GC_MemoryBufferBusy);
   SetRegLocked(&gcRegsDef[MemoryBufferSequenceDefragIdx], GC_MemoryBufferBusy);
   SetRegLocked(&gcRegsDef[POSIXTimeIdx], ((gcRegsData.TimeSource != TS_InternalRealTimeClock) || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[VideoAGCIdx], GC_AutofocusIsActive);
   SetRegLocked(&gcRegsDef[VideoBadPixelReplacementIdx], ((gcRegsData.VideoAGC != VAGC_Off) || GC_AutofocusIsActive));
   SetRegLocked(&gcRegsDef[VideoFreezeIdx], (GC_AutofocusIsActive || (GC_VideoOutputIsImplemented == 0)));
   SetRegLocked(&gcRegsDef[DeviceRegistersStreamingStartIdx], (GC_WaitingForImageCorrection || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[DeviceRegistersStreamingEndIdx], (GC_WaitingForImageCorrection || GC_AcquisitionStarted));
   SetRegLocked(&gcRegsDef[DeviceSerialPortSelectorIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[DeviceSerialPortBaudRateIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[DeviceSerialPortFunctionIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[EventSelectorIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[EventNotificationIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[ClConfigurationIdx], GC_AcquisitionStarted);
   SetRegLocked(&gcRegsDef[DeviceRegistersCheckIdx], GC_AcquisitionStarted);
/* AUTO-CODE REGLOCKED END */
}

/**
 * Update GenICam registers related to calibration.
 * This function is called every time calibration changes (load or mode change).
 */
void GC_UpdateCalibrationRegisters()
{
   uint32_t i;

   if (GC_CalibrationIsActive)
   {
      switch (calibrationInfo.collection.CollectionType)
      {
         case CCT_MultipointFixed:
         case CCT_MultipointNDF:
         case CCT_MultipointFOV:
            GC_SetExposureMode(EM_Timed);
            GC_SetExposureAuto(EA_Off);
            GC_SetEHDRINumberOfExposures(1);
         case CCT_TelopsFixed:
         case CCT_TelopsNDF:
         case CCT_TelopsFOV:
            GC_SetFWMode(FWM_Fixed);

            break;

         case CCT_MultipointFW:
            GC_SetExposureMode(EM_Timed);
            GC_SetExposureAuto(EA_Off);
            GC_SetEHDRINumberOfExposures(1);
            // Configure ExposureTime for FW module
            for (i = 0; i < calibrationInfo.collection.NumberOfBlocks; i++)
            {
               FWExposureTime[i] = (float)calibrationInfo.blocks[i].ExposureTime * CALIBBLOCK_EXP_TIME_TO_US;
               SFW_SetExposureTimeArray(i, FWExposureTime[i]);
            }
            GC_UpdateExposureTimeXRegisters(FWExposureTime, NUM_OF(FWExposureTime), true);
         case CCT_TelopsFW:
            break;

         case CCT_MultipointEHDRI:
            GC_SetExposureMode(EM_Timed);
            GC_SetExposureAuto(EA_Off);
            GC_SetFWMode(FWM_Fixed);
            // Configure and activate EHDRI
            GC_SetEHDRIMode(EHDRIM_Advanced);
            for (i = 0; i < calibrationInfo.collection.NumberOfBlocks; i++)
               EHDRIExposureTime[i] = (float)calibrationInfo.blocks[i].ExposureTime * CALIBBLOCK_EXP_TIME_TO_US;
            GC_UpdateExposureTimeXRegisters(EHDRIExposureTime, NUM_OF(EHDRIExposureTime), true);
            GC_SetEHDRINumberOfExposures(calibrationInfo.collection.NumberOfBlocks);
            break;
      }
   }
   if (gcRegsData.CalibrationMode != CM_Raw0)
   {
      //revert potential modifications during raw0 mode only
      GC_SetBinningMode(calibrationInfo.collection.BinningMode);
      GC_SetIntegrationMode(calibrationInfo.collection.IntegrationMode);
      GC_SetSensorWellDepth(calibrationInfo.collection.SensorWellDepth);
   }
}

/**
 * Update margin on the minimal period used by FPA module.
 * This function updates FPA period min margin according to active mode.
 */
void GC_UpdateFpaPeriodMinMargin()
{
   extern float gFpaPeriodMinMargin;

   if (gcRegsData.FWMode == FWM_SynchronouslyRotating)
      gFpaPeriodMinMargin = flashSettings.FWFramePeriodMinMargin;
   else
      gFpaPeriodMinMargin = 0.0F;

   GC_INF("Update FPA frame period margin: " _PCF(1) "%%", _FFMT((gFpaPeriodMinMargin * 100.0F), 1));
}

/**
 * Update camera parameters limits.
 * This function updates frame rate and exposure time limits according to each other.
 */
void GC_UpdateParameterLimits()
{
   uint32_t frameImageCount;
   uint32_t index;
   // Backup current ExposureTime
   const float ExposureTimeBackup = gcRegsData.ExposureTime;

   // Validate ExposureTimes of EHDRI module
   if (GC_EHDRIIsActive)
   {
      // Find max ExposureTime in EHDRI
      index = 0;
      gcRegsData.ExposureTime = EHDRIExposureTime[index++];
      for (; index < gcRegsData.EHDRINumberOfExposures; index++)
         gcRegsData.ExposureTime = MAX(gcRegsData.ExposureTime, EHDRIExposureTime[index]);
   }
   // Validate ExposureTimes of FW module
   else if (GC_FWSynchronouslyRotatingModeIsActive)
   {
      // Find max ExposureTime in FW
      index = 0;
      gcRegsData.ExposureTime = FWExposureTime[index++];
      for (; index < flashSettings.FWNumberOfFilters; index++)
         gcRegsData.ExposureTime = MAX(gcRegsData.ExposureTime, FWExposureTime[index]);
   }
   // Validate ExposureTimes of all calibration blocks
   else if (GC_CalibrationIsActive && (calibrationInfo.collection.CalibrationType == CALT_MULTIPOINT))
   {
      // Find max ExposureTime in calibration blocks
      index = 0;
      gcRegsData.ExposureTime = (float)calibrationInfo.blocks[index++].ExposureTime * CALIBBLOCK_EXP_TIME_TO_US;
      for (; index < calibrationInfo.collection.NumberOfBlocks; index++)
         gcRegsData.ExposureTime = MAX(gcRegsData.ExposureTime, (float)calibrationInfo.blocks[index].ExposureTime * CALIBBLOCK_EXP_TIME_TO_US);
   }

   // Calculate AcquisitionFrameRateMax with max ExposureTime found
   gcRegsData.AcquisitionFrameRateMax = FPA_MaxFrameRate(&gcRegsData);

   // Limit AcquisitionFrameRateMax in synchronous mode
   if (GC_FWSynchronouslyRotatingModeIsActive)
   {
      gcRegsData.AcquisitionFrameRateMax = MIN(gcRegsData.AcquisitionFrameRateMax, SFW_AcquisitionFrameRateMax);
   }

   // Return AcquisitionFrameRateMax without jumboframe limitation
   gcRegsData.AcquisitionFrameRateUnrestrictedMax = gcRegsData.AcquisitionFrameRateMax;

   // Limit AcquisitionFrameRateMax with jumboframe
   if (TDCStatusTst(AcquisitionStartedMask))
   {
      frameImageCount = MAX(gcRegsData.FValSize / (gcRegsData.Height + 2), 1);
      gcRegsData.AcquisitionFrameRateMax = MIN(gcRegsData.AcquisitionFrameRateMax, gcRegsData.AcquisitionFrameRateMaxFG * frameImageCount);
   }

   // Validate current AcquisitionFrameRate
   if (gcRegsData.AcquisitionFrameRate > gcRegsData.AcquisitionFrameRateMax)
   {
      GC_SetAcquisitionFrameRate(gcRegsData.AcquisitionFrameRateMax);
   }

   // Restore current ExposureTime
   gcRegsData.ExposureTime = ExposureTimeBackup;

   // Calculate ExposureTimeMax with current AcquisitionFrameRate
   gcRegsData.ExposureTimeMax = FPA_MaxExposureTime(&gcRegsData);

   if (GC_FWSynchronouslyRotatingModeIsActive)
   {
      gcRegsData.ExposureTimeMax = MIN(gcRegsData.ExposureTimeMax, SFW_ExposureTimeMax);
      SFW_LimitExposureTime(&gcRegsData);
   }

   // Validate current ExposureTime
   if (gcRegsData.ExposureTime > gcRegsData.ExposureTimeMax)
   {
      GC_SetExposureTime(gcRegsData.ExposureTimeMax);
   }
}

/**
 * Perform device GenICam registers verification.
 * This function performs device GenICam registers verification to ensure camera
 * configuration is valid in order to start an acquisition.
 */
IRC_Status_t GC_DeviceRegistersVerification()
{
   uint32_t heightMax = FPA_CONFIG_GET(height_max);
   uint32_t widthMax = FPA_CONFIG_GET(width_max);
   uint8_t error = 0;
   uint32_t idx;

   GC_UpdateParameterLimits();

   if ((gcRegsData.Height != heightMax) || (gcRegsData.Width != widthMax))
   {
      // Sub window
#ifdef FPA_SUBWINDOW_HEIGHT_MAX
      heightMax = FPA_SUBWINDOW_HEIGHT_MAX;
#endif
#ifdef FPA_SUBWINDOW_WIDTH_MAX
      widthMax = FPA_SUBWINDOW_WIDTH_MAX;
#endif
   }

   if ((gcRegsData.Height < gcRegsData.HeightMin) || (gcRegsData.Height > heightMax) || ((gcRegsData.Height % gcRegsData.HeightInc) != 0))
   {
#ifdef SIM
      PRINTF("CenterImage = %d, Height = %d, HeightMin = %d, HeightMax = %d, HeightInc = %d\n",
            gcRegsData.CenterImage, gcRegsData.Height, gcRegsData.HeightMin, gcRegsData.HeightMax, gcRegsData.HeightInc);
#endif
      GC_ERR("Invalid image height (%d).", gcRegsData.Height);
      GC_GenerateEventError(EECD_InvalidHeight);
      error = 1;
   }

   if ((gcRegsData.Width < gcRegsData.WidthMin) || (gcRegsData.Width > widthMax) || ((gcRegsData.Width % gcRegsData.WidthInc) != 0))
   {
#ifdef SIM
      PRINTF("CenterImage = %d, Width = %d, WidthMin = %d, WidthMax = %d, WidthInc = %d\n",
            gcRegsData.CenterImage, gcRegsData.Width, gcRegsData.WidthMin, gcRegsData.WidthMax, gcRegsData.WidthInc);
#endif
      GC_ERR("Invalid image width (%d).", gcRegsData.Width);
      GC_GenerateEventError(EECD_InvalidWidth);
      error = 1;
   }

   if ((gcRegsData.OffsetX < gcRegsData.OffsetXMin) || (gcRegsData.OffsetX > gcRegsData.OffsetXMax) || ((gcRegsData.OffsetX % gcRegsData.OffsetXInc) != 0))
   {
#ifdef SIM
      PRINTF("CenterImage = %d, OffsetX = %d, OffsetXMin = %d, OffsetXMax = %d, OffsetXInc = %d\n",
            gcRegsData.CenterImage, gcRegsData.OffsetX, gcRegsData.OffsetXMin, gcRegsData.OffsetXMax, gcRegsData.OffsetXInc);
#endif
      GC_ERR("Invalid image X offset (%d).", gcRegsData.OffsetX);
      GC_GenerateEventError(EECD_InvalidOffsetX);
      error = 1;
   }

   if ((gcRegsData.OffsetY < gcRegsData.OffsetYMin) || (gcRegsData.OffsetY > gcRegsData.OffsetYMax) || ((gcRegsData.OffsetY % gcRegsData.OffsetYInc) != 0))
   {
#ifdef SIM
      PRINTF("CenterImage = %d, OffsetY = %d, OffsetYMin = %d, OffsetYMax = %d, OffsetYInc = %d\n",
            gcRegsData.CenterImage, gcRegsData.OffsetY, gcRegsData.OffsetYMin, gcRegsData.OffsetYMax, gcRegsData.OffsetYInc);
#endif
      GC_ERR("Invalid image Y offset (%d).", gcRegsData.OffsetY);
      GC_GenerateEventError(EECD_InvalidOffsetY);
      error = 1;
   }

   if (GC_FWSynchronouslyRotatingModeIsActive)
   {
      for (idx = 0; idx < NUM_OF(pGcRegsDefExposureTimeX); idx++)
      {
         if ((*((float*)pGcRegsDefExposureTimeX[idx]->p_data) > gcRegsData.ExposureTimeMax) || (*((float*)pGcRegsDefExposureTimeX[idx]->p_data) < gcRegsData.ExposureTimeMin))
         {
            GC_ERR("Invalid exposure time %d (" _PCF(1) "us).", idx, _FFMT(*((float*)pGcRegsDefExposureTimeX[idx]->p_data), 1));
            GC_GenerateEventError(EECD_InvalidExposure);
            error = 1;
            break;
         }
      }
   }
   else if (GC_EHDRIIsActive)
   {
      for (idx = 0; idx < gcRegsData.EHDRINumberOfExposures; idx++)
      {
         if ((*((float*)pGcRegsDefExposureTimeX[idx]->p_data) > gcRegsData.ExposureTimeMax) || (*((float*)pGcRegsDefExposureTimeX[idx]->p_data) < gcRegsData.ExposureTimeMin))
         {
            GC_ERR("Invalid exposure time %d (" _PCF(1) "us).", idx, _FFMT(*((float*)pGcRegsDefExposureTimeX[idx]->p_data), 1));
            GC_GenerateEventError(EECD_InvalidExposure);
            error = 1;
            break;
         }
      }
   }
   else
   {
      if ((gcRegsData.ExposureTime > gcRegsData.ExposureTimeMax) || (gcRegsData.ExposureTime < gcRegsData.ExposureTimeMin))
      {
#ifdef SIM
         PRINTF("ExposureTime = %f, ExposureTimeMax = %f\n", gcRegsData.ExposureTime, gcRegsData.ExposureTimeMax);
#endif
         GC_ERR("Invalid exposure time (" _PCF(1) "us).", _FFMT(gcRegsData.ExposureTime, 1));
         GC_GenerateEventError(EECD_InvalidExposure);
         error = 1;
      }
   }
   
   if ((gcRegsData.AcquisitionFrameRate > gcRegsData.AcquisitionFrameRateMax) || (gcRegsData.AcquisitionFrameRate < gcRegsData.AcquisitionFrameRateMin))
   {
#ifdef SIM
      PRINTF("AcquisitionFrameRate = %f, AcquisitionFrameRateMax = %f, \n", gcRegsData.AcquisitionFrameRate, gcRegsData.AcquisitionFrameRateMax);
#endif
      GC_ERR("Invalid acquisition frame rate (%dmHz).", (uint32_t)(gcRegsData.AcquisitionFrameRate * 1000.0F));
      GC_GenerateEventError(EECD_InvalidFrameRate);
      error = 1;
   }

   if ((gcRegsData.SensorWellDepth != SWD_LowGain) &&
         ((gcRegsData.SensorWellDepth != SWD_HighGain) || (!TDCFlagsTst(HighGainSWDIsImplementedMask))))
   {
      GC_ERR("Invalid sensor well depth (%d).", gcRegsData.SensorWellDepth);
      GC_GenerateEventError(EECD_InvalidWellDepth);
      error = 1;
   }

   if (((gcRegsData.IntegrationMode == IM_IntegrateThenRead)  && !TDCFlagsTst(ITRIsImplementedMask)) ||
         ((gcRegsData.IntegrationMode == IM_IntegrateWhileRead) && !TDCFlagsTst(IWRIsImplementedMask)))
   {
      GC_ERR("Invalid integration mode (%d).", gcRegsData.IntegrationMode);
      GC_GenerateEventError(EECD_InvalidIntegrationMode);
      error = 1;
   }

// TODO Find a way to generate TDC status errors.
/*
 * Following errors will never be generated as long as AcquisitionStart register
 * is locked using TDCStatus value.

   if (gcRegsData.TestImageSelector == TIS_Off)
   {
#ifndef SIM
      if (TDCStatusTst(WaitingForCoolerMask))
      {
         GC_ERR("Waiting for cooler.");
         GC_GenerateEventError(EECD_WaitingForCooler);
         error = 1;
      }

      if (TDCStatusTst(WaitingForICUMask))
      {
         GC_ERR("Waiting for ICU controller.");
         GC_GenerateEventError(EECD_WaitingForICU);
         error = 1;
      }

      if (TDCStatusTst(WaitingForNDFilterMask))
      {
         GC_ERR("Waiting for NDF controller.");
         GC_GenerateEventError(EECD_WaitingForNDFilter);
         error = 1;
      }

      if (TDCStatusTst(WaitingForFilterWheelMask))
      {
         GC_ERR("Waiting for filter wheel.");
         GC_GenerateEventError(EECD_WaitingForFilterWheel);
         error = 1;
      }
#endif
   }

   if (TDCStatusTst(AcquisitionStartedMask))
   {
      GC_ERR("Acquisition is already started.");
      GC_GenerateEventError(EECD_AcquisitionStarted);
      error = 1;
   }

   if (TDCStatusTst(WaitingForCalibrationDataMask))
   {
      GC_ERR("Calibration data is loading.");
      GC_GenerateEventError(EECD_WaitingForCalibrationData);
      error = 1;
   }

   if (TDCStatusTst(WaitingForImageCorrectionMask))
   {
      GC_ERR("Waiting for image correction.");
      GC_GenerateEventError(EECD_WaitingForImageCorrection);
      error = 1;
   }

   if (TDCStatusTst(WaitingForOutputFPGAMask))
   {
      GC_ERR("Waiting for output FPGA.");
      GC_GenerateEventError(EECD_WaitingForOutputFPGA);
      error = 1;
   }

   if (TDCStatusTst(WaitingForPowerMask))
   {
      GC_ERR("Camera power state is in transition.");
      GC_GenerateEventError(EECD_WaitingForPower);
      error = 1;
   }
*/

   if ((gcRegsData.CalibrationMode == CM_Raw0) && (!AvailabilityFlagsTst(Raw0IsAvailableMask)))
   {
      GC_ERR("Raw0 calibration mode is not available.");
      GC_GenerateEventError(EECD_RawNotAvailable);
      error = 1;
   }

   if ((gcRegsData.CalibrationMode == CM_Raw) && (!AvailabilityFlagsTst(RawIsAvailableMask)))
   {
      GC_ERR("Raw calibration mode is not available.");
      GC_GenerateEventError(EECD_RawNotAvailable);
      error = 1;
   }

   if ((gcRegsData.CalibrationMode == CM_NUC) && (!AvailabilityFlagsTst(NUCIsAvailableMask)))
   {
      GC_ERR("NUC calibration mode is not available.");
      GC_GenerateEventError(EECD_NUCNotAvailable);
      error = 1;
   }

   if (((gcRegsData.CalibrationMode == CM_RT) && (!AvailabilityFlagsTst(RTIsAvailableMask))) ||
         ((gcRegsData.CalibrationMode == CM_IBR) && (!AvailabilityFlagsTst(IBRIsAvailableMask))) ||
         ((gcRegsData.CalibrationMode == CM_IBI) && (!AvailabilityFlagsTst(IBIIsAvailableMask))))
   {
      GC_ERR("RQ calibration mode is not available.");
      GC_GenerateEventError(EECD_RQNotAvailable);
      error = 1;
   }

   if(((gcRegsData.BinningMode == BM_Mode2x2)  && !TDCFlags2Tst(Binning2x2IsImplementedMask)) ||
      ((gcRegsData.BinningMode == BM_Mode4x4)  && !TDCFlags2Tst(Binning4x4IsImplementedMask)))
   {
      GC_ERR("Binning mode is not available.");
      GC_GenerateEventError(EECD_BinningModeNotAvailable);
      error = 1;
   }

   if (error)
   {
      gcRegsData.DeviceRegistersValid = 0;
      TDCStatusSet(WaitingForValidParametersMask);

      return IRC_FAILURE;
   }

   gcRegsData.DeviceRegistersValid = 1;
   TDCStatusClr(WaitingForValidParametersMask);

   return IRC_SUCCESS;
}

/**
 * Update offsets and image limits.
 * This function computes X and Y offsets and width and height limits
 * according to CenterImage register value.
 */
void GC_UpdateImageLimits()
{
   if (gcRegsData.CenterImage)
   {
      // Offset X limits
      GC_SetOffsetX((FPA_CONFIG_GET(width_max) - gcRegsData.Width) / 2);
      gcRegsData.OffsetXMin = gcRegsData.OffsetX;
      gcRegsData.OffsetXMax = gcRegsData.OffsetX;

      // Offset Y limits
#ifdef FPA_OFFSETY_MULT_CORR
      GC_SetOffsetY(roundDown((FPA_CONFIG_GET(height_max) - gcRegsData.Height) / 2, FPA_OFFSETY_MULT_CORR));
#else
      GC_SetOffsetY((FPA_CONFIG_GET(height_max) - gcRegsData.Height) / 2);
#endif
      gcRegsData.OffsetYMin = gcRegsData.OffsetY;
      gcRegsData.OffsetYMax = gcRegsData.OffsetY;
   }
   else
   {
      // Offset X limits
      gcRegsData.OffsetXMin =FPA_CONFIG_GET(offsetx_min);
#ifdef FPA_SUBWINDOW_WIDTH_MAX
      if (gcRegsData.Width <= FPA_SUBWINDOW_WIDTH_MAX)
      {
         gcRegsData.OffsetXMax = FPA_SUBWINDOW_WIDTH_MAX - gcRegsData.Width;
      }
      else
      {
         gcRegsData.OffsetXMax = FPA_CONFIG_GET(width_max) - gcRegsData.Width;
      }
#else
      gcRegsData.OffsetXMax = FPA_CONFIG_GET(offsetx_max);
#endif
      if (gcRegsData.OffsetX > gcRegsData.OffsetXMax)
         GC_SetOffsetX(gcRegsData.OffsetXMax);

      // Offset Y limits
      gcRegsData.OffsetYMin = FPA_CONFIG_GET(offsety_min);
#ifdef FPA_SUBWINDOW_HEIGHT_MAX
      if (gcRegsData.Height <= FPA_SUBWINDOW_HEIGHT_MAX)
      {
         gcRegsData.OffsetYMax = FPA_SUBWINDOW_HEIGHT_MAX - gcRegsData.Height;
      }
      else
      {
         gcRegsData.OffsetYMax = FPA_CONFIG_GET(height_max) - gcRegsData.Height;
      }
#else
      gcRegsData.OffsetYMax = FPA_CONFIG_GET(height_max) - gcRegsData.Height;
#endif
      if (gcRegsData.OffsetY > gcRegsData.OffsetYMax)
         GC_SetOffsetY(gcRegsData.OffsetYMax);
   }
   //Update Inc in the case binning mode was changed
   gcRegsData.HeightInc = FPA_CONFIG_GET(height_inc);
   gcRegsData.WidthInc = lcm(FPA_CONFIG_GET(width_mult), 2 * FPA_CONFIG_GET(offsetx_mult));

}

/**
 * Update external fan speed according to setpoint.
 */
void GC_UpdateExternalFanSpeed()
{
   extern t_fan gFan;
   FAN_SET_PWM1(&gFan, gcRegsData.ExternalFanSpeedSetpoint);
   gcRegsData.ExternalFanSpeed = gcRegsData.ExternalFanSpeedSetpoint;
}

/**
 * Unlock all of the camera features.
 */
void GC_UnlockCamera()
{
   gGC_ProprietaryFeatureKeyIsValid = 1;
   GC_INF("Camera unlocked!!!");

   // Unlock features
   AvailabilityFlagsSet(CalibrationIsAvailableMask | Raw0IsAvailableMask | ExternalFanControlIsAvailableMask);
   if (flashSettings.FWPresent == 1 && flashSettings.FWType == FW_SYNC)
   {
      // Update and share value
      TDCFlagsSet(FWAsynchronouslyRotatingModeIsImplementedMask);
      GC_SetTDCFlags(gcRegsData.TDCFlags);
   }
   if (gcRegsData.DevicePowerState == DPS_PowerOn)
   {
      AvailabilityFlagsSet(ManufacturerTestImageIsAvailableMask);
   }
   GC_UpdateExposureTimeMin();
}

void GC_UpdateMemoryBufferRegistersOwner(gcRegistersOwner_t regOwner)
{
   gcRegsDef[DeviceBuiltInTestsResults7Idx].owner = regOwner;
   gcRegsDef[DeviceBuiltInTestsResults8Idx].owner = regOwner;
   gcRegsDef[MemoryBufferModeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferLegacyModeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferStatusIdx].owner = regOwner;
   gcRegsDef[MemoryBufferAvailableFreeSpaceHighIdx].owner = regOwner;
   gcRegsDef[MemoryBufferAvailableFreeSpaceLowIdx].owner = regOwner;
   gcRegsDef[MemoryBufferFragmentedFreeSpaceHighIdx].owner = regOwner;
   gcRegsDef[MemoryBufferFragmentedFreeSpaceLowIdx].owner = regOwner;
   gcRegsDef[MemoryBufferTotalSpaceHighIdx].owner = regOwner;
   gcRegsDef[MemoryBufferTotalSpaceLowIdx].owner = regOwner;
   gcRegsDef[MemoryBufferNumberOfImagesMaxIdx].owner = regOwner;
   gcRegsDef[MemoryBufferNumberOfSequencesMaxIdx].owner = regOwner;
   gcRegsDef[MemoryBufferNumberOfSequencesMinIdx].owner = regOwner;
   gcRegsDef[MemoryBufferNumberOfSequencesIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceSizeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceSizeMinIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceSizeMaxIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceSizeIncIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequencePreMOISizeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceCountIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceSelectorIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceOffsetXIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceOffsetYIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceWidthIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceHeightIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceCalibrationModeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceBadPixelReplacementIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceFirstFrameIDIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceMOIFrameIDIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceRecordedSizeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDownloadModeIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDownloadImageFrameIDIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDownloadFrameIDIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDownloadFrameCountIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDownloadBitRateMaxIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDownloadSuggestedFrameImageCountIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceClearIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceClearAllIdx].owner = regOwner;
   gcRegsDef[MemoryBufferSequenceDefragIdx].owner = regOwner;
}

/**
 * Update filter wheel position setpoint.
 */
void GC_UpdateFWPositionSetpoint(uint32_t prevFWPositionSetpoint, uint32_t newFWPositionSetpoint)
{
   int32_t counts;

   gcRegsData.FWPositionSetpoint = newFWPositionSetpoint;

   if (gcRegsData.FWPositionSetpoint < flashSettings.FWNumberOfFilters)
   {
      if (FW_getFilterPosition(gcRegsData.FWPositionSetpoint, &counts))
      {
         ChangeFWControllerMode(FW_POSITION_MODE, counts);
      }
   }
   else
   {
      gcRegsData.FWPositionSetpoint = prevFWPositionSetpoint;
   }
}

/**
 * Update neutral density filter position setpoint.
 */
void GC_UpdateNDFPositionSetpoint(uint32_t prevNDFPositionSetpoint, uint32_t newNDFPositionSetpoint)
{
   int32_t counts;

   gcRegsData.NDFilterPositionSetpoint = newNDFPositionSetpoint;

   if (gcRegsData.NDFilterPositionSetpoint < flashSettings.NDFNumberOfFilters)
   {
      if (NDF_getFilterPosition(gcRegsData.NDFilterPositionSetpoint, &counts))
      {
         ChangeNDFControllerMode(NDF_POSITION_MODE, counts);
      }
   }
   else
   {
      gcRegsData.NDFilterPositionSetpoint = prevNDFPositionSetpoint;
   }
}

/**
 * Return a timestamp corresponding to actual POSIX time.
 *
 * @return a timestamp corresponding to actual POSIX time.
 */
uint32_t GC_GetTimestamp()
{
   extern t_Trig gTrig;
   t_PosixTime time = TRIG_GetRTC(&gTrig);
   return time.Seconds;
}

/**
 * Update ExposureTimeX registers.
 *
 * @param p_src is a pointer on the data to copy.
 * @param len is the number of elements to update.
 */
void GC_UpdateExposureTimeXRegisters(float* p_src, uint32_t len, bool GcRegsDataOnly)
{
   uint32_t idx;

   // Verify length
   if (len > NUM_OF(pGcRegsDefExposureTimeX))
      return;

   // Copy data in the referenced registers
   for (idx = 0; idx < len; idx++)
   {
      if (GcRegsDataOnly)
      {
         *((float*)pGcRegsDefExposureTimeX[idx]->p_data) = p_src[idx];
}
      else
      {
         GC_RegisterWriteFloat(pGcRegsDefExposureTimeX[idx], p_src[idx]);
      }
   }

}
/**
 * Update exposure time register(s) depending on activated features.
 *
 * @param exposureTime is the exposure time value.
 */
void GC_UpdateExposureTimeRegisters(float exposureTime)
{
   uint32_t expIdx;

   if (GC_EHDRIIsActive)
   {
      for (expIdx = 0; expIdx < EHDRI_IDX_NBR; expIdx++)
      {
         GC_RegisterWriteFloat(pGcRegsDefExposureTimeX[expIdx], exposureTime);
      }
   }
   else if (GC_FWSynchronouslyRotatingModeIsActive)
   {
      for (expIdx = 0; expIdx < MAX_NUM_FILTER; expIdx++)
      {
         GC_RegisterWriteFloat(pGcRegsDefExposureTimeX[expIdx], exposureTime);
      }
   }
   else
   {
      GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeIdx], exposureTime);
   }
}

/**
 * Update device serial ports function according to DeviceSerialPortFunctionAry.
 *
 * @param updatedPort is the port that has been updated. It is prioritised for terminal assignation.
 */
void GC_UpdateDeviceSerialPortFunction(DeviceSerialPortSelector_t updatedPort)
{
   extern ctrlIntf_t gCtrlIntf_OEM;
   extern ctrlIntf_t gCtrlIntf_CameraLink;
   extern debugTerminal_t gDebugTerminal;
   extern circularUART_t gCircularUART_USB;
   extern circularUART_t gCircularUART_RS232;
   extern circularUART_t gCircularUART_CameraLink;
   extern flashDynamicValues_t gFlashDynamicValues;
   uint32_t i;

   // Make sure that no other serial port is configured as terminal
   if (DeviceSerialPortFunctionAry[updatedPort] == DSPF_Terminal)
   {
      for (i = 0; i < DeviceSerialPortFunctionAryLen; i++)
      {
         if ((i != updatedPort) && (DeviceSerialPortFunctionAry[i] == DSPF_Terminal))
         {
            DeviceSerialPortFunctionAry[i] = DSPF_Disabled;
         }
      }
   }

   /*******************************************
    * Camera Link circular UART
    *******************************************/

   // Disconnect camera link circular UART if necessary
   if ((&gCircularUART_CameraLink == gCtrlIntf_CameraLink.p_link) && (DeviceSerialPortFunctionAry[DSPS_CameraLink] != DSPF_Control))
   {
      CtrlIntf_SetLink(&gCtrlIntf_CameraLink, CILT_UNDEFINED, NULL);
   }
   if ((&gCircularUART_CameraLink == gDebugTerminal.cuart) && (DeviceSerialPortFunctionAry[DSPS_CameraLink] != DSPF_Terminal))
   {
      DebugTerminal_SetSerial(&gDebugTerminal, NULL);
   }

   // Set camera link circular UART function
   switch (DeviceSerialPortFunctionAry[DSPS_CameraLink])
   {
      case DSPF_Disabled:
         CircularUART_Disable(&gCircularUART_CameraLink);
         break;

      case DSPF_Control:
         CtrlIntf_SetLink(&gCtrlIntf_CameraLink, CILT_CUART, &gCircularUART_CameraLink);
         CircularUART_Enable(&gCircularUART_CameraLink);
         break;

      case DSPF_Terminal:
         DebugTerminal_SetSerial(&gDebugTerminal, &gCircularUART_CameraLink);
         CircularUART_Enable(&gCircularUART_CameraLink);
         break;
   }

   /*******************************************
    * RS-232 circular UART
    *******************************************/

   // Disconnect RS-232 circular UART if necessary
   if ((&gCircularUART_RS232 == gCtrlIntf_OEM.p_link) && (DeviceSerialPortFunctionAry[DSPS_RS232] != DSPF_Control))
   {
      CtrlIntf_SetLink(&gCtrlIntf_OEM, CILT_UNDEFINED, NULL);
   }
   if ((&gCircularUART_RS232 == gDebugTerminal.cuart) && (DeviceSerialPortFunctionAry[DSPS_RS232] != DSPF_Terminal))
   {
      DebugTerminal_SetSerial(&gDebugTerminal, NULL);
   }

   // Set RS-232 circular UART function
   switch (DeviceSerialPortFunctionAry[DSPS_RS232])
   {
      case DSPF_Disabled:
         CircularUART_Disable(&gCircularUART_RS232);
         break;

      case DSPF_Control:
         CtrlIntf_SetLink(&gCtrlIntf_OEM, CILT_CUART, &gCircularUART_RS232);
         CircularUART_Enable(&gCircularUART_RS232);
         break;

      case DSPF_Terminal:
         DebugTerminal_SetSerial(&gDebugTerminal, &gCircularUART_RS232);
         CircularUART_Enable(&gCircularUART_RS232);
         break;
   }

   gFlashDynamicValues.DeviceSerialPortFunctionRS232 = DeviceSerialPortFunctionAry[DSPS_RS232];

   if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
   {
      GC_ERR("Failed to update flash dynamic values.");
   }

   /*******************************************
    * USB circular UART
    *******************************************/

   // Disconnect USB circular UART if necessary
   if ((&gCircularUART_USB == gDebugTerminal.cuart) && (DeviceSerialPortFunctionAry[DSPS_USB] != DSPF_Terminal))
   {
      DebugTerminal_SetSerial(&gDebugTerminal, NULL);
   }

   // Set RS-232 circular UART function
   switch (DeviceSerialPortFunctionAry[DSPS_USB])
   {
      case DSPF_Disabled:
      case DSPF_Control:
         CircularUART_Disable(&gCircularUART_USB);
         break;

      case DSPF_Terminal:
         DebugTerminal_SetSerial(&gDebugTerminal, &gCircularUART_USB);
         CircularUART_Enable(&gCircularUART_USB);
         break;
   }
}

/**
 * Update HFOV and VFOV.
 */
void GC_UpdateFOV()
{
   float focalLen;
   extern uint16_t gMotorLensFocalLength;
   extern t_HderInserter gHderInserter;

   // Find focal length
   if (TDCFlagsTst(MotorizedFOVLensIsImplementedMask))
      focalLen = ((float)gMotorLensFocalLength) / 1000.0F;
   else
      focalLen = ((float)calibrationInfo.blocks[0].ExternalLensFocalLength) / 1000.0F;

   if (calibrationInfo.isValid && (focalLen != 0.0F))
   {
      // Compute FOVs
      gcRegsData.HFOV = atanf( (float)gcRegsData.Width  * FPA_PIXEL_PITCH / (2.0F * focalLen) ) * 2.0F * 180.0F / (float)M_PI;  //in degrees
      gcRegsData.VFOV = atanf( (float)gcRegsData.Height * FPA_PIXEL_PITCH / (2.0F * focalLen) ) * 2.0F * 180.0F / (float)M_PI;  //in degrees

      // Round values
      gcRegsData.HFOV = roundMultiple(gcRegsData.HFOV, 0.1);
      gcRegsData.VFOV = roundMultiple(gcRegsData.VFOV, 0.1);
   }
   else
   {
      gcRegsData.HFOV = gcRegsDataFactory.HFOV;
      gcRegsData.VFOV = gcRegsDataFactory.VFOV;
   }

   // Update header
   HDER_UpdateFOVHeader(&gHderInserter, &gcRegsData);
}

/**
 * Update ExposureTimeMin register according to active mode.
 */
void GC_UpdateExposureTimeMin()
{
   float UserExposureTimeMin;
   float CorrectedExposureTimeMin;
   float exposureTimeOffset; // in us
   extern int32_t gFpaExposureTimeOffset; //in 1e-8 s

   exposureTimeOffset = (float)gFpaExposureTimeOffset/EXPOSURE_TIME_FACTOR;

   // Here, we correct the minimum exposure time of the user interface in order to compensate the gFpaExposureTimeOffset (from flash setting)
   //thus prevent sending a command to the FPA that is less than FPA_MIN_EXPOSURE.
   CorrectedExposureTimeMin = FPA_MIN_EXPOSURE - exposureTimeOffset; // ("exposureTimeSendToFPA" = "UserDefineExposureTime" + exposureTimeOffset)

   //CorrectedExposureTimeMin cannot be less than FPA_MIN_EXPOSURE, then CorrectedExposureTimeMin need to be discarded when exposureTimeOffset is positive.
   CorrectedExposureTimeMin = MAX(CorrectedExposureTimeMin, FPA_MIN_EXPOSURE);

   // Always use default value when camera is unlocked
   if (gGC_ProprietaryFeatureKeyIsValid)
   {
      UserExposureTimeMin = CorrectedExposureTimeMin;
   }
   else
   {
      // Use the most restrictive value (max)
      UserExposureTimeMin = MAX(CorrectedExposureTimeMin, flashSettings.ExposureTimeMin);
   }

   // Compare with specific value when AEC+ is active
   if (GC_AECPlusIsActive)
   {
      if (flashSettings.AECPlusExposureTimeMin != 0.0F)
      {
         // Use the most restrictive value (max)
         UserExposureTimeMin = MAX(UserExposureTimeMin, flashSettings.AECPlusExposureTimeMin);
      }
      else
      {
#ifdef FPA_AECP_MIN_EXPOSURE
         // Use the most restrictive value (max)
         UserExposureTimeMin = MAX(UserExposureTimeMin, FPA_AECP_MIN_EXPOSURE);
#endif
      }
   }

#ifdef CALCIUM_PROXY
      // Exposure Time has to be rounded to a value supported by the FPA
      t_calcium_DSM_timings DSM;
      FPA_CalculateDSMTimings(UserExposureTimeMin, &DSM);
      UserExposureTimeMin = DSM.userRoundedExposureTime_usec;
#endif

   // Update ExposureTimeMin value when needed
   if (gcRegsData.ExposureTimeMin != UserExposureTimeMin)
   {
      GC_SetExposureTimeMin(UserExposureTimeMin);
   }

   if (gcRegsData.ExposureTime < gcRegsData.ExposureTimeMin)
   {
      GC_SetExposureTime(gcRegsData.ExposureTimeMin);
   }
}

/**
 * Update Camera Link configuration registers.
 */
void GC_UpdateCameraLinkConfig()
{
   ClConfiguration_t clink_cfg;
   float clink_out_clk;
   // Backup current DeviceClockSelector
   const uint32_t DeviceClockSelectorBackup = gcRegsData.DeviceClockSelector;

   // Copy and validate requested config
   clink_cfg = (ClConfiguration_t)flashSettings.ClConfiguration;
   if ((clink_cfg != CC_Base) && (clink_cfg != CC_Full) && (clink_cfg != CC_DualBase))
   {
      // Overwrite to Full
      clink_cfg = CC_Full;
   }

   // Find valid config and clock
   if (FPA_PIX_THROUGHPUT_PEAK < (1 * CLINK_OUT_CLK_SLOW))    // 1 pix per clk
   {
      // All configs are valid
      // Use requested config and slow clock
      clink_out_clk = CLINK_OUT_CLK_SLOW;
   }
   else if (FPA_PIX_THROUGHPUT_PEAK < (1 * CLINK_OUT_CLK_FAST))    // 1 pix per clk
   {
      // All configs are valid except Base slow
      // Use requested config and clock depends on config
      if (clink_cfg == CC_Full)
         clink_out_clk = CLINK_OUT_CLK_SLOW;
      else
         clink_out_clk = CLINK_OUT_CLK_FAST;
   }
   else if (FPA_PIX_THROUGHPUT_PEAK < (4 * CLINK_OUT_CLK_SLOW))    // 4 pix per clk
   {
      // Only Full configs are valid
      // Use Full and slow clock
      clink_cfg = CC_Full;
      clink_out_clk = CLINK_OUT_CLK_SLOW;
   }
   else
   {
      // Only Full config with fast clock is valid
      clink_cfg = CC_Full;
      clink_out_clk = CLINK_OUT_CLK_FAST;
   }

   if (clink_cfg != (ClConfiguration_t)flashSettings.ClConfiguration)
      GC_ERR("Requested ClConfiguration (%d) is not possible. Forcing %d.", flashSettings.ClConfiguration, clink_cfg);


   // Set camera link config and corresponding flags
   GC_SetClConfiguration(clink_cfg);
   TDCFlagsClr(ClBaseIsImplementedMask | ClFullIsImplementedMask | ClDualBaseIsImplementedMask);
   if (clink_cfg == CC_Base)
      TDCFlagsSet(ClBaseIsImplementedMask);
   else if (clink_cfg == CC_DualBase)
      TDCFlagsSet(ClDualBaseIsImplementedMask);
   else
      TDCFlagsSet(ClFullIsImplementedMask);
   // Share new flags value
   GC_SetTDCFlags(gcRegsData.TDCFlags);

   // Set camera link clock frequency
   GC_SetDeviceClockSelector(DCS_CameraLink);
   GC_SetDeviceClockFrequency(clink_out_clk);

   // Restore DeviceClockSelector
   GC_SetDeviceClockSelector(DeviceClockSelectorBackup);
}


/**
 * This function set the height when downloading a sequence from the memory buffer. A download can be configured :
 * 1. with the jumbo frame feature i.e. configuring a frame height matching the
 *    MemoryBufferSequenceDownloadSuggestedFrameImageCount
 * 2. without the jumbo frame feature i.e. configuring a frame height matching
 *    a MemoryBufferSequenceDownloadSuggestedFrameImageCount = 1 (to maintain backwards compatibility)
 */

void GC_UpdateJumboFrameHeight(gcRegistersData_t *pGCRegs, bool heightChanged)
{
   static bool suggestedJumboFrameHeightIsValid = false;
   static uint32_t NTxMiniHeight = 0;
   uint32_t suggestedJumboFrameHeight = 0;

   suggestedJumboFrameHeight = pGCRegs->MemoryBufferSequenceDownloadSuggestedFrameImageCount*(pGCRegs->MemoryBufferSequenceHeight + 2) - 2 ;

   if (pGCRegs->MemoryBufferSequenceDownloadSuggestedFrameImageCount > 1)
   {
         GC_SetHeightInc(1);
         GC_SetHeightMax(MAX(MAX(suggestedJumboFrameHeight, NTxMiniHeight), FPA_CONFIG_GET(height_max)));
   }
   else
   {
        GC_SetHeightInc(FPA_CONFIG_GET(height_inc));
        GC_SetHeightMax(FPA_CONFIG_GET(height_max));
   }


   if (!suggestedJumboFrameHeightIsValid || heightChanged) // heightChanged is only true when this function is called from GC_HeightCallback()
     NTxMiniHeight = pGCRegs->Height;

   if((pGCRegs->MemoryBufferSequenceDownloadSuggestedFrameImageCount > 1) && (NTxMiniHeight == suggestedJumboFrameHeight))
   {
      if (!suggestedJumboFrameHeightIsValid)
      {
       suggestedJumboFrameHeightIsValid = true;

       GC_SetMemoryBufferSequenceDownloadFrameImageCount(pGCRegs->MemoryBufferSequenceDownloadSuggestedFrameImageCount); // Configure the frame image count in the output FPGA
       NTxMiniHeight = pGCRegs->Height; // Backup user define height
      }
      pGCRegs->Height = pGCRegs->MemoryBufferSequenceHeight;
      if (!heightChanged) // No need to broadcast if this function is called in GC_HeightCallback()
        GC_BroadcastRegisterWrite(&gcRegsDef[HeightIdx]); // Broadcast the sequence height. There is now a mismatch between the user defined height and the actual camera height

   }
   else
   {
     if (suggestedJumboFrameHeightIsValid)
       suggestedJumboFrameHeightIsValid = false;

       GC_SetMemoryBufferSequenceDownloadFrameImageCount(1);

       if (!heightChanged) // No need to restore the user define height if this function is called in GC_HeightCallback()
       {
          pGCRegs->Height =  MIN(NTxMiniHeight, pGCRegs->HeightMax);
          GC_BroadcastRegisterWrite(&gcRegsDef[HeightIdx]);
       }
   }
}

