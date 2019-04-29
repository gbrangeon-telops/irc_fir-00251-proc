/*-----------------------------------------------------------------------------
--
-- Author      : Patrick Daraiche (TEL-1000 base), Simon Savary (Tel-2000)
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision$
-- $Author$
-- $LastChangedDate$
--
-------------------------------------------------------------------------------
--
-- File        : FWController.cpp
-- Description : This file offers high-level filter wheel management functions
--
--
------------------------------------------------------------------------------*/
#include "FWController.h"

#include "FaulhaberControl.h"
#include "FaulhaberProtocol.h"

#include "hder_inserter.h"
#include "FlashSettings.h"
#include "Timer.h"
#include "GenICam.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "SFW_Ctrl.h"

#include <string.h>
#include <stdlib.h>

/*
* Global variables (only for FW controller)
*/
static uint32_t             FW_errors = 0;
static bool                 FW_Reset = false;
static bool                 FW_Ready = false;
static bool                 FW_HomingValid = false;
static int32_t              FW_RequestedTarget;
static bool                 FW_ModeRequest = false;
static FW_ControllerMode_t   FW_NewMode;
static int32_t              FW_NewTarget;
static FW_ControllerMode_t  FW_currentMode = FW_STARTUP_MODE;
static int32_t FW_currentRawPosition = 1000000;

static FH_ctrl_t* FH_instance = 0;

int32_t FW_COUNTS_IN_ONE_TURN = 0;
static int32_t FW_BACKLASH_OFFSET = 0;

extern t_HderInserter gHderInserter;

static bool FWInitialisationMode(bool reset);
static bool FWIdleMode(bool reset);
static bool FWVelocityMode(bool reset, bool newTarget);
static bool FWPositionMode(bool reset, bool newTarget);
static bool FWErrorMode(bool reset);
static void FW_initPositionLUT();

static timerData_t FW_modeChangeTimer;
static timerData_t FW_commTimer;
static timerData_t FW_moveTimer;

static int32_t FW_positionsLUT[8];
static uint8_t FW_numberOfFilters = 8;

static bool FW_initialized = false;

FW_config_t FW_config[FW_Config_table_size];



IRC_Status_t FWControllerInit(FH_ctrl_t* instance)
{
   IRC_Status_t status = IRC_SUCCESS;
   FW_initialized = false;

   if (instance)
      FH_instance = instance;
   else
      status = IRC_FAILURE;

   if (flashSettings.FWPresent)
   {
      if(flashSettings.FWType == FW_SYNC)
         FH_instance->fh_data.id = SFW_NODE_ID; // Synchronous wheel
      else
         FH_instance->fh_data.id = FW_NODE_ID; // Slow wheel
   }

   FW_ResetTimers();

   FW_SetFWEncoderCountInOneTurn();

   FW_initialized = true;



   return status;
}

static void FW_initPositionLUT()
{
   int i;
   int fraction;

   FW_numberOfFilters = 4;
   fraction = FW_COUNTS_IN_ONE_TURN / FW_numberOfFilters;

   // default values first
   for (i=0; i<FW_numberOfFilters; ++i)
   {
      FW_positionsLUT[i] = i * fraction;
   }

   if (FS_FLASHSETTINGS_IS_VALID)
   {
      FW_numberOfFilters = MIN(8, flashSettings.FWNumberOfFilters);

      //If it<S the slow filter wheel(4 position) center position are given in the controler referential
      //If it<s the fast 8 position wheel. Postion are in the External Encoder referential

      FW_positionsLUT[0] = flashSettings.FW0CenterPosition;
      FW_positionsLUT[1] = flashSettings.FW1CenterPosition;
      FW_positionsLUT[2] = flashSettings.FW2CenterPosition;
      FW_positionsLUT[3] = flashSettings.FW3CenterPosition;
      FW_positionsLUT[4] = flashSettings.FW4CenterPosition;
      FW_positionsLUT[5] = flashSettings.FW5CenterPosition;
      FW_positionsLUT[6] = flashSettings.FW6CenterPosition;
      FW_positionsLUT[7] = flashSettings.FW7CenterPosition;
   }

   // define the special base position for counteracting backlash. Set it about half-way between FW3 and FW0
   FW_BACKLASH_OFFSET = INT32_MAX;
   for (i=0; i<FW_numberOfFilters-1; ++i)
   {
      // take the minimum distance between two successive filters
      int32_t v = abs(FW_positionsLUT[i] - FW_positionsLUT[i+1])/2;
      FW_INF("v = %d", v);
      if (v < abs(FW_BACKLASH_OFFSET))
         FW_BACKLASH_OFFSET = v;
   }
   FW_INF("FW_BACKLASH_OFFSET = %d", FW_BACKLASH_OFFSET);
}

/*
 * Name         : FWControllerReset
 *
 * Synopsis     : void FWControllerReset()
 * Description  : Reset and variables initialisation
 * 
 */
void FWControllerReset()
{
   FW_errors = 0;
   FW_Reset = true;
   FW_Ready = false;
   FW_ModeRequest = false;
   //FaulhaberUtilitiesReset();
   FW_ResetTimers();
}

