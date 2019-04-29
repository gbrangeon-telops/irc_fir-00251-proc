/**
 * @file CalibImageCorrectionFile.h
 * Camera image correction calibration file structure declaration.
 *
 * This file declares the camera image correction calibration file structure.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (mer., 06 juil. 2016) $
 * $Id: CalibImageCorrectionFile.h 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/CalibImageCorrectionFile.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef CALIBIMAGECORRECTIONFILE_H
#define CALIBIMAGECORRECTIONFILE_H

#include "IRCamFiles.h"
#include "CalibActualizationFile_v1.h"
#include "CalibImageCorrectionFile_v2.h"
#include "FileInfo.h"
#include <stdint.h>

// Calibration image correction macros versioning
#define CALIBIMAGECORRECTION_FILEMAJORVERSION      VER_MACRO(CALIBIMAGECORRECTION_FILEMAJORVERSION, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_FILEMINORVERSION      VER_MACRO(CALIBIMAGECORRECTION_FILEMINORVERSION, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_FILESUBMINORVERSION   VER_MACRO(CALIBIMAGECORRECTION_FILESUBMINORVERSION, TSICFILES_VERSION)

#define CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE          VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE, TSICFILES_VERSION)

#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE          VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE, TSICFILES_VERSION)

#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE                VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK      VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SHIFT     VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SHIFT, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS   VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_MASK    VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_MASK, TSICFILES_VERSION)
#define CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT   VER_MACRO(CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT, TSICFILES_VERSION)

// Calibration image correction types versioning
#define CalibImageCorrection_ImageCorrectionFileHeader_t    VER_TYPE(CalibImageCorrection_ImageCorrectionFileHeader, TSICFILES_VERSION)
#define CalibImageCorrection_ImageCorrectionDataHeader_t    VER_TYPE(CalibImageCorrection_ImageCorrectionDataHeader, TSICFILES_VERSION)

// Calibration image correction default value versioning
#define CalibImageCorrection_ImageCorrectionFileHeader_default    VER_DEFAULT(CalibImageCorrection_ImageCorrectionFileHeader, TSICFILES_VERSION)
#define CalibImageCorrection_ImageCorrectionDataHeader_default    VER_DEFAULT(CalibImageCorrection_ImageCorrectionDataHeader, TSICFILES_VERSION)

// Calibration image correction function versioning
#define CalibImageCorrection_WriteImageCorrectionFileHeader    VER_FUN(CalibImageCorrection_WriteImageCorrectionFileHeader, TSICFILES_VERSION)
#define CalibImageCorrection_WriteImageCorrectionDataHeader    VER_FUN(CalibImageCorrection_WriteImageCorrectionDataHeader, TSICFILES_VERSION)

uint32_t CalibImageCorrection_ParseImageCorrectionFileHeader(int fd, CalibImageCorrection_ImageCorrectionFileHeader_t *hdr, fileInfo_t *fileInfo);
uint32_t CalibImageCorrection_ParseImageCorrectionDataHeader(int fd, fileInfo_t *fileInfo, CalibImageCorrection_ImageCorrectionDataHeader_t *hdr);

#endif // CALIBIMAGECORRECTIONFILE_H
