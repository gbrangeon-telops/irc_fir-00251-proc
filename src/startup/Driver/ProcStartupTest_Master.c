/**
 * @file ProcStartupTest_Master.c
 * Processing FPGA Startup Tests Master Controller implementation
 *
 * This file implements the Startup Tests master controller
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_Master.h"
#include "power_ctrl.h"
#include "xparameters.h"
#include "DebugTerminal.h"
#include "fpa_intf.h"
#include "GC_Callback.h"
#include "xintc.h"

static IRC_Status_t AutoTest_Check(void);
static IRC_Status_t AutoTest_Initialize(void);
static void AutoTest_Execute(autoTestID_t autoTestID);
static IRC_Status_t AutoTest_GetGlobalResult(AutoTest_GlobalResult_t *result);
static void AutoTest_PrintGlobalResult(void);
static void AutoTest_PrintTestMenu(void);
static void AutoTest_RunAllTests(void);
static void AutoTest_RunUnitaryTests(void);
static void AutoTest_GenerateTestReport(void);
static void AutoTest_OutputVerbose(bool verbose);


/*
 * Performs any configuration operations required for all (or a strong majority of) tests.
 *
 * @return IRC_SUCCESS if every operation was completed successfully.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t AutoTest_Initialize(void) {


   /***********************************************************************************
    * VRE: AEC Interrupt Patch: This interrupt is disconnected to prevent Network Interface
    * clogging whenever a Software Trigger signal is sent. This patch should be removed when
    * the referenced issue is solved. (Also remove #include "xparameters.h")
    ***********************************************************************************/
   extern XIntc gProcIntc;
   XIntc_Disconnect(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_SYSTEM_AEC_INTC_0_INTR);

   // Turn OFF Output FPGA verbose
   AutoTest_OutputVerbose(false);

   // Set the AutoTest Running global flag
   isRunningATR = true;

   GC_SetWidth(FPA_WIDTH_MAX);
   GC_SetHeight(FPA_HEIGHT_MAX);
   GC_SetAcquisitionFrameRate(30);

   gcRegsData.CalibrationMode = CM_Raw0;
   GC_CalibrationModeCallback(GCCP_AFTER, GCCA_WRITE);

   PRINTF("\n");
   GC_UnlockCamera();
   PRINTF("\n");


   return IRC_SUCCESS;
}

/*
 * Checks automated tests data structure array.
 *
 * @return IRC_SUCCESS if successfully checked.
 * @return IRC_FAILURE if failed to check.
 */
static IRC_Status_t AutoTest_Check(void) {

   uint32_t i;

   for (i = 0; i < ATID_Count; i++)
   {
      if (autoTests[i].id != i)
      {
         return IRC_FAILURE;
      }
   }

   return IRC_SUCCESS;
}

/*
 * Executes automated test and stores test result in the tests structure.
 *
 * @param autoTest is a pointer to the automated test data structure to execute
 * @return void
 */
static void AutoTest_Execute(autoTestID_t autoTestID) {

   autoTest_t *autoTest = &autoTests[autoTestID];

   if (autoTest == NULL)
   {
      return;
   }

   if (strlen(autoTest->description) > 0)
   {
      ATR_PRINTF("%s", autoTest->description);
   }

   if (autoTest->testFunc != NULL)
   {

      switch(autoTest->testFunc())
      {
         case IRC_NOT_DONE:
            autoTest->result = ATR_PENDING;
            break;

         case IRC_SUCCESS:
            autoTest->result = ATR_PASSED;
            break;

         case IRC_FAILURE:
         default:
            autoTest->result = ATR_FAILED;
      }
   }
   else
   {
      autoTest->result = ATR_FAILED;
   }

   if (strlen(autoTest->description) > 0)
   {
      if (autoTest->result == ATR_PASSED)
      {
         ATR_PRINTF("Test PASS\n");
      }
      else if (autoTest->result == ATR_FAILED)
      {
         ATR_PRINTF("Test FAIL\n");
      }
   }

   return;
}

