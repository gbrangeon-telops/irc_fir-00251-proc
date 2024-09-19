#Simulation file

asim -ses +access +r stim
#transcript off	  
do "$FIR251PROC/src/FPA/mockfpa/Sim/src/waveform.do"
#transcript on

run 5ms
