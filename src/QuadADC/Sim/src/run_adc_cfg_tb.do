alib work
setActivelib work

setenv ADC_INTF_SIM "D:\Telops\FIR-00251-Proc\src\QuadADC\Sim"

asim -ses adc_cfg_tb_top_level 

do "$ADC_INTF_SIM\src\waveform_qadc_ctrl.do"

run 30 us