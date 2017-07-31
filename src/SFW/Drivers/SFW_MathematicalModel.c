
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
static uint16_t MaxWindowSizeX(float dX, float dY, float cornerPixelPositionRadius, float usedTheta1, float usedTheta2);
static uint16_t MaxWindowSizeY(float dX, float dY, float cornerPixelPositionRadius, float usedTheta1, float usedTheta2);
static void SplitUsedTheta(float maxTheta1, float maxTheta2, float* usedTheta1, float* usedTheta2);
static void ConvertSizeToDeltaAndTarget(uint16_t width, uint16_t height, SFW_ChangedParameterEnum changedParameter, float* dX, float* dY, float* cornerPixelPositionRadius, float* cornerPixelPositionRadiusWithoutMarging);

extern flashSettings_t flashSettings;
extern float FWExposureTime[MAX_NUM_FILTER];


float SFW_AcquisitionFrameRateMax;
float SFW_ExposureTimeMax;
uint16_t SFW_CurrentWidthMax;
uint16_t SFW_CurrentHeightMax;

static float SFW_FiltersRadius;
static float SFW_OpticalAxisTheta;
static float SFW_ClearanceRadius;
static float SFW_Ox;
static float SFW_Oy;
static float SFW_PixelRadius_To_RealRadius;
static float SFW_CurrentParameters_MaxTheta1;
static float SFW_CurrentParameters_MaxTheta2;
static float SFW_CurrentParameters_Target;
static float SFW_CurrentParameters_TargetPhysMarging;
static float SFW_CurrentParameters_UsedTheta;
static float SFW_RPM_uSec_Max;
static float SFW_dX;
static float SFW_dY;
static float SFW_maxExposureTime;
static float SFW_lastMaxExposureTime;

//static uint16_t SFW_DeltaFilterBegin;
//static uint16_t SFW_DeltaFilterEnd;

uint16_t SFW_GetCurrentWidthMax(){return SFW_CurrentWidthMax;};
uint16_t SFW_GetCurrentHeightMax(){return SFW_CurrentHeightMax;};
//uint16_t SFW_GetDeltaFilterBegin(){return SFW_DeltaFilterBegin;};
//uint16_t SFW_GetDeltaFilterEnd(){return SFW_DeltaFilterEnd;};



/*
 * Calculate the values of various parameters
 * These will not change because they are only dependant of EEPROM values
 * They are precalculated to speed up the algorithms
 */
void InitMathematicalModel(gcRegistersData_t *pGCRegs)
{
   SFW_INF("InitMathematicalModel");
   
   SFW_FiltersRadius = sqrt(flashSettings.FWOpticalAxisPosX*flashSettings.FWOpticalAxisPosX + flashSettings.FWOpticalAxisPosY*flashSettings.FWOpticalAxisPosY );
   SFW_INF("SFW_FiltersRadius *1000 = %d",(int32_t)(SFW_FiltersRadius*1000));

   SFW_OpticalAxisTheta = atan2(flashSettings.FWOpticalAxisPosY, flashSettings.FWOpticalAxisPosX);
   SFW_INF("SFW_OpticalAxisTheta *1000 = %d",(int32_t)(SFW_OpticalAxisTheta*1000));
   
   SFW_Ox = SFW_FiltersRadius*cos(SFW_OpticalAxisTheta);
   SFW_Oy = SFW_FiltersRadius*sin(SFW_OpticalAxisTheta);
   SFW_INF("SFW_Ox *1000 = %d",(int32_t)(SFW_Ox*1000));
   SFW_INF("SFW_Oy *1000 = %d",(int32_t)(SFW_Oy*1000));
   
   SFW_ClearanceRadius = flashSettings.FWMountingHoleRadius - flashSettings.FWBeamMarging;
   SFW_INF("SFW_ClearanceRadius *1000 = %d",(int32_t)(SFW_ClearanceRadius*1000));
   
   SFW_PixelRadius_To_RealRadius = (flashSettings.FWCenterPixRadius-flashSettings.FWCornerPixRadius)/sqrt((float)(FPA_WIDTH_MAX*FPA_WIDTH_MAX + FPA_HEIGHT_MAX*FPA_HEIGHT_MAX));
   SFW_INF("SFW_PixelRadius_To_RealRadius *1000 = %d",(int32_t)(SFW_PixelRadius_To_RealRadius*1000));
   
   // Calculate new maximal values considering that all parameters has been changed
   // Need to be called at least once to set all global variables

   SFW_CalculateMaximalValues(pGCRegs, ALL_CHANGED);

      if(pGCRegs->FWSpeedSetpoint != 0)
         SFW_ExposureTimeMax = floorf(SFW_RPM_uSec_Max / pGCRegs->FWSpeedSetpoint);
      else
         SFW_ExposureTimeMax = pGCRegs->ExposureTimeMax;



}

