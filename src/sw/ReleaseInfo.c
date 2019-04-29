/**
 * @file ReleaseInfo.c
 * Firmware release information module implementation.
 *
 * This file implements firmware release information module.
 * 
 * $Rev: 22769 $
 * $Author: elarouche $
 * $Date: 2019-01-23 10:27:06 -0500 (mer., 23 janv. 2019) $
 * $Id: ReleaseInfo.c 22769 2019-01-23 15:27:06Z elarouche $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/ReleaseInfo.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include <stdbool.h>
#include "ReleaseInfo.h"
#include "FlashSettingsFile.h"
#include "FlashDynamicValuesFile.h"
#include "CalibBlockFile.h"
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
      RI_ERR("Release information QSPI flash page read failed.");
      return IRC_FAILURE;
   }

   p_flashData = flashData;

   // Read release information length field
   memcpy(&releaseInfo->length, p_flashData, sizeof(releaseInfo->length));
   p_flashData += sizeof(releaseInfo->length);

   if (releaseInfo->length != RELEASEINFO_LENGTH)
   {
      RI_ERR("Wrong release information length (%d).", releaseInfo->length);
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
      RI_ERR("Wrong release information version (%d.%d.%d).",
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
   memcpy(&releaseInfo->releaseStorageFPGAHardwareRevision1, p_flashData, sizeof(releaseInfo->releaseStorageFPGAHardwareRevision1));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGAHardwareRevision1);
   memcpy(&releaseInfo->releaseStorageFPGASoftwareRevision1, p_flashData, sizeof(releaseInfo->releaseStorageFPGASoftwareRevision1));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGASoftwareRevision1);
   memcpy(&releaseInfo->releaseStorageFPGABootLoaderRevision1, p_flashData, sizeof(releaseInfo->releaseStorageFPGABootLoaderRevision1));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGABootLoaderRevision1);
   memcpy(&releaseInfo->releaseStorageCommonRevision1, p_flashData, sizeof(releaseInfo->releaseStorageCommonRevision1));
   p_flashData += sizeof(releaseInfo->releaseStorageCommonRevision1);

   memcpy(&releaseInfo->releaseStorageFPGAHardwareRevision2, p_flashData, sizeof(releaseInfo->releaseStorageFPGAHardwareRevision2));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGAHardwareRevision2);
   memcpy(&releaseInfo->releaseStorageFPGASoftwareRevision2, p_flashData, sizeof(releaseInfo->releaseStorageFPGASoftwareRevision2));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGASoftwareRevision2);
   memcpy(&releaseInfo->releaseStorageFPGABootLoaderRevision2, p_flashData, sizeof(releaseInfo->releaseStorageFPGABootLoaderRevision2));
   p_flashData += sizeof(releaseInfo->releaseStorageFPGABootLoaderRevision2);
   memcpy(&releaseInfo->releaseStorageCommonRevision2, p_flashData, sizeof(releaseInfo->releaseStorageCommonRevision2));
   p_flashData += sizeof(releaseInfo->releaseStorageCommonRevision2);

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
   bool f1, f2;

   /* Verify first set of Storage SVN revision numbers */
   f1 = DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGAHardwareRevision] == releaseInfo->releaseStorageFPGAHardwareRevision1 &&
        DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGASoftwareRevision] == releaseInfo->releaseStorageFPGASoftwareRevision1 &&
        DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGABootLoaderRevision] == releaseInfo->releaseStorageFPGABootLoaderRevision1 &&
        DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGACommonRevision] == releaseInfo->releaseStorageCommonRevision1;

   /* Verify second set of Storage SVN revision numbers */
   f2 = DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGAHardwareRevision] == releaseInfo->releaseStorageFPGAHardwareRevision2 &&
        DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGASoftwareRevision] == releaseInfo->releaseStorageFPGASoftwareRevision2 &&
        DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGABootLoaderRevision] == releaseInfo->releaseStorageFPGABootLoaderRevision2 &&
        DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGACommonRevision] == releaseInfo->releaseStorageCommonRevision2;

   if ((!releaseInfo->isValid) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGAHardwareRevision] != releaseInfo->releaseProcessingFPGAHardwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGASoftwareRevision] != releaseInfo->releaseProcessingFPGASoftwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGABootLoaderRevision] != releaseInfo->releaseProcessingFPGABootLoaderRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGACommonRevision] != releaseInfo->releaseProcessingCommonRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGAHardwareRevision] != releaseInfo->releaseOutputFPGAHardwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGASoftwareRevision] != releaseInfo->releaseOutputFPGASoftwareRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGABootLoaderRevision] != releaseInfo->releaseOutputFPGABootLoaderRevision) ||
         (DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGACommonRevision] != releaseInfo->releaseOutputCommonRevision) ||
         (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask) && !f1 && !f2))
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
   RI_INF("Firmware version: %s", gcRegsData.DeviceVersion);
   RI_INF("Processing FPGA hardware revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGAHardwareRevision]);
   RI_INF("Processing FPGA software revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGASoftwareRevision]);
   RI_INF("Processing FPGA boot loader revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGABootLoaderRevision]);
   RI_INF("Processing FPGA common revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_ProcessingFPGACommonRevision]);
   RI_INF("Output FPGA hardware revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGAHardwareRevision]);
   RI_INF("Output FPGA software revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGASoftwareRevision]);
   RI_INF("Output FPGA boot loader revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGABootLoaderRevision]);
   RI_INF("Output FPGA common revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_OutputFPGACommonRevision]);
   if (TDCFlagsTst(ExternalMemoryBufferIsImplementedMask))
   {
      RI_INF("Storage FPGA hardware revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGAHardwareRevision]);
      RI_INF("Storage FPGA software revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGASoftwareRevision]);
      RI_INF("Storage FPGA boot loader revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGABootLoaderRevision]);
      RI_INF("Storage FPGA common revision: %d", DeviceFirmwareModuleRevisionAry[DFMS_StorageFPGACommonRevision]);
   }
   RI_INF("XML version: %d.%d.%d", gcRegsData.DeviceXMLMajorVersion, gcRegsData.DeviceXMLMinorVersion, gcRegsData.DeviceXMLSubMinorVersion);
   RI_INF("Flash settings version: %d.%d.%d", FLASHSETTINGS_FILEMAJORVERSION, FLASHSETTINGS_FILEMINORVERSION, FLASHSETTINGS_FILESUBMINORVERSION);
   RI_INF("Flash dynamic values version: %d.%d.%d", FLASHDYNAMICVALUES_FILEMAJORVERSION, FLASHDYNAMICVALUES_FILEMINORVERSION, FLASHDYNAMICVALUES_FILESUBMINORVERSION);
   RI_INF("Calibration files version: %d.%d.%d", CALIBBLOCK_FILEMAJORVERSION, CALIBBLOCK_FILEMINORVERSION, CALIBBLOCK_FILESUBMINORVERSION);
}
