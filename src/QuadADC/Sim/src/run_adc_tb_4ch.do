alib work
setActivelib work

setenv ADC_INTF_SIM "D:\Telops\FIR-00251-Proc\src\QuadADC\Sim"

asim -ses adc_tb_4ch_top_level 

do "$ADC_INTF_SIM\src\waveform_4ch.do"

run 10 us