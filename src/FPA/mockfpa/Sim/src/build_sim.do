alib -all

do "D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\compil_mockfpa.do"   

acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_wr132_rd66_d16\fwft_afifo_wr132_rd66_d16_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd64_fifo.vhd"

acom -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\mock_fpa_testbench_pkg.vhd \
D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fbuffer_define.vhd \
D:\Telops\FIR-00251-Common\VHDL\Buffering\BufferingDefine.vhd \
D:\Telops\FIR-00251-Common\VHDL\Utilities\axis128_RandomMiso.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\Top.bde \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\stim.vhd

