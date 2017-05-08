-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Tue May 02 15:21:58 2017
-- Host        : TELOPS228 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/scorpiomwA_18MHz_mmcm/scorpiomwA_18MHz_mmcm_funcsim.vhdl
-- Design      : scorpiomwA_18MHz_mmcm
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity scorpiomwA_18MHz_mmcmscorpiomwA_18MHz_mmcm_clk_wiz is
  port (
    clk_in : in STD_LOGIC;
    mclk_source : out STD_LOGIC;
    adc_phase_clk : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
end scorpiomwA_18MHz_mmcmscorpiomwA_18MHz_mmcm_clk_wiz;

architecture STRUCTURE of scorpiomwA_18MHz_mmcmscorpiomwA_18MHz_mmcm_clk_wiz is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal adc_phase_clk_scorpiomwA_18MHz_mmcm : STD_LOGIC;
  signal clk_in_scorpiomwA_18MHz_mmcm : STD_LOGIC;
  signal clkfbout_buf_scorpiomwA_18MHz_mmcm : STD_LOGIC;
  signal clkfbout_scorpiomwA_18MHz_mmcm : STD_LOGIC;
  signal mclk_source_scorpiomwA_18MHz_mmcm : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT2_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute box_type : string;
  attribute box_type of clkf_buf : label is "PRIMITIVE";
  attribute box_type of clkin1_bufg : label is "PRIMITIVE";
  attribute box_type of clkout1_buf : label is "PRIMITIVE";
  attribute box_type of clkout2_buf : label is "PRIMITIVE";
  attribute box_type of plle2_adv_inst : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
clkf_buf: unisim.vcomponents.BUFG
    port map (
      I => clkfbout_scorpiomwA_18MHz_mmcm,
      O => clkfbout_buf_scorpiomwA_18MHz_mmcm
    );
clkin1_bufg: unisim.vcomponents.BUFG
    port map (
      I => clk_in,
      O => clk_in_scorpiomwA_18MHz_mmcm
    );
clkout1_buf: unisim.vcomponents.BUFG
    port map (
      I => mclk_source_scorpiomwA_18MHz_mmcm,
      O => mclk_source
    );
clkout2_buf: unisim.vcomponents.BUFG
    port map (
      I => adc_phase_clk_scorpiomwA_18MHz_mmcm,
      O => adc_phase_clk
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 54,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 10.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 15,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 3,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 1,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT4_DIVIDE => 1,
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
      REF_JITTER1 => 0.050000,
      REF_JITTER2 => 0.000000,
      STARTUP_WAIT => "FALSE"
    )
    port map (
      CLKFBIN => clkfbout_buf_scorpiomwA_18MHz_mmcm,
      CLKFBOUT => clkfbout_scorpiomwA_18MHz_mmcm,
      CLKIN1 => clk_in_scorpiomwA_18MHz_mmcm,
      CLKIN2 => \<const0>\,
      CLKINSEL => \<const1>\,
      CLKOUT0 => mclk_source_scorpiomwA_18MHz_mmcm,
      CLKOUT1 => adc_phase_clk_scorpiomwA_18MHz_mmcm,
      CLKOUT2 => NLW_plle2_adv_inst_CLKOUT2_UNCONNECTED,
      CLKOUT3 => NLW_plle2_adv_inst_CLKOUT3_UNCONNECTED,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6) => \<const0>\,
      DADDR(5) => \<const0>\,
      DADDR(4) => \<const0>\,
      DADDR(3) => \<const0>\,
      DADDR(2) => \<const0>\,
      DADDR(1) => \<const0>\,
      DADDR(0) => \<const0>\,
      DCLK => \<const0>\,
      DEN => \<const0>\,
      DI(15) => \<const0>\,
      DI(14) => \<const0>\,
      DI(13) => \<const0>\,
      DI(12) => \<const0>\,
      DI(11) => \<const0>\,
      DI(10) => \<const0>\,
      DI(9) => \<const0>\,
      DI(8) => \<const0>\,
      DI(7) => \<const0>\,
      DI(6) => \<const0>\,
      DI(5) => \<const0>\,
      DI(4) => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => \<const0>\,
      LOCKED => locked,
      PWRDWN => \<const0>\,
      RST => reset
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity scorpiomwA_18MHz_mmcm is
  port (
    clk_in : in STD_LOGIC;
    mclk_source : out STD_LOGIC;
    adc_phase_clk : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of scorpiomwA_18MHz_mmcm : entity is true;
  attribute core_generation_info : string;
  attribute core_generation_info of scorpiomwA_18MHz_mmcm : entity is "scorpiomwA_18MHz_mmcm,clk_wiz_v5_1,{component_name=scorpiomwA_18MHz_mmcm,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=PLL,num_out_clk=2,clkin1_period=10.0,clkin2_period=10.0,use_power_down=false,use_reset=true,use_locked=true,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}";
end scorpiomwA_18MHz_mmcm;

architecture STRUCTURE of scorpiomwA_18MHz_mmcm is
begin
U0: entity work.scorpiomwA_18MHz_mmcmscorpiomwA_18MHz_mmcm_clk_wiz
    port map (
      adc_phase_clk => adc_phase_clk,
      clk_in => clk_in,
      locked => locked,
      mclk_source => mclk_source,
      reset => reset
    );
end STRUCTURE;
