
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
	// uint32_t Data = 0;

	//Initialize
   FlashIntf->BaseAddress = TEL_PAR_TEL_FLASH_INTF_BASEADDR;
   
	//Set direction
   FlashIntf_WriteReg(FlashIntf->BaseAddress, FLASH_INTF_CMD_TRI_OFFSET, 0xFFFFFFC0);
   // Data = FlashIntf_ReadReg(FlashIntf->BaseAddress, FLASH_INTF_CMD_TRI_OFFSET);
   FlashIntf_WriteReg(FlashIntf->BaseAddress, FLASH_INTF_DATA_TRI_OFFSET, 0xFFFFFFFF);
   // Data = FlashIntf_ReadReg(FlashIntf->BaseAddress, FLASH_INTF_DATA_TRI_OFFSET);
   
	//Set initial value
   FlashIntf_WriteReg(FlashIntf->BaseAddress, FLASH_INTF_NAND_SM_OFFSET, 0);
   // Data = FlashIntf_ReadReg(FlashIntf->BaseAddress, FLASH_INTF_NAND_SM_OFFSET);
   FlashIntf_WriteReg(FlashIntf->BaseAddress, FLASH_INTF_CMD_OUT_OFFSET, 0xFFFFFF0C);
   // Data = FlashIntf_ReadReg(FlashIntf->BaseAddress, FLASH_INTF_CMD_OUT_OFFSET);
   FlashIntf_WriteReg(FlashIntf->BaseAddress, FLASH_INTF_DATA_OUT_OFFSET, 0);
   // Data = FlashIntf_ReadReg(FlashIntf->BaseAddress, FLASH_INTF_DATA_OUT_OFFSET);
}

void FlashIntf_SetOutput(FlashIntfStruct *FlashIntf, uint8_t RegOffset, uint32_t Mask)
{
   FlashIntf_WriteReg(FlashIntf->BaseAddress, RegOffset + FLASH_INTF_REG_OFFSET, Mask);
}

// DirectionMask = 0 => input, DirectionMask = 1 => output
void FlashIntf_CfgOutput(FlashIntfStruct *FlashIntf, uint8_t RegOffset, uint32_t DirectionMask)
{
   FlashIntf_WriteReg(FlashIntf->BaseAddress, RegOffset + FLASH_INTF_REG_OFFSET, DirectionMask);
}

uint32_t FlashIntf_GetInput(FlashIntfStruct *FlashIntf, uint8_t RegOffset)
{
   return FlashIntf_ReadReg(FlashIntf->BaseAddress + FLASH_INTF_REG_OFFSET, RegOffset);
}
