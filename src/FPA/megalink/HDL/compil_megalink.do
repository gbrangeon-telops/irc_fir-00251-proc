#savealltabs
#setactivelib work
#clearlibrary 	

#packages
acom -incr -nowarn DAGGEN_0523 $FIR251PROC/src/FPA/Megalink/HDL/proxy_define.vhd

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

# sources mglk_data_ctrl 
acom -incr -nowarn DAGGEN_0523 \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_fifo_writer.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_diag_data_gen.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_data_dispatcher.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_base_mode_ctrl.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_data_ctrl.bde

# sources mglk_hw_driver
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/dfpa_cfg_dpram.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_prog_ctrler.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_serial_module.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_hw_driver.bde

# top level intf
acom -incr -nowarn DAGGEN_0523 \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_mblaze_intf.vhd \
 $FIR251COMMON/VHDL/Utilities/axis_32_to_64_wrap.vhd \
 $FIR251COMMON/VHDL/Fifo/t_axi4_stream32_fifo.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_io_interface.vhd \
 $FIR251PROC/src/FPA/fpa_trig_precontroller.vhd \
 $FIR251PROC/src/FPA/Megalink/HDL/mglk_intf.bde
