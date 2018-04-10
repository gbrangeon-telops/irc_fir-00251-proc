/*
 * SightlineSLAProtocol.h
 *
 *  Created on: 2017-12-07
 *      Author: ecloutier
 */

#ifndef SIGHTLINESLAPROTOCOL_H_
#define SIGHTLINESLAPROTOCOL_H_

#include "xuartns550.h"
#include "GC_Registers.h"
#include "CircularByteBuffer.h"
#include "IRC_status.h"
#include "verbose.h"
#include "Xintc.h"

#include <stdbool.h>
#include <stdio.h>

#define  SL_DEFAULT_BAULDRATE   (uint32_t)57600
#define  SL_DATA_BITS           (uint8_t)8
#define  SL_STOP_BITS           (uint8_t)1
#define  SL_PARITY              (char)'N'

#ifdef SL_VERBOSE
   #define SL_PRINTF(fmt, ...)   FPGA_PRINTF("SL: " fmt, ##__VA_ARGS__)
#else
   #define SL_PRINTF(fmt, ...)   DUMMY_PRINTF("SL: " fmt, ##__VA_ARGS__)
#endif

#define SL_INF(fmt, ...)         SL_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define SL_ERR(fmt, ...)         FPGA_PRINTF("SL: Error: " fmt "\n", ##__VA_ARGS__)

typedef enum
{
   sync1 = 0,
   sync2,
   dataLength1,
   dataLength2,
   commandID,
   dataState,
   checksum
}slParsingState_t;

// datatype structure for a RS232 channel
typedef struct
{
   uint8_t rxBuffer[48];
   uint8_t txBuffer[48];
   uint8_t rxDataCount;
   uint8_t txDataCount;
   uint8_t txBusy;                        // 1 for yes
} serial_cha_t;

typedef struct
{
   uint16_t          dataLength;
   uint8_t           type;
   uint8_t           dataBuf[32];
   uint8_t           count;
} slResponse_t;

typedef struct
{
   serial_cha_t      serial_data;
   uint8_t           parsingDone;
   slParsingState_t  slParsingState;
   slResponse_t      lastResponseData;
   float             currentMetricData;
   XUartNs550        theUart;
   circByteBuffer_t  responses;
   uint8_t           rawBytes[64];        // raw bytes (circBuffer_t responses) received from the UART interrupt handler
}slCtrl_t;

XStatus SL_init(gcRegistersData_t* pGCRegs, slCtrl_t* aCtrl, uint16_t uartDeviceId, XIntc* intc, uint16_t uartIntrId);

void SL_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData);

uint8_t calculChecksum(slCtrl_t* aCtrl);

void SightLine_ProtocolHandler_SM(slCtrl_t* aCtrl);

bool setCoordReportMode(slCtrl_t* aCtrl, uint8_t aFrameRate, uint8_t aLsbFlags, uint8_t aMsbFlags);

bool setLensParams(slCtrl_t* aCtrl, uint8_t aMetricRegion);

/*bool setAcqParam( slCtrl_t* aCtrl,  uint8_t aCamType,
                                    uint8_t aVideoFlags,
                                    uint16_t aImageHeight,
                                    uint16_t aImageWidth,
                                    uint8_t aBitDepth,
                                    uint16_t aVertFrontPorch,
                                    uint16_t aHoriFrontPorch,
                                    uint16_t aDigitalFlags);*/

/*bool setSerialPassThrought(slCtrl_t* aCtrl,  uint8_t aPortID,
                                             uint8_t aBaudRate,
                                             uint8_t aDataBits,
                                             uint8_t aStopBit,
                                             uint8_t  aParity,
                                             uint8_t aMaxLength,
                                             uint8_t aMaxTimout,
                                             uint8_t aProtocol,
                                             uint16_t aAttNav);*/

//bool getPortConfig(slCtrl_t* aCtrl, uint8_t aPortID);

bool getParameter(slCtrl_t* aCtrl, uint8_t aSetterID);

//bool setMetricAlgo(slCtrl_t* aCtrl, uint8_t anAlgoID);

#endif /* SIGHTLINESLAPROTOCOL_H_ */
