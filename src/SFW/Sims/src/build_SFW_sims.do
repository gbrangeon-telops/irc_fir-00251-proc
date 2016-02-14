
alib work
setActivelib work

setenv SFW_INTF "D:\Telops\FIR-00251-Proc\src\SFW\HDL"			   
setenv SFW_INTF_SIM "D:\Telops\FIR-00251-Proc\src\SFW\sims\src"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"


#source SFW
do "$SFW_INTF\build_sfw.do"			  

#simulation ip

#simulation src
acom "$SFW_INTF_SIM\sfw_tb_stim.vhd"
acom -relax "$SFW_INTF_SIM\sfw_tb_sink.vhd"
acom "$SFW_INTF_SIM\tb_sfw_top.bde"	


