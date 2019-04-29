/**
 * @file GC_Poller.c
 * GenICam register poller module implementation.
 *
 * This file implements GenICam register poller module.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2015 Telops Inc.
 */

#include "GC_Poller.h"
#include "GenICam.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "Protocol_F1F2.h"
#include "BufferManager.h"
#include "BuiltInTests.h"
#include "ReleaseInfo.h"
#include "Utils.h"

IRC_Status_t GC_Poller_ValidatePollingIndex(uint32_t *pollingIdx);
void GC_Poller_FirmwareRevisionCallback(gcPolledReg_t *polledReg);
void GC_Poller_OutputErrorCallback(gcPolledReg_t *polledReg);
void GC_Poller_StorageErrorCallback(gcPolledReg_t *polledReg);

/**
 * GenICam poller network port.
 */
netIntfPort_t gcpPort;

/**
 * GenICam poller event temporary values.
 */
uint32_t gOutputEventErrorValue;
gcEvent_t gOutputEvent;
uint32_t gStorageEventErrorValue;
gcEvent_t gStorageEvent;


/**
 * Indicates whether GenICam poller state machine must be stopped.
 */
static uint8_t gcpStopRequested;

/**
 * GenICam poller current state.
 */
static gcpState_t gcpCurrentState;

/**
 * GenICam polled registers list.
 */
gcPolledReg_t gcPolledRegsList[] = {
   {GCPR_OutputFPGAHardwareRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_OutputFPGAHardwareRevision, NIA_OUTPUT_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGAHardwareRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_OutputFPGASoftwareRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_OutputFPGASoftwareRevision, NIA_OUTPUT_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGASoftwareRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_OutputFPGABootLoaderRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_OutputFPGABootLoaderRevision, NIA_OUTPUT_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGABootLoaderRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_OutputFPGACommonRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_OutputFPGACommonRevision, NIA_OUTPUT_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGACommonRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_StorageFPGAHardwareRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_StorageFPGAHardwareRevision, NIA_STORAGE_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGAHardwareRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_StorageFPGASoftwareRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_StorageFPGASoftwareRevision, NIA_STORAGE_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGASoftwareRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_StorageFPGABootLoaderRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_StorageFPGABootLoaderRevision, NIA_STORAGE_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGABootLoaderRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_StorageFPGACommonRevision, GCPM_ONCE, 0, DeviceFirmwareModuleRevisionIdx, DeviceFirmwareModuleSelectorIdx, DFMS_StorageFPGACommonRevision, NIA_STORAGE_FPGA, &DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGACommonRevision], GC_Poller_FirmwareRevisionCallback},
   {GCPR_OutputFPGATemperature, GCPM_CONTINUOUS, 0, DeviceTemperatureIdx, DeviceTemperatureSelectorIdx, DTS_OutputFPGA, NIA_OUTPUT_FPGA, &DeviceTemperatureAry[DTS_OutputFPGA], NULL},
   {GCPR_OutputFPGA_VCCINTVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_OutputFPGA_VCCINT, NIA_OUTPUT_FPGA, &DeviceVoltageAry[DVS_OutputFPGA_VCCINT], NULL},
   {GCPR_OutputFPGA_VCCAUXVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_OutputFPGA_VCCAUX, NIA_OUTPUT_FPGA, &DeviceVoltageAry[DVS_OutputFPGA_VCCAUX], NULL},
   {GCPR_OutputFPGA_VREFPVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_OutputFPGA_VREFP, NIA_OUTPUT_FPGA, &DeviceVoltageAry[DVS_OutputFPGA_VREFP], NULL},
   {GCPR_OutputFPGA_VREFNVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_OutputFPGA_VREFN, NIA_OUTPUT_FPGA, &DeviceVoltageAry[DVS_OutputFPGA_VREFN], NULL},
   {GCPR_OutputFPGA_VBRAMVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_OutputFPGA_VBRAM, NIA_OUTPUT_FPGA, &DeviceVoltageAry[DVS_OutputFPGA_VBRAM], NULL},
   {GCPR_StorageFPGATemperature, GCPM_CONTINUOUS, 0, DeviceTemperatureIdx, DeviceTemperatureSelectorIdx, DTS_StorageFPGA, NIA_STORAGE_FPGA, &DeviceTemperatureAry[DTS_StorageFPGA], NULL},
   {GCPR_StorageFPGA_VCCINTVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_StorageFPGA_VCCINT, NIA_STORAGE_FPGA, &DeviceVoltageAry[DVS_StorageFPGA_VCCINT], NULL},
   {GCPR_StorageFPGA_VCCAUXVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_StorageFPGA_VCCAUX, NIA_STORAGE_FPGA, &DeviceVoltageAry[DVS_StorageFPGA_VCCAUX], NULL},
   {GCPR_StorageFPGA_VREFPVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_StorageFPGA_VREFP, NIA_STORAGE_FPGA, &DeviceVoltageAry[DVS_StorageFPGA_VREFP], NULL},
   {GCPR_StorageFPGA_VREFNVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_StorageFPGA_VREFN, NIA_STORAGE_FPGA, &DeviceVoltageAry[DVS_StorageFPGA_VREFN], NULL},
   {GCPR_StorageFPGA_VBRAMVoltage, GCPM_CONTINUOUS, 0, DeviceVoltageIdx, DeviceVoltageSelectorIdx, DVS_StorageFPGA_VBRAM, NIA_STORAGE_FPGA, &DeviceVoltageAry[DVS_StorageFPGA_VBRAM], NULL},
   {GCPR_OutputFPGAEventError, GCPM_CONTINUOUS, 0, EventErrorIdx, GCP_SELECTOR_NONE, 0, NIA_OUTPUT_FPGA, &gOutputEventErrorValue, GC_Poller_OutputErrorCallback},
   {GCPR_OutputFPGAEventErrorCode, GCPM_CONTINUOUS, 0, EventErrorCodeIdx, GCP_SELECTOR_NONE, 0, NIA_OUTPUT_FPGA, &gOutputEvent.code, GC_Poller_OutputErrorCallback},
   {GCPR_OutputFPGAEventErrorTimestamp, GCPM_CONTINUOUS, 0, EventErrorTimestampIdx, GCP_SELECTOR_NONE, 0, NIA_OUTPUT_FPGA, &gOutputEvent.timestamp, GC_Poller_OutputErrorCallback},
   {GCPR_StorageFPGAEventError, GCPM_CONTINUOUS, 0, EventErrorIdx, GCP_SELECTOR_NONE, 0, NIA_STORAGE_FPGA, &gStorageEventErrorValue, GC_Poller_StorageErrorCallback},
   {GCPR_StorageFPGAEventErrorCode, GCPM_CONTINUOUS, 0, EventErrorCodeIdx, GCP_SELECTOR_NONE, 0, NIA_STORAGE_FPGA, &gStorageEvent.code, GC_Poller_StorageErrorCallback},
   {GCPR_StorageFPGAEventErrorTimestamp, GCPM_CONTINUOUS, 0, EventErrorTimestampIdx, GCP_SELECTOR_NONE, 0, NIA_STORAGE_FPGA, &gStorageEvent.timestamp, GC_Poller_StorageErrorCallback}
};


