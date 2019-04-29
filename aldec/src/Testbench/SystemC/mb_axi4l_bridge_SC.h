/**
 *  @file mb_axi4l_bridge_SC.h
 *  Functions used to bridge microblaze AXI4-Lite transaction to SystemC transactions.
 *  
 *  These functions are a copy of the real ones and are used to simulates the microblaze.
 *  
 *  $Rev: 13301 $
 *  $Author: enofodjie $
 *  $LastChangedDate: 2014-03-13 11:22:29 -0400 (jeu., 13 mars 2014) $
 *  $Id: mb_axi4l_bridge_SC.h 13301 2014-03-13 15:22:29Z enofodjie $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/SystemC/mb_axi4l_bridge_SC.h $
 */
#ifndef __MB_AXI4L_BRIDGE_SC_H__
#define __MB_AXI4L_BRIDGE_SC_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

#ifdef Xil_Out32
#undef Xil_Out32
#endif
#ifdef Xil_In32
#undef Xil_In32
#endif

uint8_t AXI4L_write32( uint32_t data, uint32_t add);
uint8_t AXI4L_write16( uint16_t data, uint32_t add);
uint8_t AXI4L_write8( uint8_t data, uint32_t add);
uint32_t AXI4L_read32(uint32_t add);


void Xil_Out32(uint32_t add, uint32_t data);
uint32_t Xil_In32(uint32_t add);


#ifdef __cplusplus
}
#endif

#endif //__UCT_WB_BRIDGE_SC_H__





