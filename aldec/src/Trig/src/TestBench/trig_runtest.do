
SetActiveLib -work
clearlibrary trig

acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom D:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd

do D:\Telops\FIR-00251-Proc\src\Trig\hdl\compil_trig_gen.do

runexe "d:/telops/fir-00251-Proc/src/copy_to_cpp.bat"
adel mb_model
cd D:\Telops\FIR-00251-Proc\aldec\src\Trig\src
buildc trig.dlm
addfile mb_model.dll
addsc mb_model.dll

acom "D:\Telops\FIR-00251-Proc\aldec\src\Testbench\SystemC\mb_model_wrapper.vhd"
acom d:\Telops\FIR-00251-Proc\aldec\src\Trig\src\trig_top_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\Trig\src\TestBench\trig_top_tb_TB.vhd
#

asim -ses trig_top_tb_TB 

#asim -dbg -cc -cc_all trig_top_tb_TB

## le receveur config
#wave -rec UUT/U1/U1/*

# le time stamper
#wave -rec UUT/U1/U4/U4/*

# les conditionneurs
wave -rec UUT/U1/U5/*

run  10 ms


