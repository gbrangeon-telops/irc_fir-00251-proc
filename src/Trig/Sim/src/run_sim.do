#Simulation file

asim -ses +access +r tb_trig_top
#transcript off
do "$FIR251PROC/src/Trig/Sim/src/waveform.do"
#transcript on
run 12 us
						