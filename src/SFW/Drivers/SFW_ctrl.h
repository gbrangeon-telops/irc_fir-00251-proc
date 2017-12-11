
#ifndef SFW_CTRL_H
#define SFW_CTRL_H

#include "GC_Registers.h"
#include "IRC_Status.h"
#include <stdint.h>
#include "verbose.h"

#ifdef SFW_VERBOSE
   #define SFW_PRINTF(fmt, ...)    FPGA_PRINTF("SFW: " fmt, ##__VA_ARGS__)
#else
   #define SFW_PRINTF(fmt, ...)    DUMMY_PRINTF("SFW: " fmt, ##__VA_ARGS__)
#endif

#define SFW_ERR(fmt, ...)          FPGA_PRINTF("SFW: Error: " fmt "\n", ##__VA_ARGS__)
#define SFW_INF(fmt, ...)          SFW_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define SFW_BRAM_SIZE           128

//SFW CTRL ADDRESS MAP
#define FW_POSITION_0_ADDR 			0
#define FW_POSITION_1_ADDR 			4
#define FW_POSITION_2_ADDR 			8
#define FW_POSITION_3_ADDR 			12
#define FW_POSITION_4_ADDR 			16
#define FW_POSITION_5_ADDR 			20
#define FW_POSITION_6_ADDR 			24
#define FW_POSITION_7_ADDR 			28
#define CLEAR_ERR_ADDR 				32
#define VALID_PARAM_ADDR 			36
#define WHEEL_STATE_ADDR 			40
#define POSITIONSETPOINT_ADDR		44
#define NB_ENCODER_CNT_Addr 		48
#define RPM_FACTOR_ADDR 			52
#define RPM_MAX_ADDR 				56
#define HOME_LOCK_ADDR 				60
#define POSITION_ADDR 				64
#define RPM_ADDR 					   68
#define ERROR_SPEED_ADDR 			72
#define SPEED_PRECISION_BIT_ADDR	76
#define INDEX_MODE_ADDR          80

#define FW_EXPOSURETIME_OFFSET		1024

#define SFW_POS_TOLERANCE_MARGIN       0.5F
#define SFW_MAX_SPEED_MARGIN           500
#define SFW_FILTER_NB                  8

#define FWPOSITION_IN_TRANSITION          8
#define FWPOSITION_NOT_IMPLEMENTED        9


// Struct Definition
/**
 * EHDRI MANAGER STRUCT
 */
struct s_SFW_CTRL_Struct {
	uint32_t SIZE;                     // Number of config elements, excluding SIZE and ADD.
	uint32_t ADD;

   uint32_t FilterWheelPosition[8];
	uint32_t clear_err;
	uint32_t valid_param;
	uint32_t wheel_state;
	uint32_t position_setpoint;
	uint32_t nb_encoder_cnt;
	uint32_t rpm_factor;
	uint32_t rpm_max;
	uint32_t index_mode;
	uint32_t Enable;
};
typedef struct s_SFW_CTRL_Struct t_SfwCtrl;

/***************** Macros (Inline Functions) Definitions ********************/
#define sfw_Intf_Ctor(add) {sizeof(t_SfwCtrl) / 4 - 2, add, {0,0,0,0,0,0,0,0},0,0,0,0,0,0,0,0}

// Fonction defition
IRC_Status_t SFW_CTRL_Init(gcRegistersData_t *pGCRegs, t_SfwCtrl *pSFWCtrl);
//IRC_Status_t SFW_CTRL_Reset(t_SfwCtrl *pSFWCtrl);
void SFW_UpdateFilterRanges(float deltaTheta1, float deltaTheta2);
uint16_t SFW_GetEncoderPosition();
void SFW_SetExposureTimeArray(uint8_t ExpId, float Exptime);
void SFW_Enable();
void SFW_Disable();
uint32_t SFW_Get_RPM();
void SFW_UpdateSFWMode(FWMode_t Mode);
void SFW_GetCurrentFilterRange(int32_t CurrentFilterPos, uint32_t * pFilterStart, uint32_t * pFilterEnd);

//For debug
void SFW_DisplayReadRegister();



#endif // SFW_CTRL_H
