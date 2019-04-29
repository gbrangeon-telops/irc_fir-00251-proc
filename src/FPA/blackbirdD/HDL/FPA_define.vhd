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
   constant DEFINE_FPA_ROIC              : std_logic_vector(7 downto 0) := FPA_ROIC_SCD_PROXY1;  -- roic du d�tecteur. Cela veut dire que le vhd actuel peut contr�ler in d�tecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT            : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant DEFINE_FPA_INIT_CFG_NEEDED   : std_logic := '0';     -- pas besoin de config particuli�re au demarrage du Blackbird
   constant SCD_MASTER_CLK_RATE_MHZ      : integer := 2;     -- INT_TIME is in steps of 500ns
   constant PROXY_CLINK_CHANNEL_NUM      : integer := 3;     -- Number of channels in the Camera Link interface with the proxy 
   constant PROXY_CLINK_CLK_1X_PERIOD_NS : real    := 14.3;  -- CLINK IN est � 70MHz pour le Blackbird
   constant DEFINE_DIAG_CLK_RATE_MAX_KHZ : integer := 85_000;    -- vitesse max de l'horloge de sortie des pixels en mode diag (vitesse totale des sorties divis�e par 2 canaux en mode diag 
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   constant XSIZE_MAX                    : integer := 1280;              -- dimension en X maximale                                      -- dimension en X maximale
   constant YSIZE_MAX                    : integer := 1024;              -- dimension en Y maximale  
   
   -- increment des donn�es en mode diag compteur
   constant DIAG_DATA_INC                : integer :=  2*integer(((2**13)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- 2*integer(((2**16)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   
end FPA_define;

package body FPA_define is
   
      
end package body FPA_define; 
