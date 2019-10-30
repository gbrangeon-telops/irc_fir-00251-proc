/**
 * @file GC_Store.h
 * GenICam parameters storage
 *
 * This file defines the GenICam parameters storage implementation.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2019 Telops Inc.
 */

#include <string.h>
#include "proc_prom.h"
#include "GC_Registers.h"
#include "GC_Manager.h"
#include "CRC.h"
#include "GC_Store.h"

/* Private prototypes */
static size_t prepare_data(qspiFlash_t *qspiFlash, uint8_t *pFlashData);
static bool isRegExcluded(uint32_t idx);

/* Private data */

/* Exception list of GenIcam registers that must be excluded */
static uint32_t exclList[] =
{
  DeviceBuiltInTestsResults7Idx, DeviceBuiltInTestsResults8Idx, MemoryBufferModeIdx,
  MemoryBufferLegacyModeIdx, MemoryBufferStatusIdx, MemoryBufferAvailableFreeSpaceHighIdx,
  MemoryBufferAvailableFreeSpaceLowIdx, MemoryBufferFragmentedFreeSpaceHighIdx, MemoryBufferFragmentedFreeSpaceLowIdx,
  MemoryBufferTotalSpaceHighIdx, MemoryBufferTotalSpaceLowIdx, MemoryBufferNumberOfImagesMaxIdx,
  MemoryBufferNumberOfSequencesMaxIdx, MemoryBufferNumberOfSequencesIdx, MemoryBufferSequenceSizeIdx,
  MemoryBufferSequenceSizeMinIdx, MemoryBufferSequenceSizeMaxIdx, MemoryBufferSequenceSizeIncIdx,
  MemoryBufferSequencePreMOISizeIdx, MemoryBufferSequenceCountIdx, MemoryBufferSequenceSelectorIdx,
  MemoryBufferSequenceOffsetXIdx, MemoryBufferSequenceOffsetYIdx, MemoryBufferSequenceWidthIdx,
  MemoryBufferSequenceHeightIdx, MemoryBufferSequenceFirstFrameIDIdx, MemoryBufferSequenceMOIFrameIDIdx,
  MemoryBufferSequenceRecordedSizeIdx, MemoryBufferSequenceDownloadModeIdx, MemoryBufferSequenceDownloadImageFrameIDIdx,
  MemoryBufferSequenceDownloadFrameIDIdx, MemoryBufferSequenceDownloadFrameCountIdx, MemoryBufferSequenceDownloadBitRateMaxIdx,
  MemoryBufferSequenceClearIdx, MemoryBufferSequenceClearAllIdx, MemoryBufferSequenceDefragIdx,
  TestImageSelectorIdx, DevicePowerStateSetpointIdx
};


static bool cmd_erase; /* Erase command flag */
static bool cmd_save;  /* Save command flag */


IRC_Status_t GC_Store_Erase(void)
{
   cmd_erase = true;
   GCS_INF("GC store erase started.");
   return IRC_SUCCESS;
}


IRC_Status_t GC_Store_Save(void)
{
   cmd_save = true;
   GCS_INF("GC store save started.");
   return IRC_SUCCESS;
}


