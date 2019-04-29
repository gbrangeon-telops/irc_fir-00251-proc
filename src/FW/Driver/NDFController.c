/*-----------------------------------------------------------------------------
--
-- Author      : Simon Savary
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 22650 $
-- $Author: pcouture $
-- $LastChangedDate: 2018-12-13 15:30:18 -0500 (jeu., 13 d√©c. 2018) $
--
-------------------------------------------------------------------------------
--
-- File        : NDFController.cpp
-- Description : This file offers high-level neutral density filter management functions
--
--
------------------------------------------------------------------------------*/
#include "NDFController.h"

#include "FaulhaberControl.h"
#include "FaulhaberProtocol.h"

#include "hder_inserter.h"
#include "FlashSettings.h"
#include "Timer.h"
#include "utils.h"
#include "GenICam.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "calib.h"

#include <string.h>
#include <stdlib.h>

/*
 * Global variables (only for FW controller)
 */
static uint32_t             NDF_errors = 0;
static bool                 NDF_Reset = false;
static bool                 NDF_Ready = false;
static bool                 NDF_HomingValid = false;
static int32_t              NDF_RequestedTarget;
static bool                 NDF_ModeRequest = false;
static NDF_ControllerMode_t NDF_NewMode;
static int32_t              NDF_NewTarget;
static NDF_ControllerMode_t NDF_currentMode = NDF_STARTUP_MODE;
static bool NDF_rawMode = false;
static int32_t NDF_currentRawPosition = 1000000;

static FH_ctrl_t* FH_instance = 0;

extern t_HderInserter gHderInserter;

static bool NDF_InitialisationMode(bool reset);
static bool NDF_IdleMode(bool reset);
static bool NDF_PositionMode(bool reset, bool newTarget);
static bool NDF_ErrorMode(bool reset);
static void NDF_initPositionLUT();

static timerData_t NDF_modeChangeTimer;
static timerData_t NDF_commTimer;
static timerData_t NDF_moveTimer;

static int32_t NDF_positionsLUT[3];
static uint8_t NDF_numberOfFilters = 3;

static int32_t NDF_minPosition;
static int32_t NDF_maxPosition;
static int32_t NDF_filterWidth;

static bool NDF_initialized = false;

static NDF_config_t NDF_config;

IRC_Status_t NDF_ControllerInit(FH_ctrl_t* instance)
{
   IRC_Status_t status = IRC_SUCCESS;
   NDF_initialized = false;

   if (instance)
      FH_instance = instance;
   else
      status = IRC_FAILURE;

   if (flashSettings.NDFPresent)
      FH_instance->fh_data.id = NDF_NODE_ID;

   NDF_ResetTimers();

   // use default values (might use flash settings one day)
   NDF_config.POR = NDF_POR_GAIN_POSITION;
   NDF_config.I_GAIN = NDF_I_GAIN_POSITION;
   NDF_config.PP = NDF_PP_GAIN_POSITION;
   NDF_config.PD = NDF_PD_GAIN_POSITION;
   NDF_config.maxVelocity = NDF_MAX_SPEED_POSITION;

   NDF_initialized = true;

   return status;
}

static void NDF_initPositionLUT()
{
   int i;
   int fraction;

   NDF_numberOfFilters = 3;
   fraction = NDF_FREE_RANGE / NDF_numberOfFilters;

   // default values first
   for (i=0; i<NDF_numberOfFilters; ++i)
   {
      NDF_positionsLUT[i] = i * fraction;
   }

   NDF_filterWidth = NDF_DEFAULT_FILTER_WIDTH;

   if (FS_FLASHSETTINGS_IS_VALID)
   {
      NDF_numberOfFilters = MIN(3, flashSettings.NDFNumberOfFilters);

      NDF_positionsLUT[0] = flashSettings.NDF0CenterPosition;
      NDF_positionsLUT[1] = flashSettings.NDF1CenterPosition;
      NDF_positionsLUT[2] = flashSettings.NDF2CenterPosition;

      NDF_filterWidth = flashSettings.NDFClearFOVWidth;
   }
}

/*
 * Name         : NDF_ControllerReset
 *
 * Synopsis     : void FWControllerReset()
 * Description  : Reset and variables initialisation
 * 
 */
void NDF_ControllerReset()
{
   NDF_errors = 0;
   NDF_Reset = true;
   NDF_Ready = false;
   NDF_ModeRequest = false;
   //FaulhaberUtilitiesReset();
   NDF_ResetTimers();
}

void NDF_ResetTimers()
{
   StopTimer(&NDF_modeChangeTimer);
   StopTimer(&NDF_commTimer);
   StopTimer(&NDF_moveTimer);
}

/*
 * Name         : ChangeFWControllerMode
 *
 * Synopsis     : void ChangeFWControllerMode(FWControllerModes_t newMode, int32_t target)
 * Arguments    : FWControllerModes_t  newMode : mode to change to
 *                int32_t  target : position or velocity target
 *
 * Description  : Change the mode of the FW controller with a target in position or velocity
 * 
 */
