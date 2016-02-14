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
#include "CalibActualizationFile.h"
#include "hder_inserter.h"
#include "CalibBlockFile.h"
#include "CRC.h"
#include "trig_gen.h"
#include "xil_cache.h"
#include "uffs\uffs.h"
#include "uffs\uffs_fd.h"
#include "GC_Registers.h"
#include "GC_Events.h"
#include "GC_Callback.h"
#include "GenICam.h"
#include "tel2000_param.h"
#include "proc_memory.h"
#include "timer.h"
#include "utils.h"
#include "BuiltInTests.h"

#include <math.h>
#include <stdbool.h> // bool
#include <string.h> // for memcpy()
#include <stddef.h> // NULL

extern t_Trig gTrig;
extern ICU_config_t gICU_ctrl;
extern t_AEC gAEC_Ctrl;
extern t_bufferManager gBufManager;
extern t_HderInserter gHderInserter;

bool gActDeltaBetaAvailable = false; /**< indicates the validity of the actualization data in memory */
bool gActAllowAcquisitionStart = false;
actOptions_t gActualizationOptions;

#ifdef ACT_VERBOSE
static uint32_t PixCounter;
#endif

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
} BC_CoaddData_t;

typedef struct
{
   float deltaBeta_test;
   float FcalBB_test;
   float TcalBB_test;
   float alpha_test;
} validation_data_t;
validation_data_t test_data;

extern flashSettings_t flashSettings;

extern fileList_t gFM_calibrationBlocks;

// private stuff
static BlockFileHeader_t refBlockFileHdr; // a header buffer for searching through blocks in flash memory
static ActualizationFileHeader_t actFileHeader;
static ActualizationDataHeader_t actDataHeader;

static ICUParams_t icuParams;

static timerData_t act_timer; // used to mesure timeouts
static timerData_t act_tic_verbose; // used to limit the number of repeated verbose
static timerData_t act_tic_stability; // used during the ICU temperature stabilisation

static int32_t DeltaBeta_Exp; /**< the exponent used in the reference block */

static bool gStartActualization = false;
static uint8_t gWriteActualizationFile = 0;
static uint16_t dataCRC;
static bool usingICU = true; // set to true when the actualisation was internally triggered
static bool disableCalibUpdate = false;
uint32_t gActualisationPosixTime = 0; // (not a rigorous posix time, merely a unique ID). Proxy variable to actualisationPosixTimeInternal, value can switch between that and 0.
static uint32_t privateActualisationPosixTime = 0; // this one is the actual value

#define LUT_RT_ADDR TEL_PAR_TEL_RQC_LUT_BASEADDR

static void setBCState( BC_State_t* p_state, BC_State_t state );
static void backupGCRegisters( BC_GCRegsBackup_t* p_GCRegsBackup );
static void restoreGCRegisters( BC_GCRegsBackup_t* p_GCRegsBackup );
static float applyLUT( uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float x );
static float applyReverseLUT( uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float y_target, bool verbose );
static LUTRQInfo_t* selectLUT(calibBlockInfo_t* blockInfo, uint8_t type);
static void unpackLUTData( uint32_t LUTData, LUTRQInfo_t* p_LUTInfo, float* p_m, float* p_b, bool verbose );
static bool computeDeltaBeta( uint64_t* p_CalData, float FCal, float FCalBB, float Alpha_LSB, float Beta_LSB, const calibBlockInfo_t* blockInfo, int32_t* deltaBetaOut);
static IRC_Status_t ActualizationFileWriter_SM();
static fileRecord_t* findIcuReferenceBlock();
static uint8_t updatePixelDataElement(const calibBlockInfo_t* blockInfo, uint64_t *p_CalData, int16_t deltaBeta, int8_t expBitShift);

#ifdef ACT_TEST_NOBUFFERING
static uint32_t fillDebugData(uint16_t* data, uint32_t c0, uint32_t frameSize, uint32_t numFrames);
#endif

static void defineActualizationFilename(char* buf, uint8_t length, uint32_t timestamp);

static void ACT_init();

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
void setBCState( BC_State_t *p_state, BC_State_t state )
{
   *p_state = state;

   switch (state)
   {
   case BC_Idle:
     ACT_PRINTF( "State = BC_Idle\n");
     break;
   case BC_Start:
     ACT_PRINTF( "State = BC_Start\n");
     break;
   case BC_WaitForCalibData:
     ACT_PRINTF( "State = BC_WaitForCalibData\n");
     break;
   case BC_TransitionICU:
     ACT_PRINTF( "State = BC_TransitionICU\n");
     break;
   case BC_WaitICU:
     ACT_PRINTF( "State = BC_WaitICU\n");
     break;
   case BC_StabilizeICU:
     ACT_PRINTF( "State = BC_StabilizeICU\n");
     break;
   case BC_StartAECAcquisition:
     ACT_PRINTF( "State = BC_StartAECAcquisition\n");
     break;
   case BC_StartAEC:
     ACT_PRINTF( "State = BC_StartAEC\n");
     break;
   case BC_StopAECAcquisition:
     ACT_PRINTF( "State = BC_StopAECAcquisition\n");
     break;
   case BC_StartAcquisition:
     ACT_PRINTF( "State = BC_StartAcquisition\n");
     break;
   case BC_WaitSequenceReady:
     ACT_PRINTF( "State = BC_WaitSequenceReady\n");
     break;
   case BC_ComputeAveragedImage:
      ACT_PRINTF( "State = BC_ComputeAveragedImage\n");
      break;
   case BC_FinalizeSequence:
      ACT_PRINTF( "State = BC_WaitStopAcquisition\n");
      break;
   case BC_ComputeBlackBodyFCal:
     ACT_PRINTF( "State = BC_ComputeBlackBodyFCal\n");
     break;
   case BC_ComputeDeltaBeta:
     ACT_PRINTF( "State = BC_ComputeDeltaBeta\n");
     break;
   case BC_WriteActualizationFile:
     ACT_PRINTF( "State = BC_WriteActualizationFile\n");
     break;
   case BC_Finalize:
     ACT_PRINTF( "State = BC_Finalize\n");
     break;
   default:
      ACT_PRINTF( "State = %d\n", state);
   }
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
IRC_Status_t startBetaCorrectionSM( bool internalTrig )
{
   builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Pending;

   if ( TDCFlagsTst(CalibrationActualizationIsImplementedMask) == 0 )
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("Actualization is not implemented on this model.");
      return IRC_FAILURE;
   }

   if (!flashSettings.ActualizationEnabled || !flashSettings.isValid)
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("Actualization is not enabled on this camera.");
      return IRC_FAILURE;
   }

   // process is disabled if the external buffer memory is not present and the internal buffer is not empty
   if (!TDCFlagsTst(ExternalMemoryBufferIsImplementedMask) && BufferManager_GetNumSequenceCount(&gBufManager) != 0)
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("Could not perform actualization because some sequences were recorded in buffer memory.");
      return IRC_FAILURE;
   }

   usingICU = internalTrig;

   if ( TDCStatusTst(WaitingForCalibrationActualizationMask) )
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      PRINTF("ACT: Actualization is already running.\n");
      return IRC_FAILURE;
   }

   if (internalTrig)
   {
      // set the flag early so that the status LED does not become green for a short period of time.
      TDCStatusSet(WaitingForCalibrationActualizationMask);
      PRINTF( "Starting actualization (internal command)...\n" );
   }
   else
      PRINTF( "Starting actualization (external command)...\n" );

   // Start beta correction
   gStartActualization = 1;

   return IRC_DONE;
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

#define SCALE_FACTOR_TRICK 1

