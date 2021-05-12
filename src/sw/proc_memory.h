/**
 * @file proc_memory.h
 * Processing FPGA DDR memory definition.
 *
 * This file defines processing FPGA DDR memory macros.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef PROC_MEMORY_H
#define PROC_MEMORY_H

#include "xparameters.h"
#include "FileManager.h"
#include "fpa_intf.h"
#include "Calibration.h"
#include "CalibCollectionFile.h"
#include <stdint.h>

/**
 * Pixel calibration data
 */
#define PROC_MEM_PIXEL_DATA_BASEADDR         XPAR_MIG_CALIBRATION_CAL_DDR_MIG_BASEADDR
#define PROC_MEM_PIXEL_DATA_SIZE             (CM_CALIB_BLOCK_PIXEL_DATA_SIZE * CALIB_MAX_NUM_OF_BLOCKS)
#define PROC_MEM_PIXEL_DATA_HIGHADDR         (PROC_MEM_PIXEL_DATA_BASEADDR + PROC_MEM_PIXEL_DATA_SIZE - 1)

/**
 * USART RX buffer
 */
#define PROC_MEM_USART_RXBUFFER_BASEADDR     (PROC_MEM_PIXEL_DATA_HIGHADDR + 1)
#define PROC_MEM_USART_RXBUFFER_SIZE         F1F2_MAX_FILE_PACKET_SIZE
#define PROC_MEM_USART_RXBUFFER_HIGHADDR     (PROC_MEM_USART_RXBUFFER_BASEADDR + PROC_MEM_USART_RXBUFFER_SIZE - 1)

/**
 * Internal memory buffer
 */
#define PROC_MEM_MEMORY_BUFFER_BASEADDR      (PROC_MEM_USART_RXBUFFER_HIGHADDR + 1)
#define PROC_MEM_MEMORY_BUFFER_SIZE          (XPAR_MIG_CALIBRATION_CAL_DDR_MIG_HIGHADDR - PROC_MEM_MEMORY_BUFFER_BASEADDR + 1)
#define PROC_MEM_MEMORY_BUFFER_HIGHADDR      (PROC_MEM_MEMORY_BUFFER_BASEADDR + PROC_MEM_MEMORY_BUFFER_SIZE - 1)

#endif // PROC_MEMORY_H
