#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\fpa_serdes_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do
do D:\Telops\FIR-00251-Common\compile_all_common.do

#signal stat
acom \
 "D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_define.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\min_max_define.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\min_max_ctrl.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\delay_measurement.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\high_duration.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_delay.bde" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\period_duration.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_period.bde" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_period_8ch.bde"

# sources FPA common
acom -relax d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\ad5648_driver.vhd
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\signal_filter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\brd_id_reader.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\ddc_brd_id_reader.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\LL8_ext_to_spi_tx.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_switch_ctrl.vhd \
 d:\Telops\Common_HDL\SPI\ads1118_driver.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\monitoring_adc_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\spi_mux_ctler_sadc.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\fpa_trig_precontroller.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_hw_driver_ctrler.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_prog_ctler_kernel.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleG_dac_spi_feeder.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleG_prog_ctrler.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\frm_in_progress_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_min_max_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\edge_counter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt_min_max.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_watchdog_module.bde

# sources Calcium
do D:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\compil_kpix_recombine.do
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_clks_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_io_intf.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_mblaze_intf.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_services_ctrl.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_services.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_int_signal_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_prog_spi_driver.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_prog_mem.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_prog_ctrler_core.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_prog_ctrler.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_hw_driver.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_rx_data_fifo.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_diag_data_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_flow_mux.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_data_dispatcher.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_quad_to_axis32.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_data_compression_core.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_data_compression.bde \
 -2008 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_data_ctrl.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\calcium_intf.bde
