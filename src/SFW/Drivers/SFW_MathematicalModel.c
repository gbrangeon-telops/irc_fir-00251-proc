
#include "SFW_MathematicalModel.h"
#include "fpa_intf.h"
//#include "wb_lowlevel.h"
#include "utils.h"
#include <math.h>
#include "GC_Registers.h"
#include "FWController.h"
#include "FlashSettings.h"
#include "SFW_ctrl.h"
#include "exposure_time_ctrl.h"

#define SFW_EXPOSUREMAX_MARGING     (flashSettings.FWExposureTimeMaxMargin / 100.0F)

static void BeamIntersect(float dX, float dY, float cornerPixelPositionRadius, float* maxTheta1, float* maxTheta2);
static void ConvertSizeToDeltaAndTarget(uint16_t width, uint16_t height, SFW_ChangedParameterEnum changedParameter, float* dX, float* dY, float* cornerPixelPositionRadius);

static void SFW_CalculFilterRange(gcRegistersData_t *pGCRegs, SFW_ChangedParameterEnum changedParameter);
static void SFW_CalculExposureTimeMax(gcRegistersData_t *pGCRegs);
static void SFW_CalculAcquisitionFrameRateMax(gcRegistersData_t *pGCRegs);

extern float FWExposureTime[MAX_NUM_FILTER];

float SFW_AcquisitionFrameRateMax;
float SFW_ExposureTimeMax;

static float SFW_FiltersRadius;
static float SFW_OpticalAxisTheta;
static float SFW_ClearanceRadius;
static float SFW_Ox;
static float SFW_Oy;
static float SFW_PixelRadius_To_RealRadius;
static float SFW_CurrentParameters_MaxTheta1;
static float SFW_CurrentParameters_MaxTheta2;
static float SFW_CurrentParameters_Target;
static float SFW_RPM_uSec_Max;
static float SFW_dX;
static float SFW_dY;
static float SFW_GreatestFWExposureTime_i;
static float SFW_lastGreatestFWExposureTime_i;

/*
 * Calculate the values of various parameters
 * These will not change because they are only dependant of EEPROM values
 * They are precalculated to speed up the algorithms
 */
void InitMathematicalModel(gcRegistersData_t *pGCRegs)
{
   float ExposureTimeBackup;

   SFW_INF("InitMathematicalModel");
   
   SFW_FiltersRadius = sqrtf(flashSettings.FWOpticalAxisPosX*flashSettings.FWOpticalAxisPosX + flashSettings.FWOpticalAxisPosY*flashSettings.FWOpticalAxisPosY );
   SFW_INF("SFW_FiltersRadius *1000 = %d",(int32_t)(SFW_FiltersRadius*1000));

   SFW_OpticalAxisTheta = atan2f(flashSettings.FWOpticalAxisPosY, flashSettings.FWOpticalAxisPosX);
   SFW_INF("SFW_OpticalAxisTheta *1000 = %d",(int32_t)(SFW_OpticalAxisTheta*1000));
   
   SFW_Ox = SFW_FiltersRadius*cosf(SFW_OpticalAxisTheta);
   SFW_Oy = SFW_FiltersRadius*sinf(SFW_OpticalAxisTheta);
   SFW_INF("SFW_Ox *1000 = %d",(int32_t)(SFW_Ox*1000));
   SFW_INF("SFW_Oy *1000 = %d",(int32_t)(SFW_Oy*1000));
   
   SFW_ClearanceRadius = flashSettings.FWMountingHoleRadius - flashSettings.FWBeamMarging;
   SFW_INF("SFW_ClearanceRadius *1000 = %d",(int32_t)(SFW_ClearanceRadius*1000));
   
   //On perd deux lignes (une en haut et une en bas lors du passage en mode binné) Est-ce qu'on veut prendre cette différence en considération ?
   //if(pGCRegs->BinningMode == BM_Mode2x2) {
      //SFW_PixelRadius_To_RealRadius = (flashSettings.FWCenterPixRadius-flashSettings.FWCornerPixRadius) / sqrtf((float)(FPA_WIDTH_MAX*FPA_WIDTH_MAX + (FPA_HEIGHT_MAX-2)*(FPA_HEIGHT_MAX-2)));
   //} else
   {
      SFW_PixelRadius_To_RealRadius = (flashSettings.FWCenterPixRadius-flashSettings.FWCornerPixRadius) / sqrtf((float)(FPA_WIDTH_MAX*FPA_WIDTH_MAX + FPA_HEIGHT_MAX*FPA_HEIGHT_MAX));
   }

   SFW_INF("SFW_PixelRadius_To_RealRadius *1000 = %d",(int32_t)(SFW_PixelRadius_To_RealRadius*1000));
   
   // Init SFW actualization limits with ETmin to have absolute max
   ExposureTimeBackup = pGCRegs->ExposureTime;
   pGCRegs->ExposureTime = pGCRegs->ExposureTimeMin;

   SFW_AllChanged(pGCRegs);
   pGCRegs->ImageCorrectionFWAcquisitionFrameRateMin = ceilMultiple((float)(FW_VEL_THRESHOLD * flashSettings.FWNumberOfFilters) / 60.0F, 0.01);
   pGCRegs->ImageCorrectionFWAcquisitionFrameRateMax = floorMultiple(MIN(FPA_MaxFrameRate(pGCRegs), SFW_AcquisitionFrameRateMax), 0.01);

   pGCRegs->ExposureTime = ExposureTimeBackup;


   // Calculate new maximal values considering that all parameters has been changed
   // Need to be called at least once to set all global variables
   SFW_AllChanged(pGCRegs);

   if(pGCRegs->FWSpeedSetpoint != 0)
      SFW_ExposureTimeMax = floorf(SFW_RPM_uSec_Max / (float)pGCRegs->FWSpeedSetpoint);
   else
      SFW_ExposureTimeMax = pGCRegs->ExposureTimeMax;
}

