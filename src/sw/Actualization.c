/**
 *  @file Actualization.c
 *  Calibration actualization module implementation.
 *  
 *  This file implements the calibration update module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "Actualization.h"

#include "BufferManager.h"
#include "AEC.h"
#include "ICU.h"
#include "FileManager.h"
#include "flashSettings.h"
#include "fpa_intf.h"
#include "CalibImageCorrectionFile.h"
#include "FlashDynamicValues.h"
#include "hder_inserter.h"
#include "IRCamHeader.h"
#include "CalibBlockFile.h"
#include "calib.h"
#include "CRC.h"
#include "trig_gen.h"
#include "exposure_time_ctrl.h"
#include "xil_cache.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "GenICam.h"
#include "tel2000_param.h"
#include "proc_memory.h"
#include "timer.h"
#include "utils.h"
#include "BuiltInTests.h"
#include "Acquisition.h"
#include "RpOpticalProtocol.h"

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h> // bool
#include <string.h> // for memcpy()
#include <stddef.h> // NULL
#include <limits.h>

extern ICU_config_t gICU_ctrl;
extern t_bufferManager gBufManager;

bool gActBPMapAvailable = false; /**< indicates the validity of the bad pixel data in memory */
bool gActAllowAcquisitionStart = false; /**< allows the Actualization SM to initiate an internal acquisition through the AcquisitionSM */
actDebugOptions_t gActDebugOptions;
actParams_t gActualizationParams;

// private type for lut data (data is stored in little endian)
typedef struct {
   uint16_t m;
   uint16_t b;
} lut_data_t;

/**
  * Wrapper function to Xil_In32 macro
  *
  *   @param address of the LUT element
  *
  *   @return uint32_t packed LUT element
  *
  *   Note(s): workaround for the read access bug to the LUT
  *
  *--------------------------------------------------------------------------------
  */
uint32_t Xil_In32_(uint32_t add)
{
   Xil_In32(add); // first call does not return the right value.

   return Xil_In32(add); // this call reads the data prepared (but not returned) by the previous call
}

// private type for co-adding status
typedef struct {
   uint32_t NCoadd;
   uint32_t currentCount; // status of the running average
   uint32_t numProcessedPixels; // number of averaging passes completed -> average is ready when this value reaches the number of block divisions in image
} ACT_CoaddData_t;

// private type for statistics accumulation status
typedef struct {
   uint32_t NSamples;
   uint32_t currentCount; // status of the running average
   uint32_t numProcessedPixels; // number of averaging passes completed -> average is ready when this value reaches the number of block divisions in image
} BPD_StatData_t;

typedef struct
{
   float deltaBeta_test;
   float FcalBB_test;
   float TcalBB_test;
   float alpha_test;
} validation_data_t;
validation_data_t test_data;


int8_t gActualisationLoadBlockIdx = -1;

static ICUParams_t icuParams;

static const uint16_t maxNucValue = 0xFFF0;

static bool gStartActualization = false;
static bool gStopActualization = false; // for debugging
static bool gStartBadPixelDetection = false;
bool gStartBetaQuantization = false;
static bool gBetaUpdateDone = false;
static uint8_t gWriteActualizationFile = 0;
static bool usingICU = true; // set to true when the actualisation uses Internal Calibration Unit
static bool allowCalibUpdate = true; // flag for enabling/disabling the correction of Beta when loading a calibration block
static uint32_t privateActualisationPosixTime = 0; // this one is the actual value

static uint32_t mu_buffer[MAX_FRAME_SIZE] __attribute__ ((section (".noinit")));
static uint32_t prctile_buffer[MAX_FRAME_SIZE] __attribute__ ((section (".noinit")));
static uint16_t max_buffer[MAX_FRAME_SIZE] __attribute__ ((section (".noinit")));
static uint16_t min_buffer[MAX_FRAME_SIZE] __attribute__ ((section (".noinit")));
static uint16_t R_buffer[MAX_FRAME_SIZE] __attribute__ ((section (".noinit"))); // array for computing the range of each pixels
static int32_t Z_buffer[MAX_FRAME_SIZE] __attribute__ ((section (".noinit")));  // array for computing the test statistics for the flicker pixels
static uint8_t badPixelMap[MAX_FRAME_SIZE] __attribute__ ((section (".noinit"))); // 0x00 good, 0x01 noisy, 0x02 flicker

static deltabeta_t deltaBetaArray[MAX_DELTA_BETA_SIZE] __attribute__ ((section (".noinit")));
static deltaBetaList_t deltaBetaDB;

static void setActState(ACT_State_t* p_state, ACT_State_t next_state);
static void setBpdState(BPD_State_t* p_state, BPD_State_t next_state);
static void setBqState(BQ_State_t* p_state, BQ_State_t next_state);
static void ACT_backupGCRegisters( ACT_GCRegsBackup_t* p_GCRegsBackup );
static void ACT_restoreGCRegisters( ACT_GCRegsBackup_t* p_GCRegsBackup );
static float applyLUT(uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float x );
static float applyReverseLUT(uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float y_target, bool verbose );
static LUTRQInfo_t* selectLUT(calibBlockInfo_t* blockInfo, uint8_t type);
static void unpackLUTData(uint32_t LUTData, LUTRQInfo_t* p_LUTInfo, float* p_m, float* p_b, bool verbose );
static void computeDeltaBeta(uint64_t* p_CalData, float FCal, float FCalBB, float Alpha_LSB, float Beta_LSB, const calibBlockInfo_t* blockInfo, float* deltaBetaOut, float* alphaOut);
static bool quantizeDeltaBeta(const float BetaLSB, const float deltaBetaIn, int16_t* rawDeltaBetaOut);
static IRC_Status_t ActualizationFileWriter_SM(deltabeta_t* currentDeltaBeta);
static fileRecord_t* findIcuReferenceBlock();
static uint8_t updatePixelDataElement(const calibBlockInfo_t* blockInfo, uint64_t *p_CalData, int16_t deltaBeta, int8_t expBitShift);
static bool isBadPixel(uint64_t* pixelData);

static IRC_Status_t deleteExternalActualizationFiles();
static fileRecord_t* findActualizationFile(uint32_t ref_posixtime);
static bool allocateDeltaBetaForCurrentBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx, bool actTypeICU, deltabeta_t** newDataOut);
static void initDeltaBetaData(deltabeta_t* data);
static deltabeta_t* findSuitableDeltaBetaForBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx, bool verbose);
static deltabeta_t* findMatchingDeltaBetaForBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx);
static void advanceDeltaBetaAge(uint32_t increment_s);

// function for detecting bad pixels in the updated Beta parameter before computing its optimal quantization
static IRC_Status_t cleanBetaDistribution(float* beta, int N, float p_FA, statistics_t* stats, uint32_t* numBadPixels, bool verbose);
static uint32_t cleanBetaDistributionIterate(float* beta, int N, float threshold, statistics_t* stats, bool verbose);
static float nth_element_f(const float* input, float minval, float* buffer, int N, int r);
static uint32_t nth_element_i(const uint32_t* input, uint32_t* buffer, int N, int r);
static uint32_t countBadPixels(const uint64_t* pixelData, int N);
static float decodeBeta(const uint32_t* p_CalData, const calibBlockInfo_t* blockInfo); // convert a single beta value from a packed pixel data element to float value
static bool encodeBeta(float value, uint32_t* p_CalData, const calibBlockInfo_t* blockInfo); // convert a float value and pack it into the 64-bit pixel data element

static void defineActualizationFilename(char* buf, uint8_t length, uint32_t timestamp, deltabeta_t* data);

static void ACT_init();
//static void ACT_clearDeltaBeta(); // initialize the delta beta map with value 0 and bad pixel status 1 (all good pixels)

static bool findImageForBlock(uint8_t blockIdx, uint32_t* seqOffset, uint32_t frameSize, uint32_t nbImg);

// debugging and diagnosis functions
static bool validateAverage(const uint32_t* coadd_buffer, uint32_t numPixels, uint32_t expectedSum);
static bool validateBuffers(uint32_t* coadd_buffer, uint32_t nCoadd, uint16_t* seq_buffer, uint32_t nSeq);

/**
  * Change the current state and display an entry in the log.
  *
  *   @param p_state a pointer to the current state
  *   @param state the new state
  *
  *   @return none
  *
  *   Note(s):
  *
  *--------------------------------------------------------------------------------
  */
static void setActState( ACT_State_t *p_state, ACT_State_t next_state )
{
   int num_states = NUM_OF(ACT_State_str);
   *p_state = next_state;

   if (next_state < num_states)
      ACT_PRINTF("State = %s\n", ACT_State_str[next_state]);
   else
      ACT_PRINTF( "State = %d (unknown)\n", next_state);

   return;
}

static void setBpdState(BPD_State_t* p_state, BPD_State_t next_state)
{
   int num_states = NUM_OF(BPD_State_str);
   *p_state = next_state;

   if (next_state < num_states)
      ACT_PRINTF("State = %s\n", BPD_State_str[next_state]);
   else
      ACT_PRINTF( "State = %d (unknown)\n", next_state);

   return;
}

static void setBqState(BQ_State_t* p_state, BQ_State_t next_state)
{
   int num_states = NUM_OF(BQ_State_str);
   *p_state = next_state;

   if (next_state < num_states)
      ACT_PRINTF("State = %s\n", BQ_State_str[next_state]);
   else
      ACT_PRINTF("State = %d (unknown)\n", next_state);

   return;
}

/**
  *   Initiates the beta correction state machine.
  *
  *   Can be used as an "external" trig for the state machine.
  *
  *   @param None
  *
  *   @return IRC_DONE       Beta correction has been started.
  *           IRC_FAILURE    Beta correction has failed to start.
  *
  *   Note(s):
  *
  *--------------------------------------------------------------------------------
  */
IRC_Status_t startActualization()
{
   builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Pending;

   if ( TDCFlagsTst(ImageCorrectionIsImplementedMask) == 0 )
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("Image correction is not implemented on this model.");
      return IRC_FAILURE;
   }

   if (!flashSettings.ImageCorrectionEnabled || !FS_FLASHSETTINGS_IS_VALID)
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("Image correction is not enabled on this camera.");
      return IRC_FAILURE;
   }

   // process is disabled if the external buffer memory is not present and the internal buffer is not empty
   if (!GC_ExternalMemoryBufferIsImplemented && GC_MemoryBufferNotEmpty)
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("Could not perform image correction because there are recorded sequences in buffer memory.");
      return IRC_FAILURE;
   }

   if (GC_WaitingForImageCorrection)
   {
      ACT_ERR("Image correction is already running.");
      return IRC_FAILURE;
   }

   ACT_INF( "Starting image correction" );

   // Start beta correction
   gStartActualization = 1;

   // set the flag early so that the status LED does not become green for a short period of time.
   TDCStatusSet(WaitingForImageCorrectionMask);

   return IRC_DONE;
}

void stopActualization()
{
   gStopActualization = true;
}

/**
  *  Beta correction state machine.
  *
  *  This state machine computes delta Beta and delta bad pixel map
  *  for every pixel by placing the ICU in front of the detector.
  *
  *  It also writes a file with the computed parameters. The currently loaded
  *  calibration is also updated with the delta parameters
  *
  *   @param None
  *
  *   @return
  *      Process status:
  *      IRC_NOT_DONE   Delta Beta computation is in process.
  *      IRC_DONE       Delta Beta computation is done.
  *      IRC_FAILURE    Delta Beta computation failed.
  *
  *   Note(s):
  *
  */


