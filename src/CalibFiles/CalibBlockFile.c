/**
 * @file CalibBlockFile.c
 * Camera calibration block file structure definition.
 *
 * This file defines camera calibration block file structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "CalibBlockFile.h"
#include "FileManager.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include <string.h>

/**
 * Calibration block file header parser.
 *
 * @param fd is the calibration block file descriptor.
 * @param hdr is the pointer to the calibration block file header structure to fill.
 * @param fileInfo is a pointer to the file info data structure to fill (optional).
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseBlockFileHeader(int fd, CalibBlock_BlockFileHeader_t *hdr, fileInfo_t *fileInfo)
{
   fileInfo_t fi;
   CalibBlock_BlockFileHeader_v1_t hdr_v1;
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

   if (fi.type != FT_TSBL)
   {
      return 0;
   }

   if (uffs_seek(fd, 0, USEEK_SET) == -1)
   {
      return 0;
   }

   if (fi.version.major == 1) headerSize = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1;
   else if (fi.version.major == 2) headerSize = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2;

   byteCount = uffs_read(fd, tmpFileDataBuffer, headerSize);
   if (byteCount != headerSize)
   {
      return 0;
   }

   if (fi.version.major == 1)
   {
      byteCount = CalibBlock_ParseBlockFileHeader_v1(tmpFileDataBuffer, byteCount, &hdr_v1);
   }
   else if (fi.version.major == 2)
   {
      byteCount = CalibBlock_ParseBlockFileHeader_v2(tmpFileDataBuffer, byteCount, hdr);
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
               hdr->FileHeaderLength = hdr_v1.BlockFileHeaderLength;
               hdr->DeviceSerialNumber = hdr_v1.DeviceSerialNumber;
               hdr->POSIXTime = hdr_v1.POSIXTime;
               memcpy(hdr->FileDescription, hdr_v1.FileDescription, 65);
               hdr->DeviceDataFlowMajorVersion = hdr_v1.DeviceDataFlowMajorVersion;
               hdr->DeviceDataFlowMinorVersion = hdr_v1.DeviceDataFlowMinorVersion;
               hdr->SensorID = hdr_v1.SensorID;
               hdr->CalibrationSource = hdr_v1.CalibrationSource;
               hdr->CalibrationType = hdr_v1.CalibrationType;
               hdr->IntegrationMode = hdr_v1.IntegrationMode;
               hdr->SensorWellDepth = hdr_v1.SensorWellDepth;
               hdr->PixelDataResolution = hdr_v1.PixelDataResolution;
               hdr->Width = hdr_v1.Width;
               hdr->Height = hdr_v1.Height;
               hdr->OffsetX = hdr_v1.OffsetX;
               hdr->OffsetY = hdr_v1.OffsetY;
               hdr->ReverseX = hdr_v1.ReverseX;
               hdr->ReverseY = hdr_v1.ReverseY;
               hdr->ExternalLensSerialNumber = hdr_v1.ExternalLensSerialNumber;
               memcpy(hdr->ExternalLensName, hdr_v1.ExternalLensName, 65);
               hdr->ManualFilterSerialNumber = hdr_v1.ManualFilterSerialNumber;
               memcpy(hdr->ManualFilterName, hdr_v1.ManualFilterName, 65);
               hdr->ExposureTime = hdr_v1.ExposureTime;
               hdr->AcquisitionFrameRate = hdr_v1.AcquisitionFrameRate;
               hdr->FWPosition = hdr_v1.FWPosition;
               hdr->NDFPosition = hdr_v1.NDFPosition;
               hdr->SensorWidth = hdr_v1.SensorWidth;
               hdr->SensorHeight = hdr_v1.SensorHeight;
               hdr->PixelDynamicRangeMin = hdr_v1.PixelDynamicRangeMin;
               hdr->PixelDynamicRangeMax = hdr_v1.PixelDynamicRangeMax;
               hdr->SaturationThreshold = hdr_v1.SaturationThreshold;
               hdr->BlockBadPixelCount = hdr_v1.BlockBadPixelCount;
               hdr->MaximumTotalFlux = hdr_v1.MaximumTotalFlux;
               hdr->NUCMultFactor = hdr_v1.NUCMultFactor;
               hdr->T0 = hdr_v1.T0;
               hdr->Nu = hdr_v1.Nu;
               hdr->DeviceTemperatureSensor = hdr_v1.DeviceTemperatureSensor;
               hdr->SpectralResponsePOSIXTime = hdr_v1.SpectralResponsePOSIXTime;
               hdr->ReferencePOSIXTime = hdr_v1.ReferencePOSIXTime;
               hdr->FWFilterID = 0;
               hdr->NDFilterID = 0;
               hdr->ManualFilterID = 0;
               hdr->LensID = 0;
               hdr->LowCut = 0.0F;
               hdr->HighCut = 0.0F;
               hdr->PixelDataPresence = hdr_v1.PixelDataPresence;
               hdr->MaxTKDataPresence = hdr_v1.MaxTKDataPresence;
               hdr->LUTNLDataPresence = hdr_v1.LUTNLDataPresence;
               hdr->LUTRQDataPresence = hdr_v1.LUTRQDataPresence;
               hdr->NumberOfLUTRQ = hdr_v1.NumberOfLUTRQ;
               hdr->FileHeaderCRC16 = hdr_v1.BlockFileHeaderCRC16;
               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (fi.version.minor)
         {
            case 0:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = CALIBBLOCK_FILESUBMINORVERSION;
         }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return byteCount;
}

/**
 * Calibration block pixel data header parser.
 *
 * @param fd is the calibration block file descriptor.
 * @param fileInfo is a pointer to the calibration block file information data structure.
 * @param hdr is the pointer to the calibration block pixel data header structure to fill.
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParsePixelDataHeader(int fd, fileInfo_t *fileInfo, CalibBlock_PixelDataHeader_t *hdr)
{
   uint32_t byteCount;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   byteCount = uffs_read(fd, tmpFileDataBuffer, CALIBBLOCK_PIXELDATAHEADER_SIZE_V2);
   if (byteCount != CALIBBLOCK_PIXELDATAHEADER_SIZE_V2)
   {
      return 0;
   }

   byteCount = CalibBlock_ParsePixelDataHeader_v2(tmpFileDataBuffer, byteCount, hdr);
   if (byteCount == 0)
   {
      return 0;
   }

   return byteCount;
}

/**
 * MaxTK data header parser.
 *
 * @param fd is the calibration block file descriptor.
 * @param fileInfo is a pointer to the calibration block file information data structure.
 * @param hdr is the pointer to the calibration MaxTK data header structure to fill.
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseMaxTKDataHeader(int fd, fileInfo_t *fileInfo, CalibBlock_MaxTKDataHeader_t *hdr)
{
   uint32_t byteCount;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   byteCount = uffs_read(fd, tmpFileDataBuffer, CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2);
   if (byteCount != CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2)
   {
      return 0;
   }

   byteCount = CalibBlock_ParseMaxTKDataHeader_v2(tmpFileDataBuffer, byteCount, hdr);
   if (byteCount == 0)
   {
      return 0;
   }

   return byteCount;
}

/**
 * LUTNL data header parser.
 *
 * @param fd is the calibration block file descriptor.
 * @param fileInfo is a pointer to the calibration block file information data structure.
 * @param hdr is the pointer to the calibration LUTNL data header structure to fill.
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseLUTNLDataHeader(int fd, fileInfo_t *fileInfo, CalibBlock_LUTNLDataHeader_t *hdr)
{
   uint32_t byteCount;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   byteCount = uffs_read(fd, tmpFileDataBuffer, CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2);
   if (byteCount != CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2)
   {
      return 0;
   }

   byteCount = CalibBlock_ParseLUTNLDataHeader_v2(tmpFileDataBuffer, byteCount, hdr);
   if (byteCount == 0)
   {
      return 0;
   }

   return byteCount;
}

/**
 * LUTRQ data header parser.
 *
 * @param fd is the calibration block file descriptor.
 * @param fileInfo is a pointer to the calibration block file information data structure.
 * @param hdr is the pointer to the calibration LUTNL data header structure to fill.
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t CalibBlock_ParseLUTRQDataHeader(int fd, fileInfo_t *fileInfo, CalibBlock_LUTRQDataHeader_t *hdr)
{
   uint32_t byteCount;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   byteCount = uffs_read(fd, tmpFileDataBuffer, CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2);
   if (byteCount != CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2)
   {
      return 0;
   }

   byteCount = CalibBlock_ParseLUTRQDataHeader_v2(tmpFileDataBuffer, byteCount, hdr);
   if (byteCount == 0)
   {
      return 0;
   }

   return byteCount;
}