void FW_ResetTimers()
{
   StopTimer(&FW_modeChangeTimer);
   StopTimer(&FW_commTimer);
   StopTimer(&FW_moveTimer);
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
void ChangeFWControllerMode(FW_ControllerMode_t newMode, int32_t target)
{
   if (((newMode != FW_VELOCITY_MODE) && (newMode != FW_POSITION_MODE)) ||  // New mode not in velocity or position
         ((gcRegsData.FWMode != FWM_Fixed) && (newMode == FW_VELOCITY_MODE)) ||
         ((gcRegsData.FWMode == FWM_Fixed) && (newMode == FW_POSITION_MODE)))
   {
      FW_NewMode = newMode;
      FW_NewTarget = target;
      FW_ModeRequest = true;
      FW_Ready = false;
   }

}

/*
 * Name         : FWControllerProcess
 *
 * Synopsis     : void FWControllerProcess()
 * Description  : High-level state machine for the filter wheel
 * 
 */
void FW_ControllerProcess()
{
   static FW_ControllerMode_t currentMode = FW_STARTUP_MODE;
   static FW_ControllerMode_t lastMode = FW_STARTUP_MODE;
   static bool FW_newModeAvailable = false;
   static FW_ControllerMode_t newMode;
   static int32_t newTarget;
   static bool modeReady = false;
   bool modeChanged = false;
   bool targetChanged = false;
   static int numRetryErrorMode = 0;


   static uint32_t prevPosition = 100000000;

   if (FW_Reset || FW_initialized == false)
   {
      gcRegsData.FWPosition = FWP_FilterWheelInTransition;
      currentMode = FW_STARTUP_MODE;
      lastMode = FW_STARTUP_MODE;
      FW_newModeAvailable = false;
      modeReady = false;
      FW_Reset = false;
      // allow the current setpoint be applied immediately at the end of the homing sequence
      FW_getFilterPosition(gcRegsData.FWPositionSetpoint, &newTarget);
      numRetryErrorMode = 0;
   }
   if (FW_ModeRequest && !FW_newModeAvailable)
   {
      FW_newModeAvailable = true;
      newMode = FW_NewMode;
      newTarget = FW_NewTarget;
      FW_ModeRequest = false;
   }
   
   //UPDATE the GCSpeed register
   if(flashSettings.FWType == FW_SYNC )
      gcRegsData.FWSpeed = SFW_Get_RPM();




   //////////////////////////////////////////////////////////////////////////////////
   // Change state conditions state machine
   //////////////////////////////////////////////////////////////////////////////////
   switch(currentMode)
   {
      case FW_STARTUP_MODE:
         if (!flashSettings.FWPresent)
            currentMode = FW_DISABLED_MODE;
         else
            currentMode = FW_INIT_MODE;

         break;

      case FW_INIT_MODE:
         if (modeReady)
         {  // Goto to Idle when Init is done
            currentMode = FW_IDLE_MODE;
         }
         break;

      case FW_IDLE_MODE:
         if (modeReady)
         {  // Exit Idle mode when a new mode request is received
            if (FW_newModeAvailable)
            {
               FW_newModeAvailable = false;
               if(newMode != FW_IDLE_MODE)
               {
                  FW_RequestedTarget = newTarget;
                  currentMode = newMode;
               }
            }
         }
         break;

      case FW_VELOCITY_MODE:
      case FW_POSITION_MODE:
         if (modeReady)
         {
            if (FW_newModeAvailable)
            {  // Don't go back to IDLE mode if new mode is the same!
               if (newMode == currentMode)
               {
                  FW_newModeAvailable = false;
                  // Update target if necessary
                  if(newTarget != FW_RequestedTarget)
                  {
                     FW_RequestedTarget = newTarget;
                     targetChanged = true;
                  }
               }
               else
               {  // Change to transitory state (idle)
                  currentMode = FW_IDLE_MODE;
                  FW_PRINTF("Going To Idle_Mode\n");
               }
            }
         }
         break;

      case FW_ERROR_MODE:
         if (modeReady)
         {  // Return to initialisation when error mode is ready
            currentMode = FW_STARTUP_MODE;
            FW_PRINTF("FW_ERROR_MODE: returning to FW_STARTUP_MODE\n");
            ++numRetryErrorMode;
         }
         /*else if (numRetryErrorMode >= FW_ERROR_MODE_MAX_RETRY)
         {
            FW_ERR("Abandoning after %d retries.", FW_ERROR_MODE_MAX_RETRY);
            currentMode = FW_DISABLED_MODE;
         }*/



         break;

      case FW_DISABLED_MODE:
         // this mode is reached when no FW is present (FWP_FilterWheelNotImplemented)
         break;

      default:
         currentMode = FW_STARTUP_MODE;
         break;
   }

   // Always go in Error mode if FAULHABER controller doesn't respond after too many retries
   if (FW_GetErrors(FW_ERR_ALL))
   {
      currentMode = FW_ERROR_MODE;
   }

   // Update last cycle memory
   modeChanged = (currentMode != lastMode);
   lastMode = currentMode;
   
   // Set FW_HomingValid to false and it can be changed if the currentMode is FW_POSITION_MODE
   FW_HomingValid = false;

   //////////////////////////////////////////////////////////////////////////////////
   // Output of the state machine : Processing to be done in each state
   //////////////////////////////////////////////////////////////////////////////////
   switch(currentMode)
   {
      case FW_STARTUP_MODE:
         FH_consumeResponses(FH_instance);
         FW_Ready = false;
         gcRegsData.FWPosition = FWP_FilterWheelInTransition;

         break;

      case FW_INIT_MODE:
         modeReady = FWInitialisationMode(modeChanged);
         FW_Ready = false;
         gcRegsData.FWPosition = FWP_FilterWheelInTransition;

         break;

      case FW_IDLE_MODE:
         modeReady = FWIdleMode(modeChanged);
         FW_Ready = modeReady && !FW_ModeRequest & !FW_newModeAvailable;
         numRetryErrorMode = 0;
         gcRegsData.FWPosition = FWP_FilterWheelInTransition;

         break;

      case FW_VELOCITY_MODE:
         modeReady = FWVelocityMode(modeChanged, targetChanged);
         FW_Ready = modeReady && !FW_ModeRequest;
         gcRegsData.FWPosition = FWP_FilterWheelInTransition;

         break;

      case FW_POSITION_MODE:
         modeReady = FWPositionMode(modeChanged, targetChanged);
         FW_HomingValid = modeReady;
         FW_Ready = modeReady && !FW_ModeRequest;
         //gcRegsData.FWPosition is updated in FWPositionMode()

         break;

      case FW_ERROR_MODE:
         modeReady = FWErrorMode(modeChanged);
         FW_Ready = modeReady;
         gcRegsData.FWPosition = FWP_FilterWheelInTransition;
         break;

      case FW_DISABLED_MODE:
         gcRegsData.FWPosition = FWP_FilterWheelNotImplemented;
         FW_Ready = false;
         modeReady = true;
         break;

      default:
         break;
   }

   if (!modeReady)
      TDCStatusSet(WaitingForFilterWheelMask);
   else
      TDCStatusClr(WaitingForFilterWheelMask);

   // transmit the new position upon a change
   if (prevPosition != gcRegsData.FWPosition)
   {
      HDER_UpdateFWPositionHeader(&gHderInserter, gcRegsData.FWPosition);
         prevPosition = gcRegsData.FWPosition;

      FW_INF("Updating FWPosition in header (%d)", gcRegsData.FWPosition);
   }

   FW_currentMode = currentMode;

   // handle commands in the pipe
   FH_sendPendingCmds(FH_instance);
}

/*
 * Name         : IsFWControllerReady
 *
 * Synopsis     : uint32_t IsFWControllerReady()
 * Description  : Check if the FW is ready to accept a new command
 * 
 * Returns      : bool : false -> not ready, true -> Ready
 */
bool IsFWControllerReady()
{
   return FW_Ready;
}

/*
 * Name         : getFWControllerModes
 *
 * Synopsis     : FWControllerModes_t getFWControllerModes()
 * Description  : Return the current mode of FW
 * 
 * Returns      : FWControllerModes_t : state of the Controller
 */
FW_ControllerMode_t getFWControllerMode()
{
   return FW_currentMode;
}

/*
 * Name         : IsFWHomingValid
 *
 * Synopsis     : bool IsFWHomingValid()
 * Description  : Return FW_HomingValid;
 * 
 * Returns      : bool : false -> homing is not valid, true homing is valid
 */
bool IsFWHomingValid()
{
   return FW_HomingValid;
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
static bool FWInitialisationMode(bool reset)
{
   static FW_initialisationMode_t initMode = INIT_TIMEOUTSETUP_MODE;
   int numAck;
   bool done = false;
   static bool gFWConfigInit = true;

   if(reset)
   {
      initMode = INIT_TIMEOUTSETUP_MODE;
      StopTimer(&FW_modeChangeTimer);
      FH_consumeResponses(FH_instance);
   }
   
   switch(initMode)
   {
      case INIT_TIMEOUTSETUP_MODE:
         StartTimer(&FW_modeChangeTimer, FAULHABER_INIT_TIMEOUT);

         //Init LUT Position
         FW_initPositionLUT();

         //Init FW_Config parameter only at first boot. Do not override FW_config when we reset for Debug terminal or an FW issue
         if(gFWConfigInit == true)
         {
            FW_ConfigParameterSet( &flashSettings, FW_config);
            gFWConfigInit = false;
         }



         if ((flashSettings.FWType == FW_SYNC ) && (gcRegsData.FWSpeed >= 1))
         {
            initMode = INIT_STOP_WHEEL;
         }
         else
         {
            initMode = INIT_SET_GAIN;
         }

         break;

      case INIT_STOP_WHEEL:
         if(setVelocityWithoutNotification(FH_instance, 1))
         {
            FW_INF("Stopping Filter Wheel");
            StartTimer(&FW_commTimer, FAULHABER_INIT_TIMEOUT);
            FW_PRINTF("INIT_WAIT_STOP_WHEEL_ACK\n");
            initMode = INIT_WAIT_STOP_WHEEL_ACK;
         }
         break;

      case INIT_WAIT_STOP_WHEEL_ACK:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            initMode = INIT_WAIT_STOP_WHEEL;
            FW_PRINTF("INIT_WAIT_STOP_WHEEL\n");
            StartTimer(&FW_commTimer, FAULHABER_VELOCITY_TIMEOUT);
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in WAIT_STOP_WHEEL_ACK");
            StopTimer(&FW_commTimer);
            initMode = INIT_DONE_MODE;
            FW_PRINTF("INIT_DONE_MODE\n");
         }
         break;

      case INIT_WAIT_STOP_WHEEL:
         gcRegsData.FWSpeed = SFW_Get_RPM();

         if (gcRegsData.FWSpeed <= 1)
         {
            StopTimer(&FW_commTimer);
            FW_PRINTF("INIT_DISABLEMOTOR_MODE\n");
            initMode = INIT_DISABLEMOTOR_MODE;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABER_VEL_TIMEOUT);
            FW_ERR("Timeout in WAIT_STOP_WHEEL (velocity = 0 not reached within the timeout period).");
            initMode = INIT_DONE_MODE;
            FW_PRINTF("INIT_DONE_MODE\n");
         }
         break;

      case INIT_DISABLEMOTOR_MODE:
         StopTimer(&FW_commTimer);
         if (setEnableDrive(FH_instance, false))
         {
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            initMode = INIT_WAIT_DISABLEMOTOR_ACK;
         }
         break;

      case INIT_WAIT_DISABLEMOTOR_ACK:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_PRINTF("INIT_SET_GAIN\n");
            initMode = INIT_SET_GAIN;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in INIT_WAIT_DISABLEMOTOR_ACK");
            StopTimer(&FW_commTimer);
            initMode = INIT_DONE_MODE;
            FW_PRINTF("INIT_DONE_MODE\n");
         }
         break;


      case INIT_SET_GAIN:
         StopTimer(&FW_commTimer);
         if (setControllerGain(FH_instance, FW_config[FW_Position_Pid].POR, FW_config[FW_Position_Pid].I_GAIN, FW_config[FW_Position_Pid].PP, FW_config[FW_Position_Pid].PD, FW_config[FW_Position_Pid].maxVelocity))
         {
            StartTimer(&FW_commTimer, FAULHABER_INIT_TIMEOUT);
            initMode = INIT_WAIT_SET_GAIN;
         }
         break;

      case INIT_WAIT_SET_GAIN:

         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);

            initMode = INIT_ENABLEMOTOR_MODE;
            FW_PRINTF("INIT_ENABLEMOTOR_MODE\n");
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Timeout during INIT_WAIT_SET_GAIN (no ACK).");
            initMode = INIT_DONE_MODE;
            StopTimer(&FW_commTimer);
         }

         break;

      case INIT_ENABLEMOTOR_MODE:
         StopTimer(&FW_commTimer);
         if (setEnableDrive(FH_instance, true))
         {
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            initMode = INIT_WAIT_ACK_MODE;
         }
         break;

      case INIT_WAIT_ACK_MODE:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_PRINTF("INIT_HOME_SEQ\n");
            initMode = INIT_HOME_SEQ;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Timeout during INIT_WAIT_ACK_MODE");
            initMode = INIT_DONE_MODE;
         }
         break;

      case INIT_HOME_SEQ:
         StopTimer(&FW_commTimer);
         //Home with the good IO pin configuration
         if(flashSettings.FWType == FW_FIX )
         {
            if (initiateHomingSequence(FH_instance, FW_LIMIT_SWITCH_MSK))
            {
               StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
               initMode = INIT_HOME_WAIT_ACK;
            }
         }
         else if(flashSettings.FWType == FW_SYNC )
         {
            if (initiateHomingSequence(FH_instance, FW_LIMIT_SWITCH_FAULT_MSK))
            {
               StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
               initMode = INIT_HOME_WAIT_ACK;
            }
         }

         break;

      case INIT_HOME_WAIT_ACK:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            StartTimer(&FW_moveTimer, FAULHABER_HOME_PROFILE_TIMEOUT);
            initMode = INIT_HOME_WAIT_SWITCH;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Timeout during homing sequence (no ACK).");
            initMode = INIT_DONE_MODE;
            setVelocityWithoutNotification(FH_instance, 0);
         }

         break;

      case INIT_HOME_WAIT_SWITCH:
      {
         char notif;


         if (FH_readNotification(FH_instance, (uint8_t*)&notif) && (notif == FH_T || notif == FH_F))
         {
            StopTimer(&FW_modeChangeTimer);
            FW_ClearErrors(FW_ERR_FAULHABER_HOME_TIMEOUT);
            FW_PRINTF("INIT_DONE_MODE\n");
            initMode = INIT_DONE_MODE;
            if(flashSettings.FWType == FW_SYNC)
            {
               //TODO Load Register HOME_LOCK for the External encoder
            }
         }
         else if (TimedOut(&FW_moveTimer))
         {
            StopTimer(&FW_modeChangeTimer);
            FW_SetErrors(FW_ERR_FAULHABER_HOME_TIMEOUT);
            FW_ERR("Timeout during homing sequence (limit switch not found).");
            initMode = INIT_DONE_MODE;
            setVelocityWithoutNotification(FH_instance, 0);
         }

      }
            break;

      case INIT_DONE_MODE:
         done = true;
         break;

      default:
         initMode = INIT_ENABLEMOTOR_MODE;
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
static bool FWIdleMode(bool reset)
{
   int32_t counts = 0;
   bool ready = true;
   FH_consumeResponses(FH_instance);

   //Check for the operating mode
   //Set the basic parameter
   if(gcRegsData.FWMode == FWM_Fixed)
   {
      if (FW_getFilterPosition(gcRegsData.FWPositionSetpoint, &counts) == 0)
      {
         FW_getFilterPosition(FWPS_Filter1, &counts);
      }
      ChangeFWControllerMode(FW_POSITION_MODE, counts);
   }
   else if(gcRegsData.FWMode == FWM_AsynchronouslyRotating)
   {

      ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint);
   }
   else if(gcRegsData.FWMode == FWM_SynchronouslyRotating)
   {
      ChangeFWControllerMode(FW_VELOCITY_MODE, gcRegsData.FWSpeedSetpoint);
   }


   // for now, issue a mode change command

   return ready;
}

