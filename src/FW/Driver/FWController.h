/*-----------------------------------------------------------------------------
--
-- Description : Filter Wheel Controller header file
--
-- Author   : PDA (TEL-1000), SSA (TEL-2000)
-- Company  : Telops inc.
--
-- $Revision$
-- $Author$
-- $LastChangedDate$
------------------------------------------------------------------------------*/
#ifndef FWCONTROLLER_H
#define FWCONTROLLER_H

#include "FaulhaberProtocol.h"
#include "verbose.h"

#include <stdint.h>
#include <stdbool.h>
#include "genicam.h"
#include "FlashSettings.h"

#ifdef FW_VERBOSE
   #define FW_PRINTF(fmt, ...)   FPGA_PRINTF("FW: " fmt, ##__VA_ARGS__)
#else
   #define FW_PRINTF(fmt, ...)   DUMMY_PRINTF("FW: " fmt, ##__VA_ARGS__)
#endif

#define FW_ERR(fmt, ...)         FPGA_PRINTF("FW: Error: " fmt "\n", ##__VA_ARGS__)
#define FW_INF(fmt, ...)         FW_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define FAULHABER_MAX_IDLE_SPEED          10    // rpm
#define FAULHABER_INIT_TIMEOUT            1000 // ms : Long timeout because FAULHABER controller may start a few seconds after CLink board
#define FAULHABER_IDLE_TIMEOUT            60000 // ms
#define FAULHABER_HOME_PROFILE_TIMEOUT    10000 // ms
#define FAULHABER_POSITION_TIMEOUT        15000  // ms
#define FAULHABER_VELOCITY_TIMEOUT        60000 // ms
#define FAULHABER_VELOCITY_QUERY_TIMEOUT  1000 // ms
#define FAULHABER_VELOCITY_QUERY_PAUSE    500 // ms

#define FAULHABER_PROFILE_TIMEOUT_CNT     4     // Nb profile try before going to error mode

#define FW_ERROR_MODE_MAX_RETRY           10

#define FW_NODE_ID                        0
#define SFW_NODE_ID                       3

#define VERIFY_ERRORS_PERIOD              1000  // ms

#define VELOCITY_TOLERANCE                50    // rpm
#define POSITION_TOLERANCE                10     // cnt

#define FW_VEL_THRESHOLD                  flashSettings.FWSpeedControllerSwitchingThreshold

#define FW_MAPPING_DIST_THRESHOLD   (uint32_t)200 /*< Maximum distance in counts from the calibrated position before exiting from IN_TRANSITION state */

#define FW_LIMIT_SWITCH_MSK               (uint8_t)4 /*< value of the IO configuration mask 5th input mcdc only */
#define FW_LIMIT_SWITCH_FAULT_MSK         (uint8_t)2 /*< value of the IO configuration mask Fault pin */

#define FW_CMD_QUEUE_SIZE           1

// SLOW FILTER WHEEL WITH 4 POSITONS AND A GEARBOX
#define FW_INTERNAL_GEAR_RATIO (int)361
#define FW_EXTERNAL_GEAR_RATIO (float)88/32
#define FW_ENCODER_COUNTS  (int32_t)64 /*< number of counts in one motor revolution */

// fast FILTER WHEEL WITH 8 POSITONS AND A hall sensor and external ENC
#define FW_HALL_ENCODER_COUNTS   3000
#define FW_EXTERNAL_ENCODER_COUNTS   4096



////////////////////
// Define Errors
////////////////////
#define FW_ERR_FAULHABERCOMM_TIMEOUT         0x00000001
#define FW_ERR_FAULHABERCOMM_ERROR           0x00000002
#define FW_ERR_FAULHABER_RESP_TIMEOUT        0x00000004
#define FW_ERR_FAULHABER_HALT_TIMEOUT        0x00000008
#define FW_ERR_FAULHABER_HOME_TIMEOUT        0x00000010
#define FW_ERR_FAULHABER_POS_TIMEOUT         0x00000020
#define FW_ERR_FAULHABER_VEL_TIMEOUT         0x00000080
#define FW_ERR_FAULHABER_PROFILE_TIMEOUT     0x00000100
#define FW_ERR_FAULHABER_CONTR_ERROR         0x00000200
#define FW_ERR_FAULHABER_SPEED_SETPOINT      0x00000400
#define FW_ERR_ALL                           0xFFFFFFFF

typedef enum
{
   FW_STARTUP_MODE = 0,
   FW_INIT_MODE,
   FW_IDLE_MODE,
   FW_VELOCITY_MODE,
   FW_POSITION_MODE,
   FW_ERROR_MODE,
   FW_DISABLED_MODE
} FW_ControllerMode_t;

