/**
 * @file CalibSpectralResponseFile_v2.h
 * Camera calibration spectral response file structure v2 declaration.
 *
 * This file declares the camera calibration spectral response file structure v2.
 *
 * Auto-generated calibration spectral response file library.
 * Generated from the calibration spectral response file structure definition XLS file version 2.0.0
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

#ifndef CALIBSPECTRALRESPONSEFILE_V2_H
#define CALIBSPECTRALRESPONSEFILE_V2_H

#include <stdint.h>

#define CALIBSPECTRALRESPONSE_FILEMAJORVERSION_V2      2
#define CALIBSPECTRALRESPONSE_FILEMINORVERSION_V2      0
#define CALIBSPECTRALRESPONSE_FILESUBMINORVERSION_V2   0

#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V2   512

#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V2   256
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SIZE_V2   4
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_MASK_V2    (uint32_t)(0x0000FFFF)
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_SHIFT_V2   0
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_MASK_V2    (uint32_t)(0xFFFF0000)
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_SHIFT_V2   16

/**
 * SpectralResponseFileHeader data structure.
 */
struct CalibSpectralResponse_SpectralResponseFileHeader_v2Struct {
   char FileSignature[5];   /**< File signature */
   uint8_t FileStructureMajorVersion;   /**< File structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< File structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< File structure SubMinor Version */
   uint32_t FileHeaderLength;   /**< File header length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t POSIXTime;   /**< File generation date and time */
   char FileDescription[65];   /**< File description */
   uint8_t SensorID;   /**< Sensor identification number. */
   uint32_t ExternalLensSerialNumber;   /**< Unique Telops 32-bit external lens serial number */
   uint32_t ManualFilterSerialNumber;   /**< Unique Telops 32-bit manual filter serial number */
   uint8_t FWPosition;   /**< Filter wheel position */
   uint8_t NDFPosition;   /**< Neutral density filter position */
   uint16_t FWFilterID;   /**< Filter wheel filter identification number. */
   uint16_t NDFilterID;   /**< Neutral density filter identification number. */
   uint16_t ManualFilterID;   /**< Manual filter identification number. */
   uint16_t LensID;   /**< Lens identification number. */
   float LowCut;   /**< Low wavelength at mid-height of the IBR integration start. */
   float HighCut;   /**< High wavelength at mid-height of the IBR integration start. */
   uint16_t FileHeaderCRC16;   /**< File header CRC-16 */
};

/**
 * SpectralResponseFileHeader data type.
 */
typedef struct CalibSpectralResponse_SpectralResponseFileHeader_v2Struct CalibSpectralResponse_SpectralResponseFileHeader_v2_t;

/**
 * SpectralResponseDataHeader data structure.
 */
struct CalibSpectralResponse_SpectralResponseDataHeader_v2Struct {
   uint32_t DataHeaderLength;   /**< Data header length */
   uint16_t SpectralResponseCurveSize;   /**< Number of points in the curve */
   int8_t Lambda_Exp;   /**< Lambda exponent */
   int8_t SR_Exp;   /**< Spectral response exponent */
   float Lambda_Off;   /**< Lambda offset */
   float SR_Off;   /**< Spectral response offset */
   uint8_t Lambda_Nbits;   /**< M data filed bit width */
   uint8_t SR_Nbits;   /**< B data filed bit width */
   uint8_t Lambda_Signed;   /**< Indicates whether the Lambda data field is signed. */
   uint8_t SR_Signed;   /**< Indicates whether the SR data field is signed. */
   uint32_t SpectralResponseDataLength;   /**< Spectral response data length */
   uint16_t SpectralResponseDataCRC16;   /**< Spectral response data CRC-16 */
   uint16_t DataHeaderCRC16;   /**< Data header CRC-16 */
};

/**
 * SpectralResponseDataHeader data type.
 */
typedef struct CalibSpectralResponse_SpectralResponseDataHeader_v2Struct CalibSpectralResponse_SpectralResponseDataHeader_v2_t;

/**
 * SpectralResponseData data structure.
 */
struct CalibSpectralResponse_SpectralResponseData_v2Struct {
   uint16_t lambda;   /**< Wavelength */
   uint16_t SR;   /**< Spectral response */
};

/**
 * SpectralResponseData data type.
 */
typedef struct CalibSpectralResponse_SpectralResponseData_v2Struct CalibSpectralResponse_SpectralResponseData_v2_t;

uint32_t CalibSpectralResponse_ParseSpectralResponseFileHeader_v2(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseFileHeader_v2_t *hdr);
uint32_t CalibSpectralResponse_WriteSpectralResponseFileHeader_v2(CalibSpectralResponse_SpectralResponseFileHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibSpectralResponse_PrintSpectralResponseFileHeader_v2(CalibSpectralResponse_SpectralResponseFileHeader_v2_t *hdr);
uint32_t CalibSpectralResponse_ParseSpectralResponseDataHeader_v2(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseDataHeader_v2_t *hdr);
uint32_t CalibSpectralResponse_WriteSpectralResponseDataHeader_v2(CalibSpectralResponse_SpectralResponseDataHeader_v2_t *hdr, uint8_t *buffer, uint32_t buflen);
void CalibSpectralResponse_PrintSpectralResponseDataHeader_v2(CalibSpectralResponse_SpectralResponseDataHeader_v2_t *hdr);
uint32_t CalibSpectralResponse_ParseSpectralResponseData_v2(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseData_v2_t *data);
uint32_t CalibSpectralResponse_WriteSpectralResponseData_v2(CalibSpectralResponse_SpectralResponseData_v2_t *data, uint8_t *buffer, uint32_t buflen);

#endif // CALIBSPECTRALRESPONSEFILE_V2_H