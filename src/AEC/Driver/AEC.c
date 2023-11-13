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
extern calibrationInfo_t calibrationInfo;
extern t_Trig gTrig;

static uint32_t AEC_TimeStamps_d1[SFW_FILTER_NB];
uint64_t AECP_Int_Sum_Cnts;
uint32_t AECP_Int_Data_Valid, AEC_NbPixelTotal;
float AECP_Int_SumExpTime;
float AECPlusMaximumTotalFlux;
float FluxRatio[2];
uint8_t MinNDFPosition, MaxNDFPosition;

static timerData_t AECPlusDataPrintf, AECPlusArmedDelay;
float AECPlus_ExpTime = 0;
bool AECArmed = false;

bool AECPlusCheckForUnattenuation(gcRegistersData_t *pGCRegs, float PET);
bool AECPlusCheckForAttenuation(gcRegistersData_t *pGCRegs, float PET);
void AECPlusChangeFilter(gcRegistersData_t *pGCRegs, bool Attenuate);
float computeTotalFlux(int N, int n, float totalCounts, float ET, float w);
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
   pAEC_CTRL->AEC_ImageFraction = (uint32_t)  (pGCRegs->SensorWidth * pGCRegs->SensorHeight * 0.5f); // 50% of the pixel by default
   pAEC_CTRL->AEC_MSB_Pos = AEC_GetMsbPos();
   pAEC_CTRL->AEC_clearmem = 1;
   pAEC_CTRL->AEC_NB_Bin = AEC_NB_BIN;
   pAEC_CTRL->AEC_NewConfigFlag = 0;
   pAEC_CTRL->AEC_DecimatorInputWidth = pGCRegs->SensorWidth;
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

   AEC_NbPixelTotal = pGCRegs->SensorWidth * pGCRegs->SensorHeight;

   StartTimer(&AECPlusDataPrintf, 1000);

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

   bool done = false;

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

   // Start wait time for AEC
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
      // On reset l'histogramme lorsqu'on est à l'extérieur d'une plage valide ou si le PET précédent n'a pas encore été appliqué.
      AEC_ClearMem(pAEC_CTRL);
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

      if (AEC_TimeStamps_d1[AEC_Int_FWPosition] == 0) // Condition where filter was changed but haven't reached setpoint in AEC+
      {
         AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;
         AEC_PRINTF("AEC_TimeStamps_d1[AEC_Int_FWPosition] == 0\n");
         return;
      }
      else if (((pGCRegs->ExposureAuto == EA_ContinuousNDFilter) && (pGCRegs->NDFilterPosition == NDFP_NDFilterInTransition)) || // AECPlus hold the AEC when "in transition"
            ((AECPlus_ExpTime != 0) && (pGCRegs->NDFilterPosition == pGCRegs->NDFilterPositionSetpoint))) // Set AECPlus ExpTime when no frame was received during "in transition", i.e. at lower frame rates
      {

         if (AECPlus_ExpTime != 0)
         {
            GC_SetExposureTime(AECPlus_ExpTime);
            AECPlus_ExpTime = 0;
         }

         AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;
         AEC_PRINTF("AECPlus_ExpTime != 0\n");
         return;
      }

      if (GC_AECPlusIsActive)
      {
         AECP_Int_Data_Valid = AXI4L_read32(AEC_BASE_ADDR + AECP_DATAVALID_OFFSET);
         if(AECP_Int_Data_Valid)
         {
           // Read Data
           AECP_Int_Sum_Cnts       = AXI4L_read32(AEC_BASE_ADDR + AECP_SUMCNT_MSB_OFFSET);
           AECP_Int_Sum_Cnts       = (AECP_Int_Sum_Cnts << 32);
           AECP_Int_Sum_Cnts       |= AXI4L_read32(AEC_BASE_ADDR + AECP_SUMCNT_LSB_OFFSET);
           AECP_Int_SumExpTime     = ((float)AXI4L_read32(AEC_BASE_ADDR + AECP_EXPTIME_OFFSET) / 100);
           AECP_Int_NbPixels       = AXI4L_read32(AEC_BASE_ADDR + AECP_NBPIXELS_OFFSET);
         }
      }

      if(calibrationInfo.isValid == false)
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
      if(AEC_Int_errors)
      {
         AEC_PRINTF("AEC CUMSUM ERROR\n");
      }

      // Interpolation
      kif_factor = AEC_Int_lowerbinId; // CDF(Kif)
      p_factor = (float)(AEC_Int_imagefraction_fbck - AEC_Int_lowercumsum) / (float)(AEC_Int_uppercumsum - AEC_Int_lowercumsum);
      CurrentWF = (p_factor + (float)kif_factor) * binWidth;

      // Correction factor
      TargetWF = (float) ( PDRmin + (pGCRegs->AECTargetWellFilling/100) * (PDRmax-PDRmin));

      den = MAX(1.0, CurrentWF - ((float)PDRmin));
      CorrectionFactor =  (TargetWF - ((float) PDRmin)) / den;

      // Verify saturation
      if (CurrentWF >= (float)PDRmax)
         // Reduce the correction factor if the calculation is distorted by saturation
         CorrectionFactor = MIN(CorrectionFactor, flashSettings.AECSaturatedCorrectionFactor);

      // Check if Correction factor is valid
      if(CorrectionFactor > CORRECTION_FACTOR_MAX)
      {
         CorrectionFactor = CORRECTION_FACTOR_MAX;
      }
      else if(CorrectionFactor < CORRECTION_FACTOR_MIN)
      {
         CorrectionFactor = CORRECTION_FACTOR_MIN;
      }

      // Target ET
      TargetExpTime = CorrectionFactor * AEC_Int_expTime ; //CorrectionFactor * exptime used in histogram

      // IIR Filter
      if(AEC_Int_timeStamp <= AEC_TimeStamps_d1[AEC_Int_FWPosition]) // Check for wrap around
      {
         DeltaT = (float)(( 4294967296 - AEC_TimeStamps_d1[AEC_Int_FWPosition] ) + AEC_Int_timeStamp) / (float)AEC_BASE_CLOCK_FREQ_HZ; //(2^32 - Last Value) + NewValue
      }
      else
      {
         DeltaT = (float)(AEC_Int_timeStamp - AEC_TimeStamps_d1[AEC_Int_FWPosition]) / (float)AEC_BASE_CLOCK_FREQ_HZ;
      }

      AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;

      alpha = powf(0.05f, (1.0f / (pGCRegs->AECResponseTime / (DeltaT*1000)) )); // AEC REsponse time in ms DaltaT is Sec

      if (alpha >= ALPHA_MAX)
      {
         alpha = ALPHA_MAX;
      }

      PET = (1-alpha) * TargetExpTime + alpha * AEC_Int_expTime;

      //round to 0.1us
      PET = ((float)((uint32_t)(PET/AEC_EXPOSURE_TIME_RESOLUTION))) * AEC_EXPOSURE_TIME_RESOLUTION;

      //Limite to ETmin and ETmax
      if(PET < pGCRegs->ExposureTimeMin)
      {
         PET = pGCRegs->ExposureTimeMin;
      }
      else if(PET > pGCRegs->ExposureTimeMax)
      {
         PET = pGCRegs->ExposureTimeMax;
      }


      if ((AEC_Int_FWPosition == FWPOSITION_NOT_IMPLEMENTED) || (pGCRegs->FWMode == FWM_Fixed))
      {
         //Apply Exposure time
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

   //********************
   // AEC+ Calculus
   //********************

   if (GC_AECPlusIsActive)
   {
	   // Check if we are in the mode AECPlusContinuous, if AEC+ data is valid or if filter command have already been sent
	   if((!AECP_Int_Data_Valid) || (AECPlus_ExpTime != 0) || (AECP_Int_NbPixels != (pGCRegs->Width * pGCRegs->Height)))
	   {
	      //Apply Exposure time
	      //GC_SetExposureTime(PET); // deja appliqué

	      if (TimedOut(&AECPlusDataPrintf))
	      {
	         if (!AECP_Int_Data_Valid)
	            AEC_PRINTF("!AECP_Int_Data_Valid\n");

	         if (AECPlus_ExpTime != 0)
	            AEC_PRINTF("AECPlus_ExpTime != 0\n");

	         if (AECP_Int_NbPixels != (pGCRegs->Width * pGCRegs->Height))
	            AEC_PRINTF("AECP_Int_NbPixels != (pGCRegs->Width * pGCRegs->Height\n");

	         StartTimer(&AECPlusDataPrintf, 1000);
	      }
	      done = true;
	   }

	   if (!done && AECArmed && !TimedOut(&AECPlusArmedDelay))
	   {
	      AEC_PRINTF("!TimedOut(&AECPlusArmedDelay\n");
	      done = true;
	   }

	   // Check if we have a NDF higher than the current filter
	   if (!done && pGCRegs->NDFilterPositionSetpoint < MaxNDFPosition)
	   {
	      // if we changed the ND filter, no need to check for other option.
	      if (AECPlusCheckForAttenuation(pGCRegs, PET))
	      {
	         AECPlusChangeFilter(pGCRegs, true);
	         done = true;
	      }
	   }

	   //Check if we have a NDF lower than the current filter
	   if (!done && pGCRegs->NDFilterPositionSetpoint > MinNDFPosition)
	   {
	      if(AECPlusCheckForUnattenuation(pGCRegs, PET))
	      {
	         AECPlusChangeFilter(pGCRegs, false);
	         done = true;
	      }
	   }

	   if (!done && AECArmed) // quand on atteint ce point, le mode ARM est triggé et l'AEC+ peut commencer à suivre la scène
	   {
	      AEC_PRINTF("AECArmed = false\n");
	      // Apply new ExposureAuto mode
	      GC_SetExposureAuto(EA_ContinuousNDFilter);
	      AECArmed = false;
	   }

   }

#ifdef AEC_ENABLE_PROFILER
   updateStats(&aec_plus_stats, elapsed_time_us(profiler));

   if (TimedOut(&report_timer) || aec_stats.N >= 10000)
   {
      reportStats(&aec_stats, "AEC (µs)");
      resetStats(&aec_stats);

      AEC_PRINTF("AEC: busy ratio: " _PCF(2) "\n", _FFMT((float)numNotReady/(numNotReady+numReady), 2));
      numNotReady = 0;
      numReady = 0;
   }

   if (TimedOut(&report_timer) || aec_plus_stats.N >= 10000)
   {
      reportStats(&aec_plus_stats, "AEC+ (µs)");
      resetStats(&aec_plus_stats);
   }

   if (TimedOut(&report_timer))
      RestartTimer(&report_timer);

#endif
}

