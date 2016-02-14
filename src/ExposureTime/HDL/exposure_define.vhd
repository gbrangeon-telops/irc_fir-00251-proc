--******************************************************************************
-- Destination: 
--
-- File: exposure_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: TEL-2000
--	By: Edem Nofodjie
-- Date: 03 fevrier 2013	  
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
use work.tel2000.all; 

package exposure_define is    	  
   
   -- les differentes sources de temps d,intégration
   constant MB_SOURCE             : std_logic_vector(7 downto 0) := x"00";  -- Le temps d'exposition à prendre provient du µblaze
   constant FW_SOURCE             : std_logic_vector(7 downto 0) := x"01";  -- Le temps d'exposition à prendre provient de la roue à filtres
   constant EHDRI_SOURCE          : std_logic_vector(7 downto 0) := x"02";  -- Le temps d'exposition à prendre provient du EHDRI
   
   -------------------------------------------------------							
   -- parametres de config reçus du µblaze
   -------------------------------------------------------
   type exp_config_type is
   record 
      exp_source        : std_logic_vector(MB_SOURCE'range);   -- source du temps d'intégration
      exp_time_min      : unsigned(31 downto 0);               -- temps d'exposition minimal     
      exp_time_max      : unsigned(31 downto 0);               -- temps d'exposition maximal
      exp_new_cfg       : std_logic;                           -- pulse signalant la reception d'une nouvelle configuration
   end record exp_config_type;  
   
end exposure_define;

package body exposure_define is
   
end package body exposure_define; 
