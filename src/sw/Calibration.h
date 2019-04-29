/**
 * @file Calibration.h
 * Camera calibration module header.
 *
 * This file declares the camera calibration module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef CALIBRATION_H
#define CALIBRATION_H

#include "FileManager.h"
#include "CalibBlockFile.h"
#include "CalibCollectionFile.h"
#include "verbose.h"
#include <stdint.h>
#include "fpa_intf.h"


#ifdef CM_VERBOSE
   #define CM_PRINTF(fmt, ...)   FPGA_PRINTF("CM: " fmt, ##__VA_ARGS__)
#else
   #define CM_PRINTF(fmt, ...)   DUMMY_PRINTF("CM: " fmt, ##__VA_ARGS__)
#endif

#define CM_ERR(fmt, ...)         FPGA_PRINTF("CM: Error: " fmt "\n", ##__VA_ARGS__)
#define CM_INF(fmt, ...)         FPGA_PRINTF("CM: Info: " fmt "\n", ##__VA_ARGS__)
#define CM_DBG(fmt, ...)         CM_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define CM_MAX_FILE_READ_SIZE    512


#define CM_CALIB_BLOCK_PIXEL_DATA_SIZE       (FPA_WIDTH_MAX * FPA_HEIGHT_MAX * sizeof(uint64_t))

#define CM_CALIB_MAXTK_TVSINT_MAX_FITORDER   7
#define CM_CALIB_MAXTK_TVSINT_MAX_SIZE       (2 * (CM_CALIB_MAXTK_TVSINT_MAX_FITORDER + 1))
#define CM_CALIB_MAXTK_INTVST_MAX_FITORDER   7
#define CM_CALIB_MAXTK_INTVST_MAX_SIZE       (2 * (CM_CALIB_MAXTK_INTVST_MAX_FITORDER + 1))

#define CM_CALIB_UPDATE_BLOCK_SIZE           128 /**< maximum number of pixel data to update in one iteration */

/**
 * Calibration manager state.
 */
enum cmStateEnum {
   CMS_INIT = 0,                       /**< Initialize calibration manager state machine */
   CMS_IDLE,                           /**< Calibration manager idle state */
   CMS_LOAD_COLLECTION_FILE,           /**< Load calibration collection file */
   CMS_OPEN_BLOCK_FILE,                /**< Open calibration block file */
   CMS_LOAD_BLOCK_FILE_HEADER,         /**< Load calibration block file header */
   CMS_LOAD_PIXEL_DATA_HEADER,         /**< Load pixel data header */
   CMS_LOAD_PIXEL_DATA,                /**< Load pixel data */
   CMS_UPDATE_PIXEL_DATA,              /**< Apply the delta beta computed from the calibration Actualization process */
   CMS_LOAD_MAXTK_DATA_HEADER,         /**< Load MAXTK data header */
   CMS_LOAD_MAXTK_DATA,                /**< Load MAXTK data */
   CMS_LOAD_LUTNL_DATA_HEADER,         /**< Load LUTNL data header */
   CMS_LOAD_LUTNL_DATA,                /**< Load LUTNL data */
   CMS_LOAD_LUTRQ_DATA_HEADER,         /**< Load LUTRQ data header */
   CMS_LOAD_LUTRQ_DATA,                /**< Load LUTRQ data */
   CMS_FINALIZE_BLOCK_FILE,            /**< Finalize block file data */
   CMS_FINALIZE_COLLECTION_FILE,       /**< Finalize collection file data */
   CMS_ERROR                           /**< Executed when an error occurs while loading calibration data */
};

/**
 * Calibration manager state data type.
 */
typedef enum cmStateEnum cmState_t;

typedef enum {
   CS_REFERENCED = 0,
   CS_INTERPOLATED = 1,
   CS_CONVERTED = 1,
   CS_MODIFIED = 2,
   CS_ACTUALIZED = 3
} cmCalibrationSource_t;

