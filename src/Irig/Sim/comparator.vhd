-------------------------------------------------------------------------------
--
-- Title       : comparator
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\comparator.vhd
-- Generated   : Sun Sep 18 12:56:14 2011
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
use IEEE.numeric_std.all;

entity comparator is
   port(
      ARESET         : in std_logic;
      CLK            : in std_logic;
      IRIG_SIGNAL    : in std_logic_vector(7 downto 0);
      IRIG_CMP_OUT   : out std_logic
      );
end comparator;


architecture RTL of comparator is
begin
   
   -- detections  des debuts de cycles 
   U1: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            IRIG_CMP_OUT <= '0';
         else   
            
            if signed(IRIG_SIGNAL) > 0  then 
               IRIG_CMP_OUT <= '1';
            else
               IRIG_CMP_OUT <= '0';
            end if;
            
         end if;                                  
      end if;   
   end process; 
   
end RTL;
