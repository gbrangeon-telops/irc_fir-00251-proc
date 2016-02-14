-------------------------------------------------------------------
-- System Generator version 2013.4 VHDL source file.
--
-- Copyright(C) 2013 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2013 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

-- Generated from Simulink block "histogram_AXIS_TMI/AXIS16_Histogram/Data_to_Addr"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity data_to_addr_b771ca29fb is
  port (
    msb_pos: in std_logic_vector(1 downto 0);
    data: in std_logic_vector(15 downto 0);
    add: out std_logic_vector(6 downto 0)
  );
end data_to_addr_b771ca29fb;

architecture structural of data_to_addr_b771ca29fb is
  signal xtoadd_y_net: std_logic_vector(6 downto 0);
  signal xtoadd1_y_net: std_logic_vector(6 downto 0);
  signal xtoadd2_y_net: std_logic_vector(6 downto 0);
  signal xtoadd3_y_net: std_logic_vector(6 downto 0);
  signal msb_pos_net: std_logic_vector(1 downto 0);
  signal rx_tdata_net: std_logic_vector(15 downto 0);
  signal mux4_y_net: std_logic_vector(6 downto 0);

begin
  msb_pos_net <= msb_pos;
  rx_tdata_net <= data;
  add <= mux4_y_net;

  mux4: entity work.sysgen_mux_d76f43616f
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel => msb_pos_net,
      d0 => xtoadd_y_net,
      d1 => xtoadd1_y_net,
      d2 => xtoadd2_y_net,
      d3 => xtoadd3_y_net,
      y => mux4_y_net
  );

  xtoadd: entity work.xlslice_histogram_axis_tmi
    generic map (
      new_lsb => 6,
      new_msb => 12,
      x_width => 16,
      y_width => 7)
    port map (
      x => rx_tdata_net,
      y => xtoadd_y_net
  );

  xtoadd1: entity work.xlslice_histogram_axis_tmi
    generic map (
      new_lsb => 7,
      new_msb => 13,
      x_width => 16,
      y_width => 7)
    port map (
      x => rx_tdata_net,
      y => xtoadd1_y_net
  );

  xtoadd2: entity work.xlslice_histogram_axis_tmi
    generic map (
      new_lsb => 8,
      new_msb => 14,
      x_width => 16,
      y_width => 7)
    port map (
      x => rx_tdata_net,
      y => xtoadd2_y_net
  );

  xtoadd3: entity work.xlslice_histogram_axis_tmi
    generic map (
      new_lsb => 9,
      new_msb => 15,
      x_width => 16,
      y_width => 7)
    port map (
      x => rx_tdata_net,
      y => xtoadd3_y_net
  );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI/AXIS16_Histogram/HistogramState/SOF_GEN"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity sof_gen_x1_985fc0bb07 is
  port (
    clk_1: in std_logic;
    ce_1: in std_logic;
    areset: in std_logic;
    dval: in std_logic;
    tlast: in std_logic;
    sof: out std_logic
  );
end sof_gen_x1_985fc0bb07;

architecture structural of sof_gen_x1_985fc0bb07 is
  signal clk_1_net: std_logic;
  signal ce_1_net: std_logic;
  signal register1_q_net: std_logic;
  signal areset_net: std_logic;
  signal and_y_net: std_logic;
  signal d8_q_net: std_logic;
  signal logical13_y_net: std_logic;

begin
  clk_1_net <= clk_1;
  ce_1_net <= ce_1;
  areset_net <= areset;
  and_y_net <= dval;
  d8_q_net <= tlast;
  sof <= logical13_y_net;

  logical13: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => register1_q_net,
      d1(0) => and_y_net,
      y(0) => logical13_y_net
  );

  register1: entity work.xlregister_histogram_axis_tmi
    generic map (
      d_width => 1,
      init_value => b"1")
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      d(0) => d8_q_net,
      rst(0) => areset_net,
      en(0) => and_y_net,
      q(0) => register1_q_net
  );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI/AXIS16_Histogram/HistogramState"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity histogramstate_e4048d08ea is
  port (
    clk_1: in std_logic;
    ce_1: in std_logic;
    ext_data_in2: in std_logic_vector(31 downto 0);
    areset: in std_logic;
    ext_data_in: in std_logic_vector(31 downto 0);
    dval: in std_logic;
    clearmem: in std_logic;
    eof: in std_logic;
    hist_rdy: out std_logic;
    wea: out std_logic;
    web: out std_logic;
    clearadd: out std_logic_vector(6 downto 0);
    timestamp: out std_logic_vector(31 downto 0);
    ext_data_out: out std_logic_vector(31 downto 0);
    ext_data_out2: out std_logic_vector(31 downto 0)
  );
end histogramstate_e4048d08ea;

