/*
  This file is part of UFFS, the Ultra-low-cost Flash File System.
  
  Copyright (C) 2005-2009 Ricky Zheng <ricky_gz_zheng@yahoo.co.nz>

  UFFS is free software; you can redistribute it and/or modify it under
  the GNU Library General Public License as published by the Free Software 
  Foundation; either version 2 of the License, or (at your option) any
  later version.

  UFFS is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
  or GNU Library General Public License, as applicable, for more details.
 
  You should have received a copy of the GNU General Public License
  and GNU Library General Public License along with UFFS; if not, write
  to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  Boston, MA  02110-1301, USA.

  As a special exception, if other files instantiate templates or use
  macros or inline functions from this file, or you compile this file
  and link it with other works to produce a work based on this file,
  this file does not by itself cause the resulting work to be covered
  by the GNU General Public License. However the source code for this
  file must still be made available in accordance with section (3) of
  the GNU General Public License v2.
 
  This exception does not invalidate any other reasons why a work based
  on this file might be covered by the GNU General Public License.
*/
/**
 * \file flash-interface.c
 * \brief UFFS flash driver with multiple partitions, with static memory allocator.
 * based on flash-interface-example.c included with UFFS package
 * \author Francois Duchesneau, 2014-08-01
 */

#include "flash-interface.h"
#include "xparameters.h"
#include "tel2000_param.h"
#include "Flash_intf.h"
#include "uffs_config.h"
#include "uffs/uffs_os.h"
#include "uffs/uffs_device.h"
#include "uffs/uffs_flash.h"
#include "uffs/uffs_mtb.h"
#include "uffs/uffs_fs.h"
#include <string.h>
#include <stdio.h>
#include <Xgpio.h>

#define PFX "ndrv: "

#define MSG(msg,...) uffs_PerrorRaw(UFFS_MSG_NORMAL, msg, ## __VA_ARGS__)

struct my_nand_chip {
	//void *IOR_ADDR;
	//void *IOW_ADDR;
	UBOOL inited;
	// ... 
}chip;

#ifdef SHOW_LOW_ACCESS
volatile int trace = 0;
volatile int Total_Nand_read_full;
volatile int Total_Nand_read_partial;
volatile int Total_Nand_write;
volatile int Total_Nand_erase;
volatile int Total_Nand_check;
#endif

/*
 * Standard NAND flash commands
 */
#define NAND_CMD_READ0		0
#define NAND_CMD_READ1		0x30
//not used #define NAND_CMD_RNDOUT		5
#define NAND_CMD_PAGEPROG	0x10
//not used #define NAND_CMD_READOOB	0x50
#define NAND_CMD_ERASE1		0x60
#define NAND_CMD_STATUS		0x70
//not used #define NAND_CMD_STATUS_MULTI	0x71
#define NAND_CMD_SEQIN		0x80
//not used #define NAND_CMD_RNDIN		0x85
#define NAND_CMD_READID		0x90
#define NAND_CMD_ERASE2		0xd0
#define NAND_CMD_RESET		0xff
#define NAND_CMD_SET_FEATURES	0xEF
#define NAND_CMD_GET_FEATURES	0xEE

#define DPRAM_BASE_ADDRESS	0xC0000000

#define FM_UFFS_MOUNT_POINT_0            "/cs0/"
#define FM_UFFS_MOUNT_POINT_1            "/cs1/"


static int nand_init_flash(uffs_Device *dev);
static int nand_release_flash(uffs_Device *dev);
static int nand_read_pagewlayout(uffs_Device *dev, u32 block, u32 page, u8* data, int data_len, u8 *ecc, uffs_TagStore *ts, u8 *ecc_store);
static int nand_write_pagewlayout(uffs_Device *dev, u32 block, u32 page, const u8 *data, int data_len, const u8 *ecc, const uffs_TagStore *ts);
static int nand_erase_block(uffs_Device *dev, u32 block);
static int nand_check_erased_block(uffs_Device *dev, u32 block);

static uffs_FlashOps g_my_nand_ops = {
	nand_init_flash,		// InitFlash()
	nand_release_flash,		// ReleaseFlash()
	NULL,					// ReadPage()
	nand_read_pagewlayout,	// ReadPageWithLayout
	NULL,					// WritePage()
	nand_write_pagewlayout,	// WritePageWithLayout
	NULL,					// IsBadBlock(), let UFFS take care of it.
	NULL,					// MarkBadBlock(), let UFFS take care of it.
	nand_erase_block,		// EraseBlock()
	nand_check_erased_block, // CheckErasedBlock();
};


#define SET_DEFAULT_NAND_MODEL_STRUCT(model_struct) do{model_struct->nand_model = NAND_UNDEFINED;model_struct->nr_partition=0;}while(0)
#define SET_MT29F4_NAND_MODEL_STRUCT(model_struct) do{model_struct->nand_model = MT29F4G08ABADAWP;model_struct->nr_partition=1;}while(0)
#define SET_MT29F16_NAND_MODEL_STRUCT(model_struct) do{model_struct->nand_model = MT29F16G08AJADAWP;model_struct->nr_partition=2;}while(0)

flashIntfCtrl_t *gpflash_intf_struct ;
//nandModel_t g_my_nand_model = NAND_UNDEFINED;
//unsigned int g_current_nrpartition = 0;
/////////////////////////////////////////////////////////////////////////////////
//
// MT29F16G08AJADAWP NAND definitions
//
#define MT29F16G08AJADAWP_ID0 0x2C
#define MT29F16G08AJADAWP_ID1 0xD3
#define MT29F16G08AJADAWP_ID2 0xD1
#define MT29F16G08AJADAWP_ID3 0x95
#define MT29F16G08AJADAWP_ID4 0xDA


/////////////////////////////////////////////////////////////////////////////////
//
// MT29F4G08ABADAWP NAND definitions
//
#define MT29F4G08ABADAWP_ID0 0x2C
#define MT29F4G08ABADAWP_ID1 0xDC
#define MT29F4G08ABADAWP_ID2 0x90
#define MT29F4G08ABADAWP_ID3 0x95
#define MT29F4G08ABADAWP_ID4 0xD6

#define PAGE_DATA_SIZE  2048     // page size
#define PAGE_SPARE_SIZE 64       // spare size
#define PAGES_PER_BLOCK 64       // nb page per block
#define ADDRESS_SHIFT_PAGE 6     //shift block address to insert page address
#define PAGE_SIZE    (PAGE_DATA_SIZE + PAGE_SPARE_SIZE)
#define BLOCK_DATA_SIZE (PAGE_DATA_SIZE * PAGES_PER_BLOCK)


#if MAX_NR_PARTITION==1
#define MT29F4G08ABADAWP_TOTAL_BLOCKS  4096  // total block on chip
#else
#define MT29F4G08ABADAWP_TOTAL_BLOCKS  4096  // total block on chip

#endif
#define MT29F16G08AJADAWP_TOTAL_BLOCKS 8192  // total block on one 8gb chip select
                                             // one partition can not span on 2 chip
                                             // each partition has TOTAL_BLOCKS 8192

struct my_nand_chip g_nand_chip[MAX_NR_PARTITION] = {0};

struct uffs_StorageAttrSt g_my_flash_storage = {0};

/* define mount table */
static uffs_Device demo_device[MAX_NR_PARTITION] = {0};

static uffs_MountTable demo_mount_table[MAX_NR_PARTITION] = {
	{ &demo_device[0],  0, 0/*configured later*/, FM_UFFS_MOUNT_POINT_0},
	{ &demo_device[1],  0, 0/*configured later*/, FM_UFFS_MOUNT_POINT_1},

};
//convert dev_num to dev_idx
#define dev_num_to_idx(dev_num) ((dev_num <= gpflash_intf_struct->nr_partition) && (dev_num >0))?(dev_num-1):0

// sealed byte is use to know if a page was written
// this is the last user byte in spare section
#define SEALED_BYTE 0x37

