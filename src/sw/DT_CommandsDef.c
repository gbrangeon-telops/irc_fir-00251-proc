/**
 * @file DT_CommandsDef.c
 *  Debug terminal commands implementation.
 *  
 *  This file implements the debug terminal commands.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "DebugTerminal.h"
#include "CircularByteBuffer.h"
#include "IRC_Status.h"
#include "GC_Registers.h"
#include "FPA_intf.h"
#include "hder_inserter.h"
#include "calib.h"
#include "utils.h"
#include "Actualization.h"
#include "BufferManager.h"
#include "FileManager.h"
#include "power_ctrl.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "FlashSettings.h"
#include "FlashDynamicValues.h"
#include "proc_memory.h"
#include "GPS.h"
#include "trig_gen.h"
#include "DeviceKey.h"
#include "GC_Poller.h"
#include "BuiltInTests.h"
#include "ReleaseInfo.h"
#include "adc_readout.h"
#include <stdbool.h>
#include <limits.h>
#include <time.h>
#include <string.h>

#ifdef STARTUP
#include "DT_CommandsDef_startup.h"
#endif

static IRC_Status_t DebugTerminalParseFPA(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseHDER(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseCAL(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseTRIG(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseSTATUS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParsePOWER(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseACT(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseBUF(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseRM(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFO(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLB(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseSB(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLED(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseGPS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseVER(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseUNLOCK(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFORMAT(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFRW(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseMRW(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseRST(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParsePWR(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseDFW(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseKEY(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseGCP(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseADC(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseDFDVU(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseDTO(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseHLP(circByteBuffer_t *cbuf);

debugTerminalCommand_t gDebugTerminalCommands[] =
{
   {"RDM", DebugTerminalParseRDM},
   {"WRM", DebugTerminalParseWRM},
   {"FPA", DebugTerminalParseFPA},
   {"HDER", DebugTerminalParseHDER},
   {"CAL", DebugTerminalParseCAL},
   {"TRIG", DebugTerminalParseTRIG},
   {"STATUS", DebugTerminalParseSTATUS},
   {"POWER", DebugTerminalParsePOWER},
   {"NET", DebugTerminalParseNET},
   {"ACT", DebugTerminalParseACT},
   {"BUF", DebugTerminalParseBUF},
   {"LS", DebugTerminalParseLS},
   {"RM", DebugTerminalParseRM},
   {"FO", DebugTerminalParseFO},
   {"LB", DebugTerminalParseLB},
   {"SB", DebugTerminalParseSB},
   {"LED", DebugTerminalParseLED},
   {"GPS", DebugTerminalParseGPS},
   {"VER", DebugTerminalParseVER},
   {"UNLOCK", DebugTerminalParseUNLOCK},
   {"FORMAT", DebugTerminalParseFORMAT},
   {"FRW", DebugTerminalParseFRW},
   {"MRW", DebugTerminalParseMRW},
   {"RST", DebugTerminalParseRST},
   {"PWR", DebugTerminalParsePWR},
   {"DFW", DebugTerminalParseDFW},
   {"KEY", DebugTerminalParseKEY},
   {"STACK", DebugTerminalParseSTACK},
   {"GCP", DebugTerminalParseGCP},
   {"ADC", DebugTerminalParseADC},
   {"DFDVU", DebugTerminalParseDFDVU},
   {"FS", DebugTerminalParseFS},
   {"DTO", DebugTerminalParseDTO},
#ifdef STARTUP
   DT_STARTUP_CMDS
#endif
   {"HLP", DebugTerminalParseHLP}
};

uint32_t gDebugTerminalCommandsCount = NUM_OF(gDebugTerminalCommands);

bool gDisableFilterWheel;

/**
 * Debug terminal get FPA status command parser.
 * This parser is used to parse and validate get FPA status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when FPA status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFPA(circByteBuffer_t *cbuf)
{
   extern t_FpaIntf gFpaIntf;
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaDebugRegA;
   extern int32_t gFpaDebugRegB;
   extern int32_t gFpaDebugRegC;
   extern int32_t gFpaDebugRegD;
   uint8_t argStr[12];
   uint32_t arglen;
   uint32_t cmd = 0;
   int32_t iValue = 0;
   float fValue = 0.0F;
   t_FpaStatus status;

   // Check for FPA command argument presence
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read FPA command argument
      arglen = GetNextArg(cbuf, argStr, 4);
      if (arglen == 0)
      {
         DT_ERR("Invalid FPA command argument.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      if (strcasecmp((char *)argStr, "POL") == 0)
      {
         cmd = 1;
      }
      else if (strcasecmp((char *)argStr, "REF") == 0)
      {
         cmd = 2;
      }
      else if (strcasecmp((char *)argStr, "OFF") == 0)
      {
         cmd = 3;
      }
      else if (strcasecmp((char *)argStr, "REGA") == 0)
      {
         cmd = 4;
      }
      else if (strcasecmp((char *)argStr, "REGB") == 0)
      {
         cmd = 5;
      }
      else if (strcasecmp((char *)argStr, "REGC") == 0)
      {
         cmd = 6;
      }
      else if (strcasecmp((char *)argStr, "REGD") == 0)
      {
         cmd = 7;
      }
      else
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      // Read FPA command parameter value
      arglen = GetNextArg(cbuf, argStr, 12);
      switch (cmd)
      {
         case 1: // POL
            if ((ParseSignedNumDec((char *)argStr, arglen, &iValue) != IRC_SUCCESS) ||
                  (iValue < -32768) || (iValue > 32767))
            {
               DT_ERR("Invalid int16 value.");
               return IRC_FAILURE;
            }
            break;

         case 4: // REGA
         case 5: // REGB
         case 6: // REGC
         case 7: // REGD
            if (ParseSignedNumDec((char *)argStr, arglen, &iValue) != IRC_SUCCESS)
            {
               DT_ERR("Invalid int32 value.");
               return IRC_FAILURE;
            }
            break;

         case 2: // REF
         case 3: // OFF
            if (ParseFloatNumDec((char *)argStr, arglen, &fValue) != IRC_SUCCESS)
            {
               DT_ERR("Invalid float value.");
               return IRC_FAILURE;
            }
            break;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      // Update FPA parameter
      switch (cmd)
      {
         case 1: // POL
            gFpaDetectorPolarizationVoltage = (int16_t)iValue;
            break;

         case 2: // REF
            gFpaDetectorElectricalTapsRef = fValue;
            break;

         case 3: // OFF
            gFpaDetectorElectricalRefOffset = fValue;
            break;

         case 4: // REGA
            gFpaDebugRegA = iValue;
            break;

         case 5: // REGB
            gFpaDebugRegB = iValue;
            break;

         case 6: // REGC
            gFpaDebugRegC = iValue;
            break;

         case 7: // REGD
            gFpaDebugRegD = iValue;
            break;
      }
      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
   }

   FPA_GetStatus(&status, &gFpaIntf);

   DT_PRINTF("FPA model name = " FPA_DEVICE_MODEL_NAME);

   DT_PRINTF("FPA temperature = %dcC", FPA_GetTemperature(&gFpaIntf));

   DT_PRINTF("FPA detector polarization voltage = %d mV", gFpaDetectorPolarizationVoltage);
   DT_PRINTF("FPA detector taps reference voltage = " _PCF(3) " mV", _FFMT(gFpaDetectorElectricalTapsRef, 3));
   DT_PRINTF("FPA detector offset voltage = " _PCF(3) " mV", _FFMT(gFpaDetectorElectricalRefOffset, 3));

   DT_PRINTF("FPA debug register A = %d", gFpaDebugRegA);
   DT_PRINTF("FPA debug register B = %d", gFpaDebugRegB);
   DT_PRINTF("FPA debug register C = %d", gFpaDebugRegC);
   DT_PRINTF("FPA debug register D = %d", gFpaDebugRegD);

   DT_PRINTF("fpa.adc_oper_freq_max_khz = %d", status.adc_oper_freq_max_khz);
   DT_PRINTF("fpa.adc_analog_channel_num = %d", status.adc_analog_channel_num);
   DT_PRINTF("fpa.adc_resolution = %d", status.adc_resolution);
   DT_PRINTF("fpa.adc_brd_spare = %d", status.adc_brd_spare);

   DT_PRINTF("fpa.ddc_fpa_roic = %d", status.ddc_fpa_roic);
   DT_PRINTF("fpa.ddc_brd_spare = %d", status.ddc_brd_spare);

   DT_PRINTF("fpa.flex_fpa_roic = %d", status.flex_fpa_roic);
   DT_PRINTF("fpa.flex_fpa_input = %d", status.flex_fpa_input);
   DT_PRINTF("fpa.flex_ch_diversity_num = %d", status.flex_ch_diversity_num);

   DT_PRINTF("fpa.cooler_volt_min_mV = %d", status.cooler_volt_min_mV);
   DT_PRINTF("fpa.cooler_volt_max_mV = %d", status.cooler_volt_max_mV);
   DT_PRINTF("fpa.fpa_temp_raw = %d", status.fpa_temp_raw);

   DT_PRINTF("fpa.global_done = %d", status.global_done);
   DT_PRINTF("fpa.fpa_powered = %d", status.fpa_powered);
   DT_PRINTF("fpa.cooler_powered = %d", status.cooler_powered);

   DT_PRINTF("fpa.errors_latchs = 0x%08X", status.errors_latchs);

   DT_PRINTF("fpa.adc_ddc_detect_process_done = %d", status.adc_ddc_detect_process_done);
   DT_PRINTF("fpa.adc_ddc_present = %d", status.adc_ddc_present);
   DT_PRINTF("fpa.flex_detect_process_done = %d", status.flex_detect_process_done);
   DT_PRINTF("fpa.flex_present = %d", status.flex_present);
   
   DT_PRINTF("fpa.id_cmd_in_error = 0x%08X", status.id_cmd_in_error);

   DT_PRINTF("fpa.serdes_done = 0b%s", dec2bin(status.fpa_serdes_done, 4));
   DT_PRINTF("fpa.serdes_success = 0b%s", dec2bin(status.fpa_serdes_success, 4));
   
   DT_PRINTF("fpa.serdes_edges_ch0 = 0x%08X", status.fpa_serdes_edges[0]);
   DT_PRINTF("fpa.serdes_delay_ch0 = %d", status.fpa_serdes_delay[0]);
   DT_PRINTF("fpa.serdes_edges_ch1 = 0x%08X", status.fpa_serdes_edges[1]);
   DT_PRINTF("fpa.serdes_delay_ch1 = %d", status.fpa_serdes_delay[1]);
   DT_PRINTF("fpa.serdes_edges_ch2 = 0x%08X", status.fpa_serdes_edges[2]);
   DT_PRINTF("fpa.serdes_delay_ch2 = %d", status.fpa_serdes_delay[2]);
   DT_PRINTF("fpa.serdes_edges_ch3 = 0x%08X", status.fpa_serdes_edges[3]);
   DT_PRINTF("fpa.serdes_delay_ch3 = %d", status.fpa_serdes_delay[3]);

   DT_PRINTF("fpa.init_done = %d", status.fpa_init_done);
   DT_PRINTF("fpa.init_success = %d", status.fpa_init_success);

   return IRC_SUCCESS;
}

/**
 * Debug terminal get HDER status command parser.
 * This parser is used to parse and validate get HDER status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when HDER status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseHDER(circByteBuffer_t *cbuf)
{
   extern t_HderInserter gHderInserter;
   uint32_t status;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   status = HDER_GetStatus(&gHderInserter);

   DT_INF("hder status = 0x%08X", status);

   return IRC_SUCCESS;
}

/**
 * Debug terminal get CAL status command parser.
 * This parser is used to parse and validate get CAL status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when CAL status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseCAL(circByteBuffer_t *cbuf)
{
   extern t_calib gCal;
   t_CalStatus status;
   uint32_t i;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   CAL_GetStatus(&status, &gCal);

   DT_PRINTF("cal.done = %d", status.done);
   for (i = 0; i < NUM_OF(status.error_set); i++)
   {
      DT_PRINTF("cal.error_set[%d] = 0x%08X", i, status.error_set[i]);
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal get TRIG status command parser.
 * This parser is used to parse and validate get TRIG status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when TRIG status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseTRIG(circByteBuffer_t *cbuf)
{
   extern t_Trig gTrig;
   t_TrigStatus status;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   TRIG_GetStatus(&gTrig, &status);

   DT_PRINTF("trig_ctlr_status = 0x%08X", status.ctlr_status);

   DT_PRINTF("trig_period_min[0] = %d", status.trig_period_min[0]);
   DT_PRINTF("trig_period_max[0] = %d", status.trig_period_max[0]);
   DT_PRINTF("trig_period_min[1] = %d", status.trig_period_min[1]);
   DT_PRINTF("trig_period_max[1] = %d", status.trig_period_max[1]);
   DT_PRINTF("trig_period_min[2] = %d", status.trig_period_min[2]);
   DT_PRINTF("trig_period_max[2] = %d", status.trig_period_max[2]);
   DT_PRINTF("trig_period_min[3] = %d", status.trig_period_min[3]);
   DT_PRINTF("trig_period_max[3] = %d", status.trig_period_max[3]);
   DT_PRINTF("trig_period_min[4] = %d", status.trig_period_min[4]);
   DT_PRINTF("trig_period_max[4] = %d", status.trig_period_max[4]);
   DT_PRINTF("trig_period_min[5] = %d", status.trig_period_min[5]);
   DT_PRINTF("trig_period_max[5] = %d", status.trig_period_max[5]);
   DT_PRINTF("trig_period_min[6] = %d", status.trig_period_min[6]);
   DT_PRINTF("trig_period_max[6] = %d", status.trig_period_max[6]);
   DT_PRINTF("trig_period_min[7] = %d", status.trig_period_min[7]);
   DT_PRINTF("trig_period_max[7] = %d", status.trig_period_max[7]);

   return IRC_SUCCESS;
}

/**
 * Debug terminal get camera status command parser.
 * This parser is used to parse and validate get camera status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when get camera status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseSTATUS(circByteBuffer_t *cbuf)
{
   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINTF("TDCStatus = 0x%08X", gcRegsData.TDCStatus);
   DT_PRINTF("Bit0:  WaitingForCooler =             %d", TDCStatusTst(WaitingForCoolerMask));
   DT_PRINTF("Bit1:  WaitingForSensor =             %d", TDCStatusTst(WaitingForSensorMask));
   DT_PRINTF("Bit2:  WaitingForInit =               %d", TDCStatusTst(WaitingForInitMask));
   DT_PRINTF("Bit3:  Reserved =                     %d", TDCStatusTst(1L << 3));
   DT_PRINTF("Bit4:  WaitingForICU =                %d", TDCStatusTst(WaitingForICUMask));
   DT_PRINTF("Bit5:  WaitingForNDFilter =           %d", TDCStatusTst(WaitingForNDFilterMask));
   DT_PRINTF("Bit6:  WaitingForCalibrationInit =    %d", TDCStatusTst(WaitingForCalibrationInitMask));
   DT_PRINTF("Bit7:  WaitingForFilterWheel =        %d", TDCStatusTst(WaitingForFilterWheelMask));
   DT_PRINTF("Bit8:  WaitingForArm =                %d", TDCStatusTst(WaitingForArmMask));
   DT_PRINTF("Bit9:  WaitingForValidParameters =    %d", TDCStatusTst(WaitingForValidParametersMask));
   DT_PRINTF("Bit10: AcquisitionStarted =           %d", TDCStatusTst(AcquisitionStartedMask));
   DT_PRINTF("Bit11: Reserved =                     %d", TDCStatusTst(1L << 11));
   DT_PRINTF("Bit12: WaitingForCalibrationData =    %d", TDCStatusTst(WaitingForCalibrationDataMask));
   DT_PRINTF("Bit13: WaitingForImageCorrection =    %d", TDCStatusTst(WaitingForImageCorrectionMask));
   DT_PRINTF("Bit14: WaitingForOutputFPGA =         %d", TDCStatusTst(WaitingForOutputFPGAMask));
   DT_PRINTF("Bit15: WaitingForPower =              %d", TDCStatusTst(WaitingForPowerMask));
   DT_PRINTF("Bit16: WaitingForFlashSettingsInit =  %d", TDCStatusTst(WaitingForFlashSettingsInitMask));

   return IRC_SUCCESS;
}

/**
 * Debug terminal get camera power status command parser.
 * This parser is used to parse and validate get camera power status
 * command arguments and to execute the command.
 *
 * @return IRC_SUCCESS when get camera power status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParsePOWER(circByteBuffer_t *cbuf)
{
   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   switch (gcRegsData.DevicePowerStateSetpoint)
   {
      case DPSS_PowerStandby:
         DT_PRINTF("DevicePowerStateSetpoint = Standby (%d)", gcRegsData.DevicePowerStateSetpoint);
         break;

      case DPSS_PowerOn:
         DT_PRINTF("DevicePowerStateSetpoint = On (%d)", gcRegsData.DevicePowerStateSetpoint);
         break;
   }
   switch (gcRegsData.DevicePowerState)
   {
      case DPS_PowerStandby:
         DT_PRINTF("DevicePowerState = Standby (%d)", gcRegsData.DevicePowerState);
         break;

      case DPS_PowerOn:
         DT_PRINTF("DevicePowerState = On (%d)", gcRegsData.DevicePowerState);
         break;

      case DPS_PowerInTransition:
         DT_PRINTF("DevicePowerState = In Transition (%d)", gcRegsData.DevicePowerState);
         break;
   }
   DT_PRINTF("Pleora =       %s", (Power_GetChannelPowerState(PC_PLEORA) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("ADC/DDC =      %s", (Power_GetChannelPowerState(PC_ADC_DDC) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Cooler =       %s", (Power_GetChannelPowerState(PC_COOLER) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Buffer =       %s", (Power_GetChannelPowerState(PC_BUFFER) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Filter wheel = %s", (Power_GetChannelPowerState(PC_FW) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Expansion =    %s", (Power_GetChannelPowerState(PC_EXPANSION) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Spare1 =       %s", (Power_GetChannelPowerState(PC_SPARE1) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Spare2 =       %s", (Power_GetChannelPowerState(PC_SPARE2) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Spare =        %s", (Power_GetChannelPowerState(PC_SPARE) == CPS_ON)? "ON":"OFF");

   return IRC_SUCCESS;
}

/**
 * Debug terminal ACT control.
 * This parser is used to debug actualization
 *
 * @return IRC_SUCCESS when FPA status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseACT(circByteBuffer_t *cbuf)
{
   uint32_t cmd = 1000;
   uint32_t value;
   uint8_t argStr[11];
   uint32_t arglen;

   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   argStr[arglen++] = '\0';
   if (strcasecmp((char*)argStr, "DBG") == 0) // data debug diagnosis mode
      cmd = 0;
   else if (strcasecmp((char*)argStr, "RST") == 0) // reset options
      cmd = 1;
   else if (strcasecmp((char*)argStr, "INV") == 0) // invalidate the current actualization
      cmd = 2;
   else if (strcasecmp((char*)argStr, "CLR") == 0) // set the clear option for the buffer after an actualization
      cmd = 3;
   else if (strcasecmp((char*)argStr, "ICU") == 0) // perform actualization using ICU
      cmd = 4;
   else if (strcasecmp((char*)argStr, "XBB") == 0) // perform actualization using external BB
      cmd = 5;
   else if (strcasecmp((char*)argStr, "AEC") == 0) // AEC enable/disable
      cmd = 6;
   else if (strcasecmp((char*)argStr, "CFG") == 0) // Mode configuration
      cmd = 7;
   else if (strcasecmp((char*)argStr, "STP") == 0) // Cancel currently running actualization
      cmd = 8;
   else if (strcasecmp((char*)argStr, "LST") == 0) // List all actualization in memory and flash memory
      cmd = 9;

   switch (cmd)
   {
      case 0: // debug data on/off
         arglen = GetNextArg(cbuf, argStr, 10);
         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (value == 0)
            {
               DT_INF("using detector data for actualization");
               gActDebugOptions.useDebugData = false;
            }
            else
            {
               DT_INF("using constant test pattern data for actualization");
               gActDebugOptions.useDebugData = true;
            }
         }
         break;

      case 1: // reset options
         ACT_resetDebugOptions();
         DT_INF("actualization options were reset");
         break;

      case 2: // invalidate and reload
         if (TDCStatusTst(WaitingForImageCorrectionMask) == 0 && TDCStatusTst(AcquisitionStartedMask) == 0)
         {
            arglen = GetNextArg(cbuf, argStr, 10);
            if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
            {
               value = 0; // clear current by default
            }

            if (value == 0)
            {
               ACT_invalidateActualizations(ACT_CURRENT);
               DT_PRINTF("all actualizations were invalidated");
            }
            else
            {
               ACT_invalidateActualizations(ACT_ALL);
               DT_PRINTF("current actualization was invalidated");
            }

            // reload the calibration to unapply the actualization
            Calibration_LoadCalibrationFilePOSIXTime(calibrationInfo.collection.POSIXTime);
         }
         else
         {
            DT_ERR("Actualization invalidation is unavailable while the camera is busy");
            return IRC_FAILURE;
         }
         break;

      case 3: // clear buffer on/off
            arglen = GetNextArg(cbuf, argStr, 10);
            if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
            {
               DT_ERR("Invalid data length.");
               return IRC_FAILURE;
            }
            else
            {
               if (value == 1)
               {
                  DT_INF("will clear the buffer after actualisation");
                  gActDebugOptions.clearBufferAfterCompletion = true;
               }
               else
               {
                  DT_INF("will not clear the buffer after actualisation");
                  gActDebugOptions.clearBufferAfterCompletion = false;
               }
            }
            break;

      case 4: // perform actualization using ICU
         DT_INF("Triggering an actualization (icu)");
         gcRegsData.ImageCorrectionMode = ICM_ICU;
         startActualization(false);
         break;

      case 5: // perform actualization using external BB
         DT_INF("Triggering an actualization (xbb)");
         gcRegsData.ImageCorrectionMode = ICM_BlackBody;
         startActualization(false);
         break;

      case 6: // AEC on/off
         arglen = GetNextArg(cbuf, argStr, 10);
         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (value == 1)
            {
               DT_INF("AEC enabled during actualisation");
               gActDebugOptions.bypassAEC = false;
            }
            else
            {
               DT_INF("AEC disabled during actualisation");
               gActDebugOptions.bypassAEC = true;
            }
         }
         break;

      case 7: // CFG mode
               arglen = GetNextArg(cbuf, argStr, 10);
               if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
               {
                  // without argument : display the current mode
                  value = gActDebugOptions.mode;
               }
               else
                  gActDebugOptions.mode = value;

               DT_PRINTF("Actualisation : current mode = 0x%02X", value);

               if (BitMaskTst(value, ACT_MODE_DEBUG))
               {
                  DT_PRINTF("Actualisation : debug mode activated (0x%02X)", ACT_MODE_DEBUG);
               }
               else
               {
                  DT_PRINTF("Actualisation : debug mode disabled (0x%02X)", ACT_MODE_DEBUG);
               }

               if (BitMaskTst(value, ACT_MODE_DELTA_BETA_OFF))
               {
                  DT_PRINTF("Actualisation : beta correction disabled (0x%02X)", ACT_MODE_DELTA_BETA_OFF);
               }
               else
               {
                  DT_PRINTF("Actualisation : beta correction activated (0x%02X)", ACT_MODE_DELTA_BETA_OFF);
               }

               if (BitMaskTst(value, ACT_MODE_BP_OFF))
               {
                  DT_PRINTF("Actualisation : bad pixel detection disabled (0x%02X)", ACT_MODE_BP_OFF);
               }
               else
               {
                  DT_PRINTF("Actualisation : bad pixel detection activated (0x%02X)", ACT_MODE_BP_OFF);
               }

               if (BitMaskTst(value, ACT_MODE_DYN_TST_PTRN))
               {
                  DT_PRINTF("Actualisation : dynamic test pattern is ON (0x%02X)", ACT_MODE_DYN_TST_PTRN);
               }
               else
               {
                  DT_PRINTF("Actualisation : dynamic test pattern is OFF (0x%02X)", ACT_MODE_DYN_TST_PTRN);
               }

               if (BitMaskTst(value, ACT_MODE_VERBOSE))
               {
                  DT_PRINTF("Actualisation : verbose is ON (0x%02X)", ACT_MODE_VERBOSE);
               }
               else
               {
                  DT_PRINTF("Actualisation : verbose is OFF (0x%02X)", ACT_MODE_VERBOSE);
               }

               if (BitMaskTst(value, ACT_MODE_DISCARD_OFFSET))
               {
                  DT_PRINTF("Actualisation : force discard delta beta offset is ON (0x%02X)", ACT_MODE_DISCARD_OFFSET);
               }
               else
               {
                  DT_PRINTF("Actualisation : force discard delta beta offset is OFF (0x%02X)", ACT_MODE_DISCARD_OFFSET);
               }

               break;

      case 8:
         DT_PRINTF("Cancelling current actualization");
         stopActualization();
         break;

      case 9:
         ACT_listActualizationData();
         break;

      default:
         DT_ERR("Unknown command");
         return IRC_FAILURE;
   };

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal buffering status command parser.
 * This parser is used to parse and validate buffering status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when buffering status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseBUF(circByteBuffer_t *cbuf)
{
   extern t_bufferManager gBufManager;
   t_bufferStatus status;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   BufferManager_GetStatus(&status, &gBufManager);

   DT_PRINTF("buf.write_err      = 0b%s", dec2bin(status.write_err, 4));
   DT_PRINTF("buf.read_err       = 0b%s", dec2bin(status.read_err, 4));
   //DT_PRINTF("buf.mem_ready      = %d", status.mem_ready);   //TODO: de-comment when connected in hdl
   DT_PRINTF("buf.ext_buf_prsnt  = %d", status.ext_buf_prsnt);

   return IRC_SUCCESS;
}

/**
 * Debug terminal list files command parser.
 * This parser is used to print UFFS mounting point file list.
 *
 * @return IRC_SUCCESS when list files command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseLS(circByteBuffer_t *cbuf)
{
   uint8_t argStr[6];
   uint32_t arglen;
   fileList_t *fileList = NULL;
   uffs_DIR *dp;
   struct uffs_dirent *ep;
   struct uffs_stat filestat;
   long spaceTotal, spaceUsed, spaceFree;
   char filename[FM_LONG_FILENAME_SIZE];
   uint32_t i;

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read file list value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid file list value.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      if (strcasecmp((char *)argStr, "FILE") == 0)
      {
         fileList = &gFM_files;
      }
      else if (strcasecmp((char *)argStr, "COL") == 0)
      {
         fileList = &gFM_collections;
      }
      else if (strcasecmp((char *)argStr, "BLOCK") == 0)
      {
         fileList = &gFM_calibrationBlocks;
      }
      else if (strcasecmp((char *)argStr, "NL") == 0)
      {
         fileList = &gFM_nlBlocks;
      }
      else if (strcasecmp((char *)argStr, "ICU") == 0)
      {
         fileList = &gFM_icuBlocks;
      }
      else if (strcasecmp((char *)argStr, "ACT") == 0)
      {
         fileList = &gFM_calibrationActualizationFiles;
      }
      else
      {
         DT_ERR("Unknown file list value.");
         return IRC_FAILURE;
      }
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   if (fileList == NULL)
   {
      dp = uffs_opendir(FM_UFFS_MOUNT_POINT);
      if (dp != NULL)
      {
         i = 0;
         while ((ep = uffs_readdir(dp)) != NULL)
         {
            sprintf(filename, "%s%s", FM_UFFS_MOUNT_POINT, ep->d_name);
            uffs_stat(filename, &filestat);
            DT_PRINTF("%3d: %s (%d)", i++, ep->d_name, filestat.st_size);
         }
         DT_PRINTF("%d file(s)", i);

         uffs_closedir(dp);
      }
      else
      {
         DT_ERR("List failed.");
         return IRC_FAILURE;
      }
   }
   else
   {
      for (i = 0; i < fileList->count; i++)
      {
         DT_PRINTF("%3d: %s (%d)", i, fileList->item[i]->name, fileList->item[i]->size);
      }
      DT_PRINTF("%d file(s)", fileList->count);
   }

   if ((fileList == NULL) || (fileList == &gFM_files))
   {
      spaceTotal = uffs_space_total(FM_UFFS_MOUNT_POINT);
      spaceUsed = uffs_space_used(FM_UFFS_MOUNT_POINT);
      spaceFree = uffs_space_free(FM_UFFS_MOUNT_POINT);

      DT_PRINTF("Space used = %d / %d (free = %d / %d)", spaceUsed, spaceTotal, spaceFree, spaceTotal);
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal Remove File command parser.
 * This parser is used to parse and validate Remove File command arguments and to
 * execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Remove File command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseRM(circByteBuffer_t *cbuf)
{
   uint32_t arglen;
   char filename[FM_LONG_FILENAME_SIZE];
   int retval;

   // Read filename
   strcpy(filename, FM_UFFS_MOUNT_POINT);
   arglen = GetNextArg(cbuf, (uint8_t *)&filename[FM_UFFS_MOUNT_POINT_SIZE], F1F2_FILE_NAME_SIZE);
   if (arglen == 0)
   {
      DT_ERR("Empty file name.");
      return IRC_FAILURE;
   }

   // Add string terminator (null char)
   filename[FM_UFFS_MOUNT_POINT_SIZE + arglen] = '\0';

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Protect flash dynamic values file
   if (strcmp(filename, FM_UFFS_MOUNT_POINT FDV_FILENAME) == 0)
   {
      DT_ERR("%s is protected.", filename);
      return IRC_FAILURE;
   }

   retval = uffs_remove(filename);
   if (retval == -1)
   {
      DT_ERR("Failed to remove %s.", filename);
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal File Order command parser.
 * This parser is used to parse and validate File Order command arguments and to
 * execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when File Order command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFO(circByteBuffer_t *cbuf)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   uint8_t argStr[6];
   uint32_t arglen;
   fileList_t *fileList;
   uint32_t keyCount;
   fileOrder_t keys[FM_MAX_NUM_FILE_ORDER_KEY];
   uint32_t i;

   const char *strKeys[FO_COUNT] = {
         "NONE",
         "POSIX",
         "TYPE",
         "NAME",
         "CTYPE",
         "FW",
         "NDF",
         "LENS"
   };

   // Read file list value
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid file list value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "FILE") == 0)
   {
      fileList = &gFM_files;
   }
   else if (strcasecmp((char *)argStr, "COL") == 0)
   {
      fileList = &gFM_collections;
   }
   else if (strcasecmp((char *)argStr, "BLOCK") == 0)
   {
      fileList = &gFM_calibrationBlocks;
   }
   else if (strcasecmp((char *)argStr, "NL") == 0)
   {
      fileList = &gFM_nlBlocks;
   }
   else if (strcasecmp((char *)argStr, "ICU") == 0)
   {
      fileList = &gFM_icuBlocks;
   }
   else if (strcasecmp((char *)argStr, "ACT") == 0)
   {
      fileList = &gFM_calibrationActualizationFiles;
   }
   else
   {
      DT_ERR("Unknown file list value.");
      return IRC_FAILURE;
   }

   memset(keys, 0, sizeof(keys));
   keyCount = 0;
   while (!DebugTerminal_CommandIsEmpty(cbuf) && (keyCount < FM_MAX_NUM_FILE_ORDER_KEY))
   {
      // Read file order key value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid file order key value.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      for (i = 0; i < FO_COUNT; i++)
      {
         if (strcasecmp((char *)argStr, strKeys[i]) == 0)
         {
            keys[keyCount++] = i;
            break;
         }
      }

      if (i == FO_COUNT)
      {
         DT_ERR("Unknown file order key value.");
         return IRC_FAILURE;
      }
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   if (keyCount > 0)
   {
      // Update file list file order keys and sort it
      FM_SetFileListKeys(fileList, keys, keyCount);

      // Fill remaining file order keys
      keyCount = fileList->keyCount;
      while (keyCount < FM_MAX_NUM_FILE_ORDER_KEY)
      {
         keys[keyCount++] = FO_NONE;
      }

      // Update flash dynamic values
      if (fileList == &gFM_files)
      {
         gFlashDynamicValues.FileOrderKey1 = keys[0];
         gFlashDynamicValues.FileOrderKey2 = keys[1];
         gFlashDynamicValues.FileOrderKey3 = keys[2];
         gFlashDynamicValues.FileOrderKey4 = keys[3];
         FlashDynamicValues_Update(&gFlashDynamicValues);
      }
      else if (fileList == &gFM_collections)
      {
         gFlashDynamicValues.CalibrationCollectionFileOrderKey1 = keys[0];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey2 = keys[1];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey3 = keys[2];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey4 = keys[3];
         FlashDynamicValues_Update(&gFlashDynamicValues);
      }
   }
   else
   {
      FPGA_PRINTF("DT: File order keys (%d):", fileList->keyCount);
      for (i = 0; i < fileList->keyCount; i++)
      {
         PRINTF(" %s", strKeys[fileList->keys[i]]);
      }
      PRINTF("\n");
   }

   return IRC_SUCCESS;
}

/**
 * Loopback command parser.
 * This parser is used to parse and validate Loopback command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Loopback command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseLB(circByteBuffer_t *cbuf)
{
   extern ctrlIntf_t gCtrlIntf_NTxMini;
   extern ctrlIntf_t gCtrlIntf_OEM;
   extern ctrlIntf_t gCtrlIntf_CameraLink;
   extern ctrlIntf_t gCtrlIntf_FileManager;
   ctrlIntf_t *p_ctrlIntf;
   uint8_t argStr[7];
   uint32_t arglen;
   uint32_t loopback;

   // Read port value
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid port value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "CLINK") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_CameraLink;
   }
   else if (strcasecmp((char *)argStr, "PLEORA") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_NTxMini;
   }
   else if (strcasecmp((char *)argStr, "OEM") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_OEM;
   }
   else if (strcasecmp((char *)argStr, "USART") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_FileManager;
   }
   else
   {
      DT_ERR("Unknown port value.");
      return IRC_FAILURE;
   }

   // Read loopback value
   arglen = GetNextArg(cbuf, argStr, 6);
   if ((ParseNumArg((char *)argStr, arglen, &loopback) != IRC_SUCCESS) ||
         ((loopback != 0) && (loopback != 1)))
   {
      DT_ERR("Invalid logical value.");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Validate control interface link type
   if (p_ctrlIntf->linkType != CILT_USART)
   {
      DT_ERR("Loopback feature is only supported for USART link.");
      return IRC_FAILURE;
   }

   ((usart_t*)p_ctrlIntf->p_link)->loopback = loopback;

   return IRC_SUCCESS;
}

/**
 * Show Bytes command parser.
 * This parser is used to parse and validate Show Bytes command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Show Bytes command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseSB(circByteBuffer_t *cbuf)
{
   extern ctrlIntf_t gCtrlIntf_NTxMini;
   extern ctrlIntf_t gCtrlIntf_OEM;
   extern ctrlIntf_t gCtrlIntf_CameraLink;
   extern ctrlIntf_t gCtrlIntf_FileManager;
   extern ctrlIntf_t gCtrlIntf_OutputFPGA;
   ctrlIntf_t *p_ctrlIntf;
   uint8_t argStr[7];
   uint32_t arglen;
   uint32_t showBytes;

   // Read port value
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid port value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "CLINK") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_CameraLink;
   }
   else if (strcasecmp((char *)argStr, "PLEORA") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_NTxMini;
   }
   else if (strcasecmp((char *)argStr, "OEM") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_OEM;
   }
   else if (strcasecmp((char *)argStr, "USART") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_FileManager;
   }
   else if (strcasecmp((char *)argStr, "OUTPUT") == 0)
   {
      p_ctrlIntf = &gCtrlIntf_OutputFPGA;
   }
   else
   {
      DT_ERR("Unknown port value.");
      return IRC_FAILURE;
   }

   // Read show bytes value
   arglen = GetNextArg(cbuf, argStr, 6);
   if ((ParseNumArg((char *)argStr, arglen, &showBytes) != IRC_SUCCESS) ||
         ((showBytes != 0) && (showBytes != 1)))
   {
      DT_ERR("Invalid logical value.");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   p_ctrlIntf->showBytes = showBytes;

   return IRC_SUCCESS;
}

/**
 * LED command parser.
 * This parser is used to parse and validate LED command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when LED command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseLED(circByteBuffer_t *cbuf)
{
   extern uint32_t gTestLed;
   extern DeviceLedIndicatorState_t gTestLedState;
   uint8_t argStr[9];
   uint32_t arglen;
   uint32_t testLed;
   DeviceLedIndicatorState_t testLedState;

   // Read LED color value
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid LED state value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "AUTO") == 0)
   {
      testLed = 0;
      testLedState = DLIS_Error;
   }
   else if (strcasecmp((char *)argStr, "ERR") == 0)
   {
      testLed = 1;
      testLedState = DLIS_Error;
   }
   else if (strcasecmp((char *)argStr, "WARN") == 0)
   {
      testLed = 1;
      testLedState = DLIS_Warning;
   }
   else if (strcasecmp((char *)argStr, "STBY") == 0)
   {
      testLed = 1;
      testLedState = DLIS_Standby;
   }
   else if (strcasecmp((char *)argStr, "WARNSTRM") == 0)
   {
      testLed = 1;
      testLedState = DLIS_WarningWhileStreaming;
   }
   else if (strcasecmp((char *)argStr, "STRM") == 0)
   {
      testLed = 1;
      testLedState = DLIS_Streaming;
   }
   else if (strcasecmp((char *)argStr, "BUSY") == 0)
   {
      testLed = 1;
      testLedState = DLIS_Busy;
   }
   else if (strcasecmp((char *)argStr, "RDY") == 0)
   {
      testLed = 1;
      testLedState = DLIS_Ready;
   }
   else
   {
      DT_ERR("Unknown LED state value.");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   gTestLed = testLed;
   gTestLedState = testLedState;

   return IRC_SUCCESS;
}

/**
 * Debug terminal get GPS data command parser.
 * This parser is used to parse and validate get GPS data command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when GPS data command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseGPS(circByteBuffer_t *cbuf)
{
   extern t_GPS Gps_struct;
   extern struct tm rTClock;
   extern t_Trig gTrig;
   uint8_t argStr[2];
   uint32_t arglen;
   uint32_t showNMEA;


   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read show packet value
      arglen = GetNextArg(cbuf, argStr, 1);
      if ((ParseNumArg((char *)argStr, arglen, &showNMEA) != IRC_SUCCESS) ||
            ((showNMEA != 0) && (showNMEA != 1)))
      {
         DT_ERR("Invalid logical value.");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      Gps_struct.showNMEA = showNMEA;
   }

   switch(Gps_struct.GpsStatus)
   {
      case GPS_NOTDETECTED:
         DT_PRINTF("Status: No GPS detected");
         break;

      case GPS_PRESENT:
         DT_PRINTF("Status: Detected & decoding...");
         break;

      case GPS_GOOD_COMM:
         DT_PRINTF("Status: Good");
         DT_PRINTF("Number of satellite: %d", gcRegsData.GPSNumberOfSatellitesInUse);
         DT_PRINTF("Mode: %C", Gps_struct.ModeIndicator);
         if ((gcRegsData.TimeSource == TS_GPS) && TRIG_PpsTimeOut(&gTrig))
         {
            DT_PRINTF("PPS: Lost");
         }
         else
         {
            DT_PRINTF("PPS: OK");
         }
         DT_PRINTF("UTC Time:  %02d:%02d:%02d  %02d/%02d/%4d", rTClock.tm_hour, rTClock.tm_min, rTClock.tm_sec,
               rTClock.tm_mon + 1, rTClock.tm_mday, rTClock.tm_year + 1900);
         DT_PRINTF("Latitude:  %d?\%d'%d\" %C", Gps_struct.Latitude.degrees, Gps_struct.Latitude.minutes, Gps_struct.Latitude.frac_minutes, Gps_struct.Latitude.Hemisphere);
         DT_PRINTF("Longitude: %d?\%d'%d\" %C", Gps_struct.Longitude.degrees, Gps_struct.Longitude.minutes, Gps_struct.Longitude.frac_minutes, Gps_struct.Longitude.Hemisphere);
         DT_PRINTF("Altitude:  %d,%d m", Gps_struct.Altitude, Gps_struct.Altitude_frac);
         break;

      case GPS_BAD_COMM:
         DT_PRINTF("Status: Bad data format or baud rate");
         break;

      case GPS_LOST:
         DT_PRINTF("Status: Lost");
         break;

      default:
         break;
   }
   DT_PRINTF("Error flags: %d", Gps_struct.ErrFlags);

   switch (gcRegsData.TimeSource)
   {
      case TS_InternalRealTimeClock:
         DT_PRINTF("Time source: RTC");
         break;

      case TS_GPS:
         DT_PRINTF("Time source: GPS");
         break;

      case TS_IRIGB:
         DT_PRINTF("Time source: IRIGB");
         break;
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal get version command parser.
 * This parser is used to parse and validate get version command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when get version command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseVER(circByteBuffer_t *cbuf)
{
   extern releaseInfo_t gReleaseInfo;

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   ReleaseInfo_Print(&gReleaseInfo);
   return IRC_SUCCESS;
}

/**
 * Debug terminal unlock camera command parser.
 * This parser is used to parse and validate unlock camera command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when unlock camera command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseUNLOCK(circByteBuffer_t *cbuf)
{
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   GC_UnlockCamera();
   return IRC_SUCCESS;
}

/**
 * Debug terminal format file system command parser.
 * This parser is used to parse and validate format file system command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when format file system command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFORMAT(circByteBuffer_t *cbuf)
{
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   FM_Format();
   return IRC_SUCCESS;
}

/**
 * Flash read and write test.
 * This parser is used to test flash reading and writing.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when flash test read write command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFRW(circByteBuffer_t *cbuf)
{
   int fd;
   char testfilename[] = FM_UFFS_MOUNT_POINT"TelopsFlashTest.bin";
   struct uffs_stat filestat;
   const uint32_t fileSize = 1024 * 1024;
   uint32_t counter;
   uint32_t counterMax;
   uint32_t data;
   uint32_t progressStep;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINT("Performing flash read and write test...");

   counterMax = fileSize / sizeof(counter); // 1 MB
   progressStep = counterMax / 50;

   FPGA_PRINT("DT: Writing flash test file");
   fd = uffs_open(testfilename, UO_WRONLY | UO_CREATE | UO_TRUNC);
   if (fd == -1)
   {
      DT_ERR("\nFailed to open %s for writing.", testfilename);
      return IRC_SUCCESS;
   }

   for (counter = 0; counter < counterMax;  counter++)
   {
      if (uffs_write(fd, &counter, sizeof(counter)) != sizeof(counter))
      {
         DT_ERR("\nFile write failed (counter = %d).", counter);
         return IRC_SUCCESS;
      }
      if (counter % progressStep == 0) PRINT(".");
   }
   PRINT("\n");

   if (uffs_close(fd) == -1)
   {
      DT_ERR("Failed to close %s.", testfilename);
      return IRC_SUCCESS;
   }

   DT_PRINT("Flash test file writing succeeded.");

   DT_PRINT("Reading flash test file size...");
   if (uffs_stat(testfilename, &filestat) == -1)
   {
      DT_ERR("Failed to get file stat.");
      return IRC_SUCCESS;
   }

   DT_PRINTF("Flash test file size is %d bytes.", filestat.st_size);

   if (filestat.st_size != fileSize)
   {
      DT_ERR("Flash test file size mismatch.");
      return IRC_SUCCESS;
   }

   FPGA_PRINT("DT: Reading flash test file");
   fd = uffs_open(testfilename, UO_RDONLY);
   if (fd == -1)
   {
      DT_ERR("\nFailed to open %s for reading.", testfilename);
      return IRC_SUCCESS;
   }

   for (counter = 0; counter < counterMax;  counter++)
   {
      if (uffs_read(fd, &data, sizeof(data)) != sizeof(data))
      {
         DT_ERR("\nFile read failed (counter = %d).", counter);
         return IRC_SUCCESS;
      }

      if (data != counter)
      {
         DT_ERR("\nData mismatch (counter = %d).", counter);
         return IRC_SUCCESS;
      }
      if (counter % progressStep == 0) PRINT(".");
   }
   PRINT("\n");

   if (uffs_close(fd) == -1)
   {
      DT_ERR("Failed to close %s.", testfilename);
      return IRC_SUCCESS;
   }

   DT_PRINT("Flash test file reading succeeded.");

   DT_PRINT("Removing flash test file...");
   if (uffs_remove(testfilename) == -1)
   {
      DT_ERR("Failed to remove %s.", testfilename);
      return IRC_SUCCESS;
   }

   DT_PRINT("Removing flash test file succeeded.");

   DT_PRINT("Flash read and write test succeeded.");

   return IRC_SUCCESS;
}

/**
 * DDR read and write test.
 * This parser is used to test DDR reading and writing.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when DDR test read write command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseMRW(circByteBuffer_t *cbuf)
{
   uint8_t *p_ddrTestBuffer = (uint8_t *) XPAR_MIG_CALIBRATION_CAL_DDR_MIG_BASEADDR;
   uint32_t bufferSize = PROC_MEM_PIXEL_DATA_SIZE + PROC_MEM_USART_RXBUFFER_SIZE + PROC_MEM_DELTA_BETA_SIZE;
   uint32_t i;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_INF("Performing DDR memory read and write test...");

   DT_INF("Writing %d bytes to DDR memory @ 0x%08X...", bufferSize, p_ddrTestBuffer);
   for (i = 0; i < bufferSize; i++)
   {
      p_ddrTestBuffer[i] = (i & 0x000000FF);
   }

   DT_INF("Reading %d bytes from DDR memory @ 0x%08X...", bufferSize, p_ddrTestBuffer);
   for (i = 0; i < bufferSize; i++)
   {
      if (p_ddrTestBuffer[i] != (i & 0x000000FF))
      {
         DT_ERR("Failed to read byte @ 0x%08X (%d read, %d expected)", &p_ddrTestBuffer[i], p_ddrTestBuffer[i], i);
         return IRC_SUCCESS;
      }
   }

   DT_INF("DDR memory read and write test succeeded.");

   return IRC_SUCCESS;
}

/**
 * Debug terminal reset camera command parser.
 * This parser is used to parse and validate reset camera command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when reset camera command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseRST(circByteBuffer_t *cbuf)
{
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   Power_CameraReset();
   return IRC_SUCCESS;
}

/**
 * Debug terminal power command parser.
 * This parser is used to parse and validate power command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when power command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParsePWR(circByteBuffer_t *cbuf)
{
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   Power_ToggleDevicePowerState();
   return IRC_SUCCESS;
}

/**
 * Debug terminal disable filter wheel command parser.
 * This parser is used to parse and validate disable filter wheel command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when disable filter wheel command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseDFW(circByteBuffer_t *cbuf)
{
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   gDisableFilterWheel = 1;
   FM_InitFileDB(); // this will re-scan the flash for files and reload the flashSettings
   if (gFM_collections.count > 0)
      Calibration_LoadCalibrationFilePOSIXTime(gFM_collections.item[0]->posixTime);

   return IRC_SUCCESS;
}

/**
 * Device Key command parser.
 * This parser is used to parse and validate Device Key command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Device Key command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseKEY(circByteBuffer_t *cbuf)
{
   extern flashDynamicValues_t gFlashDynamicValues;
   uint8_t argStr[6];
   uint32_t arglen;

   // Check for key command argument presence
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read key command argument
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid key command argument.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      if (strcasecmp((char *)argStr, "RENEW") == 0)
      {
         DeviceKey_Renew(&gFlashDynamicValues, &gcRegsData);
         BuiltInTest_Execute(BITID_DeviceKeyValidation);
      }
      else if (strcasecmp((char *)argStr, "RESET") == 0)
      {
         DeviceKey_Reset(&gFlashDynamicValues, &gcRegsData);
         BuiltInTest_Execute(BITID_DeviceKeyValidation);
      }
      else
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }
   }

   DT_PRINTF("Device key:            0x%08X%08X", flashSettings.DeviceKeyHigh, flashSettings.DeviceKeyLow);
   DT_PRINTF("Device key validation: 0x%08X%08X (%s)", gcRegsData.DeviceKeyValidationHigh, gcRegsData.DeviceKeyValidationLow,
         (builtInTests[BITID_DeviceKeyValidation].result == BITR_Passed)? "Passed" : "Failed");
   DT_PRINTF("Device key expiration: %d%d (0x%08X)", flashSettings.DeviceKeyExpirationPOSIXTime / 10,
         flashSettings.DeviceKeyExpirationPOSIXTime % 10, flashSettings.DeviceKeyExpirationPOSIXTime);

   return IRC_SUCCESS;
}

/**
 * Get/Set GenICAm Poller State command parser.
 * This parser is used to parse and validate Get/Set GenICAm Poller State command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Get/Set GenICAm Poller State command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseGCP(circByteBuffer_t *cbuf)
{
   uint8_t argStr[2];
   uint32_t arglen;
   uint32_t gcpState;

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read GenICam poller state
      arglen = GetNextArg(cbuf, argStr, 1);
      if ((ParseNumArg((char *)argStr, arglen, &gcpState) != IRC_SUCCESS) ||
            ((gcpState != 0) && (gcpState != 1)))
      {
         DT_ERR("Invalid logical value.");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      if (gcpState == 1)
      {
         GC_Poller_Start();
      }
      else
      {
         GC_Poller_Stop();
      }
   }

   DT_PRINTF("GCP state: %s", (GC_Poller_IsActive() == 1)? "STARTED":"STOPPED");

   return IRC_SUCCESS;
}

/**
 * Get/Set ADC readout calibration command parser.
 * This parser is used to parse and validate Get/Set ADC readout calibration command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Get/Set ADC readout calibration command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParseADC(circByteBuffer_t *cbuf)
{
   uint8_t argStr[10];
   uint32_t arglen;
   float adc_m;
   int32_t adc_b;

   // Check for ADC command argument presence
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read ADC command m argument
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (ParseFloatNumDec((char *)argStr, arglen, &adc_m) != IRC_SUCCESS)
      {
         DT_ERR("Invalid ADC command m argument.");
         return IRC_FAILURE;
      }

      // Read ADC command b argument
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if ((ParseSignedNumDec((char *)argStr, arglen, &adc_b) != IRC_SUCCESS) ||
            ((adc_b < SHRT_MIN) && (adc_b > SHRT_MAX)))
      {
         DT_ERR("Invalid ADC command b argument.");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments.");
         return IRC_FAILURE;
      }

      if (TDCFlagsTst(ADCReadoutIsImplementedMask))
      {
         flashSettings.ADCReadout_m = adc_m;
         flashSettings.ADCReadout_b = adc_b;

         if (ADC_readout_init(&flashSettings) != IRC_SUCCESS)
         {
            DT_ERR("Failed to update ADC calibration.");
            return IRC_FAILURE;
         }
      }
   }

   if (!TDCFlagsTst(ADCReadoutIsImplementedMask))
   {
      DT_ERR("ADC readout is disabled.");
      return IRC_FAILURE;
   }

   DT_PRINTF("ADC: enabled = %d, m = " _PCF(6) ", b = %d\n", flashSettings.ADCReadoutEnabled, _FFMT(flashSettings.ADCReadout_m, 6), flashSettings.ADCReadout_b);

   return IRC_SUCCESS;
}

/**
 * Disable Flash Dynamic Values Update command parser.
 * This parser is used to parse and validate Disable Flash Dynamic Values Update command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Disable Flash Dynamic Values Update command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParseDFDVU(circByteBuffer_t *cbuf)
{
   extern uint8_t gDisableFlashDynamicValuesUpdate;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   gDisableFlashDynamicValuesUpdate = 1;

   DT_PRINTF("Flash dynamic values update has been disabled.");

   return IRC_SUCCESS;
}

/**
 * Flash Settings command parser.
 * This parser is used to parse and validate Flash Settings command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Flash Settings command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParseFS(circByteBuffer_t *cbuf)
{
   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Print flash settings
   FlashSettings_PrintFlashSettingsFileHeader(&flashSettings);

   return IRC_SUCCESS;
}

/**
 * Debug Terminal Output command parser.
 * This parser is used to parse and validate Debug Terminal Output command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Flash Settings command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParseDTO(circByteBuffer_t *cbuf)
{
   uint8_t argStr[6];
   uint32_t arglen;
   DeviceSerialPortSelector_t port;

   // Read port value
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid port value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "CLINK") == 0)
   {
      port = DSPS_CameraLink;
   }
   else if (strcasecmp((char *)argStr, "OEM") == 0)
   {
      port = DSPS_RS232;

   }
   else if (strcasecmp((char *)argStr, "USB") == 0)
   {
      port = DSPS_USB;
   }
   else
   {
      DT_ERR("Unknown port value.");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DeviceSerialPortFunctionAry[port] = DSPF_Terminal;
   GC_SetDeviceSerialPortFunction(port);

   DT_PRINTF("Debug terminal output set to %s.", argStr);

   return IRC_SUCCESS;
}

/**
 * Debug terminal Help command parser parser.
 * This parser is used to print debug terminal help.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t DebugTerminalParseHLP(circByteBuffer_t *cbuf)
{
   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINTF("Debug terminal commands:");
   DT_PRINTF("  Read memory:        RDM address [c|u8|u16|u32|s8|s16|s32 length]");
   DT_PRINTF("  Write memory:       WRM address value");
   DT_PRINTF("  FPA status:         FPA [POL|REF|OFF value]");
   DT_PRINTF("  HDER status:        HDER");
   DT_PRINTF("  CAL status:         CAL");
   DT_PRINTF("  TRIG status:        TRIG");
   DT_PRINTF("  Buffering status:   BUF");
   DT_PRINTF("  Camera status:      STATUS");
   DT_PRINTF("  Power status:       POWER");
   DT_PRINTF("  Network status:     NET [0|1 [port]]");
   DT_PRINTF("  Actualization:      ACT DBG|RST|INV|CLR|ICU|XBB|AEC|CFG|STP|LST");
   DT_PRINTF("  List files:         LS [FILE|COL|BLOCK|NL|ICU|ACT]");
   DT_PRINTF("  Remove file:        RM filename");
   DT_PRINTF("  File order:         FO FILE|COL|BLOCK|NL|ICU|ACT [NONE|POSIX|TYPE|NAME|CTYPE|FW|NDF|LENS]");
   DT_PRINTF("  Loopback:           LB CLINK|PLEORA|OEM|USART 0|1");
   DT_PRINTF("  Show bytes:         SB CLINK|PLEORA|OEM|USART|OUTPUT 0|1");
   DT_PRINTF("  Set led state:      LED AUTO|ERR|WARN|STBY|WARNSTRM|STRM|BUSY|RDY");
   DT_PRINTF("  GPS status:         GPS [0|1]");
   DT_PRINTF("  Print version:      VER");
   DT_PRINTF("  Unlock camera:      UNLOCK");
   DT_PRINTF("  Format FS:          FORMAT");
   DT_PRINTF("  Flash R/W test:     FRW");
   DT_PRINTF("  DDR R/W test:       MRW");
   DT_PRINTF("  Reset:              RST");
   DT_PRINTF("  Power:              PWR");
   DT_PRINTF("  Disable/ignore FW:  DFW");
   DT_PRINTF("  Device key:         KEY [RENEW]");
   DT_PRINTF("  Get Stack Level:    STACK");
   DT_PRINTF("  Set GCP state:      GCP [0|1]");
   DT_PRINTF("  ADC calibration:    ADC [m b]");
   DT_PRINTF("  Flash Settings:     FS");
   DT_PRINTF("  Debug Term. Output: DTO [CLINK|OEM|USB]");
   DT_PRINTF("  Print help:         HLP");

   /*
   Hidden commands:
      Reset device key:    KEY RESET
      Disable FDV update:  DFDVU
   */

   return IRC_SUCCESS;
}

