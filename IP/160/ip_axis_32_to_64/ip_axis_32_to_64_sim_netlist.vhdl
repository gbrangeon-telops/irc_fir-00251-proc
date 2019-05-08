-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Sun May 05 07:12:09 2019
-- Host        : TELOPS228 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/160/ip_axis_32_to_64/ip_axis_32_to_64_sim_netlist.vhdl
-- Design      : ip_axis_32_to_64
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axisc_upsizer is
  port (
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    s_axis_tlast : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axisc_upsizer : entity is "axis_dwidth_converter_v1_1_9_axisc_upsizer";
end ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axisc_upsizer;

architecture STRUCTURE of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axisc_upsizer is
  signal \FSM_onehot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_7_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[0]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[1]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[1]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[3]\ : signal is "yes";
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal acc_data : STD_LOGIC;
  signal \acc_data[63]_i_1_n_0\ : STD_LOGIC;
  signal \acc_id[0]_i_1_n_0\ : STD_LOGIC;
  signal acc_last : STD_LOGIC;
  signal acc_last_i_1_n_0 : STD_LOGIC;
  signal acc_last_i_2_n_0 : STD_LOGIC;
  signal acc_strb : STD_LOGIC;
  signal \acc_strb1__0\ : STD_LOGIC;
  signal id_dest_mismatch0 : STD_LOGIC;
  signal id_dest_mismatch02_in : STD_LOGIC;
  signal \^m_axis_tid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axis_tlast\ : STD_LOGIC;
  signal \next_xfer_is_end__1\ : STD_LOGIC;
  signal p_0_in1_in : STD_LOGIC;
  attribute RTL_KEEP of p_0_in1_in : signal is "yes";
  signal p_1_in : STD_LOGIC;
  attribute RTL_KEEP of p_1_in : signal is "yes";
  signal p_3_in : STD_LOGIC;
  signal r0_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal r0_data_1 : STD_LOGIC;
  signal r0_dest : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal r0_dest_0 : STD_LOGIC;
  signal \r0_id_reg_n_0_[0]\ : STD_LOGIC;
  signal r0_keep : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal r0_last_i_1_n_0 : STD_LOGIC;
  signal r0_last_reg_n_0 : STD_LOGIC;
  signal \r0_reg_sel[0]_i_1_n_0\ : STD_LOGIC;
  signal \r0_reg_sel[1]_i_1_n_0\ : STD_LOGIC;
  signal \r0_reg_sel[1]_i_2_n_0\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[0]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[1]\ : STD_LOGIC;
  signal r0_strb : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal r0_user : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal state : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal state1 : STD_LOGIC;
  signal state110_out : STD_LOGIC;
  signal state112_out : STD_LOGIC;
  signal \state[0]_i_3_n_0\ : STD_LOGIC;
  signal \state[1]_i_2_n_0\ : STD_LOGIC;
  signal \state[1]_i_3_n_0\ : STD_LOGIC;
  signal \state[2]_i_2_n_0\ : STD_LOGIC;
  signal \state[2]_i_3_n_0\ : STD_LOGIC;
  signal \state[2]_i_4_n_0\ : STD_LOGIC;
  signal \state_reg_n_0_[2]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[3]_i_5\ : label is "soft_lutpair1";
  attribute KEEP : string;
  attribute KEEP of \FSM_onehot_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[3]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[4]\ : label is "yes";
  attribute SOFT_HLUTNM of \acc_strb[7]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \state[0]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \state[0]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \state[0]_i_4\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \state[2]_i_3\ : label is "soft_lutpair2";
begin
  Q(1 downto 0) <= \^q\(1 downto 0);
  m_axis_tid(0) <= \^m_axis_tid\(0);
  m_axis_tlast <= \^m_axis_tlast\;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7F7F7F7F7F7F7F2"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => s_axis_tvalid,
      I2 => \FSM_onehot_state_reg_n_0_[1]\,
      I3 => \FSM_onehot_state[0]_i_2_n_0\,
      I4 => \FSM_onehot_state[0]_i_3_n_0\,
      I5 => \FSM_onehot_state[0]_i_4_n_0\,
      O => \FSM_onehot_state[0]_i_1_n_0\
    );
\FSM_onehot_state[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[3]\,
      I1 => p_1_in,
      I2 => p_0_in1_in,
      O => \FSM_onehot_state[0]_i_2_n_0\
    );
\FSM_onehot_state[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => s_axis_tvalid,
      I2 => r0_last_reg_n_0,
      O => \FSM_onehot_state[0]_i_3_n_0\
    );
