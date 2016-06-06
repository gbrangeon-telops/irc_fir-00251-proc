------------------------------------------------------------------
--!   @file : scorpiomwA_clks_mmcm
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.FPA_Define.all; 
use work.fpa_common_pkg.all;

entity scorpiomwA_clks_mmcm is
   port(
      ARESET           : in std_logic;
      CLK_80M          : in std_logic;
      MCLK_SOURCE      : out std_logic;
      ADC_PHASE_CLK    : out std_logic;
      MMCM_LOCKED      : out std_logic  
      );
end scorpiomwA_clks_mmcm;

architecture rtl of scorpiomwA_clks_mmcm is
   
   component scorpiomwA_10MHz_mmcm
      port
         (
         clk_in            : in     std_logic;
         mclk_source       : out    std_logic;
         adc_phase_clk     : out    std_logic;
         reset             : in     std_logic;
         locked            : out    std_logic
         );
   end component; 
   
   component scorpiomwA_15MHz_mmcm
      port
         (
         clk_in            : in     std_logic;
         mclk_source       : out    std_logic;
         adc_phase_clk     : out    std_logic;
         reset             : in     std_logic;
         locked            : out    std_logic
         );
   end component;
   
   component scorpiomwA_18MHz_mmcm
      port
         (
         clk_in            : in     std_logic;
         mclk_source       : out    std_logic;
         adc_phase_clk     : out    std_logic;
         reset             : in     std_logic;
         locked            : out    std_logic
         );
   end component;
   
   component scorpiomwA_17MHz_mmcm
      port
         (
         clk_in            : in     std_logic;
         mclk_source       : out    std_logic;
         adc_phase_clk     : out    std_logic;
         reset             : in     std_logic;
         locked            : out    std_logic
         );
   end component;
   
   
begin
   
   
   MCLK10M_Gen : if DEFINE_FPA_MCLK_RATE_KHZ = 10_000 generate   
      begin                                             
      U10M :  scorpiomwA_10MHz_mmcm
      port map (   
         clk_in         => CLK_80M,
         mclk_source    => MCLK_SOURCE,      --  80 MHz
         adc_phase_clk  => ADC_PHASE_CLK,    -- 160 MHz        soit 6.25 ns de delai par tap 
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;
   
   
   MCLK15M_Gen : if DEFINE_FPA_MCLK_RATE_KHZ = 15_000 generate   
      begin                                             
      U15M :  scorpiomwA_15MHz_mmcm
      port map (   
         clk_in         => CLK_80M,
         mclk_source    => MCLK_SOURCE,        --  60 MHz
         adc_phase_clk  => ADC_PHASE_CLK,      -- 180 MHz      soit 5.6 ns de delai par tap  
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;
   
   
   MCLK18M_Gen : if DEFINE_FPA_MCLK_RATE_KHZ = 18_000 generate   
      begin                                             
      U18M :  scorpiomwA_18MHz_mmcm
      port map (   
         clk_in         => CLK_80M,
         mclk_source    => MCLK_SOURCE,        --  72 MHz
         adc_phase_clk  => ADC_PHASE_CLK,      -- 144 MHz      soit 6.9 ns de delai par tap  
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;
   
   MCLK17M_Gen : if DEFINE_FPA_MCLK_RATE_KHZ = 17_500 generate   
      begin                                             
      U17M :  scorpiomwA_17MHz_mmcm
      port map (   
         clk_in         => CLK_80M,
         mclk_source    => MCLK_SOURCE,        --  70.0 MHz
         adc_phase_clk  => ADC_PHASE_CLK,      -- 210.0 MHz      soit 4.8 ns de delai par tap  
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;
   
end rtl;
