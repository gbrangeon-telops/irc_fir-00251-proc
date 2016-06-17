-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Mon Jun 13 19:02:16 2016
-- Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/ip_fp32_axis_mult/ip_fp32_axis_mult_funcsim.vhdl
-- Design      : ip_fp32_axis_mult
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_fp32_axis_multglb_ifx_master is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    areset : in STD_LOGIC;
    wr_enable : in STD_LOGIC;
    wr_data : in STD_LOGIC_VECTOR ( 51 downto 0 );
    ifx_valid : out STD_LOGIC;
    ifx_ready : in STD_LOGIC;
    ifx_data : out STD_LOGIC_VECTOR ( 51 downto 0 );
    full : out STD_LOGIC;
    afull : out STD_LOGIC;
    not_full : out STD_LOGIC;
    not_afull : out STD_LOGIC;
    add : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  attribute WIDTH : integer;
  attribute WIDTH of ip_fp32_axis_multglb_ifx_master : entity is 52;
  attribute DEPTH : integer;
  attribute DEPTH of ip_fp32_axis_multglb_ifx_master : entity is 16;
  attribute AFULL_THRESH1 : integer;
  attribute AFULL_THRESH1 of ip_fp32_axis_multglb_ifx_master : entity is 1;
  attribute AFULL_THRESH0 : integer;
  attribute AFULL_THRESH0 of ip_fp32_axis_multglb_ifx_master : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_multglb_ifx_master : entity is "yes";
end ip_fp32_axis_multglb_ifx_master;

architecture STRUCTURE of ip_fp32_axis_multglb_ifx_master is
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
  signal \n_0_fifo0/fifo_1_reg[15][18]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][19]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][1]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][20]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][21]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][22]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][23]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][24]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][25]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][26]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][27]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][28]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][29]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][2]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][30]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][31]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][32]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][33]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][34]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][35]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][36]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][37]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][38]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][39]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][3]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][40]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][41]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][42]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][43]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][44]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][45]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][46]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][47]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][48]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][49]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][4]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][50]_srl16\ : STD_LOGIC;
  signal \n_0_fifo0/fifo_1_reg[15][51]_srl16\ : STD_LOGIC;
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
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][18]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][18]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][18]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][19]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][19]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][19]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][1]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][1]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][1]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][20]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][20]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][20]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][21]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][21]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][21]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][22]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][22]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][22]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][23]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][23]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][23]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][24]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][24]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][24]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][25]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][25]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][25]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][26]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][26]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][26]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][27]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][27]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][27]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][28]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][28]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][28]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][29]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][29]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][29]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][2]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][2]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][2]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][30]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][30]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][30]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][31]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][31]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][31]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][32]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][32]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][32]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][33]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][33]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][33]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][34]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][34]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][34]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][35]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][35]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][35]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][36]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][36]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][36]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][37]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][37]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][37]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][38]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][38]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][38]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][39]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][39]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][39]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][3]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][3]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][3]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][40]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][40]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][40]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][41]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][41]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][41]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][42]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][42]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][42]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][43]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][43]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][43]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][44]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][44]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][44]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][45]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][45]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][45]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][46]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][46]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][46]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][47]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][47]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][47]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][48]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][48]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][48]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][49]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][49]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][49]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][4]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][4]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][4]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][50]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][50]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][50]_srl16 ";
  attribute srl_bus_name of \fifo0/fifo_1_reg[15][51]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15] ";
  attribute srl_name of \fifo0/fifo_1_reg[15][51]_srl16\ : label is "U0/i_synth/\HAS_OUTPUT_FIFO.i_output_fifo /\fifo0/fifo_1_reg[15][51]_srl16 ";
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
\fifo0/fifo_1_reg[15][18]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(18),
      Q => \n_0_fifo0/fifo_1_reg[15][18]_srl16\
    );
\fifo0/fifo_1_reg[15][19]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(19),
      Q => \n_0_fifo0/fifo_1_reg[15][19]_srl16\
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
\fifo0/fifo_1_reg[15][20]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(20),
      Q => \n_0_fifo0/fifo_1_reg[15][20]_srl16\
    );
\fifo0/fifo_1_reg[15][21]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(21),
      Q => \n_0_fifo0/fifo_1_reg[15][21]_srl16\
    );
\fifo0/fifo_1_reg[15][22]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(22),
      Q => \n_0_fifo0/fifo_1_reg[15][22]_srl16\
    );
\fifo0/fifo_1_reg[15][23]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(23),
      Q => \n_0_fifo0/fifo_1_reg[15][23]_srl16\
    );
\fifo0/fifo_1_reg[15][24]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(24),
      Q => \n_0_fifo0/fifo_1_reg[15][24]_srl16\
    );
\fifo0/fifo_1_reg[15][25]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(25),
      Q => \n_0_fifo0/fifo_1_reg[15][25]_srl16\
    );
\fifo0/fifo_1_reg[15][26]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(26),
      Q => \n_0_fifo0/fifo_1_reg[15][26]_srl16\
    );
\fifo0/fifo_1_reg[15][27]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(27),
      Q => \n_0_fifo0/fifo_1_reg[15][27]_srl16\
    );
\fifo0/fifo_1_reg[15][28]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(28),
      Q => \n_0_fifo0/fifo_1_reg[15][28]_srl16\
    );
\fifo0/fifo_1_reg[15][29]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(29),
      Q => \n_0_fifo0/fifo_1_reg[15][29]_srl16\
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
\fifo0/fifo_1_reg[15][30]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(30),
      Q => \n_0_fifo0/fifo_1_reg[15][30]_srl16\
    );
\fifo0/fifo_1_reg[15][31]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(31),
      Q => \n_0_fifo0/fifo_1_reg[15][31]_srl16\
    );
\fifo0/fifo_1_reg[15][32]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(32),
      Q => \n_0_fifo0/fifo_1_reg[15][32]_srl16\
    );
\fifo0/fifo_1_reg[15][33]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(33),
      Q => \n_0_fifo0/fifo_1_reg[15][33]_srl16\
    );
\fifo0/fifo_1_reg[15][34]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(34),
      Q => \n_0_fifo0/fifo_1_reg[15][34]_srl16\
    );
\fifo0/fifo_1_reg[15][35]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(35),
      Q => \n_0_fifo0/fifo_1_reg[15][35]_srl16\
    );
\fifo0/fifo_1_reg[15][36]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(36),
      Q => \n_0_fifo0/fifo_1_reg[15][36]_srl16\
    );
\fifo0/fifo_1_reg[15][37]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(37),
      Q => \n_0_fifo0/fifo_1_reg[15][37]_srl16\
    );
\fifo0/fifo_1_reg[15][38]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(38),
      Q => \n_0_fifo0/fifo_1_reg[15][38]_srl16\
    );
\fifo0/fifo_1_reg[15][39]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(39),
      Q => \n_0_fifo0/fifo_1_reg[15][39]_srl16\
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
\fifo0/fifo_1_reg[15][40]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(40),
      Q => \n_0_fifo0/fifo_1_reg[15][40]_srl16\
    );
\fifo0/fifo_1_reg[15][41]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(41),
      Q => \n_0_fifo0/fifo_1_reg[15][41]_srl16\
    );
\fifo0/fifo_1_reg[15][42]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(42),
      Q => \n_0_fifo0/fifo_1_reg[15][42]_srl16\
    );
\fifo0/fifo_1_reg[15][43]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(43),
      Q => \n_0_fifo0/fifo_1_reg[15][43]_srl16\
    );
\fifo0/fifo_1_reg[15][44]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(44),
      Q => \n_0_fifo0/fifo_1_reg[15][44]_srl16\
    );
\fifo0/fifo_1_reg[15][45]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(45),
      Q => \n_0_fifo0/fifo_1_reg[15][45]_srl16\
    );
\fifo0/fifo_1_reg[15][46]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(46),
      Q => \n_0_fifo0/fifo_1_reg[15][46]_srl16\
    );
\fifo0/fifo_1_reg[15][47]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(47),
      Q => \n_0_fifo0/fifo_1_reg[15][47]_srl16\
    );
\fifo0/fifo_1_reg[15][48]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(48),
      Q => \n_0_fifo0/fifo_1_reg[15][48]_srl16\
    );
\fifo0/fifo_1_reg[15][49]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(49),
      Q => \n_0_fifo0/fifo_1_reg[15][49]_srl16\
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
\fifo0/fifo_1_reg[15][50]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(50),
      Q => \n_0_fifo0/fifo_1_reg[15][50]_srl16\
    );
\fifo0/fifo_1_reg[15][51]_srl16\: unisim.vcomponents.SRL16E
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
      D => wr_data(51),
      Q => \n_0_fifo0/fifo_1_reg[15][51]_srl16\
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
\fifo0/fifo_2_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][18]_srl16\,
      Q => ifx_data(18),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][19]_srl16\,
      Q => ifx_data(19),
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
\fifo0/fifo_2_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][20]_srl16\,
      Q => ifx_data(20),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][21]_srl16\,
      Q => ifx_data(21),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][22]_srl16\,
      Q => ifx_data(22),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][23]_srl16\,
      Q => ifx_data(23),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][24]_srl16\,
      Q => ifx_data(24),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][25]_srl16\,
      Q => ifx_data(25),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][26]_srl16\,
      Q => ifx_data(26),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][27]_srl16\,
      Q => ifx_data(27),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][28]_srl16\,
      Q => ifx_data(28),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][29]_srl16\,
      Q => ifx_data(29),
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
\fifo0/fifo_2_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][30]_srl16\,
      Q => ifx_data(30),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][31]_srl16\,
      Q => ifx_data(31),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][32]_srl16\,
      Q => ifx_data(32),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][33]_srl16\,
      Q => ifx_data(33),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][34]_srl16\,
      Q => ifx_data(34),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][35]_srl16\,
      Q => ifx_data(35),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][36]_srl16\,
      Q => ifx_data(36),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][37]_srl16\,
      Q => ifx_data(37),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][38]_srl16\,
      Q => ifx_data(38),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][39]_srl16\,
      Q => ifx_data(39),
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
\fifo0/fifo_2_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][40]_srl16\,
      Q => ifx_data(40),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][41]_srl16\,
      Q => ifx_data(41),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][42]_srl16\,
      Q => ifx_data(42),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][43]_srl16\,
      Q => ifx_data(43),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][44]_srl16\,
      Q => ifx_data(44),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][45]_srl16\,
      Q => ifx_data(45),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][46]_srl16\,
      Q => ifx_data(46),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][47]_srl16\,
      Q => ifx_data(47),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][48]_srl16\,
      Q => ifx_data(48),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][49]_srl16\,
      Q => ifx_data(49),
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
\fifo0/fifo_2_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][50]_srl16\,
      Q => ifx_data(50),
      R => \<const0>\
    );
