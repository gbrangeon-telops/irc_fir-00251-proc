/**
 * @file DeviceKey.c
 * Device key module implementation.
 *
 * This file implements device key module.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "DeviceKey.h"
#include "hash64.h"
#include "trig_gen.h"
#include "CRC.h"

IRC_Status_t DeviceKey_Validate(flashSettings_t *p_flashSettings, flashDynamicValues_t *p_flashDynamicValues)
{
   uint64_t deviceKey;
   uint32_t *p_deviceKey32 = (uint32_t *) &deviceKey;
   uint64_t deviceKeyValidation;
   uint32_t *p_deviceKeyValidation32 = (uint32_t *) &deviceKeyValidation;

   p_deviceKey32[DK_KEY_DWORD_LOW] = p_flashSettings->DeviceKeyLow;
   p_deviceKey32[DK_KEY_DWORD_HIGH] = p_flashSettings->DeviceKeyHigh;

   deviceKeyValidation = hash_64(deviceKey, (uint64_t) 0xFFFFFFFFFFFFFFFF);

   DK_DBG("Device key: 0x%08X%08X", flashSettings.DeviceKeyHigh, flashSettings.DeviceKeyLow);
   DK_DBG("Device key validation: 0x%08X%08X", p_deviceKeyValidation32[DK_KEY_DWORD_HIGH], p_deviceKeyValidation32[DK_KEY_DWORD_LOW]);
   DK_DBG("Device key TSDV validation: 0x%08X%08X", p_flashDynamicValues->DeviceKeyValidationHigh, p_flashDynamicValues->DeviceKeyValidationLow);

   if ((p_deviceKeyValidation32[DK_KEY_DWORD_LOW] != p_flashDynamicValues->DeviceKeyValidationLow) ||
         (p_deviceKeyValidation32[DK_KEY_DWORD_HIGH] != p_flashDynamicValues->DeviceKeyValidationHigh))
   {
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

IRC_Status_t DeviceKey_Renew(flashDynamicValues_t *p_flashDynamicValues, gcRegistersData_t *p_gcRegsData)
{
   extern t_Trig gTrig;
   t_PosixTime time = TRIG_GetRTC(&gTrig);
   uint8_t *p_seedVal1 = (uint8_t *)&time.Seconds;
   uint8_t *p_seedVal2 = (uint8_t *)&time.SubSeconds;

   uint32_t seedVal;
   uint8_t *p_seedVal8 = (uint8_t *)&seedVal;

   uint64_t deviceKey;
   uint8_t *p_deviceKey8 = (uint8_t *)&deviceKey;
   uint32_t *p_deviceKey32 = (uint32_t *)&deviceKey;

   uint64_t deviceKeyValidation;
   uint32_t *p_deviceKeyValidation32 = (uint32_t *)&deviceKeyValidation;

   uint32_t idxSeed;
   uint32_t startIdxDeviceKey;
   uint16_t crc16;
   uint32_t i;

   // Generate seed value
   for (i = 0; i < sizeof(seedVal); i++)
   {
      p_seedVal8[i] = p_seedVal1[i]^p_seedVal2[sizeof(seedVal) - i];
   }

   // Generate device key
   idxSeed = seedVal % sizeof(seedVal);
   startIdxDeviceKey = seedVal % sizeof(deviceKey);
   crc16 = idxSeed * startIdxDeviceKey;
   for (i = 0; i < sizeof(deviceKey); i++)
   {
      crc16 = CRC16(crc16, &p_seedVal8[idxSeed], 1);
      p_deviceKey8[(startIdxDeviceKey + i) % sizeof(deviceKey)] = (uint8_t) (crc16 & 0x00FF);
      idxSeed = crc16 % sizeof(seedVal);
   }

   // Save device key validation in flash dynamic values and registers
   deviceKeyValidation = hash_64(deviceKey, (uint64_t) 0xFFFFFFFFFFFFFFFF);

   DK_INF("Device key (renewed):  0x%08X%08X", p_deviceKey32[DK_KEY_DWORD_HIGH], p_deviceKey32[DK_KEY_DWORD_LOW]);
   DK_INF("Device key validation: 0x%08X%08X", p_deviceKeyValidation32[DK_KEY_DWORD_HIGH], p_deviceKeyValidation32[DK_KEY_DWORD_LOW]);

   p_flashDynamicValues->DeviceKeyValidationLow = p_deviceKeyValidation32[DK_KEY_DWORD_LOW];
   p_flashDynamicValues->DeviceKeyValidationHigh = p_deviceKeyValidation32[DK_KEY_DWORD_HIGH];
   p_gcRegsData->DeviceKeyValidationLow = p_flashDynamicValues->DeviceKeyValidationLow;
   p_gcRegsData->DeviceKeyValidationHigh = p_flashDynamicValues->DeviceKeyValidationHigh;

   if (FlashDynamicValues_Update(p_flashDynamicValues) != IRC_SUCCESS)
   {
      DK_ERR("Failed to update flash dynamic values.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

IRC_Status_t DeviceKey_Reset(flashDynamicValues_t *p_flashDynamicValues, gcRegistersData_t *p_gcRegsData)
{
   extern flashDynamicValues_t flashDynamicValuesDefault;

   p_flashDynamicValues->DeviceKeyValidationLow = flashDynamicValuesDefault.DeviceKeyValidationLow;
   p_flashDynamicValues->DeviceKeyValidationHigh = flashDynamicValuesDefault.DeviceKeyValidationHigh;
   p_gcRegsData->DeviceKeyValidationLow = p_flashDynamicValues->DeviceKeyValidationLow;
   p_gcRegsData->DeviceKeyValidationHigh = p_flashDynamicValues->DeviceKeyValidationHigh;

   if (FlashDynamicValues_Update(p_flashDynamicValues) != IRC_SUCCESS)
   {
      DK_ERR("Failed to update flash dynamic values.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}