IRC_Status_t GC_Store_Load(qspiFlash_t *qspiFlash)
{
   IRC_Status_t status;
   static uint8_t flashData[GC_STORE_BUFSIZE];
   gcStoreHeader_t *pHdr = (gcStoreHeader_t *) flashData;
   uint8_t *pData = pHdr->GCStore;
   uint16_t CRC1, CRC2;
   int idx;

   do {
      status = QSPIFlash_Read(qspiFlash, PROM_GC_STORE_BASEADDR, flashData, GC_STORE_BUFSIZE);
   } while (status == IRC_NOT_DONE);
   if (status == IRC_FAILURE)
   {
      GCS_ERR("Failed to read %d bytes in PROM @ 0x%08X.", GC_STORE_BUFSIZE, PROM_GC_STORE_BASEADDR);
      return IRC_FAILURE;
   }

   /* Verify signature */
   if (strncmp(pHdr->Sig, GC_STORE_SIG, 4))
   {
      GCS_INF("GC store signature not found.");
      return IRC_FAILURE;
   }

   /* Verify CRCs */
   CRC1 = pHdr->HeaderCRC16;
   CRC2 = pHdr->StoreCRC16;
   pHdr->HeaderCRC16 = 0;
   pHdr->StoreCRC16 = 0;
   if (CRC16(0, (const uint8_t *) pHdr, sizeof(gcStoreHeader_t)) != CRC1)
   {
      GCS_ERR("Store header corruption detected!");
      return IRC_FAILURE;
   }
   if (CRC16(0, (const uint8_t *) pHdr->GCStore, pHdr->StoreSize) != CRC2)
   {
      GCS_ERR("Store data corruption detected!");
      return IRC_FAILURE;
   }

   /* Verify length */
   if (pHdr->length != sizeof(gcStoreHeader_t))
   {
      GCS_ERR("Wrong GC store header length (%d).", pHdr->length);
      return IRC_FAILURE;
   }

   /* Verify structure version */
   if (pHdr->versionMajor != GCSTORE_MAJOR_VERSION ||
       pHdr->versionMinor != GCSTORE_MINOR_VERSION ||
       pHdr->versionSubMinor != GCSTORE_SUBMINOR_VERSION)
   {
      GCS_ERR("Wrong GC store version (%d.%d.%d).",
            pHdr->versionMajor, pHdr->versionMinor, pHdr->versionSubMinor);
      return IRC_FAILURE;
   }

   /* Verify XML version */
   if (pHdr->XmlVersionMajor != GC_XMLMAJORVERSION ||
       pHdr->XmlVersionMinor != GC_XMLMINORVERSION ||
       pHdr->XmlVersionSubMinor != GC_XMLSUBMINORVERSION)
   {
      GCS_ERR("XML version mismatch (%d.%d.%d).",
            pHdr->XmlVersionMajor, pHdr->XmlVersionMinor, pHdr->XmlVersionSubMinor);
      return IRC_FAILURE;
   }

   /* Load GenIcam parameters */
   for (idx = 0; idx < GC_REG_COUNT; idx++)
   {
      gcRegister_t reg = gcRegsDef[idx];

      if (reg.owner == GCRO_Processing_FPGA && RegIsRW(&reg))
      {
         gcSelectedReg_t* pSelectedReg = findSelectedRegister(idx);

         if (isRegExcluded(idx)) continue;

         if (pSelectedReg == NULL) /* normal register */
         {
            memcpy(reg.p_data, pData, reg.dataLength);
            pData += reg.dataLength;
         }

         else /* selected register */
         {
            size_t len = 0;

            switch (idx)
            {
               case DeviceClockFrequencyIdx:
                  len = sizeof(DeviceClockFrequencyAry);
                  memcpy(DeviceClockFrequencyAry, pData, len);
                  break;

               case DeviceTemperatureIdx:
                  len = sizeof(DeviceTemperatureAry);
                  memcpy(DeviceTemperatureAry, pData, len);
                  break;

               case DeviceVoltageIdx:
                  len = sizeof(DeviceVoltageAry);
                  memcpy(DeviceVoltageAry, pData, len);
                  break;

               case DeviceCurrentIdx:
                  len = sizeof(DeviceCurrentAry);
                  memcpy(DeviceCurrentAry, pData, len);
                  break;

               case DeviceSerialPortBaudRateIdx:
                  len = sizeof(DeviceSerialPortBaudRateAry);
                  memcpy(DeviceSerialPortBaudRateAry, pData, len);
                  break;

               case DeviceSerialPortFunctionIdx:
                  len = sizeof(DeviceSerialPortFunctionAry);
                  memcpy(DeviceSerialPortFunctionAry, pData, len);
                  break;

               case EventNotificationIdx:
                  len = sizeof(EventNotificationAry);
                  memcpy(EventNotificationAry, pData, len);
                  break;

               case DeviceFirmwareModuleRevisionIdx:
                  len = sizeof(DeviceFirmwareModuleRevisionAry);
                  memcpy(DeviceFirmwareModuleRevisionAry, pData, len);
                  break;

               case TriggerModeIdx:
                  len = sizeof(TriggerModeAry);
                  memcpy(TriggerModeAry, pData, len);
                  break;

               case TriggerSourceIdx:
                  len = sizeof(TriggerSourceAry);
                  memcpy(TriggerSourceAry, pData, len);
                  break;

               case TriggerActivationIdx:
                  len = sizeof(TriggerActivationAry);
                  memcpy(TriggerActivationAry, pData, len);
                  break;

               case TriggerDelayIdx:
                  len = sizeof(TriggerDelayAry);
                  memcpy(TriggerDelayAry, pData, len);
                  break;

               case TriggerFrameCountIdx:
                  len = sizeof(TriggerFrameCountAry);
                  memcpy(TriggerFrameCountAry, pData, len);
                  break;
            }

            pData += len;
         }
      }
   }

   GCS_INF("GC parameters read successfully.");
   return IRC_SUCCESS;
}


