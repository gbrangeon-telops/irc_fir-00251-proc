#Simulation file

asim -ses +access +r tb_expTime_top
#transcript off
do "D:\Telops\FIR-00251-Proc\src\ExposureTime\Sim\src\waveform.do"
#transcript on
run 12 us
						