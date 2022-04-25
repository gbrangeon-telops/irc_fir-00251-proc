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
#include "hder_inserter.h"
#include "Calibration.h"
#include "FileManager.h"
#include "Trig_gen.h"
#include <math.h>
#include <stdlib.h>
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
#include "RpOpticalProtocol.h"
#include "SightLineSLAProtocol.h"
#include "GC_Store.h"
#include "mgt_ctrl.h"
#include "fpa_intf.h"

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
extern rpCtrl_t theRpCtrl;
extern slCtrl_t theSlCtrl;
extern qspiFlash_t gQSPIFlash;
extern t_mgt gMGT;
extern float EHDRIExposureTime[EHDRI_IDX_NBR];
extern float FWExposureTime[MAX_NUM_FILTER];

#ifdef SCD_PROXY
   extern uint8_t gFrameRateChangePostponed;
   extern uint8_t gWaitingForFilterWheel;
#endif

/* AUTO-CODE BEGIN */
// Auto-generated GeniCam registers callback functions definition.
// Generated from XML camera definition file version 13.2.0
// using updateGenICamCallback.m Matlab script.

/**
 * GenICam registers callback function initialization.
 */
void GC_Callback_Init()
{
   gcRegsDef[AECImageFractionIdx].callback =                                     &GC_AECImageFractionCallback;
   gcRegsDef[AECPlusExtrapolationWeightIdx].callback =                           &GC_AECPlusExtrapolationWeightCallback;
   gcRegsDef[AECResponseTimeIdx].callback =                                      &GC_AECResponseTimeCallback;
   gcRegsDef[AECTargetWellFillingIdx].callback =                                 &GC_AECTargetWellFillingCallback;
   gcRegsDef[AcquisitionArmIdx].callback =                                       &GC_AcquisitionArmCallback;
   gcRegsDef[AcquisitionFrameRateIdx].callback =                                 &GC_AcquisitionFrameRateCallback;
   gcRegsDef[AcquisitionFrameRateMaxIdx].callback =                              &GC_AcquisitionFrameRateMaxCallback;
   gcRegsDef[AcquisitionFrameRateMaxFGIdx].callback =                            &GC_AcquisitionFrameRateMaxFGCallback;
   gcRegsDef[AcquisitionFrameRateMinIdx].callback =                              &GC_AcquisitionFrameRateMinCallback;
   gcRegsDef[AcquisitionFrameRateModeIdx].callback =                             &GC_AcquisitionFrameRateModeCallback;
   gcRegsDef[AcquisitionFrameRateSetToMaxIdx].callback =                         &GC_AcquisitionFrameRateSetToMaxCallback;
   gcRegsDef[AcquisitionFrameRateUnrestrictedMaxIdx].callback =                  &GC_AcquisitionFrameRateUnrestrictedMaxCallback;
   gcRegsDef[AcquisitionFrameRateUnrestrictedMinIdx].callback =                  &GC_AcquisitionFrameRateUnrestrictedMinCallback;
   gcRegsDef[AcquisitionModeIdx].callback =                                      &GC_AcquisitionModeCallback;
   gcRegsDef[AcquisitionStartIdx].callback =                                     &GC_AcquisitionStartCallback;
   gcRegsDef[AcquisitionStartAtStartupIdx].callback =                            &GC_AcquisitionStartAtStartupCallback;
   gcRegsDef[AcquisitionStopIdx].callback =                                      &GC_AcquisitionStopCallback;
   gcRegsDef[AutofocusIdx].callback =                                            &GC_AutofocusCallback;
   gcRegsDef[AutofocusModeIdx].callback =                                        &GC_AutofocusModeCallback;
   gcRegsDef[AutofocusROIIdx].callback =                                         &GC_AutofocusROICallback;
   gcRegsDef[AutomaticExternalFanSpeedModeIdx].callback =                        &GC_AutomaticExternalFanSpeedModeCallback;
   gcRegsDef[AvailabilityFlagsIdx].callback =                                    &GC_AvailabilityFlagsCallback;
   gcRegsDef[BadPixelReplacementIdx].callback =                                  &GC_BadPixelReplacementCallback;
   gcRegsDef[CalibrationCollectionActiveBlockPOSIXTimeIdx].callback =            &GC_CalibrationCollectionActiveBlockPOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionActivePOSIXTimeIdx].callback =                 &GC_CalibrationCollectionActivePOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionActiveTypeIdx].callback =                      &GC_CalibrationCollectionActiveTypeCallback;
   gcRegsDef[CalibrationCollectionBlockCountIdx].callback =                      &GC_CalibrationCollectionBlockCountCallback;
   gcRegsDef[CalibrationCollectionBlockLoadIdx].callback =                       &GC_CalibrationCollectionBlockLoadCallback;
   gcRegsDef[CalibrationCollectionBlockPOSIXTimeIdx].callback =                  &GC_CalibrationCollectionBlockPOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionBlockSelectorIdx].callback =                   &GC_CalibrationCollectionBlockSelectorCallback;
   gcRegsDef[CalibrationCollectionCountIdx].callback =                           &GC_CalibrationCollectionCountCallback;
   gcRegsDef[CalibrationCollectionLoadIdx].callback =                            &GC_CalibrationCollectionLoadCallback;
   gcRegsDef[CalibrationCollectionPOSIXTimeIdx].callback =                       &GC_CalibrationCollectionPOSIXTimeCallback;
   gcRegsDef[CalibrationCollectionSelectorIdx].callback =                        &GC_CalibrationCollectionSelectorCallback;
   gcRegsDef[CalibrationCollectionTypeIdx].callback =                            &GC_CalibrationCollectionTypeCallback;
   gcRegsDef[CalibrationModeIdx].callback =                                      &GC_CalibrationModeCallback;
   gcRegsDef[CenterImageIdx].callback =                                          &GC_CenterImageCallback;
   gcRegsDef[ClConfigurationIdx].callback =                                      &GC_ClConfigurationCallback;
   gcRegsDef[DetectorModeIdx].callback =                                         &GC_DetectorModeCallback;
   gcRegsDef[DeviceBuiltInTestsResults1Idx].callback =                           &GC_DeviceBuiltInTestsResults1Callback;
   gcRegsDef[DeviceBuiltInTestsResults2Idx].callback =                           &GC_DeviceBuiltInTestsResults2Callback;
   gcRegsDef[DeviceBuiltInTestsResults3Idx].callback =                           &GC_DeviceBuiltInTestsResults3Callback;
   gcRegsDef[DeviceBuiltInTestsResults4Idx].callback =                           &GC_DeviceBuiltInTestsResults4Callback;
   gcRegsDef[DeviceBuiltInTestsResults7Idx].callback =                           &GC_DeviceBuiltInTestsResults7Callback;
   gcRegsDef[DeviceBuiltInTestsResults8Idx].callback =                           &GC_DeviceBuiltInTestsResults8Callback;
   gcRegsDef[DeviceClockFrequencyIdx].callback =                                 &GC_DeviceClockFrequencyCallback;
   gcRegsDef[DeviceClockSelectorIdx].callback =                                  &GC_DeviceClockSelectorCallback;
   gcRegsDef[DeviceCoolerPowerOnCyclesIdx].callback =                            &GC_DeviceCoolerPowerOnCyclesCallback;
   gcRegsDef[DeviceCoolerRunningTimeIdx].callback =                              &GC_DeviceCoolerRunningTimeCallback;
   gcRegsDef[DeviceCurrentIdx].callback =                                        &GC_DeviceCurrentCallback;
   gcRegsDef[DeviceCurrentSelectorIdx].callback =                                &GC_DeviceCurrentSelectorCallback;
   gcRegsDef[DeviceDetectorElectricalRefOffsetIdx].callback =                    &GC_DeviceDetectorElectricalRefOffsetCallback;
   gcRegsDef[DeviceDetectorElectricalTapsRefIdx].callback =                      &GC_DeviceDetectorElectricalTapsRefCallback;
   gcRegsDef[DeviceDetectorPolarizationVoltageIdx].callback =                    &GC_DeviceDetectorPolarizationVoltageCallback;
   gcRegsDef[DeviceFirmwareBuildVersionIdx].callback =                           &GC_DeviceFirmwareBuildVersionCallback;
   gcRegsDef[DeviceFirmwareMajorVersionIdx].callback =                           &GC_DeviceFirmwareMajorVersionCallback;
   gcRegsDef[DeviceFirmwareMinorVersionIdx].callback =                           &GC_DeviceFirmwareMinorVersionCallback;
   gcRegsDef[DeviceFirmwareModuleRevisionIdx].callback =                         &GC_DeviceFirmwareModuleRevisionCallback;
   gcRegsDef[DeviceFirmwareModuleSelectorIdx].callback =                         &GC_DeviceFirmwareModuleSelectorCallback;
   gcRegsDef[DeviceFirmwareSubMinorVersionIdx].callback =                        &GC_DeviceFirmwareSubMinorVersionCallback;
   gcRegsDef[DeviceIDIdx].callback =                                             &GC_DeviceIDCallback;
   gcRegsDef[DeviceKeyValidationHighIdx].callback =                              &GC_DeviceKeyValidationHighCallback;
   gcRegsDef[DeviceKeyValidationLowIdx].callback =                               &GC_DeviceKeyValidationLowCallback;
   gcRegsDef[DeviceLedIndicatorStateIdx].callback =                              &GC_DeviceLedIndicatorStateCallback;
   gcRegsDef[DeviceManufacturerInfoIdx].callback =                               &GC_DeviceManufacturerInfoCallback;
   gcRegsDef[DeviceModelNameIdx].callback =                                      &GC_DeviceModelNameCallback;
   gcRegsDef[DeviceNotReadyIdx].callback =                                       &GC_DeviceNotReadyCallback;
   gcRegsDef[DevicePowerOnCyclesIdx].callback =                                  &GC_DevicePowerOnCyclesCallback;
   gcRegsDef[DevicePowerStateIdx].callback =                                     &GC_DevicePowerStateCallback;
   gcRegsDef[DevicePowerStateSetpointIdx].callback =                             &GC_DevicePowerStateSetpointCallback;
   gcRegsDef[DeviceRegistersCheckIdx].callback =                                 &GC_DeviceRegistersCheckCallback;
   gcRegsDef[DeviceRegistersStreamingEndIdx].callback =                          &GC_DeviceRegistersStreamingEndCallback;
   gcRegsDef[DeviceRegistersStreamingStartIdx].callback =                        &GC_DeviceRegistersStreamingStartCallback;
   gcRegsDef[DeviceRegistersValidIdx].callback =                                 &GC_DeviceRegistersValidCallback;
   gcRegsDef[DeviceResetIdx].callback =                                          &GC_DeviceResetCallback;
   gcRegsDef[DeviceRunningTimeIdx].callback =                                    &GC_DeviceRunningTimeCallback;
   gcRegsDef[DeviceSerialNumberIdx].callback =                                   &GC_DeviceSerialNumberCallback;
   gcRegsDef[DeviceSerialPortBaudRateIdx].callback =                             &GC_DeviceSerialPortBaudRateCallback;
   gcRegsDef[DeviceSerialPortFunctionIdx].callback =                             &GC_DeviceSerialPortFunctionCallback;
   gcRegsDef[DeviceSerialPortSelectorIdx].callback =                             &GC_DeviceSerialPortSelectorCallback;
   gcRegsDef[DeviceTemperatureIdx].callback =                                    &GC_DeviceTemperatureCallback;
   gcRegsDef[DeviceTemperatureSelectorIdx].callback =                            &GC_DeviceTemperatureSelectorCallback;
   gcRegsDef[DeviceVendorNameIdx].callback =                                     &GC_DeviceVendorNameCallback;
   gcRegsDef[DeviceVersionIdx].callback =                                        &GC_DeviceVersionCallback;
   gcRegsDef[DeviceVoltageIdx].callback =                                        &GC_DeviceVoltageCallback;
   gcRegsDef[DeviceVoltageSelectorIdx].callback =                                &GC_DeviceVoltageSelectorCallback;
   gcRegsDef[DeviceXMLMajorVersionIdx].callback =                                &GC_DeviceXMLMajorVersionCallback;
   gcRegsDef[DeviceXMLMinorVersionIdx].callback =                                &GC_DeviceXMLMinorVersionCallback;
   gcRegsDef[DeviceXMLSubMinorVersionIdx].callback =                             &GC_DeviceXMLSubMinorVersionCallback;
   gcRegsDef[EHDRIExpectedTemperatureMaxIdx].callback =                          &GC_EHDRIExpectedTemperatureMaxCallback;
   gcRegsDef[EHDRIExpectedTemperatureMaxMinIdx].callback =                       &GC_EHDRIExpectedTemperatureMaxMinCallback;
   gcRegsDef[EHDRIExpectedTemperatureMinIdx].callback =                          &GC_EHDRIExpectedTemperatureMinCallback;
   gcRegsDef[EHDRIExpectedTemperatureMinMaxIdx].callback =                       &GC_EHDRIExpectedTemperatureMinMaxCallback;
   gcRegsDef[EHDRIExposureOccurrence1Idx].callback =                             &GC_EHDRIExposureOccurrence1Callback;
   gcRegsDef[EHDRIExposureOccurrence2Idx].callback =                             &GC_EHDRIExposureOccurrence2Callback;
   gcRegsDef[EHDRIExposureOccurrence3Idx].callback =                             &GC_EHDRIExposureOccurrence3Callback;
   gcRegsDef[EHDRIExposureOccurrence4Idx].callback =                             &GC_EHDRIExposureOccurrence4Callback;
   gcRegsDef[EHDRIModeIdx].callback =                                            &GC_EHDRIModeCallback;
   gcRegsDef[EHDRINumberOfExposuresIdx].callback =                               &GC_EHDRINumberOfExposuresCallback;
   gcRegsDef[EHDRIResetToDefaultIdx].callback =                                  &GC_EHDRIResetToDefaultCallback;
   gcRegsDef[EventErrorIdx].callback =                                           &GC_EventErrorCallback;
   gcRegsDef[EventErrorCodeIdx].callback =                                       &GC_EventErrorCodeCallback;
   gcRegsDef[EventErrorTimestampIdx].callback =                                  &GC_EventErrorTimestampCallback;
   gcRegsDef[EventNotificationIdx].callback =                                    &GC_EventNotificationCallback;
   gcRegsDef[EventSelectorIdx].callback =                                        &GC_EventSelectorCallback;
   gcRegsDef[EventTelopsIdx].callback =                                          &GC_EventTelopsCallback;
   gcRegsDef[EventTelopsCodeIdx].callback =                                      &GC_EventTelopsCodeCallback;
   gcRegsDef[EventTelopsTimestampIdx].callback =                                 &GC_EventTelopsTimestampCallback;
   gcRegsDef[ExposureAutoIdx].callback =                                         &GC_ExposureAutoCallback;
   gcRegsDef[ExposureModeIdx].callback =                                         &GC_ExposureModeCallback;
   gcRegsDef[ExposureTimeIdx].callback =                                         &GC_ExposureTimeCallback;
   gcRegsDef[ExposureTime1Idx].callback =                                        &GC_ExposureTime1Callback;
   gcRegsDef[ExposureTime2Idx].callback =                                        &GC_ExposureTime2Callback;
   gcRegsDef[ExposureTime3Idx].callback =                                        &GC_ExposureTime3Callback;
   gcRegsDef[ExposureTime4Idx].callback =                                        &GC_ExposureTime4Callback;
   gcRegsDef[ExposureTime5Idx].callback =                                        &GC_ExposureTime5Callback;
   gcRegsDef[ExposureTime6Idx].callback =                                        &GC_ExposureTime6Callback;
   gcRegsDef[ExposureTime7Idx].callback =                                        &GC_ExposureTime7Callback;
   gcRegsDef[ExposureTime8Idx].callback =                                        &GC_ExposureTime8Callback;
   gcRegsDef[ExposureTimeMaxIdx].callback =                                      &GC_ExposureTimeMaxCallback;
   gcRegsDef[ExposureTimeMinIdx].callback =                                      &GC_ExposureTimeMinCallback;
   gcRegsDef[ExposureTimeSetToMaxIdx].callback =                                 &GC_ExposureTimeSetToMaxCallback;
   gcRegsDef[ExposureTimeSetToMinIdx].callback =                                 &GC_ExposureTimeSetToMinCallback;
   gcRegsDef[ExternalBlackBodyTemperatureIdx].callback =                         &GC_ExternalBlackBodyTemperatureCallback;
   gcRegsDef[ExternalFanSpeedIdx].callback =                                     &GC_ExternalFanSpeedCallback;
   gcRegsDef[ExternalFanSpeedSetpointIdx].callback =                             &GC_ExternalFanSpeedSetpointCallback;
   gcRegsDef[ExternalLensSerialNumberIdx].callback =                             &GC_ExternalLensSerialNumberCallback;
   gcRegsDef[FOVPositionIdx].callback =                                          &GC_FOVPositionCallback;
   gcRegsDef[FOVPositionNumberIdx].callback =                                    &GC_FOVPositionNumberCallback;
   gcRegsDef[FOVPositionRawIdx].callback =                                       &GC_FOVPositionRawCallback;
   gcRegsDef[FOVPositionRawMaxIdx].callback =                                    &GC_FOVPositionRawMaxCallback;
   gcRegsDef[FOVPositionRawMinIdx].callback =                                    &GC_FOVPositionRawMinCallback;
   gcRegsDef[FOVPositionRawSetpointIdx].callback =                               &GC_FOVPositionRawSetpointCallback;
   gcRegsDef[FOVPositionSetpointIdx].callback =                                  &GC_FOVPositionSetpointCallback;
   gcRegsDef[FValSizeIdx].callback =                                             &GC_FValSizeCallback;
   gcRegsDef[FWFilterNumberIdx].callback =                                       &GC_FWFilterNumberCallback;
   gcRegsDef[FWModeIdx].callback =                                               &GC_FWModeCallback;
   gcRegsDef[FWPositionIdx].callback =                                           &GC_FWPositionCallback;
   gcRegsDef[FWPositionRawIdx].callback =                                        &GC_FWPositionRawCallback;
   gcRegsDef[FWPositionRawSetpointIdx].callback =                                &GC_FWPositionRawSetpointCallback;
   gcRegsDef[FWPositionSetpointIdx].callback =                                   &GC_FWPositionSetpointCallback;
   gcRegsDef[FWSpeedIdx].callback =                                              &GC_FWSpeedCallback;
   gcRegsDef[FWSpeedMaxIdx].callback =                                           &GC_FWSpeedMaxCallback;
   gcRegsDef[FWSpeedSetpointIdx].callback =                                      &GC_FWSpeedSetpointCallback;
   gcRegsDef[FocusFarFastIdx].callback =                                         &GC_FocusFarFastCallback;
   gcRegsDef[FocusFarSlowIdx].callback =                                         &GC_FocusFarSlowCallback;
   gcRegsDef[FocusNearFastIdx].callback =                                        &GC_FocusNearFastCallback;
   gcRegsDef[FocusNearSlowIdx].callback =                                        &GC_FocusNearSlowCallback;
   gcRegsDef[FocusPositionRawIdx].callback =                                     &GC_FocusPositionRawCallback;
   gcRegsDef[FocusPositionRawMaxIdx].callback =                                  &GC_FocusPositionRawMaxCallback;
   gcRegsDef[FocusPositionRawMinIdx].callback =                                  &GC_FocusPositionRawMinCallback;
   gcRegsDef[FocusPositionRawSetpointIdx].callback =                             &GC_FocusPositionRawSetpointCallback;
   gcRegsDef[GPSAltitudeIdx].callback =                                          &GC_GPSAltitudeCallback;
   gcRegsDef[GPSLatitudeIdx].callback =                                          &GC_GPSLatitudeCallback;
   gcRegsDef[GPSLongitudeIdx].callback =                                         &GC_GPSLongitudeCallback;
   gcRegsDef[GPSModeIndicatorIdx].callback =                                     &GC_GPSModeIndicatorCallback;
   gcRegsDef[GPSNumberOfSatellitesInUseIdx].callback =                           &GC_GPSNumberOfSatellitesInUseCallback;
   gcRegsDef[GevFirstURLIdx].callback =                                          &GC_GevFirstURLCallback;
   gcRegsDef[GevSecondURLIdx].callback =                                         &GC_GevSecondURLCallback;
   gcRegsDef[HFOVIdx].callback =                                                 &GC_HFOVCallback;
   gcRegsDef[HeightIdx].callback =                                               &GC_HeightCallback;
   gcRegsDef[HeightIncIdx].callback =                                            &GC_HeightIncCallback;
   gcRegsDef[HeightMaxIdx].callback =                                            &GC_HeightMaxCallback;
   gcRegsDef[HeightMinIdx].callback =                                            &GC_HeightMinCallback;
   gcRegsDef[ICUPositionIdx].callback =                                          &GC_ICUPositionCallback;
   gcRegsDef[ICUPositionSetpointIdx].callback =                                  &GC_ICUPositionSetpointCallback;
   gcRegsDef[ImageCorrectionIdx].callback =                                      &GC_ImageCorrectionCallback;
   gcRegsDef[ImageCorrectionBlockSelectorIdx].callback =                         &GC_ImageCorrectionBlockSelectorCallback;
   gcRegsDef[ImageCorrectionFWAcquisitionFrameRateIdx].callback =                &GC_ImageCorrectionFWAcquisitionFrameRateCallback;
   gcRegsDef[ImageCorrectionFWAcquisitionFrameRateMaxIdx].callback =             &GC_ImageCorrectionFWAcquisitionFrameRateMaxCallback;
   gcRegsDef[ImageCorrectionFWAcquisitionFrameRateMinIdx].callback =             &GC_ImageCorrectionFWAcquisitionFrameRateMinCallback;
   gcRegsDef[ImageCorrectionFWModeIdx].callback =                                &GC_ImageCorrectionFWModeCallback;
   gcRegsDef[ImageCorrectionModeIdx].callback =                                  &GC_ImageCorrectionModeCallback;
   gcRegsDef[IntegrationModeIdx].callback =                                      &GC_IntegrationModeCallback;
   gcRegsDef[IsActiveFlagsIdx].callback =                                        &GC_IsActiveFlagsCallback;
   gcRegsDef[LoadSavedConfigurationAtStartupIdx].callback =                      &GC_LoadSavedConfigurationAtStartupCallback;
   gcRegsDef[LockedCenterImageIdx].callback =                                    &GC_LockedCenterImageCallback;
   gcRegsDef[ManualFilterSerialNumberIdx].callback =                             &GC_ManualFilterSerialNumberCallback;
   gcRegsDef[MemoryBufferAvailableFreeSpaceHighIdx].callback =                   &GC_MemoryBufferAvailableFreeSpaceHighCallback;
   gcRegsDef[MemoryBufferAvailableFreeSpaceLowIdx].callback =                    &GC_MemoryBufferAvailableFreeSpaceLowCallback;
   gcRegsDef[MemoryBufferFragmentedFreeSpaceHighIdx].callback =                  &GC_MemoryBufferFragmentedFreeSpaceHighCallback;
   gcRegsDef[MemoryBufferFragmentedFreeSpaceLowIdx].callback =                   &GC_MemoryBufferFragmentedFreeSpaceLowCallback;
   gcRegsDef[MemoryBufferLegacyModeIdx].callback =                               &GC_MemoryBufferLegacyModeCallback;
   gcRegsDef[MemoryBufferMOIActivationIdx].callback =                            &GC_MemoryBufferMOIActivationCallback;
   gcRegsDef[MemoryBufferMOISoftwareIdx].callback =                              &GC_MemoryBufferMOISoftwareCallback;
   gcRegsDef[MemoryBufferMOISourceIdx].callback =                                &GC_MemoryBufferMOISourceCallback;
   gcRegsDef[MemoryBufferModeIdx].callback =                                     &GC_MemoryBufferModeCallback;
   gcRegsDef[MemoryBufferNumberOfImagesMaxIdx].callback =                        &GC_MemoryBufferNumberOfImagesMaxCallback;
   gcRegsDef[MemoryBufferNumberOfSequencesIdx].callback =                        &GC_MemoryBufferNumberOfSequencesCallback;
   gcRegsDef[MemoryBufferNumberOfSequencesMaxIdx].callback =                     &GC_MemoryBufferNumberOfSequencesMaxCallback;
   gcRegsDef[MemoryBufferNumberOfSequencesMinIdx].callback =                     &GC_MemoryBufferNumberOfSequencesMinCallback;
   gcRegsDef[MemoryBufferSequenceClearIdx].callback =                            &GC_MemoryBufferSequenceClearCallback;
   gcRegsDef[MemoryBufferSequenceClearAllIdx].callback =                         &GC_MemoryBufferSequenceClearAllCallback;
   gcRegsDef[MemoryBufferSequenceCountIdx].callback =                            &GC_MemoryBufferSequenceCountCallback;
   gcRegsDef[MemoryBufferSequenceDefragIdx].callback =                           &GC_MemoryBufferSequenceDefragCallback;
   gcRegsDef[MemoryBufferSequenceDownloadBitRateMaxIdx].callback =               &GC_MemoryBufferSequenceDownloadBitRateMaxCallback;
   gcRegsDef[MemoryBufferSequenceDownloadFrameCountIdx].callback =               &GC_MemoryBufferSequenceDownloadFrameCountCallback;
   gcRegsDef[MemoryBufferSequenceDownloadFrameIDIdx].callback =                  &GC_MemoryBufferSequenceDownloadFrameIDCallback;
   gcRegsDef[MemoryBufferSequenceDownloadFrameImageCountIdx].callback =          &GC_MemoryBufferSequenceDownloadFrameImageCountCallback;
   gcRegsDef[MemoryBufferSequenceDownloadImageFrameIDIdx].callback =             &GC_MemoryBufferSequenceDownloadImageFrameIDCallback;
   gcRegsDef[MemoryBufferSequenceDownloadModeIdx].callback =                     &GC_MemoryBufferSequenceDownloadModeCallback;
   gcRegsDef[MemoryBufferSequenceDownloadSuggestedFrameImageCountIdx].callback = &GC_MemoryBufferSequenceDownloadSuggestedFrameImageCountCallback;
   gcRegsDef[MemoryBufferSequenceFirstFrameIDIdx].callback =                     &GC_MemoryBufferSequenceFirstFrameIDCallback;
   gcRegsDef[MemoryBufferSequenceHeightIdx].callback =                           &GC_MemoryBufferSequenceHeightCallback;
   gcRegsDef[MemoryBufferSequenceMOIFrameIDIdx].callback =                       &GC_MemoryBufferSequenceMOIFrameIDCallback;
   gcRegsDef[MemoryBufferSequenceOffsetXIdx].callback =                          &GC_MemoryBufferSequenceOffsetXCallback;
   gcRegsDef[MemoryBufferSequenceOffsetYIdx].callback =                          &GC_MemoryBufferSequenceOffsetYCallback;
   gcRegsDef[MemoryBufferSequencePreMOISizeIdx].callback =                       &GC_MemoryBufferSequencePreMOISizeCallback;
   gcRegsDef[MemoryBufferSequenceRecordedSizeIdx].callback =                     &GC_MemoryBufferSequenceRecordedSizeCallback;
   gcRegsDef[MemoryBufferSequenceSelectorIdx].callback =                         &GC_MemoryBufferSequenceSelectorCallback;
   gcRegsDef[MemoryBufferSequenceSizeIdx].callback =                             &GC_MemoryBufferSequenceSizeCallback;
   gcRegsDef[MemoryBufferSequenceSizeIncIdx].callback =                          &GC_MemoryBufferSequenceSizeIncCallback;
   gcRegsDef[MemoryBufferSequenceSizeMaxIdx].callback =                          &GC_MemoryBufferSequenceSizeMaxCallback;
   gcRegsDef[MemoryBufferSequenceSizeMinIdx].callback =                          &GC_MemoryBufferSequenceSizeMinCallback;
   gcRegsDef[MemoryBufferSequenceWidthIdx].callback =                            &GC_MemoryBufferSequenceWidthCallback;
   gcRegsDef[MemoryBufferStatusIdx].callback =                                   &GC_MemoryBufferStatusCallback;
   gcRegsDef[MemoryBufferTotalSpaceHighIdx].callback =                           &GC_MemoryBufferTotalSpaceHighCallback;
   gcRegsDef[MemoryBufferTotalSpaceLowIdx].callback =                            &GC_MemoryBufferTotalSpaceLowCallback;
   gcRegsDef[NDFilterArmedPositionSetpointIdx].callback =                        &GC_NDFilterArmedPositionSetpointCallback;
   gcRegsDef[NDFilterNumberIdx].callback =                                       &GC_NDFilterNumberCallback;
   gcRegsDef[NDFilterPositionIdx].callback =                                     &GC_NDFilterPositionCallback;
   gcRegsDef[NDFilterPositionRawIdx].callback =                                  &GC_NDFilterPositionRawCallback;
   gcRegsDef[NDFilterPositionRawSetpointIdx].callback =                          &GC_NDFilterPositionRawSetpointCallback;
   gcRegsDef[NDFilterPositionSetpointIdx].callback =                             &GC_NDFilterPositionSetpointCallback;
   gcRegsDef[OffsetXIdx].callback =                                              &GC_OffsetXCallback;
   gcRegsDef[OffsetXIncIdx].callback =                                           &GC_OffsetXIncCallback;
   gcRegsDef[OffsetXMaxIdx].callback =                                           &GC_OffsetXMaxCallback;
   gcRegsDef[OffsetXMinIdx].callback =                                           &GC_OffsetXMinCallback;
   gcRegsDef[OffsetYIdx].callback =                                              &GC_OffsetYCallback;
   gcRegsDef[OffsetYIncIdx].callback =                                           &GC_OffsetYIncCallback;
   gcRegsDef[OffsetYMaxIdx].callback =                                           &GC_OffsetYMaxCallback;
   gcRegsDef[OffsetYMinIdx].callback =                                           &GC_OffsetYMinCallback;
   gcRegsDef[POSIXTimeIdx].callback =                                            &GC_POSIXTimeCallback;
   gcRegsDef[PixelDataResolutionIdx].callback =                                  &GC_PixelDataResolutionCallback;
   gcRegsDef[PixelFormatIdx].callback =                                          &GC_PixelFormatCallback;
   gcRegsDef[PowerOnAtStartupIdx].callback =                                     &GC_PowerOnAtStartupCallback;
   gcRegsDef[ProprietaryFeatureIdx].callback =                                   &GC_ProprietaryFeatureCallback;
   gcRegsDef[ReverseXIdx].callback =                                             &GC_ReverseXCallback;
   gcRegsDef[ReverseYIdx].callback =                                             &GC_ReverseYCallback;
   gcRegsDef[SaveConfigurationIdx].callback =                                    &GC_SaveConfigurationCallback;
   gcRegsDef[SensorHeightIdx].callback =                                         &GC_SensorHeightCallback;
   gcRegsDef[SensorIDIdx].callback =                                             &GC_SensorIDCallback;
   gcRegsDef[SensorWellDepthIdx].callback =                                      &GC_SensorWellDepthCallback;
   gcRegsDef[SensorWidthIdx].callback =                                          &GC_SensorWidthCallback;
   gcRegsDef[StealthModeIdx].callback =                                          &GC_StealthModeCallback;
   gcRegsDef[SubSecondTimeIdx].callback =                                        &GC_SubSecondTimeCallback;
   gcRegsDef[TDCFlagsIdx].callback =                                             &GC_TDCFlagsCallback;
   gcRegsDef[TDCFlags2Idx].callback =                                            &GC_TDCFlags2Callback;
   gcRegsDef[TDCStatusIdx].callback =                                            &GC_TDCStatusCallback;
   gcRegsDef[TestImageSelectorIdx].callback =                                    &GC_TestImageSelectorCallback;
   gcRegsDef[TimeSourceIdx].callback =                                           &GC_TimeSourceCallback;
   gcRegsDef[TriggerActivationIdx].callback =                                    &GC_TriggerActivationCallback;
   gcRegsDef[TriggerDelayIdx].callback =                                         &GC_TriggerDelayCallback;
   gcRegsDef[TriggerFrameCountIdx].callback =                                    &GC_TriggerFrameCountCallback;
   gcRegsDef[TriggerModeIdx].callback =                                          &GC_TriggerModeCallback;
   gcRegsDef[TriggerSelectorIdx].callback =                                      &GC_TriggerSelectorCallback;
   gcRegsDef[TriggerSoftwareIdx].callback =                                      &GC_TriggerSoftwareCallback;
   gcRegsDef[TriggerSourceIdx].callback =                                        &GC_TriggerSourceCallback;
   gcRegsDef[VFOVIdx].callback =                                                 &GC_VFOVCallback;
   gcRegsDef[VideoAGCIdx].callback =                                             &GC_VideoAGCCallback;
   gcRegsDef[VideoBadPixelReplacementIdx].callback =                             &GC_VideoBadPixelReplacementCallback;
   gcRegsDef[VideoFreezeIdx].callback =                                          &GC_VideoFreezeCallback;
   gcRegsDef[WidthIdx].callback =                                                &GC_WidthCallback;
   gcRegsDef[WidthIncIdx].callback =                                             &GC_WidthIncCallback;
   gcRegsDef[WidthMaxIdx].callback =                                             &GC_WidthMaxCallback;
   gcRegsDef[WidthMinIdx].callback =                                             &GC_WidthMinCallback;
   gcRegsDef[ZoomInFastIdx].callback =                                           &GC_ZoomInFastCallback;
   gcRegsDef[ZoomInSlowIdx].callback =                                           &GC_ZoomInSlowCallback;
   gcRegsDef[ZoomOutFastIdx].callback =                                          &GC_ZoomOutFastCallback;
   gcRegsDef[ZoomOutSlowIdx].callback =                                          &GC_ZoomOutSlowCallback;
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
      if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         #ifdef SCD_PROXY
            gWaitingForFilterWheel = 1;
         #endif
         FW_CalculateSpeedSetpoint(&gcRegsData);
         SFW_FrameRateChanged(&gcRegsData);
      }
      // Update AcquisitionFrameRate and ExposureTime limits
      GC_UpdateParameterLimits();
      if (!gGC_RegistersStreaming && ((gcRegsData.AcquisitionFrameRate > gcRegsData.AcquisitionFrameRateMax) || (gcRegsData.AcquisitionFrameRate < gcRegsData.AcquisitionFrameRateMin)))
      {
         GC_GenerateEventError(EECD_InvalidFrameRate);
      }
      else
      {
         #ifdef SCD_PROXY
            // We postpone the frame rate change in order to observe the required delay (see acquisition_SM).
            // For FR change during acquisition, ETx change and header update are also postpone after the FR change.
            gFrameRateChangePostponed = 1;
            if (!GC_AcquisitionStarted)
            {
               gFrameRateChangePostponed = 0;
               TRIG_ChangeFrameRate(&gTrig, &gFpaIntf, &gcRegsData);
            }
         #else
            TRIG_ChangeFrameRate(&gTrig, &gFpaIntf, &gcRegsData);
         #endif

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
      if ( gcRegsData.AcquisitionFrameRateSetToMax )
      {
         gcRegsData.AcquisitionFrameRateSetToMax = 0;

         SFW_FrameRateChanged(&gcRegsData);
         GC_UpdateParameterLimits();

         if ( gcRegsData.AcquisitionFrameRate != gcRegsData.AcquisitionFrameRateMax )
         {
            GC_SetAcquisitionFrameRate(gcRegsData.AcquisitionFrameRateMax);
         }
      }
   }
}

