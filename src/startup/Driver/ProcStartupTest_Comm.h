/**
 * @file ProcStartupTest_Comm.h
 * Processing FPGA Startup Communication Tests definition
 *
 * This file defines the Startup communication tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef PROCSTARTUPTEST_COMM_H_
#define PROCSTARTUPTEST_COMM_H_

#include "ProcStartupTest_utils.h"

IRC_Status_t AutoTest_CLINK_UART(void);
IRC_Status_t AutoTest_OEM_UART(void);
IRC_Status_t AutoTest_GIGE_UART(void);
IRC_Status_t AutoTest_USB_UART(void);
IRC_Status_t AutoTest_FilterWheel_UART(void);
IRC_Status_t AutoTest_Cooler_UART(void);
IRC_Status_t AutoTest_USARTLoopback(void);
IRC_Status_t AutoTest_USARTFileTx(void);


#endif /* PROCSTARTUPTEST_COMM_H_ */
