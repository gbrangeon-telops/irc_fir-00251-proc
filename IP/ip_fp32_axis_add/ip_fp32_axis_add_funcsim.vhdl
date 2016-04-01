-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Wed Mar 30 11:50:25 2016
-- Host        : TELOPS230 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim D:/telops/FIR-00251-Proc/IP/ip_fp32_axis_add/ip_fp32_axis_add_funcsim.vhdl
-- Design      : ip_fp32_axis_add
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_fp32_axis_addglb_ifx_master is
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
  attribute WIDTH of ip_fp32_axis_addglb_ifx_master : entity is 52;
  attribute DEPTH : integer;
  attribute DEPTH of ip_fp32_axis_addglb_ifx_master : entity is 16;
  attribute AFULL_THRESH1 : integer;
  attribute AFULL_THRESH1 of ip_fp32_axis_addglb_ifx_master : entity is 1;
  attribute AFULL_THRESH0 : integer;
  attribute AFULL_THRESH0 of ip_fp32_axis_addglb_ifx_master : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_addglb_ifx_master : entity is "yes";
end ip_fp32_axis_addglb_ifx_master;

architecture STRUCTURE of ip_fp32_axis_addglb_ifx_master is
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
entity \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ is
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
  attribute ORIG_REF_NAME of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is "floating_point_v7_0_viv";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 14;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 2;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 2;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is 19;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ : entity is "yes";
end \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\;