// nand spare definition
// 0                               10h                             20h                             30h
// 0,1,2,3,4,5,6,7,8,9:a,b,c,d,e,f,0,1,2,3,4,5,6,7,8,9:a,b,c,d,e,f,0,1,2,3,4,5,6,7,8,9:a,b,c,d,e,f,0,1,2,3,4,5,6,7,8,9:a,b,c,d,e,f]
//[r,r,u,u,m,m,m,m,e,e,e,e,e,e,e,e,r,r,u,u,m,m,m,m,e,e,e,e,e,e,e,e,r,r,u,u,m,m,m,m,e,e,e,e,e,e,e,e,u,u,u,u,m,m,m,S,e,e,e,e,e,e,e,e
// not required static u8 nand_ecc_layout[] =  {0x08, 0x08, 0x18, 0x08, 0x28, 0x08, 0x38, 0x08, 0xff, 0x00};
// not required static u8 nand_data_layout[] = {0x04, 0x04, 0x14, 0x04, 0x24, 0x04, 0x34, 0x04, 0xff, 0x00};


static void setup_flash_storage(struct uffs_StorageAttrSt *attr)
{
	memset(attr, 0, sizeof(struct uffs_StorageAttrSt));

	// setup NAND flash attributes.
	if (gpflash_intf_struct->nand_model == MT29F4G08ABADAWP)
	   attr->total_blocks = MT29F4G08ABADAWP_TOTAL_BLOCKS;   /* total blocks */
	else     //MT29F16G08AJADAWP
	{
	   attr->total_blocks = MT29F16G08AJADAWP_TOTAL_BLOCKS*gpflash_intf_struct->nr_partition;  /* total blocks */
	}
	attr->page_data_size = PAGE_DATA_SIZE;		/* page data size */
	attr->pages_per_block = PAGES_PER_BLOCK;	/* pages per block */
	attr->spare_size = PAGE_SPARE_SIZE;		  	/* page spare size */
	attr->block_status_offs = 0;				/* block status offset is 0th byte in spare */
	attr->ecc_opt = UFFS_ECC_HW_AUTO;           /* ecc option */
	attr->layout_opt = UFFS_LAYOUT_FLASH;       /* let driver do the spare layout */
	attr->ecc_layout = NULL; 					// not required nand_ecc_layout;		/* page data ECC layout: [ofs1, size1, ofs2, size2, ..., 0xFF, 0]*/
	attr->data_layout = NULL; 					// not required nand_data_layout;		/* spare data layout: [ofs1, size1, ofs2, size2, ..., 0xFF, 0]*/
}

// uffs adaptation with gpio
#define CHANNEL_DATA 	1		// GPIO data channel
#define CHANNEL_COMMAND	2		// GPIO command channel
#define SM_COMMAND		3		// State Machine state
#define WREN_N_BIT		0x02	// write enable bit mask
#define RDEN_N_BIT		0x01	// read enable bit mask
#define CS0_N_BIT		0x04	// cs0 enable bit mask
#define CS1_N_BIT		0x08	// cs1 enable bit mask
#define CLE_BIT			0x10	// command latch enable bit mask
#define ALE_BIT			  0x20	// address latch enable bit mask
#define READYBUSY0_N_BIT         0x01  // ready busy0 bit mask
#define READYBUSY1_N_BIT         0x02  // ready busy1 bit mask
static XGpio Gpio;				// structure des definition GPIO

static u32 g_cs_tab[MAX_NR_PARTITION] = {CS0_N_BIT,CS1_N_BIT};
static u32 g_rb_tab[MAX_NR_PARTITION] = {READYBUSY0_N_BIT,READYBUSY1_N_BIT};

#ifdef MOD_FAST
static XGpio Gpio1;				// structure des definition GPIO
#endif

static FlashIntfStruct Flash_Interface;

/*
 * XGpio functions here are duplicated from library gpio_v3_01_a
 * to be optimized
*/

// optimized XGpio_SetDataDirection
static inline void my_XGpio_SetDataDirection(XGpio * InstancePtr, unsigned Channel,
			    u32 DirectionMask)
{
	//DirectionMask = ~DirectionMask;

	if (Channel == CHANNEL_DATA) {
		FlashIntf_CfgOutput(&Flash_Interface, FLASH_INTF_DATA_TRI_OFFSET, DirectionMask);
	} else if (Channel == CHANNEL_COMMAND) {
		FlashIntf_CfgOutput(&Flash_Interface, FLASH_INTF_CMD_TRI_OFFSET, DirectionMask);
	}

}

// optimized XGpio_DiscreteRead
static inline u32 my_XGpio_DiscreteRead(XGpio * InstancePtr, unsigned Channel)
{
	u32 ReadValue = 0xFFFFFFFF;

	if (Channel == CHANNEL_DATA) {
		ReadValue = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_DATA_IN_OFFSET);
	} else if (Channel == CHANNEL_COMMAND) {
		ReadValue = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_CMD_IN_OFFSET);
	}

	return ReadValue;
}

// optimized XGpio_DiscreteSet
static inline void my_XGpio_DiscreteSet(XGpio * InstancePtr, unsigned Channel, u32 Mask)
{
	u32 Current;
	unsigned DataOffset;

	if (Channel == CHANNEL_DATA) {
		DataOffset = FLASH_INTF_DATA_OUT_OFFSET;
	} else if (Channel == CHANNEL_COMMAND) {
		DataOffset = FLASH_INTF_CMD_OUT_OFFSET;
	} else if (Channel == SM_COMMAND) {
		DataOffset = FLASH_INTF_NAND_SM_OFFSET;
	} else {
		return;
	}

	Current = FlashIntf_GetInput(&Flash_Interface, DataOffset);
	Current |= Mask;
	FlashIntf_SetOutput(&Flash_Interface, DataOffset, Current);

}

// optimized XGpio_DiscreteClear
static inline void my_XGpio_DiscreteClear(XGpio * InstancePtr, unsigned Channel, u32 Mask)
{
	u32 Current;
	unsigned DataOffset;

	if (Channel == CHANNEL_DATA) {
		DataOffset = FLASH_INTF_DATA_OUT_OFFSET;
	} else if (Channel == CHANNEL_COMMAND) {
		DataOffset = FLASH_INTF_CMD_OUT_OFFSET;
	} else if (Channel == SM_COMMAND) {
		DataOffset = FLASH_INTF_NAND_SM_OFFSET;
	} else {
		return;
	}

	Current = FlashIntf_GetInput(&Flash_Interface, DataOffset);
	Current &= ~Mask;
	FlashIntf_SetOutput(&Flash_Interface, DataOffset, Current);
}

// combined XGpio_DiscreteClear + XGpio_DiscreteRead + XGpio_DiscreteSet
static inline u32 XGpio_DiscreteClearReadSet(XGpio * InstancePtr, unsigned ChannelRead, unsigned ChannelCommand, u32 Mask)
{
	u32 Current, Value;
	unsigned DataOffsetRead;
	unsigned DataOffsetCmd;

	if (ChannelRead == CHANNEL_DATA) {
		DataOffsetRead = FLASH_INTF_DATA_IN_OFFSET;
	} else if (ChannelRead == CHANNEL_COMMAND) {
		DataOffsetRead = FLASH_INTF_CMD_IN_OFFSET;
	} else {
		return 0xFFFFFFFF;
	}

	if (ChannelCommand == CHANNEL_DATA) {
		DataOffsetCmd = FLASH_INTF_DATA_OUT_OFFSET;
	} else if (ChannelCommand == CHANNEL_COMMAND) {
		DataOffsetCmd = FLASH_INTF_CMD_OUT_OFFSET;
	} else {
		return 0xFFFFFFFF;
	}

	Current = FlashIntf_GetInput(&Flash_Interface, DataOffsetCmd);
	Current &= ~Mask;
	FlashIntf_SetOutput(&Flash_Interface, DataOffsetCmd, Current);

	Value = FlashIntf_GetInput(&Flash_Interface, DataOffsetRead);
	Current |= Mask;
	FlashIntf_SetOutput(&Flash_Interface, DataOffsetCmd, Current);

	return Value;
}