IRC_Status_t BetaCorrection_SM( void )
{
   static BC_State_t state = BC_Init;
   static uint64_t tic_BCDuration; // for counting the total elapsed time during calibration update
   static uint64_t tic_AvgDuration; //used for measuring the elapsed time during the averaged (not real time)
   static uint64_t tic_RT_Duration; // used for benchmarking the real time effort of the averaging and other computation
   static uint32_t *p_Data;
   static uint32_t *p_PixData;
   static uint32_t *p_DeltaBeta;
   static float FCalBB;
   static float min_temp;
   static float max_temp;
   static uint32_t numDataToProcess;
   static BC_GCRegsBackup_t GCRegsBackup;
   static float Alpha_LSB;
   static float Beta_LSB;
   static uint32_t expectedSum; // used in debug data mode
#if SCALE_FACTOR_TRICK // TODO enlever quand validé
   float scaleFCal;
#else
   static float scaleFCal;
#endif
   static BC_CoaddData_t coaddData;
   static uint32_t savedCalibPosixTime; // posix time of the calibration block to be reloaded at the end of the update
   static uint32_t dataOffset;
   static uint32_t pixelOffset;
   static uint32_t sequenceOffset = 0; // start of the first image of the buffered sequence [bytes]
   static uint32_t coaddSequenceOffset = 0; // start of the first image passed the buffered sequence [bytes]
   static uint8_t icuPhase = 0;
   static float ICUTemp;
   static float prevExpTime;
   static uint32_t newBadPixelCount = 0; // just for stats

   uint16_t i;
   bool error = false;
   uint16_t blockSize;
   float FCal;
   float T_BB;
   int32_t DeltaBetaH, DeltaBetaL;
   IRC_Status_t rtnStatus = IRC_NOT_DONE;
   IRC_Status_t writeStatus;
   fileRecord_t* icuCalibFileRec;

   calibBlockInfo_t* blockInfo = &calibrationInfo.blocks[0]; // TODO valider choix du bloc, en particulier en mode BB externe / multibloc
   uint32_t* coadd_buffer = NULL; // address of the co-added image in DDR
   // float* delta_beta_full = NULL; // address of the single float delta beta image in DDR
   uint16_t* seq_buffer = NULL; // address of the image sequence in DDR

   switch (state)
   {
   case BC_Init:
      ACT_init();
      setBCState(&state, BC_Idle);
      break;

   case BC_Idle:
      {
         bool notCameraReady = TDCStatusTstAny(WaitingForCoolerMask | WaitingForCalibrationInitMask | WaitingForPowerMask);

         StopTimer(&act_tic_verbose);
         StopTimer(&act_timer);
         StopTimer(&act_tic_stability);

         gActAllowAcquisitionStart = false;

         if (gStartActualization && notCameraReady == 0 && calibrationInfo.isValid)
         {
            gStartActualization = 0;
            savedCalibPosixTime = 0;

            TDCStatusSet(WaitingForCalibrationActualizationMask);

            setBCState(&state, BC_Start);
         }
      }
      break;

      case BC_Start:
         StartTimer(&act_tic_verbose, TIME_ONE_SECOND_US/1000.0);

         GETTIME(&tic_BCDuration);

         disableCalibUpdate = false; // we want a plain calibration upon loading it

         gActAllowAcquisitionStart = true;

         setDefaultIcuParams(&icuParams);

         // Backup registers value
         backupGCRegisters( &GCRegsBackup );

         // If an acquisition has been started, stop it
         if ( TDCStatusTst(AcquisitionStartedMask) )
         {
            GC_SetAcquisitionStop(1);
         }

         icuPhase = 1;

         gcRegsData.EHDRINumberOfExposures = 1; // disable EHDRI
         gcRegsData.CalibrationMode = CM_RT; // make sure the RT LUTRQ gets loaded by the calibration manager
         gcRegsData.TestImageSelector = TIS_Off;

         if ( TDCFlagsTst(ICUIsImplementedMask) && (usingICU || gcRegsData.CalibrationActualizationMode == CAM_ICU))
         {
            usingICU = true;
            PRINTF("ACT: Updating calibration using the internal calibration unit.\n");

            // Load ICU calibration data
            icuCalibFileRec = findIcuReferenceBlock();

            if (icuCalibFileRec != 0)
            {
               // initiate the loading of the reference block
               savedCalibPosixTime = calibrationInfo.collection.POSIXTime;

               Calibration_LoadCalibrationFile(icuCalibFileRec);

               setBCState(&state, BC_WaitForCalibData);
            }
            else
            {
               ACT_ERR( "Could not find a matching ICU file.");
               GC_GenerateEventError(EECD_ActualizationInvalidReferenceBlock);
               error = true;
            }

            StartTimer(&act_timer, ACT_WAIT_FOR_DATA_TIMEOUT/1000);
         }
         else // gcRegsData.CalibrationActualizationMode == CAM_BlackBody
         {
            // cas sans ICU -> BB externe. Utiliser alors la calibration en cours comme bloc de référence Passer à l'état BC_StartAECAcquisition
            PRINTF("ACT: Updating calibration using an external blackbody.\n");

            usingICU = false;

            // reload the current calibration, because we do not want to update a calibration that has already been calibrated
            savedCalibPosixTime = calibrationInfo.collection.POSIXTime;
            Calibration_LoadCalibrationFilePOSIXTime(calibrationInfo.collection.POSIXTime);

            setBCState(&state, BC_WaitForCalibData);
            StartTimer(&act_timer, ACT_WAIT_FOR_DATA_TIMEOUT/1000);
         }

         break;

      case BC_WaitForCalibData:
         // Check for calib data loading
         if (TDCStatusTst(WaitingForCalibrationDataMask) == 0
               && TDCStatusTst(WaitingForFilterWheelMask) == 0)
         {
            if (usingICU)
            {
             // if reference block was not successfully loaded...
               if (refBlockFileHdr.POSIXTime == blockInfo->POSIXTime)
               {
                  // TODO la sélection de la LUT pourrait etre faite ici (lutInfo)

                //  setBCState( &state, BC_PositionICUMotorBB );

                  // place the ICU out of the FOV in phase 1
                  icuPhase = 1;
                  ICU_scene(&gcRegsData, &gICU_ctrl);

                  setBCState( &state, BC_TransitionICU );
               }
               else
               {
                  ACT_ERR( "Could not load the ICU reference block." );
                  GC_GenerateEventError(EECD_ActualizationInvalidReferenceBlock);
                  error = true;
               }
            }
            else // external blackbody
               setBCState(&state, BC_StartAECAcquisition);
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while loading reference block." );
            GC_GenerateEventError(EECD_ActualizationInvalidReferenceBlock);
            error = true;
         }

         break;

      case BC_TransitionICU:
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
            setBCState(&state, BC_WaitICU);
         }
         break;

      case BC_WaitICU:
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
            setBCState(&state, BC_StabilizeICU);
         }
         break;

      case BC_StabilizeICU:
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
            ACT_PRINTF( "ICU phase %d (%dms)\n", icuPhase, (uint32_t) elapsed_time_us( tic_BCDuration ) / 1000 );
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
               setBCState(&state, BC_TransitionICU);
            }
            else // all ICU phases completed
            {
               icuPhase = 0;
               StartTimer(&act_timer, ACT_WAIT_FOR_ACQ_TIMEOUT/1000);
               ICUTemp = DeviceTemperatureAry[icuParams.TemperatureSelector];
               setBCState( &state, BC_StartAECAcquisition );
            }
         }
      }
         break;

      case BC_StartAECAcquisition:

         // Ensure that no acquisition is running, cooldown period is over and camera is powered on
         if (!TDCStatusTst(AcquisitionStartedMask) && !TDCStatusTst(WaitingForCoolerMask))
         {
            ACT_PRINTF( "Ready for AEC acquisition! (%dms)\n", (uint32_t) elapsed_time_us( tic_BCDuration ) / 1000 );

            // Prepare acquisition -> full width
            GC_SetWidth(gcRegsData.SensorWidth);
            GC_SetHeight(gcRegsData.SensorHeight);
            GC_RegisterWriteUI32(&gcRegsDef[OffsetXIdx], 0);
            GC_RegisterWriteUI32(&gcRegsDef[OffsetYIdx], 0);
            GC_SetAcquisitionFrameRate(MAX(25.0F, (float)refBlockFileHdr.AcquisitionFrameRate/1000.0)); // TODO si pas d'ICU, prendre un frame rate pré-déterminé? (ex. 25)

            // set the starting point for the exposure time
            gcRegsData.ExposureTime = (float)refBlockFileHdr.ExposureTime * CALIB_BLOCKFILE_EXP_TIME_TO_US;
            if (gcRegsData.ExposureTime <= FPA_MIN_EXPOSURE || gcRegsData.ExposureTime >= FPA_MAX_EXPOSURE)
               gcRegsData.ExposureTime = FPA_DEFAULT_EXPOSURE;

            if (gActualizationOptions.useDebugData)
               gcRegsData.CalibrationMode = CM_Raw0;
            else
               gcRegsData.CalibrationMode = CM_NUC;

            gcRegsData.SensorWellDepth = refBlockFileHdr.SensorWellDepth;

            // disable buffering in case it was ON
            //BufferManager_SetBufferMode(&gBufManager, BM_OFF, &gcRegsData);

            StartTimer(&act_timer, ACT_WAIT_FOR_ACQ_TIMEOUT/1000);

            if (gActualizationOptions.bypassAEC)
            {
               ACT_PRINTF( "AEC mode disabled\n");
               StartTimer(&act_timer, 0); // no need to wait if AEC is disabled
               setBCState( &state, BC_StartAcquisition );
               // Make sure AEC is stopped
               GC_RegisterWriteUI32(&gcRegsDef[ExposureAutoIdx], EA_Off);
            }
            else
            {
               // Start acqusition
               GC_SetAcquisitionStart(1);

               setBCState( &state, BC_StartAEC );
            }
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while waiting for acquisition stop.");
            GC_GenerateEventError(EECD_ActualizationAcquisitionTimeout);
            error = true;
         }
         break;

      case BC_StartAEC: // State 6
         // Wait until the acquisition is started
         if ( TDCStatusTst(AcquisitionStartedMask) )
         {
            // Perform an AEC
            GC_RegisterWriteFloat(&gcRegsDef[AECTargetWellFillingIdx], flashSettings.ActualizationAECTargetWellFilling);
            GC_RegisterWriteFloat(&gcRegsDef[AECResponseTimeIdx], flashSettings.ActualizationAECResponseTime);
            GC_RegisterWriteFloat(&gcRegsDef[AECImageFractionIdx], flashSettings.ActualizationAECImageFraction);
            GC_RegisterWriteUI32(&gcRegsDef[ExposureAutoIdx], EA_Continuous);

            prevExpTime = gcRegsData.ExposureTime;
            // set a timer for the stability criterion
            StartTimer(&act_tic_stability, ACT_WAIT_FOR_AEC_TIMEOUT/1000);
            // set a timeout
            StartTimer(&act_timer, 4*ACT_WAIT_FOR_AEC_TIMEOUT/1000);

            setBCState( &state, BC_StopAECAcquisition );
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while waiting for acquisition start.");
            GC_GenerateEventError(EECD_ActualizationAcquisitionTimeout);
            error = true;
         }
         break;

      case BC_StopAECAcquisition: // State 7

         if ( fabsf( prevExpTime - gcRegsData.ExposureTime) > ACT_AEC_EXPTIME_TOL)
         {
            RestartTimer(&act_tic_stability);
         }
         prevExpTime = gcRegsData.ExposureTime;

         // Wait until the AEC period is over then stop acquisition
         if (TimedOut(&act_tic_stability) || TimedOut(&act_timer))
         {
            // Stop AEC
            GC_RegisterWriteUI32(&gcRegsDef[ExposureAutoIdx], EA_Off);

            // Stop acquisition
            GC_SetAcquisitionStop(1);

            ACT_PRINTF( "AEC acquisition done (%d ms)\n", (uint32_t) elapsed_time_us( tic_BCDuration ) / 1000 );
            ACT_PRINTF( "AEC Exposure time is " _PCF(2) " µs\n", _FFMT(gcRegsData.ExposureTime, 2) );

            StartTimer(&act_timer, 1000);

            setBCState( &state, BC_StartAcquisition );
         }
         break;

      case BC_StartAcquisition: // State 8
         // Wait until the previous acquisition stop is effective
         if ( TDCStatusTst(AcquisitionStartedMask) == 0 && TimedOut(&act_timer))
         {
            coaddData.NCoadd = MIN(flashSettings.ActualizationNumberOfImagesCoadd, ACT_MAX_N_COADD); // to do prendre dans flash settings


            if (gActualizationOptions.useDebugData)
            {
               coaddData.NCoadd = 16;
               gcRegsData.TestImageSelector = TIS_TelopsConstantValue1;
            }

            PRINTF( "ACT: Exposure time = %d us\n", (uint32_t) gcRegsData.ExposureTime );
            ACT_PRINTF( "AcquisitionFrameRate = %d\n", (uint32_t) gcRegsData.AcquisitionFrameRate );

            // configurer le buffering pour coaddData.NCoadd images
            // always using the internal buffer
            BufferManager_SetSwitchConfig(&gBufManager, BM_SWITCH_INTERNAL_LIVE);
            gcRegsData.MemoryBufferSequencePreMOISize = 0;
            gcRegsData.MemoryBufferSequenceSize = coaddData.NCoadd + 2; // +2 to protect the coadd buffer space
            gcRegsData.MemoryBufferNumberOfSequences = 1;
            gcRegsData.MemoryBufferMOISource = MBMOIS_AcquisitionStarted;
            BufferManager_SetMoiConfig(&gBufManager);
            BufferManager_ClearSequence(&gBufManager, &gcRegsData);
            BufferManager_SetBufferMode(&gBufManager, BM_WRITE, &gcRegsData);

            // start acquisition (arm is handled automatically)
            GC_SetAcquisitionStart(1);

            StartTimer(&act_timer, ACT_WAIT_FOR_SEQ_TIMEOUT/1000);

            setBCState( &state, BC_WaitSequenceReady );
         }
         break;

      case BC_WaitSequenceReady: // State 9
         // Wait until we have all the requested images for averaging
         if (TDCStatusTst(AcquisitionStartedMask) && BufferManager_GetNumSequenceCount(&gBufManager) == 1)
         {
            // CR_WARNING : because the sequence count increments at the *beginning* of the last frame,
            // wait at least for the duration of two frames to make sure we have all the frames before we start computation
            //StopTimer(&act_timer);
            StartTimer(&act_timer, 2000.0/gcRegsData.AcquisitionFrameRate);
            setBCState( &state, BC_FinalizeSequence );
         }
         else if (TimedOut(&act_timer))
         {
            ACT_ERR( "Timeout while acquiring buffer sequence (number of sequences = %d).", BufferManager_GetNumSequenceCount(&gBufManager));
            GC_GenerateEventError(EECD_ActualizationAcquisitionTimeout);
            error = true;
         }

         break;

      case BC_FinalizeSequence:
         if (TimedOut(&act_timer))
         {
            // Stop acquisition
            GC_SetAcquisitionStop(1);
            if (TDCStatusTst(AcquisitionStartedMask) == 0)
            {
               const uint32_t numPixels = gBufManager.FrameSize;

               ACT_PRINTF( "Sequence buffer acquisition done (%d ms)\n", (uint32_t) elapsed_time_us( tic_BCDuration ) / 1000 );

               if (usingICU)
               {
                  // Move the ICU back to scene position
                  ICU_scene(&gcRegsData, &gICU_ctrl);
               }

               coaddData.currentCount = 0;
               coaddData.numProcessedPixels = 0;
               dataOffset = 0; // position of the pointer for running average [bytes]
               pixelOffset = 0; // offset of the current computing block within a frame [bytes]

               t_bufferTable sequenceTable;
               sequenceTable = BufferManager_ReadBufferTable(0);
               sequenceOffset = 0; // since we cleared the buffer, our sequence will always be at offset 0
               // CR_TRICKY we asked for N+2 images, and the last 2 will be used for the coadd buffer
               coaddSequenceOffset = (sequenceTable.stop_img + 1 - 2) * gBufManager.FrameSize * 2; // stop_img points to the last image. we need to add 1 to it.

               ACT_INF("coaddSequenceOffset = %d, sequenceTable.stop_img = %d, gBufManager.FrameSize = %d", coaddSequenceOffset, sequenceTable.stop_img, gBufManager.FrameSize);


               if (gActualizationOptions.useDebugData)
               {
                  expectedSum = 0x1000 * coaddData.NCoadd;
      #ifdef ACT_TEST_NOBUFFERING
                  ACT_PRINTF( "Preparing debug data...\n");
                  sequenceOffset = 0;
                  coaddSequenceOffset = numPixels * coaddData.NCoadd * 2; // bytes
                  seq_buffer = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + sequenceOffset);
                  expectedSum = fillDebugData(seq_buffer, 0x1000, numPixels, coaddData.NCoadd);
                  ACT_PRINTF( "Done.\n");
      #endif

                  test_data.deltaBeta_test = -0.1234f;
                  test_data.alpha_test = 1.0;
                  refBlockFileHdr.NUCMultFactor = MAX(1.0, refBlockFileHdr.NUCMultFactor);
                  test_data.FcalBB_test = (float)expectedSum / (gcRegsData.ExposureTime * refBlockFileHdr.NUCMultFactor * coaddData.NCoadd) - test_data.deltaBeta_test / test_data.alpha_test;
                  test_data.TcalBB_test = applyLUT(LUT_RT_ADDR, &blockInfo->lutRQData[0], sqrtf(test_data.FcalBB_test));
               }

               // fill the accumulator buffer with zeros
               coadd_buffer = (uint32_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + coaddSequenceOffset);
               memset(coadd_buffer, 0, numPixels * sizeof(uint32_t));

               GETTIME(&tic_AvgDuration);
               tic_RT_Duration = 0;

               if (gActualizationOptions.useDebugData)
               {
                  seq_buffer = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + sequenceOffset);
                  validateBuffers(coadd_buffer, gBufManager.FrameSize, seq_buffer, coaddData.NCoadd * gBufManager.FrameSize);
               }

               setBCState( &state, BC_ComputeAveragedImage );
            }
         }

         break;
      case BC_ComputeAveragedImage: // state 10
         {
            const uint32_t numPixels = gBufManager.FrameSize;
            const uint32_t numPixelsToProcess = numPixels * coaddData.NCoadd;
            uint64_t t0; // just for benchmarking
            int k=0;

            GETTIME(&t0);

            seq_buffer = (uint16_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + sequenceOffset + dataOffset + (pixelOffset<<1));
            coadd_buffer = (uint32_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + coaddSequenceOffset + (pixelOffset<<2));

            // compute a running average => in fact, we only accumulate pixel values over 32 bits
            // and postpone the division by N for later.
            // After each pass, we'll have processed a block from a single frame
            // The fastest way to sum the pixel (memory access-wise) is to make 32-bit wide accesses.
            // 3.98 us/px (1.88 réel) (3 reads, 2 write par 2 pixels, (1.5r, 1w)/px)

            uint32_t* data_in = (uint32_t*)seq_buffer;
            uint32_t* data_out = (uint32_t*)coadd_buffer;
            uint32_t pixVal;

            if (coaddData.numProcessedPixels == 0)
            {
               ACT_INF("first value %d", data_out[0]);
               ACT_INF("first value 0x%04X", seq_buffer[0]);
            }

            for (k=0; k<ACT_MAX_PIX_DATA_TO_PROCESS; k += 2)
            {
               pixVal = *data_in++;

               *data_out++ += (uint32_t)(pixVal & 0x0000FFFF);

               *data_out++ += (uint32_t)(pixVal >> 16);
            }

            tic_RT_Duration += elapsed_time_us(t0);

            // go to next frame -> step is in bytes
            dataOffset += 2 * numPixels;

            coaddData.numProcessedPixels += ACT_MAX_PIX_DATA_TO_PROCESS;
            if (coaddData.numProcessedPixels % numPixels == 0)
               ACT_PRINTF( "Computing average step %d... (@%d ms)\n", coaddData.numProcessedPixels/numPixels, (uint32_t) elapsed_time_us( tic_AvgDuration ) / 1000 );

            if (++coaddData.currentCount == coaddData.NCoadd)
            {
               pixelOffset += ACT_MAX_PIX_DATA_TO_PROCESS; // once a block is finished, advance the pixel index
               dataOffset = 0;
               coaddData.currentCount = 0;
            }

            if (coaddData.numProcessedPixels == numPixelsToProcess)
            {
               // we're done
               dataOffset = 0;

               ACT_PRINTF( "Computing average took " _PCF(2) " s\n", _FFMT((float) (elapsed_time_us( tic_AvgDuration )) / ((float)TIME_ONE_SECOND_US), 2) );
               ACT_PRINTF( "Computing average took " _PCF(2) " us/px\n", _FFMT((float) (elapsed_time_us( tic_AvgDuration )) / ((float)numPixelsToProcess), 2) );

               ACT_PRINTF( "Computing average took (actual) " _PCF(2) " s\n", _FFMT((float) (tic_RT_Duration) / ((float)TIME_ONE_SECOND_US), 2) );
               ACT_PRINTF( "Computing average took (actual) " _PCF(2) " us/px\n", _FFMT((float) (tic_RT_Duration) / ((float)numPixelsToProcess), 2) );

               if (gActualizationOptions.useDebugData)
               {
                  // validate sum

                  coadd_buffer = (uint32_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + coaddSequenceOffset);
                  validateAverage(coadd_buffer, numPixels, expectedSum);
               }

               setBCState( &state, BC_ComputeBlackBodyFCal );
            }
         }

         break;

      case BC_ComputeBlackBodyFCal: // State 11
         if ( TDCStatusTst(AcquisitionStartedMask) == 0 )
         {
            if (usingICU)
            {
               T_BB = ICUTemp + CELSIUS_TO_KELVIN;
               PRINTF( "ACT: T_BB (internal) is " _PCF(3) " K\n", _FFMT(T_BB,3));
            }
            else
            {
               T_BB = gcRegsData.ExternalBlackBodyTemperature + CELSIUS_TO_KELVIN;
               PRINTF( "ACT: T_BB (external) is " _PCF(3) " K\n", _FFMT(T_BB,3));
            }

            if (gActualizationOptions.useDebugData)
               T_BB = test_data.TcalBB_test;

            ACT_PRINTF( "Computing FCalBB...\n" );

            // Compute FCal scale according to exposure time. We apply it to FCalBB to save on floating point operations
            scaleFCal = gcRegsData.ExposureTime * calibrationInfo.blocks[0].NUCMultFactor * coaddData.NCoadd; // CR_WARNING exposure time is assumed to be in µs

            // Compute sqrt(FCalBB)
            // find the index of the LUT which has the ICU type
            // TODO utiliser le data de la bonne LUTRQ
            LUTRQInfo_t* lutInfo = selectLUT(blockInfo, RQT_RT);
            if (lutInfo == NULL)
            {
               ACT_ERR("Could not find a valid LUTRQ data (type == %s) in the %s block.", usingICU?"RQT_RT":"RQT_RT", usingICU?"reference":"calibration");
               GC_GenerateEventError(EECD_ActualizationInvalidReferenceBlock);
               error = true;
               break;
            }

            FCalBB = applyReverseLUT( LUT_RT_ADDR, lutInfo, T_BB, true ); // TODO utiliser la bonne LUTRQ (cas BB externe)

            // Compute FCalBB = sqrt(FCalBB)^ 2
            FCalBB *= FCalBB;

            #ifdef ACT_VERBOSE
            ACT_PRINTF( "FCalBB = " _PCF(4) "\n", _FFMT(FCalBB,4) );
            ACT_PRINTF( "Reverse LUT_RT done (%dms)\n", (uint32_t) elapsed_time_us( tic_BCDuration ) / 1000 );
            ACT_PRINTF( "Computing delta beta...\n" );
            ACT_PRINTF( "Exposure time = %d us\n", (uint32_t) gcRegsData.ExposureTime );
            PixCounter = 0;
            #endif

            // Compute Alpha and Beta LSB
            Alpha_LSB = exp2f( (float) calibrationInfo.blocks[0].pixelData.Alpha_Exp );
            Beta_LSB = exp2f( (float) calibrationInfo.blocks[0].pixelData.Beta0_Exp );

#if SCALE_FACTOR_TRICK
            // this saves a bunch of floating point operations later
            FCalBB *= scaleFCal;
            Beta_LSB *= scaleFCal;
#endif

            // Copy Beta_Exp from the reference calibration in order to apply beta correction
            DeltaBeta_Exp = calibrationInfo.blocks[0].pixelData.Beta0_Exp;

            // Initialize number of data to process and data pointers
            coadd_buffer = (uint32_t*) (PROC_MEM_MEMORY_BUFFER_BASEADDR + coaddSequenceOffset);
            numDataToProcess = gcRegsData.SensorWidth * gcRegsData.SensorHeight;
            p_PixData = coadd_buffer + 2*gcRegsData.SensorWidth; // skip the header lines (2 rows)
            p_Data = (uint32_t *) PROC_MEM_PIXEL_DATA_BASEADDR; // adresse des données de calibration
            p_DeltaBeta = (uint32_t *) PROC_MEM_DELTA_BETA_BASEADDR; // adresse des données d'actualisation

            ACT_PRINTF( "p_Data = 0x%08X\n", p_Data  );

            ACT_PRINTF( "PixData(0) = %d\n", *p_PixData );

            dataCRC = 0xFFFF; // init with Modbus CRC-16 starting value. It will be updated as the data is computed

            tic_RT_Duration = 0;

            newBadPixelCount = 0;
            setBCState( &state, BC_ComputeDeltaBeta );
         }
         break;

      case BC_ComputeDeltaBeta: // State 12
      {
         uint64_t t0;
         uint64_t calData;
         uint32_t data32;
         GETTIME(&t0);

         // Compute data block size to process (gives some air to other processes)
         blockSize = MIN( numDataToProcess, ACT_MAX_PIX_DATA_TO_PROCESS );

         // delta_beta_full = (float*) p_PixData;

         // Apply beta correction, 2 pixels at a time
         for ( i = 0; i < blockSize; i += 2 )
         {
#if SCALE_FACTOR_TRICK
            FCal = (float)*p_PixData++;
#else
            FCal = (float)*p_PixData++ / scaleFCal;
#endif
            calData = (uint64_t)*p_Data++;
            calData |= ((uint64_t)*p_Data++ << 32);
            //DeltaBetaL = computeDeltaBeta( p_Data++, FCal, FCalBB, Alpha_LSB, Beta_LSB, blockInfo,/*delta_beta_full++*/0);
            newBadPixelCount += computeDeltaBeta( &calData, FCal, FCalBB, Alpha_LSB, Beta_LSB, blockInfo, &DeltaBetaL);

#if SCALE_FACTOR_TRICK
            FCal = (float)*p_PixData++;
#else
            FCal = (float)*p_PixData++ / scaleFCal;
#endif
            calData = (uint64_t)*p_Data++;
            calData |= ((uint64_t)*p_Data++ << 32);
            //DeltaBetaH = computeDeltaBeta( p_Data++, FCal, FCalBB, Alpha_LSB, Beta_LSB, blockInfo,/*delta_beta_full++*/0);
            newBadPixelCount += computeDeltaBeta( &calData, FCal, FCalBB, Alpha_LSB, Beta_LSB, blockInfo, &DeltaBetaH);

            data32 = ( DeltaBetaH << 16 ) | ( DeltaBetaL & 0x0000FFFF );

            // update the value of the data CRC
            dataCRC = CRC16(dataCRC, (uint8_t*)&data32, sizeof(uint32_t));
            *p_DeltaBeta++ = data32;
         }

         // Update number of data to process
         numDataToProcess -= blockSize;

         tic_RT_Duration += elapsed_time_us(t0);

         if ( numDataToProcess == 0 )
         {
#ifdef ACT_VERBOSE
            const int numPixels = gcRegsData.SensorWidth * gcRegsData.SensorHeight;
#endif
            ACT_PRINTF( "Computing delta beta took (actual) " _PCF(4) " s\n", _FFMT((float) (tic_RT_Duration) / ((float)TIME_ONE_SECOND_US), 2) );
            ACT_PRINTF( "Computing delta beta (actual) " _PCF(4) " us/px\n", _FFMT((float) (tic_RT_Duration) / ((float)numPixels), 2) );
            PRINTF("ACT: number of new bad pixels: %d\n", newBadPixelCount);

            gWriteActualizationFile = 1;
            setBCState( &state, BC_WriteActualizationFile );
         }
      }
         break;

      case BC_WriteActualizationFile: // state 13

         writeStatus = ActualizationFileWriter_SM();

         if (writeStatus == IRC_DONE)
            setBCState( &state, BC_Finalize );

         if (writeStatus == IRC_FAILURE)
            error = true;

         break;

      case BC_Finalize: // State 14
         // Wait for ICU to be back in scene position
         if ( gcRegsData.ICUPosition == ICUP_Scene )
         {
            // Beta correction is done
            rtnStatus = IRC_DONE;

            // enable beta correction upon loading a calibration block
            gActDeltaBetaAvailable = true;

            // now the actualisation timestamp becomes valid
            gActualisationPosixTime = privateActualisationPosixTime;

#ifdef ACT_VERBOSE
            PixCounter = 0;
#endif

            disableCalibUpdate = true; // re-enable the calibration update

            builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Passed;
            ACT_PRINTF( "Beta correction completed in %dms\n", (uint32_t) elapsed_time_us( tic_BCDuration ) / 1000 );
            PRINTF( "ACT: Actualization done.\n");

            if (gActualizationOptions.clearBufferAfterCompletion)
            {
               BufferManager_ClearSequence(&gBufManager, &gcRegsData);
               BufferManager_SetBufferMode(&gBufManager, BM_OFF, &gcRegsData);   // Make sure internal buffering is OFF
            }

            // Restore registers value
            restoreGCRegisters( &GCRegsBackup );

            // Reload original calibration data (will update the calibration at the same time)
            if (savedCalibPosixTime != 0)
               Calibration_LoadCalibrationFilePOSIXTime(savedCalibPosixTime);

            TDCStatusClr(WaitingForCalibrationActualizationMask);

            // Reset state machine
            setBCState( &state, BC_Idle );
         }
         break;
   }

   if ( error == true )
   {
      builtInTests[BITID_ActualizationDataAcquisition].result = BITR_Failed;
      ACT_ERR("An error occurred. No calibration update was generated. Reverting to initial parameters.");
      gActDeltaBetaAvailable = false;
      disableCalibUpdate = true;

      gActualisationPosixTime = 0;

      if (gActualizationOptions.clearBufferAfterCompletion)
      {
         BufferManager_ClearSequence(&gBufManager, &gcRegsData);
         BufferManager_SetBufferMode(&gBufManager, BM_OFF, &gcRegsData);   // Make sure internal buffering is OFF
      }

      // Restore registers value
      restoreGCRegisters( &GCRegsBackup );

      ICU_scene(&gcRegsData, &gICU_ctrl);

      GC_SetAcquisitionStop(1);

      // Reload original calibration data (will update the calibration at the same time)
      if (savedCalibPosixTime != 0)
         Calibration_LoadCalibrationFilePOSIXTime(savedCalibPosixTime);

      TDCStatusClr(WaitingForCalibrationActualizationMask);

      // Reset state machine
      setBCState( &state, BC_Idle );

      rtnStatus = IRC_FAILURE;
   }

   return rtnStatus;
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
  *
  *  Note(s):
  *
  */

