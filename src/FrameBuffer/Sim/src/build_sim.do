alib work
setActivelib work


setenv COMMON "D:\Telops\FIR-00251-Common"
setenv PROC   "D:\Telops\FIR-00251-Proc"
setenv UTILITIES "D:\Telops\Common_HDL\Utilities"

-- frame buffer src
do "D:\Telops\FIR-00251-Proc\src\compil_utilities.do"
acom  "$COMMON\VHDL\tel2000pkg.vhd"	 
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_define.vhd"

acom "D:\Telops\Common_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"


acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_manager.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_ctrl_intf.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\reader_fsm.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\writer_fsm.vhd"

acom "D:\Telops\FIR-00251-Proc\IP\325\t_axi4_stream64_sfifo_d128\t_axi4_stream64_sfifo_d128_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream64_fifo.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\FrameBuffer.bde"

-- Simulation src	 
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\fb_testbench_pkg.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\datamover_frame_buffer_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\data_mover_wrapper.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\fifo_generator_0_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\AXI4_FIFO.vhd"


acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\axi_bram_ctrl_0_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\axi_bram_ctrl_0_wrapper.vhdl"

acom -relax "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\stim.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\Top.bde"



