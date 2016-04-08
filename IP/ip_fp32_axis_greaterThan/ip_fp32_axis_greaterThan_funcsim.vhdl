-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Fri Apr 08 04:07:17 2016
-- Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/ip_fp32_axis_greaterThan/ip_fp32_axis_greaterThan_funcsim.vhdl
-- Design      : ip_fp32_axis_greaterThan
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_fp32_axis_greaterThanglb_ifx_master is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    areset : in STD_LOGIC;
    wr_enable : in STD_LOGIC;
    wr_data : in STD_LOGIC_VECTOR ( 17 downto 0 );
    ifx_valid : out STD_LOGIC;
    ifx_ready : in STD_LOGIC;
    ifx_data : out STD_LOGIC_VECTOR ( 17 downto 0 );
    full : out STD_LOGIC;
    afull : out STD_LOGIC;
    not_full : out STD_LOGIC;
    not_afull : out STD_LOGIC;
    add : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  attribute WIDTH : integer;
  attribute WIDTH of ip_fp32_axis_greaterThanglb_ifx_master : entity is 18;
  attribute DEPTH : integer;
  attribute DEPTH of ip_fp32_axis_greaterThanglb_ifx_master : entity is 16;
  attribute AFULL_THRESH1 : integer;
  attribute AFULL_THRESH1 of ip_fp32_axis_greaterThanglb_ifx_master : entity is 1;
  attribute AFULL_THRESH0 : integer;
  attribute AFULL_THRESH0 of ip_fp32_axis_greaterThanglb_ifx_master : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_greaterThanglb_ifx_master : entity is "yes";
end ip_fp32_axis_greaterThanglb_ifx_master;

architecture STRUCTURE of ip_fp32_axis_greaterThanglb_ifx_master is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^ifx_valid\ : STD_LOGIC;
  signal \n_0_add_1[0]_i_1\ : STD_LOGIC;
  signal \n_0_add_1[1]_i_1\ : STD_LOGIC;
  signal \n_0_add_1[2]_i_1\ : STD_LOGIC;
  signal \n_0_add_1[2]_i_2\ : STD_LOGIC;
  signal \n_0_add_1[3]_i_1\ : STD_LOGIC;
  signal \n_0_add_1[3]_i_2\ : STD_LOGIC;
  signal \n_0_add_1[3]_i_3\ : STD_LOGIC;
  signal \n_0_add_1[4]_i_1\ : STD_LOGIC;
  signal \n_0_add_1[4]_i_2\ : STD_LOGIC;
  signal \n_0_add_1[4]_i_3\ : STD_LOGIC;
  signal \n_0_add_1[4]_i_4\ : STD_LOGIC;
  signal \n_0_add_1[4]_i_5\ : STD_LOGIC;
  signal \n_0_fifo0/add_1_reg[0]\ : STD_LOGIC;
  signal \n_0_fifo0/add_1_reg[1]\ : STD_LOGIC;
  signal \n_0_fifo0/add_1_reg[2]\ : STD_LOGIC;
  signal \n_0_fifo0/add_1_reg[3]\ : STD_LOGIC;
  signal \n_0_fifo0/add_1_reg[4]\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][0]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][10]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][11]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][12]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][13]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][14]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][15]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][16]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][17]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][1]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][2]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][3]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][4]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][5]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][6]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][7]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][8]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][9]_srl16\ : STD_LOGIC;
  signal n_0_rd_valid_2_i_1 : STD_LOGIC;
  signal rd_enable : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \add_1[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \add_1[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \add_1[2]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \add_1[4]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \add_1[4]_i_4\ : label is "soft_lutpair1";
  attribute register_duplication : string;
  attribute register_duplication of \fifo0/add_1_reg[0]\ : label is "no";
  attribute use_carry_chain : string;
  attribute use_carry_chain of \fifo0/add_1_reg[0]\ : label is "yes";
  attribute use_clock_enable : string;
  attribute use_clock_enable of \fifo0/add_1_reg[0]\ : label is "no";
  attribute use_sync_reset : string;
  attribute use_sync_reset of \fifo0/add_1_reg[0]\ : label is "no";
  attribute register_duplication of \fifo0/add_1_reg[1]\ : label is "no";
  attribute use_carry_chain of \fifo0/add_1_reg[1]\ : label is "yes";
  attribute use_clock_enable of \fifo0/add_1_reg[1]\ : label is "no";
  attribute use_sync_reset of \fifo0/add_1_reg[1]\ : label is "no";
  attribute register_duplication of \fifo0/add_1_reg[2]\ : label is "no";
  attribute use_carry_chain of \fifo0/add_1_reg[2]\ : label is "yes";
  attribute use_clock_enable of \fifo0/add_1_reg[2]\ : label is "no";
  attribute use_sync_reset of \fifo0/add_1_reg[2]\ : label is "no";
  attribute register_duplication of \fifo0/add_1_reg[3]\ : label is "no";
  attribute use_carry_chain of \fifo0/add_1_reg[3]\ : label is "yes";
  attribute use_clock_enable of \fifo0/add_1_reg[3]\ : label is "no";
  attribute use_sync_reset of \fifo0/add_1_reg[3]\ : label is "no";
  attribute register_duplication of \fifo0/add_1_reg[4]\ : label is "no";
  attribute use_carry_chain of \fifo0/add_1_reg[4]\ : label is "yes";
  attribute use_clock_enable of \fifo0/add_1_reg[4]\ : label is "no";
  attribute use_sync_reset of \fifo0/add_1_reg[4]\ : label is "no";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][0]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name : string;
  attribute srl_name of \fifo0/fifo_1_reg[15][0]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][0]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][10]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][10]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][10]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][11]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][11]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][11]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][12]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][12]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][12]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][13]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][13]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][13]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][14]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][14]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][14]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][15]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][15]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][15]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][16]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][16]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][16]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][17]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][17]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][17]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][1]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][1]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][1]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][2]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][2]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][2]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][3]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][3]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][3]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][4]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][4]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][4]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][5]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][5]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][5]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][6]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][6]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][6]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][7]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][7]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][7]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][8]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][8]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][8]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][9]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][9]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][9]_srl16 ";
  attribute use_clock_enable of \fifo0/rd_valid_2_reg\ : label is "no";
  attribute use_sync_reset of \fifo0/rd_valid_2_reg\ : label is "no";
  attribute use_sync_set : string;
  attribute use_sync_set of \fifo0/rd_valid_2_reg\ : label is "no";
  attribute SOFT_HLUTNM of rd_valid_2_i_1 : label is "soft_lutpair2";
begin
  add(4) <= \<const0>\;
  add(3) <= \<const0>\;
  add(2) <= \<const0>\;
  add(1) <= \<const0>\;
  add(0) <= \<const0>\;
  afull <= \<const0>\;
  full <= \<const0>\;
  ifx_valid <= \^ifx_valid\;
  not_afull <= \<const0>\;
  not_full <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\add_1[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4044BFBBBFBB4044"
    )
    port map (
      I0 => \n_0_fifo0/add_1_reg[4]\,
      I1 => aclken,
      I2 => ifx_ready,
      I3 => \^ifx_valid\,
      I4 => \n_0_fifo0/add_1_reg[0]\,
      I5 => wr_enable,
      O => \n_0_add_1[0]_i_1\
    );
\add_1[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BD42"
    )
    port map (
      I0 => \n_0_add_1[2]_i_2\,
      I1 => wr_enable,
      I2 => \n_0_fifo0/add_1_reg[0]\,
      I3 => \n_0_fifo0/add_1_reg[1]\,
      O => \n_0_add_1[1]_i_1\
    );
\add_1[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F708EF10"
    )
    port map (
      I0 => wr_enable,
      I1 => \n_0_fifo0/add_1_reg[0]\,
      I2 => \n_0_add_1[2]_i_2\,
      I3 => \n_0_fifo0/add_1_reg[2]\,
      I4 => \n_0_fifo0/add_1_reg[1]\,
      O => \n_0_add_1[2]_i_1\
    );
\add_1[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00D0"
    )
    port map (
      I0 => \^ifx_valid\,
      I1 => ifx_ready,
      I2 => aclken,
      I3 => \n_0_fifo0/add_1_reg[4]\,
      O => \n_0_add_1[2]_i_2\
    );
\add_1[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"87A5A5A5A5A5A5A5"
    )
    port map (
      I0 => \n_0_add_1[4]_i_3\,
      I1 => \n_0_add_1[3]_i_2\,
      I2 => \n_0_fifo0/add_1_reg[3]\,
      I3 => \n_0_fifo0/add_1_reg[1]\,
      I4 => \n_0_fifo0/add_1_reg[2]\,
      I5 => \n_0_add_1[3]_i_3\,
      O => \n_0_add_1[3]_i_1\
    );
\add_1[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000004044"
    )
    port map (
      I0 => \n_0_fifo0/add_1_reg[4]\,
      I1 => aclken,
      I2 => ifx_ready,
      I3 => \^ifx_valid\,
      I4 => \n_0_fifo0/add_1_reg[0]\,
      I5 => wr_enable,
      O => \n_0_add_1[3]_i_2\
    );
