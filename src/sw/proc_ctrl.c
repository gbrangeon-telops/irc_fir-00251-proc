/**
 *  @file proc_ctrl.c
 *  Processing FPGA main() function.
 *  
 *  This file contains the main() function.
 *  
 *  $Rev$
 *  $Author$
 *  $LastChangedDate$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "GC_Registers.h"
#include "BuiltInTests.h"
#include "proc_init.h"
#include "FlashDynamicValues.h"
#include "IRC_Status.h"
#include "Acquisition.h"
#include "led_ctrl.h"
#include "GPS.h"
#include "xil_cache.h"
#include "FileManager.h"
#include "FirmwareUpdater.h"
#include "GC_Manager.h"
#include "GC_Poller.h"
#include "Calibration.h"
#include "FlashSettings.h"
#include "Actualization.h"
#include "XADC_Channels.h"
#include "irigb.h"
#include "FWController.h"
#include "NDFController.h"
#include "icu.h"
#include "TempMonitor.h"
#include "DebugTerminal.h"
#include "hder_inserter.h"
#include "AEC.h"
#include "BufferManager.h"
#include "power_ctrl.h"
#include "printf_utils.h"
#include "CtrlInterface.h"
#include "NetworkInterface.h"
#include "DeviceKey.h"
#include "StackUtils.h"
#include "verbose.h"

#define DEVICE_RUNNING_TIME_REFRESH_PERIOD_US   TIME_ONE_MINUTE_US

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   #include "mb_axi4l_bridge.h" // Used to bridge Microblaze AXI4-Lite transaction
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
#endif

void enable_caches()
{
#ifdef __PPC__
    Xil_ICacheEnableRegion(CACHEABLE_REGION_MASK);
    Xil_DCacheEnableRegion(CACHEABLE_REGION_MASK);
#elif __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheEnable();
#endif
#endif
}

void disable_caches()
{
    Xil_DCacheDisable();
    Xil_ICacheDisable();
}


/*--------------------------------------------------------------------------------------*/
/* main                                                                                 */
/*--------------------------------------------------------------------------------------*/
#ifdef SIM
   sc_port<mb_transactor_task_if> *global_trans_ptr; /*< Pointer to a transactor interface */ 
   void proc_ctrl::main()  // We are now defining the main() function of proc_ctrl (THREAD) for SystemC
#else
   int main()  // Defining the standard main() function 