AEC_MSBPOS_t AEC_GetMsbPos()
{
   AEC_MSBPOS_t p;

   switch (FPA_DATA_RESOLUTION)
   {
   case 13:
      p = AEC_13B;
      break;

   case 14:
      p = AEC_14B;
      break;

   case 15:
      p = AEC_15B;
      break;

   case 16:
      p = AEC_16B;
      break;
   default:
      p = AEC_16B;
   };

   return p;
}

bool AECPlusCheckForAttenuation(gcRegistersData_t *pGCRegs, float PET)
{
   float SumOfFlux;
   float NbPixelsRead;

   //Check if ExposureTime is at its minimum
   if (PET == pGCRegs->ExposureTimeMin)
   {
      AEC_PRINTF("AEC ForAt - EXPTIME at min\n");
      return true;
   }

   NbPixelsRead = (float) (pGCRegs->Width * pGCRegs->Height);

   //Calculate the Flux received at the detector [counts/µs]
   SumOfFlux = computeTotalFlux(AEC_NbPixelTotal, NbPixelsRead, AECP_Int_Sum_Cnts, AECP_Int_SumExpTime, pGCRegs->AECPlusExtrapolationWeight);

   if (TimedOut(&AECPlusDataPrintf))
   {
      AEC_PRINTF("SumOfFlux: %d\n", (uint32_t)(SumOfFlux));
      AEC_PRINTF("AECP_Int_SumExpTime: %d\n", (uint32_t)(AECP_Int_SumExpTime));
      StartTimer(&AECPlusDataPrintf, 1000);
   }

   //Compare the SumOfFlux with MaximumTotalFlux
   if(SumOfFlux >= AECPlusMaximumTotalFlux)
   {
      if (!AECArmed)
      {
         AEC_PRINTF("AEC ForAt - AECP_Int_Sum_Cnts=%d, NbPixelsRead = %d, AEC_NbPixelTotal=%d, AECP_Int_SumExpTime(x100)=%d\n",AECP_Int_Sum_Cnts, (uint32_t)NbPixelsRead, AEC_NbPixelTotal,((uint32_t) (AECP_Int_SumExpTime*100)));
         AEC_PRINTF("AEC ForAt- SumOfFlux=%d, MaximumTotalFlux=%d\n", (uint32_t) SumOfFlux, (uint32_t)AECPlusMaximumTotalFlux);
      }
      return true;
   }
   else
   {
      return false;
   }

}

