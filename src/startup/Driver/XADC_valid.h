/**
 * @file XADC_valid.h
 * XADC valid value ranges definition
 *
 * This file defines the accepted measurement ranges for each XADC channel
 *
 * $Rev: 17659 $
 * $Author: dalain $
 * $Date: 2015-12-10 11:42:57 -0500 (jeu., 10 d√©c. 2015) $
 * $Id: DebugTerminal.h 17659 2015-12-10 16:42:57Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/DebugTerminal.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef XADC_VALID_H_
#define XADC_VALID_H_


#define MEAS_PRECISION        ((double)0.001)   // precision used in measurements
#define DISPLAY_DIGITS        3                 // number of digits to display, should match MEAS_PRECISION


#define VOLTAGE_TOL           0.05f    // in %, experimentally determined


#define COOLER_VOLTAGE_MAX    (24.0f * (1.0f + VOLTAGE_TOL))
#define COOLER_VOLTAGE_MIN  	(24.0f * (1.0f - VOLTAGE_TOL))
								
#define COOLER_CURRENT_MAX  	(0.5f)
#define COOLER_CURRENT_MIN  	(0.1f)
								
#define P24V_VOLTAGE_MAX    	(24.0f * (1.0f + VOLTAGE_TOL))
#define P24V_VOLTAGE_MIN    	(24.0f * (1.0f - VOLTAGE_TOL))
								
#define P24V_CURRENT_MAX    	(1.5f)
#define P24V_CURRENT_MIN    	(0.5f)


#define FPGA_ITEMP_MAX        (95.0f)
#define FPGA_ITEMP_MIN        (15.0f)

#define FPGA_IVCC_MAX       	(1.0f * (1.0f + VOLTAGE_TOL))
#define FPGA_IVCC_MIN       	(1.0f * (1.0f - VOLTAGE_TOL))
								
#define FPGA_AVCC_MAX       	(1.8f * (1.0f + VOLTAGE_TOL))
#define FPGA_AVCC_MIN       	(1.8f * (1.0f - VOLTAGE_TOL))
								
#define FPGA_VREFP_MAX      	(1.25f * (1.0f + VOLTAGE_TOL))
#define FPGA_VREFP_MIN      	(1.25f * (1.0f - VOLTAGE_TOL))
								
#define FPGA_VREFN_MAX      	(0.03f)
#define FPGA_VREFN_MIN      	(-0.03f)
								
#define FPGA_VBRAM_MAX      	(1.0f * (1.0f + VOLTAGE_TOL))
#define FPGA_VBRAM_MIN      	(1.0f * (1.0f - VOLTAGE_TOL))


#define USB_BUS_VOLTAGE_MAX   (5.0f * (1.0f + VOLTAGE_TOL))
#define USB_BUS_VOLTAGE_MIN   (5.0f * (1.0f - VOLTAGE_TOL))

#define USB_1V8_MAX           (1.8f * (1.0f + VOLTAGE_TOL))
#define USB_1V8_MIN           (1.8f * (1.0f - VOLTAGE_TOL))

//#define DDR3_VREF_MAX         (0.75f * (1.0f + VOLTAGE_TOL))
//#define DDR3_VREF_MIN         (0.75f * (1.0f - VOLTAGE_TOL))
#define DDR3_VREF_MAX         (0.86f)     // experimentally determined
#define DDR3_VREF_MIN         (0.81f)

#define GIGE_VCC10_MAX        SUPPLY_12V_MAX
#define GIGE_VCC10_MIN        SUPPLY_12V_MIN
								
#define PROC_IO_VOLTAGE_MAX 	(1.8f * (1.0f + VOLTAGE_TOL))    // could be 2.0V
#define PROC_IO_VOLTAGE_MIN 	(1.8f * (1.0f - VOLTAGE_TOL))
								
#define OUT_IO_VOLTAGE_MAX  	(1.8f * (1.0f + VOLTAGE_TOL))    // could be 2.0V
#define OUT_IO_VOLTAGE_MIN  	(1.8f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_3V3_MAX      	(3.3f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_3V3_MIN      	(3.3f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_2V5_MAX      	(2.5f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_2V5_MIN      	(2.5f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_1V8_MAX      	(1.8f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_1V8_MIN      	(1.8f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_1V5_MAX      	(1.5f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_1V5_MIN      	(1.5f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_1V35_MAX     	(1.35f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_1V35_MIN     	(1.35f * (1.0f - VOLTAGE_TOL))
								
#define MGT_1V0_MAX         	(1.0f * (1.0f + VOLTAGE_TOL))
#define MGT_1V0_MIN         	(1.0f * (1.0f - VOLTAGE_TOL))
								
#define MGT_1V2_MAX         	(1.2f * (1.0f + VOLTAGE_TOL))
#define MGT_1V2_MIN         	(1.2f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_12V_MAX      	(12.0f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_12V_MIN      	(12.0f * (1.0f - VOLTAGE_TOL))
								
#define SUPPLY_5V_MAX       	(5.0f * (1.0f + VOLTAGE_TOL))
#define SUPPLY_5V_MIN       	(5.0f * (1.0f - VOLTAGE_TOL))


//#define ADC_REF_1_MAX         (0.97516f + 0.003f)  // ADC Ref needs to be precise
//#define ADC_REF_1_MIN         (0.97516f - 0.003f)
#define ADC_REF_1_MAX         (0.979f + 0.003f)    // differs from theoretical value because
#define ADC_REF_1_MIN         (0.979f - 0.003f)    // it is very close to the max XADC value

#define ADC_REF_2_MAX         (0.09942f + 0.003f)  // ADC Ref needs to be precise
#define ADC_REF_2_MIN         (0.09942f - 0.003f)

#define ADC_REF_3_MAX         (0.03f)
#define ADC_REF_3_MIN         (-0.03f)


#define THERM_TOL             0.003f         // R @ ±0.1% + VREF @ ±0.2%

//#define THERM_VAL_1           0.19967987f    // Volt value for R=4.99k
//#define THERM_VAL_1_MAX       (THERM_VAL_1 * (1.0f + THERM_TOL))
//#define THERM_VAL_1_MIN       (THERM_VAL_1 * (1.0f - THERM_TOL))
#define THERM_VAL_1_MAX       (0.210f)       // experimentally determined
#define THERM_VAL_1_MIN       (0.204f)

#define THERM_VAL_2           0.83333333f    // Volt value for R=100k
#define THERM_VAL_2_MAX       (THERM_VAL_2 * (1.0f + THERM_TOL))
#define THERM_VAL_2_MIN       (THERM_VAL_2 * (1.0f - THERM_TOL))
								
#define INT_LENS_TEMP_MAX   	THERM_VAL_1_MAX
#define INT_LENS_TEMP_MIN   	THERM_VAL_1_MIN
								
#define EXT_LENS_TEMP_MAX   	THERM_VAL_2_MAX
#define EXT_LENS_TEMP_MIN   	THERM_VAL_2_MIN
								
#define ICU_TEMP_MAX        	THERM_VAL_1_MAX
#define ICU_TEMP_MIN        	THERM_VAL_1_MIN
								
#define SFW_TEMP_MAX        	THERM_VAL_2_MAX
#define SFW_TEMP_MIN        	THERM_VAL_2_MIN
								
#define COMPR_TEMP_MAX      	THERM_VAL_1_MAX
#define COMPR_TEMP_MIN      	THERM_VAL_1_MIN
								
#define COLD_FINGER_TEMP_MAX	THERM_VAL_2_MAX
#define COLD_FINGER_TEMP_MIN	THERM_VAL_2_MIN
								
#define SPARE_TEMP_MAX      	THERM_VAL_1_MAX
#define SPARE_TEMP_MIN      	THERM_VAL_1_MIN
								
#define EXT_THERM_TEMP_MAX  	THERM_VAL_2_MAX
#define EXT_THERM_TEMP_MIN  	THERM_VAL_2_MIN

#endif /* XADC_VALID_H_ */
