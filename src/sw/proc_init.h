/**
 *  @file proc_init.h
 *  Processing FPGA initialization module header.
 *  
 *  This file defines the processing FPGA initialization module.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef PROC_INIT_H
#define PROC_INIT_H

#include "IRC_Status.h"
#include "Protocol_F1F2.h"
#include "Protocol_Pleora.h"
#include "xparameters.h"

#define OEM_UART_IS_GPS             (0)

#define OEM_UART_IS_DEBUG_TERMINAL  ((STDOUT_BASEADDRESS == XPAR_OEM_UART_BASEADDR) || (STDIN_BASEADDRESS == XPAR_OEM_UART_BASEADDR))

#define OEM_UART_ENABLED            (!OEM_UART_IS_DEBUG_TERMINAL && !OEM_UART_IS_GPS)

#if (!defined(DEBUG) && OEM_UART_IS_GPS)
#error "OEM UART is used as GPS."
#endif

#if (!defined(DEBUG) && OEM_UART_IS_DEBUG_TERMINAL)
#error "OEM UART is used as debug terminal."
#endif

#define FILE_CI_USART_RX_BUFFER_SIZE         PROC_MEM_USART_RXBUFFER_SIZE
#define FILE_CI_UART_RX_CIRC_BUFFER_SIZE     PROC_MEM_USART_RXBUFFER_SIZE
#define FILE_CI_USART_TX_BUFFER_SIZE         F1F2_MAX_FILE_PACKET_SIZE
#define FILE_RX_BUFFER_THRESHOLD             64

#define CLINK_CI_UART_RX_CIRC_BUFFER_SIZE    MAX((F1F2_MIN_PACKET_SIZE + F1F2_REG_ADDR_SIZE + GC_REG_MAX_WRITE_LENGTH), F1F2_MAX_FILE_PACKET_SIZE)
#define PLEORA_CI_UART_RX_CIRC_BUFFER_SIZE   (2 * PLEORA_MAX_PACKET_SIZE)
#define OEM_CI_UART_RX_CIRC_BUFFER_SIZE      MAX((F1F2_MIN_PACKET_SIZE + F1F2_REG_ADDR_SIZE + GC_REG_MAX_WRITE_LENGTH), F1F2_MAX_FILE_PACKET_SIZE)
#define MASTER_UART_TX_BUFFER_SIZE           MAX((F1F2_MIN_PACKET_SIZE + F1F2_REG_ADDR_SIZE + GC_REG_MAX_READ_LENGTH), F1F2_MAX_FILE_PACKET_SIZE)

#define OUTPUT_CI_UART_RX_CIRC_BUFFER_SIZE   (2 * F1F2_MAX_NET_PACKET_SIZE)
#define OUTPUT_CI_UART_TX_BUFFER_SIZE        F1F2_MAX_NET_PACKET_SIZE

#define GPS_UART_RX_CIRC_BUFFER_SIZE         512

#define NI_CMD_QUEUE_SIZE           7
#define GCM_CMD_QUEUE_SIZE          1
#define GCP_CMD_QUEUE_SIZE          1
#define CLINK_CI_CMD_QUEUE_SIZE     1
#define PLEORA_CI_CMD_QUEUE_SIZE    1
#define OEM_CI_CMD_QUEUE_SIZE       1
#define OUTPUT_CI_CMD_QUEUE_SIZE    3
#define FM_CMD_QUEUE_SIZE           1
#define FM_CI_CMD_QUEUE_SIZE        1
#define FU_CMD_QUEUE_SIZE           1

#define GC_EVENT_ERROR_QUEUE_SIZE   10

IRC_Status_t Proc_NI_Init();
IRC_Status_t Proc_FM_Init();
IRC_Status_t Proc_FU_Init();
IRC_Status_t Proc_GC_Init();
IRC_Status_t Proc_QSPIFlash_Init();
IRC_Status_t Proc_Power_Init();
IRC_Status_t Proc_Intc_Init();
IRC_Status_t Proc_Intc_Start();
IRC_Status_t Proc_GPS_Init();
IRC_Status_t Proc_FH_Init();
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

#endif // PROC_INIT_H
