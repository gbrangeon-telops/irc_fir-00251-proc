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
#include <string.h>


// Global variables
t_Trig gTrig = Trig_Ctor(TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR);
t_ExposureTime gExposureTime = ExposureTime_Ctor(TEL_PAR_TEL_EXPTIM_CTRL_BASEADDR);
t_FpaIntf gFpaIntf = FpaIntf_Ctor(TEL_PAR_TEL_FPA_CTRL_BASEADDR);
int16_t gFpaDetectorPolarizationVoltage = 0;
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
ctrlIntf_t gFileCtrlIntf;
ctrlIntf_t gClinkCtrlIntf;
ctrlIntf_t gPleoraCtrlIntf;
#if (OEM_UART_ENABLED)
ctrlIntf_t gOemCtrlIntf;
#endif
ctrlIntf_t gOutputCtrlIntf;
qspiFlash_t gQSPIFlash;
FH_ctrl_t gFaulhaberCtrl;
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
 * Initializes file manager
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_FM_Init()
{
   static uint8_t fileRxDataCircBuffer[FILE_CI_UART_RX_CIRC_BUFFER_SIZE];
   static uint8_t fmTxDataBuffer[FILE_CI_USART_TX_BUFFER_SIZE];
   static networkCommand_t fmCtrlIntfCmdQueueBuffer[FM_CI_CMD_QUEUE_SIZE];
   static circBuffer_t fmCtrlIntfCmdQueue =
         CB_Ctor(fmCtrlIntfCmdQueueBuffer, FM_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   static networkCommand_t fmCmdQueueBuffer[FM_CMD_QUEUE_SIZE];
   static circBuffer_t fmCmdQueue =
         CB_Ctor(fmCmdQueueBuffer, FM_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   IRC_Status_t status;

   // Initialize file manager control interface
   status = CtrlIntf_InitUSART(&gFileCtrlIntf,
         CIP_F1F2,
         TEL_PAR_TEL_USART_CTRL_BASEADDR,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_SYSTEM_BULK_INTERRUPT_0_INTR,
         fileRxDataCircBuffer,
         FILE_CI_UART_RX_CIRC_BUFFER_SIZE,
         fmTxDataBuffer,
         FILE_CI_USART_TX_BUFFER_SIZE,
         &gNetworkIntf,
         &fmCtrlIntfCmdQueue,
         NIP_CI_FILE_MANAGER);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize file manager
   if (File_Manager_Init(&gNetworkIntf, &fmCmdQueue) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

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
   static uint8_t clinkRxDataCircBuffer[CLINK_CI_UART_RX_CIRC_BUFFER_SIZE];
   static networkCommand_t clinkCtrlIntfCmdQueueBuffer[CLINK_CI_CMD_QUEUE_SIZE];
   static circBuffer_t clinkCtrlIntfCmdQueue =
         CB_Ctor(clinkCtrlIntfCmdQueueBuffer, CLINK_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   static uint8_t pleoraRxDataCircBuffer[PLEORA_CI_UART_RX_CIRC_BUFFER_SIZE];
   static networkCommand_t pleoraCtrlIntfCmdQueueBuffer[PLEORA_CI_CMD_QUEUE_SIZE];
   static circBuffer_t pleoraCtrlIntfCmdQueue =
         CB_Ctor(pleoraCtrlIntfCmdQueueBuffer, PLEORA_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

#if (OEM_UART_ENABLED)
   static uint8_t oemRxDataCircBuffer[OEM_CI_UART_RX_CIRC_BUFFER_SIZE];
   static networkCommand_t oemCtrlIntfCmdQueueBuffer[OEM_CI_CMD_QUEUE_SIZE];
   static circBuffer_t oemCtrlIntfCmdQueue =
         CB_Ctor(oemCtrlIntfCmdQueueBuffer, OEM_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));
#endif

   static uint8_t masterTxDataBuffer[MASTER_UART_TX_BUFFER_SIZE];

   static uint8_t outputRxDataCircBuffer[OUTPUT_CI_UART_RX_CIRC_BUFFER_SIZE];
   static uint8_t outputTxDataBuffer[OUTPUT_CI_UART_TX_BUFFER_SIZE];
   static networkCommand_t outputCtrlIntfCmdQueueBuffer[OUTPUT_CI_CMD_QUEUE_SIZE];
   static circBuffer_t outputCtrlIntfCmdQueue =
         CB_Ctor(outputCtrlIntfCmdQueueBuffer, OUTPUT_CI_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   static networkCommand_t gcmCmdQueueBuffer[GCM_CMD_QUEUE_SIZE];
   static circBuffer_t gcmCmdQueue =
         CB_Ctor(gcmCmdQueueBuffer, GCM_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   static gcEvent_t gcEventErrorQueueBuffer[GC_EVENT_ERROR_QUEUE_SIZE];
   static circBuffer_t gcEventErrorQueue =
         CB_Ctor(gcEventErrorQueueBuffer, GC_EVENT_ERROR_QUEUE_SIZE, sizeof(gcEvent_t));

   static networkCommand_t gcpCmdQueueBuffer[GCP_CMD_QUEUE_SIZE];
   static circBuffer_t gcpCmdQueue =
         CB_Ctor(gcpCmdQueueBuffer, GCP_CMD_QUEUE_SIZE, sizeof(networkCommand_t));

   IRC_Status_t status;

   // Initialize GenICam registers data pointer
   GC_Registers_Init();

   // Initialize GenICam registers callback function
   GC_Callback_Init();

   // Initialize GenICam register data
   gcRegsData = gcRegsDataFactory;

   // Initialize image size limits
   gcRegsData.WidthInc = lcm(FPA_WIDTH_MULT, 2 * FPA_OFFSETX_MULT);
   gcRegsData.WidthMin = roundUp(FPA_WIDTH_MIN, gcRegsData.WidthInc);
   gcRegsData.HeightInc = lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT);
   gcRegsData.HeightMin = roundUp(FPA_HEIGHT_MIN, gcRegsData.HeightInc);

   // Memory buffer GenICam registers initialization
   GC_MemoryBufferNumberOfImagesMaxCallback(GCCP_BEFORE, GCCA_READ);
   GC_MemoryBufferNumberOfSequencesMaxCallback(GCCP_BEFORE, GCCA_READ);
   GC_MemoryBufferSequenceSizeMaxCallback(GCCP_BEFORE, GCCA_READ);
   gcRegsData.MemoryBufferNumberOfSequences = gcRegsData.MemoryBufferNumberOfSequencesMax;

   GC_UpdateLockedFlag();
   GC_UpdateParameterLimits();
   GC_ComputeImageLimits();

   // Initialize Camera Link GenICam control interface
   status = CtrlIntf_InitCircularUART(&gClinkCtrlIntf,
         CIP_F1F2,
         XPAR_CLINK_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_CLINK_UART_IP2INTC_IRPT_INTR,
         clinkRxDataCircBuffer,
         CLINK_CI_UART_RX_CIRC_BUFFER_SIZE,
         masterTxDataBuffer,
         MASTER_UART_TX_BUFFER_SIZE,
         &gNetworkIntf,
         &clinkCtrlIntfCmdQueue,
         NIP_CI_CLINK);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   if (UART_Config(&gClinkCtrlIntf.link.cuart.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize Pleora GenICam control interface
   status = CtrlIntf_InitCircularUART(&gPleoraCtrlIntf,
         CIP_PLEORA,
         XPAR_PLEORA_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR,
         pleoraRxDataCircBuffer,
         PLEORA_CI_UART_RX_CIRC_BUFFER_SIZE,
         masterTxDataBuffer,
         MASTER_UART_TX_BUFFER_SIZE,
         &gNetworkIntf,
         &pleoraCtrlIntfCmdQueue,
         NIP_CI_PLEORA);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   if (UART_Config(&gPleoraCtrlIntf.link.cuart.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

#if (OEM_UART_ENABLED)
   // Initialize OEM GenICam control interface
   status = CtrlIntf_InitCircularUART(&gOemCtrlIntf,
         CIP_F1F2,
         XPAR_OEM_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_OEM_UART_IP2INTC_IRPT_INTR,
         oemRxDataCircBuffer,
         OEM_CI_UART_RX_CIRC_BUFFER_SIZE,
         masterTxDataBuffer,
         MASTER_UART_TX_BUFFER_SIZE,
         &gNetworkIntf,
         &oemCtrlIntfCmdQueue,
         NIP_CI_OEM);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   if (UART_Config(&gOemCtrlIntf.link.cuart.uart, 115200, 8, 'N', 1) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }
#endif

   // Initialize Output FPGA GenICam control interface
   status = CtrlIntf_InitCircularUART(&gOutputCtrlIntf,
         CIP_F1F2_NETWORK,
         XPAR_FPGA_OUTPUT_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_FPGA_OUTPUT_UART_IP2INTC_IRPT_INTR,
         outputRxDataCircBuffer,
         OUTPUT_CI_UART_RX_CIRC_BUFFER_SIZE,
         outputTxDataBuffer,
         OUTPUT_CI_UART_TX_BUFFER_SIZE,
         &gNetworkIntf,
         &outputCtrlIntfCmdQueue,
         NIP_UNDEFINED);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   status = UART_Config(&gOutputCtrlIntf.link.cuart.uart, 115200, 8, 'N', 1);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize GenICam Manager
   if (GC_Manager_Init(&gNetworkIntf, &gcmCmdQueue) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Initialize GenICam Events
   if (GC_Events_Init(&gcEventErrorQueue, NULL) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

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
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_CLINK_UART_IP2INTC_IRPT_INTR);
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_PLEORA_UART_IP2INTC_IRPT_INTR);
#if (!OEM_UART_IS_DEBUG_TERMINAL)
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_OEM_UART_IP2INTC_IRPT_INTR);
#endif

   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FPGA_OUTPUT_UART_IP2INTC_IRPT_INTR);
#if (!OEM_UART_IS_GPS)
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_GPS_UART_IP2INTC_IRPT_INTR);
#endif
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_FW_UART_IP2INTC_IRPT_INTR);

   /*
    * Enable the interrupt for the USART driver instance.
    */
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_SYSTEM_BULK_INTERRUPT_0_INTR);

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
   XIntc_Enable(&gProcIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_POWER_MANAGEMENT_IP2INTC_IRPT_INTR);

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
#if (OEM_UART_IS_GPS)
         XPAR_OEM_UART_DEVICE_ID,
#else
         XPAR_AXI_GPS_UART_DEVICE_ID,
#endif
         &gProcIntc,
#if (OEM_UART_IS_GPS)
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_OEM_UART_IP2INTC_IRPT_INTR,
#else
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_GPS_UART_IP2INTC_IRPT_INTR,
#endif
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
          &gFaulhaberCtrl,
         XPAR_FW_UART_DEVICE_ID,
         &gProcIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_FW_UART_IP2INTC_IRPT_INTR);

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
   IRC_Status_t status = FlashDynamicValues_Init(&gFlashDynamicValues);

   gcRegsData.PowerOnAtStartup = gFlashDynamicValues.PowerOnAtStartup;
   gcRegsData.AcquisitionStartAtStartup = gFlashDynamicValues.AcquisitionStartAtStartup;
   gcRegsData.StealthMode = gFlashDynamicValues.StealthMode;
   gcRegsData.DeviceKeyValidationLow = gFlashDynamicValues.DeviceKeyValidationLow;
   gcRegsData.DeviceKeyValidationHigh = gFlashDynamicValues.DeviceKeyValidationHigh;

   return status;
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
   PRINTF("Warning: Flash interface is configured in slow mode.\n");
#endif

#ifdef LOW_FORMAT
   PRINTF("Warning: Flash interface low format is activated.\n");
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
   MGT_SetMGTLoopback(&gMGT, DATA_MGT, LOOPBACK_NEAREND_PMA);

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
   // Initialize the SFW Module event if not used
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

	return FWControllerInit(&gFaulhaberCtrl);}

/**
 * Initializes neutral density filter controller.
 *
 * @return IRC_SUCCESS if successfully initialized.
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Proc_NDF_Init()
{
   return NDF_ControllerInit(&gFaulhaberCtrl);
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
