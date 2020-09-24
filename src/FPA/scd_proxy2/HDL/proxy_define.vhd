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
   constant DEFINE_PROXY                 : std_logic_vector(2 downto 0) := PROXY2_SCD;
   constant PROG_FREE_RUNNING_TRIG       : std_logic := '0';   -- à '1', cette constante dit que les trigs n'ont pas besoin d'être arrêté lorsqu'on programme le détecteur
   constant FPA_INTF_CLK_RATE_MHZ        : integer := 100;     --  FPA_INTF_CLK_RATE en MHz
   constant INT_TIME_MIN_US              : integer := 1; 
   constant MASTER_CLK_RATE_MHZ          : integer := 70;      --
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP   : integer := 1; -- pour le pelicanD, chaque appel de FPA_SendConfigGC() déclenche l'envoi d'une config opérationnelle au proxy qui sera précédé et suivi d'au moins FPA_XTRA_IMAGE_NUM_TO_SKIP prog trig.  
   constant DEFINE_FPA_100M_CLK_RATE_KHZ : integer := 100_000;
   
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
   constant FSYNC_HIGH_TIME_US       : integer := 5;     -- duree de FSYNC en usec
   constant POWER_WAIT_US            : integer := 2_000_000;  -- duree d'attente après allumage en usec. selon la doc, le proxy prend 1 sec. Pour plus de securité, j'en mets 2
   constant TEMP_TRIG_PERIOD_US      : integer := 1_000_000;  -- le trig de lecture de la temperature a une periode de 1sec pour ne pas submerger le proxy
   
   -- commandes
   constant CMD_OVERHEAD_BYTES_NUM   : integer := 6; -- nombre de bytes de l'overhead (header, CommandID, length, Checksum)
   constant LONGEST_CMD_BYTES_NUM    : integer := 32; -- longueur maximale en byte de la config d'un scd_proxy2 (incluant le header, checksum etc). Ce nombre doit être inférieur à 64 à cause d'un fifo dans le copieur
   constant SERIAL_BAUD_RATE         : integer := 921_600; -- baud rate utilisé pour Scd (utilisé juste pour generateur de delai)
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
   constant DIAG_CMD_RAM_BASE_ADD    : integer  := 128;
   constant TEMP_CMD_RAM_BASE_ADD    : integer  := 192;
   
   -- adresse de base de la zone securisée
   constant CMD_SECUR_RAM_BASE_ADD   : integer  := 1024; -- adresse où se retrouve la commande copiée dans la zone securisee
   
   -- quelques constantes 
   constant SERIAL_CFG_END_ADD           : std_logic_vector(7 downto 0) := x"FC"; -- adresse de fin d'envoi de la config serielle
   constant SERIAL_CFG_COPIER_START_DLY  : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   constant SERIAL_CFG_COPIER_END_DLY    : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   
   ----------------------------------------------
   -- Calculs 
   ---------------------------------------------- 
   constant FSYNC_HIGH_TIME_FACTOR     : integer := integer(FPA_INTF_CLK_RATE_MHZ*FSYNC_HIGH_TIME_US);
   constant POWER_WAIT_FACTOR          : integer := integer(FPA_INTF_CLK_RATE_MHZ*POWER_WAIT_US);
   constant SERIAL_TX_CLK_FACTOR       : integer := integer((FPA_INTF_CLK_RATE_MHZ*1E6)/SERIAL_BAUD_RATE); -- utilisé juste pour generateur de delai
   constant OP_INT_TIME_DEFAULT_FACTOR : integer := integer(real(MASTER_CLK_RATE_MHZ)*(0.5*real(INT_TIME_MIN_US))); --
   constant TEMP_TRIG_PERIOD_FACTOR    : integer := integer(FPA_INTF_CLK_RATE_MHZ*TEMP_TRIG_PERIOD_US);
   
   constant EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de EXP_TIME_CONV_DENOMINATOR  
   constant EXP_TIME_CONV_DENOMINATOR  : integer := 2**EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant EXP_TIME_CONV_NUMERATOR    : unsigned(EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned((4*(2**EXP_TIME_CONV_DENOMINATOR_BIT_POS))/5, EXP_TIME_CONV_DENOMINATOR_BIT_POS);     -- (80 x 2^26 )/100
   constant DEFINE_DIAG_DATA_CLK_FACTOR    : integer := integer(ceil(real(FPA_INTF_CLK_RATE_MHZ * 1000) / real(DEFINE_DIAG_CLK_RATE_MAX_KHZ)));  
   
   
   
   ---------------------------------------------------------------------------------								
   -- Configuration regroupant les éléments vraiment propres au détecteur
   ---------------------------------------------------------------------------------
   -- scd_proxy2 integration
   type int_cfg_type is
   record
      int_time            : unsigned(23 downto 0);  --! temps d'integration en coups de 80Mhz
      diag_int_time           : unsigned(24 downto 0);  --! temps d'integration en coups de 100Mhz
      int_indx            : std_logic_vector(7 downto 0);
   end record;
   
   -- scd_proxy2 operationnelle
   type op_cfg_type is
   record  
      xstart              : unsigned(10 downto 0); 
      ystart              : unsigned(10 downto 0);
      xsize               : unsigned(10 downto 0);
      ysize               : unsigned(10 downto 0);
      gain                : std_logic_vector(7 downto 0);
      out_chn             : std_logic;
      diode_bias          : std_logic_vector(3 downto 0);
      int_mode            : std_logic_vector(7 downto 0);
      spare1              : std_logic;
      spare2              : std_logic_vector(1 downto 0);
      frame_period_min    : unsigned(23 downto 0); 
      cfg_num                 : unsigned(7 downto 0);      
   end record;
   
   -- scd_proxy2 video synthetic
   type diag_cfg_type is
   record
      bit_pattern         : std_logic_vector(2 downto 0);   
   end record;
   
   -- scd_proxy2 temperature
   type temp_cfg_type is
   record
      temp_read_num       : unsigned(7 downto 0);
   end record; 
   
   -- scd_proxy2 misc                 --  quelques valeurs propres au PelicanD (-- se reporter aux figures 1 et 2 et 4 des pages 13, 15 et 19 du doument Communication protocol appendix A5 (SPEC. NO: DPS3008) dans le dossier du pelicanD)                                
   type misc_cfg_type is
   record
      fig1_or_fig2_t6_dly : unsigned(15 downto 0);
      fig4_t1_dly         : unsigned(15 downto 0);
      fig4_t2_dly         : unsigned(15 downto 0);
      fig4_t6_dly         : unsigned(15 downto 0);
      fig4_t3_dly         : unsigned(15 downto 0);
      fig4_t5_dly         : unsigned(15 downto 0);
      fig4_t4_dly         : unsigned(15 downto 0);
      fig1_or_fig2_t5_dly : unsigned(15 downto 0);
      fig1_or_fig2_t4_dly : unsigned(15 downto 0);
      xsize_div2          : unsigned(9 downto 0);
   end record;
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record     
      cmd_to_update_id     : std_logic_vector(15 downto 0); -- cet ide permet de saoir quelle partie de la commande rentrante est à mettre à jour. Important pour regler bugs
      comn                 : fpa_comn_cfg_type;   -- partie commune (utilisée par les modules communs)
      op                   : op_cfg_type;     -- tout changement dans op entraine la programmation du detecteur (commnde operationnelle)
      int                  : int_cfg_type;    -- tout changement dans int entraine la programmation du detecteur (commnde temps d'intégration)
      diag                 : diag_cfg_type;   -- tout changement dans diag entraine la programmation du detecteur (commnde PE Syntehtique)
      temp                 : temp_cfg_type;   -- tout changement dans temp entraine la programmation du detecteur (commnde temperature read)  
      misc                 : misc_cfg_type;   -- les changements dans misc ne font pas programmer le detecteur
      fpa_serdes_lval_num  : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      fpa_serdes_lval_len  : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      int_time             : unsigned(31 downto 0);   -- temps d'integration actuellement utilisé en coups de MCLK. Sert juste à generer un statut.
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
