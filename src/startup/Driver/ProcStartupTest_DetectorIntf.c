/**
 * @file ProcStartupTest_DetectorIntf.c
 * Processing FPGA Startup Tests Detector Interface tests implementation
 *
 * This file implements the Startup Tests Detector interface tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_DetectorIntf.h"
#include "GC_Registers.h"
#include "fpa_intf.h"
#include "power_ctrl.h"

/*
 * Starts FPA init and waits for its result.
 *
 * @return IRC_SUCCESS if FPA init is successful
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_Detector(void) {

   extern t_FpaIntf gFpaIntf;
   t_FpaStatus fpaStatus;
   uint64_t tic_fpaInitTimeout;
   IRC_Status_t status = IRC_NOT_DONE;

   ATR_PRINTF("Connect ADC (EFA-00253-4xx), HiFleG (EFA-00272-001) and Hi-X (EFA-00271-001) boards with these harnesses:");
   ATR_PRINTF("\tADC power harness from ADC_DDC connector on the 252 to ADC board.");
   ATR_PRINTF("\tSamtec 80-pin cable from ADC board to Detector connector (J14) on the 251.");
   ATR_PRINTF("\tSamtec 60-pin cable from FleG board to ADC board.");
   PRINTF("\n");
   ATR_PRINTF("Press ENTER to continue...");
   AutoTest_getUserNULL();

   // Power on ADC and init FPA module
   Power_TurnOn(PC_ADC_DDC);
   FPA_Init(&fpaStatus, &gFpaIntf, &gcRegsData);
   GETTIME(&tic_fpaInitTimeout);

   ATR_PRINTF("Waiting for sensor initialization...");

   while (status == IRC_NOT_DONE)
   {
      AutoTest_RunMinimalStateMachines();

      FPA_GetStatus(&fpaStatus, &gFpaIntf);
      if (BitMaskTst(fpaStatus.fpa_serdes_done, 0xF))
      {
         if (BitMaskTst(fpaStatus.fpa_serdes_success, 0xF))
         {
            ATR_PRINTF("Sensor initialized in %dms.", elapsed_time_us(tic_fpaInitTimeout) / 1000);
            status = IRC_SUCCESS;
         }
         else
         {
            ATR_ERR("Sensor initialization failed.");
            status = IRC_FAILURE;
         }
      }
      else if (elapsed_time_us(tic_fpaInitTimeout) > (10 * TIME_ONE_SECOND_US))
      {
         ATR_ERR("Sensor initialization timeout.");
         status = IRC_FAILURE;
      }
   }

   // Power off ADC
   FPA_PowerDown(&gFpaIntf);
   Power_TurnOff(PC_ADC_DDC);

   return status;
}