static void backupGCRegisters( BC_GCRegsBackup_t *p_GCRegsBackup )
{
   p_GCRegsBackup->AcquisitionFrameRate = gcRegsData.AcquisitionFrameRate;
   p_GCRegsBackup->ExposureTime = gcRegsData.ExposureTime;
   p_GCRegsBackup->AECTargetWellFilling = gcRegsData.AECTargetWellFilling;
   p_GCRegsBackup->Width = gcRegsData.Width;
   p_GCRegsBackup->Height = gcRegsData.Height;
   p_GCRegsBackup->CalibrationMode = gcRegsData.CalibrationMode;
   p_GCRegsBackup->SensorWellDepth = gcRegsData.SensorWellDepth;
   p_GCRegsBackup->IntegrationMode = gcRegsData.IntegrationMode;
   p_GCRegsBackup->ExposureAuto = gcRegsData.ExposureAuto;
   p_GCRegsBackup->AECImageFraction = gcRegsData.AECImageFraction;
   p_GCRegsBackup->AECResponseTime = gcRegsData.AECResponseTime;
   p_GCRegsBackup->FWPositionSetpoint = gcRegsData.FWPositionSetpoint;
   p_GCRegsBackup->TestImageSelector = gcRegsData.TestImageSelector;
   p_GCRegsBackup->EHDRINumberOfExposures = gcRegsData.EHDRINumberOfExposures;
   p_GCRegsBackup->MemoryBufferMOISource = gcRegsData.MemoryBufferMOISource;
   p_GCRegsBackup->MemoryBufferNumberOfSequences = gcRegsData.MemoryBufferNumberOfSequences;
   p_GCRegsBackup->MemoryBufferSequenceSize = gcRegsData.MemoryBufferSequenceSize;
   p_GCRegsBackup->MemoryBufferSequencePreMOISize = gcRegsData.MemoryBufferSequencePreMOISize;
   p_GCRegsBackup->MemoryBufferMode = gcRegsData.MemoryBufferMode;
   p_GCRegsBackup->OffsetX = gcRegsData.OffsetX;
   p_GCRegsBackup->OffsetY = gcRegsData.OffsetY;
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
  *
  *  Note(s):
  *
  */
static void restoreGCRegisters( BC_GCRegsBackup_t *p_GCRegsBackup )
{
   GC_SetAcquisitionFrameRate(p_GCRegsBackup->AcquisitionFrameRate);
   GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeIdx], p_GCRegsBackup->ExposureTime);
   GC_RegisterWriteFloat(&gcRegsDef[AECTargetWellFillingIdx], p_GCRegsBackup->AECTargetWellFilling);
   GC_SetWidth(p_GCRegsBackup->Width);
   GC_SetHeight(p_GCRegsBackup->Height);
   GC_RegisterWriteUI32(&gcRegsDef[CalibrationModeIdx], p_GCRegsBackup->CalibrationMode);
   GC_RegisterWriteUI32(&gcRegsDef[SensorWellDepthIdx], p_GCRegsBackup->SensorWellDepth);
   GC_RegisterWriteUI32(&gcRegsDef[IntegrationModeIdx], p_GCRegsBackup->IntegrationMode);
   GC_RegisterWriteUI32(&gcRegsDef[ExposureAutoIdx], p_GCRegsBackup->ExposureAuto);
   GC_RegisterWriteFloat(&gcRegsDef[AECImageFractionIdx], p_GCRegsBackup->AECImageFraction);
   GC_RegisterWriteFloat(&gcRegsDef[AECResponseTimeIdx], p_GCRegsBackup->AECResponseTime);
   GC_RegisterWriteUI32(&gcRegsDef[FWPositionSetpointIdx], p_GCRegsBackup->FWPositionSetpoint);
   GC_RegisterWriteUI32(&gcRegsDef[TestImageSelectorIdx], p_GCRegsBackup->TestImageSelector);
   GC_RegisterWriteUI32(&gcRegsDef[EHDRINumberOfExposuresIdx], p_GCRegsBackup->EHDRINumberOfExposures);
   GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferMOISourceIdx], p_GCRegsBackup->MemoryBufferMOISource);
   GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferNumberOfSequencesIdx], p_GCRegsBackup->MemoryBufferNumberOfSequences);
   GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequenceSizeIdx], p_GCRegsBackup->MemoryBufferSequenceSize);
   GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferSequencePreMOISizeIdx], p_GCRegsBackup->MemoryBufferSequencePreMOISize);
   GC_RegisterWriteUI32(&gcRegsDef[MemoryBufferModeIdx], p_GCRegsBackup->MemoryBufferMode);
   GC_RegisterWriteUI32(&gcRegsDef[OffsetXIdx], p_GCRegsBackup->OffsetX);
   GC_RegisterWriteUI32(&gcRegsDef[OffsetYIdx], p_GCRegsBackup->OffsetY);
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

   unpackLUTData(Xil_In32_(LUTDataAddr + i) , p_LUTInfo, &m, &bi, true);

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
float applyReverseLUT( uint32_t LUTDataAddr, LUTRQInfo_t* p_LUTInfo, float y_target, bool verbose )
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
      //    ACT_PRINTF( "y(%d) (x100) = %d\n", i, (uint32_t) ( y * 100.0f ) );

      i++;
   }
   while ( ( y < y_target ) && ( i < p_LUTInfo->LUT_Size ) );

   i--; // Undo last i++

   if ( verbose )
      ACT_PRINTF( "bi[%d] = " _PCF(4) "\n", i, _FFMT(bi, 4) );

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
      ACT_PRINTF( "bi[%d] = " _PCF(4) "\n", i, _FFMT(bi,4));
      ACT_PRINTF( "mi[%d] = " _PCF(4) "\n", i, _FFMT(m,4));
   }

   // xi = ( i * XRange / Size ) + XMin
   xi = ( (float) i * p_LUTInfo->LUT_Xrange / p_LUTInfo->LUT_Size ) + p_LUTInfo->LUT_Xmin;

   // x = ( ( y - bi ) / m ) + xi
   x = ( ( y_target - bi ) / m ) + xi;

