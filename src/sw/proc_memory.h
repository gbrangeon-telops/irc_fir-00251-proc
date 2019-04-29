/**
 * @file proc_memory.h
 * Processing FPGA DDR memory definition.
 *
 * This file defines processing FPGA DDR memory macros.
 *
 * $Rev: 23157 $
 * $Author: elarouche $
 * $Date: 2019-04-02 16:06:10 -0400 (mar., 02 avr. 2019) $
 * $Id: proc_memory.h 23157 2019-04-02 20:06:10Z elarouche $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/proc_memory.h $
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
 * Calibration actualization delta beta
 */
#define PROC_MEM_DELTA_BETA_BASEADDR         (PROC_MEM_USART_RXBUFFER_HIGHADDR + 1)
#define PROC_MEM_DELTA_BETA_SIZE             (FPA_WIDTH_MAX * FPA_HEIGHT_MAX * sizeof(uint16_t))
#define PROC_MEM_DELTA_BETA_HIGHADDR         (PROC_MEM_DELTA_BETA_BASEADDR + PROC_MEM_DELTA_BETA_SIZE - 1)

/**
 * Internal memory buffer
 */
#define PROC_MEM_MEMORY_BUFFER_BASEADDR      (PROC_MEM_DELTA_BETA_HIGHADDR + 1)
#define PROC_MEM_MEMORY_BUFFER_SIZE          (XPAR_MIG_CALIBRATION_CAL_DDR_MIG_HIGHADDR - PROC_MEM_MEMORY_BUFFER_BASEADDR + 1)
#define PROC_MEM_MEMORY_BUFFER_HIGHADDR      (PROC_MEM_MEMORY_BUFFER_BASEADDR + PROC_MEM_MEMORY_BUFFER_SIZE - 1)

#endif // PROC_MEMORY_H