/*
 * Name         : FWVelocityMode
 *
 * Synopsis     : bool FWVelocityMode(bool reset, bool newTarget)
 * Arguments    : bool  reset : signal to reset state machine
 *                bool  newTarget : false -> no new target, true -> new target to applied
 *
 * Description  : process that manage and applied a new velocity setpoint.
 * 
 * Returns      : bool : false -> velocity not reached, true -> velocity reached
 */
static bool FWVelocityMode(bool reset, bool newTarget )
{
   bool ready = false;
   static FW_velocityMode_t velMode = VELOCITY_NEW_VEL_MODE;
   int numAck;
   static int32_t currentTarget = 0;
   static int32_t lastTarget = 0;
   

   if(reset || newTarget)
   {
      lastTarget = currentTarget;
      currentTarget = FW_RequestedTarget;

      if( (FW_RequestedTarget >= FW_VEL_THRESHOLD && lastTarget < FW_VEL_THRESHOLD) || (reset) )
      {
         velMode = VELOCITY_SET_GAIN; // Slow to Fast, change PID settings before speed
         FW_PRINTF("VELOCITY_SET_GAIN\n");

         if (reset)
         {
            lastTarget = 0;
         }
      }
      else
      {
         velMode = VELOCITY_NEW_VEL_MODE; // Fast to Slow, slow down the wheel before changing PID settings, prevent command kick on the motor
         FW_PRINTF("VELOCITY_NEW_VEL_MODE\n");
      }

      HDER_UpdateFWSpeedSetpointHeader(&gHderInserter, &gcRegsData);
      StopTimer(&FW_modeChangeTimer);
      StopTimer(&FW_commTimer);
   }

   switch(velMode)
   {
      case VELOCITY_SET_GAIN:
         if(FW_RequestedTarget >= FW_VEL_THRESHOLD && lastTarget < FW_VEL_THRESHOLD)
         {
            //FAST CTRL
            if (setControllerGain(FH_instance, FW_config[FW_Vel_Pid_Fast].POR,FW_config[FW_Vel_Pid_Fast].I_GAIN, FW_config[FW_Vel_Pid_Fast].PP,FW_config[FW_Vel_Pid_Fast].PD, FW_config[FW_Vel_Pid_Fast].maxVelocity))
            {
               StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
               velMode = VELOCITY_WAIT_SET_GAIN;
               FW_PRINTF("VELOCITY_WAIT_SET_GAIN\n");
            }
         }
         else if( (FW_RequestedTarget < FW_VEL_THRESHOLD) && ((lastTarget > FW_VEL_THRESHOLD) || (lastTarget == 0 )))
         {
            //SLOW CTRL
            if (setControllerGain(FH_instance, FW_config[FW_Vel_Pid_Slow].POR,FW_config[FW_Vel_Pid_Slow].I_GAIN, FW_config[FW_Vel_Pid_Slow].PP,FW_config[FW_Vel_Pid_Slow].PD, FW_config[FW_Vel_Pid_Slow].maxVelocity))
            {
               StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
               velMode = VELOCITY_WAIT_SET_GAIN;
               FW_PRINTF("VELOCITY_WAIT_SET_GAIN\n");
            }
         }
         else // Dont update the pid
         {
            velMode = VELOCITY_NEW_VEL_MODE;
            FW_PRINTF("VELOCITY_NEW_VEL_MODE\n");
         }
         break;
      
      case VELOCITY_WAIT_SET_GAIN:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);

            if ((FW_RequestedTarget >= FW_VEL_THRESHOLD && lastTarget < FW_VEL_THRESHOLD) || (lastTarget == 0))
            {
               velMode = VELOCITY_NEW_VEL_MODE; // Slow to Fast or mode change, change PID settings then change speed
               FW_PRINTF("VELOCITY_NEW_VEL_MODE\n");
            }
            else
            {
               velMode = VELOCITY_READY_MODE; // Fast to Slow, Fast to Fast or Slow to Slow: don't need PID settings changes or PID settings changes already applied
               FW_PRINTF("VELOCITY_READY_MODE\n");
            }

         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Timeout during VELOCITY_WAIT_SET_GAIN (no ACK).");
            velMode = VELOCITY_SET_GAIN;
            FW_PRINTF("VELOCITY_SET_GAIN\n");
            StopTimer(&FW_commTimer);
         }
         break;

      case VELOCITY_NEW_VEL_MODE:
         if(setVelocityWithoutNotification(FH_instance, currentTarget))
         {
            FW_INF("New target Velocity: %d", currentTarget);
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            velMode = VELOCITY_WAIT_CMDACK_MODE;
            FW_PRINTF("VELOCITY_WAIT_CMDACK_MODE\n");
         }
         break;

      case VELOCITY_WAIT_CMDACK_MODE:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            StartTimer(&FW_commTimer, FAULHABER_VELOCITY_TIMEOUT);
            velMode = VELOCITY_QUERY_MODE;
            FW_PRINTF("VELOCITY_QUERY_MODE\n");
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in VELOCITY_WAIT_CMDACK_MODE");
            StopTimer(&FW_commTimer);
            velMode = VELOCITY_NEW_VEL_MODE;
            FW_PRINTF("VELOCITY_NEW_VEL_MODE\n");
         }
         break;
      
      case VELOCITY_PAUSE_QUERY_MODE:
         if(TimedOut(&FW_commTimer))
         {
            velMode = VELOCITY_QUERY_MODE;
         }
         break;

      case VELOCITY_QUERY_MODE:
         if(queryVelocity(FH_instance))
         {
            StartTimer(&FW_commTimer, FAULHABER_VELOCITY_QUERY_TIMEOUT);
            velMode = VELOCITY_WAIT_QUERY_MODE;
         }
         break;

      case VELOCITY_WAIT_QUERY_MODE:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            int32_t value;

            if (FH_readValue(FH_instance, &value))
            {
               StopTimer(&FW_commTimer);
               FW_ClearErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);

               FW_INF("Current Velocity : %d", value);
               if( (value > ( currentTarget - FW_VEL_THRESHOLD)) && (value < ( currentTarget + FW_VEL_THRESHOLD)))
               {
                  FW_INF("Target Velocity Reached\n");

                  if ((FW_RequestedTarget < FW_VEL_THRESHOLD) && (lastTarget > FW_VEL_THRESHOLD))
                  {
                     velMode = VELOCITY_SET_GAIN; // Fast to Slow, apply PID settings after speed changed
                     FW_PRINTF("VELOCITY_SET_GAIN\n");
                  }
                  else
                  {
                     velMode = VELOCITY_READY_MODE; // Slow to Fast, Fast to Fast or Slow to Slow: don't need PID settings changes or PID settings changes already applied
                     FW_PRINTF("VELOCITY_READY_MODE\n");
                  }
               }
               else
               {
                  velMode = VELOCITY_PAUSE_QUERY_MODE;
                  StartTimer(&FW_commTimer, FAULHABER_VELOCITY_QUERY_PAUSE);
               }

            }
            else if (TimedOut(&FW_commTimer))
            {
               FW_SetErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);
               FW_ERR("Timeout in VELOCITY_WAIT_QUERY_MODE (requested value not returned).");
               velMode = VELOCITY_QUERY_MODE;
               FW_PRINTF("VELOCITY_QUERY_MODE\n");
            }
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Timeout during VELOCITY_WAIT_QUERY_MODE (no ACK).");
            velMode = VELOCITY_QUERY_MODE;
            FW_PRINTF("VELOCITY_QUERY_MODE\n");
            StopTimer(&FW_commTimer);
         }
         break;

      case VELOCITY_READY_MODE:
         lastTarget = currentTarget;
         ready = true;
         break;
         
      default:
         velMode = VELOCITY_NEW_VEL_MODE;
         break;
   }
   
   //lastTarget = currentTarget;

   return ready;
}

