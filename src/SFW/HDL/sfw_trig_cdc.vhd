-------------------------------------------------------------------------------
--
-- Title       : trig_pulse_cdc
-- Design      : TEL2000
-- Author      : Telops Inc.
-- Company     : Telops Inc.
--
-------------------------------------------------------------------------------
--
-- File        : trig_pulse_cdc.vhd
-- Generated   : Wed Jan 24 18:43:53 2007
-- From        : interface description file
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description : The purpose of this block is to detect rising of pulses
-- even if they are narrower than a clock period. 
--
--
--  Revision history:  
--  Notes: 
--
--  $Revision$ 
--  $Author: 
--  $LastChangedDate: 

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity trig_pulse_cdc is
	 port(
		 PULSE : in STD_LOGIC;
         CLK_IN : in STD_LOGIC;
		 CLK_OUT : in STD_LOGIC;
		 PULSE_OUT : out STD_LOGIC
	     );
end trig_pulse_cdc;


architecture RTL of trig_pulse_cdc is 

SIGNAL pulse_i  : std_logic := '0';
signal pulse_o  : std_logic_vector(1 downto 0) := "00";
signal pulse_or : std_logic;

begin
    --register input pulse
	in_pulse_process : process(CLK_IN)
	begin
		if (rising_edge(CLK_IN)) then
            pulse_i <= PULSE;
		end if;	
	end process;
    
    pulse_or <= pulse_i or PULSE;
    
    --double sync output pusle
    out_pulse_process : process(CLK_OUT)
	begin
		if (rising_edge(CLK_OUT)) then
            pulse_o(0) <= pulse_or;
            pulse_o(1) <= pulse_o(0);
		end if;	
	end process;
	
    PULSE_OUT <= pulse_o(1);
    
end RTL;