void ChangeNDFControllerMode(NDF_ControllerMode_t newMode, int32_t target)
{
   NDF_NewMode = newMode;
   NDF_NewTarget = target;
   NDF_ModeRequest = true;
   NDF_Ready = false;
}

/*
 * Name         : FWControllerProcess
 *
 * Synopsis     : void FWControllerProcess()
 * Description  : High-level state machine for the filter wheel
 * 
 */
void NDF_ControllerProcess()
{
   extern t_calib gCal;

   static NDF_ControllerMode_t currentMode = NDF_STARTUP_MODE;
   static NDF_ControllerMode_t lastMode = NDF_STARTUP_MODE;
   static bool NDF_newModeAvailable = false;
   static NDF_ControllerMode_t newMode;
   static int32_t newTarget;
   static bool modeReady = false;
   bool modeChanged = false;
   bool targetChanged = false;
   static int numRetryErrorMode = 0;

   static int32_t prevPosition = 100000000;

   if (NDF_Reset || NDF_initialized == false)
   {
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;
      currentMode = NDF_STARTUP_MODE;
      lastMode = NDF_STARTUP_MODE;
      NDF_newModeAvailable = false;
      modeReady = false;
      NDF_Reset = false;
      // allow the current setpoint be applied immediately at the end of the homing sequence
      NDF_getFilterPosition(gcRegsData.NDFilterPositionSetpoint, &newTarget);
      numRetryErrorMode = 0;
   }
   if (NDF_ModeRequest && !NDF_newModeAvailable)
   {
      NDF_newModeAvailable = true;
      newMode = NDF_NewMode;
      newTarget = NDF_NewTarget;
      NDF_ModeRequest = false;
   }

   //////////////////////////////////////////////////////////////////////////////////
   // Change state conditions state machine
   //////////////////////////////////////////////////////////////////////////////////
   switch(currentMode)
   {
   case NDF_STARTUP_MODE:
      if (!flashSettings.NDFPresent)
         currentMode = NDF_DISABLED_MODE;
      else
      {
         currentMode = NDF_INIT_MODE;
         FH_instance->fh_data.id = NDF_NODE_ID; // to pas ideal, repenser le mÈcanisme
      }

      break;

   case NDF_INIT_MODE:
      if (modeReady)
      {  // Goto to Idle when Init is done
         currentMode = NDF_IDLE_MODE;
      }
      // Always go in Error mode if FAULHABER controller doesn't respond after too many retries
      if (NDF_GetErrors(NDF_ERR_ALL))
      {
         currentMode = NDF_ERROR_MODE;
      }
      break;

   case NDF_IDLE_MODE:
      if (modeReady)
      {  // Exit Idle mode when a new mode request is received
         if (NDF_newModeAvailable)
         {
            NDF_newModeAvailable = false;
            if(newMode != NDF_IDLE_MODE)
            {
               NDF_RequestedTarget = newTarget;
               currentMode = newMode;
            }
         }
      }
      break;

   case NDF_POSITION_MODE:
      if (modeReady)
      {
         if (NDF_newModeAvailable)
         {  // Don't go back to IDLE mode if new mode is the same!
            if (newMode == currentMode)
            {
               NDF_newModeAvailable = false;
               // Update target if necessary
               if(newTarget != NDF_RequestedTarget)
               {
                  NDF_RequestedTarget = newTarget;
                  targetChanged = true;
               }
            }
            else
            {  // Change to transitory state (idle)
               currentMode = NDF_IDLE_MODE;
               NDF_PRINTF("Going To Idle_Mode\n");
            }
         }
      }
      break;

   case NDF_ERROR_MODE:
      if (modeReady)
      {  // Return to initialisation when error mode is cleared
         currentMode = NDF_STARTUP_MODE;
         NDF_PRINTF("NDF_ERROR_MODE: returning to NDF_STARTUP_MODE\n");
         ++numRetryErrorMode;
      }
      /*else if (numRetryErrorMode >= NDF_ERROR_MODE_MAX_RETRY)
         {
            NDF_ERR("Abandoning after %d retries.", NDF_ERROR_MODE_MAX_RETRY);
            currentMode = NDF_DISABLED_MODE;
         }*/



      break;

   case NDF_DISABLED_MODE:
      // this mode is reached when no NDF is present (NDFP_NDFilterNotImplemented)
      break;

   default:
      currentMode = NDF_STARTUP_MODE;
      break;
   }

   // Update last cycle memory
   modeChanged = (currentMode != lastMode);
   lastMode = currentMode;

   // Set NDF_HomingValid to false and it can be changed if the currentMode is NDF_POSITION_MODE
   NDF_HomingValid = false;

   //////////////////////////////////////////////////////////////////////////////////
   // Output of the state machine : Processing to be done in each state
   //////////////////////////////////////////////////////////////////////////////////
   switch(currentMode)
   {
   case NDF_STARTUP_MODE:
      FH_consumeResponses(FH_instance);
      NDF_Ready = false;
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;

      break;

   case NDF_INIT_MODE:
      modeReady = NDF_InitialisationMode(modeChanged);
      NDF_Ready = false;
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;

      break;

   case NDF_IDLE_MODE:
      modeReady = NDF_IdleMode(modeChanged);
      NDF_Ready = modeReady && !NDF_ModeRequest & !NDF_newModeAvailable;
      numRetryErrorMode = 0;
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;

      break;

   case NDF_POSITION_MODE:
      modeReady = NDF_PositionMode(modeChanged, targetChanged);
      NDF_HomingValid = modeReady;
      NDF_Ready = modeReady && !NDF_ModeRequest;

      break;

   case NDF_ERROR_MODE:
      modeReady = NDF_ErrorMode(modeChanged);
      NDF_Ready = modeReady;
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;
      break;

   case NDF_DISABLED_MODE:
      gcRegsData.NDFilterPosition = NDFP_NDFilterNotImplemented;
      NDF_Ready = false;
      break;

   default:
      break;
   }

   if (currentMode == NDF_DISABLED_MODE)
      gcRegsData.NDFilterPosition = NDFP_NDFilterNotImplemented;
   else if (currentMode != NDF_POSITION_MODE)
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;

   if (NDF_rawMode)
      gcRegsData.NDFilterPosition = NDFP_NDFilterInTransition;

   // raw mode does not set the TDCStatus
   if (!NDF_rawMode && gcRegsData.NDFilterPosition == NDFP_NDFilterInTransition)
      TDCStatusSet(WaitingForNDFilterMask);
   else
      TDCStatusClr(WaitingForNDFilterMask);

   // transmit the new position upon a change
   if ( (!NDF_rawMode && prevPosition != gcRegsData.NDFilterPosition)
         || (NDF_rawMode && prevPosition != gcRegsData.NDFilterPositionRaw))
   {
      if (!NDF_rawMode)
      {
         HDER_UpdateNDFPositionHeader(&gHderInserter, gcRegsData.NDFilterPosition);
         prevPosition = gcRegsData.NDFilterPosition;

         // Change calibration block
         if (calibrationInfo.isValid && GC_CalibrationIsActive &&    // Not in RAW or RAW0
               ((calibrationInfo.collection.CollectionType == CCT_TelopsNDF) || (calibrationInfo.collection.CollectionType == CCT_MultipointNDF)) && // NDF Collection
               (calibrationInfo.blocks[gCal.calib_block_sel_mode - CBSM_USER_SEL_0].NDFPosition != gcRegsData.NDFilterPositionSetpoint))  // Block NDF Position changed
         {
            CAL_UpdateCalibBlockSelMode(&gCal, &gcRegsData);
         }

      }
      else
      {
         HDER_UpdateNDFPositionHeader(&gHderInserter, abs(gcRegsData.NDFilterPositionRaw) % 256);
         HDER_UpdateFWPositionHeader(&gHderInserter, abs(gcRegsData.NDFilterPositionRaw)/256);
         prevPosition = gcRegsData.NDFilterPositionRaw;
      }

      NDF_INF("Updating NDFPosition in header (%d) (RawMode is %s)", gcRegsData.NDFilterPosition, NDF_rawMode?"on":"off");
   }

   NDF_currentMode = currentMode;
}

