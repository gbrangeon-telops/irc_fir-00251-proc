/**
 * @file ProcStartupTest_PowerIntf.h
 * Processing FPGA Startup Power Interfaces Tests implementation
 *
 * This file implements the Startup Power interfaces tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_PowerIntf.h"
#include "ProcStartupTest_SSM.h"

#include "GC_Registers.h"
#include "GC_Poller.h"
#include "fan_ctrl.h"
#include "power_ctrl.h"
#include "XADC_Channels.h"
#include "XADC_valid.h"
#include "DebugTerminal.h"
#include "xgpio.h"
#include "xintc.h"
#include "xparameters.h"

#define MAX_INTR_DELAY_US                                8 * ONE_SECOND_US
#define XADC_DEVICE_ADDR                                 XPAR_SYSMON_0_DEVICE_ID
#define FAN_CTRL_DBG_CMD_LENGTH                          10
#define ALL_GPIO_INTR_MASK                               0

extern t_fan gFan;
extern ledCtrl_t gLedCtrl;
extern XSysMon xsm;
extern powerCtrl_t gPowerCtrl;
extern XIntc gProcIntc;
extern debugTerminal_t gDebugTerminal;


/*
 * Fan Control Function Pointer type
 */
typedef void (*FanCtrlFunc_t)(unsigned int speed);

/*
 * Fan Tests Index enumeration
 */
enum testFanIndexEnum {
   INTERNAL,
   EXTERNAL_1,
   EXTERNAL_2
};

/*
 * Fan Tests Index data type
 */
typedef enum testFanIndexEnum testFanIndex_t;

/*
 * Fan Test structure
 */
struct testFanStruct {
   char           *desc;
   FanCtrlFunc_t  ctrlFunc;
};

/*
 * Fan test data type
 */
typedef struct testFanStruct testFan_t;

static bool PwrBtn_intr = false;

static void Startup_SetInternalFanSpeed(unsigned int speed);
static void Startup_SetExternalFanSpeed(unsigned int speed);
static IRC_Status_t Startup_FanCtrlTest(testFanIndex_t fanIndex);

/*
 * Fan test reference table
 */
static testFan_t testFanCtrl_Table[] = {
      { "Internal", Startup_SetInternalFanSpeed },
      { "External 1", Startup_SetExternalFanSpeed },
      { "External 2", Startup_SetExternalFanSpeed },
};


/*
 * Starts the internal fan at 100% speed, then slows to 25%, then stops.
 * Queries the user for correct fan operation at each step.
 *
 * @return IRC_SUCCESS if internal fan operation successfully controlled
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_IntFanCtrl(void) {

   //ATR_PRINTF("Connect the FPGA Fan Harness to J29.\nPress ENTER to continue...");   --> EC
   ATR_PRINTF("Connect the FPGA Fan Harness to J26.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   return Startup_FanCtrlTest(INTERNAL);
}

/*
 * Starts the external fan at 100% speed, then slows to 25%, then stops.
 * Queries the user for correct fan operation at each step.
 *
 * @return IRC_SUCCESS if external fan operation successfully controlled
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_ExtFanCtrl(void) {

   IRC_Status_t status1;
   IRC_Status_t status2;

   // External fan initial speed is not 0
   Startup_SetExternalFanSpeed(0);

   //ATR_PRINTF("Connect the External Fan Harness to J9.\nPress ENTER to continue...");   --> EC
   ATR_PRINTF("Connect the External Fan Harness to J27.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   status1 = Startup_FanCtrlTest(EXTERNAL_1);

   //ATR_PRINTF("Connect the External Fan Harness to J10.\nPress ENTER to continue...");  --> EC
   ATR_PRINTF("Connect the External Fan Harness to J29.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   status2 = Startup_FanCtrlTest(EXTERNAL_2);

   return ((status1 == IRC_SUCCESS) && (status2 == IRC_SUCCESS)) ? IRC_SUCCESS : IRC_FAILURE;
}

/*
 * Toggles each power line in sequence and queries the user for proper
 * Power LED state at each step.
 *
 * @return IRC_SUCCESS if every step completed successfully
 * @return IRC_FAILURE otherwise
 *
 * @note The BUFFER power line cannot be switched OFF (the control MOSFET is
 *       jumped in hardware)
 */
