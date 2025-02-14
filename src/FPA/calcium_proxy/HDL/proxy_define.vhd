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
use work.tel2000.all;

package Proxy_define is

   --------------------------------------------------
   -- D�finitions propres au calcium proxy
   --------------------------------------------------
   constant DEFINE_FPA_ROIC                           : std_logic_vector(7 downto 0) := FPA_ROIC_CALCIUM;  -- roic du d�tecteur. Cela veut dire que le vhd actuel peut contr�ler un d�tecteur de ce type qque soit le cooler
   constant DEFINE_FPA_OUTPUT                         : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL; 
   constant DEFINE_FPA_INPUT                          : std_logic_vector(7 downto 0) := LVCMOS18;
   constant DEFINE_FPA_TEMP_DIODE_CURRENT_uA          : natural   := 100;        -- doit �tre d�fini mais pas utilis�: source courant sur EFA-00331. consigne pour courant de polarisation de la diode de lecture de temp�rature
   constant DEFINE_FLEX_VOLTAGEP_mV                   : natural   := 5500;       -- doit �tre d�fini mais pas utilis�: la tension interm�diaire vflex de ce d�tecteur est � 5.5V
   constant DEFINE_FPA_TEMP_CH_GAIN                   : real      := 1.0;        -- le gain entre le voltage de la diode de temperature et le voltage � l'entr�e de l'ADC de lecture de la temperature. (Vadc_in/Vdiode). Tenir compte de l'ampli buffer et des resistances entre les deux
   constant DEFINE_FPA_INIT_CFG_NEEDED                : std_logic := '0';        -- doit �tre d�fini mais pas utilis�: pas besoin de config particuli�re au demarrage
   constant DEFINE_FPA_PROG_SCLK_RATE_KHZ             : integer   := 1_000;      -- horloge SPI pour la programmation du FPA. Doit �tre 1 MHz (ou 10?)
   constant DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP         : integer   := 1;          -- on doit laisser 1 image d�s qu'on reprogramme le d�tecteur
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP                : integer   := DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;
   constant DEFINE_FPA_POWER_ON_WAIT_MS               : integer   := 1_200;      -- en msec, duree d'attente apr�s allumage. Le ramp-up du LT3045 est d'environ 1s
   constant DEFINE_FPA_OUT_OF_RESET_WAIT_MS           : integer   := 10;         -- en msec, duree d'attente apr�s avoir sorti le roic du reset (1ms selon le manufacturier)
   constant DEFINE_FPA_TEMP_RAW_MIN                   : integer   := 30720;      -- minimum ADC value for power-on : 0.960V de 2N2222 (soit 120K)
   constant DEFINE_FPA_TEMP_RAW_MAX                   : integer   := 35200;      -- maximum ADC value for power-on : 1.100V de 2N2222 (soit 40K) to protect against ultra low temp
   constant PROG_FREE_RUNNING_TRIG                    : std_logic := '0';        -- cette constante dit que les trigs doivent �tre arr�t�s lorsqu'on programme le d�tecteur
   constant DEFINE_FPA_100M_CLK_RATE_KHZ              : integer   := 100_000;    -- horloge de 100M en KHz
   
   -- limites impos�es aux tensions VDAC
   -- proviennent des scripts FLEG_VccVoltage_To_DacWord et FLEG_DacWord_To_VccVoltage dans
   -- \\STARK\DisqueTELOPS\Bibliotheque\Electronique\PCB\EFP-00331-001_Senseeker Proxy\Documentation
   constant DEFINE_DAC_LIMIT : fleg_vdac_limit_array_type   := (
      ( 3373,  5400),      -- limites du DAC1 -> VA1.8 1.5V � 2.1V
      (    0, 11796),      -- limites du DAC2 -> VPIXRST 0V � 3.6V (mais le LDO ne pourra descendre plus bas que 0.5V)
      ( 3880,  5400),      -- limites du DAC3 -> VDHS1.8 1.65V � 2.1V
      ( 3880,  5400),      -- limites du DAC4 -> VD1.8 1.65V � 2.1V
      ( 8440, 10467),      -- limites du DAC5 -> VA3.3 3.0V � 3.6V
      ( 9830, 11796),      -- limites du DAC6 -> VDETGUARD 3.0V � 3.6V
      ( 8440, 10467),      -- limites du DAC7 -> VDETCOM 3.0V � 3.6V
      ( 1684,  5400)       -- limites du DAC8 -> VPIXQNB 1.0V � 2.1V
   );
   
   --------------------------------------------
   --  modes diag
   --------------------------------------------
   -- D comme diag 
   constant TELOPS_DIAG_CNST               : std_logic_vector(7 downto 0):= x"D1";  -- mode diag constant
   constant TELOPS_DIAG_DEGR               : std_logic_vector(7 downto 0):= x"D2";  -- mode diag degrad� pour la prod
   constant TELOPS_DIAG_DEGR_DYN           : std_logic_vector(7 downto 0):= x"D3";  -- mode diag degrad� dynamique pour FAU
   
   -- increment des donn�es en mode diag compteur
   constant DIAG_DATA_INC                  : integer := 2*integer((2**14 - 1 - XSIZE_MAX)/(2*XSIZE_MAX)) + 1; -- nombre toujours impair. Pour provoquer SSO
   
   ----------------------------------------------
   -- Calculs
   ----------------------------------------------
   constant DEFINE_FPA_POWER_WAIT_FACTOR                    : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_POWER_ON_WAIT_MS);
   constant DEFINE_FPA_OUT_OF_RESET_WAIT_FACTOR             : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ*DEFINE_FPA_OUT_OF_RESET_WAIT_MS);
   constant DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS    : natural := 26;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR
   constant DEFINE_FPA_PROG_SCLK_RATE_FACTOR                : integer := integer(DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_PROG_SCLK_RATE_KHZ);
   constant FPA_PIX_THROUGHPUT_MAX_MPIX                     : real    := real(8*400*2) / real(24);    -- 8 canaux � 400MHz DDR � 24b par pixel [Mpix/s]
   constant DEFINE_DIAG_DATA_CLK_FACTOR                     : integer := integer(ceil(real(4*DEFINE_FPA_100M_CLK_RATE_KHZ) / real(FPA_PIX_THROUGHPUT_MAX_MPIX*1000.0))); -- il faut ralentir le throughput du DIAG (4 pix � 100MHz) pour qu'il soit <= au FPA
   
   
   -- diag 
   type diag_cfg_type is
   record
      x_to_readout_start_dly                 : unsigned(15 downto 0);
      fval_re_to_dval_re_dly                 : unsigned(15 downto 0);
      lval_pause_dly                         : unsigned(15 downto 0);
      x_to_next_fsync_re_dly                 : unsigned(15 downto 0);
      xsize_div_per_pixel_num                : unsigned(9 downto 0);
   end record;
   
   -- kpix
   type kpix_reg_type is
   record     
      write      : std_logic_vector(31 downto 0);     
      write_dval : std_logic;     
      status     : std_logic_vector(31 downto 0);
   end record;
   subtype kpix_write_reg_even_range is natural range 31 downto 16;
   subtype kpix_write_reg_odd_range  is natural range 15 downto  0;
   subtype kpix_status_reg_addr_range is natural range 31 downto 8;
   subtype kpix_status_reg_err_range  is natural range  2 downto 2;
   subtype kpix_status_reg_done_range is natural range  1 downto 1;
   subtype kpix_status_reg_size_range is natural range  0 downto 0;
   
   -- compression
   type compr_err_ary_type is array (natural range <>) of std_logic_vector(4 downto 0);
   
   -- roic exposure time config
   type roic_exp_time_cfg_type is
   record
      bIntCnt             : unsigned(19 downto 0);    -- valeur du registre bIntCnt. Le temps d'int�gration est bIntCnt + 1.
      bDSMCycles          : unsigned(15 downto 0);    -- valeur du registre bDSMCycles. Le nombre de cycles DSM est bDSMCycles + 1.
      bDSMDelayCnt        : unsigned(15 downto 0);    -- valeur du registre bDSMDelayCnt. Le d�lai entre les cycles DSM est bDSMDelayCnt + 1.
      bDSMInitDelayCnt    : unsigned(15 downto 0);    -- valeur du registre bDSMInitDelayCnt. Le d�lai avant le 1er cycle DSM est bDSMInitDelayCnt + 1.
   end record;
   
   ------------------------------------------------
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record     
      -- cette partie provient du contr�leur du temps d'integration
      int_time                         : unsigned(31 downto 0);            -- temps d'integration en CLK_100MHz 
      int_indx                         : std_logic_vector(7 downto 0);     -- index du  temps d'integration
      int_signal_high_time             : unsigned(31 downto 0);            -- duree en CLK_100MHz pendant laquelle lever le signal d'integration pour avoir int_time. depend de l'offset de temps d'int�gration
      
      -- cette partie provient du microBlaze
      comn                             : fpa_comn_cfg_type;                -- config commune. d�finition dans fpa_common_pkg
      
      offsetx                          : unsigned(9 downto 0);             -- d�calage horizontal de l'AOI en nbre de colonnes. 0 signifie aucun d�calage
      offsety                          : unsigned(9 downto 0);             -- d�calage vertical de l'AOI en nbre de lignes. 0 signifie aucun d�calage
      width                            : unsigned(9 downto 0);             -- largeur de l'AOI en nbre de colonnes
      height                           : unsigned(9 downto 0);             -- hauteur de l'AOI en nbre de lignes
      
      active_line_start_num            : unsigned(3 downto 0);             -- le numero de la premiere ligne de l'AOI. 1 signifie qu'aucune ligne n'est rejet�e au d�but
      active_line_end_num              : unsigned(9 downto 0);             -- le numero de la derniere ligne de l'AOI. (active_line_start_num + height - 1)
      active_line_width_div4           : unsigned(7 downto 0);             -- le nombre de transactions dans une ligne. (width / 4)
      
      diag                             : diag_cfg_type;                    -- config du module diag
      
      fpa_int_time_offset              : signed(31 downto 0);              -- offset en CLK_100MHz � ajouter au temps d'int�gration pour que le r�sultat soit conforme � la commande.
                                                                           -- offset est sign�: positif signifie que la commande doit �tre plus longue que le r�sultat voulu, n�gatif signifie que la commande doit �tre plus courte que le r�sultat voulu
      
      int_fdbk_dly                     : unsigned(3 downto 0);             -- delai en CLK_100MHz avant generation du feedback d'integration
      
      kpix_pgen_en                     : std_logic;                        -- active le mode des kpix uniformes avec une valeur programm�e
      kpix_median_value                : unsigned(15 downto 0);            -- valeur m�diane pour le calcul des kpix
      
      use_ext_pixqnb                   : std_logic;                        -- indique s'il faut activer le bias externe vTstPixQNB. S'il est d�sactiv�, le bias interne doit �tre configur�
      clk_frm_pulse_width              : unsigned(7 downto 0);             -- dur�e fixe du pulse CLK_FRM en CLK_100MHz lorsque le temps d'int�gration est contr�l� � l'interne du ROIC (configur� par registres).
                                                                           -- la valeur 0 est r�serv�e pour le contr�le du temps d'int�gration � l'externe (largeur du pulse CLK_FRM). CLK_FRM sera une copie de FPA_INT
      
      fpa_serdes_lval_num              : unsigned(10 downto 0);            -- nombre total de LVAL dans un FVAL pour la calibration des serdes d'entr�e
      fpa_serdes_lval_len              : unsigned(10 downto 0);            -- nombre de pixel_clk dans un LVAL (width / 8) pour la calibration des serdes d'entr�e
      
      compr_ratio_fp32                 : std_logic_vector(31 downto 0);    -- ratio de compression en fp32 utilis� comme exposant par la loi de puissance
      compr_en                         : std_logic;                        -- active la compression par la loi de puissance
      compr_bypass_shift               : unsigned(3 downto 0);             -- bit shift � appliquer aux donn�es quand la compression est d�sactiv�e
      
      roic_tx_nb_data                  : unsigned(7 downto 0);             -- nombre de donn�es � envoyer au ROIC
      
      dsm_period_constants             : unsigned(8 downto 0);             -- somme des parties constantes de la p�riode DSM en ClkDSM
      dsm_period_min                   : unsigned(8 downto 0);             -- dur�e min de la p�riode DSM en ClkDSM
      dsm_period_min_div_numerator     : unsigned(31 downto 0);            -- valeur multiplicative pour obtenir la division par la p�riode DSM min
      dsm_nb_period_max                : unsigned(8 downto 0);             -- nombre max de p�riodes DSM
      dsm_nb_period_max_div_numerator  : unsigned(31 downto 0);            -- valeur multiplicative pour obtenir la division par le nombre max de p�riodes DSM
      dsm_nb_period_min                : unsigned(3 downto 0);             -- nombre min de p�riodes DSM
      dsm_total_time_threshold         : unsigned(15 downto 0);            -- threshold de temps total du m�canisme DSM pour utiliser le nombre max de p�riodes DSM
      
      cfg_num                          : unsigned(7 downto 0);             -- num�ro incr�mental de la config actuelle
      
      vdac_value                       : fleg_vdac_value_type;             -- config du DAC. d�finition dans fleg_brd_define
      
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
      rdy                 : std_logic;                     -- pulse signifiant que les parametres du header sont pr�ts
   end record;
   
   
   -- Pixel fields range. Used to index pixel bits vector.
   subtype pix_data_range_type    is natural range 22 downto  0;
   subtype pix_coarse_range_type  is natural range 22 downto 15;
   subtype pix_residue_range_type is natural range 14 downto  0;
   
   -- Pixel data array. Each pixel is on 23 bits.
   type pix_data_array_type is array (positive range <>) of std_logic_vector(pix_data_range_type);
   
   -- Quad data type. Quad pixel data array with some control signals.
   type calcium_quad_data_type is
   record
      -- Pixel data
      pix_data       : pix_data_array_type(1 to 4);
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
   
   -- Octo data type. Octo pixel data array with some control signals.
   type calcium_octo_data_type is
   record
      -- Pixel data
      pix_data       : pix_data_array_type(1 to 8);
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
   
   ----------------------------------------------
   -- Functions
   ----------------------------------------------
   function fpa_intf_cfg_to_slv_array(FPA_INTF_CFG : fpa_intf_cfg_type) return fpa_intf_cfg_slv_array_type;
   
