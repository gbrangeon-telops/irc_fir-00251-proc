/**
 * @file ProcStartupTest_utils.c
 * Processing FPGA Startup Test utilities implementation
 *
 * This file implements the Startup Test tools used for various functionality tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 d√©c. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_utils.h"

#include "GC_Registers.h"
#include "GC_Manager.h"
#include "GC_Poller.h"
#include "FileManager.h"
#include "Acquisition.h"
#include "power_ctrl.h"
#include "Led_ctrl.h"
#include "NetworkInterface.h"
#include "CtrlInterface.h"
#include "XADC.h"
#include "DebugTerminal.h"
#include "GC_Callback.h"
#include "Calibration.h"
#include "BufferManager.h"
#include "FlashSettings.h"

extern ledCtrl_t gLedCtrl;
extern netIntf_t gNetworkIntf;
extern ctrlIntf_t gCtrlIntf_FileManager;
extern ctrlIntf_t gCtrlIntf_CameraLink;
extern ctrlIntf_t gCtrlIntf_OutputFPGA;
extern ctrlIntf_t gCtrlIntf_NTxMini;
extern ctrlIntf_t gCtrlIntf_OEM;
extern debugTerminal_t gDebugTerminal;

// Global test control variables
volatile bool isRunningATR = false;
volatile bool waitingForNULL = false;
volatile bool waitingForYN = false;
volatile bool userAns = false;
volatile bool waitingForTI = false;
volatile bool waitingForTR = false;
volatile bool exitUnitaryTests = false;
volatile bool breakBatchMode = false;
volatile IRC_Status_t oTestResult = IRC_NOT_DONE;
volatile int32_t unitaryTestIndex = 0;

// Static Trigger restore point
static bool isRestorePoint = false;
static uint32_t TriggerMode;
static uint32_t TriggerSource;
static uint32_t TriggerActivation;
static float    TriggerDelay;
static uint32_t TriggerFrameCount;
static uint32_t DeviceTimeSource;


/*
 * XADC tests structure
 */
XADC_Test_t XADC_Tests[XADC_CHANNEL_COUNT] =
{
   // Test ID                 Test Description                                               Test Measurement  Test Result
   {VOLTAGE_COOLER,           "XADC -- Cooler Voltage [V]:                           ",       0.0F,             XMR_PENDING},
   {CURRENT_COOLER,           "XADC -- Cooler Current [A]:                           ",       0.0F,             XMR_PENDING},
   {VOLTAGE_24V,              "XADC -- 24V Voltage [V]:                              ",       0.0F,             XMR_PENDING},
   {CURRENT_24V,              "XADC -- 24V Current [A]:                              ",       0.0F,             XMR_PENDING},
   {INTERNAL_LENS_TEMP,       "XADC -- Internal Lens Temperature Voltage [V]:        ",       0.0F,             XMR_PENDING},
   {EXTERNAL_LENS_TEMP,       "XADC -- External Lens Temperature Voltage [V]:        ",       0.0F,             XMR_PENDING},
   {ICU_TEMP,                 "XADC -- ICU Temperature Voltage [V]:                  ",       0.0F,             XMR_PENDING},
   {SFW_TEMP,                 "XADC -- SFW Temperature Voltage [V]:                  ",       0.0F,             XMR_PENDING},
   {COMPRESSOR_TEMP,          "XADC -- Compressor Temperature Voltage [V]:           ",       0.0F,             XMR_PENDING},
   {COLDFINGER_TEMP,          "XADC -- Cold Finger Temperature Voltage [V]:          ",       0.0F,             XMR_PENDING},
   {SPARE_TEMP,               "XADC -- SPARE Temperature Voltage [V]:                ",       0.0F,             XMR_PENDING},
   {EXTERNAL_TEMP,            "XADC -- External Thermistor Temperature Voltage [V]:  ",       0.0F,             XMR_PENDING},
   {VOLTAGE_USB_BUS,          "XADC -- USB Bus Voltage [V]:                          ",       0.0F,             XMR_PENDING},
   {VOLTAGE_USB_1V8,          "XADC -- USB 1.8V Source Voltage [V]:                  ",       0.0F,             XMR_PENDING},
   {VOLTAGE_DDR3_REF,         "XADC -- DDR3 Reference Voltage [V]:                   ",       0.0F,             XMR_PENDING},
   {VOLTAGE_10GIGE,           "XADC -- 10GigE Supply Voltage [V]:                    ",       0.0F,             XMR_PENDING},
   {VOLTAGE_AUX_IO_PROC,      "XADC -- Auxiliary Processing I/O Voltage [V]:         ",       0.0F,             XMR_PENDING},
   {VOLTAGE_AUX_IO_OUT,       "XADC -- Auxiliary Output I/O Voltage [V]:             ",       0.0F,             XMR_PENDING},
   {VOLTAGE_3V3,              "XADC -- 3.3V Supply Voltage [V]:                      ",       0.0F,             XMR_PENDING},
   {VOLTAGE_2V5,              "XADC -- 2.5V Supply Voltage [V]:                      ",       0.0F,             XMR_PENDING},
   {VOLTAGE_1V8,              "XADC -- 1.8V Supply Voltage [V]:                      ",       0.0F,             XMR_PENDING},
   {VOLTAGE_1V5,              "XADC -- 1.5V - 1.35V Supply Voltage [V]:              ",       0.0F,             XMR_PENDING},
   {VOLTAGE_MGT_1V0,          "XADC -- MGT 1.0V Voltage [V]:                         ",       0.0F,             XMR_PENDING},
   {VOLTAGE_MGT_1V2,          "XADC -- MGT 1.2V Voltage [V]:                         ",       0.0F,             XMR_PENDING},
   {VOLTAGE_12V,              "XADC -- 12V Supply Voltage [V]:                       ",       0.0F,             XMR_PENDING},
   {VOLTAGE_5V,               "XADC -- 5V Supply Voltage [V]:                        ",       0.0F,             XMR_PENDING},
   {ADC_REF_1,                "XADC -- ADC Reference 1 Voltage [V]:                  ",       0.0F,             XMR_PENDING},
   {ADC_REF_2,                "XADC -- ADC Reference 2 Voltage [V]:                  ",       0.0F,             XMR_PENDING},
   {ADC_REF_3,                "XADC -- ADC Reference 3 Voltage [V]:                  ",       0.0F,             XMR_PENDING},
   {FPGA_INTERNAL_TEMP,       "XADC -- Internal FPGA Temperature [∞C]:               ",       0.0F,             XMR_PENDING},
   {FPGA_VCCINT,              "XADC -- Internal VCC [V]:                             ",       0.0F,             XMR_PENDING},
   {FPGA_AUX_VCC,             "XADC -- Auxiliary VCC [V]:                            ",       0.0F,             XMR_PENDING},
   {FPGA_VREF_POS,            "XADC -- Reference V+ [V]:                             ",       0.0F,             XMR_PENDING},
   {FPGA_VREF_NEG,            "XADC -- Reference V- [V]:                             ",       0.0F,             XMR_PENDING},
   {FPGA_BRAM,                "XADC -- BRAM Voltage [V]:                             ",       0.0F,             XMR_PENDING}
};

