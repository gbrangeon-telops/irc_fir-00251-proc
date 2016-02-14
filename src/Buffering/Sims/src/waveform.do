onerror { resume }
transcript off
add wave -named_row "SIMULATION SRC"
add wave -noreg -logic {/sim_buffering_top/STIM/CLK160}
add wave -noreg -logic {/sim_buffering_top/STIM/CLK100}
add wave -noreg -logic {/sim_buffering_top/STIM/ARESETN}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/STIM/AXIL_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/STIM/AXIL_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/STIM/AXIL_BUF_MOSI}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/STIM/AXIL_BUF_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/STIM/write_value}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/STIM/write_value_u}
add wave -noreg -logic {/sim_buffering_top/STIM/WATERLEVEL}
add wave -noreg -logic {/sim_buffering_top/STIM/EXTERNAL_MOI}
add wave -noreg -logic {/sim_buffering_top/STIM/STALL}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/tx_cal_miso}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/tx_cal_mosi}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/STIM/MB_PROCESS/nb_seq_mem}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/STIM/read_value}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/TX_MGT_MOSI}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/TX_MGT_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/read_buf32_mosi}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/read_buf32_miso}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U20/tid_s}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/read_buf32_mosi_tid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/read_buf32_miso_tid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/rd_data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/wr_data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/axi_w_data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/axi_w_wr_data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/axi_w_rd_data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/axi_r_wr_data_count}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U8/sgen_d256/t_axi4_stream32_sfifo_d256_inst/U0/axi_r_rd_data_count}
add wave -named_row "BUFFER SRC"
add wave -named_row "MOI_SRC"
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U10/EXTERNAL}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U10/SOFTWARE}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/U10/MODE}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/U10/EDGE}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U10/MOI}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U10/ext_moi_o}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U10/ext_moi_i}
add wave -named_row "BUFFER CTRL"
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/MEMORY_BASE_ADDR}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/NB_SEQUENCE_MAX}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/SEQ_IMG_TOTAL}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/FRAME_SIZE}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/BUFFER_MODE}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/BUF_CTRL/CONFIG_VALID}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/NB_IMG_PRE}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/NB_IMG_POST}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/NB_SEQ_IN_MEM}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/RD_SEQ_ID}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/RD_START_ID}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/RD_STOP_ID}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/BUF_CTRL/CLEAR_MEMORY_CONTENT}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/BUFFER_SWITCH}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BUF_CTRL/FSM_ERROR}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/BUF_CTRL/SOFT_MOI}
add wave -named_row "FSM"
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_MM2S_CMD_MOSI}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_MM2S_CMD_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_MM2S_STS_MOSI}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_MM2S_STS_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_S2MM_CMD_MOSI}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_S2MM_CMD_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/AXIS_S2MM_STS_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/AXIS_S2MM_STS_MISO}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/FSM/BUFFER_MODE}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/NEW_IMAGE_DETECT}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/ACQUISITION_STOP}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/MOI}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/CONFIG_VALID}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/NB_SEQUENCE}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/FRAME_SIZE}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/MEMORY_BASED_ADDR}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/SEQ_IMG_TOTAL}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/NB_IMG_PRE}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/NB_IMG_POST}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/NB_SEQUENCE_IN_MEM}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/READ_SEQUENCE_ID}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/READ_START_ID}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/READ_STOP_ID}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/WATER_LEVEL}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/IMG_READ_EOF}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/CLEAR_MEMORY_CONTENT}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/BM_TABLE_ADDR}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/BM_TABLE_WR_DATA}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/BM_TABLE_WREN}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/BM_TABLE_REN}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/BM_TABLE_RD_DATA}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/BM_TABLE_R_DVAL}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/WRITE_ERR}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/READ_ERR}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/frame_size_u}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/baseaddr_s}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/baseaddr_u}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/nb_sequence_u}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/config_valid_s}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/FSM/nb_img_pre_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/nb_img_post_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/SeqSizeMax_bytes_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/nb_seq_in_mem_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/read_seq_id_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/read_seq_id_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/read_start_id_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/read_stop_id_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/start_loc_s}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/moi_loc_s}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/end_loc_s}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s_mm2s_cmd_tag}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s_s2mm_cmd_tag}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s_mm2s_saddr}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s_s2mm_saddr}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/s_mm2s_eof}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/s_s2mm_eof}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s_mm2s_btt}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s_s2mm_btt}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/mm2s_err_o}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/s2mm_err_o}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/FSM/moi_i}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/FSM/write_state}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/FSM/next_write_state}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/FSM/read_state}
add wave -noreg -literal {/sim_buffering_top/BUFFER_INST/FSM/next_read_state}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/total_img_per_seq_u}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/write_img_loc}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/FSM/read_img_loc}
add wave -named_row "axil32_to_native96"
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/AXIL_MOSI}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/AXIL_MISO}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/WR_ADD}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/WR_DATA}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/WR_EN}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/RD_ADD}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/RD_DATA}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/RD_EN}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/RD_DVAL}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/ERR}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/axi_awaddr}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/axi_awready}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/axi_wready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/axi_bresp}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/axi_bvalid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/axi_araddr}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/axi_arready}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/axi_rvalid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/axi_rdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/axi_rresp}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/rd_proc}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/slv_reg0}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/slv_reg1}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U11/slv_reg2}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/slv_reg_rden}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U11/slv_reg_wren}
add wave -noreg -decimal -literal -signed2 {/sim_buffering_top/BUFFER_INST/U11/byte_index}
add wave -named_row "BUFFER_TABLE"
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U4/clka}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U4/ena}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U4/wea}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U4/addra}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U4/dina}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U4/douta}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U4/clkb}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U4/enb}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U4/web}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/U4/addrb}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/BUFFER_INST/U4/dinb}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U4/doutb}
add wave -named_row "CORE BD"
add wave -named_row "DM"
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_aclk}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_aresetn}
add wave -noreg -logic {/sim_buffering_top/core/U2/mm2s_err}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_cmdsts_aclk}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_cmdsts_aresetn}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_mm2s_cmd_tvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_mm2s_cmd_tready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/s_axis_mm2s_cmd_tdata}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_sts_tvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_sts_tready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axis_mm2s_sts_tdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axis_mm2s_sts_tkeep}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_sts_tlast}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_mm2s_arid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_mm2s_araddr}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_mm2s_arlen}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_mm2s_arsize}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_mm2s_arburst}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_mm2s_arprot}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_mm2s_arcache}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_mm2s_aruser}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_arvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_arready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_mm2s_rdata}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_mm2s_rresp}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_rlast}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_rvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_mm2s_rready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axis_mm2s_tdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axis_mm2s_tkeep}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_tlast}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_tvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_mm2s_tready}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_aclk}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_aresetn}
add wave -noreg -logic {/sim_buffering_top/core/U2/s2mm_err}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_s2mm_cmdsts_awclk}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_s2mm_cmdsts_aresetn}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_s2mm_cmd_tvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_s2mm_cmd_tready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/s_axis_s2mm_cmd_tdata}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_s2mm_sts_tvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_s2mm_sts_tready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axis_s2mm_sts_tdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axis_s2mm_sts_tkeep}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axis_s2mm_sts_tlast}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_s2mm_awid}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_s2mm_awaddr}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_s2mm_awlen}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_s2mm_awsize}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_s2mm_awburst}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_s2mm_awprot}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_s2mm_awcache}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_s2mm_awuser}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_awvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_awready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/m_axi_s2mm_wdata}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_s2mm_wstrb}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_wlast}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_wvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_wready}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/U2/m_axi_s2mm_bresp}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_bvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/m_axi_s2mm_bready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/s_axis_s2mm_tdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/U2/s_axis_s2mm_tkeep}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_s2mm_tlast}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_s2mm_tvalid}
add wave -noreg -logic {/sim_buffering_top/core/U2/s_axis_s2mm_tready}
add wave -named_row "RAM_INTF"
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/blk_mem_gen/s_axi_awid}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/blk_mem_gen/s_axi_awaddr}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/blk_mem_gen/s_axi_awlen}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/blk_mem_gen/s_axi_awsize}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_awburst}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_awvalid}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_awready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_wdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_wstrb}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_wlast}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_wvalid}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_wready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_bid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_bresp}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_bvalid}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_bready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_arid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_araddr}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/blk_mem_gen/s_axi_arlen}
add wave -noreg -hexadecimal -literal -unsigned {/sim_buffering_top/core/blk_mem_gen/s_axi_arsize}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_arburst}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_arvalid}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_arready}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_rid}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_rdata}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/core/blk_mem_gen/s_axi_rresp}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_rlast}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_rvalid}
add wave -noreg -logic {/sim_buffering_top/core/blk_mem_gen/s_axi_rready}
add wave -named_row "IMG_SOF/EOF"
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U9/SOF}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/fall}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/full}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/skip}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/BM_SW}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U2/SEL}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U2/sel_i}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U2/off}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U2/eof_i}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U2/sof_i}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U3/SEL}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U3/sel_i}
add wave -noreg -logic {/sim_buffering_top/BUFFER_INST/U3/off}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U3/eof_i}
add wave -noreg -hexadecimal -literal {/sim_buffering_top/BUFFER_INST/U3/sof_i}
cursor "Cursor 1" 257378225ps  
transcript on
