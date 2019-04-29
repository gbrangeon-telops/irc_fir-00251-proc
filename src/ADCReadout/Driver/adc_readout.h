/* $Id: adc_readout.h 22650 2018-12-13 20:30:18Z pcouture $ */
/****************************************************************************/
/**
*
* @file adc_readout.h
* 
* This driver controls the ADC readout feature.
* 
* 
* Author(s) : Simon Savary
*
*****************************************************************************/
#ifndef __ADC_READOUT_H__
#define __ADC_READOUT_H__

#include "FlashSettings.h"
#include "IRC_status.h"

#include <stdbool.h>

#define ADC_BASE_ADDR XPAR_ADC_READOUT_CTRL_BASEADDR

#define ADC_ENABLE_OFFSET 0x00
#define ADC_R_OFFSET  0x04
#define ADC_Q_OFFSET  0x08
#define ADC_CFG_VALID 0x0C

#define ADC_DATA_OUT 0x00

#define ADC_Q_FIXP_FORMAT_M (uint32_t)15
#define ADC_Q_FIXP_FORMAT_N (uint32_t)4
#define ADC_R_FIXP_FORMAT_M (uint32_t)3
#define ADC_R_FIXP_FORMAT_N (uint32_t)16



enum adc_readout_cfg {
   ADC_IRIG_ONLY = 0,
   ADC_READOUT = 1,
   ADC_AND_IRIG = 2
};

typedef enum adc_readout_cfg adc_readout_cfg_t ;

IRC_Status_t ADC_readout_init(flashSettings_t* fs);

// convert flat value into a Qm.n fixed point value (encoded on m+n+s bits)
uint32_t floatToFixedPoint(float val, uint32_t m, uint32_t n, bool s);

#endif // __ADC_READOUT_H__
