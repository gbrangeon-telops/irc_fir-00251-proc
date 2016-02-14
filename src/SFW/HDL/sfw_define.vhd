--******************************************************************************
-- Destination: 
--
--	File: sfw_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: tel-2000
--	By: JBO
-- Date: 	  
--
--******************************************************************************
--Description
--******************************************************************************
-- 1- Defines the global variables 
-- 2- Defines the project function
--******************************************************************************


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 


package sfw_define is    	  

constant NUMBER_OF_FILTERS  : integer := 8;

constant FIXED_WHEEL       : std_logic_vector := "00";
constant ROTATING_WHEEL    : std_logic_vector := "01";
constant NOT_IMPLEMENTED   : std_logic_vector := "10";
                      



type position_array_t is array(0 to NUMBER_OF_FILTERS-1) of std_logic_vector(15 downto 0);
   
   
end sfw_define; 


package body sfw_define is
   
end package body sfw_define; 