bool AECPlusCheckForUnattenuation(gcRegistersData_t *pGCRegs, float PET)
{
   float ExposureTimeEstimated;
   float SumOfFlux;
   uint32_t NbPixelsRead;

   //We estimate the new ExposureTime
   ExposureTimeEstimated = PET/FluxRatio[pGCRegs->NDFilterPositionSetpoint-1];

   //Check if the Estimated Exposure Time if far from ExposureTimeMin with new filter
   if (ExposureTimeEstimated > (pGCRegs->ExposureTimeMin/flashSettings.AECPlusExpTimeMargin))
   {
      NbPixelsRead = pGCRegs->Width * pGCRegs->Height;

      //Calculate the Flux received at the detector [counts/µs]
      SumOfFlux = computeTotalFlux(AEC_NbPixelTotal, NbPixelsRead, AECP_Int_Sum_Cnts, AECP_Int_SumExpTime, pGCRegs->AECPlusExtrapolationWeight);

      if (TimedOut(&AECPlusDataPrintf))
      {
         AEC_PRINTF("SumOfFlux: %d\n", (uint32_t)(SumOfFlux));
         AEC_PRINTF("AECP_Int_SumExpTime: %d\n", (uint32_t)(AECP_Int_SumExpTime));
         StartTimer(&AECPlusDataPrintf, 1000);
      }

      //Compare the SumOfFlux with MaximumTotalFlux
      if(SumOfFlux * FluxRatio[pGCRegs->NDFilterPositionSetpoint - 1] < AECPlusMaximumTotalFlux * flashSettings.AECPlusFluxMargin)
      {
         if (!AECArmed)
         {
            AEC_PRINTF("AEC ForUnat- AECP_Int_Sum_Cnts=%d, NbPixelsRead = %d, AEC_NbPixelTotal=%d, AECP_Int_SumExpTime=%d (x100)\n",AECP_Int_Sum_Cnts, (uint32_t)NbPixelsRead,AEC_NbPixelTotal,((uint32_t)(AECP_Int_SumExpTime*100)));
            AEC_PRINTF("AEC ForUnat- SumOfFlux=%d, MaximumTotalFlux=%d\n",(uint32_t) SumOfFlux, (uint32_t)AECPlusMaximumTotalFlux);
            AEC_PRINTF("AEC ForUnat - FluxRatio(x100)=%d, FPA_FLUX_MARGIN_AECP(x100)=%d\n",(uint32_t)(FluxRatio[pGCRegs->NDFilterPositionSetpoint-1]*100.0f),(uint32_t)(100.0f*flashSettings.AECPlusFluxMargin));
         }
         return true;
      }
   }

   return false;
}