/*
 * Compiles automated tests global result.
 *
 * @param result is a pointer to the Global Results structure to be written by this function.
 *
 * @return IRC_SUCCESS if the results compilation completed successfully
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t AutoTest_GetGlobalResult(AutoTest_GlobalResult_t *result) {
   uint32_t i;
   uint32_t totalResults = 0;

   if (result == NULL)
   {
      return IRC_FAILURE;
   }

   memset(result, 0, sizeof(AutoTest_GlobalResult_t));

   for (i = ATID_ProcessingCalibrationMemory; i < ATID_Count; i++)
   {
      if (autoTests[i].result == ATR_FAILED)
      {
         result->failed++;
         totalResults++;
      }
      else if (autoTests[i].result == ATR_PENDING)
      {
         result->pending++;
         totalResults++;
      }
      else if (autoTests[i].result == ATR_PASSED)
      {
         result->passed++;
         totalResults++;
      }
      else if (autoTests[i].result == ATR_SKIPPED)
      {
         result->skipped++;
         totalResults++;
      }
   }

   if (totalResults != ATID_Count)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/*
 * Compiles global test results and prints them to the test console.
 *
 * @return void
 */
static void AutoTest_PrintGlobalResult(void) {

   AutoTest_GlobalResult_t results;
   autoTestID_t testIndex;
   char testResultString[10];
   IRC_Status_t status;

   PRINTF("\n\n");

   status = AutoTest_GetGlobalResult(&results);
   if (status != IRC_SUCCESS) {
      ATR_ERR("An error occurred when compiling automated tests results.");
   }

   ATR_PRINTF("Test Result Summary");
   for (testIndex = 0; testIndex < ATID_Count; testIndex++) {

      switch(autoTests[testIndex].result) {
         case ATR_PASSED:
            snprintf(testResultString, sizeof(testResultString), "PASSED");
            break;
         case ATR_FAILED:
            snprintf(testResultString, sizeof(testResultString), "FAILED");
            break;
         case ATR_SKIPPED:
            snprintf(testResultString, sizeof(testResultString), "SKIPPED");
            break;
         case ATR_PENDING:
            snprintf(testResultString, sizeof(testResultString), "PENDING");
            break;
      }

      ATR_PRINTF("%-58s%s", autoTests[testIndex].description, testResultString);
   }

   PRINTF("\n");

   if (results.passed == ATID_Count)
   {
      ATR_PRINTF("ALL tests PASSED\n");
   }
   else
   {
      ATR_PRINTF("Tests PENDING : %2d", results.pending);
      ATR_PRINTF("Tests FAILED  : %2d", results.failed);
      ATR_PRINTF("Tests PASSED  : %2d", results.passed);
   }

   PRINTF("\n");

   return;
}

/*
 * Prints the automated tests menu to the user (for use in unitary test mode)
 *
 * @return void
 */
static void AutoTest_PrintTestMenu(void) {

   autoTestID_t testIndex;

   ATR_PRINTF("Unitary Tests Menu\n");

   for (testIndex = 0; testIndex < ATID_Count; testIndex++) {
      ATR_PRINTF("%2d : %-58s", autoTests[testIndex].id, autoTests[testIndex].description);
   }

   ATR_PRINTF("BM : Run Tests in Batch Mode.");
   ATR_PRINTF("EX : End Unitary Tests\n");
   ATR_PRINTF("Enter your choice using ATR followed by your selection.\n");

   return;
}

/*
 * Runs every test in in the autoTests structure in sequence
 *
 * @return void
 */
static void AutoTest_RunAllTests(void) {

   autoTestID_t testIndex;

   //PRINTF("\n\n");
   ATR_PRINTF("Use ATR BREAK to abort batch mode testing.\n");

   for (testIndex = 0; testIndex < ATID_Count; testIndex++) {

      AutoTest_RunMinimalStateMachines();

      if (breakBatchMode) {
         breakBatchMode = false;
         return;
      }

      AutoTest_Execute(testIndex);
   }

   return;
}

/*
 * Prints the unitary test menu to the console to allow the user to run any test.
 *
 * @return void
 */
