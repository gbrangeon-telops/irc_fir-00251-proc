------------------------------------------------------------------
--!   @file : calcium_clks_gen
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
use IEEE.numeric_std.all;
use work.fpa_define.all;
use work.proxy_define.all;

entity calcium_clks_gen is
   port (
      ARESET         : in std_logic;
      CLK_100M       : in std_logic;
      
      FPA_INTF_CFG   : in fpa_intf_cfg_type;
      
      GLOBAL_RST     : out std_logic;
      
      CLK_DDR        : out std_logic
   );
end calcium_clks_gen;

architecture rtl of calcium_clks_gen is
   
   component rst_conditioner is
      generic (
         RESET_PULSE_DELAY : natural := 80; 
         RESET_PULSE_LEN   : natural := 9
      );
      port ( 
         ARESET      : in std_logic;
         SLOWEST_CLK : in std_logic;
         ORST        : out std_logic   
      );
   end component;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;

   component calciumD_clks_mmcm 
      port ( 
         clk_in         : in  std_logic;
         reset          : in  std_logic;
         locked         : out std_logic; 
         clk_ddr        : out std_logic
      );
   end component;
   
   signal sreset              : std_logic;
   signal cond_reset_in       : std_logic;
   signal mmcm_locked_i       : std_logic;
   
begin
   
   --------------------------------------------------
   -- Resets
   --------------------------------------------------   
   U1A : rst_conditioner
   generic map (
      RESET_PULSE_DELAY => 80,
      RESET_PULSE_LEN   => 9
   )
   port map (
      ARESET      => cond_reset_in,
      SLOWEST_CLK => CLK_100M,
      ORST        => GLOBAL_RST
   );
   cond_reset_in <= not mmcm_locked_i;
   
   U1B : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK_100M,
      SRESET => sreset
   );
   
   --------------------------------------------------
   -- Clock Wizard
   --------------------------------------------------
   U2 :  calciumD_clks_mmcm
   port map (   
      clk_in          => CLK_100M,
      reset           => ARESET, 
      locked          => mmcm_locked_i,   
      clk_ddr         => CLK_DDR
   );
   
end rtl;
