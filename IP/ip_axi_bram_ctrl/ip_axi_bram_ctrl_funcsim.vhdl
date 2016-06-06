-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Wed Jun 01 12:04:18 2016
-- Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim d:/Telops/fir-00251-Proc/IP/ip_axi_bram_ctrl/ip_axi_bram_ctrl_funcsim.vhdl
-- Design      : ip_axi_bram_ctrl
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlaxi_bram_ctrl_v3_0_SRL_FIFO is
  port (
    bid_gets_fifo_load : out STD_LOGIC;
    O1 : out STD_LOGIC;
    bvalid_cnt_inc0 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    AW2Arb_BVALID_Cnt : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_1_out : in STD_LOGIC;
    I1 : in STD_LOGIC;
    bid_gets_fifo_load_d1 : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    I3 : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    axi_wr_burst : in STD_LOGIC;
    I4 : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi_wdata_full_cmb16_out : in STD_LOGIC;
    wr_data_sng_sm_cs : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wvalid : in STD_LOGIC
  );
end ip_axi_bram_ctrlaxi_bram_ctrl_v3_0_SRL_FIFO;

architecture STRUCTURE of ip_axi_bram_ctrlaxi_bram_ctrl_v3_0_SRL_FIFO is
  signal CI : STD_LOGIC;
  signal D : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal S : STD_LOGIC;
  signal S2_out : STD_LOGIC;
  signal S4_out : STD_LOGIC;
  signal S6_out : STD_LOGIC;
  signal VCC_1 : STD_LOGIC;
  signal bid_fifo_not_empty : STD_LOGIC;
  signal bid_fifo_rd : STD_LOGIC;
  signal bid_fifo_rd_en : STD_LOGIC;
  signal \^bid_gets_fifo_load\ : STD_LOGIC;
  signal buffer_Empty : STD_LOGIC;
  signal \^bvalid_cnt_inc0\ : STD_LOGIC;
  signal bvalid_cnt_non_zero : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal \n_0_Addr_Counters[0].FDRE_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[0].MUXCY_L_I_i_2\ : STD_LOGIC;
  signal \n_0_Addr_Counters[1].FDRE_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[1].MUXCY_L_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[1].XORCY_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[2].FDRE_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[2].XORCY_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[3].FDRE_I\ : STD_LOGIC;
  signal \n_0_Addr_Counters[3].XORCY_I\ : STD_LOGIC;
  signal n_0_Data_Exists_DFF_i_1 : STD_LOGIC;
  signal n_0_bid_gets_fifo_load_d1_i_2 : STD_LOGIC;
  signal \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
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
  attribute srl_bus_name of \FIFO_RAM[0].SRL16E_I\ : label is "U0/\gext_inst.abcv3_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_WR_CHNL/BID_FIFO/FIFO_RAM ";
  attribute srl_name : string;
  attribute srl_name of \FIFO_RAM[0].SRL16E_I\ : label is "U0/\gext_inst.abcv3_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_WR_CHNL/BID_FIFO/FIFO_RAM[0].SRL16E_I ";
begin
  O1 <= \^o1\;
  bid_gets_fifo_load <= \^bid_gets_fifo_load\;
  bvalid_cnt_inc0 <= \^bvalid_cnt_inc0\;
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
      D => D,
      Q => \n_0_Addr_Counters[0].FDRE_I\,
      R => SR(0)
    );
\Addr_Counters[0].MUXCY_L_I_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3 downto 2) => \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_0_Addr_Counters[1].MUXCY_L_I\,
      CO(0) => CI,
      CYINIT => \n_0_Addr_Counters[0].MUXCY_L_I_i_2\,
      DI(3) => \NLW_Addr_Counters[0].MUXCY_L_I_CARRY4_DI_UNCONNECTED\(3),
      DI(2) => \n_0_Addr_Counters[2].FDRE_I\,
      DI(1) => \n_0_Addr_Counters[1].FDRE_I\,
      DI(0) => \n_0_Addr_Counters[0].FDRE_I\,
      O(3) => \n_0_Addr_Counters[3].XORCY_I\,
      O(2) => \n_0_Addr_Counters[2].XORCY_I\,
      O(1) => \n_0_Addr_Counters[1].XORCY_I\,
      O(0) => D,
      S(3) => S,
      S(2) => S2_out,
      S(1) => S4_out,
      S(0) => S6_out
    );
\Addr_Counters[0].MUXCY_L_I_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\Addr_Counters[0].MUXCY_L_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFEFFFF0000"
    )
    port map (
      I0 => \n_0_Addr_Counters[1].FDRE_I\,
      I1 => \n_0_Addr_Counters[3].FDRE_I\,
      I2 => \n_0_Addr_Counters[2].FDRE_I\,
      I3 => I2,
      I4 => \n_0_Addr_Counters[0].FDRE_I\,
      I5 => bid_fifo_rd_en,
      O => S6_out
    );
\Addr_Counters[0].MUXCY_L_I_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAA2AAAAAAA"
    )
    port map (
      I0 => I2,
      I1 => \n_0_Addr_Counters[0].FDRE_I\,
      I2 => \n_0_Addr_Counters[1].FDRE_I\,
      I3 => \n_0_Addr_Counters[3].FDRE_I\,
      I4 => \n_0_Addr_Counters[2].FDRE_I\,
      I5 => bid_fifo_rd_en,
      O => \n_0_Addr_Counters[0].MUXCY_L_I_i_2\
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
      D => \n_0_Addr_Counters[1].XORCY_I\,
      Q => \n_0_Addr_Counters[1].FDRE_I\,
      R => SR(0)
    );
\Addr_Counters[1].MUXCY_L_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFEFFFF0000"
    )
    port map (
      I0 => \n_0_Addr_Counters[0].FDRE_I\,
      I1 => \n_0_Addr_Counters[3].FDRE_I\,
      I2 => \n_0_Addr_Counters[2].FDRE_I\,
      I3 => I2,
      I4 => \n_0_Addr_Counters[1].FDRE_I\,
      I5 => bid_fifo_rd_en,
      O => S4_out
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
      D => \n_0_Addr_Counters[2].XORCY_I\,
      Q => \n_0_Addr_Counters[2].FDRE_I\,
      R => SR(0)
    );
\Addr_Counters[2].MUXCY_L_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFEFFFF0000"
    )
    port map (
      I0 => \n_0_Addr_Counters[0].FDRE_I\,
      I1 => \n_0_Addr_Counters[1].FDRE_I\,
      I2 => \n_0_Addr_Counters[3].FDRE_I\,
      I3 => I2,
      I4 => \n_0_Addr_Counters[2].FDRE_I\,
      I5 => bid_fifo_rd_en,
      O => S2_out
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
      D => \n_0_Addr_Counters[3].XORCY_I\,
      Q => \n_0_Addr_Counters[3].FDRE_I\,
      R => SR(0)
    );
\Addr_Counters[3].XORCY_I_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFEFFFF0000"
    )
    port map (
      I0 => \n_0_Addr_Counters[0].FDRE_I\,
      I1 => \n_0_Addr_Counters[1].FDRE_I\,
      I2 => \n_0_Addr_Counters[2].FDRE_I\,
      I3 => I2,
      I4 => \n_0_Addr_Counters[3].FDRE_I\,
      I5 => bid_fifo_rd_en,
      O => S
    );
Data_Exists_DFF: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => VCC_1,
      D => n_0_Data_Exists_DFF_i_1,
      Q => bid_fifo_not_empty,
      R => SR(0)
    );
Data_Exists_DFF_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2FFF2020"
    )
    port map (
      I0 => p_1_out,
      I1 => I1,
      I2 => buffer_Empty,
      I3 => bid_fifo_rd_en,
      I4 => bid_fifo_not_empty,
      O => n_0_Data_Exists_DFF_i_1
    );
Data_Exists_DFF_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \n_0_Addr_Counters[0].FDRE_I\,
      I1 => \n_0_Addr_Counters[1].FDRE_I\,
      I2 => \n_0_Addr_Counters[3].FDRE_I\,
      I3 => \n_0_Addr_Counters[2].FDRE_I\,
      O => buffer_Empty
    );
\FIFO_RAM[0].SRL16E_I\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_Addr_Counters[0].FDRE_I\,
      A1 => \n_0_Addr_Counters[1].FDRE_I\,
      A2 => \n_0_Addr_Counters[2].FDRE_I\,
      A3 => \n_0_Addr_Counters[3].FDRE_I\,
      CE => \n_0_Addr_Counters[0].MUXCY_L_I_i_2\,
      CLK => s_axi_aclk,
      D => s_axi_awid(0),
      Q => bid_fifo_rd
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.clr_bram_we_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F8080808"
    )
    port map (
      I0 => axi_wdata_full_cmb16_out,
      I1 => \^bvalid_cnt_inc0\,
      I2 => wr_data_sng_sm_cs(1),
      I3 => s_axi_wlast,
      I4 => s_axi_wvalid,
      I5 => wr_data_sng_sm_cs(0),
      O => \^o1\
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"3A"
    )
    port map (
      I0 => s_axi_wlast,
      I1 => axi_wr_burst,
      I2 => I4,
      O => \^bvalid_cnt_inc0\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => VCC_1
    );
\axi_bid_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA8AA0800A80008"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => s_axi_bid(0),
      I2 => bid_fifo_rd_en,
      I3 => \^bid_gets_fifo_load\,
      I4 => bid_fifo_rd,
      I5 => s_axi_awid(0),
      O => O2
    );
\axi_bid_int[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA8AA20AA20AA20"
    )
    port map (
      I0 => bid_fifo_not_empty,
      I1 => bvalid_cnt_non_zero,
      I2 => \^o1\,
      I3 => bid_gets_fifo_load_d1,
      I4 => s_axi_bready,
      I5 => I3,
      O => bid_fifo_rd_en
    );
\axi_bid_int[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => AW2Arb_BVALID_Cnt(1),
      I1 => AW2Arb_BVALID_Cnt(2),
      I2 => AW2Arb_BVALID_Cnt(0),
      O => bvalid_cnt_non_zero
    );
bid_gets_fifo_load_d1_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000020A00000000"
    )
    port map (
      I0 => I2,
      I1 => n_0_bid_gets_fifo_load_d1_i_2,
      I2 => AW2Arb_BVALID_Cnt(2),
      I3 => AW2Arb_BVALID_Cnt(0),
      I4 => AW2Arb_BVALID_Cnt(1),
      I5 => \^o1\,
      O => \^bid_gets_fifo_load\
    );
bid_gets_fifo_load_d1_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBFFFFFFFFF"
    )
    port map (
      I0 => bid_fifo_not_empty,
      I1 => I3,
      I2 => AW2Arb_BVALID_Cnt(0),
      I3 => AW2Arb_BVALID_Cnt(2),
      I4 => AW2Arb_BVALID_Cnt(1),
      I5 => s_axi_bready,
      O => n_0_bid_gets_fifo_load_d1_i_2
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlsng_port_arb is
  port (
    s_axi_awready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    p_1_out : out STD_LOGIC;
    p_0_out : out STD_LOGIC;
    curr_narrow_burst_en : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    p_5_out : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    axi_wdata_full_cmb16_out : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I1 : in STD_LOGIC;
    s_axi_awlen : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    AR2Arb_Active_Clr : in STD_LOGIC;
    I10 : in STD_LOGIC;
    I11 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    last_arb_won_cmb6_out : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    curr_ua_narrow_wrap4 : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    curr_ua_narrow_wrap4_0 : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_wdata_full_reg : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    curr_narrow_burst_cmb : in STD_LOGIC;
    axi_rd_burst1 : in STD_LOGIC;
    curr_narrow_burst : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    I13 : in STD_LOGIC;
    I14 : in STD_LOGIC;
    s_axi_arlen : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I15 : in STD_LOGIC;
    ar_active_d1 : in STD_LOGIC;
    aw_active_d1 : in STD_LOGIC
  );
end ip_axi_bram_ctrlsng_port_arb;

architecture STRUCTURE of ip_axi_bram_ctrlsng_port_arb is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \I_RD_CHNL/p_1_out\ : STD_LOGIC;
  signal \I_WR_CHNL/p_2_out\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^o4\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC;
  signal ar_active_cmb : STD_LOGIC;
  signal arb_sm_cs : STD_LOGIC_VECTOR ( 0 to 0 );
  signal arb_sm_ns : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_arready_cmb : STD_LOGIC;
  signal last_arb_won : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_20\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_21__0\ : STD_LOGIC;
  signal n_0_ar_active_i_1 : STD_LOGIC;
  signal n_0_ar_active_i_2 : STD_LOGIC;
  signal \n_0_arb_sm_cs[0]_i_1\ : STD_LOGIC;
  signal \n_0_arb_sm_cs[0]_i_3\ : STD_LOGIC;
  signal \n_0_arb_sm_cs[1]_i_1\ : STD_LOGIC;
  signal n_0_aw_active_i_1 : STD_LOGIC;
  signal n_0_aw_active_i_2 : STD_LOGIC;
  signal n_0_axi_arready_int_i_2 : STD_LOGIC;
  signal n_0_axi_awready_int_i_1 : STD_LOGIC;
  signal n_0_last_arb_won_i_1 : STD_LOGIC;
  signal \^p_0_out\ : STD_LOGIC;
  signal \^p_1_out\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_3\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of ar_active_i_1 : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of axi_arready_int_i_2 : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of axi_awready_int_i_3 : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \bram_we_a[0]_INST_0\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \bram_we_a[1]_INST_0\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \bram_we_a[2]_INST_0\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \bram_we_a[3]_INST_0\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[12]_i_1__0\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \wrap_burst_total[2]_i_1\ : label is "soft_lutpair67";
begin
  O1 <= \^o1\;
  O3(0) <= \^o3\(0);
  O4 <= \^o4\;
  O5 <= \^o5\;
  p_0_out <= \^p_0_out\;
  p_1_out <= \^p_1_out\;
\GEN_AR_SNG.ar_active_d1_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0888"
    )
    port map (
      I0 => \^p_0_out\,
      I1 => s_axi_aresetn,
      I2 => s_axi_rready,
      I3 => I12,
      O => O7
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E00000000000"
    )
    port map (
      I0 => s_axi_awaddr(1),
      I1 => s_axi_awaddr(0),
      I2 => curr_ua_narrow_wrap4,
      I3 => s_axi_awburst(1),
      I4 => s_axi_awburst(0),
      I5 => \^o1\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_20\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000A80000000000"
    )
    port map (
      I0 => curr_ua_narrow_wrap4,
      I1 => s_axi_awaddr(1),
      I2 => s_axi_awaddr(0),
      I3 => s_axi_awburst(0),
      I4 => s_axi_awburst(1),
      I5 => \^o1\,
      O => \I_WR_CHNL/p_2_out\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_21__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E00000000000"
    )
    port map (
      I0 => s_axi_araddr(1),
      I1 => s_axi_araddr(0),
      I2 => curr_ua_narrow_wrap4_0,
      I3 => s_axi_arburst(1),
      I4 => s_axi_arburst(0),
      I5 => \^o5\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_21__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000A80000000000"
    )
    port map (
      I0 => curr_ua_narrow_wrap4_0,
      I1 => s_axi_araddr(1),
      I2 => s_axi_araddr(0),
      I3 => s_axi_arburst(0),
      I4 => s_axi_arburst(1),
      I5 => \^o5\,
      O => \I_RD_CHNL/p_1_out\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFE0000"
    )
    port map (
      I0 => I2,
      I1 => I3,
      I2 => I4,
      I3 => I5,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_20\,
      I5 => \I_WR_CHNL/p_2_out\,
      O => O2
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_8__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFE0000"
    )
    port map (
      I0 => I6,
      I1 => I7,
      I2 => I8,
      I3 => I9,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_21__0\,
      I5 => \I_RD_CHNL/p_1_out\,
      O => p_5_out
    );
\GEN_NARROW_EN.curr_narrow_burst_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFBFBFFF80808000"
    )
    port map (
      I0 => curr_narrow_burst_cmb,
      I1 => axi_rd_burst1,
      I2 => \^o5\,
      I3 => s_axi_arburst(1),
      I4 => s_axi_arburst(0),
      I5 => curr_narrow_burst,
      O => O6
    );
\GEN_NARROW_EN.curr_narrow_burst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E0E0E0E0E0E0E000"
    )
    port map (
      I0 => s_axi_awburst(0),
      I1 => s_axi_awburst(1),
      I2 => \^o1\,
      I3 => I1,
      I4 => s_axi_awlen(0),
      I5 => s_axi_awlen(1),
      O => curr_narrow_burst_en
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => \^p_1_out\,
      I1 => axi_wdata_full_reg,
      I2 => s_axi_wvalid,
      O => axi_wdata_full_cmb16_out
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ar_active_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \^p_0_out\,
      I2 => n_0_ar_active_i_2,
      I3 => ar_active_cmb,
      O => n_0_ar_active_i_1
    );
ar_active_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F008F8F0F008080"
    )
    port map (
      I0 => I12,
      I1 => s_axi_rready,
      I2 => arb_sm_cs(0),
      I3 => last_arb_won_cmb6_out,
      I4 => \^o3\(0),
      I5 => \^o4\,
      O => n_0_ar_active_i_2
    );
ar_active_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAEF0000AFEF0000"
    )
    port map (
      I0 => \^o3\(0),
      I1 => I11,
      I2 => arb_sm_cs(0),
      I3 => s_axi_awvalid,
      I4 => s_axi_arvalid,
      I5 => last_arb_won,
      O => ar_active_cmb
    );
ar_active_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_ar_active_i_1,
      Q => \^p_0_out\,
      R => \<const0>\
    );
\arb_sm_cs[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => arb_sm_ns(0),
      I1 => \n_0_arb_sm_cs[0]_i_3\,
      I2 => arb_sm_cs(0),
      O => \n_0_arb_sm_cs[0]_i_1\
    );
\arb_sm_cs[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"303B0000333B0000"
    )
    port map (
      I0 => I11,
      I1 => arb_sm_cs(0),
      I2 => \^o3\(0),
      I3 => s_axi_awvalid,
      I4 => s_axi_arvalid,
      I5 => last_arb_won,
      O => arb_sm_ns(0)
    );
\arb_sm_cs[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFB8BBCCCCB8BB"
    )
    port map (
      I0 => I10,
      I1 => \^o3\(0),
      I2 => \^o4\,
      I3 => I11,
      I4 => arb_sm_cs(0),
      I5 => AR2Arb_Active_Clr,
      O => \n_0_arb_sm_cs[0]_i_3\
    );
\arb_sm_cs[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0033444700004447"
    )
    port map (
      I0 => I10,
      I1 => \^o3\(0),
      I2 => \^o4\,
      I3 => I11,
      I4 => arb_sm_cs(0),
      I5 => AR2Arb_Active_Clr,
      O => \n_0_arb_sm_cs[1]_i_1\
    );
\arb_sm_cs_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_arb_sm_cs[0]_i_1\,
      Q => arb_sm_cs(0),
      R => SR(0)
    );
\arb_sm_cs_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_arb_sm_cs[1]_i_1\,
      Q => \^o3\(0),
      R => SR(0)
    );
aw_active_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"080808A8"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \^p_1_out\,
      I2 => n_0_aw_active_i_2,
      I3 => I11,
      I4 => \^o3\(0),
      O => n_0_aw_active_i_1
    );
aw_active_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"30003000308830BB"
    )
    port map (
      I0 => AR2Arb_Active_Clr,
      I1 => arb_sm_cs(0),
      I2 => I10,
      I3 => \^o3\(0),
      I4 => \^o4\,
      I5 => I11,
      O => n_0_aw_active_i_2
    );
aw_active_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_aw_active_i_1,
      Q => \^p_1_out\,
      R => \<const0>\
    );
axi_arready_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F008F8F0F008080"
    )
    port map (
      I0 => n_0_axi_arready_int_i_2,
      I1 => AR2Arb_Active_Clr,
      I2 => arb_sm_cs(0),
      I3 => last_arb_won_cmb6_out,
      I4 => \^o3\(0),
      I5 => \^o4\,
      O => axi_arready_cmb
    );
axi_arready_int_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_arvalid,
      O => n_0_axi_arready_int_i_2
    );
axi_arready_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => axi_arready_cmb,
      Q => s_axi_arready,
      R => SR(0)
    );
axi_awready_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000051010101"
    )
    port map (
      I0 => I11,
      I1 => \^o4\,
      I2 => arb_sm_cs(0),
      I3 => s_axi_rready,
      I4 => I12,
      I5 => \^o3\(0),
      O => n_0_axi_awready_int_i_1
    );
axi_awready_int_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4C"
    )
    port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_arvalid,
      I2 => last_arb_won,
      O => \^o4\
    );
axi_awready_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_awready_int_i_1,
      Q => s_axi_awready,
      R => SR(0)
    );
\bram_we_a[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_1_out\,
      I1 => Q(0),
      O => bram_we_a(0)
    );
\bram_we_a[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_1_out\,
      I1 => Q(1),
      O => bram_we_a(1)
    );
\bram_we_a[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_1_out\,
      I1 => Q(2),
      O => bram_we_a(2)
    );
\bram_we_a[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_1_out\,
      I1 => Q(3),
      O => bram_we_a(3)
    );
brst_zero_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE00FFFFFFFF"
    )
    port map (
      I0 => s_axi_arlen(1),
      I1 => s_axi_arlen(0),
      I2 => I15,
      I3 => \^p_0_out\,
      I4 => ar_active_d1,
      I5 => s_axi_aresetn,
      O => O8
    );
last_arb_won_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA888A800088808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => last_arb_won,
      I2 => I13,
      I3 => arb_sm_cs(0),
      I4 => I14,
      I5 => ar_active_cmb,
      O => n_0_last_arb_won_i_1
    );
last_arb_won_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_last_arb_won_i_1,
      Q => last_arb_won,
      R => \<const0>\
    );
\save_init_bram_addr_ld[12]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^p_0_out\,
      I1 => ar_active_d1,
      O => \^o5\
    );
\wrap_burst_total[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^p_1_out\,
      I1 => aw_active_d1,
      O => \^o1\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlwrap_brst is
  port (
    O2 : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    brst_cnt_dec : out STD_LOGIC;
    rd_adv_buf30_out : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O25 : out STD_LOGIC;
    O26 : out STD_LOGIC;
    O27 : out STD_LOGIC;
    O28 : out STD_LOGIC;
    O29 : out STD_LOGIC;
    O30 : out STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 10 downto 0 );
    p_0_out : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 0 to 0 );
    I5 : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    I1 : in STD_LOGIC;
    curr_wrap_burst_reg : in STD_LOGIC;
    I2 : in STD_LOGIC;
    narrow_bram_addr_inc_d1 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I3 : in STD_LOGIC;
    brst_zero : in STD_LOGIC;
    end_brst_rd : in STD_LOGIC;
    axi_rd_burst : in STD_LOGIC;
    I4 : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    I10 : in STD_LOGIC;
    narrow_addr_int : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC
  );
end ip_axi_bram_ctrlwrap_brst;

architecture STRUCTURE of ip_axi_bram_ctrlwrap_brst is
  signal \^o3\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal RdChnl_BRAM_Addr_Ld : STD_LOGIC_VECTOR ( 9 downto 1 );
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal bram_addr_ld_en_mod1 : STD_LOGIC;
  signal bram_addr_ld_wrap : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal \^brst_cnt_dec\ : STD_LOGIC;
  signal max_wrap_burst : STD_LOGIC;
  signal \n_0_brst_cnt[7]_i_4\ : STD_LOGIC;
  signal \n_0_brst_cnt[7]_i_5\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld[12]_i_5\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld[12]_i_6\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[10]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[11]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[12]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[3]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[4]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[5]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[6]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[7]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[8]\ : STD_LOGIC;
  signal \n_0_save_init_bram_addr_ld_reg[9]\ : STD_LOGIC;
  signal \n_0_wrap_burst_total[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_wrap_burst_total[1]_i_2__0\ : STD_LOGIC;
  signal \n_0_wrap_burst_total[2]_i_2__0\ : STD_LOGIC;
  signal \^rd_adv_buf30_out\ : STD_LOGIC;
  signal wrap_burst_total : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal wrap_burst_total_cmb : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[10]_i_4\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[11]_i_4\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[3]_i_4\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[5]_i_5\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[6]_i_4\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[7]_i_4\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[8]_i_4\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[9]_i_4\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[10]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[11]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[6]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[7]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[8]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[9]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \wrap_burst_total[0]_i_1__0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \wrap_burst_total[0]_i_2__0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_1__0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_2__0\ : label is "soft_lutpair18";
begin
  O3(0) <= \^o3\(0);
  SR(0) <= \^sr\(0);
  brst_cnt_dec <= \^brst_cnt_dec\;
  rd_adv_buf30_out <= \^rd_adv_buf30_out\;
\ADDR_SNG_PORT.bram_addr_int[10]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[10]\,
      I1 => s_axi_araddr(8),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(7),
      O => O29
    );
\ADDR_SNG_PORT.bram_addr_int[11]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[11]\,
      I1 => s_axi_araddr(9),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(8),
      O => O30
    );
\ADDR_SNG_PORT.bram_addr_int[12]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EEFE"
    )
    port map (
      I0 => p_3_in,
      I1 => bram_addr_ld_en_mod1,
      I2 => p_0_out,
      I3 => I1,
      O => O8
    );
\ADDR_SNG_PORT.bram_addr_int[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20202F20"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => bram_addr_ld_en_mod1,
      I2 => p_0_out,
      I3 => s_axi_awaddr(0),
      I4 => I5,
      O => O7
    );
\ADDR_SNG_PORT.bram_addr_int[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => bram_addr_ld_wrap(3),
      I1 => s_axi_araddr(1),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(0),
      O => O6
    );
\ADDR_SNG_PORT.bram_addr_int[3]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C0B0"
    )
    port map (
      I0 => wrap_burst_total(0),
      I1 => wrap_burst_total(2),
      I2 => \n_0_save_init_bram_addr_ld_reg[3]\,
      I3 => wrap_burst_total(1),
      O => bram_addr_ld_wrap(3)
    );
\ADDR_SNG_PORT.bram_addr_int[4]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => bram_addr_ld_wrap(4),
      I1 => s_axi_araddr(2),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(1),
      O => O5
    );
\ADDR_SNG_PORT.bram_addr_int[4]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BD00"
    )
    port map (
      I0 => wrap_burst_total(2),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(1),
      I3 => \n_0_save_init_bram_addr_ld_reg[4]\,
      O => bram_addr_ld_wrap(4)
    );
\ADDR_SNG_PORT.bram_addr_int[5]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => bram_addr_ld_wrap(5),
      I1 => s_axi_araddr(3),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(2),
      O => O2
    );
\ADDR_SNG_PORT.bram_addr_int[5]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD00"
    )
    port map (
      I0 => wrap_burst_total(2),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(1),
      I3 => \n_0_save_init_bram_addr_ld_reg[5]\,
      O => bram_addr_ld_wrap(5)
    );
\ADDR_SNG_PORT.bram_addr_int[6]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[6]\,
      I1 => s_axi_araddr(4),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(3),
      O => O25
    );
\ADDR_SNG_PORT.bram_addr_int[7]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[7]\,
      I1 => s_axi_araddr(5),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(4),
      O => O26
    );
\ADDR_SNG_PORT.bram_addr_int[8]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[8]\,
      I1 => s_axi_araddr(6),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(5),
      O => O27
    );
\ADDR_SNG_PORT.bram_addr_int[9]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACFFAC00"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[9]\,
      I1 => s_axi_araddr(7),
      I2 => bram_addr_ld_en_mod1,
      I3 => p_0_out,
      I4 => D(6),
      O => O28
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => I4,
      I1 => s_axi_rready,
      O => \^rd_adv_buf30_out\
    );
bram_rst_a_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => s_axi_aresetn,
      O => \^sr\(0)
    );
\brst_cnt[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01015101"
    )
    port map (
      I0 => Q(3),
      I1 => \n_0_brst_cnt[7]_i_4\,
      I2 => Q(0),
      I3 => \n_0_brst_cnt[7]_i_5\,
      I4 => Q(2),
      O => \^brst_cnt_dec\
    );