\fifo0/fifo_2_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => rd_enable,
      D => \n_0_fifo0/fifo_1_reg[15][51]_srl16\,
      Q => ifx_data(51),
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
\fifo_2[51]_i_1\: unisim.vcomponents.LUT3
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
entity ip_fp32_axis_multmult_gen_v12_0_viv is
  port (
    CLK : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 23 downto 0 );
    B : in STD_LOGIC_VECTOR ( 23 downto 0 );
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    ZERO_DETECT : out STD_LOGIC_VECTOR ( 1 downto 0 );
    P : out STD_LOGIC_VECTOR ( 25 downto 0 );
    PCASC : out STD_LOGIC_VECTOR ( 47 downto 0 )
  );
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 0;
  attribute C_MODEL_TYPE : integer;
  attribute C_MODEL_TYPE of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_OPTIMIZE_GOAL : integer;
  attribute C_OPTIMIZE_GOAL of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of ip_fp32_axis_multmult_gen_v12_0_viv : entity is "kintex7";
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 0;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1000000015;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 24;
  attribute C_A_TYPE : integer;
  attribute C_A_TYPE of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 24;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_OUT_HIGH : integer;
  attribute C_OUT_HIGH of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 47;
  attribute C_OUT_LOW : integer;
  attribute C_OUT_LOW of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 22;
  attribute C_MULT_TYPE : integer;
  attribute C_MULT_TYPE of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 0;
  attribute C_CCM_IMP : integer;
  attribute C_CCM_IMP of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 0;
  attribute C_B_VALUE : string;
  attribute C_B_VALUE of ip_fp32_axis_multmult_gen_v12_0_viv : entity is "111111111111111111";
  attribute C_HAS_ZERO_DETECT : integer;
  attribute C_HAS_ZERO_DETECT of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 1;
  attribute C_ROUND_OUTPUT : integer;
  attribute C_ROUND_OUTPUT of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 0;
  attribute C_ROUND_PT : integer;
  attribute C_ROUND_PT of ip_fp32_axis_multmult_gen_v12_0_viv : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_multmult_gen_v12_0_viv : entity is "yes";
end ip_fp32_axis_multmult_gen_v12_0_viv;

architecture STRUCTURE of ip_fp32_axis_multmult_gen_v12_0_viv is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \gDSP.gDSP_only.iDSP/ACOUT\ : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal \gDSP.gDSP_only.iDSP/PATTERNDETECT\ : STD_LOGIC;
  signal \gDSP.gDSP_only.iDSP/PCOUT\ : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\ : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_subtract_delay.subtract_delay/dout_i\ : STD_LOGIC;
  signal \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\ : STD_LOGIC_VECTOR ( 42 downto 0 );
  signal \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay0/dout_i\ : STD_LOGIC;
  signal \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay1/dout_i\ : STD_LOGIC;
  signal \gDSP.gDSP_only.iDSP/use_prim.iAdelx[0].iAdely[0].use_delay_line.Adelay/dout_i\ : STD_LOGIC_VECTOR ( 24 to 24 );
  signal \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[0].need_delay_line.Bdelay/dout_i\ : STD_LOGIC_VECTOR ( 17 to 17 );
  signal \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\ : STD_LOGIC_VECTOR ( 7 to 7 );
  signal \n_0_d1.dout_i[0]_i_1\ : STD_LOGIC;
  signal \n_100_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_101_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_102_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_103_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_104_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_105_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_106_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_107_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_108_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_109_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_110_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_111_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_112_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_113_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_114_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_115_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_116_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_117_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_118_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_119_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_120_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_121_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_122_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_123_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_124_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_125_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_126_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_127_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_128_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_129_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_130_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_131_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_132_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_133_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_134_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_135_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_136_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_137_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_138_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_139_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_140_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_141_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_142_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_143_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_144_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_145_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_146_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_147_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_148_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_149_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_150_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_151_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_152_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_153_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_89_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_90_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_91_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_92_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_93_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_94_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_95_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_96_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_97_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_98_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal \n_99_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_CARRYCASCOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_BCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_CARRYOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_P_UNCONNECTED\ : STD_LOGIC_VECTOR ( 47 downto 17 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_CARRYCASCOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_ACOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_BCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_CARRYOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_P_UNCONNECTED\ : STD_LOGIC_VECTOR ( 47 downto 43 );
  attribute box_type : string;
  attribute box_type of \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\ : label is "PRIMITIVE";
  attribute box_type of \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\ : label is "PRIMITIVE";
begin
  PCASC(47) <= \<const0>\;
  PCASC(46) <= \<const0>\;
  PCASC(45) <= \<const0>\;
  PCASC(44) <= \<const0>\;
  PCASC(43) <= \<const0>\;
  PCASC(42) <= \<const0>\;
  PCASC(41) <= \<const0>\;
  PCASC(40) <= \<const0>\;
  PCASC(39) <= \<const0>\;
  PCASC(38) <= \<const0>\;
  PCASC(37) <= \<const0>\;
  PCASC(36) <= \<const0>\;
  PCASC(35) <= \<const0>\;
  PCASC(34) <= \<const0>\;
  PCASC(33) <= \<const0>\;
  PCASC(32) <= \<const0>\;
  PCASC(31) <= \<const0>\;
  PCASC(30) <= \<const0>\;
  PCASC(29) <= \<const0>\;
  PCASC(28) <= \<const0>\;
  PCASC(27) <= \<const0>\;
  PCASC(26) <= \<const0>\;
  PCASC(25) <= \<const0>\;
  PCASC(24) <= \<const0>\;
  PCASC(23) <= \<const0>\;
  PCASC(22) <= \<const0>\;
  PCASC(21) <= \<const0>\;
  PCASC(20) <= \<const0>\;
  PCASC(19) <= \<const0>\;
  PCASC(18) <= \<const0>\;
  PCASC(17) <= \<const0>\;
  PCASC(16) <= \<const0>\;
  PCASC(15) <= \<const0>\;
  PCASC(14) <= \<const0>\;
  PCASC(13) <= \<const0>\;
  PCASC(12) <= \<const0>\;
  PCASC(11) <= \<const0>\;
  PCASC(10) <= \<const0>\;
  PCASC(9) <= \<const0>\;
  PCASC(8) <= \<const0>\;
  PCASC(7) <= \<const0>\;
  PCASC(6) <= \<const0>\;
  PCASC(5) <= \<const0>\;
  PCASC(4) <= \<const0>\;
  PCASC(3) <= \<const0>\;
  PCASC(2) <= \<const0>\;
  PCASC(1) <= \<const0>\;
  PCASC(0) <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\d1.dout_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/PATTERNDETECT\,
      I1 => CE,
      I2 => \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay0/dout_i\,
      O => \n_0_d1.dout_i[0]_i_1\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_105_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(0),
      I2 => CE,
      O => p_0_in(0)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_95_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(10),
      I2 => CE,
      O => p_0_in(10)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_94_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(11),
      I2 => CE,
      O => p_0_in(11)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_93_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(12),
      I2 => CE,
      O => p_0_in(12)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_92_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(13),
      I2 => CE,
      O => p_0_in(13)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_91_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(14),
      I2 => CE,
      O => p_0_in(14)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_90_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(15),
      I2 => CE,
      O => p_0_in(15)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_89_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(16),
      I2 => CE,
      O => p_0_in(16)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_104_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(1),
      I2 => CE,
      O => p_0_in(1)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_103_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(2),
      I2 => CE,
      O => p_0_in(2)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_102_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(3),
      I2 => CE,
      O => p_0_in(3)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_101_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(4),
      I2 => CE,
      O => p_0_in(4)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_100_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(5),
      I2 => CE,
      O => p_0_in(5)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_99_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(6),
      I2 => CE,
      O => p_0_in(6)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_98_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(7),
      I2 => CE,
      O => p_0_in(7)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_97_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(8),
      I2 => CE,
      O => p_0_in(8)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_96_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      I1 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(9),
      I2 => CE,
      O => p_0_in(9)
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(0),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(0),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(10),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(10),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(11),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(11),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(12),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(12),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(13),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(13),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(14),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(14),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(15),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(15),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(16),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(16),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(1),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(1),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(2),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(2),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(3),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(3),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(4),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(4),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(5),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(5),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(6),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(6),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(7),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(7),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(8),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(8),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/d1.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => p_0_in(9),
      Q => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].need_output_delay.output_delay/dout_i\(9),
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 1,
      ADREG => 0,
      ALUMODEREG => 0,
      AREG => 1,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 0,
      DREG => 0,
      INMODEREG => 0,
      IS_ALUMODE_INVERTED => B"0000",
      IS_CARRYIN_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_INMODE_INVERTED => B"00000",
      IS_OPMODE_INVERTED => B"0000000",
      MASK => X"FFFFFFFE0000",
      MREG => 1,
      OPMODEREG => 1,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "PATDET",
      USE_SIMD => "ONE48"
    )
    port map (
      A(29) => \<const0>\,
      A(28) => \<const0>\,
      A(27) => \<const0>\,
      A(26) => \<const0>\,
      A(25) => \<const0>\,
      A(24) => \gDSP.gDSP_only.iDSP/use_prim.iAdelx[0].iAdely[0].use_delay_line.Adelay/dout_i\(24),
      A(23 downto 0) => A(23 downto 0),
      ACIN(29) => \<const0>\,
      ACIN(28) => \<const0>\,
      ACIN(27) => \<const0>\,
      ACIN(26) => \<const0>\,
      ACIN(25) => \<const0>\,
      ACIN(24) => \<const0>\,
      ACIN(23) => \<const0>\,
      ACIN(22) => \<const0>\,
      ACIN(21) => \<const0>\,
      ACIN(20) => \<const0>\,
      ACIN(19) => \<const0>\,
      ACIN(18) => \<const0>\,
      ACIN(17) => \<const0>\,
      ACIN(16) => \<const0>\,
      ACIN(15) => \<const0>\,
      ACIN(14) => \<const0>\,
      ACIN(13) => \<const0>\,
      ACIN(12) => \<const0>\,
      ACIN(11) => \<const0>\,
      ACIN(10) => \<const0>\,
      ACIN(9) => \<const0>\,
      ACIN(8) => \<const0>\,
      ACIN(7) => \<const0>\,
      ACIN(6) => \<const0>\,
      ACIN(5) => \<const0>\,
      ACIN(4) => \<const0>\,
      ACIN(3) => \<const0>\,
      ACIN(2) => \<const0>\,
      ACIN(1) => \<const0>\,
      ACIN(0) => \<const0>\,
      ACOUT(29 downto 0) => \gDSP.gDSP_only.iDSP/ACOUT\(29 downto 0),
      ALUMODE(3) => \<const0>\,
      ALUMODE(2) => \<const0>\,
      ALUMODE(1) => \<const0>\,
      ALUMODE(0) => \<const0>\,
      B(17) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[0].need_delay_line.Bdelay/dout_i\(17),
      B(16 downto 0) => B(16 downto 0),
      BCIN(17) => \<const0>\,
      BCIN(16) => \<const0>\,
      BCIN(15) => \<const0>\,
      BCIN(14) => \<const0>\,
      BCIN(13) => \<const0>\,
      BCIN(12) => \<const0>\,
      BCIN(11) => \<const0>\,
      BCIN(10) => \<const0>\,
      BCIN(9) => \<const0>\,
      BCIN(8) => \<const0>\,
      BCIN(7) => \<const0>\,
      BCIN(6) => \<const0>\,
      BCIN(5) => \<const0>\,
      BCIN(4) => \<const0>\,
      BCIN(3) => \<const0>\,
      BCIN(2) => \<const0>\,
      BCIN(1) => \<const0>\,
      BCIN(0) => \<const0>\,
      BCOUT(17 downto 0) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_BCOUT_UNCONNECTED\(17 downto 0),
      C(47) => \<const0>\,
      C(46) => \<const0>\,
      C(45) => \<const0>\,
      C(44) => \<const0>\,
      C(43) => \<const0>\,
      C(42) => \<const0>\,
      C(41) => \<const0>\,
      C(40) => \<const0>\,
      C(39) => \<const0>\,
      C(38) => \<const0>\,
      C(37) => \<const0>\,
      C(36) => \<const0>\,
      C(35) => \<const0>\,
      C(34) => \<const0>\,
      C(33) => \<const0>\,
      C(32) => \<const0>\,
      C(31) => \<const0>\,
      C(30) => \<const0>\,
      C(29) => \<const0>\,
      C(28) => \<const0>\,
      C(27) => \<const0>\,
      C(26) => \<const0>\,
      C(25) => \<const0>\,
      C(24) => \<const0>\,
      C(23) => \<const0>\,
      C(22) => \<const0>\,
      C(21) => \<const0>\,
      C(20) => \<const0>\,
      C(19) => \<const0>\,
      C(18) => \<const0>\,
      C(17) => \<const0>\,
      C(16) => \<const0>\,
      C(15) => \<const0>\,
      C(14) => \<const0>\,
      C(13) => \<const0>\,
      C(12) => \<const0>\,
      C(11) => \<const0>\,
      C(10) => \<const0>\,
      C(9) => \<const0>\,
      C(8) => \<const0>\,
      C(7) => \<const0>\,
      C(6) => \<const0>\,
      C(5) => \<const0>\,
      C(4) => \<const0>\,
      C(3) => \<const0>\,
      C(2) => \<const0>\,
      C(1) => \<const0>\,
      C(0) => \<const0>\,
      CARRYCASCIN => \<const0>\,
      CARRYCASCOUT => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_CARRYCASCOUT_UNCONNECTED\,
      CARRYIN => \<const0>\,
      CARRYINSEL(2) => \<const0>\,
      CARRYINSEL(1) => \<const0>\,
      CARRYINSEL(0) => \<const0>\,
      CARRYOUT(3 downto 0) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_CARRYOUT_UNCONNECTED\(3 downto 0),
      CEA1 => \<const0>\,
      CEA2 => CE,
      CEAD => \<const0>\,
      CEALUMODE => \<const0>\,
      CEB1 => \<const0>\,
      CEB2 => CE,
      CEC => \<const0>\,
      CECARRYIN => \<const0>\,
      CECTRL => CE,
      CED => \<const0>\,
      CEINMODE => \<const0>\,
      CEM => CE,
      CEP => CE,
      CLK => CLK,
      D(24) => \<const0>\,
      D(23) => \<const0>\,
      D(22) => \<const0>\,
      D(21) => \<const0>\,
      D(20) => \<const0>\,
      D(19) => \<const0>\,
      D(18) => \<const0>\,
      D(17) => \<const0>\,
      D(16) => \<const0>\,
      D(15) => \<const0>\,
      D(14) => \<const0>\,
      D(13) => \<const0>\,
      D(12) => \<const0>\,
      D(11) => \<const0>\,
      D(10) => \<const0>\,
      D(9) => \<const0>\,
      D(8) => \<const0>\,
      D(7) => \<const0>\,
      D(6) => \<const0>\,
      D(5) => \<const0>\,
      D(4) => \<const0>\,
      D(3) => \<const0>\,
      D(2) => \<const0>\,
      D(1) => \<const0>\,
      D(0) => \<const0>\,
      INMODE(4) => \<const0>\,
      INMODE(3) => \<const0>\,
      INMODE(2) => \<const0>\,
      INMODE(1) => \<const0>\,
      INMODE(0) => \<const0>\,
      MULTSIGNIN => \<const0>\,
      MULTSIGNOUT => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6) => \<const0>\,
      OPMODE(5) => \<const1>\,
      OPMODE(4) => \<const1>\,
      OPMODE(3) => \<const0>\,
      OPMODE(2) => \<const1>\,
      OPMODE(1) => \<const0>\,
      OPMODE(0) => \<const1>\,
      OVERFLOW => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_OVERFLOW_UNCONNECTED\,
      P(47 downto 17) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_P_UNCONNECTED\(47 downto 17),
      P(16) => \n_89_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(15) => \n_90_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(14) => \n_91_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(13) => \n_92_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(12) => \n_93_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(11) => \n_94_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(10) => \n_95_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(9) => \n_96_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(8) => \n_97_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(7) => \n_98_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(6) => \n_99_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(5) => \n_100_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(4) => \n_101_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(3) => \n_102_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(2) => \n_103_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(1) => \n_104_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      P(0) => \n_105_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1\,
      PATTERNBDETECT => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \gDSP.gDSP_only.iDSP/PATTERNDETECT\,
      PCIN(47) => \<const0>\,
      PCIN(46) => \<const0>\,
      PCIN(45) => \<const0>\,
      PCIN(44) => \<const0>\,
      PCIN(43) => \<const0>\,
      PCIN(42) => \<const0>\,
      PCIN(41) => \<const0>\,
      PCIN(40) => \<const0>\,
      PCIN(39) => \<const0>\,
      PCIN(38) => \<const0>\,
      PCIN(37) => \<const0>\,
      PCIN(36) => \<const0>\,
      PCIN(35) => \<const0>\,
      PCIN(34) => \<const0>\,
      PCIN(33) => \<const0>\,
      PCIN(32) => \<const0>\,
      PCIN(31) => \<const0>\,
      PCIN(30) => \<const0>\,
      PCIN(29) => \<const0>\,
      PCIN(28) => \<const0>\,
      PCIN(27) => \<const0>\,
      PCIN(26) => \<const0>\,
      PCIN(25) => \<const0>\,
      PCIN(24) => \<const0>\,
      PCIN(23) => \<const0>\,
      PCIN(22) => \<const0>\,
      PCIN(21) => \<const0>\,
      PCIN(20) => \<const0>\,
      PCIN(19) => \<const0>\,
      PCIN(18) => \<const0>\,
      PCIN(17) => \<const0>\,
      PCIN(16) => \<const0>\,
      PCIN(15) => \<const0>\,
      PCIN(14) => \<const0>\,
      PCIN(13) => \<const0>\,
      PCIN(12) => \<const0>\,
      PCIN(11) => \<const0>\,
      PCIN(10) => \<const0>\,
      PCIN(9) => \<const0>\,
      PCIN(8) => \<const0>\,
      PCIN(7) => \<const0>\,
      PCIN(6) => \<const0>\,
      PCIN(5) => \<const0>\,
      PCIN(4) => \<const0>\,
      PCIN(3) => \<const0>\,
      PCIN(2) => \<const0>\,
      PCIN(1) => \<const0>\,
      PCIN(0) => \<const0>\,
      PCOUT(47 downto 0) => \gDSP.gDSP_only.iDSP/PCOUT\(47 downto 0),
      RSTA => \<const0>\,
      RSTALLCARRYIN => \<const0>\,
      RSTALUMODE => \<const0>\,
      RSTB => \<const0>\,
      RSTC => \<const0>\,
      RSTCTRL => \<const0>\,
      RSTD => \<const0>\,
      RSTINMODE => \<const0>\,
      RSTM => \<const0>\,
      RSTP => \<const0>\,
      UNDERFLOW => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_dsp.use_dsp48e1.iDSP48E1_UNDERFLOW_UNCONNECTED\
    );
\gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 1,
      ADREG => 0,
      ALUMODEREG => 1,
      AREG => 1,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "CASCADE",
      BCASCREG => 2,
      BREG => 2,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 0,
      DREG => 0,
      INMODEREG => 0,
      IS_ALUMODE_INVERTED => B"0000",
      IS_CARRYIN_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_INMODE_INVERTED => B"00000",
      IS_OPMODE_INVERTED => B"0000000",
      MASK => X"FFFFFFFFFFE0",
      MREG => 1,
      OPMODEREG => 1,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "PATDET",
      USE_SIMD => "ONE48"
    )
    port map (
      A(29) => \<const0>\,
      A(28) => \<const0>\,
      A(27) => \<const0>\,
      A(26) => \<const0>\,
      A(25) => \<const0>\,
      A(24) => \<const0>\,
      A(23) => \<const0>\,
      A(22) => \<const0>\,
      A(21) => \<const0>\,
      A(20) => \<const0>\,
      A(19) => \<const0>\,
      A(18) => \<const0>\,
      A(17) => \<const0>\,
      A(16) => \<const0>\,
      A(15) => \<const0>\,
      A(14) => \<const0>\,
      A(13) => \<const0>\,
      A(12) => \<const0>\,
      A(11) => \<const0>\,
      A(10) => \<const0>\,
      A(9) => \<const0>\,
      A(8) => \<const0>\,
      A(7) => \<const0>\,
      A(6) => \<const0>\,
      A(5) => \<const0>\,
      A(4) => \<const0>\,
      A(3) => \<const0>\,
      A(2) => \<const0>\,
      A(1) => \<const0>\,
      A(0) => \<const0>\,
      ACIN(29 downto 0) => \gDSP.gDSP_only.iDSP/ACOUT\(29 downto 0),
      ACOUT(29 downto 0) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_ACOUT_UNCONNECTED\(29 downto 0),
      ALUMODE(3) => \<const0>\,
      ALUMODE(2) => \<const0>\,
      ALUMODE(1) => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_subtract_delay.subtract_delay/dout_i\,
      ALUMODE(0) => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_subtract_delay.subtract_delay/dout_i\,
      B(17) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(16) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(15) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(14) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(13) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(12) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(11) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(10) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(9) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(8) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(7) => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7),
      B(6 downto 0) => B(23 downto 17),
      BCIN(17) => \<const0>\,
      BCIN(16) => \<const0>\,
      BCIN(15) => \<const0>\,
      BCIN(14) => \<const0>\,
      BCIN(13) => \<const0>\,
      BCIN(12) => \<const0>\,
      BCIN(11) => \<const0>\,
      BCIN(10) => \<const0>\,
      BCIN(9) => \<const0>\,
      BCIN(8) => \<const0>\,
      BCIN(7) => \<const0>\,
      BCIN(6) => \<const0>\,
      BCIN(5) => \<const0>\,
      BCIN(4) => \<const0>\,
      BCIN(3) => \<const0>\,
      BCIN(2) => \<const0>\,
      BCIN(1) => \<const0>\,
      BCIN(0) => \<const0>\,
      BCOUT(17 downto 0) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_BCOUT_UNCONNECTED\(17 downto 0),
      C(47) => \<const1>\,
      C(46) => \<const1>\,
      C(45) => \<const1>\,
      C(44) => \<const1>\,
      C(43) => \<const1>\,
      C(42) => \<const1>\,
      C(41) => \<const1>\,
      C(40) => \<const1>\,
      C(39) => \<const1>\,
      C(38) => \<const1>\,
      C(37) => \<const1>\,
      C(36) => \<const1>\,
      C(35) => \<const1>\,
      C(34) => \<const1>\,
      C(33) => \<const1>\,
      C(32) => \<const1>\,
      C(31) => \<const1>\,
      C(30) => \<const1>\,
      C(29) => \<const1>\,
      C(28) => \<const1>\,
      C(27) => \<const1>\,
      C(26) => \<const1>\,
      C(25) => \<const1>\,
      C(24) => \<const1>\,
      C(23) => \<const1>\,
      C(22) => \<const1>\,
      C(21) => \<const1>\,
      C(20) => \<const1>\,
      C(19) => \<const1>\,
      C(18) => \<const1>\,
      C(17) => \<const1>\,
      C(16) => \<const1>\,
      C(15) => \<const1>\,
      C(14) => \<const1>\,
      C(13) => \<const1>\,
      C(12) => \<const1>\,
      C(11) => \<const1>\,
      C(10) => \<const1>\,
      C(9) => \<const1>\,
      C(8) => \<const1>\,
      C(7) => \<const1>\,
      C(6) => \<const1>\,
      C(5) => \<const1>\,
      C(4) => \<const1>\,
      C(3) => \<const1>\,
      C(2) => \<const1>\,
      C(1) => \<const1>\,
      C(0) => \<const1>\,
      CARRYCASCIN => \<const0>\,
      CARRYCASCOUT => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_CARRYCASCOUT_UNCONNECTED\,
      CARRYIN => \<const0>\,
      CARRYINSEL(2) => \<const0>\,
      CARRYINSEL(1) => \<const0>\,
      CARRYINSEL(0) => \<const0>\,
      CARRYOUT(3 downto 0) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_CARRYOUT_UNCONNECTED\(3 downto 0),
      CEA1 => \<const0>\,
      CEA2 => CE,
      CEAD => \<const0>\,
      CEALUMODE => CE,
      CEB1 => CE,
      CEB2 => CE,
      CEC => \<const0>\,
      CECARRYIN => \<const0>\,
      CECTRL => CE,
      CED => \<const0>\,
      CEINMODE => \<const0>\,
      CEM => CE,
      CEP => CE,
      CLK => CLK,
      D(24) => \<const0>\,
      D(23) => \<const0>\,
      D(22) => \<const0>\,
      D(21) => \<const0>\,
      D(20) => \<const0>\,
      D(19) => \<const0>\,
      D(18) => \<const0>\,
      D(17) => \<const0>\,
      D(16) => \<const0>\,
      D(15) => \<const0>\,
      D(14) => \<const0>\,
      D(13) => \<const0>\,
      D(12) => \<const0>\,
      D(11) => \<const0>\,
      D(10) => \<const0>\,
      D(9) => \<const0>\,
      D(8) => \<const0>\,
      D(7) => \<const0>\,
      D(6) => \<const0>\,
      D(5) => \<const0>\,
      D(4) => \<const0>\,
      D(3) => \<const0>\,
      D(2) => \<const0>\,
      D(1) => \<const0>\,
      D(0) => \<const0>\,
      INMODE(4) => \<const0>\,
      INMODE(3) => \<const0>\,
      INMODE(2) => \<const0>\,
      INMODE(1) => \<const0>\,
      INMODE(0) => \<const0>\,
      MULTSIGNIN => \<const0>\,
      MULTSIGNOUT => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6) => \<const1>\,
      OPMODE(5) => \<const0>\,
      OPMODE(4) => \<const1>\,
      OPMODE(3) => \<const0>\,
      OPMODE(2) => \<const1>\,
      OPMODE(1) => \<const0>\,
      OPMODE(0) => \<const1>\,
      OVERFLOW => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_OVERFLOW_UNCONNECTED\,
      P(47 downto 43) => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_P_UNCONNECTED\(47 downto 43),
      P(42 downto 0) => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(42 downto 0),
      PATTERNBDETECT => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay1/dout_i\,
      PCIN(47 downto 0) => \gDSP.gDSP_only.iDSP/PCOUT\(47 downto 0),
      PCOUT(47) => \n_106_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(46) => \n_107_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(45) => \n_108_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(44) => \n_109_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(43) => \n_110_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(42) => \n_111_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(41) => \n_112_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(40) => \n_113_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(39) => \n_114_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(38) => \n_115_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(37) => \n_116_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(36) => \n_117_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(35) => \n_118_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(34) => \n_119_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(33) => \n_120_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(32) => \n_121_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(31) => \n_122_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(30) => \n_123_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(29) => \n_124_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(28) => \n_125_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(27) => \n_126_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(26) => \n_127_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(25) => \n_128_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(24) => \n_129_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(23) => \n_130_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(22) => \n_131_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(21) => \n_132_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(20) => \n_133_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(19) => \n_134_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(18) => \n_135_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(17) => \n_136_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(16) => \n_137_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(15) => \n_138_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(14) => \n_139_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(13) => \n_140_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(12) => \n_141_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(11) => \n_142_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(10) => \n_143_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(9) => \n_144_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(8) => \n_145_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(7) => \n_146_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(6) => \n_147_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(5) => \n_148_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(4) => \n_149_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(3) => \n_150_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(2) => \n_151_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(1) => \n_152_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      PCOUT(0) => \n_153_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1\,
      RSTA => \<const0>\,
      RSTALLCARRYIN => \<const0>\,
      RSTALUMODE => \<const0>\,
      RSTB => \<const0>\,
      RSTC => \<const0>\,
      RSTCTRL => \<const0>\,
      RSTD => \<const0>\,
      RSTINMODE => \<const0>\,
      RSTM => \<const0>\,
      RSTP => \<const0>\,
      UNDERFLOW => \NLW_gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].use_dsp.use_dsp48e1.iDSP48E1_UNDERFLOW_UNCONNECTED\
    );
\gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay0/d1.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => \<const1>\,
      D => \n_0_d1.dout_i[0]_i_1\,
      Q => \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay0/dout_i\,
      R => \<const0>\
    );
\gDSP.gDSP_only.iDSPi_31\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay0/dout_i\,
      O => ZERO_DETECT(0)
    );
\use_prim.appDSP48[0].bppDSP48[0].use_subtract_delay.subtract_delayi_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \<const0>\,
      O => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[0].use_subtract_delay.subtract_delay/dout_i\
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(24),
      O => P(19)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(23),
      O => P(18)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_12\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(22),
      O => P(17)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_13\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(21),
      O => P(16)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_14\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(20),
      O => P(15)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_15\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(19),
      O => P(14)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(18),
      O => P(13)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_17\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(17),
      O => P(12)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_18\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(16),
      O => P(11)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_19\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(15),
      O => P(10)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_20\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(14),
      O => P(9)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_21\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(13),
      O => P(8)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_22\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(12),
      O => P(7)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_23\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(11),
      O => P(6)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_24\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(10),
      O => P(5)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_25\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(9),
      O => P(4)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_26\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(8),
      O => P(3)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_27\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(7),
      O => P(2)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_28\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(6),
      O => P(1)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_29\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(5),
      O => P(0)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(30),
      O => P(25)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(29),
      O => P(24)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(28),
      O => P(23)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(27),
      O => P(22)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(26),
      O => P(21)
    );
\use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delayi_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.appDSP48[0].bppDSP48[1].need_output_delay.output_delay/dout_i\(25),
      O => P(20)
    );
\use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay1i_30\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \gDSP.gDSP_only.iDSP/use_prim.has_zero_detect.zd_a1b2.multi_dsp_output.zd_delay1/dout_i\,
      O => ZERO_DETECT(1)
    );
\use_prim.iAdelx[0].iAdely[0].use_delay_line.Adelayi_0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \<const0>\,
      O => \gDSP.gDSP_only.iDSP/use_prim.iAdelx[0].iAdely[0].use_delay_line.Adelay/dout_i\(24)
    );
\use_prim.iBdelx[0].iBdely[0].need_delay_line.Bdelayi_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \<const0>\,
      O => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[0].need_delay_line.Bdelay/dout_i\(17)
    );
\use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelayi_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \<const0>\,
      O => \gDSP.gDSP_only.iDSP/use_prim.iBdelx[0].iBdely[1].need_delay_line.Bdelay/dout_i\(7)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ is
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
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 18 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is "floating_point_v7_0_viv";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 11;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 2;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 2;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is 19;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ : entity is "yes";
end \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\;