/*
 * Function package which includes every state machine that must be kept alive to
 * minimize timeout errors during tests.
 *
 * @note Every state machine is only run once to allow for inclusion within loops.
 *
 * @return void
 */
void AutoTest_RunMinimalStateMachines(void) {

   GC_Manager_SM();
   GC_Poller_SM();
   File_Manager_SM();
   FlashSettings_SM();
   Acquisition_SM();
   Power_SM();
   Led_ToggleDebugLedState(&gLedCtrl);
   Led_UpdateCameraLedState(&gLedCtrl);
   XADC_SM();
   NetIntf_SM(&gNetworkIntf);
   CtrlIntf_Process(&gCtrlIntf_FileManager);
   CtrlIntf_Process(&gCtrlIntf_CameraLink);
   CtrlIntf_Process(&gCtrlIntf_NTxMini);
#if (OEM_UART_ENABLED)
   CtrlIntf_Process(&gOemCtrlIntf);
#endif
   CtrlIntf_Process(&gCtrlIntf_OutputFPGA);
   DebugTerminal_Process(&gDebugTerminal);

   File_Manager_SM();
   Calibration_SM();
   FlashSettings_SM();
   BufferManager_SM();

   return;
}

/*
 * Sets the waitingForYN global flag, then runs minimal state machines until it is
 * cleared by the user (in Debug Terminal)
 *
 * @return User's input
 */
bool AutoTest_getUserYN(void) {

   waitingForYN = true;

   while (waitingForYN) {
      AutoTest_RunMinimalStateMachines();
   }

   return userAns;
}

/*
 * Sets the waitingForNULL global flag, then runs minimal state machines until it is
 * cleared by the user (in Debug Terminal)
 *
 * @return void
 */
void AutoTest_getUserNULL(void) {

   waitingForNULL = true;

   while (waitingForNULL) {
      AutoTest_RunMinimalStateMachines();
   }

   return;
}

/*
 * Sets the waitingForTI global flag, then runs minimal state machines until it is cleared
 * by the user (in Debug Terminal)
 *
 * @return void
 */
void AutoTest_getUserTI(void) {

   waitingForTI = true;

   while (waitingForTI) {
      AutoTest_RunMinimalStateMachines();
   }

   return;
}

/*
 * Sets the waitingForTR global flag, then runs minimal state machines until it is
 * cleared by the Output FPGA (in Debug Terminal)
 *
 * @return IRC_SUCCESS if the test was successful
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_getOutputTR(void) {

   waitingForTR = true;

   while (waitingForTR) {
      AutoTest_RunMinimalStateMachines();
   }

   return oTestResult;
}

/*
 * Creates a GC Registers restore point for Trigger-related configuration
 */
void AutoTest_SaveGCRegisters(void) {

   TriggerMode          = TriggerModeAry[TS_AcquisitionStart];
   TriggerSource        = TriggerSourceAry[TS_AcquisitionStart];
   TriggerActivation    = TriggerActivationAry[TS_AcquisitionStart];
   TriggerDelay         = TriggerDelayAry[TS_AcquisitionStart];
   TriggerFrameCount    = TriggerFrameCountAry[TS_AcquisitionStart];

   GC_TimeSourceCallback(GCCP_BEFORE, GCCA_READ);
   DeviceTimeSource     = gcRegsData.TimeSource;
   GC_TimeSourceCallback(GCCP_AFTER, GCCA_READ);

   isRestorePoint = true;

}

/*
 * Resets the GC Registers data structure gcRegs to its default value array
 *
 * @return IRC_SUCCESS if the data was restored successfully
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_RestoreGCRegisters(void) {

   if (!isRestorePoint) {
      ATR_ERR("No restore data available.");
      return IRC_FAILURE;
   }

   TriggerModeAry[TS_AcquisitionStart] = TriggerMode;
   TriggerSourceAry[TS_AcquisitionStart] = TriggerSource;
   TriggerActivationAry[TS_AcquisitionStart] = TriggerActivation;
   TriggerDelayAry[TS_AcquisitionStart] = TriggerDelay;
   TriggerFrameCountAry[TS_AcquisitionStart] = TriggerFrameCount;

   GC_RegisterWriteUI32(&gcRegsDef[TimeSourceIdx], DeviceTimeSource);

   return IRC_SUCCESS;
}
