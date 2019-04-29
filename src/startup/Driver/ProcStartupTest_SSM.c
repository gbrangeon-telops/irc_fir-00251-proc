/**
 * @file SystemFunctionSM_Test.c
 * Modified Systems State Machines implementation
 *
 * This file implements the modified state machines for use in automated tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 d√©c. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_SSM.h"

// External variables
extern XSysMon xsm;

// External functions
extern void ProcessAdcChannel(xadcChannel_t *xadcCh);
extern void StartXADCSequence(void);

// GPS Private functions are copied here for proper test process functionality
static uint32_t toSiRFBinary(uint32_t degrees, uint32_t minutes);
static uint32_t MinutesDigitsToSiRFBinary(uint32_t minutes_frac_digits, uint32_t number_of_digits);
static uint32_t str2int(char *data, uint32_t pos, uint32_t num);
static GPS_NMEA_codes_t NMEA_BuildValidateCommand(t_GPS *GPS_Data, uint8_t receivedByte);
static void GPS_Reset(t_GPS *GPS_Data);
static void GPS_ParseGPRMC(t_GPS *GPS_Data);
static void GPS_LowPriorityTasks(t_GPS *GPS_Data);

extern void GPS_RstData(t_GPS *GPS_Data);


/*
 * Modified XADC State Machine for tests 3.4.4 and 3.8
 *
 * @note Removed state tracking. This modified function goes through every step without
 *       pause and thus has full thread control.
 *
 * @param ExtCh is the external channel to be measured. Setting ExtCh to XADC_COUNT measures
 *        internal values instead.
 *
 * @return void.
 */
void XADC_SM_Test(xadcExtCh_t ExtCh)
{
   uint64_t tic_xadcSampling;
   uint32_t i;

   // case XADC_INIT
      if (ExtCh != XEC_COUNT)
      {
         Power_SetMuxAddr(extAdcChannels[ExtCh].muxAddr);
      }

      GETTIME(&tic_xadcSampling);

   // case XADC_START_SEQUENCE:

      /* Wait for sampling time instead of checking if sampling time has passed */
      while (elapsed_time_us(tic_xadcSampling) < XADC_SAMPLING_PERIOD_US);

      StartXADCSequence();

   // case XADC_READ_CHANNELS:
      // Wait the end of internal sequence
      while ((XSysMon_GetStatus(&xsm) & XSM_SR_EOS_MASK) != XSM_SR_EOS_MASK);

      if (ExtCh == XEC_COUNT)
      {
         // Read the internal ADC channels data from the data registers
         intAdcChannels[XIC_TEMP].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_TEMP);
         intAdcChannels[XIC_VCCINT].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_VCCINT);
         intAdcChannels[XIC_VCCAUX].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_VCCAUX);
         intAdcChannels[XIC_VREFP].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_VREFP);
         intAdcChannels[XIC_VREFN].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_VREFN);
         intAdcChannels[XIC_VBRAM].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_VBRAM);

         // Process internal ADC channels data
         for (i = 0; i < XIC_COUNT; ++i)
         {
            ProcessAdcChannel(&intAdcChannels[i]);
         }
      }
      else
      {
         // Read the external ADC channel data from the data register
         extAdcChannels[ExtCh].raw.unipolar = XSysMon_GetAdcData(&xsm, XSM_CH_VPVN);

         // Process external ADC channel data
         ProcessAdcChannel(&extAdcChannels[ExtCh]);
      }
}

/****************************************************************************************
 * GPS
 ***************************************************************************************/

