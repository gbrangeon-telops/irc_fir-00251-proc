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
