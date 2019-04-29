/*
 * @file RpOpticalProtocol.c
 *
 * interface driver implementation.
 *
 * $Rev$
 * $Author$ ecloutier
 * $Date$   4 décembre 2017
 * $Id$
 * $URL$ .../FIR-00251-Proc/src/Zoom/RpOpticalProtocol.c
 *
 * (c) Copyright 2017 Telops Inc.
 */

#include "RpOpticalProtocol.h"
#include "xparameters.h"
#include "FlashSettings.h"
#include "hder_inserter.h"
#include "calib.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

////////// ***** Variables globales ***** //////////////
lensTable_t    lensLookUpTable;
uint16_t gMotorLensFocalLength;
int32_t userFOV1PosMax, userFOV2PosMax, userFOV3PosMax, userFOV4PosMax;
extern bool autofocusLaunch;

////////// ***** private functions ***** ///////////////
bool sendNoDataCommand(rpCtrl_t* aCtrl, uint8_t anId, uint8_t aChksum);
uint8_t computeChkSumNoData(uint8_t aCommandId);


////////// ***** public functions *****
/*
 * @brief Initialization function for the UART channel of the RP Optical interface.
 *
 * @param pGCRegs       : a pointer to the gcRegistersData_t structure
 * @param aCtrl         : a pointer to a rpCtrl_t structure with information on the target channel
 * @param uartDeviceId  : uartDeviceId
 * @param XIntc         : a pointer to the interrupt controller instance (XIntc*)
 * @param uartIntrId    : the interrupt ID to activate
 *
 * @return IRC_SUCCESS or IRC_FAILURE
*/
XStatus RPOpt_init(gcRegistersData_t* pGCRegs, rpCtrl_t* aCtrl, uint16_t uartDeviceId, XIntc* intc, uint16_t uartIntrId)
{
   XStatus status;

   CBB_Init(&aCtrl->responses, aCtrl->rawBytes, sizeof(aCtrl->rawBytes));
   aCtrl->serial_data.rxDataCount = 0;
   aCtrl->serial_data.txDataCount = 0;
   aCtrl->serial_data.txBusy = 0;
   aCtrl->rpParsingState = sync;
   aCtrl->rpDataState = getZoom1;
   aCtrl->parsingDone = 0;
   aCtrl->initDone = 0;
   aCtrl->readingDone = false;
   aCtrl->tableLength = 0;
   aCtrl->dataCount = 0;

   memset(aCtrl->serial_data.rxBuffer, 0, sizeof(aCtrl->serial_data.rxBuffer));
   memset(aCtrl->serial_data.txBuffer, 0, sizeof(aCtrl->serial_data.txBuffer));

   status = CircularUART_Init(  &aCtrl->theUart,
                        uartDeviceId,
                        intc,
                        uartIntrId,
                        RP_OPT_UART_IntrHandler,
                        (void *)(aCtrl),
                        Ns550);


   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   status = CircularUART_Config(&aCtrl->theUart, RP_OPT_DEFAULT_BAULDRATE, RP_OPT_DATA_BITS, RP_OPT_PARITY, RP_OPT_STOP_BITS);
   if (status != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   // Reset RX FIFO
   CircularUART_ResetFifo(&aCtrl->theUart);

   XUartNs550_SetFifoThreshold(&aCtrl->theUart.uart.Ns550, XUN_FIFO_TRIGGER_08);

   XUartNs550_Recv(  &aCtrl->theUart.uart.Ns550,
                     aCtrl->serial_data.rxBuffer,
                     sizeof( aCtrl->serial_data.rxBuffer));

   return IRC_SUCCESS;
}

/*
 * @brief Front processing function of the RP OPT driver including the parsing state machine
 *
 * @param aCtrl      : a pointer to a rpCtrl_t structure
 * @param pGCRegs    : a pointer to the gcRegistersData_t structure
 *
 * @return void
*/
void RPopt_ProtocolHandler_SM(rpCtrl_t* aCtrl, gcRegistersData_t* pGCRegs)
{
   uint32_t firstRegister = 0;
   rpParsingState_t state = aCtrl->rpParsingState;
   rpDataState_t dataState = aCtrl->rpDataState;
   unsigned char byte;

   if(flashSettings.MotorizedLensType != MLT_RPOpticalODEM660)
   {
      return;
   }

   if(!aCtrl->serial_data.txBusy)
   {
      if(aCtrl->serial_data.txDataCount > 0)
      {
         aCtrl->serial_data.txBusy = 1;
         XUartNs550_Send(&aCtrl->theUart.uart.Ns550, aCtrl->serial_data.txBuffer, aCtrl->serial_data.txDataCount);
      }

   }

      // deactivate uart interruptions
      //firstRegister = XUartNs550_ReadReg(aCtrl->theUart.BaseAddress, XUN_IER_OFFSET);
      //XUartNs550_WriteReg(aCtrl->theUart.BaseAddress, XUN_IER_OFFSET, 0);

   /*if(aCtrl->parsingDone < 1)
   {
      CBB_Flush(&aCtrl->responses);
   }*/

      while (CBB_Pop(&aCtrl->responses, &byte) == IRC_SUCCESS)
      {
            switch(state)
            {
               case sync:
               default:
               {
                  if(byte == 0x24)
                  {
                     aCtrl->lastResponseData = aCtrl->currentResponseData;
                     state = getCom;
                  }
                  RP_OPT_PRINTF("sync\n");
                  break;
               }

               case getCom:
               {
                    aCtrl->currentResponseData.command = byte;                // ToDo ECL transfer to global var
                    aCtrl->currentResponseData.checksum = 0x24 ^ byte;
                    aCtrl->dataBuf[0] = byte;
                    state = getDataLength1;
                    RP_OPT_PRINTF("command:\n");
                    break;
               }

               case getDataLength1:
               {

                  aCtrl->currentResponseData.dataLength = (uint16_t)(byte);   // byte 0 : val % 256
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getDataLength2;
                  aCtrl->dataBuf[1] = byte;
                  RP_OPT_PRINTF("dataLength1:\n");
                  break;
               }

               case getDataLength2:
               {
                  uint16_t temp = (uint16_t)(byte) * 256;                     // byte 1 : val /256
                  aCtrl->currentResponseData.dataLength += temp;
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  aCtrl->dataBuf[2] = byte;
                  switch(aCtrl->currentResponseData.command)
                  {
                     case BIT:                     // built in tests response flags
                     {
                        state = getBitResponse1;
                        break;
                     }

                     case WRITE:
                     {
                        state = getAck;
                        break;
                     }

                     case HOURS:                   // Working hours and version
                     case VERSION:
                     {
                        state = getParam1;
                        break;
                     }

                     case TEMPERATURE:
                     {
                        state = getTemperature1;
                        break;
                     }

                     case READ:
                     {
                        state = reading;
                        break;
                     }

                     case ADDRESS:
                     {
                        state = sync;
                        break;
                     }

                     case ENDOFACTION:
                     {
                        state = getData;
                        break;
                     }

                     default:
                     {
                        state = sync;
                     }
                  }

                  RP_OPT_PRINTF("dataLength2:\n");
                  break;
               }

               case getData:
               {
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  switch(dataState)
                  {
                     default:
                     case getZoom1:
                     {
                        aCtrl->currentResponseData.zoomEncValue = (uint16_t)(byte);    // byte 0 : val % 256
                        dataState = getZoom2;
                        aCtrl->dataBuf[3] = byte;
                        RP_OPT_PRINTF("getZoom1:\n");
                        break;
                     }

                     case getZoom2:
                     {
                        uint16_t temp = (uint16_t)(byte) * 256;                     // byte 1 : val / 256
                        aCtrl->currentResponseData.zoomEncValue += temp;
                        dataState = getFocus1;
                        aCtrl->dataBuf[4] = byte;
                        RP_OPT_PRINTF("getZoom2:\n");
                        break;
                     }

                     case getFocus1:
                     {
                        aCtrl->currentResponseData.focusEncValue = (uint16_t)(byte);   // byte 0 : val % 256
                        dataState = getFocus2;
                        aCtrl->dataBuf[5] = byte;
                        RP_OPT_PRINTF("getFocus1:\n");
                        break;
                     }

                     case getFocus2:
                     {
                        uint16_t temp = (uint16_t)(byte) * 256;                     // byte 1 : val /256
                        aCtrl->currentResponseData.focusEncValue += temp;
                        dataState = getTemp;
                        aCtrl->dataBuf[6] = byte;
                        RP_OPT_PRINTF("getFocus2:\n");
                        break;
                     }

                     case getTemp:
                     {
                        aCtrl->currentResponseData.temperature = (int8_t)byte;
                        RP_OPT_PRINTF("getTemp:\n");
                        aCtrl->dataBuf[7] = byte;
                        dataState = getFov;
                        break;
                     }

                     case getFov:
                     {
                        RP_OPT_PRINTF("getFov:\n");
                        dataState = getZoom1;
                        aCtrl->dataBuf[8] = byte;
                        state = getAck;
                        break;
                     }
                  }
                  break;
               }

               case getBitResponse1:
               {
                  aCtrl->builtInTest = (uint8_t)(byte);
                  if(aCtrl->builtInTest > 0)
                  {
                     RP_OPT_ERR("Built in test : %X\n", aCtrl->builtInTest);
                  }
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getBitResponse2;
                  RP_OPT_PRINTF("getBitResponse1:\n");
                  break;
               }

               case getBitResponse2:
               {
                  // this data is not used by RP Optical (Reserve)
                  state = getAck;
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  RP_OPT_PRINTF("getBitResponse2:\n");
                  break;
               }

               case getParam1:
               {
                  // we dont use this one at this moment
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getParam2;
                  RP_OPT_PRINTF("getParam1:\n");
                  break;
               }

               case getParam2:
               {
                  // we dont use this one at this moment
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getAck;
                  RP_OPT_PRINTF("getParam2:\n");
                  break;
               }

               case getTemperature1:
               {
                  // we dont use max temp recorded at this moment
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getTemperature2;
                  RP_OPT_PRINTF("getTemperature1:\n");
                  break;
               }

               case getTemperature2:
               {
                  // we dont use min temp recorded at this moment
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getTemperature3;
                  RP_OPT_PRINTF("getTemperature2:\n");
                  break;
               }

               case getTemperature3:
               {
                  aCtrl->currentResponseData.temperature = (int8_t)(byte - 100);
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  state = getAck;
                  RP_OPT_PRINTF("getTemperature3:\n");
                  break;
               }

               case reading:
               {
                  uint8_t ind = aCtrl->dataCount;
                  aCtrl->dataBuf[ind] = byte;
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  ind += 1;
                  if(ind > (aCtrl->currentResponseData.dataLength-1))
                  {
                     state = getAck;
                     aCtrl->dataCount = 0;
                  }
                  else
                  {
                     aCtrl->dataCount = ind;
                  }
                  RP_OPT_PRINTF("reading:\n");
                  break;
               }

               case getAck:
               {
                  aCtrl->currentResponseData.ack = byte;
                  RP_OPT_PRINTF("getAck\n");
                  aCtrl->currentResponseData.checksum = aCtrl->currentResponseData.checksum ^ byte;
                  if(byte > 0xFE)
                  {
                     RP_OPT_ERR("Operation not successful : %x", aCtrl->currentResponseData.command);
                  }
                  aCtrl->dataBuf[9] = byte;
                  state = chksum;
                  break;
               }

               case chksum:
               {
                  extern t_HderInserter gHderInserter;
                  extern t_calib gCal;
                  uint8_t temp = aCtrl->currentResponseData.command;

                  if(aCtrl->currentResponseData.checksum == byte)
                  {
                     aCtrl->lastResponseData = aCtrl->currentResponseData;
                     if(temp == 41)
                     {
                           // Update feedback registers if they have changed
                           if (pGCRegs->FocusPositionRaw != (int32_t)aCtrl->currentResponseData.focusEncValue)
                           {
                              pGCRegs->FocusPositionRaw = (int32_t)aCtrl->currentResponseData.focusEncValue;
                              HDER_UpdateFocusPositionRawHeader(&gHderInserter, pGCRegs);
                              RP_OPT_INF("Focus move done (%d).", pGCRegs->FocusPositionRaw);
                           }
                           if (pGCRegs->FOVPositionRaw != (int32_t)aCtrl->currentResponseData.zoomEncValue)
                           {
                              pGCRegs->FOVPositionRaw = (int32_t)aCtrl->currentResponseData.zoomEncValue;
                              pGCRegs->FOVPosition = RPOpt_ConvertRawPosToFOVPos(pGCRegs->FOVPositionRaw);
                              HDER_UpdateFOVPositionHeader(&gHderInserter, pGCRegs);
                              RP_OPT_INF("FOV move done (%d).", pGCRegs->FOVPositionRaw);

                              if (pGCRegs->FOVPosition != pGCRegs->FOVPositionSetpoint)
                                 RP_OPT_ERR("FOVPosition (%d) does not match FOVPositionSetpoint (%d).", pGCRegs->FOVPosition, pGCRegs->FOVPositionSetpoint);

                              if (GC_CalibrationIsActive &&    // Not in RAW or RAW0
                                    ((calibrationInfo.collection.CollectionType == CCT_TelopsFOV) || (calibrationInfo.collection.CollectionType == CCT_MultipointFOV)))
                              {
                                 CAL_UpdateCalibBlockSelMode(&gCal, pGCRegs);
                              }
                           }
                     }

                     RP_OPT_PRINTF("good chksum:\n");
                  }
                  else
                  {
                     aCtrl->currentResponseData = aCtrl->lastResponseData;
                     RP_OPT_ERR("bad chksum\n");
                     firstRegister = XUartNs550_ReadReg(aCtrl->theUart.uart.Ns550.BaseAddress, XUN_IER_OFFSET);
                     XUartNs550_WriteReg(aCtrl->theUart.uart.Ns550.BaseAddress, XUN_IER_OFFSET, 0);
                     CBB_Pushn(&aCtrl->responses, 10, aCtrl->dataBuf);
                     XUartNs550_WriteReg(aCtrl->theUart.uart.Ns550.BaseAddress, XUN_IER_OFFSET, firstRegister);
                  }

                  switch(temp)
                  {
                     case TEMPERATURE:
                     case ENDOFACTION:
                     {
                        if(aCtrl->parsingDone > 0)
                        {
                           aCtrl->parsingDone -= 1;
                        }
                        break;
                     }

                     case BIT:
                     {
                        aCtrl->initDone -= 1;
                        break;
                     }

                     case READ:
                     {
                        if(aCtrl->parsingDone > 0)
                        {
                           aCtrl->parsingDone -= 1;
                        }
                        break;
                     }

                     default:
                     {
                        RP_OPT_PRINTF("Nothing to Do in checksum State for that command", byte);
                     }
                  }

                  state = sync;
                  break;
               }
            }
            RP_OPT_PRINTF("byte: %x\n", byte);
      }
      aCtrl->rpParsingState = state;
      aCtrl->rpDataState = dataState;

      // Reactivate UART interrupt
      //XUartNs550_WriteReg(aCtrl->theUart.BaseAddress, XUN_IER_OFFSET, firstRegister);
}

/*
*   @brief Interrupt handler for the UART.
*   Upon reception, response bytes are processed by the parsing state machine.
*
*   @param CallBackRef  : a pointer to a rpCtrl_t structure with data relevant to the communication channel and motor controller
*   @param Event        :  the type of event (RX or TX)
*   @param EventData    : (usually the number of bytes sent or received for the events that interest us)
*
*   @return void
*/
void RP_OPT_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData)
{
   uint32_t n;
   rpCtrl_t* theCtrl = (rpCtrl_t *)CallBackRef;

   switch (Event)
   {
      case XUN_EVENT_RECV_TIMEOUT:                    // Data was received but stopped for 4 character periods.
      case XUN_EVENT_RECV_DATA:                       // Data has been received.
      {
         // Listen for command on UART
         n = XUartNs550_Recv(&theCtrl->theUart.uart.Ns550, theCtrl->serial_data.rxBuffer, sizeof(theCtrl->serial_data.rxBuffer));

         // CR_WARNING for some reason, n is always 0! thus we use EventData, which contains the actual number of bytes received
         n = EventData;

         if (CBB_Pushn(&theCtrl->responses, n, theCtrl->serial_data.rxBuffer) != IRC_SUCCESS)
         {
            RP_OPT_ERR("Unable to push RX data in the circular buffer.");
         }
         break;
      }

      case XUN_EVENT_RECV_ERROR:                      // Data was received with an error.
      {
         RP_OPT_ERR("XUN_EVENT_RECV_ERROR");
         break;
      }

      case XUN_EVENT_SENT_DATA:                       // data was sent
      {
         if (theCtrl->serial_data.txDataCount >= EventData)
         {
            theCtrl->serial_data.txDataCount -= EventData;
            memmove((char*)theCtrl->serial_data.txBuffer, (char*)theCtrl->serial_data.txBuffer + EventData, theCtrl->serial_data.txDataCount);
         }
         theCtrl->serial_data.txBusy = 0;
         break;
      }

      case XUN_EVENT_MODEM:
      {
         RP_OPT_INF("XUN_EVENT_MODEM");
         break;
      }

      default:
      {
         RP_OPT_ERR("Unknown UART event %d", Event);
      }
   }
}

