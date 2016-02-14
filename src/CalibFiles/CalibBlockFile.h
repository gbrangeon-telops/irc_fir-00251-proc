/**
 * @file CalibBlockFile.h
 * Camera calibration block file structure declaration.
 *
 * This file declares the camera calibration block file structure.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef CALIBBLOCKFILE_H
#define CALIBBLOCKFILE_H

#include "IRC_Status.h"
#include "fpa_intf.h"
#include <stdint.h>

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

#define CALIB_BLOCKFILE_EXP_TIME_TO_US ((float)1e-2)

/* AUTO-CODE BEGIN */
// Auto-generated Calibration Block File library.
// Generated from the calibration block file structure definition XLS file version 1.1.0
// using generateIRCamBlockCalibrationFileCLib.m Matlab script.

#define CALIB_BLOCKFILEMAJORVERSION      1
#define CALIB_BLOCKFILEMINORVERSION      1
#define CALIB_BLOCKFILESUBMINORVERSION   0

#define CALIB_BLOCKFILEHEADER_SIZE   512
#define CALIB_PIXELDATAHEADER_SIZE   256
#define CALIB_PIXELDATA_SIZE   8
#define CALIB_PIXELDATA_OFFSET_MASK    (uint64_t)(0x0000000000000FFF)
#define CALIB_PIXELDATA_OFFSET_SHIFT   0
#define CALIB_PIXELDATA_RANGE_MASK    (uint64_t)(0x0000000000FFF000)
#define CALIB_PIXELDATA_RANGE_SHIFT   12
#define CALIB_PIXELDATA_LUTNLINDEX_MASK    (uint64_t)(0x000000003F000000)
#define CALIB_PIXELDATA_LUTNLINDEX_SHIFT   24
#define CALIB_PIXELDATA_KAPPA_MASK    (uint64_t)(0x000000FFC0000000)
#define CALIB_PIXELDATA_KAPPA_SHIFT   30
#define CALIB_PIXELDATA_BETA0_MASK    (uint64_t)(0x0007FF0000000000)
#define CALIB_PIXELDATA_BETA0_SHIFT   40
#define CALIB_PIXELDATA_BETA0_SIGNPOS (1 << 10)
#define CALIB_PIXELDATA_ALPHA_MASK    (uint64_t)(0x7FF8000000000000)
#define CALIB_PIXELDATA_ALPHA_SHIFT   51
#define CALIB_PIXELDATA_BADPIXEL_MASK    (uint64_t)(0x8000000000000000)
#define CALIB_PIXELDATA_BADPIXEL_SHIFT   63
#define CALIB_MAXTKDATAHEADER_SIZE   256
#define CALIB_LUTNLDATAHEADER_SIZE   256
#define CALIB_LUTNLDATA_SIZE   4
#define CALIB_LUTNLDATA_M_MASK    (uint32_t)(0x0000FFFF)
#define CALIB_LUTNLDATA_M_SHIFT   0
#define CALIB_LUTNLDATA_B_MASK    (uint32_t)(0xFFFF0000)
#define CALIB_LUTNLDATA_B_SHIFT   16
#define CALIB_LUTRQDATAHEADER_SIZE   256
#define CALIB_LUTRQDATA_SIZE   4
#define CALIB_LUTRQDATA_M_MASK    (uint32_t)(0x0000FFFF)
#define CALIB_LUTRQDATA_M_SHIFT   0
#define CALIB_LUTRQDATA_B_MASK    (uint32_t)(0xFFFF0000)
#define CALIB_LUTRQDATA_B_SHIFT   16

/**
 * BlockFileHeader data structure.
 */
