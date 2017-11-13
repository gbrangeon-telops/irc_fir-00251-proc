/**
 * @file ProcStartupTest_TimeSync.c
 * Processing FPGA Startup Temporal Synchronization tests implementation
 *
 * This file implements the Startup Temporal synchronization tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_TimeSync.h"
#include "ProcStartupTest_SSM.h"

#include "GC_Registers.h"
#include "GC_Callback.h"
#include "irigb.h"
#include "trig_gen.h"
#include "xuartns550.h"

#define TEST_UART_TIMEOUT_US                             5  * ONE_SECOND_US
#define GPS_TEST_NUM_NMEA_STRINGS                        2
#define GPS_TEST_TIMEOUT                                 3 * ONE_SECOND_US
#define IRIG_TEST_TIMEOUT                                10 * ONE_SECOND_US
#define IRIG_SYNC_MAX_RETRY                              3
#define TEST_UART_BUFFER_SIZE                            128

extern t_Trig gTrig;
extern t_GPS Gps_struct;


struct GPRMCMsgStruct {
   uint32_t hour;
   uint32_t min;
   uint32_t sec;
   uint32_t day;
   uint32_t month;
   uint32_t year;
   char     fix;
   uint32_t lat_deg;
   uint32_t lat_min;
   uint32_t lat_fmin;
   char     lat_hem;
   uint32_t long_deg;
   uint32_t long_min;
   uint32_t long_fmin;
   char     long_hem;
   char     mode;
};

typedef struct GPRMCMsgStruct GPRMC_msg_t;

/*
 * Compares a GPRMC message structure to the data contained within the GPS structure
 *
 * @param GPRMC is a pointer to the GPRMC structure to be compared
 * @param GPS is a pointer to the GPS structure to be compared
 *
 * @return TRUE if both sets of data are identical
 * @return FALSE otherwise
 */
static bool cmp_GPRMC(const GPRMC_msg_t *GPRMC, const t_GPS *GPS) {

   return ((GPS->rTClock.tm_hour == GPRMC->hour) && (GPS->rTClock.tm_min == GPRMC->min) && (GPS->rTClock.tm_sec == GPRMC->sec) &&
           (GPS->rTClock.tm_mday == GPRMC->day) && (GPS->rTClock.tm_mon == GPRMC->month - 1) && (GPS->rTClock.tm_year == GPRMC->year) &&
           (GPS->Latitude.degrees == GPRMC->lat_deg) && (GPS->Latitude.minutes == GPRMC->lat_min) &&
           (GPS->Latitude.frac_minutes == GPRMC->lat_fmin) && (GPS->Latitude.Hemisphere == GPRMC->lat_hem) &&
           (GPS->Longitude.degrees == GPRMC->long_deg) && (GPS->Longitude.minutes == GPRMC->long_min) &&
           (GPS->Longitude.frac_minutes == GPRMC->long_fmin) && (GPS->Longitude.Hemisphere == GPRMC->long_hem) &&
           (GPS->ModeIndicator == GPRMC->mode) && (GPS->Gps_Fix == GPRMC->fix));
}

