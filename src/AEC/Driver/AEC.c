#include "AEC.h"
#include "fpa_intf.h"
#include "utils.h"
#include "Calibration.h"
#include "Genicam.h"
#include "proc_init.h"
#include "mb_axi4l_bridge.h"
#include "SFW_ctrl.h"
#include "exposure_time_ctrl.h"
#include "GC_Registers.h"
#include "FlashSettings.h"
#include "Timer.h"
#include "trig_gen.h"   // for TRIG_GetRTC()

#include "xintc.h"

#include <math.h>
#include <string.h>
#include <stdbool.h>

//#define AEC_INT_TIME_PRINT
#define ALPHA_MAX    0.976f   // ToDo: determiner la variation minimale de l'ExpTime pour chaque detecteur

static volatile bool gAEC_Data_Ready  = false;

extern XIntc gProcIntc;
extern t_AEC gAEC_CTRL;
extern float FWExposureTime[MAX_NUM_FILTER];
extern t_Trig gTrig;

static uint32_t AEC_TimeStamps_d1[SFW_FILTER_NB];
uint64_t AECP_Int_Sum_Cnts;
uint32_t AECP_Int_Data_Valid;
float AECP_Int_SumExpTime;
float AECPlusMaximumTotalFlux;
float FluxRatio[2];
uint8_t MinNDFPosition, MaxNDFPosition;

static timerData_t AECPlusArmedDelay;
bool AECArmed = false;

bool AECPlusCheckForUnattenuation(gcRegistersData_t *pGCRegs, float PET);
bool AECPlusCheckForAttenuation(gcRegistersData_t *pGCRegs, float PET);
float AECPlusChangeFilter(gcRegistersData_t *pGCRegs, bool Attenuate, float PET);
float computeTotalFlux(gcRegistersData_t *pGCRegs, uint64_t totalCounts, float ET);
/***************************************************************************//**
   Interrupt Initialisation of the AEC module.

   @return void

*******************************************************************************/
static inline int32_t AEC_SetupInterruptSystem(XIntc * InterruptController)
{
#ifndef SIM
   return XIntc_Connect(InterruptController, AEC_INTR_ID, (XInterruptHandler)XAEC_InterruptHandler, InterruptController);
#endif
}

/***************************************************************************//**
   Interrupt Enable of the AEC module.

   @return void

*******************************************************************************/
static inline void AEC_EnableInterrupt(XIntc * InterruptController)
{
#ifndef SIM
  //XIntc_Enable(InterruptController, AEC_INTR_ID);
#endif
}


/*--------------------------------------------------------- 
 FONCTION : AEC_Init
---------------------------------------------------------*/
IRC_Status_t AEC_Init(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL)
{

   XIntc * InterruptController = &gProcIntc;

   pAEC_CTRL->AEC_Mode = AEC_OFF;
   pAEC_CTRL->AEC_ImageFraction = (uint32_t)  (FPA_CONFIG_GET(width_max) *FPA_CONFIG_GET(height_max) * 0.5f); // 50% of the pixel by default
   pAEC_CTRL->AEC_MSB_Pos = AEC_GetMsbPos();
   pAEC_CTRL->AEC_clearmem = 1;
   pAEC_CTRL->AEC_NB_Bin = AEC_NB_BIN;
   pAEC_CTRL->AEC_NewConfigFlag = 0;
   pAEC_CTRL->AEC_DecimatorInputWidth = FPA_CONFIG_GET(width_max);
   pAEC_CTRL->AEC_DecimatorEnable &= DECIMATOR_DESACTIVATED_MASK;

   memset(AEC_TimeStamps_d1, 0, sizeof(AEC_TimeStamps_d1));

   //Write Struct to AEC
   WriteStruct(pAEC_CTRL);

   // Toggle new config flag to AEC
   AXI4L_write32(1, pAEC_CTRL->ADD + AEC_NEW_CONFIG_FLAG_OFFSET);
   AXI4L_write32(0, pAEC_CTRL->ADD + AEC_NEW_CONFIG_FLAG_OFFSET);

   //REgister Interrupt and start intc process
   AEC_SetupInterruptSystem(InterruptController);

   AEC_UpdateImageFraction(pGCRegs,pAEC_CTRL);
   AEC_UpdateMode(pGCRegs, pAEC_CTRL );

   return IRC_SUCCESS;

}

