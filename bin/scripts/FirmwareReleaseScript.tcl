
proc DebugPause {} {
    puts "\n<W> Paused"
    puts -nonewline "> "
    flush stdout
    gets stdin
    puts "\n"
}

proc fetchHwSwFiles {SwFile hwFile} {
    #clean up
    file delete -force $hwFile
    file copy -force $SwFile $hwFile
}
proc fetchNumericValue {inputfile fieldName} {
    set fp [open $inputfile r]
    set inputStr [read $fp]
    close $fp

    if {[regexp "$fieldName=(\\d+)" $inputStr match number]} {
        return $number
    } elseif {[regexp "$fieldName\\s+(\\d+)" $inputStr match number]} {
        return $number
    } else {
        return 0
    }
}

proc updateVersionFile {sensor_name fpga_size} {
    global scriptsDir
    global vfirmwareVersionMajor
    global vfirmwareVersionMinor
    global vfirmwareVersionBuild
    global sensorCode
    set commonDir ""
    set projectDir ""
    set x_xsct ""
    set srcDir ""
    set versionFile ""
    source "${scriptsDir}/setEnvironment.tcl"
    setEnvironmentVariable $sensor_name $fpga_size

    set GenICam_h "${commonDir}/Software/GenICam.h"
    set sensorInfoFile "${projectDir}/bin/SensorInformation.txt"

    #get sensorcode information
    set sensorCode "0"
    set sensorWidth ""
    set sensorHeight ""

    set inputFile [open "$sensorInfoFile" r]
    while {[gets $inputFile line] != -1} {
        set tokens [split $line ","]
        set sensorNameToken [lindex $tokens 0]
        set sensorCodeToken [lindex $tokens 1]
        set sensorWidthToken [lindex $tokens 2]
        set sensorHeightToken [lindex $tokens 3]

        if {$sensorNameToken eq $sensor_name} {
            set sensorCode $sensorCodeToken
            set sensorWidth $sensorWidthToken
            set sensorHeight $sensorHeightToken
            break
        }
    }
    close $inputFile


    set fsMajorVersion [fetchNumericValue "$srcDir/IRCamFiles/IRCamFiles.h" TSFSFILES_VERSION]
    set FlashSettingsFile_h "$srcDir/IRCamFiles/FlashSettingsFile_v$fsMajorVersion.h"
    set fdvMajorVersion [fetchNumericValue "$srcDir/IRCamFiles/IRCamFiles.h" TSDVFILES_VERSION]
    set FlashDynamicValuesFile_h "$srcDir/IRCamFiles/FlashDynamicValuesFile_v$fdvMajorVersion.h"
    set calMajorVersion [fetchNumericValue "$srcDir/IRCamFiles/IRCamFiles.h" CALIBFILES_VERSION]
    set CalibCollectionFile_h "$srcDir/IRCamFiles/CalibCollectionFile_v$calMajorVersion.h"
    set FirmwareVersionFile "$projectDir/bin/FirmwareReleaseVersion.txt"

    #TODO NOT SET A version FILE JUST A SET GLOBAL VARIABLE
    set script [open $versionFile w]
    puts  -nonewline $script "set firmwareVersionMajor="
    set vfirmwareVersionMajor [fetchNumericValue $FirmwareVersionFile firmwareVersionMajor]
    puts $script "$vfirmwareVersionMajor"
    set vfirmwareVersionMinor [fetchNumericValue $FirmwareVersionFile firmwareVersionMinor]
    puts -nonewline $script "set firmwareVersionMinor="
    puts  $script $vfirmwareVersionMinor
    puts $script "set firmwareVersionSubMinor=$sensorCode"
    puts -nonewline $script "set firmwareVersionBuild="
    set vfirmwareVersionBuild [fetchNumericValue $FirmwareVersionFile firmwareVersionBuild]
    puts $script "$vfirmwareVersionBuild"
    puts $script "set firmwareVersion=%firmwareVersionMajor%.%firmwareVersionMinor%.%firmwareVersionSubMinor%.%firmwareVersionBuild%"

    puts -nonewline $script "set xmlVersionMajor="
    set vxmlVersionMajor [fetchNumericValue $GenICam_h GC_XMLMAJORVERSION]
    puts $script "$vxmlVersionMajor"
    puts -nonewline $script "set xmlVersionMinor="
    set vxmlVersionMinor [fetchNumericValue $GenICam_h GC_XMLMINORVERSION]
    puts $script "$vxmlVersionMinor"
    puts -nonewline $script "set xmlVersionSubMinor="
    set vxmlVersionSubMinor [fetchNumericValue $GenICam_h GC_XMLSUBMINORVERSION]
    puts $script "$vxmlVersionSubMinor"
    puts $script "set xmlVersion=%xmlVersionMajor%.%xmlVersionMinor%.%xmlVersionSubMinor%"

    puts -nonewline $script "set flashSettingsVersionMajor="
    set vflashSettingsVersionMajor [fetchNumericValue $FlashSettingsFile_h "FLASHSETTINGS_FILEMAJORVERSION_V$fsMajorVersion"]
    puts $script "$vflashSettingsVersionMajor"
    puts -nonewline $script "set flashSettingsVersionMinor="
    set vflashSettingsVersionMinor [fetchNumericValue $FlashSettingsFile_h "FLASHSETTINGS_FILEMINORVERSION_V$fsMajorVersion"]
    puts $script "$vflashSettingsVersionMinor"
    puts -nonewline $script "set flashSettingsVersionSubMinor="
    set vflashSettingsVersionSubMinor [fetchNumericValue $FlashSettingsFile_h "FLASHSETTINGS_FILESUBMINORVERSION_V$fsMajorVersion"]
    puts $script "$vflashSettingsVersionSubMinor"
    puts $script "set flashSettingsVersion=%flashSettingsVersionMajor%.%flashSettingsVersionMinor%.%flashSettingsVersionSubMinor%"

    puts -nonewline $script "set flashDynamicValuesVersionMajor="
    set vflashDynamicValuesVersionMajor [fetchNumericValue $FlashDynamicValuesFile_h "FLASHDYNAMICVALUES_FILEMAJORVERSION_V$fdvMajorVersion"]
    puts $script "$vflashDynamicValuesVersionMajor"
    puts -nonewline $script "set flashDynamicValuesVersionMinor="
    set vflashDynamicValuesVersionMinor [fetchNumericValue $FlashDynamicValuesFile_h "FLASHDYNAMICVALUES_FILEMINORVERSION_V$fdvMajorVersion"]
    puts $script "$vflashDynamicValuesVersionMinor"
    puts -nonewline $script "set flashDynamicValuesVersionSubMinor="
    set vflashDynamicValuesVersionSubMinor [fetchNumericValue $FlashDynamicValuesFile_h "FLASHDYNAMICVALUES_FILESUBMINORVERSION_V$fdvMajorVersion"]
    puts $script "$vflashDynamicValuesVersionSubMinor"
    puts $script "set flashDynamicValuesVersion=%flashDynamicValuesVersionMajor%.%flashDynamicValuesVersionMinor%.%flashDynamicValuesVersionSubMinor%"

    puts -nonewline $script "set calibFilesVersionMajor="
    set vcalibFilesVersionMajor [fetchNumericValue $CalibCollectionFile_h "CALIBCOLLECTION_FILEMAJORVERSION_V$calMajorVersion"]
    puts $script "$vcalibFilesVersionMajor"
    puts -nonewline $script "set calibFilesVersionMinor="
    set vcalibFilesVersionMinor [fetchNumericValue $CalibCollectionFile_h "CALIBCOLLECTION_FILEMINORVERSION_V$calMajorVersion"]
    puts $script "$vcalibFilesVersionMinor"
    puts -nonewline  $script "set calibFilesVersionSubMinor="
    set vcalibFilesVersionSubMinor [fetchNumericValue $CalibCollectionFile_h "CALIBCOLLECTION_FILESUBMINORVERSION_V$calMajorVersion"]
    puts $script "$vcalibFilesVersionSubMinor"
    puts $script "set calibFilesVersion=%calibFilesVersionMajor%.%calibFilesVersionMinor%.%calibFilesVersionSubMinor%"

    #set newVersionFile [string map {.txt .bat} $versionFile]
    close $script

    puts "done"
}

