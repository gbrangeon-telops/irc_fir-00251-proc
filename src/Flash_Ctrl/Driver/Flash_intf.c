
#include "Flash_intf.h"
#include "tel2000_param.h"
#include "sleep.h"
#include "xil_io.h"

/**
 * FlashInitInterface init the gpio io port to known state
 *
 * @param   baseAddr is the base address of the Flash GPIO Ctrl.
 */

void FlashIntf_Init(FlashIntfStruct *FlashIntf)
{
   //Initialize
   FlashIntf->BaseAddress = XPAR_M_FLASHINTF_AXI_BASEADDR;
   
   //Set direction
   FlashIntf_CfgOutput(FlashIntf, FLASH_INTF_CMD_TRI_OFFSET, 0xFFFFFFC0);
   FlashIntf_CfgOutput(FlashIntf, FLASH_INTF_DATA_TRI_OFFSET, 0xFFFFFFFF);
   
   //Set initial value
   FlashIntf_SetOutput(FlashIntf, FLASH_INTF_NAND_SM_OFFSET, 0);
   FlashIntf_SetOutput(FlashIntf, FLASH_INTF_CMD_OUT_OFFSET, 0xFFFFFF0C);
   FlashIntf_SetOutput(FlashIntf, FLASH_INTF_DATA_OUT_OFFSET, 0);
}

void FlashIntf_SetOutput(FlashIntfStruct *FlashIntf, uint8_t RegOffset, uint32_t Mask)
{
   FlashIntf_WriteReg(FlashIntf->BaseAddress, RegOffset + FLASH_INTF_REG_OFFSET, Mask);
}

// DirectionMask = 1 => input, DirectionMask = 0 => output
void FlashIntf_CfgOutput(FlashIntfStruct *FlashIntf, uint8_t RegOffset, uint32_t DirectionMask)
{
   FlashIntf_WriteReg(FlashIntf->BaseAddress, RegOffset + FLASH_INTF_REG_OFFSET, DirectionMask);
}

uint32_t FlashIntf_GetInput(FlashIntfStruct *FlashIntf, uint8_t RegOffset)
{
   return FlashIntf_ReadReg(FlashIntf->BaseAddress + FLASH_INTF_REG_OFFSET, RegOffset);
}
