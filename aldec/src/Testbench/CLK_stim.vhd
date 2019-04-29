------------------------------------------------------------------
--!   @file CLK_stim.vhd
--!   @brief Clocks stimulus.
--!   @details This files simulates the external clock for simulation. 
--!
--!   $Rev: 12770 $
--!   $Author: pdaraiche $
--!   $Date: 2013-12-20 12:01:34 -0500 (ven., 20 déc. 2013) $
--!   $Id: CLK_stim.vhd 12770 2013-12-20 17:01:34Z pdaraiche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/CLK_stim.vhd $
------------------------------------------------------------------

--! Call library IEEE for logic element
library IEEE;
--! Call logic element for std_logic
use IEEE.STD_LOGIC_1164.all;

--! Entity Declaration
entity CLK_stim is
   port(
      CLK100 : out std_logic; --! Clock 100MHz for MicroBlaze
      ARESETn : out std_logic --! Asynchronous Active Low Reset
      );
end CLK_stim;

--! Architecture Declaration
architecture CLK_stim of CLK_stim is
   signal CLK100i : std_logic := '0'; 
begin     
   
   CLK100 <= CLK100i;
   
   --! Clock 100MHz generation
   CLK_GEN100: process(CLK100i)
   begin
      CLK100i <= not CLK100i after 5 ns; 
   end process;
   
   --! Reset Generation
   RST_PROC : process
   begin          
      ARESETn <= '0';
      wait for 25 us;
      ARESETn <= '1'; 
      wait;
   end process;
   
end CLK_stim;
