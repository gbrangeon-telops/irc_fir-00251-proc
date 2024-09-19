#Simulation file

asim -ses +access +r Top
#transcript off	  
do "$FIR251PROC/src/FrameBuffer/Sim/src/waveform.do"
#transcript on

run 1ms
