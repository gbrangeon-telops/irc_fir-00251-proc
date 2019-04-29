/**
 * @file proc_prom.h
 * PROM definition.
 *
 * This file defines PROM macros.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef PROC_PROM_H
#define PROC_PROM_H

#if defined(ARCH_FPGA_160)

/**
 * Download.bit file base address
 */
#define PROM_DOWNLOAD_BIT_BASEADDR     0x00000000

/**
 * releaseInfo.bin file base address
 */
#define PROM_RELEASE_INFO_BASEADDR     0x00670000

/**
 * Software SREC file base address
 */
#define PROM_SOFTWARE_SREC_BASEADDR    0x00680000

/**
 * saved GenIcam storage base address
 */
#define PROM_GC_STORE_BASEADDR        0x00FF0000

#elif defined(ARCH_FPGA_325)

/**
 * Download.bit file base address
 */
#define PROM_DOWNLOAD_BIT_BASEADDR     0x00000000

/**
 * releaseInfo.bin file base address
 */
#define PROM_RELEASE_INFO_BASEADDR     0x00AF0000

/**
 * Software SREC file base address
 */
#define PROM_SOFTWARE_SREC_BASEADDR    0x00B00000

/**
 * saved GenIcam storage base address
 */
#define PROM_GC_STORE_BASEADDR        0x00FF0000

#else

#error "Undefined FPGA Architecture"

#endif

#endif // PROC_PROM_H
