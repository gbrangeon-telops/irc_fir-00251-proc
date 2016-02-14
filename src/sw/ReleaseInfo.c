/**
 * @file ReleaseInfo.c
 * Firmware release information module implementation.
 *
 * This file implements firmware release information module.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "ReleaseInfo.h"
#include "GC_Registers.h"
#include "printf_utils.h"
#include "string.h"


/**
 * Read firmware release information from QSPI flash memory.
 *
 * @param qspiFlash is the pointer to the QSPI flash data structure.
 * @param releaseInfo is the pointer to the firmware release information structure to fill.
 *
 * @return IRC_SUCCESS if firmware release information was successfully read from QSPI flash memory.
 * @return IRC_FAILURE if failed to read firmware release information from QSPI flash memory.
 */
IRC_Status_t ReleaseInfo_Read(qspiFlash_t *qspiFlash, releaseInfo_t *releaseInfo)
{
   IRC_Status_t status;
   uint8_t flashData[PAGE_SIZE];
   uint8_t *p_flashData;

   memset(releaseInfo, 0, sizeof(releaseInfo_t));

   do {
      status = QSPIFlash_Read(qspiFlash, PROM_RELEASE_INFO_BASEADDR, flashData, PAGE_SIZE);
   } while (status == IRC_NOT_DONE);
   if (status != IRC_SUCCESS)
   {
      PRINT("Release information QSPI flash page read failed.\n");
      return IRC_FAILURE;
   }

   p_flashData = flashData;

   // Read release information length field
   memcpy(&releaseInfo->length, p_flashData, sizeof(releaseInfo->length));
   p_flashData += sizeof(releaseInfo->length);

   if (releaseInfo->length != RELEASEINFO_LENGTH)
   {
      PRINTF("Wrong release information length (%d).\n", releaseInfo->length);
      return IRC_FAILURE;
   }

   // Read release information version fields
   memcpy(&releaseInfo->versionMajor, p_flashData, sizeof(releaseInfo->versionMajor));
   p_flashData += sizeof(releaseInfo->versionMajor);
   memcpy(&releaseInfo->versionMinor, p_flashData, sizeof(releaseInfo->versionMinor));
   p_flashData += sizeof(releaseInfo->versionMinor);
   memcpy(&releaseInfo->versionSubMinor, p_flashData, sizeof(releaseInfo->versionSubMinor));
   p_flashData += sizeof(releaseInfo->versionSubMinor);

   if ((releaseInfo->versionMajor != RELEASEINFO_MAJOR_VERSION) ||
         (releaseInfo->versionMinor != RELEASEINFO_MINOR_VERSION) ||
         (releaseInfo->versionSubMinor != RELEASEINFO_SUBMINOR_VERSION))
   {
      PRINTF("Wrong release information version (%d.%d.&d).\n",
            releaseInfo->versionMajor, releaseInfo->versionMinor, releaseInfo->versionSubMinor);
      return IRC_FAILURE;
   }

   // Read release firmware version fields
   memcpy(&releaseInfo->firmwareVersionMajor, p_flashData, sizeof(releaseInfo->firmwareVersionMajor));
   p_flashData += sizeof(releaseInfo->firmwareVersionMajor);
   memcpy(&releaseInfo->firmwareVersionMinor, p_flashData, sizeof(releaseInfo->firmwareVersionMinor));
   p_flashData += sizeof(releaseInfo->firmwareVersionMinor);
   memcpy(&releaseInfo->firmwareVersionSubMinor, p_flashData, sizeof(releaseInfo->firmwareVersionSubMinor));
   p_flashData += sizeof(releaseInfo->firmwareVersionSubMinor);
   memcpy(&releaseInfo->firmwareVersionBuild, p_flashData, sizeof(releaseInfo->firmwareVersionBuild));
   p_flashData += sizeof(releaseInfo->firmwareVersionBuild);

   // Read processing FPGA release revision numbers fields
   memcpy(&releaseInfo->releaseProcessingFPGAHardwareRevision, p_flashData, sizeof(releaseInfo->releaseProcessingFPGAHardwareRevision));
   p_flashData += sizeof(releaseInfo->releaseProcessingFPGAHardwareRevision);
   memcpy(&releaseInfo->releaseProcessingFPGASoftwareRevision, p_flashData, sizeof(releaseInfo->releaseProcessingFPGASoftwareRevision));
   p_flashData += sizeof(releaseInfo->releaseProcessingFPGASoftwareRevision);
   memcpy(&releaseInfo->releaseProcessingFPGABootLoaderRevision, p_flashData, sizeof(releaseInfo->releaseProcessingFPGABootLoaderRevision));
   p_flashData += sizeof(releaseInfo->releaseProcessingFPGABootLoaderRevision);
   memcpy(&releaseInfo->releaseProcessingCommonRevision, p_flashData, sizeof(releaseInfo->releaseProcessingCommonRevision));
   p_flashData += sizeof(releaseInfo->releaseProcessingCommonRevision);

   // Read output FPGA release revision numbers fields
   memcpy(&releaseInfo->releaseOutputFPGAHardwareRevision, p_flashData, sizeof(releaseInfo->releaseOutputFPGAHardwareRevision));
   p_flashData += sizeof(releaseInfo->releaseOutputFPGAHardwareRevision);
   memcpy(&releaseInfo->releaseOutputFPGASoftwareRevision, p_flashData, sizeof(releaseInfo->releaseOutputFPGASoftwareRevision));
   p_flashData += sizeof(releaseInfo->releaseOutputFPGASoftwareRevision);
   memcpy(&releaseInfo->releaseOutputFPGABootLoaderRevision, p_flashData, sizeof(releaseInfo->releaseOutputFPGABootLoaderRevision));
   p_flashData += sizeof(releaseInfo->releaseOutputFPGABootLoaderRevision);
   memcpy(&releaseInfo->releaseOutputCommonRevision, p_flashData, sizeof(releaseInfo->releaseOutputCommonRevision));
   p_flashData += sizeof(releaseInfo->releaseOutputCommonRevision);

   // Read storage FPGA release revision numbers fields
   memcpy(&releaseInfo->releaseStorageFPGAHardwareRevision, p_flashData, sizeof(releaseInfo->releaseStorageFPGAHardwareRevision));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGAHardwareRevision);
   memcpy(&releaseInfo->releaseStorageFPGASoftwareRevision, p_flashData, sizeof(releaseInfo->releaseStorageFPGASoftwareRevision));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGASoftwareRevision);
   memcpy(&releaseInfo->releaseStorageFPGABootLoaderRevision, p_flashData, sizeof(releaseInfo->releaseStorageFPGABootLoaderRevision));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGABootLoaderRevision);
   memcpy(&releaseInfo->releaseStorageCommonRevision, p_flashData, sizeof(releaseInfo->releaseStorageCommonRevision));
   p_flashData += sizeof(releaseInfo->releaseStorageCommonRevision);

   releaseInfo->isValid = 1;

   return IRC_SUCCESS;
}

