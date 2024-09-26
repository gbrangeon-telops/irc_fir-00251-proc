#Import build fonction

set current_file_location_absolute_path [file normalize [file dirname [info script]]]
set parts [file split $current_file_location_absolute_path]
set root_location_absolute_path [file join {*}[lrange $parts 0 end-2]]

puts "root_location_absolute_path:$root_location_absolute_path"
#set project info from the root location
set commonHDLDir "$root_location_absolute_path/irc_common_hdl"
set commonDir "$root_location_absolute_path/irc_fir-00251-common"
set outputDir "$root_location_absolute_path/irc_fir-00251-output"
set projectDir "$root_location_absolute_path/irc_fir-00251-proc"
set sdkDir "$projectDir/sdk"
set srcDir "$projectDir/src"
set binDir "$projectDir/bin"
set scriptsDir "$projectDir/bin/scripts"

puts "commonHDLDir:$commonHDLDir"
puts "commonDir:$commonDir"
puts "outputDir:$outputDir"
puts "projectDir:$projectDir"
puts "sdkDir:$sdkDir"


#git tools

proc is_git_file_modified {filepath} {
	set is_file [file isfile $filepath]
	if {$is_file == 1} {
		set directory [file dirname $filepath]
	} else {
		set directory $filepath
	}
	#switch dir to be able to execute the git command correctly when folder is outside current repo
	set current_dir [pwd]
	cd $directory
	set status [catch {exec git diff $filepath } result]
	if {$result == ""} {
	   set returnValue 0	   
	} else {
	   set returnValue 1
	}
	cd $current_dir
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
	set revision [git_last_modification_commit_hash $filepath]
	if {$git_diff_status == 0 || $trace_modified==0} {
	   set hash "$revision"
	} else {
	   set hash "*$revision"
	}
    puts "the hash value is $hash"

	return $hash
}
