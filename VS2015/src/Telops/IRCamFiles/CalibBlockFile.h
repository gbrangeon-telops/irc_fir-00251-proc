/**
 * @file CalibBlockFile.h
 * Camera calibration block file structure declaration.
 *
 * This file declares the camera calibration block file structure.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (Wed, 06 Jul 2016) $
 * $Id: CalibBlockFile.h 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/IRCamFiles/CalibBlockFile.h $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef CALIBBLOCKFILE_H
#define CALIBBLOCKFILE_H

#include "IRCamFiles.h"
#include "CalibBlockFile_v1.h"
#include "CalibBlockFile_v2.h"
#include "FileInfo.h"
#include <stdint.h>


#ifdef __cplusplus
extern "C"
{
#endif  

 // Calibration block macros versioning
#define CALIBBLOCK_FILEMAJORVERSION          VER_MACRO(CALIBBLOCK_FILEMAJORVERSION, TSBLFILES_VERSION)
#define CALIBBLOCK_FILEMINORVERSION          VER_MACRO(CALIBBLOCK_FILEMINORVERSION, TSBLFILES_VERSION)
#define CALIBBLOCK_FILESUBMINORVERSION       VER_MACRO(CALIBBLOCK_FILESUBMINORVERSION, TSBLFILES_VERSION)

#define CALIBBLOCK_BLOCKFILEHEADER_SIZE      VER_MACRO(CALIBBLOCK_BLOCKFILEHEADER_SIZE, TSBLFILES_VERSION)

#define CALIBBLOCK_PIXELDATAHEADER_SIZE      VER_MACRO(CALIBBLOCK_PIXELDATAHEADER_SIZE, TSBLFILES_VERSION)

#define CALIBBLOCK_PIXELDATA_OFFSET_MASK     VER_MACRO(CALIBBLOCK_PIXELDATA_OFFSET_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_OFFSET_SHIFT    VER_MACRO(CALIBBLOCK_PIXELDATA_OFFSET_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_RANGE_MASK      VER_MACRO(CALIBBLOCK_PIXELDATA_RANGE_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_RANGE_SHIFT     VER_MACRO(CALIBBLOCK_PIXELDATA_RANGE_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_LUTNLINDEX      VER_MACRO(CALIBBLOCK_PIXELDATA_LUTNLINDEX, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_LUTNLINDEX      VER_MACRO(CALIBBLOCK_PIXELDATA_LUTNLINDEX, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_KAPPA_MASK      VER_MACRO(CALIBBLOCK_PIXELDATA_KAPPA_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_KAPPA_SHIFT     VER_MACRO(CALIBBLOCK_PIXELDATA_KAPPA_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_BETA0_MASK      VER_MACRO(CALIBBLOCK_PIXELDATA_BETA0_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_BETA0_SHIFT     VER_MACRO(CALIBBLOCK_PIXELDATA_BETA0_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS   VER_MACRO(CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_ALPHA_MASK      VER_MACRO(CALIBBLOCK_PIXELDATA_ALPHA_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_ALPHA_SHIFT     VER_MACRO(CALIBBLOCK_PIXELDATA_ALPHA_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_BADPIXEL_MASK   VER_MACRO(CALIBBLOCK_PIXELDATA_BADPIXEL_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT  VER_MACRO(CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT, TSBLFILES_VERSION)

#define CALIBBLOCK_MAXTKDATAHEADER_SIZE      VER_MACRO(CALIBBLOCK_MAXTKDATAHEADER_SIZE, TSBLFILES_VERSION)

#define CALIBBLOCK_LUTNLDATAHEADER_SIZE      VER_MACRO(CALIBBLOCK_LUTNLDATAHEADER_SIZE, TSBLFILES_VERSION)

#define CALIBBLOCK_LUTNLDATA_SIZE            VER_MACRO(CALIBBLOCK_LUTNLDATA_SIZE, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTNLDATA_M_MASK          VER_MACRO(CALIBBLOCK_LUTNLDATA_M_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTNLDATA_M_SHIFT         VER_MACRO(CALIBBLOCK_LUTNLDATA_M_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTNLDATA_B_MASK          VER_MACRO(CALIBBLOCK_LUTNLDATA_B_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTNLDATA_B_SHIFT         VER_MACRO(CALIBBLOCK_LUTNLDATA_B_SHIFT, TSBLFILES_VERSION)

#define CALIBBLOCK_LUTRQDATAHEADER_SIZE      VER_MACRO(CALIBBLOCK_LUTRQDATAHEADER_SIZE, TSBLFILES_VERSION)

#define CALIBBLOCK_LUTRQDATA_SIZE            VER_MACRO(CALIBBLOCK_LUTRQDATA_SIZE, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTRQDATA_M_MASK          VER_MACRO(CALIBBLOCK_LUTRQDATA_M_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTRQDATA_M_SHIFT         VER_MACRO(CALIBBLOCK_LUTRQDATA_M_SHIFT, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTRQDATA_B_MASK          VER_MACRO(CALIBBLOCK_LUTRQDATA_B_MASK, TSBLFILES_VERSION)
#define CALIBBLOCK_LUTRQDATA_B_SHIFT         VER_MACRO(CALIBBLOCK_LUTRQDATA_B_SHIFT, TSBLFILES_VERSION)

 // Calibration block types versioning
#define CalibBlock_BlockFileHeader_t         VER_TYPE(CalibBlock_BlockFileHeader, TSBLFILES_VERSION)
#define CalibBlock_PixelDataHeader_t         VER_TYPE(CalibBlock_PixelDataHeader, TSBLFILES_VERSION)
#define CalibBlock_PixelData_t               VER_TYPE(CalibBlock_PixelData, TSBLFILES_VERSION)
#define CalibBlock_MaxTKDataHeader_t         VER_TYPE(CalibBlock_MaxTKDataHeader, TSBLFILES_VERSION)
#define CalibBlock_LUTNLDataHeader_t         VER_TYPE(CalibBlock_LUTNLDataHeader, TSBLFILES_VERSION)
#define CalibBlock_LUTNLData_t               VER_TYPE(CalibBlock_LUTNLData, TSBLFILES_VERSION)
#define CalibBlock_LUTRQDataHeader_t         VER_TYPE(CalibBlock_LUTRQDataHeader, TSBLFILES_VERSION)
#define CalibBlock_LUTRQData_t               VER_TYPE(CalibBlock_LUTRQData, TSBLFILES_VERSION)

 // Calibration block default value versioning
#define CalibBlock_BlockFileHeader_default   VER_DEFAULT(CalibBlock_BlockFileHeader, TSBLFILES_VERSION)
#define CalibBlock_PixelDataHeader_default   VER_DEFAULT(CalibBlock_PixelDataHeader, TSBLFILES_VERSION)
#define CalibBlock_PixelData_default         VER_DEFAULT(CalibBlock_PixelData, TSBLFILES_VERSION)
#define CalibBlock_MaxTKDataHeader_default   VER_DEFAULT(CalibBlock_MaxTKDataHeader, TSBLFILES_VERSION)
#define CalibBlock_LUTNLDataHeader_default   VER_DEFAULT(CalibBlock_LUTNLDataHeader, TSBLFILES_VERSION)
#define CalibBlock_LUTNLData_default         VER_DEFAULT(CalibBlock_LUTNLData, TSBLFILES_VERSION)
#define CalibBlock_LUTRQDataHeader_default   VER_DEFAULT(CalibBlock_LUTRQDataHeader, TSBLFILES_VERSION)
#define CalibBlock_LUTRQData_default         VER_DEFAULT(CalibBlock_LUTRQData, TSBLFILES_VERSION)

#define CALIBBLOCK_EXP_TIME_TO_US   ((float)1e-2)

 /**
 * RadiometricQuantityType enumeration values
 */