/*
 * @brief Send a no data command (constant checksum)
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 * @param anID    : command id
 * @param aChksum : bitwise xor of sync char ^ ... ^ data(n-1)
 *
 * @return true if successful
*/
bool sendNoDataCommand(rpCtrl_t* aCtrl, uint8_t anId, uint8_t aChksum)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;
   aCtrl->serial_data.txBuffer[ind++] = anId;
   aCtrl->serial_data.txBuffer[ind++] = 0x0;
   aCtrl->serial_data.txBuffer[ind++] = 0x0;
   aCtrl->serial_data.txBuffer[ind++] = aChksum;
   aCtrl->serial_data.txDataCount += 5;

   aCtrl->parsingDone += 1;
   return true;
}

/*
 * @brief Compute the checksum for a not data command
 *
 * @param aCommandId : command id
 *
 * @return  bitwise xor of : (sync char ^ aCommandId ^ 0x00 ^ 0x00)
*/
uint8_t computeChkSumNoData(uint8_t aCommandId)
{
   return (uint8_t)(0x24 ^ aCommandId ^ 0x00 ^ 0x00);
}

/*
 * @brief Moves the lens to FOV1 at predefined focus position and maintain it
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goToFOV1(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FOV1, 0x2A);
}

/*
 * @brief Moves the lens to FOV2 at predefined focus position and maintain it
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goToFOV2(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FOV2, 0x2B);
}

/*
 * @brief Moves the lens to FOV3 at predefined focus position and maintain it
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goToFOV3(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FOV3, 0x34);
}

/*
 * @brief Moves the lens to FOV4 at predefined focus position and maintain it
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goToFOV4(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FOV4, 0x35);
}

/*
 * @brief Moves the lens to FOV5 at predefined focus position and maintain it
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goToFOV5(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FOV5, 0x36);
}

/*
 * @brief Get lens positions, FW version, working hours, lens serial and <end of action> responses
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool reportParameters(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, PARAM, 0x26);
}

/*
 * @brief Set speed for zoom and focus (no gen response verification)
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aZoomSpeed    : zoom speed from 1 to 7
 * @param aFocusSpeed   : focus speed from 1 to 7
 *
 * @return true if successful
*/
bool setSpeed(rpCtrl_t* aCtrl, uint8_t aZoomSpeed, uint8_t aFocusSpeed)
{
   if(aCtrl->serial_data.txBusy || aZoomSpeed > 7 || aFocusSpeed > 7)
   {
      return false;
   }

   uint8_t checksum = 0x24 ^ SPEED ^ 0x02 ^ 0x00 ^ aZoomSpeed ^ aFocusSpeed;
   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = SPEED;        // command id
   aCtrl->serial_data.txBuffer[ind++] = 0x2;          // datalength byte 0 (%256)
   aCtrl->serial_data.txBuffer[ind++] = 0x0;          // datalength byte 1 (/256)
   aCtrl->serial_data.txBuffer[ind++] = aZoomSpeed;   // zoom speed
   aCtrl->serial_data.txBuffer[ind++] = aFocusSpeed;  // focus speed
   aCtrl->serial_data.txBuffer[ind++] = checksum;      // bitwise xor of sync ^ ... ^ aFocusSpeed
   aCtrl->serial_data.txDataCount += 7;
   return true;
}

