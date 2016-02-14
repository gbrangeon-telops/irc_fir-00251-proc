onerror { resume }
transcript off
add wave -noreg -logic {/adc_cfg_tb_top_level/areset}
add wave -noreg -logic {/adc_cfg_tb_top_level/cfg_done}
add wave -noreg -logic {/adc_cfg_tb_top_level/clk100}
add wave -noreg -logic {/adc_cfg_tb_top_level/clk200}
add wave -noreg -logic {/adc_cfg_tb_top_level/clk40a}
add wave -noreg -logic {/adc_cfg_tb_top_level/clk40b}
add wave -noreg -logic {/adc_cfg_tb_top_level/clk40c}
add wave -noreg -logic {/adc_cfg_tb_top_level/clk40d}
add wave -noreg -logic {/adc_cfg_tb_top_level/cs_n}
add wave -noreg -logic {/adc_cfg_tb_top_level/en}
add wave -noreg -logic {/adc_cfg_tb_top_level/err}
add wave -noreg -logic {/adc_cfg_tb_top_level/GND}
add wave -noreg -logic {/adc_cfg_tb_top_level/ptrn_done}
add wave -noreg -logic {/adc_cfg_tb_top_level/ptrn_en}
add wave -noreg -logic {/adc_cfg_tb_top_level/rdy}
add wave -noreg -logic {/adc_cfg_tb_top_level/rqst}
add wave -noreg -logic {/adc_cfg_tb_top_level/sclk}
add wave -noreg -logic {/adc_cfg_tb_top_level/sdi}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/decode_rd_addr/addr}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/cfg/addr}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/cfg_reg1}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/cfg_reg2}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/cfg_reg3}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/cfg_reg4}
add wave -noreg -logic {/adc_cfg_tb_top_level/U1/spi_rd_ssn}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/rd_addr_data}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/U1/rd_dout}
add wave -noreg -literal {/adc_cfg_tb_top_level/U1/spi_rd_dval}
add wave -noreg -logic {/adc_cfg_tb_top_level/sdo}
add wave -noreg -logic {/adc_cfg_tb_top_level/VCC}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/data_0_a}
add wave -noreg -hexadecimal -literal {/adc_cfg_tb_top_level/test_pattern}
add wave -named_row "quad_adc_ctrl"
add wave -noreg -vgroup "/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr"  {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/dreg} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/data_vld} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/resync/dval_dsync} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/CLK} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/DOUT} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/DVAL} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/CSn} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/SDA} {/adc_cfg_tb_top_level/U1/spi_cfg_rd_addr/SCL}
add wave -noreg -vgroup "/adc_cfg_tb_top_level/U1/spi_cfg"  {/adc_cfg_tb_top_level/U1/spi_cfg/dreg} {/adc_cfg_tb_top_level/U1/spi_cfg/data_vld} {/adc_cfg_tb_top_level/U1/spi_cfg/resync/dval_dsync} {/adc_cfg_tb_top_level/U1/spi_cfg/CLK} {/adc_cfg_tb_top_level/U1/spi_cfg/DOUT} {/adc_cfg_tb_top_level/U1/spi_cfg/DVAL} {/adc_cfg_tb_top_level/U1/spi_cfg/CSn} {/adc_cfg_tb_top_level/U1/spi_cfg/SDA} {/adc_cfg_tb_top_level/U1/spi_cfg/SCL}
add wave -noreg -vgroup "/adc_cfg_tb_top_level/U1/spi_out"  {/adc_cfg_tb_top_level/U1/spi_out/spi_mosi_q} {/adc_cfg_tb_top_level/U1/spi_out/spi_sck_q} {/adc_cfg_tb_top_level/U1/spi_out/spi_ssn_q} {/adc_cfg_tb_top_level/U1/spi_out/sck_rise} {/adc_cfg_tb_top_level/U1/spi_out/sck_fall} {/adc_cfg_tb_top_level/U1/spi_out/rx_reg} {/adc_cfg_tb_top_level/U1/spi_out/tx_reg} {/adc_cfg_tb_top_level/U1/spi_out/spi_state} {/adc_cfg_tb_top_level/U1/spi_out/CLK} {/adc_cfg_tb_top_level/U1/spi_out/RST} {/adc_cfg_tb_top_level/U1/spi_out/DOUT} {/adc_cfg_tb_top_level/U1/spi_out/DIN} {/adc_cfg_tb_top_level/U1/spi_out/STB} {/adc_cfg_tb_top_level/U1/spi_out/SPI_SCK} {/adc_cfg_tb_top_level/U1/spi_out/SPI_MOSI} {/adc_cfg_tb_top_level/U1/spi_out/SPI_MISO} {/adc_cfg_tb_top_level/U1/spi_out/SPI_SSn}
add wave -noreg -vgroup "/adc_cfg_tb_top_level/U2"  {/adc_cfg_tb_top_level/U2/sreset} {/adc_cfg_tb_top_level/U2/test_pattern_hold} {/adc_cfg_tb_top_level/U2/enable_test_pattern} {/adc_cfg_tb_top_level/U2/configuration_fsm/state} {/adc_cfg_tb_top_level/U2/configuration_fsm/next_state} {/adc_cfg_tb_top_level/U2/cfg_word} {/adc_cfg_tb_top_level/U2/data_spi_rx} {/adc_cfg_tb_top_level/U2/dval_spi_tx} {/adc_cfg_tb_top_level/U2/dval_spi_rx} {/adc_cfg_tb_top_level/U2/dval_rx} {/adc_cfg_tb_top_level/U2/ack_i} {/adc_cfg_tb_top_level/U2/cs_n_i} {/adc_cfg_tb_top_level/U2/sclk_i} {/adc_cfg_tb_top_level/U2/enable_pattern} {/adc_cfg_tb_top_level/U2/index} {/adc_cfg_tb_top_level/U2/next_index} {/adc_cfg_tb_top_level/U2/err_i} {/adc_cfg_tb_top_level/U2/ptrn_done_i} {/adc_cfg_tb_top_level/U2/done_i} {/adc_cfg_tb_top_level/U2/test_pattern_enabled} {/adc_cfg_tb_top_level/U2/config_addr} {/adc_cfg_tb_top_level/U2/config_data} {/adc_cfg_tb_top_level/U2/config_data_readback_reg} {/adc_cfg_tb_top_level/U2/rw_n} {/adc_cfg_tb_top_level/U2/CLK} {/adc_cfg_tb_top_level/U2/ARESET} {/adc_cfg_tb_top_level/U2/EN} {/adc_cfg_tb_top_level/U2/PTRN_EN} {/adc_cfg_tb_top_level/U2/PTRN_DATA} {/adc_cfg_tb_top_level/U2/PTRN_DONE} {/adc_cfg_tb_top_level/U2/RQST} {/adc_cfg_tb_top_level/U2/MISO} {/adc_cfg_tb_top_level/U2/CS_N} {/adc_cfg_tb_top_level/U2/SCLK} {/adc_cfg_tb_top_level/U2/MOSI} {/adc_cfg_tb_top_level/U2/ERR} {/adc_cfg_tb_top_level/U2/DONE}
add wave -noreg -vgroup "/adc_cfg_tb_top_level/U2/spi_in"  {/adc_cfg_tb_top_level/U2/spi_in/dreg} {/adc_cfg_tb_top_level/U2/spi_in/data_vld} {/adc_cfg_tb_top_level/U2/spi_in/CLK} {/adc_cfg_tb_top_level/U2/spi_in/DOUT} {/adc_cfg_tb_top_level/U2/spi_in/DVAL} {/adc_cfg_tb_top_level/U2/spi_in/CSn} {/adc_cfg_tb_top_level/U2/spi_in/SDA} {/adc_cfg_tb_top_level/U2/spi_in/SCL}
cursor "Cursor 1" 3095ns  
transcript on