enum radiometricQuantityTypeEnum {
	RQT_RT = 0,
	RQT_IBR = 1,
	RQT_IBI = 4
};

/**
* RadiometricQuantityType enumeration values data type
*/
typedef enum radiometricQuantityTypeEnum radiometricQuantityType_t;

/**
* CalibrationType enumeration values
*/
enum calibrationTypeEnum {
	CALT_NL = 0,
	CALT_ICU = 1,
	CALT_MULTIPOINT = 2,
	CALT_TELOPS = 3
};

/**
* CalibrationType enumeration values data type
*/
typedef enum calibrationTypeEnum calibrationType_t;


// Calibration block function versioning
#define CalibBlock_WriteBlockFileHeader      VER_FUN(CalibBlock_WriteBlockFileHeader, TSBLFILES_VERSION)
#define CalibBlock_WritePixelDataHeader      VER_FUN(CalibBlock_WritePixelDataHeader, TSBLFILES_VERSION)
#define CalibBlock_WritePixelData            VER_FUN(CalibBlock_WritePixelData, TSBLFILES_VERSION)
#define CalibBlock_WriteMaxTKDataHeader      VER_FUN(CalibBlock_WriteMaxTKDataHeader, TSBLFILES_VERSION)
#define CalibBlock_WriteLUTNLDataHeader      VER_FUN(CalibBlock_WriteLUTNLDataHeader, TSBLFILES_VERSION)
#define CalibBlock_WriteLUTNLData            VER_FUN(CalibBlock_WriteLUTNLData, TSBLFILES_VERSION)
#define CalibBlock_WriteLUTRQDataHeader      VER_FUN(CalibBlock_WriteLUTRQDataHeader, TSBLFILES_VERSION)
#define CalibBlock_WriteLUTRQData            VER_FUN(CalibBlock_WriteLUTRQData, TSBLFILES_VERSION)

