/**
 * @file Timer.c
 * Timer module implementation.
 *
 * This file implements the interface used to manage 64-bit timer.
 * This module use XTmrCtr library and is based on xtmrctr_polled_example.c.
 *
 * $Rev: 16700 $
 * $Author: ssavary $
 * $Date: 2015-08-27 11:52:24 -0400 (Thu, 27 Aug 2015) $
 * $Id: Timer.c 16700 2015-08-27 15:52:24Z ssavary $
 * $URL: http://einstein/svn/firmware/FIR-00251-Common/trunk/Software/Timer.c $
 * 1.00x dha   04/06/18 ***Heavily modified to compile independant of firmware.***
 *
 * (c) Copyright 2014 Telops Inc.
 */

#define XTC_CSR_CASC_MASK		0x00000800 /**< Cascade Mode */
#define XTC_CSR_AUTO_RELOAD_MASK	0x00000010 /**< In compare mode,
 configures
 the timer counter to
 reload  from the
 Load Register. The
 default  mode
 causes the timer counter
 to hold when the compare
 value is hit. In capture
 mode, configures  the
 timer counter to not
 hold the previous
 capture value if a new
 event occurs. The
 default mode cause the
 timer counter to hold
 the capture value until
 recognized. */
#define XTC_CSR_LOAD_MASK		0x00000020 /**< Loads the timer using
 the load value provided
 earlier in the Load
 Register,
 XTC_TLR_OFFSET. */
#define XTC_CSR_ENABLE_TMR_MASK		0x00000080 /**< Enables only the
 specific timer */

#include <stdio.h>      /* printf */
#include <time.h>       /* clock_t, clock, CLOCKS_PER_SEC */
#include <math.h>       /* sqrt */

#include "Timer.h"
#include "utils.h"
#include "printf_utils.h"

uint32_t timerBaseAddress = 0;   /**< AXI Timer base address */
uint32_t timerClockFreq = 0;     /**< AXI Timer clock frequency */
timerData_t  *timer = NULL;


/**
 * Initializes AXI timer IP registers.
 * The timer is initialized in cascaded mode in order to obtain a 64-bit timer.
 * The period of such a timer @100MHz is more than 5845 years before wrap.
 *
 * @param baseAddress is the register base address of the AXI timer IP.
 * @param clockFreq is the timer clock frequency or the ticks count per second.
 *
 * @return IRC_SUCCESS, always.
 */
IRC_Status_t Timer_Init(uint32_t baseAddress, uint32_t clockFreq)
{
	//not tested, just placeholder
	//if (timer != NULL)
	//{
	//	free(timer);
	//	timer = NULL;
	//}
	//timer = (timerData_t*)malloc(sizeof(timerData_t*));

	//timer->timer = 0;
	//timer->timeout  = 0; // [us]
	//timer->enabled = false;

   return IRC_SUCCESS;
}

/**
 * Returns the actual value of the timer counter.
 *
 * @param time is a pointer to the time value to update.
 */
void Timer_GetTime(volatile uint64_t *time)
{
	//not tested, just placeholder
	//timer->timer = (uint64_t)clock(); // [us]
	//time = timer->timer;
}

/**
 * Returns timer clock frequency or the ticks count per second.
 *
 * @return timer clock frequency or the ticks count per second.
 */
uint32_t Timer_GetCountsPerSecond()
{
   return timerClockFreq;
}

void Timer_Test(uint32_t duration)
{
	//not tested, just placeholder
//	uint64_t tStart, tEnd, tCur;
//   uint32_t i;
//   for (i = 0; i < duration; ++i)
//   {
//      Timer_GetTime(&tStart);
//      tEnd  = tStart + (uint64_t) Timer_GetCountsPerSecond();
//      do
//      {
//         Timer_GetTime(&tCur);
//      } while (tCur < tEnd);
//
//#ifdef ENABLE_PRINTF
//      uint32_t *p_tStart32 = (uint32_t*) &tStart;
//      uint32_t *p_tEnd32 = (uint32_t*) &tCur;
//      PRINTF("Timer(%d): Start = 0x%08X%08X, End = 0x%08X%08X\n", i + 1, p_tStart32[1], p_tStart32[0], p_tEnd32[1], p_tEnd32[0]);
//#endif
//   }
}

void RestartTimer(timerData_t* timer)
{
	//not tested, just placeholder
	//GETTIME(&timer->timer);
 //  timer->enabled = true;
}

void StartTimer(timerData_t* timer, float timeout_ms)
{
	//not tested, just placeholder
	//timer->timeout = (uint64_t)timeout_ms * 1000;
 //  GETTIME(&timer->timer);
 //  timer->enabled = true;
}

void StopTimer(timerData_t* timer)
{
	//not tested, just placeholder
	//timer->enabled = false;
}

bool TimedOut(timerData_t* timer)
{
	//not tested, just placeholder
	//if (!timer->enabled)
 //     return false;

   //return elapsed_time_us(timer->timer) >= timer->timeout;
   return true;
}