end Proxy_define;

package body Proxy_define is
   
   ---------------------------------------------------------------------------------------------------------------
   -- Fonction utilis�e par le module fpa_status_gen pour transf�rer la FPA_INTF_CFG par AXIL vers le microBlaze
   ---------------------------------------------------------------------------------------------------------------
   function fpa_intf_cfg_to_slv_array(FPA_INTF_CFG : fpa_intf_cfg_type) return fpa_intf_cfg_slv_array_type is
      variable a : fpa_intf_cfg_slv_array_type;
   begin
      a := (
         std_logic_vector(resize(FPA_INTF_CFG.int_time, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.int_indx, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.int_signal_high_time, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_diag_mode, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_diag_type, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_pwr_on, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_acq_trig_mode, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_acq_trig_ctrl_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_xtra_trig_mode, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_xtra_trig_ctrl_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_trig_ctrl_timeout_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_stretch_acq_trig, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_intf_data_source, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_xtra_trig_int_time, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.fpa_prog_trig_int_time, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.intclk_to_clk100_conv_numerator, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.comn.clk100_to_intclk_conv_numerator, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.offsetx, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.offsety, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.width, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.height, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.active_line_start_num, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.active_line_end_num, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.active_line_width_div4, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.diag.x_to_readout_start_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.diag.fval_re_to_dval_re_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.diag.lval_pause_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.diag.x_to_next_fsync_re_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.diag.xsize_div_per_pixel_num, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.fpa_int_time_offset, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.int_fdbk_dly, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.kpix_pgen_en, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.kpix_median_value, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.use_ext_pixqnb, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.clk_frm_pulse_width, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.fpa_serdes_lval_num, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.fpa_serdes_lval_len, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.compr_ratio_fp32, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.compr_en, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.compr_bypass_shift, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.roic_tx_nb_data, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_period_constants, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_period_min, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_period_min_div_numerator, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_nb_period_max, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_nb_period_max_div_numerator, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_nb_period_min, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.dsm_total_time_threshold, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.cfg_num, a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(1), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(2), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(3), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(4), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(5), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(6), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(7), a(0)'length)),
         std_logic_vector(resize(FPA_INTF_CFG.vdac_value(8), a(0)'length)),
         others => (others => '0')     -- champs inutilis�s
      );
      return a;
   end fpa_intf_cfg_to_slv_array;
   
end package body Proxy_define;
