onerror { resume }
transcript off
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/ARESETN}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/DATA_USER_CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_USER_CLK}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_MISO64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_OUT_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_MISO64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_OUT_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/TO_EXP_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/TO_EXP_STREAM_MISO64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/FROM_EXP_STREAM_MOSI64}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/AURORA_CLK_N0}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/AURORA_CLK_N1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/AURORA_CLK_P0}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/AURORA_CLK_P1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/CLK100MHZ}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/RESET}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/AXI4_LITE_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/AXI4_LITE_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_IN_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_IN_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_IN_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_IN_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_STREAM_IN_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_STREAM_IN_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_OUT_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_STREAM_OUT_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_OUT_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_STREAM_OUT_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_STREAM_OUT_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_STREAM_OUT_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_UPLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_UPLINK_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_PROC_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_PROC_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_UPLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_UPLINK_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_DOWNLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/DATA_DOWNLINK_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/PROC_EXP_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/PROC_EXP_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_DOWNLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/VIDEO_DOWNLINK_P}
add wave -named_row "UUT2"
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/ARESETN}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_MISO64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_OUT_MOSI64}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/DATA_USER_CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/EXP_USER_CLK}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/FROM_EXP_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/TO_EXP_STREAM_MISO64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/TO_EXP_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_MISO64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_MOSI64}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_OUT_MOSI64}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/AURORA_CLK_P0}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/AURORA_CLK_N0}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/AURORA_CLK_P1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/AURORA_CLK_N1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/CLK100MHZ}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT2/RESET}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/AXI4_LITE_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/AXI4_LITE_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_IN_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_IN_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_IN_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_IN_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/EXP_STREAM_IN_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/EXP_STREAM_IN_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_OUT_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_STREAM_OUT_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_OUT_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_STREAM_OUT_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/EXP_STREAM_OUT_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/EXP_STREAM_OUT_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_UPLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_UPLINK_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/EXP_PROC_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/EXP_PROC_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_UPLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_UPLINK_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_DOWNLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/DATA_DOWNLINK_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/PROC_EXP_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/PROC_EXP_P}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_DOWNLINK_N}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT2/VIDEO_DOWNLINK_P}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/ACLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/ARESETN}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/S_ACLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/S_ARESETN}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/S_AXI4S_32_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/S_AXI4S_32_MISO}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/M_ACLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/M_ARESETN}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/M_AXI4S_64_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/EXP_32_TO_64/M_AXI4S_64_MISO}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/GT_CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/GT_CLK_LOCKED}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/INIT_CLK_I}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/INIT_CLK_O}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/PLL_NOT_LOCKED}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/SYNC_CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CLK_MODULE_EXP/USER_CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/channel_up}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/do_cc}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpaddr_in}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpaddr_in_lane1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpclk_in}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpdi_in}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpdi_in_lane1}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpdo_out}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpdo_out_lane1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpen_in}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpen_in_lane1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drprdy_out}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drprdy_out_lane1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpwe_in}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/drpwe_in_lane1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/frame_err}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt0_qplllock_in}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt0_qpllrefclklost_in}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt0_qpllreset_out}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt_qpllclk_quad2_in}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt_qpllrefclk_quad2_in}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt_refclk1}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/gt_reset}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/hard_err}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/init_clk_in}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/lane_up}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/link_reset_out}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/loopback}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/m_axi_rx_tdata}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/m_axi_rx_tkeep}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/m_axi_rx_tlast}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/m_axi_rx_tvalid}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/pll_not_locked}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/power_down}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/reset}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/rx_resetdone_out}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/rxn}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/rxp}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/s_axi_tx_tdata}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/s_axi_tx_tkeep}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/s_axi_tx_tlast}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/s_axi_tx_tready}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/s_axi_tx_tvalid}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/soft_err}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/sync_clk}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/sys_reset_out}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/tx_lock}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/tx_out_clk}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/tx_resetdone_out}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/txn}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/EXP/txp}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/user_clk}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/EXP/warn_cc}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/core_status_i}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/pll_status_i}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/power_down_i}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/loopback_i}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_awaddr}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_awready}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_wready}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_bresp}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_bvalid}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_araddr}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_arready}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_rdata}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_rresp}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/axi_rvalid}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/slv_reg_rden}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/slv_reg_wren}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/reg_data_out}
add wave -noreg -decimal -literal -signed2 {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/byte_index}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/CLK}
add wave -noreg -logic {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/ARESETN}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/AXI4_LITE_MOSI}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/AXI4_LITE_MISO}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/FRAME_ERR}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/HARD_ERR}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/SOFT_ERR}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/CHANNEL_UP}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/LANE_UP}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/RX_RESETDONE}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/TX_RESETDONE}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/PLL_NOT_LOCK}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/TX_OUT_LOCK}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/LINK_RESET}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/GT0_QPLLLOCK}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/GT0_QPLLREFCLKLOST}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/GT0_QPLLRESET}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/POWER_DOWN}
add wave -noreg -hexadecimal -literal {/MGT_WRAPPER_TB/UUT1/MGT/CTRL/LOOPBACK}
cursor "Cursor 1" 10468.75ns  
cursor "Cursor 2" 200ns  
transcript on
