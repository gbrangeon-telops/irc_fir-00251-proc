-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Wed Mar 30 11:43:57 2016
-- Host        : TELOPS230 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim D:/telops/FIR-00251-Proc/IP/clink_ch/clink_ch_funcsim.vhdl
-- Design      : clink_ch
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \clink_chclink_ch_selectio_wiz__parameterized0\ is
  port (
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 27 downto 0 );
    delay_locked : out STD_LOGIC;
    ref_clock : in STD_LOGIC;
    bitslip : in STD_LOGIC;
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    clock_enable : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \clink_chclink_ch_selectio_wiz__parameterized0\ : entity is "clink_ch_selectio_wiz";
  attribute SYS_W : integer;
  attribute SYS_W of \clink_chclink_ch_selectio_wiz__parameterized0\ : entity is 4;
  attribute DEV_W : integer;
  attribute DEV_W of \clink_chclink_ch_selectio_wiz__parameterized0\ : entity is 28;
end \clink_chclink_ch_selectio_wiz__parameterized0\;

architecture STRUCTURE of \clink_chclink_ch_selectio_wiz__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal DDLY : STD_LOGIC;
  signal IDATAIN : STD_LOGIC;
  signal O : STD_LOGIC;
  signal ce_in_uc : STD_LOGIC;
  signal inc_in_uc : STD_LOGIC;
  signal \n_0_pins[1].ibufds_inst\ : STD_LOGIC;
  signal \n_0_pins[1].idelaye2_bus\ : STD_LOGIC;
  signal \n_0_pins[2].ibufds_inst\ : STD_LOGIC;
  signal \n_0_pins[2].idelaye2_bus\ : STD_LOGIC;
  signal \n_0_pins[3].ibufds_inst\ : STD_LOGIC;
  signal \n_0_pins[3].idelaye2_bus\ : STD_LOGIC;
  signal regrst_in_uc : STD_LOGIC;
  signal \NLW_pins[0].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_pins[0].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_pins[1].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_pins[2].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_pins[3].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  attribute IODELAY_GROUP : string;
  attribute IODELAY_GROUP of delayctrl : label is "clink_ch_group";
  attribute box_type : string;
  attribute box_type of delayctrl : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of \pins[0].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "AUTO";
  attribute box_type of \pins[0].ibufds_inst\ : label is "PRIMITIVE";
  attribute IODELAY_GROUP of \pins[0].idelaye2_bus\ : label is "clink_ch_group";
  attribute box_type of \pins[0].idelaye2_bus\ : label is "PRIMITIVE";
  attribute box_type of \pins[0].iserdese2_master\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[1].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[1].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[1].ibufds_inst\ : label is "AUTO";
  attribute box_type of \pins[1].ibufds_inst\ : label is "PRIMITIVE";
  attribute IODELAY_GROUP of \pins[1].idelaye2_bus\ : label is "clink_ch_group";
  attribute box_type of \pins[1].idelaye2_bus\ : label is "PRIMITIVE";
  attribute box_type of \pins[1].iserdese2_master\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[2].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[2].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[2].ibufds_inst\ : label is "AUTO";
  attribute box_type of \pins[2].ibufds_inst\ : label is "PRIMITIVE";
  attribute IODELAY_GROUP of \pins[2].idelaye2_bus\ : label is "clink_ch_group";
  attribute box_type of \pins[2].idelaye2_bus\ : label is "PRIMITIVE";
  attribute box_type of \pins[2].iserdese2_master\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[3].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[3].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[3].ibufds_inst\ : label is "AUTO";
  attribute box_type of \pins[3].ibufds_inst\ : label is "PRIMITIVE";
  attribute IODELAY_GROUP of \pins[3].idelaye2_bus\ : label is "clink_ch_group";
  attribute box_type of \pins[3].idelaye2_bus\ : label is "PRIMITIVE";
  attribute box_type of \pins[3].iserdese2_master\ : label is "PRIMITIVE";
  attribute box_type of ref_clk_bufg : label is "PRIMITIVE";
begin
  ce_in_uc <= 'Z';
  inc_in_uc <= 'Z';
  regrst_in_uc <= 'Z';
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
delayctrl: unisim.vcomponents.IDELAYCTRL
    port map (
      RDY => delay_locked,
      REFCLK => O,
      RST => io_reset
    );
