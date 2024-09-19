alib -all

do "$FIR251PROC/src/FPA/mockfpa/HDL/compil_mockfpa.do"   

acom "$FIR251PROC/IP/325/fwft_afifo_wr132_rd66_d16/fwft_afifo_wr132_rd66_d16_sim_netlist.vhdl"
acom "$FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr128_rd64_fifo.vhd"

acom -nowarn DAGGEN_0523 -incr \
$FIR251PROC/src/FPA/mockfpa/Sim/src/mock_fpa_testbench_pkg.vhd \
$FIR251PROC/src/FrameBuffer/HDL/fbuffer_define.vhd \
$FIR251COMMON/VHDL/Buffering/BufferingDefine.vhd \
$FIR251COMMON/VHDL/Utilities/axis128_RandomMiso.vhd \
$FIR251PROC/src/FPA/mockfpa/Sim/src/Top.bde \
$FIR251PROC/src/FPA/mockfpa/Sim/src/stim.vhd

