#savealltabs
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/proxy_define.vhd \
 $FIR251COMMON/VHDL/img_header_define.vhd \
 $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
 


#utilities
do $FIR251PROC/src/compil_utilities.do

#uarts
acom -incr -nowarn DAGGEN_0523 \
 $COMMON_HDL/RS232/uarts.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/uart_block_tel2000.bde

#signal stat
acom \
 "$FIR251PROC/src/Trig/HDL/trig_define.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/min_max_define.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/min_max_ctrl.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/delay_measurement.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/trig_delay.bde" \
 "$FIR251COMMON/VHDL/signal_stat/period_duration.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/trig_period.bde" \
 "$FIR251COMMON/VHDL/signal_stat/trig_period_8ch.bde"

# sources FPa common 
acom -incr -nowarn DAGGEN_0523 \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/signal_filter.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/brd_id_reader.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_trig_controller.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/dfpa_hardw_stat_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_intf_sequencer.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_status_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/frm_in_progress_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_data_ctrl_map.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_min_max_ctrl.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/edge_counter.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_data_mux.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_progr_clk_div.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_data_dispatcher.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_diag_data_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/afpa_flow_mux.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/frm_in_progress_gen.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/dfpa_cfg_dpram_writer.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt_min_max.bde \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_watchdog_module.bde

# sources scd_proxy2_data_ctrl 
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/fpa_trig_precontroller.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_real_data.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_dummy_dispatcher.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_bridge.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_mux_std_core.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_mux_binning_core.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_mux_input_sw.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_mux_output_sw.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_mux.bde \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_pix_pos.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_pix_sel.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_cropping_core.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_cropping.bde \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_dval_gen.bde \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_data_ctrl.bde

# sources scd_proxy2_hw_driver
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/dfpa_cfg_dpram.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_prog_ctrler.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_serial_com.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_hw_driver.bde

# top level intf
acom -incr \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_mblaze_intf.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_clocks.vhd \
 $FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr64_rd128_fifo.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_io_intf.vhd \
 $FIR251PROC/src/FPA/scd_proxy2/HDL/scd_proxy2_intf.bde
