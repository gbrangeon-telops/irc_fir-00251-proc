/*
 * Copyright (c) 2008 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#ifndef __FLASH_INTERFACE_H_
#define __FLASH_INTERFACE_H_

#define MOD_FAST
// #define LOW_FORMAT
// For model MT29F16G08AJADAWP:
//    MAX_NR_PARTITION 1 permits to use only 8Gb
//    MAX_NR_PARTITION 2 permits to use the whole 16Gb (not tested)
//    using more than 1 partition consume much more memory ????
//    For 8192 blocks: (16 * 8192)128K + 20.4K + 4.6K = 153K bytes.
//    For 16,384 blocks : 306K bytes ?
// For model MT29F4G08ABADAWP:
//    MAX_NR_PARTITION 1 permits to use the whole 4Gb
//    MAX_NR_PARTITION 2 same
// Because it s static allocation, a maximum partition must be defined
#define MAX_NR_PARTITION 2                       /* total partitions max 2 for cs0 & cs1 */
#define FM_UFFS_MOUNT_POINT_SIZE       5
#define FM_MOUNT_POINT_STRING_SIZE       6

enum nandModelEnum {
   MT29F16G08AJADAWP = 0,
   MT29F4G08ABADAWP = 1,
   NAND_UNDEFINED
};
typedef enum nandModelEnum nandModel_t;

struct flash_intf_struct {
   unsigned int nr_partition;
   char mount_points[MAX_NR_PARTITION][FM_MOUNT_POINT_STRING_SIZE];
   nandModel_t nand_model;
};

typedef struct flash_intf_struct flashIntfCtrl_t;

int uffs_main(flashIntfCtrl_t* flashIntfCtrl,int iStep);

#endif