static void AutoTest_RunUnitaryTests(void) {

   exitUnitaryTests = false;

   while (!exitUnitaryTests) {

      unitaryTestIndex = -1;

      AutoTest_PrintTestMenu();

      AutoTest_getUserTI();

      if ((unitaryTestIndex < ATID_Count) && !exitUnitaryTests) {
         PRINTF("\n");
         AutoTest_Execute(unitaryTestIndex);
      }
      else if (unitaryTestIndex == ATID_Count && exitUnitaryTests) {
         PRINTF("\n");
         exitUnitaryTests = false;
         ATR_PRINTF("Restarting test suite in batch mode...");
         AutoTest_RunAllTests();
      }
      else if (!exitUnitaryTests) {
         ATR_ERR("Invalid test index.");
      }

   }

   ATR_PRINTF("Exited Unitary Tests");

   return;
}

/*
 * Tells the user to enable console logging, then prints all test results to the console
 * using printing format #testIdx.testResult;args:#
 * Includes a system revisions header for easier tracking.
 *
 * @return void
 */
static void AutoTest_GenerateTestReport(void) {

   autoTestID_t testIdx;
   uint8_t aryIdx;

   char* testResultDesc[4] = {
         "FAIL",
         "SKIP",
         "PASS",
         "PENDING"
   };

   char* XADCResultDesc[4] = {
         "FAIL",
         "NC",
         "PASS",
         "PENDING"
   };

   char* XADC_ChannelDesc[XADC_CHANNEL_COUNT] = {
         "Cooler Voltage",
         "Cooler Current",
         "24V Voltage",
         "24V Current",
         "Internal Lens Temperature",
         "External Lens Temperature",
         "Internal Calibration Unit Temperature",
         "Spectral Filter Wheel Temperature",
         "Compressor Temperature",
         "Cold Finger Temperature",
         "SPARE Temperature",
         "External Thermistor Temperature",
         "USB BUS Voltage",
         "USB 1V8 Voltage",
         "DDR3 Reference Voltage",
         "10GigE Reference Voltage",
         "Processing Auxiliary I/O Voltage",
         "Output Auxiliary I/O Voltage",
         "3V3 Supply Voltage",
         "2V5 Supply Voltage",
         "1V8 Supply Voltage",
         "1V5 Supply Voltage",
         "MGT 1.0V Voltage",
         "MGT 1.2V Voltage",
         "12V Supply Voltage",
         "5V Supply Voltage",
         "FPGA Internal Temperature",
         "FPGA Internal VCC",
         "FPGA Auxiliary VCC",
         "FPGA Positive Reference Voltage",
         "FPGA Negative Reference Voltage",
         "FPGA BRAM Voltage"
   };

   ATR_PRINTF("Enable the console logging function (File -> Log...)\nPress ENTER to continue...\n\n");
   AutoTest_getUserNULL();

   // Print system revisions
   PRINTF("\"Device Version\",\"%s\"\n", gcRegsData.DeviceVersion);    // Firmware version
   PRINTF("\"Processing FPGA Hardware Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGAHardwareRevision]);
   PRINTF("\"Processing FPGA Software Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGASoftwareRevision]);
   PRINTF("\"Processing FPGA Bootloader Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGABootLoaderRevision]);
   PRINTF("\"Processing FPGA Common Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGACommonRevision]);
   PRINTF("\"Output FPGA Hardware Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGAHardwareRevision]);
   PRINTF("\"Output FPGA Software Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGASoftwareRevision]);
   PRINTF("\"Output FPGA Bootloader Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGABootLoaderRevision]);
   PRINTF("\"Output FPGA Common Rev\",\"%d\"\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGACommonRevision]);
   PRINTF("\"XML Version\",\"%d.%d.%d\"\n", gcRegsData.DeviceXMLMajorVersion, gcRegsData.DeviceXMLMinorVersion, gcRegsData.DeviceXMLSubMinorVersion);

   PRINTF("\n\n");

   PRINTF("\"Test Index\",\"Test Description\",\"Test Result\"\n");

   for (testIdx = 0; testIdx < ATID_Count; testIdx++) {
      PRINTF("%d,\"%s\",\"%s\"\n", testIdx, autoTests[testIdx].description, testResultDesc[autoTests[testIdx].result]);
   }

   PRINTF("\n\n");
   PRINTF("\"XADC Measurement Index\",\"XADC Channel\",\"Measurement Value\",\"Measurement Result\"\n");

   for (aryIdx = 0; aryIdx < XADC_MEASUREMENT_END_IDX; aryIdx++) {
      PRINTF("%d,\"%s\",\"" _PCF(3) "\",\"%s\"\n", aryIdx, XADC_ChannelDesc[aryIdx], _FFMT(XADC_Measurement[aryIdx], 3), XADCResultDesc[XADC_Result[aryIdx]]);
   }

   PRINTF("\n\n\n");

   return;
}

/*
 * Initializes the automated tests routine, then calls either automated tests function
 * depending on whether the user wishes to run all tests sequentially (batch mode) or not.
 *
 * @return IRC_FAILURE if there was an error in the tests structure
 * @return IRC_SUCCESS at the end of the test procedure otherwise
 */
IRC_Status_t AutoTest_Routine(void) {

   uint64_t tic;
   uint8_t timeToReset;

   AutoTest_Initialize();

   PRINTF("\n");
   ATR_PRINTF("Checking automated tests structure... ");

   if (AutoTest_Check())
   {
      ATR_ERR("Failed to check automated tests structure\n");
      return IRC_FAILURE;
   }
   PRINTF("passed.\n");

   ATR_PRINTF("Starting Automated Test Routine...\n");

   ATR_PRINTF("Would you like to run all tests in batch mode? (Y/N) ");

   if (AutoTest_getUserYN()) {

      AutoTest_RunAllTests();
      AutoTest_PrintGlobalResult();

      PRINTF("\n");
      ATR_PRINTF("End of test procedure. Enter unitary test mode? (Y/N) ");
      if (AutoTest_getUserYN()) {
         AutoTest_RunUnitaryTests();
      }
   }
   else {
      AutoTest_RunUnitaryTests();
      AutoTest_PrintGlobalResult();
   }

   PRINTF("\n\n");

   ATR_PRINTF("Generate Test Report in Text File? (Y/N) ");
   if (AutoTest_getUserYN()) {
      AutoTest_GenerateTestReport();
   }

   for (timeToReset = 5; timeToReset > 0; timeToReset--) {
      PRINTF("\rRestarting in %d...", timeToReset);
      GETTIME(&tic);
      while (elapsed_time_us(tic) < ONE_SECOND_US) {
         AutoTest_RunMinimalStateMachines();
      }
   }

   PRINTF("\rRestarting now...\n");
   Power_CameraReset();

   return IRC_SUCCESS;
}

/**
 * Sends the VER Debug Terminal command to the Output FPGA to control output text
 *
 * @param verbose controls the output FPGA verbose state. Setting verbose to TRUE enables
 *        output verbose; setting it to FALSE disables it.
 */
static void AutoTest_OutputVerbose(bool verbose) {

   extern debugTerminal_t gDebugTerminal;
   const int arg = (verbose) ? 1 : 0;

   networkCommand_t dtRequest;
   debugTerminal_t *debugTerminal = &gDebugTerminal;

   // VER is the Output Verbose Control command
   const char* const debugTerminalCMD = "VRB";

   F1F2_CommandClear(&dtRequest.f1f2);
   dtRequest.f1f2.isNetwork = 1;
   dtRequest.f1f2.srcAddr = debugTerminal->port.netIntf->address;
   dtRequest.f1f2.srcPort = debugTerminal->port.port;
   dtRequest.f1f2.destAddr = NIA_OUTPUT_FPGA;
   dtRequest.f1f2.destPort = NIP_DEBUG_TERMINAL;
   dtRequest.f1f2.cmd = F1F2_CMD_DEBUG_CMD;

   snprintf(dtRequest.f1f2.payload.debug.text, F1F2_MAX_DEBUG_DATA_SIZE + 1, "%s %d", debugTerminalCMD, arg);

   dtRequest.port = &debugTerminal->port;

   if (NetIntf_EnqueueCmd(debugTerminal->port.netIntf, &dtRequest) != IRC_SUCCESS)
   {
      DT_ERR("Failed to push debug CMD command in network interface command queue");
   }

   return;
}




