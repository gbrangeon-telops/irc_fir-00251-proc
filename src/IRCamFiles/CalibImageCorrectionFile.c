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
   extern CalibImageCorrection_ImageCorrectionFileHeader_t CalibImageCorrection_ImageCorrectionFileHeader_default;

   fileInfo_t fi;
   CalibActualization_ActualizationFileHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (hdr == NULL))
   {
      return 0;
   }

   if ((FI_ParseFileInfo(fd, &fi) != IRC_SUCCESS) || ((fi.type != FT_TSAC) && (fi.type != FT_TSIC)))
   {
      return 0;
   }

   switch (fi.version.major)
   {
       case 1:
          headerSize = CALIBACTUALIZATION_ACTUALIZATIONFILEHEADER_SIZE_V1;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibActualization_ParseActualizationFileHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
             {
                break;
             }
          }
          return 0;

       case 2:
          headerSize = CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE_V2;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibImageCorrection_ParseImageCorrectionFileHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
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
               hdr_v1.SensorID = CalibImageCorrection_ImageCorrectionFileHeader_default.SensorID;
               hdr_v1.FileStructureMinorVersion = 1;

            case 1:
            default:
               // 1.1.x -> 2.0.x
               memcpy(hdr->FileSignature, hdr_v1.FileSignature, 5);
               hdr->DeviceSerialNumber = hdr_v1.DeviceSerialNumber;
               hdr->POSIXTime = hdr_v1.POSIXTime;
               memcpy(hdr->FileDescription, hdr_v1.FileDescription, 65);
               hdr->DeviceDataFlowMajorVersion = hdr_v1.DeviceDataFlowMajorVersion;
               hdr->DeviceDataFlowMinorVersion = hdr_v1.DeviceDataFlowMinorVersion;
               hdr->SensorID = hdr_v1.SensorID;
               hdr->ImageCorrectionType = CalibImageCorrection_ImageCorrectionFileHeader_default.ImageCorrectionType;
               hdr->Width = hdr_v1.Width;
               hdr->Height = hdr_v1.Height;
               hdr->OffsetX = hdr_v1.OffsetX;
               hdr->OffsetY = hdr_v1.OffsetY;
               hdr->ReferencePOSIXTime = hdr_v1.ReferencePOSIXTime;
               hdr->TemperatureInternalLens = CalibImageCorrection_ImageCorrectionFileHeader_default.TemperatureInternalLens;
               hdr->TemperatureReference = CalibImageCorrection_ImageCorrectionFileHeader_default.TemperatureReference;
               hdr->ExposureTime = CalibImageCorrection_ImageCorrectionFileHeader_default.ExposureTime;

               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
               hdr->FileHeaderLength = CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE;
               hdr->FileHeaderCRC16 = 0;

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // 2.0.x -> 2.1.x
               // Nothing to do
               hdr->FileStructureMinorVersion = 1;

            case 1:
               // 2.1.x -> 2.2.x
               hdr->AcquisitionFrameRate = CalibImageCorrection_ImageCorrectionFileHeader_default.AcquisitionFrameRate;
               hdr->FWMode = CalibImageCorrection_ImageCorrectionFileHeader_default.FWMode;
               hdr->FocusPositionRaw = CalibImageCorrection_ImageCorrectionFileHeader_default.FocusPositionRaw;
               hdr->FileStructureMinorVersion = 2;

            case 2:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = CALIBIMAGECORRECTION_FILESUBMINORVERSION;
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
   CalibActualization_ActualizationDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (fileInfo == NULL) || ((fileInfo->type != FT_TSAC) && (fileInfo->type != FT_TSIC))  || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
          headerSize = CALIBACTUALIZATION_ACTUALIZATIONDATAHEADER_SIZE_V1;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibActualization_ParseActualizationDataHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
             {
                break;
             }
          }
          return 0;

       case 2:
          headerSize = CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE_V2;
          if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
          {
             if (CalibImageCorrection_ParseImageCorrectionDataHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
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
               // 2.0.x -> 2.1.x
               // Nothing to do

            case 1:
               // 2.1.x -> 2.2.x
               // Nothing to do

            case 2:
               // Up to date, nothing to do
               break;
         }
   }

   return headerSize;
}
