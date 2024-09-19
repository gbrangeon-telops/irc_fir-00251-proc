
alib work
setactivelib work

setenv SFW_INTF "$FIR251PROC/src/SFW/HDL"			   
setenv SFW_INTF_SIM "$FIR251PROC/src/SFW/sims/src"



#source SFW
do "$SFW_INTF/build_sfw.do"			  

#simulation ip

#simulation src
acom "$SFW_INTF_SIM/sfw_tb_stim.vhd"
acom -relax "$SFW_INTF_SIM/sfw_tb_sink.vhd"
acom "$SFW_INTF_SIM/tb_sfw_top.bde"	


