-- file: Clink_ch0_tb.vhd
-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

------------------------------------------------------------------------------
-- SelectIO wizard demonstration testbench
------------------------------------------------------------------------------
-- This demonstration testbench instantiates the example design for the 
--   SelectIO wizard. 
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

library work;
use work.all;

entity Clink_ch_tb is
end Clink_ch_tb;

architecture test of Clink_ch_tb is

component Clink_ch_exdes
port (
  pattern_completed_out     : out   std_logic_vector (1 downto 0);
  -- From the system into the device
  data_in_from_pins_p      : in    std_logic_vector(3 downto 0);
  data_in_from_pins_n      : in    std_logic_vector(3 downto 0);
  data_out_to_pins_p         : out   std_logic_vector(3 downto 0);
  data_out_to_pins_n         : out   std_logic_vector(3 downto 0);

  clk_in                   : in    std_logic;
  clk_in_n                   : in    std_logic;
  clock_enable             : in    std_logic;
  delay_locked             : out   std_logic;
  ref_clock                : in    std_logic;
  clk_reset                : in    std_logic;
  io_reset                 : in    std_logic);
end component;
  constant clk_per         : time    :=  10 ns; -- 100 MHz clk
  constant SYS_W           : integer := 4;
  constant DEV_W           : integer := 28;
  constant num_serial_bits : integer := DEV_W/SYS_W;
  -- From the system into the device
  signal   data_in_from_pins_p : std_logic_vector(SYS_W-1 downto 0);
  signal   data_in_from_pins_n : std_logic_vector(SYS_W-1 downto 0);
  signal   data_out_to_pins_p : std_logic_vector(SYS_W-1 downto 0);
  signal   data_out_to_pins_n : std_logic_vector(SYS_W-1 downto 0);
  signal   clk_in             : std_logic := '0';
  signal   clk_in_n             : std_logic := '1';
  signal   clk_reset          : std_logic;
  signal   io_reset           : std_logic;
  signal   io_reset1           : std_logic;
  signal   pattern_completed_out : std_logic_vector (1 downto 0);
  signal   pattern_completed_out1 : std_logic_vector (1 downto 0);
  signal   timeout_counter : std_logic_vector (10 downto 0) := "00000000000";
  signal   bitslip_timeout : std_logic_vector (16 downto 0) := "00000000000000000";

begin




  -- Any aliases

  -- clock generator- 100 MHz simulation clock
  --------------------------------------------
  process begin
    wait for (clk_per/2);
    clk_in <= not clk_in;
    clk_in_n <= not clk_in_n;
  end process;






  -- Test sequence
  process 
  begin
   -- data_in_from_pins <= (others => '0');
    -- reset the logic
    report "Timing checks are not valid" severity note;
    clk_reset   <= '1';
    io_reset    <= '1';
    io_reset1    <= '1';
    
    wait for (18*clk_per);
    clk_reset   <= '0';

    wait for (120.5*clk_per);
    wait until clk_in'event and clk_in = '0';
    io_reset    <= '0';

    wait for (2.5*clk_per);
    io_reset1    <= '0';
    report "Timing checks are valid" severity note;
    wait;
  end process;

process (clk_in)
    procedure simtimeprint is
      variable outline : line;
    begin
      write(outline, string'("## SYSTEM_CYCLE_COUNTER "));
      write(outline, NOW/clk_per);
      write(outline, string'(" ns"));
      writeline(output,outline);
    end simtimeprint;
begin
    if(clk_in'event and clk_in = '0') then
    if (io_reset = '0') then
       timeout_counter <= timeout_counter + '1';
       if ((timeout_counter = "11111010000") and (pattern_completed_out = "00")) then
         simtimeprint;
         report "ERROR : SIMULATION TIMED OUT" severity failure;
       end if;
    end if; 
    end if;
end process;


process (clk_in)
    procedure simtimeprint is
      variable outline : line;
    begin
      write(outline, string'("## SYSTEM_CYCLE_COUNTER "));
      write(outline, NOW/clk_per);
      write(outline, string'(" ns"));
      writeline(output,outline);
    end simtimeprint;
begin
    if (clk_in'event and clk_in = '0') then
    if (io_reset1 = '0') then
    if (pattern_completed_out = "00") then
       report "SIMULATION started" severity note;
    elsif (pattern_completed_out = "10") then
       simtimeprint;
       report "ERROR : SIMULATION FAILED. SERDES design" severity failure;
    elsif (pattern_completed_out = "01") then
       bitslip_timeout <= bitslip_timeout + '1'; 
       if (bitslip_timeout = "11111111111111111") then
       simtimeprint;
       report "ERROR: TOO LONG A TIME FOR bitslip" severity failure; 
       end if;
       report "SIMULATION in progress: BITSLIPS found, data checking in progress" severity note;
    elsif (pattern_completed_out = "11") then
       bitslip_timeout <= (others => '0');
       simtimeprint;
       report "Test Completed Successfully" severity failure;
       report "SIMULATION STOPPED." severity failure;
    else
       simtimeprint;
       report "ERROR : Unknown state (SERDES design)" severity failure;
    end if;
    end if;
    end if;
end process;



    data_in_from_pins_p <= transport data_out_to_pins_p after 1.00 ns;
    data_in_from_pins_n <= transport data_out_to_pins_n after 1.00 ns;


   pattern_completed_out <= pattern_completed_out1 after (0.4*clk_per);

 
  -- Instantiation of the example design

  dut : Clink_ch_exdes
  port map
  (
   pattern_completed_out      => pattern_completed_out1,
   -- From the system into the device
   data_in_from_pins_p       => data_in_from_pins_p,
   data_in_from_pins_n       => data_in_from_pins_n,
   data_out_to_pins_p        => data_out_to_pins_p,
   data_out_to_pins_n        => data_out_to_pins_n,
   clk_in                    => clk_in,
   clk_in_n                    => clk_in_n,
--    delay_locked            => open,
    ref_clock               => clk_in,
   clock_enable             => '1',
   clk_reset                 => clk_reset,
   io_reset                  => io_reset);
end test;
