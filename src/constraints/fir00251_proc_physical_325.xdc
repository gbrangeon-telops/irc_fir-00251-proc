## Physical Constraints Section

############################### GT LOC ###################################
# IMPORTANT : Proccessing fpga can be build with or without a mgt for video streaming. A choice must be made between two set of constraints. 

	# Use the following contraints for a build without the video mgt (when MGT_2CH = false on top bde) 
#	set_logic_unconnected [get_ports VIDEO_UPLINK_*] 

	#Use the following contraints for a build with the video mgt (when MGT_2CH = true on top bde) 
	set_property PACKAGE_PIN K1 [get_ports {VIDEO_UPLINK_N[0]}]
##########################################################################
