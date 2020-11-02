onerror { resume }
transcript off
							 
add wave -noreg {/Top_Level/U2/CLK_100MHz}
add wave -noreg {/Top_Level/OUTPUT_MOSI}	   
add wave -noreg {/Top_Level/OUTPUT_MISO}
add wave -noreg {/Top_Level/U2/SEL}
add wave -noreg {/Top_Level/U2/LINE2_MOSI}
add wave -noreg {/Top_Level/U2/LINE2_MISO}	 
add wave -noreg {/Top_Level/U2/LINE1_MOSI}
add wave -noreg {/Top_Level/U2/LINE1_MISO}		  
add wave -noreg {/Top_Level/U2/U5/TREADY_LINE1}
add wave -noreg {/Top_Level/U2/U5/TVALID_LINE1}
add wave -noreg {/Top_Level/U2/U5/TREADY_LINE2}
add wave -noreg {/Top_Level/U2/U5/TVALID_LINE2}
add wave -noreg {/Top_Level/U2/U5/sm_state}
add wave -noreg {/Top_Level/U2/U5/config_hauteur}
add wave -noreg {/Top_Level/U2/U5/config_largeur}
add wave -noreg {/Top_Level/U2/U5/comp_hauteur}
add wave -noreg {/Top_Level/U2/U5/comp_largeur}
#add wave -noreg ()
#add wave -noreg ()

transcript on
