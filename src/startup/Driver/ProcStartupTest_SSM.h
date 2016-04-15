 /**
 * @file SystemFunctionSM_Test.c
 * Modified Systems State Machines definition
 *
 * This file defines the modified state machines for use in automated tests
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */
#ifndef SYSTEMFUNCTIONSM_TEST_H_
#define SYSTEMFUNCTIONSM_TEST_H_

#include "ProcStartupTest_utils.h"

#include "XADC_Channels.h"
#include "XADC.h"
#include "gps.h"
#include "power_ctrl.h"
#include "trig_gen.h"
#include "hder_inserter.h"
#include "GC_Events.h"
#include "utils.h"
#include "xstatus.h"

#include <stdlib.h>
#include <string.h>

void XADC_SM_Test(xadcExtCh_t ExtCh);

void GPS_Process_TEST(t_GPS *Gps_struct);


#endif /* SYSTEMFUNCTIONSM_TEST_H_ */
