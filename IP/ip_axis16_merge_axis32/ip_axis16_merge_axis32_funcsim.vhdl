-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Thu Oct 06 15:39:01 2016
-- Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/ip_axis16_merge_axis32/ip_axis16_merge_axis32_funcsim.vhdl
-- Design      : ip_axis16_merge_axis32
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axisc_upsizer is
  port (
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tready : out STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tlast : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tready : in STD_LOGIC;
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axisc_upsizer;

architecture STRUCTURE of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axisc_upsizer is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal acc_last : STD_LOGIC;
  signal acc_last4_out : STD_LOGIC;
  signal \^m_axis_tid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axis_tlast\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[1]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[2]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[2]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[2]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[2]_i_5\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[2]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[3]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[3]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[3]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[3]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[3]_i_5\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[3]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[4]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[4]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[4]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[4]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[4]_i_5\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state[4]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state_reg[0]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state_reg[1]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state_reg[2]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state_reg[3]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_state_reg[4]\ : STD_LOGIC;
  signal \n_0_acc_data[15]_i_1\ : STD_LOGIC;
  signal \n_0_acc_data[31]_i_1\ : STD_LOGIC;
  signal \n_0_acc_id[0]_i_1\ : STD_LOGIC;
  signal \n_0_acc_id[0]_i_2\ : STD_LOGIC;
  signal n_0_acc_last_i_1 : STD_LOGIC;
  signal n_0_acc_last_i_4 : STD_LOGIC;
  signal n_0_acc_last_i_5 : STD_LOGIC;
  signal n_0_acc_last_i_6 : STD_LOGIC;
  signal n_0_acc_last_i_7 : STD_LOGIC;
  signal \n_0_acc_strb[3]_i_1\ : STD_LOGIC;
  signal \n_0_acc_strb[3]_i_2\ : STD_LOGIC;
  signal \n_0_acc_strb[3]_i_3\ : STD_LOGIC;
  signal \n_0_r0_data[15]_i_1\ : STD_LOGIC;
  signal \n_0_r0_dest[0]_i_1\ : STD_LOGIC;
  signal \n_0_r0_dest[1]_i_1\ : STD_LOGIC;
  signal \n_0_r0_dest[2]_i_1\ : STD_LOGIC;
  signal \n_0_r0_dest[2]_i_2\ : STD_LOGIC;
  signal \n_0_r0_id[0]_i_1\ : STD_LOGIC;
  signal \n_0_r0_id_reg[0]\ : STD_LOGIC;
  signal n_0_r0_last_i_1 : STD_LOGIC;
  signal n_0_r0_last_reg : STD_LOGIC;
  signal \n_0_r0_reg_sel[0]_i_1\ : STD_LOGIC;
  signal \n_0_r0_reg_sel[1]_i_1\ : STD_LOGIC;
  signal \n_0_r0_reg_sel[1]_i_2\ : STD_LOGIC;
  signal \n_0_r0_reg_sel[1]_i_3\ : STD_LOGIC;
  signal \n_0_r0_reg_sel_reg[0]\ : STD_LOGIC;
  signal \n_0_r0_reg_sel_reg[1]\ : STD_LOGIC;
  signal r0_data : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal r0_dest : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal r0_keep : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal r0_strb : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal r0_user : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[2]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \FSM_onehot_state[2]_i_6\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \FSM_onehot_state[3]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_onehot_state[3]_i_6\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_4\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_5\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_6\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \acc_id[0]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of acc_last_i_3 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of acc_last_i_5 : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of acc_last_i_6 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of acc_last_i_7 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \acc_strb[3]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of m_axis_tvalid_INST_0 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \r0_dest[2]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \r0_reg_sel[1]_i_3\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of s_axis_tready_INST_0 : label is "soft_lutpair8";
begin
  O1 <= \^o1\;
  m_axis_tid(0) <= \^m_axis_tid\(0);
  m_axis_tlast <= \^m_axis_tlast\;
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000002222222E"
    )
    port map (
      I0 => \n_0_FSM_onehot_state[1]_i_2\,
      I1 => \n_0_FSM_onehot_state_reg[0]\,
      I2 => \n_0_FSM_onehot_state_reg[2]\,
      I3 => \n_0_FSM_onehot_state_reg[1]\,
      I4 => \n_0_FSM_onehot_state_reg[3]\,
      I5 => \n_0_FSM_onehot_state_reg[4]\,
      O => \n_0_FSM_onehot_state[1]_i_1\
    );