/**
 * Radiometric LUT index enumeration values
 */
enum lutRQIndexEnum {
   LUTRQI_RT = 0,
   LUTRQI_IBR,
   LUTRQI_IBI,
   LUTRQI_MAX_NUM_OF_LUTRQ
};

/**
 * Radiometric LUT information structure.
 */
struct LUTRQInfoStruct {
   uint8_t isValid;                 /**< Indicate whether LUTRQ data is valid */
   float LUT_Xmin;                  /**< Minimum lookup table X value */
   float LUT_Xrange;                /**< Lookup table X value range */
   uint16_t LUT_Size;               /**< Number of lookup table elements */
   int8_t M_Exp;                    /**< M exponent */
   int8_t B_Exp;                    /**< B exponent */
   float Data_Off;                  /**< Data offset */
   int8_t Data_Exp;                 /**< Data exponent */
   radiometricQuantityType_t RadiometricQuantityType; /**< Radiometric quantity type */
   uint8_t M_Nbits;                 /**< M data filed bit width */
   uint8_t B_Nbits;                 /**< B data filed bit width */
   uint8_t M_Signed;                /**< Indicates whether the M data field is signed. */
   uint8_t B_Signed;                /**< Indicates whether the B data field is signed. */
   uint32_t DataOffset;             /**< Lookup table data offset in block file. */
   uint32_t DataLength;             /**< Lookup table data length. */
   uint16_t DataCRC16;              /**< Lookup table data CRC-16. */
};

/**
* Radiometric LUT information data type.
*/
typedef struct LUTRQInfoStruct LUTRQInfo_t;

/**
 * Calibration block information structure.
 */