IRC_Status_t AutoTest_PwrConnectOnOff(void) {

   bool testFailed = false;

   powerChannel_t channelIndex;
   static char* powerChannelEnumStrings[] = {
         "PLEORA",
         "ADC_DDC",
         "COOLER",
         "BUFFER",
         "FW",
         "EXPANSION",
         //"SPARE1",
         //"SPARE2",
         "SPARE3",
         "SELF RESET",
         //"PUSH_BUTTON"
   };

   PRINTF("\n");
   ATR_PRINTF("...............................................");
   ATR_PRINTF("....................WARNING....................");
   ATR_PRINTF("...............................................");
   ATR_PRINTF("Make sure no cooler is connected to J3, as the \nfollowing test risks damaging it.");
   ATR_PRINTF("Press ENTER to continue...\n");

   AutoTest_getUserNULL();

   for (channelIndex = PC_PLEORA; channelIndex <= PC_SELFRESET; channelIndex++)
   {

      if (channelIndex != PC_SELFRESET && channelIndex != PC_COOLER && channelIndex != PC_FW && channelIndex != PC_SPARE2)
      {
         Power_TurnOn(channelIndex);
         ATR_PRINTF("Is the %s LED Power Indicator ON? (Y/N) ", powerChannelEnumStrings[channelIndex]);
         if (!AutoTest_getUserYN())
         {
            testFailed = true;
         }

         Power_TurnOff(channelIndex);
         ATR_PRINTF("Is the %s LED Power Indicator OFF? (Y/N) ", powerChannelEnumStrings[channelIndex]);
         if (!AutoTest_getUserYN())
         {
            testFailed = true;
         }
      }

      // Filter Wheel power channel is already ON at startup, therefore we reverse the operation order
      if (channelIndex == PC_FW)
      {
         Power_TurnOff(channelIndex);
         ATR_PRINTF("Is the %s LED Power Indicator OFF? (Y/N) ", powerChannelEnumStrings[channelIndex]);
         if (!AutoTest_getUserYN())
         {
            testFailed = true;
         }

         Power_TurnOn(channelIndex);
         ATR_PRINTF("Is the %s LED Power Indicator ON? (Y/N) ", powerChannelEnumStrings[channelIndex]);
         if (!AutoTest_getUserYN())
         {
            testFailed = true;
         }
      }

      // The COOLER power line requires special handling, as the regular Power_TurnOn function
      // does not allow COOLER power channel control.
      if (channelIndex == PC_COOLER)
      {
         uint32_t mask = 1 << channelIndex;
         uint32_t regValue;

         regValue = XGpio_DiscreteRead(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT) | mask;
         XGpio_DiscreteWrite(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT, regValue);

         ATR_PRINTF("Is the %s LED Power Indicator ON? (Y/N) ", powerChannelEnumStrings[channelIndex]);
         if (!AutoTest_getUserYN())
         {
            testFailed = true;
         }

         regValue &= ~mask;
         XGpio_DiscreteWrite(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT, regValue);

         ATR_PRINTF("Is the %s LED Power Indicator OFF? (Y/N) ", powerChannelEnumStrings[channelIndex]);
         if (!AutoTest_getUserYN())
         {
            testFailed = true;
         }
      }
   }

   return (testFailed) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Initializes the Camera LED GPIO, then cycles through all 3 LED colors.
 * Queries the user for correct LED lighting at every step.
 *
 * @return IRC_SUCCESS if every step completed successfully.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_CamLEDColors(void) {

   bool testFailed = false;

   Led_SetCameraLedState(&gLedCtrl, CLS_OFF);

   ATR_PRINTF("Connect the LED Indicator Harness to J13.\nPress ENTER to continue...");

   AutoTest_getUserNULL();

   Led_SetCameraLedState(&gLedCtrl, CLS_GREEN);
   ATR_PRINTF("Is the Camera LED lit GREEN? (Y/N) ");
   if (!AutoTest_getUserYN()){
      testFailed = true;
   }

   Led_SetCameraLedState(&gLedCtrl, CLS_YELLOW);
   ATR_PRINTF("Is the Camera LED lit YELLOW? (Y/N) ");
   if (!AutoTest_getUserYN()){
      testFailed = true;
   }

   Led_SetCameraLedState(&gLedCtrl, CLS_RED);
   ATR_PRINTF("Is the Camera LED lit RED? (Y/N) ");
   if (!AutoTest_getUserYN()){
      testFailed = true;
   }

   Led_SetCameraLedBlinking(&gLedCtrl, CLS_RED, CLS_GREEN, 0.5 * ONE_SECOND_US);
   ATR_PRINTF("Is the Camera LED blinking RED and GREEN? (Y/N) ");
   if (!AutoTest_getUserYN()){
      testFailed = true;
   }

   Led_SetCameraLedState(&gLedCtrl, CLS_OFF);
   Led_SetCameraLedBlinking(&gLedCtrl, CLS_OFF, CLS_OFF, 0);

   return (testFailed) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Ties the Power button interrupt to a test handler and attempts to detect
 * Power button interrupts.
 *
 * @return IRC_SUCCESS if one interrupt is detected
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_PwrBtnInt(void) {

   uint64_t pwr_tic;

   // Replace the Power button handler with a test handler
   XIntc_Disconnect(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FLASHRESET_0_IP2INTC_IRPT_INTR);
   XIntc_Connect(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FLASHRESET_0_IP2INTC_IRPT_INTR, (XInterruptHandler)Power_IntrHandler_Test, &gPowerCtrl);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FLASHRESET_0_IP2INTC_IRPT_INTR);

   ATR_PRINTF("Connect the Power Button to J8.\nPress ENTER to continue...");
   GC_Poller_Stop();
   AutoTest_getUserNULL();

   while (GC_Poller_IsActive()) {
      AutoTest_RunMinimalStateMachines();
   }

   ATR_PRINTF("Press the Power button now.");

   GETTIME(&pwr_tic);
   while ((elapsed_time_us(pwr_tic) < MAX_INTR_DELAY_US) && !PwrBtn_intr) {
      AutoTest_RunMinimalStateMachines();
   }

   if (!PwrBtn_intr)
   {
      ATR_ERR("No interrupt detected");
      XIntc_Disable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FLASHRESET_0_IP2INTC_IRPT_INTR);
      return IRC_FAILURE;
   }

   ATR_PRINTF("Release the Power button now.");

   GETTIME(&pwr_tic);
   while ((elapsed_time_us(pwr_tic) < MAX_INTR_DELAY_US) && PwrBtn_intr) {
      AutoTest_RunMinimalStateMachines();
   }

   if (PwrBtn_intr)
   {
      ATR_ERR("No interrupt detected");
      XIntc_Disable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FLASHRESET_0_IP2INTC_IRPT_INTR);
      return IRC_FAILURE;
   }

   XIntc_Disable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FLASHRESET_0_IP2INTC_IRPT_INTR);
   GC_Poller_Start();

   return IRC_SUCCESS;
}

