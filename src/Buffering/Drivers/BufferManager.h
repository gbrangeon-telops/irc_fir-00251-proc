/**
 * @file BufferManager.h
 * 
 * Buffer Manager control the start stop of the buffering mode and the sequence reading and deleting command
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL: $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef BUFFERMANAGER_H
#define BUFFERMANAGER_H

#include "GC_Registers.h"
#include "IRC_Status.h"
#include "mb_axi4l_bridge.h"
#include "tel2000_param.h"
#include "verbose.h"
#include <stdint.h>

#ifdef BUFFERING_VERBOSE
   #define BUFFERING_PRINTF(fmt, ...)    FPGA_PRINTF("BUF: " fmt, ##__VA_ARGS__)
#else
   #define BUFFERING_PRINTF(fmt, ...)    DUMMY_PRINTF("BUF: " fmt, ##__VA_ARGS__)
#endif

#define BUFFERING_ERR(fmt, ...)          FPGA_PRINTF("BUF: Error: " fmt "\n", ##__VA_ARGS__)
#define BUFFERING_INF(fmt, ...)          FPGA_PRINTF("BUF: Info: " fmt "\n", ##__VA_ARGS__)
#define BUFFERING_DBG(fmt, ...)          BUFFERING_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)



// DEFINE CONSTANT PARAMTER HERE
#define BUF_MAX_SEQUENCE 		255
#define BUF_BASE_ADDR_OFFSET	0x10000000

//BUFFER CTRL ADDRESS MAP
#define BM_BASE_ADDR 			0x0
#define NB_SEQUENCE_MAX			0x4		//SEQUENCE
#define BM_NB_IMG_PER_SEQ 		0x8		//IMAGES
#define BM_FRAME_SIZE 			0xC		//pIXEL
#define BM_BUFFER_MODE			0x10	//BM_OFF - BMWRITE - BMREAD
#define BM_HDR_SIZE 	         0x14		//BYTES
#define BM_IMG_SIZE           0x18		//BYTES
#define BM_NB_IMG_PRE 			0x1C	//PRE = 0 -> no PREMOI
#define BM_NB_IMG_POST 			0x20	//NB image including MOI to the end
#define BM_READ_SEQUENCE_ID 	0x24	//READ seq ID
#define BM_READ_START_ID		0x28	//READ Start image ID(in buffer memory)
#define BM_READ_STOP_ID			0x2C	//READ STOP image ID(in buffer memory)
#define BM_CLEAR_MEMORY			0x30	//Pulse to clear memory
#define BM_SWITCH_CONFIG		0x34	//BM_OFF = 0,BM INTERNAL = 1, BUFFER EXTERNE = 2
#define BM_MOI_SOURCE			0x38	//External MOI = 0, Software MOI =1, No MOI = 2
#define BM_MOI_ACTIVATION		0x3C	//Rising = 0, Falling = 1, Any edge = 2
#define BM_SOFT_MOI_SIG			0X40	//Pulse to generate a Software MOI
#define BM_ACQ_STOP				0X44	//When acquisition is stop assert this signal.
#define BM_CONFIG_VALID			0x48	//Hold at 1 when valid. Do not change param when valid

#define BM_NB_SEQ_IN_MEM		0x4C	//Return number of sequence int the buffer
#define BM_WRITE_ERR 			0x50	// Return write error (Not implemented yet)
#define BM_READ_ERR 	         0x54	// Return read error (Not implemented yet)
#define BM_EXT_BUF_PRSNT      0x58  //Return number of sequence int the buffer
#define BM_MIN_FRAME_TIME     0x5C  //Configure frame duration in read mode

#define BT_START_IMG_OFFSET		0
#define BT_MOI_IMG_OFFSET		1
#define BT_END_IMG_OFFSET		2

// Struct Definition
/**
 * BUFFER MANAGER STRUCT
 */
struct s_bufferManagerStruct {
	uint32_t SIZE;                     // Number of config elements, excluding SIZE and ADD.
	uint32_t ADD;

	uint32_t Buffer_base_addr;
	uint32_t nbSequenceMax;
	uint32_t nbImagePerSeq;
	uint32_t FrameSize;
	uint32_t BufferMode;
	uint32_t HDR_Size;
	uint32_t IMG_Size;
	uint32_t nb_img_pre; //exluding MOI
	uint32_t nb_img_post; //including MOI
	uint32_t rd_sequence_id;
	uint32_t rd_start_img; 	
	uint32_t rd_stop_img;
	uint32_t clear_memory;
	uint32_t switchConfig;
	uint32_t moiSource;
	uint32_t moiActivation;
	uint32_t soft_moi;
	uint32_t acq_stop;
	uint32_t ConfigValid;

};
typedef struct s_bufferManagerStruct t_bufferManager;

