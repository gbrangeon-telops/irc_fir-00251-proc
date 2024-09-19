
adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $FIR251PROC/src/FPA/calcium640D/HDL/FPA_define.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/HDL/proxy_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd

# utilities
do $FIR251PROC/src/compil_utilities.do

# FPA common 
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/signal_filter.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/brd_id_reader.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/ddc_brd_id_reader.vhd
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/LL8_ext_to_spi_tx.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_switch_ctrl.vhd
acom $COMMON_HDL/SPI/ads1118_driver.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/monitoring_adc_ctrl.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/spi_mux_ctler_sadc.vhd

# calcium services
acom $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_services_ctrl.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_services.bde

# emulateur
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/monit_adc_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/fpa_temp_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/digio_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/flexV_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/brd_switch_dummy.vhd

# testbench
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/calcium_services_testbench.bde
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/calcium_services_testbench_stim.vhd




asim -ses calcium_services_testbench_stim 

wave UUT/U1/*

-- spi_mux_ctrl
--wave UUT/U1/U1/* 
 
-- monit adc
--wave UUT/U1/U4/*
--wave UUT/U1/U4/U2/*
-- monit adc dummy
--wave UUT/U7/* 
 
-- switch
--wave UUT/U1/U3/*

-- services ctrl
--wave UUT/U1/U8/* 

-- ddc brd_id_reader
--wave UUT/U1/U6/*
--wave UUT/U1/U6/U2*



run 8 ms
