alib work
setactivelib work

setenv BUF_INTF_SIM "$FIR251PROC/src/Buffering/Sims"
setenv PROC "$FIR251PROC"

#source Buffering
do "$PROC/src/Buffering/hdl/build_buffering_intf.do"			  

#simulation ip
acom "$BUF_INTF_SIM/src/Sim IP/axi_buffering_dm/axi_buffering_dm_funcsim.vhdl"
acom "$BUF_INTF_SIM/src/Sim IP/axi_interco_dm/axi_interco_dm_funcsim.vhdl"
acom "$BUF_INTF_SIM/src/Sim IP/blk_mem/blk_mem_funcsim.vhdl"
acom "$BUF_INTF_SIM/src/Sim Src/core_bd.bde"

#simulation src
acom "$BUF_INTF_SIM/src/Sim Src/buffering_tb_stim.vhd"
acom "$COMMON_HDL/matlab/axis_file_input_16.vhd"
acom "$COMMON_HDL/matlab/axis_file_input_32.vhd"
acom "$COMMON_HDL/matlab/axis_file_output_32.vhd"
acom "$BUF_INTF_SIM/src/sim_buffering_top.bde"	