architecture structural of histogramstate_e4048d08ea is
  signal clk_1_net: std_logic;
  signal ce_1_net: std_logic;
  signal constant_op_net_x0: std_logic;
  signal constant1_op_net: std_logic;
  signal constant2_op_net: std_logic_vector(6 downto 0);
  signal inverter1_op_net: std_logic;
  signal inverter2_op_net: std_logic;
  signal inverter3_op_net: std_logic;
  signal inverter4_op_net: std_logic;
  signal inverter5_op_net: std_logic;
  signal inverter7_op_net: std_logic;
  signal logical_y_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical11_y_net: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net: std_logic;
  signal logical4_y_net: std_logic;
  signal logical5_y_net: std_logic;
  signal logical6_y_net: std_logic;
  signal logical7_y_net: std_logic;
  signal relational_op_net: std_logic;
  signal timestamp_cntr_op_net: std_logic_vector(31 downto 0);
  signal d1_q_net: std_logic;
  signal d2_q_net: std_logic;
  signal inverter8_op_net: std_logic;
  signal d15_q_net: std_logic_vector(31 downto 0);
  signal areset_net: std_logic;
  signal d14_q_net: std_logic_vector(31 downto 0);
  signal and_y_net: std_logic;
  signal d9_q_net: std_logic;
  signal d8_q_net: std_logic;
  signal mux_y_net: std_logic;
  signal logical8_y_net: std_logic;
  signal logical9_y_net: std_logic;
  signal clrmem_cntr_op_net: std_logic_vector(6 downto 0);
  signal reg1_q_net: std_logic_vector(31 downto 0);
  signal reg2_q_net: std_logic_vector(31 downto 0);
  signal reg3_q_net: std_logic_vector(31 downto 0);
  signal logical13_y_net: std_logic;

begin
  clk_1_net <= clk_1;
  ce_1_net <= ce_1;
  d15_q_net <= ext_data_in2;
  areset_net <= areset;
  d14_q_net <= ext_data_in;
  and_y_net <= dval;
  d9_q_net <= clearmem;
  d8_q_net <= eof;
  hist_rdy <= mux_y_net;
  wea <= logical8_y_net;
  web <= logical9_y_net;
  clearadd <= clrmem_cntr_op_net;
  timestamp <= reg1_q_net;
  ext_data_out <= reg2_q_net;
  ext_data_out2 <= reg3_q_net;

  constant_x0: entity work.sysgen_constant_e5febd1393
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => constant_op_net_x0
  );

  constant1: entity work.sysgen_constant_caa057be3c
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => constant1_op_net
  );

  constant2: entity work.sysgen_constant_c5b64e3de8
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op => constant2_op_net
  );

  inverter1: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => logical1_y_net,
      op(0) => inverter1_op_net
  );

  inverter2: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => mux_y_net,
      op(0) => inverter2_op_net
  );

  inverter3: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => logical9_y_net,
      op(0) => inverter3_op_net
  );

  inverter4: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => logical9_y_net,
      op(0) => inverter4_op_net
  );

  inverter5: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => logical2_y_net,
      op(0) => inverter5_op_net
  );

  inverter7: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => mux_y_net,
      op(0) => inverter7_op_net
  );

  logical: entity work.sysgen_logical_3029227866
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => inverter1_op_net,
      d1(0) => inverter3_op_net,
      d2(0) => logical3_y_net,
      y(0) => logical_y_net
  );

  logical1: entity work.sysgen_logical_3c7c5a426a
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      d0(0) => d8_q_net,
      d1(0) => logical2_y_net,
      d2(0) => and_y_net,
      y(0) => logical1_y_net
  );

  logical11: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => logical7_y_net,
      d1(0) => inverter7_op_net,
      y(0) => logical11_y_net
  );

  logical2: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => d2_q_net,
      d1(0) => inverter2_op_net,
      y(0) => logical2_y_net
  );

  logical3: entity work.sysgen_logical_046a394c83
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => logical7_y_net,
      d1(0) => d2_q_net,
      y(0) => logical3_y_net
  );

  logical4: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => logical1_y_net,
      d1(0) => d2_q_net,
      y(0) => logical4_y_net
  );

  logical5: entity work.sysgen_logical_046a394c83
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => logical4_y_net,
      d1(0) => mux_y_net,
      y(0) => logical5_y_net
  );

  logical6: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => inverter4_op_net,
      d1(0) => logical5_y_net,
      y(0) => logical6_y_net
  );

  logical7: entity work.sysgen_logical_446d5a2873
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => logical13_y_net,
      d1(0) => inverter5_op_net,
      d2(0) => and_y_net,
      d3(0) => inverter8_op_net,
      y(0) => logical7_y_net
  );

  logical8: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => logical2_y_net,
      d1(0) => d1_q_net,
      y(0) => logical8_y_net
  );

  logical9: entity work.sysgen_logical_046a394c83
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => d9_q_net,
      d1(0) => relational_op_net,
      y(0) => logical9_y_net
  );

  mux: entity work.sysgen_mux_30e91dd528
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      sel(0) => logical6_y_net,
      d0(0) => constant_op_net_x0,
      d1(0) => constant1_op_net,
      y(0) => mux_y_net
  );

  relational: entity work.sysgen_relational_897dad502c
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      a => clrmem_cntr_op_net,
      b => constant2_op_net,
      op(0) => relational_op_net
  );

  timestamp_cntr: entity work.sysgen_counter_bc3c6a5dd3
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      op => timestamp_cntr_op_net
  );

  clrmem_cntr: entity work.xlcounter_limit_histogram_axis_tmi
    generic map (
      cnt_15_0 => 127,
      cnt_31_16 => 0,
      cnt_47_32 => 0,
      cnt_63_48 => 0,
      core_name0 => "histogram_axis_tmi_c_counter_binary_v12_0_0",
      count_limited => 0,
      op_arith => xlUnsigned,
      op_width => 7)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      rst => "0",
      clr => '0',
      en(0) => logical9_y_net,
      op => clrmem_cntr_op_net
  );

  d1: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => and_y_net,
      q(0) => d1_q_net
  );

  d2: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => logical_y_net,
      q(0) => d2_q_net
  );

  reg1: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 32)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      rst => '1',
      d => timestamp_cntr_op_net,
      en => logical11_y_net,
      q => reg1_q_net
  );

  reg2: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 32)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      rst => '1',
      d => d14_q_net,
      en => logical11_y_net,
      q => reg2_q_net
  );

  reg3: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 32)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      rst => '1',
      d => d15_q_net,
      en => logical11_y_net,
      q => reg3_q_net
  );

  inverter8: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => logical9_y_net,
      op(0) => inverter8_op_net
  );

  sof_gen_x1: entity work.sof_gen_x1_985fc0bb07
    port map (
      clk_1 => clk_1_net,
      ce_1 => ce_1_net,
      areset => areset_net,
      dval => and_y_net,
      tlast => d8_q_net,
      sof => logical13_y_net
    );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI/AXIS16_Histogram/TMI"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity tmi_9e0b22fd09 is
  port (
    clk_1: in std_logic;
    ce_1: in std_logic;
    areset: in std_logic;
    hist_rdy: in std_logic;
    doutb: in std_logic_vector(20 downto 0);
    dval: in std_logic;
    rnw: in std_logic;
    add_in: in std_logic_vector(6 downto 0);
    busy: out std_logic;
    idle: out std_logic;
    error: out std_logic;
    rd_dval: out std_logic
  );