/*
 * Uses a modified XADC state machine (XADC_SM_Test) to acquire ADC readings
 * from the Cooler and 24V voltage and current channels.
 *
 * @return IRC_SUCCESS if every measurement completed successfully and every
 *         value is in range.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_XADCPwrMonitor(void) {

   xadcExtCh_t curExtChannel;
   bool invalidValue = false;

   // External Interfaces use XADC measurement indices 4 to 15
   XADC_measIdx = XADC_MEASUREMENT_PWR_IDX;

   ATR_PRINTF("Make sure the following test harnesses are disconnected:");
   ATR_PRINTF("\tFPGA Fan");
   ATR_PRINTF("\tInternal Fan");
   ATR_PRINTF("\tExternal Fan");
   PRINTF("\n");
   ATR_PRINTF("Press ENTER to continue...");
   AutoTest_getUserNULL();

   PRINTF("\n");
   // Turn off LED indicator so that current status does not impact the XADC 24V Current Sense test
   Led_SetCameraLedState(&gLedCtrl, CLS_OFF);

   IRC_Status_t Status = XADC_Init(XADC_DEVICE_ADDR);
   if (Status != IRC_SUCCESS)
   {
      ATR_ERR("Failed to initialize Device: XADC\n");
      return IRC_FAILURE;
   }

   for (curExtChannel = XEC_COOLER_SENSE; curExtChannel <= XEC_24V_CUR; curExtChannel++)
   {
      // Keep alive
      AutoTest_RunMinimalStateMachines();

      XADC_SM_Test(curExtChannel);
      if (!extAdcChannels[curExtChannel].isValid)
      {
         ATR_ERR("Invalid XADC reading on external channel %d.", curExtChannel);
         return IRC_FAILURE;
      }
   }

   // Measurement output
   ATR_PRINTF("XADC -- Cooler Voltage:");
   if (extAdcChannels[XEC_COOLER_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      PRINTF(" " _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Cooler], 3));
      if ((DeviceVoltageAry[DVS_Cooler] >= COOLER_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_Cooler] <= COOLER_VOLTAGE_MAX))
      {
         PRINTF("\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Result[XADC_measIdx] = 0;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(COOLER_VOLTAGE_MIN, 3), _FFMT(COOLER_VOLTAGE_MAX, 3));
   }
   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Cooler];

   ATR_PRINTF("XADC -- Cooler Current:");
   if (extAdcChannels[XEC_COOLER_CUR].raw.unipolar <= 0xF0)
   {
      PRINTF("\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      PRINTF(" " _PCF(3)" A", _FFMT(DeviceCurrentAry[DCS_Cooler], 3));
      if ((DeviceCurrentAry[DCS_Cooler] >= COOLER_CURRENT_MIN) && (DeviceCurrentAry[DCS_Cooler] <= COOLER_CURRENT_MAX))
      {
         PRINTF("\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Result[XADC_measIdx] = 0;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(COOLER_CURRENT_MIN, 3), _FFMT(COOLER_CURRENT_MAX, 3));
   }
   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DCS_Cooler];

   ATR_PRINTF("XADC -- 24V Voltage: " _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply24V], 3));
   if ((DeviceVoltageAry[DVS_Supply24V] >= P24V_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_Supply24V] <= P24V_VOLTAGE_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Result[XADC_measIdx] = 0;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(P24V_VOLTAGE_MIN, 3), _FFMT(P24V_VOLTAGE_MAX, 3));
   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply24V];

   ATR_PRINTF("XADC -- 24V Current: " _PCF(3) " A", _FFMT(DeviceCurrentAry[DCS_Supply24V], 3));
   if ((DeviceCurrentAry[DCS_Supply24V] >= P24V_CURRENT_MIN) && (DeviceCurrentAry[DCS_Supply24V] <= P24V_CURRENT_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Result[XADC_measIdx] = 0;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(P24V_CURRENT_MIN, 3), _FFMT(P24V_CURRENT_MAX, 3));
   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DCS_Supply24V];

   if (XADC_measIdx != XADC_MEASUREMENT_EXT_INTF_IDX) {
      ATR_ERR("Invalid XADC Measurement Index.");
   }

   PRINTF("\n");

   return (invalidValue) ? IRC_FAILURE : IRC_SUCCESS;
}

/**
 * Sets the Internal Fan Speed
 *
 * @param speed is the target internal fan speed
 */
