# Procédure pour analyser le fichier HW Rev
proc parseHWRevFile {sensorName fpgaSize sdkDir} {
    set hwRevFile [format "%s/fir_00251_proc_%s_%s_hw_svn_rev.txt" $sdkDir $sensorName $fpgaSize]
    set encrypt_key_name ""
    set temp_encrypt_key_name ""

    set file [open $hwRevFile r]
    set content [read $file]
    close $file

    if {[regexp {encryption key\s*:\s*(\S+)} $content - temp_encrypt_key_name]} {
        # Remove spaces
        set encrypt_key_name [string map {" " ""} $temp_encrypt_key_name]
    }

    return $encrypt_key_name
}

proc parseVersionFile {versionFile} {
    # Parse proc release info file
    set versionFileStr [read_file $versionFile]
    upvar 1 firmwareVersion firmwareVersion
    upvar 1 xmlVersion xmlVersion
    upvar 1 flashSettingsVersion flashSettingsVersion
    upvar 1 flashDynamicValuesVersion flashDynamicValuesVersion
    upvar 1 calibFilesVersion srcDcalibFilesVersionir
    
    
    set firmwareVersionMajor ""
    if {[regexp {firmwareVersionMajor[^\n\r0-9]+(\d+)} $versionFileStr match firmwareVersionMajor]} {
        set firmwareVersionMajor $firmwareVersionMajor
    } else {
        error "Missing firmwareVersionMajor"
    }
    set firmwareVersionMinor ""
    if {[regexp {firmwareVersionMinor[^\n\r0-9]+(\d+)} $versionFileStr match firmwareVersionMinor]} {
        set firmwareVersionMinor $firmwareVersionMinor
    } else {
        error "Missing firmwareVersionMinor"
    }
    set firmwareVersionSubMinor ""
    if {[regexp {firmwareVersionSubMinor[^\n\r0-9]+(\d+)} $versionFileStr match firmwareVersionSubMinor]} {
        set firmwareVersionSubMinor $firmwareVersionSubMinor
    } else {
        error "Missing firmwareVersionSubMinor"
    }
    set firmwareVersionBuild ""
    if {[regexp {firmwareVersionBuild[^\n\r0-9]+(\d+)} $versionFileStr match firmwareVersionBuild]} {
        set firmwareVersionBuild $firmwareVersionBuild
    } else {
        error "Missing firmwareVersionBuild"
    }
    set firmwareVersion "$firmwareVersionMajor.$firmwareVersionMinor.$firmwareVersionSubMinor.$firmwareVersionBuild"

    set xmlVersionMajor ""
    if {[regexp {xmlVersionMajor[^\n\r0-9]+(\d+)} $versionFileStr match xmlVersionMajor]} {
        set xmlVersionMajor $xmlVersionMajor
    } else {
        error "Missing xmlVersionMajor"
    }
    set xmlVersionMinor ""
    if {[regexp {xmlVersionMinor[^\n\r0-9]+(\d+)} $versionFileStr match xmlVersionMinor]} {
        set xmlVersionMinor $xmlVersionMinor
    } else {
        error "Missing xmlVersionMinor"
    }
    set xmlVersionSubMinor ""
    if {[regexp {xmlVersionSubMinor[^\n\r0-9]+(\d+)} $versionFileStr match xmlVersionSubMinor]} {
        set xmlVersionSubMinor $xmlVersionSubMinor
    } else {
        error "Missing xmlVersionSubMinor"
    }
    set xmlVersion "$xmlVersionMajor.$xmlVersionMinor.$xmlVersionSubMinor"

    set flashSettingsVersionMajor ""
    if {[regexp {flashSettingsVersionMajor[^\n\r0-9]+(\d+)} $versionFileStr match flashSettingsVersionMajor]} {
        set flashSettingsVersionMajor $flashSettingsVersionMajor
    } else {
        error "Missing flashSettingsVersionMajor"
    }
    set flashSettingsVersionMinor ""
    if {[regexp {flashSettingsVersionMinor[^\n\r0-9]+(\d+)} $versionFileStr match flashSettingsVersionMinor]} {
        set flashSettingsVersionMinor $flashSettingsVersionMinor
    } else {
        error "Missing flashSettingsVersionMinor"
    }
    set flashSettingsVersionSubMinor ""
    if {[regexp {flashSettingsVersionSubMinor[^\n\r0-9]+(\d+)} $versionFileStr match flashSettingsVersionSubMinor]} {
        set flashSettingsVersionSubMinor $flashSettingsVersionSubMinor
    } else {
        error "Missing flashSettingsVersionSubMinor"
    }
    set flashSettingsVersion " $flashSettingsVersionMajor.$flashSettingsVersionMinor.$flashSettingsVersionSubMinor"

    set flashDynamicValuesVersionMajor ""
    if {[regexp {flashDynamicValuesVersionMajor[^\n\r0-9]+(\d+)} $versionFileStr match flashDynamicValuesVersionMajor]} {
        set flashDynamicValuesVersionMajor $flashDynamicValuesVersionMajor
    } else {
        error "Missing flashDynamicValuesVersionMajor"
    }
    set flashDynamicValuesVersionMinor ""
    if {[regexp {flashDynamicValuesVersionMinor[^\n\r0-9]+(\d+)} $versionFileStr match flashDynamicValuesVersionMinor]} {
        set flashDynamicValuesVersionMinor $flashDynamicValuesVersionMinor
    } else {
        error "Missing flashDynamicValuesVersionMinor"
    }
    set flashDynamicValuesVersionSubMinor ""
    if {[regexp {flashDynamicValuesVersionSubMinor[^\n\r0-9]+(\d+)} $versionFileStr match flashDynamicValuesVersionSubMinor]} {
        set flashDynamicValuesVersionSubMinor $flashDynamicValuesVersionSubMinor
    } else {
        error "Missing flashDynamicValuesVersionSubMinor"
    }
    set flashDynamicValuesVersion "$flashDynamicValuesVersionMajor.$flashDynamicValuesVersionMinor.$flashDynamicValuesVersionSubMinor"

    set calibFilesVersionMajor ""
    if {[regexp {calibFilesVersionMajor[^\n\r0-9]+(\d+)} $versionFileStr match calibFilesVersionMajor]} {
        set calibFilesVersionMajor $calibFilesVersionMajor
    } else {
        error "Missing calibFilesVersionMajor"
    }
    set calibFilesVersionMinor ""
    if {[regexp {calibFilesVersionMinor[^\n\r0-9]+(\d+)} $versionFileStr match calibFilesVersionMinor]} {
        set calibFilesVersionMinor $calibFilesVersionMinor
    } else {
        error "Missing calibFilesVersionMinor"
    }
    set calibFilesVersionSubMinor ""
    if {[regexp {calibFilesVersionSubMinor[^\n\r0-9]+(\d+)} $versionFileStr match calibFilesVersionSubMinor]} {
        set calibFilesVersionSubMinor $calibFilesVersionSubMinor
    } else {
        error "Missing calibFilesVersionSubMinor"
    }
    set calibFilesVersion "$calibFilesVersionMajor.$calibFilesVersionMinor.$calibFilesVersionSubMinor"
        
    puts "firmware Revision: $firmwareVersion"
    puts "xml Revision: $xmlVersion"
    puts "FS Revision: $flashSettingsVersion"
    puts "FDV Revision: $flashDynamicValuesVersion"
    puts "Calibration Revision: $calibFilesVersion"

}