IRC_Status_t Actualization_SM()
{
   static ACT_State_t state = ACT_Init;
   static uint64_t tic_TotalDuration; // for counting the total elapsed time during calibration update
   static uint64_t tic_AvgDuration; //used for measuring the elapsed time during the averaged (not real time)
   static uint64_t tic_RT_Duration; // used for benchmarking the real time effort of the averaging and other computation
   static timerData_t act_timer; // used to mesure timeouts
   static timerData_t act_tic_verbose; // used to limit the number of repeated verbose
   static timerData_t act_tic_stability; // used during stabilisation
   static uint32_t *p_Data;
   static uint32_t *p_PixData;
   static float FCalBB;
   static float min_temp;
   static float max_temp;
   static ACT_GCRegsBackup_t GCRegsBackup;
   static float Alpha_LSB;
   //static float Beta_LSB;
   static uint32_t expectedSum; // used in debug data mode
   static float scaleFCal;
   static ACT_CoaddData_t coaddData;
   static uint32_t savedCalibPosixTime; // posix time of the calibration block to be reloaded at the end of the update
   static uint8_t savedCurrentBlockIdx;
   static uint32_t dataOffset;
   static uint32_t pixelOffset;
   static uint32_t sequenceOffset; // start of the first image of the buffered sequence [bytes]
   static uint8_t icuPhase;
   static float ICUTemp;
   static float prevExpTime, prevExpTime1, prevExpTime2, prevExpTime3, prevExpTime4, prevExpTime5, prevExpTime6, prevExpTime7, prevExpTime8;
   static context_t blockContext; // information structure for block processing
   static timerData_t age_timer;
   static deltabeta_t* currentDeltaBeta = NULL;
   static uint8_t blockIdx;
   static calibBlockInfo_t* blockInfo = NULL;
   static uint8_t actBlocks;
   static bool actSyncFW;
   static int intBufSeqSize;

   const uint32_t numExtraImages = 1; // number of frames to skip at the beginning of the buffer sequence

   uint32_t i;
   uint32_t k;
   bool error = false;
   float FCal;
   float T_BB;
   //int16_t DeltaBetaH, DeltaBetaL;
   IRC_Status_t rtnStatus = IRC_NOT_DONE;
   IRC_Status_t writeStatus, detectionStatus;
   fileRecord_t* icuCalibFileRec;

   static const uint32_t frameSize = (FPA_HEIGHT_MAX + 2) * FPA_WIDTH_MAX;
   static const uint32_t imageDataOffset = 2*FPA_WIDTH_MAX; // number of header pixels to skip [pixels]
   static const uint32_t numPixels = FPA_HEIGHT_MAX * FPA_WIDTH_MAX;
   const uint32_t age_increment = 10; // [s]

   extern float FWExposureTime[MAX_NUM_FILTER];
   extern float* pGcRegsDataExposureTimeX[MAX_NUM_FILTER];
   extern t_calib gCal;
   extern rpCtrl_t theRpCtrl;

   if (TimedOut(&age_timer))
   {
      RestartTimer(&age_timer);

      // update the age of the valid actualisations
      advanceDeltaBetaAge(age_increment);
   }

   ACT_parseDebugMode();

   switch (state)
   {
      case ACT_Init:
         ACT_init();
         //ACT_clearDeltaBeta();

         deleteExternalActualizationFiles();

         StartTimer(&age_timer, age_increment * 1000);

         setActState(&state, ACT_Idle);
         break;

      case ACT_Idle:
      {
         bool cameraReady = !TDCStatusTstAny(WaitingForCoolerMask | WaitingForCalibrationInitMask | WaitingForPowerMask | WaitingForOutputFPGAMask)
                     || gActDebugOptions.bypassChecks;

         StopTimer(&act_tic_verbose);
         StopTimer(&act_timer);
         StopTimer(&act_tic_stability);

         gActAllowAcquisitionStart = false;

         if (gStartActualization && cameraReady && calibrationInfo.isValid)
         {
            uint32_t numDataToProcess = gcRegsData.SensorWidth * gcRegsData.SensorHeight;
            long spaceFree = uffs_space_free(FM_UFFS_MOUNT_POINT);
            long spaceAct = (CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE +
                             CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE +
                             numDataToProcess * CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE)
                            * gFM_icuBlocks.count;

            gStartActualization = 0;
            savedCalibPosixTime = 0;
            if (spaceFree < spaceAct)
            {
               ACT_ERR("Filesystem has not enough space for actualization process.");
               error = true;
            }
            else
               setActState(&state, ACT_Start);
         }
      }
      break;

      case ACT_Start:
         StartTimer(&act_tic_verbose, TIME_ONE_SECOND_US/1000.0);

         GETTIME(&tic_TotalDuration);

         allowCalibUpdate = false; // we want a plain calibration upon loading it

         gActAllowAcquisitionStart = true;

         configureIcuParams(&icuParams);

         if (gActDebugOptions.bypassChecks)
         {
            icuParams.WaitTime1 = 0;
            icuParams.WaitTime2 = 0;
            icuParams.Timeout1 = 10000;
            icuParams.Timeout2 = 10000;
         }
         ACT_PRINTF("icuParams.WaitTime1 = %d\n", icuParams.WaitTime1);
         ACT_PRINTF("icuParams.WaitTime2 = %d\n", icuParams.WaitTime2);
         ACT_PRINTF("icuParams.StabilizationTime1 = %d\n", icuParams.StabilizationTime1);
         ACT_PRINTF("icuParams.StabilizationTime2 = %d\n", icuParams.StabilizationTime2);
         ACT_PRINTF("icuParams.Timeout1 = %d\n", icuParams.Timeout1);
         ACT_PRINTF("icuParams.Timeout2 = %d\n", icuParams.Timeout2);

         // Backup registers value
         ACT_backupGCRegisters( &GCRegsBackup );

         // Save the collection and current block index
         savedCalibPosixTime = calibrationInfo.collection.POSIXTime;
         Calibration_GetActiveBlockIdx(&calibrationInfo, &savedCurrentBlockIdx);

         // If an acquisition has been started, stop it
         if ( TDCStatusTst(AcquisitionStartedMask) )
         {
            GC_SetAcquisitionStop(1);
         }

         GC_SetFWMode(FWM_Fixed); // stop SFW
         GC_SetEHDRINumberOfExposures(1); // disable EHDRI
         GC_SetCalibrationMode(CM_RT); // make sure the RT LUTRQ gets loaded by the calibration manager
         gcRegsData.TestImageSelector = TIS_Off;
         gcRegsData.BadPixelReplacement = 0; // disabled
         TriggerModeAry[TS_AcquisitionStart] = TM_Off;   // internal trigger
         TriggerModeAry[TS_Gating] = TM_Off; // disabled

         if (gActDebugOptions.useDynamicTestPattern || TDCStatusTst(WaitingForCoolerMask))
         {
            ACT_PRINTF("Using TIS_TelopsDynamicShade\n");
            gcRegsData.TestImageSelector = TIS_TelopsDynamicShade;
         }

         if ( TDCFlagsTst(ICUIsImplementedMask) && (gcRegsData.ImageCorrectionMode == ICM_ICU) )
         {
            usingICU = true;
            ACT_INF("Using ICU");

            // Load ICU calibration data
            icuCalibFileRec = findIcuReferenceBlock();

            if (icuCalibFileRec != 0)
            {
               // number of blocks to actualize
               actBlocks = 1;
               // block index to actualize
               blockIdx = 0;
               // FW mode during actualization
               actSyncFW = false;

               // initiate the loading of the reference block
               Calibration_LoadCalibrationFile(icuCalibFileRec);

               setActState(&state, ACT_WaitForCalibData);
            }
            else
            {
               ACT_ERR( "Could not find a matching ICU file.");
               GC_GenerateEventError(EECD_ImageCorrectionInvalidReferenceBlock);
               error = true;
            }

            StartTimer(&act_timer, ACT_WAIT_FOR_DATA_TIMEOUT/1000);
         }
         else // gcRegsData.ImageCorrectionMode == ICM_BlackBody
         {
            // cas sans ICU -> BB externe. Utiliser alors la calibration en cours comme bloc de référence
            ACT_INF("Using external BB");

            usingICU = false;

            // number of blocks to actualize
            if (gcRegsData.ImageCorrectionBlockSelector == ICBS_AllBlocks)
               actBlocks = calibrationInfo.collection.NumberOfBlocks;
            else
               actBlocks = 1;
            // FW mode during actualization
            if (gcRegsData.ImageCorrectionFWMode == ICFWM_SynchronouslyRotating)
               actSyncFW = true;
            else
               actSyncFW = false;

            ACT_INF("Number of blocks = %d, FW in Sync = %d", actBlocks, actSyncFW);

            // reload the current calibration, because we do not want to update a calibration that has already been actualized
            if ( (actBlocks > 1) || actSyncFW )    // SFW can only use a complete FW collection
            {
               // block index to actualize first
               if ( (actBlocks == 1) && actSyncFW )   // current block in SFW
                  blockIdx = savedCurrentBlockIdx;
               else
                  blockIdx = 0;  // start with 1st block for all multiblock collections
               // make sure we activate the correct block index, because reloading a collection always makes block 0 the active one
               gActualisationLoadBlockIdx = blockIdx;
               Calibration_LoadCalibrationFilePOSIXTime(calibrationInfo.collection.POSIXTime);
               StartTimer(&act_timer, calibrationInfo.collection.NumberOfBlocks * ACT_WAIT_FOR_DATA_TIMEOUT/1000);
            }
            else
            {
               // reload only the block to actualize
               blockIdx = 0;
               gActualisationLoadBlockIdx = 0;
               Calibration_LoadCalibrationFilePOSIXTime(calibrationInfo.blocks[savedCurrentBlockIdx].POSIXTime);
               StartTimer(&act_timer, ACT_WAIT_FOR_DATA_TIMEOUT/1000);
            }

            setActState(&state, ACT_WaitForCalibData);
         }
         break;

      case ACT_WaitForCalibData:
         // Check for calib data loading
         if (TDCStatusTst(WaitingForCalibrationDataMask) == 0)
         {
            if (usingICU)
            {
               // place the ICU out of the FOV in phase 1
               icuPhase = 1;
               ICU_scene(&gcRegsData, &gICU_ctrl);

               setActState( &state, ACT_TransitionICU );
            }
            else // external blackbody
            {
               setActState(&state, ACT_ConfigCamera);
            }
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while loading reference block." );
            GC_GenerateEventError(EECD_ImageCorrectionInvalidReferenceBlock);
            error = true;
         }
         break;

      case ACT_TransitionICU:
         if (gcRegsData.ICUPosition != ICUP_ICUInTransition)
         {
            if (icuPhase == 1)
            {
               StartTimer(&act_timer, icuParams.WaitTime1);
            }
            else // icuPhase == 2
            {
               StartTimer(&act_timer, icuParams.WaitTime2);
            }
            setActState(&state, ACT_WaitICU);
         }
         break;

      case ACT_WaitICU:
         if (TimedOut(&act_timer))
         {
            if (icuPhase == 1)
            {
               StartTimer(&act_tic_stability, icuParams.StabilizationTime1);
               StartTimer(&act_timer, icuParams.Timeout1);
            }
            else // icuPhase == 2
            {
               StartTimer(&act_tic_stability, icuParams.StabilizationTime2);
               StartTimer(&act_timer, icuParams.Timeout2);
            }

            min_temp = 1e6;
            max_temp = -1e6;
            setActState(&state, ACT_StabilizeICU);
         }
         break;

      case ACT_StabilizeICU:
      {
         float tol;

         if (icuPhase == 1)
            tol = icuParams.TemperatureTolerance1;
         else
            tol = icuParams.TemperatureTolerance2;

         // Check for ICU BB temperature stability
         ICUTemp = DeviceTemperatureAry[icuParams.TemperatureSelector];

         if (TimedOut(&act_tic_verbose))
         {
            ACT_INF( "ICU phase %d (%dms)", icuPhase, (uint32_t) elapsed_time_us( tic_TotalDuration ) / 1000 );
            ACT_PRINTF( "Waiting for ICU black body temperature to stabilize (" _PCF(2) " °C)...\n", _FFMT(ICUTemp,2));
            RestartTimer(&act_tic_verbose);
         }

         // Update minimum and maximum temperatures
         min_temp = MIN(min_temp, ICUTemp);
         max_temp = MAX(max_temp, ICUTemp);

         // Reset stability variables when the delta exceeds tolerance
         if ( ( max_temp - min_temp ) > tol)
         {
            ACT_PRINTF( "Min: " _PCF(2) " °C, Max: " _PCF(2) " °C, Timer: " _PCF(2) " s\n", _FFMT(min_temp,2), _FFMT(max_temp,2), _FFMT((float)elapsed_time_us( act_tic_stability.timer ) / (float)TIME_ONE_SECOND_US, 2) );

            min_temp = ICUTemp;
            max_temp = ICUTemp;
            RestartTimer(&act_tic_stability);
         }

         if (TimedOut(&act_tic_stability) || TimedOut(&act_timer))
         {
            if (TimedOut(&act_timer))
            {
               ACT_INF( "Timeout while stabilizing temperature (ICU phase %d).", icuPhase);
            }

            if (icuPhase == 1)
            {
               // Move the ICU to calibration position
               icuPhase = 2;
               ICU_calib(&gcRegsData, &gICU_ctrl);
               setActState(&state, ACT_TransitionICU);
            }
            else // all ICU phases completed
            {
               icuPhase = 0;
               ICUTemp = DeviceTemperatureAry[icuParams.TemperatureSelector];
               setActState(&state, ACT_ConfigCamera);
            }
         }
      }
      break;

      case ACT_ConfigCamera:
         // Info on the block being actualized
         blockInfo = &calibrationInfo.blocks[blockIdx];

         ACT_INF("Configuring camera for block index %d", blockIdx);

         // Prepare acquisition -> full width
         GC_SetWidth(gcRegsData.SensorWidth);
         GC_SetHeight(gcRegsData.SensorHeight);
         GC_SetOffsetX(0);
         GC_SetOffsetY(0);

         if (gActDebugOptions.useDebugData)
            GC_SetCalibrationMode(CM_Raw0);
         else
            GC_SetCalibrationMode(CM_NUC);

         // Make sure AEC and EHDRI are stopped
         GC_SetExposureAuto(EA_Off);
         GC_SetEHDRINumberOfExposures(1);

         if (usingICU)
         {
            // set the starting point for the exposure time (from ICU block)
            gcRegsData.ExposureTime = (float)blockInfo->ExposureTime * CALIBBLOCK_EXP_TIME_TO_US;
            GC_SetAcquisitionFrameRate(MAX(ACT_DEFAULT_FPS, (float)blockInfo->AcquisitionFrameRate/1000.0F));
         }
         else
         {
            if (actSyncFW)
            {
               // Configure FW
               for (i = 0; i < NUM_OF(FWExposureTime); i++)
                  FWExposureTime[i] = FPA_DEFAULT_EXPOSURE;
               GC_SetFWMode(FWM_SynchronouslyRotating);
            }
            else
            {
               // Manually select the block
               gCal.calib_block_sel_mode = blockIdx + CBSM_USER_SEL_0;
               CAL_ApplyCalibBlockSelMode(&gCal, &gcRegsData);

               // set the starting point for the exposure time (default)
               gcRegsData.ExposureTime = FPA_DEFAULT_EXPOSURE;
            }

            GC_SetAcquisitionFrameRate(ACT_DEFAULT_FPS);

            // Move the focus lens
            if (TDCFlagsTst(MotorizedFocusLensIsImplementedMask))
               goFastToFocus(&theRpCtrl, (uint16_t)(blockInfo->ImageCorrectionFocusPositionRaw));

         }

         StartTimer(&act_timer, ACT_WAIT_FOR_ACQ_TIMEOUT/1000);
         setActState(&state, ACT_StartAECAcquisition);
         break;

      case ACT_StartAECAcquisition:
         // Ensure that camera is ready to be armed
         if (!TDCStatusTstAny(TDCStatusAllowSensorAcquisitionArmMask & ~WaitingForImageCorrectionMask) && (gcRegsData.FOVPosition != FOVP_FOVInTransition))
         {
            ACT_INF( "Ready for AEC acquisition! (%dms)", (uint32_t) elapsed_time_us( tic_TotalDuration ) / 1000 );

            if (gActDebugOptions.bypassAEC)
            {
               ACT_PRINTF( "AEC mode disabled\n");
               StartTimer(&act_timer, 0); // no need to wait if AEC is disabled
               setActState(&state, ACT_StartAcquisition);
            }
            else
            {
               // Start acqusition
               GC_SetAcquisitionStart(1);

               StartTimer(&act_timer, ACT_WAIT_FOR_ACQ_TIMEOUT/1000);
               setActState(&state, ACT_StartAEC);
            }
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while waiting for camera ready.");
            GC_GenerateEventError(EECD_ImageCorrectionAcquisitionTimeout);
            error = true;
         }
         break;

      case ACT_StartAEC:
         // Wait until the acquisition is started
         if (GC_AcquisitionStarted)
         {
            // Perform an AEC
            GC_SetAECTargetWellFilling(flashSettings.ImageCorrectionAECTargetWellFilling);
            GC_SetAECResponseTime(flashSettings.ImageCorrectionAECResponseTime);
            GC_SetAECImageFraction(flashSettings.ImageCorrectionAECImageFraction);
            GC_SetExposureAuto(EA_Continuous);

            // Copy starting exposure times
            prevExpTime = gcRegsData.ExposureTime;
            prevExpTime1 = gcRegsData.ExposureTime1;
            prevExpTime2 = gcRegsData.ExposureTime2;
            prevExpTime3 = gcRegsData.ExposureTime3;
            prevExpTime4 = gcRegsData.ExposureTime4;
            prevExpTime5 = gcRegsData.ExposureTime5;
            prevExpTime6 = gcRegsData.ExposureTime6;
            prevExpTime7 = gcRegsData.ExposureTime7;
            prevExpTime8 = gcRegsData.ExposureTime8;

            // set a timer for the stability criterion
            StartTimer(&act_tic_stability, ACT_WAIT_FOR_AEC_TIMEOUT/1000);
            // set a timeout
            if (actSyncFW)
               StartTimer(&act_timer, flashSettings.FWNumberOfFilters * ACT_WAIT_FOR_AEC_TIMEOUT/1000);
            else
               StartTimer(&act_timer, 4*ACT_WAIT_FOR_AEC_TIMEOUT/1000);

            setActState(&state, ACT_StopAECAcquisition);
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while waiting for acquisition start.");
            GC_GenerateEventError(EECD_ImageCorrectionAcquisitionTimeout);
            error = true;
         }
         break;

      case ACT_StopAECAcquisition:
         // Reset timer until all exposure times are stable
         if ( (fabsf( prevExpTime - gcRegsData.ExposureTime) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime1 - gcRegsData.ExposureTime1) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime2 - gcRegsData.ExposureTime2) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime3 - gcRegsData.ExposureTime3) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime4 - gcRegsData.ExposureTime4) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime5 - gcRegsData.ExposureTime5) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime6 - gcRegsData.ExposureTime6) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime7 - gcRegsData.ExposureTime7) > ACT_AEC_EXPTIME_TOL) ||
               (fabsf( prevExpTime8 - gcRegsData.ExposureTime8) > ACT_AEC_EXPTIME_TOL) )
         {
            RestartTimer(&act_tic_stability);
         }
         // Update previous exposure times
         prevExpTime = gcRegsData.ExposureTime;
         prevExpTime1 = gcRegsData.ExposureTime1;
         prevExpTime2 = gcRegsData.ExposureTime2;
         prevExpTime3 = gcRegsData.ExposureTime3;
         prevExpTime4 = gcRegsData.ExposureTime4;
         prevExpTime5 = gcRegsData.ExposureTime5;
         prevExpTime6 = gcRegsData.ExposureTime6;
         prevExpTime7 = gcRegsData.ExposureTime7;
         prevExpTime8 = gcRegsData.ExposureTime8;

         // Wait until the AEC period is over then stop acquisition
         if (TimedOut(&act_tic_stability) || TimedOut(&act_timer))
         {
            // Stop AEC
            GC_SetExposureAuto(EA_Off);

            // Stop acquisition
            GC_SetAcquisitionStop(1);

            ACT_INF( "AEC acquisition done (%d ms)", (uint32_t) elapsed_time_us( tic_TotalDuration ) / 1000 );

            if (actSyncFW)
            {
               // Set FW speed as close as possible to the value requested by user
               GC_SetAcquisitionFrameRate(gcRegsData.ImageCorrectionFWAcquisitionFrameRate);

               StartTimer(&act_timer, ACT_WAIT_FOR_ACQ_TIMEOUT/1000);
               setActState(&state, ACT_WaitAcquisitionReady);
            }
            else
            {
               StartTimer(&act_timer, 1000);
               setActState(&state, ACT_StartAcquisition);
            }
         }
         break;

      case ACT_WaitAcquisitionReady:
         // Ensure that camera is ready to be armed
         if (!TDCStatusTstAny(TDCStatusAllowSensorAcquisitionArmMask & ~WaitingForImageCorrectionMask))
         {
            StartTimer(&act_timer, 0); // no need to wait again
            setActState(&state, ACT_StartAcquisition);
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while waiting for camera ready.");
            GC_GenerateEventError(EECD_ImageCorrectionAcquisitionTimeout);
            error = true;
         }
         break;

      case ACT_StartAcquisition:
         // Wait until the previous acquisition stop is effective
         if (GC_AcquisitionStarted == 0 && TimedOut(&act_timer))
         {
            if (gActDebugOptions.useDebugData)
            {
               gcRegsData.TestImageSelector = TIS_TelopsConstantValue1;
            }

            ACT_PRINTF( "AcquisitionFrameRate = %d fps\n", (uint32_t) gcRegsData.AcquisitionFrameRate );

            // configurer le buffering pour deltaBetaNCoadd images
            ACT_PRINTF( "MemoryBufferSequenceSizeMax = %d\n", BM_HW_GetLocalBufferSequenceSizeMax(&gcRegsData) );

            //intBufSeqSize = gActualizationParams.numFrames;
            intBufSeqSize = gActualizationParams.deltaBetaNCoadd + numExtraImages; // + 1 because the first image is offset most of the time
            if (gActDebugOptions.clearBufferAfterCompletion == 0)
               intBufSeqSize += ACT_NUM_DEBUG_FRAMES;

            gcRegsData.MemoryBufferMOISource = MBMOIS_AcquisitionStarted;
            BufferManager_HW_SetMoiConfig(&gBufManager);
            BufferManager_HW_ForceDirectInternalBufferWriteConfig(&gBufManager, &gcRegsData, 1, intBufSeqSize, 0);

            // start acquisition (arm is handled automatically)
            GC_SetAcquisitionStart(1);

            float timeout = 1000 * intBufSeqSize/gcRegsData.AcquisitionFrameRate;
            StartTimer(&act_timer, timeout + ACT_WAIT_FOR_SEQ_TIMEOUT/1000);

            setActState(&state, ACT_WaitSequenceReady);
         }
         break;

      case ACT_WaitSequenceReady:
         // Wait until we have all the requested images for averaging
         if (elapsed_time_us(tic_TotalDuration) % 5000000 < 3000)
         {
            ACT_INF("Acquiring data for actualization...");
            //ACT_PRINTF("Current number of images in sequence = %d\n", BufferManager_GetSequenceLength(&gBufManager, 0)); // (fait planter l'enregistrement dans le buffer)

         }

         if (GC_AcquisitionStarted && BM_HW_GetLocalWriteSeqCompleted(&gBufManager))
         {
            // CR_WARNING : because the sequence count increments at the *beginning* of the last frame,
            // wait at least for the duration of two frames to make sure we have all the frames before we start computation
            //StopTimer(&act_timer);
            StartTimer(&act_timer, 2000.0F/gcRegsData.AcquisitionFrameRate);
            setActState(&state, ACT_FinalizeSequence);
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while acquiring buffer sequence (number of sequences = %d).", BM_HW_GetLocalSequenceCount(&gBufManager));
            GC_GenerateEventError(EECD_ImageCorrectionAcquisitionTimeout);
            error = true;
         }
         break;

      case ACT_FinalizeSequence:
         if (TimedOut(&act_timer))
         {
            // Stop acquisition
            GC_SetAcquisitionStop(1);
            if (GC_AcquisitionStarted == 0)
            {
               int sequenceLength = BufferManager_HW_GetDirectInternalBufferSequenceRecordedSize(&gBufManager,0);
               ACT_INF( "Sequence buffer acquisition done (%d ms)", (uint32_t) elapsed_time_us( tic_TotalDuration ) / 1000 );

               if (sequenceLength != intBufSeqSize)
               {
                  ACT_ERR( "Number recorded of frames mismatch (actual=%d vs requested=%d)\n", sequenceLength, intBufSeqSize);
                  error = true;
               }

               if (usingICU)
               {
                  // Move the ICU back to scene position
                  ICU_scene(&gcRegsData, &gICU_ctrl);
               }

               if (gActDebugOptions.disableDeltaBeta)
               {
                  gStartBadPixelDetection = 1;
                  setActState(&state, ACT_DetectBadPixels);
               }
               else
                  setActState(&state, ACT_InitComputation);
            }
         }

         break;

      case ACT_InitComputation:
         // fill the accumulator buffer with zeros
         memset(mu_buffer, 0, frameSize * sizeof(uint32_t));

         // Info on the block being actualized (re-assigned if blockIdx has changed)
         blockInfo = &calibrationInfo.blocks[blockIdx];

         ACT_INF("Computing data for block index %d", blockIdx);

         GETTIME(&tic_AvgDuration);
         tic_RT_Duration = 0;

         if (gActDebugOptions.useDebugData)
            coaddData.NCoadd = 16;
         else
            coaddData.NCoadd = gActualizationParams.deltaBetaNCoadd;
         coaddData.currentCount = 0;
         coaddData.numProcessedPixels = 0;

         allocateDeltaBetaForCurrentBlock(&calibrationInfo, blockIdx, usingICU, &currentDeltaBeta);
         if (currentDeltaBeta == NULL)
         {
            ACT_ERR("No active calibration block found.");
            GC_GenerateEventError(EECD_ImageCorrectionInvalidReferenceBlock);
            error = true;
            break;
         }

         currentDeltaBeta->info.internalLensTemperature = C_TO_K(DeviceTemperatureAry[DTS_InternalLens]);
         if (actSyncFW)
            currentDeltaBeta->info.exposureTime = *pGcRegsDataExposureTimeX[blockIdx];
         else
            currentDeltaBeta->info.exposureTime = gcRegsData.ExposureTime;
         currentDeltaBeta->info.AcquisitionFrameRate = gcRegsData.AcquisitionFrameRate;
         currentDeltaBeta->info.FWMode = gcRegsData.FWMode;
         currentDeltaBeta->info.FocusPositionRaw = gcRegsData.FocusPositionRaw;

         sequenceOffset = PROC_MEM_MEMORY_BUFFER_BASEADDR + 2 * frameSize * numExtraImages; // [bytes] the first image is skipped because it has a DL offset in some detectors

         // Move sequence start to the first image corresponding to the block index
         if (findImageForBlock(blockIdx, &sequenceOffset, 2 * frameSize, gcRegsData.MemoryBufferSequenceSize - numExtraImages) == false)
         {
            ACT_ERR("No images found for block index %d", blockIdx);
            error = true;
         }

         dataOffset = 0; // position of the pointer for running average [bytes]
         pixelOffset = imageDataOffset; // offset of the current computing block within a frame [pixels]

         if (gActDebugOptions.useDebugData)
         {
            uint32_t lutAddr = XPAR_RQC_LUT_AXI_BASEADDR + (blockIdx * RQC_LUT_PAGE_SIZE);
            uint16_t* seq_buffer = (uint16_t*) PROC_MEM_MEMORY_BUFFER_BASEADDR;

            expectedSum = 0x1000 * coaddData.NCoadd;
            test_data.deltaBeta_test = -0.1234f;
            test_data.alpha_test = 1.0;
            test_data.FcalBB_test = (float)expectedSum / (currentDeltaBeta->info.exposureTime * blockInfo->NUCMultFactor * coaddData.NCoadd) - test_data.deltaBeta_test / test_data.alpha_test;
            test_data.TcalBB_test = applyLUT(lutAddr, &blockInfo->lutRQData[0], sqrtf(test_data.FcalBB_test));
            validateBuffers(mu_buffer, frameSize, seq_buffer, gcRegsData.MemoryBufferSequenceSize);
         }

         setActState(&state, ACT_ComputeAveragedImage);
         break;

      case ACT_ComputeAveragedImage:
      {
         const uint32_t numPixelsToProcess = numPixels * coaddData.NCoadd;
         uint64_t t0; // just for benchmarking
         int k=0;

         GETTIME(&t0);

         // compute a running average => in fact, we only accumulate pixel values over 32 bits
         // and postpone the division by N for later.
         // After each pass, we'll have processed a block from a single frame
         // The fastest way to sum the pixel (memory access-wise) is to make 32-bit wide accesses.
         // 3.98 us/px (1.88 réel) (3 reads, 2 write par 2 pixels, (1.5r, 1w)/px)

         uint32_t* data_in = (uint32_t*)(sequenceOffset + dataOffset + (pixelOffset<<1));
         uint32_t* data_out = (uint32_t*)(mu_buffer + pixelOffset);
         uint32_t pixVal32;

         if (coaddData.numProcessedPixels == 0)
         {
            ACT_PRINTF("first value (32-bits) 0x%08X\n", data_in[0]);
         }

         for (k=0; k<ACT_MAX_PIX_DATA_TO_PROCESS; k += 2)
         {
            pixVal32 = *data_in++;

            // check if saturation occurred on a pixel that is not already bad (report it in the debug terminal for now)
            if ((pixVal32 & 0x0000FFFF) == (uint32_t)maxNucValue)
               ++currentDeltaBeta->saturatedDataCount;

            if ((pixVal32 >> 16) == (uint32_t)maxNucValue)
               ++currentDeltaBeta->saturatedDataCount;

            *data_out++ += (uint32_t)(pixVal32 & 0x0000FFFF);

            *data_out++ += (uint32_t)(pixVal32 >> 16);
         }

         tic_RT_Duration += elapsed_time_us(t0);

         // go to next frame -> step is in bytes
         if (actSyncFW)
            dataOffset += 2 * frameSize * flashSettings.FWNumberOfFilters;
         else
            dataOffset += 2 * frameSize;

         coaddData.numProcessedPixels += ACT_MAX_PIX_DATA_TO_PROCESS;
         if (coaddData.numProcessedPixels % numPixels == 0)
            ACT_INF( "Computing average step %d/%d... (@%d ms)", coaddData.numProcessedPixels/numPixels, numPixelsToProcess/numPixels, (uint32_t) elapsed_time_us( tic_AvgDuration ) / 1000 );

         if (++coaddData.currentCount == coaddData.NCoadd)
         {
            pixelOffset += ACT_MAX_PIX_DATA_TO_PROCESS; // once a block is finished, advance the pixel index
            dataOffset = 0;
            coaddData.currentCount = 0;
         }

         if (coaddData.numProcessedPixels == numPixelsToProcess)
         {
            if (gActDebugOptions.verbose)
            {
               float etime = (float) (elapsed_time_us( tic_AvgDuration )) / ((float)TIME_ONE_SECOND_US);
               ACT_INF( "Computing average took %d ms", (uint32_t)elapsed_time_us( tic_AvgDuration )/1000);
               ACT_INF( "Computing average took " _PCF(2) " s", _FFMT(etime, 2) );
               ACT_INF( "Computing average took " _PCF(2) " us/px", _FFMT((float) (elapsed_time_us( tic_AvgDuration )) / ((float)numPixelsToProcess), 2) );

               ACT_INF( "Computing average took (real time) " _PCF(2) " s", _FFMT((float) (tic_RT_Duration) / ((float)TIME_ONE_SECOND_US), 2) );
               ACT_INF( "Computing average took (real time) " _PCF(2) " us/px", _FFMT((float) (tic_RT_Duration) / ((float)numPixelsToProcess), 2) );
            }

            if (gActDebugOptions.useDebugData)
            {
               // validate sum
               validateAverage(mu_buffer, frameSize, expectedSum);
            }

            setActState(&state, ACT_ComputeBlackBodyFCal);
         }
      }
      break;

      case ACT_ComputeBlackBodyFCal:
      {
         uint32_t i50; // index of the median element
         float medianFCal; // estimated from image (median of image)
         float Tmin, Tmax; // range of the LUTRQ
         uint32_t lutAddr;

         if (usingICU)
         {
            T_BB = C_TO_K(ICUTemp);
            ACT_INF( "T_BB (ICU) is " _PCF(3) " K", _FFMT(T_BB,3));
         }
         else
         {
            T_BB = C_TO_K(gcRegsData.ExternalBlackBodyTemperature);
            ACT_INF( "T_BB (ext BB) is " _PCF(3) " K", _FFMT(T_BB,3));
         }

         if (gActDebugOptions.useDebugData)
            T_BB = test_data.TcalBB_test;

         currentDeltaBeta->info.referenceTemperature = T_BB; // [K]

         // Compute FCal scale according to exposure time. We apply it to FCalBB to save on floating point operations
         scaleFCal = currentDeltaBeta->info.exposureTime * blockInfo->NUCMultFactor * coaddData.NCoadd; // CR_WARNING exposure time is assumed to be in µs

         // Compute sqrt(FCalBB)
         // find the index of the LUT which has the ICU type
         LUTRQInfo_t* lutInfo = selectLUT(blockInfo, RQT_RT);
         lutAddr = XPAR_RQC_LUT_AXI_BASEADDR + (blockIdx * RQC_LUT_PAGE_SIZE);
         if (lutInfo == NULL)
         {
            ACT_ERR("Could not find a valid LUT RQT_RT in the %s block.", usingICU?"reference":"calibration");
            GC_GenerateEventError(EECD_ImageCorrectionInvalidReferenceBlock);
            error = true;
            break;
         }

         Tmin = applyLUT(lutAddr, lutInfo, lutInfo->LUT_Xmin);
         Tmax = applyLUT(lutAddr, lutInfo, lutInfo->LUT_Xmin+lutInfo->LUT_Xrange);

         ACT_PRINTF( "Tmin = " _PCF(3) " K, Tmax = " _PCF(3) " K\n", _FFMT(Tmin,3), _FFMT(Tmax,3) );

         if ((T_BB < Tmin || T_BB > Tmax) && currentDeltaBeta->info.discardOffset == 0)
         {
            ACT_INF( "T_BB out of LUT range, forcing zero-mean correction");
            currentDeltaBeta->info.discardOffset = 1;
         }

         // Initialize number of data to process and data pointers
         p_PixData = mu_buffer + imageDataOffset; // skip the header lines (2 rows)
         p_Data = (uint32_t*)(PROC_MEM_PIXEL_DATA_BASEADDR + (blockIdx * CM_CALIB_BLOCK_PIXEL_DATA_SIZE)); // adresse des données de calibration

         ACT_PRINTF( "p_Data = 0x%08X\n", p_Data  );
         ACT_PRINTF( "PixData(0) = %d\n", *p_PixData );

         if (currentDeltaBeta->info.discardOffset)
         {
            uint32_t numBadPixels = MIN(numPixels, countBadPixels((uint64_t*)p_Data, numPixels));

            ACT_INF( "numBadPixels in block %d: %d", blockIdx, numBadPixels);

            // compute the index of the median sample in the sorted array, not counting bad pixels, which are all falling in the high range of the array
            i50 = 0.50f * (float)(numPixels - numBadPixels);
            medianFCal = nth_element_i(p_PixData, prctile_buffer, numPixels, i50);

            ACT_INF( "Using FCal from median (index : %d)", i50);

            FCalBB = medianFCal;
         }
         else
         {
            FCalBB = applyReverseLUT(lutAddr, lutInfo, T_BB, gActDebugOptions.verbose); // is a sqrt

            // Compute FCalBB = sqrt(FCalBB)^ 2
            FCalBB *= FCalBB;

            ACT_INF( "Using FCal from T_BB");

            FCalBB *= scaleFCal;    // this saves a bunch of floating point operations later
         }

         ACT_PRINTF( "FCal = " _PCF(4) "\n", _FFMT(FCalBB/scaleFCal,4));
         ACT_INF( "Computing FCal done (%dms)", (uint32_t) elapsed_time_us( tic_TotalDuration ) / 1000 );

         // Compute Alpha LSB
         Alpha_LSB = exp2f( (float) blockInfo->pixelData.Alpha_Exp );

         tic_RT_Duration = 0;

         ctxtInit(&blockContext, 0, numPixels, 100*ACT_MAX_PIX_DATA_TO_PROCESS);

         setActState(&state, ACT_ComputeDeltaBeta);
      }
      break;

      case ACT_ComputeDeltaBeta:
      {
         uint64_t t0;
         uint64_t calData;
         GETTIME(&t0);

         // Apply beta correction, 2 pixels at a time
         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; i+=2, k+=2)
         {
            FCal = (float)*p_PixData++;
            calData = (uint64_t)*p_Data++;
            calData |= ((uint64_t)*p_Data++ << 32);
            computeDeltaBeta(&calData, FCal, FCalBB, Alpha_LSB, scaleFCal, blockInfo, &currentDeltaBeta->deltaBeta[k], NULL);

            FCal = (float)*p_PixData++;
            calData = (uint64_t)*p_Data++;
            calData |= ((uint64_t)*p_Data++ << 32);
            computeDeltaBeta(&calData, FCal, FCalBB, Alpha_LSB, scaleFCal, blockInfo, &currentDeltaBeta->deltaBeta[k+1], NULL);
         }

         ctxtIterate(&blockContext);

         tic_RT_Duration += elapsed_time_us(t0);

         if (ctxtIsDone(&blockContext))
         {
            ACT_INF( "Computing delta beta took (real time) " _PCF(2) " s", _FFMT((float) (tic_RT_Duration) / ((float)TIME_ONE_SECOND_US), 2) );
            ACT_INF( "Computing delta beta (real time) " _PCF(2) " us/px", _FFMT((float) (tic_RT_Duration) / ((float)(numPixels * coaddData.NCoadd)), 2) );

            tic_RT_Duration = 0;

            if (currentDeltaBeta->saturatedDataCount > 0)
            {
               ACT_INF("%d pixel value(s) reached saturation value during delta beta measurement", currentDeltaBeta->saturatedDataCount);
            }

            if (usingICU) // update bad pixel map only if using ICU
            {
               currentDeltaBeta->valid = 1;  // doit être updaté avant détection bad pixel
               gStartBadPixelDetection = 1;
               setActState(&state, ACT_DetectBadPixels);
            }
            else
            {
               ctxtInit(&blockContext, 0, numPixels, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
               if (gActBPMapAvailable == true)
                  setActState(&state, ACT_ApplyBadPixelMap);
               else
                  setActState(&state, ACT_ComputeDeltaBetaStats);
            }
         }
      }
      break;

      case ACT_DetectBadPixels:
         detectionStatus = BadPixelDetection_SM(blockIdx);    // returns DONE if disabled

         if (detectionStatus == IRC_DONE)
         {
            ctxtInit(&blockContext, 0, numPixels, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
            if (gActBPMapAvailable == true)
               setActState(&state, ACT_ApplyBadPixelMap);
            else
               setActState(&state, ACT_ComputeDeltaBetaStats);
         }

         if (detectionStatus == IRC_FAILURE)
            error = true;

         break;

      case ACT_ApplyBadPixelMap:
      {
         float* deltaBeta = &currentDeltaBeta->deltaBeta[blockContext.startIndex];

         for (i=0, k=blockContext.startIndex+imageDataOffset; i<blockContext.blockLength; ++i, ++k)
         {
            if (badPixelMap[k] != 0)
               *deltaBeta = infinityf();

            ++deltaBeta;
         }

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            ctxtInit(&blockContext, 0, numPixels, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
            setActState(&state, ACT_ComputeDeltaBetaStats);
         }
      }
      break;

      case ACT_ComputeDeltaBetaStats:
      {
         uint64_t t0; // just for benchmarking

         if (blockContext.blockIdx == 0) // first iteration
         {
            tic_RT_Duration = 0;
            resetStats(&currentDeltaBeta->stats);
         }

         GETTIME(&t0);

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            float x = currentDeltaBeta->deltaBeta[k];
            if (!isinf(x)) // only count pixels that are not bad according to the reference block for computing the stats
            {
               updateStats(&currentDeltaBeta->stats, x);
            }
         }

         tic_RT_Duration += elapsed_time_us(t0);

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            float p50;
            int i50 = 0.50f * numPixels; // index of the median

            GETTIME(&t0);

            // compute the median (can not be split over multiple block operations)
            p50 = nth_element_f(currentDeltaBeta->deltaBeta, currentDeltaBeta->stats.min, (float*)prctile_buffer, numPixels, i50);

            currentDeltaBeta->p50 = p50;

            tic_RT_Duration += elapsed_time_us(t0);

            if (gActDebugOptions.verbose)
            {
               reportStats(&currentDeltaBeta->stats, "DeltaBeta");
               ACT_INF( "Median value : " _PCF(6), _FFMT(p50, 6));
            }
            ACT_INF( "Computing delta beta stats (real time) " _PCF(2) " s", _FFMT((float)tic_RT_Duration/((float)TIME_ONE_SECOND_US), 2));

            gWriteActualizationFile = 1;
            setActState(&state, ACT_WriteActualizationFile);
         }
      }
      break;

      case ACT_WriteActualizationFile:
         writeStatus = ActualizationFileWriter_SM(currentDeltaBeta);    // returns DONE even if failed to write the file

         if (writeStatus == IRC_DONE)
         {
            // enable beta correction upon loading a calibration block
            currentDeltaBeta->valid = 1;

            // now the actualisation timestamp becomes valid
            currentDeltaBeta->info.POSIXTime = privateActualisationPosixTime;
            currentDeltaBeta->info.age = 0;

            // Verify if other blocks have to be actualized
            blockIdx++;
            if (blockIdx >= actBlocks)
               setActState(&state, ACT_Finalize);
            else if (actSyncFW)
               setActState(&state, ACT_InitComputation);    // Loop only on computation states
            else
            {
               StartTimer(&act_timer, ACT_WAIT_FOR_DATA_TIMEOUT/1000);  // calibration is already loaded
               setActState(&state, ACT_WaitForCalibData);   // Loop on the whole process
            }
         }

         if (writeStatus == IRC_FAILURE)
            error = true;

         break;

      case ACT_Finalize:
         // Wait for ICU to be back in scene position (no waiting time if using an external BB)
         if (!usingICU || (gcRegsData.ICUPosition == ICUP_Scene))
         {
            // Beta correction is done
            rtnStatus = IRC_DONE;

            allowCalibUpdate = true; // re-enable the calibration update

            builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Passed;

            ACT_INF( "image correction completed in " _PCF(2) " s", _FFMT(elapsed_time_us((float)tic_TotalDuration) / ((float)TIME_ONE_SECOND_US), 2));

            // Restore registers value
            ACT_restoreGCRegisters( &GCRegsBackup );

            // Reload original calibration data (will update the calibration at the same time)
            if (savedCalibPosixTime != 0)
            {
               // make sure we activate the correct block index, because reloading a collection always makes block 0 the active one
               gActualisationLoadBlockIdx = savedCurrentBlockIdx;
               Calibration_LoadCalibrationFilePOSIXTime(savedCalibPosixTime);
            }

            TDCStatusClr(WaitingForImageCorrectionMask);

            if (usingICU)
               ACT_invalidateActualizations(ACT_XBB);

            // Reset state machine
            setActState(&state, ACT_Idle);
         }
         break;
   }

   if (gStopActualization)
   {
      gStopActualization = false;
      error = true;
      ACT_ERR("Image correction process was interrupted by user.");
   }


   if (error == true)
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("An error occurred. No calibration update was generated. Reverting to initial parameters.");
      allowCalibUpdate = true;

      // Invalidate only the current delta beta
      if (currentDeltaBeta != NULL)
         currentDeltaBeta->valid = 0;

      // Restore registers value
      ACT_restoreGCRegisters( &GCRegsBackup );

      ICU_scene(&gcRegsData, &gICU_ctrl);

      GC_SetAcquisitionStop(1);

      // Reload original calibration data (will update the calibration at the same time)
      if (savedCalibPosixTime != 0)
      {
         // make sure we activate the correct block index, because reloading a collection always makes block 0 the active one
         gActualisationLoadBlockIdx = savedCurrentBlockIdx;
         Calibration_LoadCalibrationFilePOSIXTime(savedCalibPosixTime);
      }

      TDCStatusClr(WaitingForImageCorrectionMask);

      // Reset state machine
      setActState(&state, ACT_Idle);

      rtnStatus = IRC_FAILURE;
   }

   return rtnStatus;
}

