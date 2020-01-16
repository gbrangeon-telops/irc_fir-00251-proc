#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom -incr -nowarn DAGGEN_0523 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\proxy_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#uarts
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\RS232\uarts.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\uart_block_tel2000.bde

#signal stat
acom \
 "D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_define.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\min_max_define.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\min_max_ctrl.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\delay_measurement.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_delay.bde" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\period_duration.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_period.bde" \
 "D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_period_8ch.bde"

# sources FPa common 
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\frm_in_progress_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_min_max_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\edge_counter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt_min_max.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_watchdog_module.bde

# sources mglk_data_ctrl 
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_fifo_writer.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_diag_data_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_data_dispatcher.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_base_mode_ctrl.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_data_ctrl.bde

# sources mglk_hw_driver
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\dfpa_cfg_dpram.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_prog_ctrler.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_serial_module.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_hw_driver.bde

# top level intf
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_mblaze_intf.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Utilities\axis_32_to_64_wrap.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream32_fifo.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_io_interface.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\fpa_trig_precontroller.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\mglk_intf.bde