/*
 * Calculate the maximum acquisition frame rate allowed when the filter wheel is spinning.
 */
void SFW_CalculAcquisitionFrameRateMax(gcRegistersData_t *pGCRegs)
{
   //SFW_INF("CalculAcquisitionFrameRateMax");

   SFW_AcquisitionFrameRateMax = floorf(SFW_RPM_uSec_Max / SFW_GreatestFWExposureTime_i)*flashSettings.FWNumberOfFilters/60.0f;
   SFW_AcquisitionFrameRateMax = MIN(SFW_AcquisitionFrameRateMax, pGCRegs->FWSpeedMax*flashSettings.FWNumberOfFilters/60.0f);
   SFW_INF("SFW_AcquisitionFrameRateMax = %d\n", (uint32_t) (SFW_AcquisitionFrameRateMax * 10));
}

/*
 * Calculate the maximum exposure time allowed with the filter wheel rotating.
 */
void SFW_CalculExposureTimeMax(gcRegistersData_t *pGCRegs)
{
   //SFW_INF("CalculExposureTimeMax");

   if(pGCRegs->FWSpeedSetpoint != 0)
      SFW_ExposureTimeMax = floorf(SFW_RPM_uSec_Max / (float)pGCRegs->FWSpeedSetpoint); //Temps max ou le filtre est devant le detecteur
   else
      SFW_ExposureTimeMax = pGCRegs->ExposureTimeMax;

   SFW_ExposureTimeMax = MIN(SFW_ExposureTimeMax , FPA_MaxExposureTime(pGCRegs)); //Min entre Temps ou le filtre est devant et Temps du FPA qui tient compte du temps d'exposition+readout possible selon le framerate
}

/*
 * Calculate the maximum valid angle allowed with the filter wheel rotating.
 */
void SFW_CalculFilterRange(gcRegistersData_t *pGCRegs, SFW_ChangedParameterEnum changedParameter)
   {
   //SFW_INF("CalculFilterRange");
      //We always want non binning parameters
      uint32_t nobinWidth = pGCRegs->Width;
      uint32_t nobinHeight = pGCRegs->Height;
      if(pGCRegs->BinningMode != BM_NoBinning) {
         //CUrrently 2x2 = 1 and 4x4 = 2
         nobinWidth = pGCRegs->Width << pGCRegs->BinningMode;
         nobinHeight =  pGCRegs->Height << pGCRegs->BinningMode;
      }
      ConvertSizeToDeltaAndTarget(nobinWidth, nobinHeight, changedParameter, &SFW_dX, &SFW_dY, &SFW_CurrentParameters_Target);
      SFW_INF("Width = %d, Height = %d, SFW_dX = %d, SFW_dY=%d, SFW_CurrentParameters_Target=%d\n",nobinWidth,nobinHeight,(int32_t)(SFW_dX*1000.0f) ,(int32_t)(SFW_dY*1000.0f),(int32_t)(SFW_CurrentParameters_Target*1000.0f));

	   //Calculate the beam intersect to get the filter ranges and angular speed parameter limit (for exposure and frame rate max)
	   BeamIntersect(SFW_dX, SFW_dY, SFW_CurrentParameters_Target, &SFW_CurrentParameters_MaxTheta1, &SFW_CurrentParameters_MaxTheta2);

	   SFW_UpdateFilterRanges(SFW_CurrentParameters_MaxTheta1-SFW_OpticalAxisTheta, SFW_OpticalAxisTheta-SFW_CurrentParameters_MaxTheta2);

	   SFW_RPM_uSec_Max = (SFW_CurrentParameters_MaxTheta1 - SFW_CurrentParameters_MaxTheta2) * 60.0f / 2.0f / (float)M_PI / 0.000001f  * SFW_EXPOSUREMAX_MARGING;
   }

