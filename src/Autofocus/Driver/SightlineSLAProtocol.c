/*
 * SightlineSLAProtocol.c
 *
 *  Created on: 2017-12-07
 *      Author: ecloutier
 */
#include "SightlineSLAProtocol.h"
#include "UART_Utils.h"
#include "xparameters.h"
#include "FlashSettings.h"
#include <string.h>
#include <stdio.h>


////////// ***** Variables globales ***** //////////////
uint8_t  metricRegion;        // % of the screen (0 to 100)


const uint8_t crc8_Table[ ] =
{
0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
};

// ***** private functions *****



// ***** public functions *****
/*
 * @brief Initialization function for the UART channel of the RP Optical interface.
 *
 * @param a pointer to the gcRegistersData_t structure
 * @param a pointer to a slCtrl_t structure with information on the target channel
 * @param uartDeviceId
 * @param a pointer to the interrupt controller instance (XIntc*)
 * @param the interrupt ID to activate
 *
 * @return IRC_SUCCESS or IRC_FAILURE
*/
XStatus SL_init(gcRegistersData_t *pGCRegs, slCtrl_t *aCtrl, uint16_t uartDeviceId, XIntc* intc, uint16_t uartIntrId)
{
   XStatus status;

   CBB_Init(&aCtrl->responses, aCtrl->rawBytes, sizeof(aCtrl->rawBytes));
   aCtrl->serial_data.rxDataCount = 0;
   aCtrl->serial_data.txDataCount = 0;
   aCtrl->serial_data.txBusy = 0;
   aCtrl->slParsingState = sync1;
   aCtrl->lastResponseData.count = 0;

   memset(aCtrl->serial_data.rxBuffer, 0, sizeof(aCtrl->serial_data.rxBuffer));
   memset(aCtrl->serial_data.txBuffer, 0, sizeof(aCtrl->serial_data.txBuffer));

   status = UART_Init(  &aCtrl->theUart,
                        uartDeviceId,
                        intc,
                        uartIntrId,
                        SL_UART_IntrHandler,
                        (void *)(aCtrl));

   if (status != IRC_SUCCESS)
   {
     return IRC_FAILURE;
   }

   status = UART_Config(&aCtrl->theUart, SL_DEFAULT_BAULDRATE, SL_DATA_BITS, SL_PARITY, SL_STOP_BITS);
   if (status != IRC_SUCCESS)
   {
     return IRC_FAILURE;
   }

   // Reset RX FIFO
   UART_ResetRxFifo(&aCtrl->theUart);

   XUartNs550_SetFifoThreshold(&aCtrl->theUart, XUN_FIFO_TRIGGER_14);

   XUartNs550_Recv(  &aCtrl->theUart,
                     aCtrl->serial_data.rxBuffer,
                     sizeof( aCtrl->serial_data.rxBuffer));

   return IRC_SUCCESS;
}

/*
*   @brief Interrupt handler for the UART.
*   Upon reception of bytes, they are processed by the parsing state machine.
*
*   @param CallBackRef : a pointer to slCtrl_t structure with data relevant to the communication channel and motor controller
*   @param Event, the type of event (RX or TX)
*   @param EventData (usually the number of bytes sent or received for the events that interest us)
*
*   @return void
*/
void SL_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData)
{
   uint32_t n;
   slCtrl_t* theCtrl = (slCtrl_t *)CallBackRef;

   switch (Event)
   {
      case XUN_EVENT_RECV_TIMEOUT:                    // Data was received but stopped for 4 character periods.
      case XUN_EVENT_RECV_DATA:                       // Data has been received.
      {
         // Listen for command on UART
         n = XUartNs550_Recv(&theCtrl->theUart, theCtrl->serial_data.rxBuffer, sizeof(theCtrl->serial_data.rxBuffer));

         // CR_WARNING for some reason, n is always 0! thus we use EventData, which contains the actual number of bytes received
         n = EventData;

         if (CBB_Pushn(&theCtrl->responses, n, theCtrl->serial_data.rxBuffer) != IRC_SUCCESS)
         {
            SL_ERR("Unable to push RX data in the circular buffer.");
         }
         break;
      }

      case XUN_EVENT_RECV_ERROR:                      // Data was received with an error.
      {
         SL_INF("XUN_EVENT_RECV_ERROR");
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
         SL_INF("XUN_EVENT_MODEM");
         break;
      }

      default:
      {
         SL_ERR("Unknown UART event %d", Event);
      }
   }
}

