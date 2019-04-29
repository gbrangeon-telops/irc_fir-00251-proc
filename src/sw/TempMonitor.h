/**
 *  @file TempMonitor.h
 *  Temperature monitor module header.
 *  
 *  This file defines the temperature monitor module.
 *  
 *  $Rev: 18503 $
 *  $Author: dalain $
 *  $Date: 2016-04-08 14:46:14 -0400 (ven., 08 avr. 2016) $
 *  $Id: TempMonitor.h 18503 2016-04-08 18:46:14Z dalain $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/TempMonitor.h $
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
