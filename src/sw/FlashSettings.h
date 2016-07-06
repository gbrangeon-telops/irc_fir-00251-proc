/**
 * @file FlashSettings.h
 * Camera flash settings structure declaration.
 *
 * This file declares the camera flash settings structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FLASHSETTINGS_H
#define FLASHSETTINGS_H

#include "FlashSettingsFile.h"
#include "FileManager.h"
#include "GC_Registers.h"
#include "IRC_Status.h"
#include "verbose.h"
#include <stdint.h>

#ifdef FS_VERBOSE
   #define FS_PRINTF(fmt, ...)   FPGA_PRINTF("FS: " fmt, ##__VA_ARGS__)
#else
   #define FS_PRINTF(fmt, ...)   DUMMY_PRINTF("FS: " fmt, ##__VA_ARGS__)
#endif

#define FS_ERR(fmt, ...)         FPGA_PRINTF("FS: Error: " fmt "\n", ##__VA_ARGS__)
#define FS_INF(fmt, ...)         FPGA_PRINTF("FS: Info: " fmt "\n", ##__VA_ARGS__)
#define FS_DBG(fmt, ...)         FS_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define FS_FLASHSETTINGS_IS_VALID (!TDCStatusTst(WaitingForFlashSettingsInitMask))

/**
 * Flash settings loader state.
 */
enum fsState {
   FSS_INIT = 0,                       /**< Initializing flash settings loader */
   FSS_LOADING                         /**< Loading flash setting file */
};

/**
 * Flash settings loader state data type.
 */
typedef enum fsState fsState_t;

/**
 * Flash settings loader Immediate.
 */
enum fslImmediateEnum {
   FSLI_DEFERRED_LOADING = 0,          /**< Flash settings file loading is deferred */
   FSLI_LOAD_IMMEDIATELY = 1           /**< Flash settings file is loaded immediately */
};

/**
 * Flash settings loader immediate data type.
 */
typedef enum fslImmediateEnum fslImmediate_t;

/**
 * Flash settings data type
 */
typedef FlashSettings_FlashSettingsFileHeader_t flashSettings_t;

/**
 * Flash settings global variable declaration
 */
extern flashSettings_t flashSettings;

/**
 * Flash dynamic values default value
 */
#define flashSettings_default FlashSettings_FlashSettingsFileHeader_default


IRC_Status_t FlashSettings_Init();
IRC_Status_t FlashSettings_Load(fileRecord_t *file, fslImmediate_t immediate);
IRC_Status_t FlashSettings_Reset(flashSettings_t *p_flashSettings);
void FlashSettings_SM();

#endif // FLASHSETTINGS_H
