adel -all
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\FPA_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\Proxy_define.vhd 

# sources FPa common 
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do  

#pour la simulation 
acom D:\Telops\FIR-00251-Proc\IP\fwft_afifo_w62_d16\fwft_afifo_w62_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w72_d16\fwft_sfifo_w72_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w33_d16\fwft_sfifo_w33_d16_funcsim.vhdl
 
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\brd_id_reader.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_id_reader.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\flex_brd_id_reader.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\LL8_ext_to_spi_tx.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_switch_ctrl.vhd

#acom d:\Telops\Common_HDL\SPI\ads1118_driver.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\monitoring_adc_ctrl.vhd

acom d:\Telops\Common_HDL\SPI\spi_rx.vhd
acom d:\Telops\Common_HDL\SPI\spi_tx.vhd
#acom d:\Telops\FIR-00251-Proc\src\QuadADC\HDL\quad_adc_ctrl.vhd
#
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\spi_mux_ctler.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_services_ctrl.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_services.bde 

acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_counter.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_mux.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_int_signal_gen.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_mean.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_selector.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_sum.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_dispatcher.vhd

acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_clks_gen.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_diag_data_gen.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_digio_map.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_dval_gen.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_pixel_reorder.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_prog_ctrler.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_spi_feeder.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_sync_flag_gen.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_mblaze_intf.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_data_ctrl.bde  

--acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A\src\isc0207A_intf_testbench.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0207A\src\TestBench\isc0207a_data_ctrl_TB.vhd


asim -ses isc0207a_data_ctrl_TB 

-- diag gen
--wave UUT/U2/* 

-- diag gen
--wave UUT/U2/Udbg/*

-- dval gen
wave UUT/U1/*

--wave UUT/U6/*

-- data dispatcher
--wave UUT/U18/* 

-- sample counter
--wave UUT/U22/*

-- sample selection
--wave UUT/U7/*

-- sample sum
--wave UUT/U23/* 

-- sample mean
--wave UUT/U28/*

-- data reorder
--wave UUT/U12/*
                     
run 4.5 ms