uint32_t CalibBlock_ParseBlockFileHeader(unsigned char *buffer, unsigned int bufferLen, fileInfo_t *fileInfo, CalibBlock_BlockFileHeader_v2_t *hdr);
uint32_t CalibBlock_ParseBlockFileHeader(unsigned char *buffer, unsigned int bufferLen, fileInfo_t *fileInfo, CalibBlock_BlockFileHeader_v2_t *hdr);
uint32_t CalibBlock_ParsePixelDataHeader(uint8_t *buffer, uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_PixelDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseMaxTKDataHeader(uint8_t *buffer, uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_MaxTKDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseLUTNLDataHeader(uint8_t *buffer, uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_LUTNLDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseLUTRQDataHeader(uint8_t *buffer, uint32_t bufferLen, fileInfo_t *fileInfo, CalibBlock_LUTRQDataHeader_v2_t *hdr);

#ifdef __cplusplus
}
#endif

	class CalibBlockFile
	{
	public: 
		fileInfo_t						m_FileInfo;

		CalibBlock_BlockFileHeader_t	m_BlockHeader;

		int								m_PdCount;
		CalibBlock_PixelDataHeader_t	m_PdHeader;
		CalibBlock_PixelData_t			*m_PdData;

		CalibBlock_MaxTKDataHeader_t	m_TkHeader;

		int								m_NlListCount;
		int								m_NlListSize;
		CalibBlock_LUTNLDataHeader_t	m_NlHeader;
		CalibBlock_LUTNLData_t			**m_NlData;

		int								m_RqListCount;
		int								m_RqListSize;
		CalibBlock_LUTRQDataHeader_t	m_RqHeader[4];
		CalibBlock_LUTRQData_t			*m_RqData[4];

	} ;

	bool CalibBlock_LoadCalibrationBlock(unsigned char *buffer, unsigned int bufferLen, CalibBlockFile *calibration);
	void CalibBlock_DeleteCalibrationBlock(CalibBlockFile *calibration);


#endif // CALIBBLOCKFILE_H
