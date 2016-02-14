/**
 * @file verbose.h
 * VERBOSE definition.
 *
 * This file defines VERBOSE macros.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef VERBOSE_H
#define VERBOSE_H

#include "printf_utils.h"


#ifdef DEBUG
#define ACQ_VERBOSE
#define ACT_VERBOSE
// #define BUFFERING_VERBOSE
// #define CAL_VERBOSE
// #define CI_VERBOSE
// #define CM_VERBOSE
// #define EHDRI_VERBOSE
// #define F1F2_VERBOSE
// #define FDV_VERBOSE
// #define FH_VERBOSE
// #define FH_RX_VERBOSE
// #define FH_TX_VERBOSE
// #define FM_VERBOSE
// #define FS_VERBOSE
// #define FU_VERBOSE
// #define FW_VERBOSE
// #define SFW_VERBOSE

// #define GCM_VERBOSE
// #define GCP_VERBOSE
// #define GPS_VERBOSE
// #define ICU_VERBOSE
// #define IHEX_VERBOSE
// #define NDF_VERBOSE
// #define PLEORA_VERBOSE
// #define PM_VERBOSE
// #define SREC_VERBOSE
// #define TM_VERBOSE
// #define XADC_VERBOSE
#endif // DEBUG

#endif // VERBOSE_H