architecture STRUCTURE of \ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 22 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 22 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/CIN_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_ADD_IP_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_LRG_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.CARRY_MUX/D\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_LZD_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\ : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/cin_align\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/not_zero_largest_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_0_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_10_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_1_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_2_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_3_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_4_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_5_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_6_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_7_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_8_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_9_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/subtract_add_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/sum_pad_fab\ : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_add_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_lrg_add_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_align\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_lod\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_lod\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/CI\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/D\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/LEAD16_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 26 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O0_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O1_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O2_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O3_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O4_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O55_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O7_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in10_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in16_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in4_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S21_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S24_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S27_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S30_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S33_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S36_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S39_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\ : STD_LOGIC_VECTOR ( 26 downto 11 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LSB_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_BIT_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_UP_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/lsb_lod\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/lsb_shift\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_norm\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_rnd_ip\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_bit_shift\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_lod\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_shift\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/zero_lod\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/zero_up_norm\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_SIGN_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_SIGN_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_SIGN_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_SIGN_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_ZERO_SIGN_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_ZERO_SIGN_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/exp_all_one_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/exp_all_zero_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/exp_all_one_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/exp_all_zero_ip\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NORM_SIGN_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NORM_SIGN_DEL/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[0].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[0].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[10].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[10].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[11].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[11].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[12].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[12].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[13].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[13].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[14].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[14].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[1].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[1].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[2].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[2].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[3].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[3].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[4].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[4].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[5].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[5].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[6].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[6].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[7].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[7].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[8].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[8].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[9].di_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[9].lut_op_reg\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/D\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SIGN_SIG_UP_DELAY/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SIGN_SIG_UP_DELAY/i_pipe/first_q\ : signal is "true";
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SUB_DELAY/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_and_b_inf_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_and_b_inf_sign_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_mant_is_zero\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_inf_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_inf_sign_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_nan_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_zero_sign_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_sign_xor_b_sign_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/b_mant_is_zero\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_invalid_op\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_sign\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_sign_del\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/norm_sign_mux\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/p_0_in1_in\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/sign_sig_up\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/subtract_int\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/FLAGS_REG.IV_OP_REG/i_pipe/first_q\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\ : STD_LOGIC_VECTOR ( 21 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_6_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_8_out\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\ : STD_LOGIC_VECTOR ( 26 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/cancellation\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\ : STD_LOGIC;
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/round_mant\ : STD_LOGIC_VECTOR ( 22 to 22 );
  signal \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/zero_largest\ : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal combiner_data_valid : STD_LOGIC;
  signal \i_nd_to_rdy/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \i_nd_to_rdy/first_q\ : signal is "true";
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal lopt_10 : STD_LOGIC;
  signal lopt_11 : STD_LOGIC;
  signal lopt_12 : STD_LOGIC;
  signal lopt_2 : STD_LOGIC;
  signal lopt_3 : STD_LOGIC;
  signal lopt_4 : STD_LOGIC;
  signal lopt_5 : STD_LOGIC;
  signal lopt_6 : STD_LOGIC;
  signal lopt_7 : STD_LOGIC;
  signal lopt_8 : STD_LOGIC;
  signal lopt_9 : STD_LOGIC;
  signal \^m_axis_result_tvalid\ : STD_LOGIC;
  signal m_axis_z_tdata_b : STD_LOGIC_VECTOR ( 30 downto 0 );
  signal minusOp : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[1].CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[2].CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[5].CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[6].CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[5].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[6].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[11].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[0]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[1]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[2]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[3]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[4]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[5]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[6]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[7]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\ : STD_LOGIC;
  signal \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_2\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_HAS_ARESETN.sclr_i_i_1\ : STD_LOGIC;
  signal \n_0_RESULT_REG.NORMAL.mant_op[22]_i_1\ : STD_LOGIC;
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
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\ : STD_LOGIC;
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[7].pipe_reg[7][0]\ : STD_LOGIC;
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[8].pipe_reg[8][0]\ : STD_LOGIC;
  signal \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__11\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__19\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__21\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__24\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__31\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__5\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__6\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_3__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[10]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[10]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[11]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[11]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[12]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[12]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[13]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[13]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[14]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[14]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[15]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[15]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[16]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[16]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[17]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[17]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[18]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[18]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[19]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[19]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__6\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[20]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[20]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[21]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[21]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[22]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[22]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[23]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__6\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_2__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_2__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_3__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_4__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_5\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_5__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_2__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_3__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_4__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_5\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_5__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[8]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[8]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q_reg[3]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q_reg[7]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_104_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_105_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_106_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_106_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_107_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_107_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_108_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_108_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_109_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_109_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_10_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_10_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_110_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_110_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_111_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_111_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_112_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_112_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_113_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_113_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_114_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_114_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_115_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_115_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_116_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_116_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_117_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_117_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_118_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_118_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_119_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_119_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_11_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_11_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_120_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_120_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_121_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_121_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_122_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_122_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_123_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_123_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_124_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_124_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_125_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_125_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_126_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_126_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_127_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_127_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_128_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_128_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_129_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_129_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_12_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_12_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_130_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_130_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_131_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_131_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_132_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_132_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_133_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_133_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_134_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_134_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_135_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_135_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_136_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_136_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_137_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_137_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_138_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_138_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_139_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_139_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_13_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_13_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_140_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_140_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_141_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_141_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_142_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_142_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_143_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_143_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_144_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_144_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_145_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_145_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_146_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_146_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_147_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_147_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_148_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_148_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_149_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_149_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_14_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_14_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_150_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_150_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_151_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_151_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_152_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_152_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_153_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_153_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_15_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_15_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_16_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_16_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_17_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_17_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_18_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_18_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_19_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_19_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_1_opt_has_pipe.first_q_reg[3]_i_1\ : STD_LOGIC;
  signal \n_1_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_1_opt_has_pipe.first_q_reg[7]_i_1\ : STD_LOGIC;
  signal \n_1_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_20_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_20_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_21_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_21_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_22_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_22_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_23_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_23_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_24_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_24_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_25_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_25_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_26_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_26_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_27_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_27_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_28_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_28_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_29_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_29_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_2_opt_has_pipe.first_q_reg[3]_i_1\ : STD_LOGIC;
  signal \n_2_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_2_opt_has_pipe.first_q_reg[7]_i_1\ : STD_LOGIC;
  signal \n_2_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_30_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_30_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_31_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_31_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_32_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_32_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_33_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_33_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_34_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_34_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_35_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_35_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_36_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_36_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_37_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_37_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_38_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_38_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_39_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_39_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_3_opt_has_pipe.first_q_reg[3]_i_1\ : STD_LOGIC;
  signal \n_3_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_3_opt_has_pipe.first_q_reg[7]_i_1\ : STD_LOGIC;
  signal \n_3_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_3_opt_has_pipe.first_q_reg[9]_i_1\ : STD_LOGIC;
  signal \n_40_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_40_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_41_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_41_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_42_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_42_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_43_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_43_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_44_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_44_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_45_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_45_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_46_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_46_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_47_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_47_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_48_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_48_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_49_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_49_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_4_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_4_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_4_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_50_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_50_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_51_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_51_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_52_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_52_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_53_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_53_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_54_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_54_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_55_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_55_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_56_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_56_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_57_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_57_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_5_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_5_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_6_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_6_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_6_opt_has_pipe.first_q_reg[3]_i_1__0\ : STD_LOGIC;
  signal \n_6_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_6_opt_has_pipe.first_q_reg[9]_i_1\ : STD_LOGIC;
  signal \n_79_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_7_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_7_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_7_opt_has_pipe.first_q_reg[7]_i_1__0\ : STD_LOGIC;
  signal \n_7_opt_has_pipe.first_q_reg[9]_i_1\ : STD_LOGIC;
  signal \n_80_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_8_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_8_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
  signal \n_9_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : STD_LOGIC;
  signal \n_9_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : STD_LOGIC;
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
  signal p_4_in : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal p_4_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \pipe[10]\ : STD_LOGIC;
  signal \pipe[4]\ : STD_LOGIC;
  signal \pipe[5]\ : STD_LOGIC;
  signal \pipe[6]\ : STD_LOGIC;
  signal \pipe[9]\ : STD_LOGIC;
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
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_P_UNCONNECTED\ : STD_LOGIC_VECTOR ( 47 downto 40 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_P_UNCONNECTED\ : STD_LOGIC_VECTOR ( 47 downto 35 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_afull_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_full_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_afull_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_not_full_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_HAS_OUTPUT_FIFO.i_output_fifo_add_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_opt_has_pipe.first_q_reg[3]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_opt_has_pipe.first_q_reg[3]_i_1__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_opt_has_pipe.first_q_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_opt_has_pipe.first_q_reg[8]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_opt_has_pipe.first_q_reg[9]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_opt_has_pipe.first_q_reg[9]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute box_type : string;
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\ : label is "PRIMITIVE";
  attribute keep : string;
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[23]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[23]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.CARRY_MUX/CHAIN_GEN[0].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.CARRY_MUX/CHAIN_GEN[0].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[1].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[1].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[2].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[2].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[5].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[5].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[6].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[6].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[7].REG.CARRY_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[7].REG.CARRY_FD\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[0].LSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[0].MSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[1].LSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[1].MSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[2].LSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[2].MSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[3].LSB\ : label is "PRIMITIVE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[3].MSB\ : label is "PRIMITIVE";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\ : label is "PRIMITIVE";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_ZERO_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6] ";
  attribute srl_name : string;
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5 ";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\ : label is "yes";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3 ";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4\ : label is "PRIMITIVE";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7 ";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NORM_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[2]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[3]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[15].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[15].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SIGN_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5 ";
  attribute srl_bus_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6] ";
  attribute srl_name of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5\ : label is "U0/i_synth/\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5 ";
  attribute use_sync_reset : string;
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[0]\ : label is "auto";
  attribute use_sync_set : string;
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[0]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[1]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[1]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[2]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[2]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[3]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[3]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[4]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[4]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[5]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[5]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[6]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[6]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[7]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[7]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[0]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[0]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[10]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[10]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[11]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[11]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[12]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[12]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[13]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[13]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[14]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[14]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[15]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[15]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[16]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[16]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[17]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[17]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[18]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[18]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[19]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[19]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[1]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[1]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[20]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[20]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[21]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[21]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[22]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[22]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[2]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[2]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[3]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[3]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[4]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[4]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[5]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[5]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[6]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[6]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[7]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[7]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[8]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[8]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[9]\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[9]\ : label is "auto";
  attribute use_sync_reset of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_reg\ : label is "auto";
  attribute use_sync_set of \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_reg\ : label is "auto";
  attribute AFULL_THRESH0 : integer;
  attribute AFULL_THRESH0 of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 1;
  attribute AFULL_THRESH1 : integer;
  attribute AFULL_THRESH1 of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 1;
  attribute DEPTH : integer;
  attribute DEPTH of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 16;
  attribute WIDTH : integer;
  attribute WIDTH of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is 52;
  attribute downgradeipidentifiedwarnings of \HAS_OUTPUT_FIFO.i_output_fifo\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[0]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[10]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[11]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[12]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[13]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[14]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[15]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[16]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[17]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[18]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[19]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[1]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[20]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[21]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[22]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[23]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[24]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[25]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[26]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[27]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[28]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[29]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[2]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[30]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[31]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[3]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[4]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[5]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[6]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[7]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[8]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[9]_i_1\ : label is "soft_lutpair13";
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
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[3]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[4]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[5]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[6]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[7]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tdata[9]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[0]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[1]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[2]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[3]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[4]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[5]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[6]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_tuser[7]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_b_valid_i_2\ : label is "soft_lutpair51";
  attribute keep of \i_nd_to_rdy/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9 ";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__33\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__34\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__35\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__36\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_1__37\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[11]_i_1__2\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[12]_i_1__2\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[13]_i_1__2\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[14]_i_1__2\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[15]_i_1__2\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[16]_i_1__1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[17]_i_1__1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[18]_i_1__1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[19]_i_1__1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[1]_i_1__3\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[20]_i_1__1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[21]_i_1__1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[22]_i_1__1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[23]_i_1__0\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[24]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[25]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[26]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[2]_i_1__2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[2]_i_1__6\ : label is "soft_lutpair4";
begin
  m_axis_result_tvalid <= \^m_axis_result_tvalid\;
  s_axis_a_tready <= \^s_axis_a_tready\;
  s_axis_b_tready <= \^s_axis_b_tready\;
  s_axis_c_tready <= \<const1>\;
  s_axis_operation_tready <= \<const1>\;
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(10),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(11),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(12),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(13),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(14),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(15),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(16),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(16),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(17),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(17),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(18),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(18),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(19),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(19),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(20),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(20),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(21),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(21),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(22),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(22),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(10),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(11),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(12),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(13),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(14),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(15),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(16),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(16),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(17),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(17),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(18),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(18),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(19),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(19),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(20),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(20),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(21),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(21),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(22),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(22),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/CIN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/cin_align\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/CIN_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 1,
      ADREG => 0,
      ALUMODEREG => 1,
      AREG => 1,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 1,
      CARRYINSELREG => 1,
      CREG => 1,
      DREG => 0,
      INMODEREG => 0,
      IS_ALUMODE_INVERTED => B"0000",
      IS_CARRYIN_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_INMODE_INVERTED => B"00000",
      IS_OPMODE_INVERTED => B"0000000",
      MASK => X"FF0000FFFFFF",
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
      A(23 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(23 downto 0),
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
      ACOUT(29) => \n_24_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(28) => \n_25_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(27) => \n_26_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(26) => \n_27_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(25) => \n_28_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(24) => \n_29_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(23) => \n_30_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(22) => \n_31_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(21) => \n_32_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(20) => \n_33_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(19) => \n_34_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(18) => \n_35_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(17) => \n_36_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(16) => \n_37_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(15) => \n_38_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(14) => \n_39_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(13) => \n_40_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(12) => \n_41_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(11) => \n_42_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(10) => \n_43_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(9) => \n_44_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(8) => \n_45_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(7) => \n_46_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(6) => \n_47_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(5) => \n_48_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(4) => \n_49_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(3) => \n_50_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(2) => \n_51_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(1) => \n_52_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ACOUT(0) => \n_53_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      ALUMODE(3) => \<const0>\,
      ALUMODE(2) => \<const0>\,
      ALUMODE(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/subtract_add_ip\,
      ALUMODE(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/subtract_add_ip\,
      B(17) => \<const0>\,
      B(16) => \<const0>\,
      B(15 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(15 downto 0),
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
      BCOUT(17) => \n_6_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(16) => \n_7_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(15) => \n_8_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(14) => \n_9_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(13) => \n_10_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(12) => \n_11_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(11) => \n_12_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(10) => \n_13_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(9) => \n_14_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(8) => \n_15_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(7) => \n_16_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(6) => \n_17_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(5) => \n_18_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(4) => \n_19_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(3) => \n_20_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(2) => \n_21_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(1) => \n_22_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      BCOUT(0) => \n_23_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      C(47) => \<const0>\,
      C(46) => \<const0>\,
      C(45) => \<const0>\,
      C(44) => \<const0>\,
      C(43) => \<const0>\,
      C(42) => \<const0>\,
      C(41) => \<const0>\,
      C(40) => \<const0>\,
      C(39) => \<const0>\,
      C(38 downto 15) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(23 downto 0),
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
      CARRYCASCOUT => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      CARRYIN => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/CIN_DELAY/i_pipe/first_q\,
      CARRYINSEL(2) => \<const0>\,
      CARRYINSEL(1) => \<const0>\,
      CARRYINSEL(0) => \<const0>\,
      CARRYOUT(3) => \n_54_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      CARRYOUT(2) => \n_55_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      CARRYOUT(1) => \n_56_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      CARRYOUT(0) => \n_57_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      CEA1 => \<const0>\,
      CEA2 => \<const1>\,
      CEAD => \<const0>\,
      CEALUMODE => \<const1>\,
      CEB1 => \<const0>\,
      CEB2 => \<const1>\,
      CEC => \<const1>\,
      CECARRYIN => \<const1>\,
      CECTRL => \<const1>\,
      CED => \<const0>\,
      CEINMODE => \<const0>\,
      CEM => \<const1>\,
      CEP => \<const1>\,
      CLK => aclk,
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
      MULTSIGNOUT => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6) => \<const0>\,
      OPMODE(5) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_lrg_add_ip\,
      OPMODE(4) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_lrg_add_ip\,
      OPMODE(3) => \<const0>\,
      OPMODE(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_add_ip\,
      OPMODE(1) => \<const0>\,
      OPMODE(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_add_ip\,
      OVERFLOW => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_OVERFLOW_UNCONNECTED\,
      P(47 downto 40) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_P_UNCONNECTED\(47 downto 40),
      P(39 downto 13) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(26 downto 0),
      P(12) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/sum_pad_fab\(12),
      P(11) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_10_in\,
      P(10) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_9_in\,
      P(9) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_8_in\,
      P(8) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_7_in\,
      P(7) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_6_in\,
      P(6) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_5_in\,
      P(5) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_4_in\,
      P(4) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_3_in\,
      P(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_2_in\,
      P(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_1_in\,
      P(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_0_in\,
      P(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/sum_pad_fab\(0),
      PATTERNBDETECT => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
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
      PCOUT(47) => \n_106_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(46) => \n_107_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(45) => \n_108_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(44) => \n_109_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(43) => \n_110_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(42) => \n_111_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(41) => \n_112_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(40) => \n_113_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(39) => \n_114_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(38) => \n_115_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(37) => \n_116_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(36) => \n_117_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(35) => \n_118_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(34) => \n_119_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(33) => \n_120_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(32) => \n_121_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(31) => \n_122_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(30) => \n_123_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(29) => \n_124_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(28) => \n_125_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(27) => \n_126_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(26) => \n_127_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(25) => \n_128_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(24) => \n_129_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(23) => \n_130_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(22) => \n_131_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(21) => \n_132_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(20) => \n_133_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(19) => \n_134_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(18) => \n_135_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(17) => \n_136_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(16) => \n_137_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(15) => \n_138_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(14) => \n_139_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(13) => \n_140_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(12) => \n_141_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(11) => \n_142_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(10) => \n_143_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(9) => \n_144_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(8) => \n_145_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(7) => \n_146_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(6) => \n_147_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(5) => \n_148_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(4) => \n_149_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(3) => \n_150_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(2) => \n_151_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(1) => \n_152_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
      PCOUT(0) => \n_153_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP\,
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
      UNDERFLOW => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/DSP2/DSP_UNDERFLOW_UNCONNECTED\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__19\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[10]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[11]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[12]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[13]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[14]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[15]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[16]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(16),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[17]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(17),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[18]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(18),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[19]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(19),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__2\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[20]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(20),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[21]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(21),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[22]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(22),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const1>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(23),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[4]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[6]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[7]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[8]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[9]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(10),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(11),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(12),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(13),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(14),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(15),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(16),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(16),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(17),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(17),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(18),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(18),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(19),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(19),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(20),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(20),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(21),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(21),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(22),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(22),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(23),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(23),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/LRG_DELAY/i_pipe/first_q\(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/a\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(10),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(11),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(12),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(13),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(14),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(15),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__11\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[10]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(10),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[11]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(11),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[12]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(12),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[13]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(13),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[14]_i_1__1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(14),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[15]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(15),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[16]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(16),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[17]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(17),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[18]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(18),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[19]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(19),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[1]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[20]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(20),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[21]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(21),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[22]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(22),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[23]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(23),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[3]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[4]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[5]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[6]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[7]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[8]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[9]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SML_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_ADD_IP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SUB_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_ADD_IP_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_ADD_IP_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_ADD_IP_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/subtract_add_ip\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SUB_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_add_ip\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_LRG_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/not_zero_largest_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_LRG_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_LRG_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/VALID_LRG_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_lrg_add_ip\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.CARRY_MUX/CHAIN_GEN[0].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.CARRY_MUX/D\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_align\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_8,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(3 downto 0)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_8
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.CARRY_MUX/D\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_9,
      DI(3) => \<const1>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\,
      S(2 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(6 downto 4)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_9
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_align\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/first_q\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_14_LZD_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_lod\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_LZD_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_lod\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_LZD_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_10,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].CARRY_MUX\,
      CO(2) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[2].CARRY_MUX\,
      CO(1) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[1].CARRY_MUX\,
      CO(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/CI\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S30_out\,
      S(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S27_out\,
      S(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S24_out\,
      S(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S21_out\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_10
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[0].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/CI\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in16_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[1].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[1].CARRY_MUX\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[2].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[2].CARRY_MUX\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in10_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].CARRY_MUX\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[3].CARRY_MUX\,
      CO(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/D\,
      CO(2) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[6].CARRY_MUX\,
      CO(1) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[5].CARRY_MUX\,
      CO(0) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX\,
      CYINIT => lopt_11,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S\,
      S(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S39_out\,
      S(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S36_out\,
      S(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S33_out\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_11
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[4].CARRY_MUX\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in4_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[5].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[5].CARRY_MUX\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[6].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[6].CARRY_MUX\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DET_GEN[7].REG.CARRY_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/D\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__21\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__3\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__2\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/LEAD16_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[0].LSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF0C"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(23),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(24),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(25),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(26),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O55_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[0].MSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000FC"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(23),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(24),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(25),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(26),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[1].LSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF0C"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(19),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(20),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(21),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(22),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O0_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[1].MSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000FC"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(19),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(20),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(21),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(22),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O1_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[2].LSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF0C"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(15),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(16),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(17),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(18),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O2_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[2].MSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000FC"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(15),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(16),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(17),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(18),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O4_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[3].LSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF0C"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(11),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(12),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(13),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(14),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O3_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_ENC[3].MSB\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000FC"
    )
    port map (
      I0 => \<const0>\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(11),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(12),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(13),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(14),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O7_in\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/LEAD16_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/LEAD16_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(0),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(10),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(10),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(11),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(12),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(13),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(14),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(15),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(16),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(16),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(17),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(17),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(18),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(18),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(19),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(19),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(1),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(20),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(20),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(21),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(21),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(22),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(22),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(23),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(23),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(24),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(24),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(25),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(25),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(26),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(26),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(2),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(3),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(4),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(5),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(6),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(7),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(8),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(9),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(10),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(11),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(12),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(12),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(13),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(13),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(14),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(14),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(15),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(15),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LSB_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/lsb_lod\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LSB_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LSB_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LSB_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/lsb_shift\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_norm\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(25),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/first_q\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_rnd_ip\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/MSBS_DELAY/i_pipe/first_q\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_rnd_ip\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_BIT_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_bit_shift\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_BIT_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_lod\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_DELAY/i_pipe/first_q\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_shift\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 2,
      ADREG => 0,
      ALUMODEREG => 1,
      AREG => 2,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 1,
      CARRYINSELREG => 1,
      CREG => 1,
      DREG => 0,
      INMODEREG => 0,
      IS_ALUMODE_INVERTED => B"0000",
      IS_CARRYIN_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_INMODE_INVERTED => B"00000",
      IS_OPMODE_INVERTED => B"0000000",
      MASK => X"3FFFFFFFFFFF",
      MREG => 1,
      OPMODEREG => 1,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
    port map (
      A(29) => \<const0>\,
      A(28) => \<const0>\,
      A(27) => \<const0>\,
      A(26) => \<const0>\,
      A(25) => \<const0>\,
      A(24) => \<const0>\,
      A(23 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(24 downto 1),
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
      ACOUT(29) => \n_24_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(28) => \n_25_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(27) => \n_26_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(26) => \n_27_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(25) => \n_28_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(24) => \n_29_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(23) => \n_30_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(22) => \n_31_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(21) => \n_32_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(20) => \n_33_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(19) => \n_34_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(18) => \n_35_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(17) => \n_36_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(16) => \n_37_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(15) => \n_38_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(14) => \n_39_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(13) => \n_40_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(12) => \n_41_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(11) => \n_42_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(10) => \n_43_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(9) => \n_44_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(8) => \n_45_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(7) => \n_46_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(6) => \n_47_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(5) => \n_48_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(4) => \n_49_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(3) => \n_50_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(2) => \n_51_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(1) => \n_52_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ACOUT(0) => \n_53_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      ALUMODE(3) => \<const0>\,
      ALUMODE(2) => \<const0>\,
      ALUMODE(1) => \<const0>\,
      ALUMODE(0) => \<const0>\,
      B(17) => \<const0>\,
      B(16) => \<const0>\,
      B(15 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/SHIFT_DELAY/i_pipe/first_q\(15 downto 0),
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
      BCOUT(17) => \n_6_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(16) => \n_7_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(15) => \n_8_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(14) => \n_9_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(13) => \n_10_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(12) => \n_11_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(11) => \n_12_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(10) => \n_13_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(9) => \n_14_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(8) => \n_15_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(7) => \n_16_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(6) => \n_17_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(5) => \n_18_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(4) => \n_19_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(3) => \n_20_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(2) => \n_21_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(1) => \n_22_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      BCOUT(0) => \n_23_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
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
      C(34 downto 27) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(7 downto 0),
      C(26) => \<const1>\,
      C(25 downto 24) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_rnd_ip\(1 downto 0),
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
      C(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ROUND_BIT_DELAY/i_pipe/first_q\,
      C(1) => \<const0>\,
      C(0) => \<const0>\,
      CARRYCASCIN => \<const0>\,
      CARRYCASCOUT => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      CARRYIN => \<const0>\,
      CARRYINSEL(2) => \<const0>\,
      CARRYINSEL(1) => \<const0>\,
      CARRYINSEL(0) => \<const0>\,
      CARRYOUT(3) => \n_54_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      CARRYOUT(2) => \n_55_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      CARRYOUT(1) => \n_56_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      CARRYOUT(0) => \n_57_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      CEA1 => \<const1>\,
      CEA2 => \<const1>\,
      CEAD => \<const0>\,
      CEALUMODE => \<const1>\,
      CEB1 => \<const0>\,
      CEB2 => \<const1>\,
      CEC => \<const1>\,
      CECARRYIN => \<const1>\,
      CECTRL => \<const1>\,
      CED => \<const0>\,
      CEINMODE => \<const0>\,
      CEM => \<const1>\,
      CEP => \<const1>\,
      CLK => aclk,
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
      MULTSIGNOUT => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6) => \<const0>\,
      OPMODE(5) => \<const1>\,
      OPMODE(4) => \<const1>\,
      OPMODE(3) => \<const0>\,
      OPMODE(2) => \<const1>\,
      OPMODE(1) => \<const0>\,
      OPMODE(0) => \<const1>\,
      OVERFLOW => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_OVERFLOW_UNCONNECTED\,
      P(47 downto 35) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_P_UNCONNECTED\(47 downto 35),
      P(34 downto 27) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(7 downto 0),
      P(26) => \n_79_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      P(25) => \n_80_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      P(24) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/round_mant\(22),
      P(23 downto 2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(21 downto 0),
      P(1) => \n_104_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      P(0) => \n_105_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PATTERNBDETECT => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \n_4_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
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
      PCOUT(47) => \n_106_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(46) => \n_107_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(45) => \n_108_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(44) => \n_109_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(43) => \n_110_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(42) => \n_111_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(41) => \n_112_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(40) => \n_113_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(39) => \n_114_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(38) => \n_115_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(37) => \n_116_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(36) => \n_117_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(35) => \n_118_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(34) => \n_119_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(33) => \n_120_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(32) => \n_121_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(31) => \n_122_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(30) => \n_123_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(29) => \n_124_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(28) => \n_125_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(27) => \n_126_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(26) => \n_127_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(25) => \n_128_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(24) => \n_129_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(23) => \n_130_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(22) => \n_131_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(21) => \n_132_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(20) => \n_133_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(19) => \n_134_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(18) => \n_135_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(17) => \n_136_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(16) => \n_137_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(15) => \n_138_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(14) => \n_139_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(13) => \n_140_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(12) => \n_141_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(11) => \n_142_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(10) => \n_143_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(9) => \n_144_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(8) => \n_145_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(7) => \n_146_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(6) => \n_147_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(5) => \n_148_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(4) => \n_149_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(3) => \n_150_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(2) => \n_151_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(1) => \n_152_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      PCOUT(0) => \n_153_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
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
      UNDERFLOW => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP_UNDERFLOW_UNCONNECTED\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/zero_lod\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/zero_up_norm\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_UP_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_and_b_inf_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_and_b_inf_sign_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_SIGN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/zero_largest\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(23),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(24),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(25),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(26),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(27),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(28),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(29),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(30),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_inf_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_inf_sign_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_SIGN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_nan_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_ZERO_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_zero_sign_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_ZERO_SIGN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => p_4_out(31),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_sign_xor_b_sign_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => minusOp(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(23),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(24),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(25),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(26),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(27),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(28),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(29),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => m_axis_z_tdata_b(30),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/p_0_in1_in\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/cancellation\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/first_q\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/CANCELLATION_DELAY/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/exp_all_one_ip\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/exp_all_zero_ip\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3 downto 0)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_mant_is_zero\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/exp_all_one_ip\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/exp_all_zero_ip\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_1,
      CO(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3 downto 0)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/CARRY_ZERO_DET/D\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/b_mant_is_zero\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__31\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(10),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(11),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__6\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__6\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__4\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__3\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_sign\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\: unisim.vcomponents.SRL16E
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
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/first_q\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DET_SIGN_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_sign_del\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(4),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(5),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(6),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(7),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_ALIGN_DELAY/i_pipe/first_q\(8),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(0),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(1),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(2),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(3),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(4),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(5),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(6),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/first_q\(7),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][2]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][3]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][4]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][5]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][6]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][7]_srl3\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_6,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const1>\,
      O(3 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(3 downto 0),
      S(3) => \n_0_CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\,
      S(2) => \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\,
      S(1) => \n_0_CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\,
      S(0) => \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_6
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CYINIT => lopt_7,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(7 downto 4),
      S(3) => \n_0_CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__0\,
      S(2) => \n_0_CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__0\,
      S(1) => \n_0_CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__0\,
      S(0) => \n_0_CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_7
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_CO_UNCONNECTED\(3 downto 0),
      CYINIT => lopt_12,
      DI(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_DI_UNCONNECTED\(3 downto 0),
      O(3 downto 1) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_O_UNCONNECTED\(3 downto 1),
      O(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ext_largest_exp\(8),
      S(3 downto 1) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_S_UNCONNECTED\(3 downto 1),
      S(0) => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.STRUCT_ADD/CHAIN_GEN[8].Q_XOR.SUM_XOR_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_12
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_invalid_op\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/first_q\,
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NORM_SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/norm_sign_mux\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NORM_SIGN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__24\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_6_opt_has_pipe.first_q_reg[3]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_5_opt_has_pipe.first_q_reg[3]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_4_opt_has_pipe.first_q_reg[3]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_7_opt_has_pipe.first_q_reg[7]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(4),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_6_opt_has_pipe.first_q_reg[7]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(5),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_5_opt_has_pipe.first_q_reg[7]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(6),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_4_opt_has_pipe.first_q_reg[7]_i_1__0\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(7),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_7_opt_has_pipe.first_q_reg[9]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(8),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_6_opt_has_pipe.first_q_reg[9]_i_1\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(9),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(9),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\(2),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(2),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\(3),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(3),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_2,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \<const0>\,
      DI(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[3].di_reg\,
      DI(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[2].di_reg\,
      DI(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[1].di_reg\,
      DI(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[0].di_reg\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[3].lut_op_reg\,
      S(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[2].lut_op_reg\,
      S(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[1].lut_op_reg\,
      S(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[0].lut_op_reg\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/D\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_5,
      DI(3) => \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_2\,
      DI(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[14].di_reg\,
      DI(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[13].di_reg\,
      DI(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[12].di_reg\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\,
      S(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[14].lut_op_reg\,
      S(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[13].lut_op_reg\,
      S(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[12].lut_op_reg\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_5
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[15].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/D\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      R => GND_2
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_3,
      DI(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[7].di_reg\,
      DI(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[6].di_reg\,
      DI(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[5].di_reg\,
      DI(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[4].di_reg\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[7].lut_op_reg\,
      S(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[6].lut_op_reg\,
      S(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[5].lut_op_reg\,
      S(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[4].lut_op_reg\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_3
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(2 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => lopt_4,
      DI(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[11].di_reg\,
      DI(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[10].di_reg\,
      DI(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[9].di_reg\,
      DI(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[8].di_reg\,
      O(3 downto 0) => \NLW_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[11].lut_op_reg\,
      S(2) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[10].lut_op_reg\,
      S(1) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[9].lut_op_reg\,
      S(0) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[8].lut_op_reg\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/C_CHAIN/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_4
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SIGN_SIG_UP_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/sign_sig_up\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SIGN_SIG_UP_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state\(0),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/first_q\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state\(1),
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/first_q\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\: unisim.vcomponents.SRL16E
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
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/first_q\(0),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5\: unisim.vcomponents.SRL16E
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
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/first_q\(1),
      Q => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]_srl5\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[7].pipe_reg[7][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/STATE_DELAY/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]_srl5\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SUB_DELAY/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/subtract_int\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SUB_DELAY/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/FLAGS_REG.IV_OP_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/INV_OP_DEL/i_pipe/opt_has_pipe.i_pipe[8].pipe_reg[8][0]_srl7\,
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/FLAGS_REG.IV_OP_REG/i_pipe/first_q\,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/FLAGS_REG.NOT_LATE_UPDATE_GEN.OVERFLOW_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_8_out\,
      Q => p_2_in,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/FLAGS_REG.NOT_LATE_UPDATE_GEN.UNDERFLOW_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_6_out\,
      Q => p_1_in,
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[0]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[1]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[2]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[3]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[4]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[5]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[6]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/exp_rnd\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(0),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[7]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[0]_i_1\,
      Q => p_0_in(23),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[1]_i_1\,
      Q => p_0_in(24),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[2]_i_1\,
      Q => p_0_in(25),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[3]_i_1\,
      Q => p_0_in(26),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[4]_i_1\,
      Q => p_0_in(27),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[5]_i_1\,
      Q => p_0_in(28),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[6]_i_1\,
      Q => p_0_in(29),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.exp_op[7]_i_1\,
      Q => p_0_in(30),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(1)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(10),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(11),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(13),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(15),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(16),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(17),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(18),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(19),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(20),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(21),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(8),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_5_out\(9),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(4),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[0]_i_1\,
      Q => p_0_in(0),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[10]_i_1\,
      Q => p_0_in(10),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[11]_i_1\,
      Q => p_0_in(11),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[12]_i_1\,
      Q => p_0_in(12),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[13]_i_1\,
      Q => p_0_in(13),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[14]_i_1\,
      Q => p_0_in(14),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[15]_i_1\,
      Q => p_0_in(15),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[16]_i_1\,
      Q => p_0_in(16),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[17]_i_1\,
      Q => p_0_in(17),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[18]_i_1\,
      Q => p_0_in(18),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[19]_i_1\,
      Q => p_0_in(19),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[1]_i_1\,
      Q => p_0_in(1),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[20]_i_1\,
      Q => p_0_in(20),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[21]_i_1\,
      Q => p_0_in(21),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_RESULT_REG.NORMAL.mant_op[22]_i_1\,
      Q => p_0_in(22),
      R => \<const0>\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[2]_i_1\,
      Q => p_0_in(2),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[3]_i_1\,
      Q => p_0_in(3),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[4]_i_1\,
      Q => p_0_in(4),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[5]_i_1\,
      Q => p_0_in(5),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[6]_i_1\,
      Q => p_0_in(6),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[7]_i_1\,
      Q => p_0_in(7),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[8]_i_1\,
      Q => p_0_in(8),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.mant_op[9]_i_1\,
      Q => p_0_in(9),
      R => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(5)
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/SIGN_SIG_UP_DELAY/i_pipe/first_q\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(7),
      O => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\
    );
\ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_reg\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/RESULT_REG.NORMAL.sign_op_i_1\,
      Q => p_0_in(31),
      R => \<const0>\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(1),
      I1 => p_4_out(1),
      I2 => m_axis_z_tdata_b(0),
      I3 => p_4_out(0),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[0].lut_op_reg\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"35"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      O => \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55555556AAAAAAAA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT6
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
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(3),
      I1 => m_axis_z_tdata_b(0),
      I2 => m_axis_z_tdata_b(5),
      I3 => m_axis_z_tdata_b(1),
      I4 => m_axis_z_tdata_b(2),
      I5 => m_axis_z_tdata_b(4),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(0),
      I1 => p_4_out(0),
      I2 => p_4_out(1),
      I3 => m_axis_z_tdata_b(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[0].di_reg\
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(21),
      I1 => p_4_out(21),
      I2 => m_axis_z_tdata_b(20),
      I3 => p_4_out(20),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[10].lut_op_reg\
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(20),
      I1 => p_4_out(20),
      I2 => p_4_out(21),
      I3 => m_axis_z_tdata_b(21),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[10].di_reg\
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(23),
      I1 => p_4_out(23),
      I2 => m_axis_z_tdata_b(22),
      I3 => p_4_out(22),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[11].lut_op_reg\
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(22),
      I1 => p_4_out(22),
      I2 => p_4_out(23),
      I3 => m_axis_z_tdata_b(23),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[11].di_reg\
    );
\CHAIN_GEN[12].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(25),
      I1 => p_4_out(25),
      I2 => m_axis_z_tdata_b(24),
      I3 => p_4_out(24),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[12].lut_op_reg\
    );
\CHAIN_GEN[12].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(24),
      I1 => p_4_out(24),
      I2 => p_4_out(25),
      I3 => m_axis_z_tdata_b(25),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[12].di_reg\
    );
\CHAIN_GEN[13].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(27),
      I1 => p_4_out(27),
      I2 => m_axis_z_tdata_b(26),
      I3 => p_4_out(26),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[13].lut_op_reg\
    );
\CHAIN_GEN[13].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(26),
      I1 => p_4_out(26),
      I2 => p_4_out(27),
      I3 => m_axis_z_tdata_b(27),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[13].di_reg\
    );
\CHAIN_GEN[14].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(29),
      I1 => p_4_out(29),
      I2 => m_axis_z_tdata_b(28),
      I3 => p_4_out(28),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[14].lut_op_reg\
    );
\CHAIN_GEN[14].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(28),
      I1 => p_4_out(28),
      I2 => p_4_out(29),
      I3 => m_axis_z_tdata_b(29),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[14].di_reg\
    );
\CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(30),
      I1 => p_4_out(30),
      O => \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[15].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => m_axis_z_tdata_b(30),
      I1 => p_4_out(30),
      O => \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_2\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(3),
      I1 => p_4_out(3),
      I2 => m_axis_z_tdata_b(2),
      I3 => p_4_out(2),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[1].lut_op_reg\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(1),
      O => \n_0_CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT6
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
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(9),
      I1 => m_axis_z_tdata_b(6),
      I2 => m_axis_z_tdata_b(11),
      I3 => m_axis_z_tdata_b(7),
      I4 => m_axis_z_tdata_b(8),
      I5 => m_axis_z_tdata_b(10),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(2),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(3),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(2),
      I1 => p_4_out(2),
      I2 => p_4_out(3),
      I3 => m_axis_z_tdata_b(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[1].di_reg\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(5),
      I1 => p_4_out(5),
      I2 => m_axis_z_tdata_b(4),
      I3 => p_4_out(4),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[2].lut_op_reg\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(2),
      O => \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT6
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
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(15),
      I1 => m_axis_z_tdata_b(12),
      I2 => m_axis_z_tdata_b(17),
      I3 => m_axis_z_tdata_b(13),
      I4 => m_axis_z_tdata_b(14),
      I5 => m_axis_z_tdata_b(16),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(4),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(5),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(5),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(4),
      I1 => p_4_out(4),
      I2 => p_4_out(5),
      I3 => m_axis_z_tdata_b(5),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[2].di_reg\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(7),
      I1 => p_4_out(7),
      I2 => m_axis_z_tdata_b(6),
      I3 => p_4_out(6),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[3].lut_op_reg\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(3),
      O => \n_0_CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => p_4_out(20),
      I1 => p_4_out(22),
      I2 => p_4_out(19),
      I3 => p_4_out(21),
      I4 => p_4_out(18),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(20),
      I1 => m_axis_z_tdata_b(22),
      I2 => m_axis_z_tdata_b(19),
      I3 => m_axis_z_tdata_b(21),
      I4 => m_axis_z_tdata_b(18),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/MANT_CARRY.MANT_ALL_ZERO_DET/chunk_det\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(6),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(7),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(7),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(6),
      I1 => p_4_out(6),
      I2 => p_4_out(7),
      I3 => m_axis_z_tdata_b(7),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[3].di_reg\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(9),
      I1 => p_4_out(9),
      I2 => m_axis_z_tdata_b(8),
      I3 => p_4_out(8),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[4].lut_op_reg\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(4),
      O => \n_0_CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(8),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(9),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(9),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(4)
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(8),
      I1 => p_4_out(8),
      I2 => p_4_out(9),
      I3 => m_axis_z_tdata_b(9),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[4].di_reg\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(11),
      I1 => p_4_out(11),
      I2 => m_axis_z_tdata_b(10),
      I3 => p_4_out(10),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[5].lut_op_reg\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(5),
      O => \n_0_CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(10),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(10),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(11),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(11),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(5)
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(10),
      I1 => p_4_out(10),
      I2 => p_4_out(11),
      I3 => m_axis_z_tdata_b(11),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[5].di_reg\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(13),
      I1 => p_4_out(13),
      I2 => m_axis_z_tdata_b(12),
      I3 => p_4_out(12),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[6].lut_op_reg\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(6),
      O => \n_0_CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(12),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(13),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(13),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/ZERO_14_DET.ZERO_DET/chunk_det\(6)
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(12),
      I1 => p_4_out(12),
      I2 => p_4_out(13),
      I3 => m_axis_z_tdata_b(13),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[6].di_reg\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(15),
      I1 => p_4_out(15),
      I2 => m_axis_z_tdata_b(14),
      I3 => p_4_out(14),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[7].lut_op_reg\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_EXP_DELAY/i_pipe/first_q\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_EXP_DELAY/i_pipe/first_q\(7),
      O => \n_0_CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(14),
      I1 => p_4_out(14),
      I2 => p_4_out(15),
      I3 => m_axis_z_tdata_b(15),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[7].di_reg\
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(17),
      I1 => p_4_out(17),
      I2 => m_axis_z_tdata_b(16),
      I3 => p_4_out(16),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[8].lut_op_reg\
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(16),
      I1 => p_4_out(16),
      I2 => p_4_out(17),
      I3 => m_axis_z_tdata_b(17),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[8].di_reg\
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => m_axis_z_tdata_b(19),
      I1 => p_4_out(19),
      I2 => m_axis_z_tdata_b(18),
      I3 => p_4_out(18),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[9].lut_op_reg\
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
    port map (
      I0 => m_axis_z_tdata_b(18),
      I1 => p_4_out(18),
      I2 => p_4_out(19),
      I3 => m_axis_z_tdata_b(19),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NUMB_CMP/NOT_FAST.CMP/ADD_MANT_GEN[9].di_reg\
    );
\DET_GEN[0].CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(26),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(10),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(25),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(9),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S21_out\
    );
\DET_GEN[1].CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(24),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(8),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(23),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(7),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S24_out\
    );
\DET_GEN[2].CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(22),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(6),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(21),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(5),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S27_out\
    );
\DET_GEN[3].CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(20),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(4),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(19),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S30_out\
    );
\DET_GEN[4].CARRY_MUX_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(18),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(2),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(17),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S33_out\
    );
\DET_GEN[5].CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01F1"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(15),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(16),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(0),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S36_out\
    );
\DET_GEN[6].CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CD"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(13),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S39_out\
    );
\DET_GEN[7].CARRY_MUX_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CD"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(11),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/S\
    );
\FLAGS_REG.NOT_LATE_UPDATE_GEN.OVERFLOW_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(0),
      I1 => \n_79_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(2),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_8_out\
    );
\FLAGS_REG.NOT_LATE_UPDATE_GEN.UNDERFLOW_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/FLOW_SIG_UP_DELAY/i_pipe/first_q\(3),
      I2 => \n_79_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/SHIFT_RND/DSP\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/p_6_out\
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
\HAS_OUTPUT_FIFO.i_output_fifo\: entity work.ip_fp32_axis_addglb_ifx_master
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
      wr_data(34) => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/OP/FLAGS_REG.IV_OP_REG/i_pipe/first_q\,
      wr_data(33) => p_2_in,
      wr_data(32) => p_1_in,
      wr_data(31 downto 0) => p_0_in(31 downto 0),
      wr_enable => valid_transfer_out
    );
\RESULT_REG.NORMAL.mant_op[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/round_mant\(22),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/DEC_STATE_PRE_OP_DELAY/i_pipe/first_q\(2),
      O => \n_0_RESULT_REG.NORMAL.mant_op[22]_i_1\
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
\i_nd_to_rdy/opt_has_pipe.i_pipe[10].pipe_reg[10][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[9]\,
      Q => \pipe[10]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[11].pipe_reg[11][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[10]\,
      Q => valid_transfer_out,
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
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\,
      Q => \pipe[4]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \pipe[4]\,
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
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[7].pipe_reg[7][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[8].pipe_reg[8][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[7].pipe_reg[7][0]\,
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[8].pipe_reg[8][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[9].pipe_reg[9][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[8].pipe_reg[8][0]\,
      Q => \pipe[9]\,
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
      Q => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/p_0_in1_in\,
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
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(0),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(10),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(11),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(12),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(13),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(14),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(15),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(16),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(1),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(2),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(3),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(4),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(5),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(6),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(7),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(8),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const1>\,
      CE => \<const1>\,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(9),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][0]_srl9\,
      Q => p_4_in(0),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][10]_srl9\,
      Q => p_4_in(10),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][11]_srl9\,
      Q => p_4_in(11),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][12]_srl9\,
      Q => p_4_in(12),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][13]_srl9\,
      Q => p_4_in(13),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][14]_srl9\,
      Q => p_4_in(14),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][15]_srl9\,
      Q => p_4_in(15),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][16]_srl9\,
      Q => p_4_in(16),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][1]_srl9\,
      Q => p_4_in(1),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][2]_srl9\,
      Q => p_4_in(2),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][3]_srl9\,
      Q => p_4_in(3),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][4]_srl9\,
      Q => p_4_in(4),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][5]_srl9\,
      Q => p_4_in(5),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][6]_srl9\,
      Q => p_4_in(6),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][7]_srl9\,
      Q => p_4_in(7),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][8]_srl9\,
      Q => p_4_in(8),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[11].pipe_reg[11][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[10].pipe_reg[10][9]_srl9\,
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
\opt_has_pipe.first_q[0]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/not_zero_largest_mux\
    );
\opt_has_pipe.first_q[0]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/zero_largest\
    );
\opt_has_pipe.first_q[0]_i_1__10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_zero_sign_mux\
    );
\opt_has_pipe.first_q[0]_i_1__11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(0),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(14),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(14),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__11\
    );
\opt_has_pipe.first_q[0]_i_1__12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1040000000002080"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(0)
    );
\opt_has_pipe.first_q[0]_i_1__13\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_2__0\,
      I1 => \n_0_opt_has_pipe.first_q[0]_i_3\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/valid_mux\
    );
\opt_has_pipe.first_q[0]_i_1__14\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_out(23),
      I1 => m_axis_z_tdata_b(23),
      O => minusOp(0)
    );
\opt_has_pipe.first_q[0]_i_1__15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/first_q\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state\(0)
    );
\opt_has_pipe.first_q[0]_i_1__16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4F44"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/b_mant_is_zero\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_mant_is_zero\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_nan_mux\
    );
\opt_has_pipe.first_q[0]_i_1__17\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_and_b_inf_sign_mux\
    );
\opt_has_pipe.first_q[0]_i_1__18\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SUB_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_align\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/cin_align\
    );
\opt_has_pipe.first_q[0]_i_1__19\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__19\
    );
\opt_has_pipe.first_q[0]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/p_0_in1_in\,
      I1 => p_4_out(31),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/subtract_int\
    );
\opt_has_pipe.first_q[0]_i_1__20\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/LEAD16_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/cancellation\
    );
\opt_has_pipe.first_q[0]_i_1__21\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_2__1\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O0_in\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__21\
    );
\opt_has_pipe.first_q[0]_i_1__22\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(26),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(25),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/mant_msbs_norm\(0)
    );
\opt_has_pipe.first_q[0]_i_1__23\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/Z_LZD_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/zero_up_norm\
    );
\opt_has_pipe.first_q[0]_i_1__24\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(0),
      I1 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__24\
    );
\opt_has_pipe.first_q[0]_i_1__25\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(26),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in16_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(0)
    );
\opt_has_pipe.first_q[0]_i_1__26\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_shift\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/lsb_shift\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/ZERO_UP_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_bit_shift\
    );
\opt_has_pipe.first_q[0]_i_1__27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF0FF000F808F808"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(24),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(26),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(3),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(25),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/lsb_lod\
    );
\opt_has_pipe.first_q[0]_i_1__28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF0FF000F808F808"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(24),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(26),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(2),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(25),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/round_lod\
    );
\opt_has_pipe.first_q[0]_i_1__29\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0737"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(25),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(26),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/zero_lod\
    );
\opt_has_pipe.first_q[0]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0AC"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_ZERO_SIGN_DEL/i_pipe/first_q\,
      I1 => \n_0_opt_has_pipe.first_q[0]_i_2\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_sign\
    );
\opt_has_pipe.first_q[0]_i_1__30\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00020000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(0),
      I1 => \n_0_opt_has_pipe.first_q[2]_i_2\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(9),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(8),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\(0)
    );
\opt_has_pipe.first_q[0]_i_1__31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FF00FF00FF10"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__31\
    );
\opt_has_pipe.first_q[0]_i_1__32\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(0)
    );
\opt_has_pipe.first_q[0]_i_1__33\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A8AA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_sign_del\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/sign_sig_up\
    );
\opt_has_pipe.first_q[0]_i_1__34\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => p_4_out(25),
      I1 => p_4_out(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__2\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/exp_all_zero_ip\
    );
\opt_has_pipe.first_q[0]_i_1__35\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => p_4_out(25),
      I1 => p_4_out(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__3\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/exp_all_one_ip\
    );
\opt_has_pipe.first_q[0]_i_1__36\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => m_axis_z_tdata_b(25),
      I1 => m_axis_z_tdata_b(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__4\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/exp_all_zero_ip\
    );
\opt_has_pipe.first_q[0]_i_1__37\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => m_axis_z_tdata_b(25),
      I1 => m_axis_z_tdata_b(23),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__5\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/exp_all_one_ip\
    );
\opt_has_pipe.first_q[0]_i_1__38\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_7_in\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_9_in\,
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__6\,
      I3 => \n_0_opt_has_pipe.first_q[0]_i_3__0\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_lod\
    );
