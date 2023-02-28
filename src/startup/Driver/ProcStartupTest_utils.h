/**
 * @file ProcStartupTest_utils.h
 * Processing FPGA Startup Test utilities definition
 *
 * This file defines the Startup Test tools used for various functionality tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */


#ifndef AUTOTEST_UTILS_H_
#define AUTOTEST_UTILS_H_


// Included standard libraries
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include <time.h>
#include <stdlib.h>

// Included XILINX-defined headers
#include "xil_types.h"

// Included TELOPS-defined headers
#include "utils.h"
#include "IRC_status.h"
#include "verbose.h"
#include "GC_Registers.h"

#include "ProcStartupTest_Def.h"

#define ONE_SECOND_US            1000000

#define ATR_ERR(fmt, ...)        PRINTF("\nATR> Error: " fmt, ##__VA_ARGS__)
#define ATR_INF(fmt, ...)        PRINTF("\nATR> Info: " fmt, ##__VA_ARGS__)
#define ATR_PRINTF(fmt, ...)     PRINTF("\nATR> " fmt, ##__VA_ARGS__)

#ifdef ATR_VERBOSE
   #define ATR_DBG(fmt, ...)     PRINTF("\nATR> Debug: " fmt, ##__VA_ARGS__)
#else
   #define ATR_DBG(fmt, ...)     DUMMY_PRINTF("\nATR> Debug: " fmt, ##__VA_ARGS__)
#endif

// Global variables broadcasting
extern volatile bool isRunningATR;
extern volatile bool waitingForNULL;
extern volatile bool waitingForYN;
extern volatile bool userAns;
extern volatile bool waitingForTI;
extern volatile bool waitingForTR;
extern volatile bool exitUnitaryTests;
extern volatile bool breakBatchMode;
extern volatile IRC_Status_t oTestResult;
extern volatile int32_t unitaryTestIndex;

/*
 * XADC Measurement ID enum
 */
enum XADC_MeasurementIDEnum {
   VOLTAGE_COOLER = 0,
   CURRENT_COOLER,
   VOLTAGE_24V,
   CURRENT_24V,
   INTERNAL_LENS_TEMP,
   EXTERNAL_LENS_TEMP,
   ICU_TEMP,
   SFW_TEMP,
   COMPRESSOR_TEMP,
   COLDFINGER_TEMP,
   SPARE_TEMP,
   EXTERNAL_TEMP,
   VOLTAGE_USB_BUS,
   VOLTAGE_USB_1V8,
   VOLTAGE_DDR3_REF,
   VOLTAGE_10GIGE,
   VOLTAGE_AUX_IO_PROC,
   VOLTAGE_AUX_IO_OUT,
   VOLTAGE_3V3,
   VOLTAGE_2V5,
   VOLTAGE_1V8,
   VOLTAGE_1V5,
   VOLTAGE_MGT_1V0,
   VOLTAGE_MGT_1V2,
   VOLTAGE_12V,
   VOLTAGE_5V,
   ADC_REF_1,
   ADC_REF_2,
   ADC_REF_3,
   PROC_FPGA_TEMP,
   PROC_FPGA_VCCINT,
   PROC_FPGA_VCCAUX,
   PROC_FPGA_VREFP,
   PROC_FPGA_VREFN,
   PROC_FPGA_VBRAM,
   OUTPUT_FPGA_TEMP,
   OUTPUT_FPGA_VCCINT,
   OUTPUT_FPGA_VCCAUX,
   OUTPUT_FPGA_VREFP,
   OUTPUT_FPGA_VREFN,
   OUTPUT_FPGA_VBRAM,

   XADC_CHANNEL_COUNT
};

/*
 * XADC Measurement ID data type
 */
typedef enum XADC_MeasurementIDEnum XADC_MeasurementID_t;

/*
 *  XADC Measurement result
 */
enum XADC_MeasurementResultEnum {
   XMR_FAIL = 0,
   XMR_NC,
   XMR_PASS,
   XMR_PENDING
};

/*
 *  XADC Measurement result data type
 */
typedef enum XADC_MeasurementResultEnum XADC_MeasurementResult_t;

/*
 * XADC test structure
 */
struct XADC_TestStruct {
   XADC_MeasurementID_t id;
   char *description;
   float measurement;
   XADC_MeasurementResult_t result;
};

/*
 * XADC test data type
 */
typedef struct XADC_TestStruct XADC_Test_t;

extern XADC_Test_t XADC_Tests[XADC_CHANNEL_COUNT];

void AutoTest_RunMinimalStateMachines(void);
bool AutoTest_getUserYN(void);
void AutoTest_getUserNULL(void);
void AutoTest_getUserTI(void);
IRC_Status_t AutoTest_getOutputTR(void);
void AutoTest_SaveGCRegisters(void);
IRC_Status_t AutoTest_RestoreGCRegisters(void);

#endif /* AUTOTEST_UTILS_H_ */
