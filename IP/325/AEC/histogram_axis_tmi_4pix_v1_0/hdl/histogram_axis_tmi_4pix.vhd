-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/Add_Gen
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_add_gen is
  port (
    add_pix1 : in std_logic_vector( 7-1 downto 0 );
    add_pix2 : in std_logic_vector( 7-1 downto 0 );
    add_pix3 : in std_logic_vector( 7-1 downto 0 );
    add_pix4 : in std_logic_vector( 7-1 downto 0 );
    dvalid : in std_logic_vector( 1-1 downto 0 );
    add1 : out std_logic_vector( 7-1 downto 0 );
    add2 : out std_logic_vector( 7-1 downto 0 );
    add3 : out std_logic_vector( 7-1 downto 0 );
    add4 : out std_logic_vector( 7-1 downto 0 )
  );
end histogram_axis_tmi_4pix_add_gen;
architecture structural of histogram_axis_tmi_4pix_add_gen is 
  signal mux2_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux4_y_net : std_logic_vector( 7-1 downto 0 );
  signal d4_q_net : std_logic_vector( 7-1 downto 0 );
  signal d7_q_net : std_logic_vector( 7-1 downto 0 );
  signal d1_q_net : std_logic_vector( 7-1 downto 0 );
  signal d2_q_net : std_logic_vector( 7-1 downto 0 );
  signal and_y_net : std_logic_vector( 1-1 downto 0 );
  signal c1_op_net : std_logic_vector( 7-1 downto 0 );
begin
  add1 <= mux2_y_net;
  add2 <= mux1_y_net;
  add3 <= mux3_y_net;
  add4 <= mux4_y_net;
  d4_q_net <= add_pix1;
  d7_q_net <= add_pix2;
  d1_q_net <= add_pix3;
  d2_q_net <= add_pix4;
  and_y_net <= dvalid;
  mux1 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and_y_net,
    d0 => c1_op_net,
    d1 => d7_q_net,
    y => mux1_y_net
  );
  mux2 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and_y_net,
    d0 => c1_op_net,
    d1 => d4_q_net,
    y => mux2_y_net
  );
  mux3 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and_y_net,
    d0 => c1_op_net,
    d1 => d1_q_net,
    y => mux3_y_net
  );
  mux4 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and_y_net,
    d0 => c1_op_net,
    d1 => d2_q_net,
    y => mux4_y_net
  );
  c1 : entity work.sysgen_constant_d9f3ecb9ac 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c1_op_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/Data_to_Addr
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_data_to_addr is
  port (
    data : in std_logic_vector( 64-1 downto 0 );
    msb_pos : in std_logic_vector( 2-1 downto 0 );
    add_1 : out std_logic_vector( 7-1 downto 0 );
    add_2 : out std_logic_vector( 7-1 downto 0 );
    add_3 : out std_logic_vector( 7-1 downto 0 );
    add_4 : out std_logic_vector( 7-1 downto 0 )
  );
end histogram_axis_tmi_4pix_data_to_addr;
architecture structural of histogram_axis_tmi_4pix_data_to_addr is 
  signal mux4_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal rx_tdata_net : std_logic_vector( 64-1 downto 0 );
  signal msb_pos_net : std_logic_vector( 2-1 downto 0 );
  signal xtoadd4_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd5_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd6_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd7_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd8_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd9_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd10_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd11_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd12_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd13_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd14_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd15_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd1_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd2_y_net : std_logic_vector( 7-1 downto 0 );
  signal xtoadd3_y_net : std_logic_vector( 7-1 downto 0 );
  signal pix1_slice_y_net : std_logic_vector( 16-1 downto 0 );
  signal pix3_slice_y_net : std_logic_vector( 16-1 downto 0 );
  signal pix4_slice_y_net : std_logic_vector( 16-1 downto 0 );
  signal pix2_slice_y_net : std_logic_vector( 16-1 downto 0 );
