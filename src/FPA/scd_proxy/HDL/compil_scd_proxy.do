#savealltabs
#setactivelib work
#clearlibrary 	

#packages
acom -incr -nowarn DAGGEN_0523 $FIR251PROC/src/FPA/scd_proxy/HDL/proxy_define.vhd

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
 "$FIR251COMMON/VHDL/Utilities/axis_32_to_64_wrap.vhd" \
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
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_min_max_ctrl.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/edge_counter.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt_min_max.bde \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_watchdog_module.bde

# sources scd_data_ctrl 
acom -incr -nowarn DAGGEN_0523 \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_fifo_writer.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_diag_data_gen.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_data_dispatcher.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_data_ctrl.bde

# sources scd_hw_driver
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/dfpa_cfg_dpram.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_prog_ctrler.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_serial_module.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_hw_driver.bde

# top level intf
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_mblaze_intf.vhd \
 $FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr64_rd128_fifo.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_io_interface.vhd \
 $FIR251PROC/src/FPA/fpa_trig_precontroller.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_proxy_cropping.vhd \
 $FIR251PROC/src/FPA/scd_proxy/HDL/scd_proxy_intf.bde