end tmi_9e0b22fd09;

architecture structural of tmi_9e0b22fd09 is
  signal clk_1_net: std_logic;
  signal ce_1_net: std_logic;
  signal and1_y_net: std_logic;
  signal and2_y_net: std_logic;
  signal and3_y_net: std_logic;
  signal and4_y_net: std_logic;
  signal and5_y_net: std_logic;
  signal c1_op_net: std_logic;
  signal c2_op_net: std_logic;
  signal c3_op_net: std_logic;
  signal c4_op_net: std_logic;
  signal d1_q_net_x0: std_logic;
  signal d5_q_net: std_logic;
  signal inv1_op_net: std_logic;
  signal inv2_op_net: std_logic;
  signal inv3_op_net: std_logic;
  signal inv4_op_net: std_logic;
  signal inv5_op_net: std_logic;
  signal areset_net: std_logic;
  signal mux_y_net: std_logic;
  signal dp_ram_doutb_net: std_logic_vector(20 downto 0);
  signal d12_q_net: std_logic;
  signal d11_q_net: std_logic;
  signal d10_q_net: std_logic_vector(6 downto 0);
  signal mux_y_net_x1: std_logic;
  signal mux1_y_net_x0: std_logic;
  signal mux3_y_net_x0: std_logic;
  signal mux2_y_net_x0: std_logic;

