adel -all
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do  
do D:\Telops\FIR-00251-Proc\aldec\debug_scopio_230Hz\src\compil_scorpio230_dbg.do 

#pour la simulation
--acom d:\Telops\FIR-00251-Proc\aldec\src\Clink_receiver\src\Clink_receiver_tb.bde
acom  d:\Telops\FIR-00251-Proc\aldec\debug_scopio_230Hz\src\TestBench\double_base_sig_measure_TB.vhd


asim -ses double_base_sig_measure_TB 


wave UUT/U2/U1/*

run 40 ms