/**
 * @file BuiltInTestsDef.c
 * Built-in tests list implementation.
 *
 * This file implements camera Built-in tests list.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "BuiltInTestsdef.h"
#include "BuiltInTests.h"
#include "proc_init.h"
#include "DebugTerminal.h"

builtInTest_t builtInTests[BITID_Count] =
{
   {BITID_BuiltInTestsGlobalResult, "", BuiltInTest_UpdateGlobalResult, BITR_Pending},
   {BITID_BuiltInTestsVerification, "", BuiltInTest_Check, BITR_Pending},
   {BITID_DebugTerminalInitialization, "", DebugTerminal_Init, BITR_Pending},
   {BITID_TimerInitialization, "", Proc_Timer_Init, BITR_Pending},
   {BITID_InterruptControllerInitialization, "Initializing interrupt controller", Proc_Intc_Init, BITR_Pending},
   {BITID_NetworkInterfaceInitialization, "Initializing network interface", Proc_NI_Init, BITR_Pending},
   {BITID_GenICamManagerInitialization, "Initializing GenICam manager", Proc_GC_Init, BITR_Pending},
   {BITID_PowerManagerInitialization, "Initializing power manager", Proc_Power_Init, BITR_Pending},
   {BITID_LedControllerInitialization, "Initializing LEDs controller", Proc_Led_Init, BITR_Pending},
   {BITID_FlashSettingsManagerInitialization, "Initializing flash settings loader", Proc_FlashSettings_Init, BITR_Pending},
   {BITID_FileSystemInitialization, "Initializing file system", Proc_FileSystem_Init, BITR_Pending},
   {BITID_FileManagerInitialization, "Initializing file manager", Proc_FM_Init, BITR_Pending},
   {BITID_QSPIFlashInerfaceInitialization, "Initializing QSPI flash interface", Proc_QSPIFlash_Init, BITR_Pending},
   {BITID_FirmwareUpdaterInitialization, "Initializing firmware updater", Proc_FU_Init, BITR_Pending},
   {BITID_FANControllerInitialization, "Initializing fan controller", Proc_Fan_Init, BITR_Pending},
   {BITID_EHDRIControllerInitialization, "Initializing EHDRI controller", Proc_EHDRI_Init, BITR_Pending},
   {BITID_ExposureTimeControllerInitialization, "Initializing exposure time controller", Proc_EXP_Init, BITR_Pending},
   {BITID_TriggerControllerInitialization, "Initializing trigger controller", Proc_Trigger_Init, BITR_Pending},
   {BITID_GPSInterfaceInitialization, "Initializing GPS interface", Proc_GPS_Init, BITR_Pending},
   {BITID_MotorControllerInterfaceInitialization, "Initializing motor controller interface", Proc_FH_Init, BITR_Pending},
   {BITID_FWControllerInitialization, "Initializing filter wheel controller", Proc_FW_Init, BITR_Pending},
   {BITID_NDFControllerInitialization, "Initializing neutral density filter controller", Proc_NDF_Init, BITR_Pending},
   {BITID_CalibrationDataFlowInitialization, "Initializing calibration data flow", Proc_CAL_Init, BITR_Pending},
   {BITID_MGTInterfaceInitialization, "Initializing MGT interface", Proc_MGT_Init, BITR_Pending},
   {BITID_ICUControllerInitialization, "Initializing ICU controller", Proc_ICU_Init, BITR_Pending},
   {BITID_ADCControllerInitialization, "Initializing ADC controller", Proc_XADC_Init, BITR_Pending},
   {BITID_AECControllerInitialization, "Initializing AEC controller", Proc_AEC_Init, BITR_Pending},
   {BITID_MemoryBufferControllerInitialization, "Initializing memory buffer manager", Proc_BufferManager_Init, BITR_Pending},
   {BITID_FlashDynamicValuesInitialization, "Initializing flash dynamic values", Proc_FlashDynamicValues_Init, BITR_Pending},
   {BITID_InterruptControllerStartup, "Starting interrupt controller", Proc_Intc_Start, BITR_Pending},
   {BITID_FirmwareReleaseInfoInitialization, "Initializing release information", Proc_ReleaseInfo_Init, BITR_Pending},
   {BITID_NetworkHostsReady, "", NULL, BITR_Pending},
   {BITID_NetworkHostsSynchronization, "", NULL, BITR_Pending},
   {BITID_FirmwareRevisionsConsistency, "", NULL, BITR_Pending},
   {BITID_SensorControllerInitialization, "Initializing sensor controller", Proc_Sensor_Init, BITR_Pending},
   {BITID_SensorControllerDetection, "", NULL, BITR_NotApplicable},
   {BITID_CoolerVoltageVerification, "", NULL, BITR_NotApplicable},
   {BITID_CoolerCurrentVerification, "", NULL, BITR_NotApplicable},
   {BITID_Cooldown, "", NULL, BITR_NotApplicable},
   {BITID_ActualizationDataAcquisition, "", NULL, BITR_NotApplicable},
   {BITID_FlashSettingsFileLoading, "", NULL, BITR_NotApplicable},
   {BITID_CalibrationFilesLoading, "", NULL, BITR_NotApplicable}
};
