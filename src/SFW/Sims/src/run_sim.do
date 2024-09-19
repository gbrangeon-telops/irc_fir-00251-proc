#Simulation file
setenv SFW_INTF_SIM "$FIR251PROC/src/SFW/sims/src"

asim -ses +access +r tb_sfw_top
#transcript off
do "$SFW_INTF_SIM/waveform.do"
#transcript on
run 200 ms
