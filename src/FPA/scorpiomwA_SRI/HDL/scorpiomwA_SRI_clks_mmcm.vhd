------------------------------------------------------------------
--!   @file : scorpiomwA_SRI_clks_mmcm
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

entity scorpiomwA_SRI_clks_mmcm is
   port(
      ARESET           : in std_logic;
      CLK_100M          : in std_logic;
      MCLK_SOURCE      : out std_logic;
      ADC_PHASE_CLK    : out std_logic;
      MMCM_LOCKED      : out std_logic  
      );
end scorpiomwA_SRI_clks_mmcm;

architecture rtl of scorpiomwA_SRI_clks_mmcm is
   
   component scorpiomwA_SRI_18MHz_mmcm
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
   
   MCLK18M_Gen : if DEFINE_FPA_MCLK_RATE_KHZ = 18_000 generate   
      begin                                             
      U18M :  scorpiomwA_SRI_18MHz_mmcm
      port map (   
         clk_in         => CLK_100M,
         mclk_source    => MCLK_SOURCE,        --  36 MHz
         adc_phase_clk  => ADC_PHASE_CLK,      -- 360 MHz      soit 2.8 ns de delai par tap  
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;
   
end rtl;