\pins[0].ibufds_inst\: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE"
    )
    port map (
      I => data_in_from_pins_p(0),
      IB => data_in_from_pins_n(0),
      O => IDATAIN
    );
\pins[0].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 23,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => clk_div_in,
      CE => ce_in_uc,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_pins[0].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => DDLY,
      IDATAIN => IDATAIN,
      INC => inc_in_uc,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => regrst_in_uc
    );
\pins[0].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "SDR",
      DATA_WIDTH => 7,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
    port map (
      BITSLIP => bitslip,
      CE1 => clock_enable,
      CE2 => clock_enable,
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => \<const0>\,
      D => \<const0>\,
      DDLY => DDLY,
      DYNCLKDIVSEL => \<const0>\,
      DYNCLKSEL => \<const0>\,
      O => \NLW_pins[0].iserdese2_master_O_UNCONNECTED\,
      OCLK => \<const0>\,
      OCLKB => \<const0>\,
      OFB => \<const0>\,
      Q1 => data_in_to_device(24),
      Q2 => data_in_to_device(20),
      Q3 => data_in_to_device(16),
      Q4 => data_in_to_device(12),
      Q5 => data_in_to_device(8),
      Q6 => data_in_to_device(4),
      Q7 => data_in_to_device(0),
      Q8 => \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => \<const0>\,
      SHIFTIN2 => \<const0>\,
      SHIFTOUT1 => \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[1].ibufds_inst\: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE"
    )
    port map (
      I => data_in_from_pins_p(1),
      IB => data_in_from_pins_n(1),
      O => \n_0_pins[1].ibufds_inst\
    );
\pins[1].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 23,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => clk_div_in,
      CE => ce_in_uc,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_pins[1].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => \n_0_pins[1].idelaye2_bus\,
      IDATAIN => \n_0_pins[1].ibufds_inst\,
      INC => inc_in_uc,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => regrst_in_uc
    );
\pins[1].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "SDR",
      DATA_WIDTH => 7,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
    port map (
      BITSLIP => bitslip,
      CE1 => clock_enable,
      CE2 => clock_enable,
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => \<const0>\,
      D => \<const0>\,
      DDLY => \n_0_pins[1].idelaye2_bus\,
      DYNCLKDIVSEL => \<const0>\,
      DYNCLKSEL => \<const0>\,
      O => \NLW_pins[1].iserdese2_master_O_UNCONNECTED\,
      OCLK => \<const0>\,
      OCLKB => \<const0>\,
      OFB => \<const0>\,
      Q1 => data_in_to_device(25),
      Q2 => data_in_to_device(21),
      Q3 => data_in_to_device(17),
      Q4 => data_in_to_device(13),
      Q5 => data_in_to_device(9),
      Q6 => data_in_to_device(5),
      Q7 => data_in_to_device(1),
      Q8 => \NLW_pins[1].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => \<const0>\,
      SHIFTIN2 => \<const0>\,
      SHIFTOUT1 => \NLW_pins[1].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[1].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[2].ibufds_inst\: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE"
    )
    port map (
      I => data_in_from_pins_p(2),
      IB => data_in_from_pins_n(2),
      O => \n_0_pins[2].ibufds_inst\
    );
\pins[2].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 23,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => clk_div_in,
      CE => ce_in_uc,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_pins[2].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => \n_0_pins[2].idelaye2_bus\,
      IDATAIN => \n_0_pins[2].ibufds_inst\,
      INC => inc_in_uc,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => regrst_in_uc
    );
\pins[2].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "SDR",
      DATA_WIDTH => 7,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
    port map (
      BITSLIP => bitslip,
      CE1 => clock_enable,
      CE2 => clock_enable,
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => \<const0>\,
      D => \<const0>\,
      DDLY => \n_0_pins[2].idelaye2_bus\,
      DYNCLKDIVSEL => \<const0>\,
      DYNCLKSEL => \<const0>\,
      O => \NLW_pins[2].iserdese2_master_O_UNCONNECTED\,
      OCLK => \<const0>\,
      OCLKB => \<const0>\,
      OFB => \<const0>\,
      Q1 => data_in_to_device(26),
      Q2 => data_in_to_device(22),
      Q3 => data_in_to_device(18),
      Q4 => data_in_to_device(14),
      Q5 => data_in_to_device(10),
      Q6 => data_in_to_device(6),
      Q7 => data_in_to_device(2),
      Q8 => \NLW_pins[2].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => \<const0>\,
      SHIFTIN2 => \<const0>\,
      SHIFTOUT1 => \NLW_pins[2].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[2].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[3].ibufds_inst\: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE"
    )
    port map (
      I => data_in_from_pins_p(3),
      IB => data_in_from_pins_n(3),
      O => \n_0_pins[3].ibufds_inst\
    );
