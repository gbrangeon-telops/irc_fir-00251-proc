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
   constant DEFINE_FPA_ROIC               : std_logic_vector(7 downto 0) := FPA_ROIC_SCORPIO_MW;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler un détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT             : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant PROG_FREE_RUNNING_TRIG        : std_logic := '1';   -- cette constante dit que les trigs n'ont pas besoin d'être arrêté lorsqu'on programme le détecteur
   constant FPA_INTF_CLK_RATE_HZ          : integer := 100_000_000; --  FPA_INTF_CLK_RATE en KHz
   constant FPA_MCLK_RATE_HZ              : integer := 10_000_000;  -- le scorpioMW est cadencé à 10MHz . Ce parametre intervient dans la converspion du temps d'intégration en coups de 100MHz
   constant FPA_INT_TIME_MIN_NS           : integer := 150;         -- 0.150 usec
   constant MGLK_MASTER_CLOCK_IS_EXTERNAL : std_logic := '1';   -- '1' si l'horloge MatsreClock est externe, '0' sinon. Doit être compatible avec les registres du piloteC
   constant MGLK_INT_SIGNAL_IS_EXTERNAL   : std_logic := '1';   -- '1' if INT source is external CC1 (FSYNC), '0' si generé sur le Megalink. Doit être compatible avec les registres du piloteC
   constant FPA_INT_TIME_OFFSET_MCLK      : integer   := 3076;    -- 3075.5 MCLK d'offset sur le temps d'integration pour reset des puits 
   constant MGLK_LVAL_TIMEOUT_MCLK        : integer   := 6;     -- ENO 19 nov 2015: pour corriger bug du Megalink avec son fval qui ne tombe jamais. Si le lval reste à '0' durant 6 MCLK, on suppose que l'image est terminée.  
   constant PROXY_CLINK_CHANNEL_NUM       : integer   := 2;     -- Number of channels in the Camera Link interface with the Megalink

   --------------------------------------------
   --  modes diag
   --------------------------------------------
   -- D comme diag mais en fait pour laisser les valeurs inférieurs au
   constant TELOPS_DIAG_CNST              : std_logic_vector(7 downto 0):= x"D1";  -- mode diag constant
   constant TELOPS_DIAG_DEGR              : std_logic_vector(7 downto 0):= x"D2";  -- mode diag degradé pour la prod
   constant TELOPS_DIAG_DEGR_DYN          : std_logic_vector(7 downto 0):= x"D3";  -- mode diag degradé dynamique pour FAU
   
   --------------------------------------------
   -- FPA : Nombre d'ADCs sur le FPA
   -------------------------------------------- 
   constant NUMBER_TAPS                   : natural := 4;
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   constant XSIZE_MAX                     : integer := 640;              -- dimension en X maximale                                      -- dimension en X maximale
   constant YSIZE_MAX                     : integer := 512;              -- dimension en Y maximale  
   constant FPA_INT_FBK_AVAILABLE         : std_logic := '0';
   
   -- increment des données en mode diag compteur
   constant DIAG_DATA_INC                 : integer :=  2*integer(((2**14)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; --2*integer((2**16)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
 
   
end FPA_define;

package body FPA_define is
  
   
end package body FPA_define; 