float SFW_GetAcquisitionFrameRateMax()
{
   return SFW_AcquisitionFrameRateMax;
}

float SFW_GetExposureTimeMax()
{
   return SFW_ExposureTimeMax;
}

/*
 * Calculate the maximal values that can be set in GenICam registers :
 * Width, Height, ExposureTime and AcquisitionFrameRate
 *
 * changedParameter must indicate which register has changed since the last callback of this function
 */

void SFW_CalculateMaximalValues(gcRegistersData_t *pGCRegs, SFW_ChangedParameterEnum changedParameter)
{
   float usedTheta1, usedTheta2;
   float maxTheta1, maxTheta2;
   uint16_t tempWidthMax = 0;
   uint16_t tempHeightMax = 0;
   float temp_dX, temp_dY;
   float tempCornerPixelPositionRadius;

   if(flashSettings.FWType != FW_SYNC || flashSettings.FWPresent != 1)
      return;

   SFW_INF("CalculateMaximalValues");

   // If the window size changed, recalculate the max angles
   if(changedParameter == WIDTH_CHANGED || changedParameter == HEIGHT_CHANGED || changedParameter == ALL_CHANGED)
   {
      ConvertSizeToDeltaAndTarget(pGCRegs->Width, pGCRegs->Height, changedParameter, &SFW_dX, &SFW_dY, &SFW_CurrentParameters_Target, &SFW_CurrentParameters_TargetPhysMarging);
      SFW_INF("Width = %d, Height = %d, SFW_dX = %d, SFW_dY=%d, SFW_CurrentParameters_Target=%d\n",pGCRegs->Width,pGCRegs->Height,(int32_t)(SFW_dX*1000.0f) ,(int32_t)(SFW_dY*1000.0f),(int32_t)(SFW_CurrentParameters_Target*1000.0f));

	  //Calculate the beam intersect without the Physical marging to get the good encoder count
      BeamIntersect(SFW_dX, SFW_dY, SFW_CurrentParameters_TargetPhysMarging, &SFW_CurrentParameters_MaxTheta1, &SFW_CurrentParameters_MaxTheta2);
      SFW_UpdateFilterRanges(SFW_CurrentParameters_MaxTheta1-SFW_OpticalAxisTheta, SFW_OpticalAxisTheta-SFW_CurrentParameters_MaxTheta2);

	  //Calculate the beam intersect with the Physical marging to get the parameter limit (exposure and frame rate)
	  BeamIntersect(SFW_dX, SFW_dY, SFW_CurrentParameters_Target, &SFW_CurrentParameters_MaxTheta1, &SFW_CurrentParameters_MaxTheta2);
      SFW_RPM_uSec_Max = (SFW_CurrentParameters_MaxTheta1 - SFW_CurrentParameters_MaxTheta2) * 60.0f / 2.0f / M_PI / 0.000001f  * SFW_EXPOSUREMAX_MARGING;
      //SFW_INF("MaxTheta1 = %d, MaxTheta2 = %d, SFW_RPM_uSec_Max = %d\n",(int32_t) (SFW_CurrentParameters_MaxTheta1 *1000.0f),(int32_t) (SFW_CurrentParameters_MaxTheta2 *1000.0f),(int32_t) (SFW_RPM_uSec_Max * 1e6f)  );
   }

   if ((pGCRegs->FWMode != FWM_SynchronouslyRotating) && (changedParameter != ALL_CHANGED))
      return;

   // If a parameter, other than the exposure time, changed, set the new maximum exposure time
   if(changedParameter != EXPOSURE_TIME_CHANGED)
   {
      float SFW_ExposureTimeMax_temp = SFW_ExposureTimeMax;

      if(pGCRegs->FWSpeedSetpoint != 0)
         SFW_ExposureTimeMax = floorf(SFW_RPM_uSec_Max / pGCRegs->FWSpeedSetpoint); //Temps max ou le filtre est devant le detecteur
      else
         SFW_ExposureTimeMax = pGCRegs->ExposureTimeMax;

      SFW_ExposureTimeMax = MIN(SFW_ExposureTimeMax , FPA_MaxExposureTime(pGCRegs)); //Min entre Temps ou le filtre est devant et Temps du FPA qui tient compte du temps d'exposition+readout possible selon le framerate

      // if width or height changed, limit the acquisition frame rate only
      if (((changedParameter == WIDTH_CHANGED) || (changedParameter == HEIGHT_CHANGED)) && (SFW_ExposureTimeMax_temp > SFW_ExposureTimeMax) && (SFW_maxExposureTime > SFW_ExposureTimeMax))
      {
         SFW_ExposureTimeMax = SFW_ExposureTimeMax_temp;
      }

   }

   if(changedParameter == EXPOSURE_TIME_CHANGED || changedParameter == ALL_CHANGED)
   {
      SFW_maxExposureTime = SFW_GetMaxExposureTime(pGCRegs);

      // If an exposure time change but the maximum is the same, return
      // The max parameters are still valid
      if(SFW_maxExposureTime==SFW_lastMaxExposureTime && changedParameter == EXPOSURE_TIME_CHANGED)
         return;

      SFW_lastMaxExposureTime = SFW_maxExposureTime;
   }

   // If a parameter, other than the frame rate, changed, set the new maximum frame rate
    if(changedParameter != FRAME_RATE_CHANGED)
    {
      SFW_AcquisitionFrameRateMax = floorf(SFW_RPM_uSec_Max / SFW_maxExposureTime)*flashSettings.FWNumberOfFilters/60.0f;
      SFW_AcquisitionFrameRateMax = MIN(SFW_AcquisitionFrameRateMax, pGCRegs->FWSpeedMax*flashSettings.FWNumberOfFilters/60.0f);
      SFW_INF("SFW_AcquisitionFrameRateMax = %d\n", (uint32_t) (SFW_AcquisitionFrameRateMax * 10));
    }

   if(changedParameter == EXPOSURE_TIME_CHANGED || changedParameter == FRAME_RATE_CHANGED || changedParameter == ALL_CHANGED)
   {
      SFW_CurrentParameters_UsedTheta = pGCRegs->FWSpeedSetpoint / 60.0f * 2.0f * M_PI * SFW_maxExposureTime * 0.000001f;
   }

   SplitUsedTheta(SFW_CurrentParameters_MaxTheta1, SFW_CurrentParameters_MaxTheta2, &usedTheta1, &usedTheta2);

   // If only the width changed, no need to calculate the maximum width again
   if(changedParameter != WIDTH_CHANGED)
   {
      tempWidthMax = MaxWindowSizeX(SFW_dX, SFW_dY, SFW_CurrentParameters_Target, usedTheta1, usedTheta2);
   }

   // If only the height changed, no need to calculate the maximum height again
   if(changedParameter != HEIGHT_CHANGED)
   {
      tempHeightMax = MaxWindowSizeY(SFW_dX, SFW_dY, SFW_CurrentParameters_Target, usedTheta1, usedTheta2);
   }

   // Do the algo for the width an other time because the ratio of thetas isn't accurate
   if(changedParameter != WIDTH_CHANGED)
   {
      // Height is unchanged so keep using SFW_dY
      // Width is changed so recalculate dX and Target;
      ConvertSizeToDeltaAndTarget(tempWidthMax, pGCRegs->Height, WIDTH_CHANGED, &temp_dX, &temp_dY, &tempCornerPixelPositionRadius,&SFW_CurrentParameters_TargetPhysMarging);

      // Find maximal angles with the new width
      BeamIntersect(temp_dX, SFW_dY, tempCornerPixelPositionRadius, &maxTheta1, &maxTheta2);

      SplitUsedTheta(maxTheta1, maxTheta2, &usedTheta1, &usedTheta2);

      SFW_CurrentWidthMax = MaxWindowSizeX(temp_dX, SFW_dY, tempCornerPixelPositionRadius, usedTheta1, usedTheta2);

   }

   // Do the algo for the height an other time because the ratio of thetas isn't accurate
   if(changedParameter != HEIGHT_CHANGED)
   {
      // Width is unchanged so keep using SFW_dY
      // Height is changed so recalculate dY and Target;
      ConvertSizeToDeltaAndTarget(pGCRegs->Width, tempHeightMax, HEIGHT_CHANGED, &temp_dX, &temp_dY, &tempCornerPixelPositionRadius,&SFW_CurrentParameters_TargetPhysMarging);

      // Find maximal angles with the new height
      BeamIntersect(SFW_dX, temp_dY, tempCornerPixelPositionRadius, &maxTheta1, &maxTheta2);

      SplitUsedTheta(maxTheta1, maxTheta2, &usedTheta1, &usedTheta2);


      SFW_CurrentHeightMax = MaxWindowSizeY(SFW_dX, temp_dY, tempCornerPixelPositionRadius, usedTheta1, usedTheta2);

   }
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
   *maxTheta1 = asin(-T/sqrt(A*A + B*B)) - atan2(A,B);
   if (*maxTheta1 > 0)
      *maxTheta1 -= (2.0*M_PI);

   // Second corner
   A = (SFW_Ox - dX);
   B = (SFW_Oy - dY);
   T = (SFW_FiltersRadius*SFW_FiltersRadius + A*A + B*B - cornerPixelPositionRadius*cornerPixelPositionRadius) / (2.0f*SFW_FiltersRadius);
   *maxTheta2 = asin(T/sqrt(A*A + B*B)) - atan2(A,B);
   if (*maxTheta2 > 0)
      *maxTheta2 -= (2.0*M_PI);

}

