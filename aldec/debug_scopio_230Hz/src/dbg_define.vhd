--******************************************************************************
-- Destination: 
--
--	File: dbg_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: IRCDEV
--	By: Edem Nofodjie
-- Date: 22 october 2009	  
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


package dbg_define is    
   
   
   ---------------------------------------------------------------------------------								
   -- Configuration
   ---------------------------------------------------------------------------------  
   -- misc                    
   type dbg_stat_type is
   record
      
      ch0_lval_high_length_min          : unsigned(9 downto 0);
      ch0_lval_high_length_max          : unsigned(9 downto 0);
      ch0_lval_low_length_min           : unsigned(9 downto 0);
      ch0_lval_low_length_max           : unsigned(9 downto 0);	  
      
      ch1_lval_high_length_min          : unsigned(9 downto 0);
      ch1_lval_high_length_max          : unsigned(9 downto 0);
      ch1_lval_low_length_min           : unsigned(9 downto 0);
      ch1_lval_low_length_max           : unsigned(9 downto 0);	
      
      ch_desync_length_min              : unsigned(9 downto 0);	
      ch_desync_length_max              : unsigned(9 downto 0);
      
      ch0_clk_low_min                  : unsigned(9 downto 0);
      ch0_clk_low_max                  : unsigned(9 downto 0);
      ch0_clk_high_min                 : unsigned(9 downto 0);
      ch0_clk_high_max                 : unsigned(9 downto 0);
                                                              
      ch1_clk_low_min                  : unsigned(9 downto 0);
      ch1_clk_low_max                  : unsigned(9 downto 0);
      ch1_clk_high_min                 : unsigned(9 downto 0);
      ch1_clk_high_max                 : unsigned(9 downto 0);
      
   end record;
   
   
end dbg_define;

package body dbg_define is
   
   
   
end package body dbg_define; 
