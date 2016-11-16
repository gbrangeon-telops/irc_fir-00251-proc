/**
 * @file FlashSettingsFile.h
 * Camera flash settings file structure declaration.
 *
 * This file declares the camera flash settings file structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef FLASHSETTINGSFILE_H
#define FLASHSETTINGSFILE_H

#include "IRCamFiles.h"
#include "FlashSettingsFile_v1.h"
#include "FlashSettingsFile_v2.h"
#include "fileInfo.h"

#define TSFSFILES_VERSION  2

// Flashsettings macros versioning
#define FLASHSETTINGS_FILEMAJORVERSION       VER_MACRO(FLASHSETTINGS_FILEMAJORVERSION, TSDVFILES_VERSION)
#define FLASHSETTINGS_FILEMINORVERSION       VER_MACRO(FLASHSETTINGS_FILEMINORVERSION, TSDVFILES_VERSION)
#define FLASHSETTINGS_FILESUBMINORVERSION    VER_MACRO(FLASHSETTINGS_FILESUBMINORVERSION, TSDVFILES_VERSION)

#define FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE       VER_MACRO(FLASHSETTINGS_FLASHSETTINGSFILEHEADER_SIZE, TSFSFILES_VERSION)
#define FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE  VER_MACRO(FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKSIZE, TSFSFILES_VERSION)
#define FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKCOUNT VER_MACRO(FLASHSETTINGS_FLASHSETTINGSFILEHEADER_CHUNKCOUNT, TSFSFILES_VERSION)

// Flash settings types versioning
#define FlashSettings_FlashSettingsFileHeader_t  VER_TYPE(FlashSettings_FlashSettingsFileHeader, TSFSFILES_VERSION)

// Flash settings default value versionning
#define FlashSettings_FlashSettingsFileHeader_default VER_DEFAULT(FlashSettings_FlashSettingsFileHeader, TSFSFILES_VERSION)

// Flash settings function versioning
#define FlashSettings_WriteFlashSettingsFileHeader  VER_FUN(FlashSettings_WriteFlashSettingsFileHeader, TSFSFILES_VERSION)
#define FlashSettings_PrintFlashSettingsFileHeader  VER_FUN(FlashSettings_PrintFlashSettingsFileHeader, TSFSFILES_VERSION)


IRC_Status_t FlashSettings_ParseFlashSettingsFileHeader(int fd, FlashSettings_FlashSettingsFileHeader_t *hdr, fileInfo_t *fileInfo);

#endif // FLASHSETTINGSFILE_H