\add_1[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFBB000000000000"
    )
    port map (
      I0 => \n_0_fifo0/add_1_reg[4]\,
      I1 => aclken,
      I2 => ifx_ready,
      I3 => \^ifx_valid\,
      I4 => \n_0_fifo0/add_1_reg[0]\,
      I5 => wr_enable,
      O => \n_0_add_1[3]_i_3\
    );
\add_1[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B4C3"
    )
    port map (
      I0 => \n_0_add_1[4]_i_2\,
      I1 => \n_0_fifo0/add_1_reg[3]\,
      I2 => \n_0_fifo0/add_1_reg[4]\,
      I3 => \n_0_add_1[4]_i_3\,
      O => \n_0_add_1[4]_i_1\
    );
\add_1[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FFFFFF"
    )
    port map (
      I0 => \n_0_fifo0/add_1_reg[1]\,
      I1 => \n_0_fifo0/add_1_reg[2]\,
      I2 => \n_0_add_1[2]_i_2\,
      I3 => \n_0_fifo0/add_1_reg[0]\,
      I4 => wr_enable,
      O => \n_0_add_1[4]_i_2\
    );
\add_1[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
    port map (
      I0 => \n_0_add_1[4]_i_4\,
      I1 => \n_0_fifo0/add_1_reg[1]\,
      I2 => \n_0_fifo0/add_1_reg[2]\,
      I3 => \n_0_add_1[4]_i_5\,
      I4 => \n_0_fifo0/add_1_reg[4]\,
      I5 => aclken,
      O => \n_0_add_1[4]_i_3\
    );
\add_1[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => wr_enable,
      I1 => \n_0_fifo0/add_1_reg[0]\,
      O => \n_0_add_1[4]_i_4\
    );
\add_1[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => ifx_ready,
      I1 => \^ifx_valid\,
      O => \n_0_add_1[4]_i_5\
    );
\fifo0/add_1_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_add_1[0]_i_1\,
      Q => \n_0_fifo0/add_1_reg[0]\,
      S => areset
    );
\fifo0/add_1_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_add_1[1]_i_1\,
      Q => \n_0_fifo0/add_1_reg[1]\,
      S => areset
    );
\fifo0/add_1_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_add_1[2]_i_1\,
      Q => \n_0_fifo0/add_1_reg[2]\,
      S => areset
    );
\fifo0/add_1_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_add_1[3]_i_1\,
      Q => \n_0_fifo0/add_1_reg[3]\,
      S => areset
    );
\fifo0/add_1_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_add_1[4]_i_1\,
      Q => \n_0_fifo0/add_1_reg[4]\,
      S => areset
    );
\fifo0/fifo_1_reg[15][0]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(0),
      Q => \n_0_fifo0/fifo_1_reg[15][0]_srl16\
    );
\fifo0/fifo_1_reg[15][10]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(10),
      Q => \n_0_fifo0/fifo_1_reg[15][10]_srl16\
    );
\fifo0/fifo_1_reg[15][11]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(11),
      Q => \n_0_fifo0/fifo_1_reg[15][11]_srl16\
    );
\fifo0/fifo_1_reg[15][12]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(12),
      Q => \n_0_fifo0/fifo_1_reg[15][12]_srl16\
    );
\fifo0/fifo_1_reg[15][13]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(13),
      Q => \n_0_fifo0/fifo_1_reg[15][13]_srl16\
    );
\fifo0/fifo_1_reg[15][14]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(14),
      Q => \n_0_fifo0/fifo_1_reg[15][14]_srl16\
    );
\fifo0/fifo_1_reg[15][15]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(15),
      Q => \n_0_fifo0/fifo_1_reg[15][15]_srl16\
    );
\fifo0/fifo_1_reg[15][16]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(16),
      Q => \n_0_fifo0/fifo_1_reg[15][16]_srl16\
    );
\fifo0/fifo_1_reg[15][17]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(17),
      Q => \n_0_fifo0/fifo_1_reg[15][17]_srl16\
    );
\fifo0/fifo_1_reg[15][1]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(1),
      Q => \n_0_fifo0/fifo_1_reg[15][1]_srl16\
    );
\fifo0/fifo_1_reg[15][2]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(2),
      Q => \n_0_fifo0/fifo_1_reg[15][2]_srl16\
    );
\fifo0/fifo_1_reg[15][3]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(3),
      Q => \n_0_fifo0/fifo_1_reg[15][3]_srl16\
    );
\fifo0/fifo_1_reg[15][4]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(4),
      Q => \n_0_fifo0/fifo_1_reg[15][4]_srl16\
    );
\fifo0/fifo_1_reg[15][5]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(5),
      Q => \n_0_fifo0/fifo_1_reg[15][5]_srl16\
    );
\fifo0/fifo_1_reg[15][6]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(6),
      Q => \n_0_fifo0/fifo_1_reg[15][6]_srl16\
    );
\fifo0/fifo_1_reg[15][7]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(7),
      Q => \n_0_fifo0/fifo_1_reg[15][7]_srl16\
    );
\fifo0/fifo_1_reg[15][8]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(8),
      Q => \n_0_fifo0/fifo_1_reg[15][8]_srl16\
    );
\fifo0/fifo_1_reg[15][9]_srl16\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \n_0_fifo0/add_1_reg[0]\,
      A1 => \n_0_fifo0/add_1_reg[1]\,
      A2 => \n_0_fifo0/add_1_reg[2]\,
      A3 => \n_0_fifo0/add_1_reg[3]\,
      CE => wr_enable,
      CLK => aclk,
      D => wr_data(9),
      Q => \n_0_fifo0/fifo_1_reg[15][9]_srl16\
    );
\fifo0/fifo_2_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][0]_srl16\,
      Q => ifx_data(0),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][10]_srl16\,
      Q => ifx_data(10),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][11]_srl16\,
      Q => ifx_data(11),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][12]_srl16\,
      Q => ifx_data(12),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][13]_srl16\,
      Q => ifx_data(13),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][14]_srl16\,
      Q => ifx_data(14),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][15]_srl16\,
      Q => ifx_data(15),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][16]_srl16\,
      Q => ifx_data(16),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][17]_srl16\,
      Q => ifx_data(17),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][1]_srl16\,
      Q => ifx_data(1),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][2]_srl16\,
      Q => ifx_data(2),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][3]_srl16\,
      Q => ifx_data(3),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][4]_srl16\,
      Q => ifx_data(4),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][5]_srl16\,
      Q => ifx_data(5),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][6]_srl16\,
      Q => ifx_data(6),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][7]_srl16\,
      Q => ifx_data(7),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][8]_srl16\,
      Q => ifx_data(8),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][9]_srl16\,
      Q => ifx_data(9),
      R => \<const0>\
    );
\fifo0/rd_valid_2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => n_0_rd_valid_2_i_1,
      Q => \^ifx_valid\,
      R => areset
    );
\fifo_2[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => aclken,
      I1 => \^ifx_valid\,
      I2 => ifx_ready,
      O => rd_enable
    );
