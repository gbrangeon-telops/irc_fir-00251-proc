/**
 * @file power_ctrl.h
 * Camera power manager module header.
 *
 * This file defines the camera power manager module interface.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef POWER_CTRL_H
#define POWER_CTRL_H

#include <stdint.h>
#include "xgpio.h"
#include "IRC_Status.h"
#include "led_ctrl.h"
#include "xintc.h"
#include "verbose.h"

#ifdef PM_VERBOSE
   #define PM_PRINTF(fmt, ...)   FPGA_PRINTF("PM: " fmt, ##__VA_ARGS__)
#else
   #define PM_PRINTF(fmt, ...)   DUMMY_PRINTF("PM: " fmt, ##__VA_ARGS__)
#endif

#define PM_ERR(fmt, ...)         FPGA_PRINTF("PM: Error: " fmt "\n", ##__VA_ARGS__)
#define PM_INF(fmt, ...)         FPGA_PRINTF("PM: Info: " fmt "\n", ##__VA_ARGS__)
#define PM_DBG(fmt, ...)         PM_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define POWER_UPDATE_CAMERA_LED_STATE_PERIOD_US    TIME_ONE_SECOND_US

/**
 * Power control data structure declaration
 */
struct powerCtrl_Struct
{
	XGpio GPIO;
};

/**
 * Power control data type
 */
typedef struct powerCtrl_Struct powerCtrl_t;

/**
 * Power GPIO channel
 */
enum powerGPIOChannelEnum {
   PGPIOC_POWER_MANAGEMENT = 1,
   PGPIOC_ANALOG_MUX_ADDR = 2
};

/**
 * Power GPIO channel data type.
 */
typedef enum powerGPIOChannelEnum powerGPIOChannel_t;

/**
 * Channel power state
 */
enum channelPowerStateEnum {
   CPS_OFF = 0,
   CPS_ON
};

/**
 * Power state data type.
 */
typedef enum channelPowerStateEnum channelPowerState_t;

/**
 * Power channel
 */
enum powerChannelEnum {
   PC_PLEORA = 0,
   PC_ADC_DDC = 1,
   PC_COOLER = 2,
   PC_FW = 3,
   PC_EXPANSION = 4,
   PC_SPARE1 = 5,
   PC_SPARE2 = 6,
   PC_SELFRESET = 7,
};

/**
 * Power channel data type.
 */
typedef enum powerChannelEnum powerChannel_t;

#define POWER_PLEORA_MASK        (1L << PC_PLEORA)
#define POWER_ADC_DDC_MASK       (1L << PC_ADC_DDC)
#define POWER_COOLER_MASK        (1L << PC_COOLER)
#define POWER_SFW_MASK           (1L << PC_SFW)
#define POWER_EXPANSION_MASK     (1L << PC_EXPANSION)
#define POWER_SPARE1_MASK        (1L << PC_SPARE1)
#define POWER_SPARE2_MASK        (1L << PC_SPARE2)
#define POWER_SELFRESET_MASK     (1L << PC_SELFRESET)

/**
 * Push button state
 */
enum pushButtonStateEnum {
   PBS_PUSHED = 0,
   PBS_RELEASED = 1
};

/**
 * Push button state data type.
 */
typedef enum pushButtonStateEnum pushButtonState_t;


#define Power_TurnOn(channel) Power_SetChannelPowerState(channel, CPS_ON)
#define Power_TurnOff(channel) Power_SetChannelPowerState(channel, CPS_OFF)

IRC_Status_t Power_Init(uint16_t gpioDeviceId, XIntc *p_intc, uint16_t IntrId);
channelPowerState_t Power_GetChannelPowerState(powerChannel_t channel);
pushButtonState_t Power_GetPushButtonState();
channelPowerState_t Power_SetChannelPowerState(powerChannel_t channel, channelPowerState_t state);
void Power_SetMuxAddr(uint32_t muxAddr);
void Power_UpdateDeviceLedIndicatorState(ledCtrl_t *p_ledCtrl, uint8_t init);
void Power_UpdateCameraLedState(ledCtrl_t *p_ledCtrl);
void Power_ToggleDevicePowerState();
void Power_SM();
void Power_CameraReset();
void Power_IntrHandler(powerCtrl_t *p_powerCtrl);

#endif // POWER_CTRL_H
