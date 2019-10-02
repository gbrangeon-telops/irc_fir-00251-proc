/**
 * @file ProcStartupTest_PowerIntf.h
 * Processing FPGA Startup Power Interfaces Tests definition
 *
 * This file defines the Startup Power interfaces tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef PROCSTARTUPTEST_POWERINTF_H_
#define PROCSTARTUPTEST_POWERINTF_H_

#include "ProcStartupTest_utils.h"
#include "power_ctrl.h"

IRC_Status_t AutoTest_IntFanCtrl(void);
IRC_Status_t AutoTest_ExtFanCtrl(void);
IRC_Status_t AutoTest_PwrConnectOnOff(void);
IRC_Status_t AutoTest_CamLEDColors(void);
IRC_Status_t AutoTest_PwrBtnInt(void);
IRC_Status_t AutoTest_XADCPwrMonitor(void);

void Power_IntrHandler_Test(powerCtrl_t *p_powerCtrl);

#endif /* PROCSTARTUPTEST_POWERINTF_H_ */
