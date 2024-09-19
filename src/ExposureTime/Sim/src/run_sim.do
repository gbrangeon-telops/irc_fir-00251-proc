#Simulation file

asim -ses +access +r tb_expTime_top
#transcript off
do "$FIR251PROC/src/ExposureTime/Sim/src/waveform.do"
#transcript on
run 12 us
						