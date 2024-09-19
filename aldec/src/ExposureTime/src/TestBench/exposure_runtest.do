
setactivelib work
clearlibrary ExposureTime

acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd

do $FIR251PROC/src/ExposureTime/hdl/compil_exposure_time.do

runexe "$FIR251PROC/src/copy_to_cpp.bat"
adel mb_model
cd $FIR251PROC/aldec/src/ExposureTime/src
buildc Exposure.dlm
addfile mb_model.dll
addsc mb_model.dll

acom "$FIR251PROC/aldec/src/Testbench/SystemC/mb_model_wrapper.vhd"
acom $FIR251PROC/aldec/src/ExposureTime/src/exposure_top_tb.bde
acom $FIR251PROC/aldec/src/ExposureTime/src/TestBench/exposure_top_tb_TB.vhd
#

asim -ses exposure_top_tb_TB 

# model mb
#wave -rec UUT/U2/*

#
wave -rec UUT/U1/U2/*

run  10 ms


