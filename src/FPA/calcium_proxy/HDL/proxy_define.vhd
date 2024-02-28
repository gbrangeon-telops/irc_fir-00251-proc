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
   constant DEFINE_FPA_INIT_CFG_NEEDED                : std_logic := '0';        -- doit être défini mais pas utilisé: pas besoin de config particulière au demarrage
   constant DEFINE_FPA_PROG_SCLK_RATE_KHZ             : integer   := 1_000;      -- horloge SPI pour la programmation du FPA. Doit être 1 MHz (ou 10?)
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP         : integer   := 1;          -- on doit laisser 1 image dès qu'on reprogramme le détecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP                : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;
   constant DEFINE_FPA_POWER_ON_WAIT_MS               : integer   := 1_200;      -- en msec, duree d'attente après allumage. Le ramp-up du LT3045 est d'environ 1s
   constant DEFINE_FPA_OUT_OF_RESET_WAIT_MS           : integer   := 100;        -- en msec, duree d'attente après avoir sorti le roic du reset
   constant DEFINE_FPA_TEMP_RAW_MIN                   : integer   := 30720;      -- minimum ADC value for power-on : 0.960V de 2N2222 (soit 120K)
   constant DEFINE_FPA_TEMP_RAW_MAX                   : integer   := 35200;      -- maximum ADC value for power-on : 1.100V de 2N2222 (soit 40K) to protect against ultra low temp
   constant PROG_FREE_RUNNING_TRIG                    : std_logic := '0';        -- cette constante dit que les trigs doivent être arrêtés lorsqu'on programme le détecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ              : integer   := 100_000;    -- horloge de 100M en KHz
   constant DEFINE_ADC_QUAD_CLK_RATE_KHZ              : integer   := 40_000;     -- nécessaire pour ADC_BRD_INFO. À ENLEVER
   
   -- limites imposées aux tensions VDAC
   -- proviennent des scripts FLEG_VccVoltage_To_DacWord et FLEG_DacWord_To_VccVoltage dans
   -- \\STARK\DisqueTELOPS\Bibliotheque\Electronique\PCB\EFP-00331-001_Senseeker Proxy\Documentation
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
      ( 3373,  5400),      -- limites du DAC1 -> VA1.8 1.5V à 2.1V
      (    0, 11796),      -- limites du DAC2 -> VPIXRST 0V à 3.6V
      ( 3880,  5400),      -- limites du DAC3 -> VDHS1.8 1.65V à 2.1V
      ( 3880,  5400),      -- limites du DAC4 -> VD1.8 1.65V à 2.1V
      ( 8440, 10467),      -- limites du DAC5 -> VA3.3 3.0V à 3.6V
      ( 9830, 11796),      -- limites du DAC6 -> VDETGUARD 3.0V à 3.6V
      ( 8440, 10467),      -- limites du DAC7 -> VDETCOM 3.0V à 3.6V
      (    0,  5400)       -- limites du DAC8 -> VPIXQNB 0V à 2.1V (mais le LDO ne pourra descendre plus bas que 0.5V)
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
   constant DEFINE_FPA_OUT_OF_RESET_WAIT_FACTOR             : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_OUT_OF_RESET_WAIT_MS);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS    : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR
   constant DEFINE_FPA_PROG_SCLK_RATE_FACTOR                : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_PROG_SCLK_RATE_KHZ);
   constant FPA_PIX_THROUGHPUT_MAX_MPIX                     : real    := real(8*400*2) / real(24);    -- 8 canaux à 400MHz DDR à 24b par pixel [Mpix/s]
   constant DEFINE_DIAG_DATA_CLK_FACTOR                     : integer := integer(ceil(real(4*DEFINE_FPA_100M_CLK_RATE_KHZ) / real(FPA_PIX_THROUGHPUT_MAX_MPIX*1000.0))); -- il faut ralentir le throughput du DIAG (4 pix à 100MHz) pour qu'il soit <= au FPA
   
   
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
      int_time                         : unsigned(31 downto 0);            -- temps d'integration en CLK_100MHz 
      int_indx                         : std_logic_vector(7 downto 0);     -- index du  temps d'integration
      int_signal_high_time             : unsigned(31 downto 0);            -- duree en CLK_100MHz pendant laquelle lever le signal d'integration pour avoir int_time. depend de l'offset de temps d'intégration
      
      -- cette partie provient du microBlaze
      comn                             : fpa_comn_cfg_type;                -- config commune. définition dans fpa_common_pkg
      
      offsetx                          : unsigned(9 downto 0);             -- décalage horizontal de l'AOI en nbre de colonnes. 0 signifie aucun décalage
      offsety                          : unsigned(9 downto 0);             -- décalage vertical de l'AOI en nbre de lignes. 0 signifie aucun décalage
      width                            : unsigned(9 downto 0);             -- largeur de l'AOI en nbre de colonnes
      height                           : unsigned(9 downto 0);             -- hauteur de l'AOI en nbre de lignes
      
      active_line_start_num            : unsigned(3 downto 0);             -- le numero de la premiere ligne de l'AOI. 1 signifie qu'aucune ligne n'est rejetée au début
      active_line_end_num              : unsigned(9 downto 0);             -- le numero de la derniere ligne de l'AOI. (active_line_start_num + height - 1)
      active_line_width_div4           : unsigned(7 downto 0);             -- le nombre de transactions dans une ligne. (width / 4)
      
      misc                             : misc_cfg_type;                    -- config du module diag
      
      fpa_int_time_offset              : signed(31 downto 0);              -- offset en CLK_100MHz à ajouter au temps d'intégration pour que le résultat soit conforme à la commande.
                                                                           -- offset est signé: positif signifie que la commande doit être plus longue que le résultat voulu, négatif signifie que la commande doit être plus courte que le résultat voulu
      
      int_fdbk_dly                     : unsigned(3 downto 0);             -- delai en CLK_100MHz avant generation du feedback d'integration
      
      kpix_pgen_value                  : std_logic_vector(15 downto 0);    --
      kpix_mean_value                  : std_logic_vector(15 downto 0);    --
      
      use_ext_pixqnb                   : std_logic;                        -- indique s'il faut activer le bias externe vTstPixQNB. S'il est désactivé, le bias interne doit être configuré
      clk_frm_pulse_width              : unsigned(7 downto 0);             -- durée fixe du pulse CLK_FRM en CLK_100MHz lorsque le temps d'intégration est contrôlé à l'interne du ROIC (configuré par registres).
                                                                           -- la valeur 0 est réservée pour le contrôle du temps d'intégration à l'externe (largeur du pulse CLK_FRM). CLK_FRM sera une copie de FPA_INT
      
      fpa_serdes_lval_num              : unsigned(10 downto 0);            -- nombre total de LVAL dans un FVAL pour la calibration des serdes d'entrée
      fpa_serdes_lval_len              : unsigned(10 downto 0);            -- nombre de pixel_clk dans un LVAL (width / 8) pour la calibration des serdes d'entrée
      
      cfg_num                          : unsigned(7 downto 0);             -- numéro incrémental de la config actuelle
      
      vdac_value                       : fleg_vdac_value_type;             -- config du DAC. définition dans fleg_brd_define
      
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
