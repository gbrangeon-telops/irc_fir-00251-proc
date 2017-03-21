#Simulation file

asim -ses +access +r tb_trig_top
#transcript off
do "D:\Telops\FIR-00251-Proc\src\Trig\Sim\src\waveform.do"
#transcript on
run 12 us
						