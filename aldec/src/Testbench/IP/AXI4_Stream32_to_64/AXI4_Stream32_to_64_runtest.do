
setenv FIR251COMMUM "$FIR251COMMON/VHDL/IP"

acom -O3 -work fir_00251 -2002  $FIR251COMMUM/AXI4_Stream32_to_64/AXI4_Stream32_to_64_funcsim.vhdl
acom -O3 -work fir_00251 -2002  $dsn/src/Testbench/IP/AXI4_Stream32_to_64/AXI4_Stream32_to_64_stim.vhd
acom -O3 -work fir_00251 -2002  $dsn/src/Testbench/IP/AXI4_Stream32_to_64/AXI4_Stream32_to_64_tb.bde

asim -O5 +access +r +m+AXI4_Stream32_to_64_tb AXI4_Stream32_to_64_tb AXI4_Stream32_to_64_tb
do $dsn/src/Testbench/IP/AXI4_Stream32_to_64/AXI4_Stream32_to_64_wave.do 

run 120us

