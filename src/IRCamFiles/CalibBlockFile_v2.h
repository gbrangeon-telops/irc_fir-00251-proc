/**
 * @file CalibBlockFile_v2.h
 * Camera calibration block file structure v2 declaration.
 *
 * This file declares the camera calibration block file structure v2.
 *
 * Auto-generated calibration block file library.
 * Generated from the calibration block file structure definition XLS file version 2.6.0
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

#ifndef CALIBBLOCKFILE_V2_H
#define CALIBBLOCKFILE_V2_H

#include <stdint.h>

#define CALIBBLOCK_FILEMAJORVERSION_V2      2
#define CALIBBLOCK_FILEMINORVERSION_V2      6
#define CALIBBLOCK_FILESUBMINORVERSION_V2   0

#define CALIBBLOCK_BLOCKFILEHEADER_SIZE_V2   512

#define CALIBBLOCK_PIXELDATAHEADER_SIZE_V2   256
#define CALIBBLOCK_PIXELDATA_SIZE_V2   8
#define CALIBBLOCK_PIXELDATA_OFFSET_MASK_V2    (uint64_t)(0x0000000000000FFF)
#define CALIBBLOCK_PIXELDATA_OFFSET_SHIFT_V2   0
#define CALIBBLOCK_PIXELDATA_RANGE_MASK_V2    (uint64_t)(0x0000000000FFF000)
#define CALIBBLOCK_PIXELDATA_RANGE_SHIFT_V2   12
#define CALIBBLOCK_PIXELDATA_LUTNLINDEX_MASK_V2    (uint64_t)(0x000000003F000000)
#define CALIBBLOCK_PIXELDATA_LUTNLINDEX_SHIFT_V2   24
#define CALIBBLOCK_PIXELDATA_KAPPA_MASK_V2    (uint64_t)(0x000000FFC0000000)
#define CALIBBLOCK_PIXELDATA_KAPPA_SHIFT_V2   30
#define CALIBBLOCK_PIXELDATA_BETA0_MASK_V2    (uint64_t)(0x0007FF0000000000)
#define CALIBBLOCK_PIXELDATA_BETA0_SHIFT_V2   40
#define CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS_V2 (1 << 10)
#define CALIBBLOCK_PIXELDATA_ALPHA_MASK_V2    (uint64_t)(0x7FF8000000000000)
#define CALIBBLOCK_PIXELDATA_ALPHA_SHIFT_V2   51
#define CALIBBLOCK_PIXELDATA_BADPIXEL_MASK_V2    (uint64_t)(0x8000000000000000)
#define CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT_V2   63

#define CALIBBLOCK_MAXTKDATAHEADER_SIZE_V2   256
#define CALIBBLOCK_MAXTKDATA_SIZE_V2   4
#define CALIBBLOCK_MAXTKDATA_MAXTK_DATA_MASK_V2    (uint32_t)(0xFFFFFFFF)
#define CALIBBLOCK_MAXTKDATA_MAXTK_DATA_SHIFT_V2   0
#define CALIBBLOCK_MAXTKDATA_MAXTK_DATA_SIGNPOS_V2 (1 << 31)

#define CALIBBLOCK_LUTNLDATAHEADER_SIZE_V2   256
#define CALIBBLOCK_LUTNLDATA_SIZE_V2   4
#define CALIBBLOCK_LUTNLDATA_M_MASK_V2    (uint32_t)(0x0000FFFF)
#define CALIBBLOCK_LUTNLDATA_M_SHIFT_V2   0
#define CALIBBLOCK_LUTNLDATA_B_MASK_V2    (uint32_t)(0xFFFF0000)
#define CALIBBLOCK_LUTNLDATA_B_SHIFT_V2   16

#define CALIBBLOCK_LUTRQDATAHEADER_SIZE_V2   256
#define CALIBBLOCK_LUTRQDATA_SIZE_V2   4
#define CALIBBLOCK_LUTRQDATA_M_MASK_V2    (uint32_t)(0x0000FFFF)
#define CALIBBLOCK_LUTRQDATA_M_SHIFT_V2   0
#define CALIBBLOCK_LUTRQDATA_B_MASK_V2    (uint32_t)(0xFFFF0000)
#define CALIBBLOCK_LUTRQDATA_B_SHIFT_V2   16

#define CALIBBLOCK_KPIXDATAHEADER_SIZE_V2   256
#define CALIBBLOCK_KPIXDATA_SIZE_V2   2
#define CALIBBLOCK_KPIXDATA_KPIX_DATA_MASK_V2    (uint16_t)(0xFFFF)
#define CALIBBLOCK_KPIXDATA_KPIX_DATA_SHIFT_V2   0
#define CALIBBLOCK_KPIXDATA_KPIX_DATA_SIGNPOS_V2 (1 << 15)

/**
 * BlockFileHeader data structure.
 */