// combined XGpio_DiscreteWrite + XGpio_DiscreteClear + XGpio_DiscreteSet
static inline void XGpio_DiscreteWriteClearSet(XGpio * InstancePtr, unsigned ChannelWrite, u32 Data, unsigned ChannelCommand, u32 Mask)
{
	u32 Current;
	unsigned DataOffsetWrite;
	unsigned DataOffsetCmd;

	if (ChannelWrite == CHANNEL_DATA) {
		DataOffsetWrite = FLASH_INTF_DATA_OUT_OFFSET;
	} else if (ChannelWrite == CHANNEL_COMMAND) {
		DataOffsetWrite = FLASH_INTF_CMD_OUT_OFFSET;
	} else {
		return;
	}

	if (ChannelCommand == CHANNEL_DATA) {
		DataOffsetCmd = FLASH_INTF_DATA_OUT_OFFSET;
	} else if (ChannelCommand == CHANNEL_COMMAND) {
		DataOffsetCmd = FLASH_INTF_CMD_OUT_OFFSET;
	} else {
		return;
	}

	FlashIntf_SetOutput(&Flash_Interface, DataOffsetWrite, Data);

	Current = FlashIntf_GetInput(&Flash_Interface, DataOffsetCmd);
	Current &= ~Mask;
	FlashIntf_SetOutput(&Flash_Interface, DataOffsetCmd, Current);
	Current |= Mask;
	FlashIntf_SetOutput(&Flash_Interface, DataOffsetCmd, Current);
}

//  Initialize GPIO interface
static void initGpioInterface(){  //Init GPIO interface to NAND

    my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0xFF);			// Data bus input
    FlashIntf_SetOutput(&Flash_Interface, FLASH_INTF_CMD_OUT_OFFSET, 0x0F);	// Set default command
    my_XGpio_SetDataDirection(&Gpio, CHANNEL_COMMAND, 0xFFFFFF00);  // Command output
    for(int i = 0; i < MAX_NR_PARTITION; i++ )
       my_XGpio_DiscreteSet(&Gpio, CHANNEL_COMMAND, g_cs_tab[i]);		// deselect cs0 & cs1

   // my_XGpio_DiscreteSet(&Gpio, CHANNEL_COMMAND, CS1_N_BIT);		// deselect cs1

}
static inline u32 GET_CHIP_SELECT(int dev_num)
{
   return g_cs_tab[dev_num_to_idx(dev_num)] ;
}
static inline u32 GET_CHIP_READYBUSY(int dev_num)
{
   return g_rb_tab[dev_num_to_idx(dev_num)] ;
}

// enable command latch
static inline void CHIP_SET_CLE(uffs_Device *dev) {
	//set gpio CLE
	my_XGpio_DiscreteSet(&Gpio, CHANNEL_COMMAND, CLE_BIT);
}
// disable command latch
static inline void CHIP_CLR_CLE(uffs_Device *dev) {
	//clear gpio CLE
	//XGpio_DiscreteClear(&Gpio, CHANNEL_COMMAND, CLE_BIT);
	my_XGpio_DiscreteClear(&Gpio, CHANNEL_COMMAND, CLE_BIT);
}
// enable address latch
static inline void CHIP_SET_ALE(uffs_Device *dev) {
	//set gpio ALE
	my_XGpio_DiscreteSet(&Gpio, CHANNEL_COMMAND, ALE_BIT);
}
// disable address latch
static inline void CHIP_CLR_ALE(uffs_Device *dev) {
	//clear gpio ALE
	my_XGpio_DiscreteClear(&Gpio, CHANNEL_COMMAND, ALE_BIT);
}
// disable chip select
static inline void CHIP_SET_NCS(uffs_Device *dev) {
	u32 CS = GET_CHIP_SELECT(dev->dev_num);
	//set gpio nCS
	my_XGpio_DiscreteSet(&Gpio, CHANNEL_COMMAND, CS);
}
// enable chip select
static inline void CHIP_CLR_NCS(uffs_Device *dev) {
   u32 CS = GET_CHIP_SELECT(dev->dev_num);
	//clear gpio nCS
	my_XGpio_DiscreteClear(&Gpio, CHANNEL_COMMAND, CS);
}
// wait chip busy (not used)
static inline void CHIP_BUSY(uffs_Device *dev) {
	//wait tADL (~100 ns)
}
// check & wait ready/busy bit
static inline int CHIP_READY(uffs_Device *dev) {
	//wait gpio busy set then clear
	//int iOnce = 1;
	int data, timeout = 0x7ffff;
	const u32 RB_MASK = GET_CHIP_READYBUSY(dev->dev_num);
	do{
		//data = my_XGpio_DiscreteRead(&Gpio2, 1);
		data = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_READYBUSY_OFFSET);
		data &= RB_MASK;
		//if (iOnce) {
		//	iOnce = 0;
		//	if (data == 0){
		//		MSG("see busy zero\n");
		//	}
		//}
	}while((data == 0) && --timeout);
	if (timeout == 0) {
		MSG("ERROR timeout occurs in CHIP_READY\n");
		return 1;
	}
	return 0;
}
// check & wait ready/busy bit
//static inline int CHIP_READY(uffs_Device *dev) {
//	//wait gpio busy set then clear
	//int iOnce = 1;
//	int data, timeout = 0x7ffff;
//	do{
//		data = my_XGpio_DiscreteRead(&Gpio, CHANNEL_COMMAND);
//		data &= 0x100;
		//if (iOnce) {
		//	iOnce = 0;
		//	if (data == 0){
		//		MSG("see busy zero\n");
		//	}
		//}
//	}while((data == 0) && --timeout);
//	if (timeout == 0) {
//		MSG("ERROR timeout occurs in CHIP_READY\n");
//		return 1;
//	}
//	return 0;
//}
// write a nand command
static inline void WRITE_COMMAND(uffs_Device *dev, u8 cmd){
	//set gpio data out
	//put cmd on gpio data
	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);

	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, cmd, CHANNEL_COMMAND, WREN_N_BIT);
}
// write a full nand address for read/write
static inline void WRITE_DATA_ADDR(uffs_Device *dev, u32 block, u32 page, u32 offset){
	//set gpio data out
	//write combine block+page+offset to gpio data
	u32 address = (block << ADDRESS_SHIFT_PAGE) | page;
	//MSG("*** address:%08X, offset:%08X\n", address, offset);
	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);

	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, offset, CHANNEL_COMMAND, WREN_N_BIT);
	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, offset >> 8, CHANNEL_COMMAND, WREN_N_BIT);
	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address, CHANNEL_COMMAND, WREN_N_BIT);
	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address >> 8, CHANNEL_COMMAND, WREN_N_BIT);
	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address >> 16, CHANNEL_COMMAND, WREN_N_BIT);
}
// write a partial nand address for erase
static inline void WRITE_ERASE_ADDR(uffs_Device *dev, u32 block){
	//set gpio data out
	//write block to gpio data
	u32 address = block << ADDRESS_SHIFT_PAGE;
	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);

	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address, CHANNEL_COMMAND, WREN_N_BIT);
	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address >> 8, CHANNEL_COMMAND, WREN_N_BIT);
	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address >> 16, CHANNEL_COMMAND, WREN_N_BIT);
}
#ifdef MOD_FAST
static inline void WRITE_DATA_FAST_SPARE(uffs_Device *dev, const u8 *data, int len){
	//set gpio data out
	//write data from dram buffer
	//****** assume data is on 64 bit boundary (if not boom...)


		u8 busy;
		u64 *data64 = (u64*)data;
		int len64 = len/8;
		u64 *DRAM1 = (u64 *)XPAR_M_FLASHINTF_AXI_BASEADDR;  					// Memory base

		while(len64) {
				*DRAM1 = *data64;
				data64++;
				DRAM1++;
				len64--;
			}

		my_XGpio_DiscreteSet(&Gpio1, SM_COMMAND, 8);
		my_XGpio_DiscreteClear(&Gpio1, SM_COMMAND, 8);
		//XGpio_DiscreteSet(&Gpio1, 1, 8);							//Start SM write 64 bytes
		//XGpio_DiscreteSet(&Gpio1, 1, 0);
		do{
			// busy = XGpio_DiscreteRead(&Gpio2, 1);
			busy = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_READYBUSY_OFFSET);
			busy &= 0x04;
		} while(busy > 0);
}

