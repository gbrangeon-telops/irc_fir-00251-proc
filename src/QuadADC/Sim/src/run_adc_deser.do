alib work
setActivelib work

setenv ADC_INTF_SIM "D:\Telops\FIR-00251-Proc\src\QuadADC\Sim"

asim -ses adc_deser_tb_top_level 

do "$ADC_INTF_SIM\src\waveform_deser.do"

--run 10 us
run 1600 us