/*
 * Calculate the maximal window width for these input parameters
 */

uint16_t MaxWindowSizeX(float dX, float dY, float cornerPixelPositionRadius, float usedTheta1, float usedTheta2)
{
   float dX_a, tempValue;
   uint16_t Xmax_1, Xmax_2;

   tempValue = SFW_FiltersRadius*sin(usedTheta1) - (SFW_Oy + dY);
   dX_a =   SFW_FiltersRadius*cos(usedTheta1) - SFW_Ox - sqrt(cornerPixelPositionRadius*cornerPixelPositionRadius - tempValue*tempValue);
   Xmax_1 = (uint16_t)floorf(dX_a/flashSettings.FWCornerPixDistX*FPA_WIDTH_MAX);

   tempValue = SFW_FiltersRadius*sin(usedTheta2) - (SFW_Oy - dY);
   dX_a =   -(SFW_FiltersRadius*cos(usedTheta2) - SFW_Ox + sqrt(cornerPixelPositionRadius*cornerPixelPositionRadius - tempValue*tempValue));
   Xmax_2 = (uint16_t)floorf(dX_a/flashSettings.FWCornerPixDistX*FPA_WIDTH_MAX);

   // return the minimal value between Xmax_1, Xmax_2 and FPA_WIDTH_MAX
   if(FPA_WIDTH_MAX < Xmax_1 && FPA_WIDTH_MAX < Xmax_2)
      return FPA_WIDTH_MAX;

   if(Xmax_1 < Xmax_2)
      return Xmax_1;
   else
      return Xmax_2;
}

