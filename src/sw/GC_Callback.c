/**
 * @file GC_Callback.c
 * GenICam registers callback functions definition.
 *
 * This file defines the GenICam registers callback functions.
 * 
 * Callback functions are alphabetically ordered to ease searches.
 * 
 * Once a default callback function has been generated using the matlab script, 
 * callback function header and body can be manually modified. The script
 * performs a backup of existing callback functions and rewrite them if needed.
 * It is suggested to carefully inspect generated code to ensure that there is
 * no source code lost. In case unused code need to be kept for future, be sure
 * to copy that code outside AUTO-CODE tags.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "GC_Callback.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "Calibration.h"
#include "FileManager.h"
#include "Trig_gen.h"
#include <math.h>
#include "aec.h"
#include "exposure_time_ctrl.h"
#include "icu.h"
#include "Actualization.h"
#include "BufferManager.h"
#include "FWController.h"
#include "SFW_MathematicalModel.h"
#include "NDFController.h"
#include "EHDRI_Manager.h"
#include "calib.h"
#include "power_ctrl.h"
#include "Acquisition.h"
#include "FlashDynamicValues.h"
#include "flagging.h"
#include "gating.h"
#include "BuiltInTests.h"

extern t_Trig gTrig;
extern t_FpaIntf gFpaIntf;
extern t_ExposureTime gExposureTime;
extern t_AEC gAEC_Ctrl;
extern ICU_config_t gICU_ctrl;
extern t_bufferManager gBufManager;
extern t_EhdriManager gEHDRIManager;
extern t_calib gCal;
extern t_HderInserter gHderInserter;
extern t_FlagCfg gFlagging_ctrl;
extern t_GatingCfg gGating_ctrl;

extern float EHDRIExposureTime[EHDRI_IDX_NBR];
extern float FWExposureTime[8];


/* AUTO-CODE BEGIN */
// Auto-generated GeniCam registers callback functions definition.
// Generated from XML camera definition file version 11.5.0
// using updateGenICamCallback.m Matlab script.

/**
 * GenICam registers callback function initialization.
 */
