-- file: clink_serdes_clk_wrapper.vhd


library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.fpa_common_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity clink_serdes8_clk_wrapper is
   generic(
      PROXY_CLINK_CLK_1X_PERIOD_NS  : real := 25.0
      );
   
   port
      (-- Clock in ports
      PROXY_DCLK_IN                 : in     std_logic;
      -- Clock out ports
      PROXY_DCLK_OUT                : out    std_logic;
      PROXY_DCLK_OUT_MULT8          : out    std_logic;
      -- Status and control signals
      ARESET             : in     std_logic;
      LOCKED            : out    std_logic
      );
end clink_serdes8_clk_wrapper;

architecture xilinx of clink_serdes8_clk_wrapper is

   ----------------------------------------------------------------------------------
   -- For more details see :
   --    FPGA Data Sheet (DS182): MMCM Switching Characteristics section.
   --    FPGA Clocking Resources User Guide (UG472): Chapter 3 Clock Management Tile.
   ----------------------------------------------------------------------------------
   -- MMCM block diagram :
   -- clkin  ->  /D  ->  *M  ->  /out0  ->  clkout0 @ freqIn
   -- clkin  ->  /D  ->  *M  ->  /out1  ->  clkout1 @ 7*freqIn
   ----------------------------------------------------------------------------------
   -- D : 
   --    integer in range [1, 106]
   --    freqPFD = clkin / D must be in range [10, 450] MHz
   constant D : integer := 1;
   -- M : 
   --    integer in range [2, 64]
   --    freqVCO = clkin * M / D must be in range [600, 1200] MHz
   --    freqVCO must be as high as possible so M is calculated with freqVCOmax
   --    M must be divisible by 7
   constant Mideal : integer := integer(1200.0E6 * real(D) * PROXY_CLINK_CLK_1X_PERIOD_NS * 1.0E-9);
   constant Mvalid : integer := MIN(Mideal, 64);
   constant M : integer := Mvalid / 8 * 8;
   

   -- Input clock buffering / unused connectors
   signal PROXY_DCLK_IN_clink_serdes_clk_wrapper      : std_logic;
   -- Output clock buffering / unused connectors
   signal clkfbout_clink_serdes_clk_wrapper           : std_logic;
   signal clkfbout_buf_clink_serdes_clk_wrapper       : std_logic;
   signal clkfboutb_unused : std_logic;
   signal PROXY_DCLK_OUT_clink_serdes_clk_wrapper          : std_logic;
   signal clkout0b_unused  : std_logic;
   signal PROXY_DCLK_OUT_MULT8_clink_serdes_clk_wrapper          : std_logic;
   signal clkout1b_unused  : std_logic;
   signal clkout2_unused   : std_logic;
   signal clkout2b_unused  : std_logic;
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
   clkin1_bufg : BUFG
   port map
      (O => PROXY_DCLK_IN_clink_serdes_clk_wrapper,
      I => PROXY_DCLK_IN);
   
   
   
   -- Clocking PRIMITIVE
   --------------------------------------
   -- Instantiation of the MMCM PRIMITIVE
   --    * Unused inputs are tied off
   --    * Unused outputs are labeled unused
   mmcm_adv_inst : MMCME2_ADV
   generic map
      (BANDWIDTH            => "OPTIMIZED",
      CLKOUT4_CASCADE      => FALSE,
      COMPENSATION         => "ZHOLD",
      STARTUP_WAIT         => FALSE,
      DIVCLK_DIVIDE        => D,
      CLKFBOUT_MULT_F      => real(M),
      CLKFBOUT_PHASE       => 0.000,
      CLKFBOUT_USE_FINE_PS => FALSE,
      CLKOUT0_DIVIDE_F     => real(M),
      CLKOUT0_PHASE        => 0.000,
      CLKOUT0_DUTY_CYCLE   => 0.500,
      CLKOUT0_USE_FINE_PS  => FALSE,
      CLKOUT1_DIVIDE       => M/8,
      CLKOUT1_PHASE        => 0.000,
      CLKOUT1_DUTY_CYCLE   => 0.500,
      CLKOUT1_USE_FINE_PS  => FALSE,
      CLKIN1_PERIOD        => PROXY_CLINK_CLK_1X_PERIOD_NS,
      REF_JITTER1          => 0.072)
   port map
      -- Output clocks
      (
      CLKFBOUT            => clkfbout_clink_serdes_clk_wrapper,
      CLKFBOUTB           => clkfboutb_unused,
      CLKOUT0             => PROXY_DCLK_OUT_clink_serdes_clk_wrapper,
      CLKOUT0B            => clkout0b_unused,
      CLKOUT1             => PROXY_DCLK_OUT_MULT8_clink_serdes_clk_wrapper,
      CLKOUT1B            => clkout1b_unused,
      CLKOUT2             => clkout2_unused,
      CLKOUT2B            => clkout2b_unused,
      CLKOUT3             => clkout3_unused,
      CLKOUT3B            => clkout3b_unused,
      CLKOUT4             => clkout4_unused,
      CLKOUT5             => clkout5_unused,
      CLKOUT6             => clkout6_unused,
      -- Input clock control
      CLKFBIN             => clkfbout_buf_clink_serdes_clk_wrapper,
      CLKIN1              => PROXY_DCLK_IN_clink_serdes_clk_wrapper,
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
      -- Ports for dynamic phase shift
      PSCLK               => '0',
      PSEN                => '0',
      PSINCDEC            => '0',
      PSDONE              => psdone_unused,
      -- Other control and status signals
      LOCKED              => locked_int,
      CLKINSTOPPED        => clkinstopped_unused,
      CLKFBSTOPPED        => clkfbstopped_unused,
      PWRDWN              => '0',
      RST                 => reset_high);
   
   reset_high <= ARESET; 
   LOCKED <= locked_int;
   
   -- Output buffering
   -------------------------------------
   
   clkf_buf : BUFG
   port map
      (O => clkfbout_buf_clink_serdes_clk_wrapper,
      I => clkfbout_clink_serdes_clk_wrapper);
   
   
   
   clkout1_buf : BUFG
   port map
      (O   => PROXY_DCLK_OUT,
      I   => PROXY_DCLK_OUT_clink_serdes_clk_wrapper);
   
   
   
   clkout2_buf : BUFG
   port map
      (O   => PROXY_DCLK_OUT_MULT8,
      I   => PROXY_DCLK_OUT_MULT8_clink_serdes_clk_wrapper);
   
end xilinx;