IRC_Status_t BadPixelDetection_SM(uint8_t blockIdx)
{
   static BPD_State_t state = BPD_Idle;
   static BPD_StatData_t statData;

   static timerData_t verbose_timeout;
   static timerData_t bpd_timer;
   uint64_t t0; // for RT benchmarking
   static uint64_t tic_TotalDuration; // used for benchmarking the total time
   static uint64_t tic_RT_Duration; // used for benchmarking the actual time taken for building the statistics

   static uint32_t dataOffset;
   static uint32_t sequenceOffset; // start of the first image of the buffered sequence [bytes]

   static context_t blockContext; // information structure for block processing
   static uint64_t mu_R; // sample mean of the range R
   static int64_t mu_Z;
   static uint32_t N_mu; // number of good pixels in block
   static uint32_t noiseThreshold;
   static int32_t flickerThreshold2;
   static int32_t flickerThreshold1;
   static uint32_t outlierThreshold1;
   static uint32_t outlierThreshold2;
   static uint32_t outlierThreshold;

   static uint16_t* data_buffer = NULL; // address of the image sequence in DDR
   static actBuffers_t actDataBuffers;

   static uint32_t numberOfBadPixels = 0;
   static uint32_t numberOfNoisy = 0;
   static uint32_t numberOfFlickers = 0;
   static uint32_t numberOfOutliers = 0;

   static deltabeta_t* currentDeltaBeta = NULL;

   static const uint32_t frameSize = (FPA_HEIGHT_MAX + 2) * FPA_WIDTH_MAX;
   static const uint32_t imageDataOffset = 2*FPA_WIDTH_MAX; // number of header pixels to skip [pixels]
   static const uint32_t numPixels = FPA_HEIGHT_MAX * FPA_WIDTH_MAX;
   uint32_t numFramesToSkip;// number of frames to skip at the beginning, corresponding to the AEC transient -> a number of time constants
   static int intBufSeqSize;

   bool error = false;

   int i, k;
   IRC_Status_t rtnStatus = IRC_NOT_DONE;

   if (gActDebugOptions.disableBPDetection || gActualizationParams.badPixelsDetection == 0)
   {
      gStartBadPixelDetection = false;
      gActBPMapAvailable = false;
      return IRC_DONE;
   }

   switch (state)
   {
   case BPD_Idle:
      if (gStartBadPixelDetection)
      {
         ACT_resetParams(&gActualizationParams);

         gStartBadPixelDetection = false;
         gActBPMapAvailable = false;

         ICU_calib(&gcRegsData, &gICU_ctrl);

         statData.currentCount = 0;
         statData.numProcessedPixels = 0;
         dataOffset = 0; // position of the pointer for running average [bytes]

         //ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);

         sequenceOffset = PROC_MEM_MEMORY_BUFFER_BASEADDR;

         // if debug mode is ON, the first few images are used as buffers for intermediate results
         if (gActDebugOptions.clearBufferAfterCompletion == false)
         {
            sequenceOffset += ACT_NUM_DEBUG_FRAMES * 2 * frameSize;

            actDataBuffers.m = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 0 * frameSize * 2);
            actDataBuffers.M = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 1 * frameSize * 2);
            actDataBuffers.mu = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 2 * frameSize * 2);
            actDataBuffers.R = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 3 * frameSize * 2);
            actDataBuffers.Z = (int32_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 4 * frameSize * 2);
            actDataBuffers.bpMap = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 6 * frameSize * 2);
            actDataBuffers.deltaBeta = (float*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + 7 * frameSize * 2);

            actDataBuffers.length = frameSize;
         }

         memset(mu_buffer, 0, frameSize * sizeof(uint32_t));
         memset(max_buffer, 0, frameSize * sizeof(uint16_t));
         memset(min_buffer, UINT16_MAX, frameSize * sizeof(uint16_t));
         memset(badPixelMap, 0, frameSize * sizeof(uint8_t));

         numberOfBadPixels = 0;
         numberOfNoisy = 0;
         numberOfFlickers = 0;
         numberOfOutliers = 0;

         GETTIME(&tic_TotalDuration);
         tic_RT_Duration = 0;
         StartTimer(&verbose_timeout, 10000);
         StartTimer(&bpd_timer, 1000);

         // trouver le deltaBeta ICU
         currentDeltaBeta = findMatchingDeltaBetaForBlock(&calibrationInfo, blockIdx);
         if (currentDeltaBeta != NULL && currentDeltaBeta->valid)
         {
            ctxtInit(&blockContext, 0, numPixels, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
            setBpdState(&state, BPD_ComputeDeltaBetaStats);
         }
         else
         {
            if (currentDeltaBeta == NULL)
            {
               ACT_ERR("No actualisation data was found for bad pixel detection (pointer is NULL)");
            }
            else if (!currentDeltaBeta->valid)
            {
               ACT_ERR("No valid actualisation data was found for bad pixel detection (valid == FALSE).");
            }

            ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
            setBpdState(&state, BPD_StartAcquisition);
         }
      }

      break;

   case BPD_ComputeDeltaBetaStats:
      {
         uint64_t t0; // just for benchmarking

         if (blockContext.blockIdx == 0) // first iteration
         {
            tic_RT_Duration = 0;
            resetStats(&currentDeltaBeta->stats);
         }

         GETTIME(&t0);

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            float x = currentDeltaBeta->deltaBeta[k];
            if (!isinf(x)) // only count pixels that are not bad according to the reference block for computing the stats
            {
               updateStats(&currentDeltaBeta->stats, x);
            }
         }

         tic_RT_Duration += elapsed_time_us(t0);

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            float p50;
            int i50 = 0.50f * numPixels; // index of the median

            GETTIME(&t0);

            // compute the median (can not be split over multiple block operations)
            p50 = nth_element_f(currentDeltaBeta->deltaBeta, currentDeltaBeta->stats.min, (float*)prctile_buffer, numPixels, i50);

            currentDeltaBeta->p50 = p50;

            tic_RT_Duration += elapsed_time_us(t0);

            if (gActDebugOptions.verbose)
            {
               reportStats(&currentDeltaBeta->stats, "DeltaBeta (pre-bad pixel detection)");
               ACT_INF( "BPD median value : " _PCF(6), _FFMT(p50, 6));
            }
            ACT_INF( "BPD_ComputeDeltaBetaStats took (real time) " _PCF(2) " s", _FFMT((float)tic_RT_Duration/((float)TIME_ONE_SECOND_US), 2));

            setBpdState(&state, BPD_UpdateBeta);
         }
      }
      break;

   case BPD_UpdateBeta:
      {
         uint32_t* calAddr = (uint32_t*)(PROC_MEM_PIXEL_DATA_BASEADDR + (blockIdx * CM_CALIB_BLOCK_PIXEL_DATA_SIZE)); // CR_TRICKY the pointer is in 32-bit elements (64 bits per pixel data)

         ACT_updateCurrentCalibration(&calibrationInfo.blocks[blockIdx], &calAddr[blockContext.startIndex*2], currentDeltaBeta, blockContext.startIndex, blockContext.blockLength);
         calibrationInfo.blocks[blockIdx].CalibrationSource = CS_ACTUALIZED;

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            // prepare next processing context
            ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);

            ACT_INF( "BPD_UpdateBeta took " _PCF(2) " s", _FFMT((float) (elapsed_time_us( tic_TotalDuration)) / ((float)TIME_ONE_SECOND_US), 2) );

            setBpdState(&state, BPD_StartAcquisition);
         }

      }
      break;

   case BPD_StartAcquisition:

      // Ensure that no acquisition is running, cooldown period is over and camera is powered on
      if (!GC_AcquisitionStarted)
      {
         float frameRate;

         // Prepare acquisition -> full width
         GC_SetWidth(gcRegsData.SensorWidth);
         GC_SetHeight(gcRegsData.SensorHeight);
         GC_SetOffsetX(0);
         GC_SetOffsetY(0);

         frameRate = 1000.0F * gActualizationParams.numFrames / gActualizationParams.duration;
         if (frameRate > gcRegsData.AcquisitionFrameRateMax)
         {
            ACT_ERR("Required frame rate of bad pixel identification is invalid (" _PCF(2) " > " _PCF(2) "). The recording duration will be adjusted accordingly.",
                  _FFMT(frameRate, 2), _FFMT(gcRegsData.AcquisitionFrameRateMax, 2));
            frameRate = gcRegsData.AcquisitionFrameRateMax;
            gActualizationParams.duration = gActualizationParams.numFrames / frameRate * 1000;
         }
         GC_SetAcquisitionFrameRate(frameRate);

         // Setup an AEC
         GC_SetAECTargetWellFilling(flashSettings.BPAECWellFilling);
         GC_SetAECResponseTime(flashSettings.BPAECResponseTime);
         GC_SetAECImageFraction(flashSettings.BPAECImageFraction);
         GC_SetExposureAuto(EA_Continuous);

         // compute the number of frames to skip (5 times the time constant)
         numFramesToSkip = ceilf(5 * flashSettings.BPAECResponseTime/1000.0f * frameRate);
         sequenceOffset += numFramesToSkip * frameSize * 2;

         if (gActDebugOptions.verbose)
         {
            ACT_INF( "BPD Frame rate : " _PCF(2) " Hz", _FFMT(frameRate, 2));
            ACT_INF( "BPD using %d frames for AEC transient", numFramesToSkip);
         }

         GC_SetCalibrationMode(CM_NUC);

         // setup buffering

         // configurer le buffering pour coaddData.NCoadd images
         // always using the internal buffer
         intBufSeqSize = gActualizationParams.numFrames + numFramesToSkip;
         if (gActDebugOptions.clearBufferAfterCompletion == 0)
            intBufSeqSize += ACT_NUM_DEBUG_FRAMES;

         BufferManager_HW_ForceDirectInternalBufferWriteConfig(&gBufManager, &gcRegsData, 1, intBufSeqSize, 0);

         float timeout = 1000 * intBufSeqSize/gcRegsData.AcquisitionFrameRate;
         StartTimer(&bpd_timer, timeout + ACT_WAIT_FOR_SEQ_TIMEOUT/1000);

         // Start acqusition
         GC_SetAcquisitionStart(1);

         setBpdState(&state, BPD_WaitSequenceReady);
      }
      else if (TimedOut(&bpd_timer))
      {
         ACT_ERR( "Timeout while waiting for acquisition stop.");
         GC_GenerateEventError(EECD_ImageCorrectionAcquisitionTimeout);
         error = true;
      }

      break;

   case BPD_WaitSequenceReady:

      if (TimedOut(&verbose_timeout))
      {
         ACT_INF("Acquiring data for bad pixel detection...");
         RestartTimer(&verbose_timeout);
      }

      if (GC_AcquisitionStarted && BM_HW_GetLocalWriteSeqCompleted(&gBufManager))
      {
         // CR_WARNING : because the sequence count increments at the *beginning* of the last frame,
         // wait at least for the duration of two frames to make sure we have all the frames before we start computation
         StartTimer(&bpd_timer, 2000.0/gcRegsData.AcquisitionFrameRate);
         setBpdState( &state, BPD_FinalizeSequence );
      }
      else if (TimedOut(&bpd_timer))
      {
         ACT_ERR( "Timeout while acquiring buffer sequence (number of sequences = %d).", BM_HW_GetLocalSequenceCount(&gBufManager));
         GC_GenerateEventError(EECD_ImageCorrectionAcquisitionTimeout);
         error = true;
      }

      break;

   case BPD_FinalizeSequence:
      if (TimedOut(&bpd_timer))
      {
         // Stop acquisition
         GC_SetAcquisitionStop(1);
         if (GC_AcquisitionStarted == 0)
         {
            int sequenceLength = BufferManager_HW_GetDirectInternalBufferSequenceRecordedSize(&gBufManager, 0);
            ACT_PRINTF( "Sequence buffer acquisition done (%d ms)\n", (uint32_t) elapsed_time_us( tic_TotalDuration ) / 1000 );

            if (sequenceLength != intBufSeqSize)
            {
               ACT_ERR("Number recorded of frames mismatch (actual=%d vs requested=%d)\n", sequenceLength, intBufSeqSize);
               error = true;
            }

            // Move the ICU back to scene position
            ICU_scene(&gcRegsData, &gICU_ctrl);

            GETTIME(&tic_TotalDuration);

            ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
            setBpdState(&state, BPD_ComputeStatistics);
         }
      }

      break;

   case BPD_ComputeStatistics:
      {
         data_buffer = (uint16_t*) (sequenceOffset + dataOffset + blockContext.startIndex * 2);

         GETTIME(&t0);

         if (statData.currentCount == 0) // on the first iteration, make the max and the min identical
         {
            for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
            {
               const uint16_t x = data_buffer[i];
               max_buffer[k] = x;
               min_buffer[k] = x;
               mu_buffer[k] = x;
            }
         }
         else
         {
            uint32_t* data32 = (uint32_t*)data_buffer;
            uint32_t* min32 = (uint32_t*)(min_buffer + blockContext.startIndex);
            uint32_t* max32 = (uint32_t*)(max_buffer + blockContext.startIndex);

            for (i=0, k=blockContext.startIndex; i<blockContext.blockLength/2; ++i, k+=2)
            {
#define _HI16(x) (x & 0xFFFF0000)
#define _LO16(x) (x & 0x0000FFFF)
#define MSB(x) (x >> 16)
#define LSB(x) (x & 0x0000FFFF)

               uint32_t x = data32[i];
               uint32_t m = min32[i];
               uint32_t M = max32[i];
               uint32_t xl;

               xl = _LO16(x);

               // find min/max
               if (xl > _LO16(M))
               {
                  max_buffer[k] = LSB(x);
               }
               else if (xl < _LO16(m))
               {
                  min_buffer[k] = LSB(x);
               }

               if (x > M)
               {
                  max_buffer[k+1] = MSB(x);
               }
               else if (x < m)
               {
                  min_buffer[k+1] = MSB(x);
               }

               // accumulate
               if (statData.currentCount < gActualizationParams.flickersNCoadd)
               {
                  mu_buffer[k] += LSB(x);
                  mu_buffer[k+1] += MSB(x);
               }
            }
         }
      }
      tic_RT_Duration += elapsed_time_us(t0);

      ctxtIterate(&blockContext);

      if (TimedOut(&verbose_timeout))
      {
         ACT_INF("BPD computing statistics %d/%d...", statData.currentCount, gActualizationParams.BPNumSamples);
         RestartTimer(&verbose_timeout);
      }

      if (ctxtIsDone(&blockContext))
      {
         // go to next frame -> step is in bytes
         dataOffset += 2 * frameSize;

         ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);

         ++statData.currentCount;

         if (statData.currentCount == gActualizationParams.BPNumSamples)
         {
            ACT_INF( "BPD_ComputeStatistics took " _PCF(2) " s", _FFMT((float)tic_RT_Duration / ((float)TIME_ONE_SECOND_US), 2) );
            tic_RT_Duration = 0;

            setBpdState(&state, BPD_BuildCriteria);
         }
      }

      break;

   case BPD_BuildCriteria:
      {
         const int Ndiv2 = gActualizationParams.flickersNCoadd/2;
         //const int N = gActualizationParams.flickersNCoadd;

         GETTIME(&t0);

         // compute 2 * mu by dividing the accumulated array by (N/2)

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            uint16_t m, M;
            int32_t mu_x2;

            m = min_buffer[k];
            M = max_buffer[k];
            mu_x2 = mu_buffer[k] / Ndiv2;

            R_buffer[k] = M - m;
            Z_buffer[k] = M + m - mu_x2;
         }

         ctxtIterate(&blockContext);

         tic_RT_Duration += elapsed_time_us(t0);

         if (ctxtIsDone(&blockContext))
         {
            ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);

            ACT_INF( "BPD_BuildCriteria took " _PCF(2) " s", _FFMT((float)tic_RT_Duration / ((float)TIME_ONE_SECOND_US), 2) );

            tic_RT_Duration = 0;
            setBpdState(&state, BPD_AdjustThresholds);
         }
      }
      break;

   case BPD_AdjustThresholds:
      {
         const uint32_t maxValidValue = 0xFFF0;

         GETTIME(&t0);
         // compute the 1st order moment of the range, which equals mu_R = mu_R0 * sigma_x

         if (blockContext.blockIdx == 0)
         {
            mu_R = 0;
            mu_Z = 0;
            N_mu = 0;
         }

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            // do not use bad pixels
            if (max_buffer[k] <= maxValidValue)
            {
               mu_R += R_buffer[k];
               mu_Z += Z_buffer[k];
               ++N_mu;
            }
         }

         ctxtIterate(&blockContext);

         tic_RT_Duration += elapsed_time_us(t0);

         if (ctxtIsDone(&blockContext))
         {
            ctxtInit(&blockContext, imageDataOffset, frameSize, 100*ACT_MAX_PIX_DATA_TO_PROCESS);

            if (N_mu > 1)
            {
               mu_R /= N_mu;
               mu_Z /= N_mu;
            }

            const float IQR_to_sigma = 20.0f/27; // IQR \approx 27/20 x \sigma
            uint32_t IQR; // inter-quantile range, used for estimating the std of the spatial distribution
            uint32_t sigma_mu; // std of the spatial average distribution
            int i50 = 0.50f * numPixels; // index of the median
            int i25 = 0.25f * numPixels; // index of the 1st quartile
            int i75 = 0.75f * numPixels; // index of the 3rd quartile
            uint32_t p25,p50,p75; // percentiles

            ACT_PRINTF( "(BPD_AdjustThresholds) i25=%d, i50=%d, i75=%d\n", i25, i50, i75);

            if (N_mu > 100)
            {
               // the order of these 3 calls is important!
               // since select() modifies the input array
               memcpy(prctile_buffer, mu_buffer + imageDataOffset, numPixels * sizeof(uint32_t));
               p75 = select(prctile_buffer, 0, numPixels-1, i75);
               p50 = select(prctile_buffer, 0, i75, i50);
               p25 = select(prctile_buffer, 0, i50, i25);
            }
            else
            {
               ACT_ERR("Abnormaly high number of bad pixels (%d/%d)", numPixels - N_mu, numPixels);
               p25 = 25;
               p50 = 100;
               p75 = 75;
               error = true;
            }
            IQR = p75 - p25;
            sigma_mu = (float)IQR * IQR_to_sigma;

            tic_RT_Duration += elapsed_time_us(t0);

            // compute thresholds based on the actual data statistics
            // multiply it by the normalized threshold parameter
            noiseThreshold = (float)mu_R * gActualizationParams.noiseThreshold;
            flickerThreshold1 = -(float)mu_R * gActualizationParams.flickerThreshold + (float)mu_Z;
            flickerThreshold2 = (float)mu_R * gActualizationParams.flickerThreshold + (float)mu_Z;
            outlierThreshold = flashSettings.BPOutlierThreshold * sigma_mu;
            outlierThreshold1 = p50 - outlierThreshold;
            outlierThreshold2 = p50 + outlierThreshold;

            if (gActDebugOptions.verbose)
            {
               const int NCoadd = gActualizationParams.flickersNCoadd;
               ACT_INF( "p25, p50, p75 = %d, %d, %d", p25/NCoadd, p50/NCoadd, p75/NCoadd);
               ACT_INF( "mu_R = %d", (int32_t)mu_R);
               ACT_INF( "mu_Z = %d", (int32_t)mu_Z);
               ACT_INF( "N_mu = %d (number of good pixels in original block)", N_mu);
               ACT_INF( "sigma image (IQR-based) = %d", sigma_mu/NCoadd);
               ACT_INF( "noiseThreshold = %d", noiseThreshold);
               ACT_INF( "outlierThreshold = %d", outlierThreshold/NCoadd);
               ACT_INF( "flickerThreshold = +/-%d", (uint32_t)((float)mu_R * gActualizationParams.flickerThreshold));
               ACT_INF( "flickerThreshold1 = %d", flickerThreshold1);
               ACT_INF( "flickerThreshold2 = %d", flickerThreshold2);
            }
            ACT_INF( "BPD_AdjustThresholds took " _PCF(2) " s", _FFMT((float)tic_RT_Duration / ((float)TIME_ONE_SECOND_US), 2) );

            tic_RT_Duration = 0;
            setBpdState(&state, BPD_UpdateBPMap);
         }
      }

      break;

   case BPD_UpdateBPMap:
      {
         const uint8_t flicker_mask = 0x02;
         const uint8_t noisy_mask = 0x01;
         const uint8_t outlier_mask = 0x04;

         GETTIME(&t0);

         // build the bad pixel map. Do not process the header data
         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            uint8_t tag = 0;
            int32_t z_val = Z_buffer[k];

            if (R_buffer[k] > noiseThreshold)
            {
               tag |= noisy_mask;
               ++numberOfNoisy;
            }

            if (mu_buffer[k] < outlierThreshold1 || mu_buffer[k] > outlierThreshold2)
            {
               tag |= outlier_mask;
               ++numberOfOutliers;
            }

            if (z_val < flickerThreshold1 || z_val > flickerThreshold2)
            {
               tag |= flicker_mask;
               ++numberOfFlickers;
            }

            badPixelMap[k] = tag;

            numberOfBadPixels += (tag != 0);
         }

         tic_RT_Duration += elapsed_time_us(t0);

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            gActBPMapAvailable = true;

            ACT_INF( "bad pixel map duration (real-time) : " _PCF(2) " s", _FFMT((float)tic_RT_Duration / ((float)TIME_ONE_SECOND_US), 2) );
            ACT_INF( "Bad pixel detection took (real-time) " _PCF(2) " us/px", _FFMT((float) (elapsed_time_us( tic_TotalDuration )) / ((float)frameSize * gActualizationParams.BPNumSamples), 2) );
            ACT_INF( "Bad pixel detection took " _PCF(2) " s", _FFMT((float) (elapsed_time_us( tic_TotalDuration)) / ((float)TIME_ONE_SECOND_US), 2) );
            ACT_INF( "number of bad pixels found : %d (%d noisy, %d flickers, %d outliers)", numberOfBadPixels, numberOfNoisy, numberOfFlickers, numberOfOutliers);

            if (gActDebugOptions.clearBufferAfterCompletion == false)
               setBpdState(&state, BPD_DebugState);
            else
            {
               ICU_scene(&gcRegsData, &gICU_ctrl);
               setBpdState(&state, BPD_Idle);
               rtnStatus = IRC_DONE;
            }
         }
      }
         break;

   case BPD_DebugState:
      {
         const int N = gActualizationParams.flickersNCoadd;

         // dans cet état, on copie les images de calcul dans le buffer externe

         for (i=imageDataOffset; i<frameSize; ++i)
         {
            actDataBuffers.m[i] = min_buffer[i];
            actDataBuffers.M[i] = max_buffer[i];
            actDataBuffers.mu[i] = mu_buffer[i]/N;
            actDataBuffers.R[i] = R_buffer[i];
            actDataBuffers.Z[i] = Z_buffer[i];
            actDataBuffers.bpMap[i] = (uint16_t)badPixelMap[i];
            actDataBuffers.deltaBeta[i] = currentDeltaBeta->deltaBeta[i-imageDataOffset];
         }

         setBpdState(&state, BPD_Idle);
         rtnStatus = IRC_DONE;
      }
      break;

   default:
      ACT_ERR("Unknown BPD state (%d)", state);
      rtnStatus = IRC_FAILURE;
   }

   if (error == true)
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("An error occurred during bad pixel detection. No bad pixels were identified.");
      gActBPMapAvailable = false;
      allowCalibUpdate = true;

      ICU_scene(&gcRegsData, &gICU_ctrl);

      GC_SetAcquisitionStop(1);

      // Reset state machine
      setBpdState(&state, BPD_Idle);

      rtnStatus = IRC_FAILURE;
   }

   return rtnStatus;
}