/*
 * @brief Go fast to a focus specified by encoder value
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aFocusVal     : focus encoder value (<64000)
 *
 * @return true if successful
*/
bool goFastToFocus(rpCtrl_t* aCtrl, uint16_t aFocusVal)
{
   if(aCtrl->serial_data.txBusy || aFocusVal > 64000)
   {
      return false;
   }

   uint8_t byte0 = aFocusVal % 256;
   uint8_t byte1 = aFocusVal / 256;
   uint8_t checksum = 0x24 ^ GOFASTFOC ^ 0x02 ^ 0x00 ^ byte0 ^ byte1;
   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = GOFASTFOC;    // command id
   aCtrl->serial_data.txBuffer[ind++] = 0x2;          // datalength byte 0 (%256)
   aCtrl->serial_data.txBuffer[ind++] = 0x0;          // datalength byte 1 (/256)
   aCtrl->serial_data.txBuffer[ind++] = byte0;
   aCtrl->serial_data.txBuffer[ind++] = byte1;
   aCtrl->serial_data.txBuffer[ind++] = checksum;      // bitwise xor of sync ^ ... ^ aFocusSpeed
   aCtrl->serial_data.txDataCount += 7;

   aCtrl->parsingDone += 1;
   return true;
}

/*
 * @brief Initialize the address pointer for read and write operations
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param anAddress     : memory address
 *
 * @return true if successful
*/
bool setAddress(rpCtrl_t* aCtrl, uint16_t anAddress)
{
   if(aCtrl->serial_data.txBusy || anAddress > 0x0FFF)
   {
      return false;
   }

   uint8_t byte0 = anAddress % 256;
   uint8_t byte1 = anAddress / 256;

   uint8_t checksum = 0x24 ^ ADDRESS ^ 0x02 ^ 0x00 ^ byte0 ^ byte1;
   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = ADDRESS;      // command id
   aCtrl->serial_data.txBuffer[ind++] = 0x2;          // datalength byte 0 (%256)
   aCtrl->serial_data.txBuffer[ind++] = 0x0;          // datalength byte 1 (/256)
   aCtrl->serial_data.txBuffer[ind++] = byte0;        // address byte0
   aCtrl->serial_data.txBuffer[ind++] = byte1;        // address byte1
   aCtrl->serial_data.txBuffer[ind++] = checksum;     // bitwise xor of sync ^ ... ^ address byte1
   aCtrl->serial_data.txDataCount += 7;
   // gen acknowledge response
   return true;
}

