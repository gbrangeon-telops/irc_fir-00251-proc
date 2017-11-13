/**
 * @file ProcStartupTest_VideoOut.c
 * Processing FPGA Startup Video Output Tests implementation
 *
 * This file implements the Startup Video output tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */


#include "ProcStartupTest_VideoOut.h"

#include "GC_Registers.h"
#include "FileManager.h"
#include "Calibration.h"
#include "FlashSettings.h"
#include "XADC.h"
#include "BufferManager.h"
#include "power_ctrl.h"

extern ledCtrl_t gLedCtrl;

/*
 * Enables the State Machines and processes required for CameraLink video output.
 * This test is driven through MATLAB
 *
 * @return IRC_SUCCESS if the test pattern is correctly received through Intellicam
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_CamLinkVideoOut(void) {

   ATR_PRINTF("Using MATLAB, execute the script CLINK_Test_Acq.m and verify that\nthe test pattern is correctly received in Intellicam.");
   ATR_PRINTF("Was this operation successful? (Y/N)\n");


   // We do not use the getUserYN function here, as we need to run additional state machines
   waitingForYN = true;

   while (waitingForYN) {

      AutoTest_RunMinimalStateMachines();

   }

   return (userAns) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * Enables the State Machines and processes required for Pleora video output.
 * This test is driven through GEV Player
 *
 * @return IRC_SUCCESS if the test pattern is correctly received through GEV Player
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_GIGEVideoOut(void) {

   ATR_PRINTF("Using GEV, configure the resolution to 320x256 and framerate to 30Hz\nand start a Dynamic Raw0 test pattern acquisition. Verify that the\ntest pattern is correctly received.");
   ATR_PRINTF("Was this operation successful? (Y/N)\n");


   // We do not use the getUserYN function here, as we need to run additional state machines
   waitingForYN = true;

   while (waitingForYN) {

      AutoTest_RunMinimalStateMachines();

   }

   return (userAns) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * Enables the State Machines and processes required for SDI video output.
 * This test is not driven.
 *
 * @return IRC_SUCCESS if the test pattern is correctly received on the SDI display
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_SDIVideoOut(void) {

   //ATR_PRINTF("Connect the SDI Video monitor to the device."); --> EC
   ATR_PRINTF("Connect the SDI Video monitor to J11.");
   ATR_PRINTF("Is the SDI Test Pattern displayed correctly? (Y/N)\n");


   // We do not use the getUserYN function here, as we need to run additional state machines
   waitingForYN = true;

   while (waitingForYN) {

      AutoTest_RunMinimalStateMachines();

   }

   return (userAns) ? IRC_SUCCESS : IRC_FAILURE;
}

