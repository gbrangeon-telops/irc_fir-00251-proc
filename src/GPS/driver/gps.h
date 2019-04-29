/**
 * @file gps.h
 * GPS module header.
 *
 * This file declares the GPS module.
 *
 * $Rev: 18503 $
 * $Author: dalain $
 * $Date: 2016-04-08 14:46:14 -0400 (ven., 08 avr. 2016) $
 * $Id: gps.h 18503 2016-04-08 18:46:14Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/GPS/driver/gps.h $
 *
 * (c) Copyright 2015 Telops Inc.
 */

#ifndef GPS_H
#define GPS_H

#include "GC_Registers.h"
#include "CircularUART.h"
#include "xintc.h"
#include "verbose.h"
#include "IRC_Status.h"
#include <time.h>
#include <stdint.h>

#ifdef GPS_VERBOSE
   #define GPS_PRINTF(fmt, ...)  FPGA_PRINTF("GPS: " fmt, ##__VA_ARGS__)
#else
   #define GPS_PRINTF(fmt, ...)  DUMMY_PRINTF("GPS: " fmt, ##__VA_ARGS__)
#endif

#define GPS_ERR(fmt, ...)        FPGA_PRINTF("GPS: Error: " fmt "\n", ##__VA_ARGS__)
#define GPS_INF(fmt, ...)        FPGA_PRINTF("GPS: Info: " fmt "\n", ##__VA_ARGS__)
#define GPS_DBG(fmt, ...)        GPS_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

// This only works if you are sure you have an upper case hex digit
#define HEXTOBIN(ch) ((ch <= '9') ? ch - '0' : ch - ('A' - 10))

// Timeout delay for GPS to be present, expressed in microseconds 
#define GPS_COMM_TIMEOUT_DELAY_US 1500000
#define GPS_NMEA_TIMEOUT_DELAY_US 2000000

// Maximun number of field that NMEA frame can have
#define NBR_OF_FIELD 32

// Maximun number of char a NMEA field can have
#define NBR_OF_CHAR	32

// GPS error flags definition
#define GPS_BADCKSUM    0x1
#define GPS_NOPPS       0x2
#define GPS_UARTOVRFLW  0x4

// PPS missing count to trigg a PPS time out
#define GPS_PPS_TIMEOUT 6 

typedef enum
{
   GPS_NOT_DONE = 0, /**< NMEA Not done gathering a complete sentence */
   GPS_GPRMC,        /**< NMEA GPRMC sentence header detected */
   GPS_GPGGA,        /**< NMEA GPGGA sentence header detected */
   GPS_NMEA_OTHERS   /**< Other NMEA sentence header detected */
} GPS_NMEA_codes_t;

typedef enum
{
   GPS_NOTDETECTED = 0,
   GPS_PRESENT,
   GPS_GOOD_COMM,
   GPS_BAD_COMM,
   GPS_LOST
} GPS_status_t;

typedef struct
{					   
   uint32_t degrees;     
   uint32_t minutes;
   uint32_t frac_minutes;
   uint32_t frac_digits;
   char     Hemisphere; // ASCII letter N, S, E or W
} NMEA_Coordinate;

typedef struct
{					   
   circularUART_t uart;
   circByteBuffer_t rxCircDataBuffer;
   uint8_t index;       // Store the current state machine state
   uint8_t field;   // NMEA field... between commas
   uint8_t CharPtr; // pointer to characters   
   uint8_t checksumVal; // The checksum that is calculated as each byte is received
   uint8_t checksum[3];    // received checksum
   uint8_t dataArray[NBR_OF_FIELD][NBR_OF_CHAR];     
   char Gps_Fix;
   NMEA_Coordinate Latitude;
   NMEA_Coordinate Longitude;    
   char    ModeIndicator;
   uint32_t Altitude;
   uint32_t Altitude_frac;
   uint64_t CommTic;
   uint64_t NmeaTic;
   uint64_t LowPriorityTaskTic;
   struct tm rTClock;
   uint8_t ErrFlags;
   GPS_status_t GpsStatus;   
   uint8_t MissingPps_cnt;
   uint8_t showNMEA;
} t_GPS;


IRC_Status_t GPS_Init(t_GPS *GPS_Data,
      uint16_t uartDeviceId,
      XIntc *intc,
      uint16_t uartIntrId,
      uint8_t *rxCircBuffer,
      uint16_t rxCircBufferSize);
void GPS_Process(t_GPS *GPS_Data);

#endif // GPS_H