static inline void WRITE_DATA_FAST(uffs_Device *dev, const u8 *data, int len){
	//set gpio data out
	//write data from dram buffer
	//****** assume data is on 64 bit boundary (if not boom...)

		u8 busy;
		u64 *data64 = (u64*)data;
		int len64 = len/8;
		u64 *DRAM1 = (u64 *)XPAR_M_FLASHINTF_AXI_BASEADDR;  					// Memory base

		while(len64) {
				*DRAM1 = *data64;
				data64++;
				DRAM1++;
				len64--;
			}

		my_XGpio_DiscreteSet(&Gpio1, SM_COMMAND, 2);
		my_XGpio_DiscreteClear(&Gpio1, SM_COMMAND, 2);
		//XGpio_DiscreteSet(&Gpio1, 1, 2);							//Start SM write 2048 bytes
		//XGpio_DiscreteSet(&Gpio1, 1, 0);
		do{
			// busy = XGpio_DiscreteRead(&Gpio2, 1);
			busy = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_READYBUSY_OFFSET);
			busy &= 0x04;
		} while(busy > 0);

}
#endif
// write data to nand
static inline void WRITE_DATA(uffs_Device *dev, const u8 *data, int len){

	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);
	while(len) {
		XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, *data, CHANNEL_COMMAND, WREN_N_BIT);
		data++;
		len--;
	}
}
#ifdef MOD_FAST
static inline void READ_DATA_FAST_SPARE(uffs_Device *dev, u8 *data, int len){
	u8 busy = 0;
	//set gpio data in
	//read data from dram buffer
	//****** assume data is on 64 bit boundary (if not boom...)

		u64 *data64 = (u64*)data;
		int len64 = len/8;
	    u64 *DRAM1 = (u64 *)XPAR_M_FLASHINTF_AXI_BASEADDR;  					// Memory base
	    my_XGpio_DiscreteSet(&Gpio1, SM_COMMAND, 4);
    	my_XGpio_DiscreteClear(&Gpio1, SM_COMMAND, 4);

		do{
			// busy = XGpio_DiscreteRead(&Gpio2, 1);
			busy = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_READYBUSY_OFFSET);
			busy &= 0x08;
		} while(busy > 0);

		while(len64) {
			*data64 = *DRAM1;
			//testData[len64] = *DRAM1;
			data64++;
			DRAM1++;
			len64--;
		}

}
// read data from nand
static inline void READ_DATA_FAST(uffs_Device *dev, u8 *data, int len){
	u8 busy = 0;
	//set gpio data in
	//read data from dram buffer
	//****** assume data is on 64 bit boundary (if not boom...)
		//u32 test;

		u64 *data64 = (u64*)data;
		int len64 = len/8;
		u64 *DRAM1 = (u64 *)XPAR_M_FLASHINTF_AXI_BASEADDR;				// Memory base
		my_XGpio_DiscreteSet(&Gpio1, SM_COMMAND, 1);
		my_XGpio_DiscreteClear(&Gpio1, SM_COMMAND, 1);

		do{
			// busy = XGpio_DiscreteRead(&Gpio2, 1);
			busy = FlashIntf_GetInput(&Flash_Interface, FLASH_INTF_READYBUSY_OFFSET);
			busy &= 0x08;
		} while(busy > 0);

		while(len64) {
			*data64 = *DRAM1;
			data64++;
			DRAM1++;
			len64--;
		}

}
#endif
static inline void READ_DATA(uffs_Device *dev, u8 *data, int len){
		//set gpio data in
		//read data from gpio data for len

		my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0xFF);
		while(len) {
			*data = XGpio_DiscreteClearReadSet(&Gpio, CHANNEL_DATA, CHANNEL_COMMAND, RDEN_N_BIT);
			data++;
			len--;
		}
	}


//static inline void READ_DATA(uffs_Device *dev, u8 *data, int len){
	//set gpio data in
	//read data got gpio data for len
//	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0xFF);
//	while(len) {
//		*data = XGpio_DiscreteClearReadSet(&Gpio, CHANNEL_DATA, CHANNEL_COMMAND, RDEN_N_BIT);
//		data++;
//		len--;
//	}
//}
// check for status error
static inline int PARSE_STATUS(u8 v){
	//check status bit if no error or bad
	if ((v & 1) == 1)
		return UFFS_FLASH_IO_ERR;
	else
		return UFFS_FLASH_NO_ERR;
}

// read & check nand id
static int nand_readid(uffs_Device *dev) {
	int ret;
	u8 deviceid[4];

	gpflash_intf_struct->nand_model = NAND_UNDEFINED;   //reset nand model found

	CHIP_CLR_NCS(dev);
	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_RESET);
	CHIP_CLR_CLE(dev);

	ret = CHIP_READY(dev);
	if (ret){
		MSG("ERROR Ready Busy bit failed\n");
		return 1;
	}
	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_READID);
	CHIP_CLR_CLE(dev);
	CHIP_SET_ALE(dev);
	// write address 0
	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);

	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, 0, CHANNEL_COMMAND, WREN_N_BIT);

	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0xFF);

	CHIP_CLR_ALE(dev);
	READ_DATA(dev, deviceid, 4);

	CHIP_SET_NCS(dev);
	MSG("nand_readid b1:%02x, b2:%02x, b3:%02x, b4:%02x\n", deviceid[0], deviceid[1], deviceid[2], deviceid[3]);
   if ((deviceid[0] == MT29F16G08AJADAWP_ID0) &&
         (deviceid[1] == MT29F16G08AJADAWP_ID1) &&
         (deviceid[2] == MT29F16G08AJADAWP_ID2) &&
         (deviceid[3] == MT29F16G08AJADAWP_ID3)) // don't check last one, it may be 0x5a or 0xda
   {
      SET_MT29F16_NAND_MODEL_STRUCT(gpflash_intf_struct);
      print("MT29F16G08AJADAWP NAND Flash detected \n\r");

      ret = 0;
   }
   else if ((deviceid[0] == MT29F4G08ABADAWP_ID0) &&
         (deviceid[1] == MT29F4G08ABADAWP_ID1) &&
         (deviceid[2] == MT29F4G08ABADAWP_ID2) &&
         (deviceid[3] == MT29F4G08ABADAWP_ID3)) // don't check last one, it may be 0x56 or 0xd6
   {
      SET_MT29F4_NAND_MODEL_STRUCT(gpflash_intf_struct);
      print("MT29F4G08ABADAWP NAND Flash detected %d\n\r");
      ret= 0;
   }
   else
      return 1;
   if(gpflash_intf_struct->nr_partition > MAX_NR_PARTITION) {
      MSG("ERROR NR partition is too high %d, driver can only handle %d!\n",gpflash_intf_struct->nr_partition,MAX_NR_PARTITION);
      gpflash_intf_struct->nr_partition = MAX_NR_PARTITION;
   }

   return ret;
}

// force HW Ecc calculation
static void nand_set_features(uffs_Device *dev, u8 address, const u8 *data) {
	CHIP_CLR_NCS(dev);
	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_SET_FEATURES);
	CHIP_CLR_CLE(dev);
	CHIP_SET_ALE(dev);
	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);

	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address, CHANNEL_COMMAND, WREN_N_BIT);
	CHIP_CLR_ALE(dev);
	{
		volatile int i=10;
		while(i--);				//delay > 10us
	}
	WRITE_DATA(dev, data, 4);
	CHIP_READY(dev);
	CHIP_SET_NCS(dev);
}

// read HW Ecc calculation feature
static int nand_get_features(uffs_Device *dev, u8 address, const u8 *verif_data) {
	u8 data[4];
	CHIP_CLR_NCS(dev);
	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_GET_FEATURES);
	CHIP_CLR_CLE(dev);
	CHIP_SET_ALE(dev);
	my_XGpio_SetDataDirection(&Gpio, CHANNEL_DATA, 0x00);

	XGpio_DiscreteWriteClearSet(&Gpio, CHANNEL_DATA, address, CHANNEL_COMMAND, WREN_N_BIT);
	CHIP_CLR_ALE(dev);
	CHIP_READY(dev);
	READ_DATA(dev, data, 4);
	CHIP_SET_NCS(dev);
	MSG("Feature: addr:%02x %02x,%02x,%02x,%02x\n",address, data[0], data[1], data[2], data[3]);
	if ((data[0] == verif_data[0]) && (data[1] == verif_data[1]) && (data[2] == verif_data[2]) && (data[3] == verif_data[3]))
		return 0;
	else
		return 1;
}

