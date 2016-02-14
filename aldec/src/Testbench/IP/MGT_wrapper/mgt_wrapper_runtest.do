

acom -O3 -work -2002  $dsn/src/Testbench/IP/mgt_wrapper/mgt_wrapper_stim.vhd
acom -O3 -work -2002  $dsn/src/Testbench/IP/mgt_wrapper/mgt_wrapper_tb.bde

asim -O5 +access +r +m+mgt_wrapper_tb mgt_wrapper_tb mgt_wrapper_tb
do $dsn/src/Testbench/IP/mgt_wrapper/mgt_wrapper_wave.do 

run 70us

