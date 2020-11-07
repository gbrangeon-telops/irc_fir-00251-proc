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
         clk_70         : out std_logic;
         clk_140        : out std_logic
         );
   end component;
   
   signal  clk_a     : std_logic;
   signal  clk_b     : std_logic;
   signal  clk_c     : std_logic;
   
begin
   
   Gen_BB1920_4CHN : if (DEFINE_FPA_ROIC = FPA_ROIC_BLACKBIRD1920) and  (DEFINE_FPA_PIX_NUM_PER_PCLK = 4) generate   
      begin  
      
      U1 :  bb1920D_clks_mmcm
      port map (   
         clk_in          => CLK_100M_IN,
         reset           => ARESET, 
         locked          => MMCM_LOCKED,   
         clk_100         => clk_a,
         clk_70          => clk_b,
         clk_140         => clk_c
         ); 
      
      TX_CLK          <=  clk_b;   --  70 MHz       
      CLK_100M        <=  clk_a;   -- 100 MHz        
      INT_CLK_SOURCE  <=  clk_b;   --  70 MHz
      QUAD_CLK_SOURCE <=  clk_b;   --  70 MHz
      
   end generate;
   
      Gen_BB1920_8CHN : if (DEFINE_FPA_ROIC = FPA_ROIC_BLACKBIRD1920) and  (DEFINE_FPA_PIX_NUM_PER_PCLK = 8) generate   
      begin  
      
      U1 :  bb1920D_clks_mmcm
      port map (   
         clk_in          => CLK_100M_IN,
         reset           => ARESET, 
         locked          => MMCM_LOCKED,   
         clk_100         => clk_a,
         clk_70          => clk_b,
         clk_140         => clk_c
         ); 
      
      TX_CLK          <=  clk_c;   -- 140 MHz       
      CLK_100M        <=  clk_a;   -- 100 MHz        
      INT_CLK_SOURCE  <=  clk_b;   --  70 MHz
      QUAD_CLK_SOURCE <=  clk_b;   --  70 MHz
      
   end generate;
   
end rtl;
