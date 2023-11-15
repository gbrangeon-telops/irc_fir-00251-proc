
#Argument check
if { $argc != 3 } {
	error "The updateVersionFile.tcl script requires three argument <scriptsDir> <fpga_size> <sensor_name>"
} else {
	puts "Update Version file ..."
	set scriptsDir [lindex $argv 0 ]
    set fpga_size [lindex $argv 1 ]
    set sensor_name [lindex $argv 2 ]
}
set commonDir ""
set projectDir ""
set x_xsct ""
set srcDir ""

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


set fsMajorVersion [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if "$srcDir/IRCamFiles/IRCamFiles.h" -f TSFSFILES_VERSION]
set FlashSettingsFile_h "$srcDir/IRCamFiles/FlashSettingsFile_v$fsMajorVersion.h"
set fdvMajorVersion [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if "$srcDir/IRCamFiles/IRCamFiles.h" -f TSDVFILES_VERSION]
set FlashDynamicValuesFile_h "$srcDir/IRCamFiles/FlashDynamicValuesFile_v$fdvMajorVersion.h"
set calMajorVersion [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if "$srcDir/IRCamFiles/IRCamFiles.h" -f CALIBFILES_VERSION]
set CalibCollectionFile_h "$srcDir/IRCamFiles/CalibCollectionFile_v$calMajorVersion.h"
set FirmwareVersionFile "$projectDir/bin/FirmwareReleaseVersion.txt"
set FirmwareVersionFile "$projectDir/bin/FirmwareReleaseVersion.txt"
set versionFile "$projectDir/bin/fir_00251_proc_$sensor_name/version.txt"


set script [open $versionFile w]
puts  -nonewline $script "set firmwareVersionMajor="
set vfirmwareVersionMajor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FirmwareVersionFile -f firmwareVersionMajor]
puts $script "$vfirmwareVersionMajor"
set vfirmwareVersionMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FirmwareVersionFile -f firmwareVersionMinor]
puts -nonewline $script "set firmwareVersionMinor="
puts  $script $vfirmwareVersionMinor
puts $script "set firmwareVersionSubMinor=$sensorCode"
puts -nonewline $script "set firmwareVersionBuild="
set vfirmwareVersionBuild [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FirmwareVersionFile -f firmwareVersionBuild]
puts $script "$vfirmwareVersionBuild"
puts $script "set firmwareVersion=%firmwareVersionMajor%.%firmwareVersionMinor%.%firmwareVersionSubMinor%.%firmwareVersionBuild%"

puts -nonewline $script "set xmlVersionMajor="
set vxmlVersionMajor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $GenICam_h -f GC_XMLMAJORVERSION]
puts $script "$vxmlVersionMajor"
puts -nonewline $script "set xmlVersionMinor="
set vxmlVersionMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $GenICam_h -f GC_XMLMINORVERSION]
puts $script "$vxmlVersionMinor"
puts -nonewline $script "set xmlVersionSubMinor="
set vxmlVersionSubMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $GenICam_h -f GC_XMLSUBMINORVERSION]
puts $script "$vxmlVersionSubMinor"
puts $script "set xmlVersion=%xmlVersionMajor%.%xmlVersionMinor%.%xmlVersionSubMinor%"

puts -nonewline $script "set flashSettingsVersionMajor="
set vflashSettingsVersionMajor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FlashSettingsFile_h -f "FLASHSETTINGS_FILEMAJORVERSION_V$fsMajorVersion"]
puts $script "$vflashSettingsVersionMajor"
puts -nonewline $script "set flashSettingsVersionMinor="
set vflashSettingsVersionMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FlashSettingsFile_h -f "FLASHSETTINGS_FILEMINORVERSION_V$fsMajorVersion"]
puts $script "$vflashSettingsVersionMinor"
puts -nonewline $script "set flashSettingsVersionSubMinor="
set vflashSettingsVersionSubMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FlashSettingsFile_h -f "FLASHSETTINGS_FILESUBMINORVERSION_V$fsMajorVersion"]
puts $script "$vflashSettingsVersionSubMinor"
puts $script "set flashSettingsVersion=%flashSettingsVersionMajor%.%flashSettingsVersionMinor%.%flashSettingsVersionSubMinor%"

puts -nonewline $script "set flashDynamicValuesVersionMajor="
set vflashDynamicValuesVersionMajor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FlashDynamicValuesFile_h -f "FLASHDYNAMICVALUES_FILEMAJORVERSION_V$fdvMajorVersion"]
puts $script "$vflashDynamicValuesVersionMajor"
puts -nonewline $script "set flashDynamicValuesVersionMinor="
set vflashDynamicValuesVersionMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FlashDynamicValuesFile_h -f "FLASHDYNAMICVALUES_FILEMINORVERSION_V$fdvMajorVersion"]
puts $script "$vflashDynamicValuesVersionMinor"
puts -nonewline $script "set flashDynamicValuesVersionSubMinor="
set vflashDynamicValuesVersionSubMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $FlashDynamicValuesFile_h -f "FLASHDYNAMICVALUES_FILESUBMINORVERSION_V$fdvMajorVersion"]
puts $script "$vflashDynamicValuesVersionSubMinor"
puts $script "set flashDynamicValuesVersion=%flashDynamicValuesVersionMajor%.%flashDynamicValuesVersionMinor%.%flashDynamicValuesVersionSubMinor%"

puts -nonewline $script "set calibFilesVersionMajor="
set vcalibFilesVersionMajor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $CalibCollectionFile_h -f "CALIBCOLLECTION_FILEMAJORVERSION_V$calMajorVersion"]
puts $script "$vcalibFilesVersionMajor"
puts -nonewline $script "set calibFilesVersionMinor="
set vcalibFilesVersionMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $CalibCollectionFile_h -f "CALIBCOLLECTION_FILEMINORVERSION_V$calMajorVersion"]
puts $script "$vcalibFilesVersionMinor"
puts -nonewline  $script "set calibFilesVersionSubMinor="
set vcalibFilesVersionSubMinor [exec $x_xsct "$scriptsDir/fetchNumericValue.tcl" -if $CalibCollectionFile_h -f "CALIBCOLLECTION_FILESUBMINORVERSION_V$calMajorVersion"]
puts $script "$vcalibFilesVersionSubMinor"
puts $script "set calibFilesVersion=%calibFilesVersionMajor%.%calibFilesVersionMinor%.%calibFilesVersionSubMinor%"

#set newVersionFile [string map {.txt .bat} $versionFile]
close $script
set newVersionFile "$projectDir/bin/fir_00251_proc_$sensor_name/version.bat"
file copy -force $versionFile $newVersionFile
after 1000
exec $newVersionFile
file delete $newVersionFile

puts "done"