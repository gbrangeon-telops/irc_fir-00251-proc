/**
 * @file HwRevision.h
 * Board HW revision module header.
 *
 * This file defines Board HW revision module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
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
#include <stdbool.h>
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

struct s_detected_hw
{
   brd_rev_ver_t BrdRevid;
   uint8_t       NbDDR3;
};

typedef struct s_detected_hw detected_hw_t;

IRC_Status_t Get_board_hw_revision(uint16_t gpioDeviceId, detected_hw_t* detected_hw);

#endif // HWREVISION_H
