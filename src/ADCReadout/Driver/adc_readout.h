/* $Id$ */
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

#define ADC_BASE_ADDR TEL_PAR_TEL_ADC_READOUT_CTRL_BASEADDR

#define ADC_ENABLE_OFFSET 0x00
#define ADC_R_OFFSET  0x04
#define ADC_Q_OFFSET  0x08
#define ADC_CFG_VALID 0x0C

IRC_Status_t ADC_readout_init(flashSettings_t* fs);

// convert flat value into a Qm.n fixed point value (encoded on m+n+s bits)
uint32_t floatToFixedPoint(float val, uint32_t m, uint32_t n, bool s);
														 
#endif // __ADC_READOUT_H__