\opt_has_pipe.first_q[0]_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_invalid_op\
    );
\opt_has_pipe.first_q[0]_i_1__5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_sign_xor_b_sign_mux\
    );
\opt_has_pipe.first_q[0]_i_1__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_mant_is_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_inf_sign_mux\
    );
\opt_has_pipe.first_q[0]_i_1__7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/b_mant_is_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_mant_is_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_or_b_inf_mux\
    );
\opt_has_pipe.first_q[0]_i_1__8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/b_mant_is_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_mant_is_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/a_and_b_inf_mux\
    );
\opt_has_pipe.first_q[0]_i_1__9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/B_SIGN_DELAY/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_DELAY/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/norm_sign_mux\
    );
\opt_has_pipe.first_q[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_SIGN_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_SIGN_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/first_q\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NORM_SIGN_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_2\
    );
\opt_has_pipe.first_q[0]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBFDBFDDBBDDBFDD"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__0\
    );
\opt_has_pipe.first_q[0]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0C0FACA00C00ACA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O55_in\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O2_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O3_in\,
      O => \n_0_opt_has_pipe.first_q[0]_i_2__1\
    );
\opt_has_pipe.first_q[0]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_4_out(27),
      I1 => p_4_out(24),
      I2 => p_4_out(28),
      I3 => p_4_out(30),
      I4 => p_4_out(26),
      I5 => p_4_out(29),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__2\
    );
