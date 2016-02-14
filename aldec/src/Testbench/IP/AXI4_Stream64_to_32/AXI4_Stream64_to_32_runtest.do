

setenv FIR251COMMUM "D:\Telops\FIR-00251-Common\VHDL\IP"


acom -O3 -work fir_00251 -2002  $FIR251COMMUM\AXI4_Stream32_to_64\AXI4_Stream32_to_64_funcsim.vhdl


acom -O3 -work fir_00251 -2002  "$FIR251COMMUM\AXI4_Stream64_to32\AXI4_Stream64_to_32_funcsim.vhdl"
acom -O3 -work fir_00251 -2002  $dsn/src/Testbench/IP/AXI4_Stream64_to_32/AXI4_Stream64_to_32_stim.vhd
acom -O3 -work fir_00251 -2002  $dsn/src/Testbench/IP/AXI4_Stream64_to_32/AXI4_Stream64_to_32_tb.bde

asim -O5 +access +r +m+AXI4_Stream64_to_32_tb AXI4_Stream64_to_32_tb AXI4_Stream64_to_32_tb
do $dsn/src/Testbench/IP/AXI4_Stream64_to_32/AXI4_Stream64_to_32_wave.do 

run 120us