/*
 * @brief write data to RP Optical memory (the write/read pointer needs to be initialize)
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aNumber       : nbr of data bytes (max 200)
 * @param aBuf          : pointer to data
 *
 * @return true if successful and the write/read pointer is incremented
*/
bool writeData(rpCtrl_t* aCtrl, uint8_t aNumber, uint8_t* aBuf)
{
   uint8_t ind = aCtrl->serial_data.txDataCount;
   uint8_t count = 0;

   if( (ind + aNumber) > 96)
   {
      return false;
   }

   while(aCtrl->serial_data.txBusy)
   {
      WAIT_US(20);
   }

   uint8_t checksum = 0x24 ^ WRITE ^ aNumber ^ 0x00;

   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = WRITE;        // command id
   aCtrl->serial_data.txBuffer[ind++] = aNumber;      // datalength byte 0 (%256)
   aCtrl->serial_data.txBuffer[ind++] = 0;            // datalength byte 1 (/256)
   while(count < aNumber)
   {
      aCtrl->serial_data.txBuffer[ind++] = aBuf[count];
      checksum = checksum ^ aBuf[count];
      count += 1;
   }
   aCtrl->serial_data.txBuffer[ind++] = checksum;     // bitwise xor of sync ^ ... ^ data(n-1)
   aCtrl->serial_data.txDataCount += (aNumber + 5);
   // gen acknowledge response
   return true;
}

/*
 * @brief write the Zoom-focus look up table in the Rp Optical EEPROM
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aBuf          : pointer to data
 *
 * @return true if successful
*/
bool writeRpTables(rpCtrl_t* aCtrl, uint8_t aLine)
{
   uint8_t i, byte0, byte1;
   uint8_t ind = 0;
   uint8_t buf[22];
   uint16_t temp;

      for(i=0; i<11; i++)
      {
         switch(i)
         {
            case 0:
            {
               temp = lensLookUpTable.zoom[aLine];
               break;
            }

            case 1:
            case 2:
            case 10:
            {
               temp = lensLookUpTable.focusAtTemp4[aLine];
               break;
            }

            case 3:
            {
               temp = lensLookUpTable.focusAtTemp1[aLine];
               break;
            }

            case 4:
            {
               temp = lensLookUpTable.focusAtTemp2[aLine];
               break;
            }

            case 5:
            {
               temp = lensLookUpTable.focusAtTemp3[aLine];
               break;
            }

            case 6:
            {
               temp = lensLookUpTable.focusAtTemp4[aLine];
               break;
            }

            case 7:
            {
               temp = lensLookUpTable.focusAtTemp5[aLine];
               break;
            }

            case 8:
            {
               temp = lensLookUpTable.focusAtTemp6[aLine];
               break;
            }

            case 9:
            {
               temp = lensLookUpTable.focusAtTemp7[aLine];
               break;
            }

            default:
            {

            }
         }
         byte0 = (uint8_t)(temp % 256);
         byte1 = (uint8_t)(temp / 256);
         buf[ind++] = byte0;
         buf[ind++] = byte1;
      }

      writeData(aCtrl, 22, buf);
      ind = 0;

   // gen acknowledge response
   return true;
}