\opt_has_pipe.first_q[0]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => p_4_out(27),
      I1 => p_4_out(24),
      I2 => p_4_out(28),
      I3 => p_4_out(30),
      I4 => p_4_out(26),
      I5 => p_4_out(29),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__3\
    );
\opt_has_pipe.first_q[0]_i_2__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => m_axis_z_tdata_b(27),
      I1 => m_axis_z_tdata_b(24),
      I2 => m_axis_z_tdata_b(28),
      I3 => m_axis_z_tdata_b(30),
      I4 => m_axis_z_tdata_b(26),
      I5 => m_axis_z_tdata_b(29),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__4\
    );
\opt_has_pipe.first_q[0]_i_2__5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => m_axis_z_tdata_b(27),
      I1 => m_axis_z_tdata_b(24),
      I2 => m_axis_z_tdata_b(28),
      I3 => m_axis_z_tdata_b(30),
      I4 => m_axis_z_tdata_b(26),
      I5 => m_axis_z_tdata_b(29),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__5\
    );
\opt_has_pipe.first_q[0]_i_2__6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/sum_pad_fab\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_10_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/zeros_14_lod\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_8_in\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_6_in\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_5_in\,
      O => \n_0_opt_has_pipe.first_q[0]_i_2__6\
    );
