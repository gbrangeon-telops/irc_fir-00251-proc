proc read_file {filename} {
    set fh [open $filename r]
    set fileStr [read $fh]
    close $fh
    return $fileStr
}
proc usage {} {
    #note : see switch case line 25
    puts "Usage: verifyRelease.tcl -pbf <procBuildInfoFile> -obf <outputBuildInfoFile> ... "
}

set procBuildInfoFile ""
set outputBuildInfoFile ""
set storageBuildInfoFile ""
set outputReleaseInfoFile ""
set storageReleaseInfoFile1 ""
set storageReleaseInfoFile2 ""
set procReleaseInfoFile ""
set releaseLogFile ""
set fpgaSize ""
set outputFpgaSize ""

#set argv [lassign $argv _]

while {[llength $argv] > 0} {
    switch -- [lindex $argv 0] {
    "-pbf" {
        set procBuildInfoFile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-obf" {
        set outputBuildInfoFile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-sbf" {
        set storageBuildInfoFile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-of" {
        set outputReleaseInfoFile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-sf1" {
        set storageReleaseInfoFile1 [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-sf2" {
        set storageReleaseInfoFile2 [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-pf" {
        set procReleaseInfoFile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-rf" {
        set releaseLogFile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-size" {
        set fpgaSize [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-osize" {
        set outputFpgaSize [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    default {
        usage
        error "Error in command line arguments"
        }
    }
}

set error 0

# Parse proc build info file
set procBuildInfoFileStr [read_file $procBuildInfoFile]
#set procBuildInfoFileSubstr [string range $procBuildInfoFileStr [string first "ARCH_FPGA_$fpgaSize" $procBuildInfoFileStr]]
set procBuildInfoFileSubstr [string range $procBuildInfoFileStr [string first "ARCH_FPGA_${fpgaSize}" $procBuildInfoFileStr] end]
set procBuildInfoHardware ""
set procBuildInfoSoftware ""
set procBuildInfoBootLoader ""
set procBuildInfoCommon ""

if {[regexp {SVN_HARDWARE_REV[^\n\r0-9]+(\d+)} $procBuildInfoFileSubstr match procBuildInfoHardware]} {
    set procBuildInfoHardware $procBuildInfoHardware
} else {
    set error 1
}
if {[regexp {SVN_SOFTWARE_REV[^\n\r0-9]+(\d+)} $procBuildInfoFileSubstr match procBuildInfoSoftware]} {
    set procBuildInfoSoftware $procBuildInfoSoftware
} else {
    set error 1
}
if {[regexp {SVN_BOOTLOADER_REV[^\n\r0-9]+(\d+)} $procBuildInfoFileSubstr match procBuildInfoBootLoader]} {
    set procBuildInfoBootLoader $procBuildInfoBootLoader
} else {
    set error 1
}
if {[regexp {SVN_COMMON_REV[^\n\r0-9]+(\d+)} $procBuildInfoFileSubstr match procBuildInfoCommon]} {
    set procBuildInfoCommon $procBuildInfoCommon
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot parse proc build info file"
    exit 1
}

# Parse output build info file
set outputBuildInfoFileStr [read_file $outputBuildInfoFile]
set outputBuildInfoFileSubstr [string range $outputBuildInfoFileStr \
[string first "ARCH_FPGA_$outputFpgaSize" $outputBuildInfoFileStr] end]
set outputBuildInfoHardware ""
set outputBuildInfoSoftware ""
set outputBuildInfoBootLoader ""
set outputBuildInfoCommon ""

if {[regexp {SVN_HARDWARE_REV[^\n\r0-9]+(\d+)} $outputBuildInfoFileSubstr match outputBuildInfoHardware]} {
    set outputBuildInfoHardware $outputBuildInfoHardware
} else {
    set error 1
}
if {[regexp {SVN_SOFTWARE_REV[^\n\r0-9]+(\d+)} $outputBuildInfoFileSubstr match outputBuildInfoSoftware]} {
    set outputBuildInfoSoftware $outputBuildInfoSoftware
} else {
    set error 1
}
if {[regexp {SVN_BOOTLOADER_REV[^\n\r0-9]+(\d+)} $outputBuildInfoFileSubstr match outputBuildInfoBootLoader]} {
    set outputBuildInfoBootLoader $outputBuildInfoBootLoader
} else {
    set error 1
}
if {[regexp {SVN_COMMON_REV[^\n\r0-9]+(\d+)} $outputBuildInfoFileSubstr match outputBuildInfoCommon]} {
    set outputBuildInfoCommon $outputBuildInfoCommon
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot parse proc build info file"
    exit 1
}

# Parse storage build info file
set storageBuildInfoFileStr [read_file $storageBuildInfoFile]
set storageBuildInfoFileSubstr1 [string range $storageBuildInfoFileStr \
[string first "MEMCONF == 16" $storageBuildInfoFileStr] end]
set storageBuildInfoHardware1 ""
set storageBuildInfoSoftware1 ""
set storageBuildInfoBootLoader1 ""
set storageBuildInfoCommon1 ""

if {[regexp {SVN_HARDWARE_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr1 match storageBuildInfoHardware1]} {
    set storageBuildInfoHardware1 $storageBuildInfoHardware1
} else {
    set error 1
}
if {[regexp {SVN_SOFTWARE_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr1 match storageBuildInfoSoftware1]} {
    set storageBuildInfoSoftware1 $storageBuildInfoSoftware1
} else {
    set error 1
}
if {[regexp {SVN_BOOTLOADER_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr1 match storageBuildInfoBootLoader1]} {
    set storageBuildInfoBootLoader1 $storageBuildInfoBootLoader1
} else {
    set error 1
}
if {[regexp {SVN_COMMON_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr1 match storageBuildInfoCommon1]} {
    set storageBuildInfoCommon1 $storageBuildInfoCommon1
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot parse storage build info file"
    exit 1
}

set storageBuildInfoFileSubstr2 [string range $storageBuildInfoFileStr \
[string first "MEMCONF == 32" $storageBuildInfoFileStr] end]
set storageBuildInfoHardware2 ""
set storageBuildInfoSoftware2 ""
set storageBuildInfoBootLoader2 ""
set storageBuildInfoCommon2 ""

if {[regexp {SVN_HARDWARE_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr2 match storageBuildInfoHardware2]} {
    set storageBuildInfoHardware2 $storageBuildInfoHardware2
} else {
    set error 1
}
if {[regexp {SVN_SOFTWARE_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr2 match storageBuildInfoSoftware2]} {
    set storageBuildInfoSoftware2 $storageBuildInfoSoftware2
} else {
    set error 1
}
if {[regexp {SVN_BOOTLOADER_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr2 match storageBuildInfoBootLoader2]} {
    set storageBuildInfoBootLoader2 $storageBuildInfoBootLoader2
} else {
    set error 1
}
if {[regexp {SVN_COMMON_REV[^\n\r0-9]+(\d+)} $storageBuildInfoFileSubstr2 match storageBuildInfoCommon2]} {
    set storageBuildInfoCommon2 $storageBuildInfoCommon2
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot parse storage build info file"
    exit 1
}

# Parse output release info file
set outputReleaseInfoFileStr [read_file $outputReleaseInfoFile]
set outputReleaseInfoHardware ""
set outputReleaseInfoSoftware ""
set outputReleaseInfoBootLoader ""
set outputReleaseInfoCommon ""

if {[regexp {rel_out_hw_rev[^\n\r0-9]+(\d+)} $outputReleaseInfoFileStr match outputReleaseInfoHardware]} {
    set outputReleaseInfoHardware $outputReleaseInfoHardware
} else {
    set error 1
}
if {[regexp {rel_out_sw_rev[^\n\r0-9]+(\d+)} $outputReleaseInfoFileStr match outputReleaseInfoSoftware]} {
    set outputReleaseInfoSoftware $outputReleaseInfoSoftware
} else {
    set error 1
}
if {[regexp {rel_out_boot_rev[^\n\r0-9]+(\d+)} $outputReleaseInfoFileStr match outputReleaseInfoBootLoader]} {
    set outputReleaseInfoBootLoader $outputReleaseInfoBootLoader
} else {
    set error 1
}
if {[regexp {rel_out_common_rev[^\n\r0-9]+(\d+)} $outputReleaseInfoFileStr match outputReleaseInfoCommon]} {
    set outputReleaseInfoCommon $outputReleaseInfoCommon
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot  parse output release info file"
    exit 1
}

# Parse storage release info file
set storageReleaseInfoFileStr1 [read_file $storageReleaseInfoFile1]
set storageReleaseInfoHardware1 ""
set storageReleaseInfoSoftware1 ""
set storageReleaseInfoBootLoader1 ""
set storageReleaseInfoCommon1 ""

if {[regexp {rel_storage_hw_rev1[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr1 match storageReleaseInfoHardware1]} {
    set storageReleaseInfoHardware1 $storageReleaseInfoHardware1
} else {
    set error 1
}
if {[regexp {rel_storage_sw_rev1[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr1 match storageReleaseInfoSoftware1]} {
    set storageReleaseInfoSoftware1 $storageReleaseInfoSoftware1
} else {
    set error 1
}
if {[regexp {rel_storage_boot_rev1[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr1 match storageReleaseInfoBootLoader1]} {
    set storageReleaseInfoBootLoader1 $storageReleaseInfoBootLoader1
} else {
    set error 1
}
if {[regexp {rel_storage_common_rev1[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr1 match storageReleaseInfoCommon1]} {
    set storageReleaseInfoCommon1 $storageReleaseInfoCommon1
} else {
    set error 1
}

set storageReleaseInfoFileStr2 [read_file $storageReleaseInfoFile2]
set storageReleaseInfoHardware2 ""
set storageReleaseInfoSoftware2 ""
set storageReleaseInfoBootLoader2 ""
set storageReleaseInfoCommon2 ""

if {[regexp {rel_storage_hw_rev2[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr2 match storageReleaseInfoHardware2]} {
    set storageReleaseInfoHardware2 $storageReleaseInfoHardware2
} else {
    set error 1
}
if {[regexp {rel_storage_sw_rev2[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr2 match storageReleaseInfoSoftware2]} {
    set storageReleaseInfoSoftware2 $storageReleaseInfoSoftware2
} else {
    set error 1
}
if {[regexp {rel_storage_boot_rev2[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr2 match storageReleaseInfoBootLoader2]} {
    set storageReleaseInfoBootLoader2 $storageReleaseInfoBootLoader2
} else {
    set error 1
}
if {[regexp {rel_storage_common_rev2[^\n\r0-9]+(\d+)} $storageReleaseInfoFileStr2 match storageReleaseInfoCommon2]} {
    set storageReleaseInfoCommon2 $storageReleaseInfoCommon2
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot parse storage build info file"
    exit 1
}

# Parse proc release info file
set procReleaseInfoFileStr [read_file $procReleaseInfoFile]
set procReleaseInfoHardware ""
set procReleaseInfoSoftware ""
set procReleaseInfoBootLoader ""
set procReleaseInfoCommon ""

if {[regexp {rel_proc_hw_rev[^\n\r0-9]+(\d+)} $procReleaseInfoFileStr match procReleaseInfoHardware]} {
    set procReleaseInfoHardware $procReleaseInfoHardware
} else {
    set error 1
}
if {[regexp {rel_proc_sw_rev[^\n\r0-9]+(\d+)} $procReleaseInfoFileStr match procReleaseInfoSoftware]} {
    set procReleaseInfoSoftware $procReleaseInfoSoftware
} else {
    set error 1
}
if {[regexp {rel_proc_boot_rev[^\n\r0-9]+(\d+)} $procReleaseInfoFileStr match procReleaseInfoBootLoader]} {
    set procReleaseInfoBootLoader $procReleaseInfoBootLoader
} else {
    set error 1
}
if {[regexp {rel_proc_common_rev[^\n\r0-9]+(\d+)} $procReleaseInfoFileStr match procReleaseInfoCommon]} {
    set procReleaseInfoCommon $procReleaseInfoCommon
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot  parse proc release info file"
    exit 1
}

# Parse release log file
set releaseLogFileStr [read_file $releaseLogFile]
set releaseLogVersion ""
set releaseLogProcHardware ""
set releaseLogProcSoftware ""
set releaseLogProcBootLoader ""
set releaseLogProcCommon ""
set releaseLogOutputHardware ""
set releaseLogOutputSoftware ""
set releaseLogOutputBootLoader ""
set releaseLogOutputCommon ""
set releaseLogStorageHardware1 ""
set releaseLogStorageSoftware1 ""
set releaseLogStorageBootLoader1 ""
set releaseLogStorageCommon1 ""
set releaseLogStorageHardware2 ""
set releaseLogStorageSoftware2 ""
set releaseLogStorageBootLoader2 ""
set releaseLogStorageCommon2 ""

if {[regexp {Firmware release version[^\n\r0-9]+([\d\.]+)} $releaseLogFileStr match releaseLogVersion]} {
    set releaseLogVersion $releaseLogVersion
} else {
    set error 1
}
if {[regexp {Processing FPGA hardware[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogProcHardware]} {
    set releaseLogProcHardware $releaseLogProcHardware
} else {
    set error 1
}
if {[regexp {Processing FPGA software[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogProcSoftware]} {
    set releaseLogProcSoftware $releaseLogProcSoftware
} else {
    set error 1
}
if {[regexp {Processing FPGA boot loader[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogProcBootLoader]} {
    set releaseLogProcBootLoader $releaseLogProcBootLoader
} else {
    set error 1
}
if {[regexp {Processing FPGA common[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogProcCommon]} {
    set releaseLogProcCommon $releaseLogProcCommon
} else {
    set error 1
}
if {[regexp {Output FPGA hardware[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogOutputHardware]} {
    set releaseLogOutputHardware $releaseLogOutputHardware
} else {
    set error 1
}
if {[regexp {Output FPGA software[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogOutputSoftware]} {
    set releaseLogOutputSoftware $releaseLogOutputSoftware
} else {
    set error 1
}
if {[regexp {Output FPGA boot loader[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogOutputBootLoader]} {
    set releaseLogOutputBootLoader $releaseLogOutputBootLoader
} else {
    set error 1
}
if {[regexp {Output FPGA common[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogOutputCommon]} {
    set releaseLogOutputCommon $releaseLogOutputCommon
} else {
    set error 1
}

if {[regexp {Storage FPGA hardware 16GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageHardware1]} {
    set releaseLogStorageHardware1 $releaseLogStorageHardware1
} else {
    set error 1
}
if {[regexp {Storage FPGA software 16GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageSoftware1]} {
    set releaseLogStorageSoftware1 $releaseLogStorageSoftware1
} else {
    set error 1
}
if {[regexp {Storage FPGA boot loader 16GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageBootLoader1]} {
    set releaseLogStorageBootLoader1 $releaseLogStorageBootLoader1
} else {
    set error 1
}
if {[regexp {Storage FPGA common repository 16GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageCommon1]} {
    set releaseLogStorageCommon1 $releaseLogStorageCommon1
} else {
    set error 1
}

if {[regexp {Storage FPGA hardware 32GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageHardware2]} {
    set releaseLogStorageHardware2 $releaseLogStorageHardware2
} else {
    set error 1
}
if {[regexp {Storage FPGA software 32GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageSoftware2]} {
    set releaseLogStorageSoftware2 $releaseLogStorageSoftware2
} else {
    set error 1
}
if {[regexp {Storage FPGA boot loader 32GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageBootLoader2]} {
    set releaseLogStorageBootLoader2 $releaseLogStorageBootLoader2
} else {
    set error 1
}
if {[regexp {Storage FPGA common repository 32GB[^\n\r0-9]+(\d+)} $releaseLogFileStr match releaseLogStorageCommon2]} {
    set releaseLogStorageCommon2 $releaseLogStorageCommon2
} else {
    set error 1
}

if {$error == 1} {
    puts "Cannot parse release log file"
    exit 1
}

puts $procReleaseInfoHardware
puts $procBuildInfoHardware
puts $procReleaseInfoSoftware
puts $procBuildInfoSoftware
puts $procReleaseInfoBootLoader
puts $procBuildInfoBootLoader
puts $procReleaseInfoCommon
puts $procBuildInfoCommon
# Verify proc build info file
if {($procReleaseInfoHardware != $procBuildInfoHardware) ||
($procReleaseInfoSoftware != $procBuildInfoSoftware) ||
($procReleaseInfoBootLoader != $procBuildInfoBootLoader) ||
($procReleaseInfoCommon != $procBuildInfoCommon)} {
    puts "Processing FPGA release info does not match build info"
    exit 1
}

# Verify proc release log file
if {($procReleaseInfoHardware != $releaseLogProcHardware) ||
($procReleaseInfoSoftware != $releaseLogProcSoftware) ||
($procReleaseInfoBootLoader != $releaseLogProcBootLoader) ||
($procReleaseInfoCommon != $releaseLogProcCommon)} {
    puts "Processing FPGA release info does not match release log file"
    exit 1
}

# Verify output build info file
if {($outputReleaseInfoHardware != $outputBuildInfoHardware) ||
($outputReleaseInfoSoftware != $outputBuildInfoSoftware) ||
($outputReleaseInfoBootLoader != $outputBuildInfoBootLoader) ||
($outputReleaseInfoCommon != $outputBuildInfoCommon)} {
    puts "Output FPGA release info does not match build info"
    exit 1
}

# Verify output release log file
if {($outputReleaseInfoHardware != $releaseLogOutputHardware) ||
($outputReleaseInfoSoftware != $releaseLogOutputSoftware) ||
($outputReleaseInfoBootLoader != $releaseLogOutputBootLoader) ||
($outputReleaseInfoCommon != $releaseLogOutputCommon)} {
    puts "Output FPGA release info does not match release log file"
    exit 1
}

# Verify storage build info file
if {($storageReleaseInfoHardware1 != $storageBuildInfoHardware1) ||
($storageReleaseInfoSoftware1 != $storageBuildInfoSoftware1) ||
($storageReleaseInfoBootLoader1 != $storageBuildInfoBootLoader1) ||
($storageReleaseInfoCommon1 != $storageBuildInfoCommon1) ||
($storageReleaseInfoHardware2 != $storageBuildInfoHardware2) ||
($storageReleaseInfoSoftware2 != $storageBuildInfoSoftware2) ||
($storageReleaseInfoBootLoader2 != $storageBuildInfoBootLoader2) ||
($storageReleaseInfoCommon2 != $storageBuildInfoCommon2)} {
    puts "Storage FPGA release info does not match build info"
    exit 1
}

# Verify storage release log file
if {($storageReleaseInfoHardware1 != $releaseLogStorageHardware1) ||
($storageReleaseInfoSoftware1 != $releaseLogStorageSoftware1) ||
($storageReleaseInfoBootLoader1 != $releaseLogStorageBootLoader1) ||
($storageReleaseInfoCommon1 != $releaseLogStorageCommon1) ||
($storageReleaseInfoHardware2 != $releaseLogStorageHardware2) ||
($storageReleaseInfoSoftware2 != $releaseLogStorageSoftware2) ||
($storageReleaseInfoBootLoader2 != $releaseLogStorageBootLoader2) ||
($storageReleaseInfoCommon2 != $releaseLogStorageCommon2)} {
    puts "Storage FPGA release info does not match release log file"
    exit 1
}

puts "$releaseLogVersion (Passed)"