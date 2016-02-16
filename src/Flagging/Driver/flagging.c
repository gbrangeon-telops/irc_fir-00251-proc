/**
 * @file flagging.c
 * IR camera flagging driver.
 */
 
#include "flagging.h"
#include "utils.h"
#include "IRC_status.h"
#include "GenICam.h"
#include "mb_axi4l_bridge.h"

IRC_Status_t FLAG_Init(t_FlagCfg *a)
{

   WriteStruct(a);

   FLAGGING_PRINTF("Init\n\r");
   return IRC_SUCCESS;

}

void FLAG_SendConfigGC(t_FlagCfg *a, const gcRegistersData_t *pGCRegs)
{
   if ((TriggerModeAry[TS_Flagging] == TM_On) && (TriggerModeAry[TS_Gating] == TM_Off))
   {
      a->Mode = (TriggerActivationAry[TS_Flagging] + 1);
      a->Delay = (uint32_t)(TriggerDelayAry[TS_Flagging]*1.0e-6F * (float)FLAG_BASE_CLOCK_FREQ_HZ);
      a->FrameCount = TriggerFrameCountAry[TS_Flagging];

      if (TriggerSourceAry[TS_Flagging] == TS_ExternalSignal)
      {
         a->TrigSource = FLAGSOURCE_EXTERNAL;
      }
      else
      {
         a->TrigSource = FLAGSOURCE_SOFTWARE;
      }
   }
   else
   {
      a->Mode = FLAGMODE_DISABLE;
      a->Delay = 0;
      a->FrameCount = 0;
      a->TrigSource = FLAGSOURCE_EXTERNAL;
   }

   WriteStruct(a);

   FLAGGING_PRINTF("Config sent\n");

}

void FLAG_SendTrig(t_FlagCfg *a)
{
   AXI4L_write32(1, a->ADD + FLAGADDR_SOFTTRIG);

   FLAGGING_PRINTF("Trig sent\n");
}