/**
 * Validate firmware release information.
 *
 * @param releaseInfo is the pointer to the firmware release information data structure.
 *
 * @return IRC_SUCCESS if firmware release information was successfully validated.
 * @return IRC_FAILURE if failed to validate firmware release information.
 */
IRC_Status_t ReleaseInfo_Validate(releaseInfo_t *releaseInfo)
{
   if ((!releaseInfo->isValid) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGAHardwareRevision] != releaseInfo->releaseProcessingFPGAHardwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGASoftwareRevision] != releaseInfo->releaseProcessingFPGASoftwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGABootLoaderRevision] != releaseInfo->releaseProcessingFPGABootLoaderRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGACommonRevision] != releaseInfo->releaseProcessingCommonRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGAHardwareRevision] != releaseInfo->releaseOutputFPGAHardwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGASoftwareRevision] != releaseInfo->releaseOutputFPGASoftwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGABootLoaderRevision] != releaseInfo->releaseOutputFPGABootLoaderRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGACommonRevision] != releaseInfo->releaseOutputCommonRevision) ||
         (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask) &&
               ((DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGAHardwareRevision] != releaseInfo->releaseStorageFPGAHardwareRevision) ||
               (DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGASoftwareRevision] != releaseInfo->releaseStorageFPGASoftwareRevision) ||
               (DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGABootLoaderRevision] != releaseInfo->releaseStorageFPGABootLoaderRevision) ||
               (DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGACommonRevision] != releaseInfo->releaseStorageCommonRevision))))
   {
      return IRC_FAILURE;
   }

   // Set device firmware version (copy only least significant byte since header fields are 8-bit wide)
   gcRegsData.DeviceFirmwareMajorVersion = releaseInfo->firmwareVersionMajor & (uint32_t) 0x000000FF;
   gcRegsData.DeviceFirmwareMinorVersion = releaseInfo->firmwareVersionMinor  & (uint32_t) 0x000000FF;
   gcRegsData.DeviceFirmwareSubMinorVersion = releaseInfo->firmwareVersionSubMinor  & (uint32_t) 0x000000FF;
   gcRegsData.DeviceFirmwareBuildVersion = releaseInfo->firmwareVersionBuild  & (uint32_t) 0x000000FF;

   // Set device version
   memset(gcRegsData.DeviceVersion, 0, gcRegsDef[DeviceVersionIdx].dataLength);
   sprintf(gcRegsData.DeviceVersion, "%d.%d.%d.%d",
         (int) gcRegsData.DeviceFirmwareMajorVersion,
         (int) gcRegsData.DeviceFirmwareMinorVersion,
         (int) gcRegsData.DeviceFirmwareSubMinorVersion,
         (int) gcRegsData.DeviceFirmwareBuildVersion);

   return IRC_SUCCESS;
}

/**
 * Print firmware release information.
 *
 * @param releaseInfo is the pointer to the firmware release information structure to fill.
 */
void ReleaseInfo_Print(releaseInfo_t *releaseInfo)
{
   PRINTF("Firmware version: %s\n", gcRegsData.DeviceVersion);
   PRINTF("Processing FPGA hardware revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGAHardwareRevision]);
   PRINTF("Processing FPGA software revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGASoftwareRevision]);
   PRINTF("Processing FPGA boot loader revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGABootLoaderRevision]);
   PRINTF("Processing FPGA common revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGACommonRevision]);
   PRINTF("Output FPGA hardware revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGAHardwareRevision]);
   PRINTF("Output FPGA software revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGASoftwareRevision]);
   PRINTF("Output FPGA boot loader revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGABootLoaderRevision]);
   PRINTF("Output FPGA common revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGACommonRevision]);
   if (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask))
   {
      PRINTF("Storage FPGA hardware revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGAHardwareRevision]);
      PRINTF("Storage FPGA software revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGASoftwareRevision]);
      PRINTF("Storage FPGA boot loader revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGABootLoaderRevision]);
      PRINTF("Storage FPGA common revision: %d\n", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGACommonRevision]);
   }
   PRINTF("XML version: %d.%d.%d\n", gcRegsData.DeviceXMLMajorVersion, gcRegsData.DeviceXMLMinorVersion, gcRegsData.DeviceXMLSubMinorVersion);
}
