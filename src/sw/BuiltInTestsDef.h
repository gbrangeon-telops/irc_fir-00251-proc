/**
 * @file BuiltInTestsdef.h
 * Built-in tests list definition header.
 *
 * This file defines the built-in tests list.
 *
 * $Rev: 22650 $
 * $Author: pcouture $
 * $Date: 2018-12-13 15:30:18 -0500 (jeu., 13 déc. 2018) $
 * $Id: BuiltInTestsDef.h 22650 2018-12-13 20:30:18Z pcouture $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/BuiltInTestsDef.h $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef BUILTINTESTSDEF_H
#define BUILTINTESTSDEF_H

/**
 * Built-in test ID.
 */
enum builtInTestIDEnum {
   // Initialization built-in tests
   BITID_BuiltInTestsGlobalResult = 0,
   BITID_BuiltInTestsVerification,
   BITID_DebugTerminalInitialization,
   BITID_TimerInitialization,
   BITID_InterruptControllerInitialization,
   BITID_NetworkInterfaceInitialization,
   BITID_GenICamManagerInitialization,
   BITID_PowerManagerInitialization,
   BITID_LedControllerInitialization,
   BITID_FlashSettingsManagerInitialization,
   BITID_FileSystemInitialization,
   BITID_FileManagerInitialization,
   BITID_QSPIFlashInerfaceInitialization,
   BITID_FirmwareUpdaterInitialization,
   BITID_FANControllerInitialization,
   BITID_EHDRIControllerInitialization,
   BITID_ExposureTimeControllerInitialization,
   BITID_TriggerControllerInitialization,
   BITID_GPSInterfaceInitialization,
   BITID_MotorControllerInterfaceInitialization,
   BITID_FWControllerInitialization,
   BITID_NDFControllerInitialization,
   BITID_CalibrationDataFlowInitialization,
   BITID_MGTInterfaceInitialization,
   BITID_ICUControllerInitialization,
   BITID_ADCControllerInitialization,
   BITID_AECControllerInitialization,
   BITID_MemoryBufferControllerInitialization,
   BITID_FlashDynamicValuesInitialization,
   BITID_InterruptControllerStartup,
   BITID_FirmwareReleaseInfoInitialization,
   BITID_NetworkHostsReady,
   BITID_NetworkHostsSynchronization,
   BITID_FirmwareRevisionsConsistency,
   BITID_SensorControllerInitialization,
   BITID_SensorControllerDetection,
   BITID_CoolerVoltageVerification,
   BITID_CoolerCurrentVerification,
   BITID_Cooldown,
   BITID_ActualizationDataAcquisition,
   BITID_FlashSettingsFileLoading,
   BITID_CalibrationFilesLoading,
   BITID_DeviceKeyValidation,
   BITID_SensorInitialization,
   BITID_DeviceSerialPortsInitialization,
   BITID_BoardRevisionValidation,
   BITID_MotorizedLensInitialization,
   BITID_AutofocusModuleInitialization,

   // When a built-in test is added to this list, the following tools must be updated:
   //    - tsirinfo
   //    - IRCAM_TEL2000\Test\DeviceBuiltInTests\ParseDeviceBuiltInTestsResults.m (called in TSIRDiag)

   // Built-in test count
   BITID_Count
};

#endif // BUILTINTESTSDEF_H