proc updateReleaseSvnRevsFile {scripts_dir sensor_name fpga_size} {
    set revFile ""
    set svn_subwcrev ""
    set hwFile ""
    set elfFile ""
    set bootFile ""
    set commonDir ""
    set tortoiseSVNDir ""

    source "${scripts_dir}/setEnvironment.tcl"
    setEnvironmentVariable $sensor_name $fpga_size

    # clean up
    if {[ catch {[file delete -force $revFile]} ]} {
        puts "Error: Can't delete $revFile"
    }
    set Vfo [open $revFile w]
    puts $Vfo "set rel_proc_hw_rev \$WCREV\$"
    close $Vfo
    puts "$svn_subwcrev $hwFile $revFile $revFile"
    if {[ catch {[exec $svn_subwcrev $hwFile $revFile $revFile]} ]} {
        puts "SubWCRev.exe Hw done"
    }
    set Vfo [open $revFile a]
    puts $Vfo "set rel_proc_sw_rev \$WCREV\$"
    close $Vfo
    if {[ catch {[exec $svn_subwcrev $elfFile $revFile $revFile]} ]} {
        puts "SubWCRev.exe elf done"
    }
    set Vfo [open $revFile a]
    puts $Vfo "set rel_proc_boot_rev \$WCREV\$"
    close $Vfo
    if {[ catch {[exec $svn_subwcrev $bootFile $revFile $revFile]} ]} {
        puts "SubWCRev.exe boot done"
    }
    set Vfo [open $revFile a]
    puts $Vfo "set rel_proc_common_rev \$WCREV\$"
    close $Vfo
    if {[ catch {[exec $svn_subwcrev $commonDir $revFile $revFile]} ]} {
        puts "SubWCRev.exe boot done"
    }
    
    #add revsion file 
    set tortoiseSvnBin "$tortoiseSVNDir/bin/svn.exe"
    if {[ catch {[exec $tortoiseSvnBin add $revFile]} ]} {
        puts "Target is already versioned"
    }
    
}

