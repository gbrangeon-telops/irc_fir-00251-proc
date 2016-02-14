alib work
setActivelib work

setenv ADC_INTF_SIM "D:\Telops\FIR-00251-Proc\src\QuadADC\Sim"

asim -ses data_cdc_tb_stim_top_level 

do "$ADC_INTF_SIM\src\waveform_data_cdc.do"

run 10 us