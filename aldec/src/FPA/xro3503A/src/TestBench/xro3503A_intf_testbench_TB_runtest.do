
adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $FIR251PROC/src/FPA/xro3503A/HDL/FPA_define.vhd
acom $FIR251PROC/src/FPA/xro3503A/HDL/Proxy_define.vhd 
acom $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
acom $FIR251COMMON/VHDL/Utilities/rst_conditioner.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do

acom $COMMON_HDL/Utilities/reset_extension.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/signal_filter.vhd

# sources FPa common 
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_trig_controller.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/dfpa_hardw_stat_gen.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_intf_sequencer.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_status_gen.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd

acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_min_max_ctrl.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_high_duration.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_high_low_duration.bde

acom $FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd

acom $FIR251PROC/IP/325/t_axi4_stream64_afifo_d512/t_axi4_stream64_afifo_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d8192_lim/t_axi4_stream64_sfifo_d8192_lim_sim_netlist.vhdl
acom $FIR251PROC/IP/325/t_axi4_stream64_sfifo_d16384_lim/t_axi4_stream64_sfifo_d16384_lim_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w8_d256/fwft_afifo_w8_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w72_d16/fwft_sfifo_w72_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w72_d512/fwft_sfifo_w72_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w1_d16/fwft_sfifo_w1_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d256/fwft_sfifo_w3_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w4_d1024/fwft_sfifo_w4_d1024_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w76_d256/fwft_sfifo_w76_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w8_d16/fwft_sfifo_w8_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w56_d256/fwft_sfifo_w56_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w16_d256/fwft_sfifo_w16_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w43_d512/fwft_sfifo_w43_d512_sim_netlist.vhdl 
acom $FIR251PROC/IP/325/fwft_sfifo_w32_d256/fwft_sfifo_w32_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_w96_d128/fwft_afifo_w96_d128_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_wr66_rd132_d32/fwft_afifo_wr66_rd132_d32_sim_netlist.vhdl
acom $FIR251PROC/IP/325/afifo_w72_d16/afifo_w72_d16_sim_netlist.vhdl

acom $FIR251PROC/aldec/src/FPA/xro3503A/src/var_shift_reg_w16_d32.vhd

acom $FIR251PROC/IP/325/xro3503A_10MHz_mmcm/xro3503A_10MHz_mmcm_sim_netlist.vhdl
acom $FIR251PROC/IP/325/xro3503A_27MHz_mmcm/xro3503A_27MHz_mmcm_sim_netlist.vhdl
acom $FIR251PROC/IP/325/xro3503A_40MHz_mmcm/xro3503A_40MHz_mmcm_sim_netlist.vhdl



acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/flex_brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/LL8_ext_to_spi_tx.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/LL8_ext_to_spi_tx_v2.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_switch_ctrl.vhd
acom $FIR251PROC/src/Quad_serdes/HDL/quad_data_sync.vhd

acom $COMMON_HDL/SPI/ads1118_driver.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/monitoring_adc_ctrl.vhd

acom $COMMON_HDL/SPI/spi_rx.vhd
acom $COMMON_HDL/SPI/spi_tx.vhd
acom $FIR251PROC/src/Quad_serdes/HDL/quad_adc_ctrl.vhd
acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream64_fifo.vhd
acom $FIR251COMMON/VHDL/Utilities/axis64_throughput_ctrl.vhd	 
acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr64_rd128_fifo.vhd

do $FIR251PROC/src/FPA/xro3503A/HDL/compil_xro3503A.do
 
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/brd_mux_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/monit_adc_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/fpa_temp_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/digio_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/flexV_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/brd_switch_dummy.vhd

acom $FIR251PROC/aldec/src/FPA/xro3503A/src/detector_trace_define.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/re_distance_measure.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/edge_measure_ref_clk.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/edge_measure_stat.vhd
acom $FIR251PROC/aldec/src/FPA/xro3503A/src/edge_distance_measure.bde

acom $FIR251PROC/aldec/src/FPA/xro3503A/src/xro3503A_intf_testbench.bde

acom  $FIR251PROC/aldec/src/FPA/xro3503A/src/TestBench/xro3503A_intf_testbench_TB.vhd


asim -ses xro3503A_intf_testbench_TB 

wave UUT/U1/*

-- spi_mux_ctrl
-- wave UUT/U1/U21/U1/* 
 
-- monit adc
-- wave UUT/U1/U21/U4/*
-- wave UUT/U1/U21/U4/U2/*
-- monit adc dummy
-- wave UUT/U7/* 
 
-- switch
-- wave UUT/U1/U21/U3/*

-- adc brd_id_reader
-- wave UUT/U1/U21/U5/*

-- services ctrl
-- wave UUT/U1/U21/U8/* 

 -- flex brd_id_reader
-- wave UUT/U1/U21/U6/*

-- mb_interface
-- wave UUT/U1/U4/*  

-- digio map
-- wave UUT/U1/U19/*

-- intf_sequencer
-- wave UUT/U1/U2/*  

-- hw_driver
-- wave UUT/U1/U5/* 
-- wave UUT/U1/U5/U5/*
-- wave UUT/U1/U5/U2/U2/*

-- data_ctrl
-- wave UUT/U1/U9/*
-- wave UUT/U1/U9/U18/*
-- wave UUT/U1/U9/U6/*
-- wave UUT/U1/U9/U19/*
 
-- clk_gen
-- wave UUT/U1/U26/U1/*

-- status
-- wave UUT/U1/U6/*

-- wave UUT/U14/U1/* 
-- wave UUT/U14/U11/*
-- wave UUT/TRACE_ERR*

-- run 20 us
run 10 ms