\brst_cnt[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFBCBFBFBFBFB"
    )
    port map (
      I0 => I3,
      I1 => Q(1),
      I2 => Q(2),
      I3 => brst_zero,
      I4 => end_brst_rd,
      I5 => \^rd_adv_buf30_out\,
      O => \n_0_brst_cnt[7]_i_4\
    );
\brst_cnt[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02FF02FF02FF0200"
    )
    port map (
      I0 => \^rd_adv_buf30_out\,
      I1 => end_brst_rd,
      I2 => brst_zero,
      I3 => Q(1),
      I4 => axi_rd_burst,
      I5 => I3,
      O => \n_0_brst_cnt[7]_i_5\
    );
\save_init_bram_addr_ld[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[10]\,
      I1 => s_axi_araddr(8),
      I2 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(8)
    );
\save_init_bram_addr_ld[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[11]\,
      I1 => s_axi_araddr(9),
      I2 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(9)
    );
\save_init_bram_addr_ld[12]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[12]\,
      I1 => s_axi_araddr(10),
      I2 => bram_addr_ld_en_mod1,
      O => \^o3\(0)
    );
\save_init_bram_addr_ld[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0808000088080000"
    )
    port map (
      I0 => curr_wrap_burst_reg,
      I1 => max_wrap_burst,
      I2 => I2,
      I3 => \n_0_save_init_bram_addr_ld[12]_i_5\,
      I4 => \^brst_cnt_dec\,
      I5 => narrow_bram_addr_inc_d1,
      O => bram_addr_ld_en_mod1
    );
\save_init_bram_addr_ld[12]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => I7,
      I1 => \n_0_save_init_bram_addr_ld[12]_i_6\,
      O => max_wrap_burst
    );
\save_init_bram_addr_ld[12]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => narrow_addr_int(0),
      I1 => narrow_addr_int(1),
      O => \n_0_save_init_bram_addr_ld[12]_i_5\
    );
\save_init_bram_addr_ld[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3030338000303300"
    )
    port map (
      I0 => I8,
      I1 => wrap_burst_total(2),
      I2 => I9,
      I3 => wrap_burst_total(0),
      I4 => wrap_burst_total(1),
      I5 => I10,
      O => \n_0_save_init_bram_addr_ld[12]_i_6\
    );
\save_init_bram_addr_ld[3]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0B0C0B0FFFF0000"
    )
    port map (
      I0 => wrap_burst_total(0),
      I1 => wrap_burst_total(2),
      I2 => \n_0_save_init_bram_addr_ld_reg[3]\,
      I3 => wrap_burst_total(1),
      I4 => s_axi_araddr(1),
      I5 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(1)
    );
\save_init_bram_addr_ld[4]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BD00BD00FFFF0000"
    )
    port map (
      I0 => wrap_burst_total(2),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(1),
      I3 => \n_0_save_init_bram_addr_ld_reg[4]\,
      I4 => s_axi_araddr(2),
      I5 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(2)
    );
\save_init_bram_addr_ld[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FD00FD00FFFF0000"
    )
    port map (
      I0 => wrap_burst_total(2),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(1),
      I3 => \n_0_save_init_bram_addr_ld_reg[5]\,
      I4 => s_axi_araddr(3),
      I5 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(3)
    );
\save_init_bram_addr_ld[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[6]\,
      I1 => s_axi_araddr(4),
      I2 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(4)
    );
\save_init_bram_addr_ld[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[7]\,
      I1 => s_axi_araddr(5),
      I2 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(5)
    );
\save_init_bram_addr_ld[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[8]\,
      I1 => s_axi_araddr(6),
      I2 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(6)
    );
\save_init_bram_addr_ld[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_save_init_bram_addr_ld_reg[9]\,
      I1 => s_axi_araddr(7),
      I2 => bram_addr_ld_en_mod1,
      O => RdChnl_BRAM_Addr_Ld(7)
    );
\save_init_bram_addr_ld_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(8),
      Q => \n_0_save_init_bram_addr_ld_reg[10]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(9),
      Q => \n_0_save_init_bram_addr_ld_reg[11]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => \^o3\(0),
      Q => \n_0_save_init_bram_addr_ld_reg[12]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(1),
      Q => \n_0_save_init_bram_addr_ld_reg[3]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(2),
      Q => \n_0_save_init_bram_addr_ld_reg[4]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(3),
      Q => \n_0_save_init_bram_addr_ld_reg[5]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(4),
      Q => \n_0_save_init_bram_addr_ld_reg[6]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(5),
      Q => \n_0_save_init_bram_addr_ld_reg[7]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(6),
      Q => \n_0_save_init_bram_addr_ld_reg[8]\,
      R => \^sr\(0)
    );
\save_init_bram_addr_ld_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => RdChnl_BRAM_Addr_Ld(7),
      Q => \n_0_save_init_bram_addr_ld_reg[9]\,
      R => \^sr\(0)
    );
\wrap_burst_total[0]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arlen(0),
      I2 => \n_0_wrap_burst_total[0]_i_2__0\,
      O => wrap_burst_total_cmb(0)
    );
\wrap_burst_total[0]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08004610"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arlen(2),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(1),
      I4 => s_axi_arlen(3),
      O => \n_0_wrap_burst_total[0]_i_2__0\
    );
\wrap_burst_total[1]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(2),
      I3 => \n_0_wrap_burst_total[1]_i_2__0\,
      O => wrap_burst_total_cmb(1)
    );
\wrap_burst_total[1]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"03A8"
    )
    port map (
      I0 => s_axi_arlen(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arlen(3),
      I3 => s_axi_arsize(1),
      O => \n_0_wrap_burst_total[1]_i_2__0\
    );
\wrap_burst_total[2]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_wrap_burst_total[2]_i_2__0\,
      I1 => s_axi_arsize(2),
      O => wrap_burst_total_cmb(2)
    );
\wrap_burst_total[2]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000000000000000"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arlen(1),
      I3 => s_axi_arlen(0),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => \n_0_wrap_burst_total[2]_i_2__0\
    );
\wrap_burst_total_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => wrap_burst_total_cmb(0),
      Q => wrap_burst_total(0),
      R => \^sr\(0)
    );
\wrap_burst_total_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => wrap_burst_total_cmb(1),
      Q => wrap_burst_total(1),
      R => \^sr\(0)
    );
\wrap_burst_total_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I6,
      D => wrap_burst_total_cmb(2),
      Q => wrap_burst_total(2),
      R => \^sr\(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlwrap_brst_0 is
  port (
    D : out STD_LOGIC_VECTOR ( 9 downto 0 );
    p_3_in : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    I1 : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    curr_narrow_burst : in STD_LOGIC;
    bram_addr_inc : in STD_LOGIC;
    curr_wrap_burst_reg : in STD_LOGIC;
    I3 : in STD_LOGIC;
    wr_data_sng_sm_cs : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I37 : in STD_LOGIC;
    I38 : in STD_LOGIC;
    I39 : in STD_LOGIC;
    curr_fixed_burst_reg : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    I2 : in STD_LOGIC;
    O6 : in STD_LOGIC;
    narrow_addr_int : in STD_LOGIC_VECTOR ( 1 downto 0 );
    narrow_bram_addr_inc_d1 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_axi_bram_ctrlwrap_brst_0 : entity is "wrap_brst";
end ip_axi_bram_ctrlwrap_brst_0;

architecture STRUCTURE of ip_axi_bram_ctrlwrap_brst_0 is
  signal \^d\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \^o1\ : STD_LOGIC;
  signal \^o4\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC;
  signal bram_addr_ld_wrap : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal \n_0_save_init_bram_addr_ld[11]_i_4\ : STD_LOGIC;
  signal \n_0_wrap_burst_total[0]_i_2\ : STD_LOGIC;
  signal \n_0_wrap_burst_total[1]_i_2\ : STD_LOGIC;
  signal \n_0_wrap_burst_total[2]_i_3\ : STD_LOGIC;
  signal narrow_addr_dec : STD_LOGIC;
  signal p_22_in : STD_LOGIC;
  signal \^p_3_in\ : STD_LOGIC;
  signal save_init_bram_addr_ld : STD_LOGIC_VECTOR ( 12 downto 3 );
  signal wrap_burst_total : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal wrap_burst_total_cmb : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[12]_i_2__0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[3]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \save_init_bram_addr_ld[5]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \wrap_burst_total[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \wrap_burst_total[0]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \wrap_burst_total[1]_i_2\ : label is "soft_lutpair1";
begin
  D(9 downto 0) <= \^d\(9 downto 0);
  O1 <= \^o1\;
  O4 <= \^o4\;
  O5 <= \^o5\;
  p_3_in <= \^p_3_in\;
\ADDR_SNG_PORT.bram_addr_int[12]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0010FFFF"
    )
    port map (
      I0 => \^p_3_in\,
      I1 => O6,
      I2 => wr_data_sng_sm_cs(0),
      I3 => wr_data_sng_sm_cs(1),
      I4 => s_axi_aresetn,
      O => \^o5\
    );
\ADDR_SNG_PORT.bram_addr_int[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F4F4F4444444"
    )
    port map (
      I0 => I1,
      I1 => p_1_out,
      I2 => p_22_in,
      I3 => \^o1\,
      I4 => curr_narrow_burst,
      I5 => bram_addr_inc,
      O => \^p_3_in\
    );
\curr_fixed_burst_reg_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"030003000000AA00"
    )
    port map (
      I0 => curr_fixed_burst_reg,
      I1 => s_axi_awburst(1),
      I2 => s_axi_awburst(0),
      I3 => s_axi_aresetn,
      I4 => \^o5\,
      I5 => I2,
      O => O2
    );
curr_wrap_burst_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"300030000000AA00"
    )
    port map (
      I0 => curr_wrap_burst_reg,
      I1 => s_axi_awburst(0),
      I2 => s_axi_awburst(1),
      I3 => s_axi_aresetn,
      I4 => \^o5\,
      I5 => I2,
      O => O3
    );
\save_init_bram_addr_ld[10]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => save_init_bram_addr_ld(10),
      I1 => s_axi_awaddr(7),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(7)
    );
\save_init_bram_addr_ld[11]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => save_init_bram_addr_ld(11),
      I1 => s_axi_awaddr(8),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(8)
    );
\save_init_bram_addr_ld[11]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A000000"
    )
    port map (
      I0 => curr_wrap_burst_reg,
      I1 => \^o1\,
      I2 => curr_narrow_burst,
      I3 => I3,
      I4 => \n_0_save_init_bram_addr_ld[11]_i_4\,
      O => p_22_in
    );
\save_init_bram_addr_ld[11]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => narrow_addr_int(0),
      I1 => narrow_addr_int(1),
      I2 => narrow_addr_dec,
      I3 => narrow_bram_addr_inc_d1,
      O => \^o1\
    );
\save_init_bram_addr_ld[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3030338000303300"
    )
    port map (
      I0 => I37,
      I1 => wrap_burst_total(2),
      I2 => I38,
      I3 => wrap_burst_total(0),
      I4 => wrap_burst_total(1),
      I5 => I39,
      O => \n_0_save_init_bram_addr_ld[11]_i_4\
    );
\save_init_bram_addr_ld[11]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => wr_data_sng_sm_cs(1),
      I1 => s_axi_wvalid,
      I2 => wr_data_sng_sm_cs(0),
      I3 => curr_narrow_burst,
      O => narrow_addr_dec
    );
\save_init_bram_addr_ld[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => save_init_bram_addr_ld(12),
      I1 => s_axi_awaddr(9),
      I2 => \^o4\,
      O => \^d\(9)
    );
\save_init_bram_addr_ld[12]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => p_22_in,
      I1 => I1,
      I2 => p_1_out,
      O => \^o4\
    );
\save_init_bram_addr_ld[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => bram_addr_ld_wrap(3),
      I1 => s_axi_awaddr(0),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(0)
    );
\save_init_bram_addr_ld[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C0B0"
    )
    port map (
      I0 => wrap_burst_total(0),
      I1 => wrap_burst_total(2),
      I2 => save_init_bram_addr_ld(3),
      I3 => wrap_burst_total(1),
      O => bram_addr_ld_wrap(3)
    );
\save_init_bram_addr_ld[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => bram_addr_ld_wrap(4),
      I1 => s_axi_awaddr(1),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(1)
    );
\save_init_bram_addr_ld[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BD00"
    )
    port map (
      I0 => wrap_burst_total(2),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(1),
      I3 => save_init_bram_addr_ld(4),
      O => bram_addr_ld_wrap(4)
    );
\save_init_bram_addr_ld[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => bram_addr_ld_wrap(5),
      I1 => s_axi_awaddr(2),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(2)
    );
\save_init_bram_addr_ld[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD00"
    )
    port map (
      I0 => wrap_burst_total(2),
      I1 => wrap_burst_total(0),
      I2 => wrap_burst_total(1),
      I3 => save_init_bram_addr_ld(5),
      O => bram_addr_ld_wrap(5)
    );
\save_init_bram_addr_ld[6]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => save_init_bram_addr_ld(6),
      I1 => s_axi_awaddr(3),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(3)
    );
\save_init_bram_addr_ld[7]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => save_init_bram_addr_ld(7),
      I1 => s_axi_awaddr(4),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(4)
    );
\save_init_bram_addr_ld[8]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => save_init_bram_addr_ld(8),
      I1 => s_axi_awaddr(5),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(5)
    );
\save_init_bram_addr_ld[9]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ACCCACAC"
    )
    port map (
      I0 => save_init_bram_addr_ld(9),
      I1 => s_axi_awaddr(6),
      I2 => p_22_in,
      I3 => I1,
      I4 => p_1_out,
      O => \^d\(6)
    );
\save_init_bram_addr_ld_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(7),
      Q => save_init_bram_addr_ld(10),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(8),
      Q => save_init_bram_addr_ld(11),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(9),
      Q => save_init_bram_addr_ld(12),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(0),
      Q => save_init_bram_addr_ld(3),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(1),
      Q => save_init_bram_addr_ld(4),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(2),
      Q => save_init_bram_addr_ld(5),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(3),
      Q => save_init_bram_addr_ld(6),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(4),
      Q => save_init_bram_addr_ld(7),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(5),
      Q => save_init_bram_addr_ld(8),
      R => SR(0)
    );
\save_init_bram_addr_ld_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \^d\(6),
      Q => save_init_bram_addr_ld(9),
      R => SR(0)
    );
\wrap_burst_total[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awlen(0),
      I2 => \n_0_wrap_burst_total[0]_i_2\,
      O => wrap_burst_total_cmb(0)
    );
\wrap_burst_total[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08004610"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awlen(2),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(1),
      I4 => s_axi_awlen(3),
      O => \n_0_wrap_burst_total[0]_i_2\
    );
\wrap_burst_total[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(2),
      I3 => \n_0_wrap_burst_total[1]_i_2\,
      O => wrap_burst_total_cmb(1)
    );
\wrap_burst_total[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"03A8"
    )
    port map (
      I0 => s_axi_awlen(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awlen(3),
      I3 => s_axi_awsize(1),
      O => \n_0_wrap_burst_total[1]_i_2\
    );
\wrap_burst_total[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_wrap_burst_total[2]_i_3\,
      I1 => s_axi_awsize(2),
      O => wrap_burst_total_cmb(2)
    );
\wrap_burst_total[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000000000000000"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awlen(2),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(3),
      I4 => s_axi_awlen(0),
      I5 => s_axi_awlen(1),
      O => \n_0_wrap_burst_total[2]_i_3\
    );
\wrap_burst_total_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => wrap_burst_total_cmb(0),
      Q => wrap_burst_total(0),
      R => SR(0)
    );
\wrap_burst_total_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => wrap_burst_total_cmb(1),
      Q => wrap_burst_total(1),
      R => SR(0)
    );
\wrap_burst_total_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => wrap_burst_total_cmb(2),
      Q => wrap_burst_total(2),
      R => SR(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlrd_chnl is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ar_active_d1 : out STD_LOGIC;
    curr_narrow_burst : out STD_LOGIC;
    O1 : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_7_in : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O4 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    O10 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    O12 : out STD_LOGIC;
    O13 : out STD_LOGIC;
    O14 : out STD_LOGIC;
    O15 : out STD_LOGIC;
    O16 : out STD_LOGIC;
    O17 : out STD_LOGIC;
    O18 : out STD_LOGIC;
    O19 : out STD_LOGIC;
    axi_rd_burst1 : out STD_LOGIC;
    AR2Arb_Active_Clr : out STD_LOGIC;
    curr_narrow_burst_cmb : out STD_LOGIC;
    curr_ua_narrow_wrap4 : out STD_LOGIC;
    O20 : out STD_LOGIC;
    O21 : out STD_LOGIC;
    O22 : out STD_LOGIC;
    O23 : out STD_LOGIC;
    O24 : out STD_LOGIC;
    O25 : out STD_LOGIC;
    O26 : out STD_LOGIC;
    O27 : out STD_LOGIC;
    O28 : out STD_LOGIC;
    O29 : out STD_LOGIC;
    O30 : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    p_0_out : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I4 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 0 to 0 );
    I5 : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    I6 : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I36 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I37 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I38 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I39 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I40 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I41 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I42 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I43 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I44 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I45 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I46 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I47 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I48 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I49 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I50 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I51 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I52 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I53 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I54 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I55 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I56 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I57 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I58 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I59 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I60 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I61 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I62 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I63 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I64 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I65 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I66 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I67 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    I10 : in STD_LOGIC;
    I69 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I11 : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    I71 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I79 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I80 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I81 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I82 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I83 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I84 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I85 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I87 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I12 : in STD_LOGIC;
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end ip_axi_bram_ctrlrd_chnl;

architecture STRUCTURE of ip_axi_bram_ctrlrd_chnl is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW/bytes_per_addr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GEN_UA_NARROW.I_UA_NARROW/curr_axlen_unsigned_lshift025_in\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^o1\ : STD_LOGIC;
  signal \^o19\ : STD_LOGIC;
  signal \^o4\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal act_rd_burst : STD_LOGIC;
  signal act_rd_burst_set : STD_LOGIC;
  signal act_rd_burst_two : STD_LOGIC;
  signal \^ar_active_d1\ : STD_LOGIC;
  signal axi_rd_burst : STD_LOGIC;
  signal \^axi_rd_burst1\ : STD_LOGIC;
  signal axi_rd_burst126_in : STD_LOGIC;
  signal axi_rd_burst_two : STD_LOGIC;
  signal axi_rdata_en : STD_LOGIC;
  signal axi_rid_temp : STD_LOGIC;
  signal axi_rlast_set : STD_LOGIC;
  signal axi_rvalid_clr_ok : STD_LOGIC;
  signal axi_rvalid_clr_ok0 : STD_LOGIC;
  signal axi_rvalid_set : STD_LOGIC;
  signal axi_rvalid_set_cmb : STD_LOGIC;
  signal bram_addr_inc1 : STD_LOGIC;
  signal bram_addr_inc17_out : STD_LOGIC;
  signal bram_en_cmb : STD_LOGIC;
  signal brst_cnt_dec : STD_LOGIC;
  signal brst_cnt_max5_out : STD_LOGIC;
  signal brst_cnt_max_d1 : STD_LOGIC;
  signal brst_one : STD_LOGIC;
  signal brst_one0 : STD_LOGIC;
  signal brst_zero : STD_LOGIC;
  signal curr_fixed_burst : STD_LOGIC;
  signal \^curr_narrow_burst\ : STD_LOGIC;
  signal curr_wrap_burst_reg : STD_LOGIC;
  signal disable_b2b_brst : STD_LOGIC;
  signal disable_b2b_brst_cmb : STD_LOGIC;
  signal end_brst_rd : STD_LOGIC;
  signal end_brst_rd_clr : STD_LOGIC;
  signal last_bram_addr : STD_LOGIC;
  signal last_bram_addr0 : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[1]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[2]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[3]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[3]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs[4]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs_reg[0]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs_reg[1]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs_reg[2]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs_reg[3]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_rlast_sm_cs_reg[4]\ : STD_LOGIC;
  signal \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1\ : STD_LOGIC;
  signal \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_3__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_4__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_8__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_9__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_100__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_101\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_102__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_103__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_104\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_105__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_106\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_107__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_108\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_109__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_110\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_111__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_112\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_113__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_114\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_115__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_116\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_117__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_11__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_12__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_136\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_137__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_138\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_139__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_13__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_140\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_141__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_142\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_143\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_14__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_156\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_15__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_16\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_163__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_164\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_165__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_166\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_1__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_24__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_25__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_26__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_27__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_28\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_32\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_33__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_34\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_35__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_36\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_37__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_38\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_39__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_3__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_40\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_41__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_42\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_43\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_45__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_46\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_47__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_48__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_49__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_50__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_51\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_53\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_55__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_56\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_59__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_5__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_60__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_61__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_62__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_63\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_64__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_65\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_66__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_67\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_68__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_69\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_70__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_71\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_72__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_73\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_74__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_75\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_76__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_77\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_78\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_85\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_86__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_87__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_88__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_89__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_90__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_91__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_92__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_93\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_94__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_95__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_96__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_97\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_98__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_99__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_52\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_EN.curr_narrow_burst_i_1__0\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_3\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RID_SNG.axi_rid_int[0]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_RID_SNG.axi_rid_int[0]_i_2\ : STD_LOGIC;
  signal n_0_act_rd_burst_i_1 : STD_LOGIC;
  signal n_0_act_rd_burst_two_i_1 : STD_LOGIC;
  signal n_0_act_rd_burst_two_i_3 : STD_LOGIC;
  signal n_0_act_rd_burst_two_i_4 : STD_LOGIC;
  signal n_0_act_rd_burst_two_i_5 : STD_LOGIC;
  signal n_0_act_rd_burst_two_reg : STD_LOGIC;
  signal n_0_axi_rd_burst_i_1 : STD_LOGIC;
  signal n_0_axi_rd_burst_i_4 : STD_LOGIC;
  signal n_0_axi_rd_burst_i_5 : STD_LOGIC;
  signal n_0_axi_rd_burst_two_i_1 : STD_LOGIC;
  signal n_0_axi_rd_burst_two_i_3 : STD_LOGIC;
  signal n_0_axi_rd_burst_two_reg : STD_LOGIC;
  signal n_0_axi_rlast_int_i_1 : STD_LOGIC;
  signal n_0_axi_rvalid_clr_ok_i_1 : STD_LOGIC;
  signal n_0_axi_rvalid_clr_ok_i_3 : STD_LOGIC;
  signal n_0_axi_rvalid_int_i_1 : STD_LOGIC;
  signal n_0_bram_en_int_i_1 : STD_LOGIC;
  signal n_0_bram_en_int_i_10 : STD_LOGIC;
  signal n_0_bram_en_int_i_2 : STD_LOGIC;
  signal n_0_bram_en_int_i_5 : STD_LOGIC;
  signal n_0_bram_en_int_i_6 : STD_LOGIC;
  signal n_0_bram_en_int_i_7 : STD_LOGIC;
  signal n_0_bram_en_int_i_8 : STD_LOGIC;
  signal n_0_bram_en_int_reg_i_3 : STD_LOGIC;
  signal \n_0_brst_cnt[0]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[1]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[2]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[2]_i_2\ : STD_LOGIC;
  signal \n_0_brst_cnt[3]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[3]_i_2\ : STD_LOGIC;
  signal \n_0_brst_cnt[4]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[4]_i_2\ : STD_LOGIC;
  signal \n_0_brst_cnt[5]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[5]_i_2\ : STD_LOGIC;
  signal \n_0_brst_cnt[6]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[6]_i_2\ : STD_LOGIC;
  signal \n_0_brst_cnt[7]_i_1\ : STD_LOGIC;
  signal \n_0_brst_cnt[7]_i_3\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[0]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[1]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[2]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[3]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[4]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[5]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[6]\ : STD_LOGIC;
  signal \n_0_brst_cnt_reg[7]\ : STD_LOGIC;
  signal n_0_brst_one_i_1 : STD_LOGIC;
  signal n_0_brst_one_i_3 : STD_LOGIC;
  signal n_0_brst_one_i_4 : STD_LOGIC;
  signal n_0_brst_one_i_5 : STD_LOGIC;
  signal n_0_brst_one_i_6 : STD_LOGIC;
  signal n_0_brst_zero_i_1 : STD_LOGIC;
  signal n_0_brst_zero_i_2 : STD_LOGIC;
  signal n_0_brst_zero_i_4 : STD_LOGIC;
  signal n_0_curr_fixed_burst_reg_reg : STD_LOGIC;
  signal \n_0_curr_wrap_burst_reg_i_1__0\ : STD_LOGIC;
  signal n_0_disable_b2b_brst_i_2 : STD_LOGIC;
  signal n_0_disable_b2b_brst_i_3 : STD_LOGIC;
  signal n_0_disable_b2b_brst_i_4 : STD_LOGIC;
  signal n_0_end_brst_rd_clr_i_1 : STD_LOGIC;
  signal n_0_end_brst_rd_clr_i_2 : STD_LOGIC;
  signal n_0_end_brst_rd_i_1 : STD_LOGIC;
  signal n_0_last_bram_addr_i_2 : STD_LOGIC;
  signal n_0_last_bram_addr_i_3 : STD_LOGIC;
  signal n_0_last_bram_addr_i_5 : STD_LOGIC;
  signal n_0_pend_rd_op_i_1 : STD_LOGIC;
  signal n_0_pend_rd_op_i_2 : STD_LOGIC;
  signal n_0_pend_rd_op_i_3 : STD_LOGIC;
  signal n_0_pend_rd_op_i_5 : STD_LOGIC;
  signal n_0_pend_rd_op_i_6 : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[0]_i_2\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[0]_i_3\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[1]_i_2\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[1]_i_3\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[2]_i_2\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[2]_i_3\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[3]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[3]_i_3\ : STD_LOGIC;
  signal \n_0_rd_data_sm_cs[3]_i_4\ : STD_LOGIC;
  signal n_0_rddata_mux_sel_i_1 : STD_LOGIC;
  signal n_0_rddata_mux_sel_i_2 : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\ : STD_LOGIC;
  signal narrow_addr_int : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal narrow_addr_ld_en : STD_LOGIC;
  signal narrow_bram_addr_inc : STD_LOGIC;
  signal narrow_bram_addr_inc_d1 : STD_LOGIC;
  signal narrow_burst_cnt_ld_mod : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal narrow_burst_cnt_ld_reg : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^p_7_in\ : STD_LOGIC;
  signal pend_rd_op : STD_LOGIC;
  signal pend_rd_op_cmb : STD_LOGIC;
  signal rd_adv_buf30_out : STD_LOGIC;
  signal rd_data_sm_cs : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_data_sm_ns : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rd_data_sm_ns1 : STD_LOGIC;
  signal rd_skid_buf : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal rd_skid_buf_ld : STD_LOGIC;
  signal rd_skid_buf_ld_cmb : STD_LOGIC;
  signal rd_skid_buf_ld_reg : STD_LOGIC;
  signal rddata_mux_sel : STD_LOGIC;
  signal rddata_mux_sel_cmb : STD_LOGIC;
  signal \^s_axi_rid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal set_last_bram_addr7_in : STD_LOGIC;
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[10]_i_2\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[11]_i_2\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[2]_i_2\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[3]_i_2\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[4]_i_2\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[5]_i_2\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[7]_i_2\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[8]_i_2\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[9]_i_2\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \FSM_onehot_rlast_sm_cs[0]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \FSM_onehot_rlast_sm_cs[2]_i_2\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \FSM_onehot_rlast_sm_cs[4]_i_3\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[0]_i_7__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_15__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_16\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_18\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_33__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_35__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_48__0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_51\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_57\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_1__0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1__0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1__0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \GEN_NARROW_EN.curr_narrow_burst_i_3__0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_3\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \GEN_RID_SNG.axi_rid_int[0]_i_2\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of act_rd_burst_two_i_4 : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of axi_rd_burst_i_2 : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of axi_rd_burst_two_i_2 : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of axi_rlast_int_i_1 : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of axi_rvalid_clr_ok_i_3 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of axi_rvalid_set_i_1 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of bram_en_int_i_10 : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of bram_en_int_i_9 : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \brst_cnt[2]_i_2\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \brst_cnt[3]_i_2\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \brst_cnt[4]_i_2\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \brst_cnt[5]_i_2\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of brst_one_i_2 : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of brst_zero_i_1 : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of brst_zero_i_2 : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of curr_fixed_burst_reg_i_1 : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \curr_wrap_burst_reg_i_1__0\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of pend_rd_op_i_6 : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[1]_i_2\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[2]_i_2\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rd_data_sm_cs[3]_i_5\ : label is "soft_lutpair61";
begin
  O1 <= \^o1\;
  O19 <= \^o19\;
  O4(2 downto 0) <= \^o4\(2 downto 0);
  SR(0) <= \^sr\(0);
  ar_active_d1 <= \^ar_active_d1\;
  axi_rd_burst1 <= \^axi_rd_burst1\;
  curr_narrow_burst <= \^curr_narrow_burst\;
  p_7_in <= \^p_7_in\;
  s_axi_rid(0) <= \^s_axi_rid\(0);
