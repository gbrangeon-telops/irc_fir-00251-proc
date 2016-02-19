/**
 * @file DebugTerminal.h
 * Debug terminal module header.
 *
 * This file defines the debug terminal module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef DEBUGTERMINAL_H
#define DEBUGTERMINAL_H

#include "CircularByteBuffer.h"
#include "IRC_Status.h"
#include <stdio.h>
#include <stdbool.h>

#if ((STDOUT_BASEADDRESS != XPAR_AXI_USB_UART_BASEADDR) || (STDIN_BASEADDRESS != XPAR_AXI_USB_UART_BASEADDR))
#ifdef DEBUG
#warning STDIN and STDOUT do not refer to USB UART.
#else
#error "STDIN and STDOUT must refer to USB UART."
#endif
#endif

#define DT_ERR(fmt, ...)      xil_printf("DT: Error: " fmt "\n", ##__VA_ARGS__)
#define DT_PRINT(fmt, ...)    print("DT: " fmt "\n", ##__VA_ARGS__)
#define DT_PRINTF(fmt, ...)   xil_printf("DT: " fmt "\n", ##__VA_ARGS__)

#define DT_BUFFER_SIZE        128

#define DT_DATA_PER_LINE      8

/**
 * Debug terminal state.
 */
enum debugTerminalStateEnum {
   DT_INIT = 0,   /**< Debug terminal initialization */
   DT_RUNNING     /**< Debug terminal is running */
};

/**
 * Debug terminal state data type.
 */
typedef enum debugTerminalStateEnum debugTerminalState_t;


IRC_Status_t DebugTerminal_Init();
void DebugTerminal_SM();

extern bool gDisableFilterWheel;

#endif // DEBUGTERMINAL_H
