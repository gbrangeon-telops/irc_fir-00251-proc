/*
 * @file RpOpticalProtocol.h
 *
 * interface driver implementation.
 *
 * $Rev: 23147 $
 * $Author: elarouche $ ecloutier
 * $Date: 2019-04-01 14:32:59 -0400 (lun., 01 avr. 2019) $   4 décembre 2017
 * $Id: RpOpticalProtocol.h 23147 2019-04-01 18:32:59Z elarouche $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/Zoom/Driver/RpOpticalProtocol.h $ .../FIR-00251-Proc/src/Zoom/RpOpticalProtocol.h
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef RP_OPTICAL_PROTOCOL_H_
#define RP_OPTICAL_PROTOCOL_H_

#include "xuartns550.h"
#include "GC_Registers.h"
#include "CircularByteBuffer.h"
#include "IRC_status.h"
#include "verbose.h"
#include "Xintc.h"
#include "CircularUART.h"

#include <stdbool.h>
#include <stdio.h>


#ifndef LF_CHAR
   #define LF_CHAR (char)10
#endif

#define  FOCUS_NEAR  (uint8_t)0x0A
#define  FOCUS_FAR   (uint8_t)0x0B
#define  FOV1        (uint8_t)0x0E
#define  FOV2        (uint8_t)0x0F
#define  FOV3        (uint8_t)0x10
#define  FOV4        (uint8_t)0x11
#define  FOV5        (uint8_t)0x12
#define  PARAM       (uint8_t)0x02
#define  SPEED       (uint8_t)0x1F
#define  ADDRESS     (uint8_t)0x1C
#define  WRITE       (uint8_t)0x1D
#define  READ        (uint8_t)0x1E
#define  GOTOPOS     (uint8_t)0x0D
#define  GOTOZOOMPOS (uint8_t)0x47
#define  GOFASTFOC   (uint8_t)0x48
#define  FNEAR       (uint8_t)0x21
#define  FFAR        (uint8_t)0x22
#define  BIT         (uint8_t)0x0C
#define  HOURS       (uint8_t)0x27
#define  SERIAL      (uint8_t)0x26
#define  VERSION     (uint8_t)0x25
#define  TEMPERATURE (uint8_t)0x45
#define  ENDOFACTION (uint8_t)0x29

#define  RP_OPT_DEFAULT_BAULDRATE   (uint32_t)19200
#define  RP_OPT_DATA_BITS           (uint8_t)8
#define  RP_OPT_STOP_BITS           (uint8_t)1
#define  RP_OPT_PARITY              (char)'N'

#define  RP_OPT_TABLE_LEN           41

#define  ZF_LOOK_UP_TABLE_ADDR      0x0064

#define  ZOOM_CMD_LIMIT_POS         3000
#define  ZOOM_IN_SLOW_M_1           1.2F
#define  ZOOM_IN_SLOW_B_1           287
#define  ZOOM_IN_FAST_M_1           1.6F
#define  ZOOM_IN_FAST_B_1           860
#define  ZOOM_OUT_SLOW_M_1          (1.0F / ZOOM_IN_SLOW_M_1)
#define  ZOOM_OUT_SLOW_B_1          -239
#define  ZOOM_OUT_FAST_M_1          (1.0F / ZOOM_IN_FAST_M_1)
#define  ZOOM_OUT_FAST_B_1          -538
#define  ZOOM_IN_SLOW_M_2           1.2F
#define  ZOOM_IN_SLOW_B_2           0
#define  ZOOM_IN_FAST_M_2           1.6F
#define  ZOOM_IN_FAST_B_2           0
#define  ZOOM_OUT_SLOW_M_2          (1.0F / ZOOM_IN_SLOW_M_2)
#define  ZOOM_OUT_SLOW_B_2          0
#define  ZOOM_OUT_FAST_M_2          (1.0F / ZOOM_IN_FAST_M_2)
#define  ZOOM_OUT_FAST_B_2          0

#define  FOCUS_ENCODER_MIN          250
#define  FOCUS_ENCODER_MAX          16750

#define  FOCUS_SLOW_STEP            75
#define  FOCUS_FAST_STEP            (5 * FOCUS_SLOW_STEP)

#ifdef RP_VERBOSE
   #define RP_OPT_PRINTF(fmt, ...)   FPGA_PRINTF("RP: " fmt, ##__VA_ARGS__)
#else
   #define RP_OPT_PRINTF(fmt, ...)   DUMMY_PRINTF("RP: " fmt, ##__VA_ARGS__)
#endif

#define RP_OPT_INF(fmt, ...)         FPGA_PRINTF("RP: Info: " fmt "\n", ##__VA_ARGS__)
#define RP_OPT_ERR(fmt, ...)         FPGA_PRINTF("RP: Error: " fmt "\n", ##__VA_ARGS__)

typedef enum
{
   init = 0,
   sync,
   getCom,
   getDataLength1,
   getDataLength2,
   getData,
   getBitResponse1,
   getBitResponse2,
   getParam1,
   getParam2,
   getTemperature1,
   getTemperature2,
   getTemperature3,
   reading,
   getAck,
   chksum
}rpParsingState_t;

typedef enum
{
   getZoom1 = 0,
   getZoom2,
   getFocus1,
   getFocus2,
   getTemp,
   getFov
}rpDataState_t;

// datatype structure for a RS232 channel
typedef struct
{
   uint8_t rxBuffer[48];
   uint8_t txBuffer[96];
   uint8_t rxDataCount;
   uint8_t txDataCount;
   uint8_t txBusy;                        // 1 for yes
} serial_ch_t;

typedef struct                             // regular response
{
   uint8_t           command;
   uint16_t          dataLength;
   uint16_t          zoomEncValue;
   uint16_t          focusEncValue;
   int8_t            temperature;         // +- 127
   uint8_t           ack;                 // 0xFE for success, 0xFF for failed operation
   uint8_t           checksum;
} genResponse_t;

typedef struct
{
   serial_ch_t       serial_data;
   uint8_t           parsingDone;
   uint8_t           initDone;
   bool              readingDone;
   uint16_t          tableLength;
   rpParsingState_t  rpParsingState;
   rpDataState_t     rpDataState;
   genResponse_t     lastResponseData;
   genResponse_t     currentResponseData;
   uint8_t           dataBuf[22];
   uint8_t           dataCount;
   uint8_t           builtInTest;         // Error flags from a Bit Response
   circularUART_t    theUart;
   circByteBuffer_t  responses;
   uint8_t           rawBytes[64];        // raw bytes (circBuffer_t responses) received from the UART interrupt handler
}rpCtrl_t;

/**
 * lensTable data type
 */