void GC_Callback_Init()
{
   gcRegsDef[AECImageFractionIdx].callback =                            &GC_AECImageFractionCallback;
   gcRegsDef[AECPlusExtrapolationWeightIdx].callback =                  &GC_AECPlusExtrapolationWeightCallback;
   gcRegsDef[AECResponseTimeIdx].callback =                             &GC_AECResponseTimeCallback;
   gcRegsDef[AECTargetWellFillingIdx].callback =                        &GC_AECTargetWellFillingCallback;
   gcRegsDef[AcquisitionArmIdx].callback =                              &GC_AcquisitionArmCallback;
   gcRegsDef[AcquisitionFrameRateIdx].callback =                        &GC_AcquisitionFrameRateCallback;
   gcRegsDef[AcquisitionFrameRateMaxIdx].callback =                     &GC_AcquisitionFrameRateMaxCallback;
   gcRegsDef[AcquisitionFrameRateMaxFGIdx].callback =                   &GC_AcquisitionFrameRateMaxFGCallback;
   gcRegsDef[AcquisitionFrameRateMinIdx].callback =                     &GC_AcquisitionFrameRateMinCallback;
   gcRegsDef[AcquisitionFrameRateModeIdx].callback =                    &GC_AcquisitionFrameRateModeCallback;
   gcRegsDef[AcquisitionFrameRateSetToMaxIdx].callback =                &GC_AcquisitionFrameRateSetToMaxCallback;
   gcRegsDef[AcquisitionModeIdx].callback =                             &GC_AcquisitionModeCallback;
   gcRegsDef[AcquisitionStartIdx].callback =                            &GC_AcquisitionStartCallback;
   gcRegsDef[AcquisitionStartAtStartupIdx].callback =                   &GC_AcquisitionStartAtStartupCallback;
   gcRegsDef[AcquisitionStopIdx].callback =                             &GC_AcquisitionStopCallback;
   gcRegsDef[AutomaticExternalFanSpeedModeIdx].callback =               &GC_AutomaticExternalFanSpeedModeCallback;
   gcRegsDef[AvailabilityFlagsIdx].callback =                           &GC_AvailabilityFlagsCallback;
   gcRegsDef[BadPixelReplacementIdx].callback =                         &GC_BadPixelReplacementCallback;
   gcRegsDef[CalibrationActualizationModeIdx].callback =                &GC_CalibrationActualizationModeCallback;
   gcRegsDef[CalibrationActualizeIdx].callback =                        &GC_CalibrationActualizeCallback;
   gcRegsDef[CalibrationCollectionActiveBlockPOSIXTimeIdx].callback =   &GC_CalibrationCollectionActiveBlockPOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionActivePOSIXTimeIdx].callback =        &GC_CalibrationCollectionActivePOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionActiveTypeIdx].callback =             &GC_CalibrationCollectionActiveTypeCallback;
   gcRegsDef[CalibrationCollectionBlockCountIdx].callback =             &GC_CalibrationCollectionBlockCountCallback;
   gcRegsDef[CalibrationCollectionBlockLoadIdx].callback =              &GC_CalibrationCollectionBlockLoadCallback;
   gcRegsDef[CalibrationCollectionBlockPOSIXTimeIdx].callback =         &GC_CalibrationCollectionBlockPOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionBlockSelectorIdx].callback =          &GC_CalibrationCollectionBlockSelectorCallback;
   gcRegsDef[CalibrationCollectionCountIdx].callback =                  &GC_CalibrationCollectionCountCallback;
   gcRegsDef[CalibrationCollectionLoadIdx].callback =                   &GC_CalibrationCollectionLoadCallback;
   gcRegsDef[CalibrationCollectionPOSIXTimeIdx].callback =              &GC_CalibrationCollectionPOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionSelectorIdx].callback =               &GC_CalibrationCollectionSelectorCallback;
   gcRegsDef[CalibrationCollectionTypeIdx].callback =                   &GC_CalibrationCollectionTypeCallback;
   gcRegsDef[CalibrationModeIdx].callback =                             &GC_CalibrationModeCallback;
   gcRegsDef[CenterImageIdx].callback =                                 &GC_CenterImageCallback;
   gcRegsDef[DeviceBuiltInTestsResults1Idx].callback =                  &GC_DeviceBuiltInTestsResults1Callback;
   gcRegsDef[DeviceBuiltInTestsResults2Idx].callback =                  &GC_DeviceBuiltInTestsResults2Callback;
   gcRegsDef[DeviceBuiltInTestsResults3Idx].callback =                  &GC_DeviceBuiltInTestsResults3Callback;
   gcRegsDef[DeviceBuiltInTestsResults4Idx].callback =                  &GC_DeviceBuiltInTestsResults4Callback;
   gcRegsDef[DeviceBuiltInTestsResults7Idx].callback =                  &GC_DeviceBuiltInTestsResults7Callback;
   gcRegsDef[DeviceBuiltInTestsResults8Idx].callback =                  &GC_DeviceBuiltInTestsResults8Callback;
   gcRegsDef[DeviceClockFrequencyIdx].callback =                        &GC_DeviceClockFrequencyCallback;
   gcRegsDef[DeviceClockSelectorIdx].callback =                         &GC_DeviceClockSelectorCallback;
   gcRegsDef[DeviceCoolerPowerOnCyclesIdx].callback =                   &GC_DeviceCoolerPowerOnCyclesCallback;
   gcRegsDef[DeviceCoolerRunningTimeIdx].callback =                     &GC_DeviceCoolerRunningTimeCallback;
   gcRegsDef[DeviceCurrentIdx].callback =                               &GC_DeviceCurrentCallback;
   gcRegsDef[DeviceCurrentSelectorIdx].callback =                       &GC_DeviceCurrentSelectorCallback;
   gcRegsDef[DeviceDetectorPolarizationVoltageIdx].callback =           &GC_DeviceDetectorPolarizationVoltageCallback;
   gcRegsDef[DeviceFirmwareBuildVersionIdx].callback =                  &GC_DeviceFirmwareBuildVersionCallback;
   gcRegsDef[DeviceFirmwareMajorVersionIdx].callback =                  &GC_DeviceFirmwareMajorVersionCallback;
   gcRegsDef[DeviceFirmwareMinorVersionIdx].callback =                  &GC_DeviceFirmwareMinorVersionCallback;
   gcRegsDef[DeviceFirmwareModuleRevisionIdx].callback =                &GC_DeviceFirmwareModuleRevisionCallback;
   gcRegsDef[DeviceFirmwareModuleSelectorIdx].callback =                &GC_DeviceFirmwareModuleSelectorCallback;
   gcRegsDef[DeviceFirmwareSubMinorVersionIdx].callback =               &GC_DeviceFirmwareSubMinorVersionCallback;
   gcRegsDef[DeviceIDIdx].callback =                                    &GC_DeviceIDCallback;
   gcRegsDef[DeviceKeyValidationHighIdx].callback =                     &GC_DeviceKeyValidationHighCallback;
   gcRegsDef[DeviceKeyValidationLowIdx].callback =                      &GC_DeviceKeyValidationLowCallback;
   gcRegsDef[DeviceLedIndicatorStateIdx].callback =                     &GC_DeviceLedIndicatorStateCallback;
   gcRegsDef[DeviceManufacturerInfoIdx].callback =                      &GC_DeviceManufacturerInfoCallback;
   gcRegsDef[DeviceModelNameIdx].callback =                             &GC_DeviceModelNameCallback;
   gcRegsDef[DeviceNotReadyIdx].callback =                              &GC_DeviceNotReadyCallback;
   gcRegsDef[DevicePowerOnCyclesIdx].callback =                         &GC_DevicePowerOnCyclesCallback;
   gcRegsDef[DevicePowerStateIdx].callback =                            &GC_DevicePowerStateCallback;
   gcRegsDef[DevicePowerStateSetpointIdx].callback =                    &GC_DevicePowerStateSetpointCallback;
   gcRegsDef[DeviceRegistersCheckIdx].callback =                        &GC_DeviceRegistersCheckCallback;
   gcRegsDef[DeviceRegistersStreamingEndIdx].callback =                 &GC_DeviceRegistersStreamingEndCallback;
   gcRegsDef[DeviceRegistersStreamingStartIdx].callback =               &GC_DeviceRegistersStreamingStartCallback;
   gcRegsDef[DeviceRegistersValidIdx].callback =                        &GC_DeviceRegistersValidCallback;
   gcRegsDef[DeviceResetIdx].callback =                                 &GC_DeviceResetCallback;
   gcRegsDef[DeviceRunningTimeIdx].callback =                           &GC_DeviceRunningTimeCallback;
   gcRegsDef[DeviceSerialNumberIdx].callback =                          &GC_DeviceSerialNumberCallback;
   gcRegsDef[DeviceSerialPortBaudRateIdx].callback =                    &GC_DeviceSerialPortBaudRateCallback;
   gcRegsDef[DeviceSerialPortSelectorIdx].callback =                    &GC_DeviceSerialPortSelectorCallback;
   gcRegsDef[DeviceTemperatureIdx].callback =                           &GC_DeviceTemperatureCallback;
   gcRegsDef[DeviceTemperatureSelectorIdx].callback =                   &GC_DeviceTemperatureSelectorCallback;
   gcRegsDef[DeviceVendorNameIdx].callback =                            &GC_DeviceVendorNameCallback;
   gcRegsDef[DeviceVersionIdx].callback =                               &GC_DeviceVersionCallback;
   gcRegsDef[DeviceVoltageIdx].callback =                               &GC_DeviceVoltageCallback;
   gcRegsDef[DeviceVoltageSelectorIdx].callback =                       &GC_DeviceVoltageSelectorCallback;
   gcRegsDef[DeviceXMLMajorVersionIdx].callback =                       &GC_DeviceXMLMajorVersionCallback;
   gcRegsDef[DeviceXMLMinorVersionIdx].callback =                       &GC_DeviceXMLMinorVersionCallback;
   gcRegsDef[DeviceXMLSubMinorVersionIdx].callback =                    &GC_DeviceXMLSubMinorVersionCallback;
   gcRegsDef[EHDRIExpectedTemperatureMaxIdx].callback =                 &GC_EHDRIExpectedTemperatureMaxCallback;
   gcRegsDef[EHDRIExpectedTemperatureMaxMinIdx].callback =              &GC_EHDRIExpectedTemperatureMaxMinCallback;
   gcRegsDef[EHDRIExpectedTemperatureMinIdx].callback =                 &GC_EHDRIExpectedTemperatureMinCallback;
   gcRegsDef[EHDRIExpectedTemperatureMinMaxIdx].callback =              &GC_EHDRIExpectedTemperatureMinMaxCallback;
   gcRegsDef[EHDRIExposureOccurrence1Idx].callback =                    &GC_EHDRIExposureOccurrence1Callback;
   gcRegsDef[EHDRIExposureOccurrence2Idx].callback =                    &GC_EHDRIExposureOccurrence2Callback;
   gcRegsDef[EHDRIExposureOccurrence3Idx].callback =                    &GC_EHDRIExposureOccurrence3Callback;
   gcRegsDef[EHDRIExposureOccurrence4Idx].callback =                    &GC_EHDRIExposureOccurrence4Callback;
   gcRegsDef[EHDRIModeIdx].callback =                                   &GC_EHDRIModeCallback;
   gcRegsDef[EHDRINumberOfExposuresIdx].callback =                      &GC_EHDRINumberOfExposuresCallback;
   gcRegsDef[EHDRIResetToDefaultIdx].callback =                         &GC_EHDRIResetToDefaultCallback;
   gcRegsDef[EventErrorIdx].callback =                                  &GC_EventErrorCallback;
   gcRegsDef[EventErrorCodeIdx].callback =                              &GC_EventErrorCodeCallback;
   gcRegsDef[EventErrorTimestampIdx].callback =                         &GC_EventErrorTimestampCallback;
   gcRegsDef[EventNotificationIdx].callback =                           &GC_EventNotificationCallback;
   gcRegsDef[EventSelectorIdx].callback =                               &GC_EventSelectorCallback;
   gcRegsDef[EventTelopsIdx].callback =                                 &GC_EventTelopsCallback;
   gcRegsDef[EventTelopsCodeIdx].callback =                             &GC_EventTelopsCodeCallback;
   gcRegsDef[EventTelopsTimestampIdx].callback =                        &GC_EventTelopsTimestampCallback;
   gcRegsDef[ExposureAutoIdx].callback =                                &GC_ExposureAutoCallback;
   gcRegsDef[ExposureModeIdx].callback =                                &GC_ExposureModeCallback;
   gcRegsDef[ExposureTimeIdx].callback =                                &GC_ExposureTimeCallback;
   gcRegsDef[ExposureTime1Idx].callback =                               &GC_ExposureTime1Callback;
   gcRegsDef[ExposureTime2Idx].callback =                               &GC_ExposureTime2Callback;
   gcRegsDef[ExposureTime3Idx].callback =                               &GC_ExposureTime3Callback;
   gcRegsDef[ExposureTime4Idx].callback =                               &GC_ExposureTime4Callback;
   gcRegsDef[ExposureTime5Idx].callback =                               &GC_ExposureTime5Callback;
   gcRegsDef[ExposureTime6Idx].callback =                               &GC_ExposureTime6Callback;
   gcRegsDef[ExposureTime7Idx].callback =                               &GC_ExposureTime7Callback;
   gcRegsDef[ExposureTime8Idx].callback =                               &GC_ExposureTime8Callback;
   gcRegsDef[ExposureTimeMaxIdx].callback =                             &GC_ExposureTimeMaxCallback;
   gcRegsDef[ExposureTimeMinIdx].callback =                             &GC_ExposureTimeMinCallback;
   gcRegsDef[ExposureTimeSetToMaxIdx].callback =                        &GC_ExposureTimeSetToMaxCallback;
   gcRegsDef[ExternalBlackBodyTemperatureIdx].callback =                &GC_ExternalBlackBodyTemperatureCallback;
   gcRegsDef[ExternalFanSpeedIdx].callback =                            &GC_ExternalFanSpeedCallback;
   gcRegsDef[ExternalFanSpeedSetpointIdx].callback =                    &GC_ExternalFanSpeedSetpointCallback;
   gcRegsDef[ExternalLensSerialNumberIdx].callback =                    &GC_ExternalLensSerialNumberCallback;
   gcRegsDef[FValSizeIdx].callback =                                    &GC_FValSizeCallback;
   gcRegsDef[FWFilterNumberIdx].callback =                              &GC_FWFilterNumberCallback;
   gcRegsDef[FWModeIdx].callback =                                      &GC_FWModeCallback;
   gcRegsDef[FWPositionIdx].callback =                                  &GC_FWPositionCallback;
   gcRegsDef[FWPositionRawIdx].callback =                               &GC_FWPositionRawCallback;
   gcRegsDef[FWPositionRawSetpointIdx].callback =                       &GC_FWPositionRawSetpointCallback;
   gcRegsDef[FWPositionSetpointIdx].callback =                          &GC_FWPositionSetpointCallback;
   gcRegsDef[FWSpeedIdx].callback =                                     &GC_FWSpeedCallback;
   gcRegsDef[FWSpeedMaxIdx].callback =                                  &GC_FWSpeedMaxCallback;
   gcRegsDef[FWSpeedSetpointIdx].callback =                             &GC_FWSpeedSetpointCallback;
   gcRegsDef[GPSAltitudeIdx].callback =                                 &GC_GPSAltitudeCallback;
   gcRegsDef[GPSLatitudeIdx].callback =                                 &GC_GPSLatitudeCallback;
   gcRegsDef[GPSLongitudeIdx].callback =                                &GC_GPSLongitudeCallback;
   gcRegsDef[GPSModeIndicatorIdx].callback =                            &GC_GPSModeIndicatorCallback;
   gcRegsDef[GPSNumberOfSatellitesInUseIdx].callback =                  &GC_GPSNumberOfSatellitesInUseCallback;
   gcRegsDef[GevFirstURLIdx].callback =                                 &GC_GevFirstURLCallback;
   gcRegsDef[GevSecondURLIdx].callback =                                &GC_GevSecondURLCallback;
   gcRegsDef[HeightIdx].callback =                                      &GC_HeightCallback;
   gcRegsDef[HeightIncIdx].callback =                                   &GC_HeightIncCallback;
   gcRegsDef[HeightMaxIdx].callback =                                   &GC_HeightMaxCallback;
   gcRegsDef[HeightMinIdx].callback =                                   &GC_HeightMinCallback;
   gcRegsDef[ICUPositionIdx].callback =                                 &GC_ICUPositionCallback;
   gcRegsDef[ICUPositionSetpointIdx].callback =                         &GC_ICUPositionSetpointCallback;
   gcRegsDef[IntegrationModeIdx].callback =                             &GC_IntegrationModeCallback;
   gcRegsDef[IsActiveFlagsIdx].callback =                               &GC_IsActiveFlagsCallback;
   gcRegsDef[LockedCenterImageIdx].callback =                           &GC_LockedCenterImageCallback;
   gcRegsDef[ManualFilterSerialNumberIdx].callback =                    &GC_ManualFilterSerialNumberCallback;
   gcRegsDef[MemoryBufferMOIActivationIdx].callback =                   &GC_MemoryBufferMOIActivationCallback;
   gcRegsDef[MemoryBufferMOISoftwareIdx].callback =                     &GC_MemoryBufferMOISoftwareCallback;
   gcRegsDef[MemoryBufferMOISourceIdx].callback =                       &GC_MemoryBufferMOISourceCallback;
   gcRegsDef[MemoryBufferModeIdx].callback =                            &GC_MemoryBufferModeCallback;
   gcRegsDef[MemoryBufferNumberOfImagesMaxIdx].callback =               &GC_MemoryBufferNumberOfImagesMaxCallback;
   gcRegsDef[MemoryBufferNumberOfSequencesIdx].callback =               &GC_MemoryBufferNumberOfSequencesCallback;
   gcRegsDef[MemoryBufferNumberOfSequencesMaxIdx].callback =            &GC_MemoryBufferNumberOfSequencesMaxCallback;
   gcRegsDef[MemoryBufferSequenceClearAllIdx].callback =                &GC_MemoryBufferSequenceClearAllCallback;
   gcRegsDef[MemoryBufferSequenceCountIdx].callback =                   &GC_MemoryBufferSequenceCountCallback;
   gcRegsDef[MemoryBufferSequenceDownloadBitRateMaxIdx].callback =      &GC_MemoryBufferSequenceDownloadBitRateMaxCallback;
   gcRegsDef[MemoryBufferSequenceDownloadImageFrameIDIdx].callback =    &GC_MemoryBufferSequenceDownloadImageFrameIDCallback;
   gcRegsDef[MemoryBufferSequenceDownloadModeIdx].callback =            &GC_MemoryBufferSequenceDownloadModeCallback;
   gcRegsDef[MemoryBufferSequenceFirstFrameIDIdx].callback =            &GC_MemoryBufferSequenceFirstFrameIDCallback;
   gcRegsDef[MemoryBufferSequenceMOIFrameIDIdx].callback =              &GC_MemoryBufferSequenceMOIFrameIDCallback;
   gcRegsDef[MemoryBufferSequencePreMOISizeIdx].callback =              &GC_MemoryBufferSequencePreMOISizeCallback;
   gcRegsDef[MemoryBufferSequenceRecordedSizeIdx].callback =            &GC_MemoryBufferSequenceRecordedSizeCallback;
   gcRegsDef[MemoryBufferSequenceSelectorIdx].callback =                &GC_MemoryBufferSequenceSelectorCallback;
   gcRegsDef[MemoryBufferSequenceSizeIdx].callback =                    &GC_MemoryBufferSequenceSizeCallback;
   gcRegsDef[MemoryBufferSequenceSizeMaxIdx].callback =                 &GC_MemoryBufferSequenceSizeMaxCallback;
   gcRegsDef[NDFilterArmedPositionSetpointIdx].callback =               &GC_NDFilterArmedPositionSetpointCallback;
   gcRegsDef[NDFilterNumberIdx].callback =                              &GC_NDFilterNumberCallback;
   gcRegsDef[NDFilterPositionIdx].callback =                            &GC_NDFilterPositionCallback;
   gcRegsDef[NDFilterPositionRawIdx].callback =                         &GC_NDFilterPositionRawCallback;
   gcRegsDef[NDFilterPositionRawSetpointIdx].callback =                 &GC_NDFilterPositionRawSetpointCallback;
   gcRegsDef[NDFilterPositionSetpointIdx].callback =                    &GC_NDFilterPositionSetpointCallback;
   gcRegsDef[OffsetXIdx].callback =                                     &GC_OffsetXCallback;
   gcRegsDef[OffsetXIncIdx].callback =                                  &GC_OffsetXIncCallback;
   gcRegsDef[OffsetXMaxIdx].callback =                                  &GC_OffsetXMaxCallback;
   gcRegsDef[OffsetXMinIdx].callback =                                  &GC_OffsetXMinCallback;
   gcRegsDef[OffsetYIdx].callback =                                     &GC_OffsetYCallback;
   gcRegsDef[OffsetYIncIdx].callback =                                  &GC_OffsetYIncCallback;
   gcRegsDef[OffsetYMaxIdx].callback =                                  &GC_OffsetYMaxCallback;
   gcRegsDef[OffsetYMinIdx].callback =                                  &GC_OffsetYMinCallback;
   gcRegsDef[POSIXTimeIdx].callback =                                   &GC_POSIXTimeCallback;
   gcRegsDef[PixelDataResolutionIdx].callback =                         &GC_PixelDataResolutionCallback;
   gcRegsDef[PixelFormatIdx].callback =                                 &GC_PixelFormatCallback;
   gcRegsDef[PowerOnAtStartupIdx].callback =                            &GC_PowerOnAtStartupCallback;
   gcRegsDef[ProprietaryFeatureIdx].callback =                          &GC_ProprietaryFeatureCallback;
   gcRegsDef[ReverseXIdx].callback =                                    &GC_ReverseXCallback;
   gcRegsDef[ReverseYIdx].callback =                                    &GC_ReverseYCallback;
   gcRegsDef[SensorHeightIdx].callback =                                &GC_SensorHeightCallback;
   gcRegsDef[SensorIDIdx].callback =                                    &GC_SensorIDCallback;
   gcRegsDef[SensorWellDepthIdx].callback =                             &GC_SensorWellDepthCallback;
   gcRegsDef[SensorWidthIdx].callback =                                 &GC_SensorWidthCallback;
   gcRegsDef[StealthModeIdx].callback =                                 &GC_StealthModeCallback;
   gcRegsDef[SubSecondTimeIdx].callback =                               &GC_SubSecondTimeCallback;
   gcRegsDef[TDCFlagsIdx].callback =                                    &GC_TDCFlagsCallback;
   gcRegsDef[TDCStatusIdx].callback =                                   &GC_TDCStatusCallback;
   gcRegsDef[TestImageSelectorIdx].callback =                           &GC_TestImageSelectorCallback;
   gcRegsDef[TimeSourceIdx].callback =                                  &GC_TimeSourceCallback;
   gcRegsDef[TriggerActivationIdx].callback =                           &GC_TriggerActivationCallback;
   gcRegsDef[TriggerDelayIdx].callback =                                &GC_TriggerDelayCallback;
   gcRegsDef[TriggerFrameCountIdx].callback =                           &GC_TriggerFrameCountCallback;
   gcRegsDef[TriggerModeIdx].callback =                                 &GC_TriggerModeCallback;
   gcRegsDef[TriggerSelectorIdx].callback =                             &GC_TriggerSelectorCallback;
   gcRegsDef[TriggerSoftwareIdx].callback =                             &GC_TriggerSoftwareCallback;
   gcRegsDef[TriggerSourceIdx].callback =                               &GC_TriggerSourceCallback;
   gcRegsDef[VideoAGCIdx].callback =                                    &GC_VideoAGCCallback;
   gcRegsDef[VideoBadPixelReplacementIdx].callback =                    &GC_VideoBadPixelReplacementCallback;
   gcRegsDef[VideoEHDRIExposureIndexIdx].callback =                     &GC_VideoEHDRIExposureIndexCallback;
   gcRegsDef[VideoFWPositionIdx].callback =                             &GC_VideoFWPositionCallback;
   gcRegsDef[VideoFreezeIdx].callback =                                 &GC_VideoFreezeCallback;
   gcRegsDef[WidthIdx].callback =                                       &GC_WidthCallback;
   gcRegsDef[WidthIncIdx].callback =                                    &GC_WidthIncCallback;
   gcRegsDef[WidthMaxIdx].callback =                                    &GC_WidthMaxCallback;
   gcRegsDef[WidthMinIdx].callback =                                    &GC_WidthMinCallback;
}

