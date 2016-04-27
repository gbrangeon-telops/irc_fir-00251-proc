/**
 * @file FlashSettings.c
 * Camera flash settings structure definition.
 *
 * This file defines camera flash settings structure.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "FlashSettings.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "FileManager.h"
#include "GC_Registers.h"
#include "GenICam.h"
#include "CRC.h"
#include "ICU.h"
#include "BufferManager.h"
#include "Calibration.h"
#include "FPA_intf.h"
#include "BuiltInTests.h"
#include "utils.h"
#include "FWController.h"
#include "DeviceKey.h"
#include "FlashDynamicValues.h"
#include <string.h>
#include <float.h>

/**
 * Load flash settings command flag
 */
uint32_t fsLoadFlashSettings;

/**
 * Indicates whether flash settings have to be loaded immediately
 */
fslImmediate_t fsLoadImmediately;

/**
 * Flash settings file descriptor to load
 */
int fdFlashSettings;


/* AUTO-CODE BEGIN */
// Auto-generated Flash Settings library.
// Generated from the Flash Settings definition XLS file version 1.12.0
// using generateFlashSettingsCLib.m Matlab script.

/**
 * Flash settings default values
 */
flashSettings_t flashSettingsDefault = {
   /* isValid */ 0,
   /* ActualizationAECImageFraction = */ 50.000000F,
   /* ActualizationAECTargetWellFilling = */ 50.000000F,
   /* ActualizationAECResponseTime = */ 500.000000F,
   /* FWOpticalAxisPosX = */ -1.351F,
   /* FWOpticalAxisPosY = */ -0.492F,
   /* FWMountingHoleRadius = */ 0.902/2.0F,
   /* FWBeamMarging = */ 0.1/2.54F,
   /* FWCornerPixDistX = */ -5.098/25.4F,
   /* FWCornerPixDistY = */ 4.078/25.4F,
   /* FWCenterPixRadius = */ (3.4/2.0)/25.4F,
   /* FWCornerPixRadius = */ (3.24/2.0)/25.4F,
   /* FWExposureTimeMaxMargin = */ 95.000000F,
   /* ExternalFanSpeedSetpoint = */ 50.000000F,
   /* BPFlickerThreshold = */  0.312236F,
   /* BPNoiseThreshold = */ 1.304589F,
   /* MaximumTotalFlux = */ FLT_MAX,
   /* FluxRatio01 = */ 1.0F,
   /* FluxRatio12 = */ 1.0F,
   /* AECPlusExpTimeMargin = */ 0.2F,
   /* AECPlusFluxMargin = */ 0.9F,
   /* BPOutlierThreshold = */ 6.000000F,
   /* BPAECImageFraction = */ 50.000000F,
   /* BPAECWellFilling = */ 50.000000F,
   /* BPAECResponseTime = */ 1000.000000F,
   /* DetectorElectricalTapsRef = */ 0.000000F,
   /* DetectorElectricalRefOffset = */ 0.000000F,
   /* FW0CenterPosition = */ 0,
   /* FW1CenterPosition = */ 47652,
   /* FW2CenterPosition = */ 31768,
   /* FW3CenterPosition = */ 15884,
   /* FW4CenterPosition = */ 0,
   /* FW5CenterPosition = */ 0,
   /* FW6CenterPosition = */ 0,
   /* FW7CenterPosition = */ 0,
   /* NDF0CenterPosition = */ 442,
   /* NDF1CenterPosition = */ 222,
   /* NDF2CenterPosition = */ 2,
   /* FlashSettingsFileLength = */ 65536,
   /* DeviceSerialNumber = */ 0,
   /* ActualizationWaitTime1 = */ 0,
   /* ActualizationStabilizationTime1 = */ 60000,
   /* ActualizationTimeout1 = */ 300000,
   /* ActualizationWaitTime2 = */ 5000,
   /* ActualizationStabilizationTime2 = */ 0,
   /* ActualizationTimeout2 = */ 300000,
   /* BPDuration = */ 60000,
   /* DeviceKeyExpirationPOSIXTime = */ 0xFFFFFFFF,
   /* DeviceKeyLow = */ 0x00000000,
   /* DeviceKeyHigh = */ 0x00000000,
   /* ActualizationTemperatureTolerance1 = */ 20,
   /* ActualizationTemperatureTolerance2 = */ 20,
   /* DetectorPolarizationVoltage = */ 0,
   /* ICUPulseWidth = */ 80,
   /* ICUPeriod = */ 350,
   /* ICUTransitionDuration = */ 500,
   /* ActualizationNumberOfImagesCoadd = */ 16,
   /* NDFClearFOVWidth = */ 40,
   /* FWSpeedMax = */ 5000,
   /* FWEncoderCyclePerTurn = */ 4096,
   /* FWPositionControllerPP = */ 64,
   /* FWPositionControllerPD = */ 2,
   /* FWPositionControllerPOR = */ 3,
   /* FWPositionControllerI = */ 9,
   /* FWSlowSpeedControllerPP = */ 5,
   /* FWSlowSpeedControllerPD = */ 2,
   /* FWSlowSpeedControllerPOR = */ 37,
   /* FWSlowSpeedControllerPI = */ 11,
   /* FWFastSpeedControllerPP = */ 5,
   /* FWFastSpeedControllerPD = */ 2,
   /* FWFastSpeedControllerPOR = */ 11,
   /* FWFastSpeedControllerI = */ 13,
   /* FWSpeedControllerSwitchingThreshold = */ 50,
   /* BPNumSamples = */ 1000,
   /* BPNCoadd = */ 64,
   /* FlashSettingsFileCRC16 = */ 0,
   /* FileStructureMajorVersion = */ 0,
   /* FileStructureMinorVersion = */ 0,
   /* FileStructureSubMinorVersion = */ 0,
   /* SensorID = */ 0,
   /* PixelDataResolution = */ 16,
   /* ReverseX = */ 0,
   /* ReverseY = */ 0,
   /* ICUPresent = */ 0,
   /* ICUMode = */ 1,
   /* ICUCalibPosition = */ 0,
   /* ActualizationEnabled = */ 0,
   /* ActualizationAtPowerOn = */ 0,
   /* FWPresent = */ 1,
   /* FWNumberOfFilters = */ 4,
   /* FWType = */ 0,
   /* ActualizationTemperatureSelector = */ 0,
   /* ActualizationDiscardOffset = */ 0,
   /* ExternalMemoryBufferPresent = */ 0,
   /* NDFPresent = */ 0,
   /* NDFNumberOfFilters = */ 3,
   /* BPDetectionEnabled = */ 0,
   /* FileSignature = */ "TSFS",
   /* DeviceModelName = */ ""
};

/**
 * Flash settings values
 */
flashSettings_t flashSettings;

/* AUTO-CODE END */

static IRC_Status_t FlashSettings_LoadFileHeader(int fd, flashSettings_t *p_flashSettings, uint16_t *p_crc16);
static IRC_Status_t FlashSettings_LoadFieldsData(int fd, flashSettings_t *p_flashSettings, uint16_t *p_crc16);
static IRC_Status_t FlashSettings_SkipSpareFreeSpace(int fd, uint32_t *p_dataOffset, uint16_t *p_crc16);
static IRC_Status_t FlashSettings_ValidateCRC16(int fd, flashSettings_t *p_flashSettings, uint16_t crc16);
static void FlashSettings_UpdateVersion(flashSettings_t *p_flashSettings);
static IRC_Status_t FlashSettings_Finalize(flashSettings_t *p_flashSettings);
static IRC_Status_t FlashSettings_Error();
static IRC_Status_t FlashSettings_UpdateCameraSettings(flashSettings_t *p_flashSettings);
static void FlashSettings_UpdateFixFWSettings(flashSettings_t *p_flashSettings);

/**
 * Initializes the flash settings loader.
 */
IRC_Status_t FlashSettings_Init()
{
   FlashSettings_Reset(&flashSettings);
   fdFlashSettings = -1;
   fsLoadFlashSettings = 0;
   fsLoadImmediately = FSLI_DEFERRED_LOADING;

   return IRC_SUCCESS;
}

/**
 * Start flash settings file loading.
 *
 * @param filename is the name of the flash settings file to load.
 * @param immediate indicates whether the flash setting data is immediately loaded.
 *
 * @return IRC_SUCCESS if successfully started to load flash settings file.
 * @return IRC_FAILURE if failed to start to loading flash settings file.
 */