/**
 * Initializes the GenICam poller.
 *
 * @param netIntf is the pointer to the network interface data structure.
 * @param cmdQueue is the pointer to the file manager command queue.
 *
 * @return IRC_SUCCESS if successfully initialized
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t GC_Poller_Init(netIntf_t *netIntf, circBuffer_t *cmdQueue)
{
   if (NUM_OF(gcPolledRegsList) != GCPR_COUNT)
   {
      GCP_ERR("Polled register count mismatch.");
      return IRC_FAILURE;
   }

   gcpCurrentState = GCPS_WAITING_FOR_NETWORK_INTF;

   gcpPort.port = NIP_GC_POLLER;
   gcpPort.cmdQueue = cmdQueue;

   gcpStopRequested = 0;

   // Connect GenICam poller to network interface
   if (NetIntf_Connect(netIntf, &gcpPort) != IRC_SUCCESS)
   {
      GCP_ERR("Failed to connect to network interface.");
      return IRC_FAILURE;
   }
   
   return IRC_SUCCESS;
}

/**
 * Starts the GenICam poller.
 *
 * @return IRC_SUCCESS if successfully started.
 * @return IRC_FAILURE if failed to start.
 */
IRC_Status_t GC_Poller_Start()
{
   gcpStopRequested = 0;

   return IRC_SUCCESS;
}

/**
 * Generate a GenICam poller stop request.
 *
 * @return IRC_SUCCESS if successfully stopped.
 * @return IRC_FAILURE if failed to stop.
 */
IRC_Status_t GC_Poller_Stop()
{
   gcpStopRequested = 1;

   return IRC_SUCCESS;
}

/**
 * Return the GenICam poller active state.
 *
 * @return 0 if GenICam poller is stopped.
 * @return 1 if GenICam poller is started.
 */