/*--------------------------------------------------------- 
 FONCTION : AEC_Arm
---------------------------------------------------------*/
void AEC_Arm(void)
{
   memset(AEC_TimeStamps_d1, 0, sizeof(AEC_TimeStamps_d1));
   AEC_PRINTF("Arming AEC\n");
}

/*--------------------------------------------------------- 
 FONCTION : AEC_UpdateMode
---------------------------------------------------------*/
void AEC_UpdateMode(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL)
{
   AECArmed = false;

   if(pGCRegs->ExposureAuto == EA_Off)
   {
      pAEC_CTRL->AEC_Mode = AEC_OFF;
      memset(AEC_TimeStamps_d1, 0, sizeof(AEC_TimeStamps_d1));
   }
   else if(pGCRegs->ExposureAuto == EA_Continuous)
   {
      pAEC_CTRL->AEC_Mode = AEC_ON;
   }
   else if(pGCRegs->ExposureAuto == EA_ContinuousNDFilter)
   {
      pAEC_CTRL->AEC_Mode = AEC_ON;
   }
   else if(pGCRegs->ExposureAuto == EA_ArmedNDFilter)
   {
      pAEC_CTRL->AEC_Mode = AEC_ON;
      GC_UpdateNDFPositionSetpoint(gcRegsData.NDFilterPositionSetpoint, gcRegsData.NDFilterArmedPositionSetpoint);
      AECArmed = true;
      StopTimer(&AECPlusArmedDelay);
   }
   pAEC_CTRL->AEC_clearmem = 1;
   AXI4L_write32(pAEC_CTRL->AEC_clearmem, pAEC_CTRL->ADD + AEC_CLEARMEM_OFFSET);

   AXI4L_write32(pAEC_CTRL->AEC_Mode, pAEC_CTRL->ADD + AEC_MODE_OFFSET);
   pAEC_CTRL->AEC_clearmem = 0;
   AXI4L_write32(pAEC_CTRL->AEC_clearmem, pAEC_CTRL->ADD + AEC_CLEARMEM_OFFSET);

   // Toggle new config to AEC
   AXI4L_write32(1, pAEC_CTRL->ADD + AEC_NEW_CONFIG_FLAG_OFFSET);
   AXI4L_write32(0, pAEC_CTRL->ADD + AEC_NEW_CONFIG_FLAG_OFFSET);
}

/*--------------------------------------------------------- 
 FONCTION : AEC_UpdateImageSize
---------------------------------------------------------*/
void AEC_UpdateImageFraction(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL)
{
   uint32_t AECImgHeight;

   // Decimator configuration
   pAEC_CTRL->AEC_DecimatorInputWidth = pGCRegs->Width;
   AECImgHeight = pGCRegs->Height;
   pAEC_CTRL->AEC_DecimatorEnable &= DECIMATOR_DESACTIVATED_MASK; // Decimation deactivated by default

   // Row decimation is activated when a full image pixel size cannot fit all into one histogram bin (max bin size is 2^21-1 pixels).
   if(pGCRegs->Width*pGCRegs->Height > (uint32_t)DECIMATOR_THRESHOLD &&
      pGCRegs->Height > 2*DECIMATOR_INPUT_HEIGHT_MIN)
   {
      AECImgHeight  = pGCRegs->Height >> 1;  //decimate one out of two rows
      pAEC_CTRL->AEC_DecimatorEnable |= (uint32_t)DECIMATOR_ROW_MASK;
   }

   // Image fraction update
   pAEC_CTRL->AEC_ImageFraction =(uint32_t) ( AECImgHeight * pAEC_CTRL->AEC_DecimatorInputWidth * (pGCRegs->AECImageFraction / 100.0f)); // IMAGE FRaction between 0 and 100
   AXI4L_write32(pAEC_CTRL->AEC_ImageFraction, pAEC_CTRL->ADD + AEC_IMAGEFRACTION_OFFSET);

   AXI4L_write32(pAEC_CTRL->AEC_DecimatorInputWidth, pAEC_CTRL->ADD + DECIMATOR_INPUT_WIDTH_OFFSET);
   AXI4L_write32(pAEC_CTRL->AEC_DecimatorEnable, pAEC_CTRL->ADD + DECIMATOR_ENABLE_OFFSET);

   // Toggle new config flag to AEC
   AXI4L_write32(1, pAEC_CTRL->ADD + AEC_NEW_CONFIG_FLAG_OFFSET);
   AXI4L_write32(0, pAEC_CTRL->ADD + AEC_NEW_CONFIG_FLAG_OFFSET);

}

