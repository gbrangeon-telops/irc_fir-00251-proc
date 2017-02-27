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
use work.fpa_common_pkg.all; 


package FPA_define is    
   
   --------------------------------------------
   -- PROJET: definition
   --------------------------------------------   
   constant DEFINE_FPA_ROIC              : std_logic_vector(7 downto 0) := FPA_ROIC_HERCULES;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT            : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant DEFINE_FPA_INIT_CFG_NEEDED   : std_logic := '0';     -- pas besoin de config particulière au demarrage du Hercules
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   constant XSIZE_MAX                    : integer := 1280;              -- dimension en X maximale                                      -- dimension en X maximale
   constant YSIZE_MAX                    : integer := 1024;              -- dimension en Y maximale  
   
   -- increment des données en mode diag compteur
   constant DIAG_DATA_INC                : integer :=  2*integer(((2**14)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- 2*integer(((2**16)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   
end FPA_define;

package body FPA_define is
   
      
end package body FPA_define; 