uint8_t GC_Poller_IsActive()
{
   return (gcpCurrentState != GCPS_IDLE);
}

void GC_Poller_SM()
{
   static uint32_t pollingIdx = 0;
   static uint64_t tic_timeout;
   static uint32_t retryCount = 0;

   gcRegister_t *p_register;
   networkCommand_t gcpRequest;
   networkCommand_t gcpResponse;

   switch (gcpCurrentState)
   {
      case GCPS_WAITING_FOR_NETWORK_INTF:
         if ((gcpPort.netIntf->currentState == NIS_READY) &&
               (builtInTests[BITID_NetworkHostsSynchronization].result == BITR_Passed))
         {
            // Check that the output FPGA has been detected by network interface
            if (NetIntf_HostReached(gcpPort.netIntf, NIA_OUTPUT_FPGA))
            {
               TDCStatusClr(WaitingForOutputFPGAMask);
            }

            // Check that the all FPGAs have been detected by network interface
            if (!NetIntf_HostReached(gcpPort.netIntf, NIA_OUTPUT_FPGA) || (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask) && !NetIntf_HostReached(gcpPort.netIntf, NIA_STORAGE_FPGA)))
            {
               builtInTests[BITID_NetworkHostsReady].result = BITR_Failed;
            }
            else
            {
               builtInTests[BITID_NetworkHostsReady].result = BITR_Passed;
            }

            gcpCurrentState = GCPS_SENDING_SELECTOR_WRITE_REQ;
         }
         break;
       
      case GCPS_IDLE:
         if (gcpStopRequested == 0)
         {
            retryCount = 0;
            gcpCurrentState = GCPS_SENDING_SELECTOR_WRITE_REQ;
         }
         break;

      case GCPS_SENDING_SELECTOR_WRITE_REQ:
         // Check that there is a register to poll (valid polling index)
         if (GC_Poller_ValidatePollingIndex(&pollingIdx) != IRC_SUCCESS)
         {
            gcpStopRequested = 1;
         }

         if (gcpStopRequested == 1)
         {
            gcpCurrentState = GCPS_IDLE;
         }
         else
         {
            if (gcPolledRegsList[pollingIdx].selectorRegIdx != GCP_SELECTOR_NONE)
            {
               p_register = &gcRegsDef[gcPolledRegsList[pollingIdx].selectorRegIdx];
               F1F2_CommandClear(&gcpRequest.f1f2);
               gcpRequest.f1f2.isNetwork = 1;
               gcpRequest.f1f2.srcAddr = NIA_PROCESSING_FPGA;
               gcpRequest.f1f2.srcPort = NIP_GC_POLLER;
               gcpRequest.f1f2.destAddr = gcPolledRegsList[pollingIdx].address;
               gcpRequest.f1f2.destPort = NIP_GC_MANAGER;
               gcpRequest.f1f2.cmd = F1F2_CMD_REG_WRITE;
               gcpRequest.f1f2.payload.regRW.address = p_register->address;
               memcpy_swap(gcpRequest.f1f2.payload.regRW.data, &gcPolledRegsList[pollingIdx].selectorRegValue,
                     p_register->dataLength, p_register->dataLength, RegIsBigEndian(p_register));
               gcpRequest.f1f2.payload.regRW.dataLength = p_register->dataLength;
               gcpRequest.f1f2.payload.regRW.padLength = p_register->length - p_register->dataLength;
               gcpRequest.port = &gcpPort;

               if (NetIntf_EnqueueCmd(gcpPort.netIntf, &gcpRequest) != IRC_SUCCESS)
               {
                  GCP_ERR("Failed to push register selector write poller command in network interface command queue.");
               }

               GETTIME(&tic_timeout);
               gcpCurrentState = GCPS_WAITING_FOR_SELECTOR_WRITE_RESP;
            }
            else
            {
               gcpCurrentState = GCPS_SENDING_READ_REQ;
            }
         }
         break;

      case GCPS_WAITING_FOR_SELECTOR_WRITE_RESP:
         if (CB_Pop(gcpPort.cmdQueue, &gcpResponse) == IRC_SUCCESS)
         {
            if ((gcpResponse.f1f2.cmd == F1F2_CMD_ACK) && (gcpResponse.f1f2.payload.ack.cmd == F1F2_CMD_REG_WRITE))
            {
               GCP_DBG("Register selector write response has been received (addr: 0x%08X, selector: %d).",
                     gcRegsDef[gcPolledRegsList[pollingIdx].selectorRegIdx].address,
                     gcPolledRegsList[pollingIdx].selectorRegValue);

               gcpCurrentState = GCPS_SENDING_READ_REQ;
            }
            else
            {
               GCP_ERR("Unexpected selector write response received (cmd: %d).", gcpResponse.f1f2.cmd);
            }
         }

         if ((gcpCurrentState == GCPS_WAITING_FOR_SELECTOR_WRITE_RESP) &&
               (elapsed_time_us(tic_timeout) > GCP_REQUEST_TIMEOUT_US))
         {
            retryCount++;

            GCP_ERR("Register read request failed (addr: 0x%08X, selector: %d, retry: %d).",
                  gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx].address,
                  gcPolledRegsList[pollingIdx].selectorRegValue, retryCount);

            if (retryCount >= GCP_REQUEST_MAX_RETRY)
            {
               // Skip register
               pollingIdx++;
               retryCount = 0;
            }
            gcpCurrentState = GCPS_SENDING_SELECTOR_WRITE_REQ;
         }
         break;

      case GCPS_SENDING_READ_REQ:
         // Prepare polled register read request
         p_register = &gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx];
         F1F2_CommandClear(&gcpRequest.f1f2);
         gcpRequest.f1f2.isNetwork = 1;
         gcpRequest.f1f2.srcAddr = NIA_PROCESSING_FPGA;
         gcpRequest.f1f2.srcPort = NIP_GC_POLLER;
         gcpRequest.f1f2.destAddr = gcPolledRegsList[pollingIdx].address;
         gcpRequest.f1f2.destPort = NIP_GC_MANAGER;
         gcpRequest.f1f2.cmd = F1F2_CMD_REG_READ_REQ;
         gcpRequest.f1f2.payload.regRW.address = p_register->address;
         gcpRequest.port = &gcpPort;

         // Transmit polled register read request
         if (NetIntf_EnqueueCmd(gcpPort.netIntf, &gcpRequest) != IRC_SUCCESS)
         {
            GCP_ERR("Failed to push register read poller command in network interface command queue.");
         }

         GETTIME(&tic_timeout);
         gcpCurrentState = GCPS_WAITING_FOR_READ_RESP;
         break;
      
      case GCPS_WAITING_FOR_READ_RESP:
         if (CB_Pop(gcpPort.cmdQueue, &gcpResponse) == IRC_SUCCESS)
         {
            if ((gcpResponse.f1f2.cmd == F1F2_CMD_REG_READ_RSP) &&
                  (gcpResponse.f1f2.payload.regRW.address == gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx].address))
            {
               GCP_DBG("Register read response has been received (addr: 0x%08X, selector: %d).",
                     gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx].address,
                     gcPolledRegsList[pollingIdx].selectorRegValue);

               if (gcPolledRegsList[pollingIdx].p_registerData != NULL)
               {
                  memcpy_swap(gcPolledRegsList[pollingIdx].p_registerData,
                        gcpResponse.f1f2.payload.regRW.data,
                        gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx].dataLength,
                        gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx].dataLength,
                        RegIsBigEndian(&gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx]));
               }

               gcPolledRegsList[pollingIdx].polled = 1;

               if (gcPolledRegsList[pollingIdx].callback != NULL)
               {
                  (*gcPolledRegsList[pollingIdx].callback)(&gcPolledRegsList[pollingIdx]);
               }

               pollingIdx++;
               retryCount = 0;
               gcpCurrentState = GCPS_SENDING_SELECTOR_WRITE_REQ;
            }
            else
            {
               GCP_ERR("Unexpected read response received (cmd: %d).", gcpResponse.f1f2.cmd);
            }
         }

         if ((gcpCurrentState == GCPS_WAITING_FOR_READ_RESP) &&
               (elapsed_time_us(tic_timeout) > GCP_REQUEST_TIMEOUT_US))
         {
            retryCount++;

            GCP_ERR("Register read request timeout (addr: 0x%08X, selector: %d, retry: %d).",
                  gcRegsDef[gcPolledRegsList[pollingIdx].registerIdx].address,
                  gcPolledRegsList[pollingIdx].selectorRegValue, retryCount);

            if (retryCount >= GCP_REQUEST_MAX_RETRY)
            {
               // Skip register
               pollingIdx++;
               retryCount = 0;
               gcpCurrentState = GCPS_SENDING_SELECTOR_WRITE_REQ;
            }
            else
            {
               gcpCurrentState = GCPS_SENDING_READ_REQ;
            }
         }
         break;
   }
}