/*--------------------------------------------------------- 
 FONCTION : AEC_ClearMem
---------------------------------------------------------*/
void AEC_ClearMem(t_AEC *pAEC_CTRL)
{

   AXI4L_write32(1, pAEC_CTRL->ADD + AEC_CLEARMEM_OFFSET);
   AXI4L_write32(0, pAEC_CTRL->ADD + AEC_CLEARMEM_OFFSET);
}
/*---------------------------------------------------------
 FONCTION : AEC_UpdateHotSpotMaxSize
---------------------------------------------------------*/


/*--------------------------------------------------------- 
 FONCTION : AEC_Interrupt
---------------------------------------------------------*/
void XAEC_InterruptHandler(XIntc * InterruptController )
{

   //AEC_PRINTF("AEC Interrupt\n");
   // Security check for interrupt from AEC core

  gAEC_Data_Ready = true;
  // Acknowledge Interrupt to AEC Core and Interrupt Controller
  XIntc_Acknowledge(InterruptController, AEC_INTR_ID);
  //XIntc_Disable(InterruptController, AEC_INTR_ID);
}

/*--------------------------------------------------------- 
 FONCTION : AEC_InterruptProcess
---------------------------------------------------------*/
void AEC_InterruptProcess(gcRegistersData_t *pGCRegs,  t_AEC *pAEC_CTRL)
{
   uint32_t AEC_Int_timeStamp = 0;
   uint32_t AEC_Int_FWPosition = 0;
   float AEC_Int_expTime = 0;
   uint32_t AEC_Int_lowerbinId = 0;
   uint32_t AEC_Int_lowercumsum = 0;
   uint32_t AEC_Int_uppercumsum = 0;
   uint32_t AEC_Int_imagefraction_fbck = 0;
   uint32_t AECP_Int_NbPixels = 0;
   bool AEC_Int_errors = false;

   float p_factor = 0.0f;
   uint32_t kif_factor = 0;
   float CurrentWF = 0;
   float TargetWF = 0;
   uint16_t PDRmin = 0;
   uint16_t PDRmax = 0;
   float CorrectionFactor = 0.0f;
   float TargetExpTime = 0.0f;
   float ProposedExposureTimeLast = 0.0f;
   float DeltaT = 0.0;
   float alpha  = 0.0f;
   float PET = 0.0f;
   float den;

   bool AECPlusdone = false;

   const float binWidth = exp2f((float)FPA_DATA_RESOLUTION) / (float)AEC_NB_BIN;
   extern gcRegister_t* pGcRegsDefExposureTimeX[MAX_NUM_FILTER];

#ifdef AEC_ENABLE_PROFILER
   static statistics_t aec_stats;
   static statistics_t aec_plus_stats;
   static timerData_t report_timer;
   static uint64_t profiler;
   static bool reset = true;
   static uint32_t numNotReady = 0;
   static uint32_t numReady = 0;
#endif

#ifdef AEC_ENABLE_PROFILER
   if (reset)
   {
      reset = false;
      resetStats(&aec_stats);
      resetStats(&aec_plus_stats);
      StartTimer(&report_timer, 10000);
      numNotReady = 0;
      numReady = 0;
   }

   gAEC_Data_Ready ? ++numReady : ++numNotReady;

   GETTIME(&profiler);
#endif

   if(gAEC_Data_Ready == false)
   {
      return;
   }

   gAEC_Data_Ready = false;

   // Start wait time for AEC+
   if (GC_AECPlusIsActive && AECArmed && (AECPlusArmedDelay.enabled == false))
   {
      StartTimer(&AECPlusArmedDelay, ((uint32_t)gcRegsData.AECResponseTime) * 5);
   }

   AEC_Int_FWPosition = AXI4L_read32(AEC_BASE_ADDR + AEC_FWPOSITION_OFFSET);
   if ((AEC_Int_FWPosition == FWPOSITION_NOT_IMPLEMENTED) || (pGCRegs->FWMode == FWM_Fixed))
   {
      AEC_Int_FWPosition = 0;    // on utilise l'index 0 lorsque sans roue a filtre
      ProposedExposureTimeLast = gcRegsData.ExposureTime;
   }
   else
   {
      ProposedExposureTimeLast = *((float*)pGcRegsDefExposureTimeX[AEC_Int_FWPosition]->p_data);
   }

   AEC_Int_expTime            = ((float) AXI4L_read32(AEC_BASE_ADDR + AEC_EXPOSURETIME_OFFSET)) / EXPOSURE_TIME_FACTOR; // in us
   if ((AEC_Int_FWPosition == FWPOSITION_IN_TRANSITION) || (fabsf(ProposedExposureTimeLast - AEC_Int_expTime) >= AEC_EXPTIME_THRESHOLD))
   {
      // On reset l'histogramme lorsqu'on est � l'ext�rieur d'une plage valide ou si le PET pr�c�dent n'a pas encore �t� appliqu�.
      AEC_ClearMem(pAEC_CTRL);
      AEC_PRINTF("Histogram rejected: Last proposed ET was not applied\n");
   }
   else
   {
      // Read Data
      AEC_Int_lowerbinId         = AXI4L_read32(AEC_BASE_ADDR + AEC_LOWERBINID_OFFSET);
      AEC_Int_lowercumsum        = AXI4L_read32(AEC_BASE_ADDR + AEC_LOWERCUMSUM_OFFSET);
      AEC_Int_uppercumsum        = AXI4L_read32(AEC_BASE_ADDR + AEC_UPPERCUMSUM_OFFSET);
      AEC_Int_errors             = (bool) AXI4L_read32(AEC_BASE_ADDR + AEC_CUMSUM_ERR_OFFSET);
      AEC_Int_imagefraction_fbck = AXI4L_read32(AEC_BASE_ADDR + AEC_IMAGEFRACTION_FBCK_OFFSET);
      AEC_Int_timeStamp          = AXI4L_read32(AEC_BASE_ADDR + AEC_TIMESTAMP_OFFSET);

      //Clear MEM
      AEC_ClearMem(pAEC_CTRL);

      if (AEC_TimeStamps_d1[AEC_Int_FWPosition] == 0) // First time in AEC there is no last timestamp
      {
         AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;
         AEC_PRINTF("AEC_TimeStamps_d1[%u] == 0\n", AEC_Int_FWPosition);
         return;
      }
      else if ((pGCRegs->ExposureAuto == EA_ContinuousNDFilter) && (pGCRegs->NDFilterPosition == NDFP_NDFilterInTransition))  // AECPlus holds the AEC when "in transition"
      {
         AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;
         AEC_PRINTF("NDF in transition\n");
         return;
      }

      if (GC_AECPlusIsActive)
      {
         AECP_Int_Data_Valid = AXI4L_read32(AEC_BASE_ADDR + AECP_DATAVALID_OFFSET);
         if (AECP_Int_Data_Valid)
         {
           // Read Data
           AECP_Int_Sum_Cnts       = (uint64_t)AXI4L_read32(AEC_BASE_ADDR + AECP_SUMCNT_MSB_OFFSET) << 32;
           AECP_Int_Sum_Cnts       |= (uint64_t)AXI4L_read32(AEC_BASE_ADDR + AECP_SUMCNT_LSB_OFFSET);
           AECP_Int_SumExpTime     = (float)AXI4L_read32(AEC_BASE_ADDR + AECP_EXPTIME_OFFSET) / EXPOSURE_TIME_FACTOR; // in us
           AECP_Int_NbPixels       = AXI4L_read32(AEC_BASE_ADDR + AECP_NBPIXELS_OFFSET);
         }
      }

      if (calibrationInfo.isValid == false)
      {
         PDRmin = DEFAULT_PIXDYNRANGEMIN;
         PDRmax = DEFAULT_PIXDYNRANGEMAX;
      }
      else
      {
         // NL calibration parameters are always the same for all the blocks of a collection
         PDRmin = calibrationInfo.blocks[0].PixelDynamicRangeMin;
         PDRmax = calibrationInfo.blocks[0].PixelDynamicRangeMax;
      }

      // Check for errors
      if (AEC_Int_errors)
      {
         AEC_PRINTF("AEC CUMSUM ERROR\n");
      }

      // Interpolation
      kif_factor = AEC_Int_lowerbinId; // CDF(Kif)
      p_factor = (float)(AEC_Int_imagefraction_fbck - AEC_Int_lowercumsum) / (float)(AEC_Int_uppercumsum - AEC_Int_lowercumsum);
      CurrentWF = (p_factor + (float)kif_factor) * binWidth;

      // Correction factor
      TargetWF = (float)(PDRmin + (pGCRegs->AECTargetWellFilling/100.0f) * (PDRmax-PDRmin));
      AEC_PRINTF("CurrentWF = " _PCF(3) ", TargetWF = " _PCF(3) "\n", _FFMT(CurrentWF, 3), _FFMT(TargetWF, 3));

      den = MAX(1.0f, CurrentWF - (float)PDRmin);
      CorrectionFactor =  (TargetWF - (float)PDRmin) / den;

      // Verify saturation
      if (CurrentWF >= (float)PDRmax)
      {
         // Reduce the correction factor if the calculation is distorted by saturation
         CorrectionFactor = MIN(CorrectionFactor, flashSettings.AECSaturatedCorrectionFactor);
         // If there is saturation and we are not already at ETmin, skip AEC+ processing
         if (fabsf(pGCRegs->ExposureTimeMin - AEC_Int_expTime) >= AEC_EXPTIME_THRESHOLD)
            AECPlusdone = true;
      }

      // Check if Correction factor is valid
      if (CorrectionFactor > CORRECTION_FACTOR_MAX)
      {
         CorrectionFactor = CORRECTION_FACTOR_MAX;
      }
      else if (CorrectionFactor < CORRECTION_FACTOR_MIN)
      {
         CorrectionFactor = CORRECTION_FACTOR_MIN;
      }
      AEC_PRINTF("CorrectionFactor = " _PCF(3) "\n", _FFMT(CorrectionFactor, 3));

      // Target ET
      TargetExpTime = CorrectionFactor * AEC_Int_expTime ; //CorrectionFactor * exptime used in histogram

      // IIR Filter
      if (AEC_Int_timeStamp <= AEC_TimeStamps_d1[AEC_Int_FWPosition]) // Check for wrap around
      {
         DeltaT = (float)(4294967296 - AEC_TimeStamps_d1[AEC_Int_FWPosition] + AEC_Int_timeStamp) / (float)AEC_BASE_CLOCK_FREQ_HZ; //(2^32 - Last Value) + NewValue
      }
      else
      {
         DeltaT = (float)(AEC_Int_timeStamp - AEC_TimeStamps_d1[AEC_Int_FWPosition]) / (float)AEC_BASE_CLOCK_FREQ_HZ;
      }

      AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;

      alpha = powf(0.05f, (1.0f / (pGCRegs->AECResponseTime / (DeltaT*1000.0f)) )); // AEC REsponse time in ms DeltaT is Sec

      if (alpha >= ALPHA_MAX)
      {
         alpha = ALPHA_MAX;
      }

      PET = (1.0f-alpha) * TargetExpTime + alpha * AEC_Int_expTime;

      //round to 0.1us
      PET = (float)((uint32_t)(PET/AEC_EXPOSURE_TIME_RESOLUTION)) * AEC_EXPOSURE_TIME_RESOLUTION;

      //Limite to ETmin and ETmax
      if (PET < pGCRegs->ExposureTimeMin)
      {
         PET = pGCRegs->ExposureTimeMin;
      }
      else if (PET > pGCRegs->ExposureTimeMax)
      {
         PET = pGCRegs->ExposureTimeMax;
      }


      //********************
      // AEC+ Calculus
      //********************
      if (GC_AECPlusIsActive)
      {
         // Check for errors
         if ((!AECP_Int_Data_Valid) || (AECP_Int_NbPixels != (pGCRegs->Width * pGCRegs->Height)))
         {
            if (!AECP_Int_Data_Valid)
               AEC_PRINTF("!AECP_Int_Data_Valid\n");

            if (AECP_Int_NbPixels != (pGCRegs->Width * pGCRegs->Height))
               AEC_PRINTF("AECP_Int_NbPixels != (pGCRegs->Width * pGCRegs->Height\n");

            AECPlusdone = true;
         }

         if (!AECPlusdone && AECArmed && !TimedOut(&AECPlusArmedDelay))
         {
            AEC_PRINTF("!TimedOut(&AECPlusArmedDelay\n");
            AECPlusdone = true;
         }

         // Check if we have a NDF higher than the current filter
         if (!AECPlusdone && pGCRegs->NDFilterPositionSetpoint < MaxNDFPosition)
         {
            // if we change the ND filter, no need to check for other option.
            if (AECPlusCheckForAttenuation(pGCRegs, PET))
            {
               // Change ND filter and return new proposed ET
               PET = AECPlusChangeFilter(pGCRegs, true, PET);
               AECPlusdone = true;
            }
         }

         //Check if we have a NDF lower than the current filter
         if (!AECPlusdone && pGCRegs->NDFilterPositionSetpoint > MinNDFPosition)
         {
            if (AECPlusCheckForUnattenuation(pGCRegs, PET))
            {
               // Change ND filter and return new proposed ET
               PET = AECPlusChangeFilter(pGCRegs, false, PET);
               AECPlusdone = true;
            }
         }

         if (!AECPlusdone && AECArmed) // quand on atteint ce point, le mode ARM est trigg� et l'AEC+ peut commencer � suivre la sc�ne
         {
            AEC_PRINTF("AECArmed = false\n");
            // Apply new ExposureAuto mode
            GC_SetExposureAuto(EA_ContinuousNDFilter);
            AECArmed = false;
         }
      }


      //-----------------------------
      // Apply proposed exposure time
      //-----------------------------
      AEC_PRINTF("Proposed ET = " _PCF(3) "\n", _FFMT(PET, 3));
      if ((AEC_Int_FWPosition == FWPOSITION_NOT_IMPLEMENTED) || (pGCRegs->FWMode == FWM_Fixed))
      {
         GC_SetExposureTime(PET);
      }
      else
      {
         SFW_SetExposureTimeArray(AEC_Int_FWPosition, PET);
         FWExposureTime[AEC_Int_FWPosition] = PET;
         GC_RegisterWriteFloat(pGcRegsDefExposureTimeX[AEC_Int_FWPosition], PET);
      }
   }


#ifdef AEC_ENABLE_PROFILER
   updateStats(&aec_stats, elapsed_time_us(profiler));
   GETTIME(&profiler);
#endif

#ifdef AEC_ENABLE_PROFILER
   updateStats(&aec_plus_stats, elapsed_time_us(profiler));

   if (TimedOut(&report_timer) || aec_stats.N >= 10000)
   {
      reportStats(&aec_stats, "AEC (�s)");
      resetStats(&aec_stats);

      AEC_PRINTF("AEC: busy ratio: " _PCF(2) "\n", _FFMT((float)numNotReady/(numNotReady+numReady), 2));
      numNotReady = 0;
      numReady = 0;
   }

   if (TimedOut(&report_timer) || aec_plus_stats.N >= 10000)
   {
      reportStats(&aec_plus_stats, "AEC+ (�s)");
      resetStats(&aec_plus_stats);
   }

   if (TimedOut(&report_timer))
      RestartTimer(&report_timer);

#endif
}

