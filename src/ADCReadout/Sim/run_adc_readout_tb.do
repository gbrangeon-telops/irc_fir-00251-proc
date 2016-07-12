
do "D:\telops\FIR-00251-Proc\src\ADCReadout\HDL\build_adc_readout.do"

acom -nowarn D:\telops\Common_HDL\Matlab\axis_file_input_16.vhd \
D:\telops\FIR-00251-Proc\src\ADCReadout\Sim\adc_readout_tb_stim.vhd \
D:\telops\FIR-00251-Proc\src\ADCReadout\Sim\adc_readout_tb_toplevel.bde

asim -ses adc_readout_tb_toplevel 

do "D:\Telops\FIR-00251-Proc\src\ADCReadout\Sim\waveform.do"

run 200 us