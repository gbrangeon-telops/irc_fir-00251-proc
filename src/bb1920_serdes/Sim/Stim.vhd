-------------------------------------------------------------------------------
--
-- Title       : Stim
-- Design      : Line_Buffer
-- Author      : ETD
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\2020-08-08 Line Buffer\Simulation\Line_buffer\src\Stim.vhd
-- Generated   : Mon Aug 31 14:28:25 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Fichier de stimulation et de vérification pour le testbench du line buffer
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;
use work.tel2000.all;	
library std;
use std.textio.all;
use ieee.std_logic_textio.all;



entity Stim is
	port(		   
		CLK : out STD_LOGIC;
		ARESETN : out STD_LOGIC;
		 
		ch_data : out std_logic_vector(31 downto 0);
		dout : in std_logic_vector(31 downto 0));
end Stim;


architecture Stim of Stim is	

function hex_string_to_std_logic_vector(s: string)	return std_logic_vector is
	variable slv : std_logic_vector((s'high-s'low+1)*4-1 downto 0);
	variable k : integer;
begin
	k := s'high-s'low;
	for i in s'range loop
		case s(i) is
			when '0' =>
				slv(k*4+3 downto k*4) := x"0";
			when '1' =>
				slv(k*4+3 downto k*4) := x"1";
			when '2' =>
				slv(k*4+3 downto k*4) := x"2";
			when '3' =>
				slv(k*4+3 downto k*4) := x"3";
			when '4' =>
				slv(k*4+3 downto k*4) := x"4";
			when '5' =>
				slv(k*4+3 downto k*4) := x"5";
			when '6' =>
				slv(k*4+3 downto k*4) := x"6";
			when '7' =>
				slv(k*4+3 downto k*4) := x"7";
			when '8' =>
				slv(k*4+3 downto k*4) := x"8";
			when '9' =>
				slv(k*4+3 downto k*4) := x"9";
			when 'A' =>
				slv(k*4+3 downto k*4) := x"A";
			when 'B' =>
				slv(k*4+3 downto k*4) := x"B";
			when 'C' =>
				slv(k*4+3 downto k*4) := x"C";
			when 'D' =>
				slv(k*4+3 downto k*4) := x"D";
			when 'E' =>
				slv(k*4+3 downto k*4) := x"E";
			when 'F' =>
				slv(k*4+3 downto k*4) := x"F";
			when 'U' =>
				slv(k*4+3 downto k*4) := "UUUU";
			when 'X' =>
				slv(k*4+3 downto k*4) := "XXXX"; 
			when 'Z' =>
				slv(k*4+3 downto k*4) := "ZZZZ";
			when 'W' =>
				slv(k*4+3 downto k*4) := "WWWW";
			when 'L' =>
				slv(k*4+3 downto k*4) := "LLLL";
			when 'H' =>
				slv(k*4+3 downto k*4) := "HHHH"; 
			when '-' =>
				slv(k*4+3 downto k*4) := "----"; 
			when others =>
				slv(k*4+3 downto k*4) := "XXXX";
		end case;	
		k := k-1;
	end loop;	 
	return slv;
end hex_string_to_std_logic_vector;

signal datatosave : std_logic_vector(63 downto 0);

file stimulus_image : text;
file stimulus_start_up : text;

constant clk_period : time := 10 ns;
signal clk_i : std_logic;
		

begin

	--Clock 100Mhz definition
   clk_100Mhz_process : process
   begin 
      CLK <= '0';
      clk_i <= '0';
      wait for clk_period/2;
      CLK <= '1';
      clk_i <= '1';
      wait for clk_period/2;
   end process;
   
   --The format of stimulus_lineX needs to be 4 hex per line
	read_image_process : process
		variable l : line;
		variable s : string(1 to 8);
	begin
	  
      wait for clk_period * 10;
      
      --Read startup of the detector
      file_open(stimulus_start_up, "D:\Telops\FIR-00251-Proc\src\bb1920_serdes\SIM\Start_up.txt", read_mode);
      while not endfile(stimulus_start_up) loop
         wait until rising_edge(clk_i);
         readline(stimulus_start_up,l);
         read(l,s);
         ch_data <= hex_string_to_std_logic_vector(s);
      end loop;
      
      --Read the image in an infinite loop like the detector would
      --Only one image is read in a loop
      while true loop
         file_open(stimulus_image, "D:\Telops\FIR-00251-Proc\src\bb1920_serdes\SIM\Image.txt",  read_mode);
         while not endfile(stimulus_image) loop
            wait until rising_edge(clk_i);	
            readline(stimulus_image,l);
            read(l,s);
            ch_data <= hex_string_to_std_logic_vector(s);      
         end loop;		
         file_close(stimulus_image);
		end loop;
      
      wait;
	end process read_image_process;
   
   gen_stim : process
   begin
      ARESETN <= '0';
      
      wait for clk_period * 5;
      
      ARESETN <= '1';
      
      wait;
   end process;

end Stim;
