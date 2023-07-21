#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd \
 D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_define.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Buffering\BufferingDefine.vhd
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do
 
 
# ----------------- mockfpa files ------------------	
acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_wr132_rd66_d16\fwft_afifo_wr132_rd66_d16_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd64_fifo.vhd"
acom -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\mock_fpa_testbench_pkg.vhd \
D:\Telops\FIR-00251-Common\VHDL\signal_stat\min_max_define.vhd \
D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt.vhd \
D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_min_max_ctrl.vhd \
D:\Telops\FIR-00251-Common\VHDL\signal_stat\period_duration.vhd \
D:\Telops\FIR-00251-Common\VHDL\signal_stat\delay_measurement.vhd \
D:\Telops\FIR-00251-Common\VHDL\signal_stat\min_max_ctrl.vhd \
D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\edge_counter.vhd \
D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt_min_max.bde \
D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_delay.bde \
D:\Telops\FIR-00251-Common\VHDL\signal_stat\trig_period.bde \
D:\Telops\FIR-00251-Proc\src\Trig\HDL\progr_clk_div.vhd \
D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_conditioner.vhd \
D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen_ctler_core.vhd \
D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen_ctler.bde \
D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_watchdog_module_128.bde \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\mockfpa_mblaze_intf.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\mockfpa_status_gen.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\mockfpa_data_gen.vhd \
D:\Telops\FIR-00251-Proc\IP\325\t_axi4_stream64_sfifo_d1024\t_axi4_stream64_sfifo_d1024_sim_netlist.vhdl \
D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd64_fifo.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\mock_flow_controller.vhd \
D:\Telops\FIR-00251-Proc\IP\325\t_axi4_stream128_afifo_d512\t_axi4_stream128_afifo_d512_sim_netlist.vhdl \
D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream128_fifo.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\mockfpa_intf.bde