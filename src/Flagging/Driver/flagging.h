/**
 * @file flagging.h
 * IR camera flagging driver.
 */

#ifndef __FLAGGING_H__
#define __FLAGGING_H__

#include <stdint.h>
#include "GC_Registers.h"
#include "tel2000_param.h"

#ifdef FLAGGING_VERBOSE
   #define FLAGGING_PRINTF(fmt, ...)  FPGA_PRINTF("Flag: " fmt, ##__VA_ARGS__)
#else
   #define FLAGGING_PRINTF(fmt, ...)  DUMMY_PRINTF("flag: " fmt, ##__VA_ARGS__)
#endif

// structure de configuration du block de flagging
struct s_FlagCfg
{
   uint32_t SIZE;                   // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;
   
   uint32_t Mode;          
   uint32_t Delay;          
   uint32_t FrameCount;          
   uint32_t TrigSource;          
   };
   
typedef struct s_FlagCfg t_FlagCfg;

#define FLAG_BASE_CLOCK_FREQ_HZ    CLK_MB_FREQ_HZ  // horloge de reference du flagging

#define FLAGADDR_MODE            0x0
#define FLAGADDR_DELAY           0x4
#define FLAGADDR_FRAMECOUNT      0x8
#define FLAGADDR_TRIGSOURCE      0xC
#define FLAGADDR_SOFTTRIG        0x10

#define FLAGMODE_DISABLE         0x0
#define FLAGMODE_RISINGEDGE      0x1
#define FLAGMODE_FALLINGEDGE     0x2
#define FLAGMODE_ANYEDGE         0x3
#define FLAGMODE_LEVELHIGH       0x4
#define FLAGMODE_LEVELLOW        0x5

#define FLAGSOURCE_EXTERNAL      0x0
#define FLAGSOURCE_SOFTWARE      0x1

#define FLAGGING_AXILITE_OFFSET  0x400

/***************** Macros (Inline Functions) Definitions ********************/
#define Flagging_config_Ctor(add) {sizeof(t_FlagCfg)/4 - 2, add, FLAGMODE_DISABLE, 0, 0, FLAGSOURCE_EXTERNAL}

IRC_Status_t FLAG_Init(t_FlagCfg *a);
void FLAG_SendConfigGC(t_FlagCfg *a, const gcRegistersData_t *pGCRegs);
void FLAG_SendTrig(t_FlagCfg *a);

#endif // __FLAGGING_H__