/*
 * Calculate the maximal window height for these input parameters
 */

uint16_t MaxWindowSizeY(float dX, float dY, float cornerPixelPositionRadius, float usedTheta1, float usedTheta2)
{
   float dY_a, tempValue;
   uint16_t Ymax_1, Ymax_2;

   tempValue = SFW_FiltersRadius*cos(usedTheta1) - (SFW_Ox + dX);
   dY_a =   SFW_FiltersRadius*sin(usedTheta1) - SFW_Oy + sqrt(cornerPixelPositionRadius*cornerPixelPositionRadius - tempValue*tempValue);
   Ymax_1 = (uint16_t)floorf(dY_a/flashSettings.FWCornerPixDistY*FPA_HEIGHT_MAX);

   tempValue = SFW_FiltersRadius*cos(usedTheta2) - (SFW_Ox - dX);
   dY_a =   -(SFW_FiltersRadius*sin(usedTheta2) - SFW_Oy - sqrt(cornerPixelPositionRadius*cornerPixelPositionRadius - tempValue*tempValue));
   Ymax_2 = (uint16_t)floorf(dY_a/flashSettings.FWCornerPixDistY*FPA_HEIGHT_MAX);

   // return the minimal value between Ymax_1, Ymax_2 and FPA_HEIGHT_MAX
   if(FPA_HEIGHT_MAX < Ymax_1 && FPA_HEIGHT_MAX < Ymax_2)
      return FPA_HEIGHT_MAX;

   if(Ymax_1 < Ymax_2)
      return Ymax_1;
   else
      return Ymax_2;
}