\FSM_onehot_state[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => s_axis_tvalid,
      I3 => m_axis_tready,
      O => \FSM_onehot_state[0]_i_4_n_0\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000CFCACACA"
    )
        port map (
      I0 => \FSM_onehot_state[2]_i_2_n_0\,
      I1 => state110_out,
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => state112_out,
      I4 => p_0_in1_in,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[2]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000E04"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[3]\,
      I1 => p_1_in,
      I2 => m_axis_tready,
      I3 => s_axis_tvalid,
      I4 => p_0_in1_in,
      O => \FSM_onehot_state[2]_i_2_n_0\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000002222FFF0"
    )
        port map (
      I0 => state1,
      I1 => state110_out,
      I2 => \FSM_onehot_state[3]_i_3_n_0\,
      I3 => \FSM_onehot_state[3]_i_4_n_0\,
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[3]_i_1_n_0\
    );
\FSM_onehot_state[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F800"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => \r0_reg_sel_reg_n_0_[1]\,
      I3 => s_axis_tvalid,
      O => state1
    );
\FSM_onehot_state[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5557444400000000"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => r0_last_reg_n_0,
      I2 => id_dest_mismatch02_in,
      I3 => id_dest_mismatch0,
      I4 => state1,
      I5 => p_0_in1_in,
      O => \FSM_onehot_state[3]_i_3_n_0\
    );
\FSM_onehot_state[3]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
        port map (
      I0 => m_axis_tready,
      I1 => s_axis_tvalid,
      I2 => \FSM_onehot_state_reg_n_0_[3]\,
      I3 => p_0_in1_in,
      O => \FSM_onehot_state[3]_i_4_n_0\
    );
\FSM_onehot_state[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \r0_id_reg_n_0_[0]\,
      I1 => s_axis_tid(0),
      O => id_dest_mismatch02_in
    );
\FSM_onehot_state[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEFEEEEEAAAAAAAA"
    )
        port map (
      I0 => \FSM_onehot_state[4]_i_2_n_0\,
      I1 => \FSM_onehot_state[4]_i_3_n_0\,
      I2 => \FSM_onehot_state[4]_i_4_n_0\,
      I3 => state112_out,
      I4 => \FSM_onehot_state[4]_i_5_n_0\,
      I5 => \FSM_onehot_state[4]_i_6_n_0\,
      O => \FSM_onehot_state[4]_i_1_n_0\
    );
\FSM_onehot_state[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A88A00000000"
    )
        port map (
      I0 => \FSM_onehot_state[4]_i_7_n_0\,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => s_axis_tid(0),
      I3 => \r0_id_reg_n_0_[0]\,
      I4 => id_dest_mismatch0,
      I5 => s_axis_tvalid,
      O => \FSM_onehot_state[4]_i_2_n_0\
    );
\FSM_onehot_state[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"008800C0"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => m_axis_tready,
      I2 => p_1_in,
      I3 => p_0_in1_in,
      I4 => \FSM_onehot_state_reg_n_0_[3]\,
      O => \FSM_onehot_state[4]_i_3_n_0\
    );
\FSM_onehot_state[4]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002A"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => p_0_in1_in,
      I2 => \r0_reg_sel_reg_n_0_[0]\,
      I3 => \r0_reg_sel_reg_n_0_[1]\,
      O => \FSM_onehot_state[4]_i_4_n_0\
    );
\FSM_onehot_state[4]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"101010D0"
    )
        port map (
      I0 => r0_last_reg_n_0,
      I1 => s_axis_tvalid,
      I2 => p_0_in1_in,
      I3 => \r0_reg_sel_reg_n_0_[0]\,
      I4 => \r0_reg_sel_reg_n_0_[1]\,
      O => \FSM_onehot_state[4]_i_5_n_0\
    );
\FSM_onehot_state[4]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[4]_i_6_n_0\
    );
\FSM_onehot_state[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000007FF00000000"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => \r0_reg_sel_reg_n_0_[1]\,
      I3 => s_axis_tvalid,
      I4 => \FSM_onehot_state_reg_n_0_[1]\,
      I5 => \FSM_onehot_state_reg_n_0_[0]\,
      O => \FSM_onehot_state[4]_i_7_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => aclken,
      D => \FSM_onehot_state[0]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[0]\,
      R => SR(0)
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => aclk,
      CE => aclken,
      D => '0',
      Q => \FSM_onehot_state_reg_n_0_[1]\,
      S => SR(0)
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => aclken,
      D => \FSM_onehot_state[2]_i_1_n_0\,
      Q => p_1_in,
      R => SR(0)
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => aclken,
      D => \FSM_onehot_state[3]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[3]\,
      R => SR(0)
    );
