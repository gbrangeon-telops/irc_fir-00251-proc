onerror { resume }
transcript off
add wave -noreg -logic {/sync_switch_top/clk_data}
add wave -noreg -logic {/sync_switch_top/done}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U7/img_cnt}
add wave -noreg -logic {/sync_switch_top/aresetn}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/SEL2}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/IMG_INPUT/FILENAME}
add wave -named_row "U5 : axis32_hole_sync"
add wave -noreg -logic {/sync_switch_top/U5/sof_s}
add wave -noreg -logic -unsigned {/sync_switch_top/U5/eof_s}
add wave -noreg -logic {/sync_switch_top/U5/fall_sync}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U5/tx_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U5/rx_miso_i}
add wave -noreg -logic {/sync_switch_top/U5/areset}
add wave -noreg -logic {/sync_switch_top/U5/sreset}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U5/RX_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U5/RX_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U5/TX_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U5/TX_MISO}
add wave -noreg -logic {/sync_switch_top/U5/FALL}
add wave -noreg -logic {/sync_switch_top/U5/ARESETN}
add wave -noreg -logic {/sync_switch_top/U5/CLK}
add wave -named_row "U4: axis32_sw_2_1"
add wave -noreg -logic {/sync_switch_top/U4/areset}
add wave -noreg -logic {/sync_switch_top/U4/sreset}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/sof_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/eof_i}
add wave -noreg -logic {/sync_switch_top/U4/off}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx_mosi_out}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/rx0_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/rx1_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx0_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx1_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx0_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/tx1_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/sel_sync}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/RX0_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/RX0_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/RX1_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/RX1_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/TX_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/TX_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U4/SEL}
add wave -noreg -logic -unsigned {/sync_switch_top/U4/ARESETN}
add wave -noreg -logic {/sync_switch_top/U4/CLK}
add wave -named_row "u11 : axis32_sw1_2"
add wave -noreg -logic {/sync_switch_top/U11/areset}
add wave -noreg -logic {/sync_switch_top/U11/sreset}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/tx_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/tx0_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/tx1_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/rx_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/rx0_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/rx1_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/rx_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/rx0_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/rx1_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/tx_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/tx0_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/tx1_miso_i}
add wave -noreg -logic -unsigned {/sync_switch_top/U11/sof_i}
add wave -noreg -logic -unsigned {/sync_switch_top/U11/eof_i}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/sel_sync}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/RX_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/RX_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/TX0_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/TX0_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/TX1_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/TX1_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/sync_switch_top/U11/SEL}
add wave -noreg -logic {/sync_switch_top/U11/ARESETN}
add wave -noreg -logic {/sync_switch_top/U11/CLK}
add wave -named_row "U16 : axis32_delay"
add wave -noreg -hexadecimal -literal {/sync_switch_top/U16/tx_array_mosi}
add wave -noreg -hexadecimal -literal {/sync_switch_top/U16/tx_array_miso}
add wave -noreg -logic {/sync_switch_top/U16/ARESETN}
add wave -noreg -logic {/sync_switch_top/U16/CLK}
add wave -noreg -hexadecimal -literal {/sync_switch_top/U16/RX_MOSI}
add wave -noreg -hexadecimal -literal {/sync_switch_top/U16/RX_MISO}
add wave -noreg -hexadecimal -literal {/sync_switch_top/U16/TX_MOSI}
add wave -noreg -hexadecimal -literal {/sync_switch_top/U16/TX_MISO}
cursor "Cursor 1" 32us  
bookmark add 134.409267us
transcript on
