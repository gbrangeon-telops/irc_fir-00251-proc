#Simulation file

asim -ses +access +r tb_clink_top
#transcript off
do $FIR251PROC/src/clink/Sim/src/waveform.do
#transcript on
run 10 us
						