\ADDR_SNG_PORT.bram_addr_int[10]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O10
    );
\ADDR_SNG_PORT.bram_addr_int[11]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O9
    );
\ADDR_SNG_PORT.bram_addr_int[11]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000002222222A"
    )
    port map (
      I0 => brst_cnt_dec,
      I1 => \^curr_narrow_burst\,
      I2 => narrow_bram_addr_inc_d1,
      I3 => narrow_addr_int(1),
      I4 => narrow_addr_int(0),
      I5 => n_0_curr_fixed_burst_reg_reg,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\
    );
\ADDR_SNG_PORT.bram_addr_int[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O18
    );
\ADDR_SNG_PORT.bram_addr_int[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O17
    );
\ADDR_SNG_PORT.bram_addr_int[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O16
    );
\ADDR_SNG_PORT.bram_addr_int[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O15
    );
\ADDR_SNG_PORT.bram_addr_int[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O14
    );
\ADDR_SNG_PORT.bram_addr_int[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O13
    );
\ADDR_SNG_PORT.bram_addr_int[8]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O12
    );
\ADDR_SNG_PORT.bram_addr_int[9]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"47"
    )
    port map (
      I0 => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_5\,
      I1 => p_0_out,
      I2 => I6,
      O => O11
    );
\FSM_onehot_rlast_sm_cs[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000006"
    )
    port map (
      I0 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      I3 => \n_0_FSM_onehot_rlast_sm_cs_reg[0]\,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      O => \n_0_FSM_onehot_rlast_sm_cs[0]_i_1\
    );
\FSM_onehot_rlast_sm_cs[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00EAEAEA00000000"
    )
    port map (
      I0 => n_0_axi_rd_burst_two_reg,
      I1 => axi_rd_burst,
      I2 => n_0_act_rd_burst_two_reg,
      I3 => \^o19\,
      I4 => s_axi_rready,
      I5 => \n_0_FSM_onehot_rlast_sm_cs[1]_i_2\,
      O => \n_0_FSM_onehot_rlast_sm_cs[1]_i_1\
    );
\FSM_onehot_rlast_sm_cs[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
    port map (
      I0 => \n_0_FSM_onehot_rlast_sm_cs_reg[0]\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I3 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      O => \n_0_FSM_onehot_rlast_sm_cs[1]_i_2\
    );
\FSM_onehot_rlast_sm_cs[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0004040400000000"
    )
    port map (
      I0 => n_0_axi_rd_burst_two_reg,
      I1 => axi_rd_burst,
      I2 => n_0_act_rd_burst_two_reg,
      I3 => \^o19\,
      I4 => s_axi_rready,
      I5 => \n_0_FSM_onehot_rlast_sm_cs[2]_i_2\,
      O => \n_0_FSM_onehot_rlast_sm_cs[2]_i_1\
    );
\FSM_onehot_rlast_sm_cs[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
    port map (
      I0 => \n_0_FSM_onehot_rlast_sm_cs_reg[0]\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I3 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      O => \n_0_FSM_onehot_rlast_sm_cs[2]_i_2\
    );
\FSM_onehot_rlast_sm_cs[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      I0 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I3 => \n_0_FSM_onehot_rlast_sm_cs[3]_i_2\,
      O => \n_0_FSM_onehot_rlast_sm_cs[3]_i_1\
    );
\FSM_onehot_rlast_sm_cs[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF88800000"
    )
    port map (
      I0 => s_axi_rready,
      I1 => \^o19\,
      I2 => n_0_axi_rd_burst_two_reg,
      I3 => axi_rd_burst,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[0]\,
      I5 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      O => \n_0_FSM_onehot_rlast_sm_cs[3]_i_2\
    );
\FSM_onehot_rlast_sm_cs[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFEF0F0E1E0"
    )
    port map (
      I0 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I3 => last_bram_addr,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      I5 => rd_adv_buf30_out,
      O => \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\
    );
\FSM_onehot_rlast_sm_cs[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001010000000100"
    )
    port map (
      I0 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I3 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[0]\,
      I5 => axi_rd_burst_two,
      O => \n_0_FSM_onehot_rlast_sm_cs[4]_i_2\
    );
\FSM_onehot_rlast_sm_cs[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_axi_rd_burst_two_reg,
      I1 => axi_rd_burst,
      O => axi_rd_burst_two
    );
\FSM_onehot_rlast_sm_cs_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_axi_aclk,
      CE => \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\,
      D => \n_0_FSM_onehot_rlast_sm_cs[0]_i_1\,
      Q => \n_0_FSM_onehot_rlast_sm_cs_reg[0]\,
      S => \^sr\(0)
    );
\FSM_onehot_rlast_sm_cs_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\,
      D => \n_0_FSM_onehot_rlast_sm_cs[1]_i_1\,
      Q => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      R => \^sr\(0)
    );
\FSM_onehot_rlast_sm_cs_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\,
      D => \n_0_FSM_onehot_rlast_sm_cs[2]_i_1\,
      Q => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      R => \^sr\(0)
    );
\FSM_onehot_rlast_sm_cs_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\,
      D => \n_0_FSM_onehot_rlast_sm_cs[3]_i_1\,
      Q => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      R => \^sr\(0)
    );
\FSM_onehot_rlast_sm_cs_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \n_0_FSM_onehot_rlast_sm_cs[4]_i_1\,
      D => \n_0_FSM_onehot_rlast_sm_cs[4]_i_2\,
      Q => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      R => \^sr\(0)
    );
\GEN_AR_SNG.ar_active_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => I2,
      Q => \^ar_active_d1\,
      R => \<const0>\
    );
\GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E0EE0000"
    )
    port map (
      I0 => \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\,
      I1 => brst_cnt_max5_out,
      I2 => \^ar_active_d1\,
      I3 => p_0_out,
      I4 => s_axi_aresetn,
      I5 => end_brst_rd_clr,
      O => \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1\
    );
\GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20220000"
    )
    port map (
      I0 => p_0_out,
      I1 => pend_rd_op,
      I2 => narrow_bram_addr_inc,
      I3 => \^curr_narrow_burst\,
      I4 => brst_zero,
      O => brst_cnt_max5_out
    );
\GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_i_1\,
      Q => \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\,
      R => \<const0>\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_12__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCC3C6"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_araddr(1),
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(1),
      O => \^o4\(1)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_13__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(0),
      O => \^o4\(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A8080808A808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => narrow_addr_int(0),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0\,
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_3__0\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\,
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_4__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_1__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => narrow_addr_ld_en,
      I1 => \^curr_narrow_burst\,
      I2 => brst_cnt_dec,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_2__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_3__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"202F"
    )
    port map (
      I0 => narrow_burst_cnt_ld_mod(0),
      I1 => p_5_out,
      I2 => narrow_addr_ld_en,
      I3 => narrow_addr_int(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_3__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6F6000006F60FFFF"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/bytes_per_addr\(0),
      I2 => p_5_out,
      I3 => narrow_burst_cnt_ld_mod(0),
      I4 => narrow_addr_ld_en,
      I5 => narrow_addr_int(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_4__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_5__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF1F0010"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => p_0_out,
      I3 => \^ar_active_d1\,
      I4 => narrow_burst_cnt_ld_reg(0),
      O => narrow_burst_cnt_ld_mod(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_7__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \GEN_UA_NARROW.I_UA_NARROW/bytes_per_addr\(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_8__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I3(0),
      I1 => I4(0),
      I2 => s_axi_arsize(1),
      I3 => \^o4\(1),
      I4 => s_axi_arsize(0),
      I5 => \^o4\(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_8__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_9__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I36(0),
      I1 => I37(0),
      I2 => s_axi_arsize(1),
      I3 => I38(0),
      I4 => s_axi_arsize(0),
      I5 => I39(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_9__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_100__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_136\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_137__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_138\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_139__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_100__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_101\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_140\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_141__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_142\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_143\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_101\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_102__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11111114"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(3),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(2),
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_102__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_103__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11111421"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_103__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_104\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I54(1),
      I1 => I55(0),
      I2 => s_axi_arsize(1),
      I3 => I52(3),
      I4 => s_axi_arsize(0),
      I5 => I53(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_104\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_105__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I81(0),
      I2 => s_axi_arsize(0),
      I3 => I80(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_105__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_106\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I54(2),
      I1 => I55(1),
      I2 => s_axi_arsize(1),
      I3 => I56(0),
      I4 => s_axi_arsize(0),
      I5 => I53(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_106\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_107__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I81(1),
      I2 => s_axi_arsize(0),
      I3 => I80(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_107__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_108\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I50(3),
      I1 => I51(2),
      I2 => s_axi_arsize(1),
      I3 => I52(1),
      I4 => s_axi_arsize(0),
      I5 => I53(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_108\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_109__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I79(2),
      I2 => s_axi_arsize(0),
      I3 => I49(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_109__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_10__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_28\,
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(1),
      I3 => I66(3),
      I4 => s_axi_arsize(0),
      I5 => I67(3),
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(31)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_110\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I54(0),
      I1 => I51(3),
      I2 => s_axi_arsize(1),
      I3 => I52(2),
      I4 => s_axi_arsize(0),
      I5 => I53(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_110\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_111__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I79(3),
      I2 => s_axi_arsize(0),
      I3 => I80(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_111__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_112\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I50(1),
      I1 => I51(0),
      I2 => s_axi_arsize(1),
      I3 => I46(3),
      I4 => s_axi_arsize(0),
      I5 => I47(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_112\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_113__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I79(0),
      I2 => s_axi_arsize(0),
      I3 => I49(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_113__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_114\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I50(2),
      I1 => I51(1),
      I2 => s_axi_arsize(1),
      I3 => I52(0),
      I4 => s_axi_arsize(0),
      I5 => I47(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_114\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_115__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I79(1),
      I2 => s_axi_arsize(0),
      I3 => I49(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_115__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_116\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I44(3),
      I1 => I45(2),
      I2 => s_axi_arsize(1),
      I3 => I46(1),
      I4 => s_axi_arsize(0),
      I5 => I47(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_116\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_117__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
    port map (
      I0 => I69(3),
      I1 => I48(2),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_117__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_118\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_156\,
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(1),
      I3 => I48(3),
      I4 => s_axi_arsize(0),
      I5 => I49(0),
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(9)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_11__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(30),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(31),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_11__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_12__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_32\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_33__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_34\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_35__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_12__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_132\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000FC8"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_araddr(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arsize(2),
      O => \^o4\(2)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_136\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I44(1),
      I1 => I45(0),
      I2 => s_axi_arsize(1),
      I3 => I42(3),
      I4 => s_axi_arsize(0),
      I5 => I43(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_136\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_137__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => I69(1),
      I3 => I48(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_137__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_138\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I44(2),
      I1 => I45(1),
      I2 => s_axi_arsize(1),
      I3 => I46(0),
      I4 => s_axi_arsize(0),
      I5 => I43(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_138\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_139__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => I69(2),
      I3 => I48(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_139__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_13__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_36\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_37__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_38\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_39__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_13__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_140\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I40(3),
      I1 => I41(2),
      I2 => s_axi_arsize(1),
      I3 => I42(1),
      I4 => s_axi_arsize(0),
      I5 => I43(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_140\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_141__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FA72D850"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => I71(3),
      I4 => I87(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_141__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_142\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I44(0),
      I1 => I41(3),
      I2 => s_axi_arsize(1),
      I3 => I42(2),
      I4 => s_axi_arsize(0),
      I5 => I43(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_142\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_143\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C480"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => I69(0),
      I3 => I87(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_143\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_14__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_40\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_41__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_42\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_43\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_14__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_156\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I50(0),
      I1 => I45(3),
      I2 => s_axi_arsize(1),
      I3 => I46(2),
      I4 => s_axi_arsize(0),
      I5 => I47(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_156\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_15__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"666669C6"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_15__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00FD0000"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => \^ar_active_d1\,
      I4 => p_0_out,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_16\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_163__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => I71(2),
      I3 => I87(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_163__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_164\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I40(2),
      I1 => I41(1),
      I2 => s_axi_arsize(1),
      I3 => I42(0),
      I4 => s_axi_arsize(0),
      I5 => I39(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_164\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_165__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B391A280"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => I71(1),
      I3 => I87(0),
      I4 => \^o4\(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_165__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_166\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I40(1),
      I1 => I41(0),
      I2 => s_axi_arsize(1),
      I3 => I38(2),
      I4 => s_axi_arsize(0),
      I5 => I39(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_166\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_17__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFE680"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_45__0\,
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_46\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_47__0\,
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_48__0\,
      O => O22
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_18\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3E02FFFF"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_49__0\,
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(1),
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_50__0\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_51\,
      O => O21
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_19__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0A0E0E0E"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_52\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_53\,
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(1),
      O => O24
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A8080808A808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => narrow_addr_int(1),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0\,
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_3__0\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\,
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_5__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_1__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_20__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFFEFEFEAAAEAEAE"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/curr_axlen_unsigned_lshift025_in\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_55__0\,
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(1),
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_56\,
      O => O20
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_24__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_63\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_64__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_65\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_66__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_24__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_25__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_67\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_68__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_69\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_70__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_25__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_26__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_71\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_72__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_73\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_74__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_26__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_27__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_75\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_76__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_77\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_78\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_27__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(3),
      I4 => s_axi_arsize(0),
      I5 => I65(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_28\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => narrow_addr_ld_en,
      I1 => \^curr_narrow_burst\,
      I2 => brst_cnt_dec,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_2__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_31__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_85\,
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(1),
      I3 => I66(3),
      I4 => s_axi_arsize(0),
      I5 => I67(3),
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(30)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_32\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(3),
      I4 => s_axi_arsize(0),
      I5 => I65(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_32\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_33__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I66(2),
      I2 => s_axi_arsize(0),
      I3 => I67(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_33__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_34\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(3),
      I4 => s_axi_arsize(0),
      I5 => I65(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_34\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_35__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I66(3),
      I2 => s_axi_arsize(0),
      I3 => I67(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_35__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_36\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(3),
      I4 => s_axi_arsize(0),
      I5 => I65(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_36\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_37__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I66(0),
      I2 => s_axi_arsize(0),
      I3 => I67(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_37__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_38\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(3),
      I4 => s_axi_arsize(0),
      I5 => I65(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_38\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_39__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I66(1),
      I2 => s_axi_arsize(0),
      I3 => I67(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_39__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2F20202F"
    )
    port map (
      I0 => narrow_burst_cnt_ld_mod(1),
      I1 => p_5_out,
      I2 => narrow_addr_ld_en,
      I3 => narrow_addr_int(0),
      I4 => narrow_addr_int(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_3__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_40\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(2),
      I2 => s_axi_arsize(1),
      I3 => I64(1),
      I4 => s_axi_arsize(0),
      I5 => I65(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_40\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_41__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I85(2),
      I2 => s_axi_arsize(0),
      I3 => I84(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_41__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_42\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(2),
      I4 => s_axi_arsize(0),
      I5 => I65(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_42\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_43\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I85(3),
      I2 => s_axi_arsize(0),
      I3 => I67(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_43\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_45__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(2),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_45__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_46\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(6),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_46\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_47__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACACAA0"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_88__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_89__0\,
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_47__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_48__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CAA0A0A0"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_90__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_91__0\,
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_48__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_49__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(6),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_49__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_50__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(2),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_50__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_51\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FD54FD57"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_92__0\,
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_93\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_51\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_53\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(2),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_53\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_55__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(6),
      I5 => s_axi_arlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_55__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_56\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(2),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_56\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_57\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => curr_ua_narrow_wrap4
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_59__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_104\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_105__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_106\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_107__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_59__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8FFB800B800B8FF"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_15__0\,
      I1 => p_5_out,
      I2 => narrow_burst_cnt_ld_mod(1),
      I3 => narrow_addr_ld_en,
      I4 => narrow_addr_int(0),
      I5 => narrow_addr_int(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_5__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_60__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_108\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_109__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_110\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_111__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_60__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_61__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_112\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_113__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_114\,
      I3 => s_axi_arsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_115__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_61__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_62__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0047"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_116\,
      I1 => s_axi_arsize(2),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_117__0\,
      I3 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(9),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_62__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_63\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(1),
      I1 => I63(0),
      I2 => s_axi_arsize(1),
      I3 => I60(3),
      I4 => s_axi_arsize(0),
      I5 => I61(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_63\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_64__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I85(0),
      I2 => s_axi_arsize(0),
      I3 => I84(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_64__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_65\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(2),
      I1 => I63(1),
      I2 => s_axi_arsize(1),
      I3 => I64(0),
      I4 => s_axi_arsize(0),
      I5 => I61(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_65\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_66__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I85(1),
      I2 => s_axi_arsize(0),
      I3 => I84(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_66__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_67\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I58(3),
      I1 => I59(2),
      I2 => s_axi_arsize(1),
      I3 => I60(1),
      I4 => s_axi_arsize(0),
      I5 => I61(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_67\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_68__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I83(2),
      I2 => s_axi_arsize(0),
      I3 => I82(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_68__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_69\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(0),
      I1 => I59(3),
      I2 => s_axi_arsize(1),
      I3 => I60(2),
      I4 => s_axi_arsize(0),
      I5 => I61(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_69\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_6__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000040"
    )
    port map (
      I0 => narrow_bram_addr_inc_d1,
      I1 => \^curr_narrow_burst\,
      I2 => brst_cnt_dec,
      I3 => narrow_addr_int(1),
      I4 => narrow_addr_int(0),
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_16\,
      O => narrow_addr_ld_en
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_70__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I83(3),
      I2 => s_axi_arsize(0),
      I3 => I84(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_70__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_71\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I58(1),
      I1 => I59(0),
      I2 => s_axi_arsize(1),
      I3 => I56(3),
      I4 => s_axi_arsize(0),
      I5 => I57(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_71\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_72__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I83(0),
      I2 => s_axi_arsize(0),
      I3 => I82(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_72__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_73\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I58(2),
      I1 => I59(1),
      I2 => s_axi_arsize(1),
      I3 => I60(0),
      I4 => s_axi_arsize(0),
      I5 => I57(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_73\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_74__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I83(1),
      I2 => s_axi_arsize(0),
      I3 => I82(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_74__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_75\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I54(3),
      I1 => I55(2),
      I2 => s_axi_arsize(1),
      I3 => I56(1),
      I4 => s_axi_arsize(0),
      I5 => I57(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_75\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_76__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I81(2),
      I2 => s_axi_arsize(0),
      I3 => I80(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_76__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_77\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I58(0),
      I1 => I55(3),
      I2 => s_axi_arsize(1),
      I3 => I56(2),
      I4 => s_axi_arsize(0),
      I5 => I57(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_77\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_78\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => I81(3),
      I2 => s_axi_arsize(0),
      I3 => I82(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_78\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_7__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF01FF00000100"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => p_0_out,
      I4 => \^ar_active_d1\,
      I5 => narrow_burst_cnt_ld_reg(1),
      O => narrow_burst_cnt_ld_mod(1)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_85\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I62(3),
      I1 => I63(3),
      I2 => s_axi_arsize(1),
      I3 => I64(3),
      I4 => s_axi_arsize(0),
      I5 => I65(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_85\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_86__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AACCAACCFFF000F0"
    )
    port map (
      I0 => I71(0),
      I1 => I4(1),
      I2 => \^o4\(1),
      I3 => s_axi_arsize(0),
      I4 => \^o4\(2),
      I5 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_86__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_87__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I40(0),
      I1 => I37(1),
      I2 => s_axi_arsize(1),
      I3 => I38(1),
      I4 => s_axi_arsize(0),
      I5 => I39(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_87__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_88__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(6),
      I1 => s_axi_arlen(7),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(4),
      I5 => s_axi_arlen(5),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_88__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_89__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(2),
      I1 => s_axi_arlen(3),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(0),
      I5 => s_axi_arlen(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_89__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_90__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(6),
      I5 => s_axi_arlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_90__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_91__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(2),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_91__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_92__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(2),
      I1 => s_axi_arlen(3),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(0),
      I5 => s_axi_arlen(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_92__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_93\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_arlen(6),
      I1 => s_axi_arlen(7),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      I4 => s_axi_arlen(4),
      I5 => s_axi_arlen(5),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_93\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_94__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(2),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_94__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_95__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(6),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_95__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_96__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(6),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_96__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_97\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_arlen(0),
      I1 => s_axi_arlen(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arlen(2),
      I4 => s_axi_arsize(0),
      I5 => s_axi_arlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_97\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_98__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(3),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arsize(2),
      I4 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_98__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_99__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000310"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      I2 => s_axi_arsize(1),
      I3 => s_axi_arsize(0),
      I4 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_99__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_1__0\,
      Q => narrow_addr_int(0),
      R => \<const0>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_6__0\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_8__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_9__0\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      S => s_axi_arsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_1__0\,
      Q => narrow_addr_int(1),
      R => \<const0>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_134__0\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_163__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_164\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(3),
      S => s_axi_arsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_135\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_165__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_166\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(2),
      S => s_axi_arsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_59__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_60__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_61__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_62__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_44\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_86__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_87__0\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      S => s_axi_arsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0\,
      CYINIT => \<const0>\,
      DI(3) => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(31),
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_11__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_12__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_13__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_14__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_52\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_94__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_95__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_52\,
      S => s_axi_arsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_54\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_96__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_97\,
      O => \GEN_UA_NARROW.I_UA_NARROW/curr_axlen_unsigned_lshift025_in\,
      S => s_axi_arsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_98__0\,
      DI(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_99__0\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_58_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_100__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_101\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_102__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_103__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_23\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_24__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_25__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_26__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_27__0\
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => \^curr_narrow_burst\,
      I1 => brst_cnt_dec,
      I2 => narrow_addr_int(1),
      I3 => narrow_addr_int(0),
      O => narrow_bram_addr_inc
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => narrow_bram_addr_inc,
      Q => narrow_bram_addr_inc_d1,
      R => \^sr\(0)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1__0\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1__0\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I1,
      D => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1__0\,
      Q => narrow_burst_cnt_ld_reg(0),
      R => \^sr\(0)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I1,
      D => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1__0\,
      Q => narrow_burst_cnt_ld_reg(1),
      R => \^sr\(0)
    );
\GEN_NARROW_EN.curr_narrow_burst_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888800808888"
    )
    port map (
      I0 => I11,
      I1 => s_axi_aresetn,
      I2 => p_0_out,
      I3 => \^ar_active_d1\,
      I4 => axi_rlast_set,
      I5 => pend_rd_op,
      O => \n_0_GEN_NARROW_EN.curr_narrow_burst_i_1__0\
    );
\GEN_NARROW_EN.curr_narrow_burst_i_3__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => curr_narrow_burst_cmb
    );
\GEN_NARROW_EN.curr_narrow_burst_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_NARROW_EN.curr_narrow_burst_i_1__0\,
      Q => \^curr_narrow_burst\,
      R => \<const0>\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(0),
      I1 => bram_rddata_a(0),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[0].axi_rdata_int[0]_i_1\,
      Q => s_axi_rdata(0),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(10),
      I1 => bram_rddata_a(10),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[10].axi_rdata_int[10]_i_1\,
      Q => s_axi_rdata(10),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(11),
      I1 => bram_rddata_a(11),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[11].axi_rdata_int[11]_i_1\,
      Q => s_axi_rdata(11),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(12),
      I1 => bram_rddata_a(12),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[12].axi_rdata_int[12]_i_1\,
      Q => s_axi_rdata(12),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(13),
      I1 => bram_rddata_a(13),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[13].axi_rdata_int[13]_i_1\,
      Q => s_axi_rdata(13),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(14),
      I1 => bram_rddata_a(14),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[14].axi_rdata_int[14]_i_1\,
      Q => s_axi_rdata(14),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(15),
      I1 => bram_rddata_a(15),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[15].axi_rdata_int[15]_i_1\,
      Q => s_axi_rdata(15),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(16),
      I1 => bram_rddata_a(16),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[16].axi_rdata_int[16]_i_1\,
      Q => s_axi_rdata(16),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(17),
      I1 => bram_rddata_a(17),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[17].axi_rdata_int[17]_i_1\,
      Q => s_axi_rdata(17),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(18),
      I1 => bram_rddata_a(18),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[18].axi_rdata_int[18]_i_1\,
      Q => s_axi_rdata(18),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(19),
      I1 => bram_rddata_a(19),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[19].axi_rdata_int[19]_i_1\,
      Q => s_axi_rdata(19),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(1),
      I1 => bram_rddata_a(1),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[1].axi_rdata_int[1]_i_1\,
      Q => s_axi_rdata(1),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(20),
      I1 => bram_rddata_a(20),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[20].axi_rdata_int[20]_i_1\,
      Q => s_axi_rdata(20),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(21),
      I1 => bram_rddata_a(21),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[21].axi_rdata_int[21]_i_1\,
      Q => s_axi_rdata(21),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(22),
      I1 => bram_rddata_a(22),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[22].axi_rdata_int[22]_i_1\,
      Q => s_axi_rdata(22),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(23),
      I1 => bram_rddata_a(23),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[23].axi_rdata_int[23]_i_1\,
      Q => s_axi_rdata(23),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(24),
      I1 => bram_rddata_a(24),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[24].axi_rdata_int[24]_i_1\,
      Q => s_axi_rdata(24),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(25),
      I1 => bram_rddata_a(25),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[25].axi_rdata_int[25]_i_1\,
      Q => s_axi_rdata(25),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(26),
      I1 => bram_rddata_a(26),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[26].axi_rdata_int[26]_i_1\,
      Q => s_axi_rdata(26),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(27),
      I1 => bram_rddata_a(27),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[27].axi_rdata_int[27]_i_1\,
      Q => s_axi_rdata(27),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(28),
      I1 => bram_rddata_a(28),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[28].axi_rdata_int[28]_i_1\,
      Q => s_axi_rdata(28),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(29),
      I1 => bram_rddata_a(29),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[29].axi_rdata_int[29]_i_1\,
      Q => s_axi_rdata(29),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(2),
      I1 => bram_rddata_a(2),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[2].axi_rdata_int[2]_i_1\,
      Q => s_axi_rdata(2),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(30),
      I1 => bram_rddata_a(30),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[30].axi_rdata_int[30]_i_1\,
      Q => s_axi_rdata(30),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
    port map (
      I0 => \^o1\,
      I1 => s_axi_rready,
      I2 => s_axi_aresetn,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0454450004444500"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_adv_buf30_out,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_ns1,
      O => axi_rdata_en
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(31),
      I1 => bram_rddata_a(31),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_3\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_act_rd_burst_two_reg,
      I1 => act_rd_burst,
      O => rd_data_sm_ns1
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_3\,
      Q => s_axi_rdata(31),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(3),
      I1 => bram_rddata_a(3),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[3].axi_rdata_int[3]_i_1\,
      Q => s_axi_rdata(3),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(4),
      I1 => bram_rddata_a(4),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[4].axi_rdata_int[4]_i_1\,
      Q => s_axi_rdata(4),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(5),
      I1 => bram_rddata_a(5),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[5].axi_rdata_int[5]_i_1\,
      Q => s_axi_rdata(5),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(6),
      I1 => bram_rddata_a(6),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[6].axi_rdata_int[6]_i_1\,
      Q => s_axi_rdata(6),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(7),
      I1 => bram_rddata_a(7),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[7].axi_rdata_int[7]_i_1\,
      Q => s_axi_rdata(7),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(8),
      I1 => bram_rddata_a(8),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[8].axi_rdata_int[8]_i_1\,
      Q => s_axi_rdata(8),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => rd_skid_buf(9),
      I1 => bram_rddata_a(9),
      I2 => rddata_mux_sel,
      O => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\
    );
\GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => axi_rdata_en,
      D => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[9].axi_rdata_int[9]_i_1\,
      Q => s_axi_rdata(9),
      R => \n_0_GEN_RDATA_NO_ECC.GEN_RDATA[31].axi_rdata_int[31]_i_1\
    );
\GEN_RDATA_NO_ECC.rd_skid_buf[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAABAAAAAAAAAA"
    )
    port map (
      I0 => rd_skid_buf_ld_reg,
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(3),
      I3 => rd_adv_buf30_out,
      I4 => rd_data_sm_cs(0),
      I5 => rd_data_sm_cs(2),
      O => rd_skid_buf_ld
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(0),
      Q => rd_skid_buf(0),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(10),
      Q => rd_skid_buf(10),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(11),
      Q => rd_skid_buf(11),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(12),
      Q => rd_skid_buf(12),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(13),
      Q => rd_skid_buf(13),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(14),
      Q => rd_skid_buf(14),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(15),
      Q => rd_skid_buf(15),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(16),
      Q => rd_skid_buf(16),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(17),
      Q => rd_skid_buf(17),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(18),
      Q => rd_skid_buf(18),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(19),
      Q => rd_skid_buf(19),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(1),
      Q => rd_skid_buf(1),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(20),
      Q => rd_skid_buf(20),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(21),
      Q => rd_skid_buf(21),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(22),
      Q => rd_skid_buf(22),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(23),
      Q => rd_skid_buf(23),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(24),
      Q => rd_skid_buf(24),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(25),
      Q => rd_skid_buf(25),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(26),
      Q => rd_skid_buf(26),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(27),
      Q => rd_skid_buf(27),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(28),
      Q => rd_skid_buf(28),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(29),
      Q => rd_skid_buf(29),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(2),
      Q => rd_skid_buf(2),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(30),
      Q => rd_skid_buf(30),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(31),
      Q => rd_skid_buf(31),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(3),
      Q => rd_skid_buf(3),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(4),
      Q => rd_skid_buf(4),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(5),
      Q => rd_skid_buf(5),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(6),
      Q => rd_skid_buf(6),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(7),
      Q => rd_skid_buf(7),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(8),
      Q => rd_skid_buf(8),
      R => \^sr\(0)
    );
\GEN_RDATA_NO_ECC.rd_skid_buf_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => rd_skid_buf_ld,
      D => bram_rddata_a(9),
      Q => rd_skid_buf(9),
      R => \^sr\(0)
    );
\GEN_RID_SNG.axi_rid_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FEF20E02"
    )
    port map (
      I0 => \^s_axi_rid\(0),
      I1 => axi_rvalid_set,
      I2 => I1,
      I3 => axi_rid_temp,
      I4 => s_axi_arid(0),
      I5 => \n_0_GEN_RID_SNG.axi_rid_int[0]_i_2\,
      O => \n_0_GEN_RID_SNG.axi_rid_int[0]_i_1\
    );
\GEN_RID_SNG.axi_rid_int[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
    port map (
      I0 => \^o1\,
      I1 => s_axi_rready,
      I2 => s_axi_aresetn,
      O => \n_0_GEN_RID_SNG.axi_rid_int[0]_i_2\
    );
\GEN_RID_SNG.axi_rid_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_RID_SNG.axi_rid_int[0]_i_1\,
      Q => \^s_axi_rid\(0),
      R => \<const0>\
    );
\GEN_RID_SNG.axi_rid_temp_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I1,
      D => s_axi_arid(0),
      Q => axi_rid_temp,
      R => \^sr\(0)
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
I_WRAP_BRST: entity work.ip_axi_bram_ctrlwrap_brst
    port map (
      D(8 downto 0) => D(8 downto 0),
      I1 => \^ar_active_d1\,
      I10 => I10,
      I2 => \^curr_narrow_burst\,
      I3 => n_0_axi_rd_burst_two_reg,
      I4 => \^o19\,
      I5 => I5,
      I6 => I1,
      I7 => I7,
      I8 => I8,
      I9 => I9,
      O2 => O2,
      O25 => O25,
      O26 => O26,
      O27 => O27,
      O28 => O28,
      O29 => O29,
      O3(0) => O3(0),
      O30 => O30,
      O5 => O5,
      O6 => O6,
      O7 => O7,
      O8 => O8,
      Q(3 downto 0) => rd_data_sm_cs(3 downto 0),
      SR(0) => \^sr\(0),
      axi_rd_burst => axi_rd_burst,
      brst_cnt_dec => brst_cnt_dec,
      brst_zero => brst_zero,
      curr_wrap_burst_reg => curr_wrap_burst_reg,
      end_brst_rd => end_brst_rd,
      narrow_addr_int(1 downto 0) => narrow_addr_int(1 downto 0),
      narrow_bram_addr_inc_d1 => narrow_bram_addr_inc_d1,
      p_0_out => p_0_out,
      p_3_in => p_3_in,
      rd_adv_buf30_out => rd_adv_buf30_out,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(10 downto 0) => s_axi_araddr(12 downto 2),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arlen(3 downto 0) => s_axi_arlen(3 downto 0),
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_awaddr(0) => s_axi_awaddr(0),
      s_axi_rready => s_axi_rready
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
act_rd_burst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE222E2"
    )
    port map (
      I0 => act_rd_burst,
      I1 => act_rd_burst_set,
      I2 => axi_rd_burst,
      I3 => I1,
      I4 => axi_rd_burst126_in,
      I5 => n_0_act_rd_burst_two_i_3,
      O => n_0_act_rd_burst_i_1
    );
act_rd_burst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_act_rd_burst_i_1,
      Q => act_rd_burst,
      R => \<const0>\
    );
act_rd_burst_two_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE222E2"
    )
    port map (
      I0 => n_0_act_rd_burst_two_reg,
      I1 => act_rd_burst_set,
      I2 => n_0_axi_rd_burst_two_reg,
      I3 => I1,
      I4 => act_rd_burst_two,
      I5 => n_0_act_rd_burst_two_i_3,
      O => n_0_act_rd_burst_two_i_1
    );
act_rd_burst_two_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000010001010100"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(2),
      I3 => n_0_act_rd_burst_two_i_4,
      I4 => rd_data_sm_cs(0),
      I5 => axi_rd_burst_two,
      O => act_rd_burst_set
    );
act_rd_burst_two_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8100FFFF"
    )
    port map (
      I0 => rd_data_sm_cs(0),
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(2),
      I3 => n_0_act_rd_burst_two_i_5,
      I4 => s_axi_aresetn,
      O => n_0_act_rd_burst_two_i_3
    );
act_rd_burst_two_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => \^ar_active_d1\,
      I1 => p_0_out,
      I2 => \^axi_rd_burst1\,
      O => n_0_act_rd_burst_two_i_4
    );
act_rd_burst_two_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E000E0000000"
    )
    port map (
      I0 => act_rd_burst,
      I1 => n_0_act_rd_burst_two_reg,
      I2 => \^o19\,
      I3 => s_axi_rready,
      I4 => rd_data_sm_cs(3),
      I5 => rd_data_sm_cs(2),
      O => n_0_act_rd_burst_two_i_5
    );
act_rd_burst_two_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_act_rd_burst_two_i_1,
      Q => n_0_act_rd_burst_two_reg,
      R => \<const0>\
    );
axi_arready_int_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => s_axi_rready,
      I1 => \^o1\,
      O => AR2Arb_Active_Clr
    );
axi_rd_burst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C000C0000000AA00"
    )
    port map (
      I0 => axi_rd_burst,
      I1 => \^axi_rd_burst1\,
      I2 => axi_rd_burst126_in,
      I3 => s_axi_aresetn,
      I4 => brst_zero,
      I5 => I1,
      O => n_0_axi_rd_burst_i_1
    );
axi_rd_burst_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => s_axi_arlen(7),
      I1 => s_axi_arlen(6),
      I2 => n_0_axi_rd_burst_i_4,
      O => \^axi_rd_burst1\
    );
axi_rd_burst_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => s_axi_arlen(7),
      I1 => s_axi_arlen(6),
      I2 => n_0_axi_rd_burst_i_5,
      O => axi_rd_burst126_in
    );
axi_rd_burst_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arlen(1),
      I3 => s_axi_arlen(0),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => n_0_axi_rd_burst_i_4
    );
axi_rd_burst_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFEFF"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arlen(1),
      I3 => s_axi_arlen(0),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => n_0_axi_rd_burst_i_5
    );
axi_rd_burst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_rd_burst_i_1,
      Q => axi_rd_burst,
      R => \<const0>\
    );
axi_rd_burst_two_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00A0C0C000A000A0"
    )
    port map (
      I0 => n_0_axi_rd_burst_two_reg,
      I1 => act_rd_burst_two,
      I2 => s_axi_aresetn,
      I3 => brst_zero,
      I4 => \^ar_active_d1\,
      I5 => p_0_out,
      O => n_0_axi_rd_burst_two_i_1
    );
axi_rd_burst_two_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_arlen(7),
      I1 => s_axi_arlen(6),
      I2 => n_0_axi_rd_burst_two_i_3,
      O => act_rd_burst_two
    );
axi_rd_burst_two_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arlen(0),
      I3 => s_axi_arlen(1),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => n_0_axi_rd_burst_two_i_3
    );
axi_rd_burst_two_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_rd_burst_two_i_1,
      Q => n_0_axi_rd_burst_two_reg,
      R => \<const0>\
    );
axi_rlast_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA08"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \^o1\,
      I2 => s_axi_rready,
      I3 => axi_rlast_set,
      O => n_0_axi_rlast_int_i_1
    );
axi_rlast_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000575403005050"
    )
    port map (
      I0 => \^o1\,
      I1 => \n_0_FSM_onehot_rlast_sm_cs_reg[2]\,
      I2 => \n_0_FSM_onehot_rlast_sm_cs_reg[4]\,
      I3 => rd_adv_buf30_out,
      I4 => \n_0_FSM_onehot_rlast_sm_cs_reg[1]\,
      I5 => \n_0_FSM_onehot_rlast_sm_cs_reg[3]\,
      O => axi_rlast_set
    );
axi_rlast_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_rlast_int_i_1,
      Q => \^o1\,
      R => \<const0>\
    );
axi_rvalid_clr_ok_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => axi_rvalid_clr_ok,
      I2 => axi_rvalid_clr_ok0,
      O => n_0_axi_rvalid_clr_ok_i_1
    );
axi_rvalid_clr_ok_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBBBAAAAA"
    )
    port map (
      I0 => I1,
      I1 => axi_rvalid_clr_ok,
      I2 => disable_b2b_brst,
      I3 => disable_b2b_brst_cmb,
      I4 => last_bram_addr,
      I5 => n_0_axi_rvalid_clr_ok_i_3,
      O => axi_rvalid_clr_ok0
    );
axi_rvalid_clr_ok_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(2),
      O => n_0_axi_rvalid_clr_ok_i_3
    );
axi_rvalid_clr_ok_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_rvalid_clr_ok_i_1,
      Q => axi_rvalid_clr_ok,
      R => \<const0>\
    );
axi_rvalid_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E0E0E0E0E0E0E0"
    )
    port map (
      I0 => \^o19\,
      I1 => axi_rvalid_set,
      I2 => s_axi_aresetn,
      I3 => axi_rvalid_clr_ok,
      I4 => \^o1\,
      I5 => s_axi_rready,
      O => n_0_axi_rvalid_int_i_1
    );
axi_rvalid_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_rvalid_int_i_1,
      Q => \^o19\,
      R => \<const0>\
    );
axi_rvalid_set_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      O => axi_rvalid_set_cmb
    );
axi_rvalid_set_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => axi_rvalid_set_cmb,
      Q => axi_rvalid_set,
      R => \^sr\(0)
    );
bram_en_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888AAA888880008"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \^p_7_in\,
      I2 => n_0_bram_en_int_i_2,
      I3 => n_0_bram_en_int_reg_i_3,
      I4 => rd_data_sm_cs(3),
      I5 => bram_en_cmb,
      O => n_0_bram_en_int_i_1
    );
bram_en_int_i_10: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => end_brst_rd,
      I1 => brst_zero,
      O => n_0_bram_en_int_i_10
    );
bram_en_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888008080800080"
    )
    port map (
      I0 => rd_data_sm_cs(0),
      I1 => rd_adv_buf30_out,
      I2 => I1,
      I3 => rd_data_sm_ns1,
      I4 => rd_data_sm_cs(1),
      I5 => pend_rd_op,
      O => n_0_bram_en_int_i_2
    );
bram_en_int_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF040404FF04"
    )
    port map (
      I0 => n_0_axi_rd_burst_two_reg,
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(0),
      I3 => n_0_bram_en_int_i_7,
      I4 => rd_data_sm_cs(2),
      I5 => n_0_bram_en_int_i_8,
      O => bram_en_cmb
    );
bram_en_int_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFEFEFE5EFEFE"
    )
    port map (
      I0 => rd_data_sm_cs(0),
      I1 => I1,
      I2 => rd_data_sm_cs(1),
      I3 => rd_adv_buf30_out,
      I4 => brst_one,
      I5 => bram_addr_inc1,
      O => n_0_bram_en_int_i_5
    );
bram_en_int_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0303030383838380"
    )
    port map (
      I0 => I1,
      I1 => rd_data_sm_cs(0),
      I2 => rd_data_sm_cs(1),
      I3 => brst_zero,
      I4 => end_brst_rd,
      I5 => rd_adv_buf30_out,
      O => n_0_bram_en_int_i_6
    );
bram_en_int_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA00AA00FCFFFC00"
    )
    port map (
      I0 => n_0_bram_en_int_i_10,
      I1 => axi_rd_burst,
      I2 => n_0_axi_rd_burst_two_reg,
      I3 => rd_data_sm_cs(0),
      I4 => I1,
      I5 => rd_data_sm_cs(1),
      O => n_0_bram_en_int_i_7
    );
bram_en_int_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8C8F0C0F8FBF0C0"
    )
    port map (
      I0 => pend_rd_op,
      I1 => rd_data_sm_cs(1),
      I2 => I1,
      I3 => rd_data_sm_cs(0),
      I4 => rd_adv_buf30_out,
      I5 => bram_addr_inc1,
      O => n_0_bram_en_int_i_8
    );
bram_en_int_i_9: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => brst_zero,
      I1 => end_brst_rd,
      O => bram_addr_inc1
    );
bram_en_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_bram_en_int_i_1,
      Q => \^p_7_in\,
      R => \<const0>\
    );
bram_en_int_reg_i_3: unisim.vcomponents.MUXF7
    port map (
      I0 => n_0_bram_en_int_i_5,
      I1 => n_0_bram_en_int_i_6,
      O => n_0_bram_en_int_reg_i_3,
      S => rd_data_sm_cs(2)
    );
\brst_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22A288A822028808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[0]\,
      I2 => p_0_out,
      I3 => \^ar_active_d1\,
      I4 => brst_cnt_dec,
      I5 => s_axi_arlen(0),
      O => \n_0_brst_cnt[0]_i_1\
    );
\brst_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A2A808080208"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[1]\,
      I2 => I1,
      I3 => brst_cnt_dec,
      I4 => \n_0_brst_cnt_reg[0]\,
      I5 => s_axi_arlen(1),
      O => \n_0_brst_cnt[1]_i_1\
    );
\brst_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A2A808080208"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[2]\,
      I2 => I1,
      I3 => brst_cnt_dec,
      I4 => \n_0_brst_cnt[2]_i_2\,
      I5 => s_axi_arlen(2),
      O => \n_0_brst_cnt[2]_i_1\
    );
\brst_cnt[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_brst_cnt_reg[0]\,
      I1 => \n_0_brst_cnt_reg[1]\,
      O => \n_0_brst_cnt[2]_i_2\
    );
\brst_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A2A808080208"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[3]\,
      I2 => I1,
      I3 => brst_cnt_dec,
      I4 => \n_0_brst_cnt[3]_i_2\,
      I5 => s_axi_arlen(3),
      O => \n_0_brst_cnt[3]_i_1\
    );
\brst_cnt[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => \n_0_brst_cnt_reg[1]\,
      I1 => \n_0_brst_cnt_reg[0]\,
      I2 => \n_0_brst_cnt_reg[2]\,
      O => \n_0_brst_cnt[3]_i_2\
    );
\brst_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A2A808080208"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[4]\,
      I2 => I1,
      I3 => brst_cnt_dec,
      I4 => \n_0_brst_cnt[4]_i_2\,
      I5 => s_axi_arlen(4),
      O => \n_0_brst_cnt[4]_i_1\
    );
\brst_cnt[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => \n_0_brst_cnt_reg[2]\,
      I1 => \n_0_brst_cnt_reg[0]\,
      I2 => \n_0_brst_cnt_reg[1]\,
      I3 => \n_0_brst_cnt_reg[3]\,
      O => \n_0_brst_cnt[4]_i_2\
    );
\brst_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A2A808080208"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[5]\,
      I2 => I1,
      I3 => brst_cnt_dec,
      I4 => \n_0_brst_cnt[5]_i_2\,
      I5 => s_axi_arlen(5),
      O => \n_0_brst_cnt[5]_i_1\
    );
\brst_cnt[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => \n_0_brst_cnt_reg[3]\,
      I1 => \n_0_brst_cnt_reg[1]\,
      I2 => \n_0_brst_cnt_reg[0]\,
      I3 => \n_0_brst_cnt_reg[2]\,
      I4 => \n_0_brst_cnt_reg[4]\,
      O => \n_0_brst_cnt[5]_i_2\
    );
\brst_cnt[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A2A808080208"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[6]\,
      I2 => I1,
      I3 => brst_cnt_dec,
      I4 => \n_0_brst_cnt[6]_i_2\,
      I5 => s_axi_arlen(6),
      O => \n_0_brst_cnt[6]_i_1\
    );
\brst_cnt[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \n_0_brst_cnt_reg[4]\,
      I1 => \n_0_brst_cnt_reg[2]\,
      I2 => \n_0_brst_cnt_reg[0]\,
      I3 => \n_0_brst_cnt_reg[1]\,
      I4 => \n_0_brst_cnt_reg[3]\,
      I5 => \n_0_brst_cnt_reg[5]\,
      O => \n_0_brst_cnt[6]_i_2\
    );
\brst_cnt[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA88A800008808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => \n_0_brst_cnt_reg[7]\,
      I2 => p_0_out,
      I3 => \^ar_active_d1\,
      I4 => brst_cnt_dec,
      I5 => \n_0_brst_cnt[7]_i_3\,
      O => \n_0_brst_cnt[7]_i_1\
    );
\brst_cnt[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FC03FC03AAAAFC03"
    )
    port map (
      I0 => s_axi_arlen(7),
      I1 => \n_0_brst_cnt_reg[6]\,
      I2 => \n_0_brst_cnt[6]_i_2\,
      I3 => \n_0_brst_cnt_reg[7]\,
      I4 => p_0_out,
      I5 => \^ar_active_d1\,
      O => \n_0_brst_cnt[7]_i_3\
    );
brst_cnt_max_d1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\,
      Q => brst_cnt_max_d1,
      R => \^sr\(0)
    );
\brst_cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[0]_i_1\,
      Q => \n_0_brst_cnt_reg[0]\,
      R => \<const0>\
    );
\brst_cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[1]_i_1\,
      Q => \n_0_brst_cnt_reg[1]\,
      R => \<const0>\
    );
\brst_cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[2]_i_1\,
      Q => \n_0_brst_cnt_reg[2]\,
      R => \<const0>\
    );
\brst_cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[3]_i_1\,
      Q => \n_0_brst_cnt_reg[3]\,
      R => \<const0>\
    );
\brst_cnt_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[4]_i_1\,
      Q => \n_0_brst_cnt_reg[4]\,
      R => \<const0>\
    );
\brst_cnt_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[5]_i_1\,
      Q => \n_0_brst_cnt_reg[5]\,
      R => \<const0>\
    );
\brst_cnt_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[6]_i_1\,
      Q => \n_0_brst_cnt_reg[6]\,
      R => \<const0>\
    );
\brst_cnt_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_brst_cnt[7]_i_1\,
      Q => \n_0_brst_cnt_reg[7]\,
      R => \<const0>\
    );
brst_one_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000E0000"
    )
    port map (
      I0 => brst_one,
      I1 => brst_one0,
      I2 => n_0_brst_one_i_3,
      I3 => n_0_brst_zero_i_2,
      I4 => s_axi_aresetn,
      O => n_0_brst_one_i_1
    );
brst_one_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0080"
    )
    port map (
      I0 => brst_cnt_dec,
      I1 => n_0_brst_zero_i_4,
      I2 => \n_0_brst_cnt_reg[1]\,
      I3 => \n_0_brst_cnt_reg[0]\,
      I4 => n_0_brst_one_i_4,
      O => brst_one0
    );
brst_one_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44444440"
    )
    port map (
      I0 => \^ar_active_d1\,
      I1 => p_0_out,
      I2 => n_0_brst_one_i_5,
      I3 => s_axi_arlen(6),
      I4 => s_axi_arlen(7),
      O => n_0_brst_one_i_3
    );
brst_one_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000040"
    )
    port map (
      I0 => \^ar_active_d1\,
      I1 => p_0_out,
      I2 => n_0_brst_one_i_6,
      I3 => s_axi_arlen(6),
      I4 => s_axi_arlen(5),
      O => n_0_brst_one_i_4
    );
brst_one_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFEFF"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arlen(1),
      I3 => s_axi_arlen(0),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => n_0_brst_one_i_5
    );
brst_one_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(7),
      I2 => s_axi_arlen(0),
      I3 => s_axi_arlen(3),
      I4 => s_axi_arlen(2),
      I5 => s_axi_arlen(1),
      O => n_0_brst_one_i_6
    );
brst_one_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_brst_one_i_1,
      Q => brst_one,
      R => \<const0>\
    );
brst_zero_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => brst_zero,
      I1 => n_0_brst_zero_i_2,
      I2 => I12,
      O => n_0_brst_zero_i_1
    );
brst_zero_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => brst_cnt_dec,
      I1 => n_0_brst_zero_i_4,
      I2 => \n_0_brst_cnt_reg[1]\,
      I3 => \n_0_brst_cnt_reg[0]\,
      O => n_0_brst_zero_i_2
    );
brst_zero_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \n_0_brst_cnt_reg[3]\,
      I1 => \n_0_brst_cnt_reg[2]\,
      I2 => \n_0_brst_cnt_reg[7]\,
      I3 => \n_0_brst_cnt_reg[5]\,
      I4 => \n_0_brst_cnt_reg[4]\,
      I5 => \n_0_brst_cnt_reg[6]\,
      O => n_0_brst_zero_i_4
    );
brst_zero_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arlen(1),
      I3 => s_axi_arlen(0),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => O23
    );
brst_zero_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_brst_zero_i_1,
      Q => brst_zero,
      R => \<const0>\
    );
curr_fixed_burst_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => s_axi_arburst(0),
      I1 => s_axi_arburst(1),
      O => curr_fixed_burst
    );
curr_fixed_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I1,
      D => curr_fixed_burst,
      Q => n_0_curr_fixed_burst_reg_reg,
      R => \^sr\(0)
    );
\curr_wrap_burst_reg_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => s_axi_arburst(1),
      I1 => s_axi_arburst(0),
      O => \n_0_curr_wrap_burst_reg_i_1__0\
    );
curr_wrap_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I1,
      D => \n_0_curr_wrap_burst_reg_i_1__0\,
      Q => curr_wrap_burst_reg,
      R => \^sr\(0)
    );
disable_b2b_brst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEAEEEEEEAEEAE"
    )
    port map (
      I0 => n_0_disable_b2b_brst_i_2,
      I1 => disable_b2b_brst,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(3),
      I5 => rd_data_sm_cs(2),
      O => disable_b2b_brst_cmb
    );
disable_b2b_brst_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAABBB"
    )
    port map (
      I0 => n_0_disable_b2b_brst_i_3,
      I1 => n_0_disable_b2b_brst_i_4,
      I2 => s_axi_rready,
      I3 => \^o19\,
      I4 => rd_data_sm_cs(2),
      O => n_0_disable_b2b_brst_i_2
    );
disable_b2b_brst_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000101100000000"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => n_0_axi_rd_burst_two_reg,
      I3 => axi_rd_burst,
      I4 => rd_data_sm_cs(1),
      I5 => rd_data_sm_cs(0),
      O => n_0_disable_b2b_brst_i_3
    );
disable_b2b_brst_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFBFBFBFBFBFBFFF"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(0),
      I3 => end_brst_rd,
      I4 => brst_zero,
      I5 => brst_one,
      O => n_0_disable_b2b_brst_i_4
    );
disable_b2b_brst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => disable_b2b_brst_cmb,
      Q => disable_b2b_brst,
      R => \^sr\(0)
    );
end_brst_rd_clr_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => end_brst_rd_clr,
      I2 => n_0_end_brst_rd_clr_i_2,
      I3 => rd_data_sm_cs(2),
      O => n_0_end_brst_rd_clr_i_1
    );
end_brst_rd_clr_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000FF04"
    )
    port map (
      I0 => \^ar_active_d1\,
      I1 => p_0_out,
      I2 => rd_data_sm_cs(2),
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(3),
      I5 => rd_data_sm_cs(1),
      O => n_0_end_brst_rd_clr_i_2
    );
end_brst_rd_clr_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_end_brst_rd_clr_i_1,
      Q => end_brst_rd_clr,
      R => \<const0>\
    );
end_brst_rd_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00F04040"
    )
    port map (
      I0 => brst_cnt_max_d1,
      I1 => \n_0_GEN_BRST_MAX_W_NARROW.brst_cnt_max_reg\,
      I2 => s_axi_aresetn,
      I3 => end_brst_rd_clr,
      I4 => end_brst_rd,
      O => n_0_end_brst_rd_i_1
    );
end_brst_rd_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_end_brst_rd_i_1,
      Q => end_brst_rd,
      R => \<const0>\
    );
last_bram_addr_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF88000030"
    )
    port map (
      I0 => n_0_last_bram_addr_i_2,
      I1 => rd_data_sm_cs(2),
      I2 => n_0_last_bram_addr_i_3,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(1),
      I5 => n_0_brst_zero_i_2,
      O => last_bram_addr0
    );
last_bram_addr_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000A8000000"
    )
    port map (
      I0 => set_last_bram_addr7_in,
      I1 => pend_rd_op,
      I2 => I1,
      I3 => s_axi_rready,
      I4 => \^o19\,
      I5 => rd_data_sm_cs(3),
      O => n_0_last_bram_addr_i_2
    );
last_bram_addr_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000100010FF1000"
    )
    port map (
      I0 => axi_rd_burst,
      I1 => n_0_axi_rd_burst_two_reg,
      I2 => rd_adv_buf30_out,
      I3 => rd_data_sm_cs(3),
      I4 => I1,
      I5 => \^axi_rd_burst1\,
      O => n_0_last_bram_addr_i_3
    );
last_bram_addr_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"10FF100010001000"
    )
    port map (
      I0 => s_axi_arlen(7),
      I1 => s_axi_arlen(6),
      I2 => n_0_last_bram_addr_i_5,
      I3 => I1,
      I4 => axi_rd_burst_two,
      I5 => pend_rd_op,
      O => set_last_bram_addr7_in
    );
