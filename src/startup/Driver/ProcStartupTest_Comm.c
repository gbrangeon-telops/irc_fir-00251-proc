/**
 * @file ProcStartupTest_Comm.c
 * Processing FPGA Startup Communication Tests implementation
 *
 * This file implements the Startup communication tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_Comm.h"

#include "GC_Registers.h"
#include "UART_utils.h"
#include "ctrlInterface.h"
#include "xuartns550.h"
#include "xparameters.h"
#include "xintc.h"

#define TEST_UART_TIMEOUT_US                             5  * ONE_SECOND_US
#define TEST_UART_BUFFER_SIZE                            128
#define TEST_UART_BAUD_RATE                              9600
#define TEST_UART_DATA_BITS                              8
#define TEST_UART_PARITY                                 'N'
#define TEST_UART_STOP_BITS                              1
#define OEM_UART_DEVICE_ID                               XPAR_OEM_UART_DEVICE_ID
#define OEM_UART_INTR_ID                                 XPAR_MCU_MICROBLAZE_1_AXI_INTC_OEM_UART_IP2INTC_IRPT_INTR
#define FW_UART_DEVICE_ID                                XPAR_FW_UART_DEVICE_ID
#define FW_UART_INTR_ID                                  XPAR_MCU_MICROBLAZE_1_AXI_INTC_FW_UART_IP2INTC_IRPT_INTR
#define NDF_UART_DEVICE_ID                               XPAR_AXI_NDF_UART_DEVICE_ID
#define NDF_UART_INTR_ID                                 XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_NDF_UART_IP2INTC_IRPT_INTR
#define NUM_UART_TEST_DEVICES                            3



/*
 * UART Device selector enumeration
 */
enum testedUARTDevicesEnum {
   OEM,
   FILTER_WHEEL,
   COOLER,
   TEST_UART_COUNT
};

/*
 * UART Device selector data type
 */
typedef enum testedUARTDevicesEnum tstUARTDevice_t;

/*
 * Minimalist UART data structure
 */
struct testUartStruct {
   tstUARTDevice_t   sel;
   uint32_t          id;
   uint32_t          intr_id;
   XUartNs550        uart;
   uint8_t           rxDataBuffer[TEST_UART_BUFFER_SIZE];
   uint8_t           txDataBuffer[TEST_UART_BUFFER_SIZE];
};

/*
 * Minimalist UART data type
 */
typedef struct testUartStruct testUart_t;

/*
 * UART Device description strings
 */
static char* Startup_UARTDeviceDesc[NUM_UART_TEST_DEVICES] = {
      "OEM",
      "Filter Wheel",
      "Cooler"
};

/*
 * Private test functions
 */
static IRC_Status_t Startup_TestUARTDevice(tstUARTDevice_t testUARTSelector);
static void Test_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData);

/*
 * Global variables
 */
extern XIntc gProcIntc;
extern ctrlIntf_t gCtrlIntf_FileManager;

/*
 * Displays the XML Major, Minor and Subminor versions and asks the user whether
 * the data read from MATLAB and displayed on the console are the same.
 *
 * @return IRC_SUCCESS if data read from MATLAB is the same.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_CLINK_UART(void) {

   ATR_PRINTF("Connect the CLINK cables to the test card.\nPress ENTER to continue...");

   AutoTest_getUserNULL();

   PRINTF("\n");
   ATR_PRINTF("Run the CLINK_Read_XML.m MATLAB script.");
   ATR_PRINTF("XML version: %d.%d.%d\n", gcRegsData.DeviceXMLMajorVersion, gcRegsData.DeviceXMLMinorVersion, gcRegsData.DeviceXMLSubMinorVersion);
   ATR_PRINTF("Is this result identical to data read from MATLAB? (Y/N) ");

   /*
    * The AutoTest_getUserYN function contains a loop which executes all the necessary
    * state machines for proper CLINK communication with MATLAB.
    */
   return (AutoTest_getUserYN()) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * Calls the Startup_TestUARTDevice function upon the OEM UART Device
 *
 * @return Startup_TestUARTDevice
 */
