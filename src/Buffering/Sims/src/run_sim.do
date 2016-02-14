#Simulation file
	   	 
setenv BUF_INTF_SIM "D:\Telops\FIR-00251-Proc\src\Buffering\Sims"
acom "$BUF_INTF_SIM\src\sim_buffering_top.bde"	
	   
asim -ses +access +r sim_buffering_top
#transcript off
do "D:\Telops\FIR-00251-Proc\src\Buffering\Sims\src\waveform.do"
#transcript on
run 600 us
