/**
 * @file gating.h
 * IR camera gating driver.
 */

#ifndef __GATING_H__
#define __GATING_H__

#include <stdint.h>
#include "GC_Registers.h"

#ifdef GATING_VERBOSE
   #define GATING_PRINTF(fmt, ...)  FPGA_PRINTF("Gating: " fmt, ##__VA_ARGS__)
#else
   #define GATING_PRINTF(fmt, ...)  DUMMY_PRINTF("Gating: " fmt, ##__VA_ARGS__)
#endif

// structure de configuration du block de flagging
struct s_GatingCfg
{
   uint32_t SIZE;                   // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;
   
   uint32_t Mode;          
   uint32_t Delay;          
   uint32_t FrameCount;          
   uint32_t TrigSource;          
};
   
typedef struct s_GatingCfg t_GatingCfg;

#define GATING_BASE_CLOCK_FREQ_HZ   100000000.0  // horloge de reference du gating (100MHz)

#define GATING_ADDR_MODE            0x0
#define GATING_ADDR_DELAY           0x4
#define GATING_ADDR_FRAMECOUNT      0x8
#define GATING_ADDR_TRIGSOURCE      0xC
#define GATING_ADDR_SOFTTRIG        0x10

#define GATING_MODE_DISABLE         0x0
#define GATING_MODE_RISINGEDGE      0x1
#define GATING_MODE_FALLINGEDGE     0x2
#define GATING_MODE_ANYEDGE         0x3
#define GATING_MODE_LEVELHIGH       0x4
#define GATING_MODE_LEVELLOW        0x5

#define GATING_SOURCE_EXTERNAL      0x0
#define GATING_SOURCE_SOFTWARE      0x1

#define GATING_AXILITE_OFFSET       0x800

/***************** Macros (Inline Functions) Definitions ********************/
#define Gating_config_Ctor(add) {sizeof(t_GatingCfg)/4 - 2, add, GATING_MODE_DISABLE, 0, 0, GATING_SOURCE_EXTERNAL}

IRC_Status_t GATING_Init(t_GatingCfg *a);
void GATING_SendConfigGC(t_GatingCfg *a, const gcRegistersData_t *pGCRegs);
void GATING_SendTrig(t_GatingCfg *a);

#endif // __GATING_H__
