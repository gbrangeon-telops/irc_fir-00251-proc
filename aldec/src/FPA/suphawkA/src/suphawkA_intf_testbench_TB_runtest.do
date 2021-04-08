
adel -all
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fastrd2\fastrd2_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd


do D:\Telops\FIR-00251-Proc\src\compil_utilities.do


acom D:\Telops\FIR-00251-Proc\IP\160\afifo_w72_d16\afifo_w72_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_afifo_w8_d256\fwft_afifo_w8_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_afifo_w96_d128\fwft_afifo_w96_d128_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w3_d256\fwft_sfifo_w3_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w8_d16\fwft_sfifo_w8_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w16_d256\fwft_sfifo_w16_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w32_d256\fwft_sfifo_w32_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w72_d16\fwft_sfifo_w72_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w76_d256\fwft_sfifo_w76_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\sfifo_w10_d256\sfifo_w10_d256_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\suphawkA_10_0_MHz_mmcm\suphawkA_10_0_MHz_mmcm_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\160\t_axi4_stream64_afifo_d512\t_axi4_stream64_afifo_d512_sim_netlist.vhdl

acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A_3k\src\var_shift_reg_w16_d32.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A_3k\src\afpa_single_div_ip.vhd

acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_min_max_ctrl.vhd
acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_high_duration.vhd
acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_high_low_duration.bde

acom D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream64_fifo.vhd
acom D:\Telops\FIR-00251-Common\VHDL\Utilities\axil32_to_native.vhd

do D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\compil_suphawkA.do

acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A\src\brd_mux_dummy.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A\src\monit_adc_dummy.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A\src\brd_switch_dummy.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\suphawkA\src\fpa_temp_dummy.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\suphawkA\src\digio_dummy.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\suphawkA\src\flexV_dummy.vhd

acom D:\Telops\FIR-00251-Proc\src\Quad_serdes\HDL\quad_data_sync.vhd

acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\suphawkA\src\suphawkA_intf_testbench.bde

acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\suphawkA\src\suphawka_intf_testbench_pkg.vhd

acom  d:\Telops\FIR-00251-Proc\aldec\src\FPA\suphawkA\src\suphawkA_intf_testbench_TB.vhd

asim -ses suphawkA_intf_testbench_TB 


-- spi_mux_ctrl
--wave UUT/U1/U21/U1/* 
 
-- monit adc driver
--wave UUT/U1/U21/U4/U2/* 


-- monit adc
--wave UUT/U1/U21/U4/*

-- monit adc dummy
--wave UUT/U7/* 
 
-- switch
--wave UUT/U1/U21/U3/*


-- adc brd_id_reader
--wave UUT/U1/U21/U5/U2/*

-- services ctrl
--wave UUT/U1/U21/U8/* 

#-- mb_interface
#wave UUT/U1/U4/*  
#
#-- clks
#wave UUT/U1/U26/*  


-- intf_sequencer
--wave UUT/U1/U2/* 

--wave UUT/U14/U1/* 
--wave UUT/U14/U11/*
--wave UUT/TRACE_ERR*
 
-- flex brd_id_reader
--wave UUT/U1/U21/U6/U2/*
--wave UUT/U1/U21/U6/*

wave UUT/U1/U9/*
--wave UUT/U1/U9/U22/*  OK
--wave UUT/U1/U9/U23/*  OK
--wave UUT/U1/U9/U7/*
--wave UUT/U1/U9/U2/U1/U1/* 
--wave UUT/U1/U9/U18/*

--wave UUT/U1/U19/*

--wave UUT/U15/*

#hw driver
#wave UUT/U1/U5/*
#wave UUT/U1/U5/U1/*
#wave UUT/U1/U5/U2/*
#wave UUT/U1/U5/U3/*
#wave UUT/U1/U5/U4/*
#wave UUT/U1/U5/U5/*

wave UUT/U1/*

run 10 ms