/*
 * Convert usedTheta in 2 new angles with same proportions than the maximal angles
 * The exact proportion isn't known and the use of the current proportion is a good approximation
 * Nevertheless, 2 iterations of the algorithm for the maximal size is needed for a better accuracy
 */

void SplitUsedTheta(float maxTheta1, float maxTheta2, float* usedTheta1, float* usedTheta2)
{
   *usedTheta1 = (SFW_CurrentParameters_UsedTheta)/(maxTheta1-maxTheta2)*(maxTheta1-SFW_OpticalAxisTheta) + SFW_OpticalAxisTheta;
   *usedTheta2 = (SFW_CurrentParameters_UsedTheta)/(maxTheta1-maxTheta2)*(maxTheta2-SFW_OpticalAxisTheta) + SFW_OpticalAxisTheta;
}

/*
 * Calculate dX and dY by doing an linear interpolation between 0 and maximal pixels
 * Calculate the new cornerPixelPositionRadius :
 *    substract clearance radius with the linear interpolation between center pixel radius and corner pixel radius for the given window size
 */ 

void ConvertSizeToDeltaAndTarget(uint16_t width, uint16_t height, SFW_ChangedParameterEnum changedParameter, float* dX, float* dY, float* cornerPixelPositionRadius, float* cornerPixelPositionRadiusWithoutMarging)
{
   if(changedParameter != HEIGHT_CHANGED)
      *dX = (float)width / FPA_WIDTH_MAX * flashSettings.FWCornerPixDistX;

   if(changedParameter != WIDTH_CHANGED)
      *dY = (float)height / FPA_HEIGHT_MAX * flashSettings.FWCornerPixDistY;

   *cornerPixelPositionRadius = SFW_ClearanceRadius - (sqrt((float)(width*width + height*height))*SFW_PixelRadius_To_RealRadius+flashSettings.FWCornerPixRadius);
   *cornerPixelPositionRadiusWithoutMarging = (flashSettings.FWMountingHoleRadius - SFW_PhysicalMarging * flashSettings.FWBeamMarging) - (sqrt((float)(width*width + height*height))*SFW_PixelRadius_To_RealRadius+flashSettings.FWCornerPixRadius);
}

