proc create_proc_sw {detector} {
set current_path [exec pwd]

#Switch directory
cd "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}"

#Set workspace
setws -switch "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/"

#Create HW projects
createhw -name hw_platform_160 -hwspec fir_00251_proc_${detector}_160.hdf
createhw -name hw_platform_325 -hwspec fir_00251_proc_${detector}_325.hdf

#Create BSP projects
createbsp -name standalone_bsp_160 -hwproject hw_platform_160 -proc MCU_microblaze_1
createbsp -name standalone_bsp_325 -hwproject hw_platform_325 -proc MCU_microblaze_1

#Import projects
importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_boot_160"
importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_160"
importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_boot_325"
importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_325"

#Clean projects
projects -clean

#Configure in release mode
configapp -app fir_00251_proc_${detector}_boot_160 build-config release
configapp -app fir_00251_proc_${detector}_160 build-config release
configapp -app fir_00251_proc_${detector}_boot_325 build-config release
configapp -app fir_00251_proc_${detector}_325 build-config release

#Return to initial path
cd $current_path
}

# Supported compile_arg: "boot_only", "main_only" and "both"
proc build_proc_sw {detector size {compile_arg "both"}} {
set current_path [exec pwd]
#Switch directory
cd "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}"

#Set workspace
setws -switch "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/"

#Configure in release mode and clean projects
if {$compile_arg == "both" || $compile_arg == "boot_only"} {
   configapp -app fir_00251_proc_${detector}_boot_$size build-config release
   projects -clean -type app -name fir_00251_proc_${detector}_boot_$size
   file delete -force fir_00251_proc_${detector}_boot_$size/Release/
}
if {$compile_arg == "both" || $compile_arg == "main_only"} {
   configapp -app fir_00251_proc_${detector}_$size build-config release
   projects -clean -type app -name fir_00251_proc_${detector}_$size
   file delete -force fir_00251_proc_${detector}_$size/Release/
}

#Build standalone_bsp
projects -build -type bsp -name standalone_bsp_$size

#Build projects
if {$compile_arg == "both" || $compile_arg == "boot_only"} {
   projects -build -type app -name fir_00251_proc_${detector}_boot_$size
}
if {$compile_arg == "both" || $compile_arg == "main_only"} {
   projects -build -type app -name fir_00251_proc_${detector}_$size
}

#Return to initial path
cd $current_path
}