/*
 * Name         : FWPositionMode
 *
 * Synopsis     : bool FWPositionMode(bool reset, bool newTarget)
 * Arguments    : bool  reset : signal to reset state machine (from Rotating to Position)
 *                bool  newTarget : false -> no new position target, true -> new position target
 *
 * Description  : process that manage and applied a new position target
 * 
 * Returns      : bool : false -> position not reached, true -> position reached
 */
static bool FWPositionMode(bool reset, bool newTarget)
{
   static FW_positionMode_t posMode = POSITION_SET_GAIN;
   bool ready = false;
   int32_t newSetpoint, correctionMove;
   uint32_t maxTolerance;
   static bool verifyPos = false;
   static bool backlashMode = false;
   int numAck;
   char notification;

   extern uint16_t gSFW_deltaFilterEnd;
   extern uint16_t gSFW_deltaFilterBegin;

   if(reset || newTarget)
   {
      if (reset)
      {
         FW_PRINTF("FWPositionMode reset\n");
         if (SFW_Get_RPM() != 0)
         {
            posMode = POSITION_SET_1RPM;
            FW_PRINTF("POSITION_SET_1RPM\n");
         }
         else
         {
            posMode = POSITION_SET_GAIN;
            FW_PRINTF("POSITION_SET_GAIN\n");
         }
      }
      else
      {
         if (posMode == POSITION_READY_MODE)
         {
            if (flashSettings.FWType == FW_SYNC)
            {
               verifyPos = false;
               posMode = POSITION_QUERY_POS_MODE;
               FW_PRINTF("POSITION_QUERY_POS_MODE\n");
            }
            else
            {
               posMode = POSITION_ENABLEMOTOR_MODE;
               FW_PRINTF("POSITION_ENABLEMOTOR_MODE\n");
            }
         }
      }

      StopTimer(&FW_modeChangeTimer);
      StopTimer(&FW_commTimer);
   }
   
   switch(posMode)
   {
      case POSITION_SET_1RPM:
         if(setVelocity(FH_instance, 1))
         {
            FW_INF("Stopping Filter Wheel");
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            FW_PRINTF("POSITION_WAIT_SET_1RPM_ACK\n");
            posMode = POSITION_WAIT_SET_1RPM_ACK;
         }
         break;

      case POSITION_WAIT_SET_1RPM_ACK:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            StartTimer(&FW_commTimer, FAULHABER_VELOCITY_TIMEOUT);
            FW_PRINTF("POSITION_WAIT_SET_1RPM_NOTIFY\n");
            posMode = POSITION_WAIT_SET_1RPM_NOTIFY;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in POSITION_WAIT_SET_1RPM_ACK");
            StopTimer(&FW_commTimer);
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         }
         break;

      case POSITION_WAIT_SET_1RPM_NOTIFY:
      {
         char notif;

         if (FH_readNotification(FH_instance, (uint8_t*)&notif) && notif == FH_V)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABER_HOME_TIMEOUT);
            FW_PRINTF("POSITION_SET_GAIN\n");
            posMode = POSITION_SET_GAIN;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABER_VEL_TIMEOUT);
            FW_ERR("Timeout in POSITION_WAIT_SET_1RPM_NOTIFY (velocity = 1 not reached within the timeout period).");
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         }
         break;
      }

      case POSITION_SET_GAIN:
         if (setControllerGain(FH_instance, FW_config[FW_Position_Pid].POR, FW_config[FW_Position_Pid].I_GAIN, FW_config[FW_Position_Pid].PP, FW_config[FW_Position_Pid].PD, FW_config[FW_Position_Pid].maxVelocity))
         {
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            posMode = POSITION_WAIT_SET_GAIN;
            FW_PRINTF("POSITION_WAIT_SET_GAIN\n");
         }
         break;

      case POSITION_WAIT_SET_GAIN:

         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);

            if (flashSettings.FWType == FW_SYNC)
            {
               verifyPos = false;
               posMode = POSITION_QUERY_POS_MODE;
               FW_PRINTF("POSITION_QUERY_POS_MODE\n");
            }
            else
            {
               posMode = POSITION_ENABLEMOTOR_MODE;
               FW_PRINTF("POSITION_ENABLEMOTOR_MODE\n");
            }
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_PRINTF("FW: Timeout during POSITION_WAIT_SET_GAIN (no ACK).\n");
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
            StopTimer(&FW_commTimer);
         }

         break;

      case POSITION_ENABLEMOTOR_MODE:
         StopTimer(&FW_commTimer);
         if (setEnableDrive(FH_instance, true))
         {
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            posMode = POSITION_WAIT_ENABLEMOTOR_ACK;
         }
         break;

      case POSITION_WAIT_ENABLEMOTOR_ACK:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            verifyPos = false;
            FW_PRINTF("POSITION_QUERY_POS_MODE\n");
            posMode = POSITION_QUERY_POS_MODE;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in POSITION_WAIT_ENABLEMOTOR_ACK");
            StopTimer(&FW_commTimer);
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         }
         break;

   case POSITION_QUERY_POS_MODE:
      StopTimer(&FW_commTimer);
      if (queryPosition(FH_instance))
      {
         StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
         posMode = POSITION_WAIT_QUERY_POS;
         FW_PRINTF("POSITION_WAIT_QUERY_POS\n");
      }

      break;

   case POSITION_WAIT_QUERY_POS:

      numAck = FH_readAcks(FH_instance);
      FH_clearAcks(FH_instance, numAck);

      if (FH_numExpectedAcks(FH_instance) == 0)
      {
         int32_t value;

         if (FH_readValue(FH_instance, &value))
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);

            if (flashSettings.FWType == FW_SYNC)
            {
               // Use external encoder as current position
               FW_currentRawPosition = (int32_t)SFW_GetEncoderPosition();
               FW_INF("Current position: %d", FW_currentRawPosition);

               // For feedback only
               value = mod(value, FW_HALL_ENCODER_COUNTS);
               FW_INF("FH position: %d (%d)", value, FWPositionToSFWPosition(value));
            }
            else
            {
               // Use feedback as current position
               FW_currentRawPosition = value;
               FW_INF("Current position: %d", FW_currentRawPosition);
            }

            if (verifyPos)
            {
               if (flashSettings.FWType == FW_SYNC)
               {
                  // Calculate move needed to correct position
                  correctionMove = FW_CalculateMove(FW_RequestedTarget, FW_currentRawPosition);

                  // Determine maximum tolerance on position
                  if (correctionMove < 0)
                  {
                     // Position is over target (filter center), so use filter end as tolerance
                     maxTolerance = (uint32_t)(SFW_POS_TOLERANCE_MARGIN * (float)gSFW_deltaFilterEnd);
                  }
                  else
                  {
                     // Position is under target (filter center), so use filter begin as tolerance
                     maxTolerance = (uint32_t)(SFW_POS_TOLERANCE_MARGIN * (float)gSFW_deltaFilterBegin);
                  }

                  // Requery move if tolerance is exceeded
                  if (abs(correctionMove) > maxTolerance)
                  {
                     posMode = POSITION_NEW_POS_MODE;
                     FW_PRINTF("Warning: Filter misaligned (delta: %d, maxTolerance: %d)\n", -correctionMove, maxTolerance);
                     FW_PRINTF("POSITION_NEW_POS_MODE\n");
                  }
                  else
                  {
                     posMode = POSITION_MOVE_DONE_MODE;
                     FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
                  }
               }
               else
               {
                  if (backlashMode == false)
                  {
                     posMode = POSITION_MOVE_DONE_MODE;
                     FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
                  }
                  else
                  {
                     backlashMode = false;
                     posMode = POSITION_NEW_POS_MODE;
                     FW_PRINTF("POSITION_NEW_POS_MODE (backlash prevention)\n");
                  }
               }
            }
            else
            {
               // position was queried prior to issuing a move command
               posMode = POSITION_NEW_POS_MODE;
               FW_PRINTF("POSITION_NEW_POS_MODE\n");
            }

         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);
            FW_ERR("Timeout in POSITION_NEW_POS_MODE (requested value not returned).");
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         }
      }
      else if (TimedOut(&FW_commTimer))
      {
         FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
         FW_ERR("Timeout during POSITION_WAIT_QUERY_POS (no ACK).");
         posMode = POSITION_MOVE_DONE_MODE;
         FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         StopTimer(&FW_commTimer);
      }

      break;

     case POSITION_NEW_POS_MODE:
        {
           bool isRelativeMove = flashSettings.FWType == FW_SYNC; // FW_FIX commands absolute positions

           if (flashSettings.FWType == FW_SYNC)
           {
              // Current and requested positions are in external encoder counts
              newSetpoint = FW_CalculateMove(FW_RequestedTarget, FW_currentRawPosition);
              FW_INF("New target position: %d, relative move: %d", FW_RequestedTarget, newSetpoint);

              // Convert to Hall encoder position
              newSetpoint = SFWPositionToFWPosition(newSetpoint);
           }
           else
           {
              backlashMode = FW_CalculateBacklashFreeMove(FW_RequestedTarget, FW_currentRawPosition, &newSetpoint);
              FW_INF("New target position: %d, absolute move: %d, backlashMode: %d", FW_RequestedTarget, newSetpoint, backlashMode);
           }

           StopTimer(&FW_commTimer);
           if (setPosition(FH_instance, newSetpoint, isRelativeMove))
           {
              StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
              posMode = POSITION_NEWPOS_ACK_MODE;
              FW_PRINTF("POSITION_NEWPOS_ACK_MODE\n");
           }
        }
        break;

      case POSITION_NEWPOS_ACK_MODE:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_ClearErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            StartTimer(&FW_commTimer, FAULHABER_POSITION_TIMEOUT);
            FW_PRINTF("POSITION_WAIT_MODE\n");
            posMode = POSITION_WAIT_MODE;
            if (flashSettings.FWType == FW_SYNC)
               StartTimer(&FW_moveTimer, 5000);    // protection against early notification caused by overshoot
            else
               StartTimer(&FW_moveTimer, 0);       // no protection needed with this wheel
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in POSITION_NEWPOS_ACK_MODE");
            StopTimer(&FW_commTimer);
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         }

         break;
      
      case POSITION_WAIT_MODE:
         if ((TimedOut(&FW_moveTimer)) && FH_readNotification(FH_instance, (uint8_t*)&notification) && notification == FH_P)
         {
            StopTimer(&FW_commTimer);
            StopTimer(&FW_moveTimer);
            FW_ClearErrors(FW_ERR_FAULHABER_POS_TIMEOUT);
            FW_PRINTF("POSITION_QUERY_POS_MODE\n");
            verifyPos = true;
            posMode = POSITION_QUERY_POS_MODE;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABER_POS_TIMEOUT);
            FW_ERR("Timeout in POSITION_WAIT_MODE (position not reached within the timeout period).");
            posMode = POSITION_MOVE_DONE_MODE;
            FW_PRINTF("POSITION_MOVE_DONE_MODE\n");
         }

         break;

      case POSITION_MOVE_DONE_MODE:
         if (flashSettings.FWType == FW_SYNC)
         {
            // Motor always enabled
            posMode = POSITION_READY_MODE;
            FW_PRINTF("POSITION_READY_MODE\n");
         }
         else
         {
            // Disable motor
            posMode = POSITION_DISABLEMOTOR_MODE;
            FW_PRINTF("POSITION_DISABLEMOTOR_MODE\n");
         }
         break;

      case POSITION_DISABLEMOTOR_MODE:
         StopTimer(&FW_commTimer);
         if (setEnableDrive(FH_instance, false))
         {
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            posMode = POSITION_WAIT_DISABLEMOTOR_ACK;
         }
         break;

      case POSITION_WAIT_DISABLEMOTOR_ACK:
         numAck = FH_readAcks(FH_instance);
         FH_clearAcks(FH_instance, numAck);

         if (FH_numExpectedAcks(FH_instance) == 0)
         {
            StopTimer(&FW_commTimer);
            FW_PRINTF("POSITION_READY_MODE\n");
            posMode = POSITION_READY_MODE;
         }
         else if (TimedOut(&FW_commTimer))
         {
            FW_SetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT);
            FW_ERR("Time out while in POSITION_WAIT_DISABLEMOTOR_ACK");
            StopTimer(&FW_commTimer);
            posMode = POSITION_READY_MODE;
            FW_PRINTF("POSITION_READY_MODE\n");
         }
         break;

      case POSITION_READY_MODE:
         //FW_PRINTF("FW ready\n");
         ready = true;
         FH_consumeResponses(FH_instance);
         break;
         
      default:
         posMode = POSITION_NEW_POS_MODE;
         break;
   }
   
   gcRegsData.FWPositionRaw = FW_currentRawPosition;

   if (ready)
      gcRegsData.FWPosition = FW_getFilterIndex(FW_currentRawPosition);
   else
      gcRegsData.FWPosition = FWP_FilterWheelInTransition;

   return ready;
}

