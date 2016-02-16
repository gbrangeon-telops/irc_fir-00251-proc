/**
 * @file gating.c
 * IR camera gating driver.
 */
 
#include "gating.h"
#include "utils.h"
#include "IRC_status.h"
#include "GenICam.h"
#include "mb_axi4l_bridge.h"

IRC_Status_t GATING_Init(t_GatingCfg *a)
{

   WriteStruct(a);

   GATING_PRINTF("Init\n\r");
   return IRC_SUCCESS;

}

void GATING_SendConfigGC(t_GatingCfg *a, const gcRegistersData_t *pGCRegs)
{
   if ((TriggerModeAry[TS_Gating] == TM_On) &&
         (TriggerModeAry[TS_Flagging] == TM_Off) &&
         (TriggerModeAry[TS_AcquisitionStart] == TM_Off) &&
         (pGCRegs->FWMode != FWM_SynchronouslyRotating))
   {
      a->Mode = (TriggerActivationAry[TS_Gating] + 1);
      a->Delay = (uint32_t)(TriggerDelayAry[TS_Gating]*1.0e-6F * (float)GATING_BASE_CLOCK_FREQ_HZ);
      a->FrameCount = TriggerFrameCountAry[TS_Gating];

      if (TriggerSourceAry[TS_Gating] == TS_ExternalSignal)
      {
         a->TrigSource = GATING_SOURCE_EXTERNAL;
      }
      else
      {
         a->TrigSource = GATING_SOURCE_SOFTWARE;
      }
   }
   else
   {
      a->Mode = GATING_MODE_DISABLE;
      a->Delay = 0;
      a->FrameCount = 0;
      a->TrigSource = GATING_SOURCE_EXTERNAL;
   }

   WriteStruct(a);

   GATING_PRINTF("Config sent\n");

}

void GATING_SendTrig(t_GatingCfg *a)
{
   AXI4L_write32(1, a->ADD + GATING_ADDR_SOFTTRIG);

   GATING_PRINTF("Trig sent\n");
}
