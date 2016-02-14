/**
 * @file ReleaseInfo.h
 * Firmware release information module header.
 *
 * This file declares the firmware release informationn module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef RELEASEINFO_H
#define RELEASEINFO_H

#include "QSPIFlash.h"
#include "IRC_Status.h"
#include "proc_prom.h"

/**
 * Release information page index in QPSI flash memory
 */
#define RELEASEINFO_FLASH_PAGE_IDX     (PROM_RELEASE_INFO_BASEADDR / PAGE_SIZE)

/**
 * Release information length in bytes
 */
#define RELEASEINFO_LENGTH             80

/**
 * Release information structure version
 */
#define RELEASEINFO_MAJOR_VERSION      2
#define RELEASEINFO_MINOR_VERSION      1
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

   uint32_t releaseStorageFPGAHardwareRevision;
   uint32_t releaseStorageFPGASoftwareRevision;
   uint32_t releaseStorageFPGABootLoaderRevision;
   uint32_t releaseStorageCommonRevision;
};

/**
 * Firmware release information data type
 */
typedef struct releaseInfoStruct releaseInfo_t;

IRC_Status_t ReleaseInfo_Read(qspiFlash_t *qspiFlash, releaseInfo_t *releaseInfo);
IRC_Status_t ReleaseInfo_Validate(releaseInfo_t *releaseInfo);
void ReleaseInfo_Print(releaseInfo_t *releaseInfo);

#endif // RELEASEINFO_H
