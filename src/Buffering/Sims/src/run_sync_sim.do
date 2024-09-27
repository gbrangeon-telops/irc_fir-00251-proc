#Simulation file
	   	 
setenv BUF_INTF_SIM "$FIR251PROC/src/Buffering/Sims/"
#acom "$BUF_INTF_SIM/src/Sim src/sync_switch_stim.vhd"
#acom "$BUF_INTF_SIM/src/sync_switch_top.bde"	
	   
asim -ses +access +r sync_switch_top
#transcript off
do "$BUF_INTF_SIM/src/sync_waveform.do"
#transcript on
-- run 150 us
run 32 us
