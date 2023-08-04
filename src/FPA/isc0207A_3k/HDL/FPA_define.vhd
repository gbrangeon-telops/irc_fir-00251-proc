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
use work.fleg_brd_define.all; 

package FPA_define is    
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   -- consignes pour vérification avec infos en provenance du vhd, flex, et adc
   constant DEFINE_FPA_ROIC                       : std_logic_vector(7 downto 0) := FPA_ROIC_ISC0207;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                     : std_logic_vector(1 downto 0) := OUTPUT_ANALOG; 
   constant DEFINE_FPA_INPUT                      : std_logic_vector(7 downto 0) := LVTTL50;            -- le isc0207A_3k sera contrôlé à 5.0 en vue de reduire
   constant DEFINE_FPA_VIDEO_DATA_INVERTED        : std_logic := '1';      -- les données du isc0207A_3k sont en video inverse
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA      : natural   := 100;      -- consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                 : natural   := 16;                                                                                     
   constant DEFINE_FLEX_VOLTAGEP_mV               : natural   := 8_000;    -- ENO 03 juin 2016: le flex de ce détecteur doit être alimenté à 8000 mV 
   constant DEFINE_FPA_TEMP_CH_GAIN               : real      := 1.0;      -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l,ampli buffer et des resistances entre les deux 
   constant DEFINE_FPA_PIX_PER_MCLK_PER_TAP       : natural   := 2;        -- 1 pixels par coup d'horloge pour le isc0207A_3k
   constant DEFINE_FPA_BITSTREAM_LENGTH           : natural   := 58;       -- nombre de bits contenu  dans le bitstream de configuration serielle
   constant DEFINE_FPA_PROG_END_PAUSE_MCLK        : natural   := 20;       -- en fin d'envoi  d'un bitstream, delai minimum à observer avant l'envoi d'un autre. Bref le delaiminimal où SPI_CSN doit remonter à '1' 
   constant DEFINE_FPA_PROG_INT_TIME              : natural   := 100;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images post configuration du detecteur 
   constant DEFINE_FPA_XTRA_TRIG_INT_TIME         : natural   := 100;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images xtra trig
   constant DEFINE_FPA_SYNC_FLAG_VALID_ON_FE      : boolean   := false;    -- utilisé dans le module afpa_real_mode_dval_gen pour savoir si le sync_flag valid sur RE ou FE. False = valid sur RE.
   constant DEFINE_FPA_LINE_SYNC_MODE             : boolean   := true;    -- utilisé dans le module afpa_real_data_gen pour signaler à TRUE qu'il faille se synchroniser sur chaque ligne et à false pour signaler qu'une synchro en debut de trame est suffisante ou s
   constant DEFINE_FPA_INIT_CFG_NEEDED            : std_logic := '0';
   constant DEFINE_GENERATE_HPROC_CHAIN           : std_logic := '0';      -- on peut ne fait plus de diversité temporelle doncn ne plus utiliser la chaine Hprocessing.  
   constant DEFINE_GENERATE_VPROC_CHAIN           : std_logic := '0';    
   constant DEFINE_GENERATE_DYNRANGE_CTRL_CHAIN   : std_logic := '0';      -- on ne permet pas la troncature de la plage dynamique du détecteur (fait sur le M2K-UD uniquement pour reduire le ghost oscillant)
   constant DEFINE_ELCORR_REF_DAC_SETUP_US        : integer   := 500_000;  -- en usec, le delaui de stabilisation (analog setup)
   constant DEFINE_GENERATE_CROPPING_CHAIN        : std_logic := '0';      -- on ne fait pas de cropping
   
   constant DEFINE_FPA_MCLK_RATE_KHZ              : real      := 8_333.375;   --
   constant DEFINE_FPA_FAST_MCLK_RATE_KHZ         : real      := 2.0*DEFINE_FPA_MCLK_RATE_KHZ;   --
   constant DEFINE_FPA_INTCLK_RATE_KHZ            : real      := DEFINE_FPA_MCLK_RATE_KHZ;  -- l'horloge d'integration
   
   constant DEFINE_FPA_INT_TIME_OFFSET_nS         : natural   := 0;        -- ENO: 26 janv 2020. Provient desormais du driverC 
   
   -- integration, offset d'integration,  feedback
   constant DEFINE_GENERATE_INT_FDBK_MODULE       : std_logic := '0';      -- à '0' pour dire que le signal fpa_int_fdbk = fpa_int. à  '1' sinon. Dans ce cas, le fpa_int_fdbk est genere et on doit spécifier son delai. Sa duree est d'office FPA_INT_TIME. Faire attention au calcul des delais dans le fpa_intf.c pour le mode MODE_INT_END_TO_TRIG_START
   constant DEFINE_FPA_INT_FDBK_DLY               : natural   := DEFINE_FPA_INT_TIME_OFFSET_nS;        -- pour isc0209A, le fedback commence en même temps que la consigne (fpa_int) mais les deux signaux n'ont pas la même durée (DEFINE_FPA_INT_TIME_OFFSET_nS les differencie)
   
   constant DEFINE_GENERATE_ELCORR_CHAIN          : std_logic := '1';      -- pour le M3K, on fait de la correction de gain et d'offset
   constant DEFINE_GENERATE_ELCORR_GAIN           : std_logic := '1';      -- on ne fait pas que la correctioon de l'offset mais aussi du gain
   
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP     : integer   := 3;           -- pour le isc0207A_3k, on doit laisser 3 images dès qu'on reprogramme le détecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP            : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;           -- not used
   constant DEFINE_XSIZE_MAX                      : integer   := 320;         -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                      : integer   := 256;         -- dimension en Y maximale  
   constant DEFINE_GAIN0                          : std_logic := '0';
   constant DEFINE_GAIN1                          : std_logic := '1';    
   constant DEFINE_ITR_MODE                       : std_logic := '0'; 
   constant DEFINE_IWR_MODE                       : std_logic := '1';
   constant DEFINE_FPA_INT_FBK_AVAILABLE          : std_logic := '0';
   constant DEFINE_FPA_POWER_ON_WAIT_US           : integer   := 1_200_000;  -- en usec, duree d'attente après allumage pour declarer le FPA rdy. Le ramp-up du LT3042 est d'environ 1s.
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_US        : integer   := 500_000;    -- le trig de lecture de la temperature a une periode de 0.5sec
   constant DEFINE_FPA_TEMP_RAW_MIN               : integer   := 30720;      -- Minimum ADC value for isc0207A_3k power-on : 1.00 V de 2N2222 (soit 91K)  
   constant DEFINE_FPA_TEMP_RAW_MAX               : integer   := 35200;      -- Maximum ADC value for isc0207A_3k power-on : (to protect against ultra low temp). 1.039V 
   
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer   := 100_000;    --  horloge de 100M en KHz
   -- constant DEFINE_FPA_80M_CLK_RATE_KHZ           : integer   := 80_000;     --  horloge de 80M en KHz
   -- constant DEFINE_FPA_40M_CLK_RATE_KHZ           : integer   := 40_000;     --  horloge de 40M en KHz
   -- constant DEFINE_FPA_51_2M_CLK_RATE_KHZ         : integer   := 51_200;
   -- constant DEFINE_FPA_52_8M_CLK_RATE_KHZ         : integer   := 52_800;
   
   constant DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ  : real      := 2.0*DEFINE_FPA_MCLK_RATE_KHZ;     -- toujours prendre ADC_CLK_RATE = PCLK_RATE en vue de prendre un échantillon par pixel.
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ          : real      := 2.0*DEFINE_FPA_MCLK_RATE_KHZ;     -- toujours prendre ADC_CLK_RATE = PCLK_RATE en vue de prendre un échantillon par pixel.
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : real      := 8.0*DEFINE_FPA_MCLK_RATE_KHZ;             --   
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ : real      := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ;       -- c'est l'horloge à partir de laquelle est produite celle du détecteur. Il faut que ce soit rigoureusement la m^me source que les ADC. Ainsi le dehphasage entre le FPA_MASTER_CLK et les clocks des quads sera toujours le même. 
   
   -- limites imposées aux tensions VDAC provenant de celles de FP_VCC1 à FP_VCC8 du Fleg 
   -- provient du script F:\Bibliotheque\Electronique\PCB\EFP-00266-001 (Generic Flex Board TEL-2000)\Documentation\calcul_LT3042.m
   -- ATTENTION il faut avoir completer la correspondance entre VCC et  les tensions du détecteur avant que le script ne donne des resultats valides
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
   (11939, 13685),     -- limites du DAC1 pour le isc0207A_3k     VPOS_OUT
   (11939, 13685),     -- limites du DAC2 pour le isc0207A_3k     VPOS
   (11939, 13685),     -- limites du DAC3 pour le isc0207A_3k     VPOS_UC
   (    0, 16383),     -- limites du DAC4 pour le isc0207A_3k     VOUTREF
   (    0, 16383),     -- limites du DAC5 pour le isc0207A_3k     VOS
   (    0, 16383),     -- limites du DAC6 pour le isc0207A_3k     VDETCOM
   (    0, 16210),     -- limites du DAC7 pour le isc0207A_3k     inref
   (11939, 13685));    -- limites du DAC8 pour le isc0207A_3k     VPD
   
   --------------------------------------------
   --  modes diag
   --------------------------------------------
   -- D comme diag 
   constant DEFINE_TELOPS_DIAG_CNST               : std_logic_vector(7 downto 0):= x"D1";  -- mode diag constant
   constant DEFINE_TELOPS_DIAG_DEGR               : std_logic_vector(7 downto 0):= x"D2";  -- mode diag degradé pour la prod
   constant DEFINE_TELOPS_DIAG_DEGR_DYN           : std_logic_vector(7 downto 0):= x"D3";  -- mode diag degradé dynamique pour FAU
   
   -- increment des données en mode diag compteur
   constant DEFINE_DIAG_DATA_INC                  : integer    := 2*integer((2**14 - 1 - DEFINE_XSIZE_MAX)/(2*DEFINE_XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   
   ----------------------------------------------
   -- Calculs 
   ---------------------------------------------- 
   constant DEFINE_FPA_BITSTREAM_BYTE_NUM         : integer := integer(ceil(real(DEFINE_FPA_BITSTREAM_LENGTH)/8.0));
   constant DEFINE_FPA_PCLK_RATE_KHZ              : real    := real(DEFINE_FPA_PIX_PER_MCLK_PER_TAP)*DEFINE_FPA_MCLK_RATE_KHZ;
   constant DEFINE_FPA_FAST_PCLK_RATE_KHZ         : real    := real(DEFINE_FPA_PIX_PER_MCLK_PER_TAP)*DEFINE_FPA_FAST_MCLK_RATE_KHZ;
   constant DEFINE_FPA_POWER_WAIT_FACTOR          : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ*real(DEFINE_FPA_POWER_ON_WAIT_US/1000));
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_FACTOR    : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_TEMP_TRIG_PERIOD_US/1000);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR  : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR    : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_INTCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     --
   constant DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR    : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/(real(DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ)));
   constant DEFINE_ADC_QUAD_CLK_FACTOR            : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/(real(DEFINE_ADC_QUAD_CLK_RATE_KHZ)));
   constant DEFINE_FPA_MCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_PCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_PCLK_RATE_KHZ);
   constant DEFINE_FPA_FAST_MCLK_RATE_FACTOR      : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_FAST_MCLK_RATE_KHZ);
   constant DEFINE_FPA_FAST_PCLK_RATE_FACTOR      : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_FAST_PCLK_RATE_KHZ);
   constant DEFINE_FPA_INT_TIME_OFFSET_FACTOR     : integer := integer((real(DEFINE_FPA_INT_TIME_OFFSET_nS)*real(DEFINE_FPA_INTCLK_RATE_KHZ))/1_000_000.0);
   constant DEFINE_DIAG_PIX_SAMPLE_NUM_PER_CH     : natural := integer(real(DEFINE_ADC_QUAD_CLK_RATE_KHZ)/(real(DEFINE_FPA_PIX_PER_MCLK_PER_TAP)*DEFINE_FPA_MCLK_RATE_KHZ));
   constant XSIZE_MAX                             : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                             : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX   
   constant ADC_SERDES_CLK_1X_PERIOD_NS           : real    := 1_000_000.0/real(DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_PROG_END_PAUSE_FACTOR      : integer := DEFINE_FPA_PROG_END_PAUSE_MCLK * DEFINE_FPA_MCLK_RATE_FACTOR;
   constant DEFINE_ELCORR_REF_DAC_SETUP_FACTOR    : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ*real(DEFINE_ELCORR_REF_DAC_SETUP_US/1000));
   constant DEFINE_FPA_EXP_TIME_RECONV_NUMERATOR  : unsigned(31 downto 0):= to_unsigned(integer(real(DEFINE_FPA_100M_CLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_INTCLK_RATE_KHZ)), 32);
   
   ---------------------------------------------------------------------------------								
   -- Configuration
   ---------------------------------------------------------------------------------  
   -- misc                    
   type misc_cfg_type is
   record
      tir                        : unsigned(7 downto 0);
      xsize_div_tapnum           : unsigned(7 downto 0);
   end record;
   
   --type quad_clk_phase_type is array (1 to 4) of unsigned(5 downto 0);
   
   -- window_cfg_type                    
   type window_cfg_type is
   record      
      xstart                         : unsigned(10 downto 0); 
      ystart                         : unsigned(10 downto 0);
      xsize                          : unsigned(10 downto 0);
      ysize                          : unsigned(10 downto 0);
      xsize_div_tapnum               : unsigned(7 downto 0);
      ysize_div4_m1                  : unsigned(7 downto 0);
      ysize_div2_m1                  : unsigned(8 downto 0);
      lovh_mclk_source               : unsigned(15 downto 0);    -- lovh converti en coups d'hotloges mclk_source.Utilisé en mode diag 
   end record; 
   
   -- area                    
   type area_cfg_type is
   record
      -- parametres de window
      xstart                         : unsigned(9 downto 0); 
      ystart                         : unsigned(9 downto 0);
      xsize                          : unsigned(9 downto 0);
      ysize                          : unsigned(9 downto 0);      
      
      -- delimiteurs de trames et de lignes
      sof_posf_pclk                  : unsigned(8 downto 0);     --  pour isc0804A: 
      eof_posf_pclk                  : unsigned(16 downto 0);    --  pour isc0804A:
      sol_posl_pclk                  : unsigned(7 downto 0);     --  pour isc0804A:
      eol_posl_pclk                  : unsigned(7 downto 0);     --  pour isc0804A:
      eol_posl_pclk_p1               : unsigned(7 downto 0);     --  pour isc0804A: eol_posl_pclk + 1      
      
      -- lignes de debut et fin des zones    
      line_start_num                 : unsigned(9 downto 0);    --  pour isc0804A: 
      line_end_num                   : unsigned(9 downto 0);    --  pour isc0804A: 
      
      -- parametres divers
      readout_pclk_cnt_max           : unsigned(16 downto 0);   --  pour isc0804A: readout_pclk_cnt_max = taille en pclk de l'image incluant les pauses, les lignes non valides etc.. = (XSIZE/TAP_NUM + LOVH)* (YSIZE + FOVH) + 1  (un dernier PCLK pur finir)
      line_period_pclk               : unsigned(9 downto 0);    --  pour isc0804A: nombre de pclk =  XSIZE/TAP_NUM + LOVH)
      window_lsync_num               : unsigned(9 downto 0);    --  pour isc0804A: le nombre de pulse Lsync à envoyer. Il vaut active_line_end_num puisqu'il n'y a pas de ligne non active après les lignes actives.
      
   end record;
   
   ----------------------------------------------								
   -- Type hder_param
   ----------------------------------------------
   type hder_param_type is
   record
      exp_time            : unsigned(31 downto 0);         -- temps d'integration en coups de 100 MHz
      frame_id            : unsigned(31 downto 0);
      exp_index           : unsigned(7 downto 0);
      sensor_temp_raw     : std_logic_vector(15 downto 0);
      rdy                 : std_logic;                     -- pulse signifiant que les parametres du header sont prêts
   end record;
   
   ----------------------------------------------								
   -- Type raw_area_type
   ----------------------------------------------
   type raw_area_type is
   record
      -- raw_area info
      sof           : std_logic;        
      eof           : std_logic;
      sol           : std_logic;
      eol           : std_logic;
      fval          : std_logic;
      active_window : std_logic;      -- passe à '1' pour une ligne raw qui comporte une ligne user. Même si la ligne raw comprte aussi des pixels en dehors de la zone user 
      lval          : std_logic;
      dval          : std_logic;
      lsync         : std_logic;
      line_cnt      : unsigned(9 downto 0);    -- numero de ligne
      line_pclk_cnt : unsigned(9 downto 0);    -- compteur de coups d'horloge PCLK sur une ligne
      pclk_sample   : std_logic;
      imminent_lsync: std_logic;               -- permet de signaler 1CLK à l'avance de l'arrivée d'un LSYNC
   end record;   
   
   ----------------------------------------------								
   -- Type user_area_type
   ----------------------------------------------
   type user_area_type is
   record
      -- user_area info    
      sof           : std_logic;        
      eof           : std_logic;
      sol           : std_logic;
      eol           : std_logic;
      fval          : std_logic;
      lval          : std_logic;
      dval          : std_logic;
      spare_flag    : std_logic;           -- flag de spare
      imminent_sol  : std_logic;
   end record;
   
   ----------------------------------------------								
   -- Type waste_area_type
   ----------------------------------------------
   type waste_area_type is
   record
      -- waste_area info
      dval         : std_logic;
   end record;
   
   ----------------------------------------------								
   -- Type window_area_type
   ----------------------------------------------
   type window_info_type is
   record
      -- raw_area info
      raw                  : raw_area_type;                     
      
      -- user_area info
      user                 : user_area_type;
      
      --
      stretch              : std_logic;     -- à '1' lorsque le pixel/mclk en cours ne doit pas être accéléré. C'est une zone d'extension accolée à la zone usager pour éviter l,impact du pipe de ligne du isc0804A
      
      -- waste_area info
      waste                : waste_area_type;
      
      -- horloges associées
      fast_clk_en          : std_logic;
      slow_clk_en          : std_logic;
      imminent_clk_change  : std_logic;
      
      --
      data_id      : std_logic_vector(1 downto 0);
   end record;
   
   -- cfg des references pour correction electronique
   type elcorr_ref_cfg_type is 
   record
      ref_enabled                    : std_logic;
      ref_cont_meas_mode             : std_logic;
      start_dly_sampclk              : unsigned(7 downto 0);
      samp_num_per_ch                : unsigned(7 downto 0);
      samp_mean_numerator            : unsigned(22 downto 0);
      ref_value                      : unsigned(13 downto 0);  -- dac word correspondant à la valeur de refrence voulue pour la caorrection des offsets
      forced_val_enabled             : std_logic;              -- permet de forcer la valeur de la reference a la valeur du registre forced_val
      forced_val                     : unsigned(13 downto 0);  -- la reference prend cette valeur si forced_val_enabled = 1. Les valeurs echantillonnees de la reference sont ignorees
   end record;
   
   type elcorr_ref_cfg_array_type is array (0 to 1) of  elcorr_ref_cfg_type; 
   
   -- sol et eol de l'aoi
   type line_area_cfg_type is
   record      
      sol_pos                        : unsigned(9 downto 0);     -- position de sol de l'aoi lorsque cropping actif
      eol_pos                        : unsigned(9 downto 0);     -- position de eol de l'aoi lorsque cropping actif
   end record;
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------   
   type fpa_intf_cfg_type is
   record     
      -- cette partie provient du contrôleur du temps d'integration
      int_time                            : unsigned(31 downto 0);          -- temps d'integration en coups de MCLK. 
      int_indx                            : std_logic_vector(7 downto 0);   -- index du  temps d'integration
      int_signal_high_time                : unsigned(31 downto 0);          -- dureen en MCLK pendant laquelle lever le signal d'integration pour avoir int_time. depend des offsets de temps d'intégration   
      
      -- provenance hybride (µBlaze ou vhd)
      int_fdbk_dly                        : unsigned(1 downto 0);           -- delai avant generation du feedback d'integration. Utilisé pour certains détecteurs uniquement dont le ISC0209A à cause de l'offset dynamique
      
      -- cette partie provient du microBlaze
      -- common
      comn                                : fpa_comn_cfg_type;              -- partie commune (utilisée par les modules communs)
      
      -- diag window                      
      diag                                : window_cfg_type;
      
      -- roic window                           
      roic                                : window_cfg_type;     
      
      -- misc                             
      internal_outr                       : std_logic; 
      boost_mode                          : std_logic;
      
      -- gain                             
      gain                                : std_logic;        
      
      -- chn diversity                    
      adc_quad2_en                        : std_logic;  -- pour isc0207A, n'est pas envoyé par le MB car vaut toujours '1'
      
      -- delai                            
      real_mode_active_pixel_dly          : unsigned(7 downto 0);
      
      -- configuration des différentes zone de lecture
      speedup_lsydel                      : std_logic;
      speedup_lsync                       : std_logic;
      speedup_sample_row                  : std_logic;
      speedup_unused_area                 : std_logic;
      raw_area                            : area_cfg_type; -- zone brute 
      user_area                           : area_cfg_type; -- zone AOI demandée par l'usager
      stretch_area                        : area_cfg_type; -- zone d'étirement accolée à user_area, dans laquelle aucune accélération d'horloge n'est acceptée. ce, pour éviter des problèmes de perturbation dus au pipe de ligne du isc0804A
      
      -- nombre d'échantillons dans un pixel
      pix_samp_num_per_ch                 : unsigned(1 downto 0);     --  nombre d'echantillons constituant un pixel =  ADC_SAMP_RATE/PIX_RATE_PER_TAP
      
      -- calculs pour diversité des canaux
      hgood_samp_sum_num                  : unsigned(3 downto 0);    --  nombre d'échantillons horizontaux par pixel et par canal 
      hgood_samp_mean_numerator           : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      vgood_samp_sum_num                  : unsigned(3 downto 0);    --  nombre d'échantillons verticaux par pixel (>=2 => diversité des canaux active sinon vaut 1)
      vgood_samp_mean_numerator           : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      -- choix des échantillons par canal
      good_samp_first_pos_per_ch          : unsigned(1 downto 0);    -- position du premier bon echantillon 
      good_samp_last_pos_per_ch           : unsigned(1 downto 0);    -- position du dernier bon echantillon       
      
      -- misc                             
      roic_ysize_div2_m1                  : unsigned(6 downto 0);
      
      -- les valeurs Vdac                 
      vdac_value                          : fleg_vdac_value_type;     -- calculé dans le MB pour dac(1) à dac(8)
      
      -- adc clk_phase                    
      adc_clk_source_phase                : signed(31 downto 0);     -- dit de combien déphaser l'horloge des ADCs 
      adc_clk_pipe_sel                    : unsigned(7 downto 0);
      spare1                              : std_logic_vector(7 downto 0);
      
      -- lsync delay time en coup d'horloge mclk
      lsydel_mclk                         : unsigned(7 downto 0);
      adc_clk_pipe_sync_pos               : unsigned(7 downto 0);
      
      -- reorder column                   
      reorder_column                      : std_logic;               -- non envoyé par le MBlaze 
      
      -- electrical analog chain correction   
      elcorr_enabled                 : std_logic; 
      
      -- pixel data ctrl
      elcorr_spare1                  : std_logic;              -- permet de forcer la valeur des pixels (données des ADCs) à la valeur du registre "fpa_faked_pixel_value"
      elcorr_spare2                  : unsigned(14 downto 0);  -- la valeur des pixels est remplacée par celle contenue dans ce registre lorsque elec_ofs_pixel_faked_value_forced = '1'
      
      -- refrence signal 
      elcorr_ref_cfg                 : elcorr_ref_cfg_array_type;                                                                                                             
      elcorr_ref_dac_id              : unsigned(3 downto 0);  -- l'id du dac qui doit etre programmé avec les tensions de references pour la correction de gain et offset 
      
      -- multiplier control 
      elcorr_atemp_gain              : signed(17 downto 0);
      
      -- adder control
      elcorr_atemp_ofs               : signed(17 downto 0);
      
      -- embedded switches control
      elcorr_ref0_op_sel             : std_logic_vector(1 downto 0);
      elcorr_ref1_op_sel             : std_logic_vector(1 downto 0);
      elcorr_mult_op_sel             : std_logic_vector(1 downto 0);
      elcorr_div_op_sel              : std_logic_vector(1 downto 0);
      elcorr_add_op_sel              : std_logic_vector(1 downto 0);   
      
      -- spare
      elcorr_spare3                       : std_logic;          
      
      -- gestion de la saturation basse et haute à la sortie du module fpa
      sat_ctrl_en                         : std_logic;
      
      -- maintien de la sortie  du roic à voutref 
      roic_cst_output_mode                : std_logic;
      
      -- mode evenementiel: calcul du gain seulement lorsqu'une nouvelle config arrive
      cfg_num                             : unsigned(7 downto 0);
      
      -- dac free running mode 
      elcorr_spare4                       : std_logic;
      
      -- parametres propres à ISC0207A 
      readout_plus_delay                  : unsigned(15 downto 0);
      tri_min_window_part                 : signed(17 downto 0);   
      int_time_offset_mclk                : signed(7 downto 0);
      spare2                              : signed(15 downto 0);
      tsh_min_minus_int_time_offset       : signed(15 downto 0);
      
      -- additional exposure time offset from driver C
      spare3                              : signed(31 downto 0);
      
      -- cropping
      aoi_data                            : line_area_cfg_type;
      aoi_flag1                           : line_area_cfg_type;
      aoi_flag2                           : line_area_cfg_type;
      
      -- FPA: clipping of the dynamic range 
      dynrange_scaling_numerator          : unsigned(22 downto 0);
      dynrange_clipping_level             : unsigned(13 downto 0);
      
   end record;     
   
   ----------------------------------------------								
   -- Type readout_info_type
   ----------------------------------------------
   -- aoi
   type aoi_readout_info_type is
   record
      sof            : std_logic;        
      eof            : std_logic;
      sol            : std_logic;
      eol            : std_logic;
      fval           : std_logic;                     
      lval           : std_logic;
      dval           : std_logic;
      read_end       : std_logic;                     -- pulse  en dehors de fval mais qui signifie que le readout est terminé
      samp_pulse     : std_logic;                     -- sampling pluse de frequence valant celle des adc
      spare          : std_logic_vector(14 downto 0); -- pour utilisation future
   end record;
   
   -- non_aoi
   type non_aoi_readout_info_type is
   record
      start          : std_logic;                     -- pulse  en dehors de fval mais qui signifie que le readout est terminé
      stop           : std_logic;                     -- divers flags synchronisables avec readout_info. Attention: après read_end, les misc flags ne servent à rien. Si besoin d'utilser des flags après rd_end alors utiliser les ADC_FLAG  
      dval           : std_logic;  
      samp_pulse     : std_logic;                     -- sampling pulse de frequence valant celle des adc
      ref_valid      : std_logic_vector(1 downto 0);  -- dit laquelle des deux references est en progression dans la chaine. Utile pour correction dynamqieu de  l'électronique
      spare          : std_logic_vector(12 downto 0); -- pour utilisation future
   end record;
   
   -- readout_type
   type readout_info_type is
   record
      aoi            : aoi_readout_info_type;        
      naoi           : non_aoi_readout_info_type;
      samp_pulse     : std_logic;
   end record;
   
   ----------------------------------------------
   -- quues fontions                                    
   ----------------------------------------------
   
end FPA_define;

package body FPA_define is
   
   
   
end package body FPA_define; 