bool FW_getFilterPosition(uint8_t idx, int32_t* counts)
{
   bool success = false;

   if (counts!=0 && idx >= 0 && idx < FW_numberOfFilters)
   {
      *counts = FW_positionsLUT[idx];
      success = true;
   }

   return success;
}

uint8_t FW_getFilterIndex(int32_t counts)
{
   const uint8_t fnames[8] = {FWP_Filter1, FWP_Filter2, FWP_Filter3, FWP_Filter4, FWP_Filter5, FWP_Filter6, FWP_Filter7, FWP_Filter8};
   const uint32_t threshold = FW_MAPPING_DIST_THRESHOLD; // counts
   uint32_t i;
   int32_t dist;
   uint8_t p = FWP_FilterWheelInTransition;

   for (i=0; i<FW_numberOfFilters; ++i)
   {
         dist = FW_positionsLUT[i] - counts;

      if (dist > FW_COUNTS_IN_ONE_TURN/2)
         dist = dist - FW_COUNTS_IN_ONE_TURN;
      else if (dist < -FW_COUNTS_IN_ONE_TURN/2)
         dist = dist + FW_COUNTS_IN_ONE_TURN;

      if (abs(dist) <= threshold)
      {
         p = fnames[i];
         break;
      }
   }

   return p;
}

