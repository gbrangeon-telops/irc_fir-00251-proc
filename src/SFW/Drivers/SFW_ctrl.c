#include "SFW_ctrl.h"
#include "xparameters.h"
#include "tel2000_param.h"
#include "irc_status.h"
#include "utils.h"
#include "GC_Registers.h"
#include "mb_axi4l_bridge.h"
#include "fpa_intf.h"
#include "FlashSettings.h"
#include "FWController.h"
#include "exposure_time_ctrl.h"

#define SFW_BASE_CLOCK_FREQ_HZ   CLK_MB_FREQ_HZ  // horloge de reference de la SFW
#define FILTER_DEFAULT_RANGE     125

#define FIXED_WHEEL     0
#define ROTATING_WHEEL  1
#define NOT_IMPLEMENTED 2

/*
* Global variables
*/
uint16_t gSFW_deltaFilterEnd = 0;
uint16_t gSFW_deltaFilterBegin = 0;
uint16_t gSFW_precisionFactor;
/*
* Extern variables
*/
extern t_SfwCtrl gSFW_Ctrl;
extern float FWExposureTime[MAX_NUM_FILTER];
extern uint8_t FPA_StretchAcqTrig;

IRC_Status_t SFW_CTRL_Init(gcRegistersData_t *pGCRegs, t_SfwCtrl *pSFWCtrl)
{
   uint8_t i;
   uint16_t pos;
   uint32_t val;
   uint32_t clock_to_rpm_factor;
   int32_t counts = 0;

   pGCRegs->FWSpeedSetpoint = (uint16_t)roundf(pGCRegs->AcquisitionFrameRate*60.0f/flashSettings.FWNumberOfFilters);

   AXI4L_write32( 0, pSFWCtrl->ADD + VALID_PARAM_ADDR);

   AXI4L_write32( 0, pSFWCtrl->ADD + CLEAR_ERR_ADDR);

   AXI4L_write32( FIXED_WHEEL, pSFWCtrl->ADD + WHEEL_STATE_ADDR);

   AXI4L_write32( 0, pSFWCtrl->ADD + POSITIONSETPOINT_ADDR);

   AXI4L_write32( flashSettings.FWEncoderCyclePerTurn, pSFWCtrl->ADD + NB_ENCODER_CNT_Addr);

   // This calcul is done in the PPC to save a division (or multiplication) in the FPGA
   clock_to_rpm_factor = (uint32_t)( (SFW_BASE_CLOCK_FREQ_HZ * 60.0f/ ( (float) flashSettings.FWEncoderCyclePerTurn))+0.5f);
   AXI4L_write32(clock_to_rpm_factor, pSFWCtrl->ADD + RPM_FACTOR_ADDR);

   AXI4L_write32( (uint32_t)flashSettings.FWSpeedMax + SFW_MAX_SPEED_MARGIN, pSFWCtrl->ADD + RPM_MAX_ADDR);

   gSFW_precisionFactor = (uint16_t)AXI4L_read32(pSFWCtrl->ADD  + SPEED_PRECISION_BIT_ADDR);

   //Write to hardware the position of the filter
   for(i=0; i<8; i++)
   {
      FW_getFilterPosition(i, &counts);

      pos = (uint16_t)counts + FILTER_DEFAULT_RANGE;
      if(pos >= flashSettings.FWEncoderCyclePerTurn)
      {
         pos -= flashSettings.FWEncoderCyclePerTurn;
      }

      val = (uint32_t)pos << 16;

      pos = (uint16_t)counts - FILTER_DEFAULT_RANGE;
      if(pos >= flashSettings.FWEncoderCyclePerTurn)
      {
         pos += flashSettings.FWEncoderCyclePerTurn;
      }
      val += (uint32_t)pos;

      AXI4L_write32(val, pSFWCtrl->ADD  + FW_POSITION_0_ADDR + 4 * i);
   }

   //Send to the hardware the mode of the wheel if present
   if(flashSettings.FWPresent == 1 && flashSettings.FWType == FW_SYNC)
   {
      FPA_StretchAcqTrig = 0;

      if (pGCRegs->FWMode == FWM_Fixed)
         AXI4L_write32(FIXED_WHEEL, pSFWCtrl->ADD  + WHEEL_STATE_ADDR);
      else
      {
         AXI4L_write32(ROTATING_WHEEL, pSFWCtrl->ADD  + WHEEL_STATE_ADDR);
         FPA_StretchAcqTrig = 1;
      }
   }
   else
   {
      AXI4L_write32(NOT_IMPLEMENTED,  pSFWCtrl->ADD  + WHEEL_STATE_ADDR);
   }

   //Set exposure time arrays to default value
   for(i=0; i<NUM_OF(FWExposureTime); i++)
   {
      SFW_SetExposureTimeArray(i,FWExposureTime[i]);
   }

   //Set the Homing index method (Encoder or Optoswitch)
   AXI4L_write32( flashSettings.SFWOptoswitchPresent , pSFWCtrl->ADD + INDEX_MODE_ADDR);

   //Set config valid
   AXI4L_write32( 1 , pSFWCtrl->ADD + VALID_PARAM_ADDR);

	return IRC_SUCCESS;

}