void GC_Store_SM(qspiFlash_t *qspiFlash)
{
   static gcStoreState_t state = gcStoreIdle;
   static uint8_t flashData[GC_STORE_BUFSIZE];
   static size_t datalen;
   IRC_Status_t status;

   switch (state)
   {
      case gcStoreIdle:
         if (cmd_erase) state = doErase;
         if (cmd_save) state = doSave;
         break;

      case doErase:
         status =  QSPIFlash_SectorErase(qspiFlash, PROM_GC_STORE_BASEADDR, GC_STORE_BUFSIZE);
         if (status == IRC_FAILURE)
         {
            GCS_ERR("Failed to erase %d bytes in PROM @ 0x%08X.", GC_STORE_BUFSIZE, PROM_GC_STORE_BASEADDR);
            state = finishErase;
         }
         if (status == IRC_SUCCESS) state = finishErase;
         break;

      case finishErase:
         GCS_INF("GC store erase finished.");
         cmd_erase = false;
         state = gcStoreIdle;
         break;

      case doSave:
         datalen = prepare_data(qspiFlash, flashData);
         state = eraseBeforeWrite;
         break;

      case eraseBeforeWrite:
         status =  QSPIFlash_SectorErase(qspiFlash, PROM_GC_STORE_BASEADDR, GC_STORE_BUFSIZE);
         if (status == IRC_FAILURE)
         {
            GCS_ERR("Failed to erase %d bytes in PROM @ 0x%08X.", GC_STORE_BUFSIZE, PROM_GC_STORE_BASEADDR);
            state = finishWrite;
         }
         if (status == IRC_SUCCESS) state = writeInProgress;
         break;

      case writeInProgress:
         status = QSPIFlash_Write(qspiFlash, flashData, PROM_GC_STORE_BASEADDR, datalen);
         if (status == IRC_FAILURE)
         {
            GCS_ERR("Failed to write %d bytes in PROM @ 0x%08X.", datalen, PROM_GC_STORE_BASEADDR);
            state = finishWrite;
         }
         if (status == IRC_SUCCESS) state = finishWrite;
         break;

      case finishWrite:
         GCS_INF("GC store write finished.");
         cmd_save = false;
         state = gcStoreIdle;
         break;
   }
}


