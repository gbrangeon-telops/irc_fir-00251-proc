------------------------------------------------------------------
--!   @file : isc0207A_clks_mmcm
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

entity isc0207A_clks_mmcm is
   port(
      ARESET           : in std_logic;
      CLK_100M_IN      : in std_logic;
      --CLK_100M_OUT     : out std_logic;
      MCLK_SOURCE      : out std_logic;
      QUAD_PHASE_CLK   : out std_logic;
      MMCM_LOCKED      : out std_logic  
      );
end isc0207A_clks_mmcm;

architecture rtl of isc0207A_clks_mmcm is
   
   
   component isc0207A_5_0_MHz_mmcm
      port
         (
         clk_in            : in     std_logic;
         mclk_source       : out    std_logic;
         quad_phase_clk    : out    std_logic;
         reset             : in     std_logic;
         locked            : out    std_logic
         );
   end component; 
   
   
begin
   
   
   MCLK_5_0M_Gen : if DEFINE_FPA_MCLK_RATE_KHZ = 5_000 generate   
      begin                                             
      U10M :  isc0207A_5_0_MHz_mmcm
      port map (   
         clk_in         => CLK_100M_IN,
         mclk_source    => MCLK_SOURCE,       --  
         quad_phase_clk => QUAD_PHASE_CLK,    --   
         reset          => ARESET,
         locked         => MMCM_LOCKED            
         );      
   end generate;   

   
end rtl;
