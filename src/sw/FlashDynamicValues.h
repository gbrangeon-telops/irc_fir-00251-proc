/**
 * @file FlashDynamicValues.h
 * Camera flash dynamic values module header.
 *
 * This file defines the camera flash dynamic values module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FLASHDYNAMICVALUES_H
#define FLASHDYNAMICVALUES_H

#include "FlashDynamicValuesFile.h"
#include "IRC_Status.h"
#include "verbose.h"

#ifdef FDV_VERBOSE
   #define FDV_PRINTF(fmt, ...)  FPGA_PRINTF("FDV: " fmt, ##__VA_ARGS__)
#else
   #define FDV_PRINTF(fmt, ...)  DUMMY_PRINTF("FDV: " fmt, ##__VA_ARGS__)
#endif

#define FDV_ERR(fmt, ...)        FPGA_PRINTF("FDV: Error: " fmt "\n", ##__VA_ARGS__)
#define FDV_INF(fmt, ...)        FPGA_PRINTF("FDV: Info: " fmt "\n", ##__VA_ARGS__)
#define FDV_DBG(fmt, ...)        FDV_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define FDV_FILENAME             "FlashDynamicValues.tsdv"
#define FDV_TMP_FILENAME         "FlashDynamicValuesTmp.tsdv"
#define FDV_FILENAME_SIZE        24U
/**
 * Flash dynamic values data type
 */
typedef FlashDynamicValues_FlashDynamicValuesFileHeader_t flashDynamicValues_t;

/**
 * Flash dynamic values default value
 */
#define flashDynamicValues_default FlashDynamicValues_FlashDynamicValuesFileHeader_default

IRC_Status_t FlashDynamicValues_Init(flashDynamicValues_t *p_flashDynamicValues);
IRC_Status_t FlashDynamicValues_Update(flashDynamicValues_t *p_flashDynamicValues);
IRC_Status_t FlashDynamicValues_Recover();

#endif // FLASHDYNAMICVALUES_H