/**
 * Validate specified polling index. If not valid, polling index is set to the
 * next valid polling index.
 *
 * @param p_pollingIdx is the pointer to the polling index to validate.
 *
 * @return IRC_SUCCESS if returned polling index is valid.
 * @return IRC_FAILURE if there is no valid polling index. Pointed polling time won't be modified.
 */
IRC_Status_t GC_Poller_ValidatePollingIndex(uint32_t *p_pollingIdx)
{
   uint32_t i;
   uint32_t pollingIdx = *p_pollingIdx;

   for (i = 0; i < NUM_OF(gcPolledRegsList); i++)
   {
      pollingIdx = (*p_pollingIdx + i) % NUM_OF(gcPolledRegsList);

      /* Validate that register polling mode is not once after first pass and
         that register is not a storage register when external memory buffer is not implemented */
      if (!((gcPolledRegsList[pollingIdx].pollingMode == GCPM_ONCE) && gcPolledRegsList[pollingIdx].polled) &&
            !((gcPolledRegsList[pollingIdx].address == NIA_STORAGE_FPGA) && !TDCFlagsTst(ExternalMemoryBufferIsImplementedMask)))
      {
         *p_pollingIdx = pollingIdx;
         return IRC_SUCCESS;
      }
   }

   return IRC_FAILURE;
}