/**
 * AECImageFraction GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AECImageFractionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
	   AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
      HDER_UpdateAECHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * AECPlusExtrapolationWeight GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AECPlusExtrapolationWeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AECResponseTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AECResponseTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      HDER_UpdateAECHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * AECTargetWellFilling GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AECTargetWellFillingCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      HDER_UpdateAECHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * AcquisitionArm GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionArmCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionFrameRate GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update AcquisitionFrameRate and ExposureTime limits
      GC_UpdateParameterLimits();

      if(gcRegsData.FWMode == FWM_SynchronouslyRotating)
      {

         FW_CalculateSpeedSetpoint(&gcRegsData);
         GC_FWSpeedSetpointCallback(GCCP_AFTER, GCCA_WRITE);
         SFW_CalculateMaximalValues(&gcRegsData, FRAME_RATE_CHANGED);
         SFW_LimitParameter(&gcRegsData);

         if(SFW_GetExposureTimeMax() != gcRegsData.ExposureTimeMax)
         {
            uint32_t sfw;
            gcRegsData.ExposureTimeMax = SFW_GetExposureTimeMax();
            for(sfw=0;sfw<8;sfw++)
            {
               if(FWExposureTime[sfw] > gcRegsData.ExposureTimeMax){
                  //PRINTF("UPDATE EXPOSURE TIME: (%d,%d) before(x100) = %d ",sfw,hdri,(uint32_t) GETEHDRIEXPOSURE(sfw,hdri)*100);
                  FWExposureTime[sfw] = gcRegsData.ExposureTimeMax;
                  SFW_SetExposureTimeArray(sfw, FWExposureTime[sfw]);
                  //PRINTF(" After(x100) = %d \n",(uint32_t) GETEHDRIEXPOSURE(sfw,hdri)*100);
               }
            }

            if(gcRegsData.ExposureTime > gcRegsData.ExposureTimeMax)
            {
               gcRegsData.ExposureTime = gcRegsData.ExposureTimeMax;
            }
         }


      }


      if (!gGC_RegistersStreaming && ((gcRegsData.AcquisitionFrameRate > gcRegsData.AcquisitionFrameRateMax) || (gcRegsData.AcquisitionFrameRate < gcRegsData.AcquisitionFrameRateMin)))
      {
         GC_GenerateEventError(EECD_InvalidFrameRate);
      }
      else
      {
         TRIG_ChangeFrameRate(&gTrig, &gFpaIntf, &gcRegsData);
         EXP_SendConfigGC(&gExposureTime, &gcRegsData);
         HDER_UpdateAcquisitionFrameRateHeader(&gHderInserter, &gcRegsData);
      }
   }
}

/**
 * AcquisitionFrameRateMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionFrameRateMaxFG GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateMaxFGCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionFrameRateMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionFrameRateMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      GC_AcquisitionFrameRateCallback(GCCP_AFTER, GCCA_WRITE);
   }
}

/**
 * AcquisitionFrameRateSetToMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateSetToMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if ( gcRegsData.AcquisitionFrameRateSetToMax == 1 )
      {
         gcRegsData.AcquisitionFrameRateSetToMax = 0;

         // Update AcquisitionFrameRateMax
         GC_UpdateParameterLimits();

         if (gcRegsData.FWMode == FWM_SynchronouslyRotating)
         {
            SFW_CalculateMaximalValues(&gcRegsData, FRAME_RATE_CHANGED);
            SFW_LimitParameter(&gcRegsData);
         }

         if ( gcRegsData.AcquisitionFrameRate != gcRegsData.AcquisitionFrameRateMax )
         {
            GC_SetAcquisitionFrameRate(gcRegsData.AcquisitionFrameRateMax);
         }
      }
   }
}

/**
 * AcquisitionMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionStart GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionStartCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionStartAtStartup GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionStartAtStartupCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update AcquisitionStartAtStartup flash dynamic value
      gFlashDynamicValues.AcquisitionStartAtStartup = gcRegsData.AcquisitionStartAtStartup;

      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         GC_ERR("Failed to update flash dynamic values.");
      }
   }
}

/**
 * AcquisitionStop GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionStopCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AutomaticExternalFanSpeedMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AutomaticExternalFanSpeedModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AvailabilityFlags GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AvailabilityFlagsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * BadPixelReplacement GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_BadPixelReplacementCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update BadPixelReplacement flash dynamic value
      gFlashDynamicValues.BadPixelReplacement = gcRegsData.BadPixelReplacement;

      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         GC_ERR("Failed to update flash dynamic values.");
      }

      // Update bad pixel replacement state
      CAL_UpdateCalibBprMode(&gCal, &gcRegsData);

      // Update BadPixelReplacement image header field
      HDER_UpdateBadPixelReplacementHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * CalibrationActualizationMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationActualizationModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * CalibrationActualize GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationActualizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      startActualization(false);
   }
}

/**
 * CalibrationCollectionActiveBlockPOSIXTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionActiveBlockPOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * CalibrationCollectionActivePOSIXTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionActivePOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * CalibrationCollectionActiveType GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionActiveTypeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * CalibrationCollectionBlockCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionBlockCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.CalibrationCollectionBlockCount =
            gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->info.collection.NumberOfBlocks;
   }
}

/**
 * CalibrationCollectionBlockLoad GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionBlockLoadCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   fileRecord_t *file;

   extern bool blockLoadCmdFlag;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.CalibrationCollectionBlockLoad == 1)
      {
         file = gFM_collections.item[gcRegsData.CalibrationCollectionSelector];

         if ((!calibrationInfo.isValid) || (file->posixTime != calibrationInfo.collection.POSIXTime))
         {
            // Need to load another calibration collection
            if (!TDCStatusTst(AcquisitionStartedMask))
            {
               Calibration_LoadCalibrationFilePOSIXTime(file->posixTime);
               // Set command of block load for when the collection will be loaded
               blockLoadCmdFlag = true;
            }
         }
         else
         {
            // Set command of block load and update selection mode
            blockLoadCmdFlag = true;
            CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);
         }

         gcRegsData.CalibrationCollectionBlockLoad = 0;
      }
   }
}

/**
 * CalibrationCollectionBlockPOSIXTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionBlockPOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   fileRecord_t *file;
   uint32_t i;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.CalibrationCollectionBlockPOSIXTime =
            gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->info.collection.BlockPOSIXTime[gcRegsData.CalibrationCollectionBlockSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      file = gFM_collections.item[gcRegsData.CalibrationCollectionSelector];

      // Try to find calibration collection block index corresponding to specified calibration collection block POSIX time
      for (i = 0; i < file->info.collection.NumberOfBlocks; i++)
      {
         if (gcRegsData.CalibrationCollectionBlockPOSIXTime == file->info.collection.BlockPOSIXTime[i])
         {
            gcRegsData.CalibrationCollectionBlockSelector = i;
            break;
         }
      }

      // Update calibration collection block POSIX time register value (in case specified POSIX time not found)
      gcRegsData.CalibrationCollectionBlockPOSIXTime =
            file->info.collection.BlockPOSIXTime[gcRegsData.CalibrationCollectionBlockSelector];
   }
}

/**
 * CalibrationCollectionBlockSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionBlockSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Validate calibration collection block selector
      gcRegsData.CalibrationCollectionBlockSelector =
            MIN(gcRegsData.CalibrationCollectionBlockSelector,
                  gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->info.collection.NumberOfBlocks - 1);
   }
}

/**
 * CalibrationCollectionCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.CalibrationCollectionCount = gFM_collections.count;
   }
}

/**
 * CalibrationCollectionLoad GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionLoadCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   fileRecord_t *file;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.CalibrationCollectionLoad == 1)
      {
         file = gFM_collections.item[gcRegsData.CalibrationCollectionSelector];

         if (((!calibrationInfo.isValid) || (file->posixTime != calibrationInfo.collection.POSIXTime)) && (!TDCStatusTst(AcquisitionStartedMask)))
         {
            Calibration_LoadCalibrationFilePOSIXTime(file->posixTime);
         }

         gcRegsData.CalibrationCollectionLoad = 0;
      }
   }
}

/**
 * CalibrationCollectionPOSIXTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionPOSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   uint32_t i;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.CalibrationCollectionPOSIXTime = gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->posixTime;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Try to find calibration collection index corresponding to specified calibration collection POSIX time
      for (i = 0; i < gFM_collections.count; i++)
      {
         if (gcRegsData.CalibrationCollectionPOSIXTime == gFM_collections.item[i]->posixTime)
         {
            gcRegsData.CalibrationCollectionSelector = i;
            break;
         }
      }

      // Set calibration collection POSIX time register value (in case specified POSIX time not found)
      gcRegsData.CalibrationCollectionPOSIXTime = gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->posixTime;
   }
}

/**
 * CalibrationCollectionSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Validate calibration collection selector
      gcRegsData.CalibrationCollectionSelector = MIN(gcRegsData.CalibrationCollectionSelector, gFM_collections.count - 1);

      // Validate calibration collection block selector
      gcRegsData.CalibrationCollectionBlockSelector =
            MIN(gcRegsData.CalibrationCollectionBlockSelector,
                  gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->info.collection.NumberOfBlocks - 1);
   }
}

/**
 * CalibrationCollectionType GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationCollectionTypeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.CalibrationCollectionType = gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->info.collection.CollectionType;
   }
}

/**
 * CalibrationMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CalibrationModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   static uint32_t previousValue;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      // Before write
      // Save actual calibration mode
      previousValue = gcRegsData.CalibrationMode;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (gcRegsData.CalibrationMode != previousValue)
      {
         // After write
         if (((gcRegsData.CalibrationMode == CM_Raw0) && (!AvailabilityFlagsTst(Raw0IsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_Raw) && (!AvailabilityFlagsTst(RawIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_NUC) && (!AvailabilityFlagsTst(NUCIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_RT) && (!AvailabilityFlagsTst(RTIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_IBR) && (!AvailabilityFlagsTst(IBRIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_IBI) && (!AvailabilityFlagsTst(IBIIsAvailableMask))))
         {
            gcRegsData.CalibrationMode = previousValue;
         }
         else
         {
            // Update registers related to calibration control
            GC_UpdateParameterLimits();
            GC_CalibrationUpdateRegisters();
            CAL_ApplyCalibBlockSelMode(&gCal, &gcRegsData);
            CAL_WriteBlockParam(&gCal, &gcRegsData);
            Calibration_LoadLUTRQ(0);
         }
      }
   }
}

/**
 * CenterImage GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_CenterImageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      GC_ComputeImageLimits();
   }
}

/**
 * DeviceBuiltInTestsResults1 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceBuiltInTestsResults1Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      BuiltInTest_Execute(BITID_BuiltInTestsGlobalResult);
      gcRegsData.DeviceBuiltInTestsResults1 = BuiltInTest_FillResultRegister(0);
   }
}

/**
 * DeviceBuiltInTestsResults2 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceBuiltInTestsResults2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceBuiltInTestsResults2 = BuiltInTest_FillResultRegister(1);
   }
}

/**
 * DeviceBuiltInTestsResults3 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceBuiltInTestsResults3Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceBuiltInTestsResults3 = BuiltInTest_FillResultRegister(2);
   }
}

/**
 * DeviceBuiltInTestsResults4 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceBuiltInTestsResults4Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceBuiltInTestsResults4 = BuiltInTest_FillResultRegister(3);
   }
}

/**
 * DeviceBuiltInTestsResults7 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceBuiltInTestsResults7Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceBuiltInTestsResults8 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceBuiltInTestsResults8Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceClockFrequency GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceClockFrequencyCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceClockFrequency = DeviceClockFrequencyAry[gcRegsData.DeviceClockSelector];
   }
}

/**
 * DeviceClockSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceClockSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceCoolerPowerOnCycles GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceCoolerPowerOnCyclesCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceCoolerRunningTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceCoolerRunningTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceCurrent GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceCurrentCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceCurrent = DeviceCurrentAry[gcRegsData.DeviceCurrentSelector];
   }
}

/**
 * DeviceCurrentSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceCurrentSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceDetectorPolarizationVoltage GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceDetectorPolarizationVoltageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern int16_t gFpaDetectorPolarizationVoltage;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceDetectorPolarizationVoltage = (float)gFpaDetectorPolarizationVoltage / 1000.0F;
   }
}

/**
 * DeviceFirmwareBuildVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceFirmwareBuildVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceFirmwareMajorVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceFirmwareMajorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceFirmwareMinorVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceFirmwareMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceFirmwareModuleRevision GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceFirmwareModuleRevisionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceFirmwareModuleRevision = DeviceFirmwareModuleRevisionAry[gcRegsData.DeviceFirmwareModuleSelector];
   }
}

/**
 * DeviceFirmwareModuleSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceFirmwareModuleSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceFirmwareSubMinorVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceFirmwareSubMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceID GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceKeyValidationHigh GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceKeyValidationHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceKeyValidationLow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceKeyValidationLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceLedIndicatorState GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceLedIndicatorStateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceManufacturerInfo GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceManufacturerInfoCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceModelName GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceModelNameCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceNotReady GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceNotReadyCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceNotReady = 1;

      if (AllowAcquisitionArm())
      {
         gcRegsData.DeviceNotReady = 0;
      }
   }
}

/**
 * DevicePowerOnCycles GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DevicePowerOnCyclesCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DevicePowerState GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DevicePowerStateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DevicePowerStateSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DevicePowerStateSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   static DevicePowerStateSetpoint_t prevDevicePowerStateSetpoint;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      // Before write
      prevDevicePowerStateSetpoint = gcRegsData.DevicePowerStateSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.DevicePowerState == DPS_PowerInTransition)
      {
         gcRegsData.DevicePowerStateSetpoint = prevDevicePowerStateSetpoint;
      }
   }
}

/**
 * DeviceRegistersCheck GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceRegistersCheckCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.DeviceRegistersCheck == 1)
      {
         GC_DeviceRegistersVerification();
      }
   }
}

/**
 * DeviceRegistersStreamingEnd GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceRegistersStreamingEndCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.DeviceRegistersStreamingEnd == 1)
      {
         GC_DeviceRegistersVerification();
         gGC_RegistersStreaming = 0;
      }
   }
}

/**
 * DeviceRegistersStreamingStart GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceRegistersStreamingStartCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.DeviceRegistersStreamingStart == 1)
      {
         gGC_RegistersStreaming = 1;
      }
   }
}

/**
 * DeviceRegistersValid GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceRegistersValidCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceReset GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceResetCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.DeviceReset == 1)
      {
         Power_CameraReset();
      }
   }
}

/**
 * DeviceRunningTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceRunningTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceSerialNumber GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceSerialNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceSerialPortBaudRate GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceSerialPortBaudRateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceSerialPortSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceSerialPortSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceTemperature GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceTemperatureCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceTemperature = DeviceTemperatureAry[gcRegsData.DeviceTemperatureSelector];
   }
}

/**
 * DeviceTemperatureSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceTemperatureSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceVendorName GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceVendorNameCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceVoltage GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceVoltageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.DeviceVoltage = DeviceVoltageAry[gcRegsData.DeviceVoltageSelector];
   }
}

/**
 * DeviceVoltageSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceVoltageSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceXMLMajorVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceXMLMajorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceXMLMinorVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceXMLMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DeviceXMLSubMinorVersion GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceXMLSubMinorVersionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIExpectedTemperatureMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExpectedTemperatureMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update EHDRIExpectedTemperatureMinMax register
      gcRegsData.EHDRIExpectedTemperatureMinMax = gcRegsData.EHDRIExpectedTemperatureMax;
   }
}

/**
 * EHDRIExpectedTemperatureMaxMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExpectedTemperatureMaxMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIExpectedTemperatureMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExpectedTemperatureMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update EHDRIExpectedTemperatureMaxMin register
      gcRegsData.EHDRIExpectedTemperatureMaxMin = gcRegsData.EHDRIExpectedTemperatureMin;
   }
}

/**
 * EHDRIExpectedTemperatureMinMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExpectedTemperatureMinMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIExposureOccurrence1 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExposureOccurrence1Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIExposureOccurrence2 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExposureOccurrence2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIExposureOccurrence3 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExposureOccurrence3Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIExposureOccurrence4 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIExposureOccurrence4Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRIMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * EHDRINumberOfExposures GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRINumberOfExposuresCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_UpdateParameterLimits();
      if (EHDRIIsActive)
      {
         gcRegsData.ExposureTime1 = EHDRIExposureTime[0];
         gcRegsData.ExposureTime2 = EHDRIExposureTime[1];
         gcRegsData.ExposureTime3 = EHDRIExposureTime[2];
         gcRegsData.ExposureTime4 = EHDRIExposureTime[3];
         GC_UpdateParameterLimits();
      }
      CAL_UpdateVideo(&gCal, &gcRegsData);
      GC_UpdateAECPlusIsAvailable();
   }
}

/**
 * EHDRIResetToDefault GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EHDRIResetToDefaultCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      EHDRI_Reset(&gEHDRIManager, &gcRegsData);

      if (EHDRIIsActive)
      {
         gcRegsData.ExposureTime1 = EHDRIExposureTime[0];
         gcRegsData.ExposureTime2 = EHDRIExposureTime[1];
         gcRegsData.ExposureTime3 = EHDRIExposureTime[2];
         gcRegsData.ExposureTime4 = EHDRIExposureTime[3];
   }
   }
}

/**
 * EventError GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventErrorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read
      gcRegsData.EventError = 0;
      GC_NextEventError();
   }
}

/**
 * EventErrorCode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventErrorCodeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read
      gcRegsData.EventErrorCode = EECD_NoError;
      GC_NextEventError();
   }
}

/**
 * EventErrorTimestamp GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventErrorTimestampCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read
      gcRegsData.EventErrorTimestamp = 0;
      GC_NextEventError();
   }
}

/**
 * EventNotification GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventNotificationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.EventNotification = EventNotificationAry[gcRegsData.EventSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      EventNotificationAry[gcRegsData.EventSelector] = gcRegsData.EventNotification;
   }
}

/**
 * EventSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      gcRegsData.EventSelector = MIN(gcRegsData.EventSelector, EventNotificationAryLen - 1);
   }
}

/**
 * EventTelops GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventTelopsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read
      gcRegsData.EventTelops = 0;
      GC_NextEventTelops();
   }
}

/**
 * EventTelopsCode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventTelopsCodeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read
      gcRegsData.EventTelopsCode = ETCD_NoEvent;
      GC_NextEventTelops();
   }
}

/**
 * EventTelopsTimestamp GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_EventTelopsTimestampCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read
      gcRegsData.EventTelopsTimestamp = 0;
      GC_NextEventTelops();
   }
}

/**
 * ExposureAuto GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureAutoCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
      AEC_UpdateMode(&gcRegsData, &gAEC_Ctrl);
      HDER_UpdateAECHeader(&gHderInserter, &gcRegsData);

      if (gcRegsData.ExposureAuto == EA_Off)
      {
         // Update Frame Rate limit with the actual exposure times
         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ExposureTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if(gcRegsData.FWMode != FWM_SynchronouslyRotating)
      {
         // Update ExposureTime and FrameRate limits
         GC_UpdateParameterLimits();
      }

      if (!gGC_RegistersStreaming && ((gcRegsData.ExposureTime > gcRegsData.ExposureTimeMax) || (gcRegsData.ExposureTime < gcRegsData.ExposureTimeMin)))
      {
         GC_GenerateEventError(EECD_InvalidExposure);
      }
      else
      {
         EXP_SendConfigGC(&gExposureTime, &gcRegsData);
      }
   }
}

/**
 * ExposureTime1 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime1Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (EHDRIIsActive)
      {
         EHDRIExposureTime[0] = gcRegsData.ExposureTime1;
      }
      else if (FWSynchronoulyRotatingModeIsActive)
      {
         // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime1 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime1 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[0] = gcRegsData.ExposureTime1;
         SFW_SetExposureTimeArray(0, FWExposureTime[0]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime2 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (EHDRIIsActive)
      {
         EHDRIExposureTime[1] = gcRegsData.ExposureTime2;
      }
      else if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime2 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime2 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[1] = gcRegsData.ExposureTime2;
         SFW_SetExposureTimeArray(1, FWExposureTime[1]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime3 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime3Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (EHDRIIsActive)
      {
         EHDRIExposureTime[2] = gcRegsData.ExposureTime3;
      }
      else if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime3 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime3 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[2] = gcRegsData.ExposureTime3;
         SFW_SetExposureTimeArray(2, FWExposureTime[2]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime4 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime4Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (EHDRIIsActive)
      {
         EHDRIExposureTime[3] = gcRegsData.ExposureTime4;
      }
      else if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime4 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime4 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[3] = gcRegsData.ExposureTime4;
         SFW_SetExposureTimeArray(3, FWExposureTime[3]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime5 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime5Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime5 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime5 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[4] = gcRegsData.ExposureTime5;
         SFW_SetExposureTimeArray(4, FWExposureTime[4]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime6 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime6Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime6 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime6 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[5] = gcRegsData.ExposureTime6;
         SFW_SetExposureTimeArray(5, FWExposureTime[5]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime7 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime7Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime7 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime7 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[6] = gcRegsData.ExposureTime7;
         SFW_SetExposureTimeArray(6, FWExposureTime[6]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTime8 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTime8Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      if (FWSynchronoulyRotatingModeIsActive)
      {
     	   // TODO: la limitation devrait se faire dans SFW_CalculateMaximalValues() sans affecter le frame rate
         if (gcRegsData.ExposureTime8 > gcRegsData.ExposureTimeMax)
         {
            gcRegsData.ExposureTime8 = gcRegsData.ExposureTimeMax;
         }

         FWExposureTime[7] = gcRegsData.ExposureTime8;
         SFW_SetExposureTimeArray(7, FWExposureTime[7]);

         SFW_CalculateMaximalValues(&gcRegsData, EXPOSURE_TIME_CHANGED);
         GC_UpdateParameterLimits();
         SFW_LimitParameter(&gcRegsData);
      }
   }
}

/**
 * ExposureTimeMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTimeMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ExposureTimeMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTimeMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ExposureTimeSetToMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTimeSetToMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if(gcRegsData.ExposureTimeSetToMax == 1)
      {
         gcRegsData.ExposureTimeSetToMax = 0;

         GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeIdx], gcRegsData.ExposureTimeMax);
      }
   }
}

/**
 * ExternalBlackBodyTemperature GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExternalBlackBodyTemperatureCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      HDER_UpdateExternalBBTempHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * ExternalFanSpeed GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExternalFanSpeedCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ExternalFanSpeedSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExternalFanSpeedSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      GC_SetExternalFanSpeed();
   }
}

/**
 * ExternalLensSerialNumber GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExternalLensSerialNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FValSize GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FValSizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FWFilterNumber GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWFilterNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FWMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   int32_t counts;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_UpdateParameterLimits();

      CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);
      if (FWSynchronoulyRotatingModeIsActive)
      {
         gcRegsData.ExposureTime1 = FWExposureTime[0];
         gcRegsData.ExposureTime2 = FWExposureTime[1];
         gcRegsData.ExposureTime3 = FWExposureTime[2];
         gcRegsData.ExposureTime4 = FWExposureTime[3];
         gcRegsData.ExposureTime5 = FWExposureTime[4];
         gcRegsData.ExposureTime6 = FWExposureTime[5];
         gcRegsData.ExposureTime7 = FWExposureTime[6];
         gcRegsData.ExposureTime8 = FWExposureTime[7];
      }

      if(flashSettings.FWType == FW_SYNC)
         SFW_UpdateSFWMode(gcRegsData.FWMode);

      if( gcRegsData.FWMode == FWM_Fixed)
      {
         if (FW_getFilterPosition(gcRegsData.FWPositionSetpoint, &counts, flashSettings.FWType))
         {
            ChangeFWControllerMode(FW_POSITION_MODE, counts);
         }
      }
      else if(gcRegsData.FWMode == FWM_AsynchronouslyRotating )
      {
         ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint);
      }
      else if(gcRegsData.FWMode == FWM_SynchronouslyRotating)
      {
         //Limit Parameter
         FW_CalculateSpeedSetpoint(&gcRegsData);
         SFW_CalculateMaximalValues(&gcRegsData, ALL_CHANGED);
         SFW_LimitParameter(&gcRegsData);
         ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint); // TODO should we set something always valid?
      }

      GC_UpdateAECPlusIsAvailable();
      CAL_UpdateVideo(&gCal, &gcRegsData);
   }
}

/**
 * FWPosition GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FWPositionRaw GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FWPositionRawSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      FW_setRawPositionMode(true);
      ChangeFWControllerMode(FW_POSITION_MODE, gcRegsData.FWPositionRawSetpoint);
   }
}

/**
 * FWPositionSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   static uint32_t prevFWPositionSetpoint;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      // Before write
      prevFWPositionSetpoint = gcRegsData.FWPositionSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (calibrationInfo.isValid && ((calibrationInfo.collection.CollectionType == CCT_TelopsFW) || (calibrationInfo.collection.CollectionType == CCT_MultipointFW)))
         CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);   // Updates FWPositionSetpoint
      else
         GC_SetFWPositionSetpoint(prevFWPositionSetpoint, gcRegsData.FWPositionSetpoint);
   }
}

/**
 * FWSpeed GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWSpeedCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FWSpeedMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWSpeedMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FWSpeedSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FWSpeedSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   static uint32_t prevFWSpeedSetpoint = 0;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      prevFWSpeedSetpoint = gcRegsData.FWSpeedSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if(gcRegsData.FWSpeedSetpoint <= gcRegsData.FWSpeedMax)
      {
         ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint);
      }
      else
      {
         gcRegsData.FWSpeedMax = prevFWSpeedSetpoint;
      }
   }
}

/**
 * GPSAltitude GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GPSAltitudeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * GPSLatitude GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GPSLatitudeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * GPSLongitude GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GPSLongitudeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * GPSModeIndicator GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GPSModeIndicatorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * GPSNumberOfSatellitesInUse GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GPSNumberOfSatellitesInUseCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * GevFirstURL GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GevFirstURLCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * GevSecondURL GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_GevSecondURLCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * Height GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_HeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read

      // Add 2 header lines for the NTx-Mini
      gcRegsData.Height += 2;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // After read

      // Remove 2 header lines (added for the NTx-Mini)
      gcRegsData.Height -= 2;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Remove 2 header lines (added for the NTx-Mini)
      gcRegsData.Height -= 2;

      SFW_CalculateMaximalValues(&gcRegsData, HEIGHT_CHANGED);
      GC_UpdateParameterLimits();
      GC_ComputeImageLimits();

      SFW_LimitParameter(&gcRegsData);

      AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
		AEC_UpdateMode(&gcRegsData, &gAEC_Ctrl);

		// Update Memory Buffer params
      GC_MemoryBufferModeCallback(GCCP_AFTER, GCCA_WRITE);
   }
}

/**
 * HeightInc GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_HeightIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * HeightMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_HeightMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * HeightMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_HeightMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ICUPosition GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ICUPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
	   ICU_getCurrentState(&gcRegsData, &gICU_ctrl);
   }
}

/**
 * ICUPositionSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ICUPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      ICU_setpointUpdated(&gcRegsData, &gICU_ctrl);
   }
}

/**
 * IntegrationMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_IntegrationModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * IsActiveFlags GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_IsActiveFlagsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * LockedCenterImage GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_LockedCenterImageCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ManualFilterSerialNumber GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ManualFilterSerialNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferMOIActivation GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferMOIActivationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      BufferManager_SetMoiConfig(&gBufManager);
   }
}

/**
 * MemoryBufferMOISoftware GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferMOISoftwareCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if ((gcRegsData.MemoryBufferMOISoftware == 1) &&
            (gcRegsData.MemoryBufferMOISource == MBMOIS_Software))
      {
         BufferManager_SendSoftwareMoi(&gBufManager);
      }
   }
}

/**
 * MemoryBufferMOISource GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferMOISourceCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      BufferManager_SetMoiConfig(&gBufManager);
   }
}

/**
 * MemoryBufferMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
     BufferManager_SetMoiConfig(&gBufManager);
	  if(gcRegsData.MemoryBufferMode == MBM_Off)
	  {
		  if (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask))
		  {
		     BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_EXTERNAL_LIVE);
		  }
		  else
		  {
           BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_INTERNAL_LIVE);
           BufferManager_SetBufferMode(&gBufManager, BM_OFF,  &gcRegsData);
		  }
	  }
	  else if(gcRegsData.MemoryBufferMode == MBM_On && gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Off)
	  {
		  if (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask))
        {
           BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_EXTERNAL_LIVE);
        }
        else
        {
           BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_INTERNAL_LIVE);
           BufferManager_SetBufferMode(&gBufManager, BM_WRITE,  &gcRegsData);
        }
	  }
	  else
	  {
	     if (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask))
        {
           BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_EXTERNAL_PLAYBACK);
        }
        else
        {
           BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_INTERNAL_PLAYBACK);
           BufferManager_SetBufferMode(&gBufManager, BM_READ,  &gcRegsData);
        }
	  }

   }
}

/**
 * MemoryBufferNumberOfImagesMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferNumberOfImagesMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
	   gcRegsData.MemoryBufferNumberOfImagesMax = BufferManager_GetNbImageMax(&gBufManager, &gcRegsData);
   }
}

/**
 * MemoryBufferNumberOfSequences GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferNumberOfSequencesCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      //Limit Number of image
      GC_UpdateMemoryBufferNumberOfSequenceLimits();
	   BufferManager_SetSequenceParams(&gBufManager, &gcRegsData);

   }
}

/**
 * MemoryBufferNumberOfSequencesMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferNumberOfSequencesMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
	   gcRegsData.MemoryBufferNumberOfSequencesMax = BufferManager_GetNumberOfSequenceMax();
   }
}

/**
 * MemoryBufferSequenceClearAll GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceClearAllCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
	   BufferManager_ClearSequence(&gBufManager, &gcRegsData);
   }
}

/**
 * MemoryBufferSequenceCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferSequenceDownloadBitRateMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadBitRateMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferSequenceDownloadImageFrameID GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadImageFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   uint32_t firstFrameID, lastFrameID;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      firstFrameID = BufferManager_GetSequenceFirstFrameId(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
      lastFrameID = firstFrameID + BufferManager_GetSequenceLength(&gBufManager, gcRegsData.MemoryBufferSequenceSelector) - 1;

      if (gcRegsData.MemoryBufferSequenceDownloadImageFrameID < firstFrameID)
         gcRegsData.MemoryBufferSequenceDownloadImageFrameID = firstFrameID;

      if (gcRegsData.MemoryBufferSequenceDownloadImageFrameID > lastFrameID)
         gcRegsData.MemoryBufferSequenceDownloadImageFrameID = lastFrameID;
   }
}

/**
 * MemoryBufferSequenceDownloadMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      GC_MemoryBufferModeCallback(GCCP_AFTER, GCCA_WRITE);
   }
}

/**
 * MemoryBufferSequenceFirstFrameID GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceFirstFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.MemoryBufferSequenceFirstFrameID = BufferManager_GetSequenceFirstFrameId(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
   }
}

/**
 * MemoryBufferSequenceMOIFrameID GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceMOIFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.MemoryBufferSequenceMOIFrameID = BufferManager_GetSequenceMOIFrameId(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
   }
}

/**
 * MemoryBufferSequencePreMOISize GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequencePreMOISizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      GC_UpdateMemoryBufferSequencePreMOISizeLimits();
      BufferManager_SetSequenceParams(&gBufManager, &gcRegsData);

   }
}

/**
 * MemoryBufferSequenceRecordedSize GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceRecordedSizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.MemoryBufferSequenceRecordedSize = BufferManager_GetSequenceLength(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
   }
}

/**
 * MemoryBufferSequenceSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferSequenceSize GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceSizeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      // Limit the parameter value
      GC_UpdateMemoryBufferSequenceSizeLimits();
      BufferManager_SetSequenceParams(&gBufManager, &gcRegsData);
   }
}

/**
 * MemoryBufferSequenceSizeMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceSizeMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read

      // Since MemoryBufferSequenceSize must be even, make sure MemoryBufferSequenceSizeMax is even too
      gcRegsData.MemoryBufferSequenceSizeMax = roundDown(BufferManager_GetNbImageMax(&gBufManager, &gcRegsData), 2);
   }
}

/**
 * NDFilterArmedPositionSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_NDFilterArmedPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.ExposureAuto == EA_ArmedNDFilter)
      {
         GC_SetNDFPositionSetpoint(gcRegsData.NDFilterPositionSetpoint, gcRegsData.NDFilterArmedPositionSetpoint);
      }
   }
}

/**
 * NDFilterNumber GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_NDFilterNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * NDFilterPosition GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_NDFilterPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * NDFilterPositionRaw GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_NDFilterPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * NDFilterPositionRawSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_NDFilterPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      NDF_setRawPositionMode(true);
      ChangeNDFControllerMode(NDF_POSITION_MODE, gcRegsData.NDFilterPositionRawSetpoint);
   }
}

/**
 * NDFilterPositionSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_NDFilterPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   static uint32_t prevNDFPositionSetpoint;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      // Before write
      prevNDFPositionSetpoint = gcRegsData.NDFilterPositionSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      GC_SetNDFPositionSetpoint(prevNDFPositionSetpoint, gcRegsData.NDFilterPositionSetpoint);
   }
}

/**
 * OffsetX GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetXCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      //GC_UpdateParameterLimits();    // Offsets have no impact on ExpTime and AcqFrameRate
      GC_ComputeImageLimits();
   }
}

/**
 * OffsetXInc GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetXIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * OffsetXMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetXMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * OffsetXMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetXMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * OffsetY GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetYCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      //GC_UpdateParameterLimits();    // Offsets have no impact on ExpTime and AcqFrameRate
      GC_ComputeImageLimits();
   }
}

/**
 * OffsetYInc GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetYIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * OffsetYMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetYMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * OffsetYMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_OffsetYMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * POSIXTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_POSIXTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   t_PosixTime time;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      time = TRIG_GetRTC(&gTrig);
      gcRegsData.POSIXTime = time.Seconds;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      TRIG_OverWritePOSIXNow(gcRegsData.POSIXTime, &gTrig);
   }
}

/**
 * PixelDataResolution GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_PixelDataResolutionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * PixelFormat GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_PixelFormatCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * PowerOnAtStartup GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_PowerOnAtStartupCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update PowerOnAtStartup flash dynamic value
      gFlashDynamicValues.PowerOnAtStartup = gcRegsData.PowerOnAtStartup;

      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         GC_ERR("Failed to update flash dynamic values.");
      }
   }
}

/**
 * ProprietaryFeature GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ProprietaryFeatureCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   const uint32_t key_high = 0xB09CCFC2;
   const uint32_t key_low = 0x49579EE8;
   static uint32_t prevProprietaryFeature = 0;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if ((prevProprietaryFeature == key_high) && (gcRegsData.ProprietaryFeature == key_low))
      {
         GC_UnlockCamera();
      }

      prevProprietaryFeature = gcRegsData.ProprietaryFeature;
   }
}

/**
 * ReverseX GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ReverseXCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      HDER_UpdateReverseXHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * ReverseY GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ReverseYCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      HDER_UpdateReverseYHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * SensorHeight GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_SensorHeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * SensorID GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_SensorIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * SensorWellDepth GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_SensorWellDepthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * SensorWidth GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_SensorWidthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * StealthMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_StealthModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern flashDynamicValues_t gFlashDynamicValues;
   extern ledCtrl_t gLedCtrl;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write

      // Update StealthMode flash dynamic value
      gFlashDynamicValues.StealthMode = gcRegsData.StealthMode;

      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         GC_ERR("Failed to update flash dynamic values.");
      }

      Power_UpdateCameraLedState(&gLedCtrl);
   }
}

/**
 * SubSecondTime GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_SubSecondTimeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   t_PosixTime time;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      time = TRIG_GetRTC(&gTrig);
      gcRegsData.SubSecondTime = time.SubSeconds;
   }
}

/**
 * TDCFlags GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TDCFlagsCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * TDCStatus GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TDCStatusCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * TestImageSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TestImageSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * TimeSource GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TimeSourceCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * TriggerActivation GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerActivationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.TriggerActivation = TriggerActivationAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      TriggerActivationAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerActivation;
   }
}

/**
 * TriggerDelay GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerDelayCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.TriggerDelay = TriggerDelayAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      TriggerDelayAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerDelay;
   }
}

/**
 * TriggerFrameCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerFrameCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.TriggerFrameCount = TriggerFrameCountAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      TriggerFrameCountAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerFrameCount;
   }
}

/**
 * TriggerMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   uint32_t triggerIsActiveFlagMask;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.TriggerMode = TriggerModeAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      TriggerModeAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerMode;

      // Update TriggerIsActive flags
      triggerIsActiveFlagMask = 0x00000001 << gcRegsData.TriggerSelector;
      IsActiveFlagsClr(triggerIsActiveFlagMask);
      if (TriggerModeAry[gcRegsData.TriggerSelector] == TM_On)
      {
         IsActiveFlagsSet(triggerIsActiveFlagMask);
      }

      // Update AECPlusIsAvailableMask value
      GC_UpdateAECPlusIsAvailable();
   }
}

/**
 * TriggerSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * TriggerSoftware GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerSoftwareCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (TriggerSourceAry[gcRegsData.TriggerSelector] == TS_Software)
      {
         switch (gcRegsData.TriggerSelector)
         {
            case TS_AcquisitionStart:
               TRIG_SendTrigSoft(&gTrig, &gcRegsData);
               break;

            case TS_Flagging:
               FLAG_SendTrig(&gFlagging_ctrl);
               break;

            case TS_Gating:
               GATING_SendTrig(&gGating_ctrl);
               break;
         }
      }
   }
}

/**
 * TriggerSource GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TriggerSourceCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      // Before read
      gcRegsData.TriggerSource = TriggerSourceAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      TriggerSourceAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerSource;
   }
}

/**
 * VideoAGC GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_VideoAGCCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      if (gcRegsData.VideoAGC != VAGC_Off)
      {
         GC_RegisterWriteUI32(&gcRegsDef[VideoBadPixelReplacementIdx], 1);
      }
   }
}

/**
 * VideoBadPixelReplacement GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_VideoBadPixelReplacementCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      CAL_UpdateVideo(&gCal, &gcRegsData);
   }
}

/**
 * VideoEHDRIExposureIndex GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_VideoEHDRIExposureIndexCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      CAL_UpdateVideo(&gCal, &gcRegsData);
   }
}

/**
 * VideoFWPosition GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_VideoFWPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      CAL_UpdateVideo(&gCal, &gcRegsData);
   }
}

/**
 * VideoFreeze GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_VideoFreezeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      CAL_UpdateVideo(&gCal, &gcRegsData);
   }
}

/**
 * Width GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_WidthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // After write
      SFW_CalculateMaximalValues(&gcRegsData, WIDTH_CHANGED);
      GC_UpdateParameterLimits();

      GC_ComputeImageLimits();

      SFW_LimitParameter(&gcRegsData);

      AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
		AEC_UpdateMode(&gcRegsData, &gAEC_Ctrl);

		// Update Memory Buffer params
      GC_MemoryBufferModeCallback(GCCP_AFTER, GCCA_WRITE);
   }
}

/**
 * WidthInc GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_WidthIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * WidthMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_WidthMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * WidthMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_WidthMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/* AUTO-CODE END */

///**
// * DeviceTemperatureShutdownThresh GenICam register callback function.
// *
// * @param phase indicates whether the function is called before or
// *    after the read or write operation.
// * @param access indicates whether the operation is read or write.
// */
//void GC_DeviceTemperatureShutdownThreshCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
//{
//   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
//   {
//      // Before read
//      gcRegsData.DeviceTemperatureShutdownThresh = DeviceTemperatureShutdownThreshAry[gcRegsData.DeviceTemperatureSelector];
//   }
//}

///**
// * DeviceTemperatureWarningThresh GenICam register callback function.
// *
// * @param phase indicates whether the function is called before or
// *    after the read or write operation.
// * @param access indicates whether the operation is read or write.
// */
//void GC_DeviceTemperatureWarningThreshCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
//{
//   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
//   {
//      // Before read
//      gcRegsData.DeviceTemperatureWarningThresh = DeviceTemperatureWarningThreshAry[gcRegsData.DeviceTemperatureSelector];
//   }
//}
