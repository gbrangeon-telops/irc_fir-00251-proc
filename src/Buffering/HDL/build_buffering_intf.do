alib work
setActivelib work

setenv BUF_INTF "D:\Telops\FIR-00251-Proc\src\Buffering\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

# Package
acom -nowarn DAGGEN_0523 "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
 "$COMMON_HDL\Utilities\double_sync.vhd" \
 "$COMMON_HDL\Utilities\double_sync_vector.vhd" \
 "$COMMON_HDL\Utilities\sync_resetn.vhd"

#fir-00251-common
acom -nowarn DAGGEN_0523 \
 "$PROC\IP\ip_axis32_fanout2\ip_axis32_fanout2_funcsim.vhdl" \
 "$COMMON\VHDL\Utilities\axis32_fanout2.vhd" \
 "$COMMON\VHDL\Utilities\axis32_sw_1_2.vhd" \
 "$COMMON\VHDL\Utilities\axis32_sw_2_1.vhd" \
 "$COMMON\VHDL\Utilities\axis32_hole.vhd" \
 "$COMMON\VHDL\Utilities\axis32_reg.vhd" \
 "$COMMON\VHDL\Utilities\axis32_stub.vhd" \
 "$COMMON\VHDL\Utilities\axis32_hole_sync.vhd" \
 "$COMMON\VHDL\Utilities\axis32_img_boundaries.vhd" \
 "$COMMON\VHDL\Utilities\axis32_tid_gen.vhd" \
 "$PROC\IP\t_axi4_stream32_sfifo_d16\t_axi4_stream32_sfifo_d16_funcsim.vhdl" \
 "$PROC\IP\t_axi4_stream32_sfifo_d64\t_axi4_stream32_sfifo_d64_funcsim.vhdl" \
 "$PROC\IP\t_axi4_stream32_sfifo_d256\t_axi4_stream32_sfifo_d256_funcsim.vhdl" \
 "$PROC\IP\t_axi4_stream32_afifo_d512\t_axi4_stream32_afifo_d512_funcsim.vhdl" \
 "$PROC\IP\t_axi4_stream32_sfifo_d2048\t_axi4_stream32_sfifo_d2048_funcsim.vhdl" \
 "$PROC\IP\ip_axis16_merge_axis32\ip_axis16_merge_axis32_funcsim.vhdl" \
 "$COMMON\VHDL\fifo\t_axi4_stream32_fifo.vhd" \
 "$COMMON\VHDL\Utilities\axil32_to_native96.vhd" \
 "$COMMON\VHDL\Utilities\shift_registers_x.vhd" \
 "$COMMON\VHDL\axis32_pixel_cnt.vhd" \
 "$COMMON\VHDL\Utilities\axis16_merge_axis32.vhd" \
 "$COMMON\VHDL\Buffering\BufferingDefine.vhd" \
 "$COMMON\VHDL\Buffering\axis32_img_sof.vhd" \
 "$COMMON\VHDL\Buffering\axis32_img_eof.vhd"

#source Buffering

acom -nowarn DAGGEN_0523 "$BUF_INTF\buffering_fsm.vhd" \
 -relax "$BUF_INTF\buffering_Ctrl.vhd" \
 "$PROC\IP\buffer_table_ram\buffer_table_ram_funcsim.vhdl" \
 "$BUF_INTF\moi_source_selector.vhd" \
 "$BUF_INTF\buffering.bde"