begin
  add_1 <= mux4_y_net;
  add_2 <= mux1_y_net;
  add_3 <= mux2_y_net;
  add_4 <= mux3_y_net;
  rx_tdata_net <= data;
  msb_pos_net <= msb_pos;
  mux1 : entity work.sysgen_mux_83cdf78b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => msb_pos_net,
    d0 => xtoadd4_y_net,
    d1 => xtoadd5_y_net,
    d2 => xtoadd6_y_net,
    d3 => xtoadd7_y_net,
    y => mux1_y_net
  );
  mux2 : entity work.sysgen_mux_83cdf78b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => msb_pos_net,
    d0 => xtoadd8_y_net,
    d1 => xtoadd9_y_net,
    d2 => xtoadd10_y_net,
    d3 => xtoadd11_y_net,
    y => mux2_y_net
  );
  mux3 : entity work.sysgen_mux_83cdf78b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => msb_pos_net,
    d0 => xtoadd12_y_net,
    d1 => xtoadd13_y_net,
    d2 => xtoadd14_y_net,
    d3 => xtoadd15_y_net,
    y => mux3_y_net
  );
  mux4 : entity work.sysgen_mux_83cdf78b1e 
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
  xtoadd : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 6,
    new_msb => 12,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix1_slice_y_net,
    y => xtoadd_y_net
  );
  xtoadd1 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 7,
    new_msb => 13,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix1_slice_y_net,
    y => xtoadd1_y_net
  );
  xtoadd10 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 14,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix3_slice_y_net,
    y => xtoadd10_y_net
  );
  xtoadd11 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 15,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix3_slice_y_net,
    y => xtoadd11_y_net
  );
  xtoadd12 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 6,
    new_msb => 12,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix4_slice_y_net,
    y => xtoadd12_y_net
  );
  xtoadd13 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 7,
    new_msb => 13,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix4_slice_y_net,
    y => xtoadd13_y_net
  );
  xtoadd14 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 14,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix4_slice_y_net,
    y => xtoadd14_y_net
  );
  xtoadd15 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 15,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix4_slice_y_net,
    y => xtoadd15_y_net
  );
  xtoadd2 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 14,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix1_slice_y_net,
    y => xtoadd2_y_net
  );
  xtoadd3 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 15,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix1_slice_y_net,
    y => xtoadd3_y_net
  );
  xtoadd4 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 6,
    new_msb => 12,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix2_slice_y_net,
    y => xtoadd4_y_net
  );
  xtoadd5 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 7,
    new_msb => 13,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix2_slice_y_net,
    y => xtoadd5_y_net
  );
  xtoadd6 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 14,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix2_slice_y_net,
    y => xtoadd6_y_net
  );
  xtoadd7 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 15,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix2_slice_y_net,
    y => xtoadd7_y_net
  );
  xtoadd8 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 6,
    new_msb => 12,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix3_slice_y_net,
    y => xtoadd8_y_net
  );
  xtoadd9 : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 7,
    new_msb => 13,
    x_width => 16,
    y_width => 7
  )
  port map (
    x => pix3_slice_y_net,
    y => xtoadd9_y_net
  );
  pix1_slice : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 64,
    y_width => 16
  )
  port map (
    x => rx_tdata_net,
    y => pix1_slice_y_net
  );
  pix2_slice : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 31,
    x_width => 64,
    y_width => 16
  )
  port map (
    x => rx_tdata_net,
    y => pix2_slice_y_net
  );
  pix3_slice : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 32,
    new_msb => 47,
    x_width => 64,
    y_width => 16
  )
  port map (
    x => rx_tdata_net,
    y => pix3_slice_y_net
  );
  pix4_slice : entity work.histogram_axis_tmi_4pix_xlslice 
  generic map (
    new_lsb => 48,
    new_msb => 63,
    x_width => 64,
    y_width => 16
  )
  port map (
    x => rx_tdata_net,
    y => pix4_slice_y_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/Hist_ram_pix1
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_hist_ram_pix1 is
  port (
    wea : in std_logic_vector( 1-1 downto 0 );
    hist_rdy : in std_logic_vector( 1-1 downto 0 );
    add : in std_logic_vector( 7-1 downto 0 );
    rd_add : in std_logic_vector( 7-1 downto 0 );
    web : in std_logic_vector( 1-1 downto 0 );
    clear_add : in std_logic_vector( 7-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 21-1 downto 0 )
  );
end histogram_axis_tmi_4pix_hist_ram_pix1;
architecture structural of histogram_axis_tmi_4pix_hist_ram_pix1 is 
  signal dp_ram_doutb_net : std_logic_vector( 21-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 7-1 downto 0 );
  signal d10_q_net : std_logic_vector( 7-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal clrmem_cntr_op_net : std_logic_vector( 7-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux_y_net : std_logic_vector( 21-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal and1_y_net : std_logic_vector( 1-1 downto 0 );
  signal d3_q_net : std_logic_vector( 21-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal d1_q_net : std_logic_vector( 7-1 downto 0 );
  signal d13_q_net : std_logic_vector( 1-1 downto 0 );
  signal c3_op_net : std_logic_vector( 21-1 downto 0 );
  signal d2_q_net : std_logic_vector( 7-1 downto 0 );
  signal dp_ram_douta_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= dp_ram_doutb_net;
  logical8_y_net <= wea;
  mux_y_net_x0 <= hist_rdy;
  mux2_y_net <= add;
  d10_q_net <= rd_add;
  logical9_y_net <= web;
  clrmem_cntr_op_net <= clear_add;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity work.histogram_axis_tmi_4pix_xladdsub 
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
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => mux_y_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant_x0 : entity work.sysgen_constant_300e474968 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mux : entity work.sysgen_mux_da5d3a35ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and1_y_net,
    d0 => dp_ram_doutb_net,
    d1 => d3_q_net,
    y => mux_y_net
  );
  mux1 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mux_y_net_x0,
    d0 => mux2_y_net,
    d1 => d10_q_net,
    y => mux1_y_net
  );
  mux3 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => logical9_y_net,
    d0 => mux1_y_net,
    d1 => clrmem_cntr_op_net,
    y => mux3_y_net
  );
  relational : entity work.sysgen_relational_19c3cbee3b 
  port map (
    clr => '0',
    a => d1_q_net,
    b => mux2_y_net,
    en => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  and1 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational_op_net,
    d1 => d13_q_net,
    y => and1_y_net
  );
  c3 : entity work.sysgen_constant_f9fb72d132 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c3_op_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux2_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d13 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d13_q_net
  );
  d2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d3 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 21
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net
  );
  dp_ram : entity work.histogram_axis_tmi_4pix_xldpram 
  generic map (
    c_address_width_a => 7,
    c_address_width_b => 7,
    c_width_a => 21,
    c_width_b => 21,
    core_name0 => "histogram_axis_tmi_4pix_blk_mem_gen_v8_3_i0",
    latency => 1
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => d2_q_net,
    dina => addsub1_s_net,
    wea => logical8_y_net,
    addrb => mux3_y_net,
    dinb => c3_op_net,
    web => logical9_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => dp_ram_douta_net,
    doutb => dp_ram_doutb_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/Hist_ram_pix2
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_hist_ram_pix2 is
  port (
    wea : in std_logic_vector( 1-1 downto 0 );
    hist_rdy : in std_logic_vector( 1-1 downto 0 );
    add : in std_logic_vector( 7-1 downto 0 );
    rd_add : in std_logic_vector( 7-1 downto 0 );
    web : in std_logic_vector( 1-1 downto 0 );
    clear_add : in std_logic_vector( 7-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 21-1 downto 0 )
  );
end histogram_axis_tmi_4pix_hist_ram_pix2;
architecture structural of histogram_axis_tmi_4pix_hist_ram_pix2 is 
  signal dp_ram_doutb_net : std_logic_vector( 21-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net_x0 : std_logic_vector( 7-1 downto 0 );
  signal d10_q_net : std_logic_vector( 7-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal clrmem_cntr_op_net : std_logic_vector( 7-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux_y_net : std_logic_vector( 21-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal and1_y_net : std_logic_vector( 1-1 downto 0 );
  signal d3_q_net : std_logic_vector( 21-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal d1_q_net : std_logic_vector( 7-1 downto 0 );
  signal d13_q_net : std_logic_vector( 1-1 downto 0 );
  signal c3_op_net : std_logic_vector( 21-1 downto 0 );
  signal d2_q_net : std_logic_vector( 7-1 downto 0 );
  signal dp_ram_douta_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= dp_ram_doutb_net;
  logical8_y_net <= wea;
  mux_y_net_x0 <= hist_rdy;
  mux1_y_net_x0 <= add;
  d10_q_net <= rd_add;
  logical9_y_net <= web;
  clrmem_cntr_op_net <= clear_add;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity work.histogram_axis_tmi_4pix_xladdsub 
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
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => mux_y_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant_x0 : entity work.sysgen_constant_300e474968 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mux : entity work.sysgen_mux_da5d3a35ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and1_y_net,
    d0 => dp_ram_doutb_net,
    d1 => d3_q_net,
    y => mux_y_net
  );
  mux1 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mux_y_net_x0,
    d0 => mux1_y_net_x0,
    d1 => d10_q_net,
    y => mux1_y_net
  );
  mux3 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => logical9_y_net,
    d0 => mux1_y_net,
    d1 => clrmem_cntr_op_net,
    y => mux3_y_net
  );
  relational : entity work.sysgen_relational_19c3cbee3b 
  port map (
    clr => '0',
    a => d1_q_net,
    b => mux1_y_net_x0,
    en => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  and1 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational_op_net,
    d1 => d13_q_net,
    y => and1_y_net
  );
  c3 : entity work.sysgen_constant_f9fb72d132 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c3_op_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux1_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d13 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d13_q_net
  );
  d2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d3 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 21
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net
  );
  dp_ram : entity work.histogram_axis_tmi_4pix_xldpram 
  generic map (
    c_address_width_a => 7,
    c_address_width_b => 7,
    c_width_a => 21,
    c_width_b => 21,
    core_name0 => "histogram_axis_tmi_4pix_blk_mem_gen_v8_3_i0",
    latency => 1
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => d2_q_net,
    dina => addsub1_s_net,
    wea => logical8_y_net,
    addrb => mux3_y_net,
    dinb => c3_op_net,
    web => logical9_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => dp_ram_douta_net,
    doutb => dp_ram_doutb_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/Hist_ram_pix3
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_hist_ram_pix3 is
  port (
    wea : in std_logic_vector( 1-1 downto 0 );
    hist_rdy : in std_logic_vector( 1-1 downto 0 );
    add : in std_logic_vector( 7-1 downto 0 );
    rd_add : in std_logic_vector( 7-1 downto 0 );
    web : in std_logic_vector( 1-1 downto 0 );
    clear_add : in std_logic_vector( 7-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 21-1 downto 0 )
  );
end histogram_axis_tmi_4pix_hist_ram_pix3;
architecture structural of histogram_axis_tmi_4pix_hist_ram_pix3 is 
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal d1_q_net : std_logic_vector( 7-1 downto 0 );
  signal d13_q_net : std_logic_vector( 1-1 downto 0 );
  signal c3_op_net : std_logic_vector( 21-1 downto 0 );
  signal d2_q_net : std_logic_vector( 7-1 downto 0 );
  signal dp_ram_douta_net : std_logic_vector( 21-1 downto 0 );
  signal dp_ram_doutb_net : std_logic_vector( 21-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux3_y_net_x0 : std_logic_vector( 7-1 downto 0 );
  signal d10_q_net : std_logic_vector( 7-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal clrmem_cntr_op_net : std_logic_vector( 7-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux_y_net : std_logic_vector( 21-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal and1_y_net : std_logic_vector( 1-1 downto 0 );
  signal d3_q_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= dp_ram_doutb_net;
  logical8_y_net <= wea;
  mux_y_net_x0 <= hist_rdy;
  mux3_y_net_x0 <= add;
  d10_q_net <= rd_add;
  logical9_y_net <= web;
  clrmem_cntr_op_net <= clear_add;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity work.histogram_axis_tmi_4pix_xladdsub 
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
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => mux_y_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant_x0 : entity work.sysgen_constant_300e474968 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mux : entity work.sysgen_mux_da5d3a35ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and1_y_net,
    d0 => dp_ram_doutb_net,
    d1 => d3_q_net,
    y => mux_y_net
  );
  mux1 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mux_y_net_x0,
    d0 => mux3_y_net_x0,
    d1 => d10_q_net,
    y => mux1_y_net
  );
  mux3 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => logical9_y_net,
    d0 => mux1_y_net,
    d1 => clrmem_cntr_op_net,
    y => mux3_y_net
  );
  relational : entity work.sysgen_relational_19c3cbee3b 
  port map (
    clr => '0',
    a => d1_q_net,
    b => mux3_y_net_x0,
    en => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  and1 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational_op_net,
    d1 => d13_q_net,
    y => and1_y_net
  );
  c3 : entity work.sysgen_constant_f9fb72d132 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c3_op_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux3_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d13 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d13_q_net
  );
  d2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d3 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 21
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net
  );
  dp_ram : entity work.histogram_axis_tmi_4pix_xldpram 
  generic map (
    c_address_width_a => 7,
    c_address_width_b => 7,
    c_width_a => 21,
    c_width_b => 21,
    core_name0 => "histogram_axis_tmi_4pix_blk_mem_gen_v8_3_i0",
    latency => 1
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => d2_q_net,
    dina => addsub1_s_net,
    wea => logical8_y_net,
    addrb => mux3_y_net,
    dinb => c3_op_net,
    web => logical9_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => dp_ram_douta_net,
    doutb => dp_ram_doutb_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/Hist_ram_pix4
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_hist_ram_pix4 is
  port (
    wea : in std_logic_vector( 1-1 downto 0 );
    hist_rdy : in std_logic_vector( 1-1 downto 0 );
    add : in std_logic_vector( 7-1 downto 0 );
    rd_add : in std_logic_vector( 7-1 downto 0 );
    web : in std_logic_vector( 1-1 downto 0 );
    clear_add : in std_logic_vector( 7-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 21-1 downto 0 )
  );
end histogram_axis_tmi_4pix_hist_ram_pix4;
architecture structural of histogram_axis_tmi_4pix_hist_ram_pix4 is 
  signal dp_ram_doutb_net : std_logic_vector( 21-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux4_y_net : std_logic_vector( 7-1 downto 0 );
  signal d10_q_net : std_logic_vector( 7-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal clrmem_cntr_op_net : std_logic_vector( 7-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux_y_net : std_logic_vector( 21-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal and1_y_net : std_logic_vector( 1-1 downto 0 );
  signal d3_q_net : std_logic_vector( 21-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal d1_q_net : std_logic_vector( 7-1 downto 0 );
  signal d13_q_net : std_logic_vector( 1-1 downto 0 );
  signal c3_op_net : std_logic_vector( 21-1 downto 0 );
  signal d2_q_net : std_logic_vector( 7-1 downto 0 );
  signal dp_ram_douta_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= dp_ram_doutb_net;
  logical8_y_net <= wea;
  mux_y_net_x0 <= hist_rdy;
  mux4_y_net <= add;
  d10_q_net <= rd_add;
  logical9_y_net <= web;
  clrmem_cntr_op_net <= clear_add;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity work.histogram_axis_tmi_4pix_xladdsub 
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
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => mux_y_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant_x0 : entity work.sysgen_constant_300e474968 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mux : entity work.sysgen_mux_da5d3a35ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => and1_y_net,
    d0 => dp_ram_doutb_net,
    d1 => d3_q_net,
    y => mux_y_net
  );
  mux1 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mux_y_net_x0,
    d0 => mux4_y_net,
    d1 => d10_q_net,
    y => mux1_y_net
  );
  mux3 : entity work.sysgen_mux_4c5856ffb7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => logical9_y_net,
    d0 => mux1_y_net,
    d1 => clrmem_cntr_op_net,
    y => mux3_y_net
  );
  relational : entity work.sysgen_relational_19c3cbee3b 
  port map (
    clr => '0',
    a => d1_q_net,
    b => mux4_y_net,
    en => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  and1 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational_op_net,
    d1 => d13_q_net,
    y => and1_y_net
  );
  c3 : entity work.sysgen_constant_f9fb72d132 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c3_op_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux4_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d13 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical8_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d13_q_net
  );
  d2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d3 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 21
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net
  );
  dp_ram : entity work.histogram_axis_tmi_4pix_xldpram 
  generic map (
    c_address_width_a => 7,
    c_address_width_b => 7,
    c_width_a => 21,
    c_width_b => 21,
    core_name0 => "histogram_axis_tmi_4pix_blk_mem_gen_v8_3_i0",
    latency => 1
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => d2_q_net,
    dina => addsub1_s_net,
    wea => logical8_y_net,
    addrb => mux3_y_net,
    dinb => c3_op_net,
    web => logical9_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => dp_ram_douta_net,
    doutb => dp_ram_doutb_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/HistogramState/SOF_GEN
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_sof_gen is
  port (
    tlast : in std_logic_vector( 1-1 downto 0 );
    dval : in std_logic_vector( 1-1 downto 0 );
    areset : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sof : out std_logic_vector( 1-1 downto 0 )
  );
end histogram_axis_tmi_4pix_sof_gen;
architecture structural of histogram_axis_tmi_4pix_sof_gen is 
  signal logical13_y_net : std_logic_vector( 1-1 downto 0 );
  signal d8_q_net : std_logic_vector( 1-1 downto 0 );
  signal and_y_net : std_logic_vector( 1-1 downto 0 );
  signal areset_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
begin
  sof <= logical13_y_net;
  d8_q_net <= tlast;
  and_y_net <= dval;
  areset_net <= areset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  logical13 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => register1_q_net,
    d1 => and_y_net,
    y => logical13_y_net
  );
  register1 : entity work.histogram_axis_tmi_4pix_xlregister 
  generic map (
    d_width => 1,
    init_value => b"1"
  )
  port map (
    d => d8_q_net,
    rst => areset_net,
    en => and_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/HistogramState
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_histogramstate is
  port (
    eof : in std_logic_vector( 1-1 downto 0 );
    clearmem : in std_logic_vector( 1-1 downto 0 );
    dval : in std_logic_vector( 1-1 downto 0 );
    ext_data_in : in std_logic_vector( 32-1 downto 0 );
    areset : in std_logic_vector( 1-1 downto 0 );
    ext_data_in2 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    hist_rdy : out std_logic_vector( 1-1 downto 0 );
    wea : out std_logic_vector( 1-1 downto 0 );
    web : out std_logic_vector( 1-1 downto 0 );
    clearadd : out std_logic_vector( 7-1 downto 0 );
    timestamp : out std_logic_vector( 32-1 downto 0 );
    ext_data_out : out std_logic_vector( 32-1 downto 0 );
    ext_data_out2 : out std_logic_vector( 32-1 downto 0 )
  );
end histogram_axis_tmi_4pix_histogramstate;
architecture structural of histogram_axis_tmi_4pix_histogramstate is 
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical11_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical7_y_net : std_logic_vector( 1-1 downto 0 );
  signal d2_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical5_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical6_y_net : std_logic_vector( 1-1 downto 0 );
  signal d1_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal timestamp_cntr_op_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal clrmem_cntr_op_net : std_logic_vector( 7-1 downto 0 );
  signal reg1_q_net : std_logic_vector( 32-1 downto 0 );
  signal reg2_q_net : std_logic_vector( 32-1 downto 0 );
  signal reg3_q_net : std_logic_vector( 32-1 downto 0 );
  signal d8_q_net : std_logic_vector( 1-1 downto 0 );
  signal d9_q_net : std_logic_vector( 1-1 downto 0 );
  signal and_y_net : std_logic_vector( 1-1 downto 0 );
  signal d14_q_net : std_logic_vector( 32-1 downto 0 );
  signal areset_net : std_logic_vector( 1-1 downto 0 );
  signal d15_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal logical13_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 7-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter2_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter3_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter4_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter5_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter7_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter8_op_net : std_logic_vector( 1-1 downto 0 );
begin
  hist_rdy <= mux_y_net;
  wea <= logical8_y_net;
  web <= logical9_y_net;
  clearadd <= clrmem_cntr_op_net;
  timestamp <= reg1_q_net;
  ext_data_out <= reg2_q_net;
  ext_data_out2 <= reg3_q_net;
  d8_q_net <= eof;
  d9_q_net <= clearmem;
  and_y_net <= dval;
  d14_q_net <= ext_data_in;
  areset_net <= areset;
  d15_q_net <= ext_data_in2;
  clk_net <= clk_1;
  ce_net <= ce_1;
  sof_gen : entity work.histogram_axis_tmi_4pix_sof_gen 
  port map (
    tlast => d8_q_net,
    dval => and_y_net,
    areset => areset_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sof => logical13_y_net
  );
  constant_x0 : entity work.sysgen_constant_c26a192fd2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity work.sysgen_constant_300e474968 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity work.sysgen_constant_d9f3ecb9ac 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  inverter1 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  inverter2 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter2_op_net
  );
  inverter3 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => logical9_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter3_op_net
  );
  inverter4 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => logical9_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter4_op_net
  );
  inverter5 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => logical2_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter5_op_net
  );
  inverter7 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter7_op_net
  );
  inverter8 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => logical9_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter8_op_net
  );
  logical : entity work.sysgen_logical_b401db0a81 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter1_op_net,
    d1 => inverter3_op_net,
    d2 => logical3_y_net,
    y => logical_y_net
  );
  logical1 : entity work.sysgen_logical_7e3e2adf8f 
  port map (
    clr => '0',
    d0 => d8_q_net,
    d1 => logical2_y_net,
    d2 => and_y_net,
    clk => clk_net,
    ce => ce_net,
    y => logical1_y_net
  );
  logical11 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical7_y_net,
    d1 => inverter7_op_net,
    y => logical11_y_net
  );
  logical2 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d2_q_net,
    d1 => inverter2_op_net,
    y => logical2_y_net
  );
  logical3 : entity work.sysgen_logical_0255e084a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical7_y_net,
    d1 => d2_q_net,
    y => logical3_y_net
  );
  logical4 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => d2_q_net,
    y => logical4_y_net
  );
  logical5 : entity work.sysgen_logical_0255e084a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical4_y_net,
    d1 => mux_y_net,
    y => logical5_y_net
  );
  logical6 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter4_op_net,
    d1 => logical5_y_net,
    y => logical6_y_net
  );
  logical7 : entity work.sysgen_logical_56ba4dec34 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical13_y_net,
    d1 => inverter5_op_net,
    d2 => and_y_net,
    d3 => inverter8_op_net,
    y => logical7_y_net
  );
  logical8 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical2_y_net,
    d1 => d1_q_net,
    y => logical8_y_net
  );
  logical9 : entity work.sysgen_logical_0255e084a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d9_q_net,
    d1 => relational_op_net,
    y => logical9_y_net
  );
  mux : entity work.sysgen_mux_f2fd5be235 
  port map (
    clr => '0',
    sel => logical6_y_net,
    d0 => constant_op_net,
    d1 => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  relational : entity work.sysgen_relational_f411a208c2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => clrmem_cntr_op_net,
    b => constant2_op_net,
    op => relational_op_net
  );
  timestamp_cntr : entity work.sysgen_counter_28090c7f7f 
  port map (
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => timestamp_cntr_op_net
  );
  clrmem_cntr : entity work.histogram_axis_tmi_4pix_xlcounter_limit 
  generic map (
    cnt_15_0 => 127,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "histogram_axis_tmi_4pix_c_counter_binary_v12_0_i0",
    count_limited => 0,
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical9_y_net,
    clk => clk_net,
    ce => ce_net,
    op => clrmem_cntr_op_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => and_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  reg1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    rst => '1',
    d => timestamp_cntr_op_net,
    en => logical11_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => reg1_q_net
  );
  reg2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    rst => '1',
    d => d14_q_net,
    en => logical11_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => reg2_q_net
  );
  reg3 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    rst => '1',
    d => d15_q_net,
    en => logical11_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => reg3_q_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix/TMI
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_tmi is
  port (
    add_in : in std_logic_vector( 7-1 downto 0 );
    rnw : in std_logic_vector( 1-1 downto 0 );
    dval : in std_logic_vector( 1-1 downto 0 );
    doutb : in std_logic_vector( 21-1 downto 0 );
    hist_rdy : in std_logic_vector( 1-1 downto 0 );
    areset : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    busy : out std_logic_vector( 1-1 downto 0 );
    idle : out std_logic_vector( 1-1 downto 0 );
    error : out std_logic_vector( 1-1 downto 0 );
    rd_dval : out std_logic_vector( 1-1 downto 0 )
  );
