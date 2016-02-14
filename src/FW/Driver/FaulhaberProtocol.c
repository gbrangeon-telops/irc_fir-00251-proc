/**
 * @file faulhaber.h
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

#include "FaulhaberProtocol.h"
#include "UART_Utils.h"
#include "xparameters.h"

#include <stdlib.h> // atoi()
#include <ctype.h> // isalpha(), isdigit()
#include <string.h> // strncmp

void responseTypeAsString(FH_RESPONSE_TYPE_t type, char* str);

/***************************************************************************//**
   Initialisation function for the FH_data_t structure

   @param a pointer to a FH_data_t structure

   @return none

*******************************************************************************/
void FH_initData(FH_data_t* data)
{
   if (data == 0)
      return;

   data->id = 0;
   data->awaitingResponse = 0;
   data->responseValid = 0;
   data->numResponses = 0;
   CBB_Init(&data->responses, (uint8_t*)data->responses_buf, sizeof(data->responses_buf));
   CBB_Init(&data->partialResponse, (uint8_t*)data->partialResponse_buf, sizeof(data->partialResponse_buf));
   CBB_Init(&data->respTypes, data->respTypes_buf, sizeof(data->respTypes_buf));
   CBB_Init(&data->rxCircBuff, data->rawBytes, sizeof(data->rawBytes));
   data->rxState = FHRX_IDLE;
}

