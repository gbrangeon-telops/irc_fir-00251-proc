
adel -all

# IP
acom $FIR251PROC/IP/325/calciumD_clks_mmcm/calciumD_clks_mmcm_sim_netlist.vhdl
acom $FIR251PROC/IP/325/calciumD_prog_ram/calciumD_prog_ram_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_wr66_rd132_d512/fwft_afifo_wr66_rd132_d512_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_afifo_wr192_rd96_d16/fwft_afifo_wr192_rd96_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/fwft_sfifo_w72_d16/fwft_sfifo_w72_d16_sim_netlist.vhdl
acom $FIR251PROC/IP/325/ip_axis_fi32tofp32/ip_axis_fi32tofp32_stub.vhdl
acom $FIR251PROC/IP/325/ip_axis_fp32tofi32/ip_axis_fp32tofi32_stub.vhdl
acom $FIR251PROC/IP/325/ip_fp32_axis_exp/ip_fp32_axis_exp_stub.vhdl
acom $FIR251PROC/IP/325/ip_fp32_axis_log/ip_fp32_axis_log_stub.vhdl
acom $FIR251PROC/IP/325/ip_fp32_axis_mult/ip_fp32_axis_mult_stub.vhdl

# FPA module
do $FIR251PROC/src/FPA/calcium640D/HDL/compil_calcium640D.do

# Serdes module
do $FIR251PROC/src/nbits/HDL/compil_nbits_receiver.do
acom -2008 $FIR251PROC/aldec/src/FPA/calcium640D/src/calcium640D_fpa_dummy.vhd

# PGM file builder
acom $FIR251COMMON/VHDL/pgm_builder.vhd

# emulateur
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/monit_adc_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/fpa_temp_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/digio_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/flexV_dummy.vhd
acom $FIR251PROC/src/FPA/calcium_proxy/Sim/services_testbench/src/brd_switch_dummy.vhd

# Testbench
acom $FIR251PROC/aldec/src/FPA/calcium640D/src/calcium640D_intf_testbench_pkg.vhd
acom -2008 $FIR251PROC/aldec/src/FPA/calcium640D/src/calcium640D_intf_testbench.bde
acom $FIR251PROC/aldec/src/FPA/calcium640D/src/calcium640D_intf_testbench_stim.vhd

#asim -ses calcium640D_intf_testbench_stim
#
#wave UUT/U1/*
#
#run 10 ms

#__Ce testbench est simulable seulement dans Vivado