proc generateReleaseFile {sensorName fpgaSize} {
    global scriptsDir
    global vfirmwareVersionMajor
    global vfirmwareVersionMinor
    global vfirmwareVersionBuild
    global sensorCode
    set relInfoVersionMajor 2
    set relInfoVersionMinor 2
    set relInfoVersionSubMinor 0
    set revFile ""
    set outputRevFile ""
    set storageRevFile1 ""
    set storageRevFile2 ""
    set releaseFile ""
    set releaseLogFile ""

    # Set environment variables
    source "${scriptsDir}/setEnvironment.tcl"
    setEnvironmentVariable $sensorName $fpgaSize

    set firmwareVersionMajor $vfirmwareVersionMajor
    set firmwareVersionMinor $vfirmwareVersionMinor
    set firmwareVersionSubMinor $sensorCode
    set firmwareVersionBuild $vfirmwareVersionBuild

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

    #require 
    source $revFile
    source $outputRevFile
    source $storageRevFile1
    source $storageRevFile2
    set relInfolength 0
    puts $releaseFile
    puts $releaseLogFile
    # Update release file
    set fh [open $releaseFile w]

    # Skip release information length field
    incr relInfolength 4
    seek $fh $relInfolength start

    # Write release information version fields
    puts -nonewline $fh [binary format i $relInfoVersionMajor]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $relInfoVersionMinor]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $relInfoVersionSubMinor]
    incr relInfolength 4

    # Write release firmware version fields
    puts -nonewline $fh [binary format i $firmwareVersionMajor]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $firmwareVersionMinor]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $firmwareVersionSubMinor]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $firmwareVersionBuild]
    incr relInfolength 4

    # Write release revision numbers fields
    puts -nonewline $fh [binary format i $rel_proc_hw_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_proc_sw_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_proc_boot_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_proc_common_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_out_hw_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_out_sw_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_out_boot_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_out_common_rev]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_hw_rev1]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_sw_rev1]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_boot_rev1]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_common_rev1]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_hw_rev2]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_sw_rev2]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_boot_rev2]
    incr relInfolength 4
    puts -nonewline $fh [binary format i $rel_storage_common_rev2]
    incr relInfolength 4

    # Write release information length field
    seek $fh 0 start
    puts -nonewline $fh [binary format i $relInfolength]
    close $fh

    set lfh [open $releaseLogFile "w"]
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

}

proc read_file {filename} {
    set fh [open $filename r]
    set fileStr [read $fh]
    close $fh
    return $fileStr
}

