#get root directory relative to this file
set current_file_location_absolute_path [file normalize [file dirname [info script]]]
set parts [file split $current_file_location_absolute_path]
set root_location_absolute_path [file join {*}[lrange $parts 0 end-3]]

set commonDir "$root_location_absolute_path/irc_fir-00251-common"
set projectDir "$root_location_absolute_path/irc_fir-00251-proc"
set srcDir "$projectDir/src"
set scriptsDir "$projectDir/bin/scripts"
set outputDir "$root_location_absolute_path/irc_fir-00251-output"
set storageDir "$root_location_absolute_path/ircam_fir-00257-storage_temp"
set ntxminiDir "//STARK/DisqueTELOPS/Production/IRCAM/Firmwares/FIR-00251-NTx-Mini/Archives"

proc setEnvironmentVariable {sensorName fpgaSize} {
    upvar 1 baseName baseName
    upvar 1 elfFile elfFile
    upvar 1 bootFile bootFile
    upvar 1 hwFile hwFile
    upvar 1 buildInfoFile buildInfoFile
    upvar 1 releaseFile releaseFile
    upvar 1 releaseLogFile releaseLogFile
    upvar 1 revFile revFile
    upvar 1 outputFpgaSize outputFpgaSize
    upvar 1 outputRevFile outputRevFile
    upvar 1 outputBaseName outputBaseName
    upvar 1 outputBuildInfoFile outputBuildInfoFile
    upvar 1 storageRevFile1 storageRevFile1
    upvar 1 storageRevFile2 storageRevFile2 
    upvar 1 storageBuildInfoFile storageBuildInfoFile
    upvar 1 versionFile versionFile
    upvar 1 sensorInfoFile sensorInfoFile
    upvar 1 zip zip
    upvar 1 tortoiseSVNDir tortoiseSVNDir
    upvar 1 svn_subwcrev svn_subwcrev
    upvar 1 xDir xDir
    upvar 1 x_mb-objcopy x_mb-objcopy
    upvar 1 x_xsct x_xsct
    upvar 1 x_promgen x_promgen
    upvar 1  sensorCode sensorCode
    upvar 1  sensorWidth sensorWidth
    upvar 1  sensorHeight sensorHeight

    set baseName "fir_00251_proc_$sensorName"
    set binDir "$projectDir/bin/$baseName"
	set sdkDir "$projectDir/sdk/$baseName"
    set elfFile "$binDir/${baseName}_$fpgaSize.elf"
    set bootFile "$sdkDir/${baseName}_boot_$fpgaSize/Release/${baseName}_boot_$fpgaSize.elf"
    set hwFile "$sdkDir/${baseName}_$fpgaSize.hdf"
    set buildInfoFile "$srcDir/BuildInfo/$sensorName/BuildInfo.h"
    set releaseFile "$binDir/${baseName}_${fpgaSize}_release.bin"
    set releaseLogFile "$binDir/${baseName}_${fpgaSize}_release.txt"
    set revFile "$binDir/svnrevs_$fpgaSize.tcl"

    if {$fpgaSize == "160"} {
        set outputFpgaSize 70
    } else {
        set outputFpgaSize 160
    }
    set outputRevFile "$outputDir/bin/svnrevs_$outputFpgaSize.tcl"
    set outputBaseName "fir_00251_output_$outputFpgaSize"
    set outputBuildInfoFile "$outputDir/src/BuildInfo/BuildInfo.h"
    set storageRevFile1 "$storageDir/bin/svnrevs_16.tcl"
    set storageRevFile2 "$storageDir/bin/svnrevs_32.tcl"
    set storageBuildInfoFile "$storageDir/src/BuildInfo/BuildInfo.h"
    set versionFile "$binDir/version.txt"
    set sensorInfoFile "$projectDir/bin/SensorInformation.txt"
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

        if {$sensorNameToken eq $sensorName} {
            set sensorCode $sensorCodeToken
            set sensorWidth $sensorWidthToken
            set sensorHeight $sensorHeightToken
            break
        }
    }
    close $inputFile
    set zip "C:/Program Files/7-Zip/7z.exe"
    set tortoiseSVNDir "C:/Program Files/TortoiseSVN"
    set svn_subwcrev "$tortoiseSVNDir/bin/SubWCRev.exe"
    set xDir "C:/Xilinx"
    if {[file exists "D:/Xilinx/SDK/2018.3/*.*"]} {
        set xDir "D:/Xilinx"
    }
    puts "Xilinx directory: $xDir"
    set x_mb-objcopy "$xDir/SDK/2018.3/gnu/microblaze/nt/bin/mb-objcopy.exe"
    set x_xsct "$xDir/SDK/2018.3/bin/xsct.bat"
    set xDir "C:/Xilinx"
    if {[file exists "D:/Xilinx/14.7/*.*"]} {
        set xDir "D:/Xilinx"
    }
    puts "Xilinx directory: $xDir"
    set x_promgen "$xDir/14.7/LabTools/LabTools/bin/nt64/promgen.exe"
}



#git tools

proc is_git_file_modified {filepath} {
	set status [catch {exec git diff $filepath } result]
	if {$result == ""} {
	   set returnValue 0	   
	} else {
	   set returnValue 1
	}
	return $returnValue
}

proc git_last_modification_commit_hash {filepath} {
	set is_file [file isfile $filepath]
	if {$is_file == 1} {
		set directory [file dirname $filepath]
	} else {
		set directory $filepath
	}
	#switch dir to be able to execute the git command correctly when folder is outside current repo
	set current_dir [pwd]
	cd $directory
	set status [catch {exec  git log -n 1 --pretty=format:%h -- $filepath } result]
	cd $current_dir

	return $result
}

proc git_get_rev {filepath trace_modified} {
	set git_diff_status [is_git_file_modified $filepath]
	if {$git_diff_status == 0 || $trace_modified==0} {
	   set hash [git_last_modification_commit_hash $filepath]
	} else {
	   set hash "modified"
	}
    puts "the hash value is $hash"

	return $hash
}

proc git_tag {path tag message} {
	set current_dir [pwd]
	cd $directory
	set status [catch {exec  git tag $tag -m $message } result]
	cd $current_dir
	
	
}