-------------------------------------------------------------------------------
--
-- Title       : debug_data_sync
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Tue Nov 22 12:13:49 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : sync data from several clock domains to the clk100 domain (due to chipscope ila limitation...)
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work;
use work.fpa_serdes_define.all;

entity debug_data_sync is
   port(
      READY_IN         : in std_logic_vector(3 downto 0);
      BITSLIP_CNTS_IN  : in bitslip_cnt_array;
      DELAYS_IN        : in delay_array;
      EDGES_IN         : in edges_array;
      CLKOUT           : in std_logic;
      READY_OUT        : out std_logic_vector(3 downto 0);
      BITSLIP_CNTS_OUT : out bitslip_cnt_array;
      DELAYS_OUT       : out delay_array;
      EDGES_OUT        : out edges_array
      );
end debug_data_sync;

architecture RTL of debug_data_sync is
   component double_sync_vector is
      port(
         D : in STD_LOGIC_vector;
         Q : out STD_LOGIC_vector;
         CLK : in STD_LOGIC
         );
   end component;   
   
begin
   
   -- safely using a double sync for data buses here, assuming data is slow and stable, which is the case
   
   rdy_sync : double_sync_vector
   port map(
      D => READY_IN,
      Q => READY_OUT,
      CLK => CLKOUT);
   
   sync_data : for i in 0 to 3 generate
      edges_sync : double_sync_vector
      port map(
         D => EDGES_IN(i),
         Q => EDGES_OUT(i),
         CLK => CLKOUT);
      
      delay_sync : double_sync_vector
      port map(
         D => DELAYS_IN(i),
         Q => DELAYS_OUT(i),
         CLK => CLKOUT);
      
      
      bitslip_sync : double_sync_vector
      port map(
         D => BITSLIP_CNTS_IN(i),
         Q => BITSLIP_CNTS_OUT(i),
         CLK => CLKOUT);
      
   end generate;
   
end RTL;
