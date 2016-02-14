

acom -O3 -work fir_00251 -2002  $dsn/../IP/data_mgt/data_mgt_funcsim.vhdl
acom -O3 -work fir_00251 -2002  $dsn/../mgt/data_mgt_example/data_mgt_example.srcs/sources_1/imports/data_mgt/example_design/cc_manager/data_mgt_standard_cc_module.vhd
acom -O3 -work fir_00251 -2002  $dsn/src/Testbench/IP/data_mgt/data_mgt_stim.vhd
acom -O3 -work fir_00251 -2002  $dsn/src/Testbench/IP/data_mgt/data_mgt_tb.bde

asim -O5 +access +r +m+data_mgt_tb data_mgt_tb data_mgt_tb
do $dsn/src/Testbench/IP/data_mgt/data_mgt_wave.do 

run 70us