struct calibBlockInfoStruct {
   uint8_t isValid;                 /**< Indicate whether block data is valid */
   fileRecord_t *file;              /**< Block file record pointer */
   uint32_t POSIXTime;              /**< Block file generation date and time */
   uint32_t ExposureTime;           /**< Exposure time */
   uint32_t AcquisitionFrameRate;   /**< Acquisition rate (in millihertz) */
   uint8_t FWPosition;              /**< Filter wheel position */
   uint8_t NDFPosition;             /**< Neutral density filter position */
   uint8_t FOVPosition;             /**< Motorized FOV lens position */
   int32_t ImageCorrectionFocusPositionRaw;   /**< Motorized focus lens encoder position to use for image correction */
   uint16_t ExternalLensFocalLength;   /**< Focal length of the external lens */
   uint32_t ExternalLensSerialNumber;  /**< Unique Telops 32-bit external lens serial number */
   uint32_t ManualFilterSerialNumber;  /**< Unique Telops 32-bit manual filter serial number */
   uint16_t PixelDynamicRangeMin;   /**< Minimum value of the dynamic range */
   uint16_t PixelDynamicRangeMax;   /**< Maximum value of the dynamic range */
   uint16_t SaturationThreshold;    /**< Threshold at which a pixel is considered to be saturated */
   uint32_t BlockBadPixelCount;     /**< Bad pixel count computed during calibration block generation */
   uint8_t CalibrationSource;       /**< Calibration source */
   float MaximumTotalFlux;          /**< Maximum total flux supported  */
   float NUCMultFactor;             /**< Multiplier Factor for NUC */
   int32_t T0;                      /**< Internal lens temperature during calibration */
   float Nu;                        /**< Thermal compensation exponent */
   int32_t DeviceTemperatureSensor; /**< Device Sensor Temperature during calibration */
   float LowCut;                    /**< Low wavelength at mid-height of the IBR integration start. */
   float HighCut;                   /**< High wavelength at mid-height of the IBR integration start. */
   uint8_t PixelDataPresence;       /**< Indicates the presence of pixel data in calibration block */
   struct {
      float Offset_Off;             /**< Offset offset */
      float Offset_Median;          /**< Offset median */
      int8_t Offset_Exp;            /**< Offset exponent */
      uint8_t Offset_Nbits;         /**< Offset data filed bit width */
      uint8_t Offset_Signed;        /**< Indicates whether the offset data field is signed. */
      float Range_Off;              /**< Range offset */
      float Range_Median;           /**< Range median */
      int8_t Range_Exp;             /**< Range exponent */
      uint8_t Range_Nbits;          /**< Range data filed bit width */
      uint8_t Range_Signed;         /**< Indicates whether the range data field is signed. */
      float Kappa_Off;              /**< Kappa offset */
      float Kappa_Median;           /**< Kappa median */
      int8_t Kappa_Exp;             /**< Kappa exponent */
      uint8_t Kappa_Nbits;          /**< Kappa data filed bit width */
      uint8_t Kappa_Signed;         /**< Indicates whether the kappa data field is signed. */
      float Beta0_Off;              /**< Beta0 offset */
      float Beta0_Median;           /**< Beta0 median */
      int8_t Beta0_Exp;             /**< Beta0 exponent */
      uint8_t Beta0_Nbits;          /**< Beta0 data filed bit width */
      uint8_t Beta0_Signed;         /**< Indicates whether the beta0 data field is signed. */
      float Alpha_Off;              /**< Alpha offset */
      float Alpha_Median;           /**< Alpha median */
      int8_t Alpha_Exp;             /**< Alpha exponent */
      uint8_t Alpha_Nbits;          /**< Alpha data filed bit width */
      uint8_t Alpha_Signed;         /**< Indicates whether the alpha data field is signed. */
      uint8_t LUTNLIndex_Nbits;     /**< LUTNLIndex data filed bit width */
      uint8_t LUTNLIndex_Signed;    /**< Indicates whether the LUTNL index data field is signed. */
      uint8_t BadPixel_Nbits;       /**< Alpha data filed bit width */
      uint8_t BadPixel_Signed;      /**< Indicates whether the bad pixel data field is signed. */
   } pixelData;
   uint8_t MaxTKDataPresence;       /**< Indicates the presence of MaxTK data in calibration block */
   struct {
      float TCalMin;                /**< Minimum valid Tcal */
      float TCalMax;                /**< Maximum valid Tcal */
      float TCalMinExpTimeMin;      /**< Minimum valid exposure time for TcalMin curve */
      float TCalMinExpTimeMax;      /**< Maximum valid exposure time for TcalMin curve */
      float TCalMaxExpTimeMin;      /**< Minimum valid exposure time for TcalMax curve */
      float TCalMaxExpTimeMax;      /**< Maximum valid exposure time for TcalMax curve */
      uint8_t TvsINT_FitOrder;      /**< Fit Order for T vs Int curve */
      uint8_t INTvsT_FitOrder;      /**< Fit Order for INT vs T curve */
      float coeffs[CM_CALIB_MAXTK_TVSINT_MAX_SIZE + CM_CALIB_MAXTK_INTVST_MAX_SIZE]; /**< Curve coefficients */
   } maxTKData;
   uint8_t LUTNLDataPresence;       /**< Indicates the presence of LUTNL data in calibration block */
   struct {
      float LUT_Xmin;               /**< Minimum lookup table X value */
      float LUT_Xrange;             /**< Lookup table X value range */
      uint16_t LUT_Size;            /**< Number of lookup table elements */
      int8_t M_Exp;                 /**< M exponent */
      int8_t B_Exp;                 /**< B exponent */
      uint8_t M_Nbits;              /**< M data filed bit width */
      uint8_t B_Nbits;              /**< B data filed bit width */
      uint8_t M_Signed;             /**< Indicates whether the M data field is signed. */
      uint8_t B_Signed;             /**< Indicates whether the B data field is signed. */
      uint8_t NumberOfLUTNL;        /**< Number of non-linearity correction lookup tables in LUTNL data */
   } lutNLData;
   uint8_t LUTRQDataPresence;       /**< Indicates the presence of LUTRQ data in calibration block */
   uint8_t NumberOfLUTRQ;           /**< Number of radiometric quantity lookup tables in calibration block */
   LUTRQInfo_t lutRQData[LUTRQI_MAX_NUM_OF_LUTRQ];
};

