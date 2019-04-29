/**
 * @file DeviceKey.c
 * Device key module implementation.
 *
 * This file implements device key module.
 * 
 * $Rev: 22650 $
 * $Author: pcouture $
 * $Date: 2018-12-13 15:30:18 -0500 (jeu., 13 déc. 2018) $
 * $Id: HwRevision.c 22650 2018-12-13 20:30:18Z pcouture $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/HwRevision.c $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "HwRevision.h"
#include "stdint.h"

/**
 * Validate device key using device key validation code.
 *
 * @param p_flashSettings is the pointer to the flash settings data structure.
 * @param p_flashDynamicValues is the pointer to the flash dynamic values data structure.
 *
 * @return IRC_SUCCESS if device key is valid.
 * @return IRC_FAILURE if device key is not valid.
 */
IRC_Status_t Get_board_hw_revision(uint16_t gpioDeviceId, brd_rev_ver_t* brd_rev_id )
{
   XGpio hw_rev_gpio;
   XStatus status;
   uint32_t brd_rev = 0;

   status = XGpio_Initialize(&hw_rev_gpio, gpioDeviceId);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   brd_rev = XGpio_DiscreteRead(&hw_rev_gpio, REV_GPIO_CHANNEL);

   switch(brd_rev){
      case 0:
         *(brd_rev_id) = BRD_REV_00x;
         HWR_INF("\nHW Board Revision is 00x");
         break;
      case 1:
         *(brd_rev_id) = BRD_REV_20x;
         HWR_INF("\nHW Board Revision is 20x");
         break;
      default:
         *(brd_rev_id) = BRD_REV_UNKNOWN;
         HWR_INF("\nHW Board Revision is Unknown");
         break;
   }

   return IRC_SUCCESS;
}
