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
   constant DEFINE_FPA_ROIC                       : std_logic_vector(7 downto 0) := FPA_ROIC_SCORPIO_MW;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                     : std_logic_vector(1 downto 0) := OUTPUT_ANALOG; 
   constant DEFINE_FPA_INPUT                      : std_logic_vector(7 downto 0) := LVCMOS33;            -- le scorpioMW sera contrôlé à 3.3V en vue de reduire de 56% la puissance nuisible de l'horloge
   constant DEFINE_FPA_VIDEO_DATA_INVERTED        : std_logic := '1';      -- les données du scorpioMW sont en video inverse
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA      : natural   := 25;       -- consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                 : natural   := 4;                                                                                     
   constant DEFINE_FLEX_VOLTAGEP_mV               : natural   := 8_000;    -- ENO 03 juin 2016: le flex de ce détecteur doit être alimenté à 8000 mV 
   constant DEFINE_FPA_TEMP_CH_GAIN               : real      := 1.0;      -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l,ampli buffer et des resistances entre les deux 
   constant DEFINE_FPA_PIX_PER_MCLK_PER_TAP       : natural   := 1;        -- 1 pixels par coup d'horloge pour le scorpioMW
   --constant DEFINE_FPA_BITSTREAM_LENGTH           : natural   := 58;     -- nombre de bits contenu  dans le bitstream de configuration serielle
   constant DEFINE_FPA_PROG_INT_TIME              : natural   := 1000 + 3076;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images post configuration du detecteur 
   constant DEFINE_FPA_XTRA_TRIG_INT_TIME         : natural   := 1000 + 3076;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images xtra trig
   constant DEFINE_FPA_SYNC_FLAG_VALID_ON_FE      : boolean   := false;    -- utilisé dans le module afpa_real_mode_dval_gen pour savoir si le sync_flag valid sur RE ou FE. False = valid sur RE.
   constant DEFINE_FPA_INIT_CFG_NEEDED            : std_logic := '1';
   constant DEFINE_GENERATE_VPROCESSING_CHAIN     : std_logic := '1';      -- pour le scorpiomwA, on  peut utiliser la chaine Vprocessing. 
   constant DEFINE_FPA_LINE_SYNC_MODE             : boolean   := false;    -- utilisé dans le module afpa_real_data_gen pour signaler à TRUE qu'il faille se synchroniser sur chaque ligne et à false pour signaler qu'une synchro en debut de trame est suffisante ou s 
   
   constant DEFINE_FPA_MCLK_RATE_KHZ              : integer   := 18_000;       -- 10_000 => MCLK = 10M, 15_000 => MCLK = 15M, 18_000 => MCLK = 18M, 
   
   constant DEFINE_FPA_INT_TIME_OFFSET_nS         : natural   := integer(real(3076)*real(1_000_000)/real(DEFINE_FPA_MCLK_RATE_KHZ));     --  3076 MCLK en ns et en fonction de la frequence d'horloge detecteur
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP     : integer   := 3;           -- pour le scorpioMW, on doit laisser 3 images dès qu'on reprogramme le détecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP            : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;
   constant DEFINE_XSIZE_MAX                      : integer   := 640;         -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                      : integer   := 512;         -- dimension en Y maximale  
   --constant DEFINE_GAIN0                          : std_logic := '0';
   --constant DEFINE_GAIN1                          : std_logic := '1';    
   constant DEFINE_ITR_MODE                       : std_logic := '0';
   constant DEFINE_IWR_MODE                       : std_logic := '1';
   constant DEFINE_FPA_INT_FBK_AVAILABLE          : std_logic := '0';
   constant DEFINE_FPA_POWER_ON_WAIT_US           : integer   := 100_000;    -- en usec, duree d'attente après allumage  pour declarer le FPA rdy. Faible chiffre car comptabilisé dans 
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_US        : integer   := 500_000;    -- le trig de lecture de la temperature a une periode de 0.5sec
   constant DEFINE_FPA_TEMP_RAW_MIN               : integer   := 31466;      -- Minimum ADC value for scorpioMW power-on : 983.3 mV de 2N2222 (soit 100K)  
   constant DEFINE_FPA_TEMP_RAW_MAX               : integer   := 33248;      -- Maximum ADC value for scorpioMW power-on : (to protect against ultra low temp). 1.039V 
   
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer   := 100_000;    --  horloge de 100M en KHz
   
   
   -- quelques caractéristiques de la carte ADC requise
   --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   -- ATTENTION : les 3 lignes suivantes à changer avec MCLK
   --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   constant DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ  : integer   := 18_000;     -- 40_000 => MCLK = 10M, 30_000 => MCLK = 15M, 36_000 => MCLK = 18M,  
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ          : integer   := 18_000;     -- 40_000 => MCLK = 10M, 30_000 => MCLK = 15M, 36_000 => MCLK = 18M, 
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : integer   := 72_000;     --  ENO 02 mai 2017 doit valoir au moins 4xMCLK pour éviter des problèmes dans LL8_ext_to_spi_tx
   
   
   
   
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ : integer   := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ;     -- c'est l'horloge à partir de laquelle est produite celle du détecteur. On a le choix entre 100MHz et 80MHz.Il faut que ce soit rigoureusement la m^me source que les ADC. Ainsi le dehphasage entre le FPA_MASTER_CLK et les clocks des quads sera toujours le même. 
   
   -- limites imposées aux tensions VDAC provenant de celles de FP_VCC1 à FP_VCC8 du Fleg 
   -- provient du script F:\Bibliotheque\Electronique\PCB\EFP-00266-001 (Generic Flex Board TEL-2000)\Documentation\calcul_LT3042.m
   -- ATTENTION il faut avoir completer la correspondance entre VCC et  les tensions du détecteur avant que le script ne donne des resultats valides
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
   ( 2772,  3645),     -- limites du DAC1 pour le scorpioMW     VDDA
   ( 2772,  6264),     -- limites du DAC2 pour le scorpioMW     VDDO
   (    0, 15868),     -- limites du DAC3 pour le scorpioMW
   ( 9116,  9792),     -- limites du DAC4 pour le scorpioMW     VDD
   ( 7765,  9116),     -- limites du DAC5 pour le scorpioMW     VR
   (    0,  3373),     -- limites du DAC6 pour le scorpioMW     GPOL
   (    0, 16210),     -- limites du DAC7 pour le scorpioMW     offset1
   ( 1899, 15868));    -- limites du DAC8 pour le scorpioMW     offset2
   
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
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR    : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_MCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     --
   constant DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR    : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ);
   constant DEFINE_ADC_QUAD_CLK_FACTOR            : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_MCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_PCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_PCLK_RATE_KHZ);
   --constant DEFINE_FPA_MCLK_RATE_FACTOR_100M      : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);    -- pour la conversion du temps d'integration en coups de 100MHz 
   constant DEFINE_FPA_INT_TIME_OFFSET_FACTOR     : integer := integer((real(DEFINE_FPA_INT_TIME_OFFSET_nS)*real(DEFINE_FPA_MCLK_RATE_KHZ))/1_000_000.0);
   constant DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH      : natural := integer(DEFINE_ADC_QUAD_CLK_RATE_KHZ/(DEFINE_FPA_PIX_PER_MCLK_PER_TAP*DEFINE_FPA_MCLK_RATE_KHZ));
   constant XSIZE_MAX                             : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                             : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX   
   constant DEFINE_FPA_MCLK_RATE_FACTOR_100M_X_2P15 : integer := integer((DEFINE_FPA_100M_CLK_RATE_KHZ*(2**15))/DEFINE_FPA_MCLK_RATE_KHZ);    -- pour la conversion du temps d'integration en coups de 100MHz 
   constant ADC_SERDES_CLK_1X_PERIOD_NS           : real    := 1_000_000.0/real(DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   ---------------------------------------------------------------------------------								
   -- Configuration
   ---------------------------------------------------------------------------------  
   -- misc                    
   type misc_cfg_type is
   record
      tir                        : unsigned(7 downto 0);
      xsize_div_tapnum           : unsigned(7 downto 0);
   end record;
   
   type quad_clk_phase_type is array (1 to 2) of unsigned(4 downto 0);
   
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
   
   type fpa_intf_cfg_type is
   record     
      -- cette partie provient du contrôleur du temps d'integration
      int_time                       : unsigned(31 downto 0);          -- temps d'integration en coups de MCLK. 
      int_indx                       : std_logic_vector(7 downto 0);   -- index du  temps d'integration
      int_signal_high_time           : unsigned(31 downto 0);          -- dureen en MCLK pendant laquelle lever le signal d'integration pour avoir int_time. depend des offsets de temps d'intégration   
      
      -- cette partie provient du microBlaze
      -- common
      comn                           : fpa_comn_cfg_type;        -- partie commune (utilisée par les modules communs)
      
       -- diag window
      diag                           : window_cfg_type; 
      
      -- window
      xstart                         : unsigned(10 downto 0); 
      ystart                         : unsigned(10 downto 0);
      xsize                          : unsigned(10 downto 0);
      ysize                          : unsigned(10 downto 0);      
      windcfg_part1                  : unsigned(8 downto 0);     -- serdat(33 downto 25)
      windcfg_part2                  : unsigned(8 downto 0);     -- serdat(24 downto 16)
      windcfg_part3                  : unsigned(7 downto 0);     -- serdat(15 downto 8)
      windcfg_part4                  : unsigned(7 downto 0);     -- serdat(7 downto 0)  
      uprow_upcol                    : std_logic;
      sizea_sizeb                    : std_logic;
      
      -- readout mode
      itr                            : std_logic;
      
      -- gain
      gain                           : std_logic;   
      
      -- gpol_code
      gpol_code                      : std_logic_vector(13 downto 0);      
      
      -- delai 
      real_mode_active_pixel_dly     : unsigned(7 downto 0);
      
      -- chn diversity
      adc_quad2_en                   : std_logic; -- à '1' si les données du quad2 doivent êre prises en compte par la chaine
      chn_diversity_en               : std_logic; -- dit quoi faire avec les données du quad2. '1' si ces données sont des repliques du quad1 => chn diversity. '0' si ces données doient être considérées comme des des données de taps 5, 6, 7, 8 d'un détrecteur 8 taps.
      
      -- pour les referentiels de trame et de lignes
      readout_pclk_cnt_max          : unsigned(16 downto 0);    --  pour scorpioMW: readout_pclk_cnt_max = taille en pclk de l'image incluant les pauses, les lignes non valides etc.. = (XSIZE/TAP_NUM + LOVH)* (YSIZE + FOVH) + 1  (un dernier PCLK pur finir)
      line_period_pclk              : unsigned(7 downto 0);     --  pour scorpioMW: nombre de pclk =  XSIZE/TAP_NUM + LOVH)
      
      -- ligne active = ligne excluant les portions/pixels non valides     
      active_line_start_num          : unsigned(3 downto 0);    --  pour scorpioMW: le numero de la premiere ligne active. Il vaut 1
      active_line_end_num            : unsigned(9 downto 0);    --  pour scorpioMW: le numero de la derniere ligne active. Il vaut Ysize
      
      -- nombre d'échantillons dans un pixel
      pix_samp_num_per_ch            : unsigned(7 downto 0);     --  nombre d'echantillons constituant un pixel =  ADC_SAMP_RATE/PIX_RATE_PER_TAP
      
      -- delimiteurs de trames et de lignes
      sof_posf_pclk                  : unsigned(8 downto 0);     --  pour scorpioMW: 
      eof_posf_pclk                  : unsigned(16 downto 0);    --  pour scorpioMW:
      sol_posl_pclk                  : unsigned(7 downto 0);     --  pour scorpioMW:
      eol_posl_pclk                  : unsigned(7 downto 0);     --  pour scorpioMW:
      eol_posl_pclk_p1               : unsigned(7 downto 0);     --  pour scorpioMW: eol_posl_pclk + 1
      
      -- calculs pour diversité des canaux
      hgood_samp_sum_num             : unsigned(3 downto 0);    --  nombre d'échantillons horizontaux par pixel et par canal 
      hgood_samp_mean_numerator      : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      vgood_samp_sum_num             : unsigned(3 downto 0);    --  nombre d'échantillons verticaux par pixel (>=2 => diversité des canaux active sinon vaut 1)
      vgood_samp_mean_numerator      : unsigned(22 downto 0);   --  ne pas changer la taille de ce registre 
      
      -- choix des échantillons par canal
      good_samp_first_pos_per_ch     : unsigned(7 downto 0);    -- position du premier bon echantillon 
      good_samp_last_pos_per_ch      : unsigned(7 downto 0);    -- position du dernier bon echantillon 
      xsize_div_tapnum               : unsigned(7 downto 0);      
      
      -- les valeurs Vdac
      vdac_value                     : fleg_vdac_value_type;     -- calculé dans le MB pour dac(1) à dac(8)  -- dac6 -> VOS pour le skimming
      
      -- adc clk_phase
      adc_clk_phase                  : quad_clk_phase_type;     -- dit en coup de 80MHz, de combien déphaser l'horloge des ADCs
      
      -- reorder column
      reorder_column                 : std_logic;               -- utilisé principalemet par les Sofradir pour contrer l'inversion des columns
      
   end record;    
   
   ---- Configuration par defaut