/*
 * \brief uffs tag, 8 bytes, will be store in page spare area.
struct uffs_TagStoreSt {
	u32 dirty:1;		//!< 0: dirty, 1: clear
	u32 valid:1;		//!< 0: valid, 1: invalid
	u32 type:2;			//!< block type: #UFFS_TYPE_DIR, #UFFS_TYPE_FILE, #UFFS_TYPE_DATA
	u32 block_ts:2;		//!< time stamp of block;
	u32 data_len:12;	//!< length of page data
	u32 serial:14;		//!< serial number

	u32 parent:10;		//!< parent's serial number
	u32 page_id:6;		//!< page id
	u32 reserved:4;		//!< reserved, for UFFS2
	u32 tag_ecc:12;		//!< tag ECC
};
*/

// convert nand spare to tag for UFFS
static void spare2tag(u8* spare, uffs_TagStore *ts){

	//u32* u = (u32*)ts;
	ts->dirty = spare[4];
	ts->valid = spare[5];
	ts->type = spare[6];
	ts->block_ts = spare[7];
	ts->data_len = (spare[0x14] << 8) | spare[0x15];
	ts->serial = (spare[0x16] << 8) | spare[0x17];
	ts->parent = (spare[0x24] << 8) | spare[0x25];
	ts->page_id = spare[0x26];
	ts->reserved = spare[0x27];
	ts->tag_ecc = (spare[0x34] << 8) | spare[0x35];
	/*
	MSG("spare2tag %02x, %02x, %02x, %02x, u:%08X\n", spare[4], spare[5], spare[6], spare[7], *u);
	MSG("spare2tag %02x, %02x, %02x, %02x\n", spare[0x14], spare[0x15], spare[0x16], spare[0x17]);
	MSG("spare2tag %02x, %02x, %02x, %02x\n", spare[0x24], spare[0x25], spare[0x26], spare[0x27]);
	MSG("spare2tag %02x, %02x\n", spare[0x34], spare[0x35]);
	MSG("ts->dirty:%08X\n", ts->dirty);
	MSG("ts->valid:%08X\n", ts->valid);
	MSG("ts->type:%08X\n", ts->type);
	MSG("ts->block_ts:%08X\n", ts->block_ts);
	MSG("ts->data_len:%08X\n", ts->data_len);
	MSG("ts->serial:%08X\n", ts->serial);
	MSG("ts->parent:%08X\n", ts->parent);
	MSG("ts->page_id:%08X\n", ts->page_id);
	MSG("ts->reserved:%08X\n", ts->reserved);
	MSG("ts->tag_ecc:%08X\n", ts->tag_ecc);
	*/
}

// convert tag from UFFS to spare
static void tag2spare(u8* spare, const uffs_TagStore *ts){
	spare[4] = ts->dirty;
	spare[5] = ts->valid;
	spare[6] = ts->type;
	spare[7] = ts->block_ts;
	spare[0x14] = ts->data_len >> 8;
	spare[0x15] = ts->data_len;
	spare[0x16] = ts->serial  >> 8;
	spare[0x17] = ts->serial;
	spare[0x24] = ts->parent >> 8;
	spare[0x25] = ts->parent;
	spare[0x26] = ts->page_id;
	spare[0x27] = ts->reserved;
	spare[0x34] = ts->tag_ecc >> 8;
	spare[0x35] = ts->tag_ecc;
}

/**
 * Read a full nand page, driver do the layout.
 *
 * \param[out] ecc ecc of page data
 *   if ecc_opt is UFFS_ECC_HW, flash driver must calculate and return ecc of data(if ecc != NULL).
 *   if ecc_opt is UFFS_ECC_HW_AUTO, flash driver do ecc correction before return data and flash driver do not need to return ecc.
 *   if ecc_opt is UFFS_ECC_NONE or UFFS_ECC_SOFT, flash driver do not need calculate data ecc and return ecc.
 *
 * \param[out] ecc_store ecc store on spare area
 *   if ecc_opt is UFFS_ECC_NONE or UFFS_ECC_HW_AUTO, do not need to return ecc_store.
 *
 * \note flash driver must provide this function if layout_opt is UFFS_LAYOUT_FLASH.
 *       UFFS will use this function (if exist) prio to 'ReadPageSpare()'
 *
 * \return	#UFFS_FLASH_NO_ERR: success
 *			#UFFS_FLASH_IO_ERR: I/O error, expect retry ?
 *			#UFFS_FLASH_ECC_FAIL: page data has flip bits and ecc correct failed (when ecc_opt == UFFS_ECC_HW_AUTO)
 *			#UFFS_FLASH_ECC_OK: page data has flip bits and corrected by ecc (when ecc_opt == UFFS_ECC_HW_AUTO)
 *          #UFFS_FLASH_BAD_BLK: if the block is a bad block (e.g., the bad block mark byte is not 0xFF)
 *			#UFFS_FLASH_NOT_SEALED: if the page spare is not sealed properly
 *
 * \note if data is NULL, do not return data; if ts is NULL, do not read tag; if both data and ts are NULL,
 *       then read bad block mark and return UFFS_FLASH_BAD_BLK if bad block mark is not 0xFF.
 *
 * \note flash driver DO NOT need to do ecc correction for tag,
 *		UFFS will take care of tag ecc.
 */
static int nand_read_pagewlayout(uffs_Device *dev, u32 block, u32 page, u8* data, int data_len, u8 *ecc, uffs_TagStore *ts, u8 *ecc_store)
{
	u8 val = 0, status;
	int ret = UFFS_FLASH_NO_ERR;

	UBOOL fall_through = FALSE;
	u8 spare[PAGE_SPARE_SIZE];
	CHIP_CLR_NCS(dev);
	//MSG("nand_read_pagewlayout data:%08X, data_len:%d, ts:%08X, ecc:%08X, ecc_store:%08X\n", data, data_len, ts, ecc, ecc_store);
	if (data && data_len > 0) {
#ifdef SHOW_LOW_ACCESS
		Total_Nand_read_full++;
#endif
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		CHIP_CLR_CLE(dev);
		CHIP_SET_ALE(dev);
		WRITE_DATA_ADDR(dev, block, page, 0);
		CHIP_CLR_ALE(dev);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ1);
		CHIP_CLR_CLE(dev);
		CHIP_READY(dev);
		// read status
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_STATUS);
		CHIP_CLR_CLE(dev);
		READ_DATA(dev, &status, 1);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		CHIP_CLR_CLE(dev);
		// read data
		if ((status & 1) == 1) {
			MSG("read data status failed status:%08x\n",status);
			ret  = UFFS_FLASH_ECC_FAIL;
			goto read_out;
		}
#ifdef PERFORMANCE_LOW
		if ((data_len == PAGE_DATA_SIZE) && (ecc_store == NULL)){
#else
		if (data_len == PAGE_DATA_SIZE){
#endif
#ifdef MOD_FAST
			READ_DATA_FAST(dev, data, data_len);
#else
			READ_DATA(dev, data, data_len);
#endif
		}
		else {
			READ_DATA(dev, data, data_len);
		}
		if (data_len == dev->attr->page_data_size){
			fall_through = TRUE;
		}
	}

	if (ts) {
		if (!fall_through){
#ifdef SHOW_LOW_ACCESS
			Total_Nand_read_partial++;
#endif
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_READ0);
			CHIP_CLR_CLE(dev);
			CHIP_SET_ALE(dev);
			WRITE_DATA_ADDR(dev, block, page, dev->attr->page_data_size);
			CHIP_CLR_ALE(dev);
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_READ1);
			CHIP_CLR_CLE(dev);
			CHIP_READY(dev);
			// read status
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_STATUS);
			CHIP_CLR_CLE(dev);
			READ_DATA(dev, &status, 1);
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_READ0);
			CHIP_CLR_CLE(dev);
			// read data
			if ((status & 1) == 1) {
				MSG("read ts status failed status:%08X\n",status);
				ret  = UFFS_FLASH_ECC_FAIL;
				goto read_out;
			}
		}
		//MSG("nand_readTS block:%08X, %08X, ret:%02X\n",block, page, ret);
#ifdef MOD_FAST
		READ_DATA_FAST_SPARE(dev, spare, dev->attr->spare_size);