AEC_MSBPOS_t AEC_GetMsbPos()
{
   switch (FPA_DATA_RESOLUTION)
   {
      case 13:
         return AEC_13B;

      case 14:
         return AEC_14B;

      case 15:
         return AEC_15B;

      case 16:
      default:
         return AEC_16B;
   };
}

bool AECPlusCheckForAttenuation(gcRegistersData_t *pGCRegs, float PET)
{
   float SumOfFlux;

   //Check if proposed ExposureTime is the minimum
   if (PET <= pGCRegs->ExposureTimeMin)
   {
      AEC_PRINTF("NDF++ Proposed ET (" _PCF(2) " us) <= ETmin (" _PCF(2) " us)\n", _FFMT(PET, 2), _FFMT(pGCRegs->ExposureTimeMin, 2));
      return true;
   }

   //Calculate the Flux received at the detector [counts/�s]
   SumOfFlux = computeTotalFlux(pGCRegs, AECP_Int_Sum_Cnts, AECP_Int_SumExpTime);

   //Compare the SumOfFlux with MaximumTotalFlux
   if (SumOfFlux >= AECPlusMaximumTotalFlux)
   {
      if (!AECArmed)
      {
         AEC_PRINTF("NDF++ AECP_Int_Sum_Cnts (%u << 32 + %u), AECP_Int_SumExpTime (" _PCF(2) " us)\n", (uint32_t)(AECP_Int_Sum_Cnts >> 32), (uint32_t)AECP_Int_Sum_Cnts, _FFMT(AECP_Int_SumExpTime, 2));
         AEC_PRINTF("NDF++ SumOfFlux (%u) >= MaximumTotalFlux (%u)\n", (uint32_t)SumOfFlux, (uint32_t)AECPlusMaximumTotalFlux);
      }
      return true;
   }

   return false;
}