last_bram_addr_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => s_axi_arlen(4),
      I1 => s_axi_arlen(5),
      I2 => s_axi_arlen(1),
      I3 => s_axi_arlen(0),
      I4 => s_axi_arlen(3),
      I5 => s_axi_arlen(2),
      O => n_0_last_bram_addr_i_5
    );
last_bram_addr_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => last_bram_addr0,
      Q => last_bram_addr,
      R => \^sr\(0)
    );
pend_rd_op_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA888A800088808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => pend_rd_op,
      I2 => n_0_pend_rd_op_i_2,
      I3 => rd_data_sm_cs(0),
      I4 => n_0_pend_rd_op_i_3,
      I5 => pend_rd_op_cmb,
      O => n_0_pend_rd_op_i_1
    );
pend_rd_op_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1010100010001000"
    )
    port map (
      I0 => rd_data_sm_cs(1),
      I1 => rd_data_sm_cs(3),
      I2 => rd_data_sm_cs(2),
      I3 => I1,
      I4 => \^o1\,
      I5 => pend_rd_op,
      O => n_0_pend_rd_op_i_2
    );
pend_rd_op_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000080800F00"
    )
    port map (
      I0 => n_0_pend_rd_op_i_5,
      I1 => pend_rd_op,
      I2 => rd_data_sm_cs(1),
      I3 => n_0_pend_rd_op_i_6,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => n_0_pend_rd_op_i_3
    );
pend_rd_op_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000044450000"
    )
    port map (
      I0 => rd_data_sm_cs(1),
      I1 => rd_data_sm_cs(2),
      I2 => axi_rd_burst,
      I3 => n_0_axi_rd_burst_two_reg,
      I4 => p_0_out,
      I5 => \^ar_active_d1\,
      O => pend_rd_op_cmb
    );
pend_rd_op_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AE000000"
    )
    port map (
      I0 => pend_rd_op,
      I1 => p_0_out,
      I2 => \^ar_active_d1\,
      I3 => s_axi_rready,
      I4 => \^o19\,
      O => n_0_pend_rd_op_i_5
    );
pend_rd_op_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAAE"
    )
    port map (
      I0 => pend_rd_op,
      I1 => p_0_out,
      I2 => \^ar_active_d1\,
      I3 => n_0_axi_rd_burst_two_reg,
      I4 => axi_rd_burst,
      O => n_0_pend_rd_op_i_6
    );
pend_rd_op_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_pend_rd_op_i_1,
      Q => pend_rd_op,
      R => \<const0>\
    );
\rd_data_sm_cs[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F001F1F0F001010"
    )
    port map (
      I0 => rd_data_sm_cs(0),
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(3),
      I3 => \n_0_rd_data_sm_cs[0]_i_2\,
      I4 => rd_data_sm_cs(2),
      I5 => \n_0_rd_data_sm_cs[0]_i_3\,
      O => rd_data_sm_ns(0)
    );
\rd_data_sm_cs[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F3B3C0B0FFFFFFFF"
    )
    port map (
      I0 => pend_rd_op,
      I1 => rd_data_sm_cs(1),
      I2 => rd_adv_buf30_out,
      I3 => I1,
      I4 => rd_data_sm_ns1,
      I5 => rd_data_sm_cs(0),
      O => \n_0_rd_data_sm_cs[0]_i_2\
    );
\rd_data_sm_cs[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8080808FFFFFFFFF"
    )
    port map (
      I0 => s_axi_rready,
      I1 => \^o19\,
      I2 => rd_data_sm_cs(1),
      I3 => axi_rd_burst,
      I4 => n_0_axi_rd_burst_two_reg,
      I5 => rd_data_sm_cs(0),
      O => \n_0_rd_data_sm_cs[0]_i_3\
    );
\rd_data_sm_cs[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000022E2EEE2"
    )
    port map (
      I0 => \n_0_rd_data_sm_cs[1]_i_2\,
      I1 => rd_data_sm_cs(2),
      I2 => \n_0_rd_data_sm_cs[1]_i_3\,
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => rd_data_sm_cs(3),
      O => rd_data_sm_ns(1)
    );
\rd_data_sm_cs[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4462"
    )
    port map (
      I0 => rd_data_sm_cs(1),
      I1 => rd_data_sm_cs(0),
      I2 => axi_rd_burst,
      I3 => n_0_axi_rd_burst_two_reg,
      O => \n_0_rd_data_sm_cs[1]_i_2\
    );
\rd_data_sm_cs[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BF00BF00BF00BFFF"
    )
    port map (
      I0 => rd_data_sm_ns1,
      I1 => I1,
      I2 => rd_adv_buf30_out,
      I3 => rd_data_sm_cs(0),
      I4 => end_brst_rd,
      I5 => brst_zero,
      O => \n_0_rd_data_sm_cs[1]_i_3\
    );
\rd_data_sm_cs[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000022E2EEE2"
    )
    port map (
      I0 => \n_0_rd_data_sm_cs[2]_i_2\,
      I1 => rd_data_sm_cs(2),
      I2 => \n_0_rd_data_sm_cs[2]_i_3\,
      I3 => rd_data_sm_cs(1),
      I4 => rd_data_sm_cs(0),
      I5 => rd_data_sm_cs(3),
      O => rd_data_sm_ns(2)
    );
\rd_data_sm_cs[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA8C"
    )
    port map (
      I0 => rd_data_sm_cs(1),
      I1 => rd_data_sm_cs(0),
      I2 => axi_rd_burst,
      I3 => n_0_axi_rd_burst_two_reg,
      O => \n_0_rd_data_sm_cs[2]_i_2\
    );
\rd_data_sm_cs[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFBFFFBFFFBF00"
    )
    port map (
      I0 => rd_data_sm_ns1,
      I1 => I1,
      I2 => rd_adv_buf30_out,
      I3 => rd_data_sm_cs(0),
      I4 => brst_zero,
      I5 => end_brst_rd,
      O => \n_0_rd_data_sm_cs[2]_i_3\
    );
\rd_data_sm_cs[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEF8FFFFFEFFF8F"
    )
    port map (
      I0 => rd_adv_buf30_out,
      I1 => rd_data_sm_cs(3),
      I2 => \n_0_rd_data_sm_cs[3]_i_3\,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(1),
      O => \n_0_rd_data_sm_cs[3]_i_1\
    );
\rd_data_sm_cs[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000070400000"
    )
    port map (
      I0 => rd_adv_buf30_out,
      I1 => rd_data_sm_cs(1),
      I2 => rd_data_sm_cs(0),
      I3 => \n_0_rd_data_sm_cs[3]_i_4\,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => rd_data_sm_ns(3)
    );
\rd_data_sm_cs[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0FFF0F0F4FFF404F"
    )
    port map (
      I0 => bram_addr_inc17_out,
      I1 => rd_adv_buf30_out,
      I2 => rd_data_sm_cs(0),
      I3 => I1,
      I4 => rd_data_sm_cs(2),
      I5 => rd_data_sm_cs(3),
      O => \n_0_rd_data_sm_cs[3]_i_3\
    );
\rd_data_sm_cs[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E0000000000000"
    )
    port map (
      I0 => act_rd_burst,
      I1 => n_0_act_rd_burst_two_reg,
      I2 => p_0_out,
      I3 => \^ar_active_d1\,
      I4 => \^o19\,
      I5 => s_axi_rready,
      O => \n_0_rd_data_sm_cs[3]_i_4\
    );
\rd_data_sm_cs[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => brst_zero,
      I1 => end_brst_rd,
      O => bram_addr_inc17_out
    );
\rd_data_sm_cs_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \n_0_rd_data_sm_cs[3]_i_1\,
      D => rd_data_sm_ns(0),
      Q => rd_data_sm_cs(0),
      R => \^sr\(0)
    );
\rd_data_sm_cs_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \n_0_rd_data_sm_cs[3]_i_1\,
      D => rd_data_sm_ns(1),
      Q => rd_data_sm_cs(1),
      R => \^sr\(0)
    );
\rd_data_sm_cs_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \n_0_rd_data_sm_cs[3]_i_1\,
      D => rd_data_sm_ns(2),
      Q => rd_data_sm_cs(2),
      R => \^sr\(0)
    );
\rd_data_sm_cs_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \n_0_rd_data_sm_cs[3]_i_1\,
      D => rd_data_sm_ns(3),
      Q => rd_data_sm_cs(3),
      R => \^sr\(0)
    );
rd_skid_buf_ld_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1110011001100110"
    )
    port map (
      I0 => rd_data_sm_cs(3),
      I1 => rd_data_sm_cs(2),
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(1),
      I4 => s_axi_rready,
      I5 => \^o19\,
      O => rd_skid_buf_ld_cmb
    );
rd_skid_buf_ld_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => rd_skid_buf_ld_cmb,
      Q => rd_skid_buf_ld_reg,
      R => \^sr\(0)
    );
rddata_mux_sel_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888A8880"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => rddata_mux_sel,
      I2 => n_0_rddata_mux_sel_i_2,
      I3 => rd_data_sm_cs(3),
      I4 => rddata_mux_sel_cmb,
      O => n_0_rddata_mux_sel_i_1
    );
rddata_mux_sel_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A007AF07AF07AF07"
    )
    port map (
      I0 => rd_data_sm_cs(1),
      I1 => n_0_axi_rd_burst_two_reg,
      I2 => rd_data_sm_cs(0),
      I3 => rd_data_sm_cs(2),
      I4 => \^o19\,
      I5 => s_axi_rready,
      O => n_0_rddata_mux_sel_i_2
    );
rddata_mux_sel_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"03FF0000FF00AA00"
    )
    port map (
      I0 => rd_data_sm_cs(1),
      I1 => act_rd_burst,
      I2 => n_0_act_rd_burst_two_reg,
      I3 => rd_data_sm_cs(0),
      I4 => rd_data_sm_cs(2),
      I5 => rd_adv_buf30_out,
      O => rddata_mux_sel_cmb
    );
rddata_mux_sel_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_rddata_mux_sel_i_1,
      Q => rddata_mux_sel,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlwr_chnl is
  port (
    axi_wdata_full_reg : out STD_LOGIC;
    aw_active_d1 : out STD_LOGIC;
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    O1 : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 9 downto 0 );
    DI : out STD_LOGIC_VECTOR ( 2 downto 0 );
    p_3_in : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    last_arb_won_cmb6_out : out STD_LOGIC;
    curr_ua_narrow_wrap4 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    bram_en_a : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    O10 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    O12 : out STD_LOGIC;
    O13 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_1_out : in STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    O : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    I2 : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    I3 : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    arb_sm_cs : in STD_LOGIC_VECTOR ( 0 to 0 );
    I4 : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I6 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I7 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I8 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I9 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I10 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I11 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I12 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I13 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I14 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I15 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I16 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I17 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I18 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I19 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I20 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I21 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I22 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I23 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I24 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I25 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I26 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I27 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I28 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I29 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I30 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I31 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I32 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I33 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I34 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I35 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I36 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I37 : in STD_LOGIC;
    I38 : in STD_LOGIC;
    I39 : in STD_LOGIC;
    I68 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    p_7_in : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    curr_narrow_burst_en : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I40 : in STD_LOGIC;
    I70 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_wdata_full_cmb16_out : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    I41 : in STD_LOGIC;
    I72 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I73 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I74 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I75 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I76 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I77 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I78 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I86 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end ip_axi_bram_ctrlwr_chnl;

architecture STRUCTURE of ip_axi_bram_ctrlwr_chnl is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal AW2Arb_BVALID_Cnt : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^di\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \GEN_UA_NARROW.I_UA_NARROW/bytes_per_addr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GEN_UA_NARROW.I_UA_NARROW/curr_axlen_unsigned_lshift025_in\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^o1\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o6\ : STD_LOGIC;
  signal \^aw_active_d1\ : STD_LOGIC;
  signal axi_wdata_full_cmb : STD_LOGIC;
  signal \^axi_wdata_full_reg\ : STD_LOGIC;
  signal axi_wlast_d1 : STD_LOGIC;
  signal axi_wr_burst : STD_LOGIC;
  signal bid_gets_fifo_load : STD_LOGIC;
  signal bid_gets_fifo_load_d1 : STD_LOGIC;
  signal bram_addr_inc : STD_LOGIC;
  signal bvalid_cnt_dec20_out : STD_LOGIC;
  signal bvalid_cnt_inc0 : STD_LOGIC;
  signal clr_bram_we : STD_LOGIC;
  signal curr_fixed_burst_reg : STD_LOGIC;
  signal curr_narrow_burst : STD_LOGIC;
  signal curr_narrow_burst_cmb : STD_LOGIC;
  signal curr_wrap_burst_reg : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_2\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_3\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_4\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_8\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_9\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_100\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_101__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_102\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_103\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_104__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_105\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_106__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_107\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_108__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_109\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_11\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_110__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_111\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_112__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_113\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_114__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_115\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_116__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_12\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_13\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_135\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_136__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_137\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_138__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_139\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_14\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_140__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_141\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_142__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_15\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_155\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_162__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_163\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_164__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_165\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_2\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_23\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_24\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_25\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_26\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_27\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_3\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_31\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_32__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_33\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_34__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_35\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_36__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_37\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_38__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_39\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_40__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_41\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_42__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_44\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_45\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_46__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_47\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_48\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_49\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_5\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_50\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_52\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_54\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_55\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_58\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_59\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_60\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_61\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_62\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_63__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_64\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_65__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_66\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_67__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_68\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_69__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_70\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_71__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_72\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_73__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_74\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_75__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_76\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_77__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_84\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_85__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_86\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_87\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_88\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_89\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_90\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_91\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_92\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_93__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_94\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_95\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_96\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_97__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_98\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_99\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_51\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_EN.curr_narrow_burst_i_1\ : STD_LOGIC;
  signal \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_i_1\ : STD_LOGIC;
  signal \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1\ : STD_LOGIC;
  signal \n_0_GEN_WR_NO_ECC.bram_we_int[3]_i_1\ : STD_LOGIC;
  signal n_0_axi_bvalid_int_i_1 : STD_LOGIC;
  signal n_0_axi_wr_burst_i_1 : STD_LOGIC;
  signal n_0_axi_wr_burst_i_2 : STD_LOGIC;
  signal n_0_axi_wready_int_mod_i_1 : STD_LOGIC;
  signal \n_0_bvalid_cnt[0]_i_1\ : STD_LOGIC;
  signal \n_0_bvalid_cnt[1]_i_1\ : STD_LOGIC;
  signal \n_0_bvalid_cnt[2]_i_1\ : STD_LOGIC;
  signal n_11_I_WRAP_BRST : STD_LOGIC;
  signal n_13_I_WRAP_BRST : STD_LOGIC;
  signal n_15_I_WRAP_BRST : STD_LOGIC;
  signal n_1_BID_FIFO : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\ : STD_LOGIC;
  signal n_3_BID_FIFO : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\ : STD_LOGIC;
  signal narrow_addr_int : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal narrow_addr_ld_en : STD_LOGIC;
  signal narrow_bram_addr_inc : STD_LOGIC;
  signal narrow_bram_addr_inc_d1 : STD_LOGIC;
  signal narrow_burst_cnt_ld_reg : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_11_in : STD_LOGIC;
  signal p_8_in : STD_LOGIC;
  signal \^s_axi_bid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_wready\ : STD_LOGIC;
  signal wr_data_sng_sm_cs : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal wrdata_reg_ld : STD_LOGIC;
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[12]_i_6\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[0]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[0]_i_5\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[0]_i_7\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_140__0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_15\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_32__0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_34__0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_46__0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_50\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT.narrow_addr_int[1]_i_56__0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \GEN_NARROW_EN.curr_narrow_burst_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.axi_wdata_full_reg_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \arb_sm_cs[1]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of axi_arready_int_i_4 : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of axi_wr_burst_i_2 : label is "soft_lutpair11";
begin
  DI(2 downto 0) <= \^di\(2 downto 0);
  O1 <= \^o1\;
  O3 <= \^o3\;
  O6 <= \^o6\;
  aw_active_d1 <= \^aw_active_d1\;
  axi_wdata_full_reg <= \^axi_wdata_full_reg\;
  s_axi_bid(0) <= \^s_axi_bid\(0);
  s_axi_wready <= \^s_axi_wready\;
\ADDR_SNG_PORT.bram_addr_int[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000002222222A"
    )
    port map (
      I0 => bram_addr_inc,
      I1 => curr_narrow_burst,
      I2 => narrow_bram_addr_inc_d1,
      I3 => narrow_addr_int(1),
      I4 => narrow_addr_int(0),
      I5 => curr_fixed_burst_reg,
      O => \^o6\
    );
\ADDR_SNG_PORT.bram_addr_int[12]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => wr_data_sng_sm_cs(0),
      I1 => s_axi_wvalid,
      I2 => wr_data_sng_sm_cs(1),
      O => bram_addr_inc
    );
