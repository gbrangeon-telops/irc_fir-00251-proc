
#ifndef __FrameBuffer_H__
#define __FrameBuffer_H__

#include "IRC_status.h"
#include "GC_Registers.h"
#include <stdint.h>
#include "xparameters.h"
#include "GC_Registers.h"




#ifdef FB_VERBOSE
   #define FB_PRINTF(fmt, ...)  FPGA_PRINTF("FB: " fmt, ##__VA_ARGS__)
#else
   #define FB_PRINTF(fmt, ...)  DUMMY_PRINTF("FB: " fmt, ##__VA_ARGS__)
#endif

#define FB_ERR(fmt, ...)        FPGA_PRINTF("FB: Error: " fmt "\n", ##__VA_ARGS__)
#define FB_INF(fmt, ...)        FPGA_PRINTF("FB: Info: " fmt "\n", ##__VA_ARGS__)
#define FB_DBG(fmt, ...)        FB_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)


/************************** Constant Definitions ****************************/

#ifdef MEM_4DDR
   #define FB_FRAME_BUFFER_SIZE              FB_NB_BUFFER*FB_BUFFER_SIZE
   #define FB_CTRL_BASE_ADDR                 XPAR_M_FRAME_BUFFER_CTRL_BASEADDR
   #define FB_NB_BUFFER                      3 // Number of buffers in the frame buffer
   #define FB_BUFFER_SIZE                    FPA_WIDTH_MAX * (FPA_HEIGHT_MAX + 2) * sizeof(uint16_t) // Number of bytes in a single buffer, +2 lines for the header
#else
   #define FB_FRAME_BUFFER_SIZE              0
   #define FB_CTRL_BASE_ADDR                 0
   #define FB_NB_BUFFER                      0
   #define FB_BUFFER_SIZE                    0
#endif

// Read/Write adresses
#define FB_BUFFER_A_BASE_ADDR_OFFSET	   0x00
#define FB_BUFFER_B_BASE_ADDR_OFFSET	   0x04
#define FB_BUFFER_C_BASE_ADDR_OFFSET	   0x08
#define FB_FRAME_BYTE_SIZE_OFFSET	      0x0C
#define FB_HDR_PIX_SIZE_OFFSET	         0x10
#define FB_IMG_PIX_SIZE_OFFSET	         0x14
#define FB_LVAL_PAUSE_MIN_OFFSET	         0x18

// Read only adresses
#define FB_STATUS_OFFSET                  0x1C
#define FB_ERROR_OFFSET                   0x20
#define FB_WR_FR_MIN_STAT_OFFSET          0x24
#define FB_WR_FR_STAT_OFFSET              0x28
#define FB_WR_FR_MAX_STAT_OFFSET          0x2C
#define FB_RD_FR_MIN_STAT_OFFSET          0x30
#define FB_RD_FR_STAT_OFFSET              0x34
#define FB_RD_FR_MAX_STAT_OFFSET          0x38

// Status mask
#define FB_INIT_CFG_DONE_MASK             0x01
#define FB_CFG_UPDATE_DONE_MASK           0x02
#define FB_READY                          (FB_INIT_CFG_DONE_MASK | FB_CFG_UPDATE_DONE_MASK)


// Errors mask
//TODO


/**************************** Type Definitions ******************************/

struct s_FB
{
   uint32_t SIZE;                // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;

   uint32_t fb_buffer_a_base_address; // buffer a base address
   uint32_t fb_buffer_b_base_address; // buffer b base address
   uint32_t fb_buffer_c_base_address; // buffer c base address
   uint32_t fb_frame_byte_size;       // frame size in bytes
   uint32_t fb_hdr_pix_size;          // header size in bytes
   uint32_t fb_img_pix_size;          // image size in bytes
   uint32_t fb_lval_pause_min;        // minimum pause between line
  };
typedef struct s_FB t_FB;

// structure de statut
struct s_FrameBufferStatus
{
   uint32_t FB_in_FR_min;
   uint32_t FB_in_FR;
   uint32_t FB_in_FR_max;
   uint32_t FB_out_FR_min;
   uint32_t FB_out_FR;
   uint32_t FB_out_FR_max;
   uint32_t global_status;
   uint32_t errors;
};

typedef struct s_FrameBufferStatus t_FrameBufferStatus;

/***************** Macros (Inline Functions) Definitions ********************/

#define FB_Intf_Ctor(add) {sizeof(t_FB)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0}

/************************** Function Prototypes *****************************/

IRC_Status_t FB_Init(t_FB *pFB_ctrl, gcRegistersData_t *pGCRegs);
void FB_SendConfigGC( t_FB *pFB_ctrl, gcRegistersData_t *pGCRegs);
bool FB_isFrameBufferReady(t_FB *pFB_ctrl);
t_FrameBufferStatus FB_getStatusAndErrors(t_FB *pFB_ctrl);


#endif
