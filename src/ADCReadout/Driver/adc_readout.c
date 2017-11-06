#include "adc_readout.h"

#include "tel2000_param.h"
#include "mb_axi4l_bridge.h"
#include "utils.h"
#include "HwRevision.h"

#include <stdlib.h>
#include <time.h>
#include <stdint.h>


#define ADC_Q_FIXP_FORMAT_M (uint32_t)15
#define ADC_Q_FIXP_FORMAT_N (uint32_t)4
#define ADC_R_FIXP_FORMAT_M (uint32_t)3
#define ADC_R_FIXP_FORMAT_N (uint32_t)16

extern brd_rev_ver_t gBrdRevid;

// fonction appelée au chargement des flash settings
IRC_Status_t ADC_readout_init(flashSettings_t* fs)
{
   IRC_Status_t status = IRC_FAILURE;
   int32_t ri, qi;
   float r, q;
   uint32_t N_ADC_BITS = 12;
   uint32_t adcReadoutcgf = 0;

   // nominal values
   float m = 1.0; // [counts/mV]
   float b = 0.0f;  // [counts]
   
   if(gBrdRevid == BRD_REV_20x){
      adcReadoutcgf = ADC_AND_IRIG;
      N_ADC_BITS = 16;
   }
   else if(gBrdRevid == BRD_REV_00x && fs->ADCReadoutEnabled)
   {
      adcReadoutcgf = ADC_READOUT;
      N_ADC_BITS = 12;
   }
   else
   {
      adcReadoutcgf = ADC_IRIG_ONLY;
      N_ADC_BITS = 16;
   }

   m = fs->ADCReadout_m;
   b = fs->ADCReadout_b;

   r = 1.0f/m;
   q = b + (1<<(N_ADC_BITS-1)); // 2048 is the nominal offset, since the input of the ADC is offset by Vref/2

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

   /*
   PRINTF("ADC_READOUT: enabled = %d\n", adcReadoutEnabled);
   PRINTF("ADC_READOUT: m (float) = " _PCF(3) "\n", _FFMT(fs->ADCReadout_m, 3));
   PRINTF("ADC_READOUT: b (int16) = %d\n", fs->ADCReadout_b);
   PRINTF("ADC_READOUT: r (float) = " _PCF(5) "\n", _FFMT(r, 5));
   PRINTF("ADC_READOUT: q (float) = " _PCF(3) "\n", _FFMT(q, 3));
   PRINTF("ADC_READOUT: r (fixed point) = %d\n", ri);
   PRINTF("ADC_READOUT: q (fixed point) = %d\n", qi);
   */

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


