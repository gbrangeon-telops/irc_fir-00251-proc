/**
 * @file CalibImageCorrectionFile.c
 * Camera image correction calibration file structure definition.
 *
 * This file defines camera image correction calibration file structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "CalibImageCorrectionFile.h"
#include "FileManager.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include <string.h>

/**
 * Image correction calibration file header parser.
 *
 * @param fd is the image correction calibration file descriptor.
 * @param hdr is the pointer to the image correction calibration file header structure to fill.
 * @param fileInfo is a pointer to the file info data structure to fill (optional).
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_ParseImageCorrectionFileHeader(int fd, CalibImageCorrection_ImageCorrectionFileHeader_t *hdr, fileInfo_t *fileInfo)
{
   fileInfo_t fi;
   CalibActualization_ActualizationFileHeader_v1_t hdr_v1;
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

   if ((fi.type != FT_TSAC) && (fi.type != FT_TSIC))
   {
      return 0;
   }

   if (uffs_seek(fd, 0, USEEK_SET) == -1)
   {
      return 0;
   }

   if (fi.version.major == 1) headerSize = CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1;
   else if (fi.version.major == 2) headerSize = CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2;

   byteCount = uffs_read(fd, tmpFileDataBuffer, headerSize);
   if (byteCount != headerSize)
   {
      return 0;
   }

   if (fi.version.major == 1)
   {
      byteCount = CalibActualization_ParseActualizationFileHeader_v1(tmpFileDataBuffer, byteCount, &hdr_v1);
   }
   else if (fi.version.major == 2)
   {
      byteCount = CalibImageCorrection_ParseImageCorrectionFileHeader_v2(tmpFileDataBuffer, byteCount, hdr);
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
               hdr_v1.SensorID = 0;
               hdr_v1.FileStructureMinorVersion = 1;

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr->FileSignature, hdr_v1.FileSignature, 5);
               hdr->FileHeaderLength = hdr_v1.ActualizationFileHeaderLength;
               hdr->DeviceSerialNumber = hdr_v1.DeviceSerialNumber;
               hdr->POSIXTime = hdr_v1.POSIXTime;
               memcpy(hdr->FileDescription, hdr_v1.FileDescription, 65);
               hdr->DeviceDataFlowMajorVersion = hdr_v1.DeviceDataFlowMajorVersion;
               hdr->DeviceDataFlowMinorVersion = hdr_v1.DeviceDataFlowMinorVersion;
               hdr->SensorID = hdr_v1.SensorID;
               hdr->ImageCorrectionType = 0;
               hdr->Width = hdr_v1.Width;
               hdr->Height = hdr_v1.Height;
               hdr->OffsetX = hdr_v1.OffsetX;
               hdr->OffsetY = hdr_v1.OffsetY;
               hdr->ReferencePOSIXTime = hdr_v1.ReferencePOSIXTime;
               hdr->TemperatureInternalLens = 0;
               hdr->TemperatureReference = 0;
               hdr->ExposureTime = 0;
               hdr->FileHeaderCRC16 = hdr_v1.ActualizationFileHeaderCRC16;
               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (fi.version.minor)
         {
            case 0:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = CALIBIMAGECORRECTION_FILESUBMINORVERSION;
         }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return byteCount;
}

/**
 * Image correction calibration data header parser.
 *
 * @param fd is the image correction calibration file descriptor.
 * @param fileInfo is a pointer to the image correction calibration file information data structure.
 * @param hdr is the pointer to the image correction data calibration header structure to fill.
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibImageCorrection_ParseImageCorrectionDataHeader(int fd, fileInfo_t *fileInfo, CalibImageCorrection_ImageCorrectionDataHeader_t *hdr)
{
   uint32_t byteCount;

   if ((fd == -1) || (fileInfo == NULL) || ((fileInfo->type != FT_TSAC) && (fileInfo->type != FT_TSIC))  || (hdr == NULL))
   {
      return 0;
   }

   byteCount = uffs_read(fd, tmpFileDataBuffer, CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2);
   if (byteCount != CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2)
   {
      return 0;
   }

   byteCount = CalibImageCorrection_ParseImageCorrectionDataHeader_v2(tmpFileDataBuffer, byteCount, hdr);
   if (byteCount == 0)
   {
      return 0;
   }

   return byteCount;
}
