
do "$FIR251PROC/src/ADCReadout/HDL/build_adc_readout.do"

acom -nowarn $COMMON_HDL/Matlab/axis_file_input_16.vhd \
$FIR251PROC/src/ADCReadout/Sim/adc_readout_tb_stim.vhd \
$FIR251PROC/src/ADCReadout/Sim/adc_readout_tb_toplevel.bde

asim -ses adc_readout_tb_toplevel 

do "$FIR251PROC/src/ADCReadout/Sim/waveform.do"

run 200 us