float SFW_GetMaxExposureTime(gcRegistersData_t *pGCRegs)
{

   float maxValue = 0.0f;
   uint8_t i;
   // uint8_t j;

   if(pGCRegs->FWMode == FWM_Fixed)
   {
      /*
      if(pGCRegs->EHDRINumberOfExposures > 1)
      {
         for(i=0; i<pGCRegs->EHDRINumberOfExposures; i++) // Max of the EHDRI values of 1 spectral filter
         {
            maxValue = MAX(GETEHDRIEXPOSURE(pGCRegs->SFWPositionSetpoint,i), maxValue);
         }
      }

      else
      {
         maxValue = GETEHDRIEXPOSURE(pGCRegs->SFWPositionSetpoint,0); // The value of the spactral filter
      }
      */
      maxValue = pGCRegs->ExposureTime;
   }
   else // if ROTATING
   {
//      if(pGCRegs->EHDRINumberOfExposures > 1)
//      {
//         for(i=0; i<SFW_FILTER_NB; i++) // Max of EHDRI values of all spectral filters
//            for(j=0; j<pGCRegs->EHDRINumberOfExposures; j++)
//               maxValue = MAX(GETEHDRIEXPOSURE(i,j), maxValue);
//      }
//      else
//      {
//         for(i=0; i<SFW_FILTER_NB; i++)
//            maxValue = MAX(GETEHDRIEXPOSURE(i,0), maxValue); // Max values of all spectral filters
//      }
      for(i=0; i<flashSettings.FWNumberOfFilters; i++)
      {
         maxValue = MAX(maxValue, FWExposureTime[i]);
      }
   }


   return maxValue;
}

void SFW_LimitParameter(gcRegistersData_t * pGCRegs)
{
   float acqFrMaxTemp;

   if(gcRegsData.FWMode == FWM_SynchronouslyRotating)
   {
      acqFrMaxTemp = MIN(pGCRegs->AcquisitionFrameRateMax, SFW_GetAcquisitionFrameRateMax());

      if( acqFrMaxTemp != pGCRegs->AcquisitionFrameRateMax)
      {
         pGCRegs->AcquisitionFrameRateMax = acqFrMaxTemp;

         if ( pGCRegs->AcquisitionFrameRate > pGCRegs->AcquisitionFrameRateMax && !TDCStatusTst(AcquisitionStartedMask)) // TODO le check empêche de changer live un parametre?
         {
            pGCRegs->AcquisitionFrameRate = pGCRegs->AcquisitionFrameRateMax;

            pGCRegs->FWSpeedSetpoint = (int16_t) floorf(pGCRegs->AcquisitionFrameRate*60.0f/flashSettings.FWNumberOfFilters);
            // limit speed to 1 RPM (minimum for the controller)
            pGCRegs->FWSpeedSetpoint = MIN(MAX(pGCRegs->FWSpeedSetpoint, 1),pGCRegs->FWSpeedMax);
            // Recalcul the corresponding frame rate
            pGCRegs->AcquisitionFrameRate = pGCRegs->FWSpeedSetpoint*flashSettings.FWNumberOfFilters/60.0f;
            ChangeFWControllerMode(FW_VELOCITY_MODE, pGCRegs->FWSpeedSetpoint);
         }
      }

      if(SFW_GetExposureTimeMax() != pGCRegs->ExposureTimeMax) // If the maximum exposure time value of a rotating wheel is different than the exposuretime max then
      {
         uint32_t sfw; //,hdri;
         pGCRegs->ExposureTimeMax = SFW_GetExposureTimeMax();
         for(sfw=0; sfw<NUM_OF(FWExposureTime); sfw++)
         {
               if(FWExposureTime[sfw]> pGCRegs->ExposureTimeMax)
               {
                  SFW_INF("UPDATE EXPOSURE TIME: (%d) before(x100) = %d ",sfw, (uint32_t) FWExposureTime[sfw] * 100);
                  FWExposureTime[sfw] = pGCRegs->ExposureTimeMax;
                  SFW_SetExposureTimeArray(sfw, FWExposureTime[sfw]);
                  SFW_INF(" After(x100) = %d \n",(uint32_t) FWExposureTime[sfw] *100);
               }
         }
         GC_UpdateExposureTimeXRegisters(FWExposureTime, NUM_OF(FWExposureTime));
      }
   }
}
