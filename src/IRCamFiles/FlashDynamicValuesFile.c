/**
 * @file FlashDynamicValuesFile.c
 * Camera flash dynamic values file structure definition.
 *
 * This file defines camera flash dynamic file values structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "FlashDynamicValuesFile.h"
#include "FileManager.h"
#include <string.h>

/**
 * Flash dynamic values file header parser.
 *
 * @param fd is the flash dynamic values file descriptor.
 * @param hdr is the pointer to the flash dynamic values file header structure to fill.
 * @param fileInfo is a pointer to the file info data structure to fill (optional).
 *
 * @return the number of byte read from the file.
 * @return 0 if an error occurred.
 */
uint32_t FlashDynamicValues_ParseFlashDynamicValuesFileHeader(int fd, FlashDynamicValues_FlashDynamicValuesFileHeader_t *hdr, fileInfo_t *fileInfo)
{
   extern FlashDynamicValues_FlashDynamicValuesFileHeader_t FlashDynamicValues_FlashDynamicValuesFileHeader_default;

   fileInfo_t fi;
   FlashDynamicValues_FlashDynamicValuesFile_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((fd == -1) || (hdr == NULL))
   {
      return 0;
   }

   if ((FI_ParseFileInfo(fd, &fi) != IRC_SUCCESS) || (fi.type != FT_TSDV))
   {
      return 0;
   }

   switch (fi.version.major)
   {
      case 1:
         headerSize = FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILE_SIZE_V1;
         if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
         {
            if (FlashDynamicValues_ParseFlashDynamicValuesFile_v1(tmpFileDataBuffer, headerSize, &hdr_v1) == headerSize)
            {
               break;
            }
         }
         return 0;

      case 2:
         headerSize = FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE_V2;
         if (FM_ReadFileToTmpFileDataBuffer(fd, headerSize) == headerSize)
         {
            if (FlashDynamicValues_ParseFlashDynamicValuesFileHeader_v2(tmpFileDataBuffer, headerSize, hdr) == headerSize)
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
                hdr_v1.PowerOnAtStartup = FlashDynamicValues_FlashDynamicValuesFileHeader_default.PowerOnAtStartup;
                hdr_v1.AcquisitionStartAtStartup = FlashDynamicValues_FlashDynamicValuesFileHeader_default.AcquisitionStartAtStartup;
                hdr_v1.FileStructureMinorVersion = 1;

            case 1:
                // 1.1.x -> 1.2.x
                hdr_v1.StealthMode = FlashDynamicValues_FlashDynamicValuesFileHeader_default.StealthMode;
                hdr_v1.FileStructureMinorVersion = 2;

            case 2:
                // 1.2.x -> 1.3.x
                hdr_v1.CalibrationCollectionPOSIXTimeAtStartup = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionPOSIXTimeAtStartup;
                hdr_v1.CalibrationCollectionBlockPOSIXTimeAtStartup = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionBlockPOSIXTimeAtStartup;
                hdr_v1.FileStructureMinorVersion = 3;

             case 3:
                // 1.3.x -> 1.4.x
                hdr_v1.DeviceKeyValidationLow = FlashDynamicValues_FlashDynamicValuesFileHeader_default.DeviceKeyValidationLow;
                hdr_v1.DeviceKeyValidationHigh = FlashDynamicValues_FlashDynamicValuesFileHeader_default.DeviceKeyValidationHigh;
                hdr_v1.FileStructureMinorVersion = 4;

             case 4:
                // 1.4.x -> 1.5.x
                hdr_v1.BadPixelReplacement = FlashDynamicValues_FlashDynamicValuesFileHeader_default.BadPixelReplacement;
                hdr_v1.FileStructureMinorVersion = 5;

             case 5:
                // 1.5.x -> 1.6.x
                hdr_v1.FileOrderKey1 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.FileOrderKey1;
                hdr_v1.FileOrderKey2 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.FileOrderKey2;
                hdr_v1.FileOrderKey3 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.FileOrderKey3;
                hdr_v1.FileOrderKey4 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.FileOrderKey4;
                hdr_v1.CalibrationCollectionFileOrderKey1 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionFileOrderKey1;
                hdr_v1.CalibrationCollectionFileOrderKey2 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionFileOrderKey2;
                hdr_v1.CalibrationCollectionFileOrderKey3 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionFileOrderKey3;
                hdr_v1.CalibrationCollectionFileOrderKey4 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionFileOrderKey4;
                hdr_v1.FileStructureMinorVersion = 6;

            case 6:
            default:
               // 1.6.x -> 2.0.x
               memcpy(hdr, &hdr_v1, sizeof(*hdr));

               hdr->FileStructureMajorVersion = 2;
               hdr->FileStructureMinorVersion = 0;
               hdr->FileHeaderLength = FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE;
               hdr->FileHeaderCRC16 = 0;

               minorVersion = 0;
         }

      case 2:
         // 2.x.x
         switch (minorVersion)
         {
            case 0:
               // 2.0.x -> 2.1.x
               hdr->DeviceSerialPortFunctionRS232 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.DeviceSerialPortFunctionRS232;
               hdr->FileStructureMinorVersion = 1;
               
            case 1:
               // 2.1.x -> 2.2.x
               hdr->FileOrderKey5 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.FileOrderKey5;
               hdr->CalibrationCollectionFileOrderKey5 = FlashDynamicValues_FlashDynamicValuesFileHeader_default.CalibrationCollectionFileOrderKey5;
               hdr->AutofocusROI = FlashDynamicValues_FlashDynamicValuesFileHeader_default.AutofocusROI;
               hdr->FileStructureMinorVersion = 2;

            case 2:
               // 2.2.x -> 2.3.x
               hdr->DetectorMode = DM_Normal;

            case 3:
               // Up to date, nothing to do
               hdr->FileStructureSubMinorVersion = FLASHDYNAMICVALUES_FILESUBMINORVERSION;
               break;
         }
   }

   if (fileInfo != NULL)
   {
      *fileInfo = fi;
   }

   return headerSize;
}