void updateMoments(float* m1, float* m2, float* m3, float x, uint32_t N)
{
   float m1_1d, m2_1d, delta, delta2, tmp;

   static int N_ = 0;
   static float N_inv;
   static float K;

   if (N != N_)
   {
      N_inv = 1.0F/N;
      N_ = N;
      K = 1.0F - N_inv;//(float)(N-1)/N;
   }

   m1_1d = *m1;
   m2_1d = *m2;

   delta = x - m1_1d;
   delta2 = delta * delta;

   // update average value : mu_n = mu_(n-1) + (x_n + mu_(n-1))/n
   *m1 += delta * N_inv;///N;

   // update second-order moment : M2_n = M2_(n-1) + (n-1)/n * (d_n)^2, d_n = x_n - mu_(n-1)
   tmp = K;//(float)(N-1)/N;
   *m2 += tmp * (delta2);

   // update the third-order moment : M3_n = M3_(n-1) + (n-1)*(n-2)/n^2 * (d_n)^3 - 3/n*d_n*M2_(n-1), d_n = x_n - mu_(n-1)
   if (N>=2)
      *m3 += (float)(N-2)*tmp * N_inv * (delta2 * delta) - 3.0*delta * m2_1d * N_inv;
}

void testMomentComputations()
{
   int N = 0;
   int Nmax = 1000;
   float m1, m2, m3;
   float x;

   ACT_PRINTF("Running testMomentComputations()\n");

   m1 = 0;
   m2 = 0;
   m3 = 0;

   N = 0;
   while(N < Nmax)
   {
      x = (float)rand()/RAND_MAX;
      updateMoments(&m1, &m2, &m3, x, ++N);
   }

   ACT_PRINTF("1st-order moment : " _PCF(3) "\n", _FFMT(m1, 3));
   ACT_PRINTF("2nd-order moment : " _PCF(3) "\n", _FFMT(m2, 3));
   ACT_PRINTF("3rd-order moment : " _PCF(3) "\n", _FFMT(m3, 3));
}