\FSM_onehot_state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00010001005A000A"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[1]\,
      I1 => n_0_r0_last_reg,
      I2 => \n_0_FSM_onehot_state_reg[3]\,
      I3 => s_axis_tvalid,
      I4 => m_axis_tready,
      I5 => \n_0_FSM_onehot_state_reg[2]\,
      O => \n_0_FSM_onehot_state[1]_i_2\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0075000000FF00FF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state[2]_i_2\,
      I1 => \n_0_FSM_onehot_state[3]_i_3\,
      I2 => \n_0_FSM_onehot_state[2]_i_3\,
      I3 => \n_0_FSM_onehot_state_reg[0]\,
      I4 => \n_0_FSM_onehot_state[2]_i_4\,
      I5 => \n_0_FSM_onehot_state[2]_i_5\,
      O => \n_0_FSM_onehot_state[2]_i_1\
    );
\FSM_onehot_state[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF4044FFFF"
    )
    port map (
      I0 => \n_0_r0_reg_sel_reg[0]\,
      I1 => s_axis_tvalid,
      I2 => n_0_acc_last_i_7,
      I3 => \n_0_acc_strb[3]_i_3\,
      I4 => \n_0_FSM_onehot_state_reg[1]\,
      I5 => \n_0_FSM_onehot_state[4]_i_4\,
      O => \n_0_FSM_onehot_state[2]_i_2\
    );
\FSM_onehot_state[2]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0151"
    )
    port map (
      I0 => \n_0_FSM_onehot_state[2]_i_6\,
      I1 => n_0_r0_last_reg,
      I2 => s_axis_tvalid,
      I3 => \n_0_FSM_onehot_state[3]_i_6\,
      O => \n_0_FSM_onehot_state[2]_i_3\
    );
\FSM_onehot_state[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFF70000"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => \n_0_r0_reg_sel_reg[0]\,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      I4 => s_axis_tvalid,
      I5 => \n_0_r0_reg_sel_reg[1]\,
      O => \n_0_FSM_onehot_state[2]_i_4\
    );
\FSM_onehot_state[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF9DFF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[4]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => s_axis_tvalid,
      I3 => m_axis_tready,
      I4 => \n_0_FSM_onehot_state_reg[2]\,
      I5 => \n_0_FSM_onehot_state_reg[1]\,
      O => \n_0_FSM_onehot_state[2]_i_5\
    );
\FSM_onehot_state[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => \n_0_FSM_onehot_state_reg[1]\,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      O => \n_0_FSM_onehot_state[2]_i_6\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000444555554445"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[0]\,
      I1 => \n_0_FSM_onehot_state[3]_i_2\,
      I2 => \n_0_FSM_onehot_state[3]_i_3\,
      I3 => \n_0_FSM_onehot_state[3]_i_4\,
      I4 => \n_0_FSM_onehot_state_reg[1]\,
      I5 => \n_0_FSM_onehot_state[3]_i_5\,
      O => \n_0_FSM_onehot_state[3]_i_1\
    );
\FSM_onehot_state[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => m_axis_tready,
      I2 => s_axis_tvalid,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      I4 => \n_0_FSM_onehot_state_reg[4]\,
      O => \n_0_FSM_onehot_state[3]_i_2\
    );
\FSM_onehot_state[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => s_axis_tvalid,
      I1 => n_0_acc_last_i_7,
      I2 => \n_0_acc_strb[3]_i_3\,
      I3 => n_0_r0_last_reg,
      O => \n_0_FSM_onehot_state[3]_i_3\
    );
\FSM_onehot_state[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FDFDFDFFFFFFFDFF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      I3 => n_0_r0_last_reg,
      I4 => s_axis_tvalid,
      I5 => \n_0_FSM_onehot_state[3]_i_6\,
      O => \n_0_FSM_onehot_state[3]_i_4\
    );
\FSM_onehot_state[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAFBFFFFFFFFFFFF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state[4]_i_4\,
      I1 => \n_0_acc_strb[3]_i_3\,
      I2 => n_0_acc_last_i_7,
      I3 => \n_0_r0_reg_sel_reg[0]\,
      I4 => s_axis_tvalid,
      I5 => \n_0_FSM_onehot_state[3]_i_6\,
      O => \n_0_FSM_onehot_state[3]_i_5\
    );
\FSM_onehot_state[3]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ABAAAAAA"
    )
    port map (
      I0 => \n_0_r0_reg_sel_reg[1]\,
      I1 => \n_0_FSM_onehot_state_reg[4]\,
      I2 => \n_0_FSM_onehot_state_reg[3]\,
      I3 => \n_0_FSM_onehot_state_reg[2]\,
      I4 => \n_0_r0_reg_sel_reg[0]\,
      O => \n_0_FSM_onehot_state[3]_i_6\
    );