/*
 * Name         : IsNDFControllerReady
 *
 * Synopsis     : uint32_t IsNDFControllerReady()
 * Description  : Check if the FW is ready to accept a new command
 * 
 * Returns      : bool : false -> not ready, true -> Ready
 */
bool IsNDFControllerReady()
{
   return NDF_Ready;
}

/*
 * Name         : getFWControllerModes
 *
 * Synopsis     : FWControllerModes_t getFWControllerModes()
 * Description  : Return the current mode of FW
 * 
 * Returns      : FWControllerModes_t : state of the Controller
 */
NDF_ControllerMode_t getNDFControllerMode()
{
   return NDF_currentMode;
}

/*
 * Name         : IsFWHomingValid
 *
 * Synopsis     : bool IsFWHomingValid()
 * Description  : Return NDF_HomingValid;
 * 
 * Returns      : bool : false -> homing is not valid, true homing is valid
 */
bool IsNDFHomingValid()
{
   return NDF_HomingValid;
}

/*
 * Internal mode functions
 */
/*
 * Name         : FWInitialisationMode
 *
 * Synopsis     : bool FWInitialisationMode(bool reset)
 * Arguments    : bool  reset : signal to reset state machine
 *
 * Description  : Clear fault and error
 * 
 * Returns      : bool : false -> not done or failure, true -> success
 */