/**
 * AcquisitionFrameRateUnrestrictedMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateUnrestrictedMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AcquisitionFrameRateUnrestrictedMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AcquisitionFrameRateUnrestrictedMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (gcRegsData.AcquisitionStart && !GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_OnAcquisitionStart(&gBufManager, &gcRegsData);
      }
   }
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
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (gcRegsData.AcquisitionStop && !GC_ExternalMemoryBufferIsImplemented)
         BufferManager_OnAcquisitionStop(&gBufManager, &gcRegsData);

      BufferManager_HW_MoiHandlerConfig(&gBufManager, 1);
   }
}

/**
 * Autofocus GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AutofocusCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern bool autofocusLaunch;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (!GC_AutofocusIsActive)
      {
         if ((flashSettings.AutofocusModuleType == AMT_SightlineSLA1500) && (gcRegsData.AutofocusMode == AM_Once))
            autofocusLaunch = true;
      }
   }
}

/**
 * AutofocusMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AutofocusModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * AutofocusROI GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_AutofocusROICallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      uint8_t roi = (uint8_t)(gcRegsData.AutofocusROI);
      setLensParams(&theSlCtrl, roi);

      // Update AutofocusROI flash dynamic value
      gFlashDynamicValues.AutofocusROI = gcRegsData.AutofocusROI;

      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         GC_ERR("Failed to update flash dynamic values.");
      }
   }
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
      if (gcRegsData.CalibrationCollectionBlockLoad)
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
      gcRegsData.CalibrationCollectionBlockPOSIXTime =
            gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->info.collection.BlockPOSIXTime[gcRegsData.CalibrationCollectionBlockSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      if (gcRegsData.CalibrationCollectionLoad)
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
      gcRegsData.CalibrationCollectionPOSIXTime = gFM_collections.item[gcRegsData.CalibrationCollectionSelector]->posixTime;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
   static uint32_t prevCalibrationMode;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      // Save actual calibration mode
      prevCalibrationMode = gcRegsData.CalibrationMode;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (gcRegsData.CalibrationMode != prevCalibrationMode)
      {
         if (((gcRegsData.CalibrationMode == CM_Raw0) && (!AvailabilityFlagsTst(Raw0IsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_Raw) && (!AvailabilityFlagsTst(RawIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_NUC) && (!AvailabilityFlagsTst(NUCIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_RT) && (!AvailabilityFlagsTst(RTIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_IBR) && (!AvailabilityFlagsTst(IBRIsAvailableMask))) ||
               ((gcRegsData.CalibrationMode == CM_IBI) && (!AvailabilityFlagsTst(IBIIsAvailableMask))))
         {
            gcRegsData.CalibrationMode = prevCalibrationMode;
         }
         else
         {
            // Update registers related to calibration control
            GC_UpdateCalibrationRegisters();
            GC_UpdateParameterLimits();
            CAL_ApplyCalibBlockSelMode(&gCal, &gcRegsData);
            CAL_WriteBlockParam(&gCal, &gcRegsData);
            Calibration_LoadLUTRQ(0);
            GC_UpdateAECPlusIsAvailable();
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
      GC_UpdateImageLimits();   // must be called first
   }
}

/**
 * ClConfiguration GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ClConfigurationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * DetectorMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DetectorModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Update AcquisitionFrameRate and ExposureTime limits
      GC_UpdateParameterLimits();

      // Update DetectorMode flash dynamic value
      gFlashDynamicValues.DetectorMode = gcRegsData.DetectorMode;

      if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
      {
         GC_ERR("Failed to update flash dynamic values.");
      }
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
      gcRegsData.DeviceClockFrequency = DeviceClockFrequencyAry[gcRegsData.DeviceClockSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      DeviceClockFrequencyAry[gcRegsData.DeviceClockSelector] = gcRegsData.DeviceClockFrequency;
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
      gcRegsData.DeviceCurrent = DeviceCurrentAry[gcRegsData.DeviceCurrentSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      DeviceCurrentAry[gcRegsData.DeviceCurrentSelector] = gcRegsData.DeviceCurrent;
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
 * DeviceDetectorElectricalRefOffset GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceDetectorElectricalRefOffsetCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern float gFpaDetectorElectricalRefOffset;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      gcRegsData.DeviceDetectorElectricalRefOffset = gFpaDetectorElectricalRefOffset;
   }
}

/**
 * DeviceDetectorElectricalTapsRef GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceDetectorElectricalTapsRefCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   extern float gFpaDetectorElectricalTapsRef;

   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      gcRegsData.DeviceDetectorElectricalTapsRef = gFpaDetectorElectricalTapsRef;
   }
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
      gcRegsData.DeviceFirmwareModuleRevision = DeviceFirmwareModuleRevisionAry[gcRegsData.DeviceFirmwareModuleSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      DeviceFirmwareModuleRevisionAry[gcRegsData.DeviceFirmwareModuleSelector] = gcRegsData.DeviceFirmwareModuleRevision;
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
      prevDevicePowerStateSetpoint = gcRegsData.DevicePowerStateSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      if (gcRegsData.DeviceRegistersCheck)
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
      if (gcRegsData.DeviceRegistersStreamingEnd)
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
      if (gcRegsData.DeviceRegistersStreamingStart)
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
      if (gcRegsData.DeviceReset)
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
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      gcRegsData.DeviceSerialPortBaudRate = DeviceSerialPortBaudRateAry[gcRegsData.DeviceSerialPortSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      DeviceSerialPortBaudRateAry[gcRegsData.DeviceSerialPortSelector] = gcRegsData.DeviceSerialPortBaudRate;
   }
}

/**
 * DeviceSerialPortFunction GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_DeviceSerialPortFunctionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_BEFORE) && (access == GCCA_READ))
   {
      gcRegsData.DeviceSerialPortFunction = DeviceSerialPortFunctionAry[gcRegsData.DeviceSerialPortSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if ((gcRegsData.DeviceSerialPortSelector == DSPS_USB) && (gcRegsData.DeviceSerialPortFunction == DSPF_Control))
      {
         // USB serial port cannot be a control port
         // Revert change
         gcRegsData.DeviceSerialPortFunction = DeviceSerialPortFunctionAry[gcRegsData.DeviceSerialPortSelector];
      }
      else if (DeviceSerialPortFunctionAry[gcRegsData.DeviceSerialPortSelector] != gcRegsData.DeviceSerialPortFunction)
      {
         // Device serial port function changed
         DeviceSerialPortFunctionAry[gcRegsData.DeviceSerialPortSelector] = gcRegsData.DeviceSerialPortFunction;
         GC_UpdateDeviceSerialPortFunction(gcRegsData.DeviceSerialPortSelector);
      }
   }
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
      gcRegsData.DeviceTemperature = DeviceTemperatureAry[gcRegsData.DeviceTemperatureSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      DeviceTemperatureAry[gcRegsData.DeviceTemperatureSelector] = gcRegsData.DeviceTemperature;
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
      gcRegsData.DeviceVoltage = DeviceVoltageAry[gcRegsData.DeviceVoltageSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      DeviceVoltageAry[gcRegsData.DeviceVoltageSelector] = gcRegsData.DeviceVoltage;
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
      if (GC_EHDRIIsActive)
      {
         GC_UpdateExposureTimeXRegisters(EHDRIExposureTime, NUM_OF(EHDRIExposureTime), true);
      }
      GC_UpdateParameterLimits();
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
      EHDRI_Reset(&gEHDRIManager, &gcRegsData);
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
      gcRegsData.EventNotification = EventNotificationAry[gcRegsData.EventSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      GC_UpdateExposureTimeMin();

      AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
      AEC_UpdateMode(&gcRegsData, &gAEC_Ctrl);
      HDER_UpdateAECHeader(&gHderInserter, &gcRegsData);

      if (gcRegsData.ExposureAuto == EA_Off)
      {
         // Update Frame Rate limit with the actual exposure times
         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (!GC_FWSynchronouslyRotatingModeIsActive && !GC_EHDRIIsActive)
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
      if (GC_EHDRIIsActive)
      {
         EHDRIExposureTime[0] = gcRegsData.ExposureTime1;
         GC_UpdateParameterLimits();
      }
      else if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[0] = gcRegsData.ExposureTime1;
         SFW_SetExposureTimeArray(0, FWExposureTime[0]);
         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (GC_EHDRIIsActive)
      {
         EHDRIExposureTime[1] = gcRegsData.ExposureTime2;
         GC_UpdateParameterLimits();
      }
      else if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[1] = gcRegsData.ExposureTime2;
         SFW_SetExposureTimeArray(1, FWExposureTime[1]);

         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();

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
      if (GC_EHDRIIsActive)
      {
         EHDRIExposureTime[2] = gcRegsData.ExposureTime3;
         GC_UpdateParameterLimits();
      }
      else if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[2] = gcRegsData.ExposureTime3;
         SFW_SetExposureTimeArray(2, FWExposureTime[2]);

         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (GC_EHDRIIsActive)
      {
         EHDRIExposureTime[3] = gcRegsData.ExposureTime4;
         GC_UpdateParameterLimits();
      }
      else if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[3] = gcRegsData.ExposureTime4;
         SFW_SetExposureTimeArray(3, FWExposureTime[3]);
         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[4] = gcRegsData.ExposureTime5;
         SFW_SetExposureTimeArray(4, FWExposureTime[4]);
         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[5] = gcRegsData.ExposureTime6;
         SFW_SetExposureTimeArray(5, FWExposureTime[5]);

         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[6] = gcRegsData.ExposureTime7;
         SFW_SetExposureTimeArray(6, FWExposureTime[6]);
         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         FWExposureTime[7] = gcRegsData.ExposureTime8;
         SFW_SetExposureTimeArray(7, FWExposureTime[7]);
         SFW_ExposureTimeChanged(&gcRegsData);
         GC_UpdateParameterLimits();
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
      if(gcRegsData.ExposureTimeSetToMax)
      {
         gcRegsData.ExposureTimeSetToMax = 0;

         GC_UpdateExposureTimeRegisters(gcRegsData.ExposureTimeMax);
      }
   }
}

/**
 * ExposureTimeSetToMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ExposureTimeSetToMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if(gcRegsData.ExposureTimeSetToMin)
      {
         gcRegsData.ExposureTimeSetToMin = 0;

         GC_UpdateExposureTimeRegisters(gcRegsData.ExposureTimeMin);
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
      GC_UpdateExternalFanSpeed();
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
 * FOVPosition GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FOVPositionNumber GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionNumberCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FOVPositionRaw GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FOVPositionRawMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionRawMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FOVPositionRawMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionRawMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FOVPositionRawSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Limit setpoint to min/max
      gcRegsData.FOVPositionRawSetpoint = MIN( MAX(gcRegsData.FOVPositionRawSetpoint, gcRegsData.FOVPositionRawMin), gcRegsData.FOVPositionRawMax );

      if ( goManuallyToZoomPos(&theRpCtrl, (uint16_t)(gcRegsData.FOVPositionRawSetpoint)) )
      {
         RPOpt_UpdateRegisters(&theRpCtrl, &gcRegsData);
      }
   }
}

/**
 * FOVPositionSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FOVPositionSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   LensFOV_t LensFOV;

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      LensFOV = RPOpt_ConvertUserFOVtoLensFOV((FOVPositionSetpoint_t)gcRegsData.FOVPositionSetpoint);
      if ( RPOpt_SetLensFOV(&theRpCtrl, LensFOV) )
      {
         gcRegsData.FOVPositionRawSetpoint = (int32_t)RPOpt_ConvertLensFOVtoEncoder(LensFOV);
         RPOpt_UpdateRegisters(&theRpCtrl, &gcRegsData);
      }
   }
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
   static uint32_t prevFWMode;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      prevFWMode = gcRegsData.FWMode;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Exclude invalid modes
      if (((gcRegsData.FWMode == FWM_SynchronouslyRotating) && !GC_FWSynchronouslyRotatingModeIsImplemented) ||
            ((gcRegsData.FWMode == FWM_AsynchronouslyRotating) && !GC_FWAsynchronouslyRotatingModeIsImplemented))
      {
         gcRegsData.FWMode = prevFWMode;
      }
      else
      {
         GC_UpdateFpaPeriodMinMargin();   // must be called first

         CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);
         SFW_UpdateSFWMode(gcRegsData.FWMode);

         if( gcRegsData.FWMode == FWM_Fixed)
         {
            if (FW_getFilterPosition(gcRegsData.FWPositionSetpoint, &counts))
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
            // Make sure CenterImage is set when FW is synchronously rotating
            if (!gcRegsData.CenterImage)
            {
               GC_SetCenterImage(1);
            }

            GC_UpdateExposureTimeXRegisters(FWExposureTime, NUM_OF(FWExposureTime), true);
            FW_CalculateSpeedSetpoint(&gcRegsData);
            SFW_AllChanged(&gcRegsData);
            ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint); // TODO should we set something always valid?
         }

         GC_UpdateParameterLimits();
         GC_UpdateAECPlusIsAvailable();
         CAL_UpdateVideo(&gCal, &gcRegsData);

         if (gcRegsData.FWMode != FWM_Fixed)
            gcRegsData.ImageCorrectionBlockSelector = ICBS_AllBlocks;   //No active block in these modes
      }
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
   static int32_t prevFWPositionRawSetpoint;
   extern int32_t FW_COUNTS_IN_ONE_TURN;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      prevFWPositionRawSetpoint = gcRegsData.FWPositionRawSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (abs(gcRegsData.FWPositionRawSetpoint) < FW_COUNTS_IN_ONE_TURN)
      {
         ChangeFWControllerMode(FW_POSITION_MODE, gcRegsData.FWPositionRawSetpoint);
      }
      else
      {
         gcRegsData.FWPositionRawSetpoint = prevFWPositionRawSetpoint;
      }
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
      prevFWPositionSetpoint = gcRegsData.FWPositionSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (calibrationInfo.isValid && GC_CalibrationCollectionTypeFWIsActive)
         CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);   // Updates FWPositionSetpoint
      else
         GC_UpdateFWPositionSetpoint(prevFWPositionSetpoint, gcRegsData.FWPositionSetpoint);

      GC_UpdateAECPlusIsAvailable();
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
   static uint32_t prevFWSpeedSetpoint;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      prevFWSpeedSetpoint = gcRegsData.FWSpeedSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if ((gcRegsData.FWSpeedSetpoint <= gcRegsData.FWSpeedMax) && GC_FWRotatingModeIsActive)
      {
         ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint);
      }
      else
      {
         gcRegsData.FWSpeedSetpoint = prevFWSpeedSetpoint;
      }
   }
}

/**
 * FocusFarFast GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusFarFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_SetFocusPositionRawSetpoint(gcRegsData.FocusPositionRaw - FOCUS_FAST_STEP);
   }
}

/**
 * FocusFarSlow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusFarSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_SetFocusPositionRawSetpoint(gcRegsData.FocusPositionRaw - FOCUS_SLOW_STEP);
   }
}

/**
 * FocusNearFast GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusNearFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_SetFocusPositionRawSetpoint(gcRegsData.FocusPositionRaw + FOCUS_FAST_STEP);
   }
}

/**
 * FocusNearSlow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusNearSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_SetFocusPositionRawSetpoint(gcRegsData.FocusPositionRaw + FOCUS_SLOW_STEP);
   }
}

/**
 * FocusPositionRaw GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusPositionRawCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FocusPositionRawMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusPositionRawMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FocusPositionRawMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusPositionRawMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * FocusPositionRawSetpoint GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_FocusPositionRawSetpointCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Limit setpoint to min/max
      gcRegsData.FocusPositionRawSetpoint = MIN( MAX(gcRegsData.FocusPositionRawSetpoint, gcRegsData.FocusPositionRawMin), gcRegsData.FocusPositionRawMax );
      //goFastToFocus(&theRpCtrl, (uint16_t)(gcRegsData.FocusPositionRawSetpoint));
      goManuallyToPos(&theRpCtrl, theRpCtrl.currentResponseData.zoomEncValue, gcRegsData.FocusPositionRawSetpoint);
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
 * HFOV GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_HFOVCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
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
      // Add 2 header lines for the NTx-Mini
      gcRegsData.Height += 2;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_READ))
   {
      // Remove 2 header lines (added for the NTx-Mini)
      gcRegsData.Height -= 2;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {

      // Remove 2 header lines (added for the NTx-Mini)
      gcRegsData.Height -= 2;
      GC_UpdateJumboFrameHeight(&gcRegsData, true); // must be called first (may change height)

      GC_UpdateImageLimits();   // must be called first

      SFW_HeightChanged(&gcRegsData);
      GC_UpdateParameterLimits();

      AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
      AEC_UpdateMode(&gcRegsData, &gAEC_Ctrl);

      GC_UpdateFOV();

      // Update Memory Buffer params
      if(!GC_ExternalMemoryBufferIsImplemented)
         BufferManager_UpdateSequenceMaxParameters(&gcRegsData);
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
      ICU_setpointUpdated(&gcRegsData, &gICU_ctrl);
   }
}

/**
 * ImageCorrection GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      startActualization();
   }
}

/**
 * ImageCorrectionBlockSelector GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionBlockSelectorCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ImageCorrectionFWAcquisitionFrameRate GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionFWAcquisitionFrameRateCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ImageCorrectionFWAcquisitionFrameRateMax GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionFWAcquisitionFrameRateMaxCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ImageCorrectionFWAcquisitionFrameRateMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionFWAcquisitionFrameRateMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ImageCorrectionFWMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionFWModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * ImageCorrectionMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ImageCorrectionModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Update AcquisitionFrameRate and ExposureTime limits
      GC_UpdateParameterLimits();
   }
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
 * LoadSavedConfigurationAtStartup GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_LoadSavedConfigurationAtStartupCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_Store_Save();
   }
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
 * MemoryBufferAvailableFreeSpaceHigh GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferAvailableFreeSpaceHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferAvailableFreeSpaceLow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferAvailableFreeSpaceLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferFragmentedFreeSpaceHigh GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferFragmentedFreeSpaceHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferFragmentedFreeSpaceLow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferFragmentedFreeSpaceLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferLegacyMode GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferLegacyModeCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Cette mise-à-jour des paramètres max ne change rien en pratique dans HypIR/VTT puisque le registre est modifié au démarrage.
      // C'est utile pour valider la différence de comportement dans MatLab.
      BufferManager_UpdateSequenceMaxParameters(&gcRegsData);
   }
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
      BufferManager_HW_SetMoiConfig(&gBufManager);
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
      if ((gcRegsData.MemoryBufferMOISoftware == 1) &&
            (gcRegsData.MemoryBufferMOISource == MBMOIS_Software))
      {
         BufferManager_HW_SendSoftwareMoi(&gBufManager);
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
   static uint32_t prevMemoryBufferMOISource;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      prevMemoryBufferMOISource = gcRegsData.MemoryBufferMOISource;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if(!GC_ExternalMemoryBufferIsImplemented && (gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Off) && GC_AcquisitionStarted)
      {
         if((prevMemoryBufferMOISource != MBMOIS_None) && (gcRegsData.MemoryBufferMOISource == MBMOIS_None))
         {
            BufferManager_OnAcquisitionStop(&gBufManager, &gcRegsData);
            GC_SetMemoryBufferStatus(MBS_Holding);
         }
      }

      // Set MOI Config AFTER AcquisitionStop
      // Set MOI Config BEFORE AcquisitionStart
      BufferManager_HW_SetMoiConfig(&gBufManager);

      if(!GC_ExternalMemoryBufferIsImplemented && (gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Off) && GC_AcquisitionStarted)
      {
         if((prevMemoryBufferMOISource == MBMOIS_None) && (gcRegsData.MemoryBufferMOISource != MBMOIS_None))
         {
            BufferManager_OnAcquisitionStart(&gBufManager, &gcRegsData);
         }
      }
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
      BufferManager_HW_SetSwitchConfig(&gBufManager);

      if (gcRegsData.MemoryBufferMode == MBM_Off)
         GC_SetMemoryBufferStatus(MBS_Deactivated);
      else
         GC_SetMemoryBufferStatus(MBS_Idle);
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
   // Obsolete register
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
      if(!GC_ExternalMemoryBufferIsImplemented)
         BufferManager_NumberOfSequencesLimits(&gcRegsData);
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
}

/**
 * MemoryBufferNumberOfSequencesMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferNumberOfSequencesMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferSequenceClear GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceClearCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (gcRegsData.MemoryBufferSequenceClear && !GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_OnSequenceClearSelected(&gcRegsData);
         BufferManager_UpdateSuggestedFrameImageCount(&gcRegsData);
      }
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
      if(gcRegsData.MemoryBufferSequenceClearAll && !GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_OnSequenceClearAll(&gBufManager, &gcRegsData);
      }
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
 * MemoryBufferSequenceDefrag GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDefragCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if(gcRegsData.MemoryBufferSequenceDefrag && !GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_OnDefrag(&gBufManager, &gcRegsData);
         BufferManager_UpdateSuggestedFrameImageCount(&gcRegsData);
      }
   }
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
 * MemoryBufferSequenceDownloadFrameCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadFrameCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if(!GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_SequenceDownloadLimits(&gcRegsData);
         BufferManager_UpdateSuggestedFrameImageCount(&gcRegsData);
      }

   }
}

/**
 * MemoryBufferSequenceDownloadFrameID GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadFrameIDCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if(!GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_SequenceDownloadLimits(&gcRegsData);
         BufferManager_UpdateSuggestedFrameImageCount(&gcRegsData);
      }
   }
}

/**
 * MemoryBufferSequenceDownloadFrameImageCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadFrameImageCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
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
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if(!GC_ExternalMemoryBufferIsImplemented)
      {
         if(BufferManager_SequenceDownloadLimits(&gcRegsData))
         {
            if(BM_MemoryBufferImage)
               BufferManager_OnAcquisitionStart(&gBufManager, &gcRegsData);
         }
      }
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
      BufferManager_HW_SetSwitchConfig(&gBufManager);

      if (gcRegsData.MemoryBufferSequenceDownloadMode != MBSDM_Off)
         MGT_Send_MBSDM(&gMGT, 1);
      else
         MGT_Send_MBSDM(&gMGT, 0);

      if(!GC_ExternalMemoryBufferIsImplemented)
         BufferManager_UpdateSuggestedFrameImageCount(&gcRegsData);

   }
}

/**
 * MemoryBufferSequenceDownloadSuggestedFrameImageCount GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceDownloadSuggestedFrameImageCountCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_UpdateJumboFrameHeight(&gcRegsData, false);
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
}

/**
 * MemoryBufferSequenceHeight GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceHeightCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
}

/**
 * MemoryBufferSequenceOffsetX GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceOffsetXCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferSequenceOffsetY GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceOffsetYCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
      if(!GC_ExternalMemoryBufferIsImplemented)
         BufferManager_SequencePreMOISizeLimits(&gcRegsData);
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
   static uint32_t prevMemoryBufferSequenceSelector;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      prevMemoryBufferSequenceSelector = gcRegsData.MemoryBufferSequenceSelector;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      // Call update function only when selector has changed because it resets download default frame IDs
      if(gcRegsData.MemoryBufferSequenceSelector != prevMemoryBufferSequenceSelector && !GC_ExternalMemoryBufferIsImplemented)
      {
         BufferManager_UpdateSelectedSequenceParameters(&gcRegsData);
         BufferManager_UpdateSuggestedFrameImageCount(&gcRegsData);
      }

   }
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
      if(!GC_ExternalMemoryBufferIsImplemented)
         BufferManager_SequenceSizeLimits(&gcRegsData);
   }
}

/**
 * MemoryBufferSequenceSizeInc GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceSizeIncCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
}

/**
 * MemoryBufferSequenceSizeMin GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceSizeMinCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferSequenceWidth GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferSequenceWidthCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferStatus GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferStatusCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   static uint32_t prevMemoryBufferStatus;

   if ((phase == GCCP_BEFORE) && (access == GCCA_WRITE))
   {
      prevMemoryBufferStatus = gcRegsData.MemoryBufferStatus;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      if (gcRegsData.MemoryBufferStatus == MBS_Refresh)
         gcRegsData.MemoryBufferStatus = prevMemoryBufferStatus;
   }
}

/**
 * MemoryBufferTotalSpaceHigh GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferTotalSpaceHighCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
}

/**
 * MemoryBufferTotalSpaceLow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_MemoryBufferTotalSpaceLowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
      if (gcRegsData.ExposureAuto == EA_ArmedNDFilter)
      {
         GC_UpdateNDFPositionSetpoint(gcRegsData.NDFilterPositionSetpoint, gcRegsData.NDFilterArmedPositionSetpoint);
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
      prevNDFPositionSetpoint = gcRegsData.NDFilterPositionSetpoint;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_UpdateNDFPositionSetpoint(prevNDFPositionSetpoint, gcRegsData.NDFilterPositionSetpoint);
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
      //GC_UpdateImageLimits();   // Offsets have no impact on Offsets
      //GC_UpdateParameterLimits();    // Offsets have no impact on ExpTime and AcqFrameRate
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
      //GC_UpdateImageLimits();   // Offsets have no impact on Offsets
      //GC_UpdateParameterLimits();    // Offsets have no impact on ExpTime and AcqFrameRate
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
      time = TRIG_GetRTC(&gTrig);
      gcRegsData.POSIXTime = time.Seconds;
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      HDER_UpdateReverseYHeader(&gHderInserter, &gcRegsData);
   }
}

/**
 * SaveConfiguration GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_SaveConfigurationCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      GC_Store_Save();
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
 * TDCFlags2 GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_TDCFlags2Callback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
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
      gcRegsData.TriggerActivation = TriggerActivationAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      gcRegsData.TriggerDelay = TriggerDelayAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      gcRegsData.TriggerFrameCount = TriggerFrameCountAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
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
      gcRegsData.TriggerMode = TriggerModeAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      TriggerModeAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerMode;

      // Update TriggerIsActive flags
      triggerIsActiveFlagMask = 0x00000001 << gcRegsData.TriggerSelector;
      if (TriggerModeAry[gcRegsData.TriggerSelector] == TM_On)
      {
         IsActiveFlagsSet(triggerIsActiveFlagMask);
      }
      else
      {
         IsActiveFlagsClr(triggerIsActiveFlagMask);
      }
      // Share new flags value
      GC_SetIsActiveFlags(gcRegsData.IsActiveFlags);

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
      gcRegsData.TriggerSource = TriggerSourceAry[gcRegsData.TriggerSelector];
   }

   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      TriggerSourceAry[gcRegsData.TriggerSelector] = gcRegsData.TriggerSource;
   }
}

/**
 * VFOV GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_VFOVCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
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
      if (gcRegsData.VideoAGC != VAGC_Off)
      {
         GC_SetVideoBadPixelReplacement(1);
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
      GC_UpdateImageLimits();   // must be called first

      SFW_WidthChanged(&gcRegsData);
      GC_UpdateParameterLimits();

      AEC_UpdateImageFraction(&gcRegsData, &gAEC_Ctrl);
      AEC_UpdateMode(&gcRegsData, &gAEC_Ctrl);

      GC_UpdateFOV();

      // Update Memory Buffer params
      if(!GC_ExternalMemoryBufferIsImplemented)
         BufferManager_UpdateSequenceMaxParameters(&gcRegsData);
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

/**
 * ZoomInFast GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ZoomInFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      int32_t newFOVPositionRawSetpoint = RPOpt_CalcZoomNewSetpoint((uint16_t)gcRegsData.FOVPositionRaw, ZoomInFast);
      GC_SetFOVPositionRawSetpoint(newFOVPositionRawSetpoint);
   }
}

/**
 * ZoomInSlow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ZoomInSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      int32_t newFOVPositionRawSetpoint = RPOpt_CalcZoomNewSetpoint((uint16_t)gcRegsData.FOVPositionRaw, ZoomInSlow);
      GC_SetFOVPositionRawSetpoint(newFOVPositionRawSetpoint);
   }
}

/**
 * ZoomOutFast GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ZoomOutFastCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      int32_t newFOVPositionRawSetpoint = RPOpt_CalcZoomNewSetpoint((uint16_t)gcRegsData.FOVPositionRaw, ZoomOutFast);
      GC_SetFOVPositionRawSetpoint(newFOVPositionRawSetpoint);
   }
}

/**
 * ZoomOutSlow GenICam register callback function.
 * 
 * @param phase indicates whether the function is called before or
 *    after the read or write operation.
 * @param access indicates whether the operation is read or write.
 */
void GC_ZoomOutSlowCallback(gcCallbackPhase_t phase, gcCallbackAccess_t access)
{
   if ((phase == GCCP_AFTER) && (access == GCCA_WRITE))
   {
      int32_t newFOVPositionRawSetpoint = RPOpt_CalcZoomNewSetpoint((uint16_t)gcRegsData.FOVPositionRaw, ZoomOutSlow);
      GC_SetFOVPositionRawSetpoint(newFOVPositionRawSetpoint);
   }
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
//      gcRegsData.DeviceTemperatureWarningThresh = DeviceTemperatureWarningThreshAry[gcRegsData.DeviceTemperatureSelector];
//   }
//}
