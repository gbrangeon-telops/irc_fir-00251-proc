-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3_AR71948_AR71898 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Feb 22 09:36:16 2024
-- Host        : Telops331 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/IP/325/isc0804A_17_5_MHz_mmcm_v3/isc0804A_17_5_MHz_mmcm_v3_sim_netlist.vhdl
-- Design      : isc0804A_17_5_MHz_mmcm_v3
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity isc0804A_17_5_MHz_mmcm_v3_isc0804A_17_5_MHz_mmcm_v3_clk_wiz is
  port (
    mclk_source : out STD_LOGIC;
    quad1_clk_source : out STD_LOGIC;
    quad2_clk_source : out STD_LOGIC;
    quad3_clk_source : out STD_LOGIC;
    quad4_clk_source : out STD_LOGIC;
    daddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dclk : in STD_LOGIC;
    den : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drdy : out STD_LOGIC;
    dwe : in STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of isc0804A_17_5_MHz_mmcm_v3_isc0804A_17_5_MHz_mmcm_v3_clk_wiz : entity is "isc0804A_17_5_MHz_mmcm_v3_clk_wiz";
end isc0804A_17_5_MHz_mmcm_v3_isc0804A_17_5_MHz_mmcm_v3_clk_wiz;

architecture STRUCTURE of isc0804A_17_5_MHz_mmcm_v3_isc0804A_17_5_MHz_mmcm_v3_clk_wiz is
  signal clk_in_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal clkfbout_buf_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal clkfbout_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal mclk_source_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal quad1_clk_source_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal quad2_clk_source_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal quad3_clk_source_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal quad4_clk_source_isc0804A_17_5_MHz_mmcm_v3 : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_bufg : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout3_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout4_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout5_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of plle2_adv_inst : label is "PRIMITIVE";
begin
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_isc0804A_17_5_MHz_mmcm_v3,
      O => clkfbout_buf_isc0804A_17_5_MHz_mmcm_v3
    );
clkin1_bufg: unisim.vcomponents.BUFG
     port map (
      I => clk_in,
      O => clk_in_isc0804A_17_5_MHz_mmcm_v3
    );
clkout1_buf: unisim.vcomponents.BUFG
     port map (
      I => mclk_source_isc0804A_17_5_MHz_mmcm_v3,
      O => mclk_source
    );
clkout2_buf: unisim.vcomponents.BUFG
     port map (
      I => quad1_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      O => quad1_clk_source
    );
clkout3_buf: unisim.vcomponents.BUFG
     port map (
      I => quad2_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      O => quad2_clk_source
    );
clkout4_buf: unisim.vcomponents.BUFG
     port map (
      I => quad3_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      O => quad3_clk_source
    );
clkout5_buf: unisim.vcomponents.BUFG
     port map (
      I => quad4_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      O => quad4_clk_source
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 49,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 10.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 7,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 7,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 7,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT3_DIVIDE => 7,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT4_DIVIDE => 7,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "BUF_IN",
      DIVCLK_DIVIDE => 5,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => clkfbout_buf_isc0804A_17_5_MHz_mmcm_v3,
      CLKFBOUT => clkfbout_isc0804A_17_5_MHz_mmcm_v3,
      CLKIN1 => clk_in_isc0804A_17_5_MHz_mmcm_v3,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => mclk_source_isc0804A_17_5_MHz_mmcm_v3,
      CLKOUT1 => quad1_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      CLKOUT2 => quad2_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      CLKOUT3 => quad3_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      CLKOUT4 => quad4_clk_source_isc0804A_17_5_MHz_mmcm_v3,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6 downto 0) => daddr(6 downto 0),
      DCLK => dclk,
      DEN => den,
      DI(15 downto 0) => din(15 downto 0),
      DO(15 downto 0) => dout(15 downto 0),
      DRDY => drdy,
      DWE => dwe,
      LOCKED => locked,
      PWRDWN => '0',
      RST => reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity isc0804A_17_5_MHz_mmcm_v3 is
  port (
    mclk_source : out STD_LOGIC;
    quad1_clk_source : out STD_LOGIC;
    quad2_clk_source : out STD_LOGIC;
    quad3_clk_source : out STD_LOGIC;
    quad4_clk_source : out STD_LOGIC;
    daddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dclk : in STD_LOGIC;
    den : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drdy : out STD_LOGIC;
    dwe : in STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of isc0804A_17_5_MHz_mmcm_v3 : entity is true;
end isc0804A_17_5_MHz_mmcm_v3;

architecture STRUCTURE of isc0804A_17_5_MHz_mmcm_v3 is
begin
inst: entity work.isc0804A_17_5_MHz_mmcm_v3_isc0804A_17_5_MHz_mmcm_v3_clk_wiz
     port map (
      clk_in => clk_in,
      daddr(6 downto 0) => daddr(6 downto 0),
      dclk => dclk,
      den => den,
      din(15 downto 0) => din(15 downto 0),
      dout(15 downto 0) => dout(15 downto 0),
      drdy => drdy,
      dwe => dwe,
      locked => locked,
      mclk_source => mclk_source,
      quad1_clk_source => quad1_clk_source,
      quad2_clk_source => quad2_clk_source,
      quad3_clk_source => quad3_clk_source,
      quad4_clk_source => quad4_clk_source,
      reset => reset
    );
end STRUCTURE;
