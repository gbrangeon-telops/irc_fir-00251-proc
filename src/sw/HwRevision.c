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
#include "GenICam.h"
#include "GC_Registers.h"
/**
 * Validate device key using device key validation code.
 *
 * @param p_flashSettings is the pointer to the flash settings data structure.
 * @param p_flashDynamicValues is the pointer to the flash dynamic values data structure.
 *
 * @return IRC_SUCCESS if device key is valid.
 * @return IRC_FAILURE if device key is not valid.
 */
IRC_Status_t Get_board_hw_revision(uint16_t gpioDeviceId, detected_hw_t* detected_hw )
{
   XGpio hw_rev_gpio;
   XStatus status;
   uint32_t hw_id = 0;
   uint8_t  brd_rev = 0;

   status = XGpio_Initialize(&hw_rev_gpio, gpioDeviceId);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   hw_id = XGpio_DiscreteRead(&hw_rev_gpio, REV_GPIO_CHANNEL);
   brd_rev = (uint8_t)(hw_id & 0x0000007F); // Board rev is the 7 LSB bits of the ID word.

   if((hw_id & 0x00000080) == 1) // DDR memory HW config is the MSB bit of the ID word.
   {
      detected_hw->NbDDR3 = 4;
      TDCFlags2Set(Mem4DDRIsImplementedMask);
   }
   else
   {
      detected_hw->NbDDR3 = 2;
      TDCFlags2Clr(Mem4DDRIsImplementedMask);
   }

   switch(brd_rev){
      case 0:
         detected_hw->BrdRevid = BRD_REV_00x;
         HWR_INF("\nHW Board Revision is 00x");
         break;
      case 1:
         detected_hw->BrdRevid = BRD_REV_20x;
         HWR_INF("\nHW Board Revision is 20x (%u DDR3)", detected_hw->NbDDR3);
         break;
      default:
         detected_hw->BrdRevid = BRD_REV_UNKNOWN;
         HWR_INF("\nHW Board Revision is Unknown");
         return IRC_FAILURE;
   }

   return IRC_SUCCESS;
}