\FSM_onehot_state_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => aclken,
      D => \FSM_onehot_state[4]_i_1_n_0\,
      Q => p_0_in1_in,
      R => SR(0)
    );
\acc_data[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => aclken,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => p_0_in1_in,
      O => acc_data
    );
\acc_data[63]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => aclken,
      I1 => p_0_in1_in,
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      O => \acc_data[63]_i_1_n_0\
    );
\acc_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(0),
      Q => m_axis_tdata(0),
      R => '0'
    );
\acc_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(10),
      Q => m_axis_tdata(10),
      R => '0'
    );
\acc_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(11),
      Q => m_axis_tdata(11),
      R => '0'
    );
\acc_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(12),
      Q => m_axis_tdata(12),
      R => '0'
    );
\acc_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(13),
      Q => m_axis_tdata(13),
      R => '0'
    );
\acc_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(14),
      Q => m_axis_tdata(14),
      R => '0'
    );
\acc_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(15),
      Q => m_axis_tdata(15),
      R => '0'
    );
\acc_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(16),
      Q => m_axis_tdata(16),
      R => '0'
    );
\acc_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(17),
      Q => m_axis_tdata(17),
      R => '0'
    );
\acc_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(18),
      Q => m_axis_tdata(18),
      R => '0'
    );
\acc_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(19),
      Q => m_axis_tdata(19),
      R => '0'
    );
\acc_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(1),
      Q => m_axis_tdata(1),
      R => '0'
    );
\acc_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(20),
      Q => m_axis_tdata(20),
      R => '0'
    );
\acc_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(21),
      Q => m_axis_tdata(21),
      R => '0'
    );
\acc_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(22),
      Q => m_axis_tdata(22),
      R => '0'
    );
\acc_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(23),
      Q => m_axis_tdata(23),
      R => '0'
    );
\acc_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(24),
      Q => m_axis_tdata(24),
      R => '0'
    );
\acc_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(25),
      Q => m_axis_tdata(25),
      R => '0'
    );
\acc_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(26),
      Q => m_axis_tdata(26),
      R => '0'
    );
\acc_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(27),
      Q => m_axis_tdata(27),
      R => '0'
    );
\acc_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(28),
      Q => m_axis_tdata(28),
      R => '0'
    );
\acc_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(29),
      Q => m_axis_tdata(29),
      R => '0'
    );
\acc_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(2),
      Q => m_axis_tdata(2),
      R => '0'
    );
\acc_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(30),
      Q => m_axis_tdata(30),
      R => '0'
    );
\acc_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(31),
      Q => m_axis_tdata(31),
      R => '0'
    );
\acc_data_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(0),
      Q => m_axis_tdata(32),
      R => '0'
    );
\acc_data_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(1),
      Q => m_axis_tdata(33),
      R => '0'
    );
\acc_data_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(2),
      Q => m_axis_tdata(34),
      R => '0'
    );
\acc_data_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(3),
      Q => m_axis_tdata(35),
      R => '0'
    );
\acc_data_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(4),
      Q => m_axis_tdata(36),
      R => '0'
    );
\acc_data_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(5),
      Q => m_axis_tdata(37),
      R => '0'
    );
\acc_data_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(6),
      Q => m_axis_tdata(38),
      R => '0'
    );
\acc_data_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(7),
      Q => m_axis_tdata(39),
      R => '0'
    );
\acc_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(3),
      Q => m_axis_tdata(3),
      R => '0'
    );
\acc_data_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(8),
      Q => m_axis_tdata(40),
      R => '0'
    );
\acc_data_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(9),
      Q => m_axis_tdata(41),
      R => '0'
    );
\acc_data_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(10),
      Q => m_axis_tdata(42),
      R => '0'
    );
\acc_data_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(11),
      Q => m_axis_tdata(43),
      R => '0'
    );
\acc_data_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(12),
      Q => m_axis_tdata(44),
      R => '0'
    );
\acc_data_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(13),
      Q => m_axis_tdata(45),
      R => '0'
    );
\acc_data_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(14),
      Q => m_axis_tdata(46),
      R => '0'
    );
\acc_data_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(15),
      Q => m_axis_tdata(47),
      R => '0'
    );
\acc_data_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(16),
      Q => m_axis_tdata(48),
      R => '0'
    );
\acc_data_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(17),
      Q => m_axis_tdata(49),
      R => '0'
    );
\acc_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(4),
      Q => m_axis_tdata(4),
      R => '0'
    );
\acc_data_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(18),
      Q => m_axis_tdata(50),
      R => '0'
    );