typedef struct
{
   uint16_t   zoom[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp1[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp2[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp3[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp4[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp5[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp6[RP_OPT_TABLE_LEN];
   uint16_t   focusAtTemp7[RP_OPT_TABLE_LEN];
   int16_t    deltaFocusMin[RP_OPT_TABLE_LEN];
   int16_t    deltaFocusMax[RP_OPT_TABLE_LEN];
   uint16_t   focalLength[RP_OPT_TABLE_LEN];
}lensTable_t;

/**
 * lensTable defines
 */
#define LENS_FOV1_IDX   0
#define LENS_FOV2_IDX   10
#define LENS_FOV3_IDX   20
#define LENS_FOV4_IDX   30
#define LENS_FOV5_IDX   40

#define FOCUS_TEMP_1    -25.0F
#define FOCUS_TEMP_2    -10.0F
#define FOCUS_TEMP_3      5.0F
#define FOCUS_TEMP_4     20.0F
#define FOCUS_TEMP_5     35.0F
#define FOCUS_TEMP_6     50.0F
#define FOCUS_TEMP_7     65.0F


/**
 * LensFOV enumeration values
 */
enum LensFOVEnum {
   LensFOV1 = 0,
   LensFOV2 = 1,
   LensFOV3 = 2,
   LensFOV4 = 3,
   LensFOV5 = 4,
   LensFOV_Undefined = 0xFF
};

/**
 * LensFOV enumeration values data type
 */
typedef enum LensFOVEnum LensFOV_t;


/**
 * ZoomCommand enumeration values
 */
enum ZoomCommandEnum {
   ZoomInFast = 0,
   ZoomInSlow = 1,
   ZoomOutFast = 2,
   ZoomOutSlow = 3
};

/**
 * ZoomCommand enumeration values data type
 */
typedef enum ZoomCommandEnum ZoomCommand_t;


XStatus RPOpt_init(gcRegistersData_t* pGCRegs, rpCtrl_t* aCtrl, uint16_t uartDeviceId, XIntc* intc, uint16_t uartIntrId);

void RPopt_ProtocolHandler_SM(rpCtrl_t* aCtrl, gcRegistersData_t* pGCRegs);

void RP_OPT_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData);

bool goToFOV1(rpCtrl_t* aCtrl);

bool goToFOV2(rpCtrl_t* aCtrl);

bool goToFOV3(rpCtrl_t* aCtrl);

bool goToFOV4(rpCtrl_t* aCtrl);

bool goToFOV5(rpCtrl_t* aCtrl);

bool reportParameters(rpCtrl_t* aCtrl);

bool setSpeed(rpCtrl_t* aCtrl, uint8_t aZoomSpeed, uint8_t aFocusSpeed);

bool goFastToFocus(rpCtrl_t* aCtrl, uint16_t aFocusVal);

bool setAddress(rpCtrl_t* aCtrl, uint16_t anAddress);

bool writeData(rpCtrl_t* aCtrl, uint8_t aNumber, uint8_t* aBuf);

bool writeRpTables(rpCtrl_t* aCtrl, uint8_t aLine);

bool readData(rpCtrl_t* aCtrl, uint8_t aNumber);

bool goManuallyToPos(rpCtrl_t* aCtrl, uint16_t aZoomEncoder, uint16_t aFocusEncoder);

bool goManuallyToZoomPos(rpCtrl_t* aCtrl, uint16_t aZoomEncoder);

bool goContFocusNear(rpCtrl_t* aCtrl);

bool goContFocusFar(rpCtrl_t* aCtrl);

bool builtInTest(rpCtrl_t* aCtrl);

bool refreshTemperature(rpCtrl_t* aCtrl);

LensFOV_t RPOpt_ConvertUserFOVtoLensFOV(FOVPositionSetpoint_t UserFOV);

uint16_t RPOpt_ConvertLensFOVtoEncoder(LensFOV_t LensFOV);

FOVPositionSetpoint_t RPOpt_ConvertRawPosToFOVPos(int32_t rawPosition);

bool RPOpt_SetLensFOV(rpCtrl_t* aCtrl, LensFOV_t LensFOV);

int32_t RPOpt_CalcZoomNewSetpoint(uint16_t currentPos, ZoomCommand_t cmd);

void RPOpt_UpdateRegisters(rpCtrl_t* aCtrl, gcRegistersData_t* pGCRegs);

uint16_t RPOpt_GetAthermFocus(rpCtrl_t* aCtrl, uint32_t idx);

void RPOpt_UpdateLensTableFromFlash();

void RPOpt_CalcFOVPositionLimits(gcRegistersData_t* pGCRegs);

#endif /* RP_OPTICAL_PROTOCOL_H_ */
