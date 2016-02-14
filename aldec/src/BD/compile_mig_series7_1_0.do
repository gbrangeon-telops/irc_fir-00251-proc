alib work
SetActiveLib work

#Clocking
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/clocking/mig_7series_v2_0_iodelay_ctrl.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/clocking/mig_7series_v2_0_infrastructure.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/clocking/mig_7series_v2_0_tempmon.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/clocking/mig_7series_v2_0_clk_ibuf.v

#AXI
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_ctrl_addr_decode.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_ctrl_read.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_ctrl_reg.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_ctrl_reg_bank.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_ctrl_write.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_cmd_arbiter.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_cmd_fsm.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_incr_cmd.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_wrap_cmd.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_cmd_translator.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_ar_channel.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_wr_cmd_fsm.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_aw_channel.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_fifo.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_b_channel.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_r_channel.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_simple_fifo.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc_w_channel.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_ctrl_top.v

#DDR
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_carry_latch_and.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_carry_and.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_comparator.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_carry_or.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_carry_latch_or.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_command_fifo.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_a_upsizer.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_axic_register_slice.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_axi_register_slice.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_comparator_sel.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_comparator_sel_static.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_r_upsizer.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_w_upsizer.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_ddr_axi_upsizer.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_byte_group_io.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_if_post_fifo.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_of_pre_fifo.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_byte_lane.v

#DDR Phy
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_prbs_gen.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_init.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_wrcal.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_wrlvl.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_ck_addr_cmd_delay.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_wrlvl_off_delay.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_oclkdelay_cal.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_dqs_found_cal.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_rdlvl.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_prbs_rdlvl.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_tempmon.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_dqs_found_cal_hr.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_calib_top.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_4lanes.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_mc_phy.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_mc_phy_wrapper.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/axi/mig_7series_v2_0_axi_mc.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/phy/mig_7series_v2_0_ddr_phy_top.v

#UI
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ui/mig_7series_v2_0_ui_cmd.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ui/mig_7series_v2_0_ui_rd_data.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ui/mig_7series_v2_0_ui_wr_data.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ui/mig_7series_v2_0_ui_top.v

#MC
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_round_robin_arb.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_arb_row_col.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_arb_select.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_arb_mux.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_bank_compare.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_bank_state.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_bank_queue.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_bank_cntrl.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_bank_common.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_bank_mach.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_col_mach.v
alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_rank_cntrl.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_rank_common.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_rank_mach.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/controller/mig_7series_v2_0_mc.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ip_top/mig_7series_v2_0_mem_intfc.v
alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ip_top/mig_7series_v2_0_memc_ui_top_axi.v

#ECC
#alog -O2 -sve -l unisim -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ecc/mig_7series_v2_0_ecc_buf.v
#alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ecc/mig_7series_v2_0_ecc_dec_fix.v
#alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ecc/mig_7series_v2_0_ecc_gen.v
#alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ecc/mig_7series_v2_0_ecc_merge_enc.v
#alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/ecc/mig_7series_v2_0_fi_xor.v

alog -O2 -sve   -work work $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/user_design/rtl/core_mig_7series_1_0_mig_sim.v

SetActiveLib work





