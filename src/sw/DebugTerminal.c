/**
 * @file DebugTerminal.c
 *  Debug terminal module implementation.
 *  
 *  This file implements the debug terminal module.
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
#include "GC_Registers.h"
#include "xparameters.h"
#include "xuartns550.h"
#include "FPA_intf.h"
#include "hder_inserter.h"
#include "calib.h"
#include "Utils.h"
#include "Actualization.h"
#include "BufferManager.h"
#include "FileManager.h"
#include "power_ctrl.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "FlashSettings.h"
#include "proc_init.h"
#include "proc_memory.h"
#include "GPS.h"
#include "trig_gen.h"
#include "DeviceKey.h"
#include <string.h>
#include <time.h>

static IRC_Status_t DebugTerminalParser(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseRDM(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseWRM(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFPA(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParsePOL(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseHDER(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseCAL(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseSTATUS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParsePOWER(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseNET(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseACT(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseRM(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLB(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseSB(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLED(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseGPS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFRW(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseMRW(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseHLP(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseBUF(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseKEY(circByteBuffer_t *cbuf);
static uint16_t GetNextArg(circByteBuffer_t *cbuf, uint8_t *buffer, uint16_t buflen);
static IRC_Status_t ParseNumArg(char *str, uint8_t length, uint32_t *value);
static IRC_Status_t ParseNumHex(char *str, uint8_t length, uint32_t *value);
static IRC_Status_t ParseNumDec(char *str, uint8_t length, uint32_t *value);
static IRC_Status_t ParseSignedNumDec(char *str, uint8_t length, int32_t *value);


bool gDisableFilterWheel = false;

/**
 * Debug terminal UART device
 */
XUartNs550 debugTerminalDevice;


/**
 * Initialize debug terminal UART.
 *
 * @param uartDeviceId is the debug terminal UART device ID that can be found in xparameters.h file.
 *
 * @return IRC_SUCCESS when debug terminal successfully initialized.
 * @return IRC_FAILURE when debug terminal failed to initialize.
 */
