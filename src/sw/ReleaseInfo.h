/**
 * @file ReleaseInfo.h
 * Firmware release information module header.
 *
 * This file declares the firmware release informationn module.
 *
 * $Rev: 22585 $
 * $Author: elarouche $
 * $Date: 2018-12-04 10:04:04 -0500 (mar., 04 déc. 2018) $
 * $Id: ReleaseInfo.h 22585 2018-12-04 15:04:04Z elarouche $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/ReleaseInfo.h $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef RELEASEINFO_H
#define RELEASEINFO_H

#include "QSPIFlash.h"
#include "IRC_Status.h"
#include "proc_prom.h"

#define RI_ERR(fmt, ...)         FPGA_PRINTF("RI: Error: " fmt "\n", ##__VA_ARGS__)
#define RI_INF(fmt, ...)         FPGA_PRINTF("RI: Info: " fmt "\n", ##__VA_ARGS__)

/**
 * Release information page index in QPSI flash memory
 */
#define RELEASEINFO_FLASH_PAGE_IDX     (PROM_RELEASE_INFO_BASEADDR / PAGE_SIZE)

/**
 * Release information length in bytes
 */
#define RELEASEINFO_LENGTH             96

/**
 * Release information structure version
 */
#define RELEASEINFO_MAJOR_VERSION      2
#define RELEASEINFO_MINOR_VERSION      2
#define RELEASEINFO_SUBMINOR_VERSION   0

/**
 * Firmware release information structure
 */
struct releaseInfoStruct {
   uint8_t isValid;
   uint32_t length;
   uint32_t versionMajor;
   uint32_t versionMinor;
   uint32_t versionSubMinor;

   uint32_t firmwareVersionMajor;
   uint32_t firmwareVersionMinor;
   uint32_t firmwareVersionSubMinor;
   uint32_t firmwareVersionBuild;

   uint32_t releaseProcessingFPGAHardwareRevision;
   uint32_t releaseProcessingFPGASoftwareRevision;
   uint32_t releaseProcessingFPGABootLoaderRevision;
   uint32_t releaseProcessingCommonRevision;

   uint32_t releaseOutputFPGAHardwareRevision;
   uint32_t releaseOutputFPGASoftwareRevision;
   uint32_t releaseOutputFPGABootLoaderRevision;
   uint32_t releaseOutputCommonRevision;

   uint32_t releaseStorageFPGAHardwareRevision1;
   uint32_t releaseStorageFPGASoftwareRevision1;
   uint32_t releaseStorageFPGABootLoaderRevision1;
   uint32_t releaseStorageCommonRevision1;

   uint32_t releaseStorageFPGAHardwareRevision2;
   uint32_t releaseStorageFPGASoftwareRevision2;
   uint32_t releaseStorageFPGABootLoaderRevision2;
   uint32_t releaseStorageCommonRevision2;
};

/**
 * Firmware release information data type
 */
typedef struct releaseInfoStruct releaseInfo_t;

IRC_Status_t ReleaseInfo_Read(qspiFlash_t *qspiFlash, releaseInfo_t *releaseInfo);
IRC_Status_t ReleaseInfo_Validate(releaseInfo_t *releaseInfo);
void ReleaseInfo_Print(releaseInfo_t *releaseInfo);

#endif // RELEASEINFO_H
