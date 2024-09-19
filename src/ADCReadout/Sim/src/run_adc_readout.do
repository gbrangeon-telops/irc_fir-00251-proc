acom "$FIR251PROC/src/ADCReadout/Sim/src/adc_readout_tb_top.bde"

asim -ses +access +r adc_readout_adc_tb_top

do "$FIR251PROC/src/ADCReadout/Sim/src/waveform.do"
				   
run 50 us