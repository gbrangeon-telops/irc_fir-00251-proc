/**
 *  @file TempMonitor.h
 *  Temperature monitor module header.
 *  
 *  This file defines the temperature monitor module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef TEMPMONITOR_H
#define TEMPMONITOR_H

#include <stdint.h>
#include "IRC_Status.h"
#include "verbose.h"
#include "utils.h"

#ifdef TM_VERBOSE
   #define TM_PRINTF(fmt, ...)   FPGA_PRINTF("TM: " fmt, ##__VA_ARGS__)
#else
   #define TM_PRINTF(fmt, ...)   DUMMY_PRINTF("TM: " fmt, ##__VA_ARGS__)
#endif

#define TM_ERR(fmt, ...)         FPGA_PRINTF("TM: Error: " fmt "\n", ##__VA_ARGS__)
#define TM_INF(fmt, ...)         TM_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define FPA_TEMPERATURE_SAMPLING_PERIOD_US   TIME_ONE_SECOND_US
#define FPA_TEMPERATURE_ERROR_PERIOD_US      (60 * TIME_ONE_SECOND_US)

#define FPA_TEMPERATURE_TOL_C                1.0F

#define COOLER_ERROR_DETECTION_PERIOD_US     (10 * TIME_ONE_SECOND_US)
#define COOLER_ERROR_THRESHOLD_C             1.0F

/**
 * Temperature monitor state.
 */
enum tmStateEnum {
   TM_INIT = 0,         /**< State machine initialization */
   TM_SAMPLING          /**< FPA temperature sampling */
};

/**
 * Temperature monitor state data type.
 */
typedef enum tmStateEnum tmState_t;


void TempMonitor_SM();

#endif // TEMPMONITOR_H
