-------------------------------------------------------------------------------
--
-- Title       : TB STIM
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\clink\Sim\src\data_gen.vhd
-- Generated   : Thu Jan 30 13:26:14 2014
-- From        : interface description file
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;                                             
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_gen is
   port(
      CLK40    : in std_ulogic;
      ARESET   : in std_ulogic;
      EN       : in std_logic;
      DATA     : out std_logic_vector(13 downto 0)
      );
end data_gen;

architecture rtl of data_gen is
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   signal sreset : std_ulogic := '1';
   
   signal data_i : unsigned(13 downto 0) := "10101010101010";
   
   constant INIT_DATA : unsigned(15 downto 0) := x"DCBA";
   
begin
   reset_sync : sync_reset
   port map (
      clk => CLK40,
      areset => ARESET,
      sreset => sreset);
   
   DATA <= std_logic_vector(data_i);
   
   --! Reset Generation
   gen_data : process(CLK40)
   begin          
      if rising_edge(CLK40) then
         if sreset = '1' then
            data_i <= (others => '0');
         else
            if EN = '1' then
               data_i <= data_i + 1;
            end if;
         end if;
      end if;
   end process;
   
end rtl;