static size_t prepare_data(qspiFlash_t *qspiFlash, uint8_t *pFlashData)
{
   gcStoreHeader_t *pHdr = (gcStoreHeader_t *) pFlashData;
   uint8_t *pData = pHdr->GCStore;
   size_t datalen;
   int idx;

   /* Fill header.
    * The StoreSize and CRCs fields must be computed later.
    */
   memset(pHdr, 0, sizeof(gcStoreHeader_t));
   strncpy(pHdr->Sig, GC_STORE_SIG, 4);
   pHdr->length = sizeof(gcStoreHeader_t);
   pHdr->versionMajor = GCSTORE_MAJOR_VERSION;
   pHdr->versionMinor = GCSTORE_MINOR_VERSION;
   pHdr->versionSubMinor = GCSTORE_SUBMINOR_VERSION;
   pHdr->XmlVersionMajor = GC_XMLMAJORVERSION;
   pHdr->XmlVersionMinor = GC_XMLMINORVERSION;
   pHdr->XmlVersionSubMinor = GC_XMLSUBMINORVERSION;

   /* Copy GenIcam data to local buffer */
   for (idx = 0; idx < GC_REG_COUNT; idx++)
   {
      gcRegister_t reg = gcRegsDef[idx];

      if (reg.owner == GCRO_Processing_FPGA && RegIsRW(&reg))
      {
         gcSelectedReg_t* pSelectedReg = findSelectedRegister(idx);

         if (isRegExcluded(idx)) continue;

         if (pSelectedReg == NULL) /* normal register */
         {
            memcpy(pData, reg.p_data, reg.dataLength);
            pData += reg.dataLength;
            pHdr->StoreSize += reg.dataLength;
          }

         else /* selected register */
         {
            size_t len = 0;

            switch (idx)
            {
               case DeviceClockFrequencyIdx:
                  len = sizeof(DeviceClockFrequencyAry);
                  memcpy(pData, DeviceClockFrequencyAry, len);
                  break;

               case DeviceTemperatureIdx:
                  len = sizeof(DeviceTemperatureAry);
                  memcpy(pData, DeviceTemperatureAry, len);
                  break;

               case DeviceVoltageIdx:
                  len = sizeof(DeviceVoltageAry);
                  memcpy(pData, DeviceVoltageAry, len);
                  break;

               case DeviceCurrentIdx:
                  len = sizeof(DeviceCurrentAry);
                  memcpy(pData, DeviceCurrentAry, len);
                  break;

               case DeviceSerialPortBaudRateIdx:
                  len = sizeof(DeviceSerialPortBaudRateAry);
                  memcpy(pData, DeviceSerialPortBaudRateAry, len);
                  break;

               case DeviceSerialPortFunctionIdx:
                  len = sizeof(DeviceSerialPortFunctionAry);
                  memcpy(pData, DeviceSerialPortFunctionAry, len);
                  break;

               case EventNotificationIdx:
                  len = sizeof(EventNotificationAry);
                  memcpy(pData, EventNotificationAry, len);
                  break;

               case DeviceFirmwareModuleRevisionIdx:
                  len = sizeof(DeviceFirmwareModuleRevisionAry);
                  memcpy(pData, DeviceFirmwareModuleRevisionAry, len);
                  break;

               case TriggerModeIdx:
                  len = sizeof(TriggerModeAry);
                  memcpy(pData, TriggerModeAry, len);
                  break;

               case TriggerSourceIdx:
                  len = sizeof(TriggerSourceAry);
                  memcpy(pData, TriggerSourceAry, len);
                  break;

               case TriggerActivationIdx:
                  len = sizeof(TriggerActivationAry);
                  memcpy(pData, TriggerActivationAry, len);
                  break;

               case TriggerDelayIdx:
                  len = sizeof(TriggerDelayAry);
                  memcpy(pData, TriggerDelayAry, len);
                  break;

               case TriggerFrameCountIdx:
                  len = sizeof(TriggerFrameCountAry);
                  memcpy(pData, TriggerFrameCountAry, len);
                  break;
            }

            pData += len;
            pHdr->StoreSize += len;
          }
      }
   }

   /* Compute CRCs */
   pHdr->HeaderCRC16 = CRC16(0, (const uint8_t *) pHdr, sizeof(gcStoreHeader_t));
   pHdr->StoreCRC16 = CRC16(0, (const uint8_t *) pHdr->GCStore, pHdr->StoreSize);

   /* Compute total length of data to write to flash */
   datalen = sizeof(gcStoreHeader_t) + pHdr->StoreSize;

   return datalen;
}


static bool isRegExcluded(uint32_t idx)
{
   uint32_t i;
   uint32_t len = sizeof(exclList) / sizeof(exclList[0]);

   for (i = 0; i < len; i++)
   {
      if (exclList[i] == idx) return true;
   }

   return false;
}