\opt_has_pipe.first_q[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF7FFE"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(6),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(8),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_B/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/COND_DET_A/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_3\
    );
\opt_has_pipe.first_q[0]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_0_in\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_2_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_3_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_1_in\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/sum_pad_fab\(12),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/p_4_in\,
      O => \n_0_opt_has_pipe.first_q[0]_i_3__0\
    );
\opt_has_pipe.first_q[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000090090000000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(10)
    );
\opt_has_pipe.first_q[10]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(10),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(10),
      O => \n_0_opt_has_pipe.first_q[10]_i_1__0\
    );
\opt_has_pipe.first_q[10]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(10),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(10),
      O => \n_0_opt_has_pipe.first_q[10]_i_1__1\
    );
\opt_has_pipe.first_q[10]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(16),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in4_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(10)
    );
\opt_has_pipe.first_q[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0008008100100000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(11)
    );
\opt_has_pipe.first_q[11]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(11),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(11),
      O => \n_0_opt_has_pipe.first_q[11]_i_1__0\
    );
\opt_has_pipe.first_q[11]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(11),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(11),
      O => \n_0_opt_has_pipe.first_q[11]_i_1__1\
    );
\opt_has_pipe.first_q[11]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(11),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(11)
    );
\opt_has_pipe.first_q[11]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(16),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(15),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in4_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(11)
    );
