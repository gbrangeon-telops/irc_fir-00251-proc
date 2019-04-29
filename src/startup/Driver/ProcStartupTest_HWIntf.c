/**
 * @file ProcStartupTest_HWIntf.c
 * Processing FPGA Startup Tests Hardware Interfaces Tests implementation
 *
 * This file implements the Startup Hardware interface tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_HWIntf.h"

#include "ICU.h"
#include "trig_gen.h"
#include "GC_Registers.h"
#include "GC_Callback.h"
#include "mb_axi4l_bridge.h"

#define STARTUP_HW_PROBE_OFFSET                          0xC00
#define HARDWARE_SIG_PROBE_BASEADDR                      TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR + STARTUP_HW_PROBE_OFFSET
#define HARDWARE_SIG_PROBE_RESET                         HARDWARE_SIG_PROBE_BASEADDR + 0x04
#define HARDWARE_SIG_ENCA_MASK                           0x01
#define HARDWARE_SIG_ENCB_MASK                           0x02
#define HARDWARE_SIG_ENC_INDEX_MASK                      0x04
#define HARDWARE_SIG_TRIG_IN_MASK                        0x08
#define NUM_TRIG_TESTS                                   5
#define TRIG_DETECT_TIMEOUT_US                           ONE_SECOND_US
#define SIG_DETECT_TIMEOUT_US                            8 * ONE_SECOND_US
#define SIG_BTN_DEBOUNCE_DELAY                           15000    // 15 ms

#define SIG_PROBE_READ()                                 AXI4L_read32(HARDWARE_SIG_PROBE_BASEADDR)
#define SIG_PROBE_RESET()                                AXI4L_write32(0, HARDWARE_SIG_PROBE_RESET)

static void ButtonDebounce(void);

extern ICU_config_t gICU_ctrl;
extern t_Trig gTrig;

/*
 * Sets the ICU to different waveform generators and queries the user
 * for each waveform conformity
 *
 * @return IRC_SUCCESS if every step completed successfully
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_ICUIntf(void) {

   /*
    * Note: There was a mistake made on the test harness drawing and therefore forward
    * pulses appear as red while reverse pulses appear green; the opposite was intended.
    * User output strings have been reversed to appear as though the correct behavior is
    * witnessed, as green for positive and red for reverse seem more intuitive.
    */

   bool testFailed = false;

   // Saving ICU controller state
   const ICU_config_t memICU_ctrl = gICU_ctrl;

   PRINTF("\n");
   ATR_PRINTF("...............................................");
   ATR_PRINTF("....................WARNING....................");
   ATR_PRINTF("...............................................");
   //ATR_PRINTF("Make sure no motor is connected to J30, as the \nfollowing test risks damaging it.");
   //ATR_PRINTF("Connect ICU Test Harness to J30.\nPress ENTER to continue..."); --> EC
   ATR_PRINTF("Make sure no motor is connected to J28, as the \nfollowing test risks damaging it.");
   ATR_PRINTF("Connect ICU Test Harness to J28.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   // ICU Pulse Generation Test
   // Config 1
   gICU_ctrl.ICU_Mode       = ICU_MODE_REPEAT;
   gICU_ctrl.ICU_Period     = 1000 * ICU_CLK_PER_MS;
   gICU_ctrl.ICU_PulseWidth = 250 * ICU_CLK_PER_MS;
   gICU_ctrl.ICU_CalibPolarity = ICU_POL_REVERSE;
   WriteStruct(&gICU_ctrl);

   // Start ICU (perhaps there is a macro/function for this?)
   AXI4L_write32((uint32_t)1, gICU_ctrl.ADD + ICU_PULSE_CMD_OFFSET);

   ATR_PRINTF("Do you observe a positive (green), 25%% duty cycle, 1Hz wave on the LED indicators? (Y/N) ");
   testFailed = !AutoTest_getUserYN();

   // Config 2
   gICU_ctrl.ICU_Mode       = ICU_MODE_REPEAT;
   gICU_ctrl.ICU_Period     = 200 * ICU_CLK_PER_MS;
   gICU_ctrl.ICU_PulseWidth = 100 * ICU_CLK_PER_MS;
   gICU_ctrl.ICU_CalibPolarity = ICU_POL_REVERSE;
   WriteStruct(&gICU_ctrl);

   ATR_PRINTF("Do you observe a positive (green), 50%% duty cycle, 5Hz wave on the LED indicators? (Y/N) ");
   testFailed = !AutoTest_getUserYN();

   // Config 3
   gICU_ctrl.ICU_Mode       = ICU_MODE_REPEAT;
   gICU_ctrl.ICU_Period     = 2000 * ICU_CLK_PER_MS;
   gICU_ctrl.ICU_PulseWidth = 1500 * ICU_CLK_PER_MS;
   gICU_ctrl.ICU_CalibPolarity = ICU_POL_FORWARD;
   WriteStruct(&gICU_ctrl);

   ATR_PRINTF("Do you observe a negative (red), 75%% duty cycle, 0.5Hz wave on the LED indicators? (Y/N) ");
   testFailed = !AutoTest_getUserYN();

   // Restore ICU controller state, then turn it off.
   gICU_ctrl = memICU_ctrl;
   WriteStruct(&gICU_ctrl);

   ICU_off(&gcRegsData, &gICU_ctrl);

   return (testFailed) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Generates five software trig signal, then reads the hardware signal probe to find the triggers
 *
 * @return IRC_SUCCESS if every trig signal is received correctly
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_TrigIntf(void) {

   uint64_t trig_tic;
   uint64_t timeOnDetection;
   uint8_t i;
   bool trigDetected = false;
   bool timeout = false;

   AutoTest_SaveGCRegisters();

   // Trigger configuration for test purposes
   GC_SetTriggerSelector(TS_AcquisitionStart);
   GC_SetTriggerMode(TM_On);

   gcRegsData.TriggerSource = TS_Software;
   GC_TriggerSourceCallback(GCCP_AFTER, GCCA_WRITE);

   gcRegsData.AcquisitionFrameRateMaxFG = 1200;
   GC_AcquisitionFrameRateMaxFGCallback(GCCP_AFTER, GCCA_WRITE);

   // Reset the Startup_HW_Test module
   SIG_PROBE_RESET();

   //ATR_PRINTF("Connect the Trig Test Harness to J4 and J5.\nPress ENTER to continue...\n");   --> EC
   ATR_PRINTF("Connect the Trig Test Harness to J9 and J10.\nPress ENTER to continue...\n");
   AutoTest_getUserNULL();

   GC_SetAcquisitionStop(0);
   GC_SetAcquisitionStart(1);

   while (!GC_AcquisitionStarted) {
      AutoTest_RunMinimalStateMachines();
   }

   ATR_PRINTF("Sending Software Trigger signals...\n");

   for (i = 1; i <= NUM_TRIG_TESTS; i++) {

      // Reset the Startup_HW_Test module
      SIG_PROBE_RESET();
      trigDetected = false;
      timeout = false;

      GETTIME(&trig_tic);
      TRIG_SendTrigSoft(&gTrig, &gcRegsData);

      while (!trigDetected && !timeout) {

         AutoTest_RunMinimalStateMachines();

         trigDetected = ((SIG_PROBE_READ() & HARDWARE_SIG_TRIG_IN_MASK) == HARDWARE_SIG_TRIG_IN_MASK);

         if (trigDetected) {

            timeOnDetection = elapsed_time_us(trig_tic);
            ATR_INF("Trigger signal %d received after %d us.", i, timeOnDetection);

         }

         if (elapsed_time_us(trig_tic) > TRIG_DETECT_TIMEOUT_US) {

            ATR_INF("Trigger signal %d timed out.", i);
            timeout = true;

         }
      }

      // We pause 100ms here to make sure the system has plenty of time to update internal clock
      while (elapsed_time_us(trig_tic) < (0.1 * ONE_SECOND_US)) {
         AutoTest_RunMinimalStateMachines();
      }
   }

   // Return to idle acquisition state
   GC_SetAcquisitionStart(0);
   GC_SetAcquisitionStop(1);

   PRINT("\n");

   // Wait for acquisition to stop
   while (GC_AcquisitionStarted) {
      AutoTest_RunMinimalStateMachines();
   }

   // Reset the Startup_HW_Test module
   SIG_PROBE_RESET();

   AutoTest_RestoreGCRegisters();

   return (timeout) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Reads the hardware signal probe to detect Filter Wheel encoder signals,
 * while asking the user for each of the 3 target signals in sequence
 *
 * @return IRC_SUCCESS if every input was detected successfully.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_SWFIntf(void) {

   /*
    * SFW Signals enumeration
    */
   enum SFWSignalsEnum {
      ENCA = 0,
      ENCB,
      INDEX,
      SFW_SIG_COUNT
   };

   /*
    * SFW Signals data type
    */
   typedef enum SFWSignalsEnum sigIndex_t;

   /*
    * SFW Signal description data type
    * Forward-declared so SFW_signal_t can contain pointers to itself
    */
   typedef struct SFWSignalsStruct SFW_signal_t;

   /*
    * SFW Signal description structure
    */
   struct SFWSignalsStruct {
      char*          desc;
      uint32_t       mask;
      bool           detected;
      SFW_signal_t   *false1_p;
      SFW_signal_t   *false2_p;
   };

   SFW_signal_t Signal_ENCA  = { "SFW_ENCA", HARDWARE_SIG_ENCA_MASK, false, NULL, NULL };
   SFW_signal_t Signal_ENCB  = { "SFW_ENCB", HARDWARE_SIG_ENCB_MASK, false, NULL, NULL };
   SFW_signal_t Signal_INDEX = { "SFW_INDEX", HARDWARE_SIG_ENC_INDEX_MASK, false, NULL, NULL };

   // Pointer reference initialization
   Signal_ENCA.false1_p = &Signal_ENCB;
   Signal_ENCA.false2_p = &Signal_INDEX;

   Signal_ENCB.false1_p = &Signal_ENCA;
   Signal_ENCB.false2_p = &Signal_INDEX;

   Signal_INDEX.false1_p = &Signal_ENCA;
   Signal_INDEX.false2_p = &Signal_ENCB;

   SFW_signal_t *SFW_SigTable[SFW_SIG_COUNT] = {
         &Signal_ENCA,
         &Signal_ENCB,
         &Signal_INDEX
   };

   SFW_signal_t *testSignal;

   uint32_t signalsRead;
   uint64_t sfw_tic;

   uint32_t signalIndex;

   bool testFailed = false;
   bool timeout;

   /*
    * Test function body
    */
   //ATR_PRINTF("Connect the Filter Wheel Test Harness to J26.\nPress ENTER to continue...");   --> EC
   ATR_PRINTF("Connect the Filter Wheel Test Harness to J25.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   // All signals initially undetected
   SFW_SigTable[ENCA]->detected = false;
   SFW_SigTable[ENCB]->detected = false;
   SFW_SigTable[INDEX]->detected = false;

   for (signalIndex = ENCA; signalIndex < SFW_SIG_COUNT; signalIndex++) {

      // Select test signal structure
      testSignal = SFW_SigTable[signalIndex];

      timeout = false;
      GETTIME(&sfw_tic);

      PRINTF("\n");
      ATR_PRINTF("Press the %s button now.", testSignal->desc);

      while (!testSignal->detected && !timeout) {

         AutoTest_RunMinimalStateMachines();

         SIG_PROBE_RESET();
         signalsRead = SIG_PROBE_READ();

         if ((signalsRead & testSignal->mask) == testSignal->mask) {
            // Target signal detected
            ButtonDebounce();

            if((SIG_PROBE_READ() & testSignal->mask) == testSignal->mask) {
               testSignal->detected = true;
               ATR_PRINTF("Signal %s was detected.", testSignal->desc);
            }
         }

         if (((signalsRead & testSignal->false1_p->mask) == testSignal->false1_p->mask) && !testSignal->false1_p->detected) {
            // False signal 1 newly detected
            ButtonDebounce();

            if ((SIG_PROBE_READ() & testSignal->false1_p->mask) == testSignal->false1_p->mask) {
               ATR_INF("Detected signal %s.", testSignal->false1_p->desc);
               testSignal->false1_p->detected = true;
            }
         }

         if (((signalsRead & testSignal->false2_p->mask) == testSignal->false2_p->mask) && !testSignal->false2_p->detected) {
            // False signal 2 newly detected
            ButtonDebounce();

            if ((SIG_PROBE_READ() & testSignal->false2_p->mask) == testSignal->false2_p->mask) {
               ATR_INF("Detected signal %s.", testSignal->false2_p->desc);
               testSignal->false2_p->detected = true;
            }
         }

         if (((signalsRead & testSignal->false1_p->mask) != testSignal->false1_p->mask) && testSignal->false1_p->detected) {
            // False signal 1 no longer detected
            ButtonDebounce();

            if ((SIG_PROBE_READ() & testSignal->false1_p->mask) != testSignal->false1_p->mask) {
               testSignal->false1_p->detected = false;
            }
         }

         if (((signalsRead & testSignal->false2_p->mask) != testSignal->false2_p->mask) && testSignal->false2_p->detected) {
            // False signal 2 no longer detected
            ButtonDebounce();

            if ((SIG_PROBE_READ() & testSignal->false2_p->mask) != testSignal->false2_p->mask) {
               testSignal->false2_p->detected = false;
            }
         }

         if (elapsed_time_us(sfw_tic) > SIG_DETECT_TIMEOUT_US) {
            timeout = true;
            testFailed = true;
            ATR_ERR("Signal %s was not detected.", testSignal->desc);
         }
      }

   }

   SIG_PROBE_RESET();

   return (testFailed) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Waits for the debounce delay, then resets the signal probe
 */
static void ButtonDebounce(void) {

   uint64_t debounce;

   GETTIME(&debounce);
   while (elapsed_time_us(debounce) < SIG_BTN_DEBOUNCE_DELAY);

   SIG_PROBE_RESET();

   return;
}
