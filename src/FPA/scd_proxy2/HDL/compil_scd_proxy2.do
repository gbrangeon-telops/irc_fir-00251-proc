#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\proxy_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
 


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
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\signal_filter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\brd_id_reader.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\frm_in_progress_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_ctrl_map.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_min_max_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\edge_counter.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_mux.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_data_dispatcher.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_diag_data_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_flow_mux.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\frm_in_progress_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt_min_max.bde \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_watchdog_module.bde

# sources scd_proxy2_data_ctrl 
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\fpa_trig_precontroller.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_real_data.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_bridge.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_line_mux.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_dval_gen.bde \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_data_ctrl.bde

# sources scd_proxy2_hw_driver
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\dfpa_cfg_dpram.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_prog_ctrler.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_serial_com.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_hw_driver.bde

# top level intf
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_mblaze_intf.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_clocks.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream64_fifo.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_io_intf.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\scd_proxy2_intf.bde
