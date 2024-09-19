
setactivelib work
clearlibrary pelicanD



acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd

acom $FIR251COMMON/VHDL/Utilities/rst_conditioner.vhd

acom $FIR251PROC/IP/160/fwft_afifo_w28_d16/fwft_afifo_w28_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w32_d16/fwft_sfifo_w32_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w64_d16/fwft_sfifo_w64_d16_sim_netlist.vhdl
--acom $FIR251PROC/IP/160/fwft_sfifo_w41_d16/fwft_sfifo_w41_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w40_d16/fwft_sfifo_w40_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/tdp_ram_w8_d2048/tdp_ram_w8_d2048_sim_netlist.vhdl
acom $FIR251PROC/IP/160/t_axi4_stream32_sfifo_d2048/t_axi4_stream32_sfifo_d2048_sim_netlist.vhdl
acom $FIR251PROC/IP/160/t_axi4_stream32_afifo_d512/t_axi4_stream32_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/160/t_axi4_stream64_afifo_d512/t_axi4_stream64_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/160/sfifo_w8_d64/sfifo_w8_d64_sim_netlist.vhdl	
acom $FIR251PROC/IP/160/sfifo_w8_d64_no_output_reg/sfifo_w8_d64_no_output_reg_sim_netlist.vhdl
 
acom "$FIR251PROC/IP/160/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl"
acom "$FIR251PROC/IP/160/ip_axis_32_to_64/ip_axis_32_to_64_sim_netlist.vhdl"
do $FIR251PROC/src/FPA/PelicanD/hdl/compil_PelicanD.do
acom "$FIR251PROC/aldec/src/FPA/PelicanD/src/TestBench/pelicand_testbench_pkg.vhd"	 

acom "$FIR251COMMON/VHDL/Buffering/BufferingDefine.vhd"
do "$FIR251PROC/src/Trig/HDL/compil_trig_gen.do"
#runexe "$FIR251PROC/src/copy_to_cpp.bat"
#adel mb_model
#cd $FIR251PROC/aldec/src/FPA/PelicanD/src
#buildc PelicanD.dlm
#addfile mb_model.dll
#addsc mb_model.dll
##
#acom "$FIR251PROC/aldec/src/Testbench/SystemC/mb_model_wrapper.vhd"	 
acom $FIR251PROC/aldec/src/FPA/PelicanD/src/TestBench/scd_proxy_sim.vhd
acom $FIR251PROC/aldec/src/FPA/PelicanD/src/PelicanD_top_tb.bde
acom $FIR251PROC/aldec/src/FPA/PelicanD/src/TestBench/pelicand_top_tb_TB.vhd
#
#
asim -ses pelicand_top_tb_TB  													   
add wave -noreg -logic {/pelicand_top_tb_tB/ACQ_TRIG} 
add wave -noreg -logic {/pelicand_top_tb_tB/XTRA_TRIG} 
add wave -noreg -logic {/pelicand_top_tb_tb/UUT/U1/U9/U6/IWR_TRIG}
add wave -noreg -logic {/pelicand_top_tb_tB/UUT/U1/U9/U6/ACQ_MODE}  
add wave -noreg -logic {/pelicand_top_tb_tB/UUT/U1/U9/U6/FPA_INT}  
add wave -noreg -logic {/pelicand_top_tb_tB/UUT/U1/U9/U6/ACQ_INT} 
add wave -noreg -logic {/pelicand_top_tb_tb/UUT/U1/U9/U6/force_header_fast}  
add wave -noreg -logic {/pelicand_top_tb_tb/UUT/U1/U9/U6/fast_hder_sm} 
add wave -noreg -logic {/pelicand_top_tb_tb/UUT/U1/U9/U6/pix_out_sm}  
add wave -noreg -logic {/pelicand_top_tb_tb/UUT/U1/U9/U6/iwr_last_readout_fsm} 
add wave -noreg -logic {/pelicand_top_tb_tb/UUT/U1/U9/U6/iwr_first_readout_fsm}  
add wave -noreg -logic {/pelicand_top_tb_tB/UUT/U1/U9/U6/PIX_MOSI.TVALID} 
add wave -noreg -logic {/pelicand_top_tb_tB/UUT/U1/U9/U6/PIX_MOSI.TDATA}  


#add wave -named_row "Stim"
#add wave UUT/U3/*	 

add wave -noreg -logic {} 


add wave -named_row "UTT" 
wave UUT/* 

add wave -named_row "fifo out"
add wave UUT/U1/U8/*	

add wave -named_row "axis 32 to 64"
add wave UUT/U1/U24/*	

  add wave -named_row "Data dispatcher"
add wave UUT/U1/U9/U6/*



add wave -named_row "fpa intf sequencer" 
wave UUT/U1/U2/* 

add wave -named_row "scd pre trig ctler" 
wave UUT/U1/U21/* 

 add wave -named_row "mblaze intf" 
wave UUT/U1/U4/* 


add wave -named_row "scd serial module" 
wave UUT/U1/U5/U2/* 


add wave -named_row "scd trig ctler" 
wave UUT/U1/U1/*  


#
#add wave -named_row "fpa intf out"  
#wave UUT/U1/U8/*
#	


#add wave -named_row "status gen" 
#wave UUT/U1/U6/* 
#
#add wave -named_row "watchdog" 
#wave UUT/U1/U26/* 
  

add wave -named_row "scd prog ctrler" 
wave UUT/U1/U5/U1/* 

add wave -named_row "scd prog ctrler" 
wave UUT/U3/*   

run 30 ms