struct CalibBlock_BlockFileHeader_v2Struct {
   char FileSignature[5];   /**< File signature */
   uint8_t FileStructureMajorVersion;   /**< File structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< File structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< File structure SubMinor Version */
   uint32_t FileHeaderLength;   /**< File header length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t POSIXTime;   /**< File generation date and time */
   char FileDescription[65];   /**< File description */
   uint8_t DeviceDataFlowMajorVersion;   /**< Major version of the calibration data flow of the camera */
   uint8_t DeviceDataFlowMinorVersion;   /**< Minor version of the calibration data flow of the camera */
   uint8_t SensorID;   /**< Sensor ID */
   uint8_t CalibrationSource;   /**< Indicates how the calibration block has been generated */
   uint8_t CalibrationType;   /**< Calibration type */
   uint8_t IntegrationMode;   /**< Integration mode */
   uint8_t SensorWellDepth;   /**< Sensor well depth */
   uint8_t PixelDataResolution;   /**< Effective size in bits of a pixel of the image */
   uint16_t Width;   /**< Width of the image provided by the device in pixels */
   uint16_t Height;   /**< Height of the image provided by the device in pixels */
   uint16_t OffsetX;   /**< Horizontal offset from the origin to the region of interest in pixels */
   uint16_t OffsetY;   /**< Vertical offset from the origin to the region of interest in pixels */
   uint8_t ReverseX;   /**< Indicates whether the image is horizontally flipped */
   uint8_t ReverseY;   /**< Indicates whether the image is vertically flipped */
   uint16_t ExternalLensFocalLength;   /**< Focal length of the external lens */
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
   float MaximumTotalFlux;   /**< Maximum total flux supported considering sensor width and height (MaxFluxCurrentSaturation x SensorWidth x SensorHeight) */
   float NUCMultFactor;   /**< Multiplier Factor for NUC */
   int32_t T0;   /**< Internal lens temperature during calibration */
   float Nu;   /**< Thermal compensation exponent */
   int32_t DeviceTemperatureSensor;   /**< Device Sensor Temperature during calibration */
   uint32_t SpectralResponsePOSIXTime;   /**< Camera spectral response file generation date and time */
   uint32_t ReferencePOSIXTime;   /**< Camera reference file generation date and time */
   uint16_t FWFilterID;   /**< Filter wheel filter identification number */
   uint16_t NDFilterID;   /**< Neutral density filter identification number */
   uint16_t ManualFilterID;   /**< Manual filter identification number */
   uint16_t LensID;   /**< Lens identification number */
   float LowCut;   /**< Low wavelength at mid-height of the IBR integration start */
   float HighCut;   /**< High wavelength at mid-height of the IBR integration start */
   float LowReferenceTemperature;   /**< Lowest blackbody reference temperature used in calibration */
   float HighReferenceTemperature;   /**< Highest blackbody reference temperature used in calibration */
   float LowExtrapolationTemperature;   /**< Lowest value of the radiometric temperature LUT */
   float HighExtrapolationTemperature;   /**< Highest value of the radiometric temperature LUT */
   float FluxOffset;   /**< Calculated flux at 0K */
   float FluxSaturation;   /**< Measured flux at current saturation */
   float LowExtrapolationFactor;   /**< Extrapolation factor for LUT lower limit */
   float HighExtrapolationFactor;   /**< Extrapolation factor for LUT upper limit */
   float LowValidTemperature;   /**< Lowest valid value of the calibrated radiometric temperature */
   float HighValidTemperature;   /**< Highest valid value of the calibrated radiometric temperature */
   uint8_t BinningMode;   /**< In binning mode, pixels are joined into a single large pixel */
   uint8_t FOVPosition;   /**< Motorized FOV lens position */
   int32_t FocusPositionRaw;   /**< Motorized focus lens encoder position */
   int32_t ImageCorrectionFocusPositionRaw;   /**< Motorized focus lens encoder position to use for image correction */
   float ExternalLensMagnification;   /**< External lens magnification (for microscope objective) */
   uint8_t SensorPixelPitch;   /**< Pixel pitch of the infrared sensor */
   uint8_t CompensatedBlock;   /**< Logical flag indicating if the block is compensated for reference source and environment (chamber) contributions */
   uint16_t CalibrationReferenceSourceID;   /**< Reference blackbody source identification number */
   float CalibrationReferenceSourceEmissivity;   /**< Emissivity of the reference blackbody source */
   float CalibrationReferenceSourceDistance;   /**< Distance between the reference blackbody surface and the external lens */
   float CalibrationChamberTemperature;   /**< Temperature of the air mass between the reference blackbody surface and the external lens */
   float CalibrationChamberRelativeHumidity;   /**< Relative humidity (RH) of the air mass between the reference blackbody surface and the external lens */
   float CalibrationChamberCO2MixingRatio;   /**< CO2 mixing ratio of the air mass between the reference blackbody surface and the external lens */
   float SSEParameter1;   /**< Parameter #1 of the SSE compensation */
   float SSEParameter2;   /**< Parameter #2 of the SSE compensation */
   float SSEParameter3;   /**< Parameter #3 of the SSE compensation */
   uint8_t SSEModel;   /**< Model number of the SSE compensation */
   uint8_t SensorIDMSB;   /**< Sensor ID Most Significant Byte */
   uint16_t ExtenderRingID;   /**< Extender ring identification number */
   uint32_t ExtenderRingSerialNumber;   /**< Unique Telops 32-bit extender ring serial number */
   char ExtenderRingName[65];   /**< Extender ring name */
   float FNumber;   /**< Sensor FNumber */
   uint8_t CompressionAlgorithm;   /**< Compression algorithm to be used on data calibrated with this block */
   float CompressionParameter;   /**< Compression parameter to be used on data calibrated with this block. Parameter usage depends on CompressionAlgorithm */
   float CalibrationROI;   /**< Region of interest used to calibrate the camera */
   uint8_t CalibrationMethod;   /**< Method used to calibrate the camera */
   uint8_t PixelDataPresence;   /**< Indicates the presence of pixel data in calibration block */
   uint8_t MaxTKDataPresence;   /**< Indicates the presence of MaxTK data in calibration block */
   uint8_t LUTNLDataPresence;   /**< Indicates the presence of LUTNL data in calibration block */
   uint8_t LUTRQDataPresence;   /**< Indicates the presence of LUTRQ data in calibration block */
   uint8_t NumberOfLUTRQ;   /**< Number of radiometric quantity lookup tables in calibration block */
   uint8_t KPixDataPresence;   /**< Indicates the presence of KPix data in calibration block */
   uint16_t FileHeaderCRC16;   /**< File header CRC-16 */
};

