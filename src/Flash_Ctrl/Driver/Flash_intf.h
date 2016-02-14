#ifndef FLASH_INTF_H
#define FLASH_INTF_H

#include <stdint.h>
#include <stdbool.h>

#define FLASH_INTF_BRAM_OFFSET         0x0000
#define FLASH_INTF_REG_OFFSET          0x2000

#define FLASH_INTF_NAND_SM_OFFSET         0x00
#define FLASH_INTF_READYBUSY_OFFSET       0x04
#define FLASH_INTF_CMD_IN_OFFSET          0x08
#define FLASH_INTF_CMD_OUT_OFFSET         0x0C
#define FLASH_INTF_CMD_TRI_OFFSET         0x10
#define FLASH_INTF_DATA_IN_OFFSET         0x14
#define FLASH_INTF_DATA_OUT_OFFSET        0x18
#define FLASH_INTF_DATA_TRI_OFFSET        0x1C

typedef struct {
	uint32_t BaseAddress;	/* Device base address */
	uint32_t IsReady;		/* Device is initialized and ready */
} FlashIntfStruct;

#define FlashIntf_WriteReg(BaseAddress, RegOffset, Data) \
	Xil_Out32((BaseAddress) + (RegOffset), (uint32_t)(Data))

#define FlashIntf_ReadReg(BaseAddress, RegOffset) \
	Xil_In32((BaseAddress) + (RegOffset))

void FlashIntf_Init(FlashIntfStruct *FlashIntf);
void FlashIntf_SetOutput(FlashIntfStruct *FlashIntf, uint8_t RegOffset, uint32_t Mask);
uint32_t FlashIntf_GetInput(FlashIntfStruct *FlashIntf, uint8_t RegOffset);
void FlashIntf_CfgOutput(FlashIntfStruct *FlashIntf, uint8_t RegOffset, uint32_t DirectionMask);

#endif