void GPS_Process_TEST(t_GPS *GPS_Data) {

   uint8_t byte;
   uint32_t POSIXTimeAtNextPPS;
   extern t_HderInserter gHderInserter;
   extern t_Trig gTrig;

   GPS_NMEA_codes_t testValidate = GPS_NOT_DONE;

   while (testValidate == GPS_NOT_DONE && !CBB_Empty(&GPS_Data->rxCircDataBuffer))
   {

      // Get GPS UART actual byte
      CBB_Pop(&GPS_Data->rxCircDataBuffer, &byte);

      GETTIME(&GPS_Data->CommTic);
      if((GPS_Data->GpsStatus == GPS_NOTDETECTED) || (GPS_Data->GpsStatus == GPS_LOST))
      {
         GETTIME(&GPS_Data->NmeaTic);
         // We have something on GPS UART port so set GPS state to present
         GPS_Data->GpsStatus = GPS_PRESENT;
      }

      testValidate = NMEA_BuildValidateCommand(GPS_Data, byte);
   }

   switch(testValidate)
   {
      case GPS_NOT_DONE: // NMEA not done gathering a complete sentence
         // Update gps timeout counter here

         ATR_PRINTF("Invalid GPS Process State");
         return;

      case GPS_GPRMC:  // RMC message $GPRMC,200559.686,V,4648.2978,N,07119.9542,W,0.00,0.00,280910,,,N*6B

         // Update gps timeout counter here
         GETTIME(&GPS_Data->NmeaTic);
         // Set GPS state to good comm sens we have a good NMEA sentence now
         GPS_Data->GpsStatus = GPS_GOOD_COMM;
         // Call parsing fnct to extract time and coordinates
         GPS_ParseGPRMC(GPS_Data);
         // Update POSIXTime for the next PPS
         GPS_Data->rTClock.tm_isdst = -1; //tells mktime()  to determine whether daylight saving time is in effect */
         POSIXTimeAtNextPPS = mktime(&GPS_Data->rTClock) + 1;
         // Overwrite of RTC time by the GPS at the next PPS
         TRIG_OverWritePOSIXNextPPS(POSIXTimeAtNextPPS, 0, &gTrig);    // ENO: Sauf indication contraire, le subsec du GPS est mis ‡ 0

         // Update GeniCam Reg: Latitude
         gcRegsData.GPSLatitude = (int32_t)(toSiRFBinary(GPS_Data->Latitude.degrees, GPS_Data->Latitude.minutes) + MinutesDigitsToSiRFBinary(GPS_Data->Latitude.frac_minutes, GPS_Data->Latitude.frac_digits));
         if(GPS_Data->Latitude.Hemisphere == 'S')
         {
            gcRegsData.GPSLatitude *= -1;
         }

         // Update GeniCam Reg: Longitude
         gcRegsData.GPSLongitude = (int32_t)(toSiRFBinary(GPS_Data->Longitude.degrees, GPS_Data->Longitude.minutes) + MinutesDigitsToSiRFBinary(GPS_Data->Longitude.frac_minutes, GPS_Data->Longitude.frac_digits));
         if (GPS_Data->Longitude.Hemisphere == 'W')
         {
            gcRegsData.GPSLongitude *= -1;
         }

         // Update GeniCam Reg: ModeIndicator
         gcRegsData.GPSModeIndicator = GPS_Data->ModeIndicator;

         // Update header
         HDER_UpdateGPSHeader(&gHderInserter, &gcRegsData);

         // Reset GPS data structure to get it ready for the next NMEA sentence
         GPS_RstData(GPS_Data);
         break; //case GPS_GPRMC

      case GPS_GPGGA: //$GPGGA,193917.000,4648.2933,N,07119.9534,W,1,5,1.72,5.3,M,-28.7,M,,*6D
         // Extract Altitude
         GPS_Data->Altitude = str2int((char *)(GPS_Data->dataArray[9]),0,strlen((char *)(GPS_Data->dataArray[9]))-2);
         GPS_Data->Altitude_frac = str2int((char *)(GPS_Data->dataArray[9]),strlen((char *)(GPS_Data->dataArray[9]))-1,1);

         // Update GeniCam Reg: Altitude. In SiRF format and expressed in cm
         gcRegsData.GPSAltitude = (int32_t)(100*GPS_Data->Altitude + 10*GPS_Data->Altitude_frac);

         // Findout GPS signal quality: number of satellites used in position fix
         gcRegsData.GPSNumberOfSatellitesInUse = str2int((char *)(GPS_Data->dataArray[7]),0,2);

         // Update header
         HDER_UpdateGPSHeader(&gHderInserter, &gcRegsData);

         // Reset GPS data structure to get it ready for the next NMEA sentence
         GPS_RstData(GPS_Data);
         break; //case GPS_GPGGA

      case GPS_NMEA_OTHERS:
         // Do nothing here, just ignore other sentences
         // Reset GPS data structure to get it ready for the next NMEA sentence
         GPS_RstData(GPS_Data);
         break;

      default:
         // Invalid command received... just ignore it and reset GPS data structure
         GPS_RstData(GPS_Data);
         break;
   } // end switch

   if(elapsed_time_us(GPS_Data->CommTic) >= GPS_COMM_TIMEOUT_DELAY_US)
   {
      // Set ModeIndicator to "Data Not Valid" as soon as we lose communication with GPS UART
      gcRegsData.GPSModeIndicator = 'N';
      gcRegsData.GPSNumberOfSatellitesInUse = 0;
      if((GPS_Data->GpsStatus != GPS_LOST) && (GPS_Data->GpsStatus != GPS_NOTDETECTED))
      {
         // Set GPS to not detected
         GPS_Data->GpsStatus = GPS_LOST;
         GC_GenerateEventError(EECD_GPSCommunicationLost);
         GPS_ERR("GPS lost");
      }

      // Update header
      HDER_UpdateGPSHeader(&gHderInserter, &gcRegsData);
   }
   else if ((elapsed_time_us(GPS_Data->NmeaTic) >= GPS_NMEA_TIMEOUT_DELAY_US) && (GPS_Data->GpsStatus != GPS_BAD_COMM))
   {
      // Set GPS to present : no comm time out but NMEA timed out
      GPS_Data->GpsStatus = GPS_BAD_COMM;
      GPS_ERR("Bad COMM/data format");
   }

   if (elapsed_time_us(GPS_Data->LowPriorityTaskTic) > TIME_TEN_SECOND_US)
   {
      GETTIME(&GPS_Data->LowPriorityTaskTic);
      GPS_LowPriorityTasks(GPS_Data);
   }
}

