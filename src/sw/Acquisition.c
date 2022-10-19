/**
 *  @file Acquisition.c
 *  Acquisition module implementation.
 *  
 *  This file implements the acquisition module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "Acquisition.h"
#include "utils.h"
#include "FPA_intf.h"
#include "exposure_time_ctrl.h"
#include "Trig_gen.h"
#include "hder_inserter.h"
#include "calib.h"
#include "power_ctrl.h"
#include "XADC_Channels.h"
#include "BufferManager.h"
#include "EHDRI_Manager.h"
#include "GenICam.h"
#include "Calibration.h"
#include "TempMonitor.h"
#include "FlashDynamicValues.h"
#include "BuiltInTests.h"
#include "flagging.h"
#include "gating.h"
#include "proc_init.h"
#include "AEC.h"
#include "Actualization.h"
#include "SFW_ctrl.h"
#include "FrameBuffer.h"

#include <stdbool.h> // bool

static uint8_t gAcquisitionTurnOn = 0;
static uint8_t gAcquisitionTurnOff = 0;
static DevicePowerState_t gAcquisitionPowerState = DPS_PowerStandby;

bool actualisationAcqStartReady();
void Acquisition_Arm();
void Acquisition_Start();
void SCD_UpdatePostponedExposureTimeChange();
void SCD_SetRelaxMode();

/**
 * Set acquisition module power state setpoint.
 *
 * @param acquisitionPowerStateSetpoint is the acquisition module power state setpoint.
 *
 * @return IRC_SUCCESS if successfully set acquisition module power state setpoint.
 * @return IRC_FAILURE if failed to set acquisition module power state setpoint.
 */
IRC_Status_t Acquisition_SetPowerState(DevicePowerStateSetpoint_t acquisitionPowerStateSetpoint)
{
   if (gAcquisitionPowerState == DPS_PowerInTransition)
   {
      return IRC_FAILURE;
   }

   if ((gAcquisitionPowerState == DPS_PowerStandby) && (acquisitionPowerStateSetpoint == DPSS_PowerOn))
   {
      GC_SetAcquisitionStop(1);
      gAcquisitionTurnOn = 1;
      gAcquisitionPowerState = DPS_PowerInTransition;
   }
   else if ((gAcquisitionPowerState == DPS_PowerOn) && (acquisitionPowerStateSetpoint == DPSS_PowerStandby))
   {
      GC_SetAcquisitionStop(1);
      gAcquisitionTurnOff = 1;
      gAcquisitionPowerState = DPS_PowerInTransition;
   }

   return IRC_SUCCESS;
}

/**
 * Return actual acquisition module power state.
 *
 * @return actual acquisition module power state.
 */
DevicePowerState_t Acquisition_GetPowerState()
{
   return gAcquisitionPowerState;
}

bool actualisationAcqStartReady()
{
   extern bool gActAllowAcquisitionStart; // from Actualization.h
   extern actDebugOptions_t gActDebugOptions; // from Actualization.h

   return (gActAllowAcquisitionStart &&
         (gcRegsData.TDCStatus & ~WaitingForImageCorrectionMask) == 0) ||
         (gActDebugOptions.bypassChecks == true);
}

/**
 * Arm detector.
 */
void Acquisition_Arm()
{
   extern t_Trig gTrig;
   extern t_ExposureTime gExposureTime;
   extern t_FpaIntf gFpaIntf;
   extern t_HderInserter gHderInserter;
   extern t_calib gCal;
   extern t_EhdriManager gEHDRIManager;
   extern t_FlagCfg gFlagging_ctrl;
   extern t_GatingCfg gGating_ctrl;
   extern t_bufferManager gBufManager;
   extern t_FB gFB_ctrl;

   TRIG_SendConfigGC(&gTrig, &gcRegsData);

   EHDRI_SendConfig(&gEHDRIManager, &gcRegsData);

   EXP_SendConfigGC(&gExposureTime, &gcRegsData);

   CAL_SendConfigGC(&gCal, &gcRegsData);
   CAL_UpdateCalibBprMode(&gCal, &gcRegsData);

   FPA_SendConfigGC(&gFpaIntf, &gcRegsData);

   HDER_SendConfigGC(&gHderInserter, &gcRegsData);
   HDER_SendHeaderGC(&gHderInserter, &gcRegsData);

   FLAG_SendConfigGC(&gFlagging_ctrl, &gcRegsData);
   GATING_SendConfigGC(&gGating_ctrl, &gcRegsData);

   AEC_Arm();

   BufferManager_HW_MoiHandlerConfig(&gBufManager, 0);


   FB_SendConfigGC(&gFB_ctrl, &gcRegsData);


   TDCStatusClr(WaitingForArmMask);

   PRINT("Arming...\n");
}

