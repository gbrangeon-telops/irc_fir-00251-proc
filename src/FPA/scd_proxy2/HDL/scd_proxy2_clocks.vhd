------------------------------------------------------------------
--!   @file : scd_proxy2_clocks
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
use work.fpa_common_pkg.all;
use work.fpa_define.all;

entity scd_proxy2_clocks is
   port(
      
      ARESET           : in std_logic;
      CLK_100M_IN      : in std_logic;
      
      MMCM_LOCKED      : out std_logic;
      
      TX_CLK           : out std_logic;
      CLK_100M         : out std_logic;
      
      INT_CLK_SOURCE   : out std_logic;
      QUAD_CLK_SOURCE  : out std_logic      
      
      );
end scd_proxy2_clocks;

architecture rtl of scd_proxy2_clocks is
   
   component bb1920D_clks_mmcm 
      port ( 
         clk_in         : in  std_logic;
         reset          : in  std_logic;
         locked         : out std_logic; 
         clk_100        : out std_logic;
         int_clk_source : out std_logic        
         );
   end component;
   
   signal  clk_100_i        : std_logic;
   signal  int_clk_source_i : std_logic;
   
begin
   
   Gen_BB1920 : if (DEFINE_FPA_ROIC = FPA_ROIC_BLACKBIRD1920)  generate   
      begin  
         
      U1 :  bb1920D_clks_mmcm
      port map (   
         clk_in          => CLK_100M_IN,
         reset           => ARESET, 
         locked          => MMCM_LOCKED,   
         clk_100         => clk_100_i,
         int_clk_source  => int_clk_source_i            
         ); 
      
      TX_CLK          <=  clk_100_i;         
      CLK_100M        <=  clk_100_i;           
      INT_CLK_SOURCE  <=  int_clk_source_i;
      QUAD_CLK_SOURCE <=  int_clk_source_i;   
      
   end generate;
   
end rtl;