\FSM_onehot_state[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0101010101015101"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[0]\,
      I1 => \n_0_FSM_onehot_state[4]_i_2\,
      I2 => \n_0_FSM_onehot_state_reg[1]\,
      I3 => \n_0_acc_strb[3]_i_2\,
      I4 => \n_0_FSM_onehot_state[4]_i_3\,
      I5 => \n_0_FSM_onehot_state[4]_i_4\,
      O => \n_0_FSM_onehot_state[4]_i_1\
    );
\FSM_onehot_state[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4545454545455545"
    )
    port map (
      I0 => \n_0_FSM_onehot_state[4]_i_5\,
      I1 => \n_0_FSM_onehot_state[4]_i_6\,
      I2 => s_axis_tvalid,
      I3 => \n_0_acc_strb[3]_i_3\,
      I4 => n_0_acc_last_i_7,
      I5 => n_0_r0_last_reg,
      O => \n_0_FSM_onehot_state[4]_i_2\
    );
\FSM_onehot_state[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => \n_0_r0_reg_sel_reg[0]\,
      I1 => s_axis_tvalid,
      O => \n_0_FSM_onehot_state[4]_i_3\
    );
\FSM_onehot_state[4]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[3]\,
      I1 => \n_0_FSM_onehot_state_reg[2]\,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      O => \n_0_FSM_onehot_state[4]_i_4\
    );
\FSM_onehot_state[4]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01100010"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => m_axis_tready,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      I4 => s_axis_tvalid,
      O => \n_0_FSM_onehot_state[4]_i_5\
    );
\FSM_onehot_state[4]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[4]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => \n_0_FSM_onehot_state_reg[2]\,
      O => \n_0_FSM_onehot_state[4]_i_6\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => aclken,
      D => \<const0>\,
      Q => \n_0_FSM_onehot_state_reg[0]\,
      S => SR(0)
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => aclken,
      D => \n_0_FSM_onehot_state[1]_i_1\,
      Q => \n_0_FSM_onehot_state_reg[1]\,
      R => SR(0)
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => aclken,
      D => \n_0_FSM_onehot_state[2]_i_1\,
      Q => \n_0_FSM_onehot_state_reg[2]\,
      R => SR(0)
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => aclken,
      D => \n_0_FSM_onehot_state[3]_i_1\,
      Q => \n_0_FSM_onehot_state_reg[3]\,
      R => SR(0)
    );
\FSM_onehot_state_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => aclken,
      D => \n_0_FSM_onehot_state[4]_i_1\,
      Q => \n_0_FSM_onehot_state_reg[4]\,
      R => SR(0)
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\acc_data[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000040000000000"
    )
    port map (
      I0 => \^o1\,
      I1 => \n_0_r0_reg_sel_reg[0]\,
      I2 => \n_0_FSM_onehot_state_reg[0]\,
      I3 => aclken,
      I4 => \n_0_FSM_onehot_state_reg[1]\,
      I5 => \n_0_FSM_onehot_state_reg[2]\,
      O => \n_0_acc_data[15]_i_1\
    );
\acc_data[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000E0"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[1]\,
      I1 => \n_0_FSM_onehot_state_reg[2]\,
      I2 => aclken,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      I4 => \n_0_FSM_onehot_state_reg[4]\,
      O => \n_0_acc_data[31]_i_1\
    );
\acc_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(0),
      Q => m_axis_tdata(0),
      R => \<const0>\
    );
\acc_data_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(10),
      Q => m_axis_tdata(10),
      R => \<const0>\
    );
\acc_data_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(11),
      Q => m_axis_tdata(11),
      R => \<const0>\
    );
\acc_data_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(12),
      Q => m_axis_tdata(12),
      R => \<const0>\
    );
\acc_data_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(13),
      Q => m_axis_tdata(13),
      R => \<const0>\
    );
\acc_data_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(14),
      Q => m_axis_tdata(14),
      R => \<const0>\
    );
\acc_data_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(15),
      Q => m_axis_tdata(15),
      R => \<const0>\
    );
\acc_data_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(0),
      Q => m_axis_tdata(16),
      R => \<const0>\
    );
\acc_data_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(1),
      Q => m_axis_tdata(17),
      R => \<const0>\
    );
\acc_data_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(2),
      Q => m_axis_tdata(18),
      R => \<const0>\
    );