struct BlockFileHeaderStruct {
   char FileSignature[5];   /**< Calibration block file signature */
   uint8_t FileStructureMajorVersion;   /**< Calibration file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Calibration file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Calibration file structure SubMinor Version */
   uint32_t BlockFileHeaderLength;   /**< Block file header length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t POSIXTime;   /**< File generation date and time */
   char FileDescription[65];   /**< Calibration block file description */
   uint8_t DeviceDataFlowMajorVersion;   /**< Major version of the calibration data flow of the camera */
   uint8_t DeviceDataFlowMinorVersion;   /**< Minor version of the calibration data flow of the camera */
   uint8_t SensorID;   /**< Sensor ID. */
   uint8_t CalibrationSource;   /**< Indicates how the calibration block has been generated */
   uint8_t CalibrationType;   /**< Calibration type */
   uint8_t IntegrationMode;   /**< Integration mode */
   uint8_t SensorWellDepth;   /**< Sensor well depth */
   uint8_t PixelDataResolution;   /**< Effective size in bits of a pixel of the image */
   uint16_t Width;   /**< Width of the image provided by the device in pixels */
   uint16_t Height;   /**< Height of the image provided by the device in pixels */
   uint16_t OffsetX;   /**< Horizontal offset from the origin to the region of interest in pixels */
   uint16_t OffsetY;   /**< Vertical offset from the origin to the region of interest in pixels */
   uint8_t ReverseX;   /**< Indicates whether the image is horizontally flipped. */
   uint8_t ReverseY;   /**< Indicates whether the image is vertically flipped. */
   uint32_t ExternalLensSerialNumber;   /**< Unique Telops 32-bit external lens serial number */
   char ExternalLensName[65];   /**< External Lens Name */
   uint32_t ManualFilterSerialNumber;   /**< Unique Telops 32-bit manual filter serial number */
   char ManualFilterName[65];   /**< Manual filter name */
   uint32_t ExposureTime;   /**< Exposure time */
   uint32_t AcquisitionFrameRate;   /**< Acquisition rate (in millihertz) */
   uint8_t FWPosition;   /**< Filter wheel position */
   uint8_t NDFPosition;   /**< Neutral density filter position */
   uint16_t SensorWidth;   /**< Effective width of the sensor in pixels */
   uint16_t SensorHeight;   /**< Effective Height of the sensor in pixels */
   uint16_t PixelDynamicRangeMin;   /**< Minimum value of the dynamic range */
   uint16_t PixelDynamicRangeMax;   /**< Maximum value of the dynamic range */
   uint16_t SaturationThreshold;   /**< Threshold at which a pixel is considered to be saturated */
   uint32_t BlockBadPixelCount;   /**< Bad pixel count computed during calibration block generation */
   float MaximumTotalFlux;   /**< Maximum total flux supported  */
   float NUCMultFactor;   /**< Multiplier Factor for NUC */
   int32_t T0;   /**< Internal lens temperature during calibration */
   float Nu;   /**< Thermal compensation exponent */
   int32_t DeviceTemperatureSensor;   /**< Device Sensor Temperature during calibration */
   uint32_t SpectralResponsePOSIXTime;   /**< Camera spectral response file generation date and time */
   uint32_t ReferencePOSIXTime;   /**< Camera reference file generation date and time */
   uint8_t PixelDataPresence;   /**< Indicates the presence of pixel data in calibration block */
   uint8_t MaxTKDataPresence;   /**< Indicates the presence of MaxTK data in calibration block */
   uint8_t LUTNLDataPresence;   /**< Indicates the presence of LUTNL data in calibration block */
   uint8_t LUTRQDataPresence;   /**< Indicates the presence of LUTRQ data in calibration block */
   uint8_t NumberOfLUTRQ;   /**< Number of radiometric quantity lookup tables in calibration block */
   uint16_t BlockFileHeaderCRC16;   /**< Block file header CRC-16 */
};

/**
 * BlockFileHeader data type.
 */
typedef struct BlockFileHeaderStruct BlockFileHeader_t;

/**
 * PixelDataHeader data structure.
 */