/***************************************************************************//**
   RX data parser state machine. Responses from the device are in the following
   format :

   Response / CR / LF

   Thus whenever the CRLF (13,10) sequence is found, a response is complete and
   pushed to the responses and respTypes buffers.

   @param faulhaber data structure

   @return void
*******************************************************************************/
void FH_parseResponse(FH_ctrl_t* chan)
{
   uint32_t ierRegister;
   uint8_t responseValid = 0;
   circByteBuffer_t* partialResp = &chan->fh_data.partialResponse;
   circByteBuffer_t* responses = &chan->fh_data.responses;
   circByteBuffer_t* respTypes = &chan->fh_data.respTypes;
   fh_rx_state_t state = chan->fh_data.rxState;

   /*static statistics_t byteLost_stats;
   static bool initStats = true;
   static uint64_t profiler;
   static timerData_t profiler_timer;

   if (initStats)
   {
      resetStats(&byteLost_stats);
      initStats = false;
      GETTIME(&profiler);
      StartTimer(&profiler_timer, 30*1000);
   }*/

   static bool resyncFlag = false; // indicates that the next CR/LF termination sequence is a resync following an error. This response will be lost, since it can't be trusted

   if (state == FHRX_IDLE || state == FHRX_UNEXPECTED)
      FH_TRX("FH: Rx: ");

   ierRegister = XUartNs550_ReadReg(chan->link.uart.BaseAddress, XUN_IER_OFFSET);
   XUartNs550_WriteReg(chan->link.uart.BaseAddress, XUN_IER_OFFSET, 0);

   unsigned char byte;
   while (CBB_Pop(&chan->fh_data.rxCircBuff, &byte) == IRC_SUCCESS)
   {
      if (byte > 32)
         FH_TRX("%c", byte);
      else
         FH_TRX("(%d)", byte);

      // signaling characters. they should not occur, but no big deal if they do. skip them. they seem to be correctly handled by the uart
      if (byte == FH_STOP || byte == FH_START)
      {
         FH_INF("FH: control character %d (%s)", byte, byte==FH_STOP?"Stop":"Start");
         continue;
      }

      // state transition and transition actions
      switch (state)
      {
         case FHRX_WAIT_NUMERIC:
            if (isdigit(byte))
               state = FHRX_WAIT_NUMERIC;
            else if (byte == CR_CHAR)
               state = FHRX_WAIT_TERMINATION;
            else
               state = FHRX_UNEXPECTED;
         break;

         case FHRX_WAIT_ACK:
            if (byte == 'K')
               state = FHRX_WAIT_ACK;
            else if (byte == CR_CHAR)
               state = FHRX_WAIT_TERMINATION;
            else
               state = FHRX_UNEXPECTED;
         break;

         case FHRX_WAIT_STRING:
            if (byte == CR_CHAR)
               state = FHRX_WAIT_TERMINATION;

            break;

         case FHRX_WAIT_NOTIFY:
            if (byte == CR_CHAR)
               state = FHRX_WAIT_TERMINATION;
            else
               state = FHRX_UNEXPECTED;
            break;

         case FHRX_WAIT_TERMINATION:
            if (byte == LF_CHAR)
               state = FHRX_DONE;
            else
               state = FHRX_UNEXPECTED;
         break;

         case FHRX_DONE:
            state = FHRX_IDLE;
            break;

         case FHRX_UNEXPECTED:
         case FHRX_IDLE:
         default:
            if (byte == 'O')
            {
               state = FHRX_WAIT_ACK;
               CBB_Push(partialResp, FHR_ACK);
               CBB_Push(partialResp, FH_OK);
            }
            else if (strrchr("pvrhftwx", byte) != 0)
            {
               state = FHRX_WAIT_NOTIFY;
               CBB_Push(partialResp, FHR_NOTIFY);
               CBB_Push(partialResp, byte);
            }
            else if (isdigit(byte) || byte == '-')
            {
               chan->fh_data.numericValue = 0;
               chan->fh_data.sign = 1;
               state = FHRX_WAIT_NUMERIC;
               CBB_Push(partialResp, FHR_NUMERIC);
            }
            else if (isalpha(byte))
            {
               state = FHRX_WAIT_STRING;
               CBB_Push(partialResp, FHR_STRING);
            }
            else if (byte == CR_CHAR || byte == LF_CHAR)
            {
               state = FHRX_IDLE;
            }
            else
               state = FHRX_UNEXPECTED;
      };

      // state actions
      switch (state)
      {
         case FHRX_WAIT_NUMERIC:
         if (byte == '-')
            chan->fh_data.sign = -1;

         // each new digit
         if (isdigit(byte))
            chan->fh_data.numericValue = 10*chan->fh_data.numericValue + (int)(byte - '0');
         break;

         case FHRX_WAIT_STRING:
            CBB_Push(partialResp, byte);
            break;

         case FHRX_WAIT_ACK:
         case FHRX_WAIT_NOTIFY:
         case FHRX_WAIT_TERMINATION:
         break;

         case FHRX_DONE:

            // the first byte is always the response type
            CBB_Pop(partialResp, &byte);

            // if the error flag was set earlier, clear it and we're back on track
            if (resyncFlag == true)
            {
               char type_str[16];
               resyncFlag = false;
               responseValid = 0;

               FH_TRX("\n");
               responseTypeAsString(byte, type_str);
               FH_WARN("The last response from the motor controller (of type %s) was lost due to a protocol framing error.", type_str);

               CBB_Flush(partialResp);

               state = FHRX_IDLE;
               break;
            }

            switch (byte)
            {
            case FHR_ACK:
               CBB_Pop(partialResp, &byte);
               CBB_Push(respTypes, FHR_ACK);
               CBB_Push(responses, FH_OK);
               responseValid = 1;
            break;

            case FHR_STRING:
            {
               char tmp[64];
               uint8_t length = CBB_Length(partialResp);

               tmp[length] = 0;
               CBB_Popn(partialResp, CBB_Length(partialResp), (uint8_t*)tmp);
               if (strcmp(tmp, FH_UNAVAILABLE_STR) == 0)
               {
                  CBB_Push(respTypes, FHR_STRING);
                  CBB_Push(responses, FH_UNAVAILABLE);
               }
               else if (strcmp(tmp, FH_UNKNOWN_STR) == 0)
               {
                  CBB_Push(respTypes, FHR_STRING);
                  CBB_Push(responses, FH_UNKNOWN);
               }
               else if (strcmp(tmp, FH_INVALID_STR) == 0)
               {
                  CBB_Push(respTypes, FHR_STRING);
                  CBB_Push(responses, FH_INVALID);
               }
               else
               {
                  CBB_Push(respTypes, FHR_STRING);
                  CBB_Push(responses, FH_UNKNOWN_RESPONSE);
               }

               responseValid = 1;
            }
               break;

            case FHR_NUMERIC:
            {
               _int_ value;
               value.val = chan->fh_data.sign * chan->fh_data.numericValue;
               CBB_Push(respTypes, FHR_NUMERIC);
               CBB_Pushn(responses, 4, value.bytes);
               responseValid = 1;
            }
            break;

            case FHR_NOTIFY:
               CBB_Pop(partialResp, &byte);
               CBB_Push(respTypes, FHR_NOTIFY);
               CBB_Push(responses, byte);

               responseValid = 1;
               break;

            default:
               responseValid = 0;
            };

            if (responseValid)
               ++chan->fh_data.numResponses;

            FH_TRX("\n");
            state = FHRX_IDLE;
            break;

         case FHRX_IDLE:
         case FHRX_UNEXPECTED:
            if (state == FHRX_UNEXPECTED)
            {
               resyncFlag = true; // must resync with the next CR/LF termination
               /*updateStats(&byteLost_stats, elapsed_time_us(profiler)/1000.0);
               GETTIME(&profiler);*/
               if (isalnum(byte))
               {
                  FH_WARN("Unexpected byte ('%c', ASCII-%d) while in RX state %d",
                        byte, (int)byte, chan->fh_data.rxState);
               }
               else
               {
                  FH_WARN("Unexpected byte (ASCII-%d) while in RX state %d",
                        (int)byte, chan->fh_data.rxState);
               }
            }

            // no break here it's ok.

         default:
            chan->fh_data.numericValue = 0;
            CBB_Flush(partialResp);
      };
   }

   chan->fh_data.rxState = state;

   /*if (TimedOut(&profiler_timer))
   {
      reportStats(&byteLost_stats, "Faulhaber protocol error timing statistics [ms]");
      RestartTimer(&profiler_timer);
   }*/

   // Reactivate UART interrupt
   XUartNs550_WriteReg(chan->link.uart.BaseAddress, XUN_IER_OFFSET, ierRegister);
}