static void Startup_SetInternalFanSpeed(unsigned int speed) {

   // Fan is now always 100%

   return;
}

/**
 * Sets the External Fan Speed
 *
 * @param speed is the target external fan speed
 */
static void Startup_SetExternalFanSpeed(unsigned int speed) {

   gcRegsData.ExternalFanSpeedSetpoint = (float)speed;
   GC_UpdateExternalFanSpeed();

   return;
}

/*
 * Sets the fan speed to 100%, then 25%, then 0%. Queries the user at each step
 * to verify correct fan operation.
 *
 * @param fanIndex is a member of testFanIndexEnum indicating upon which fan the
 *        tests are to be performed.
 *
 * @return IRC_SUCCESS if fan control was successful at every step
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t Startup_FanCtrlTest(testFanIndex_t fanIndex) {

   bool testFailed = false;

   testFanCtrl_Table[fanIndex].ctrlFunc(100);
   ATR_PRINTF("Does the %s fan run at 100%% speed? (Y/N) ", testFanCtrl_Table[fanIndex].desc);
   if (!AutoTest_getUserYN())
   {
      testFailed = true;
   }

   if (fanIndex != INTERNAL)
   {
      testFanCtrl_Table[fanIndex].ctrlFunc(25);
      ATR_PRINTF("Does the %s fan run at 25%% speed? (Y/N) ", testFanCtrl_Table[fanIndex].desc);
      if (!AutoTest_getUserYN())
      {
         testFailed = true;
      }

      testFanCtrl_Table[fanIndex].ctrlFunc(0);
      ATR_PRINTF("Has the %s fan completely stopped? (Y/N) ", testFanCtrl_Table[fanIndex].desc);
      if (!AutoTest_getUserYN())
      {
         testFailed = true;
      }
   }

   return (testFailed) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Test interrupt handler for the Power Button test function
 * Sets and clears the PwrBtn_intr flag to be read by the test function
 *
 * @return void
 */
void Power_IntrHandler_Test(powerCtrl_t *p_powerCtrl) {

   if (!TDCStatusTst(WaitingForInitMask))
   {
      if (Power_GetPushButtonState() == PBS_RELEASED)
      {
         ATR_PRINTF("Power Button Interrupt detected.");
         ATR_DBG("Button released.");
         PwrBtn_intr = false;
      }
      else
      {
         ATR_PRINTF("Power Button Interrupt detected.");
         ATR_DBG("Button pushed.");
         PwrBtn_intr = true;
      }
   }

   return;

}