proc verifyRelease {sensorName fpgaSize} {
    global scriptsDir
    set buildInfoFile ""
    set outputBuildInfoFile ""
    set storageBuildInfoFile ""
    set outputRevFile ""
    set storageRevFile1  ""
    set storageRevFile2  "" 
    set releaseLogFile ""
    set revFile ""
    set outputFpgaSize ""
    # Set environment variables
    source "${scriptsDir}/setEnvironment.tcl"
    setEnvironmentVariable $sensorName $fpgaSize
    set procReleaseInfoFile $revFile
    set storageReleaseInfoFile1 $storageRevFile1
    set storageReleaseInfoFile2 $storageRevFile2
    set outputReleaseInfoFile $outputRevFile
    set procBuildInfoFile $buildInfoFile

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
        error "Cannot parse proc build info file"
        
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
        error "Cannot parse storage build info file"
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
        error "Cannot parse storage build info file"
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
        error "Cannot  parse output release info file"
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
        error "Cannot parse storage build info file"
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
        error "Cannot  parse proc release info file"
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
        error "Cannot parse release log file"
    }


    # Verify proc build info file
    if {($procReleaseInfoHardware != $procBuildInfoHardware) ||
    ($procReleaseInfoSoftware != $procBuildInfoSoftware) ||
    ($procReleaseInfoBootLoader != $procBuildInfoBootLoader) ||
    ($procReleaseInfoCommon != $procBuildInfoCommon)} {
        error "Processing FPGA release info does not match build info"
    }

    # Verify proc release log file
    if {($procReleaseInfoHardware != $releaseLogProcHardware) ||
    ($procReleaseInfoSoftware != $releaseLogProcSoftware) ||
    ($procReleaseInfoBootLoader != $releaseLogProcBootLoader) ||
    ($procReleaseInfoCommon != $releaseLogProcCommon)} {
        error "Processing FPGA release info does not match release log file"
    }

    # Verify output build info file
    if {($outputReleaseInfoHardware != $outputBuildInfoHardware) ||
    ($outputReleaseInfoSoftware != $outputBuildInfoSoftware) ||
    ($outputReleaseInfoCommon != $outputBuildInfoCommon)} {
    error "Output FPGA release info does not match build info"
    }

    # Verify output release log file
    if {($outputReleaseInfoHardware != $releaseLogOutputHardware) ||
    ($outputReleaseInfoSoftware != $releaseLogOutputSoftware) ||
    ($outputReleaseInfoCommon != $releaseLogOutputCommon)} {
        error "Output FPGA release info does not match release log file"
    }

    # Verify storage build info file
    if {($storageReleaseInfoHardware1 != $storageBuildInfoHardware1) ||
    ($storageReleaseInfoSoftware1 != $storageBuildInfoSoftware1) ||
    ($storageReleaseInfoCommon1 != $storageBuildInfoCommon1) ||
    ($storageReleaseInfoHardware2 != $storageBuildInfoHardware2) ||
    ($storageReleaseInfoSoftware2 != $storageBuildInfoSoftware2) ||
    ($storageReleaseInfoCommon2 != $storageBuildInfoCommon2)} {
    error "Storage FPGA release info does not match build info"
    }

    # Verify storage release log file
    if {($storageReleaseInfoHardware1 != $releaseLogStorageHardware1) ||
    ($storageReleaseInfoSoftware1 != $releaseLogStorageSoftware1) ||
    ($storageReleaseInfoCommon1 != $releaseLogStorageCommon1) ||
    ($storageReleaseInfoHardware2 != $releaseLogStorageHardware2) ||
    ($storageReleaseInfoSoftware2 != $releaseLogStorageSoftware2) ||
    ($storageReleaseInfoCommon2 != $releaseLogStorageCommon2)} {
        error "Storage FPGA release info does not match release log file"
    }

    puts "$releaseLogVersion (Passed)"

}