//IRC_Status_t SFW_CTRL_Reset(t_SfwCtrl *pSFWCtrl)
//{
//   return IRC_SUCCESS;
//}

void SFW_UpdateFilterRanges(float deltaTheta1, float deltaTheta2)
{
   uint8_t i;
   uint16_t pos;
   uint32_t val = 0;
   int32_t counts = 0;

   SFW_INF("deltaTheta1*1000 = %d, deltaTheta2*1000 = %d",(int32_t)(deltaTheta1*1000),(int32_t)(deltaTheta2*1000));

   gSFW_deltaFilterEnd = (uint16_t)floorf(deltaTheta1 * (float)flashSettings.FWEncoderCyclePerTurn / (2.0f * (float)M_PI));
   gSFW_deltaFilterBegin = (uint16_t)floorf(deltaTheta2 * (float)flashSettings.FWEncoderCyclePerTurn / (2.0f * (float)M_PI));

   SFW_INF("Sending filter min and max through AxiLite\n");
   SFW_INF("deltaFilterEnd = %d\n",gSFW_deltaFilterEnd);
   SFW_INF("deltaFilterBegin = %d\n",gSFW_deltaFilterBegin);

   for(i=0; i<flashSettings.FWNumberOfFilters; i++)
   {
      FW_getFilterPosition(i, &counts);

      pos = (uint16_t)counts + gSFW_deltaFilterEnd;

      if(pos >= flashSettings.FWEncoderCyclePerTurn)   //Verify if pos exceeds encoder values
         pos -= flashSettings.FWEncoderCyclePerTurn; // if so, wrap the value

      val = (uint32_t)pos << 16;
      SFW_INF("SFW_UpdateFilterRanges Filter[%d] -- Max Pos=%d",i, pos);

      pos = (uint16_t)counts - gSFW_deltaFilterBegin;

      if(pos >= flashSettings.FWEncoderCyclePerTurn)   //Verify if pos exceeds encoder values
         pos += flashSettings.FWEncoderCyclePerTurn; // if so, wrap the value
      val |= (uint32_t)pos;
      SFW_INF("SFW_UpdateFilterRanges Filter[%d] -- Min Pos=%d",i, pos);

      AXI4L_write32(val, gSFW_Ctrl.ADD + FW_POSITION_0_ADDR + 4 * i);
   }

}

/*
 * Name         : SFW_GetEncoderPosition
 *
 * Synopsis     : uint16_t SFW_GetEncoderPosition()
 *
 * Description  : Return the encoder position
 *
 * Returns      : uint16_t : 0 to 4095
 */
uint16_t SFW_GetEncoderPosition()
{
   return (uint16_t) AXI4L_read32(gSFW_Ctrl.ADD  + POSITION_ADDR);
}