end histogram_axis_tmi_4pix_tmi;
architecture structural of histogram_axis_tmi_4pix_tmi is 
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 1-1 downto 0 );
  signal d10_q_net : std_logic_vector( 7-1 downto 0 );
  signal d11_q_net : std_logic_vector( 1-1 downto 0 );
  signal d12_q_net : std_logic_vector( 1-1 downto 0 );
  signal bin_adder2_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal areset_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal and3_y_net : std_logic_vector( 1-1 downto 0 );
  signal c3_op_net : std_logic_vector( 1-1 downto 0 );
  signal inv1_op_net : std_logic_vector( 1-1 downto 0 );
  signal c1_op_net : std_logic_vector( 1-1 downto 0 );
  signal d1_q_net : std_logic_vector( 1-1 downto 0 );
  signal c2_op_net : std_logic_vector( 1-1 downto 0 );
  signal and4_y_net : std_logic_vector( 1-1 downto 0 );
  signal c4_op_net : std_logic_vector( 1-1 downto 0 );
  signal and1_y_net : std_logic_vector( 1-1 downto 0 );
  signal and2_y_net : std_logic_vector( 1-1 downto 0 );
  signal d5_q_net : std_logic_vector( 1-1 downto 0 );
  signal inv2_op_net : std_logic_vector( 1-1 downto 0 );
  signal inv3_op_net : std_logic_vector( 1-1 downto 0 );
  signal and5_y_net : std_logic_vector( 1-1 downto 0 );
  signal inv4_op_net : std_logic_vector( 1-1 downto 0 );
  signal inv5_op_net : std_logic_vector( 1-1 downto 0 );
