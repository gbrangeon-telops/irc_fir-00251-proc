/**
 * @file ProcStartupTest_Master.h
 * Processing FPGA Startup Tests Master Controller definition
 *
 * This file defines the Startup Tests master controller
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef PROCSTARTUPTEST_MASTER_H_
#define PROCSTARTUPTEST_MASTER_H_

#include <stdbool.h>

// TELOPS-defined headers
#include "ProcStartupTest_utils.h"
#include "ProcStartupTest_Def.h"

#include "ProcStartupTest_Comm.h"
#include "ProcStartupTest_DetectorIntf.h"
#include "ProcStartupTest_HWIntf.h"
#include "ProcStartupTest_Memory.h"
#include "ProcStartupTest_PowerIntf.h"
#include "ProcStartupTest_TimeSync.h"
#include "ProcStartupTest_VideoOut.h"
#include "ProcStartupTest_XADC.h"

// Type definitions

/*
 * Automated test ID data type
 */
typedef enum automatedTestIDEnum autoTestID_t;

/*
 * Automated test result
 */
enum automatedTestResultEnum {
   ATR_FAILED = 0,
   ATR_SKIPPED,
   ATR_PASSED,
   ATR_PENDING
};

/*
 * Automated test result data type
 */
typedef enum automatedTestResultEnum autoTestResult_t;

/*
 * Automated test function pointer data type
 */
typedef IRC_Status_t (*autoTestFunc_t)();

/*
 * Automated test results structure
 */
struct AutomatedTestResultStruct {
   uint32_t pending;
   uint32_t skipped;
   uint32_t failed;
   uint32_t passed;
};

/*
 * Automated test results data type
 */
typedef struct AutomatedTestResultStruct AutoTest_GlobalResult_t;

/*
 * Automated test data structure
 */
struct AutomatedTestStruct {
   autoTestID_t id;
   char *description;
   autoTestFunc_t testFunc;
   autoTestResult_t result;
};

/*
 * Automated test data type
 */
typedef struct AutomatedTestStruct autoTest_t;

extern autoTest_t autoTests[ATID_Count];

// Master functions
IRC_Status_t AutoTest_Routine(void);

#endif /* PROCSTARTUPTEST_MASTER_H_ */
