library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity adc_rcv_clk_7x is
   generic(
      INPUT_PERIOD : real := 25.0
      );
   port
      (-- Clock in ports
      clk_in           : in     std_logic;
      -- Clock out ports
      clk_1x          : out    std_logic;
      clk_7x          : out    std_logic;
      -- Status and control signals
      reset             : in     std_logic;
      locked            : out    std_logic
      );
end adc_rcv_clk_7x;

architecture xilinx of adc_rcv_clk_7x is
   -- Input clock buffering / unused connectors
   signal clk_in_adc_rcv_clk_7x40MHz      : std_logic;
   -- Output clock buffering / unused connectors
   signal clkfbout_adc_rcv_clk_7x40MHz         : std_logic;
   signal clkfbout_buf_adc_rcv_clk_7x40MHz     : std_logic;
   signal clkfboutb_unused : std_logic;
   signal clk_1x_adc_rcv_clk_7x40MHz          : std_logic;
   signal clkout0b_unused  : std_logic;
   signal clk_7x_adc_rcv_clk_7x40MHz          : std_logic;
   signal clkout1b_unused  : std_logic;
   signal clk_7x_b_adc_rcv_clk_7x40MHz          : std_logic;
   signal clkout2b_unused  : std_logic;
   signal clkout2_unused  : std_logic;
   signal clkout3_unused   : std_logic;
   signal clkout3b_unused  : std_logic;
   signal clkout4_unused   : std_logic;
   signal clkout5_unused   : std_logic;
   signal clkout6_unused   : std_logic;
   -- Dynamic programming unused signals
   signal do_unused        : std_logic_vector(15 downto 0);
   signal drdy_unused      : std_logic;
   -- Dynamic phase shift unused signals
   signal psdone_unused    : std_logic;
   signal locked_int : std_logic;
   -- Unused status signals
   signal clkfbstopped_unused : std_logic;
   signal clkinstopped_unused : std_logic;
   signal reset_high   : std_logic;
   
begin
   
   
   -- Input buffering
   --------------------------------------
   clkin1_ibufg : IBUF
   port map
      (O => clk_in_adc_rcv_clk_7x40MHz,
      I => clk_in);
   
   
   
   -- Clocking PRIMITIVE
   --------------------------------------
   -- Instantiation of the MMCM PRIMITIVE
   --    * Unused inputs are tied off
   --    * Unused outputs are labeled unused
   plle2_adv_inst : PLLE2_ADV
   generic map
      (BANDWIDTH            => "OPTIMIZED",
      COMPENSATION         => "ZHOLD",
      DIVCLK_DIVIDE        => 1,
      CLKFBOUT_MULT        => 35,
      CLKFBOUT_PHASE       => 0.000,
      CLKOUT0_DIVIDE       => 35,
      CLKOUT0_PHASE        => 0.000,
      CLKOUT0_DUTY_CYCLE   => 0.500,
      CLKOUT1_DIVIDE       => 5,
      CLKOUT1_PHASE        => 0.000,
      CLKOUT1_DUTY_CYCLE   => 0.500,
      CLKIN1_PERIOD        => INPUT_PERIOD,
      REF_JITTER1          => 0.010)
   port map
      -- Output clocks
      (
      CLKFBOUT            => clkfbout_adc_rcv_clk_7x40MHz,
      CLKOUT0             => clk_1x_adc_rcv_clk_7x40MHz,
      CLKOUT1             => clk_7x_adc_rcv_clk_7x40MHz,
      CLKOUT2             => clkout2_unused,
      CLKOUT3             => clkout3_unused,
      CLKOUT4             => clkout4_unused,
      CLKOUT5             => clkout5_unused,
      -- Input clock control
      CLKFBIN             => clkfbout_adc_rcv_clk_7x40MHz,--clkfbout_buf_adc_rcv_clk_7x40MHz,
      CLKIN1              => clk_in_adc_rcv_clk_7x40MHz,
      CLKIN2              => '0',
      -- Tied to always select the primary input clock
      CLKINSEL            => '1',
      -- Ports for dynamic reconfiguration
      DADDR               => (others => '0'),
      DCLK                => '0',
      DEN                 => '0',
      DI                  => (others => '0'),
      DO                  => do_unused,
      DRDY                => drdy_unused,
      DWE                 => '0',
      -- Other control and status signals
      LOCKED              => locked_int,
      PWRDWN              => '0',
      RST                 => reset_high);
   
   reset_high <= reset; 
   locked <= locked_int;
   
   -- Output buffering
   -------------------------------------
   
  -- clkf_buf : BUFH
--   port map
--      (O => clkfbout_buf_adc_rcv_clk_7x40MHz,
--      I => clkfbout_adc_rcv_clk_7x40MHz);
   --clkfbout_buf_adc_rcv_clk_7x40MHz <= clkfbout_adc_rcv_clk_7x40MHz;
   
   
   clkout1_buf : BUFG
   port map
      (O   => clk_1x,
      I   => clk_1x_adc_rcv_clk_7x40MHz);
   
   clkout2_buf : BUFG
   port map
      (O   => clk_7x,
      I   => clk_7x_adc_rcv_clk_7x40MHz);
   
end xilinx;