begin
  busy <= mux_y_net;
  idle <= mux1_y_net;
  error <= mux3_y_net;
  rd_dval <= mux2_y_net;
  d10_q_net <= add_in;
  d11_q_net <= rnw;
  d12_q_net <= dval;
  bin_adder2_s_net <= doutb;
  mux_y_net_x0 <= hist_rdy;
  areset_net <= areset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  mux : entity work.sysgen_mux_bebb0b6594 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => areset_net,
    d0 => and3_y_net,
    d1 => c3_op_net,
    y => mux_y_net
  );
  mux1 : entity work.sysgen_mux_bebb0b6594 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => areset_net,
    d0 => inv1_op_net,
    d1 => c1_op_net,
    y => mux1_y_net
  );
  mux2 : entity work.sysgen_mux_bebb0b6594 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => areset_net,
    d0 => d1_q_net,
    d1 => c2_op_net,
    y => mux2_y_net
  );
  mux3 : entity work.sysgen_mux_bebb0b6594 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => areset_net,
    d0 => and4_y_net,
    d1 => c4_op_net,
    y => mux3_y_net
  );
  and1 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d12_q_net,
    d1 => d11_q_net,
    y => and1_y_net
  );
  and2 : entity work.sysgen_logical_0255e084a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => and1_y_net,
    d1 => d5_q_net,
    y => and2_y_net
  );
  and3 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inv2_op_net,
    d1 => and1_y_net,
    y => and3_y_net
  );
  and4 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d12_q_net,
    d1 => inv3_op_net,
    y => and4_y_net
  );
  and5 : entity work.sysgen_logical_b401db0a81 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => and1_y_net,
    d1 => inv4_op_net,
    d2 => inv5_op_net,
    y => and5_y_net
  );
  c1 : entity work.sysgen_constant_c26a192fd2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c1_op_net
  );
  c2 : entity work.sysgen_constant_c26a192fd2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c2_op_net
  );
  c3 : entity work.sysgen_constant_300e474968 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c3_op_net
  );
  c4 : entity work.sysgen_constant_c26a192fd2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => c4_op_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => and5_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d5 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => and1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d5_q_net
  );
  inv1 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => and2_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inv1_op_net
  );
  inv2 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    op => inv2_op_net
  );
  inv3 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => d11_q_net,
    clk => clk_net,
    ce => ce_net,
    op => inv3_op_net
  );
  inv4 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => and3_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inv4_op_net
  );
  inv5 : entity work.sysgen_inverter_58d71abb1c 
  port map (
    clr => '0',
    ip => inv1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inv5_op_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix/AXIS16_Histogram_4pix
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_axis16_histogram_4pix is
  port (
    areset : in std_logic_vector( 1-1 downto 0 );
    clear_mem : in std_logic_vector( 1-1 downto 0 );
    ext_data_in : in std_logic_vector( 32-1 downto 0 );
    ext_data_in2 : in std_logic_vector( 32-1 downto 0 );
    msb_pos : in std_logic_vector( 2-1 downto 0 );
    rx_tdata : in std_logic_vector( 64-1 downto 0 );
    rx_tlast : in std_logic_vector( 1-1 downto 0 );
    rx_tready : in std_logic_vector( 1-1 downto 0 );
    rx_tvalid : in std_logic_vector( 1-1 downto 0 );
    tmi_mosi_add : in std_logic_vector( 7-1 downto 0 );
    tmi_mosi_dval : in std_logic_vector( 1-1 downto 0 );
    tmi_mosi_rnw : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ext_data_out : out std_logic_vector( 32-1 downto 0 );
    ext_data_out2 : out std_logic_vector( 32-1 downto 0 );
    histogram_rdy : out std_logic_vector( 1-1 downto 0 );
    timestamp : out std_logic_vector( 32-1 downto 0 );
    tmi_miso_busy : out std_logic_vector( 1-1 downto 0 );
    tmi_miso_error : out std_logic_vector( 1-1 downto 0 );
    tmi_miso_idle : out std_logic_vector( 1-1 downto 0 );
    tmi_miso_rd_data : out std_logic_vector( 21-1 downto 0 );
    tmi_miso_rd_dval : out std_logic_vector( 1-1 downto 0 )
  );
end histogram_axis_tmi_4pix_axis16_histogram_4pix;
architecture structural of histogram_axis_tmi_4pix_axis16_histogram_4pix is 
  signal areset_net : std_logic_vector( 1-1 downto 0 );
  signal clear_mem_net : std_logic_vector( 1-1 downto 0 );
  signal ext_data_in_net : std_logic_vector( 32-1 downto 0 );
  signal ext_data_in2_net : std_logic_vector( 32-1 downto 0 );
  signal reg2_q_net : std_logic_vector( 32-1 downto 0 );
  signal reg3_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal msb_pos_net : std_logic_vector( 2-1 downto 0 );
  signal rx_tdata_net : std_logic_vector( 64-1 downto 0 );
  signal rx_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal rx_tready_net : std_logic_vector( 1-1 downto 0 );
  signal rx_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal reg1_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux3_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal bin_adder2_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux2_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal tmi_mosi_add_net : std_logic_vector( 7-1 downto 0 );
  signal tmi_mosi_dval_net : std_logic_vector( 1-1 downto 0 );
  signal tmi_mosi_rnw_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal mux2_y_net_x0 : std_logic_vector( 7-1 downto 0 );
  signal mux1_y_net_x1 : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net_x0 : std_logic_vector( 7-1 downto 0 );
  signal mux4_y_net_x0 : std_logic_vector( 7-1 downto 0 );
  signal d4_q_net : std_logic_vector( 7-1 downto 0 );
  signal d7_q_net : std_logic_vector( 7-1 downto 0 );
  signal d1_q_net : std_logic_vector( 7-1 downto 0 );
  signal d2_q_net : std_logic_vector( 7-1 downto 0 );
  signal and_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux4_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 7-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 7-1 downto 0 );
  signal dp_ram_doutb_net_x2 : std_logic_vector( 21-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal d10_q_net : std_logic_vector( 7-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal clrmem_cntr_op_net : std_logic_vector( 7-1 downto 0 );
  signal dp_ram_doutb_net_x1 : std_logic_vector( 21-1 downto 0 );
  signal dp_ram_doutb_net_x0 : std_logic_vector( 21-1 downto 0 );
  signal dp_ram_doutb_net : std_logic_vector( 21-1 downto 0 );
  signal d8_q_net : std_logic_vector( 1-1 downto 0 );
  signal d9_q_net : std_logic_vector( 1-1 downto 0 );
  signal d14_q_net : std_logic_vector( 32-1 downto 0 );
  signal d15_q_net : std_logic_vector( 32-1 downto 0 );
  signal d11_q_net : std_logic_vector( 1-1 downto 0 );
  signal d12_q_net : std_logic_vector( 1-1 downto 0 );
  signal bin_adder_s_net : std_logic_vector( 21-1 downto 0 );
  signal bin_adder1_s_net : std_logic_vector( 21-1 downto 0 );
  signal d5_q_net : std_logic_vector( 1-1 downto 0 );
  signal d6_q_net : std_logic_vector( 1-1 downto 0 );
begin
  areset_net <= areset;
  clear_mem_net <= clear_mem;
  ext_data_in_net <= ext_data_in;
  ext_data_in2_net <= ext_data_in2;
  ext_data_out <= reg2_q_net;
  ext_data_out2 <= reg3_q_net;
  histogram_rdy <= mux_y_net;
  msb_pos_net <= msb_pos;
  rx_tdata_net <= rx_tdata;
  rx_tlast_net <= rx_tlast;
  rx_tready_net <= rx_tready;
  rx_tvalid_net <= rx_tvalid;
  timestamp <= reg1_q_net;
  tmi_miso_busy <= mux_y_net_x0;
  tmi_miso_error <= mux3_y_net_x1;
  tmi_miso_idle <= mux1_y_net_x0;
  tmi_miso_rd_data <= bin_adder2_s_net;
  tmi_miso_rd_dval <= mux2_y_net_x1;
  tmi_mosi_add_net <= tmi_mosi_add;
  tmi_mosi_dval_net <= tmi_mosi_dval;
  tmi_mosi_rnw_net <= tmi_mosi_rnw;
  clk_net <= clk_1;
  ce_net <= ce_1;
  add_gen : entity work.histogram_axis_tmi_4pix_add_gen 
  port map (
    add_pix1 => d4_q_net,
    add_pix2 => d7_q_net,
    add_pix3 => d1_q_net,
    add_pix4 => d2_q_net,
    dvalid => and_y_net,
    add1 => mux2_y_net_x0,
    add2 => mux1_y_net_x1,
    add3 => mux3_y_net_x0,
    add4 => mux4_y_net_x0
  );
  data_to_addr : entity work.histogram_axis_tmi_4pix_data_to_addr 
  port map (
    data => rx_tdata_net,
    msb_pos => msb_pos_net,
    add_1 => mux4_y_net,
    add_2 => mux1_y_net,
    add_3 => mux2_y_net,
    add_4 => mux3_y_net
  );
  hist_ram_pix1 : entity work.histogram_axis_tmi_4pix_hist_ram_pix1 
  port map (
    wea => logical8_y_net,
    hist_rdy => mux_y_net,
    add => mux2_y_net_x0,
    rd_add => d10_q_net,
    web => logical9_y_net,
    clear_add => clrmem_cntr_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => dp_ram_doutb_net_x2
  );
  hist_ram_pix2 : entity work.histogram_axis_tmi_4pix_hist_ram_pix2 
  port map (
    wea => logical8_y_net,
    hist_rdy => mux_y_net,
    add => mux1_y_net_x1,
    rd_add => d10_q_net,
    web => logical9_y_net,
    clear_add => clrmem_cntr_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => dp_ram_doutb_net_x1
  );
  hist_ram_pix3 : entity work.histogram_axis_tmi_4pix_hist_ram_pix3 
  port map (
    wea => logical8_y_net,
    hist_rdy => mux_y_net,
    add => mux3_y_net_x0,
    rd_add => d10_q_net,
    web => logical9_y_net,
    clear_add => clrmem_cntr_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => dp_ram_doutb_net_x0
  );
  hist_ram_pix4 : entity work.histogram_axis_tmi_4pix_hist_ram_pix4 
  port map (
    wea => logical8_y_net,
    hist_rdy => mux_y_net,
    add => mux4_y_net_x0,
    rd_add => d10_q_net,
    web => logical9_y_net,
    clear_add => clrmem_cntr_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => dp_ram_doutb_net
  );
  histogramstate : entity work.histogram_axis_tmi_4pix_histogramstate 
  port map (
    eof => d8_q_net,
    clearmem => d9_q_net,
    dval => and_y_net,
    ext_data_in => d14_q_net,
    areset => areset_net,
    ext_data_in2 => d15_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    hist_rdy => mux_y_net,
    wea => logical8_y_net,
    web => logical9_y_net,
    clearadd => clrmem_cntr_op_net,
    timestamp => reg1_q_net,
    ext_data_out => reg2_q_net,
    ext_data_out2 => reg3_q_net
  );
  tmi : entity work.histogram_axis_tmi_4pix_tmi 
  port map (
    add_in => d10_q_net,
    rnw => d11_q_net,
    dval => d12_q_net,
    doutb => bin_adder2_s_net,
    hist_rdy => mux_y_net,
    areset => areset_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    busy => mux_y_net_x0,
    idle => mux1_y_net_x0,
    error => mux3_y_net_x1,
    rd_dval => mux2_y_net_x1
  );
  bin_adder : entity work.histogram_axis_tmi_4pix_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 21,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 21,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 22,
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => dp_ram_doutb_net_x2,
    b => dp_ram_doutb_net_x1,
    clk => clk_net,
    ce => ce_net,
    s => bin_adder_s_net
  );
  bin_adder1 : entity work.histogram_axis_tmi_4pix_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 21,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 21,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 22,
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => dp_ram_doutb_net_x0,
    b => dp_ram_doutb_net,
    clk => clk_net,
    ce => ce_net,
    s => bin_adder1_s_net
  );
  bin_adder2 : entity work.histogram_axis_tmi_4pix_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 21,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 21,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 22,
    core_name0 => "histogram_axis_tmi_4pix_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => bin_adder_s_net,
    b => bin_adder1_s_net,
    clk => clk_net,
    ce => ce_net,
    s => bin_adder2_s_net
  );
  and_x0 : entity work.sysgen_logical_1e62fb9b73 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d5_q_net,
    d1 => d6_q_net,
    y => and_y_net
  );
  d1 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux2_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d10 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => tmi_mosi_add_net,
    clk => clk_net,
    ce => ce_net,
    q => d10_q_net
  );
  d11 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => tmi_mosi_rnw_net,
    clk => clk_net,
    ce => ce_net,
    q => d11_q_net
  );
  d12 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => tmi_mosi_dval_net,
    clk => clk_net,
    ce => ce_net,
    q => d12_q_net
  );
  d14 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    en => '1',
    rst => '1',
    d => ext_data_in_net,
    clk => clk_net,
    ce => ce_net,
    q => d14_q_net
  );
  d15 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    en => '1',
    rst => '1',
    d => ext_data_in2_net,
    clk => clk_net,
    ce => ce_net,
    q => d15_q_net
  );
  d2 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux3_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d4 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux4_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d4_q_net
  );
  d5 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => rx_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => d5_q_net
  );
  d6 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => rx_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => d6_q_net
  );
  d7 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    en => '1',
    rst => '1',
    d => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => d7_q_net
  );
  d8 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => rx_tlast_net,
    clk => clk_net,
    ce => ce_net,
    q => d8_q_net
  );
  d9 : entity work.histogram_axis_tmi_4pix_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => clear_mem_net,
    clk => clk_net,
    ce => ce_net,
    q => d9_q_net
  );
