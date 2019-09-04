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
   constant DEFINE_FPA_ROIC                       : std_logic_vector(7 downto 0) := FPA_ROIC_HAWK;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                     : std_logic_vector(1 downto 0) := OUTPUT_ANALOG; 
   constant DEFINE_FPA_INPUT                      : std_logic_vector(7 downto 0) := LVCMOS33;       -- le hawk sera contrôlé à 3.3V en vue de reduire de 56% la puissance nuisible de l'horloge
   constant DEFINE_FPA_VIDEO_DATA_INVERTED        : std_logic := '1';      -- les données du hawk sont en video inverse     
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA      : natural   := 100;      -- consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                 : natural   := 4;                                                                                     
   constant DEFINE_FLEX_VOLTAGEP_mV               : natural   := 8000;     -- le flex de ce détecteur doit être alimenté à 8V 
   constant DEFINE_FPA_TEMP_CH_GAIN               : real      := 1.0;      -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l,ampli buffer et des resistances entre les deux 
   constant DEFINE_FPA_PIX_PER_MCLK_PER_TAP       : natural   := 1;        -- 1 pixels par coup d'horloge pour le hawk
   
   -- integration, offset d'integration,  feddeback
   constant DEFINE_GENERATE_INT_FDBK_MODULE       : std_logic := '0';      -- à '0' pour dire que le signal fpa_int_fdbk = fpa_int. à  '1' sinon. Dans ce cas, le fpa_int_fdbk est genere et on doit spécifier son delai. Sa duree est d'office FPA_INT_TIME. Faire attention au calcul des delais dans le fpa_intf.c pour le mode MODE_INT_END_TO_TRIG_START
   constant DEFINE_FPA_INT_FDBK_DLY               : natural   := 0;        -- pour isc0209A, le fedback commence en même temps que la consigne (fpa_int) mais les deux signaux n'ont pas la même durée (DEFINE_FPA_INT_TIME_OFFSET_nS les differencie)
   constant DEFINE_FPA_INT_TIME_OFFSET_nS         : natural   := 0;        -- int_time offset de 0 nsec 
   
   constant DEFINE_FPA_PROG_INT_TIME              : natural   := 2;        -- en coups d'horloge FPA, c'est le temps d'integration utilisé piour les images post configuration du detecteur 
   constant DEFINE_FPA_XTRA_TRIG_INT_TIME         : natural   := 2;        -- en coups d'horloge FPA, c'est le temps d'integration utilisé piour les images post configuration du detecteur 
   constant DEFINE_FPA_SYNC_FLAG_VALID_ON_FE      : boolean   := false;     -- utilisé dans le module afpa_real_mode_dval_gen pour savoir si le sync_flag valid sur RE ou FE. False = valid sur RE.
   constant DEFINE_FPA_INIT_CFG_NEEDED            : std_logic := '0';      -- pas besoin de config particulière au demarrage des Hawks
   constant DEFINE_GENERATE_HPROC_CHAIN           : std_logic := '0';      -- on peut ne fait plus de diversité temporelle doncn ne plus utiliser la chaine Hprocessing.  
   constant DEFINE_GENERATE_VPROC_CHAIN           : std_logic := '0';      -- on peut ne fait plus de diversité de canaux donc ne plus utiliser la chaine Vprocessing.
   constant DEFINE_GENERATE_QUAD2_CHAIN           : std_logic := '0';      -- à '1' permet de generer la chaine de traitement pour le quad 2. Ce qui est utile en diversité de canal
   constant DEFINE_FPA_LINE_SYNC_MODE             : boolean   := true;     -- utilisé dans le module afpa_real_data_gen pour signaler à TRUE qu'il faille se synchroniser sur chaque ligne et à false pour signaler qu'une synchro en debut de trame est suffisante ou s
   constant DEFINE_GENERATE_ELCORR_CHAIN          : std_logic := '0';      -- on ne fait aucune correction électronique
   constant DEFINE_GENERATE_ELCORR_GAIN           : std_logic := '0';      -- on ne fait aucune correction de gain
   
   -- quelques caractéristiques du FPA
   --constant DEFINE_FPA_INT_TIME_MIN_US            : integer   := 1; 
   constant DEFINE_FPA_MCLK_RATE_KHZ              : real      := 10_000.0;       -- pour le hawk, c'est fixé à 510 MHz. Donc non configurable. D'où sa présence dans le fpa_define. Pour d'autres détecteurs, il peut se retrouver dans le pilote en C
   
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP     : integer   := 3;            -- pour le Hawk, on doit laisser 3 images dès qu'on reprogramme le détecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP            : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;        -- not used
   constant DEFINE_XSIZE_MAX                      : integer   := 640;          -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                      : integer   := 512;          -- dimension en Y maximale  
   --constant DEFINE_GAIN0                          : std_logic := '0';
   --constant DEFINE_GAIN1                          : std_logic := '1';    
   constant DEFINE_ITR_MODE                       : std_logic := '0';
   --constant DEFINE_IWR_MODE                       : std_logic := '1';
   constant DEFINE_FPA_INT_FBK_AVAILABLE          : std_logic := '0';
   constant DEFINE_FPA_POWER_ON_WAIT_US           : integer   := 600_000;    -- en usec, duree d'attente après allumage  pour declarer le FPA rdy
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_US        : integer   := 500_000;    -- le trig de lecture de la temperature a une periode de 0.5sec
   constant DEFINE_FPA_TEMP_RAW_MIN               : integer   := 30720;      -- Minimum ADC value for Hawk power-on : 0.960V de 2N2222 (soit 120K)  
   constant DEFINE_FPA_TEMP_RAW_MAX               : integer   := 35200;      -- Maximum ADC value for Hawk power-on : (to protect against ultra low temp). 1.1V 
   
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer   := 100_000;    --  horloge de 100M en KHz
   constant DEFINE_FPA_80M_CLK_RATE_KHZ           : integer   := 80_000;     --  horloge de 80M en KHz
   
   -- quelques caractéristiques de la carte ADC requise
   constant DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ  : real      := 1.0*real(DEFINE_FPA_MCLK_RATE_KHZ);       -- ENO 01 Août 2017 : Sur demande FAU pour CE, on passe les ADC du Hawk à 10 MHz
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ          : real      := 1.0*real(DEFINE_FPA_MCLK_RATE_KHZ);       -- ENO 01 Août 2017 : Sur demande FAU pour CE, on passe les ADC du Hawk à 10 MHz
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : real      := 1.0*real(DEFINE_FPA_80M_CLK_RATE_KHZ);    -- c'est l'horloge à partir de laquelle est produite celle des quads. On a le choix entre 100MHz et 80MHz.
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ : real      := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ;     -- c'est l'horloge à partir de laquelle est produite celle du détecteur. On a le choix entre 100MHz et 80MHz.Il faut que ce soit rigoureusement la m^me source que les ADC. Ainsi le dehphasage entre le FPA_MASTER_CLK et les clocks des quads sera toujours le même. 
   
   -- limites imposées aux tensions VDAC deduites de celles de FP_VCC1 à FP_VCC8 du Fleg 
   -- provient du script F:\Bibliotheque\Electronique\PCB\EFP-00266-001 (Generic Flex Board TEL-2000)\Documentation\calcul_LT3042.m
   -- ATTENTION il faut avoir completer la correspondance entre VCC et  les tensions du détecteur avant que le script ne donne des resultats valides
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
   (10630, 15432),     -- limites du DAC1 pour le Hawk
   ( 1899, 15868),     -- limites du DAC2 pour le Hawk 
   (10630, 14558),     -- limites du DAC3 pour le Hawk
   (    0, 16210),     -- limites du DAC4 pour le Hawk
   (    0, 16210),     -- limites du DAC5 pour le Hawk
   (    0, 16210),     -- limites du DAC6 pour le Hawk
   (    0, 16210),     -- limites du DAC7 pour le Hawk
   ( 1026, 15868));    -- limites du DAC8 pour le Hawk 
   
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
   -- constant DEFINE_FPA_BITSTREAM_BYTE_NUM         : integer := integer(ceil(real(DEFINE_FPA_BITSTREAM_LENGTH)/8.0));
   constant DEFINE_FPA_PCLK_RATE_KHZ              : real    := real(DEFINE_FPA_PIX_PER_MCLK_PER_TAP)*DEFINE_FPA_MCLK_RATE_KHZ;
   constant DEFINE_FPA_POWER_WAIT_FACTOR          : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ*real(DEFINE_FPA_POWER_ON_WAIT_US/1000));
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_FACTOR    : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_TEMP_TRIG_PERIOD_US/1000);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR  : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR    : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_MCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     --
   constant DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR    : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/(real(DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ)));
   constant DEFINE_ADC_QUAD_CLK_FACTOR            : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/(real(DEFINE_ADC_QUAD_CLK_RATE_KHZ)));
   constant DEFINE_FPA_MCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_PCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_PCLK_RATE_KHZ);
   constant DEFINE_FPA_INT_TIME_OFFSET_FACTOR     : integer := integer((real(DEFINE_FPA_INT_TIME_OFFSET_nS)*real(DEFINE_FPA_MCLK_RATE_KHZ))/1_000_000.0);
   constant DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH      : natural := integer(real(DEFINE_ADC_QUAD_CLK_RATE_KHZ)/(real(DEFINE_FPA_PIX_PER_MCLK_PER_TAP)*DEFINE_FPA_MCLK_RATE_KHZ));
   constant XSIZE_MAX                             : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                             : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX   
   constant DEFINE_FPA_MCLK_RATE_FACTOR_100M_X_2P15 : integer := integer(real(DEFINE_FPA_100M_CLK_RATE_KHZ*(2**15))/real(DEFINE_FPA_MCLK_RATE_KHZ));    -- pour la conversion du temps d'integration en coups de 100MHz 
   constant ADC_SERDES_CLK_1X_PERIOD_NS           : real    := 1_000_000.0/real(DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_PEAK_THROUGHPUT_MPixS      : integer := integer(ceil(real(DEFINE_FPA_PCLK_RATE_KHZ) * real(DEFINE_FPA_TAP_NUMBER))/1000.0);
   -- constant DEFINE_FPA_PROG_END_PAUSE_FACTOR      : integer := DEFINE_FPA_PROG_END_PAUSE_MCLK * DEFINE_FPA_MCLK_RATE_FACTOR;
  
   
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
      ref_cont_meas_mode             : std_logic;
      start_dly_sampclk              : unsigned(7 downto 0);
      samp_num_per_ch                : unsigned(7 downto 0);
      samp_mean_numerator            : unsigned(22 downto 0);
      ref_value                      : unsigned(13 downto 0); -- dac word correspondant à la valeur de refrence voulue pour la caorrection des offsets
   end record;
   
   type elcorr_ref_cfg_array_type is array (0 to 1) of  elcorr_ref_cfg_type;
   
   
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
      gain                                : std_logic_vector(1 downto 0);
      invert                              : std_logic; 
      revert                              : std_logic;   
      cbit_en                             : std_logic;
      dig_code                            : unsigned(15 downto 0);
      jpos                                : unsigned(15 downto 0); 
      kpos                                : unsigned(15 downto 0);
      lpos                                : unsigned(15 downto 0);
      mpos                                : unsigned(15 downto 0);
      wdr_len                             : unsigned(15 downto 0);    
      full_window                         : std_logic;     -- '1' si fenetre pleine
      
      -- delai 
      real_mode_active_pixel_dly          : unsigned(7 downto 0);
      
      -- chn diversity
      adc_quad2_en                        : std_logic; -- à '1' si les données du quad2 doivent êre prises en compte par la chaine
      chn_diversity_en                    : std_logic; -- dit quoi faire avec les données du quad2. '1' si ces données sont des repliques du quad1 => chn diversity. '0' si ces données doient être considérées comme des des données de taps 5, 6, 7, 8 d'un détrecteur 8 taps.
      
      -- pour les referentiels de trame et de lignes
      readout_pclk_cnt_max                : unsigned(16 downto 0);    --  pour hawk: readout_pclk_cnt_max = taille en pclk de l'image incluant les pauses, les lignes non valides etc.. = (XSIZE/TAP_NUM + LOVH)* (YSIZE + FOVH) + 1  (un dernier PCLK pur finir)
      line_period_pclk                    : unsigned(7 downto 0);     --  pour hawk: nombre de pclk =  (XSIZE/TAP_NUM + LOVH)
      
      -- ligne active = ligne excluant les portions/pixels non valides     
      active_line_start_num               : unsigned(3 downto 0);     --  pour hawk: le numero de la premiere ligne active. Il vaut 1
      active_line_end_num                 : unsigned(10 downto 0);     --  pour hawk: le numero de la derniere ligne active. Il vaut Ysize
      
      -- nombre d'échantillons dans un pixel
      pix_samp_num_per_ch                 : unsigned(7 downto 0);     --  nombre d'echantillons constituant un pixel =  ADC_SAMP_RATE/PIX_RATE_PER_TAP
      
      -- delimiteurs de trames et de lignes
      sof_posf_pclk                       : unsigned(8 downto 0);     --  pour hawk: 
      eof_posf_pclk                       : unsigned(16 downto 0);    --  pour hawk:
      sol_posl_pclk                       : unsigned(7 downto 0);     --  pour hawk:
      eol_posl_pclk                       : unsigned(7 downto 0);     --  pour hawk:
      eol_posl_pclk_p1                    : unsigned(7 downto 0);     --  pour hawk: eol_posl_pclk + 1
      
      -- calculs pour diversité des canaux
      hgood_samp_sum_num                  : unsigned(3 downto 0);    --  nombre d'échantillons horizontaux par pixel et par canal 
      hgood_samp_mean_numerator           : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      vgood_samp_sum_num                  : unsigned(3 downto 0);    --  nombre d'échantillons verticaux par pixel (>=2 => diversité des canaux active sinon vaut 1)
      vgood_samp_mean_numerator           : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      -- choix des échantillons par canal
      good_samp_first_pos_per_ch          : unsigned(7 downto 0);    -- position du premier bon echantillon 
      good_samp_last_pos_per_ch           : unsigned(7 downto 0);    -- position du dernier bon echantillon 
      xsize_div_tapnum                    : unsigned(7 downto 0);      
      
      -- les valeurs Vdac
      vdac_value                          : fleg_vdac_value_type;     -- calculé dans le MB pour dac(1) à dac(8)
      
      -- adc clk_phase                    
      adc_clk_source_phase                : unsigned(31 downto 0);     -- dit de combien déphaser l'horloge des ADCs 
      adc_clk_pipe_sel                    : unsigned(7 downto 0);
      
      -- reorder_column                   
      reorder_column                      : std_logic;
      
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
      
      -- mode de calcul continuel du gain   (à toutes les x sec)
      elcorr_spare3                  : std_logic;          
      
      -- gestion de la saturation basse et haute à la sortie du module fpa
      sat_ctrl_en                    : std_logic;
      
      cfg_num                        : unsigned(7 downto 0);
      
   end record; 
   
   -- Configuration par defaut
   --constant FPA_INTF_CFG_DEFAULT : fpa_intf_cfg_type := (
   --   to_unsigned(100, 32),      --int_time                       
   --   (others => '0'),           --int_indx                       
   --   to_unsigned(100, 32),      --int_signal_high_time           
   --   --comn                           
   --   ('0', DEFINE_TELOPS_DIAG_DEGR, '0', '0', '0', MODE_INT_END_TO_TRIG_START, to_unsigned(1000000, 32), to_unsigned(800000, 32), to_unsigned(800000, 32), to_unsigned(800000, 32), '0'),
   --   to_unsigned(0, 11),        --xstart                         
   --   to_unsigned(0, 11),        --ystart                         
   --   to_unsigned(640, 11),      --xsize                          
   --   to_unsigned(512, 11),      --ysize                          
   --   (others => '1'),           --gain                           
   --   '0',                       --invert                         
   --   '0',                       --revert                         
   --   '1',                       --cbit_en                        
   --   x"0051",                   --dig_code                       
   --   to_unsigned(1185, 16),     --jpos                         
   --   to_unsigned(1184, 16),     --kpos                         
   --   to_unsigned(513, 16),      --lpos                         
   --   to_unsigned(512, 16),      --mpos                         
   --   to_unsigned(1344, 16),     --wdr_len                      
   --   '1',                       --full_window                  
   --   to_unsigned(6, 8),         --real_mode_active_pixel_dly   
   --   '1',                       --adc_quad2_en                 
   --   '1',                       --chn_diversity_en             
   --   to_unsigned(86187, 17),    --readout_pclk_cnt_max         
   --   to_unsigned(168, 8),       --line_period_pclk             
   --   to_unsigned(1, 4),         --active_line_start_num        
   --   to_unsigned(512, 11),      --active_line_end_num          
   --   to_unsigned(4, 8),         --pix_samp_num_per_ch          
   --   to_unsigned(8, 9),         --sof_posf_pclk                
   --   to_unsigned(86015, 17),    --eof_posf_pclk                
   --   to_unsigned(8, 8),         --sol_posl_pclk                
   --   to_unsigned(167, 8),       --eol_posl_pclk                
   --   to_unsigned(168, 8),       --eol_posl_pclk_p1             
   --   to_unsigned(2, 4),         --hgood_samp_sum_num           
   --   to_unsigned(1048576, 23),  --hgood_samp_mean_numerator    
   --   to_unsigned(2, 4),         --vgood_samp_sum_num           
   --   to_unsigned(1048576, 23),  --vgood_samp_mean_numerator    
   --   to_unsigned(3, 8),         --good_samp_first_pos_per_ch   
   --   to_unsigned(4, 8),         --good_samp_last_pos_per_ch    
   --   to_unsigned(160, 8),       --xsize_div_tapnum             
   --   (to_unsigned(14995, 14), to_unsigned(0, 14), to_unsigned(14122, 14), to_unsigned(0, 14), to_unsigned(0, 14), to_unsigned(0, 14), to_unsigned(0, 14), to_unsigned(1791, 14)),           
   --   to_unsigned(0, 4),          --adc_clk_phase
   --   '0'                         --reorder_column
   --   );                                               
   
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
