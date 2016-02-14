-------------------------------------------------------------------------------
--
-- Title       : data_mgt_stim
-- Design      : FIR_00251
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\aldec\src\Testbench\IP\data_mgt\data_mgt_stim.vhd
-- Generated   : Thu Jan  9 11:40:23 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {data_mgt_stim} architecture {data_mgt_stim}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
--library TEL2000;
use work.TEL2000.all;

entity data_mgt_stim is
port(
   RESET : out std_logic;
   GT_RESET : out std_logic;
   CLK_50MHZ : out std_logic;
   CLK_125MHZ : out std_logic;
   LOOPBACK : out std_logic_vector(2 downto 0);
   
   TX_CLK : in std_logic;
   
   DATA_TEST_mosi : out t_axi4_stream_mosi64;
   DATA_TEST_miso : in t_axi4_stream_miso;
   
   DATA_VERIF_mosi : in t_axi4_stream_mosi64;
   DATA_VERIF_miso : out t_axi4_stream_miso
   );
end data_mgt_stim;

--}} End of automatically maintained section

architecture data_mgt_stim of data_mgt_stim is

constant clk_50Mhz_period : time := 20ns;
constant clk_125Mhz_period : time := 8ns;
constant RESET_LENGTH : time := 200ns;
constant GT_RESET_LENGTH : time:= 128 ns;

signal CLK_50MHZ_i : std_logic := '0';
signal CLK_125MHZ_i : std_logic := '0';

begin

CLK_50MHZ <= CLK_50MHZ_i;  
CLK_125MHZ <= CLK_125MHZ_i;


   -- enter your statements here --        
CLK50MHZ_GEN: process(CLK_50MHZ_i)
begin
	CLK_50MHZ_i<= not CLK_50MHZ_i after clk_50Mhz_period/2; 
end process;

CLK125MHz_GEN: process(CLK_125MHZ_i)
begin
	CLK_125MHZ_i<= not CLK_125MHZ_i after clk_125Mhz_period/2; 
end process;

GT_RES: process
begin
	GT_RESET<='1';  -- reset of the counter
	wait for GT_RESET_LENGTH;
	GT_RESET<='0';
	wait;
end process;

RES: process
begin
	RESET<='1';  -- reset of the counter
	wait for RESET_LENGTH;
	RESET<='0';
	wait;
end process;



LOOPBACK <= "000";

STIM : process
begin
   DATA_TEST_mosi.TDATA <= (others => '0');
   DATA_TEST_mosi.TVALID <= '0';
   DATA_TEST_mosi.TSTRB <= (others => '0');
   DATA_TEST_mosi.TKEEP <= (others => '0');
   DATA_TEST_mosi.TLAST <= '0';
   
   DATA_VERIF_miso.TREADY <= '0';
   
   wait for 60 us;
   
   for i in 1 to 100 loop
      wait until TX_CLK = '1';
      if DATA_TEST_miso.TREADY = '1' then
         DATA_TEST_mosi.TVALID <= '1';
         DATA_TEST_mosi.TDATA <= std_logic_vector(to_unsigned(i*100,DATA_TEST_mosi.TDATA'length));
         DATA_TEST_mosi.TSTRB <= (others => '1');
         DATA_TEST_mosi.TKEEP <= (others => '1');
         if i = 99 then
            DATA_TEST_mosi.TLAST <= '1';
         else
            DATA_TEST_mosi.TLAST <= '0';
         end if;
      end if;
   end loop;
   
end process;

end data_mgt_stim;
