alib work
setActivelib work

setenv ADC_READOUT "D:\telops\FIR-00251-Proc\src\ADCReadout\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

# Package
acom  "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"
acom  "D:\telops\FIR-00251-Common\VHDL\img_header_define.vhd"

do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#source ADC Readout
acom -nowarn DAGGEN_0523 "$ADC_READOUT\adc_readout_mb_intf.vhd" \
 "D:\telops\FIR-00251-Proc\src\Irig\HDL\IRIG_define_v2.vhd" \
 "D:\telops\FIR-00251-Proc\src\Irig\HDL\ad747x_driver.vhd" \
 "$ADC_READOUT\ad798x_driver.vhd" \
 "$ADC_READOUT\adc_readout.vhd" \
 "$ADC_READOUT\adc_switch.vhd" \
 "$ADC_READOUT\adc_readout_top.bde"

#sim



