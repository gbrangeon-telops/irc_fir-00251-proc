proc setEnvironmentVariable {sensorName fpgaSize} {
    upvar 1 baseName baseName
    upvar 1 commonDir commonDir
    upvar 1 projectDir projectDir
    upvar 1 sdkDir sdkDir
    upvar 1 srcDir srcDir
    upvar 1 binDir binDir
    upvar 1 scriptsDir scriptsDir
    upvar 1 outputDir outputDir
    upvar 1 storageDir storageDir
    upvar 1 ntxminiDir ntxminiDir
    upvar 1 elfFile elfFile
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
    upvar 1 objcopy objcopy
    upvar 1 x_xsct x_xsct
    upvar 1 x_promgen x_promgen

    set baseName "fir_00251_proc_$sensorName"
    set commonDir "D:/Telops/FIR-00251-Common"
    set projectDir "D:/Telops/FIR-00251-Proc"
    set sdkDir "$projectDir/sdk/$baseName"
    set srcDir "$projectDir/src"
    set binDir "$projectDir/bin/$baseName"
    set scriptsDir "$projectDir/bin/scripts"
    set outputDir "D:/Telops/FIR-00251-Output"
    set storageDir "D:/Telops/FIR-00257-Storage"
    set ntxminiDir "//STARK/DisqueTELOPS/Production/IRCAM/Firmwares/FIR-00251-NTx-Mini/Archives"
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
