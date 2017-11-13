
/**
 * @file ProcStartupTest_XADC.c
 * Processing FPGA Startup XADC tests implementation
 *
 * This file implements the Startup XADC tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_XADC.h"
#include "ProcStartupTest_SSM.h"

#include "XADC_valid.h"
#include "XADC_Channels.h"
#include "GC_Registers.h"
#include "xparameters.h"

#define XADC_DEVICE_ADDR                        XPAR_SYSMON_0_DEVICE_ID

/*
 * Uses a modified XADC state machine (XADC_SM_Test) to acquire ADC readings
 * from the external interface channels.
 *
 * @return IRC_SUCCESS if every measurement completed successfully and every
 *         value is in range.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_XADCExtIntf(void) {

   xadcExtCh_t curExtChannel;
   bool invalidValue = false;

   // External Interfaces use XADC measurement indices 4 to 15
   XADC_measIdx = XADC_MEASUREMENT_EXT_INTF_IDX;

   //ATR_PRINTF("Connect the Thermistor Test Harness to J17 and J20.\nPress ENTER to continue...");   --> EC
   ATR_PRINTF("Connect the Thermistor Test Harness to J20 and J21.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   IRC_Status_t Status = XADC_Init(XADC_DEVICE_ADDR);
   if (Status != IRC_SUCCESS)
   {
      ATR_ERR("Failed to initialize Device: XADC\n");
      return IRC_FAILURE;
   }

   for (curExtChannel = XEC_INTERNAL_LENS; curExtChannel < XEC_COOLER_SENSE; curExtChannel++)
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

   for (curExtChannel = XEC_USB_VBUS_SENSE; curExtChannel < XEC_VCCAUX_IO_P_SENSE; curExtChannel++)
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
   ATR_PRINTF("XADC -- Internal Lens Temperature..............." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_InternalLens], 3));
   if ((extAdcChannels[XEC_INTERNAL_LENS].voltage >= INT_LENS_TEMP_MIN) && (extAdcChannels[XEC_INTERNAL_LENS].voltage <= INT_LENS_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_InternalLens];

   ATR_PRINTF("XADC -- External Lens Temperature..............." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_ExternalLens], 3));
   if ((extAdcChannels[XEC_EXTERNAL_LENS].voltage >= EXT_LENS_TEMP_MIN) && (extAdcChannels[XEC_EXTERNAL_LENS].voltage <= EXT_LENS_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_ExternalLens];

   ATR_PRINTF("XADC -- Internal Calibration Unit Temperature..." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_InternalCalibrationUnit], 3));
   if ((extAdcChannels[XEC_ICU].voltage >= ICU_TEMP_MIN) && (extAdcChannels[XEC_ICU].voltage <= ICU_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_InternalCalibrationUnit];

   ATR_PRINTF("XADC -- Spectral Filter Wheel Temperature......." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_SpectralFilterWheel], 3));
   if ((extAdcChannels[XEC_SFW].voltage >= SFW_TEMP_MIN) && (extAdcChannels[XEC_SFW].voltage <= SFW_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_SpectralFilterWheel];

   ATR_PRINTF("XADC -- Compressor Temperature.................." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_Compressor], 3));
   if ((extAdcChannels[XEC_COMPRESSOR].voltage >= COMPR_TEMP_MIN) && (extAdcChannels[XEC_COMPRESSOR].voltage <= COMPR_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_Compressor];

   ATR_PRINTF("XADC -- Cold Finger Temperature................." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_ColdFinger], 3));
   if ((extAdcChannels[XEC_COLD_FINGER].voltage >= COLD_FINGER_TEMP_MIN) && (extAdcChannels[XEC_COLD_FINGER].voltage <= COLD_FINGER_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_ColdFinger];

   ATR_PRINTF("XADC -- SPARE Temperature......................." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_Spare], 3));
   if ((extAdcChannels[XEC_SPARE].voltage >= SPARE_TEMP_MIN) && (extAdcChannels[XEC_SPARE].voltage <= SPARE_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_Spare];

   ATR_PRINTF("XADC -- External Thermistor Temperature........." _PCF(3) " C", _FFMT(DeviceTemperatureAry[DTS_ExternalThermistor], 3));
   if ((extAdcChannels[XEC_EXT_THERMISTOR].voltage >= EXT_THERM_TEMP_MIN) && (extAdcChannels[XEC_EXT_THERMISTOR].voltage <= EXT_THERM_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_ExternalThermistor];

   if (extAdcChannels[XEC_USB_VBUS_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- USB Bus Voltage................................");
      PRINTF("\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- USB Bus Voltage........................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_USB_VBUS], 3));
      if ((DeviceVoltageAry[DVS_USB_VBUS] >= USB_BUS_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_USB_VBUS] <= USB_BUS_VOLTAGE_MAX))
      {
         PRINTF("\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_USB_VBUS];

   if (extAdcChannels[XEC_USB_1V8_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- USB 1.8V Source Voltage........................");
      PRINTF("\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- USB 1.8V Source Voltage................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_USB1V8], 3));
      if ((DeviceVoltageAry[DVS_USB1V8] >= USB_1V8_MIN) && (DeviceVoltageAry[DVS_USB1V8] <= USB_1V8_MAX))
      {
         PRINTF("\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_USB1V8];

   if (extAdcChannels[XEC_DDR3_VREF_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- DDR3 Reference Voltage.........................");
      PRINTF("\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- DDR3 Reference Voltage.................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_DDR3_VREF], 3));
      if ((DeviceVoltageAry[DVS_DDR3_VREF] >= DDR3_VREF_MIN) && (DeviceVoltageAry[DVS_DDR3_VREF] <= DDR3_VREF_MAX))
      {
         PRINTF("\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_DDR3_VREF];

   if (extAdcChannels[XEC_VCC_10GigE_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- GigE Supply Voltage............................");
      PRINTF("\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- GigE Supply Voltage....................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_VCC10GigE], 3));
      if ((DeviceVoltageAry[DVS_VCC10GigE] >= GIGE_VCC10_MIN) && (DeviceVoltageAry[DVS_VCC10GigE] <= GIGE_VCC10_MAX))
      {
         PRINTF("\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_VCC10GigE];

   if (XADC_measIdx != XADC_MEASUREMENT_EXT_VOLT_IDX) {
      ATR_ERR("Invalid XADC Measurement Index.");
   }

   PRINTF("\n");

   return (invalidValue) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Uses a modified XADC state machine (XADC_SM_Test) to acquire ADC readings
 * from the external voltage channels.
 *
 * @return IRC_SUCCESS if every measurement completed successfully and every
 *         value is in range.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_XADCExtVolt(void) {

   xadcExtCh_t curExtChannel;
   bool invalidValue = false;

   // External Interfaces use XADC measurement indices 4 to 15
   XADC_measIdx = XADC_MEASUREMENT_EXT_VOLT_IDX;

   IRC_Status_t Status = XADC_Init(XADC_DEVICE_ADDR);
   if (Status != IRC_SUCCESS)
   {
      ATR_ERR("Failed to initialize Device: XADC\n");
      return IRC_FAILURE;
   }

   for (curExtChannel = XEC_VCCAUX_IO_P_SENSE; curExtChannel < XEC_COUNT; curExtChannel++)
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
   if (extAdcChannels[XEC_VCCAUX_IO_P_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- Auxiliary Processing I/O Voltage..........");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- Auxiliary Processing I/O Voltage..." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_VCCAUX_IO_P], 3));
      if ((DeviceVoltageAry[DVS_VCCAUX_IO_P] >= PROC_IO_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_VCCAUX_IO_P] <= PROC_IO_VOLTAGE_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_VCCAUX_IO_P];

   if (extAdcChannels[XEC_VCCAUX_IO_O_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- Auxiliary Output I/O Voltage..............");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- Auxiliary Output I/O Voltage......." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_VCCAUX_IO_O], 3));
      if ((DeviceVoltageAry[DVS_VCCAUX_IO_O] >= OUT_IO_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_VCCAUX_IO_O] <= OUT_IO_VOLTAGE_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_VCCAUX_IO_O];

   if (extAdcChannels[XEC_3V3_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- 3.3V Supply Voltage.......................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- 3.3V Supply Voltage................" _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply3V3], 3));
      if ((DeviceVoltageAry[DVS_Supply3V3] >= SUPPLY_3V3_MIN) && (DeviceVoltageAry[DVS_Supply3V3] <= SUPPLY_3V3_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply3V3];

   if (extAdcChannels[XEC_2V5_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- 2.5V Supply Voltage.......................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- 2.5V Supply Voltage................" _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply2V5], 3));
      if ((DeviceVoltageAry[DVS_Supply2V5] >= SUPPLY_2V5_MIN) && (DeviceVoltageAry[DVS_Supply2V5] <= SUPPLY_2V5_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply2V5];

   if (extAdcChannels[XEC_1V8_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- 1.8V Supply Voltage.......................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- 1.8V Supply Voltage................" _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply1V8], 3));
      if ((DeviceVoltageAry[DVS_Supply1V8] >= SUPPLY_1V8_MIN) && (DeviceVoltageAry[DVS_Supply1V8] <= SUPPLY_1V8_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply1V8];

   if (extAdcChannels[XEC_1V5_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- 1.5V - 1.35V Supply Voltage...............");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      if ((DeviceVoltageAry[DVS_Supply1V5] >= SUPPLY_1V5_MIN) && (DeviceVoltageAry[DVS_Supply1V5] <= SUPPLY_1V5_MAX))
      {
         ATR_PRINTF("XADC -- 1.5V Supply Voltage................" _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply1V5], 3));
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else if ((DeviceVoltageAry[DVS_Supply1V5] >= SUPPLY_1V35_MIN) && (DeviceVoltageAry[DVS_Supply1V5] <= SUPPLY_1V35_MAX))
      {
         ATR_PRINTF("XADC -- 1.35V Supply Voltage..............." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply1V5], 3));
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         ATR_PRINTF("XADC -- 1.5V Supply Voltage................" _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply1V5], 3));
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply1V5];

   if (extAdcChannels[XEC_1V0MGT_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- MGT 1.0V Voltage..........................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- MGT 1.0V Voltage..................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_MGT1V0], 3));
      if ((DeviceVoltageAry[DVS_MGT1V0] >= MGT_1V0_MIN) && (DeviceVoltageAry[DVS_MGT1V0] <= MGT_1V0_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_MGT1V0];

   if (extAdcChannels[XEC_1V2MGT_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- MGT 1.2V Voltage..........................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- MGT 1.2V Voltage..................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_MGT1V2], 3));
      if ((DeviceVoltageAry[DVS_MGT1V2] >= MGT_1V2_MIN) && (DeviceVoltageAry[DVS_MGT1V2] <= MGT_1V2_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_MGT1V2];

   if (extAdcChannels[XEC_12V_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- 12V Supply Voltage........................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- 12V Supply Voltage................." _PCF(2) " V", _FFMT(DeviceVoltageAry[DVS_Supply12V], 2));
      if ((DeviceVoltageAry[DVS_Supply12V] >= SUPPLY_12V_MIN) && (DeviceVoltageAry[DVS_Supply12V] <= SUPPLY_12V_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply12V];

   if (extAdcChannels[XEC_5V0_SENSE].raw.unipolar <= 0xF0)
   {
      ATR_PRINTF("XADC -- 5V Supply Voltage.........................");
      PRINTF("\t\tNC");
      XADC_Result[XADC_measIdx] = 1;
   }
   else
   {
      ATR_PRINTF("XADC -- 5V Supply Voltage.................." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_Supply5V], 3));
      if ((DeviceVoltageAry[DVS_Supply5V] >= SUPPLY_5V_MIN) && (DeviceVoltageAry[DVS_Supply5V] <= SUPPLY_5V_MAX))
      {
         PRINTF("\t\tPASS");
         XADC_Result[XADC_measIdx] = 2;
      }
      else
      {
         PRINTF("\t\tFAIL");
         invalidValue = true;
      }
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_Supply5V];

   if (XADC_measIdx != XADC_MEASUREMENT_INT_VOLT_IDX) {
      ATR_ERR("Invalid XADC Measurement Index.");
   }

   PRINTF("\n");

   return (invalidValue) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Uses a modified XADC state machine (XADC_SM_Test) to acquire ADC readings
 * from the internal voltage channels.
 *
 * @return IRC_SUCCESS if every measurement completed successfully and every
 *         value is in range.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_XADCIntVolt(void) {

   xadcIntCh_t curIntChannel;
   bool invalidValue = false;

   // External Interfaces use XADC measurement indices 4 to 15
   XADC_measIdx = XADC_MEASUREMENT_INT_VOLT_IDX;

   IRC_Status_t Status = XADC_Init(XADC_DEVICE_ADDR);
   if (Status != IRC_SUCCESS)
   {
      ATR_ERR("Failed to initialize Device: XADC\n");
      return IRC_FAILURE;
   }

   XADC_SM_Test(XEC_COUNT);

   for (curIntChannel = XIC_TEMP; curIntChannel < XIC_COUNT; curIntChannel++)
   {
      if (!intAdcChannels[curIntChannel].isValid)
      {
         ATR_ERR("Invalid XADC reading on internal channel %d.", curIntChannel);
         return IRC_FAILURE;
      }
   }

   // Measurement output
   ATR_PRINTF("XADC -- Internal Temp..." _PCF(3) "C", _FFMT(DeviceTemperatureAry[DTS_ProcessingFPGA], 3));
   if ((DeviceTemperatureAry[DTS_ProcessingFPGA] >= FPGA_ITEMP_MIN && DeviceTemperatureAry[DTS_ProcessingFPGA] <= FPGA_ITEMP_MAX)){
      PRINTF("\t\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\t\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceTemperatureAry[DTS_ProcessingFPGA];

   ATR_PRINTF("XADC -- Internal VCC...." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT] >= FPGA_IVCC_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT] <= FPGA_IVCC_MAX))
   {
      PRINTF("\t\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\t\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT];

   ATR_PRINTF("XADC -- Auxiliary VCC..." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX] >= FPGA_AVCC_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX] <= FPGA_AVCC_MAX))
   {
      PRINTF("\t\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\t\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX];

   ATR_PRINTF("XADC -- Reference V+...." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VREFP], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] >= FPGA_VREFP_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] <= FPGA_VREFP_MAX))
   {
      PRINTF("\t\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\t\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_ProcessingFPGA_VREFP];

   ATR_PRINTF("XADC -- Reference V-...." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VREFN], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VREFN] >= FPGA_VREFN_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VREFN] <= FPGA_VREFN_MAX))
   {
      PRINTF("\t\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\t\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_ProcessingFPGA_VREFN];

   ATR_PRINTF("XADC -- BRAM Voltage...." _PCF(3) " V", _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM] >= FPGA_VBRAM_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM] <= FPGA_VBRAM_MAX))
   {
      PRINTF("\t\tPASS");
      XADC_Result[XADC_measIdx] = 2;
   }
   else
   {
      PRINTF("\t\tFAIL");
      invalidValue = true;
   }

   XADC_Measurement[XADC_measIdx++] = DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM];

   if (XADC_measIdx != XADC_MEASUREMENT_END_IDX) {
      ATR_ERR("Invalid XADC Measurement Index.");
   }

   PRINTF("\n");

   return (invalidValue) ? IRC_FAILURE : IRC_SUCCESS;
}