/*
 * Name         : FWErrorMode
 *
 * Synopsis     : bool FWErrorMode(bool reset)
 * Arguments    : bool  reset : signal to reset state machine
 *
 * Description  : process that verify the velocity is at 0 within a certain time, otherwise trig errors
 * 
 * Returns      : bool : false -> velocity is 0 ± 10 RPM, true -> velocity is greather than ±10RPM
 */
static bool FWErrorMode(bool reset)
{
   bool ready = false;

   if (reset)
      StopTimer(&FW_modeChangeTimer);

   if (FW_GetErrors(FW_ERR_FAULHABERCOMM_TIMEOUT | FW_ERR_FAULHABERCOMM_ERROR))
      GC_GenerateEventError(EECD_FilterWheelTimeout);

   if (FW_GetErrors(FW_ERR_FAULHABER_HOME_TIMEOUT))
      GC_GenerateEventError(EECD_FilterWheelHomingError);

   if (FW_GetErrors(FW_ERR_ALL))
   {
      FW_ERR("Error : 0x%08X", FW_errors);
      StartTimer(&FW_modeChangeTimer, 5000); // basic error mode : retry after 5 sec
   }

   FW_ClearErrors(FW_ERR_ALL);

   if (TimedOut(&FW_modeChangeTimer))
   {
      FW_ERR("Errors cleared");
      ready = true;
   }

   /*
   static errorMode_t errorMode = ERROR_VELOCITY_MODE;
   static uint32_t timeoutCnt = 0;
   uint8_t length;
   int32_t velocity;
   bool ready = false;
   int32_t actual_velocity;

   if(reset)
   {
      errorMode = ERROR_VELOCITY_MODE;
      timeoutCnt = 0;
      StopTimer(&FW_modeChangeTimer);
      StopTimer(&FW_commTimer);
   }

   switch(errorMode)
   {
      // case ERROR_CLEARFAULTCMD_MODE:
         // if(ClearFaultCmd())
         // {
            // errorMode = ERROR_WAIT_CLRF_MODE;
         // }
         // break;

      // case ERROR_WAIT_CLRF_MODE:
         // if(CommandSent())
         // {
            // if(LastCommandTimedOut())
            // {  // Retry if communication with FAULHABER has failed
               // errorMode = ERROR_CLEARFAULTCMD_MODE;
            // }
            // else
            // {  // ClearFault successful
               // FW_ClearErrors(FW_ERR_FAULHABER_PROFILE_TIMEOUT | FW_ERR_FAULHABER_CONTR_ERROR);
               // errorMode = ERROR_STOP_MODE;
            // }
         // }
         // break;

      case ERROR_STOP_MODE:
         if(SetNewVelocity(SFW_NODE,0))
         {
            StartTimer(&FW_modeChangeTimer, FAULHABER_VELOCITY_TIMEOUT);
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            errorMode = ERROR_STOP_ACK_MODE;
         }
         break;

      case ERROR_STOP_ACK_MODE:
         if(GetResponse(response, &length))
         {  // Faulhaber responded

            if(strcmp(response,"OK"))
            {
               StopTimer(&FW_commTimer);
               FW_ClearErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);
               errorMode = ERROR_VELOCITY_MODE;
            }
            else
               FW_SetErrors(FW_ERR_FAULHABER_CONTR_ERROR);
         }
         // else if(LastCommandTimedOut() || TimedOut(FW_TIMER_CONTROLLER_PROFILE))
         // {  // Retry if Faulhaber fails to respond
            // errorMode = ERROR_STOP_MODE;
            // if(TimedOut(FW_TIMER_CONTROLLER_PROFILE))
               // FW_SetErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);
         // }
         break;

      case ERROR_VELOCITY_MODE:
         if(GetVelocityCmd(SFW_NODE))
         {
            StartTimer(&FW_commTimer, FH_REQUEST_TIMEOUT);
            errorMode = ERROR_WAIT_VEL_MODE;
         }
         break;

      case ERROR_WAIT_VEL_MODE:
         if(GetResponse(response, &length))
         {  // FAULHABER responded
            FW_ClearErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);
            actual_velocity = atoi(response);
            if(actual_velocity < FAULHABER_MAX_IDLE_SPEED && actual_velocity > -FAULHABER_MAX_IDLE_SPEED)
            {  // Acceptable Idle speed : Error mode is now ready
               StopTimer(&FW_modeChangeTimer);
               StopTimer(&FW_commTimer);
               errorMode = ERROR_READY_MODE;
               FW_ClearErrors(FW_ERR_FAULHABER_HALT_TIMEOUT);
            }
            else
            {  // Wait more until speed has dropped enough
               errorMode = ERROR_VELOCITY_MODE;
            }
         }
         // else if(LastCommandTimedOut() || TimedOut(FW_TIMER_CONTROLLER_STATUS))
         // {  // Retry if FAULHABER fails to respond
            // errorMode = ERROR_VELOCITY_MODE;    // Request timeout
            // if(TimedOut(FW_TIMER_CONTROLLER_STATUS))
               // FW_SetErrors(FW_ERR_FAULHABER_RESP_TIMEOUT);
         // }
         // else if(TimedOut(FW_TIMER_CONTROLLER_PROFILE))
         // {  // Send the Halt command again if speed takes too long to reach acceptable Idle speed
            // FW_SetErrors(FW_ERR_FAULHABER_HALT_TIMEOUT);
            // errorMode = ERROR_STOP_MODE;
            // timeoutCnt++;
            // if(timeoutCnt == FAULHABER_PROFILE_TIMEOUT_CNT)
            // {  // Flag the error if FAULHABER fails to reach 0 rpm after too many tentatives
               // FW_SetErrors(FW_ERR_FAULHABER_PROFILE_TIMEOUT);
               // errorMode = ERROR_STOP_MODE;
               // timeoutCnt = 0;
            // }
         // }
         break;

      case ERROR_READY_MODE:
         ready = true;
         break;

      default:
         errorMode = ERROR_VELOCITY_MODE;
         break;
   }*/

   return ready;
}