/**
 * BlockFileHeader data type.
 */
typedef struct CalibBlock_BlockFileHeader_v2Struct CalibBlock_BlockFileHeader_v2_t;

/**
 * PixelDataHeader data structure.
 */
struct CalibBlock_PixelDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
   float Offset_Off;   /**< Offset offset */
   float Offset_Median;   /**< Offset median */
   int8_t Offset_Exp;   /**< Offset exponent */
   uint8_t Offset_Nbits;   /**< Offset data field bit width */
   uint8_t Offset_Signed;   /**< Indicates whether the offset data field is signed */
   float Range_Off;   /**< Range offset */
   float Range_Median;   /**< Range median */
   int8_t Range_Exp;   /**< Range exponent */
   uint8_t Range_Nbits;   /**< Range data field bit width */
   uint8_t Range_Signed;   /**< Indicates whether the range data field is signed */
   float Kappa_Off;   /**< Kappa offset */
   float Kappa_Median;   /**< Kappa median */
   int8_t Kappa_Exp;   /**< Kappa exponent */
   uint8_t Kappa_Nbits;   /**< Kappa data field bit width */
   uint8_t Kappa_Signed;   /**< Indicates whether the kappa data field is signed */
   float Beta0_Off;   /**< Beta0 offset */
   float Beta0_Median;   /**< Beta0 median */
   int8_t Beta0_Exp;   /**< Beta0 exponent */
   uint8_t Beta0_Nbits;   /**< Beta0 data field bit width */
   uint8_t Beta0_Signed;   /**< Indicates whether the beta0 data field is signed */
   float Alpha_Off;   /**< Alpha offset */
   float Alpha_Median;   /**< Alpha median */
   int8_t Alpha_Exp;   /**< Alpha exponent */
   uint8_t Alpha_Nbits;   /**< Alpha data field bit width */
   uint8_t Alpha_Signed;   /**< Indicates whether the alpha data field is signed */
   uint8_t LUTNLIndex_Nbits;   /**< LUTNLIndex data field bit width */
   uint8_t LUTNLIndex_Signed;   /**< Indicates whether the LUTNL index data field is signed */
   uint8_t BadPixel_Nbits;   /**< Alpha data field bit width */
   uint8_t BadPixel_Signed;   /**< Indicates whether the bad pixel data field is signed */
   uint32_t PixelDataLength;   /**< Pixel data length */
   uint16_t PixelDataCRC16;   /**< Pixel data CRC-16 */
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * PixelDataHeader data type.
 */
