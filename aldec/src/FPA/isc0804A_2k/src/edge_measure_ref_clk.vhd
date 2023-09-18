------------------------------------------------------------------
--!   @file : edge_measure_ref_clk
--!   @brief
--!   @details
--!
--!   $Rev: 20057 $
--!   $Author: enofodjie $
--!   $Date: 2017-02-05 15:16:08 -0500 (dim., 05 fÃ©vr. 2017) $
--!   $Id: edge_measure_ref_clk.vhd 20057 2017-02-05 20:16:08Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0804A/src/edge_measure_ref_clk.vhd $
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
   
   REF_CLK <= clk_i;
   
   -- clk
   U1: process(clk_i)
   begin
      clk_i <= not clk_i after REF_CLK_PERIOD/2; 
   end process;
   
   
end rtl;