proc getEncryptationStatus {mcsDir} {
    #generate CLI file using mcs
    set mcsFile [open ${mcsDir} r]
    set registerIsAfter 0
    while {[gets $mcsFile line] != -1} {
        if {$registerIsAfter == 0} {
            if {[string match "*3000A001*" $line]} {
                set index [string first "3000A001" $line]
                #get the 8 bits after 3000A001
                set variable [string range $line [expr {$index + 8}] [expr {$index + 15}]]
                #case register is in the other line
                if {[string length $variable] != 8} {
                    #puts "Register est dans lautre ligne"
                    set registerIsAfter 1
                } else {
                    #variable is correctly set 
                    #puts "Register est dans la meme ligne"
                    break
                }
            }
        } else {
            set variable [string range $line [expr {9}] [expr {16}]]
            break
        }

    }

    #puts "Les 32 bits apres'3000A001' sont : $variable"
    binary scan [binary format H* $variable] B* bits
    set sixthBit [expr {($bits & 0b01000000) >> 6}]
    #puts "Le 6eme bit de $variable est $sixthBit"
    if {$sixthBit == 1} {
        close $mcsFile
        return "ENCRYPTED"
    } else {
        close $mcsFile
        return "NONE"
    } 
        
    close $mcsFile
}

proc generatePaperwork {scriptsDir sensor fpgaSize encrypt_key_name template_dir} {

    set outputRevFile ""
    set storageRevFile1 ""
    set storageRevFile2 ""
    set revFile ""
    set xmlVersion ""
    set firmwareVersion ""
    set flashSettingsVersion ""
    set flashDynamicValuesVersion ""
    set calibFilesVersion ""
    # Set environment variables
    source "$scriptsDir/setEnvironment.tcl"
    setEnvironmentVariable $sensor $fpgaSize
    parseVersionFile $versionFile

    set xmlver $xmlVersion
    set flashSettingsver $flashSettingsVersion
    set flashdynamicvaluesver $flashDynamicValuesVersion
    set version $firmwareVersion
    set calibver $calibFilesVersion
    set proc_versions $revFile
    set output_versions $outputRevFile
    set storage_versions1 $storageRevFile1
    set storage_versions2 $storageRevFile2

    set sharedStringsFile "$template_dir/xl/sharedStrings.xml"
    puts "proc_versions = $proc_versions"
    puts "output_versions = $output_versions"
    puts "storage_versions1 = $storage_versions1"
    puts "storage_versions2 = $storage_versions2"
    puts "template_dir = $template_dir"
    puts "sharedStringsFile = $sharedStringsFile"
    puts "sensor = $sensor"
    puts "xmlver = $xmlver"
    puts "version = $version"

    #require
    source $proc_versions 
    source $output_versions
    source $storage_versions1 
    source $storage_versions2 

    set fh [open $sharedStringsFile w]
    set date [clock format [clock seconds] -format %Y-%m-%d]
    puts $fh "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
    puts $fh "<sst xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\" count=\"30\" uniqueCount=\"27\">"
    puts $fh "<si><t>FPGA</t></si>"
    puts $fh "<si><t>Board</t></si>"
    puts $fh "<si><t>Component</t></si>"
    puts $fh "<si><t>Version #</t></si>"
    puts $fh "<si><t>Date</t></si>"
    puts $fh "<si><t>Release number</t></si>"
    puts $fh "<si><t>Assembly</t></si>"
    puts $fh "<si><t>SN</t></si>"
    puts $fh "<si><t>Fait Par</t></si>"
    puts $fh "<si><t>Détecteur</t></si>"
    if {$fpgaSize == "325"} {
        puts $fh "<si><t>EFA-00251-x03</t></si>"
    } else {
        puts $fh "<si><t>EFA-00251-x01</t></si>"
    }
    puts $fh "<si><t>Acquisition Board</t></si>"
    puts $fh "<si><t>NTx-Mini</t></si>"
    if {$fpgaSize == "325"} {
        puts $fh "<si><t>FPGA Processing (xc7k325t)</t></si>"
        puts $fh "<si><t>FPGA Output (xc7k160t)</t></si>"
    } else {
        puts $fh "<si><t>FPGA Processing (xc7k160t)</t></si>"
        puts $fh "<si><t>FPGA Output (xc7k70t)</t></si>"
    }
    puts $fh "<si><t>XML $xmlver</t></si>"
    puts $fh "<si><t>H: $rel_out_hw_rev, S: $rel_out_sw_rev, B: $rel_out_boot_rev, C: $rel_out_common_rev</t></si>"
    puts $fh "<si><t>$version</t></si>"
    puts $fh "<si><t>$sensor</t></si>"
    puts $fh "<si><t>$date</t></si>"
    puts $fh "<si><t>Storage Board</t></si>"
    puts $fh "<si><t>EFA-00257-001</t></si>"
    puts $fh "<si><t>FPGA Storage (xc7k160t)</t></si>"
    puts $fh "<si><t>H1: $rel_storage_hw_rev1, S1: $rel_storage_sw_rev1, B1: $rel_storage_boot_rev1, C1: $rel_storage_common_rev1, H2: $rel_storage_hw_rev2, S2: $rel_storage_sw_rev2, B2: $rel_storage_boot_rev2, C2: $rel_storage_common_rev2</t></si>"
    puts $fh "<si><t>H: $rel_proc_hw_rev, S: $rel_proc_sw_rev, B: $rel_proc_boot_rev, C: $rel_proc_common_rev, FS: $flashSettingsver, FDV: $flashdynamicvaluesver, CAL: $calibver</t></si>"
    puts $fh "<si><t>Encryption key</t></si>"
    puts $fh "<si><t>$encrypt_key_name</t></si></sst>"
    close $fh
}

