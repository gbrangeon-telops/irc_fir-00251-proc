/**
 * @file FlashDynamicValuesFile.h
 * Camera flash dynamic values file structure declaration.
 *
 * This file declares the camera flash dynamic values file structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FLASHDYNAMICVALUESFILE_H
#define FLASHDYNAMICVALUESFILE_H

#include "FlashDynamicValuesFile_v1.h"
#include "FlashDynamicValuesFile_v2.h"
#include "IRCamFiles.h"
#include "fileInfo.h"

#define TSDVFILES_VERSION  2

// Flash dynamic values macros versioning
#define FLASHDYNAMICVALUES_FILEMAJORVERSION     VER_MACRO(FLASHDYNAMICVALUES_FILEMAJORVERSION, TSDVFILES_VERSION)
#define FLASHDYNAMICVALUES_FILEMINORVERSION     VER_MACRO(FLASHDYNAMICVALUES_FILEMINORVERSION, TSDVFILES_VERSION)
#define FLASHDYNAMICVALUES_FILESUBMINORVERSION  VER_MACRO(FLASHDYNAMICVALUES_FILESUBMINORVERSION, TSDVFILES_VERSION)

#define FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE   VER_MACRO(FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE, TSDVFILES_VERSION)

// Flash dynamic values types versioning
#define FlashDynamicValues_FlashDynamicValuesFileHeader_t  VER_TYPE(FlashDynamicValues_FlashDynamicValuesFileHeader, TSDVFILES_VERSION)

// Flash dynamic values default value versionning
#define FlashDynamicValues_FlashDynamicValuesFileHeader_default VER_DEFAULT(FlashDynamicValues_FlashDynamicValuesFileHeader, TSDVFILES_VERSION)

// Flash dynamic values function versioning
#define FlashDynamicValues_WriteFlashDynamicValuesFileHeader  VER_FUN(FlashDynamicValues_WriteFlashDynamicValuesFileHeader, TSDVFILES_VERSION)


uint32_t FlashDynamicValues_ParseFlashDynamicValuesFileHeader(int fd, FlashDynamicValues_FlashDynamicValuesFileHeader_t *hdr, fileInfo_t *fileInfo);

#endif // FLASHDYNAMICVALUESFILE_H
