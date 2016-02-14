-------------------------------------------------------------------------------
--
-- Title       : edge_detect
-- Design      : Trig_ctrl_tb
-- Author      : Telops Inc
-- Company     : Telops Inc
--
-------------------------------------------------------------------------------
--
-- File        :
-- Generated   : Wed Nov 11 19:41:13 2009
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 

entity edge_detect is 
	generic (
		RISING_FALLING : std_logic_vector(1 downto 0) := "10"
		);
	
	port(
		ARESET    : in std_logic;
		CLK       : in std_logic;
		INPUT     : in std_logic;
		OUTPUT    : out std_logic
		);
end edge_detect;

architecture RTL of edge_detect is
	
signal sreset      : std_logic;
signal input_last  : std_logic;	
signal output_i    : std_logic;
	
	component sync_reset
		port(
			ARESET : in std_logic;
			SRESET : out std_logic;
			CLK    : in std_logic);
	end component;
	
begin  
	OUTPUT <= output_i;
	
	--  synchro reset 
	sreset_map : sync_reset
	port map(
		ARESET => ARESET,
		CLK    => CLK,
		SRESET => sreset
		); 
	-----
	process(CLK)
	begin
		if rising_edge(CLK) then
			if sreset = '1' then 
				input_last <= INPUT;
				output_i <= '0';
			else 
				input_last <= INPUT;
				
				case RISING_FALLING  is
					when "10" => -- rising_edge detect
						if input_last= '0' and INPUT = '1' then 
							output_i <= '1'; 
						else
							output_i <= '0';
						end if;						
					when "01" =>   -- falling_edge detect
						if input_last= '1' and INPUT = '0' then 
							output_i <= '1'; 
						else
							output_i <= '0';
						end if;								
					when "11" =>  -- rising and falling edge detect
						if (input_last xor INPUT) = '1' then 
							output_i <= '1'; 
						else
							output_i <= '0';
						end if;		
					when others =>
					output_i <= '0';
				end case;
			end if;	
		end if;
	end process;
	
end RTL;