architecture STRUCTURE of \ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/EXP/COND_DET_A/exp_all_one_ip\ : STD_LOGIC;
  signal \MULT.OP/EXP/COND_DET_A/exp_all_zero_ip\ : STD_LOGIC;
  signal \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/EXP/COND_DET_B/exp_all_one_ip\ : STD_LOGIC;
  signal \MULT.OP/EXP/COND_DET_B/exp_all_zero_ip\ : STD_LOGIC;
  signal \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \MULT.OP/EXP/EXP_ADD.C_CHAIN/CI\ : STD_LOGIC;
  signal \MULT.OP/EXP/EXP_ADD.C_CHAIN/D\ : STD_LOGIC;
  signal \MULT.OP/EXP/EXP_ADD.C_CHAIN/O\ : STD_LOGIC;
  signal \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/EXP/INV_OP_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/INV_OP_DEL/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/PROD_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \MULT.OP/EXP/SIGN_RND_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/first_q\ : signal is "true";
  signal \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \MULT.OP/EXP/STATE_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \MULT.OP/EXP/a_mant_is_zero_int\ : STD_LOGIC;
  signal \MULT.OP/EXP/a_xor_b_ip\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/EXP/b_mant_is_zero_int\ : STD_LOGIC;
  signal \MULT.OP/EXP/flow_int_up\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/EXP/flow_sig\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/EXP/invalid_op_det\ : STD_LOGIC;
  signal \MULT.OP/EXP/p_0_in2_in\ : STD_LOGIC;
  signal \MULT.OP/EXP/p_1_in4_in\ : STD_LOGIC;
  signal \MULT.OP/EXP/prod_sign_ip\ : STD_LOGIC;
  signal \MULT.OP/EXP/sign_det\ : STD_LOGIC;
  signal \MULT.OP/EXP/sign_int_up\ : STD_LOGIC;
  signal \MULT.OP/EXP/state\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \MULT.OP/EXP/state_det\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\ : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/zero_detect_mult\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \MULT.OP/OP/exp_op6_out\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \MULT.OP/OP/p_10_out\ : STD_LOGIC;
  signal \MULT.OP/OP/p_12_out\ : STD_LOGIC;
  signal \MULT.OP/OP/p_5_out\ : STD_LOGIC_VECTOR ( 22 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_INC_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CI\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/D\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/O\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CI\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/D\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/O\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/carry_op\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/carry_rnd2\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/round_rnd1\ : STD_LOGIC;
  signal \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \MULT.OP/R_AND_R/normalize_local\ : STD_LOGIC;
  signal \MULT.OP/exp_rnd\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \MULT.OP/flow_op\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \MULT.OP/mant_casc_rnd\ : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal SIGN : STD_LOGIC;
  signal combiner_data_valid : STD_LOGIC;
  signal \i_nd_to_rdy/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \i_nd_to_rdy/first_q\ : signal is "true";
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal lopt_10 : STD_LOGIC;
  signal lopt_11 : STD_LOGIC;
  signal lopt_12 : STD_LOGIC;
  signal lopt_13 : STD_LOGIC;
  signal lopt_14 : STD_LOGIC;
  signal lopt_2 : STD_LOGIC;
  signal lopt_3 : STD_LOGIC;
  signal lopt_4 : STD_LOGIC;
  signal lopt_5 : STD_LOGIC;
  signal lopt_6 : STD_LOGIC;
  signal lopt_7 : STD_LOGIC;
  signal lopt_8 : STD_LOGIC;
  signal lopt_9 : STD_LOGIC;
  signal \^m_axis_result_tvalid\ : STD_LOGIC;
  signal m_axis_z_tdata_b : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_HAS_ARESETN.sclr_i_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[1].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[2].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[5].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[5].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[6].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[6].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[7].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[5].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[10].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[10].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[11].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[2].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[3].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[6].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[6].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[7].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[10].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[10].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[11].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[11].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[1].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[2].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[5].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[5].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[6].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[6].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[9].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[9].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[1]_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[2]_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[3]_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[4]_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[5]_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[6]_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.exp_op[7]_i_1\ : STD_LOGIC;
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
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\ : STD_LOGIC;
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\ : STD_LOGIC;
  signal \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[10]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[11]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[12]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[13]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_2\ : STD_LOGIC;
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
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal p_1_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_4_in : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal p_4_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \pipe[3]\ : STD_LOGIC;
  signal \pipe[5]\ : STD_LOGIC;
  signal \pipe[6]\ : STD_LOGIC;
  signal \pipe[7]\ : STD_LOGIC;
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
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_afull_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_full_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_afull_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_full_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_add_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute AFULL_THRESH0 : integer;
  attribute AFULL_THRESH0 of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 1;
  attribute AFULL_THRESH1 : integer;
  attribute AFULL_THRESH1 of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 1;
  attribute DEPTH : integer;
  attribute DEPTH of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 16;
  attribute WIDTH : integer;
  attribute WIDTH of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 52;
  attribute downgradeipidentifiedwarnings of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is "yes";
  attribute keep : string;
  attribute keep of \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type : string;
  attribute box_type of \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute keep of \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\ : label is "FDE";
  attribute box_type of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name : string;
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2 ";
  attribute keep of \MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : label is "U0/i_synth/\MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6] ";
  attribute srl_name of \MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : label is "U0/i_synth/\MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5 ";
  attribute keep of \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2 ";
  attribute keep of \MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute srl_bus_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2 ";
  attribute keep of \MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute srl_bus_name of \MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2 ";
  attribute srl_bus_name of \MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2 ";
  attribute keep of \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute C_A_TYPE : integer;
  attribute C_A_TYPE of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_A_WIDTH of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 24;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_B_VALUE : string;
  attribute C_B_VALUE of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is "111111111111111111";
  attribute C_B_WIDTH of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 24;
  attribute C_CCM_IMP : integer;
  attribute C_CCM_IMP of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 0;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 0;
  attribute C_HAS_ZERO_DETECT : integer;
  attribute C_HAS_ZERO_DETECT of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_LATENCY of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1000000015;
  attribute C_MODEL_TYPE : integer;
  attribute C_MODEL_TYPE of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_MULT_TYPE : integer;
  attribute C_MULT_TYPE of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_OPTIMIZE_GOAL : integer;
  attribute C_OPTIMIZE_GOAL of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 1;
  attribute C_OUT_HIGH : integer;
  attribute C_OUT_HIGH of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 47;
  attribute C_OUT_LOW : integer;
  attribute C_OUT_LOW of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 22;
  attribute C_ROUND_OUTPUT : integer;
  attribute C_ROUND_OUTPUT of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 0;
  attribute C_ROUND_PT : integer;
  attribute C_ROUND_PT of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 0;
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is 0;
  attribute C_XDEVICEFAMILY of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is "kintex7";
  attribute downgradeipidentifiedwarnings of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[12]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[13]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[14]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[15]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[16]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[17]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[18]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[19]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[20]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[21]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[22]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[23]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[24]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[25]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute use_sync_reset : string;
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[0]\ : label is "auto";
  attribute use_sync_set : string;
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[0]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[1]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[1]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[2]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[2]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[3]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[3]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[4]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[4]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[5]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[5]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[6]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[6]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[7]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[7]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[0]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[0]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[10]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[10]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[11]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[11]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[12]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[12]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[13]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[13]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[14]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[14]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[15]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[15]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[16]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[16]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[17]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[17]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[18]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[18]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[19]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[19]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[1]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[1]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[20]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[20]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[21]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[21]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[22]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[22]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[2]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[2]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[3]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[3]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[4]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[4]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[5]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[5]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[6]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[6]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[7]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[7]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[8]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[8]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[9]\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[9]\ : label is "auto";
  attribute use_sync_reset of \MULT.OP/OP/RESULT_REG.NORMAL.sign_op_reg\ : label is "auto";
  attribute use_sync_set of \MULT.OP/OP/RESULT_REG.NORMAL.sign_op_reg\ : label is "auto";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\ : label is "FDE";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\ : label is "FDE";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[10]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[11]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[12]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[13]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[14]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[15]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[16]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[17]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[18]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[19]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[20]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[21]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[22]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[23]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[24]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[25]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[26]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[27]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[28]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[29]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[30]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[31]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[4]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[5]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[6]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[7]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[8]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[9]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[0]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[1]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[2]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[3]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[4]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[5]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[6]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[7]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[0]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[10]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[11]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[12]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[13]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[14]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[15]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[16]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[17]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[18]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[19]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[1]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[20]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[21]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[22]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[23]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[24]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[25]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[26]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[27]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[28]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[29]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[2]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[30]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[31]_i_2\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[3]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[4]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[5]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[6]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[7]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[8]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[9]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[0]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[1]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[2]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[3]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[4]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[5]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[6]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[7]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_valid_i_2\ : label is "soft_lutpair43";
  attribute keep of \i_nd_to_rdy/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6 ";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__10\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__11\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__8\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__9\ : label is "soft_lutpair44";
begin
  m_axis_result_tvalid <= \^m_axis_result_tvalid\;
  s_axis_a_tready <= \^s_axis_a_tready\;
  s_axis_b_tready <= \^s_axis_b_tready\;
  s_axis_c_tready <= \<const1>\;
  s_axis_operation_tready <= \<const1>\;
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(2),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(3),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\(0),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(1),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\(1),
      I3 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(0),
      O => \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(2),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(1),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(23),
      I1 => m_axis_z_tdata_b(23),
      O => \MULT.OP/EXP/a_xor_b_ip\(0)
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(12),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(13),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(10)
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(12),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(11),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(10)
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_INC_DELAY/i_pipe/first_q\,
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(11)
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(13),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(12),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(11)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(3),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(4),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(3),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(2),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(24),
      I1 => m_axis_z_tdata_b(24),
      O => \MULT.OP/EXP/a_xor_b_ip\(1)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(4),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(5),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5777553355335533"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(1),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(2),
      I3 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I4 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\(1),
      I5 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\(0),
      O => \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(4),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(3),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(25),
      I1 => m_axis_z_tdata_b(25),
      O => \MULT.OP/EXP/a_xor_b_ip\(2)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(5),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(6),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(5),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(4),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(26),
      I1 => m_axis_z_tdata_b(26),
      O => \MULT.OP/EXP/a_xor_b_ip\(3)
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(6),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(7),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(4)
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(6),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(5),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(4)
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(27),
      I1 => m_axis_z_tdata_b(27),
      O => \MULT.OP/EXP/a_xor_b_ip\(4)
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(7),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(8),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(5)
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(7),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(6),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(5)
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(28),
      I1 => m_axis_z_tdata_b(28),
      O => \MULT.OP/EXP/a_xor_b_ip\(5)
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(8),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(9),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(6)
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(8),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(7),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(6)
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(29),
      I1 => m_axis_z_tdata_b(29),
      O => \MULT.OP/EXP/a_xor_b_ip\(6)
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(9),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(10),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(7)
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(9),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(8),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(7)
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(30),
      I1 => m_axis_z_tdata_b(30),
      O => \MULT.OP/EXP/a_xor_b_ip\(7)
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(10),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(11),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(8)
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(10),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(9),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(8)
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(11),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(12),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(9)
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(11),
      I1 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(10),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(9)
    );
\FLAGS_REG.NOT_LATE_UPDATE_GEN.OVERFLOW_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => \MULT.OP/flow_op\(0),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(11),
      I2 => \MULT.OP/flow_op\(2),
      O => \MULT.OP/OP/p_12_out\
    );
\FLAGS_REG.NOT_LATE_UPDATE_GEN.UNDERFLOW_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => \MULT.OP/flow_op\(1),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(11),
      I2 => \MULT.OP/flow_op\(3),
      O => \MULT.OP/OP/p_10_out\
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
\HAS_OUTPUT_FIFO.i_output_fifo\: entity work.ip_fp32_axis_multglb_ifx_master
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      add(4 downto 0) => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_add_UNCONNECTED\(4 downto 0),
      afull => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_afull_UNCONNECTED\,
      areset => sclr_i,
      full => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_full_UNCONNECTED\,
      ifx_data(51) => m_axis_result_tlast,
      ifx_data(50 downto 32) => m_axis_result_tuser(18 downto 0),
      ifx_data(31 downto 0) => m_axis_result_tdata(31 downto 0),
      ifx_ready => m_axis_result_tready,
      ifx_valid => \^m_axis_result_tvalid\,
      not_afull => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_afull_UNCONNECTED\,
      not_full => \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_full_UNCONNECTED\,
      wr_data(51 downto 35) => p_4_in(16 downto 0),
      wr_data(34) => p_3_in,
      wr_data(33) => p_2_in,
      wr_data(32) => p_1_in,
      wr_data(31 downto 0) => p_0_in(31 downto 0),
      wr_enable => valid_transfer_out
    );
\MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/COND_DET_A/exp_all_one_ip\,
      Q => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/COND_DET_A/exp_all_zero_ip\,
      Q => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      CO(2 downto 0) => \NLW_MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3 downto 0)
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      Q => \MULT.OP/EXP/a_mant_is_zero_int\,
      R => GND_2
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(4),
      I1 => p_4_out(3),
      I2 => p_4_out(0),
      I3 => p_4_out(5),
      I4 => p_4_out(2),
      I5 => p_4_out(1),
      O => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(0)
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(10),
      I1 => p_4_out(9),
      I2 => p_4_out(6),
      I3 => p_4_out(11),
      I4 => p_4_out(8),
      I5 => p_4_out(7),
      O => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(1)
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(16),
      I1 => p_4_out(15),
      I2 => p_4_out(12),
      I3 => p_4_out(17),
      I4 => p_4_out(14),
      I5 => p_4_out(13),
      O => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(2)
    );
\MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => p_4_out(20),
      I1 => p_4_out(18),
      I2 => p_4_out(22),
      I3 => p_4_out(21),
      I4 => p_4_out(19),
      O => \MULT.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3)
    );
\MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/COND_DET_B/exp_all_one_ip\,
      Q => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/COND_DET_B/exp_all_zero_ip\,
      Q => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_1,
      CO(3) => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      CO(2 downto 0) => \NLW_MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3 downto 0)
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      Q => \MULT.OP/EXP/b_mant_is_zero_int\,
      R => GND_2
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(4),
      I1 => m_axis_z_tdata_b(3),
      I2 => m_axis_z_tdata_b(0),
      I3 => m_axis_z_tdata_b(5),
      I4 => m_axis_z_tdata_b(2),
      I5 => m_axis_z_tdata_b(1),
      O => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(0)
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(10),
      I1 => m_axis_z_tdata_b(9),
      I2 => m_axis_z_tdata_b(6),
      I3 => m_axis_z_tdata_b(11),
      I4 => m_axis_z_tdata_b(8),
      I5 => m_axis_z_tdata_b(7),
      O => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(1)
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(16),
      I1 => m_axis_z_tdata_b(15),
      I2 => m_axis_z_tdata_b(12),
      I3 => m_axis_z_tdata_b(17),
      I4 => m_axis_z_tdata_b(14),
      I5 => m_axis_z_tdata_b(13),
      O => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(2)
    );
\MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(20),
      I1 => m_axis_z_tdata_b(18),
      I2 => m_axis_z_tdata_b(22),
      I3 => m_axis_z_tdata_b(21),
      I4 => m_axis_z_tdata_b(19),
      O => \MULT.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3)
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CI\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3 downto 0) => \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_CO_UNCONNECTED\(3 downto 0),
      CYINIT => lopt_13,
      DI(3 downto 0) => \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_DI_UNCONNECTED\(3 downto 0),
      O(3 downto 1) => \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_O_UNCONNECTED\(3 downto 1),
      O(0) => \MULT.OP/EXP/EXP_ADD.C_CHAIN/D\,
      S(3 downto 1) => \NLW_MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_S_UNCONNECTED\(3 downto 1),
      S(0) => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_13
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/D\,
      Q => \MULT.OP/EXP/p_1_in4_in\,
      R => GND_2
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_2,
      CO(3) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CO(0) => \MULT.OP/EXP/EXP_ADD.C_CHAIN/CI\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => m_axis_z_tdata_b(26 downto 23),
      O(3) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      O(0) => \MULT.OP/EXP/EXP_ADD.C_CHAIN/O\,
      S(3 downto 0) => \MULT.OP/EXP/a_xor_b_ip\(3 downto 0)
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_2
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CYINIT => lopt_3,
      DI(3 downto 0) => m_axis_z_tdata_b(30 downto 27),
      O(3) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      O(0) => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      S(3 downto 0) => \MULT.OP/EXP/a_xor_b_ip\(7 downto 4)
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_3
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/O\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_ADD.C_CHAIN/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(0),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(1),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(2),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(3),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(4),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(5),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(6),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(7),
      Q => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(0),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(1),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(2),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(3),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(4),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(5),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(6),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/first_q\(7),
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][4]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][5]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][6]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]\,
      R => \<const0>\
    );
\MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][7]_srl2\,
      Q => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]\,
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_int_up\(3),
      Q => \MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_int_up\(0),
      Q => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_int_up\(1),
      Q => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_int_up\(2),
      Q => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_int_up\(3),
      Q => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(0),
      Q => \MULT.OP/flow_op\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(1),
      Q => \MULT.OP/flow_op\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(2),
      Q => \MULT.OP/flow_op\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/FLOW_UP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/FLOW_UP_DEL/i_pipe/first_q\(3),
      Q => \MULT.OP/flow_op\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/invalid_op_det\,
      Q => \MULT.OP/EXP/INV_OP_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/INV_OP_DEL/i_pipe/first_q\,
      Q => \n_0_MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\
    );
\MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/sign_det\,
      Q => \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/first_q\,
      Q => \n_0_MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\
    );
\MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/IP_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\,
      Q => \MULT.OP/EXP/sign_int_up\,
      R => \<const0>\
    );
\MULT.OP/EXP/PROD_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/prod_sign_ip\,
      Q => \MULT.OP/EXP/PROD_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/SIGN_RND_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/PROD_DELAY/i_pipe/first_q\,
      Q => \MULT.OP/EXP/SIGN_RND_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/sign_int_up\,
      Q => \MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/SIGN_UP_DELAY/i_pipe/first_q\,
      Q => SIGN,
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_sig\(0),
      Q => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_sig\(1),
      Q => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_sig\(2),
      Q => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/flow_sig\(3),
      Q => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(0),
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(1),
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(2),
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/SIG_DELAY/i_pipe/first_q\(3),
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\,
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\,
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][2]_srl2\,
      Q => \MULT.OP/EXP/p_0_in2_in\,
      R => \<const0>\
    );
\MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][3]_srl2\,
      Q => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\,
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__2\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[10]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[11]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[12]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[13]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__0\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[3]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[10]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[11]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[10]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[11]_i_1\,
      Q => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/state_det\(0),
      Q => \MULT.OP/EXP/STATE_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/EXP/state_det\(1),
      Q => \MULT.OP/EXP/STATE_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/STATE_DELAY/i_pipe/first_q\(0),
      Q => \n_0_MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\
    );
\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \MULT.OP/EXP/STATE_DELAY/i_pipe/first_q\(1),
      Q => \n_0_MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\
    );
\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\,
      Q => \MULT.OP/EXP/state\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\,
      Q => \MULT.OP/EXP/state\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__1\,
      Q => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[1]_i_1\,
      Q => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/EXP/STATE_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/MULT\: entity work.ip_fp32_axis_multmult_gen_v12_0_viv
    port map (
      A(23) => \<const1>\,
      A(22 downto 0) => p_4_out(22 downto 0),
      B(23) => \<const1>\,
      B(22 downto 0) => m_axis_z_tdata_b(22 downto 0),
      CE => \<const1>\,
      CLK => aclk,
      P(25 downto 0) => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(25 downto 0),
      PCASC(47 downto 0) => \MULT.OP/mant_casc_rnd\(47 downto 0),
      SCLR => \<const0>\,
      ZERO_DETECT(1 downto 0) => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/zero_detect_mult\(1 downto 0)
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(0),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(10),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(11),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(11),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(12),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(12),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(13),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(13),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(14),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(14),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(15),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(15),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(16),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(16),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(17),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(17),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(18),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(18),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(19),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(19),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(1),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(20),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(20),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(21),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(21),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(22),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(22),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(23),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(23),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(24),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(24),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(25),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(2),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(3),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(4),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(5),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(6),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(7),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(8),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/mant_mult\(9),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/zero_detect_mult\(0),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/zero_detect_mult\(1),
      Q => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.ZERO_DET_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/OP/FLAGS_REG.NOT_LATE_UPDATE_GEN.INVALID_OP_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\,
      Q => p_3_in,
      R => \<const0>\
    );
\MULT.OP/OP/FLAGS_REG.NOT_LATE_UPDATE_GEN.OVERFLOW_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/OP/p_12_out\,
      Q => p_2_in,
      R => \<const0>\
    );
\MULT.OP/OP/FLAGS_REG.NOT_LATE_UPDATE_GEN.UNDERFLOW_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/OP/p_10_out\,
      Q => p_1_in,
      R => \<const0>\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/OP/exp_op6_out\(0),
      Q => p_0_in(23),
      R => \<const0>\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[1]_i_1\,
      Q => p_0_in(24),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[2]_i_1\,
      Q => p_0_in(25),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[3]_i_1\,
      Q => p_0_in(26),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[4]_i_1\,
      Q => p_0_in(27),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[5]_i_1\,
      Q => p_0_in(28),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[6]_i_1\,
      Q => p_0_in(29),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.exp_op_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.exp_op[7]_i_1\,
      Q => p_0_in(30),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(1)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(0),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(10),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(11),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(0),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(1),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(2),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(3),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(4),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(5),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(6),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(7),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(1),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(8),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(9),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(2),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(3),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(4),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(5),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(6),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(7),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(8),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/OP/p_5_out\(9),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(4),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\,
      Q => p_0_in(0),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\,
      Q => p_0_in(10),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\,
      Q => p_0_in(11),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\,
      Q => p_0_in(12),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\,
      Q => p_0_in(13),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\,
      Q => p_0_in(14),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\,
      Q => p_0_in(15),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\,
      Q => p_0_in(16),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\,
      Q => p_0_in(17),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\,
      Q => p_0_in(18),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\,
      Q => p_0_in(19),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\,
      Q => p_0_in(1),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\,
      Q => p_0_in(20),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\,
      Q => p_0_in(21),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/OP/p_5_out\(22),
      Q => p_0_in(22),
      R => \<const0>\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\,
      Q => p_0_in(2),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\,
      Q => p_0_in(3),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\,
      Q => p_0_in(4),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\,
      Q => p_0_in(5),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\,
      Q => p_0_in(6),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\,
      Q => p_0_in(7),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\,
      Q => p_0_in(8),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.mant_op_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\,
      Q => p_0_in(9),
      R => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(5)
    );
\MULT.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(6),
      I1 => SIGN,
      I2 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(7),
      O => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\
    );