proc FirmwareReleaseScript_step1 {sensorName fpgaSize logFile} {
    global scriptsDir
    set sdkDir ""
    set baseName ""
    set elfFile ""
    set projectDir ""
    append logContent "BEGIN Pre-release compile $sensorName $fpgaSize\n"

    # Set environment variables
    source "${scriptsDir}/setEnvironment.tcl"
    setEnvironmentVariable $sensorName $fpgaSize

    # Create and build main project $sensorName $fpgaSize 1 "main_only"
    source  "$projectDir/sdk/sdk_proc_cmd.tcl" 
    create_proc_sw $sensorName $fpgaSize
    build_proc_sw $sensorName $fpgaSize "main_only"

    if {![file exists $sdkDir/${baseName}_${fpgaSize}/Release/${baseName}_${fpgaSize}.elf]} {
        append logContent "Create and build project failed!\n"
        # Append log content to the log file
        set logFileHandle [open $logFile a]
        puts -nonewline $logFileHandle $logContent
        close $logFileHandle
        error "Step 1:Create and build project failed!\n"
    }

    append logContent "Create and build project done\n"

    # Copy files
    fetchHwSwFiles "$sdkDir/${baseName}_${fpgaSize}/Release/${baseName}_${fpgaSize}.elf" $elfFile

    append logContent "fetchHwSwFiles done\n"
    append logContent "END Pre-release compile $sensorName $fpgaSize\n.\n"

    puts "END Pre-release compile $sensorName $fpgaSize\n.\n"

    # Append log content to the log file
    set logFileHandle [open $logFile a]
    puts -nonewline $logFileHandle $logContent
    close $logFileHandle
}
proc FirmwareReleaseScript_step2 {sensorName fpgaSize logFile} {
    global scriptsDir
    set sdkDir ""
    set baseName ""
    set xDir ""
    set projectDir ""
    append logContent "BEGIN Release compile $sensorName $fpgaSize\n"
    puts "BEGIN Release compile compile $sensorName $fpgaSize"
    # Set environment variables
    source "${scriptsDir}/setEnvironment.tcl"
    setEnvironmentVariable $sensorName $fpgaSize

    # Build main project
    # Create and build main project $sensorName $fpgaSize 0 "main_only"
    source  "$projectDir/sdk/sdk_proc_cmd.tcl" 
    build_proc_sw $sensorName $fpgaSize "main_only"

    if {![file exists $sdkDir/${baseName}_${fpgaSize}/Release/${baseName}_${fpgaSize}.elf]} {
        append logContent "Create and build project failed!\n"
        set logFileHandle [open $logFile a]
        puts -nonewline $logFileHandle $logContent
        close $logFileHandle
        error "Step 2:Create and build project failed!\n"
    }

    append logContent "Build project done\n"
    puts "Build project done"

    # Generate release files
    #updateReleaseSvnRevsFile
    updateReleaseSvnRevsFile $scriptsDir $sensorName $fpgaSize
    puts "updateReleaseSvnRevsFile done"
    updateVersionFile $sensorName $fpgaSize
    puts "updateVersionFile done"
    generateReleaseFile $sensorName $fpgaSize
    append logContent "generateReleaseFile done\n"
    puts "generateReleaseFile done"
    # Verify release files
    verifyRelease $sensorName $fpgaSize
    append logContent "verifyRelease done\n"
    puts "verifyRelease done"

    # Note: Because generatePromFile uses the vivado bin, we have to call the .bat
    exec $scriptsDir/generatePromFile.bat $sensorName $fpgaSize

    append logContent "generatePromFile done\n"
    puts "generatePromFile done"

    append logContent "END Release compile $sensorName $fpgaSize\n.\n"

    puts "END Release compile $sensorName $fpgaSize"
    # Append log content to the log file
    set logFileHandle [open $logFile a]
    puts -nonewline $logFileHandle $logContent
    close $logFileHandle
}

