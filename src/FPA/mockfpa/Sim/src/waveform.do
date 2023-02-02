onerror { resume }
transcript off	  
   																																			  
add wave -noreg -logic {/stim/ARESETN}															  
add wave -noreg -logic {/stim/CLK_100M}															  													  

add wave -named_row "--------------------------Config----------------------------------"	
add wave -noreg -logic {/stim/UUT/U3/U1/MB_MOSI}
add wave -noreg -logic {/stim/UUT/U3/U1/MB_MISO}
add wave -noreg -logic {/stim/UUT/U3/U1/USER_CFG}
add wave -noreg -logic {/stim/UUT/U3/U4/FPA_INTF_CFG}  

add wave -named_row "--------------------------Trigger----------------------------------"

add wave -noreg -logic {/stim/UUT/U3/U4/ACQ_INT}
add wave -named_row "--------------------------Hder gen----------------------------------"
add wave -noreg -logic {/stim/UUT/U3/U4/acq_hder}
add wave -noreg -logic {/stim/UUT/U3/U4/fast_hder_sm}
add wave -noreg -logic {/stim/UUT/U3/U4/HDER_MOSI}
add wave -noreg -logic {/stim/UUT/U3/U4/HDER_MISO}


add wave -named_row "--------------------------Data gen----------------------------------"
add wave -noreg -logic {/stim/UUT/U3/U4/pix_sm}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {/stim/UUT/U3/U4/DOUT_MOSI}
add wave -noreg -logic {/stim/UUT/U3/U4/DOUT_MISO}
add wave -named_row "--------------------------flow control----------------------------------"
add wave -noreg -logic {/stim/UUT/U3/U9/AXIS_MOSI_RX}
add wave -noreg -logic {/stim/UUT/U3/U9/AXIS_MOSI_TX}
add wave -noreg -logic {/stim/UUT/U3/U9/FLOW_CTRLER_CFG}
add wave -noreg -logic {/stim/UUT/U3/U9/flow_control_s}

add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}

#transcript on
#