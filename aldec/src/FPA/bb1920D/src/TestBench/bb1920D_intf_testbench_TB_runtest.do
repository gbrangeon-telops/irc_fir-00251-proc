
adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do

acom $COMMON_HDL/Utilities/reset_extension.vhd
acom $FIR251COMMON/VHDL/Utilities/rst_conditioner.vhd

acom $FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd
acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d16/t_axi4_stream64_afifo_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d512/t_axi4_stream64_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d1024/t_axi4_stream64_afifo_d1024_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d1024/t_axi4_stream64_sfifo_d1024_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d2048/t_axi4_stream64_sfifo_d2048_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d16384_lim/t_axi4_stream64_sfifo_d16384_lim_sim_netlist.vhdl


--acom $FIR251PROC/IP/325/afifo_w57d16/afifo_w57d16_sim_netlist.vhdl
acom $FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd
--acom $FIR251PROC/IP/325/fwft_afifo_w62_d16/fwft_afifo_w62_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w72_d16/fwft_sfifo_w72_d16_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/fwft_afifo_w72_d128/fwft_afifo_w72_d128_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/fwft_sfifo_w1_d16/fwft_sfifo_w1_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d256/fwft_sfifo_w3_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w76_d256/fwft_sfifo_w76_d256_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/fwft_sfifo_w8_d256/fwft_sfifo_w8_d256_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/fwft_sfifo_w64_d256/fwft_sfifo_w64_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/sfifo_w8_d64/sfifo_w8_d64_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/sfifo_w8_d64_no_output_reg/sfifo_w8_d64_no_output_reg_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/fwft_sfifo_w56_d256/fwft_sfifo_w56_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream32_afifo_d512/t_axi4_stream32_afifo_d512_sim_netlist.vhdl
--acom $FIR251PROC/IP/325/afifo_w57d16/afifo_w57d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w16_d256/fwft_sfifo_w16_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w43_d512/fwft_sfifo_w43_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w72_d512/fwft_sfifo_w72_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w8_d256/fwft_afifo_w8_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w32_d16/fwft_afifo_w32_d16_sim_netlist.vhdl 
acom $FIR251PROC/IP/325/fwft_sfifo_w4_d1024/fwft_sfifo_w4_d1024_sim_netlist.vhdl 
acom $FIR251PROC/IP/325/fwft_sfifo_w32_d256/fwft_sfifo_w32_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w96_d128/fwft_afifo_w96_d128_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w76_d512/fwft_afifo_w76_d512_sim_netlist.vhdl


--acom $FIR251PROC/IP/325/afpa_single_div_ip/afpa_single_div_ip_sim_netlist.vhdl
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/afpa_single_div_ip.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/var_shift_reg_w16_d32.vhd

acom $FIR251PROC/IP/325/fwft_sfifo_w32_d256/fwft_sfifo_w32_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w96_d128/fwft_afifo_w96_d128_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w72_d16/fwft_afifo_w72_d16_sim_netlist.vhdl	 
acom $FIR251PROC/IP/325/tdp_ram_w8_d2048/tdp_ram_w8_d2048_sim_netlist.vhdl
acom "$FIR251PROC/IP/325/fwft_afifo_wr66_rd132_d512/fwft_afifo_wr66_rd132_d512_sim_netlist.vhdl"
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/afpa_single_div_ip.vhd
                                                                                                   
acom $FIR251PROC/IP/325/bb1920D_clks_mmcm/bb1920D_clks_mmcm_sim_netlist.vhdl

acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream64_fifo.vhd

acom $FIR251COMMON/VHDL/signal_stat/period_duration.vhd 

acom "$FIR251PROC/IP/325/fwft_afifo_wr40_rd80_d1024/fwft_afifo_wr40_rd80_d1024_sim_netlist.vhdl"
do $FIR251PROC/src/FPA/blackbird1920D/HDL/compil_blackbird1920D.do

acom $FIR251PROC/aldec/src/FPA/bb1920D/src/TestBench/bb1920_data_gen.vhd
acom $FIR251PROC/aldec/src/FPA/bb1920D/src/TestBench/sim_data_gen.bde
acom $FIR251PROC/aldec/src/FPA/bb1920D/src/TestBench/bb1920D_intf_testbench_pkg.vhd 
acom $FIR251PROC/aldec/src/FPA/bb1920D/src/bb1920_intf_testbench.bde

acom  $FIR251PROC/aldec/src/FPA/bb1920D/src/TestBench/bb1920D_intf_testbench_TB.vhd

asim -ses bb1920D_intf_testbench_TB 	 

#add wave -named_row "------------------------SIM DATA ------------------------------------" 
#wave bb1920d_intf_testbench_tb/UUT/U3/A_DIAG_DVAL	
#wave bb1920d_intf_testbench_tb/UUT/U3/A_DIAG_DATA

#wave bb1920d_intf_testbench_tb/UUT/U3/B_DIAG_DVAL
#wave bb1920d_intf_testbench_tb/UUT/U3/B_DIAG_DATA  

--add wave -named_row "------------------------Real Data -------------------------------------" 
--wave bb1920d_intf_testbench_tb/UUT/U1/U9/U1/U1/pix_debug
--wave bb1920d_intf_testbench_tb/UUT/U1/U9/U2/U1/pix_debug		

