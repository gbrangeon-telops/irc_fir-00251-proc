/**
 * @file DT_CommandsDef_startup.c
 *  Debug terminal startup commands definition.
 *
 *  This file defines the debug terminal startup commands.
 *
 * $Rev: 18084 $
 * $Author: vreiher $
 * $Date: 2016-02-22 15:30:33 -0500 (lun., 22 févr. 2016) $
 * $Id: DT_CommandsDef.c 18084 2016-02-22 20:30:33Z vreiher $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2016-01-19%20Jig%20de%20Test/src/sw/DT_CommandsDef.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef DT_COMMANDSDEF_STARTUP_H_
#define DT_COMMANDSDEF_STARTUP_H_

#include "IRC_Status.h"
#include "CircularByteBuffer.h"
#include "ProcStartupTest_utils.h"

#define DT_STARTUP_CMDS    \
   {"ATR", DebugTerminalParseATR},  \
   {"Y", DebugTerminalParseYES},    \
   {"N", DebugTerminalParseNO},     \
   {"", DebugTerminalParseNULL},    \
   {"TRS", DebugTerminalParseTRS},  \
   {"TRF", DebugTerminalParseTRF},

IRC_Status_t DebugTerminalParseATR(circByteBuffer_t *cbuf);
IRC_Status_t DebugTerminalParseYES(circByteBuffer_t *cbuf);
IRC_Status_t DebugTerminalParseNO(circByteBuffer_t *cbuf);
IRC_Status_t DebugTerminalParseNULL(circByteBuffer_t *cbuf);
IRC_Status_t DebugTerminalParseTRS(circByteBuffer_t *cbuf);
IRC_Status_t DebugTerminalParseTRF(circByteBuffer_t *cbuf);



#endif /* DT_COMMANDSDEF_STARTUP_H_ */