/**
 * Device firmware module revision polled register callback function.
 *
 * @param polledReg is the pointer to the polled register data structure.
 */
void GC_Poller_FirmwareRevisionCallback(gcPolledReg_t *polledReg)
{
   extern releaseInfo_t gReleaseInfo;

   if ((gcPolledRegsList[GCPR_OutputFPGAHardwareRevision].polled && gcPolledRegsList[GCPR_OutputFPGASoftwareRevision].polled &&
         gcPolledRegsList[GCPR_OutputFPGABootLoaderRevision].polled && gcPolledRegsList[GCPR_OutputFPGACommonRevision].polled) &&
         (!TDCFlagsTst(ExternalMemoryBufferIsImplementedMask) || (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask) &&
               gcPolledRegsList[GCPR_StorageFPGAHardwareRevision].polled && gcPolledRegsList[GCPR_StorageFPGASoftwareRevision].polled &&
               gcPolledRegsList[GCPR_StorageFPGABootLoaderRevision].polled && gcPolledRegsList[GCPR_StorageFPGACommonRevision].polled)))
   {
      if (ReleaseInfo_Validate(&gReleaseInfo) == IRC_SUCCESS)
      {
         builtInTests[BITID_FirmwareRevisionsConsistency].result = BITR_Passed;
      }
      else
      {
         builtInTests[BITID_FirmwareRevisionsConsistency].result = BITR_Failed;
      }
      ReleaseInfo_Print(&gReleaseInfo);
   }
}

/**
 * Output FPGA error event polled register callback function.
 *
 * @param polledReg is the pointer to the polled register data structure.
 */
void GC_Poller_OutputErrorCallback(gcPolledReg_t *polledReg)
{
   if (gcPolledRegsList[GCPR_OutputFPGAEventError].polled &&
         gcPolledRegsList[GCPR_OutputFPGAEventErrorCode].polled &&
         gcPolledRegsList[GCPR_OutputFPGAEventErrorTimestamp].polled)
   {
      if ((gOutputEventErrorValue == 1) && (gOutputEvent.code != EECD_NoError))
      {
         GC_GenerateEventError(gOutputEvent.code);
      }

      gcPolledRegsList[GCPR_OutputFPGAEventError].polled = 0;
      gcPolledRegsList[GCPR_OutputFPGAEventErrorCode].polled = 0;
      gcPolledRegsList[GCPR_OutputFPGAEventErrorTimestamp].polled = 0;
   }
}

/**
 * Storage FPGA error event polled register callback function.
 *
 * @param polledReg is the pointer to the polled register data structure.
 */
void GC_Poller_StorageErrorCallback(gcPolledReg_t *polledReg)
{
   if (gcPolledRegsList[GCPR_StorageFPGAEventError].polled &&
         gcPolledRegsList[GCPR_StorageFPGAEventErrorCode].polled &&
         gcPolledRegsList[GCPR_StorageFPGAEventErrorTimestamp].polled)
   {
      if ((gStorageEventErrorValue == 1) && (gStorageEvent.code != EECD_NoError))
      {
         GC_GenerateEventError(gStorageEvent.code);
      }

      gcPolledRegsList[GCPR_StorageFPGAEventError].polled = 0;
      gcPolledRegsList[GCPR_StorageFPGAEventErrorCode].polled = 0;
      gcPolledRegsList[GCPR_StorageFPGAEventErrorTimestamp].polled = 0;
   }
}

