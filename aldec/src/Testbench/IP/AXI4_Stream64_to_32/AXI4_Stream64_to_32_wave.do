onerror { resume }
transcript off
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/ACLK}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/ARESETN}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_ACLK}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_ARESETN}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TVALID}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TREADY}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TDATA}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TSTRB}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TKEEP}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TLAST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TID}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TDEST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_AXIS_TUSER}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_ACLK}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_ARESETN}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TVALID}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TREADY}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TDATA}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TSTRB}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TKEEP}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TLAST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TID}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TDEST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S32_TO_S64/M00_AXIS_TUSER}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S32_TO_S64/S00_DECODE_ERR}
add wave -named_row "Named Row"
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/ACLK}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/ARESETN}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_ACLK}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_ARESETN}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TVALID}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TREADY}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TDATA}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TSTRB}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TKEEP}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TLAST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TID}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TDEST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_AXIS_TUSER}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_ACLK}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_ARESETN}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TVALID}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TREADY}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TDATA}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TSTRB}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TKEEP}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TLAST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TID}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TDEST}
add wave -noreg -hexadecimal -literal {/AXI4_Stream64_to_32_tb/S64_TO_S32/M00_AXIS_TUSER}
add wave -noreg -logic {/AXI4_Stream64_to_32_tb/S64_TO_S32/S00_DECODE_ERR}
cursor "Cursor 1" 10052657ps  
cursor "Cursor 2" 0ps  
transcript on