/**
  *  This function backs up genicam registers that are modified during a
  *  calibration update.
  *
  *  This function accesses the global variable gcRegsData in read-only mode.
  *
  *  @param p_GCRegsBackup a pointer to the genicam registers subset
  *
  *  @return none
  */
static void ACT_backupGCRegisters( ACT_GCRegsBackup_t *p_GCRegsBackup )
{
   uint8_t i;

   p_GCRegsBackup->AcquisitionFrameRate = gcRegsData.AcquisitionFrameRate;
   p_GCRegsBackup->ExposureTime = gcRegsData.ExposureTime;
   p_GCRegsBackup->ExposureTime1 = gcRegsData.ExposureTime1;
   p_GCRegsBackup->ExposureTime2 = gcRegsData.ExposureTime2;
   p_GCRegsBackup->ExposureTime3 = gcRegsData.ExposureTime3;
   p_GCRegsBackup->ExposureTime4 = gcRegsData.ExposureTime4;
   p_GCRegsBackup->ExposureTime5 = gcRegsData.ExposureTime5;
   p_GCRegsBackup->ExposureTime6 = gcRegsData.ExposureTime6;
   p_GCRegsBackup->ExposureTime7 = gcRegsData.ExposureTime7;
   p_GCRegsBackup->ExposureTime8 = gcRegsData.ExposureTime8;
   p_GCRegsBackup->AECTargetWellFilling = gcRegsData.AECTargetWellFilling;
   p_GCRegsBackup->Width = gcRegsData.Width;
   p_GCRegsBackup->Height = gcRegsData.Height;
   p_GCRegsBackup->CalibrationMode = gcRegsData.CalibrationMode;
   p_GCRegsBackup->ExposureAuto = gcRegsData.ExposureAuto;
   p_GCRegsBackup->AECImageFraction = gcRegsData.AECImageFraction;
   p_GCRegsBackup->AECResponseTime = gcRegsData.AECResponseTime;
   p_GCRegsBackup->FWMode = gcRegsData.FWMode;
   p_GCRegsBackup->FWPositionSetpoint = gcRegsData.FWPositionSetpoint;
   p_GCRegsBackup->NDFilterPositionSetpoint = gcRegsData.NDFilterPositionSetpoint;
   p_GCRegsBackup->TestImageSelector = gcRegsData.TestImageSelector;
   p_GCRegsBackup->EHDRINumberOfExposures = gcRegsData.EHDRINumberOfExposures;
   p_GCRegsBackup->MemoryBufferMOISource = gcRegsData.MemoryBufferMOISource;
   p_GCRegsBackup->MemoryBufferMode = gcRegsData.MemoryBufferMode;
   p_GCRegsBackup->OffsetX = gcRegsData.OffsetX;
   p_GCRegsBackup->OffsetY = gcRegsData.OffsetY;
   p_GCRegsBackup->BadPixelReplacement = gcRegsData.BadPixelReplacement;
   for (i = 0; i < TriggerModeAryLen; i++)
      p_GCRegsBackup->TriggerModeAry[i] = TriggerModeAry[i];
}

/**
  *  This function restores genicam registers that have been modified during
  *  calibration update.
  *
  *  This function writes the global variable gcRegsData.
  *
  *  @param p_GCRegsBackup a pointer to the genicam registers subset
  *
  *  @return none
  */
static void ACT_restoreGCRegisters( ACT_GCRegsBackup_t *p_GCRegsBackup )
{
   uint8_t i;

   GC_SetWidth(p_GCRegsBackup->Width);
   GC_SetHeight(p_GCRegsBackup->Height);
   GC_SetOffsetX(p_GCRegsBackup->OffsetX);
   GC_SetOffsetY(p_GCRegsBackup->OffsetY);
   GC_SetFWMode(p_GCRegsBackup->FWMode);
   GC_SetEHDRINumberOfExposures(p_GCRegsBackup->EHDRINumberOfExposures);
   GC_SetAcquisitionFrameRate(p_GCRegsBackup->AcquisitionFrameRate);
   GC_SetExposureTime(p_GCRegsBackup->ExposureTime);
   GC_SetExposureTime1(p_GCRegsBackup->ExposureTime1);
   GC_SetExposureTime2(p_GCRegsBackup->ExposureTime2);
   GC_SetExposureTime3(p_GCRegsBackup->ExposureTime3);
   GC_SetExposureTime4(p_GCRegsBackup->ExposureTime4);
   GC_SetExposureTime5(p_GCRegsBackup->ExposureTime5);
   GC_SetExposureTime6(p_GCRegsBackup->ExposureTime6);
   GC_SetExposureTime7(p_GCRegsBackup->ExposureTime7);
   GC_SetExposureTime8(p_GCRegsBackup->ExposureTime8);
   GC_SetAECTargetWellFilling(p_GCRegsBackup->AECTargetWellFilling);
   GC_SetCalibrationMode(p_GCRegsBackup->CalibrationMode);
   GC_SetExposureAuto(p_GCRegsBackup->ExposureAuto);
   GC_SetAECImageFraction(p_GCRegsBackup->AECImageFraction);
   GC_SetAECResponseTime(p_GCRegsBackup->AECResponseTime);
   GC_SetFWPositionSetpoint(p_GCRegsBackup->FWPositionSetpoint);
   GC_SetNDFilterPositionSetpoint(p_GCRegsBackup->NDFilterPositionSetpoint);
   GC_SetTestImageSelector(p_GCRegsBackup->TestImageSelector);
   if (gActDebugOptions.clearBufferAfterCompletion)
      BufferManager_HW_ForceDirectInternalBufferWriteConfig(&gBufManager, &gcRegsData, 0, 0, 0); // Clear Hardware Buffer
   else
      BufferManager_HW_ForceLoadInternalBufferTable(&gBufManager, &gcRegsData); // Debug only : load hardware table to allow to read images used for actualization
   GC_SetMemoryBufferMOISource(p_GCRegsBackup->MemoryBufferMOISource);
   // IMPORTANT: Restore MemoryBufferMode AFTER clearing or downloading the buffer !!! (not before)
   GC_SetMemoryBufferMode(p_GCRegsBackup->MemoryBufferMode);
   BufferManager_HW_SetSwitchConfig(&gBufManager);

   GC_SetBadPixelReplacement(p_GCRegsBackup->BadPixelReplacement);
   for (i = 0; i < TriggerModeAryLen; i++)
      TriggerModeAry[i] = p_GCRegsBackup->TriggerModeAry[i];
}

/**
  *  This function computes y = m * x + b using a lookup table (LUT).
  *
  *  @param LUTDataAddr Address of the LUT m and b data (not a pointer)
  *  @param p_LUTInfo   Pointer to LUT info (XMin, XRange ... ).
  *  @param x           x value.
  *
  *  @return y value.
  *
  *   Note(s):
  *
  */
float applyLUT( uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float x )
{
   uint32_t i;
   float m, xi, bi, y;

   // i = int[ ( x - XMin ) * (Size) / XRange ]
   if (x >= p_LUTInfo->LUT_Xmin)
      i = (uint32_t)( ( x - p_LUTInfo->LUT_Xmin ) * p_LUTInfo->LUT_Size / p_LUTInfo->LUT_Xrange );
   else
      i = 0;

   i = MIN(i, p_LUTInfo->LUT_Size - 1);

   // xi = ( i * XRange / Size ) + XMin, the abscissa value of the start of interval i
   xi = ( (float) i * p_LUTInfo->LUT_Xrange / p_LUTInfo->LUT_Size ) + p_LUTInfo->LUT_Xmin;

   unpackLUTData(Xil_In32_(LUTDataAddr + i) , p_LUTInfo, &m, &bi, gActDebugOptions.verbose);

   y = m * ( x - xi ) + bi;

   return y;
}

/**
  *  This function computes reverse calculation of y = m * x + b using a
  *  lookup table (LUT), i.e. it finds x such as y = mi * (x-xi) + bi
  *
  *  @param p_LUTData  Address of the quantized LUT m and b data. (not a pointer)
  *  @param p_LUTInfo  Pointer to LUT info (XMin, XRange ... ).
  *  @param y_target   y target value.
  *
  *  @return x value.
  *
  *   Note(s):
  *      Equations:
  *      #1- y(x)
  *
  *         1a    y = m * ( x - xi ) + bi
  *
  *         1b    x = ( ( y - bi ) / m ) + xi
  *
  *      #2- LUT index
  *
  *         2a    i = int[ ( x - XMin ) * Size / XRange ]
  *
  *         2b    xi = ( i * XRange / Size ) + XMin
  *
  */
static float applyReverseLUT( uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float y_target, bool verbose )
{
   int32_t i;
   float m=1, bi=0, x, xi, binf;
   uint32_t imin, imax;
   // must read the LUT data using a Xil transaction
   uint32_t data;

#define BINARY_SEARCH

#ifndef BINARY_SEARCH
   float y;
   i = 0;
   do
   {
      data = Xil_In32_(LUTDataAddr + i);
      unpackLUTData( data, p_LUTInfo, &m, &bi, false );
      y = bi;

      // if ( verbose )
      //    ACT_INF( "y(%d) (x100) = %d", i, (uint32_t) ( y * 100.0f ) );

      i++;
   }
   while ( ( y < y_target ) && ( i < p_LUTInfo->LUT_Size ) );

   i--; // Undo last i++

   if ( verbose )
      ACT_INF( "bi[%d] = " _PCF(4), i, _FFMT(bi, 4) );

   if ( ( y > y_target ) && ( i > 0 ) )
   {
      // Read last m and bi value
      --i;
      data = Xil_In32_(LUTDataAddr + i);
      unpackLUTData( data, p_LUTInfo, &m, &bi, verbose );
   }
#else
   // perform a binary search using the bi. CR_TRICKY it is a modified binary search, since we're looking for a lower bound
   imin = 1; // skip first and last LUT intervals
   i=0;
   imax = p_LUTInfo->LUT_Size-1; // CR_TRICKY because we're searching an interval, it's ok to use LUT_Size as imax
   binf = p_LUTInfo->LUT_Xmin;

   while (imin < imax && binf < y_target)
   {
      i = (imax + imin)/2;

      // CR_TRICKY : address offset is in 32-bit word offset. nth element is at base+n (not base+4*n)
      data = Xil_In32_(LUTDataAddr + i);
      unpackLUTData( data, p_LUTInfo, &m, &bi, false );

      if (bi < y_target)
      {
         imin = i + 1;
         binf = bi;
      }
      else if (bi > y_target)
         imax = i;
      else // ==
         break;
   }

#endif
   if ( verbose )
   {
      ACT_INF( "bi[%d] = " _PCF(4), i, _FFMT(bi,4));
      ACT_INF( "mi[%d] = " _PCF(4), i, _FFMT(m,4));
   }

   // xi = ( i * XRange / Size ) + XMin
   xi = ( (float) i * p_LUTInfo->LUT_Xrange / p_LUTInfo->LUT_Size ) + p_LUTInfo->LUT_Xmin;

   // x = ( ( y - bi ) / m ) + xi
   x = ( ( y_target - bi ) / m ) + xi;

#ifdef ACT_VERBOSE
   if ( verbose )
   {
      float z = (x - xi) * m + bi;
      ACT_INF( "Index = %d, x = " _PCF(3), i, _FFMT(x,3));
      ACT_INF( "y_ = mx + b = " _PCF(3), _FFMT(z,3));
   }
#endif

   return x;
}

/**
  *  This function retrieves m and b float values from packed fixed point 32-bit
  *  data. Both m and b are stored using 16-bit field.
  *
  *  @param LUTData     Quantized LUT m and b data.
  *  @param p_LUTInfo   Pointer to LUT info (XMin, XRange ... ).
  *  @param p_m         Pointer to m value to return.
  *  @param p_b         Pointer to b value to return.
  *
  *  @return None
  *
  *   Note(s):
  */
static void unpackLUTData( uint32_t LUTData, LUTRQInfo_t *p_LUTInfo, float *p_m, float *p_b, bool verbose )
{
   int32_t raw;

   lut_data_t* data = (lut_data_t*)(&LUTData); // reinterpret cast the data

   /* CR_WARNING présentement M et B sont NON SIGNÉS.
    * si un jour M_Signed et B_Signed deviennent actifs
    * il faut réactiver et tester les deux if() ci-dessous
    */
   raw = data->m;
   if (0 && p_LUTInfo->M_Signed)
      SIGN_EXT32(raw, 16);

   *p_m = ((float) raw) * exp2f( (float) p_LUTInfo->M_Exp );

   raw = data->b;
   if (0 && p_LUTInfo->B_Signed)
         SIGN_EXT32(raw, 16);

   *p_b = ((float) raw) * exp2f( (float) p_LUTInfo->B_Exp );

   if ( verbose )
   {
      ACT_INF( "LUTData = 0x%08X", LUTData );
      ACT_INF( "   m = %d * 2^%d = " _PCF(3), data->m, p_LUTInfo->M_Exp, _FFMT(*p_m, 3));
      ACT_INF( "   b = %d * 2^%d = " _PCF(3), data->b, p_LUTInfo->B_Exp, _FFMT(*p_b, 3));
   }
}

/**
  * This function computes one delta beta and new bad pixel status from ICU calibration data.
  *
  *  @param p_CalData   Pointer to calibration data.
  *  @param FCal        Pixel FCal value.
  *  @param FCalBB      Black body FCal value.
  *  @param Alpha_LSB   Alpha LSB value to convert fixed point data to float (2^ALPHA_EXP)
  *  @param Beta_LSB    Beta LSB value to convert fixed point data to float (2^BETA_EXP)
  *
  *  @return Raw delta Beta value, bit 11 : new bad pixel status, bits 10-0 : DeltaBeta
  *
  *   Note(s):
  *      Equations:
  *      #1- Flux spatial uniformization (FSU)
  *
  *         1a    FCal = ( F - Beta ) / Alpha
  *
  *         1b    F = ( FCal * Alpha ) + Beta
  *
  *         1c    Beta = F - ( FCal * Alpha )
  *
  *      #2- Delta Beta (delta_beta)
  *
  *         2a    delta_beta = new_Beta - current_Beta
  *
  *         2b    delta_beta = ( FCal - FCalBB ) * Alpha      (See below)
  *
  *
  *      Computing delta_beta using 1b, 1c and 2a:
  *         F = ( FCal * Alpha ) + current_Beta
  *
  *         new_Beta = F - ( FCalBB * Alpha )
  *         new_Beta = ( FCal * Alpha ) + current_Beta - ( FCalBB * Alpha )
  *
  *         delta_beta = new_Beta - current_Beta
  *         delta_beta = [ ( FCal * Alpha ) + current_Beta - ( FCalBB * Alpha ) ] - current_Beta
  *         delta_beta = ( FCal * Alpha ) - ( FCalBB * Alpha )
  *         delta_beta = ( FCal - FCalBB ) * Alpha
  *
  */
static void computeDeltaBeta(uint64_t* p_CalData, float FCal, float FCalBB, float Alpha_LSB, float Beta_LSB, const calibBlockInfo_t* blockInfo, float* deltaBetaOut, float* alphaOut)
{
   static const uint64_t alpha_mask = CALIBBLOCK_PIXELDATA_ALPHA_MASK;
   float alpha, delta_beta;
   uint16_t raw_alpha;
   uint64_t calData;

   calData = *p_CalData;

   const float alpha_offset = blockInfo->pixelData.Alpha_Off;

   // Extract alpha from current calibration data => 12 lsb
   raw_alpha = (uint16_t) (( calData & alpha_mask ) >> CALIBBLOCK_PIXELDATA_ALPHA_SHIFT);
   alpha = (float) raw_alpha * Alpha_LSB + alpha_offset;

   // Compute delta beta ( see notes in function header )
   delta_beta = (FCal - FCalBB) * alpha;

   delta_beta /= Beta_LSB;

   if (isBadPixel(p_CalData))
      delta_beta = infinityf();

   // Return raw delta Beta value
   if (deltaBetaOut)
      *deltaBetaOut = delta_beta;

   if (alphaOut)
      *alphaOut = alpha;

#ifdef ACT_VERBOSE
   static uint32_t counter = 0;
   static uint32_t bpcounter = 0;
   bool isAlreadyBadPixel = isBadPixel(&calData);
   uint32_t col = counter % gcRegsData.SensorWidth;
   uint32_t line = counter / gcRegsData.SensorWidth;
   bool verboseData = ( col % 128 == 0 ) && (( line % 128 == 0 ) || line+1 == gcRegsData.SensorHeight);

   ++counter;
   counter %= MAX_PIXEL_COUNT;

   if (BitMaskTst(calData, CALIBBLOCK_PIXELDATA_BADPIXEL_MASK) != BitTst(calData, CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT))
      ACT_PRINTF( "Probleme (r=%d, c=%d)\n", line, col);

   if (isAlreadyBadPixel)
   {
      ++bpcounter;
      if (bpcounter < 100)
         ACT_TRC( "Bad pixel in block file (r=%d, c=%d)\n", line, col);

      if (counter == 0)
      {
         ACT_TRC( "%d bad Pixels in block file\n", bpcounter);
         bpcounter = 0;
      }
   }

   if ( verboseData )
   {
      ACT_TRC( "Pixel (r=%d, c=%d)\n", line, col );
      ACT_TRC( "   FCal: " _PCF(3) "\n", _FFMT(FCal,3));
      ACT_TRC( "   CalData: 0x%08X%08X\n", (uint32_t)(calData >> 32), (uint32_t)(calData & 0x00000000FFFFFFFF));
      ACT_TRC( "   alpha: " _PCF(3) " + %d x 2^%d (" _PCF(3) ")\n", _FFMT(alpha_offset,3), raw_alpha,
            blockInfo->pixelData.Alpha_Exp, _FFMT(alpha,3) );
      if (!isAlreadyBadPixel)
         ACT_TRC( "   delta_beta: " _PCF(6) ")\n", _FFMT(delta_beta, 6) );
      else
         ACT_TRC( "   delta_beta: " _PCF(6) ") **bad pixel in block file**\n", _FFMT(delta_beta, 6) );
   }
#endif
}

static bool quantizeDeltaBeta(const float BetaLSB, const float deltaBetaIn, int16_t* rawDeltaBetaOut)
{
   static const int16_t minRawData = -CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS; //-2^10
   static const int16_t maxRawData = CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS - 1;  // 2^10 - 1
   static const int16_t max16s = SHRT_MAX;
   static const int16_t min16s = SHRT_MIN;
   int16_t raw_delta_beta = 0;
   bool isNewBadPixel = false;

   raw_delta_beta = (int16_t) MIN( MAX( roundf(deltaBetaIn / BetaLSB), min16s ), max16s );

   // check if it now has become a bad pixel -> according to the saturation status of delta beta only
   // there might be more new bad pixels when a calibration block is updated with the delta beta value
   if (raw_delta_beta <= minRawData)
   {
      isNewBadPixel = true;
      raw_delta_beta = minRawData;
   }

   if (raw_delta_beta >= maxRawData)
   {
      isNewBadPixel = true;
      raw_delta_beta = maxRawData;
   }

   // now set the NewBadPixel bit (in reverse logic)
   if (isNewBadPixel)
      BitClr(raw_delta_beta, CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT);
   else
      BitSet(raw_delta_beta, CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT);

   *rawDeltaBetaOut = raw_delta_beta;

#ifdef ACT_VERBOSE
   static uint32_t counter = 0;
   uint32_t col = counter % gcRegsData.SensorWidth;
   uint32_t line = counter / gcRegsData.SensorWidth;
   bool verboseData = ( col % 128 == 0 ) && (( line % 128 == 0 ) || line+1 == gcRegsData.SensorHeight);
   ++counter;
   counter %= MAX_PIXEL_COUNT;
   if (0 && isNewBadPixel)
   {
      ACT_TRC( "quantizeDeltaBeta(): Bad Pixel (r=%d, c=%d)\n", line, col );
   }

   if ( verboseData )
   {
      int16_t tmp;
      ACT_TRC( "Pixel (r=%d, c=%d)\n", line, col );
      tmp = (raw_delta_beta & CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK);
      SIGN_EXT16(tmp, DELTA_BETA_NUM_BITS);
      ACT_TRC( "   delta_beta: %d x 2^%d (" _PCF(6) ") %s\n", tmp, exponent, _FFMT(deltaBetaIn, 6), isNewBadPixel?"**new bad pixel**":"" );
      ACT_TRC( "   raw_delta_beta (sat) : %d\n", tmp );
   }
#endif

   return isNewBadPixel;
}