\opt_has_pipe.first_q[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0880000001100000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(12)
    );
\opt_has_pipe.first_q[12]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(12),
      O => \n_0_opt_has_pipe.first_q[12]_i_1__0\
    );
\opt_has_pipe.first_q[12]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(12),
      O => \n_0_opt_has_pipe.first_q[12]_i_1__1\
    );
\opt_has_pipe.first_q[12]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(12)
    );
\opt_has_pipe.first_q[12]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(12)
    );
\opt_has_pipe.first_q[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000010030"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(13)
    );
\opt_has_pipe.first_q[13]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(13),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(13),
      O => \n_0_opt_has_pipe.first_q[13]_i_1__0\
    );
\opt_has_pipe.first_q[13]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(13),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(13),
      O => \n_0_opt_has_pipe.first_q[13]_i_1__1\
    );
\opt_has_pipe.first_q[13]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(13),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(13)
    );
\opt_has_pipe.first_q[13]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(13),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(13)
    );
\opt_has_pipe.first_q[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000010"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(14)
    );
\opt_has_pipe.first_q[14]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(14),
      O => \n_0_opt_has_pipe.first_q[14]_i_1__0\
    );
\opt_has_pipe.first_q[14]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(14),
      O => \n_0_opt_has_pipe.first_q[14]_i_1__1\
    );
\opt_has_pipe.first_q[14]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(14),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(14)
    );
\opt_has_pipe.first_q[14]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(14)
    );
\opt_has_pipe.first_q[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(15),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(15),
      O => \n_0_opt_has_pipe.first_q[15]_i_1\
    );
\opt_has_pipe.first_q[15]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(15),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(15),
      O => \n_0_opt_has_pipe.first_q[15]_i_1__0\
    );
\opt_has_pipe.first_q[15]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(15)
    );
\opt_has_pipe.first_q[15]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(15),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(15)
    );
\opt_has_pipe.first_q[15]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(12),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(11),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(15)
    );
\opt_has_pipe.first_q[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(16),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(16),
      O => \n_0_opt_has_pipe.first_q[16]_i_1\
    );
\opt_has_pipe.first_q[16]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(16),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(16),
      O => \n_0_opt_has_pipe.first_q[16]_i_1__0\
    );
\opt_has_pipe.first_q[16]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(16),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(16)
    );
\opt_has_pipe.first_q[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(17),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(17),
      O => \n_0_opt_has_pipe.first_q[17]_i_1\
    );
\opt_has_pipe.first_q[17]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(17),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(17),
      O => \n_0_opt_has_pipe.first_q[17]_i_1__0\
    );
\opt_has_pipe.first_q[17]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(17),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(17)
    );
\opt_has_pipe.first_q[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(18),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(18),
      O => \n_0_opt_has_pipe.first_q[18]_i_1\
    );
\opt_has_pipe.first_q[18]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(18),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(18),
      O => \n_0_opt_has_pipe.first_q[18]_i_1__0\
    );
\opt_has_pipe.first_q[18]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(18),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(18)
    );
\opt_has_pipe.first_q[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(19),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(19),
      O => \n_0_opt_has_pipe.first_q[19]_i_1\
    );
\opt_has_pipe.first_q[19]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(19),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(19),
      O => \n_0_opt_has_pipe.first_q[19]_i_1__0\
    );
\opt_has_pipe.first_q[19]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(19),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(19)
    );
\opt_has_pipe.first_q[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(1),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(15),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(15),
      O => \n_0_opt_has_pipe.first_q[1]_i_1\
    );
\opt_has_pipe.first_q[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0110000000022000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(1)
    );
