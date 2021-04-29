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
   constant DEFINE_FPA_MCLK_SOURCE_RATE_KHZ       : integer   := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ; 
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer := 100_000;
   
   
   constant FSYNC_HIGH_TIME_US                    : integer := 5;     -- duree de FSYNC en usec
   constant POWER_WAIT_US                         : integer := 2_000_000;  -- duree d'attente après allumage en usec. selon la doc, le proxy prend 1 sec. Pour plus de securité, j'en mets 2
   constant TEMP_TRIG_PERIOD_US                   : integer := 1_000_000;  -- le trig de lecture de la temperature a une periode de 1sec pour ne pas submerger le proxy
   
   -- commandes                                   
   constant SERIAL_BAUD_RATE                      : integer := 921_600; -- baud rate utilisé pour Scd (utilisé juste pour generateur de delai)
   
   -- control Bits (voir la doc atlasdatasheet2.17ext)
   constant CBITS_PIXEL_ID                        : std_logic_vector(3 downto 0) := x"E";
   constant CBITS_FRM_IDLE_ID                     : std_logic_vector(3 downto 0) := x"3";
   constant CBITS_FRM_STATUS_ID                   : std_logic_vector(3 downto 0) := x"8";
   
   ----------------------------------------------
   -- calculs 
   ---------------------------------------------- 
   -- attention aux modifs à apporter aux lignes des calculs
   constant DEFINE_DIAG_DATA_INC                         : integer := 2*integer(((2**14)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- 2*integer(((2**16)- 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   constant PROXY_CLINK_CLK_1X_PERIOD_NS                 : real    := 1_000_000.0/real(DEFINE_FPA_PCLK_RATE_KHZ);       
   constant DEFINE_ADC_QUAD_CLK_FACTOR                   : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR         : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant FSYNC_HIGH_TIME_FACTOR                       : integer := integer((real(DEFINE_FPA_MCLK_SOURCE_RATE_KHZ) * real(FSYNC_HIGH_TIME_US))/1000.0);
   constant POWER_WAIT_FACTOR                            : integer := integer((real(DEFINE_FPA_MCLK_SOURCE_RATE_KHZ) * real(POWER_WAIT_US))/1000.0);
   constant SERIAL_TX_CLK_FACTOR                         : integer := integer((real(DEFINE_FPA_MCLK_SOURCE_RATE_KHZ)*1000.0) / real(SERIAL_BAUD_RATE)); -- utilisé juste pour generateur de delai
   constant TEMP_TRIG_PERIOD_FACTOR                      : integer := integer((real(DEFINE_FPA_MCLK_SOURCE_RATE_KHZ) * real(TEMP_TRIG_PERIOD_US))/1000.0);
   
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
   
   -- cmd
   --   constant COM_RESP_HDER            : std_logic_vector(7 downto 0)  := x"55";
   --   constant COM_RESP_FAILURE_ID      : std_logic_vector(15 downto 0) := x"FFFF";
   
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
      int_time             : unsigned(23 downto 0);            -- temps d'integration en coups de MCLK
      int_signal_high_time : unsigned(23 downto 0);            -- temps d'integration que le detecteur doit faire en tenant compte de son offset interne en temps.                        -- 
      int_dly              : unsigned(19 downto 0);            -- delay avant debut de integration. Delai entre Fsync et le debut du signal d'integration
      int_indx             : std_logic_vector(7 downto 0);                    
      frame_dly		      : unsigned(19 downto 0);        	   -- delay entre Fsync et le debut du readout. frame_dly = a*int + frame_dly_cst 
      int_dval             : std_logic;
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
      frame_time       : unsigned(19 downto 0);        	-- frame time en coups de int_clk
      
      -- gain et mode
      gain             : std_logic_vector(7 downto 0); 	-- op_mode de bb1920
      int_mode         : std_logic_vector(7 downto 0);  -- itr ou iwr
      test_mode        : std_logic_vector(7 downto 0);   -- vid_if_bit_en de bb1920. C'est le test pattern mode
      
      -- bias et saturation
      det_vbias        : std_logic_vector(3 downto 0);	-- mtx_vdet de bb1920
      det_ibias        : std_logic_vector(3 downto 0); 	-- mtx_idet de bb1920
      
      -- misc
      binning          : std_logic_vector(1 downto 0);	  
      output_rate      : std_logic_vector(1 downto 0); 	-- video_rate de bb1920      
      cfg_num          : unsigned(7 downto 0);      
      
   end record;
   
   -- scd_proxy2 synth
   type synth_cfg_type is
   record  
      spare            : std_logic_vector(1 downto 0);	-- mtx_intg_low de bb1920
      frm_res          : unsigned(6 downto 0);
      frm_dat          : std_logic_vector(1 downto 0);
   end record;
   
   -- telops diag
   type diag_cfg_type is
   record
      ysize               : unsigned(10 downto 0);
      xsize_div_tapnum    : unsigned(10 downto 0);
      lovh_mclk_source    : unsigned(15 downto 0);
   end record;
   
   -- scd_proxy2 temperature
   type temp_cfg_type is
   record
      cfg_num             : unsigned(7 downto 0);
      cfg_end             : std_logic;                -- necessaire pour que mb_cfg_in_progress retombe à '0' dans le receveur de config
   end record; 
   
   -- sol et eol de l'aoi
   type line_area_cfg_type is
   record      
      sol_pos             : unsigned(9 downto 0);     -- position de sol de l'aoi lorsque cropping actif
      eol_pos             : unsigned(9 downto 0);     -- position de eol de l'aoi lorsque cropping actif
   end record;
   
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record 
      
      comn                           : fpa_comn_cfg_type;   -- partie commune (utilisée par les modules communs)
      
      -- diag mode
      diag                           : diag_cfg_type;   --
      real_mode_active_pixel_dly     : unsigned(15 downto 0);
      
      -- integration mode
      itr                            : std_logic;
      int_time                       : unsigned(23 downto 0);   -- consigne du temps d'integration actuellement utilisé en coups de MCLK. Sert juste à generer un statut.
      
      -- aoi (cropping)
      aoi_xsize                      : unsigned(10 downto 0);
      aoi_ysize                      : unsigned(10 downto 0);
      aoi_data                       : line_area_cfg_type;
      aoi_flag1                      : line_area_cfg_type;
      aoi_flag2                      : line_area_cfg_type;
      
      -- les cmds structurales
      op                             : op_cfg_type;     -- tout changement dans op entraine la programmation du detecteur (commnde operationnelle)
      synth                          : synth_cfg_type;  -- tout changement dans op entraine la programmation du detecteur (commnde operationnelle)
      int                            : int_cfg_type;    -- tout changement dans int entraine la programmation du detecteur (commnde temps d'intégration)
      temp                           : temp_cfg_type;   -- tout changement dans temp entraine la programmation du detecteur (commnde temperature read)  
      
      -- cmd serielle integration 
      int_cmd_id                     : std_logic_vector(15 downto 0);
      int_cmd_data_size              : unsigned(15 downto 0);
      int_cmd_dlen                   : unsigned(15 downto 0);
      int_cmd_offs                   : std_logic_vector(7 downto 0);
      int_cmd_sof_add                : unsigned(7 downto 0);
      int_cmd_eof_add                : unsigned(7 downto 0);
      int_cmd_sof_add_m1             : unsigned(7 downto 0);
      int_checksum_add               : unsigned(7 downto 0);
      frame_dly_cst                  : unsigned(19 downto 0);   -- valeur constante à ajouter pour avoir  frame_dly = int + frame_dly_cst
      int_dly_cst                    : unsigned(19 downto 0);   -- valeur constante en provenance du MB pour le compte de int_dly
      
      -- cmd serielle operationnelle
      op_cmd_id                      : std_logic_vector(15 downto 0);
      op_cmd_data_size               : unsigned(15 downto 0);
      op_cmd_dlen                    : unsigned(15 downto 0);
      op_cmd_sof_add                 : unsigned(7 downto 0);
      op_cmd_eof_add                 : unsigned(7 downto 0);
      
      -- cmd serielle video synthetique (diag scd)
      synth_cmd_id                   : std_logic_vector(15 downto 0);
      synth_cmd_data_size            : unsigned(15 downto 0);
      synth_cmd_dlen                 : unsigned(15 downto 0);
      synth_cmd_sof_add              : unsigned(7 downto 0);
      synth_cmd_eof_add              : unsigned(7 downto 0);
      
      -- cmd serielle temperature
      temp_cmd_id                    : std_logic_vector(15 downto 0);
      temp_cmd_data_size             : unsigned(15 downto 0);
      temp_cmd_dlen                  : unsigned(15 downto 0);
      temp_cmd_sof_add               : unsigned(7 downto 0);
      temp_cmd_eof_add               : unsigned(7 downto 0);    
      
      --- misc     
      outgoing_com_hder              : std_logic_vector(7 downto 0);
      outgoing_com_ovh_len           : unsigned(7 downto 0);
      incoming_com_hder              : std_logic_vector(7 downto 0);
      incoming_com_fail_id           : std_logic_vector(15 downto 0);
      incoming_com_ovh_len           : unsigned(7 downto 0);
      fpa_serdes_lval_num            : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée
      fpa_serdes_lval_len            : unsigned(10 downto 0);   -- pour la calibration des serdes d'entrée        
      int_clk_period_factor          : unsigned(7 downto 0);
      int_time_offset                : signed(31 downto 0);
      proxy_alone_mode               : std_logic;               -- à '1' pour tester le proxy SCD sans detecteur 
      
   end record;    
   
   ----------------------------------------------								
   -- Type hder_param
   ----------------------------------------------
   type hder_param_type is
   record
      exp_time            : unsigned(31 downto 0);              -- temps d'integration en coups de 100 MHz
      frame_id            : unsigned(31 downto 0);
      sensor_temp_raw     : std_logic_vector(15 downto 0);
      exp_index           : unsigned(7 downto 0);
      rdy                 : std_logic;                     -- pulse signifiant que les parametres du header sont prêts
   end record;
   
   ----------------------------------------------								
   -- Type serial_param
   ----------------------------------------------
   type serial_param_type is
   record
      cmd_sof_add    : unsigned(7 downto 0);
      cmd_eof_add    : unsigned(7 downto 0);
      run            : std_logic;
      abort          : std_logic;
      prog_trig_mode : std_logic;  -- à '1', impose le mode prog_trig. prog_trig avant l'envoi de la commande et prog_trig après l'envoi de la commande
   end record;  
   
end Proxy_define;

package body Proxy_define is
   
   
   
end package body Proxy_define; 
