#Simulation file
setenv SFW_INTF_SIM "D:\Telops\FIR-00251-Proc\src\SFW\sims\src"

asim -ses +access +r tb_sfw_top
#transcript off
do "$SFW_INTF_SIM\waveform.do"
#transcript on
run 250 ms