/**
  *  This function validates whether a newly loaded calibration collection can be updated or not with the latest
  *  available delta beta map in memory (if any).
  *
  *  Checks for calibration type, pixel data presence and reference POSIX time
  *
  *
  * @param a pointer to the current calibration info
  * @param an index to the candidate calibration block to be updated
  *
  * @return true or false
  *
  */
bool ACT_shouldUpdateCurrentCalibration(const calibrationInfo_t* calibInfo, uint8_t blockIdx)
{
   bool retval = false;
   deltabeta_t* data = NULL;

   if (!flashSettings.ImageCorrectionEnabled)
      return false;

   data = findSuitableDeltaBetaForBlock(calibInfo, blockIdx, true);

   // check if the current block is compatible
   if (allowCalibUpdate && data != NULL &&
         (calibInfo->collection.CalibrationType == CALT_TELOPS || calibInfo->collection.CalibrationType == CALT_MULTIPOINT) &&
         calibInfo->blocks[blockIdx].PixelDataPresence == 1 && GC_WaitingForImageCorrection == 0)
   {
      retval = true;
   }
   else
   {
      if (!allowCalibUpdate || GC_WaitingForImageCorrection)
         ACT_INF("Calibration image correction is not applicable to the current block (it is already running).");
      else if (data == NULL)
         ACT_INF("No calibration image correction has been computed yet.");
      else
         ACT_INF("Calibration image correction is not applicable to the current block.");
   }

   return retval;
}

/**
  *  This function updates the calibration data by applying delta beta to
  *  the current beta loaded in memory.
  *
  *  The function iterates through data by reading two delta beta elements at a time. Thus, the
  *  provided pointer points to 32 bit data
  *
  * @param a pointer to the current calibration data to be updated
  * @param a pointer to new calibration data (actualizationData) -> actually a pointer to a pair of data values
  * @param the number of data elements to process (must be even)
  * @param a pointer to the number of identified bad pixels during update (both old and new) (pointer can be NULL)
  *
  * @return the number of new bad pixels following update
  *
  *   Note(s):
  *      Only factory calibrations can be updated
  *
  */
uint32_t ACT_updateCurrentCalibration(const calibBlockInfo_t* blockInfo, uint32_t* p_CalData, const deltabeta_t* deltaBeta, uint32_t startIdx, uint32_t numData)
{
   int16_t DeltaBetaH, DeltaBetaL;
   uint32_t numBadPixels = 0;
   const int8_t expBitshift = 0;// the factor to apply (as a binary shift) in order to bring the deltaBeta parameter to the same range as that the beta of the current block *now always 0*
   uint64_t calData;
   uint64_t* calDataAddr;
   const float BetaLSB = exp2f((float)blockInfo->pixelData.Beta0_Exp);
   const float* deltaBetaAddr = &deltaBeta->deltaBeta[startIdx];
   float offset;

   if (deltaBeta->info.discardOffset || gActDebugOptions.forceDiscardOffset)
      offset = deltaBeta->p50;
   else
      offset = 0;

   while (numData)
   {
      quantizeDeltaBeta(BetaLSB, *deltaBetaAddr - offset, &DeltaBetaL);
      ++deltaBetaAddr;

      // Apply beta correction
      calDataAddr = (uint64_t*)p_CalData;
      calData = (uint64_t)*p_CalData++;
      calData |= ((uint64_t)*p_CalData++ << 32);
      numBadPixels += updatePixelDataElement(blockInfo, &calData, DeltaBetaL, expBitshift);
      *calDataAddr = calData;

      quantizeDeltaBeta(BetaLSB, *deltaBetaAddr - offset, &DeltaBetaH);
      ++deltaBetaAddr;

      calDataAddr = (uint64_t*)p_CalData;
      calData = (uint64_t)*p_CalData++;
      calData |= ((uint64_t)*p_CalData++ << 32);
      numBadPixels += updatePixelDataElement(blockInfo, &calData, DeltaBetaH, expBitshift);
      *calDataAddr = calData;

      numData -= 2;
   }

   return numBadPixels;
}

/**
  *   This function applies beta correction and sets the new bad pixels to the
  *   current calibration.
  *
  *   @param p_CalData         Pointer to calibration data containing Beta.
  *   @param deltaBeta         Raw delta beta to apply.
  *   @param expBitShift       Factor to apply to delta beta to have the same LSB as that of beta to be update. (as a bit shift ->(a+b) in 2^a_deltabeta / 2^a_beta = 2^(a_deltabeta - a_beta)
  *
  *   @return 1 if the updated pixel data is a new bad pixel
  *
  *   Note(s):
  *      Equations:
  *      #1- Beta/raw_beta relation
  *         1a    Beta = raw_beta * 2^BETA_EXP
  *
  *      #2- Corrected Beta
  *         2a    corr_Beta = current_Beta + delta_beta
  *
  *      #3 Computing corrected raw beta using 1a in 2a
  *         raw_corr_beta * 2^BETA_EXP =
  *            ( raw_current_beta * 2^BETA_EXP ) +
  *            ( raw_delta_beta * 2^BETA_EXP )
  *         raw_corr_beta * 2^BETA_EXP = ( raw_current_beta + raw_delta_beta ) * 2^BETA_EXP
  *         raw_corr_beta = raw_current_beta + raw_delta_beta
  *
  */
static uint8_t updatePixelDataElement(const calibBlockInfo_t* blockInfo, uint64_t *p_CalData, int16_t deltaBeta, int8_t expBitShift)
{
   static const int32_t minRawData = -CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS; //-2^10
   static const int32_t maxRawData = CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_SIGNPOS - 1;  // 2^10 - 1

   int16_t raw_current_beta, raw_corr_beta, corr_deltaBeta;
   uint8_t saturation = false;
   uint64_t calData;
   uint8_t newBadPixel = false;
   uint8_t isAlreadyBad;

   calData = *p_CalData;

   isAlreadyBad = isBadPixel(&calData);

   // Extract current beta from current calibration data
   raw_current_beta = (int16_t) ((calData & CALIBBLOCK_PIXELDATA_BETA0_MASK) >> CALIBBLOCK_PIXELDATA_BETA0_SHIFT );
   SIGN_EXT16( raw_current_beta, blockInfo->pixelData.Beta0_Nbits );

   newBadPixel = !BitTst(deltaBeta, CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_NEWBADPIXEL_SHIFT); // the bad pixel bit is in reverse logic
   deltaBeta &= CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_DELTABETA_MASK; // extract the data without the bad pixel flag
   SIGN_EXT16( deltaBeta, DELTA_BETA_NUM_BITS);

   // the following implements :  corr_deltaBeta = deltaBeta * 2^(+/-)expBitShift
   // CR_WARNING negative shift operand is undefined, hence the if/else construct
   if (expBitShift < 0)
      corr_deltaBeta = (int16_t) (deltaBeta >> (uint8_t)(-expBitShift));
   else
      corr_deltaBeta = (int16_t) (deltaBeta << (uint8_t)expBitShift);

   // Compute corrected raw beta
   raw_corr_beta = raw_current_beta + corr_deltaBeta;

#ifdef ACT_VERBOSE
   static uint32_t counter = 0;
   uint32_t col = counter % gcRegsData.SensorWidth;
   uint32_t line = counter / gcRegsData.SensorWidth;
   bool verboseData = ( col % 128 == 0 ) && (( line % 128 == 0 ) || line+1 == gcRegsData.SensorHeight);
   ++counter;
   counter %= MAX_PIXEL_COUNT;
   if ( verboseData )
   {
      ACT_TRC( "Pixel (r=%d, c=%d)\n", line, col );
      ACT_TRC( "CalData: 0x%08X%08X\n", (uint32_t)(calData >> 32), (uint32_t)(calData & 0x00000000FFFFFFFF) );
      ACT_TRC( "raw_beta: %d\n", raw_current_beta );
      ACT_TRC( "raw_delta_beta: %d\n", deltaBeta );
      ACT_TRC( "raw_corr_delta_beta: %d\n", corr_deltaBeta );
      ACT_TRC( "raw_corr_beta: %d\n", raw_corr_beta );
   }
#endif

   // Check for raw corrected beta saturation -> will yield a new bad pixel
   if ( raw_corr_beta < minRawData)
   {
      raw_corr_beta = minRawData;
      saturation = true;
   }
   else if ( raw_corr_beta > maxRawData)
   {
      raw_corr_beta = maxRawData;
      saturation = true;
   }

   newBadPixel |= saturation;

   // Write corrected beta value into calibration data

   // clear the beta data bits first
   calData &= ~CALIBBLOCK_PIXELDATA_BETA0_MASK;
   calData |= ( ((uint64_t)raw_corr_beta) << CALIBBLOCK_PIXELDATA_BETA0_SHIFT ) & CALIBBLOCK_PIXELDATA_BETA0_MASK;

   if (newBadPixel) // clear the badpixel bit when it is bad (reverse logic) (do nothing otherwise)
      BitMaskClr(calData, CALIBBLOCK_PIXELDATA_BADPIXEL_MASK);

   *p_CalData = calData;

#ifdef ACT_VERBOSE
   if ( verboseData )
   {
      ACT_TRC( "raw_corr_beta (sat)%s: %d\n", newBadPixel?" (**new bad pixel after update**) ":"", raw_corr_beta);
      ACT_TRC( "CalData: 0x%08X%08X\n", (uint32_t)((*p_CalData) >> 32), (uint32_t)((*p_CalData) & 0x00000000FFFFFFFF));
      ACT_TRC( "\n" );
   }
#endif

   return (newBadPixel && !isAlreadyBad);
}

/**
  *  Find the ICU reference block that matches the current calibration settings.
  *
  *  The function scans all the available calibration blocks and selects
  *  the one ICU reference block that matches the current calibration features.
  *
  *   @param none
  *
  *   @return a pointer to the file record of the ICU block we need to load.
  */
static fileRecord_t* findIcuReferenceBlock()
{
   int n = gFM_icuBlocks.count;
   int i = 0;
   int fd;
   uint32_t length=0;
   fileRecord_t* filerec = NULL;
   CalibBlock_BlockFileHeader_t refBlockFileHdr;

   if (!calibrationInfo.isValid)
      return NULL;

   // get through all block files in flash and find the matching ICU reference
   while (i < n)
   {
      fd = FM_OpenFile(gFM_icuBlocks.item[i]->name, UO_RDONLY);

      length = CalibBlock_ParseBlockFileHeader(fd, &refBlockFileHdr, NULL);

      uffs_close(fd);

      if (length == 0)
      {
         ++i;
         continue;
      }

      if (refBlockFileHdr.CalibrationType == CALT_ICU &&
            refBlockFileHdr.PixelDataResolution == calibrationInfo.collection.PixelDataResolution &&
            refBlockFileHdr.SensorWellDepth == calibrationInfo.collection.SensorWellDepth &&
            refBlockFileHdr.IntegrationMode == calibrationInfo.collection.IntegrationMode &&
            refBlockFileHdr.POSIXTime == calibrationInfo.collection.ReferencePOSIXTime)
      {
         filerec = gFM_icuBlocks.item[i];
         ACT_INF("Found ICU reference block %s", filerec->name);
         break;
      }
      ++i;
   }

   return filerec;
}

/**
  *  State machine for the image correction data file
  *
  *   @param none
  *
  *   @return IRC_DONE or IRC_Failure or IRC_NOT_DONE when it is not finished
  */
static IRC_Status_t ActualizationFileWriter_SM(deltabeta_t* currentDeltaBeta)
{
   static ACT_Write_State_t state = FWR_IDLE;
   static uint32_t dataOffset = 0; // used for data write
   static uint32_t numDataToProcess;
   static uint16_t dataCRC;
   static uint64_t tic_io_duration;
   static fileRecord_t* actualization_file;
   static int fd = -1;
   static char shortFileName[48];
   static char longFileName[FM_LONG_FILENAME_SIZE];
   static context_t blockContext; // information structure for block processing
   static float deltaBetaLSB;
   static CalibImageCorrection_ImageCorrectionFileHeader_t actFileHeader;
   static CalibImageCorrection_ImageCorrectionDataHeader_t actDataHeader;

   extern t_Trig gTrig;

   IRC_Status_t retVal = IRC_NOT_DONE;
   bool error = false;
   uint16_t blockSize;
   uint32_t numBytes = 0;
   fileRecord_t* previousFile;
   int i, k;

   static const uint32_t numPixels = FPA_HEIGHT_MAX * FPA_WIDTH_MAX;

   switch (state)
   {
   case FWR_IDLE:
      if (gWriteActualizationFile)
      {
         gWriteActualizationFile = 0;
         state = FWR_DELETE_PREVIOUS;
         GETTIME(&tic_io_duration);
      }

      break;

   case FWR_DELETE_PREVIOUS:
   {
      ACT_PRINTF("FWR_DELETE_PREVIOUS\n");
      uint32_t timestampOffset = 0;

      privateActualisationPosixTime = TRIG_GetRTC(&gTrig).Seconds;

      // take the most recent timestamp as an offset in case the RTC is not valid
      for (i=0; i<gFM_files.count; ++i)
         timestampOffset = MAX(timestampOffset, gFM_files.item[i]->posixTime);

      if (privateActualisationPosixTime < timestampOffset) // this can happen if the camera was not yet synchronized with a RTC.
         privateActualisationPosixTime = timestampOffset + privateActualisationPosixTime % 60;

      previousFile = findActualizationFile(currentDeltaBeta->info.referencePOSIXTime);
      if (previousFile != NULL)
      {
         ACT_PRINTF("Removing previous actualisation file (%s).\n", previousFile->name);
         if (FM_RemoveFile(previousFile) != IRC_SUCCESS)
         {
            ACT_ERR("Error deleting previous actualisation file (%s).", previousFile->name);
            // no big deal if could not remove the file
         }
      }
      else
         ACT_PRINTF("No existing previous file to remove.\n");

      state = FWR_INIT_IO;
   }
   case FWR_INIT_IO:

      ACT_PRINTF("FWR_INIT_IO\n");

      defineActualizationFilename(shortFileName, sizeof(shortFileName), privateActualisationPosixTime, currentDeltaBeta);
      sprintf(longFileName, "%s%s", FM_UFFS_MOUNT_POINT, shortFileName);

      ACT_PRINTF("Will write to file : %s\n", shortFileName);

      actualization_file = NULL;

      // if file does not exist, create it
      if (!FM_FileExists(shortFileName))
      {
         actualization_file = FM_CreateFile(shortFileName);
         if (actualization_file == NULL)
         {
            ACT_ERR("Error creating file %s.", shortFileName);
            error = true;
            break;
         }
      }

      // open the file
      fd = FM_OpenFile(shortFileName, UO_WRONLY);
      if (fd == -1)
      {
         ACT_ERR("Failed to open %s.", shortFileName);
         error = true;
         break;
      }

      state = FWR_FILE_HEADER;

      break;

   case FWR_FILE_HEADER:

      ACT_PRINTF("FWR_FILE_HEADER\n");

      actFileHeader.DeviceSerialNumber = gcRegsData.DeviceSerialNumber;
      actFileHeader.POSIXTime = privateActualisationPosixTime;
      strcpy(actFileHeader.FileDescription, "");
      actFileHeader.Width = gcRegsData.SensorWidth;
      actFileHeader.Height = gcRegsData.SensorHeight;
      actFileHeader.OffsetX = 0;
      actFileHeader.OffsetY = 0;
      actFileHeader.ReferencePOSIXTime = currentDeltaBeta->info.referencePOSIXTime;
      actFileHeader.SensorID = calibrationInfo.collection.SensorID;

      actFileHeader.ImageCorrectionType = currentDeltaBeta->info.type;
      actFileHeader.TemperatureInternalLens = currentDeltaBeta->info.internalLensTemperature;
      actFileHeader.TemperatureReference = currentDeltaBeta->info.referenceTemperature;
      actFileHeader.ExposureTime = currentDeltaBeta->info.exposureTime;
      actFileHeader.AcquisitionFrameRate = (uint32_t)(currentDeltaBeta->info.AcquisitionFrameRate * 1000.0F);
      actFileHeader.FWMode = currentDeltaBeta->info.FWMode;
      actFileHeader.FocusPositionRaw = currentDeltaBeta->info.FocusPositionRaw;

      // write file header
      numBytes = CalibImageCorrection_WriteImageCorrectionFileHeader(&actFileHeader, tmpFileDataBuffer, FM_TEMP_FILE_DATA_BUFFER_SIZE);

      if (numBytes != CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE)
      {
         ACT_ERR("Abnormal file header length (expected %d, got %d).", CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE, numBytes);
         error = true;
         break;
      }

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }

      if (uffs_write(fd, tmpFileDataBuffer, numBytes) != CALIBIMAGECORRECTION_IMAGECORRECTIONFILEHEADER_SIZE)
      {
         ACT_ERR("Error writing file header to file %s.", shortFileName);
         uffs_close(fd);
         uffs_remove(longFileName);
         error = true;
         break;
      }

      dataOffset = 0;
      numDataToProcess = gcRegsData.SensorWidth * gcRegsData.SensorHeight;
      dataCRC = 0xFFFF; // init with Modbus CRC-16 starting value. It will be updated as the data is computed

      ctxtInit(&blockContext, 0, numPixels, 100*ACT_MAX_PIX_DATA_TO_PROCESS);
      state = FWR_QUANTIZE_DATA;

      break;

   case FWR_QUANTIZE_DATA:
      {
         const float offset = currentDeltaBeta->stats.mu;
         int16_t* d = (int16_t*)PROC_MEM_DELTA_BETA_BASEADDR;

         if (blockContext.blockIdx == 0)
         {
            int8_t Exp = MAX(ceilf(log2f(offset - currentDeltaBeta->stats.min)), ceilf(log2f(currentDeltaBeta->stats.max - offset))) - (DELTA_BETA_NUM_BITS-1);

            deltaBetaLSB = exp2f(Exp);

            if (gActDebugOptions.verbose)
            {
               ACT_INF("Quantization exponent for .tsic file = %d", Exp);
            }

            actDataHeader.Beta0_Off = offset;
            actDataHeader.Beta0_Median = currentDeltaBeta->p50;
            actDataHeader.Beta0_Exp = Exp;
         }

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            quantizeDeltaBeta(deltaBetaLSB, currentDeltaBeta->deltaBeta[k] - offset, &d[k]);
         }

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            state = FWR_CALC_CRC;
         }
      }
      break;

   case FWR_CALC_CRC:
      blockSize = MIN( numDataToProcess, ACT_MAX_PIX_DATA_TO_PROCESS );

      uint8_t* dataPtr = (uint8_t*)PROC_MEM_DELTA_BETA_BASEADDR + dataOffset;

      dataCRC = CRC16(dataCRC, dataPtr, blockSize * CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE);

      numDataToProcess -= blockSize;

      dataOffset += blockSize * CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE;

      if (numDataToProcess == 0)
      {
         state = FWR_DATA_HEADER;
      }

      break;

   case FWR_DATA_HEADER:

      ACT_PRINTF("FWR_DATA_HEADER\n");

      actDataHeader.Beta0_Nbits = DELTA_BETA_NUM_BITS;
      actDataHeader.Beta0_Signed = 1;
      actDataHeader.ImageCorrectionDataCRC16 = dataCRC;
      actDataHeader.ImageCorrectionDataLength = CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE * gcRegsData.SensorWidth * gcRegsData.SensorHeight;

      // write file data header
      numBytes = CalibImageCorrection_WriteImageCorrectionDataHeader(&actDataHeader, tmpFileDataBuffer, FM_TEMP_FILE_DATA_BUFFER_SIZE);

      if (numBytes != CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE)
      {
         ACT_ERR("Abnormal data header length (expected %d, got %d).", CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE, numBytes);
         error = true;
         break;
      }

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }
      if (uffs_write(fd, tmpFileDataBuffer, numBytes) != CALIBIMAGECORRECTION_IMAGECORRECTIONDATAHEADER_SIZE)
      {
         ACT_ERR("Error writing data header to file %s.", shortFileName);
         uffs_close(fd);
         uffs_remove(longFileName);
         error = true;
         break;
      }

      dataOffset = 0;
      numDataToProcess = gcRegsData.SensorWidth * gcRegsData.SensorHeight;

      state = FWR_DATA;

      ACT_PRINTF("Going to FWR_DATA\n");

      break;

   case FWR_DATA:
      blockSize = MIN( numDataToProcess, ACT_MAX_DATABLOCK_TO_WRITE );

      uint8_t* dataAddr = (uint8_t*)PROC_MEM_DELTA_BETA_BASEADDR + dataOffset;

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }

      numBytes = blockSize * CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE;
      if (uffs_write(fd, dataAddr, numBytes) != numBytes)
      {
         ACT_ERR("Error writing data to file %s.", shortFileName);
         uffs_close(fd);
         uffs_remove(longFileName);
         error = true;
         break;
      }

      numDataToProcess -= blockSize;

      dataOffset += blockSize * CALIBIMAGECORRECTION_IMAGECORRECTIONDATA_SIZE;

      if (numDataToProcess == 0)
      {
         state = FWR_CLOSEFILE;
      }

      break;

   case FWR_CLOSEFILE:

      ACT_PRINTF("FWR_CLOSEFILE\n");

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }

      actualization_file->size = uffs_tell(fd);

      // now close the file
      if (uffs_close(fd) == -1)
      {
         ACT_ERR("File close failed.");
         error = true;
         break;
      }

      if (uffs_space_free(FM_UFFS_MOUNT_POINT) < FLASHDYNAMICVALUES_FLASHDYNAMICVALUESFILEHEADER_SIZE)
      {
         ACT_ERR("Filesystem full.");
         uffs_remove(longFileName);
         error = true;
         break;
      }

      FM_CloseFile(actualization_file, FMP_RUNNING);

      FM_AddFileToList(actualization_file, &gFM_files, NULL);

      currentDeltaBeta->info.file = actualization_file;

      state = FWR_IDLE;
      retVal = IRC_DONE;

      ACT_PRINTF( "File IO completed in %d ms\n", (uint32_t) elapsed_time_us( tic_io_duration ) / 1000 );

      break;

   default:
      state = FWR_IDLE;
   };

   if (error == true)
   {
      // Reset state machine
      state = FWR_IDLE;

      GC_GenerateEventError(EECD_ImageCorrectionFileIOError);

      if (fd != -1)
      {
         uffs_close(fd); // don't bother the error if any upon closing the file
         ACT_ERR("File close failed.");
      }

      retVal = IRC_FAILURE;
   }

   return retVal;
}