begin
  clk_1_net <= clk_1;
  ce_1_net <= ce_1;
  areset_net <= areset;
  mux_y_net <= hist_rdy;
  dp_ram_doutb_net <= doutb;
  d12_q_net <= dval;
  d11_q_net <= rnw;
  d10_q_net <= add_in;
  busy <= mux_y_net_x1;
  idle <= mux1_y_net_x0;
  error <= mux3_y_net_x0;
  rd_dval <= mux2_y_net_x0;

  mux: entity work.sysgen_mux_a7539e4023
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => areset_net,
      d0(0) => and3_y_net,
      d1(0) => c3_op_net,
      y(0) => mux_y_net_x1
  );

  mux1: entity work.sysgen_mux_a7539e4023
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => areset_net,
      d0(0) => inv1_op_net,
      d1(0) => c1_op_net,
      y(0) => mux1_y_net_x0
  );

  mux2: entity work.sysgen_mux_a7539e4023
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => areset_net,
      d0(0) => d1_q_net_x0,
      d1(0) => c2_op_net,
      y(0) => mux2_y_net_x0
  );

  mux3: entity work.sysgen_mux_a7539e4023
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => areset_net,
      d0(0) => and4_y_net,
      d1(0) => c4_op_net,
      y(0) => mux3_y_net_x0
  );

  and1: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => d12_q_net,
      d1(0) => d11_q_net,
      y(0) => and1_y_net
  );

  and2: entity work.sysgen_logical_046a394c83
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => and1_y_net,
      d1(0) => d5_q_net,
      y(0) => and2_y_net
  );

  and3: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => inv2_op_net,
      d1(0) => and1_y_net,
      y(0) => and3_y_net
  );

  and4: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => d12_q_net,
      d1(0) => inv3_op_net,
      y(0) => and4_y_net
  );

  and5: entity work.sysgen_logical_3029227866
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => and1_y_net,
      d1(0) => inv4_op_net,
      d2(0) => inv5_op_net,
      y(0) => and5_y_net
  );

  c1: entity work.sysgen_constant_e5febd1393
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => c1_op_net
  );

  c2: entity work.sysgen_constant_e5febd1393
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => c2_op_net
  );

  c3: entity work.sysgen_constant_caa057be3c
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => c3_op_net
  );

  c4: entity work.sysgen_constant_e5febd1393
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => c4_op_net
  );

  d1: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => and5_y_net,
      q(0) => d1_q_net_x0
  );

  d5: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => and1_y_net,
      q(0) => d5_q_net
  );

  inv1: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => and2_y_net,
      op(0) => inv1_op_net
  );

  inv2: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => mux_y_net,
      op(0) => inv2_op_net
  );

  inv3: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => d11_q_net,
      op(0) => inv3_op_net
  );

  inv4: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => and3_y_net,
      op(0) => inv4_op_net
  );

  inv5: entity work.sysgen_inverter_21617b5822
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      ip(0) => inv1_op_net,
      op(0) => inv5_op_net
  );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI/AXIS16_Histogram"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity axis16_histogram_ec93b64bc0 is
  port (
    clk_1: in std_logic;
    ce_1: in std_logic;
    tmi_mosi_rnw: in std_logic;
    tmi_mosi_dval: in std_logic;
    tmi_mosi_add: in std_logic_vector(6 downto 0);
    rx_tvalid: in std_logic;
    rx_tready: in std_logic;
    rx_tlast: in std_logic;
    rx_tdata: in std_logic_vector(15 downto 0);
    msb_pos: in std_logic_vector(1 downto 0);
    ext_data_in2_x1: in std_logic_vector(31 downto 0);
    ext_data_in_x1: in std_logic_vector(31 downto 0);
    clear_mem: in std_logic;
    areset_x6: in std_logic;
    ext_data_out_x3: out std_logic_vector(31 downto 0);
    ext_data_out2_x3: out std_logic_vector(31 downto 0);
    histogram_rdy: out std_logic;
    timestamp_x3: out std_logic_vector(31 downto 0);
    tmi_miso_busy: out std_logic;
    tmi_miso_error: out std_logic;
    tmi_miso_idle: out std_logic;
    tmi_miso_rd_data: out std_logic_vector(20 downto 0);
    tmi_miso_rd_dval: out std_logic
  );
end axis16_histogram_ec93b64bc0;

architecture structural of axis16_histogram_ec93b64bc0 is
  signal clk_1_net: std_logic;
  signal ce_1_net: std_logic;
  signal addsub1_s_net: std_logic_vector(20 downto 0);
  signal constant_op_net: std_logic;
  signal mux_y_net_x0: std_logic_vector(20 downto 0);
  signal mux1_y_net: std_logic_vector(6 downto 0);
  signal mux2_y_net: std_logic_vector(6 downto 0);
  signal mux3_y_net: std_logic_vector(6 downto 0);
  signal relational_op_net_x0: std_logic;
  signal and_y_net: std_logic;
  signal and1_y_net_x0: std_logic;
  signal c1_op_net_x0: std_logic_vector(6 downto 0);
  signal c3_op_net_x0: std_logic_vector(20 downto 0);
  signal d1_q_net_x1: std_logic_vector(6 downto 0);
  signal d10_q_net: std_logic_vector(6 downto 0);
  signal d11_q_net: std_logic;
  signal d12_q_net: std_logic;
  signal d13_q_net: std_logic;
  signal d14_q_net: std_logic_vector(31 downto 0);
  signal d15_q_net: std_logic_vector(31 downto 0);
  signal d2_q_net_x0: std_logic_vector(6 downto 0);
  signal d3_q_net: std_logic_vector(20 downto 0);
  signal d4_q_net: std_logic_vector(6 downto 0);
  signal d5_q_net_x0: std_logic;
  signal d6_q_net: std_logic;
  signal d8_q_net: std_logic;
  signal d9_q_net: std_logic;
  signal dp_ram_douta_net: std_logic_vector(20 downto 0);
  signal dp_ram_doutb_net: std_logic_vector(20 downto 0);
  signal tmi_mosi_rnw_net: std_logic;
  signal tmi_mosi_dval_net: std_logic;
  signal tmi_mosi_add_net: std_logic_vector(6 downto 0);
  signal rx_tvalid_net: std_logic;
  signal rx_tready_net: std_logic;
  signal rx_tlast_net: std_logic;
  signal rx_tdata_net: std_logic_vector(15 downto 0);
  signal msb_pos_net: std_logic_vector(1 downto 0);
  signal ext_data_in2_net: std_logic_vector(31 downto 0);
  signal ext_data_in_net: std_logic_vector(31 downto 0);
  signal clear_mem_net: std_logic;
  signal areset_net: std_logic;
  signal ext_data_out_net: std_logic_vector(31 downto 0);
  signal ext_data_out2_net: std_logic_vector(31 downto 0);
  signal histogram_rdy_net: std_logic;
  signal timestamp_net: std_logic_vector(31 downto 0);
  signal tmi_miso_busy_net: std_logic;
  signal tmi_miso_error_net: std_logic;
  signal tmi_miso_idle_net: std_logic;
  signal tmi_miso_rd_data_net: std_logic_vector(20 downto 0);
  signal tmi_miso_rd_dval_net: std_logic;
  signal mux4_y_net: std_logic_vector(6 downto 0);
  signal mux_y_net: std_logic;
  signal logical8_y_net: std_logic;
  signal logical9_y_net: std_logic;
  signal clrmem_cntr_op_net: std_logic_vector(6 downto 0);
  signal reg1_q_net: std_logic_vector(31 downto 0);
  signal reg2_q_net: std_logic_vector(31 downto 0);
  signal reg3_q_net: std_logic_vector(31 downto 0);
  signal mux_y_net_x1: std_logic;
  signal mux1_y_net_x0: std_logic;
  signal mux3_y_net_x0: std_logic;
  signal mux2_y_net_x0: std_logic;