/*
 * Name         : FW_SetErrors
 *
 * Synopsis     : void FW_SetErrors(uint32_t mask)
 * Arguments    : uint32_t  mask : error code to apply
 *
 * Description  : Set the bit wise error flag
 * 
 */
void FW_SetErrors(uint32_t mask) 
{
   FW_errors |= mask;
}

/*
 * Name         : FW_ClearErrors
 *
 * Synopsis     : void FW_ClearErrors(uint32_t mask)
 * Arguments    : uint32_t  mask : error code to clear
 *
 * Description  : Clear the bit wise error flag
 * 
 */
void FW_ClearErrors(uint32_t mask) 
{
   FW_errors &= ~mask;
}
/*
 * Name         : FW_GetErrors
 *
 * Synopsis     : uint32_t FW_GetErrors(uint32_t mask)
 * Arguments    : uint32_t  mask : error code to compare
 *
 * Description  : Check if the error code from mask is set
 * 
 * Returns      : uint32_t : return the bit wise and of error & mask
 */
uint32_t FW_GetErrors(uint32_t mask) 
{
   return FW_errors & mask;
}

/*
 * Name         : FW_CalculateMove
 *
 * Synopsis     : int32_t FW_CalculateMove(int32_t target, int32_t pos)
 *
 * Arguments    : int32_t  target : target to reach
 *                int32_t  pos : actual position
 *
 * Description  : Calculate the shortest path between the target and the current position
 * 
 * Returns      : int32_t Distance and orientation of the move
 */