/*
*   @brief Sightline protocol state machine
*
*   @param aCtrl : a pointer to slCtrl_t structure
*
*   @return void
*/
void SightLine_ProtocolHandler_SM(slCtrl_t* aCtrl)
{
   uint32_t firstRegister = 0;
   slParsingState_t state = aCtrl->slParsingState;
   unsigned char byte;

   if(flashSettings.AutofocusModuleType != AMT_SightlineSLA1500)
   {
      return;
   }

      if(!aCtrl->serial_data.txBusy)
      {
         if(aCtrl->serial_data.txDataCount > 0)
         {
            aCtrl->serial_data.txBusy = 1;
            XUartNs550_Send(&aCtrl->theUart, aCtrl->serial_data.txBuffer, aCtrl->serial_data.txDataCount);
         }

      }

      // deactivate uart interruptions
      firstRegister = XUartNs550_ReadReg(aCtrl->theUart.BaseAddress, XUN_IER_OFFSET);
      XUartNs550_WriteReg(aCtrl->theUart.BaseAddress, XUN_IER_OFFSET, 0);

      if(aCtrl->parsingDone<1)               // if we don't expect any response so flush the buffer
      {
         CBB_Flush(&aCtrl->responses);
      }

      while (CBB_Pop(&aCtrl->responses, &byte) == IRC_SUCCESS)
      {
            switch(state)
            {
               case sync1:
               default:
               {
                  if(byte == 0x51)
                  {
                     state = sync2;
                  }
                  SL_PRINTF("sync1\n");
                  break;
               }

               case sync2:
               {
                  if(byte == 0xAC)
                  {
                     state = dataLength1;
                  }
                  SL_PRINTF("sync2\n");
                  break;
               }

               case dataLength1:
               {
                  aCtrl->lastResponseData.dataLength = byte;
                  if(byte < 128)
                  {
                     state = commandID;
                     SL_PRINTF("datalength1:\n");
                  }
                  else
                  {
                     state = dataLength2;
                  }
                  break;
               }

               case dataLength2:
               {
                  uint8_t temp = aCtrl->lastResponseData.dataLength;
                  aCtrl->lastResponseData.dataLength = (byte<<7) | (temp & ~0x80);
                  state = commandID;
                  SL_PRINTF("dataLength2\n");
                  break;
               }

               case commandID:
               {
                  aCtrl->lastResponseData.type = byte;
                  uint8_t ind = aCtrl->lastResponseData.count;
                  aCtrl->lastResponseData.dataBuf[ind] = byte;
                  ind += 1;
                  if(byte == 0x40)
                  {
                     state = sync1;
                     aCtrl->parsingDone -= 1;                     // board is ready !
                  }
                  else
                  {
                     aCtrl->lastResponseData.count = ind;
                     state = dataState;
                  }
                  SL_PRINTF("commandID\n");
                  break;
               }

               case dataState:
               {
                  uint8_t ind = aCtrl->lastResponseData.count;
                  aCtrl->lastResponseData.dataBuf[ind] = byte;
                  ind += 1;
                  if(ind > (aCtrl->lastResponseData.dataLength-2))
                  {
                     state = checksum;
                  }
                  aCtrl->lastResponseData.count = ind;
                  break;
               }

               case checksum:
               {
                  if(byte == calculChecksum(aCtrl))
                  {
                     switch(aCtrl->lastResponseData.type)
                     {
                           case 0x55:        // focus stats
                           {
                              float temp = ( (float)(aCtrl->lastResponseData.dataBuf[5])*256.0*256.0*256.0
                                          + (float)(aCtrl->lastResponseData.dataBuf[4])*256.0*256.0
                                          + (float)(aCtrl->lastResponseData.dataBuf[3])*256.0
                                          + (float)(aCtrl->lastResponseData.dataBuf[2]) );
                              aCtrl->currentMetricData = (float)( temp /256.0 );
                              break;
                           }

                           case 0x6F:        // Lens param
                           {
                              break;
                           }

                           default:
                           {
                              SL_INF("We dont process that commandID at this point");
                           }
                     }
                     aCtrl->parsingDone -= 1;

                  }
                  else
                  {
                     // We have to go back in the buffer and look for a sync1 char
                     // or we skip this one
                     SL_INF("checksum does not matched:\n");
                  }
                  SL_PRINTF("checksum:\n");
                  aCtrl->lastResponseData.count = 0;
                  state = sync1;
                  break;
               }
            }
            SL_PRINTF("byte : %x\n", byte);

      }
      aCtrl->slParsingState = state;

      // Reactivate UART interrupt
      XUartNs550_WriteReg(aCtrl->theUart.BaseAddress, XUN_IER_OFFSET, firstRegister);
}

