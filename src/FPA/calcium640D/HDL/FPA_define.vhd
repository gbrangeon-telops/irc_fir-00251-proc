--******************************************************************************
-- Destination: 
--
--	File: FPA_define.vhd
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
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all; 

package FPA_define is    
   
   --------------------------------------------------
   -- Définitions propres au calcium640D
   --------------------------------------------------
   constant DEFINE_XSIZE_MAX                 : integer := 640;    -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                 : integer := 512;    -- dimension en Y maximale
   constant XSIZE_MAX                        : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                        : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX
   
end FPA_define;

package body FPA_define is
   
end package body FPA_define; 
