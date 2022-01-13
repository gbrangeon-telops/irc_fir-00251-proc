   
   proc readHardwareMemoryConfig {base_dir sensor FPGA_SIZE} {
   
   set fp [open $base_dir/scripts/${sensor}${FPGA_SIZE}_project.tcl r]
   set file_data [read $fp]
   close $fp
   set data [split $file_data "\n"]
   set MEM_4DDR [lindex [lindex $data [lsearch $data *MEM_4DDR*]] 2]
   set MEM_HW [if {$MEM_4DDR} {set MEM_HW "4DDR"} {set MEM_HW "2DDR"}]  
   return $MEM_HW
   } 