/*
*   @brief Calculate checksum using each value between length and checksum fields and a look up table
*
*   @param aResponse :  data struct
*
*   @return result
*/
uint8_t calculChecksum(slCtrl_t* aCtrl)
{
   uint8_t result = 0x01;
   uint8_t i, temp;

   for(i=0; i<aCtrl->lastResponseData.count; i++)
   {
      temp = result ^ aCtrl->lastResponseData.dataBuf[i];
      result = crc8_Table[temp];
   }

   return result;
}

/*
*   @brief Set the reporting rate of Command and Control Protocol
*
*   @param aCtrl        :  a pointer to the slCtrl_t struct
*   @param aFrameRate   :  by number of frames
*   @param aLsbFlags    :
*   @param aMsbFlags    :
*
*   @return success or failure
*/
bool setCoordReportMode(slCtrl_t* aCtrl, uint8_t aFrameRate, uint8_t aLsbFlags, uint8_t aMsbFlags)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;         // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;         // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0x5;          // datalength
   uint8_t i = ind;
   aCtrl->serial_data.txBuffer[ind++] = 0x0B;         // command ID (type)
   aCtrl->serial_data.txBuffer[ind++] = aFrameRate;   // frame period mode (1 = every frame)
   aCtrl->serial_data.txBuffer[ind++] = aLsbFlags;    // Flags LSB (0x80 for focus stats)
   aCtrl->serial_data.txBuffer[ind++] = aMsbFlags;    // Flags MSB (0 for nothing)

   uint8_t chksum = 0x01;
   uint8_t temp;
   while(i < ind)
   {
      temp = chksum ^ aCtrl->serial_data.txBuffer[i];
      chksum = crc8_Table[temp];
      i++;
   }

   aCtrl->serial_data.txBuffer[ind++] = chksum;
   aCtrl->serial_data.txDataCount += 8;
   return true;
}

/*
*   @brief Set the reporting rate of Command and Control Protocol
*
*   @param aCtrl           :  a pointer to the slCtrl_t struct
*   @param aMetricRegion   :  Metric region size % of screen (half of the real value)
*
*   @return success or failure
*/
bool setLensParams(slCtrl_t* aCtrl, uint8_t aMetricRegion)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t roi = aMetricRegion * 2;
   if(roi>100)
   {
      roi = 100;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   uint8_t i = ind;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;            // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;            // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0xB;             // datalength
   aCtrl->serial_data.txBuffer[ind++] = 0x6E;            // command ID (type)
   aCtrl->serial_data.txBuffer[ind++] = 00;              // Lens type (0 = none)
   aCtrl->serial_data.txBuffer[ind++] = roi;             // %
   aCtrl->serial_data.txBuffer[ind++] = 01;              // Zoom Track focus disabled
   aCtrl->serial_data.txBuffer[ind++] = 01;              // Autofocus method : 1 = seek
   aCtrl->serial_data.txBuffer[ind++] = 64;              // Autofocus rate : 100 = default speed of motion
   aCtrl->serial_data.txBuffer[ind++] = 00;              // Autofocus change persent 40(default) = 4%
   aCtrl->serial_data.txBuffer[ind++] = 00;              // zoom speed (0 = default)
   aCtrl->serial_data.txBuffer[ind++] = 00;              // focus speed (0 = default)
   aCtrl->serial_data.txBuffer[ind++] = 00;              // ?!

   int8_t chksum = 0x01;
   while(i < ind)
   {
      chksum = crc8_Table[chksum ^ aCtrl->serial_data.txBuffer[i]];
      i++;
   }

   aCtrl->serial_data.txBuffer[ind++] = chksum;
   aCtrl->serial_data.txDataCount += 15;
   metricRegion = aMetricRegion;
   return true;
}

/*
*   @brief Get the
*
*   @param aCtrl           :  a pointer to the slCtrl_t struct
*   @param aSetterID        :  corresponding setter command type ID
*
*   @return success or failure
*/
bool getParameter(slCtrl_t* aCtrl, uint8_t aSetterID)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;            // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;            // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0x03;            // datalength
   uint8_t i = ind;
   aCtrl->serial_data.txBuffer[ind++] = 0x28;            // command id
   aCtrl->serial_data.txBuffer[ind++] = aSetterID;

   uint8_t chksum = 0x01;
   uint8_t test;
   while(i < ind)
   {
      test = chksum ^ aCtrl->serial_data.txBuffer[i];
      chksum = crc8_Table[test];
      i++;
   }

   aCtrl->serial_data.txBuffer[ind++] = chksum;
   aCtrl->serial_data.txDataCount += 6;
   return true;
}

