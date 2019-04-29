/**
 *  @file proc_init.h
 *  Processing FPGA initialization module header.
 *  
 *  This file defines the processing FPGA initialization module.
 *  
 *  $Rev: 22650 $
 *  $Author: pcouture $
 *  $Date: 2018-12-13 15:30:18 -0500 (jeu., 13 déc. 2018) $
 *  $Id: proc_init.h 22650 2018-12-13 20:30:18Z pcouture $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/proc_init.h $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef PROC_INIT_H
#define PROC_INIT_H

#include "IRC_Status.h"
#include "Protocol_F1F2.h"
#include "Protocol_Pleora.h"
#include "xparameters.h"

#define DT_UART_RX_CIRC_BUFFER_SIZE          128
#define DT_UART_TX_CIRC_BUFFER_SIZE          320

#define FILE_CI_USART_RX_CIRC_BUFFER_SIZE    PROC_MEM_USART_RXBUFFER_SIZE
#define FILE_CI_USART_TX_CIRC_BUFFER_SIZE    F1F2_MAX_FILE_PACKET_SIZE
#define FILE_RX_BUFFER_THRESHOLD             64

#define CLINK_CI_UART_RX_CIRC_BUFFER_SIZE    MAX((F1F2_MIN_PACKET_SIZE + F1F2_REG_ADDR_SIZE + GC_REG_MAX_WRITE_LENGTH), F1F2_MAX_FILE_PACKET_SIZE)
#define NTXMINI_CI_UART_RX_CIRC_BUFFER_SIZE  (2 * PLEORA_MAX_PACKET_SIZE)
#define OEM_CI_UART_RX_CIRC_BUFFER_SIZE      MAX((F1F2_MIN_PACKET_SIZE + F1F2_REG_ADDR_SIZE + GC_REG_MAX_WRITE_LENGTH), F1F2_MAX_FILE_PACKET_SIZE)
#define GENICAM_UART_TX_CIRC_BUFFER_SIZE     MAX((F1F2_MIN_PACKET_SIZE + F1F2_REG_ADDR_SIZE + GC_REG_MAX_READ_LENGTH), F1F2_MAX_FILE_PACKET_SIZE)

#define OUTPUT_CI_UART_RX_CIRC_BUFFER_SIZE   (5 * F1F2_MAX_NET_PACKET_SIZE)
#define OUTPUT_CI_UART_TX_CIRC_BUFFER_SIZE   F1F2_MAX_NET_PACKET_SIZE

#define GPS_UART_RX_CIRC_BUFFER_SIZE         512

#define NI_CMD_QUEUE_SIZE           10
#define GCM_CMD_QUEUE_SIZE          1
#define GCP_CMD_QUEUE_SIZE          1
#define CLINK_CI_CMD_QUEUE_SIZE     1
#define NTXMINI_CI_CMD_QUEUE_SIZE   1
#define OEM_CI_CMD_QUEUE_SIZE       1
#define OUTPUT_CI_CMD_QUEUE_SIZE    3
#define FM_CMD_QUEUE_SIZE           1
#define FM_CI_CMD_QUEUE_SIZE        1
#define FU_CMD_QUEUE_SIZE           1
#define DT_CMD_QUEUE_SIZE           1


#define GC_EVENT_ERROR_QUEUE_SIZE   10

IRC_Status_t Proc_NI_Init();
IRC_Status_t Proc_DeviceSerialPorts_Init();
IRC_Status_t Proc_DebugTerminal_InitPhase1();
IRC_Status_t Proc_DebugTerminal_InitPhase2();
IRC_Status_t Proc_DebugTerminal_InitPhase3();
IRC_Status_t Proc_FM_Init();
IRC_Status_t Proc_FU_Init();
IRC_Status_t Proc_GC_Init();
IRC_Status_t Proc_QSPIFlash_Init();
IRC_Status_t Proc_Power_Init();
IRC_Status_t Proc_Intc_Init();
IRC_Status_t Proc_Intc_Start();
IRC_Status_t Proc_GPS_Init();
IRC_Status_t Proc_FH_Init();
IRC_Status_t Proc_RP_Init();
IRC_Status_t Proc_SL_Init();
IRC_Status_t Proc_ReleaseInfo_Init();
IRC_Status_t Proc_Sensor_Init();
IRC_Status_t Proc_FlashDynamicValues_Init();
IRC_Status_t Proc_FlashSettings_Init();
IRC_Status_t Proc_Led_Init();
IRC_Status_t Proc_FileSystem_Init();
IRC_Status_t Proc_Fan_Init();
IRC_Status_t Proc_EHDRI_Init();
IRC_Status_t Proc_AEC_Init();
IRC_Status_t Proc_MGT_Init();
IRC_Status_t Proc_FW_Init();
IRC_Status_t Proc_NDF_Init();
IRC_Status_t Proc_EXP_Init();
IRC_Status_t Proc_CAL_Init();
IRC_Status_t Proc_Trigger_Init();
IRC_Status_t Proc_ICU_Init();
IRC_Status_t Proc_XADC_Init();
IRC_Status_t Proc_BufferManager_Init();
IRC_Status_t Proc_Timer_Init();
IRC_Status_t Proc_DeviceKeyValidation();
IRC_Status_t Proc_BoardRevisionValidation();

#endif // PROC_INIT_H