proc FirmwareReleaseScript_step3 {sensorName fpgaSize logFile} {
    global scriptsDir
    global vfirmwareVersionMajor
    global vfirmwareVersionMinor
    global vfirmwareVersionBuild
    global sensorCode
    
    set releaseDir ""
    set projectDir ""
    set releaseNameDir ""
    append logContent "BEGIN Export release files $sensorName $fpgaSize\n"
    puts "BEGIN Export release files $sensorName $fpgaSize"
    # Set environment variables
    source "${scriptsDir}/setEnvironment.tcl"
    setEnvironmentVariable $sensorName $fpgaSize

    source $scriptsDir/exportReleaseArchive.tcl
    set releaseDir [convertScript $sensorName $fpgaSize $scriptsDir]

    set firmwareVersion "$vfirmwareVersionMajor.$vfirmwareVersionMinor.$sensorCode.$vfirmwareVersionBuild"
    set encrypt_key_name [parseHWRevFile $sensorName $fpgaSize $sdkDir]
    #delete previous and copy new one
    if {$sensorName eq "startup"} {
        set releaseNameDir [format "%s/Release_%s (%s_%s, %s key)" "$projectDir/bin/ReleasedFirmwares/" [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion] $sensorName $fpgaSize $encrypt_key_name]
    } else {
        set releaseNameDir [format "%s/Release_%s (%s, %s key)" "$projectDir/bin/ReleasedFirmwares/" [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion] $sensorName $encrypt_key_name]
    }
    catch {file delete -force -- $releaseNameDir}
    file copy -force $releaseDir "$projectDir/bin/ReleasedFirmwares/"
    file delete -force -- $releaseDir

    append logContent "END Export release files $sensorName $fpgaSize\n"
    puts "END Export release files $sensorName $fpgaSize"
    append logContent "\n"

    # Append log content to the log file
    set logFileHandle [open $logFile a]
    puts -nonewline $logFileHandle $logContent
    close $logFileHandle

}

global scriptsDir
set scriptsDir "D:/Telops/FIR-00251-Proc/bin/scripts" 

set TestMode "None"
#Argument check
if { $argc == 1 } {
	puts "Call FirmwareReleaseScript in TestMode"
	set TestMode [lindex $argv 0 ]
} 

set projectDir "D:/Telops/FIR-00251-Proc"
set FirmwareReleaseListFile "$projectDir/bin/FirmwareReleaseList.txt"
set FirmwareReleaseVersionFile "$projectDir/bin/FirmwareReleaseVersion.txt"
set FirmwareReleaseLogFile "$projectDir/bin/FirmwareRelease.log"
set svnDir "http://einstein/svn/firmware/"
set tortoiseSvnBin "C:/Program Files/TortoiseSVN/bin/svn.exe"

#In this mode, skip the release procedure and get only the process
if {$TestMode == "Source"} {
    exit 0
}
set FirmwareReleaseLogFile [format "%s" $FirmwareReleaseLogFile]
file delete -force $FirmwareReleaseLogFile
file mkdir [format "%s/bin/ReleasedFirmwares" $projectDir]

set major ""
set minor ""
set build ""

set fid [open $FirmwareReleaseVersionFile r]
set contents [read $fid]
set lines [split $contents "\n"]
close $fid

foreach line $lines {
    if {[string match "*firmwareVersionMajor*" $line]} {
        set major [lindex [split $line "="] 1]
    } elseif {[string match "*firmwareVersionMinor*" $line]} {
        set minor [lindex [split $line "="] 1]
    } elseif {[string match "*firmwareVersionBuild*" $line]} {
        set build [lindex [split $line "="] 1]
    }   
}

set firmwareReleaseVersion [format "%s.%s.x.%s" $major $minor $build]
puts "*****************************************"
puts "BEGIN Firmware release $firmwareReleaseVersion"
puts "*****************************************"
puts ""

set fid [open $FirmwareReleaseLogFile a]
puts $fid "*****************************************"
puts $fid "BEGIN Firmware release $firmwareReleaseVersion"
puts $fid "*****************************************"
puts $fid ""
close $fid

set fid [open $FirmwareReleaseListFile r]
set contents [read $fid]
set lines [split $contents "\n"]
close $fid
set lineToSkip 3
foreach line $lines {
    if {$lineToSkip == 0} {
        set tokens [split $line ","]
        set sensorName [lindex $tokens 0]
        set substring "#"
        # Dont read line with #
        if {[string first $substring $sensorName] == -1} {
            set fpgaSize [lindex $tokens 1]
            puts "Sensor in list: $sensorName $fpgaSize"
            FirmwareReleaseScript_step1 $sensorName $fpgaSize $FirmwareReleaseLogFile
        }

    } else {
        set lineToSkip [expr $lineToSkip-1]
    }
}

if {$TestMode == "Debug"} {
    DebugPause
}

set preReleaseMessage "Pre-release $firmwareReleaseVersion"
exec $tortoiseSvnBin commit $projectDir -m \"$preReleaseMessage\"
exec $tortoiseSvnBin update $projectDir