/**
 * Converts degrees and minutes to the SiRF binary format, which is only
 * degrees but multiplied by 1e7. So the LSB is 1e-7 degree.
 *
 * @param degrees 0 to 89 degrees.
 * @param minutes 0 to 59 minutes.
 *
 * @return The SiRF binary uint32_t result.
 */
uint32_t toSiRFBinary(uint32_t degrees, uint32_t minutes)
{
   #define SIRF_SCALING 10000000
   uint32_t SiRF_from_minutes;

   SiRF_from_minutes = (minutes * SIRF_SCALING) / 60;
    return (uint32_t)(degrees * SIRF_SCALING + SiRF_from_minutes);
}

/**
 * Converts minutes fractional digits to SiRF binary format. For example,
 * the NMEA latitude can be given as ddmm.mmm format. This function takes the
 * last 3 mmm digits (or 2 to 7) and converts it to SiRF binary.
 *
 * @param minutes_frac_digits 0 to 99 when 2 digits,
 *                            0 to 999 when 3 digits,
 *                            0 to 9999 when 4 digits,
 *                            0 to 99999 when 5 digits,
 *                            0 to 999999 when 6 digits,
 *                            0 to 9999999 when 7 digits.
 * @param number_of_digits The number of fractionnal digits (2 to 7).
 *
 * @return The SiRF binary uint32_t result.
 */
uint32_t MinutesDigitsToSiRFBinary(uint32_t minutes_frac_digits, uint32_t number_of_digits)
{
   uint32_t SiRFBinary = 0;

   switch (number_of_digits)
   {
      case 2:
         SiRFBinary = (uint32_t)((minutes_frac_digits * 10000000) / 6000);
         break;

      case 3:
         SiRFBinary = (uint32_t)((minutes_frac_digits * 1000000) / 6000);
         break;

      case 4:
         SiRFBinary = (uint32_t)((minutes_frac_digits * 100000) / 6000);
         break;

      case 5:
         SiRFBinary = (uint32_t)((minutes_frac_digits * 10000) / 6000);
         break;

      case 6:
         SiRFBinary = (uint32_t)((minutes_frac_digits * 1000) / 6000);
         break;

      case 7:
         SiRFBinary = (uint32_t)((minutes_frac_digits * 100) / 6000);
         break;
   }

   return SiRFBinary;
}

/**
 * Function that convert string to integer.
 *
 * @param data : pointer to gps data memeber to convert
 * @param pos : position in the gps data member
 * @param num : number of char to consider
 *
 * @return converted string to integer
 */