\MULT.OP/OP/RESULT_REG.NORMAL.sign_op_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\,
      Q => p_0_in(31),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(0),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(0),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(0)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(1),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(1),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(1)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(2),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(2),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(2)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(3),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(3),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(3)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(4),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(4),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(4)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(5),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(5),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(5)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(6),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(6),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(6)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/CHAIN_GEN[7].Q_XOR.SUM_XOR_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(7),
      I1 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(7),
      O => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(7)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_11,
      CO(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX\,
      CYINIT => \MULT.OP/R_AND_R/LOGIC.R_AND_R/carry_op\,
      DI(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(3 downto 0),
      O(3 downto 0) => \MULT.OP/exp_rnd\(3 downto 0),
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(3 downto 0)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_11
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3 downto 2) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CYINIT => lopt_12,
      DI(3) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3),
      DI(2 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(6 downto 4),
      O(3 downto 0) => \MULT.OP/exp_rnd\(7 downto 4),
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/a_add_op\(7 downto 4)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_ADD.ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_12
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_INC_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_INC_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(0),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(1),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(2),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(3),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(4),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(5),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(6),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_IN_DEL/i_pipe/first_q\(7),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_op\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const1>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(0),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(1),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(2),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(3),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(4),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(5),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(6),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_IN_DELAY.EXP_OFF_OP_DEL/i_pipe/first_q\(7),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/exp_off_op\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const1>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_OFF_RND_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/EXP/EXP_PRE_RND_DEL/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/EXP_RND2_DELAY.EXP_RND_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CI\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[10].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/D\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/carry_rnd2\,
      R => GND_2
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CI\,
      CO(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CYINIT => lopt_5,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      O(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(4 downto 1)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_5
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      CYINIT => lopt_6,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      O(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(8 downto 5)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_6
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].C_MUX.CARRY_MUX\,
      CO(3 downto 2) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[10].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX\,
      CYINIT => lopt_7,
      DI(3) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3),
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/D\,
      O(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[11].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[10].Q_XOR.SUM_XOR\,
      O(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].Q_XOR.SUM_XOR\,
      S(3) => \<const0>\,
      S(2 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(11 downto 9)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_7
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/O\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[10].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[11].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(11),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[8].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CHAIN_GEN[9].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(0),
      Q => \MULT.OP/OP/p_5_out\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(10),
      Q => \MULT.OP/OP/p_5_out\(10),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(11),
      Q => \MULT.OP/OP/p_5_out\(11),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(1),
      Q => \MULT.OP/OP/p_5_out\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(2),
      Q => \MULT.OP/OP/p_5_out\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(3),
      Q => \MULT.OP/OP/p_5_out\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(4),
      Q => \MULT.OP/OP/p_5_out\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(5),
      Q => \MULT.OP/OP/p_5_out\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(6),
      Q => \MULT.OP/OP/p_5_out\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(7),
      Q => \MULT.OP/OP/p_5_out\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(8),
      Q => \MULT.OP/OP/p_5_out\(8),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/Q_DEL/i_pipe/first_q\(9),
      Q => \MULT.OP/OP/p_5_out\(9),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CI\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[10].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[9].C_MUX.CARRY_MUX\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.CARRYS_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(3 downto 0) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_CO_UNCONNECTED\(3 downto 0),
      CYINIT => lopt_14,
      DI(3 downto 0) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_DI_UNCONNECTED\(3 downto 0),
      O(3 downto 1) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_O_UNCONNECTED\(3 downto 1),
      O(0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/D\,
      S(3 downto 1) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_S_UNCONNECTED\(3 downto 1),
      S(0) => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_EXIT_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_14
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CARRYS_Q_DEL.FAST_DEL.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/D\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/carry_op\,
      R => GND_2
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_8,
      CO(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CO(0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CI\,
      CYINIT => \MULT.OP/R_AND_R/LOGIC.R_AND_R/carry_rnd2\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      O(0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/O\,
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(3 downto 0)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_8
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CYINIT => lopt_9,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      O(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(7 downto 4)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_9
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[10].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[9].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX\,
      CYINIT => lopt_10,
      DI(3) => \<const1>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[11].Q_XOR.SUM_XOR\,
      O(2) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[10].Q_XOR.SUM_XOR\,
      O(1) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[9].Q_XOR.SUM_XOR\,
      O(0) => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].Q_XOR.SUM_XOR\,
      S(3 downto 0) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/sum_rnd2\(11 downto 8)
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_10
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/O\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[10].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[11].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(11),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[8].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/CHAIN_GEN[9].Q_XOR.SUM_XOR\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(11),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(21),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(22),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(11),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(23),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(12),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(24),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(13),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(12),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(13),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(14),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(15),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(16),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(17),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(18),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(19),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(20),
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/MANT_RND2_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \MULT.OP/R_AND_R/normalize_local\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \MULT.OP/R_AND_R/LOGIC.R_AND_R/NORMALIZE_RND2_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_4,
      CO(3) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/CI\,
      CO(2) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/round_rnd1\,
      CO(1 downto 0) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(1 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const1>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND1/O\,
      O(2 downto 0) => \NLW_MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(2 downto 0),
      S(3) => \MULT.OP/R_AND_R/LOGIC.R_AND_R/mant_shifted_rnd1\(0),
      S(2) => \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\,
      S(1) => \<const0>\,
      S(0) => \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\
    );
\MULT.OP/R_AND_R/LOGIC.R_AND_R/RND_BIT_GEN/NORM_1_OR_0.STRUCT_REQ.GENERAL.RND1/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_4
    );
\RESULT_REG.NORMAL.exp_op[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => \MULT.OP/exp_rnd\(0),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(12),
      I2 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(13),
      O => \MULT.OP/OP/exp_op6_out\(0)
    );
\RESULT_REG.NORMAL.exp_op[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(1),
      O => \n_0_RESULT_REG.NORMAL.exp_op[1]_i_1\
    );
\RESULT_REG.NORMAL.exp_op[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(2),
      O => \n_0_RESULT_REG.NORMAL.exp_op[2]_i_1\
    );
\RESULT_REG.NORMAL.exp_op[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(3),
      O => \n_0_RESULT_REG.NORMAL.exp_op[3]_i_1\
    );
\RESULT_REG.NORMAL.exp_op[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(4),
      O => \n_0_RESULT_REG.NORMAL.exp_op[4]_i_1\
    );
\RESULT_REG.NORMAL.exp_op[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(5),
      O => \n_0_RESULT_REG.NORMAL.exp_op[5]_i_1\
    );
\RESULT_REG.NORMAL.exp_op[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(6),
      O => \n_0_RESULT_REG.NORMAL.exp_op[6]_i_1\
    );
\RESULT_REG.NORMAL.exp_op[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/exp_rnd\(7),
      O => \n_0_RESULT_REG.NORMAL.exp_op[7]_i_1\
    );
\RESULT_REG.NORMAL.mant_op[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => \MULT.OP/R_AND_R/LOGIC.R_AND_R/LOGIC.RND2/Q_DEL/i_pipe/first_q\(10),
      I1 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(2),
      I2 => \MULT.OP/EXP/STATE_DEC_DELAY/i_pipe/first_q\(3),
      O => \MULT.OP/OP/p_5_out\(22)
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
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      Q => \pipe[3]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[3]\,
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      Q => \pipe[5]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[6].pipe_reg[6][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[5]\,
      Q => \pipe[6]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[7].pipe_reg[7][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[6]\,
      Q => \pipe[7]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[8].pipe_reg[8][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[7]\,
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
      Q => m_axis_z_tdata_b(0),
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
      Q => m_axis_z_tdata_b(10),
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
      Q => m_axis_z_tdata_b(11),
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
      Q => m_axis_z_tdata_b(12),
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
      Q => m_axis_z_tdata_b(13),
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
      Q => m_axis_z_tdata_b(14),
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
      Q => m_axis_z_tdata_b(15),
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
      Q => m_axis_z_tdata_b(16),
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
      Q => m_axis_z_tdata_b(17),
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
      Q => m_axis_z_tdata_b(18),
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
      Q => m_axis_z_tdata_b(19),
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
      Q => m_axis_z_tdata_b(1),
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
      Q => m_axis_z_tdata_b(20),
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
      Q => m_axis_z_tdata_b(21),
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
      Q => m_axis_z_tdata_b(22),
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
      Q => m_axis_z_tdata_b(23),
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
      Q => m_axis_z_tdata_b(24),
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
      Q => m_axis_z_tdata_b(25),
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
      Q => m_axis_z_tdata_b(26),
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
      Q => m_axis_z_tdata_b(27),
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
      Q => m_axis_z_tdata_b(28),
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
      Q => m_axis_z_tdata_b(29),
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
      Q => m_axis_z_tdata_b(2),
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
      Q => m_axis_z_tdata_b(30),
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
      Q => m_axis_z_tdata_b(31),
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
      Q => m_axis_z_tdata_b(3),
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
      Q => m_axis_z_tdata_b(4),
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
      Q => m_axis_z_tdata_b(5),
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
      Q => m_axis_z_tdata_b(6),
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
      Q => m_axis_z_tdata_b(7),
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
      Q => m_axis_z_tdata_b(8),
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
      Q => m_axis_z_tdata_b(9),
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
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(0),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(10),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(11),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(12),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(13),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(14),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(15),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(16),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(1),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(2),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(3),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(4),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(5),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(6),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(7),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(8),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(9),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]_srl6\,
      Q => p_4_in(0),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][10]_srl6\,
      Q => p_4_in(10),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][11]_srl6\,
      Q => p_4_in(11),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][12]_srl6\,
      Q => p_4_in(12),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][13]_srl6\,
      Q => p_4_in(13),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][14]_srl6\,
      Q => p_4_in(14),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][15]_srl6\,
      Q => p_4_in(15),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][16]_srl6\,
      Q => p_4_in(16),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]_srl6\,
      Q => p_4_in(1),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][2]_srl6\,
      Q => p_4_in(2),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][3]_srl6\,
      Q => p_4_in(3),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][4]_srl6\,
      Q => p_4_in(4),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][5]_srl6\,
      Q => p_4_in(5),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][6]_srl6\,
      Q => p_4_in(6),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][7]_srl6\,
      Q => p_4_in(7),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][8]_srl6\,
      Q => p_4_in(8),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][9]_srl6\,
      Q => p_4_in(9),
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
\opt_has_pipe.first_q[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      O => \MULT.OP/R_AND_R/normalize_local\
    );
\opt_has_pipe.first_q[0]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F1F1F1F0F1F0F1F0"
    )
    port map (
      I0 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      I1 => \MULT.OP/EXP/state\(1),
      I2 => \MULT.OP/EXP/state\(0),
      I3 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      I4 => \MULT.OP/EXP/p_0_in2_in\,
      I5 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__1\
    );
\opt_has_pipe.first_q[0]_i_1__10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => m_axis_z_tdata_b(24),
      I1 => m_axis_z_tdata_b(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__2\,
      O => \MULT.OP/EXP/COND_DET_B/exp_all_zero_ip\
    );
\opt_has_pipe.first_q[0]_i_1__11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => m_axis_z_tdata_b(24),
      I1 => m_axis_z_tdata_b(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__3\,
      O => \MULT.OP/EXP/COND_DET_B/exp_all_one_ip\
    );
\opt_has_pipe.first_q[0]_i_1__12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111000011111000"
    )
    port map (
      I0 => \MULT.OP/EXP/state\(0),
      I1 => \MULT.OP/EXP/state\(1),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I3 => \MULT.OP/EXP/p_0_in2_in\,
      I4 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      I5 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      O => \MULT.OP/EXP/flow_int_up\(0)
    );
\opt_has_pipe.first_q[0]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"34"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      I2 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__2\
    );
\opt_has_pipe.first_q[0]_i_1__3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \MULT.OP/EXP/PROD_DELAY/i_pipe/first_q\,
      I1 => \n_0_opt_has_pipe.first_q[0]_i_2\,
      O => \MULT.OP/EXP/sign_det\
    );
\opt_has_pipe.first_q[0]_i_1__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EC0CA0000000A000"
    )
    port map (
      I0 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I1 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I2 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \MULT.OP/EXP/a_mant_is_zero_int\,
      I4 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I5 => \MULT.OP/EXP/b_mant_is_zero_int\,
      O => \MULT.OP/EXP/invalid_op_det\
    );
\opt_has_pipe.first_q[0]_i_1__5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => m_axis_z_tdata_b(31),
      I1 => p_4_out(31),
      O => \MULT.OP/EXP/prod_sign_ip\
    );
\opt_has_pipe.first_q[0]_i_1__6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      O => \MULT.OP/EXP/state_det\(0)
    );
\opt_has_pipe.first_q[0]_i_1__7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A888888888888888"
    )
    port map (
      I0 => \MULT.OP/EXP/p_1_in4_in\,
      I1 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(7),
      I2 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(0),
      I3 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(1),
      I4 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(6),
      I5 => \n_0_opt_has_pipe.first_q[2]_i_2\,
      O => \MULT.OP/EXP/flow_sig\(0)
    );
\opt_has_pipe.first_q[0]_i_1__8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => p_4_out(24),
      I1 => p_4_out(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__0\,
      O => \MULT.OP/EXP/COND_DET_A/exp_all_zero_ip\
    );
\opt_has_pipe.first_q[0]_i_1__9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => p_4_out(24),
      I1 => p_4_out(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__1\,
      O => \MULT.OP/EXP/COND_DET_A/exp_all_one_ip\
    );
\opt_has_pipe.first_q[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"13035F0F00005F0F"
    )
    port map (
      I0 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I1 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I2 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \MULT.OP/EXP/a_mant_is_zero_int\,
      I4 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I5 => \MULT.OP/EXP/b_mant_is_zero_int\,
      O => \n_0_opt_has_pipe.first_q[0]_i_2\
    );
\opt_has_pipe.first_q[0]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(26),
      I1 => p_4_out(25),
      I2 => p_4_out(29),
      I3 => p_4_out(30),
      I4 => p_4_out(27),
      I5 => p_4_out(28),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__0\
    );
\opt_has_pipe.first_q[0]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => p_4_out(26),
      I1 => p_4_out(25),
      I2 => p_4_out(29),
      I3 => p_4_out(30),
      I4 => p_4_out(27),
      I5 => p_4_out(28),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__1\
    );
\opt_has_pipe.first_q[0]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(26),
      I1 => m_axis_z_tdata_b(25),
      I2 => m_axis_z_tdata_b(29),
      I3 => m_axis_z_tdata_b(30),
      I4 => m_axis_z_tdata_b(27),
      I5 => m_axis_z_tdata_b(28),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__2\
    );