\opt_has_pipe.first_q[1]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ABBBAABA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_ZERO_DEL/i_pipe/first_q\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_NAN_DEL/i_pipe/first_q\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_AND_B_INF_DEL/i_pipe/first_q\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_SIGN_XOR_B_SIGN_DEL/i_pipe/first_q\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/A_OR_B_INF_DEL/i_pipe/first_q\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state\(1)
    );
\opt_has_pipe.first_q[1]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__2\
    );
\opt_has_pipe.first_q[1]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[1]_i_2\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O1_in\,
      O => \n_0_opt_has_pipe.first_q[1]_i_1__3\
    );
\opt_has_pipe.first_q[1]_i_1__4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(26),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(25),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in16_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(1)
    );
\opt_has_pipe.first_q[1]_i_1__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(1)
    );
\opt_has_pipe.first_q[1]_i_1__6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0F0F0F0E"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(1),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__6\
    );
\opt_has_pipe.first_q[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0C0FACA00C00ACA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O4_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/O7_in\,
      O => \n_0_opt_has_pipe.first_q[1]_i_2\
    );
\opt_has_pipe.first_q[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(20),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(20),
      O => \n_0_opt_has_pipe.first_q[20]_i_1\
    );
\opt_has_pipe.first_q[20]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(20),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(20),
      O => \n_0_opt_has_pipe.first_q[20]_i_1__0\
    );
\opt_has_pipe.first_q[20]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(20),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(20)
    );
\opt_has_pipe.first_q[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(21),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(21),
      O => \n_0_opt_has_pipe.first_q[21]_i_1\
    );
\opt_has_pipe.first_q[21]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(21),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(21),
      O => \n_0_opt_has_pipe.first_q[21]_i_1__0\
    );
\opt_has_pipe.first_q[21]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(21),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(21)
    );
\opt_has_pipe.first_q[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(22),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(22),
      O => \n_0_opt_has_pipe.first_q[22]_i_1\
    );
\opt_has_pipe.first_q[22]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(22),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(22),
      O => \n_0_opt_has_pipe.first_q[22]_i_1__0\
    );
\opt_has_pipe.first_q[22]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(22),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(22)
    );
\opt_has_pipe.first_q[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFE00010000FFFF"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[23]_i_1\
    );
\opt_has_pipe.first_q[23]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(23),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(23)
    );
\opt_has_pipe.first_q[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(8),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(24),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(24)
    );
\opt_has_pipe.first_q[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(9),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(25),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(25)
    );
\opt_has_pipe.first_q[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(10),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/lead16_zero\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/add_mant\(26),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shifted_16_lzd\(26)
    );
\opt_has_pipe.first_q[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(2),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(16),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(16),
      O => \n_0_opt_has_pipe.first_q[2]_i_1\
    );
\opt_has_pipe.first_q[2]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010400000208000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(2)
    );
\opt_has_pipe.first_q[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[2]_i_1__1\
    );
\opt_has_pipe.first_q[2]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in1_in\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      O => \n_0_opt_has_pipe.first_q[2]_i_1__2\
    );
\opt_has_pipe.first_q[2]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(24),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in16_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(2)
    );
\opt_has_pipe.first_q[2]_i_1__4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(0),
      I1 => \n_0_opt_has_pipe.first_q[2]_i_2\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(9),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(8),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\(2)
    );
\opt_has_pipe.first_q[2]_i_1__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(2),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(2)
    );
\opt_has_pipe.first_q[2]_i_1__6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      O => \n_0_opt_has_pipe.first_q[2]_i_1__6\
    );
\opt_has_pipe.first_q[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(2),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(6),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(7),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(4),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[2]_i_2\
    );
\opt_has_pipe.first_q[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(3),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(17),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(17),
      O => \n_0_opt_has_pipe.first_q[3]_i_1\
    );
\opt_has_pipe.first_q[3]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001040002080000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(3)
    );
\opt_has_pipe.first_q[3]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__1\
    );
\opt_has_pipe.first_q[3]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(24),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(23),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in16_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(3)
    );
\opt_has_pipe.first_q[3]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/flow_sig_up\(3)
    );
\opt_has_pipe.first_q[3]_i_1__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBBBBBBBBBA"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__4\
    );
\opt_has_pipe.first_q[3]_i_1__5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[3]_i_2__1\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(0),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(1),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(9),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(8),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/ip_sig__0\(3)
    );
\opt_has_pipe.first_q[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(26),
      I1 => p_4_out(26),
      O => \n_0_opt_has_pipe.first_q[3]_i_2\
    );
\opt_has_pipe.first_q[3]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[3]_i_2__0\
    );
\opt_has_pipe.first_q[3]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(2),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(6),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(7),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(4),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.NORM_EXP_DELAY/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[3]_i_2__1\
    );
\opt_has_pipe.first_q[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(25),
      I1 => p_4_out(25),
      O => \n_0_opt_has_pipe.first_q[3]_i_3\
    );
\opt_has_pipe.first_q[3]_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[3]_i_3__0\
    );
\opt_has_pipe.first_q[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(24),
      I1 => p_4_out(24),
      O => \n_0_opt_has_pipe.first_q[3]_i_4\
    );
\opt_has_pipe.first_q[3]_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[3]_i_4__0\
    );
\opt_has_pipe.first_q[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(23),
      I1 => p_4_out(23),
      O => \n_0_opt_has_pipe.first_q[3]_i_5\
    );
\opt_has_pipe.first_q[3]_i_5__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[3]_i_5__0\
    );
\opt_has_pipe.first_q[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(4),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(18),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(18),
      O => \n_0_opt_has_pipe.first_q[4]_i_1\
    );
\opt_has_pipe.first_q[4]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000104020800000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(4)
    );
\opt_has_pipe.first_q[4]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(4),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[4]_i_1__1\
    );
\opt_has_pipe.first_q[4]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(22),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in10_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(4)
    );
\opt_has_pipe.first_q[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(5),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(19),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(19),
      O => \n_0_opt_has_pipe.first_q[5]_i_1\
    );
\opt_has_pipe.first_q[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000010608000000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(5)
    );
\opt_has_pipe.first_q[5]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__1\
    );
\opt_has_pipe.first_q[5]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(22),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(21),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in13_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in10_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(5)
    );
\opt_has_pipe.first_q[5]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(1),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/cancellation_del\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/NOT_LOW_LATENCY_NORM_DIST.SIGDELAY/i_pipe/first_q\(0),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(0),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/det_state_del\(1),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__3\
    );
\opt_has_pipe.first_q[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(6),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(20),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(20),
      O => \n_0_opt_has_pipe.first_q[6]_i_1\
    );
\opt_has_pipe.first_q[6]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(6),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(6),
      O => \n_0_opt_has_pipe.first_q[6]_i_1__0\
    );
\opt_has_pipe.first_q[6]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"40000200"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(6)
    );
\opt_has_pipe.first_q[6]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(20),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in10_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(6)
    );
\opt_has_pipe.first_q[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(7),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(21),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(21),
      O => \n_0_opt_has_pipe.first_q[7]_i_1\
    );
\opt_has_pipe.first_q[7]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000100800000084"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(7)
    );
\opt_has_pipe.first_q[7]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(7),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(7),
      O => \n_0_opt_has_pipe.first_q[7]_i_1__1\
    );
\opt_has_pipe.first_q[7]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(20),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(19),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in10_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(7)
    );
\opt_has_pipe.first_q[7]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]\,
      O => \n_0_opt_has_pipe.first_q[7]_i_2\
    );
\opt_has_pipe.first_q[7]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(30),
      I1 => p_4_out(30),
      O => \n_0_opt_has_pipe.first_q[7]_i_2__0\
    );
\opt_has_pipe.first_q[7]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]\,
      O => \n_0_opt_has_pipe.first_q[7]_i_3\
    );
\opt_has_pipe.first_q[7]_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(29),
      I1 => p_4_out(29),
      O => \n_0_opt_has_pipe.first_q[7]_i_3__0\
    );
\opt_has_pipe.first_q[7]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]\,
      O => \n_0_opt_has_pipe.first_q[7]_i_4\
    );
\opt_has_pipe.first_q[7]_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(28),
      I1 => p_4_out(28),
      O => \n_0_opt_has_pipe.first_q[7]_i_4__0\
    );
\opt_has_pipe.first_q[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => m_axis_z_tdata_b(27),
      I1 => p_4_out(27),
      O => \n_0_opt_has_pipe.first_q[7]_i_5\
    );
\opt_has_pipe.first_q[7]_i_5__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/DIST_DELAY/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[7]_i_5__0\
    );
\opt_has_pipe.first_q[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(8),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(8),
      I2 => \n_0_opt_has_pipe.first_q[23]_i_1\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(22),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(22),
      O => \n_0_opt_has_pipe.first_q[8]_i_1\
    );
\opt_has_pipe.first_q[8]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0108108000000000"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(8)
    );
\opt_has_pipe.first_q[8]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(8),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(8),
      O => \n_0_opt_has_pipe.first_q[8]_i_1__1\
    );
\opt_has_pipe.first_q[8]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(18),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in4_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(8)
    );
\opt_has_pipe.first_q[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEAE"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/shift_by_14_mux\,
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(9),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(9),
      O => \n_0_opt_has_pipe.first_q[9]_i_1\
    );
\opt_has_pipe.first_q[9]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000018000001800"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(5),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(3),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(4),
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(2),
      I4 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(0),
      I5 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/BMA_EXP_DELAY/i_pipe/first_q\(1),
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.ALIGN_ADD/SHIFT_TABLE[0]\(9)
    );
\opt_has_pipe.first_q[9]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/B_IP_DELAY/i_pipe/first_q\(9),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/b_largest\,
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/A_IP_DELAY/i_pipe/first_q\(9),
      O => \n_0_opt_has_pipe.first_q[9]_i_1__1\
    );
\opt_has_pipe.first_q[9]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(18),
      I1 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/NORM_DELAY/i_pipe/first_q\(17),
      I2 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in7_in\,
      I3 => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/Q0_in4_in\,
      O => \ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/LOD/shift_norm\(9)
    );