rd_valid_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"74F4"
    )
    port map (
      I0 => \n_0_fifo0/add_1_reg[4]\,
      I1 => aclken,
      I2 => \^ifx_valid\,
      I3 => ifx_ready,
      O => n_0_rd_valid_2_i_1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_b_tlast : in STD_LOGIC;
    s_axis_c_tvalid : in STD_LOGIC;
    s_axis_c_tready : out STD_LOGIC;
    s_axis_c_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_c_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_c_tlast : in STD_LOGIC;
    s_axis_operation_tvalid : in STD_LOGIC;
    s_axis_operation_tready : out STD_LOGIC;
    s_axis_operation_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_operation_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_operation_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is "floating_point_v7_0_viv";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 4;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 5;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 2;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is 16;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ : entity is "yes";
end \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\;

architecture STRUCTURE of \ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/BOTH_NEGATIVE_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \COMP_OP.SPD.OP/I_O_REG/i_pipe/first_q\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/MET_REG/i_pipe/first_q\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/D\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[0].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[10].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[1].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[2].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[3].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[4].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[5].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[6].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[7].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[8].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[9].eq_det_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/chunk_det\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/zero_det\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[0].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[0].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[10].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[10].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[11].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[11].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[12].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[12].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[13].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[13].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[14].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[14].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[15].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[15].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[1].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[1].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[2].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[2].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[3].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[3].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[4].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[4].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[5].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[5].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[6].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[6].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[7].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[7].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[8].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[8].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[9].di_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[9].lut_op_reg\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/D\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/chunk_det\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/zero_det\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/chunk_det\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \COMP_OP.SPD.OP/a_eq_b_p1\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/a_frac_not_zero_p0\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/a_gt_b_p1\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/a_is_nan_p1\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/b_frac_not_zero_p0\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/b_is_nan_p1\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/both_negative_p0\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/both_zero_p1\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/invalid_op_p1\ : STD_LOGIC;
  signal \COMP_OP.SPD.OP/result_var\ : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal combiner_data_valid : STD_LOGIC;
  signal \i_nd_to_rdy/first_q\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \i_nd_to_rdy/first_q\ : signal is "true";
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal lopt_10 : STD_LOGIC;
  signal lopt_11 : STD_LOGIC;
  signal lopt_2 : STD_LOGIC;
  signal lopt_3 : STD_LOGIC;
  signal lopt_4 : STD_LOGIC;
  signal lopt_5 : STD_LOGIC;
  signal lopt_6 : STD_LOGIC;
  signal lopt_7 : STD_LOGIC;
  signal lopt_8 : STD_LOGIC;
  signal lopt_9 : STD_LOGIC;
  signal \^m_axis_result_tdata\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axis_result_tvalid\ : STD_LOGIC;
  signal \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[11].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_HAS_ARESETN.sclr_i_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg1_a_tlast_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[0]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[10]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[11]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[12]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[13]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[14]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[15]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[16]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[17]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[18]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[19]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[1]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[20]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[21]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[22]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[23]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[24]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[25]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[26]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[27]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[28]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[29]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[2]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[30]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[31]_i_2\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[3]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[4]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[5]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[6]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[7]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[8]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[9]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tlast_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[0]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[1]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[2]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[3]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[4]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[5]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[6]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[7]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[0]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[10]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[11]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[12]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[13]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[14]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[15]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[16]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[17]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[18]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[19]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[1]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[20]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[21]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[22]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[23]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[24]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[25]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[26]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[27]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[28]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[29]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[2]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[30]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[31]_i_2\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[3]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[4]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[5]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[6]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[7]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[8]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tdata[9]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[0]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[1]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[2]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[3]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[4]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[5]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[6]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_b_tuser[7]_i_1\ : STD_LOGIC;
  signal \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_4\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/p_22_in\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/p_4_out\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_ready_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_ready_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\ : STD_LOGIC;
  signal \need_user_delay.user_pipe/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal p_1_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal p_4_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal reg1_a_tdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal reg1_a_tuser : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal reg1_b_tdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal reg1_b_tuser : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal reg2_a_tlast : STD_LOGIC;
  signal reg2_a_tuser : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal reg2_b_tuser : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^s_axis_a_tready\ : STD_LOGIC;
  signal \^s_axis_b_tready\ : STD_LOGIC;
  signal sclr_i : STD_LOGIC;
  signal valid_transfer_in : STD_LOGIC;
  signal valid_transfer_out : STD_LOGIC;
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_afull_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_full_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_afull_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_full_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_add_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type : string;
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[10].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[10].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[15].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[15].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[2].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[2].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute AFULL_THRESH0 : integer;
  attribute AFULL_THRESH0 of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 1;
  attribute AFULL_THRESH1 : integer;
  attribute AFULL_THRESH1 of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 1;
  attribute DEPTH : integer;
  attribute DEPTH of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 16;
  attribute WIDTH : integer;
  attribute WIDTH of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 18;
  attribute downgradeipidentifiedwarnings of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[0]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[10]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[11]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[12]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[13]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[14]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[15]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[16]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[17]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[18]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[19]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[1]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[20]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[21]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[22]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[23]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[24]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[25]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[26]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[27]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[28]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[29]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[2]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[30]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[31]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[3]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[4]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[5]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[6]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[7]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[8]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[9]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[0]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[1]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[2]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[3]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[4]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[5]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[6]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[7]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[0]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[10]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[11]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[12]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[13]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[14]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[15]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[16]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[17]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[18]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[19]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[1]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[20]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[21]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[22]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[23]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[24]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[25]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[26]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[27]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[28]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[29]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[2]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[30]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[31]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[3]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[4]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[5]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[6]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[7]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[8]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[9]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[0]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[1]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[2]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[3]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[4]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[5]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[6]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[7]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_valid_i_2\ : label is "soft_lutpair5";
  attribute keep : string;
  attribute keep of \i_nd_to_rdy/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_3\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_4\ : label is "soft_lutpair3";
begin
  m_axis_result_tdata(7) <= \<const0>\;
  m_axis_result_tdata(6) <= \<const0>\;
  m_axis_result_tdata(5) <= \<const0>\;
  m_axis_result_tdata(4) <= \<const0>\;
  m_axis_result_tdata(3) <= \<const0>\;
  m_axis_result_tdata(2) <= \<const0>\;
  m_axis_result_tdata(1) <= \<const0>\;
  m_axis_result_tdata(0) <= \^m_axis_result_tdata\(0);
  m_axis_result_tvalid <= \^m_axis_result_tvalid\;
  s_axis_a_tready <= \^s_axis_a_tready\;
  s_axis_b_tready <= \^s_axis_b_tready\;
  s_axis_c_tready <= \<const1>\;
  s_axis_operation_tready <= \<const1>\;
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_1_out(26),
      I1 => p_1_out(23),
      I2 => p_1_out(28),
      I3 => p_1_out(24),
      I4 => p_1_out(25),
      I5 => p_1_out(27),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(3),
      I1 => p_4_out(0),
      I2 => p_4_out(5),
      I3 => p_4_out(1),
      I4 => p_4_out(2),
      I5 => p_4_out(4),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/zero_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => p_4_out(24),
      I1 => p_4_out(26),
      I2 => p_4_out(23),
      I3 => p_4_out(27),
      I4 => p_4_out(25),
      I5 => p_4_out(28),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_1_out(3),
      I1 => p_1_out(0),
      I2 => p_1_out(5),
      I3 => p_1_out(1),
      I4 => p_1_out(2),
      I5 => p_1_out(4),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/zero_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => p_1_out(26),
      I1 => p_1_out(23),
      I2 => p_1_out(28),
      I3 => p_1_out(24),
      I4 => p_1_out(25),
      I5 => p_1_out(27),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(1),
      I1 => p_1_out(1),
      I2 => p_4_out(0),
      I3 => p_1_out(0),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[0].lut_op_reg\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_1_out(2),
      I1 => p_4_out(2),
      I2 => p_4_out(1),
      I3 => p_1_out(1),
      I4 => p_4_out(0),
      I5 => p_1_out(0),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[0].eq_det_reg\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(0),
      I1 => p_1_out(0),
      I2 => p_1_out(1),
      I3 => p_4_out(1),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[0].di_reg\
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(31),
      I1 => p_4_out(31),
      I2 => p_4_out(30),
      I3 => p_1_out(30),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[10].eq_det_reg\
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(21),
      I1 => p_4_out(21),
      I2 => p_1_out(20),
      I3 => p_4_out(20),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[10].lut_op_reg\
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40F4"
    )
    port map (
      I0 => p_1_out(20),
      I1 => p_4_out(20),
      I2 => p_4_out(21),
      I3 => p_1_out(21),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[10].di_reg\
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(23),
      I1 => p_1_out(23),
      I2 => p_1_out(22),
      I3 => p_4_out(22),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[11].lut_op_reg\
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(22),
      I1 => p_1_out(22),
      I2 => p_1_out(23),
      I3 => p_4_out(23),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[11].di_reg\
    );
\CHAIN_GEN[12].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(25),
      I1 => p_4_out(25),
      I2 => p_1_out(24),
      I3 => p_4_out(24),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[12].lut_op_reg\
    );
\CHAIN_GEN[12].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(24),
      I1 => p_1_out(24),
      I2 => p_1_out(25),
      I3 => p_4_out(25),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[12].di_reg\
    );
\CHAIN_GEN[13].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(27),
      I1 => p_1_out(27),
      I2 => p_4_out(26),
      I3 => p_1_out(26),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[13].lut_op_reg\
    );
\CHAIN_GEN[13].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40F4"
    )
    port map (
      I0 => p_1_out(26),
      I1 => p_4_out(26),
      I2 => p_4_out(27),
      I3 => p_1_out(27),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[13].di_reg\
    );
\CHAIN_GEN[14].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(29),
      I1 => p_1_out(29),
      I2 => p_4_out(28),
      I3 => p_1_out(28),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[14].lut_op_reg\
    );
\CHAIN_GEN[14].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(28),
      I1 => p_1_out(28),
      I2 => p_1_out(29),
      I3 => p_4_out(29),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[14].di_reg\
    );
\CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(31),
      I1 => p_4_out(31),
      I2 => p_4_out(30),
      I3 => p_1_out(30),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[15].lut_op_reg\
    );