\opt_has_pipe.first_q[0]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => m_axis_z_tdata_b(26),
      I1 => m_axis_z_tdata_b(25),
      I2 => m_axis_z_tdata_b(29),
      I3 => m_axis_z_tdata_b(30),
      I4 => m_axis_z_tdata_b(27),
      I5 => m_axis_z_tdata_b(28),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__3\
    );
\opt_has_pipe.first_q[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      I2 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[10]_i_1\
    );
\opt_has_pipe.first_q[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      I2 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[11]_i_1\
    );
\opt_has_pipe.first_q[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[12]_i_1\
    );
\opt_has_pipe.first_q[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"001C"
    )
    port map (
      I0 => \MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/first_q\,
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      I2 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      I3 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[13]_i_1\
    );
\opt_has_pipe.first_q[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBBBABABBBA"
    )
    port map (
      I0 => \MULT.OP/EXP/state\(1),
      I1 => \MULT.OP/EXP/state\(0),
      I2 => \n_0_opt_has_pipe.first_q[1]_i_2\,
      I3 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\,
      I4 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I5 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      O => \n_0_opt_has_pipe.first_q[1]_i_1\
    );
\opt_has_pipe.first_q[1]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      I2 => \MULT.OP/EXP/FLOW_DEC_DEL/i_pipe/first_q\,
      I3 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__0\
    );
\opt_has_pipe.first_q[1]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"05050D0D5505D808"
    )
    port map (
      I0 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \MULT.OP/EXP/a_mant_is_zero_int\,
      I2 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \MULT.OP/EXP/b_mant_is_zero_int\,
      I4 => \MULT.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I5 => \MULT.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \MULT.OP/EXP/state_det\(1)
    );
\opt_has_pipe.first_q[1]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(7),
      I1 => \MULT.OP/EXP/p_1_in4_in\,
      O => \MULT.OP/EXP/flow_sig\(1)
    );
\opt_has_pipe.first_q[1]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => \MULT.OP/EXP/state\(0),
      I1 => \MULT.OP/EXP/state\(1),
      I2 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      O => \MULT.OP/EXP/flow_int_up\(1)
    );
\opt_has_pipe.first_q[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      I1 => \MULT.OP/EXP/p_0_in2_in\,
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      O => \n_0_opt_has_pipe.first_q[1]_i_2\
    );
\opt_has_pipe.first_q[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(0),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      I2 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[2]_i_1\
    );
\opt_has_pipe.first_q[2]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020000000000000"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[2]_i_2\,
      I1 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(0),
      I2 => \MULT.OP/EXP/p_1_in4_in\,
      I3 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(7),
      I4 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(1),
      I5 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(6),
      O => \MULT.OP/EXP/flow_sig\(2)
    );
\opt_has_pipe.first_q[2]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1110111100000000"
    )
    port map (
      I0 => \MULT.OP/EXP/state\(0),
      I1 => \MULT.OP/EXP/state\(1),
      I2 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      I3 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      I4 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I5 => \MULT.OP/EXP/p_0_in2_in\,
      O => \MULT.OP/EXP/flow_int_up\(2)
    );
\opt_has_pipe.first_q[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(3),
      I1 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(2),
      I2 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(5),
      I3 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[2]_i_2\
    );
\opt_has_pipe.first_q[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(1),
      I1 => \MULT.OP/EXP/STATE_UP_DELAY/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[3]_i_1\
    );
\opt_has_pipe.first_q[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => \MULT.OP/EXP/p_1_in4_in\,
      I1 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(7),
      I2 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(0),
      I3 => \n_0_opt_has_pipe.first_q[3]_i_2\,
      O => \MULT.OP/EXP/flow_sig\(3)
    );
\opt_has_pipe.first_q[3]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111110100000000"
    )
    port map (
      I0 => \MULT.OP/EXP/state\(0),
      I1 => \MULT.OP/EXP/state\(1),
      I2 => \MULT.OP/MULT/MULT_GEN_VARIANT.FIX_MULT/OP_REG.MANT_DEL/i_pipe/first_q\(25),
      I3 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      I4 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\,
      I5 => \n_0_MULT.OP/EXP/SIG_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]\,
      O => \MULT.OP/EXP/flow_int_up\(3)
    );
\opt_has_pipe.first_q[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(1),
      I1 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(2),
      I2 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(4),
      I3 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(3),
      I4 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(6),
      I5 => \MULT.OP/EXP/EXP_ADD.C_CHAIN/Q_DEL/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[3]_i_2\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ is
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
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 18 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is "floating_point_v7_0";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 11;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 2;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 2;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is 19;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ : entity is "yes";
end \ip_fp32_axis_multfloating_point_v7_0__parameterized0\;

architecture STRUCTURE of \ip_fp32_axis_multfloating_point_v7_0__parameterized0\ is
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
  attribute C_COMPARE_OPERATION of i_synth : label is 8;
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
  attribute C_HAS_COMPARE of i_synth : label is 0;
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
  attribute C_HAS_INVALID_OP of i_synth : label is 1;
  attribute C_HAS_LOGARITHM of i_synth : label is 0;
  attribute C_HAS_MULTIPLY of i_synth : label is 1;
  attribute C_HAS_OPERATION of i_synth : label is 0;
  attribute C_HAS_OPERATION_TLAST of i_synth : label is 0;
  attribute C_HAS_OPERATION_TUSER of i_synth : label is 0;
  attribute C_HAS_OVERFLOW of i_synth : label is 1;
  attribute C_HAS_RECIP of i_synth : label is 0;
  attribute C_HAS_RECIP_SQRT of i_synth : label is 0;
  attribute C_HAS_RESULT_TLAST of i_synth : label is 1;
  attribute C_HAS_RESULT_TUSER of i_synth : label is 1;
  attribute C_HAS_SQRT of i_synth : label is 0;
  attribute C_HAS_SUBTRACT of i_synth : label is 0;
  attribute C_HAS_UNDERFLOW of i_synth : label is 1;
  attribute C_LATENCY of i_synth : label is 11;
  attribute C_MULT_USAGE of i_synth : label is 2;
  attribute C_OPERATION_TDATA_WIDTH of i_synth : label is 8;
  attribute C_OPERATION_TUSER_WIDTH of i_synth : label is 1;
  attribute C_OPTIMIZATION of i_synth : label is 1;
  attribute C_RATE of i_synth : label is 1;
  attribute C_RESULT_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_RESULT_TDATA_WIDTH of i_synth : label is 32;
  attribute C_RESULT_TUSER_WIDTH of i_synth : label is 19;
  attribute C_RESULT_WIDTH of i_synth : label is 32;
  attribute C_THROTTLE_SCHEME of i_synth : label is 2;
  attribute C_TLAST_RESOLUTION of i_synth : label is 1;
  attribute C_XDEVICEFAMILY of i_synth : label is "kintex7";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.\ip_fp32_axis_multfloating_point_v7_0_viv__parameterized0\
    port map (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      m_axis_result_tdata(31 downto 0) => m_axis_result_tdata(31 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      m_axis_result_tuser(18 downto 0) => m_axis_result_tuser(18 downto 0),
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
entity ip_fp32_axis_mult is
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
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 18 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_fp32_axis_mult : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_mult : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ip_fp32_axis_mult : entity is "floating_point_v7_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_fp32_axis_mult : entity is "ip_fp32_axis_mult,floating_point_v7_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of ip_fp32_axis_mult : entity is "ip_fp32_axis_mult,floating_point_v7_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=floating_point,x_ipVersion=7.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_XDEVICEFAMILY=kintex7,C_HAS_ADD=0,C_HAS_SUBTRACT=0,C_HAS_MULTIPLY=1,C_HAS_DIVIDE=0,C_HAS_SQRT=0,C_HAS_COMPARE=0,C_HAS_FIX_TO_FLT=0,C_HAS_FLT_TO_FIX=0,C_HAS_FLT_TO_FLT=0,C_HAS_RECIP=0,C_HAS_RECIP_SQRT=0,C_HAS_ABSOLUTE=0,C_HAS_LOGARITHM=0,C_HAS_EXPONENTIAL=0,C_HAS_FMA=0,C_HAS_FMS=0,C_HAS_ACCUMULATOR_A=0,C_HAS_ACCUMULATOR_S=0,C_A_WIDTH=32,C_A_FRACTION_WIDTH=24,C_B_WIDTH=32,C_B_FRACTION_WIDTH=24,C_C_WIDTH=32,C_C_FRACTION_WIDTH=24,C_RESULT_WIDTH=32,C_RESULT_FRACTION_WIDTH=24,C_COMPARE_OPERATION=8,C_LATENCY=11,C_OPTIMIZATION=1,C_MULT_USAGE=2,C_BRAM_USAGE=0,C_RATE=1,C_ACCUM_INPUT_MSB=32,C_ACCUM_MSB=32,C_ACCUM_LSB=-31,C_HAS_UNDERFLOW=1,C_HAS_OVERFLOW=1,C_HAS_INVALID_OP=1,C_HAS_DIVIDE_BY_ZERO=0,C_HAS_ACCUM_OVERFLOW=0,C_HAS_ACCUM_INPUT_OVERFLOW=0,C_HAS_ACLKEN=0,C_HAS_ARESETN=1,C_THROTTLE_SCHEME=2,C_HAS_A_TUSER=1,C_HAS_A_TLAST=1,C_HAS_B=1,C_HAS_B_TUSER=1,C_HAS_B_TLAST=1,C_HAS_C=0,C_HAS_C_TUSER=0,C_HAS_C_TLAST=0,C_HAS_OPERATION=0,C_HAS_OPERATION_TUSER=0,C_HAS_OPERATION_TLAST=0,C_HAS_RESULT_TUSER=1,C_HAS_RESULT_TLAST=1,C_TLAST_RESOLUTION=1,C_A_TDATA_WIDTH=32,C_A_TUSER_WIDTH=8,C_B_TDATA_WIDTH=32,C_B_TUSER_WIDTH=8,C_C_TDATA_WIDTH=32,C_C_TUSER_WIDTH=1,C_OPERATION_TDATA_WIDTH=8,C_OPERATION_TUSER_WIDTH=1,C_RESULT_TDATA_WIDTH=32,C_RESULT_TUSER_WIDTH=19}";
end ip_fp32_axis_mult;

architecture STRUCTURE of ip_fp32_axis_mult is
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
  attribute C_COMPARE_OPERATION of U0 : label is 8;
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
  attribute C_HAS_COMPARE of U0 : label is 0;
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
  attribute C_HAS_INVALID_OP of U0 : label is 1;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of U0 : label is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of U0 : label is 1;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of U0 : label is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of U0 : label is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of U0 : label is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of U0 : label is 1;
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
  attribute C_HAS_UNDERFLOW of U0 : label is 1;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of U0 : label is 11;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of U0 : label is 2;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of U0 : label is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of U0 : label is 1;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of U0 : label is 1;
  attribute C_RATE : integer;
  attribute C_RATE of U0 : label is 1;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of U0 : label is 24;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of U0 : label is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of U0 : label is 19;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of U0 : label is 32;
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
U0: entity work.\ip_fp32_axis_multfloating_point_v7_0__parameterized0\
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      aresetn => aresetn,
      m_axis_result_tdata(31 downto 0) => m_axis_result_tdata(31 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      m_axis_result_tuser(18 downto 0) => m_axis_result_tuser(18 downto 0),
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
