onerror { resume }
transcript off
add wave -noreg -logic {/adc_tb_4ch_top_level/all_rdy}
add wave -noreg -logic {/adc_tb_4ch_top_level/areset}
add wave -noreg -logic {/adc_tb_4ch_top_level/aresetn}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk100}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk1x_master}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk200}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk40a}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk40b}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk40c}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk40d}
add wave -noreg -logic {/adc_tb_4ch_top_level/clk7x_master}
add wave -noreg -logic {/adc_tb_4ch_top_level/cs_n}
add wave -noreg -logic {/adc_tb_4ch_top_level/GND}
add wave -noreg -logic {/adc_tb_4ch_top_level/sclk}
add wave -noreg -logic {/adc_tb_4ch_top_level/sdi}
add wave -noreg -logic {/adc_tb_4ch_top_level/VCC}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/data_0_a}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/data_0_b}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/data_0_c}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/data_0_d}
add wave -noreg -logic {/adc_tb_4ch_top_level/LD}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/pattern_valid}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/Q_0_a}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/Q_0_b}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/Q_0_c}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_4ch_top_level/Q_0_d}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_4ch_top_level/rdy}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/start_test}
add wave -noreg -hexadecimal -literal {/adc_tb_4ch_top_level/test_done}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_4ch_top_level/test_pattern}
add wave -noreg -vgroup "/adc_tb_4ch_top_level/CH3/U9"  {/adc_tb_4ch_top_level/CH3/U9/bs_state} {/adc_tb_4ch_top_level/CH3/U9/dly_state}
add wave -noreg -vgroup "/adc_tb_4ch_top_level/CH2/U9"  {/adc_tb_4ch_top_level/CH2/U9/bs_state} {/adc_tb_4ch_top_level/CH2/U9/dly_state}
add wave -noreg -vgroup "/adc_tb_4ch_top_level/CH0/U9"  {/adc_tb_4ch_top_level/CH0/U9/bs_state} {/adc_tb_4ch_top_level/CH0/U9/dly_state}
add wave -noreg -vgroup "/adc_tb_4ch_top_level/CH1/U9"  {/adc_tb_4ch_top_level/CH1/U9/bs_state} {/adc_tb_4ch_top_level/CH1/U9/dly_state}
cursor "Cursor 1" 10us  
transcript on
