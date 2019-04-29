/* $Id: ICU.h 23157 2019-04-02 20:06:10Z elarouche $ */
/****************************************************************************/
/**
*
* @file ICU.h
* 
* This driver controls the ICU module via AXIL.
* 
* Author(s) : Simon Savary
*
*****************************************************************************/
#ifndef __ICU_H__
#define __ICU_H__

/***************************** Include Files ********************************/

#include "Genicam.h"
#include "GC_Registers.h"
#include "xintc.h"
#include "irc_status.h"
#include "tel2000_param.h"
#include "hder_inserter.h"
#include "verbose.h"

#ifdef ICU_VERBOSE
   #define ICU_PRINTF(fmt, ...)  FPGA_PRINTF("ICU: " fmt, ##__VA_ARGS__)
#else
   #define ICU_PRINTF(fmt, ...)  DUMMY_PRINTF("ICU: " fmt, ##__VA_ARGS__)
#endif

#define ICU_ERR(fmt, ...)        FPGA_PRINTF("ICU: Error: " fmt "\n", ##__VA_ARGS__)
#define ICU_INF(fmt, ...)        ICU_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

// ADRESSE du registre des statuts
#define ICU_MODE_OFFSET					   0x00
#define ICU_PULSE_WIDTH_OFFSET      	0x04
#define ICU_PERIOD_OFFSET           	0x08
#define ICU_CALIB_POLARITY_OFFSET  	 	0x0C
#define ICU_TRANSITION_DURATION_OFFSET	0x10
#define ICU_PULSE_CMD_OFFSET	    	   0x14
#define ICU_POSITION_OFFSET		    	0x18
#define ICU_BRAKEPOLARITY_OFFSET       0x1C

/**************************** Type Definitions ******************************/

// structure de configuration de AEC
struct ICU_config
{
   uint32_t SIZE;                 // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;                  // base address for the ICU config

   uint32_t ICU_Mode;             // operating mode, either ONE_SHOT or REPEAT
   uint32_t ICU_PulseWidth;       // command pulse width, [ms]
   uint32_t ICU_Period;           // period of one pulse cycle (REPEAT mode only), [ms]
   uint32_t ICU_CalibPolarity;    // polarity of the pule for placing the palette at the CALIB position : convention
   uint32_t ICU_TransitionDuration; // duration of the ICU_POSITION_MOVING period, [ms]
  };
typedef struct ICU_config ICU_config_t;


// ICU polarity for the ICU in calibration position
enum ICU_POL_Enum
{
   ICU_POL_FORWARD = 0, // H-Bridge state : INA/INB = 1/0
   ICU_POL_REVERSE = 1  // H-Bridge state : INA/INB = 0/1
};

// ICU operating mode
enum ICU_Mode_Enum
{
   ICU_MODE_ONE_SHOT = 0,
   ICU_MODE_REPEAT = 1
};

/**************************** Constant Definitions ******************************/

#define ICU_DEFAULT_PULSE_WIDTH 			(uint32_t)10 // [ms]
#define ICU_DEFAULT_PERIOD      			(uint32_t)1000 // [ms]
#define ICU_DEFAULT_TRANSITION_DURATION    	(uint32_t)1000 // [ms]
#define ICU_DEFAULT_MODE        			ICU_MODE_REPEAT
#define ICU_DEFAULT_POLARITY    			ICU_POL_FORWARD
#define ICU_CLK_PER_MS						((uint32_t)(CLK_MB_FREQ_HZ / 1000)) // [clock ticks in one ms]

#define ICU_STATUS_REFRESH_RATE 10 // [ms]

/***************** Macros (Inline Functions) Definitions ********************/
#define ICU_config_Ctor(add) {sizeof(ICU_config_t)/4 - 2, add, ICU_DEFAULT_MODE, ICU_DEFAULT_PULSE_WIDTH*ICU_CLK_PER_MS, ICU_DEFAULT_PERIOD*ICU_CLK_PER_MS, ICU_DEFAULT_POLARITY, ICU_DEFAULT_TRANSITION_DURATION*ICU_CLK_PER_MS}

/************************** Function Prototypes *****************************/

void ICU_process(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl, t_HderInserter* gHderInserter);

IRC_Status_t ICU_init(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl);

void ICU_scene(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl);
void ICU_off(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl);
void ICU_calib(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl);

void ICU_setpointUpdated(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl);
void ICU_getCurrentState(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl);
void ICU_updateHeader(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl, const t_HderInserter *a);

#endif // __ICU_H__
