/**
 *  @file tec_intf.c
 *  TEC Controller module implementation.
 *
 *  This file implements the TEC Controller module.
 *
 *  $Rev: 24412 $
 *  $Author: elarouche $
 *  $LastChangedDate: 2019-10-30 17:48:17 -0400 (mer., 30 oct. 2019) $
 *  $Id: proc_ctrl.c 24412 2019-10-30 21:48:17Z odionne $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2020-06-17%20-%20DP2011%20S2K/src/sw/proc_ctrl.c $
 *
 * (c) Copyright 2020 Telops Inc.
 */

#include <stdbool.h>
#include "xstatus.h"
#include "xparameters.h"
#include "xiic.h"
#include "xintc.h"
#include "utils.h"
#include "fpa_intf.h"
#include "tec_intf.h"

#define I2C_SLAVE_ADDR 0x2C /* ref: datasheet du AD5245 */

/* Private data */
static XIic gI2CCtrl;
static bool init;

void TEC_Init(void)
{
   XStatus status;

   if (!init)
   {
      status = XIic_Initialize(&gI2CCtrl, XPAR_AXI_IIC_0_DEVICE_ID);
      if (status != XST_SUCCESS) goto fail;

      /* Set I2C slave address */
      status = XIic_SetAddress(&gI2CCtrl, XII_ADDR_TO_SEND_TYPE, I2C_SLAVE_ADDR);
      if (status != XST_SUCCESS) goto fail;
      XIic_Start(&gI2CCtrl);
      init = true;
   }

   return;

fail:
   TEC_PRINTF("Controller initialization failure!");
}

uint16_t TEC_GetTemperatureSetpoint(void)
{
   unsigned ByteCount;
   uint8_t DigipotVal = 0;

   if (!init) return;
   ByteCount = XIic_Recv(XPAR_AXI_IIC_0_BASEADDR, I2C_SLAVE_ADDR,
                         &DigipotVal, 1, XIIC_STOP);
   if (ByteCount != 1)
      TEC_PRINTF("Digipot reading failure!");

   return DigipotVal;
}

void TEC_SetTemperatureSetpoint(uint16_t SetVal)
{
   unsigned ByteCount;
   uint8_t databuf[2];

   databuf[0] = 0x00;   /* instruction byte */
   databuf[1] = SetVal; /* data byte */

   if (!init) return;
   ByteCount = XIic_Send(XPAR_AXI_IIC_0_BASEADDR, I2C_SLAVE_ADDR,
                         databuf, 2, XIIC_STOP);
   if (ByteCount != 2)
      TEC_PRINTF("Digipot writing failure!");
}
