--******************************************************************************
-- Destination: 
--
--	File: IRIG_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: IRCDEV
--	By: Edem Nofodjie
-- Date: 9 pctobre 2011	  
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
--library Common_HDL;
--use Common_HDL.telops.all; 


package IRIG_Testbench_define is    
   
   
   type irig_stream_type  is array(0 to 99) of character;
   
   constant IRIG_STREAM  : irig_stream_type := (
   'P', '1', '1', '0','0', '0', '0', '1', '1',            
   'P', '1', '1', '1','0', '0', '0', '1', '1', '1',
   'P', '1', '0', '0','1', '1', '0', '0', '0', '1',
   'P', '1', '0', '1','0', '1', '0', '1', '0', '1',
   'P', '0', '1', '0','0', '0', '1', '1', '1', '1',
   'P', '0', '0', '0','0', '0', '0', '0', '1', '1',
   'P', '0', '0', '0','0', '0', '0', '0', '0', '0',
   'P', '0', '0', '0','0', '0', '0', '0', '0', '0',
   'P', '0', '0', '0','0', '0', '0', '0', '0', '0',
   'P', '0', '0', '0','0', '0', '0', '0', '0', '0',
   'P'
   );
end IRIG_Testbench_define;



package body IRIG_Testbench_define is
   
   
   
end package body IRIG_Testbench_define; 