\acc_data_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(19),
      Q => m_axis_tdata(51),
      R => '0'
    );
\acc_data_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(20),
      Q => m_axis_tdata(52),
      R => '0'
    );
\acc_data_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(21),
      Q => m_axis_tdata(53),
      R => '0'
    );
\acc_data_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(22),
      Q => m_axis_tdata(54),
      R => '0'
    );
\acc_data_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(23),
      Q => m_axis_tdata(55),
      R => '0'
    );
\acc_data_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(24),
      Q => m_axis_tdata(56),
      R => '0'
    );
\acc_data_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(25),
      Q => m_axis_tdata(57),
      R => '0'
    );
\acc_data_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(26),
      Q => m_axis_tdata(58),
      R => '0'
    );
\acc_data_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(27),
      Q => m_axis_tdata(59),
      R => '0'
    );
\acc_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(5),
      Q => m_axis_tdata(5),
      R => '0'
    );
\acc_data_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(28),
      Q => m_axis_tdata(60),
      R => '0'
    );
\acc_data_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(29),
      Q => m_axis_tdata(61),
      R => '0'
    );
\acc_data_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(30),
      Q => m_axis_tdata(62),
      R => '0'
    );
\acc_data_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tdata(31),
      Q => m_axis_tdata(63),
      R => '0'
    );
\acc_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(6),
      Q => m_axis_tdata(6),
      R => '0'
    );
\acc_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(7),
      Q => m_axis_tdata(7),
      R => '0'
    );
\acc_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(8),
      Q => m_axis_tdata(8),
      R => '0'
    );
\acc_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_data(9),
      Q => m_axis_tdata(9),
      R => '0'
    );
\acc_dest_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_dest(0),
      Q => m_axis_tdest(0),
      R => '0'
    );
\acc_dest_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_dest(1),
      Q => m_axis_tdest(1),
      R => '0'
    );
\acc_dest_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_dest(2),
      Q => m_axis_tdest(2),
      R => '0'
    );
\acc_id[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF8000"
    )
        port map (
      I0 => \r0_id_reg_n_0_[0]\,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => p_0_in1_in,
      I3 => aclken,
      I4 => \^m_axis_tid\(0),
      O => \acc_id[0]_i_1_n_0\
    );
\acc_id_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \acc_id[0]_i_1_n_0\,
      Q => \^m_axis_tid\(0),
      R => '0'
    );
\acc_keep_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_keep(0),
      Q => m_axis_tkeep(0),
      R => '0'
    );
\acc_keep_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_keep(1),
      Q => m_axis_tkeep(1),
      R => '0'
    );
\acc_keep_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_keep(2),
      Q => m_axis_tkeep(2),
      R => '0'
    );
\acc_keep_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_keep(3),
      Q => m_axis_tkeep(3),
      R => '0'
    );
\acc_keep_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tkeep(0),
      Q => m_axis_tkeep(4),
      R => acc_strb
    );
\acc_keep_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tkeep(1),
      Q => m_axis_tkeep(5),
      R => acc_strb
    );
\acc_keep_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tkeep(2),
      Q => m_axis_tkeep(6),
      R => acc_strb
    );
\acc_keep_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tkeep(3),
      Q => m_axis_tkeep(7),
      R => acc_strb
    );
acc_last_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF3F00AAAAAAAA"
    )
        port map (
      I0 => \^m_axis_tlast\,
      I1 => p_3_in,
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => acc_last_i_2_n_0,
      I4 => \acc_strb1__0\,
      I5 => acc_last,
      O => acc_last_i_1_n_0
    );
acc_last_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BAABFFFF8AA80000"
    )
        port map (
      I0 => r0_last_reg_n_0,
      I1 => id_dest_mismatch0,
      I2 => \r0_id_reg_n_0_[0]\,
      I3 => s_axis_tid(0),
      I4 => p_0_in1_in,
      I5 => s_axis_tlast,
      O => acc_last_i_2_n_0
    );
acc_last_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => r0_last_reg_n_0,
      O => \acc_strb1__0\
    );
acc_last_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => aclken,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => p_1_in,
      O => acc_last
    );
acc_last_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => acc_last_i_1_n_0,
      Q => \^m_axis_tlast\,
      R => '0'
    );
\acc_strb[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A888A800"
    )
        port map (
      I0 => aclken,
      I1 => p_0_in1_in,
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => p_3_in,
      I4 => r0_last_reg_n_0,
      O => acc_strb
    );
\acc_strb[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F6"
    )
        port map (
      I0 => s_axis_tid(0),
      I1 => \r0_id_reg_n_0_[0]\,
      I2 => id_dest_mismatch0,
      O => p_3_in
    );