static bool NDF_InitialisationMode(bool reset)
{
   static NDF_initialisationMode_t state = NIM_INIT_TIMEOUTSETUP_MODE;
   int numAck;
   bool done = false;
   static uint8_t phase = 0; // used during the homing phase
   static uint32_t rpm = 0; // homing speed
   static int32_t prevRawPosition = 1000000;

   if(reset)
   {
      state = NIM_INIT_TIMEOUTSETUP_MODE;
      StopTimer(&NDF_modeChangeTimer);
      FH_consumeResponses(FH_instance);
   }

   switch(state)
   {
   case NIM_INIT_TIMEOUTSETUP_MODE:
      StartTimer(&NDF_modeChangeTimer, NDF_INIT_TIMEOUT);

      NDF_initPositionLUT();
      phase = 0;
      rpm = 0;

      state = NIM_DISABLE_LIMITS;//INIT_SET_GAIN;

      break;

   /*case NIM_SET_GAIN:
      StopTimer(&NDF_commTimer);
      if (setControllerGain(FH_instance, NDF_config.POR, NDF_config.I_GAIN, NDF_config.PP, NDF_config.PD, NDF_config.maxVelocity))
      {
         StartTimer(&NDF_commTimer, FAULHABER_INIT_TIMEOUT);
         initMode = NIM_WAIT_SET_GAIN;
      }
      break;

   case NIM_WAIT_SET_GAIN:

      numAck = FH_readAcks(FH_instance);
      FH_clearAcks(FH_instance, numAck);

      if (FH_numExpectedAcks(FH_instance) == 0)
      {
         StopTimer(&NDF_commTimer);
         NDF_ClearErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);

         initMode = NIM_ENABLEMOTOR;
         NDF_PRINTF("NIM_INIT_ENABLEMOTOR_MODE\n");
      }
      else if (TimedOut(&NDF_commTimer))
      {
         NDF_SetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         NDF_ERR("Timeout during NIM_INIT_WAIT_SET_GAIN (no ACK).");
         initMode = NIM_DONE;
         StopTimer(&NDF_commTimer);
      }

      break;*/

   case NIM_DISABLE_LIMITS:
      StopTimer(&NDF_commTimer);
      if (setEnablePositionLimits(FH_instance, false))
      {
         StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
         state = NIM_INIT_HOMING;
      }
      break;

   case NIM_INIT_HOMING:
      StopTimer(&NDF_commTimer);
      if (setCurrentLimits(FH_instance, NDF_HOMING_MAX_PEAK_CURRENT, NDF_HOMING_MAX_CONT_CURRENT))
      {
         StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
         state = NIM_ENABLE_DRIVE;
      }
      break;

   case NIM_ENABLE_DRIVE:
      StopTimer(&NDF_commTimer);
      if (setEnableDrive(FH_instance, true))
      {
         StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
         state = NIM_WAIT_ACK;
      }
      break;

   case NIM_WAIT_ACK:
      numAck = FH_readAcks(FH_instance);
      FH_clearAcks(FH_instance, numAck);

      if (FH_numExpectedAcks(FH_instance) == 0)
      {
         StopTimer(&NDF_commTimer);
         NDF_ClearErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         //NDF_PRINTF("NIM_INIT_HOME_SEQ\n");
         NDF_PRINTF("NIM_HOME_SEQ\n");
         state = NIM_HOME_SEQ;
      }
      else if (TimedOut(&NDF_commTimer))
      {
         NDF_SetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         NDF_ERR("Timeout during NIM_INIT_WAIT_ACK_MODE");
         state = NIM_DONE;
      }
      break;

   case NIM_HOME_SEQ:
      {
         StopTimer(&NDF_commTimer);
         //StopTimer(&NDF_moveTimer);

         if (phase > 2) // homing completed
         {
            state = NIM_SET_CURRENT_LIMITS;
            NDF_PRINTF("NIM_SET_CURRENT_LIMITS\n");
         }
         else if (setVelocityWithoutNotification(FH_instance, rpm))
         {
            StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
            state = NIM_HOME_WAIT_ACK;
         }
      }
      break;

   case NIM_HOME_WAIT_ACK:
      numAck = FH_readAcks(FH_instance);
      FH_clearAcks(FH_instance, numAck);

      if (FH_numExpectedAcks(FH_instance) == 0)
      {
         StopTimer(&NDF_commTimer);
         NDF_ClearErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         StartTimer(&NDF_moveTimer, 2000);
         state = NIM_WAIT_STATE;
         NDF_PRINTF("NIM_WAIT_STATE\n");
      }
      else if (TimedOut(&NDF_commTimer))
      {
         NDF_SetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         NDF_ERR("Timeout during homing sequence (no ACK).");
         state = NIM_DONE;
         setVelocityWithoutNotification(FH_instance, 0);
      }

      break;

   case NIM_WAIT_STATE:
      if (TimedOut(&NDF_moveTimer))
      {
         state = NIM_HOME_QUERY_POS;
         NDF_PRINTF("NIM_HOME_QUERY_POS\n");
      }
      break;

   case NIM_HOME_QUERY_POS:
      StopTimer(&NDF_commTimer);
      if (queryPosition(FH_instance))
      {
         StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
         state = NIM_HOME_WAIT_QUERY_POS;
      }

      break;

   case NIM_HOME_WAIT_QUERY_POS:
      numAck = FH_readAcks(FH_instance);
      FH_clearAcks(FH_instance, numAck);

      if (FH_numExpectedAcks(FH_instance) == 0)
      {
         int32_t value;

         if (FH_readValue(FH_instance, &value))
         {
            StopTimer(&NDF_commTimer);
            NDF_ClearErrors(NDF_ERR_FAULHABER_RESP_TIMEOUT);

            NDF_INF("Current/previous position : %d, %d", value, prevRawPosition);

            // first postion reading OR we found a mechanical limit switch
            if (phase == 0 || abs(prevRawPosition - value) < NDF_HOMING_TOL)
            {
               if (phase == 1)
               {
                  NDF_minPosition = value;
                  NDF_PRINTF("NDF_minPosition = %d\n", NDF_minPosition);
               }
               else if (phase == 2)
               {
                  NDF_maxPosition = value;
                  NDF_PRINTF("NDF_maxPosition = %d\n", NDF_maxPosition);
               }

               state = NIM_STOP;
               NDF_PRINTF("NIM_STOP\n");
            }
            else
            {
               // too far from home, retry
               state = NIM_HOME_QUERY_POS;
               NDF_PRINTF("NIM_HOME_QUERY_POS\n");
            }
            prevRawPosition = value;
         }
         else if (TimedOut(&NDF_commTimer))
         {
            NDF_SetErrors(NDF_ERR_FAULHABER_RESP_TIMEOUT);
            NDF_ERR("Timeout during NIM_INIT_HOME_QUERY_POS_MODE (requested value not returned).");
            state = NIM_DONE;
         }
      }
      else if (TimedOut(&NDF_commTimer))
      {
         NDF_SetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         NDF_ERR("Timeout during NIM_INIT_HOME_QUERY_POS_MODE (no ACK).");
         state = NIM_DONE;
         StopTimer(&NDF_commTimer);
      }
      break;

      case NIM_STOP:
         StopTimer(&NDF_commTimer);
         if (setEnableDrive(FH_instance, false))
         {
            StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
            state = NIM_STOP_WAIT_ACK;
         }

         break;

      case NIM_STOP_WAIT_ACK:
            numAck = FH_readAcks(FH_instance);
            FH_clearAcks(FH_instance, numAck);

            if (FH_numExpectedAcks(FH_instance) == 0)
            {
               StopTimer(&NDF_commTimer);
               NDF_ClearErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);

               ++phase;
               int sign = phase == 1 ? -1 : 1;
               rpm = sign * NDF_HOMING_SPEED;

               state = NIM_ENABLE_DRIVE;
               NDF_PRINTF("NIM_ENABLE_DRIVE (phase %d)\n", phase);
            }
            else if (TimedOut(&NDF_commTimer))
            {
               NDF_SetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
               NDF_ERR("Timeout during NIM_STOP_WAIT_ACK");
               state = NIM_DONE;
            }
            break;

      case NIM_SET_CURRENT_LIMITS:

         if (setCurrentLimits(FH_instance, NDF_MAX_PEAK_CURRENT, NDF_MAX_CONT_CURRENT))
         {
            StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
            state = NIM_CONFIG_HOME;
            NDF_PRINTF("NIM_CONFIG_HOME\n");
         }

         break;

      case NIM_CONFIG_HOME:
      {
         int initialPosition, pmin, pmax, range;

         range = abs(NDF_maxPosition - NDF_minPosition);

         if (NDF_maxPosition < NDF_minPosition)
         {
            int32_t tmp = NDF_minPosition;
            NDF_minPosition = NDF_maxPosition;
            NDF_maxPosition = tmp;
            initialPosition = -NDF_POS_LIMIT_DIST;
         }
         else
         {
            initialPosition = range - NDF_POS_LIMIT_DIST;
         }
         pmin = -NDF_POS_LIMIT_DIST/2;
         pmax = -NDF_POS_LIMIT_DIST + range - NDF_POS_LIMIT_DIST/2;
         NDF_PRINTF("range = %d, initialPosition = %d, pmin = %d, pmax = %d\n", range, initialPosition, pmin, pmax);

         if (configurePositionLimits(FH_instance, initialPosition, pmin, pmax))
         {
            StartTimer(&NDF_moveTimer, NDF_POSITION_TIMEOUT);
            StartTimer(&NDF_commTimer, FH_REQUEST_TIMEOUT);
            state = NIM_CONFIG_HOME_WAIT_ACK;
            NDF_PRINTF("NIM_CONFIG_HOME_WAIT_ACK\n");
         }
      }
      break;

      case NIM_CONFIG_HOME_WAIT_ACK:

         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&NDF_commTimer);
            NDF_ClearErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
            StartTimer(&NDF_moveTimer, NDF_POSITION_TIMEOUT);
            /*NDF_PRINTF("NIM_CONFIG_HOME_WAIT\n");
            state = NIM_CONFIG_HOME_WAIT;*/
            NDF_PRINTF("NIM_DONE\n");
            state = NIM_DONE;
         }
         else if (TimedOut(&NDF_commTimer))
         {
            NDF_SetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
            NDF_ERR("Time out while in NIM_CONFIG_HOME_WAIT_ACK");
            StopTimer(&NDF_commTimer);
            state = NIM_DONE;
         }
         break;

      case NIM_CONFIG_HOME_WAIT:
      {
         char notif;
         if (FH_readNotification(FH_instance, (uint8_t*)&notif) && notif == FH_P)
         {
            StopTimer(&NDF_moveTimer);
            NDF_ClearErrors(NDF_ERR_FAULHABER_HOME_TIMEOUT);
            NDF_PRINTF("NIM_DONE\n");
            state = NIM_DONE;
         }
         else if (TimedOut(&NDF_moveTimer))
         {
            StopTimer(&NDF_moveTimer);
            NDF_SetErrors(NDF_ERR_FAULHABER_HOME_TIMEOUT);
            NDF_ERR("Timeout during NIM_CONFIG_HOME_WAIT (no notification received).");
            state = NIM_DONE;
            setVelocityWithoutNotification(FH_instance, 0);
         }

      }
            break;

   case NIM_DONE:
      done = true;
      //setPosition(FH_instance, (NDF_maxPosition + NDF_minPosition)/2, FH_ABSOLUTE);
      break;

   default:
      state = NIM_ENABLE_DRIVE;
      break;
   }

   return done;
}

