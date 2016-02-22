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

package FPA_define is    
   
   ----------------------------------------------
   -- FPA 
   ---------------------------------------------- 
   -- consignes pour vérification avec infos en provenance du vhd, flex, et adc
   constant DEFINE_FPA_ROIC                       : std_logic_vector(7 downto 0) := FPA_ROIC_ISC0207;  -- roic du détecteur. Cela veut dire que le vhd actuel peut contrôler in détecteur de ce type qque soit le cooler.
   constant DEFINE_FPA_OUTPUT                     : std_logic_vector(1 downto 0) := OUTPUT_ANALOG; 
   constant DEFINE_FPA_INPUT                      : std_logic_vector(7 downto 0) := LVTTL50;   
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA      : natural   := 100;      -- consigne pour courant de polarisation de la diode de lecture de température
   constant DEFINE_FPA_TAP_NUMBER                 : natural   := 16;                                                                                     
   constant DEFINE_FLEX_VOLTAGEP_mV               : natural   := 8000;     -- le flex de ce détecteur doit être alimenté à 8V 
   constant DEFINE_FPA_TEMP_CH_GAIN               : real      := 1.0;      -- le gain entre le voltage de la diode de temperature et le voltage à l'entrée de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l,ampli buffer et des resistances entre les deux 
   constant DEFINE_FPA_PIX_PER_MCLK_PER_TAP       : natural   := 2;        -- 2 pixels par coup d'horloge pour le 0207
   constant DEFINE_FPA_BITSTREAM_LENGTH           : natural   := 58;       -- nombre de bits contenu  dans le bitstream de configuration serielle
   constant DEFINE_FPA_INT_TIME_OFFSET_nS         : natural   := 800;      -- int_time offset de 0.8usec 
   constant DEFINE_FPA_PROG_INT_TIME              : natural   := 100;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé piour les images post configuration du detecteur 
   constant DEFINE_FPA_XTRA_TRIG_INT_TIME         : natural   := 100;      -- en coups d'horloge FPA, c'est le temps d'integration utilisé pour les images xtra trig
   
   -- quelques caractéristiques du FPA
   constant DEFINE_FPA_INT_TIME_MIN_US            : integer   := 1; 
   constant DEFINE_FPA_MCLK_RATE_KHZ              : integer   := 5_000;       -- pour le 0207, c'est fixé à 5MHz. Donc non configurable. D'où sa présence dans le fpa_define. Pour d'autres détecteurs, il peut se retrouver dans le pilote en C
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP     : integer   := 2;           -- pour le ISC0207, on doit laisser deux images dès qu'on reprogramme le détecteur
   constant DEFINE_XSIZE_MAX                      : integer   := 320;              -- dimension en X maximale
   constant DEFINE_YSIZE_MAX                      : integer   := 256;              -- dimension en Y maximale  
   constant DEFINE_GAIN0                          : std_logic := '0';
   constant DEFINE_GAIN1                          : std_logic := '1';             -- plus gros puits
   constant DEFINE_ITR_MODE                       : std_logic := '0';
   constant DEFINE_IWR_MODE                       : std_logic := '1';
   constant DEFINE_FPA_INT_FBK_AVAILABLE          : std_logic := '0';
   constant DEFINE_FPA_POWER_ON_WAIT_US           : integer   := 1_000_000;  -- duree d'attente après allumage en usec
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_US        : integer   := 500_000;    -- le trig de lecture de la temperature a une periode de 0.5sec
   constant DEFINE_FPA_TEMP_RAW_MIN               : integer   := 30720;        -- Minimum ADC value for 0207 power-on : 0.960V de 2N2222 (soit 120K)  
   constant DEFINE_FPA_TEMP_RAW_MAX               : integer   := 35200;       -- Maximum ADC value for 0207 power-on : (to protect against ultra low temp). 1.1V 
   
   constant PROG_FREE_RUNNING_TRIG                : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ          : integer   := 100_000;    --  horloge de 100M en KHz
   constant DEFINE_FPA_80M_CLK_RATE_KHZ           : integer   := 80_000;     --  horloge de 80M en KHz
   
   -- quelques caractéristiques de la carte ADC requise
   constant DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ  : integer   := 40_000;     -- 10 juin 2015: 40MHz pour debloquer SSA. On revient à 25 par la suite. l'horloge par defaut est celle des Quads au demarrage en attendant la detection de la carte ADC. C,est une frequence utilisable quelle que soit la carte ADC. Une fois la carte ADC détectée, celle-ci imposera une frequence maximale à ne pas depasser.
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ          : integer   := 40_000;     -- c'est l'horolge reelle des quads pour laquelle le design est fait. Elle doit être inférieure à la limite imposée par la carte ADC détectée. Si telle n'est pas le cas, sortir une erreur  
   constant DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ   : integer   := DEFINE_FPA_80M_CLK_RATE_KHZ;     -- c'est l'horloge à partir de laquelle est produite celle des quads. On a le choix entre 100MHz et 80MHz.
   constant DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ : integer   := DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ;     -- c'est l'horloge à partir de laquelle est produite celle du détecteur. On a le choix entre 100MHz et 80MHz.Il faut que ce soit rigoureusement la m^me source que les ADC. Ainsi le dehphasage entre le FPA_MASTER_CLK et les clocks des quads sera toujours le même. 
   
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
   constant DEFINE_FPA_POWER_WAIT_FACTOR          : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ*(DEFINE_FPA_POWER_ON_WAIT_US/1000));
   constant DEFINE_FPA_TEMP_TRIG_PERIOD_FACTOR    : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_TEMP_TRIG_PERIOD_US/1000);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR  
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR  : integer := 2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant DEFINE_FPA_EXP_TIME_CONV_NUMERATOR    : unsigned(DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(DEFINE_FPA_MCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     --
   constant DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR    : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_DEFAULT_KHZ);
   constant DEFINE_ADC_QUAD_CLK_FACTOR            : integer := integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ/DEFINE_ADC_QUAD_CLK_RATE_KHZ);
   constant DEFINE_FPA_MCLK_RATE_FACTOR           : integer := integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);
   constant DEFINE_FPA_MCLK_RATE_FACTOR_100M      : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ);    -- pour la conversion du temps d'integration en coups de 100MHz 
   constant DEFINE_FPA_INT_TIME_OFFSET_FACTOR     : integer := integer((real(DEFINE_FPA_INT_TIME_OFFSET_nS)*real(DEFINE_FPA_MCLK_RATE_KHZ))/1_000_000.0);
   constant DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH      : natural := integer(DEFINE_ADC_QUAD_CLK_RATE_KHZ/(DEFINE_FPA_PIX_PER_MCLK_PER_TAP*DEFINE_FPA_MCLK_RATE_KHZ));
   constant XSIZE_MAX                             : integer := DEFINE_XSIZE_MAX;  -- pour les modules utilisant XSIZE_MAX
   constant YSIZE_MAX                             : integer := DEFINE_YSIZE_MAX;  -- pour les modules utilisant YSIZE_MAX
   
   ---------------------------------------------------------------------------------								
   -- Configuration
   ---------------------------------------------------------------------------------  
   --   -- config propre au détecteur
   --   -- tout changement implique sa reprogrammation
   --   type det_cfg_type is
   --   record  
   --      xstart              : unsigned(10 downto 0); 
   --      ystart              : unsigned(10 downto 0);
   --      xsize               : unsigned(10 downto 0);
   --      ysize               : unsigned(10 downto 0);
   --      gain                : std_logic;
   --      invert              : std_logic; 
   --      revert              : std_logic;
   --      onchip_binning      : std_logic;    
   --   end record;
   --   
   --   
   -- misc                    
   type misc_cfg_type is
   record
      tir                        : unsigned(7 downto 0);
      xsize_div_tapnum           : unsigned(7 downto 0);
   end record;
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record     
      -- cette partie provient du contrôleur du temps d'integration
      int_time                     : unsigned(31 downto 0);  -- temps d'integration en coups de MCLK. 
      int_indx                     : std_logic_vector(7 downto 0);   -- index du  temps d'integration
      int_signal_high_time         : unsigned(31 downto 0);  -- dureen en MCLK pendant laquelle lever le signal d'integration pour avoir int_time. depend des offsets de temps d'intégration   
      
      -- cette partie provient du microBlaze
      comn                         : fpa_comn_cfg_type;      -- partie commune (utilisée par les modules communs)
      xstart                       : unsigned(9 downto 0); 
      ystart                       : unsigned(9 downto 0);
      xsize                        : unsigned(9 downto 0);
      ysize                        : unsigned(9 downto 0);
      gain                         : std_logic;
      invert                       : std_logic; 
      revert                       : std_logic;
      onchip_bin_256               : std_logic;
      onchip_bin_128               : std_logic;      
      pix_samp_num_per_ch          : unsigned(7 downto 0); 
      good_samp_first_pos_per_ch   : unsigned(3 downto 0);    --  first good sample position in a pixel
      good_samp_last_pos_per_ch    : unsigned(3 downto 0);    --  last good sample position  in a pixel
      good_samp_sum_num            : unsigned(3 downto 0);    --  
      good_samp_mean_numerator     : unsigned(22 downto 0);   -- ne pas changer la taille de ce registre car elle depend 
      good_samp_mean_div_bit_pos   : unsigned(4 downto 0);
      ysize_div2_m1                : unsigned(8 downto 0);
      img_samp_num                 : unsigned(23 downto 0);   -- nombre total d'echantillons de l'image = Xsize*Ysize*Nsample_per_pix
      img_samp_num_per_ch          : unsigned(14 downto 0);
      fpa_active_pixel_dly         : unsigned(7 downto 0);    -- delay ajustable pour synchro sur le premier pixel
      diag_active_pixel_dly        : unsigned(7 downto 0);    -- delay ajustable pour synchro sur le premier pixel
      sof_samp_pos_start_per_ch    : unsigned(23 downto 0);
      sof_samp_pos_end_per_ch      : unsigned(23 downto 0);
      eof_samp_pos_start_per_ch    : unsigned(23 downto 0);
      eof_samp_pos_end_per_ch      : unsigned(23 downto 0); 
      diag_tir                     : unsigned(7 downto 0);
      xsize_div_tapnum             : unsigned(7 downto 0);
      readout_plus_delay           : unsigned(15 downto 0);
      tri_window_and_intmode_part  : unsigned(17 downto 0); -- suppose que le mode IWR n'Est pas supporté. Sinon cette variable doit être signed
      int_time_offset              : unsigned(7 downto 0);
      tsh_min                      : unsigned(15 downto 0);
      tsh_min_minus_int_time_offset: unsigned(15 downto 0);
      
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
   -- quues fontions                                    
   ----------------------------------------------
   
end FPA_define;

package body FPA_define is
   
   
   
end package body FPA_define; 