int32_t FW_CalculateMove(int32_t target, int32_t pos)
{

   int32_t delta;
   int32_t relativeMove = 0;

   delta = target - pos;

   if (delta > FW_COUNTS_IN_ONE_TURN/2)
      relativeMove = -(FW_COUNTS_IN_ONE_TURN - delta);
   else if (delta < -FW_COUNTS_IN_ONE_TURN/2)
      relativeMove = FW_COUNTS_IN_ONE_TURN + delta;
   else
      relativeMove = delta;

   return relativeMove;
}

bool FW_CalculateBacklashFreeMove(int32_t target, int32_t pos, int32_t* setpoint_out)
{
   int32_t setpoint = 0;
   bool backlashMode = false;

   if (target < pos)
   {
      setpoint = target - FW_BACKLASH_OFFSET;
      backlashMode = true;
   }
   else
      setpoint = target;

   *setpoint_out = setpoint;

   return backlashMode;
}

void FW_ConfigParameterSet( flashSettings_t *flashSetting, FW_config_t *Config)
{
   //Check what is the filterWheel Type (Slow 4 position or Fast 8 position)
   if ( flashSetting->FWType == FW_FIX )
   {
      Config[FW_Position_Pid].I_GAIN    = flashSetting->FWPositionControllerI;
      Config[FW_Position_Pid].PD        = flashSetting->FWPositionControllerPD;
      Config[FW_Position_Pid].POR       = flashSetting->FWPositionControllerPOR;
      Config[FW_Position_Pid].PP        = flashSetting->FWPositionControllerPP;
      Config[FW_Position_Pid].maxVelocity  = flashSetting->FWSpeedMax;
   }
   else if( flashSetting->FWType == FW_SYNC )
   {
      //Set the slow PID for the homing
      Config[FW_Position_Pid].I_GAIN  = flashSetting->FWPositionControllerI;
      Config[FW_Position_Pid].PD      = flashSetting->FWPositionControllerPD;
      Config[FW_Position_Pid].POR     = flashSetting->FWPositionControllerPOR;
      Config[FW_Position_Pid].PP      = flashSetting->FWPositionControllerPP;
      Config[FW_Position_Pid].maxVelocity   = flashSetting->FWSpeedMax;

      Config[FW_Vel_Pid_Slow].I_GAIN  = flashSetting->FWSlowSpeedControllerPI;
      Config[FW_Vel_Pid_Slow].PD      = flashSetting->FWSlowSpeedControllerPD;
      Config[FW_Vel_Pid_Slow].POR     = flashSetting->FWSlowSpeedControllerPOR;
      Config[FW_Vel_Pid_Slow].PP      = flashSetting->FWSlowSpeedControllerPP;
      Config[FW_Vel_Pid_Slow].maxVelocity   = flashSetting->FWSpeedMax;

      Config[FW_Vel_Pid_Fast].I_GAIN  = flashSetting->FWFastSpeedControllerI;
      Config[FW_Vel_Pid_Fast].PD      = flashSetting->FWFastSpeedControllerPD;
      Config[FW_Vel_Pid_Fast].POR     = flashSetting->FWFastSpeedControllerPOR;
      Config[FW_Vel_Pid_Fast].PP      = flashSetting->FWFastSpeedControllerPP;
      Config[FW_Vel_Pid_Fast].maxVelocity   = flashSetting->FWSpeedMax;
   }
}

void FW_SetFWEncoderCountInOneTurn()
{
   if( flashSettings.FWType == FW_FIX)
   {
      FW_COUNTS_IN_ONE_TURN = (int32_t)(FW_INTERNAL_GEAR_RATIO * FW_EXTERNAL_GEAR_RATIO * FW_ENCODER_COUNTS);
   }
   else
   {
      FW_COUNTS_IN_ONE_TURN = (int32_t)(flashSettings.FWEncoderCyclePerTurn);
   }
}

void FW_CalculateSpeedSetpoint(gcRegistersData_t *pGCRegs)
{
   pGCRegs->FWSpeedSetpoint = (uint32_t) floorf(pGCRegs->AcquisitionFrameRate*60.0f/flashSettings.FWNumberOfFilters);
   if (pGCRegs->FWSpeedSetpoint == 0)
   {
      pGCRegs->FWSpeedSetpoint = 1;
   }
   
   pGCRegs->AcquisitionFrameRate = (float) pGCRegs->FWSpeedSetpoint*flashSettings.FWNumberOfFilters/60.0f;
}

int32_t SFWPositionToFWPosition(int32_t count)
{
   return (int32_t) ((float) count * ((float)FW_HALL_ENCODER_COUNTS / (float)FW_EXTERNAL_ENCODER_COUNTS));
}

int32_t FWPositionToSFWPosition(int32_t count)
{
   return (int32_t) ((float) count * ((float)FW_EXTERNAL_ENCODER_COUNTS / (float)FW_HALL_ENCODER_COUNTS));
}

