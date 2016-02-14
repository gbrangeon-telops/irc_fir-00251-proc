/**
 * @file FaulhaberProtocol.h
 * Faulhaber driver module header.
 *
 * This file defines the Faulhaber controller interface
 *
 * Author : SSA
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2015-02-19%20-%20FW/src/sw/FileManager.h $
 *
 * (c) Copyright 2015 Telops Inc.
 */

#ifndef FAULHABER_PROTOCOL_H
#define FAULHABER_PROTOCOL_H

#include "CircularByteBuffer.h"
#include "GC_Registers.h"
#include "xuartns550.h"
#include "usart.h"
#include "verbose.h"

#include <stdint.h>
#include <stdbool.h>

#ifdef FH_VERBOSE
   #define FH_PRINTF(fmt, ...)   PRINTF("FH: " fmt, ##__VA_ARGS__)
#else
   #define FH_PRINTF(fmt, ...)   DUMMY_PRINTF("FH: " fmt, ##__VA_ARGS__)
#endif

#ifdef FH_RX_VERBOSE
   #define FH_TRX(fmt, ...)         PRINTF(fmt, ##__VA_ARGS__)
#else
   #define FH_TRX(fmt, ...)      DUMMY_PRINTF(fmt, ##__VA_ARGS__)
#endif

#ifdef FH_TX_VERBOSE
   #define FH_TTX(fmt, ...)         PRINTF(fmt, ##__VA_ARGS__)
#else
   #define FH_TTX(fmt, ...)      DUMMY_PRINTF(fmt, ##__VA_ARGS__)
#endif

#define FH_ERR(fmt, ...)         PRINTF("FH: Error: " fmt "\n", ##__VA_ARGS__)
#define FH_WARN(fmt, ...)        FH_PRINTF("Warning: " fmt "\n", ##__VA_ARGS__)
#define FH_INF(fmt, ...)         FH_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#ifndef CR_CHAR
	#define CR_CHAR (char)13
#endif

#ifndef CR_STR
   #define CR_STR "\r" // compatible with strcat
#endif

#ifndef LF_CHAR
	#define LF_CHAR (char)10
#endif

#define FH_BAUDRATE (uint32_t)115200
#define FH_DATA_BITS (uint8_t)8
#define FH_STOP_BITS (uint8_t)1
#define FH_PARITY (char)'N'

/*< the Faulhaber controller does not like being sent bursts of chars larger than 22 bytes.
 * it sends ASCII-17 (stop) & 19 (start) control characters in reaction. Thus we
 * choose to limit it to 16 bytes at a time.
 */
#define FH_MAX_TX_SIZE (uint8_t)16

// response types
#define FH_OK (uint8_t)0  /*< Acknowledgement */
#define FH_ERROR (char)'r'  /*< Error notification */
#define FH_V (char)'v'    /*< Target velocity notification */
#define FH_P (char)'p'    /*< Target position notification */
#define FH_H (char)'h'    /*< AnIn notify */
#define FH_F (char)'f'    /*< Fault notify*/
#define FH_T (char)'t'    /*< 3rd input notify*/
#define FH_W (char)'w'    /*< 4th input notify*/
#define FH_X (char)'x'    /*< 5th input notify*/
#define FH_STOP (char)19
#define FH_START (char)17
#define FH_UNKNOWN 1
#define FH_INVALID 2
#define FH_UNAVAILABLE 3
#define FH_UNKNOWN_RESPONSE 3

#define FH_UNKNOWN_STR (char*)"Unknown command"
#define FH_UNAVAILABLE_STR (char*)"Command not available"
#define FH_INVALID_STR (char*)"Invalid parameter"

#define FH_REQUEST_TIMEOUT         500 // [ms]

typedef enum FH_RESPONSE_TYPE
{
   FHR_ACK = 0,
   FHR_NOTIFY,
   FHR_NUMERIC,
   FHR_STRING
} FH_RESPONSE_TYPE_t;

// datatype structure for a RS232 channel
typedef struct serial_chan
{
   uint32_t addr;          // address of the channel
   uint8_t rxBuffer[48];   // buffer for reception
   uint8_t txBuffer[48];   // buffer for transmission (can hold many commands)
   uint8_t rxDataCount;
   uint8_t txDataCount;
   uint8_t txBusy;
   uint8_t padding[1];
} serial_chan_t; // 104 bytes

typedef enum fh_rx_state
{
   FHRX_IDLE = 0,         // waiting for the first byte of a new reception
   FHRX_WAIT_ACK,
   FHRX_WAIT_STRING,
   FHRX_WAIT_NOTIFY,
   FHRX_WAIT_TERMINATION,	// waiting for LF following a CR
   FHRX_WAIT_NUMERIC,     // waiting for numerical characters
   FHRX_DONE,				   // a complete frame was received
   FHRX_UNEXPECTED 			// unexpected character was received
} fh_rx_state_t;

typedef struct FW_data
{
	uint8_t id; // the node id, used as a preamble to all communications
	uint8_t awaitingResponse; // flag telling if an ack or response is expected
	uint8_t numExpectedAck;
	uint8_t responseValid;
	uint8_t numResponses; // number of unprocessed responses (used by the circBuffer_t type)
	fh_rx_state_t rxState;
	char partialResponse_buf[32]; // buffer to contain the response data (used by circBuffer_t partialResponse)
	uint8_t respTypes_buf[8]; // a fifo of unprocessed responses types (used by circBuffer_t respTypes)
	int32_t responses_buf[8]; // a fifo of unprocessed responses (used by circBuffer_t responses)
	uint8_t rawBytes[32]; // raw bytes received from the UART interrupt handler (used by circBuffer_t rxCircBuff)
   int numericValue; // used to parse a returned numeric value
	int sign;         // used to hold the sign of numeric value, while it is partially parsed
	circByteBuffer_t responses; // sizeof(circBuffer_t) = 12 bytes
	circByteBuffer_t respTypes;
	circByteBuffer_t partialResponse;
	circByteBuffer_t rxCircBuff;
} FH_data_t;

typedef struct FH_ctrl
{
   serial_chan_t buffers; // the serial channel buffers
   FH_data_t fh_data; // the current state of the device high-level state machine
	union {
      XUartNs550 uart;        /**< The UART link of the control interface */
      usart_t usart;          /**< The USART link of the control interface */
   } link; // 68 bytes
} FH_ctrl_t; // 304 bytes

typedef union
{
   int val;
   uint8_t bytes[4];
} _int_;

void FH_initData(FH_data_t* data);
void FH_parseResponse(FH_ctrl_t* chan);
XStatus FH_init(gcRegistersData_t *pGCRegs, FH_ctrl_t *fh_data, uint16_t uartDeviceId, XIntc* intc, uint16_t uartIntrId);
void FH_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData);

void FH_ProtocolHandler(FH_ctrl_t* ctrl); // the function that handles the parsing of RX bytes and pending TX bytes

// transmit bytes to the Faulhaber device. Typically, one atomic command is given at once
uint32_t FH_sendPendingCmds(FH_ctrl_t* chan);

void FH_consumeResponses(FH_ctrl_t* chan);
bool FH_readNotification(FH_ctrl_t* data, uint8_t* value);
bool FH_readValue(FH_ctrl_t* data, int32_t* value);
uint8_t FH_readAcks(FH_ctrl_t* data);
uint8_t FH_numExpectedAcks(FH_ctrl_t* data);
uint8_t FH_clearAcks(FH_ctrl_t* data, uint8_t n);

#endif // FAULHABER_PROTOCOL_H
