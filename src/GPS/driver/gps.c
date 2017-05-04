/**
 * @file gps.c
 * GPS module implementation.
 *
 * This file implements GPS module.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2015 Telops Inc.
 */

#include "GPS.h"
#include "trig_gen.h"
#include "UART_Utils.h"
#include "hder_inserter.h"
#include "GC_Events.h"
#include <string.h>
#include <stdlib.h>

static void GPS_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData);
static uint32_t toSiRFBinary(uint32_t degrees, uint32_t minutes);
static uint32_t MinutesDigitsToSiRFBinary(uint32_t minutes_frac_digits, uint32_t number_of_digits);
static uint32_t str2int(char *data, uint32_t pos, uint32_t num);
static GPS_NMEA_codes_t NMEA_BuildValidateCommand(t_GPS *GPS_Data, uint8_t receivedByte);
static void GPS_Reset(t_GPS *GPS_Data);
static void GPS_ParseGPRMC(t_GPS *GPS_Data);
static void GPS_LowPriorityTasks(t_GPS *GPS_Data);

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
 * Reset/initialize the GPS Data structure : counters and data fields.
 * 
 * @param GPS_Data is the pointer to the GPS data structure.
 */
void GPS_RstData(t_GPS *GPS_Data)
{
   GPS_Data->index = 0;
   GPS_Data->field = 0;
   GPS_Data->CharPtr = 0;
   GPS_Data->checksumVal = 0;
   memset(GPS_Data->checksum, 0, 3);
   memset(GPS_Data->dataArray, 0, NBR_OF_FIELD * NBR_OF_CHAR);
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
 * Init and reset the GPS communication layer.
 * 
 * @param GPS_Data is the pointer to the GPS data structure.
 * @param uartDeviceId is the UART device ID that can be found in xparameters.h file.
 * @param intc is the pointer to the Interrupt controller instance.
 * @param uartIntrId is the UART interrupt ID that can be found in xparameters.h file.
 * @param rxCircBuffer is a pointer to the buffer used to initialize received data circular buffer.
 * @param rxCircBufferSize is the size of the buffer used to initialize received data circular buffer.
 *
 * @return IRC_SUCCESS if GPS data structure initialization is successful.
 * @return IRC_FAILURE if failed to initialize GPS data structure.
 */
IRC_Status_t GPS_Init(t_GPS *GPS_Data,
      uint16_t uartDeviceId,
      XIntc *intc,
      uint16_t uartIntrId,
      uint8_t *rxCircBuffer,
      uint16_t rxCircBufferSize)
{
   IRC_Status_t status;

   memset(GPS_Data, 0, sizeof(t_GPS));

   if (CBB_Init(&GPS_Data->rxCircDataBuffer, rxCircBuffer, rxCircBufferSize) != IRC_SUCCESS)
   {
      return IRC_FAILURE;
   }

   status = CircularUART_Init(&GPS_Data->uart,
		   uartDeviceId,
		   intc,
		   uartIntrId);
	if (status != IRC_SUCCESS)
	{
	  return IRC_FAILURE;
	}

	if (UART_Config(&GPS_Data->uart.uart, 9600, 8, 'N', 1) != IRC_SUCCESS)
	{
	  return IRC_FAILURE;
	}

	GPS_Data->uart.rxCircBuffer = &GPS_Data->rxCircDataBuffer;
	GPS_Data->uart.txCircBuffer = NULL;
	GPS_Data->uart.uart.Handler = GPS_UART_IntrHandler;
	GPS_Data->uart.uart.CallBackRef = GPS_Data;

   // Set ModeIndicator to "Data Not Valid"
	GPS_Data->ModeIndicator = 'N';
   
   // Init errors flag at camera startup to avoid issuing error when GPS isn't connected.
   // If GPS is detected first time, these error flags will onlt then be cleared.
	GPS_Data->ErrFlags = 0;
   
	GPS_Data->MissingPps_cnt = 0;
   
   // Set GPS to not present   
	GPS_Data->GpsStatus = GPS_NOTDETECTED;
   
   //Reset comm Layer
   GPS_Reset(GPS_Data);

   // Reset RX FIFO
   UART_ResetRxFifo(&GPS_Data->uart.uart);

   return IRC_SUCCESS;
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

   GPS_NMEA_codes_t returnValue;		 	// Stores the return value (command or 0 if not done)
   uint8_t checksum;   

   returnValue = GPS_NOT_DONE;	 // Make sure to return 0 until the whole packet is received and checked

   // Protection for array overflow. Error in communication
   if (GPS_Data->field == NBR_OF_FIELD -1 || GPS_Data->CharPtr == NBR_OF_CHAR -1)
   {
   //	NMEA_ResetSerial(State); ??
      return -1;
   }

   switch(GPS_Data->index)
   {
	   case 0:		// Start of NMEA frame
      	if(receivedByte == '$')
         {
      	   GPS_Data->dataArray[GPS_Data->field][GPS_Data->CharPtr++] = receivedByte;
      	   GPS_Data->checksumVal = 0;		// reset the checksum counter
      	   GPS_Data->index++;
          }
      	break;

      case 1:		// Extract the NMEA frame
         if(receivedByte == ',') // Check if new field
         {
            GPS_Data->field++;			// Move to next field
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

      case 2:		// Extract Checksum
			if(GPS_Data->CharPtr < 2) // Only two byte for checksum
			   GPS_Data->checksum[GPS_Data->CharPtr++] = receivedByte;

         if(receivedByte == 0xD) // <CR>
         {
            GPS_Data->index++;
			}
      	break;

      case 3:		// Process the NMEA frame
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
 * Function that gets called continuously to receive and decode GPS NMEA
 * sentences. It updates the Latitude and Longitude as well as POSIXTime when
 * a NMEA message is complete.
 * 
 * @param GPS_Data is the pointer to the GPS data structure.
 */
void GPS_Process(t_GPS *GPS_Data)
{
   uint8_t byte;
   uint32_t POSIXTimeAtNextPPS;
   uint16_t i, len;
   extern t_HderInserter gHderInserter;
   extern t_Trig gTrig;
      
   // Read receive fifo until empty
   len = CBB_Length(&GPS_Data->rxCircDataBuffer);

   for (i = 0; i < len; i++)
   {     
      // Get GPS UART actual byte
      CBB_Pop(&GPS_Data->rxCircDataBuffer, &byte);
      
      switch(NMEA_BuildValidateCommand(GPS_Data, byte))
      {
         case GPS_NOT_DONE: // NMEA not done gathering a complete sentence
            // Update gps timeout counter here
            GETTIME(&GPS_Data->CommTic);            
            if((GPS_Data->GpsStatus == GPS_NOTDETECTED) || (GPS_Data->GpsStatus == GPS_LOST))
            {
               GETTIME(&GPS_Data->NmeaTic);   
               // We have something on GPS UART port so set GPS state to present
               GPS_Data->GpsStatus = GPS_PRESENT; 
            }   
         	break;

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
            TRIG_OverWritePOSIXNextPPS(POSIXTimeAtNextPPS, 0, &gTrig);    // ENO: Sauf indication contraire, le subsec du GPS est mis à 0
           
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
   } // end for
   
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

/**
 * GPS UART interrupt handler.
 *
 * @param CallBackRef is a pointer to the control interface data structure.
 * @param Event is used to identify the cause of the interrupt.
 * @param EventData is the number of received or sent bytes.
 */
void GPS_UART_IntrHandler(void *CallBackRef, u32 Event, unsigned int EventData)
{
   // Nothing to do
}
