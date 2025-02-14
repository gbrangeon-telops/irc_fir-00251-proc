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
#include "FWController.h"
#include "RpOpticalProtocol.h"
#include "Autofocus.h"
#include "IRIGB.h"
#include "GC_Store.h"
#include "FrameBuffer.h"
#include "xparameters.h"
#include "HwRevision.h"

#ifdef STARTUP
#include "DT_CommandsDef_startup.h"
#endif

static IRC_Status_t DebugTerminalParseIRIG(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFPA(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFPACFG(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseXRO(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseCCM(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseCCMREG(circByteBuffer_t *cbuf);
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
static IRC_Status_t DebugTerminalParseFWTEMP(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseDFDVU(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFS(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFDV(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseDTO(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFWPID(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseLT(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParsePLT(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParsePBT(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseFB(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseHWID(circByteBuffer_t *cbuf);
static IRC_Status_t DebugTerminalParseHLP(circByteBuffer_t *cbuf);

debugTerminalCommand_t gDebugTerminalCommands[] =
{
   {"IRIG", DebugTerminalParseIRIG},
   {"RDM", DebugTerminalParseRDM},
   {"WRM", DebugTerminalParseWRM},
   {"FPA", DebugTerminalParseFPA},
   {"FPACFG", DebugTerminalParseFPACFG},
   {"XRO", DebugTerminalParseXRO},
   {"CCM", DebugTerminalParseCCM},
   {"CCMREG", DebugTerminalParseCCMREG},
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
   {"FDV", DebugTerminalParseFDV},
   {"DTO", DebugTerminalParseDTO},
   {"FWPID", DebugTerminalParseFWPID},
   {"FWTEMP", DebugTerminalParseFWTEMP},
   {"CI", DebugTerminalParseCI},
   {"LT", DebugTerminalParseLT},
   {"PLT", DebugTerminalParsePLT},
   {"PBT", DebugTerminalParsePBT},
   {"FB", DebugTerminalParseFB},
   {"HWID", DebugTerminalParseHWID},

#ifdef STARTUP
   DT_STARTUP_CMDS
#endif
   {"HLP", DebugTerminalParseHLP}
};

uint32_t gDebugTerminalCommandsCount = NUM_OF(gDebugTerminalCommands);

bool gDisableFilterWheel;

extern ctrlIntf_t gCtrlIntf_NTxMini;
extern ctrlIntf_t gCtrlIntf_OEM;
extern ctrlIntf_t gCtrlIntf_CameraLink;
extern ctrlIntf_t gCtrlIntf_OutputFPGA;
extern ctrlIntf_t gCtrlIntf_FileManager;
extern rpCtrl_t theRpCtrl;
extern autofocusCtrl_t theAutoCtrl;
extern IRIG_POSIXTime_t IRIG_POSIXTime;
extern qspiFlash_t gQSPIFlash;
debugTerminalCtrlIntf_t gDebugTerminalCtrlIntfs[] =
{
   {"PLEORA", &gCtrlIntf_NTxMini},
   {"OEM", &gCtrlIntf_OEM},
   {"CLINK", &gCtrlIntf_CameraLink},
   {"OUTPUT", &gCtrlIntf_OutputFPGA},
   {"USART", &gCtrlIntf_FileManager}
};

uint32_t gDebugTerminalCtrlIntfsCount = NUM_OF(gDebugTerminalCtrlIntfs);

/**
 * Debug terminal set IRIGB delay.
 * This parser is used to parse and validate set IRIGB delay command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when IRIGB set delay command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseIRIG(circByteBuffer_t *cbuf)
{

   uint8_t argStr[12];
   uint32_t arglen;
   uint32_t cmd = 0;
   uint32_t iValue = 0;

   // Check for IRIGB command argument presence
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read IRIGB command argument
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid IRIGB command argument.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      if (strcasecmp((char *)argStr, "DLY") == 0)
      {
         cmd = 1;
      }
      else
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      // Read IRIGB command parameter value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      switch (cmd)
      {
         case 1: // IRIGB
            if ((ParseNumArg((char *)argStr, arglen, &iValue) != IRC_SUCCESS))
            {
               DT_ERR("Invalid uint32 value.");
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

      AXI4L_write32(iValue, XPAR_IRIG_CTRL_BASEADDR + AW_IRIG_DELAY);
   }


   IRIG_Read_Global_Status();

   DT_PRINTF("GLOBAL STATUS = 0x%08X", IRIG_POSIXTime.Status.Global_Status);
   DT_PRINTF("MB SPEED ERROR = 0x%08X", IRIG_POSIXTime.Status.MB_Speed_Error);
   DT_PRINTF("PPS DELAY = %d (number of 50ns clock cycle)", IRIG_POSIXTime.Status.PPS_Delay);

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
   extern uint8_t gFpaScdDiodeBiasEnum;
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern uint16_t gFpaElCorrMeasAtStarvation; 
   extern uint16_t gFpaElCorrMeasAtSaturation; 
   extern uint16_t gFpaElCorrMeasAtReference1; 
   extern uint16_t gFpaElCorrMeasAtReference2;
   extern int32_t gFpaDebugRegA;
   extern int32_t gFpaDebugRegB;
   extern int32_t gFpaDebugRegC;
   extern int32_t gFpaDebugRegD;
   extern int32_t gFpaDebugRegE;
   extern int32_t gFpaDebugRegF;
   extern int32_t gFpaDebugRegG;
   extern int32_t gFpaDebugRegH;
   extern int32_t gFpaDebugRegI;
   extern int32_t gFpaDebugRegJ;
   extern int32_t gFpaDebugRegK;
   extern int32_t gFpaDebugRegL;
   extern int32_t gFpaDebugRegM;
   extern int32_t gFpaExposureTimeOffset;

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
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid FPA command argument.");
         return IRC_FAILURE;
      }
      argStr[arglen++] = '\0'; // Add string terminator

      if (strcasecmp((char *)argStr, "POL") == 0)
         cmd = 1;
      else if (strcasecmp((char *)argStr, "REF") == 0)
         cmd = 2;
      else if (strcasecmp((char *)argStr, "OFF") == 0)
         cmd = 3;
      else if (strcasecmp((char *)argStr, "ETOFF") == 0)
         cmd = 4;
      else if (strcasecmp((char *)argStr, "REGA") == 0)
         cmd = 5;
      else if (strcasecmp((char *)argStr, "REGB") == 0)
         cmd = 6;
      else if (strcasecmp((char *)argStr, "REGC") == 0)
         cmd = 7;
      else if (strcasecmp((char *)argStr, "REGD") == 0)
         cmd = 8;
      else if (strcasecmp((char *)argStr, "REGE") == 0)
         cmd = 9;
      else if (strcasecmp((char *)argStr, "REGF") == 0)
         cmd = 10;
      else if (strcasecmp((char *)argStr, "REGG") == 0)
         cmd = 11;
      else if (strcasecmp((char *)argStr, "REGH") == 0)
         cmd = 12;
      else if (strcasecmp((char *)argStr, "STAR") == 0)
         cmd = 13;
      else if (strcasecmp((char *)argStr, "SATU") == 0)
         cmd = 14;
      else if (strcasecmp((char *)argStr, "REF1") == 0)
         cmd = 15;
      else if (strcasecmp((char *)argStr, "REF2") == 0)
         cmd = 16;
      else if (strcasecmp((char *)argStr, "BIAS") == 0)
         cmd = 17;
      else if (strcasecmp((char *)argStr, "REGI") == 0)
         cmd = 18;
      else if (strcasecmp((char *)argStr, "REGJ") == 0)
         cmd = 19;
      else if (strcasecmp((char *)argStr, "REGK") == 0)
         cmd = 20;
      else if (strcasecmp((char *)argStr, "REGL") == 0)
         cmd = 21;
      else if (strcasecmp((char *)argStr, "REGM") == 0)
         cmd = 22;
      else
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      // Read FPA command parameter value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
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

         case  4: // ETOFF
         case  5: // REGA
         case  6: // REGB
         case  7: // REGC
         case  8: // REGD
         case  9: // REGE
         case 10: // REGF
         case 11: // REGG
         case 12: // REGH
         case 18: // REGI
         case 19: // REGJ
         case 20: // REGK
         case 21: // REGL
         case 22: // REGM

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
            
         case 13: // ELCORR STARVATION
         case 14: // ELCORR SATURATION
         case 15: // ELCORR REFERENCE1
         case 16: // ELCORR REFERENCE2
            if ((ParseSignedNumDec((char *)argStr, arglen, &iValue) != IRC_SUCCESS) ||
                  (iValue < 0) || (iValue > 65535))
            {
               DT_ERR("Invalid uint16 value.");
               return IRC_FAILURE;
            }
            break;

         case 17: // BIAS
            if ((ParseSignedNumDec((char *)argStr, arglen, &iValue) != IRC_SUCCESS) ||
                  (iValue < 0) || (iValue > 255))
            {
                  DT_ERR("Invalid uint8 value.");
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

         case 4: // ETOFF
            gFpaExposureTimeOffset = iValue;
            break;

         case 5: // REGA
            gFpaDebugRegA = iValue;
            break;

         case 6: // REGB
            gFpaDebugRegB = iValue;
            break;

         case 7: // REGC
            gFpaDebugRegC = iValue;
            break;
			
		   case 8: // REGD
            gFpaDebugRegD = iValue;
            break;
            
         case 9: // REGE
            gFpaDebugRegE = iValue;
            break;

         case 10: // REGF
            gFpaDebugRegF = iValue;
            break;

         case 11: // REGG
            gFpaDebugRegG = iValue;
            break;
			
		   case 12: // REGH
            gFpaDebugRegH = iValue;
            break;
            
         case 13: // ELCORR STARVATION
            gFpaElCorrMeasAtStarvation = iValue;
            break;
            
         case 14: // ELCORR SATURATION
            gFpaElCorrMeasAtSaturation = iValue;
            break;
         
         case 15: // ELCORR REFERENCE1
            gFpaElCorrMeasAtReference1 = iValue;
            break;
         
         case 16: // ELCORR REFERENCE2
            gFpaElCorrMeasAtReference2 = iValue;
            break;

         case 17: // BIAS
            gFpaScdDiodeBiasEnum = (uint8_t)iValue;
            break;

         case 18: // REGI
            gFpaDebugRegI = iValue;
            break;

         case 19: // REGJ
            gFpaDebugRegJ = iValue;
            break;

         case 20: // REGK
            gFpaDebugRegK = iValue;
            break;

         case 21: // REGL
            gFpaDebugRegL = iValue;
            break;

         case 22: // REGM
            gFpaDebugRegM = iValue;
            break;
      }


      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
   }

   FPA_GetStatus(&status, &gFpaIntf);

   DT_PRINTF("FPA model name = " FPA_DEVICE_MODEL_NAME);

   DT_PRINTF("FPA temperature = %dcC", FPA_GetTemperature(&gFpaIntf));

   DT_PRINTF("FPA SCD diode bias current enum = %d", gFpaScdDiodeBiasEnum);

   DT_PRINTF("FPA detector polarization voltage = %d mV", gFpaDetectorPolarizationVoltage);
   DT_PRINTF("FPA detector taps reference voltage = " _PCF(3) " mV", _FFMT(gFpaDetectorElectricalTapsRef, 3));
   DT_PRINTF("FPA detector offset voltage = " _PCF(3) " mV", _FFMT(gFpaDetectorElectricalRefOffset, 3));
   DT_PRINTF("FPA detector exposure time offset =  %de-8 s", gFpaExposureTimeOffset);

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
   DT_PRINTF("fpa.cooler_on_curr_min_mA = %d", status.cooler_on_curr_min_mA);
   DT_PRINTF("fpa.cooler_off_curr_max_mA = %d", status.cooler_off_curr_max_mA);
   DT_PRINTF("fpa.fpa_temp_raw = %d", status.fpa_temp_raw);

   DT_PRINTF("fpa.global_done = %d", status.global_done);
   DT_PRINTF("fpa.fpa_powered = %d", status.fpa_powered);
   DT_PRINTF("fpa.cooler_powered = %d", status.cooler_powered);

   DT_PRINTF("fpa.errors_latchs = 0x%08X", status.errors_latchs);

   //DT_PRINTF("fpa.intf_seq_stat = 0x%08X", status.intf_seq_stat);
   //DT_PRINTF("fpa.data_path_stat = 0x%08X", status.data_path_stat);
   //DT_PRINTF("fpa.trig_ctler_stat = 0x%08X", status.trig_ctler_stat);
  //DT_PRINTF("fpa.fpa_driver_stat = 0x%08X", status.fpa_driver_stat);

   DT_PRINTF("fpa.adc_ddc_detect_process_done = %d", status.adc_ddc_detect_process_done);
   DT_PRINTF("fpa.adc_ddc_present = %d", status.adc_ddc_present);
   DT_PRINTF("fpa.flex_flegx_detect_process_done = %d", status.flex_flegx_detect_process_done);
   DT_PRINTF("fpa.flex_flegx_present = %d", status.flex_flegx_present);
   
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
   DT_PRINTF("prog_init_done = %d", status.prog_init_done);
   
   DT_PRINTF("FPA debug register A = %d", gFpaDebugRegA);
   DT_PRINTF("FPA debug register B = %d", gFpaDebugRegB);
   DT_PRINTF("FPA debug register C = %d", gFpaDebugRegC);
   DT_PRINTF("FPA debug register D = %d", gFpaDebugRegD);
   DT_PRINTF("FPA debug register E = %d", gFpaDebugRegE);
   DT_PRINTF("FPA debug register F = %d", gFpaDebugRegF);
   DT_PRINTF("FPA debug register G = %d", gFpaDebugRegG);
   DT_PRINTF("FPA debug register H = %d", gFpaDebugRegH);
   DT_PRINTF("FPA debug register I = %d", gFpaDebugRegI);
   DT_PRINTF("FPA debug register J = %d", gFpaDebugRegJ);
   DT_PRINTF("FPA debug register K = %d", gFpaDebugRegK);
   DT_PRINTF("FPA debug register L = %d", gFpaDebugRegL);
   DT_PRINTF("FPA debug register M = %d", gFpaDebugRegM);
  
   DT_PRINTF("FPA ElCorr Meas At Starvation = %d", gFpaElCorrMeasAtStarvation);
   DT_PRINTF("FPA ElCorr Meas At Saturation = %d", gFpaElCorrMeasAtSaturation);
   DT_PRINTF("FPA ElCorr Meas At Reference1 = %d", gFpaElCorrMeasAtReference1);
   DT_PRINTF("FPA ElCorr Meas At Reference2 = %d", gFpaElCorrMeasAtReference2);
   
   DT_PRINTF("fpa.acq_trig_cnt     = %d", status.acq_trig_cnt);
   DT_PRINTF("fpa.acq_int_cnt      = %d", status.acq_int_cnt);
   DT_PRINTF("fpa.acq_fast_hder_cnt= %d", status.fast_hder_cnt);
   DT_PRINTF("fpa.acq_readout_cnt  = %d", status.acq_readout_cnt);   
   DT_PRINTF("fpa.fpa_readout_cnt  = %d", status.fpa_readout_cnt);   
   DT_PRINTF("fpa.out_pix_cnt_min  = %d", status.out_pix_cnt_min);
   DT_PRINTF("fpa.out_pix_cnt_max  = %d", status.out_pix_cnt_max);
   DT_PRINTF("fpa.trig_to_int_delay_min = %d", status.trig_to_int_delay_min);
   DT_PRINTF("fpa.trig_to_int_delay_max = %d", status.trig_to_int_delay_max);
   DT_PRINTF("fpa.int_to_int_delay_min  = %d", status.int_to_int_delay_min);
   DT_PRINTF("fpa.int_to_int_delay_max  = %d", status.int_to_int_delay_max);

#ifdef CALCIUM_PROXY
   // bus d'erreurs spécifiques au calciumD
   DT_PRINTF("compr_err_latch = 0x%08X", AXI4L_read32(gFpaIntf.ADD + AR_COMPR_ERR));
#endif

   return IRC_SUCCESS;
}

/**
 * Debug terminal get FPA config command parser.
 * This parser is used to parse and validate get FPA config command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when FPA config command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFPACFG(circByteBuffer_t *cbuf)
{
   extern t_FpaIntf gFpaIntf;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   FPA_PrintConfig(&gFpaIntf);

   return IRC_SUCCESS;
}

/**
 * Debug terminal get XRO status command parser.
 * This parser is used to parse and validate get XRO status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when XRO status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseXRO(circByteBuffer_t *cbuf)
{
   extern t_FpaIntf gFpaIntf;
   extern uint8_t gFpaCtiaBiasEnum;
   extern uint16_t gFpaDetectSub_mV;
   extern uint16_t gFpaCtiaRef_mV;
   extern uint16_t gFpaVTestG_mV;
   extern uint16_t gFpaCM_mV;
   extern uint16_t gFpaVCMO_mV;
   extern uint16_t gFpaLovh_mclk;
   extern bool gFpaLovhFlag;
   extern uint8_t gFpaSubWindowMode;

   uint8_t cmdStr[10], argStr[7];
   uint32_t arglen;
   uint32_t uValue;

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read command value
      arglen = GetNextArg(cbuf, cmdStr, sizeof(cmdStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid command");
         return IRC_FAILURE;
      }
      cmdStr[arglen++] = '\0'; // Add string terminator

      // Read argument value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if ((ParseNumArg((char *)argStr, arglen, &uValue) != IRC_SUCCESS) ||
            (uValue < 0) || (uValue > USHRT_MAX))
      {
         DT_ERR("Invalid argument");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments");
         return IRC_FAILURE;
      }

      // Process command
      if (strcasecmp((char *)cmdStr, "BIAS") == 0)
      {
         gFpaCtiaBiasEnum = (uint8_t)uValue;
      }
      else if (strcasecmp((char *)cmdStr, "DETECTSUB") == 0)
      {
         gFpaDetectSub_mV = (uint16_t)uValue;
      }
      else if (strcasecmp((char *)cmdStr, "CTIAREF") == 0)
      {
         gFpaCtiaRef_mV = (uint16_t)uValue;
      }
      else if (strcasecmp((char *)cmdStr, "VTESTG") == 0)
      {
         gFpaVTestG_mV = (uint16_t)uValue;
      }
      else if (strcasecmp((char *)cmdStr, "CM") == 0)
      {
         gFpaCM_mV = (uint16_t)uValue;
      }
      else if (strcasecmp((char *)cmdStr, "VCMO") == 0)
      {
         gFpaVCMO_mV = (uint16_t)uValue;
      }
      else if (strcasecmp((char *)cmdStr, "LOVH") == 0)
      {
         gFpaLovh_mclk = (uint16_t)uValue;
         if (gFpaLovh_mclk > 0)
            gFpaLovhFlag = true;
         else
            gFpaLovhFlag = false;
      }
      else if (strcasecmp((char *)cmdStr, "SWM") == 0)
      {
         gFpaSubWindowMode = (uint8_t)uValue;
      }
      else
      {
         DT_ERR("Unsupported command");
         return IRC_FAILURE;
      }

      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
   }

   DT_PRINTF("FPA CTIA bias current enum = %d", gFpaCtiaBiasEnum);

   DT_PRINTF("FPA DETECTSUB voltage = %d mV", gFpaDetectSub_mV);
   DT_PRINTF("FPA CTIAREF voltage = %d mV", gFpaCtiaRef_mV);
   DT_PRINTF("FPA VTESTG voltage = %d mV", gFpaVTestG_mV);
   DT_PRINTF("FPA CM voltage = %d mV", gFpaCM_mV);
   DT_PRINTF("FPA VCMO voltage = %d mV", gFpaVCMO_mV);

   DT_PRINTF("FPA LOVH = %d MCLK", gFpaLovh_mclk);

   DT_PRINTF("FPA Sub-window mode = %d", gFpaSubWindowMode);

   return IRC_SUCCESS;
}

/**
 * Debug terminal get CCM status command parser.
 * This parser is used to parse and validate get CCM status command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when CCM status command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseCCM(circByteBuffer_t *cbuf)
{
#ifdef CALCIUM_PROXY
   extern t_FpaIntf gFpaIntf;
   extern uint16_t gFpaVa1p8_mV;
   extern uint16_t gFpaVPixRst_mV;
   extern uint16_t gFpaVdhs1p8_mV;
   extern uint16_t gFpaVd1p8_mV;
   extern uint16_t gFpaVa3p3_mV;
   extern uint16_t gFpaVDetGuard_mV;
   extern uint16_t gFpaVDetCom_mV;
   extern uint16_t gFpaVPixQNB_mV;
   extern int32_t gFpaDebugRegH;                       // reservé pour l'activation/désactivation du LDO de VPIXQNB
   extern uint16_t gFpaDebugKPix;
   extern bool gFpaDebugKPixForced;
   extern bool gFpaDebugKPixApplied;
   extern float gFpaActualFreq_MHz;
   extern float gFpaDesiredFreq_MHz;
   extern CompressionAlgorithm_t gCompressionAlgorithm;
   extern float gCompressionParameter;
   extern bool gCompressionParameterForced;
   extern uint8_t gCompressionBypassShift;
   extern bool gCompressionBypassShiftForced;
   extern t_calib gCal;
   extern t_HderInserter gHderInserter;

   uint8_t cmdStr[10], argStr[9];
   uint32_t arglen;
   uint32_t cmd;
   uint32_t uValue;
   float fValue = 0.0F;

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read command value
      arglen = GetNextArg(cbuf, cmdStr, sizeof(cmdStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid command");
         return IRC_FAILURE;
      }
      cmdStr[arglen++] = '\0'; // Add string terminator
      
      // Identify command
      if (strcasecmp((char *)cmdStr, "VA1P8") == 0)
         cmd = 1;
      else if (strcasecmp((char *)cmdStr, "VPIXRST") == 0)
         cmd = 2;
      else if (strcasecmp((char *)cmdStr, "VDHS1P8") == 0)
         cmd = 3;
      else if (strcasecmp((char *)cmdStr, "VD1P8") == 0)
         cmd = 4;
      else if (strcasecmp((char *)cmdStr, "VA3P3") == 0)
         cmd = 5;
      else if (strcasecmp((char *)cmdStr, "VDETGUARD") == 0)
         cmd = 6;
      else if (strcasecmp((char *)cmdStr, "VDETCOM") == 0)
         cmd = 7;
      else if (strcasecmp((char *)cmdStr, "VPIXQNB") == 0)
         cmd = 8;
      else if (strcasecmp((char *)cmdStr, "WARNLED") == 0)
         cmd = 9;
      else if (strcasecmp((char *)cmdStr, "KPIX") == 0)
         cmd = 10;
      else if (strcasecmp((char *)cmdStr, "COMPR") == 0)
         cmd = 11;
      else if (strcasecmp((char *)cmdStr, "FREQ") == 0)
         cmd = 12;
      else if (strcasecmp((char *)cmdStr, "SHIFT") == 0)
         cmd = 13;
      else
      {
         DT_ERR("Unsupported command");
         return IRC_FAILURE;
      }

      // Read argument value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      switch (cmd)
      {
         case 1:  // VA1P8
         case 2:  // VPIXRST
         case 3:  // VDHS1P8
         case 4:  // VD1P8
         case 5:  // VA3P3
         case 6:  // VDETGUARD
         case 7:  // VDETCOM
         case 8:  // VPIXQNB
         case 9:  // WARNLED
         case 10: // KPIX
         case 13: // SHIFT
            if ((ParseNumArg((char *)argStr, arglen, &uValue) != IRC_SUCCESS) ||
                  (uValue < 0) || (uValue > USHRT_MAX))
            {
               DT_ERR("Invalid uint16 argument");
               return IRC_FAILURE;
            }
            break;
         
         case 11: // COMPR
         case 12: // FREQ
            if (ParseFloatNumDec((char *)argStr, arglen, &fValue) != IRC_SUCCESS)
            {
               DT_ERR("Invalid float argument");
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

      // Process command
      switch (cmd)
      {
         case 1:  // VA1P8
            gFpaVa1p8_mV = (uint16_t)uValue;
            break;
         
         case 2:  // VPIXRST
            gFpaVPixRst_mV = (uint16_t)uValue;
            break;
         
         case 3:  // VDHS1P8
            gFpaVdhs1p8_mV = (uint16_t)uValue;
            break;
         
         case 4:  // VD1P8
            gFpaVd1p8_mV = (uint16_t)uValue;
            break;
         
         case 5:  // VA3P3
            gFpaVa3p3_mV = (uint16_t)uValue;
            break;
         
         case 6:  // VDETGUARD
            gFpaVDetGuard_mV = (uint16_t)uValue;
            break;
         
         case 7:  // VDETCOM
            gFpaVDetCom_mV = (uint16_t)uValue;
            break;
         
         case 8:  // VPIXQNB
            gFpaVPixQNB_mV = (uint16_t)uValue;
            break;
         
         case 9:  // WARNLED
            if (uValue > 0)
               FPA_SetWarningLed(&gFpaIntf, true);
            else
               FPA_SetWarningLed(&gFpaIntf, false);
            break;
         
         case 10:  // KPIX
            gFpaDebugKPix = (uint16_t)uValue;
            gFpaDebugKPixForced = true;
            break;
         
         case 11:  // COMPR
            if (gCompressionBypassShiftForced)
            {
               gCompressionBypassShiftForced = false;
               DT_INF("The compression parameter overwrites the compression bypass shift");
            }
            gCompressionParameter = fValue;
            gCompressionParameterForced = true;
            break;
         
         case 12:  // FREQ
            if(fValue > 0.0f) {
               gFpaDesiredFreq_MHz = fValue;
               DT_PRINTF("New frequency will be applied on next FPA power on");
            } else {
               DT_ERR("New frequency must be greater than 0.0");
            }
            break;

         case 13:  // SHIFT
            if (gCompressionParameterForced)
            {
               gCompressionParameterForced = false;
               DT_INF("The compression bypass shift overwrites the compression parameter");
            }
            gCompressionBypassShift = (uint8_t)uValue;
            gCompressionBypassShiftForced = true;
            break;
      }

      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
      CAL_ConfigComprRatio(&gCal);
      HDER_UpdateCompressionConfig(&gHderInserter, &gcRegsData);
   }

   DT_PRINTF("FPA VA1P8 voltage = %u mV", gFpaVa1p8_mV);
   DT_PRINTF("FPA VPIXRST voltage = %u mV", gFpaVPixRst_mV);
   DT_PRINTF("FPA VDHS1P8 voltage = %u mV", gFpaVdhs1p8_mV);
   DT_PRINTF("FPA VD1P8 voltage = %u mV", gFpaVd1p8_mV);
   DT_PRINTF("FPA VA3P3 voltage = %u mV", gFpaVa3p3_mV);
   DT_PRINTF("FPA VDETGUARD voltage = %u mV", gFpaVDetGuard_mV);
   DT_PRINTF("FPA VDETCOM voltage = %u mV", gFpaVDetCom_mV);
   DT_PRINTF("FPA VPIXQNB voltage = %u mV is %s", gFpaVPixQNB_mV, gFpaDebugRegH ? "enabled" : "disabled");

   DT_PRINTF("FPA debug KPix = %u is %s", gFpaDebugKPix, gFpaDebugKPixApplied ? "enabled" : "disabled");

   switch (gCompressionAlgorithm)
   {
      case CA_NoCompression:
      default:
         DT_PRINTF("FPA compression is disabled");
         break;

      case CA_PowerLaw:
         DT_PRINTF("FPA Power Law compression is enabled");
         DT_PRINTF("FPA Power Law parameter = " _PCF(6), _FFMT(gCompressionParameter, 6));
         break;

      case CA_BitShift:
         DT_PRINTF("FPA Bit Shift compression is enabled");
         DT_PRINTF("FPA Bit Shift parameter = %u", gCompressionBypassShift);
         break;
   };

   DT_PRINTF("FPA actual frequency = "_PCF(6)" MHz", _FFMT(gFpaActualFreq_MHz, 6));

   return IRC_SUCCESS;

#else
   DT_ERR("Unsupported command for this FPA");
   return IRC_FAILURE;
#endif
}

/**
 * Debug terminal get CCM register command parser.
 * This parser is used to parse and validate get CCM register command arguments and to
 * execute the command.
 *
 * @return IRC_SUCCESS when CCM register command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseCCMREG(circByteBuffer_t *cbuf)
{
#ifdef CALCIUM_PROXY
   extern t_FpaIntf gFpaIntf;
   extern bool gFpaReadReg;

   uint8_t cmdStr[3], argStr[7];
   uint32_t arglen;
   uint32_t cmd;
   uint32_t uAddr, uValue;

   // Read command value
   arglen = GetNextArg(cbuf, cmdStr, sizeof(cmdStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid command");
      return IRC_FAILURE;
   }
   cmdStr[arglen++] = '\0'; // Add string terminator

   // Identify command and read optional arguments
   if (strcasecmp((char *)cmdStr, "RD") == 0)
   {
      cmd = 1;
      // No argument to read
   }
   else if (strcasecmp((char *)cmdStr, "WR") == 0)
   {
      cmd = 2;

      // Read argument address
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if ((ParseNumArg((char *)argStr, arglen, &uAddr) != IRC_SUCCESS) ||
            (uAddr < 0) || (uAddr > UCHAR_MAX))
      {
         DT_ERR("Invalid uint8 argument");
         return IRC_FAILURE;
      }

      // Read argument value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if ((ParseNumArg((char *)argStr, arglen, &uValue) != IRC_SUCCESS) ||
            (uValue < 0) || (uValue > UCHAR_MAX))
      {
         DT_ERR("Invalid uint8 argument");
         return IRC_FAILURE;
      }
   }
   else
   {
      DT_ERR("Unsupported command");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Process command
   switch (cmd)
   {
      case 1:  // RD
         gFpaReadReg = true;
         break;

      case 2:  // WR
         if (!FPA_ModifyRoicRegs((uint8_t)uAddr, (uint8_t)uValue))
         {
            DT_ERR("Register address (%u) not found", (uint8_t)uAddr);
            return IRC_FAILURE;
         }
         break;
   }

   FPA_SendConfigGC(&gFpaIntf, &gcRegsData);

   return IRC_SUCCESS;

#else
   DT_ERR("Unsupported command for this FPA");
   return IRC_FAILURE;
#endif
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
	DT_PRINTF("trig_delay_min = %d", status.trig_delay_min);
	DT_PRINTF("trig_delay_max = %d", status.trig_delay_max);

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
   DT_PRINTF("Filter wheel = %s", (Power_GetChannelPowerState(PC_FW) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Expansion =    %s", (Power_GetChannelPowerState(PC_EXPANSION) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Spare1 =       %s", (Power_GetChannelPowerState(PC_SPARE1) == CPS_ON)? "ON":"OFF");
   DT_PRINTF("Spare2 =       %s", (Power_GetChannelPowerState(PC_SPARE2) == CPS_ON)? "ON":"OFF");

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
   extern actDebugOptions_t gActDebugOptions;
   uint32_t cmd = 1000;
   uint32_t value;
   float fValue;
   uint8_t argStr[11];
   uint32_t arglen;

   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   argStr[arglen++] = '\0';
   if (strcasecmp((char*)argStr, "DBG") == 0) // use debug mode
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
   else if (strcasecmp((char*)argStr, "VRB") == 0) // Verbose configuration
      cmd = 7;
   else if (strcasecmp((char*)argStr, "STP") == 0) // Cancel currently running actualization
      cmd = 8;
   else if (strcasecmp((char*)argStr, "LST") == 0) // List all actualization in memory and flash memory
      cmd = 9;
   else if (strcasecmp((char*)argStr, "FR") == 0)  // set acquisition frame rate during actualization
      cmd = 10;
   else if (strcasecmp((char*)argStr, "CNST") == 0)  // Constant value data
      cmd = 11;

   switch (cmd)
   {
      case 0: // debug mode on/off
         arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (value == 0)
            {
               DT_INF("Normal mode (no bypass) activated");
               gActDebugOptions.bypassChecks = false;
            }
            else
            {
               DT_INF("Debug mode (bypass) activated");
               gActDebugOptions.bypassChecks = true;
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
            arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
            if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
            {
               value = 0; // clear current by default
            }

            if (value == 0)
            {
               ACT_invalidateActualizations(ACT_CURRENT);
               DT_PRINTF("current actualization was invalidated");
            }
            else
            {
               ACT_invalidateActualizations(ACT_ALL);
               DT_PRINTF("all actualizations were invalidated");
            }

            if(GC_MemoryBufferNotEmpty)
               DT_PRINTF("WARNING : Memory buffer is not empty. It won't be possible to download sequences with the invalidated actualization");

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
         arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (value == 0)
            {
               DT_INF("will not clear the buffer after actualisation");
               gActDebugOptions.clearBufferAfterCompletion = false;
            }
            else
            {
               DT_INF("will clear the buffer after actualisation");
               gActDebugOptions.clearBufferAfterCompletion = true;
            }
         }
         break;

      case 4: // perform actualization using ICU
         DT_INF("Triggering an actualization (icu)");
         gcRegsData.ImageCorrectionMode = ICM_ICU;
         startActualization();
         break;

      case 5: // perform actualization using external BB
         DT_INF("Triggering an actualization (xbb)");
         gcRegsData.ImageCorrectionMode = ICM_BlackBody;
         startActualization();
         break;

      case 6: // AEC on/off
         arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (value == 0)
            {
               DT_INF("AEC disabled during actualisation");
               gActDebugOptions.bypassAEC = true;
            }
            else
            {
               DT_INF("AEC enabled during actualisation");
               gActDebugOptions.bypassAEC = false;
            }
         }
         break;

      case 7: // Verbose on/off
         arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (value == 0)
            {
               DT_INF("Verbose is OFF");
               gActDebugOptions.verbose = false;
            }
            else
            {
               DT_INF("Verbose is ON");
               gActDebugOptions.verbose = true;
            }
         }
         break;

      case 8:
         DT_PRINTF("Cancelling current actualization");
         stopActualization();
         break;

      case 9:
         ACT_listActualizationData();
         break;

      case 10: // FR value
         arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
         if (ParseFloatNumDec((char *)argStr, arglen, &fValue) != IRC_SUCCESS)
         {
            DT_ERR("Invalid data length.");
            return IRC_FAILURE;
         }
         else
         {
            if (fValue < gcRegsData.AcquisitionFrameRateMin)
            {
               DT_ERR("Invalid frame rate value");
               return IRC_FAILURE;
            }
            else
            {
               gActDebugOptions.actFrameRate = fValue;   // limited to FRmax when set
            }
         }
         break;

      case 11: // Constant value data on/off
         arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
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

   BufferManager_GetStatus(&gBufManager, &status);

   DT_PRINTF("buf.error          = 0x%08X", status.error);
   DT_PRINTF("buf.mem_ready      = %d", status.mem_ready);
   DT_PRINTF("buf.ext_buf_prsnt  = %d", status.ext_buf_prsnt);
   DT_PRINTF("buf.status         = 0x%08X", gcRegsData.MemoryBufferStatus);

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
   uint64_t spaceTotal, spaceUsed;
   uint64_t space_Free;
   char filename[FM_LONG_FILENAME_SIZE];
   uint32_t i;
   int retlen;
   extern flashIntfCtrl_t gflashIntfCtrl;

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
      for(int idx = 0; idx < gflashIntfCtrl.nr_partition ; idx++) {
         dp = uffs_opendir(gflashIntfCtrl.mount_points[idx]);
         if (dp != NULL)
         {
            i = 0;
            while ((ep = uffs_readdir(dp)) != NULL)
            {
               retlen = snprintf(filename,FM_LONG_FILENAME_SIZE, "%s%s", gflashIntfCtrl.mount_points[idx], ep->d_name);
                /* ensure generated "filename" string is valid */
                if (retlen <= 0 || FM_LONG_FILENAME_SIZE <= retlen)
                	continue;
               uffs_stat(filename, &filestat);
               DT_PRINTF("%3d: %s (%d)", i++, ep->d_name, filestat.st_size);
            }
            DT_PRINTF("%d file(s)", i);

            spaceUsed = flash_space_used(gflashIntfCtrl.mount_points[idx]);
            space_Free = flash_space_free(gflashIntfCtrl.mount_points[idx]);
            DT_PRINTF("Space used in %s: = %llu B",gflashIntfCtrl.mount_points[idx], spaceUsed);
            DT_PRINTF("Space free in %s: = %llu B",gflashIntfCtrl.mount_points[idx], space_Free );

            uffs_closedir(dp);
         }
         else
         {
            DT_ERR("List failed.");
            return IRC_FAILURE;
         }
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
      spaceTotal = flash_all_space_total();
      spaceUsed = flash_all_space_used();
      space_Free = flash_all_space_free();

      DT_PRINTF("All Space in bytes: used = %llu", spaceUsed);
      DT_PRINTF("All Space in bytes: free = %llu", space_Free);
      DT_PRINTF("All Space in bytes: total= %llu", spaceTotal);

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
   arglen = GetNextArg(cbuf, (uint8_t *)filename, F1F2_FILE_NAME_SIZE);
   if (arglen == 0)
   {
      DT_ERR("Empty file name.");
      return IRC_FAILURE;
   }

   // Add string terminator (null char)
   filename[arglen] = '\0';

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Protect flash dynamic values file
   if (strcmp(filename, FDV_FILENAME) == 0)
   {
      DT_ERR("%s is protected.", filename);
      return IRC_FAILURE;
   }

   retval = FM_Remove(filename);
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
         "LENS",
         "FOV"
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
         gFlashDynamicValues.FileOrderKey5 = keys[4];
         FlashDynamicValues_Update(&gFlashDynamicValues);
      }
      else if (fileList == &gFM_collections)
      {
         gFlashDynamicValues.CalibrationCollectionFileOrderKey1 = keys[0];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey2 = keys[1];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey3 = keys[2];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey4 = keys[3];
         gFlashDynamicValues.CalibrationCollectionFileOrderKey5 = keys[4];
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
   extern t_Trig gTrig;
   uint8_t argStr[2];
   uint32_t arglen;
   uint32_t showNMEA;


   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read show packet value
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
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
         DT_PRINTF("UTC Time:  %02d:%02d:%02d  %02d/%02d/%4d", Gps_struct.rTClock.tm_hour, Gps_struct.rTClock.tm_min, Gps_struct.rTClock.tm_sec,
               Gps_struct.rTClock.tm_mon + 1, Gps_struct.rTClock.tm_mday, Gps_struct.rTClock.tm_year + 1900);
         DT_PRINTF("Latitude:  %dd%d.%04d' %C", Gps_struct.Latitude.degrees, Gps_struct.Latitude.minutes, Gps_struct.Latitude.frac_minutes, Gps_struct.Latitude.Hemisphere);
         DT_PRINTF("Longitude: %dd%d.%04d' %C", Gps_struct.Longitude.degrees, Gps_struct.Longitude.minutes, Gps_struct.Longitude.frac_minutes, Gps_struct.Longitude.Hemisphere);
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
 * Update: With more than one die, the test is made in each one.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when flash test read write command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFRW(circByteBuffer_t *cbuf)
{
   int fd;
   char stestfilename[] = "TelopsFlashTest.bin";
   const uint32_t fileSize = 1024 * 1024;
   uint32_t currentFileSize = 0;
   uint32_t counter;
   uint32_t data;
   const uint32_t counterMax = fileSize / sizeof(counter); // 1 MB
   const uint32_t progressStep = counterMax / 50;
   extern flashIntfCtrl_t gflashIntfCtrl;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINT("Performing flash read and write test...");

   for(int idx = 0; idx < gflashIntfCtrl.nr_partition ; idx++) {
      char testfilename[FM_LONG_FILENAME_SIZE] = {0};

      DT_PRINTF("DT: Writing flash test file in %s",gflashIntfCtrl.mount_points[idx]);
      snprintf(testfilename,FM_LONG_FILENAME_SIZE, "%s%s", gflashIntfCtrl.mount_points[idx], stestfilename);

      fd = uffs_open( testfilename, UO_WRONLY | UO_CREATE | UO_TRUNC);
      if (fd == -1)
      {
         DT_ERR("\nFailed to open %s for writing.Error %ld", testfilename,uffs_get_error());
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
      if ((currentFileSize = FM_GetFileSize(stestfilename)) == 0)
      {
         DT_ERR("Failed to get file stat.");
         return IRC_SUCCESS;
      }

      DT_PRINTF("Flash test file size is %d bytes.",currentFileSize);

      if (fileSize != currentFileSize)
      {
         DT_ERR("Flash test file size mismatch.");
         return IRC_SUCCESS;
      }

      FPGA_PRINT("DT: Reading flash test file");
      fd = uffs_open(testfilename, UO_RDONLY);
      if (fd == -1)
      {
         DT_ERR("\nFailed to open %s for reading.",testfilename);
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

      DT_PRINT("Removing flash test file in %s succeeded.", gflashIntfCtrl.mount_points[idx]);
   }

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
   uint32_t bufferSize = PROC_MEM_PIXEL_DATA_SIZE + PROC_MEM_USART_RXBUFFER_SIZE;
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
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
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
 * Get/Set Filter wheel reference temperature coefficients command parser.
 * This parser is used to parse and validate Get/Set Filter wheel reference temperature coefficients command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Get/Set Filter wheel reference temperature coefficients command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParseFWTEMP(circByteBuffer_t *cbuf)
{
   uint8_t argStr[10];
   uint32_t arglen;
   float fwTemp_m;
   float fwTemp_b;

   // Check for FWTEMP command argument presence
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      // Read FWTEMP command m argument
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (ParseFloatNumDec((char *)argStr, arglen, &fwTemp_m) != IRC_SUCCESS)
      {
         DT_ERR("Invalid FWTEMP command m argument.");
         return IRC_FAILURE;
      }

      // Read FWTEMP command b argument
      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (ParseFloatNumDec((char *)argStr, arglen, &fwTemp_b) != IRC_SUCCESS)
      {
         DT_ERR("Invalid FWTEMP command b argument.");
         return IRC_FAILURE;
      }

      // There is supposed to be no remaining bytes in the buffer
      if (!DebugTerminal_CommandIsEmpty(cbuf))
      {
         DT_ERR("Unsupported command arguments.");
         return IRC_FAILURE;
      }

      if (GC_FWSynchronouslyRotatingModeIsImplemented)
      {
         flashSettings.FWReferenceTemperatureGain = fwTemp_m;
         flashSettings.FWReferenceTemperatureOffset = fwTemp_b;
      }
   }

   if (!GC_FWSynchronouslyRotatingModeIsImplemented)
   {
      DT_ERR("Filter wheel synchronously rotating mode is not implemented.");
      return IRC_FAILURE;
   }

   DT_PRINTF("FW Reference Temperature : m = " _PCF(3) ", b = " _PCF(3) "\n",  _FFMT(flashSettings.FWReferenceTemperatureGain, 3), _FFMT(flashSettings.FWReferenceTemperatureOffset, 3));

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
            (adc_b < SHRT_MIN) || (adc_b > SHRT_MAX))
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
         flashSettings.ADCReadout_b = (int16_t)adc_b;

         if (ADC_readout_init() != IRC_SUCCESS)
         {
            DT_ERR("Failed to update ADC Readout calibration.");
            return IRC_FAILURE;
         }
      }
   }

   if (!TDCFlagsTst(ADCReadoutIsImplementedMask))
   {
      DT_ERR("ADC Readout is disabled.");
      return IRC_FAILURE;
   }

   DT_PRINTF("ADC Readout: m = " _PCF(6) ", b = %d\n", _FFMT(flashSettings.ADCReadout_m, 6), flashSettings.ADCReadout_b);

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
 * Flash Dynamic Values command parser.
 * This parser is used to parse and validate Flash Dynamic Values command arguments
 * and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Flash Dynamic Values command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParseFDV(circByteBuffer_t *cbuf)
{
   extern flashDynamicValues_t gFlashDynamicValues;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Print flash dynamic values
   FlashDynamicValues_PrintFlashDynamicValuesFileHeader(&gFlashDynamicValues);

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
   GC_UpdateDeviceSerialPortFunction(port);

   DT_PRINTF("Debug terminal output set to %s.", argStr);

   return IRC_SUCCESS;
}

/**
 * Filter Wheel Settings command parser.
 * This parser is used to parse and validate Filter Wheel Settings command arguments and to
 * execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Filter Wheel Settings command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFWPID(circByteBuffer_t *cbuf)
{
   extern FW_config_t FW_config[FW_Config_table_size];
   FW_Config_type_t config;
   uint8_t argStr[5], valueStr[6];
   uint32_t arglen, valuelen;
   uint32_t value;

   // Read config
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid config value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator

   if (strcasecmp((char *)argStr, "POS") == 0)
   {
      config = FW_Position_Pid;
   }
   else if (strcasecmp((char *)argStr, "SLOW") == 0)
   {
      config = FW_Vel_Pid_Slow;
   }
   else if (strcasecmp((char *)argStr, "FAST") == 0)
   {
      config = FW_Vel_Pid_Fast;
   }
   else
   {
      DT_ERR("Unknown config value.");
      return IRC_FAILURE;
   }

   // Read PID parameter
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (arglen == 0)
   {
      DT_ERR("Invalid parameter value.");
      return IRC_FAILURE;
   }
   argStr[arglen++] = '\0'; // Add string terminator


   // Read PID VALUE
   valuelen = GetNextArg(cbuf, valueStr, sizeof(valueStr) - 1);
   if (ParseNumArg((char *)valueStr, valuelen, &value) != IRC_SUCCESS)
   {
      DT_ERR("Invalid value.");
      return IRC_FAILURE;
   }


   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }


   if (strcasecmp((char *)argStr, "POR") == 0)
   {
      FW_config[config].POR = (uint8_t)value;
   }
   else if (strcasecmp((char *)argStr, "INT") == 0)
   {
      FW_config[config].I_GAIN = (uint8_t)value;
   }
   else if (strcasecmp((char *)argStr, "PP") == 0)
   {
      FW_config[config].PP = (uint8_t)value;
   }
   else if (strcasecmp((char *)argStr, "PD") == 0)
   {
      FW_config[config].PD = (uint8_t)value;
   }
   else if (strcasecmp((char *)argStr, "SP") == 0)
   {
      FW_config[config].maxVelocity = (uint16_t)value;
   }
   else
   {
      DT_ERR("Unknown parameter value.");
      return IRC_FAILURE;
   }

   FWControllerReset();

   return IRC_SUCCESS;
}

/**
 * Lens Table command parser.
 * This parser is used to parse and validate Lens Table
 * command arguments and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Lens Table command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseLT(circByteBuffer_t *cbuf)
{
   extern lensTable_t lensLookUpTable;
   uint8_t argStr[6];
   uint32_t arglen;
   uint32_t rowIndex, fieldIndex, value;

   // Read row index
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if ((ParseNumArg((char *)argStr, arglen, &rowIndex) != IRC_SUCCESS) ||
         (rowIndex >= RP_OPT_TABLE_LEN))
   {
      DT_ERR("Invalid rowIndex.");
      return IRC_FAILURE;
   }

   // Read field index
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if ((ParseNumArg((char *)argStr, arglen, &fieldIndex) != IRC_SUCCESS) ||
         (fieldIndex > 9))
   {
      DT_ERR("Invalid fieldIndex.");
      return IRC_FAILURE;
   }

   // Read value
   arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
   if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS)
   {
      DT_ERR("Invalid value.");
      return IRC_FAILURE;
   }

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Apply value to lensLookUpTable
   switch (fieldIndex)
   {
      case 0:
         lensLookUpTable.zoom[rowIndex] = (uint16_t)value;
         break;
      case 3:
         lensLookUpTable.focusAtTemp1[rowIndex] = (uint16_t)value;
         break;
      case 4:
         lensLookUpTable.focusAtTemp2[rowIndex] = (uint16_t)value;
         break;
      case 5:
         lensLookUpTable.focusAtTemp3[rowIndex] = (uint16_t)value;
         break;
      case 6:
         lensLookUpTable.focusAtTemp4[rowIndex] = (uint16_t)value;
         break;
      case 7:
         lensLookUpTable.focusAtTemp5[rowIndex] = (uint16_t)value;
         break;
      case 8:
         lensLookUpTable.focusAtTemp6[rowIndex] = (uint16_t)value;
         break;
      case 9:
         lensLookUpTable.focusAtTemp7[rowIndex] = (uint16_t)value;
         break;
      default:
         DT_ERR("Unknown fieldIndex");
         return IRC_FAILURE;
   }

   uint16_t addr = ZF_LOOK_UP_TABLE_ADDR + (rowIndex * 22) + (fieldIndex * 2);
   uint8_t byte0, byte1;
   uint8_t buf[2];
   byte0 = (uint8_t)(value % 256);
   byte1 = (uint8_t)(value / 256);
   buf[0] = byte0;
   buf[1] = byte1;

   // Transmit to lens
   if (flashSettings.MotorizedLensType == MLT_RPOpticalODEM660)
   {
      setAddress(&theRpCtrl, addr);       // toDo ECL Ajouter les valeurs -40deg et +80deg en extra
      writeData(&theRpCtrl, 2, buf);
   }

   return IRC_SUCCESS;
}

/**
 * Print Lens Table command parser.
 * This parser is used to parse and validate Print Lens Table
 * command arguments and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Print Lens Table command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParsePLT(circByteBuffer_t *cbuf)
{
   extern lensTable_t lensLookUpTable;
   uint32_t i;

   // There is supposed to be no remaining bytes in the buffer
   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   DT_PRINTF("Lens look-up table");
   DT_PRINTF("rowIndex\tzoom\tfoc%d\tfoc%d\tfoc%d\tfoc%d\tfoc%d\tfoc%d\tfoc%d\tDFocMin\tDFocMax\tfocLen",
         (int8_t)FOCUS_TEMP_1, (int8_t)FOCUS_TEMP_2, (int8_t)FOCUS_TEMP_3, (int8_t)FOCUS_TEMP_4, (int8_t)FOCUS_TEMP_5, (int8_t)FOCUS_TEMP_6, (int8_t)FOCUS_TEMP_7);
   for (i = 0; i < RP_OPT_TABLE_LEN; i++)
   {
      DT_PRINTF("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d", i, lensLookUpTable.zoom[i],
            lensLookUpTable.focusAtTemp1[i], lensLookUpTable.focusAtTemp2[i], lensLookUpTable.focusAtTemp3[i], lensLookUpTable.focusAtTemp4[i],
            lensLookUpTable.focusAtTemp5[i], lensLookUpTable.focusAtTemp6[i], lensLookUpTable.focusAtTemp7[i],
            lensLookUpTable.deltaFocusMin[i], lensLookUpTable.deltaFocusMax[i], lensLookUpTable.focalLength[i]);
   }

   return IRC_SUCCESS;
}


/**
 * Print Buffer Table command parser
 * This parser is used to parse and validate Print Buffer Table
 * command arguments and to execute the command.
 *
 * @param cbuf is the pointer to the circular buffer containing the data to be parsed.
 *
 * @return IRC_SUCCESS when Print Buffer Table command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
static IRC_Status_t DebugTerminalParsePBT(circByteBuffer_t *cbuf)
{
   extern t_memoryTable gMemoryTable;
   uint32_t i;

   DT_PRINTF("Buffer Table:");
   for (i = 0; i < gMemoryTable.NbValidSequences; i++)
   {
      uint64_t addr = (uint64_t)gMemoryTable.data[i].startAddress << BM_ADDRBITS_ALIGN;
      DT_PRINTF("Seq %u: startAddr=0x%08x%08x, bufLen=%u, width=%u, height=%u, offX=%u, offY=%u, "
                "start=%u, stop=%u, moi=%u",
                i, (uint32_t) (addr >> 32),  (uint32_t) (addr & 0x00000000ffffffffull),
                gMemoryTable.data[i].bufferLength,
                gMemoryTable.data[i].imageWidth,  gMemoryTable.data[i].imageHeight,
                gMemoryTable.data[i].OffsetX,  gMemoryTable.data[i].OffsetY,
                gMemoryTable.data[i].bufImgIdx.start_img, gMemoryTable.data[i].bufImgIdx.stop_img,
                gMemoryTable.data[i].bufImgIdx.moi_img);
   }

   return IRC_SUCCESS;
}


/**
 * Debug terminal get FB status & errors.
 *
 * @return IRC_SUCCESS when FB command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseFB(circByteBuffer_t *cbuf)
{
   #ifdef MEM_4DDR
   extern t_FB gFB_ctrl;
   t_FrameBufferStatus status;

   DT_PRINTF("FB_BUFFER_A_BASE_ADDR = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_BUFFER_A_BASE_ADDR_OFFSET));
   DT_PRINTF("FB_BUFFER_B_BASE_ADDR = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_BUFFER_B_BASE_ADDR_OFFSET));
   DT_PRINTF("FB_BUFFER_C_BASE_ADDR = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_BUFFER_C_BASE_ADDR_OFFSET));
   DT_PRINTF("FB_FRAME_BYTE_SIZE    = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_FRAME_BYTE_SIZE_OFFSET));
   DT_PRINTF("FB_HDR_PIX_SIZE       = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_HDR_PIX_SIZE_OFFSET));
   DT_PRINTF("FB_IMG_PIX_SIZE       = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_IMG_PIX_SIZE_OFFSET));
   DT_PRINTF("FB_LVAL_PAUSE_MIN     = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_LVAL_PAUSE_MIN_OFFSET));
   DT_PRINTF("FB_FVAL_PAUSE_MIN     = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_FVAL_PAUSE_MIN_OFFSET));
   DT_PRINTF("FB_BYPASS             = 0x%08X",  AXI4L_read32(gFB_ctrl.ADD + FB_BYPASS_OFFSET));

   status = FB_getStatusAndErrors(&gFB_ctrl);

   DT_PRINTF("FrameBuffer.Input_FR  = (min=%u, present=%u, max=%u) fps", status.FB_in_FR_min, status.FB_in_FR, status.FB_in_FR_max);
   DT_PRINTF("FrameBuffer.Output_FR = (min=%u, present=%u, max=%u) fps", status.FB_out_FR_min, status.FB_out_FR, status.FB_out_FR_max);

   DT_PRINTF("ERRORS = 0x%08X", status.errors);
   DT_PRINTF("STATUS = 0x%08X", status.global_status);

   return IRC_SUCCESS;

   #else
   DT_PRINTF("Frame Buffer is not implemented.");
   return IRC_SUCCESS;
   #endif
}


/**
 * Debug terminal get Hardware ID.
 *
 * @return IRC_SUCCESS when HWID command was successfully executed.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseHWID(circByteBuffer_t *cbuf)
{
   extern detected_hw_t gDetectedHw;
   Get_board_hw_revision(XPAR_AXI_GPIO_0_DEVICE_ID,&gDetectedHw);
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

   DT_PRINTF("Processing FPGA debug terminal commands:");
   DT_PRINTF("  Read memory:        RDM address [c|u8|u16|u32|s8|s16|s32 length]");
   DT_PRINTF("  Write memory:       WRM address value");
   DT_PRINTF("  IRIG status:        IRIG [DLY value]");
   DT_PRINTF("  FPA status:         FPA [POL|REF|OFF|ETOFF|REGA|REGB|REGC|REGD|REGE|REGF|REGG|REGH|REGI|REGJ|REGK|REGL|REGM|STAR|SATU|REF1|REF2|BIAS value]");
   DT_PRINTF("  FPA config:         FPACFG");
   DT_PRINTF("  xro3503A status:    XRO [BIAS|DETECTSUB|CTIAREF|VTESTG|CM|VCMO|LOVH|SWM value]");
   DT_PRINTF("  calciumD status:    CCM [VA1P8|VPIXRST|VDHS1P8|VD1P8|VA3P3|VDETGUARD|VDETCOM|VPIXQNB|WARNLED|KPIX|COMPR|FREQ|SHIFT value]");
   DT_PRINTF("  calciumD register:  CCMREG RD|WR [address value]");
   DT_PRINTF("  HDER status:        HDER");
   DT_PRINTF("  CAL status:         CAL");
   DT_PRINTF("  TRIG status:        TRIG");
   DT_PRINTF("  Buffering status:   BUF");
   DT_PRINTF("  Camera status:      STATUS");
   DT_PRINTF("  Power status:       POWER");
   DT_PRINTF("  Network status:     NET [0|1 [port]]");
   DT_PRINTF("  Actualization:      ACT DBG|RST|INV|CLR|ICU|XBB|AEC|VRB|STP|LST|FR|CNST [value]");
   DT_PRINTF("  List files:         LS [FILE|COL|BLOCK|NL|ICU|ACT]");
   DT_PRINTF("  Remove file:        RM filename");
   DT_PRINTF("  File order:         FO FILE|COL|BLOCK|NL|ICU|ACT [NONE|POSIX|TYPE|NAME|CTYPE|FW|NDF|LENS|FOV]");
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
   DT_PRINTF("  ADC Readout:        ADC [m b]");
   DT_PRINTF("  Flash Settings:     FS");
   DT_PRINTF("  Flash Dynamic Val.: FDV");
   DT_PRINTF("  Debug Term. Output: DTO CLINK|OEM|USB");
   DT_PRINTF("  FW PID Settings:    FWPID POS|SLOW|FAST POR|INT|PP|PD|SP value");
   DT_PRINTF("  FW Reference Temp.: FWTEMP [m b]");
   DT_PRINTF("  Ctrl Intf status:   CI [SB|LB PLEORA|OEM|CLINK|OUTPUT|USART 0|1]");
   DT_PRINTF("  Lens Table:         LT rowIndex fieldIndex value");
   DT_PRINTF("  Print Lens Table:   PLT");
   DT_PRINTF("  Print Buffer Table: PBT");
   DT_PRINTF("  FB status & errors: FB");
   DT_PRINTF("  Get Hardware ID:    HWID");
   DT_PRINTF("  Print help:         HLP");

   /*
   Hidden commands:
      Reset device key:    KEY RESET
      Disable FDV update:  DFDVU
   */

   return IRC_SUCCESS;
}

