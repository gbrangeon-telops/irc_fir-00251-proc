/**
 * @file XADC_valid.h
 * XADC valid value ranges definition
 *
 * This file defines the accepted measurement ranges for each XADC channel
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 déc. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef XADC_VALID_H_
#define XADC_VALID_H_

#define TOLERANCE           0.0165f
#define THERM_TOL           0.0048828125f       // 20 LSBs of a 12-bit ADC, VREF = 1V

#define COOLER_VOLTAGE_MAX    (24.0f * (1.0f + TOLERANCE))
#define COOLER_VOLTAGE_MIN  	(24.0f * (1.0f - TOLERANCE))
								
#define COOLER_CURRENT_MAX  	0
#define COOLER_CURRENT_MIN  	0
								
#define P24V_VOLTAGE_MAX    	(24.0f * (1.0f + TOLERANCE))
#define P24V_VOLTAGE_MIN    	(24.0f * (1.0f - TOLERANCE))
								
#define P24V_CURRENT_MAX    	(1.5f * (1.0f + 0.18))
#define P24V_CURRENT_MIN    	(0.5f * (1.0f - 0.18))
								
#define FPGA_IVCC_MAX       	(1.03f)
#define FPGA_IVCC_MIN       	(0.97f)
								
#define FPGA_AVCC_MAX       	(1.89f)
#define FPGA_AVCC_MIN       	(1.71f)
								
#define FPGA_VREFP_MAX      	(1.3f)
#define FPGA_VREFP_MIN      	(1.2f)
								
#define FPGA_VREFN_MAX      	(0.02f)
#define FPGA_VREFN_MIN      	(-0.02f)
								
#define FPGA_VBRAM_MAX      	(1.03f)
#define FPGA_VBRAM_MIN      	(0.97f)
								
#define PROC_IO_VOLTAGE_MAX 	0
#define PROC_IO_VOLTAGE_MIN 	0
								
#define OUT_IO_VOLTAGE_MAX  	0
#define OUT_IO_VOLTAGE_MIN  	0
								
#define SUPPLY_3V3_MAX      	(3.3f * (1.0f + TOLERANCE))
#define SUPPLY_3V3_MIN      	(3.3f * (1.0f - TOLERANCE))
								
#define SUPPLY_2V5_MAX      	(2.5f * (1.0f + TOLERANCE))
#define SUPPLY_2V5_MIN      	(2.5f * (1.0f - TOLERANCE))
								
#define SUPPLY_1V8_MAX      	(1.8f * (1.0f + TOLERANCE))
#define SUPPLY_1V8_MIN      	(1.8f * (1.0f - TOLERANCE))
								
#define SUPPLY_1V5_MAX      	(1.5f * (1.0f + TOLERANCE))
#define SUPPLY_1V5_MIN      	(1.5f * (1.0f - TOLERANCE))
								
#define SUPPLY_1V35_MAX     	(1.35f * (1.0f + TOLERANCE))
#define SUPPLY_1V35_MIN     	(1.35f * (1.0f - TOLERANCE))
								
#define MGT_1V0_MAX         	(1.03f)
#define MGT_1V0_MIN         	(0.97f)
								
#define MGT_1V2_MAX         	(1.23f)
#define MGT_1V2_MIN         	(1.17f)
								
#define SUPPLY_12V_MAX      	(12.0f * (1.0f + TOLERANCE))
#define SUPPLY_12V_MIN      	(12.0f * (1.0f - TOLERANCE))
								
#define SUPPLY_5V_MAX       	(5.0f * (1.0f + TOLERANCE))
#define SUPPLY_5V_MIN       	(5.0f * (1.0f - TOLERANCE))
								
#define FPGA_ITEMP_MAX      	(100.0f)
#define FPGA_ITEMP_MIN      	(-40.0f)
								
#define INT_LENS_TEMP_MAX   	(0.84335f + THERM_TOL)
#define INT_LENS_TEMP_MIN   	(0.84335f - THERM_TOL)
								
#define EXT_LENS_TEMP_MAX   	(0.57822f + THERM_TOL)
#define EXT_LENS_TEMP_MIN   	(0.57822f - THERM_TOL)
								
#define ICU_TEMP_MAX        	(0.33433f + THERM_TOL)
#define ICU_TEMP_MIN        	(0.33433f - THERM_TOL)
								
#define SFW_TEMP_MAX        	(0.20404f + THERM_TOL)
#define SFW_TEMP_MIN        	(0.20404f - THERM_TOL)
								
#define COMPR_TEMP_MAX      	(0.13103f + THERM_TOL)
#define COMPR_TEMP_MIN      	(0.13103f - THERM_TOL)
								
#define COLD_FINGER_TEMP_MAX	(0.047743f + THERM_TOL)
#define COLD_FINGER_TEMP_MIN	(0.047743f - THERM_TOL)
								
#define SPARE_TEMP_MAX      	(0.024857f + THERM_TOL)
#define SPARE_TEMP_MIN      	(0.024857f - THERM_TOL)
								
#define EXT_THERM_TEMP_MAX  	(0.011766f + THERM_TOL)
#define EXT_THERM_TEMP_MIN  	(0.011766f - THERM_TOL)
								
#define USB_BUS_VOLTAGE_MAX 	(5.0f * (1.0f + TOLERANCE))
#define USB_BUS_VOLTAGE_MIN 	(5.0f * (1.0f - TOLERANCE))
								
#define USB_1V8_MAX         	(1.8f * (1.0f + TOLERANCE))
#define USB_1V8_MIN         	(1.8f * (1.0f - TOLERANCE))
								
#define DDR3_VREF_MAX       	(0.75f * (1.0f + TOLERANCE))
#define DDR3_VREF_MIN       	(0.75f * (1.0f - TOLERANCE))
								
#define GIGE_VCC10_MAX      	(12.0f * (1.0f + TOLERANCE))
#define GIGE_VCC10_MIN        (12.0f * (1.0f - TOLERANCE))

#endif /* XADC_VALID_H_ */