uint32_t str2int(char *data, uint32_t pos, uint32_t num)
{
   char StrTmp[6];

   // Init array temp variable
   memset(StrTmp, 0, sizeof(StrTmp));

   // Copy string
   memcpy(&StrTmp,&data[pos],num);

   // Convert string to integer and return the result
   return (uint32_t)atoi(StrTmp);
}

/**
 * Analyzes the received packet byte by byte. Handles 1 byte then returns
 * before handling the next byte.
 *
 * @param GPS_Data is the pointer to the GPS data structure.
 * @param receivedByte The received byte.
 *
 * @return The command byte if the command is complete, otherwise GPS_NOT_DONE
 */
GPS_NMEA_codes_t NMEA_BuildValidateCommand(t_GPS *GPS_Data, uint8_t receivedByte)
{

   GPS_NMEA_codes_t returnValue;       // Stores the return value (command or 0 if not done)
   uint8_t checksum;

   returnValue = GPS_NOT_DONE;    // Make sure to return 0 until the whole packet is received and checked

   // Protection for array overflow. Error in communication
   if (GPS_Data->field == NBR_OF_FIELD -1 || GPS_Data->CharPtr == NBR_OF_CHAR -1)
   {
   // NMEA_ResetSerial(State); ??
      return -1;
   }

   switch(GPS_Data->index)
   {
      case 0:     // Start of NMEA frame
         if(receivedByte == '$')
         {
            GPS_Data->dataArray[GPS_Data->field][GPS_Data->CharPtr++] = receivedByte;
            GPS_Data->checksumVal = 0;    // reset the checksum counter
            GPS_Data->index++;
          }
         break;

      case 1:     // Extract the NMEA frame
         if(receivedByte == ',') // Check if new field
         {
            GPS_Data->field++;         // Move to next field
            GPS_Data->CharPtr = 0;
            GPS_Data->checksumVal ^= receivedByte; // comma is included in checksum
         }
         else if(receivedByte == '*') // Checksum identifier
         {
            GPS_Data->index++;
            GPS_Data->field++;
            GPS_Data->CharPtr = 0;
        }
         else
         {
            GPS_Data->checksumVal ^= receivedByte;
            GPS_Data->dataArray[GPS_Data->field][GPS_Data->CharPtr++] = receivedByte;
         }
         break;

      case 2:     // Extract Checksum
         if(GPS_Data->CharPtr < 2) // Only two byte for checksum
            GPS_Data->checksum[GPS_Data->CharPtr++] = receivedByte;

         if(receivedByte == 0xD) // <CR>
         {
            GPS_Data->index++;
         }
         break;

      case 3:     // Process the NMEA frame
         // Verify the Checksum
         checksum = (HEXTOBIN(GPS_Data->checksum[0]) << 4) + HEXTOBIN(GPS_Data->checksum[1]);
         if(checksum != GPS_Data->checksumVal)
         {
            if (!(GPS_Data->ErrFlags & GPS_BADCKSUM))
            {
               GPS_Data->ErrFlags |= GPS_BADCKSUM;
               GPS_ERR("NMEA bad checksum");
            }

            // Reset GPS Serial com and GPS data
            GPS_Reset(GPS_Data);
            break;
         }
         else
         {
            // Clear cksum error after receiving a sentence with a good chsum.
            GPS_Data->ErrFlags &= ~GPS_BADCKSUM;
         }

         // GPS UP500B
         if(strcmp((char *)(GPS_Data->dataArray[0]),"$GPRMC")==0)
         {
            returnValue = GPS_GPRMC;
            if (GPS_Data->showNMEA) GPS_INF("GPRMC sentence received");
         }
         else if(strcmp((char *)(GPS_Data->dataArray[0]),"$GPGGA")==0)
         {
            returnValue = GPS_GPGGA;
            if (GPS_Data->showNMEA) GPS_INF("GPGGA sentence received");
         }
         else
         {
            returnValue = GPS_NMEA_OTHERS;
            if (GPS_Data->showNMEA) GPS_INF("Other NMEA sentence received");
         }

         break;  // case 3

      default:
         break;
   } // End switch(GPS_Data.index)

   return returnValue;
}