\CHAIN_GEN[15].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(30),
      I1 => p_1_out(30),
      I2 => p_4_out(31),
      I3 => p_1_out(31),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[15].di_reg\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(24),
      I1 => p_1_out(29),
      I2 => p_4_out(26),
      I3 => p_1_out(30),
      I4 => p_4_out(23),
      I5 => p_4_out(25),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(9),
      I1 => p_4_out(6),
      I2 => p_4_out(11),
      I3 => p_4_out(7),
      I4 => p_4_out(8),
      I5 => p_4_out(10),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/zero_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => p_4_out(30),
      I1 => p_4_out(29),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_1_out(9),
      I1 => p_1_out(6),
      I2 => p_1_out(11),
      I3 => p_1_out(7),
      I4 => p_1_out(8),
      I5 => p_1_out(10),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/zero_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => p_1_out(29),
      I1 => p_1_out(30),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(3),
      I1 => p_4_out(3),
      I2 => p_1_out(2),
      I3 => p_4_out(2),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[1].lut_op_reg\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_4_out(4),
      I1 => p_1_out(4),
      I2 => p_4_out(5),
      I3 => p_1_out(5),
      I4 => p_1_out(3),
      I5 => p_4_out(3),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[1].eq_det_reg\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40F4"
    )
    port map (
      I0 => p_1_out(2),
      I1 => p_4_out(2),
      I2 => p_4_out(3),
      I3 => p_1_out(3),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[1].di_reg\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => p_4_out(27),
      I1 => p_4_out(30),
      I2 => p_4_out(28),
      I3 => p_4_out(29),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/chunk_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(15),
      I1 => p_4_out(12),
      I2 => p_4_out(17),
      I3 => p_4_out(13),
      I4 => p_4_out(14),
      I5 => p_4_out(16),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/zero_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_1_out(15),
      I1 => p_1_out(12),
      I2 => p_1_out(17),
      I3 => p_1_out(13),
      I4 => p_1_out(14),
      I5 => p_1_out(16),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/zero_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_1_out(8),
      I1 => p_4_out(8),
      I2 => p_4_out(7),
      I3 => p_1_out(7),
      I4 => p_4_out(6),
      I5 => p_1_out(6),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[2].eq_det_reg\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(5),
      I1 => p_4_out(5),
      I2 => p_1_out(4),
      I3 => p_4_out(4),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[2].lut_op_reg\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(4),
      I1 => p_1_out(4),
      I2 => p_1_out(5),
      I3 => p_4_out(5),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[2].di_reg\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => p_4_out(20),
      I1 => p_4_out(22),
      I2 => p_4_out(19),
      I3 => p_4_out(21),
      I4 => p_4_out(18),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/zero_det\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => p_1_out(20),
      I1 => p_1_out(22),
      I2 => p_1_out(19),
      I3 => p_1_out(21),
      I4 => p_1_out(18),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/zero_det\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_4_out(10),
      I1 => p_1_out(10),
      I2 => p_4_out(11),
      I3 => p_1_out(11),
      I4 => p_1_out(9),
      I5 => p_4_out(9),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[3].eq_det_reg\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(7),
      I1 => p_1_out(7),
      I2 => p_4_out(6),
      I3 => p_1_out(6),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[3].lut_op_reg\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(6),
      I1 => p_1_out(6),
      I2 => p_1_out(7),
      I3 => p_4_out(7),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[3].di_reg\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_1_out(14),
      I1 => p_4_out(14),
      I2 => p_4_out(13),
      I3 => p_1_out(13),
      I4 => p_4_out(12),
      I5 => p_1_out(12),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[4].eq_det_reg\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(9),
      I1 => p_4_out(9),
      I2 => p_1_out(8),
      I3 => p_4_out(8),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[4].lut_op_reg\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40F4"
    )
    port map (
      I0 => p_1_out(8),
      I1 => p_4_out(8),
      I2 => p_4_out(9),
      I3 => p_1_out(9),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[4].di_reg\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_4_out(16),
      I1 => p_1_out(16),
      I2 => p_4_out(17),
      I3 => p_1_out(17),
      I4 => p_1_out(15),
      I5 => p_4_out(15),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[5].eq_det_reg\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(11),
      I1 => p_4_out(11),
      I2 => p_1_out(10),
      I3 => p_4_out(10),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[5].lut_op_reg\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(10),
      I1 => p_1_out(10),
      I2 => p_1_out(11),
      I3 => p_4_out(11),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[5].di_reg\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_1_out(20),
      I1 => p_4_out(20),
      I2 => p_4_out(19),
      I3 => p_1_out(19),
      I4 => p_4_out(18),
      I5 => p_1_out(18),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[6].eq_det_reg\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(13),
      I1 => p_1_out(13),
      I2 => p_4_out(12),
      I3 => p_1_out(12),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[6].lut_op_reg\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(12),
      I1 => p_1_out(12),
      I2 => p_1_out(13),
      I3 => p_4_out(13),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[6].di_reg\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_4_out(22),
      I1 => p_1_out(22),
      I2 => p_1_out(23),
      I3 => p_4_out(23),
      I4 => p_1_out(21),
      I5 => p_4_out(21),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[7].eq_det_reg\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(15),
      I1 => p_4_out(15),
      I2 => p_1_out(14),
      I3 => p_4_out(14),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[7].lut_op_reg\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40F4"
    )
    port map (
      I0 => p_1_out(14),
      I1 => p_4_out(14),
      I2 => p_4_out(15),
      I3 => p_1_out(15),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[7].di_reg\
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_4_out(26),
      I1 => p_1_out(26),
      I2 => p_1_out(25),
      I3 => p_4_out(25),
      I4 => p_1_out(24),
      I5 => p_4_out(24),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[8].eq_det_reg\
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(17),
      I1 => p_4_out(17),
      I2 => p_1_out(16),
      I3 => p_4_out(16),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[8].lut_op_reg\
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(16),
      I1 => p_1_out(16),
      I2 => p_1_out(17),
      I3 => p_4_out(17),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[8].di_reg\
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => p_1_out(28),
      I1 => p_4_out(28),
      I2 => p_1_out(29),
      I3 => p_4_out(29),
      I4 => p_4_out(27),
      I5 => p_1_out(27),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[9].eq_det_reg\
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_4_out(19),
      I1 => p_1_out(19),
      I2 => p_4_out(18),
      I3 => p_1_out(18),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[9].lut_op_reg\
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => p_4_out(18),
      I1 => p_1_out(18),
      I2 => p_1_out(19),
      I3 => p_4_out(19),
      O => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[9].di_reg\
    );
\COMP_OP.SPD.OP/BOTH_NEGATIVE_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/both_negative_p0\,
      Q => \COMP_OP.SPD.OP/BOTH_NEGATIVE_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const1>\,
      Q => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\COMP_OP.SPD.OP/I_O_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/invalid_op_p1\,
      Q => \COMP_OP.SPD.OP/I_O_REG/i_pipe/first_q\,
      R => \<const0>\
    );