typedef enum
{
   INIT_TIMEOUTSETUP_MODE = 0,
   INIT_ENABLEMOTOR_MODE,
   INIT_WAIT_ACK_MODE,
   INIT_SET_GAIN,
   INIT_WAIT_SET_GAIN,
   INIT_HOME_SEQ,
   INIT_HOME_WAIT_ACK,
   INIT_HOME_WAIT_SWITCH,
   INIT_STOP_WHEEL,
   INIT_WAIT_STOP_WHEEL_ACK,
   INIT_WAIT_STOP_WHEEL,
   INIT_DISABLEMOTOR_MODE,
   INIT_WAIT_DISABLEMOTOR_ACK,
   INIT_DONE_MODE
}  FW_initialisationMode_t;

typedef enum
{
   IDLE_STOP_MODE = 0,
   IDLE_STOP_ACK_MODE,
   IDLE_VELOCITY_MODE,
   IDLE_WAIT_VEL_MODE,
   IDLE_READY_MODE
}  FW_idleMode_t;

typedef enum
{
   VELOCITY_SET_GAIN = 0,
   VELOCITY_WAIT_SET_GAIN,
   VELOCITY_NEW_VEL_MODE,
   VELOCITY_WAIT_VEL_MODE,
   VELOCITY_WAIT_CMDACK_MODE,
   VELOCITY_PAUSE_QUERY_MODE,
   VELOCITY_QUERY_MODE,
   VELOCITY_WAIT_QUERY_MODE,
   VELOCITY_READY_MODE
}  FW_velocityMode_t;

typedef enum
{
   POSITION_SET_1RPM = 0,
   POSITION_WAIT_SET_1RPM_ACK,
   POSITION_WAIT_SET_1RPM_NOTIFY,
   POSITION_SET_GAIN,
   POSITION_WAIT_SET_GAIN,
   POSITION_ENABLEMOTOR_MODE,
   POSITION_WAIT_ENABLEMOTOR_ACK,
   POSITION_QUERY_POS_MODE,
   POSITION_WAIT_QUERY_POS,
   POSITION_NEW_POS_MODE,
   POSITION_NEWPOS_ACK_MODE,
   POSITION_WAIT_MODE,
   POSITION_MOVE_DONE_MODE,
   POSITION_DISABLEMOTOR_MODE,
   POSITION_WAIT_DISABLEMOTOR_ACK,
   POSITION_READY_MODE
}  FW_positionMode_t;

typedef enum
{
   ERROR_STOP_MODE = 0,
   ERROR_STOP_ACK_MODE,
   ERROR_VELOCITY_MODE,
   ERROR_WAIT_VEL_MODE,
   ERROR_READY_MODE
}  FW_errorMode_t;

typedef struct
{
   uint8_t POR;
   uint8_t I_GAIN;
   uint8_t PP;
   uint8_t PD;
   uint16_t maxVelocity;
} FW_config_t;

typedef enum
{
   FW_Position_Pid = 0,
   FW_Vel_Pid_Slow,
   FW_Vel_Pid_Fast,
   FW_Config_table_size
} FW_Config_type_t;

typedef enum
{
   FW_FIX = 0,
   FW_SYNC
} FWType_t;

struct FWCommandStruct {
   FW_ControllerMode_t mode;
   int32_t target;
};
typedef struct FWCommandStruct FWCommand_t;


////////////////////
// External functions
////////////////////
void FWControllerReset();
void ChangeFWControllerMode(FW_ControllerMode_t newMode, int32_t target);
void FW_ControllerProcess();
IRC_Status_t FWControllerInit(FH_ctrl_t* instance);
void FW_initPositionLUT();

////////////////////
// External Variable
////////////////////



////////////////////
// Error functions
////////////////////
void FW_SetErrors(uint32_t mask);
void FW_ClearErrors(uint32_t mask);
uint32_t FW_GetErrors(uint32_t mask);

////////////////////
// Internal functions
////////////////////
//static bool FWInitialisationMode(bool reset);
//static bool FWIdleMode(bool reset);
//static bool FWVelocityMode(bool reset, bool newTarget);
//static bool FWPositionMode(bool reset, bool newTarget);
//static bool FWErrorMode(bool reset);

int32_t FW_CalculateMove(int32_t target, int32_t pos);
bool FW_CalculateBacklashFreeMove(int32_t target, int32_t pos, int32_t* setpoint);

uint8_t FW_getFilterIndex(int32_t counts);
bool FW_getFilterPosition(uint8_t idx, int32_t* counts);

void FW_ResetTimers();

void FW_ConfigParameterSet(flashSettings_t *flashSetting, FW_config_t *Config);
void FW_SetFWEncoderCountInOneTurn();

void FW_CalculateSpeedSetpoint(gcRegistersData_t *pGCRegs);

int32_t SFWPositionToFWPosition(int32_t count);
int32_t FWPositionToSFWPosition(int32_t count);

#endif
