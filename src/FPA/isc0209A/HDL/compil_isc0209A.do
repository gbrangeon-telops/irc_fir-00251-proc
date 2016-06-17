#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPa common 
acom -relax d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\ad5648_driver.vhd 

acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\Common_HDL\SPI\ads1118_driver.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\signal_filter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd  \
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
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_real_mode_dval_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_diag_data_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_flow_mux.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_dval_gen.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_chn_diversity_ctrler.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_pixel_reorder.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_ctrl.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\concat_1_to_8.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\LL8_ext_fifo8.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_hw_driver_ctrler.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_prog_ctler_kernel.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleG_dac_spi_feeder.vhd \
 d:\Telops\FIR-00251-Proc\src\QuadADC\HDL\quad_adc_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_services.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleG_prog_ctrler.bde


# fichiers isc0209A
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_clks_gen.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_readout_ctrler.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_digio_map.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_mblaze_intf.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_mode_reg.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_window_reg.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_prog_mux.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_prog_spi_feeder.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_intf.bde
 
                                            