\acc_data_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(3),
      Q => m_axis_tdata(19),
      R => \<const0>\
    );
\acc_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(1),
      Q => m_axis_tdata(1),
      R => \<const0>\
    );
\acc_data_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(4),
      Q => m_axis_tdata(20),
      R => \<const0>\
    );
\acc_data_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(5),
      Q => m_axis_tdata(21),
      R => \<const0>\
    );
\acc_data_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(6),
      Q => m_axis_tdata(22),
      R => \<const0>\
    );
\acc_data_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(7),
      Q => m_axis_tdata(23),
      R => \<const0>\
    );
\acc_data_reg[24]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(8),
      Q => m_axis_tdata(24),
      R => \<const0>\
    );
\acc_data_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(9),
      Q => m_axis_tdata(25),
      R => \<const0>\
    );
\acc_data_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(10),
      Q => m_axis_tdata(26),
      R => \<const0>\
    );
\acc_data_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(11),
      Q => m_axis_tdata(27),
      R => \<const0>\
    );
\acc_data_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(12),
      Q => m_axis_tdata(28),
      R => \<const0>\
    );
\acc_data_reg[29]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(13),
      Q => m_axis_tdata(29),
      R => \<const0>\
    );
\acc_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(2),
      Q => m_axis_tdata(2),
      R => \<const0>\
    );
\acc_data_reg[30]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(14),
      Q => m_axis_tdata(30),
      R => \<const0>\
    );
\acc_data_reg[31]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tdata(15),
      Q => m_axis_tdata(31),
      R => \<const0>\
    );
\acc_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(3),
      Q => m_axis_tdata(3),
      R => \<const0>\
    );
\acc_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(4),
      Q => m_axis_tdata(4),
      R => \<const0>\
    );
\acc_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(5),
      Q => m_axis_tdata(5),
      R => \<const0>\
    );
\acc_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(6),
      Q => m_axis_tdata(6),
      R => \<const0>\
    );
\acc_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(7),
      Q => m_axis_tdata(7),
      R => \<const0>\
    );
\acc_data_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(8),
      Q => m_axis_tdata(8),
      R => \<const0>\
    );
\acc_data_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_data(9),
      Q => m_axis_tdata(9),
      R => \<const0>\
    );
\acc_dest_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_dest(0),
      Q => m_axis_tdest(0),
      R => \<const0>\
    );
\acc_dest_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_dest(1),
      Q => m_axis_tdest(1),
      R => \<const0>\
    );
\acc_dest_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_dest(2),
      Q => m_axis_tdest(2),
      R => \<const0>\
    );
\acc_id[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFF00000200"
    )
    port map (
      I0 => \n_0_r0_id_reg[0]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      I3 => \n_0_r0_reg_sel_reg[0]\,
      I4 => \n_0_acc_id[0]_i_2\,
      I5 => \^m_axis_tid\(0),
      O => \n_0_acc_id[0]_i_1\
    );
\acc_id[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => \n_0_FSM_onehot_state_reg[1]\,
      I2 => aclken,
      I3 => \n_0_FSM_onehot_state_reg[0]\,
      O => \n_0_acc_id[0]_i_2\
    );
\acc_id_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_acc_id[0]_i_1\,
      Q => \^m_axis_tid\(0),
      R => \<const0>\
    );
\acc_keep_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_keep(0),
      Q => m_axis_tkeep(0),
      R => \<const0>\
    );
\acc_keep_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_keep(1),
      Q => m_axis_tkeep(1),
      R => \<const0>\
    );
\acc_keep_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tkeep(0),
      Q => m_axis_tkeep(2),
      R => \n_0_acc_strb[3]_i_1\
    );
\acc_keep_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tkeep(1),
      Q => m_axis_tkeep(3),
      R => \n_0_acc_strb[3]_i_1\
    );
acc_last_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3202FFFF32023202"
    )
    port map (
      I0 => \^m_axis_tlast\,
      I1 => acc_last,
      I2 => acc_last4_out,
      I3 => n_0_acc_last_i_4,
      I4 => n_0_acc_last_i_5,
      I5 => aclken,
      O => n_0_acc_last_i_1
    );
acc_last_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007DFFFF7D"
    )
    port map (
      I0 => \n_0_acc_strb[3]_i_3\,
      I1 => r0_dest(2),
      I2 => s_axis_tdest(2),
      I3 => r0_dest(0),
      I4 => s_axis_tdest(0),
      I5 => n_0_acc_last_i_6,
      O => acc_last
    );
