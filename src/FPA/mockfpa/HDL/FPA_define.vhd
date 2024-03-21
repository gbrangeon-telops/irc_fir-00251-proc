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
use work.tel2000.all;

package FPA_define is    
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   -- consignes pour vérification avec infos en provenance du vhd, flex, et adc
   constant DEFINE_FPA_ROIC                       : std_logic_vector(7 downto 0) := FPA_ROIC_ISC0804;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                     : std_logic_vector(1 downto 0) := OUTPUT_ANALOG; 
   constant DEFINE_FPA_INPUT                      : std_logic_vector(7 downto 0) := LVCMOS33;            -- le isc0804A sera contrôlé à 3.3V en vue de reduire de 56% la puissance nuisible de l'horloge
   constant DEFINE_FPA_VIDEO_DATA_INVERTED        : std_logic := '0';      -- les données du isc0804A ne sont pas en video inverse
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA      : natural   := 100;      -- consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                 : natural   := 16;                                                                                     
   constant DEFINE_FLEX_VOLTAGEP_mV               : natural   := 8_000;    -- le flex de ce détecteur doit être alimenté à 8000 mV 
   constant DEFINE_FPA_TEMP_CH_GAIN               : real      := 1.0;      -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l,ampli buffer et des resistances entre les deux 
   constant DEFINE_FPA_PIX_PER_MCLK_PER_TAP       : natural   := 2;        -- 1 pixels par coup d'horloge pour le isc0804A
   constant DEFINE_FPA_BITSTREAM_LENGTH           : natural   := 62;       -- nombre de bits contenu  dans le bitstream de configuration serielle
   constant DEFINE_FPA_PROG_END_PAUSE_MCLK        : natural   := 20;       -- en fin d'envoi  d'un bitstream, delai minimum à observer avant l'envoi d'un autre. Bref le delaiminimal où SPI_CSN doit remonter à '1'  
   constant DEFINE_FPA_PROG_INT_TIME              : natural   := 100;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images post configuration du detecteur 
   constant DEFINE_FPA_XTRA_TRIG_INT_TIME         : natural   := 100;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images xtra trig
   constant DEFINE_FPA_SYNC_FLAG_VALID_ON_FE      : boolean   := false;    -- utilisé dans le module afpa_real_data_gen pour savoir si le sync_flag valid sur RE ou FE. False = valid sur RE.
   constant DEFINE_FPA_LINE_SYNC_MODE             : boolean   := true;     -- utilisé dans le module afpa_real_data_gen pour signaler à TRUE qu'il faille se synchroniser sur chaque ligne et à false pour signaler qu'une synchro en debut de trame est suffisante ou s
   constant DEFINE_FPA_INIT_CFG_NEEDED            : std_logic := '0';
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP     : integer   := 3;       
   constant DEFINE_GENERATE_HPROC_CHAIN           : std_logic := '0';      -- on peut ne fait plus de diversité temporelle doncn ne plus utiliser la chaine Hprocessing.  
   constant DEFINE_GENERATE_VPROC_CHAIN           : std_logic := '0';      -- on peut ne fait plus de diversité de canaux donc ne plus utiliser la chaine Vprocessing.
   constant DEFINE_GENERATE_ELCORR_CHAIN          : std_logic := '1';
   constant DEFINE_GENERATE_ELCORR_GAIN           : std_logic := '1';      -- on ne fait pas que la correctioon de l'offset mais aussi du gain
   -- constant DEFINE_GENERATE_QUAD2_PROCESSING_CHAIN: std_logic := '0';      -- n'a aucune importance pour un 16 taps
   constant DEFINE_ELCORR_REF_DAC_SETUP_US        : integer   := 500_000;  -- en usec, le delaui de stabilisation (analog setup)
   
   constant DEFINE_FPA_MCLK_RATE_KHZ              : real      := 11_111.0; -- 12_125.0; --11_880.0; -- 11_111.0;    
   
   -- integration, offset d'integration,  feedback
   constant DEFINE_GENERATE_INT_FDBK_MODULE       : std_logic := '0';      -- à '0' pour dire que le signal fpa_int_fdbk = fpa_int. à  '1' sinon. Dans ce cas, le fpa_int_fdbk est genere et on doit spécifier son delai. Sa duree est d'office FPA_INT_TIME. Faire attention au calcul des delais dans le fpa_intf.c pour le mode MODE_INT_END_TO_TRIG_START
   constant DEFINE_FPA_INT_TIME_OFFSET_nS         : integer   := 0;        -- provient du MB desormais. integer(real(3)*real(1_000_000)/real(DEFINE_FPA_MCLK_RATE_KHZ));     --  3 MCLK en ns et en fonction de la frequence d'horloge detecteur
   constant DEFINE_FPA_INT_FDBK_DLY               : natural   := DEFINE_FPA_INT_TIME_OFFSET_nS;        -- pour isc0209A, le fedback commence en même temps que la consigne (fpa_int) mais les deux signaux n'ont pas la même durée (DEFINE_FPA_INT_TIME_OFFSET_nS les differencie)
   --
   constant DEFINE_FPA_FAST_MCLK_RATE_KHZ         : real      := 2.0*DEFINE_FPA_MCLK_RATE_KHZ;   -- 3.0*DEFINE_FPA_MCLK_RATE_KHZ;   -- 
   --
   constant DEFINE_FPA_FAST_LSYDEL_CLK_RATE_KHZ   : real      := 2.666*DEFINE_FPA_MCLK_RATE_KHZ;
   
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP            : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;           -- pour le isc0804A, on doit laisser 3 images dès qu'on reprogramme le détecteur
   constant DEFINE_XSIZE_MAX                      : integer   := 1920;        -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                      : integer   := 1536;        -- dimension en Y maximale  
   constant DEFINE_GAIN0                          : std_logic := '0';
   constant DEFINE_GAIN1                          : std_logic := '1';    
   constant DEFINE_ITR_MODE                       : std_logic := '0'; 
   constant DEFINE_IWR_MODE                       : std_logic := '1';
   constant DEFINE_FPA_INT_FBK_AVAILABLE          : std_logic := '0';
   constant DEFINE_FPA_POWER_ON_WAIT_US           : integer   := 10_000;     -- en usec, duree d'attente après allumage  pour declarer le FPA rdy. Faible chiffre car comptabilisé dans 
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_US        : integer   := 500_000;    -- le trig de lecture de la temperature a une periode de 0.5sec
   constant DEFINE_FPA_TEMP_RAW_MIN               : integer   := 30720;      -- minimum ADC value for power-on : 0.960V de 2N2222 (soit 120K)
   constant DEFINE_FPA_TEMP_RAW_MAX               : integer   := 35200;      -- maximum ADC value for power-on : 1.100V de 2N2222 (soit 40K) to protect against ultra low temp
   
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer   := 100_000;    --  horloge de 100M en KHz
   
   constant DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ  : real      := 2.0*DEFINE_FPA_MCLK_RATE_KHZ;     -- toujours prendre ADC_CLK_RATE = PCLK_RATE en vue de prendre un échantillon par pixel.
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ          : real      := 2.0*DEFINE_FPA_MCLK_RATE_KHZ;     -- toujours prendre ADC_CLK_RATE = PCLK_RATE en vue de prendre un échantillon par pixel.
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : real      := 8.0*DEFINE_FPA_MCLK_RATE_KHZ;     -- 12.0*DEFINE_FPA_MCLK_RATE_KHZ;             --   
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ : real      := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ;       -- c'est l'horloge à partir de laquelle est produite celle du détecteur. Il faut que ce soit rigoureusement la m^me source que les ADC. Ainsi le dehphasage entre le FPA_MASTER_CLK et les clocks des quads sera toujours le même. 
   
   -- limites imposées aux tensions VDAC provenant de celles de FP_VCC1 à FP_VCC8 du Fleg 
   -- provient du script F:\Bibliotheque\Electronique\PCB\EFP-00266-001 (Generic Flex Board TEL-2000)\Documentation\calcul_LT3042.m
   -- ATTENTION il faut avoir completé la correspondance entre VCC et  les tensions du détecteur avant que le script ne donne des resultats valides
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
   ( 4300,  4736),     -- limites du DAC1 pour le isc0804A     VPOS_OUT
   ( 4300,  4736),     -- limites du DAC2 pour le isc0804A     VPOS
   (    0, 13685),     -- limites du DAC3 pour le isc0804A     non utilisé
   (    0, 16383),     -- limites du DAC4 pour le isc0804A     non utilisé
   ( 1009,  8400),     -- limites du DAC5 pour le isc0804A     VOUTREF
   (    0, 16383),     -- limites du DAC6 pour le isc0804A     non utilisé
   (	  0, 16210),     -- limites du DAC7 pour le isc0804A     inref
   ( 4081,  4954));    -- limites du DAC8 pour le isc0804A     VPD
   
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
   --- used in mockfpa_mblaze_intf
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
      ---
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR  : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR    : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_MCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     
   constant DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR    : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/(real(DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ)));
   constant DEFINE_ADC_QUAD_CLK_FACTOR            : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/(real(DEFINE_ADC_QUAD_CLK_RATE_KHZ)));
   constant DEFINE_FPA_MCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_PCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_PCLK_RATE_KHZ);
   constant DEFINE_FPA_FAST_MCLK_RATE_FACTOR      : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_FAST_MCLK_RATE_KHZ);
   constant DEFINE_FPA_FAST_PCLK_RATE_FACTOR      : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_FAST_PCLK_RATE_KHZ);
   constant DEFINE_FPA_FAST_LSYDEL_CLK_RATE_FACTOR: integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_FAST_LSYDEL_CLK_RATE_KHZ);
   constant DEFINE_FPA_INT_TIME_OFFSET_FACTOR     : integer := integer((real(DEFINE_FPA_INT_TIME_OFFSET_nS)*real(DEFINE_FPA_MCLK_RATE_KHZ))/1_000_000.0);
   constant DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH      : natural := integer(real(DEFINE_ADC_QUAD_CLK_RATE_KHZ)/(real(DEFINE_FPA_PIX_PER_MCLK_PER_TAP)*DEFINE_FPA_MCLK_RATE_KHZ));
   constant XSIZE_MAX                             : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                             : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX   
   constant DEFINE_FPA_MCLK_RATE_FACTOR_100M_X_2P15 : integer := integer(real(DEFINE_FPA_100M_CLK_RATE_KHZ*(2**15))/real(DEFINE_FPA_MCLK_RATE_KHZ));    -- pour la conversion du temps d'integration en coups de 100MHz 
   constant ADC_SERDES_CLK_1X_PERIOD_NS           : real    := 1_000_000.0/real(DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_PEAK_THROUGHPUT_MPixS      : integer := integer(ceil(real(DEFINE_FPA_PCLK_RATE_KHZ) * real(DEFINE_FPA_TAP_NUMBER))/1000.0);
   constant DEFINE_FPA_PROG_END_PAUSE_FACTOR      : integer := DEFINE_FPA_PROG_END_PAUSE_MCLK * DEFINE_FPA_MCLK_RATE_FACTOR;
   constant DEFINE_FPA_PROG_START_PAUSE_FACTOR    : integer := DEFINE_FPA_PROG_END_PAUSE_FACTOR;
   constant DEFINE_ELCORR_REF_DAC_SETUP_FACTOR    : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ*real(DEFINE_ELCORR_REF_DAC_SETUP_US/1000));
   
   ---------------------------------------------------------------------------------								
   -- Type
   --------------------------------------------------------------------------------- 
   --type quad_clk_phase_type is array (1 to 4) of unsigned(4 downto 0);
   
   
   type fpa_intf_cfg_type is
   record     
      int_time                            : unsigned(31 downto 0);          -- temps d'integration en coups de MCLK. 
      int_indx                            : std_logic_vector(7 downto 0);   -- index du  temps d'integration
      flow_ctler_dval                     : std_logic;      
	  flow_ctler_stalled_cnt              : unsigned(7 downto 0);    
	  flow_ctler_valid_cnt                : unsigned(7 downto 0);    
	  flow_ctler_width                    : unsigned(13 downto 0);
	  flow_ctler_lval_pause_cnt           : unsigned(7 downto 0);
	  flow_ctler_fval_pause_cnt           : unsigned(7 downto 0);
	  fpa_height                          : unsigned(11 downto 0);
      fpa_width                           : unsigned(11 downto 0);
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
   -- Functions
   ----------------------------------------------
   function fpa_intf_cfg_to_slv_array(FPA_INTF_CFG : fpa_intf_cfg_type) return fpa_intf_cfg_slv_array_type;
   
end FPA_define;

package body FPA_define is  
   
   ---------------------------------------------------------------------------------------------------------------
   -- Fonction utilisée par le module fpa_status_gen pour transférer la FPA_INTF_CFG par AXIL vers le microBlaze
   ---------------------------------------------------------------------------------------------------------------
   function fpa_intf_cfg_to_slv_array(FPA_INTF_CFG : fpa_intf_cfg_type) return fpa_intf_cfg_slv_array_type is
      variable a : fpa_intf_cfg_slv_array_type;
   begin
      a := (
         std_logic_vector(resize(FPA_INTF_CFG.int_time, a(0)'length)),
         others => (others => '0')     -- champs inutilisés
      );
      return a;
   end fpa_intf_cfg_to_slv_array;
   
end package body FPA_define; 
