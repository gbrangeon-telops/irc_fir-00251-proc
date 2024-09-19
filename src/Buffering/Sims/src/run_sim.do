#Simulation file
	   	 
setenv BUF_INTF_SIM "$FIR251PROC/src/Buffering/Sims"
acom "$BUF_INTF_SIM/src/sim_buffering_top.bde"	
	   
asim -ses +access +r sim_buffering_top
#transcript off
do "$FIR251PROC/src/Buffering/Sims/src/waveform.do"
#transcript on
run 600 us