/**
 * Calibration block information data type.
 */
typedef struct calibBlockInfoStruct calibBlockInfo_t;

/**
 * Calibration collection information structure.
 */
struct calibCollectionInfoStruct {
   uint8_t isValid;                    /**< Indicate whether collection data is valid */
   fileRecord_t *file;                 /**< Collection file record pointer */
   uint32_t POSIXTime;                 /**< Collection file generation date and time. */
   CalibrationCollectionType_t CollectionType; /**< Collection type */
   calibrationType_t CalibrationType;  /**< Calibration type */
   uint8_t SensorID;                   /**< Sensor ID */
   uint8_t IntegrationMode;            /**< Integration mode */
   uint8_t SensorWellDepth;            /**< Sensor well depth */
   uint8_t PixelDataResolution;        /**< Effective size in bits of a pixel of the image */
   uint16_t Width;                     /**< Width of the image provided by the device in pixels */
   uint16_t Height;                    /**< Height of the image provided by the device in pixels */
   uint16_t OffsetX;                   /**< Horizontal offset from the origin to the region of interest in pixels */
   uint16_t OffsetY;                   /**< Vertical offset from the origin to the region of interest in pixels */
   uint8_t ReverseX;                   /**< Indicates whether the image is horizontally flipped */
   uint8_t ReverseY;                   /**< Indicates whether the image is vertically flipped */
   uint8_t FWPosition;                 /**< Filter wheel position */
   uint8_t NDFPosition;                /**< Neutral density filter position */
   uint8_t FOVPosition;                /**< Motorized FOV lens position */
   uint32_t ExternalLensSerialNumber;  /**< Unique Telops 32-bit external lens serial number */
   uint32_t ManualFilterSerialNumber;  /**< Unique Telops 32-bit manual filter serial number */
   uint32_t ReferencePOSIXTime;        /**< Camera reference file generation date and time */
   int32_t DeviceTemperatureSensor;    /**< Device Sensor Temperature during calibration in cC (averaged from block data) */
   float FluxRatio01;                  /**< Ratio de flux entre NDF0 et NDF1 */
   float FluxRatio12;                  /**< Ratio de flux entre NDF1 et NDF2 */
   uint8_t NumberOfBlocks;             /**< Number of calibration blocks in collection file */
   uint32_t BlockPOSIXTime[CALIB_MAX_NUM_OF_BLOCKS]; /**< List of collection calibration blocks POSIX time */
};

/**
 * Calibration collection information data type.
 */
typedef struct calibCollectionInfoStruct calibCollectionInfo_t;

/**
 * Calibration information structure.
 */
struct calibrationInfoStruct {
   uint8_t isValid;
   calibCollectionInfo_t collection;
   calibBlockInfo_t blocks[CALIB_MAX_NUM_OF_BLOCKS];
};

/**
 * Calibration information data type.
 */
typedef struct calibrationInfoStruct calibrationInfo_t;


/**
 * Calibration block information global variable declaration
 */
extern calibrationInfo_t calibrationInfo;


void Calibration_SM();
IRC_Status_t Calibration_LoadCalibrationFile(fileRecord_t *file);
IRC_Status_t Calibration_LoadCalibrationFilePOSIXTime(uint32_t posixTime);
IRC_Status_t Calibration_LoadCollectionFile(fileRecord_t *file, calibCollectionInfo_t *collectionInfo);
void Calibration_Reset();
IRC_Status_t Calibration_LoadLUTRQ(uint8_t initLUTRQ);
uint8_t CM_FileUsedByActualCalibration(fileRecord_t *file);

bool Calibration_GetActiveBlockIdx(const calibrationInfo_t* calibInfo, uint8_t* blockIdx);

#endif // CALIBRATION_H