acc_last_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"888A"
    )
    port map (
      I0 => aclken,
      I1 => \n_0_FSM_onehot_state_reg[2]\,
      I2 => \n_0_FSM_onehot_state_reg[3]\,
      I3 => \n_0_FSM_onehot_state_reg[4]\,
      O => acc_last4_out
    );
acc_last_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAEFF0000A200"
    )
    port map (
      I0 => n_0_r0_last_reg,
      I1 => \n_0_acc_strb[3]_i_3\,
      I2 => n_0_acc_last_i_7,
      I3 => \n_0_FSM_onehot_state_reg[2]\,
      I4 => \^o1\,
      I5 => s_axis_tlast,
      O => n_0_acc_last_i_4
    );
acc_last_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => \n_0_FSM_onehot_state_reg[4]\,
      I3 => n_0_r0_last_reg,
      O => n_0_acc_last_i_5
    );
acc_last_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFEFFF"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[4]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => aclken,
      I3 => \n_0_FSM_onehot_state_reg[1]\,
      I4 => \n_0_FSM_onehot_state_reg[2]\,
      O => n_0_acc_last_i_6
    );
acc_last_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => r0_dest(2),
      I1 => s_axis_tdest(2),
      I2 => r0_dest(0),
      I3 => s_axis_tdest(0),
      O => n_0_acc_last_i_7
    );
acc_last_reg: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => n_0_acc_last_i_1,
      Q => \^m_axis_tlast\,
      R => \<const0>\
    );
\acc_strb[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888A888888888"
    )
    port map (
      I0 => \n_0_acc_data[31]_i_1\,
      I1 => \n_0_acc_strb[3]_i_2\,
      I2 => \n_0_FSM_onehot_state_reg[2]\,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      I4 => \n_0_FSM_onehot_state_reg[4]\,
      I5 => n_0_r0_last_reg,
      O => \n_0_acc_strb[3]_i_1\
    );
\acc_strb[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6FF6FFFF"
    )
    port map (
      I0 => s_axis_tdest(0),
      I1 => r0_dest(0),
      I2 => s_axis_tdest(2),
      I3 => r0_dest(2),
      I4 => \n_0_acc_strb[3]_i_3\,
      O => \n_0_acc_strb[3]_i_2\
    );
\acc_strb[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => r0_dest(1),
      I1 => s_axis_tdest(1),
      I2 => \n_0_r0_id_reg[0]\,
      I3 => s_axis_tid(0),
      O => \n_0_acc_strb[3]_i_3\
    );
\acc_strb_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_strb(0),
      Q => m_axis_tstrb(0),
      R => \<const0>\
    );
\acc_strb_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_strb(1),
      Q => m_axis_tstrb(1),
      R => \<const0>\
    );
\acc_strb_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tstrb(0),
      Q => m_axis_tstrb(2),
      R => \n_0_acc_strb[3]_i_1\
    );
\acc_strb_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tstrb(1),
      Q => m_axis_tstrb(3),
      R => \n_0_acc_strb[3]_i_1\
    );
\acc_user_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_user(0),
      Q => m_axis_tuser(0),
      R => \<const0>\
    );
\acc_user_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_user(1),
      Q => m_axis_tuser(1),
      R => \<const0>\
    );
\acc_user_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_user(2),
      Q => m_axis_tuser(2),
      R => \<const0>\
    );
\acc_user_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[15]_i_1\,
      D => r0_user(3),
      Q => m_axis_tuser(3),
      R => \<const0>\
    );
\acc_user_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tuser(0),
      Q => m_axis_tuser(4),
      R => \<const0>\
    );
\acc_user_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tuser(1),
      Q => m_axis_tuser(5),
      R => \<const0>\
    );
\acc_user_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tuser(2),
      Q => m_axis_tuser(6),
      R => \<const0>\
    );
\acc_user_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_acc_data[31]_i_1\,
      D => s_axis_tuser(3),
      Q => m_axis_tuser(7),
      R => \<const0>\
    );
m_axis_tvalid_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[3]\,
      I1 => \n_0_FSM_onehot_state_reg[4]\,
      O => \^o1\
    );
\r0_data[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => aclken,
      I1 => \n_0_FSM_onehot_state_reg[2]\,
      I2 => \n_0_FSM_onehot_state_reg[1]\,
      I3 => \n_0_FSM_onehot_state_reg[3]\,
      O => \n_0_r0_data[15]_i_1\
    );
\r0_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(0),
      Q => r0_data(0),
      R => \<const0>\
    );
