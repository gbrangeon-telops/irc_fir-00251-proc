/**
 *  @file proc_init.c
 *  Processing FPGA initialization module implementation.
 *  
 *  This file implements the processing FPGA initialization module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "proc_init.h"
#include "IRC_Status.h"
#include "xparameters.h"
#include "proc_memory.h"
#include "xil_exception.h"
#include "FileManager.h"
#include "FirmwareUpdater.h"
#include "GC_Manager.h"
#include "GC_Poller.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "Timer.h"
#include "power_Ctrl.h"
#include "tel2000_param.h"
#include "gps.h"
#include "FaulhaberProtocol.h"
#include "xintc.h"
#include "QSPIFlash.h"
#include "FPA_intf.h"
#include "FlashSettings.h"
#include "mgt_ctrl.h"
#include "exposure_time_ctrl.h"
#include "Trig_gen.h"
#include "fan_ctrl.h"
#include "calib.h"
#include "flash-interface.h"
#include "ReleaseInfo.h"
#include "AEC.h"
#include "BufferManager.h"
#include "EHDRI_Manager.h"
#include "FlashDynamicValues.h"
#include "ICU.h"
#include "hder_inserter.h"
#include "FWController.h"
#include "SFW_ctrl.h"
#include "SFW_MathematicalModel.h"
#include "NDFController.h"
#include "GC_Callback.h"
#include "XADC.h"
#include "CtrlInterface.h"
#include "UART_Utils.h"
#include "NetworkInterface.h"
#include "flagging.h"
#include "gating.h"
#include "DebugTerminal.h"
#include "DeviceKey.h"
#include <string.h>


// Global variables
t_Trig gTrig = Trig_Ctor(TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR);
t_ExposureTime gExposureTime = ExposureTime_Ctor(TEL_PAR_TEL_EXPTIM_CTRL_BASEADDR);
t_FpaIntf gFpaIntf = FpaIntf_Ctor(TEL_PAR_TEL_FPA_CTRL_BASEADDR);
int16_t gFpaDetectorPolarizationVoltage = 0;
float gFpaDetectorElectricalTapsRef = 0.0F;
float gFpaDetectorElectricalRefOffset = 0.0F;
int32_t gFpaDebugRegA = 0;
int32_t gFpaDebugRegB = 0;
int32_t gFpaDebugRegC = 0;
int32_t gFpaDebugRegD = 0;
t_HderInserter gHderInserter = HderInserter_Ctor(TEL_PAR_TEL_HEADER_CTRL_BASEADDR);
t_fan gFan = FAN_Ctor(TEL_PAR_TEL_FAN_CTRL_BASEADDR);
t_calib gCal = CAL_Config_Ctor(TEL_PAR_TEL_CAL_CTRL_BASEADDR);
t_AEC gAEC_Ctrl = AEC_Intf_Ctor(TEL_PAR_TEL_AEC_CTRL_BASEADDR);
ICU_config_t gICU_ctrl = ICU_config_Ctor(TEL_PAR_TEL_ICU_CTRL_BASEADDR);
t_bufferManager gBufManager = Buffering_Intf_Ctor(TEL_PAR_TEL_BUFFERING_CTRL_BASEADDR);
t_EhdriManager gEHDRIManager = Ehdri_Intf_Ctor(TEL_PAR_TEL_EHDRI_CTRL_BASEADDR);
t_mgt gMGT = MGT_Ctor(TEL_PAR_TEL_MGT_CTRL_BASEADDR);
t_FlagCfg gFlagging_ctrl = Flagging_config_Ctor(TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR + FLAGGING_AXILITE_OFFSET);
t_GatingCfg gGating_ctrl = Gating_config_Ctor(TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR + GATING_AXILITE_OFFSET);
t_SfwCtrl gSFW_Ctrl = sfw_Intf_Ctor(TEL_PAR_TEL_SFW_CTRL_BASEADDR);

XIntc gProcIntc;
t_GPS Gps_struct;
netIntf_t gNetworkIntf;

circularUART_t gCircularUART_USB;
circularUART_t gCircularUART_NTxMini;
circularUART_t gCircularUART_RS232;
circularUART_t gCircularUART_CameraLink;
circularUART_t gCircularUART_OutputFPGA;
usart_t gUSART_NTxMiniBulk;

debugTerminal_t gDebugTerminal;
IRC_Status_t gDebugTerminalStatus;
ctrlIntf_t gCtrlIntf_NTxMini;
ctrlIntf_t gCtrlIntf_OEM;
ctrlIntf_t gCtrlIntf_CameraLink;
ctrlIntf_t gCtrlIntf_OutputFPGA;
ctrlIntf_t gCtrlIntf_FileManager;

qspiFlash_t gQSPIFlash;
FH_ctrl_t gFWFaulhaberCtrl;
FH_ctrl_t gNDFFaulhaberCtrl;
releaseInfo_t gReleaseInfo;
ledCtrl_t gLedCtrl;
flashDynamicValues_t gFlashDynamicValues;


/**
 * Initializes network interface
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_NI_Init()
{
   static networkCommand_t niCmdQueueBuffer[NI_CMD_QUEUE_SIZE];
   static circBuffer_t niCmdQueue =
         CB_Ctor(niCmdQueueBuffer, NI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   return NetIntf_Init(&gNetworkIntf, NIA_PROCESSING_FPGA, &niCmdQueue);
}

/**
 * Initializes device serial ports
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_DeviceSerialPorts_Init()
{
   IRC_Status_t status;
   IRC_Status_t retval = IRC_SUCCESS;

   // Initialize USB UART serial port
   status = CircularUART_Init(&gCircularUART_USB,
         XPAR_AXI_USB_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_USB_UART_IP2INTC_IRPT_INTR);
   if (status == IRC_SUCCESS)
   {
      // Configure USB UART serial port
      if (UART_Config(&gCircularUART_USB.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
      {
         retval = IRC_FAILURE;
      }
   }
   else
   {
      retval = IRC_FAILURE;
   }

   // Initialize Camera Link UART serial port
   status = CircularUART_Init(&gCircularUART_CameraLink,
         XPAR_CLINK_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_CLINK_UART_IP2INTC_IRPT_INTR);
   if (status == IRC_SUCCESS)
   {
      // Configure Camera Link UART serial port
      if (UART_Config(&gCircularUART_CameraLink.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
      {
         retval = IRC_FAILURE;
      }
   }
   else
   {
      retval = IRC_FAILURE;
   }

   // Initialize NTx-Mini UART serial port
   status = CircularUART_Init(&gCircularUART_NTxMini,
         XPAR_PLEORA_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);
   if (status == IRC_SUCCESS)
   {
      // Configure NTx-Mini UART serial port
      if (UART_Config(&gCircularUART_NTxMini.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
      {
         retval = IRC_FAILURE;
      }
   }
   else
   {
      retval = IRC_FAILURE;
   }


   // Initialize RS-232 UART serial port
   status = CircularUART_Init(&gCircularUART_RS232,
         XPAR_OEM_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_OEM_UART_IP2INTC_IRPT_INTR);
   if (status == IRC_SUCCESS)
   {
      // Configure RS-232 UART serial port
      if (UART_Config(&gCircularUART_RS232.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
      {
         retval = IRC_FAILURE;
      }
   }
   else
   {
      retval = IRC_FAILURE;
   }

   // Initialize Output FPGA UART serial port
   status = CircularUART_Init(&gCircularUART_OutputFPGA,
         XPAR_FPGA_OUTPUT_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_FPGA_OUTPUT_UART_IP2INTC_IRPT_INTR);
   if (status == IRC_SUCCESS)
   {
      // Configure Output FPGA UART serial port
      if (UART_Config(&gCircularUART_OutputFPGA.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
      {
         retval = IRC_FAILURE;
      }
   }
   else
   {
      retval = IRC_FAILURE;
   }

   // Initialize USART serial port
   status = Usart_Init(&gUSART_NTxMiniBulk,
         TEL_PAR_TEL_USART_CTRL_BASEADDR,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_SYSTEM_BULK_INTERRUPT_0_INTR);
   if (status != IRC_SUCCESS)
   {
      retval = IRC_FAILURE;
   }

   return retval;
}

/**
 * Initializes debug terminal (phase 1).
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_DebugTerminal_InitPhase1()
{
   static uint8_t dtRxCircBufferBytes[DT_UART_RX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t dtRxCircBuffer;

   static uint8_t dtTxCircBufferBytes[DT_UART_TX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t dtTxCircBuffer;

   // Initialize debug terminal RX circular buffer
   if (CBB_Init(&dtRxCircBuffer, dtRxCircBufferBytes, DT_UART_RX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize debug terminal TX circular buffer
   if (CBB_Init(&dtTxCircBuffer, dtTxCircBufferBytes, DT_UART_TX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize debug terminal data structure
   if (DebugTerminal_Init(&gDebugTerminal, &dtRxCircBuffer, &dtTxCircBuffer) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes debug terminal (phase 2).
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_DebugTerminal_InitPhase2()
{
   circularUART_t *p_cuart = &gCircularUART_USB;

   if (gFlashDynamicValues.DeviceSerialPortFunctionRS232 == DSPF_Terminal)
   {
      p_cuart = &gCircularUART_RS232;
   }

   // Connect USB UART serial port to debug terminal interface
   if (DebugTerminal_SetSerial(&gDebugTerminal, p_cuart) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes debug terminal (phase 3).
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_DebugTerminal_InitPhase3()
{
   static networkCommand_t dtCmdQueueBuffer[DT_CMD_QUEUE_SIZE];
   static circBuffer_t dtCmdQueue =
         CB_Ctor(dtCmdQueueBuffer, DT_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Connect debug terminal to network interface
   if (DebugTerminal_Connect(&gDebugTerminal, &gNetworkIntf, &dtCmdQueue) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }
   
   // Look for global debug terminal initialization tests result
   if (gDebugTerminalStatus != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes file manager
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FM_Init()
{
   static uint8_t fmRxCircBufferBytes[FILE_CI_USART_RX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t fmRxCircBuffer;

   static uint8_t fmTxCircBufferBytes[FILE_CI_USART_TX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t fmTxCircBuffer;

   static networkCommand_t fmCtrlIntfCmdQueueBuffer[FM_CI_CMD_QUEUE_SIZE];
   static circBuffer_t fmCtrlIntfCmdQueue =
         CB_Ctor(fmCtrlIntfCmdQueueBuffer, FM_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   static networkCommand_t fmCmdQueueBuffer[FM_CMD_QUEUE_SIZE];
   static circBuffer_t fmCmdQueue =
         CB_Ctor(fmCmdQueueBuffer, FM_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   IRC_Status_t status;
   fileOrder_t keys[4];

   // Initialize file manager RX circular buffer
   if (CBB_Init(&fmRxCircBuffer, fmRxCircBufferBytes, FILE_CI_USART_RX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize file manager TX circular buffer
   if (CBB_Init(&fmTxCircBuffer, fmTxCircBufferBytes, FILE_CI_USART_TX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize file manager control interface
   status = CtrlIntf_Init(&gCtrlIntf_FileManager,
         CIP_F1F2,
         &fmRxCircBuffer,
         &fmTxCircBuffer,
         &gNetworkIntf,
         &fmCtrlIntfCmdQueue,
         NIP_CI_FILE_MANAGER);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Connect USART serial port to file manager control interface
   if (CtrlIntf_SetLink(&gCtrlIntf_FileManager, CILT_USART, &gUSART_NTxMiniBulk) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize file manager
   if (File_Manager_Init(&gNetworkIntf, &fmCmdQueue) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   keys[0] = gFlashDynamicValues.FileOrderKey1;
   keys[1] = gFlashDynamicValues.FileOrderKey2;
   keys[2] = gFlashDynamicValues.FileOrderKey3;
   keys[3] = gFlashDynamicValues.FileOrderKey4;
   FM_SetFileListKeys(&gFM_files, keys, 4);

   keys[0] = gFlashDynamicValues.CalibrationCollectionFileOrderKey1;
   keys[1] = gFlashDynamicValues.CalibrationCollectionFileOrderKey2;
   keys[2] = gFlashDynamicValues.CalibrationCollectionFileOrderKey3;
   keys[3] = gFlashDynamicValues.CalibrationCollectionFileOrderKey4;
   FM_SetFileListKeys(&gFM_collections, keys, 4);

   return IRC_SUCCESS;
}

/**
 * Initializes firmware updater
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FU_Init()
{
   static networkCommand_t fuCmdQueueBuffer[FU_CMD_QUEUE_SIZE];
   static circBuffer_t fuCmdQueue =
         CB_Ctor(fuCmdQueueBuffer, FU_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize firmware updater
   if (Firmware_Updater_Init(&gNetworkIntf, &fuCmdQueue, &gQSPIFlash) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes GenICam manager and GenICam registers.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_GC_Init()
{
   IRC_Status_t status;
   extern float* pGcRegsDataExposureTimeX[MAX_NUM_FILTER];

   // Initialize GenICam registers data pointer
   GC_Registers_Init();

   // Initialize GenICam registers callback function
   GC_Callback_Init();

   // Initialize GenICam register data
   gcRegsData = gcRegsDataFactory;

   // Initialize registers from flash dynamic values
   gcRegsData.PowerOnAtStartup = gFlashDynamicValues.PowerOnAtStartup;
   gcRegsData.AcquisitionStartAtStartup = gFlashDynamicValues.AcquisitionStartAtStartup;
   gcRegsData.StealthMode = gFlashDynamicValues.StealthMode;
   gcRegsData.BadPixelReplacement = gFlashDynamicValues.BadPixelReplacement;
   gcRegsData.DeviceKeyValidationLow = gFlashDynamicValues.DeviceKeyValidationLow;
   gcRegsData.DeviceKeyValidationHigh = gFlashDynamicValues.DeviceKeyValidationHigh;
   DeviceSerialPortFunctionAry[DSPS_RS232] = gFlashDynamicValues.DeviceSerialPortFunctionRS232;
   if (DeviceSerialPortFunctionAry[DSPS_RS232] == DSPF_Terminal)
   {
      DeviceSerialPortFunctionAry[DSPS_USB] = DSPF_Disabled;
   }

   // Initialize pointer array on ExposureTimeX registers
   pGcRegsDataExposureTimeX[0] = &gcRegsData.ExposureTime1;
   pGcRegsDataExposureTimeX[1] = &gcRegsData.ExposureTime2;
   pGcRegsDataExposureTimeX[2] = &gcRegsData.ExposureTime3;
   pGcRegsDataExposureTimeX[3] = &gcRegsData.ExposureTime4;
   pGcRegsDataExposureTimeX[4] = &gcRegsData.ExposureTime5;
   pGcRegsDataExposureTimeX[5] = &gcRegsData.ExposureTime6;
   pGcRegsDataExposureTimeX[6] = &gcRegsData.ExposureTime7;
   pGcRegsDataExposureTimeX[7] = &gcRegsData.ExposureTime8;

   // Initialize image size limits
   gcRegsData.WidthInc = lcm(FPA_WIDTH_MULT, 2 * FPA_OFFSETX_MULT);
   gcRegsData.WidthMin = roundUp(FPA_WIDTH_MIN, gcRegsData.WidthInc);
   gcRegsData.HeightInc = lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT);
   gcRegsData.HeightMin = roundUp(FPA_HEIGHT_MIN, gcRegsData.HeightInc);
   GC_ComputeImageLimits();   // must be called first

   // Memory buffer GenICam registers initialization
   GC_MemoryBufferNumberOfImagesMaxCallback(GCCP_BEFORE, GCCA_READ);
   GC_MemoryBufferNumberOfSequencesMaxCallback(GCCP_BEFORE, GCCA_READ);
   GC_MemoryBufferSequenceSizeMaxCallback(GCCP_BEFORE, GCCA_READ);
   gcRegsData.MemoryBufferNumberOfSequences = gcRegsData.MemoryBufferNumberOfSequencesMax;

   GC_UpdateLockedFlag();
   GC_UpdateFpaPeriodMinMargin();
   GC_UpdateParameterLimits();

   static uint8_t genicamTxCircBufferBytes[GENICAM_UART_TX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t genicamTxCircBuffer;

   // Initialize GenICam control interfaces TX circular buffer
   if (CBB_Init(&genicamTxCircBuffer, genicamTxCircBufferBytes, GENICAM_UART_TX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /************************************************************************************
    * Camera Link GenICam Control interface
    ************************************************************************************/

   static uint8_t clinkRxCircBufferBytes[CLINK_CI_UART_RX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t clinkRxCircBuffer;

   static networkCommand_t clinkCtrlIntfCmdQueueBuffer[CLINK_CI_CMD_QUEUE_SIZE];
   static circBuffer_t clinkCtrlIntfCmdQueue =
         CB_Ctor(clinkCtrlIntfCmdQueueBuffer, CLINK_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize Camera Link GenICam control interface RX circular buffer
   if (CBB_Init(&clinkRxCircBuffer, clinkRxCircBufferBytes, CLINK_CI_UART_RX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize Camera Link GenICam control interface
   status = CtrlIntf_Init(&gCtrlIntf_CameraLink,
         CIP_F1F2,
         &clinkRxCircBuffer,
         &genicamTxCircBuffer,
         &gNetworkIntf,
         &clinkCtrlIntfCmdQueue,
         NIP_CI_CLINK);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Connect Camera Link UART serial port to Camera Link GenICam control interface
   if (CtrlIntf_SetLink(&gCtrlIntf_CameraLink, CILT_CUART, &gCircularUART_CameraLink) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /************************************************************************************
    * NTx-Mini GenICam Control interface
    ************************************************************************************/

   static uint8_t ntxMiniRxCircBufferBytes[NTXMINI_CI_UART_RX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t ntxMiniRxCircBuffer;

   static networkCommand_t ntxMiniCtrlIntfCmdQueueBuffer[NTXMINI_CI_CMD_QUEUE_SIZE];
   static circBuffer_t ntxMiniCtrlIntfCmdQueue =
         CB_Ctor(ntxMiniCtrlIntfCmdQueueBuffer, NTXMINI_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize NTx-Mini GenICam control interface RX circular buffer
   if (CBB_Init(&ntxMiniRxCircBuffer, ntxMiniRxCircBufferBytes, NTXMINI_CI_UART_RX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize NTx-Mini GenICam control interface
   status = CtrlIntf_Init(&gCtrlIntf_NTxMini,
         CIP_PLEORA,
         &ntxMiniRxCircBuffer,
         &genicamTxCircBuffer,
         &gNetworkIntf,
         &ntxMiniCtrlIntfCmdQueue,
         NIP_CI_PLEORA);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Connect NTx-Mini UART serial port to NTx-Mini GenICam control interface
   if (CtrlIntf_SetLink(&gCtrlIntf_NTxMini, CILT_CUART, &gCircularUART_NTxMini) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /************************************************************************************
    * OEM GenICam Control interface
    ************************************************************************************/

   static uint8_t oemRxCircBufferBytes[OEM_CI_UART_RX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t oemRxCircBuffer;

   static networkCommand_t oemCtrlIntfCmdQueueBuffer[OEM_CI_CMD_QUEUE_SIZE];
   static circBuffer_t oemCtrlIntfCmdQueue =
         CB_Ctor(oemCtrlIntfCmdQueueBuffer, OEM_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize OEM GenICam control interface RX circular buffer
   if (CBB_Init(&oemRxCircBuffer, oemRxCircBufferBytes, OEM_CI_UART_RX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize OEM GenICam control interface
   status = CtrlIntf_Init(&gCtrlIntf_OEM,
         CIP_F1F2,
         &oemRxCircBuffer,
         &genicamTxCircBuffer,
         &gNetworkIntf,
         &oemCtrlIntfCmdQueue,
         NIP_CI_OEM);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   if (DeviceSerialPortFunctionAry[DSPS_RS232] != DSPF_Terminal)
   {
      // Connect RS-232 UART serial port to OEM GenICam control interface
      if (CtrlIntf_SetLink(&gCtrlIntf_OEM, CILT_CUART, &gCircularUART_RS232) != IRC_SUCCESS)
      {
         return IRC_FAILURE;
      }
   }

   /************************************************************************************
    * Output FPGA Control interface
    ************************************************************************************/

   static uint8_t outputRxCircBufferBytes[OUTPUT_CI_UART_RX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t outputRxCircBuffer;

   static uint8_t outputTxCircBufferBytes[OUTPUT_CI_UART_TX_CIRC_BUFFER_SIZE];
   static circByteBuffer_t outputTxCircBuffer;

   static networkCommand_t outputCtrlIntfCmdQueueBuffer[OUTPUT_CI_CMD_QUEUE_SIZE];
   static circBuffer_t outputCtrlIntfCmdQueue =
         CB_Ctor(outputCtrlIntfCmdQueueBuffer, OUTPUT_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize Output FPGA control interface RX circular buffer
   if (CBB_Init(&outputRxCircBuffer, outputRxCircBufferBytes, OUTPUT_CI_UART_RX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize Output FPGA control interface TX circular buffer
   if (CBB_Init(&outputTxCircBuffer, outputTxCircBufferBytes, OUTPUT_CI_UART_TX_CIRC_BUFFER_SIZE) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize Output FPGA control interface
   status = CtrlIntf_Init(&gCtrlIntf_OutputFPGA,
         CIP_F1F2_NETWORK,
         &outputRxCircBuffer,
         &outputTxCircBuffer,
         &gNetworkIntf,
         &outputCtrlIntfCmdQueue,
         NIP_UNDEFINED);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Connect Output FPGA UART serial port to Output FPGA control interface
   if (CtrlIntf_SetLink(&gCtrlIntf_OutputFPGA, CILT_CUART, &gCircularUART_OutputFPGA) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /************************************************************************************
    * GenICam manager
    ************************************************************************************/

   static networkCommand_t gcmCmdQueueBuffer[GCM_CMD_QUEUE_SIZE];
   static circBuffer_t gcmCmdQueue =
         CB_Ctor(gcmCmdQueueBuffer, GCM_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize GenICam Manager
   if (GC_Manager_Init(&gNetworkIntf, &gcmCmdQueue) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /************************************************************************************
    * GenICam events
    ************************************************************************************/

   static gcEvent_t gcEventErrorQueueBuffer[GC_EVENT_ERROR_QUEUE_SIZE];
   static circBuffer_t gcEventErrorQueue =
         CB_Ctor(gcEventErrorQueueBuffer, GC_EVENT_ERROR_QUEUE_SIZE, sizeof(gcEvent_t));

   // Initialize GenICam Events
   if (GC_Events_Init(&gcEventErrorQueue, NULL) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /************************************************************************************
    * GenICam poller
    ************************************************************************************/

   static networkCommand_t gcpCmdQueueBuffer[GCP_CMD_QUEUE_SIZE];
   static circBuffer_t gcpCmdQueue =
         CB_Ctor(gcpCmdQueueBuffer, GCP_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   // Initialize GenICam Poller
   if (GC_Poller_Init(&gNetworkIntf, &gcpCmdQueue) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes QSPIFlash interface.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_QSPIFlash_Init()
{
   IRC_Status_t status;

   // QSPI flash initialization
   status = QSPIFlash_Init(&gQSPIFlash,
         XPAR_AXI_QUAD_SPI_0_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes power manager interface.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Power_Init(powerCtrl_t *p_powerCtrl)
{
   if (Power_Init(XPAR_POWER_MANAGEMENT_DEVICE_ID, &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_POWER_MANAGEMENT_IP2INTC_IRPT_INTR) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   Power_TurnOn(PC_FW);

   return IRC_SUCCESS;
}

/**
 * Initializes interrupt controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Intc_Init()
{
   XStatus status;

   status = XIntc_Initialize(&gProcIntc, XPAR_INTC_0_DEVICE_ID);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Starts interrupt controller.
 *
 * @return IRC_SUCCESS if successfully started.
 * @return IRC_FAILURE if failed to start.
 */
IRC_Status_t Proc_Intc_Start()
{
   XStatus status;

   /*
    * Start the interrupt controller such that interrupts are enabled for
    * all devices that cause interrupts, specifies real mode so that only
    * hardware interrupts are enabled.
    */
   status = XIntc_Start(&gProcIntc, XIN_REAL_MODE);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   /*
    * Enable the interrupt for the UartNs550 driver instances.
    */
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_GPS_UART_IP2INTC_IRPT_INTR);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FW_UART_IP2INTC_IRPT_INTR);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_NDF_UART_IP2INTC_IRPT_INTR);
   CircularUART_Enable(&gCircularUART_NTxMini);
   CircularUART_Enable(&gCircularUART_OutputFPGA);
   if (DeviceSerialPortFunctionAry[DSPS_CameraLink] != DSPF_Disabled) CircularUART_Enable(&gCircularUART_CameraLink);
   if (DeviceSerialPortFunctionAry[DSPS_RS232] != DSPF_Disabled) CircularUART_Enable(&gCircularUART_RS232);
   if (DeviceSerialPortFunctionAry[DSPS_USB] != DSPF_Disabled) CircularUART_Enable(&gCircularUART_USB);

   /*
    * Enable the interrupt for the USART driver instance.
    */
   Usart_Enable(&gUSART_NTxMiniBulk);

   /*
    * Enable the interrupt for the SPI driver instance.
    */
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR);

   /*
    * Enable the interrupt for the AEC instance.
    */
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_SYSTEM_AEC_INTC_0_INTR);

   /*
    * Enable the interrupt for the power push button.
    */
#ifndef STARTUP
   // Pushbutton interrupt is disabled for Startup tests
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_POWER_MANAGEMENT_IP2INTC_IRPT_INTR);
#endif

   /*
    * Initialize the exception table.
    */
   Xil_ExceptionInit();

   /*
    * Register the interrupt controller handler with the exception table.
    */
   Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
          (Xil_ExceptionHandler)XIntc_InterruptHandler,
          &gProcIntc);

   /*
    * Enable exceptions.
    */
   Xil_ExceptionEnable();

   return IRC_SUCCESS;
}

/**
 * Initializes GPS interface.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_GPS_Init()
{
   static uint8_t gpsRxDataCircBuffer[GPS_UART_RX_CIRC_BUFFER_SIZE];
   IRC_Status_t status;

   status = GPS_Init(&Gps_struct,
         XPAR_AXI_GPS_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_GPS_UART_IP2INTC_IRPT_INTR,
         gpsRxDataCircBuffer,
         GPS_UART_RX_CIRC_BUFFER_SIZE);

	if (status != IRC_SUCCESS)
	{
	  return IRC_FAILURE;
	}

	return IRC_SUCCESS;
}

/**
 * Initializes Faulhaber controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FH_Init()
{
    IRC_Status_t status;

    status = FH_init(&gcRegsData,
          &gFWFaulhaberCtrl,
         XPAR_FW_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_FW_UART_IP2INTC_IRPT_INTR);

   if (status != IRC_SUCCESS)
   {
     return IRC_FAILURE;
   }

   status = FH_init(&gcRegsData,
         &gNDFFaulhaberCtrl,
        XPAR_AXI_NDF_UART_DEVICE_ID,
        &gProcIntc,
        XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_NDF_UART_IP2INTC_IRPT_INTR);

   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Initializes and validate release info.
 *
 * @return IRC_SUCCESS if successfully initialized and validated.
 * @return IRC_FAILURE if failed to initialize or to validate.
 */
IRC_Status_t Proc_ReleaseInfo_Init()
{
   return ReleaseInfo_Read(&gQSPIFlash, &gReleaseInfo);
}

/**
 * Initializes sensor controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Sensor_Init()
{
   t_FpaStatus fpaStatus;

   FPA_Init(&fpaStatus, &gFpaIntf, &gcRegsData);

   return IRC_SUCCESS;
}

/**
 * Initializes flash dynamic values.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FlashDynamicValues_Init()
{
   // Recover flash dynamic values file update
   if (FlashDynamicValues_Recover() != IRC_SUCCESS)
   {
      FM_ERR("Failed to recover flash dynamic values file update.");
   }

   return FlashDynamicValues_Init(&gFlashDynamicValues);


   // TODO DAL Transf鲥r dans GC INit
}

/**
 * Initializes flash settings.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FlashSettings_Init()
{
   return FlashSettings_Init();
}

/**
 * Initializes LED controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Led_Init()
{
   return Led_Init(&gLedCtrl, XPAR_AXI_GPIO_0_DEVICE_ID);
}

/**
 * Initializes file system.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FileSystem_Init()
{
   if (uffs_main(0) != 0)
   {
      return IRC_FAILURE;
   }

#ifndef MOD_FAST
   FPGA_PRINTF("Warning: Flash interface is configured in slow mode.\n");
#endif

#ifdef LOW_FORMAT
   FPGA_PRINTF("Warning: Flash interface low format is activated.\n");
#endif

   return IRC_SUCCESS;
}

/**
 * Initializes fan controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Fan_Init()
{
   FAN_Init(&gFan);
   FAN_SET_PWM1(&gFan, 100.0); // FPGA FAN
   FAN_SET_PWM2(&gFan, 10.0); // Internal FAN
   GC_SetExternalFanSpeed(); // External FAN

   return IRC_SUCCESS;
}

/**
 * Initializes EHDRI controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_EHDRI_Init()
{
   EHDRI_Init(&gEHDRIManager);

   return IRC_SUCCESS;
}

/**
 * Initializes AEC controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_AEC_Init()
{
   return AEC_Init(&gcRegsData, &gAEC_Ctrl);
}

/**
 * Initializes MGT interface.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_MGT_Init()
{
   MGT_Init(&gMGT);
   MGT_ReadCoreStatus(&gMGT);
   MGT_ReadPLLStatus(&gMGT);

   return IRC_SUCCESS;
}

/**
 * Initializes filter wheel controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FW_Init()
{
   // Initialize the SFW Module even if not used
   SFW_CTRL_Init(&gcRegsData, &gSFW_Ctrl);

   //Check the filterwheel type(slow or fast)  and init the SFW mathematical model if needed
   if(flashSettings.FWType == FW_SYNC)
   {
      InitMathematicalModel(&gcRegsData);
   }
   else
   {
      SFW_Disable();
   }

	return FWControllerInit(&gFWFaulhaberCtrl);}

/**
 * Initializes neutral density filter controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_NDF_Init()
{
   return NDF_ControllerInit(&gNDFFaulhaberCtrl);
}

/**
 * Initializes exposure time controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_EXP_Init()
{
   EXP_Init(&gExposureTime, &gcRegsData);

   return IRC_SUCCESS;
}

/**
 * Initializes calibration data flow.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_CAL_Init()
{
   CAL_Init(&gCal, &gcRegsData);

   return IRC_SUCCESS;
}

/**
 * Initializes trigger controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Trigger_Init()
{
   TRIG_Init(&gTrig, &gcRegsData);
   FLAG_Init(&gFlagging_ctrl);
   GATING_Init(&gGating_ctrl);

   return IRC_SUCCESS;
}

/**
 * Initializes ICU controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_ICU_Init()
{
   return ICU_init(&gcRegsData, &gICU_ctrl);
}

/**
 * Initializes XADC.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_XADC_Init()
{
   return XADC_Init(XPAR_SYSMON_0_DEVICE_ID);
}

/**
 * Initializes memory buffer manager.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_BufferManager_Init()
{
   // Update ExternalMemoryBufferIsImplemented and owner of MemoryBuffer registers
   if (BufferManager_DetectExternalMemoryBuffer())
   {
        TDCFlagsSet(ExternalMemoryBufferIsImplementedMask);
        GC_SetMemoryBufferRegistersOwner(GCRO_Storage_FPGA);
   }
   else
   {
        TDCFlagsClr(ExternalMemoryBufferIsImplementedMask);
        GC_SetMemoryBufferRegistersOwner(GCRO_Processing_FPGA);
   }

   return BufferManager_Init(&gBufManager, &gcRegsData);
}

/**
 * Initializes general purpose 64-bit timer.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_Timer_Init()
{
   return Timer_Init(XPAR_TMRCTR_0_BASEADDR, XPAR_TMRCTR_0_CLOCK_FREQ_HZ);
}


/**
 * Device key validation.
 *
 * @return IRC_SUCCESS if device key is valid.
 * @return IRC_FAILURE if device key is not valid.
 */
IRC_Status_t Proc_DeviceKeyValidation()
{
   return DeviceKey_Validate(&flashSettings, &gFlashDynamicValues);
}
