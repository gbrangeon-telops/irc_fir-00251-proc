
adel -all

# IP
acom D:\Telops\FIR-00251-Proc\IP\325\calciumD_clks_mmcm\calciumD_clks_mmcm_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_wr66_rd132_d512\fwft_afifo_wr66_rd132_d512_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_wr192_rd96_d16\fwft_afifo_wr192_rd96_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w76_d16\fwft_sfifo_w76_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\ip_axis16_combine_axis64\ip_axis16_combine_axis64_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\ip_axis_fi32tofp32\ip_axis_fi32tofp32_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\ip_axis_fp32tofi32\ip_axis_fp32tofi32_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\ip_fp32_axis_exp\ip_fp32_axis_exp_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\ip_fp32_axis_log\ip_fp32_axis_log_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\ip_fp32_axis_mult\ip_fp32_axis_mult_sim_netlist.vhdl

# FPA module
do D:\Telops\FIR-00251-Proc\src\FPA\calcium640D\HDL\compil_calcium640D.do

# emulateur
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\monit_adc_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\fpa_temp_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\digio_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\flexV_dummy.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\services_testbench\src\brd_switch_dummy.vhd

# Testbench
acom D:\Telops\FIR-00251-Proc\aldec\src\FPA\calcium640D\src\calcium640D_intf_testbench_pkg.vhd
acom D:\Telops\FIR-00251-Proc\aldec\src\FPA\calcium640D\src\calcium640D_intf_testbench.bde
acom D:\Telops\FIR-00251-Proc\aldec\src\FPA\calcium640D\src\calcium640D_intf_testbench_stim.vhd

asim -ses calcium640D_intf_testbench_stim

wave UUT/U1/*

run 4 ms