struct PixelDataHeaderStruct {
   uint32_t PixelDataHeaderLength;   /**< Pixel data header length */
   float Offset_Off;   /**< Offset offset */
   float Offset_Median;   /**< Offset median */
   int8_t Offset_Exp;   /**< Offset exponent */
   uint8_t Offset_Nbits;   /**< Offset data filed bit width */
   uint8_t Offset_Signed;   /**< Indicates whether the offset data field is signed. */
   float Range_Off;   /**< Range offset */
   float Range_Median;   /**< Range median */
   int8_t Range_Exp;   /**< Range exponent */
   uint8_t Range_Nbits;   /**< Range data filed bit width */
   uint8_t Range_Signed;   /**< Indicates whether the range data field is signed. */
   float Kappa_Off;   /**< Kappa offset */
   float Kappa_Median;   /**< Kappa median */
   int8_t Kappa_Exp;   /**< Kappa exponent */
   uint8_t Kappa_Nbits;   /**< Kappa data filed bit width */
   uint8_t Kappa_Signed;   /**< Indicates whether the kappa data field is signed. */
   float Beta0_Off;   /**< Beta0 offset */
   float Beta0_Median;   /**< Beta0 median */
   int8_t Beta0_Exp;   /**< Beta0 exponent */
   uint8_t Beta0_Nbits;   /**< Beta0 data filed bit width */
   uint8_t Beta0_Signed;   /**< Indicates whether the beta0 data field is signed. */
   float Alpha_Off;   /**< Alpha offset */
   float Alpha_Median;   /**< Alpha median */
   int8_t Alpha_Exp;   /**< Alpha exponent */
   uint8_t Alpha_Nbits;   /**< Alpha data filed bit width */
   uint8_t Alpha_Signed;   /**< Indicates whether the alpha data field is signed. */
   uint8_t LUTNLIndex_Nbits;   /**< LUTNLIndex data filed bit width */
   uint8_t LUTNLIndex_Signed;   /**< Indicates whether the LUTNL index data field is signed. */
   uint8_t BadPixel_Nbits;   /**< Alpha data filed bit width */
   uint8_t BadPixel_Signed;   /**< Indicates whether the bad pixel data field is signed. */
   uint32_t PixelDataLength;   /**< Pixel data length */
   uint16_t PixelDataCRC16;   /**< Pixel data CRC-16 */
   uint16_t PixelDataHeaderCRC16;   /**< Pixel data header CRC-16 */
};

/**
 * PixelDataHeader data type.
 */
typedef struct PixelDataHeaderStruct PixelDataHeader_t;

/**
 * PixelData data structure.
 */
struct PixelDataStruct {
   uint16_t Offset;   /**< Offset */
   uint16_t Range;   /**< Range */
   uint8_t LUTNLIndex;   /**< LUTNL index */
   uint16_t Kappa;   /**< Kappa */
   int16_t Beta0;   /**< Beta0 */
   uint16_t Alpha;   /**< Alpha */
   uint8_t BadPixel;   /**< Indicates whether the pixel is considered as bad (0) or good (1) */
};

/**
 * PixelData data type.
 */
typedef struct PixelDataStruct PixelData_t;

/**
 * MaxTKDataHeader data structure.
 */
struct MaxTKDataHeaderStruct {
   uint32_t MaxTKDataHeaderLength;   /**< MaxTK data header length */
   float TCalMin;   /**< Minimum valid Tcal */
   float TCalMax;   /**< Maximum valid Tcal */
   float TCalMinExpTimeMin;   /**< Minimum valid exposure time for TcalMin curve */
   float TCalMinExpTimeMax;   /**< Maximum valid exposure time for TcalMin curve */
   float TCalMaxExpTimeMin;   /**< Minimum valid exposure time for TcalMax curve */
   float TCalMaxExpTimeMax;   /**< Maximum valid exposure time for TcalMax curve */
   uint8_t TvsINT_FitOrder;   /**< Fit Order for T vs Int curve */
   uint8_t INTvsT_FitOrder;   /**< Fit Order for INT vs T curve */
   uint32_t MaxTKDataLength;   /**< MaxTK data length */
   uint16_t MaxTKDataCRC16;   /**< MaxTK data CRC-16 */
   uint16_t MaxTKDataHeaderCRC16;   /**< MaxTK data header CRC-16 */
};

/**
 * MaxTKDataHeader data type.
 */
typedef struct MaxTKDataHeaderStruct MaxTKDataHeader_t;

/**
 * LUTNLDataHeader data structure.
 */
struct LUTNLDataHeaderStruct {
   uint32_t LUTNLDataHeaderLength;   /**< Non-linearity correction lookup table data header length */
   float LUT_Xmin;   /**< Minimum lookup table X value */
   float LUT_Xrange;   /**< Lookup table X value range */
   uint16_t LUT_Size;   /**< Number of lookup table elements */
   int8_t M_Exp;   /**< M exponent */
   int8_t B_Exp;   /**< B exponent */
   uint8_t M_Nbits;   /**< M data filed bit width */
   uint8_t B_Nbits;   /**< B data filed bit width */
   uint8_t M_Signed;   /**< Indicates whether the M data field is signed. */
   uint8_t B_Signed;   /**< Indicates whether the B data field is signed. */
   uint8_t NumberOfLUTNL;   /**< Number of non-linearity correction lookup tables in LUTNL data */
   uint32_t LUTNLDataLength;   /**< Non-linearity correction lookup table data length */
   uint16_t LUTNLDataCRC16;   /**< Non-linearity correction lookup table data CRC-16 */
   uint16_t LUTNLDataHeaderCRC16;   /**< Non-linearity correction lookup table data header CRC-16 */
};

