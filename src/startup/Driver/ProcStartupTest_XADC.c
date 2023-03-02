
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
#include "GC_Poller.h"
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
   float measurement_min;
   float measurement_max;

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
   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_INTERNAL_LENS].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(INT_LENS_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(INT_LENS_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_EXTERNAL_LENS].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(EXT_LENS_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(EXT_LENS_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_ICU].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(ICU_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(ICU_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_SFW].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(SFW_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SFW_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_COMPRESSOR].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(COMPR_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(COMPR_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_COLD_FINGER].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(COLD_FINGER_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(COLD_FINGER_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_SPARE].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(SPARE_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SPARE_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(extAdcChannels[XEC_EXT_THERMISTOR].voltage, MEAS_PRECISION);
   measurement_min = floorMultiple(EXT_THERM_TEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(EXT_THERM_TEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));


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
   float measurement_min, measurement_min_2;
   float measurement_max, measurement_max_2;

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
   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_USB_VBUS], MEAS_PRECISION);
   measurement_min = floorMultiple(USB_BUS_VOLTAGE_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(USB_BUS_VOLTAGE_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_USB_VBUS_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_USB1V8], MEAS_PRECISION);
   measurement_min = floorMultiple(USB_1V8_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(USB_1V8_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_USB_1V8_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_DDR3_VREF], MEAS_PRECISION);
   measurement_min = floorMultiple(DDR3_VREF_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(DDR3_VREF_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_DDR3_VREF_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_VCC10GigE], MEAS_PRECISION);
   measurement_min = floorMultiple(GIGE_VCC10_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(GIGE_VCC10_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_VCC_10GigE_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_VCCAUX_IO_P], MEAS_PRECISION);
   measurement_min = floorMultiple(PROC_IO_VOLTAGE_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(PROC_IO_VOLTAGE_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_VCCAUX_IO_P_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_VCCAUX_IO_O], MEAS_PRECISION);
   measurement_min = floorMultiple(OUT_IO_VOLTAGE_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(OUT_IO_VOLTAGE_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_VCCAUX_IO_O_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_Supply3V3], MEAS_PRECISION);
   measurement_min = floorMultiple(SUPPLY_3V3_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SUPPLY_3V3_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_3V3_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_Supply2V5], MEAS_PRECISION);
   measurement_min = floorMultiple(SUPPLY_2V5_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SUPPLY_2V5_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_2V5_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_Supply1V8], MEAS_PRECISION);
   measurement_min = floorMultiple(SUPPLY_1V8_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SUPPLY_1V8_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V8_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_Supply1V5], MEAS_PRECISION);
   measurement_min = floorMultiple(SUPPLY_1V5_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SUPPLY_1V5_MAX, MEAS_PRECISION);
   measurement_min_2 = floorMultiple(SUPPLY_1V35_MIN, MEAS_PRECISION);
   measurement_max_2 = ceilMultiple(SUPPLY_1V35_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V5_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if (((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max)) ||
          ((XADC_Tests[XADC_measIdx].measurement >= measurement_min_2) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max_2)))
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
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3),
            _FFMT(measurement_min_2, 3), _FFMT(measurement_max_2, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_MGT1V0], MEAS_PRECISION);
   measurement_min = floorMultiple(MGT_1V0_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(MGT_1V0_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V0MGT_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_MGT1V2], MEAS_PRECISION);
   measurement_min = floorMultiple(MGT_1V2_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(MGT_1V2_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_1V2MGT_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_Supply12V], MEAS_PRECISION);
   measurement_min = floorMultiple(SUPPLY_12V_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SUPPLY_12V_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_12V_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_Supply5V], MEAS_PRECISION);
   measurement_min = floorMultiple(SUPPLY_5V_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(SUPPLY_5V_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_5V0_SENSE].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageCalibrationAry[DVCS_Ref0], MEAS_PRECISION);
   measurement_min = floorMultiple(ADC_REF_1_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(ADC_REF_1_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_ADC_REF_1].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageCalibrationAry[DVCS_Ref1], MEAS_PRECISION);
   measurement_min = floorMultiple(ADC_REF_2_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(ADC_REF_2_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s", XADC_Tests[XADC_measIdx].description);
   if (extAdcChannels[XEC_ADC_REF_2].raw.unipolar <= 0xF0)
   {
      PRINTF("\t\tNC");
      XADC_Tests[XADC_measIdx].result = XMR_NC;
   }
   else
   {
      PRINTF(_PCF(3), _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
      if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
      PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
            _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   }
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageCalibrationAry[DVCS_Ref2], MEAS_PRECISION);
   measurement_min = floorMultiple(ADC_REF_3_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(ADC_REF_3_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));


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
   uint64_t tic;
   extern gcPolledReg_t gcPolledRegsList[];

   XADC_MeasurementID_t XADC_measIdx = PROC_FPGA_TEMP;
   float measurement_min;
   float measurement_max;

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

   // Make sure all registers have been polled
   GETTIME(&tic);
   while (elapsed_time_us(tic) < TIME_TEN_SECOND_US)
   {
      AutoTest_RunMinimalStateMachines();
   }
   if (!gcPolledRegsList[GCPR_OutputFPGATemperature].polled ||
       !gcPolledRegsList[GCPR_OutputFPGA_VCCINTVoltage].polled ||
       !gcPolledRegsList[GCPR_OutputFPGA_VCCAUXVoltage].polled ||
       !gcPolledRegsList[GCPR_OutputFPGA_VREFPVoltage].polled ||
       !gcPolledRegsList[GCPR_OutputFPGA_VREFNVoltage].polled ||
       !gcPolledRegsList[GCPR_OutputFPGA_VBRAMVoltage].polled)
   {
      ATR_ERR("Cannot poll Output FPGA registers.");
      return IRC_FAILURE;
   }

   // Measurement output
   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceTemperatureAry[DTS_ProcessingFPGA], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_ITEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_ITEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_IVCC_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_IVCC_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_AVCC_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_AVCC_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_ProcessingFPGA_VREFP], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_VREFP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_VREFP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_ProcessingFPGA_VREFN], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_VREFN_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_VREFN_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_VBRAM_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_VBRAM_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceTemperatureAry[DTS_OutputFPGA], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_ITEMP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_ITEMP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_OutputFPGA_VCCINT], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_IVCC_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_IVCC_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_OutputFPGA_VCCAUX], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_AVCC_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_AVCC_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_OutputFPGA_VREFP], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_VREFP_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_VREFP_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_OutputFPGA_VREFN], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_VREFN_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_VREFN_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));
   XADC_measIdx++;

   XADC_Tests[XADC_measIdx].measurement = roundMultiple(DeviceVoltageAry[DVS_OutputFPGA_VBRAM], MEAS_PRECISION);
   measurement_min = floorMultiple(FPGA_VBRAM_MIN, MEAS_PRECISION);
   measurement_max = ceilMultiple(FPGA_VBRAM_MAX, MEAS_PRECISION);
   ATR_PRINTF("%s" _PCF(3), XADC_Tests[XADC_measIdx].description, _FFMT(XADC_Tests[XADC_measIdx].measurement, 3));
   if ((XADC_Tests[XADC_measIdx].measurement >= measurement_min) && (XADC_Tests[XADC_measIdx].measurement <= measurement_max))
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
   PRINTF("\tValid interval = [" _PCF(3) ", " _PCF(3) "]",
         _FFMT(measurement_min, 3), _FFMT(measurement_max, 3));


   if (XADC_measIdx != OUTPUT_FPGA_VBRAM) {
      ATR_ERR("Invalid XADC Measurement Index.");
   }

   PRINTF("\n");

   return (invalidValue) ? IRC_FAILURE : IRC_SUCCESS;
}