--   constant FPA_INTF_CFG_DEFAULT : fpa_intf_cfg_type := (
--   to_unsigned(100, 32),      --int_time                       
--   (others => '0'),           --int_indx                       
--   to_unsigned(3176, 32),     --int_signal_high_time           
--   --comn                           
--   ('0', x"D2", '0', '0', '0', x"02", to_unsigned(10000000, 32), to_unsigned(8000000, 32), to_unsigned(8000000, 32), to_unsigned(8000000, 32),'0'),
--   to_unsigned(0, 11),        --xstart                         
--   to_unsigned(0, 11),        --ystart                         
--   to_unsigned(640, 11),      --xsize                          
--   to_unsigned(512, 11),      --ysize
--   
--   to_unsigned(0, 9),         --windcfg_part1                         
--   to_unsigned(511, 9),       --windcfg_part2                         
--   to_unsigned(0, 8),         --windcfg_part3                          
--   to_unsigned(159, 8),       --windcfg_part4
--   
--   '1',                       --uprow_upcol                         
--   '1',                       --sizea_sizeb 
--   
--   '1',                       --itr
--   
--   '0',                       --gain                           
--   
--   std_logic_vector(to_unsigned(671, 14)),      --det_code
--   to_unsigned(0, 8),         --real_mode_active_pixel_dly   
--   '1',                       --adc_quad2_en                 
--   '1',                       --chn_diversity_en             
--   to_unsigned(82081, 17),    --readout_pclk_cnt_max         
--   to_unsigned(160, 8),       --line_period_pclk             
--   to_unsigned(1, 4),         --active_line_start_num        
--   to_unsigned(512, 10),       --active_line_end_num
--   to_unsigned(DEFINE_ADC_QUAD_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ, 8),         --pix_samp_num_per_ch          
--   to_unsigned(1, 9),         --sof_posf_pclk                
--   to_unsigned(81920, 17),    --eof_posf_pclk                
--   to_unsigned(1, 8),         --sol_posl_pclk                
--   to_unsigned(160, 8),       --eol_posl_pclk                
--   to_unsigned(161, 8),       --eol_posl_pclk_p1             
--   to_unsigned(1, 4),         --hgood_samp_sum_num           
--   to_unsigned(2097152, 23),  --hgood_samp_mean_numerator    
--   to_unsigned(2, 4),         --vgood_samp_sum_num           
--   to_unsigned(1048576, 23),  --vgood_samp_mean_numerator    
--   to_unsigned(DEFINE_ADC_QUAD_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ, 8),         --good_samp_first_pos_per_ch   
--   to_unsigned(DEFINE_ADC_QUAD_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ, 8),         --good_samp_last_pos_per_ch    
--   to_unsigned(160, 8),       --xsize_div_tapnum             
--   (to_unsigned(100, 14), to_unsigned(100, 14), to_unsigned(100, 14), to_unsigned(100, 14), to_unsigned(100, 14), to_unsigned(100, 14), to_unsigned(0, 14), to_unsigned(100, 14)),           
--   (to_unsigned(1, 5),to_unsigned(1, 5)),
--   '0'
--   );
--   
   
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
   -- Type readout_info
   ----------------------------------------------
   type readout_info_type is
   record
      sof        : std_logic;        
      eof        : std_logic;
      sol        : std_logic;
      eol        : std_logic;
      fval       : std_logic;                     
      lval       : std_logic;
      dval       : std_logic;
      read_end   : std_logic;  -- pulse  en dehors de fval mais qui signifie que le readout est terminé
      samp_pulse : std_logic;  -- sampling pluse de frequence valant celle des adc
   end record;
   
   ----------------------------------------------
   -- quues fontions                                    
   ----------------------------------------------
   
end FPA_define;

package body FPA_define is
   
   
   
end package body FPA_define; 
