/**
 *  @file tec_intf.h
 *  TEC Controller module header.
 *
 *  This file declares the TEC Controller module.
 *
 *  $Rev: 24412 $
 *  $Author: elarouche $
 *  $LastChangedDate: 2019-10-30 17:48:17 -0400 (mer., 30 oct. 2019) $
 *  $Id: proc_ctrl.c 24412 2019-10-30 21:48:17Z odionne $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2020-06-17%20-%20DP2011%20S2K/src/sw/proc_ctrl.c $
 *
 * (c) Copyright 2020 Telops Inc.
 */
#ifndef __TEC_INTF_H__
#define __TEC_INTF_H__

#include <stdint.h>

#define TEC_PRINTF(fmt, ...)  FPGA_PRINTF("TEC: " fmt "\n", ##__VA_ARGS__)

/* Prototypes */
void TEC_Init(void);
void TEC_Process(void );
uint16_t TEC_GetTemperatureSetpoint(void);
void TEC_SetTemperatureSetpoint(uint16_t SetVal);

#endif // __TEC_INTF_H__
