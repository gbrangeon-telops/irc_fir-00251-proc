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
#ifndef NDFCONTROLLER_H
#define NDFCONTROLLER_H

#include "FaulhaberProtocol.h"
#include "verbose.h"

#include <stdint.h>
#include <stdbool.h>

#ifdef NDF_VERBOSE
   #define NDF_PRINTF(fmt, ...)   FPGA_PRINTF("NDF: " fmt, ##__VA_ARGS__)
#else
   #define NDF_PRINTF(fmt, ...)   DUMMY_PRINTF("NDF: " fmt, ##__VA_ARGS__)
#endif

#define NDF_ERR(fmt, ...)         FPGA_PRINTF("NDF: Error: " fmt "\n", ##__VA_ARGS__)
#define NDF_INF(fmt, ...)         NDF_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define NDF_INIT_TIMEOUT            1000 // ms : Long timeout because FAULHABER controller may start a few seconds after CLink board
#define NDF_POSITION_TIMEOUT        150  // ms
#define NDF_QUERY_POS_TIMEOUT       10  // ms

#define NDF_POS_POLLING_PERIOD            1 /*< polling period during displacements [ms] */
#define NDF_POS_PROTECTION_PERIOD         30 /*< forced pause between end to end displacement [ms] */

#define NDF_POS_LIMIT_DIST                10 /*< distance in counts to keep from the bumpers (used as a parameter for Load Position Limit after homing) */

#define NDF_NODE_ID                       2 /*< ID included in every serial command to the controller */

#define NDF_DEFAULT_FILTER_WIDTH   (uint32_t)50 /*< Default maximum distance in counts from the calibrated position before exiting the IN_TRANSITION state */

#define NDF_HOMING_SPEED                 (int32_t)20 /*< speed at which we search for mechanical stops [rpm] */
#define NDF_HOMING_TOL                   (uint32_t)5 // counts todo TBD
#define NDF_HOMING_MAX_PEAK_CURRENT       (uint32_t)100 // [mA]
#define NDF_HOMING_MAX_CONT_CURRENT       (uint32_t)100 // [mA]
#define NDF_MAX_PEAK_CURRENT              (uint32_t)1500 // [mA]
#define NDF_MAX_CONT_CURRENT              (uint32_t)1500 // [mA]

#define NDF_MAX_RPM                     (int32_t)1326 /*< maximum speed */
#define NDF_ENCODER_COUNTS              (int32_t)2048 /*< number of counts in one motor revolution */
#define NDF_FREE_RANGE                  (uint32_t)450 /*< approximative free range in counts ~80°/360° * 2048 */

#define NDF_POR_GAIN_POSITION                 1
#define NDF_I_GAIN_POSITION                   50
#define NDF_PP_GAIN_POSITION                  30
#define NDF_PD_GAIN_POSITION                  10
#define NDF_MAX_SPEED_POSITION                300

////////////////////
// Define Errors
////////////////////
#define NDF_ERR_FAULHABERCOMM_TIMEOUT         0x00000001
#define NDF_ERR_FAULHABERCOMM_ERROR           0x00000002
#define NDF_ERR_FAULHABER_RESP_TIMEOUT        0x00000004
#define NDF_ERR_FAULHABER_HALT_TIMEOUT        0x00000008
#define NDF_ERR_FAULHABER_HOME_TIMEOUT        0x00000010
#define NDF_ERR_FAULHABER_POS_TIMEOUT         0x00000020
#define NDF_ERR_FAULHABER_VEL_TIMEOUT         0x00000080
#define NDF_ERR_FAULHABER_PROFILE_TIMEOUT     0x00000100
#define NDF_ERR_FAULHABER_CONTR_ERROR         0x00000200
#define NDF_ERR_ALL                           0xFFFFFFFF

typedef enum
{
   NDF_STARTUP_MODE = 0,
   NDF_INIT_MODE,
   NDF_IDLE_MODE,
   NDF_POSITION_MODE,
   NDF_ERROR_MODE,
   NDF_DISABLED_MODE
} NDF_ControllerMode_t;

typedef enum
{
   NIM_INIT_TIMEOUTSETUP_MODE = 0,
   NIM_INIT_HOMING,
   NIM_DISABLE_LIMITS,
   NIM_ENABLE_DRIVE,
   NIM_WAIT_ACK,
   NIM_SET_GAIN, // not used
   NIM_WAIT_SET_GAIN, // not used
   NIM_HOME_SEQ,
   NIM_HOME_WAIT_ACK,
   NIM_HOME_QUERY_POS,
   NIM_WAIT_STATE,
   NIM_HOME_WAIT_QUERY_POS,
   NIM_STOP,
   NIM_STOP_WAIT_ACK,
   NIM_SET_CURRENT_LIMITS,
   NIM_CONFIG_HOME,
   NIM_CONFIG_HOME_WAIT_ACK,
   NIM_CONFIG_HOME_WAIT,
   NIM_DONE
}  NDF_initialisationMode_t;

typedef enum
{
   NPM_INIT,
   NPM_NEW_POS,
   NPM_NEW_POS_ACK,
   NPM_PAUSE,
   NPM_QUERY_POS,
   NPM_QUERY_POS_WAIT,
   NPM_TIMEOUT
}  NDF_positionMode_t;

typedef struct
{
   uint8_t POR;
   uint8_t I_GAIN;
   uint8_t PP;
   uint8_t PD;
   uint16_t maxVelocity;
} NDF_config_t;

void NDF_ControllerReset();
void ChangeNDFControllerMode(NDF_ControllerMode_t newMode, int32_t target);
void NDF_ControllerProcess();
bool IsNDFControllerReady();
NDF_ControllerMode_t getNDFControllerMode();
bool IsNDFHomingValid();

IRC_Status_t NDF_ControllerInit(FH_ctrl_t* instance);

////////////////////
// Error functions
////////////////////
void NDF_SetErrors(uint32_t mask);
void NDF_ClearErrors(uint32_t mask);
uint32_t NDF_GetErrors(uint32_t mask);


uint8_t NDF_getFilterIndex(int32_t counts, uint32_t threshold);
bool NDF_getFilterPosition(uint8_t idx, int32_t* counts);

void NDF_setRawPositionMode(bool enable);

void NDF_ResetTimers();

#endif
