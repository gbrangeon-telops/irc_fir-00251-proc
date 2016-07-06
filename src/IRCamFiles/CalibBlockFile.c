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
   extern CalibBlock_BlockFileHeader_t CalibBlock_BlockFileHeader_default;

   fileInfo_t fi;
   CalibBlock_BlockFileHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (hdr == NULL))
   {
      return 0;
   }

   if ((FI_ParseFileInfo(fd, &fi) != IRC_SUCCESS) || (fi.type != FT_TSBL))
   {
      return 0;
   }

   switch (fi.version.major)
   {
      case 1:
         headerSize = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1;
         if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
         {
            if (CalibBlock_ParseBlockFileHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
            {
               break;
            }
         }
         return 0;

      case 2:
         headerSize = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2;
         if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
         {
            if (CalibBlock_ParseBlockFileHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
            {
               break;
            }
         }
         return 0;

      default:
         return 0;
   }

   minorVersion = fi.version.minor;
   switch (fi.version.major)
   {
      case 1:
         // 1.x.x
         switch (minorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x
               hdr_v1.SensorID = CalibBlock_BlockFileHeader_default.SensorID;
               hdr_v1.FileStructureMinorVersion = 1;

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr->FileSignature, hdr_v1.FileSignature, 5);
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
               hdr->FWFilterID = CalibBlock_BlockFileHeader_default.FWFilterID;
               hdr->NDFilterID = CalibBlock_BlockFileHeader_default.NDFilterID;
               hdr->ManualFilterID = CalibBlock_BlockFileHeader_default.ManualFilterID;
               hdr->LensID = CalibBlock_BlockFileHeader_default.LensID;
               hdr->LowCut = CalibBlock_BlockFileHeader_default.LowCut;
               hdr->HighCut = CalibBlock_BlockFileHeader_default.HighCut;
               hdr->PixelDataPresence = hdr_v1.PixelDataPresence;
               hdr->MaxTKDataPresence = hdr_v1.MaxTKDataPresence;
               hdr->LUTNLDataPresence = hdr_v1.LUTNLDataPresence;
               hdr->LUTRQDataPresence = hdr_v1.LUTRQDataPresence;
               hdr->NumberOfLUTRQ = hdr_v1.NumberOfLUTRQ;

               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
               hdr->FileHeaderLength = CALIBBLOCK_BLOCKFILEHEADER_SIZE;
               hdr->FileHeaderCRC16 = 0;

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = CALIBBLOCK_FILESUBMINORVERSION;
               break;
         }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return headerSize;
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
   CalibBlock_PixelDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
          headerSize = CALIBBLOCK_PIXELDATAHEADER_SIZE_V1;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParsePixelDataHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
             {
                break;
             }
          }
          return 0;

       case 2:
          headerSize = CALIBBLOCK_PIXELDATAHEADER_SIZE_V2;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParsePixelDataHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
             {
                break;
             }
          }
          return 0;

       default:
          return 0;
   }

   minorVersion = fileInfo->version.minor;
   switch (fileInfo->version.major)
   {
      case 1:
         // 1.x.x
         switch (minorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr, &hdr_v1, sizeof(*hdr));

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // Up to date, nothing to do
               break;
         }
   }

   return headerSize;
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
   CalibBlock_MaxTKDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
          headerSize = CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParseMaxTKDataHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
             {
                break;
             }
          }
          return 0;

       case 2:
          headerSize = CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParseMaxTKDataHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
             {
                break;
             }
          }
          return 0;

       default:
          return 0;
   }

   minorVersion = fileInfo->version.minor;
   switch (fileInfo->version.major)
   {
      case 1:
         // 1.x.x
         switch (minorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr, &hdr_v1, sizeof(*hdr));

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // Up to date, nothing to do
               break;
         }
   }

   return headerSize;
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
   CalibBlock_LUTNLDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
          headerSize = CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParseLUTNLDataHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
             {
                break;
             }
          }
          return 0;

       case 2:
          headerSize = CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParseLUTNLDataHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
             {
                break;
             }
          }
          return 0;

       default:
          return 0;
   }

   minorVersion = fileInfo->version.minor;
   switch (fileInfo->version.major)
   {
      case 1:
         // 1.x.x
         switch (minorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr, &hdr_v1, sizeof(*hdr));

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // Up to date, nothing to do
               break;
         }
   }

   return headerSize;
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
   CalibBlock_LUTRQDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
          headerSize = CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParseLUTRQDataHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
             {
                break;
             }
          }
          return 0;

       case 2:
          headerSize = CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibBlock_ParseLUTRQDataHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
             {
                break;
             }
          }
          return 0;

       default:
          return 0;
   }

   minorVersion = fileInfo->version.minor;
   switch (fileInfo->version.major)
   {
      case 1:
         // 1.x.x
         switch (minorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x

            case 1:
               // 1.1.x -> 2.0.x
               memcpy(hdr, &hdr_v1, sizeof(*hdr));

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // Up to date, nothing to do
               break;
         }
   }

   return headerSize;
}
