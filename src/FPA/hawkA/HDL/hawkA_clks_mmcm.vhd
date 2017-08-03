------------------------------------------------------------------
--!   @file : hawkA_clks_mmcm
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

entity hawkA_clks_mmcm is
   port(
      ARESET           : in std_logic;
      CLK_100M          : in std_logic;
      MCLK_SOURCE      : out std_logic;
      ADC_PHASE_CLK    : out std_logic;
      MMCM_LOCKED      : out std_logic  
      );
end hawkA_clks_mmcm;

architecture rtl of hawkA_clks_mmcm is
   
   component hawkA_10MHz_mmcm
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
      U18M :  hawkA_10MHz_mmcm
      port map (   
         clk_in         => CLK_100M,
         mclk_source    => MCLK_SOURCE,        --  80 MHz
         adc_phase_clk  => ADC_PHASE_CLK,      -- 320 MHz      
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;
   
end rtl;
