-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Tue Jun 21 14:03:54 2016
-- Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_c_counter_binary_v12_0_0/histogram_axis_tmi_c_counter_binary_v12_0_0_funcsim.vhdl
-- Design      : histogram_axis_tmi_c_counter_binary_v12_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    UP : in STD_LOGIC;
    LOAD : in STD_LOGIC;
    L : in STD_LOGIC_VECTOR ( 6 downto 0 );
    THRESH0 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "c_counter_binary_v12_0_viv";
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_WIDTH : integer;
  attribute C_WIDTH of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 7;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_RESTRICT_COUNT : integer;
  attribute C_RESTRICT_COUNT of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_COUNT_TO : string;
  attribute C_COUNT_TO of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "1";
  attribute C_COUNT_BY : string;
  attribute C_COUNT_BY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "1";
  attribute C_COUNT_MODE : integer;
  attribute C_COUNT_MODE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_THRESH0_VALUE : string;
  attribute C_THRESH0_VALUE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "1";
  attribute C_CE_OVERRIDES_SYNC : integer;
  attribute C_CE_OVERRIDES_SYNC of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_THRESH0 : integer;
  attribute C_HAS_THRESH0 of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_LOAD : integer;
  attribute C_HAS_LOAD of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_LOAD_LOW : integer;
  attribute C_LOAD_LOW of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_FB_LATENCY : integer;
  attribute C_FB_LATENCY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "0";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "0";
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ : entity is "yes";
end \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/CI\ : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carryxor0\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[3].carryxor\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carryxor\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[5].carryxor\ : STD_LOGIC;
  signal \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carryxortop\ : STD_LOGIC;
  signal \n_0_i_simple_model.carrymux0_i_1\ : STD_LOGIC;
  signal \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carrymux0_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type : string;
  attribute box_type of \i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carrymux0_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4\ : label is "PRIMITIVE";
begin
  Q(6 downto 0) <= \^q\(6 downto 0);
  THRESH0 <= \<const1>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carryxor0\,
      Q => \^q\(0),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor\,
      Q => \^q\(1),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor\,
      Q => \^q\(2),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[3].carryxor\,
      Q => \^q\(3),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carryxor\,
      Q => \^q\(4),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[5].carryxor\,
      Q => \^q\(5),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_q.i_simple.qreg/i_no_async_controls.output_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carryxortop\,
      Q => \^q\(6),
      R => SINIT
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carrymux0_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux\,
      CO(2) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux\,
      CO(1) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux\,
      CO(0) => \i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/CI\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const1>\,
      O(3) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[3].carryxor\,
      O(2) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor\,
      O(1) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor\,
      O(0) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carryxor0\,
      S(3 downto 1) => \^q\(3 downto 1),
      S(0) => \n_0_i_simple_model.carrymux0_i_1\
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.carrymux0_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux\,
      CO(3 downto 1) => \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux\,
      CYINIT => lopt_1,
      DI(3 downto 2) => \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_DI_UNCONNECTED\(3 downto 2),
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_O_UNCONNECTED\(3),
      O(2) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carryxortop\,
      O(1) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[5].carryxor\,
      O(0) => \n_0_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carryxor\,
      S(3) => \NLW_i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_S_UNCONNECTED\(3),
      S(2 downto 0) => \^q\(6 downto 4)
    );
