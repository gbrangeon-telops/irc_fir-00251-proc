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
acom "D:\Telops\FIR-00251-Common\VHDL\Buffering\BufferingDefine.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\fb_testbench_pkg.vhd"
acom -relax "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\stim.vhd"

acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_wr130_rd130_d128\fwft_sfifo_wr130_rd130_d128_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd128_fifo.vhd" 
 
acom "D:\Telops\FIR-00251-Proc\IP\325\t_axi4_stream64_sfifo_d16\t_axi4_stream64_sfifo_d16_sim_netlist.vhdl"  
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream64_fifo.vhd"

acom "D:\Telops\FIR-00251-Proc\IP\325\t_axi4_stream128_afifo_d16\t_axi4_stream128_afifo_d16_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream128_fifo.vhd"

acom "D:\Telops\Common_HDL\Matlab\axis_file_output_128.vhd"
acom "D:\Telops\Common_HDL\Matlab\axis_file_output_64.vhd"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\type_sw.vhd"
acom "D:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_RandomMiso.vhd"
acom "D:\Telops\FIR-00251-Common\VHDL\Utilities\axis128_RandomMiso.vhd"	  

acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_wr132_rd66_d16\fwft_afifo_wr132_rd66_d16_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd64_fifo.vhd"  


acom "D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_wr66_rd132_d128\fwft_sfifo_wr66_rd132_d128_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr64_rd128_fifo.vhd" 


do "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\build_frame_buffer.do"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\datamover_frame_buffer\datamover_frame_buffer_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\data_mover_wrapper.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\fifo_generator_0_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\AXI4_FIFO.vhd"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\axi_bram_ctrl_0_sim_netlist.vhdl"
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\axi_bram_ctrl_0_wrapper.vhdl"

acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\Top.bde"

-- done

