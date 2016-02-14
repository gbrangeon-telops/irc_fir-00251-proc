library IEEE;
use IEEE.std_logic_1164.all;
library work;

entity histogram_axis_tmi_stub is
  port(
    tmi_mosi_rnw : in std_logic;
    tmi_mosi_dval : in std_logic;
    tmi_mosi_add : in std_logic_vector(6 downto 0);
    rx_tvalid : in std_logic;
    rx_tready : in std_logic;
    rx_tlast : in std_logic;
    rx_tdata : in std_logic_vector(15 downto 0);
    msb_pos : in std_logic_vector(1 downto 0);
    ext_data_in2_x1 : in std_logic_vector(31 downto 0);
    ext_data_in_x1 : in std_logic_vector(31 downto 0);
    clear_mem : in std_logic;
    areset_x6 : in std_logic;
    ext_data_out_x3 : out std_logic_vector(31 downto 0);
    ext_data_out2_x3 : out std_logic_vector(31 downto 0);
    histogram_rdy : out std_logic;
    timestamp_x3 : out std_logic_vector(31 downto 0);
    tmi_miso_busy : out std_logic;
    tmi_miso_error : out std_logic;
    tmi_miso_idle : out std_logic;
    tmi_miso_rd_data : out std_logic_vector(20 downto 0);
    tmi_miso_rd_dval : out std_logic;
    clk:in std_logic
    );
end histogram_axis_tmi_stub;
architecture STRUCTURAL of histogram_axis_tmi_stub is
  signal tmi_mosi_rnw_net : std_logic;
  signal tmi_mosi_dval_net : std_logic;
  signal tmi_mosi_add_net : std_logic_vector(6 downto 0);
  signal rx_tvalid_net : std_logic;
  signal rx_tready_net : std_logic;
  signal rx_tlast_net : std_logic;
  signal rx_tdata_net : std_logic_vector(15 downto 0);
  signal msb_pos_net : std_logic_vector(1 downto 0);
  signal ext_data_in2_x1_net : std_logic_vector(31 downto 0);
  signal ext_data_in_x1_net : std_logic_vector(31 downto 0);
  signal clear_mem_net : std_logic;
  signal areset_x6_net : std_logic;
  signal ext_data_out_x3_net : std_logic_vector(31 downto 0);
  signal ext_data_out2_x3_net : std_logic_vector(31 downto 0);
  signal histogram_rdy_net : std_logic;
  signal timestamp_x3_net : std_logic_vector(31 downto 0);
  signal tmi_miso_busy_net : std_logic;
  signal tmi_miso_error_net : std_logic;
  signal tmi_miso_idle_net : std_logic;
  signal tmi_miso_rd_data_net : std_logic_vector(20 downto 0);
  signal tmi_miso_rd_dval_net : std_logic;
  signal clk_net : std_logic;
  component histogram_axis_tmi is
    port(
      tmi_mosi_rnw : in std_logic;
      tmi_mosi_dval : in std_logic;
      tmi_mosi_add : in std_logic_vector(6 downto 0);
      rx_tvalid : in std_logic;
      rx_tready : in std_logic;
      rx_tlast : in std_logic;
      rx_tdata : in std_logic_vector(15 downto 0);
      msb_pos : in std_logic_vector(1 downto 0);
      ext_data_in2_x1 : in std_logic_vector(31 downto 0);
      ext_data_in_x1 : in std_logic_vector(31 downto 0);
      clear_mem : in std_logic;
      areset_x6 : in std_logic;
      ext_data_out_x3 : out std_logic_vector(31 downto 0);
      ext_data_out2_x3 : out std_logic_vector(31 downto 0);
      histogram_rdy : out std_logic;
      timestamp_x3 : out std_logic_vector(31 downto 0);
      tmi_miso_busy : out std_logic;
      tmi_miso_error : out std_logic;
      tmi_miso_idle : out std_logic;
      tmi_miso_rd_data : out std_logic_vector(20 downto 0);
      tmi_miso_rd_dval : out std_logic;
      clk:in std_logic
      );
  end component;
begin
  tmi_mosi_rnw_net <= tmi_mosi_rnw;
  tmi_mosi_dval_net <= tmi_mosi_dval;
  tmi_mosi_add_net <= tmi_mosi_add;
  rx_tvalid_net <= rx_tvalid;
  rx_tready_net <= rx_tready;
  rx_tlast_net <= rx_tlast;
  rx_tdata_net <= rx_tdata;
  msb_pos_net <= msb_pos;
  ext_data_in2_x1_net <= ext_data_in2_x1;
  ext_data_in_x1_net <= ext_data_in_x1;
  clear_mem_net <= clear_mem;
  areset_x6_net <= areset_x6;
  ext_data_out_x3 <= ext_data_out_x3_net;
  ext_data_out2_x3 <= ext_data_out2_x3_net;
  histogram_rdy <= histogram_rdy_net;
  timestamp_x3 <= timestamp_x3_net;
  tmi_miso_busy <= tmi_miso_busy_net;
  tmi_miso_error <= tmi_miso_error_net;
  tmi_miso_idle <= tmi_miso_idle_net;
  tmi_miso_rd_data <= tmi_miso_rd_data_net;
  tmi_miso_rd_dval <= tmi_miso_rd_dval_net;
  clk_net <= clk;
  sysgen_dut: histogram_axis_tmi
  port map (
    tmi_mosi_rnw => tmi_mosi_rnw_net,
    tmi_mosi_dval => tmi_mosi_dval_net,
    tmi_mosi_add => tmi_mosi_add_net,
    rx_tvalid => rx_tvalid_net,
    rx_tready => rx_tready_net,
    rx_tlast => rx_tlast_net,
    rx_tdata => rx_tdata_net,
    msb_pos => msb_pos_net,
    ext_data_in2_x1 => ext_data_in2_x1_net,
    ext_data_in_x1 => ext_data_in_x1_net,
    clear_mem => clear_mem_net,
    areset_x6 => areset_x6_net,
    ext_data_out_x3 => ext_data_out_x3_net,
    ext_data_out2_x3 => ext_data_out2_x3_net,
    histogram_rdy => histogram_rdy_net,
    timestamp_x3 => timestamp_x3_net,
    tmi_miso_busy => tmi_miso_busy_net,
    tmi_miso_error => tmi_miso_error_net,
    tmi_miso_idle => tmi_miso_idle_net,
    tmi_miso_rd_data => tmi_miso_rd_data_net,
    tmi_miso_rd_dval => tmi_miso_rd_dval_net,
    clk => clk_net    );
end STRUCTURAL;
