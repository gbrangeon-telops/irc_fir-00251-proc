
vdel -all
setactivelib work



acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd

acom $FIR251COMMON/VHDL/Utilities/rst_conditioner.vhd

acom $FIR251PROC/IP/160/fwft_afifo_w28_d16/fwft_afifo_w28_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w32_d16/fwft_sfifo_w32_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w64_d16/fwft_sfifo_w64_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w65_d16/fwft_sfifo_w65_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w40_d16/fwft_sfifo_w40_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/tdp_ram_w8_d2048/tdp_ram_w8_d2048_sim_netlist.vhdl
acom $FIR251PROC/IP/160/t_axi4_stream32_sfifo_d2048/t_axi4_stream32_sfifo_d2048_sim_netlist.vhdl
acom $FIR251PROC/IP/160/t_axi4_stream32_afifo_d512/t_axi4_stream32_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/160/t_axi4_stream64_afifo_d512/t_axi4_stream64_afifo_d512_sim_netlist.vhdl	 
acom "$FIR251PROC/IP/325/t_axi4_stream64_afifo_d1024/t_axi4_stream64_afifo_d1024_sim_netlist.vhdl"
acom $FIR251PROC/IP/160/sfifo_w8_d64/sfifo_w8_d64_sim_netlist.vhdl	
acom $FIR251PROC/IP/160/sfifo_w8_d64_no_output_reg/sfifo_w8_d64_no_output_reg_sim_netlist.vhdl
acom "$FIR251PROC/IP/160/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl"
acom "$FIR251PROC/IP/160/ip_axis_32_to_64/ip_axis_32_to_64_sim_netlist.vhdl"
acom "$FIR251COMMON/VHDL/Utilities/axis_32_to_64_wrap.vhd"



acom "$FIR251COMMON/VHDL/Buffering/BufferingDefine.vhd"
do "$FIR251PROC/src/Trig/HDL/compil_trig_gen.do"

acom  $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom  $FIR251PROC/src/FPA/blackbird1280D/HDL/FPA_define.vhd
acom -incr -nowarn DAGGEN_0523 $FIR251PROC/src/FPA/scd_proxy/HDL/proxy_define.vhd
acom "$FIR251PROC/aldec/src/FPA/blackbird1280D/src/TestBench/blackbird1280D_testbench_pkg.vhd"	
do $FIR251PROC/src/FPA/blackbird1280D/hdl/compil_blackbird1280D.do
acom $FIR251PROC/aldec/src/FPA/blackbird1280D/src/TestBench/scd_proxy_sim.vhd
acom $FIR251PROC/aldec/src/FPA/blackbird1280D/src/blackbird1280D_top_tb.bde   
acom "$FIR251COMMON/VHDL/Utilities/axis64_RandomMiso.vhd"
acom $FIR251PROC/aldec/src/FPA/blackbird1280D/src/TestBench/blackbird1280D_top_tb_TB.vhd


--------------------
asim -ses blackbird1280D_top_tb_TB 
add wave -named_row "--------------------- Réception de configurations -----------------------"
add wave -named_row "Interface uBlaze"
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/ARESETN}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U4/MB_CLK}
add wave -noreg -lo/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/ACQ_INTgic {/blackbird1280D_top_tb_tB/UUT/U1/U4/axi_awaddr}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U4/cfg_arb/blackbird1280D_top_tb_tB/UUT/U1/U4/mb_cfg_serial_in_progressit_fsm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U4/mb_cfg_serial_in_progress}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U4/user_cfg_in_progress_i}
add wave -named_row "Prog controller"
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/XTRA_TRIG}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/ACQ_TRIG}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/ACQ_INT}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/PROXY_PWR}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/PROXY_POWERED}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/PROXY_RDY}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/RST_CLINK_N}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/proxy_static_done}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/new_cfg_pending_fsm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/driver_seq_fsm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U1/SERIAL_BASE_ADD}
add wave -named_row "Serial module"
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U2/cfg_mgmt_fsm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U2/prog_seq_fsm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U5/U2/prog_trig_fsm}

add wave -named_row "--------------------- Dispatcher -----------------------"
add wave -named_row "Diag data input"
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/DIAG_CH1_DVAL}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/DIAG_CH1_DATA}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/DIAG_CH2_DVAL}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/DIAG_CH2_DATA}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/DIAG_CH3_DVAL}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/DIAG_CH3_DATA}
add wave -named_row "Real data input"
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_CH1_DVAL}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_CH1_DATA}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_CH2_DVAL}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_CH2_DATA}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_CH3_DVAL}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_CH3_DATA}
add wave -named_row "Data output"  
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_TRIG}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/acq_mode}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/acq_mode_first_int}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/FPA_INT}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/READOUT}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/acq_hder_fifo_wr}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/acq_hder_fifo_rd}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/acq_hder}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/int_fifo_wr}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/int_fifo_rd}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/mode_fsm}
add wave -noreg -logic {/black/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/mode_fsmbird1280D_top_tb_tB/UUT/U1/U9/U6/fast_hder_sm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/frame_fsm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/pix_out_sm}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/PIX_MOSI.TVALID}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/PIX_MISO.TREADY}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/PIX_MOSI.TDATA}
add wave -noreg -logic {/blackbird1280D_top_tb_tB/UUT/U1/U9/U6/PIX_MOSI.TLAST}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}


add wave -named_row "--------------------- All others signals-----------------------"

add wave -named_row "---------------------Sim diag data -----------------------"
add wave UUT/U3/U1/*

add wave -named_row "---------------------Fifo out -----------------------"
add wave UUT/U5/*


add wave -named_row "---------------------Data dispatcher _ test pattern -----------------------"
add wave UUT/U1/U9/U1/*

add wave -named_row "---------------------Data dispatcher _ fifo writer -----------------------"
add wave UUT/U1/U9/U4/*

add wave -named_row "---------------------Data dispatcher -----------------------"
add wave UUT/U1/U9/U6/*

add wave -named_row "---------------------mblaze intf -----------------------"
wave UUT/U1/U4/* 

add wave -named_row "-------------------scd_proxy_stim----------------------------------"
add wave UUT/U3/*
add wave -named_row "---------------------scd_diag_data_gen-----------------------"
add wave UUT/U3/U2/*
	  
add wave -named_row "---------------------scd trig ctler-----------------------"
wave UUT/U1/U1/*  
 
add wave -named_row "---------------------scd prog ctrler-----------------------"
wave UUT/U1/U5/U1/* 

add wave -named_row "---------------------scd serial module-----------------------"
wave UUT/U1/U5/U2/* 

add wave -named_row "---------------------scd io intf -----------------------"
wave UUT/U1/U19/*

add wave -named_row "---------------------fpa intf sequencer -----------------------"
wave UUT/U1/U2/*

#add wave -named_row "---------------------watchdog -----------------------"
#wave UUT/U1/U26/*	

add wave -named_row "---------------------sim -----------------------"
wave UUT/U1/g0/U32/*

run 30 ms