void SFW_SetExposureTimeArray(uint8_t ExpId, float Exptime)
{
   #ifdef SCD_PROXY
      extern uint8_t gFrameRateChangePostponed;
      if (!gFrameRateChangePostponed) // We need to delay the ET update to prevent invalid proxy config.
   #endif
         AXI4L_write32( (uint32_t) (Exptime * EXPOSURE_TIME_FACTOR) , gSFW_Ctrl.ADD + FW_EXPOSURETIME_OFFSET + 4 * ExpId);
}

void SFW_Disable()
{
   AXI4L_write32(  0, gSFW_Ctrl.ADD + VALID_PARAM_ADDR);
   //AXI4L_write32( 0, gSFW_Ctrl.ADD + CLEAR_ERR_ADDR);
}

void SFW_Enable()
{
   AXI4L_write32(  1, gSFW_Ctrl.ADD + VALID_PARAM_ADDR);
}

uint32_t SFW_Get_RPM()
{
   uint32_t rpm;

   rpm =(uint32_t) ((float)((uint32_t) AXI4L_read32(gSFW_Ctrl.ADD + RPM_ADDR)) / (float)gSFW_precisionFactor);

   return rpm;
}

void SFW_UpdateSFWMode(FWMode_t Mode)
{
   FPA_StretchAcqTrig = 0;
   
   if(flashSettings.FWPresent == 1 && flashSettings.FWType == FW_SYNC)
   {
      //Clear valid Param to change the wheel mode
      SFW_Disable();
      AXI4L_write32( 0, gSFW_Ctrl.ADD + CLEAR_ERR_ADDR);
     
      switch(Mode)
      {
         case FWM_Fixed:
            AXI4L_write32( FIXED_WHEEL, gSFW_Ctrl.ADD + WHEEL_STATE_ADDR);
            break;
         case FWM_AsynchronouslyRotating:
         case FWM_SynchronouslyRotating:
            AXI4L_write32( ROTATING_WHEEL, gSFW_Ctrl.ADD + WHEEL_STATE_ADDR);
	         FPA_StretchAcqTrig = 1;
            break;
         default: // SHould not happen...
            AXI4L_write32( NOT_IMPLEMENTED, gSFW_Ctrl.ADD + WHEEL_STATE_ADDR);
            break;
      }

      SFW_Enable();
   }
}


void SFW_DisplayReadRegister()
{
#ifdef SFW_VERBOSE
   uint32_t reg[5];

   reg[0] = AXI4L_read32(gSFW_Ctrl.ADD + HOME_LOCK_ADDR);
   reg[1] = AXI4L_read32(gSFW_Ctrl.ADD + POSITION_ADDR);
   reg[2] = AXI4L_read32(gSFW_Ctrl.ADD + RPM_ADDR);
   reg[3] = AXI4L_read32(gSFW_Ctrl.ADD + ERROR_SPEED_ADDR);
   reg[4] = AXI4L_read32(gSFW_Ctrl.ADD + SPEED_PRECISION_BIT_ADDR);

   SFW_INF("Home_Lock : %d",reg[0]);
   SFW_INF("Position : %d",reg[1]);
   SFW_INF("RPM : %d",reg[2]);
   SFW_INF("ErrorSpeed : %d",reg[3]);
   SFW_INF("Speed Precision : %d",reg[4]);
#endif
}

void SFW_GetCurrentFilterRange(int32_t CurrentFilterPos, uint32_t * pFilterStart, uint32_t * pFilterEnd)
{

   *pFilterStart = CurrentFilterPos - gSFW_deltaFilterBegin;

   if (*pFilterStart > flashSettings.FWEncoderCyclePerTurn)
   {
      *pFilterStart += flashSettings.FWEncoderCyclePerTurn;
   }

   *pFilterEnd = CurrentFilterPos + gSFW_deltaFilterEnd;

   if (*pFilterEnd > flashSettings.FWEncoderCyclePerTurn)
   {
      *pFilterEnd -= flashSettings.FWEncoderCyclePerTurn;
   }
}
