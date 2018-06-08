/**
 * @file CalibBlockFile.c
 * Camera calibration block file structure definition.
 *
 * This file defines camera calibration block file structure.
 * 
 * $Rev: 21422 $
 * $Author: odionne $
 * $Date: 2018-02-08 23:11:02 -0500 (Thu, 08 Feb 2018) $
 * $Id: CalibBlockFile.c 21422 2018-02-09 04:11:02Z odionne $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/IRCamFiles/CalibBlockFile.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "CalibBlockFile.h"
#include <string.h>

#define MIN_FILE_INFO_SIZE 20

bool CalibBlock_LoadCalibrationBlock(unsigned char *buffer, unsigned int bufferLen, CalibBlockFile *calibration)
{
	uint32_t offset = 0;
	uint32_t readSize = 0;

	if (buffer == NULL)
		return false;

	if (bufferLen == 0)
		return false;

	if (calibration == NULL)
		return false;

	readSize = CalibBlock_ParseBlockFileHeader((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_FileInfo, &calibration->m_BlockHeader);
	if (readSize == 0) //error reading section
		return false;
	offset = calibration->m_BlockHeader.FileHeaderLength;
	if (calibration->m_BlockHeader.PixelDataPresence) //only scan it the section is marked as present
	{
		readSize = CalibBlock_ParsePixelDataHeader((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_FileInfo, &calibration->m_PdHeader);
		if (readSize == 0) //error reading section
			return false;
		offset += calibration->m_PdHeader.DataHeaderLength;
		//data processing
		int pixelCount = calibration->m_BlockHeader.Width * calibration->m_BlockHeader.Height;
		calibration->m_PdData = new CalibBlock_PixelData_t[pixelCount];
		for (int i = 0; i < pixelCount; i++)
		{
			readSize = CalibBlock_ParsePixelData_v2((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_PdData[i]);
			if (readSize == 0) //error reading section
				return false;
			offset += sizeof(uint64_t);
		}
	}
	if (calibration->m_BlockHeader.MaxTKDataPresence) //only scan it the section is marked as present
	{
		readSize = CalibBlock_ParseMaxTKDataHeader((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_FileInfo, &calibration->m_TkHeader);
		if (readSize == 0) //error reading section
			return false;
		// #todo do data processing
		offset += calibration->m_TkHeader.DataHeaderLength + calibration->m_TkHeader.MaxTKDataLength;
		//data processing
		//partially complete, must finish conversion from pixel data copy
		//int TvsINTCount = calibration->m_TkHeader.TvsINT_FitOrder + 1;
		//calibration->m_PdData = new CalibBlock_PixelData_t[pixelCount];
		//for (int i = 0; i < pixelCount; i++)
		//{
		//	readSize = CalibBlock_ParsePixelData_v2((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_PdData[i]);
		//	if (readSize == 0) //error reading section
		//		return false;
		//	offset += sizeof(uint64_t);
		//}
		////data processing
		//int INTvsTCount = calibration->m_TkHeader.INTvsT_FitOrder + 1;
		//calibration->m_PdData = new CalibBlock_PixelData_t[pixelCount];
		//for (int i = 0; i < pixelCount; i++)
		//{
		//	readSize = CalibBlock_ParsePixelData_v2((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_PdData[i]);
		//	if (readSize == 0) //error reading section
		//		return false;
		//	offset += sizeof(uint64_t);
		//}
	}
	if (calibration->m_BlockHeader.LUTNLDataPresence) //only scan it the section is marked as present
	{
		readSize = CalibBlock_ParseLUTNLDataHeader((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_FileInfo, &calibration->m_NlHeader);
		if (readSize == 0) //error reading section
			return false;
		offset += calibration->m_NlHeader.DataHeaderLength;
		//data processing
		int listCount = calibration->m_NlHeader.NumberOfLUTNL;
		calibration->m_NlData = new CalibBlock_LUTNLData_t*[listCount];
		for (int i = 0; i < listCount; i++)
		{
			int itemCount = calibration->m_NlHeader.LUT_Size;
			calibration->m_NlData[i] = new CalibBlock_LUTNLData_t[itemCount];
			for (int k = 0; k < itemCount; k++)
			{
				readSize = CalibBlock_ParseLUTNLData_v2((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_NlData[i][k]);
				if (readSize == 0) //error reading section
					return false;
				offset += sizeof(uint32_t);
			}
		}

	}
	if (calibration->m_BlockHeader.LUTRQDataPresence) //only scan it the section is marked as present
	{
		calibration->m_RqListCount = calibration->m_BlockHeader.NumberOfLUTRQ;
		for (int i = 0; i < calibration->m_RqListCount; i++)
		{
			readSize = CalibBlock_ParseLUTRQDataHeader((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_FileInfo, &calibration->m_RqHeader[i]);
			if (readSize == 0) //error reading section
				return false;
			offset += calibration->m_RqHeader[i].DataHeaderLength;
			//data processing
			int rqCount = calibration->m_RqHeader[i].LUT_Size;
			calibration->m_RqData[i] = new CalibBlock_LUTRQData_t[calibration->m_RqHeader[i].LUT_Size];
			for (int k = 0; k < rqCount; k++)
			{
				readSize = CalibBlock_ParseLUTRQData_v2((uint8_t*)buffer + offset, bufferLen - offset, &calibration->m_RqData[i][k]);
				if (readSize == 0) //error reading section
					return false;
				offset += sizeof(uint32_t);
			}
		}
	}
	if (bufferLen == offset) //parse the file completely
		return true;
	else
		return false;


}

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
uint32_t CalibBlock_ParseBlockFileHeader(unsigned char *buffer, unsigned int  bufferLen, fileInfo_t *fileInfo, CalibBlock_BlockFileHeader_v2_t *hdr)
{
	extern CalibBlock_BlockFileHeader_t CalibBlock_BlockFileHeader_default;

   fileInfo_t fi;
   CalibBlock_BlockFileHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((buffer == NULL) || (bufferLen <= MIN_FILE_INFO_SIZE) || (hdr == NULL))
   {
      return 0;
   }

   if ((FI_GetFileInfo((const char*)buffer, &fi) != IRC_SUCCESS) || (fi.type != FT_TSBL))
   {
      return 0;
   }

   switch (fi.version.major)
   {
      case 1:
         headerSize = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1;
        if (CalibBlock_ParseBlockFileHeader_v1(buffer, headerSize, &hdr_v1) == headerSize)
        {
            break;
        }
         return 0;

      case 2:
         headerSize = CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2;
        if (CalibBlock_ParseBlockFileHeader_v2(buffer, headerSize, hdr) == headerSize)
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
               hdr_v1.SensorID = CalibBlock_BlockFileHeader_default.SensorID;
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
               // 2.0.x -> 2.1.x
               hdr->LowReferenceTemperature = CalibBlock_BlockFileHeader_default.LowReferenceTemperature;
               hdr->HighReferenceTemperature = CalibBlock_BlockFileHeader_default.HighReferenceTemperature;
               hdr->LowExtrapolationTemperature = CalibBlock_BlockFileHeader_default.LowExtrapolationTemperature;
               hdr->HighExtrapolationTemperature = CalibBlock_BlockFileHeader_default.HighExtrapolationTemperature;
               hdr->FluxOffset = CalibBlock_BlockFileHeader_default.FluxOffset;
               hdr->FileStructureMinorVersion = 1;
			   
            case 1:
               // 2.1.x -> 2.2.x
				hdr->ExternalLensFocalLength = CalibBlock_BlockFileHeader_default.ExternalLensFocalLength;
				hdr->FluxSaturation = CalibBlock_BlockFileHeader_default.FluxSaturation;
				hdr->LowExtrapolationFactor = CalibBlock_BlockFileHeader_default.LowExtrapolationFactor;
				hdr->HighExtrapolationFactor = CalibBlock_BlockFileHeader_default.HighExtrapolationFactor;
				hdr->LowValidTemperature = CalibBlock_BlockFileHeader_default.LowValidTemperature;
				hdr->HighValidTemperature = CalibBlock_BlockFileHeader_default.HighValidTemperature;
				hdr->FOVPosition = CalibBlock_BlockFileHeader_default.FOVPosition;
				hdr->FocusPositionRaw = CalibBlock_BlockFileHeader_default.FocusPositionRaw;
				hdr->ImageCorrectionFocusPositionRaw = CalibBlock_BlockFileHeader_default.ImageCorrectionFocusPositionRaw;
               hdr->FileStructureMinorVersion = 2;

            case 2:
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
uint32_t CalibBlock_ParsePixelDataHeader( uint8_t *buffer, uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_PixelDataHeader_v2_t *hdr)
{
   CalibBlock_PixelDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((buffer == NULL) || (bufferLen <= MIN_FILE_INFO_SIZE) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
		   headerSize = CALIBBLOCK_PIXELDATAHEADER_SIZE_V1;
            if (CalibBlock_ParsePixelDataHeader_v1(buffer, headerSize, &hdr_v1) == headerSize)
            {
            break;
            }
          return 0;

       case 2:
		   headerSize = CALIBBLOCK_PIXELDATAHEADER_SIZE_V2;
            if (CalibBlock_ParsePixelDataHeader_v2(buffer, headerSize, hdr) == headerSize)
            {
            break;
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
uint32_t CalibBlock_ParseMaxTKDataHeader( uint8_t *buffer,  uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_MaxTKDataHeader_v2_t *hdr)
{
   CalibBlock_MaxTKDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((buffer == NULL) || (bufferLen <= MIN_FILE_INFO_SIZE) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
		   headerSize = CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1;
			if (CalibBlock_ParseMaxTKDataHeader_v1(buffer, headerSize, &hdr_v1) == headerSize)
			{
			break;
			}
          return 0;

       case 2:
		   headerSize = CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2;
             if (CalibBlock_ParseMaxTKDataHeader_v2(buffer, headerSize, hdr) == headerSize)
             {
                break;
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
uint32_t CalibBlock_ParseLUTNLDataHeader( uint8_t *buffer,  uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_LUTNLDataHeader_v2_t *hdr)
{
   CalibBlock_LUTNLDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((buffer == NULL) || (bufferLen <= MIN_FILE_INFO_SIZE) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
		   headerSize = CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1;
            if (CalibBlock_ParseLUTNLDataHeader_v1(buffer, headerSize, &hdr_v1) == headerSize)
            {
            break;
            }
          return 0;

       case 2:
		   headerSize = CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2;
            if (CalibBlock_ParseLUTNLDataHeader_v2(buffer, headerSize, hdr) == headerSize)
            {
            break;
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
uint32_t CalibBlock_ParseLUTRQDataHeader( uint8_t *buffer,  uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_LUTRQDataHeader_v2_t *hdr)
{
   CalibBlock_LUTRQDataHeader_v1_t hdr_v1;
   uint32_t headerSize;
   uint32_t minorVersion;

   if ((buffer == NULL) || (bufferLen <= MIN_FILE_INFO_SIZE) || (fileInfo == NULL) || (fileInfo->type != FT_TSBL) || (hdr == NULL))
   {
      return 0;
   }

   switch (fileInfo->version.major)
   {
       case 1:
		   headerSize = CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1;
            if (CalibBlock_ParseLUTRQDataHeader_v1(buffer, headerSize, &hdr_v1) == headerSize)
            {
            break;
            }
          return 0;

       case 2:
		   headerSize = CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2;
            if (CalibBlock_ParseLUTRQDataHeader_v2(buffer, headerSize, hdr) == headerSize)
            {
            break;
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
