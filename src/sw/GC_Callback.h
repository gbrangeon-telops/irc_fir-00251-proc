/**
 * @file GC_Callback.h
 * GenICam registers callback functions declaration.
 *
 * This file declares the GenICam registers callback functions.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef GC_CALLBACK_H
#define GC_CALLBACK_H

#include "GenICam.h"

/* AUTO-CODE BEGIN */
// Auto-generated GeniCam registers callback functions definition.
// Generated from XML camera definition file version 13.4.0
// using updateGenICamCallback.m Matlab script.

void GC_Callback_Init();

void GC_AECImageFractionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AECPlusExtrapolationWeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AECResponseTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AECTargetWellFillingCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionArmCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateMaxFGCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateSetToMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateUnrestrictedMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionFrameRateUnrestrictedMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionStartCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionStartAtStartupCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AcquisitionStopCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AutofocusCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AutofocusModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AutofocusROICallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AutomaticExternalFanSpeedModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_AvailabilityFlagsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_BadPixelReplacementCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_BinningModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionActiveBlockPOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionActivePOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionActiveTypeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionBlockCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionBlockLoadCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionBlockPOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionBlockSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionLoadCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionPOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationCollectionTypeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CalibrationModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_CenterImageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ClConfigurationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DetectorModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceBuiltInTestsResults1Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceBuiltInTestsResults2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceBuiltInTestsResults3Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceBuiltInTestsResults4Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceBuiltInTestsResults7Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceBuiltInTestsResults8Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceClockFrequencyCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceClockSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceCoolerPowerOnCyclesCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceCoolerRunningTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceCurrentCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceCurrentSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceDetectorElectricalRefOffsetCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceDetectorElectricalTapsRefCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceDetectorPolarizationVoltageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceFirmwareBuildVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceFirmwareMajorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceFirmwareMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceFirmwareModuleRevisionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceFirmwareModuleSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceFirmwareSubMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceKeyValidationHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceKeyValidationLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceLedIndicatorStateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceManufacturerInfoCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceModelNameCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceNotReadyCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DevicePowerOnCyclesCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DevicePowerStateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DevicePowerStateSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceRegistersCheckCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceRegistersStreamingEndCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceRegistersStreamingStartCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceRegistersValidCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceResetCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceRunningTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceSerialNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceSerialPortBaudRateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceSerialPortFunctionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceSerialPortSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceTemperatureCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceTemperatureSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceVendorNameCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceVoltageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceVoltageSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceXMLMajorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceXMLMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_DeviceXMLSubMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExpectedTemperatureMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExpectedTemperatureMaxMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExpectedTemperatureMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExpectedTemperatureMinMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExposureOccurrence1Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExposureOccurrence2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExposureOccurrence3Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIExposureOccurrence4Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRINumberOfExposuresCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EHDRIResetToDefaultCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventErrorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventErrorCodeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventErrorTimestampCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventNotificationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventTelopsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventTelopsCodeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_EventTelopsTimestampCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureAutoCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime1Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime3Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime4Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime5Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime6Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime7Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTime8Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTimeMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTimeMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTimeSetToMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExposureTimeSetToMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExternalBlackBodyTemperatureCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExternalFanSpeedCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExternalFanSpeedSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ExternalLensSerialNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionRawMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionRawMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FOVPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FValSizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWFilterNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWSpeedCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWSpeedMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FWSpeedSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusFarFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusFarSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusNearFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusNearSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusPositionRawMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusPositionRawMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_FocusPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GPSAltitudeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GPSLatitudeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GPSLongitudeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GPSModeIndicatorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GPSNumberOfSatellitesInUseCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GevFirstURLCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_GevSecondURLCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_HFOVCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_HeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_HeightIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_HeightMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_HeightMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ICUPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ICUPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionBlockSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionFWAcquisitionFrameRateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionFWAcquisitionFrameRateMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionFWAcquisitionFrameRateMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionFWModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ImageCorrectionModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_IntegrationModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_IsActiveFlagsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_LoadSavedConfigurationAtStartupCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_LockedCenterImageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ManualFilterSerialNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferAvailableFreeSpaceHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferAvailableFreeSpaceLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferFragmentedFreeSpaceHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferFragmentedFreeSpaceLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferLegacyModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferMOIActivationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferMOISoftwareCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferMOISourceCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferNumberOfImagesMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferNumberOfSequencesCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferNumberOfSequencesMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferNumberOfSequencesMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceBadPixelReplacementCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceCalibrationModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceClearCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceClearAllCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDefragCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadBitRateMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadFrameCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadFrameImageCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadImageFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceDownloadSuggestedFrameImageCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceFirstFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceHeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceMOIFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceOffsetXCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceOffsetYCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequencePreMOISizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceRecordedSizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceSizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceSizeIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceSizeMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceSizeMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferSequenceWidthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferStatusCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferTotalSpaceHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_MemoryBufferTotalSpaceLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_NDFilterArmedPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_NDFilterNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_NDFilterPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_NDFilterPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_NDFilterPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_NDFilterPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetXCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetXIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetXMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetXMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetYCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetYIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetYMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_OffsetYMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_POSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_PayloadSizeMinFGCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_PixelDataResolutionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_PixelFormatCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_PowerOnAtStartupCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ProprietaryFeatureCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ReverseXCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ReverseYCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_SaveConfigurationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_SensorHeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_SensorIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_SensorWellDepthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_SensorWidthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_StealthModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_SubSecondTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TDCFlagsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TDCFlags2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TDCStatusCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TestImageSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TimeSourceCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerActivationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerDelayCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerFrameCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerSoftwareCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_TriggerSourceCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_VFOVCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_VideoAGCCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_VideoBadPixelReplacementCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_VideoFreezeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_WidthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_WidthIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_WidthMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_WidthMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ZoomInFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ZoomInSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ZoomOutFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);
void GC_ZoomOutSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access);

/* AUTO-CODE END */

#endif // GC_CALLBACK_H