begin
  clk_1_net <= clk_1;
  ce_1_net <= ce_1;
  tmi_mosi_rnw_net <= tmi_mosi_rnw;
  tmi_mosi_dval_net <= tmi_mosi_dval;
  tmi_mosi_add_net <= tmi_mosi_add;
  rx_tvalid_net <= rx_tvalid;
  rx_tready_net <= rx_tready;
  rx_tlast_net <= rx_tlast;
  rx_tdata_net <= rx_tdata;
  msb_pos_net <= msb_pos;
  ext_data_in2_net <= ext_data_in2_x1;
  ext_data_in_net <= ext_data_in_x1;
  clear_mem_net <= clear_mem;
  areset_net <= areset_x6;
  ext_data_out_x3 <= ext_data_out_net;
  ext_data_out2_x3 <= ext_data_out2_net;
  histogram_rdy <= histogram_rdy_net;
  timestamp_x3 <= timestamp_net;
  tmi_miso_busy <= tmi_miso_busy_net;
  tmi_miso_error <= tmi_miso_error_net;
  tmi_miso_idle <= tmi_miso_idle_net;
  tmi_miso_rd_data <= tmi_miso_rd_data_net;
  tmi_miso_rd_dval <= tmi_miso_rd_dval_net;
  ext_data_out_net <= reg2_q_net;
  ext_data_out2_net <= reg3_q_net;
  histogram_rdy_net <= mux_y_net;
  timestamp_net <= reg1_q_net;
  tmi_miso_busy_net <= mux_y_net_x1;
  tmi_miso_error_net <= mux3_y_net_x0;
  tmi_miso_idle_net <= mux1_y_net_x0;
  tmi_miso_rd_data_net <= dp_ram_doutb_net;
  tmi_miso_rd_dval_net <= mux2_y_net_x0;

  addsub1: entity work.xladdsub_histogram_axis_tmi
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 21,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 1,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 22,
      core_name0 => "histogram_axis_tmi_c_addsub_v12_0_0",
      extra_registers => 0,
      full_s_arith => 1,
      full_s_width => 22,
      latency => 0,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 21)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      en => "1",
      a => mux_y_net_x0,
      b(0) => constant_op_net,
      s => addsub1_s_net
  );

  constant_x0: entity work.sysgen_constant_caa057be3c
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op(0) => constant_op_net
  );

  mux: entity work.sysgen_mux_8ec97c9fb1
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => and1_y_net_x0,
      d0 => dp_ram_doutb_net,
      d1 => d3_q_net,
      y => mux_y_net_x0
  );

  mux1: entity work.sysgen_mux_f0fafa8b45
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => mux_y_net,
      d0 => mux2_y_net,
      d1 => d10_q_net,
      y => mux1_y_net
  );

  mux2: entity work.sysgen_mux_f0fafa8b45
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => and_y_net,
      d0 => c1_op_net_x0,
      d1 => d4_q_net,
      y => mux2_y_net
  );

  mux3: entity work.sysgen_mux_f0fafa8b45
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      sel(0) => logical9_y_net,
      d0 => mux1_y_net,
      d1 => clrmem_cntr_op_net,
      y => mux3_y_net
  );

  relational: entity work.sysgen_relational_d33edfebda
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      clr => '0',
      a => d1_q_net_x1,
      b => mux2_y_net,
      en(0) => logical8_y_net,
      op(0) => relational_op_net_x0
  );

  and_x0: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => d5_q_net_x0,
      d1(0) => d6_q_net,
      y(0) => and_y_net
  );

  and1: entity work.sysgen_logical_d533be9fdc
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      d0(0) => relational_op_net_x0,
      d1(0) => d13_q_net,
      y(0) => and1_y_net_x0
  );

  c1: entity work.sysgen_constant_c5b64e3de8
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op => c1_op_net_x0
  );

  c3: entity work.sysgen_constant_f8464393c3
    port map (
      clk => '0',
      ce => '0',
      clr => '0',
      op => c3_op_net_x0
  );

  d1: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 7)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => mux2_y_net,
      q => d1_q_net_x1
  );

  d10: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 7)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => tmi_mosi_add_net,
      q => d10_q_net
  );

  d11: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => tmi_mosi_rnw_net,
      q(0) => d11_q_net
  );

  d12: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => tmi_mosi_dval_net,
      q(0) => d12_q_net
  );

  d13: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => logical8_y_net,
      q(0) => d13_q_net
  );

  d14: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 32)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => ext_data_in_net,
      q => d14_q_net
  );

  d15: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 32)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => ext_data_in2_net,
      q => d15_q_net
  );

  d2: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 7)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => mux1_y_net,
      q => d2_q_net_x0
  );

  d3: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 21)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => addsub1_s_net,
      q => d3_q_net
  );

  d4: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 7)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d => mux4_y_net,
      q => d4_q_net
  );

  d5: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => rx_tvalid_net,
      q(0) => d5_q_net_x0
  );

  d6: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => rx_tready_net,
      q(0) => d6_q_net
  );

  d8: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => rx_tlast_net,
      q(0) => d8_q_net
  );

  d9: entity work.xldelay_histogram_axis_tmi
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1)
    port map (
      ce => ce_1_net,
      clk => clk_1_net,
      en => '1',
      rst => '1',
      d(0) => clear_mem_net,
      q(0) => d9_q_net
  );

  dp_ram: entity work.xldpram_histogram_axis_tmi
    generic map (
      c_address_width_a => 7,
      c_address_width_b => 7,
      c_width_a => 21,
      c_width_b => 21,
      core_name0 => "histogram_axis_tmi_blk_mem_gen_v8_1_0",
      latency => 1)
    port map (
      b_ce => ce_1_net,
      b_clk => clk_1_net,
      a_ce => ce_1_net,
      a_clk => clk_1_net,
      ena => "1",
      enb => "1",
      rsta => "0",
      rstb => "0",
      addra => d2_q_net_x0,
      dina => addsub1_s_net,
      wea(0) => logical8_y_net,
      addrb => mux3_y_net,
      dinb => c3_op_net_x0,
      web(0) => logical9_y_net,
      douta => dp_ram_douta_net,
      doutb => dp_ram_doutb_net
  );

  data_to_addr: entity work.data_to_addr_b771ca29fb
    port map (
      msb_pos => msb_pos_net,
      data => rx_tdata_net,
      add => mux4_y_net
    );

  histogramstate: entity work.histogramstate_e4048d08ea
    port map (
      clk_1 => clk_1_net,
      ce_1 => ce_1_net,
      ext_data_in2 => d15_q_net,
      areset => areset_net,
      ext_data_in => d14_q_net,
      dval => and_y_net,
      clearmem => d9_q_net,
      eof => d8_q_net,
      hist_rdy => mux_y_net,
      wea => logical8_y_net,
      web => logical9_y_net,
      clearadd => clrmem_cntr_op_net,
      timestamp => reg1_q_net,
      ext_data_out => reg2_q_net,
      ext_data_out2 => reg3_q_net
    );

  tmi: entity work.tmi_9e0b22fd09
    port map (
      clk_1 => clk_1_net,
      ce_1 => ce_1_net,
      areset => areset_net,
      hist_rdy => mux_y_net,
      doutb => dp_ram_doutb_net,
      dval => d12_q_net,
      rnw => d11_q_net,
      add_in => d10_q_net,
      busy => mux_y_net_x1,
      idle => mux1_y_net_x0,
      error => mux3_y_net_x0,
      rd_dval => mux2_y_net_x0
    );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI/histogram_axis_tmi_struct"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity histogram_axis_tmi_struct is
  port (
    clk_1: in std_logic;
    ce_1: in std_logic;
    tmi_mosi_rnw: in std_logic;
    tmi_mosi_dval: in std_logic;
    tmi_mosi_add: in std_logic_vector(6 downto 0);
    rx_tvalid: in std_logic;
    rx_tready: in std_logic;
    rx_tlast: in std_logic;
    rx_tdata: in std_logic_vector(15 downto 0);
    msb_pos: in std_logic_vector(1 downto 0);
    ext_data_in2_x1: in std_logic_vector(31 downto 0);
    ext_data_in_x1: in std_logic_vector(31 downto 0);
    clear_mem: in std_logic;
    areset_x6: in std_logic;
    ext_data_out_x3: out std_logic_vector(31 downto 0);
    ext_data_out2_x3: out std_logic_vector(31 downto 0);
    histogram_rdy: out std_logic;
    timestamp_x3: out std_logic_vector(31 downto 0);
    tmi_miso_busy: out std_logic;
    tmi_miso_error: out std_logic;
    tmi_miso_idle: out std_logic;
    tmi_miso_rd_data: out std_logic_vector(20 downto 0);
    tmi_miso_rd_dval: out std_logic
  );
