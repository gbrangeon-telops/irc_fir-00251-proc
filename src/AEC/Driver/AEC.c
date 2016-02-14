#include "stdbool.h"
#include "AEC.h"
#include "fpa_intf.h"
#include "utils.h"
#include "Calibration.h"
#include "Genicam.h"
#include "proc_init.h"
#include "xintc.h"
#include "mb_axi4l_bridge.h"
#include "math.h"
#include "SFW_ctrl.h"
#include "exposure_time_ctrl.h"
#include <string.h>

//#define AEC_INT_TIME_PRINT
#define ALPHA_MAX    0.976f   // ToDo: determiner la variation minimale de l'ExpTime pour chaque detecteur

#define AEC_PRINT    //PRINT
#define AEC_PRINTF   PRINTF

static volatile bool gAEC_Data_Ready  = false;

extern XIntc gProcIntc;
extern t_AEC gAEC_CTRL;
extern float FWExposureTime[MAX_NUM_FILTER];

static uint32_t AEC_TimeStamps_d1[SFW_FILTER_NB];

/*----------------------------------------------------- 
FONCTION : AEC_SetupInterruptSystem
------------------------------------------------------*/
inline int32_t AEC_SetupInterruptSystem(XIntc * InterruptController)
{
return XIntc_Connect(InterruptController, AEC_INTR_ID, (XInterruptHandler)XAEC_InterruptHandler, InterruptController);
}

/*--------------------------------------------------------- 
FONCTION : EnableAECInterrupt
---------------------------------------------------------*/
inline void AEC_EnableInterrupt(XIntc * InterruptController)
{
  //XIntc_Enable(InterruptController, AEC_INTR_ID);
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

	memset(AEC_TimeStamps_d1, 0, sizeof(AEC_TimeStamps_d1));

	//Write Struct to AEC
	WriteStruct(pAEC_CTRL);

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
}

/*--------------------------------------------------------- 
 FONCTION : AEC_UpdateMode
---------------------------------------------------------*/
void AEC_UpdateMode(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL)
{


   if(pGCRegs->ExposureAuto == EA_Off)
   {
	   pAEC_CTRL->AEC_Mode = AEC_OFF;
   }
   else if(pGCRegs->ExposureAuto == EA_Continuous)
   {
	   pAEC_CTRL->AEC_Mode = AEC_ON;
   }
   pAEC_CTRL->AEC_clearmem = 1;
   AXI4L_write32(pAEC_CTRL->AEC_clearmem, pAEC_CTRL->ADD + AEC_CLEARMEM_OFFSET);

   AXI4L_write32(pAEC_CTRL->AEC_Mode, pAEC_CTRL->ADD + AEC_MODE_OFFSET);
   //pAEC_CTRL->AEC_ImageFraction =(uint32_t) ( pGCRegs->Height * pGCRegs->Width * (pGCRegs->AECImageFraction / 100.0f)); // IMAGE FRaction between 0 and 100
   //AXI4L_write32(pAEC_CTRL->AEC_ImageFraction, AEC_BASE_ADDR + AEC_IMAGEFRACTION_OFFSET);
   pAEC_CTRL->AEC_clearmem = 0;
   AXI4L_write32(pAEC_CTRL->AEC_clearmem, pAEC_CTRL->ADD + AEC_CLEARMEM_OFFSET);

}