/***************************************************************************//**
   Interrupt handler for the UART.

   Upon reception of bytes, they are processed by the parser state machine.

   @param CallBackRef : a pointer to a FH_ctrl_t structure with data relevant to the communication channel and motor controller
   @param Event, the type of event (RX or TX)
   @param EventData (usually the number of bytes sent or received for the events that interest us)

   @return void

*******************************************************************************/
void FH_UART_IntrHandler(void *CallBackRef,
      u32 Event,
      unsigned int EventData)
{
   uint32_t n;
   FH_ctrl_t *FH_ctrl = (FH_ctrl_t *)CallBackRef;

   switch (Event)
   {
      case XUN_EVENT_RECV_TIMEOUT: // Data was received but stopped for 4 character periods.
      case XUN_EVENT_RECV_DATA: // Data has been received.
         // Listen for command on UART
         n = XUartNs550_Recv(&FH_ctrl->link.uart, FH_ctrl->buffers.rxBuffer, sizeof(FH_ctrl->buffers.rxBuffer));

         // CR_WARNING for some reason, n is always 0! thus we use EventData, which contains the actual number of bytes received
         n = EventData;

         if (CBB_Pushn(&FH_ctrl->fh_data.rxCircBuff, n, FH_ctrl->buffers.rxBuffer) != IRC_SUCCESS)
         {
            FH_ERR("Unable to push RX data in the circular buffer.");
         }

         break;

      case XUN_EVENT_RECV_ERROR: // Data was received with an error.
         FH_INF("XUN_EVENT_RECV_ERROR");
         break;

      case XUN_EVENT_SENT_DATA: // data was sent
         if (FH_ctrl->buffers.txDataCount >= EventData)
         {
            FH_ctrl->buffers.txDataCount -= EventData;
            memmove((char*)FH_ctrl->buffers.txBuffer, (char*)FH_ctrl->buffers.txBuffer + EventData, FH_ctrl->buffers.txDataCount);
         }
         FH_ctrl->buffers.txBusy = 0;

         break;

      case XUN_EVENT_MODEM:
         FH_INF("XUN_EVENT_MODEM");
         break;

      default:
         FH_ERR("Unknown UART event %d", Event);
   }
}

/***************************************************************************//**
 *
 * Initialization function for the UART channel of the Faulhaber controller.
 *
 * @param a pointer to the gcRegistersData_t structure
 * @param a pointer to a FH_ctrl_t structure with information on the target channel
 * @param uartDeviceId
 * @param a pointer to the interrupt controller instance (XIntc*)
 * @param the interrupt ID to activate
 *
 * @return IRC_SUCCESS or IRC_FAILURE
 *
 ******************************************************************************/
