
SetActiveLib -work
clearlibrary ExposureTime

acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom D:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd

do D:\Telops\FIR-00251-Proc\src\ExposureTime\hdl\compil_exposure_time.do

runexe "d:/telops/fir-00251-Proc/src/copy_to_cpp.bat"
adel mb_model
cd D:\Telops\FIR-00251-Proc\aldec\src\ExposureTime\src
buildc Exposure.dlm
addfile mb_model.dll
addsc mb_model.dll

acom "D:\Telops\FIR-00251-Proc\aldec\src\Testbench\SystemC\mb_model_wrapper.vhd"
acom d:\Telops\FIR-00251-Proc\aldec\src\ExposureTime\src\exposure_top_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\ExposureTime\src\TestBench\exposure_top_tb_TB.vhd
#

asim -ses exposure_top_tb_TB 

# model mb
#wave -rec UUT/U2/*

#
wave -rec UUT/U1/U2/*

run  10 ms


