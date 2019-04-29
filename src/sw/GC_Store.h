/**
 * @file GC_Store.h
 * GenICam parameters storage
 *
 * This file declares the GenICam parameters storage interface.
 *
 * $Rev: 22942 $
 * $Author: elarouche $
 * $Date: 2019-02-26 11:04:07 -0500 (mar., 26 févr. 2019) $
 * $Id: GC_Store.h 22942 2019-02-26 16:04:07Z elarouche $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/GC_Store.h $
 *
 * (c) Copyright 2019 Telops Inc.
 */


#ifndef GC_STORE_H
#define GC_STORE_H

#include "QSPIFlash.h"
#include "IRC_Status.h"

#define GCS_INF(fmt, ...)         FPGA_PRINTF("GCS: Info: " fmt "\n", ##__VA_ARGS__)
#define GCS_ERR(fmt, ...)         FPGA_PRINTF("GCS: Error: " fmt "\n", ##__VA_ARGS__)

#define GC_STORE_SIG "GCPS"
#define GC_STORE_BUFSIZE 4096    /* GC Store buffer size in bytes */

/**
 * GC store structure version
 */
#define GCSTORE_MAJOR_VERSION      1
#define GCSTORE_MINOR_VERSION      0
#define GCSTORE_SUBMINOR_VERSION   0


/**
 * GenIcam parameters store header structure
 */
struct gcStoreHeaderStruct {
   char Sig[4];                  /* magic signature */
   uint16_t HeaderCRC16;         /* header CRC-16 */
   uint16_t StoreCRC16;          /* data store CRC-16 */
   uint32_t length;              /* header length in bytes */
   uint32_t versionMajor;        /* structure major version */
   uint32_t versionMinor;        /* structure minor version */
   uint32_t versionSubMinor;     /* structure subminor version */
   uint32_t XmlVersionMajor;     /* XML major version */
   uint32_t XmlVersionMinor;     /* XML minor version */
   uint32_t XmlVersionSubMinor;  /* XML subminor version */
   uint32_t StoreSize;           /* GenIcam parameters store's size in bytes */
   uint8_t GCStore[];            /* GenIcam parameters store following the header */
};

/**
 * GenIcam parameters store header data type
 */
typedef struct gcStoreHeaderStruct gcStoreHeader_t;

typedef enum
{
   gcStoreIdle,
   doErase,
   finishErase,
   doSave,
   eraseBeforeWrite,
   writeInProgress,
   finishWrite
} gcStoreState_t;


/* Prototypes */
IRC_Status_t GC_Store_Save(qspiFlash_t *qspiFlash);
IRC_Status_t GC_Store_Load(qspiFlash_t *qspiFlash);
IRC_Status_t GC_Store_Erase(qspiFlash_t *qspiFlash);
void GC_Store_SM(qspiFlash_t *qspiFlash);

#endif