/*
 * Creates 2 NMEA GPRMC strings and sends them in loopback mode to the system GPS.
 * After decoding the NMEA strings, sets the internal clock at PPS, then reads back the
 * internal clock time and compares it against a test POSIX time value.
 *
 * @return IRC_SUCCESS if both time settings completed successfully.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_GPSSync(void) {

   bool testFailed = false;

   uint8_t NMEA_length[GPS_TEST_NUM_NMEA_STRINGS] = { 0 };
   char NMEA_strings[GPS_TEST_NUM_NMEA_STRINGS][TEST_UART_BUFFER_SIZE] = {{ 0 }};

   uint64_t POSIXTimeValue[GPS_TEST_NUM_NMEA_STRINGS] = { 0 };
   t_PosixTime RTC;
   int i = 0;

   // Variables for readable time output from POSIX timestamp
   char printfBuf[80];
   struct tm *curTimeAndDate;
   time_t curPOSIX;

   uint64_t GPSTimer;
   uint64_t TrigTimer;

   AutoTest_SaveGCRegisters();

   // Trigger configuration for test purposes
   GC_SetTriggerSelector(TS_AcquisitionStart);
   GC_SetTriggerMode(TM_On);

   gcRegsData.TriggerSource = TS_Software;
   GC_TriggerSourceCallback(GCCP_AFTER, GCCA_WRITE);

   gcRegsData.AcquisitionFrameRateMaxFG = 1000;
   GC_AcquisitionFrameRateMaxFGCallback(GCCP_AFTER, GCCA_WRITE);

   // Reset time source flags
   gcRegsData.TimeSource = TS_GPS;
   GC_TimeSourceCallback(GCCP_AFTER, GCCA_WRITE);

   TRIG_PpsSrcSelect(TS_GPS, &gTrig);
   Gps_struct.GpsStatus = GPS_NOTDETECTED;

   //ATR_PRINTF("Connect the GPS Test Harness to J3 and J4.\nPress ENTER to continue...\n\n");  --> EC
   ATR_PRINTF("Connect the GPS Test Harness to J17 and J9.\nPress ENTER to continue...\n\n");
   AutoTest_getUserNULL();

   GC_SetAcquisitionStop(0);
   GC_SetAcquisitionStart(1);

   while (!GC_AcquisitionStarted) {
      AutoTest_RunMinimalStateMachines();
   }

   const char* const GPRMC_str1 = "$GPRMC,175138,A,4147.72819,N,18211.33829,E,,,110316,,,D*73\r";
   const GPRMC_msg_t GPRMC_msg1 = { 17, 51, 38, 11, 3, 116, 'A', 41, 47, 72819, 'N', 182, 11, 33829, 'E', 'D' };
   NMEA_length[0]  = strlen(GPRMC_str1) + 1;
   POSIXTimeValue[0] = 1457718698;     // Value obtained using an online Epoch time converter
   snprintf(NMEA_strings[0], NMEA_length[0], GPRMC_str1);

   const char* const GPRMC_str2 = "$GPRMC,071349,R,2731.63824,S,29182.92873,W,,,240506,,,A*6A\r";
   const GPRMC_msg_t GPRMC_msg2 = { 7, 13, 49, 24, 5, 106, 'R', 27, 31, 63824, 'S', 291, 82, 92873, 'W', 'A' };
   NMEA_length[1] = strlen(GPRMC_str2) + 1;
   POSIXTimeValue[1] = 1148454829;     // Value obtained using an online Epoch time converter
   snprintf(NMEA_strings[1], NMEA_length[1], GPRMC_str2);

   for (i = 0; i < GPS_TEST_NUM_NMEA_STRINGS; i++)
   {

      if (i == 0) {
         ATR_INF("Setting clock time to Fri Mar 11 17:51:38 2016\nSending GPRMC string...\n");
      }

      if (i == 1) {
         ATR_INF("Setting clock time to Wed May 24 07:13:49 2006\nSending GPRMC string...\n");
      }

      XUartNs550_Send(&Gps_struct.uart.uart, (uint8_t *)NMEA_strings[i], NMEA_length[i]);
      GETTIME(&GPSTimer);

      while ((Gps_struct.rxCircDataBuffer.length < NMEA_length[i]) && (elapsed_time_us(GPSTimer) < GPS_TEST_TIMEOUT))
      {
         AutoTest_RunMinimalStateMachines();
      }

      if (elapsed_time_us(GPSTimer) > GPS_TEST_TIMEOUT) {
         ATR_ERR("GPS UART Timeout.");
         testFailed = true;

         // String has not been received, skip processing to next NMEA string
         continue;
      }

      // String has been received, move on with data processing
      GPS_Process_TEST(&Gps_struct);

      if (i == 0) {
         if (!cmp_GPRMC(&GPRMC_msg1, &Gps_struct)) {
            testFailed = true;
            ATR_ERR("First GPRMC string was not processed correctly.");
            continue;
         }
         else
         {
            ATR_PRINTF("First GPRMC string was processed correctly.");
         }
      }

      if (i == 1) {
         if (!cmp_GPRMC(&GPRMC_msg2, &Gps_struct)) {
            testFailed = true;
            ATR_ERR("Second GPRMC string was not processed correctly.");
            continue;
         }
         else
         {
            ATR_PRINTF("Second GPRMC string was processed correctly.");
         }
      }

      // Overwrite POSIX Time when PPS is received
      TRIG_SendTrigSoft(&gTrig, &gcRegsData);
      GETTIME(&TrigTimer);

      // We pause 100ms here to make sure the system has plenty of time to update internal clock
      while (elapsed_time_us(TrigTimer) < (0.1 * ONE_SECOND_US)) {
         AutoTest_RunMinimalStateMachines();
      }

      RTC = TRIG_GetRTC(&gTrig);

      if ((RTC.Seconds > POSIXTimeValue[i] + 2) || (RTC.Seconds < POSIXTimeValue[i]))
      {
         ATR_ERR("Incorrect POSIX Time reading: %d", RTC.Seconds);
         testFailed = true;
         continue;
      }
      else
      {
         // Convert POSIX time to readable "human" time
         curPOSIX = (time_t)RTC.Seconds;
         curTimeAndDate = localtime(&curPOSIX);
         strftime(printfBuf, sizeof(printfBuf), "%c", curTimeAndDate);
         ATR_PRINTF("Valid POSIX Time reading from internal clock.");
         ATR_PRINTF("Current time: %s\n\n", printfBuf);
      }

   }

   // Return to idle acquisition state
   GC_SetAcquisitionStart(0);
   GC_SetAcquisitionStop(1);

   PRINT("\n");

   while (GC_AcquisitionStarted) {
      AutoTest_RunMinimalStateMachines();
   }

   AutoTest_RestoreGCRegisters();

   return (testFailed) ? IRC_FAILURE : IRC_SUCCESS;
}

/*
 * Checks for a valid IRIG-B source and data, then outputs received time
 * to the console
 *
 * @return IRC_SUCCESS if received time and actual time are the same
 * @return IRC_FAILURE otherwise
 */
