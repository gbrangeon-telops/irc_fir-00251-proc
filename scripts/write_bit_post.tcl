#get root directory relative to this file
set current_file_location_absolute_path [file normalize [file dirname [info script]]]
source $current_file_location_absolute_path/setEnvironment.tcl

set base_dir "$projectDir"
#Get project name
set proj_name [get_project]
#Get sensor if possible
set sensor [string range $proj_name 19 end]
#Get FPGA Size
set FPGA_SIZE [string range $proj_name 15 17]

set encrypt_file $base_dir/src/constraints/_encryption/fir00251_proc_${FPGA_SIZE}_encrypt.xdc

# No encryption key by default
set encrypt_key_name "NONE"

# When the encryption constraints file is enabled, we have to parse it
if {[get_property is_enabled [get_files $encrypt_file]] == 1} {

   # Read the whole file
   set fp [open $encrypt_file "r"]
   set file_data [read $fp]
   close $fp
   
   # Parse the file line by line
   set data [split $file_data "\n"]
   foreach line $data {
      
      # Find line with the ENCRYPT property
      if {[string match -nocase "*ENCRYPTION.ENCRYPT *" $line] == 1} {
         # No encryption key if the line is commented or if the property is not set to Yes
         if {[string index $line 0] == "#" || [string match -nocase "* Yes *" $line] == 0} {
            set encrypt_key_name "NONE"
            break
         }
      }
      
      # The IRCAM KEYFILE is found and not commented
      if {[string match -nocase "*ENCRYPTION.KEYFILE *irc.nky*" $line] == 1 && [string index $line 0] != "#"} {
         set encrypt_key_name "IRCAM"
      }
      
      # The KIT KEYFILE is found and not commented
      if {[string match -nocase "*ENCRYPTION.KEYFILE *kit.nky*" $line] == 1 && [string index $line 0] != "#"} {
         set encrypt_key_name "KIT"
      }
   }
}

#Build git revision
source $base_dir/scripts/updateHwRev.tcl 
updateHwSvnRev ${FPGA_SIZE} ${sensor} ${FPGA_SIZE} ${encrypt_key_name}
#exec $base_dir/scripts/updateHwSvnRev.bat ${sensor} ${FPGA_SIZE} ${encrypt_key_name}
 