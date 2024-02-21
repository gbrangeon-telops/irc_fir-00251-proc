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
use work.fleg_brd_define.all;

package Proxy_define is

   --------------------------------------------------
   -- Définitions propres au calcium proxy
   --------------------------------------------------
   constant DEFINE_FPA_ROIC                           : std_logic_vector(7 downto 0) := FPA_ROIC_CALCIUM;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler un détecteur de ce type qque soit le cooler
   constant DEFINE_FPA_OUTPUT                         : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant DEFINE_FPA_INPUT                          : std_logic_vector(7 downto 0) := LVCMOS18;
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA          : natural   := 100;        -- doit être défini mais pas utilisé: source courant sur EFA-00331. consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                     : natural   := 8;          -- nécessaire pour ADC_BRD_INFO. À ENLEVER
   constant DEFINE_FLEX_VOLTAGEP_mV                   : natural   := 5500;       -- doit être défini mais pas utilisé: la tension intermédiaire vflex de ce détecteur est à 5.5V
   constant DEFINE_FPA_TEMP_CH_GAIN                   : real      := 1.0;        -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l'ampli buffer et des resistances entre les deux
   constant DEFINE_FPA_INIT_CFG_NEEDED                : std_logic := '0';        -- pas besoin de config particulière au demarrage
   constant DEFINE_FPA_PROG_SCLK_RATE_KHZ             : integer   := 1_000;      -- horloge SPI pour la programmation du FPA. Doit être 1 MHz (ou 10?)
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP         : integer   := 1;          -- on doit laisser 1 image dès qu'on reprogramme le détecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP                : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;
   constant DEFINE_FPA_POWER_ON_WAIT_MS               : integer   := 1_200;      -- en msec, duree d'attente après allumage pour declarer le FPA rdy. Le ramp-up du LT3042 est d'environ 1s
   constant DEFINE_FPA_TEMP_RAW_MIN                   : integer   := 24786;      -- Minimum ADC value for power-on : 0.775 V, soit 35°C
   constant DEFINE_FPA_TEMP_RAW_MAX                   : integer   := 26833;      -- Maximum ADC value for power-on : 0.838 V, soit -5°C
   constant PROG_FREE_RUNNING_TRIG                    : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ              : integer   := 100_000;    --  horloge de 100M en KHz
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ              : integer   := 40_000;     -- nécessaire pour ADC_BRD_INFO. À ENLEVER
   
   -- limites imposées aux tensions VDAC provenant de celles de FP_VCC1 à FP_VCC8 du Fleg 
   -- provient du script F:\Bibliotheque\Electronique\PCB\EFP-00266-001 (Generic Flex Board TEL-2000)\Documentation\calcul_LT3042.m
   -- ATTENTION il faut avoir completer la correspondance entre VCC et  les tensions du détecteur avant que le script ne donne des resultats valides
   -- Les marges de 100 counts représentent environ 30mV.
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
      ( 7765-100, 10130+100),     -- limites du DAC1 -> DETECTSUB 2.8V à 3.5V
      ( 5400-100,  7427+100),     -- limites du DAC2 -> CTIA_REF 2.1V à 2.7V
      (        0,  9454+100),     -- limites du DAC3 -> VTESTG 0V à 3.3V
      ( 3373-100,  5063+100),     -- limites du DAC4 -> CM 1.5V à 2V
      ( 3373-100,  5063+100),     -- limites du DAC5 -> VCMO 1.5V à 2V
      (        0,     16383),     -- limites du DAC6 -> not connected
      (        0,     16383),     -- limites du DAC7 -> not connected
      (        0,     16383)      -- limites du DAC8 -> not connected
   );
   
   --------------------------------------------
   --  modes diag
   --------------------------------------------
   -- D comme diag 
   constant TELOPS_DIAG_CNST               : std_logic_vector(7 downto 0):= x"D1";  -- mode diag constant
   constant TELOPS_DIAG_DEGR               : std_logic_vector(7 downto 0):= x"D2";  -- mode diag degradé pour la prod
   constant TELOPS_DIAG_DEGR_DYN           : std_logic_vector(7 downto 0):= x"D3";  -- mode diag degradé dynamique pour FAU
   
   -- increment des données en mode diag compteur
   constant DIAG_DATA_INC                  : integer := 2*integer((2**14 - 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   
   ----------------------------------------------
   -- Calculs
   ----------------------------------------------
   constant DEFINE_FPA_POWER_WAIT_FACTOR                    : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_POWER_ON_WAIT_MS);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS    : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR
   constant DEFINE_FPA_PROG_SCLK_RATE_FACTOR                : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_PROG_SCLK_RATE_KHZ);
   constant DEFINE_DIAG_DATA_CLK_FACTOR                     : integer := 2; -- ???
   
   
   -- misc 
   type misc_cfg_type is
   record
      x_to_readout_start_dly                 : unsigned(15 downto 0);
      fval_re_to_dval_re_dly                 : unsigned(15 downto 0);
      hdr_start_to_lval_re_dly               : unsigned(15 downto 0);
      lval_pause_dly                         : unsigned(15 downto 0);
      x_to_next_fsync_re_dly                 : unsigned(15 downto 0);
      xsize_div_per_pixel_num                : unsigned(9 downto 0);
   end record;
   
   ------------------------------------------------
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record     
      -- cette partie provient du contrôleur du temps d'integration
      int_time                         : unsigned(31 downto 0);          -- temps d'integration en coups de MCLK. 
      int_indx                         : std_logic_vector(7 downto 0);   -- index du  temps d'integration
      int_signal_high_time             : unsigned(31 downto 0);          -- duree en MCLK pendant laquelle lever le signal d'integration pour avoir int_time. depend des offsets de temps d'intégration   
      
      -- feedback d'intégration
      int_fdbk_dly                     : unsigned(3 downto 0);          -- delai en MCLK avant generation du feedback d'integration.
      
      -- cette partie provient du microBlaze
      -- common
      comn                             : fpa_comn_cfg_type;      -- partie commune (utilisée par les modules communs)
      
      -- les valeurs Vdac
      vdac_value                       : fleg_vdac_value_type;     -- calculé dans le MB pour dac(1) à dac(8)
      
      -- window
      offsetx                          : unsigned(9 downto 0);
      offsety                          : unsigned(9 downto 0);
      width                            : unsigned(9 downto 0);
      height                           : unsigned(9 downto 0);
      
      -- kpix
      kpix_pgen_value                  : std_logic_vector(15 downto 0);
      kpix_mean_value                  : std_logic_vector(15 downto 0);
      
      misc                             : misc_cfg_type; -- les changements dans misc ne font pas programmer le detecteur
      
      fpa_int_time_offset              : signed(31 downto 0);
      
      cfg_num                          : unsigned(7 downto 0);
      
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
   
   
   -- Pixel fields range. Used to index pixel bits vector.
   subtype pix_data_range_type    is natural range 22 downto  0;
   subtype pix_coarse_range_type  is natural range 22 downto 15;
   subtype pix_residue_range_type is natural range 14 downto  0;
   
   -- Quad pixel data array. Each pixel is on 23 bits.
   type pix_data_array_type is array (1 to 4) of std_logic_vector(pix_data_range_type);
   
   -- Quad data type. Quad pixel data array with some control signals.
   type calcium_quad_data_type is
   record
      -- Pixel data
      pix_data       : pix_data_array_type;
      -- Frame valid is high during a frame. Stays low at least 1 clk between frames.
      fval           : std_logic;
      -- Line valid is high during a line. Stays low at least 1 clk between lines.
      -- Can be high only when FVAL is high.
      lval           : std_logic;
      -- Data valid is high for each valid data transaction. Stays high if there are 2 
      -- consecutive transaction. Can be high only when FVAL and LVAL are high.
      dval           : std_logic;
      -- Area of interest data valid is the same signal as DVAL but is high only
      -- for pixel data transaction. Stays low for other data transactions.
      aoi_dval       : std_logic;
      -- Area of interest last is high during the last pixel data transaction.
      aoi_last       : std_logic;
   end record;
   
end Proxy_define;

package body Proxy_define is
   
   
end package body Proxy_define;
