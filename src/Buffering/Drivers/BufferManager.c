/**
 * @file BufferManager.c
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

#include "BufferManager.h"
#include "xparameters.h"
#include "tel2000_param.h"
#include "xil_io.h"
#include "irc_status.h"
#include "utils.h"
#include "IRCamHeader.h"
#include "mb_axi4l_bridge.h"
#include "proc_memory.h"


IRC_Status_t BufferManager_Init(t_bufferManager *pBufferCtrl, gcRegistersData_t *pGCRegs)
{

	pBufferCtrl->Buffer_base_addr = PROC_MEM_MEMORY_BUFFER_BASEADDR; //DDR Base ADDR + Buffer location offset
	pBufferCtrl->nbSequenceMax = 1;
	pBufferCtrl->FrameSize = pGCRegs->Width*(pGCRegs->Height+2); // In pixel
	pBufferCtrl->HDR_Size = pGCRegs->Width*4; // In bytes
	pBufferCtrl->IMG_Size = pGCRegs->Width*pGCRegs->Height*2; // In bytes
	pBufferCtrl->nbImagePerSeq = BufferManager_GetNbImageMax(pBufferCtrl,pGCRegs);
	pBufferCtrl->BufferMode = BM_OFF;
	pBufferCtrl->nb_img_pre = 0;
	pBufferCtrl->nb_img_post = pBufferCtrl->nbImagePerSeq;
	pBufferCtrl->rd_sequence_id = 0;
	pBufferCtrl->rd_start_img = 0;
	pBufferCtrl->rd_stop_img = 0;
	pBufferCtrl->clear_memory = 0;
	pBufferCtrl->switchConfig = BM_SWITCH_INTERNAL_LIVE;
	pBufferCtrl->moiSource = BM_SOFTARE_MOI;
	pBufferCtrl->moiActivation = RISING_EDGE;
	pBufferCtrl->soft_moi = 0;
	pBufferCtrl->acq_stop = 0;
	pBufferCtrl->ConfigValid = 0;
	WriteStruct(pBufferCtrl);

	BUFFERING_INF("Init");
	return IRC_SUCCESS;

}

t_bufferTable BufferManager_ReadBufferTable(uint32_t SequenceID)
{
	t_bufferTable SequenceTable;

	SequenceTable.start_img =  AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_START_IMG_OFFSET);
	SequenceTable.moi_img 	=  AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_MOI_IMG_OFFSET);
	SequenceTable.stop_img 	=  AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_END_IMG_OFFSET);

	BUFFERING_INF("ReadBufferTable");
	return SequenceTable;
}

void BufferManager_ReadSequence(t_bufferManager *pBufferCtrl, 	const gcRegistersData_t *pGCRegs)
{
	t_bufferTable SequenceTable;

	BufferManager_DisableBuffer(pBufferCtrl);
	pBufferCtrl->rd_sequence_id = pGCRegs->MemoryBufferSequenceSelector;

	SequenceTable = BufferManager_ReadBufferTable(pBufferCtrl->rd_sequence_id);

	pBufferCtrl->rd_start_img = SequenceTable.start_img;
	pBufferCtrl->rd_stop_img = SequenceTable.stop_img;

	AXI4L_write32(pBufferCtrl->rd_sequence_id, 	pBufferCtrl->ADD + BM_READ_SEQUENCE_ID);
	AXI4L_write32(pBufferCtrl->rd_start_img, 	pBufferCtrl->ADD + BM_READ_START_ID);
	AXI4L_write32(pBufferCtrl->rd_stop_img, 	pBufferCtrl->ADD + BM_READ_STOP_ID);

	//BufferManager_EnableBuffer(pBufferCtrl); // workaround : on doit laisser un peu de temps à la config avant de la réactiver
	BUFFERING_INF("ReadSequence");

}

void BufferManager_ReadImage(t_bufferManager *pBufferCtrl, 	const gcRegistersData_t *pGCRegs)
{
	t_bufferTable SequenceTable;
	uint32_t firstFrameId;
	uint32_t img_offset;
	uint32_t download_img_loc;

	BufferManager_DisableBuffer(pBufferCtrl);
	pBufferCtrl->rd_sequence_id = pGCRegs->MemoryBufferSequenceSelector;

	//Get the buffertable of the sequence
	SequenceTable = BufferManager_ReadBufferTable(pBufferCtrl->rd_sequence_id);

	//Get the firstFrameId
	firstFrameId = BufferManager_GetSequenceFirstFrameId(pBufferCtrl, pBufferCtrl->rd_sequence_id);

	//Get the image location of the RequieredimageFrameID
	img_offset = pGCRegs->MemoryBufferSequenceDownloadImageFrameID - firstFrameId;

	//Find the location of the frame id (modulo to rollover the circular buffer)
	download_img_loc = (img_offset + SequenceTable.start_img) % pBufferCtrl->nbImagePerSeq;


	pBufferCtrl->rd_start_img = download_img_loc;
	pBufferCtrl->rd_stop_img = download_img_loc;

	AXI4L_write32(pBufferCtrl->rd_sequence_id, 	pBufferCtrl->ADD + BM_READ_SEQUENCE_ID);
	AXI4L_write32(pBufferCtrl->rd_start_img, 	pBufferCtrl->ADD + BM_READ_START_ID);
	AXI4L_write32(pBufferCtrl->rd_stop_img, 	pBufferCtrl->ADD + BM_READ_STOP_ID);

	//BufferManager_EnableBuffer(pBufferCtrl); // workaround : on doit laisser un peu de temps à la config avant de la réactiver
	BUFFERING_INF("ReadImage");
}

bool gBufferClearedTrigger = false;
void BufferManager_ClearSequence(t_bufferManager *pBufferCtrl, 	const gcRegistersData_t *pGCRegs)
{
	BufferManager_DisableBuffer(pBufferCtrl);

	pBufferCtrl->clear_memory = 1;
	AXI4L_write32(pBufferCtrl->clear_memory, 		pBufferCtrl->ADD + BM_CLEAR_MEMORY);

	pBufferCtrl->clear_memory = 0;
	AXI4L_write32(pBufferCtrl->clear_memory, 		pBufferCtrl->ADD + BM_CLEAR_MEMORY);

	if (pBufferCtrl->BufferMode == BM_WRITE)  // Do not enable in read mode wait for ACQ_Start
      BufferManager_EnableBuffer(pBufferCtrl);
	BUFFERING_INF("ClearSequence");

	gBufferClearedTrigger = true;
}

void BufferManager_EnableBuffer(t_bufferManager *pBufferCtrl)
{
	pBufferCtrl->ConfigValid = 1;
	AXI4L_write32(pBufferCtrl->ConfigValid, pBufferCtrl->ADD + BM_CONFIG_VALID);
	BUFFERING_INF("EnableBuffer");
}

void BufferManager_DisableBuffer(t_bufferManager *pBufferCtrl)
{
	pBufferCtrl->ConfigValid = 0;
	AXI4L_write32(pBufferCtrl->ConfigValid, pBufferCtrl->ADD + BM_CONFIG_VALID);
//	pBufferCtrl->BufferMode = BM_OFF;
//	AXI4L_write32(pBufferCtrl->BufferMode, pBufferCtrl->ADD + BM_BUFFER_MODE);

	BUFFERING_INF("DisableBuffer");
}


uint32_t BufferManager_GetBufferSize(t_bufferManager *pBufferCtrl)
{
	BUFFERING_INF("GetBufferSize");

	return PROC_MEM_MEMORY_BUFFER_SIZE; // in bytes
}

uint32_t BufferManager_GetNbImageMax(t_bufferManager *pBufferCtrl, const gcRegistersData_t *pGCRegs){

	BUFFERING_INF("GetNbImageMax");

	return  BufferManager_GetBufferSize(pBufferCtrl) / (pGCRegs->Width * (pGCRegs->Height+2) *2);
}

uint32_t BufferManager_GetNumSequenceCount(t_bufferManager *pBufferCtrl)
{
	 return AXI4L_read32( pBufferCtrl->ADD + BM_NB_SEQ_IN_MEM );
}

uint32_t BufferManager_GetFrameId(t_bufferManager *pBufferCtrl, uint32_t SequenceID, uint32_t ImageLocation)
{
	uint32_t FrameID;
	uint32_t readAddrLoc;

	//readAddrLoc = BaseAddr + sequence offset + image offset + FrameIdReg offset
	readAddrLoc = pBufferCtrl->Buffer_base_addr + (SequenceID * (pBufferCtrl->FrameSize * 2 * pBufferCtrl->nbImagePerSeq)) + (ImageLocation * pBufferCtrl->FrameSize * 2) + FrameIDHdrAddr; // frame size is in pixel
	FrameID = AXI4L_read32(readAddrLoc);

	BUFFERING_INF("GetFrameId");

	return FrameID;
}

uint32_t BufferManager_GetSequenceFirstFrameId(t_bufferManager *pBufferCtrl, uint32_t SequenceID)
{
	uint32_t ImageLoc, FrameId;

	ImageLoc = AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_START_IMG_OFFSET);

	FrameId = BufferManager_GetFrameId(pBufferCtrl, SequenceID, ImageLoc);

	BUFFERING_INF("GetSequenceFirstFrameId");

	return FrameId;

}

uint32_t BufferManager_GetSequenceMOIFrameId(t_bufferManager *pBufferCtrl, uint32_t SequenceID)
{
	uint32_t ImageLoc, FrameId;

	ImageLoc = AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_MOI_IMG_OFFSET);

	FrameId = BufferManager_GetFrameId(pBufferCtrl, SequenceID, ImageLoc);

	BUFFERING_INF("GetSequenceMOIFrameId");

	return FrameId;
}

uint32_t BufferManager_GetSequenceLength(t_bufferManager *pBufferCtrl, uint32_t SequenceID)
{
	t_bufferTable SequenceTable;
	uint32_t SequenceLength;

	SequenceTable.start_img =  AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_START_IMG_OFFSET);
	SequenceTable.stop_img 	=  AXI4L_read32( TEL_PAR_TEL_BUFTABLE_BASEADDR + SequenceID*4 + BT_END_IMG_OFFSET);

	if(SequenceTable.start_img > SequenceTable.stop_img ) // Buffer Wrap
	{
		SequenceLength = pBufferCtrl->nbImagePerSeq - SequenceTable.start_img + SequenceTable.stop_img + 1;
	}
	else
	{
		SequenceLength = SequenceTable.stop_img - SequenceTable.start_img + 1;
	}

	BUFFERING_INF("GetSequenceLength");
	return SequenceLength;
}

void BufferManager_SetBufferMode(t_bufferManager *pBufferCtrl,t_bufferMode Mode , const gcRegistersData_t *pGCRegs )
{
	BufferManager_DisableBuffer(pBufferCtrl);

	// Set control values
   pBufferCtrl->BufferMode = Mode;
	pBufferCtrl->nbSequenceMax = pGCRegs->MemoryBufferNumberOfSequences;
	pBufferCtrl->FrameSize = pGCRegs->Width*(pGCRegs->Height+2); // In pixel
	pBufferCtrl->HDR_Size = pGCRegs->Width*4; // In bytes
	pBufferCtrl->IMG_Size = pGCRegs->Width*pGCRegs->Height*2; // In bytes
	pBufferCtrl->nbImagePerSeq = pGCRegs->MemoryBufferSequenceSize;
	pBufferCtrl->nb_img_pre = pGCRegs->MemoryBufferSequencePreMOISize;
	pBufferCtrl->nb_img_post = BufferManager_ReturnNumberOfImagePost(pBufferCtrl);
   pBufferCtrl->clear_memory = 0;

	WriteStruct(pBufferCtrl);

	if(Mode == BM_WRITE) // Do not enable in read mode wait for ACQ_Start
	{
      BufferManager_EnableBuffer(pBufferCtrl);
	}

	BUFFERING_INF("SetBufferMode");

}

void BufferManager_SetSwitchConfig(t_bufferManager *pBufferCtrl, t_bufferSwitch config)
{
   pBufferCtrl->switchConfig = config;
   AXI4L_write32(pBufferCtrl->switchConfig, pBufferCtrl->ADD + BM_SWITCH_CONFIG);
   BUFFERING_INF("SetSwitchConfig");
}

void BufferManager_SetMoiConfig(t_bufferManager *pBufferCtrl)
{
   // Config MOI source
   switch (gcRegsData.MemoryBufferMOISource)
   {
      case MBMOIS_AcquisitionStarted:
      default:
         pBufferCtrl->moiSource = BM_NO_MOI;
         break;

      case MBMOIS_Software:
         pBufferCtrl->moiSource = BM_SOFTARE_MOI;
         break;

      case MBMOIS_ExternalSignal:
         pBufferCtrl->moiSource = BM_EXTERNAL_MOI;
         break;
   }

   // Config MOI activation
   switch (gcRegsData.MemoryBufferMOIActivation)
   {
      case MBMOIA_RisingEdge:
      default:
         pBufferCtrl->moiActivation = RISING_EDGE;
         break;

      case MBMOIA_FallingEdge:
         pBufferCtrl->moiActivation = FALLING_EDGE;
         break;

      case MBMOIA_AnyEdge:
         pBufferCtrl->moiActivation = ANY_EDGE;
         break;
   }

   AXI4L_write32(pBufferCtrl->moiSource,     pBufferCtrl->ADD + BM_MOI_SOURCE);
   AXI4L_write32(pBufferCtrl->moiActivation, pBufferCtrl->ADD + BM_MOI_ACTIVATION);

   BUFFERING_INF("SetMoiConfig");
}

uint32_t BufferManager_GetNumberOfSequenceMax()
{
	BUFFERING_INF("GetNumberOfSequenceMax");
	return BUF_MAX_SEQUENCE;
}

void BufferManager_SetSequenceParams(t_bufferManager *pBufferCtrl, const gcRegistersData_t *pGCRegs )
{
	BufferManager_DisableBuffer(pBufferCtrl);
	pBufferCtrl->nbSequenceMax = pGCRegs->MemoryBufferNumberOfSequences;
	pBufferCtrl->nbImagePerSeq = pGCRegs->MemoryBufferSequenceSize;
	pBufferCtrl->nb_img_pre = pGCRegs->MemoryBufferSequencePreMOISize;
   pBufferCtrl->nb_img_post  = BufferManager_ReturnNumberOfImagePost(pBufferCtrl);
	AXI4L_write32(pBufferCtrl->nbSequenceMax, 	pBufferCtrl->ADD + NB_SEQUENCE_MAX);
	AXI4L_write32(pBufferCtrl->nbImagePerSeq,    pBufferCtrl->ADD + BM_NB_IMG_PER_SEQ);
	AXI4L_write32(pBufferCtrl->nb_img_pre,       pBufferCtrl->ADD + BM_NB_IMG_PRE);
   AXI4L_write32(pBufferCtrl->nb_img_post,      pBufferCtrl->ADD + BM_NB_IMG_POST);
	BufferManager_EnableBuffer(pBufferCtrl);

	BUFFERING_INF("SetSequenceParams");
}

uint32_t BufferManager_ReturnNumberOfImagePost(t_bufferManager *pBufferCtrl){

	return pBufferCtrl->nbImagePerSeq- pBufferCtrl->nb_img_pre;
}

void BufferManager_SendSoftwareMoi(t_bufferManager *pBufferCtrl){
	AXI4L_write32( 1,	pBufferCtrl->ADD + BM_SOFT_MOI_SIG);
	AXI4L_write32( 0, pBufferCtrl->ADD + BM_SOFT_MOI_SIG);
}

bool gBufferStartDownloadTrigger = false;
bool gBufferStopDownloadTrigger = false;
bool gBufferAcqStartedTrigger = false;

// attention tout changement à cette fonction doit être potentiellement répercuté dans le fichier BufferManager.c du projet Storage
void BufferManager_SM()
{
   extern t_bufferManager gBufManager;
   extern gcRegistersData_t gcRegsData;

   const uint32_t bits_per_pixel = 16;
   const float max_delay_us = 20e6; // 0.05 Hz min
   const float minBitRate = 0.1e6; // bps

   static bmState_t cstate = BMS_IDLE;
   static timerData_t timer; // used to control some delay for buffer deactivation/activation
   static uint32_t frameSize; // frame size, including header [pixels]
   static bool acqStopCmd = true;

   float maxBandWidth = 10e6; // maximum average bit rate as requested by the client [bps]
   float timeout_delay_us; // configured delay between frames, [us]
   uint32_t sequenceCount;
   uint32_t frameID, numFrames;

   // the external memory buffer overrides internal buffer
   bool internalMemory = !TDCFlagsTst(ExternalMemoryBufferIsImplementedMask);
   bool enabled = internalMemory && gcRegsData.MemoryBufferMode == MBM_On && gcRegsData.MemoryBufferSequenceDownloadMode != MBSDM_Off;

   if (!internalMemory)
      return;

   // update sequence count
   sequenceCount = BufferManager_GetNumSequenceCount(&gBufManager);
   if (gcRegsData.MemoryBufferSequenceCount != sequenceCount)
   {
      GC_SetMemoryBufferSequenceCount(sequenceCount);
   }

   // preserve consistency among the memory buffer registers
   if (gcRegsData.MemoryBufferSequenceCount == 0)
   {
      if (gcRegsData.MemoryBufferSequenceDownloadMode != MBSDM_Off)
      {
         GC_SetMemoryBufferSequenceDownloadMode(MBSDM_Off);
      }
      gcRegsData.MemoryBufferSequenceSelector = 0;
   }
   else
      gcRegsData.MemoryBufferSequenceSelector = MIN(gcRegsData.MemoryBufferSequenceSelector, gcRegsData.MemoryBufferSequenceCount - 1);

   switch (cstate)
   {
   case BMS_IDLE:
      if (enabled)
      {
         if (gBufferStartDownloadTrigger == 1)
         {
            gBufferStartDownloadTrigger = 0;
            if (gcRegsData.MemoryBufferSequenceCount > 0
                  && gcRegsData.MemoryBufferSequenceSelector >= 0
                  && gcRegsData.MemoryBufferSequenceSelector < gcRegsData.MemoryBufferSequenceCount)
               cstate = BMS_CFG;
         }
      }

      break;

   case BMS_CFG:

      numFrames = BufferManager_GetSequenceLength(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
      if (gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Sequence)
      {
         frameID = BufferManager_GetSequenceFirstFrameId(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
      }
      else // single image mode
      {
         uint32_t firstID = BufferManager_GetSequenceFirstFrameId(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
         uint32_t moiFrameID = BufferManager_GetSequenceMOIFrameId(&gBufManager, gcRegsData.MemoryBufferSequenceSelector);
         uint32_t lastID = firstID + numFrames - 1;

         // make sure the requested frame is within bounds. By default, send the MOI frame
         frameID = gcRegsData.MemoryBufferSequenceDownloadImageFrameID;
         if (frameID < firstID || frameID > lastID)
            frameID = moiFrameID;
         gcRegsData.MemoryBufferSequenceDownloadImageFrameID = frameID;
      }

      maxBandWidth = MAX(minBitRate, gcRegsData.MemoryBufferSequenceDownloadBitRateMax * 1.0e6);

      frameSize = gcRegsData.Width * (gcRegsData.Height + 2);

      timeout_delay_us = 1.0e6 * frameSize * bits_per_pixel / maxBandWidth;
      timeout_delay_us = MIN(timeout_delay_us, max_delay_us);

      BUFFERING_INF("Initiating sequence/image download from the memory buffer.\n");
      BUFFERING_INF("BUF: max output average bit rate target: " _PCF(2) " Mbps\n", _FFMT(maxBandWidth/1.0e6,2));
      BUFFERING_INF("BUF: max output frame rate: " _PCF(2) "Hz\n", _FFMT(1.0e6/timeout_delay_us, 2));

      BUFFERING_INF("Buffer download started.\n");

      StartTimer(&timer, 10); // workaround for buffer reactivation

      BufferManager_ConfigureMinFrameTime(&gBufManager, timeout_delay_us);
      if(gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Sequence)
      {
         BufferManager_ReadSequence(&gBufManager, &gcRegsData);
      }
      else if(gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Image)
      {
         BufferManager_ReadImage(&gBufManager, &gcRegsData);
      }

      cstate = BMS_WAIT;

      break;

   case BMS_READ:

      // live throttling of the average bit rate
      maxBandWidth = MAX(minBitRate, gcRegsData.MemoryBufferSequenceDownloadBitRateMax * 1.0e6);

      timeout_delay_us = 1.0e6 * frameSize * bits_per_pixel / maxBandWidth;
      timeout_delay_us = MIN(timeout_delay_us, max_delay_us);

      BufferManager_ConfigureMinFrameTime(&gBufManager, timeout_delay_us);
      break;

   case BMS_WAIT:
      if (TimedOut(&timer))
      {
         BufferManager_EnableBuffer(&gBufManager);
         if(gcRegsData.MemoryBufferSequenceDownloadMode == MBSDM_Sequence)
            cstate = BMS_READ;
         else
            cstate = BMS_DONE;
      }
      break;

   case BMS_DONE:
      // do some clean up

      cstate = BMS_IDLE;

      break;

   default:
      cstate = BMS_IDLE;
      break;
   };

   // always : handle acquisition stop and start. In download mode, a start trigger restarts the download
   if (gBufferStopDownloadTrigger == 1 || gBufferStartDownloadTrigger == 1 || gBufferClearedTrigger == 1) // Acquisition Stop is high when buffer is cleared
   {
      gBufferStopDownloadTrigger = 0;
      gBufferClearedTrigger = 0;
      acqStopCmd = 1;

      // go to the DONE state only when in download mode
      if (enabled && cstate == BMS_READ)
      {
         BUFFERING_INF("Buffer download stopped.\n");

         cstate = BMS_DONE;
      }
   }

   // acquisition stop stay high when Acquisition is stop and there is no download
   BufferManager_AcquisitionStop(&gBufManager, acqStopCmd);

   if(gBufferAcqStartedTrigger == 1 || gBufferStartDownloadTrigger == 1) //gBufferStartDownloadTrigger is not RAZ, restart a buffer read sequence at BMS_IDLE
   {
      gBufferAcqStartedTrigger = 0;
      acqStopCmd = 0;
   }
}

/**
 * Configure the frame duration in read mode.
 *
 * @param pBufferCtrl Pointer to the Buffer Manager controller instance.
 *
 * @return void.
 */
void BufferManager_ConfigureMinFrameTime(t_bufferManager *pBufferCtrl, float time_us)
{
   const float clk_freq_MHz = CLK_80_FREQ_HZ / 1E6;
   uint32_t cnt;

   cnt = time_us * clk_freq_MHz;

   AXI4L_write32(cnt, pBufferCtrl->ADD + BM_MIN_FRAME_TIME);
}

void BufferManager_AcquisitionStop(t_bufferManager *pBufferCtrl, bool flag)
{
   AXI4L_write32(flag, pBufferCtrl->ADD + BM_ACQ_STOP);
}
