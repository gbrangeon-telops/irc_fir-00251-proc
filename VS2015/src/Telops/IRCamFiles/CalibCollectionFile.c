/**
 * @file CalibCollectionFile.c
 * Camera calibration collection file structure definition.
 *
 * This file defines camera calibration collection file structure.
 * 
 * $Rev: 21422 $
 * $Author: odionne $
 * $Date: 2018-02-08 23:11:02 -0500 (Thu, 08 Feb 2018) $
 * $Id: CalibCollectionFile.c 21422 2018-02-09 04:11:02Z odionne $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/IRCamFiles/CalibCollectionFile.c $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "CalibCollectionFile.h"
#include "GenICam.h"
#include <string.h>

#define MIN_FILE_INFO_SIZE 20

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
uint32_t CalibCollection_ParseCollectionFileHeader( uint8_t *buffer,  uint32_t bufferLen, fileInfo_t *fileInfo, CalibCollection_CollectionFileHeader_t *hdr)
{
   extern CalibCollection_CollectionFileHeader_t CalibCollection_CollectionFileHeader_default;

   fileInfo_t fi;
   CalibCollection_CollectionFileHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((buffer == NULL) || (bufferLen <= MIN_FILE_INFO_SIZE) || (hdr == NULL))
   {
      return 0;
   }

   if ((FI_GetFileInfo((const char*)buffer, &fi) != IRC_SUCCESS) || (fi.type != FT_TSCO))
   {
      return 0;
   }

   switch (fi.version.major)
   {
      case 1:
         headerSize = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V1;
        if (CalibCollection_ParseCollectionFileHeader_v1(buffer, headerSize, &hdr_v1) == headerSize)
        {
            break;
        }
         return 0;

      case 2:
         headerSize = CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE_V2;
        if (CalibCollection_ParseCollectionFileHeader_v2(buffer, headerSize, hdr) == headerSize)
        {
            break;
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
               hdr_v1.CollectionType = CCT_TelopsFixed;
               hdr_v1.CollectionFileDataLength = hdr_v1.NumberOfBlocks * sizeof(uint32_t);
               hdr_v1.SensorID = CalibCollection_CollectionFileHeader_default.SensorID;
               hdr_v1.NDFPosition = NDFP_NDFilterNotImplemented;
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
 
            case 1:
               // 2.1.x -> 2.2.x
               hdr->FOVPosition = CalibCollection_CollectionFileHeader_default.FOVPosition;
 
            case 2:
               // Up to date, nothing to do
               break;
		 }
		 hdr->FileStructureMinorVersion = minorVersion;
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return headerSize;
}