/**
 * Start acquisition.
 */
void Acquisition_Start()
{
   extern t_Trig gTrig;
   extern uint8_t tic_fpaTemperatureVeryDifferent;

   // Switch trigger to normal mode (not extra trig).
   TRIG_ChangeAcqWindow(&gTrig, TRIG_Normal, &gcRegsData);

   tic_fpaTemperatureVeryDifferent = 0;

   PRINT("Acquisition started!\n");
}


/**
 * Update exposure time.
 * When gFrameRateChangePostponed = 1, new ETx isn't send immediately to the VHD (This measure was needed to prevent sending an invalid config to SCD proxy).
 */
void SCD_UpdatePostponedExposureTimeChange()
{
   #ifdef SCD_PROXY
      extern t_ExposureTime gExposureTime;
      extern float FWExposureTime[MAX_NUM_FILTER];
      uint8_t i;

      EXP_SendConfigGC(&gExposureTime, &gcRegsData);
      if (GC_FWSynchronouslyRotatingModeIsActive)
      {
         for (i = 0; i < NUM_OF(FWExposureTime); i++)
         {
            SFW_SetExposureTimeArray(i, FWExposureTime[i]);
         }
      }
   #endif
}

/**
 * Configure SCD proxy with FRmin to make valid all combination of ET, Height.
 */
void SCD_SetRelaxMode()
{
   /* This function should only be called when acquisition is stopped and we are in xtra trig mode after the XTRA_TRIG_MODE_DELAY has elapsed.
    * The call of FPA_SendConfigGC() is also used to generate the prog trig necessary to get the last frame in IWR (This is required when current trig frequency is << SCD_XTRA_TRIG_FREQ_MAX_HZ).
   */

   #ifdef SCD_PROXY

      float frameRateBackup;
      extern t_FpaIntf gFpaIntf;
      extern float gFpaPeriodMinMargin;

      frameRateBackup = gcRegsData.AcquisitionFrameRate;
      gcRegsData.AcquisitionFrameRate = SCD_MIN_OPER_FPS*(1.0F - gFpaPeriodMinMargin);
      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
      gcRegsData.AcquisitionFrameRate = frameRateBackup;

   #endif
}

/**
 * Acquisition state machine.
 
\dot
digraph G {
   ACQ_INIT -> ACQ_WAITING_FOR_DDC_READY
   ACQ_WAITING_FOR_DDC_READY -> ACQ_STOPPED
   ACQ_WAITING_FOR_DDC_READY -> ACQ_WAITING_FOR_SENSOR_READY
   ACQ_WAITING_FOR_SENSOR_READY -> ACQ_FPA_COOLDOWN
   ACQ_FPA_COOLDOWN -> ACQ_STOPPED [label="Sensor temp. stabilized"]
   ACQ_STOPPED -> ACQ_WAITING_FOR_SENSOR [label="AcquisitionArm"]
   ACQ_WAITING_FOR_SENSOR -> ACQ_SENSOR_READY [label="1s"]
   ACQ_SENSOR_READY -> ACQ_STARTED [label="AcquisitionStart"]
   ACQ_STARTED -> ACQ_STOPPED [label="AcquisitionStop, AcquisitionArm"]
   ACQ_SENSOR_READY -> ACQ_STOPPED [label="AcquisitionStop"]
}
\enddot

 */
