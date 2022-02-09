
############### MGT Physical and Timing Constraints ###############
# IMPORTANT : Processing fpga can be built with or without a mgt for video streaming. A choice must be made between two sets of constraints. 

   # Use the following contraints for a build without the video mgt (when MGT_2CH = false on top bde) 
   set_logic_unconnected [get_ports VIDEO_UPLINK_*]

   # Use the following contraints for a build with the video mgt (when MGT_2CH = true on top bde) 
   #set_property PACKAGE_PIN K1 [get_ports {VIDEO_UPLINK_N[0]}]
   #set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *video_mgt*RXOUTCLK]
   #set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *video_mgt*TXOUTCLK]
###################################################################
