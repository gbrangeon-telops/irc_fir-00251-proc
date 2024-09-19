
adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fastrd2/fastrd2_define.vhd
#acom $FIR251PROC/src/FPA/common/tests/tests2x_define.vhd
acom $FIR251PROC/src/FPA/scorpiomwA_300Hz/HDL/FPA_define.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/Proxy_define.vhd 
acom $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd

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
acom $FIR251PROC/src/FPA/fpa_trig_precontroller.vhd

acom $FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd
--acom $FIR251PROC/IP/160/fwft_afifo_w62_d16/fwft_afifo_w62_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w72_d16/fwft_sfifo_w72_d16_sim_netlist.vhdl
#acom $FIR251PROC/IP/160/fwft_sfifo_w33_d16/fwft_sfifo_w33_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w76_d16/fwft_sfifo_w76_d16_sim_netlist.vhdl
--acom $FIR251PROC/IP/160/fwft_sfifo_w8_d256/fwft_sfifo_w8_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w32_d256/fwft_sfifo_w32_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w16_d256/fwft_sfifo_w16_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_sfifo_w4_d1024/fwft_sfifo_w4_d1024_sim_netlist.vhdl
 
acom $FIR251PROC/IP/160/t_axi4_stream64_afifo_d512/t_axi4_stream64_afifo_d512_sim_netlist.vhdl

acom $FIR251PROC/IP/160/afifo_w72_d16/afifo_w72_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_afifo_w96_d128/fwft_afifo_w96_d128_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_afifo_w8_d256/fwft_afifo_w8_d256_sim_netlist.vhdl

acom $FIR251PROC/IP/160/fwft_sfifo_w72_d512/fwft_sfifo_w72_d512_sim_netlist.vhdl

acom $FIR251PROC/IP/160/fwft_sfifo_w76_d256/fwft_sfifo_w76_d256_sim_netlist.vhdl
acom $FIR251PROC/IP/160/fwft_afifo_w72_d16/fwft_afifo_w72_d16_sim_netlist.vhdl


acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/var_shift_reg_w16_d32.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A_3k/src/afpa_single_div_ip.vhd
acom $FIR251PROC/IP/160/scorpiomwA_27MHz_mmcm/scorpiomwA_27MHz_mmcm_sim_netlist.vhdl


acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream64_fifo.vhd
acom $FIR251COMMON/VHDL/Utilities/rst_conditioner.vhd

acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/flex_brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/LL8_ext_to_spi_tx.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_switch_ctrl.vhd

acom $COMMON_HDL/SPI/ads1118_driver.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/monitoring_adc_ctrl.vhd

acom $COMMON_HDL/SPI/spi_rx.vhd
acom $COMMON_HDL/SPI/spi_tx.vhd
#acom $FIR251PROC/src/QuadADC/HDL/quad_adc_ctrl.vhd
acom $FIR251PROC/src/Quad_serdes/HDL/quad_adc_ctrl.vhd
acom $FIR251PROC/src/Quad_serdes/HDL/quad_data_sync.vhd
acom $FIR251PROC/src/Quad_serdes/HDL/quad_data_sync_v2.vhd

acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/spi_mux_ctler.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_services_ctrl.vhd


acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_sample_counter.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_data_mux.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_int_signal_gen.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_sample_mean.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_sample_selector.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_sample_sum.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_data_dispatcher.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd
acom $FIR251COMMON/VHDL/Fifo/t_axi4_stream64_fifo.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_services.bde

do $FIR251PROC/src/FPA/scorpiomwA_300Hz/HDL/compil_scorpiomwA_300Hz.do 

acom $FIR251PROC/aldec/src/FPA/isc0207A/src/brd_mux_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A/src/monit_adc_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/isc0207A/src/brd_switch_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/scorpiomwA/src/fpa_temp_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/scorpiomwA/src/digio_dummy.vhd
acom $FIR251PROC/aldec/src/FPA/scorpiomwA/src/flexV_dummy.vhd

acom $FIR251PROC/aldec/src/FPA/scorpiomwA_300Hz/src/scorpiomwA_300Hz_intf_testbench.bde

acom $FIR251PROC/aldec/src/FPA/scorpiomwA_300Hz/src/TestBench/scorpiomwA_300Hz_intf_testbench_pkg.vhd
acom  $FIR251PROC/aldec/src/FPA/scorpiomwA_300Hz/src/TestBench/scorpiomwA_300Hz_intf_testbench_TB.vhd

asim -ses scorpiomwA_300Hz_intf_testbench_TB 

# Clock Generator
wave UUT/U1/U26/* 

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

-- mb_interface
#wave UUT/U1/U4/*  

-- digio map
--wave UUT/U1/U19/*

-- intf_sequencer
--wave UUT/U1/U2/*  

-- fpa_prog_controller
--wave UUT/U1/U5/U2/* 


-- module FPA
--wave UUT/U1/* 

--wave UUT/U14/U1/* 
--wave UUT/U14/U11/*
--wave UUT/TRACE_ERR*
 
 -- flex brd_id_reader
--wave UUT/U1/U21/U6/U2/*
--wave UUT/U1/U21/U6/*


--wave UUT/U1/U9/U22/*  OK
--wave UUT/U1/U9/U23/*  OK

--wave UUT/U1/U9/U7/*
--wave UUT/U1/U9/U2/U1/* 
--wave UUT/U1/U9/U18/*

#wave UUT/U1/U5/U5/U4/* 
#wave UUT/U1/U5/U5/U2/* 
#wave UUT/U1/U5/U5/U10/*
#wave UUT/U1/U5/U5/U1/*
#wave UUT/U1/U5/U5/U6/U1/*
#wave UUT/U1/U5/U5/U5/*
#wave UUT/U1/U9/U18/*

#wave UUT/U1/U9/U15/*
#wave UUT/U1/U9/U2/U1/*
#wave UUT/U1/U9/U2/U2/*
#wave UUT/U1/U9/U2/U4/*
#
#wave UUT/U1/U27/U2/*
#wave UUT/U1/U27/U1/U1/*
#wave UUT/U1/U27/U1/U19/*
#wave UUT/U1/U27/U1/U18/*
#wave UUT/U1/U27/U1/U28/*


#wave UUT/U1/U29/*
#wave UUT/U1/U29/U1/*
#wave UUT/U1/U29/U2/*
#wave UUT/U1/U29/U5/*

wave UUT/U1/*

--wave UUT/U1/U5/U2/U6/*

run 400 ms  




