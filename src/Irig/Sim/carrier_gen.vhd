-------------------------------------------------------------------------------
--
-- Title       : carrier_gen
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\carrier_gen.vhd
-- Generated   : Fri Sep 16 14:20:02 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.IRIG_define.all;

entity carrier_gen is
	 port(
		 ARESET  : in std_logic;
		 CLK     : in std_logic;
       CARRIER : out std_logic_vector(7 downto 0)
	     );
end carrier_gen;


architecture RTL of carrier_gen is
signal rrr : real;

begin
   
   -- ceci n'est pas conçu pour etre synthétisé !!!!!
   
   process(CLK)
   begin
    if rising_edge(CLK) then
          
       
       
    end if;  
   end process;
   
   
   
   


end RTL;