#else
		READ_DATA(dev, spare, dev->attr->spare_size);
#endif
		spare2tag(spare, ts);
		/*
		if (trace && (page == 0)){
			MSG("NR b:%ld, p:%ld\n", block, page);
			MSG("R %02x, %02x, %02x, %02x\n", spare[4], spare[5], spare[6], spare[7]);
			MSG("R %02x, %02x, %02x, %02x\n", spare[0x14], spare[0x15], spare[0x16], spare[0x17]);
			MSG("R %02x, %02x, %02x, %02x\n", spare[0x24], spare[0x25], spare[0x26], spare[0x27]);
			MSG("R %02x, %02x\n", spare[0x34], spare[0x35]);
			MSG("ts->dirty:%08X\n", ts->dirty);
			MSG("ts->valid:%08X\n", ts->valid);
			MSG("ts->type:%08X\n", ts->type);
			MSG("ts->block_ts:%08X\n", ts->block_ts);
			MSG("ts->data_len:%08X\n", ts->data_len);
			MSG("ts->serial:%08X\n", ts->serial);
			MSG("ts->parent:%08X\n", ts->parent);
			MSG("ts->page_id:%08X\n", ts->page_id);
			MSG("ts->reserved:%08X\n", ts->reserved);
			MSG("ts->tag_ecc:%08X\n", ts->tag_ecc);
		}
		*/
		if ((spare[SEALED_BYTE] == 0xFF) && (ret == UFFS_FLASH_NO_ERR))
			ret = UFFS_FLASH_NOT_SEALED;
	}

	if (data == NULL && ts == NULL) {
		// read bad block mark
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		CHIP_CLR_CLE(dev);
		CHIP_SET_ALE(dev);
		WRITE_DATA_ADDR(dev, block, page, dev->attr->page_data_size + dev->attr->block_status_offs);
		CHIP_CLR_ALE(dev);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ1);
		CHIP_CLR_CLE(dev);
		CHIP_READY(dev);
		// read status
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_STATUS);
		CHIP_CLR_CLE(dev);
		READ_DATA(dev, &status, 1);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		CHIP_CLR_CLE(dev);
		// read data
		if ((status & 1) == 1) {
			MSG("read BB status failed status:%08X\n",status);
			ret  = UFFS_FLASH_ECC_FAIL;
			goto read_out;
		}
		READ_DATA(dev, &val, 1);
		ret = (val == 0xFF ? UFFS_FLASH_NO_ERR : UFFS_FLASH_BAD_BLK);
		if (ret == UFFS_FLASH_BAD_BLK){
			MSG("**** read BB:%d, page:%d, val:%02X\n",block, page, val);
		}
	}
read_out:
	CHIP_SET_NCS(dev);

	return ret;
}

/**
 * Write full page, flash driver do the layout for spare area.
 *
 * \note if layout_opt is UFFS_LAYOUT_FLASH or ecc_opt is UFFS_ECC_HW/UFFS_ECC_HW_AUTO, flash driver MUST implement
 *       this function. UFFS will use this function (if provided) prio to 'WritePage()'
 *
 * \param[in] ecc ecc of data. if ecc_opt is UFFS_ECC_SOFT and this function is implemented,
 *                UFFS will calculate page data ecc and pass it to WritePageWithLayout().
 *            if ecc_opt is UFFS_ECC_NONE/UFFS_ECC_HW/UFFS_ECC_HW_AUTO, UFFS pass ecc = NULL.
 *
 * \note If data == NULL && ts == NULL, driver should mark this block as a 'bad block'.
 *
 * \return	#UFFS_FLASH_NO_ERR: success
 *			#UFFS_FLASH_IO_ERR: I/O error, expect retry ?
 *			#UFFS_FLASH_BAD_BLK: a bad block detected.
 */
/*
 * \brief uffs tag, 8 bytes, will be store in page spare area.
struct uffs_TagStoreSt {
	u32 dirty:1;		//!< 0: dirty, 1: clear
	u32 valid:1;		//!< 0: valid, 1: invalid
	u32 type:2;			//!< block type: #UFFS_TYPE_DIR, #UFFS_TYPE_FILE, #UFFS_TYPE_DATA
	u32 block_ts:2;		//!< time stamp of block;
	u32 data_len:12;	//!< length of page data
	u32 serial:14;		//!< serial number

	u32 parent:10;		//!< parent's serial number
	u32 page_id:6;		//!< page id
	u32 reserved:4;		//!< reserved, for UFFS2
	u32 tag_ecc:12;		//!< tag ECC
};
*/
static int nand_write_pagewlayout(uffs_Device *dev, u32 block, u32 page, const u8 *data, int data_len, const u8 *ecc, const uffs_TagStore *ts)
{
	u8 val = 0;
	int ret = UFFS_FLASH_NO_ERR;
	UBOOL fall_through = FALSE;

	u8 spare[PAGE_SPARE_SIZE];

	//MSG("NW b:%ld, p:%ld\n", block, page);
#ifdef SHOW_LOW_ACCESS
	Total_Nand_write++;
#endif
	CHIP_CLR_NCS(dev);

	if (data && data_len > 0) {
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		WRITE_COMMAND(dev, NAND_CMD_SEQIN);
		CHIP_CLR_CLE(dev);
		CHIP_SET_ALE(dev);
		WRITE_DATA_ADDR(dev, block, page, 0);
		CHIP_CLR_ALE(dev);
		CHIP_BUSY(dev);
		if (data_len == PAGE_DATA_SIZE){
#ifdef MOD_FAST
			WRITE_DATA_FAST(dev, data, data_len);
#else
			WRITE_DATA(dev, data, data_len);
#endif
		}
		else {
			WRITE_DATA(dev, data, data_len);
		}
		if (data_len == dev->attr->page_data_size)
			fall_through = U_TRUE;
		else {
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_PAGEPROG);
			CHIP_CLR_CLE(dev);
			CHIP_READY(dev);
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_STATUS);
			CHIP_CLR_CLE(dev);
			READ_DATA(dev, &val, 1);
			ret = PARSE_STATUS(val);
		}
	}

	if (ret != UFFS_FLASH_NO_ERR)
		goto ext;

	if (ts) {
		if (!fall_through) {
			CHIP_SET_CLE(dev);
			WRITE_COMMAND(dev, NAND_CMD_READ0);
			WRITE_COMMAND(dev, NAND_CMD_SEQIN);
			CHIP_CLR_CLE(dev);
			CHIP_SET_ALE(dev);
			WRITE_DATA_ADDR(dev, block, page, dev->attr->page_data_size);
			CHIP_CLR_ALE(dev);
			CHIP_BUSY(dev);
		}
		memset(spare, 0xff, PAGE_SPARE_SIZE); // keep unused bytes to 0xff
		tag2spare(spare, ts);
		spare[SEALED_BYTE] = 0; // seal it
		/*
		if (page == 0){
			MSG("NW b:%ld, p:%ld\n", block, page);
			MSG("ts->dirty:%08X\n", ts->dirty);
			MSG("ts->valid:%08X\n", ts->valid);
			MSG("ts->type:%08X\n", ts->type);
			MSG("ts->block_ts:%08X\n", ts->block_ts);
			MSG("ts->data_len:%08X\n", ts->data_len);
			MSG("ts->serial:%08X\n", ts->serial);
			MSG("ts->parent:%08X\n", ts->parent);
			MSG("ts->page_id:%08X\n", ts->page_id);
			MSG("ts->reserved:%08X\n", ts->reserved);
			MSG("ts->tag_ecc:%08X\n", ts->tag_ecc);
			MSG("W %02x, %02x, %02x, %02x\n", spare[4], spare[5], spare[6], spare[7]);
			MSG("W %02x, %02x, %02x, %02x\n", spare[0x14], spare[0x15], spare[0x16], spare[0x17]);
			MSG("W %02x, %02x, %02x, %02x\n", spare[0x24], spare[0x25], spare[0x26], spare[0x27]);
			MSG("W %02x, %02x\n", spare[0x34], spare[0x35]);
		}
		*/
#ifdef MOD_FAST
		WRITE_DATA_FAST_SPARE(dev, spare, dev->attr->spare_size);
#else
		WRITE_DATA(dev, spare, dev->attr->spare_size);
#endif
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_PAGEPROG);
		CHIP_CLR_CLE(dev);
		CHIP_READY(dev);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_STATUS);
		CHIP_CLR_CLE(dev);
		READ_DATA(dev, &val, 1);
		ret = PARSE_STATUS(val);
	}

	if (data == NULL && ts == NULL) {
		// mark bad block
		MSG("mark bad block:%ld, page:%ld\n", block, page);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		WRITE_COMMAND(dev, NAND_CMD_SEQIN);
		CHIP_CLR_CLE(dev);
		CHIP_SET_ALE(dev);
		WRITE_DATA_ADDR(dev, block, page, dev->attr->page_data_size + dev->attr->block_status_offs);
		CHIP_CLR_ALE(dev);
		CHIP_BUSY(dev);
		val = 0;
		WRITE_DATA(dev, &val, 1);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_PAGEPROG);
		CHIP_CLR_CLE(dev);
		CHIP_READY(dev);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_STATUS);
		CHIP_CLR_CLE(dev);
		READ_DATA(dev, &val, 1);
		ret = PARSE_STATUS(val);
	}
