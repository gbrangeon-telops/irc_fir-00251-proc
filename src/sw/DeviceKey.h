/**
 * @file DeviceKey.h
 * Device key module header.
 *
 * This file defines the device key module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef DEVICEKEY_H
#define DEVICEKEY_H

#include "FlashSettings.h"
#include "FlashDynamicValues.h"
#include "GC_Registers.h"
#include "IRC_Status.h"
#include "verbose.h"
#include <stdint.h>

#ifdef DK_VERBOSE
   #define DK_PRINTF(fmt, ...)      PRINTF("DK: " fmt, ##__VA_ARGS__)
#else
   #define DK_PRINTF(fmt, ...)      DUMMY_PRINTF("DK: " fmt, ##__VA_ARGS__)
#endif

#define DK_ERR(fmt, ...)            PRINTF("DK: Error: " fmt "\n", ##__VA_ARGS__)
#define DK_INF(fmt, ...)            PRINTF("DK: Info: " fmt "\n", ##__VA_ARGS__)
#define DK_DBG(fmt, ...)            DK_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define DK_KEY_DWORD_LOW   0
#define DK_KEY_DWORD_HIGH  1


IRC_Status_t DeviceKey_Validate(flashSettings_t *p_flashSettings, flashDynamicValues_t *p_flashDynamicValues);
IRC_Status_t DeviceKey_Renew(flashDynamicValues_t *p_flashDynamicValues, gcRegistersData_t *p_gcRegsData);
IRC_Status_t DeviceKey_Reset(flashDynamicValues_t *p_flashDynamicValues, gcRegistersData_t *p_gcRegsData);

#endif // DEVICEKEY_H
