/*
 * ProcStartupTest_ADC.c
 *
 *  Created on: 2017-11-28
 *      Author: ecloutier
 */
#include "ProcStartupTest_ADC.h"
#include "adc_readout.h"
#include "tel2000_param.h"
#include "mb_axi4l_bridge.h"
#include "utils.h"

extern uint32_t N_ADC_BITS;
/*
 * perform a test of the ADC(AD7980) readings for +5V and -5V
 *
 * @return IRC_SUCCESS if the adc perform within acceptable parameters (+-20% of experimental values)

 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t AutoTest_ADCReadout(void)
{
   // experimental values
   int16_t POS_5V_MAX_VAL = 18500;
   int16_t POS_5V_MIN_VAL = 14000;
   int16_t NEG_5V_MAX_VAL = -13800;
   int16_t NEG_5V_MIN_VAL = -18300;

   if(N_ADC_BITS == 12)       // those values haven't been tested
   {
      POS_5V_MAX_VAL = (POS_5V_MAX_VAL >> 1);
      POS_5V_MIN_VAL = (POS_5V_MIN_VAL >> 1);
      NEG_5V_MAX_VAL = (NEG_5V_MAX_VAL >> 1);
      NEG_5V_MIN_VAL = (NEG_5V_MIN_VAL >> 1);
   }

   int16_t test = 0;

   ATR_PRINTF("Connect a +5V source to the connector J15.\nPress ENTER to continue...\n");
   AutoTest_getUserNULL();

   test = AXI4L_read32(ADC_BASE_ADDR + ADC_DATA_OUT);

   if(!(test > POS_5V_MIN_VAL && test < POS_5V_MAX_VAL))
   {
      ATR_ERR("Voltage value is not within acceptable parameters");
      return IRC_FAILURE;
   }

   ATR_PRINTF("Connect a -5V source to the connector J15.\nPress ENTER to continue...\n");
   AutoTest_getUserNULL();

   test = (int16_t)(AXI4L_read32(ADC_BASE_ADDR + ADC_DATA_OUT));

   if(!(test > NEG_5V_MIN_VAL && test < NEG_5V_MAX_VAL))
   {
      ATR_ERR("Voltage value is not within acceptable parameters");
      return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}