--add wave -named_row "------------------------Dispatcher-------------------------------------"  
--wave BB1920D_intf_testbench_tb/UUT/U1/U9/U18/pix_debug_dispatcher			  
--wave BB1920D_intf_testbench_tb/UUT/U1/U9/U5/pix_debug_dispatcher			  

--add wave -named_row "------------------------Mux bin -------------------------------------"  
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/dout_mosi_i
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/dout_mosi_debug	   
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/din_l1_mosi_debug
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/din_l2_mosi_debug
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line_mux_fsm	  
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/output_state  

--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line0_fifo_din	
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line0_fifo_dval
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line0_fifo_dout
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line0_fifo_wr_en 
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line0_fifo_rd_en
 
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line1_fifo_din	  
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line1_fifo_dval
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line1_fifo_dout	
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line1_fifo_wr_en
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line1_fifo_rd_en
  
--wave  /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line2_fifo_din 
--wave  /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line2_fifo_dval
--wave  /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line2_fifo_dout	
--wave  /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line2_fifo_wr_en
--wave  /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line2_fifo_rd_en
  
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line3_fifo_din
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line3_fifo_dval
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line3_fifo_dout
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line3_fifo_wr_en   
--wave /BB1920D_intf_testbench_tb/UUT/U1/U9/U7/U3/line3_fifo_rd_en
 
 	
#add wave -named_row "------------------------afpa flow mux-------------------------------------" 
#wave UUT/U1/U9/U2/U2/*  	 
 
#add wave -named_row "------------------------diag switch-------------------------------------" 
#wave UUT/U1/U9/U1/U2/*  
  
add wave -named_row "------------------------Mux input switch-------------------------------------" 
wave UUT/U1/U9/U7/U4/*  	  

add wave -named_row "------------------------Mux STD-------------------------------------" 
wave UUT/U1/U9/U7/U5/* 

add wave -named_row "------------------------Mux bin -------------------------------------" 
wave UUT/U1/U9/U7/U3/* 

add wave -named_row "------------------------Mux output switch-------------------------------------" 
wave UUT/U1/U9/U7/U2/* 


#add wave -named_row "------------------------sim data-------------------------------------" 
#wave UUT/U3/*
	
#add wave -named_row "------------------------Prog control -------------------------------------" 
#wave UUT/U1/U5/U1/*

#add wave -named_row "------------------------Serial Com -------------------------------------" 
#wave UUT/U1/U5/U2/*  

add wave -named_row "------------------------mblaze intf-------------------------------------" 
wave UUT/U1/U4/* 

#add wave -named_row "------------------------fifo out-------------------------------------" 
#wave UUT/U1/U33/*  	   

# add wave -named_row "------------------------Real Data1-------------------------------------" 
#wave UUT/U1/U9/U1/U1/* 

add wave -named_row "------------------------afpa diag-------------------------------------" 
wave UUT/U1/U9/U1/U4/* 

add wave -named_row "------------------------cropping-------------------------------------" 
wave UUT/U1/U9/U8/* 

add wave -named_row "------------------------cropping-------------------------------------" 
wave UUT/U1/U9/U8/* 

add wave -named_row "------------------------cropping pos-------------------------------------" 
wave UUT/U1/U9/U8/U1/*

add wave -named_row "------------------------cropping sel DATA-------------------------------------" 
wave UUT/U1/U9/U8/U2/*	 

add wave -named_row "------------------------cropping sel FLAG1-------------------------------------" 
wave UUT/U1/U9/U8/U3/*		   

add wave -named_row "------------------------cropping sel FLAG2-------------------------------------" 
wave UUT/U1/U9/U8/U4/*		   

add wave -named_row "------------------------cropping core-------------------------------------" 
wave UUT/U1/U9/U8/U5/*

#add wave -named_row "------------------------line mux-------------------------------------" 
#wave UUT/U1/U9/U17/*
#
#-- mb_interface	   
#add wave -named_row "------------------------bb1920 data gen-------------------------------------"		 
#wave UUT/U3/U3/*
#		 
#		 
#add wave -named_row "------------------------real_data(even)-------------------------------------" 
#wave UUT/U1/U9/U2/U1/*
#
add wave -named_row "------------------------data dispatcher (even)-------------------------------------" 
wave UUT/U1/U9/U18/*
#
# add wave -named_row "------------------------sequencer-------------------------------------" 
# wave UUT/U1/U2/*
#   add wave -named_row "------------------------trig ctler-------------------------------------" 
#wave UUT/U1/U1/*
#
#wave UUT/U1/U4/*  
##
## 
add wave -named_row "------------------------TOP-------------------------------------" 
wave UUT/*
##wave UUT/U1/U5/U1/* 
##wave UUT/U1/U5/U2/*
#
#
#
#wave UUT/U1/U9/U5/*	  
##wave UUT/U3/*
##wave UUT/U3/U3/*
#
##
##
##wave UUT/U1/U9/U2/U4/U2/*
##wave UUT/U1/U9/U2/U2/*
##wave UUT/U1/U9/U1/*
#
##wave UUT/U1/U9/U8/* 
##wave UUT/U1/U9/U8/U5/*
#
#
#wave UUT/U1/*
#--run 10 ms
run 100 ms  
--9.1 ms