\r0_data_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(10),
      Q => r0_data(10),
      R => \<const0>\
    );
\r0_data_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(11),
      Q => r0_data(11),
      R => \<const0>\
    );
\r0_data_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(12),
      Q => r0_data(12),
      R => \<const0>\
    );
\r0_data_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(13),
      Q => r0_data(13),
      R => \<const0>\
    );
\r0_data_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(14),
      Q => r0_data(14),
      R => \<const0>\
    );
\r0_data_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(15),
      Q => r0_data(15),
      R => \<const0>\
    );
\r0_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(1),
      Q => r0_data(1),
      R => \<const0>\
    );
\r0_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(2),
      Q => r0_data(2),
      R => \<const0>\
    );
\r0_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(3),
      Q => r0_data(3),
      R => \<const0>\
    );
\r0_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(4),
      Q => r0_data(4),
      R => \<const0>\
    );
\r0_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(5),
      Q => r0_data(5),
      R => \<const0>\
    );
\r0_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(6),
      Q => r0_data(6),
      R => \<const0>\
    );
\r0_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(7),
      Q => r0_data(7),
      R => \<const0>\
    );
\r0_data_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(8),
      Q => r0_data(8),
      R => \<const0>\
    );
\r0_data_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tdata(9),
      Q => r0_data(9),
      R => \<const0>\
    );
\r0_dest[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
    port map (
      I0 => s_axis_tdest(0),
      I1 => \n_0_r0_dest[2]_i_2\,
      I2 => aclken,
      I3 => s_axis_tvalid,
      I4 => r0_dest(0),
      O => \n_0_r0_dest[0]_i_1\
    );
\r0_dest[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
    port map (
      I0 => s_axis_tdest(1),
      I1 => \n_0_r0_dest[2]_i_2\,
      I2 => aclken,
      I3 => s_axis_tvalid,
      I4 => r0_dest(1),
      O => \n_0_r0_dest[1]_i_1\
    );
\r0_dest[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
    port map (
      I0 => s_axis_tdest(2),
      I1 => \n_0_r0_dest[2]_i_2\,
      I2 => aclken,
      I3 => s_axis_tvalid,
      I4 => r0_dest(2),
      O => \n_0_r0_dest[2]_i_1\
    );
\r0_dest[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[3]\,
      I1 => \n_0_FSM_onehot_state_reg[1]\,
      I2 => \n_0_FSM_onehot_state_reg[2]\,
      O => \n_0_r0_dest[2]_i_2\
    );
\r0_dest_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_r0_dest[0]_i_1\,
      Q => r0_dest(0),
      R => \<const0>\
    );
\r0_dest_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_r0_dest[1]_i_1\,
      Q => r0_dest(1),
      R => \<const0>\
    );
\r0_dest_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_r0_dest[2]_i_1\,
      Q => r0_dest(2),
      R => \<const0>\
    );
\r0_id[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
    port map (
      I0 => s_axis_tid(0),
      I1 => \n_0_r0_dest[2]_i_2\,
      I2 => aclken,
      I3 => s_axis_tvalid,
      I4 => \n_0_r0_id_reg[0]\,
      O => \n_0_r0_id[0]_i_1\
    );
\r0_id_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_r0_id[0]_i_1\,
      Q => \n_0_r0_id_reg[0]\,
      R => \<const0>\
    );
\r0_keep_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tkeep(0),
      Q => r0_keep(0),
      R => \<const0>\
    );
\r0_keep_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tkeep(1),
      Q => r0_keep(1),
      R => \<const0>\
    );
r0_last_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBF88888880"
    )
    port map (
      I0 => s_axis_tlast,
      I1 => aclken,
      I2 => \n_0_FSM_onehot_state_reg[2]\,
      I3 => \n_0_FSM_onehot_state_reg[1]\,
      I4 => \n_0_FSM_onehot_state_reg[3]\,
      I5 => n_0_r0_last_reg,
      O => n_0_r0_last_i_1
    );
r0_last_reg: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => n_0_r0_last_i_1,
      Q => n_0_r0_last_reg,
      R => \<const0>\
    );
\r0_reg_sel[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF4444444"
    )
    port map (
      I0 => \n_0_r0_reg_sel[1]_i_2\,
      I1 => \n_0_r0_reg_sel_reg[0]\,
      I2 => \^o1\,
      I3 => aclken,
      I4 => m_axis_tready,
      I5 => SR(0),
      O => \n_0_r0_reg_sel[0]_i_1\
    );