bool AECPlusCheckForUnattenuation(gcRegistersData_t *pGCRegs, float PET)
{
   float ExposureTimeEstimated, ExposureTimeMinPlusMargin;
   float SumOfFluxEstimated, MaximumTotalFluxMinusMargin;

   //We estimate the proposed ExposureTime for previous NDF
   ExposureTimeEstimated = PET / FluxRatio[pGCRegs->NDFilterPositionSetpoint-1];
   ExposureTimeMinPlusMargin = pGCRegs->ExposureTimeMin / flashSettings.AECPlusExpTimeMargin;

   //Check if the Estimated Exposure Time is far from ExposureTimeMin
   if (ExposureTimeEstimated > ExposureTimeMinPlusMargin)
   {
      //We estimate the Flux received at the detector [counts/�s] for previous NDF
      SumOfFluxEstimated = computeTotalFlux(pGCRegs, AECP_Int_Sum_Cnts, AECP_Int_SumExpTime) * FluxRatio[pGCRegs->NDFilterPositionSetpoint-1];
      MaximumTotalFluxMinusMargin = AECPlusMaximumTotalFlux * flashSettings.AECPlusFluxMargin;

      //Compare the estimated SumOfFlux with MaximumTotalFlux
      if (SumOfFluxEstimated < MaximumTotalFluxMinusMargin)
      {
         if (!AECArmed)
         {
            AEC_PRINTF("NDF-- ExposureTimeEstimated (" _PCF(2) " us) > ExposureTimeMinPlusMargin (" _PCF(2) " us)\n", _FFMT(ExposureTimeEstimated, 2), _FFMT(ExposureTimeMinPlusMargin, 2));
            AEC_PRINTF("NDF-- AECP_Int_Sum_Cnts (%u << 32 + %u), AECP_Int_SumExpTime (" _PCF(2) " us)\n", (uint32_t)(AECP_Int_Sum_Cnts >> 32), (uint32_t)AECP_Int_Sum_Cnts, _FFMT(AECP_Int_SumExpTime, 2));
            AEC_PRINTF("NDF-- SumOfFluxEstimated (%u) < MaximumTotalFluxMinusMargin (%u)\n", (uint32_t)SumOfFluxEstimated, (uint32_t)MaximumTotalFluxMinusMargin);
         }
         return true;
      }
   }

   return false;
}