/*
 * @brief Read data from RP Optical EEPROM (the write/read pointer needs to be initialize)
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aNumber       : nbr of data bytes (max 200)
 *
 * @return true if successful and the write/read pointer is incremented
*/
bool readData(rpCtrl_t* aCtrl, uint8_t aNumber)
{
   uint8_t ind = aCtrl->serial_data.txDataCount;

   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t checksum = 0x24 ^ READ ^ 0x02 ^ 0x00 ^ aNumber ^ 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = READ;         // command id
   aCtrl->serial_data.txBuffer[ind++] = 0x02;         // dataLength
   aCtrl->serial_data.txBuffer[ind++] = 0x00;         // dataLength
   aCtrl->serial_data.txBuffer[ind++] = aNumber;      // nbr of bytes to read
   aCtrl->serial_data.txBuffer[ind++] = 0;
   aCtrl->serial_data.txBuffer[ind++] = checksum;     // bitwise xor of sync ^ ... ^ data(n-1)
   aCtrl->serial_data.txDataCount += (7);
   // Report EEPROM response
   return true;
}

/*
 * @brief Go to the position defined by the encoders values (focus necessary)
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aZoomEncoder  : value from 0 to 64000
 * @param aFocusEncoder : value from 0 to 64000
 *
 * @return true if successful
*/
bool goManuallyToPos(rpCtrl_t* aCtrl, uint16_t aZoomEncoder, uint16_t aFocusEncoder)
{
   if(aCtrl->serial_data.txBusy || aZoomEncoder > 64000 || aFocusEncoder > 64000)
   {
      return false;
   }

   uint8_t byte0 = aZoomEncoder % 256;
   uint8_t byte1 = aZoomEncoder / 256;
   uint8_t byte2 = aFocusEncoder % 256;
   uint8_t byte3 = aFocusEncoder / 256;
   uint8_t checksum = 0x24 ^ GOTOPOS ^ 0x04 ^ 0x00 ^ byte0 ^ byte1 ^ byte2 ^ byte3;

   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = GOTOPOS;      // command id
   aCtrl->serial_data.txBuffer[ind++] = 0x4;          // datalength byte 0 (%256)
   aCtrl->serial_data.txBuffer[ind++] = 0x0;          // datalength byte 1 (/256)
   aCtrl->serial_data.txBuffer[ind++] = byte0;        // zoom byte 0
   aCtrl->serial_data.txBuffer[ind++] = byte1;        // zoom byte 1
   aCtrl->serial_data.txBuffer[ind++] = byte2;        // focus byte 0
   aCtrl->serial_data.txBuffer[ind++] = byte3;        // focus byte 1
   aCtrl->serial_data.txBuffer[ind++] = checksum;     // bitwise xor of sync ^ ... ^ byte3
   aCtrl->serial_data.txDataCount += 9;

   aCtrl->parsingDone += 1;
   return true;
}

/*
 * @brief Go to the position defined by the zoom encoder parameter and focus is taken from RP Look Up Table
 *
 * @param aCtrl         : a pointer to a rpCtrl_t structure
 * @param aZoomEncoder  : value from 0 to 64000
 *
 * @return true if successful
*/
bool goManuallyToZoomPos(rpCtrl_t* aCtrl, uint16_t aZoomEncoder)
{
   if(aCtrl->serial_data.txBusy || aZoomEncoder > 64000 )
   {
      return false;
   }

   uint8_t byte0 = aZoomEncoder % 256;
   uint8_t byte1 = aZoomEncoder / 256;
   uint8_t checksum = 0x24 ^ GOTOZOOMPOS ^ 0x02 ^ 0x00 ^ byte0 ^ byte1;

   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x24;         // sync char
   aCtrl->serial_data.txBuffer[ind++] = GOTOZOOMPOS;      // command id
   aCtrl->serial_data.txBuffer[ind++] = 0x2;          // datalength byte 0 (%256)
   aCtrl->serial_data.txBuffer[ind++] = 0x0;          // datalength byte 1 (/256)
   aCtrl->serial_data.txBuffer[ind++] = byte0;        // zoom byte 0
   aCtrl->serial_data.txBuffer[ind++] = byte1;        // zoom byte 1
   aCtrl->serial_data.txBuffer[ind++] = checksum;     // bitwise xor of sync ^ ... ^ byte3
   aCtrl->serial_data.txDataCount += 7;

   aCtrl->parsingDone += 1;
   return true;
}

/*
 * @brief Move focus lens up until a stop command
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goContFocusNear(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FNEAR, 0x05);
}

/*
 * @brief Move focus lens down until a stop command
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool goContFocusFar(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, FFAR, 0x06);
}

/*
 * @brief Get a <BIT> +  2 <end of action> responses for init
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return true if successful
*/
bool builtInTest(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, BIT, 0x28);
}

/*
 * @brief refresh actual temperature + max and min
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 *
 * @return (+-127)
*/
bool refreshTemperature(rpCtrl_t* aCtrl)
{
   return sendNoDataCommand(aCtrl, TEMPERATURE, 0x61);
}

/*
 * @brief Converts user-defined FOV position (XML) to lens-defined FOV position.
 *
 * @param UserFOV : FOV position to convert
 *
 * @return lens-defined FOV position
*/
LensFOV_t RPOpt_ConvertUserFOVtoLensFOV(FOVPositionSetpoint_t UserFOV)
{
   switch (UserFOV)
   {
      case FOVPS_FOV1:
         return (LensFOV_t)(flashSettings.FOV1ToLensFOV);

      case FOVPS_FOV2:
         return (LensFOV_t)(flashSettings.FOV2ToLensFOV);

      case FOVPS_FOV3:
         return (LensFOV_t)(flashSettings.FOV3ToLensFOV);

      case FOVPS_FOV4:
         return (LensFOV_t)(flashSettings.FOV4ToLensFOV);

      default:
         return LensFOV_Undefined;
   }
}