/*
 * Name         : FWIdleMode
 *
 * Synopsis     : bool FWIdleMode(bool reset)
 * Arguments    : bool  reset : signal to reset the state machine
 *
 * Description  : Stop the wheel and wait until stopped.
 * 
 * Returns      : bool : false -> not stopped or failure, true -> wheel stopped
 */
static bool NDF_IdleMode(bool reset)
{
   // static int32_t prevPosition;
   int32_t counts;
   bool ready = true;
   FH_consumeResponses(FH_instance);

   /*if (ready && prevPosition != NDF_currentRawPosition)
   {
      gcRegsData.NDFilterPosition = NDF_getFilterIndex(NDF_currentRawPosition);
   }*/

   // prevPosition = NDF_currentRawPosition;

   // for now, issue a mode change command and go to the setpoint
   if (NDF_getFilterPosition(gcRegsData.NDFilterPositionSetpoint, &counts))
      ChangeNDFControllerMode(NDF_POSITION_MODE, counts);
   else
      ChangeNDFControllerMode(NDF_POSITION_MODE, NDFPS_NDFilter1);


   return ready;
}


/*
 * Name         : NDFilterPositionMode
 *
 * Synopsis     : bool NDFilterPositionMode(bool reset, bool newTarget)
 * Arguments    : bool  reset : signal to reset state machine (from Rotating to Position)
 *                bool  newTarget : false -> no new position target, true -> new position target
 *
 * Description  : process that manage and applied a new position target
 * 
 * Returns      : bool : false -> position not reached, true -> position reached
 */
