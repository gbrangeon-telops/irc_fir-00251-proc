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
   
   constant DEFINE_FPA_ROIC                        : std_logic_vector(7 downto 0) := FPA_ROIC_BLACKBIRD1520;  	-- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                      : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant DEFINE_FPA_INIT_CFG_NEEDED             : std_logic  := '0';     									-- pas besoin de config particulière au demarrage du PelicanD  
    
   constant DEFINE_INT_CLK_SOURCE_RATE_KHZ         : integer    := 70_000;           -- frequence de l'horloge source de laquelle est tirée celle de INT
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ    : integer    := 70_000;           -- frequence de l'horloge source de laquelle est tirée celle de ADC_QUAD_CLK
   constant DEFINE_FPA_PCLK_RATE_KHZ               : integer    := 70_000;
   constant DEFINE_XTAL_CLK_RATE_HZ                : integer    := 70_000_000;           -- frequence de l'horloge XTAL pour le RS232
   
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ           : integer    := DEFINE_FPA_PCLK_RATE_KHZ;
   
   constant DEFINE_DIAG_PIX_SAMPLE_NUM_PER_CH      : integer    := 1;  
    
   constant XSIZE_MAX                              : integer    := 1520;              -- dimension en X maximale                                      -- dimension en X maximale
   constant YSIZE_MAX                              : integer    := 1536;              -- dimension en Y maximale  
   
   constant ACTIVE_RWI_MODE                        : std_logic  := '1';               -- '1' <=> mode RWI;  '0' <=> mode IWR   
   
end FPA_define;

package body FPA_define is
   
   
end package body FPA_define; 