\acc_strb_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_strb(0),
      Q => m_axis_tstrb(0),
      R => '0'
    );
\acc_strb_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_strb(1),
      Q => m_axis_tstrb(1),
      R => '0'
    );
\acc_strb_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_strb(2),
      Q => m_axis_tstrb(2),
      R => '0'
    );
\acc_strb_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_strb(3),
      Q => m_axis_tstrb(3),
      R => '0'
    );
\acc_strb_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tstrb(0),
      Q => m_axis_tstrb(4),
      R => acc_strb
    );
\acc_strb_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tstrb(1),
      Q => m_axis_tstrb(5),
      R => acc_strb
    );
\acc_strb_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tstrb(2),
      Q => m_axis_tstrb(6),
      R => acc_strb
    );
\acc_strb_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tstrb(3),
      Q => m_axis_tstrb(7),
      R => acc_strb
    );
\acc_user_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(0),
      Q => m_axis_tuser(0),
      R => '0'
    );
\acc_user_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(2),
      Q => m_axis_tuser(10),
      R => '0'
    );
\acc_user_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(3),
      Q => m_axis_tuser(11),
      R => '0'
    );
\acc_user_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(4),
      Q => m_axis_tuser(12),
      R => '0'
    );
\acc_user_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(5),
      Q => m_axis_tuser(13),
      R => '0'
    );
\acc_user_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(6),
      Q => m_axis_tuser(14),
      R => '0'
    );
\acc_user_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(7),
      Q => m_axis_tuser(15),
      R => '0'
    );
\acc_user_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(1),
      Q => m_axis_tuser(1),
      R => '0'
    );
\acc_user_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(2),
      Q => m_axis_tuser(2),
      R => '0'
    );
\acc_user_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(3),
      Q => m_axis_tuser(3),
      R => '0'
    );
\acc_user_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(4),
      Q => m_axis_tuser(4),
      R => '0'
    );
\acc_user_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(5),
      Q => m_axis_tuser(5),
      R => '0'
    );
\acc_user_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(6),
      Q => m_axis_tuser(6),
      R => '0'
    );
\acc_user_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_data,
      D => r0_user(7),
      Q => m_axis_tuser(7),
      R => '0'
    );
\acc_user_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(0),
      Q => m_axis_tuser(8),
      R => '0'
    );
\acc_user_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[63]_i_1_n_0\,
      D => s_axis_tuser(1),
      Q => m_axis_tuser(9),
      R => '0'
    );
\r0_data[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aclken,
      I1 => \^q\(0),
      O => r0_data_1
    );
\r0_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(0),
      Q => r0_data(0),
      R => '0'
    );
\r0_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(10),
      Q => r0_data(10),
      R => '0'
    );
\r0_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(11),
      Q => r0_data(11),
      R => '0'
    );
\r0_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(12),
      Q => r0_data(12),
      R => '0'
    );
\r0_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(13),
      Q => r0_data(13),
      R => '0'
    );
\r0_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(14),
      Q => r0_data(14),
      R => '0'
    );
\r0_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(15),
      Q => r0_data(15),
      R => '0'
    );
\r0_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(16),
      Q => r0_data(16),
      R => '0'
    );
\r0_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(17),
      Q => r0_data(17),
      R => '0'
    );
\r0_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(18),
      Q => r0_data(18),
      R => '0'
    );
\r0_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(19),
      Q => r0_data(19),
      R => '0'
    );
\r0_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(1),
      Q => r0_data(1),
      R => '0'
    );
\r0_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(20),
      Q => r0_data(20),
      R => '0'
    );
\r0_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(21),
      Q => r0_data(21),
      R => '0'
    );
\r0_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(22),
      Q => r0_data(22),
      R => '0'
    );
\r0_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(23),
      Q => r0_data(23),
      R => '0'
    );
\r0_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(24),
      Q => r0_data(24),
      R => '0'
    );
\r0_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(25),
      Q => r0_data(25),
      R => '0'
    );
\r0_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(26),
      Q => r0_data(26),
      R => '0'
    );
\r0_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(27),
      Q => r0_data(27),
      R => '0'
    );
\r0_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(28),
      Q => r0_data(28),
      R => '0'
    );
\r0_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(29),
      Q => r0_data(29),
      R => '0'
    );
\r0_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(2),
      Q => r0_data(2),
      R => '0'
    );
\r0_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(30),
      Q => r0_data(30),
      R => '0'
    );
\r0_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(31),
      Q => r0_data(31),
      R => '0'
    );
\r0_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(3),
      Q => r0_data(3),
      R => '0'
    );
