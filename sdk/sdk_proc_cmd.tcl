# Supported size_arg: "160", "325" and "both"
proc create_proc_sw {detector {size_arg "both"}} {
set current_path [exec pwd]

#Switch directory
cd "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}"

#Set workspace
setws -switch "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/"

if {$size_arg == "both" || $size_arg == "160"} {
   #Create HW projects, In the case already exist, update HW 
   if {[catch {createhw -name hw_platform_160 -hwspec "fir_00251_proc_${detector}_160.hdf"} errMsg]} {
		updatehw -hw hw_platform_160 -newhwspec "fir_00251_proc_${detector}_160.hdf"
	}
   after 1000

   #Create BSP projects, if already exist do nothing
   if {[catch {createbsp -name standalone_bsp_160 -hwproject hw_platform_160 -proc MCU_microblaze_1} errMsg]} {
			puts ""
	}	
   after 1000

   #Import projects
   importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_boot_160"
   importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_160"
   
   #Delay to avoid "Configuration with name release is not defined" error
   after 6000

   #Configure in release mode
   if {[catch {configapp -app fir_00251_proc_${detector}_boot_160 build-config release} errMsg]} {
      puts "Warning: Could not set release configuration."
   }
   after 1000
   if {[catch {configapp -app fir_00251_proc_${detector}_160 build-config release} errMsg]} {
      puts "Warning: Could not set release configuration."
   }
}
if {$size_arg == "both" || $size_arg == "325"} {
   #Create HW projects, In the case already exist, update HW 
   if {[catch { createhw -name hw_platform_325 -hwspec "fir_00251_proc_${detector}_325.hdf"} errMsg]} {
		updatehw -hw hw_platform_325 -newhwspec "fir_00251_proc_${detector}_325.hdf"
	}
   after 1000
  
    #Create BSP projects, if already exist do nothing
   if {[catch {createbsp -name standalone_bsp_325 -hwproject hw_platform_325 -proc MCU_microblaze_1} errMsg]} {
			puts ""
	}	
   after 1000

   #Import projects
   importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_boot_325"
   importprojects "d:/Telops/fir-00251-Proc/sdk/fir_00251_proc_${detector}/fir_00251_proc_${detector}_325"
   
   #Delay to avoid "Configuration with name release is not defined" error
   after 6000

   #Configure in release mode
   if {[catch {configapp -app fir_00251_proc_${detector}_boot_325 build-config release} errMsg]} {
      puts "Warning: Could not set release configuration."
   }
   after 1000
   if {[catch {configapp -app fir_00251_proc_${detector}_325 build-config release} errMsg]} {
      puts "Warning: Could not set release configuration."
   }
}

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

#prebuild
if {[ catch {[source "D:/Telops/FIR-00251-Proc/bin/scripts/generateBuildInfoFile.tcl"]} ]} {
   puts "Catch the error because no input"
}

set scriptEnvironment "D:/Telops/FIR-00251-Proc/bin/scripts/setEnvironment.tcl"
genCore $scriptEnvironment $detector "160"
genCore $scriptEnvironment $detector "325"

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