typedef struct CalibBlock_PixelDataHeader_v2Struct CalibBlock_PixelDataHeader_v2_t;

/**
 * PixelData data structure.
 */
struct CalibBlock_PixelData_v2Struct {
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
typedef struct CalibBlock_PixelData_v2Struct CalibBlock_PixelData_v2_t;

/**
 * MaxTKDataHeader data structure.
 */
struct CalibBlock_MaxTKDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
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
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * MaxTKDataHeader data type.
 */
typedef struct CalibBlock_MaxTKDataHeader_v2Struct CalibBlock_MaxTKDataHeader_v2_t;

/**
 * MaxTKData data structure.
 */
struct CalibBlock_MaxTKData_v2Struct {
   int32_t MaxTK_Data;   /**< MaxTK constant used for recombining coarse and residue values */
};

/**
 * MaxTKData data type.
 */
typedef struct CalibBlock_MaxTKData_v2Struct CalibBlock_MaxTKData_v2_t;

/**
 * LUTNLDataHeader data structure.
 */
struct CalibBlock_LUTNLDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
   float LUT_Xmin;   /**< Minimum lookup table X value */
   float LUT_Xrange;   /**< Lookup table X value range */
   uint16_t LUT_Size;   /**< Number of lookup table elements */
   int8_t M_Exp;   /**< M exponent */
   int8_t B_Exp;   /**< B exponent */
   uint8_t M_Nbits;   /**< M data field bit width */
   uint8_t B_Nbits;   /**< B data field bit width */
   uint8_t M_Signed;   /**< Indicates whether the M data field is signed */
   uint8_t B_Signed;   /**< Indicates whether the B data field is signed */
   uint8_t NumberOfLUTNL;   /**< Number of non-linearity correction lookup tables in LUTNL data */
   uint32_t LUTNLDataLength;   /**< Non-linearity correction lookup table data length */
   uint16_t LUTNLDataCRC16;   /**< Non-linearity correction lookup table data CRC-16 */
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * LUTNLDataHeader data type.
 */
typedef struct CalibBlock_LUTNLDataHeader_v2Struct CalibBlock_LUTNLDataHeader_v2_t;

/**
 * LUTNLData data structure.
 */
struct CalibBlock_LUTNLData_v2Struct {
   uint16_t m;   /**< m */
   uint16_t b;   /**< b */
};

/**
 * LUTNLData data type.
 */
typedef struct CalibBlock_LUTNLData_v2Struct CalibBlock_LUTNLData_v2_t;

/**
 * LUTRQDataHeader data structure.
 */
struct CalibBlock_LUTRQDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
   float LUT_Xmin;   /**< Minimum lookup table X value */
   float LUT_Xrange;   /**< Lookup table X value range */
   uint16_t LUT_Size;   /**< Number of lookup table elements */
   int8_t M_Exp;   /**< M exponent */
   int8_t B_Exp;   /**< B exponent */
   float Data_Off;   /**< Data offset */
   int8_t Data_Exp;   /**< Data exponent */
   uint8_t RadiometricQuantityType;   /**< Radiometric quantity type */
   uint8_t M_Nbits;   /**< M data field bit width */
   uint8_t B_Nbits;   /**< B data field bit width */
   uint8_t M_Signed;   /**< Indicates whether the M data field is signed */
   uint8_t B_Signed;   /**< Data field is signed */
   uint32_t LUTRQDataLength;   /**< Radiometric quantity lookup table data length */
   uint16_t LUTRQDataCRC16;   /**< Radiometric quantity lookup table data CRC-16 */
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * LUTRQDataHeader data type.
 */
typedef struct CalibBlock_LUTRQDataHeader_v2Struct CalibBlock_LUTRQDataHeader_v2_t;

/**
 * LUTRQData data structure.
 */
struct CalibBlock_LUTRQData_v2Struct {
   uint16_t m;   /**< m */
   uint16_t b;   /**< b */
};

/**
 * LUTRQData data type.
 */
typedef struct CalibBlock_LUTRQData_v2Struct CalibBlock_LUTRQData_v2_t;

/**
 * KPixDataHeader data structure.
 */
struct CalibBlock_KPixDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
   uint32_t KPix_Median;   /**< KPix median */
   uint8_t KPix_Nbits;   /**< KPix data field bit width */
   uint8_t KPix_EffectiveBitWidth;   /**< KPix data field effective bit width */
   uint8_t KPix_Signed;   /**< Indicates whether the KPix data field is signed */
   uint32_t KPixDataLength;   /**< KPix data length */
   uint16_t KPixDataCRC16;   /**< KPix data CRC-16 */
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * KPixDataHeader data type.
 */
typedef struct CalibBlock_KPixDataHeader_v2Struct CalibBlock_KPixDataHeader_v2_t;

/**
 * KPixData data structure.
 */
struct CalibBlock_KPixData_v2Struct {
   int16_t KPix_Data;   /**< KPix constant used for recombining coarse and residue values */
};

/**
 * KPixData data type.
 */
typedef struct CalibBlock_KPixData_v2Struct CalibBlock_KPixData_v2_t;

uint32_t CalibBlock_ParseBlockFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_BlockFileHeader_v2_t *hdr);
uint32_t CalibBlock_WriteBlockFileHeader_v2(CalibBlock_BlockFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibBlock_PrintBlockFileHeader_v2(CalibBlock_BlockFileHeader_v2_t *hdr);
uint32_t CalibBlock_ParsePixelDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelDataHeader_v2_t *hdr);
uint32_t CalibBlock_WritePixelDataHeader_v2(CalibBlock_PixelDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibBlock_PrintPixelDataHeader_v2(CalibBlock_PixelDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParsePixelData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_PixelData_v2_t *data);
uint32_t CalibBlock_WritePixelData_v2(CalibBlock_PixelData_v2_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseMaxTKDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_MaxTKDataHeader_v2_t *hdr);
uint32_t CalibBlock_WriteMaxTKDataHeader_v2(CalibBlock_MaxTKDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibBlock_PrintMaxTKDataHeader_v2(CalibBlock_MaxTKDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseMaxTKData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_MaxTKData_v2_t *data);
uint32_t CalibBlock_WriteMaxTKData_v2(CalibBlock_MaxTKData_v2_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseLUTNLDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLDataHeader_v2_t *hdr);
uint32_t CalibBlock_WriteLUTNLDataHeader_v2(CalibBlock_LUTNLDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibBlock_PrintLUTNLDataHeader_v2(CalibBlock_LUTNLDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseLUTNLData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTNLData_v2_t *data);
uint32_t CalibBlock_WriteLUTNLData_v2(CalibBlock_LUTNLData_v2_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseLUTRQDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQDataHeader_v2_t *hdr);
uint32_t CalibBlock_WriteLUTRQDataHeader_v2(CalibBlock_LUTRQDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibBlock_PrintLUTRQDataHeader_v2(CalibBlock_LUTRQDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseLUTRQData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_LUTRQData_v2_t *data);
uint32_t CalibBlock_WriteLUTRQData_v2(CalibBlock_LUTRQData_v2_t *data, uint8_t *buffer, uint32_t buflen);
uint32_t CalibBlock_ParseKPixDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_KPixDataHeader_v2_t *hdr);
uint32_t CalibBlock_WriteKPixDataHeader_v2(CalibBlock_KPixDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibBlock_PrintKPixDataHeader_v2(CalibBlock_KPixDataHeader_v2_t *hdr);
uint32_t CalibBlock_ParseKPixData_v2(uint8_t *buffer, uint32_t buflen, CalibBlock_KPixData_v2_t *data);
uint32_t CalibBlock_WriteKPixData_v2(CalibBlock_KPixData_v2_t *data, uint8_t *buffer, uint32_t buflen);

#endif // CALIBBLOCKFILE_V2_H