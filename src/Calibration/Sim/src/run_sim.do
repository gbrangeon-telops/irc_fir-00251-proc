#Simulation file

asim -ses +access +r tb_calib_top
#transcript off
do "$FIR251PROC/src/Calibration/Sim/src/waveform.do"
#transcript on
run 12 us
						