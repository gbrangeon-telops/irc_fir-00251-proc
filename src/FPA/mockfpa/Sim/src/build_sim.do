alib work
setActivelib work

do "D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\HDL\compil_mockfpa.do"   

acom -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\mock_fpa_testbench_pkg.vhd \
D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fbuffer_define.vhd \
D:\Telops\FIR-00251-Common\VHDL\Buffering\BufferingDefine.vhd \
D:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_RandomMiso.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\Top.bde \
D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\stim.vhd