\r0_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(4),
      Q => r0_data(4),
      R => '0'
    );
\r0_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(5),
      Q => r0_data(5),
      R => '0'
    );
\r0_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(6),
      Q => r0_data(6),
      R => '0'
    );
\r0_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(7),
      Q => r0_data(7),
      R => '0'
    );
\r0_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(8),
      Q => r0_data(8),
      R => '0'
    );
\r0_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tdata(9),
      Q => r0_data(9),
      R => '0'
    );
\r0_dest[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => aclken,
      I1 => s_axis_tvalid,
      I2 => \^q\(0),
      O => r0_dest_0
    );
\r0_dest_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_dest_0,
      D => s_axis_tdest(0),
      Q => r0_dest(0),
      R => '0'
    );
\r0_dest_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_dest_0,
      D => s_axis_tdest(1),
      Q => r0_dest(1),
      R => '0'
    );
\r0_dest_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_dest_0,
      D => s_axis_tdest(2),
      Q => r0_dest(2),
      R => '0'
    );
\r0_id_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_dest_0,
      D => s_axis_tid(0),
      Q => \r0_id_reg_n_0_[0]\,
      R => '0'
    );
\r0_keep_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tkeep(0),
      Q => r0_keep(0),
      R => '0'
    );
\r0_keep_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tkeep(1),
      Q => r0_keep(1),
      R => '0'
    );
\r0_keep_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tkeep(2),
      Q => r0_keep(2),
      R => '0'
    );
\r0_keep_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tkeep(3),
      Q => r0_keep(3),
      R => '0'
    );
r0_last_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
        port map (
      I0 => s_axis_tlast,
      I1 => \^q\(0),
      I2 => aclken,
      I3 => r0_last_reg_n_0,
      O => r0_last_i_1_n_0
    );
r0_last_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => r0_last_i_1_n_0,
      Q => r0_last_reg_n_0,
      R => '0'
    );
\r0_reg_sel[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFA2A2A2A"
    )
        port map (
      I0 => \r0_reg_sel_reg_n_0_[0]\,
      I1 => p_0_in1_in,
      I2 => aclken,
      I3 => m_axis_tready,
      I4 => \^q\(1),
      I5 => SR(0),
      O => \r0_reg_sel[0]_i_1_n_0\
    );
\r0_reg_sel[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000EA2A"
    )
        port map (
      I0 => \r0_reg_sel_reg_n_0_[1]\,
      I1 => p_0_in1_in,
      I2 => aclken,
      I3 => \r0_reg_sel_reg_n_0_[0]\,
      I4 => \r0_reg_sel[1]_i_2_n_0\,
      O => \r0_reg_sel[1]_i_1_n_0\
    );
\r0_reg_sel[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EAAA"
    )
        port map (
      I0 => SR(0),
      I1 => \^q\(1),
      I2 => m_axis_tready,
      I3 => aclken,
      O => \r0_reg_sel[1]_i_2_n_0\
    );
\r0_reg_sel_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \r0_reg_sel[0]_i_1_n_0\,
      Q => \r0_reg_sel_reg_n_0_[0]\,
      R => '0'
    );
\r0_reg_sel_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \r0_reg_sel[1]_i_1_n_0\,
      Q => \r0_reg_sel_reg_n_0_[1]\,
      R => '0'
    );
\r0_strb_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tstrb(0),
      Q => r0_strb(0),
      R => '0'
    );
\r0_strb_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tstrb(1),
      Q => r0_strb(1),
      R => '0'
    );
\r0_strb_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tstrb(2),
      Q => r0_strb(2),
      R => '0'
    );
\r0_strb_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tstrb(3),
      Q => r0_strb(3),
      R => '0'
    );
\r0_user_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(0),
      Q => r0_user(0),
      R => '0'
    );
\r0_user_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(1),
      Q => r0_user(1),
      R => '0'
    );
\r0_user_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(2),
      Q => r0_user(2),
      R => '0'
    );
\r0_user_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(3),
      Q => r0_user(3),
      R => '0'
    );
\r0_user_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(4),
      Q => r0_user(4),
      R => '0'
    );
\r0_user_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(5),
      Q => r0_user(5),
      R => '0'
    );
\r0_user_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(6),
      Q => r0_user(6),
      R => '0'
    );
\r0_user_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => r0_data_1,
      D => s_axis_tuser(7),
      Q => r0_user(7),
      R => '0'
    );
\state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0C5FFCFFFC5FFCF"
    )
        port map (
      I0 => state110_out,
      I1 => \state[0]_i_3_n_0\,
      I2 => \^q\(1),
      I3 => \state_reg_n_0_[2]\,
      I4 => \^q\(0),
      I5 => state112_out,
      O => state(0)
    );
