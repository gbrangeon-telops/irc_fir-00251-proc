
adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $FIR251PROC/src/FPA/isc0804A/HDL/FPA_define.vhd
acom $FIR251PROC/src/FPA/isc0804A/HDL/Proxy_define.vhd 
acom $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
acom $FIR251COMMON/VHDL/Utilities/rst_conditioner.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do


acom $COMMON_HDL/Utilities/reset_extension.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_min_max_ctrl.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_high_duration.vhd
acom  $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_high_low_duration.bde


acom $FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd
acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d16/t_axi4_stream64_afifo_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d512/t_axi4_stream64_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d1024/t_axi4_stream64_afifo_d1024_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d1024/t_axi4_stream64_sfifo_d1024_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d2048/t_axi4_stream64_sfifo_d2048_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d16384_lim/t_axi4_stream64_sfifo_d16384_lim_sim_netlist.vhdl
acom $FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd
acom $FIR251PROC/IP/325/fwft_sfifo_w72_d16/fwft_sfifo_w72_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d256/fwft_sfifo_w3_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w76_d256/fwft_sfifo_w76_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream32_afifo_d512/t_axi4_stream32_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w16_d256/fwft_sfifo_w16_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w43_d512/fwft_sfifo_w43_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w8_d256/fwft_afifo_w8_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_wr66_rd132_d32/fwft_afifo_wr66_rd132_d32_sim_netlist.vhdl

acom $FIR251PROC/IP/325/fwft_sfifo_w32_d256/fwft_sfifo_w32_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w96_d128/fwft_afifo_w96_d128_sim_netlist.vhdl
acom $FIR251PROC/IP/325/afifo_w72_d16/afifo_w72_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/isc0207A_3k_8_3_MHz_mmcm/isc0207A_3k_8_3_MHz_mmcm_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w32_d256/fwft_sfifo_w32_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w96_d128/fwft_afifo_w96_d128_sim_netlist.vhdl
acom $FIR251PROC/IP/325/afifo_w72_d16/afifo_w72_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/isc0804A_11_1_MHz_mmcm/isc0804A_11_1_MHz_mmcm_sim_netlist.vhdl

acom $COMMON_HDL/SPI/ads1118_driver.vhd
acom $COMMON_HDL/SPI/spi_rx.vhd
acom $COMMON_HDL/SPI/spi_tx.vhd
acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream64_fifo.vhd
acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr64_rd128_fifo.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/var_shift_reg_w16_d32.vhd

acom $FIR251COMMON/VHDL/signal_stat/period_duration.vhd
do $FIR251PROC/src/FPA/isc0804A/HDL/compil_isc0804A.do

acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/afpa_single_div_ip.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/var_shift_reg_w16_d32.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/afpa_single_div_ip.vhd

acom $FIR251PROC/aldec/src/FPA/isc0804A/src/brd_mux_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/monit_adc_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/fpa_temp_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/digio_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/flexV_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/brd_switch_dummy.vhd

acom $FIR251PROC/aldec/src/FPA/isc0804A/src/detector_trace_define.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/re_distance_measure.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/edge_measure_ref_clk.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/edge_measure_stat.vhd
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/edge_distance_measure.bde
acom $FIR251PROC/src/Quad_serdes/HDL/quad_data_sync.vhd

acom $FIR251PROC/aldec/src/FPA/isc0804A/src/TestBench/isc0804A_intf_testbench_pkg.vhd 
acom $FIR251PROC/aldec/src/FPA/isc0804A/src/isc0804A_intf_testbench.bde

acom  $FIR251PROC/aldec/src/FPA/isc0804A/src/TestBench/isc0804A_intf_testbench_TB.vhd

asim -ses isc0804A_intf_testbench_TB 

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
--wave UUT/U1/U21/U5/U2/* 

-- mb_interface
--wave UUT/U1/U4/*  


--

-- intf_sequencer
--wave UUT/U1/U2/*  

-- fpa_prog_controller
--wave UUT/U1/U5/U2/* 

-- status
wave UUT/U1/U6/* 


-- clocks_gen
#wave UUT/U1/U26/U1/* 
#wave UUT/U1/U26/U2/* 
wave UUT/U1/U26/*

--wave UUT/U1/U5/U4/* 
--wave UUT/U14/U11/*
--wave UUT/TRACE_ERR*
 
 -- flex brd_id_reader
--wave UUT/U1/U21/U6/U2/*
--wave UUT/U1/U21/U6/*

--wave UUT/U1/U5/U5/U5/* 
 
--wave UUT/U1/U5/U5/U1/* 
--wave UUT/U1/U5/U5/U5/* 
--wave UUT/U1/U5/U5/U6/U1/* 
--wave UUT/U1/U5/U5/U7/U3/U8/* 
--wave UUT/U1/U5/U5/U7/U1/*

-- le outfifo
--wave UUT/U1/U5/U5/U6/U3/* 

wave UUT/U1/U5/U5/U5/*
#wave UUT/U1/U5/U5/U5/*
#wave UUT/U1/U5/U2/U1/* 
#wave UUT/U1/U9/U1/U1/* 
#wave UUT/U1/U9/U1/U2/*
#wave UUT/U1/U9/U1/U3/* 
#wave UUT/U1/U9/U1/U4/* 
#wave UUT/U1/U9/U1/U5/* 
#wave UUT/U1/U9/U1/U6/*
#wave UUT/U1/U9/U1/U7/*
#wave UUT/U1/U9/U1/U8/*
#wave UUT/U1/U9/U1/U9/*

--wave UUT/U1/U5/U21/*

--wave UUT/U1/U9/U10/*

#wave UUT/U1/U9/CH1/*
#wave UUT/U1/U9/CH2/*   

#wave UUT/U1/U9/CH3/*
#wave UUT/U16/*  
  
--wave UUT/U1/U5/U4/*

--wave UUT/U1/*
--wave UUT/U1/U4/*
#                           
#wave UUT/U1/U9/U1/g0/U8/*
#wave UUT/U1/U9/U1/g0/U4/*
#wave UUT/U1/U9/U1/g0/U5/*
#wave UUT/U1/U9/U1/g0/U1/*
#wave UUT/U1/U9/U1/g0/U7/*
#wave UUT/U1/U9/U1/g0/U3/*
--wave UUT/U11/*
--wave UUT/U1/U2/*

--wave UUT/U1/U23/U1/*
--wave UUT/U1/U23/U5/*
--wave UUT/U15/*

--wave UUT/U1/U9/U11/*
--wave UUT/U1/U9/U12/U3/*
#wave UUT/U1/U5/U2/*
#wave UUT/U1/U5/U2/U21/*
#wave UUT/U1/U5/*
#
#
#wave UUT/U1/U9/U2/U4/U2/*
#wave UUT/U1/U9/U2/U4/U2/UB/*
#wave UUT/U1/U9/U13/* 
#wave UUT/U1/U9/U14/*
#wave UUT/U1/U9/U18/*
#wave UUT/U1/U9/U6/*
#wave UUT/U1/U9/U19/*
#wave UUT/U1/U9/U10/*
-- wave UUT/U1/U27/*
--wave UUT/U1/U9/*

wave UUT/U1/*

run 100 ms
--run 30 ms  
--9.1 ms
