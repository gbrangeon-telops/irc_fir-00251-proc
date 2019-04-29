adel -all
SetActiveLib -work
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd
acom D:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do
do D:\Telops\FIR-00251-Proc\src\Quad_serdes\HDL\build_quad_receiver.do

acom d:\Telops\FIR-00251-Proc\aldec\src\afpa_quad_serdes\src\quad_receiver_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\afpa_quad_serdes\src\TestBench\quad_receiver_tb_TB.vhd


asim -ses quad_receiver_tb_TB 



wave UUT/U12/*
--wave UUT/U5/*

--run 20 us
 run 30 ms
