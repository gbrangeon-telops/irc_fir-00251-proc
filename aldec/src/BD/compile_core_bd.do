alib work
setactivelib work


# Compile 
do $FIR251PROC/aldec/src/BD/compile_lmb_bram_if_cntlr_v4_0.do
do $FIR251PROC/aldec/src/BD/compile_lmb_v10_v3_0.do
do $FIR251PROC/aldec/src/BD/compile_blk_mem_gen_v8_1.do
do $FIR251PROC/aldec/src/BD/compile_mdm_v3_0.do
do $FIR251PROC/aldec/src/BD/compile_microblaze_v9_2.do
do $FIR251PROC/aldec/src/BD/compile_axi_intc_v4_0.do
do $FIR251PROC/aldec/src/BD/compile_axi_gpio_v2_0.do
do $FIR251PROC/aldec/src/BD/compile_axi_timer_v2_0.do
do $FIR251PROC/aldec/src/BD/compile_axi_uart16550_v2_0.do
do $FIR251PROC/aldec/src/BD/compile_proc_sys_reset_v5_0.do
do $FIR251PROC/aldec/src/BD/compile_core_xadc_wiz_1_0_axi_xadc.do
do $FIR251PROC/aldec/src/BD/compile_axi_protocol_converter_v2_1.do
do $FIR251PROC/aldec/src/BD/compile_core_auto_cc.do
do $FIR251PROC/aldec/src/BD/compile_core_auto_us.do
do $FIR251PROC/aldec/src/BD/compile_core_xbar.do
do $FIR251PROC/aldec/src/BD/compile_mig_series7_1_0.do


alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_0_0/sim/core_axi_protocol_converter_0_0.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_1_1/sim/core_axi_protocol_converter_1_1.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_2_2/sim/core_axi_protocol_converter_2_2.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_3_3/sim/core_axi_protocol_converter_3_3.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_4_4/sim/core_axi_protocol_converter_4_4.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_5_5/sim/core_axi_protocol_converter_5_5.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_6_6/sim/core_axi_protocol_converter_6_6.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_7_7/sim/core_axi_protocol_converter_7_7.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_protocol_converter_8_8/sim/core_axi_protocol_converter_8_8.v


alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_cc_2/sim/core_auto_cc_2.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_cc_3/sim/core_auto_cc_3.v

alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_17/sim/core_auto_pc_17.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_18/sim/core_auto_pc_18.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_19/sim/core_auto_pc_19.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_20/sim/core_auto_pc_20.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_21/sim/core_auto_pc_21.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_22/sim/core_auto_pc_22.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_23/sim/core_auto_pc_23.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_pc_24/sim/core_auto_pc_24.v

alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_us_5/sim/core_auto_us_5.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_us_6/sim/core_auto_us_6.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_us_7/sim/core_auto_us_7.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_us_8/sim/core_auto_us_8.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_auto_us_9/sim/core_auto_us_9.v

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_dlmb_bram_if_cntlr_0/synth/core_dlmb_bram_if_cntlr_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_ilmb_bram_if_cntlr_1/sim/core_ilmb_bram_if_cntlr_1.vhd
acom -reorder -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_dlmb_v10_0/sim/core_dlmb_v10_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_lmb_bram_0/sim/core_lmb_bram_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_ilmb_v10_1/sim/core_ilmb_v10_1.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mdm_1_0/sim/core_mdm_1_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_microblaze_1_0/sim/core_microblaze_1_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_microblaze_1_axi_intc_0/sim/core_microblaze_1_axi_intc_0.vhd

alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_xbar_0/sim/core_xbar_0.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_xbar_1/sim/core_xbar_1.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_xbar_2/sim/core_xbar_2.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_xbar_3/sim/core_xbar_3.v

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_VCC_0/work/xlconstant.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_VCC_0/sim/core_VCC_0.vhd

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_gpio_0_0/sim/core_axi_gpio_0_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_timer_0_0/sim/core_axi_timer_0_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_axi_usb_uart_0/sim/core_axi_usb_uart_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_clink_uart_1/sim/core_clink_uart_1.vhd

alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/core_mig_7series_1_0.v

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_clk_wiz_1_0/core_clk_wiz_1_0_clk_wiz.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_clk_wiz_1_0/core_clk_wiz_1_0.vhd

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_fpga_output_uart_2/sim/core_fpga_output_uart_2.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_intr_concact_0/work/xlconcat.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_intr_concact_0/sim/core_intr_concact_0.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_oem_uart_3/sim/core_oem_uart_3.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_pleora_uart_4/sim/core_pleora_uart_4.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_proc_sys_reset_1_0/sim/core_proc_sys_reset_1_0.vhd

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_xadc_wiz_1_0/core_xadc_wiz_1_0_axi_xadc.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_xadc_wiz_1_0/core_xadc_wiz_1_0.vhd

acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/hdl/core.vhd
acom -O3 -work work -2002  -relax $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/hdl/core_wrapper.vhd
acom -O3 -work work -2002  -relax $dsn/../src/BD/bd_wrapper.vhd




acom -O3 -work work -2002  -relax $dsn/src/Testbench/Microblaze/microblaze_stim.vhd
acom -O3 -work work -2002  -relax $dsn/src/Testbench/Microblaze/MicroBlaze_tb.bde

asim -G  /MicroBlaze_tb/MB/core_wrapper_i/core_i/MCU/microblaze_1_local_memory/lmb_bram/U0/native_mem_map_module/mem_map_module/C_INIT_FILE="$FIR251PROC/xilinx/fir_0251_Proc.sim/sim_1/behav/core_lmb_bram_0.mem" -ses +access +r +m+MicroBlaze_tb MicroBlaze_tb MicroBlaze_tb