void AECPlusChangeFilter(gcRegistersData_t *pGCRegs, bool Attenuate)
{
   // if NDF Continuous Hold keep the filter in place
   if (AECArmed)
      return;

   AECPlus_ExpTime = AECP_Int_SumExpTime;

   if(Attenuate)
   {
      GC_SetNDFilterPositionSetpoint(pGCRegs->NDFilterPositionSetpoint + 1); //Go to the next NDF Filter

      AECPlus_ExpTime *= FluxRatio[pGCRegs->NDFilterPositionSetpoint - 1];
   }
   else
   {
      //Go to the previous NDF Filter
      GC_SetNDFilterPositionSetpoint(pGCRegs->NDFilterPositionSetpoint - 1); //Go to the next NDF Filter

      AECPlus_ExpTime /= FluxRatio[pGCRegs->NDFilterPositionSetpoint];
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

#ifdef AEC_VERBOSE
   t_PosixTime t0 = TRIG_GetRTC(&gTrig);
#endif

   AEC_PRINTF("AECPlus_ExpTime (x100) = %d\n", ((uint32_t)AECPlus_ExpTime * 100));
   AEC_PRINTF("AEC+: change filter request @ %010d.%d s\n", t0.Seconds, t0.SubSeconds);
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

   AEC_PRINTF("AEC+ available\n");
   AEC_PRINTF("AEC+ FluxRatio01 = %d\n", ((uint32_t) FluxRatio[0]));
   AEC_PRINTF("AEC+ FluxRatio12 = %d\n", ((uint32_t) FluxRatio[1]));
   AEC_PRINTF("AEC+ Maximal Total Flux = %d\n", ((uint32_t) AECPlusMaximumTotalFlux));
   AEC_PRINTF("AEC+ MinNDFPosition = %d\n", MinNDFPosition);
   AEC_PRINTF("AEC+ MaxNDFPosition = %d\n", MaxNDFPosition);

}

float computeTotalFlux(int N, int n, float totalCounts, float ET, float w)
{
   float totalFlux;
   float alpha;

   const float pixelRatio = (float)N/(float)n;

   // Calculate Extrapolation factor
   alpha = (1.0f - w) + pixelRatio*w;

   totalFlux = totalCounts/ET * alpha;

   return totalFlux;
}
