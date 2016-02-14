/**
 *  @file Actualization.h
 *  Calibration actualization module header.
 *  
 *  This file defines the calibration actualization module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef ACTUALIZATION_H
#define ACTUALIZATION_H

#include "IRC_Status.h" // for IRC_Status_t

#include "Calibration.h"
#include "ICU.h"
#include "AEC.h"
#include "verbose.h"

#include <stdint.h>
#include <stdbool.h>

#define ACT_VERBOSE_LEVEL 2

#ifdef ACT_VERBOSE
   #define ACT_PRINTF(fmt, ...)  PRINTF("ACT: " fmt, ##__VA_ARGS__)
#else
   #define ACT_PRINTF(fmt, ...)  DUMMY_PRINTF("ACT: " fmt, ##__VA_ARGS__)
#endif

#define ACT_ERR(fmt, ...)        PRINTF("ACT: Error: " fmt "\n", ##__VA_ARGS__)
#define ACT_INF(fmt, ...)        ACT_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#if ACT_VERBOSE_LEVEL>1
   #define ACT_TRC(fmt, ...)        ACT_PRINTF("Trace: " fmt "\n", ##__VA_ARGS__)
#else
   #define ACT_TRC(fmt, ...)        DUMMY_PRINTF("Trace: " fmt "\n", ##__VA_ARGS__)
#endif

#define ACT_MAX_PIX_DATA_TO_PROCESS   128 // number of pixels to process in a single time shared pass. Must be even
#define ACT_MAX_DATABLOCK_TO_WRITE    256 // for file IO

#define ACT_ICU_TEMP_TOL              (float)0.25f // [°C]
#define ACT_AEC_EXPTIME_TOL           (float)2.0f // [us] convergence criterion for AEC

#define TIC
#define ACT_WAIT_FOR_ACQ_TIMEOUT (uint32_t)5 * TIME_ONE_SECOND_US // [us]
#define ACT_WAIT_FOR_DATA_TIMEOUT (uint32_t)30 * TIME_ONE_SECOND_US // [us]
#define ACT_WAIT_FOR_ICU_TIMEOUT (uint32_t)2*gICU_ctrl.ICU_TransitionDuration*1000 // [us]
#define ACT_WAIT_FOR_AEC_TIMEOUT (uint32_t)3 * TIME_ONE_SECOND_US // [us] // TODO periode à valider (vient du code de TEL-1000)
#define ACT_WAIT_FOR_SEQ_TIMEOUT (uint32_t)10 * TIME_ONE_SECOND_US // [us]
#define ACT_ICU_TEMP_STABLE_TIME (uint32_t)15 * TIME_ONE_SECOND_US // [us] // TODO mettre la bonne duree
#define ACT_ICU_TEMP_WAIT_TIME (uint32_t)5 * TIME_ONE_SECOND_US // [us] // TODO mettre la bonne duree
#define ACT_ICU_STABILISATION_TIMEOUT (uint32_t)300 * TIME_ONE_SECOND_US // [us] // TODO mettre la bonne duree

#define DELTA_BETA_NUM_BITS 11

#define ACT_MAX_N_COADD (uint32_t)256 // maximum number of images to coadd

#define ACT_FILENAME (char*)"Actualization.tsac"

#ifndef CELSIUS_TO_KELVIN
   #define CELSIUS_TO_KELVIN (float)273.15f
#endif

#ifndef KELVIN_TO_CELSIUS
   #define KELVIN_TO_CELSIUS (float)-273.15f
#endif

typedef enum {
   BC_Init = 0,                /**< initial state with some initialisations */
   BC_Idle,                    /**< wait for a start actualization command */
   BC_Start,              /**< find the reference block (if using ICU) an trigger a load command to the calibration manager */
   BC_WaitForCalibData,        /**< wait until the calibration manager has finished loading the reference block */
   BC_TransitionICU,           /**< waiting during while ICU is in transition */
   BC_WaitICU,                 /**< waiting phases for ICU measurements */
   BC_StabilizeICU,            /**< ICU temperature stabilization phases */
   BC_StartAECAcquisition,     /**< choose a best exposure time in AEC mode*/
   BC_StartAEC,                /**< */
   BC_StopAECAcquisition,      /**< */
   BC_StartAcquisition,        /**< configure the buffer mode and trigger the buffered acquisition */
   BC_WaitSequenceReady,       /**< wait for the buffered sequence to be ready */
   BC_FinalizeSequence,
   BC_ComputeAveragedImage,    /**< the buffered sequence is accumulated (block-computation to yield some time to other processes)*/
   BC_ComputeBlackBodyFCal,    /**< the scalar value FCalBB is computed from the temperature measurement */
   BC_ComputeDeltaBeta,        /**< for each pixel, compute delta-beta (block-computation to yield some time to other processes) */
   BC_WriteActualizationFile,  /**< the file writer state machine is on during this state */
   BC_Finalize                 /**< a reload calibration command is issued to the calibration manager */
}  BC_State_t;

/**< a datatype for keeping a copy of the genicam register to get tampered with during this process */
typedef struct {
   uint32_t CalibrationMode;
   uint32_t SensorWellDepth;
   uint32_t IntegrationMode;
   uint32_t ExposureAuto;
   uint32_t Width;
   uint32_t Height;
   float AcquisitionFrameRate;
   float ExposureTime;
   float AECImageFraction;
   float AECTargetWellFilling;
   float AECResponseTime;
   uint32_t FWPositionSetpoint;
   uint32_t TestImageSelector;
   uint32_t EHDRINumberOfExposures;
   uint32_t MemoryBufferMOISource;
   uint32_t MemoryBufferNumberOfSequences;
   uint32_t MemoryBufferSequenceSize;
   uint32_t MemoryBufferSequencePreMOISize;
   uint32_t MemoryBufferMode;
   uint32_t OffsetX;
   uint32_t OffsetY;
} BC_GCRegsBackup_t;

typedef struct {
   uint8_t TemperatureSelector;
   uint32_t WaitTime1;
   float TemperatureTolerance1;
   uint32_t StabilizationTime1;
   uint32_t Timeout1;
   uint32_t WaitTime2;
   float TemperatureTolerance2;
   uint32_t StabilizationTime2;
   uint32_t Timeout2;
} ICUParams_t;

typedef struct
{
   bool useDebugData; // defaults to false
   bool clearBufferAfterCompletion; // defaults to true
   bool bypassAEC; // defaults to false
} actOptions_t;

extern bool gActDeltaBetaAvailable; /**< indicates the validity of the actualization data in memory */
extern bool gActAllowAcquisitionStart; /**< Allows acquisitions during the actualisation process */
extern uint32_t gActualisationPosixTime; /**< POSIX time of the most current actualization */
extern actOptions_t gActualizationOptions;

void setDefaultIcuParams(ICUParams_t* p);

IRC_Status_t startBetaCorrectionSM( bool internalTrig );
IRC_Status_t BetaCorrection_SM( void );

bool shouldUpdateCurrentCalibration(const calibrationInfo_t* calibInfo, uint8_t blockIdx);
uint32_t updateCurrentCalibration(const calibBlockInfo_t* blockInfo, uint32_t* p_CalData, const uint32_t* p_actData, uint32_t numData);
void ACT_ResetOptions();

#endif // ACTUALIZATION_H