/*
*   @brief Configure video input for digital camera interface
*
*   @param aCtrl           :  a pointer to the slCtrl_t struct
*   @param aCamTypr        :
*   @param aVideoFlags     :
*   @param aImageHeight    :
*   @param aImageWidth     :
*   @param aBitDepth       :
*   @param aVertFrontPorch :
*   @param aHoriFrontPorch :
*   @param aDigitalFlags   :
*
*   @return success or failure
*/
/*bool setAcqParam(    slCtrl_t* aCtrl,
                     uint8_t aCamIndex,
                     uint8_t aCamType,
                     uint16_t aImageHeight,
                     uint16_t aImageWidth,
                     uint8_t aBitDepth,
                     uint16_t aVertFrontPorch,
                     uint16_t aHoriFrontPorch,
                     uint16_t aDigitalFlags)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t byte0 = aImageHeight % 256;
   uint8_t byte1 = aImageHeight / 256;
   uint8_t byte2 = aImageWidth % 256;
   uint8_t byte3 = aImageWidth / 256;
   uint8_t byte4 = aVertFrontPorch % 256;
   uint8_t byte5 = aVertFrontPorch / 256;
   uint8_t byte6 = aHoriFrontPorch % 256;
   uint8_t byte7 = aHoriFrontPorch / 256;
   uint8_t byte8 = aDigitalFlags % 256;
   uint8_t byte9 = aDigitalFlags / 256;

   uint8_t ind = aCtrl->serial_data.txDataCount;
   uint8_t i = ind;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;         // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;         // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0x19;         // datalength
   aCtrl->serial_data.txBuffer[ind++] = 0x37;         // command ID (type)
   aCtrl->serial_data.txBuffer[ind++] = aCamIndex;    // cam index : digital
   aCtrl->serial_data.txBuffer[ind++] = aCamType;     // cam type
   aCtrl->serial_data.txBuffer[ind++] = byte0;        // image height LSB
   aCtrl->serial_data.txBuffer[ind++] = byte1;        // image height MSB
   aCtrl->serial_data.txBuffer[ind++] = byte2;        // image width LSB
   aCtrl->serial_data.txBuffer[ind++] = byte3;        // image width MSB
   aCtrl->serial_data.txBuffer[ind++] = aBitDepth;    // image width MSB
   aCtrl->serial_data.txBuffer[ind++] = byte4;        // vertical front porch LSB
   aCtrl->serial_data.txBuffer[ind++] = byte5;        // vertical front porch MSB
   aCtrl->serial_data.txBuffer[ind++] = byte6;        // horizontal front porch LSB
   aCtrl->serial_data.txBuffer[ind++] = byte7;        // horizontal front porch MSB
   aCtrl->serial_data.txBuffer[ind++] = byte8;        // Digital video flags LSB
   aCtrl->serial_data.txBuffer[ind++] = byte9;        // Digital video flags MSB
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;

   int8_t chksum = 0x01;
   while(i < ind)
   {
      chksum = crc8_Table[chksum ^ aCtrl->serial_data.txBuffer[i]];
      i++;
   }

   aCtrl->serial_data.txBuffer[ind++] = chksum;
   aCtrl->serial_data.txDataCount += 26;
   aCtrl->parsingDone += 1;
   return true;
}*/