/*
 * @brief Converts lens-defined FOV position to encoder position.
 *
 * @param LensFOV : lens-defined FOV position
 *
 * @return encoder position if defined
*/
uint16_t RPOpt_ConvertLensFOVtoEncoder(LensFOV_t LensFOV)
{
   switch (LensFOV)
   {
      case LensFOV1:
         return lensLookUpTable.zoom[LENS_FOV1_IDX];

      case LensFOV2:
         return lensLookUpTable.zoom[LENS_FOV2_IDX];

      case LensFOV3:
         return lensLookUpTable.zoom[LENS_FOV3_IDX];

      case LensFOV4:
         return lensLookUpTable.zoom[LENS_FOV4_IDX];

      case LensFOV5:
         return lensLookUpTable.zoom[LENS_FOV5_IDX];

      case LensFOV_Undefined:
      default:
         return 0;
   }
}

/*
 * @brief Converts raw encoder position to user-defined FOV position (XML).
 *
 * @param rawPosition : raw encoder position
 *
 * @return user-defined FOV position
*/
FOVPositionSetpoint_t RPOpt_ConvertRawPosToFOVPos(int32_t rawPosition)
{
   if (rawPosition <= userFOV1PosMax)
      return FOVPS_FOV1;
   else if (rawPosition <= userFOV2PosMax)
      return FOVPS_FOV2;
   else if (rawPosition <= userFOV3PosMax)
      return FOVPS_FOV3;
   else
      return FOVPS_FOV4;
}

/*
 * @brief Moves the lens to lens-defined FOV position.
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 * @param LensFOV : lens-defined FOV position
 *
 * @return true if successful
*/
bool RPOpt_SetLensFOV(rpCtrl_t* aCtrl, LensFOV_t LensFOV)
{
   if(autofocusLaunch || !aCtrl->readingDone)
   {
      return false;
   }

   switch (LensFOV)
   {
      case LensFOV1:
         return goToFOV1(aCtrl);

      case LensFOV2:
         return goToFOV2(aCtrl);

      case LensFOV3:
         return goToFOV3(aCtrl);

      case LensFOV4:
         return goToFOV4(aCtrl);

      case LensFOV5:
         return goToFOV5(aCtrl);

      case LensFOV_Undefined:
      default:
         return false;
   }
}

/*
 * @brief Calculates new FOV raw position setpoint corresponding to desired zoom command.
 *
 * @param currentPos : current FOV raw position
 * @param cmd        : zoom command type
 *
 * @return new FOV raw position setpoint
*/
int32_t RPOpt_CalcZoomNewSetpoint(uint16_t currentPos, ZoomCommand_t cmd)
{
   switch (cmd)
   {
      case ZoomInFast:
         if (currentPos < ZOOM_CMD_LIMIT_POS)
            return (int32_t)(ZOOM_IN_FAST_M_1 * (float)currentPos) + ZOOM_IN_FAST_B_1;
         else
            return (int32_t)(ZOOM_IN_FAST_M_2 * (float)currentPos) + ZOOM_IN_FAST_B_2;

      case ZoomInSlow:
         if (currentPos < ZOOM_CMD_LIMIT_POS)
            return (int32_t)(ZOOM_IN_SLOW_M_1 * (float)currentPos) + ZOOM_IN_SLOW_B_1;
         else
            return (int32_t)(ZOOM_IN_SLOW_M_2 * (float)currentPos) + ZOOM_IN_SLOW_B_2;

      case ZoomOutFast:
         if (currentPos < ZOOM_CMD_LIMIT_POS)
            return (int32_t)(ZOOM_OUT_FAST_M_1 * (float)currentPos) + ZOOM_OUT_FAST_B_1;
         else
            return (int32_t)(ZOOM_OUT_FAST_M_2 * (float)currentPos) + ZOOM_OUT_FAST_B_2;

      case ZoomOutSlow:
         if (currentPos < ZOOM_CMD_LIMIT_POS)
            return (int32_t)(ZOOM_OUT_SLOW_M_1 * (float)currentPos) + ZOOM_OUT_SLOW_B_1;
         else
            return (int32_t)(ZOOM_OUT_SLOW_M_2 * (float)currentPos) + ZOOM_OUT_SLOW_B_2;

      default:
         return (int32_t)currentPos;
   }
}

