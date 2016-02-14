-------------------------------------------------------------------------------
--
-- Title       : peak_detector
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\peak_detector.vhd
-- Generated   : Sun Sep 18 13:03:46 2011
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

entity peak_detector is
   port(         
      ARESET              : in std_logic;  
      CLK                 : in std_logic;
      IRIG_SIGNAL         : in std_logic_vector(7 downto 0);
      IRIG_SIGNAL_DVAL    : in std_logic;
      IRIG_CMP_OUT        : in std_logic;
      PEAK_SIGNAL         : out std_logic_vector(7 downto 0)
      );
end peak_detector;


architecture RTL of peak_detector is
   signal maximum_i  : signed(7 downto 0);
begin
   
   PEAK_SIGNAL <= std_logic_vector(maximum_i);
   
   -- detections des passages à '0'
   U1: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            maximum_i <= (others => '0');
         else            
            
            if IRIG_CMP_OUT = '1' and IRIG_SIGNAL_DVAL ='1' then 
               if maximum_i < signed(IRIG_SIGNAL) then 
                  maximum_i <= signed(IRIG_SIGNAL); 
               end if;
            else
               maximum_i <= (others => '0'); 
            end if;
         end if;                                  
      end if;   
   end process;
   
   
end RTL;