\state[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55140000"
    )
        port map (
      I0 => \r0_reg_sel_reg_n_0_[0]\,
      I1 => s_axis_tid(0),
      I2 => \r0_id_reg_n_0_[0]\,
      I3 => id_dest_mismatch0,
      I4 => s_axis_tvalid,
      O => state110_out
    );
\state[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => \^q\(0),
      I2 => m_axis_tready,
      O => \state[0]_i_3_n_0\
    );
\state[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAA8AA8"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => r0_last_reg_n_0,
      I2 => s_axis_tid(0),
      I3 => \r0_id_reg_n_0_[0]\,
      I4 => id_dest_mismatch0,
      O => state112_out
    );
\state[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => s_axis_tdest(0),
      I1 => r0_dest(0),
      I2 => r0_dest(2),
      I3 => s_axis_tdest(2),
      I4 => r0_dest(1),
      I5 => s_axis_tdest(1),
      O => id_dest_mismatch0
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F5C0050005C0050"
    )
        port map (
      I0 => m_axis_tready,
      I1 => \state[1]_i_2_n_0\,
      I2 => \^q\(1),
      I3 => \state_reg_n_0_[2]\,
      I4 => \^q\(0),
      I5 => \state[1]_i_3_n_0\,
      O => state(1)
    );
\state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAEAEEEEEA"
    )
        port map (
      I0 => state1,
      I1 => s_axis_tvalid,
      I2 => id_dest_mismatch0,
      I3 => \r0_id_reg_n_0_[0]\,
      I4 => s_axis_tid(0),
      I5 => \r0_reg_sel_reg_n_0_[0]\,
      O => \state[1]_i_2_n_0\
    );
\state[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFEFFFFAAAA"
    )
        port map (
      I0 => state1,
      I1 => id_dest_mismatch0,
      I2 => \r0_id_reg_n_0_[0]\,
      I3 => s_axis_tid(0),
      I4 => r0_last_reg_n_0,
      I5 => s_axis_tvalid,
      O => \state[1]_i_3_n_0\
    );
\state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0FCA00C000CA00C0"
    )
        port map (
      I0 => \state[2]_i_2_n_0\,
      I1 => \state[2]_i_3_n_0\,
      I2 => \^q\(1),
      I3 => \state_reg_n_0_[2]\,
      I4 => \^q\(0),
      I5 => \state[2]_i_4_n_0\,
      O => state(2)
    );
\state[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AAEB0000"
    )
        port map (
      I0 => \r0_reg_sel_reg_n_0_[0]\,
      I1 => s_axis_tid(0),
      I2 => \r0_id_reg_n_0_[0]\,
      I3 => id_dest_mismatch0,
      I4 => s_axis_tvalid,
      I5 => state1,
      O => \state[2]_i_2_n_0\
    );
\state[2]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => \^q\(0),
      I2 => m_axis_tready,
      O => \state[2]_i_3_n_0\
    );
\state[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000002002"
    )
        port map (
      I0 => s_axis_tvalid,
      I1 => r0_last_reg_n_0,
      I2 => s_axis_tid(0),
      I3 => \r0_id_reg_n_0_[0]\,
      I4 => id_dest_mismatch0,
      I5 => \next_xfer_is_end__1\,
      O => \state[2]_i_4_n_0\
    );
\state[2]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => \r0_reg_sel_reg_n_0_[1]\,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => p_0_in1_in,
      O => \next_xfer_is_end__1\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => state(0),
      Q => \^q\(0),
      R => SR(0)
    );
\state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => state(1),
      Q => \^q\(1),
      R => SR(0)
    );
\state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => state(2),
      Q => \state_reg_n_0_[2]\,
      R => SR(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is "32'b00000000000000000000000011111111";
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is "kintex7";
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 64;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 16;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 32;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 8;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is "axis_dwidth_converter_v1_1_9_axis_dwidth_converter";
  attribute P_AXIS_SIGNAL_SET : string;
  attribute P_AXIS_SIGNAL_SET of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is "32'b00000000000000000000000011111111";
  attribute P_D1_REG_CONFIG : integer;
  attribute P_D1_REG_CONFIG of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 0;
  attribute P_D1_TUSER_WIDTH : integer;
  attribute P_D1_TUSER_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 8;
  attribute P_D2_TDATA_WIDTH : integer;
  attribute P_D2_TDATA_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 64;
  attribute P_D2_TUSER_WIDTH : integer;
  attribute P_D2_TUSER_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 16;
  attribute P_D3_REG_CONFIG : integer;
  attribute P_D3_REG_CONFIG of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 0;
  attribute P_D3_TUSER_WIDTH : integer;
  attribute P_D3_TUSER_WIDTH of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 16;
  attribute P_M_RATIO : integer;
  attribute P_M_RATIO of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 1;
  attribute P_SS_TKEEP_REQUIRED : integer;
  attribute P_SS_TKEEP_REQUIRED of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 8;
  attribute P_S_RATIO : integer;
  attribute P_S_RATIO of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter : entity is 2;
end ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter;

architecture STRUCTURE of ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter is
  signal areset_r : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
begin
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
      CE => '1',
      D => p_0_in,
      Q => areset_r,
      R => '0'
    );