float AECPlusChangeFilter(gcRegistersData_t *pGCRegs, bool Attenuate, float PET)
{
   float AECPlus_ExpTime;

   // if NDF Continuous Hold keep the filter in place
   if (AECArmed)
      return PET;

   if (Attenuate)
   {
      //Go to the next NDF Filter
      GC_SetNDFilterPositionSetpoint(pGCRegs->NDFilterPositionSetpoint + 1);

      AECPlus_ExpTime = PET * FluxRatio[pGCRegs->NDFilterPositionSetpoint - 1];
   }
   else
   {
      //Go to the previous NDF Filter
      GC_SetNDFilterPositionSetpoint(pGCRegs->NDFilterPositionSetpoint - 1);

      AECPlus_ExpTime = PET / FluxRatio[pGCRegs->NDFilterPositionSetpoint];
   }

   //Check and apply new exposure time relative to flux ratio
   if (AECPlus_ExpTime > pGCRegs->ExposureTimeMax)
   {
      AECPlus_ExpTime = pGCRegs->ExposureTimeMax;
   }
   else if (AECPlus_ExpTime < pGCRegs->ExposureTimeMin)
   {
      AECPlus_ExpTime = pGCRegs->ExposureTimeMin;
   }

   return AECPlus_ExpTime;
}