/*
 * Update the maximal values that can be set in GenICam registers when the width has changed.
 */
void SFW_WidthChanged(gcRegistersData_t *pGCRegs)
{
   float SFW_ExposureTimeMax_temp;

   if(flashSettings.FWType != FW_SYNC || flashSettings.FWPresent != 1)
      return;

   //SFW_INF("WidthChanged");

   SFW_CalculFilterRange(pGCRegs, WIDTH_CHANGED);

   if (pGCRegs->FWMode != FWM_SynchronouslyRotating)
      return;

   SFW_ExposureTimeMax_temp = SFW_ExposureTimeMax;
   SFW_CalculExposureTimeMax(pGCRegs);

   SFW_GreatestFWExposureTime_i = SFW_GetMaxExposureTime(pGCRegs);
   if ((SFW_ExposureTimeMax_temp > SFW_ExposureTimeMax) && (SFW_GreatestFWExposureTime_i > SFW_ExposureTimeMax))
      {
         SFW_ExposureTimeMax = SFW_ExposureTimeMax_temp;
      }

   SFW_CalculAcquisitionFrameRateMax(pGCRegs);
   }

/*
 * Update the maximal values that can be set in GenICam registers when the height has changed.
 */
void SFW_HeightChanged(gcRegistersData_t *pGCRegs)
   {
   float SFW_ExposureTimeMax_temp;

   if(flashSettings.FWType != FW_SYNC || flashSettings.FWPresent != 1)
         return;

   //SFW_INF("HeightChanged");

   SFW_CalculFilterRange(pGCRegs, HEIGHT_CHANGED);

   if (pGCRegs->FWMode != FWM_SynchronouslyRotating)
      return;

   SFW_ExposureTimeMax_temp = SFW_ExposureTimeMax;
   SFW_CalculExposureTimeMax(pGCRegs);

   SFW_GreatestFWExposureTime_i = SFW_GetMaxExposureTime(pGCRegs);
   if ((SFW_ExposureTimeMax_temp > SFW_ExposureTimeMax) && (SFW_GreatestFWExposureTime_i > SFW_ExposureTimeMax))
   {
        SFW_ExposureTimeMax = SFW_ExposureTimeMax_temp;
   }
   SFW_CalculAcquisitionFrameRateMax(pGCRegs);
   }

/*
 * Update all maximal values that can be set in GenICam registers (Width, Height, ExposureTime and AcquisitionFrameRate).
 */
void SFW_AllChanged(gcRegistersData_t *pGCRegs)
   {
   if((flashSettings.FWType != FW_SYNC) || (flashSettings.FWPresent != 1))
      return;

   //SFW_INF("AllChanged");

   SFW_CalculFilterRange(pGCRegs, ALL_CHANGED);
   SFW_CalculExposureTimeMax(pGCRegs);

   SFW_GreatestFWExposureTime_i = SFW_GetMaxExposureTime(pGCRegs);
   SFW_lastGreatestFWExposureTime_i = SFW_GreatestFWExposureTime_i;

   SFW_CalculAcquisitionFrameRateMax(pGCRegs);
   }

/*
 * Update the maximal values that can be set in GenICam registers when the exposure time has changed.
 */
void SFW_ExposureTimeChanged(gcRegistersData_t *pGCRegs)
   {
   if((flashSettings.FWType != FW_SYNC) || (flashSettings.FWPresent != 1) || (pGCRegs->FWMode != FWM_SynchronouslyRotating))
      return;

   //SFW_INF("ExposureTimeChanged");

   SFW_GreatestFWExposureTime_i = SFW_GetMaxExposureTime(pGCRegs);

   if(SFW_GreatestFWExposureTime_i==SFW_lastGreatestFWExposureTime_i)
      return;

   SFW_lastGreatestFWExposureTime_i = SFW_GreatestFWExposureTime_i;
   SFW_CalculAcquisitionFrameRateMax(pGCRegs);
}