\COMP_OP.SPD.OP/MET_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/result_var\,
      Q => \COMP_OP.SPD.OP/MET_REG/i_pipe/first_q\,
      R => \<const0>\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_5,
      CO(3) => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[3].eq_det_reg\,
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[2].eq_det_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[1].eq_det_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[0].eq_det_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_5
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[10].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/D\,
      Q => \COMP_OP.SPD.OP/a_eq_b_p1\,
      R => GND_2
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_6,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[7].eq_det_reg\,
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[6].eq_det_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[5].eq_det_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[4].eq_det_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_6
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3),
      CO(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/D\,
      CO(1 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(1 downto 0),
      CYINIT => lopt_7,
      DI(3) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3),
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\(3),
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[10].eq_det_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[9].eq_det_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/ZERO_GEN[8].eq_det_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EQ_B_DET/WIDE_AND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_7
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \COMP_OP.SPD.OP/a_frac_not_zero_p0\,
      CO(3 downto 2) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/D\,
      CO(0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(0),
      CYINIT => lopt_2,
      DI(3 downto 2) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3 downto 2),
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\(3 downto 2),
      S(1 downto 0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/chunk_det\(1 downto 0)
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_2
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/STRUCT_CMP.A_EXP_ALL_ONE_DET/CARRY_ZERO_DET/D\,
      Q => \COMP_OP.SPD.OP/a_is_nan_p1\,
      R => GND_2
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_1,
      CO(3) => \COMP_OP.SPD.OP/a_frac_not_zero_p0\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const0>\,
      DI(3) => \<const1>\,
      DI(2) => \<const1>\,
      DI(1) => \<const1>\,
      DI(0) => \<const1>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/zero_det\(3 downto 0)
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_8,
      CO(3) => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const0>\,
      DI(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[3].di_reg\,
      DI(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[2].di_reg\,
      DI(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[1].di_reg\,
      DI(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[0].di_reg\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[3].lut_op_reg\,
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[2].lut_op_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[1].lut_op_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[0].lut_op_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_8
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/D\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_11,
      DI(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[15].di_reg\,
      DI(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[14].di_reg\,
      DI(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[13].di_reg\,
      DI(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[12].di_reg\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[15].lut_op_reg\,
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[14].lut_op_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[13].lut_op_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[12].lut_op_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_11
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[15].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/D\,
      Q => \COMP_OP.SPD.OP/a_gt_b_p1\,
      R => GND_2
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_9,
      DI(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[7].di_reg\,
      DI(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[6].di_reg\,
      DI(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[5].di_reg\,
      DI(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[4].di_reg\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[7].lut_op_reg\,
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[6].lut_op_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[5].lut_op_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[4].lut_op_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_9
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_10,
      DI(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[11].di_reg\,
      DI(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[10].di_reg\,
      DI(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[9].di_reg\,
      DI(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[8].di_reg\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[11].lut_op_reg\,
      S(2) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[10].lut_op_reg\,
      S(1) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[9].lut_op_reg\,
      S(0) => \COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/ADD_MANT_GEN[8].lut_op_reg\
    );
\COMP_OP.SPD.OP/STRUCT_CMP.A_GT_B_DET/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_10
    );
\COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \COMP_OP.SPD.OP/b_frac_not_zero_p0\,
      CO(3 downto 2) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/D\,
      CO(0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(0),
      CYINIT => lopt_4,
      DI(3 downto 2) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3 downto 2),
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\(3 downto 2),
      S(1 downto 0) => \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/chunk_det\(1 downto 0)
    );
\COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_4
    );
\COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/STRUCT_CMP.B_EXP_ALL_ONE_DET/CARRY_ZERO_DET/D\,
      Q => \COMP_OP.SPD.OP/b_is_nan_p1\,
      R => GND_2
    );
\COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_3,
      CO(3) => \COMP_OP.SPD.OP/b_frac_not_zero_p0\,
      CO(2 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const0>\,
      DI(3) => \<const1>\,
      DI(2) => \<const1>\,
      DI(1) => \<const1>\,
      DI(0) => \<const1>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/zero_det\(3 downto 0)
    );
\COMP_OP.SPD.OP/STRUCT_CMP.B_FRAC_NOT_ZERO_DET/WIDE_NOR/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_3
    );
\COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3),
      CO(2) => \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      CO(1 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(1 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3),
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \NLW_COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\(3),
      S(2 downto 0) => \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/chunk_det\(2 downto 0)
    );
\COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[2].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \COMP_OP.SPD.OP/STRUCT_CMP.EXP_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      Q => \COMP_OP.SPD.OP/both_zero_p1\,
      R => GND_2
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
GND_1: unisim.vcomponents.GND
    port map (
      G => GND_2
    );
\HAS_ARESETN.sclr_i_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => aresetn,
      O => \n_0_HAS_ARESETN.sclr_i_i_1\
    );
\HAS_ARESETN.sclr_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_HAS_ARESETN.sclr_i_i_1\,
      Q => sclr_i,
      R => \<const0>\
    );
\HAS_OUTPUT_FIFO.i_output_fifo\: entity work.ip_fp32_axis_greaterThanglb_ifx_master
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      add(4 downto 0) => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_add_UNCONNECTED\(4 downto 0),
      afull => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_afull_UNCONNECTED\,
      areset => sclr_i,
      full => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_full_UNCONNECTED\,
      ifx_data(17) => m_axis_result_tlast,
      ifx_data(16 downto 1) => m_axis_result_tuser(15 downto 0),
      ifx_data(0) => \^m_axis_result_tdata\(0),
      ifx_ready => m_axis_result_tready,
      ifx_valid => \^m_axis_result_tvalid\,
      not_afull => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_afull_UNCONNECTED\,
      not_full => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_full_UNCONNECTED\,
      wr_data(17 downto 1) => p_1_in(16 downto 0),
      wr_data(0) => \COMP_OP.SPD.OP/MET_REG/i_pipe/first_q\,
      wr_enable => valid_transfer_out
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gen_has_z_tready.reg1_a_ready_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0B0000000B0B0B0B"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I4 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_ready_nxt\
    );
\gen_has_z_tready.reg1_a_tdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800080808080"
    )
    port map (
      I0 => s_axis_a_tvalid,
      I1 => \^s_axis_a_tready\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\
    );
\gen_has_z_tready.reg1_a_tlast_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBF0080"
    )
    port map (
      I0 => s_axis_a_tlast,
      I1 => s_axis_a_tvalid,
      I2 => \^s_axis_a_tready\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I4 => \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\,
      O => \n_0_gen_has_z_tready.reg1_a_tlast_i_1\
    );
\gen_has_z_tready.reg1_a_valid_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFF0808"
    )
    port map (
      I0 => s_axis_a_tvalid,
      I1 => \^s_axis_a_tready\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I4 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid_nxt\
    );
\gen_has_z_tready.reg1_b_ready_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0B0000000B0B0B0B"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      I4 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_ready_nxt\
    );
\gen_has_z_tready.reg1_b_tdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800080808080"
    )
    port map (
      I0 => s_axis_b_tvalid,
      I1 => \^s_axis_b_tready\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\
    );
\gen_has_z_tready.reg1_b_valid_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFF0808"
    )
    port map (
      I0 => s_axis_b_tvalid,
      I1 => \^s_axis_b_tready\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I4 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\
    );
\gen_has_z_tready.reg2_a_tdata[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(0),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(0),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[0]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(10),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(10),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[10]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(11),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(11),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[11]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(12),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(12),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[12]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(13),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(13),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[13]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(14),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(14),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[14]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(15),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(15),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[15]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(16),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(16),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[16]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(17),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(17),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[17]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(18),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(18),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[18]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(19),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(19),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[19]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(1),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(1),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[1]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(20),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(20),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[20]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(21),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(21),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[21]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(22),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(22),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[22]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(23),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(23),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[23]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(24),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(24),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[24]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(25),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(25),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[25]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(26),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(26),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[26]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(27),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(27),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[27]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(28),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(28),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[28]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(29),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(29),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[29]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(2),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(2),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[2]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(30),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(30),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[30]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8AFF"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I1 => m_axis_result_tready,
      I2 => \^m_axis_result_tvalid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\
    );
\gen_has_z_tready.reg2_a_tdata[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(31),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(31),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[31]_i_2\
    );
\gen_has_z_tready.reg2_a_tdata[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(3),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(3),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[3]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(4),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(4),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[4]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(5),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(5),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[5]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(6),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(6),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[6]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(7),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(7),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[7]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(8),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(8),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[8]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(9),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(9),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[9]_i_1\
    );
\gen_has_z_tready.reg2_a_tlast_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
    port map (
      I0 => \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tlast,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I4 => reg2_a_tlast,
      O => \n_0_gen_has_z_tready.reg2_a_tlast_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(0),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(0),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[0]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(1),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(1),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[1]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(2),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(2),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[2]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(3),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(3),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[3]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(4),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(4),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[4]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(5),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(5),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[5]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(6),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(6),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[6]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(7),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(7),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[7]_i_1\
    );
\gen_has_z_tready.reg2_a_valid_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF88F888F888F888"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/p_22_in\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I4 => \^s_axis_a_tready\,
      I5 => s_axis_a_tvalid,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\
    );
\gen_has_z_tready.reg2_b_tdata[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(0),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(0),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[0]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(10),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(10),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[10]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(11),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(11),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[11]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(12),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(12),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[12]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(13),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(13),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[13]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(14),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(14),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[14]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(15),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(15),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[15]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(16),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(16),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[16]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(17),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(17),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[17]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(18),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(18),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[18]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(19),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(19),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[19]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(1),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(1),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[1]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(20),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(20),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[20]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(21),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(21),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[21]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(22),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(22),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[22]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(23),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(23),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[23]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(24),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(24),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[24]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(25),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(25),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[25]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(26),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(26),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[26]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(27),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(27),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[27]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(28),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(28),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[28]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(29),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(29),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[29]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(2),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(2),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[2]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(30),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(30),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[30]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8AFF"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I1 => m_axis_result_tready,
      I2 => \^m_axis_result_tvalid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\
    );
\gen_has_z_tready.reg2_b_tdata[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(31),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(31),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[31]_i_2\
    );
\gen_has_z_tready.reg2_b_tdata[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(3),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(3),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[3]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(4),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(4),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[4]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(5),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(5),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[5]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(6),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(6),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[6]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(7),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(7),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[7]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(8),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(8),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[8]_i_1\
    );
\gen_has_z_tready.reg2_b_tdata[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tdata(9),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tdata(9),
      O => \n_0_gen_has_z_tready.reg2_b_tdata[9]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(0),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(0),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[0]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(1),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(1),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[1]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(2),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(2),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[2]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(3),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(3),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[3]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(4),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(4),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[4]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(5),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(5),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[5]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(6),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(6),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[6]_i_1\
    );
\gen_has_z_tready.reg2_b_tuser[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_b_tuser(7),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I2 => s_axis_b_tuser(7),
      O => \n_0_gen_has_z_tready.reg2_b_tuser[7]_i_1\
    );
\gen_has_z_tready.reg2_b_valid_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF88F888F888F888"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/p_22_in\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      I4 => \^s_axis_b_tready\,
      I5 => s_axis_b_tvalid,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\
    );
\gen_has_z_tready.reg2_b_valid_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"5D"
    )
    port map (
      I0 => combiner_data_valid,
      I1 => \^m_axis_result_tvalid\,
      I2 => m_axis_result_tready,
      O => \need_combiner.use_2to1.skid_buffer_combiner/p_22_in\
    );
\gen_has_z_tready.z_valid_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/p_4_out\
    );
