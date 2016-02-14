onerror { resume }
transcript off
add wave -noreg -logic {/data_mgt_tb/channel_up}
add wave -noreg -logic {/data_mgt_tb/CLK_50MHz}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/DATA_VERIF_miso}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/DATA_VERIF_mosi}
add wave -noreg -logic {/data_mgt_tb/do_cc_i}
add wave -noreg -logic {/data_mgt_tb/frame_err}
add wave -noreg -logic {/data_mgt_tb/GND}
add wave -noreg -logic {/data_mgt_tb/gt0_qplllock_i}
add wave -noreg -logic {/data_mgt_tb/gt0_qpllrefclklost_i}
add wave -noreg -logic {/data_mgt_tb/gt0_qpllreset_i}
add wave -noreg -logic {/data_mgt_tb/gt_qpllclk_quad1_i}
add wave -noreg -logic {/data_mgt_tb/gt_qpllrefclk_quad1_i}
add wave -noreg -logic {/data_mgt_tb/gt_refclk1_i}
add wave -noreg -logic {/data_mgt_tb/gt_reset}
add wave -noreg -logic {/data_mgt_tb/gt_reset_i}
add wave -noreg -logic {/data_mgt_tb/hard_err}
add wave -noreg -logic {/data_mgt_tb/init_clk_i}
add wave -noreg -logic {/data_mgt_tb/lane_up_reduce_i}
add wave -noreg -logic {/data_mgt_tb/link_reset_out}
add wave -noreg -logic {/data_mgt_tb/pll_not_locked_i}
add wave -noreg -logic {/data_mgt_tb/reset}
add wave -noreg -logic {/data_mgt_tb/rx_resetdone_i}
add wave -noreg -logic {/data_mgt_tb/soft_err}
add wave -noreg -logic {/data_mgt_tb/sync_clk_i}
add wave -noreg -logic {/data_mgt_tb/system_reset_i}
add wave -noreg -logic {/data_mgt_tb/sys_reset_out}
add wave -noreg -logic {/data_mgt_tb/tx_lock_i}
add wave -noreg -logic {/data_mgt_tb/tx_out_clk_i}
add wave -noreg -logic {/data_mgt_tb/tx_resetdone_i}
add wave -noreg -logic {/data_mgt_tb/user_clk_i}
add wave -noreg -logic {/data_mgt_tb/warn_cc_i}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/BUS504}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/BUS525}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/BUS535}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/DATA_TEST_miso}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/DATA_TEST_mosi}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/lane_up}
add wave -noreg -hexadecimal -literal {/data_mgt_tb/LOOPBACK}
cursor "Cursor 1" 60796ns  
transcript on