end structural;
-- Generated from Simulink block histogram_AXIS_TMI_4pix_struct
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_struct is
  port (
    areset : in std_logic_vector( 1-1 downto 0 );
    clear_mem : in std_logic_vector( 1-1 downto 0 );
    ext_data_in : in std_logic_vector( 32-1 downto 0 );
    ext_data_in2 : in std_logic_vector( 32-1 downto 0 );
    msb_pos : in std_logic_vector( 2-1 downto 0 );
    rx_tdata : in std_logic_vector( 64-1 downto 0 );
    rx_tlast : in std_logic_vector( 1-1 downto 0 );
    rx_tready : in std_logic_vector( 1-1 downto 0 );
    rx_tvalid : in std_logic_vector( 1-1 downto 0 );
    tmi_mosi_add : in std_logic_vector( 7-1 downto 0 );
    tmi_mosi_dval : in std_logic_vector( 1-1 downto 0 );
    tmi_mosi_rnw : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ext_data_out : out std_logic_vector( 32-1 downto 0 );
    ext_data_out2 : out std_logic_vector( 32-1 downto 0 );
    histogram_rdy : out std_logic_vector( 1-1 downto 0 );
    timestamp : out std_logic_vector( 32-1 downto 0 );
    tmi_miso_busy : out std_logic_vector( 1-1 downto 0 );
    tmi_miso_error : out std_logic_vector( 1-1 downto 0 );
    tmi_miso_idle : out std_logic_vector( 1-1 downto 0 );
    tmi_miso_rd_data : out std_logic_vector( 21-1 downto 0 );
    tmi_miso_rd_dval : out std_logic_vector( 1-1 downto 0 )
  );
