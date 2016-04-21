------------------------------------------------------------------
--!   @file : edge_measure_ref_clk
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

entity edge_measure_ref_clk is
   port(
      ARESET  : in STD_LOGIC;
      REF_CLK : out STD_LOGIC
      );
end edge_measure_ref_clk;


architecture rtl of edge_measure_ref_clk is

   constant REF_CLK_PERIOD  : time := 1 ns;    -- on opère cette horloge à 1GHz
   signal clk_i             : std_logic := '0';
   
begin
   
   -- clk
   U1: process(clk_i)
   begin
      clk_i <= not clk_i after REF_CLK_PERIOD/2; 
   end process;
   
   
end rtl;