void Acquisition_SM()
{
   extern t_FpaIntf gFpaIntf;
   extern flashDynamicValues_t gFlashDynamicValues;
   extern t_Trig gTrig;
   extern t_FB gFB_ctrl;


   #ifdef SCD_PROXY
      extern uint8_t gFrameRateChangePostponed;
      extern t_HderInserter gHderInserter;
      extern uint8_t gWaitingForFilterWheel;
      static timerData_t trig_mode_transition_timer;
   #endif

   static acquisitionState_t acquisitionState = ACQ_STOPPED;
   static uint8_t acquisitionStateTransition = 1;
   static uint8_t startup = 1;

   static uint64_t tic_delay;
   static uint64_t tic_timeout;
   static uint64_t tic_fpaInitTimeout;

   // Cooldown static variables
   static int16_t initial_temp;
   static uint64_t tic_cooldownStability;
   static uint64_t tic_cooldownSampling;
   static uint64_t tic_cooldownStart;
   static int16_t min_temp;
   static int16_t max_temp;

   acquisitionState_t prevAcquisitionState = acquisitionState;
   int16_t sensorTemp;
   int16_t cooldownTempTarget;
   t_FpaStatus fpaStatus;

   switch (acquisitionState)
   {
      case ACQ_STOPPED:
         if (gcRegsData.AcquisitionStop)
         {
            // Ignore Acquisition Stop command
            GC_SetAcquisitionStop(0);
         }

         TDCStatusClr(AcquisitionStartedMask);

         if (acquisitionStateTransition == 1)
         {
            GC_UpdateParameterLimits();
         }

         if (gAcquisitionTurnOn)
         {
            gAcquisitionTurnOn = 0;

            builtInTests[BITID_SensorControllerInitialization].result = BITR_Pending;
            builtInTests[BITID_SensorControllerDetection].result = BITR_Pending;
            builtInTests[BITID_CoolerVoltageVerification].result = BITR_Pending;
            builtInTests[BITID_CoolerCurrentVerification].result = BITR_Pending;
            builtInTests[BITID_Cooldown].result = BITR_Pending;
            builtInTests[BITID_SensorInitialization].result = BITR_Pending;

            Power_TurnOn(PC_ADC_DDC);
            FPA_Init(&fpaStatus, &gFpaIntf, &gcRegsData);
            builtInTests[BITID_SensorControllerInitialization].result = BITR_Passed;

            GETTIME(&tic_timeout);
            GETTIME(&tic_fpaInitTimeout);
            GETTIME(&tic_delay);
            ACQ_INF("Waiting for ADC or DDC to be ready...");
            acquisitionState = ACQ_WAITING_FOR_ADC_DDC_PRESENCE;
         }
         else if (gAcquisitionTurnOff)
         {
            gAcquisitionTurnOff = 0;

            builtInTests[BITID_SensorControllerInitialization].result = BITR_Pending;
            builtInTests[BITID_SensorControllerDetection].result = BITR_NotApplicable;
            builtInTests[BITID_CoolerVoltageVerification].result = BITR_NotApplicable;
            builtInTests[BITID_CoolerCurrentVerification].result = BITR_Pending;
            builtInTests[BITID_Cooldown].result = BITR_NotApplicable;
            builtInTests[BITID_SensorInitialization].result = BITR_NotApplicable;

            GETTIME(&tic_timeout);
            ACQ_INF("Waiting for global done...");
            acquisitionState = ACQ_WAITING_FOR_GLOBAL_DONE;
         }
         else
         {
            if (gcRegsData.AcquisitionStart)
            {
               GC_SetAcquisitionArm(1);
            }

            if (gcRegsData.AcquisitionArm)
            {
               GC_SetAcquisitionArm(0);

               if (GC_DeviceRegistersVerification() == IRC_SUCCESS && !BM_MemoryBufferRead)
               {
                  Acquisition_Arm();

                  GETTIME(&tic_delay);
                  TDCStatusSet(WaitingForSensorMask);
                  acquisitionState = ACQ_WAITING_FOR_SENSOR_READY;
               }
               else if (gcRegsData.AcquisitionStart)
               {
                  // Abort acquisition start command
                  GC_SetAcquisitionStart(0);
               }
            }
         }
         break;

      case ACQ_WAITING_FOR_SENSOR_READY:
         if (elapsed_time_us(tic_delay) >= WAITING_FOR_SENSOR_DELAY_US)
         {
            TDCStatusClr(WaitingForSensorMask);

            PRINT("Sensor ready!\n");
            acquisitionState = ACQ_SENSOR_READY;
         }
         break;

      case ACQ_SENSOR_READY:
         if (gcRegsData.AcquisitionStart && FB_isFrameBufferReady(&gFB_ctrl))
         {
            GC_SetAcquisitionStart(0);

            // Update WaitingForValidParameters flag
            GC_DeviceRegistersVerification();

            if (AllowAcquisitionStart() || actualisationAcqStartReady())
            {
               Acquisition_Start();
               acquisitionState = ACQ_STARTED;
            }
         }
         if (gcRegsData.AcquisitionStop)
         {
            TRIG_ChangeAcqWindow(&gTrig, TRIG_ExtraTrig, &gcRegsData);


            #ifdef SCD_PROXY
               StartTimer(&trig_mode_transition_timer, ((float)XTRA_TRIG_MODE_DELAY)/1000.0F);
               acquisitionState = ACQ_WAIT_SCD_TRIG_MODE_TRANSITION;
            #else
               GC_SetAcquisitionStop(0);
               TDCStatusSet(WaitingForArmMask);
               PRINT("Acquisition stopped!\n");
               acquisitionState = ACQ_STOPPED;
            #endif

         }
         break;

      case ACQ_STARTED:
         if (gcRegsData.AcquisitionArm)
         {
            // Stop acquisition before re-arming the camera
            GC_SetAcquisitionStop(1);
         }

         if (gcRegsData.AcquisitionStop)
         {
            TRIG_ChangeAcqWindow(&gTrig, TRIG_ExtraTrig,  &gcRegsData);

            #ifdef SCD_PROXY
               StartTimer(&trig_mode_transition_timer, ((float)XTRA_TRIG_MODE_DELAY)/1000.0F);
               acquisitionState = ACQ_WAIT_SCD_TRIG_MODE_TRANSITION;
            #else
               GC_SetAcquisitionStop(0);
               TDCStatusSet(WaitingForArmMask);
               PRINT("Acquisition stopped!\n");
               acquisitionState = ACQ_STOPPED;
            #endif
         }
         else
         {
            TDCStatusSet(AcquisitionStartedMask);

            if (acquisitionStateTransition == 1)
            {
               GC_UpdateParameterLimits();
            }

            #ifdef SCD_PROXY
               if(gFrameRateChangePostponed)
               {
                  TRIG_ChangeAcqWindow(&gTrig, TRIG_ExtraTrig,  &gcRegsData);
                  StartTimer(&trig_mode_transition_timer, ((float)XTRA_TRIG_MODE_DELAY)/1000.0F);
                  acquisitionState = ACQ_WAIT_SCD_TRIG_MODE_TRANSITION;
               }
            #endif
         }
         break;

      case ACQ_WAITING_FOR_ADC_DDC_PRESENCE:
         FPA_GetStatus(&fpaStatus, &gFpaIntf);
         if (fpaStatus.adc_ddc_detect_process_done == 1)
         {
            if (elapsed_time_us(tic_delay) >= WAITING_FOR_ADC_DDC_SENSOR_DELAY_US) // la carte ADC requiert un peu de temps pour démarrer
            {
               if (fpaStatus.adc_ddc_present == 1)
               {
                  builtInTests[BITID_SensorControllerDetection].result = BITR_Passed;
                  ACQ_INF("ADC or DDC detected in %dms.", elapsed_time_us(tic_timeout) / 1000);
                  GETTIME(&tic_timeout);
                  ACQ_INF("Waiting for cooler voltage to be available...");
                  acquisitionState = ACQ_WAITING_FOR_COOLER_VOLTAGE;
               }
               else
               {
                  builtInTests[BITID_SensorControllerDetection].result = BITR_Failed;
                  ACQ_ERR("No ADC or DDC detected.");
                  acquisitionState = ACQ_POWER_RESET;
               }
            }
         }
         else if (elapsed_time_us(tic_timeout) > WAITING_FOR_ADC_DDC_PRESENCE_TIMEOUT_US)
         {
            builtInTests[BITID_SensorControllerDetection].result = BITR_Failed;
            ACQ_ERR("ADC or DDC presence detection timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;

      case ACQ_WAITING_FOR_COOLER_VOLTAGE:
         if (extAdcChannels[XEC_COOLER_SENSE].isValid)
         {
               // Turn on the cooler
            if (Power_TurnOn(PC_COOLER) == CPS_ON)
            {
               ACQ_INF("Cooler voltage available in %dms.", elapsed_time_us(tic_timeout) / 1000);
               extAdcChannels[XEC_COOLER_CUR].isValid = 0;
               GETTIME(&tic_timeout);
               ACQ_INF("Waiting for cooler power on...");
               acquisitionState = ACQ_WAITING_FOR_COOLER_POWER_ON;
            }
            else
            {
               ACQ_ERR("Cooler cannot be turned on.");
               acquisitionState = ACQ_POWER_RESET;
            }
         }
         else if (elapsed_time_us(tic_timeout) > WAITING_FOR_COOLER_VOLTAGE_TIMEOUT_US)
         {
            ACQ_ERR("Cooler voltage detection timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;

      case ACQ_WAITING_FOR_COOLER_POWER_ON:
         FPA_GetStatus(&fpaStatus, &gFpaIntf);         
         if ((extAdcChannels[XEC_COOLER_CUR].isValid) &&
               (*(extAdcChannels[XEC_COOLER_CUR].p_physical) >= (float)fpaStatus.cooler_on_curr_min_mA / 1000.0F))
         {
            builtInTests[BITID_CoolerCurrentVerification].result = BITR_Passed;
            ACQ_INF("Cooler powered on in %dms.", elapsed_time_us(tic_timeout) / 1000);

            // Update DeviceCoolerPowerOnCycles
            gFlashDynamicValues.DeviceCoolerPowerOnCycles++;

            if (FlashDynamicValues_Update(&gFlashDynamicValues) != IRC_SUCCESS)
            {
               ACQ_ERR("Failed to update flash dynamic values.");
            }

            GETTIME(&tic_timeout);
            ACQ_INF("Waiting for sensor temperature to be available...");
            acquisitionState = ACQ_WAITING_FOR_SENSOR_TEMP;
         }
         else if (elapsed_time_us(tic_timeout) > WAITING_FOR_COOLER_POWER_ON_TIMEOUT_US)
         {
            builtInTests[BITID_CoolerCurrentVerification].result = BITR_Failed;
            ACQ_ERR("Cooler power on timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;
         
      case ACQ_WAITING_FOR_SENSOR_TEMP:
            sensorTemp = FPA_GetTemperature(&gFpaIntf);

         #ifdef SIM
         sensorTemp = FPA_COOLER_TEMP_THRES - 100;
         #endif

         if (sensorTemp != FPA_INVALID_TEMP)
         {

            ACQ_INF("Sensor temperature available in %dms.", elapsed_time_us(tic_timeout) / 1000);

            GETTIME(&tic_cooldownStart);
            GETTIME(&tic_cooldownStability);
            tic_cooldownSampling = 0;
            initial_temp = sensorTemp;
            min_temp = sensorTemp;
            max_temp = sensorTemp;

            acquisitionState = ACQ_WAITING_FOR_SENSOR_COOLDOWN;
         }
         else if (elapsed_time_us(tic_timeout) > WAITING_FOR_SENSOR_TEMP_TIMEOUT_US)
         {
            builtInTests[BITID_Cooldown].result = BITR_Failed;
            ACQ_ERR("Sensor temperature timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;

      case ACQ_WAITING_FOR_SENSOR_COOLDOWN:
         if (( uint32_t) elapsed_time_us(tic_cooldownSampling) > COOLDOWN_SAMPLING_PERIOD_US)
         {
            sensorTemp = FPA_GetTemperature(&gFpaIntf);

            #ifdef SIM
            sensorTemp = cooldownTempTarget - 100;
            #endif

            if (sensorTemp == FPA_INVALID_TEMP)
            {
               ACQ_ERR("Invalid FPA temperature during cooldown period.");

               // Reset stability period.
               GETTIME(&tic_cooldownStability);
            }
            else
            {
               // Set sensor cooldown temperature target
               if (calibrationInfo.isValid)
               {
                  cooldownTempTarget = (int16_t)calibrationInfo.collection.DeviceTemperatureSensor;
               }
               else
               {
                  cooldownTempTarget = FPA_COOLER_TEMP_THRES;
               }

               ACQ_INF("Cooling down from %dcC to %dcC...", sensorTemp, cooldownTempTarget);

               // Update minimum and maximum temperature
               if (sensorTemp < min_temp) min_temp = sensorTemp;
               if (sensorTemp > max_temp) max_temp = sensorTemp;

               // Reset stability variables when delta exceeds tolerance
               if ((max_temp - min_temp) > COOLDOWN_TEMP_TOLERANCE_CC)
               {
                  min_temp = sensorTemp;
                  max_temp = sensorTemp;
                  GETTIME(&tic_cooldownStability);
               }

               // Check if sensor cooldown is done 
                  if ((cooldownTempTarget - FPA_COOLER_TEMP_TOL < sensorTemp) &&
                       (sensorTemp < cooldownTempTarget + FPA_COOLER_TEMP_TOL) &&
                       (elapsed_time_us(tic_cooldownStability) >= COOLDOWN_STABILITY_PERIOD_US))
               {

                  builtInTests[BITID_Cooldown].result = BITR_Passed;
                  ACQ_INF("Cooled down from %dcC to %dcC in %d s.", initial_temp, sensorTemp,
                     ((uint32_t) elapsed_time_us( tic_cooldownStart )) / 1000000);
                  TDCStatusClr(WaitingForCoolerMask);
                  ACQ_INF("Waiting for sensor initialization...");

                     #ifdef SCD_PROXY
                        GETTIME(&tic_fpaInitTimeout);
                        FPA_Specific_Init_SM(&gFpaIntf, &gcRegsData, true);
                        acquisitionState = ACQ_WAIT_SCD_SPECIFIC_INIT_SEQ;
                     #else
                        acquisitionState = ACQ_WAITING_FOR_FPA_INIT;
                     #endif
               }
            }
            GETTIME(&tic_cooldownSampling);
         }
         break;

      case ACQ_WAITING_FOR_FPA_INIT:
         FPA_GetStatus(&fpaStatus, &gFpaIntf);
         if ((fpaStatus.fpa_init_done == 1) && (fpaStatus.fpa_powered == 1))
         {
            if (fpaStatus.fpa_init_success == 1)
            {
               builtInTests[BITID_SensorInitialization].result = BITR_Passed;
               ACQ_INF("Sensor initialized in %dms.", elapsed_time_us(tic_fpaInitTimeout) / 1000);
               acquisitionState = ACQ_FINALIZE_POWER_ON;

               #ifdef SCD_PROXY
                  FPA_EnableSerialExposureTimeCMD(&gFpaIntf, true);
               #endif
            }
            else
            {
               builtInTests[BITID_SensorInitialization].result = BITR_Failed;
               ACQ_ERR("Sensor initialization failed.");
               acquisitionState = ACQ_POWER_RESET;
            }
         }
         else if (elapsed_time_us(tic_fpaInitTimeout) > WAITING_FOR_FPA_INIT_TIMEOUT_US)
         {
            builtInTests[BITID_SensorInitialization].result = BITR_Failed;
            ACQ_ERR("Sensor initialization timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;

      case ACQ_FINALIZE_POWER_ON:
         gAcquisitionPowerState = DPS_PowerOn;
         acquisitionState = ACQ_STOPPED;

         if (startup)
         {
            startup = 0;
            if (gcRegsData.PowerOnAtStartup && gcRegsData.AcquisitionStartAtStartup)
            {
               GC_SetAcquisitionStart(1);
            }
         }
         break;

      case ACQ_WAITING_FOR_GLOBAL_DONE:
         FPA_GetStatus(&fpaStatus, &gFpaIntf);
         if (fpaStatus.global_done == 1)
         {
            ACQ_INF("Global done in %dms.", elapsed_time_us(tic_timeout) / 1000);

            FPA_PowerDown(&gFpaIntf);
            Power_TurnOff(PC_ADC_DDC);
            Power_TurnOff(PC_COOLER);

            extAdcChannels[XEC_COOLER_CUR].isValid = 0;
            GETTIME(&tic_timeout);
            ACQ_INF("Waiting for cooler power off...");
            acquisitionState = ACQ_WAITING_FOR_COOLER_POWER_OFF;
         }
         else if (elapsed_time_us(tic_timeout) > WAITING_FOR_GLOBAL_DONE_TIMEOUT_US)
         {
            builtInTests[BITID_SensorControllerInitialization].result = BITR_Failed;
            ACQ_ERR("Waiting for global done signal timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;

      case ACQ_WAITING_FOR_COOLER_POWER_OFF:
         FPA_GetStatus(&fpaStatus, &gFpaIntf);
         if ((extAdcChannels[XEC_COOLER_CUR].isValid) &&
               (*(extAdcChannels[XEC_COOLER_CUR].p_physical) <= (float)fpaStatus.cooler_off_curr_max_mA / 1000.0F))
         {
            builtInTests[BITID_CoolerCurrentVerification].result = BITR_Passed;
            ACQ_INF("Cooler powered off in %dms.", elapsed_time_us(tic_timeout) / 1000);

            TDCStatusSet(WaitingForCoolerMask);
            FPA_Init(&fpaStatus, &gFpaIntf, &gcRegsData);
            builtInTests[BITID_SensorControllerInitialization].result = BITR_Passed;
            gAcquisitionPowerState = DPS_PowerStandby;
            acquisitionState = ACQ_STOPPED;
         }
         else if (elapsed_time_us(tic_timeout) > WAITING_FOR_COOLER_POWER_OFF_TIMEOUT_US)
         {
            builtInTests[BITID_CoolerCurrentVerification].result = BITR_Failed;
            ACQ_ERR("Waiting for cooler power off timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         break;

      case ACQ_POWER_RESET:
         startup = 0;

         if (builtInTests[BITID_SensorControllerInitialization].result == BITR_Pending) builtInTests[BITID_SensorControllerInitialization].result = BITR_NotApplicable;
         if (builtInTests[BITID_SensorControllerDetection].result == BITR_Pending) builtInTests[BITID_SensorControllerDetection].result = BITR_NotApplicable;
         if (builtInTests[BITID_CoolerVoltageVerification].result == BITR_Pending) builtInTests[BITID_CoolerVoltageVerification].result = BITR_NotApplicable;
         if (builtInTests[BITID_CoolerCurrentVerification].result == BITR_Pending) builtInTests[BITID_CoolerCurrentVerification].result = BITR_NotApplicable;
         if (builtInTests[BITID_Cooldown].result == BITR_Pending) builtInTests[BITID_Cooldown].result = BITR_NotApplicable;
         if (builtInTests[BITID_SensorInitialization].result == BITR_Pending) builtInTests[BITID_SensorInitialization].result = BITR_NotApplicable;

         FPA_PowerDown(&gFpaIntf);
         Power_TurnOff(PC_ADC_DDC);
         Power_TurnOff(PC_COOLER);
         TDCStatusSet(WaitingForCoolerMask);
         FPA_Init(&fpaStatus, &gFpaIntf, &gcRegsData);
         gAcquisitionPowerState = DPS_PowerStandby;
         acquisitionState = ACQ_STOPPED;
         break;

      case ACQ_WAIT_SCD_TRIG_MODE_TRANSITION:
         #ifdef SCD_PROXY
            /* After setting the xtra_trig mode, it is required to observe a delay of
             * at least 1/SCD_XTRA_TRIG_FREQ_MAX_HZ ms before generating a prog_trig.
             * Otherwise the detector VHD module may crash unexpectedly.
             * This mechanism was necessary for PelicanD & HerculeD but is also used for BB1280 & BB1920.
            */
            if(TimedOut(&trig_mode_transition_timer) && !gWaitingForFilterWheel)
            {
               StopTimer(&trig_mode_transition_timer);

               if (gcRegsData.AcquisitionStop)
               {
                  SCD_SetRelaxMode(); // Make valid all ET or Height values and generate the prog trig.
                  GC_SetAcquisitionStop(0);
                  TDCStatusSet(WaitingForArmMask);
                  PRINT("Acquisition stopped!\n");
                  acquisitionState = ACQ_STOPPED;
   }
               else
               {
                  //Frame rate was changed during acquisition.
                  FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
                  gFrameRateChangePostponed = 0;
                  SCD_UpdatePostponedExposureTimeChange();
                  HDER_UpdateAcquisitionFrameRateHeader(&gHderInserter, &gcRegsData); // This action was postpone earlier in GC_AcquisitionFrameRateCallback().
                  TRIG_ChangeFrameRate(&gTrig, &gFpaIntf, &gcRegsData);
                  TRIG_ChangeAcqWindow(&gTrig, TRIG_Normal, &gcRegsData);
                  acquisitionState = ACQ_STARTED;
               }
            }
         #endif
         break;

      case ACQ_WAIT_SCD_SPECIFIC_INIT_SEQ:
         #ifdef SCD_PROXY
         if (FPA_Specific_Init_SM(&gFpaIntf, &gcRegsData, false) == true)
         {
            acquisitionState = ACQ_WAITING_FOR_FPA_INIT;
         }
         else if (elapsed_time_us(tic_fpaInitTimeout) > WAITING_FOR_FPA_INIT_TIMEOUT_US)
         {
            builtInTests[BITID_SensorInitialization].result = BITR_Failed;
            ACQ_ERR("Sensor specific initialization timeout.");
            acquisitionState = ACQ_POWER_RESET;
         }
         #endif
         break;

   }

   if (acquisitionState != prevAcquisitionState)
   {
      acquisitionStateTransition = 1;
   }
   else
   {
      acquisitionStateTransition = 0;
   }
}

