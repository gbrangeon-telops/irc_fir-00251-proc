/**
 *  @file TempMonitor.c
 *  Temperature monitor module implementation.
 *  
 *  This file implements the temperature monitor module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "TempMonitor.h"
#include "GC_Events.h"
#include "FPA_intf.h"
#include "utils.h"
#include "Calibration.h"
#include <math.h> // abs()
#include "hder_inserter.h"

/**
 * Global timer tic used to display FPA temperature very different error
 */
uint64_t tic_fpaTemperatureVeryDifferent = 0;

/**
 * Temperature monitor state machine.

\dot
digraph G {
   TM_INIT -> TM_SAMPLING -> TM_SAMPLING
}
\enddot

 */
void TempMonitor_SM()
{
   extern t_FpaIntf gFpaIntf;
   extern t_HderInserter gHderInserter;

   static tmState_t tmState = TM_INIT;

   static uint64_t tic_fpaTempSampling;

   // Cooler failure detection variables
   static uint64_t tic_coolerErrorDetection;
   static float prevSensorTemp;
   static float actualSensorTemp;

   int16_t sensorTemp;

   switch (tmState)
   {
      case TM_INIT:
         // Wait for first valid FPA temperature
         sensorTemp = FPA_GetTemperature(&gFpaIntf);
         if (sensorTemp != FPA_INVALID_TEMP)
         {
            DeviceTemperatureAry[DTS_Sensor] = CC_TO_C(sensorTemp);

            // Initialize cooler failure detection variables
            GETTIME(&tic_coolerErrorDetection);
            actualSensorTemp = DeviceTemperatureAry[DTS_Sensor];
            prevSensorTemp = actualSensorTemp;

            tic_fpaTempSampling = 0;
            tmState = TM_SAMPLING;
         }
         break;

      case TM_SAMPLING:
         // FPA temperature sampling
         if (elapsed_time_us(tic_fpaTempSampling) > FPA_TEMPERATURE_SAMPLING_PERIOD_US)
         {
            sensorTemp = FPA_GetTemperature(&gFpaIntf);
            if (sensorTemp != FPA_INVALID_TEMP)
            {
               // Update sensor temperature register
               DeviceTemperatureAry[DTS_Sensor] = CC_TO_C(sensorTemp);

               // Update image header
               HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_Sensor);

               // Validate sensor temperature
               if (((DeviceTemperatureAry[DTS_Sensor] < -220.0F) || (DeviceTemperatureAry[DTS_Sensor] > 50.0F)) && !TDCStatusTst(WaitingForCoolerMask))
               {
                  TM_ERR("Cooler temperature is not valid (%dcC).", C_TO_CC(DeviceTemperatureAry[DTS_Sensor]));
                  GC_GenerateEventError(EECD_InvalidCoolerTemperature);
               }

               // FPA temperature very different detection
               if (TDCStatusTst(AcquisitionStartedMask) && (calibrationInfo.isValid) &&
                     (fabsf(DeviceTemperatureAry[DTS_Sensor] - CC_TO_C(calibrationInfo.collection.DeviceTemperatureSensor)) > FPA_TEMPERATURE_TOL_C) &&
                     (elapsed_time_us(tic_fpaTemperatureVeryDifferent) > FPA_TEMPERATURE_ERROR_PERIOD_US))
               {
                  TM_ERR("FPA temperature very different (Sensor = %dcC, Calib = %dcC)", C_TO_CC(DeviceTemperatureAry[DTS_Sensor]), calibrationInfo.collection.DeviceTemperatureSensor);
                  GC_GenerateEventError(EECD_FPATemperatureDifferent);
                  GETTIME(&tic_fpaTemperatureVeryDifferent);
               }
            }

            GETTIME(&tic_fpaTempSampling);
         }

         // Cooler failure periodic detection
         if (elapsed_time_us(tic_coolerErrorDetection) > COOLER_ERROR_DETECTION_PERIOD_US)
         {
            prevSensorTemp = actualSensorTemp;
            actualSensorTemp = DeviceTemperatureAry[DTS_Sensor];

            // Compare actual sensor temperature with last sample
            if ((actualSensorTemp - prevSensorTemp) > COOLER_ERROR_THRESHOLD_C)
            {
               TM_ERR("FPA cooler is not cooling");
               GC_GenerateEventError(EECD_CoolerNotCooling);
            }

            GETTIME(&tic_coolerErrorDetection);
         }
         break;
   }
}
