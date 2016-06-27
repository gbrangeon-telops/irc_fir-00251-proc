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

#include "CalibFiles.h"
#include "CalibCollectionFile_v1.h"
#include "CalibCollectionFile_v2.h"
#include "FileInfo.h"
#include "GenICam.h"
#include <stdint.h>

// Calibration collection macros versioning
#define CALIBCOLLECTION_FILEMAJORVERSION     VER_MACRO(CALIBBLOCK_FILEMAJORVERSION, CALIBFILES_VERSION)
#define CALIBCOLLECTION_FILEMINORVERSION     VER_MACRO(CALIBBLOCK_FILEMINORVERSION, CALIBFILES_VERSION)
#define CALIBCOLLECTION_FILESUBMINORVERSION  VER_MACRO(CALIBBLOCK_FILESUBMINORVERSION, CALIBFILES_VERSION)

#define CALIBCOLLECTION_CALIBCOLLECTIONFILEHEADER_SIZE   VER_MACRO(CALIBCOLLECTION_CALIBCOLLECTIONFILEHEADER_SIZE, CALIBFILES_VERSION)

// Calibration collection types versioning
#define CalibCollection_CollectionFileHeader_t  VER_TYPE(CalibCollection_CollectionFileHeader, CALIBFILES_VERSION)

// Calibration collection function versioning
#define CalibCollection_WriteCollectionFileHeader  VER_FUN(CalibCollection_WriteCollectionFileHeader, CALIBFILES_VERSION)

#define CALIB_MAX_NUM_OF_BLOCKS              8

#define DefaultCollectionType(calibrationType) ((calibrationType == CALT_MULTIPOINT) ? CCT_MultipointFixed : CCT_TelopsFixed)

uint32_t CalibCollection_ParseCollectionFileHeader(int fd, CalibCollection_CollectionFileHeader_t *hdr, fileInfo_t *fileInfo);

#endif // CALIBCOLLECTIONFILE_H
