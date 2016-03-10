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

#ifndef ACT_VERBOSE
   #define VERBOSE_IF(x) if (x)
#else
   #define VERBOSE_IF(x)
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

#define ACT_DEFAULT_FPS         (float)25.0f
#define ACT_MAX_N_COADD         (uint32_t)256 // maximum number of images to coadd

#define ACT_NUM_DEBUG_FRAMES   12

#define MAX_FRAME_SIZE ((uint32_t)(FPA_HEIGHT_MAX+2) * (uint32_t)FPA_WIDTH_MAX)
#define MAX_PIXEL_COUNT ((uint32_t)(FPA_HEIGHT_MAX) * (uint32_t)FPA_WIDTH_MAX)

#define ACT_FILENAME (char*)"Actualization.tsac"

#ifndef CELSIUS_TO_KELVIN
   #define CELSIUS_TO_KELVIN (float)273.15f
#endif

#ifndef KELVIN_TO_CELSIUS
   #define KELVIN_TO_CELSIUS (float)-273.15f
#endif

#define ACT_STATES(ACTION) \
		ACTION(ACT_Init)                    /**< initial state with some initialisations */ \
		ACTION(ACT_Idle)                    /**< wait for a start actualization command */ \
		ACTION(ACT_Start)                   /**< find the reference block (if using ICU) an trigger a load command to the calibration manager */ \
		ACTION(ACT_WaitForCalibData)        /**< wait until the calibration manager has finished loading the reference block */ \
		ACTION(ACT_TransitionICU)           /**< waiting during while ICU is in transition */ \
		ACTION(ACT_WaitICU)                 /**< waiting phases for ICU measurements */ \
		ACTION(ACT_StabilizeICU)            /**< ICU temperature stabilization phases */ \
		ACTION(ACT_StartAECAcquisition)     /**< choose a best exposure time in AEC mode*/ \
		ACTION(ACT_StartAEC)                /**< once configure, start acquisition with AEC active*/ \
		ACTION(ACT_StopAECAcquisition)      /**< stop acquisition after some time */ \
		ACTION(ACT_StartAcquisition)        /**< configure the buffer mode and trigger the buffered acquisition */ \
		ACTION(ACT_WaitSequenceReady)       /**< wait for the buffered sequence to be ready */ \
		ACTION(ACT_FinalizeSequence)        /**< stop acquisition and initialise variables for average computation */ \
		ACTION(ACT_ComputeAveragedImage)    /**< the buffered sequence is accumulated (block-computation to yield some time to other processes)*/ \
		ACTION(ACT_ComputeBlackBodyFCal)    /**< the scalar value FCalBB is computed from the temperature measurement */ \
		ACTION(ACT_ComputeDeltaBeta)        /**< for each pixel, compute delta-beta (block-computation to yield some time to other processes) */ \
		ACTION(ACT_DetectBadPixels)         /**< perform detection of bad pixel based on noise and flicker criteria */ \
		ACTION(ACT_ApplyBadPixelMap)        /**< merge the bad pixel map with the delta beta map */ \
		ACTION(ACT_ComputeDeltaBetaStats)   /**< fill the remaining fields of the deltaBeta_t structure (min, max, etc.) */ \
		ACTION(ACT_WriteActualizationFile)  /**< the file writer state machine is on during this state */ \
		ACTION(ACT_Finalize)                /**< a reload calibration command is issued to the calibration manager */

#define BPD_STATES(ACTION) \
		ACTION(BPD_Idle) \
		ACTION(BPD_UpdateBeta) \
		ACTION(BPD_StartAcquisition) \
		ACTION(BPD_WaitSequenceReady) \
		ACTION(BPD_FinalizeSequence) \
		ACTION(BPD_ComputeStatistics) \
		ACTION(BPD_BuildCriteria) \
		ACTION(BPD_AdjustThresholds) \
		ACTION(BPD_UpdateBPMap) \
		ACTION(BPD_DebugState) \
		ACTION(BPD_Finalize)

#define GENERATE_ENUM(x) x,
#define GENERATE_STRING(x) #x,

typedef enum {
   ACT_STATES(GENERATE_ENUM)
} ACT_State_t;

static const char *ACT_State_str[] __attribute__ ((unused)) = {
      ACT_STATES(GENERATE_STRING)
};

typedef enum {
   BPD_STATES(GENERATE_ENUM)
} BPD_State_t;

static const char *BPD_State_str[] __attribute__ ((unused)) = {
      BPD_STATES(GENERATE_STRING)
};

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
} ACT_GCRegsBackup_t;

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