/*
*   @brief Configure a serial communication port (baudrate to parity setup need a reboot)
*
*   @param aCtrl           :  a pointer to the slCtrl_t struct
*   @param aPortID         :  0 for serial 0, 1 for serial 1 and 4 for serial 2
*   @param aBaudRate       :  3 for 57600 (default), 4 for 115200, ...
*   @param aDataBits       :  number
*   @param aStopBit        :  bool
*   @param aParity         :  bool
*   @param aMaxLength      : default 127 bytes
*   @param aMaxTimout      : in ms (default 100)
*   @param aProtocol       : 0 for SLA (for telemetry), ...
*   @param aAttNav         : a network socket for listening
*
*   @return success or failure
*/
/*bool setSerialPassThrought(slCtrl_t* aCtrl,  uint8_t aPortID,
                                             uint8_t aBaudRate,
                                             uint8_t aDataBits,
                                             uint8_t aStopBit,
                                             uint8_t aParity,
                                             uint8_t aMaxLength,
                                             uint8_t aMaxTimout,
                                             uint8_t aProtocol,
                                             uint16_t aAttNav)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   uint8_t i = ind;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;            // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;            // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0x14;            // datalength
   aCtrl->serial_data.txBuffer[ind++] = 0x3E;            // command ID (type)
   aCtrl->serial_data.txBuffer[ind++] = aPortID;         //
   aCtrl->serial_data.txBuffer[ind++] = aBaudRate;       //
   aCtrl->serial_data.txBuffer[ind++] = aDataBits;       //
   aCtrl->serial_data.txBuffer[ind++] = aStopBit;        //
   aCtrl->serial_data.txBuffer[ind++] = aParity;         //
   aCtrl->serial_data.txBuffer[ind++] = aMaxLength;      //
   aCtrl->serial_data.txBuffer[ind++] = aMaxTimout;      //
   aCtrl->serial_data.txBuffer[ind++] = aProtocol;       //

   aCtrl->serial_data.txBuffer[ind++] = 0xFF;            // Ethernet in port number LSB
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet in port number MSB
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet out IP addr
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet out IP addr
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet out IP addr
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet out IP addr
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet output port
   aCtrl->serial_data.txBuffer[ind++] = 0xFF;           // Ethernet output port

   uint8_t byte0 = aAttNav % 256;
   uint8_t byte1 = aAttNav / 256;
   aCtrl->serial_data.txBuffer[ind++] = byte0;           // port number LSB
   aCtrl->serial_data.txBuffer[ind++] = byte1;           // port number MSB

   int8_t chksum = 0x01;
   while(i < ind)
   {
      chksum = crc8_Table[chksum ^ aCtrl->serial_data.txBuffer[i]];
      i++;
   }

   aCtrl->serial_data.txBuffer[ind++] = chksum;
   aCtrl->serial_data.txDataCount += 23;
   aCtrl->parsingDone += 1;
   return true;
}*/

/*
*   @brief Get the reporting rate of Command and Control Protocol
*
*   @param aCtrl           :  a pointer to the slCtrl_t struct
*   @param aPortID         :  defined for 7 ports : 0 for serial0, 1 for serial2, 2 for Ethernet, ...
*
*   @return success or failure
*/
/*bool getPortConfig(slCtrl_t* aCtrl, uint8_t aPortID)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   uint8_t i = ind;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;            // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;            // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0x3;             // datalength
   aCtrl->serial_data.txBuffer[ind++] = 0x3F;            // command ID (type)
   aCtrl->serial_data.txBuffer[ind++] = aPortID;         //

   int8_t chksum = 0x01;
   while(i < ind)
   {
      chksum = crc8_Table[chksum ^ aCtrl->serial_data.txBuffer[i]];
      i++;
   }
   SL_PRINTF("checksum : %x\n", checksum);
   aCtrl->serial_data.txBuffer[ind++] = 0xF1;   //chksum;
   aCtrl->serial_data.txDataCount += 6;
   aCtrl->parsingDone += 1;
   return true;
}*/

/*
*   @brief Set the algo type for the metric processing
*
*   @param aCtrl           :  a pointer to the slCtrl_t struct
*   @param anAlgoID        :  ID : 0x05 for Brenner, 0x04 for Sobel, 0x03 for Laplacien
*
*   @return success or failure
*/
/*bool setMetricAlgo(slCtrl_t* aCtrl, uint8_t anAlgoID)
{
   if(aCtrl->serial_data.txBusy)
   {
      return false;
   }

   uint8_t ind = aCtrl->serial_data.txDataCount;
   aCtrl->serial_data.txBuffer[ind++] = 0x51;            // sync char1
   aCtrl->serial_data.txBuffer[ind++] = 0xAC;            // sync char2
   aCtrl->serial_data.txBuffer[ind++] = 0x1A;            // datalength
   aCtrl->serial_data.txBuffer[ind++] = 0x92;            // command ID
   aCtrl->serial_data.txBuffer[ind++] = 0x03;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = anAlgoID;        // 0x05 for Brenner, 0x04 for Sobel, 0x03 for Laplacien
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   aCtrl->serial_data.txBuffer[ind++] = 0x00;
   switch(anAlgoID)
   {
      case 0x05:
      {
         aCtrl->serial_data.txBuffer[ind++] = 0xC9;  //chksum;
         break;
      }

      case 0x04:
      {
         aCtrl->serial_data.txBuffer[ind++] = 0x8A;  //chksum;
         break;
      }

      case 0x03:
      {
         aCtrl->serial_data.txBuffer[ind++] = 0x5A;  //chksum;
         break;
      }

      default:
      {
         SL_ERR("Wrong algo ID\n");
      }
   }
   aCtrl->serial_data.txDataCount += 29;
   aCtrl->parsingDone += 1;
   return true;
}*/
