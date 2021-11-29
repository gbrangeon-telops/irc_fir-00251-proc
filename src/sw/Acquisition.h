/**
 *  @file Acquisition.h
 *  Acquisition module header.
 *  
 *  This file defines the acquisition module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef ACQUISITION_H
#define ACQUISITION_H

#include "IRC_Status.h"
#include "power_ctrl.h"
#include "verbose.h"
#include "utils.h"

#ifdef ACQ_VERBOSE
   #define ACQ_PRINTF(fmt, ...)  FPGA_PRINTF("ACQ: " fmt, ##__VA_ARGS__)
#else
   #define ACQ_PRINTF(fmt, ...)  DUMMY_PRINTF("ACQ: " fmt, ##__VA_ARGS__)
#endif

#define ACQ_ERR(fmt, ...)        FPGA_PRINTF("ACQ: Error: " fmt "\n", ##__VA_ARGS__)
#define ACQ_INF(fmt, ...)        FPGA_PRINTF("ACQ: Info: " fmt "\n", ##__VA_ARGS__)
#define ACQ_DBG(fmt, ...)        ACQ_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define WAITING_FOR_SENSOR_DELAY_US             (2 * TIME_ONE_SECOND_US)
#define WAITING_FOR_ADC_DDC_SENSOR_DELAY_US     (10 * TIME_ONE_SECOND_US) // waiting delay before validating the ADC board presence, because it takes some time to initialize

#define WAITING_FOR_ADC_DDC_PRESENCE_TIMEOUT_US (30 * TIME_ONE_SECOND_US)
#define WAITING_FOR_COOLER_VOLTAGE_TIMEOUT_US   (30 * TIME_ONE_SECOND_US)
#define WAITING_FOR_COOLER_POWER_ON_TIMEOUT_US  (30 * TIME_ONE_SECOND_US)
#define WAITING_FOR_SENSOR_TEMP_TIMEOUT_US      (10 * TIME_ONE_MINUTE_US)
#define WAITING_FOR_FPA_INIT_TIMEOUT_US         (44 * TIME_ONE_SECOND_US) // 32 + 7 images @ 0.9Hz
#define WAITING_FOR_GLOBAL_DONE_TIMEOUT_US      (30 * TIME_ONE_SECOND_US)
#define WAITING_FOR_COOLER_POWER_OFF_TIMEOUT_US (30 * TIME_ONE_SECOND_US)

#define COOLDOWN_STABILITY_PERIOD_US            (30 * TIME_ONE_SECOND_US)
#define COOLDOWN_SAMPLING_PERIOD_US             TIME_ONE_SECOND_US
#define COOLDOWN_TEMP_TOLERANCE_CC              80

// ENO,  29 janv 2019:  COOLER_CURRENT_THRESHOLD_A provient désormais du module fpa. #define COOLER_CURRENT_THRESHOLD_A              0.100F // 100 mA

#define TDCStatusAllowSensorAcquisitionArmMask        (WaitingForCoolerMask | WaitingForInitMask | WaitingForICUMask | WaitingForNDFilterMask | \
                                                      WaitingForFilterWheelMask | AcquisitionStartedMask | \
                                                      WaitingForCalibrationDataMask | WaitingForImageCorrectionMask | \
                                                      WaitingForOutputFPGAMask | WaitingForPowerMask)

#define TDCStatusAllowTestImageAcquisitionArmMask     (WaitingForInitMask | AcquisitionStartedMask | WaitingForCalibrationDataMask | \
                                                      WaitingForImageCorrectionMask | WaitingForOutputFPGAMask | WaitingForPowerMask)

#define AllowSensorAcquisitionArm()                   (!TDCStatusTstAny(TDCStatusAllowSensorAcquisitionArmMask))

#define AllowSensorAcquisitionStart()                 (!TDCStatusTstAny(TDCStatusAllowSensorAcquisitionArmMask | WaitingForValidParametersMask | \
                                                      WaitingForArmMask | WaitingForSensorMask))

#define AllowTestImageAcquisitionArm()                (!TDCStatusTstAny(TDCStatusAllowTestImageAcquisitionArmMask))

#define AllowTestImageAcquisitionStart()              (!TDCStatusTstAny(TDCStatusAllowTestImageAcquisitionArmMask | WaitingForValidParametersMask | \
                                                      WaitingForArmMask | WaitingForSensorMask))

#define AllowAcquisitionArm()                         (((gcRegsData.TestImageSelector == TIS_Off) && AllowSensorAcquisitionArm()) || \
                                                      ((gcRegsData.TestImageSelector != TIS_Off) && AllowTestImageAcquisitionArm()))

#define AllowAcquisitionStart()                       (((gcRegsData.TestImageSelector == TIS_Off) && AllowSensorAcquisitionStart()) || \
                                                      ((gcRegsData.TestImageSelector != TIS_Off) && AllowTestImageAcquisitionStart()))

/**
 * Acquisition state.
 */
enum acquisitionStateEnum {
   // Acquisition states
   ACQ_STOPPED = 0,                    /**< Acquisition is stopped */
   ACQ_WAITING_FOR_SENSOR_READY,       /**< Waiting for sensor to be ready */
   ACQ_SENSOR_READY,                   /**< Sensor is ready */
   ACQ_STARTED,                        /**< Acquisition is started */

   // Power ON states
   ACQ_WAITING_FOR_ADC_DDC_PRESENCE,   /**< Waiting for ADC/DDC presence */
   ACQ_WAITING_FOR_COOLER_VOLTAGE,     /**< Waiting for cooler voltage to be available */
   ACQ_WAITING_FOR_COOLER_POWER_ON,    /**< Waiting for cooler to be powered on */
   ACQ_WAITING_FOR_SENSOR_TEMP,        /**< Waiting for sensor temperature to be available */
   ACQ_WAITING_FOR_SENSOR_COOLDOWN,    /**< Waiting for sensor cooldown */
   ACQ_WAITING_FOR_FPA_INIT,           /**< Waiting for FPA initialization to be done */
   ACQ_FINALIZE_POWER_ON,              /**< Finalize power on */

   // Power OFF states
   ACQ_WAITING_FOR_GLOBAL_DONE,        /**< Waiting for global done signal */
   ACQ_WAITING_FOR_COOLER_POWER_OFF,   /**< Waiting for cooler to be powered OFF */

   ACQ_POWER_RESET,                     /**< Reset acquisition power state */

   ACQ_WAIT_SCD_TRIG_MODE_TRANSITION,    /**< Wait delay required for SCD detector */
   ACQ_WAIT_SCD_SPECIFIC_INIT_SEQ       /**< SCD specific detector initialization sequence */
};

/**
 * Acquisition state data type.
 */
typedef enum acquisitionStateEnum acquisitionState_t;


IRC_Status_t Acquisition_SetPowerState(DevicePowerStateSetpoint_t acquisitionPowerStateSetpoint);
DevicePowerState_t Acquisition_GetPowerState();
void Acquisition_SM();

#endif // ACQUISITION_H
