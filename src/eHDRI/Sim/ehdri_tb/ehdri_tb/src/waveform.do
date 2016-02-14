onerror { resume }
transcript off
add wave -named_row "Top Level"
add wave -noreg -logic {/ehdri_tb_toplevel/U2/AReset}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/Clk_Ctrl}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/Clk_Data}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/EXP_Ctrl_Busy}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/Axil_Mosi}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/Axil_Miso}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/FPA_Exp_Info}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/GND}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/mem_miso_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/mem_mosi_i}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/wr_en}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/mem_address_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/mem_data_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/wr_add}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/wr_data}
add wave -noreg -hexadecimal -literal -unsigned {/ehdri_tb_toplevel/U2/exptime0_i}
add wave -noreg -hexadecimal -literal -unsigned {/ehdri_tb_toplevel/U2/exptime1_i}
add wave -noreg -hexadecimal -literal -unsigned {/ehdri_tb_toplevel/U2/exptime2_i}
add wave -noreg -hexadecimal -literal -unsigned {/ehdri_tb_toplevel/U2/exptime3_i}
add wave -named_row "ehdri State Machine"
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U4/Clk_Data}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U4/AReset}
add wave -noreg -hexadecimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/ExpTime0}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/ExpTime1}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/ExpTime2}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/ExpTime3}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/Mem_Address}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/Mem_Data}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/enable_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/FPA_Exp_Info}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U4/EXP_Ctrl_Busy}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U4/Enable}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/fpa_exp_info_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/mem_address_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/Hder_Axil_Mosi}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/Hder_Axil_Miso}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/FPA_Img_Info}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/max_exptime}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U4/min_exptime}
add wave -noreg -literal {/ehdri_tb_toplevel/U2/U4/write_state}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U4/sreset}
add wave -named_row "ehdri ctrl"
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U3/Sys_clk}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U3/Rst}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/Axil_Mosi}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/Axil_Miso}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/Mem_Mosi}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/Mem_Miso}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/ExpTime0}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/ExpTime1}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/ExpTime2}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/ExpTime3}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U3/SM_Enable}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/cfg_waddr}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/cfg_raddr}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/cfg_read_data}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U3/cfg_wren}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U3/cfg_rden}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/axi_mosi_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/axi_miso_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/exptime0_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/exptime1_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/exptime2_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U3/exptime3_i}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U3/sm_enable_i}
add wave -named_row "Ublaze"
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U1/AXIL_MOSI}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U1/AXIL_MISO}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/CLK100}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/CLK160}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/EXP_Ctrl_Busy}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U1/FPA_Exp_Info}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U1/Feedback_FPA_Info}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/clk100_i}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/clk160_i}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U1/exp_time}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/exp_indx}
add wave -noreg -logic {/ehdri_tb_toplevel/U1/exp_dval}
add wave -noreg -hexadecimal -literal -unsigned {/ehdri_tb_toplevel/U1/busy_vector}
add wave -named_row "hder fifo"
add wave -noreg -logic {/ehdri_tb_toplevel/U3/ARESETN}
add wave -noreg -logic {/ehdri_tb_toplevel/U3/RX_CLK}
add wave -noreg -logic {/ehdri_tb_toplevel/U3/asgen_d15/t_axi4_lite32_w_afifo_d16_inst/axi_w_overflow}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U3/RX_MOSI}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U3/RX_MISO}
add wave -noreg -logic {/ehdri_tb_toplevel/U3/OVFL}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U1/clka}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/wea}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/addra}
add wave -named_row "Mem"
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/wea}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/addra}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/dina}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U1/clkb}
add wave -noreg -logic {/ehdri_tb_toplevel/U2/U1/enb}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/addrb}
add wave -noreg -decimal -literal -unsigned {/ehdri_tb_toplevel/U2/U1/doutb}
add wave -noreg -literal {/ehdri_tb_toplevel/U2/U4/write_state}
add wave -noreg -decimal -literal {/ehdri_tb_toplevel/U2/U4/exp_time_i}
cursor "Cursor 1" 8707111ps  
transcript on