void AEC_UpdateAECPlusParameters(void)
{
   uint32_t blockIndex;

   AECPlusMaximumTotalFlux = 0.0F;
   FluxRatio[0] = 1.0F;
   FluxRatio[1] = 1.0F;

   // Reset available filter position
   MinNDFPosition = (AvailabilityFlagsTst(NDFilter1IsAvailableMask) ? NDFP_NDFilter1 : NDFP_NDFilter2);
   MaxNDFPosition = (AvailabilityFlagsTst(NDFilter3IsAvailableMask) ? NDFP_NDFilter3 : NDFP_NDFilter2);

   // Should not happen
   if (MinNDFPosition == MaxNDFPosition)
      return;

   for (blockIndex = 0; blockIndex < calibrationInfo.collection.NumberOfBlocks ; blockIndex++)
   {
      // Searching for maximal total flux value
      if (AECPlusMaximumTotalFlux < calibrationInfo.blocks[blockIndex].MaximumTotalFlux)
      {
         // Find the maximum total flux
         AECPlusMaximumTotalFlux = calibrationInfo.blocks[blockIndex].MaximumTotalFlux;
      }
   }

   // If flux ratio from collection are configured then use them
   if (calibrationInfo.collection.FluxRatio01 != 0)
   {
      FluxRatio[0] = calibrationInfo.collection.FluxRatio01;
   }
   if (calibrationInfo.collection.FluxRatio12 != 0)
   {
      FluxRatio[1] = calibrationInfo.collection.FluxRatio12;
   }

   AEC_PRINTF("AEC+ FluxRatio01 = " _PCF(3) "\n", _FFMT(FluxRatio[0], 3));
   AEC_PRINTF("AEC+ FluxRatio12 = " _PCF(3) "\n", _FFMT(FluxRatio[1], 3));
   AEC_PRINTF("AEC+ MaximumTotalFlux = %u\n", ((uint32_t)AECPlusMaximumTotalFlux));
   AEC_PRINTF("AEC+ FluxMargin = " _PCF(3) "\n", _FFMT(flashSettings.AECPlusFluxMargin, 3));
   AEC_PRINTF("AEC+ ExpTimeMargin = " _PCF(3) "\n", _FFMT(flashSettings.AECPlusExpTimeMargin, 3));
   AEC_PRINTF("AEC+ MinNDFPosition = %u\n", MinNDFPosition);
   AEC_PRINTF("AEC+ MaxNDFPosition = %u\n", MaxNDFPosition);

}

float computeTotalFlux(gcRegistersData_t *pGCRegs, uint64_t totalCounts, float ET)
{
   float totalFlux;
   float alpha;

   const uint32_t NbPixelTotal = FPA_CONFIG_GET(width_max) * FPA_CONFIG_GET(height_max);
   const uint32_t NbPixelsRead = pGCRegs->Width * pGCRegs->Height;
   const float pixelRatio = (float)NbPixelTotal / (float)NbPixelsRead;

   // Calculate Extrapolation factor
   alpha = (1.0f - pGCRegs->AECPlusExtrapolationWeight) + pixelRatio * pGCRegs->AECPlusExtrapolationWeight;

   totalFlux = (float)totalCounts/ET * alpha;

   return totalFlux;
}
