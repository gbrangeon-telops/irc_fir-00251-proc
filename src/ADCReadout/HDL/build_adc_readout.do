alib work
setactivelib work

setenv ADC_READOUT "$FIR251PROC//src/ADCReadout/HDL"

# Package
acom  "$FIR251COMMON/VHDL/tel2000pkg.vhd"
acom  "$FIR251COMMON/VHDL/img_header_define.vhd"

do "$FIR251PROC/src/compil_utilities.do"

#source ADC Readout
acom -nowarn DAGGEN_0523 "$ADC_READOUT/adc_readout_mb_intf.vhd" \
 "$FIR251PROC/src/Irig/HDL/IRIG_define_v2.vhd" \
 "$FIR251PROC/src/Irig/HDL/ad747x_driver.vhd" \
 "$ADC_READOUT/ad798x_driver.vhd" \
 "$ADC_READOUT/adc_readout.vhd" \
 "$ADC_READOUT/adc_switch.vhd" \
 "$ADC_READOUT/adc_readout_top.bde"

#sim



