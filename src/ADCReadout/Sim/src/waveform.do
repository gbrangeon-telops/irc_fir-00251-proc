onerror { resume }
transcript off
add wave -noreg -logic {/adc_readout_adc_tb_top/test_mosi}	 
add wave -noreg -logic {/adc_readout_adc_tb_top/test_miso}	   
add wave -noreg -logic {/adc_readout_adc_tb_top/value_out}
add wave -noreg -logic {/adc_readout_adc_tb_top/dval}
add wave -noreg -logic {/adc_readout_adc_tb_top/test}	  
add wave -noreg -logic {/adc_readout_adc_tb_top/mb_clk}  
add wave -noreg -logic {/adc_readout_adc_tb_top/areset}  
add wave -noreg -logic {/adc_readout_adc_tb_top/CFG}   
add wave -noreg -logic {/adc_readout_adc_tb_top/adc_cnv}

transcript on
