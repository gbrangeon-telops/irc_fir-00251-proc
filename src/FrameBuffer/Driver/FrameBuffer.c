#include "FrameBuffer.h"
#include "proc_memory.h"
#include "fpa_intf.h"
#include "mb_axi4l_bridge.h"
#include "utils.h"
#include "proc_init.h"
#include <stdbool.h>

// Internal function prototype



/* This function write the initial configuration to the frame buffer VHDL module.
 *
 * It's impossible to use the frame buffer until at least one configuration has
 * been sent. Otherwise, all incoming frame will be discarded.
 * When a first configuration is receive, status(0) is set to high.
 *
*/
IRC_Status_t FB_Init(t_FB *pFB_ctrl, gcRegistersData_t *pGCRegs)
{
   #ifdef MEM_4DDR
      pFB_ctrl->fb_buffer_a_base_address = PROC_MEM_FRAME_BUFFER_BASEADDR;
      pFB_ctrl->fb_buffer_b_base_address = pFB_ctrl->fb_buffer_a_base_address + FB_BUFFER_SIZE;
      pFB_ctrl->fb_buffer_c_base_address = pFB_ctrl->fb_buffer_b_base_address + FB_BUFFER_SIZE;
      pFB_ctrl->fb_frame_byte_size       = (pGCRegs->Height + 2)*pGCRegs->Width* sizeof(uint16_t);
      pFB_ctrl->fb_hdr_pix_size          = pGCRegs->Width * 2;
      pFB_ctrl->fb_img_pix_size          = (pGCRegs->Width * pGCRegs->Height);
      pFB_ctrl->fb_lval_pause_min        = 1; // minimum pause between lines, limite du lien CLINK (CL_LVAL_PAUSE_FAST = 1)
      pFB_ctrl->fb_fval_pause_min        = 3; // minimum pause between frames and between header end image, limite du lien CLINK (CL_FVAL_PAUSE_FAST = 3)

      WriteStruct(pFB_ctrl);
      return IRC_SUCCESS;
   #else
      return IRC_SUCCESS;
   #endif
}

/* This function write a new configuration to the frame buffer VHDL module.
 *
 * The frame buffer must be empty to apply any new configurations.
 * Its behavior when receiving a new configuration :
 *    1. Set Status(1) = 0.
 *    2. Stop writing frames (all new incoming frames will be discarded).
 *    3. Wait to finish all pending read command.
 *    4. Apply the new configuration.
 *    5. Set Status(1) = 1.
 *
*/
void FB_SendConfigGC(t_FB *pFB_ctrl, gcRegistersData_t *pGCRegs)
{
   #ifdef MEM_4DDR
      //extern int32_t gFpaDebugRegA, gFpaDebugRegB;
      if(FB_getStatusAndErrors(pFB_ctrl).errors == 0)
      {
         pFB_ctrl->fb_frame_byte_size       = (pGCRegs->Height + 2) * pGCRegs->Width * sizeof(uint16_t);
         pFB_ctrl->fb_hdr_pix_size          = pGCRegs->Width * 2;
         pFB_ctrl->fb_img_pix_size          = (pGCRegs->Width * pGCRegs->Height);

         //if (gFpaDebugRegA > 0)
         //   pFB_ctrl->fb_fval_pause_min        = (uint32_t)gFpaDebugRegA;
         //else
         //   pFB_ctrl->fb_fval_pause_min        = 3;


         //if (gFpaDebugRegB > 0)
         //   pFB_ctrl->fb_lval_pause_min        = (uint32_t)gFpaDebugRegB;
         //else
         //   pFB_ctrl->fb_lval_pause_min        = 1;


         WriteStruct(pFB_ctrl);
      }
      else
      {
         FB_ERR("Configuration failed : frame buffer error \n");
      }
   #endif
}

bool FB_isFrameBufferReady(t_FB *pFB_ctrl)
{
   #ifdef MEM_4DDR
      bool     isReady;
      uint32_t status;

      status = AXI4L_read32(pFB_ctrl->ADD + FB_STATUS_OFFSET);
      isReady = BitMaskTst(status, FB_READY);
      return isReady;
   #else
      return true;
   #endif
}

t_FrameBufferStatus FB_getStatusAndErrors(t_FB *pFB_ctrl)
{
   t_FrameBufferStatus Status;
   Status.global_status = AXI4L_read32(pFB_ctrl->ADD + FB_STATUS_OFFSET);
   Status.errors = AXI4L_read32(pFB_ctrl->ADD + FB_ERROR_OFFSET);
   Status.FB_in_FR_min = AXI4L_read32(pFB_ctrl->ADD + FB_WR_FR_MIN_STAT_OFFSET);
   Status.FB_in_FR = AXI4L_read32(pFB_ctrl->ADD + FB_WR_FR_STAT_OFFSET);
   Status.FB_in_FR_max = AXI4L_read32(pFB_ctrl->ADD + FB_WR_FR_MAX_STAT_OFFSET);
   Status.FB_out_FR_min = AXI4L_read32(pFB_ctrl->ADD + FB_RD_FR_MIN_STAT_OFFSET);
   Status.FB_out_FR = AXI4L_read32(pFB_ctrl->ADD + FB_RD_FR_STAT_OFFSET);
   Status.FB_out_FR_max = AXI4L_read32(pFB_ctrl->ADD + FB_RD_FR_MAX_STAT_OFFSET);
   return Status;
}



