/* $Id: calibration.h 12286 2013-01-25 19:24:16Z pdaraiche $ */
/****************************************************************************/
/**
*
* @file calibration.h
* 
* This driver controls the module CalibrationController via Axi lite32.
* Please see the following documentation about details of this module:
* 
* 
* Author(s) : Edem Nofodjie
*
*****************************************************************************/
#ifndef __calibration_tb_H__
#define __calibration_tb_H__

/***************************** Include Files ********************************/
#include <stdint.h>
#include "xbasic_types.h"  
#include "GC_Registers.h"
#include "IRC_status.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/
typedef struct
{
   float    delta_f;
   float    alpha_offset;
   float    data_offset;
   float    data_lsb;
   float    range_offset;
   float    nuc_mult_factor;
   t_lut    nlc_lut;
   t_lut    rqc_lut;
} calHdrData_t;

#endif // __calib_H__
