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

entity adc_ctrl_sm is
   generic(
      TEST_PATTERN : std_logic_vector(13 downto 0) := "01" & x"CAB");
   port(
      CLK : in std_logic;
      ARESET : in std_logic;
      CAL_DONE : in std_logic;
      CS_N : out std_logic;
      SDI : out std_logic;
      SCLK : out std_logic;
      DVAL : out std_logic;
      PATTERN : out std_logic_vector(13 downto 0);
      DONE : out std_logic;
      PTRN_ON: out std_logic
      );
end adc_ctrl_sm;

architecture rtl of adc_ctrl_sm is
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   component spi_tx
      generic(
         CLKDIV : natural := 4;
         BITWIDTH : natural := 12);
      port(
         CLK : in std_logic;
         DIN : in std_logic_vector(BITWIDTH-1 downto 0);
         STB : in std_logic;
         ACK : out std_logic;
         CSn : out std_logic;
         SDA : out std_logic;
         SCL : out std_logic);
   end component;
   
   signal cfg : std_logic_vector(15 downto 0) := (others => '0');
   signal dval_spi, ack_i : std_logic := '0';
   signal sreset : std_logic := '0';
   signal done_i, ptrn_on_i : std_ulogic := '0';
   
begin
   
   DONE <= done_i;
   PTRN_ON <= ptrn_on_i;
   
   reset_sync : sync_reset
   port map (
      clk => CLK,
      areset => ARESET,
      sreset => sreset);
   
   spi_out : entity spi_tx
   generic map(
      CLKDIV => 10,
      BITWIDTH => 16)
   port map(
      CLK => CLK,
      DIN => cfg,
      STB => dval_spi,
      ACK => ack_i,
      CSn => CS_N,
      SDA => SDI,
      SCL => SCLK);
   
   process (CLK)
      variable state : unsigned(2 downto 0) := (others => '0');
      variable addr : std_logic_vector(6 downto 0) := (others => '0');
      variable data : std_logic_vector(7 downto 0) := (others => '0');
      variable rw_n : std_logic := '0';
      variable cfg_done : std_logic := '0';
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            dval_spi <= '0';
            state := (others => '0');
            cfg_done := '0';
            done_i <= '0';
            ptrn_on_i <= '0';
         else
            DVAL <= '1';
            PATTERN <= TEST_PATTERN;
            
            if CAL_DONE = '0' then
               if state = 0 then
                  addr := "000" & x"3";
                  data := "10" & TEST_PATTERN(13 downto 8);
                  dval_spi <= '1';
                  state := state + 1;
               elsif state = 2 then
                  addr := "000" & x"4";
                  data := TEST_PATTERN(7 downto 0);
                  dval_spi <= '1';
                  state := state + 1;
               else
                  dval_spi <= '0';
               end if;
               
               if state = 4 then
                  done_i <= '1';
                  ptrn_on_i <= '1';
               end if;
               
               cfg_done := '0';
               cfg <= rw_n & addr & data;
               if ack_i = '1' then
                  state := state + 1;
               end if;
            else
               if cfg_done = '0' then
                  cfg_done := '1';
                  addr := "000" & x"3";
                  data := "00" & TEST_PATTERN(13 downto 8);
                  dval_spi <= '1';
                  cfg <= rw_n & addr & data;
               else
                  dval_spi <= '0';
                  done_i <= '1';
                  ptrn_on_i <= '0';
               end if;
            end if;
            
         end if;
      end if;
      
   end process;
end rtl;
