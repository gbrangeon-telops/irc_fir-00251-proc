alib work
setActivelib work

setenv CALIB "D:\Telops\FIR-00251-Proc\src\Calibration"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"

#IP
acom D:\Telops\FIR-00251-Proc\IP\160\calib_param_ram\calib_param_ram_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_afifo_wr68_rd34_d16\fwft_afifo_wr68_rd34_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_afifo_wr34_rd68_d1024\fwft_afifo_wr34_rd68_d1024_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\ip_axis32_split_axis16\ip_axis32_split_axis16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\ip_axis16_combine_axis32\ip_axis16_combine_axis32_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\ip_axis32_fanout2\ip_axis32_fanout2_sim_netlist.vhdl

#Common
do "$COMMON\compile_all_common.do"
acom "$COMMON_HDL\Utilities\sync_resetn.vhd"
acom "$COMMON_HDL\Utilities\sync_reset.vhd"
acom "$COMMON_HDL\Utilities\double_sync.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_edge_det.vhd"

#Calibration
do "$CALIB\HDL\compil_calibration.do"

#Simulation
acom "$CALIB\Sim\src\calib_tb_stim.vhd"
acom "$CALIB\Sim\src\tb_calib_top.bde"


