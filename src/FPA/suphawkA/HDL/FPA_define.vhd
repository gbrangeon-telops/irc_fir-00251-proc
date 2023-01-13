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
use work.fastrd2_define.all;

package FPA_define is    
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   -- consignes pour vérification avec infos en provenance du vhd, flex, et adc
   constant DEFINE_FPA_ROIC                       : std_logic_vector(7 downto 0) := FPA_ROIC_SUPHAWK;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                     : std_logic_vector(1 downto 0) := OUTPUT_ANALOG; 
   constant DEFINE_FPA_INPUT                      : std_logic_vector(7 downto 0) := LVCMOS33;       -- le suphawk sera contrôlé à 3.3V
   constant DEFINE_FPA_VIDEO_DATA_INVERTED        : std_logic := '1';      -- les données du suphawk sont en video inverse     
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA      : natural   := 100;      -- consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                 : natural   := 8;                                                                                     
   constant DEFINE_FLEX_VOLTAGEP_mV               : natural   := 8000;     -- le flex de ce détecteur doit être alimenté à 8V 
   constant DEFINE_FPA_TEMP_CH_GAIN               : real      := 1.0;      -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l,ampli buffer et des resistances entre les deux 
   constant DEFINE_FPA_PIX_PER_MCLK_PER_TAP       : natural   := 1;        -- 1 pixels par coup d'horloge pour le suphawk
   
   -- integration, offset d'integration,  feddeback
   constant DEFINE_GENERATE_INT_FDBK_MODULE       : std_logic := '0';      -- à '0' pour dire que le signal fpa_int_fdbk = fpa_int. à  '1' sinon. Dans ce cas, le fpa_int_fdbk est genere et on doit spécifier son delai. Sa duree est d'office FPA_INT_TIME. Faire attention au calcul des delais dans le fpa_intf.c pour le mode MODE_INT_END_TO_TRIG_START
   constant DEFINE_FPA_INT_FDBK_DLY               : natural   := 0;        -- pour superhawk, le fedback commence en même temps que la consigne (fpa_int) mais les deux signaux n'ont pas la même durée (DEFINE_FPA_INT_TIME_OFFSET_nS les differencie)
   constant DEFINE_FPA_INT_TIME_OFFSET_nS         : natural   := 0;        -- int_time offset de 0 nsec 
   
   constant DEFINE_FPA_PROG_INT_TIME              : natural   := 4;        -- en coups d'horloge FPA, c'est le temps d'integration utilisé piour les images post configuration du detecteur 
   constant DEFINE_FPA_XTRA_TRIG_INT_TIME         : natural   := 4;        -- en coups d'horloge FPA, c'est le temps d'integration utilisé piour les images post configuration du detecteur 
   constant DEFINE_FPA_SYNC_FLAG_VALID_ON_FE      : boolean   := false;     -- utilisé dans le module afpa_real_mode_dval_gen pour savoir si le sync_flag valid sur RE ou FE. False = valid sur RE.
   constant DEFINE_FPA_INIT_CFG_NEEDED            : std_logic := '0';      -- pas besoin de config particulière au demarrage des suphawks
   constant DEFINE_GENERATE_HPROC_CHAIN           : std_logic := '0';      -- on peut ne fait plus de diversité temporelle doncn ne plus utiliser la chaine Hprocessing.  
   constant DEFINE_GENERATE_VPROC_CHAIN           : std_logic := '0';      -- diversité de canaux
   constant DEFINE_GENERATE_QUAD2_CHAIN           : std_logic := '1';      -- à '1' permet de generer la chaine de traitement pour le quad 2 puisqu'il faut 8 canaux
   constant DEFINE_FPA_LINE_SYNC_MODE             : boolean   := true;     -- utilisé dans le module afpa_real_data_gen pour signaler à TRUE qu'il faille se synchroniser sur chaque ligne et à false pour signaler qu'une synchro en debut de trame est suffisante ou s
   constant DEFINE_GENERATE_ELCORR_CHAIN          : std_logic := '0';      -- on fait de la correction électronique
   constant DEFINE_GENERATE_ELCORR_GAIN           : std_logic := '0';      -- on ne fait aucune correction de gain, mais juste l'offset au besoin
   constant DEFINE_ELCORR_REF_DAC_SETUP_US        : integer   := 300_000;  -- en usec, le delai de stabilisation (analog setup)
   constant DEFINE_GENERATE_CROPPING_CHAIN        : std_logic := '0';      -- on ne fait pas de cropping
   
   ------------------------------------------------------------
   -- fastrd2
   ------------------------------------------------------------
   -- definition les differentes horloges MCLK. Les IDs sont definis par les positions des bits occupées dans l'argument de la fonction gen_fpa_clk_info_func
   constant DEFINE_FPA_NOMINAL_MCLK_ID            : integer := 0;       -- l'horloge nominale doit toujours occuper l'ID 0
   constant DEFINE_FPA_SIDEBAND_MCLK_ID           : integer := 1;       -- horloge de la bande latérale
   constant DEFINE_FPA_LINEPAUSE_MCLK_ID          : integer := 2;       -- horloge du blank
   constant DEFINE_FPA_MCLK_NUM                   : integer := 3;
   constant DEFINE_FPA_NOMINAL_MCLK_RATE_HZ       : integer := 10_000_000; -- vitesse nominale
   constant DEFINE_FPA_SIDEBAND_MCLK_RATE_HZ      : integer := 5_000_000;  -- vitesse d'opération dans la zone de bande laterale
   constant DEFINE_FPA_LINEPAUSE_MCLK_RATE_HZ     : integer := 15_000_000; -- vitesse d'opération dans la zone interligne pour compenser le SIDEBAND_MCLK_RATE_KHZ
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_HZ  : integer := 60_000_000; -- -- c'est l'horloge à partir de laquelle est produite celle du détecteur. On a le choix entre 100MHz, 80MHz et 60 MHz.Il faut que ce soit rigoureusement la m^me source que les ADC. Ainsi le dehphasage entre le FPA_MASTER_CLK et les clocks des quads sera toujours le même. 
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ : integer := DEFINE_FPA_MASTER_CLK_SOURCE_RATE_HZ/1000; --fréquence de horloge principale MCLK_SOURCE en kHz

   -- generation des infos d'horloge
   -- position 0     -> clk ayant le clk rate nominal 
   -- position 7 à 1 -> les autres horloges
   -- mettre 0 comme valeur aux positions non utilisées 
   constant DEFINE_FPA_CLK_INFO                   : fpa_clk_info_type := gen_fpa_clk_info_func(
   DEFINE_FPA_MASTER_CLK_SOURCE_RATE_HZ, DEFINE_FPA_PIX_PER_MCLK_PER_TAP, (0, 0, 0, 0, 0, DEFINE_FPA_LINEPAUSE_MCLK_RATE_HZ, 
   DEFINE_FPA_SIDEBAND_MCLK_RATE_HZ, DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)); -- mettre 0 comme valeur aux positions non utilisées 
   constant DEFINE_FPA_NOMINAL_MCLK_RATE_KHZ      : real := real(DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)/1000.0; 
   
   -- quelques caractéristiques du FPA
   --constant DEFINE_FPA_INT_TIME_MIN_US            : integer   := 1; 
   constant DEFINE_FPA_MCLK_RATE_KHZ              : integer   := 10_000;       -- pour le superHawk, c'est fixé à 5MHz. Donc non configurable. D'où sa présence dans le fpa_define. Pour d'autres détecteurs, il peut se retrouver dans le pilote en C
   constant DEFINE_FPA_INTCLK_RATE_KHZ            : integer   := DEFINE_FPA_MCLK_RATE_KHZ;  -- l'horloge d'integration

   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP     : integer   := 2;            -- pour le suphawk, on doit laisser 3 images dès qu'on reprogramme le détecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP            : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;        -- not used
   constant DEFINE_XSIZE_MAX                      : integer   := 1280;          -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                      : integer   := 1024;          -- dimension en Y maximale  
   constant DEFINE_ITR_MODE                       : std_logic := '0';
   constant DEFINE_IWR_MODE                       : std_logic := '1';
   constant DEFINE_FPA_INT_FBK_AVAILABLE          : std_logic := '0';
   constant DEFINE_FPA_POWER_ON_WAIT_US           : integer   := 1_200_000;  -- en usec, duree d'attente après allumage pour declarer le FPA rdy. Le ramp-up du LT3042 est d'environ 1s.
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_US        : integer   := 500_000;    -- le trig de lecture de la temperature a une periode de 0.5sec
   constant DEFINE_FPA_TEMP_RAW_MIN               : integer   := 30000;      -- Minimum ADC value for suphawk power-on : 0.940V (soit 140K)  
   constant DEFINE_FPA_TEMP_RAW_MAX               : integer   := 35200;      -- Maximum ADC value for suphawk power-on : (to protect against ultra low temp). 1.1V 
   
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer   := 100_000;    --  horloge de 100M en KHz
   
   -- quelques caractéristiques de la carte ADC requise
   constant DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ  : integer   := DEFINE_FPA_MCLK_RATE_KHZ;       -- 
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ          : integer   := DEFINE_FPA_MCLK_RATE_KHZ;       --
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : integer   := DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ; -- c'est l'horloge à partir de laquelle est produite celle des quads. On a le choix entre 100MHz, 80MHz et 60MHz.
      
   -- limites imposées aux tensions VDAC deduites de celles de FP_VCC1 à FP_VCC8 du Fleg 
   -- provient du script F:\Bibliotheque\Electronique\PCB\EFP-00266-001 (Generic Flex Board TEL-2000)\Documentation\calcul_LT3042.m
   -- ATTENTION il faut avoir completer la correspondance entre VCC et  les tensions du détecteur avant que le script ne donne des resultats valides
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
   (6701,  7574),     -- limites du DAC1 pour le suphawk
   (1899, 16305),     -- limites du DAC2 pour le suphawk 
   (6701,  7574),     -- limites du DAC3 pour le suphawk
   (4049,  5062),     -- limites du DAC4 pour le suphawk
   (333 , 16210),     -- limites du DAC5 pour le suphawk
   (8440, 11818),     -- limites du DAC6 pour le suphawk
   (   0, 16210),     -- limites du DAC7 pour le suphawk
   (1899, 16305));    -- limites du DAC8 pour le suphawk 
   
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
   --constant DEFINE_FPA_BITSTREAM_BYTE_NUM         : integer := integer(ceil(real(DEFINE_FPA_BITSTREAM_LENGTH)/8.0));
   constant DEFINE_FPA_PCLK_RATE_KHZ              : integer := integer(DEFINE_FPA_PIX_PER_MCLK_PER_TAP*DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_POWER_WAIT_FACTOR          : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ*(DEFINE_FPA_POWER_ON_WAIT_US/1000));
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_FACTOR    : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_TEMP_TRIG_PERIOD_US/1000);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR  : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR    : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_INTCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     --
   constant DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR    : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ);
   constant DEFINE_ADC_QUAD_CLK_FACTOR            : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_MCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_PCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_PCLK_RATE_KHZ);
   constant DEFINE_FPA_INT_TIME_OFFSET_FACTOR     : integer := integer((real(DEFINE_FPA_INT_TIME_OFFSET_nS)*real(DEFINE_FPA_INTCLK_RATE_KHZ))/1_000_000.0);
   constant DEFINE_DIAG_PIX_SAMPLE_NUM_PER_CH     : natural := integer(DEFINE_ADC_QUAD_CLK_RATE_KHZ/(DEFINE_FPA_PIX_PER_MCLK_PER_TAP*DEFINE_FPA_MCLK_RATE_KHZ));
   constant XSIZE_MAX                             : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                             : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX   
   constant ADC_SERDES_CLK_1X_PERIOD_NS           : real    := 1_000_000.0/real(DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_ELCORR_REF_DAC_SETUP_FACTOR    : integer := integer(real(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ)*real(DEFINE_ELCORR_REF_DAC_SETUP_US/1000));
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
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------ 
   
   -- window_cfg_type                    
   type window_cfg_type is
   record      
      xstart                         : unsigned(10 downto 0); 
      ystart                         : unsigned(10 downto 0);
      xsize                          : unsigned(10 downto 0);
      ysize                          : unsigned(10 downto 0);
      xsize_div_tapnum               : unsigned(7 downto 0);
      ysize_div4_m1                  : unsigned(7 downto 0);
      lovh_mclk_source               : unsigned(15 downto 0);    -- lovh converti en coups d'hotloges mclk_source.Utilisé en mode diag 
   end record;  
   
   -- cfg des references pour correction electronique
   type elcorr_ref_cfg_type is 
   record
      ref_enabled                    : std_logic;
      ref_cont_meas_mode             : std_logic;   -- mode de mesure/calcul continuel
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
   
   
   type fpa_intf_cfg_type is
   record     
      -- cette partie provient du contrôleur du temps d'integration
      int_time                            : unsigned(31 downto 0);          -- temps d'integration en coups de MCLK. 
      int_indx                            : std_logic_vector(7 downto 0);   -- index du  temps d'integration
      int_signal_high_time                : unsigned(31 downto 0);          -- dureen en MCLK pendant laquelle lever le signal d'integration pour avoir int_time. depend des offsets de temps d'intégration   
      
      -- provenance hybride (µBlaze ou vhd)
      int_fdbk_dly                        : unsigned(1 downto 0);          -- delai avant generation du feedback d'integration. Utilisé pour certains détecteurs uniquement dont le ISC0209A à cause de l'offset dynamique
      
      -- cette partie provient du microBlaze
      -- common
      comn                                : fpa_comn_cfg_type;      -- partie commune (utilisée par les modules communs)
      
      -- diag window                     
      diag                                : window_cfg_type; 
      
      -- window, gain                    
      xstart                              : unsigned(10 downto 0); 
      ystart                              : unsigned(10 downto 0);
      xsize                               : unsigned(10 downto 0);
      ysize                               : unsigned(10 downto 0);
      gain                                : std_logic;
      invert                              : std_logic; 
      revert                              : std_logic;   
      cbit_en                             : std_logic;
      dig_code                            : unsigned(15 downto 0);      
      
      colstart                            : unsigned(8 downto 0); 
      colstop                             : unsigned(8 downto 0);
      rowstart                            : unsigned(10 downto 0);
      rowstop                             : unsigned(10 downto 0);      
      active_subwindow                    : std_logic;     
      
      prv_dac_nominal_value               : unsigned(13 downto 0);     -- valeur de PRV en mot DAC
      
      -- delai 
      real_mode_active_pixel_dly          : unsigned(7 downto 0);
      
      -- chn diversity
      adc_quad2_en                        : std_logic; -- à '1' si les données du quad2 doivent êre prises en compte par la chaine
      chn_diversity_en                    : std_logic; -- dit quoi faire avec les données du quad2. '1' si ces données sont des repliques du quad1 => chn diversity. '0' si ces données doient être considérées comme des des données de taps 5, 6, 7, 8 d'un détrecteur 8 taps.
      
      -- nombre d'échantillons dans un pixel
      pix_samp_num_per_ch                 : unsigned(7 downto 0);     --  nombre d'echantillons constituant un pixel =  ADC_SAMP_RATE/PIX_RATE_PER_TAP
      
      -- calculs pour diversité des canaux
      hgood_samp_sum_num                  : unsigned(3 downto 0);    --  nombre d'échantillons horizontaux par pixel et par canal 
      hgood_samp_mean_numerator           : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      vgood_samp_sum_num                  : unsigned(3 downto 0);    --  nombre d'échantillons verticaux par pixel (>=2 => diversité des canaux active sinon vaut 1)
      vgood_samp_mean_numerator           : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      -- choix des échantillons par canal
      good_samp_first_pos_per_ch          : unsigned(7 downto 0);    -- position du premier bon echantillon 
      good_samp_last_pos_per_ch           : unsigned(7 downto 0);    -- position du dernier bon echantillon 
      xsize_div_tapnum                    : unsigned(7 downto 0);
      
      spare1                              : std_logic_vector(7 downto 0);
      spare2                              : std_logic_vector(1 downto 0);
      
      -- les valeurs Vdac
      vdac_value                          : fleg_vdac_value_type;     -- calculé dans le MB pour dac(1) à dac(8)
      
      -- adc clk_phase                    
      adc_clk_source_phase                : unsigned(31 downto 0);     -- dit de combien déphaser l'horloge des ADCs 
      adc_clk_pipe_sel                    : unsigned(7 downto 0);
      
      -- reorder_column                   
      reorder_column                      : std_logic;
      
      -- electrical analog chain correction   
      elcorr_enabled                      : std_logic; 
      
      -- pixel data ctrl
      elcorr_spare1                       : std_logic;              -- permet de forcer la valeur des pixels (données des ADCs) à la valeur du registre "fpa_faked_pixel_value"
      elcorr_spare2                       : unsigned(14 downto 0);  -- la valeur des pixels est remplacée par celle contenue dans ce registre lorsque elec_ofs_pixel_faked_value_forced = '1'
      
      -- refrence signal 
      elcorr_ref_cfg                      : elcorr_ref_cfg_array_type;                                                                                                             
      elcorr_ref_dac_id                   : unsigned(3 downto 0);  -- l'id du dac qui doit etre programmé avec les tensions de references pour la correction de gain et offset 
      
      -- multiplier control 
      elcorr_atemp_gain                   : signed(17 downto 0);
      
      -- adder control
      elcorr_atemp_ofs                    : signed(17 downto 0);
      
      -- embedded switches control
      elcorr_ref0_op_sel                  : std_logic_vector(1 downto 0);
      elcorr_ref1_op_sel                  : std_logic_vector(1 downto 0);
      elcorr_mult_op_sel                  : std_logic_vector(1 downto 0);
      elcorr_div_op_sel                   : std_logic_vector(1 downto 0);
      elcorr_add_op_sel                   : std_logic_vector(1 downto 0);   
      
      -- spare3
      elcorr_spare3                       : std_logic;          
      
      -- gestion de la saturation basse et haute à la sortie du module fpa
      sat_ctrl_en                         : std_logic;
      
      -- pour placer le superhawk en mode output constant
      roic_cst_output_mode                : std_logic;
      
      -- additional exposure time offset from driver C
      additional_fpa_int_time_offset      : signed(31 downto 0);
      
      -- cropping
      aoi_data                            : line_area_cfg_type;
      aoi_flag1                           : line_area_cfg_type;
      aoi_flag2                           : line_area_cfg_type;
	  
	  -- fastrd2
	  raw_area                            : area_cfg_type; -- zone brute
	  user_area                           : area_cfg_type; -- zone AOI demandée par l'usager
      clk_area_a                          : area_cfg_type; -- zone d'horloge 
      clk_area_b                          : area_cfg_type; -- zone d'horloge
	  roic_rst_time_mclk                  : unsigned(9 downto 0);  -- duree du reset du puits du superhawk en mclk
	  sideband_cancel_en                  : std_logic;
	  spare4                              : unsigned(3 downto 0);

      cfg_num                             : unsigned(7 downto 0);
	  
   end record; 
   
   ----------------------------------
   -- Type hder_param
   ----------------------------------
   type hder_param_type is
   record
      exp_time            : unsigned(31 downto 0);         -- temps d'integration en coups de 100 MHz
      frame_id            : unsigned(31 downto 0);
      exp_index           : unsigned(7 downto 0);
      sensor_temp_raw     : std_logic_vector(15 downto 0);
      rdy                 : std_logic;                     -- pulse signifiant que les parametres du header sont prêts
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
