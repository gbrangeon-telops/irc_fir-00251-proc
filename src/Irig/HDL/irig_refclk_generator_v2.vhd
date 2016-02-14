-------------------------------------------------------------------------------
--
-- Title       : irig_refclk_generator_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_refclk_generator_v2.vhd
-- Generated   : Tue Sep 13 15:39:08 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--library Common_HDL;
--use Common_HDL.Telops.all;
use work.IRIG_define_v2.all;

entity irig_refclk_generator_v2 is
   port(
      ARESET             : in std_logic;
      CLK                : in std_logic;
      CARRIER_REFPULSE   : out std_logic;
      ALPHAB_REFPULSE    : out std_logic      
      );
end irig_refclk_generator_v2;


architecture RTL of irig_refclk_generator_v2 is 
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK    : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component; 
   
   component clk_divider_pulse 
      generic(
         FACTOR : integer);
      port(
         CLOCK     : in  std_logic;
         RESET     : in  std_logic;
         PULSE     : out std_logic);
   end component;
   
   
   signal sreset                 : std_logic; 
   signal carrier_refpulse_i       : std_logic;
   signal alphab_refpulse_i        : std_logic;
   
begin           
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      );      
   
   --------------------------------------------------
   -- generation d'une horloge de porteuse interne
   -------------------------------------------------- 
   U2 :clk_divider_pulse
   generic map(FACTOR => IRIG_CARRIER_PERIOD)
   port map(CLOCK => CLK, RESET => sreset, PULSE => carrier_refpulse_i); 
   
   
   --------------------------------------------------
   -- generation d'une horloge de morpheme interne
   -------------------------------------------------- 
   U3 :clk_divider_pulse
   generic map(FACTOR => IRIG_MORPHEME_PERIOD)
   port map(CLOCK => CLK, RESET => sreset, PULSE => alphab_refpulse_i);
   
   
   --------------------------------------------------
   -- sorties via registres
   -------------------------------------------------- 
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then
         CARRIER_REFPULSE <= carrier_refpulse_i;
         ALPHAB_REFPULSE <= alphab_refpulse_i;           
      end if;      
   end process;
   
   
   
end RTL;