typedef struct {
   uint32_t startIndex; // index of first element to process
   uint32_t blockIdx; // current block being processed
   uint32_t blockLength; // number of elements to process in the next pass
   uint32_t initialBlockLength;
   uint32_t totalLength; // total number of elements to process
} context_t;

typedef struct {
   float deltaBeta[MAX_PIXEL_COUNT]; // the bad pixels from the reference block have a deltaBeta value of infinity
   statistics_t stats;
   float p50; // median value
   uint32_t saturatedData; // number of pixel values with saturation in the NUC data
   uint32_t type; // 0: icu, 1: external BB
   bool ready;
} deltabeta_t; // for future use

void ctxtInit(context_t* ctxt, uint32_t i0, uint32_t totalLength, uint32_t blockLength);
uint32_t ctxtIterate(context_t* ctxt);
uint32_t ctxtStep(context_t* ctxt, uint32_t n);
bool ctxtIsDone(const context_t* ctxt);

typedef struct
{
   bool useDebugData; // defaults to false
   bool clearBufferAfterCompletion; // defaults to true
   bool bypassAEC; // defaults to false
   bool bypassChecks;
   bool disableDelteBeta;
   bool disableBPDetection;
   bool useDynamicTestPattern;
   bool verbose;
   bool forceDiscardOffset;
   uint32_t mode; // bit mask, default to 0
} actDebugOptions_t;

typedef struct
{
   uint32_t numFrames; // number of recorded frames (minus the extra frames for debugging)
   uint32_t BPNumSamples;
   uint32_t deltaBetaNCoadd;
   float flickerThreshold; // threshold for flicker identification
   float noiseThreshold; // threshold for noisy pixels identification
   uint32_t flickersNCoadd; // number of frames to use for average estimation
   uint32_t badPixelsDetection;
   uint32_t duration; // duration of observation
   uint32_t deltaBetaDiscardOffset; // remove the DC component of the deltaBeta map (only applies to ICU updates). Default is false
} actParams_t;

typedef struct
{
   uint16_t* m;
   uint16_t* M;
   uint16_t* mu;
   uint16_t* R;
   int32_t* Z;
   uint16_t* bpMap;
   float* deltaBeta;
   uint32_t length; // size of the arrays (number of pixels)
} actBuffers_t;

typedef struct
{
   uint32_t type;                 // 0 : ICU, 1 : External BB
   float internalLensTemperature; // temperature of internal lens at time of actualisation [K]
   float referenceTemperature;    // temperature used as reference [K]
   float exposureTime;            // [µs]
} actualisationInfo_t;

// actOptions_t.mode switches
#define ACT_MODE_DELTA_BETA_OFF 0x01 // go directly to bad pixel detection (if enabled)
#define ACT_MODE_BP_OFF 0x02
#define ACT_MODE_DEBUG 0x04 // bypass some verifications, buffer not cleared, bypass stabilisation phases
#define ACT_MODE_DYN_TST_PTRN 0x08 // use the dynamic test pattern (always the case if the cooler is off)
#define ACT_MODE_VERBOSE 0x10 // add some verbose
#define ACT_MODE_DISCARD_OFFSET 0x20 // add some verbose

extern bool gActDeltaBetaAvailable; /**< indicates the validity of the actualization data in memory */
extern bool gActAllowAcquisitionStart; /**< Allows acquisitions during the actualisation process (bypass the WaitingForCalibrationActualizationMask flag) */
extern uint32_t gActualisationPosixTime; /**< POSIX time of the most current actualization */
extern actDebugOptions_t gActDebugOptions;
extern actParams_t gActualizationParams;

void configureIcuParams(ICUParams_t* p);

IRC_Status_t startActualization( bool internalTrig );
void stopActualization();
IRC_Status_t Actualization_SM();
IRC_Status_t BadPixelDetection_SM();

bool shouldUpdateCurrentCalibration(const calibrationInfo_t* calibInfo, uint8_t blockIdx);
uint32_t updateCurrentCalibration(const calibBlockInfo_t* blockInfo, uint32_t* p_CalData, const deltabeta_t* deltaBeta, uint32_t startIdx, uint32_t numData);
uint32_t updateBadPixelMap(uint32_t* p_CalData, const uint16_t* p_bpMap, uint32_t numData);
void ACT_resetDebugOptions();
void ACT_parseDebugMode();
void ACT_resetParams(actParams_t* p);

void updateMoments(float* m1, float* m2, float* m3, float x, uint32_t N); /**< iterative statistical moments update. */

void testMomentComputations();

deltabeta_t* ACT_getDeltaBetaForBlock(const calibBlockInfo_t* blockInfo);

#endif // ACTUALIZATION_H