\pins[3].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 23,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => clk_div_in,
      CE => ce_in_uc,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_pins[3].idelaye2_bus_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => \n_0_pins[3].idelaye2_bus\,
      IDATAIN => \n_0_pins[3].ibufds_inst\,
      INC => inc_in_uc,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => regrst_in_uc
    );
\pins[3].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "SDR",
      DATA_WIDTH => 7,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
    port map (
      BITSLIP => bitslip,
      CE1 => clock_enable,
      CE2 => clock_enable,
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => \<const0>\,
      D => \<const0>\,
      DDLY => \n_0_pins[3].idelaye2_bus\,
      DYNCLKDIVSEL => \<const0>\,
      DYNCLKSEL => \<const0>\,
      O => \NLW_pins[3].iserdese2_master_O_UNCONNECTED\,
      OCLK => \<const0>\,
      OCLKB => \<const0>\,
      OFB => \<const0>\,
      Q1 => data_in_to_device(27),
      Q2 => data_in_to_device(23),
      Q3 => data_in_to_device(19),
      Q4 => data_in_to_device(15),
      Q5 => data_in_to_device(11),
      Q6 => data_in_to_device(7),
      Q7 => data_in_to_device(3),
      Q8 => \NLW_pins[3].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => \<const0>\,
      SHIFTIN2 => \<const0>\,
      SHIFTOUT1 => \NLW_pins[3].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[3].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
ref_clk_bufg: unisim.vcomponents.BUFG
    port map (
      I => ref_clock,
      O => O
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity clink_ch is
  port (
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 27 downto 0 );
    delay_locked : out STD_LOGIC;
    ref_clock : in STD_LOGIC;
    bitslip : in STD_LOGIC;
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    clock_enable : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of clink_ch : entity is true;
  attribute SYS_W : integer;
  attribute SYS_W of clink_ch : entity is 4;
  attribute DEV_W : integer;
  attribute DEV_W of clink_ch : entity is 28;
  attribute core_generation_info : string;
  attribute core_generation_info of clink_ch : entity is "clink_ch,selectio_wiz_v5_1,{component_name=clink_ch,bus_dir=INPUTS,bus_sig_type=DIFF,bus_io_std=LVDS_25,use_serialization=true,use_phase_detector=false,serialization_factor=7,enable_bitslip=false,enable_train=false,system_data_width=4,bus_in_delay=NONE,bus_out_delay=NONE,clk_sig_type=SINGLE,clk_io_std=LVCMOS18,clk_buf=BUFIO2,active_edge=RISING,clk_delay=NONE,selio_bus_in_delay=FIXED,selio_bus_out_delay=NONE,selio_clk_buf=MMCM,selio_active_edge=SDR,selio_ddr_alignment=SAME_EDGE_PIPELINED,selio_oddr_alignment=SAME_EDGE,ddr_alignment=C0,selio_interface_type=NETWORKING,interface_type=NETWORKING,selio_bus_in_tap=23,selio_bus_out_tap=0,selio_clk_io_std=HSTL_I,selio_clk_sig_type=SINGLE}";
end clink_ch;

architecture STRUCTURE of clink_ch is
  attribute DEV_W of U0 : label is 28;
  attribute SYS_W of U0 : label is 4;
begin
U0: entity work.\clink_chclink_ch_selectio_wiz__parameterized0\
    port map (
      bitslip => bitslip,
      clk_div_in => clk_div_in,
      clk_in => clk_in,
      clock_enable => clock_enable,
      data_in_from_pins_n(3 downto 0) => data_in_from_pins_n(3 downto 0),
      data_in_from_pins_p(3 downto 0) => data_in_from_pins_p(3 downto 0),
      data_in_to_device(27 downto 0) => data_in_to_device(27 downto 0),
      delay_locked => delay_locked,
      io_reset => io_reset,
      ref_clock => ref_clock
    );
end STRUCTURE;
