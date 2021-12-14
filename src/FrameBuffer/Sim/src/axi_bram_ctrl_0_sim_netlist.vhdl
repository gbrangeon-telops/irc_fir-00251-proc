-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Wed Aug 19 16:07:10 2020
-- Host        : TELOPS250 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim -rename_top axi_bram_ctrl_0 -prefix
--               axi_bram_ctrl_0_ axi_bram_ctrl_0_sim_netlist.vhdl
-- Design      : axi_bram_ctrl_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_SRL_FIFO is
  port (
    bid_gets_fifo_load_d1_reg : out STD_LOGIC;
    \GEN_AW_DUAL.wr_addr_sm_cs_reg\ : out STD_LOGIC;
    bid_gets_fifo_load_d1_reg_0 : out STD_LOGIC;
    bid_gets_fifo_load : out STD_LOGIC;
    bid_gets_fifo_load_d1_reg_1 : out STD_LOGIC;
    bvalid_cnt_inc : out STD_LOGIC;
    axi_wdata_full_cmb115_out : out STD_LOGIC;
    bvalid_cnt_inc11_out : out STD_LOGIC;
    \axi_bid_int_reg[0]\ : out STD_LOGIC;
    bid_fifo_rst : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    wr_addr_sm_cs : in STD_LOGIC;
    last_data_ack_mod : in STD_LOGIC;
    \GEN_AWREADY.axi_aresetn_d2_reg\ : in STD_LOGIC;
    \bvalid_cnt_reg[1]\ : in STD_LOGIC;
    bvalid_cnt : in STD_LOGIC_VECTOR ( 2 downto 0 );
    bid_gets_fifo_load_d1 : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    axi_bvalid_int_reg : in STD_LOGIC;
    axi_wr_burst : in STD_LOGIC;
    axi_awaddr_full : in STD_LOGIC;
    aw_active : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : in STD_LOGIC;
    curr_awlen_reg_1_or_2 : in STD_LOGIC;
    axi_awlen_pipe_1_or_2 : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg\ : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    axi_awid_pipe : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end axi_bram_ctrl_0_SRL_FIFO;

architecture STRUCTURE of axi_bram_ctrl_0_SRL_FIFO is
  signal \Addr_Counters[0].FDRE_I_n_0\ : STD_LOGIC;
  signal \Addr_Counters[1].FDRE_I_n_0\ : STD_LOGIC;
  signal \Addr_Counters[2].FDRE_I_n_0\ : STD_LOGIC;
  signal \Addr_Counters[3].FDRE_I_n_0\ : STD_LOGIC;
  signal \Addr_Counters[3].XORCY_I_i_1_n_0\ : STD_LOGIC;
  signal CI : STD_LOGIC;
  signal D : STD_LOGIC;
  signal Data_Exists_DFF_i_2_n_0 : STD_LOGIC;
  signal Data_Exists_DFF_i_3_n_0 : STD_LOGIC;
  signal \GEN_AWREADY.axi_awready_int_i_6_n_0\ : STD_LOGIC;
  signal \^gen_aw_dual.wr_addr_sm_cs_reg\ : STD_LOGIC;
  signal S : STD_LOGIC;
  signal S0_out : STD_LOGIC;
  signal S1_out : STD_LOGIC;
  signal addr_cy_1 : STD_LOGIC;
  signal addr_cy_2 : STD_LOGIC;
  signal addr_cy_3 : STD_LOGIC;
  signal \axi_bid_int[0]_i_2_n_0\ : STD_LOGIC;
  signal \axi_bid_int[0]_i_3_n_0\ : STD_LOGIC;
  signal \^axi_wdata_full_cmb115_out\ : STD_LOGIC;
  signal bid_fifo_ld : STD_LOGIC;
  signal bid_fifo_not_empty : STD_LOGIC;
  signal bid_fifo_rd : STD_LOGIC;
  signal \^bid_gets_fifo_load\ : STD_LOGIC;
  signal \^bid_gets_fifo_load_d1_reg\ : STD_LOGIC;
  signal \^bid_gets_fifo_load_d1_reg_0\ : STD_LOGIC;
  signal \^bid_gets_fifo_load_d1_reg_1\ : STD_LOGIC;
  signal \^bvalid_cnt_inc\ : STD_LOGIC;
  signal \^bvalid_cnt_inc11_out\ : STD_LOGIC;
  signal clr_bram_we_cmb6_out : STD_LOGIC;
  signal sum_A_0 : STD_LOGIC;
  signal sum_A_1 : STD_LOGIC;
  signal sum_A_2 : STD_LOGIC;
  signal sum_A_3 : STD_LOGIC;
  signal \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \Addr_Counters[0].FDRE_I\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \Addr_Counters[0].MUXCY_L_I_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \Addr_Counters[0].MUXCY_L_I_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of \Addr_Counters[0].MUXCY_L_I_CARRY4\ : label is "LO:O";
  attribute BOX_TYPE of \Addr_Counters[1].FDRE_I\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \Addr_Counters[2].FDRE_I\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \Addr_Counters[3].FDRE_I\ : label is "PRIMITIVE";
  attribute BOX_TYPE of Data_Exists_DFF : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of Data_Exists_DFF : label is "FDR";
  attribute BOX_TYPE of \FIFO_RAM[0].SRL16E_I\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \FIFO_RAM[0].SRL16E_I\ : label is "U0/\gint_inst.abcv4_0_int_inst/GEN_AXI4.I_FULL_AXI/I_WR_CHNL/BID_FIFO/FIFO_RAM ";
  attribute srl_name : string;
  attribute srl_name of \FIFO_RAM[0].SRL16E_I\ : label is "U0/\gint_inst.abcv4_0_int_inst/GEN_AXI4.I_FULL_AXI/I_WR_CHNL/BID_FIFO/FIFO_RAM[0].SRL16E_I ";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_AW_DUAL.wr_addr_sm_cs_i_3\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of axi_bvalid_int_i_3 : label is "soft_lutpair93";
begin
  \GEN_AW_DUAL.wr_addr_sm_cs_reg\ <= \^gen_aw_dual.wr_addr_sm_cs_reg\;
  axi_wdata_full_cmb115_out <= \^axi_wdata_full_cmb115_out\;
  bid_gets_fifo_load <= \^bid_gets_fifo_load\;
  bid_gets_fifo_load_d1_reg <= \^bid_gets_fifo_load_d1_reg\;
  bid_gets_fifo_load_d1_reg_0 <= \^bid_gets_fifo_load_d1_reg_0\;
  bid_gets_fifo_load_d1_reg_1 <= \^bid_gets_fifo_load_d1_reg_1\;
  bvalid_cnt_inc <= \^bvalid_cnt_inc\;
  bvalid_cnt_inc11_out <= \^bvalid_cnt_inc11_out\;
\Addr_Counters[0].FDRE_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bid_fifo_not_empty,
      D => sum_A_3,
      Q => \Addr_Counters[0].FDRE_I_n_0\,
      R => bid_fifo_rst
    );
\Addr_Counters[0].MUXCY_L_I_CARRY4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_CO_UNCONNECTED\(3),
      CO(2) => addr_cy_1,
      CO(1) => addr_cy_2,
      CO(0) => addr_cy_3,
      CYINIT => CI,
      DI(3) => \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_DI_UNCONNECTED\(3),
      DI(2) => \Addr_Counters[2].FDRE_I_n_0\,
      DI(1) => \Addr_Counters[1].FDRE_I_n_0\,
      DI(0) => \Addr_Counters[0].FDRE_I_n_0\,
      O(3) => sum_A_0,
      O(2) => sum_A_1,
      O(1) => sum_A_2,
      O(0) => sum_A_3,
      S(3) => \Addr_Counters[3].XORCY_I_i_1_n_0\,
      S(2) => S0_out,
      S(1) => S1_out,
      S(0) => S
    );
\Addr_Counters[0].MUXCY_L_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFFFFFD0000"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => \Addr_Counters[1].FDRE_I_n_0\,
      I2 => \Addr_Counters[3].FDRE_I_n_0\,
      I3 => \Addr_Counters[2].FDRE_I_n_0\,
      I4 => \axi_bid_int[0]_i_2_n_0\,
      I5 => \Addr_Counters[0].FDRE_I_n_0\,
      O => S
    );
\Addr_Counters[0].MUXCY_L_I_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4555555555555555"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => \axi_bid_int[0]_i_2_n_0\,
      I2 => \Addr_Counters[0].FDRE_I_n_0\,
      I3 => \Addr_Counters[1].FDRE_I_n_0\,
      I4 => \Addr_Counters[3].FDRE_I_n_0\,
      I5 => \Addr_Counters[2].FDRE_I_n_0\,
      O => CI
    );
\Addr_Counters[1].FDRE_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bid_fifo_not_empty,
      D => sum_A_2,
      Q => \Addr_Counters[1].FDRE_I_n_0\,
      R => bid_fifo_rst
    );
\Addr_Counters[1].MUXCY_L_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFFFFFD0000"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => \Addr_Counters[0].FDRE_I_n_0\,
      I2 => \Addr_Counters[3].FDRE_I_n_0\,
      I3 => \Addr_Counters[2].FDRE_I_n_0\,
      I4 => \axi_bid_int[0]_i_2_n_0\,
      I5 => \Addr_Counters[1].FDRE_I_n_0\,
      O => S1_out
    );
\Addr_Counters[2].FDRE_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bid_fifo_not_empty,
      D => sum_A_1,
      Q => \Addr_Counters[2].FDRE_I_n_0\,
      R => bid_fifo_rst
    );
\Addr_Counters[2].MUXCY_L_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFFFFFD0000"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => \Addr_Counters[0].FDRE_I_n_0\,
      I2 => \Addr_Counters[1].FDRE_I_n_0\,
      I3 => \Addr_Counters[3].FDRE_I_n_0\,
      I4 => \axi_bid_int[0]_i_2_n_0\,
      I5 => \Addr_Counters[2].FDRE_I_n_0\,
      O => S0_out
    );
\Addr_Counters[3].FDRE_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bid_fifo_not_empty,
      D => sum_A_0,
      Q => \Addr_Counters[3].FDRE_I_n_0\,
      R => bid_fifo_rst
    );
\Addr_Counters[3].XORCY_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFFFFFD0000"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => \Addr_Counters[0].FDRE_I_n_0\,
      I2 => \Addr_Counters[1].FDRE_I_n_0\,
      I3 => \Addr_Counters[2].FDRE_I_n_0\,
      I4 => \axi_bid_int[0]_i_2_n_0\,
      I5 => \Addr_Counters[3].FDRE_I_n_0\,
      O => \Addr_Counters[3].XORCY_I_i_1_n_0\
    );
Data_Exists_DFF: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => D,
      Q => bid_fifo_not_empty,
      R => bid_fifo_rst
    );
Data_Exists_DFF_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD05"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => Data_Exists_DFF_i_2_n_0,
      I2 => Data_Exists_DFF_i_3_n_0,
      I3 => bid_fifo_not_empty,
      O => D
    );
Data_Exists_DFF_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000FFFD"
    )
        port map (
      I0 => \^bvalid_cnt_inc\,
      I1 => bvalid_cnt(0),
      I2 => bvalid_cnt(2),
      I3 => bvalid_cnt(1),
      I4 => \^bid_gets_fifo_load_d1_reg_1\,
      I5 => bid_gets_fifo_load_d1,
      O => Data_Exists_DFF_i_2_n_0
    );
Data_Exists_DFF_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \Addr_Counters[0].FDRE_I_n_0\,
      I1 => \Addr_Counters[1].FDRE_I_n_0\,
      I2 => \Addr_Counters[3].FDRE_I_n_0\,
      I3 => \Addr_Counters[2].FDRE_I_n_0\,
      O => Data_Exists_DFF_i_3_n_0
    );
\FIFO_RAM[0].SRL16E_I\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => \Addr_Counters[0].FDRE_I_n_0\,
      A1 => \Addr_Counters[1].FDRE_I_n_0\,
      A2 => \Addr_Counters[2].FDRE_I_n_0\,
      A3 => \Addr_Counters[3].FDRE_I_n_0\,
      CE => CI,
      CLK => s_axi_aclk,
      D => bid_fifo_ld,
      Q => bid_fifo_rd
    );
\FIFO_RAM[0].SRL16E_I_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awid_pipe,
      I1 => axi_awaddr_full,
      I2 => s_axi_awid(0),
      O => bid_fifo_ld
    );
\GEN_AWREADY.axi_awready_int_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DDDDD0DDFFFFFFFF"
    )
        port map (
      I0 => \GEN_AWREADY.axi_awready_int_i_6_n_0\,
      I1 => wr_addr_sm_cs,
      I2 => \^gen_aw_dual.wr_addr_sm_cs_reg\,
      I3 => last_data_ack_mod,
      I4 => \^bid_gets_fifo_load_d1_reg_0\,
      I5 => \GEN_AWREADY.axi_aresetn_d2_reg\,
      O => \^bid_gets_fifo_load_d1_reg\
    );
\GEN_AWREADY.axi_awready_int_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"007F007F007F0000"
    )
        port map (
      I0 => bvalid_cnt(0),
      I1 => bvalid_cnt(2),
      I2 => bvalid_cnt(1),
      I3 => aw_active,
      I4 => axi_awaddr_full,
      I5 => s_axi_awvalid,
      O => \GEN_AWREADY.axi_awready_int_i_6_n_0\
    );
\GEN_AWREADY.axi_awready_int_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => axi_awaddr_full,
      I1 => curr_awlen_reg_1_or_2,
      I2 => axi_awlen_pipe_1_or_2,
      I3 => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg\,
      O => \^bid_gets_fifo_load_d1_reg_0\
    );
\GEN_AW_DUAL.wr_addr_sm_cs_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => bvalid_cnt(0),
      I1 => bvalid_cnt(2),
      I2 => bvalid_cnt(1),
      O => \^gen_aw_dual.wr_addr_sm_cs_reg\
    );
\axi_bid_int[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACAFACA0"
    )
        port map (
      I0 => bid_fifo_ld,
      I1 => bid_fifo_rd,
      I2 => \^bid_gets_fifo_load\,
      I3 => \axi_bid_int[0]_i_2_n_0\,
      I4 => s_axi_bid(0),
      O => \axi_bid_int_reg[0]\
    );
\axi_bid_int[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A888AAAAA8888888"
    )
        port map (
      I0 => bid_fifo_not_empty,
      I1 => bid_gets_fifo_load_d1,
      I2 => s_axi_bready,
      I3 => axi_bvalid_int_reg,
      I4 => \axi_bid_int[0]_i_3_n_0\,
      I5 => \^bvalid_cnt_inc\,
      O => \axi_bid_int[0]_i_2_n_0\
    );
\axi_bid_int[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => bvalid_cnt(0),
      I1 => bvalid_cnt(2),
      I2 => bvalid_cnt(1),
      O => \axi_bid_int[0]_i_3_n_0\
    );
axi_bvalid_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000330022223000"
    )
        port map (
      I0 => clr_bram_we_cmb6_out,
      I1 => \out\(1),
      I2 => \^axi_wdata_full_cmb115_out\,
      I3 => \^bvalid_cnt_inc11_out\,
      I4 => \out\(2),
      I5 => \out\(0),
      O => \^bvalid_cnt_inc\
    );
axi_bvalid_int_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE000000"
    )
        port map (
      I0 => bvalid_cnt(1),
      I1 => bvalid_cnt(2),
      I2 => bvalid_cnt(0),
      I3 => axi_bvalid_int_reg,
      I4 => s_axi_bready,
      O => \^bid_gets_fifo_load_d1_reg_1\
    );
axi_bvalid_int_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5504"
    )
        port map (
      I0 => axi_wr_burst,
      I1 => axi_awaddr_full,
      I2 => \^bid_gets_fifo_load_d1_reg\,
      I3 => \^axi_wdata_full_cmb115_out\,
      O => clr_bram_we_cmb6_out
    );
axi_bvalid_int_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F7F007F007F00"
    )
        port map (
      I0 => bvalid_cnt(1),
      I1 => bvalid_cnt(2),
      I2 => bvalid_cnt(0),
      I3 => aw_active,
      I4 => s_axi_awvalid,
      I5 => s_axi_awready,
      O => \^axi_wdata_full_cmb115_out\
    );
axi_bvalid_int_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => s_axi_wlast,
      O => \^bvalid_cnt_inc11_out\
    );
bid_gets_fifo_load_d1_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000040000005500"
    )
        port map (
      I0 => \^bid_gets_fifo_load_d1_reg\,
      I1 => \^bid_gets_fifo_load_d1_reg_1\,
      I2 => bid_fifo_not_empty,
      I3 => \^bvalid_cnt_inc\,
      I4 => \bvalid_cnt_reg[1]\,
      I5 => bvalid_cnt(0),
      O => \^bid_gets_fifo_load\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_ua_narrow is
  port (
    CO : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\ : out STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[2]\ : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DI : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\ : in STD_LOGIC;
    \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_AW_PIPE_DUAL.axi_awburst_pipe_reg[0]\ : in STD_LOGIC;
    curr_narrow_burst_cmb : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[0]\ : in STD_LOGIC;
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awaddr_full : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg[0]\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg[1]\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]_0\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg[2]\ : in STD_LOGIC
  );
end axi_bram_ctrl_0_ua_narrow;

architecture STRUCTURE of axi_bram_ctrl_0_ua_narrow is
  signal \^co\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GEN_NARROW_CNT.narrow_addr_int[1]_i_2_n_0\ : STD_LOGIC;
  signal \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\ : STD_LOGIC;
  signal ua_narrow_load1_carry_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_n_1 : STD_LOGIC;
  signal ua_narrow_load1_carry_n_2 : STD_LOGIC;
  signal ua_narrow_load1_carry_n_3 : STD_LOGIC;
  signal NLW_ua_narrow_load1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ua_narrow_load1_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_ua_narrow_load1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
begin
  CO(0) <= \^co\(0);
  \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\ <= \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\;
\GEN_NARROW_CNT.narrow_addr_int[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9F90"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[1]_i_2_n_0\,
      O => D(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888B888B8B888B8"
    )
        port map (
      I0 => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\(0),
      I1 => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_reg[0]\,
      I2 => \^co\(0),
      I3 => curr_narrow_burst_cmb,
      I4 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\,
      I5 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[0]\,
      O => \GEN_NARROW_CNT.narrow_addr_int[1]_i_2_n_0\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_awsize(1),
      I1 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\(1),
      I2 => s_axi_awsize(2),
      I3 => axi_awaddr_full,
      I4 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\(2),
      O => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\
    );
ua_narrow_load1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ua_narrow_load1_carry_n_0,
      CO(2) => ua_narrow_load1_carry_n_1,
      CO(1) => ua_narrow_load1_carry_n_2,
      CO(0) => ua_narrow_load1_carry_n_3,
      CYINIT => '1',
      DI(3) => '0',
      DI(2 downto 0) => DI(2 downto 0),
      O(3 downto 0) => NLW_ua_narrow_load1_carry_O_UNCONNECTED(3 downto 0),
      S(3 downto 0) => S(3 downto 0)
    );
\ua_narrow_load1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => ua_narrow_load1_carry_n_0,
      CO(3 downto 1) => \NLW_ua_narrow_load1_carry__0_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \^co\(0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_ua_narrow_load1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 1) => B"000",
      S(0) => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]\(0)
    );
ua_narrow_load1_carry_i_34: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFCF305050CF30"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\(0),
      I1 => s_axi_awsize(0),
      I2 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]_0\,
      I3 => s_axi_awaddr(2),
      I4 => axi_awaddr_full,
      I5 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg[2]\,
      O => \GEN_NARROW_CNT.narrow_addr_int_reg[2]\(2)
    );
ua_narrow_load1_carry_i_35: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5F5F3FC0A0A03FC0"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\(0),
      I1 => s_axi_awsize(0),
      I2 => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\,
      I3 => s_axi_awaddr(1),
      I4 => axi_awaddr_full,
      I5 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg[1]\,
      O => \GEN_NARROW_CNT.narrow_addr_int_reg[2]\(1)
    );
ua_narrow_load1_carry_i_36: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFCF305050CF30"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\(0),
      I1 => s_axi_awsize(0),
      I2 => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\,
      I3 => s_axi_awaddr(0),
      I4 => axi_awaddr_full,
      I5 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg[0]\,
      O => \GEN_NARROW_CNT.narrow_addr_int_reg[2]\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_ua_narrow_0 is
  port (
    D : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \GEN_NARROW_CNT.narrow_addr_int_reg[1]\ : out STD_LOGIC;
    \wrap_burst_total_reg[1]\ : out STD_LOGIC;
    \wrap_burst_total_reg[1]_0\ : out STD_LOGIC;
    \wrap_burst_total_reg[0]\ : out STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[1]_0\ : out STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[2]\ : out STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[3]\ : out STD_LOGIC;
    \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\ : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_NARROW_CNT.narrow_addr_int_reg[0]\ : in STD_LOGIC;
    \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_araddr_full_reg\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_NARROW_CNT.narrow_addr_int_reg[1]_1\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\ : in STD_LOGIC;
    size_plus_lsb : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_araddr_full : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg[0]\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg[1]\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg[2]\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axi_bram_ctrl_0_ua_narrow_0 : entity is "ua_narrow";
end axi_bram_ctrl_0_ua_narrow_0;

architecture STRUCTURE of axi_bram_ctrl_0_ua_narrow_0 is
  signal \GEN_NARROW_CNT.narrow_addr_int[0]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_3__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_24__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_25__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_26__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_27__0_n_0\ : STD_LOGIC;
  signal \^gen_narrow_cnt.narrow_addr_int_reg[1]\ : STD_LOGIC;
  signal \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\ : STD_LOGIC;
  signal \^gen_narrow_cnt.narrow_addr_int_reg[2]\ : STD_LOGIC;
  signal \^gen_narrow_cnt.narrow_addr_int_reg[3]\ : STD_LOGIC;
  signal \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\ : STD_LOGIC;
  signal \ua_narrow_load1_carry__0_i_1__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry__0_n_3\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_10__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_11__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_16__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_17__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_18__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_19__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_1__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_20__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_21__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_2__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_3__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_4__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_5__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_6__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_7__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_8__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_9__0_n_0\ : STD_LOGIC;
  signal ua_narrow_load1_carry_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_n_1 : STD_LOGIC;
  signal ua_narrow_load1_carry_n_2 : STD_LOGIC;
  signal ua_narrow_load1_carry_n_3 : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[1]\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[1]_0\ : STD_LOGIC;
  signal NLW_ua_narrow_load1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ua_narrow_load1_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_ua_narrow_load1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[3]_i_2__0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \ua_narrow_load1_carry_i_12__0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_3__0\ : label is "soft_lutpair1";
begin
  \GEN_NARROW_CNT.narrow_addr_int_reg[1]\ <= \^gen_narrow_cnt.narrow_addr_int_reg[1]\;
  \GEN_NARROW_CNT.narrow_addr_int_reg[1]_0\ <= \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\;
  \GEN_NARROW_CNT.narrow_addr_int_reg[2]\ <= \^gen_narrow_cnt.narrow_addr_int_reg[2]\;
  \GEN_NARROW_CNT.narrow_addr_int_reg[3]\ <= \^gen_narrow_cnt.narrow_addr_int_reg[3]\;
  \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\ <= \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\;
  \wrap_burst_total_reg[0]\ <= \^wrap_burst_total_reg[0]\;
  \wrap_burst_total_reg[1]\ <= \^wrap_burst_total_reg[1]\;
  \wrap_burst_total_reg[1]_0\ <= \^wrap_burst_total_reg[1]_0\;
\GEN_NARROW_CNT.narrow_addr_int[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7477744474447444"
    )
        port map (
      I0 => Q(0),
      I1 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\,
      I2 => \GEN_AR_PIPE_DUAL.axi_araddr_full_reg\(0),
      I3 => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\,
      I4 => \ua_narrow_load1_carry__0_n_3\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[0]_i_2_n_0\,
      O => D(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0004FFFF"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_8__0_n_0\,
      I1 => \^wrap_burst_total_reg[1]_0\,
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => \^wrap_burst_total_reg[0]\,
      I4 => \^gen_narrow_cnt.narrow_addr_int_reg[1]\,
      O => \GEN_NARROW_CNT.narrow_addr_int[0]_i_2_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9F909F9F9F909090"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\,
      I3 => \GEN_AR_PIPE_DUAL.axi_araddr_full_reg\(1),
      I4 => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0_n_0\,
      O => D(1)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8828888822822222"
    )
        port map (
      I0 => \ua_narrow_load1_carry__0_n_3\,
      I1 => \^gen_narrow_cnt.narrow_addr_int_reg[1]\,
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => \^wrap_burst_total_reg[1]_0\,
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6F606F6F6F606060"
    )
        port map (
      I0 => Q(2),
      I1 => \GEN_NARROW_CNT.narrow_addr_int_reg[1]_1\,
      I2 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\,
      I3 => \GEN_AR_PIPE_DUAL.axi_araddr_full_reg\(2),
      I4 => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[2]_i_3__0_n_0\,
      O => D(2)
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2A0A028280A0A828"
    )
        port map (
      I0 => \ua_narrow_load1_carry__0_n_3\,
      I1 => \^gen_narrow_cnt.narrow_addr_int_reg[1]\,
      I2 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\,
      I3 => \^wrap_burst_total_reg[0]\,
      I4 => \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\,
      I5 => \^gen_narrow_cnt.narrow_addr_int_reg[2]\,
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_3__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_17__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"50535C5F"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_24__0_n_0\,
      I1 => \^wrap_burst_total_reg[1]\,
      I2 => \^wrap_burst_total_reg[1]_0\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_25__0_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_26__0_n_0\,
      O => \^gen_narrow_cnt.narrow_addr_int_reg[2]\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_18__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"111DDDDD"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_27__0_n_0\,
      I1 => \^wrap_burst_total_reg[1]_0\,
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => \^wrap_burst_total_reg[0]\,
      I4 => \ua_narrow_load1_carry_i_8__0_n_0\,
      O => \^gen_narrow_cnt.narrow_addr_int_reg[1]\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_24__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => \^wrap_burst_total_reg[1]\,
      I2 => size_plus_lsb(7),
      I3 => \^wrap_burst_total_reg[0]\,
      I4 => size_plus_lsb(6),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_24__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_25__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(3),
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(0),
      I4 => size_plus_lsb(2),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_25__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_26__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(5),
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(0),
      I4 => size_plus_lsb(4),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_26__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_27__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(3),
      I1 => size_plus_lsb(2),
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => size_plus_lsb(1),
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => size_plus_lsb(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_27__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A888A888AA8AA888"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int_reg[0]\,
      I1 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\,
      I2 => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\,
      I3 => \GEN_AR_PIPE_DUAL.axi_araddr_full_reg\(3),
      I4 => \ua_narrow_load1_carry__0_n_3\,
      I5 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\,
      O => D(3)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[3]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_arsize(2),
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(2),
      I2 => s_axi_arsize(1),
      I3 => axi_araddr_full,
      I4 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(1),
      O => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\
    );
ua_narrow_load1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ua_narrow_load1_carry_n_0,
      CO(2) => ua_narrow_load1_carry_n_1,
      CO(1) => ua_narrow_load1_carry_n_2,
      CO(0) => ua_narrow_load1_carry_n_3,
      CYINIT => '1',
      DI(3) => '0',
      DI(2) => \ua_narrow_load1_carry_i_1__0_n_0\,
      DI(1) => \ua_narrow_load1_carry_i_2__0_n_0\,
      DI(0) => \ua_narrow_load1_carry_i_3__0_n_0\,
      O(3 downto 0) => NLW_ua_narrow_load1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => \ua_narrow_load1_carry_i_4__0_n_0\,
      S(2) => \ua_narrow_load1_carry_i_5__0_n_0\,
      S(1) => \ua_narrow_load1_carry_i_6__0_n_0\,
      S(0) => \ua_narrow_load1_carry_i_7__0_n_0\
    );
\ua_narrow_load1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => ua_narrow_load1_carry_n_0,
      CO(3 downto 1) => \NLW_ua_narrow_load1_carry__0_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \ua_narrow_load1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_ua_narrow_load1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 1) => B"000",
      S(0) => \ua_narrow_load1_carry__0_i_1__0_n_0\
    );
\ua_narrow_load1_carry__0_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFB8FFFFFFFF"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(1),
      I3 => \^wrap_burst_total_reg[1]_0\,
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => size_plus_lsb(8),
      O => \ua_narrow_load1_carry__0_i_1__0_n_0\
    );
\ua_narrow_load1_carry_i_10__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFDDDFFFDF"
    )
        port map (
      I0 => \^gen_narrow_cnt.narrow_addr_int_reg[2]\,
      I1 => \^wrap_burst_total_reg[0]\,
      I2 => s_axi_arsize(1),
      I3 => axi_araddr_full,
      I4 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(1),
      I5 => \^wrap_burst_total_reg[1]_0\,
      O => \ua_narrow_load1_carry_i_10__0_n_0\
    );
\ua_narrow_load1_carry_i_11__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4C7F4F7"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_18__0_n_0\,
      I1 => \^wrap_burst_total_reg[1]\,
      I2 => \^wrap_burst_total_reg[1]_0\,
      I3 => \ua_narrow_load1_carry_i_19__0_n_0\,
      I4 => \ua_narrow_load1_carry_i_20__0_n_0\,
      O => \ua_narrow_load1_carry_i_11__0_n_0\
    );
\ua_narrow_load1_carry_i_12__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_9__0_n_0\,
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(2),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(2),
      I4 => \ua_narrow_load1_carry_i_21__0_n_0\,
      O => \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\
    );
\ua_narrow_load1_carry_i_15__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF55FF550FCC0F33"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_20__0_n_0\,
      I1 => \ua_narrow_load1_carry_i_19__0_n_0\,
      I2 => \ua_narrow_load1_carry_i_18__0_n_0\,
      I3 => \^wrap_burst_total_reg[1]\,
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => \^wrap_burst_total_reg[1]_0\,
      O => \^gen_narrow_cnt.narrow_addr_int_reg[3]\
    );
\ua_narrow_load1_carry_i_16__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00004540FFFFBABF"
    )
        port map (
      I0 => \^wrap_burst_total_reg[1]_0\,
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(1),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(1),
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => \^gen_narrow_cnt.narrow_addr_int_reg[2]\,
      O => \ua_narrow_load1_carry_i_16__0_n_0\
    );
\ua_narrow_load1_carry_i_17__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E20000FF1DFFFF"
    )
        port map (
      I0 => s_axi_arsize(1),
      I1 => axi_araddr_full,
      I2 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(1),
      I3 => \^wrap_burst_total_reg[1]_0\,
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\,
      O => \ua_narrow_load1_carry_i_17__0_n_0\
    );
\ua_narrow_load1_carry_i_18__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(6),
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(0),
      I4 => size_plus_lsb(5),
      O => \ua_narrow_load1_carry_i_18__0_n_0\
    );
\ua_narrow_load1_carry_i_19__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(4),
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(0),
      I4 => size_plus_lsb(3),
      O => \ua_narrow_load1_carry_i_19__0_n_0\
    );
\ua_narrow_load1_carry_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \^wrap_burst_total_reg[1]\,
      I1 => \^wrap_burst_total_reg[0]\,
      I2 => \ua_narrow_load1_carry_i_8__0_n_0\,
      I3 => \^wrap_burst_total_reg[1]_0\,
      I4 => \ua_narrow_load1_carry_i_9__0_n_0\,
      O => \ua_narrow_load1_carry_i_1__0_n_0\
    );
\ua_narrow_load1_carry_i_20__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I2 => axi_araddr_full,
      I3 => s_axi_arsize(0),
      I4 => size_plus_lsb(7),
      O => \ua_narrow_load1_carry_i_20__0_n_0\
    );
\ua_narrow_load1_carry_i_21__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(4),
      I1 => size_plus_lsb(3),
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => size_plus_lsb(2),
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => size_plus_lsb(1),
      O => \ua_narrow_load1_carry_i_21__0_n_0\
    );
\ua_narrow_load1_carry_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44444D44"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_10__0_n_0\,
      I1 => \ua_narrow_load1_carry_i_11__0_n_0\,
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => \^wrap_burst_total_reg[0]\,
      I4 => \^wrap_burst_total_reg[1]_0\,
      O => \ua_narrow_load1_carry_i_2__0_n_0\
    );
ua_narrow_load1_carry_i_31: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFB040404FB04"
    )
        port map (
      I0 => \^wrap_burst_total_reg[0]\,
      I1 => \^wrap_burst_total_reg[1]\,
      I2 => \^wrap_burst_total_reg[1]_0\,
      I3 => s_axi_araddr(2),
      I4 => axi_araddr_full,
      I5 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg[2]\,
      O => S(2)
    );
ua_narrow_load1_carry_i_32: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFB040404FB04"
    )
        port map (
      I0 => \^wrap_burst_total_reg[1]\,
      I1 => \^wrap_burst_total_reg[0]\,
      I2 => \^wrap_burst_total_reg[1]_0\,
      I3 => s_axi_araddr(1),
      I4 => axi_araddr_full,
      I5 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg[1]\,
      O => S(1)
    );
ua_narrow_load1_carry_i_33: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFCF305050CF30"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I1 => s_axi_arsize(0),
      I2 => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[3]\,
      I3 => s_axi_araddr(0),
      I4 => axi_araddr_full,
      I5 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg[0]\,
      O => S(0)
    );
\ua_narrow_load1_carry_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000818"
    )
        port map (
      I0 => \^wrap_burst_total_reg[0]\,
      I1 => \^wrap_burst_total_reg[1]\,
      I2 => \^wrap_burst_total_reg[1]_0\,
      I3 => \ua_narrow_load1_carry_i_8__0_n_0\,
      I4 => \^gen_narrow_cnt.narrow_addr_int_reg[1]_0\,
      O => \ua_narrow_load1_carry_i_3__0_n_0\
    );
\ua_narrow_load1_carry_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFBBABAFAFBBABF"
    )
        port map (
      I0 => \^wrap_burst_total_reg[1]_0\,
      I1 => size_plus_lsb(8),
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => size_plus_lsb(7),
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => size_plus_lsb(6),
      O => \ua_narrow_load1_carry_i_4__0_n_0\
    );
\ua_narrow_load1_carry_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0C1F0F1F5C4F5F4"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_9__0_n_0\,
      I1 => \^wrap_burst_total_reg[1]\,
      I2 => \^wrap_burst_total_reg[1]_0\,
      I3 => \^wrap_burst_total_reg[0]\,
      I4 => size_plus_lsb(8),
      I5 => \ua_narrow_load1_carry_i_8__0_n_0\,
      O => \ua_narrow_load1_carry_i_5__0_n_0\
    );
\ua_narrow_load1_carry_i_6__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^gen_narrow_cnt.narrow_addr_int_reg[3]\,
      I1 => \ua_narrow_load1_carry_i_16__0_n_0\,
      O => \ua_narrow_load1_carry_i_6__0_n_0\
    );
\ua_narrow_load1_carry_i_7__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_17__0_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[0]_i_2_n_0\,
      O => \ua_narrow_load1_carry_i_7__0_n_0\
    );
\ua_narrow_load1_carry_i_8__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(7),
      I1 => size_plus_lsb(6),
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => size_plus_lsb(5),
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => size_plus_lsb(4),
      O => \ua_narrow_load1_carry_i_8__0_n_0\
    );
\ua_narrow_load1_carry_i_9__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => size_plus_lsb(7),
      I2 => \^wrap_burst_total_reg[1]\,
      I3 => size_plus_lsb(6),
      I4 => \^wrap_burst_total_reg[0]\,
      I5 => size_plus_lsb(5),
      O => \ua_narrow_load1_carry_i_9__0_n_0\
    );
\wrap_burst_total[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(2),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(2),
      O => \^wrap_burst_total_reg[1]_0\
    );
\wrap_burst_total[1]_i_3__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(1),
      O => \^wrap_burst_total_reg[1]\
    );
\wrap_burst_total[1]_i_5__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(0),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(0),
      O => \^wrap_burst_total_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_wrap_brst is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\ : out STD_LOGIC;
    curr_narrow_burst_cmb : out STD_LOGIC;
    curr_fixed_burst_reg_reg : out STD_LOGIC;
    bram_addr_ld_en_mod : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 9 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \wrap_burst_total_reg[0]_0\ : out STD_LOGIC;
    \wrap_burst_total_reg[0]_1\ : out STD_LOGIC;
    \wrap_burst_total_reg[0]_2\ : out STD_LOGIC;
    \wrap_burst_total_reg[1]_0\ : out STD_LOGIC;
    \wrap_burst_total_reg[1]_1\ : out STD_LOGIC;
    \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\ : out STD_LOGIC;
    DI : out STD_LOGIC_VECTOR ( 0 to 0 );
    curr_awlen_reg_1_or_2_reg : out STD_LOGIC;
    \wrap_burst_total_reg[0]_3\ : out STD_LOGIC;
    curr_wrap_burst_reg_reg : out STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awaddr_full : in STD_LOGIC;
    s_axi_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \GEN_AW_DUAL.wr_addr_sm_cs_reg\ : in STD_LOGIC;
    curr_fixed_burst_reg : in STD_LOGIC;
    curr_fixed_burst : in STD_LOGIC;
    bram_addr_rst_cmb : in STD_LOGIC;
    curr_narrow_burst : in STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[2]\ : in STD_LOGIC;
    narrow_bram_addr_inc_d1 : in STD_LOGIC;
    bram_addr_inc : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[8]\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg\ : in STD_LOGIC;
    curr_wrap_burst_reg : in STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[3]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GEN_AW_PIPE_DUAL.axi_awaddr_full_reg\ : in STD_LOGIC;
    \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[1]\ : in STD_LOGIC;
    bid_fifo_rst : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC
  );
end axi_bram_ctrl_0_wrap_brst;

architecture STRUCTURE of axi_bram_ctrl_0_wrap_brst is
  signal \^d\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \^di\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_5_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_6_n_0\ : STD_LOGIC;
  signal \^gen_dual_addr_cnt.bram_addr_int_reg[11]\ : STD_LOGIC;
  signal \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[1]\ : STD_LOGIC;
  signal bram_addr_ld : STD_LOGIC_VECTOR ( 11 downto 5 );
  signal \^bram_addr_ld_en_mod\ : STD_LOGIC;
  signal \^curr_awlen_reg_1_or_2_reg\ : STD_LOGIC;
  signal \^curr_narrow_burst_cmb\ : STD_LOGIC;
  signal save_init_bram_addr_ld : STD_LOGIC_VECTOR ( 13 downto 5 );
  signal \save_init_bram_addr_ld[13]_i_3_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[5]_i_2__0_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[6]_i_2__0_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[7]_i_2__0_n_0\ : STD_LOGIC;
  signal wrap_burst_total : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \wrap_burst_total[0]_i_2_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[0]_i_3_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[0]_i_5_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[1]_i_5_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[2]_i_1__0_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[2]_i_3__0_n_0\ : STD_LOGIC;
  signal wrap_burst_total_cmb : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^wrap_burst_total_reg[0]_0\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]_1\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]_2\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]_3\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[1]_0\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[1]_1\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_2\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of curr_awlen_reg_1_or_2_i_3 : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[5]_i_2__0\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[7]_i_2__0\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of ua_narrow_load1_carry_i_18 : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_2__0\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_3\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_4\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_5\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_6\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_7\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \wrap_burst_total[2]_i_1__0\ : label is "soft_lutpair96";
begin
  D(9 downto 0) <= \^d\(9 downto 0);
  DI(0) <= \^di\(0);
  E(0) <= \^e\(0);
  \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\ <= \^gen_dual_addr_cnt.bram_addr_int_reg[11]\;
  \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\ <= \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[1]\;
  bram_addr_ld_en_mod <= \^bram_addr_ld_en_mod\;
  curr_awlen_reg_1_or_2_reg <= \^curr_awlen_reg_1_or_2_reg\;
  curr_narrow_burst_cmb <= \^curr_narrow_burst_cmb\;
  \wrap_burst_total_reg[0]_0\ <= \^wrap_burst_total_reg[0]_0\;
  \wrap_burst_total_reg[0]_1\ <= \^wrap_burst_total_reg[0]_1\;
  \wrap_burst_total_reg[0]_2\ <= \^wrap_burst_total_reg[0]_2\;
  \wrap_burst_total_reg[0]_3\ <= \^wrap_burst_total_reg[0]_3\;
  \wrap_burst_total_reg[1]_0\ <= \^wrap_burst_total_reg[1]_0\;
  \wrap_burst_total_reg[1]_1\ <= \^wrap_burst_total_reg[1]_1\;
\GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B88BB8B8B8B8B8"
    )
        port map (
      I0 => bram_addr_ld(10),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(6),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(4),
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0_n_0\,
      I5 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(5),
      O => \^d\(6)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(0),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(1),
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(2),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(3),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAABBBFAAAA"
    )
        port map (
      I0 => \^bram_addr_ld_en_mod\,
      I1 => curr_narrow_burst,
      I2 => \GEN_NARROW_CNT.narrow_addr_int_reg[2]\,
      I3 => narrow_bram_addr_inc_d1,
      I4 => bram_addr_inc,
      I5 => curr_fixed_burst_reg,
      O => \^gen_dual_addr_cnt.bram_addr_int_reg[11]\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8BB8B8B8B8B8B8B8"
    )
        port map (
      I0 => bram_addr_ld(11),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(7),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(5),
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[8]\,
      I5 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(6),
      O => \^d\(7)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"01000000FFFFFFFF"
    )
        port map (
      I0 => \^gen_dual_addr_cnt.bram_addr_int_reg[11]\,
      I1 => s_axi_wvalid,
      I2 => \out\(2),
      I3 => \out\(0),
      I4 => \out\(1),
      I5 => s_axi_aresetn,
      O => SR(0)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"01000000FFFFFFFF"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_3_n_0\,
      I1 => \out\(1),
      I2 => \out\(2),
      I3 => \out\(0),
      I4 => s_axi_wvalid,
      I5 => \GEN_AW_DUAL.wr_addr_sm_cs_reg\,
      O => \^bram_addr_ld_en_mod\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F444FFFFFFFFF"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_4_n_0\,
      I1 => curr_narrow_burst,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_5_n_0\,
      I3 => \save_init_bram_addr_ld[7]_i_2__0_n_0\,
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0_n_0\,
      I5 => curr_wrap_burst_reg,
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_3_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => narrow_bram_addr_inc_d1,
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_6_n_0\,
      I2 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(3),
      I3 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(1),
      I4 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(0),
      I5 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(2),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_4_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000008F00A000"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(1),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(2),
      I2 => wrap_burst_total(1),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(0),
      I4 => wrap_burst_total(0),
      I5 => wrap_burst_total(2),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_5_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => \out\(0),
      I2 => \out\(2),
      I3 => \out\(1),
      I4 => curr_narrow_burst,
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_6_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"454045404540FFFF"
    )
        port map (
      I0 => \GEN_AW_DUAL.wr_addr_sm_cs_reg\,
      I1 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg\,
      I2 => axi_awaddr_full,
      I3 => s_axi_awaddr(0),
      I4 => \^bram_addr_ld_en_mod\,
      I5 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(0),
      O => \^d\(0)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8BB8"
    )
        port map (
      I0 => bram_addr_ld(5),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(0),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(1),
      O => \^d\(1)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BB8B8B8"
    )
        port map (
      I0 => bram_addr_ld(6),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(2),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(1),
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(0),
      O => \^d\(2)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8BB8B8B8B8B8B8B8"
    )
        port map (
      I0 => bram_addr_ld(7),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(3),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(2),
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(1),
      I5 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(0),
      O => \^d\(3)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B88B"
    )
        port map (
      I0 => bram_addr_ld(8),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0_n_0\,
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(4),
      O => \^d\(4)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B88BB8B8"
    )
        port map (
      I0 => bram_addr_ld(9),
      I1 => \^bram_addr_ld_en_mod\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(5),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2__0_n_0\,
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(4),
      O => \^d\(5)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(0),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(0),
      O => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[1]\
    );
curr_awlen_reg_1_or_2_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(3),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(3),
      O => \^curr_awlen_reg_1_or_2_reg\
    );
\curr_fixed_burst_reg_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D800D8000000D800"
    )
        port map (
      I0 => \GEN_AW_DUAL.wr_addr_sm_cs_reg\,
      I1 => curr_fixed_burst_reg,
      I2 => curr_fixed_burst,
      I3 => s_axi_aresetn,
      I4 => bram_addr_rst_cmb,
      I5 => \^gen_dual_addr_cnt.bram_addr_int_reg[11]\,
      O => curr_fixed_burst_reg_reg
    );
\curr_wrap_burst_reg_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888888888880"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awaddr_full_reg\,
      I1 => s_axi_aresetn,
      I2 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[1]\,
      I3 => \out\(2),
      I4 => s_axi_wvalid,
      I5 => \^gen_dual_addr_cnt.bram_addr_int_reg[11]\,
      O => curr_wrap_burst_reg_reg
    );
\save_init_bram_addr_ld[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(10),
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(6),
      O => bram_addr_ld(10)
    );
\save_init_bram_addr_ld[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(11),
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(7),
      O => bram_addr_ld(11)
    );
\save_init_bram_addr_ld[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(12),
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(8),
      O => \^d\(8)
    );
\save_init_bram_addr_ld[13]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \GEN_AW_DUAL.wr_addr_sm_cs_reg\,
      O => \^e\(0)
    );
\save_init_bram_addr_ld[13]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(13),
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(9),
      O => \^d\(9)
    );
\save_init_bram_addr_ld[13]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \GEN_AW_DUAL.wr_addr_sm_cs_reg\,
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_3_n_0\,
      O => \save_init_bram_addr_ld[13]_i_3_n_0\
    );
\save_init_bram_addr_ld[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \save_init_bram_addr_ld[5]_i_2__0_n_0\,
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(1),
      O => bram_addr_ld(5)
    );
\save_init_bram_addr_ld[5]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A282"
    )
        port map (
      I0 => save_init_bram_addr_ld(5),
      I1 => wrap_burst_total(1),
      I2 => wrap_burst_total(2),
      I3 => wrap_burst_total(0),
      O => \save_init_bram_addr_ld[5]_i_2__0_n_0\
    );
\save_init_bram_addr_ld[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \save_init_bram_addr_ld[6]_i_2__0_n_0\,
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(2),
      O => bram_addr_ld(6)
    );
\save_init_bram_addr_ld[6]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A28A"
    )
        port map (
      I0 => save_init_bram_addr_ld(6),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(2),
      I3 => wrap_burst_total(1),
      O => \save_init_bram_addr_ld[6]_i_2__0_n_0\
    );
\save_init_bram_addr_ld[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2F202F2F2F202020"
    )
        port map (
      I0 => save_init_bram_addr_ld(7),
      I1 => \save_init_bram_addr_ld[7]_i_2__0_n_0\,
      I2 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I3 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg\,
      I4 => axi_awaddr_full,
      I5 => s_axi_awaddr(3),
      O => bram_addr_ld(7)
    );
\save_init_bram_addr_ld[7]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => wrap_burst_total(0),
      I1 => wrap_burst_total(2),
      I2 => wrap_burst_total(1),
      O => \save_init_bram_addr_ld[7]_i_2__0_n_0\
    );
\save_init_bram_addr_ld[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(8),
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(4),
      O => bram_addr_ld(8)
    );
\save_init_bram_addr_ld[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(9),
      I1 => \save_init_bram_addr_ld[13]_i_3_n_0\,
      I2 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg\,
      I3 => axi_awaddr_full,
      I4 => s_axi_awaddr(5),
      O => bram_addr_ld(9)
    );
\save_init_bram_addr_ld_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(10),
      Q => save_init_bram_addr_ld(10),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(11),
      Q => save_init_bram_addr_ld(11),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => \^d\(8),
      Q => save_init_bram_addr_ld(12),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => \^d\(9),
      Q => save_init_bram_addr_ld(13),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(5),
      Q => save_init_bram_addr_ld(5),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(6),
      Q => save_init_bram_addr_ld(6),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(7),
      Q => save_init_bram_addr_ld(7),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(8),
      Q => save_init_bram_addr_ld(8),
      R => bid_fifo_rst
    );
\save_init_bram_addr_ld_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => bram_addr_ld(9),
      Q => save_init_bram_addr_ld(9),
      R => bid_fifo_rst
    );
ua_narrow_load1_carry_i_18: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000ACC0A"
    )
        port map (
      I0 => s_axi_awsize(1),
      I1 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(1),
      I2 => s_axi_awsize(2),
      I3 => axi_awaddr_full,
      I4 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(2),
      O => \^wrap_burst_total_reg[0]_3\
    );
\wrap_burst_total[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF9000"
    )
        port map (
      I0 => \^wrap_burst_total_reg[0]_0\,
      I1 => \^wrap_burst_total_reg[0]_1\,
      I2 => \^wrap_burst_total_reg[0]_2\,
      I3 => \wrap_burst_total[0]_i_2_n_0\,
      I4 => \wrap_burst_total[0]_i_3_n_0\,
      O => wrap_burst_total_cmb(0)
    );
\wrap_burst_total[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000004000444"
    )
        port map (
      I0 => \^wrap_burst_total_reg[1]_0\,
      I1 => \^wrap_burst_total_reg[1]_1\,
      I2 => Q(3),
      I3 => axi_awaddr_full,
      I4 => s_axi_awlen(3),
      I5 => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[1]\,
      O => \wrap_burst_total[0]_i_2_n_0\
    );
\wrap_burst_total[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8F88000F88880F00"
    )
        port map (
      I0 => \wrap_burst_total[2]_i_3__0_n_0\,
      I1 => \^di\(0),
      I2 => \wrap_burst_total[0]_i_5_n_0\,
      I3 => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[1]\,
      I4 => \^curr_awlen_reg_1_or_2_reg\,
      I5 => \^wrap_burst_total_reg[0]_0\,
      O => \wrap_burst_total[0]_i_3_n_0\
    );
\wrap_burst_total[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111050000000500"
    )
        port map (
      I0 => \^wrap_burst_total_reg[1]_1\,
      I1 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(0),
      I4 => axi_awaddr_full,
      I5 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(0),
      O => \^di\(0)
    );
\wrap_burst_total[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"757FF5FF7F7FFFFF"
    )
        port map (
      I0 => \^wrap_burst_total_reg[0]_3\,
      I1 => Q(1),
      I2 => axi_awaddr_full,
      I3 => s_axi_awlen(1),
      I4 => Q(0),
      I5 => s_axi_awlen(0),
      O => \wrap_burst_total[0]_i_5_n_0\
    );
\wrap_burst_total[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3008000000000000"
    )
        port map (
      I0 => \^wrap_burst_total_reg[0]_0\,
      I1 => \^wrap_burst_total_reg[1]_0\,
      I2 => \^wrap_burst_total_reg[1]_1\,
      I3 => \wrap_burst_total[1]_i_5_n_0\,
      I4 => \^wrap_burst_total_reg[0]_2\,
      I5 => \^wrap_burst_total_reg[0]_1\,
      O => wrap_burst_total_cmb(1)
    );
\wrap_burst_total[1]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(2),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(2),
      O => \^wrap_burst_total_reg[0]_0\
    );
\wrap_burst_total[1]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(1),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(1),
      O => \^wrap_burst_total_reg[1]_0\
    );
\wrap_burst_total[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(2),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(2),
      O => \^wrap_burst_total_reg[1]_1\
    );
\wrap_burst_total[1]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_awsize(0),
      I1 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(0),
      I2 => s_axi_awlen(3),
      I3 => axi_awaddr_full,
      I4 => Q(3),
      O => \wrap_burst_total[1]_i_5_n_0\
    );
\wrap_burst_total[1]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(0),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(0),
      O => \^wrap_burst_total_reg[0]_2\
    );
\wrap_burst_total[1]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(1),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(1),
      O => \^wrap_burst_total_reg[0]_1\
    );
\wrap_burst_total[2]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"40444000"
    )
        port map (
      I0 => \^curr_narrow_burst_cmb\,
      I1 => \wrap_burst_total[2]_i_3__0_n_0\,
      I2 => Q(3),
      I3 => axi_awaddr_full,
      I4 => s_axi_awlen(3),
      O => \wrap_burst_total[2]_i_1__0_n_0\
    );
\wrap_burst_total[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEFAFFFFFFFAFF"
    )
        port map (
      I0 => \^gen_narrow_cnt_ld.narrow_burst_cnt_ld_reg_reg[1]\,
      I1 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(2),
      I4 => axi_awaddr_full,
      I5 => \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(2),
      O => \^curr_narrow_burst_cmb\
    );
\wrap_burst_total[2]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C000A0A0C0000000"
    )
        port map (
      I0 => s_axi_awlen(0),
      I1 => Q(0),
      I2 => \^wrap_burst_total_reg[0]_0\,
      I3 => Q(1),
      I4 => axi_awaddr_full,
      I5 => s_axi_awlen(1),
      O => \wrap_burst_total[2]_i_3__0_n_0\
    );
\wrap_burst_total_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => wrap_burst_total_cmb(0),
      Q => wrap_burst_total(0),
      R => bid_fifo_rst
    );
\wrap_burst_total_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => wrap_burst_total_cmb(1),
      Q => wrap_burst_total(1),
      R => bid_fifo_rst
    );
\wrap_burst_total_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^e\(0),
      D => \wrap_burst_total[2]_i_1__0_n_0\,
      Q => wrap_burst_total(2),
      R => bid_fifo_rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_wrap_brst_1 is
  port (
    bram_addr_ld_en : out STD_LOGIC;
    DI : out STD_LOGIC_VECTOR ( 0 to 0 );
    \save_init_bram_addr_ld_reg[13]_0\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 1 downto 0 );
    D : out STD_LOGIC_VECTOR ( 9 downto 0 );
    \save_init_bram_addr_ld_reg[13]_1\ : out STD_LOGIC;
    \brst_cnt_reg[3]\ : out STD_LOGIC;
    bram_en_int_reg : out STD_LOGIC;
    \wrap_burst_total_reg[0]_0\ : out STD_LOGIC;
    \wrap_burst_total_reg[0]_1\ : out STD_LOGIC;
    \wrap_burst_total_reg[0]_2\ : out STD_LOGIC;
    \wrap_burst_total_reg[0]_3\ : out STD_LOGIC;
    axi_rd_burst_two_reg : out STD_LOGIC;
    size_plus_lsb0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    rd_addr_sm_cs : in STD_LOGIC;
    no_ar_ack : in STD_LOGIC;
    pend_rd_op_reg : in STD_LOGIC;
    ar_active : in STD_LOGIC;
    axi_araddr_full : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arsize : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\ : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    curr_fixed_burst_reg : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[9]\ : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg\ : in STD_LOGIC;
    axi_aresetn_d2 : in STD_LOGIC;
    last_bram_addr : in STD_LOGIC;
    disable_b2b_brst : in STD_LOGIC;
    axi_arsize_pipe_max : in STD_LOGIC;
    axi_arlen_pipe_1_or_2 : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg\ : in STD_LOGIC;
    brst_zero : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    axi_rvalid_int_reg : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg\ : in STD_LOGIC;
    curr_wrap_burst_reg : in STD_LOGIC;
    \GEN_NARROW_CNT.narrow_addr_int_reg[3]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    narrow_bram_addr_inc_d1 : in STD_LOGIC;
    curr_narrow_burst : in STD_LOGIC;
    \rd_data_sm_cs_reg[3]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    end_brst_rd : in STD_LOGIC;
    axi_b2b_brst : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\ : in STD_LOGIC;
    \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_rd_burst : in STD_LOGIC;
    axi_rd_burst_two_reg_0 : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of axi_bram_ctrl_0_wrap_brst_1 : entity is "wrap_brst";
end axi_bram_ctrl_0_wrap_brst_1;

architecture STRUCTURE of axi_bram_ctrl_0_wrap_brst_1 is
  signal \^d\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \^di\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3__0_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_5_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_10__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_8__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_9__0_n_0\ : STD_LOGIC;
  signal \^axi_rd_burst_two_reg\ : STD_LOGIC;
  signal bram_addr_ld : STD_LOGIC_VECTOR ( 11 downto 5 );
  signal \^bram_addr_ld_en\ : STD_LOGIC;
  signal \^bram_en_int_reg\ : STD_LOGIC;
  signal \^brst_cnt_reg[3]\ : STD_LOGIC;
  signal save_init_bram_addr_ld : STD_LOGIC_VECTOR ( 13 downto 5 );
  signal \save_init_bram_addr_ld[13]_i_3__0_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[13]_i_5_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[13]_i_6_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[13]_i_7_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[13]_i_8_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[5]_i_2_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[6]_i_2_n_0\ : STD_LOGIC;
  signal \save_init_bram_addr_ld[7]_i_2_n_0\ : STD_LOGIC;
  signal \^save_init_bram_addr_ld_reg[13]_0\ : STD_LOGIC;
  signal \^save_init_bram_addr_ld_reg[13]_1\ : STD_LOGIC;
  signal \^size_plus_lsb0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal wrap_burst_total : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \wrap_burst_total[0]_i_3__0_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[0]_i_4__0_n_0\ : STD_LOGIC;
  signal \wrap_burst_total[2]_i_4_n_0\ : STD_LOGIC;
  signal wrap_burst_total_cmb : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^wrap_burst_total_reg[0]_0\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]_1\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]_2\ : STD_LOGIC;
  signal \^wrap_burst_total_reg[0]_3\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_2__0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_10__0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of axi_rd_burst_two_i_3 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[13]_i_5\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[5]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[7]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_4__0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \wrap_burst_total[2]_i_3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \wrap_burst_total[2]_i_4\ : label is "soft_lutpair3";
begin
  D(9 downto 0) <= \^d\(9 downto 0);
  DI(0) <= \^di\(0);
  axi_rd_burst_two_reg <= \^axi_rd_burst_two_reg\;
  bram_addr_ld_en <= \^bram_addr_ld_en\;
  bram_en_int_reg <= \^bram_en_int_reg\;
  \brst_cnt_reg[3]\ <= \^brst_cnt_reg[3]\;
  \save_init_bram_addr_ld_reg[13]_0\ <= \^save_init_bram_addr_ld_reg[13]_0\;
  \save_init_bram_addr_ld_reg[13]_1\ <= \^save_init_bram_addr_ld_reg[13]_1\;
  size_plus_lsb0(0) <= \^size_plus_lsb0\(0);
  \wrap_burst_total_reg[0]_0\ <= \^wrap_burst_total_reg[0]_0\;
  \wrap_burst_total_reg[0]_1\ <= \^wrap_burst_total_reg[0]_1\;
  \wrap_burst_total_reg[0]_2\ <= \^wrap_burst_total_reg[0]_2\;
  \wrap_burst_total_reg[0]_3\ <= \^wrap_burst_total_reg[0]_3\;
\GEN_AWREADY.axi_awready_int_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_aresetn,
      O => \^save_init_bram_addr_ld_reg[13]_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAFFFF6AAA0000"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(6),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(4),
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2_n_0\,
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(5),
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I5 => bram_addr_ld(10),
      O => \^d\(6)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(3),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(1),
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(0),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(2),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"1F"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3__0_n_0\,
      I1 => curr_fixed_burst_reg,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      O => E(0)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AFF6A00"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(7),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[9]\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(6),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I4 => bram_addr_ld(11),
      O => \^d\(7)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFDFF00"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_5_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(3),
      I2 => narrow_bram_addr_inc_d1,
      I3 => \^brst_cnt_reg[3]\,
      I4 => curr_narrow_burst,
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3__0_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(0),
      I1 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(1),
      I2 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(2),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_5_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      O => E(1)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^bram_addr_ld_en\,
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[4]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000DDD111D1"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(0),
      I1 => \^bram_addr_ld_en\,
      I2 => s_axi_araddr(0),
      I3 => axi_araddr_full,
      I4 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg\,
      I5 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      O => \^d\(0)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[5]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6F60"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(1),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(0),
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I3 => bram_addr_ld(5),
      O => \^d\(1)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[6]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AFF6A00"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(2),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(0),
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(1),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I4 => bram_addr_ld(6),
      O => \^d\(2)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[7]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAFFFF6AAA0000"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(3),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(1),
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(0),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(2),
      I4 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I5 => bram_addr_ld(7),
      O => \^d\(3)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[8]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6F60"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(4),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2_n_0\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I3 => bram_addr_ld(8),
      O => \^d\(4)
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[9]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AFF6A00"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(5),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2_n_0\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(4),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int[13]_i_2__0_n_0\,
      I4 => bram_addr_ld(9),
      O => \^d\(5)
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_10__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \rd_data_sm_cs_reg[3]\(0),
      I1 => axi_rd_burst_two_reg_0,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_10__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F0E0E0F0FFE0E0"
    )
        port map (
      I0 => \^bram_en_int_reg\,
      I1 => \rd_data_sm_cs_reg[3]\(3),
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_8__0_n_0\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_9__0_n_0\,
      I4 => \rd_data_sm_cs_reg[3]\(1),
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_10__0_n_0\,
      O => \^brst_cnt_reg[3]\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_8__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF0FFF0FFF1FFFF"
    )
        port map (
      I0 => axi_rd_burst,
      I1 => axi_rd_burst_two_reg_0,
      I2 => \rd_data_sm_cs_reg[3]\(2),
      I3 => \rd_data_sm_cs_reg[3]\(3),
      I4 => \rd_data_sm_cs_reg[3]\(0),
      I5 => \rd_data_sm_cs_reg[3]\(1),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_8__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_9__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0D00000000000000"
    )
        port map (
      I0 => end_brst_rd,
      I1 => axi_b2b_brst,
      I2 => brst_zero,
      I3 => axi_rvalid_int_reg,
      I4 => s_axi_rready,
      I5 => \rd_data_sm_cs_reg[3]\(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_9__0_n_0\
    );
axi_rd_burst_two_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(0),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(0),
      O => \^axi_rd_burst_two_reg\
    );
bram_en_int_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEFFFFFFFFFFFFF"
    )
        port map (
      I0 => end_brst_rd,
      I1 => brst_zero,
      I2 => \rd_data_sm_cs_reg[3]\(2),
      I3 => \rd_data_sm_cs_reg[3]\(0),
      I4 => axi_rvalid_int_reg,
      I5 => s_axi_rready,
      O => \^bram_en_int_reg\
    );
\save_init_bram_addr_ld[10]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(10),
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(6),
      O => bram_addr_ld(10)
    );
\save_init_bram_addr_ld[11]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(11),
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(7),
      O => bram_addr_ld(11)
    );
\save_init_bram_addr_ld[12]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(12),
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(8),
      O => \^d\(8)
    );
\save_init_bram_addr_ld[13]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888A888888888"
    )
        port map (
      I0 => axi_aresetn_d2,
      I1 => \save_init_bram_addr_ld[13]_i_3__0_n_0\,
      I2 => \^save_init_bram_addr_ld_reg[13]_1\,
      I3 => \save_init_bram_addr_ld[13]_i_5_n_0\,
      I4 => \save_init_bram_addr_ld[13]_i_6_n_0\,
      I5 => last_bram_addr,
      O => \^bram_addr_ld_en\
    );
\save_init_bram_addr_ld[13]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(13),
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(9),
      O => \^d\(9)
    );
\save_init_bram_addr_ld[13]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000100010000"
    )
        port map (
      I0 => rd_addr_sm_cs,
      I1 => no_ar_ack,
      I2 => pend_rd_op_reg,
      I3 => ar_active,
      I4 => axi_araddr_full,
      I5 => s_axi_arvalid,
      O => \save_init_bram_addr_ld[13]_i_3__0_n_0\
    );
\save_init_bram_addr_ld[13]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000040"
    )
        port map (
      I0 => disable_b2b_brst,
      I1 => axi_arsize_pipe_max,
      I2 => axi_araddr_full,
      I3 => axi_arlen_pipe_1_or_2,
      I4 => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg\,
      O => \^save_init_bram_addr_ld_reg[13]_1\
    );
\save_init_bram_addr_ld[13]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => \rd_data_sm_cs_reg[3]\(3),
      I1 => \rd_data_sm_cs_reg[3]\(2),
      I2 => \rd_data_sm_cs_reg[3]\(1),
      I3 => \rd_data_sm_cs_reg[3]\(0),
      O => \save_init_bram_addr_ld[13]_i_5_n_0\
    );
\save_init_bram_addr_ld[13]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2A"
    )
        port map (
      I0 => brst_zero,
      I1 => s_axi_rready,
      I2 => axi_rvalid_int_reg,
      O => \save_init_bram_addr_ld[13]_i_6_n_0\
    );
\save_init_bram_addr_ld[13]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"54440000"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3__0_n_0\,
      I1 => \save_init_bram_addr_ld[13]_i_8_n_0\,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[10]_i_2_n_0\,
      I3 => \save_init_bram_addr_ld[7]_i_2_n_0\,
      I4 => curr_wrap_burst_reg,
      O => \save_init_bram_addr_ld[13]_i_7_n_0\
    );
\save_init_bram_addr_ld[13]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000008F00A000"
    )
        port map (
      I0 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(1),
      I1 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(2),
      I2 => wrap_burst_total(1),
      I3 => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(0),
      I4 => wrap_burst_total(0),
      I5 => wrap_burst_total(2),
      O => \save_init_bram_addr_ld[13]_i_8_n_0\
    );
\save_init_bram_addr_ld[5]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \save_init_bram_addr_ld[5]_i_2_n_0\,
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(1),
      O => bram_addr_ld(5)
    );
\save_init_bram_addr_ld[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A08A"
    )
        port map (
      I0 => save_init_bram_addr_ld(5),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(2),
      I3 => wrap_burst_total(1),
      O => \save_init_bram_addr_ld[5]_i_2_n_0\
    );
\save_init_bram_addr_ld[6]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \save_init_bram_addr_ld[6]_i_2_n_0\,
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(2),
      O => bram_addr_ld(6)
    );
\save_init_bram_addr_ld[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A28A"
    )
        port map (
      I0 => save_init_bram_addr_ld(6),
      I1 => wrap_burst_total(1),
      I2 => wrap_burst_total(2),
      I3 => wrap_burst_total(0),
      O => \save_init_bram_addr_ld[6]_i_2_n_0\
    );
\save_init_bram_addr_ld[7]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2F202F2F2F202020"
    )
        port map (
      I0 => save_init_bram_addr_ld(7),
      I1 => \save_init_bram_addr_ld[7]_i_2_n_0\,
      I2 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I3 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg\,
      I4 => axi_araddr_full,
      I5 => s_axi_araddr(3),
      O => bram_addr_ld(7)
    );
\save_init_bram_addr_ld[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => wrap_burst_total(1),
      I1 => wrap_burst_total(2),
      I2 => wrap_burst_total(0),
      O => \save_init_bram_addr_ld[7]_i_2_n_0\
    );
\save_init_bram_addr_ld[8]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(8),
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(4),
      O => bram_addr_ld(8)
    );
\save_init_bram_addr_ld[9]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => save_init_bram_addr_ld(9),
      I1 => \save_init_bram_addr_ld[13]_i_7_n_0\,
      I2 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg\,
      I3 => axi_araddr_full,
      I4 => s_axi_araddr(5),
      O => bram_addr_ld(9)
    );
\save_init_bram_addr_ld_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(10),
      Q => save_init_bram_addr_ld(10),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(11),
      Q => save_init_bram_addr_ld(11),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => \^d\(8),
      Q => save_init_bram_addr_ld(12),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => \^d\(9),
      Q => save_init_bram_addr_ld(13),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(5),
      Q => save_init_bram_addr_ld(5),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(6),
      Q => save_init_bram_addr_ld(6),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(7),
      Q => save_init_bram_addr_ld(7),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(8),
      Q => save_init_bram_addr_ld(8),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\save_init_bram_addr_ld_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => bram_addr_ld(9),
      Q => save_init_bram_addr_ld(9),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\wrap_burst_total[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF80080800"
    )
        port map (
      I0 => \wrap_burst_total[2]_i_4_n_0\,
      I1 => \^wrap_burst_total_reg[0]_0\,
      I2 => \^wrap_burst_total_reg[0]_1\,
      I3 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\,
      I4 => \^wrap_burst_total_reg[0]_2\,
      I5 => \wrap_burst_total[0]_i_3__0_n_0\,
      O => wrap_burst_total_cmb(0)
    );
\wrap_burst_total[0]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000ACC0A"
    )
        port map (
      I0 => s_axi_arsize(0),
      I1 => Q(0),
      I2 => s_axi_arsize(1),
      I3 => axi_araddr_full,
      I4 => Q(1),
      O => \^wrap_burst_total_reg[0]_0\
    );
\wrap_burst_total[0]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C020802080208020"
    )
        port map (
      I0 => \wrap_burst_total[0]_i_4__0_n_0\,
      I1 => \^wrap_burst_total_reg[0]_3\,
      I2 => \^axi_rd_burst_two_reg\,
      I3 => \^wrap_burst_total_reg[0]_2\,
      I4 => \^wrap_burst_total_reg[0]_1\,
      I5 => \^di\(0),
      O => \wrap_burst_total[0]_i_3__0_n_0\
    );
\wrap_burst_total[0]_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000002000222"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\,
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\,
      I2 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(3),
      I3 => axi_araddr_full,
      I4 => s_axi_arlen(3),
      I5 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\,
      O => \wrap_burst_total[0]_i_4__0_n_0\
    );
\wrap_burst_total[0]_i_5__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(1),
      O => \^wrap_burst_total_reg[0]_3\
    );
\wrap_burst_total[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0030000000305050"
    )
        port map (
      I0 => s_axi_arsize(1),
      I1 => Q(1),
      I2 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\,
      I3 => Q(0),
      I4 => axi_araddr_full,
      I5 => s_axi_arsize(0),
      O => \^di\(0)
    );
\wrap_burst_total[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000400040002020"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\,
      I1 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\,
      I2 => \wrap_burst_total[2]_i_4_n_0\,
      I3 => \^wrap_burst_total_reg[0]_2\,
      I4 => \^wrap_burst_total_reg[0]_1\,
      I5 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\,
      O => wrap_burst_total_cmb(1)
    );
\wrap_burst_total[1]_i_4__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(3),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(3),
      O => \^wrap_burst_total_reg[0]_1\
    );
\wrap_burst_total[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A808000000000000"
    )
        port map (
      I0 => \^size_plus_lsb0\(0),
      I1 => s_axi_arlen(3),
      I2 => axi_araddr_full,
      I3 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(3),
      I4 => \^wrap_burst_total_reg[0]_2\,
      I5 => \wrap_burst_total[2]_i_4_n_0\,
      O => wrap_burst_total_cmb(2)
    );
\wrap_burst_total[2]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000C000CAA"
    )
        port map (
      I0 => s_axi_arsize(1),
      I1 => Q(1),
      I2 => Q(0),
      I3 => axi_araddr_full,
      I4 => s_axi_arsize(0),
      I5 => \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\,
      O => \^size_plus_lsb0\(0)
    );
\wrap_burst_total[2]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(2),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(2),
      O => \^wrap_burst_total_reg[0]_2\
    );
\wrap_burst_total[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCA000A0"
    )
        port map (
      I0 => s_axi_arlen(0),
      I1 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(0),
      I2 => s_axi_arlen(1),
      I3 => axi_araddr_full,
      I4 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(1),
      O => \wrap_burst_total[2]_i_4_n_0\
    );
\wrap_burst_total_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => wrap_burst_total_cmb(0),
      Q => wrap_burst_total(0),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\wrap_burst_total_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => wrap_burst_total_cmb(1),
      Q => wrap_burst_total(1),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
\wrap_burst_total_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \^bram_addr_ld_en\,
      D => wrap_burst_total_cmb(2),
      Q => wrap_burst_total(2),
      R => \^save_init_bram_addr_ld_reg[13]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_blk_mem_gen_prim_wrapper is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end axi_bram_ctrl_0_blk_mem_gen_prim_wrapper;

architecture STRUCTURE of axi_bram_ctrl_0_blk_mem_gen_prim_wrapper is
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\ : STD_LOGIC;
  signal p_33_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "COMMON";
begin
\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "NONE",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => s_axi_aclk,
      CLKBWRCLK => s_axi_aclk,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => BRAM_WrData_A(31 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => p_33_out(31 downto 0),
      DOBDO(31 downto 0) => D(31 downto 0),
      DOPADOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\,
      DOPADOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\,
      DOPADOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\,
      DOPADOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\,
      DOPBDOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\,
      DOPBDOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\,
      DOPBDOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\,
      DOPBDOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\,
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => BRAM_En_A,
      ENBWREN => p_3_out,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => Q(3 downto 0),
      WEBWE(7 downto 0) => B"00000000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized0\ is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized0\ : entity is "blk_mem_gen_prim_wrapper";
end \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized0\;

architecture STRUCTURE of \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized0\ is
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\ : STD_LOGIC;
  signal p_33_out : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "COMMON";
begin
\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "NONE",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => s_axi_aclk,
      CLKBWRCLK => s_axi_aclk,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => BRAM_WrData_A(31 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => p_33_out(63 downto 32),
      DOBDO(31 downto 0) => D(31 downto 0),
      DOPADOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\,
      DOPADOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\,
      DOPADOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\,
      DOPADOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\,
      DOPBDOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\,
      DOPBDOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\,
      DOPBDOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\,
      DOPBDOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\,
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => BRAM_En_A,
      ENBWREN => p_3_out,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => Q(3 downto 0),
      WEBWE(7 downto 0) => B"00000000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized1\ is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized1\ : entity is "blk_mem_gen_prim_wrapper";
end \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized1\;

architecture STRUCTURE of \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized1\ is
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\ : STD_LOGIC;
  signal p_33_out : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "COMMON";
begin
\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "NONE",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => s_axi_aclk,
      CLKBWRCLK => s_axi_aclk,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => BRAM_WrData_A(31 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => p_33_out(95 downto 64),
      DOBDO(31 downto 0) => D(31 downto 0),
      DOPADOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\,
      DOPADOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\,
      DOPADOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\,
      DOPADOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\,
      DOPBDOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\,
      DOPBDOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\,
      DOPBDOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\,
      DOPBDOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\,
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => BRAM_En_A,
      ENBWREN => p_3_out,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => Q(3 downto 0),
      WEBWE(7 downto 0) => B"00000000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized2\ is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized2\ : entity is "blk_mem_gen_prim_wrapper";
end \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized2\;

architecture STRUCTURE of \axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized2\ is
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\ : STD_LOGIC;
  signal p_33_out : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "COMMON";
begin
\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "NONE",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 5) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => s_axi_aclk,
      CLKBWRCLK => s_axi_aclk,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => BRAM_WrData_A(31 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => p_33_out(127 downto 96),
      DOBDO(31 downto 0) => D(31 downto 0),
      DOPADOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_85\,
      DOPADOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_86\,
      DOPADOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_87\,
      DOPADOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_88\,
      DOPBDOP(3) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_89\,
      DOPBDOP(2) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_90\,
      DOPBDOP(1) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_91\,
      DOPBDOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_92\,
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => BRAM_En_A,
      ENBWREN => p_3_out,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => Q(3 downto 0),
      WEBWE(7 downto 0) => B"00000000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_rd_chnl is
  port (
    bid_fifo_rst : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_3_out : out STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : out STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    p_0_in : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_rready : in STD_LOGIC;
    axi_aresetn_d2 : in STD_LOGIC;
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_aresetn_re_reg : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 127 downto 0 )
  );
end axi_bram_ctrl_0_rd_chnl;

architecture STRUCTURE of axi_bram_ctrl_0_rd_chnl is
  signal \/i__n_0\ : STD_LOGIC;
  signal \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \FSM_sequential_rlast_sm_cs[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rlast_sm_cs[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rlast_sm_cs[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rlast_sm_cs[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rlast_sm_cs[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_ARREADY.axi_arready_int_i_1_n_0\ : STD_LOGIC;
  signal \GEN_ARREADY.axi_early_arready_int_i_2_n_0\ : STD_LOGIC;
  signal \GEN_ARREADY.axi_early_arready_int_i_3_n_0\ : STD_LOGIC;
  signal \GEN_ARREADY.axi_early_arready_int_i_4_n_0\ : STD_LOGIC;
  signal \GEN_ARREADY.axi_early_arready_int_i_5_n_0\ : STD_LOGIC;
  signal \GEN_AR_DUAL.ar_active_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AR_DUAL.ar_active_i_2_n_0\ : STD_LOGIC;
  signal \GEN_AR_DUAL.ar_active_i_3_n_0\ : STD_LOGIC;
  signal \GEN_AR_DUAL.ar_active_i_4_n_0\ : STD_LOGIC;
  signal \GEN_AR_DUAL.rd_addr_sm_cs_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg_n_0_[0]\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg_n_0_[1]\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg_n_0_[2]\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[3].axi_araddr_pipe_reg_n_0_[3]\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_araddr_full_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_AR_PIPE_DUAL.axi_arlen_pipe_1_or_2_i_2_n_0\ : STD_LOGIC;
  signal \GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1_n_0\ : STD_LOGIC;
  signal \GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_2_n_0\ : STD_LOGIC;
  signal \GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_2__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_11__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_13__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_14__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_15__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_16_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_19__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_20__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_21__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_22__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_23__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_28__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_29_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_30__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_4__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_5__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_6__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_7__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int_reg[3]_i_12_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_EN.curr_narrow_burst_i_1__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_EN.curr_narrow_burst_i_3_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[100].axi_rdata_int[100]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[101].axi_rdata_int[101]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[102].axi_rdata_int[102]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[103].axi_rdata_int[103]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[104].axi_rdata_int[104]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[105].axi_rdata_int[105]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[106].axi_rdata_int[106]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[107].axi_rdata_int[107]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[108].axi_rdata_int[108]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[109].axi_rdata_int[109]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[110].axi_rdata_int[110]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[111].axi_rdata_int[111]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[112].axi_rdata_int[112]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[113].axi_rdata_int[113]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[114].axi_rdata_int[114]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[115].axi_rdata_int[115]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[116].axi_rdata_int[116]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[117].axi_rdata_int[117]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[118].axi_rdata_int[118]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[119].axi_rdata_int[119]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[120].axi_rdata_int[120]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[121].axi_rdata_int[121]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[122].axi_rdata_int[122]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[123].axi_rdata_int[123]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[124].axi_rdata_int[124]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[125].axi_rdata_int[125]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[126].axi_rdata_int[126]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[32].axi_rdata_int[32]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[33].axi_rdata_int[33]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[34].axi_rdata_int[34]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[35].axi_rdata_int[35]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[36].axi_rdata_int[36]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[37].axi_rdata_int[37]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[38].axi_rdata_int[38]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[39].axi_rdata_int[39]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[40].axi_rdata_int[40]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[41].axi_rdata_int[41]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[42].axi_rdata_int[42]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[43].axi_rdata_int[43]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[44].axi_rdata_int[44]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[45].axi_rdata_int[45]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[46].axi_rdata_int[46]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[47].axi_rdata_int[47]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[48].axi_rdata_int[48]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[49].axi_rdata_int[49]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[50].axi_rdata_int[50]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[51].axi_rdata_int[51]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[52].axi_rdata_int[52]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[53].axi_rdata_int[53]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[54].axi_rdata_int[54]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[55].axi_rdata_int[55]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[56].axi_rdata_int[56]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[57].axi_rdata_int[57]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[58].axi_rdata_int[58]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[59].axi_rdata_int[59]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[60].axi_rdata_int[60]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[61].axi_rdata_int[61]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[62].axi_rdata_int[62]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[63].axi_rdata_int[63]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[64].axi_rdata_int[64]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[65].axi_rdata_int[65]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[66].axi_rdata_int[66]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[67].axi_rdata_int[67]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[68].axi_rdata_int[68]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[69].axi_rdata_int[69]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[70].axi_rdata_int[70]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[71].axi_rdata_int[71]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[72].axi_rdata_int[72]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[73].axi_rdata_int[73]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[74].axi_rdata_int[74]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[75].axi_rdata_int[75]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[76].axi_rdata_int[76]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[77].axi_rdata_int[77]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[78].axi_rdata_int[78]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[79].axi_rdata_int[79]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[80].axi_rdata_int[80]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[81].axi_rdata_int[81]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[82].axi_rdata_int[82]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[83].axi_rdata_int[83]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[84].axi_rdata_int[84]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[85].axi_rdata_int[85]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[86].axi_rdata_int[86]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[87].axi_rdata_int[87]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[88].axi_rdata_int[88]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[89].axi_rdata_int[89]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[90].axi_rdata_int[90]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[91].axi_rdata_int[91]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[92].axi_rdata_int[92]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[93].axi_rdata_int[93]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[94].axi_rdata_int[94]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[95].axi_rdata_int[95]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[96].axi_rdata_int[96]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[97].axi_rdata_int[97]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[98].axi_rdata_int[98]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[99].axi_rdata_int[99]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_int[0]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_int[0]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_temp2[0]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_temp2_full_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_temp2_reg_n_0_[0]\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_temp[0]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_temp[0]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_RID.axi_rid_temp_full_i_1_n_0\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_0\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_1\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_10\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_11\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_12\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_13\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_14\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_2\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_3\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_4\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_5\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_6\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_7\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_8\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_9\ : STD_LOGIC;
  signal I_WRAP_BRST_n_1 : STD_LOGIC;
  signal I_WRAP_BRST_n_10 : STD_LOGIC;
  signal I_WRAP_BRST_n_11 : STD_LOGIC;
  signal I_WRAP_BRST_n_12 : STD_LOGIC;
  signal I_WRAP_BRST_n_13 : STD_LOGIC;
  signal I_WRAP_BRST_n_14 : STD_LOGIC;
  signal I_WRAP_BRST_n_15 : STD_LOGIC;
  signal I_WRAP_BRST_n_16 : STD_LOGIC;
  signal I_WRAP_BRST_n_17 : STD_LOGIC;
  signal I_WRAP_BRST_n_18 : STD_LOGIC;
  signal I_WRAP_BRST_n_19 : STD_LOGIC;
  signal I_WRAP_BRST_n_20 : STD_LOGIC;
  signal I_WRAP_BRST_n_21 : STD_LOGIC;
  signal I_WRAP_BRST_n_22 : STD_LOGIC;
  signal I_WRAP_BRST_n_4 : STD_LOGIC;
  signal I_WRAP_BRST_n_7 : STD_LOGIC;
  signal I_WRAP_BRST_n_8 : STD_LOGIC;
  signal I_WRAP_BRST_n_9 : STD_LOGIC;
  signal act_rd_burst : STD_LOGIC;
  signal act_rd_burst_i_1_n_0 : STD_LOGIC;
  signal act_rd_burst_i_4_n_0 : STD_LOGIC;
  signal act_rd_burst_i_5_n_0 : STD_LOGIC;
  signal act_rd_burst_set : STD_LOGIC;
  signal act_rd_burst_two : STD_LOGIC;
  signal act_rd_burst_two_i_1_n_0 : STD_LOGIC;
  signal act_rd_burst_two_i_2_n_0 : STD_LOGIC;
  signal ar_active : STD_LOGIC;
  signal araddr_pipe_ld44_out : STD_LOGIC;
  signal axi_araddr_full : STD_LOGIC;
  signal axi_arburst_pipe : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_arid_pipe : STD_LOGIC;
  signal axi_arlen_pipe : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_arlen_pipe_1_or_2 : STD_LOGIC;
  signal axi_arready_int : STD_LOGIC;
  signal axi_arsize_pipe : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_arsize_pipe_max : STD_LOGIC;
  signal axi_arsize_pipe_max_i_1_n_0 : STD_LOGIC;
  signal axi_b2b_brst : STD_LOGIC;
  signal axi_b2b_brst_i_1_n_0 : STD_LOGIC;
  signal axi_b2b_brst_i_2_n_0 : STD_LOGIC;
  signal axi_byte_div_curr_arsize : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_early_arready_int : STD_LOGIC;
  signal axi_rd_burst : STD_LOGIC;
  signal axi_rd_burst0 : STD_LOGIC;
  signal axi_rd_burst_i_1_n_0 : STD_LOGIC;
  signal axi_rd_burst_two : STD_LOGIC;
  signal axi_rd_burst_two_i_1_n_0 : STD_LOGIC;
  signal axi_rd_burst_two_i_4_n_0 : STD_LOGIC;
  signal axi_rd_burst_two_reg_n_0 : STD_LOGIC;
  signal axi_rdata_en : STD_LOGIC;
  signal axi_rid_temp : STD_LOGIC;
  signal axi_rid_temp2 : STD_LOGIC;
  signal axi_rid_temp2_full : STD_LOGIC;
  signal axi_rid_temp_full : STD_LOGIC;
  signal axi_rid_temp_full_d1 : STD_LOGIC;
  signal axi_rlast_int_i_1_n_0 : STD_LOGIC;
  signal axi_rlast_set : STD_LOGIC;
  signal axi_rvalid_clr_ok : STD_LOGIC;
  signal axi_rvalid_clr_ok_i_1_n_0 : STD_LOGIC;
  signal axi_rvalid_clr_ok_i_2_n_0 : STD_LOGIC;
  signal axi_rvalid_clr_ok_i_3_n_0 : STD_LOGIC;
  signal axi_rvalid_int_i_1_n_0 : STD_LOGIC;
  signal axi_rvalid_set : STD_LOGIC;
  signal axi_rvalid_set_cmb : STD_LOGIC;
  signal \^bid_fifo_rst\ : STD_LOGIC;
  signal bram_addr_ld : STD_LOGIC_VECTOR ( 13 downto 12 );
  signal bram_addr_ld_en : STD_LOGIC;
  signal bram_addr_ld_en_mod : STD_LOGIC;
  signal bram_en_int_i_10_n_0 : STD_LOGIC;
  signal bram_en_int_i_11_n_0 : STD_LOGIC;
  signal bram_en_int_i_12_n_0 : STD_LOGIC;
  signal bram_en_int_i_1_n_0 : STD_LOGIC;
  signal bram_en_int_i_2_n_0 : STD_LOGIC;
  signal bram_en_int_i_4_n_0 : STD_LOGIC;
  signal bram_en_int_i_5_n_0 : STD_LOGIC;
  signal bram_en_int_i_6_n_0 : STD_LOGIC;
  signal bram_en_int_i_7_n_0 : STD_LOGIC;
  signal bram_en_int_i_8_n_0 : STD_LOGIC;
  signal bram_en_int_i_9_n_0 : STD_LOGIC;
  signal brst_cnt : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \brst_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \brst_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[6]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[6]_i_2_n_0\ : STD_LOGIC;
  signal \brst_cnt[6]_i_3_n_0\ : STD_LOGIC;
  signal \brst_cnt[7]_i_1_n_0\ : STD_LOGIC;
  signal \brst_cnt[7]_i_2_n_0\ : STD_LOGIC;
  signal \brst_cnt[7]_i_3_n_0\ : STD_LOGIC;
  signal \brst_cnt[7]_i_4_n_0\ : STD_LOGIC;
  signal \brst_cnt[7]_i_5_n_0\ : STD_LOGIC;
  signal brst_cnt_max_d1 : STD_LOGIC;
  signal brst_one : STD_LOGIC;
  signal brst_one0 : STD_LOGIC;
  signal brst_one_i_1_n_0 : STD_LOGIC;
  signal brst_one_i_3_n_0 : STD_LOGIC;
  signal brst_zero : STD_LOGIC;
  signal brst_zero_i_1_n_0 : STD_LOGIC;
  signal brst_zero_i_2_n_0 : STD_LOGIC;
  signal curr_fixed_burst : STD_LOGIC;
  signal curr_fixed_burst_reg : STD_LOGIC;
  signal curr_narrow_burst : STD_LOGIC;
  signal curr_wrap_burst : STD_LOGIC;
  signal curr_wrap_burst_reg : STD_LOGIC;
  signal disable_b2b_brst : STD_LOGIC;
  signal disable_b2b_brst_cmb : STD_LOGIC;
  signal disable_b2b_brst_i_2_n_0 : STD_LOGIC;
  signal disable_b2b_brst_i_3_n_0 : STD_LOGIC;
  signal disable_b2b_brst_i_4_n_0 : STD_LOGIC;
  signal end_brst_rd : STD_LOGIC;
  signal end_brst_rd_clr : STD_LOGIC;
  signal end_brst_rd_clr_i_1_n_0 : STD_LOGIC;
  signal end_brst_rd_i_1_n_0 : STD_LOGIC;
  signal last_bram_addr : STD_LOGIC;
  signal last_bram_addr0 : STD_LOGIC;
  signal last_bram_addr_i_2_n_0 : STD_LOGIC;
  signal last_bram_addr_i_3_n_0 : STD_LOGIC;
  signal last_bram_addr_i_4_n_0 : STD_LOGIC;
  signal last_bram_addr_i_5_n_0 : STD_LOGIC;
  signal last_bram_addr_i_6_n_0 : STD_LOGIC;
  signal narrow_addr_int : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal narrow_bram_addr_inc : STD_LOGIC;
  signal narrow_bram_addr_inc_d1 : STD_LOGIC;
  signal narrow_burst_cnt_ld_mod : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal narrow_burst_cnt_ld_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal no_ar_ack : STD_LOGIC;
  signal no_ar_ack_i_1_n_0 : STD_LOGIC;
  signal p_11_out : STD_LOGIC;
  signal p_15_out : STD_LOGIC;
  signal \^p_3_out\ : STD_LOGIC;
  signal p_47_out : STD_LOGIC;
  signal p_4_out : STD_LOGIC;
  signal p_55_out : STD_LOGIC;
  signal pend_rd_op_i_1_n_0 : STD_LOGIC;
  signal pend_rd_op_i_2_n_0 : STD_LOGIC;
  signal pend_rd_op_i_3_n_0 : STD_LOGIC;
  signal pend_rd_op_i_4_n_0 : STD_LOGIC;
  signal pend_rd_op_i_5_n_0 : STD_LOGIC;
  signal pend_rd_op_i_6_n_0 : STD_LOGIC;
  signal pend_rd_op_reg_n_0 : STD_LOGIC;
  signal rd_addr_sm_cs : STD_LOGIC;
  signal rd_adv_buf75_out : STD_LOGIC;
  signal rd_data_sm_cs : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \rd_data_sm_cs[0]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[0]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[0]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[0]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[1]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[1]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[1]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[1]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[2]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[2]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[2]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[2]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_7_n_0\ : STD_LOGIC;
  signal \rd_data_sm_cs[3]_i_8_n_0\ : STD_LOGIC;
  signal rd_data_sm_ns : STD_LOGIC;
  signal rd_skid_buf : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal rd_skid_buf_ld : STD_LOGIC;
  signal rd_skid_buf_ld_cmb : STD_LOGIC;
  signal rd_skid_buf_ld_reg : STD_LOGIC;
  signal rddata_mux_sel : STD_LOGIC;
  signal rddata_mux_sel_cmb : STD_LOGIC;
  signal rddata_mux_sel_i_1_n_0 : STD_LOGIC;
  signal rddata_mux_sel_i_3_n_0 : STD_LOGIC;
  signal rlast_sm_cs : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of rlast_sm_cs : signal is "yes";
  signal \^s_axi_rid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_rlast\ : STD_LOGIC;
  signal \^s_axi_rvalid\ : STD_LOGIC;
  signal size_plus_lsb : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal size_plus_lsb0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \ua_narrow_load1_carry_i_14__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_14__0_n_1\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_14__0_n_2\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_14__0_n_3\ : STD_LOGIC;
  signal ua_narrow_load1_carry_i_22_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_22_n_1 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_22_n_2 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_22_n_3 : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_26__0_n_0\ : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_30__0_n_0\ : STD_LOGIC;
  signal NLW_ua_narrow_load1_carry_i_13_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_ua_narrow_load1_carry_i_13_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_rlast_sm_cs_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_rlast_sm_cs_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_rlast_sm_cs_reg[2]\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_ARREADY.axi_arready_int_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \GEN_ARREADY.axi_arready_int_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \GEN_ARREADY.axi_early_arready_int_i_3\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \GEN_ARREADY.axi_early_arready_int_i_5\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \GEN_AR_DUAL.ar_active_i_2\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \GEN_AR_DUAL.ar_active_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_2\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_4\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_15__0\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_16\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_29\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_30__0\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \GEN_NARROW_EN.curr_narrow_burst_i_3\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[100].axi_rdata_int[100]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[101].axi_rdata_int[101]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[102].axi_rdata_int[102]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[103].axi_rdata_int[103]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[104].axi_rdata_int[104]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[105].axi_rdata_int[105]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[106].axi_rdata_int[106]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[107].axi_rdata_int[107]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[108].axi_rdata_int[108]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[109].axi_rdata_int[109]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[110].axi_rdata_int[110]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[111].axi_rdata_int[111]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[112].axi_rdata_int[112]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[113].axi_rdata_int[113]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[114].axi_rdata_int[114]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[115].axi_rdata_int[115]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[116].axi_rdata_int[116]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[117].axi_rdata_int[117]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[118].axi_rdata_int[118]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[119].axi_rdata_int[119]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[120].axi_rdata_int[120]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[121].axi_rdata_int[121]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[122].axi_rdata_int[122]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[123].axi_rdata_int[123]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[124].axi_rdata_int[124]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[125].axi_rdata_int[125]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[126].axi_rdata_int[126]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_3\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_4\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_5\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[32].axi_rdata_int[32]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[33].axi_rdata_int[33]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[34].axi_rdata_int[34]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[35].axi_rdata_int[35]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[36].axi_rdata_int[36]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[37].axi_rdata_int[37]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[38].axi_rdata_int[38]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[39].axi_rdata_int[39]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[40].axi_rdata_int[40]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[41].axi_rdata_int[41]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[42].axi_rdata_int[42]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[43].axi_rdata_int[43]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[44].axi_rdata_int[44]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[45].axi_rdata_int[45]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[46].axi_rdata_int[46]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[47].axi_rdata_int[47]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[48].axi_rdata_int[48]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[49].axi_rdata_int[49]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[50].axi_rdata_int[50]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[51].axi_rdata_int[51]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[52].axi_rdata_int[52]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[53].axi_rdata_int[53]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[54].axi_rdata_int[54]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[55].axi_rdata_int[55]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[56].axi_rdata_int[56]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[57].axi_rdata_int[57]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[58].axi_rdata_int[58]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[59].axi_rdata_int[59]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[60].axi_rdata_int[60]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[61].axi_rdata_int[61]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[62].axi_rdata_int[62]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[63].axi_rdata_int[63]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[64].axi_rdata_int[64]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[65].axi_rdata_int[65]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[66].axi_rdata_int[66]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[67].axi_rdata_int[67]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[68].axi_rdata_int[68]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[69].axi_rdata_int[69]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[70].axi_rdata_int[70]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[71].axi_rdata_int[71]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[72].axi_rdata_int[72]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[73].axi_rdata_int[73]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[74].axi_rdata_int[74]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[75].axi_rdata_int[75]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[76].axi_rdata_int[76]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[77].axi_rdata_int[77]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[78].axi_rdata_int[78]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[79].axi_rdata_int[79]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[80].axi_rdata_int[80]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[81].axi_rdata_int[81]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[82].axi_rdata_int[82]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[83].axi_rdata_int[83]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[84].axi_rdata_int[84]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[85].axi_rdata_int[85]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[86].axi_rdata_int[86]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[87].axi_rdata_int[87]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[88].axi_rdata_int[88]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[89].axi_rdata_int[89]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[90].axi_rdata_int[90]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[91].axi_rdata_int[91]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[92].axi_rdata_int[92]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[93].axi_rdata_int[93]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[94].axi_rdata_int[94]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[95].axi_rdata_int[95]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[96].axi_rdata_int[96]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[97].axi_rdata_int[97]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[98].axi_rdata_int[98]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[99].axi_rdata_int[99]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \GEN_RID.axi_rid_int[0]_i_2\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of axi_rvalid_clr_ok_i_3 : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of axi_rvalid_set_i_1 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of bram_en_int_i_10 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of bram_en_int_i_12 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of bram_en_int_i_8 : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of bram_en_int_i_9 : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \brst_cnt[2]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \brst_cnt[4]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \brst_cnt[6]_i_2\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \brst_cnt[6]_i_3\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \brst_cnt[7]_i_3\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \brst_cnt[7]_i_5\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of brst_one_i_3 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of brst_zero_i_1 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of brst_zero_i_2 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of curr_fixed_burst_reg_i_1 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of curr_wrap_burst_reg_i_1 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of last_bram_addr_i_5 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of pend_rd_op_i_5 : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[1]_i_3\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[2]_i_3\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_4\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_5\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_6\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_7\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_8\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of rddata_mux_sel_i_1 : label is "soft_lutpair21";
begin
  \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9 downto 0) <= \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(9 downto 0);
  bid_fifo_rst <= \^bid_fifo_rst\;
  p_3_out <= \^p_3_out\;
  s_axi_rid(0) <= \^s_axi_rid\(0);
  s_axi_rlast <= \^s_axi_rlast\;
  s_axi_rvalid <= \^s_axi_rvalid\;
\/i_\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000F1111000E000"
    )
        port map (
      I0 => rlast_sm_cs(0),
      I1 => rlast_sm_cs(1),
      I2 => \^s_axi_rvalid\,
      I3 => s_axi_rready,
      I4 => rlast_sm_cs(2),
      I5 => last_bram_addr,
      O => \/i__n_0\
    );
\/i___0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00008080000F8080"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \^s_axi_rvalid\,
      I2 => rlast_sm_cs(0),
      I3 => rlast_sm_cs(1),
      I4 => rlast_sm_cs(2),
      I5 => \^s_axi_rlast\,
      O => axi_rlast_set
    );
\FSM_sequential_rlast_sm_cs[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01FF0100"
    )
        port map (
      I0 => rlast_sm_cs(2),
      I1 => rlast_sm_cs(0),
      I2 => \FSM_sequential_rlast_sm_cs[0]_i_2_n_0\,
      I3 => \/i__n_0\,
      I4 => rlast_sm_cs(0),
      O => \FSM_sequential_rlast_sm_cs[0]_i_1_n_0\
    );
\FSM_sequential_rlast_sm_cs[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0011001300130013"
    )
        port map (
      I0 => axi_rd_burst,
      I1 => rlast_sm_cs(1),
      I2 => act_rd_burst_two,
      I3 => axi_rd_burst_two_reg_n_0,
      I4 => \^s_axi_rvalid\,
      I5 => s_axi_rready,
      O => \FSM_sequential_rlast_sm_cs[0]_i_2_n_0\
    );
\FSM_sequential_rlast_sm_cs[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01FF0100"
    )
        port map (
      I0 => rlast_sm_cs(2),
      I1 => rlast_sm_cs(0),
      I2 => \FSM_sequential_rlast_sm_cs[1]_i_2_n_0\,
      I3 => \/i__n_0\,
      I4 => rlast_sm_cs(1),
      O => \FSM_sequential_rlast_sm_cs[1]_i_1_n_0\
    );
\FSM_sequential_rlast_sm_cs[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"003F007F003F0055"
    )
        port map (
      I0 => axi_rd_burst,
      I1 => s_axi_rready,
      I2 => \^s_axi_rvalid\,
      I3 => rlast_sm_cs(1),
      I4 => axi_rd_burst_two_reg_n_0,
      I5 => act_rd_burst_two,
      O => \FSM_sequential_rlast_sm_cs[1]_i_2_n_0\
    );
\FSM_sequential_rlast_sm_cs[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00C1FFFF00C10000"
    )
        port map (
      I0 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I1 => rlast_sm_cs(1),
      I2 => rlast_sm_cs(0),
      I3 => rlast_sm_cs(2),
      I4 => \/i__n_0\,
      I5 => rlast_sm_cs(2),
      O => \FSM_sequential_rlast_sm_cs[2]_i_1_n_0\
    );
\FSM_sequential_rlast_sm_cs[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => axi_rd_burst,
      I1 => axi_rd_burst_two_reg_n_0,
      O => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\
    );
\FSM_sequential_rlast_sm_cs_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_rlast_sm_cs[0]_i_1_n_0\,
      Q => rlast_sm_cs(0),
      R => \^bid_fifo_rst\
    );
\FSM_sequential_rlast_sm_cs_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_rlast_sm_cs[1]_i_1_n_0\,
      Q => rlast_sm_cs(1),
      R => \^bid_fifo_rst\
    );
\FSM_sequential_rlast_sm_cs_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_rlast_sm_cs[2]_i_1_n_0\,
      Q => rlast_sm_cs(2),
      R => \^bid_fifo_rst\
    );
\GEN_ARREADY.axi_arready_int_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAEEE"
    )
        port map (
      I0 => p_11_out,
      I1 => axi_arready_int,
      I2 => s_axi_arvalid,
      I3 => axi_araddr_full,
      I4 => araddr_pipe_ld44_out,
      O => \GEN_ARREADY.axi_arready_int_i_1_n_0\
    );
\GEN_ARREADY.axi_arready_int_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAEA"
    )
        port map (
      I0 => axi_aresetn_re_reg,
      I1 => axi_araddr_full,
      I2 => bram_addr_ld_en,
      I3 => axi_early_arready_int,
      O => p_11_out
    );
\GEN_ARREADY.axi_arready_int_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_ARREADY.axi_arready_int_i_1_n_0\,
      Q => axi_arready_int,
      R => \^bid_fifo_rst\
    );
\GEN_ARREADY.axi_early_arready_int_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000200"
    )
        port map (
      I0 => \GEN_ARREADY.axi_early_arready_int_i_2_n_0\,
      I1 => \GEN_ARREADY.axi_early_arready_int_i_3_n_0\,
      I2 => rd_data_sm_cs(3),
      I3 => brst_one,
      I4 => axi_arready_int,
      I5 => \GEN_ARREADY.axi_early_arready_int_i_4_n_0\,
      O => p_55_out
    );
\GEN_ARREADY.axi_early_arready_int_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3033040400030000"
    )
        port map (
      I0 => \GEN_ARREADY.axi_early_arready_int_i_5_n_0\,
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(0),
      I3 => axi_rd_burst_two_reg_n_0,
      I4 => rd_data_sm_cs(1),
      I5 => rd_adv_buf75_out,
      O => \GEN_ARREADY.axi_early_arready_int_i_2_n_0\
    );
\GEN_ARREADY.axi_early_arready_int_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => axi_araddr_full,
      I1 => s_axi_arvalid,
      O => \GEN_ARREADY.axi_early_arready_int_i_3_n_0\
    );
\GEN_ARREADY.axi_early_arready_int_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2222F222FFFFFFFF"
    )
        port map (
      I0 => brst_zero,
      I1 => rd_adv_buf75_out,
      I2 => \rd_data_sm_cs[3]_i_7_n_0\,
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => I_WRAP_BRST_n_15,
      O => \GEN_ARREADY.axi_early_arready_int_i_4_n_0\
    );
\GEN_ARREADY.axi_early_arready_int_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => brst_zero,
      I1 => end_brst_rd,
      O => \GEN_ARREADY.axi_early_arready_int_i_5_n_0\
    );
\GEN_ARREADY.axi_early_arready_int_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => p_55_out,
      Q => axi_early_arready_int,
      R => \^bid_fifo_rst\
    );
\GEN_AR_DUAL.ar_active_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFBFBFAAAAAAAAAA"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => \GEN_AR_DUAL.ar_active_i_2_n_0\,
      I2 => \GEN_AR_DUAL.ar_active_i_3_n_0\,
      I3 => \rd_data_sm_cs[1]_i_3_n_0\,
      I4 => \GEN_AR_DUAL.ar_active_i_4_n_0\,
      I5 => ar_active,
      O => \GEN_AR_DUAL.ar_active_i_1_n_0\
    );
\GEN_AR_DUAL.ar_active_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => s_axi_rready,
      I3 => \^s_axi_rvalid\,
      O => \GEN_AR_DUAL.ar_active_i_2_n_0\
    );
\GEN_AR_DUAL.ar_active_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000E"
    )
        port map (
      I0 => end_brst_rd,
      I1 => brst_zero,
      I2 => rd_data_sm_cs(1),
      I3 => rd_data_sm_cs(0),
      O => \GEN_AR_DUAL.ar_active_i_3_n_0\
    );
\GEN_AR_DUAL.ar_active_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE00EEEEE0EEEE"
    )
        port map (
      I0 => axi_b2b_brst_i_2_n_0,
      I1 => I_WRAP_BRST_n_15,
      I2 => axi_rd_burst,
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => axi_rd_burst_two_reg_n_0,
      O => \GEN_AR_DUAL.ar_active_i_4_n_0\
    );
\GEN_AR_DUAL.ar_active_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AR_DUAL.ar_active_i_1_n_0\,
      Q => ar_active,
      R => p_0_in
    );
\GEN_AR_DUAL.rd_addr_sm_cs_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"57005500"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_3_n_0\,
      I1 => rd_addr_sm_cs,
      I2 => axi_araddr_full,
      I3 => s_axi_arvalid,
      I4 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_2_n_0\,
      O => \GEN_AR_DUAL.rd_addr_sm_cs_i_1_n_0\
    );
\GEN_AR_DUAL.rd_addr_sm_cs_reg\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AR_DUAL.rd_addr_sm_cs_i_1_n_0\,
      Q => rd_addr_sm_cs,
      R => p_0_in
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(0),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg_n_0_[0]\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(10),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(11),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(12),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(13),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(1),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg_n_0_[1]\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(2),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg_n_0_[2]\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[3].axi_araddr_pipe_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(3),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[3].axi_araddr_pipe_reg_n_0_[3]\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(4),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(5),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(6),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(7),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(8),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_araddr(9),
      Q => \GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_araddr_full_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8A88"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => araddr_pipe_ld44_out,
      I2 => bram_addr_ld_en,
      I3 => axi_araddr_full,
      O => \GEN_AR_PIPE_DUAL.axi_araddr_full_i_1_n_0\
    );
\GEN_AR_PIPE_DUAL.axi_araddr_full_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AR_PIPE_DUAL.axi_araddr_full_i_1_n_0\,
      Q => axi_araddr_full,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"03AA"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg_n_0\,
      I1 => s_axi_arburst(0),
      I2 => s_axi_arburst(1),
      I3 => araddr_pipe_ld44_out,
      O => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_i_1_n_0\
    );
\GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_i_1_n_0\,
      Q => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg_n_0\,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arburst(0),
      Q => axi_arburst_pipe(0),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arburst(1),
      Q => axi_arburst_pipe(1),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arid_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arid(0),
      Q => axi_arid_pipe,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000F0004000F000"
    )
        port map (
      I0 => rd_addr_sm_cs,
      I1 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_2_n_0\,
      I2 => s_axi_arvalid,
      I3 => axi_aresetn_d2,
      I4 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_3_n_0\,
      I5 => axi_araddr_full,
      O => araddr_pipe_ld44_out
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => no_ar_ack,
      I1 => pend_rd_op_reg_n_0,
      I2 => ar_active,
      O => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_2_n_0\
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"75FF7575FFFFFFFF"
    )
        port map (
      I0 => I_WRAP_BRST_n_15,
      I1 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_4_n_0\,
      I2 => \rd_data_sm_cs[3]_i_7_n_0\,
      I3 => rd_adv_buf75_out,
      I4 => brst_zero,
      I5 => last_bram_addr,
      O => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_3_n_0\
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => rd_data_sm_cs(0),
      I1 => rd_data_sm_cs(1),
      O => \GEN_AR_PIPE_DUAL.axi_arlen_pipe[7]_i_4_n_0\
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_1_or_2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => s_axi_arlen(6),
      I1 => s_axi_arlen(3),
      I2 => s_axi_arlen(4),
      I3 => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_1_or_2_i_2_n_0\,
      O => p_15_out
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_1_or_2_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => s_axi_arlen(7),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arlen(5),
      I3 => s_axi_arlen(2),
      O => \GEN_AR_PIPE_DUAL.axi_arlen_pipe_1_or_2_i_2_n_0\
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_1_or_2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => p_15_out,
      Q => axi_arlen_pipe_1_or_2,
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(0),
      Q => axi_arlen_pipe(0),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(1),
      Q => axi_arlen_pipe(1),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(2),
      Q => axi_arlen_pipe(2),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(3),
      Q => axi_arlen_pipe(3),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(4),
      Q => axi_arlen_pipe(4),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(5),
      Q => axi_arlen_pipe(5),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(6),
      Q => axi_arlen_pipe(6),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arlen(7),
      Q => axi_arlen_pipe(7),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arsize(0),
      Q => axi_arsize_pipe(0),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arsize(1),
      Q => axi_arsize_pipe(1),
      R => '0'
    );
\GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => araddr_pipe_ld44_out,
      D => s_axi_arsize(2),
      Q => axi_arsize_pipe(2),
      R => '0'
    );
\GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_2_n_0\,
      I1 => end_brst_rd_clr,
      I2 => s_axi_aresetn,
      I3 => bram_addr_ld_en,
      O => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1_n_0\
    );
\GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00202020"
    )
        port map (
      I0 => ar_active,
      I1 => pend_rd_op_reg_n_0,
      I2 => brst_zero,
      I3 => curr_narrow_burst,
      I4 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2__0_n_0\,
      I5 => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg_n_0\,
      O => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_2_n_0\
    );
\GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1_n_0\,
      Q => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg_n_0\,
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(5),
      I1 => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(3),
      I2 => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(1),
      I3 => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(0),
      I4 => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(2),
      I5 => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(4),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_8,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(6),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_7,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(7),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en_mod,
      D => bram_addr_ld(12),
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(8),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en_mod,
      D => bram_addr_ld(13),
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(9),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_14,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(0),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_13,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(1),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_12,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(2),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_11,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(3),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_10,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(4),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_4,
      D => I_WRAP_BRST_n_9,
      Q => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(5),
      R => '0'
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => narrow_addr_int(1),
      I1 => narrow_addr_int(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_2__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_11__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAEFFFF"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_19__0_n_0\,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I3 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I4 => bram_addr_ld_en,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_11__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_13__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEC202020"
    )
        port map (
      I0 => \brst_cnt[6]_i_2_n_0\,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I3 => I_WRAP_BRST_n_22,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_22__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_13__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_14__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0EEE000"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I2 => I_WRAP_BRST_n_20,
      I3 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I4 => I_WRAP_BRST_n_19,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_23__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_14__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_15__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arburst_pipe(0),
      I1 => axi_araddr_full,
      I2 => s_axi_arburst(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_15__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arburst_pipe(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arburst(1),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_16_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_19__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000440347"
    )
        port map (
      I0 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg_n_0_[1]\,
      I1 => axi_araddr_full,
      I2 => s_axi_araddr(1),
      I3 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[3].axi_araddr_pipe_reg_n_0_[3]\,
      I4 => s_axi_araddr(3),
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_28__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_19__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4F"
    )
        port map (
      I0 => I_WRAP_BRST_n_16,
      I1 => curr_narrow_burst,
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_20__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFE0EFEAEFE0"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_29_n_0\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I3 => \brst_cnt[6]_i_2_n_0\,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I5 => I_WRAP_BRST_n_22,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_20__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_21__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFCFCCFFFFEFE0"
    )
        port map (
      I0 => \brst_cnt[7]_i_3_n_0\,
      I1 => I_WRAP_BRST_n_21,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_30__0_n_0\,
      I4 => I_WRAP_BRST_n_19,
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_21__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_22__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFCFC4C4C4C4C4C4"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_29_n_0\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I3 => I_WRAP_BRST_n_22,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I5 => I_WRAP_BRST_n_21,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_22__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_23__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFCFF4450FCF0"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I1 => \brst_cnt[6]_i_2_n_0\,
      I2 => \brst_cnt[7]_i_3_n_0\,
      I3 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_30__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_23__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_28__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg_n_0_[2]\,
      I2 => s_axi_araddr(0),
      I3 => axi_araddr_full,
      I4 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg_n_0_[0]\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_28__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_29\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arlen_pipe(4),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(4),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_29_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_30__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arlen_pipe(5),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(5),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_30__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000E0EEEEEEEE"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2__0_n_0\,
      I1 => narrow_bram_addr_inc_d1,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I3 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I5 => bram_addr_ld_en,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF44444444F"
    )
        port map (
      I0 => size_plus_lsb0(4),
      I1 => bram_addr_ld_en,
      I2 => narrow_addr_int(0),
      I3 => narrow_addr_int(1),
      I4 => narrow_addr_int(2),
      I5 => narrow_addr_int(3),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_5__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_6__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAABAAAAFFFF"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_11__0_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int_reg[3]_i_12_n_0\,
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_13__0_n_0\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_14__0_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_15__0_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_16_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_6__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_7__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"99559A9959559955"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_10\,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_9\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I3 => I_WRAP_BRST_n_18,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_8\,
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_4\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_7__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0_n_0\,
      D => \GEN_UA_NARROW.I_UA_NARROW_n_3\,
      Q => narrow_addr_int(0),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0_n_0\,
      D => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      Q => narrow_addr_int(1),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0_n_0\,
      D => \GEN_UA_NARROW.I_UA_NARROW_n_1\,
      Q => narrow_addr_int(2),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1__0_n_0\,
      D => \GEN_UA_NARROW.I_UA_NARROW_n_0\,
      Q => narrow_addr_int(3),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[3]_i_12\: unisim.vcomponents.MUXF7
     port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_20__0_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_21__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int_reg[3]_i_12_n_0\,
      S => \GEN_UA_NARROW.I_UA_NARROW_n_7\
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2__0_n_0\,
      O => narrow_bram_addr_inc
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFEFFFFFFFF"
    )
        port map (
      I0 => narrow_addr_int(0),
      I1 => narrow_addr_int(1),
      I2 => narrow_addr_int(2),
      I3 => narrow_addr_int(3),
      I4 => I_WRAP_BRST_n_16,
      I5 => curr_narrow_burst,
      O => \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2__0_n_0\
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_bram_addr_inc,
      Q => narrow_bram_addr_inc_d1,
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1DFF1D00"
    )
        port map (
      I0 => s_axi_arsize(2),
      I1 => axi_araddr_full,
      I2 => axi_arsize_pipe(2),
      I3 => bram_addr_ld_en,
      I4 => narrow_burst_cnt_ld_reg(0),
      O => narrow_burst_cnt_ld_mod(0)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"07FF0700"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I3 => bram_addr_ld_en,
      I4 => narrow_burst_cnt_ld_reg(1),
      O => narrow_burst_cnt_ld_mod(1)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[2]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0151FFFF01510000"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I1 => s_axi_arsize(1),
      I2 => axi_araddr_full,
      I3 => axi_arsize_pipe(1),
      I4 => bram_addr_ld_en,
      I5 => narrow_burst_cnt_ld_reg(2),
      O => narrow_burst_cnt_ld_mod(2)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[3]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02A2FFFF02A20000"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_11\,
      I1 => s_axi_arsize(0),
      I2 => axi_araddr_full,
      I3 => axi_arsize_pipe(0),
      I4 => bram_addr_ld_en,
      I5 => narrow_burst_cnt_ld_reg(3),
      O => narrow_burst_cnt_ld_mod(3)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_mod(0),
      Q => narrow_burst_cnt_ld_reg(0),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_mod(1),
      Q => narrow_burst_cnt_ld_reg(1),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_mod(2),
      Q => narrow_burst_cnt_ld_reg(2),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_mod(3),
      Q => narrow_burst_cnt_ld_reg(3),
      R => \^bid_fifo_rst\
    );
\GEN_NARROW_EN.curr_narrow_burst_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2E002E0000002E00"
    )
        port map (
      I0 => curr_narrow_burst,
      I1 => p_47_out,
      I2 => size_plus_lsb0(4),
      I3 => s_axi_aresetn,
      I4 => axi_rlast_set,
      I5 => \GEN_NARROW_EN.curr_narrow_burst_i_3_n_0\,
      O => \GEN_NARROW_EN.curr_narrow_burst_i_1__0_n_0\
    );
\GEN_NARROW_EN.curr_narrow_burst_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA8A8AAAA08A80"
    )
        port map (
      I0 => brst_zero_i_2_n_0,
      I1 => axi_arburst_pipe(1),
      I2 => axi_araddr_full,
      I3 => s_axi_arburst(1),
      I4 => axi_arburst_pipe(0),
      I5 => s_axi_arburst(0),
      O => p_47_out
    );
\GEN_NARROW_EN.curr_narrow_burst_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => pend_rd_op_reg_n_0,
      I1 => bram_addr_ld_en,
      O => \GEN_NARROW_EN.curr_narrow_burst_i_3_n_0\
    );
\GEN_NARROW_EN.curr_narrow_burst_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_NARROW_EN.curr_narrow_burst_i_1__0_n_0\,
      Q => curr_narrow_burst,
      R => '0'
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(0),
      I1 => D(0),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1_n_0\,
      Q => s_axi_rdata(0),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[100].axi_rdata_int[100]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(100),
      I1 => D(100),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[100].axi_rdata_int[100]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[100].axi_rdata_int_reg[100]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[100].axi_rdata_int[100]_i_1_n_0\,
      Q => s_axi_rdata(100),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[101].axi_rdata_int[101]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(101),
      I1 => D(101),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[101].axi_rdata_int[101]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[101].axi_rdata_int_reg[101]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[101].axi_rdata_int[101]_i_1_n_0\,
      Q => s_axi_rdata(101),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[102].axi_rdata_int[102]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(102),
      I1 => D(102),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[102].axi_rdata_int[102]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[102].axi_rdata_int_reg[102]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[102].axi_rdata_int[102]_i_1_n_0\,
      Q => s_axi_rdata(102),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[103].axi_rdata_int[103]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(103),
      I1 => D(103),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[103].axi_rdata_int[103]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[103].axi_rdata_int_reg[103]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[103].axi_rdata_int[103]_i_1_n_0\,
      Q => s_axi_rdata(103),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[104].axi_rdata_int[104]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(104),
      I1 => D(104),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[104].axi_rdata_int[104]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[104].axi_rdata_int_reg[104]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[104].axi_rdata_int[104]_i_1_n_0\,
      Q => s_axi_rdata(104),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[105].axi_rdata_int[105]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(105),
      I1 => D(105),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[105].axi_rdata_int[105]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[105].axi_rdata_int_reg[105]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[105].axi_rdata_int[105]_i_1_n_0\,
      Q => s_axi_rdata(105),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[106].axi_rdata_int[106]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(106),
      I1 => D(106),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[106].axi_rdata_int[106]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[106].axi_rdata_int_reg[106]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[106].axi_rdata_int[106]_i_1_n_0\,
      Q => s_axi_rdata(106),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[107].axi_rdata_int[107]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(107),
      I1 => D(107),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[107].axi_rdata_int[107]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[107].axi_rdata_int_reg[107]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[107].axi_rdata_int[107]_i_1_n_0\,
      Q => s_axi_rdata(107),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[108].axi_rdata_int[108]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(108),
      I1 => D(108),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[108].axi_rdata_int[108]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[108].axi_rdata_int_reg[108]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[108].axi_rdata_int[108]_i_1_n_0\,
      Q => s_axi_rdata(108),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[109].axi_rdata_int[109]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(109),
      I1 => D(109),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[109].axi_rdata_int[109]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[109].axi_rdata_int_reg[109]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[109].axi_rdata_int[109]_i_1_n_0\,
      Q => s_axi_rdata(109),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(10),
      I1 => D(10),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1_n_0\,
      Q => s_axi_rdata(10),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[110].axi_rdata_int[110]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(110),
      I1 => D(110),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[110].axi_rdata_int[110]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[110].axi_rdata_int_reg[110]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[110].axi_rdata_int[110]_i_1_n_0\,
      Q => s_axi_rdata(110),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[111].axi_rdata_int[111]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(111),
      I1 => D(111),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[111].axi_rdata_int[111]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[111].axi_rdata_int_reg[111]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[111].axi_rdata_int[111]_i_1_n_0\,
      Q => s_axi_rdata(111),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[112].axi_rdata_int[112]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(112),
      I1 => D(112),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[112].axi_rdata_int[112]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[112].axi_rdata_int_reg[112]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[112].axi_rdata_int[112]_i_1_n_0\,
      Q => s_axi_rdata(112),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[113].axi_rdata_int[113]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(113),
      I1 => D(113),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[113].axi_rdata_int[113]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[113].axi_rdata_int_reg[113]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[113].axi_rdata_int[113]_i_1_n_0\,
      Q => s_axi_rdata(113),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[114].axi_rdata_int[114]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(114),
      I1 => D(114),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[114].axi_rdata_int[114]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[114].axi_rdata_int_reg[114]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[114].axi_rdata_int[114]_i_1_n_0\,
      Q => s_axi_rdata(114),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[115].axi_rdata_int[115]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(115),
      I1 => D(115),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[115].axi_rdata_int[115]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[115].axi_rdata_int_reg[115]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[115].axi_rdata_int[115]_i_1_n_0\,
      Q => s_axi_rdata(115),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[116].axi_rdata_int[116]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(116),
      I1 => D(116),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[116].axi_rdata_int[116]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[116].axi_rdata_int_reg[116]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[116].axi_rdata_int[116]_i_1_n_0\,
      Q => s_axi_rdata(116),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[117].axi_rdata_int[117]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(117),
      I1 => D(117),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[117].axi_rdata_int[117]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[117].axi_rdata_int_reg[117]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[117].axi_rdata_int[117]_i_1_n_0\,
      Q => s_axi_rdata(117),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[118].axi_rdata_int[118]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(118),
      I1 => D(118),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[118].axi_rdata_int[118]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[118].axi_rdata_int_reg[118]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[118].axi_rdata_int[118]_i_1_n_0\,
      Q => s_axi_rdata(118),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[119].axi_rdata_int[119]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(119),
      I1 => D(119),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[119].axi_rdata_int[119]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[119].axi_rdata_int_reg[119]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[119].axi_rdata_int[119]_i_1_n_0\,
      Q => s_axi_rdata(119),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(11),
      I1 => D(11),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1_n_0\,
      Q => s_axi_rdata(11),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[120].axi_rdata_int[120]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(120),
      I1 => D(120),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[120].axi_rdata_int[120]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[120].axi_rdata_int_reg[120]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[120].axi_rdata_int[120]_i_1_n_0\,
      Q => s_axi_rdata(120),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[121].axi_rdata_int[121]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(121),
      I1 => D(121),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[121].axi_rdata_int[121]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[121].axi_rdata_int_reg[121]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[121].axi_rdata_int[121]_i_1_n_0\,
      Q => s_axi_rdata(121),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[122].axi_rdata_int[122]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(122),
      I1 => D(122),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[122].axi_rdata_int[122]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[122].axi_rdata_int_reg[122]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[122].axi_rdata_int[122]_i_1_n_0\,
      Q => s_axi_rdata(122),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[123].axi_rdata_int[123]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(123),
      I1 => D(123),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[123].axi_rdata_int[123]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[123].axi_rdata_int_reg[123]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[123].axi_rdata_int[123]_i_1_n_0\,
      Q => s_axi_rdata(123),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[124].axi_rdata_int[124]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(124),
      I1 => D(124),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[124].axi_rdata_int[124]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[124].axi_rdata_int_reg[124]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[124].axi_rdata_int[124]_i_1_n_0\,
      Q => s_axi_rdata(124),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[125].axi_rdata_int[125]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(125),
      I1 => D(125),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[125].axi_rdata_int[125]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[125].axi_rdata_int_reg[125]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[125].axi_rdata_int[125]_i_1_n_0\,
      Q => s_axi_rdata(125),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[126].axi_rdata_int[126]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(126),
      I1 => D(126),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[126].axi_rdata_int[126]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[126].axi_rdata_int_reg[126]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[126].axi_rdata_int[126]_i_1_n_0\,
      Q => s_axi_rdata(126),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08FF"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \^s_axi_rlast\,
      I2 => axi_b2b_brst,
      I3 => s_axi_aresetn,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000003F08F030"
    )
        port map (
      I0 => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_4_n_0\,
      I1 => rd_data_sm_cs(0),
      I2 => rd_data_sm_cs(1),
      I3 => rd_adv_buf75_out,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => axi_rdata_en
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(127),
      I1 => D(127),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_3_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => act_rd_burst,
      I1 => act_rd_burst_two,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_4_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^s_axi_rvalid\,
      I1 => s_axi_rready,
      O => rd_adv_buf75_out
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int_reg[127]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_3_n_0\,
      Q => s_axi_rdata(127),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(12),
      I1 => D(12),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1_n_0\,
      Q => s_axi_rdata(12),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(13),
      I1 => D(13),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1_n_0\,
      Q => s_axi_rdata(13),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(14),
      I1 => D(14),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1_n_0\,
      Q => s_axi_rdata(14),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(15),
      I1 => D(15),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1_n_0\,
      Q => s_axi_rdata(15),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(16),
      I1 => D(16),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1_n_0\,
      Q => s_axi_rdata(16),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(17),
      I1 => D(17),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1_n_0\,
      Q => s_axi_rdata(17),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(18),
      I1 => D(18),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1_n_0\,
      Q => s_axi_rdata(18),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(19),
      I1 => D(19),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1_n_0\,
      Q => s_axi_rdata(19),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(1),
      I1 => D(1),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1_n_0\,
      Q => s_axi_rdata(1),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(20),
      I1 => D(20),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1_n_0\,
      Q => s_axi_rdata(20),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(21),
      I1 => D(21),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1_n_0\,
      Q => s_axi_rdata(21),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(22),
      I1 => D(22),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1_n_0\,
      Q => s_axi_rdata(22),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(23),
      I1 => D(23),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1_n_0\,
      Q => s_axi_rdata(23),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(24),
      I1 => D(24),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1_n_0\,
      Q => s_axi_rdata(24),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(25),
      I1 => D(25),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1_n_0\,
      Q => s_axi_rdata(25),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(26),
      I1 => D(26),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1_n_0\,
      Q => s_axi_rdata(26),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(27),
      I1 => D(27),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1_n_0\,
      Q => s_axi_rdata(27),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(28),
      I1 => D(28),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1_n_0\,
      Q => s_axi_rdata(28),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(29),
      I1 => D(29),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1_n_0\,
      Q => s_axi_rdata(29),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(2),
      I1 => D(2),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1_n_0\,
      Q => s_axi_rdata(2),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(30),
      I1 => D(30),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1_n_0\,
      Q => s_axi_rdata(30),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(31),
      I1 => D(31),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1_n_0\,
      Q => s_axi_rdata(31),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[32].axi_rdata_int[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(32),
      I1 => D(32),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[32].axi_rdata_int[32]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[32].axi_rdata_int_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[32].axi_rdata_int[32]_i_1_n_0\,
      Q => s_axi_rdata(32),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[33].axi_rdata_int[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(33),
      I1 => D(33),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[33].axi_rdata_int[33]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[33].axi_rdata_int_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[33].axi_rdata_int[33]_i_1_n_0\,
      Q => s_axi_rdata(33),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[34].axi_rdata_int[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(34),
      I1 => D(34),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[34].axi_rdata_int[34]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[34].axi_rdata_int_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[34].axi_rdata_int[34]_i_1_n_0\,
      Q => s_axi_rdata(34),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[35].axi_rdata_int[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(35),
      I1 => D(35),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[35].axi_rdata_int[35]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[35].axi_rdata_int_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[35].axi_rdata_int[35]_i_1_n_0\,
      Q => s_axi_rdata(35),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[36].axi_rdata_int[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(36),
      I1 => D(36),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[36].axi_rdata_int[36]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[36].axi_rdata_int_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[36].axi_rdata_int[36]_i_1_n_0\,
      Q => s_axi_rdata(36),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[37].axi_rdata_int[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(37),
      I1 => D(37),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[37].axi_rdata_int[37]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[37].axi_rdata_int_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[37].axi_rdata_int[37]_i_1_n_0\,
      Q => s_axi_rdata(37),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[38].axi_rdata_int[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(38),
      I1 => D(38),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[38].axi_rdata_int[38]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[38].axi_rdata_int_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[38].axi_rdata_int[38]_i_1_n_0\,
      Q => s_axi_rdata(38),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[39].axi_rdata_int[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(39),
      I1 => D(39),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[39].axi_rdata_int[39]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[39].axi_rdata_int_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[39].axi_rdata_int[39]_i_1_n_0\,
      Q => s_axi_rdata(39),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(3),
      I1 => D(3),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1_n_0\,
      Q => s_axi_rdata(3),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[40].axi_rdata_int[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(40),
      I1 => D(40),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[40].axi_rdata_int[40]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[40].axi_rdata_int_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[40].axi_rdata_int[40]_i_1_n_0\,
      Q => s_axi_rdata(40),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[41].axi_rdata_int[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(41),
      I1 => D(41),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[41].axi_rdata_int[41]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[41].axi_rdata_int_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[41].axi_rdata_int[41]_i_1_n_0\,
      Q => s_axi_rdata(41),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[42].axi_rdata_int[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(42),
      I1 => D(42),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[42].axi_rdata_int[42]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[42].axi_rdata_int_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[42].axi_rdata_int[42]_i_1_n_0\,
      Q => s_axi_rdata(42),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[43].axi_rdata_int[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(43),
      I1 => D(43),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[43].axi_rdata_int[43]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[43].axi_rdata_int_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[43].axi_rdata_int[43]_i_1_n_0\,
      Q => s_axi_rdata(43),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[44].axi_rdata_int[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(44),
      I1 => D(44),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[44].axi_rdata_int[44]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[44].axi_rdata_int_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[44].axi_rdata_int[44]_i_1_n_0\,
      Q => s_axi_rdata(44),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[45].axi_rdata_int[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(45),
      I1 => D(45),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[45].axi_rdata_int[45]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[45].axi_rdata_int_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[45].axi_rdata_int[45]_i_1_n_0\,
      Q => s_axi_rdata(45),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[46].axi_rdata_int[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(46),
      I1 => D(46),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[46].axi_rdata_int[46]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[46].axi_rdata_int_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[46].axi_rdata_int[46]_i_1_n_0\,
      Q => s_axi_rdata(46),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[47].axi_rdata_int[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(47),
      I1 => D(47),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[47].axi_rdata_int[47]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[47].axi_rdata_int_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[47].axi_rdata_int[47]_i_1_n_0\,
      Q => s_axi_rdata(47),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[48].axi_rdata_int[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(48),
      I1 => D(48),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[48].axi_rdata_int[48]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[48].axi_rdata_int_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[48].axi_rdata_int[48]_i_1_n_0\,
      Q => s_axi_rdata(48),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[49].axi_rdata_int[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(49),
      I1 => D(49),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[49].axi_rdata_int[49]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[49].axi_rdata_int_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[49].axi_rdata_int[49]_i_1_n_0\,
      Q => s_axi_rdata(49),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(4),
      I1 => D(4),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1_n_0\,
      Q => s_axi_rdata(4),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[50].axi_rdata_int[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(50),
      I1 => D(50),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[50].axi_rdata_int[50]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[50].axi_rdata_int_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[50].axi_rdata_int[50]_i_1_n_0\,
      Q => s_axi_rdata(50),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[51].axi_rdata_int[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(51),
      I1 => D(51),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[51].axi_rdata_int[51]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[51].axi_rdata_int_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[51].axi_rdata_int[51]_i_1_n_0\,
      Q => s_axi_rdata(51),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[52].axi_rdata_int[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(52),
      I1 => D(52),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[52].axi_rdata_int[52]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[52].axi_rdata_int_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[52].axi_rdata_int[52]_i_1_n_0\,
      Q => s_axi_rdata(52),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[53].axi_rdata_int[53]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(53),
      I1 => D(53),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[53].axi_rdata_int[53]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[53].axi_rdata_int_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[53].axi_rdata_int[53]_i_1_n_0\,
      Q => s_axi_rdata(53),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[54].axi_rdata_int[54]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(54),
      I1 => D(54),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[54].axi_rdata_int[54]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[54].axi_rdata_int_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[54].axi_rdata_int[54]_i_1_n_0\,
      Q => s_axi_rdata(54),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[55].axi_rdata_int[55]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(55),
      I1 => D(55),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[55].axi_rdata_int[55]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[55].axi_rdata_int_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[55].axi_rdata_int[55]_i_1_n_0\,
      Q => s_axi_rdata(55),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[56].axi_rdata_int[56]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(56),
      I1 => D(56),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[56].axi_rdata_int[56]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[56].axi_rdata_int_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[56].axi_rdata_int[56]_i_1_n_0\,
      Q => s_axi_rdata(56),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[57].axi_rdata_int[57]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(57),
      I1 => D(57),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[57].axi_rdata_int[57]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[57].axi_rdata_int_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[57].axi_rdata_int[57]_i_1_n_0\,
      Q => s_axi_rdata(57),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[58].axi_rdata_int[58]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(58),
      I1 => D(58),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[58].axi_rdata_int[58]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[58].axi_rdata_int_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[58].axi_rdata_int[58]_i_1_n_0\,
      Q => s_axi_rdata(58),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[59].axi_rdata_int[59]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(59),
      I1 => D(59),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[59].axi_rdata_int[59]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[59].axi_rdata_int_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[59].axi_rdata_int[59]_i_1_n_0\,
      Q => s_axi_rdata(59),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(5),
      I1 => D(5),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1_n_0\,
      Q => s_axi_rdata(5),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[60].axi_rdata_int[60]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(60),
      I1 => D(60),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[60].axi_rdata_int[60]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[60].axi_rdata_int_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[60].axi_rdata_int[60]_i_1_n_0\,
      Q => s_axi_rdata(60),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[61].axi_rdata_int[61]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(61),
      I1 => D(61),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[61].axi_rdata_int[61]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[61].axi_rdata_int_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[61].axi_rdata_int[61]_i_1_n_0\,
      Q => s_axi_rdata(61),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[62].axi_rdata_int[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(62),
      I1 => D(62),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[62].axi_rdata_int[62]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[62].axi_rdata_int_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[62].axi_rdata_int[62]_i_1_n_0\,
      Q => s_axi_rdata(62),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[63].axi_rdata_int[63]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(63),
      I1 => D(63),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[63].axi_rdata_int[63]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[63].axi_rdata_int_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[63].axi_rdata_int[63]_i_1_n_0\,
      Q => s_axi_rdata(63),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[64].axi_rdata_int[64]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(64),
      I1 => D(64),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[64].axi_rdata_int[64]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[64].axi_rdata_int_reg[64]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[64].axi_rdata_int[64]_i_1_n_0\,
      Q => s_axi_rdata(64),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[65].axi_rdata_int[65]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(65),
      I1 => D(65),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[65].axi_rdata_int[65]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[65].axi_rdata_int_reg[65]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[65].axi_rdata_int[65]_i_1_n_0\,
      Q => s_axi_rdata(65),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[66].axi_rdata_int[66]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(66),
      I1 => D(66),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[66].axi_rdata_int[66]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[66].axi_rdata_int_reg[66]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[66].axi_rdata_int[66]_i_1_n_0\,
      Q => s_axi_rdata(66),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[67].axi_rdata_int[67]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(67),
      I1 => D(67),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[67].axi_rdata_int[67]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[67].axi_rdata_int_reg[67]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[67].axi_rdata_int[67]_i_1_n_0\,
      Q => s_axi_rdata(67),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[68].axi_rdata_int[68]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(68),
      I1 => D(68),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[68].axi_rdata_int[68]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[68].axi_rdata_int_reg[68]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[68].axi_rdata_int[68]_i_1_n_0\,
      Q => s_axi_rdata(68),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[69].axi_rdata_int[69]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(69),
      I1 => D(69),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[69].axi_rdata_int[69]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[69].axi_rdata_int_reg[69]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[69].axi_rdata_int[69]_i_1_n_0\,
      Q => s_axi_rdata(69),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(6),
      I1 => D(6),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1_n_0\,
      Q => s_axi_rdata(6),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[70].axi_rdata_int[70]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(70),
      I1 => D(70),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[70].axi_rdata_int[70]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[70].axi_rdata_int_reg[70]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[70].axi_rdata_int[70]_i_1_n_0\,
      Q => s_axi_rdata(70),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[71].axi_rdata_int[71]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(71),
      I1 => D(71),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[71].axi_rdata_int[71]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[71].axi_rdata_int_reg[71]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[71].axi_rdata_int[71]_i_1_n_0\,
      Q => s_axi_rdata(71),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[72].axi_rdata_int[72]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(72),
      I1 => D(72),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[72].axi_rdata_int[72]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[72].axi_rdata_int_reg[72]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[72].axi_rdata_int[72]_i_1_n_0\,
      Q => s_axi_rdata(72),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[73].axi_rdata_int[73]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(73),
      I1 => D(73),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[73].axi_rdata_int[73]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[73].axi_rdata_int_reg[73]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[73].axi_rdata_int[73]_i_1_n_0\,
      Q => s_axi_rdata(73),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[74].axi_rdata_int[74]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(74),
      I1 => D(74),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[74].axi_rdata_int[74]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[74].axi_rdata_int_reg[74]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[74].axi_rdata_int[74]_i_1_n_0\,
      Q => s_axi_rdata(74),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[75].axi_rdata_int[75]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(75),
      I1 => D(75),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[75].axi_rdata_int[75]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[75].axi_rdata_int_reg[75]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[75].axi_rdata_int[75]_i_1_n_0\,
      Q => s_axi_rdata(75),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[76].axi_rdata_int[76]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(76),
      I1 => D(76),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[76].axi_rdata_int[76]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[76].axi_rdata_int_reg[76]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[76].axi_rdata_int[76]_i_1_n_0\,
      Q => s_axi_rdata(76),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[77].axi_rdata_int[77]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(77),
      I1 => D(77),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[77].axi_rdata_int[77]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[77].axi_rdata_int_reg[77]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[77].axi_rdata_int[77]_i_1_n_0\,
      Q => s_axi_rdata(77),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[78].axi_rdata_int[78]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(78),
      I1 => D(78),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[78].axi_rdata_int[78]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[78].axi_rdata_int_reg[78]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[78].axi_rdata_int[78]_i_1_n_0\,
      Q => s_axi_rdata(78),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[79].axi_rdata_int[79]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(79),
      I1 => D(79),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[79].axi_rdata_int[79]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[79].axi_rdata_int_reg[79]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[79].axi_rdata_int[79]_i_1_n_0\,
      Q => s_axi_rdata(79),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(7),
      I1 => D(7),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1_n_0\,
      Q => s_axi_rdata(7),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[80].axi_rdata_int[80]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(80),
      I1 => D(80),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[80].axi_rdata_int[80]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[80].axi_rdata_int_reg[80]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[80].axi_rdata_int[80]_i_1_n_0\,
      Q => s_axi_rdata(80),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[81].axi_rdata_int[81]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(81),
      I1 => D(81),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[81].axi_rdata_int[81]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[81].axi_rdata_int_reg[81]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[81].axi_rdata_int[81]_i_1_n_0\,
      Q => s_axi_rdata(81),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[82].axi_rdata_int[82]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(82),
      I1 => D(82),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[82].axi_rdata_int[82]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[82].axi_rdata_int_reg[82]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[82].axi_rdata_int[82]_i_1_n_0\,
      Q => s_axi_rdata(82),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[83].axi_rdata_int[83]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(83),
      I1 => D(83),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[83].axi_rdata_int[83]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[83].axi_rdata_int_reg[83]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[83].axi_rdata_int[83]_i_1_n_0\,
      Q => s_axi_rdata(83),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[84].axi_rdata_int[84]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(84),
      I1 => D(84),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[84].axi_rdata_int[84]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[84].axi_rdata_int_reg[84]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[84].axi_rdata_int[84]_i_1_n_0\,
      Q => s_axi_rdata(84),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[85].axi_rdata_int[85]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(85),
      I1 => D(85),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[85].axi_rdata_int[85]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[85].axi_rdata_int_reg[85]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[85].axi_rdata_int[85]_i_1_n_0\,
      Q => s_axi_rdata(85),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[86].axi_rdata_int[86]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(86),
      I1 => D(86),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[86].axi_rdata_int[86]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[86].axi_rdata_int_reg[86]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[86].axi_rdata_int[86]_i_1_n_0\,
      Q => s_axi_rdata(86),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[87].axi_rdata_int[87]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(87),
      I1 => D(87),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[87].axi_rdata_int[87]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[87].axi_rdata_int_reg[87]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[87].axi_rdata_int[87]_i_1_n_0\,
      Q => s_axi_rdata(87),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[88].axi_rdata_int[88]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(88),
      I1 => D(88),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[88].axi_rdata_int[88]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[88].axi_rdata_int_reg[88]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[88].axi_rdata_int[88]_i_1_n_0\,
      Q => s_axi_rdata(88),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[89].axi_rdata_int[89]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(89),
      I1 => D(89),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[89].axi_rdata_int[89]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[89].axi_rdata_int_reg[89]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[89].axi_rdata_int[89]_i_1_n_0\,
      Q => s_axi_rdata(89),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(8),
      I1 => D(8),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1_n_0\,
      Q => s_axi_rdata(8),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[90].axi_rdata_int[90]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(90),
      I1 => D(90),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[90].axi_rdata_int[90]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[90].axi_rdata_int_reg[90]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[90].axi_rdata_int[90]_i_1_n_0\,
      Q => s_axi_rdata(90),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[91].axi_rdata_int[91]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(91),
      I1 => D(91),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[91].axi_rdata_int[91]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[91].axi_rdata_int_reg[91]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[91].axi_rdata_int[91]_i_1_n_0\,
      Q => s_axi_rdata(91),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[92].axi_rdata_int[92]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(92),
      I1 => D(92),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[92].axi_rdata_int[92]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[92].axi_rdata_int_reg[92]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[92].axi_rdata_int[92]_i_1_n_0\,
      Q => s_axi_rdata(92),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[93].axi_rdata_int[93]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(93),
      I1 => D(93),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[93].axi_rdata_int[93]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[93].axi_rdata_int_reg[93]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[93].axi_rdata_int[93]_i_1_n_0\,
      Q => s_axi_rdata(93),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[94].axi_rdata_int[94]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(94),
      I1 => D(94),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[94].axi_rdata_int[94]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[94].axi_rdata_int_reg[94]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[94].axi_rdata_int[94]_i_1_n_0\,
      Q => s_axi_rdata(94),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[95].axi_rdata_int[95]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(95),
      I1 => D(95),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[95].axi_rdata_int[95]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[95].axi_rdata_int_reg[95]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[95].axi_rdata_int[95]_i_1_n_0\,
      Q => s_axi_rdata(95),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[96].axi_rdata_int[96]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(96),
      I1 => D(96),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[96].axi_rdata_int[96]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[96].axi_rdata_int_reg[96]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[96].axi_rdata_int[96]_i_1_n_0\,
      Q => s_axi_rdata(96),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[97].axi_rdata_int[97]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(97),
      I1 => D(97),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[97].axi_rdata_int[97]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[97].axi_rdata_int_reg[97]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[97].axi_rdata_int[97]_i_1_n_0\,
      Q => s_axi_rdata(97),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[98].axi_rdata_int[98]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(98),
      I1 => D(98),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[98].axi_rdata_int[98]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[98].axi_rdata_int_reg[98]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[98].axi_rdata_int[98]_i_1_n_0\,
      Q => s_axi_rdata(98),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[99].axi_rdata_int[99]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(99),
      I1 => D(99),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[99].axi_rdata_int[99]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[99].axi_rdata_int_reg[99]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[99].axi_rdata_int[99]_i_1_n_0\,
      Q => s_axi_rdata(99),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => rd_skid_buf(9),
      I1 => D(9),
      I2 => rddata_mux_sel,
      O => \GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1_n_0\,
      Q => s_axi_rdata(9),
      R => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf[127]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAAAAAAA"
    )
        port map (
      I0 => rd_skid_buf_ld_reg,
      I1 => rd_data_sm_cs(0),
      I2 => rd_data_sm_cs(1),
      I3 => rd_data_sm_cs(3),
      I4 => rd_data_sm_cs(2),
      I5 => rd_adv_buf75_out,
      O => rd_skid_buf_ld
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(0),
      Q => rd_skid_buf(0),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[100]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(100),
      Q => rd_skid_buf(100),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[101]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(101),
      Q => rd_skid_buf(101),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[102]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(102),
      Q => rd_skid_buf(102),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[103]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(103),
      Q => rd_skid_buf(103),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[104]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(104),
      Q => rd_skid_buf(104),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[105]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(105),
      Q => rd_skid_buf(105),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[106]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(106),
      Q => rd_skid_buf(106),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[107]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(107),
      Q => rd_skid_buf(107),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[108]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(108),
      Q => rd_skid_buf(108),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[109]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(109),
      Q => rd_skid_buf(109),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(10),
      Q => rd_skid_buf(10),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[110]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(110),
      Q => rd_skid_buf(110),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[111]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(111),
      Q => rd_skid_buf(111),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[112]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(112),
      Q => rd_skid_buf(112),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[113]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(113),
      Q => rd_skid_buf(113),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[114]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(114),
      Q => rd_skid_buf(114),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[115]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(115),
      Q => rd_skid_buf(115),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[116]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(116),
      Q => rd_skid_buf(116),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[117]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(117),
      Q => rd_skid_buf(117),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[118]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(118),
      Q => rd_skid_buf(118),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[119]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(119),
      Q => rd_skid_buf(119),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(11),
      Q => rd_skid_buf(11),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[120]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(120),
      Q => rd_skid_buf(120),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[121]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(121),
      Q => rd_skid_buf(121),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[122]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(122),
      Q => rd_skid_buf(122),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[123]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(123),
      Q => rd_skid_buf(123),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[124]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(124),
      Q => rd_skid_buf(124),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[125]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(125),
      Q => rd_skid_buf(125),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[126]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(126),
      Q => rd_skid_buf(126),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[127]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(127),
      Q => rd_skid_buf(127),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(12),
      Q => rd_skid_buf(12),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(13),
      Q => rd_skid_buf(13),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(14),
      Q => rd_skid_buf(14),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(15),
      Q => rd_skid_buf(15),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(16),
      Q => rd_skid_buf(16),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(17),
      Q => rd_skid_buf(17),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(18),
      Q => rd_skid_buf(18),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(19),
      Q => rd_skid_buf(19),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(1),
      Q => rd_skid_buf(1),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(20),
      Q => rd_skid_buf(20),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(21),
      Q => rd_skid_buf(21),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(22),
      Q => rd_skid_buf(22),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(23),
      Q => rd_skid_buf(23),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(24),
      Q => rd_skid_buf(24),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(25),
      Q => rd_skid_buf(25),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(26),
      Q => rd_skid_buf(26),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(27),
      Q => rd_skid_buf(27),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(28),
      Q => rd_skid_buf(28),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(29),
      Q => rd_skid_buf(29),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(2),
      Q => rd_skid_buf(2),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(30),
      Q => rd_skid_buf(30),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(31),
      Q => rd_skid_buf(31),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(32),
      Q => rd_skid_buf(32),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(33),
      Q => rd_skid_buf(33),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(34),
      Q => rd_skid_buf(34),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(35),
      Q => rd_skid_buf(35),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(36),
      Q => rd_skid_buf(36),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(37),
      Q => rd_skid_buf(37),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(38),
      Q => rd_skid_buf(38),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(39),
      Q => rd_skid_buf(39),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(3),
      Q => rd_skid_buf(3),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(40),
      Q => rd_skid_buf(40),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(41),
      Q => rd_skid_buf(41),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(42),
      Q => rd_skid_buf(42),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(43),
      Q => rd_skid_buf(43),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(44),
      Q => rd_skid_buf(44),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(45),
      Q => rd_skid_buf(45),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(46),
      Q => rd_skid_buf(46),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(47),
      Q => rd_skid_buf(47),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(48),
      Q => rd_skid_buf(48),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(49),
      Q => rd_skid_buf(49),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(4),
      Q => rd_skid_buf(4),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(50),
      Q => rd_skid_buf(50),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(51),
      Q => rd_skid_buf(51),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(52),
      Q => rd_skid_buf(52),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(53),
      Q => rd_skid_buf(53),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(54),
      Q => rd_skid_buf(54),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(55),
      Q => rd_skid_buf(55),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(56),
      Q => rd_skid_buf(56),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(57),
      Q => rd_skid_buf(57),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(58),
      Q => rd_skid_buf(58),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(59),
      Q => rd_skid_buf(59),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(5),
      Q => rd_skid_buf(5),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(60),
      Q => rd_skid_buf(60),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(61),
      Q => rd_skid_buf(61),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(62),
      Q => rd_skid_buf(62),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(63),
      Q => rd_skid_buf(63),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[64]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(64),
      Q => rd_skid_buf(64),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[65]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(65),
      Q => rd_skid_buf(65),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[66]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(66),
      Q => rd_skid_buf(66),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[67]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(67),
      Q => rd_skid_buf(67),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[68]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(68),
      Q => rd_skid_buf(68),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[69]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(69),
      Q => rd_skid_buf(69),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(6),
      Q => rd_skid_buf(6),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[70]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(70),
      Q => rd_skid_buf(70),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[71]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(71),
      Q => rd_skid_buf(71),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[72]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(72),
      Q => rd_skid_buf(72),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[73]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(73),
      Q => rd_skid_buf(73),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[74]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(74),
      Q => rd_skid_buf(74),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[75]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(75),
      Q => rd_skid_buf(75),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[76]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(76),
      Q => rd_skid_buf(76),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[77]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(77),
      Q => rd_skid_buf(77),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[78]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(78),
      Q => rd_skid_buf(78),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[79]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(79),
      Q => rd_skid_buf(79),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(7),
      Q => rd_skid_buf(7),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[80]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(80),
      Q => rd_skid_buf(80),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[81]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(81),
      Q => rd_skid_buf(81),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[82]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(82),
      Q => rd_skid_buf(82),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[83]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(83),
      Q => rd_skid_buf(83),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[84]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(84),
      Q => rd_skid_buf(84),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[85]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(85),
      Q => rd_skid_buf(85),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[86]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(86),
      Q => rd_skid_buf(86),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[87]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(87),
      Q => rd_skid_buf(87),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[88]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(88),
      Q => rd_skid_buf(88),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[89]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(89),
      Q => rd_skid_buf(89),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(8),
      Q => rd_skid_buf(8),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[90]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(90),
      Q => rd_skid_buf(90),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[91]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(91),
      Q => rd_skid_buf(91),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[92]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(92),
      Q => rd_skid_buf(92),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[93]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(93),
      Q => rd_skid_buf(93),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[94]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(94),
      Q => rd_skid_buf(94),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[95]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(95),
      Q => rd_skid_buf(95),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[96]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(96),
      Q => rd_skid_buf(96),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[97]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(97),
      Q => rd_skid_buf(97),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[98]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(98),
      Q => rd_skid_buf(98),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[99]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(99),
      Q => rd_skid_buf(99),
      R => \^bid_fifo_rst\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => D(9),
      Q => rd_skid_buf(9),
      R => \^bid_fifo_rst\
    );
\GEN_RID.axi_rid_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFAE00A2"
    )
        port map (
      I0 => \^s_axi_rid\(0),
      I1 => axi_b2b_brst,
      I2 => \GEN_RID.axi_rid_int[0]_i_2_n_0\,
      I3 => axi_rvalid_set,
      I4 => axi_rid_temp,
      I5 => \GEN_RDATA_NO_ECC.GEN_RDATA[127].axi_rdata_int[127]_i_1_n_0\,
      O => \GEN_RID.axi_rid_int[0]_i_1_n_0\
    );
\GEN_RID.axi_rid_int[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \^s_axi_rlast\,
      O => \GEN_RID.axi_rid_int[0]_i_2_n_0\
    );
\GEN_RID.axi_rid_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_RID.axi_rid_int[0]_i_1_n_0\,
      Q => \^s_axi_rid\(0),
      R => '0'
    );
\GEN_RID.axi_rid_temp2[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8FFFFFFB8000000"
    )
        port map (
      I0 => axi_arid_pipe,
      I1 => axi_araddr_full,
      I2 => s_axi_arid(0),
      I3 => axi_rid_temp_full,
      I4 => bram_addr_ld_en,
      I5 => \GEN_RID.axi_rid_temp2_reg_n_0_[0]\,
      O => \GEN_RID.axi_rid_temp2[0]_i_1_n_0\
    );
\GEN_RID.axi_rid_temp2_full_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08080000C8C800C0"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => s_axi_aresetn,
      I2 => axi_rid_temp2_full,
      I3 => axi_rid_temp_full_d1,
      I4 => axi_rid_temp_full,
      I5 => p_4_out,
      O => \GEN_RID.axi_rid_temp2_full_i_1_n_0\
    );
\GEN_RID.axi_rid_temp2_full_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_RID.axi_rid_temp2_full_i_1_n_0\,
      Q => axi_rid_temp2_full,
      R => '0'
    );
\GEN_RID.axi_rid_temp2_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_RID.axi_rid_temp2[0]_i_1_n_0\,
      Q => \GEN_RID.axi_rid_temp2_reg_n_0_[0]\,
      R => \^bid_fifo_rst\
    );
\GEN_RID.axi_rid_temp[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAACFCFC0AAC0C0"
    )
        port map (
      I0 => axi_rid_temp2,
      I1 => \GEN_RID.axi_rid_temp2_reg_n_0_[0]\,
      I2 => \GEN_RID.axi_rid_temp[0]_i_3_n_0\,
      I3 => axi_rid_temp_full,
      I4 => bram_addr_ld_en,
      I5 => axi_rid_temp,
      O => \GEN_RID.axi_rid_temp[0]_i_1_n_0\
    );
\GEN_RID.axi_rid_temp[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arid_pipe,
      I1 => axi_araddr_full,
      I2 => s_axi_arid(0),
      O => axi_rid_temp2
    );
\GEN_RID.axi_rid_temp[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA08AAAAAA08AA08"
    )
        port map (
      I0 => axi_rid_temp2_full,
      I1 => axi_rid_temp_full_d1,
      I2 => axi_rid_temp_full,
      I3 => axi_rvalid_set,
      I4 => \GEN_RID.axi_rid_int[0]_i_2_n_0\,
      I5 => axi_b2b_brst,
      O => \GEN_RID.axi_rid_temp[0]_i_3_n_0\
    );
\GEN_RID.axi_rid_temp_full_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rid_temp_full,
      Q => axi_rid_temp_full_d1,
      R => \^bid_fifo_rst\
    );
\GEN_RID.axi_rid_temp_full_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F0F0E000F0A0A0"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => axi_rid_temp_full_d1,
      I2 => s_axi_aresetn,
      I3 => p_4_out,
      I4 => axi_rid_temp_full,
      I5 => axi_rid_temp2_full,
      O => \GEN_RID.axi_rid_temp_full_i_1_n_0\
    );
\GEN_RID.axi_rid_temp_full_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EAAA"
    )
        port map (
      I0 => axi_rvalid_set,
      I1 => s_axi_rready,
      I2 => \^s_axi_rlast\,
      I3 => axi_b2b_brst,
      O => p_4_out
    );
\GEN_RID.axi_rid_temp_full_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_RID.axi_rid_temp_full_i_1_n_0\,
      Q => axi_rid_temp_full,
      R => '0'
    );
\GEN_RID.axi_rid_temp_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_RID.axi_rid_temp[0]_i_1_n_0\,
      Q => axi_rid_temp,
      R => \^bid_fifo_rst\
    );
\GEN_UA_NARROW.I_UA_NARROW\: entity work.axi_bram_ctrl_0_ua_narrow_0
     port map (
      D(3) => \GEN_UA_NARROW.I_UA_NARROW_n_0\,
      D(2) => \GEN_UA_NARROW.I_UA_NARROW_n_1\,
      D(1) => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      D(0) => \GEN_UA_NARROW.I_UA_NARROW_n_3\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg[0]\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[0].axi_araddr_pipe_reg_n_0_[0]\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg[1]\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[1].axi_araddr_pipe_reg_n_0_[1]\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg[2]\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[2].axi_araddr_pipe_reg_n_0_[2]\,
      \GEN_AR_PIPE_DUAL.axi_araddr_full_reg\(3 downto 0) => narrow_burst_cnt_ld_mod(3 downto 0),
      \GEN_AR_PIPE_DUAL.axi_arburst_pipe_reg[0]\ => \GEN_NARROW_CNT.narrow_addr_int[3]_i_6__0_n_0\,
      \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\ => \GEN_NARROW_CNT.narrow_addr_int[3]_i_7__0_n_0\,
      \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\ => I_WRAP_BRST_n_18,
      \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\(2 downto 0) => axi_arsize_pipe(2 downto 0),
      \GEN_NARROW_CNT.narrow_addr_int_reg[0]\ => \GEN_NARROW_CNT.narrow_addr_int[3]_i_5__0_n_0\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[1]\ => \GEN_UA_NARROW.I_UA_NARROW_n_4\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[1]_0\ => \GEN_UA_NARROW.I_UA_NARROW_n_8\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[1]_1\ => \GEN_NARROW_CNT.narrow_addr_int[2]_i_2__0_n_0\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[2]\ => \GEN_UA_NARROW.I_UA_NARROW_n_9\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[3]\ => \GEN_UA_NARROW.I_UA_NARROW_n_10\,
      \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\ => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4__0_n_0\,
      \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\ => \GEN_UA_NARROW.I_UA_NARROW_n_11\,
      Q(2 downto 0) => narrow_addr_int(2 downto 0),
      S(2) => \GEN_UA_NARROW.I_UA_NARROW_n_12\,
      S(1) => \GEN_UA_NARROW.I_UA_NARROW_n_13\,
      S(0) => \GEN_UA_NARROW.I_UA_NARROW_n_14\,
      axi_araddr_full => axi_araddr_full,
      s_axi_araddr(2 downto 0) => s_axi_araddr(2 downto 0),
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      size_plus_lsb(8 downto 0) => size_plus_lsb(8 downto 0),
      \wrap_burst_total_reg[0]\ => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      \wrap_burst_total_reg[1]\ => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      \wrap_burst_total_reg[1]_0\ => \GEN_UA_NARROW.I_UA_NARROW_n_6\
    );
I_WRAP_BRST: entity work.axi_bram_ctrl_0_wrap_brst_1
     port map (
      D(9 downto 8) => bram_addr_ld(13 downto 12),
      D(7) => I_WRAP_BRST_n_7,
      D(6) => I_WRAP_BRST_n_8,
      D(5) => I_WRAP_BRST_n_9,
      D(4) => I_WRAP_BRST_n_10,
      D(3) => I_WRAP_BRST_n_11,
      D(2) => I_WRAP_BRST_n_12,
      D(1) => I_WRAP_BRST_n_13,
      D(0) => I_WRAP_BRST_n_14,
      DI(0) => I_WRAP_BRST_n_1,
      E(1) => bram_addr_ld_en_mod,
      E(0) => I_WRAP_BRST_n_4,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[10].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[11].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[12].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[13].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[4].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[5].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[6].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[7].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[8].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg\ => \GEN_AR_PIPE_DUAL.GEN_ARADDR[9].axi_araddr_pipe_reg\,
      \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg\ => \GEN_AR_PIPE_DUAL.axi_arburst_pipe_fixed_reg_n_0\,
      \GEN_AR_PIPE_DUAL.axi_arlen_pipe_reg[3]\(3 downto 0) => axi_arlen_pipe(3 downto 0),
      \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[0]\ => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[1]\ => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      \GEN_AR_PIPE_DUAL.axi_arsize_pipe_reg[2]\ => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\(7 downto 0) => \^device_7series.no_bmm_info.true_dp.simple_prim36.ram\(7 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[9]\ => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4_n_0\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(3 downto 0) => narrow_addr_int(3 downto 0),
      Q(1 downto 0) => axi_arsize_pipe(2 downto 1),
      ar_active => ar_active,
      axi_araddr_full => axi_araddr_full,
      axi_aresetn_d2 => axi_aresetn_d2,
      axi_arlen_pipe_1_or_2 => axi_arlen_pipe_1_or_2,
      axi_arsize_pipe_max => axi_arsize_pipe_max,
      axi_b2b_brst => axi_b2b_brst,
      axi_rd_burst => axi_rd_burst,
      axi_rd_burst_two_reg => I_WRAP_BRST_n_22,
      axi_rd_burst_two_reg_0 => axi_rd_burst_two_reg_n_0,
      axi_rvalid_int_reg => \^s_axi_rvalid\,
      bram_addr_ld_en => bram_addr_ld_en,
      bram_en_int_reg => I_WRAP_BRST_n_17,
      \brst_cnt_reg[3]\ => I_WRAP_BRST_n_16,
      brst_zero => brst_zero,
      curr_fixed_burst_reg => curr_fixed_burst_reg,
      curr_narrow_burst => curr_narrow_burst,
      curr_wrap_burst_reg => curr_wrap_burst_reg,
      disable_b2b_brst => disable_b2b_brst,
      end_brst_rd => end_brst_rd,
      last_bram_addr => last_bram_addr,
      narrow_bram_addr_inc_d1 => narrow_bram_addr_inc_d1,
      no_ar_ack => no_ar_ack,
      pend_rd_op_reg => pend_rd_op_reg_n_0,
      rd_addr_sm_cs => rd_addr_sm_cs,
      \rd_data_sm_cs_reg[3]\(3 downto 0) => rd_data_sm_cs(3 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(9 downto 0) => s_axi_araddr(13 downto 4),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arlen(3 downto 0) => s_axi_arlen(3 downto 0),
      s_axi_arsize(1 downto 0) => s_axi_arsize(2 downto 1),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_rready => s_axi_rready,
      \save_init_bram_addr_ld_reg[13]_0\ => \^bid_fifo_rst\,
      \save_init_bram_addr_ld_reg[13]_1\ => I_WRAP_BRST_n_15,
      size_plus_lsb0(0) => size_plus_lsb0(4),
      \wrap_burst_total_reg[0]_0\ => I_WRAP_BRST_n_18,
      \wrap_burst_total_reg[0]_1\ => I_WRAP_BRST_n_19,
      \wrap_burst_total_reg[0]_2\ => I_WRAP_BRST_n_20,
      \wrap_burst_total_reg[0]_3\ => I_WRAP_BRST_n_21
    );
act_rd_burst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000022E2EEE2"
    )
        port map (
      I0 => act_rd_burst,
      I1 => act_rd_burst_set,
      I2 => axi_rd_burst,
      I3 => bram_addr_ld_en,
      I4 => axi_rd_burst_two,
      I5 => act_rd_burst_i_4_n_0,
      O => act_rd_burst_i_1_n_0
    );
act_rd_burst_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3333333300320002"
    )
        port map (
      I0 => brst_zero_i_2_n_0,
      I1 => \rd_data_sm_cs[1]_i_3_n_0\,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I5 => act_rd_burst_i_5_n_0,
      O => act_rd_burst_set
    );
act_rd_burst_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => s_axi_arlen(0),
      I1 => axi_araddr_full,
      I2 => axi_arlen_pipe(0),
      I3 => axi_rd_burst0,
      O => axi_rd_burst_two
    );
act_rd_burst_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"04000002FFFFFFFF"
    )
        port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => \rd_data_sm_cs[3]_i_8_n_0\,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(1),
      I5 => s_axi_aresetn,
      O => act_rd_burst_i_4_n_0
    );
act_rd_burst_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000808080008000"
    )
        port map (
      I0 => I_WRAP_BRST_n_15,
      I1 => rd_adv_buf75_out,
      I2 => bram_en_int_i_9_n_0,
      I3 => brst_zero,
      I4 => axi_b2b_brst,
      I5 => end_brst_rd,
      O => act_rd_burst_i_5_n_0
    );
act_rd_burst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => act_rd_burst_i_1_n_0,
      Q => act_rd_burst,
      R => '0'
    );
act_rd_burst_two_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => act_rd_burst_two,
      I1 => act_rd_burst_set,
      I2 => act_rd_burst_two_i_2_n_0,
      I3 => act_rd_burst_i_4_n_0,
      O => act_rd_burst_two_i_1_n_0
    );
act_rd_burst_two_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E2FFFF00E20000"
    )
        port map (
      I0 => s_axi_arlen(0),
      I1 => axi_araddr_full,
      I2 => axi_arlen_pipe(0),
      I3 => axi_rd_burst0,
      I4 => bram_addr_ld_en,
      I5 => axi_rd_burst_two_reg_n_0,
      O => act_rd_burst_two_i_2_n_0
    );
act_rd_burst_two_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => act_rd_burst_two_i_1_n_0,
      Q => act_rd_burst_two,
      R => '0'
    );
axi_arsize_pipe_max_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04FF0400"
    )
        port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => araddr_pipe_ld44_out,
      I4 => axi_arsize_pipe_max,
      O => axi_arsize_pipe_max_i_1_n_0
    );
axi_arsize_pipe_max_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_arsize_pipe_max_i_1_n_0,
      Q => axi_arsize_pipe_max,
      R => \^bid_fifo_rst\
    );
axi_b2b_brst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F000F0F2F0F0F0F2"
    )
        port map (
      I0 => I_WRAP_BRST_n_15,
      I1 => axi_b2b_brst_i_2_n_0,
      I2 => axi_b2b_brst,
      I3 => rd_data_sm_cs(3),
      I4 => rd_data_sm_cs(2),
      I5 => \rd_data_sm_cs[2]_i_3_n_0\,
      O => axi_b2b_brst_i_1_n_0
    );
axi_b2b_brst_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0DFFFFFFFFFFFFFF"
    )
        port map (
      I0 => end_brst_rd,
      I1 => axi_b2b_brst,
      I2 => brst_zero,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(1),
      I5 => rd_adv_buf75_out,
      O => axi_b2b_brst_i_2_n_0
    );
axi_b2b_brst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_b2b_brst_i_1_n_0,
      Q => axi_b2b_brst,
      R => \^bid_fifo_rst\
    );
axi_rd_burst_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C0C000A0"
    )
        port map (
      I0 => axi_rd_burst,
      I1 => axi_rd_burst0,
      I2 => s_axi_aresetn,
      I3 => brst_zero,
      I4 => bram_addr_ld_en,
      O => axi_rd_burst_i_1_n_0
    );
axi_rd_burst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rd_burst_i_1_n_0,
      Q => axi_rd_burst,
      R => '0'
    );
axi_rd_burst_two_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"300030000000AA00"
    )
        port map (
      I0 => axi_rd_burst_two_reg_n_0,
      I1 => axi_rd_burst0,
      I2 => I_WRAP_BRST_n_22,
      I3 => s_axi_aresetn,
      I4 => brst_zero,
      I5 => bram_addr_ld_en,
      O => axi_rd_burst_two_i_1_n_0
    );
axi_rd_burst_two_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFE2"
    )
        port map (
      I0 => s_axi_arlen(5),
      I1 => axi_araddr_full,
      I2 => axi_arlen_pipe(5),
      I3 => \brst_cnt[6]_i_2_n_0\,
      I4 => I_WRAP_BRST_n_19,
      I5 => axi_rd_burst_two_i_4_n_0,
      O => axi_rd_burst0
    );
axi_rd_burst_two_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFEFFFEEE"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => I_WRAP_BRST_n_21,
      I2 => axi_arlen_pipe(4),
      I3 => axi_araddr_full,
      I4 => s_axi_arlen(4),
      I5 => \brst_cnt[7]_i_3_n_0\,
      O => axi_rd_burst_two_i_4_n_0
    );
axi_rd_burst_two_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rd_burst_two_i_1_n_0,
      Q => axi_rd_burst_two_reg_n_0,
      R => '0'
    );
axi_rlast_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88A8"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => axi_rlast_set,
      I2 => \^s_axi_rlast\,
      I3 => s_axi_rready,
      O => axi_rlast_int_i_1_n_0
    );
axi_rlast_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rlast_int_i_1_n_0,
      Q => \^s_axi_rlast\,
      R => '0'
    );
axi_rvalid_clr_ok_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FE000000FE00"
    )
        port map (
      I0 => axi_rvalid_clr_ok,
      I1 => axi_rvalid_clr_ok_i_2_n_0,
      I2 => axi_rvalid_clr_ok_i_3_n_0,
      I3 => s_axi_aresetn,
      I4 => bram_addr_ld_en,
      I5 => \GEN_ARREADY.axi_early_arready_int_i_4_n_0\,
      O => axi_rvalid_clr_ok_i_1_n_0
    );
axi_rvalid_clr_ok_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E0"
    )
        port map (
      I0 => disable_b2b_brst_i_2_n_0,
      I1 => disable_b2b_brst,
      I2 => last_bram_addr,
      I3 => axi_rvalid_clr_ok,
      O => axi_rvalid_clr_ok_i_2_n_0
    );
axi_rvalid_clr_ok_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(1),
      I3 => rd_data_sm_cs(0),
      O => axi_rvalid_clr_ok_i_3_n_0
    );
axi_rvalid_clr_ok_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rvalid_clr_ok_i_1_n_0,
      Q => axi_rvalid_clr_ok,
      R => '0'
    );
axi_rvalid_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E0E0E0E0E0E0E0"
    )
        port map (
      I0 => \^s_axi_rvalid\,
      I1 => axi_rvalid_set,
      I2 => s_axi_aresetn,
      I3 => axi_rvalid_clr_ok,
      I4 => \^s_axi_rlast\,
      I5 => s_axi_rready,
      O => axi_rvalid_int_i_1_n_0
    );
axi_rvalid_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rvalid_int_i_1_n_0,
      Q => \^s_axi_rvalid\,
      R => '0'
    );
axi_rvalid_set_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => rd_data_sm_cs(1),
      I1 => rd_data_sm_cs(0),
      I2 => rd_data_sm_cs(3),
      I3 => rd_data_sm_cs(2),
      O => axi_rvalid_set_cmb
    );
axi_rvalid_set_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rvalid_set_cmb,
      Q => axi_rvalid_set,
      R => \^bid_fifo_rst\
    );
bram_en_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFBFFFBFBFB00"
    )
        port map (
      I0 => bram_en_int_i_2_n_0,
      I1 => I_WRAP_BRST_n_17,
      I2 => bram_en_int_i_4_n_0,
      I3 => bram_en_int_i_5_n_0,
      I4 => bram_en_int_i_6_n_0,
      I5 => \^p_3_out\,
      O => bram_en_int_i_1_n_0
    );
bram_en_int_i_10: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0007"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \^s_axi_rvalid\,
      I2 => end_brst_rd,
      I3 => brst_zero,
      O => bram_en_int_i_10_n_0
    );
bram_en_int_i_11: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0808080000000000"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => rd_data_sm_cs(0),
      I2 => rd_data_sm_cs(1),
      I3 => act_rd_burst_two,
      I4 => act_rd_burst,
      I5 => rd_adv_buf75_out,
      O => bram_en_int_i_11_n_0
    );
bram_en_int_i_12: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1555"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => pend_rd_op_reg_n_0,
      I2 => \^s_axi_rvalid\,
      I3 => s_axi_rready,
      O => bram_en_int_i_12_n_0
    );
bram_en_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5554111111100000"
    )
        port map (
      I0 => rd_data_sm_cs(1),
      I1 => rd_data_sm_cs(2),
      I2 => axi_rd_burst,
      I3 => axi_rd_burst_two_reg_n_0,
      I4 => rd_data_sm_cs(0),
      I5 => bram_addr_ld_en,
      O => bram_en_int_i_2_n_0
    );
bram_en_int_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAFF0000"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => pend_rd_op_reg_n_0,
      I2 => rd_adv_buf75_out,
      I3 => rd_data_sm_cs(2),
      I4 => rd_data_sm_cs(1),
      I5 => bram_en_int_i_7_n_0,
      O => bram_en_int_i_4_n_0
    );
bram_en_int_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000002222222"
    )
        port map (
      I0 => bram_en_int_i_8_n_0,
      I1 => \rd_data_sm_cs[1]_i_3_n_0\,
      I2 => brst_one,
      I3 => bram_en_int_i_9_n_0,
      I4 => bram_en_int_i_10_n_0,
      I5 => act_rd_burst_i_5_n_0,
      O => bram_en_int_i_5_n_0
    );
bram_en_int_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888AAA88888A"
    )
        port map (
      I0 => \rd_data_sm_cs[3]_i_7_n_0\,
      I1 => bram_en_int_i_11_n_0,
      I2 => bram_en_int_i_10_n_0,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(1),
      I5 => bram_en_int_i_12_n_0,
      O => bram_en_int_i_6_n_0
    );
bram_en_int_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0044504455445044"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => axi_rd_burst_two_reg_n_0,
      I2 => \GEN_ARREADY.axi_early_arready_int_i_5_n_0\,
      I3 => rd_data_sm_cs(0),
      I4 => rd_adv_buf75_out,
      I5 => \rd_data_sm_cs[3]_i_3_n_0\,
      O => bram_en_int_i_7_n_0
    );
bram_en_int_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(0),
      O => bram_en_int_i_8_n_0
    );
bram_en_int_i_9: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => rd_data_sm_cs(0),
      I1 => rd_data_sm_cs(1),
      O => bram_en_int_i_9_n_0
    );
bram_en_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => bram_en_int_i_1_n_0,
      Q => \^p_3_out\,
      R => \^bid_fifo_rst\
    );
\brst_cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B800B8FF"
    )
        port map (
      I0 => axi_arlen_pipe(0),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(0),
      I3 => bram_addr_ld_en,
      I4 => brst_cnt(0),
      O => \brst_cnt[0]_i_1_n_0\
    );
\brst_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8FFB800B800B8FF"
    )
        port map (
      I0 => axi_arlen_pipe(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(1),
      I3 => bram_addr_ld_en,
      I4 => brst_cnt(0),
      I5 => brst_cnt(1),
      O => \brst_cnt[1]_i_1_n_0\
    );
\brst_cnt[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8B8B88B"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => bram_addr_ld_en,
      I2 => brst_cnt(2),
      I3 => brst_cnt(1),
      I4 => brst_cnt(0),
      O => \brst_cnt[2]_i_1_n_0\
    );
\brst_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8B8B8B8B88B"
    )
        port map (
      I0 => I_WRAP_BRST_n_19,
      I1 => bram_addr_ld_en,
      I2 => brst_cnt(3),
      I3 => brst_cnt(2),
      I4 => brst_cnt(0),
      I5 => brst_cnt(1),
      O => \brst_cnt[3]_i_1_n_0\
    );
\brst_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B800B8FFB8FFB800"
    )
        port map (
      I0 => axi_arlen_pipe(4),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(4),
      I3 => bram_addr_ld_en,
      I4 => brst_cnt(4),
      I5 => \brst_cnt[4]_i_2_n_0\,
      O => \brst_cnt[4]_i_1_n_0\
    );
\brst_cnt[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => brst_cnt(2),
      I1 => brst_cnt(0),
      I2 => brst_cnt(1),
      I3 => brst_cnt(3),
      O => \brst_cnt[4]_i_2_n_0\
    );
\brst_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B800B8FFB8FFB800"
    )
        port map (
      I0 => axi_arlen_pipe(5),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(5),
      I3 => bram_addr_ld_en,
      I4 => brst_cnt(5),
      I5 => \brst_cnt[6]_i_3_n_0\,
      O => \brst_cnt[5]_i_1_n_0\
    );
\brst_cnt[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B88BB8B8"
    )
        port map (
      I0 => \brst_cnt[6]_i_2_n_0\,
      I1 => bram_addr_ld_en,
      I2 => brst_cnt(6),
      I3 => brst_cnt(5),
      I4 => \brst_cnt[6]_i_3_n_0\,
      O => \brst_cnt[6]_i_1_n_0\
    );
\brst_cnt[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arlen_pipe(6),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(6),
      O => \brst_cnt[6]_i_2_n_0\
    );
\brst_cnt[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => brst_cnt(3),
      I1 => brst_cnt(1),
      I2 => brst_cnt(0),
      I3 => brst_cnt(2),
      I4 => brst_cnt(4),
      O => \brst_cnt[6]_i_3_n_0\
    );
\brst_cnt[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => I_WRAP_BRST_n_16,
      O => \brst_cnt[7]_i_1_n_0\
    );
\brst_cnt[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B88BB8B8"
    )
        port map (
      I0 => \brst_cnt[7]_i_3_n_0\,
      I1 => bram_addr_ld_en,
      I2 => brst_cnt(7),
      I3 => \brst_cnt[7]_i_4_n_0\,
      I4 => \brst_cnt[7]_i_5_n_0\,
      O => \brst_cnt[7]_i_2_n_0\
    );
\brst_cnt[7]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_arlen_pipe(7),
      I1 => axi_araddr_full,
      I2 => s_axi_arlen(7),
      O => \brst_cnt[7]_i_3_n_0\
    );
\brst_cnt[7]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => brst_cnt(4),
      I1 => brst_cnt(6),
      I2 => brst_cnt(5),
      I3 => brst_cnt(3),
      O => \brst_cnt[7]_i_4_n_0\
    );
\brst_cnt[7]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => brst_cnt(1),
      I1 => brst_cnt(0),
      I2 => brst_cnt(2),
      O => \brst_cnt[7]_i_5_n_0\
    );
brst_cnt_max_d1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg_n_0\,
      Q => brst_cnt_max_d1,
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[0]_i_1_n_0\,
      Q => brst_cnt(0),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[1]_i_1_n_0\,
      Q => brst_cnt(1),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[2]_i_1_n_0\,
      Q => brst_cnt(2),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[3]_i_1_n_0\,
      Q => brst_cnt(3),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[4]_i_1_n_0\,
      Q => brst_cnt(4),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[5]_i_1_n_0\,
      Q => brst_cnt(5),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[6]_i_1_n_0\,
      Q => brst_cnt(6),
      R => \^bid_fifo_rst\
    );
\brst_cnt_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \brst_cnt[7]_i_1_n_0\,
      D => \brst_cnt[7]_i_2_n_0\,
      Q => brst_cnt(7),
      R => \^bid_fifo_rst\
    );
brst_one_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000E00"
    )
        port map (
      I0 => brst_one,
      I1 => brst_one0,
      I2 => brst_one_i_3_n_0,
      I3 => s_axi_aresetn,
      I4 => last_bram_addr_i_2_n_0,
      O => brst_one_i_1_n_0
    );
brst_one_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"40FF404040404040"
    )
        port map (
      I0 => brst_cnt(0),
      I1 => brst_cnt(1),
      I2 => last_bram_addr_i_6_n_0,
      I3 => axi_rd_burst0,
      I4 => bram_addr_ld_en,
      I5 => I_WRAP_BRST_n_22,
      O => brst_one0
    );
brst_one_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A888AAA"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => axi_rd_burst0,
      I2 => axi_arlen_pipe(0),
      I3 => axi_araddr_full,
      I4 => s_axi_arlen(0),
      O => brst_one_i_3_n_0
    );
brst_one_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => brst_one_i_1_n_0,
      Q => brst_one,
      R => '0'
    );
brst_zero_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E0"
    )
        port map (
      I0 => brst_zero,
      I1 => last_bram_addr_i_2_n_0,
      I2 => s_axi_aresetn,
      I3 => brst_zero_i_2_n_0,
      O => brst_zero_i_1_n_0
    );
brst_zero_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A8AAA888"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => axi_rd_burst0,
      I2 => axi_arlen_pipe(0),
      I3 => axi_araddr_full,
      I4 => s_axi_arlen(0),
      O => brst_zero_i_2_n_0
    );
brst_zero_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => brst_zero_i_1_n_0,
      Q => brst_zero,
      R => '0'
    );
curr_fixed_burst_reg_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_arburst(0),
      I1 => axi_arburst_pipe(0),
      I2 => s_axi_arburst(1),
      I3 => axi_araddr_full,
      I4 => axi_arburst_pipe(1),
      O => curr_fixed_burst
    );
curr_fixed_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en,
      D => curr_fixed_burst,
      Q => curr_fixed_burst_reg,
      R => \^bid_fifo_rst\
    );
curr_wrap_burst_reg_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000ACC0A"
    )
        port map (
      I0 => s_axi_arburst(1),
      I1 => axi_arburst_pipe(1),
      I2 => s_axi_arburst(0),
      I3 => axi_araddr_full,
      I4 => axi_arburst_pipe(0),
      O => curr_wrap_burst
    );
curr_wrap_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en,
      D => curr_wrap_burst,
      Q => curr_wrap_burst_reg,
      R => \^bid_fifo_rst\
    );
disable_b2b_brst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEAAEAEAEEEEEAEE"
    )
        port map (
      I0 => disable_b2b_brst_i_2_n_0,
      I1 => disable_b2b_brst,
      I2 => rd_data_sm_cs(2),
      I3 => rd_data_sm_cs(3),
      I4 => rd_data_sm_cs(1),
      I5 => rd_data_sm_cs(0),
      O => disable_b2b_brst_cmb
    );
disable_b2b_brst_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000A002200"
    )
        port map (
      I0 => disable_b2b_brst_i_3_n_0,
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(3),
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(1),
      I5 => disable_b2b_brst_i_4_n_0,
      O => disable_b2b_brst_i_2_n_0
    );
disable_b2b_brst_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAAA0000FFCF"
    )
        port map (
      I0 => disable_b2b_brst,
      I1 => rd_data_sm_cs(1),
      I2 => axi_rd_burst,
      I3 => axi_rd_burst_two_reg_n_0,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => disable_b2b_brst_i_3_n_0
    );
disable_b2b_brst_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FF010000"
    )
        port map (
      I0 => brst_one,
      I1 => end_brst_rd,
      I2 => brst_zero,
      I3 => rd_adv_buf75_out,
      I4 => rd_data_sm_cs(1),
      I5 => disable_b2b_brst,
      O => disable_b2b_brst_i_4_n_0
    );
disable_b2b_brst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => disable_b2b_brst_cmb,
      Q => disable_b2b_brst,
      R => \^bid_fifo_rst\
    );
end_brst_rd_clr_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF100000A00"
    )
        port map (
      I0 => rd_data_sm_cs(0),
      I1 => bram_addr_ld_en,
      I2 => rd_data_sm_cs(1),
      I3 => rd_data_sm_cs(2),
      I4 => rd_data_sm_cs(3),
      I5 => end_brst_rd_clr,
      O => end_brst_rd_clr_i_1_n_0
    );
end_brst_rd_clr_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => end_brst_rd_clr_i_1_n_0,
      Q => end_brst_rd_clr,
      R => \^bid_fifo_rst\
    );
end_brst_rd_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0020F020"
    )
        port map (
      I0 => \GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg_n_0\,
      I1 => brst_cnt_max_d1,
      I2 => s_axi_aresetn,
      I3 => end_brst_rd,
      I4 => end_brst_rd_clr,
      O => end_brst_rd_i_1_n_0
    );
end_brst_rd_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => end_brst_rd_i_1_n_0,
      Q => end_brst_rd,
      R => '0'
    );
last_bram_addr_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAABAAAAAAAAA"
    )
        port map (
      I0 => last_bram_addr_i_2_n_0,
      I1 => last_bram_addr_i_3_n_0,
      I2 => rd_adv_buf75_out,
      I3 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I4 => last_bram_addr_i_4_n_0,
      I5 => last_bram_addr_i_5_n_0,
      O => last_bram_addr0
    );
last_bram_addr_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => last_bram_addr_i_6_n_0,
      I1 => brst_cnt(0),
      I2 => brst_cnt(1),
      O => last_bram_addr_i_2_n_0
    );
last_bram_addr_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => rd_data_sm_cs(3),
      O => last_bram_addr_i_3_n_0
    );
last_bram_addr_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0D0D0D0D00000C00"
    )
        port map (
      I0 => \rd_data_sm_cs[1]_i_3_n_0\,
      I1 => \GEN_AR_DUAL.ar_active_i_2_n_0\,
      I2 => brst_zero_i_2_n_0,
      I3 => pend_rd_op_reg_n_0,
      I4 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I5 => bram_addr_ld_en,
      O => last_bram_addr_i_4_n_0
    );
last_bram_addr_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"81"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => rd_data_sm_cs(0),
      I2 => rd_data_sm_cs(1),
      O => last_bram_addr_i_5_n_0
    );
last_bram_addr_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => I_WRAP_BRST_n_16,
      I1 => \brst_cnt[7]_i_4_n_0\,
      I2 => brst_cnt(7),
      I3 => brst_cnt(2),
      O => last_bram_addr_i_6_n_0
    );
last_bram_addr_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => last_bram_addr0,
      Q => last_bram_addr,
      R => \^bid_fifo_rst\
    );
no_ar_ack_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAEAAA0AAA0AAA"
    )
        port map (
      I0 => no_ar_ack,
      I1 => bram_addr_ld_en,
      I2 => rd_data_sm_cs(0),
      I3 => \rd_data_sm_cs[3]_i_7_n_0\,
      I4 => rd_adv_buf75_out,
      I5 => rd_data_sm_cs(1),
      O => no_ar_ack_i_1_n_0
    );
no_ar_ack_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => no_ar_ack_i_1_n_0,
      Q => no_ar_ack,
      R => \^bid_fifo_rst\
    );
pend_rd_op_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAFFFEAAAA0002"
    )
        port map (
      I0 => pend_rd_op_i_2_n_0,
      I1 => pend_rd_op_i_3_n_0,
      I2 => rd_data_sm_cs(2),
      I3 => rd_data_sm_cs(3),
      I4 => pend_rd_op_i_4_n_0,
      I5 => pend_rd_op_reg_n_0,
      O => pend_rd_op_i_1_n_0
    );
pend_rd_op_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3FDD0CC033110000"
    )
        port map (
      I0 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => bram_addr_ld_en,
      I5 => pend_rd_op_i_5_n_0,
      O => pend_rd_op_i_2_n_0
    );
pend_rd_op_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"030323230FCFFFFF"
    )
        port map (
      I0 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(0),
      I3 => \^s_axi_rlast\,
      I4 => pend_rd_op_reg_n_0,
      I5 => bram_addr_ld_en,
      O => pend_rd_op_i_3_n_0
    );
pend_rd_op_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFEAEAFF"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => end_brst_rd,
      I2 => ar_active,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(1),
      I5 => pend_rd_op_i_6_n_0,
      O => pend_rd_op_i_4_n_0
    );
pend_rd_op_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => end_brst_rd,
      I2 => ar_active,
      O => pend_rd_op_i_5_n_0
    );
pend_rd_op_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1FFFFFFF1F5F1F5F"
    )
        port map (
      I0 => bram_en_int_i_8_n_0,
      I1 => \^s_axi_rlast\,
      I2 => \rd_data_sm_cs[3]_i_7_n_0\,
      I3 => pend_rd_op_reg_n_0,
      I4 => rd_adv_buf75_out,
      I5 => bram_en_int_i_9_n_0,
      O => pend_rd_op_i_6_n_0
    );
pend_rd_op_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => pend_rd_op_i_1_n_0,
      Q => pend_rd_op_reg_n_0,
      R => \^bid_fifo_rst\
    );
\rd_data_sm_cs[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF45554444"
    )
        port map (
      I0 => \rd_data_sm_cs[0]_i_2_n_0\,
      I1 => \rd_data_sm_cs[0]_i_3_n_0\,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => \rd_data_sm_cs[3]_i_7_n_0\,
      I5 => \rd_data_sm_cs[0]_i_4_n_0\,
      O => \rd_data_sm_cs[0]_i_1_n_0\
    );
\rd_data_sm_cs[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00D000D000D00000"
    )
        port map (
      I0 => rd_adv_buf75_out,
      I1 => bram_addr_ld_en,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => act_rd_burst,
      I5 => act_rd_burst_two,
      O => \rd_data_sm_cs[0]_i_2_n_0\
    );
\rd_data_sm_cs[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E0000000"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => pend_rd_op_reg_n_0,
      I2 => \^s_axi_rvalid\,
      I3 => s_axi_rready,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => \rd_data_sm_cs[0]_i_3_n_0\
    );
\rd_data_sm_cs[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000A300000FFF"
    )
        port map (
      I0 => rd_adv_buf75_out,
      I1 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I2 => rd_data_sm_cs(1),
      I3 => rd_data_sm_cs(3),
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(0),
      O => \rd_data_sm_cs[0]_i_4_n_0\
    );
\rd_data_sm_cs[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABBAABBAABAAAAA"
    )
        port map (
      I0 => \rd_data_sm_cs[1]_i_2_n_0\,
      I1 => \rd_data_sm_cs[2]_i_4_n_0\,
      I2 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I3 => \rd_data_sm_cs[1]_i_3_n_0\,
      I4 => rd_data_sm_cs(0),
      I5 => rd_data_sm_cs(1),
      O => \rd_data_sm_cs[1]_i_1_n_0\
    );
\rd_data_sm_cs[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA02AAAAAAAA"
    )
        port map (
      I0 => \rd_data_sm_cs[3]_i_7_n_0\,
      I1 => brst_zero,
      I2 => end_brst_rd,
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => \rd_data_sm_cs[1]_i_4_n_0\,
      O => \rd_data_sm_cs[1]_i_2_n_0\
    );
\rd_data_sm_cs[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => rd_data_sm_cs(3),
      O => \rd_data_sm_cs[1]_i_3_n_0\
    );
\rd_data_sm_cs[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFE000FFFFFFFF"
    )
        port map (
      I0 => act_rd_burst_two,
      I1 => act_rd_burst,
      I2 => rd_adv_buf75_out,
      I3 => bram_addr_ld_en,
      I4 => rd_data_sm_cs(1),
      I5 => rd_data_sm_cs(0),
      O => \rd_data_sm_cs[1]_i_4_n_0\
    );
\rd_data_sm_cs[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000005555FF0C"
    )
        port map (
      I0 => \rd_data_sm_cs[2]_i_2_n_0\,
      I1 => \rd_data_sm_cs[2]_i_3_n_0\,
      I2 => \FSM_sequential_rlast_sm_cs[2]_i_2_n_0\,
      I3 => \rd_data_sm_cs[2]_i_4_n_0\,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => \rd_data_sm_cs[2]_i_1_n_0\
    );
\rd_data_sm_cs[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F020F020F020F02F"
    )
        port map (
      I0 => bram_addr_ld_en,
      I1 => \rd_data_sm_cs[3]_i_8_n_0\,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => end_brst_rd,
      I5 => brst_zero,
      O => \rd_data_sm_cs[2]_i_2_n_0\
    );
\rd_data_sm_cs[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rd_data_sm_cs(0),
      I1 => rd_data_sm_cs(1),
      O => \rd_data_sm_cs[2]_i_3_n_0\
    );
\rd_data_sm_cs[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F00FF007F000000"
    )
        port map (
      I0 => I_WRAP_BRST_n_15,
      I1 => s_axi_rready,
      I2 => \^s_axi_rvalid\,
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => axi_rd_burst_two_reg_n_0,
      O => \rd_data_sm_cs[2]_i_4_n_0\
    );
\rd_data_sm_cs[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF0DFFF0F00DFF0"
    )
        port map (
      I0 => \rd_data_sm_cs[3]_i_3_n_0\,
      I1 => \rd_data_sm_cs[3]_i_4_n_0\,
      I2 => \rd_data_sm_cs[3]_i_5_n_0\,
      I3 => rd_adv_buf75_out,
      I4 => \rd_data_sm_cs[3]_i_6_n_0\,
      I5 => bram_addr_ld_en,
      O => rd_data_sm_ns
    );
\rd_data_sm_cs[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000080A000A080"
    )
        port map (
      I0 => \rd_data_sm_cs[3]_i_7_n_0\,
      I1 => bram_addr_ld_en,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => \rd_data_sm_cs[3]_i_8_n_0\,
      I5 => rd_adv_buf75_out,
      O => \rd_data_sm_cs[3]_i_2_n_0\
    );
\rd_data_sm_cs[3]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"45"
    )
        port map (
      I0 => brst_zero,
      I1 => axi_b2b_brst,
      I2 => end_brst_rd,
      O => \rd_data_sm_cs[3]_i_3_n_0\
    );
\rd_data_sm_cs[3]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CFFE"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => rd_data_sm_cs(3),
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      O => \rd_data_sm_cs[3]_i_4_n_0\
    );
\rd_data_sm_cs[3]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BFAD"
    )
        port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(2),
      I3 => rd_data_sm_cs(0),
      O => \rd_data_sm_cs[3]_i_5_n_0\
    );
\rd_data_sm_cs[3]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0407"
    )
        port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      O => \rd_data_sm_cs[3]_i_6_n_0\
    );
\rd_data_sm_cs[3]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => rd_data_sm_cs(3),
      O => \rd_data_sm_cs[3]_i_7_n_0\
    );
\rd_data_sm_cs[3]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1FFF"
    )
        port map (
      I0 => act_rd_burst_two,
      I1 => act_rd_burst,
      I2 => s_axi_rready,
      I3 => \^s_axi_rvalid\,
      O => \rd_data_sm_cs[3]_i_8_n_0\
    );
\rd_data_sm_cs_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => rd_data_sm_ns,
      D => \rd_data_sm_cs[0]_i_1_n_0\,
      Q => rd_data_sm_cs(0),
      R => \^bid_fifo_rst\
    );
\rd_data_sm_cs_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => rd_data_sm_ns,
      D => \rd_data_sm_cs[1]_i_1_n_0\,
      Q => rd_data_sm_cs(1),
      R => \^bid_fifo_rst\
    );
\rd_data_sm_cs_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => rd_data_sm_ns,
      D => \rd_data_sm_cs[2]_i_1_n_0\,
      Q => rd_data_sm_cs(2),
      R => \^bid_fifo_rst\
    );
\rd_data_sm_cs_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => rd_data_sm_ns,
      D => \rd_data_sm_cs[3]_i_2_n_0\,
      Q => rd_data_sm_cs(3),
      R => \^bid_fifo_rst\
    );
rd_skid_buf_ld_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000111111110000"
    )
        port map (
      I0 => rd_data_sm_cs(2),
      I1 => rd_data_sm_cs(3),
      I2 => \^s_axi_rvalid\,
      I3 => s_axi_rready,
      I4 => rd_data_sm_cs(0),
      I5 => rd_data_sm_cs(1),
      O => rd_skid_buf_ld_cmb
    );
rd_skid_buf_ld_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => rd_skid_buf_ld_cmb,
      Q => rd_skid_buf_ld_reg,
      R => \^bid_fifo_rst\
    );
rddata_mux_sel_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => rddata_mux_sel_cmb,
      I1 => rddata_mux_sel_i_3_n_0,
      I2 => rd_data_sm_cs(3),
      I3 => rddata_mux_sel,
      O => rddata_mux_sel_i_1_n_0
    );
rddata_mux_sel_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F010F0F00FF00000"
    )
        port map (
      I0 => act_rd_burst,
      I1 => act_rd_burst_two,
      I2 => rd_data_sm_cs(2),
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => rd_adv_buf75_out,
      O => rddata_mux_sel_cmb
    );
rddata_mux_sel_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5FF85F085F085F08"
    )
        port map (
      I0 => rd_data_sm_cs(1),
      I1 => axi_rd_burst_two_reg_n_0,
      I2 => rd_data_sm_cs(2),
      I3 => rd_data_sm_cs(0),
      I4 => \^s_axi_rvalid\,
      I5 => s_axi_rready,
      O => rddata_mux_sel_i_3_n_0
    );
rddata_mux_sel_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => rddata_mux_sel_i_1_n_0,
      Q => rddata_mux_sel,
      R => \^bid_fifo_rst\
    );
s_axi_arready_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EAAA"
    )
        port map (
      I0 => axi_arready_int,
      I1 => \^s_axi_rvalid\,
      I2 => s_axi_rready,
      I3 => axi_early_arready_int,
      O => s_axi_arready
    );
ua_narrow_load1_carry_i_13: unisim.vcomponents.CARRY4
     port map (
      CI => \ua_narrow_load1_carry_i_14__0_n_0\,
      CO(3 downto 1) => NLW_ua_narrow_load1_carry_i_13_CO_UNCONNECTED(3 downto 1),
      CO(0) => size_plus_lsb(8),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_ua_narrow_load1_carry_i_13_O_UNCONNECTED(3 downto 0),
      S(3 downto 0) => B"0001"
    );
\ua_narrow_load1_carry_i_14__0\: unisim.vcomponents.CARRY4
     port map (
      CI => ua_narrow_load1_carry_i_22_n_0,
      CO(3) => \ua_narrow_load1_carry_i_14__0_n_0\,
      CO(2) => \ua_narrow_load1_carry_i_14__0_n_1\,
      CO(1) => \ua_narrow_load1_carry_i_14__0_n_2\,
      CO(0) => \ua_narrow_load1_carry_i_14__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => size_plus_lsb(7 downto 4),
      S(3 downto 1) => size_plus_lsb0(7 downto 5),
      S(0) => \ua_narrow_load1_carry_i_26__0_n_0\
    );
ua_narrow_load1_carry_i_22: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ua_narrow_load1_carry_i_22_n_0,
      CO(2) => ua_narrow_load1_carry_i_22_n_1,
      CO(1) => ua_narrow_load1_carry_i_22_n_2,
      CO(0) => ua_narrow_load1_carry_i_22_n_3,
      CYINIT => '0',
      DI(3) => axi_byte_div_curr_arsize(1),
      DI(2) => size_plus_lsb0(2),
      DI(1) => I_WRAP_BRST_n_1,
      DI(0) => size_plus_lsb0(0),
      O(3 downto 0) => size_plus_lsb(3 downto 0),
      S(3) => \ua_narrow_load1_carry_i_30__0_n_0\,
      S(2) => \GEN_UA_NARROW.I_UA_NARROW_n_12\,
      S(1) => \GEN_UA_NARROW.I_UA_NARROW_n_13\,
      S(0) => \GEN_UA_NARROW.I_UA_NARROW_n_14\
    );
\ua_narrow_load1_carry_i_23__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0AAC00000000000"
    )
        port map (
      I0 => s_axi_arsize(2),
      I1 => axi_arsize_pipe(2),
      I2 => axi_arsize_pipe(1),
      I3 => axi_araddr_full,
      I4 => s_axi_arsize(1),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      O => size_plus_lsb0(7)
    );
\ua_narrow_load1_carry_i_24__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000B8308800"
    )
        port map (
      I0 => axi_arsize_pipe(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(1),
      I3 => axi_arsize_pipe(2),
      I4 => s_axi_arsize(2),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      O => size_plus_lsb0(6)
    );
\ua_narrow_load1_carry_i_25__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00C0000000C0A0A0"
    )
        port map (
      I0 => s_axi_arsize(2),
      I1 => axi_arsize_pipe(2),
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I3 => axi_arsize_pipe(1),
      I4 => axi_araddr_full,
      I5 => s_axi_arsize(1),
      O => size_plus_lsb0(5)
    );
\ua_narrow_load1_carry_i_26__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000C000CAA"
    )
        port map (
      I0 => s_axi_arsize(2),
      I1 => axi_arsize_pipe(2),
      I2 => axi_arsize_pipe(1),
      I3 => axi_araddr_full,
      I4 => s_axi_arsize(1),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      O => \ua_narrow_load1_carry_i_26__0_n_0\
    );
\ua_narrow_load1_carry_i_27__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000ACC0A00000000"
    )
        port map (
      I0 => s_axi_arsize(1),
      I1 => axi_arsize_pipe(1),
      I2 => s_axi_arsize(2),
      I3 => axi_araddr_full,
      I4 => axi_arsize_pipe(2),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      O => axi_byte_div_curr_arsize(1)
    );
\ua_narrow_load1_carry_i_28__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000047034400"
    )
        port map (
      I0 => axi_arsize_pipe(2),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(2),
      I3 => axi_arsize_pipe(1),
      I4 => s_axi_arsize(1),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      O => size_plus_lsb0(2)
    );
\ua_narrow_load1_carry_i_29__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000440347"
    )
        port map (
      I0 => axi_arsize_pipe(1),
      I1 => axi_araddr_full,
      I2 => s_axi_arsize(1),
      I3 => axi_arsize_pipe(2),
      I4 => s_axi_arsize(2),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      O => size_plus_lsb0(0)
    );
\ua_narrow_load1_carry_i_30__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFDFDF202020DF20"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_6\,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_7\,
      I3 => s_axi_araddr(3),
      I4 => axi_araddr_full,
      I5 => \GEN_AR_PIPE_DUAL.GEN_ARADDR[3].axi_araddr_pipe_reg_n_0_[3]\,
      O => \ua_narrow_load1_carry_i_30__0_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_wr_chnl is
  port (
    axi_aresetn_re_reg : out STD_LOGIC;
    BRAM_En_A : out STD_LOGIC;
    BRAM_WrData_A : out STD_LOGIC_VECTOR ( 127 downto 0 );
    axi_aresetn_d2 : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    p_0_in : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 9 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    bid_fifo_rst : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bready : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end axi_bram_ctrl_0_wr_chnl;

architecture STRUCTURE of axi_bram_ctrl_0_wr_chnl is
  signal BID_FIFO_n_0 : STD_LOGIC;
  signal BID_FIFO_n_1 : STD_LOGIC;
  signal BID_FIFO_n_2 : STD_LOGIC;
  signal BID_FIFO_n_4 : STD_LOGIC;
  signal BID_FIFO_n_8 : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_AWREADY.axi_awready_int_i_2_n_0\ : STD_LOGIC;
  signal \GEN_AWREADY.axi_awready_int_i_3_n_0\ : STD_LOGIC;
  signal \GEN_AWREADY.axi_awready_int_i_5_n_0\ : STD_LOGIC;
  signal \GEN_AW_DUAL.aw_active_i_2_n_0\ : STD_LOGIC;
  signal \GEN_AW_DUAL.wr_addr_sm_cs_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AW_DUAL.wr_addr_sm_cs_i_2_n_0\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg_n_0_[0]\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg_n_0_[1]\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg_n_0_[2]\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[3].axi_awaddr_pipe_reg_n_0_[3]\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.axi_awaddr_full_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_i_1_n_0\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg_n_0\ : STD_LOGIC;
  signal \GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_i_3_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[0]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[1]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[2]_i_5_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_10_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_11_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_12_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_14_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_15_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_16__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_17_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_18_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_19_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_20_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_21_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_22_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_23_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_24_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_25_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_26_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_27_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_28_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_29__0_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_2_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_30_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_31_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_32_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_33_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_4_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_5_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_6_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_7_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_8_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT.narrow_addr_int[3]_i_9_n_0\ : STD_LOGIC;
  signal \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal \GEN_NARROW_EN.curr_narrow_burst_i_1_n_0\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_0\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_1\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_2\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_3\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_4\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW_n_5\ : STD_LOGIC;
  signal \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.axi_wdata_full_reg_i_2_n_0\ : STD_LOGIC;
  signal \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.bram_en_int_i_2_n_0\ : STD_LOGIC;
  signal \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_i_2_n_0\ : STD_LOGIC;
  signal \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_1_n_0\ : STD_LOGIC;
  signal \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_2_n_0\ : STD_LOGIC;
  signal \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_3_n_0\ : STD_LOGIC;
  signal \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\ : STD_LOGIC;
  signal \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\ : STD_LOGIC;
  signal I_WRAP_BRST_n_0 : STD_LOGIC;
  signal I_WRAP_BRST_n_1 : STD_LOGIC;
  signal I_WRAP_BRST_n_16 : STD_LOGIC;
  signal I_WRAP_BRST_n_17 : STD_LOGIC;
  signal I_WRAP_BRST_n_18 : STD_LOGIC;
  signal I_WRAP_BRST_n_19 : STD_LOGIC;
  signal I_WRAP_BRST_n_20 : STD_LOGIC;
  signal I_WRAP_BRST_n_21 : STD_LOGIC;
  signal I_WRAP_BRST_n_23 : STD_LOGIC;
  signal I_WRAP_BRST_n_24 : STD_LOGIC;
  signal I_WRAP_BRST_n_25 : STD_LOGIC;
  signal I_WRAP_BRST_n_3 : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal aw_active : STD_LOGIC;
  signal awaddr_pipe_ld22_out : STD_LOGIC;
  signal axi_aresetn_d1 : STD_LOGIC;
  signal \^axi_aresetn_d2\ : STD_LOGIC;
  signal axi_aresetn_re : STD_LOGIC;
  signal \^axi_aresetn_re_reg\ : STD_LOGIC;
  signal axi_awaddr_full : STD_LOGIC;
  signal axi_awburst_pipe : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_awid_pipe : STD_LOGIC;
  signal axi_awlen_pipe : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_awlen_pipe_1_or_2 : STD_LOGIC;
  signal axi_awsize_pipe : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_bvalid_int_i_1_n_0 : STD_LOGIC;
  signal axi_byte_div_curr_awsize : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_wdata_full_cmb : STD_LOGIC;
  signal axi_wdata_full_cmb115_out : STD_LOGIC;
  signal axi_wdata_full_reg : STD_LOGIC;
  signal axi_wr_burst : STD_LOGIC;
  signal axi_wr_burst_cmb0 : STD_LOGIC;
  signal axi_wr_burst_i_1_n_0 : STD_LOGIC;
  signal axi_wr_burst_i_2_n_0 : STD_LOGIC;
  signal axi_wr_burst_i_3_n_0 : STD_LOGIC;
  signal axi_wready_int_mod_i_1_n_0 : STD_LOGIC;
  signal bid_gets_fifo_load : STD_LOGIC;
  signal bid_gets_fifo_load_d1 : STD_LOGIC;
  signal bid_gets_fifo_load_d1_i_2_n_0 : STD_LOGIC;
  signal bram_addr_inc : STD_LOGIC;
  signal bram_addr_ld : STD_LOGIC_VECTOR ( 13 downto 12 );
  signal bram_addr_ld_en : STD_LOGIC;
  signal bram_addr_ld_en_mod : STD_LOGIC;
  signal bram_addr_rst_cmb : STD_LOGIC;
  signal bram_en_cmb : STD_LOGIC;
  signal bvalid_cnt : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \bvalid_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \bvalid_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \bvalid_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal bvalid_cnt_inc : STD_LOGIC;
  signal bvalid_cnt_inc11_out : STD_LOGIC;
  signal clr_bram_we : STD_LOGIC;
  signal clr_bram_we_cmb : STD_LOGIC;
  signal curr_awlen_reg_1_or_2 : STD_LOGIC;
  signal curr_awlen_reg_1_or_20 : STD_LOGIC;
  signal curr_awlen_reg_1_or_2_i_2_n_0 : STD_LOGIC;
  signal curr_awlen_reg_1_or_2_i_4_n_0 : STD_LOGIC;
  signal curr_awlen_reg_1_or_2_i_5_n_0 : STD_LOGIC;
  signal curr_fixed_burst : STD_LOGIC;
  signal curr_fixed_burst_reg : STD_LOGIC;
  signal curr_narrow_burst : STD_LOGIC;
  signal curr_narrow_burst_cmb : STD_LOGIC;
  signal curr_narrow_burst_en : STD_LOGIC;
  signal curr_wrap_burst_reg : STD_LOGIC;
  signal curr_wrap_burst_reg_i_2_n_0 : STD_LOGIC;
  signal curr_wrap_burst_reg_i_3_n_0 : STD_LOGIC;
  signal delay_aw_active_clr : STD_LOGIC;
  signal last_data_ack_mod : STD_LOGIC;
  signal narrow_addr_int : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal narrow_bram_addr_inc : STD_LOGIC;
  signal narrow_bram_addr_inc_d1 : STD_LOGIC;
  signal narrow_burst_cnt_ld_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^p_0_in\ : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_25_in : STD_LOGIC;
  signal p_9_out : STD_LOGIC;
  signal \^s_axi_awready\ : STD_LOGIC;
  signal \^s_axi_bid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  signal size_plus_lsb : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal size_plus_lsb0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \ua_narrow_load1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal ua_narrow_load1_carry_i_10_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_11_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_12_n_0 : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_13__0_n_0\ : STD_LOGIC;
  signal ua_narrow_load1_carry_i_15_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_15_n_1 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_15_n_2 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_15_n_3 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_16_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_17_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_19_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_1_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_20_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_21_n_0 : STD_LOGIC;
  signal \ua_narrow_load1_carry_i_22__0_n_0\ : STD_LOGIC;
  signal ua_narrow_load1_carry_i_23_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_23_n_1 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_23_n_2 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_23_n_3 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_28_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_29_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_2_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_30_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_33_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_3_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_4_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_5_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_6_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_7_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_8_n_0 : STD_LOGIC;
  signal ua_narrow_load1_carry_i_9_n_0 : STD_LOGIC;
  signal wr_addr_sm_cs : STD_LOGIC;
  signal wr_data_sm_cs : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of wr_data_sm_cs : signal is "yes";
  signal NLW_ua_narrow_load1_carry_i_14_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_ua_narrow_load1_carry_i_14_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_3\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_4\ : label is "soft_lutpair104";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[2]\ : label is "yes";
  attribute SOFT_HLUTNM of \GEN_AWREADY.axi_aresetn_re_reg_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_11\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_19\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_27\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_31\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[3]_i_32\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of axi_wready_int_mod_i_1 : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of bid_gets_fifo_load_d1_i_2 : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of curr_awlen_reg_1_or_2_i_2 : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of curr_awlen_reg_1_or_2_i_4 : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of curr_awlen_reg_1_or_2_i_5 : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of curr_fixed_burst_reg_i_2 : label is "soft_lutpair102";
begin
  Q(9 downto 0) <= \^q\(9 downto 0);
  axi_aresetn_d2 <= \^axi_aresetn_d2\;
  axi_aresetn_re_reg <= \^axi_aresetn_re_reg\;
  p_0_in <= \^p_0_in\;
  s_axi_awready <= \^s_axi_awready\;
  s_axi_bid(0) <= \^s_axi_bid\(0);
  s_axi_bvalid <= \^s_axi_bvalid\;
  s_axi_wready <= \^s_axi_wready\;
BID_FIFO: entity work.axi_bram_ctrl_0_SRL_FIFO
     port map (
      \GEN_AWREADY.axi_aresetn_d2_reg\ => \^axi_aresetn_d2\,
      \GEN_AW_DUAL.wr_addr_sm_cs_reg\ => BID_FIFO_n_1,
      \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg\ => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg_n_0\,
      aw_active => aw_active,
      axi_awaddr_full => axi_awaddr_full,
      axi_awid_pipe => axi_awid_pipe,
      axi_awlen_pipe_1_or_2 => axi_awlen_pipe_1_or_2,
      \axi_bid_int_reg[0]\ => BID_FIFO_n_8,
      axi_bvalid_int_reg => \^s_axi_bvalid\,
      axi_wdata_full_cmb115_out => axi_wdata_full_cmb115_out,
      axi_wr_burst => axi_wr_burst,
      bid_fifo_rst => bid_fifo_rst,
      bid_gets_fifo_load => bid_gets_fifo_load,
      bid_gets_fifo_load_d1 => bid_gets_fifo_load_d1,
      bid_gets_fifo_load_d1_reg => BID_FIFO_n_0,
      bid_gets_fifo_load_d1_reg_0 => BID_FIFO_n_2,
      bid_gets_fifo_load_d1_reg_1 => BID_FIFO_n_4,
      bvalid_cnt(2 downto 0) => bvalid_cnt(2 downto 0),
      bvalid_cnt_inc => bvalid_cnt_inc,
      bvalid_cnt_inc11_out => bvalid_cnt_inc11_out,
      \bvalid_cnt_reg[1]\ => bid_gets_fifo_load_d1_i_2_n_0,
      curr_awlen_reg_1_or_2 => curr_awlen_reg_1_or_2,
      last_data_ack_mod => last_data_ack_mod,
      \out\(2 downto 0) => wr_data_sm_cs(2 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awready => \^s_axi_awready\,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => \^s_axi_bid\(0),
      s_axi_bready => s_axi_bready,
      s_axi_wlast => s_axi_wlast,
      s_axi_wvalid => s_axi_wvalid,
      wr_addr_sm_cs => wr_addr_sm_cs
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_2_n_0\,
      I1 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_3_n_0\,
      I2 => wr_data_sm_cs(0),
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_1_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05051F1A"
    )
        port map (
      I0 => wr_data_sm_cs(1),
      I1 => axi_wr_burst_cmb0,
      I2 => wr_data_sm_cs(0),
      I3 => axi_wdata_full_cmb115_out,
      I4 => wr_data_sm_cs(2),
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_2_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5515"
    )
        port map (
      I0 => BID_FIFO_n_2,
      I1 => bvalid_cnt(1),
      I2 => bvalid_cnt(2),
      I3 => bvalid_cnt(0),
      O => axi_wr_burst_cmb0
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_2_n_0\,
      I1 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_3_n_0\,
      I2 => wr_data_sm_cs(1),
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_1_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000554000555540"
    )
        port map (
      I0 => wr_data_sm_cs(1),
      I1 => s_axi_wlast,
      I2 => axi_wdata_full_cmb115_out,
      I3 => wr_data_sm_cs(0),
      I4 => wr_data_sm_cs(2),
      I5 => axi_wr_burst,
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_2_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_2_n_0\,
      I1 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_3_n_0\,
      I2 => wr_data_sm_cs(2),
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_1_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44010001"
    )
        port map (
      I0 => wr_data_sm_cs(2),
      I1 => wr_data_sm_cs(1),
      I2 => axi_wdata_full_cmb115_out,
      I3 => wr_data_sm_cs(0),
      I4 => s_axi_wvalid,
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_2_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FCB00033FCB0"
    )
        port map (
      I0 => s_axi_wlast,
      I1 => wr_data_sm_cs(0),
      I2 => s_axi_wvalid,
      I3 => wr_data_sm_cs(1),
      I4 => wr_data_sm_cs(2),
      I5 => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_4_n_0\,
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_3_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"45"
    )
        port map (
      I0 => axi_wdata_full_cmb115_out,
      I1 => BID_FIFO_n_0,
      I2 => axi_awaddr_full,
      O => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_4_n_0\
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[0]_i_1_n_0\,
      Q => wr_data_sm_cs(0),
      R => bid_fifo_rst
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[1]_i_1_n_0\,
      Q => wr_data_sm_cs(1),
      R => bid_fifo_rst
    );
\FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs[2]_i_1_n_0\,
      Q => wr_data_sm_cs(2),
      R => bid_fifo_rst
    );
\GEN_AWREADY.axi_aresetn_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_aresetn,
      Q => axi_aresetn_d1,
      R => '0'
    );
\GEN_AWREADY.axi_aresetn_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_aresetn_d1,
      Q => \^axi_aresetn_d2\,
      R => '0'
    );
\GEN_AWREADY.axi_aresetn_re_reg_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => axi_aresetn_d1,
      O => axi_aresetn_re
    );
\GEN_AWREADY.axi_aresetn_re_reg_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_aresetn_re,
      Q => \^axi_aresetn_re_reg\,
      R => '0'
    );
\GEN_AWREADY.axi_awready_int_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF7F7FFFF00F0"
    )
        port map (
      I0 => \^axi_aresetn_d2\,
      I1 => \GEN_AWREADY.axi_awready_int_i_3_n_0\,
      I2 => axi_awaddr_full,
      I3 => BID_FIFO_n_0,
      I4 => \^axi_aresetn_re_reg\,
      I5 => \^s_axi_awready\,
      O => \GEN_AWREADY.axi_awready_int_i_2_n_0\
    );
\GEN_AWREADY.axi_awready_int_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5444444400000000"
    )
        port map (
      I0 => \GEN_AWREADY.axi_awready_int_i_5_n_0\,
      I1 => aw_active,
      I2 => bvalid_cnt(1),
      I3 => bvalid_cnt(2),
      I4 => bvalid_cnt(0),
      I5 => s_axi_awvalid,
      O => \GEN_AWREADY.axi_awready_int_i_3_n_0\
    );
\GEN_AWREADY.axi_awready_int_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABABABABABABABA"
    )
        port map (
      I0 => wr_addr_sm_cs,
      I1 => BID_FIFO_n_2,
      I2 => last_data_ack_mod,
      I3 => bvalid_cnt(0),
      I4 => bvalid_cnt(2),
      I5 => bvalid_cnt(1),
      O => \GEN_AWREADY.axi_awready_int_i_5_n_0\
    );
\GEN_AWREADY.axi_awready_int_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AWREADY.axi_awready_int_i_2_n_0\,
      Q => \^s_axi_awready\,
      R => bid_fifo_rst
    );
\GEN_AW_DUAL.aw_active_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^axi_aresetn_d2\,
      O => \^p_0_in\
    );
\GEN_AW_DUAL.aw_active_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFFFFF0000FFFF"
    )
        port map (
      I0 => wr_data_sm_cs(1),
      I1 => wr_data_sm_cs(0),
      I2 => wr_data_sm_cs(2),
      I3 => delay_aw_active_clr,
      I4 => BID_FIFO_n_0,
      I5 => aw_active,
      O => \GEN_AW_DUAL.aw_active_i_2_n_0\
    );
\GEN_AW_DUAL.aw_active_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AW_DUAL.aw_active_i_2_n_0\,
      Q => aw_active,
      R => \^p_0_in\
    );
\GEN_AW_DUAL.wr_addr_sm_cs_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010001000100000"
    )
        port map (
      I0 => \GEN_AW_DUAL.wr_addr_sm_cs_i_2_n_0\,
      I1 => wr_addr_sm_cs,
      I2 => s_axi_awvalid,
      I3 => axi_awaddr_full,
      I4 => BID_FIFO_n_1,
      I5 => aw_active,
      O => \GEN_AW_DUAL.wr_addr_sm_cs_i_1_n_0\
    );
\GEN_AW_DUAL.wr_addr_sm_cs_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000040"
    )
        port map (
      I0 => BID_FIFO_n_1,
      I1 => last_data_ack_mod,
      I2 => axi_awaddr_full,
      I3 => curr_awlen_reg_1_or_2,
      I4 => axi_awlen_pipe_1_or_2,
      I5 => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg_n_0\,
      O => \GEN_AW_DUAL.wr_addr_sm_cs_i_2_n_0\
    );
\GEN_AW_DUAL.wr_addr_sm_cs_reg\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AW_DUAL.wr_addr_sm_cs_i_1_n_0\,
      Q => wr_addr_sm_cs,
      R => \^p_0_in\
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(0),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg_n_0_[0]\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(10),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(11),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(12),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(13),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(1),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg_n_0_[1]\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(2),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg_n_0_[2]\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[3].axi_awaddr_pipe_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(3),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[3].axi_awaddr_pipe_reg_n_0_[3]\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(4),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(5),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(6),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(7),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(8),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awaddr(9),
      Q => \GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awaddr_full_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F8000800"
    )
        port map (
      I0 => \^axi_aresetn_d2\,
      I1 => \GEN_AWREADY.axi_awready_int_i_3_n_0\,
      I2 => axi_awaddr_full,
      I3 => s_axi_aresetn,
      I4 => BID_FIFO_n_0,
      O => \GEN_AW_PIPE_DUAL.axi_awaddr_full_i_1_n_0\
    );
\GEN_AW_PIPE_DUAL.axi_awaddr_full_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AW_PIPE_DUAL.axi_awaddr_full_i_1_n_0\,
      Q => axi_awaddr_full,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F700F700F700FF08"
    )
        port map (
      I0 => \^axi_aresetn_d2\,
      I1 => \GEN_AWREADY.axi_awready_int_i_3_n_0\,
      I2 => axi_awaddr_full,
      I3 => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg_n_0\,
      I4 => s_axi_awburst(0),
      I5 => s_axi_awburst(1),
      O => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_i_1_n_0\
    );
\GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_i_1_n_0\,
      Q => \GEN_AW_PIPE_DUAL.axi_awburst_pipe_fixed_reg_n_0\,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awburst_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awburst(0),
      Q => axi_awburst_pipe(0),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awburst_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awburst(1),
      Q => axi_awburst_pipe(1),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awid_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awid(0),
      Q => axi_awid_pipe,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \^axi_aresetn_d2\,
      I1 => \GEN_AWREADY.axi_awready_int_i_3_n_0\,
      I2 => axi_awaddr_full,
      O => awaddr_pipe_ld22_out
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => s_axi_awlen(5),
      I1 => s_axi_awlen(4),
      I2 => s_axi_awlen(7),
      I3 => \GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_i_3_n_0\,
      O => p_9_out
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => s_axi_awlen(3),
      I1 => s_axi_awlen(2),
      I2 => s_axi_awlen(6),
      I3 => s_axi_awlen(1),
      O => \GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_i_3_n_0\
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_1_or_2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => p_9_out,
      Q => axi_awlen_pipe_1_or_2,
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(0),
      Q => axi_awlen_pipe(0),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(1),
      Q => axi_awlen_pipe(1),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(2),
      Q => axi_awlen_pipe(2),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(3),
      Q => axi_awlen_pipe(3),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(4),
      Q => axi_awlen_pipe(4),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(5),
      Q => axi_awlen_pipe(5),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(6),
      Q => axi_awlen_pipe(6),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awlen_pipe_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awlen(7),
      Q => axi_awlen_pipe(7),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awsize(0),
      Q => axi_awsize_pipe(0),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awsize(1),
      Q => axi_awsize_pipe(1),
      R => '0'
    );
\GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => awaddr_pipe_ld22_out,
      D => s_axi_awsize(2),
      Q => axi_awsize_pipe(2),
      R => '0'
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFFFFFFFFFF"
    )
        port map (
      I0 => narrow_addr_int(2),
      I1 => narrow_addr_int(0),
      I2 => narrow_addr_int(1),
      I3 => narrow_addr_int(3),
      I4 => curr_narrow_burst,
      I5 => bram_addr_inc,
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \^q\(4),
      I1 => \^q\(3),
      I2 => \^q\(2),
      I3 => \^q\(1),
      I4 => \^q\(0),
      O => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4__0_n_0\
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(6),
      Q => \^q\(6),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(7),
      Q => \^q\(7),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en_mod,
      D => bram_addr_ld(12),
      Q => \^q\(8),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en_mod,
      D => bram_addr_ld(13),
      Q => \^q\(9),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(0),
      Q => \^q\(0),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(1),
      Q => \^q\(1),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(2),
      Q => \^q\(2),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(3),
      Q => \^q\(3),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(4),
      Q => \^q\(4),
      R => I_WRAP_BRST_n_0
    );
\GEN_DUAL_ADDR_CNT.bram_addr_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => I_WRAP_BRST_n_1,
      D => p_1_in(5),
      Q => \^q\(5),
      R => I_WRAP_BRST_n_0
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7444744474777444"
    )
        port map (
      I0 => narrow_addr_int(0),
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\,
      I2 => narrow_burst_cnt_ld_reg(0),
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4_n_0\,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[0]_i_1_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFD5D000002A2"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => s_axi_awsize(1),
      I2 => axi_awaddr_full,
      I3 => axi_awsize_pipe(1),
      I4 => I_WRAP_BRST_n_21,
      I5 => ua_narrow_load1_carry_i_12_n_0,
      O => \GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2E1D2E1D0C0C3F3F"
    )
        port map (
      I0 => I_WRAP_BRST_n_21,
      I1 => I_WRAP_BRST_n_20,
      I2 => ua_narrow_load1_carry_i_9_n_0,
      I3 => ua_narrow_load1_carry_i_20_n_0,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_30_n_0\,
      I5 => I_WRAP_BRST_n_19,
      O => \GEN_NARROW_CNT.narrow_addr_int[1]_i_3_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888B888B8BBB888"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[2]_i_2_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\,
      I2 => narrow_burst_cnt_ld_reg(2),
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4_n_0\,
      I4 => \GEN_UA_NARROW.I_UA_NARROW_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[2]_i_3_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_1_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E1"
    )
        port map (
      I0 => narrow_addr_int(1),
      I1 => narrow_addr_int(0),
      I2 => narrow_addr_int(2),
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_2_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"555566666A66AAAA"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[2]_i_4_n_0\,
      I1 => \ua_narrow_load1_carry_i_13__0_n_0\,
      I2 => ua_narrow_load1_carry_i_9_n_0,
      I3 => I_WRAP_BRST_n_20,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[2]_i_5_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_15_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_3_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"005300A3FF53FFA3"
    )
        port map (
      I0 => I_WRAP_BRST_n_21,
      I1 => ua_narrow_load1_carry_i_30_n_0,
      I2 => I_WRAP_BRST_n_19,
      I3 => I_WRAP_BRST_n_20,
      I4 => ua_narrow_load1_carry_i_29_n_0,
      I5 => ua_narrow_load1_carry_i_28_n_0,
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_4_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFD5FFF5DFDFFFFF"
    )
        port map (
      I0 => I_WRAP_BRST_n_21,
      I1 => axi_awsize_pipe(2),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(2),
      I4 => axi_awsize_pipe(1),
      I5 => s_axi_awsize(1),
      O => \GEN_NARROW_CNT.narrow_addr_int[2]_i_5_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000000FFFFFFFF"
    )
        port map (
      I0 => curr_narrow_burst,
      I1 => wr_data_sm_cs(1),
      I2 => wr_data_sm_cs(2),
      I3 => wr_data_sm_cs(0),
      I4 => s_axi_wvalid,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awburst_pipe(0),
      I1 => axi_awaddr_full,
      I2 => s_axi_awburst(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_10_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awburst_pipe(1),
      I1 => axi_awaddr_full,
      I2 => s_axi_awburst(1),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_11_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => curr_narrow_burst_cmb,
      I1 => BID_FIFO_n_0,
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_29__0_n_0\,
      I3 => curr_fixed_burst,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_12_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000047034400"
    )
        port map (
      I0 => axi_awsize_pipe(2),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(2),
      I3 => axi_awsize_pipe(1),
      I4 => s_axi_awsize(1),
      I5 => I_WRAP_BRST_n_21,
      O => size_plus_lsb0(2)
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2E3F2E3F0C0C3F3F"
    )
        port map (
      I0 => I_WRAP_BRST_n_21,
      I1 => I_WRAP_BRST_n_20,
      I2 => ua_narrow_load1_carry_i_9_n_0,
      I3 => ua_narrow_load1_carry_i_20_n_0,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_30_n_0\,
      I5 => I_WRAP_BRST_n_19,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_14_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA80802A20000"
    )
        port map (
      I0 => curr_narrow_burst_cmb,
      I1 => s_axi_awsize(2),
      I2 => axi_awaddr_full,
      I3 => axi_awsize_pipe(2),
      I4 => \ua_narrow_load1_carry_i_22__0_n_0\,
      I5 => ua_narrow_load1_carry_i_8_n_0,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_15_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_16__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBFF"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_20_n_0,
      I1 => I_WRAP_BRST_n_19,
      I2 => I_WRAP_BRST_n_20,
      I3 => I_WRAP_BRST_n_21,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_16__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCA000A0"
    )
        port map (
      I0 => s_axi_awsize(1),
      I1 => axi_awsize_pipe(1),
      I2 => s_axi_awsize(2),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(2),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_17_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axi_awlen_pipe(7),
      I1 => s_axi_awlen(7),
      I2 => I_WRAP_BRST_n_21,
      I3 => axi_awlen_pipe(6),
      I4 => axi_awaddr_full,
      I5 => s_axi_awlen(6),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_18_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_19\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"335ACC5A"
    )
        port map (
      I0 => s_axi_awsize(1),
      I1 => axi_awsize_pipe(1),
      I2 => s_axi_awsize(0),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_19_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAEAFBEA"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4_n_0\,
      I2 => narrow_burst_cnt_ld_reg(3),
      I3 => \GEN_UA_NARROW.I_UA_NARROW_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_5_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_6_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_2_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axi_awlen_pipe(5),
      I1 => s_axi_awlen(5),
      I2 => I_WRAP_BRST_n_21,
      I3 => axi_awlen_pipe(4),
      I4 => axi_awaddr_full,
      I5 => s_axi_awlen(4),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_20_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_21\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3A3F0A0A"
    )
        port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      I1 => I_WRAP_BRST_n_17,
      I2 => I_WRAP_BRST_n_21,
      I3 => I_WRAP_BRST_n_18,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_27_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_21_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFDDDFDAAADDDAD"
    )
        port map (
      I0 => I_WRAP_BRST_n_19,
      I1 => I_WRAP_BRST_n_16,
      I2 => s_axi_awsize(0),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(0),
      I5 => I_WRAP_BRST_n_23,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_22_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCAACCAAFCFFFCAA"
    )
        port map (
      I0 => curr_awlen_reg_1_or_2_i_4_n_0,
      I1 => curr_awlen_reg_1_or_2_i_2_n_0,
      I2 => I_WRAP_BRST_n_16,
      I3 => I_WRAP_BRST_n_21,
      I4 => I_WRAP_BRST_n_23,
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_23_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00011101AAA111A1"
    )
        port map (
      I0 => I_WRAP_BRST_n_19,
      I1 => I_WRAP_BRST_n_16,
      I2 => s_axi_awsize(0),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(0),
      I5 => I_WRAP_BRST_n_23,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_24_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axi_awlen_pipe(1),
      I1 => s_axi_awlen(1),
      I2 => I_WRAP_BRST_n_21,
      I3 => axi_awlen_pipe(0),
      I4 => axi_awaddr_full,
      I5 => s_axi_awlen(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_25_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axi_awlen_pipe(2),
      I1 => s_axi_awlen(2),
      I2 => I_WRAP_BRST_n_21,
      I3 => axi_awlen_pipe(3),
      I4 => axi_awaddr_full,
      I5 => s_axi_awlen(3),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_26_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_27\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCA533A5"
    )
        port map (
      I0 => s_axi_awsize(1),
      I1 => axi_awsize_pipe(1),
      I2 => s_axi_awsize(0),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(0),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_27_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEFEFE0AFA0AFA0"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_31_n_0\,
      I1 => I_WRAP_BRST_n_18,
      I2 => I_WRAP_BRST_n_21,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_32_n_0\,
      I4 => I_WRAP_BRST_n_17,
      I5 => I_WRAP_BRST_n_20,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_28_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_29__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000440347"
    )
        port map (
      I0 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg_n_0_[0]\,
      I1 => axi_awaddr_full,
      I2 => s_axi_awaddr(0),
      I3 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg_n_0_[2]\,
      I4 => s_axi_awaddr(2),
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_33_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_29__0_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DDD0"
    )
        port map (
      I0 => curr_narrow_burst_cmb,
      I1 => BID_FIFO_n_0,
      I2 => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3_n_0\,
      I3 => narrow_bram_addr_inc_d1,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_30\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(2),
      I1 => axi_awsize_pipe(0),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(0),
      I4 => size_plus_lsb(1),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_30_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_31\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awlen_pipe(4),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(4),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_31_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_32\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awlen_pipe(5),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(5),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_32_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_33\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_awaddr(3),
      I1 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[3].axi_awaddr_pipe_reg_n_0_[3]\,
      I2 => s_axi_awaddr(1),
      I3 => axi_awaddr_full,
      I4 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg_n_0_[1]\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_33_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFF010000"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_7_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_8_n_0\,
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_9_n_0\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_10_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_11_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_12_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9595A995A9A9A9A9"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_16_n_0,
      I1 => size_plus_lsb0(2),
      I2 => ua_narrow_load1_carry_i_17_n_0,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_14_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_15_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_16__0_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_5_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000DDDDDDDD0"
    )
        port map (
      I0 => curr_narrow_burst_cmb,
      I1 => BID_FIFO_n_0,
      I2 => narrow_addr_int(2),
      I3 => narrow_addr_int(0),
      I4 => narrow_addr_int(1),
      I5 => narrow_addr_int(3),
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_6_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F404FFFFF404F404"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_17_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_18_n_0\,
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_19_n_0\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_20_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_21_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_22_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_7_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3B3BBAAA3A0ABABA"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_23_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_24_n_0\,
      I2 => I_WRAP_BRST_n_20,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_25_n_0\,
      I4 => I_WRAP_BRST_n_19,
      I5 => I_WRAP_BRST_n_21,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_8_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int[3]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF8FFF888"
    )
        port map (
      I0 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_17_n_0\,
      I1 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_26_n_0\,
      I2 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_20_n_0\,
      I3 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_27_n_0\,
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_18_n_0\,
      I5 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_28_n_0\,
      O => \GEN_NARROW_CNT.narrow_addr_int[3]_i_9_n_0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1_n_0\,
      D => \GEN_NARROW_CNT.narrow_addr_int[0]_i_1_n_0\,
      Q => narrow_addr_int(0),
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1_n_0\,
      D => \GEN_UA_NARROW.I_UA_NARROW_n_1\,
      Q => narrow_addr_int(1),
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1_n_0\,
      D => \GEN_NARROW_CNT.narrow_addr_int[2]_i_1_n_0\,
      Q => narrow_addr_int(2),
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_NARROW_CNT.narrow_addr_int[3]_i_1_n_0\,
      D => \GEN_NARROW_CNT.narrow_addr_int[3]_i_2_n_0\,
      Q => narrow_addr_int(3),
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000008"
    )
        port map (
      I0 => bram_addr_inc,
      I1 => curr_narrow_burst,
      I2 => narrow_addr_int(3),
      I3 => narrow_addr_int(1),
      I4 => narrow_addr_int(0),
      I5 => narrow_addr_int(2),
      O => narrow_bram_addr_inc
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => wr_data_sm_cs(1),
      I1 => wr_data_sm_cs(2),
      I2 => wr_data_sm_cs(0),
      I3 => s_axi_wvalid,
      O => bram_addr_inc
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_bram_addr_inc,
      Q => narrow_bram_addr_inc_d1,
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888BBB8B"
    )
        port map (
      I0 => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[0]\,
      I1 => BID_FIFO_n_0,
      I2 => s_axi_awsize(2),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(2),
      O => narrow_burst_cnt_ld_reg(0)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888B8B8B"
    )
        port map (
      I0 => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[1]\,
      I1 => BID_FIFO_n_0,
      I2 => I_WRAP_BRST_n_20,
      I3 => I_WRAP_BRST_n_21,
      I4 => I_WRAP_BRST_n_19,
      O => narrow_burst_cnt_ld_reg(1)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888888BBB8B"
    )
        port map (
      I0 => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[2]\,
      I1 => BID_FIFO_n_0,
      I2 => s_axi_awsize(1),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(1),
      I5 => I_WRAP_BRST_n_20,
      O => narrow_burst_cnt_ld_reg(2)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888B8B8B888B8"
    )
        port map (
      I0 => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[3]\,
      I1 => BID_FIFO_n_0,
      I2 => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      I3 => s_axi_awsize(0),
      I4 => axi_awaddr_full,
      I5 => axi_awsize_pipe(0),
      O => narrow_burst_cnt_ld_reg(3)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_reg(0),
      Q => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[0]\,
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_reg(1),
      Q => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[1]\,
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_reg(2),
      Q => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[2]\,
      R => bid_fifo_rst
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => narrow_burst_cnt_ld_reg(3),
      Q => \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg_n_0_[3]\,
      R => bid_fifo_rst
    );
\GEN_NARROW_EN.axi_wlast_d1_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^s_axi_wready\,
      I1 => s_axi_wlast,
      I2 => s_axi_wvalid,
      O => p_25_in
    );
\GEN_NARROW_EN.axi_wlast_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => p_25_in,
      Q => last_data_ack_mod,
      R => bid_fifo_rst
    );
\GEN_NARROW_EN.curr_narrow_burst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C0A000A0A0"
    )
        port map (
      I0 => curr_narrow_burst,
      I1 => curr_narrow_burst_cmb,
      I2 => s_axi_aresetn,
      I3 => last_data_ack_mod,
      I4 => p_25_in,
      I5 => curr_narrow_burst_en,
      O => \GEN_NARROW_EN.curr_narrow_burst_i_1_n_0\
    );
\GEN_NARROW_EN.curr_narrow_burst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000055511151"
    )
        port map (
      I0 => BID_FIFO_n_0,
      I1 => curr_awlen_reg_1_or_20,
      I2 => s_axi_awlen(0),
      I3 => axi_awaddr_full,
      I4 => axi_awlen_pipe(0),
      I5 => curr_fixed_burst,
      O => curr_narrow_burst_en
    );
\GEN_NARROW_EN.curr_narrow_burst_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_NARROW_EN.curr_narrow_burst_i_1_n_0\,
      Q => curr_narrow_burst,
      R => '0'
    );
\GEN_UA_NARROW.I_UA_NARROW\: entity work.axi_bram_ctrl_0_ua_narrow
     port map (
      CO(0) => \GEN_UA_NARROW.I_UA_NARROW_n_0\,
      D(0) => \GEN_UA_NARROW.I_UA_NARROW_n_1\,
      DI(2) => ua_narrow_load1_carry_i_1_n_0,
      DI(1) => ua_narrow_load1_carry_i_2_n_0,
      DI(0) => ua_narrow_load1_carry_i_3_n_0,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg[0]\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[0].axi_awaddr_pipe_reg_n_0_[0]\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg[1]\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[1].axi_awaddr_pipe_reg_n_0_[1]\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg[2]\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[2].axi_awaddr_pipe_reg_n_0_[2]\,
      \GEN_AW_PIPE_DUAL.axi_awburst_pipe_reg[0]\ => \GEN_NARROW_CNT.narrow_addr_int[3]_i_4_n_0\,
      \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[0]\ => \GEN_NARROW_CNT.narrow_addr_int[1]_i_3_n_0\,
      \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]\(0) => \ua_narrow_load1_carry__0_i_1_n_0\,
      \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[1]_0\ => I_WRAP_BRST_n_24,
      \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\ => ua_narrow_load1_carry_i_12_n_0,
      \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]_0\(2 downto 0) => axi_awsize_pipe(2 downto 0),
      \GEN_NARROW_CNT.narrow_addr_int_reg[2]\(2) => \GEN_UA_NARROW.I_UA_NARROW_n_3\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[2]\(1) => \GEN_UA_NARROW.I_UA_NARROW_n_4\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[2]\(0) => \GEN_UA_NARROW.I_UA_NARROW_n_5\,
      \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\ => \GEN_NARROW_CNT.narrow_addr_int[3]_i_3_n_0\,
      \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\(0) => narrow_burst_cnt_ld_reg(1),
      \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[3]\ => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      Q(1 downto 0) => narrow_addr_int(1 downto 0),
      S(3) => ua_narrow_load1_carry_i_4_n_0,
      S(2) => ua_narrow_load1_carry_i_5_n_0,
      S(1) => ua_narrow_load1_carry_i_6_n_0,
      S(0) => ua_narrow_load1_carry_i_7_n_0,
      axi_awaddr_full => axi_awaddr_full,
      curr_narrow_burst_cmb => curr_narrow_burst_cmb,
      s_axi_awaddr(2 downto 0) => s_axi_awaddr(2 downto 0),
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0)
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.axi_wdata_full_reg_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F833F300F800C0"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => wr_data_sm_cs(0),
      I2 => axi_wdata_full_reg,
      I3 => wr_data_sm_cs(2),
      I4 => wr_data_sm_cs(1),
      I5 => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.axi_wdata_full_reg_i_2_n_0\,
      O => axi_wdata_full_cmb
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.axi_wdata_full_reg_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F00BFBF0F00BFB0"
    )
        port map (
      I0 => BID_FIFO_n_0,
      I1 => axi_awaddr_full,
      I2 => wr_data_sm_cs(2),
      I3 => axi_wdata_full_reg,
      I4 => axi_wdata_full_cmb115_out,
      I5 => s_axi_wvalid,
      O => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.axi_wdata_full_reg_i_2_n_0\
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.axi_wdata_full_reg_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_wdata_full_cmb,
      Q => axi_wdata_full_reg,
      R => bid_fifo_rst
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.bram_en_int_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"022F0220"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => wr_data_sm_cs(2),
      I2 => wr_data_sm_cs(0),
      I3 => wr_data_sm_cs(1),
      I4 => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.bram_en_int_i_2_n_0\,
      O => bram_en_cmb
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.bram_en_int_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF20F020"
    )
        port map (
      I0 => axi_awaddr_full,
      I1 => BID_FIFO_n_0,
      I2 => wr_data_sm_cs(2),
      I3 => axi_wdata_full_cmb115_out,
      I4 => s_axi_wvalid,
      O => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.bram_en_int_i_2_n_0\
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.bram_en_int_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => bram_en_cmb,
      Q => BRAM_En_A,
      R => bid_fifo_rst
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => wr_data_sm_cs(0),
      I1 => wr_data_sm_cs(1),
      I2 => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_i_2_n_0\,
      O => clr_bram_we_cmb
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55FF040055000400"
    )
        port map (
      I0 => axi_wr_burst,
      I1 => axi_awaddr_full,
      I2 => BID_FIFO_n_0,
      I3 => wr_data_sm_cs(2),
      I4 => axi_wdata_full_cmb115_out,
      I5 => bvalid_cnt_inc11_out,
      O => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_i_2_n_0\
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => clr_bram_we_cmb,
      Q => clr_bram_we,
      R => bid_fifo_rst
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3F3FBABF00008A80"
    )
        port map (
      I0 => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_2_n_0\,
      I1 => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_3_n_0\,
      I2 => wr_data_sm_cs(0),
      I3 => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.clr_bram_we_i_2_n_0\,
      I4 => wr_data_sm_cs(1),
      I5 => delay_aw_active_clr,
      O => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_1_n_0\
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5504FFFF55040000"
    )
        port map (
      I0 => wr_data_sm_cs(0),
      I1 => axi_awaddr_full,
      I2 => BID_FIFO_n_0,
      I3 => axi_wdata_full_cmb115_out,
      I4 => wr_data_sm_cs(2),
      I5 => s_axi_wlast,
      O => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_2_n_0\
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FF400040"
    )
        port map (
      I0 => axi_wr_burst_cmb0,
      I1 => s_axi_wvalid,
      I2 => s_axi_wlast,
      I3 => wr_data_sm_cs(1),
      I4 => delay_aw_active_clr,
      I5 => wr_data_sm_cs(2),
      O => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_3_n_0\
    );
\GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.delay_aw_active_clr_i_1_n_0\,
      Q => delay_aw_active_clr,
      R => bid_fifo_rst
    );
\GEN_WRDATA[0].bram_wrdata_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(0),
      Q => BRAM_WrData_A(0),
      R => '0'
    );
\GEN_WRDATA[100].bram_wrdata_int_reg[100]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(100),
      Q => BRAM_WrData_A(100),
      R => '0'
    );
\GEN_WRDATA[101].bram_wrdata_int_reg[101]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(101),
      Q => BRAM_WrData_A(101),
      R => '0'
    );
\GEN_WRDATA[102].bram_wrdata_int_reg[102]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(102),
      Q => BRAM_WrData_A(102),
      R => '0'
    );
\GEN_WRDATA[103].bram_wrdata_int_reg[103]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(103),
      Q => BRAM_WrData_A(103),
      R => '0'
    );
\GEN_WRDATA[104].bram_wrdata_int_reg[104]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(104),
      Q => BRAM_WrData_A(104),
      R => '0'
    );
\GEN_WRDATA[105].bram_wrdata_int_reg[105]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(105),
      Q => BRAM_WrData_A(105),
      R => '0'
    );
\GEN_WRDATA[106].bram_wrdata_int_reg[106]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(106),
      Q => BRAM_WrData_A(106),
      R => '0'
    );
\GEN_WRDATA[107].bram_wrdata_int_reg[107]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(107),
      Q => BRAM_WrData_A(107),
      R => '0'
    );
\GEN_WRDATA[108].bram_wrdata_int_reg[108]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(108),
      Q => BRAM_WrData_A(108),
      R => '0'
    );
\GEN_WRDATA[109].bram_wrdata_int_reg[109]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(109),
      Q => BRAM_WrData_A(109),
      R => '0'
    );
\GEN_WRDATA[10].bram_wrdata_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(10),
      Q => BRAM_WrData_A(10),
      R => '0'
    );
\GEN_WRDATA[110].bram_wrdata_int_reg[110]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(110),
      Q => BRAM_WrData_A(110),
      R => '0'
    );
\GEN_WRDATA[111].bram_wrdata_int_reg[111]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(111),
      Q => BRAM_WrData_A(111),
      R => '0'
    );
\GEN_WRDATA[112].bram_wrdata_int_reg[112]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(112),
      Q => BRAM_WrData_A(112),
      R => '0'
    );
\GEN_WRDATA[113].bram_wrdata_int_reg[113]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(113),
      Q => BRAM_WrData_A(113),
      R => '0'
    );
\GEN_WRDATA[114].bram_wrdata_int_reg[114]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(114),
      Q => BRAM_WrData_A(114),
      R => '0'
    );
\GEN_WRDATA[115].bram_wrdata_int_reg[115]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(115),
      Q => BRAM_WrData_A(115),
      R => '0'
    );
\GEN_WRDATA[116].bram_wrdata_int_reg[116]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(116),
      Q => BRAM_WrData_A(116),
      R => '0'
    );
\GEN_WRDATA[117].bram_wrdata_int_reg[117]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(117),
      Q => BRAM_WrData_A(117),
      R => '0'
    );
\GEN_WRDATA[118].bram_wrdata_int_reg[118]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(118),
      Q => BRAM_WrData_A(118),
      R => '0'
    );
\GEN_WRDATA[119].bram_wrdata_int_reg[119]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(119),
      Q => BRAM_WrData_A(119),
      R => '0'
    );
\GEN_WRDATA[11].bram_wrdata_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(11),
      Q => BRAM_WrData_A(11),
      R => '0'
    );
\GEN_WRDATA[120].bram_wrdata_int_reg[120]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(120),
      Q => BRAM_WrData_A(120),
      R => '0'
    );
\GEN_WRDATA[121].bram_wrdata_int_reg[121]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(121),
      Q => BRAM_WrData_A(121),
      R => '0'
    );
\GEN_WRDATA[122].bram_wrdata_int_reg[122]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(122),
      Q => BRAM_WrData_A(122),
      R => '0'
    );
\GEN_WRDATA[123].bram_wrdata_int_reg[123]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(123),
      Q => BRAM_WrData_A(123),
      R => '0'
    );
\GEN_WRDATA[124].bram_wrdata_int_reg[124]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(124),
      Q => BRAM_WrData_A(124),
      R => '0'
    );
\GEN_WRDATA[125].bram_wrdata_int_reg[125]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(125),
      Q => BRAM_WrData_A(125),
      R => '0'
    );
\GEN_WRDATA[126].bram_wrdata_int_reg[126]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(126),
      Q => BRAM_WrData_A(126),
      R => '0'
    );
\GEN_WRDATA[127].bram_wrdata_int_reg[127]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(127),
      Q => BRAM_WrData_A(127),
      R => '0'
    );
\GEN_WRDATA[12].bram_wrdata_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(12),
      Q => BRAM_WrData_A(12),
      R => '0'
    );
\GEN_WRDATA[13].bram_wrdata_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(13),
      Q => BRAM_WrData_A(13),
      R => '0'
    );
\GEN_WRDATA[14].bram_wrdata_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(14),
      Q => BRAM_WrData_A(14),
      R => '0'
    );
\GEN_WRDATA[15].bram_wrdata_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(15),
      Q => BRAM_WrData_A(15),
      R => '0'
    );
\GEN_WRDATA[16].bram_wrdata_int_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(16),
      Q => BRAM_WrData_A(16),
      R => '0'
    );
\GEN_WRDATA[17].bram_wrdata_int_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(17),
      Q => BRAM_WrData_A(17),
      R => '0'
    );
\GEN_WRDATA[18].bram_wrdata_int_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(18),
      Q => BRAM_WrData_A(18),
      R => '0'
    );
\GEN_WRDATA[19].bram_wrdata_int_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(19),
      Q => BRAM_WrData_A(19),
      R => '0'
    );
\GEN_WRDATA[1].bram_wrdata_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(1),
      Q => BRAM_WrData_A(1),
      R => '0'
    );
\GEN_WRDATA[20].bram_wrdata_int_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(20),
      Q => BRAM_WrData_A(20),
      R => '0'
    );
\GEN_WRDATA[21].bram_wrdata_int_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(21),
      Q => BRAM_WrData_A(21),
      R => '0'
    );
\GEN_WRDATA[22].bram_wrdata_int_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(22),
      Q => BRAM_WrData_A(22),
      R => '0'
    );
\GEN_WRDATA[23].bram_wrdata_int_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(23),
      Q => BRAM_WrData_A(23),
      R => '0'
    );
\GEN_WRDATA[24].bram_wrdata_int_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(24),
      Q => BRAM_WrData_A(24),
      R => '0'
    );
\GEN_WRDATA[25].bram_wrdata_int_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(25),
      Q => BRAM_WrData_A(25),
      R => '0'
    );
\GEN_WRDATA[26].bram_wrdata_int_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(26),
      Q => BRAM_WrData_A(26),
      R => '0'
    );
\GEN_WRDATA[27].bram_wrdata_int_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(27),
      Q => BRAM_WrData_A(27),
      R => '0'
    );
\GEN_WRDATA[28].bram_wrdata_int_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(28),
      Q => BRAM_WrData_A(28),
      R => '0'
    );
\GEN_WRDATA[29].bram_wrdata_int_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(29),
      Q => BRAM_WrData_A(29),
      R => '0'
    );
\GEN_WRDATA[2].bram_wrdata_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(2),
      Q => BRAM_WrData_A(2),
      R => '0'
    );
\GEN_WRDATA[30].bram_wrdata_int_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(30),
      Q => BRAM_WrData_A(30),
      R => '0'
    );
\GEN_WRDATA[31].bram_wrdata_int_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(31),
      Q => BRAM_WrData_A(31),
      R => '0'
    );
\GEN_WRDATA[32].bram_wrdata_int_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(32),
      Q => BRAM_WrData_A(32),
      R => '0'
    );
\GEN_WRDATA[33].bram_wrdata_int_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(33),
      Q => BRAM_WrData_A(33),
      R => '0'
    );
\GEN_WRDATA[34].bram_wrdata_int_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(34),
      Q => BRAM_WrData_A(34),
      R => '0'
    );
\GEN_WRDATA[35].bram_wrdata_int_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(35),
      Q => BRAM_WrData_A(35),
      R => '0'
    );
\GEN_WRDATA[36].bram_wrdata_int_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(36),
      Q => BRAM_WrData_A(36),
      R => '0'
    );
\GEN_WRDATA[37].bram_wrdata_int_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(37),
      Q => BRAM_WrData_A(37),
      R => '0'
    );
\GEN_WRDATA[38].bram_wrdata_int_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(38),
      Q => BRAM_WrData_A(38),
      R => '0'
    );
\GEN_WRDATA[39].bram_wrdata_int_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(39),
      Q => BRAM_WrData_A(39),
      R => '0'
    );
\GEN_WRDATA[3].bram_wrdata_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(3),
      Q => BRAM_WrData_A(3),
      R => '0'
    );
\GEN_WRDATA[40].bram_wrdata_int_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(40),
      Q => BRAM_WrData_A(40),
      R => '0'
    );
\GEN_WRDATA[41].bram_wrdata_int_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(41),
      Q => BRAM_WrData_A(41),
      R => '0'
    );
\GEN_WRDATA[42].bram_wrdata_int_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(42),
      Q => BRAM_WrData_A(42),
      R => '0'
    );
\GEN_WRDATA[43].bram_wrdata_int_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(43),
      Q => BRAM_WrData_A(43),
      R => '0'
    );
\GEN_WRDATA[44].bram_wrdata_int_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(44),
      Q => BRAM_WrData_A(44),
      R => '0'
    );
\GEN_WRDATA[45].bram_wrdata_int_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(45),
      Q => BRAM_WrData_A(45),
      R => '0'
    );
\GEN_WRDATA[46].bram_wrdata_int_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(46),
      Q => BRAM_WrData_A(46),
      R => '0'
    );
\GEN_WRDATA[47].bram_wrdata_int_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(47),
      Q => BRAM_WrData_A(47),
      R => '0'
    );
\GEN_WRDATA[48].bram_wrdata_int_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(48),
      Q => BRAM_WrData_A(48),
      R => '0'
    );
\GEN_WRDATA[49].bram_wrdata_int_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(49),
      Q => BRAM_WrData_A(49),
      R => '0'
    );
\GEN_WRDATA[4].bram_wrdata_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(4),
      Q => BRAM_WrData_A(4),
      R => '0'
    );
\GEN_WRDATA[50].bram_wrdata_int_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(50),
      Q => BRAM_WrData_A(50),
      R => '0'
    );
\GEN_WRDATA[51].bram_wrdata_int_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(51),
      Q => BRAM_WrData_A(51),
      R => '0'
    );
\GEN_WRDATA[52].bram_wrdata_int_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(52),
      Q => BRAM_WrData_A(52),
      R => '0'
    );
\GEN_WRDATA[53].bram_wrdata_int_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(53),
      Q => BRAM_WrData_A(53),
      R => '0'
    );
\GEN_WRDATA[54].bram_wrdata_int_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(54),
      Q => BRAM_WrData_A(54),
      R => '0'
    );
\GEN_WRDATA[55].bram_wrdata_int_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(55),
      Q => BRAM_WrData_A(55),
      R => '0'
    );
\GEN_WRDATA[56].bram_wrdata_int_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(56),
      Q => BRAM_WrData_A(56),
      R => '0'
    );
\GEN_WRDATA[57].bram_wrdata_int_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(57),
      Q => BRAM_WrData_A(57),
      R => '0'
    );
\GEN_WRDATA[58].bram_wrdata_int_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(58),
      Q => BRAM_WrData_A(58),
      R => '0'
    );
\GEN_WRDATA[59].bram_wrdata_int_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(59),
      Q => BRAM_WrData_A(59),
      R => '0'
    );
\GEN_WRDATA[5].bram_wrdata_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(5),
      Q => BRAM_WrData_A(5),
      R => '0'
    );
\GEN_WRDATA[60].bram_wrdata_int_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(60),
      Q => BRAM_WrData_A(60),
      R => '0'
    );
\GEN_WRDATA[61].bram_wrdata_int_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(61),
      Q => BRAM_WrData_A(61),
      R => '0'
    );
\GEN_WRDATA[62].bram_wrdata_int_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(62),
      Q => BRAM_WrData_A(62),
      R => '0'
    );
\GEN_WRDATA[63].bram_wrdata_int_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(63),
      Q => BRAM_WrData_A(63),
      R => '0'
    );
\GEN_WRDATA[64].bram_wrdata_int_reg[64]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(64),
      Q => BRAM_WrData_A(64),
      R => '0'
    );
\GEN_WRDATA[65].bram_wrdata_int_reg[65]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(65),
      Q => BRAM_WrData_A(65),
      R => '0'
    );
\GEN_WRDATA[66].bram_wrdata_int_reg[66]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(66),
      Q => BRAM_WrData_A(66),
      R => '0'
    );
\GEN_WRDATA[67].bram_wrdata_int_reg[67]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(67),
      Q => BRAM_WrData_A(67),
      R => '0'
    );
\GEN_WRDATA[68].bram_wrdata_int_reg[68]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(68),
      Q => BRAM_WrData_A(68),
      R => '0'
    );
\GEN_WRDATA[69].bram_wrdata_int_reg[69]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(69),
      Q => BRAM_WrData_A(69),
      R => '0'
    );
\GEN_WRDATA[6].bram_wrdata_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(6),
      Q => BRAM_WrData_A(6),
      R => '0'
    );
\GEN_WRDATA[70].bram_wrdata_int_reg[70]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(70),
      Q => BRAM_WrData_A(70),
      R => '0'
    );
\GEN_WRDATA[71].bram_wrdata_int_reg[71]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(71),
      Q => BRAM_WrData_A(71),
      R => '0'
    );
\GEN_WRDATA[72].bram_wrdata_int_reg[72]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(72),
      Q => BRAM_WrData_A(72),
      R => '0'
    );
\GEN_WRDATA[73].bram_wrdata_int_reg[73]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(73),
      Q => BRAM_WrData_A(73),
      R => '0'
    );
\GEN_WRDATA[74].bram_wrdata_int_reg[74]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(74),
      Q => BRAM_WrData_A(74),
      R => '0'
    );
\GEN_WRDATA[75].bram_wrdata_int_reg[75]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(75),
      Q => BRAM_WrData_A(75),
      R => '0'
    );
\GEN_WRDATA[76].bram_wrdata_int_reg[76]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(76),
      Q => BRAM_WrData_A(76),
      R => '0'
    );
\GEN_WRDATA[77].bram_wrdata_int_reg[77]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(77),
      Q => BRAM_WrData_A(77),
      R => '0'
    );
\GEN_WRDATA[78].bram_wrdata_int_reg[78]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(78),
      Q => BRAM_WrData_A(78),
      R => '0'
    );
\GEN_WRDATA[79].bram_wrdata_int_reg[79]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(79),
      Q => BRAM_WrData_A(79),
      R => '0'
    );
\GEN_WRDATA[7].bram_wrdata_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(7),
      Q => BRAM_WrData_A(7),
      R => '0'
    );
\GEN_WRDATA[80].bram_wrdata_int_reg[80]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(80),
      Q => BRAM_WrData_A(80),
      R => '0'
    );
\GEN_WRDATA[81].bram_wrdata_int_reg[81]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(81),
      Q => BRAM_WrData_A(81),
      R => '0'
    );
\GEN_WRDATA[82].bram_wrdata_int_reg[82]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(82),
      Q => BRAM_WrData_A(82),
      R => '0'
    );
\GEN_WRDATA[83].bram_wrdata_int_reg[83]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(83),
      Q => BRAM_WrData_A(83),
      R => '0'
    );
\GEN_WRDATA[84].bram_wrdata_int_reg[84]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(84),
      Q => BRAM_WrData_A(84),
      R => '0'
    );
\GEN_WRDATA[85].bram_wrdata_int_reg[85]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(85),
      Q => BRAM_WrData_A(85),
      R => '0'
    );
\GEN_WRDATA[86].bram_wrdata_int_reg[86]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(86),
      Q => BRAM_WrData_A(86),
      R => '0'
    );
\GEN_WRDATA[87].bram_wrdata_int_reg[87]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(87),
      Q => BRAM_WrData_A(87),
      R => '0'
    );
\GEN_WRDATA[88].bram_wrdata_int_reg[88]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(88),
      Q => BRAM_WrData_A(88),
      R => '0'
    );
\GEN_WRDATA[89].bram_wrdata_int_reg[89]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(89),
      Q => BRAM_WrData_A(89),
      R => '0'
    );
\GEN_WRDATA[8].bram_wrdata_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(8),
      Q => BRAM_WrData_A(8),
      R => '0'
    );
\GEN_WRDATA[90].bram_wrdata_int_reg[90]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(90),
      Q => BRAM_WrData_A(90),
      R => '0'
    );
\GEN_WRDATA[91].bram_wrdata_int_reg[91]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(91),
      Q => BRAM_WrData_A(91),
      R => '0'
    );
\GEN_WRDATA[92].bram_wrdata_int_reg[92]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(92),
      Q => BRAM_WrData_A(92),
      R => '0'
    );
\GEN_WRDATA[93].bram_wrdata_int_reg[93]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(93),
      Q => BRAM_WrData_A(93),
      R => '0'
    );
\GEN_WRDATA[94].bram_wrdata_int_reg[94]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(94),
      Q => BRAM_WrData_A(94),
      R => '0'
    );
\GEN_WRDATA[95].bram_wrdata_int_reg[95]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(95),
      Q => BRAM_WrData_A(95),
      R => '0'
    );
\GEN_WRDATA[96].bram_wrdata_int_reg[96]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(96),
      Q => BRAM_WrData_A(96),
      R => '0'
    );
\GEN_WRDATA[97].bram_wrdata_int_reg[97]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(97),
      Q => BRAM_WrData_A(97),
      R => '0'
    );
\GEN_WRDATA[98].bram_wrdata_int_reg[98]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(98),
      Q => BRAM_WrData_A(98),
      R => '0'
    );
\GEN_WRDATA[99].bram_wrdata_int_reg[99]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(99),
      Q => BRAM_WrData_A(99),
      R => '0'
    );
\GEN_WRDATA[9].bram_wrdata_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wdata(9),
      Q => BRAM_WrData_A(9),
      R => '0'
    );
\GEN_WR_NO_ECC.bram_we_int[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D0FF"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => wr_data_sm_cs(2),
      I2 => clr_bram_we,
      I3 => s_axi_aresetn,
      O => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => wr_data_sm_cs(2),
      O => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(0),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(0),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(10),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(10),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(11),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(11),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(12),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(12),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(13),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(13),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(14),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(14),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(15),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(15),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(1),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(1),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(2),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(2),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(3),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(3),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(4),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(4),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(5),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(5),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(6),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(6),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(7),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(7),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(8),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(8),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \GEN_WR_NO_ECC.bram_we_int[15]_i_2_n_0\,
      D => s_axi_wstrb(9),
      Q => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9),
      R => \GEN_WR_NO_ECC.bram_we_int[15]_i_1_n_0\
    );
I_WRAP_BRST: entity work.axi_bram_ctrl_0_wrap_brst
     port map (
      D(9 downto 8) => bram_addr_ld(13 downto 12),
      D(7 downto 0) => p_1_in(7 downto 0),
      DI(0) => size_plus_lsb0(1),
      E(0) => bram_addr_ld_en,
      \FSM_sequential_GEN_WDATA_SM_NO_ECC_DUAL_REG_WREADY.wr_data_sm_cs_reg[1]\ => curr_wrap_burst_reg_i_3_n_0,
      \GEN_AW_DUAL.wr_addr_sm_cs_reg\ => BID_FIFO_n_0,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[10].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[11].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[12].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[13].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[4].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[5].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[6].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[7].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[8].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg\ => \GEN_AW_PIPE_DUAL.GEN_AWADDR[9].axi_awaddr_pipe_reg\,
      \GEN_AW_PIPE_DUAL.axi_awaddr_full_reg\ => curr_wrap_burst_reg_i_2_n_0,
      \GEN_AW_PIPE_DUAL.axi_awsize_pipe_reg[2]\(2 downto 0) => axi_awsize_pipe(2 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]\ => I_WRAP_BRST_n_1,
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[11]_0\(7 downto 0) => \^q\(7 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[8]\ => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_4__0_n_0\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[2]\ => \GEN_DUAL_ADDR_CNT.bram_addr_int[11]_i_3_n_0\,
      \GEN_NARROW_CNT.narrow_addr_int_reg[3]\(3 downto 0) => narrow_addr_int(3 downto 0),
      \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\ => I_WRAP_BRST_n_21,
      Q(3 downto 0) => axi_awlen_pipe(3 downto 0),
      SR(0) => I_WRAP_BRST_n_0,
      axi_awaddr_full => axi_awaddr_full,
      bid_fifo_rst => bid_fifo_rst,
      bram_addr_inc => bram_addr_inc,
      bram_addr_ld_en_mod => bram_addr_ld_en_mod,
      bram_addr_rst_cmb => bram_addr_rst_cmb,
      curr_awlen_reg_1_or_2_reg => I_WRAP_BRST_n_23,
      curr_fixed_burst => curr_fixed_burst,
      curr_fixed_burst_reg => curr_fixed_burst_reg,
      curr_fixed_burst_reg_reg => I_WRAP_BRST_n_3,
      curr_narrow_burst => curr_narrow_burst,
      curr_narrow_burst_cmb => curr_narrow_burst_cmb,
      curr_wrap_burst_reg => curr_wrap_burst_reg,
      curr_wrap_burst_reg_reg => I_WRAP_BRST_n_25,
      narrow_bram_addr_inc_d1 => narrow_bram_addr_inc_d1,
      \out\(2 downto 0) => wr_data_sm_cs(2 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awaddr(9 downto 0) => s_axi_awaddr(13 downto 4),
      s_axi_awlen(3 downto 0) => s_axi_awlen(3 downto 0),
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_wvalid => s_axi_wvalid,
      \wrap_burst_total_reg[0]_0\ => I_WRAP_BRST_n_16,
      \wrap_burst_total_reg[0]_1\ => I_WRAP_BRST_n_17,
      \wrap_burst_total_reg[0]_2\ => I_WRAP_BRST_n_18,
      \wrap_burst_total_reg[0]_3\ => I_WRAP_BRST_n_24,
      \wrap_burst_total_reg[1]_0\ => I_WRAP_BRST_n_19,
      \wrap_burst_total_reg[1]_1\ => I_WRAP_BRST_n_20
    );
\axi_bid_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => BID_FIFO_n_8,
      Q => \^s_axi_bid\(0),
      R => bid_fifo_rst
    );
axi_bvalid_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAA8A88"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => bvalid_cnt_inc,
      I2 => BID_FIFO_n_4,
      I3 => bvalid_cnt(0),
      I4 => bvalid_cnt(1),
      I5 => bvalid_cnt(2),
      O => axi_bvalid_int_i_1_n_0
    );
axi_bvalid_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_bvalid_int_i_1_n_0,
      Q => \^s_axi_bvalid\,
      R => '0'
    );
axi_wr_burst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_wr_burst_i_2_n_0,
      I1 => axi_wr_burst_i_3_n_0,
      I2 => axi_wr_burst,
      O => axi_wr_burst_i_1_n_0
    );
axi_wr_burst_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000077D144D1"
    )
        port map (
      I0 => s_axi_wlast,
      I1 => wr_data_sm_cs(1),
      I2 => s_axi_wvalid,
      I3 => wr_data_sm_cs(0),
      I4 => axi_wr_burst_cmb0,
      I5 => wr_data_sm_cs(2),
      O => axi_wr_burst_i_2_n_0
    );
axi_wr_burst_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AA8A8A8A"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => wr_data_sm_cs(1),
      I2 => wr_data_sm_cs(0),
      I3 => s_axi_wlast,
      I4 => axi_wr_burst_cmb0,
      I5 => wr_data_sm_cs(2),
      O => axi_wr_burst_i_3_n_0
    );
axi_wr_burst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_wr_burst_i_1_n_0,
      Q => axi_wr_burst,
      R => bid_fifo_rst
    );
axi_wready_int_mod_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => axi_wdata_full_cmb,
      O => axi_wready_int_mod_i_1_n_0
    );
axi_wready_int_mod_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_wready_int_mod_i_1_n_0,
      Q => \^s_axi_wready\,
      R => '0'
    );
bid_gets_fifo_load_d1_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => bvalid_cnt(1),
      I1 => bvalid_cnt(2),
      O => bid_gets_fifo_load_d1_i_2_n_0
    );
bid_gets_fifo_load_d1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => bid_gets_fifo_load,
      Q => bid_gets_fifo_load_d1,
      R => bid_fifo_rst
    );
\bvalid_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0000FFF1FFFE000"
    )
        port map (
      I0 => bvalid_cnt(1),
      I1 => bvalid_cnt(2),
      I2 => \^s_axi_bvalid\,
      I3 => s_axi_bready,
      I4 => bvalid_cnt_inc,
      I5 => bvalid_cnt(0),
      O => \bvalid_cnt[0]_i_1_n_0\
    );
\bvalid_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D5BFD5BF2A402A00"
    )
        port map (
      I0 => bvalid_cnt_inc,
      I1 => s_axi_bready,
      I2 => \^s_axi_bvalid\,
      I3 => bvalid_cnt(0),
      I4 => bvalid_cnt(2),
      I5 => bvalid_cnt(1),
      O => \bvalid_cnt[1]_i_1_n_0\
    );
\bvalid_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D5FF2A00FFBF0000"
    )
        port map (
      I0 => bvalid_cnt_inc,
      I1 => s_axi_bready,
      I2 => \^s_axi_bvalid\,
      I3 => bvalid_cnt(0),
      I4 => bvalid_cnt(2),
      I5 => bvalid_cnt(1),
      O => \bvalid_cnt[2]_i_1_n_0\
    );
\bvalid_cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \bvalid_cnt[0]_i_1_n_0\,
      Q => bvalid_cnt(0),
      R => bid_fifo_rst
    );
\bvalid_cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \bvalid_cnt[1]_i_1_n_0\,
      Q => bvalid_cnt(1),
      R => bid_fifo_rst
    );
\bvalid_cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \bvalid_cnt[2]_i_1_n_0\,
      Q => bvalid_cnt(2),
      R => bid_fifo_rst
    );
curr_awlen_reg_1_or_2_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => curr_awlen_reg_1_or_2_i_2_n_0,
      I1 => I_WRAP_BRST_n_23,
      I2 => curr_awlen_reg_1_or_2_i_4_n_0,
      I3 => curr_awlen_reg_1_or_2_i_5_n_0,
      I4 => I_WRAP_BRST_n_17,
      I5 => I_WRAP_BRST_n_16,
      O => curr_awlen_reg_1_or_20
    );
curr_awlen_reg_1_or_2_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awlen_pipe(6),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(6),
      O => curr_awlen_reg_1_or_2_i_2_n_0
    );
curr_awlen_reg_1_or_2_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => axi_awlen_pipe(7),
      I1 => axi_awaddr_full,
      I2 => s_axi_awlen(7),
      O => curr_awlen_reg_1_or_2_i_4_n_0
    );
curr_awlen_reg_1_or_2_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_awlen(4),
      I1 => axi_awlen_pipe(4),
      I2 => s_axi_awlen(5),
      I3 => axi_awaddr_full,
      I4 => axi_awlen_pipe(5),
      O => curr_awlen_reg_1_or_2_i_5_n_0
    );
curr_awlen_reg_1_or_2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_ld_en,
      D => curr_awlen_reg_1_or_20,
      Q => curr_awlen_reg_1_or_2,
      R => bid_fifo_rst
    );
curr_fixed_burst_reg_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_awburst(1),
      I1 => axi_awburst_pipe(1),
      I2 => s_axi_awburst(0),
      I3 => axi_awaddr_full,
      I4 => axi_awburst_pipe(0),
      O => curr_fixed_burst
    );
curr_fixed_burst_reg_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => wr_data_sm_cs(2),
      I2 => wr_data_sm_cs(0),
      I3 => wr_data_sm_cs(1),
      O => bram_addr_rst_cmb
    );
curr_fixed_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => I_WRAP_BRST_n_3,
      Q => curr_fixed_burst_reg,
      R => '0'
    );
curr_wrap_burst_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAFEAE00005404"
    )
        port map (
      I0 => BID_FIFO_n_0,
      I1 => s_axi_awburst(1),
      I2 => axi_awaddr_full,
      I3 => axi_awburst_pipe(1),
      I4 => \GEN_NARROW_CNT.narrow_addr_int[3]_i_10_n_0\,
      I5 => curr_wrap_burst_reg,
      O => curr_wrap_burst_reg_i_2_n_0
    );
curr_wrap_burst_reg_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => wr_data_sm_cs(1),
      I1 => wr_data_sm_cs(0),
      O => curr_wrap_burst_reg_i_3_n_0
    );
curr_wrap_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => I_WRAP_BRST_n_25,
      Q => curr_wrap_burst_reg,
      R => '0'
    );
\ua_narrow_load1_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFEAFFFFFFFF"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => axi_awsize_pipe(1),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(1),
      I4 => I_WRAP_BRST_n_21,
      I5 => size_plus_lsb(8),
      O => \ua_narrow_load1_carry__0_i_1_n_0\
    );
ua_narrow_load1_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000044404"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_8_n_0,
      I1 => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      I2 => s_axi_awsize(0),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(0),
      I5 => ua_narrow_load1_carry_i_9_n_0,
      O => ua_narrow_load1_carry_i_1_n_0
    );
ua_narrow_load1_carry_i_10: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFABFBFFFFFFFF"
    )
        port map (
      I0 => I_WRAP_BRST_n_21,
      I1 => s_axi_awsize(1),
      I2 => axi_awaddr_full,
      I3 => axi_awsize_pipe(1),
      I4 => I_WRAP_BRST_n_20,
      I5 => ua_narrow_load1_carry_i_17_n_0,
      O => ua_narrow_load1_carry_i_10_n_0
    );
ua_narrow_load1_carry_i_11: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D0D3DCDF"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_19_n_0,
      I1 => I_WRAP_BRST_n_20,
      I2 => I_WRAP_BRST_n_19,
      I3 => ua_narrow_load1_carry_i_20_n_0,
      I4 => ua_narrow_load1_carry_i_21_n_0,
      O => ua_narrow_load1_carry_i_11_n_0
    );
ua_narrow_load1_carry_i_12: unisim.vcomponents.LUT5
    generic map(
      INIT => X"53555333"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_8_n_0,
      I1 => \ua_narrow_load1_carry_i_22__0_n_0\,
      I2 => axi_awsize_pipe(2),
      I3 => axi_awaddr_full,
      I4 => s_axi_awsize(2),
      O => ua_narrow_load1_carry_i_12_n_0
    );
\ua_narrow_load1_carry_i_13__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFAAAACFC0"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_20_n_0,
      I1 => size_plus_lsb(2),
      I2 => I_WRAP_BRST_n_21,
      I3 => size_plus_lsb(1),
      I4 => I_WRAP_BRST_n_19,
      I5 => I_WRAP_BRST_n_20,
      O => \ua_narrow_load1_carry_i_13__0_n_0\
    );
ua_narrow_load1_carry_i_14: unisim.vcomponents.CARRY4
     port map (
      CI => ua_narrow_load1_carry_i_15_n_0,
      CO(3 downto 1) => NLW_ua_narrow_load1_carry_i_14_CO_UNCONNECTED(3 downto 1),
      CO(0) => size_plus_lsb(8),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_ua_narrow_load1_carry_i_14_O_UNCONNECTED(3 downto 0),
      S(3 downto 0) => B"0001"
    );
ua_narrow_load1_carry_i_15: unisim.vcomponents.CARRY4
     port map (
      CI => ua_narrow_load1_carry_i_23_n_0,
      CO(3) => ua_narrow_load1_carry_i_15_n_0,
      CO(2) => ua_narrow_load1_carry_i_15_n_1,
      CO(1) => ua_narrow_load1_carry_i_15_n_2,
      CO(0) => ua_narrow_load1_carry_i_15_n_3,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => size_plus_lsb(7 downto 4),
      S(3 downto 0) => size_plus_lsb0(7 downto 4)
    );
ua_narrow_load1_carry_i_16: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0AFC0A0CF503F5F3"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_21_n_0,
      I1 => ua_narrow_load1_carry_i_20_n_0,
      I2 => I_WRAP_BRST_n_19,
      I3 => I_WRAP_BRST_n_20,
      I4 => ua_narrow_load1_carry_i_19_n_0,
      I5 => size_plus_lsb0(1),
      O => ua_narrow_load1_carry_i_16_n_0
    );
ua_narrow_load1_carry_i_17: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5350535F"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_28_n_0,
      I1 => ua_narrow_load1_carry_i_29_n_0,
      I2 => I_WRAP_BRST_n_20,
      I3 => I_WRAP_BRST_n_19,
      I4 => ua_narrow_load1_carry_i_30_n_0,
      O => ua_narrow_load1_carry_i_17_n_0
    );
ua_narrow_load1_carry_i_19: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(6),
      I1 => axi_awsize_pipe(0),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(0),
      I4 => size_plus_lsb(5),
      O => ua_narrow_load1_carry_i_19_n_0
    );
ua_narrow_load1_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D4DDD44444444444"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_10_n_0,
      I1 => ua_narrow_load1_carry_i_11_n_0,
      I2 => axi_awsize_pipe(0),
      I3 => axi_awaddr_full,
      I4 => s_axi_awsize(0),
      I5 => \GEN_UA_NARROW.I_UA_NARROW_n_2\,
      O => ua_narrow_load1_carry_i_2_n_0
    );
ua_narrow_load1_carry_i_20: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(4),
      I1 => axi_awsize_pipe(0),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(0),
      I4 => size_plus_lsb(3),
      O => ua_narrow_load1_carry_i_20_n_0
    );
ua_narrow_load1_carry_i_21: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => axi_awsize_pipe(0),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(0),
      I4 => size_plus_lsb(7),
      O => ua_narrow_load1_carry_i_21_n_0
    );
\ua_narrow_load1_carry_i_22__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(3),
      I1 => size_plus_lsb(2),
      I2 => I_WRAP_BRST_n_19,
      I3 => size_plus_lsb(1),
      I4 => I_WRAP_BRST_n_21,
      I5 => size_plus_lsb(0),
      O => \ua_narrow_load1_carry_i_22__0_n_0\
    );
ua_narrow_load1_carry_i_23: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ua_narrow_load1_carry_i_23_n_0,
      CO(2) => ua_narrow_load1_carry_i_23_n_1,
      CO(1) => ua_narrow_load1_carry_i_23_n_2,
      CO(0) => ua_narrow_load1_carry_i_23_n_3,
      CYINIT => '0',
      DI(3) => axi_byte_div_curr_awsize(1),
      DI(2 downto 0) => size_plus_lsb0(2 downto 0),
      O(3 downto 0) => size_plus_lsb(3 downto 0),
      S(3) => ua_narrow_load1_carry_i_33_n_0,
      S(2) => \GEN_UA_NARROW.I_UA_NARROW_n_3\,
      S(1) => \GEN_UA_NARROW.I_UA_NARROW_n_4\,
      S(0) => \GEN_UA_NARROW.I_UA_NARROW_n_5\
    );
ua_narrow_load1_carry_i_24: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A0000000A000"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => axi_awsize_pipe(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(0),
      I4 => axi_awaddr_full,
      I5 => axi_awsize_pipe(0),
      O => size_plus_lsb0(7)
    );
ua_narrow_load1_carry_i_25: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000B8308800"
    )
        port map (
      I0 => axi_awsize_pipe(2),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(2),
      I3 => axi_awsize_pipe(1),
      I4 => s_axi_awsize(1),
      I5 => I_WRAP_BRST_n_21,
      O => size_plus_lsb0(6)
    );
ua_narrow_load1_carry_i_26: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5050300000003000"
    )
        port map (
      I0 => axi_awsize_pipe(1),
      I1 => s_axi_awsize(1),
      I2 => I_WRAP_BRST_n_20,
      I3 => s_axi_awsize(0),
      I4 => axi_awaddr_full,
      I5 => axi_awsize_pipe(0),
      O => size_plus_lsb0(5)
    );
ua_narrow_load1_carry_i_27: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000003088B8"
    )
        port map (
      I0 => axi_awsize_pipe(2),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(1),
      I4 => axi_awsize_pipe(1),
      I5 => I_WRAP_BRST_n_21,
      O => size_plus_lsb0(4)
    );
ua_narrow_load1_carry_i_28: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => I_WRAP_BRST_n_19,
      I2 => size_plus_lsb(7),
      I3 => I_WRAP_BRST_n_21,
      I4 => size_plus_lsb(6),
      O => ua_narrow_load1_carry_i_28_n_0
    );
ua_narrow_load1_carry_i_29: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(5),
      I1 => axi_awsize_pipe(0),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(0),
      I4 => size_plus_lsb(4),
      O => ua_narrow_load1_carry_i_29_n_0
    );
ua_narrow_load1_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000400F0000C0"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_9_n_0,
      I1 => ua_narrow_load1_carry_i_12_n_0,
      I2 => I_WRAP_BRST_n_20,
      I3 => I_WRAP_BRST_n_19,
      I4 => I_WRAP_BRST_n_21,
      I5 => \ua_narrow_load1_carry_i_13__0_n_0\,
      O => ua_narrow_load1_carry_i_3_n_0
    );
ua_narrow_load1_carry_i_30: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABF8A80"
    )
        port map (
      I0 => size_plus_lsb(3),
      I1 => axi_awsize_pipe(0),
      I2 => axi_awaddr_full,
      I3 => s_axi_awsize(0),
      I4 => size_plus_lsb(2),
      O => ua_narrow_load1_carry_i_30_n_0
    );
ua_narrow_load1_carry_i_31: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000ACC0A00000000"
    )
        port map (
      I0 => s_axi_awsize(1),
      I1 => axi_awsize_pipe(1),
      I2 => s_axi_awsize(2),
      I3 => axi_awaddr_full,
      I4 => axi_awsize_pipe(2),
      I5 => I_WRAP_BRST_n_21,
      O => axi_byte_div_curr_awsize(1)
    );
ua_narrow_load1_carry_i_32: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000440347"
    )
        port map (
      I0 => axi_awsize_pipe(2),
      I1 => axi_awaddr_full,
      I2 => s_axi_awsize(2),
      I3 => axi_awsize_pipe(1),
      I4 => s_axi_awsize(1),
      I5 => I_WRAP_BRST_n_21,
      O => size_plus_lsb0(0)
    );
ua_narrow_load1_carry_i_33: unisim.vcomponents.LUT6
    generic map(
      INIT => X"77775FA088885FA0"
    )
        port map (
      I0 => I_WRAP_BRST_n_24,
      I1 => axi_awsize_pipe(0),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(3),
      I4 => axi_awaddr_full,
      I5 => \GEN_AW_PIPE_DUAL.GEN_AWADDR[3].axi_awaddr_pipe_reg_n_0_[3]\,
      O => ua_narrow_load1_carry_i_33_n_0
    );
ua_narrow_load1_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFBBABAFAFBBABF"
    )
        port map (
      I0 => I_WRAP_BRST_n_20,
      I1 => size_plus_lsb(8),
      I2 => I_WRAP_BRST_n_19,
      I3 => size_plus_lsb(7),
      I4 => I_WRAP_BRST_n_21,
      I5 => size_plus_lsb(6),
      O => ua_narrow_load1_carry_i_4_n_0
    );
ua_narrow_load1_carry_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FDFD0000FDFD03FC"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => I_WRAP_BRST_n_21,
      I2 => I_WRAP_BRST_n_19,
      I3 => ua_narrow_load1_carry_i_8_n_0,
      I4 => I_WRAP_BRST_n_20,
      I5 => ua_narrow_load1_carry_i_9_n_0,
      O => ua_narrow_load1_carry_i_5_n_0
    );
ua_narrow_load1_carry_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888882828288828"
    )
        port map (
      I0 => ua_narrow_load1_carry_i_16_n_0,
      I1 => ua_narrow_load1_carry_i_17_n_0,
      I2 => I_WRAP_BRST_n_24,
      I3 => s_axi_awsize(0),
      I4 => axi_awaddr_full,
      I5 => axi_awsize_pipe(0),
      O => ua_narrow_load1_carry_i_6_n_0
    );
ua_narrow_load1_carry_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"70707007A0505050"
    )
        port map (
      I0 => \ua_narrow_load1_carry_i_13__0_n_0\,
      I1 => ua_narrow_load1_carry_i_9_n_0,
      I2 => ua_narrow_load1_carry_i_12_n_0,
      I3 => I_WRAP_BRST_n_21,
      I4 => I_WRAP_BRST_n_19,
      I5 => I_WRAP_BRST_n_20,
      O => ua_narrow_load1_carry_i_7_n_0
    );
ua_narrow_load1_carry_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(7),
      I1 => size_plus_lsb(6),
      I2 => I_WRAP_BRST_n_19,
      I3 => size_plus_lsb(5),
      I4 => I_WRAP_BRST_n_21,
      I5 => size_plus_lsb(4),
      O => ua_narrow_load1_carry_i_8_n_0
    );
ua_narrow_load1_carry_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => size_plus_lsb(8),
      I1 => size_plus_lsb(7),
      I2 => I_WRAP_BRST_n_19,
      I3 => size_plus_lsb(6),
      I4 => I_WRAP_BRST_n_21,
      I5 => size_plus_lsb(5),
      O => ua_narrow_load1_carry_i_9_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_blk_mem_gen_prim_width is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end axi_bram_ctrl_0_blk_mem_gen_prim_width;

architecture STRUCTURE of axi_bram_ctrl_0_blk_mem_gen_prim_width is
begin
\prim_noinit.ram\: entity work.axi_bram_ctrl_0_blk_mem_gen_prim_wrapper
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(31 downto 0),
      D(31 downto 0) => D(31 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized0\ is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized0\ : entity is "blk_mem_gen_prim_width";
end \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized0\;

architecture STRUCTURE of \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized0\ is
begin
\prim_noinit.ram\: entity work.\axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized0\
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(31 downto 0),
      D(31 downto 0) => D(31 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized1\ is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized1\ : entity is "blk_mem_gen_prim_width";
end \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized1\;

architecture STRUCTURE of \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized1\ is
begin
\prim_noinit.ram\: entity work.\axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized1\
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(31 downto 0),
      D(31 downto 0) => D(31 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized2\ is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized2\ : entity is "blk_mem_gen_prim_width";
end \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized2\;

architecture STRUCTURE of \axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized2\ is
begin
\prim_noinit.ram\: entity work.\axi_bram_ctrl_0_blk_mem_gen_prim_wrapper__parameterized2\
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(31 downto 0),
      D(31 downto 0) => D(31 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_full_axi is
  port (
    s_axi_rlast : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    BRAM_En_A : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : out STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0\ : out STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_3_out : out STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_awvalid : in STD_LOGIC
  );
end axi_bram_ctrl_0_full_axi;

architecture STRUCTURE of axi_bram_ctrl_0_full_axi is
  signal axi_aresetn_d2 : STD_LOGIC;
  signal axi_aresetn_re_reg : STD_LOGIC;
  signal bid_fifo_rst : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
begin
I_RD_CHNL: entity work.axi_bram_ctrl_0_rd_chnl
     port map (
      D(127 downto 0) => D(127 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0\(9 downto 0),
      axi_aresetn_d2 => axi_aresetn_d2,
      axi_aresetn_re_reg => axi_aresetn_re_reg,
      bid_fifo_rst => bid_fifo_rst,
      p_0_in => p_0_in,
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(13 downto 0) => s_axi_araddr(13 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_rdata(127 downto 0) => s_axi_rdata(127 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid
    );
I_WR_CHNL: entity work.axi_bram_ctrl_0_wr_chnl
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(127 downto 0) => BRAM_WrData_A(127 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(15 downto 0) => Q(15 downto 0),
      Q(9 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9 downto 0),
      axi_aresetn_d2 => axi_aresetn_d2,
      axi_aresetn_re_reg => axi_aresetn_re_reg,
      bid_fifo_rst => bid_fifo_rst,
      p_0_in => p_0_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awaddr(13 downto 0) => s_axi_awaddr(13 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_wdata(127 downto 0) => s_axi_wdata(127 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(15 downto 0) => s_axi_wstrb(15 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_blk_mem_gen_generic_cstr is
  port (
    D : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 127 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end axi_bram_ctrl_0_blk_mem_gen_generic_cstr;

architecture STRUCTURE of axi_bram_ctrl_0_blk_mem_gen_generic_cstr is
begin
\ramloop[0].ram.r\: entity work.axi_bram_ctrl_0_blk_mem_gen_prim_width
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(31 downto 0),
      D(31 downto 0) => D(31 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
\ramloop[1].ram.r\: entity work.\axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized0\
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(63 downto 32),
      D(31 downto 0) => D(63 downto 32),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(7 downto 4),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
\ramloop[2].ram.r\: entity work.\axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized1\
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(95 downto 64),
      D(31 downto 0) => D(95 downto 64),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(11 downto 8),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
\ramloop[3].ram.r\: entity work.\axi_bram_ctrl_0_blk_mem_gen_prim_width__parameterized2\
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(31 downto 0) => BRAM_WrData_A(127 downto 96),
      D(31 downto 0) => D(127 downto 96),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(3 downto 0) => Q(15 downto 12),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_axi_bram_ctrl_top is
  port (
    s_axi_rlast : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    BRAM_En_A : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : out STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0\ : out STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_3_out : out STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_awvalid : in STD_LOGIC
  );
end axi_bram_ctrl_0_axi_bram_ctrl_top;

architecture STRUCTURE of axi_bram_ctrl_0_axi_bram_ctrl_top is
begin
\GEN_AXI4.I_FULL_AXI\: entity work.axi_bram_ctrl_0_full_axi
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(127 downto 0) => BRAM_WrData_A(127 downto 0),
      D(127 downto 0) => D(127 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0\(9 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0\(9 downto 0),
      Q(15 downto 0) => Q(15 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(13 downto 0) => s_axi_araddr(13 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(13 downto 0) => s_axi_awaddr(13 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(127 downto 0) => s_axi_rdata(127 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(127 downto 0) => s_axi_wdata(127 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(15 downto 0) => s_axi_wstrb(15 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_blk_mem_gen_top is
  port (
    D : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 127 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end axi_bram_ctrl_0_blk_mem_gen_top;

architecture STRUCTURE of axi_bram_ctrl_0_blk_mem_gen_top is
begin
\valid.cstr\: entity work.axi_bram_ctrl_0_blk_mem_gen_generic_cstr
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(127 downto 0) => BRAM_WrData_A(127 downto 0),
      D(127 downto 0) => D(127 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(15 downto 0) => Q(15 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_blk_mem_gen_v8_3_4_synth is
  port (
    D : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 127 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end axi_bram_ctrl_0_blk_mem_gen_v8_3_4_synth;

architecture STRUCTURE of axi_bram_ctrl_0_blk_mem_gen_v8_3_4_synth is
begin
\gnbram.gnativebmg.native_blk_mem_gen\: entity work.axi_bram_ctrl_0_blk_mem_gen_top
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(127 downto 0) => BRAM_WrData_A(127 downto 0),
      D(127 downto 0) => D(127 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(15 downto 0) => Q(15 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_blk_mem_gen_v8_3_4 is
  port (
    D : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    BRAM_En_A : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\ : in STD_LOGIC_VECTOR ( 9 downto 0 );
    BRAM_WrData_A : in STD_LOGIC_VECTOR ( 127 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end axi_bram_ctrl_0_blk_mem_gen_v8_3_4;

architecture STRUCTURE of axi_bram_ctrl_0_blk_mem_gen_v8_3_4 is
begin
inst_blk_mem_gen: entity work.axi_bram_ctrl_0_blk_mem_gen_v8_3_4_synth
     port map (
      BRAM_En_A => BRAM_En_A,
      BRAM_WrData_A(127 downto 0) => BRAM_WrData_A(127 downto 0),
      D(127 downto 0) => D(127 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0),
      Q(15 downto 0) => Q(15 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0_axi_bram_ctrl is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    ecc_interrupt : out STD_LOGIC;
    ecc_ue : out STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_ctrl_awvalid : in STD_LOGIC;
    s_axi_ctrl_awready : out STD_LOGIC;
    s_axi_ctrl_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_ctrl_wvalid : in STD_LOGIC;
    s_axi_ctrl_wready : out STD_LOGIC;
    s_axi_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_ctrl_bvalid : out STD_LOGIC;
    s_axi_ctrl_bready : in STD_LOGIC;
    s_axi_ctrl_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_ctrl_arvalid : in STD_LOGIC;
    s_axi_ctrl_arready : out STD_LOGIC;
    s_axi_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_ctrl_rvalid : out STD_LOGIC;
    s_axi_ctrl_rready : in STD_LOGIC;
    bram_rst_a : out STD_LOGIC;
    bram_clk_a : out STD_LOGIC;
    bram_en_a : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 15 downto 0 );
    bram_addr_a : out STD_LOGIC_VECTOR ( 13 downto 0 );
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 127 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 127 downto 0 );
    bram_rst_b : out STD_LOGIC;
    bram_clk_b : out STD_LOGIC;
    bram_en_b : out STD_LOGIC;
    bram_we_b : out STD_LOGIC_VECTOR ( 15 downto 0 );
    bram_addr_b : out STD_LOGIC_VECTOR ( 13 downto 0 );
    bram_wrdata_b : out STD_LOGIC_VECTOR ( 127 downto 0 );
    bram_rddata_b : in STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  attribute C_BRAM_ADDR_WIDTH : integer;
  attribute C_BRAM_ADDR_WIDTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 10;
  attribute C_BRAM_INST_MODE : string;
  attribute C_BRAM_INST_MODE of axi_bram_ctrl_0_axi_bram_ctrl : entity is "INTERNAL";
  attribute C_ECC : integer;
  attribute C_ECC of axi_bram_ctrl_0_axi_bram_ctrl : entity is 0;
  attribute C_ECC_ONOFF_RESET_VALUE : integer;
  attribute C_ECC_ONOFF_RESET_VALUE of axi_bram_ctrl_0_axi_bram_ctrl : entity is 0;
  attribute C_ECC_TYPE : integer;
  attribute C_ECC_TYPE of axi_bram_ctrl_0_axi_bram_ctrl : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of axi_bram_ctrl_0_axi_bram_ctrl : entity is "kintex7";
  attribute C_FAULT_INJECT : integer;
  attribute C_FAULT_INJECT of axi_bram_ctrl_0_axi_bram_ctrl : entity is 0;
  attribute C_MEMORY_DEPTH : integer;
  attribute C_MEMORY_DEPTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 1024;
  attribute C_SELECT_XPM : integer;
  attribute C_SELECT_XPM of axi_bram_ctrl_0_axi_bram_ctrl : entity is 0;
  attribute C_SINGLE_PORT_BRAM : integer;
  attribute C_SINGLE_PORT_BRAM of axi_bram_ctrl_0_axi_bram_ctrl : entity is 0;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 14;
  attribute C_S_AXI_CTRL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CTRL_ADDR_WIDTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 32;
  attribute C_S_AXI_CTRL_DATA_WIDTH : integer;
  attribute C_S_AXI_CTRL_DATA_WIDTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 32;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 128;
  attribute C_S_AXI_ID_WIDTH : integer;
  attribute C_S_AXI_ID_WIDTH of axi_bram_ctrl_0_axi_bram_ctrl : entity is 1;
  attribute C_S_AXI_PROTOCOL : string;
  attribute C_S_AXI_PROTOCOL of axi_bram_ctrl_0_axi_bram_ctrl : entity is "AXI4";
  attribute C_S_AXI_SUPPORTS_NARROW_BURST : integer;
  attribute C_S_AXI_SUPPORTS_NARROW_BURST of axi_bram_ctrl_0_axi_bram_ctrl : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of axi_bram_ctrl_0_axi_bram_ctrl : entity is "yes";
end axi_bram_ctrl_0_axi_bram_ctrl;

architecture STRUCTURE of axi_bram_ctrl_0_axi_bram_ctrl is
  signal \<const0>\ : STD_LOGIC;
  signal p_1_out : STD_LOGIC_VECTOR ( 13 downto 4 );
  signal p_34_out : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal p_3_out : STD_LOGIC;
  signal p_6_out : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal p_7_out : STD_LOGIC_VECTOR ( 13 downto 4 );
  signal p_8_out : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal p_9_out : STD_LOGIC;
begin
  bram_addr_a(13) <= \<const0>\;
  bram_addr_a(12) <= \<const0>\;
  bram_addr_a(11) <= \<const0>\;
  bram_addr_a(10) <= \<const0>\;
  bram_addr_a(9) <= \<const0>\;
  bram_addr_a(8) <= \<const0>\;
  bram_addr_a(7) <= \<const0>\;
  bram_addr_a(6) <= \<const0>\;
  bram_addr_a(5) <= \<const0>\;
  bram_addr_a(4) <= \<const0>\;
  bram_addr_a(3) <= \<const0>\;
  bram_addr_a(2) <= \<const0>\;
  bram_addr_a(1) <= \<const0>\;
  bram_addr_a(0) <= \<const0>\;
  bram_addr_b(13) <= \<const0>\;
  bram_addr_b(12) <= \<const0>\;
  bram_addr_b(11) <= \<const0>\;
  bram_addr_b(10) <= \<const0>\;
  bram_addr_b(9) <= \<const0>\;
  bram_addr_b(8) <= \<const0>\;
  bram_addr_b(7) <= \<const0>\;
  bram_addr_b(6) <= \<const0>\;
  bram_addr_b(5) <= \<const0>\;
  bram_addr_b(4) <= \<const0>\;
  bram_addr_b(3) <= \<const0>\;
  bram_addr_b(2) <= \<const0>\;
  bram_addr_b(1) <= \<const0>\;
  bram_addr_b(0) <= \<const0>\;
  bram_clk_a <= \<const0>\;
  bram_clk_b <= \<const0>\;
  bram_en_a <= \<const0>\;
  bram_en_b <= \<const0>\;
  bram_rst_a <= \<const0>\;
  bram_rst_b <= \<const0>\;
  bram_we_a(15) <= \<const0>\;
  bram_we_a(14) <= \<const0>\;
  bram_we_a(13) <= \<const0>\;
  bram_we_a(12) <= \<const0>\;
  bram_we_a(11) <= \<const0>\;
  bram_we_a(10) <= \<const0>\;
  bram_we_a(9) <= \<const0>\;
  bram_we_a(8) <= \<const0>\;
  bram_we_a(7) <= \<const0>\;
  bram_we_a(6) <= \<const0>\;
  bram_we_a(5) <= \<const0>\;
  bram_we_a(4) <= \<const0>\;
  bram_we_a(3) <= \<const0>\;
  bram_we_a(2) <= \<const0>\;
  bram_we_a(1) <= \<const0>\;
  bram_we_a(0) <= \<const0>\;
  bram_we_b(15) <= \<const0>\;
  bram_we_b(14) <= \<const0>\;
  bram_we_b(13) <= \<const0>\;
  bram_we_b(12) <= \<const0>\;
  bram_we_b(11) <= \<const0>\;
  bram_we_b(10) <= \<const0>\;
  bram_we_b(9) <= \<const0>\;
  bram_we_b(8) <= \<const0>\;
  bram_we_b(7) <= \<const0>\;
  bram_we_b(6) <= \<const0>\;
  bram_we_b(5) <= \<const0>\;
  bram_we_b(4) <= \<const0>\;
  bram_we_b(3) <= \<const0>\;
  bram_we_b(2) <= \<const0>\;
  bram_we_b(1) <= \<const0>\;
  bram_we_b(0) <= \<const0>\;
  bram_wrdata_a(127) <= \<const0>\;
  bram_wrdata_a(126) <= \<const0>\;
  bram_wrdata_a(125) <= \<const0>\;
  bram_wrdata_a(124) <= \<const0>\;
  bram_wrdata_a(123) <= \<const0>\;
  bram_wrdata_a(122) <= \<const0>\;
  bram_wrdata_a(121) <= \<const0>\;
  bram_wrdata_a(120) <= \<const0>\;
  bram_wrdata_a(119) <= \<const0>\;
  bram_wrdata_a(118) <= \<const0>\;
  bram_wrdata_a(117) <= \<const0>\;
  bram_wrdata_a(116) <= \<const0>\;
  bram_wrdata_a(115) <= \<const0>\;
  bram_wrdata_a(114) <= \<const0>\;
  bram_wrdata_a(113) <= \<const0>\;
  bram_wrdata_a(112) <= \<const0>\;
  bram_wrdata_a(111) <= \<const0>\;
  bram_wrdata_a(110) <= \<const0>\;
  bram_wrdata_a(109) <= \<const0>\;
  bram_wrdata_a(108) <= \<const0>\;
  bram_wrdata_a(107) <= \<const0>\;
  bram_wrdata_a(106) <= \<const0>\;
  bram_wrdata_a(105) <= \<const0>\;
  bram_wrdata_a(104) <= \<const0>\;
  bram_wrdata_a(103) <= \<const0>\;
  bram_wrdata_a(102) <= \<const0>\;
  bram_wrdata_a(101) <= \<const0>\;
  bram_wrdata_a(100) <= \<const0>\;
  bram_wrdata_a(99) <= \<const0>\;
  bram_wrdata_a(98) <= \<const0>\;
  bram_wrdata_a(97) <= \<const0>\;
  bram_wrdata_a(96) <= \<const0>\;
  bram_wrdata_a(95) <= \<const0>\;
  bram_wrdata_a(94) <= \<const0>\;
  bram_wrdata_a(93) <= \<const0>\;
  bram_wrdata_a(92) <= \<const0>\;
  bram_wrdata_a(91) <= \<const0>\;
  bram_wrdata_a(90) <= \<const0>\;
  bram_wrdata_a(89) <= \<const0>\;
  bram_wrdata_a(88) <= \<const0>\;
  bram_wrdata_a(87) <= \<const0>\;
  bram_wrdata_a(86) <= \<const0>\;
  bram_wrdata_a(85) <= \<const0>\;
  bram_wrdata_a(84) <= \<const0>\;
  bram_wrdata_a(83) <= \<const0>\;
  bram_wrdata_a(82) <= \<const0>\;
  bram_wrdata_a(81) <= \<const0>\;
  bram_wrdata_a(80) <= \<const0>\;
  bram_wrdata_a(79) <= \<const0>\;
  bram_wrdata_a(78) <= \<const0>\;
  bram_wrdata_a(77) <= \<const0>\;
  bram_wrdata_a(76) <= \<const0>\;
  bram_wrdata_a(75) <= \<const0>\;
  bram_wrdata_a(74) <= \<const0>\;
  bram_wrdata_a(73) <= \<const0>\;
  bram_wrdata_a(72) <= \<const0>\;
  bram_wrdata_a(71) <= \<const0>\;
  bram_wrdata_a(70) <= \<const0>\;
  bram_wrdata_a(69) <= \<const0>\;
  bram_wrdata_a(68) <= \<const0>\;
  bram_wrdata_a(67) <= \<const0>\;
  bram_wrdata_a(66) <= \<const0>\;
  bram_wrdata_a(65) <= \<const0>\;
  bram_wrdata_a(64) <= \<const0>\;
  bram_wrdata_a(63) <= \<const0>\;
  bram_wrdata_a(62) <= \<const0>\;
  bram_wrdata_a(61) <= \<const0>\;
  bram_wrdata_a(60) <= \<const0>\;
  bram_wrdata_a(59) <= \<const0>\;
  bram_wrdata_a(58) <= \<const0>\;
  bram_wrdata_a(57) <= \<const0>\;
  bram_wrdata_a(56) <= \<const0>\;
  bram_wrdata_a(55) <= \<const0>\;
  bram_wrdata_a(54) <= \<const0>\;
  bram_wrdata_a(53) <= \<const0>\;
  bram_wrdata_a(52) <= \<const0>\;
  bram_wrdata_a(51) <= \<const0>\;
  bram_wrdata_a(50) <= \<const0>\;
  bram_wrdata_a(49) <= \<const0>\;
  bram_wrdata_a(48) <= \<const0>\;
  bram_wrdata_a(47) <= \<const0>\;
  bram_wrdata_a(46) <= \<const0>\;
  bram_wrdata_a(45) <= \<const0>\;
  bram_wrdata_a(44) <= \<const0>\;
  bram_wrdata_a(43) <= \<const0>\;
  bram_wrdata_a(42) <= \<const0>\;
  bram_wrdata_a(41) <= \<const0>\;
  bram_wrdata_a(40) <= \<const0>\;
  bram_wrdata_a(39) <= \<const0>\;
  bram_wrdata_a(38) <= \<const0>\;
  bram_wrdata_a(37) <= \<const0>\;
  bram_wrdata_a(36) <= \<const0>\;
  bram_wrdata_a(35) <= \<const0>\;
  bram_wrdata_a(34) <= \<const0>\;
  bram_wrdata_a(33) <= \<const0>\;
  bram_wrdata_a(32) <= \<const0>\;
  bram_wrdata_a(31) <= \<const0>\;
  bram_wrdata_a(30) <= \<const0>\;
  bram_wrdata_a(29) <= \<const0>\;
  bram_wrdata_a(28) <= \<const0>\;
  bram_wrdata_a(27) <= \<const0>\;
  bram_wrdata_a(26) <= \<const0>\;
  bram_wrdata_a(25) <= \<const0>\;
  bram_wrdata_a(24) <= \<const0>\;
  bram_wrdata_a(23) <= \<const0>\;
  bram_wrdata_a(22) <= \<const0>\;
  bram_wrdata_a(21) <= \<const0>\;
  bram_wrdata_a(20) <= \<const0>\;
  bram_wrdata_a(19) <= \<const0>\;
  bram_wrdata_a(18) <= \<const0>\;
  bram_wrdata_a(17) <= \<const0>\;
  bram_wrdata_a(16) <= \<const0>\;
  bram_wrdata_a(15) <= \<const0>\;
  bram_wrdata_a(14) <= \<const0>\;
  bram_wrdata_a(13) <= \<const0>\;
  bram_wrdata_a(12) <= \<const0>\;
  bram_wrdata_a(11) <= \<const0>\;
  bram_wrdata_a(10) <= \<const0>\;
  bram_wrdata_a(9) <= \<const0>\;
  bram_wrdata_a(8) <= \<const0>\;
  bram_wrdata_a(7) <= \<const0>\;
  bram_wrdata_a(6) <= \<const0>\;
  bram_wrdata_a(5) <= \<const0>\;
  bram_wrdata_a(4) <= \<const0>\;
  bram_wrdata_a(3) <= \<const0>\;
  bram_wrdata_a(2) <= \<const0>\;
  bram_wrdata_a(1) <= \<const0>\;
  bram_wrdata_a(0) <= \<const0>\;
  bram_wrdata_b(127) <= \<const0>\;
  bram_wrdata_b(126) <= \<const0>\;
  bram_wrdata_b(125) <= \<const0>\;
  bram_wrdata_b(124) <= \<const0>\;
  bram_wrdata_b(123) <= \<const0>\;
  bram_wrdata_b(122) <= \<const0>\;
  bram_wrdata_b(121) <= \<const0>\;
  bram_wrdata_b(120) <= \<const0>\;
  bram_wrdata_b(119) <= \<const0>\;
  bram_wrdata_b(118) <= \<const0>\;
  bram_wrdata_b(117) <= \<const0>\;
  bram_wrdata_b(116) <= \<const0>\;
  bram_wrdata_b(115) <= \<const0>\;
  bram_wrdata_b(114) <= \<const0>\;
  bram_wrdata_b(113) <= \<const0>\;
  bram_wrdata_b(112) <= \<const0>\;
  bram_wrdata_b(111) <= \<const0>\;
  bram_wrdata_b(110) <= \<const0>\;
  bram_wrdata_b(109) <= \<const0>\;
  bram_wrdata_b(108) <= \<const0>\;
  bram_wrdata_b(107) <= \<const0>\;
  bram_wrdata_b(106) <= \<const0>\;
  bram_wrdata_b(105) <= \<const0>\;
  bram_wrdata_b(104) <= \<const0>\;
  bram_wrdata_b(103) <= \<const0>\;
  bram_wrdata_b(102) <= \<const0>\;
  bram_wrdata_b(101) <= \<const0>\;
  bram_wrdata_b(100) <= \<const0>\;
  bram_wrdata_b(99) <= \<const0>\;
  bram_wrdata_b(98) <= \<const0>\;
  bram_wrdata_b(97) <= \<const0>\;
  bram_wrdata_b(96) <= \<const0>\;
  bram_wrdata_b(95) <= \<const0>\;
  bram_wrdata_b(94) <= \<const0>\;
  bram_wrdata_b(93) <= \<const0>\;
  bram_wrdata_b(92) <= \<const0>\;
  bram_wrdata_b(91) <= \<const0>\;
  bram_wrdata_b(90) <= \<const0>\;
  bram_wrdata_b(89) <= \<const0>\;
  bram_wrdata_b(88) <= \<const0>\;
  bram_wrdata_b(87) <= \<const0>\;
  bram_wrdata_b(86) <= \<const0>\;
  bram_wrdata_b(85) <= \<const0>\;
  bram_wrdata_b(84) <= \<const0>\;
  bram_wrdata_b(83) <= \<const0>\;
  bram_wrdata_b(82) <= \<const0>\;
  bram_wrdata_b(81) <= \<const0>\;
  bram_wrdata_b(80) <= \<const0>\;
  bram_wrdata_b(79) <= \<const0>\;
  bram_wrdata_b(78) <= \<const0>\;
  bram_wrdata_b(77) <= \<const0>\;
  bram_wrdata_b(76) <= \<const0>\;
  bram_wrdata_b(75) <= \<const0>\;
  bram_wrdata_b(74) <= \<const0>\;
  bram_wrdata_b(73) <= \<const0>\;
  bram_wrdata_b(72) <= \<const0>\;
  bram_wrdata_b(71) <= \<const0>\;
  bram_wrdata_b(70) <= \<const0>\;
  bram_wrdata_b(69) <= \<const0>\;
  bram_wrdata_b(68) <= \<const0>\;
  bram_wrdata_b(67) <= \<const0>\;
  bram_wrdata_b(66) <= \<const0>\;
  bram_wrdata_b(65) <= \<const0>\;
  bram_wrdata_b(64) <= \<const0>\;
  bram_wrdata_b(63) <= \<const0>\;
  bram_wrdata_b(62) <= \<const0>\;
  bram_wrdata_b(61) <= \<const0>\;
  bram_wrdata_b(60) <= \<const0>\;
  bram_wrdata_b(59) <= \<const0>\;
  bram_wrdata_b(58) <= \<const0>\;
  bram_wrdata_b(57) <= \<const0>\;
  bram_wrdata_b(56) <= \<const0>\;
  bram_wrdata_b(55) <= \<const0>\;
  bram_wrdata_b(54) <= \<const0>\;
  bram_wrdata_b(53) <= \<const0>\;
  bram_wrdata_b(52) <= \<const0>\;
  bram_wrdata_b(51) <= \<const0>\;
  bram_wrdata_b(50) <= \<const0>\;
  bram_wrdata_b(49) <= \<const0>\;
  bram_wrdata_b(48) <= \<const0>\;
  bram_wrdata_b(47) <= \<const0>\;
  bram_wrdata_b(46) <= \<const0>\;
  bram_wrdata_b(45) <= \<const0>\;
  bram_wrdata_b(44) <= \<const0>\;
  bram_wrdata_b(43) <= \<const0>\;
  bram_wrdata_b(42) <= \<const0>\;
  bram_wrdata_b(41) <= \<const0>\;
  bram_wrdata_b(40) <= \<const0>\;
  bram_wrdata_b(39) <= \<const0>\;
  bram_wrdata_b(38) <= \<const0>\;
  bram_wrdata_b(37) <= \<const0>\;
  bram_wrdata_b(36) <= \<const0>\;
  bram_wrdata_b(35) <= \<const0>\;
  bram_wrdata_b(34) <= \<const0>\;
  bram_wrdata_b(33) <= \<const0>\;
  bram_wrdata_b(32) <= \<const0>\;
  bram_wrdata_b(31) <= \<const0>\;
  bram_wrdata_b(30) <= \<const0>\;
  bram_wrdata_b(29) <= \<const0>\;
  bram_wrdata_b(28) <= \<const0>\;
  bram_wrdata_b(27) <= \<const0>\;
  bram_wrdata_b(26) <= \<const0>\;
  bram_wrdata_b(25) <= \<const0>\;
  bram_wrdata_b(24) <= \<const0>\;
  bram_wrdata_b(23) <= \<const0>\;
  bram_wrdata_b(22) <= \<const0>\;
  bram_wrdata_b(21) <= \<const0>\;
  bram_wrdata_b(20) <= \<const0>\;
  bram_wrdata_b(19) <= \<const0>\;
  bram_wrdata_b(18) <= \<const0>\;
  bram_wrdata_b(17) <= \<const0>\;
  bram_wrdata_b(16) <= \<const0>\;
  bram_wrdata_b(15) <= \<const0>\;
  bram_wrdata_b(14) <= \<const0>\;
  bram_wrdata_b(13) <= \<const0>\;
  bram_wrdata_b(12) <= \<const0>\;
  bram_wrdata_b(11) <= \<const0>\;
  bram_wrdata_b(10) <= \<const0>\;
  bram_wrdata_b(9) <= \<const0>\;
  bram_wrdata_b(8) <= \<const0>\;
  bram_wrdata_b(7) <= \<const0>\;
  bram_wrdata_b(6) <= \<const0>\;
  bram_wrdata_b(5) <= \<const0>\;
  bram_wrdata_b(4) <= \<const0>\;
  bram_wrdata_b(3) <= \<const0>\;
  bram_wrdata_b(2) <= \<const0>\;
  bram_wrdata_b(1) <= \<const0>\;
  bram_wrdata_b(0) <= \<const0>\;
  ecc_interrupt <= \<const0>\;
  ecc_ue <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_ctrl_arready <= \<const0>\;
  s_axi_ctrl_awready <= \<const0>\;
  s_axi_ctrl_bresp(1) <= \<const0>\;
  s_axi_ctrl_bresp(0) <= \<const0>\;
  s_axi_ctrl_bvalid <= \<const0>\;
  s_axi_ctrl_rdata(31) <= \<const0>\;
  s_axi_ctrl_rdata(30) <= \<const0>\;
  s_axi_ctrl_rdata(29) <= \<const0>\;
  s_axi_ctrl_rdata(28) <= \<const0>\;
  s_axi_ctrl_rdata(27) <= \<const0>\;
  s_axi_ctrl_rdata(26) <= \<const0>\;
  s_axi_ctrl_rdata(25) <= \<const0>\;
  s_axi_ctrl_rdata(24) <= \<const0>\;
  s_axi_ctrl_rdata(23) <= \<const0>\;
  s_axi_ctrl_rdata(22) <= \<const0>\;
  s_axi_ctrl_rdata(21) <= \<const0>\;
  s_axi_ctrl_rdata(20) <= \<const0>\;
  s_axi_ctrl_rdata(19) <= \<const0>\;
  s_axi_ctrl_rdata(18) <= \<const0>\;
  s_axi_ctrl_rdata(17) <= \<const0>\;
  s_axi_ctrl_rdata(16) <= \<const0>\;
  s_axi_ctrl_rdata(15) <= \<const0>\;
  s_axi_ctrl_rdata(14) <= \<const0>\;
  s_axi_ctrl_rdata(13) <= \<const0>\;
  s_axi_ctrl_rdata(12) <= \<const0>\;
  s_axi_ctrl_rdata(11) <= \<const0>\;
  s_axi_ctrl_rdata(10) <= \<const0>\;
  s_axi_ctrl_rdata(9) <= \<const0>\;
  s_axi_ctrl_rdata(8) <= \<const0>\;
  s_axi_ctrl_rdata(7) <= \<const0>\;
  s_axi_ctrl_rdata(6) <= \<const0>\;
  s_axi_ctrl_rdata(5) <= \<const0>\;
  s_axi_ctrl_rdata(4) <= \<const0>\;
  s_axi_ctrl_rdata(3) <= \<const0>\;
  s_axi_ctrl_rdata(2) <= \<const0>\;
  s_axi_ctrl_rdata(1) <= \<const0>\;
  s_axi_ctrl_rdata(0) <= \<const0>\;
  s_axi_ctrl_rresp(1) <= \<const0>\;
  s_axi_ctrl_rresp(0) <= \<const0>\;
  s_axi_ctrl_rvalid <= \<const0>\;
  s_axi_ctrl_wready <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gint_inst.abcv4_0_int_inst\: entity work.axi_bram_ctrl_0_axi_bram_ctrl_top
     port map (
      BRAM_En_A => p_9_out,
      BRAM_WrData_A(127 downto 0) => p_6_out(127 downto 0),
      D(127 downto 0) => p_34_out(127 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\(9 downto 0) => p_7_out(13 downto 4),
      \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0\(9 downto 0) => p_1_out(13 downto 4),
      Q(15 downto 0) => p_8_out(15 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(13 downto 0) => s_axi_araddr(13 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(13 downto 0) => s_axi_awaddr(13 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(127 downto 0) => s_axi_rdata(127 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(127 downto 0) => s_axi_wdata(127 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(15 downto 0) => s_axi_wstrb(15 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
\gint_inst.blk_mem_gen.bmgv81_inst\: entity work.axi_bram_ctrl_0_blk_mem_gen_v8_3_4
     port map (
      BRAM_En_A => p_9_out,
      BRAM_WrData_A(127 downto 0) => p_6_out(127 downto 0),
      D(127 downto 0) => p_34_out(127 downto 0),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]\(9 downto 0) => p_7_out(13 downto 4),
      \GEN_DUAL_ADDR_CNT.bram_addr_int_reg[13]_0\(9 downto 0) => p_1_out(13 downto 4),
      Q(15 downto 0) => p_8_out(15 downto 0),
      p_3_out => p_3_out,
      s_axi_aclk => s_axi_aclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_bram_ctrl_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of axi_bram_ctrl_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of axi_bram_ctrl_0 : entity is "axi_bram_ctrl_0,axi_bram_ctrl,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of axi_bram_ctrl_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of axi_bram_ctrl_0 : entity is "axi_bram_ctrl,Vivado 2016.3";
end axi_bram_ctrl_0;

architecture STRUCTURE of axi_bram_ctrl_0 is
  signal NLW_U0_bram_clk_a_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_clk_b_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_en_a_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_en_b_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_rst_a_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_rst_b_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_ecc_interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_ecc_ue_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_addr_a_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_U0_bram_addr_b_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_U0_bram_we_a_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_bram_we_b_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_bram_wrdata_a_UNCONNECTED : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal NLW_U0_bram_wrdata_b_UNCONNECTED : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_ctrl_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_ctrl_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_s_axi_ctrl_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute C_BRAM_ADDR_WIDTH : integer;
  attribute C_BRAM_ADDR_WIDTH of U0 : label is 10;
  attribute C_BRAM_INST_MODE : string;
  attribute C_BRAM_INST_MODE of U0 : label is "INTERNAL";
  attribute C_ECC : integer;
  attribute C_ECC of U0 : label is 0;
  attribute C_ECC_ONOFF_RESET_VALUE : integer;
  attribute C_ECC_ONOFF_RESET_VALUE of U0 : label is 0;
  attribute C_ECC_TYPE : integer;
  attribute C_ECC_TYPE of U0 : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "kintex7";
  attribute C_FAULT_INJECT : integer;
  attribute C_FAULT_INJECT of U0 : label is 0;
  attribute C_MEMORY_DEPTH : integer;
  attribute C_MEMORY_DEPTH of U0 : label is 1024;
  attribute C_SELECT_XPM : integer;
  attribute C_SELECT_XPM of U0 : label is 0;
  attribute C_SINGLE_PORT_BRAM : integer;
  attribute C_SINGLE_PORT_BRAM of U0 : label is 0;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of U0 : label is 14;
  attribute C_S_AXI_CTRL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CTRL_ADDR_WIDTH of U0 : label is 32;
  attribute C_S_AXI_CTRL_DATA_WIDTH : integer;
  attribute C_S_AXI_CTRL_DATA_WIDTH of U0 : label is 32;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of U0 : label is 128;
  attribute C_S_AXI_ID_WIDTH : integer;
  attribute C_S_AXI_ID_WIDTH of U0 : label is 1;
  attribute C_S_AXI_PROTOCOL : string;
  attribute C_S_AXI_PROTOCOL of U0 : label is "AXI4";
  attribute C_S_AXI_SUPPORTS_NARROW_BURST : integer;
  attribute C_S_AXI_SUPPORTS_NARROW_BURST of U0 : label is 1;
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
U0: entity work.axi_bram_ctrl_0_axi_bram_ctrl
     port map (
      bram_addr_a(13 downto 0) => NLW_U0_bram_addr_a_UNCONNECTED(13 downto 0),
      bram_addr_b(13 downto 0) => NLW_U0_bram_addr_b_UNCONNECTED(13 downto 0),
      bram_clk_a => NLW_U0_bram_clk_a_UNCONNECTED,
      bram_clk_b => NLW_U0_bram_clk_b_UNCONNECTED,
      bram_en_a => NLW_U0_bram_en_a_UNCONNECTED,
      bram_en_b => NLW_U0_bram_en_b_UNCONNECTED,
      bram_rddata_a(127 downto 0) => B"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      bram_rddata_b(127 downto 0) => B"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      bram_rst_a => NLW_U0_bram_rst_a_UNCONNECTED,
      bram_rst_b => NLW_U0_bram_rst_b_UNCONNECTED,
      bram_we_a(15 downto 0) => NLW_U0_bram_we_a_UNCONNECTED(15 downto 0),
      bram_we_b(15 downto 0) => NLW_U0_bram_we_b_UNCONNECTED(15 downto 0),
      bram_wrdata_a(127 downto 0) => NLW_U0_bram_wrdata_a_UNCONNECTED(127 downto 0),
      bram_wrdata_b(127 downto 0) => NLW_U0_bram_wrdata_b_UNCONNECTED(127 downto 0),
      ecc_interrupt => NLW_U0_ecc_interrupt_UNCONNECTED,
      ecc_ue => NLW_U0_ecc_ue_UNCONNECTED,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(13 downto 0) => s_axi_araddr(13 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_arcache(3 downto 0) => s_axi_arcache(3 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => '0',
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arlock => s_axi_arlock,
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(13 downto 0) => s_axi_awaddr(13 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awcache(3 downto 0) => s_axi_awcache(3 downto 0),
      s_axi_awid(0) => '0',
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awlock => s_axi_awlock,
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => NLW_U0_s_axi_bid_UNCONNECTED(0),
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_ctrl_araddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_ctrl_arready => NLW_U0_s_axi_ctrl_arready_UNCONNECTED,
      s_axi_ctrl_arvalid => '0',
      s_axi_ctrl_awaddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_ctrl_awready => NLW_U0_s_axi_ctrl_awready_UNCONNECTED,
      s_axi_ctrl_awvalid => '0',
      s_axi_ctrl_bready => '0',
      s_axi_ctrl_bresp(1 downto 0) => NLW_U0_s_axi_ctrl_bresp_UNCONNECTED(1 downto 0),
      s_axi_ctrl_bvalid => NLW_U0_s_axi_ctrl_bvalid_UNCONNECTED,
      s_axi_ctrl_rdata(31 downto 0) => NLW_U0_s_axi_ctrl_rdata_UNCONNECTED(31 downto 0),
      s_axi_ctrl_rready => '0',
      s_axi_ctrl_rresp(1 downto 0) => NLW_U0_s_axi_ctrl_rresp_UNCONNECTED(1 downto 0),
      s_axi_ctrl_rvalid => NLW_U0_s_axi_ctrl_rvalid_UNCONNECTED,
      s_axi_ctrl_wdata(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_ctrl_wready => NLW_U0_s_axi_ctrl_wready_UNCONNECTED,
      s_axi_ctrl_wvalid => '0',
      s_axi_rdata(127 downto 0) => s_axi_rdata(127 downto 0),
      s_axi_rid(0) => NLW_U0_s_axi_rid_UNCONNECTED(0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(127 downto 0) => s_axi_wdata(127 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(15 downto 0) => s_axi_wstrb(15 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
