-------------------------------------------------------------------------------
--
-- Title       : TB STIM
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\clink\Sim\src\tb_stim.vhd
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

entity tb_clocks is
   port(
      CLK100    : out std_ulogic;
      CLK200    : out std_ulogic;
      CLK40     : out std_ulogic;
      CLK40_PH0 : out std_ulogic;
      CLK40_PH1 : out std_ulogic;
      CLK40_PH2 : out std_ulogic;
      ARESET    : out std_ulogic
      );
end tb_clocks;

architecture rtl of tb_clocks is
   
   -- CLK and RESET
   signal clk100_o, clk200_o : std_ulogic := '0';
   signal clk40_o, clk40_ph0_o, clk40_ph1_o, clk40_ph2_o : std_ulogic := '0';
   signal rst_i : std_ulogic := '1';
      
   -- CLK and RESET
   constant RESET_DURATION : time := 1 us;
   constant CLK100_per : time := 10 ns;
   constant CLK200_per : time := 5 ns;
   constant CLK40_per  : time := 25 ns;
   
begin
   -- Assign clock
   CLK100 <= clk100_o;
   CLK200 <= clk200_o;
   CLK40 <= clk40_o;
   CLK40_PH0 <= clk40_ph0_o;
   CLK40_PH1 <= clk40_ph1_o;
   CLK40_PH2 <= clk40_ph2_o; 
   
   ARESET <= rst_i;
   
   clk100_o <= not clk100_o after CLK100_per/2;
   
   clk200_o <= not clk200_o after CLK200_per/2;
   
   CLK40_GEN: process
   begin
      wait for 1ns;
      loop
         clk40_o <= not clk40_o after CLK40_per/2;
         wait on clk40_o;
      end loop;
   end process;
   
   clk40_ph0_o <= transport clk40_o after CLK40_per/8; -- 45°
   clk40_ph1_o <= transport clk40_o after CLK40_per/4; -- 90°
   clk40_ph2_o <= not clk40_o; -- 180 °
     
   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for RESET_DURATION;
      rst_i <= '0'; 
      wait;
   end process;
   
end rtl;