static bool NDF_PositionMode(bool reset, bool newTarget)
{
   static NDF_positionMode_t posMode = NPM_INIT;
   bool ready = false;
   static bool nowInTransition = false;
   static bool queryMode = false;
   static bool TransitionOver = true;
   static int32_t protectionModeFinalTarget = -1;
   static uint32_t DestinationSetpoint = NDFP_NDFilterInTransition;

   static int32_t RawPosition[3] = {1000000, 1000000, 1000000};
   static uint8_t RawPositionIndex = 0;

   static uint32_t pollingPeriod_ms = NDF_POS_POLLING_PERIOD;

   uint32_t threshold;
   int numAck;
   char notification;
   static timerData_t transitionTimer, protectionTimer;

   if(reset || newTarget)
   {
      queryMode = false;
      if (reset)
      {
         NDF_PRINTF("NDFPositionMode reset\n");
         posMode = NPM_QUERY_POS;
         StopTimer(&transitionTimer);
         StopTimer(&protectionTimer);
         nowInTransition = false;
         TransitionOver = true;
      }
      else
      {
         if ((posMode == NPM_QUERY_POS) || (posMode == NPM_PAUSE))
         {
            posMode = NPM_NEW_POS;
         }
         else if (posMode == NPM_TIMEOUT)
         {
            posMode = NPM_QUERY_POS;
         }
      }

      StopTimer(&NDF_modeChangeTimer);
      StopTimer(&NDF_commTimer);
   }

   if (newTarget)
   {
      pollingPeriod_ms = NDF_POS_POLLING_PERIOD;
   }

   if (TimedOut(&transitionTimer))
   {
      StopTimer(&transitionTimer);

      // two-step travel to filter 1 (or 3) from filter 3 (or 1)
      if (protectionModeFinalTarget != -1)
      {
         StartTimer(&protectionTimer, NDF_POS_PROTECTION_PERIOD);
      }
      else
      {
         nowInTransition = false;
      }
   }

   if (TimedOut(&protectionTimer))
   {
      StopTimer(&protectionTimer);
      if (protectionModeFinalTarget == -1)
      {
         queryMode = true;
      }
      else
      {
         queryMode = false;
      }
   }

   if (FH_readNotification(FH_instance, (uint8_t*)&notification) && notification == FH_P)
   {
      // if received position notification before move's ACK then pass to query mode
      if (posMode == NPM_NEW_POS_ACK)
         posMode = NPM_QUERY_POS;

      // if waiting of move's ACK timedout then don't restart the timer
      if (transitionTimer.enabled == false)
         StartTimer(&transitionTimer, 40);

      nowInTransition = true;
      DestinationSetpoint = NDF_getFilterIndex(NDF_RequestedTarget, 0);
      TransitionOver = false;
   }

   switch(posMode)
   {
   case NPM_QUERY_POS:
      StopTimer(&NDF_commTimer);
      if (queryPosition(FH_instance))
      {
         StartTimer(&NDF_commTimer, NDF_QUERY_POS_TIMEOUT);
         posMode = NPM_QUERY_POS_WAIT;
      }

      break;

   case NPM_QUERY_POS_WAIT:

      {
         int32_t value;

         if (FH_readValue(FH_instance, &value))
         {
            StopTimer(&NDF_commTimer);
            NDF_ClearErrors(NDF_ERR_FAULHABER_RESP_TIMEOUT);

            // insert position in array
            RawPosition[RawPositionIndex++] = value;
            RawPositionIndex %= NUM_OF(RawPosition);

            NDF_currentRawPosition = medianOf3(RawPosition);

            // reset TransitionOver flag to update header with current position
            if (!nowInTransition && !TransitionOver && (NDF_getFilterIndex(NDF_currentRawPosition, NDF_filterWidth/4) == NDF_getFilterIndex(NDF_RequestedTarget, 0)))
            {
               TransitionOver = true;
               DestinationSetpoint = NDF_getFilterIndex(NDF_RequestedTarget, 0);
            }
			
            if (queryMode)
            {
               // position was queried just for updating the register
               if (abs(NDF_currentRawPosition - NDF_RequestedTarget) < 30) // on peut determiner autrement qu'on est en statique ou en dynamique?
                  pollingPeriod_ms = NDF_POS_POLLING_PERIOD_STATIC;
               else
                  pollingPeriod_ms = NDF_POS_POLLING_PERIOD;

               StartTimer(&NDF_commTimer, pollingPeriod_ms);

               posMode = NPM_PAUSE;
            }
            else
            {
               // position was queried prior to issuing a relative move command
               posMode = NPM_NEW_POS;
            }

         }
         else if (TimedOut(&NDF_commTimer))
         {
            NDF_SetErrors(NDF_ERR_FAULHABER_RESP_TIMEOUT);
            NDF_INF("Timeout in NPM_POSITION_WAIT_QUERY_POS (requested value not returned).");
            posMode = NPM_TIMEOUT;
         }
      }

      break;

   case NPM_PAUSE:
      ready = true;

      if (TimedOut(&NDF_commTimer) || (!queryMode))
      {
         posMode = NPM_QUERY_POS;
         StopTimer(&NDF_commTimer);
      }
      break;

   case NPM_NEW_POS:
      {
         int notificationPosition;

         // decide if we have to travel from 1->3 or 3->1. In that case, protect the filters by going first to position 2, and then to the final destination
         if (protectionModeFinalTarget == -1)
         {
            int32_t current, setpoint;
            threshold = NDF_filterWidth/2;
            setpoint = NDF_getFilterIndex(NDF_RequestedTarget, threshold);
            current = NDF_getFilterIndex(NDF_currentRawPosition, threshold);
            if ((setpoint == NDFP_NDFilter1 && current == NDFP_NDFilter3) || (setpoint == NDFP_NDFilter3 && current == NDFP_NDFilter1))
            {
               NDF_PRINTF("Protection sequence activated\n");
               protectionModeFinalTarget = NDF_RequestedTarget;
               NDF_getFilterPosition(NDFP_NDFilter2, &NDF_RequestedTarget);
            }
         }
         else
         {
            NDF_RequestedTarget = protectionModeFinalTarget;
            protectionModeFinalTarget = -1;
         }

         NDF_PRINTF("NDF: Selecting filter %d\n", NDF_getFilterIndex(NDF_RequestedTarget, NDF_filterWidth/2));

         if (NDF_currentRawPosition < NDF_RequestedTarget)
            notificationPosition = NDF_currentRawPosition + 3*NDF_filterWidth/4;//NDF_RequestedTarget - NDF_filterWidth/2;
         else
            notificationPosition = NDF_currentRawPosition - 3*NDF_filterWidth/4;//NDF_RequestedTarget + NDF_filterWidth/2;

         NDF_INF("New target position: %d counts", NDF_RequestedTarget);

         StopTimer(&NDF_commTimer);

         if (setPositionWithEarlyNotify(FH_instance, NDF_RequestedTarget, notificationPosition, FH_ABSOLUTE))
         {
            NDF_PRINTF("NPM_NEW_POS_ACK\n");

            StartTimer(&NDF_commTimer, NDF_QUERY_MOVE_TIMEOUT);
            posMode = NPM_NEW_POS_ACK;
         }
         else
         {
            // this else clause should never occur in normal conditions...
            NDF_ERR("Setting notification command failed, retrying...\n");
            if (protectionModeFinalTarget != -1)
            {
               NDF_RequestedTarget = protectionModeFinalTarget;
               protectionModeFinalTarget = -1;
            }
         }
      }
      break;

   case NPM_NEW_POS_ACK:
      numAck = FH_readAcks(FH_instance);
      FH_clearAcks(FH_instance, numAck);

      if (FH_numExpectedAcks(FH_instance) == 0)
      {
         StopTimer(&NDF_commTimer);
         NDF_ClearErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT);
         StartTimer(&NDF_commTimer, pollingPeriod_ms);

         queryMode = true;
         posMode = NPM_QUERY_POS; // en polling seulement
      }
      else if (TimedOut(&NDF_commTimer))
      {
         NDF_ERR("didn't received NPM_NEW_POS_ACK, skipping...");

         // Pretend we received ACK and position notification
         FH_consumeResponses(FH_instance);
         StartTimer(&transitionTimer, 38);
         nowInTransition = true;
         DestinationSetpoint = NDF_getFilterIndex(NDF_RequestedTarget, 0);
         TransitionOver = false;
         queryMode = true;
         posMode = NPM_QUERY_POS; // en polling seulement
      }

      break;

   case NPM_TIMEOUT:
      ready = true;
      FH_consumeResponses(FH_instance);
      NDF_ClearErrors(NDF_ERR_ALL);

      posMode = NPM_QUERY_POS;
      break;

   default:
      StopTimer(&transitionTimer);
      nowInTransition = false;
      posMode = NPM_NEW_POS;
      break;
   }

   gcRegsData.NDFilterPositionRaw = NDF_currentRawPosition;

   threshold = 3*NDF_filterWidth/4;

   // If nowInTransition then tag in transition,
   // else TransitionOver allow to tag the header with gcRegsData.NDFilterPositionSetpoint until NDF_currentRawPosition is within the new filter range
   gcRegsData.NDFilterPosition = nowInTransition ? NDFP_NDFilterInTransition : (TransitionOver ? NDF_getFilterIndex(NDF_currentRawPosition, threshold) : DestinationSetpoint);

   return ready;
}

