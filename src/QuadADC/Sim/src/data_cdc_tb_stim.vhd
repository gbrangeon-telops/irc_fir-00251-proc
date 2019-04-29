---------------------------------------------------------------------------------------------------
--  Copyright (c) Telops Inc. 2007
--
--  File: spi_tx.vhd
--  Use: general purpose spi master interface (DACs etc...)
--  Author: Olivier Bourgois
--
--  $Revision$
--  $Author$
--  $LastChangedDate$
--
--  Notes: core divides incoming clock by CLKDIV to generate SPI clock must be at least a factor
--         of 2
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_cdc_tb_stim is
   port(
      CLK100 : out std_logic;
      CLK40 : out std_logic;
      ARESET : out std_logic;
      DVAL : out std_logic;
      DATA : out std_logic_vector(31 downto 0)
      );
end data_cdc_tb_stim;

architecture rtl of data_cdc_tb_stim is
   signal rst_i : std_ulogic := '1';
   signal clk100_i, clk40_i: std_ulogic := '0';
   
   signal data_i : unsigned(DATA'length-1 downto 0) := (others => '0');
   signal dval_i : std_ulogic := '0';
   
begin
   
   DVAL <= dval_i;
   DATA <= std_logic_vector(data_i);
   CLK100 <= clk100_i;
   CLK40 <= clk40_i;
   
   ARESET <= rst_i;
   
   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for 1us;
      rst_i <= '0'; 
      wait;
   end process;
   
   clk100_gen : process
   begin
      clk100_i <= not clk100_i after 5ns;
      wait on clk100_i;
   end process;
   
   clk40_gen : process
   begin
      clk40_i <= not clk40_i after 12.5ns;
      wait on clk40_i;
   end process;
   
   data_gen : process(clk40_i)
      variable cnt : integer range 0 to 15 := 0;
   begin
      if rst_i = '1' then
         dval_i <= '0';
         data_i <= (others => '0');
         cnt := 0;
      elsif rising_edge(clk40_i) then
         if cnt = 15 then
            data_i <= data_i + 1;
            dval_i <= '1';
         else
            cnt := cnt + 1;
         end if;
      end if;
   end process;
   
end rtl;
