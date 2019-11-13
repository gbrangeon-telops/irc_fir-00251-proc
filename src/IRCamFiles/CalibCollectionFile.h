/**
 * @file CalibCollectionFile.h
 * Camera calibration collection file structure declaration.
 *
 * This file declares the camera calibration collection file structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
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
#define CalibCollection_PrintCollectionFileHeader  VER_FUN(CalibCollection_PrintCollectionFileHeader, TSCOFILES_VERSION)

#define CALIB_MAX_NUM_OF_BLOCKS              8

#define DefaultCollectionType(calibrationType) ((calibrationType == CALT_MULTIPOINT) ? CCT_MultipointFixed : CCT_TelopsFixed)

uint32_t CalibCollection_ParseCollectionFileHeader(int fd, CalibCollection_CollectionFileHeader_t *hdr, fileInfo_t *fileInfo);

#endif // CALIBCOLLECTIONFILE_H
