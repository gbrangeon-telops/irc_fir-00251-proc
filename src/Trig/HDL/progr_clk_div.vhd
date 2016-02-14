-------------------------------------------------------------------------------
--
-- Title       : progr_clk_div
-- Design      : Trig_ctrl_tb
-- Author      : Telops Inc
-- Company     : Telops Inc
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Mon Nov  2 14:40:02 2009
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {progr_clk_div} architecture {progr_clk_div}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 

entity progr_clk_div is
   
   port (
      CLK              : in  std_logic; 	
      ARESET           : in  std_logic;
      CNT_RAZ			  : in  std_logic;
      PULSE_PERIOD     : in  std_logic_vector(31 downto 0);
      PULSE            : out std_logic);
end progr_clk_div;

--}} End of automatically maintained section

architecture RTL of progr_clk_div is
   signal sreset          : std_logic;
   signal div_cnt         : unsigned(PULSE_PERIOD'range);
   signal term_cnt        : std_logic;
   signal pulse_local     : std_logic;
   signal slower_clk      : std_logic;
   signal slower_clk_last : std_logic; 
   signal pulse_period_M_1: unsigned(PULSE_PERIOD'range);
   
   component sync_reset
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC;
         CLK    : in STD_LOGIC);
   end component;
   
begin 
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset,
      CLK   => CLK);
   
   -----------------------------------------------------
   -- output 
   -----------------------------------------------------
   PULSE <= pulse_local;
   -- detect the clock divider terminal count
   term_cnt <= '1' when (div_cnt = pulse_period_M_1) else '0';
   
   -- divide incoming clock to generate slower clock
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if (sreset = '1') or CNT_RAZ ='1' then
            div_cnt <= unsigned(PULSE_PERIOD) - 1;
            slower_clk <= '0';
            pulse_period_M_1 <= unsigned(PULSE_PERIOD) - 1;
         else	 
            pulse_period_M_1 <= unsigned(PULSE_PERIOD) - 1;            
            if (term_cnt = '1') then
               div_cnt <= (others =>'0');
               slower_clk <= '1';
            else 					
               div_cnt <= div_cnt + 1;
               slower_clk <= '0';
            end if;				
         end if;
      end if;
   end process;
   
   -- pulse gen	
   
   U3 : process(CLK)
   begin
      if rising_edge(CLK)  then
         if (sreset = '1') then
            pulse_local <= '0';	
            slower_clk_last <= '1';
         else  				
            slower_clk_last <= slower_clk;				
            if slower_clk = '1' and slower_clk_last = '0' then
               pulse_local <= '1';
            else
               pulse_local <= '0';
            end if;
         end if;
      end if;
   end process;
   
   
   
end RTL;