BID_FIFO: entity work.ip_axi_bram_ctrlaxi_bram_ctrl_v3_0_SRL_FIFO
    port map (
      AW2Arb_BVALID_Cnt(2 downto 0) => AW2Arb_BVALID_Cnt(2 downto 0),
      I1 => \^aw_active_d1\,
      I2 => I2,
      I3 => \^o1\,
      I4 => \^axi_wdata_full_reg\,
      O1 => n_1_BID_FIFO,
      O2 => n_3_BID_FIFO,
      SR(0) => SR(0),
      axi_wdata_full_cmb16_out => axi_wdata_full_cmb16_out,
      axi_wr_burst => axi_wr_burst,
      bid_gets_fifo_load => bid_gets_fifo_load,
      bid_gets_fifo_load_d1 => bid_gets_fifo_load_d1,
      bvalid_cnt_inc0 => bvalid_cnt_inc0,
      p_1_out => p_1_out,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_bid(0) => \^s_axi_bid\(0),
      s_axi_bready => s_axi_bready,
      s_axi_wlast => s_axi_wlast,
      s_axi_wvalid => s_axi_wvalid,
      wr_data_sng_sm_cs(1 downto 0) => wr_data_sng_sm_cs(1 downto 0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A8080808A808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => narrow_addr_int(0),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_2\,
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_3\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\,
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_4\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_1\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCC3C6"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awaddr(1),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(1),
      O => \^di\(1)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(0),
      O => \^di\(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAAAAA"
    )
    port map (
      I0 => narrow_addr_ld_en,
      I1 => curr_narrow_burst,
      I2 => wr_data_sng_sm_cs(0),
      I3 => s_axi_wvalid,
      I4 => wr_data_sng_sm_cs(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_2\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"202F"
    )
    port map (
      I0 => narrow_burst_cnt_ld_reg(0),
      I1 => I40,
      I2 => narrow_addr_ld_en,
      I3 => narrow_addr_int(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_3\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6F6000006F60FFFF"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/bytes_per_addr\(0),
      I2 => I40,
      I3 => narrow_burst_cnt_ld_reg(0),
      I4 => narrow_addr_ld_en,
      I5 => narrow_addr_int(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_4\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF1F0010"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => p_1_out,
      I3 => \^aw_active_d1\,
      I4 => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\,
      O => narrow_burst_cnt_ld_reg(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \GEN_UA_NARROW.I_UA_NARROW/bytes_per_addr\(0)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => O(0),
      I1 => I1(0),
      I2 => s_axi_awsize(1),
      I3 => \^di\(1),
      I4 => s_axi_awsize(0),
      I5 => \^di\(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_8\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I5(0),
      I1 => I6(0),
      I2 => s_axi_awsize(1),
      I3 => I7(0),
      I4 => s_axi_awsize(0),
      I5 => I8(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_9\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A8080808A808"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => narrow_addr_int(1),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_2\,
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_3\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\,
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_5\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_1\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_27\,
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(1),
      I3 => I35(3),
      I4 => s_axi_awsize(0),
      I5 => I36(3),
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(31)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_100\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_139\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_140__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_141\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_142__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_100\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_101__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11111114"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(3),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(2),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_101__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_102\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11111421"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_102\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_103\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I23(1),
      I1 => I24(0),
      I2 => s_axi_awsize(1),
      I3 => I21(3),
      I4 => s_axi_awsize(0),
      I5 => I22(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_103\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_104__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I74(0),
      I2 => s_axi_awsize(0),
      I3 => I73(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_104__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_105\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I23(2),
      I1 => I24(1),
      I2 => s_axi_awsize(1),
      I3 => I25(0),
      I4 => s_axi_awsize(0),
      I5 => I22(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_105\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_106__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I74(1),
      I2 => s_axi_awsize(0),
      I3 => I73(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_106__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_107\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I19(3),
      I1 => I20(2),
      I2 => s_axi_awsize(1),
      I3 => I21(1),
      I4 => s_axi_awsize(0),
      I5 => I22(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_107\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_108__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I72(2),
      I2 => s_axi_awsize(0),
      I3 => I18(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_108__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_109\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I23(0),
      I1 => I20(3),
      I2 => s_axi_awsize(1),
      I3 => I21(2),
      I4 => s_axi_awsize(0),
      I5 => I22(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_109\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(30),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(31),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_11\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_110__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I72(3),
      I2 => s_axi_awsize(0),
      I3 => I73(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_110__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_111\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I19(1),
      I1 => I20(0),
      I2 => s_axi_awsize(1),
      I3 => I15(3),
      I4 => s_axi_awsize(0),
      I5 => I16(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_111\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_112__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I72(0),
      I2 => s_axi_awsize(0),
      I3 => I18(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_112__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_113\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I19(2),
      I1 => I20(1),
      I2 => s_axi_awsize(1),
      I3 => I21(0),
      I4 => s_axi_awsize(0),
      I5 => I16(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_113\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_114__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I72(1),
      I2 => s_axi_awsize(0),
      I3 => I18(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_114__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_115\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I13(3),
      I1 => I14(2),
      I2 => s_axi_awsize(1),
      I3 => I15(1),
      I4 => s_axi_awsize(0),
      I5 => I16(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_115\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_116__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
    port map (
      I0 => I68(3),
      I1 => I17(2),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_116__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_117\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_155\,
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(1),
      I3 => I17(3),
      I4 => s_axi_awsize(0),
      I5 => I18(0),
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(9)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_31\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_32__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_33\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_34__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_12\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_35\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_36__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_37\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_38__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_13\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_131\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000FC8"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awaddr(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awsize(2),
      O => \^di\(2)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_135\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I13(1),
      I1 => I14(0),
      I2 => s_axi_awsize(1),
      I3 => I11(3),
      I4 => s_axi_awsize(0),
      I5 => I12(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_135\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_136__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => I68(1),
      I3 => I17(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_136__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_137\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I13(2),
      I1 => I14(1),
      I2 => s_axi_awsize(1),
      I3 => I15(0),
      I4 => s_axi_awsize(0),
      I5 => I12(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_137\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_138__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => I68(2),
      I3 => I17(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_138__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_139\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I9(3),
      I1 => I10(2),
      I2 => s_axi_awsize(1),
      I3 => I11(1),
      I4 => s_axi_awsize(0),
      I5 => I12(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_139\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_39\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_40__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_41\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_42__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_14\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_140__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FA72D850"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => I70(3),
      I4 => I86(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_140__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_141\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I13(0),
      I1 => I10(3),
      I2 => s_axi_awsize(1),
      I3 => I11(2),
      I4 => s_axi_awsize(0),
      I5 => I12(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_141\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_142__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C480"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => I68(0),
      I3 => I86(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_142__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"666669C6"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_15\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_155\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I19(0),
      I1 => I14(3),
      I2 => s_axi_awsize(1),
      I3 => I15(2),
      I4 => s_axi_awsize(0),
      I5 => I16(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_155\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_162__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => I70(2),
      I3 => I86(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_162__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_163\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I9(2),
      I1 => I10(1),
      I2 => s_axi_awsize(1),
      I3 => I11(0),
      I4 => s_axi_awsize(0),
      I5 => I8(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_163\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_164__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B391A280"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => I70(1),
      I3 => I86(0),
      I4 => \^di\(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_164__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_165\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I9(1),
      I1 => I10(0),
      I2 => s_axi_awsize(1),
      I3 => I7(2),
      I4 => s_axi_awsize(0),
      I5 => I8(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_165\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_16__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFE680"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_44\,
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_45\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_46__0\,
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_47\,
      O => O10
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3E02FFFF"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_48\,
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(1),
      I3 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_49\,
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_50\,
      O => O9
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_18__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0A0E0E0E"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_51\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_52\,
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(1),
      O => O13
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFFEFEFEAAAEAEAE"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/curr_axlen_unsigned_lshift025_in\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_54\,
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(1),
      I5 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_55\,
      O => O8
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAAAAA"
    )
    port map (
      I0 => narrow_addr_ld_en,
      I1 => curr_narrow_burst,
      I2 => wr_data_sng_sm_cs(0),
      I3 => s_axi_wvalid,
      I4 => wr_data_sng_sm_cs(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_2\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_23\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_62\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_63__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_64\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_65__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_23\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_24\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_66\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_67__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_68\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_69__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_24\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_25\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_70\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_71__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_72\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_73__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_25\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_26\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_74\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_75__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_76\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_77__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_26\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(3),
      I4 => s_axi_awsize(0),
      I5 => I34(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_27\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2F20202F"
    )
    port map (
      I0 => narrow_burst_cnt_ld_reg(1),
      I1 => I40,
      I2 => narrow_addr_ld_en,
      I3 => narrow_addr_int(0),
      I4 => narrow_addr_int(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_3\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_30\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_84\,
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(1),
      I3 => I35(3),
      I4 => s_axi_awsize(0),
      I5 => I36(3),
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(30)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(3),
      I4 => s_axi_awsize(0),
      I5 => I34(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_31\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_32__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I35(2),
      I2 => s_axi_awsize(0),
      I3 => I36(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_32__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_33\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(3),
      I4 => s_axi_awsize(0),
      I5 => I34(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_33\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_34__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I35(3),
      I2 => s_axi_awsize(0),
      I3 => I36(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_34__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_35\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(3),
      I4 => s_axi_awsize(0),
      I5 => I34(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_35\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_36__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I35(0),
      I2 => s_axi_awsize(0),
      I3 => I36(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_36__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_37\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(3),
      I4 => s_axi_awsize(0),
      I5 => I34(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_37\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_38__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I35(1),
      I2 => s_axi_awsize(0),
      I3 => I36(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_38__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_39\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(2),
      I2 => s_axi_awsize(1),
      I3 => I33(1),
      I4 => s_axi_awsize(0),
      I5 => I34(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_39\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_40__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I78(2),
      I2 => s_axi_awsize(0),
      I3 => I77(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_40__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_41\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(2),
      I4 => s_axi_awsize(0),
      I5 => I34(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_41\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_42__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I78(3),
      I2 => s_axi_awsize(0),
      I3 => I36(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_42__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_44\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(2),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_44\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_45\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(6),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_45\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_46__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACACAA0"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_87\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_88\,
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_46__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_47\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CAA0A0A0"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_89\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_90\,
      I2 => s_axi_awsize(2),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_47\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_48\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(6),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_48\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_49\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0AFCFCFA0A0C0C"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(2),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_49\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8FFB800B800B8FF"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_15\,
      I1 => I40,
      I2 => narrow_burst_cnt_ld_reg(1),
      I3 => narrow_addr_ld_en,
      I4 => narrow_addr_int(0),
      I5 => narrow_addr_int(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_5\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_50\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FD54FD57"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_91\,
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_92\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_50\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_52\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(2),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_52\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_54\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(6),
      I5 => s_axi_awlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_54\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_55\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(2),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_55\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_56__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => curr_ua_narrow_wrap4
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_58\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_103\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_104__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_105\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_106__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_58\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_59\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_107\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_108__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_109\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_110__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_59\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAEAEAAAEAEAEAE"
    )
    port map (
      I0 => n_11_I_WRAP_BRST,
      I1 => p_1_out,
      I2 => \^aw_active_d1\,
      I3 => s_axi_awsize(2),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awsize(1),
      O => narrow_addr_ld_en
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_60\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_111\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_112__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_113\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_114__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_60\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_61\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0047"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_115\,
      I1 => s_axi_awsize(2),
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_116__0\,
      I3 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(9),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_61\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_62\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(1),
      I1 => I32(0),
      I2 => s_axi_awsize(1),
      I3 => I29(3),
      I4 => s_axi_awsize(0),
      I5 => I30(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_62\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_63__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I78(0),
      I2 => s_axi_awsize(0),
      I3 => I77(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_63__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_64\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(2),
      I1 => I32(1),
      I2 => s_axi_awsize(1),
      I3 => I33(0),
      I4 => s_axi_awsize(0),
      I5 => I30(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_64\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_65__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I78(1),
      I2 => s_axi_awsize(0),
      I3 => I77(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_65__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_66\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I27(3),
      I1 => I28(2),
      I2 => s_axi_awsize(1),
      I3 => I29(1),
      I4 => s_axi_awsize(0),
      I5 => I30(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_66\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_67__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I76(2),
      I2 => s_axi_awsize(0),
      I3 => I75(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_67__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_68\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(0),
      I1 => I28(3),
      I2 => s_axi_awsize(1),
      I3 => I29(2),
      I4 => s_axi_awsize(0),
      I5 => I30(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_68\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_69__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I76(3),
      I2 => s_axi_awsize(0),
      I3 => I77(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_69__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF01FF00000100"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => p_1_out,
      I4 => \^aw_active_d1\,
      I5 => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\,
      O => narrow_burst_cnt_ld_reg(1)
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_70\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I27(1),
      I1 => I28(0),
      I2 => s_axi_awsize(1),
      I3 => I25(3),
      I4 => s_axi_awsize(0),
      I5 => I26(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_70\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_71__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I76(0),
      I2 => s_axi_awsize(0),
      I3 => I75(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_71__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_72\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I27(2),
      I1 => I28(1),
      I2 => s_axi_awsize(1),
      I3 => I29(0),
      I4 => s_axi_awsize(0),
      I5 => I26(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_72\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_73__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I76(1),
      I2 => s_axi_awsize(0),
      I3 => I75(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_73__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_74\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I23(3),
      I1 => I24(2),
      I2 => s_axi_awsize(1),
      I3 => I25(1),
      I4 => s_axi_awsize(0),
      I5 => I26(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_74\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_75__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I74(2),
      I2 => s_axi_awsize(0),
      I3 => I73(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_75__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_76\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I27(0),
      I1 => I24(3),
      I2 => s_axi_awsize(1),
      I3 => I25(2),
      I4 => s_axi_awsize(0),
      I5 => I26(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_76\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_77__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => I74(3),
      I2 => s_axi_awsize(0),
      I3 => I75(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_77__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_84\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I31(3),
      I1 => I32(3),
      I2 => s_axi_awsize(1),
      I3 => I33(3),
      I4 => s_axi_awsize(0),
      I5 => I34(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_84\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_85__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AACCAACCFFF000F0"
    )
    port map (
      I0 => I70(0),
      I1 => I1(1),
      I2 => \^di\(1),
      I3 => s_axi_awsize(0),
      I4 => \^di\(2),
      I5 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_85__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_86\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => I9(0),
      I1 => I6(1),
      I2 => s_axi_awsize(1),
      I3 => I7(1),
      I4 => s_axi_awsize(0),
      I5 => I8(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_86\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_87\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(6),
      I1 => s_axi_awlen(7),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(4),
      I5 => s_axi_awlen(5),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_87\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_88\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(2),
      I1 => s_axi_awlen(3),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(0),
      I5 => s_axi_awlen(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_88\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_89\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(6),
      I5 => s_axi_awlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_89\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_90\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(2),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_90\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_91\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(2),
      I1 => s_axi_awlen(3),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(0),
      I5 => s_axi_awlen(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_91\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_92\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACFFAC00ACF0AC0"
    )
    port map (
      I0 => s_axi_awlen(6),
      I1 => s_axi_awlen(7),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      I4 => s_axi_awlen(4),
      I5 => s_axi_awlen(5),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_92\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_93__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(2),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_93__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_94\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(6),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_94\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_95\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(6),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(7),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_95\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_96\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => s_axi_awlen(0),
      I1 => s_axi_awlen(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awlen(2),
      I4 => s_axi_awsize(0),
      I5 => s_axi_awlen(3),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_96\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_97__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(3),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(2),
      I4 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_97__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_98\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000310"
    )
    port map (
      I0 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      I1 => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      I2 => s_axi_awsize(1),
      I3 => s_axi_awsize(0),
      I4 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_98\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_99\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05000533"
    )
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_135\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_136__0\,
      I2 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_137\,
      I3 => s_axi_awsize(2),
      I4 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_138__0\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_99\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_1\,
      Q => narrow_addr_int(0),
      R => \<const0>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_6\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_8\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_9\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(0),
      S => s_axi_awsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_1\,
      Q => narrow_addr_int(1),
      R => \<const0>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133__0\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_162__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_163\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(3),
      S => s_axi_awsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_134\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_164__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_165\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(2),
      S => s_axi_awsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_58\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_59\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_60\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_61\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4\,
      CYINIT => \<const0>\,
      DI(3) => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(31),
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_4_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_11\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_12\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_13\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_14\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_43\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_85__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_86\,
      O => \GEN_UA_NARROW.I_UA_NARROW/narrow_addr_offset\(1),
      S => s_axi_awsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_51\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_93__0\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_94\,
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_51\,
      S => s_axi_awsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_53\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_95\,
      I1 => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_96\,
      O => \GEN_UA_NARROW.I_UA_NARROW/curr_axlen_unsigned_lshift025_in\,
      S => s_axi_awsize(2)
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_97__0\,
      DI(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_98\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_57_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_99\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_100\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_101__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_102\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_22\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_9_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_23\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_24\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_25\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_26\
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000002000"
    )
    port map (
      I0 => curr_narrow_burst,
      I1 => wr_data_sng_sm_cs(0),
      I2 => s_axi_wvalid,
      I3 => wr_data_sng_sm_cs(1),
      I4 => narrow_addr_int(1),
      I5 => narrow_addr_int(0),
      O => narrow_bram_addr_inc
    );
\GEN_NARROW_CNT.narrow_bram_addr_inc_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => narrow_bram_addr_inc,
      Q => narrow_bram_addr_inc_d1,
      R => SR(0)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1\
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[0]_i_1\,
      Q => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[0]\,
      R => SR(0)
    );
\GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => I2,
      D => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg[1]_i_1\,
      Q => \n_0_GEN_NARROW_CNT_LD.narrow_burst_cnt_ld_reg_reg[1]\,
      R => SR(0)
    );
\GEN_NARROW_EN.axi_wlast_d1_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => s_axi_wlast,
      I1 => s_axi_wvalid,
      I2 => \^s_axi_wready\,
      O => p_11_in
    );
\GEN_NARROW_EN.axi_wlast_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => p_11_in,
      Q => axi_wlast_d1,
      R => SR(0)
    );
\GEN_NARROW_EN.curr_narrow_burst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0A0A0C0C000A0"
    )
    port map (
      I0 => curr_narrow_burst,
      I1 => curr_narrow_burst_cmb,
      I2 => s_axi_aresetn,
      I3 => p_11_in,
      I4 => curr_narrow_burst_en,
      I5 => axi_wlast_d1,
      O => \n_0_GEN_NARROW_EN.curr_narrow_burst_i_1\
    );
\GEN_NARROW_EN.curr_narrow_burst_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => curr_narrow_burst_cmb
    );
\GEN_NARROW_EN.curr_narrow_burst_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => s_axi_awlen(4),
      I1 => s_axi_awlen(5),
      I2 => s_axi_awlen(1),
      I3 => s_axi_awlen(3),
      I4 => s_axi_awlen(2),
      I5 => s_axi_awlen(0),
      O => O12
    );
\GEN_NARROW_EN.curr_narrow_burst_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_NARROW_EN.curr_narrow_burst_i_1\,
      Q => curr_narrow_burst,
      R => \<const0>\
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.axi_wdata_full_reg_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F088DC"
    )
    port map (
      I0 => wr_data_sng_sm_cs(0),
      I1 => s_axi_wvalid,
      I2 => \^axi_wdata_full_reg\,
      I3 => p_1_out,
      I4 => wr_data_sng_sm_cs(1),
      O => axi_wdata_full_cmb
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.axi_wdata_full_reg_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => axi_wdata_full_cmb,
      Q => \^axi_wdata_full_reg\,
      R => SR(0)
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAE0"
    )
    port map (
      I0 => s_axi_wvalid,
      I1 => \^axi_wdata_full_reg\,
      I2 => p_1_out,
      I3 => wr_data_sng_sm_cs(1),
      I4 => wr_data_sng_sm_cs(0),
      O => \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_i_1\
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_i_1\,
      Q => p_8_in,
      R => SR(0)
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.clr_bram_we_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_1_BID_FIFO,
      Q => clr_bram_we,
      R => SR(0)
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3320002000200020"
    )
    port map (
      I0 => bvalid_cnt_inc0,
      I1 => wr_data_sng_sm_cs(0),
      I2 => axi_wdata_full_cmb16_out,
      I3 => wr_data_sng_sm_cs(1),
      I4 => s_axi_wlast,
      I5 => s_axi_wvalid,
      O => \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1\
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010331033103310"
    )
    port map (
      I0 => bvalid_cnt_inc0,
      I1 => wr_data_sng_sm_cs(0),
      I2 => axi_wdata_full_cmb16_out,
      I3 => wr_data_sng_sm_cs(1),
      I4 => s_axi_wlast,
      I5 => s_axi_wvalid,
      O => \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1\
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1\,
      Q => wr_data_sng_sm_cs(0),
      R => SR(0)
    );
\GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1\,
      Q => wr_data_sng_sm_cs(1),
      R => SR(0)
    );
\GEN_WRDATA[0].bram_wrdata_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(0),
      Q => bram_wrdata_a(0),
      R => \<const0>\
    );
\GEN_WRDATA[10].bram_wrdata_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(10),
      Q => bram_wrdata_a(10),
      R => \<const0>\
    );
\GEN_WRDATA[11].bram_wrdata_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(11),
      Q => bram_wrdata_a(11),
      R => \<const0>\
    );
\GEN_WRDATA[12].bram_wrdata_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(12),
      Q => bram_wrdata_a(12),
      R => \<const0>\
    );
\GEN_WRDATA[13].bram_wrdata_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(13),
      Q => bram_wrdata_a(13),
      R => \<const0>\
    );
\GEN_WRDATA[14].bram_wrdata_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(14),
      Q => bram_wrdata_a(14),
      R => \<const0>\
    );
\GEN_WRDATA[15].bram_wrdata_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(15),
      Q => bram_wrdata_a(15),
      R => \<const0>\
    );
\GEN_WRDATA[16].bram_wrdata_int_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(16),
      Q => bram_wrdata_a(16),
      R => \<const0>\
    );
\GEN_WRDATA[17].bram_wrdata_int_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(17),
      Q => bram_wrdata_a(17),
      R => \<const0>\
    );
\GEN_WRDATA[18].bram_wrdata_int_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(18),
      Q => bram_wrdata_a(18),
      R => \<const0>\
    );
\GEN_WRDATA[19].bram_wrdata_int_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(19),
      Q => bram_wrdata_a(19),
      R => \<const0>\
    );
\GEN_WRDATA[1].bram_wrdata_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(1),
      Q => bram_wrdata_a(1),
      R => \<const0>\
    );
\GEN_WRDATA[20].bram_wrdata_int_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(20),
      Q => bram_wrdata_a(20),
      R => \<const0>\
    );
\GEN_WRDATA[21].bram_wrdata_int_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(21),
      Q => bram_wrdata_a(21),
      R => \<const0>\
    );
\GEN_WRDATA[22].bram_wrdata_int_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(22),
      Q => bram_wrdata_a(22),
      R => \<const0>\
    );
\GEN_WRDATA[23].bram_wrdata_int_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(23),
      Q => bram_wrdata_a(23),
      R => \<const0>\
    );
\GEN_WRDATA[24].bram_wrdata_int_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(24),
      Q => bram_wrdata_a(24),
      R => \<const0>\
    );
\GEN_WRDATA[25].bram_wrdata_int_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(25),
      Q => bram_wrdata_a(25),
      R => \<const0>\
    );
\GEN_WRDATA[26].bram_wrdata_int_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(26),
      Q => bram_wrdata_a(26),
      R => \<const0>\
    );
\GEN_WRDATA[27].bram_wrdata_int_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(27),
      Q => bram_wrdata_a(27),
      R => \<const0>\
    );
\GEN_WRDATA[28].bram_wrdata_int_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(28),
      Q => bram_wrdata_a(28),
      R => \<const0>\
    );
\GEN_WRDATA[29].bram_wrdata_int_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(29),
      Q => bram_wrdata_a(29),
      R => \<const0>\
    );
\GEN_WRDATA[2].bram_wrdata_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(2),
      Q => bram_wrdata_a(2),
      R => \<const0>\
    );
\GEN_WRDATA[30].bram_wrdata_int_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(30),
      Q => bram_wrdata_a(30),
      R => \<const0>\
    );
\GEN_WRDATA[31].bram_wrdata_int[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6700"
    )
    port map (
      I0 => wr_data_sng_sm_cs(0),
      I1 => wr_data_sng_sm_cs(1),
      I2 => \^axi_wdata_full_reg\,
      I3 => s_axi_wvalid,
      O => wrdata_reg_ld
    );
\GEN_WRDATA[31].bram_wrdata_int_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(31),
      Q => bram_wrdata_a(31),
      R => \<const0>\
    );
\GEN_WRDATA[3].bram_wrdata_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(3),
      Q => bram_wrdata_a(3),
      R => \<const0>\
    );
\GEN_WRDATA[4].bram_wrdata_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(4),
      Q => bram_wrdata_a(4),
      R => \<const0>\
    );
\GEN_WRDATA[5].bram_wrdata_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(5),
      Q => bram_wrdata_a(5),
      R => \<const0>\
    );
\GEN_WRDATA[6].bram_wrdata_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(6),
      Q => bram_wrdata_a(6),
      R => \<const0>\
    );
\GEN_WRDATA[7].bram_wrdata_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(7),
      Q => bram_wrdata_a(7),
      R => \<const0>\
    );
\GEN_WRDATA[8].bram_wrdata_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(8),
      Q => bram_wrdata_a(8),
      R => \<const0>\
    );
\GEN_WRDATA[9].bram_wrdata_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wdata(9),
      Q => bram_wrdata_a(9),
      R => \<const0>\
    );
\GEN_WR_NO_ECC.bram_we_int[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"98FF0000FFFFFFFF"
    )
    port map (
      I0 => wr_data_sng_sm_cs(0),
      I1 => wr_data_sng_sm_cs(1),
      I2 => \^axi_wdata_full_reg\,
      I3 => s_axi_wvalid,
      I4 => clr_bram_we,
      I5 => s_axi_aresetn,
      O => \n_0_GEN_WR_NO_ECC.bram_we_int[3]_i_1\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wstrb(0),
      Q => Q(0),
      R => \n_0_GEN_WR_NO_ECC.bram_we_int[3]_i_1\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wstrb(1),
      Q => Q(1),
      R => \n_0_GEN_WR_NO_ECC.bram_we_int[3]_i_1\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wstrb(2),
      Q => Q(2),
      R => \n_0_GEN_WR_NO_ECC.bram_we_int[3]_i_1\
    );
\GEN_WR_NO_ECC.bram_we_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => wrdata_reg_ld,
      D => s_axi_wstrb(3),
      Q => Q(3),
      R => \n_0_GEN_WR_NO_ECC.bram_we_int[3]_i_1\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
I_WRAP_BRST: entity work.ip_axi_bram_ctrlwrap_brst_0
    port map (
      D(9 downto 0) => D(9 downto 0),
      I1 => \^aw_active_d1\,
      I2 => I2,
      I3 => I3,
      I37 => I37,
      I38 => I38,
      I39 => I39,
      O1 => n_11_I_WRAP_BRST,
      O2 => n_13_I_WRAP_BRST,
      O3 => n_15_I_WRAP_BRST,
      O4 => O4,
      O5 => O5,
      O6 => \^o6\,
      SR(0) => SR(0),
      bram_addr_inc => bram_addr_inc,
      curr_fixed_burst_reg => curr_fixed_burst_reg,
      curr_narrow_burst => curr_narrow_burst,
      curr_wrap_burst_reg => curr_wrap_burst_reg,
      narrow_addr_int(1 downto 0) => narrow_addr_int(1 downto 0),
      narrow_bram_addr_inc_d1 => narrow_bram_addr_inc_d1,
      p_1_out => p_1_out,
      p_3_in => p_3_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awaddr(9 downto 0) => s_axi_awaddr(11 downto 2),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awlen(3 downto 0) => s_axi_awlen(3 downto 0),
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_wvalid => s_axi_wvalid,
      wr_data_sng_sm_cs(1 downto 0) => wr_data_sng_sm_cs(1 downto 0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\arb_sm_cs[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_data_sng_sm_cs(0),
      I1 => wr_data_sng_sm_cs(1),
      O => O11
    );
aw_active_d1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => p_1_out,
      Q => \^aw_active_d1\,
      R => SR(0)
    );
axi_arready_int_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => wr_data_sng_sm_cs(1),
      I1 => wr_data_sng_sm_cs(0),
      I2 => s_axi_arvalid,
      O => last_arb_won_cmb6_out
    );
axi_awready_int_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D555"
    )
    port map (
      I0 => s_axi_awvalid,
      I1 => AW2Arb_BVALID_Cnt(2),
      I2 => AW2Arb_BVALID_Cnt(0),
      I3 => AW2Arb_BVALID_Cnt(1),
      O => \^o3\
    );
\axi_bid_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_3_BID_FIFO,
      Q => \^s_axi_bid\(0),
      R => \<const0>\
    );
axi_bvalid_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAA8AAA88"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => n_1_BID_FIFO,
      I2 => bvalid_cnt_dec20_out,
      I3 => AW2Arb_BVALID_Cnt(1),
      I4 => AW2Arb_BVALID_Cnt(0),
      I5 => AW2Arb_BVALID_Cnt(2),
      O => n_0_axi_bvalid_int_i_1
    );
axi_bvalid_int_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA80000"
    )
    port map (
      I0 => s_axi_bready,
      I1 => AW2Arb_BVALID_Cnt(1),
      I2 => AW2Arb_BVALID_Cnt(2),
      I3 => AW2Arb_BVALID_Cnt(0),
      I4 => \^o1\,
      O => bvalid_cnt_dec20_out
    );
axi_bvalid_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_bvalid_int_i_1,
      Q => \^o1\,
      R => \<const0>\
    );
axi_wr_burst_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08A8"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => axi_wr_burst,
      I2 => n_0_axi_wr_burst_i_2,
      I3 => s_axi_wlast,
      O => n_0_axi_wr_burst_i_1
    );
axi_wr_burst_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAE2"
    )
    port map (
      I0 => s_axi_wvalid,
      I1 => \^axi_wdata_full_reg\,
      I2 => p_1_out,
      I3 => wr_data_sng_sm_cs(0),
      I4 => wr_data_sng_sm_cs(1),
      O => n_0_axi_wr_burst_i_2
    );
axi_wr_burst_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_wr_burst_i_1,
      Q => axi_wr_burst,
      R => \<const0>\
    );
axi_wready_int_mod_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008822AA20A820AA"
    )
    port map (
      I0 => s_axi_aresetn,
      I1 => wr_data_sng_sm_cs(1),
      I2 => p_1_out,
      I3 => \^axi_wdata_full_reg\,
      I4 => s_axi_wvalid,
      I5 => wr_data_sng_sm_cs(0),
      O => n_0_axi_wready_int_mod_i_1
    );
axi_wready_int_mod_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_0_axi_wready_int_mod_i_1,
      Q => \^s_axi_wready\,
      R => \<const0>\
    );
bid_gets_fifo_load_d1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => bid_gets_fifo_load,
      Q => bid_gets_fifo_load_d1,
      R => SR(0)
    );
bram_en_a_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => p_8_in,
      I1 => p_7_in,
      O => bram_en_a
    );
\bvalid_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9999666A5555AAAA"
    )
    port map (
      I0 => n_1_BID_FIFO,
      I1 => s_axi_bready,
      I2 => AW2Arb_BVALID_Cnt(1),
      I3 => AW2Arb_BVALID_Cnt(2),
      I4 => AW2Arb_BVALID_Cnt(0),
      I5 => \^o1\,
      O => \n_0_bvalid_cnt[0]_i_1\
    );
\bvalid_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D2D2B4B05A5AF0F0"
    )
    port map (
      I0 => n_1_BID_FIFO,
      I1 => s_axi_bready,
      I2 => AW2Arb_BVALID_Cnt(1),
      I3 => AW2Arb_BVALID_Cnt(2),
      I4 => AW2Arb_BVALID_Cnt(0),
      I5 => \^o1\,
      O => \n_0_bvalid_cnt[1]_i_1\
    );
\bvalid_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DF20FB005FA0FF00"
    )
    port map (
      I0 => n_1_BID_FIFO,
      I1 => s_axi_bready,
      I2 => AW2Arb_BVALID_Cnt(1),
      I3 => AW2Arb_BVALID_Cnt(2),
      I4 => AW2Arb_BVALID_Cnt(0),
      I5 => \^o1\,
      O => \n_0_bvalid_cnt[2]_i_1\
    );
\bvalid_cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_bvalid_cnt[0]_i_1\,
      Q => AW2Arb_BVALID_Cnt(0),
      R => SR(0)
    );
\bvalid_cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_bvalid_cnt[1]_i_1\,
      Q => AW2Arb_BVALID_Cnt(1),
      R => SR(0)
    );
\bvalid_cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_bvalid_cnt[2]_i_1\,
      Q => AW2Arb_BVALID_Cnt(2),
      R => SR(0)
    );
curr_fixed_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_13_I_WRAP_BRST,
      Q => curr_fixed_burst_reg,
      R => \<const0>\
    );
curr_wrap_burst_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => n_15_I_WRAP_BRST,
      Q => curr_wrap_burst_reg,
      R => \<const0>\
    );
last_arb_won_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"40FF400040FF40FF"
    )
    port map (
      I0 => wr_data_sng_sm_cs(1),
      I1 => wr_data_sng_sm_cs(0),
      I2 => s_axi_arvalid,
      I3 => arb_sm_cs(0),
      I4 => I4,
      I5 => \^o3\,
      O => O2
    );
last_arb_won_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000004F000000"
    )
    port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_arvalid,
      I2 => \^o3\,
      I3 => s_axi_rready,
      I4 => I41,
      I5 => arb_sm_cs(0),
      O => O7
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlfull_axi is
  port (
    O1 : out STD_LOGIC;
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    O2 : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    O3 : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    DI : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O4 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O10 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    bram_addr_a : out STD_LOGIC_VECTOR ( 4 downto 0 );
    bram_en_a : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    O : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I5 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I7 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I8 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I9 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I10 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I11 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I12 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I13 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I14 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I15 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I16 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I17 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I18 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I19 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I20 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I21 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I22 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I23 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I24 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I25 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I26 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I27 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I28 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I29 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I30 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I31 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I32 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I33 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I34 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I35 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I36 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I37 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I38 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I39 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I40 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I41 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I42 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I43 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I44 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I45 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I46 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I47 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I48 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I49 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I50 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I51 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I52 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I53 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I54 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I55 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I56 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I57 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I58 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I59 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I60 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I61 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I62 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I63 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I64 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I65 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I66 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I67 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I68 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I69 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I70 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I71 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I72 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I73 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I74 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I75 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I76 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I77 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I78 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I79 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I80 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I81 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I82 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I83 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I84 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I85 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I86 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I87 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end ip_axi_bram_ctrlfull_axi;

architecture STRUCTURE of ip_axi_bram_ctrlfull_axi is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal AR2Arb_Active_Clr : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW/curr_ua_narrow_wrap4\ : STD_LOGIC;
  signal \GEN_UA_NARROW.I_UA_NARROW/curr_ua_narrow_wrap4_0\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o10\ : STD_LOGIC;
  signal \^o11\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC;
  signal \^o7\ : STD_LOGIC;
  signal \^o8\ : STD_LOGIC;
  signal \^o9\ : STD_LOGIC;
  signal RdChnl_BRAM_Addr_Ld : STD_LOGIC_VECTOR ( 10 to 10 );
  signal ar_active_d1 : STD_LOGIC;
  signal arb_sm_cs : STD_LOGIC_VECTOR ( 1 to 1 );
  signal aw_active_d1 : STD_LOGIC;
  signal axi_rd_burst1 : STD_LOGIC;
  signal axi_wdata_full_cmb16_out : STD_LOGIC;
  signal axi_wdata_full_reg : STD_LOGIC;
  signal \^bram_addr_a\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal curr_narrow_burst : STD_LOGIC;
  signal curr_narrow_burst_cmb : STD_LOGIC;
  signal curr_narrow_burst_en : STD_LOGIC;
  signal last_arb_won_cmb6_out : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[10]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[10]_i_3\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[12]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[2]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[3]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[4]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[4]_i_3\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[5]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[5]_i_3\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[6]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[6]_i_3\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[7]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[7]_i_3\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_3\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[9]_i_1\ : STD_LOGIC;
  signal \n_0_ADDR_SNG_PORT.bram_addr_int[9]_i_3\ : STD_LOGIC;
  signal \n_10_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal \n_16_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal \n_17_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal \n_18_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal n_38_I_RD_CHNL : STD_LOGIC;
  signal n_43_I_RD_CHNL : STD_LOGIC;
  signal n_44_I_RD_CHNL : STD_LOGIC;
  signal n_45_I_RD_CHNL : STD_LOGIC;
  signal n_46_I_RD_CHNL : STD_LOGIC;
  signal n_47_I_RD_CHNL : STD_LOGIC;
  signal n_48_I_RD_CHNL : STD_LOGIC;
  signal n_49_I_RD_CHNL : STD_LOGIC;
  signal n_50_I_RD_CHNL : STD_LOGIC;
  signal n_51_I_RD_CHNL : STD_LOGIC;
  signal n_51_I_WR_CHNL : STD_LOGIC;
  signal n_52_I_RD_CHNL : STD_LOGIC;
  signal n_52_I_WR_CHNL : STD_LOGIC;
  signal n_53_I_RD_CHNL : STD_LOGIC;
  signal n_54_I_RD_CHNL : STD_LOGIC;
  signal n_55_I_RD_CHNL : STD_LOGIC;
  signal n_55_I_WR_CHNL : STD_LOGIC;
  signal n_56_I_RD_CHNL : STD_LOGIC;
  signal n_57_I_WR_CHNL : STD_LOGIC;
  signal n_58_I_WR_CHNL : STD_LOGIC;
  signal n_59_I_WR_CHNL : STD_LOGIC;
  signal \n_5_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal n_60_I_WR_CHNL : STD_LOGIC;
  signal n_61_I_WR_CHNL : STD_LOGIC;
  signal n_62_I_RD_CHNL : STD_LOGIC;
  signal n_62_I_WR_CHNL : STD_LOGIC;
  signal n_63_I_RD_CHNL : STD_LOGIC;
  signal n_63_I_WR_CHNL : STD_LOGIC;
  signal n_64_I_RD_CHNL : STD_LOGIC;
  signal n_64_I_WR_CHNL : STD_LOGIC;
  signal n_65_I_RD_CHNL : STD_LOGIC;
  signal n_65_I_WR_CHNL : STD_LOGIC;
  signal n_66_I_RD_CHNL : STD_LOGIC;
  signal n_67_I_RD_CHNL : STD_LOGIC;
  signal n_68_I_RD_CHNL : STD_LOGIC;
  signal n_69_I_RD_CHNL : STD_LOGIC;
  signal \n_6_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal n_70_I_RD_CHNL : STD_LOGIC;
  signal n_71_I_RD_CHNL : STD_LOGIC;
  signal n_72_I_RD_CHNL : STD_LOGIC;
  signal \n_9_GEN_ARB.I_SNG_PORT\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal p_1_out : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_5_out : STD_LOGIC;
  signal p_6_in : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal p_7_in : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 9 to 9 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[10]_i_3\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[11]_i_3\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[4]_i_3\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[5]_i_3\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[6]_i_3\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \ADDR_SNG_PORT.bram_addr_int[7]_i_3\ : label is "soft_lutpair68";
begin
  O1 <= \^o1\;
  O10 <= \^o10\;
  O11 <= \^o11\;
  O3 <= \^o3\;
  O5 <= \^o5\;
  O7 <= \^o7\;
  O8 <= \^o8\;
  O9 <= \^o9\;
  bram_addr_a(4 downto 0) <= \^bram_addr_a\(4 downto 0);
\ADDR_SNG_PORT.bram_addr_int[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^bram_addr_a\(2),
      I1 => n_48_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[10]_i_3\,
      I4 => n_71_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[10]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[10]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \^o10\,
      I1 => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_3\,
      I2 => \^o11\,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[10]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FBF80B08"
    )
    port map (
      I0 => \^bram_addr_a\(3),
      I1 => n_47_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => plusOp(9),
      I4 => n_72_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[11]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => \^o10\,
      I1 => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_3\,
      I2 => \^o11\,
      I3 => \^bram_addr_a\(2),
      I4 => \^bram_addr_a\(3),
      O => plusOp(9)
    );
\ADDR_SNG_PORT.bram_addr_int[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE22E22"
    )
    port map (
      I0 => \^bram_addr_a\(4),
      I1 => n_46_I_RD_CHNL,
      I2 => p_0_out,
      I3 => p_1_in(9),
      I4 => RdChnl_BRAM_Addr_Ld(10),
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[12]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000F909"
    )
    port map (
      I0 => \^o5\,
      I1 => n_56_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => n_45_I_RD_CHNL,
      I4 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[2]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^o8\,
      I1 => n_55_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \^o5\,
      I4 => n_44_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[3]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^o9\,
      I1 => n_54_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[4]_i_3\,
      I4 => n_43_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[4]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^o8\,
      I1 => \^o5\,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[4]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^o7\,
      I1 => n_53_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[5]_i_3\,
      I4 => n_38_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[5]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \^o9\,
      I1 => \^o5\,
      I2 => \^o8\,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[5]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^bram_addr_a\(0),
      I1 => n_52_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[6]_i_3\,
      I4 => n_67_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[6]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[6]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \^o7\,
      I1 => \^o8\,
      I2 => \^o5\,
      I3 => \^o9\,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[6]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^bram_addr_a\(1),
      I1 => n_51_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[7]_i_3\,
      I4 => n_68_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[7]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
    port map (
      I0 => \^bram_addr_a\(0),
      I1 => \^o9\,
      I2 => \^o5\,
      I3 => \^o8\,
      I4 => \^o7\,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[7]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^o11\,
      I1 => n_50_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_3\,
      I4 => n_69_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => \^bram_addr_a\(1),
      I1 => \^o7\,
      I2 => \^o8\,
      I3 => \^o5\,
      I4 => \^o9\,
      I5 => \^bram_addr_a\(0),
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F9FA090A"
    )
    port map (
      I0 => \^o10\,
      I1 => n_49_I_RD_CHNL,
      I2 => n_46_I_RD_CHNL,
      I3 => \n_0_ADDR_SNG_PORT.bram_addr_int[9]_i_3\,
      I4 => n_70_I_RD_CHNL,
      I5 => n_57_I_WR_CHNL,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[9]_i_1\
    );
\ADDR_SNG_PORT.bram_addr_int[9]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^o11\,
      I1 => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_3\,
      O => \n_0_ADDR_SNG_PORT.bram_addr_int[9]_i_3\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[10]_i_1\,
      Q => \^bram_addr_a\(2),
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[11]_i_1\,
      Q => \^bram_addr_a\(3),
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[12]_i_1\,
      Q => \^bram_addr_a\(4),
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[2]_i_1\,
      Q => \^o5\,
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[3]_i_1\,
      Q => \^o8\,
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[4]_i_1\,
      Q => \^o9\,
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[5]_i_1\,
      Q => \^o7\,
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[6]_i_1\,
      Q => \^bram_addr_a\(0),
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[7]_i_1\,
      Q => \^bram_addr_a\(1),
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[8]_i_1\,
      Q => \^o11\,
      R => \<const0>\
    );
\ADDR_SNG_PORT.bram_addr_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_axi_aclk,
      CE => \<const1>\,
      D => \n_0_ADDR_SNG_PORT.bram_addr_int[9]_i_1\,
      Q => \^o10\,
      R => \<const0>\
    );
\GEN_ARB.I_SNG_PORT\: entity work.ip_axi_bram_ctrlsng_port_arb
    port map (
      AR2Arb_Active_Clr => AR2Arb_Active_Clr,
      I1 => n_64_I_WR_CHNL,
      I10 => n_63_I_WR_CHNL,
      I11 => n_52_I_WR_CHNL,
      I12 => \^o3\,
      I13 => n_51_I_WR_CHNL,
      I14 => n_59_I_WR_CHNL,
      I15 => n_65_I_RD_CHNL,
      I2 => n_62_I_WR_CHNL,
      I3 => n_61_I_WR_CHNL,
      I4 => n_65_I_WR_CHNL,
      I5 => n_60_I_WR_CHNL,
      I6 => n_64_I_RD_CHNL,
      I7 => n_63_I_RD_CHNL,
      I8 => n_66_I_RD_CHNL,
      I9 => n_62_I_RD_CHNL,
      O1 => \n_5_GEN_ARB.I_SNG_PORT\,
      O2 => \n_6_GEN_ARB.I_SNG_PORT\,
      O3(0) => arb_sm_cs(1),
      O4 => \n_9_GEN_ARB.I_SNG_PORT\,
      O5 => \n_10_GEN_ARB.I_SNG_PORT\,
      O6 => \n_16_GEN_ARB.I_SNG_PORT\,
      O7 => \n_17_GEN_ARB.I_SNG_PORT\,
      O8 => \n_18_GEN_ARB.I_SNG_PORT\,
      Q(3 downto 0) => p_6_in(3 downto 0),
      SR(0) => \^o1\,
      ar_active_d1 => ar_active_d1,
      aw_active_d1 => aw_active_d1,
      axi_rd_burst1 => axi_rd_burst1,
      axi_wdata_full_cmb16_out => axi_wdata_full_cmb16_out,
      axi_wdata_full_reg => axi_wdata_full_reg,
      bram_we_a(3 downto 0) => bram_we_a(3 downto 0),
      curr_narrow_burst => curr_narrow_burst,
      curr_narrow_burst_cmb => curr_narrow_burst_cmb,
      curr_narrow_burst_en => curr_narrow_burst_en,
      curr_ua_narrow_wrap4 => \GEN_UA_NARROW.I_UA_NARROW/curr_ua_narrow_wrap4\,
      curr_ua_narrow_wrap4_0 => \GEN_UA_NARROW.I_UA_NARROW/curr_ua_narrow_wrap4_0\,
      last_arb_won_cmb6_out => last_arb_won_cmb6_out,
      p_0_out => p_0_out,
      p_1_out => p_1_out,
      p_5_out => p_5_out,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(1 downto 0) => s_axi_araddr(1 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arlen(1 downto 0) => s_axi_arlen(7 downto 6),
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(1 downto 0) => s_axi_awaddr(1 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awlen(1 downto 0) => s_axi_awlen(7 downto 6),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_rready => s_axi_rready,
      s_axi_wvalid => s_axi_wvalid
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
I_RD_CHNL: entity work.ip_axi_bram_ctrlrd_chnl
    port map (
      AR2Arb_Active_Clr => AR2Arb_Active_Clr,
      D(8 downto 0) => p_1_in(8 downto 0),
      I1 => \n_10_GEN_ARB.I_SNG_PORT\,
      I10 => \^o9\,
      I11 => \n_16_GEN_ARB.I_SNG_PORT\,
      I12 => \n_18_GEN_ARB.I_SNG_PORT\,
      I2 => \n_17_GEN_ARB.I_SNG_PORT\,
      I3(0) => I2(0),
      I36(0) => I36(0),
      I37(1 downto 0) => I37(1 downto 0),
      I38(2 downto 0) => I38(2 downto 0),
      I39(3 downto 0) => I39(3 downto 0),
      I4(1 downto 0) => I3(1 downto 0),
      I40(3 downto 0) => I40(3 downto 0),
      I41(3 downto 0) => I41(3 downto 0),
      I42(3 downto 0) => I42(3 downto 0),
      I43(3 downto 0) => I43(3 downto 0),
      I44(3 downto 0) => I44(3 downto 0),
      I45(3 downto 0) => I45(3 downto 0),
      I46(3 downto 0) => I46(3 downto 0),
      I47(3 downto 0) => I47(3 downto 0),
      I48(3 downto 0) => I48(3 downto 0),
      I49(3 downto 0) => I49(3 downto 0),
      I5 => n_55_I_WR_CHNL,
      I50(3 downto 0) => I50(3 downto 0),
      I51(3 downto 0) => I51(3 downto 0),
      I52(3 downto 0) => I52(3 downto 0),
      I53(3 downto 0) => I53(3 downto 0),
      I54(3 downto 0) => I54(3 downto 0),
      I55(3 downto 0) => I55(3 downto 0),
      I56(3 downto 0) => I56(3 downto 0),
      I57(3 downto 0) => I57(3 downto 0),
      I58(3 downto 0) => I58(3 downto 0),
      I59(3 downto 0) => I59(3 downto 0),
      I6 => n_58_I_WR_CHNL,
      I60(3 downto 0) => I60(3 downto 0),
      I61(3 downto 0) => I61(3 downto 0),
      I62(3 downto 0) => I62(3 downto 0),
      I63(3 downto 0) => I63(3 downto 0),
      I64(3 downto 0) => I64(3 downto 0),
      I65(3 downto 0) => I65(3 downto 0),
      I66(3 downto 0) => I66(3 downto 0),
      I67(3 downto 0) => I67(3 downto 0),
      I69(3 downto 0) => I69(3 downto 0),
      I7 => \^o5\,
      I71(3 downto 0) => I71(3 downto 0),
      I79(3 downto 0) => I79(3 downto 0),
      I8 => \^o7\,
      I80(3 downto 0) => I80(3 downto 0),
      I81(3 downto 0) => I81(3 downto 0),
      I82(3 downto 0) => I82(3 downto 0),
      I83(3 downto 0) => I83(3 downto 0),
      I84(3 downto 0) => I84(3 downto 0),
      I85(3 downto 0) => I85(3 downto 0),
      I87(3 downto 0) => I87(3 downto 0),
      I9 => \^o8\,
      O1 => \^o3\,
      O10 => n_48_I_RD_CHNL,
      O11 => n_49_I_RD_CHNL,
      O12 => n_50_I_RD_CHNL,
      O13 => n_51_I_RD_CHNL,
      O14 => n_52_I_RD_CHNL,
      O15 => n_53_I_RD_CHNL,
      O16 => n_54_I_RD_CHNL,
      O17 => n_55_I_RD_CHNL,
      O18 => n_56_I_RD_CHNL,
      O19 => O6,
      O2 => n_38_I_RD_CHNL,
      O20 => n_62_I_RD_CHNL,
      O21 => n_63_I_RD_CHNL,
      O22 => n_64_I_RD_CHNL,
      O23 => n_65_I_RD_CHNL,
      O24 => n_66_I_RD_CHNL,
      O25 => n_67_I_RD_CHNL,
      O26 => n_68_I_RD_CHNL,
      O27 => n_69_I_RD_CHNL,
      O28 => n_70_I_RD_CHNL,
      O29 => n_71_I_RD_CHNL,
      O3(0) => RdChnl_BRAM_Addr_Ld(10),
      O30 => n_72_I_RD_CHNL,
      O4(2 downto 0) => O4(2 downto 0),
      O5 => n_43_I_RD_CHNL,
      O6 => n_44_I_RD_CHNL,
      O7 => n_45_I_RD_CHNL,
      O8 => n_46_I_RD_CHNL,
      O9 => n_47_I_RD_CHNL,
      SR(0) => \^o1\,
      ar_active_d1 => ar_active_d1,
      axi_rd_burst1 => axi_rd_burst1,
      bram_rddata_a(31 downto 0) => bram_rddata_a(31 downto 0),
      curr_narrow_burst => curr_narrow_burst,
      curr_narrow_burst_cmb => curr_narrow_burst_cmb,
      curr_ua_narrow_wrap4 => \GEN_UA_NARROW.I_UA_NARROW/curr_ua_narrow_wrap4_0\,
      p_0_out => p_0_out,
      p_3_in => p_3_in,
      p_5_out => p_5_out,
      p_7_in => p_7_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(12 downto 0) => s_axi_araddr(12 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_awaddr(0) => s_axi_awaddr(2),
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rready => s_axi_rready
    );
I_WR_CHNL: entity work.ip_axi_bram_ctrlwr_chnl
    port map (
      D(9 downto 0) => p_1_in(9 downto 0),
      DI(2 downto 0) => DI(2 downto 0),
      I1(1 downto 0) => I1(1 downto 0),
      I10(3 downto 0) => I9(3 downto 0),
      I11(3 downto 0) => I10(3 downto 0),
      I12(3 downto 0) => I11(3 downto 0),
      I13(3 downto 0) => I12(3 downto 0),
      I14(3 downto 0) => I13(3 downto 0),
      I15(3 downto 0) => I14(3 downto 0),
      I16(3 downto 0) => I15(3 downto 0),
      I17(3 downto 0) => I16(3 downto 0),
      I18(3 downto 0) => I17(3 downto 0),
      I19(3 downto 0) => I18(3 downto 0),
      I2 => \n_5_GEN_ARB.I_SNG_PORT\,
      I20(3 downto 0) => I19(3 downto 0),
      I21(3 downto 0) => I20(3 downto 0),
      I22(3 downto 0) => I21(3 downto 0),
      I23(3 downto 0) => I22(3 downto 0),
      I24(3 downto 0) => I23(3 downto 0),
      I25(3 downto 0) => I24(3 downto 0),
      I26(3 downto 0) => I25(3 downto 0),
      I27(3 downto 0) => I26(3 downto 0),
      I28(3 downto 0) => I27(3 downto 0),
      I29(3 downto 0) => I28(3 downto 0),
      I3 => \^o5\,
      I30(3 downto 0) => I29(3 downto 0),
      I31(3 downto 0) => I30(3 downto 0),
      I32(3 downto 0) => I31(3 downto 0),
      I33(3 downto 0) => I32(3 downto 0),
      I34(3 downto 0) => I33(3 downto 0),
      I35(3 downto 0) => I34(3 downto 0),
      I36(3 downto 0) => I35(3 downto 0),
      I37 => \^o7\,
      I38 => \^o8\,
      I39 => \^o9\,
      I4 => \n_9_GEN_ARB.I_SNG_PORT\,
      I40 => \n_6_GEN_ARB.I_SNG_PORT\,
      I41 => \^o3\,
      I5(0) => I4(0),
      I6(1 downto 0) => I5(1 downto 0),
      I68(3 downto 0) => I68(3 downto 0),
      I7(2 downto 0) => I6(2 downto 0),
      I70(3 downto 0) => I70(3 downto 0),
      I72(3 downto 0) => I72(3 downto 0),
      I73(3 downto 0) => I73(3 downto 0),
      I74(3 downto 0) => I74(3 downto 0),
      I75(3 downto 0) => I75(3 downto 0),
      I76(3 downto 0) => I76(3 downto 0),
      I77(3 downto 0) => I77(3 downto 0),
      I78(3 downto 0) => I78(3 downto 0),
      I8(3 downto 0) => I7(3 downto 0),
      I86(3 downto 0) => I86(3 downto 0),
      I9(3 downto 0) => I8(3 downto 0),
      O(0) => O(0),
      O1 => O2,
      O10 => n_62_I_WR_CHNL,
      O11 => n_63_I_WR_CHNL,
      O12 => n_64_I_WR_CHNL,
      O13 => n_65_I_WR_CHNL,
      O2 => n_51_I_WR_CHNL,
      O3 => n_52_I_WR_CHNL,
      O4 => n_55_I_WR_CHNL,
      O5 => n_57_I_WR_CHNL,
      O6 => n_58_I_WR_CHNL,
      O7 => n_59_I_WR_CHNL,
      O8 => n_60_I_WR_CHNL,
      O9 => n_61_I_WR_CHNL,
      Q(3 downto 0) => p_6_in(3 downto 0),
      SR(0) => \^o1\,
      arb_sm_cs(0) => arb_sm_cs(1),
      aw_active_d1 => aw_active_d1,
      axi_wdata_full_cmb16_out => axi_wdata_full_cmb16_out,
      axi_wdata_full_reg => axi_wdata_full_reg,
      bram_en_a => bram_en_a,
      bram_wrdata_a(31 downto 0) => bram_wrdata_a(31 downto 0),
      curr_narrow_burst_en => curr_narrow_burst_en,
      curr_ua_narrow_wrap4 => \GEN_UA_NARROW.I_UA_NARROW/curr_ua_narrow_wrap4\,
      last_arb_won_cmb6_out => last_arb_won_cmb6_out,
      p_1_out => p_1_out,
      p_3_in => p_3_in,
      p_7_in => p_7_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(11 downto 2) => s_axi_awaddr(12 downto 3),
      s_axi_awaddr(1 downto 0) => s_axi_awaddr(1 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_rready => s_axi_rready,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrlaxi_bram_ctrl_top is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    O1 : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    O2 : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    DI : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O9 : out STD_LOGIC;
    O10 : out STD_LOGIC;
    bram_addr_a : out STD_LOGIC_VECTOR ( 4 downto 0 );
    bram_en_a : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    O : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_wlast : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I5 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I7 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I8 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I9 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I10 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I11 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I12 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I13 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I14 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I15 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I16 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I17 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I18 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I19 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I20 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I21 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I22 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I23 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I24 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I25 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I26 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I27 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I28 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I29 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I30 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I31 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I32 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I33 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I34 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I35 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I36 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I37 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I38 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I39 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I40 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I41 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I42 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I43 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I44 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I45 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I46 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I47 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I48 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I49 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I50 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I51 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I52 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I53 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I54 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I55 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I56 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I57 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I58 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I59 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I60 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I61 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I62 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I63 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I64 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I65 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I66 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I67 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I68 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I69 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I70 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I71 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I72 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I73 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I74 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I75 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I76 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I77 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I78 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I79 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I80 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I81 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I82 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I83 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I84 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I85 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I86 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I87 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end ip_axi_bram_ctrlaxi_bram_ctrl_top;

architecture STRUCTURE of ip_axi_bram_ctrlaxi_bram_ctrl_top is
begin
\GEN_AXI4.I_FULL_AXI\: entity work.ip_axi_bram_ctrlfull_axi
    port map (
      DI(2 downto 0) => DI(2 downto 0),
      I1(1 downto 0) => I1(1 downto 0),
      I10(3 downto 0) => I10(3 downto 0),
      I11(3 downto 0) => I11(3 downto 0),
      I12(3 downto 0) => I12(3 downto 0),
      I13(3 downto 0) => I13(3 downto 0),
      I14(3 downto 0) => I14(3 downto 0),
      I15(3 downto 0) => I15(3 downto 0),
      I16(3 downto 0) => I16(3 downto 0),
      I17(3 downto 0) => I17(3 downto 0),
      I18(3 downto 0) => I18(3 downto 0),
      I19(3 downto 0) => I19(3 downto 0),
      I2(0) => I2(0),
      I20(3 downto 0) => I20(3 downto 0),
      I21(3 downto 0) => I21(3 downto 0),
      I22(3 downto 0) => I22(3 downto 0),
      I23(3 downto 0) => I23(3 downto 0),
      I24(3 downto 0) => I24(3 downto 0),
      I25(3 downto 0) => I25(3 downto 0),
      I26(3 downto 0) => I26(3 downto 0),
      I27(3 downto 0) => I27(3 downto 0),
      I28(3 downto 0) => I28(3 downto 0),
      I29(3 downto 0) => I29(3 downto 0),
      I3(1 downto 0) => I3(1 downto 0),
      I30(3 downto 0) => I30(3 downto 0),
      I31(3 downto 0) => I31(3 downto 0),
      I32(3 downto 0) => I32(3 downto 0),
      I33(3 downto 0) => I33(3 downto 0),
      I34(3 downto 0) => I34(3 downto 0),
      I35(3 downto 0) => I35(3 downto 0),
      I36(0) => I36(0),
      I37(1 downto 0) => I37(1 downto 0),
      I38(2 downto 0) => I38(2 downto 0),
      I39(3 downto 0) => I39(3 downto 0),
      I4(0) => I4(0),
      I40(3 downto 0) => I40(3 downto 0),
      I41(3 downto 0) => I41(3 downto 0),
      I42(3 downto 0) => I42(3 downto 0),
      I43(3 downto 0) => I43(3 downto 0),
      I44(3 downto 0) => I44(3 downto 0),
      I45(3 downto 0) => I45(3 downto 0),
      I46(3 downto 0) => I46(3 downto 0),
      I47(3 downto 0) => I47(3 downto 0),
      I48(3 downto 0) => I48(3 downto 0),
      I49(3 downto 0) => I49(3 downto 0),
      I5(1 downto 0) => I5(1 downto 0),
      I50(3 downto 0) => I50(3 downto 0),
      I51(3 downto 0) => I51(3 downto 0),
      I52(3 downto 0) => I52(3 downto 0),
      I53(3 downto 0) => I53(3 downto 0),
      I54(3 downto 0) => I54(3 downto 0),
      I55(3 downto 0) => I55(3 downto 0),
      I56(3 downto 0) => I56(3 downto 0),
      I57(3 downto 0) => I57(3 downto 0),
      I58(3 downto 0) => I58(3 downto 0),
      I59(3 downto 0) => I59(3 downto 0),
      I6(2 downto 0) => I6(2 downto 0),
      I60(3 downto 0) => I60(3 downto 0),
      I61(3 downto 0) => I61(3 downto 0),
      I62(3 downto 0) => I62(3 downto 0),
      I63(3 downto 0) => I63(3 downto 0),
      I64(3 downto 0) => I64(3 downto 0),
      I65(3 downto 0) => I65(3 downto 0),
      I66(3 downto 0) => I66(3 downto 0),
      I67(3 downto 0) => I67(3 downto 0),
      I68(3 downto 0) => I68(3 downto 0),
      I69(3 downto 0) => I69(3 downto 0),
      I7(3 downto 0) => I7(3 downto 0),
      I70(3 downto 0) => I70(3 downto 0),
      I71(3 downto 0) => I71(3 downto 0),
      I72(3 downto 0) => I72(3 downto 0),
      I73(3 downto 0) => I73(3 downto 0),
      I74(3 downto 0) => I74(3 downto 0),
      I75(3 downto 0) => I75(3 downto 0),
      I76(3 downto 0) => I76(3 downto 0),
      I77(3 downto 0) => I77(3 downto 0),
      I78(3 downto 0) => I78(3 downto 0),
      I79(3 downto 0) => I79(3 downto 0),
      I8(3 downto 0) => I8(3 downto 0),
      I80(3 downto 0) => I80(3 downto 0),
      I81(3 downto 0) => I81(3 downto 0),
      I82(3 downto 0) => I82(3 downto 0),
      I83(3 downto 0) => I83(3 downto 0),
      I84(3 downto 0) => I84(3 downto 0),
      I85(3 downto 0) => I85(3 downto 0),
      I86(3 downto 0) => I86(3 downto 0),
      I87(3 downto 0) => I87(3 downto 0),
      I9(3 downto 0) => I9(3 downto 0),
      O(0) => O(0),
      O1 => SR(0),
      O10 => O9,
      O11 => O10,
      O2 => O1,
      O3 => O2,
      O4(2 downto 0) => O3(2 downto 0),
      O5 => O4,
      O6 => O5,
      O7 => O6,
      O8 => O7,
      O9 => O8,
      bram_addr_a(4 downto 0) => bram_addr_a(4 downto 0),
      bram_en_a => bram_en_a,
      bram_rddata_a(31 downto 0) => bram_rddata_a(31 downto 0),
      bram_we_a(3 downto 0) => bram_we_a(3 downto 0),
      bram_wrdata_a(31 downto 0) => bram_wrdata_a(31 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(12 downto 0) => s_axi_araddr(12 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(12 downto 0) => s_axi_awaddr(12 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rready => s_axi_rready,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    ecc_interrupt : out STD_LOGIC;
    ecc_ue : out STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
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
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr_a : out STD_LOGIC_VECTOR ( 12 downto 0 );
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_rst_b : out STD_LOGIC;
    bram_clk_b : out STD_LOGIC;
    bram_en_b : out STD_LOGIC;
    bram_we_b : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr_b : out STD_LOGIC_VECTOR ( 12 downto 0 );
    bram_wrdata_b : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_rddata_b : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is "axi_bram_ctrl";
  attribute C_BRAM_INST_MODE : string;
  attribute C_BRAM_INST_MODE of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is "EXTERNAL";
  attribute C_MEMORY_DEPTH : integer;
  attribute C_MEMORY_DEPTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 2048;
  attribute C_BRAM_ADDR_WIDTH : integer;
  attribute C_BRAM_ADDR_WIDTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 11;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 13;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 32;
  attribute C_S_AXI_ID_WIDTH : integer;
  attribute C_S_AXI_ID_WIDTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 1;
  attribute C_S_AXI_PROTOCOL : string;
  attribute C_S_AXI_PROTOCOL of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is "AXI4";
  attribute C_S_AXI_SUPPORTS_NARROW_BURST : integer;
  attribute C_S_AXI_SUPPORTS_NARROW_BURST of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 1;
  attribute C_SINGLE_PORT_BRAM : integer;
  attribute C_SINGLE_PORT_BRAM of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is "kintex7";
  attribute C_S_AXI_CTRL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CTRL_ADDR_WIDTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 32;
  attribute C_S_AXI_CTRL_DATA_WIDTH : integer;
  attribute C_S_AXI_CTRL_DATA_WIDTH of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 32;
  attribute C_ECC : integer;
  attribute C_ECC of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 0;
  attribute C_ECC_TYPE : integer;
  attribute C_ECC_TYPE of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 0;
  attribute C_FAULT_INJECT : integer;
  attribute C_FAULT_INJECT of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 0;
  attribute C_ECC_ONOFF_RESET_VALUE : integer;
  attribute C_ECC_ONOFF_RESET_VALUE of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ : entity is "yes";
end \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\;

architecture STRUCTURE of \ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data20\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data30\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data40\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data50\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data60\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data70\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data20\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data30\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data40\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data50\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data60\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data70\ : STD_LOGIC;
  signal \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^bram_addr_a\ : STD_LOGIC_VECTOR ( 12 downto 2 );
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_19\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_19__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_20\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_20__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_21\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_21__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_22\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_22__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_23\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_23__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_24\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_24__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_25\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_25__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_26\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_26__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_32\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_32__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_33\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_33__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_34\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_34__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_35\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_35__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_37\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_37__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_38\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_38__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_39\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_39__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_40\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_40__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_42\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_42__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_43\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_43__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_44\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_44__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_45\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_45__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_46\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_46__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_48\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_48__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_49\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_49__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_50\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_50__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_51\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_51__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_52\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_52__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_53\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_53__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_54\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_54__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_55\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_55__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_56\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_56__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_57\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_57__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_58\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_58__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_59\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_59__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_60\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_60__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_61\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_61__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_62\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_62__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_63\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_63__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_64\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_64__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_65\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_65__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_66\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_66__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_67\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_67__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_68\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_68__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_156__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_157\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_157__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_158\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_158__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_159\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_159__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_160\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_160__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_161\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_161__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_162\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_170\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_171\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_171__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_172\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_172__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_173\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_173__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_174\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_174__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_175\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_175__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_176\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_176__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_177\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_177__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_178\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_178__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_179\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_179__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_180\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_180__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_181\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\ : STD_LOGIC;
  signal \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\ : STD_LOGIC;
  signal \^s_axi_aclk\ : STD_LOGIC;
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
  \^s_axi_aclk\ <= s_axi_aclk;
  bram_addr_a(12 downto 2) <= \^bram_addr_a\(12 downto 2);
  bram_addr_a(1) <= \<const0>\;
  bram_addr_a(0) <= \<const0>\;
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
  bram_clk_a <= \^s_axi_aclk\;
  bram_clk_b <= \<const0>\;
  bram_en_b <= \<const0>\;
  bram_rst_b <= \<const0>\;
  bram_we_b(3) <= \<const0>\;
  bram_we_b(2) <= \<const0>\;
  bram_we_b(1) <= \<const0>\;
  bram_we_b(0) <= \<const0>\;
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
\GEN_NARROW_CNT.narrow_addr_int[0]_i_18\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_18__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_19\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_19\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_19__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_19__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_20\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_20\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_20__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_20__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_21\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_21\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_21__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_21__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_22\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_22\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_22__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_22__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_23\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_23\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_23__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_23__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_24\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_24\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_24__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_24__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_25\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_25\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_25__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_25__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_26\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_26\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_26__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_26__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_28\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_28__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_29\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(6)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_29__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(6)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_30\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_30__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_31\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(4)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_31__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(4)
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_32\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_32\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_32__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_32__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_33\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_33\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_33__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_33__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_34\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_34\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_34__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_34__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_35\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_35\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_35__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_35__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_37\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_37\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_37__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_37__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_38\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_38\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_38__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_38__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_39\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_39\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_39__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_39__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_40\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_40\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_40__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_40__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_42\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_42\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_42__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_42__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_43\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_43\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_43__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_43__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_44\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_44\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_44__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_44__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_45\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_45\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_45__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_45__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_46\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_46\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_46__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_46__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_48\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_48\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_48__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_48__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_49\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_49\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_49__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_49__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_50\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_50\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_50__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_50__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_51\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_51\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_51__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_51__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_52\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_52\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_52__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_52__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_53\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_53\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_53__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_53__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_54\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_54\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_54__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_54__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_55\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_55\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_55__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_55__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_56\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_56\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_56__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_56__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_57\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_57\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_57__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_57__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_58\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_58\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_58__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_58__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_59\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_59\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_59__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_59__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_60\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_60\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_60__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_60__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_61\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_61\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_61__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_61__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_62\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_62\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_62__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_62__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_63\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_63\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_63__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_63__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_64\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_64\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_64__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_64__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_65\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_65\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_65__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_65__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_66\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_66\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_66__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAFBEBFB"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(0),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_66__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_67\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      I3 => s_axi_awaddr(1),
      I4 => s_axi_awaddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_67\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_67__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"05FA04FB"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_67__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_68\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awsize(2),
      I2 => s_axi_awsize(0),
      I3 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_68\
    );
\GEN_NARROW_CNT.narrow_addr_int[0]_i_68__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
    port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arsize(2),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_68__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_156__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_156__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_157\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_157\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_157__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_157__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_158\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_158\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_158__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_158__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_159\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_159\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_159__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_159__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_160\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_160\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_160__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_160__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_161\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_161\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_161__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_161__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_162\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_162\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_170\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_170\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_171\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_171\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_171__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_171__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_172\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_172\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_172__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_172__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_173\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(2),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_173\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_173__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_173__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_174\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(2),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(1),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_174\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_174__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_174__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_175\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_175\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_175__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_175__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_176\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(0),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_176\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_176__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_176__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_177\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(0),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_177\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_177__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_177__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_178\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_178\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_178__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_178__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_179\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => s_axi_awsize(1),
      I1 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_179\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_179__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_179__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_180\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E7"
    )
    port map (
      I0 => s_axi_awsize(0),
      I1 => s_axi_awsize(1),
      I2 => s_axi_awsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_180\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_180__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => s_axi_arsize(1),
      I1 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_180__0\
    );
\GEN_NARROW_CNT.narrow_addr_int[1]_i_181\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E7"
    )
    port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      O => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_181\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      O(2 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10_O_UNCONNECTED\(2 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_19\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_20\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_21\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_22\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      O(2 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0_O_UNCONNECTED\(2 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_19__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_20__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_21__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_22__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(2 downto 0),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      O(1 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11_O_UNCONNECTED\(1 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_23\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_24\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_25\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_26\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(2 downto 0),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      O(1 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0_O_UNCONNECTED\(1 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_23__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_24__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_25__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_26__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      CYINIT => \<const0>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7 downto 4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      O(2 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14_O_UNCONNECTED\(2 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_32\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_33\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_34\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_35\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      CYINIT => \<const0>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7 downto 4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      O(2 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0_O_UNCONNECTED\(2 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_32__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_33__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_34__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_35__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(6 downto 4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      O(1 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15_O_UNCONNECTED\(1 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_37\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_38\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_39\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_40\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(6 downto 4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      O(1 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0_O_UNCONNECTED\(1 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_37__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_38__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_39__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_40__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_42\,
      DI(2) => \<const0>\,
      DI(1 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5 downto 4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      O(0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16_O_UNCONNECTED\(0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_43\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_44\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_45\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_46\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_42__0\,
      DI(2) => \<const0>\,
      DI(1 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5 downto 4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      O(0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0_O_UNCONNECTED\(0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_43__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_44__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_45__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_46__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_48\,
      DI(2) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5),
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_49\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_50\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_51\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_52\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_48__0\,
      DI(2) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5),
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(4),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_49__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_50__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_51__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_52__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_53\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_54\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_55\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_56\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_27__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_53__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_54__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_55__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_56__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_57\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_58\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_59\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_60\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_36__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_57__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_58__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_59__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_60__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_61\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_62\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_63\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_64\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_41__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_61__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_62__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_63__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_64__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_65\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_66\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_67\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_68\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3 downto 0),
      O(3 downto 0) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_47__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_65__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_66__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_67__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[0]_i_68__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_156__0\,
      DI(2) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5),
      DI(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_157\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_158__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_159\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_160\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_161\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_157__0\,
      DI(2) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5),
      DI(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_158\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_159__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_160__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_161__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_162\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_170\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_171\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_171__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_172__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_172\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_173\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_173__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_174__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_174\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_175\,
      DI(2) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5),
      DI(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_176\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_177__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_178\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_179\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_180\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(7),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_175__0\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_176__0\,
      DI(2) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(5),
      DI(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_177\,
      DI(0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(3),
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      S(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_178__0\,
      S(2) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_179__0\,
      S(1) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_180__0\,
      S(0) => \n_0_GEN_NARROW_CNT.narrow_addr_int[1]_i_181\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data20\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data30\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data20\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data30\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data70\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data60\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data70\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data50\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data60\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data40\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data50\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      CO(3) => \NLW_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0_CO_UNCONNECTED\(3),
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data40\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
\GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      CO(3) => \n_0_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      CO(2) => \n_1_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      CO(1) => \n_2_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      CO(0) => \n_3_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      O(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      O(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      O(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      S(3) => \<const1>\,
      S(2) => \<const1>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gext_inst.abcv3_0_ext_inst\: entity work.ip_axi_bram_ctrlaxi_bram_ctrl_top
    port map (
      DI(2 downto 0) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(2 downto 0),
      I1(1) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      I1(0) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11\,
      I10(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      I10(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      I10(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      I10(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_166\,
      I11(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      I11(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      I11(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      I11(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167\,
      I12(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      I12(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      I12(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      I12(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151\,
      I13(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      I13(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      I13(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      I13(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152\,
      I14(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      I14(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      I14(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      I14(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149\,
      I15(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      I15(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      I15(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      I15(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150\,
      I16(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      I16(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      I16(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      I16(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154\,
      I17(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      I17(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      I17(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      I17(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148\,
      I18(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      I18(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      I18(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      I18(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145\,
      I19(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      I19(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      I19(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      I19(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146\,
      I2(0) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10__0\,
      I20(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      I20(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      I20(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      I20(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_143\,
      I21(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      I21(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      I21(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      I21(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144\,
      I22(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      I22(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      I22(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      I22(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126\,
      I23(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      I23(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      I23(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      I23(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127\,
      I24(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      I24(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      I24(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      I24(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124\,
      I25(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      I25(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      I25(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      I25(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125\,
      I26(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      I26(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      I26(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      I26(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120\,
      I27(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      I27(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      I27(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      I27(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121\,
      I28(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      I28(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      I28(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      I28(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_118\,
      I29(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      I29(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      I29(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      I29(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119\,
      I3(1) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      I3(0) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_11__0\,
      I30(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data70\,
      I30(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      I30(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      I30(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_78\,
      I31(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data60\,
      I31(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      I31(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      I31(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79\,
      I32(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data50\,
      I32(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      I32(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      I32(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80\,
      I33(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data40\,
      I33(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      I33(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      I33(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81\,
      I34(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data20\,
      I34(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      I34(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      I34(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_28\,
      I35(3) => \GEN_AXI4.I_FULL_AXI/I_WR_CHNL/GEN_UA_NARROW.I_UA_NARROW/data30\,
      I35(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      I35(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      I35(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29\,
      I36(0) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14__0\,
      I37(1) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      I37(0) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15__0\,
      I38(2) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      I38(1) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      I38(0) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16__0\,
      I39(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      I39(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      I39(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      I39(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17__0\,
      I4(0) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_14\,
      I40(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      I40(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      I40(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      I40(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_133\,
      I41(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      I41(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      I41(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      I41(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169__0\,
      I42(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      I42(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      I42(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      I42(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_167__0\,
      I43(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      I43(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      I43(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      I43(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168__0\,
      I44(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      I44(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      I44(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      I44(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_152__0\,
      I45(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      I45(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      I45(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      I45(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153__0\,
      I46(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      I46(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      I46(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      I46(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_150__0\,
      I47(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      I47(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      I47(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      I47(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_151__0\,
      I48(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      I48(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      I48(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      I48(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_155\,
      I49(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      I49(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      I49(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      I49(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_149__0\,
      I5(1) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      I5(0) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_15\,
      I50(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      I50(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      I50(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      I50(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_146__0\,
      I51(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      I51(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      I51(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      I51(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147__0\,
      I52(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      I52(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      I52(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      I52(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_144__0\,
      I53(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      I53(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      I53(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      I53(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_145__0\,
      I54(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      I54(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      I54(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      I54(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_127__0\,
      I55(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      I55(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      I55(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      I55(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128__0\,
      I56(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      I56(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      I56(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      I56(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_125__0\,
      I57(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      I57(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      I57(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      I57(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_126__0\,
      I58(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      I58(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      I58(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      I58(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_121__0\,
      I59(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      I59(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      I59(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      I59(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122__0\,
      I6(2) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      I6(1) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      I6(0) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_16\,
      I60(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      I60(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      I60(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      I60(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_119__0\,
      I61(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      I61(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      I61(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      I61(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_120__0\,
      I62(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data70\,
      I62(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      I62(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      I62(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_79__0\,
      I63(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data60\,
      I63(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      I63(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      I63(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_80__0\,
      I64(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data50\,
      I64(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      I64(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      I64(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_81__0\,
      I65(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data40\,
      I65(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      I65(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      I65(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82__0\,
      I66(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data20\,
      I66(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      I66(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      I66(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_29__0\,
      I67(3) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/data30\,
      I67(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      I67(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      I67(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_30\,
      I68(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      I68(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      I68(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      I68(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_153\,
      I69(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      I69(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      I69(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      I69(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_154__0\,
      I7(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      I7(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      I7(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      I7(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_17\,
      I70(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      I70(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      I70(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      I70(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130\,
      I71(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      I71(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      I71(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      I71(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_131\,
      I72(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      I72(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      I72(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      I72(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_147\,
      I73(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      I73(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      I73(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      I73(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129\,
      I74(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      I74(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      I74(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      I74(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_128\,
      I75(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      I75(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      I75(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      I75(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123\,
      I76(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      I76(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      I76(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      I76(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_122\,
      I77(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      I77(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      I77(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      I77(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83\,
      I78(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      I78(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      I78(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      I78(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_82\,
      I79(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      I79(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      I79(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      I79(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_148__0\,
      I8(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      I8(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      I8(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      I8(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_132\,
      I80(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      I80(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      I80(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      I80(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_130__0\,
      I81(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      I81(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      I81(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      I81(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_129__0\,
      I82(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      I82(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      I82(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      I82(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_124__0\,
      I83(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      I83(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      I83(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      I83(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_123__0\,
      I84(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      I84(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      I84(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      I84(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_84\,
      I85(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      I85(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      I85(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      I85(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_83__0\,
      I86(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      I86(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      I86(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      I86(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_169\,
      I87(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      I87(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      I87(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      I87(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_170\,
      I9(3) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      I9(2) => \n_5_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      I9(1) => \n_6_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      I9(0) => \n_7_GEN_NARROW_CNT.narrow_addr_int_reg[1]_i_168\,
      O(0) => \n_4_GEN_NARROW_CNT.narrow_addr_int_reg[0]_i_10\,
      O1 => s_axi_bvalid,
      O10 => \^bram_addr_a\(8),
      O2 => s_axi_rlast,
      O3(2 downto 0) => \GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_UA_NARROW.I_UA_NARROW/size_plus_lsb__0\(2 downto 0),
      O4 => \^bram_addr_a\(2),
      O5 => s_axi_rvalid,
      O6 => \^bram_addr_a\(5),
      O7 => \^bram_addr_a\(3),
      O8 => \^bram_addr_a\(4),
      O9 => \^bram_addr_a\(9),
      SR(0) => bram_rst_a,
      bram_addr_a(4 downto 2) => \^bram_addr_a\(12 downto 10),
      bram_addr_a(1 downto 0) => \^bram_addr_a\(7 downto 6),
      bram_en_a => bram_en_a,
      bram_rddata_a(31 downto 0) => bram_rddata_a(31 downto 0),
      bram_we_a(3 downto 0) => bram_we_a(3 downto 0),
      bram_wrdata_a(31 downto 0) => bram_wrdata_a(31 downto 0),
      s_axi_aclk => \^s_axi_aclk\,
      s_axi_araddr(12 downto 0) => s_axi_araddr(12 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(12 downto 0) => s_axi_awaddr(12 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rready => s_axi_rready,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axi_bram_ctrl is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    bram_rst_a : out STD_LOGIC;
    bram_clk_a : out STD_LOGIC;
    bram_en_a : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr_a : out STD_LOGIC_VECTOR ( 12 downto 0 );
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axi_bram_ctrl : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_axi_bram_ctrl : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ip_axi_bram_ctrl : entity is "axi_bram_ctrl,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axi_bram_ctrl : entity is "ip_axi_bram_ctrl,axi_bram_ctrl,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of ip_axi_bram_ctrl : entity is "ip_axi_bram_ctrl,axi_bram_ctrl,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axi_bram_ctrl,x_ipVersion=3.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_MEMORY_DEPTH=2048,C_FAMILY=kintex7,C_BRAM_INST_MODE=EXTERNAL,C_BRAM_ADDR_WIDTH=11,C_S_AXI_ADDR_WIDTH=13,C_S_AXI_DATA_WIDTH=32,C_S_AXI_ID_WIDTH=1,C_S_AXI_PROTOCOL=AXI4,C_S_AXI_SUPPORTS_NARROW_BURST=1,C_SINGLE_PORT_BRAM=1,C_S_AXI_CTRL_ADDR_WIDTH=32,C_S_AXI_CTRL_DATA_WIDTH=32,C_ECC=0,C_ECC_TYPE=0,C_FAULT_INJECT=0,C_ECC_ONOFF_RESET_VALUE=0}";
end ip_axi_bram_ctrl;

architecture STRUCTURE of ip_axi_bram_ctrl is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_U0_bram_clk_b_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_en_b_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_rst_b_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_ecc_interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_ecc_ue_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_ctrl_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_bram_addr_b_UNCONNECTED : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal NLW_U0_bram_we_b_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_bram_wrdata_b_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_s_axi_ctrl_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_ctrl_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_s_axi_ctrl_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_BRAM_ADDR_WIDTH : integer;
  attribute C_BRAM_ADDR_WIDTH of U0 : label is 11;
  attribute C_BRAM_INST_MODE : string;
  attribute C_BRAM_INST_MODE of U0 : label is "EXTERNAL";
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
  attribute C_MEMORY_DEPTH of U0 : label is 2048;
  attribute C_SINGLE_PORT_BRAM : integer;
  attribute C_SINGLE_PORT_BRAM of U0 : label is 1;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of U0 : label is 13;
  attribute C_S_AXI_CTRL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CTRL_ADDR_WIDTH of U0 : label is 32;
  attribute C_S_AXI_CTRL_DATA_WIDTH : integer;
  attribute C_S_AXI_CTRL_DATA_WIDTH of U0 : label is 32;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of U0 : label is 32;
  attribute C_S_AXI_ID_WIDTH : integer;
  attribute C_S_AXI_ID_WIDTH of U0 : label is 1;
  attribute C_S_AXI_PROTOCOL : string;
  attribute C_S_AXI_PROTOCOL of U0 : label is "AXI4";
  attribute C_S_AXI_SUPPORTS_NARROW_BURST : integer;
  attribute C_S_AXI_SUPPORTS_NARROW_BURST of U0 : label is 1;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is true;
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
U0: entity work.\ip_axi_bram_ctrlaxi_bram_ctrl__parameterized0\
    port map (
      bram_addr_a(12 downto 0) => bram_addr_a(12 downto 0),
      bram_addr_b(12 downto 0) => NLW_U0_bram_addr_b_UNCONNECTED(12 downto 0),
      bram_clk_a => bram_clk_a,
      bram_clk_b => NLW_U0_bram_clk_b_UNCONNECTED,
      bram_en_a => bram_en_a,
      bram_en_b => NLW_U0_bram_en_b_UNCONNECTED,
      bram_rddata_a(31 downto 0) => bram_rddata_a(31 downto 0),
      bram_rddata_b(31) => \<const0>\,
      bram_rddata_b(30) => \<const0>\,
      bram_rddata_b(29) => \<const0>\,
      bram_rddata_b(28) => \<const0>\,
      bram_rddata_b(27) => \<const0>\,
      bram_rddata_b(26) => \<const0>\,
      bram_rddata_b(25) => \<const0>\,
      bram_rddata_b(24) => \<const0>\,
      bram_rddata_b(23) => \<const0>\,
      bram_rddata_b(22) => \<const0>\,
      bram_rddata_b(21) => \<const0>\,
      bram_rddata_b(20) => \<const0>\,
      bram_rddata_b(19) => \<const0>\,
      bram_rddata_b(18) => \<const0>\,
      bram_rddata_b(17) => \<const0>\,
      bram_rddata_b(16) => \<const0>\,
      bram_rddata_b(15) => \<const0>\,
      bram_rddata_b(14) => \<const0>\,
      bram_rddata_b(13) => \<const0>\,
      bram_rddata_b(12) => \<const0>\,
      bram_rddata_b(11) => \<const0>\,
      bram_rddata_b(10) => \<const0>\,
      bram_rddata_b(9) => \<const0>\,
      bram_rddata_b(8) => \<const0>\,
      bram_rddata_b(7) => \<const0>\,
      bram_rddata_b(6) => \<const0>\,
      bram_rddata_b(5) => \<const0>\,
      bram_rddata_b(4) => \<const0>\,
      bram_rddata_b(3) => \<const0>\,
      bram_rddata_b(2) => \<const0>\,
      bram_rddata_b(1) => \<const0>\,
      bram_rddata_b(0) => \<const0>\,
      bram_rst_a => bram_rst_a,
      bram_rst_b => NLW_U0_bram_rst_b_UNCONNECTED,
      bram_we_a(3 downto 0) => bram_we_a(3 downto 0),
      bram_we_b(3 downto 0) => NLW_U0_bram_we_b_UNCONNECTED(3 downto 0),
      bram_wrdata_a(31 downto 0) => bram_wrdata_a(31 downto 0),
      bram_wrdata_b(31 downto 0) => NLW_U0_bram_wrdata_b_UNCONNECTED(31 downto 0),
      ecc_interrupt => NLW_U0_ecc_interrupt_UNCONNECTED,
      ecc_ue => NLW_U0_ecc_ue_UNCONNECTED,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(12 downto 0) => s_axi_araddr(12 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_arcache(3 downto 0) => s_axi_arcache(3 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arid(0) => s_axi_arid(0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arlock => s_axi_arlock,
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(12 downto 0) => s_axi_awaddr(12 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awcache(3 downto 0) => s_axi_awcache(3 downto 0),
      s_axi_awid(0) => s_axi_awid(0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awlock => s_axi_awlock,
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => s_axi_bid(0),
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_ctrl_araddr(31) => \<const0>\,
      s_axi_ctrl_araddr(30) => \<const0>\,
      s_axi_ctrl_araddr(29) => \<const0>\,
      s_axi_ctrl_araddr(28) => \<const0>\,
      s_axi_ctrl_araddr(27) => \<const0>\,
      s_axi_ctrl_araddr(26) => \<const0>\,
      s_axi_ctrl_araddr(25) => \<const0>\,
      s_axi_ctrl_araddr(24) => \<const0>\,
      s_axi_ctrl_araddr(23) => \<const0>\,
      s_axi_ctrl_araddr(22) => \<const0>\,
      s_axi_ctrl_araddr(21) => \<const0>\,
      s_axi_ctrl_araddr(20) => \<const0>\,
      s_axi_ctrl_araddr(19) => \<const0>\,
      s_axi_ctrl_araddr(18) => \<const0>\,
      s_axi_ctrl_araddr(17) => \<const0>\,
      s_axi_ctrl_araddr(16) => \<const0>\,
      s_axi_ctrl_araddr(15) => \<const0>\,
      s_axi_ctrl_araddr(14) => \<const0>\,
      s_axi_ctrl_araddr(13) => \<const0>\,
      s_axi_ctrl_araddr(12) => \<const0>\,
      s_axi_ctrl_araddr(11) => \<const0>\,
      s_axi_ctrl_araddr(10) => \<const0>\,
      s_axi_ctrl_araddr(9) => \<const0>\,
      s_axi_ctrl_araddr(8) => \<const0>\,
      s_axi_ctrl_araddr(7) => \<const0>\,
      s_axi_ctrl_araddr(6) => \<const0>\,
      s_axi_ctrl_araddr(5) => \<const0>\,
      s_axi_ctrl_araddr(4) => \<const0>\,
      s_axi_ctrl_araddr(3) => \<const0>\,
      s_axi_ctrl_araddr(2) => \<const0>\,
      s_axi_ctrl_araddr(1) => \<const0>\,
      s_axi_ctrl_araddr(0) => \<const0>\,
      s_axi_ctrl_arready => NLW_U0_s_axi_ctrl_arready_UNCONNECTED,
      s_axi_ctrl_arvalid => \<const0>\,
      s_axi_ctrl_awaddr(31) => \<const0>\,
      s_axi_ctrl_awaddr(30) => \<const0>\,
      s_axi_ctrl_awaddr(29) => \<const0>\,
      s_axi_ctrl_awaddr(28) => \<const0>\,
      s_axi_ctrl_awaddr(27) => \<const0>\,
      s_axi_ctrl_awaddr(26) => \<const0>\,
      s_axi_ctrl_awaddr(25) => \<const0>\,
      s_axi_ctrl_awaddr(24) => \<const0>\,
      s_axi_ctrl_awaddr(23) => \<const0>\,
      s_axi_ctrl_awaddr(22) => \<const0>\,
      s_axi_ctrl_awaddr(21) => \<const0>\,
      s_axi_ctrl_awaddr(20) => \<const0>\,
      s_axi_ctrl_awaddr(19) => \<const0>\,
      s_axi_ctrl_awaddr(18) => \<const0>\,
      s_axi_ctrl_awaddr(17) => \<const0>\,
      s_axi_ctrl_awaddr(16) => \<const0>\,
      s_axi_ctrl_awaddr(15) => \<const0>\,
      s_axi_ctrl_awaddr(14) => \<const0>\,
      s_axi_ctrl_awaddr(13) => \<const0>\,
      s_axi_ctrl_awaddr(12) => \<const0>\,
      s_axi_ctrl_awaddr(11) => \<const0>\,
      s_axi_ctrl_awaddr(10) => \<const0>\,
      s_axi_ctrl_awaddr(9) => \<const0>\,
      s_axi_ctrl_awaddr(8) => \<const0>\,
      s_axi_ctrl_awaddr(7) => \<const0>\,
      s_axi_ctrl_awaddr(6) => \<const0>\,
      s_axi_ctrl_awaddr(5) => \<const0>\,
      s_axi_ctrl_awaddr(4) => \<const0>\,
      s_axi_ctrl_awaddr(3) => \<const0>\,
      s_axi_ctrl_awaddr(2) => \<const0>\,
      s_axi_ctrl_awaddr(1) => \<const0>\,
      s_axi_ctrl_awaddr(0) => \<const0>\,
      s_axi_ctrl_awready => NLW_U0_s_axi_ctrl_awready_UNCONNECTED,
      s_axi_ctrl_awvalid => \<const0>\,
      s_axi_ctrl_bready => \<const0>\,
      s_axi_ctrl_bresp(1 downto 0) => NLW_U0_s_axi_ctrl_bresp_UNCONNECTED(1 downto 0),
      s_axi_ctrl_bvalid => NLW_U0_s_axi_ctrl_bvalid_UNCONNECTED,
      s_axi_ctrl_rdata(31 downto 0) => NLW_U0_s_axi_ctrl_rdata_UNCONNECTED(31 downto 0),
      s_axi_ctrl_rready => \<const0>\,
      s_axi_ctrl_rresp(1 downto 0) => NLW_U0_s_axi_ctrl_rresp_UNCONNECTED(1 downto 0),
      s_axi_ctrl_rvalid => NLW_U0_s_axi_ctrl_rvalid_UNCONNECTED,
      s_axi_ctrl_wdata(31) => \<const0>\,
      s_axi_ctrl_wdata(30) => \<const0>\,
      s_axi_ctrl_wdata(29) => \<const0>\,
      s_axi_ctrl_wdata(28) => \<const0>\,
      s_axi_ctrl_wdata(27) => \<const0>\,
      s_axi_ctrl_wdata(26) => \<const0>\,
      s_axi_ctrl_wdata(25) => \<const0>\,
      s_axi_ctrl_wdata(24) => \<const0>\,
      s_axi_ctrl_wdata(23) => \<const0>\,
      s_axi_ctrl_wdata(22) => \<const0>\,
      s_axi_ctrl_wdata(21) => \<const0>\,
      s_axi_ctrl_wdata(20) => \<const0>\,
      s_axi_ctrl_wdata(19) => \<const0>\,
      s_axi_ctrl_wdata(18) => \<const0>\,
      s_axi_ctrl_wdata(17) => \<const0>\,
      s_axi_ctrl_wdata(16) => \<const0>\,
      s_axi_ctrl_wdata(15) => \<const0>\,
      s_axi_ctrl_wdata(14) => \<const0>\,
      s_axi_ctrl_wdata(13) => \<const0>\,
      s_axi_ctrl_wdata(12) => \<const0>\,
      s_axi_ctrl_wdata(11) => \<const0>\,
      s_axi_ctrl_wdata(10) => \<const0>\,
      s_axi_ctrl_wdata(9) => \<const0>\,
      s_axi_ctrl_wdata(8) => \<const0>\,
      s_axi_ctrl_wdata(7) => \<const0>\,
      s_axi_ctrl_wdata(6) => \<const0>\,
      s_axi_ctrl_wdata(5) => \<const0>\,
      s_axi_ctrl_wdata(4) => \<const0>\,
      s_axi_ctrl_wdata(3) => \<const0>\,
      s_axi_ctrl_wdata(2) => \<const0>\,
      s_axi_ctrl_wdata(1) => \<const0>\,
      s_axi_ctrl_wdata(0) => \<const0>\,
      s_axi_ctrl_wready => NLW_U0_s_axi_ctrl_wready_UNCONNECTED,
      s_axi_ctrl_wvalid => \<const0>\,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(0) => s_axi_rid(0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
