
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

   XADC_MeasurementID_t XADC_measIdx = INTERNAL_LENS_TEMP;

   //ATR_PRINTF("Connect the Thermistor Test Harness to J17 and J20.\nPress ENTER to continue...");   --> EC
   ATR_PRINTF("Connect the Thermistor Test Harness to J20 and J21.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   IRC_Status_t Status = XADC_Init(XADC_DEVICE_ADDR);
   if (Status != IRC_SUCCESS)
   {
      ATR_ERR("Failed to initialize Device: XADC\n");
      return IRC_FAILURE;
   }

   for (curExtChannel = XEC_INTERNAL_LENS; curExtChannel <= XEC_EXT_THERMISTOR; curExtChannel++)
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
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_INTERNAL_LENS].voltage, 3));
   if ((extAdcChannels[XEC_INTERNAL_LENS].voltage >= INT_LENS_TEMP_MIN) && (extAdcChannels[XEC_INTERNAL_LENS].voltage <= INT_LENS_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(INT_LENS_TEMP_MIN, 3), _FFMT(INT_LENS_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_INTERNAL_LENS].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_EXTERNAL_LENS].voltage, 3));
   if ((extAdcChannels[XEC_EXTERNAL_LENS].voltage >= EXT_LENS_TEMP_MIN) && (extAdcChannels[XEC_EXTERNAL_LENS].voltage <= EXT_LENS_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(EXT_LENS_TEMP_MIN, 3), _FFMT(EXT_LENS_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_EXTERNAL_LENS].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_ICU].voltage, 3));
   if ((extAdcChannels[XEC_ICU].voltage >= ICU_TEMP_MIN) && (extAdcChannels[XEC_ICU].voltage <= ICU_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(ICU_TEMP_MIN, 3), _FFMT(ICU_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_ICU].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_SFW].voltage, 3));
   if ((extAdcChannels[XEC_SFW].voltage >= SFW_TEMP_MIN) && (extAdcChannels[XEC_SFW].voltage <= SFW_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SFW_TEMP_MIN, 3), _FFMT(SFW_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_SFW].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_COMPRESSOR].voltage, 3));
   if ((extAdcChannels[XEC_COMPRESSOR].voltage >= COMPR_TEMP_MIN) && (extAdcChannels[XEC_COMPRESSOR].voltage <= COMPR_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(COMPR_TEMP_MIN, 3), _FFMT(COMPR_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_COMPRESSOR].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_COLD_FINGER].voltage, 3));
   if ((extAdcChannels[XEC_COLD_FINGER].voltage >= COLD_FINGER_TEMP_MIN) && (extAdcChannels[XEC_COLD_FINGER].voltage <= COLD_FINGER_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(COLD_FINGER_TEMP_MIN, 3), _FFMT(COLD_FINGER_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_COLD_FINGER].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_SPARE].voltage, 3));
   if ((extAdcChannels[XEC_SPARE].voltage >= SPARE_TEMP_MIN) && (extAdcChannels[XEC_SPARE].voltage <= SPARE_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SPARE_TEMP_MIN, 3), _FFMT(SPARE_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = extAdcChannels[XEC_SPARE].voltage;

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(extAdcChannels[XEC_EXT_THERMISTOR].voltage, 3));
   if ((extAdcChannels[XEC_EXT_THERMISTOR].voltage >= EXT_THERM_TEMP_MIN) && (extAdcChannels[XEC_EXT_THERMISTOR].voltage <= EXT_THERM_TEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(EXT_THERM_TEMP_MIN, 3), _FFMT(EXT_THERM_TEMP_MAX, 3));
   XADC_Tests[XADC_measIdx].measurement = extAdcChannels[XEC_EXT_THERMISTOR].voltage;


   if (XADC_measIdx != EXTERNAL_TEMP) {
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

   XADC_MeasurementID_t XADC_measIdx = VOLTAGE_USB_BUS;

   IRC_Status_t Status = XADC_Init(XADC_DEVICE_ADDR);
   if (Status != IRC_SUCCESS)
   {
      ATR_ERR("Failed to initialize Device: XADC\n");
      return IRC_FAILURE;
   }

   for (curExtChannel = XEC_USB_VBUS_SENSE; curExtChannel < XEC_COUNT; curExtChannel++)
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
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_USB_VBUS_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_USB_VBUS], 3));
      if ((DeviceVoltageAry[DVS_USB_VBUS] >= USB_BUS_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_USB_VBUS] <= USB_BUS_VOLTAGE_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(USB_BUS_VOLTAGE_MIN, 3), _FFMT(USB_BUS_VOLTAGE_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_USB_VBUS];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_USB_1V8_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_USB1V8], 3));
      if ((DeviceVoltageAry[DVS_USB1V8] >= USB_1V8_MIN) && (DeviceVoltageAry[DVS_USB1V8] <= USB_1V8_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(USB_1V8_MIN, 3), _FFMT(USB_1V8_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_USB1V8];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_DDR3_VREF_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_DDR3_VREF], 3));
      if ((DeviceVoltageAry[DVS_DDR3_VREF] >= DDR3_VREF_MIN) && (DeviceVoltageAry[DVS_DDR3_VREF] <= DDR3_VREF_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(DDR3_VREF_MIN, 3), _FFMT(DDR3_VREF_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_DDR3_VREF];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_VCC_10GigE_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_VCC10GigE], 3));
      if ((DeviceVoltageAry[DVS_VCC10GigE] >= GIGE_VCC10_MIN) && (DeviceVoltageAry[DVS_VCC10GigE] <= GIGE_VCC10_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(GIGE_VCC10_MIN, 3), _FFMT(GIGE_VCC10_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_VCC10GigE];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_VCCAUX_IO_P_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_VCCAUX_IO_P], 3));
      if ((DeviceVoltageAry[DVS_VCCAUX_IO_P] >= PROC_IO_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_VCCAUX_IO_P] <= PROC_IO_VOLTAGE_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(PROC_IO_VOLTAGE_MIN, 3), _FFMT(PROC_IO_VOLTAGE_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_VCCAUX_IO_P];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_VCCAUX_IO_O_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_VCCAUX_IO_O], 3));
      if ((DeviceVoltageAry[DVS_VCCAUX_IO_O] >= OUT_IO_VOLTAGE_MIN) && (DeviceVoltageAry[DVS_VCCAUX_IO_O] <= OUT_IO_VOLTAGE_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(OUT_IO_VOLTAGE_MIN, 3), _FFMT(OUT_IO_VOLTAGE_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_VCCAUX_IO_O];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_3V3_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_Supply3V3], 3));
      if ((DeviceVoltageAry[DVS_Supply3V3] >= SUPPLY_3V3_MIN) && (DeviceVoltageAry[DVS_Supply3V3] <= SUPPLY_3V3_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SUPPLY_3V3_MIN, 3), _FFMT(SUPPLY_3V3_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_Supply3V3];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_2V5_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_Supply2V5], 3));
      if ((DeviceVoltageAry[DVS_Supply2V5] >= SUPPLY_2V5_MIN) && (DeviceVoltageAry[DVS_Supply2V5] <= SUPPLY_2V5_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SUPPLY_2V5_MIN, 3), _FFMT(SUPPLY_2V5_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_Supply2V5];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V8_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_Supply1V8], 3));
      if ((DeviceVoltageAry[DVS_Supply1V8] >= SUPPLY_1V8_MIN) && (DeviceVoltageAry[DVS_Supply1V8] <= SUPPLY_1V8_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SUPPLY_1V8_MIN, 3), _FFMT(SUPPLY_1V8_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_Supply1V8];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V5_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_Supply1V5], 3));
      if (((DeviceVoltageAry[DVS_Supply1V5] >= SUPPLY_1V5_MIN) && (DeviceVoltageAry[DVS_Supply1V5] <= SUPPLY_1V5_MAX)) ||
          ((DeviceVoltageAry[DVS_Supply1V5] >= SUPPLY_1V35_MIN) && (DeviceVoltageAry[DVS_Supply1V5] <= SUPPLY_1V35_MAX)))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "] or [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(SUPPLY_1V5_MIN, 3), _FFMT(SUPPLY_1V5_MAX, 3), _FFMT(SUPPLY_1V35_MIN, 3), _FFMT(SUPPLY_1V35_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_Supply1V5];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V0MGT_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_MGT1V0], 3));
      if ((DeviceVoltageAry[DVS_MGT1V0] >= MGT_1V0_MIN) && (DeviceVoltageAry[DVS_MGT1V0] <= MGT_1V0_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(MGT_1V0_MIN, 3), _FFMT(MGT_1V0_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_MGT1V0];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V2MGT_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_MGT1V2], 3));
      if ((DeviceVoltageAry[DVS_MGT1V2] >= MGT_1V2_MIN) && (DeviceVoltageAry[DVS_MGT1V2] <= MGT_1V2_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(MGT_1V2_MIN, 3), _FFMT(MGT_1V2_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_MGT1V2];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_12V_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_Supply12V], 3));
      if ((DeviceVoltageAry[DVS_Supply12V] >= SUPPLY_12V_MIN) && (DeviceVoltageAry[DVS_Supply12V] <= SUPPLY_12V_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SUPPLY_12V_MIN, 3), _FFMT(SUPPLY_12V_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_Supply12V];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_5V0_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageAry[DVS_Supply5V], 3));
      if ((DeviceVoltageAry[DVS_Supply5V] >= SUPPLY_5V_MIN) && (DeviceVoltageAry[DVS_Supply5V] <= SUPPLY_5V_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(SUPPLY_5V_MIN, 3), _FFMT(SUPPLY_5V_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_Supply5V];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_ADC_REF_1].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageCalibrationAry[DVCS_Ref0], 3));
      if ((DeviceVoltageCalibrationAry[DVCS_Ref0] >= ADC_REF_1_MIN) && (DeviceVoltageCalibrationAry[DVCS_Ref0] <= ADC_REF_1_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(ADC_REF_1_MIN, 3), _FFMT(ADC_REF_1_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageCalibrationAry[DVCS_Ref0];

   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_ADC_REF_2].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(DeviceVoltageCalibrationAry[DVCS_Ref1], 3));
      if ((DeviceVoltageCalibrationAry[DVCS_Ref1] >= ADC_REF_2_MIN) && (DeviceVoltageCalibrationAry[DVCS_Ref1] <= ADC_REF_2_MAX))
      {
         PRINTF("\tPASS");
         XADC_Tests[XADC_measIdx].result = XMR_PASS;
      }
      else
      {
         PRINTF("\tFAIL");
         XADC_Tests[XADC_measIdx].result = XMR_FAIL;
         invalidValue = true;
      }
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(ADC_REF_2_MIN, 3), _FFMT(ADC_REF_2_MAX, 3));
   }
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageCalibrationAry[DVCS_Ref1];

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceVoltageCalibrationAry[DVCS_Ref2], 3));
   if ((DeviceVoltageCalibrationAry[DVCS_Ref2] >= ADC_REF_3_MIN) && (DeviceVoltageCalibrationAry[DVCS_Ref2] <= ADC_REF_3_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(ADC_REF_3_MIN, 3), _FFMT(ADC_REF_3_MAX, 3));
   XADC_Tests[XADC_measIdx].measurement = DeviceVoltageCalibrationAry[DVCS_Ref2];


   if (XADC_measIdx != ADC_REF_3) {
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

   XADC_MeasurementID_t XADC_measIdx = FPGA_INTERNAL_TEMP;

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
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceTemperatureAry[DTS_ProcessingFPGA], 3));
   if ((DeviceTemperatureAry[DTS_ProcessingFPGA] >= FPGA_ITEMP_MIN && DeviceTemperatureAry[DTS_ProcessingFPGA] <= FPGA_ITEMP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(FPGA_ITEMP_MIN, 3), _FFMT(FPGA_ITEMP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = DeviceTemperatureAry[DTS_ProcessingFPGA];

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT] >= FPGA_IVCC_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT] <= FPGA_IVCC_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(FPGA_IVCC_MIN, 3), _FFMT(FPGA_IVCC_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT];

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX] >= FPGA_AVCC_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX] <= FPGA_AVCC_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(FPGA_AVCC_MIN, 3), _FFMT(FPGA_AVCC_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX];

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VREFP], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] >= FPGA_VREFP_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] <= FPGA_VREFP_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(FPGA_VREFP_MIN, 3), _FFMT(FPGA_VREFP_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_ProcessingFPGA_VREFP];

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VREFN], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VREFN] >= FPGA_VREFN_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VREFN] <= FPGA_VREFN_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(FPGA_VREFN_MIN, 3), _FFMT(FPGA_VREFN_MAX, 3));
   XADC_Tests[XADC_measIdx++].measurement = DeviceVoltageAry[DVS_ProcessingFPGA_VREFN];

   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM], 3));
   if ((DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM] >= FPGA_VBRAM_MIN) && (DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM] <= FPGA_VBRAM_MAX))
   {
      PRINTF("\tPASS");
      XADC_Tests[XADC_measIdx].result = XMR_PASS;
   }
   else
   {
      PRINTF("\tFAIL");
      XADC_Tests[XADC_measIdx].result = XMR_FAIL;
      invalidValue = true;
   }
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]", _FFMT(FPGA_VBRAM_MIN, 3), _FFMT(FPGA_VBRAM_MAX, 3));
   XADC_Tests[XADC_measIdx].measurement = DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM];


   if (XADC_measIdx != FPGA_BRAM) {
      ATR_ERR("Invalid XADC Measurement Index.");
   }

   PRINTF("\n");

   return (invalidValue) ? IRC_FAILURE : IRC_SUCCESS;
}
