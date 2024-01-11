
adel -all

# IP
--acom D:\Telops\FIR-00251-Proc\IP\325\afifo_w57d16\afifo_w57d16_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w62_d16\fwft_afifo_w62_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w72_d16\fwft_sfifo_w72_d16_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w72_d128\fwft_afifo_w72_d128_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w1_d16\fwft_sfifo_w1_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w3_d256\fwft_sfifo_w3_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w76_d256\fwft_sfifo_w76_d256_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w8_d256\fwft_sfifo_w8_d256_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w64_d256\fwft_sfifo_w64_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\sfifo_w8_d64\sfifo_w8_d64_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\sfifo_w8_d64_no_output_reg\sfifo_w8_d64_no_output_reg_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w56_d256\fwft_sfifo_w56_d256_sim_netlist.vhdl
--acom D:\Telops\FIR-00251-Proc\IP\325\afifo_w57d16\afifo_w57d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w16_d256\fwft_sfifo_w16_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w43_d512\fwft_sfifo_w43_d512_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w72_d512\fwft_sfifo_w72_d512_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w8_d256\fwft_afifo_w8_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w32_d16\fwft_afifo_w32_d16_sim_netlist.vhdl 
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w4_d1024\fwft_sfifo_w4_d1024_sim_netlist.vhdl 
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w32_d256\fwft_sfifo_w32_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w96_d128\fwft_afifo_w96_d128_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w76_d512\fwft_afifo_w76_d512_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w32_d256\fwft_sfifo_w32_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w96_d128\fwft_afifo_w96_d128_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w72_d16\fwft_afifo_w72_d16_sim_netlist.vhdl	 
acom D:\Telops\FIR-00251-Proc\IP\325\tdp_ram_w8_d2048\tdp_ram_w8_d2048_sim_netlist.vhdl

acom D:\Telops\FIR-00251-Proc\IP\325\bb1920D_clks_mmcm\bb1920D_clks_mmcm_sim_netlist.vhdl

# FPA module
do D:\Telops\FIR-00251-Proc\src\FPA\calcium640D\HDL\compil_calcium640D.do

# Testbench
acom D:\Telops\FIR-00251-Proc\aldec\src\FPA\calcium640D\src\calcium640D_intf_testbench_pkg.vhd 
acom D:\Telops\FIR-00251-Proc\aldec\src\FPA\calcium640D\src\calcium640D_intf_testbench.bde
acom D:\Telops\FIR-00251-Proc\aldec\src\FPA\calcium640D\src\calcium640D_intf_testbench_TB.vhd

asim -ses calcium640D_intf_testbench_TB 
   
add wave -named_row "------------------------line mux-------------------------------------" 
wave UUT/U1/U9/U17/*

-- mb_interface	   
add wave -named_row "------------------------bb1920 data gen-------------------------------------"		 
wave UUT/U3/U3/*
		 
		 
add wave -named_row "------------------------real_data(even)-------------------------------------" 
wave UUT/U1/U9/U2/U1/*

add wave -named_row "------------------------data dispatcher (even)-------------------------------------" 
wave UUT/U1/U9/U18/*

 add wave -named_row "------------------------sequencer-------------------------------------" 
 wave UUT/U1/U2/*
   add wave -named_row "------------------------trig ctler-------------------------------------" 
wave UUT/U1/U1/*

wave UUT/U1/U4/*  
#
# 
wave UUT/U1/U5/U1/U6A/*
wave UUT/U1/U5/U1/* 
wave UUT/U1/U5/U2/*



wave UUT/U1/U9/U5/*	  
#wave UUT/U3/*
#wave UUT/U3/U3/*

#
#
#wave UUT/U1/U9/U2/U4/U2/*
#wave UUT/U1/U9/U2/U2/*
#wave UUT/U1/U9/U1/*

#wave UUT/U1/U9/U8/* 
#wave UUT/U1/U9/U8/U5/*


wave UUT/U1/*

run 10 ms

