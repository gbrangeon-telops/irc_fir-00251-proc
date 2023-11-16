
adel -all
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium640D\HDL\FPA_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\proxy_define.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd
acom d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd
acom d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd

# utilities
do d:\Telops\FIR-00251-Proc\src\compil_utilities.do

# FPA common 
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\signal_filter.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\brd_id_reader.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_id_reader.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\flex_brd_id_reader.vhd
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_sim_netlist.vhdl
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\LL8_ext_to_spi_tx.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_switch_ctrl.vhd
acom d:\Telops\Common_HDL\SPI\ads1118_driver.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\monitoring_adc_ctrl.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\spi_mux_ctler.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\spi_mux_ctler_sadc.vhd
acom d:\Telops\FIR-00251-Proc\src\Quad_serdes\HDL\quad_adc_ctrl.vhd

# calcium services
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_services_ctrl.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_services.bde

# emulateur
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\brd_mux_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\monit_adc_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\fpa_temp_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\digio_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\flexV_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\brd_switch_dummy.vhd

# testbench
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\calcium_services_testbench.bde
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\calcium_services_testbench_stim.vhd




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

-- adc brd_id_reader
--wave UUT/U1/U5/*

-- services ctrl
--wave UUT/U1/U8/* 

-- flex brd_id_reader
--wave UUT/U1/U6/*



run 3 ms