\r0_reg_sel[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000E2"
    )
    port map (
      I0 => \n_0_r0_reg_sel_reg[1]\,
      I1 => \n_0_r0_reg_sel[1]_i_2\,
      I2 => \n_0_r0_reg_sel_reg[0]\,
      I3 => \n_0_r0_reg_sel[1]_i_3\,
      I4 => SR(0),
      O => \n_0_r0_reg_sel[1]_i_1\
    );
\r0_reg_sel[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
    port map (
      I0 => aclken,
      I1 => \n_0_FSM_onehot_state_reg[0]\,
      I2 => \n_0_FSM_onehot_state_reg[3]\,
      I3 => \n_0_FSM_onehot_state_reg[4]\,
      I4 => \n_0_FSM_onehot_state_reg[1]\,
      I5 => \n_0_FSM_onehot_state_reg[2]\,
      O => \n_0_r0_reg_sel[1]_i_2\
    );
\r0_reg_sel[1]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E000"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[4]\,
      I1 => \n_0_FSM_onehot_state_reg[3]\,
      I2 => aclken,
      I3 => m_axis_tready,
      O => \n_0_r0_reg_sel[1]_i_3\
    );
\r0_reg_sel_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_r0_reg_sel[0]_i_1\,
      Q => \n_0_r0_reg_sel_reg[0]\,
      R => \<const0>\
    );
\r0_reg_sel_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_r0_reg_sel[1]_i_1\,
      Q => \n_0_r0_reg_sel_reg[1]\,
      R => \<const0>\
    );
\r0_strb_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tstrb(0),
      Q => r0_strb(0),
      R => \<const0>\
    );
\r0_strb_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tstrb(1),
      Q => r0_strb(1),
      R => \<const0>\
    );
\r0_user_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tuser(0),
      Q => r0_user(0),
      R => \<const0>\
    );
\r0_user_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tuser(1),
      Q => r0_user(1),
      R => \<const0>\
    );
\r0_user_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tuser(2),
      Q => r0_user(2),
      R => \<const0>\
    );
\r0_user_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \n_0_r0_data[15]_i_1\,
      D => s_axis_tuser(3),
      Q => r0_user(3),
      R => \<const0>\
    );
s_axis_tready_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => \n_0_FSM_onehot_state_reg[2]\,
      I1 => \n_0_FSM_onehot_state_reg[1]\,
      I2 => \n_0_FSM_onehot_state_reg[3]\,
      O => s_axis_tready
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is "yes";
  attribute C_FAMILY : string;
  attribute C_FAMILY of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is "kintex7";
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 16;
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 32;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 1;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 3;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 4;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 8;
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is "32'b00000000000000000000000011111111";
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 0;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 1;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 2;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 4;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 5;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 6;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 7;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 1;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 2;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 4;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 16;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 32;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 64;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 2;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 1;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 0;
  attribute P_SS_TKEEP_REQUIRED : integer;
  attribute P_SS_TKEEP_REQUIRED of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 8;
  attribute P_AXIS_SIGNAL_SET : string;
  attribute P_AXIS_SIGNAL_SET of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is "32'b00000000000000000000000011111111";
  attribute P_S_RATIO : integer;
  attribute P_S_RATIO of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 2;
  attribute P_M_RATIO : integer;
  attribute P_M_RATIO of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 1;
  attribute P_D2_TDATA_WIDTH : integer;
  attribute P_D2_TDATA_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 32;
  attribute P_D1_TUSER_WIDTH : integer;
  attribute P_D1_TUSER_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 4;
  attribute P_D2_TUSER_WIDTH : integer;
  attribute P_D2_TUSER_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 8;
  attribute P_D3_TUSER_WIDTH : integer;
  attribute P_D3_TUSER_WIDTH of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 8;
  attribute P_D1_REG_CONFIG : integer;
  attribute P_D1_REG_CONFIG of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 0;
  attribute P_D3_REG_CONFIG : integer;
  attribute P_D3_REG_CONFIG of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter : entity is 0;
end ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter;

architecture STRUCTURE of ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal areset_r : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
areset_r_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => aresetn,
      O => p_0_in
    );
areset_r_reg: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_0_in,
      Q => areset_r,
      R => \<const0>\
    );