bool NDF_getFilterPosition(uint8_t idx, int32_t* counts)
{
   bool success = false;

   if (counts!=0 && idx >= 0 && idx < NDF_numberOfFilters)
   {
      *counts = NDF_positionsLUT[idx];
      success = true;
   }

   return success;
}

void NDF_setRawPositionMode(bool enable)
{
   NDF_rawMode = enable;
}

uint8_t NDF_getFilterIndex(int32_t counts, uint32_t threshold)
{
   const uint8_t fnames[3] = {NDFP_NDFilter1, NDFP_NDFilter2, NDFP_NDFilter3};
   int i;
   int dist;
   uint8_t p = NDFP_NDFilterInTransition;

   for (i=0; i<NDF_numberOfFilters; ++i)
   {
      dist = NDF_positionsLUT[i] - counts;
      if (abs(dist) <= threshold)
      {
         p = fnames[i];
         break;
      }
   }

   return p;
}

/*
 * Name         : NDF_ErrorMode
 *
 * Synopsis     : bool NDF_ErrorMode(bool reset)
 * Arguments    : bool  reset : signal to reset state machine
 *
 * Description  : process that verify the velocity is at 0 within a certain time, otherwise trig errors
 * 
 * Returns      : bool : true
 */
static bool NDF_ErrorMode(bool reset)
{
   bool ready = false;

   if (reset)
      StopTimer(&NDF_modeChangeTimer);

   if (NDF_GetErrors(NDF_ERR_FAULHABERCOMM_TIMEOUT | NDF_ERR_FAULHABERCOMM_ERROR))
      GC_GenerateEventError(EECD_NDFilterTimeout);

   if (NDF_GetErrors(NDF_ERR_FAULHABER_HOME_TIMEOUT))
      GC_GenerateEventError(EECD_NDFilterInitializationError);

   if (NDF_GetErrors(NDF_ERR_ALL))
   {
      NDF_ERR("Error : 0x%08X", NDF_errors);
      StartTimer(&NDF_modeChangeTimer, 5000); // basic error mode : retry after 5 sec
   }

   NDF_ClearErrors(NDF_ERR_ALL);

   if (TimedOut(&NDF_modeChangeTimer))
   {
      NDF_ERR("Errors cleared");
      ready = true;
   }

   return ready;
}

/*
 * Name         : NDF_SetErrors
 *
 * Synopsis     : void NDF_SetErrors(uint32_t mask)
 * Arguments    : uint32_t  mask : error code to apply
 *
 * Description  : Set the bit wise error flag
 * 
 */
void NDF_SetErrors(uint32_t mask) 
{
   NDF_errors |= mask;
}

/*
 * Name         : NDF_ClearErrors
 *
 * Synopsis     : void NDF_ClearErrors(uint32_t mask)
 * Arguments    : uint32_t  mask : error code to clear
 *
 * Description  : Clear the bit wise error flag
 * 
 */
void NDF_ClearErrors(uint32_t mask) 
{
   NDF_errors &= ~mask;
}
/*
 * Name         : NDF_GetErrors
 *
 * Synopsis     : uint32_t NDF_GetErrors(uint32_t mask)
 * Arguments    : uint32_t  mask : error code to compare
 *
 * Description  : Check if the error code from mask is set
 * 
 * Returns      : uint32_t : return the bit wise and of error & mask
 */
uint32_t NDF_GetErrors(uint32_t mask) 
{
   return NDF_errors & mask;
}
