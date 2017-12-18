#include "adc_readout.h"
#include "tel2000_param.h"
#include "mb_axi4l_bridge.h"
#include "utils.h"
#include "HwRevision.h"

#include <stdlib.h>
#include <time.h>
#include <stdint.h>

extern brd_rev_ver_t gBrdRevid;

uint32_t N_ADC_BITS;

// fonction appelée au chargement des flash settings
IRC_Status_t ADC_readout_init(flashSettings_t* fs)
{
   IRC_Status_t status = IRC_FAILURE;
   int32_t ri, qi;
   float m, b, r, q;
   N_ADC_BITS = 16;
   uint32_t adcReadoutcgf = 1;

#ifdef STARTUP
   // nominal values
   m = 1.0;                // dynamic range on N_ADC_BITS : |0 to 10V(16 bits)|-10V to 0(16 bits)|
   b = 0.0f;               //                               |  0x0 to 0x7FFF  |  8000 to 0xFFFF  |
#else
   m = fs->ADCReadout_m;   // [counts/mV]
   b = fs->ADCReadout_b;   // [counts]
#endif
   
   if(gBrdRevid == BRD_REV_20x){
      adcReadoutcgf = ADC_AND_IRIG;
   }
   else if(gBrdRevid == BRD_REV_00x && fs->ADCReadoutEnabled)
   {
      adcReadoutcgf = ADC_READOUT;
      N_ADC_BITS = 12;
   }
   else
   {
      adcReadoutcgf = ADC_IRIG_ONLY;
   }


   r = 1.0f/m;
   q = b + (1<<(N_ADC_BITS-1)); // the input of the ADC is offset by Vref/2

   // convert to S15Q16
   ri = floatToFixedPoint(r, ADC_R_FIXP_FORMAT_M, ADC_R_FIXP_FORMAT_N, true);
   qi = floatToFixedPoint(q, ADC_Q_FIXP_FORMAT_M, ADC_Q_FIXP_FORMAT_N, true);


   // configure r = 1/m and q = b
   AXI4L_write32(0, ADC_BASE_ADDR + ADC_CFG_VALID);
   AXI4L_write32(ri, ADC_BASE_ADDR + ADC_R_OFFSET);
   AXI4L_write32(qi, ADC_BASE_ADDR + ADC_Q_OFFSET);
   // configure the switch
   AXI4L_write32(adcReadoutcgf, ADC_BASE_ADDR + ADC_ENABLE_OFFSET);
   AXI4L_write32(1, ADC_BASE_ADDR + ADC_CFG_VALID);

   status = IRC_SUCCESS;

   return status;
}

uint32_t floatToFixedPoint(float val, uint32_t m, uint32_t n, bool s)
{
   uint32_t qval;
   uint32_t max_int = 1 << (m+n+1);

   val *= (1 << n);

   if (s && val < 0)
      qval = max_int - (uint32_t)fabsf(val);
   else
      qval = val;

   return qval;
}


