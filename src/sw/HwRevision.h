/**
 * @file HwRevision.h
 * Board HW revision module header.
 *
 * This file defines Board HW revision module.
 *
 * $Rev: 22650 $
 * $Author: pcouture $
 * $Date: 2018-12-13 15:30:18 -0500 (jeu., 13 déc. 2018) $
 * $Id: HwRevision.h 22650 2018-12-13 20:30:18Z pcouture $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/sw/HwRevision.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef HWREVISION_H
#define HWREVISION_H

#include "IRC_Status.h"
#include "verbose.h"
#include "xparameters.h"
#include "xgpio.h"
#include "stdint.h"

#ifdef HWR_VERBOSE
   #define HWR_PRINTF(fmt, ...)      FPGA_PRINTF("HWR: " fmt, ##__VA_ARGS__)
#else
   #define HWR_PRINTF(fmt, ...)      DUMMY_PRINTF("HWR: " fmt, ##__VA_ARGS__)
#endif

#define HWR_ERR(fmt, ...)            FPGA_PRINTF("HWR: Error: " fmt "\n", ##__VA_ARGS__)
#define HWR_INF(fmt, ...)            FPGA_PRINTF("HWR: Info: " fmt "\n", ##__VA_ARGS__)
#define HWR_DBG(fmt, ...)            HWR_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)


#define REV_GPIO_CHANNEL 2


enum brd_rev_ver {
   BRD_REV_00x = 0,
   BRD_REV_20x = 1,
   BRD_REV_UNKNOWN
};

typedef enum brd_rev_ver brd_rev_ver_t;


IRC_Status_t Get_board_hw_revision(uint16_t gpioDeviceId, brd_rev_ver_t* brd_rev_id);


#endif // HWREVISION_H