XStatus FH_init(gcRegistersData_t *pGCRegs, FH_ctrl_t *fh_data, uint16_t uartDeviceId, XIntc* intc, uint16_t uartIntrId)
{
   XStatus status;

   FH_initData(&fh_data->fh_data);

   memset(fh_data->buffers.rxBuffer, 0, sizeof(fh_data->buffers.rxBuffer));
   memset(fh_data->buffers.txBuffer, 0, sizeof(fh_data->buffers.txBuffer));

   status = UART_Init(&fh_data->link.uart,
         uartDeviceId,
         intc,
         uartIntrId,
         FH_UART_IntrHandler,
         (void *)(fh_data));

   if (status != IRC_SUCCESS)
   {
     return IRC_FAILURE;
   }

   status = UART_Config(&fh_data->link.uart, FH_BAUDRATE, FH_DATA_BITS, FH_PARITY, FH_STOP_BITS);
   if (status != IRC_SUCCESS)
   {
     return IRC_FAILURE;
   }

   // Reset RX FIFO
   UART_ResetRxFifo(&fh_data->link.uart);

   XUartNs550_SetFifoThreshold(&fh_data->link.uart, XUN_FIFO_TRIGGER_08);

   XUartNs550_Recv(&fh_data->link.uart,
         fh_data->buffers.rxBuffer,
         sizeof(fh_data->buffers.rxBuffer));

   return IRC_SUCCESS;
}

/***************************************************************************//**
   Function that consumes all responses received from the Faulhaber controller.

   @param a pointer to a FH_ctrl_t structure of the target channel

   @return the number of bytes sent

*******************************************************************************/
void FH_consumeResponses(FH_ctrl_t* data)
{
   if (data == 0)
      return;

   // avoid playing with buffers while a TX is on
   if (data->buffers.txBusy)
      return;

   while (data->fh_data.numResponses != 0)
   {
      uint8_t type;
      uint8_t value8;
      _int_ value32;
      CBB_Pop(&data->fh_data.respTypes, &type);
      switch (type)
      {
      case FHR_ACK:
         FH_INF("ACK");
         CBB_Pop(&data->fh_data.responses, &type);
         break;
      case FHR_NOTIFY:
         CBB_Pop(&data->fh_data.responses, &value8);
         FH_INF("NOTIFY (%c)", value8);
         break;
      case FHR_NUMERIC:
         CBB_Popn(&data->fh_data.responses, 4, value32.bytes);
         FH_INF("NUMERIC (%d)", value32.val);
         break;
      case FHR_STRING:
         CBB_Pop(&data->fh_data.responses, &value8);
         FH_INF("STRING (%c)", value8);
         break;

      default:
         FH_ERR("Unknown response type : %d", type);
      }
      --data->fh_data.numResponses;
   }

   data->fh_data.numExpectedAck = 0;
}

/***************************************************************************//**
   Function that pops one numerical value received in response to a query from
   front of the reception queue.

   @param a pointer to a FH_ctrl_t structure of the target channel
   @param a pointer to a return value (int32_t)

   @return true if a value was available and the value pointer is valid

*******************************************************************************/
bool FH_readValue(FH_ctrl_t* data, int32_t* value)
{
   uint8_t respType;
   bool valid = false;

   // avoid playing with buffers while a TX is on
   if (data->buffers.txBusy)
   {
      return false;
   }

   if (CBB_Peek(&data->fh_data.respTypes, 0, &respType) != IRC_SUCCESS)
   {
      return false;
   }

   if (respType == FHR_NUMERIC)
   {
      _int_ theValue;

      CBB_Pop(&data->fh_data.respTypes, &respType);
      CBB_Popn(&data->fh_data.responses, 4, theValue.bytes);

      --data->fh_data.numResponses;

      *value = theValue.val;
      valid = true;
   }
   return valid;
}

/***************************************************************************//**
   Function that one notification from the front of the response queue

   @param a pointer to a FH_ctrl_t structure of the target channel
   @param a pointer to a return value (uint8_t)

   @return true if a notification was available and the value pointer is valid

*******************************************************************************/
bool FH_readNotification(FH_ctrl_t* data, uint8_t* value)
{
   uint8_t respType;
   bool valid = false;

   // avoid playing with buffers while a TX is on
   if (data->buffers.txBusy)
      return false;

   if (CBB_Peek(&data->fh_data.respTypes, 0, &respType) != IRC_SUCCESS)
      return false;

   if (respType == FHR_NOTIFY)
   {
      CBB_Pop(&data->fh_data.respTypes, &respType);
      CBB_Pop(&data->fh_data.responses, value);

      --data->fh_data.numResponses;

      valid = true;
   }

   return valid;
}

