alib work
setActivelib work


setenv COMMON "D:\Telops\FIR-00251-Common"
setenv PROC   "D:\Telops\FIR-00251-Proc"
setenv UTILITIES "D:\Telops\Common_HDL\Utilities"

-- frame buffer src
do "D:\Telops\FIR-00251-Proc\src\compil_utilities.do"
acom  "$COMMON\VHDL\tel2000pkg.vhd"	 
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fbuffer_define.vhd"
acom "D:\Telops\Common_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\fb_testbench_pkg.vhd"
acom -relax "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\stim.vhd"
 
acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_wr130_rd130_d128\fwft_sfifo_wr130_rd130_d128_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd128_fifo.vhd" 
 
acom "D:\Telops\FIR-00251-Proc\IP\325\t_axi4_stream64_sfifo_d16\t_axi4_stream64_sfifo_d16_sim_netlist.vhdl"  
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream64_fifo.vhd"

acom "D:\Telops\FIR-00251-Common\VHDL\axis64_frame_rate.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_ctrl_intf.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\reader_fsm.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\writer_fsm.vhd"	 
acom "D:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_RandomMiso.vhd"
acom "D:\Telops\FIR-00251-Common\VHDL\Utilities\axis128_RandomMiso.vhd"	  

acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_wr132_rd66_d16\fwft_afifo_wr132_rd66_d16_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd64_fifo.vhd"  


acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\FrameBuffer.bde"

-- Simulation src	 


acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\datamover_frame_buffer\datamover_frame_buffer_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\data_mover_wrapper.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\fifo_generator_0_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\AXI4_FIFO.vhd"


acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\axi_bram_ctrl_0_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\axi_bram_ctrl_0_wrapper.vhdl"


acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\Top.bde"



