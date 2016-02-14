-------------------------------------------------------------------------------
--
-- Title       : irig_reset_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_reset_v2.vhd
-- Generated   : Thu Sep 27 10:53:37 2012
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

entity irig_reset_v2 is
   port(
      ARESET     : in std_logic;
      CLK        : in std_logic;
      IRIG_RESET : out STD_LOGIC
      );
end irig_reset_v2;


architecture RTL of irig_reset_v2 is
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
   
   
   signal sreset                   : std_logic; 
   signal one_sec_pulse            : std_logic;
   signal sec_count                : unsigned(7 downto 0);
   
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
   -- generation d'une horloge de 1sec
   -------------------------------------------------- 
   U2 :clk_divider_pulse
   generic map(FACTOR => SYS_CLK_FREQ_HZ)
   port map(CLOCK => CLK, RESET => sreset, PULSE => one_sec_pulse); 
   
   --------------------------------------------------
   -- sorties via registres
   -------------------------------------------------- 
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            IRIG_RESET <= '1';
            sec_count <= (others => '0');
         else
            if sec_count > 5 then
               IRIG_RESET <= '0'; 
            else 
               if one_sec_pulse = '1' then
                  sec_count <= sec_count + 1;
               end if;
            end if;
            -- pragma translate_off
                IRIG_RESET <= '0'; 
            -- pragma translate_on         
         end if;     
      end if;
   end process;
   
   
end RTL;
