/**
 * @file CalibSpectralResponseFile_v1.h
 * Camera calibration spectral response file structure v1 declaration.
 *
 * This file declares the camera calibration spectral response file structure v1.
 *
 * Auto-generated calibration spectral response file library.
 * Generated from the calibration spectral response file structure definition XLS file version 1.1.0
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

#ifndef CALIBSPECTRALRESPONSEFILE_V1_H
#define CALIBSPECTRALRESPONSEFILE_V1_H

#include <stdint.h>

#define CALIBSPECTRALRESPONSE_FILEMAJORVERSION_V1      1
#define CALIBSPECTRALRESPONSE_FILEMINORVERSION_V1      1
#define CALIBSPECTRALRESPONSE_FILESUBMINORVERSION_V1   0

#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEFILEHEADER_SIZE_V1   512

#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATAHEADER_SIZE_V1   256
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SIZE_V1   4
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_MASK_V1    (uint32_t)(0x0000FFFF)
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_LAMBDA_SHIFT_V1   0
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_MASK_V1    (uint32_t)(0xFFFF0000)
#define CALIBSPECTRALRESPONSE_SPECTRALRESPONSEDATA_SR_SHIFT_V1   16

/**
 * SpectralResponseFileHeader data structure.
 */
struct CalibSpectralResponse_SpectralResponseFileHeader_v1Struct {
   char FileSignature[5];   /**< Calibration actualization file signature */
   uint8_t FileStructureMajorVersion;   /**< Calibration file structure Major Version */
   uint8_t FileStructureMinorVersion;   /**< Calibration file structure Minor Version */
   uint8_t FileStructureSubMinorVersion;   /**< Calibration file structure SubMinor Version */
   uint32_t SpectralResponseFileHeaderLength;   /**< Spectral response file header length */
   uint32_t DeviceSerialNumber;   /**< Device serial number */
   uint32_t POSIXTime;   /**< File generation date and time */
   char FileDescription[65];   /**< Spectral response file description */
   uint8_t SensorID;   /**< Sensor ID. */
   uint32_t ExternalLensSerialNumber;   /**< Unique Telops 32-bit external lens serial number */
   uint32_t ManualFilterSerialNumber;   /**< Unique Telops 32-bit manual filter serial number */
   uint8_t FWPosition;   /**< Filter wheel position */
   uint8_t NDFPosition;   /**< Neutral density filter position */
   uint16_t SpectralResponseFileHeaderCRC16;   /**< Spectral Response file header CRC-16 */
};

/**
 * SpectralResponseFileHeader data type.
 */
typedef struct CalibSpectralResponse_SpectralResponseFileHeader_v1Struct CalibSpectralResponse_SpectralResponseFileHeader_v1_t;

/**
 * SpectralResponseDataHeader data structure.
 */
struct CalibSpectralResponse_SpectralResponseDataHeader_v1Struct {
   uint32_t SpectralResponseDataHeaderLength;   /**< Spectral response data header length */
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
   uint16_t SpectralResponseDataHeaderCRC16;   /**< Spectral Response data header CRC-16 */
};

/**
 * SpectralResponseDataHeader data type.
 */
typedef struct CalibSpectralResponse_SpectralResponseDataHeader_v1Struct CalibSpectralResponse_SpectralResponseDataHeader_v1_t;

/**
 * SpectralResponseData data structure.
 */
struct CalibSpectralResponse_SpectralResponseData_v1Struct {
   uint16_t lambda;   /**< Wavelength */
   uint16_t SR;   /**< Spectral response */
};

/**
 * SpectralResponseData data type.
 */
typedef struct CalibSpectralResponse_SpectralResponseData_v1Struct CalibSpectralResponse_SpectralResponseData_v1_t;

uint32_t CalibSpectralResponse_ParseSpectralResponseFileHeader_v1(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseFileHeader_v1_t *hdr);
uint32_t CalibSpectralResponse_WriteSpectralResponseFileHeader_v1(CalibSpectralResponse_SpectralResponseFileHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibSpectralResponse_ParseSpectralResponseDataHeader_v1(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseDataHeader_v1_t *hdr);
uint32_t CalibSpectralResponse_WriteSpectralResponseDataHeader_v1(CalibSpectralResponse_SpectralResponseDataHeader_v1_t *hdr, uint8_t *buffer, uint32_t buflen);
uint32_t CalibSpectralResponse_ParseSpectralResponseData_v1(uint8_t *buffer, uint32_t buflen, CalibSpectralResponse_SpectralResponseData_v1_t *data);
uint32_t CalibSpectralResponse_WriteSpectralResponseData_v1(CalibSpectralResponse_SpectralResponseData_v1_t *data, uint8_t *buffer, uint32_t buflen);

#endif // CALIBSPECTRALRESPONSEFILE_V1_H