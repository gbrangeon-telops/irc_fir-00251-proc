--******************************************************************************
-- Destination: 
--
--	File: Proxy_define.vhd
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
use IEEE.math_real.all;
use work.fpa_common_pkg.all;
use work.fpa_define.all;  

package Proxy_define is
   
   --------------------------------------------
   -- PROJET: definition
   --------------------------------------------   
   constant DEFINE_PROXY                          : std_logic_vector(2 downto 0) := PROXY2_SCD;
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';   -- à '1', cette constante dit que les trigs n'ont pas besoin d'être arrêté lorsqu'on programme le détecteur   constant INT_TIME_MIN_US                       : integer := 1; 
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP            : integer := 1; -- pour le pelicanD, chaque appel de FPA_SendConfigGC() déclenche l'envoi d'une config opérationnelle au proxy qui sera précédé et suivi d'au moins FPA_XTRA_IMAGE_NUM_TO_SKIP prog trig.  
   constant DEFINE_FPA_INTCLK_RATE_KHZ            : integer := 10_000;  -- l'horloge d'integration
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : integer := 70_000;    -- c'est l'horloge à partir de laquelle est produite celle des quads.
   constant DEFINE_FPA_MCLK_SOURCE_RATE_KHZ       : integer   := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ; 
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer := 100_000;
   
   
   constant FSYNC_HIGH_TIME_US                    : integer := 5;     -- duree de FSYNC en usec
   constant POWER_WAIT_US                         : integer := 2_000_000;  -- duree d'attente après allumage en usec. selon la doc, le proxy prend 1 sec. Pour plus de securité, j'en mets 2
   constant TEMP_TRIG_PERIOD_US                   : integer := 1_000_000;  -- le trig de lecture de la temperature a une periode de 1sec pour ne pas submerger le proxy
                                                  
   -- commandes                                   
   constant CMD_OVERHEAD_BYTES_NUM                : integer := 6; -- nombre de bytes de l'overhead (header, CommandID, length, Checksum)
   constant LONGEST_CMD_BYTES_NUM                 : integer := 32; -- longueur maximale en byte de la config d'un scd_proxy2 (incluant le header, checksum etc). Ce nombre doit être inférieur à 64 à cause d'un fifo dans le copieur
   constant SERIAL_BAUD_RATE                      : integer := 921_600; -- baud rate utilisé pour Scd (utilisé juste pour generateur de delai)
 
   
   ----------------------------------------------
   -- calculs 
   ---------------------------------------------- 
   -- attention aux modifs à apporter aux lignes des calculs
   constant DEFINE_DIAG_DATA_INC                         : integer :=  2*integer(((2**14)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- 2*integer(((2**16)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   constant DEFINE_FPA_TAP_NUMBER                        : integer :=  PROXY_CHANNEL_LINK_NUM;
   constant PROXY_CLINK_CLK_1X_PERIOD_NS                 : real    := 1_000_000.0/real(DEFINE_FPA_MCLK_RATE_KHZ);      	-- CLINK IN est à 70 MHz ns 
   constant DEFINE_FPA_PCLK_RATE_KHZ                     : integer := DEFINE_FPA_MCLK_RATE_KHZ;
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ                 : integer := DEFINE_FPA_MCLK_RATE_KHZ; 
   constant DEFINE_ADC_QUAD_CLK_FACTOR                   : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR         : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR           : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_INTCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     --
   constant FSYNC_HIGH_TIME_FACTOR                       : integer := integer((DEFINE_FPA_MCLK_SOURCE_RATE_KHZ*FSYNC_HIGH_TIME_US)/1000);
   constant POWER_WAIT_FACTOR                            : integer := integer((DEFINE_FPA_MCLK_SOURCE_RATE_KHZ*POWER_WAIT_US)/1000);
   constant SERIAL_TX_CLK_FACTOR                         : integer := integer((DEFINE_FPA_MCLK_SOURCE_RATE_KHZ*1E3)/SERIAL_BAUD_RATE); -- utilisé juste pour generateur de delai
   constant TEMP_TRIG_PERIOD_FACTOR                      : integer := integer((DEFINE_FPA_MCLK_SOURCE_RATE_KHZ*TEMP_TRIG_PERIOD_US)/1000);
   constant DEFINE_FPA_MCLK_SOURCE_RATE_HZ               : integer := 1000*DEFINE_FPA_MCLK_SOURCE_RATE_KHZ; 
   --------------------------------------------
   --  modes diag
   --------------------------------------------
   -- D comme diag mais en fait pour laisser les valeurs inférieurs au
   constant TELOPS_DIAG_CNST             : std_logic_vector(7 downto 0):= x"D1";  -- mode diag constant
   constant TELOPS_DIAG_DEGR             : std_logic_vector(7 downto 0):= x"D2";  -- mode diag degradé pour la prod
   constant TELOPS_DIAG_DEGR_DYN         : std_logic_vector(7 downto 0):= x"D3";  -- mode diag degradé dynamique pour FAU
   
   --------------------------------------------
   -- FPA : Nombre d'ADCs sur le FPA
   -------------------------------------------- 
   constant NUMBER_TAPS                  : natural := 1;
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   constant GAIN_0                   : std_logic_vector(7 downto 0) := x"00";
   constant GAIN_1                   : std_logic_vector(7 downto 0) := x"02";
   constant ITR                      : std_logic_vector(7 downto 0) := x"00";
   constant IWR                      : std_logic_vector(7 downto 0) := x"01";
   constant PIX_RES_15B              : std_logic_vector(1 downto 0) := "00";
   constant PIX_RES_14B              : std_logic_vector(1 downto 0) := "01";
   constant PIX_RES_13B              : std_logic_vector(1 downto 0) := "10";
   constant FPA_INT_FBK_AVAILABLE        : std_logic := '1';
   
   -- cmd
   constant COM_RESP_HDER            : std_logic_vector(7 downto 0)  := x"55";
   constant COM_RESP_FAILURE_ID      : std_logic_vector(15 downto 0) := x"FFFF";
   constant CMD_HDER                 : std_logic_vector(7 downto 0)  := x"AA";
   
   -- serial int time cmd
   constant INT_CMD_ID               : std_logic_vector(15 downto 0) := x"8001";
   constant INT_CMD_DLEN             : std_logic_vector(15 downto 0) := x"0006";
   
   -- serial operational cmd
   constant OP_CMD_ID                : std_logic_vector(15 downto 0) := x"8002";
   
   -- serial diag cmd                                                        
   constant DIAG_CMD_ID              : std_logic_vector(15 downto 0) := x"8004";
   
   -- serial temperature read cmd
   constant TEMP_CMD_ID              : std_logic_vector(15 downto 0) := x"8021";
   
   -- partition de la ram de cfg serielle (la partie d'ecriture reservée à la config serielle a une plage d'adresse < 255)
   constant OP_CMD_RAM_BASE_ADD      : integer  := 0;    -- adresse de base où est logée la commande operationnelle en ram
   constant INT_CMD_RAM_BASE_ADD     : integer  := 64;   -- adresse de base où est logée la commande du temps d'integration en ram
   constant TEMP_CMD_RAM_BASE_ADD    : integer  := 192;
   
   -- adresse de base de la zone securisée
   constant CMD_SECUR_RAM_BASE_ADD   : integer  := 1024; -- adresse où se retrouve la commande copiée dans la zone securisee
   
   -- quelques constantes 
   constant SERIAL_CFG_END_ADD           : std_logic_vector(7 downto 0) := x"FC"; -- adresse de fin d'envoi de la config serielle
   constant SERIAL_CFG_COPIER_START_DLY  : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   constant SERIAL_CFG_COPIER_END_DLY    : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM 
   
   --------------------------------------------
   --  modes diag
   --------------------------------------------
   -- D comme diag 
   constant DEFINE_TELOPS_DIAG_CNST               : std_logic_vector(7 downto 0):= x"D1";  -- mode diag constant
   constant DEFINE_TELOPS_DIAG_DEGR               : std_logic_vector(7 downto 0):= x"D2";  -- mode diag degradé pour la prod
   constant DEFINE_TELOPS_DIAG_DEGR_DYN           : std_logic_vector(7 downto 0):= x"D3";  -- mode diag degradé dynamique pour FAU
   
   ---------------------------------------------------------------------------------								
   -- Configuration regroupant les éléments vraiment propres au détecteur
   ---------------------------------------------------------------------------------
   -- scd_proxy2 integration
   type int_cfg_type is
   record
      int_time         : unsigned(23 downto 0);            -- temps d'integration en coups de 70 MHz
      int_dly          : unsigned(19 downto 0);            -- delay avant debut de integration. Delai entre Fsync et le debut du signal d'integration
      int_indx         : std_logic_vector(7 downto 0);                    
      frame_dly		  : unsigned(19 downto 0);        	  -- delay entre Fsync et le debut du readout. frame_dly = a*int + frame_dly_cst 
   end record;
   
   -- scd_proxy2 operationnelle
   type op_cfg_type is
   record  
      -- window
      xstart           : unsigned(10 downto 0); 
      ystart           : unsigned(10 downto 0);
      xsize            : unsigned(10 downto 0);
      ysize            : unsigned(10 downto 0);
      
      -- seq time
      frame_time       : unsigned(19 downto 0);        	-- frame time en coups de 10 MHz
      
      -- gain et mode
      gain             : std_logic_vector(7 downto 0); 	-- op_mode de bb1920
      int_mode         : std_logic_vector(7 downto 0);   -- itr ou iwr
      test_mode		  : std_logic_vector(7 downto 0);   -- vid_if_bit_en de bb1920. C'est le test pattern mode
      
      -- bias et saturation
      det_vbias        : std_logic_vector(3 downto 0);	-- mtx_vdet de bb1920
      det_ibias        : std_logic_vector(3 downto 0); 	-- mtx_idet de bb1920
      det_vsat         : std_logic_vector(3 downto 0);	-- mtx_intg_low de bb1920
      
      -- misc
      binning          : std_logic_vector(1 downto 0);	  
      output_chn       : std_logic_vector(1 downto 0); 	-- video_rate de bb1920      
      
      -- spares
      spare1			  : std_logic_vector(1 downto 0);
      spare2			  : std_logic_vector(1 downto 0);
      spare3			  : std_logic_vector(1 downto 0);
      spare4			  : std_logic_vector(1 downto 0);
      
      cfg_num          : unsigned(7 downto 0);      
      
   end record;
   
   -- scd_proxy2 diag
   type diag_cfg_type is
   record
      ysize               : unsigned(10 downto 0);
      xsize_div_tapnum    : unsigned(10 downto 0);
      lovh_mclk_source    : unsigned(15 downto 0);
   end record;
   
   -- scd_proxy2 temperature
   type temp_cfg_type is
   record
      temp_read_num       : unsigned(7 downto 0);
   end record; 
   
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record 
      
      cmd_to_update_id               : std_logic_vector(15 downto 0); -- cet id permet de saoir quelle partie de la commande rentrante est à mettre à jour. Important pour regler bugs
      comn                           : fpa_comn_cfg_type;   -- partie commune (utilisée par les modules communs)
      
      -- les cmds proxy et fpa
      op                             : op_cfg_type;     -- tout changement dans op entraine la programmation du detecteur (commnde operationnelle)
      int                            : int_cfg_type;    -- tout changement dans int entraine la programmation du detecteur (commnde temps d'intégration)
      temp                           : temp_cfg_type;   -- tout changement dans temp entraine la programmation du detecteur (commnde temperature read)  
      
      --- cmd telops
      diag                           : diag_cfg_type;   -- 
      frame_dly_cst                  : unsigned(19 downto 0);   -- valeur constante à ajouter pour avoir  frame_dly = a*int + frame_dly_cst
      additional_fpa_int_time_offset : signed(31 downto 0);
      itr                            : std_logic;
      int_time                       : unsigned(23 downto 0);   -- temps d'integration actuellement utilisé en coups de MCLK. Sert juste à generer un statut.
      real_mode_active_pixel_dly     : unsigned(15 downto 0);
      
      -- ne provient pas du MB
      fpa_serdes_lval_num            : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      fpa_serdes_lval_len            : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      
      
   end record;    
   
   ----------------------------------------------								
   -- Type hder_param
   ----------------------------------------------
   type hder_param_type is
   record
      exp_time            : unsigned(31 downto 0); -- temps d'integration en coups de 100 MHz
      frame_id            : unsigned(31 downto 0);
      sensor_temp_raw     : std_logic_vector(15 downto 0);
      exp_index           : unsigned(7 downto 0);
      rdy                 : std_logic;                     -- pulse signifiant que les parametres du header sont prêts
   end record;
   
   
end Proxy_define;

package body Proxy_define is
   
   
   
end package body Proxy_define; 