static void defineActualizationFilename(char* buf, uint8_t length, uint32_t timestamp, deltabeta_t* data)
{
   uint8_t n = MIN(length, sizeof(gcRegsData.DeviceID));
   memset(buf, 0, length);
   if (strlen(gcRegsData.DeviceID) != 0)
      strncpy(buf, gcRegsData.DeviceID, n);
   else
      strcpy(buf, "TEL00000");

   sprintf(buf + strlen(buf), "-%010u_%c_%010u.tsic", (unsigned int)timestamp,
         (data->info.type == ACT_ICU)?'i':'e', (unsigned int)data->info.referencePOSIXTime);
}

/**
  *  Find the LUTRQ table offset and info corresponding to the requested type in the current calibration block
  *
  *   @param a pointer to the calibration block
  *   @param a RadiometricQuantityType tag
  *
  *   @return A pointer to LUTRQInfo_t, null if not found
  */
static LUTRQInfo_t* selectLUT(calibBlockInfo_t* blockInfo, uint8_t type)
{
   LUTRQInfo_t* info = NULL;
   int i=0;

   if (blockInfo->LUTRQDataPresence == 0)
      return NULL;

   while (i < blockInfo->NumberOfLUTRQ && info == NULL)
   {
      if ((info = &blockInfo->lutRQData[i++])->RadiometricQuantityType != type)
         info = NULL;
   }

   return info;
}

/**
  *  Configure the ICU measurements procedure parameters from the flash settings. Uses the flashSettings global variable
  *
  *   @param a pointer to the private ICUParams_t structure
  *
  *   @return A pointer to LUTRQInfo_t, null if not found
  */
void configureIcuParams(ICUParams_t* p)
{
   if (flashSettings.ImageCorrectionTemperatureSelector == 0)
      p->TemperatureSelector = DTS_InternalCalibrationUnit;
   else
      p->TemperatureSelector = DTS_InternalLens;
   p->WaitTime1 = flashSettings.ImageCorrectionWaitTime1; // [ms]
   p->StabilizationTime1 = flashSettings.ImageCorrectionStabilizationTime1; // [ms]
   p->Timeout1 = flashSettings.ImageCorrectionTimeout1; // [ms]
   p->TemperatureTolerance1 = CC_TO_C(flashSettings.ImageCorrectionTemperatureTolerance1); // [°C]
   p->WaitTime2 = flashSettings.ImageCorrectionWaitTime2; // [ms]
   p->StabilizationTime2 = flashSettings.ImageCorrectionStabilizationTime2; // [ms]
   p->Timeout2 = flashSettings.ImageCorrectionTimeout2; // [ms]
   p->TemperatureTolerance2 = CC_TO_C(flashSettings.ImageCorrectionTemperatureTolerance2); // [°C]
}

void ACT_resetDebugOptions()
{
   gActDebugOptions.clearBufferAfterCompletion = true;
   gActDebugOptions.useDebugData = false;
   gActDebugOptions.bypassAEC = false;
   gActDebugOptions.disableBPDetection = false;
   gActDebugOptions.disableDeltaBeta = false;
   gActDebugOptions.useDynamicTestPattern = false;
   gActDebugOptions.bypassChecks = false;
   gActDebugOptions.mode = 0;
   gActDebugOptions.forceDiscardOffset = false;
#ifdef ACT_VERBOSE
   gActDebugOptions.verbose = true;
#else
   gActDebugOptions.verbose = false;
#endif
}

void ACT_parseDebugMode()
{
   if (BitMaskTst(gActDebugOptions.mode, ACT_MODE_DEBUG))
   {
      gActDebugOptions.clearBufferAfterCompletion = false;
      gActDebugOptions.bypassChecks = true;
   }
   else
   {
      gActDebugOptions.clearBufferAfterCompletion = true;
      gActDebugOptions.bypassChecks = false;
   }

   if (BitMaskTst(gActDebugOptions.mode, ACT_MODE_DELTA_BETA_OFF))
   {
      gActDebugOptions.disableDeltaBeta = true;
   }
   else
   {
      gActDebugOptions.disableDeltaBeta = false;
   }


   if (BitMaskTst(gActDebugOptions.mode, ACT_MODE_BP_OFF))
   {
      gActDebugOptions.disableBPDetection = true;
   }
   else
   {
      gActDebugOptions.disableBPDetection = false;
   }

   if (BitMaskTst(gActDebugOptions.mode, ACT_MODE_DYN_TST_PTRN))
   {
      gActDebugOptions.useDynamicTestPattern = true;
   }
   else
   {
      gActDebugOptions.useDynamicTestPattern = false;
   }

   if (BitMaskTst(gActDebugOptions.mode, ACT_MODE_VERBOSE))
   {
      gActDebugOptions.verbose = true;
   }
   else
   {
      gActDebugOptions.verbose = false;
   }

   if (BitMaskTst(gActDebugOptions.mode, ACT_MODE_DISCARD_OFFSET))
   {
      gActDebugOptions.forceDiscardOffset = true;
   }
   else
   {
      gActDebugOptions.forceDiscardOffset = false;
   }
}

void ACT_resetParams(actParams_t* p)
{
   p->badPixelsDetection = flashSettings.BPDetectionEnabled;
   p->deltaBetaNCoadd = MIN(flashSettings.ImageCorrectionNumberOfImagesCoadd, ACT_MAX_N_COADD);
   p->flickerThreshold = flashSettings.BPFlickerThreshold; // normalized threshold for a P_fa of 0.1%
   p->noiseThreshold = flashSettings.BPNoiseThreshold; // normalized threshold for a P_fa of 0.1%
   p->duration = flashSettings.BPDuration;
   p->flickersNCoadd = flashSettings.BPNCoadd;
   p->BPNumSamples = flashSettings.BPNumSamples;
   if (p->badPixelsDetection)
      p->numFrames = MAX(p->deltaBetaNCoadd, MAX(p->flickersNCoadd, p->BPNumSamples));
   else
      p->numFrames = p->deltaBetaNCoadd;

   p->numFrames = flashSettings.BPNumSamples;

   p->deltaBetaDiscardOffset = flashSettings.ImageCorrectionDiscardOffset;
}

/*static void ACT_clearDeltaBeta()
{
   int i;
   const uint32_t numPixels = FPA_HEIGHT_MAX * FPA_WIDTH_MAX;
   uint16_t* d = (uint16_t*)PROC_MEM_DELTA_BETA_BASEADDR;

   for (i=0; i<numPixels; ++i)
   {
      d[i] = CALIB_ACTUALIZATIONDATA_NEWBADPIXEL_MASK;
   }
}*/

static void ACT_init()
{
   ACT_resetDebugOptions();
   ACT_resetParams(&gActualizationParams);

   //memset(deltaBetaDB.deltaBeta, 0, MAX_DELTA_BETA_SIZE * sizeof(deltabeta_t*));
   deltaBetaDB.count = 0;

   ACT_PRINTF("Image correction state machine starting...\n");
}

static bool validateAverage(const uint32_t* coadd_buffer, uint32_t numPixels, uint32_t expectedSum)
{
   int k;

   // validate sum
   coadd_buffer += 2*gcRegsData.SensorWidth; // skip header
   for (k=2*gcRegsData.SensorWidth; k<numPixels; ++k)
   {
      if (*coadd_buffer != expectedSum)
      {
         ACT_ERR("Wrong value in coadd buffer at pixel %d : %d, expected %d", k, *coadd_buffer, expectedSum);
         k = -1;
         break;
      }
      ++coadd_buffer;
   }
   if (k == numPixels)
      ACT_INF( "Average validation success");

   return k == numPixels;
}

static bool validateBuffers(uint32_t* coadd_buffer, uint32_t nCoadd, uint16_t* seq_buffer, uint32_t nSeq)
{
   int k = 0;
   bool all_good_coadd = true;
   bool all_good_seq = true;
   const int header_sz = 2*gcRegsData.SensorWidth * 2;
   const int frame_size = gcRegsData.SensorWidth * (gcRegsData.SensorHeight+2);

   ACT_INF( "Check data integrity in buffer...");
   for (k=0; k<nCoadd; ++k)
   {
        if (coadd_buffer[k] != 0)
        {
           all_good_coadd = false;
           ACT_ERR("Wrong value (%d) at pixel %d of coadd buffer", coadd_buffer[k], k);
        }
   }
   if (all_good_coadd)
      ACT_INF( "Coadd buffer validation complete...");

   for (k=0; k<nSeq; ++k)
   {
      if (k%frame_size < header_sz)
      {
         if (k%frame_size == 0 && seq_buffer[k] != 0x4354) // check for valid header ID
         {
            all_good_seq = false;
            ACT_ERR("Wrong header ID (%d) at image %d", seq_buffer[k], k/frame_size);
         }
         continue;
      }

      if (seq_buffer[k] != 0x1000)
      {
         all_good_seq = false;
         ACT_ERR("Wrong value at pixel %d of image %d", k%frame_size, k/frame_size);
      }
   }
   if (all_good_seq)
      ACT_INF( "Data validation complete");

   return all_good_coadd && all_good_seq;
}

static bool isBadPixel(uint64_t* pixelData)
{
   return !BitTst(*pixelData, CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT);
}

/*
 * Find a valid delta beta data that matches the current block.
 * Order of precedence : xbb->icu->none
 */
static deltabeta_t* findSuitableDeltaBetaForBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx, bool verbose)
{
   int i, idx_xbb, idx_icu, idx;

   deltabeta_t* db_out = NULL;
   deltabeta_t* icu = NULL;
   deltabeta_t* xbb = NULL;
   const calibBlockInfo_t* blockInfo;

   blockInfo = &calibInfo->blocks[blockIdx];
   ACT_PRINTF("findSuitableDeltaBetaForBlock() with posix time %010d\n", (unsigned int)blockInfo->POSIXTime);

   // first, find all matching data (xbb and/or icu)
   idx_xbb = -1;
   idx_icu = -1;
   i = 0;
   while (i<deltaBetaDB.count)
   {
      deltabeta_t* p = deltaBetaDB.deltaBeta[i];
      if (p->valid)
      {
         if (p->info.type == ACT_ICU)
         {
            ACT_PRINTF("PixelDataResolution %d, %d\n", p->info.PixelDataResolution, calibInfo->collection.PixelDataResolution);
            ACT_PRINTF("SensorWellDepth %d, %d\n", p->info.SensorWellDepth, calibInfo->collection.SensorWellDepth);
            ACT_PRINTF("IntegrationMode %d, %d\n", p->info.IntegrationMode, calibInfo->collection.IntegrationMode);
            ACT_PRINTF("ReferencePOSIXTime %d, %d, (current block posixtime) %d\n", p->info.referencePOSIXTime, calibInfo->collection.ReferencePOSIXTime, blockInfo->POSIXTime);
            if ((p->info.PixelDataResolution == calibInfo->collection.PixelDataResolution &&
                  p->info.SensorWellDepth == calibInfo->collection.SensorWellDepth &&
                  p->info.IntegrationMode == calibInfo->collection.IntegrationMode &&
                  p->info.referencePOSIXTime == calibrationInfo.collection.ReferencePOSIXTime) ||
                  p->info.referencePOSIXTime == blockInfo->POSIXTime) // an ICU block is a special case : the deltabeta ref posix time will match that block's POSIXtime
            {
               icu = p;
               idx_icu = i;
            }
         }
         else // ACT_XBB
         {
            ACT_PRINTF("referencePOSIXTime %d, %d\n", p->info.referencePOSIXTime, blockInfo->POSIXTime);
            // for an external BB, only the posix time must match, because we then know that this block was used during the delta beta measurement
            if (p->info.referencePOSIXTime == blockInfo->POSIXTime)
            {
               xbb = p;
               idx_xbb = i;
            }
         }
      }
      ++i;
   }

   // apply the precedence rule
   if (xbb != NULL)
   {
      db_out = xbb;
      idx = idx_xbb;
   }
   else
   {
      db_out = icu;
      idx = idx_icu;
   }

   if (db_out != NULL && verbose == true)
   {
      ACT_INF("Found valid image correction data at location %d (type=%d, age=%d)", idx, db_out->info.type, db_out->info.age);
   }

   return db_out;
}

/* find the valid delta beta data that exactly matches the current block.
 */
static deltabeta_t* findMatchingDeltaBetaForBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx)
{
   int i, idx;
   const calibBlockInfo_t* blockInfo;

   deltabeta_t* db_out = NULL;

   blockInfo = &calibInfo->blocks[blockIdx];
   ACT_PRINTF("findMatchingDeltaBetaForBlock() posix time %010d\n", (unsigned int)blockInfo->POSIXTime);

   idx = -1;
   i = 0;
   while (i<deltaBetaDB.count)
   {
      deltabeta_t* p = deltaBetaDB.deltaBeta[i];
      if (p->info.referencePOSIXTime == blockInfo->POSIXTime)
      {
         db_out = p;
         idx = i;
      }
      ++i;
   }

   if (db_out != NULL)
   {
      ACT_INF("Found existing image correction data at location %d (valid=%d, type=%d, age=%d)", idx, db_out->valid, db_out->info.type, db_out->info.age);
   }

   return db_out;
}


void ACT_invalidateActualizations(int type) // todo invalider seulement les actualisations externes compatibles avec les paramètres de ICU existantes (si plus d'un bloc ICU)
{
   int i;
   deltabeta_t* current = NULL;

   switch (type)
   {
   case ACT_ALL:
      ACT_INF("Invalidating all image correction data");
      break;

   case ACT_CURRENT:
      ACT_INF("Invalidating active image correction data");
      current = ACT_getActiveDeltaBeta();
      current->valid = 0;
      break;

   default:
      ACT_INF("Invalidating %s image correction data", type == ACT_ICU ? "ICU":"ext BB");
   };

   if (type == ACT_CURRENT)
      return;

   for (i=0; i<deltaBetaDB.count; ++i)
      if (type == ACT_ALL || deltaBetaDB.deltaBeta[i]->info.type == type)
         deltaBetaDB.deltaBeta[i]->valid = 0;
}

static IRC_Status_t deleteExternalActualizationFiles()
{
   IRC_Status_t status = IRC_SUCCESS;
   int i;
   int fd;
   fileRecord_t* file = NULL;
   CalibImageCorrection_ImageCorrectionFileHeader_t header;
   uint32_t length;

   ACT_INF("Deleting external image correction files from a previous boot up");

   i = gFM_calibrationActualizationFiles.count-1;
   while (i>=0)
   {
      fileType_t type;

      file = gFM_calibrationActualizationFiles.item[i];
      type = file->type;

      if (type != FT_TSIC)
      {
         if (type == FT_TSAC)
         {
            ACT_INF("Deleting obsolete TSAC file %s", file->name);
            FM_RemoveFile(file);
         }
         --i;
         continue;
      }

      fd = FM_OpenFile(file->name, UO_RDONLY);
      length = CalibImageCorrection_ParseImageCorrectionFileHeader(fd, &header, NULL);
      uffs_close(fd);

      if (length == 0)
      {
         status = IRC_FAILURE;
         break;
      }

      if (length>0 && header.ImageCorrectionType == 1)
      {
         ACT_INF("Deleting %s", file->name);
         FM_RemoveFile(file);
      }

      --i;
   }

   return status;
}

static fileRecord_t* findActualizationFile(uint32_t ref_posixtime)
{
   int i;
   int fd;
   CalibImageCorrection_ImageCorrectionFileHeader_t header;
   uint32_t length;
   fileRecord_t* file = NULL;

   i = gFM_calibrationActualizationFiles.count-1;
   while (i>=0)
   {
      fd = FM_OpenFile(gFM_calibrationActualizationFiles.item[i]->name, UO_RDONLY);
      length = CalibImageCorrection_ParseImageCorrectionFileHeader(fd, &header, NULL);
      uffs_close(fd);

      if (length>0 && header.ReferencePOSIXTime == ref_posixtime)
      {
         ACT_PRINTF("found %s\n", gFM_calibrationActualizationFiles.item[i]->name);

         file = gFM_calibrationActualizationFiles.item[i];
         break;
      }

      --i;
   }

   return file;
}

void ACT_listActualizationData()
{
   int i;
   CalibImageCorrection_ImageCorrectionFileHeader_t header;
   uint32_t length;
   fileRecord_t* file = NULL;
   int fd;
   deltabeta_t* current = ACT_getActiveDeltaBeta();

   PRINTF("\n");
   ACT_INF("Found %d image correction file(s)", gFM_calibrationActualizationFiles.count);
   for (i=0; i<gFM_calibrationActualizationFiles.count; ++i)
   {
      file = gFM_calibrationActualizationFiles.item[i];

      if (file->type == FT_TSAC)
         continue;

      fd = FM_OpenFile(file->name, UO_RDONLY);
      length = CalibImageCorrection_ParseImageCorrectionFileHeader(fd, &header, NULL);
      uffs_close(fd);

      if (length > 0)
      {
         ACT_INF("#%d: Name = %s, Reference POSIX time = %010d, type = %d, T_IL = " _PCF(2) " K, T_Ref = " _PCF(2) " K, t_exp = " _PCF(2) " us",
               i+1, file->name, (unsigned int)header.ReferencePOSIXTime, header.ImageCorrectionType,
               _FFMT(header.TemperatureInternalLens, 2), _FFMT(header.TemperatureReference, 2), _FFMT(header.ExposureTime, 2));
      }
      else
         ACT_INF("#%d: Name = %s (Invalid image correction file)", i+1, file->name);
   }

   PRINTF("\n");
   ACT_INF("%d/%d image correction data locations used in memory", deltaBetaDB.count, MAX_DELTA_BETA_SIZE);
   for (i=0; i<deltaBetaDB.count; ++i)
   {
      deltabeta_t* data = deltaBetaDB.deltaBeta[i];
      ACT_INF("#%d: type = %d, discard offset = %d, valid = %d, age = %d s, reference POSIX time = %010d %s",
            i+1, data->info.type, data->info.discardOffset, data->valid, data->info.age, (unsigned int)data->info.referencePOSIXTime, (current==data)?"*** active ***":"");
   }
   PRINTF("\n");
}

static bool allocateDeltaBetaForCurrentBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx, bool actTypeICU, deltabeta_t** newDataOut)
{
   int i;
   deltabeta_t* newData;
   const calibBlockInfo_t* blockInfo = &calibInfo->blocks[blockIdx];

   *newDataOut = NULL;

   ACT_INF("Allocating an image correction data location in memory for block with POSIX time %010d", blockInfo->POSIXTime);

   // first, find the corresponding data if it already exists.
   newData = findMatchingDeltaBetaForBlock(calibInfo, blockIdx);

   // if not, try to add a new one to the list; if the list is full, recycle the location with the oldest data
   if (newData == NULL)
   {
      if (deltaBetaDB.count < MAX_DELTA_BETA_SIZE)
      {
         newData = &deltaBetaArray[deltaBetaDB.count];
         deltaBetaDB.deltaBeta[deltaBetaDB.count] = newData;
         ++deltaBetaDB.count;
         ACT_INF("Allocated a new image correction data location (%d/%d)", deltaBetaDB.count, MAX_DELTA_BETA_SIZE);
      }
      else // the DB is full: we must recycle a data location
      {
         uint32_t idx = 0;
         uint32_t M = 0;

         for (i=0; i<deltaBetaDB.count; ++i)
         {
            // ICU data location are protected; do not reallocate
            if (deltaBetaDB.deltaBeta[i]->info.type == ACT_ICU)
               continue;

            // find the oldest location
            if (deltaBetaDB.deltaBeta[i]->info.age >= M)
            {
               idx = i;
               M = deltaBetaDB.deltaBeta[i]->info.age;
            }
         }

         ACT_INF("Location at index %d was recycled (aged %d s)", idx, deltaBetaDB.deltaBeta[idx]->info.age);
         newData = deltaBetaDB.deltaBeta[idx];
      }
   }
   else
      ACT_INF("Existing image correction data in database (valid=%d, age=%d) will be updated", newData->valid, newData->info.age);

   if (newData) // this pointer should not be null at this point...
   {
      initDeltaBetaData(newData);
      newData->info.referencePOSIXTime = blockInfo->POSIXTime;
      newData->info.IntegrationMode = calibInfo->collection.IntegrationMode;
      newData->info.PixelDataResolution = calibInfo->collection.PixelDataResolution;
      newData->info.SensorWellDepth = calibInfo->collection.SensorWellDepth;
      if (actTypeICU)
      {
         newData->info.type = ACT_ICU;
         newData->info.discardOffset = BitTst(gActualizationParams.deltaBetaDiscardOffset, 0);
   }
      else
      {
         newData->info.type = ACT_XBB;
         newData->info.discardOffset = BitTst(gActualizationParams.deltaBetaDiscardOffset, 1);
      }
      if (gActDebugOptions.forceDiscardOffset)
         newData->info.discardOffset = 1;
   }

   *newDataOut = newData;

   return deltaBetaDB.count == MAX_DELTA_BETA_SIZE;
}

static void initDeltaBetaData(deltabeta_t* data)
{
   memset(data->deltaBeta, 0, MAX_PIXEL_COUNT * sizeof(float));
   data->valid = 0;
   data->info.age = 0;
   data->saturatedDataCount = 0;
   resetStats(&data->stats);
}

void advanceDeltaBetaAge(uint32_t increment_s)
{
   int i;
   for (i=0; i<deltaBetaDB.count; ++i)
   {
      if (deltaBetaDB.deltaBeta[i]->valid)
         deltaBetaDB.deltaBeta[i]->info.age += increment_s;
   }
}

/*
 * Return a pointer to the currently applied correction (the active calibration block). Returns NULL is none is applied.
 */
deltabeta_t* ACT_getActiveDeltaBeta()
{
   uint8_t idx;
   deltabeta_t* data = NULL;

   if (Calibration_GetActiveBlockIdx(&calibrationInfo, &idx) && calibrationInfo.blocks[idx].CalibrationSource == CS_ACTUALIZED)
      data = findSuitableDeltaBetaForBlock(&calibrationInfo, idx, true);

   return data;
}

/*
 * Return the POSIX time of the currently applied correction. returns 0 if none is applied
 */
uint32_t ACT_getActiveDeltaBetaPOSIXTime()
{
   deltabeta_t* data = ACT_getActiveDeltaBeta();
   if (data)
      return data->info.POSIXTime;
   else
      return 0;
}

/*
 * Return a pointer to an existing actualisation data which can be applied to the selected block. Simply a wrapper to the private function
 * Order of precedence : xbb->icu->none
 */
deltabeta_t* ACT_getSuitableDeltaBetaForBlock(const calibrationInfo_t* calibInfo, uint8_t blockIdx)
{
   return findSuitableDeltaBetaForBlock(calibInfo, blockIdx, false);
}

static uint32_t cleanBetaDistributionIterate(float* beta, int N, float threshold, statistics_t* stats, bool verbose)
{
   const float bp_code = infinityf(); // bad pixels are replaced by inf

   int i;
   float data_thresh; // threshold scaled on the actual data
   uint32_t nbp = 0;
   float lowerThreshold, higherThreshold; // thresholds centered about the average value

   resetStats(stats);

   // calculer std de x, sans inclure les bad pixels (inf). Compter le nombre de bad pixels.
   for (i=0; i<N; ++i)
   {
      float val = beta[i];
      if (!isinf(val))
         updateStats(stats, val);
   }

   // calculer le nouveau seuil
   data_thresh = threshold * sqrtf(stats->var);

   // étiqueter les pixels hors limite, i.e. abs(x-moy) > thresh * std_x
   lowerThreshold = stats->mu - data_thresh;
   higherThreshold = stats->mu + data_thresh;

   nbp = 0;
   for (i=0; i<N; ++i)
   {
      float val = beta[i];
      if (val < lowerThreshold || val > higherThreshold)
      {
         beta[i] = bp_code;
         ++nbp;
      }
   }
   if (verbose)
   {
      ACT_INF("std = " _PCF(2) ", mu = " _PCF(2), _FFMT(sqrtf(stats->var),2), _FFMT(stats->mu,2));
      ACT_INF("min = " _PCF(2) ", max = " _PCF(2), _FFMT(stats->min,2), _FFMT(stats->max,2));
      ACT_INF("Lower threshold = " _PCF(2) ", higher threshold = " _PCF(2), _FFMT(lowerThreshold, 2), _FFMT(higherThreshold, 2));
   }

   return nbp;
}

static IRC_Status_t cleanBetaDistribution(float* beta, int N, float p_FA, statistics_t* stats, uint32_t* numBadPixels, bool verbose)
{
   const float thresh = invnormcdf(1-p_FA);
   const int maxIter = 100;

   static uint32_t prev_nbp = 0;
   static uint8_t niter = 0;
   uint32_t nbp;

   IRC_Status_t status;

   if (verbose && niter == 0)
   {
      ACT_INF("cleanBetaDistribution: p_FA = " _PCF(6) ", thresh = "  _PCF(4), _FFMT(p_FA,6), _FFMT(thresh,4));
   }

   nbp = cleanBetaDistributionIterate(beta, N, thresh, stats, verbose);

   ++niter;

   if (verbose)
   {
      ACT_INF("Iteration %d, number of bad pixels: %d", niter, nbp);
   }

   if (prev_nbp == nbp || niter >= maxIter)
   {
      niter = 0;
      prev_nbp = 0;
      status = IRC_DONE;
   }
   else
   {
      prev_nbp = nbp;
      status = IRC_NOT_DONE;
   }

   *numBadPixels = nbp;

   return status;
}

static float nth_element_f(const float* input, float minval, float* buffer, int N, int r)
{
   int i;
   union {
      float f;
      uint32_t i;
   } p;

   // compute the median (can not be split over multiple block operations)

   // copy the data into buffer first because the select() function modifies the array
   for (i=0; i<N; ++i)
      buffer[i] = input[i] - minval;

   // CR_TRICKY comparing *positive* floats type-casted as uint32_t is equivalent
   p.i = select((uint32_t*)buffer, 0, N, r);
   p.f += minval;

   return p.f;
}

static uint32_t nth_element_i(const uint32_t* input, uint32_t* buffer, int N, int r)
{
   uint32_t p;
   int i;

   // copy the data into buffer first because the select() function modifies the array
   for (i=0; i<N; ++i)
      buffer[i] = input[i];

   p = select(buffer, 0, N, r);

   return p;
}

static uint32_t countBadPixels(const uint64_t* pixelData, int N)
{
   int i;
   int bp = 0;

   for (i=0; i<N; ++i)
   {
      if (BitMaskTst(*pixelData, CALIBBLOCK_PIXELDATA_BADPIXEL_MASK) == 0)
         ++bp;

      ++pixelData;
   }

   return bp;
}

IRC_Status_t BetaQuantizer_SM(uint8_t blockIdx)
{
   static BQ_State_t state = BQ_Idle;

   uint64_t t0; // for RT benchmarking
   static uint64_t tic; // used for cleanDistribution benchmarking
   static uint64_t tic_TotalDuration; // used for benchmarking the total time
   static uint64_t tic_RT_Duration; // used for benchmarking the actual time taken for building the statistics

   static context_t blockContext; // information structure for block processing

   static deltabeta_t* currentDeltaBeta = NULL;
   static statistics_t beta_stats;
   static uint32_t numBadPixels;
   static uint32_t initialNumBadPixels;

   bool error = false;

   int i, k;
   IRC_Status_t rtnStatus = IRC_NOT_DONE;

   static const float p_FA = 1.0/MAX_PIXEL_COUNT; // allow 1 good pixel to be excluded
   static const uint32_t numPixels = FPA_HEIGHT_MAX * FPA_WIDTH_MAX;

   float* betaArray = (float*)mu_buffer; // buffer recycling

   switch (state)
   {
   case BQ_Idle:

      gBetaUpdateDone = true;
      rtnStatus = IRC_DONE;

      if (gStartBetaQuantization)
      {
         rtnStatus = IRC_NOT_DONE;

         gStartBetaQuantization = false;

         gBetaUpdateDone = false;

         currentDeltaBeta = ACT_getSuitableDeltaBetaForBlock(&calibrationInfo, blockIdx);
         if (currentDeltaBeta != NULL)
         {
            GETTIME(&tic_TotalDuration);
            tic_RT_Duration = 0;
            ctxtInit(&blockContext, 0, numPixels, ACT_MAX_PIX_DATA_TO_PROCESS);
            setBqState(&state, BQ_UpdateBeta);
         }
      }
      break;

   case BQ_UpdateBeta:
      {
         // decode beta and update it with deltaBeta into betaArray
         uint32_t* calAddr = (uint32_t*)(PROC_MEM_PIXEL_DATA_BASEADDR + (blockIdx * CM_CALIB_BLOCK_PIXEL_DATA_SIZE));

         GETTIME(&t0);

         if (blockContext.blockIdx == 0)
         {
            initialNumBadPixels = 0;
         }

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            float beta = decodeBeta(&calAddr[k*2], &calibrationInfo.blocks[blockIdx]);
            betaArray[k] = beta + currentDeltaBeta->deltaBeta[k];

            if (isinf(beta))
               ++initialNumBadPixels;
         }
         tic_RT_Duration += elapsed_time_us(t0);

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            tic = tic_RT_Duration;
            setBqState(&state, BQ_CleanDistribution);
         }
      }
      break;

   case BQ_CleanDistribution:
      {
         IRC_Status_t cleanDistribStatus;
         GETTIME(&t0);

         cleanDistribStatus = cleanBetaDistribution(betaArray, numPixels, p_FA, &beta_stats, &numBadPixels, gActDebugOptions.verbose);
         tic_RT_Duration += elapsed_time_us(t0);

         if (cleanDistribStatus == IRC_DONE)
         {
            ACT_INF("%d bad pixels after cleaning distribution", numBadPixels);
            ACT_INF("cleanBetaDistribution took %d ms", (uint32_t)(tic_RT_Duration-tic)/1000);
            ctxtInit(&blockContext, 0, numPixels, ACT_MAX_PIX_DATA_TO_PROCESS);
            setBqState(&state, BQ_QuantizeBeta);
         }
      }
      break;

   case BQ_QuantizeBeta:
      {
         uint32_t* calAddr = (uint32_t*)(PROC_MEM_PIXEL_DATA_BASEADDR + (blockIdx * CM_CALIB_BLOCK_PIXEL_DATA_SIZE));
         uint8_t nbits = calibrationInfo.blocks[blockIdx].pixelData.Beta0_Nbits;
         const float beta_offset = 0; // CR_WARNING beta offset is currently always 0 (the calibration chain does not support other values)
         int8_t newExponent;

         GETTIME(&t0);

         // upon state entry, compute a new value for the beta exponent based on the badpixel-free statistics
         if (blockContext.blockIdx == 0)
         {
            const float arg1 = (beta_offset - beta_stats.min)/(exp2f(nbits-1)-1);
            const float arg2 = (beta_stats.max - beta_offset)/(exp2f(nbits-1)-2);

            numBadPixels = 0;

            if (beta_stats.max - beta_offset <= 0) // negative values only
            {
               newExponent = (int8_t)ceilf(log2f(arg1));
            }
            else if (beta_stats.min - beta_offset >= 0) // positive values only
            {
               newExponent = (int8_t)ceilf(log2f(arg2));
            }
            else // double-sided (most probable)
            {
               newExponent = (int8_t)MAX(ceilf(log2f(arg1)), ceilf(log2f(arg2)));
            }

            if (gActDebugOptions.verbose)
            {
               float qmin, qmax;
               float qstep = exp2f((float)newExponent);

               if (calibrationInfo.blocks[blockIdx].pixelData.Beta0_Signed)
               {
                  qmin = -qstep * exp2f(nbits-1) + beta_offset;
                  qmax = qstep * (exp2f(nbits-1) - 1) + beta_offset;
               }
               else
               {
                  qmin = beta_offset;
                  qmax = qstep * (exp2f(nbits) - 1) + beta_offset;
               }
               ACT_INF("New beta exponent = %d (original exponent = %d)", newExponent, calibrationInfo.blocks[blockIdx].pixelData.Beta0_Exp);
               ACT_INF("qmin = " _PCF(4) ", qmax = " _PCF(4), _FFMT(qmin, 4), _FFMT(qmax,4));
            }

            calibrationInfo.blocks[blockIdx].pixelData.Beta0_Exp = newExponent;
            calibrationInfo.blocks[blockIdx].pixelData.Beta0_Off = beta_offset; // CR_WARNING currently always 0
         }

         for (i=0, k=blockContext.startIndex; i<blockContext.blockLength; ++i, ++k)
         {
            //quantizeDeltaBeta(deltaBetaLSB, currentDeltaBeta->deltaBeta[k] - offset, &d[k]))
            if (encodeBeta(betaArray[k], &calAddr[2*k], &calibrationInfo.blocks[blockIdx]))
               ++numBadPixels;
         }
         tic_RT_Duration += elapsed_time_us(t0);

         ctxtIterate(&blockContext);

         if (ctxtIsDone(&blockContext))
         {
            ACT_INF("%d bad pixels after beta update (%d new, %d from block)", numBadPixels, numBadPixels-initialNumBadPixels, initialNumBadPixels);
            setBqState(&state, BQ_Done);
         }
      }
      break;

   case BQ_Done:

      gBetaUpdateDone = true;

         ACT_INF( "BetaQuantization took %d ms", (uint32_t)elapsed_time_us(tic_TotalDuration)/1000);
         ACT_INF( "BetaQuantization took (real time) " _PCF(2) " s", _FFMT((float) (tic_RT_Duration) / ((float)TIME_ONE_SECOND_US), 2) );

      setBqState(&state, BQ_Idle);
      rtnStatus = IRC_DONE;

      break;

   default:
      ACT_ERR("Unknown BPD state (%d)", state);
      rtnStatus = IRC_FAILURE;
   }

   if (error == true)
   {
      // Reset state machine
      setBqState(&state, BQ_Idle);

      rtnStatus = IRC_FAILURE;
   }

   return rtnStatus;
}

static float decodeBeta(const uint32_t* p_CalData, const calibBlockInfo_t* blockInfo)
{
   int16_t raw_beta;
   uint64_t calData;
   float beta;
   bool isBad = false;

   float exponent = exp2f(blockInfo->pixelData.Beta0_Exp);
   float offset = blockInfo->pixelData.Beta0_Off; // usually 0

   calData = (uint64_t)*p_CalData++;
   calData |= ((uint64_t)*p_CalData << 32);

   // Extract current beta from current calibration data
   raw_beta = (int16_t) ((calData & CALIBBLOCK_PIXELDATA_BETA0_MASK) >> CALIBBLOCK_PIXELDATA_BETA0_SHIFT );
   SIGN_EXT16( raw_beta, blockInfo->pixelData.Beta0_Nbits );

   if (BitTst(calData, CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT) == 0)
      isBad = true;

   beta = (float)raw_beta * exponent + offset;

   if (isBad)
      beta = infinityf();

   return beta;
}

static bool encodeBeta(float value, uint32_t* p_CalData, const calibBlockInfo_t* blockInfo)
{
   const float qstep = exp2f(blockInfo->pixelData.Beta0_Exp);

   uint64_t* pixelDataAddr = (uint64_t*)p_CalData;
   uint64_t pixelData;

   static const int16_t minRawData = -CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS; //-2^10
   static const int16_t maxRawData = CALIBBLOCK_PIXELDATA_BETA0_SIGNPOS - 1;  // 2^10 - 1
   static const int16_t max16s = SHRT_MAX;
   static const int16_t min16s = SHRT_MIN;
   int16_t raw_beta = 0;
   bool isNewBadPixel = false;

   raw_beta = (int16_t) MIN( MAX( roundf(value / qstep), min16s), max16s);

   // check if it now has become a bad pixel -> according to the saturation status of delta beta only
   // there might be more new bad pixels when a calibration block is updated with the delta beta value
   if (raw_beta <= minRawData)
   {
      isNewBadPixel = true;
      raw_beta = minRawData;
   }

   if (raw_beta >= maxRawData)
   {
      isNewBadPixel = true;
      raw_beta = maxRawData;
   }

   pixelDataAddr = (uint64_t*)p_CalData;
   pixelData = (uint64_t)*p_CalData++;
   pixelData |= ((uint64_t)*p_CalData++ << 32);

   BitMaskClr(pixelData, CALIBBLOCK_PIXELDATA_BETA0_MASK);
   pixelData |= ( ((uint64_t)raw_beta) << CALIBBLOCK_PIXELDATA_BETA0_SHIFT ) & CALIBBLOCK_PIXELDATA_BETA0_MASK;

   //calData &= ~CALIBBLOCK_PIXELDATA_BETA0_MASK;
   //calData |= ( ((uint64_t)raw_corr_beta) << CALIBBLOCK_PIXELDATA_BETA0_SHIFT ) & CALIBBLOCK_PIXELDATA_BETA0_MASK;

   // now set the NewBadPixel bit (in reverse logic)
   if (isNewBadPixel)
      BitClr(pixelData, CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT);
   else
      BitSet(pixelData, CALIBBLOCK_PIXELDATA_BADPIXEL_SHIFT);

   *pixelDataAddr = pixelData;

#ifdef ACT_VERBOSE
   static uint32_t counter = 0;
   uint32_t col = counter % gcRegsData.SensorWidth;
   uint32_t line = counter / gcRegsData.SensorWidth;
   bool verboseData = ( col % 128 == 0 ) && (( line % 128 == 0 ) || line+1 == gcRegsData.SensorHeight);
   ++counter;
   counter %= MAX_PIXEL_COUNT;
   if (0 && isNewBadPixel)
   {
      ACT_TRC( "quantizeDeltaBeta(): Bad Pixel (r=%d, c=%d)\n", line, col );
   }

   if ( verboseData )
   {
      int16_t tmp;
      ACT_TRC( "Pixel (r=%d, c=%d)\n", line, col );
      tmp = (raw_beta & CALIBBLOCK_PIXELDATA_BETA0_MASK);
      SIGN_EXT16(tmp, blockInfo->pixelData.Beta0_Nbits);
      ACT_TRC( "   delta_beta: %d x 2^%d (" _PCF(6) ") %s\n", tmp, exponent, _FFMT(value, 6), isNewBadPixel?"**new bad pixel**":"" );
      ACT_TRC( "   raw_delta_beta (sat) : %d\n", tmp );
   }
#endif

   return isNewBadPixel;
}

static bool findImageForBlock(uint8_t blockIdx, uint32_t* seqOffset, uint32_t frameSize, uint32_t nbImg)
{
   uint32_t i;
   bool found = false;  //default
   uint8_t* p_img = (uint8_t*)*seqOffset;

   for (i = 0; i < nbImg; i++)
   {
      // Verify if the block index is the one we are looking for
      if (*(p_img + CalibrationBlockIndexHdrAddr) == blockIdx)
      {
         // First image becomes the image found
         *seqOffset = (uint32_t)p_img;
         found = true;
         break;
      }

      // Move to next frame
      p_img += frameSize;
   }

   return found;
}