end histogram_axis_tmi_struct;

architecture structural of histogram_axis_tmi_struct is
  signal clk_1_net: std_logic;
  signal ce_1_net: std_logic;
  signal tmi_mosi_rnw_net: std_logic;
  signal tmi_mosi_dval_net: std_logic;
  signal tmi_mosi_add_net: std_logic_vector(6 downto 0);
  signal rx_tvalid_net: std_logic;
  signal rx_tready_net: std_logic;
  signal rx_tlast_net: std_logic;
  signal rx_tdata_net: std_logic_vector(15 downto 0);
  signal msb_pos_net: std_logic_vector(1 downto 0);
  signal ext_data_in2_net: std_logic_vector(31 downto 0);
  signal ext_data_in_net: std_logic_vector(31 downto 0);
  signal clear_mem_net: std_logic;
  signal areset_net: std_logic;
  signal ext_data_out_net: std_logic_vector(31 downto 0);
  signal ext_data_out2_net: std_logic_vector(31 downto 0);
  signal histogram_rdy_net: std_logic;
  signal timestamp_net: std_logic_vector(31 downto 0);
  signal tmi_miso_busy_net: std_logic;
  signal tmi_miso_error_net: std_logic;
  signal tmi_miso_idle_net: std_logic;
  signal tmi_miso_rd_data_net: std_logic_vector(20 downto 0);
  signal tmi_miso_rd_dval_net: std_logic;

