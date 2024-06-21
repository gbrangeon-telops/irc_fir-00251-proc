/**
 * @file CalibBlockFile_v1.h
 * Camera calibration block file structure v1 declaration.
 *
 * This file declares the camera calibration block file structure v1.
 *
 * Auto-generated calibration block file library.
 * Generated from the calibration block file structure definition XLS file version 1.1.0
 * using generateIRCamFileCLib.m Matlab script.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef CALIBBLOCKFILE_V1_H
#define CALIBBLOCKFILE_V1_H

#include <stdint.h>

#define CALIBBLOCK_FILEMAJORVERSION_V1      1
#define CALIBBLOCK_FILEMINORVERSION_V1      1
#define CALIBBLOCK_FILESUBMINORVERSION_V1   0

#define CALIBBLOCK_BLOCKFILEHEADER_SIZE_V1   512

#define CALIBBLOCK_PIXELDATAHEADER_SIZE_V1   256
#define CALIBBLOCK_PIXELDATA_SIZE_V1   8
#define CALIBBLOCK_PIXELDATA_OFFSET_MASK_V1    (uint64_t)(0x0000000000000FFF)
#define CALIBBLOCK_PIXELDATA_OFFSET_SHIFT_V1   0
#define CALIBBLOCK_PIXELDATA_RANGE_MASK_V1    (uint64_t)(0x0000000000FFF000)
#define CALIBBLOCK_PIXELDATA_RANGE_SHIFT_V1   12
#define CALIBBLOCK_PIXELDATA_LUTNLINDEX_MASK_V1    (uint64_t)(0x000000003F000000)
#define CALIBBLOCK_PIXELDATA_LUTNLINDEX_SHIFT_V1   24
#define CALIBBLOCK_PIXELDATA_KAPPA_MASK_V1    (uint64_t)(0x000000FFC0000000)
#define CALIBBLOCK_PIXELDATA_KAPPA_SHIFT_V1   30
#define CALIBBLOCK_PIXELDATA_BETA0_MASK_V1    (uint64_t)(0x0007FF0000000000)
#define CALIBBLOCK_PIXELDATA_BETA0_SHIFT_V1   40
#define CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS_V1 (1 << 10)
#define CALIBBLOCK_PIXELDATA_ALPHA_MASK_V1    (uint64_t)(0x7FF8000000000000)
#define CALIBBLOCK_PIXELDATA_ALPHA_SHIFT_V1   51
#define CALIBBLOCK_PIXELDATA_BADPIXEL_MASK_V1    (uint64_t)(0x8000000000000000)
#define CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT_V1   63

#define CALIBBLOCK_MAXTKDATAHEADER_SIZE_V1   256
#define CALIBBLOCK_MAXTKDATA_SIZE_V1   4

#define CALIBBLOCK_LUTNLDATAHEADER_SIZE_V1   256
#define CALIBBLOCK_LUTNLDATA_SIZE_V1   4
#define CALIBBLOCK_LUTNLDATA_M_MASK_V1    (uint32_t)(0x0000FFFF)
#define CALIBBLOCK_LUTNLDATA_M_SHIFT_V1   0
#define CALIBBLOCK_LUTNLDATA_B_MASK_V1    (uint32_t)(0xFFFF0000)
#define CALIBBLOCK_LUTNLDATA_B_SHIFT_V1   16

#define CALIBBLOCK_LUTRQDATAHEADER_SIZE_V1   256
#define CALIBBLOCK_LUTRQDATA_SIZE_V1   4
#define CALIBBLOCK_LUTRQDATA_M_MASK_V1    (uint32_t)(0x0000FFFF)
#define CALIBBLOCK_LUTRQDATA_M_SHIFT_V1   0
#define CALIBBLOCK_LUTRQDATA_B_MASK_V1    (uint32_t)(0xFFFF0000)
#define CALIBBLOCK_LUTRQDATA_B_SHIFT_V1   16

/**
 * BlockFileHeader data structure.
 */
struct CalibBlock_BlockFileHeader_v1Struct {
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
typedef struct CalibBlock_BlockFileHeader_v1Struct CalibBlock_BlockFileHeader_v1_t;

/**
 * PixelDataHeader data structure.
 */
struct CalibBlock_PixelDataHeader_v1Struct {
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
typedef struct CalibBlock_PixelDataHeader_v1Struct CalibBlock_PixelDataHeader_v1_t;

/**
 * PixelData data structure.
 */
struct CalibBlock_PixelData_v1Struct {
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
typedef struct CalibBlock_PixelData_v1Struct CalibBlock_PixelData_v1_t;

/**
 * MaxTKDataHeader data structure.
 */
struct CalibBlock_MaxTKDataHeader_v1Struct {
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
typedef struct CalibBlock_MaxTKDataHeader_v1Struct CalibBlock_MaxTKDataHeader_v1_t;

/**
 * LUTNLDataHeader data structure.
 */
struct CalibBlock_LUTNLDataHeader_v1Struct {
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
typedef struct CalibBlock_LUTNLDataHeader_v1Struct CalibBlock_LUTNLDataHeader_v1_t;

/**
 * LUTNLData data structure.
 */
struct CalibBlock_LUTNLData_v1Struct {
   uint16_t m;   /**< m */
   uint16_t b;   /**< b */
};

/**
 * LUTNLData data type.
 */
typedef struct CalibBlock_LUTNLData_v1Struct CalibBlock_LUTNLData_v1_t;

/**
 * LUTRQDataHeader data structure.
 */
struct CalibBlock_LUTRQDataHeader_v1Struct {
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
typedef struct CalibBlock_LUTRQDataHeader_v1Struct CalibBlock_LUTRQDataHeader_v1_t;

/**
 * LUTRQData data structure.
 */
struct CalibBlock_LUTRQData_v1Struct {
   uint16_t m;   /**< m */
   uint16_t b;   /**< b */
};

/**
 * LUTRQData data type.
 */
typedef struct CalibBlock_LUTRQData_v1Struct CalibBlock_LUTRQData_v1_t;

uint32_t CalibBlock_ParseBlockFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_BlockFileHeader_v1_t *hdr);
uint32_t CalibBlock_WriteBlockFileHeader_v1(CalibBlock_BlockFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParsePixelDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelDataHeader_v1_t *hdr);
uint32_t CalibBlock_WritePixelDataHeader_v1(CalibBlock_PixelDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParsePixelData_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelData_v1_t *data);
uint32_t CalibBlock_WritePixelData_v1(CalibBlock_PixelData_v1_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseMaxTKDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_MaxTKDataHeader_v1_t *hdr);
uint32_t CalibBlock_WriteMaxTKDataHeader_v1(CalibBlock_MaxTKDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseLUTNLDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLDataHeader_v1_t *hdr);
uint32_t CalibBlock_WriteLUTNLDataHeader_v1(CalibBlock_LUTNLDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseLUTNLData_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLData_v1_t *data);
uint32_t CalibBlock_WriteLUTNLData_v1(CalibBlock_LUTNLData_v1_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseLUTRQDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQDataHeader_v1_t *hdr);
uint32_t CalibBlock_WriteLUTRQDataHeader_v1(CalibBlock_LUTRQDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseLUTRQData_v1(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQData_v1_t *data);
uint32_t CalibBlock_WriteLUTRQData_v1(CalibBlock_LUTRQData_v1_t *data, uint8_t *buffer, uint32_t buflen);

#endif // CALIBBLOCKFILE_V1_H