\opt_has_pipe.first_q_reg[3]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_opt_has_pipe.first_q_reg[3]_i_1\,
      CO(2) => \n_1_opt_has_pipe.first_q_reg[3]_i_1\,
      CO(1) => \n_2_opt_has_pipe.first_q_reg[3]_i_1\,
      CO(0) => \n_3_opt_has_pipe.first_q_reg[3]_i_1\,
      CYINIT => \<const1>\,
      DI(3 downto 0) => m_axis_z_tdata_b(26 downto 23),
      O(3 downto 1) => minusOp(3 downto 1),
      O(0) => \NLW_opt_has_pipe.first_q_reg[3]_i_1_O_UNCONNECTED\(0),
      S(3) => \n_0_opt_has_pipe.first_q[3]_i_2\,
      S(2) => \n_0_opt_has_pipe.first_q[3]_i_3\,
      S(1) => \n_0_opt_has_pipe.first_q[3]_i_4\,
      S(0) => \n_0_opt_has_pipe.first_q[3]_i_5\
    );
\opt_has_pipe.first_q_reg[3]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_opt_has_pipe.first_q_reg[3]_i_1__0\,
      CO(2) => \n_1_opt_has_pipe.first_q_reg[3]_i_1__0\,
      CO(1) => \n_2_opt_has_pipe.first_q_reg[3]_i_1__0\,
      CO(0) => \n_3_opt_has_pipe.first_q_reg[3]_i_1__0\,
      CYINIT => \<const1>\,
      DI(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]\,
      DI(2) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]\,
      DI(1) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]\,
      DI(0) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\,
      O(3) => \n_4_opt_has_pipe.first_q_reg[3]_i_1__0\,
      O(2) => \n_5_opt_has_pipe.first_q_reg[3]_i_1__0\,
      O(1) => \n_6_opt_has_pipe.first_q_reg[3]_i_1__0\,
      O(0) => \NLW_opt_has_pipe.first_q_reg[3]_i_1__0_O_UNCONNECTED\(0),
      S(3) => \n_0_opt_has_pipe.first_q[3]_i_2__0\,
      S(2) => \n_0_opt_has_pipe.first_q[3]_i_3__0\,
      S(1) => \n_0_opt_has_pipe.first_q[3]_i_4__0\,
      S(0) => \n_0_opt_has_pipe.first_q[3]_i_5__0\
    );
\opt_has_pipe.first_q_reg[7]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_opt_has_pipe.first_q_reg[3]_i_1\,
      CO(3) => \n_0_opt_has_pipe.first_q_reg[7]_i_1\,
      CO(2) => \n_1_opt_has_pipe.first_q_reg[7]_i_1\,
      CO(1) => \n_2_opt_has_pipe.first_q_reg[7]_i_1\,
      CO(0) => \n_3_opt_has_pipe.first_q_reg[7]_i_1\,
      CYINIT => \<const0>\,
      DI(3 downto 0) => m_axis_z_tdata_b(30 downto 27),
      O(3 downto 0) => minusOp(7 downto 4),
      S(3) => \n_0_opt_has_pipe.first_q[7]_i_2__0\,
      S(2) => \n_0_opt_has_pipe.first_q[7]_i_3__0\,
      S(1) => \n_0_opt_has_pipe.first_q[7]_i_4__0\,
      S(0) => \n_0_opt_has_pipe.first_q[7]_i_5\
    );
\opt_has_pipe.first_q_reg[7]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_opt_has_pipe.first_q_reg[3]_i_1__0\,
      CO(3) => \n_0_opt_has_pipe.first_q_reg[7]_i_1__0\,
      CO(2) => \n_1_opt_has_pipe.first_q_reg[7]_i_1__0\,
      CO(1) => \n_2_opt_has_pipe.first_q_reg[7]_i_1__0\,
      CO(0) => \n_3_opt_has_pipe.first_q_reg[7]_i_1__0\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]\,
      DI(2) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]\,
      DI(1) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]\,
      DI(0) => \n_0_ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/EXP/EXP_OFF.LRG_EXP_DELAY/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]\,
      O(3) => \n_4_opt_has_pipe.first_q_reg[7]_i_1__0\,
      O(2) => \n_5_opt_has_pipe.first_q_reg[7]_i_1__0\,
      O(1) => \n_6_opt_has_pipe.first_q_reg[7]_i_1__0\,
      O(0) => \n_7_opt_has_pipe.first_q_reg[7]_i_1__0\,
      S(3) => \n_0_opt_has_pipe.first_q[7]_i_2\,
      S(2) => \n_0_opt_has_pipe.first_q[7]_i_3\,
      S(1) => \n_0_opt_has_pipe.first_q[7]_i_4\,
      S(0) => \n_0_opt_has_pipe.first_q[7]_i_5__0\
    );
\opt_has_pipe.first_q_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_opt_has_pipe.first_q_reg[7]_i_1\,
      CO(3 downto 0) => \NLW_opt_has_pipe.first_q_reg[8]_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 1) => \NLW_opt_has_pipe.first_q_reg[8]_i_1_O_UNCONNECTED\(3 downto 1),
      O(0) => minusOp(8),
      S(3) => \<const0>\,
      S(2) => \<const0>\,
      S(1) => \<const0>\,
      S(0) => \<const1>\
    );
\opt_has_pipe.first_q_reg[9]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_opt_has_pipe.first_q_reg[7]_i_1__0\,
      CO(3 downto 1) => \NLW_opt_has_pipe.first_q_reg[9]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \n_3_opt_has_pipe.first_q_reg[9]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 2) => \NLW_opt_has_pipe.first_q_reg[9]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1) => \n_6_opt_has_pipe.first_q_reg[9]_i_1\,
      O(0) => \n_7_opt_has_pipe.first_q_reg[9]_i_1\,
      S(3) => \<const0>\,
      S(2) => \<const0>\,
      S(1) => \<const1>\,
      S(0) => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ is
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
  attribute ORIG_REF_NAME of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is "floating_point_v7_0";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 14;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 2;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 2;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is 19;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ : entity is "yes";
end \ip_fp32_axis_addfloating_point_v7_0__parameterized0\;

architecture STRUCTURE of \ip_fp32_axis_addfloating_point_v7_0__parameterized0\ is
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
  attribute C_HAS_ADD of i_synth : label is 1;
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
  attribute C_HAS_MULTIPLY of i_synth : label is 0;
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
  attribute C_LATENCY of i_synth : label is 14;
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
i_synth: entity work.\ip_fp32_axis_addfloating_point_v7_0_viv__parameterized0\
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
entity ip_fp32_axis_add is
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
  attribute NotValidForBitStream of ip_fp32_axis_add : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_fp32_axis_add : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ip_fp32_axis_add : entity is "floating_point_v7_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_fp32_axis_add : entity is "ip_fp32_axis_add,floating_point_v7_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of ip_fp32_axis_add : entity is "ip_fp32_axis_add,floating_point_v7_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=floating_point,x_ipVersion=7.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_XDEVICEFAMILY=kintex7,C_HAS_ADD=1,C_HAS_SUBTRACT=0,C_HAS_MULTIPLY=0,C_HAS_DIVIDE=0,C_HAS_SQRT=0,C_HAS_COMPARE=0,C_HAS_FIX_TO_FLT=0,C_HAS_FLT_TO_FIX=0,C_HAS_FLT_TO_FLT=0,C_HAS_RECIP=0,C_HAS_RECIP_SQRT=0,C_HAS_ABSOLUTE=0,C_HAS_LOGARITHM=0,C_HAS_EXPONENTIAL=0,C_HAS_FMA=0,C_HAS_FMS=0,C_HAS_ACCUMULATOR_A=0,C_HAS_ACCUMULATOR_S=0,C_A_WIDTH=32,C_A_FRACTION_WIDTH=24,C_B_WIDTH=32,C_B_FRACTION_WIDTH=24,C_C_WIDTH=32,C_C_FRACTION_WIDTH=24,C_RESULT_WIDTH=32,C_RESULT_FRACTION_WIDTH=24,C_COMPARE_OPERATION=8,C_LATENCY=14,C_OPTIMIZATION=1,C_MULT_USAGE=2,C_BRAM_USAGE=0,C_RATE=1,C_ACCUM_INPUT_MSB=32,C_ACCUM_MSB=32,C_ACCUM_LSB=-31,C_HAS_UNDERFLOW=1,C_HAS_OVERFLOW=1,C_HAS_INVALID_OP=1,C_HAS_DIVIDE_BY_ZERO=0,C_HAS_ACCUM_OVERFLOW=0,C_HAS_ACCUM_INPUT_OVERFLOW=0,C_HAS_ACLKEN=0,C_HAS_ARESETN=1,C_THROTTLE_SCHEME=2,C_HAS_A_TUSER=1,C_HAS_A_TLAST=1,C_HAS_B=1,C_HAS_B_TUSER=1,C_HAS_B_TLAST=1,C_HAS_C=0,C_HAS_C_TUSER=0,C_HAS_C_TLAST=0,C_HAS_OPERATION=0,C_HAS_OPERATION_TUSER=0,C_HAS_OPERATION_TLAST=0,C_HAS_RESULT_TUSER=1,C_HAS_RESULT_TLAST=1,C_TLAST_RESOLUTION=1,C_A_TDATA_WIDTH=32,C_A_TUSER_WIDTH=8,C_B_TDATA_WIDTH=32,C_B_TUSER_WIDTH=8,C_C_TDATA_WIDTH=32,C_C_TUSER_WIDTH=1,C_OPERATION_TDATA_WIDTH=8,C_OPERATION_TUSER_WIDTH=1,C_RESULT_TDATA_WIDTH=32,C_RESULT_TUSER_WIDTH=19}";
end ip_fp32_axis_add;

architecture STRUCTURE of ip_fp32_axis_add is
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
  attribute C_HAS_ADD of U0 : label is 1;
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
  attribute C_HAS_MULTIPLY of U0 : label is 0;
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
  attribute C_LATENCY of U0 : label is 14;
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
U0: entity work.\ip_fp32_axis_addfloating_point_v7_0__parameterized0\
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
