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
   constant DEFINE_PROXY                 : std_logic_vector(2 downto 0) := PROXY_SCD;   
   constant PROG_FREE_RUNNING_TRIG       : std_logic := '0';   -- à '1', cette constante dit que les trigs n'ont pas besoin d'être arrêté lorsqu'on programme le détecteur
   constant FPA_INTF_CLK_RATE_MHZ        : integer := 100;     --  FPA_INTF_CLK_RATE en MHz
   constant SCD_INT_TIME_MIN_US          : integer := 1;      
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP   : integer := 1; -- pour les SCD, chaque appel de FPA_SendConfigGC() déclenche l'envoi d'une config opérationnelle au proxy qui sera précédé et suivi d'au moins FPA_XTRA_IMAGE_NUM_TO_SKIP prog trig.  
   
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
   constant SCD_ITR                      : std_logic_vector(7 downto 0) := x"00";
   constant SCD_IWR                      : std_logic_vector(7 downto 0) := x"01";
   constant SCD_PIX_RES_15B              : std_logic_vector(1 downto 0) := "00";
   constant SCD_PIX_RES_14B              : std_logic_vector(1 downto 0) := "01";
   constant SCD_PIX_RES_13B              : std_logic_vector(1 downto 0) := "10";
   constant SCD_POWER_WAIT_US            : integer   := 2_000_000;  -- duree d'attente après allumage en usec. selon la doc, le proxy prend 1 sec. Pour plus de securité, j'en mets 2
   constant SCD_TEMP_TRIG_PERIOD_US      : integer   := 1_000_000;  -- le trig de lecture de la temperature a une periode de 1sec pour ne pas submerger le proxy              
                
   -- commandes
   constant SCD_CMD_OVERHEAD_BYTES_NUM   : integer := 6; -- nombre de bytes de l'overhead (header, CommandID, length, Checksum)
   constant SCD_LONGEST_CMD_BYTES_NUM    : integer := 33; -- longueur maximale en byte de la config d'un scd (incluant le header, checksum etc). Ce nombre doit être inférieur à 64 à cause d'un fifo dans le copieur
   constant SCD_SERIAL_BAUD_RATE         : integer := 921_600; -- baud rate utilisé pour Scd (utilisé juste pour generateur de delai)
   constant SCD_COM_RESP_HDER            : std_logic_vector(7 downto 0)  := x"55";
   constant SCD_COM_RESP_FAILURE_ID      : std_logic_vector(15 downto 0) := x"FFFF";
   constant SCD_CMD_HDER                 : std_logic_vector(7 downto 0)  := x"AA";
   
   -- serial int time cmd
   constant SCD_INT_CMD_ID               : std_logic_vector(15 downto 0) := x"8001";
   constant SCD_INT_CMD_DLEN             : std_logic_vector(15 downto 0) := x"0006";
   
   -- serial operational cmd
   constant SCD_OP_CMD_ID                : std_logic_vector(15 downto 0) := x"8002";
   
   -- serial diag cmd                                                        
   constant SCD_DIAG_CMD_ID              : std_logic_vector(15 downto 0) := x"8004"; 
   
   -- serial frame resolution cmd                                                        
   constant SCD_FRAME_RES_CMD_ID         : std_logic_vector(15 downto 0) := x"8010"; 
   
   -- serial temperature read cmd
   constant SCD_TEMP_CMD_ID              : std_logic_vector(15 downto 0) := x"8021";
   
   -- partition de la ram de cfg serielle (la partie d'ecriture reservée à la config serielle a une plage d'adresse < 255)
   constant SCD_OP_CMD_RAM_BASE_ADD           : integer  := 0;    -- adresse de base où est logée la commande operationnelle en ram
   constant SCD_INT_CMD_RAM_BASE_ADD          : integer  := 64;   -- adresse de base où est logée la commande du temps d'integration en ram
   constant SCD_DIAG_CMD_RAM_BASE_ADD         : integer  := 128;
   constant SCD_TEMP_CMD_RAM_BASE_ADD         : integer  := 192;
   constant SCD_FRAME_RES_CMD_RAM_BASE_ADD    : integer  := 256;
   
   -- adresse de base de la zone securisée
   constant SCD_CMD_SECUR_RAM_BASE_ADD   : integer  := 1024; -- adresse où se retrouve la commande copiée dans la zone securisee
   
   -- quelques constantes 
   constant SERIAL_CFG_END_ADD           : std_logic_vector(7 downto 0) := x"FC"; -- adresse de fin d'envoi de la config serielle
   constant SERIAL_CFG_COPIER_START_DLY  : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   constant SERIAL_CFG_COPIER_END_DLY    : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   
   ----------------------------------------------
   -- Calculs 
   ---------------------------------------------- 
   constant SCD_FSYNC_HIGH_TIME_FACTOR     : integer := integer(FPA_INTF_CLK_RATE_MHZ*SCD_FSYNC_HIGH_TIME_US);
   constant SCD_POWER_WAIT_FACTOR          : integer := integer(FPA_INTF_CLK_RATE_MHZ*SCD_POWER_WAIT_US);
   constant SCD_SERIAL_TX_CLK_FACTOR       : integer := integer((FPA_INTF_CLK_RATE_MHZ*1E6)/SCD_SERIAL_BAUD_RATE); -- utilisé juste pour generateur de delai
   constant SCD_TEMP_TRIG_PERIOD_FACTOR    : integer := integer(FPA_INTF_CLK_RATE_MHZ*SCD_TEMP_TRIG_PERIOD_US);
   
   constant SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de SCD_EXP_TIME_CONV_DENOMINATOR  
   constant SCD_EXP_TIME_CONV_DENOMINATOR  : integer := 2**SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant SCD_CLK_FACTOR                 : real    := real(SCD_MASTER_CLK_RATE_MHZ)/real(FPA_INTF_CLK_RATE_MHZ);
   constant SCD_EXP_TIME_CONV_NUMERATOR    : unsigned(SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(natural((SCD_CLK_FACTOR/SCD_FRAME_RESOLUTION)*real(2**SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS)), SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     -- (80 x 2^26 )/100
   constant DEFINE_DIAG_DATA_CLK_FACTOR    : integer := integer((ceil(real(FPA_INTF_CLK_RATE_MHZ * 1000) / real(DEFINE_DIAG_CLK_RATE_MAX_KHZ)))*(2.0/real(PROXY_CLINK_PIXEL_NUM)));  
   
   
   
   ---------------------------------------------------------------------------------								
   -- Configuration regroupant les éléments vraiment propres au détecteur
   ---------------------------------------------------------------------------------
   -- scd integration
   type scd_int_cfg_type is
   record
      scd_int_time            : unsigned(24 downto 0);  --! temps d'integration en coups de 100Mhz 
      scd_int_indx            : std_logic_vector(7 downto 0);
   end record;
   
   -- scd operationnelle
   type scd_op_cfg_type is
   record  
      scd_xstart              : unsigned(10 downto 0); 
      scd_ystart              : unsigned(10 downto 0);
      scd_xsize               : unsigned(10 downto 0);
      scd_ysize               : unsigned(10 downto 0);
      scd_gain                : std_logic_vector(7 downto 0);
      scd_out_chn             : std_logic;   -- unused
      scd_diode_bias          : std_logic_vector(3 downto 0);
      scd_int_mode            : std_logic_vector(7 downto 0);
      scd_boost_mode          : std_logic;
      scd_pix_res             : std_logic_vector(1 downto 0);
      scd_frame_period_min    : unsigned(23 downto 0);
      cfg_num                 : unsigned(7 downto 0);      
   end record;
   
   -- scd video synthetic
   type scd_diag_cfg_type is
   record
      scd_bit_pattern         : std_logic_vector(2 downto 0);   
   end record;
   
   -- scd frame resolution (BB1280 only)
   type scd_frame_res_cfg_type is
   record
      cfg_num   : std_logic_vector(7 downto 0);
   end record;
   
   -- scd temperature
   type scd_temp_cfg_type is
   record
      scd_temp_read_num       : unsigned(7 downto 0);
   end record; 
   
   -- sol et eol de l'aoi
   type line_area_cfg_type is
   record      
      sol_pos             : unsigned(8 downto 0);     -- position de sol de l'aoi lorsque cropping actif
      eol_pos             : unsigned(8 downto 0);     -- position de eol de l'aoi lorsque cropping actif
   end record;
   
   -- scd misc 
   type scd_misc_cfg_type is
   record
      scd_x_to_readout_start_dly                 : unsigned(15 downto 0); -- Pelican/Hercule : delay T6 on fig 1 or 3 (d1k3008-rev1), BB1280 : FR_DLY (section 3.2.4.3.2 in D15F002 REV2 )
      scd_fsync_re_to_fval_re_dly                : unsigned(15 downto 0); -- Pelican/Hercule : delay T1 on fig 5 (d1k3008-rev1)
      scd_fval_re_to_dval_re_dly                 : unsigned(15 downto 0); -- Pelican/Hercule : delay T2 on fig 5 (d1k3008-rev1)
      scd_hdr_high_duration                      : unsigned(15 downto 0); -- Pelican/Hercule : delay T6 on fig 5 (d1k3008-rev1)
      scd_lval_high_duration                     : unsigned(15 downto 0); -- Pelican/Hercule : delay T3 on fig 5 (d1k3008-rev1)
      scd_hdr_start_to_lval_re_dly               : unsigned(15 downto 0); -- Pelican/Hercule : delay T5 on fig 5 (d1k3008-rev1)
      scd_lval_pause_dly                         : unsigned(15 downto 0); -- Pelican/Hercule : delay T4 on fig 5 (d1k3008-rev1)
      scd_x_to_next_fsync_re_dly                 : unsigned(15 downto 0); -- Pelican/Hercule : delay T5 on fig 1 & 3 (d1k3008-rev1), BB1280 : Integration or readout end to next fsync (D15F002 REV2)
      scd_fsync_re_to_intg_start_dly             : unsigned(15 downto 0); -- Pelican/Hercule : delay T4 on fig fig 1 & 3(d1k3008-rev1), BB1280 : INTEG_DLY (section 3.2.4.3.2 in D15F002 REV2 )
      scd_xsize_div_per_pixel_num                : unsigned(9 downto 0);  -- Pelican/Hercule = clink base (pixel_num = 2), BB1280 = clink full (pixel_num = 4)
   end record;
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record     
      cmd_to_update_id               : std_logic_vector(15 downto 0); -- cet ide permet de saoir quelle partie de la commande rentrante est à mettre à jour. Important pour regler bugs
      comn                           : fpa_comn_cfg_type;       -- partie commune (utilisée par les modules communs)
      scd_op                         : scd_op_cfg_type;         -- tout changement dans scd_op entraine la programmation du detecteur (commande operationnelle)
      scd_int                        : scd_int_cfg_type;        -- tout changement dans scd_int entraine la programmation du detecteur (commande temps d'intégration)
      scd_diag                       : scd_diag_cfg_type;       -- tout changement dans scd_diag entraine la programmation du detecteur (commande PE Syntehtique)
      scd_frame_res                  : scd_frame_res_cfg_type;  -- tout changement dans scd_frame_res entraine la programmation du detecteur (commande frame resolution)
      scd_temp                       : scd_temp_cfg_type;       -- tout changement dans scd_temp entraine la programmation du detecteur (commande temperature read)  
      scd_misc                       : scd_misc_cfg_type;       -- les changements dans scd_misc ne font pas programmer le detecteur
      aoi_data                       : line_area_cfg_type;      -- Config cropping
      fpa_serdes_lval_num            : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      fpa_serdes_lval_len            : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      int_time                       : unsigned(31 downto 0);   -- temps d'integration actuellement utilisé en coups de MCLK. Sert juste à generer un statut.
      enable_serdes_init             : std_logic;               -- Active l'initialisation des SERDES (pour BB1280 seulement)
      enable_failure_resp_management : std_logic;               -- Active la gestion des erreurs suite à la reception d'une "failure response" du proxy
      enable_serial_exptime_cmd      : std_logic;               -- Active l'envoi de config de temps d'intégration (pour BB1280 seulement)
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
   
   
   ----------------------------------------------								
   -- Type diag_data_ofs_type
   ----------------------------------------------
   --type diag_data_ofs_type is array (1 to 9) of natural range 0 to ((2**16)*9)/XSIZE_MAX; -- (1 to 9) pour accommoder 4 ou 8 taps
   
   
   ----------------------------------------------
   -- quues fontions                                    
   ----------------------------------------------
   --function to_diag_data_ofs return diag_data_ofs_type;
   --function to_fpa_word_func(a:fpa_intf_cfg_type) return fpa_word_type;

end Proxy_define;

package body Proxy_define is
   
   ---
   -- function to_diag_data_ofs return diag_data_ofs_type is
      -- variable y  : diag_data_ofs_type;
      -- variable ii : integer range 1 to 9;
      
   -- begin
      -- for ii in 1 to 9 loop    
         -- y(ii) := (ii - 1)*DIAG_DATA_INC;
      -- end loop;   
      -- return y;                 
   -- end to_diag_data_ofs; 
   
end package body Proxy_define; 