/*--------------------------------------------------------- 
 FONCTION : AEC_UpdateImageSize
---------------------------------------------------------*/
void AEC_UpdateImageFraction(gcRegistersData_t *pGCRegs, t_AEC *pAEC_CTRL)
{
	pAEC_CTRL->AEC_ImageFraction =(uint32_t) ( pGCRegs->Height * pGCRegs->Width * (pGCRegs->AECImageFraction / 100.0f)); // IMAGE FRaction between 0 and 100
	AXI4L_write32(pAEC_CTRL->AEC_ImageFraction, pAEC_CTRL->ADD + AEC_IMAGEFRACTION_OFFSET);
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
   bool AEC_Int_errors = false;

	float p_factor = 0.0f;
	uint32_t kif_factor = 0;
	float ActualWF = 0;
	float TargetWF = 0;
	uint16_t PDRmin = 0;
	uint16_t PDRmax = 0;
	float CorrectionFactor = 0.0f;
	float TargetExpTime = 0.0f;
	float DeltaT = 0.0;
	float alpha = 0.0f;
	float PET = 0.0f;
	float den;


	if(gAEC_Data_Ready == false)
	{
		return;
	}

	gAEC_Data_Ready = false;

	AEC_Int_FWPosition = AXI4L_read32(AEC_BASE_ADDR + AEC_FWPOSITION_OFFSET);

	if (AEC_Int_FWPosition != FWPOSITION_IN_TRANSITION) {
	   if ((AEC_Int_FWPosition == FWPOSITION_NOT_IMPLEMENTED) || (pGCRegs->FWMode == FWM_Fixed))
	   {
	      AEC_Int_FWPosition = 0;    // on utilise l'index 0 lorsque sans roue a filtre
	   }

      // Read AEC_Int_timeStamp
      AEC_Int_timeStamp          = AXI4L_read32(AEC_BASE_ADDR + AEC_TIMESTAMP_OFFSET);

      if (AEC_TimeStamps_d1[AEC_Int_FWPosition] == 0)
      {
         AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;
         AEC_ClearMem(pAEC_CTRL);
         return;
      }

      // Read Data
      AEC_Int_expTime            = ((float) AXI4L_read32(AEC_BASE_ADDR + AEC_EXPOSURETIME_OFFSET)) / 100.0f; // in us
      AEC_Int_lowerbinId         = AXI4L_read32(AEC_BASE_ADDR + AEC_LOWERBINID_OFFSET);
      AEC_Int_lowercumsum        = AXI4L_read32(AEC_BASE_ADDR + AEC_LOWERCUMSUM_OFFSET);
      AEC_Int_uppercumsum        = AXI4L_read32(AEC_BASE_ADDR + AEC_UPPERCUMSUM_OFFSET);
      AEC_Int_errors             = (bool) AXI4L_read32(AEC_BASE_ADDR + AEC_CUMSUM_ERR_OFFSET);
      AEC_Int_imagefraction_fbck = AXI4L_read32(AEC_BASE_ADDR + AEC_IMAGEFRACTION_FBCK_OFFSET);

      if(calibrationInfo.isValid == false)
      {
         PDRmin = DEFAULT_PIXDYNRANGEMIN ;
         PDRmax = DEFAULT_PIXDYNRANGEMAX;
      }
      else
      {
         PDRmin = calibrationInfo.blocks[AEC_Int_FWPosition].PixelDynamicRangeMin;
         PDRmax = calibrationInfo.blocks[AEC_Int_FWPosition].PixelDynamicRangeMax;
      }

      // Check for errors
      if(AEC_Int_errors)
      {
         AEC_PRINTF("AEC CUMSUM ERROR\n");
      }

      // Interpolation
      kif_factor = AEC_Int_lowerbinId; // CDF(Kif)
      p_factor = (float)(AEC_Int_imagefraction_fbck - AEC_Int_lowercumsum) / (float)(AEC_Int_uppercumsum - AEC_Int_lowercumsum);
      ActualWF = (p_factor + (float)kif_factor) * powf(2,FPA_DATA_RESOLUTION) / (float)AEC_NB_BIN ;

      // Correction factor
      TargetWF = (float) ( PDRmin + (pGCRegs->AECTargetWellFilling/100) * (PDRmax-PDRmin));

      den = MAX(1.0, ActualWF - ((float)PDRmin));
      CorrectionFactor =  (TargetWF - ((float) PDRmin)) / den;

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
      TargetExpTime = CorrectionFactor * AEC_Int_expTime ; //Corectionfactor * exptime used in histogram

      // IIR Filter
      if(AEC_Int_timeStamp <= AEC_TimeStamps_d1[AEC_Int_FWPosition]) // Check for wrap around
      {
         DeltaT =(float) (( 4294967296 - AEC_TimeStamps_d1[AEC_Int_FWPosition] ) + AEC_Int_timeStamp) * TIME_CONSTANT ; //(2^32 - Last Value) + NewValue
      }
      else
      {
         DeltaT =  ( ((float)(AEC_Int_timeStamp - AEC_TimeStamps_d1[AEC_Int_FWPosition])) * TIME_CONSTANT) ; //(2^32 - Last Value) + NewValue
      }

      AEC_TimeStamps_d1[AEC_Int_FWPosition] = AEC_Int_timeStamp;

      alpha = pow(0.05f, (double) (1.0 / (pGCRegs->AECResponseTime / (DeltaT*1000)) )); // AEC REsponse time in ms DaltaT is Sec

      if (alpha >= ALPHA_MAX)
      {
         alpha = ALPHA_MAX;
      }

      PET = (1-alpha) * TargetExpTime + alpha * AEC_Int_expTime;

      // Conformation

      //round to 0.1us
      //PET = roundf(PET*10.0f)/10.0f;

      PET = ((float)((uint32_t)(PET*10.0f))) / 10.0f;

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
         GC_RegisterWriteFloat(&gcRegsDef[ExposureTimeIdx], PET);
      }
      else
      {
         SFW_SetExposureTimeArray(AEC_Int_FWPosition, PET);
         FWExposureTime[AEC_Int_FWPosition] = PET;

         if (AEC_Int_FWPosition == 0)
         {
            pGCRegs->ExposureTime1 = PET;
         }
         else if (AEC_Int_FWPosition == 1)
         {
            pGCRegs->ExposureTime2 = PET;
         }
         else if (AEC_Int_FWPosition == 2)
         {
            pGCRegs->ExposureTime3 = PET;
         }
         else if (AEC_Int_FWPosition == 3)
         {
            pGCRegs->ExposureTime4 = PET;
         }
         else if (AEC_Int_FWPosition == 4)
         {
            pGCRegs->ExposureTime5 = PET;
         }
         else if (AEC_Int_FWPosition == 5)
         {
            pGCRegs->ExposureTime6 = PET;
         }
         else if (AEC_Int_FWPosition == 6)
         {
            pGCRegs->ExposureTime7 = PET;
         }
         else if (AEC_Int_FWPosition == 7)
         {
            pGCRegs->ExposureTime8 = PET;
         }

      }
	}

   //Clear MEM
   AEC_ClearMem(pAEC_CTRL);

}

AEC_MSBPOS_t AEC_GetMsbPos()
{
   if(FPA_DATA_RESOLUTION == 13){
      return AEC_13B;
   }
   else if(FPA_DATA_RESOLUTION == 14){
      return AEC_14B;
   }
   else if(FPA_DATA_RESOLUTION == 15){
      return AEC_15B;
   }
   else if(FPA_DATA_RESOLUTION == 16){
      return AEC_16B;
   }
}