end histogram_axis_tmi_4pix_struct;
architecture structural of histogram_axis_tmi_4pix_struct is 
  signal areset_net : std_logic_vector( 1-1 downto 0 );
  signal clear_mem_net : std_logic_vector( 1-1 downto 0 );
  signal ext_data_in_net : std_logic_vector( 32-1 downto 0 );
  signal ext_data_in2_net : std_logic_vector( 32-1 downto 0 );
  signal reg2_q_net : std_logic_vector( 32-1 downto 0 );
  signal reg3_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal msb_pos_net : std_logic_vector( 2-1 downto 0 );
  signal rx_tdata_net : std_logic_vector( 64-1 downto 0 );
  signal rx_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal rx_tready_net : std_logic_vector( 1-1 downto 0 );
  signal rx_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal reg1_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux3_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 1-1 downto 0 );
  signal bin_adder2_s_net : std_logic_vector( 21-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 1-1 downto 0 );
  signal tmi_mosi_add_net : std_logic_vector( 7-1 downto 0 );
  signal tmi_mosi_dval_net : std_logic_vector( 1-1 downto 0 );
  signal tmi_mosi_rnw_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
begin
  areset_net <= areset;
  clear_mem_net <= clear_mem;
  ext_data_in_net <= ext_data_in;
  ext_data_in2_net <= ext_data_in2;
  ext_data_out <= reg2_q_net;
  ext_data_out2 <= reg3_q_net;
  histogram_rdy <= mux_y_net_x0;
  msb_pos_net <= msb_pos;
  rx_tdata_net <= rx_tdata;
  rx_tlast_net <= rx_tlast;
  rx_tready_net <= rx_tready;
  rx_tvalid_net <= rx_tvalid;
  timestamp <= reg1_q_net;
  tmi_miso_busy <= mux_y_net;
  tmi_miso_error <= mux3_y_net;
  tmi_miso_idle <= mux1_y_net;
  tmi_miso_rd_data <= bin_adder2_s_net;
  tmi_miso_rd_dval <= mux2_y_net;
  tmi_mosi_add_net <= tmi_mosi_add;
  tmi_mosi_dval_net <= tmi_mosi_dval;
  tmi_mosi_rnw_net <= tmi_mosi_rnw;
  clk_net <= clk_1;
  ce_net <= ce_1;
  axis16_histogram_4pix : entity work.histogram_axis_tmi_4pix_axis16_histogram_4pix 
  port map (
    areset => areset_net,
    clear_mem => clear_mem_net,
    ext_data_in => ext_data_in_net,
    ext_data_in2 => ext_data_in2_net,
    msb_pos => msb_pos_net,
    rx_tdata => rx_tdata_net,
    rx_tlast => rx_tlast_net,
    rx_tready => rx_tready_net,
    rx_tvalid => rx_tvalid_net,
    tmi_mosi_add => tmi_mosi_add_net,
    tmi_mosi_dval => tmi_mosi_dval_net,
    tmi_mosi_rnw => tmi_mosi_rnw_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ext_data_out => reg2_q_net,
    ext_data_out2 => reg3_q_net,
    histogram_rdy => mux_y_net_x0,
    timestamp => reg1_q_net,
    tmi_miso_busy => mux_y_net,
    tmi_miso_error => mux3_y_net,
    tmi_miso_idle => mux1_y_net,
    tmi_miso_rd_data => bin_adder2_s_net,
    tmi_miso_rd_dval => mux2_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix_default_clock_driver is
  port (
    histogram_axis_tmi_4pix_sysclk : in std_logic;
    histogram_axis_tmi_4pix_sysce : in std_logic;
    histogram_axis_tmi_4pix_sysclr : in std_logic;
    histogram_axis_tmi_4pix_clk1 : out std_logic;
    histogram_axis_tmi_4pix_ce1 : out std_logic
  );
end histogram_axis_tmi_4pix_default_clock_driver;
architecture structural of histogram_axis_tmi_4pix_default_clock_driver is 
begin
  clockdriver : entity work.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => histogram_axis_tmi_4pix_sysclk,
    sysce => histogram_axis_tmi_4pix_sysce,
    sysclr => histogram_axis_tmi_4pix_sysclr,
    clk => histogram_axis_tmi_4pix_clk1,
    ce => histogram_axis_tmi_4pix_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;
entity histogram_axis_tmi_4pix is
  port (
    areset : in std_logic;
    clear_mem : in std_logic;
    ext_data_in : in std_logic_vector( 32-1 downto 0 );
    ext_data_in2 : in std_logic_vector( 32-1 downto 0 );
    msb_pos : in std_logic_vector( 2-1 downto 0 );
    rx_tdata : in std_logic_vector( 64-1 downto 0 );
    rx_tlast : in std_logic;
    rx_tready : in std_logic;
    rx_tvalid : in std_logic;
    tmi_mosi_add : in std_logic_vector( 7-1 downto 0 );
    tmi_mosi_dval : in std_logic;
    tmi_mosi_rnw : in std_logic;
    clk : in std_logic;
    ext_data_out : out std_logic_vector( 32-1 downto 0 );
    ext_data_out2 : out std_logic_vector( 32-1 downto 0 );
    histogram_rdy : out std_logic;
    timestamp : out std_logic_vector( 32-1 downto 0 );
    tmi_miso_busy : out std_logic;
    tmi_miso_error : out std_logic;
    tmi_miso_idle : out std_logic;
    tmi_miso_rd_data : out std_logic_vector( 21-1 downto 0 );
    tmi_miso_rd_dval : out std_logic
  );
end histogram_axis_tmi_4pix;
architecture structural of histogram_axis_tmi_4pix is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "histogram_axis_tmi_4pix,sysgen_core_2016_3,{,compilation=IP Catalog,block_icon_display=Default,family=kintex7,part=xc7k325t,speed=-1,package=fbg676,synthesis_language=vhdl,hdl_library=work,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=6.25,system_simulink_period=1,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=1524,addsub=7,constant=16,counter=2,delay=36,dpram=4,inv=12,logical=22,mux=25,register=1,relational=5,slice=20,}";
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
begin
  histogram_axis_tmi_4pix_default_clock_driver : entity work.histogram_axis_tmi_4pix_default_clock_driver 
  port map (
    histogram_axis_tmi_4pix_sysclk => clk,
    histogram_axis_tmi_4pix_sysce => '1',
    histogram_axis_tmi_4pix_sysclr => '0',
    histogram_axis_tmi_4pix_clk1 => clk_1_net,
    histogram_axis_tmi_4pix_ce1 => ce_1_net
  );
  histogram_axis_tmi_4pix_struct : entity work.histogram_axis_tmi_4pix_struct 
  port map (
    areset(0) => areset,
    clear_mem(0) => clear_mem,
    ext_data_in => ext_data_in,
    ext_data_in2 => ext_data_in2,
    msb_pos => msb_pos,
    rx_tdata => rx_tdata,
    rx_tlast(0) => rx_tlast,
    rx_tready(0) => rx_tready,
    rx_tvalid(0) => rx_tvalid,
    tmi_mosi_add => tmi_mosi_add,
    tmi_mosi_dval(0) => tmi_mosi_dval,
    tmi_mosi_rnw(0) => tmi_mosi_rnw,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    ext_data_out => ext_data_out,
    ext_data_out2 => ext_data_out2,
    histogram_rdy(0) => histogram_rdy,
    timestamp => timestamp,
    tmi_miso_busy(0) => tmi_miso_busy,
    tmi_miso_error(0) => tmi_miso_error,
    tmi_miso_idle(0) => tmi_miso_idle,
    tmi_miso_rd_data => tmi_miso_rd_data,
    tmi_miso_rd_dval(0) => tmi_miso_rd_dval
  );
end structural;
