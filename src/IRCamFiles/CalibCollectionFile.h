/**
 * @file CalibCollectionFile.h
 * Camera calibration collection file structure declaration.
 *
 * This file declares the camera calibration collection file structure.
 *
 * $Rev: 18969 $
 * $Author: dalain $
 * $Date: 2016-07-06 13:35:31 -0400 (mer., 06 juil. 2016) $
 * $Id: CalibCollectionFile.h 18969 2016-07-06 17:35:31Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/IRCamFiles/CalibCollectionFile.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef CALIBCOLLECTIONFILE_H
#define CALIBCOLLECTIONFILE_H

#include "IRCamFiles.h"
#include "CalibCollectionFile_v1.h"
#include "CalibCollectionFile_v2.h"
#include "FileInfo.h"
#include "GenICam.h"
#include <stdint.h>

// Calibration collection macros versioning
#define CALIBCOLLECTION_FILEMAJORVERSION     VER_MACRO(CALIBBLOCK_FILEMAJORVERSION, TSCOFILES_VERSION)
#define CALIBCOLLECTION_FILEMINORVERSION     VER_MACRO(CALIBBLOCK_FILEMINORVERSION, TSCOFILES_VERSION)
#define CALIBCOLLECTION_FILESUBMINORVERSION  VER_MACRO(CALIBBLOCK_FILESUBMINORVERSION, TSCOFILES_VERSION)

#define CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE   VER_MACRO(CALIBCOLLECTION_COLLECTIONFILEHEADER_SIZE, TSCOFILES_VERSION)

// Calibration collection types versioning
#define CalibCollection_CollectionFileHeader_t  VER_TYPE(CalibCollection_CollectionFileHeader, TSCOFILES_VERSION)

// Calibration collection default value versionning
#define CalibCollection_CollectionFileHeader_default  VER_DEFAULT(CalibCollection_CollectionFileHeader, TSCOFILES_VERSION)

// Calibration collection function versioning
#define CalibCollection_WriteCollectionFileHeader  VER_FUN(CalibCollection_WriteCollectionFileHeader, TSCOFILES_VERSION)

#define CALIB_MAX_NUM_OF_BLOCKS              8

#define DefaultCollectionType(calibrationType) ((calibrationType == CALT_MULTIPOINT) ? CCT_MultipointFixed : CCT_TelopsFixed)

uint32_t CalibCollection_ParseCollectionFileHeader(int fd, CalibCollection_CollectionFileHeader_t *hdr, fileInfo_t *fileInfo);

#endif // CALIBCOLLECTIONFILE_H
