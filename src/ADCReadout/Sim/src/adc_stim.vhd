-------------------------------------------------------------------------------
--
-- Title       : adc_readout_tb_stim
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
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
use work.tel2000.all;

entity adc_stim is
    generic(
    CLK_OUT1_PERIOD : time := 10 ns;
    CLK_OUT2_PERIOD : time := 10 ns
    );
   port(
   CLK1_OUT : out std_logic;
   CLK2_OUT : out std_logic;
   ARESETN : out std_logic;
   ARESET  : out std_logic
      );
end adc_stim;

architecture sim of adc_stim is

-- CLK and RESET
signal clk1_o : std_logic := '0';
signal clk2_o : std_logic := '0';
signal rstn_i : std_logic := '0';

begin
   
   CLK1_OUT <= clk1_o;
   CLK2_OUT <= clk2_o;
   ARESETN <= rstn_i;
   ARESET <= not rstn_i;
   
   CLK1_GEN: process(clk1_o)
   begin
      clk1_o <= not clk1_o after CLK_OUT1_PERIOD/2;                          
   end process;
   
   CLK2_GEN: process(clk2_o)
   begin
      clk2_o <= not clk2_o after CLK_OUT2_PERIOD/2;                          
   end process;
   

   
   --! Reset Generation
   RST_GEN : process
   begin          
      rstn_i <= '0';
      wait for 5 us;
      rstn_i <= '1'; 
      wait;
   end process;
   
end sim;