IRC_Status_t AutoTest_IRIGSync(void) {

   uint64_t irig_tic;
   t_PosixTime RTC;
   time_t curPOSIX;
   char printfBuf[80];
   struct tm *curTimeAndDate;
   uint8_t retry = 0;
   bool syncSuccess = false;

   AutoTest_SaveGCRegisters();

   // Reset time source flags
   gcRegsData.TimeSource = TS_InternalRealTimeClock;
   GC_TimeSourceCallback(GCCP_AFTER, GCCA_WRITE);

   // Begin test
   //ATR_PRINTF("Connect the IRIG Test Harness to J7, then start IRIG Output in NMEATime.\nPress ENTER to continue...");   --> EC
   ATR_PRINTF("Connect the IRIG Test Harness to J13, then start IRIG Output in NMEATime.\nPress ENTER to continue...");
   AutoTest_getUserNULL();

   ATR_PRINTF("Seeking valid IRIG-B Signal source...\n");
   GETTIME(&irig_tic);

   while (gcRegsData.TimeSource != TS_IRIGB && elapsed_time_us(irig_tic) < IRIG_TEST_TIMEOUT) {
      AutoTest_RunMinimalStateMachines();
      IRIG_Processing(&gcRegsData);
   }

   if (elapsed_time_us(irig_tic) > IRIG_TEST_TIMEOUT) {
      PRINTF("\n");
      ATR_ERR("Could not detect valid IRIG-B source signal.");
      return IRC_FAILURE;
   }

   while ((retry <= IRIG_SYNC_MAX_RETRY) && !syncSuccess) {

      GETTIME(&irig_tic);
      while (elapsed_time_us(irig_tic) < ONE_SECOND_US) {
         AutoTest_RunMinimalStateMachines();
         IRIG_Processing(&gcRegsData);
      }

      // Get POSIX time from internal clock
      RTC = TRIG_GetRTC(&gTrig);

      if (retry != 0) {
         // The first reading is always invalid, as shown by experimentation,
         // therefore we always discard it

         // Convert POSIX time to readable "human" time
         curPOSIX = (time_t)RTC.Seconds;

         curTimeAndDate = localtime(&curPOSIX);
         strftime(printfBuf, sizeof(printfBuf), "%B %d, %X", curTimeAndDate);

         PRINTF("\n");
         ATR_PRINTF("Current time: %s\n", printfBuf);

         ATR_PRINTF("Is this the correct local time? (Y/N) ");
         syncSuccess = AutoTest_getUserYN();

         if (!syncSuccess) {
            ATR_PRINTF("Retrying...");
         }
      }

      retry++;
   }

   AutoTest_RestoreGCRegisters();

   return (syncSuccess) ? IRC_SUCCESS : IRC_FAILURE;
}