/**
 * Reset the GPS communication layer.
 *
 * @param GPS_Data is the pointer to the GPS data structure.
 */
void GPS_Reset(t_GPS *GPS_Data)
{
   // Reset/init GPS data structure
   GPS_RstData(GPS_Data);

   GETTIME(&GPS_Data->CommTic);
   GETTIME(&GPS_Data->NmeaTic);
   GETTIME(&GPS_Data->LowPriorityTaskTic);
}

/**
 * Function that gets called each time a complete NMEA GPRMC sentence is gathered to parse
 * it and fill-up time and coordinates structures.
 *
 * @param GPS_Data is the pointer to the GPS data structure.
 */
void GPS_ParseGPRMC(t_GPS *GPS_Data)
{
   uint32_t StrLength;

   //GPS Fix
   GPS_Data->Gps_Fix = (char) GPS_Data->dataArray[2][0];
   // GPS UTC Time = hhmmss.xxx at position [1]of our NMEA data table
   // Extract hh
   GPS_Data->rTClock.tm_hour = str2int((char *)(GPS_Data->dataArray[1]),0,2);
   // Extract mm
   GPS_Data->rTClock.tm_min = str2int((char *)(GPS_Data->dataArray[1]),2,2);
   // Extract ss
   GPS_Data->rTClock.tm_sec = str2int((char *)(GPS_Data->dataArray[1]),4,2);

   // GPS UTC Date = ddmmyy
   // Extract hh
   GPS_Data->rTClock.tm_mday = str2int((char *)(GPS_Data->dataArray[9]),0,2);
   // Extract mm
   GPS_Data->rTClock.tm_mon = str2int((char *)(GPS_Data->dataArray[9]),2,2)-1; //Month = 0 to 11
   // Extract ss
   GPS_Data->rTClock.tm_year = 100 + str2int((char *)(GPS_Data->dataArray[9]),4,2);

   // Latitude ddmm.mmmm
   StrLength = strlen((char *)(GPS_Data->dataArray[3]));
   // Extract dd
   GPS_Data->Latitude.degrees = str2int((char *)(GPS_Data->dataArray[3]),0,2);
   // Extract mm
   GPS_Data->Latitude.minutes = str2int((char *)(GPS_Data->dataArray[3]),2,2);
   // Calculate how many fractional digits for frac_minutes
   GPS_Data->Latitude.frac_digits = StrLength-5;
   // Extract frac_mm
   GPS_Data->Latitude.frac_minutes = str2int((char *)(GPS_Data->dataArray[3]),5,GPS_Data->Latitude.frac_digits);
   // Latitude Hemisphere (N or S)
   GPS_Data->Latitude.Hemisphere = (char) GPS_Data->dataArray[4][0];

   // Longitude dddmm.mmmm
   StrLength = strlen((char *)(GPS_Data->dataArray[5]));
   // Extract ddd
   GPS_Data->Longitude.degrees = str2int((char *)(GPS_Data->dataArray[5]),0,3);
   // Extract mm
   GPS_Data->Longitude.minutes = str2int((char *)(GPS_Data->dataArray[5]),3,2);
   // Calculate how many fractional digits for frac_minutes
   GPS_Data->Longitude.frac_digits = StrLength-6;
   // Extract frac_mm
   GPS_Data->Longitude.frac_minutes = str2int((char *)(GPS_Data->dataArray[5]),6,GPS_Data->Longitude.frac_digits);
   // Longitude Hemisphere (E or W)
   GPS_Data->Longitude.Hemisphere = (char) GPS_Data->dataArray[6][0];

   // GPS Mode Indicator (A,D,E or N)
   GPS_Data->ModeIndicator = (char) GPS_Data->dataArray[12][0];
}

/**
 * Function that gets called in low priority mode to check for some HW regs not
 * too often, t.e. check for GPS errors.
 *
 * @param GPS_Data is the pointer to the GPS data structure.
 */