/*
 * @brief Updates the registers related to FOV and focus.
 *
 * @param aCtrl      : a pointer to a rpCtrl_t structure
 * @param pGCRegs    : a pointer to the gcRegistersData_t structure
 *
 * @return void
*/
void RPOpt_UpdateRegisters(rpCtrl_t* aCtrl, gcRegistersData_t* pGCRegs)
{
   uint32_t idx;
   bool idx_found = false;
   uint16_t focus_at_idx, focus_at_idx_p1;
   float m, b;
   extern t_HderInserter gHderInserter;

   for (idx = 0; idx < (RP_OPT_TABLE_LEN - 1); idx++)
   {
      if (pGCRegs->FOVPositionRawSetpoint >= lensLookUpTable.zoom[idx] && pGCRegs->FOVPositionRawSetpoint <= lensLookUpTable.zoom[idx+1])
      {
         idx_found = true;
         break;
      }
   }

   // Do not update registers if value not found in table
   if (idx_found)
   {
      // Update FOVPositionSetpoint from FOVPositionRawSetpoint
      pGCRegs->FOVPositionSetpoint = RPOpt_ConvertRawPosToFOVPos(pGCRegs->FOVPositionRawSetpoint);
      if (pGCRegs->FOVPosition != pGCRegs->FOVPositionSetpoint)
      {
         // Set FOVInTransition and update header
         pGCRegs->FOVPosition = FOVP_FOVInTransition;
         HDER_UpdateFOVPositionHeader(&gHderInserter, pGCRegs);
      }

      // Compute temperature compensated focus position at the indexes found
      focus_at_idx = RPOpt_GetAthermFocus(aCtrl, idx);
      focus_at_idx_p1 = RPOpt_GetAthermFocus(aCtrl, idx+1);

      // Find interpolated focus position (between table indexes)
      m = (float)(focus_at_idx_p1 - focus_at_idx) / (float)(lensLookUpTable.zoom[idx+1] - lensLookUpTable.zoom[idx]);
      b = (float)focus_at_idx - (m * (float)lensLookUpTable.zoom[idx]);
      pGCRegs->FocusPositionRawSetpoint = (int32_t)(m * (float)pGCRegs->FOVPositionRawSetpoint + b);

      // Find interpolated deltaFocusMin (between table indexes) and apply it to focus position
      m = (float)(lensLookUpTable.deltaFocusMin[idx+1] - lensLookUpTable.deltaFocusMin[idx]) / (float)(lensLookUpTable.zoom[idx+1] - lensLookUpTable.zoom[idx]);
      b = (float)lensLookUpTable.deltaFocusMin[idx] - (m * (float)lensLookUpTable.zoom[idx]);
      pGCRegs->FocusPositionRawMin = pGCRegs->FocusPositionRawSetpoint + (int32_t)(m * (float)pGCRegs->FOVPositionRawSetpoint + b);   //deltaFocusMin < 0
      pGCRegs->FocusPositionRawMin = MIN( MAX(pGCRegs->FocusPositionRawMin, FOCUS_ENCODER_MIN), FOCUS_ENCODER_MAX );

      // Find interpolated deltaFocusMax (between table indexes) and apply it to focus position
      m = (float)(lensLookUpTable.deltaFocusMax[idx+1] - lensLookUpTable.deltaFocusMax[idx]) / (float)(lensLookUpTable.zoom[idx+1] - lensLookUpTable.zoom[idx]);
      b = (float)lensLookUpTable.deltaFocusMax[idx] - (m * (float)lensLookUpTable.zoom[idx]);
      pGCRegs->FocusPositionRawMax = pGCRegs->FocusPositionRawSetpoint + (int32_t)(m * (float)pGCRegs->FOVPositionRawSetpoint + b);
      pGCRegs->FocusPositionRawMax = MIN( MAX(pGCRegs->FocusPositionRawMax, FOCUS_ENCODER_MIN), FOCUS_ENCODER_MAX );

      // Find interpolated focal length (between table indexes)
      m = (float)(lensLookUpTable.focalLength[idx+1] - lensLookUpTable.focalLength[idx]) / (float)(lensLookUpTable.zoom[idx+1] - lensLookUpTable.zoom[idx]);
      b = (float)lensLookUpTable.focalLength[idx] - (m * (float)lensLookUpTable.zoom[idx]);
      gMotorLensFocalLength = (uint16_t)(m * (float)pGCRegs->FOVPositionRawSetpoint + b);
      GC_UpdateFOV();
   }
   else
      RP_OPT_ERR("FOVPositionRawSetpoint (%d) is not in the table.", pGCRegs->FOVPositionRawSetpoint);
}

/*
 * @brief Calculates athermalized focus position from look-up table.
 *
 * @param aCtrl   : a pointer to a rpCtrl_t structure
 * @param idx     : index of the look-up table
 *
 * @return athermalized focus position
*/
uint16_t RPOpt_GetAthermFocus(rpCtrl_t* aCtrl, uint32_t idx)
{
   float temp = (float)aCtrl->currentResponseData.temperature;
   float m, b;

   // Compute interpolation (between table temperatures)
   if (temp < FOCUS_TEMP_2)   // used for (temp < FOCUS_TEMP_1) and for (FOCUS_TEMP_1 < temp < FOCUS_TEMP_2)
   {
      m = ((float)lensLookUpTable.focusAtTemp2[idx] - (float)lensLookUpTable.focusAtTemp1[idx]) / (FOCUS_TEMP_2 - FOCUS_TEMP_1);
      b = (float)lensLookUpTable.focusAtTemp2[idx] - (m * FOCUS_TEMP_2);
   }
   else if (temp < FOCUS_TEMP_3)
   {
      m = ((float)lensLookUpTable.focusAtTemp3[idx] - (float)lensLookUpTable.focusAtTemp2[idx]) / (FOCUS_TEMP_3 - FOCUS_TEMP_2);
      b = (float)lensLookUpTable.focusAtTemp3[idx] - (m * FOCUS_TEMP_3);
   }
   else if (temp < FOCUS_TEMP_4)
   {
      m = ((float)lensLookUpTable.focusAtTemp4[idx] - (float)lensLookUpTable.focusAtTemp3[idx]) / (FOCUS_TEMP_4 - FOCUS_TEMP_3);
      b = (float)lensLookUpTable.focusAtTemp4[idx] - (m * FOCUS_TEMP_4);
   }
   else if (temp < FOCUS_TEMP_5)
   {
      m = ((float)lensLookUpTable.focusAtTemp5[idx] - (float)lensLookUpTable.focusAtTemp4[idx]) / (FOCUS_TEMP_5 - FOCUS_TEMP_4);
      b = (float)lensLookUpTable.focusAtTemp5[idx] - (m * FOCUS_TEMP_5);
   }
   else if (temp < FOCUS_TEMP_6)
   {
      m = ((float)lensLookUpTable.focusAtTemp6[idx] - (float)lensLookUpTable.focusAtTemp5[idx]) / (FOCUS_TEMP_6 - FOCUS_TEMP_5);
      b = (float)lensLookUpTable.focusAtTemp6[idx] - (m * FOCUS_TEMP_6);
   }
   else  // used for (FOCUS_TEMP_6 < temp < FOCUS_TEMP_7) and for (temp > FOCUS_TEMP_7)
   {
      m = ((float)lensLookUpTable.focusAtTemp7[idx] - (float)lensLookUpTable.focusAtTemp6[idx]) / (FOCUS_TEMP_7 - FOCUS_TEMP_6);
      b = (float)lensLookUpTable.focusAtTemp7[idx] - (m * FOCUS_TEMP_7);
   }

   // Return athermalized focus position
   return (uint16_t)(m * temp + b);
}