\gen_upsizer_conversion.axisc_upsizer_0\: entity work.ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axisc_upsizer
     port map (
      Q(1) => m_axis_tvalid,
      Q(0) => s_axis_tready,
      SR(0) => areset_r,
      aclk => aclk,
      aclken => aclken,
      m_axis_tdata(63 downto 0) => m_axis_tdata(63 downto 0),
      m_axis_tdest(2 downto 0) => m_axis_tdest(2 downto 0),
      m_axis_tid(0) => m_axis_tid(0),
      m_axis_tkeep(7 downto 0) => m_axis_tkeep(7 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(7 downto 0) => m_axis_tstrb(7 downto 0),
      m_axis_tuser(15 downto 0) => m_axis_tuser(15 downto 0),
      s_axis_tdata(31 downto 0) => s_axis_tdata(31 downto 0),
      s_axis_tdest(2 downto 0) => s_axis_tdest(2 downto 0),
      s_axis_tid(0) => s_axis_tid(0),
      s_axis_tkeep(3 downto 0) => s_axis_tkeep(3 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tstrb(3 downto 0) => s_axis_tstrb(3 downto 0),
      s_axis_tuser(7 downto 0) => s_axis_tuser(7 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis_32_to_64 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axis_32_to_64 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axis_32_to_64 : entity is "ip_axis_32_to_64,axis_dwidth_converter_v1_1_9_axis_dwidth_converter,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis_32_to_64 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ip_axis_32_to_64 : entity is "axis_dwidth_converter_v1_1_9_axis_dwidth_converter,Vivado 2016.3";
end ip_axis_32_to_64;

architecture STRUCTURE of ip_axis_32_to_64 is
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000011111111";
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "kintex7";
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of inst : label is 64;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of inst : label is 16;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of inst : label is 32;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of inst : label is 8;
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
  attribute P_D1_TUSER_WIDTH of inst : label is 8;
  attribute P_D2_TDATA_WIDTH : integer;
  attribute P_D2_TDATA_WIDTH of inst : label is 64;
  attribute P_D2_TUSER_WIDTH : integer;
  attribute P_D2_TUSER_WIDTH of inst : label is 16;
  attribute P_D3_REG_CONFIG : integer;
  attribute P_D3_REG_CONFIG of inst : label is 0;
  attribute P_D3_TUSER_WIDTH : integer;
  attribute P_D3_TUSER_WIDTH of inst : label is 16;
  attribute P_M_RATIO : integer;
  attribute P_M_RATIO of inst : label is 1;
  attribute P_SS_TKEEP_REQUIRED : integer;
  attribute P_SS_TKEEP_REQUIRED of inst : label is 8;
  attribute P_S_RATIO : integer;
  attribute P_S_RATIO of inst : label is 2;
begin
inst: entity work.ip_axis_32_to_64_axis_dwidth_converter_v1_1_9_axis_dwidth_converter
     port map (
      aclk => aclk,
      aclken => '1',
      aresetn => aresetn,
      m_axis_tdata(63 downto 0) => m_axis_tdata(63 downto 0),
      m_axis_tdest(2 downto 0) => m_axis_tdest(2 downto 0),
      m_axis_tid(0) => m_axis_tid(0),
      m_axis_tkeep(7 downto 0) => m_axis_tkeep(7 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(7 downto 0) => m_axis_tstrb(7 downto 0),
      m_axis_tuser(15 downto 0) => m_axis_tuser(15 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tdata(31 downto 0) => s_axis_tdata(31 downto 0),
      s_axis_tdest(2 downto 0) => s_axis_tdest(2 downto 0),
      s_axis_tid(0) => s_axis_tid(0),
      s_axis_tkeep(3 downto 0) => s_axis_tkeep(3 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(3 downto 0) => s_axis_tstrb(3 downto 0),
      s_axis_tuser(7 downto 0) => s_axis_tuser(7 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