IRC_Status_t DebugTerminal_Init()
{
   extern XUartNs550_Config XUartNs550_ConfigTable[];
   uint16_t uartDeviceId;
   XUartNs550Format uartFormat;
   XStatus status;
   uint32_t i;

   /*
    * Search for STDIN/STDOUT device
    */
   for (i = 0; i < XPAR_XUARTNS550_NUM_INSTANCES; i++)
   {
      if ((XUartNs550_ConfigTable[i].BaseAddress == STDIN_BASEADDRESS) &&
            (XUartNs550_ConfigTable[i].BaseAddress == STDOUT_BASEADDRESS))
      {
         uartDeviceId = XUartNs550_ConfigTable[i].DeviceId;
         break;
      }
   }

   if (i == XPAR_XUARTNS550_NUM_INSTANCES)
   {
      // Cannot find STDOUT device
      return IRC_FAILURE;
   }

   /*
    * Initialize the debug terminal UART driver.
    */
   status = XUartNs550_Initialize(&debugTerminalDevice, uartDeviceId);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /*
    * Perform a self-test to ensure that the hardware was built correctly.
    */
   status = XUartNs550_SelfTest(&debugTerminalDevice);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Set UART device data format
   uartFormat.BaudRate = 115200;
   uartFormat.DataBits = XUN_FORMAT_8_BITS;
   uartFormat.Parity = XUN_FORMAT_NO_PARITY;
   uartFormat.StopBits = XUN_FORMAT_1_STOP_BIT;

   status = XUartNs550_SetDataFormat(&debugTerminalDevice, &uartFormat);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Flush Rx FIFO
   while (XUartNs550_IsReceiveData(debugTerminalDevice.BaseAddress))
   {
      XUartNs550_ReadReg(debugTerminalDevice.BaseAddress, XUN_RBR_OFFSET);
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal state machine.

\dot
digraph G {
   DT_INIT -> DT_RUNNING
}
\enddot

 */
void DebugTerminal_SM()
{
   static debugTerminalState_t debugTerminalState = DT_INIT;
   static uint8_t debugTerminalBuffer[DT_BUFFER_SIZE];
   static circByteBuffer_t cbuf;
   uint8_t byte;

   switch (debugTerminalState)
   {
      case DT_INIT:
         if (debugTerminalDevice.IsReady == XIL_COMPONENT_IS_READY)
         {
            // Initialize circular buffer
            CBB_Init(&cbuf, debugTerminalBuffer, DT_BUFFER_SIZE);

            debugTerminalState = DT_RUNNING;
         }
         else
         {
            // The following message might be transmitted at 9600bps since the UART device is not initialized yet.
            DT_ERR("Debug terminal UART device is not initialized.");
         }
         break;

      case DT_RUNNING:
         while (XUartNs550_IsReceiveData(debugTerminalDevice.BaseAddress) && !CBB_Full(&cbuf))
         {
            byte = XUartNs550_ReadReg(debugTerminalDevice.BaseAddress, XUN_RBR_OFFSET);
            if ((byte == 0x0A) || (byte == 0x0D))
            {
               if (CBB_Length(&cbuf) > 0)
               {
                  if (DebugTerminalParser(&cbuf) != IRC_SUCCESS)
                  {
                     CBB_Flush(&cbuf);
                  }
               }
            }
            else
            {
               CBB_Push(&cbuf, byte);
            }
         }
         break;
   }
}

/**
 * Debug terminal command parser.
 * This general command parser is used to parse and validate command mnemonic.
 * It also calls command parsers related to command mnemonic.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when debug terminal command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParser(circByteBuffer_t *cbuf)
{
   static uint8_t debugTerminalUnlocked = 0;
   extern releaseInfo_t gReleaseInfo;
   uint8_t cmdStr[7];
   uint32_t cmdlen;

   cmdlen = GetNextArg(cbuf, cmdStr, 6);
   cmdStr[cmdlen++] = '\0'; // Add string terminator

   if (debugTerminalUnlocked == 1)
   {
      if (strcasecmp((char *)cmdStr, "RDM") == 0)
      {
         return DebugTerminalParseRDM(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "WRM") == 0)
      {
         return DebugTerminalParseWRM(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "FPA") == 0)
      {
         return DebugTerminalParseFPA(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "POL") == 0)
      {
         return DebugTerminalParsePOL(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "HDER") == 0)
      {
         return DebugTerminalParseHDER(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "CAL") == 0)
      {
         return DebugTerminalParseCAL(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "STATUS") == 0)
      {
         return DebugTerminalParseSTATUS(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "POWER") == 0)
      {
         return DebugTerminalParsePOWER(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "NET") == 0)
      {
         return DebugTerminalParseNET(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "ACT") == 0)
      {
         return DebugTerminalParseACT(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "BUF") == 0)
      {
         return DebugTerminalParseBUF(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "LS") == 0)
      {
         return DebugTerminalParseLS(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "RM") == 0)
      {
         return DebugTerminalParseRM(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "LB") == 0)
      {
         return DebugTerminalParseLB(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "SB") == 0)
      {
         return DebugTerminalParseSB(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "LED") == 0)
      {
         return DebugTerminalParseLED(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "GPS") == 0)
      {
         return DebugTerminalParseGPS(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "VER") == 0)
      {
         if (!CBB_Empty(cbuf))
         {
            DT_ERR("Unsupported command arguments");
            return IRC_FAILURE;
         }

         ReleaseInfo_Print(&gReleaseInfo);
         return IRC_SUCCESS;
      }
      else if (strcasecmp((char *)cmdStr, "UNLOCK") == 0)
      {
         if (!CBB_Empty(cbuf))
         {
            DT_ERR("Unsupported command arguments");
            return IRC_FAILURE;
         }

         GC_UnlockCamera();
         return IRC_SUCCESS;
      }
      else if (strcasecmp((char *)cmdStr, "FORMAT") == 0)
      {
         if (!CBB_Empty(cbuf))
         {
            DT_ERR("Unsupported command arguments");
            return IRC_FAILURE;
         }

         FM_Format();
         return IRC_SUCCESS;
      }
      else if (strcasecmp((char *)cmdStr, "FRW") == 0)
      {
         return DebugTerminalParseFRW(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "MRW") == 0)
      {
         return DebugTerminalParseMRW(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "RST") == 0)
      {
         if (!CBB_Empty(cbuf))
         {
            DT_ERR("Unsupported command arguments");
            return IRC_FAILURE;
         }

         Power_CameraReset();
         return IRC_SUCCESS;
      }
      else if (strcasecmp((char *)cmdStr, "PWR") == 0)
      {
         if (!CBB_Empty(cbuf))
         {
            DT_ERR("Unsupported command arguments");
            return IRC_FAILURE;
         }

         Power_ToggleDevicePowerState();
         return IRC_SUCCESS;
      }
      else if (strcasecmp((char *)cmdStr, "DFW") == 0)
      {
         if (!CBB_Empty(cbuf))
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
      else if (strcasecmp((char *)cmdStr, "KEY") == 0)
      {
         return DebugTerminalParseKEY(cbuf);
      }
      else if (strcasecmp((char *)cmdStr, "HLP") == 0)
      {
         return DebugTerminalParseHLP(cbuf);
      }
      else
      {
         DT_ERR("Invalid command. Type HLP for help.");
         return IRC_FAILURE;
      }
   }
   else if (strcasecmp((char *)cmdStr, "SPOLET") == 0)
   {
      debugTerminalUnlocked = 1;
      DT_PRINTF("Debug terminal unlocked!!!");
      return IRC_SUCCESS;
   }
   else
   {
      return IRC_FAILURE;
   }
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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   PRINTF("Debug terminal commands:\n");
   PRINTF("  Read memory:        RDM address [c|u8|u16|u32|s8|s16|s32 length]\n");
   PRINTF("  Write memory:       WRM address value\n");
   PRINTF("  FPA status:         FPA\n");
   PRINTF("  Polarization:       POL [detector_polarization_voltage]\n");
   PRINTF("  HDER status:        HDER\n");
   PRINTF("  CAL status:         CAL\n");
   PRINTF("  Camera status:      STATUS\n");
   PRINTF("  Power status:       POWER\n");
   PRINTF("  Network status:     NET [0|1]\n");
   PRINTF("  Actualization:      ACT DBG|RST|INV|CLR|ICU|XBB|AEC|CFG|STP\n");
   PRINTF("  List files:         LS\n");
   PRINTF("  Remove file:        RM filename\n");
   PRINTF("  Loopback:           LB CLINK|PLEORA|OEM|USART 0|1\n");
   PRINTF("  Show bytes:         SB CLINK|PLEORA|OEM|USART|OUTPUT 0|1\n");
   PRINTF("  Set led state:      LED AUTO|ERR|WARN|STBY|WARNSTRM|STRM|BUSY|RDY\n");
   PRINTF("  GPS status:         GPS [0|1]\n");
   PRINTF("  Print version:      VER\n");
   PRINTF("  Unlock camera:      UNLOCK\n");
   PRINTF("  Format FS:          FORMAT\n");
   PRINTF("  Flash R/W test:     FRW\n");
   PRINTF("  DDR R/W test:       MRW\n");
   PRINTF("  Reset:              RST\n");
   PRINTF("  Power:              PWR\n");
   PRINTF("  Buffer selection:   BUF EXT|INT (broken)\n");
   PRINTF("  Disable/ignore FW:  DFW\n");
   PRINTF("  Device key:         KEY [RENEW|RESET]\n");
   PRINTF("  Print help:         HLP\n");

   return IRC_SUCCESS;
}

/**
 * Debug terminal Read Memory command parser.
 * This parser is used to parse and validate Read Memory command arguments and to
 * execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Read Memory command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseRDM(circByteBuffer_t *cbuf)
{
   uint32_t i;
   uint32_t addr;
   uint8_t isInteger;
   uint32_t nbit;
   uint32_t length;
   uint8_t argStr[11];
   uint32_t arglen;

   // Read Address
   arglen = GetNextArg(cbuf, argStr, 10);
   if (ParseNumArg((char *)argStr, arglen, &addr) != IRC_SUCCESS)
   {
      DT_ERR("Invalid address.");
      return IRC_FAILURE;
   }

   isInteger = 1;
   nbit = 32;
   length = 1;

   // Try to read optional data type
   if (CBB_Pop(cbuf, argStr) == IRC_SUCCESS)
   {
      // Parse data type
      switch (argStr[0])
      {
         case 'c':
         case 'C':
            isInteger = 0;
            break;

         case 'u':
         case 'U':
         case 's':
         case 'S':
            isInteger = 1;
            break;

         default:
            DT_ERR("Invalid data type.");
            return IRC_FAILURE;
      }
      arglen = GetNextArg(cbuf, argStr, 2);
      if (((isInteger == 0) && (arglen > 0)) || ((isInteger == 1) && (arglen == 0)))
      {
         DT_ERR("Invalid data type.");
         return IRC_FAILURE;
      }
      if (isInteger == 1)
      {
         if (ParseNumArg((char *)argStr, arglen, &nbit) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data type.");
            return IRC_FAILURE;
         }
         if ((nbit != 8) && (nbit != 16) && (nbit != 32))
         {
            DT_ERR("Invalid data type.");
            return IRC_FAILURE;
         }
      }

      // Read data length
      arglen = GetNextArg(cbuf, argStr, 10);
      if (ParseNumArg((char *)argStr, arglen, &length) != IRC_SUCCESS)
      {
         DT_ERR("Invalid data length.");
         return IRC_FAILURE;
      }
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   if (isInteger == 0)
   {
      // Output chars
      PRINTF("DT: 0x%08X: \"", addr);
      for (i = 0; i < length; i++)
      {
         if ((*((char *)addr) >= ' ' ) && (*((char *)addr) <= '~' ))
         {
            PRINTF("%c", *((char *)addr));
         }
         else
         {
            PRINTF("[%03d]", *((uint8_t *)addr));
         }
         addr += 1;
      }
      PRINTF("\"\n");
   }
   else
   {
      // Validate address alignment
      if (((nbit == 16) && (addr % 2 != 0)) || ((nbit == 32) && (addr % 4 != 0)))
      {
         DT_ERR("Invalid address alignment.");
         return IRC_FAILURE;
      }

      // Output integers
      for (i = 0; i < length; i++)
      {
         if ( i % DT_DATA_PER_LINE == 0)
         {
            PRINTF("DT: 0x%08X: 0x", addr);
         }
         switch (nbit)
         {
            case 8:
               PRINTF("%02X ", *((uint8_t *)addr));
               break;

            case 16:
               PRINTF("%04X ", *((uint16_t *)addr));
               break;

            case 32:
               PRINTF("%08X ", *((uint32_t *)addr));
               break;
         }
         addr += (nbit / 8);

         if ( i % DT_DATA_PER_LINE == (DT_DATA_PER_LINE - 1))
         {
            PRINTF("\n");
         }
      }
      PRINTF("\n");
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal Write Memory command parser.
 * This parser is used to parse and validate Write Memory command arguments and to
 * execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Write Memory command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseWRM(circByteBuffer_t *cbuf)
{
   uint32_t addr;
   uint32_t value;
   uint8_t argStr[11];
   uint32_t arglen;

   // Read Address
   arglen = GetNextArg(cbuf, argStr, 10);
   if (ParseNumArg((char *)argStr, arglen, &addr) != IRC_SUCCESS)
   {
      DT_ERR("Invalid address.");
      return IRC_FAILURE;
   }

   // Validate address alignment
   if (addr % 4 != 0)
   {
      DT_ERR("Invalid address alignment.");
      return IRC_FAILURE;
   }

   // Read data value
   arglen = GetNextArg(cbuf, argStr, 10);
   if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
   {
      DT_ERR("Invalid data value.");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Write data to memory
   *((uint32_t *)addr) = value;

   DT_PRINTF("%d (0x%08X) has been written @ 0x%08X", value, value, addr);

   return IRC_SUCCESS;
}

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
   t_FpaStatus status;

   // There is supposed to be no remaining bytes in the buffer
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   FPA_GetStatus(&status, &gFpaIntf);

   DT_PRINTF("FPA model name = " FPA_DEVICE_MODEL_NAME);

   DT_PRINTF("FPA temperature = %dcC", FPA_GetTemperature(&gFpaIntf));

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

   return IRC_SUCCESS;
}

/**
 * Debug terminal get/set FPA polarization voltage command parser.
 * This parser is used to parse and validate get/set FPA polarization voltage
 * command arguments and to execute the command.
 *
 * @return IRC_SUCCESS whenget/set FPA polarization voltage command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParsePOL(circByteBuffer_t *cbuf)
{
   extern t_FpaIntf gFpaIntf;
   extern int16_t gFpaDetectorPolarizationVoltage;
   uint8_t argStr[12];
   uint32_t arglen;
   int32_t detPolVoltage;

   if (!CBB_Empty(cbuf))
   {
      // Detector polarization voltage
      arglen = GetNextArg(cbuf, argStr, 12);
      if ((ParseSignedNumDec((char *)argStr, arglen, &detPolVoltage) != IRC_SUCCESS) ||
            (detPolVoltage < -32768) || (detPolVoltage > 32767))
      {
         DT_ERR("Invalid int16 value.");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!CBB_Empty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      gFpaDetectorPolarizationVoltage = (int16_t)detPolVoltage;
      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
   }

   DT_PRINTF("Detector Polarization Voltage = %d", gFpaDetectorPolarizationVoltage);

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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   status = HDER_GetStatus(&gHderInserter);

   DT_PRINTF("hder status = 0x%08X", status);

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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   CAL_GetStatus(&status, &gCal);

   DT_PRINTF("cal.done = %d", status.done);
   for (i = 0; i < 5; i++)
   {
      DT_PRINTF("cal.error_set[%d] = 0x%08X", i, status.error_set[i]);
   }

   return IRC_SUCCESS;
}


IRC_Status_t DebugTerminalParseBUF(circByteBuffer_t *cbuf)
{
   extern t_bufferManager gBufManager;
   extern gcRegistersData_t gcRegsData;
   uint32_t useExternalBuffer = 1;
   uint8_t argStr[11];
   uint32_t arglen;
   uint32_t currentMode;

   arglen = GetNextArg(cbuf, argStr, 10);
   if (arglen != 3)
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   argStr[arglen++] = '\0';
   if (strcasecmp((char*)argStr, "EXT") == 0) // enable external buffer
      useExternalBuffer = 1;
   else if (strcasecmp((char*)argStr, "INT") == 0) // enable internal buffer (disable external buffer)
      useExternalBuffer = 0;
   else
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   currentMode = gcRegsData.MemoryBufferMode;

   BufferManager_ClearSequence(&gBufManager, &gcRegsData);

   GC_SetMemoryBufferMode(BM_OFF);

   if (useExternalBuffer && BufferManager_DetectExternalMemoryBuffer())
   {
      DT_PRINTF("Switching to external buffer");
      TDCFlagsSet(ExternalMemoryBufferIsImplementedMask);
      GC_SetMemoryBufferRegistersOwner(GCRO_Storage_FPGA);
   }
   else
   {
      if (useExternalBuffer)
         DT_PRINTF("External buffer is not present. Will continue with the built-in internal buffer");
      else
         DT_PRINTF("Switching to internal buffer");

      TDCFlagsClr(ExternalMemoryBufferIsImplementedMask);
      GC_SetMemoryBufferRegistersOwner(GCRO_Processing_FPGA);
   }

   GC_SetMemoryBufferMode(currentMode);

   //BufferManager_SetBufferMode(&gBufManager, currentMode, &gcRegsData);

   return BufferManager_Init(&gBufManager, &gcRegsData);
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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINTF("TDCStatus = 0x%08X", gcRegsData.TDCStatus);
   DT_PRINTF("Bit0:  WaitingForCooler =                   %d", TDCStatusTst(WaitingForCoolerMask));
   DT_PRINTF("Bit1:  WaitingForSensor =                   %d", TDCStatusTst(WaitingForSensorMask));
   DT_PRINTF("Bit2:  WaitingForInit =                     %d", TDCStatusTst(WaitingForInitMask));
   DT_PRINTF("Bit3:  Reserved =                           %d", TDCStatusTst(1L << 3));
   DT_PRINTF("Bit4:  WaitingForICU =                      %d", TDCStatusTst(WaitingForICUMask));
   DT_PRINTF("Bit5:  WaitingForNDFilter =                 %d", TDCStatusTst(WaitingForNDFilterMask));
   DT_PRINTF("Bit6:  WaitingForCalibrationInit =          %d", TDCStatusTst(WaitingForCalibrationInitMask));
   DT_PRINTF("Bit7:  WaitingForFilterWheel =              %d", TDCStatusTst(WaitingForFilterWheelMask));
   DT_PRINTF("Bit8:  WaitingForArm =                      %d", TDCStatusTst(WaitingForArmMask));
   DT_PRINTF("Bit9:  WaitingForValidParameters =          %d", TDCStatusTst(WaitingForValidParametersMask));
   DT_PRINTF("Bit10: AcquisitionStarted =                 %d", TDCStatusTst(AcquisitionStartedMask));
   DT_PRINTF("Bit11: Reserved =                           %d", TDCStatusTst(1L << 11));
   DT_PRINTF("Bit12: WaitingForCalibrationData =          %d", TDCStatusTst(WaitingForCalibrationDataMask));
   DT_PRINTF("Bit13: WaitingForCalibrationActualization = %d", TDCStatusTst(WaitingForCalibrationActualizationMask));
   DT_PRINTF("Bit14: WaitingForOutputFPGA =               %d", TDCStatusTst(WaitingForOutputFPGAMask));
   DT_PRINTF("Bit15: WaitingForPower =                    %d", TDCStatusTst(WaitingForPowerMask));
   DT_PRINTF("Bit16: WaitingForFlashSettingsInit =        %d", TDCStatusTst(WaitingForFlashSettingsInitMask));

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
   if (!CBB_Empty(cbuf))
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
 * Debug terminal get network status command parser.
 * This parser is used to parse and validate get network
 * status command arguments and to execute the command.
 *
 * @return IRC_SUCCESS when get network status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseNET(circByteBuffer_t *cbuf)
{
   extern netIntf_t gNetworkIntf;
   uint8_t argStr[2];
   uint32_t arglen;
   uint32_t showPackets;
   uint32_t i, j;

   if (!CBB_Empty(cbuf))
   {
      // Read show packet value
      arglen = GetNextArg(cbuf, argStr, 1);
      if ((ParseNumArg((char *)argStr, arglen, &showPackets) != IRC_SUCCESS) ||
            ((showPackets != 0) && (showPackets != 1)))
      {
         DT_ERR("Invalid logical value.");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!CBB_Empty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      gNetworkIntf.showPackets = showPackets;
   }

   DT_PRINTF("Address: %d", gNetworkIntf.address);
   DT_PRINTF("Routing table:");
   for (i = 0; i < NI_NUM_OF_HOSTS; i++)
   {
      if ((i + 1) != gNetworkIntf.address)
      {
         if (gNetworkIntf.routingTable[i] == NULL)
         {
            DT_PRINTF("   Host %d is unreachable.", (i + 1));
         }
         else
         {
            for (j = 0; j < gNetworkIntf.numberOfConnections; j++)
            {
               if (gNetworkIntf.routingTable[i] == gNetworkIntf.connections[j])
               {
                  DT_PRINTF("   Host %d is reachable through connection %d.", (i + 1), j);
               }
            }
         }
      }
   }

   DT_PRINTF("Command queues:");
   DT_PRINTF("   Network: %d / %d (%d)%c", gNetworkIntf.cmdQueue->length, gNetworkIntf.cmdQueue->size, gNetworkIntf.cmdQueue->maxLength,
         (gNetworkIntf.cmdQueue->maxLength == gNetworkIntf.cmdQueue->size)?'*':' ');

   for (i = 0; i < gNetworkIntf.numberOfPorts; i++)
   {
      DT_PRINTF("   Port %d:  %d / %d (%d)%c", gNetworkIntf.ports[i]->port, gNetworkIntf.ports[i]->cmdQueue->length,
            gNetworkIntf.ports[i]->cmdQueue->size, gNetworkIntf.ports[i]->cmdQueue->maxLength,
            (gNetworkIntf.ports[i]->cmdQueue->maxLength == gNetworkIntf.ports[i]->cmdQueue->size)?'*':' ');
   }

   for (i = 0; i < gNetworkIntf.numberOfConnections; i++)
   {
      DT_PRINTF("   Conn %d:  %d / %d (%d)%c", i, gNetworkIntf.connections[i]->cmdQueue->length,
            gNetworkIntf.connections[i]->cmdQueue->size, gNetworkIntf.connections[i]->cmdQueue->maxLength,
            (gNetworkIntf.connections[i]->cmdQueue->maxLength == gNetworkIntf.connections[i]->cmdQueue->size)?'*':' ');
   }

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

   arglen = GetNextArg(cbuf, argStr, 10);
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
               DT_PRINTF("using detector data for actualization");
               gActDebugOptions.useDebugData = false;
            }
            else
            {
               DT_PRINTF("using constant test pattern data for actualization");
               gActDebugOptions.useDebugData = true;
            }
         }
         break;

      case 1: // reset options
         ACT_resetDebugOptions();
         DT_PRINTF("actualization options were reset");
         break;

      case 2: // invalidate and reload
         if (TDCStatusTst(WaitingForCalibrationActualizationMask) == 0 && TDCStatusTst(AcquisitionStartedMask) == 0)
         {
            gActDeltaBetaAvailable = false;
            DT_PRINTF("current actualization was invalidated");
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
                  DT_PRINTF("will clear the buffer after actualisation");
                  gActDebugOptions.clearBufferAfterCompletion = true;
               }
               else
               {
                  DT_PRINTF("will not clear the buffer after actualisation");
                  gActDebugOptions.clearBufferAfterCompletion = false;
               }
            }
            break;

      case 4: // perform actualization using ICU
         DT_PRINTF("Triggering an actualization (icu)");
         gcRegsData.CalibrationActualizationMode = CAM_ICU;
         startActualization(false);
         break;

      case 5: // perform actualization using external BB
         DT_PRINTF("Triggering an actualization (xbb)");
         gcRegsData.CalibrationActualizationMode = CAM_BlackBody;
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
               DT_PRINTF("AEC enabled during actualisation");
               gActDebugOptions.bypassAEC = false;
            }
            else
            {
               DT_PRINTF("AEC disabled during actualisation");
               gActDebugOptions.bypassAEC = true;
            }
         }
         break;
      case 7: // CFG mode
               arglen = GetNextArg(cbuf, argStr, 10);
               if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
               {
                  DT_ERR("Invalid data length.");
                  return IRC_FAILURE;
               }
               else
               {
                  DT_PRINTF("Actualisation : mode = (0x%02X)", value);
                  gActDebugOptions.mode = value;
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
                     DT_PRINTF("Actualisation : discard delta beta offset is ON (0x%02X)", ACT_MODE_DISCARD_OFFSET);
                  }
                  else
                  {
                     DT_PRINTF("Actualisation : discard delta beta offset is OFF (0x%02X)", ACT_MODE_DISCARD_OFFSET);
                  }

               }
               break;

      case 8:
         DT_PRINTF("Cancelling current actualization");
         stopActualization();
         break;

      default:
         DT_ERR("Unknown command");
         return IRC_FAILURE;
   };

   // There is supposed to be no remaining bytes in the buffer
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

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
   uffs_DIR *dp;
   struct uffs_dirent *ep;
   struct uffs_stat filestat;
   long spaceTotal, spaceUsed, spaceFree;
   char filename[FM_LONG_FILENAME_SIZE];

   // There is supposed to be no remaining bytes in the buffer
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   dp = uffs_opendir(FM_UFFS_MOUNT_POINT);
   if (dp != NULL)
   {
      PRINTF("%s:\n", FM_UFFS_MOUNT_POINT);
      while ((ep = uffs_readdir(dp)) != NULL)
      {
         sprintf(filename, "%s%s", FM_UFFS_MOUNT_POINT, ep->d_name);
         uffs_stat(filename, &filestat);
         PRINTF("   %s (%d)\n", ep->d_name, filestat.st_size);
      }

      uffs_closedir(dp);
   }
   else
   {
      DT_ERR("List failed.\n");
      return IRC_FAILURE;
   }

   spaceTotal = uffs_space_total(FM_UFFS_MOUNT_POINT);
   spaceUsed = uffs_space_used(FM_UFFS_MOUNT_POINT);
   spaceFree = uffs_space_free(FM_UFFS_MOUNT_POINT);

   PRINTF("Space used = %d / %d (free = %d / %d)\n", spaceUsed, spaceTotal, spaceFree, spaceTotal);

   return IRC_SUCCESS;
}

/**
 * Debug terminal Remove File command parser.
 * This parser is used to parse and validate Write Memory command arguments and to
 * execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Write Memory command was successfully executed.
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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   retval = uffs_remove(filename);
   if (retval == -1)
   {
      DT_ERR("Failed to remove %s.\n", filename);
      return IRC_FAILURE;
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
   extern ctrlIntf_t gClinkCtrlIntf;
   extern ctrlIntf_t gPleoraCtrlIntf;
#if (OEM_UART_ENABLED)
   extern ctrlIntf_t gOemCtrlIntf;
#endif
   extern ctrlIntf_t gFileCtrlIntf;
   ctrlIntf_t *p_ctrlIntf;
   uint8_t argStr[7];
   uint32_t arglen;
   uint32_t loopback;

   // Read port value
   arglen = GetNextArg(cbuf, argStr, 6);
   if (arglen == 0)
   {
      DT_ERR("Invalid port value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "CLINK") == 0)
   {
      p_ctrlIntf = &gClinkCtrlIntf;
   }
   else if (strcasecmp((char *)argStr, "PLEORA") == 0)
   {
      p_ctrlIntf = &gPleoraCtrlIntf;
   }
   else if (strcasecmp((char *)argStr, "OEM") == 0)
   {
#if (OEM_UART_ENABLED)
      p_ctrlIntf = &gOemCtrlIntf;
#else
      DT_ERR("OEM port is disabled.");
      return IRC_FAILURE;
#endif
   }
   else if (strcasecmp((char *)argStr, "USART") == 0)
   {
      p_ctrlIntf = &gFileCtrlIntf;
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
   if (!CBB_Empty(cbuf))
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

   p_ctrlIntf->loopback = loopback;

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
   extern ctrlIntf_t gClinkCtrlIntf;
   extern ctrlIntf_t gPleoraCtrlIntf;
#if (OEM_UART_ENABLED)
   extern ctrlIntf_t gOemCtrlIntf;
#endif
   extern ctrlIntf_t gFileCtrlIntf;
   extern ctrlIntf_t gOutputCtrlIntf;
   ctrlIntf_t *p_ctrlIntf;
   uint8_t argStr[7];
   uint32_t arglen;
   uint32_t showBytes;

   // Read port value
   arglen = GetNextArg(cbuf, argStr, 6);
   if (arglen == 0)
   {
      DT_ERR("Invalid port value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "CLINK") == 0)
   {
      p_ctrlIntf = &gClinkCtrlIntf;
   }
   else if (strcasecmp((char *)argStr, "PLEORA") == 0)
   {
      p_ctrlIntf = &gPleoraCtrlIntf;
   }
   else if (strcasecmp((char *)argStr, "OEM") == 0)
   {
#if (OEM_UART_ENABLED)
      p_ctrlIntf = &gOemCtrlIntf;
#else
      DT_ERR("OEM port is disabled.");
      return IRC_FAILURE;
#endif
   }
   else if (strcasecmp((char *)argStr, "USART") == 0)
   {
      p_ctrlIntf = &gFileCtrlIntf;
   }
   else if (strcasecmp((char *)argStr, "OUTPUT") == 0)
   {
      p_ctrlIntf = &gOutputCtrlIntf;
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
   if (!CBB_Empty(cbuf))
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
   arglen = GetNextArg(cbuf, argStr, 8);
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
   if (!CBB_Empty(cbuf))
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


   if (!CBB_Empty(cbuf))
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
      if (!CBB_Empty(cbuf))
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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINT("Performing flash read and write test...");

   counterMax = fileSize / sizeof(counter); // 1 MB
   progressStep = counterMax / 50;

   PRINT("DT: Writing flash test file");
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

   PRINT("DT: Reading flash test file");
   fd = uffs_open(testfilename, UO_RDONLY);
   if (fd == -1)
   {
      PRINT("\n");
      DT_ERR("Failed to open %s for reading.", testfilename);
      return IRC_SUCCESS;
   }

   for (counter = 0; counter < counterMax;  counter++)
   {
      if (uffs_read(fd, &data, sizeof(data)) != sizeof(data))
      {
         PRINT("\n");
         DT_ERR("File read failed (counter = %d).", counter);
         return IRC_SUCCESS;
      }

      if (data != counter)
      {
         PRINT("\n");
         DT_ERR("Data mismatch (counter = %d).", counter);
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
   if (!CBB_Empty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINT("Performing DDR memory read and write test...");

   DT_PRINTF("Writing %d bytes to DDR memory @ 0x%08X...", bufferSize, p_ddrTestBuffer);
   for (i = 0; i < bufferSize; i++)
   {
      p_ddrTestBuffer[i] = (i & 0x000000FF);
   }

   DT_PRINTF("Reading %d bytes from DDR memory @ 0x%08X...", bufferSize, p_ddrTestBuffer);
   for (i = 0; i < bufferSize; i++)
   {
      if (p_ddrTestBuffer[i] != (i & 0x000000FF))
      {
         DT_PRINTF("Failed to read byte @ 0x%08X (%d read, %d expected)", &p_ddrTestBuffer[i], p_ddrTestBuffer[i], i);
         return IRC_SUCCESS;
      }
   }

   DT_PRINT("DDR memory read and write test succeeded.");

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
   if (!CBB_Empty(cbuf))
   {
      // Read key command argument
      arglen = GetNextArg(cbuf, argStr, 5);
      if (arglen == 0)
      {
         DT_ERR("Invalid key command argument.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      // There is supposed to be no remaining bytes in the buffer
      if (!CBB_Empty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      if (strcasecmp((char *)argStr, "RENEW") == 0)
      {
         DeviceKey_Renew(&gFlashDynamicValues, &gcRegsData);
         return IRC_SUCCESS;
      }
      else if (strcasecmp((char *)argStr, "RESET") == 0)
      {
         DeviceKey_Reset(&gFlashDynamicValues, &gcRegsData);
         return IRC_SUCCESS;
      }
      else
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }
   }

   DT_PRINTF("Device key:            0x%08X%08X", flashSettings.DeviceKeyHigh, flashSettings.DeviceKeyLow);
   DT_PRINTF("Device key validation: 0x%08X%08X (%s)", gcRegsData.DeviceKeyValidationHigh, gcRegsData.DeviceKeyValidationLow,
         (DeviceKey_Validate(&flashSettings, &gFlashDynamicValues) == IRC_SUCCESS)? "Passed" : "Failed");
   DT_PRINTF("Device key expiration: 0x%08X", flashSettings.DeviceKeyExpirationPOSIXTime);

   return IRC_SUCCESS;
}

/**
 * Debug terminal command's arguments parser.
 * This parser is used to get the next command's argument.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 * @param buffer is the pointer to the byte buffer where the argument data is going to copied.
 * @param buflen is the length of the buffer passed as parameter.
 *
 * @return the argument length (without the terminator).
 * @return 0 if no terminated argument was found.
 */
uint16_t GetNextArg(circByteBuffer_t *cbuf, uint8_t *buffer, uint16_t buflen)
{
   uint8_t byte = 0;
   uint16_t length = 0;
   IRC_Status_t result = IRC_SUCCESS;
   uint8_t argTerminated = 0;

   do
   {
      result = CBB_Pop(cbuf, &byte);
      if ((result == IRC_SUCCESS) && (byte != ' '))
      {
         buffer[length++] = byte;
      }
      else
      {
         argTerminated = 1;
      }
   }
   while ((argTerminated == 0) && (length < buflen));

   if (length == buflen)
   {
      // Check if argument is terminated
      result = CBB_Peek(cbuf, 0, &byte);
      if ((result != IRC_SUCCESS) || (byte == ' '))
      {
         argTerminated = 1;
         CBB_Flushn(cbuf, 1);
      }
   }

   if (argTerminated == 1)
   {
      return length;
   }
   else
   {
      return 0;
   }
}

/**
 * Debug terminal numeric command's arguments parser.
 * This parser is used to parse a numeric command's argument (hex or decimal).
 *
 * @param str is the argument string to be parsed.
 * @param length is the length of string parameter.
 * @param value is the pointer to the uint32_t value to be returned.
 *
 * @return IRC_SUCCESS if the numeric argument was successfully parsed. value parameter content is valid.
 * @return IRC_FAILURE if the numeric argument cannot be parsed. value parameter content is not valid.
 */
IRC_Status_t ParseNumArg(char *str, uint8_t length, uint32_t *value)
{
   if ((length > 2) && (str[0] == '0') && (str[1] == 'x'))
   {
      return ParseNumHex(&str[2], length - 2, value);
   }
   else
   {
      return ParseNumDec(str, length, value);
   }
}

/**
 * Debug terminal hex command's arguments parser.
 * This parser is used to parse a hex numeric command's argument.
 *
 * @param str is the argument string to be parsed (without the 0x).
 * @param length is the length of string parameter.
 * @param value is the pointer to the uint32_t value to be returned.
 *
 * @return IRC_SUCCESS if the numeric argument was successfully parsed. value parameter content is valid.
 * @return IRC_FAILURE if the numeric argument cannot be parsed. value parameter content is not valid.
 */
IRC_Status_t ParseNumHex(char *str, uint8_t length, uint32_t *value)
{
   uint8_t i;
   uint32_t val;
   uint32_t mult;

   if ((length < 1) || (length > 8))
   {
      return IRC_FAILURE;
   }

   *value = 0;
   mult = 1;
   i = length;

   while (i > 0)
   {
      i--;
      if ((str[i] >= '0') && (str[i] <= '9'))
      {
         val = str[i] - '0';
      }
      else if ((str[i] >= 'a') && (str[i] <= 'f'))
      {
         val = 10 + str[i] - 'a';
      }
      else if ((str[i] >= 'A') && (str[i] <= 'F'))
      {
         val = 10 + str[i] - 'A';
      }
      else
      {
         return IRC_FAILURE;
      }
      *value += val * mult;
      mult *= 16;
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal decimal command's arguments parser.
 * This parser is used to parse a decimal numeric command's argument.
 *
 * @param str is the argument string to be parsed.
 * @param length is the length of string parameter.
 * @param value is the pointer to the uint32_t value to be returned.
 *
 * @return IRC_SUCCESS if the numeric argument was successfully parsed. value parameter content is valid.
 * @return IRC_FAILURE if the numeric argument cannot be parsed. value parameter content is not valid.
 */
IRC_Status_t ParseNumDec(char *str, uint8_t length, uint32_t *value)
{
   uint8_t i;
   uint32_t val;
   uint32_t mult;

   if ((length < 1) || (length > 10))
   {
      return IRC_FAILURE;
   }

   *value = 0;
   mult = 1;
   i = length;

   while (i > 0)
   {
      i--;
      if ((str[i] >= '0') && (str[i] <= '9'))
      {
         val = str[i] - '0';
      }
      else
      {
         return IRC_FAILURE;
      }

      // Check maximum 32-bit value
      if ((i == 10) && ((val > 4) ||
               ((val = 4) && (*value > (uint32_t)294967295))))
      {
            return IRC_FAILURE;
      }

      *value += val * mult;
      mult *= 10;
   }

   return IRC_SUCCESS;
}

/**
 * Debug terminal signed decimal command's arguments parser.
 * This parser is used to parse a signed decimal numeric command's argument.
 *
 * @param str is the argument string to be parsed.
 * @param length is the length of string parameter.
 * @param value is the pointer to the int32_t value to be returned.
 *
 * @return IRC_SUCCESS if the numeric argument was successfully parsed. value parameter content is valid.
 * @return IRC_FAILURE if the numeric argument cannot be parsed. value parameter content is not valid.
 */
IRC_Status_t ParseSignedNumDec(char *str, uint8_t length, int32_t *value)
{
   uint8_t i;
   uint32_t val;
   uint32_t mult;

   if ((length < 1) || (length > 11))
   {
      return IRC_FAILURE;
   }

   *value = 0;
   mult = 1;
   i = length;

   while (i > 0)
   {
      i--;
      if ((i == 0) && (str[i] == '-'))
      {
         *value *= -1;
      }
      else
      {
         if ((str[i] >= '0') && (str[i] <= '9'))
         {
            val = str[i] - '0';
         }
         else
         {
            return IRC_FAILURE;
         }

         // Check maximum 32-bit value
         if ((i == 10) && ((val > 4) ||
                  ((val = 4) && (*value > (uint32_t)294967295))))
         {
               return IRC_FAILURE;
         }

         *value += val * mult;
         mult *= 10;
      }
   }

   return IRC_SUCCESS;
}