/*
 * Update the maximal values that can be set in GenICam registers when the acquisition frame rate has changed.
 */
void SFW_FrameRateChanged(gcRegistersData_t *pGCRegs)
{
   if((flashSettings.FWType != FW_SYNC) || (flashSettings.FWPresent != 1) || (pGCRegs->FWMode != FWM_SynchronouslyRotating))
      return;

   //SFW_INF("FrameRateChanged");
   SFW_CalculExposureTimeMax(pGCRegs);

   }

/*
 * Find the angle needed for a defined beam corner to intersect with the filter edge
 * A centered window in the FPA is assumed
 */ 

void BeamIntersect(float dX, float dY, float cornerPixelPositionRadius, float* maxTheta1, float* maxTheta2)
{
   float A, B, T;

   // First corner
   A = -(SFW_Ox + dX);
   B = -(SFW_Oy + dY);
   T = (SFW_FiltersRadius*SFW_FiltersRadius + A*A + B*B - cornerPixelPositionRadius*cornerPixelPositionRadius) / (2.0f*SFW_FiltersRadius);
   *maxTheta1 = asinf(-T/sqrtf(A*A + B*B)) - atan2f(A,B);
   if (*maxTheta1 > 0)
      *maxTheta1 -= (2.0f * (float)M_PI);

   // Second corner
   A = (SFW_Ox - dX);
   B = (SFW_Oy - dY);
   T = (SFW_FiltersRadius*SFW_FiltersRadius + A*A + B*B - cornerPixelPositionRadius*cornerPixelPositionRadius) / (2.0f*SFW_FiltersRadius);
   *maxTheta2 = asinf(T/sqrtf(A*A + B*B)) - atan2f(A,B);
   if (*maxTheta2 > 0)
      *maxTheta2 -= (2.0f * (float)M_PI);

}


/*
 * Calculate dX and dY by doing an linear interpolation between 0 and maximal pixels
 * Calculate the new cornerPixelPositionRadius :
 *    substract clearance radius with the linear interpolation between center pixel radius and corner pixel radius for the given window size
 */ 

void ConvertSizeToDeltaAndTarget(uint16_t width, uint16_t height, SFW_ChangedParameterEnum changedParameter, float* dX, float* dY, float* cornerPixelPositionRadius)
{
   if(changedParameter != HEIGHT_CHANGED) {
      //On veut max en fonction de la résolution native
      *dX = (float)width / FPA_WIDTH_MAX * flashSettings.FWCornerPixDistX;
   }

   if(changedParameter != WIDTH_CHANGED) {
      //On veut max en fonction de la résolution native
      *dY = (float)height / FPA_HEIGHT_MAX * flashSettings.FWCornerPixDistY;
  }


   *cornerPixelPositionRadius = SFW_ClearanceRadius - (sqrtf((float)(width*width + height*height))*SFW_PixelRadius_To_RealRadius+flashSettings.FWCornerPixRadius);
}

float SFW_GetMaxExposureTime(gcRegistersData_t *pGCRegs)
{

   float maxValue = 0.0f;
   uint8_t i;
   // uint8_t j;

   if(pGCRegs->FWMode == FWM_Fixed)
   {
      maxValue = pGCRegs->ExposureTime;
   }
   else // if ROTATING
   {
      for(i=0; i<flashSettings.FWNumberOfFilters; i++)
      {
         maxValue = MAX(maxValue, FWExposureTime[i]);
      }
   }
   return maxValue;
}

void SFW_LimitExposureTime(gcRegistersData_t * pGCRegs)
{
   uint32_t i; // Filter index

      for(i=0; i<NUM_OF(FWExposureTime); i++)
   {
            if(FWExposureTime[i] > pGCRegs->ExposureTimeMax)
      {
               SFW_INF("UPDATE EXPOSURE TIME: (%d) before(x100) = %d ",i, (uint32_t) FWExposureTime[i] * 100);
               FWExposureTime[i] = pGCRegs->ExposureTimeMax;
               SFW_SetExposureTimeArray(i, FWExposureTime[i]);
               SFW_INF(" After(x100) = %d \n",(uint32_t) FWExposureTime[i] *100);
         }
      }
      GC_UpdateExposureTimeXRegisters(FWExposureTime, NUM_OF(FWExposureTime), true);
               }

