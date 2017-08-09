/**
 * @file ProcStartupTest_Memory.c
 * Processing FPGA Startup Memory Tests implementation
 *
 * This file implements the Startup memory tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_Memory.h"
#include "Startup_TestMem.h"

#include "xparameters.h"
#include "xintc.h"
#include "GC_Poller.h"
#include "NetworkInterface.h"
#include "DebugTerminal.h"
#include "CircularByteBuffer.h"
#include "CtrlInterface.h"
#include "Protocol_F1F2.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "FileManager.h"
#include "UART_Utils.h"

#define PROCESSING_CALIBRATION_MEMORY_SIZE         (uint32_t)((XPAR_MIG_CALIBRATION_CAL_DDR_MIG_HIGHADDR - XPAR_MIG_CALIBRATION_CAL_DDR_MIG_BASEADDR + 1) / 4)
#define PROCESSING_CALIBRATION_MEMORY_BASEADDR     (uint32_t)XPAR_MIG_CALIBRATION_CAL_DDR_MIG_BASEADDR
#define FLASH_TEST_CIRCULAR_BUFFER_SIZE            128

extern debugTerminal_t gDebugTerminal;
extern ctrlIntf_t gCtrlIntf_NTxMini;
extern XIntc gProcIntc;


/*
 * Runs the predefined memory test suite XIL_TESTMEM_ALLMEMTESTS on the
 * Processing Calibration memory range and outputs test result at every step
 *
 * @return IRC_SUCCESS if all memory tests were successful
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_ProcCalibMem(void) {

   IRC_Status_t testResult;

   GC_Poller_Stop();
   XIntc_Disable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);

   while (GC_Poller_IsActive()) {
      AutoTest_RunMinimalStateMachines();
   }

   testResult = Startup_TestMem(PROCESSING_CALIBRATION_MEMORY_BASEADDR, PROCESSING_CALIBRATION_MEMORY_SIZE);

   GC_Poller_Start();
   CBB_Flush(gCtrlIntf_NTxMini.rxCircBuffer);
   UART_ResetRxFifo(&((circularUART_t *)gCtrlIntf_NTxMini.p_link)->uart);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);

   return testResult;
}

/*
 * Sends a network command to the Output FPGA to run the predefined memory test suite
 * XIL_TESTMEM_ALLMEMTESTS on the Output Buffer, then waits for test result from the Output
 * FPGA.
 *
 * @return IRC_SUCCESS if all memory tests were successful
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_OBufMem(void) {

   networkCommand_t dtRequest;
   debugTerminal_t *debugTerminal = &gDebugTerminal;
   IRC_Status_t testResult = IRC_NOT_DONE;

   // Disable modules which cause excessive Output FPGA interrupts during buffer memory test
   GC_Poller_Stop();
   XIntc_Disable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);

   while (GC_Poller_IsActive()) {
      AutoTest_RunMinimalStateMachines();
   }

   // TOB is the Output Buffer Memory Test command
   const char* debugTerminalCMD = "TOB";

   F1F2_CommandClear(&dtRequest.f1f2);
   dtRequest.f1f2.isNetwork = 1;
   dtRequest.f1f2.srcAddr = debugTerminal->port.netIntf->address;
   dtRequest.f1f2.srcPort = debugTerminal->port.port;
   dtRequest.f1f2.destAddr = NIA_OUTPUT_FPGA;
   dtRequest.f1f2.destPort = NIP_DEBUG_TERMINAL;
   dtRequest.f1f2.cmd = F1F2_CMD_DEBUG_CMD;

   snprintf(dtRequest.f1f2.payload.debug.text, F1F2_MAX_DEBUG_DATA_SIZE + 1, debugTerminalCMD);

   dtRequest.port = &debugTerminal->port;

   if (NetIntf_EnqueueCmd(debugTerminal->port.netIntf, &dtRequest) != IRC_SUCCESS)
   {
      DT_ERR("Failed to push debug CMD command in network interface command queue");
      return IRC_FAILURE;
   }

   testResult = AutoTest_getOutputTR();

   // Re-enable disabled modules
   GC_Poller_Start();
   CBB_Flush(gCtrlIntf_NTxMini.rxCircBuffer);
   UART_ResetRxFifo(&((circularUART_t *)gCtrlIntf_NTxMini.p_link)->uart);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);

   return testResult;
}

/*
 * Calls the Debug Terminal function DebugTerminalParseFRW()
 *
 * @note cbuf is a circular buffer of size 128, as per DebugTerminal.c
 *
 * @return IRC_SUCCESS if the test function completed successfully
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_FlashMem(void) {

   circByteBuffer_t cbuf;
   uint8_t flashTestBuffer[FLASH_TEST_CIRCULAR_BUFFER_SIZE];

   GC_Poller_Stop();
   XIntc_Disable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);

   while (GC_Poller_IsActive()) {
      AutoTest_RunMinimalStateMachines();
   }

   CBB_Init(&cbuf, flashTestBuffer, FLASH_TEST_CIRCULAR_BUFFER_SIZE);

   // Test code taken from static function DebugTerminalParseFRW(circByteBuffer_t *cbuf)
   int fd;
   char testfilename[] = FM_UFFS_MOUNT_POINT"TelopsFlashTest.bin";
   struct uffs_stat filestat;
   const uint32_t fileSize = 1024 * 1024;
   uint32_t counter;
   uint32_t counterMax;
   uint32_t data;
   uint32_t progressStep;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(&cbuf))
   {
      ATR_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   PRINTF("\nPerforming flash read and write test...");

   counterMax = fileSize / sizeof(counter); // 1 MB
   progressStep = counterMax / 50;

   PRINTF("\n");
   ATR_PRINTF("Writing flash test file");
   fd = uffs_open(testfilename, UO_WRONLY | UO_CREATE | UO_TRUNC);
   if (fd == -1)
   {
      ATR_ERR("Failed to open %s for writing.", testfilename);
      return IRC_FAILURE;
   }

   for (counter = 0; counter < counterMax;  counter++)
   {
      if (uffs_write(fd, &counter, sizeof(counter)) != sizeof(counter))
      {
         ATR_ERR("File write failed (counter = %d).", counter);
         return IRC_FAILURE;
      }
      if (counter % progressStep == 0) PRINT(".");
   }

   if (uffs_close(fd) == -1)
   {
      ATR_ERR("Failed to close %s.", testfilename);
      return IRC_FAILURE;
   }

   ATR_PRINTF("Flash test file writing succeeded.");

   ATR_PRINTF("Reading flash test file size...");
   if (uffs_stat(testfilename, &filestat) == -1)
   {
      ATR_ERR("Failed to get file stat.");
      return IRC_FAILURE;
   }

   ATR_INF("Flash test file size is %d bytes.", filestat.st_size);

   if (filestat.st_size != fileSize)
   {
      ATR_ERR("Flash test file size mismatch.");
      return IRC_FAILURE;
   }

   ATR_PRINTF("Reading flash test file");
   fd = uffs_open(testfilename, UO_RDONLY);
   if (fd == -1)
   {
      ATR_ERR("Failed to open %s for reading.", testfilename);
      return IRC_FAILURE;
   }

   for (counter = 0; counter < counterMax;  counter++)
   {
      if (uffs_read(fd, &data, sizeof(data)) != sizeof(data))
      {
         ATR_ERR("File read failed (counter = %d).", counter);
         return IRC_FAILURE;
      }

      if (data != counter)
      {
         ATR_ERR("Data mismatch (counter = %d).", counter);
         return IRC_FAILURE;
      }
      if (counter % progressStep == 0) PRINT(".");
   }
   PRINT("\n");

   if (uffs_close(fd) == -1)
   {
      ATR_ERR("Failed to close %s.", testfilename);
      return IRC_FAILURE;
   }

   ATR_PRINTF("Flash test file reading succeeded.");

   ATR_PRINTF("Removing flash test file...");
   if (uffs_remove(testfilename) == -1)
   {
      ATR_ERR("Failed to remove %s.", testfilename);
      return IRC_FAILURE;
   }

   ATR_PRINTF("Removing flash test file succeeded.");

   ATR_PRINTF("Flash read and write test succeeded.");
   // End DebugTerminalParseFRW()

   GC_Poller_Start();
   CBB_Flush(gCtrlIntf_NTxMini.rxCircBuffer);
   UART_ResetRxFifo(&((circularUART_t *)gCtrlIntf_NTxMini.p_link)->uart);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);

   return IRC_SUCCESS;
}