# Procédure pour convertir le script batch en procédure Tcl
proc convertScript {sensorName fpgaSize scriptsDir} {
    set releaseDir ""
    set sdkDir ""
    set binDir ""
    set versionFile ""
    set baseName ""
    set outputBaseName ""
    set outputRevFile ""
    set storageRevFile1 ""
    set storageRevFile2 ""
    set xmlVersion ""
    set firmwareVersion ""
    set flashSettingsVersion ""
    set flashDynamicValuesVersion ""
    set calibFilesVersion ""
    # Set environment variables
    source "$scriptsDir/setEnvironment.tcl"
    setEnvironmentVariable $sensorName $fpgaSize
    parseVersionFile $versionFile

    set paperworkTemplateDir "$scriptsDir/paperwork_$fpgaSize/template"
    set jtagPromBridgeDir "//STARK/DisqueTELOPS/Production/IRCAM/Tools/PROM-JTAG Bridge"
    set ntxminiFileBaseName "CommonTEL2000LibProject_xml_$xmlVersion"
    set ntxminiFile "${ntxminiFileBaseName}_${sensorWidth}x$sensorHeight.bat"
    set cfiFile "$binDir/prom/${baseName}_$fpgaSize.cfi"

    # Parse HW Rev file
    set encrypt_key_name [parseHWRevFile $sensorName $fpgaSize $sdkDir]

    if {$sensorName eq "startup"} {
        set releaseDir [format "%s/Release_%s (%s_%s, %s key)" $binDir [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion] $sensorName $fpgaSize $encrypt_key_name]
    } elseif {$sensorName eq "startup_4DDR"} {
        set releaseDir [format "%s/Release_%s (%s_%s, %s key)" $binDir [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion] $sensorName $fpgaSize $encrypt_key_name]
    } else {
        set releaseDir [format "%s/Release_%s (%s, %s key)" $binDir [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion] $sensorName $encrypt_key_name]
    }

    set fubatch [format "$releaseDir/Release_%s.bat" [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion]]
    set fubatchJtag [format "$releaseDir/Release_%s_jtag.bat" [string map {"." "_" $sensorName $fpgaSize} $firmwareVersion]]

    # Clean up
    catch {file delete -force [glob "$paperworkTemplateDir.zip"]}

    # Check that the Release file is not is the list returned by "glob"
    if {[catch {glob -directory -type d [format "%s/Release_" $binDir]}]} {
        puts "No release file present"
    } else {
        foreach dir [glob -directory -type d [format "%s/Release_" $binDir]] {
            catch {file delete -force $dir}
        }
    }


    # Verify encryption consistency
    set encrypt_key_status "NONE"
    set encrypt_key_status [getEncryptationStatus "$binDir/Prom/fir_00251_proc_${sensorName}_$fpgaSize.mcs"]

    if {[string trim $encrypt_key_status] ne "NONE"} {
            puts "Bitstream encrypted"
        } else {
            puts "Bitstream unencrypted"
    }
    # Prepare firmware package
    file mkdir $releaseDir/FIR-00251-Proc/
    foreach f [glob -directory "$binDir/prom/" fir_00251_proc_${sensorName}_$fpgaSize.*] {
        file copy -force $f "$releaseDir/FIR-00251-Proc/"
    }

    file copy -force $jtagPromBridgeDir/scripts/jtag_prom_prog.bat $releaseDir/FIR-00251-Proc/
    if {[catch {file mkdir "$releaseDir/FIR-00251-Output/"}]} {
        error "Can't create FIR-00251-Output directory"
    }
   # file copy $outputDir/bin/prom/${outputBaseName}.* $releaseDir/FIR-00251-Output/
    foreach f [glob -directory "$outputDir/bin/prom" ${outputBaseName}.*] {
        file copy -force $f "$releaseDir/FIR-00251-Output/"
    }
    file copy $jtagPromBridgeDir/scripts/jtag_prom_prog.bat $releaseDir/FIR-00251-Output/
    if {[catch {file mkdir "$releaseDir/FIR-00257-Storage/"}]} {
        error "Can't create FIR-00257-Storage directory"
    }
    #file copy -force $storageDir/bin/prom/*.* "$releaseDir/FIR-00257-Storage/"
    foreach f [glob -directory "$storageDir/bin/prom" *.* ] {
        file copy -force $f "$releaseDir/FIR-00257-Storage/"
    }
    file copy "$jtagPromBridgeDir/scripts/jtag_prom_prog.bat" "$releaseDir/FIR-00257-Storage/"

    file mkdir $releaseDir/FIR-00251-NTx-Mini/
    file mkdir $releaseDir/FIR-00251-NTx-Mini/$ntxminiFileBaseName
    #file copy $ntxminiDir/$ntxminiFileBaseName/${ntxminiFileBaseName}_${sensorWidth}x${sensorHeight}_*.exe $releaseDir/FIR-00251-NTx-Mini/$ntxminiFileBaseName
    foreach f [glob -directory "$ntxminiDir/$ntxminiFileBaseName" ${ntxminiFileBaseName}_${sensorWidth}x${sensorHeight}_*.exe ] {
        file copy -force $f "$releaseDir/FIR-00251-NTx-Mini/$ntxminiFileBaseName"
    }
    if {[catch {file copy -force "$ntxminiDir/$ntxminiFile" "$releaseDir/FIR-00251-NTx-Mini"}]} {
        error "Can't copy FIR-00251-NTx-Mini directory"
    }
    #todo make a procedure
    puts "Generate paperwork"
    #set cmd "$x_xsct $scriptsDir/paperwork_$fpgaSize/generatePaperwork.tcl -sensor $sensorName -key $encrypt_key_name -v $firmwareVersion -o $outputRevFile -storage_revs1 $storageRevFile1 -storage_revs2 $storageRevFile2 -p $revFile -x $xmlVersion -fs $flashSettingsVersion -fdv $flashDynamicValuesVersion -cal $calibFilesVersion -t $paperworkTemplateDir 
    #exec cmd
    generatePaperwork $scriptsDir $sensorName $fpgaSize $encrypt_key_name $paperworkTemplateDir
    puts "Generate paperwork done"
    exec sleep 1
    exec $zip a -r -tzip $paperworkTemplateDir.zip $paperworkTemplateDir/*.*

    file rename "$paperworkTemplateDir.zip" $releaseDir/Release_[string map {. _} $firmwareVersion].xlsx
    exec cscript.exe "$scriptsDir/xlsx2pdf.js" $releaseDir/Release_[string map {. _} $firmwareVersion].xlsx

    # Generate firmware updater batch file
    set file [open $fubatch w]
    puts $file "@echo off\n"
    puts $file "echo.\n"
    puts $file "set fu_exe=tsirfu.exe\n"
    puts $file "echo.\n"
    puts $file "where %fu_exe%\n"
    puts $file "if %errorlevel% == 0 goto start_fu\n"
    puts $file "echo.\n"
    puts $file "set fu_retry=0\n"
    puts $file ":findfu\n"
    puts $file "if not exist %fu_exe% (\n"
    puts $file " if %fu_retry% == 2 (\n"
    puts $file " echo Error: Cannot find firmware updater.\n"
    puts $file " pause\n"
    puts $file " goto end\n"
    puts $file " )\n"
    puts $file " set fu_exe=..\\%fu_exe%\n"
    puts $file " set /a fu_retry+=1\n"
    puts $file " goto findfu\n"
    puts $file ")\n"
    puts $file ":start_fu\n"
    puts $file "cd FIR-00251-NTx-Mini\n"
    puts $file "call $ntxminiFile\n"
    puts $file "if not %errorlevel% == 0 goto err\n"
    puts $file "cd ..\n"
    puts $file "%fu_exe% -p p FIR-00251-Proc\\fir_00251_proc_${sensorName}_$fpgaSize.mcs\n"
    puts $file "%fu_exe% -p o FIR-00251-Output\\$outputBaseName.mcs\n"
    puts $file "%fu_exe% -p s FIR-00257-Storage\\fir_00257_storage.mcs\n"
    puts $file ""
    puts $file "pause"
    puts $file ""
    puts $file ":end"
    puts $file "exit"
    puts $file ""
    puts $file ":err"
    puts $file "echo \"NTx-Mini update failed!\""
    puts $file "pause"

    close $file

    set file [open $fubatchJtag "w"]
    puts $file "@echo off"
    puts $file ""
    puts $file ":start_fu"
    puts $file ""
    puts $file "cd FIR-00251-Proc"
    puts $file "call jtag_prom_prog.bat"
    puts $file "cd ..\\FIR-00251-Output"
    puts $file "call jtag_prom_prog.bat"
    puts $file "cd ..\\FIR-00257-Storage"
    puts $file "call jtag_prom_prog.bat"
    puts $file "cd .."
    puts $file ""
    puts $file "cd FIR-00251-NTx-Mini"
    puts $file "call $ntxminiFile"
    puts $file "if not %errorlevel% == 0 goto err"
    puts $file "cd .."
    puts $file ""
    puts $file ":end"
    puts $file "exit"
    puts $file ""
    puts $file ":err"
    puts $file "echo \"NTx-Mini update failed!\""
    puts $file "pause"

    close $file

    puts  $releaseDir
    return $releaseDir
}