/**
 * LUTNLDataHeader data type.
 */
typedef struct LUTNLDataHeaderStruct LUTNLDataHeader_t;

/**
 * LUTNLData data structure.
 */
struct LUTNLDataStruct {
   uint16_t m;   /**< m */
   uint16_t b;   /**< b */
};

/**
 * LUTNLData data type.
 */
typedef struct LUTNLDataStruct LUTNLData_t;

/**
 * LUTRQDataHeader data structure.
 */
struct LUTRQDataHeaderStruct {
   uint32_t LUTRQDataHeaderLength;   /**< Radiometric quantity lookup table data header length */
   float LUT_Xmin;   /**< Minimum lookup table X value */
   float LUT_Xrange;   /**< Lookup table X value range */
   uint16_t LUT_Size;   /**< Number of lookup table elements */
   int8_t M_Exp;   /**< M exponent */
   int8_t B_Exp;   /**< B exponent */
   float Data_Off;   /**< Data offset */
   int8_t Data_Exp;   /**< Data exponent */
   uint8_t RadiometricQuantityType;   /**< Radiometric quantity type */
   uint8_t M_Nbits;   /**< M data filed bit width */
   uint8_t B_Nbits;   /**< B data filed bit width */
   uint8_t M_Signed;   /**< Indicates whether the M data field is signed. */
   uint8_t B_Signed;   /**< Indicates whether the B data field is signed. */
   uint32_t LUTRQDataLength;   /**< Radiometric quantity lookup table data length */
   uint16_t LUTRQDataCRC16;   /**< Radiometric quantity lookup table data CRC-16 */
   uint16_t LUTRQDataHeaderCRC16;   /**< Radiometric quantity lookup table data header CRC-16 */
};

/**
 * LUTRQDataHeader data type.
 */
typedef struct LUTRQDataHeaderStruct LUTRQDataHeader_t;

/**
 * LUTRQData data structure.
 */
struct LUTRQDataStruct {
   uint16_t m;   /**< m */
   uint16_t b;   /**< b */
};

/**
 * LUTRQData data type.
 */
typedef struct LUTRQDataStruct LUTRQData_t;

uint32_t ParseCalibBlockFileHeader(uint8_t *buffer, uint32_t buflen, BlockFileHeader_t *hdr);
uint32_t WriteCalibBlockFileHeader(BlockFileHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibPixelDataHeader(uint8_t *buffer, uint32_t buflen, PixelDataHeader_t *hdr);
uint32_t WriteCalibPixelDataHeader(PixelDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibPixelData(uint8_t *buffer, uint32_t buflen, PixelData_t *data);
uint32_t WriteCalibPixelData(PixelData_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibMaxTKDataHeader(uint8_t *buffer, uint32_t buflen, MaxTKDataHeader_t *hdr);
uint32_t WriteCalibMaxTKDataHeader(MaxTKDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibLUTNLDataHeader(uint8_t *buffer, uint32_t buflen, LUTNLDataHeader_t *hdr);
uint32_t WriteCalibLUTNLDataHeader(LUTNLDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibLUTNLData(uint8_t *buffer, uint32_t buflen, LUTNLData_t *data);
uint32_t WriteCalibLUTNLData(LUTNLData_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibLUTRQDataHeader(uint8_t *buffer, uint32_t buflen, LUTRQDataHeader_t *hdr);
uint32_t WriteCalibLUTRQDataHeader(LUTRQDataHeader_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t ParseCalibLUTRQData(uint8_t *buffer, uint32_t buflen, LUTRQData_t *data);
uint32_t WriteCalibLUTRQData(LUTRQData_t *data, uint8_t *buffer, uint32_t buflen);

/* AUTO-CODE END */

#endif // CALIBBLOCKFILE_H
