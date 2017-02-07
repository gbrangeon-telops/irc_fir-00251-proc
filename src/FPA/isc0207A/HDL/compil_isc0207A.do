#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPa common 
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\Common_HDL\SPI\ads1118_driver.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd  \
 d:\Telops\FIR-00251-Proc\src\FPA\fpa_trig_precontroller.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\brd_id_reader.vhd      \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_id_reader.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\flex_brd_id_reader.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\LL8_ext_to_spi_tx.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_switch_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\monitoring_adc_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\spi_mux_ctler.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_services_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_counter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_mux.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_int_signal_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_mean.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_selector.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_sample_sum.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_dispatcher.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_prog_ctler_kernel.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleG_dac_spi_feeder.vhd \
 d:\Telops\FIR-00251-Proc\src\QuadADC\HDL\quad_adc_ctrl.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_clks_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_diag_data_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_digio_map.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_dval_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_pixel_reorder.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_prog_ctrler.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_spi_feeder.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_sync_flag_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_mblaze_intf.vhd  \
 d:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream32_fifo.vhd
 
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_services.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_data_ctrl.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleG_prog_ctrler.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_hw_driver.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\isc0207A_intf.bde
 
