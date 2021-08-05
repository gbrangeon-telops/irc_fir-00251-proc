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
   constant DEFINE_FPA_ROIC              : std_logic_vector(7 downto 0) := FPA_ROIC_PELICAND;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler un détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT            : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant DEFINE_FPA_INIT_CFG_NEEDED   : std_logic := '0';     -- pas besoin de config particulière au demarrage du PelicanD
   constant DEFINE_DIAG_CLK_RATE_MAX_KHZ : integer := 80_000;    -- vitesse max de l'horloge de sortie des pixels en mode diag (vitesse totale des sorties divisée par 2 canaux en mode diag 
   constant PROXY_CLINK_PIXEL_NUM        : integer := 2;         -- Number of pixels on proxy clink interface
   constant PROXY_CLINK_CHANNEL_NUM      : integer := 2;         -- Number of channels on proxy clink interface
   
   constant SCD_FSYNC_HIGH_TIME_US       : integer := 5;     -- duree de FSYNC en usec
   constant SCD_GAIN_0                   : std_logic_vector(7 downto 0) := x"00";
   constant SCD_GAIN_1                   : std_logic_vector(7 downto 0) := x"02";
   constant FPA_INT_FBK_AVAILABLE        : std_logic := '1';
   constant PROXY_CLINK_CLK_1X_PERIOD_NS : real      := 12.5;    -- CLINK IN est à 80MHz ns
   constant PROXY_NEED_FRAME_RES_CONFIG  : std_logic := '0';     -- BB1280 has a frame resoultion command (Pelican and Hercule don't) 
   constant SCD_TRIG_REFERENCED          : std_logic := '0';     -- 1 : reference to fsync (bb1280)  , 0 : reference to acq_int (pelican & hercule)
   constant SCD_CROPPING_NEEDED          : std_logic := '0';     -- 1 : Cropping module activated (bb1280)  , 0 : Cropping module deactivated (pelican & hercule)  
   constant SCD_FRAME_RESOLUTION : real  := 1.0;     -- BB1280D : FRAME_RES register value. PelicanD & HerculeD dont have this parameter.
   constant SCD_MASTER_CLK_RATE_MHZ      : integer   := 80;
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   constant XSIZE_MAX                    : integer := 640;              -- dimension en X maximale                                      -- dimension en X maximale
   constant YSIZE_MAX                    : integer := 512;              -- dimension en Y maximale  
   
   -- increment des données en mode diag compteur
   constant DIAG_DATA_INC                : integer :=  2*integer(((2**13)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- 2*integer(((2**16)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   
end FPA_define;

package body FPA_define is
     
   
end package body FPA_define; 
