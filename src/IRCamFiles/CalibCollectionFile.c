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
   extern CalibCollection_CollectionFileHeader_t CalibCollection_CollectionFileHeader_default;

   fileInfo_t fi;
   CalibCollection_CollectionFileHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (hdr == NULL))
   {
      return 0;
   }

   if ((FI_ParseFileInfo(fd, &fi) != IRC_SUCCESS) || (fi.type != FT_TSCO))
   {
      return 0;
   }

   switch (fi.version.major)
   {
      case 1:
         headerSize = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V1;
         if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
         {
            if (CalibCollection_ParseCollectionFileHeader_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
            {
               break;
            }
         }
         return 0;

      case 2:
         headerSize = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2;
         if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
         {
            if (CalibCollection_ParseCollectionFileHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
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
               hdr_v1.CollectionType = DefaultCollectionType(hdr_v1.CalibrationType);
               hdr_v1.CollectionFileDataLength = hdr_v1.NumberOfBlocks * sizeof(uint32_t);
               hdr_v1.SensorID = CalibCollection_CollectionFileHeader_default.SensorID;
               hdr_v1.NDFPosition = (flashSettings.NDFPresent == 1) ? NDFP_NDFilterInTransition : NDFP_NDFilterNotImplemented;
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
               hdr->CollectionType = hdr_v1.CollectionType;
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
               hdr->FWPosition = hdr_v1.FWPosition;
               hdr->NDFPosition = hdr_v1.NDFPosition;
               hdr->ExternalLensSerialNumber = hdr_v1.ExternalLensSerialNumber;
               memcpy(hdr->ExternalLensName, hdr_v1.ExternalLensName, 65);
               hdr->ManualFilterSerialNumber = hdr_v1.ManualFilterSerialNumber;
               memcpy(hdr->ManualFilterName, hdr_v1.ManualFilterName, 65);
               hdr->ReferencePOSIXTime = hdr_v1.ReferencePOSIXTime;
               hdr->FluxRatio01 = hdr_v1.FluxRatio01;
               hdr->FluxRatio12 = hdr_v1.FluxRatio12;
               hdr->CollectionDataLength = hdr_v1.CollectionFileDataLength;
               hdr->NumberOfBlocks = hdr_v1.NumberOfBlocks;
               hdr->CollectionDataCRC16 = hdr_v1.CollectionFileDataCRC16;

               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
               hdr->FileHeaderLength = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE;
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
               hdr->FOVPosition = CalibCollection_CollectionFileHeader_default.FOVPosition;
               hdr->FileStructureMinorVersion = 2;

            case 2:
               // 2.2.x -> 2.3.x
               hdr->ExtenderRingSerialNumber = CalibCollection_CollectionFileHeader_default.ExtenderRingSerialNumber;
               memcpy(hdr->ExtenderRingName, CalibCollection_CollectionFileHeader_default.ExtenderRingName, 65);
               hdr->Block1ImageShiftX = CalibCollection_CollectionFileHeader_default.Block1ImageShiftX;
               hdr->Block1ImageShiftY = CalibCollection_CollectionFileHeader_default.Block1ImageShiftY;
               hdr->Block1ImageRotation = CalibCollection_CollectionFileHeader_default.Block1ImageRotation;
               hdr->Block2ImageShiftX = CalibCollection_CollectionFileHeader_default.Block2ImageShiftX;
               hdr->Block2ImageShiftY = CalibCollection_CollectionFileHeader_default.Block2ImageShiftY;
               hdr->Block2ImageRotation = CalibCollection_CollectionFileHeader_default.Block2ImageRotation;
               hdr->Block3ImageShiftX = CalibCollection_CollectionFileHeader_default.Block3ImageShiftX;
               hdr->Block3ImageShiftY = CalibCollection_CollectionFileHeader_default.Block3ImageShiftY;
               hdr->Block3ImageRotation = CalibCollection_CollectionFileHeader_default.Block3ImageRotation;
               hdr->Block4ImageShiftX = CalibCollection_CollectionFileHeader_default.Block4ImageShiftX;
               hdr->Block4ImageShiftY = CalibCollection_CollectionFileHeader_default.Block4ImageShiftY;
               hdr->Block4ImageRotation = CalibCollection_CollectionFileHeader_default.Block4ImageRotation;
               hdr->Block5ImageShiftX = CalibCollection_CollectionFileHeader_default.Block5ImageShiftX;
               hdr->Block5ImageShiftY = CalibCollection_CollectionFileHeader_default.Block5ImageShiftY;
               hdr->Block5ImageRotation = CalibCollection_CollectionFileHeader_default.Block5ImageRotation;
               hdr->Block6ImageShiftX = CalibCollection_CollectionFileHeader_default.Block6ImageShiftX;
               hdr->Block6ImageShiftY = CalibCollection_CollectionFileHeader_default.Block6ImageShiftY;
               hdr->Block6ImageRotation = CalibCollection_CollectionFileHeader_default.Block6ImageRotation;
               hdr->Block7ImageShiftX = CalibCollection_CollectionFileHeader_default.Block7ImageShiftX;
               hdr->Block7ImageShiftY = CalibCollection_CollectionFileHeader_default.Block7ImageShiftY;
               hdr->Block7ImageRotation = CalibCollection_CollectionFileHeader_default.Block7ImageRotation;
               hdr->Block8ImageShiftX = CalibCollection_CollectionFileHeader_default.Block8ImageShiftX;
               hdr->Block8ImageShiftY = CalibCollection_CollectionFileHeader_default.Block8ImageShiftY;
               hdr->Block8ImageRotation = CalibCollection_CollectionFileHeader_default.Block8ImageRotation;
               hdr->FileStructureMinorVersion = 3;

            case 3:
               // 2.3.x -> 2.4.x
               // Nothing to do
               hdr->FileStructureMinorVersion = 4;

            case 4:
               // 2.4.x -> 2.5.x
               hdr->SensorIDMSB = CalibCollection_CollectionFileHeader_default.SensorIDMSB;
               hdr->FileStructureMinorVersion = 5;

            case 5:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = CALIBCOLLECTION_FILESUBMINORVERSION;
               break;
         }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return headerSize;
}