\i_nd_to_rdy/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => valid_transfer_in,
      Q => \i_nd_to_rdy/first_q\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \i_nd_to_rdy/first_q\,
      Q => valid_transfer_out,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_ready_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_ready_nxt\,
      Q => \^s_axis_a_tready\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(0),
      Q => reg1_a_tdata(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(10),
      Q => reg1_a_tdata(10),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(11),
      Q => reg1_a_tdata(11),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(12),
      Q => reg1_a_tdata(12),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(13),
      Q => reg1_a_tdata(13),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(14),
      Q => reg1_a_tdata(14),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(15),
      Q => reg1_a_tdata(15),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(16),
      Q => reg1_a_tdata(16),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(17),
      Q => reg1_a_tdata(17),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(18),
      Q => reg1_a_tdata(18),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(19),
      Q => reg1_a_tdata(19),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(1),
      Q => reg1_a_tdata(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(20),
      Q => reg1_a_tdata(20),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(21),
      Q => reg1_a_tdata(21),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(22),
      Q => reg1_a_tdata(22),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(23),
      Q => reg1_a_tdata(23),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(24),
      Q => reg1_a_tdata(24),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(25),
      Q => reg1_a_tdata(25),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(26),
      Q => reg1_a_tdata(26),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(27),
      Q => reg1_a_tdata(27),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(28),
      Q => reg1_a_tdata(28),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(29),
      Q => reg1_a_tdata(29),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(2),
      Q => reg1_a_tdata(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(30),
      Q => reg1_a_tdata(30),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(31),
      Q => reg1_a_tdata(31),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(3),
      Q => reg1_a_tdata(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(4),
      Q => reg1_a_tdata(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(5),
      Q => reg1_a_tdata(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(6),
      Q => reg1_a_tdata(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(7),
      Q => reg1_a_tdata(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(8),
      Q => reg1_a_tdata(8),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(9),
      Q => reg1_a_tdata(9),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_gen_has_z_tready.reg1_a_tlast_i_1\,
      Q => \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\,
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(0),
      Q => reg1_a_tuser(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(1),
      Q => reg1_a_tuser(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(2),
      Q => reg1_a_tuser(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(3),
      Q => reg1_a_tuser(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(4),
      Q => reg1_a_tuser(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(5),
      Q => reg1_a_tuser(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(6),
      Q => reg1_a_tuser(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(7),
      Q => reg1_a_tuser(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_ready_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_ready_nxt\,
      Q => \^s_axis_b_tready\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(0),
      Q => reg1_b_tdata(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(10),
      Q => reg1_b_tdata(10),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(11),
      Q => reg1_b_tdata(11),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(12),
      Q => reg1_b_tdata(12),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(13),
      Q => reg1_b_tdata(13),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(14),
      Q => reg1_b_tdata(14),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(15),
      Q => reg1_b_tdata(15),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(16),
      Q => reg1_b_tdata(16),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(17),
      Q => reg1_b_tdata(17),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(18),
      Q => reg1_b_tdata(18),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(19),
      Q => reg1_b_tdata(19),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(1),
      Q => reg1_b_tdata(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(20),
      Q => reg1_b_tdata(20),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(21),
      Q => reg1_b_tdata(21),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(22),
      Q => reg1_b_tdata(22),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(23),
      Q => reg1_b_tdata(23),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(24),
      Q => reg1_b_tdata(24),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(25),
      Q => reg1_b_tdata(25),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(26),
      Q => reg1_b_tdata(26),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(27),
      Q => reg1_b_tdata(27),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(28),
      Q => reg1_b_tdata(28),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(29),
      Q => reg1_b_tdata(29),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(2),
      Q => reg1_b_tdata(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(30),
      Q => reg1_b_tdata(30),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(31),
      Q => reg1_b_tdata(31),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(3),
      Q => reg1_b_tdata(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(4),
      Q => reg1_b_tdata(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(5),
      Q => reg1_b_tdata(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(6),
      Q => reg1_b_tdata(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(7),
      Q => reg1_b_tdata(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(8),
      Q => reg1_b_tdata(8),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tdata_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tdata(9),
      Q => reg1_b_tdata(9),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(0),
      Q => reg1_b_tuser(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(1),
      Q => reg1_b_tuser(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(2),
      Q => reg1_b_tuser(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(3),
      Q => reg1_b_tuser(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(4),
      Q => reg1_b_tuser(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(5),
      Q => reg1_b_tuser(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(6),
      Q => reg1_b_tuser(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_tuser_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_wr\,
      D => s_axis_b_tuser(7),
      Q => reg1_b_tuser(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[0]_i_1\,
      Q => p_4_out(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[10]_i_1\,
      Q => p_4_out(10),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[11]_i_1\,
      Q => p_4_out(11),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[12]_i_1\,
      Q => p_4_out(12),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[13]_i_1\,
      Q => p_4_out(13),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[14]_i_1\,
      Q => p_4_out(14),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[15]_i_1\,
      Q => p_4_out(15),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[16]_i_1\,
      Q => p_4_out(16),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[17]_i_1\,
      Q => p_4_out(17),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[18]_i_1\,
      Q => p_4_out(18),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[19]_i_1\,
      Q => p_4_out(19),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[1]_i_1\,
      Q => p_4_out(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[20]_i_1\,
      Q => p_4_out(20),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[21]_i_1\,
      Q => p_4_out(21),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[22]_i_1\,
      Q => p_4_out(22),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[23]_i_1\,
      Q => p_4_out(23),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[24]_i_1\,
      Q => p_4_out(24),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[25]_i_1\,
      Q => p_4_out(25),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[26]_i_1\,
      Q => p_4_out(26),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[27]_i_1\,
      Q => p_4_out(27),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[28]_i_1\,
      Q => p_4_out(28),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[29]_i_1\,
      Q => p_4_out(29),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[2]_i_1\,
      Q => p_4_out(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[30]_i_1\,
      Q => p_4_out(30),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[31]_i_2\,
      Q => p_4_out(31),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[3]_i_1\,
      Q => p_4_out(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[4]_i_1\,
      Q => p_4_out(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[5]_i_1\,
      Q => p_4_out(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[6]_i_1\,
      Q => p_4_out(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[7]_i_1\,
      Q => p_4_out(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[8]_i_1\,
      Q => p_4_out(8),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[9]_i_1\,
      Q => p_4_out(9),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tlast_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_gen_has_z_tready.reg2_a_tlast_i_1\,
      Q => reg2_a_tlast,
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[0]_i_1\,
      Q => reg2_a_tuser(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[1]_i_1\,
      Q => reg2_a_tuser(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[2]_i_1\,
      Q => reg2_a_tuser(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[3]_i_1\,
      Q => reg2_a_tuser(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[4]_i_1\,
      Q => reg2_a_tuser(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[5]_i_1\,
      Q => reg2_a_tuser(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[6]_i_1\,
      Q => reg2_a_tuser(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[7]_i_1\,
      Q => reg2_a_tuser(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[0]_i_1\,
      Q => p_1_out(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[10]_i_1\,
      Q => p_1_out(10),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[11]_i_1\,
      Q => p_1_out(11),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[12]_i_1\,
      Q => p_1_out(12),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[13]_i_1\,
      Q => p_1_out(13),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[14]_i_1\,
      Q => p_1_out(14),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[15]_i_1\,
      Q => p_1_out(15),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[16]_i_1\,
      Q => p_1_out(16),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[17]_i_1\,
      Q => p_1_out(17),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[18]_i_1\,
      Q => p_1_out(18),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[19]_i_1\,
      Q => p_1_out(19),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[1]_i_1\,
      Q => p_1_out(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[20]_i_1\,
      Q => p_1_out(20),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[21]_i_1\,
      Q => p_1_out(21),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[22]_i_1\,
      Q => p_1_out(22),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[23]_i_1\,
      Q => p_1_out(23),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[24]_i_1\,
      Q => p_1_out(24),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[25]_i_1\,
      Q => p_1_out(25),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[26]_i_1\,
      Q => p_1_out(26),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[27]_i_1\,
      Q => p_1_out(27),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[28]_i_1\,
      Q => p_1_out(28),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[29]_i_1\,
      Q => p_1_out(29),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[2]_i_1\,
      Q => p_1_out(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[30]_i_1\,
      Q => p_1_out(30),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[31]_i_2\,
      Q => p_1_out(31),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[3]_i_1\,
      Q => p_1_out(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[4]_i_1\,
      Q => p_1_out(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[5]_i_1\,
      Q => p_1_out(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[6]_i_1\,
      Q => p_1_out(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[7]_i_1\,
      Q => p_1_out(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[8]_i_1\,
      Q => p_1_out(8),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tdata_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tdata[9]_i_1\,
      Q => p_1_out(9),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[0]_i_1\,
      Q => reg2_b_tuser(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[1]_i_1\,
      Q => reg2_b_tuser(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[2]_i_1\,
      Q => reg2_b_tuser(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[3]_i_1\,
      Q => reg2_b_tuser(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[4]_i_1\,
      Q => reg2_b_tuser(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[5]_i_1\,
      Q => reg2_b_tuser(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[6]_i_1\,
      Q => reg2_b_tuser(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_tuser_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/p_20_in\,
      D => \n_0_gen_has_z_tready.reg2_b_tuser[7]_i_1\,
      Q => reg2_b_tuser(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.z_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/p_4_out\,
      Q => combiner_data_valid,
      R => sclr_i
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(0),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(0),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(2),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(10),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(3),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(11),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(4),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(12),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(5),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(13),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(6),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(14),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(7),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(15),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tlast,
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(16),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(1),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(1),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(2),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(2),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(3),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(3),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(4),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(4),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(5),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(5),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(6),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(6),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_a_tuser(7),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(7),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(0),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(8),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => reg2_b_tuser(1),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(9),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(0),
      Q => p_1_in(0),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(10),
      Q => p_1_in(10),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(11),
      Q => p_1_in(11),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(12),
      Q => p_1_in(12),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(13),
      Q => p_1_in(13),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(14),
      Q => p_1_in(14),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(15),
      Q => p_1_in(15),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(16),
      Q => p_1_in(16),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(1),
      Q => p_1_in(1),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(2),
      Q => p_1_in(2),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(3),
      Q => p_1_in(3),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(4),
      Q => p_1_in(4),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(5),
      Q => p_1_in(5),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(6),
      Q => p_1_in(6),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(7),
      Q => p_1_in(7),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(8),
      Q => p_1_in(8),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(9),
      Q => p_1_in(9),
      R => \<const0>\
    );
\opt_has_pipe.first_q[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => combiner_data_valid,
      I1 => \^m_axis_result_tvalid\,
      I2 => m_axis_result_tready,
      O => valid_transfer_in
    );
\opt_has_pipe.first_q[0]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => p_4_out(31),
      I1 => p_1_out(31),
      O => \COMP_OP.SPD.OP/both_negative_p0\
    );
\opt_has_pipe.first_q[0]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8FF08400043F843"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_2\,
      I1 => \n_0_opt_has_pipe.first_q[0]_i_3\,
      I2 => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(2),
      I3 => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(0),
      I4 => \n_0_opt_has_pipe.first_q[0]_i_4\,
      I5 => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(1),
      O => \COMP_OP.SPD.OP/result_var\
    );
\opt_has_pipe.first_q[0]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6660"
    )
    port map (
      I0 => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(0),
      I1 => \COMP_OP.SPD.OP/CMP_COND_DELAY/i_pipe/first_q\(2),
      I2 => \COMP_OP.SPD.OP/a_is_nan_p1\,
      I3 => \COMP_OP.SPD.OP/b_is_nan_p1\,
      O => \COMP_OP.SPD.OP/invalid_op_p1\
    );
\opt_has_pipe.first_q[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFE3"
    )
    port map (
      I0 => \COMP_OP.SPD.OP/a_eq_b_p1\,
      I1 => \COMP_OP.SPD.OP/a_gt_b_p1\,
      I2 => \COMP_OP.SPD.OP/BOTH_NEGATIVE_DELAY/i_pipe/first_q\,
      I3 => \COMP_OP.SPD.OP/both_zero_p1\,
      O => \n_0_opt_has_pipe.first_q[0]_i_2\
    );
\opt_has_pipe.first_q[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \COMP_OP.SPD.OP/b_is_nan_p1\,
      I1 => \COMP_OP.SPD.OP/a_is_nan_p1\,
      O => \n_0_opt_has_pipe.first_q[0]_i_3\
    );
\opt_has_pipe.first_q[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1110"
    )
    port map (
      I0 => \COMP_OP.SPD.OP/a_is_nan_p1\,
      I1 => \COMP_OP.SPD.OP/b_is_nan_p1\,
      I2 => \COMP_OP.SPD.OP/both_zero_p1\,
      I3 => \COMP_OP.SPD.OP/a_eq_b_p1\,
      O => \n_0_opt_has_pipe.first_q[0]_i_4\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_b_tlast : in STD_LOGIC;
    s_axis_c_tvalid : in STD_LOGIC;
    s_axis_c_tready : out STD_LOGIC;
    s_axis_c_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_c_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_c_tlast : in STD_LOGIC;
    s_axis_operation_tvalid : in STD_LOGIC;
    s_axis_operation_tready : out STD_LOGIC;
    s_axis_operation_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_operation_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_operation_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is "floating_point_v7_0";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 4;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 5;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 2;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is 16;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ : entity is "yes";
end \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\;

architecture STRUCTURE of \ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\ is
  attribute C_ACCUM_INPUT_MSB of i_synth : label is 32;
  attribute C_ACCUM_LSB of i_synth : label is -31;
  attribute C_ACCUM_MSB of i_synth : label is 32;
  attribute C_A_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_A_TDATA_WIDTH of i_synth : label is 32;
  attribute C_A_TUSER_WIDTH of i_synth : label is 8;
  attribute C_A_WIDTH of i_synth : label is 32;
  attribute C_BRAM_USAGE of i_synth : label is 0;
  attribute C_B_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_B_TDATA_WIDTH of i_synth : label is 32;
  attribute C_B_TUSER_WIDTH of i_synth : label is 8;
  attribute C_B_WIDTH of i_synth : label is 32;
  attribute C_COMPARE_OPERATION of i_synth : label is 4;
  attribute C_C_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_C_TDATA_WIDTH of i_synth : label is 32;
  attribute C_C_TUSER_WIDTH of i_synth : label is 1;
  attribute C_C_WIDTH of i_synth : label is 32;
  attribute C_HAS_ABSOLUTE of i_synth : label is 0;
  attribute C_HAS_ACCUMULATOR_A of i_synth : label is 0;
  attribute C_HAS_ACCUMULATOR_S of i_synth : label is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of i_synth : label is 0;
  attribute C_HAS_ACCUM_OVERFLOW of i_synth : label is 0;
  attribute C_HAS_ACLKEN of i_synth : label is 0;
  attribute C_HAS_ADD of i_synth : label is 0;
  attribute C_HAS_ARESETN of i_synth : label is 1;
  attribute C_HAS_A_TLAST of i_synth : label is 1;
  attribute C_HAS_A_TUSER of i_synth : label is 1;
  attribute C_HAS_B of i_synth : label is 1;
  attribute C_HAS_B_TLAST of i_synth : label is 1;
  attribute C_HAS_B_TUSER of i_synth : label is 1;
  attribute C_HAS_C of i_synth : label is 0;
  attribute C_HAS_COMPARE of i_synth : label is 1;
  attribute C_HAS_C_TLAST of i_synth : label is 0;
  attribute C_HAS_C_TUSER of i_synth : label is 0;
  attribute C_HAS_DIVIDE of i_synth : label is 0;
  attribute C_HAS_DIVIDE_BY_ZERO of i_synth : label is 0;
  attribute C_HAS_EXPONENTIAL of i_synth : label is 0;
  attribute C_HAS_FIX_TO_FLT of i_synth : label is 0;
  attribute C_HAS_FLT_TO_FIX of i_synth : label is 0;
  attribute C_HAS_FLT_TO_FLT of i_synth : label is 0;
  attribute C_HAS_FMA of i_synth : label is 0;
  attribute C_HAS_FMS of i_synth : label is 0;
  attribute C_HAS_INVALID_OP of i_synth : label is 0;
  attribute C_HAS_LOGARITHM of i_synth : label is 0;
  attribute C_HAS_MULTIPLY of i_synth : label is 0;
  attribute C_HAS_OPERATION of i_synth : label is 0;
  attribute C_HAS_OPERATION_TLAST of i_synth : label is 0;
  attribute C_HAS_OPERATION_TUSER of i_synth : label is 0;
  attribute C_HAS_OVERFLOW of i_synth : label is 0;
  attribute C_HAS_RECIP of i_synth : label is 0;
  attribute C_HAS_RECIP_SQRT of i_synth : label is 0;
  attribute C_HAS_RESULT_TLAST of i_synth : label is 1;
  attribute C_HAS_RESULT_TUSER of i_synth : label is 1;
  attribute C_HAS_SQRT of i_synth : label is 0;
  attribute C_HAS_SUBTRACT of i_synth : label is 0;
  attribute C_HAS_UNDERFLOW of i_synth : label is 0;
  attribute C_LATENCY of i_synth : label is 5;
  attribute C_MULT_USAGE of i_synth : label is 0;
  attribute C_OPERATION_TDATA_WIDTH of i_synth : label is 8;
  attribute C_OPERATION_TUSER_WIDTH of i_synth : label is 1;
  attribute C_OPTIMIZATION of i_synth : label is 1;
  attribute C_RATE of i_synth : label is 1;
  attribute C_RESULT_FRACTION_WIDTH of i_synth : label is 0;
  attribute C_RESULT_TDATA_WIDTH of i_synth : label is 8;
  attribute C_RESULT_TUSER_WIDTH of i_synth : label is 16;
  attribute C_RESULT_WIDTH of i_synth : label is 1;
  attribute C_THROTTLE_SCHEME of i_synth : label is 2;
  attribute C_TLAST_RESOLUTION of i_synth : label is 1;
  attribute C_XDEVICEFAMILY of i_synth : label is "kintex7";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.\ip_fp32_axis_greaterThanfloating_point_v7_0_viv__parameterized0\
    port map (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      m_axis_result_tdata(7 downto 0) => m_axis_result_tdata(7 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      m_axis_result_tuser(15 downto 0) => m_axis_result_tuser(15 downto 0),
      m_axis_result_tvalid => m_axis_result_tvalid,
      s_axis_a_tdata(31 downto 0) => s_axis_a_tdata(31 downto 0),
      s_axis_a_tlast => s_axis_a_tlast,
      s_axis_a_tready => s_axis_a_tready,
      s_axis_a_tuser(7 downto 0) => s_axis_a_tuser(7 downto 0),
      s_axis_a_tvalid => s_axis_a_tvalid,
      s_axis_b_tdata(31 downto 0) => s_axis_b_tdata(31 downto 0),
      s_axis_b_tlast => s_axis_b_tlast,
      s_axis_b_tready => s_axis_b_tready,
      s_axis_b_tuser(7 downto 0) => s_axis_b_tuser(7 downto 0),
      s_axis_b_tvalid => s_axis_b_tvalid,
      s_axis_c_tdata(31 downto 0) => s_axis_c_tdata(31 downto 0),
      s_axis_c_tlast => s_axis_c_tlast,
      s_axis_c_tready => s_axis_c_tready,
      s_axis_c_tuser(0) => s_axis_c_tuser(0),
      s_axis_c_tvalid => s_axis_c_tvalid,
      s_axis_operation_tdata(7 downto 0) => s_axis_operation_tdata(7 downto 0),
      s_axis_operation_tlast => s_axis_operation_tlast,
      s_axis_operation_tready => s_axis_operation_tready,
      s_axis_operation_tuser(0) => s_axis_operation_tuser(0),
      s_axis_operation_tvalid => s_axis_operation_tvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_fp32_axis_greaterThan is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_b_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_fp32_axis_greaterThan : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_greaterThan : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ip_fp32_axis_greaterThan : entity is "floating_point_v7_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_fp32_axis_greaterThan : entity is "ip_fp32_axis_greaterThan,floating_point_v7_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of ip_fp32_axis_greaterThan : entity is "ip_fp32_axis_greaterThan,floating_point_v7_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=floating_point,x_ipVersion=7.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_XDEVICEFAMILY=kintex7,C_HAS_ADD=0,C_HAS_SUBTRACT=0,C_HAS_MULTIPLY=0,C_HAS_DIVIDE=0,C_HAS_SQRT=0,C_HAS_COMPARE=1,C_HAS_FIX_TO_FLT=0,C_HAS_FLT_TO_FIX=0,C_HAS_FLT_TO_FLT=0,C_HAS_RECIP=0,C_HAS_RECIP_SQRT=0,C_HAS_ABSOLUTE=0,C_HAS_LOGARITHM=0,C_HAS_EXPONENTIAL=0,C_HAS_FMA=0,C_HAS_FMS=0,C_HAS_ACCUMULATOR_A=0,C_HAS_ACCUMULATOR_S=0,C_A_WIDTH=32,C_A_FRACTION_WIDTH=24,C_B_WIDTH=32,C_B_FRACTION_WIDTH=24,C_C_WIDTH=32,C_C_FRACTION_WIDTH=24,C_RESULT_WIDTH=1,C_RESULT_FRACTION_WIDTH=0,C_COMPARE_OPERATION=4,C_LATENCY=5,C_OPTIMIZATION=1,C_MULT_USAGE=0,C_BRAM_USAGE=0,C_RATE=1,C_ACCUM_INPUT_MSB=32,C_ACCUM_MSB=32,C_ACCUM_LSB=-31,C_HAS_UNDERFLOW=0,C_HAS_OVERFLOW=0,C_HAS_INVALID_OP=0,C_HAS_DIVIDE_BY_ZERO=0,C_HAS_ACCUM_OVERFLOW=0,C_HAS_ACCUM_INPUT_OVERFLOW=0,C_HAS_ACLKEN=0,C_HAS_ARESETN=1,C_THROTTLE_SCHEME=2,C_HAS_A_TUSER=1,C_HAS_A_TLAST=1,C_HAS_B=1,C_HAS_B_TUSER=1,C_HAS_B_TLAST=1,C_HAS_C=0,C_HAS_C_TUSER=0,C_HAS_C_TLAST=0,C_HAS_OPERATION=0,C_HAS_OPERATION_TUSER=0,C_HAS_OPERATION_TLAST=0,C_HAS_RESULT_TUSER=1,C_HAS_RESULT_TLAST=1,C_TLAST_RESOLUTION=1,C_A_TDATA_WIDTH=32,C_A_TUSER_WIDTH=8,C_B_TDATA_WIDTH=32,C_B_TUSER_WIDTH=8,C_C_TDATA_WIDTH=32,C_C_TUSER_WIDTH=1,C_OPERATION_TDATA_WIDTH=8,C_OPERATION_TUSER_WIDTH=1,C_RESULT_TDATA_WIDTH=8,C_RESULT_TUSER_WIDTH=16}";
end ip_fp32_axis_greaterThan;

architecture STRUCTURE of ip_fp32_axis_greaterThan is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal NLW_U0_s_axis_c_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axis_operation_tready_UNCONNECTED : STD_LOGIC;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of U0 : label is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of U0 : label is -31;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of U0 : label is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of U0 : label is 24;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of U0 : label is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of U0 : label is 8;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of U0 : label is 32;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of U0 : label is 0;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of U0 : label is 24;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of U0 : label is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of U0 : label is 8;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of U0 : label is 32;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of U0 : label is 4;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of U0 : label is 24;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of U0 : label is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of U0 : label is 1;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of U0 : label is 32;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of U0 : label is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of U0 : label is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of U0 : label is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of U0 : label is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of U0 : label is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of U0 : label is 0;
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of U0 : label is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of U0 : label is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of U0 : label is 1;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of U0 : label is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of U0 : label is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of U0 : label is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of U0 : label is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of U0 : label is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of U0 : label is 1;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of U0 : label is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of U0 : label is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of U0 : label is 0;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of U0 : label is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of U0 : label is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of U0 : label is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of U0 : label is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of U0 : label is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of U0 : label is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of U0 : label is 0;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of U0 : label is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of U0 : label is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of U0 : label is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of U0 : label is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of U0 : label is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of U0 : label is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of U0 : label is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of U0 : label is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of U0 : label is 0;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of U0 : label is 1;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of U0 : label is 1;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of U0 : label is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of U0 : label is 0;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of U0 : label is 0;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of U0 : label is 5;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of U0 : label is 0;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of U0 : label is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of U0 : label is 1;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of U0 : label is 1;
  attribute C_RATE : integer;
  attribute C_RATE of U0 : label is 1;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of U0 : label is 0;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of U0 : label is 8;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of U0 : label is 16;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of U0 : label is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of U0 : label is 2;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of U0 : label is 1;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "kintex7";
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is true;
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
U0: entity work.\ip_fp32_axis_greaterThanfloating_point_v7_0__parameterized0\
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      aresetn => aresetn,
      m_axis_result_tdata(7 downto 0) => m_axis_result_tdata(7 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      m_axis_result_tuser(15 downto 0) => m_axis_result_tuser(15 downto 0),
      m_axis_result_tvalid => m_axis_result_tvalid,
      s_axis_a_tdata(31 downto 0) => s_axis_a_tdata(31 downto 0),
      s_axis_a_tlast => s_axis_a_tlast,
      s_axis_a_tready => s_axis_a_tready,
      s_axis_a_tuser(7 downto 0) => s_axis_a_tuser(7 downto 0),
      s_axis_a_tvalid => s_axis_a_tvalid,
      s_axis_b_tdata(31 downto 0) => s_axis_b_tdata(31 downto 0),
      s_axis_b_tlast => s_axis_b_tlast,
      s_axis_b_tready => s_axis_b_tready,
      s_axis_b_tuser(7 downto 0) => s_axis_b_tuser(7 downto 0),
      s_axis_b_tvalid => s_axis_b_tvalid,
      s_axis_c_tdata(31) => \<const0>\,
      s_axis_c_tdata(30) => \<const0>\,
      s_axis_c_tdata(29) => \<const0>\,
      s_axis_c_tdata(28) => \<const0>\,
      s_axis_c_tdata(27) => \<const0>\,
      s_axis_c_tdata(26) => \<const0>\,
      s_axis_c_tdata(25) => \<const0>\,
      s_axis_c_tdata(24) => \<const0>\,
      s_axis_c_tdata(23) => \<const0>\,
      s_axis_c_tdata(22) => \<const0>\,
      s_axis_c_tdata(21) => \<const0>\,
      s_axis_c_tdata(20) => \<const0>\,
      s_axis_c_tdata(19) => \<const0>\,
      s_axis_c_tdata(18) => \<const0>\,
      s_axis_c_tdata(17) => \<const0>\,
      s_axis_c_tdata(16) => \<const0>\,
      s_axis_c_tdata(15) => \<const0>\,
      s_axis_c_tdata(14) => \<const0>\,
      s_axis_c_tdata(13) => \<const0>\,
      s_axis_c_tdata(12) => \<const0>\,
      s_axis_c_tdata(11) => \<const0>\,
      s_axis_c_tdata(10) => \<const0>\,
      s_axis_c_tdata(9) => \<const0>\,
      s_axis_c_tdata(8) => \<const0>\,
      s_axis_c_tdata(7) => \<const0>\,
      s_axis_c_tdata(6) => \<const0>\,
      s_axis_c_tdata(5) => \<const0>\,
      s_axis_c_tdata(4) => \<const0>\,
      s_axis_c_tdata(3) => \<const0>\,
      s_axis_c_tdata(2) => \<const0>\,
      s_axis_c_tdata(1) => \<const0>\,
      s_axis_c_tdata(0) => \<const0>\,
      s_axis_c_tlast => \<const0>\,
      s_axis_c_tready => NLW_U0_s_axis_c_tready_UNCONNECTED,
      s_axis_c_tuser(0) => \<const0>\,
      s_axis_c_tvalid => \<const0>\,
      s_axis_operation_tdata(7) => \<const0>\,
      s_axis_operation_tdata(6) => \<const0>\,
      s_axis_operation_tdata(5) => \<const0>\,
      s_axis_operation_tdata(4) => \<const0>\,
      s_axis_operation_tdata(3) => \<const0>\,
      s_axis_operation_tdata(2) => \<const0>\,
      s_axis_operation_tdata(1) => \<const0>\,
      s_axis_operation_tdata(0) => \<const0>\,
      s_axis_operation_tlast => \<const0>\,
      s_axis_operation_tready => NLW_U0_s_axis_operation_tready_UNCONNECTED,
      s_axis_operation_tuser(0) => \<const0>\,
      s_axis_operation_tvalid => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