begin
  clk_1_net <= clk_1;
  ce_1_net <= ce_1;
  tmi_mosi_rnw_net <= tmi_mosi_rnw;
  tmi_mosi_dval_net <= tmi_mosi_dval;
  tmi_mosi_add_net <= tmi_mosi_add;
  rx_tvalid_net <= rx_tvalid;
  rx_tready_net <= rx_tready;
  rx_tlast_net <= rx_tlast;
  rx_tdata_net <= rx_tdata;
  msb_pos_net <= msb_pos;
  ext_data_in2_net <= ext_data_in2_x1;
  ext_data_in_net <= ext_data_in_x1;
  clear_mem_net <= clear_mem;
  areset_net <= areset_x6;
  ext_data_out_x3 <= ext_data_out_net;
  ext_data_out2_x3 <= ext_data_out2_net;
  histogram_rdy <= histogram_rdy_net;
  timestamp_x3 <= timestamp_net;
  tmi_miso_busy <= tmi_miso_busy_net;
  tmi_miso_error <= tmi_miso_error_net;
  tmi_miso_idle <= tmi_miso_idle_net;
  tmi_miso_rd_data <= tmi_miso_rd_data_net;
  tmi_miso_rd_dval <= tmi_miso_rd_dval_net;

  axis16_histogram: entity work.axis16_histogram_ec93b64bc0
    port map (
      clk_1 => clk_1_net,
      ce_1 => ce_1_net,
      tmi_mosi_rnw => tmi_mosi_rnw_net,
      tmi_mosi_dval => tmi_mosi_dval_net,
      tmi_mosi_add => tmi_mosi_add_net,
      rx_tvalid => rx_tvalid_net,
      rx_tready => rx_tready_net,
      rx_tlast => rx_tlast_net,
      rx_tdata => rx_tdata_net,
      msb_pos => msb_pos_net,
      ext_data_in2_x1 => ext_data_in2_net,
      ext_data_in_x1 => ext_data_in_net,
      clear_mem => clear_mem_net,
      areset_x6 => areset_net,
      ext_data_out_x3 => ext_data_out_net,
      ext_data_out2_x3 => ext_data_out2_net,
      histogram_rdy => histogram_rdy_net,
      timestamp_x3 => timestamp_net,
      tmi_miso_busy => tmi_miso_busy_net,
      tmi_miso_error => tmi_miso_error_net,
      tmi_miso_idle => tmi_miso_idle_net,
      tmi_miso_rd_data => tmi_miso_rd_data_net,
      tmi_miso_rd_dval => tmi_miso_rd_dval_net
    );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI/default_clock_driver_histogram_axis_tmi"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity default_clock_driver_histogram_axis_tmi is
  port (
    sysclk: in std_logic;
    sysce: in std_logic;
    sysce_clr: in std_logic;
    ce_1: out std_logic;
    clk_1: out std_logic
  );
end default_clock_driver_histogram_axis_tmi;

architecture structural of default_clock_driver_histogram_axis_tmi is
  signal xlclockdriver_1_clk : std_logic;
  signal xlclockdriver_1_ce : std_logic;

begin
  clk_1 <= xlclockdriver_1_clk;
  ce_1 <= xlclockdriver_1_ce;

  xlclockdriver_1 : entity work.xlclockdriver
    generic map (
      log_2_period => 1,
      period => 1,
      use_bufg => 0
    )
    port map (
      sysce => sysce,
      sysclk => sysclk,
      sysclr => sysce_clr,
      ce => xlclockdriver_1_ce,
      clk => xlclockdriver_1_clk
    );
end structural;


-- Generated from Simulink block "histogram_AXIS_TMI"

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity histogram_axis_tmi is
  port (
    clk: in std_logic;
    tmi_mosi_rnw: in std_logic;
    tmi_mosi_dval: in std_logic;
    tmi_mosi_add: in std_logic_vector(6 downto 0);
    rx_tvalid: in std_logic;
    rx_tready: in std_logic;
    rx_tlast: in std_logic;
    rx_tdata: in std_logic_vector(15 downto 0);
    msb_pos: in std_logic_vector(1 downto 0);
    ext_data_in2_x1: in std_logic_vector(31 downto 0);
    ext_data_in_x1: in std_logic_vector(31 downto 0);
    clear_mem: in std_logic;
    areset_x6: in std_logic;
    ext_data_out_x3: out std_logic_vector(31 downto 0);
    ext_data_out2_x3: out std_logic_vector(31 downto 0);
    histogram_rdy: out std_logic;
    timestamp_x3: out std_logic_vector(31 downto 0);
    tmi_miso_busy: out std_logic;
    tmi_miso_error: out std_logic;
    tmi_miso_idle: out std_logic;
    tmi_miso_rd_data: out std_logic_vector(20 downto 0);
    tmi_miso_rd_dval: out std_logic
  );