\gen_upsizer_conversion.axisc_upsizer_0\: entity work.ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axisc_upsizer
    port map (
      O1 => m_axis_tvalid,
      SR(0) => areset_r,
      aclk => aclk,
      aclken => aclken,
      m_axis_tdata(31 downto 0) => m_axis_tdata(31 downto 0),
      m_axis_tdest(2 downto 0) => m_axis_tdest(2 downto 0),
      m_axis_tid(0) => m_axis_tid(0),
      m_axis_tkeep(3 downto 0) => m_axis_tkeep(3 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(3 downto 0) => m_axis_tstrb(3 downto 0),
      m_axis_tuser(7 downto 0) => m_axis_tuser(7 downto 0),
      s_axis_tdata(15 downto 0) => s_axis_tdata(15 downto 0),
      s_axis_tdest(2 downto 0) => s_axis_tdest(2 downto 0),
      s_axis_tid(0) => s_axis_tid(0),
      s_axis_tkeep(1 downto 0) => s_axis_tkeep(1 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(1 downto 0) => s_axis_tstrb(1 downto 0),
      s_axis_tuser(3 downto 0) => s_axis_tuser(3 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis16_merge_axis32 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axis16_merge_axis32 : entity is true;
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ip_axis16_merge_axis32 : entity is "axis_dwidth_converter_v1_1_axis_dwidth_converter,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axis16_merge_axis32 : entity is "ip_axis16_merge_axis32,axis_dwidth_converter_v1_1_axis_dwidth_converter,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of ip_axis16_merge_axis32 : entity is "ip_axis16_merge_axis32,axis_dwidth_converter_v1_1_axis_dwidth_converter,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axis_dwidth_converter,x_ipVersion=1.1,x_ipCoreRevision=1,x_ipLanguage=VHDL,C_FAMILY=kintex7,C_S_AXIS_TDATA_WIDTH=16,C_M_AXIS_TDATA_WIDTH=32,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=3,C_S_AXIS_TUSER_WIDTH=4,C_M_AXIS_TUSER_WIDTH=8,C_AXIS_SIGNAL_SET=0b11111111}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis16_merge_axis32 : entity is "yes";
end ip_axis16_merge_axis32;

architecture STRUCTURE of ip_axis16_merge_axis32 is
  signal \<const1>\ : STD_LOGIC;
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000011111111";
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "kintex7";
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of inst : label is 32;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of inst : label is 8;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of inst : label is 16;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of inst : label is 4;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of inst : label is true;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute P_AXIS_SIGNAL_SET : string;
  attribute P_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000011111111";
  attribute P_D1_REG_CONFIG : integer;
  attribute P_D1_REG_CONFIG of inst : label is 0;
  attribute P_D1_TUSER_WIDTH : integer;
  attribute P_D1_TUSER_WIDTH of inst : label is 4;
  attribute P_D2_TDATA_WIDTH : integer;
  attribute P_D2_TDATA_WIDTH of inst : label is 32;
  attribute P_D2_TUSER_WIDTH : integer;
  attribute P_D2_TUSER_WIDTH of inst : label is 8;
  attribute P_D3_REG_CONFIG : integer;
  attribute P_D3_REG_CONFIG of inst : label is 0;
  attribute P_D3_TUSER_WIDTH : integer;
  attribute P_D3_TUSER_WIDTH of inst : label is 8;
  attribute P_M_RATIO : integer;
  attribute P_M_RATIO of inst : label is 1;
  attribute P_SS_TKEEP_REQUIRED : integer;
  attribute P_SS_TKEEP_REQUIRED of inst : label is 8;
  attribute P_S_RATIO : integer;
  attribute P_S_RATIO of inst : label is 2;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of inst : label is "xilinx.com:interface:axis:1.0 S_AXIS TREADY";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
inst: entity work.ip_axis16_merge_axis32axis_dwidth_converter_v1_1_axis_dwidth_converter
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      aresetn => aresetn,
      m_axis_tdata(31 downto 0) => m_axis_tdata(31 downto 0),
      m_axis_tdest(2 downto 0) => m_axis_tdest(2 downto 0),
      m_axis_tid(0) => m_axis_tid(0),
      m_axis_tkeep(3 downto 0) => m_axis_tkeep(3 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(3 downto 0) => m_axis_tstrb(3 downto 0),
      m_axis_tuser(7 downto 0) => m_axis_tuser(7 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tdata(15 downto 0) => s_axis_tdata(15 downto 0),
      s_axis_tdest(2 downto 0) => s_axis_tdest(2 downto 0),
      s_axis_tid(0) => s_axis_tid(0),
      s_axis_tkeep(1 downto 0) => s_axis_tkeep(1 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(1 downto 0) => s_axis_tstrb(1 downto 0),
      s_axis_tuser(3 downto 0) => s_axis_tuser(3 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
