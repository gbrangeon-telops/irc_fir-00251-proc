/**
 * @file DeviceKey.c
 * Device key module implementation.
 *
 * This file implements device key module.
 * 
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
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
         *(brd_rev_id) = BRD_REV_001;
         HWR_INF("\nHW Board Revision is 001");
         break;
      case 1:
         *(brd_rev_id) = BRD_REV_201;
         HWR_INF("\nHW Board Revision is 201");
         break;
      default:
         *(brd_rev_id) = BRD_REV_UNKNOWN;
         HWR_INF("\nHW Board Revision is Unknown");
         break;
   }

   return IRC_SUCCESS;
}