end histogram_axis_tmi;

architecture structural of histogram_axis_tmi is
  attribute core_generation_info: string;
  attribute core_generation_info of structural : architecture is "histogram_axis_tmi,sysgen_core_2013_4,{compilation=HDL Netlist,block_icon_display=Default,family=kintex7,part=xc7k160t,speed=-1,package=fbg676,synthesis_tool=Vivado,synthesis_language=vhdl,hdl_library=work,proj_type=Vivado,synth_file=Vivado Synthesis Defaults,impl_file=Vivado Implementation Defaults,clock_loc=,clock_wrapper=Clock Enables,directory=./netlist,testbench=0,create_interface_document=1,ce_clr=0,base_system_period_hardware=6.25,dcm_input_clock_period=10,base_system_period_simulink=1,sim_time=82420,sim_status=0,}";

  signal clk_1_net: std_logic;
  signal ce_1_net: std_logic;
  signal clk_net: std_logic;
  signal tmi_mosi_rnw_net: std_logic;
  signal tmi_mosi_dval_net: std_logic;
  signal tmi_mosi_add_net: std_logic_vector(6 downto 0);
  signal rx_tvalid_net: std_logic;
  signal rx_tready_net: std_logic;
  signal rx_tlast_net: std_logic;
  signal rx_tdata_net: std_logic_vector(15 downto 0);
  signal msb_pos_net: std_logic_vector(1 downto 0);
  signal ext_data_in2_net: std_logic_vector(31 downto 0);
  signal ext_data_in_net: std_logic_vector(31 downto 0);
  signal clear_mem_net: std_logic;
  signal areset_net: std_logic;
  signal ext_data_out_net: std_logic_vector(31 downto 0);
  signal ext_data_out2_net: std_logic_vector(31 downto 0);
  signal histogram_rdy_net: std_logic;
  signal timestamp_net: std_logic_vector(31 downto 0);
  signal tmi_miso_busy_net: std_logic;
  signal tmi_miso_error_net: std_logic;
  signal tmi_miso_idle_net: std_logic;
  signal tmi_miso_rd_data_net: std_logic_vector(20 downto 0);
  signal tmi_miso_rd_dval_net: std_logic;

begin
  clk_net <= clk;
  tmi_mosi_rnw_net <= tmi_mosi_rnw;
  tmi_mosi_dval_net <= tmi_mosi_dval;
  tmi_mosi_add_net <= tmi_mosi_add;
  rx_tvalid_net <= rx_tvalid;
  rx_tready_net <= rx_tready;
  rx_tlast_net <= rx_tlast;
  rx_tdata_net <= rx_tdata;
  msb_pos_net <= msb_pos;
  ext_data_in2_net <= ext_data_in2_x1;
  ext_data_in_net <= ext_data_in_x1;
  clear_mem_net <= clear_mem;
  areset_net <= areset_x6;
  ext_data_out_x3 <= ext_data_out_net;
  ext_data_out2_x3 <= ext_data_out2_net;
  histogram_rdy <= histogram_rdy_net;
  timestamp_x3 <= timestamp_net;
  tmi_miso_busy <= tmi_miso_busy_net;
  tmi_miso_error <= tmi_miso_error_net;
  tmi_miso_idle <= tmi_miso_idle_net;
  tmi_miso_rd_data <= tmi_miso_rd_data_net;
  tmi_miso_rd_dval <= tmi_miso_rd_dval_net;

  histogram_axis_tmi_struct: entity work.histogram_axis_tmi_struct
    port map (
      clk_1 => clk_1_net,
      ce_1 => ce_1_net,
      tmi_mosi_rnw => tmi_mosi_rnw_net,
      tmi_mosi_dval => tmi_mosi_dval_net,
      tmi_mosi_add => tmi_mosi_add_net,
      rx_tvalid => rx_tvalid_net,
      rx_tready => rx_tready_net,
      rx_tlast => rx_tlast_net,
      rx_tdata => rx_tdata_net,
      msb_pos => msb_pos_net,
      ext_data_in2_x1 => ext_data_in2_net,
      ext_data_in_x1 => ext_data_in_net,
      clear_mem => clear_mem_net,
      areset_x6 => areset_net,
      ext_data_out_x3 => ext_data_out_net,
      ext_data_out2_x3 => ext_data_out2_net,
      histogram_rdy => histogram_rdy_net,
      timestamp_x3 => timestamp_net,
      tmi_miso_busy => tmi_miso_busy_net,
      tmi_miso_error => tmi_miso_error_net,
      tmi_miso_idle => tmi_miso_idle_net,
      tmi_miso_rd_data => tmi_miso_rd_data_net,
      tmi_miso_rd_dval => tmi_miso_rd_dval_net
    );

  default_clock_driver_histogram_axis_tmi: entity work.default_clock_driver_histogram_axis_tmi
    port map (
      sysclk => clk_net,
      sysce => '1',
      sysce_clr => '0',
      clk_1 => clk_1_net,
      ce_1 => ce_1_net
    );
end structural;
