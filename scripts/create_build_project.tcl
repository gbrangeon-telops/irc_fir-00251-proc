proc create_tsir_project {detector} {
	
	global base_dir
	#set base_dir "d:/Telops/fir-00251-Proc"
	
	#force writable directory
	file attributes $base_dir/xilinx/ -readonly 0
	
	#Create project 
	source $base_dir/scripts/${detector}_project.tcl
}

proc build_tsir_project {{release 0}} {
	global base_dir

	#set base_dir "d:/Telops/fir-00251-Proc"
	#Get project name
	set proj_name [get_project]
	#Get sensor if possible
	set sensor [string range $proj_name 19 end]
	#Get top level file name
	set top_lvl [get_property top [current_fileset]]
	#Get FPGA Size
	set FPGA_SIZE [string range $proj_name 15 17]
	
	if {$release != 0} {
      #Use release target constraints file
      set_property is_enabled false [get_files -of [get_filesets { constrs_1}] -filter {NAME !~ "*release*"} *target.xdc]
      set_property target_constrs_file [get_files -of [get_filesets { constrs_1}] *release_target.xdc] [current_fileset -constrset]
	}
   
   #export hardware to sdk
   generate_target all [get_files *.bd]
   write_hwdef -force -file $base_dir/sdk/${top_lvl}/fir_00251_proc_${sensor}_${FPGA_SIZE}.hdf
   
   #create and build bootloader
   exec xsct $base_dir/sdk/build_sw.tcl ${sensor} ${FPGA_SIZE} 1 "boot_only"
   if {[file exists $base_dir/sdk/$top_lvl/${top_lvl}_boot_${FPGA_SIZE}/Release/${top_lvl}_boot_${FPGA_SIZE}.elf] == 0} {
      return -code error "Build bootloader failed ${sensor} ${FPGA_SIZE}"
   }
   
	#generate bitstream
	launch_runs impl_1 -to_step write_bitstream
	
	#wait for run end
	wait_on_run impl_1
	
	#Export bitstream
	file copy -force $base_dir/xilinx/${sensor}/${proj_name}.runs/impl_1/${top_lvl}.bit $base_dir/sdk/${top_lvl}/fir_00251_proc_${sensor}_${FPGA_SIZE}.bit
	source $base_dir/scripts/write_bit_post.tcl
	
	#open implemented design
	open_run impl_1
	
	#Save Report
	report_timing_summary -file $base_dir/Reports/${sensor}/${proj_name}_timing_summary_routed.rpt
	report_power -file $base_dir/Reports/${sensor}/${proj_name}_power.rpt
	report_clock_utilization -file $base_dir/Reports/${sensor}/${proj_name}_clock_utilization_placed.rpt
	report_utilization -file $base_dir/Reports/${sensor}/${proj_name}_utilization_placed.rpt
	report_utilization -file $base_dir/Reports/${sensor}/${proj_name}_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 8
	
	if {$release != 0} {
      #Change back target constraints file
      set_property is_enabled true [get_files -of [get_filesets { constrs_1}] -filter {NAME !~ "*release*"} *target.xdc]
      set_property target_constrs_file [get_files -of [get_filesets { constrs_1}] -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
   }
	
	# End of this build
	close_project
}

proc create_build_project {detector {release 0}} {
	create_tsir_project $detector
	build_tsir_project $release
}
