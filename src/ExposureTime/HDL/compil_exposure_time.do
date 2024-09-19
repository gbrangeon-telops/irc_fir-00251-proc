#savealltabs
#setactivelib work
#clearlibrary 	

#Packages
acom $FIR251PROC/src/ExposureTime/HDL/exposure_define.vhd
                                                                       
#utilities
do $FIR251PROC/src/compil_utilities.do                                                                     

# sources                                                              
acom $FIR251PROC/src/ExposureTime/HDL/exp_time_mb_intf.vhd
acom $FIR251PROC/src/ExposureTime/HDL/exp_time_manager.vhd
acom $FIR251PROC/src/ExposureTime/HDL/exposure_time_ctrl.bde