#ifdef ACT_VERBOSE
   if ( verbose )
   {
      float z = (x - xi) * m + bi;
      ACT_PRINTF( "Index = %d, x = " _PCF(3) "\n", i, _FFMT(x,3));
      ACT_PRINTF( "y_ = mx + b = " _PCF(3) "\n", _FFMT(z,3));
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
void unpackLUTData( uint32_t LUTData, LUTRQInfo_t *p_LUTInfo, float *p_m, float *p_b, bool verbose )
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
      ACT_PRINTF( "LUTData = 0x%08X\n", LUTData );
      ACT_PRINTF( "   m = %d * 2^%d = " _PCF(3) "\n", data->m, p_LUTInfo->M_Exp, _FFMT(*p_m, 3));
      ACT_PRINTF( "   b = %d * 2^%d = " _PCF(3) "\n", data->b, p_LUTInfo->B_Exp, _FFMT(*p_b, 3));
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
bool computeDeltaBeta( uint64_t *p_CalData, float FCal, float FCalBB, float Alpha_LSB, float Beta_LSB, const calibBlockInfo_t* blockInfo, int32_t* deltaBetaOut)
{
   static const uint64_t alpha_mask = CALIB_PIXELDATA_ALPHA_MASK;
   static const int16_t minRawData = -CALIB_ACTUALIZATIONDATA_DELTABETA_SIGNPOS; //-2^10
   static const int16_t maxRawData = CALIB_ACTUALIZATIONDATA_DELTABETA_SIGNPOS - 1;  // 2^10 - 1
   float alpha, delta_beta;
   uint16_t raw_alpha;
   int16_t raw_delta_beta = 0;
   bool isNewBadPixel = false;
   uint64_t calData;

   calData = *p_CalData;

   const float alpha_off = blockInfo->pixelData.Alpha_Off;

   #ifdef ACT_VERBOSE
   bool isAlreadyBadPixel = (calData & CALIB_PIXELDATA_BADPIXEL_MASK) == 0; // check the bad pixel status of the current calibration. Can't use the BitTst utility for uin64_t
   uint32_t col = PixCounter % gcRegsData.SensorWidth;
   uint32_t line = PixCounter / gcRegsData.SensorWidth;
   bool outputData = ( col % 128 == 0 ) && (( line % 128 == 0 ) || line+1 == gcRegsData.SensorHeight);
   PixCounter++;
   #endif

   // Extract alpha from current calibration data => 12 lsb
   raw_alpha = (uint16_t) (( calData & alpha_mask ) >> CALIB_PIXELDATA_ALPHA_SHIFT);
   alpha = (float) raw_alpha * Alpha_LSB + alpha_off;

   // Compute delta beta ( see notes in function header )
   delta_beta = ( FCal - FCalBB ) * alpha;

   // Compute raw delta beta ( Limited to signed 16 bit range )
   raw_delta_beta = (int16_t) MIN( MAX( roundf(delta_beta / Beta_LSB), -32768 ), 32767 );
   /*raw_delta_beta = (int32_t) MIN( MAX( delta_beta / Beta_LSB, -1024 ), 1023 );
      isNewBadPixel = !isBadPixel && (raw_delta_beta == -1024 || raw_delta_beta == 1023);*/
   /*raw_delta_beta = (int32_t) MIN( MAX( delta_beta / Beta_LSB, minRawData ), maxRawData );
   isNewBadPixel = !isBadPixel && (raw_delta_beta == minRawData || raw_delta_beta == maxRawData);*/

   // check if it now has become a bad pixel -> according to the delta beta only
   // there might be more new bad pixels when a calibration block is updated with the delta beta value
   if (raw_delta_beta < minRawData)
   {
      isNewBadPixel = true;
      raw_delta_beta = minRawData;
   }

   if (raw_delta_beta > maxRawData)
   {
      isNewBadPixel = true;
      raw_delta_beta = maxRawData;
   }

   // now set the NewBadPixel bit (in reverse logic)
   if (isNewBadPixel)
      BitClr(raw_delta_beta, CALIB_ACTUALIZATIONDATA_NEWBADPIXEL_SHIFT);
   else
      BitSet(raw_delta_beta, CALIB_ACTUALIZATIONDATA_NEWBADPIXEL_SHIFT);

   #ifdef ACT_VERBOSE
   if ( outputData )
   {
      int16_t tmp;
      float tmp2 = delta_beta;
      ACT_PRINTF( "Pixel (r=%d, c=%d)\n", line, col );
      ACT_PRINTF( "   FCal: " _PCF(3) "\n", _FFMT(FCal,3));
      ACT_PRINTF( "   CalData: 0x%08X%08X\n", (uint32_t)(calData >> 32), (uint32_t)(calData & 0x00000000FFFFFFFF));
      ACT_PRINTF( "   alpha: " _PCF(3) " + %d x 2^%d (" _PCF(3) ")\n", _FFMT(alpha_off,3), raw_alpha,
            blockInfo->pixelData.Alpha_Exp, _FFMT(alpha,3) );
      tmp = (raw_delta_beta & CALIB_ACTUALIZATIONDATA_DELTABETA_MASK);
      SIGN_EXT16(tmp, DELTA_BETA_NUM_BITS);
      delta_beta = tmp * exp2f(DeltaBeta_Exp);
      if (isNewBadPixel)
      {
         if (!isAlreadyBadPixel)
            ACT_PRINTF( "   delta_beta: %d x 2^%d (" _PCF(6) ") **new bad pixel**\n", tmp, DeltaBeta_Exp, _FFMT(delta_beta, 6) );
         else
            ACT_PRINTF( "   delta_beta: %d x 2^%d (" _PCF(6) ") **already a bad pixel in reference block**\n", tmp, DeltaBeta_Exp, _FFMT(delta_beta, 6) );
         ACT_PRINTF("unsaturated value = " _PCF(4) "\n", _FFMT(tmp2, 4));
      }
      else
      {
         if (!isAlreadyBadPixel)
            ACT_PRINTF( "   delta_beta: %d x 2^%d (" _PCF(6) ")\n", tmp, DeltaBeta_Exp, _FFMT(delta_beta, 6) );
         else
            ACT_PRINTF( "   delta_beta: %d x 2^%d (" _PCF(6) ") ** bad pixel **\n", tmp, DeltaBeta_Exp, _FFMT(delta_beta, 6) );
      }
      ACT_PRINTF( "   raw_delta_beta (sat) : %d\n", tmp );
   }
   #endif

   // Return raw delta Beta value
   *deltaBetaOut = raw_delta_beta;
   return isNewBadPixel;
}

/**
  *  This function validates whether a newly loaded calibration collection can be updated or not with the latest
  *  available delta beta map in memory (if any).
  *
  *  Checks for gActDeltaBetaAvailable, calibration type, pixel data presence and reference POSIX time
  *
  *  It modifies the proxy variable gActualisationPosixTime.
  *
  * @param a pointer to the current calibration info
  * @param an index to the candidate calibration block to be updated
  *
  * @return true or false
  *
  */
bool shouldUpdateCurrentCalibration(const calibrationInfo_t* calibInfo, uint8_t blockIdx)
{
   bool retval = false;

   if (!flashSettings.ActualizationEnabled)
      return false;

   // check if the current block is compatible
   if (disableCalibUpdate && gActDeltaBetaAvailable &&
         (calibInfo->collection.CalibrationType == CALT_TELOPS || calibInfo->collection.CalibrationType == CALT_MULTIPOINT) &&
         calibInfo->blocks[blockIdx].PixelDataPresence == 1 && TDCStatusTst(WaitingForCalibrationActualizationMask) == 0 &&
         refBlockFileHdr.POSIXTime == calibInfo->collection.ReferencePOSIXTime)
   {
      retval = true;
      gActualisationPosixTime = privateActualisationPosixTime;
   }
   else
   {
      if (TDCStatusTst(WaitingForCalibrationActualizationMask))
         ACT_INF("Calibration actualization is not applicable to the current block (actualization is currently running).");
      else if (!gActDeltaBetaAvailable)
         ACT_INF("No calibration actualization has been computed yet.");
      else
         ACT_INF("Calibration actualization is not applicable to the current block.");
      gActualisationPosixTime = 0;
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
uint32_t updateCurrentCalibration(const calibBlockInfo_t* blockInfo, uint32_t* p_CalData, const uint32_t* p_actData, uint32_t numData)
{
   int16_t DeltaBetaH, DeltaBetaL;
   uint32_t numBadPixels = 0;
   int8_t expBitshift;// the factor to apply (as a binary shift) in order to bring the deltaBeta parameter to the same range as that the beta of the current block
   uint64_t calData;
   uint64_t* calDataAddr;

   // here we compute a bit shift instead of a factor
   // deltaBetaFactor = exp2f( DeltaBeta_Exp - blockInfo->pixelData.Beta0_Exp );
   expBitshift = DeltaBeta_Exp - blockInfo->pixelData.Beta0_Exp;

   while (numData)
   {
      // Extract delta beta (High)
      DeltaBetaH = (int16_t) ( *p_actData >> 16 );

      // Extract delta beta (Low)
      DeltaBetaL = (int16_t) ( *p_actData & 0x0000FFFF );

      // Apply beta correction
      /*numBadPixels += updatePixelDataElement(blockInfo, p_CalData++, DeltaBetaH, expBitshift);
      numBadPixels += updatePixelDataElement(blockInfo, p_CalData++, DeltaBetaL, expBitshift);*/
      calDataAddr = (uint64_t*)p_CalData;
      calData = (uint64_t)*p_CalData++;
      calData |= ((uint64_t)*p_CalData++ << 32);
      numBadPixels += updatePixelDataElement(blockInfo, &calData, DeltaBetaL, expBitshift);
      *calDataAddr = calData;

      calDataAddr = (uint64_t*)p_CalData;
      calData = (uint64_t)*p_CalData++;
      calData |= ((uint64_t)*p_CalData++ << 32);
      numBadPixels += updatePixelDataElement(blockInfo, &calData, DeltaBetaH, expBitshift);
      *calDataAddr = calData;

      numData -= 2;
      ++p_actData;
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
uint8_t updatePixelDataElement(const calibBlockInfo_t* blockInfo, uint64_t *p_CalData, int16_t deltaBeta, int8_t expBitShift)
{
   static const int32_t minRawData = -CALIB_ACTUALIZATIONDATA_DELTABETA_SIGNPOS; //-2^10
   static const int32_t maxRawData = CALIB_ACTUALIZATIONDATA_DELTABETA_SIGNPOS - 1;  // 2^10 - 1

   int16_t raw_current_beta, raw_corr_beta, corr_deltaBeta;
   uint8_t saturation = false;
   uint64_t calData;
   uint8_t newBadPixel = false;
   uint8_t isAlreadyBad;

   calData = *p_CalData;

   #ifdef ACT_VERBOSE
   uint32_t col = PixCounter % gcRegsData.SensorWidth;
   uint32_t line = PixCounter / gcRegsData.SensorWidth;
   bool outputData = ( col % 128 == 0 ) && (( line % 128 == 0 ) || line+1 == gcRegsData.SensorHeight);
   PixCounter++;
   #endif

   isAlreadyBad = (calData & CALIB_PIXELDATA_BADPIXEL_MASK) == 0;

   // Extract current beta from current calibration data
   raw_current_beta = (int16_t) ((calData & CALIB_PIXELDATA_BETA0_MASK) >> CALIB_PIXELDATA_BETA0_SHIFT );
   SIGN_EXT16( raw_current_beta, blockInfo->pixelData.Beta0_Nbits );

   newBadPixel = (deltaBeta & CALIB_ACTUALIZATIONDATA_NEWBADPIXEL_MASK) == 0; // the bad pixel bit is in reverse logic
   deltaBeta &= CALIB_ACTUALIZATIONDATA_DELTABETA_MASK; // extract the data without the bad pixel flag
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
   if ( outputData )
   {
      ACT_PRINTF( "Pixel (r=%d, c=%d)\n", line, col );
      ACT_PRINTF( "CalData: 0x%08X%08X\n", (uint32_t)(calData >> 32), (uint32_t)(calData & 0x00000000FFFFFFFF) );
      ACT_PRINTF( "raw_beta: %d\n", raw_current_beta );
      ACT_PRINTF( "raw_delta_beta: %d\n", deltaBeta );
      ACT_PRINTF( "raw_corr_delta_beta: %d\n", corr_deltaBeta );
      ACT_PRINTF( "raw_corr_beta: %d\n", raw_corr_beta );
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
   calData &= ~CALIB_PIXELDATA_BETA0_MASK;
   calData |= ( ((uint64_t)raw_corr_beta) << CALIB_PIXELDATA_BETA0_SHIFT ) & CALIB_PIXELDATA_BETA0_MASK;

   if (newBadPixel) // clear the badpixel bit when it is bad (reverse logic) (do nothing otherwise)
      calData &= ~CALIB_PIXELDATA_BADPIXEL_MASK;

   *p_CalData = calData;

   #ifdef ACT_VERBOSE
   if ( outputData )
   {
      ACT_PRINTF( "raw_corr_beta (sat)%s: %d\n", newBadPixel?" (**new bad pixel after update**) ":"", raw_corr_beta);
      ACT_PRINTF( "CalData: 0x%08X%08X\n", (uint32_t)((*p_CalData) >> 32), (uint32_t)((*p_CalData) & 0x00000000FFFFFFFF));
      ACT_PRINTF( "\n" );
   }
   #endif

   return (newBadPixel & !isAlreadyBad);
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
fileRecord_t* findIcuReferenceBlock()
{
   int n = gFM_icuBlocks.count;
   int i = 0;
   uint32_t length=0;
   IRC_Status_t status;
   fileRecord_t* filerec = NULL;

   if (!calibrationInfo.isValid)
      return NULL;

   // get through all block files in flash and find the matching ICU reference
   while (i < n)
   {
      //status = FM_ReadDataFromFile(tmpFileDataBuffer, gFM_calibrationBlocks.item[i]->name, 0, CALIB_BLOCKFILEHEADER_SIZE);
      status = FM_ReadDataFromFile(tmpFileDataBuffer, gFM_icuBlocks.item[i]->name, 0, CALIB_BLOCKFILEHEADER_SIZE);
      if (status != IRC_SUCCESS)
         break;

      length = ParseCalibBlockFileHeader(tmpFileDataBuffer, CALIB_BLOCKFILEHEADER_SIZE, &refBlockFileHdr);
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
  *  State machine for the actualization data file
  *
  *   @param none
  *
  *   @return IRC_DONE or IRC_Failure or IRC_NOT_DONE when it is not finished
  */
typedef enum {
   FWR_IDLE = 0,
   FWR_INIT_IO,
   FWR_DELETE_PREVIOUS,
   FWR_FILE_HEADER,
   FWR_DATA_HEADER,
   FWR_DATA,
   FWR_CLOSEFILE
} BC_Write_State_t;

IRC_Status_t ActualizationFileWriter_SM()
{
   static BC_Write_State_t state = FWR_IDLE;
   static uint32_t dataOffset = 0; // used for data write
   static uint32_t numDataToProcess;
   static uint64_t tic_io_duration;
   static uint32_t actualization_file_idx = 0xFFFF;
   static int fd = -1;
   static char shortFileName[32];
   char longFilename[FM_LONG_FILENAME_SIZE];
   fileRecord_t* file;

   IRC_Status_t retVal = IRC_NOT_DONE;
   bool error = false;
   uint16_t blockSize;
   uint32_t numBytes = 0;

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

      ACT_INF("FWR_DELETE_PREVIOUS");

      privateActualisationPosixTime = gcRegsData.DeviceRunningTime + (TRIG_GetRTC(&gTrig).Seconds % 60); // this yields a unique value for a given device ID
      if (gFM_calibrationActualizationFile != NULL)
      {
         // read the POSIX time of that file before deleting it
         uint32_t timestampOffset = gFM_calibrationActualizationFile->posixTime;

         if (privateActualisationPosixTime < timestampOffset)
            privateActualisationPosixTime += timestampOffset;

         ACT_INF("Removing previous actualisation file (%s).", gFM_calibrationActualizationFile->name);
         if (FM_RemoveFile(gFM_calibrationActualizationFile) != IRC_SUCCESS)
         {
            ACT_ERR("Error deleting previous actualisation file (%s).", gFM_calibrationActualizationFile->name);
            // no big deal if could not remove the file
         }
      }

      state = FWR_INIT_IO;

   case FWR_INIT_IO:

      ACT_INF("FWR_INIT_IO");

      defineActualizationFilename(shortFileName, sizeof(shortFileName), privateActualisationPosixTime);

      ACT_INF("Will write to file : %s", shortFileName);

      // if file does not exist, create it
      if (!FM_FileExists(shortFileName))
      {
         if (FM_CreateFile(shortFileName, &actualization_file_idx) != IRC_SUCCESS)
         {
            ACT_ERR("Error creating file %s.", shortFileName);
            error = true;
            break;
         }
      }

      // open the file
      sprintf(longFilename, "%s%s", FM_UFFS_MOUNT_POINT, shortFileName);
      fd = uffs_open(longFilename, UO_WRONLY);
      if (fd == -1)
      {
         ACT_ERR("Failed to open %s.", longFilename);
         error = true;
         break;
      }

      state = FWR_FILE_HEADER;

      break;

   case FWR_FILE_HEADER:

      ACT_INF("FWR_FILE_HEADER");

      //t_PosixTime time = TRIG_GetRTC(&gTrig);
      actFileHeader.DeviceSerialNumber = refBlockFileHdr.DeviceSerialNumber;
      actFileHeader.POSIXTime = privateActualisationPosixTime;
      strcpy(actFileHeader.FileDescription, "");
      actFileHeader.DeviceDataFlowMajorVersion = refBlockFileHdr.DeviceDataFlowMajorVersion;
      actFileHeader.DeviceDataFlowMinorVersion = refBlockFileHdr.DeviceDataFlowMinorVersion;
      actFileHeader.Width = gcRegsData.SensorWidth;
      actFileHeader.Height = gcRegsData.SensorHeight;
      actFileHeader.OffsetX = 0;
      actFileHeader.OffsetY = 0;
      actFileHeader.ReferencePOSIXTime = refBlockFileHdr.POSIXTime;

      // write file header
      numBytes = WriteCalibActualizationFileHeader(&actFileHeader, tmpFileDataBuffer, FM_TEMP_FILE_DATA_BUFFER_SIZE);

      if (numBytes != CALIB_ACTUALIZATIONFILEHEADER_SIZE)
      {
         ACT_ERR("Abnormal file header length (expected %d, got %d).", CALIB_ACTUALIZATIONFILEHEADER_SIZE, numBytes);
         error = true;
         break;
      }

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }

      if (uffs_write(fd, tmpFileDataBuffer, numBytes) != CALIB_ACTUALIZATIONFILEHEADER_SIZE)
      {
         ACT_ERR("Error writing file header to file %s.", shortFileName);
         error = true;
         break;
      }

      state = FWR_DATA_HEADER;

   case FWR_DATA_HEADER:

      ACT_INF("FWR_DATA_HEADER");

      actDataHeader.Beta0_Off = 0;
      actDataHeader.Beta0_Median = 0;
      actDataHeader.Beta0_Exp = DeltaBeta_Exp;
      actDataHeader.Beta0_Nbits = DELTA_BETA_NUM_BITS;
      actDataHeader.Beta0_Signed = 1;
      actDataHeader.ActualizationDataCRC16 = dataCRC;
      actDataHeader.ActualizationDataLength = CALIB_ACTUALIZATIONDATA_SIZE * gcRegsData.SensorWidth * gcRegsData.SensorHeight;

      // write file data header
      numBytes = WriteCalibActualizationDataHeader(&actDataHeader, tmpFileDataBuffer, FM_TEMP_FILE_DATA_BUFFER_SIZE);

      if (numBytes != CALIB_ACTUALIZATIONDATAHEADER_SIZE)
      {
         ACT_ERR("Abnormal data header length (expected %d, got %d).", CALIB_ACTUALIZATIONDATAHEADER_SIZE, numBytes);
         error = true;
         break;
      }

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }
      if (uffs_write(fd, tmpFileDataBuffer, numBytes) != CALIB_ACTUALIZATIONDATAHEADER_SIZE)
      {
         ACT_ERR("Error writing data header to file %s.", shortFileName);
         error = true;
         break;
      }

      dataOffset = 0;
      numDataToProcess = gcRegsData.SensorWidth * gcRegsData.SensorHeight;

      state = FWR_DATA;

      ACT_INF("Going to FWR_DATA");

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

      numBytes = blockSize * CALIB_ACTUALIZATIONDATA_SIZE;
      if (uffs_write(fd, dataAddr, numBytes) != numBytes)
      {
         ACT_ERR("Error writing data to file %s.", shortFileName);
         error = true;
         break;
      }

      numDataToProcess -= blockSize;

      dataOffset += blockSize * CALIB_ACTUALIZATIONDATA_SIZE;

      if (numDataToProcess == 0)
      {
         state = FWR_CLOSEFILE;
      }

      break;

   case FWR_CLOSEFILE:

      ACT_INF("FWR_CLOSEFILE");

      if (fd == -1)
      {
         ACT_ERR("Invalid file descriptor.");
         error = true;
         break;
      }

      file = FM_GetFileRecord(actualization_file_idx);
      file->size = uffs_tell(fd);

      // now close the file
      if (uffs_close(fd) == -1)
      {
         ACT_ERR("File close failed.");
         error = true;
         break;
      }

      FM_CloseFile(file, FMP_RUNNING);
      //FM_RefreshFileInfoAtIdx(actualization_file_idx);

      state = FWR_IDLE;
      retVal = IRC_DONE;

      ACT_PRINTF( "File IO completed in %dms\n", (uint32_t) elapsed_time_us( tic_io_duration ) / 1000 );

      break;

   default:
      state = FWR_IDLE;
   };

   if ( error == true )
   {
      // Reset state machine
      state = FWR_IDLE;

      GC_GenerateEventError(EECD_ActualizationFileIOError);

      if (fd != -1)
      {
         uffs_close(fd); // don't bother the error if any upon closing the file
         ACT_ERR("File close failed.");
      }

      retVal = IRC_FAILURE;
   }

   return retVal;
}

#ifdef ACT_TEST_NOBUFFERING
/**
  *  Debugging function. Fills the data array with a sequence going from [c0+(K%N) to c0+(K+N-1)%N],
  *  where K is an index.
  *
  *  For example, with c0=10 and N=4 and pixel index K=40, the sequence would be : {10,11,12,13} and pixel
  *  index K=41 would be {11,12,13,10}, And so on.
  *
  *   @param none
  *
  *   @return IRC_DONE or IRC_Failure or IRC_NOT_DONE when it is not finished
  */
uint32_t fillDebugData(uint16_t* data, uint32_t c0, uint32_t frameSize, uint32_t numFrames)
{
   uint32_t i,j;
   uint32_t S = numFrames * (2*c0 + numFrames - 1)/2;

   uint32_t offset = 0;
   for (i=0; i<numFrames; ++i)
   {
      j = 0;

      while (j<frameSize)
      {
         data[offset + j] = c0 + ((i + j) % numFrames);
         ++j;
      }

      offset += frameSize;
   }

   return S;
}
#endif

static void defineActualizationFilename(char* buf, uint8_t length, uint32_t timestamp)
{
   uint8_t n = MIN(length, sizeof(gcRegsData.DeviceID));
   memset(buf, 0, length);
   if (strlen(gcRegsData.DeviceID) != 0)
      strncpy(buf, gcRegsData.DeviceID, n);
   else
      strcpy(buf, "TEL00000");

   sprintf(buf + strlen(buf), "-%010u.tsac", (unsigned int)timestamp);
}

/**
  *  Find the LUTRQ table offset and info corresponding to the requested type in the current calibration block
  *
  * TODO Should also give access to the selected LUT. Currently, only one LUT is supported
  *
  *   @param a pointer to the calibration block
  *   @param a RadiometricQuantityType tag
  *
  *   @return A pointer to LUTRQInfo_t, null if not found
  */
LUTRQInfo_t* selectLUT(calibBlockInfo_t* blockInfo, uint8_t type)
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
void setDefaultIcuParams(ICUParams_t* p)
{
   if (flashSettings.ActualizationTemperatureSelector == 0)
      p->TemperatureSelector = DTS_InternalCalibrationUnit;
   else
      p->TemperatureSelector = DTS_InternalLens;
   p->WaitTime1 = flashSettings.ActualizationWaitTime1; // [ms]
   p->StabilizationTime1 = flashSettings.ActualizationStabilizationTime1; // [ms]
   p->Timeout1 = flashSettings.ActualizationTimeout2; // [ms]
   p->TemperatureTolerance1 = CC_TO_C(flashSettings.ActualizationTemperatureTolerance1); // [°C]
   p->WaitTime2 = flashSettings.ActualizationWaitTime2; // [ms]
   p->StabilizationTime2 = flashSettings.ActualizationStabilizationTime2; // [ms]
   p->Timeout2 = flashSettings.ActualizationTimeout2; // [ms]
   p->TemperatureTolerance2 = CC_TO_C(flashSettings.ActualizationTemperatureTolerance2); // [°C]
}

void ACT_ResetOptions()
{
   gActualizationOptions.clearBufferAfterCompletion = true;
   gActualizationOptions.useDebugData = false;
   gActualizationOptions.bypassAEC = false;
}

static void ACT_init()
{
   setDefaultIcuParams(&icuParams);
   ACT_ResetOptions();

   gActDeltaBetaAvailable = false;
   gActAllowAcquisitionStart = false;
   gActualisationPosixTime = 0;

   ACT_INF("Actualization state machine starting...");
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
      PRINTF( "ACT: Average validation success\n");

   return k == numPixels;
}

static bool validateBuffers(uint32_t* coadd_buffer, uint32_t nCoadd, uint16_t* seq_buffer, uint32_t nSeq)
{
   int k = 0;
   bool all_good_coadd = true;
   bool all_good_seq = true;
   const int header_sz = 2*gcRegsData.SensorWidth * 2;
   const int frame_size = gcRegsData.SensorWidth * (gcRegsData.SensorHeight+2);

   PRINTF( "ACT: Check data integrity in buffer...\n");
   for (k=0; k<nCoadd; ++k)
   {
        if (coadd_buffer[k] != 0)
        {
           all_good_coadd = false;
           ACT_ERR("Wrong value (%d) at pixel %d of coadd buffer", coadd_buffer[k], k);
        }
   }
   if (all_good_coadd)
      PRINTF( "ACT: Coadd buffer validation complete...\n");

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
      PRINTF( "ACT: Data validation complete...\n");

   return all_good_coadd && all_good_seq;
}

