/**
 * @file ProcStartupTest_Memory.h
 * Processing FPGA Startup Memory Tests definition
 *
 * This file defines the Startup memory tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */


#ifndef PROCSTARTUPTEST_MEMORY_H_
#define PROCSTARTUPTEST_MEMORY_H_

#include "ProcStartupTest_utils.h"

IRC_Status_t AutoTest_CodeDDRMem(void);
IRC_Status_t AutoTest_ProcCalibMem(void);
IRC_Status_t AutoTest_OBufMem(void);
IRC_Status_t AutoTest_FlashMem(void);

#endif /* PROCSTARTUPTEST_MEMORY_H_ */