/*
 * @brief Updates the look-up table from flash settings.
 *
 * @return void
*/
void RPOpt_UpdateLensTableFromFlash()
{
   uint32_t idx;
   float incr_min, incr_max;;

   for (idx = 0; idx < RP_OPT_TABLE_LEN; idx++)
   {
      // Update deltaFocusMin and deltaFocusMax
      // Warning: LENS_FOV1_IDX must be 0
      if (idx < LENS_FOV2_IDX)
      {
         // Compute increments for the lines between lens FOV
         incr_min = (float)(flashSettings.LensFOV2DeltaFocusPositionMin - flashSettings.LensFOV1DeltaFocusPositionMin) / (float)(LENS_FOV2_IDX - LENS_FOV1_IDX);
         incr_max = (float)(flashSettings.LensFOV2DeltaFocusPositionMax - flashSettings.LensFOV1DeltaFocusPositionMax) / (float)(LENS_FOV2_IDX - LENS_FOV1_IDX);

         // Apply increments to deltas
         lensLookUpTable.deltaFocusMin[idx] = flashSettings.LensFOV1DeltaFocusPositionMin + (int16_t)(incr_min * (float)(idx - LENS_FOV1_IDX));
         lensLookUpTable.deltaFocusMax[idx] = flashSettings.LensFOV1DeltaFocusPositionMax + (int16_t)(incr_max * (float)(idx - LENS_FOV1_IDX));
      }
      else if (idx < LENS_FOV3_IDX)
      {
         // Compute increments for the lines between lens FOV
         incr_min = (float)(flashSettings.LensFOV3DeltaFocusPositionMin - flashSettings.LensFOV2DeltaFocusPositionMin) / (float)(LENS_FOV3_IDX - LENS_FOV2_IDX);
         incr_max = (float)(flashSettings.LensFOV3DeltaFocusPositionMax - flashSettings.LensFOV2DeltaFocusPositionMax) / (float)(LENS_FOV3_IDX - LENS_FOV2_IDX);

         // Apply increments to deltas
         lensLookUpTable.deltaFocusMin[idx] = flashSettings.LensFOV2DeltaFocusPositionMin + (int16_t)(incr_min * (float)(idx - LENS_FOV2_IDX));
         lensLookUpTable.deltaFocusMax[idx] = flashSettings.LensFOV2DeltaFocusPositionMax + (int16_t)(incr_max * (float)(idx - LENS_FOV2_IDX));
      }
      else if (idx < LENS_FOV4_IDX)
      {
         // Compute increments for the lines between lens FOV
         incr_min = (float)(flashSettings.LensFOV4DeltaFocusPositionMin - flashSettings.LensFOV3DeltaFocusPositionMin) / (float)(LENS_FOV4_IDX - LENS_FOV3_IDX);
         incr_max = (float)(flashSettings.LensFOV4DeltaFocusPositionMax - flashSettings.LensFOV3DeltaFocusPositionMax) / (float)(LENS_FOV4_IDX - LENS_FOV3_IDX);

         // Apply increments to deltas
         lensLookUpTable.deltaFocusMin[idx] = flashSettings.LensFOV3DeltaFocusPositionMin + (int16_t)(incr_min * (float)(idx - LENS_FOV3_IDX));
         lensLookUpTable.deltaFocusMax[idx] = flashSettings.LensFOV3DeltaFocusPositionMax + (int16_t)(incr_max * (float)(idx - LENS_FOV3_IDX));
      }
      else
      {
         // Compute increments for the lines between lens FOV
         incr_min = (float)(flashSettings.LensFOV5DeltaFocusPositionMin - flashSettings.LensFOV4DeltaFocusPositionMin) / (float)(LENS_FOV5_IDX - LENS_FOV4_IDX);
         incr_max = (float)(flashSettings.LensFOV5DeltaFocusPositionMax - flashSettings.LensFOV4DeltaFocusPositionMax) / (float)(LENS_FOV5_IDX - LENS_FOV4_IDX);

         // Apply increments to deltas
         lensLookUpTable.deltaFocusMin[idx] = flashSettings.LensFOV4DeltaFocusPositionMin + (int16_t)(incr_min * (float)(idx - LENS_FOV4_IDX));
         lensLookUpTable.deltaFocusMax[idx] = flashSettings.LensFOV4DeltaFocusPositionMax + (int16_t)(incr_max * (float)(idx - LENS_FOV4_IDX));
      }
   }
}

/*
 * @brief Updates the user-defined FOV position limits.
 *
 * @param pGCRegs    : a pointer to the gcRegistersData_t structure
 *
 * @return void
*/
void RPOpt_CalcFOVPositionLimits(gcRegistersData_t* pGCRegs)
{
   int32_t userFOV1CenterPos = (int32_t)RPOpt_ConvertLensFOVtoEncoder((LensFOV_t)(flashSettings.FOV1ToLensFOV));
   int32_t userFOV2CenterPos = (int32_t)RPOpt_ConvertLensFOVtoEncoder((LensFOV_t)(flashSettings.FOV2ToLensFOV));
   int32_t userFOV3CenterPos = (int32_t)RPOpt_ConvertLensFOVtoEncoder((LensFOV_t)(flashSettings.FOV3ToLensFOV));
   int32_t userFOV4CenterPos = (int32_t)RPOpt_ConvertLensFOVtoEncoder((LensFOV_t)(flashSettings.FOV4ToLensFOV));

   // Update FOVPositionRawMin and FOVPositionRawMax
   pGCRegs->FOVPositionRawMin = lensLookUpTable.zoom[0];
   pGCRegs->FOVPositionRawMax = lensLookUpTable.zoom[RP_OPT_TABLE_LEN-1];

   // Update max position for all FOVs
   switch (pGCRegs->FOVPositionNumber)
   {
      case 4:
         userFOV4PosMax = pGCRegs->FOVPositionRawMax;
         userFOV3PosMax = (userFOV3CenterPos + userFOV4CenterPos) / 2;
         userFOV2PosMax = (userFOV2CenterPos + userFOV3CenterPos) / 2;
         userFOV1PosMax = (userFOV1CenterPos + userFOV2CenterPos) / 2;
         break;

      case 3:
         userFOV4PosMax = pGCRegs->FOVPositionRawMax;
         userFOV3PosMax = pGCRegs->FOVPositionRawMax;
         userFOV2PosMax = (userFOV2CenterPos + userFOV3CenterPos) / 2;
         userFOV1PosMax = (userFOV1CenterPos + userFOV2CenterPos) / 2;
         break;

      case 2:
         userFOV4PosMax = pGCRegs->FOVPositionRawMax;
         userFOV3PosMax = pGCRegs->FOVPositionRawMax;
         userFOV2PosMax = pGCRegs->FOVPositionRawMax;
         userFOV1PosMax = (userFOV1CenterPos + userFOV2CenterPos) / 2;
         break;

      case 1:
      case 0:
      default:
         userFOV4PosMax = pGCRegs->FOVPositionRawMax;
         userFOV3PosMax = pGCRegs->FOVPositionRawMax;
         userFOV2PosMax = pGCRegs->FOVPositionRawMax;
         userFOV1PosMax = pGCRegs->FOVPositionRawMax;
         break;
   }

   RP_OPT_INF("userFOV1PosMax=%d, userFOV2PosMax=%d, userFOV3PosMax=%d, userFOV4PosMax=%d",
         userFOV1PosMax, userFOV2PosMax, userFOV3PosMax, userFOV4PosMax);
}
