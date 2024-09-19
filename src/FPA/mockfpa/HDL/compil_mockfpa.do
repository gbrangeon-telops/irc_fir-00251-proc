#savealltabs
#adel -all
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd \
 $FIR251PROC/src/FPA/mockfpa/HDL/FPA_define.vhd \
 $FIR251PROC/src/FPA/mockfpa/HDL/proxy_define.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd \
 $FIR251COMMON/VHDL/img_header_define.vhd \
 $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd \
 $FIR251PROC/src/Trig/HDL/trig_define.vhd \
 $FIR251COMMON/VHDL/Buffering/BufferingDefine.vhd
#utilities
do $FIR251PROC/src/compil_utilities.do
 
 
# ----------------- mockfpa files ------------------	
acom "$FIR251PROC/IP/325/fwft_afifo_wr132_rd66_d16/fwft_afifo_wr132_rd66_d16_sim_netlist.vhdl"
acom "$FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr128_rd64_fifo.vhd"
acom -nowarn DAGGEN_0523 -incr \
$FIR251PROC/src/FPA/mockfpa/Sim/src/mock_fpa_testbench_pkg.vhd \
$FIR251COMMON/VHDL/signal_stat/min_max_define.vhd \
$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt.vhd \
$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_min_max_ctrl.vhd \
$FIR251COMMON/VHDL/signal_stat/period_duration.vhd \
$FIR251COMMON/VHDL/signal_stat/delay_measurement.vhd \
$FIR251COMMON/VHDL/signal_stat/min_max_ctrl.vhd \
$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/edge_counter.vhd \
$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt_min_max.bde \
$FIR251COMMON/VHDL/signal_stat/trig_delay.bde \
$FIR251COMMON/VHDL/signal_stat/trig_period.bde \
$FIR251PROC/src/Trig/HDL/progr_clk_div.vhd \
$FIR251PROC/src/Trig/HDL/trig_conditioner.vhd \
$FIR251PROC/src/Trig/HDL/trig_gen_ctler_core.vhd \
$FIR251PROC/src/Trig/HDL/trig_gen_ctler.bde \
$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_watchdog_module_128.bde \
$FIR251PROC/src/FPA/mockfpa/HDL/mockfpa_mblaze_intf.vhd \
$FIR251PROC/src/FPA/mockfpa/HDL/mockfpa_status_gen.vhd \
$FIR251PROC/src/FPA/mockfpa/HDL/mockfpa_data_gen.vhd \
$FIR251PROC/IP/325/t_axi4_stream64_sfifo_d1024/t_axi4_stream64_sfifo_d1024_sim_netlist.vhdl \
$FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr128_rd64_fifo.vhd \
$FIR251PROC/src/FPA/mockfpa/HDL/mock_flow_controller.vhd \
$FIR251PROC/IP/325/t_axi4_stream128_afifo_d512/t_axi4_stream128_afifo_d512_sim_netlist.vhdl \
$FIR251COMMON/VHDL/Fifo/t_axi4_stream128_fifo.vhd \
$FIR251PROC/src/FPA/mockfpa/HDL/mockfpa_intf.bde