set fid [open $FirmwareReleaseLogFile a]
puts $fid "*****************************************"
puts $fid "Pre-release commit done"
puts $fid "*****************************************"
puts $fid ""
close $fid

puts "*****************************************"
puts "Pre-release commit done"
puts "*****************************************"
puts ""

set lineToSkip 3
foreach line $lines {
    if {$lineToSkip == 0} {
        set tokens [split $line ","]
        set sensorName [lindex $tokens 0]
        set substring "#"
        # Dont read line with #
        if {[string first $substring $sensorName] == -1} {
            set fpgaSize [lindex $tokens 1]
            puts "Sensor in list: $sensorName $fpgaSize"
           FirmwareReleaseScript_step2 $sensorName $fpgaSize $FirmwareReleaseLogFile
        }

    } else {
        set lineToSkip [expr $lineToSkip-1]
    }
}

if {$TestMode == "Debug"} {
    DebugPause
}

set releaseMessage "Release $firmwareReleaseVersion"
exec $tortoiseSvnBin commit $projectDir -m \"$releaseMessage\"
exec $tortoiseSvnBin update $projectDir

set fid [open $FirmwareReleaseLogFile a]
puts $fid "*****************************************"
puts $fid "Release commit done"
puts $fid "*****************************************"
puts $fid ""
close $fid

set releaseDate [clock format [clock seconds] -format "%Y-%m-%d"]
puts $releaseDate
set tagPath "/tags/$releaseDate - $releaseMessage"
set svnDir "http://einstein/svn/firmware/"
set tagDone "Done"
if {[catch {exec $tortoiseSvnBin copy D:/Telops/FIR-00251-Common $svnDir/FIR-00251-Common$tagPath -m \"$releaseMessage\"} errMsg]} {
		puts "Error can't create FIR-00251-Common tags (details follow):"
        puts "$errMsg"
        set tagDone "Failed"
}
if {[catch {exec $tortoiseSvnBin copy D:/Telops/FIR-00251-NTx-Mini $svnDir/FIR-00251-NTx-Mini$tagPath -m \"$releaseMessage\"} errMsg]} {
		puts "Error can't create FIR-00251-NTx-Mini tags (details follow):"
        puts "$errMsg"
        set tagDone "Failed"
}
if {[catch {exec $tortoiseSvnBin copy $projectDir $svnDir/FIR-00251-Proc$tagPath -m \"$releaseMessage\"} errMsg]} {
		puts "Error can't create FIR-00251-Proc tags (details follow):"
        puts "$errMsg"
        set tagDone "Failed"
}
if {[catch {exec $tortoiseSvnBin copy D:/Telops/FIR-00251-Output $svnDir/FIR-00251-Output$tagPath -m \"$releaseMessage\"} errMsg]} {
		puts "Error can't create FIR-00251-Output tags (details follow):"
        puts "$errMsg"
        set tagDone "Failed"
}
if {[catch {exec $tortoiseSvnBin copy D:/Telops/FIR-00257-Storage $svnDir/FIR-00257-Storage$tagPath -m \"$releaseMessage\"} errMsg]} {
		puts "Error can't create FIR-00257-Storage tags (details follow):"
        puts "$errMsg"
        set tagDone "Failed"
}

set fid [open $FirmwareReleaseLogFile a]
puts $fid "Release tags $tagDone"
puts $fid "*****************************************"
puts $fid ""
close $fid

set lineToSkip 3
foreach line $lines {
    if {$lineToSkip == 0} {
        set tokens [split $line ","]
        set sensorName [lindex $tokens 0]
        set substring "#"
        # Dont read line with #
        if {[string first $substring $sensorName] == -1} {
            set fpgaSize [lindex $tokens 1]
            puts "Sensor in list: $sensorName $fpgaSize"
            FirmwareReleaseScript_step3 $sensorName $fpgaSize $FirmwareReleaseLogFile
        }

    } else {
        set lineToSkip [expr $lineToSkip-1]
    }
}

set fid [open $FirmwareReleaseLogFile a]
puts $fid "*****************************************"
puts $fid "END Firmware release $firmwareReleaseVersion"
puts $fid "*****************************************"
close $fid
#Open release file
exec {*}[auto_execok start] "" [file nativename [file normalize $FirmwareReleaseLogFile]]
