-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Wed Jul 22 11:09:56 2015
-- Host        : TELOPS212 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_c_addsub_v12_0_0/histogram_axis_tmi_c_addsub_v12_0_0_funcsim.vhdl
-- Design      : histogram_axis_tmi_c_addsub_v12_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0\ is
  port (
    S : out STD_LOGIC_VECTOR ( 21 downto 0 );
    A : in STD_LOGIC_VECTOR ( 21 downto 0 );
    B : in STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0\ : entity is "c_addsub_v12_0_lut6_legacy";
end \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal CI : STD_LOGIC;
  signal LI : STD_LOGIC;
  signal S_0 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal lopt_2 : STD_LOGIC;
  signal lopt_3 : STD_LOGIC;
  signal lopt_4 : STD_LOGIC;
  signal lopt_5 : STD_LOGIC;
  signal \n_0_i_simple_model.carryxor0_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[10].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[11].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[12].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[13].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[14].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[15].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[16].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[17].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[18].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[19].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[1].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[2].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[3].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[4].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[5].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[6].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[7].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[8].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[9].carrymux\ : STD_LOGIC;
  signal \n_0_i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1\ : STD_LOGIC;
  signal \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \i_simple_model.carrymux0_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type : string;
  attribute box_type of \i_simple_model.carrymux0_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \i_simple_model.i_gt_1.carrychaingen[12].carrymux_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \i_simple_model.i_gt_1.carrychaingen[12].carrymux_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \i_simple_model.i_gt_1.carrychaingen[16].carrymux_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \i_simple_model.i_gt_1.carrychaingen[16].carrymux_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \i_simple_model.i_gt_1.carrychaingen[8].carrymux_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \i_simple_model.i_gt_1.carrychaingen[8].carrymux_CARRY4\ : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\i_simple_model.carrymux0_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[3].carrymux\,
      CO(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[2].carrymux\,
      CO(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[1].carrymux\,
      CO(0) => CI,
      CYINIT => \<const0>\,
      DI(3 downto 0) => A(3 downto 0),
      O(3 downto 0) => S(3 downto 0),
      S(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1\,
      S(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1\,
      S(1) => S_0,
      S(0) => \n_0_i_simple_model.carryxor0_i_1\
    );
\i_simple_model.carrymux0_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\i_simple_model.carryxor0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(0),
      I1 => B(0),
      O => \n_0_i_simple_model.carryxor0_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(10),
      I1 => B(10),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(11),
      I1 => B(11),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[12].carrymux_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_i_simple_model.i_gt_1.carrychaingen[11].carrymux\,
      CO(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[15].carrymux\,
      CO(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[14].carrymux\,
      CO(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[13].carrymux\,
      CO(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[12].carrymux\,
      CYINIT => lopt_3,
      DI(3 downto 0) => A(15 downto 12),
      O(3 downto 0) => S(15 downto 12),
      S(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1\,
      S(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1\,
      S(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1\,
      S(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[12].carrymux_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_3
    );
\i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(12),
      I1 => B(12),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(13),
      I1 => B(13),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(14),
      I1 => B(14),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(15),
      I1 => B(15),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[16].carrymux_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_i_simple_model.i_gt_1.carrychaingen[15].carrymux\,
      CO(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[19].carrymux\,
      CO(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[18].carrymux\,
      CO(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[17].carrymux\,
      CO(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[16].carrymux\,
      CYINIT => lopt_4,
      DI(3 downto 0) => A(19 downto 16),
      O(3 downto 0) => S(19 downto 16),
      S(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1\,
      S(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1\,
      S(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1\,
      S(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[16].carrymux_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_4
    );
\i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(16),
      I1 => B(16),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(17),
      I1 => B(17),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(18),
      I1 => B(18),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(19),
      I1 => B(19),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[1].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(1),
      I1 => B(1),
      O => S_0
    );
\i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_i_simple_model.i_gt_1.carrychaingen[19].carrymux\,
      CO(3 downto 0) => \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_CO_UNCONNECTED\(3 downto 0),
      CYINIT => lopt_5,
      DI(3 downto 1) => \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_DI_UNCONNECTED\(3 downto 1),
      DI(0) => A(20),
      O(3 downto 2) => \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_O_UNCONNECTED\(3 downto 2),
      O(1 downto 0) => S(21 downto 20),
      S(3 downto 2) => \NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_S_UNCONNECTED\(3 downto 2),
      S(1) => LI,
      S(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_5
    );
\i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(20),
      I1 => B(20),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(2),
      I1 => B(2),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(3),
      I1 => B(3),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_i_simple_model.i_gt_1.carrychaingen[3].carrymux\,
      CO(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[7].carrymux\,
      CO(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[6].carrymux\,
      CO(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[5].carrymux\,
      CO(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[4].carrymux\,
      CYINIT => lopt_1,
      DI(3 downto 0) => A(7 downto 4),
      O(3 downto 0) => S(7 downto 4),
      S(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1\,
      S(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1\,
      S(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1\,
      S(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
\i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(4),
      I1 => B(4),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(5),
      I1 => B(5),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(6),
      I1 => B(6),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(7),
      I1 => B(7),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[8].carrymux_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_i_simple_model.i_gt_1.carrychaingen[7].carrymux\,
      CO(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[11].carrymux\,
      CO(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[10].carrymux\,
      CO(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[9].carrymux\,
      CO(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[8].carrymux\,
      CYINIT => lopt_2,
      DI(3 downto 0) => A(11 downto 8),
      O(3 downto 0) => S(11 downto 8),
      S(3) => \n_0_i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1\,
      S(2) => \n_0_i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1\,
      S(1) => \n_0_i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1\,
      S(0) => \n_0_i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[8].carrymux_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_2
    );
\i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(8),
      I1 => B(8),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(9),
      I1 => B(9),
      O => \n_0_i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1\
    );
\i_simple_model.i_gt_1.carryxortop_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => A(21),
      I1 => B(21),
      O => LI
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0\ is
  port (
    S : out STD_LOGIC_VECTOR ( 21 downto 0 );
    A : in STD_LOGIC_VECTOR ( 21 downto 0 );
    B : in STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0\ : entity is "c_addsub_v12_0_fabric_legacy";
end \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0\ is
begin
\i_lut6.i_lut6_addsub\: entity work.\histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0\
    port map (
      A(21 downto 0) => A(21 downto 0),
      B(21 downto 0) => B(21 downto 0),
      S(21 downto 0) => S(21 downto 0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0\ is
  port (
    S : out STD_LOGIC_VECTOR ( 21 downto 0 );
    A : in STD_LOGIC_VECTOR ( 21 downto 0 );
    B : in STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0\ : entity is "c_addsub_v12_0_legacy";
end \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0\ is
begin
\no_pipelining.the_addsub\: entity work.\histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0\
    port map (
      A(21 downto 0) => A(21 downto 0),
      B(21 downto 0) => B(21 downto 0),
      S(21 downto 0) => S(21 downto 0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ is
  port (
    A : in STD_LOGIC_VECTOR ( 21 downto 0 );
    B : in STD_LOGIC_VECTOR ( 21 downto 0 );
    CLK : in STD_LOGIC;
    ADD : in STD_LOGIC;
    C_IN : in STD_LOGIC;
    CE : in STD_LOGIC;
    BYPASS : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    C_OUT : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is "c_addsub_v12_0_viv";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 22;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 22;
  attribute C_OUT_WIDTH : integer;
  attribute C_OUT_WIDTH of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 22;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_A_TYPE : integer;
  attribute C_A_TYPE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_ADD_MODE : integer;
  attribute C_ADD_MODE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_B_CONSTANT : integer;
  attribute C_B_CONSTANT of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_B_VALUE : string;
  attribute C_B_VALUE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is "0000000000000000000000";
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is "0";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is "0";
  attribute C_CE_OVERRIDES_BYPASS : integer;
  attribute C_CE_OVERRIDES_BYPASS of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_BYPASS_LOW : integer;
  attribute C_BYPASS_LOW of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_C_IN : integer;
  attribute C_HAS_C_IN of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_OUT : integer;
  attribute C_HAS_C_OUT of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_BORROW_LOW : integer;
  attribute C_BORROW_LOW of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_BYPASS : integer;
  attribute C_HAS_BYPASS of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ : entity is "yes";
end \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
begin
  C_OUT <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\i_baseblox.i_baseblox_addsub\: entity work.\histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0\
    port map (
      A(21 downto 0) => A(21 downto 0),
      B(21 downto 0) => B(21 downto 0),
      S(21 downto 0) => S(21 downto 0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0\ is
  port (
    S : out STD_LOGIC_VECTOR ( 21 downto 0 );
    A : in STD_LOGIC_VECTOR ( 21 downto 0 );
    B : in STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0\ : entity is "c_addsub_v12_0";
end \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0\;

architecture STRUCTURE of \histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal NLW_xst_addsub_C_OUT_UNCONNECTED : STD_LOGIC;
  attribute C_ADD_MODE : integer;
  attribute C_ADD_MODE of xst_addsub : label is 0;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of xst_addsub : label is "0";
  attribute C_A_TYPE : integer;
  attribute C_A_TYPE of xst_addsub : label is 1;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of xst_addsub : label is 22;
  attribute C_BORROW_LOW : integer;
  attribute C_BORROW_LOW of xst_addsub : label is 1;
  attribute C_BYPASS_LOW : integer;
  attribute C_BYPASS_LOW of xst_addsub : label is 0;
  attribute C_B_CONSTANT : integer;
  attribute C_B_CONSTANT of xst_addsub : label is 0;
  attribute C_B_TYPE : integer;
  attribute C_B_TYPE of xst_addsub : label is 1;
  attribute C_B_VALUE : string;
  attribute C_B_VALUE of xst_addsub : label is "0000000000000000000000";
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of xst_addsub : label is 22;
  attribute C_CE_OVERRIDES_BYPASS : integer;
  attribute C_CE_OVERRIDES_BYPASS of xst_addsub : label is 1;
  attribute C_CE_OVERRIDES_SCLR : integer;
  attribute C_CE_OVERRIDES_SCLR of xst_addsub : label is 0;
  attribute C_HAS_BYPASS : integer;
  attribute C_HAS_BYPASS of xst_addsub : label is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of xst_addsub : label is 0;
  attribute C_HAS_C_IN : integer;
  attribute C_HAS_C_IN of xst_addsub : label is 0;
  attribute C_HAS_C_OUT : integer;
  attribute C_HAS_C_OUT of xst_addsub : label is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of xst_addsub : label is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of xst_addsub : label is 0;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of xst_addsub : label is 0;
  attribute C_IMPLEMENTATION : integer;
  attribute C_IMPLEMENTATION of xst_addsub : label is 0;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of xst_addsub : label is 0;
  attribute C_OUT_WIDTH : integer;
  attribute C_OUT_WIDTH of xst_addsub : label is 22;
  attribute C_SCLR_OVERRIDES_SSET : integer;
  attribute C_SCLR_OVERRIDES_SSET of xst_addsub : label is 1;
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of xst_addsub : label is "0";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of xst_addsub : label is 0;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of xst_addsub : label is "kintex7";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of xst_addsub : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
xst_addsub: entity work.\histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0\
    port map (
      A(21 downto 0) => A(21 downto 0),
      ADD => \<const1>\,
      B(21 downto 0) => B(21 downto 0),
      BYPASS => \<const0>\,
      CE => \<const1>\,
      CLK => \<const0>\,
      C_IN => \<const0>\,
      C_OUT => NLW_xst_addsub_C_OUT_UNCONNECTED,
      S(21 downto 0) => S(21 downto 0),
      SCLR => \<const0>\,
      SINIT => \<const0>\,
      SSET => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity histogram_axis_tmi_c_addsub_v12_0_0 is
  port (
    A : in STD_LOGIC_VECTOR ( 21 downto 0 );
    B : in STD_LOGIC_VECTOR ( 21 downto 0 );
    S : out STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of histogram_axis_tmi_c_addsub_v12_0_0 : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of histogram_axis_tmi_c_addsub_v12_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of histogram_axis_tmi_c_addsub_v12_0_0 : entity is "c_addsub_v12_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of histogram_axis_tmi_c_addsub_v12_0_0 : entity is "histogram_axis_tmi_c_addsub_v12_0_0,c_addsub_v12_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of histogram_axis_tmi_c_addsub_v12_0_0 : entity is "histogram_axis_tmi_c_addsub_v12_0_0,c_addsub_v12_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_addsub,x_ipVersion=12.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=kintex7,C_IMPLEMENTATION=0,C_A_WIDTH=22,C_B_WIDTH=22,C_OUT_WIDTH=22,C_CE_OVERRIDES_SCLR=0,C_A_TYPE=1,C_B_TYPE=1,C_LATENCY=0,C_ADD_MODE=0,C_B_CONSTANT=0,C_B_VALUE=0000000000000000000000,C_AINIT_VAL=0,C_SINIT_VAL=0,C_CE_OVERRIDES_BYPASS=1,C_BYPASS_LOW=0,C_SCLR_OVERRIDES_SSET=1,C_HAS_C_IN=0,C_HAS_C_OUT=0,C_BORROW_LOW=1,C_HAS_CE=0,C_HAS_BYPASS=0,C_HAS_SCLR=0,C_HAS_SSET=0,C_HAS_SINIT=0}";
end histogram_axis_tmi_c_addsub_v12_0_0;

architecture STRUCTURE of histogram_axis_tmi_c_addsub_v12_0_0 is
begin
U0: entity work.\histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0\
    port map (
      A(21 downto 0) => A(21 downto 0),
      B(21 downto 0) => B(21 downto 0),
      S(21 downto 0) => S(21 downto 0)
    );
end STRUCTURE;