ext:
	CHIP_SET_NCS(dev);

	return ret;
}

static int nand_check_erased_block(uffs_Device *dev, u32 block)
{
	u32 page;
	u8 status;
	int ret = UFFS_FLASH_NO_ERR;

	u8 sealed;
	//MSG("nand_check_erased_block CS:%d block:%ld\n", dev->dev_num, block);

	CHIP_CLR_NCS(dev);
#ifdef SHOW_LOW_ACCESS
	Total_Nand_check++;
#endif
	for (page = 0; page < dev->attr->pages_per_block; page++) {
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		CHIP_CLR_CLE(dev);
		CHIP_SET_ALE(dev);
		WRITE_DATA_ADDR(dev, block, page, dev->attr->page_data_size + SEALED_BYTE); // only sealed byte
		CHIP_CLR_ALE(dev);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ1);
		CHIP_CLR_CLE(dev);
		CHIP_READY(dev);

		// read status
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_STATUS);
		CHIP_CLR_CLE(dev);
		READ_DATA(dev, &status, 1);
		CHIP_SET_CLE(dev);
		WRITE_COMMAND(dev, NAND_CMD_READ0);
		CHIP_CLR_CLE(dev);
		// read data
		if ((status & 1) == 1) {
			MSG("read ts status failed status:%08X\n",status);
			ret  = UFFS_FLASH_ECC_FAIL;
			goto check_out;
		}

		READ_DATA(dev, &sealed, 1);
		if (sealed != 0xFF){
			MSG("WARNING nand_check_erased_block detected\n");
			ret = -1;
			break;
		}
	}

check_out:
	CHIP_SET_NCS(dev);

	return ret;
}

static int nand_erase_block(uffs_Device *dev, u32 block)
{
	u8 val = 0;
	int ret = UFFS_FLASH_NO_ERR;
	//MSG("E b:%ld\n",block);
#ifdef SHOW_LOW_ACCESS
	Total_Nand_erase++;
#endif
	CHIP_CLR_NCS(dev);

	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_ERASE1);
	CHIP_CLR_CLE(dev);
	CHIP_SET_ALE(dev);
	WRITE_ERASE_ADDR(dev, block);
	CHIP_CLR_ALE(dev);
	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_ERASE2);
	CHIP_CLR_CLE(dev);
	CHIP_READY(dev);
	CHIP_SET_CLE(dev);
	WRITE_COMMAND(dev, NAND_CMD_STATUS);
	CHIP_CLR_CLE(dev);
	READ_DATA(dev, &val, 1);

	CHIP_SET_NCS(dev);
	ret = PARSE_STATUS(val);

	return ret;
}


static int nand_init_flash(uffs_Device *dev)
{
	// initialize your hardware here ...
	struct my_nand_chip *chip = (struct my_nand_chip *) dev->attr->_private;

	if (!chip->inited) {
		// setup chip I/O address, setup NAND flash controller ... etc.
		// chip->IOR_ADDR = 0xF0000000
		// chip->IOW_ADDR = 0xF0000000
		chip->inited = U_TRUE;
	}
	return 0;
}

static int nand_release_flash(uffs_Device *dev)
{
	// release your hardware here
	struct my_nand_chip *chip = (struct my_nand_chip *) dev->attr->_private;
	//TBD why?
	chip = chip;

	return 0;
}

#ifndef PERFORMANCE_LOW
/* static alloc the memory for each partition
 * memory is allocated for the biggest number of TOTAL_BLOCKS for all models*/
static int static_buffer_par[MAX_NR_PARTITION][UFFS_STATIC_BUFF_SIZE(PAGES_PER_BLOCK, PAGE_SIZE, MT29F16G08AJADAWP_TOTAL_BLOCKS) / sizeof(int)];


#if 0 // not used
static void init_nand_chip(struct my_nand_chip *chip)
{
	// init chip IO address, etc.
}
#endif

static URET my_InitDevice(uffs_Device *dev)
{
	dev->attr = &g_my_flash_storage;				// NAND flash attributes
	//set dev_idx
	unsigned int dev_idx = dev_num_to_idx(dev->dev_num);

	dev->attr->_private = (void *) &g_nand_chip[dev_idx]; // hook nand_chip data structure to attr->_private

	dev->ops = &g_my_nand_ops;						// NAND driver

	//init_nand_chip(&g_nand_chip);
    
	return U_SUCC;
}

static URET my_ReleaseDevice(uffs_Device *dev)
{
	return U_SUCC;
}
#endif

#ifndef PERFORMANCE_LOW
static int my_init_filesystem(void)
{

	/* setup nand storage attributes */
	setup_flash_storage(&g_my_flash_storage);
	const u32 total_blocks_in_one_ce = g_my_flash_storage.total_blocks/gpflash_intf_struct->nr_partition;
	//const u32 total_blocks_in_one_ce = g_my_flash_storage.total_blocks;
	for (unsigned int i = 0; i <  gpflash_intf_struct->nr_partition; i++) {
      /* Configure start_block */
      demo_mount_table[i].start_block = 0;
	   /* Configure end_block */
	   demo_mount_table[i].end_block = total_blocks_in_one_ce-1;
	   /* setup memory allocator */
	   uffs_MemSetupStaticAllocator(&demo_device[i].mem, static_buffer_par[i], UFFS_STATIC_BUFF_SIZE(PAGES_PER_BLOCK, PAGE_SIZE, total_blocks_in_one_ce));

	}
	/* register mount table */
	for (unsigned int i = 0; i <  gpflash_intf_struct->nr_partition; i++) {
      demo_mount_table[i].dev->Init = my_InitDevice;
      demo_mount_table[i].dev->Release = my_ReleaseDevice;
      uffs_RegisterMountTable(&(demo_mount_table[i]));
	}
	// mount partitions
	for (unsigned int i = 0; i <  gpflash_intf_struct->nr_partition; i++) {
      uffs_Mount(demo_mount_table[i].mount);
	}

	return uffs_InitFileSystemObjects() == U_SUCC ? 0 : -1;
}
#endif

static int my_release_filesystem(void)
{
	int ret = 0;

	// unmount partions
	for (unsigned int i = 0; i <  gpflash_intf_struct->nr_partition; i++) {
	   ret = uffs_UnMount(demo_mount_table[i].mount);
	}
	// release objects
	if (ret == 0)
		ret = (uffs_ReleaseFileSystemObjects() == U_SUCC ? 0 : -1);

	return ret;
}


static inline int flash_intf_setMountPoints(struct flash_intf_struct* flashIntfCtrl) {

   int ret = U_SUCC;

   switch ( flashIntfCtrl->nr_partition)
   {
      case 2 :
         strncpy(flashIntfCtrl->mount_points[1],FM_UFFS_MOUNT_POINT_1,FM_UFFS_MOUNT_POINT_SIZE);
         flashIntfCtrl->mount_points[1][FM_UFFS_MOUNT_POINT_SIZE] = '\0';
         /*no break*/
      case 1 :
         strncpy(flashIntfCtrl->mount_points[0],FM_UFFS_MOUNT_POINT_0,FM_UFFS_MOUNT_POINT_SIZE);
         flashIntfCtrl->mount_points[0][FM_UFFS_MOUNT_POINT_SIZE] = '\0';
         break;

      default:
         printf("ERROR current nr partition doesn t handle !\n");
         flashIntfCtrl->nr_partition = 1;
         strncpy(flashIntfCtrl->mount_points[0],FM_UFFS_MOUNT_POINT_0,FM_UFFS_MOUNT_POINT_SIZE);

         ret = U_FAIL;
         break;

   }

   return ret;
}