void GPS_LowPriorityTasks(t_GPS *GPS_Data)
{
   uint32_t PpsTimeOut;
   uint32_t PpsSource;
   extern t_HderInserter gHderInserter;
   extern t_Trig gTrig;

   PpsSource = TRIG_GetPpsSrc(&gTrig);

   if(gcRegsData.TimeSource == TS_GPS)
   {
     // Gestion du register GC time source
     PpsTimeOut = TRIG_PpsTimeOut(&gTrig);

      if((GPS_Data->ModeIndicator == 'N') || PpsTimeOut)
      {
         gcRegsData.TimeSource = TS_InternalRealTimeClock;

         // Update header
         HDER_UpdateTimeSourceHeader(&gHderInserter, gcRegsData.TimeSource);
      }
   } else {
      PpsTimeOut = 0;
   }

   // Check communication timeout with GPS
   if(elapsed_time_us(GPS_Data->CommTic) >= GPS_COMM_TIMEOUT_DELAY_US)
   {
      // Set ModeIndicator to "Data Not Valid" as soon as we lose communication with GPS UART
      gcRegsData.GPSModeIndicator = 'N';
      gcRegsData.GPSNumberOfSatellitesInUse = 0;
      if((GPS_Data->GpsStatus != GPS_LOST) && (GPS_Data->GpsStatus != GPS_NOTDETECTED))
      {
         // Set GPS to not detected
         GPS_Data->GpsStatus = GPS_LOST;
         GC_GenerateEventError(EECD_GPSCommunicationLost);
         GPS_ERR("GPS lost");
      }

      // Update header
      HDER_UpdateGPSHeader(&gHderInserter, &gcRegsData);
   }
   else if ((elapsed_time_us(GPS_Data->NmeaTic) >= GPS_NMEA_TIMEOUT_DELAY_US) && (GPS_Data->GpsStatus != GPS_BAD_COMM))
   {
      // Set GPS to present : no comm time out but NMEA timed out
      GPS_Data->GpsStatus = GPS_BAD_COMM;
      GPS_ERR("Bad COMM/data format");
   }

   // PPS 8 seconds time out
   if(GPS_Data->GpsStatus == GPS_GOOD_COMM)
   {
      if(PpsTimeOut && PpsSource == TS_GPS)
      {
         if(GPS_Data->MissingPps_cnt < GPS_PPS_TIMEOUT)
         {
            GPS_Data->MissingPps_cnt++;
         }
         else if(!(GPS_Data->ErrFlags & GPS_NOPPS))
         {
            // Set error flag
            GPS_Data->ErrFlags |= GPS_NOPPS;
            GPS_ERR("PPS Timeout");
         }
      }
      else if((gcRegsData.TimeSource != TS_GPS) && (GPS_Data->ModeIndicator != 'N'))  // we have a good GPS UART comm and PPS
      {
         // Set time sourceto GPS
         gcRegsData.TimeSource = TS_GPS;
         // Init the counter as soon as we get a PPS
         GPS_Data->MissingPps_cnt = 0;
         // Clear pps time out error flag
         GPS_Data->ErrFlags &= ~GPS_NOPPS;
         TRIG_PpsSrcSelect(TS_GPS, &gTrig);

         // Update header
         HDER_UpdateTimeSourceHeader(&gHderInserter, gcRegsData.TimeSource);
      }
   }
   else // in case we lost comm or so, we need to init the cnt and error flag to start over
   {
      // init the counter as soon as we get a PPS
      GPS_Data->MissingPps_cnt = 0;
      // Clear pps time out error flag
      GPS_Data->ErrFlags &= ~GPS_NOPPS;
   }

   // Gestion d'erreur du UART overflow : In our case, the overflow will almost never accure because of LL bus data throttling, so our best indicator is the FIFO FULL signal
   if (XUartNs550_GetLineStatusReg(GPS_Data->uart.uart.BaseAddress) & XUN_LSR_OVERRUN_ERROR)
   {
      GPS_Reset(GPS_Data); // reset uart and data structure
      // Set the error flag and report genicam error once if it wasn't done yet
      if (!(GPS_Data->ErrFlags & GPS_UARTOVRFLW))
      {
         GPS_Data->ErrFlags |= GPS_UARTOVRFLW;
         GPS_ERR("UART RX Overflow");
      }
   }
   else
   {
      // Clear Overflow error flag
      GPS_Data->ErrFlags &= ~GPS_UARTOVRFLW;
   }
}