/***************************************************************************//**
   Function that reads ack responses from the reception queue. Returns the number
   of ack actually read

   @param a pointer to a FH_ctrl_t structure of the target channel

   @return the number of ACK response read.

*******************************************************************************/
uint8_t FH_readAcks(FH_ctrl_t* data)
{
   uint8_t numRead = 0;
   uint8_t respType, resp;
   uint8_t length = data->fh_data.numResponses;

   IRC_Status_t status;

   // avoid playing with buffers while a TX is on
   if (data->buffers.txBusy)
      return 0;

   status = CBB_Peek(&data->fh_data.respTypes, 0, &respType);
   while (status == IRC_SUCCESS && length > 0 && respType == FHR_ACK)
   {
      CBB_Pop(&data->fh_data.respTypes, &respType);
      CBB_Pop(&data->fh_data.responses, &resp);

      --data->fh_data.numResponses;
      ++numRead;

      length = CBB_Length(&data->fh_data.respTypes);
      status = CBB_Peek(&data->fh_data.respTypes, 0, &respType);
   }

   return numRead;
}

/***************************************************************************//**
   Get the number of expected ACKs following a program sequence sent to the
   motor controller

   @param a pointer to a FH_ctrl_t structure of the target channel

   @return the number of expected ACK responses

*******************************************************************************/
uint8_t FH_numExpectedAcks(FH_ctrl_t* data)
{
   return data->fh_data.numExpectedAck;
}

/***************************************************************************//**
   Clear N acks from the number of expected acks. Should be used along with the
   FH_readAcks() function, which returns the number of ACKs received and processed.

   @param a pointer to a FH_ctrl_t structure of the target channel

   @return the number of expected ACK responses

*******************************************************************************/
uint8_t FH_clearAcks(FH_ctrl_t* data, uint8_t n)
{
   uint8_t remaining;
   remaining = data->fh_data.numExpectedAck - MIN(n, data->fh_data.numExpectedAck);

   data->fh_data.numExpectedAck = remaining;

   return remaining;
}

/***************************************************************************//**
   Function that transfers the TX data to the UART channel. It should be called
   regularly by a controller to empty the buffers as soon as TX data is ready.

   @param a pointer to a FH_ctrl_t structure with data relevant to the communication channel and motor controller

   @return the number of bytes sent

*******************************************************************************/
uint32_t FH_sendPendingCmds(FH_ctrl_t* chan)
{
	uint32_t n = 0;
	uint32_t bytesSent;
#ifdef FH_TX_VERBOSE
	char tmp[64];
#endif

	if (chan->buffers.txBusy)
	   return 0;

	// the MCDC controller supports commands with some delay between bytes,
	// thus we can safely cut the buffer anywhere without questioning.
	bytesSent = MIN(FH_MAX_TX_SIZE, chan->buffers.txDataCount);

	if (bytesSent > 0)
   {
      chan->buffers.txBusy = 1;
      n = XUartNs550_Send(&chan->link.uart, chan->buffers.txBuffer, bytesSent);
   }

#ifdef FH_TX_VERBOSE
	if (bytesSent)
	{
	   int i=0;
	   for (i=0; i<bytesSent; ++i)
	   {
	      if (chan->buffers.txBuffer[i] != CR_CHAR)
	         tmp[i] = chan->buffers.txBuffer[i];
	      else
	         tmp[i] = '.';
	   }
	   tmp[i] = 0;
	   FH_INF("(length=%d) : %s", bytesSent, (char*)tmp);
	}
#endif

	return n;
}

void responseTypeAsString(FH_RESPONSE_TYPE_t type, char* str)
{
   switch (type)
   {
   case FHR_ACK:
      sprintf(str, "ACK");
      break;

   case FHR_STRING:
      sprintf(str, "STRING");
      break;

   case FHR_NUMERIC:
      sprintf(str, "NUMERIC");
      break;

   case FHR_NOTIFY:
      sprintf(str, "NOTIFY");
      break;

   default:
      sprintf(str, "UNKOWN");
   };
}

void FH_ProtocolHandler(FH_ctrl_t* ctrl)
{
   if (ctrl)
   {
      FH_sendPendingCmds(ctrl);
      FH_parseResponse(ctrl);
   }
}
