/**
 * @file CalibCollectionFile.c
 * Camera calibration collection file structure definition.
 *
 * This file defines camera calibration collection file structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "CalibCollectionFile.h"
#include "CalibBlockFile.h"
#include "FileManager.h"
#include "FlashSettings.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include <string.h>

/**
 * Calibration collection file header parser.
 *
 * @param fd is the calibration collection file descriptor.
 * @param hdr is the pointer to the calibration collection file header structure to fill.
 * @param fileInfo is a pointer to the file info data structure to fill (optional).
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibCollection_ParseCollectionFileHeader(int fd, CalibCollection_CollectionFileHeader_t *hdr, fileInfo_t *fileInfo)
{
   fileInfo_t fi;
   CalibCollection_CollectionFileHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t byteCount;

   if ((fd == -1) || (hdr == NULL))
   {
      return 0;
   }

   if (FI_ParseFileInfo(fd, &fi) != IRC_SUCCESS)
   {
      return 0;
   }

   if (fi.type != FT_TSCO)
   {
      return 0;
   }

   if (uffs_seek(fd, 0, USEEK_SET) == -1)
   {
      return 0;
   }

   if (fi.version.major == 1) headerSize = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V1;
   else if (fi.version.major == 2) headerSize = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2;

   byteCount = uffs_read(fd, tmpFileDataBuffer, headerSize);
   if (byteCount != headerSize)
   {
      return 0;
   }

   if (fi.version.major == 1)
   {
      byteCount = CalibCollection_ParseCollectionFileHeader_v1(tmpFileDataBuffer, byteCount, &hdr_v1);
   }
   else if (fi.version.major == 2)
   {
      byteCount = CalibCollection_ParseCollectionFileHeader_v2(tmpFileDataBuffer, byteCount, hdr);
   }

   if (byteCount == 0)
   {
      return 0;
   }

   switch (fi.version.major)
   {
      case 1:
         // 1.x.x
         switch (fi.version.minor)
         {
            case 0:
               // 1.0.x -> 1.1.x
               hdr_v1.CollectionType = DefaultCollectionType(hdr_v1.CalibrationType);
               hdr_v1.CollectionFileDataLength = hdr_v1.NumberOfBlocks * sizeof(uint32_t);
               hdr_v1.SensorID = 0;
               hdr_v1.NDFPosition = (flashSettings.NDFPresent == 1) ? NDFP_NDFilterInTransition : NDFP_NDFilterNotImplemented;
               hdr_v1.FileStructureMinorVersion = 1;

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr, &hdr_v1, sizeof(*hdr));
               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (fi.version.minor)
         {
            case 0:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = CALIBCOLLECTION_FILESUBMINORVERSION;
         }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return byteCount;
}
