-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library work;
entity histogram_axis_tmi_stub is
  port (
    areset : in std_logic;
    clear_mem : in std_logic;
    ext_data_in : in std_logic_vector( 32-1 downto 0 );
    ext_data_in2 : in std_logic_vector( 32-1 downto 0 );
    msb_pos : in std_logic_vector( 2-1 downto 0 );
    rx_tdata : in std_logic_vector( 16-1 downto 0 );
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
end histogram_axis_tmi_stub;
architecture structural of histogram_axis_tmi_stub is 
begin
  sysgen_dut : entity work.histogram_axis_tmi 
  port map (
    areset => areset,
    clear_mem => clear_mem,
    ext_data_in => ext_data_in,
    ext_data_in2 => ext_data_in2,
    msb_pos => msb_pos,
    rx_tdata => rx_tdata,
    rx_tlast => rx_tlast,
    rx_tready => rx_tready,
    rx_tvalid => rx_tvalid,
    tmi_mosi_add => tmi_mosi_add,
    tmi_mosi_dval => tmi_mosi_dval,
    tmi_mosi_rnw => tmi_mosi_rnw,
    clk => clk,
    ext_data_out => ext_data_out,
    ext_data_out2 => ext_data_out2,
    histogram_rdy => histogram_rdy,
    timestamp => timestamp,
    tmi_miso_busy => tmi_miso_busy,
    tmi_miso_error => tmi_miso_error,
    tmi_miso_idle => tmi_miso_idle,
    tmi_miso_rd_data => tmi_miso_rd_data,
    tmi_miso_rd_dval => tmi_miso_rd_dval
  );
end structural;