IRC_Status_t FlashSettings_Load(char *filename, fslImmediate_t immediate)
{
   char filelongname[FM_LONG_FILENAME_SIZE];

   if (fdFlashSettings != -1)
   {
      FS_ERR("There is already a flash setting file loading.");
      return IRC_FAILURE;
   }

   sprintf(filelongname, "%s%s", FM_UFFS_MOUNT_POINT, filename);
   fdFlashSettings = uffs_open(filelongname, UO_RDWR);
   if (fdFlashSettings != -1)
   {
      FS_INF("Loading flash settings data from %s...", filename);
      fsLoadFlashSettings = 1;
      fsLoadImmediately = immediate;

      if (immediate == FSLI_LOAD_IMMEDIATELY)
      {
         // Execute state machine
         FlashSettings_SM();
      }
   }
   else
   {
      FS_ERR("Failed to open %s.", filename);
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}


/**
 * Flash setting loader state machine.

\dot
digraph G {
   FSLS_IDLE -> FSLS_LOAD_FLASH_HEADER -> FSLS_LOAD_FLASH_DATA
   FSLS_LOAD_FLASH_DATA -> FSLS_SKIP_SPARE_FREE_SPACE -> FSLS_VALIDATE_CRC16 -> FSLS_FINALIZE
   FSLS_LOAD_FLASH_HEADER -> FSLS_ERROR
   FSLS_LOAD_FLASH_DATA -> FSLS_ERROR
   FSLS_SKIP_SPARE_FREE_SPACE -> FSLS_ERROR
   FSLS_VALIDATE_CRC16 -> FSLS_ERROR
}
\enddot

 */
void FlashSettings_SM()
{
   static fslState_t fslCurrentState = FSLS_IDLE;
   static uint32_t dataOffset;
   static uint16_t crc16;
   static uint64_t tic_flashSettings;
   IRC_Status_t status;
   int retval;

   switch (fslCurrentState)
   {
      case FSLS_IDLE:
         if (fsLoadFlashSettings)
         {
            fsLoadFlashSettings = 0;

            builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Pending;

            memset(&flashSettings, 0, sizeof(flashSettings_t));
            GETTIME(&tic_flashSettings);
            crc16 = 0xFFFF;

            if (fsLoadImmediately == FSLI_DEFERRED_LOADING)
            {
               fslCurrentState = FSLS_LOAD_FLASH_HEADER;
            }
            else
            {

               status = FlashSettings_LoadFileHeader(fdFlashSettings, &flashSettings, &crc16);

               if (status == IRC_SUCCESS)
               {
                  status = FlashSettings_LoadFieldsData(fdFlashSettings, &flashSettings, &crc16);
               }

               if (status == IRC_SUCCESS)
               {
                  dataOffset = 0;
                  do
                  {
                     status = FlashSettings_SkipSpareFreeSpace(fdFlashSettings, &dataOffset, &crc16);
                  } while (status == IRC_NOT_DONE);
               }

               if (status == IRC_SUCCESS)
               {
                  status = FlashSettings_ValidateCRC16(fdFlashSettings, &flashSettings, crc16);
               }

               if (status == IRC_SUCCESS)
               {
                  status = FlashSettings_Finalize(&flashSettings);
               }

               if (status != IRC_SUCCESS)
               {
                  FlashSettings_Error(&flashSettings);
               }

               if (fdFlashSettings != -1)
               {
                  retval = uffs_close(fdFlashSettings);
                  if (retval == -1)
                  {
                     FS_ERR("Failed to close flash settings file.");
                  }
                  fdFlashSettings = -1;
               }

               if (status == IRC_SUCCESS)
               {
                  builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Passed;
                  FS_INF("Flash settings data has been successfully loaded (%dms).", elapsed_time_us(tic_flashSettings) / 1000);
               }
               else
               {
                  builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Failed;
               }
            }
         }
         break;

      case FSLS_LOAD_FLASH_HEADER:
         if (FlashSettings_LoadFileHeader(fdFlashSettings, &flashSettings, &crc16) != IRC_SUCCESS)
         {
            fslCurrentState = FSLS_ERROR;
         }
         else
         {
            fslCurrentState = FSLS_LOAD_FLASH_DATA;
         }
         break;

      case FSLS_LOAD_FLASH_DATA:
         if (FlashSettings_LoadFieldsData(fdFlashSettings, &flashSettings, &crc16) != IRC_SUCCESS)
         {
            fslCurrentState = FSLS_ERROR;
         }
         else
         {
            dataOffset = 0;
            fslCurrentState = FSLS_SKIP_SPARE_FREE_SPACE;
         }
         break;

      case FSLS_SKIP_SPARE_FREE_SPACE:
         switch (FlashSettings_SkipSpareFreeSpace(fdFlashSettings, &dataOffset, &crc16))
         {
            case IRC_FAILURE:
               fslCurrentState = FSLS_ERROR;
               break;

            case IRC_SUCCESS:
               fslCurrentState = FSLS_VALIDATE_CRC16;
               break;

            default:
               // Do nothing
               break;
         }
         break;

      case FSLS_VALIDATE_CRC16:
         if (FlashSettings_ValidateCRC16(fdFlashSettings, &flashSettings, crc16) != IRC_SUCCESS)
         {
            fslCurrentState = FSLS_ERROR;
         }
         else
         {
            fslCurrentState = FSLS_FINALIZE;
         }
         break;

      case FSLS_FINALIZE:
         if (FlashSettings_Finalize(&flashSettings) != IRC_SUCCESS)
         {
            fslCurrentState = FSLS_ERROR;
         }
         else
         {
            retval = uffs_close(fdFlashSettings);
            if (retval == -1)
            {
               FS_ERR("Failed to close flash settings file.");
            }
            fdFlashSettings = -1;

            builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Passed;
            FS_INF("Flash settings data has been successfully loaded (%dms).", elapsed_time_us(tic_flashSettings) / 1000);
            fslCurrentState = FSLS_IDLE;
         }
         break;

      case FSLS_ERROR:
         FlashSettings_Error(&flashSettings);

         if (fdFlashSettings != -1)
         {
            retval = uffs_close(fdFlashSettings);
            if (retval == -1)
            {
               FS_ERR("Failed to close flash settings file.");
            }
            fdFlashSettings = -1;
         }

         builtInTests[BITID_FlashSettingsFileLoading].result = BITR_Failed;
         fslCurrentState = FSLS_IDLE;
         break;
   }
}

/**
 * Load and validate flash settings file header fields.
 *
 * @param fd is the flash settings file descriptor.
 * @param p_flashSettings is the pointer to flash settings data structure to update.
 * @param p_crc16 is the pointer to flash settings file crc16 value to update.
 *
 * @return IRC_SUCCESS if successfully loaded flash settings file header fields.
 * @return IRC_FAILURE if failed to load flash settings file header fields.
 */
IRC_Status_t FlashSettings_LoadFileHeader(int fd, flashSettings_t *p_flashSettings, uint16_t *p_crc16)
{
   int byteCount;

   // Read FileSignature flash settings field
   byteCount = uffs_read(fd, p_flashSettings->FileSignature, FS_FILESIGNATURE_LENGTH);
   if (byteCount != FS_FILESIGNATURE_LENGTH)
   {
      FS_ERR("Failed to read FileSignature field.");
      return IRC_FAILURE;
   }
   p_flashSettings->FileSignature[FS_FILESIGNATURE_LENGTH] = '\0'; // Ensure the string is NULL terminated
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) p_flashSettings->FileSignature, FS_FILESIGNATURE_LENGTH);

   // Validate file signature
   if (strcmp(p_flashSettings->FileSignature, "TSFS") != 0)
   {
      // Wrong flash settings file signature
      FS_ERR("Wrong flash settings file signature.");
      return IRC_FAILURE;
   }

   // Read FileStructureMajorVersion flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FileStructureMajorVersion, FS_FILESTRUCTUREMAJORVERSION_LENGTH);
   if (byteCount != FS_FILESTRUCTUREMAJORVERSION_LENGTH)
   {
      FS_ERR("Failed to read FileStructureMajorVersion field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FileStructureMajorVersion, FS_FILESTRUCTUREMAJORVERSION_LENGTH);

   // Read FileStructureMinorVersion flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FileStructureMinorVersion, FS_FILESTRUCTUREMINORVERSION_LENGTH);
   if (byteCount != FS_FILESTRUCTUREMINORVERSION_LENGTH)
   {
      FS_ERR("Failed to read FileStructureMinorVersion field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FileStructureMinorVersion, FS_FILESTRUCTUREMINORVERSION_LENGTH);

   // Read FileStructureSubMinorVersion flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FileStructureSubMinorVersion, FS_FILESTRUCTURESUBMINORVERSION_LENGTH);
   if (byteCount != FS_FILESTRUCTURESUBMINORVERSION_LENGTH)
   {
      FS_ERR("Failed to read FileStructureSubMinorVersion field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FileStructureSubMinorVersion, FS_FILESTRUCTURESUBMINORVERSION_LENGTH);

   // Validate flash settings file structure major version
   if (p_flashSettings->FileStructureMajorVersion != FS_FILESTRUCTUREMAJORVERSION)
   {
      FS_ERR("Flash settings file structure version %d.%d.%d is not supported. The supported version is %d.%d.%d.",
            p_flashSettings->FileStructureMajorVersion,
            p_flashSettings->FileStructureMinorVersion,
            p_flashSettings->FileStructureSubMinorVersion,
            FS_FILESTRUCTUREMAJORVERSION,
            FS_FILESTRUCTUREMINORVERSION,
            FS_FILESTRUCTURESUBMINORVERSION);
      return IRC_FAILURE;
   }

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Read FlashSettingsFileLength flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FlashSettingsFileLength, FS_FLASHSETTINGSFILELENGTH_LENGTH);
   if (byteCount != FS_FLASHSETTINGSFILELENGTH_LENGTH)
   {
      FS_ERR("Failed to read FlashSettingsLength field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FlashSettingsFileLength, FS_FLASHSETTINGSFILELENGTH_LENGTH);

   if (p_flashSettings->FlashSettingsFileLength != FS_FLASH_SETTINGS_FILE_LENGTH)
   {
      // Wrong flash settings file length
      FS_ERR("Wrong flash settings file length.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Load flash settings fields data from file.
 *
 * @param fd is the flash settings file descriptor.
 * @param p_flashSettings is the pointer to flash settings data structure to update.
 * @param p_crc16 is the pointer to flash settings file crc16 value to update.
 *
 * @return IRC_SUCCESS if successfully loaded flash settings fields.
 * @return IRC_FAILURE if failed to load flash settings fields.
 */
IRC_Status_t FlashSettings_LoadFieldsData(int fd, flashSettings_t *p_flashSettings, uint16_t *p_crc16)
{
   int byteCount;

/* AUTO-CODE FIELDS BEGIN */
// Auto-generated Flash Settings library.
// Generated from the Flash Settings definition XLS file version 1.12.0
// using generateFlashSettingsCLib.m Matlab script.

   // Read DeviceSerialNumber flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DeviceSerialNumber, FS_DEVICESERIALNUMBER_LENGTH);
   if (byteCount != FS_DEVICESERIALNUMBER_LENGTH)
   {
      FS_ERR("Failed to read DeviceSerialNumber field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DeviceSerialNumber, FS_DEVICESERIALNUMBER_LENGTH);

   // Read DeviceModelName flash settings field
   byteCount = uffs_read(fd, p_flashSettings->DeviceModelName, FS_DEVICEMODELNAME_LENGTH);
   if (byteCount != FS_DEVICEMODELNAME_LENGTH)
   {
      FS_ERR("Failed to read DeviceModelName field.");
      return IRC_FAILURE;
   }
   p_flashSettings->DeviceModelName[FS_DEVICEMODELNAME_LENGTH] = '\0'; // Ensure the string is NULL terminated
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) p_flashSettings->DeviceModelName, FS_DEVICEMODELNAME_LENGTH);

   // Read SensorID flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->SensorID, FS_SENSORID_LENGTH);
   if (byteCount != FS_SENSORID_LENGTH)
   {
      FS_ERR("Failed to read SensorID field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->SensorID, FS_SENSORID_LENGTH);

   // Read PixelDataResolution flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->PixelDataResolution, FS_PIXELDATARESOLUTION_LENGTH);
   if (byteCount != FS_PIXELDATARESOLUTION_LENGTH)
   {
      FS_ERR("Failed to read PixelDataResolution field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->PixelDataResolution, FS_PIXELDATARESOLUTION_LENGTH);

   // Read ReverseX flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ReverseX, FS_REVERSEX_LENGTH);
   if (byteCount != FS_REVERSEX_LENGTH)
   {
      FS_ERR("Failed to read ReverseX field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ReverseX, FS_REVERSEX_LENGTH);

   // Read ReverseY flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ReverseY, FS_REVERSEY_LENGTH);
   if (byteCount != FS_REVERSEY_LENGTH)
   {
      FS_ERR("Failed to read ReverseY field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ReverseY, FS_REVERSEY_LENGTH);

   // Read ICUPresent flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ICUPresent, FS_ICUPRESENT_LENGTH);
   if (byteCount != FS_ICUPRESENT_LENGTH)
   {
      FS_ERR("Failed to read ICUPresent field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ICUPresent, FS_ICUPRESENT_LENGTH);

   // Read ICUMode flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ICUMode, FS_ICUMODE_LENGTH);
   if (byteCount != FS_ICUMODE_LENGTH)
   {
      FS_ERR("Failed to read ICUMode field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ICUMode, FS_ICUMODE_LENGTH);

   // Read ICUCalibPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ICUCalibPosition, FS_ICUCALIBPOSITION_LENGTH);
   if (byteCount != FS_ICUCALIBPOSITION_LENGTH)
   {
      FS_ERR("Failed to read ICUCalibPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ICUCalibPosition, FS_ICUCALIBPOSITION_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Read ICUPulseWidth flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ICUPulseWidth, FS_ICUPULSEWIDTH_LENGTH);
   if (byteCount != FS_ICUPULSEWIDTH_LENGTH)
   {
      FS_ERR("Failed to read ICUPulseWidth field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ICUPulseWidth, FS_ICUPULSEWIDTH_LENGTH);

   // Read ICUPeriod flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ICUPeriod, FS_ICUPERIOD_LENGTH);
   if (byteCount != FS_ICUPERIOD_LENGTH)
   {
      FS_ERR("Failed to read ICUPeriod field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ICUPeriod, FS_ICUPERIOD_LENGTH);

   // Read ICUTransitionDuration flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ICUTransitionDuration, FS_ICUTRANSITIONDURATION_LENGTH);
   if (byteCount != FS_ICUTRANSITIONDURATION_LENGTH)
   {
      FS_ERR("Failed to read ICUTransitionDuration field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ICUTransitionDuration, FS_ICUTRANSITIONDURATION_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Read ActualizationEnabled flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationEnabled, FS_ACTUALIZATIONENABLED_LENGTH);
   if (byteCount != FS_ACTUALIZATIONENABLED_LENGTH)
   {
      FS_ERR("Failed to read ActualizationEnabled field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationEnabled, FS_ACTUALIZATIONENABLED_LENGTH);

   // Read ActualizationAtPowerOn flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationAtPowerOn, FS_ACTUALIZATIONATPOWERON_LENGTH);
   if (byteCount != FS_ACTUALIZATIONATPOWERON_LENGTH)
   {
      FS_ERR("Failed to read ActualizationAtPowerOn field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationAtPowerOn, FS_ACTUALIZATIONATPOWERON_LENGTH);

   // Read ActualizationNumberOfImagesCoadd flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationNumberOfImagesCoadd, FS_ACTUALIZATIONNUMBEROFIMAGESCOADD_LENGTH);
   if (byteCount != FS_ACTUALIZATIONNUMBEROFIMAGESCOADD_LENGTH)
   {
      FS_ERR("Failed to read ActualizationNumberOfImagesCoadd field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationNumberOfImagesCoadd, FS_ACTUALIZATIONNUMBEROFIMAGESCOADD_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Read ActualizationAECImageFraction flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationAECImageFraction, FS_ACTUALIZATIONAECIMAGEFRACTION_LENGTH);
   if (byteCount != FS_ACTUALIZATIONAECIMAGEFRACTION_LENGTH)
   {
      FS_ERR("Failed to read ActualizationAECImageFraction field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationAECImageFraction, FS_ACTUALIZATIONAECIMAGEFRACTION_LENGTH);

   // Read ActualizationAECTargetWellFilling flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationAECTargetWellFilling, FS_ACTUALIZATIONAECTARGETWELLFILLING_LENGTH);
   if (byteCount != FS_ACTUALIZATIONAECTARGETWELLFILLING_LENGTH)
   {
      FS_ERR("Failed to read ActualizationAECTargetWellFilling field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationAECTargetWellFilling, FS_ACTUALIZATIONAECTARGETWELLFILLING_LENGTH);

   // Read ActualizationAECResponseTime flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationAECResponseTime, FS_ACTUALIZATIONAECRESPONSETIME_LENGTH);
   if (byteCount != FS_ACTUALIZATIONAECRESPONSETIME_LENGTH)
   {
      FS_ERR("Failed to read ActualizationAECResponseTime field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationAECResponseTime, FS_ACTUALIZATIONAECRESPONSETIME_LENGTH);

   // Read FWPresent flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWPresent, FS_FWPRESENT_LENGTH);
   if (byteCount != FS_FWPRESENT_LENGTH)
   {
      FS_ERR("Failed to read FWPresent field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWPresent, FS_FWPRESENT_LENGTH);

   // Read FWNumberOfFilters flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWNumberOfFilters, FS_FWNUMBEROFFILTERS_LENGTH);
   if (byteCount != FS_FWNUMBEROFFILTERS_LENGTH)
   {
      FS_ERR("Failed to read FWNumberOfFilters field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWNumberOfFilters, FS_FWNUMBEROFFILTERS_LENGTH);

   // Read FWType flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWType, FS_FWTYPE_LENGTH);
   if (byteCount != FS_FWTYPE_LENGTH)
   {
      FS_ERR("Failed to read FWType field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWType, FS_FWTYPE_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Read FW0CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW0CenterPosition, FS_FW0CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW0CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW0CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW0CenterPosition, FS_FW0CENTERPOSITION_LENGTH);

   // Read FW1CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW1CenterPosition, FS_FW1CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW1CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW1CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW1CenterPosition, FS_FW1CENTERPOSITION_LENGTH);

   // Read FW2CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW2CenterPosition, FS_FW2CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW2CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW2CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW2CenterPosition, FS_FW2CENTERPOSITION_LENGTH);

   // Read FW3CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW3CenterPosition, FS_FW3CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW3CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW3CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW3CenterPosition, FS_FW3CENTERPOSITION_LENGTH);

   // Read FW4CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW4CenterPosition, FS_FW4CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW4CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW4CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW4CenterPosition, FS_FW4CENTERPOSITION_LENGTH);

   // Read FW5CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW5CenterPosition, FS_FW5CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW5CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW5CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW5CenterPosition, FS_FW5CENTERPOSITION_LENGTH);

   // Read FW6CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW6CenterPosition, FS_FW6CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW6CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW6CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW6CenterPosition, FS_FW6CENTERPOSITION_LENGTH);

   // Read FW7CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FW7CenterPosition, FS_FW7CENTERPOSITION_LENGTH);
   if (byteCount != FS_FW7CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read FW7CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FW7CenterPosition, FS_FW7CENTERPOSITION_LENGTH);

   // Read ActualizationTemperatureSelector flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationTemperatureSelector, FS_ACTUALIZATIONTEMPERATURESELECTOR_LENGTH);
   if (byteCount != FS_ACTUALIZATIONTEMPERATURESELECTOR_LENGTH)
   {
      FS_ERR("Failed to read ActualizationTemperatureSelector field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationTemperatureSelector, FS_ACTUALIZATIONTEMPERATURESELECTOR_LENGTH);

   // Read ActualizationDiscardOffset flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationDiscardOffset, FS_ACTUALIZATIONDISCARDOFFSET_LENGTH);
   if (byteCount != FS_ACTUALIZATIONDISCARDOFFSET_LENGTH)
   {
      FS_ERR("Failed to read ActualizationDiscardOffset field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationDiscardOffset, FS_ACTUALIZATIONDISCARDOFFSET_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Read ActualizationWaitTime1 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationWaitTime1, FS_ACTUALIZATIONWAITTIME1_LENGTH);
   if (byteCount != FS_ACTUALIZATIONWAITTIME1_LENGTH)
   {
      FS_ERR("Failed to read ActualizationWaitTime1 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationWaitTime1, FS_ACTUALIZATIONWAITTIME1_LENGTH);

   // Read ActualizationTemperatureTolerance1 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationTemperatureTolerance1, FS_ACTUALIZATIONTEMPERATURETOLERANCE1_LENGTH);
   if (byteCount != FS_ACTUALIZATIONTEMPERATURETOLERANCE1_LENGTH)
   {
      FS_ERR("Failed to read ActualizationTemperatureTolerance1 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationTemperatureTolerance1, FS_ACTUALIZATIONTEMPERATURETOLERANCE1_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Read ActualizationStabilizationTime1 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationStabilizationTime1, FS_ACTUALIZATIONSTABILIZATIONTIME1_LENGTH);
   if (byteCount != FS_ACTUALIZATIONSTABILIZATIONTIME1_LENGTH)
   {
      FS_ERR("Failed to read ActualizationStabilizationTime1 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationStabilizationTime1, FS_ACTUALIZATIONSTABILIZATIONTIME1_LENGTH);

   // Read ActualizationTimeout1 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationTimeout1, FS_ACTUALIZATIONTIMEOUT1_LENGTH);
   if (byteCount != FS_ACTUALIZATIONTIMEOUT1_LENGTH)
   {
      FS_ERR("Failed to read ActualizationTimeout1 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationTimeout1, FS_ACTUALIZATIONTIMEOUT1_LENGTH);

   // Read ActualizationWaitTime2 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationWaitTime2, FS_ACTUALIZATIONWAITTIME2_LENGTH);
   if (byteCount != FS_ACTUALIZATIONWAITTIME2_LENGTH)
   {
      FS_ERR("Failed to read ActualizationWaitTime2 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationWaitTime2, FS_ACTUALIZATIONWAITTIME2_LENGTH);

   // Read ActualizationTemperatureTolerance2 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationTemperatureTolerance2, FS_ACTUALIZATIONTEMPERATURETOLERANCE2_LENGTH);
   if (byteCount != FS_ACTUALIZATIONTEMPERATURETOLERANCE2_LENGTH)
   {
      FS_ERR("Failed to read ActualizationTemperatureTolerance2 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationTemperatureTolerance2, FS_ACTUALIZATIONTEMPERATURETOLERANCE2_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Read ActualizationStabilizationTime2 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationStabilizationTime2, FS_ACTUALIZATIONSTABILIZATIONTIME2_LENGTH);
   if (byteCount != FS_ACTUALIZATIONSTABILIZATIONTIME2_LENGTH)
   {
      FS_ERR("Failed to read ActualizationStabilizationTime2 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationStabilizationTime2, FS_ACTUALIZATIONSTABILIZATIONTIME2_LENGTH);

   // Read ActualizationTimeout2 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ActualizationTimeout2, FS_ACTUALIZATIONTIMEOUT2_LENGTH);
   if (byteCount != FS_ACTUALIZATIONTIMEOUT2_LENGTH)
   {
      FS_ERR("Failed to read ActualizationTimeout2 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ActualizationTimeout2, FS_ACTUALIZATIONTIMEOUT2_LENGTH);

   // Read DetectorPolarizationVoltage flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DetectorPolarizationVoltage, FS_DETECTORPOLARIZATIONVOLTAGE_LENGTH);
   if (byteCount != FS_DETECTORPOLARIZATIONVOLTAGE_LENGTH)
   {
      FS_ERR("Failed to read DetectorPolarizationVoltage field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DetectorPolarizationVoltage, FS_DETECTORPOLARIZATIONVOLTAGE_LENGTH);

   // Read ExternalMemoryBufferPresent flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ExternalMemoryBufferPresent, FS_EXTERNALMEMORYBUFFERPRESENT_LENGTH);
   if (byteCount != FS_EXTERNALMEMORYBUFFERPRESENT_LENGTH)
   {
      FS_ERR("Failed to read ExternalMemoryBufferPresent field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ExternalMemoryBufferPresent, FS_EXTERNALMEMORYBUFFERPRESENT_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Read NDFPresent flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->NDFPresent, FS_NDFPRESENT_LENGTH);
   if (byteCount != FS_NDFPRESENT_LENGTH)
   {
      FS_ERR("Failed to read NDFPresent field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->NDFPresent, FS_NDFPRESENT_LENGTH);

   // Read NDFNumberOfFilters flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->NDFNumberOfFilters, FS_NDFNUMBEROFFILTERS_LENGTH);
   if (byteCount != FS_NDFNUMBEROFFILTERS_LENGTH)
   {
      FS_ERR("Failed to read NDFNumberOfFilters field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->NDFNumberOfFilters, FS_NDFNUMBEROFFILTERS_LENGTH);

   // Read NDFClearFOVWidth flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->NDFClearFOVWidth, FS_NDFCLEARFOVWIDTH_LENGTH);
   if (byteCount != FS_NDFCLEARFOVWIDTH_LENGTH)
   {
      FS_ERR("Failed to read NDFClearFOVWidth field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->NDFClearFOVWidth, FS_NDFCLEARFOVWIDTH_LENGTH);

   // Read NDF0CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->NDF0CenterPosition, FS_NDF0CENTERPOSITION_LENGTH);
   if (byteCount != FS_NDF0CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read NDF0CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->NDF0CenterPosition, FS_NDF0CENTERPOSITION_LENGTH);

   // Read NDF1CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->NDF1CenterPosition, FS_NDF1CENTERPOSITION_LENGTH);
   if (byteCount != FS_NDF1CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read NDF1CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->NDF1CenterPosition, FS_NDF1CENTERPOSITION_LENGTH);

   // Read NDF2CenterPosition flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->NDF2CenterPosition, FS_NDF2CENTERPOSITION_LENGTH);
   if (byteCount != FS_NDF2CENTERPOSITION_LENGTH)
   {
      FS_ERR("Failed to read NDF2CenterPosition field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->NDF2CenterPosition, FS_NDF2CENTERPOSITION_LENGTH);

   // Read FWSpeedMax flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWSpeedMax, FS_FWSPEEDMAX_LENGTH);
   if (byteCount != FS_FWSPEEDMAX_LENGTH)
   {
      FS_ERR("Failed to read FWSpeedMax field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWSpeedMax, FS_FWSPEEDMAX_LENGTH);

   // Read FWEncoderCyclePerTurn flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWEncoderCyclePerTurn, FS_FWENCODERCYCLEPERTURN_LENGTH);
   if (byteCount != FS_FWENCODERCYCLEPERTURN_LENGTH)
   {
      FS_ERR("Failed to read FWEncoderCyclePerTurn field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWEncoderCyclePerTurn, FS_FWENCODERCYCLEPERTURN_LENGTH);

   // Read FWOpticalAxisPosX flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWOpticalAxisPosX, FS_FWOPTICALAXISPOSX_LENGTH);
   if (byteCount != FS_FWOPTICALAXISPOSX_LENGTH)
   {
      FS_ERR("Failed to read FWOpticalAxisPosX field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWOpticalAxisPosX, FS_FWOPTICALAXISPOSX_LENGTH);

   // Read FWOpticalAxisPosY flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWOpticalAxisPosY, FS_FWOPTICALAXISPOSY_LENGTH);
   if (byteCount != FS_FWOPTICALAXISPOSY_LENGTH)
   {
      FS_ERR("Failed to read FWOpticalAxisPosY field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWOpticalAxisPosY, FS_FWOPTICALAXISPOSY_LENGTH);

   // Read FWMountingHoleRadius flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWMountingHoleRadius, FS_FWMOUNTINGHOLERADIUS_LENGTH);
   if (byteCount != FS_FWMOUNTINGHOLERADIUS_LENGTH)
   {
      FS_ERR("Failed to read FWMountingHoleRadius field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWMountingHoleRadius, FS_FWMOUNTINGHOLERADIUS_LENGTH);

   // Read FWBeamMarging flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWBeamMarging, FS_FWBEAMMARGING_LENGTH);
   if (byteCount != FS_FWBEAMMARGING_LENGTH)
   {
      FS_ERR("Failed to read FWBeamMarging field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWBeamMarging, FS_FWBEAMMARGING_LENGTH);

   // Read FWCornerPixDistX flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWCornerPixDistX, FS_FWCORNERPIXDISTX_LENGTH);
   if (byteCount != FS_FWCORNERPIXDISTX_LENGTH)
   {
      FS_ERR("Failed to read FWCornerPixDistX field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWCornerPixDistX, FS_FWCORNERPIXDISTX_LENGTH);

   // Read FWCornerPixDistY flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWCornerPixDistY, FS_FWCORNERPIXDISTY_LENGTH);
   if (byteCount != FS_FWCORNERPIXDISTY_LENGTH)
   {
      FS_ERR("Failed to read FWCornerPixDistY field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWCornerPixDistY, FS_FWCORNERPIXDISTY_LENGTH);

   // Read FWCenterPixRadius flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWCenterPixRadius, FS_FWCENTERPIXRADIUS_LENGTH);
   if (byteCount != FS_FWCENTERPIXRADIUS_LENGTH)
   {
      FS_ERR("Failed to read FWCenterPixRadius field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWCenterPixRadius, FS_FWCENTERPIXRADIUS_LENGTH);

   // Read FWCornerPixRadius flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWCornerPixRadius, FS_FWCORNERPIXRADIUS_LENGTH);
   if (byteCount != FS_FWCORNERPIXRADIUS_LENGTH)
   {
      FS_ERR("Failed to read FWCornerPixRadius field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWCornerPixRadius, FS_FWCORNERPIXRADIUS_LENGTH);

   // Read FWPositionControllerPP flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWPositionControllerPP, FS_FWPOSITIONCONTROLLERPP_LENGTH);
   if (byteCount != FS_FWPOSITIONCONTROLLERPP_LENGTH)
   {
      FS_ERR("Failed to read FWPositionControllerPP field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWPositionControllerPP, FS_FWPOSITIONCONTROLLERPP_LENGTH);

   // Read FWPositionControllerPD flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWPositionControllerPD, FS_FWPOSITIONCONTROLLERPD_LENGTH);
   if (byteCount != FS_FWPOSITIONCONTROLLERPD_LENGTH)
   {
      FS_ERR("Failed to read FWPositionControllerPD field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWPositionControllerPD, FS_FWPOSITIONCONTROLLERPD_LENGTH);

   // Read FWPositionControllerPOR flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWPositionControllerPOR, FS_FWPOSITIONCONTROLLERPOR_LENGTH);
   if (byteCount != FS_FWPOSITIONCONTROLLERPOR_LENGTH)
   {
      FS_ERR("Failed to read FWPositionControllerPOR field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWPositionControllerPOR, FS_FWPOSITIONCONTROLLERPOR_LENGTH);

   // Read FWPositionControllerI flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWPositionControllerI, FS_FWPOSITIONCONTROLLERI_LENGTH);
   if (byteCount != FS_FWPOSITIONCONTROLLERI_LENGTH)
   {
      FS_ERR("Failed to read FWPositionControllerI field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWPositionControllerI, FS_FWPOSITIONCONTROLLERI_LENGTH);

   // Read FWSlowSpeedControllerPP flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWSlowSpeedControllerPP, FS_FWSLOWSPEEDCONTROLLERPP_LENGTH);
   if (byteCount != FS_FWSLOWSPEEDCONTROLLERPP_LENGTH)
   {
      FS_ERR("Failed to read FWSlowSpeedControllerPP field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWSlowSpeedControllerPP, FS_FWSLOWSPEEDCONTROLLERPP_LENGTH);

   // Read FWSlowSpeedControllerPD flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWSlowSpeedControllerPD, FS_FWSLOWSPEEDCONTROLLERPD_LENGTH);
   if (byteCount != FS_FWSLOWSPEEDCONTROLLERPD_LENGTH)
   {
      FS_ERR("Failed to read FWSlowSpeedControllerPD field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWSlowSpeedControllerPD, FS_FWSLOWSPEEDCONTROLLERPD_LENGTH);

   // Read FWSlowSpeedControllerPOR flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWSlowSpeedControllerPOR, FS_FWSLOWSPEEDCONTROLLERPOR_LENGTH);
   if (byteCount != FS_FWSLOWSPEEDCONTROLLERPOR_LENGTH)
   {
      FS_ERR("Failed to read FWSlowSpeedControllerPOR field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWSlowSpeedControllerPOR, FS_FWSLOWSPEEDCONTROLLERPOR_LENGTH);

   // Read FWSlowSpeedControllerPI flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWSlowSpeedControllerPI, FS_FWSLOWSPEEDCONTROLLERPI_LENGTH);
   if (byteCount != FS_FWSLOWSPEEDCONTROLLERPI_LENGTH)
   {
      FS_ERR("Failed to read FWSlowSpeedControllerPI field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWSlowSpeedControllerPI, FS_FWSLOWSPEEDCONTROLLERPI_LENGTH);

   // Read FWFastSpeedControllerPP flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWFastSpeedControllerPP, FS_FWFASTSPEEDCONTROLLERPP_LENGTH);
   if (byteCount != FS_FWFASTSPEEDCONTROLLERPP_LENGTH)
   {
      FS_ERR("Failed to read FWFastSpeedControllerPP field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWFastSpeedControllerPP, FS_FWFASTSPEEDCONTROLLERPP_LENGTH);

   // Read FWFastSpeedControllerPD flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWFastSpeedControllerPD, FS_FWFASTSPEEDCONTROLLERPD_LENGTH);
   if (byteCount != FS_FWFASTSPEEDCONTROLLERPD_LENGTH)
   {
      FS_ERR("Failed to read FWFastSpeedControllerPD field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWFastSpeedControllerPD, FS_FWFASTSPEEDCONTROLLERPD_LENGTH);

   // Read FWFastSpeedControllerPOR flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWFastSpeedControllerPOR, FS_FWFASTSPEEDCONTROLLERPOR_LENGTH);
   if (byteCount != FS_FWFASTSPEEDCONTROLLERPOR_LENGTH)
   {
      FS_ERR("Failed to read FWFastSpeedControllerPOR field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWFastSpeedControllerPOR, FS_FWFASTSPEEDCONTROLLERPOR_LENGTH);

   // Read FWFastSpeedControllerI flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWFastSpeedControllerI, FS_FWFASTSPEEDCONTROLLERI_LENGTH);
   if (byteCount != FS_FWFASTSPEEDCONTROLLERI_LENGTH)
   {
      FS_ERR("Failed to read FWFastSpeedControllerI field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWFastSpeedControllerI, FS_FWFASTSPEEDCONTROLLERI_LENGTH);

   // Read FWSpeedControllerSwitchingThreshold flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWSpeedControllerSwitchingThreshold, FS_FWSPEEDCONTROLLERSWITCHINGTHRESHOLD_LENGTH);
   if (byteCount != FS_FWSPEEDCONTROLLERSWITCHINGTHRESHOLD_LENGTH)
   {
      FS_ERR("Failed to read FWSpeedControllerSwitchingThreshold field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWSpeedControllerSwitchingThreshold, FS_FWSPEEDCONTROLLERSWITCHINGTHRESHOLD_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Read FWExposureTimeMaxMargin flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FWExposureTimeMaxMargin, FS_FWEXPOSURETIMEMAXMARGIN_LENGTH);
   if (byteCount != FS_FWEXPOSURETIMEMAXMARGIN_LENGTH)
   {
      FS_ERR("Failed to read FWExposureTimeMaxMargin field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FWExposureTimeMaxMargin, FS_FWEXPOSURETIMEMAXMARGIN_LENGTH);

   // Read ExternalFanSpeedSetpoint flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->ExternalFanSpeedSetpoint, FS_EXTERNALFANSPEEDSETPOINT_LENGTH);
   if (byteCount != FS_EXTERNALFANSPEEDSETPOINT_LENGTH)
   {
      FS_ERR("Failed to read ExternalFanSpeedSetpoint field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->ExternalFanSpeedSetpoint, FS_EXTERNALFANSPEEDSETPOINT_LENGTH);

   // Read BPDetectionEnabled flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPDetectionEnabled, FS_BPDETECTIONENABLED_LENGTH);
   if (byteCount != FS_BPDETECTIONENABLED_LENGTH)
   {
      FS_ERR("Failed to read BPDetectionEnabled field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPDetectionEnabled, FS_BPDETECTIONENABLED_LENGTH);

   // Read BPNumSamples flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPNumSamples, FS_BPNUMSAMPLES_LENGTH);
   if (byteCount != FS_BPNUMSAMPLES_LENGTH)
   {
      FS_ERR("Failed to read BPNumSamples field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPNumSamples, FS_BPNUMSAMPLES_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 1);
   if (byteCount != 1)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 1);

   // Read BPFlickerThreshold flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPFlickerThreshold, FS_BPFLICKERTHRESHOLD_LENGTH);
   if (byteCount != FS_BPFLICKERTHRESHOLD_LENGTH)
   {
      FS_ERR("Failed to read BPFlickerThreshold field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPFlickerThreshold, FS_BPFLICKERTHRESHOLD_LENGTH);

   // Read BPNoiseThreshold flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPNoiseThreshold, FS_BPNOISETHRESHOLD_LENGTH);
   if (byteCount != FS_BPNOISETHRESHOLD_LENGTH)
   {
      FS_ERR("Failed to read BPNoiseThreshold field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPNoiseThreshold, FS_BPNOISETHRESHOLD_LENGTH);

   // Read BPDuration flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPDuration, FS_BPDURATION_LENGTH);
   if (byteCount != FS_BPDURATION_LENGTH)
   {
      FS_ERR("Failed to read BPDuration field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPDuration, FS_BPDURATION_LENGTH);

   // Read BPNCoadd flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPNCoadd, FS_BPNCOADD_LENGTH);
   if (byteCount != FS_BPNCOADD_LENGTH)
   {
      FS_ERR("Failed to read BPNCoadd field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPNCoadd, FS_BPNCOADD_LENGTH);

   // Skip FREE space
   byteCount = uffs_read(fd, tmpFileDataBuffer, 2);
   if (byteCount != 2)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, 2);

   // Read MaximumTotalFlux flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->MaximumTotalFlux, FS_MAXIMUMTOTALFLUX_LENGTH);
   if (byteCount != FS_MAXIMUMTOTALFLUX_LENGTH)
   {
      FS_ERR("Failed to read MaximumTotalFlux field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->MaximumTotalFlux, FS_MAXIMUMTOTALFLUX_LENGTH);

   // Read FluxRatio01 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FluxRatio01, FS_FLUXRATIO01_LENGTH);
   if (byteCount != FS_FLUXRATIO01_LENGTH)
   {
      FS_ERR("Failed to read FluxRatio01 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FluxRatio01, FS_FLUXRATIO01_LENGTH);

   // Read FluxRatio12 flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->FluxRatio12, FS_FLUXRATIO12_LENGTH);
   if (byteCount != FS_FLUXRATIO12_LENGTH)
   {
      FS_ERR("Failed to read FluxRatio12 field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->FluxRatio12, FS_FLUXRATIO12_LENGTH);

   // Read AECPlusExpTimeMargin flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->AECPlusExpTimeMargin, FS_AECPLUSEXPTIMEMARGIN_LENGTH);
   if (byteCount != FS_AECPLUSEXPTIMEMARGIN_LENGTH)
   {
      FS_ERR("Failed to read AECPlusExpTimeMargin field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->AECPlusExpTimeMargin, FS_AECPLUSEXPTIMEMARGIN_LENGTH);

   // Read AECPlusFluxMargin flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->AECPlusFluxMargin, FS_AECPLUSFLUXMARGIN_LENGTH);
   if (byteCount != FS_AECPLUSFLUXMARGIN_LENGTH)
   {
      FS_ERR("Failed to read AECPlusFluxMargin field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->AECPlusFluxMargin, FS_AECPLUSFLUXMARGIN_LENGTH);

   // Read BPOutlierThreshold flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPOutlierThreshold, FS_BPOUTLIERTHRESHOLD_LENGTH);
   if (byteCount != FS_BPOUTLIERTHRESHOLD_LENGTH)
   {
      FS_ERR("Failed to read BPOutlierThreshold field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPOutlierThreshold, FS_BPOUTLIERTHRESHOLD_LENGTH);

   // Read BPAECImageFraction flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPAECImageFraction, FS_BPAECIMAGEFRACTION_LENGTH);
   if (byteCount != FS_BPAECIMAGEFRACTION_LENGTH)
   {
      FS_ERR("Failed to read BPAECImageFraction field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPAECImageFraction, FS_BPAECIMAGEFRACTION_LENGTH);

   // Read BPAECWellFilling flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPAECWellFilling, FS_BPAECWELLFILLING_LENGTH);
   if (byteCount != FS_BPAECWELLFILLING_LENGTH)
   {
      FS_ERR("Failed to read BPAECWellFilling field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPAECWellFilling, FS_BPAECWELLFILLING_LENGTH);

   // Read BPAECResponseTime flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->BPAECResponseTime, FS_BPAECRESPONSETIME_LENGTH);
   if (byteCount != FS_BPAECRESPONSETIME_LENGTH)
   {
      FS_ERR("Failed to read BPAECResponseTime field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->BPAECResponseTime, FS_BPAECRESPONSETIME_LENGTH);

   // Read DeviceKeyExpirationPOSIXTime flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DeviceKeyExpirationPOSIXTime, FS_DEVICEKEYEXPIRATIONPOSIXTIME_LENGTH);
   if (byteCount != FS_DEVICEKEYEXPIRATIONPOSIXTIME_LENGTH)
   {
      FS_ERR("Failed to read DeviceKeyExpirationPOSIXTime field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DeviceKeyExpirationPOSIXTime, FS_DEVICEKEYEXPIRATIONPOSIXTIME_LENGTH);

   // Read DeviceKeyLow flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DeviceKeyLow, FS_DEVICEKEYLOW_LENGTH);
   if (byteCount != FS_DEVICEKEYLOW_LENGTH)
   {
      FS_ERR("Failed to read DeviceKeyLow field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DeviceKeyLow, FS_DEVICEKEYLOW_LENGTH);

   // Read DeviceKeyHigh flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DeviceKeyHigh, FS_DEVICEKEYHIGH_LENGTH);
   if (byteCount != FS_DEVICEKEYHIGH_LENGTH)
   {
      FS_ERR("Failed to read DeviceKeyHigh field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DeviceKeyHigh, FS_DEVICEKEYHIGH_LENGTH);

   // Read DetectorElectricalTapsRef flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DetectorElectricalTapsRef, FS_DETECTORELECTRICALTAPSREF_LENGTH);
   if (byteCount != FS_DETECTORELECTRICALTAPSREF_LENGTH)
   {
      FS_ERR("Failed to read DetectorElectricalTapsRef field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DetectorElectricalTapsRef, FS_DETECTORELECTRICALTAPSREF_LENGTH);

   // Read DetectorElectricalRefOffset flash settings field
   byteCount = uffs_read(fd, &p_flashSettings->DetectorElectricalRefOffset, FS_DETECTORELECTRICALREFOFFSET_LENGTH);
   if (byteCount != FS_DETECTORELECTRICALREFOFFSET_LENGTH)
   {
      FS_ERR("Failed to read DetectorElectricalRefOffset field.");
      return IRC_FAILURE;
   }
   *p_crc16 = CRC16(*p_crc16, (uint8_t *) &p_flashSettings->DetectorElectricalRefOffset, FS_DETECTORELECTRICALREFOFFSET_LENGTH);

/* AUTO-CODE FIELDS END */

   return IRC_SUCCESS;
}

/**
 * Skip spare free space in flash settings file.
 *
 * @param fd is the flash settings file descriptor.
 * @param p_dataOffset is the free space offset starting from zero.
 * @param p_crc16 is the pointer to flash settings file crc16 value to update.
 *
 * @return IRC_SUCCESS if successfully skipped spare free space.
 * @return IRC_FAILURE if failed to skip spare free space.
 * @return IRC_NOT_DONE if there is some spare free space left to skip.
 */
IRC_Status_t FlashSettings_SkipSpareFreeSpace(int fd, uint32_t *p_dataOffset, uint16_t *p_crc16)
{
   int byteCount;
   uint32_t dataLength;

   dataLength = MIN(FS_MAX_SPARE_FREE_SPACE_READ_BYTES, FS_SPARE_FREE_SPACE_LENGTH - *p_dataOffset);

   byteCount = uffs_read(fd, tmpFileDataBuffer, dataLength);
   if (byteCount != dataLength)
   {
      FS_ERR("Failed to read free space.");
      return IRC_FAILURE;
   }
   else
   {
      *p_crc16 = CRC16(*p_crc16, tmpFileDataBuffer, dataLength);

      *p_dataOffset += dataLength;

      if (*p_dataOffset == FS_SPARE_FREE_SPACE_LENGTH)
      {
         return IRC_SUCCESS;
      }
   }

   return IRC_NOT_DONE;
}

/**
 * Load and validate flash settings file CRC-16 value.
 *
 * @param fd is the flash settings file descriptor.
 * @param p_flashSettings is the pointer to flash settings data structure to update.
 * @param crc16 is the flash settings file crc16 value.
 *
 * @return IRC_SUCCESS if successfully validated flash settings file CRC-16 value.
 * @return IRC_FAILURE if failed to validate flash settings file CRC-16 value.
 */
IRC_Status_t FlashSettings_ValidateCRC16(int fd, flashSettings_t *p_flashSettings, uint16_t crc16)
{
   int byteCount;

   // Read FlashSettingsFileCRC16 flash settings field
   byteCount = uffs_read(fdFlashSettings, &flashSettings.FlashSettingsFileCRC16, FS_FLASHSETTINGSFILECRC16_LENGTH);
   if (byteCount != FS_FLASHSETTINGSFILECRC16_LENGTH)
   {
      FS_ERR("Failed to read FlashSettingsFileCRC16 field.");
      return IRC_FAILURE;
   }

   // Validate flash settings file CRC-16
   if (crc16 != flashSettings.FlashSettingsFileCRC16)
   {
      // Wrong flash settings file CRC-16
      FS_ERR("Wrong flash settings file CRC-16.");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}

/**
 * Update flash settings data to current version using default values.
 *
 * @param p_flashSettings is the pointer to flash settings data structure to update.
 */
void FlashSettings_UpdateVersion(flashSettings_t *p_flashSettings)
{
   if ((p_flashSettings->FileStructureMajorVersion == FS_FILESTRUCTUREMAJORVERSION) &&
         (p_flashSettings->FileStructureMinorVersion == FS_FILESTRUCTUREMINORVERSION) &&
         (p_flashSettings->FileStructureSubMinorVersion == FS_FILESTRUCTURESUBMINORVERSION))
   {
      // Up to date
      return;
   }

   switch (p_flashSettings->FileStructureMajorVersion)
   {
      case 1:
         // 1.x.x
         switch (p_flashSettings->FileStructureMinorVersion)
         {
            case 0:
               // 1.0.x -> 1.1.x
               p_flashSettings->ActualizationAECImageFraction = flashSettingsDefault.ActualizationAECImageFraction;
               p_flashSettings->ActualizationAECTargetWellFilling = flashSettingsDefault.ActualizationAECTargetWellFilling;
               p_flashSettings->ActualizationAECResponseTime = flashSettingsDefault.ActualizationAECResponseTime;
               // ActualizationNumerOfImagesCoadd replaced by ActualizationNumberOfImagesCoadd in version 1.2.x
               // ActualizationICUTemperatureTol has been removed in version 1.3.x
               p_flashSettings->ActualizationEnabled = flashSettingsDefault.ActualizationEnabled;
               p_flashSettings->ActualizationAtPowerOn = flashSettingsDefault.ActualizationAtPowerOn;
               // PowerOnAtStartup has been removed in version 1.3.x
               // AcquisitionStartAtStartup has been removed in version 1.3.x
               p_flashSettings->ReverseX = flashSettingsDefault.ReverseX;
               p_flashSettings->ReverseY = flashSettingsDefault.ReverseY;

            case 1:
               // 1.1.x -> 1.2.x
               p_flashSettings->ActualizationNumberOfImagesCoadd = flashSettingsDefault.ActualizationNumberOfImagesCoadd;
               p_flashSettings->FWPresent = flashSettingsDefault.FWPresent;
               p_flashSettings->FWNumberOfFilters = flashSettingsDefault.FWNumberOfFilters;
               p_flashSettings->FW0CenterPosition = flashSettingsDefault.FW0CenterPosition;
               p_flashSettings->FW1CenterPosition = flashSettingsDefault.FW1CenterPosition;
               p_flashSettings->FW2CenterPosition = flashSettingsDefault.FW2CenterPosition;
               p_flashSettings->FW3CenterPosition = flashSettingsDefault.FW3CenterPosition;
               p_flashSettings->FW4CenterPosition = flashSettingsDefault.FW4CenterPosition;
               p_flashSettings->FW5CenterPosition = flashSettingsDefault.FW5CenterPosition;
               p_flashSettings->FW6CenterPosition = flashSettingsDefault.FW6CenterPosition;
               p_flashSettings->FW7CenterPosition = flashSettingsDefault.FW7CenterPosition;

            case 2:
               // 1.2.x -> 1.3.x
               p_flashSettings->ActualizationTemperatureSelector = flashSettingsDefault.ActualizationTemperatureSelector;
               p_flashSettings->ActualizationWaitTime1 = flashSettingsDefault.ActualizationWaitTime1;
               p_flashSettings->ActualizationTemperatureTolerance1 = flashSettingsDefault.ActualizationTemperatureTolerance1;
               p_flashSettings->ActualizationStabilizationTime1 = flashSettingsDefault.ActualizationStabilizationTime1;
               p_flashSettings->ActualizationTimeout1 = flashSettingsDefault.ActualizationTimeout1;
               p_flashSettings->ActualizationWaitTime2 = flashSettingsDefault.ActualizationWaitTime2;
               p_flashSettings->ActualizationTemperatureTolerance2 = flashSettingsDefault.ActualizationTemperatureTolerance2;
               p_flashSettings->ActualizationStabilizationTime2 = flashSettingsDefault.ActualizationStabilizationTime2;
               p_flashSettings->ActualizationTimeout2 = flashSettingsDefault.ActualizationTimeout2;
               p_flashSettings->DetectorPolarizationVoltage = flashSettingsDefault.DetectorPolarizationVoltage;

            case 3:
               // 1.3.x -> 1.4.x
               p_flashSettings->ExternalMemoryBufferPresent = flashSettingsDefault.ExternalMemoryBufferPresent;

            case 4:
               // 1.4.x -> 1.5.x
               p_flashSettings->NDFPresent = flashSettingsDefault.NDFPresent;
               p_flashSettings->NDFNumberOfFilters = flashSettingsDefault.NDFNumberOfFilters;
               p_flashSettings->NDFClearFOVWidth = flashSettingsDefault.NDFClearFOVWidth;
               p_flashSettings->NDF0CenterPosition = flashSettingsDefault.NDF0CenterPosition;
               p_flashSettings->NDF1CenterPosition = flashSettingsDefault.NDF1CenterPosition;
               p_flashSettings->NDF2CenterPosition = flashSettingsDefault.NDF2CenterPosition;

            case 5:
               // 1.5.x -> 1.6.x
               p_flashSettings->FWType = flashSettingsDefault.FWType;
               p_flashSettings->FWSpeedMax = flashSettingsDefault.FWSpeedMax;
               p_flashSettings->FWEncoderCyclePerTurn = flashSettingsDefault.FWEncoderCyclePerTurn;
               p_flashSettings->FWOpticalAxisPosX = flashSettingsDefault.FWOpticalAxisPosX;
               p_flashSettings->FWOpticalAxisPosY = flashSettingsDefault.FWOpticalAxisPosY;
               p_flashSettings->FWMountingHoleRadius = flashSettingsDefault.FWMountingHoleRadius;
               p_flashSettings->FWBeamMarging = flashSettingsDefault.FWBeamMarging;
               p_flashSettings->FWCornerPixDistX = flashSettingsDefault.FWCornerPixDistX;
               p_flashSettings->FWCornerPixDistY = flashSettingsDefault.FWCornerPixDistY;
               p_flashSettings->FWCenterPixRadius = flashSettingsDefault.FWCenterPixRadius;
               p_flashSettings->FWCornerPixRadius = flashSettingsDefault.FWCornerPixRadius;
               p_flashSettings->FWPositionControllerPP = flashSettingsDefault.FWPositionControllerPP;
               p_flashSettings->FWPositionControllerPD = flashSettingsDefault.FWPositionControllerPD;
               p_flashSettings->FWPositionControllerPOR = flashSettingsDefault.FWPositionControllerPOR;
               p_flashSettings->FWPositionControllerI = flashSettingsDefault.FWPositionControllerI;
               p_flashSettings->FWSlowSpeedControllerPP = flashSettingsDefault.FWSlowSpeedControllerPP;
               p_flashSettings->FWSlowSpeedControllerPD = flashSettingsDefault.FWSlowSpeedControllerPD;
               p_flashSettings->FWSlowSpeedControllerPOR = flashSettingsDefault.FWSlowSpeedControllerPOR;
               p_flashSettings->FWSlowSpeedControllerPI = flashSettingsDefault.FWSlowSpeedControllerPI;
               p_flashSettings->FWFastSpeedControllerPP = flashSettingsDefault.FWFastSpeedControllerPP;
               p_flashSettings->FWFastSpeedControllerPD = flashSettingsDefault.FWFastSpeedControllerPD;
               p_flashSettings->FWFastSpeedControllerPOR = flashSettingsDefault.FWFastSpeedControllerPOR;
               p_flashSettings->FWFastSpeedControllerI = flashSettingsDefault.FWFastSpeedControllerI;
               p_flashSettings->FWSpeedControllerSwitchingThreshold = flashSettingsDefault.FWSpeedControllerSwitchingThreshold;

            case 6:
               // 1.6.x -> 1.7.x
               p_flashSettings->FWExposureTimeMaxMargin = flashSettingsDefault.FWExposureTimeMaxMargin;
               p_flashSettings->ExternalFanSpeedSetpoint = flashSettingsDefault.ExternalFanSpeedSetpoint;

            case 7:
               // 1.7.x -> 1.8.x
               p_flashSettings->BPDetectionEnabled = flashSettingsDefault.BPDetectionEnabled;
               p_flashSettings->BPNumSamples = flashSettingsDefault.BPNumSamples;
               p_flashSettings->BPFlickerThreshold = flashSettingsDefault.BPFlickerThreshold;
               p_flashSettings->BPNoiseThreshold = flashSettingsDefault.BPNoiseThreshold;
               p_flashSettings->BPDuration = flashSettingsDefault.BPDuration;
               p_flashSettings->BPNCoadd = flashSettingsDefault.BPNCoadd;
               p_flashSettings->MaximumTotalFlux = flashSettingsDefault.MaximumTotalFlux;
               p_flashSettings->FluxRatio01 = flashSettingsDefault.FluxRatio01;
               p_flashSettings->FluxRatio12 = flashSettingsDefault.FluxRatio12;
               p_flashSettings->AECPlusExpTimeMargin = flashSettingsDefault.AECPlusExpTimeMargin;
               p_flashSettings->AECPlusFluxMargin = flashSettingsDefault.AECPlusFluxMargin;

            case 8:
               // 1.8.x -> 1.9.x
               p_flashSettings->BPOutlierThreshold = flashSettingsDefault.BPOutlierThreshold;
               p_flashSettings->BPAECImageFraction = flashSettingsDefault.BPAECImageFraction;
               p_flashSettings->BPAECWellFilling = flashSettingsDefault.BPAECWellFilling;
               p_flashSettings->BPAECResponseTime = flashSettingsDefault.BPAECResponseTime;

            case 9:
               // 1.9.x -> 1.10.x
               p_flashSettings->DeviceKeyExpirationPOSIXTime = flashSettingsDefault.DeviceKeyExpirationPOSIXTime;
               p_flashSettings->DeviceKeyLow = flashSettingsDefault.DeviceKeyLow;
               p_flashSettings->DeviceKeyHigh = flashSettingsDefault.DeviceKeyHigh;

            case 10:
               // 1.10.x -> 1.11.x
               p_flashSettings->ActualizationDiscardOffset = flashSettingsDefault.ActualizationDiscardOffset;

            case 11:
               // 1.11.x -> 1.12.x
               p_flashSettings->DetectorElectricalTapsRef = flashSettingsDefault.DetectorElectricalTapsRef;
               p_flashSettings->DetectorElectricalRefOffset = flashSettingsDefault.DetectorElectricalRefOffset;

            case FS_FILESTRUCTUREMINORVERSION:
               // Break after the last minor version only
               break;

            default:
               // Up to date, nothing to do
               return;
         }

         // Break after the last major version only
         break;

      default:
         // Up to date, nothing to do
         return;
   }

   FS_INF("File structure version %d.%d.%d has been updated to version %d.%d.%d.",
         p_flashSettings->FileStructureMajorVersion,
         p_flashSettings->FileStructureMinorVersion,
         p_flashSettings->FileStructureSubMinorVersion,
         FS_FILESTRUCTUREMAJORVERSION,
         FS_FILESTRUCTUREMINORVERSION,
         FS_FILESTRUCTURESUBMINORVERSION);

   p_flashSettings->FileStructureMinorVersion = FS_FILESTRUCTUREMINORVERSION;
   p_flashSettings->FileStructureSubMinorVersion = FS_FILESTRUCTURESUBMINORVERSION;
}

/**
 * Finalize flash settings file loading.
 *
 * @param p_flashSettings is the pointer to flash settings data structure to update.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t FlashSettings_Finalize(flashSettings_t *p_flashSettings)
{
   FlashSettings_UpdateFixFWSettings(p_flashSettings);
   FlashSettings_UpdateVersion(p_flashSettings);
   p_flashSettings->isValid = 1;
   TDCStatusClr(WaitingForFlashSettingsInitMask);

   return FlashSettings_UpdateCameraSettings(p_flashSettings);
}

/**
 * Flash settings file error.
 *
 * @param p_flashSettings is the pointer to flash settings data structure to update.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t FlashSettings_Error(flashSettings_t *p_flashSettings)
{
   return FlashSettings_Reset(p_flashSettings);
}

/**
 * Flash settings reset.
 *
 * @param p_flashSettings is the pointer to flash settings data structure to reset.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t FlashSettings_Reset(flashSettings_t *p_flashSettings)
{
   *p_flashSettings = flashSettingsDefault;
   TDCStatusSet(WaitingForFlashSettingsInitMask);

   return FlashSettings_UpdateCameraSettings(p_flashSettings);
}

/**
 * Update camera using flash settings data.
 */
IRC_Status_t FlashSettings_UpdateCameraSettings(flashSettings_t *p_flashSettings)
{
   extern ICU_config_t gICU_ctrl;
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern t_FpaIntf gFpaIntf;
   extern bool gDisableFilterWheel;
   uint8_t externalMemoryBufferDetected = BufferManager_DetectExternalMemoryBuffer();

   // Update device serial number
   gcRegsData.DeviceSerialNumber = p_flashSettings->DeviceSerialNumber;
   if (p_flashSettings->DeviceSerialNumber <= 99999)
   {
      sprintf(gcRegsData.DeviceID, "TEL%05d", (int) p_flashSettings->DeviceSerialNumber);
   }

   // Update device model name
   memset(gcRegsData.DeviceModelName, 0 , gcRegsDef[DeviceModelNameIdx].dataLength + 1);
   strcpy(gcRegsData.DeviceModelName, p_flashSettings->DeviceModelName);

   // Update pixel data resolution
   gcRegsData.PixelDataResolution = p_flashSettings->PixelDataResolution;

   // Update sensor ID
   gcRegsData.SensorID = p_flashSettings->SensorID;

   // Update reverse X/Y
   GC_RegisterWriteUI32(&gcRegsDef[ReverseXIdx], flashSettings.ReverseX ^ calibrationInfo.collection.ReverseX);
   GC_RegisterWriteUI32(&gcRegsDef[ReverseYIdx], flashSettings.ReverseY ^ calibrationInfo.collection.ReverseY);

   // Update ICU
   if (p_flashSettings->ICUPresent)
   {
      TDCFlagsSet(ICUIsImplementedMask);
      gcRegsData.CalibrationActualizationMode = CAM_ICU;
   }
   else
   {
      TDCFlagsClr(ICUIsImplementedMask);
      gcRegsData.CalibrationActualizationMode = CAM_BlackBody;
   }

   // Validate that FW and NDF are not both present
   if (p_flashSettings->FWPresent && p_flashSettings->NDFPresent)
   {
      // Disable both of them
      p_flashSettings->FWPresent = 0;
      p_flashSettings->NDFPresent = 0;

      FS_ERR("FW and NDF are both present. They have been disabled.");
   }

   // Update FW
   p_flashSettings->FWPresent &= ~gDisableFilterWheel;
   gcRegsData.FWFilterNumber = p_flashSettings->FWNumberOfFilters;
   if (p_flashSettings->FWPresent && (p_flashSettings->FWNumberOfFilters > 0))
   {
      TDCFlagsSet(FWIsImplementedMask);
      if(p_flashSettings->FWType == 1)
      {
         TDCFlagsSet(FWSynchronouslyRotatingModeIsImplementedMask);
      }
      else
      {
         TDCFlagsClr(FWSynchronouslyRotatingModeIsImplementedMask);
      }
   }
   else
   {
      TDCFlagsClr(FWIsImplementedMask);

      if (p_flashSettings->FWPresent && (p_flashSettings->FWNumberOfFilters == 0))
      {
         FS_ERR("FWNumberOfFilters must be greater than 0 when FWPresent is set.");
      }
   }

   gcRegsData.FWSpeedMax = p_flashSettings->FWSpeedMax;

   // Update NDF
   gcRegsData.NDFilterNumber = p_flashSettings->NDFNumberOfFilters;
   if (p_flashSettings->NDFPresent && (p_flashSettings->NDFNumberOfFilters > 0))
   {
      TDCFlagsSet(NDFilterIsImplementedMask);
   }
   else
   {
      TDCFlagsClr(NDFilterIsImplementedMask);

      if (p_flashSettings->NDFPresent && (p_flashSettings->NDFNumberOfFilters == 0))
      {
         FS_ERR("NDFNumberOfFilters must be greater than 0 when NDFPresent is set.");
      }
   }

   // Update actualization
   if (p_flashSettings->ActualizationEnabled)
   {
      TDCFlagsSet(CalibrationActualizationIsImplementedMask);
   }
   else
   {
      TDCFlagsClr(CalibrationActualizationIsImplementedMask);
   }

   // Update detector parameters
   gFpaDetectorPolarizationVoltage = p_flashSettings->DetectorPolarizationVoltage;
   gFpaDetectorElectricalTapsRef = p_flashSettings->DetectorElectricalTapsRef;
   gFpaDetectorElectricalRefOffset = p_flashSettings->DetectorElectricalRefOffset;

   // Validate ExternalMemoryBufferPresent field
   if (XOR(p_flashSettings->ExternalMemoryBufferPresent, externalMemoryBufferDetected))
   {
      FS_ERR("ExternalMemoryBufferPresent field value (%d) doesn't match external memory buffer detection (%d).",
            p_flashSettings->ExternalMemoryBufferPresent, externalMemoryBufferDetected);
   }

   // Update external fan speed setpoint
   gcRegsData.ExternalFanSpeedSetpoint = p_flashSettings->ExternalFanSpeedSetpoint;

   // Validate device key
   if (builtInTests[BITID_FlashDynamicValuesInitialization].result == BITR_Passed)
   {
      BuiltInTest_Execute(BITID_DeviceKeyValidation);
   }

   // Update camera state if initialization is done
   if (!TDCStatusTst(WaitingForInitMask))
   {
      ICU_init(&gcRegsData, &gICU_ctrl);
      FPA_SendConfigGC(&gFpaIntf, &gcRegsData);
      GC_SetExternalFanSpeed();
   }

   return IRC_SUCCESS;
}

static void FlashSettings_UpdateFixFWSettings(flashSettings_t *p_flashSettings)
{
   if (( p_flashSettings->FWType == FW_FIX ) &&
         (( (p_flashSettings->FileStructureMajorVersion == 1) && (p_flashSettings->FileStructureMinorVersion == 6) ) ||
          ( (p_flashSettings->FileStructureMajorVersion == 1) && (p_flashSettings->FileStructureMinorVersion == 7) && (p_flashSettings->FileStructureSubMinorVersion == 0) )) )
   {
      // Had the wrong PID settings for the Fix Fw, cause probleme with the FW
      p_flashSettings->FWPositionControllerI = flashSettingsDefault.FWPositionControllerI;
      p_flashSettings->FWPositionControllerPD = flashSettingsDefault.FWPositionControllerPD;
      p_flashSettings->FWPositionControllerPOR = flashSettingsDefault.FWPositionControllerPOR;
      p_flashSettings->FWPositionControllerPP = flashSettingsDefault.FWPositionControllerPP;
   }
}
