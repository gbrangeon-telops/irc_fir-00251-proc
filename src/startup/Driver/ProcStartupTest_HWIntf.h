/**
 * @file ProcStartupTest_HWIntf.h
 * Processing FPGA Startup Tests Hardware Interfaces Tests definition
 *
 * This file defines the Startup Hardware interface tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef PROCSTARTUPTEST_HWINTF_H_
#define PROCSTARTUPTEST_HWINTF_H_

#include "ProcStartupTest_utils.h"

IRC_Status_t AutoTest_ICUIntf(void);
IRC_Status_t AutoTest_TrigIntf(void);
IRC_Status_t AutoTest_SWFIntf(void);

#endif /* PROCSTARTUPTEST_HWINTF_H_ */
