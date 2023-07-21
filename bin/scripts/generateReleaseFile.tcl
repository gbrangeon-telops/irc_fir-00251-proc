proc usage {} {
    #note : see switch case line 25
    puts "Usage: generateReleaseFile.tcl -fa <firmwareVersionMajor> -fi <firmwareVersionMinor> ... "
}

set relInfoVersionMajor 2
set relInfoVersionMinor 2
set relInfoVersionSubMinor 0

set firmwareVersionMajor ""
set firmwareVersionMinor ""
set firmwareVersionSubMinor ""
set firmwareVersionBuild ""
set procRevFile ""
set outputRevFile ""
set storageRevFile1 ""
set storageRevFile2 ""
set releasefile ""
set releaseLogfile ""

#set argv [lassign $argv _]

while {[llength $argv] > 0} {
    switch -- [lindex $argv 0] {
        "-fa" {
            set firmwareVersionMajor [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-fi" {
            set firmwareVersionMinor [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-fs" {
            set firmwareVersionSubMinor [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-fb" {
            set firmwareVersionBuild [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-p" {
            set procRevFile [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-o" {
            set outputRevFile [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-s1" {
            set storageRevFile1 [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-s2" {
            set storageRevFile2 [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "--release" {
            set releasefile [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-r" {
            set releasefile [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "--log" {
            set releaseLogfile [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-l" {
            set releaseLogfile [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }    
        default {
            puts [lindex $argv 0]
            usage
            error "Error in command line arguments"
            }
    }
}

puts "Creating release $firmwareVersionMajor.$firmwareVersionMinor.$firmwareVersionSubMinor.$firmwareVersionBuild"
set rel_proc_hw_rev ""
set rel_proc_sw_rev ""
set rel_proc_boot_rev ""
set rel_proc_common_rev ""
set rel_out_hw_rev ""
set rel_out_sw_rev ""
set rel_out_boot_rev ""
set rel_out_common_rev ""
set rel_storage_hw_rev1 ""
set rel_storage_sw_rev1 ""
set rel_storage_boot_rev1 ""
set rel_storage_common_rev1 ""
set rel_storage_hw_rev2 ""
set rel_storage_sw_rev2 ""
set rel_storage_boot_rev2 ""
set rel_storage_common_rev2 ""

#require todo
source $procRevFile
source $outputRevFile
source $storageRevFile1
source $storageRevFile2
set relInfolength 0

# Update release file
set fh [open $releasefile w]

# Skip release information length field
incr relInfolength 4
seek $fh $relInfolength start

# Write release information version fields
#binary format I $relInfoVersionMajor | puts -nonewline $fh
#incr relInfolength 4
#binary format I $relInfoVersionMinor | puts -nonewline $fh
#incr relInfolength 4
#binary format I $relInfoVersionSubMinor | puts -nonewline $fh
#incr relInfolength 4

# Write release information version fields
puts -nonewline $fh [binary format I $relInfoVersionMajor]
incr relInfolength 4
puts -nonewline $fh [binary format I $relInfoVersionMinor]
incr relInfolength 4
puts -nonewline $fh [binary format I $relInfoVersionSubMinor]
incr relInfolength 4

# Write release firmware version fields
puts -nonewline $fh [binary format I $firmwareVersionMajor]
incr relInfolength 4
puts -nonewline $fh [binary format I $firmwareVersionMinor]
incr relInfolength 4
puts -nonewline $fh [binary format I $firmwareVersionSubMinor]
incr relInfolength 4
puts -nonewline $fh [binary format I $firmwareVersionBuild]
incr relInfolength 4

# Write release revision numbers fields
puts -nonewline $fh [binary format I $rel_proc_hw_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_proc_sw_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_proc_boot_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_proc_common_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_out_hw_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_out_sw_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_out_boot_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_out_common_rev]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_hw_rev1]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_sw_rev1]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_boot_rev1]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_common_rev1]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_hw_rev2]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_sw_rev2]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_boot_rev2]
incr relInfolength 4
puts -nonewline $fh [binary format I $rel_storage_common_rev2]
incr relInfolength 4

# Write release information length field
seek $fh 0 start
puts -nonewline $fh [binary format I $relInfolength]
close $fh

set lfh [open $releaseLogfile "w"]
puts $lfh "Release information file structure version: $relInfoVersionMajor.$relInfoVersionMinor.$relInfoVersionSubMinor"
puts $lfh "Release information file length: $relInfolength bytes"
puts $lfh "Firmware release version: $firmwareVersionMajor.$firmwareVersionMinor.$firmwareVersionSubMinor.$firmwareVersionBuild"
puts $lfh "Processing FPGA hardware SVN revision: $rel_proc_hw_rev"
puts $lfh "Processing FPGA software SVN revision: $rel_proc_sw_rev"
puts $lfh "Processing FPGA boot loader SVN revision: $rel_proc_boot_rev"
puts $lfh "Processing FPGA common repository SVN revision: $rel_proc_common_rev"
puts $lfh "Output FPGA hardware SVN revision: $rel_out_hw_rev"
puts $lfh "Output FPGA software SVN revision: $rel_out_sw_rev"
puts $lfh "Output FPGA boot loader SVN revision: $rel_out_boot_rev"
puts $lfh "Output FPGA common repository SVN revision: $rel_out_common_rev"
puts $lfh "Storage FPGA hardware 16GB SVN revision: $rel_storage_hw_rev1"
puts $lfh "Storage FPGA software 16GB SVN revision: $rel_storage_sw_rev1"
puts $lfh "Storage FPGA boot loader 16GB SVN revision: $rel_storage_boot_rev1"
puts $lfh "Storage FPGA common repository 16GB SVN revision: $rel_storage_common_rev1"
puts $lfh "Storage FPGA hardware 32GB SVN revision: $rel_storage_hw_rev2"
puts $lfh "Storage FPGA software 32GB SVN revision: $rel_storage_sw_rev2"
puts $lfh "Storage FPGA boot loader 32GB SVN revision: $rel_storage_boot_rev2"
puts $lfh "Storage FPGA common repository 32GB SVN revision: $rel_storage_common_rev2"
close $lfh