//Buffer Mode
enum BufferMode_enum {
   BM_OFF = 0,
   BM_WRITE = 1,
   BM_READ = 2/*,
   BM_SILENT_WRITE = 3 // (not used) to be used by actualisation*/
};
typedef enum BufferMode_enum t_bufferMode;

//Switch Configuration
enum BM_Switch_enum {
	BM_SWITCH_EXTERNAL_LIVE,
	BM_SWITCH_EXTERNAL_PLAYBACK,
	BM_SWITCH_INTERNAL_LIVE,
	BM_SWITCH_INTERNAL_PLAYBACK,
};
typedef enum BM_Switch_enum t_bufferSwitch;

enum BM_MOI_SRC_enum {
   BM_EXTERNAL_MOI,
   BM_SOFTARE_MOI,
   BM_NO_MOI
};
typedef enum BM_MOI_SRC_enum t_bufferMoiSrc;

enum BM_MOI_Activation_enum {
   RISING_EDGE,
   FALLING_EDGE,
   ANY_EDGE
};
typedef enum BM_MOI_Activation_enum t_bufferMoiActivation;

struct s_bufferTable {
	uint32_t start_img;
	uint32_t moi_img;
	uint32_t stop_img;
};
typedef struct s_bufferTable t_bufferTable;

typedef enum
{
   BMS_IDLE = 0,
   BMS_CFG,
   BMS_READ,
   BMS_WAIT,
   BMS_DONE
} bmState_t;


/***************** Macros (Inline Functions) Definitions ********************/
#define Buffering_Intf_Ctor(add) {sizeof(t_bufferManager)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

#define BufferManager_DetectExternalMemoryBuffer() (AXI4L_read32(TEL_PAR_TEL_BUFFERING_CTRL_BASEADDR + BM_EXT_BUF_PRSNT) != 0)

// Fonction definition
IRC_Status_t BufferManager_Init(t_bufferManager *pBufferCtrl, gcRegistersData_t *pGCRegs);
void BufferManager_SendSoftwareMoi(t_bufferManager *pBufferCtrl);
t_bufferTable BufferManager_ReadBufferTable(uint32_t SequenceID);
void BufferManager_ReadSequence(t_bufferManager *pBufferCtrl, 	const gcRegistersData_t *pGCRegs);
void BufferManager_ReadImage(t_bufferManager *pBufferCtrl, 	const gcRegistersData_t *pGCRegs);
void BufferManager_ClearSequence(t_bufferManager *pBufferCtrl, 	const gcRegistersData_t *pGCRegs);
void BufferManager_EnableBuffer(t_bufferManager *pBufferCtrl);
void BufferManager_DisableBuffer(t_bufferManager *pBufferCtrl);
void BufferManager_SetBufferMode(t_bufferManager *pBufferCtrl,t_bufferMode Mode , const gcRegistersData_t *pGCRegs );
void BufferManager_SetSwitchConfig(t_bufferManager *pBufferCtrl, t_bufferSwitch config);
void BufferManager_SetMoiConfig(t_bufferManager *pBufferCtrl);
void BufferManager_SetSequenceParams(t_bufferManager *pBufferCtrl, const gcRegistersData_t *pGCRegs );


uint32_t BufferManager_GetFrameId(t_bufferManager *pBufferCtrl, uint32_t SequenceID, uint32_t ImageLocation);
uint32_t BufferManager_GetBufferSize(t_bufferManager *pBufferCtrl);
uint32_t BufferManager_GetNbImageMax(t_bufferManager *pBufferCtrl, const gcRegistersData_t *pGCRegs);
uint32_t BufferManager_GetNumberOfSequenceMax();
uint32_t BufferManager_GetNumSequenceCount(t_bufferManager *pBufferCtrl);
uint32_t BufferManager_GetSequenceFirstFrameId(t_bufferManager *pBufferCtrl, uint32_t SequenceID);
uint32_t BufferManager_GetSequenceMOIFrameId(t_bufferManager *pBufferCtrl, uint32_t SequenceID);
uint32_t BufferManager_GetSequenceLength(t_bufferManager *pBufferCtrl, uint32_t SequenceID);

uint32_t BufferManager_ReturnNumberOfImagePost(t_bufferManager *pBufferCtrl);

extern bool gBufferStartDownloadTrigger;
extern bool gBufferStopDownloadTrigger;
void BufferManager_SM();
void BufferManager_ConfigureMinFrameTime(t_bufferManager *pBufferCtrl, float time_us);
void BufferManager_AcquisitionStop(t_bufferManager *pBufferCtrl, bool flag);



#endif // BUFFERMANAGER_H