\i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
\i_simple_model.carrymux0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^q\(0),
      O => \n_0_i_simple_model.carrymux0_i_1\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    UP : in STD_LOGIC;
    LOAD : in STD_LOGIC;
    L : in STD_LOGIC_VECTOR ( 6 downto 0 );
    THRESH0 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "c_counter_binary_v12_0";
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "kintex7";
  attribute C_WIDTH : integer;
  attribute C_WIDTH of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 7;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 1;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_RESTRICT_COUNT : integer;
  attribute C_RESTRICT_COUNT of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_COUNT_TO : string;
  attribute C_COUNT_TO of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "1";
  attribute C_COUNT_BY : string;
  attribute C_COUNT_BY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "1";
  attribute C_COUNT_MODE : integer;
  attribute C_COUNT_MODE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_THRESH0_VALUE : string;
  attribute C_THRESH0_VALUE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "1";
  attribute C_CE_OVERRIDES_SYNC : integer;
  attribute C_CE_OVERRIDES_SYNC of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_HAS_THRESH0 : integer;
  attribute C_HAS_THRESH0 of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_HAS_LOAD : integer;
  attribute C_HAS_LOAD of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_LOAD_LOW : integer;
  attribute C_LOAD_LOW of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 1;
  attribute C_FB_LATENCY : integer;
  attribute C_FB_LATENCY of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "0";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "0";
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ : entity is "yes";
end \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\ is
  attribute C_AINIT_VAL of i_synth : label is "0";
  attribute C_CE_OVERRIDES_SYNC of i_synth : label is 0;
  attribute C_FB_LATENCY of i_synth : label is 0;
  attribute C_HAS_CE of i_synth : label is 1;
  attribute C_HAS_SCLR of i_synth : label is 0;
  attribute C_HAS_SINIT of i_synth : label is 1;
  attribute C_HAS_SSET of i_synth : label is 0;
  attribute C_IMPLEMENTATION of i_synth : label is 0;
  attribute C_SCLR_OVERRIDES_SSET of i_synth : label is 1;
  attribute C_SINIT_VAL of i_synth : label is "0";
  attribute C_VERBOSITY of i_synth : label is 0;
  attribute C_WIDTH of i_synth : label is 7;
  attribute C_XDEVICEFAMILY of i_synth : label is "kintex7";
  attribute c_count_by of i_synth : label is "1";
  attribute c_count_mode of i_synth : label is 0;
  attribute c_count_to of i_synth : label is "1";
  attribute c_has_load of i_synth : label is 0;
  attribute c_has_thresh0 of i_synth : label is 0;
  attribute c_latency of i_synth : label is 1;
  attribute c_load_low of i_synth : label is 0;
  attribute c_restrict_count of i_synth : label is 0;
  attribute c_thresh0_value of i_synth : label is "1";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.\histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0_viv__parameterized0\
    port map (
      CE => CE,
      CLK => CLK,
      L(6 downto 0) => L(6 downto 0),
      LOAD => LOAD,
      Q(6 downto 0) => Q(6 downto 0),
      SCLR => SCLR,
      SINIT => SINIT,
      SSET => SSET,
      THRESH0 => THRESH0,
      UP => UP
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity histogram_axis_tmi_c_counter_binary_v12_0_0 is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of histogram_axis_tmi_c_counter_binary_v12_0_0 : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of histogram_axis_tmi_c_counter_binary_v12_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of histogram_axis_tmi_c_counter_binary_v12_0_0 : entity is "c_counter_binary_v12_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of histogram_axis_tmi_c_counter_binary_v12_0_0 : entity is "histogram_axis_tmi_c_counter_binary_v12_0_0,c_counter_binary_v12_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of histogram_axis_tmi_c_counter_binary_v12_0_0 : entity is "histogram_axis_tmi_c_counter_binary_v12_0_0,c_counter_binary_v12_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_counter_binary,x_ipVersion=12.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_IMPLEMENTATION=0,C_VERBOSITY=0,C_XDEVICEFAMILY=kintex7,C_WIDTH=7,C_HAS_CE=1,C_HAS_SCLR=0,C_RESTRICT_COUNT=0,C_COUNT_TO=1,C_COUNT_BY=1,C_COUNT_MODE=0,C_THRESH0_VALUE=1,C_CE_OVERRIDES_SYNC=0,C_HAS_THRESH0=0,C_HAS_LOAD=0,C_LOAD_LOW=0,C_LATENCY=1,C_FB_LATENCY=0,C_AINIT_VAL=0,C_SINIT_VAL=0,C_SCLR_OVERRIDES_SSET=1,C_HAS_SSET=0,C_HAS_SINIT=1}";
end histogram_axis_tmi_c_counter_binary_v12_0_0;

architecture STRUCTURE of histogram_axis_tmi_c_counter_binary_v12_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal NLW_U0_THRESH0_UNCONNECTED : STD_LOGIC;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of U0 : label is "0";
  attribute C_CE_OVERRIDES_SYNC : integer;
  attribute C_CE_OVERRIDES_SYNC of U0 : label is 0;
  attribute C_FB_LATENCY : integer;
  attribute C_FB_LATENCY of U0 : label is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of U0 : label is 1;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of U0 : label is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of U0 : label is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of U0 : label is 0;
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of U0 : label is 0;
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of U0 : label is 1;
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of U0 : label is "0";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of U0 : label is 0;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of U0 : label is 7;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "kintex7";
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is true;
  attribute c_count_by : string;
  attribute c_count_by of U0 : label is "1";
  attribute c_count_mode : integer;
  attribute c_count_mode of U0 : label is 0;
  attribute c_count_to : string;
  attribute c_count_to of U0 : label is "1";
  attribute c_has_load : integer;
  attribute c_has_load of U0 : label is 0;
  attribute c_has_thresh0 : integer;
  attribute c_has_thresh0 of U0 : label is 0;
  attribute c_latency : integer;
  attribute c_latency of U0 : label is 1;
  attribute c_load_low : integer;
  attribute c_load_low of U0 : label is 0;
  attribute c_restrict_count : integer;
  attribute c_restrict_count of U0 : label is 0;
  attribute c_thresh0_value : string;
  attribute c_thresh0_value of U0 : label is "1";
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
U0: entity work.\histogram_axis_tmi_c_counter_binary_v12_0_0c_counter_binary_v12_0__parameterized0\
    port map (
      CE => CE,
      CLK => CLK,
      L(6) => \<const0>\,
      L(5) => \<const0>\,
      L(4) => \<const0>\,
      L(3) => \<const0>\,
      L(2) => \<const0>\,
      L(1) => \<const0>\,
      L(0) => \<const0>\,
      LOAD => \<const0>\,
      Q(6 downto 0) => Q(6 downto 0),
      SCLR => \<const0>\,
      SINIT => SINIT,
      SSET => \<const0>\,
      THRESH0 => NLW_U0_THRESH0_UNCONNECTED,
      UP => \<const1>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