#endif
{
#ifdef SIM
   global_trans_ptr = &(this->transactor_interface);  // Link the pointer to the SystemC transactor interface
#endif

   extern ledCtrl_t gLedCtrl;
   extern t_GPS Gps_struct;
   extern flashDynamicValues_t gFlashDynamicValues;
   extern ICU_config_t gICU_ctrl;
   extern t_HderInserter gHderInserter;
   extern t_AEC gAEC_Ctrl;
   extern netIntf_t gNetworkIntf;
   extern debugTerminal_t gDebugTerminal;
   extern IRC_Status_t gDebugTerminalStatus;
   extern ctrlIntf_t gCtrlIntf_NTxMini;
   extern ctrlIntf_t gCtrlIntf_OEM;
   extern ctrlIntf_t gCtrlIntf_CameraLink;
   extern ctrlIntf_t gCtrlIntf_OutputFPGA;
   extern ctrlIntf_t gCtrlIntf_FileManager;
   extern FH_ctrl_t gFWFaulhaberCtrl;
   extern FH_ctrl_t gNDFFaulhaberCtrl;
   statistics_t prof_stats;
   uint64_t profiler, profiler2;
   uint64_t tic;

   Stack_ConfigStackViolationException();

   enable_caches();

   Stack_FillRemaining();

   resetStats(&prof_stats);

   gDebugTerminalStatus = Proc_DebugTerminal_InitPhase1();

   FPGA_PRINT("TSIR starting...\n");

#ifdef SIM
   (*global_trans_ptr)->initialize();  // Initialize the SystemC ports
#endif

   BuiltInTest_Execute(BITID_BuiltInTestsVerification);

#ifndef SIM
   BuiltInTest_Execute(BITID_TimerInitialization);
#endif

   WAIT_US(30);

   BuiltInTest_Execute(BITID_InterruptControllerInitialization);
   BuiltInTest_Execute(BITID_FileSystemInitialization);
   BuiltInTest_Execute(BITID_FlashDynamicValuesInitialization);
   BuiltInTest_Execute(BITID_DeviceSerialPortsInitialization);
   if (Proc_DebugTerminal_InitPhase2() != IRC_SUCCESS) gDebugTerminalStatus = IRC_FAILURE;
   BuiltInTest_Execute(BITID_PowerManagerInitialization);
   BuiltInTest_Execute(BITID_LedControllerInitialization);
   BuiltInTest_Execute(BITID_BoardRevisionValidation);
   BuiltInTest_Execute(BITID_NetworkInterfaceInitialization);
   BuiltInTest_Execute(BITID_DebugTerminalInitialization);
   BuiltInTest_Execute(BITID_GenICamManagerInitialization);
   BuiltInTest_Execute(BITID_FlashSettingsManagerInitialization);
   BuiltInTest_Execute(BITID_FileManagerInitialization);
   BuiltInTest_Execute(BITID_QSPIFlashInerfaceInitialization);
   BuiltInTest_Execute(BITID_FirmwareUpdaterInitialization);
   BuiltInTest_Execute(BITID_FANControllerInitialization);
   BuiltInTest_Execute(BITID_SensorControllerInitialization);
   BuiltInTest_Execute(BITID_EHDRIControllerInitialization);
   BuiltInTest_Execute(BITID_ExposureTimeControllerInitialization);
   BuiltInTest_Execute(BITID_TriggerControllerInitialization);
   BuiltInTest_Execute(BITID_GPSInterfaceInitialization);
   BuiltInTest_Execute(BITID_MotorControllerInterfaceInitialization);
   BuiltInTest_Execute(BITID_FWControllerInitialization);
   BuiltInTest_Execute(BITID_NDFControllerInitialization);
   BuiltInTest_Execute(BITID_CalibrationDataFlowInitialization);
   BuiltInTest_Execute(BITID_MGTInterfaceInitialization);
   BuiltInTest_Execute(BITID_ICUControllerInitialization);
   BuiltInTest_Execute(BITID_ADCControllerInitialization);
   BuiltInTest_Execute(BITID_AECControllerInitialization);
   BuiltInTest_Execute(BITID_MemoryBufferControllerInitialization);
   BuiltInTest_Execute(BITID_InterruptControllerStartup);
   BuiltInTest_Execute(BITID_FirmwareReleaseInfoInitialization);
   BuiltInTest_Execute(BITID_DeviceKeyValidation);

   Power_UpdateDeviceLedIndicatorState(&gLedCtrl, 1);

   // Update DevicePowerOncycles
   gFlashDynamicValues.DevicePowerOnCycles++;

   if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
   {
      FPGA_PRINT("Error: Failed to update flash dynamic values.\n");
   }

   TDCStatusClr(WaitingForInitMask);

   GETTIME(&tic);
   GETTIME(&profiler);
   GETTIME(&profiler2);

   // Main loop
   while(1)
   {
      if (elapsed_time_us(tic) > DEVICE_RUNNING_TIME_REFRESH_PERIOD_US)
      {
         GETTIME(&tic);

         FPGA_PRINT("Still Alive\n");

         // Update Device Running Time
         gFlashDynamicValues.DeviceRunningTime += DEVICE_RUNNING_TIME_REFRESH_PERIOD_US / 1000000;

         // Update DeviceCoolerRunningTime according to measured cooler current
         if ((extAdcChannels[XEC_COOLER_CUR].isValid) &&
               (*(extAdcChannels[XEC_COOLER_CUR].p_physical) > COOLER_CURRENT_THRESHOLD_A))
         {
            gFlashDynamicValues.DeviceCoolerRunningTime += DEVICE_RUNNING_TIME_REFRESH_PERIOD_US / 1000000;
         }

         if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
         {
            FPGA_PRINT("Error: Failed to update flash dynamic values.\n");
         }

         // Check for device key expiration
         if ((builtInTests[BITID_DeviceKeyValidation].result == BITR_Passed) &&
               (GC_GetTimestamp() > flashSettings.DeviceKeyExpirationPOSIXTime))
         {
            // Renew device key
            FPGA_PRINT("Error: Device key is expired.\n");
            DeviceKey_Renew(&gFlashDynamicValues, &gcRegsData);
            BuiltInTest_Execute(BITID_DeviceKeyValidation);
         }

         resetStats(&prof_stats);
      }

      GC_Manager_SM();
      GC_Poller_SM();
      File_Manager_SM();
      Firmware_Updater_SM();
      Calibration_SM();
      FlashSettings_SM();
      XADC_SM();
      TempMonitor_SM();
      Acquisition_SM();
      BufferManager_SM();
      DebugTerminal_Process(&gDebugTerminal);
      Power_SM();
      Power_UpdateDeviceLedIndicatorState(&gLedCtrl, 0);
      Led_ToggleDebugLedState(&gLedCtrl);
      Led_UpdateCameraLedState(&gLedCtrl);
      AEC_InterruptProcess(&gcRegsData, &gAEC_Ctrl);
      IRIG_Processing(&gcRegsData);
      Actualization_SM();
      ICU_process(&gcRegsData, &gICU_ctrl, &gHderInserter);
      FW_ControllerProcess();
      NetIntf_SM(&gNetworkIntf);
      CtrlIntf_Process(&gCtrlIntf_FileManager);
      CtrlIntf_Process(&gCtrlIntf_CameraLink);
      CtrlIntf_Process(&gCtrlIntf_NTxMini);
      CtrlIntf_Process(&gCtrlIntf_OEM);
      CtrlIntf_Process(&gCtrlIntf_OutputFPGA);
      NDF_ControllerProcess();
      FH_ProtocolHandler(&gNDFFaulhaberCtrl);
      FH_ProtocolHandler(&gFWFaulhaberCtrl);
      GPS_Process(&Gps_struct);
   }
}