#ifdef PERFORMANCE_LOW

static u8 buflarge[2500];
//static u8 buflarge2[2500];
// write directly to nand to test performance (not using UFFS)
int performance_low(void)
{
	int ret = 0, i;
#if 1
	//u8 ecc_store;
	u32 block, page;
	uffs_Device dev;
	setup_flash_storage(&g_my_flash_storage);
	dev.attr = &g_my_flash_storage;					// NAND flash attributes
	dev.dev_num = 1;
	struct uffs_TagStoreSt ts = {0x00};
	int data_len = 2048;
	//printf("page_data_size:%d\n", dev.attr->page_data_size);
#if 0		// test HW ECC status detection
	printf("Start HW ECC test\n");
	block = 0;
	page = 0;
#if 0
	memset(buflarge, 0xff, 2048);
	buflarge[0] = 0xaa;
	ret = nand_write_pagewlayout(&dev, block, page, buflarge, data_len, NULL, &ts);
	if (ret){
		printf("Test write failed\n");
		return 1;
	}
	buflarge[0] = 0x55;
	ret = nand_write_pagewlayout(&dev, block, page, buflarge, data_len, NULL, &ts);
	if (ret){
		printf("Test write failed\n");
		return 1;
	}
#endif
#if 1
	ret = nand_read_pagewlayout(&dev, block, page, buflarge, data_len, NULL, &ts, NULL);
	if (ret){
		printf("Test read failed\n");
		return 1;
	}
	printf("End HW ECC test\n");
#endif
#endif // test HW ECC status detection
#if 1
	printf("Start erase test direct\n");
	//for (block = 200; block < 280; block++) {		// Start from 200 to avoid known bad block
	for (block = 200; block < 520; block++) {		// Start from 200 to avoid known bad block 40Mb
	//for (block = 200; block < 840; block++) {		// Start from 200 to avoid known bad block 80Mb
		nand_erase_block(&dev, block);
	}
	printf("End erase test direct\n");
#endif
#if 1
	//memset(buflarge, 0, 2048);
	for (i = 0; i < data_len; i++){
		buflarge[i] = i;
	}
	printf("Start write test direct\n");
	// for 10 MB
	//for (block = 200; block < 280; block++) {		// Start from 200 to avoid known bad block
	for (block = 200; block < 520; block++) {		// Start from 200 to avoid known bad block 40Mb
	//for (block = 200; block < 840; block++) {		// Start from 200 to avoid known bad block 80Mb
		//MSG("%ld,", block);
		for (page = 0; page< 64; page++){
			ret = nand_write_pagewlayout(&dev, block, page, buflarge, data_len, NULL, &ts);
			if (ret){
				printf("Test write failed\n");
				return 1;
			}
		}
	}
	printf("End write test direct\n");
#endif
#if 1
	printf("Start read test direct\n");
	//for (block = 200; block < 280; block++) {		// Start from 200 to avoid known bad block
	//for (block = 200; block < 840; block++) {		// Start from 200 to avoid known bad block 80Mb
	for (block = 200; block < 520; block++) {		// Start from 200 to avoid known bad block 40Mb
	//for (block = 200; block < 280; block++) {		// Start from 200 to avoid known bad block 10Mb
		//printf("%ld,", block);
		for (page = 0; page< 64; page++){
			ret = nand_read_pagewlayout(&dev, block, page, buflarge, data_len, NULL, &ts, NULL);
			if (ret){
				if (ret != UFFS_FLASH_NOT_SEALED){
					printf("Test read failed\n");
					return 1;
				}
			}
#if 0
			for (i = 0; i < data_len; i++){
				if (buflarge[i] != (i&0xff)) {
					printf("Compare error @:%d, got:%02x, want:%02x\n", i, buflarge[i], i);
					return 1;
				}
			}
#endif
#if 0
			ret = nand_read_pagewlayout(&dev, block, page, buflarge2, data_len, NULL, &ts, &ecc_store); // use ecc_store as a flag to enable non fast data read
			if (ret){
				if (ret != UFFS_FLASH_NOT_SEALED){
					printf("Test read failed\n");
					return 1;
				}
			}
			for (i = 0; i < data_len; i++){
				if (buflarge[i] != buflarge2[i]){
					printf("Compare error @:%d, fast:%02x, slow:%02x\n", i, buflarge[i], buflarge2[i]);
					return 1;
				}
			}
#endif
		}
	}
	printf("End read test direct\n");
#endif
#endif
	return ret;
}
#endif

#ifdef LOW_FORMAT
extern int nand_erase_block(uffs_Device *dev, u32 block);

// only to restore NAND after some dirty tests (block 100 & 101 & 4196 & 4197 are manuf bad)
void nand_low_format()
{
	u32 block;
	uffs_Device dev;
	setup_flash_storage(&g_my_flash_storage);
	dev.attr = &g_my_flash_storage;					// NAND flash attributes
	dev.ops = &g_my_nand_ops;						// NAND driver
	dev.dev_num = 1;
	for (block = 0; block < g_my_flash_storage.total_blocks; block++){
		if ((block != 100) && (block != 101) && (block != 4196) && (block != 4197)) {
			nand_erase_block(&dev, block);
		}
	}
	if (g_my_nand_model == MT29F16G08AJADAWP)    //only this model has 2 CS
	{
      dev.dev_num = 2;
      for (block = 0; block < g_my_flash_storage.total_blocks; block++){
         if ((block != 100) && (block != 101) && (block != 4196) && (block != 4197)) {
            nand_erase_block(&dev, block);
         }
      }
	}
}
#endif


// iStep 0;  init UFFS file system
// iStep 99; release
// ret: 0 succes, != 0 failed.
int uffs_main(flashIntfCtrl_t* flashIntfCtrl,int iStep)
{
	const u8 features_data[] = {0x08,0,0,0};
   int ret = 0;

   if(flashIntfCtrl == NULL) {
      print("ERROR flashIntfCtrl is null\n\r");
      return -1;
   }
   gpflash_intf_struct = flashIntfCtrl;
   //print DEBUG
   //uffs_SetupDebugOutput();
	switch (iStep){
	case 0:
		FlashIntf_Init(&Flash_Interface);
		initGpioInterface();				// must be done first
		uffs_Device dev;					// declare dev only for nand_readid & feature
		dev.dev_num = 1;
		ret = nand_readid(&dev);
		if (ret) {
			print("ERROR NAND ID\n\r");
			break;
		}
		//reset others dies has mentionned in the datasheet
		if(gpflash_intf_struct->nand_model == MT29F16G08AJADAWP) {
	      dev.dev_num = 2;
	      ret = nand_readid(&dev);
	      dev.dev_num = 1;
		}
		// Set features of Array Operation Mode
		nand_set_features(&dev, 0x90, features_data);
		ret = nand_get_features(&dev, 0x90, features_data);
		if (ret) {
			print("ERROR features HW ECC0\n\r");
			break;
		}
      //Set others dies
      if(gpflash_intf_struct->nand_model == MT29F16G08AJADAWP) {
         dev.dev_num = 2;
         nand_set_features(&dev, 0x90, features_data);
         ret = nand_get_features(&dev, 0x90, features_data);
         if (ret) {
            print("ERROR features HW ECC1\n\r");
            break;
         }
      }
#ifdef LOW_FORMAT
		nand_low_format();					// only for Nand driver development
#endif
#ifdef PERFORMANCE_LOW
		performance_low();					// only for Nand driver development
		ret = 1; // force error
#else
		ret = my_init_filesystem();
#endif
		ret = flash_intf_setMountPoints(flashIntfCtrl);

		break;
	case 99:
		ret = my_release_filesystem();
	break;
	}
	MSG("uffs_main ret:%d\n", ret);

	return ret;
}

