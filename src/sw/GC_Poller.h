/**
 * @file GC_Poller.h
 * GenICam register poller module header.
 *
 * This file declares the GenIcam register poller module.
 *
 * $Rev: 18503 $
 * $Author: dalain $
 * $Date: 2016-04-08 14:46:14 -0400 (ven., 08 avr. 2016) $
 * $Id: GC_Poller.h 18503 2016-04-08 18:46:14Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/GC_Poller.h $
 *
 * (c) Copyright 2015 Telops Inc.
 */

#ifndef GC_POLLER_H
#define GC_POLLER_H

#include "NetworkInterface.h"
#include "CircularBuffer.h"
#include "verbose.h"

#ifdef GCP_VERBOSE
   #define GCP_PRINTF(fmt, ...)  FPGA_PRINTF("GCP: " fmt, ##__VA_ARGS__)
#else
   #define GCP_PRINTF(fmt, ...)  DUMMY_PRINTF("GCP: " fmt, ##__VA_ARGS__)
#endif

#define GCP_ERR(fmt, ...)        FPGA_PRINTF("GCP: Error: " fmt "\n", ##__VA_ARGS__)
#define GCP_INF(fmt, ...)        FPGA_PRINTF("GCP: Info: " fmt "\n", ##__VA_ARGS__)
#define GCP_DBG(fmt, ...)        GCP_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define GCP_REQUEST_TIMEOUT_US   TIME_ONE_SECOND_US
#define GCP_REQUEST_MAX_RETRY    3

#define GCP_SELECTOR_NONE        (uint32_t)0xFFFFFFFF

/**
 * GenICam poller state.
 */
enum gcpStateEnum {
   GCPS_WAITING_FOR_NETWORK_INTF = 0,     /**< Waiting for network interface to be ready */
   GCPS_IDLE,                             /**< GenICam poller idle state */
   GCPS_SENDING_SELECTOR_WRITE_REQ,       /**< Transmit selector write request */
   GCPS_WAITING_FOR_SELECTOR_WRITE_RESP,  /**< Waiting for selector write response to be received */
   GCPS_SENDING_READ_REQ,                 /**< Transmit read request */
   GCPS_WAITING_FOR_READ_RESP             /**< Waiting for read response to be received */
};

/**
 * GenICam poller state data type.
 */
typedef enum gcpStateEnum gcpState_t;

/**
 * GenICam register polling mode enum.
 */
enum gcPollingModeEnum {
   GCPM_ONCE = 0,                /**< GenICam register is polled once */
   GCPM_CONTINUOUS               /**< Waiting register is continuously polled */
};

/**
 * GenICam register polling mode data type.
 */
typedef enum gcPollingModeEnum gcPollingMode_t;

/**
 * GenICam polled register data type.
 */
typedef struct gcPolledRegStruct gcPolledReg_t;

/**
 * GenICam polled register callback function pointer data type.
 */
typedef void (*gcPolledRegCallback)(gcPolledReg_t *polledReg);

/**
 * GenICam polled registers id.
 */
enum gcPolledRegIdEnum {
   GCPR_OutputFPGAHardwareRevision = 0,
   GCPR_OutputFPGASoftwareRevision,
   GCPR_OutputFPGABootLoaderRevision,
   GCPR_OutputFPGACommonRevision,
   GCPR_StorageFPGAHardwareRevision,
   GCPR_StorageFPGASoftwareRevision,
   GCPR_StorageFPGABootLoaderRevision,
   GCPR_StorageFPGACommonRevision,
   GCPR_OutputFPGATemperature,
   GCPR_OutputFPGA_VCCINTVoltage,
   GCPR_OutputFPGA_VCCAUXVoltage,
   GCPR_OutputFPGA_VREFPVoltage,
   GCPR_OutputFPGA_VREFNVoltage,
   GCPR_OutputFPGA_VBRAMVoltage,
   GCPR_StorageFPGATemperature,
   GCPR_StorageFPGA_VCCINTVoltage,
   GCPR_StorageFPGA_VCCAUXVoltage,
   GCPR_StorageFPGA_VREFPVoltage,
   GCPR_StorageFPGA_VREFNVoltage,
   GCPR_StorageFPGA_VBRAMVoltage,
   GCPR_OutputFPGAEventError,
   GCPR_OutputFPGAEventErrorCode,
   GCPR_OutputFPGAEventErrorTimestamp,
   GCPR_StorageFPGAEventError,
   GCPR_StorageFPGAEventErrorCode,
   GCPR_StorageFPGAEventErrorTimestamp,
   GCPR_COUNT
};

/**
 * GenICam polled registers id data type.
 */
typedef enum gcPolledRegIdEnum gcPolledRegId_t;

/**
 * GenICam polled register data structure.
 */
struct gcPolledRegStruct {
   gcPolledRegId_t id;           /**< GenICam polled register id */
   gcPollingMode_t pollingMode;  /**< GenICam polled register polling mode */
   uint8_t polled;               /**< Indicates whether GenICam polled register has been successfully polled */
   uint32_t registerIdx;         /**< GenICam polled register index */
   uint32_t selectorRegIdx;      /**< GenICam polled register selector register index */
   uint32_t selectorRegValue;    /**< GenICam polled register selector register value */
   niAddress_t address;          /**< GenICam polled register host address */
   void *p_registerData;         /**< GenICam polled register destination data */
   gcPolledRegCallback callback; /**< GenICam polled register callback function pointer */
};


IRC_Status_t GC_Poller_Init(netIntf_t *netIntf, circBuffer_t *cmdQueue);
IRC_Status_t GC_Poller_Start();
IRC_Status_t GC_Poller_Stop();
uint8_t GC_Poller_IsActive();
void GC_Poller_SM();

#endif // GC_POLLER_H
