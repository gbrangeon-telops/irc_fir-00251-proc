#savealltabs
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/proxy_define.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd \
 $FIR251COMMON/VHDL/img_header_define.vhd \
 $FIR251COMMON/VHDL/iserdes/clink/fpa_serdes_define.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do
do $FIR251COMMON/compile_all_common.do

#signal stat
acom \
 "$FIR251PROC/src/Trig/HDL/trig_define.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/min_max_define.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/min_max_ctrl.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/delay_measurement.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/high_duration.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/trig_delay.bde" \
 "$FIR251COMMON/VHDL/signal_stat/period_duration.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/trig_period.bde" \
 "$FIR251COMMON/VHDL/signal_stat/trig_period_8ch.bde"

# sources FPA common
acom -relax $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/ad5648_driver.vhd
acom -incr -nowarn DAGGEN_0523 \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/signal_filter.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/brd_id_reader.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/ddc_brd_id_reader.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/LL8_ext_to_spi_tx.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_switch_ctrl.vhd \
 $COMMON_HDL/SPI/ads1118_driver.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/monitoring_adc_ctrl.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/spi_mux_ctler_sadc.vhd \
 $FIR251PROC/src/FPA/fpa_trig_precontroller.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_trig_controller.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_hw_driver_ctrler.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_prog_ctler_kernel.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleG_dac_spi_feeder.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleG_prog_ctrler.bde \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_intf_sequencer.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_status_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/frm_in_progress_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_min_max_ctrl.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/edge_counter.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt_min_max.bde \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_watchdog_module.bde

# sources Calcium
do $FIR251PROC/src/FPA/calcium_proxy/HDL/compil_kpix_recombine.do
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_clks_gen.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_io_intf.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_mblaze_intf.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_services_ctrl.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_services.bde \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_int_signal_gen.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_prog_spi_driver.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_prog_mem.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_prog_ctrler_core.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_prog_ctrler.bde \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_hw_driver.bde \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_rx_data_fifo.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_diag_data_gen.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_flow_mux.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_data_dispatcher.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_quad_to_axis32.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_data_compression_core.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_data_compression.bde \
 -2008 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_data_ctrl.bde \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/calcium_intf.bde
