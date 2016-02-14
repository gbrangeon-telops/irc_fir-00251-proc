-------------------------------------------------------------------------------
--
-- Title       : test_pattern_validator
-- Design      : adc_intf_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\QuadADC\HDL\test_pattern_validator.vhd
-- Generated   : Wed May 27 09:14:02 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_pattern_validator is
   generic(
      DEFAULT_PATTERN : std_ulogic_vector(13 downto 0) := "11111110000000"
      );
   port(
      CLK : in std_logic;
      ARESET : in std_logic;
      DATA : in std_logic_vector(13 downto 0); -- data under test
      START : in std_logic; -- start the test
      TEST_PATTERN : in std_logic_vector(13 downto 0); -- the pattern to be tested for, loaded when LOAD_PATTERN is asserted
      LOAD_PATTERN : in std_logic;
      PATTERN_VALID : out std_logic; -- valid when DONE is asserted
      DONE : out std_logic -- indicates that the test was completed
      );
end test_pattern_validator;

architecture rtl of test_pattern_validator is
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   signal sreset : std_ulogic;
   
   signal data_i, data_hold, data_1p : std_ulogic_vector(DATA'length-1 downto 0) := (others => '0');
   
   signal test_pattern_hold : std_ulogic_vector(DATA'length-1 downto 0) := (others => '0');
   
   signal test_started : std_ulogic := '0';
   signal done_i : std_ulogic := '0';
   signal pattern_valid_i : std_ulogic := '0';
   
   attribute dont_touch : string;
   attribute dont_touch of data_i : signal is "true";
   attribute dont_touch of pattern_valid_i : signal is "true";
   attribute dont_touch of done_i : signal is "true";
   
begin
   
   reset_sync : sync_reset
   port map (
      clk => CLK,
      areset => ARESET,
      sreset => sreset);
   
   data_i <= std_ulogic_vector(DATA);
   
   DONE <= done_i;
   PATTERN_VALID <= pattern_valid_i;
   
   test_pattern_loading : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            test_pattern_hold <= DEFAULT_PATTERN;
            test_started <= '0';
         else
            if LOAD_PATTERN = '1' then
               test_pattern_hold <= std_ulogic_vector(TEST_PATTERN);
            end if;
         end if;
      end if;
   end process;
   
   test : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            pattern_valid_i <= '0';
            done_i <= '0';
         else
            if START = '1' then
               if test_pattern_hold = data_i then
                  pattern_valid_i <= '1';
               else
                  pattern_valid_i <= '0';
               end if;
               done_i <= '1';
            else
               done_i <= '0';
            end if;
         end if;
      end if;
   end process;
   
end rtl;