IRC_Status_t AutoTest_OEM_UART(void) {

   /**
    * Test Harness query
    */
   ATR_PRINTF("Connect the UART Test Harness to J23.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   return Startup_TestUARTDevice(OEM);
}

/*
 * Displays the XML Major, Minor and Subminor versions.
 *
 * @return IRC_SUCCESS if data read from GEV Player is the same.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_GIGE_UART(void) {

   ATR_PRINTF("Connect the Ethernet cable to the NTX-Mini module.\nPress ENTER to continue...");

   AutoTest_getUserNULL();

   ATR_PRINTF("XML version: %d.%d.%d\n", gcRegsData.DeviceXMLMajorVersion, gcRegsData.DeviceXMLMinorVersion, gcRegsData.DeviceXMLSubMinorVersion);
   ATR_PRINTF("Is this result identical to data read from GEV Player? (Y/N) ");

   /*
    * The AutoTest_getUserYN function contains a loop which executes all the necessary
    * state machines for proper GigE communication with GEV Player
    */
   return (AutoTest_getUserYN()) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * No test required
 *
 * @note This test is empty because the whole test suite interface relies
 *       on proper USB UART behavior. Therefore, simply using this test
 *       system certifies that the USB UART module is functional and does
 *       not require additional testing
 *
 * @return IRC_SUCCESS
 */
IRC_Status_t AutoTest_USB_UART(void) {

   ATR_INF("This functionality is tested through the use of this test program.");
   return IRC_SUCCESS;
}

/*
 * Calls the Startup_TestUARTDevice function upon the Filter Wheel UART Device
 *
 * @return Startup_TestUARTDevice
 */
IRC_Status_t AutoTest_FilterWheel_UART(void) {

   /**
    * Test Harness query
    */
   ATR_PRINTF("Connect the Filter Wheel Test Harness to J26.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   return Startup_TestUARTDevice(FILTER_WHEEL);
}

/*
 * Calls the Startup_TestUARTDevice function upon the COOLER UART Device
 *
 * @return Startup_TestUARTDevice
 */
IRC_Status_t AutoTest_Cooler_UART(void) {

   /**
    * Test Harness query
    */
   ATR_PRINTF("Connect the Cooler Test Harness to J14.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   return Startup_TestUARTDevice(COOLER);
}

/*
 * Tells the user to send 10 packets of 256 bytes in loopback mode using the
 * t2kfmtb.exe application
 *
 * @return IRC_SUCCESS if this operation was successful.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_USARTLoopback(void) {

   bool testFailed = false;

   ((usart_t *)gCtrlIntf_FileManager.p_link)->loopback = 1;

   ATR_PRINTF("Run USART_Packet_Transfer.bat.");
   ATR_PRINTF("Was the test successful? (Y/N) ");

   testFailed = AutoTest_getUserYN();

   ((usart_t *)gCtrlIntf_FileManager.p_link)->loopback = 0;

   return (testFailed) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * Tells the user to load the default flash settings and unitary calibration files
 * into the FPGA using t2kfmtb.exe
 *
 * @return IRC_SUCCESS if this operation was successful.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_USARTFileTx(void) {

   ATR_PRINTF("Run USART_File_Transfer.bat.");
   ATR_PRINTF("Was the file transfer successful? (Y/N)\n\n");

   /*
    * The AutoTest_getUserYN function contains a loop which executes all the necessary
    * state machines for proper OEM communication with MATLAB
    */
   return (AutoTest_getUserYN()) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * Startup universal UART Test function used for OEM, Filter Wheel and Cooler UART devices
 * Sends a test string through the selected device and reads it back.
 *
 * @param testUARTSelector is a member of the testUARTDevices enumeration used to identify to UART
 *        device to be tested
 *
 * @return IRC_SUCCESS if the string received is identical to the one which was sent
 * @return IRC_FAILURE otherwise
 */
static IRC_Status_t Startup_TestUARTDevice(tstUARTDevice_t testUARTSelector) {

   bool stringsEqual = false;
   uint64_t UART_tic;

   /**
    * Test UART Initialization
    */
   testUart_t  testUART;
   IRC_Status_t status;

   testUART.sel = testUARTSelector;

   switch (testUARTSelector) {
      case OEM:
         testUART.id       = OEM_UART_DEVICE_ID;
         testUART.intr_id  = OEM_UART_INTR_ID;
         break;
      case FILTER_WHEEL:
         testUART.id       = FW_UART_DEVICE_ID;
         testUART.intr_id  = FW_UART_INTR_ID;
         break;
      case COOLER:
         testUART.id       = NDF_UART_DEVICE_ID;
         testUART.intr_id  = NDF_UART_INTR_ID;
         break;
      default:
         ATR_ERR("Invalid UART Device Selector.");
   }

   status = UART_Init(&testUART.uart,
         testUART.id,
         &gProcIntc,
         testUART.intr_id,
         Test_UART_IntrHandler,
         &testUART);
   if (status != IRC_SUCCESS) {
      ATR_ERR("Failed to initialize %s UART.", Startup_UARTDeviceDesc[testUART.sel]);
      return IRC_FAILURE;
   }
   ATR_DBG("Initialized %s UART.", Startup_UARTDeviceDesc[testUARTSelector]);

   status = UART_Config(&testUART.uart,
         TEST_UART_BAUD_RATE,
         TEST_UART_DATA_BITS,
         TEST_UART_PARITY,
         TEST_UART_STOP_BITS);
   if (status != IRC_SUCCESS) {
      ATR_ERR("Failed to configure %s UART.", Startup_UARTDeviceDesc[testUART.sel]);
      return IRC_FAILURE;
   }
   ATR_DBG("Configured %s UART.", Startup_UARTDeviceDesc[testUART.sel]);

   status = UART_ResetRxFifo(&testUART.uart);
   if (status != IRC_SUCCESS) {
      ATR_ERR("Failed to reset %s UART RX FIFO.", Startup_UARTDeviceDesc[testUART.sel]);
      return IRC_FAILURE;
   }
   ATR_DBG("Reset %s UART RX FIFO.", Startup_UARTDeviceDesc[testUART.sel]);
   XUartNs550_SetFifoThreshold(&testUART.uart, XUN_FIFO_TRIGGER_04);

   XIntc_Enable(&gProcIntc, testUART.intr_id);
   ATR_DBG("Enabled %s UART Interrupts.", Startup_UARTDeviceDesc[testUART.sel]);

   /**
    * Filter Wheel UART Test Procedure
    */
   const char* const testString = "This is the test string used to validate the UART device functionality.";
   const uint8_t testString_length = strlen(testString) + 1;   // +1 to include terminating NULL character (required for strcmp later)

   ATR_INF("%s\n", testString);
   ATR_PRINTF("Beginning %s UART Loopback transfer...", Startup_UARTDeviceDesc[testUART.sel]);

   snprintf((char *)testUART.txDataBuffer, TEST_UART_BUFFER_SIZE, testString);

   XUartNs550_Recv(&testUART.uart, (uint8_t *)testUART.rxDataBuffer, testString_length);
   XUartNs550_Send(&testUART.uart, (uint8_t *)testUART.txDataBuffer, testString_length);

   GETTIME(&UART_tic);

   do {

      AutoTest_RunMinimalStateMachines();
      stringsEqual = (strcmp((char *) testUART.rxDataBuffer, (char *)testUART.txDataBuffer) == 0);

   } while (!stringsEqual && elapsed_time_us(UART_tic) < TEST_UART_TIMEOUT_US);

   if (elapsed_time_us(UART_tic) > TEST_UART_TIMEOUT_US) {
      ATR_ERR("%s UART Timeout: Did not receive test string.", Startup_UARTDeviceDesc[testUART.sel]);
   }
   else
   {
      ATR_PRINTF("Integral test string received.");
   }

   XIntc_Disable(&gProcIntc, testUART.intr_id);

   return (stringsEqual) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * UART Interrupt handler for Cooler UART test
 *
 * @return void
 */
void Test_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData) {

   testUart_t *testUART = (testUart_t *)CallBackRef;
   char* deviceDesc = Startup_UARTDeviceDesc[testUART->sel];

   switch (Event)
      {
         case XUN_EVENT_RECV_TIMEOUT:  // Data was received but stopped for 4 character periods
            ATR_DBG("%s UART: Received %d bytes.", deviceDesc, EventData);
            break;

         case XUN_EVENT_RECV_DATA:     // Data has been received
            ATR_DBG("%s UART: Receive Operation Complete.", deviceDesc);
            break;

         case XUN_EVENT_RECV_ERROR:    // Data was received with an error
            ATR_ERR("%s UART: XUN_EVENT_RECV_ERROR", deviceDesc);
            break;

         case XUN_EVENT_SENT_DATA:      // Data was sent
            ATR_DBG("%s UART: Transmit Operation Complete.", deviceDesc);
            break;

         case XUN_EVENT_MODEM:
            ATR_INF("%s UART: XUN_EVENT_MODEM", deviceDesc);
            break;

         default:
            ATR_ERR("%s UART: Unknown UART event %d", deviceDesc, Event);
      }

   return;
}
