/**
 *  @file XADC_Channels.h
 *  XADC and XSysmon monitor channels header.
 *  
 *  This file defines the XADC and XSysmon channels.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef XADC_CHANNELS_H
#define XADC_CHANNELS_H

#include "XADC.h"

#define XADC_EXTERNAL_CHANNELS_ENABLED

/**
 * XADC internal channels.
 */
enum xadcIntChEnum {
   XIC_TEMP = 0,     /**< On Chip Temperature */
   XIC_VCCINT,       /**< VCCINT */
   XIC_VCCAUX,       /**< VCCAUX */
   XIC_VREFP,        /**< VREFP */
   XIC_VREFN,        /**< VREFN */
   XIC_VBRAM,        /**< VBRAM */
   XIC_COUNT         /**< Number of XADC internal channels */
};

/**
 * XADC internal channels data type.
 */
typedef enum xadcIntChEnum xadcIntCh_t;

/**
 * XADC external channels.
 */
enum xadcExtChEnum {
   XEC_INTERNAL_LENS = 0,  /**< Internal lens temperature */
   XEC_EXTERNAL_LENS,      /**< External lens temperature */
   XEC_ICU,                /**< ICU temperature */
   XEC_SFW,                /**<  */
   XEC_COMPRESSOR,         /**<  */
   XEC_COLD_FINGER,        /**<  */
   XEC_SPARE,              /**< Spare channel */
   XEC_EXT_THERMISTOR,     /**< External thermistor */
   XEC_COOLER_SENSE,       /**<  */
   XEC_COOLER_CUR,         /**<  */
   XEC_24V_SENSE,          /**<  */
   XEC_24V_CUR,            /**<  */
   XEC_USB_VBUS_SENSE,     /**<  */
   XEC_USB_1V8_SENSE,      /**<  */
   XEC_DDR3_VREF_SENSE,    /**<  */
   XEC_VCC_10GigE_SENSE,   /**<  */
   XEC_VCCAUX_IO_P_SENSE,  /**<  */
   XEC_VCCAUX_IO_O_SENSE,  /**<  */
   XEC_3V3_SENSE,          /**<  */
   XEC_2V5_SENSE,          /**<  */
   XEC_1V8_SENSE,          /**<  */
   XEC_1V5_SENSE,          /**<  */
   XEC_1V0MGT_SENSE,       /**<  */
   XEC_1V2MGT_SENSE,       /**<  */
   XEC_12V_SENSE,          /**<  */
   XEC_5V0_SENSE,          /**<  */
   XEC_COUNT               /**< Number of XADC external channels */
};

/**
 * XADC external channels data type.
 */
typedef enum xadcExtChEnum xadcExtCh_t;


extern xadcChannel_t intAdcChannels[XIC_COUNT];
extern xadcChannel_t extAdcChannels[XEC_COUNT];

#endif // XADC_CHANNELS_H
