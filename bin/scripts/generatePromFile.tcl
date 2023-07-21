proc generatePromFile {fpga_size sensor_name} {
    set binDir ""
    set elfFile ""
    set sdkDir ""
    set baseName ""
    set releaseFile ""
    #from input bring the same issue, it must be the absolute path
    set script_dir "D:/Telops/FIR-00251-Proc/bin/scripts"
    source "${script_dir}/setEnvironment.tcl" 
    setEnvironmentVariable $sensor_name $fpga_size
    set mb_objcopy_file [file join "${xDir}/SDK/2018.3/gnu/microblaze/nt/" bin mb-objcopy.exe]  

    #CLean up
    file delete -force "${binDir}/tempS0_${fpga_size}.srec"
    file delete -force "${binDir}/tempS3_${fpga_size}.srec"
    file delete -force "${binDir}/_promgen_${fpga_size}.srec"

    #fetch hw and sw files
    file delete -force "${elfFile}"
    if {[ catch {[file copy "${sdkDir}/${baseName}_${fpga_size}/Release/${baseName}_${fpga_size}.elf" ${elfFile}]} err]} {

        puts $err
    } else {
        set bit_file "${sdkDir}/${baseName}_${fpga_size}.bit"
   
        #Generate SREC image file
        if {[ catch {[exec $mb_objcopy_file -O srec --srec-forceS3 --srec-len=16 $elfFile "${binDir}/tempS3_${fpga_size}.srec"]} err]} {
            puts $err
        }

        source "${script_dir}/setRecordS0.tcl"
        generate_tempS0 ${binDir}/tempS3_${fpga_size}.srec ${baseName} ${binDir}/tempS0_${fpga_size}.srec

        #Generate PROM file
        #Here the size is in M Bytes (was K Bytes)
        if { $fpga_size == "160"} {
            write_cfgmem -format mcs -checksum FF -size 16 -interface SPIx4 -loadbit "up 0x00000000 ${bit_file}" -loaddata "up 0x00670000 ${releaseFile} up 0x00680000 ${binDir}/tempS0_${fpga_size}.srec" -force -file "${binDir}/prom/${baseName}_${fpga_size}.mcs"

        } else {
            write_cfgmem -format mcs -checksum FF -size 16 -interface SPIx4 -loadbit "up 0x00000000 ${bit_file}" -loaddata "up 0x00AF0000 ${releaseFile} up 0x00B00000 ${binDir}/tempS0_${fpga_size}.srec" -force -file "${binDir}/prom/${baseName}_${fpga_size}.mcs"

        }
        #Clean up
        file delete -force {*}[glob *.backup.log] 
        file delete -force {*}[glob *.backup.jou] 


    } 

}
