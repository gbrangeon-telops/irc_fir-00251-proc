-------------------------------------------------------------------------------
--
-- Title       : scd_data_dispatcher
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\SCD_Hercules\src\scd_data_dispatcher.vhd
-- Generated   : Mon Jan 10 13:16:11 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all;
use work.FPA_Define.all;
use work.Proxy_define.all;
use work.tel2000.all;
use work.img_header_define.all;


entity scd_data_dispatcher is
   port(
  
      ARESET            : in std_logic;
      CLK               : in std_logic; 
      
      ACQ_INT           : in std_logic;  -- ACQ_INT et FRAME_ID sont parfaitement synchdonisés
      FPA_INT           : in std_logic;
      FPA_TRIG          : in std_logic;
      FRAME_ID          : in std_logic_vector(31 downto 0);
      INT_INDX          : in std_logic_vector(7 downto 0);
      INT_TIME          : in std_logic_vector(24 downto 0);
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      FPA_CH1_RST       : in std_logic;
      FPA_CH1_CLK       : in std_logic;
      FPA_CH1_DATA      : in std_logic_vector(27 downto 0);      
      FPA_CH1_DVAL      : in std_logic;
      
      FPA_CH2_RST       : in std_logic;
      FPA_CH2_CLK       : in std_logic;
      FPA_CH2_DATA      : in std_logic_vector(27 downto 0);      
      FPA_CH2_DVAL      : in std_logic;
      
      FPA_CH3_RST       : in std_logic;
      FPA_CH3_CLK       : in std_logic;
      FPA_CH3_DATA      : in std_logic_vector(27 downto 0);      
      FPA_CH3_DVAL      : in std_logic;
      
      FPA_DIAG_CLK      : in std_logic;
      
      DIAG_CH1_DATA     : in std_logic_vector(27 downto 0);      
      DIAG_CH1_DVAL     : in std_logic;
      
      DIAG_CH2_DATA     : in std_logic_vector(27 downto 0);      
      DIAG_CH2_DVAL     : in std_logic;
      
      DIAG_CH3_DATA     : in std_logic_vector(27 downto 0);      
      DIAG_CH3_DVAL     : in std_logic;
      
      DIAG_MODE_EN      : out std_logic;      
      HDER_PROGRESS     : out std_logic;      
      READOUT           : out std_logic;
      
      PIX_MOSI          : out t_axi4_stream_mosi64;
      PIX_MISO          : in t_axi4_stream_miso;
      
      HDER_MOSI         : out t_axi4_lite_mosi;
      HDER_MISO         : in t_axi4_lite_miso;
      
      DISPATCH_INFO     : out img_info_type;
      
      FPA_ASSUMP_ERR    : out std_logic;
      FIFO_ERR          : out std_logic;
      SPEED_ERR         : out std_logic;
      CFG_MISMATCH      : out std_logic;
      DONE              : out std_logic; 
      
      TRIG_CTLER_STAT   : in std_logic_vector(7 downto 0)      
      );
end scd_data_dispatcher;

architecture rtl of scd_data_dispatcher is
   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component double_sync
      generic ( INIT_VALUE : bit := '0' );
      port (
         D     : in STD_LOGIC;
         Q     : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK   : in STD_LOGIC);
   end component;	    
   
   component fwft_afifo_w28_d16
      port (
         rst            : in std_logic;
         wr_clk         : in std_logic;
         rd_clk         : in std_logic;
         din            : in std_logic_vector(27 downto 0);
         wr_en          : in std_logic;
         rd_en          : in std_logic;
         dout           : out std_logic_vector(27 downto 0);
         valid          : out std_logic;
         full           : out std_logic;
         overflow       : out std_logic;
         empty          : out std_logic;
         wr_rst_busy    : out std_logic;
         rd_rst_busy    : out std_logic
         );
   end component;
   
   component fwft_sfifo_w28_d16
      port (
         clk       : in std_logic;
         srst      : in std_logic;
         din       : in std_logic_vector(27 downto 0);
         wr_en     : in std_logic;
         rd_en     : in std_logic;
         dout      : out std_logic_vector(27 downto 0);
         valid     : out std_logic;
         full      : out std_logic;
         overflow  : out std_logic;
         empty     : out std_logic
         );
   end component;
   
   component fwft_sfifo_w65_d16
      port (
         clk       : in std_logic;
         srst      : in std_logic;
         din       : in std_logic_vector(64 downto 0);
         wr_en     : in std_logic;
         rd_en     : in std_logic;
         dout      : out std_logic_vector(64 downto 0);
         valid     : out std_logic;
         full      : out std_logic;
         overflow  : out std_logic;
         empty     : out std_logic
         );
   end component;
   
   component fwft_sfifo_w3_d16
      port (
         clk         : in std_logic;
         srst        : in std_logic;
         din         : in std_logic_vector(2 downto 0);
         wr_en       : in std_logic;
         rd_en       : in std_logic;
         dout        : out std_logic_vector(2 downto 0);
         full        : out std_logic;
         almost_full : out std_logic;
         overflow    : out std_logic;
         empty       : out std_logic;
         valid       : out std_logic
         );
   end component;   
   
   component axis_32_to_64_wrap
      port(
         ARESETN        : in  std_logic;
         CLK            : in  std_logic;      
         
         RX_MOSI        : in  t_axi4_stream_mosi32;
         RX_MISO        : out t_axi4_stream_miso;
         
         TX_MOSI        : out t_axi4_stream_mosi64;
         TX_MISO        : in  t_axi4_stream_miso
         );
   end component;

   type mode_fsm_type is (idle, wait_fpa_fval_st, wait_diag_fval_st);
   type fast_hder_sm_type is (idle, send_hder_st, wait_acq_hder_st);                   
   type pix_out_sm_type is (idle, send_pix_st); 
   type frame_fsm_type is (init_st, idle, wait_fpa_fval_st, wait_diag_fval_st);
   type byte_array is array (0 to 3) of std_logic_vector(7 downto 0);
   
   signal mode_fsm                     : mode_fsm_type;
   signal fast_hder_sm                 : fast_hder_sm_type;
   signal pix_out_sm                   : pix_out_sm_type;
   signal frame_fsm                    : frame_fsm_type;      
   signal sreset                       : std_logic;
   signal sresetn                      : std_logic;
   signal real_data_mode               : std_logic;
   signal diag_mode_en_i               : std_logic;
   signal fpa_fifo_dval                : std_logic;
   signal diag_fifo_dval               : std_logic;
   signal fpa_ch1_fifo_dval            : std_logic;
   signal fpa_ch2_fifo_dval            : std_logic;
   signal fpa_ch3_fifo_dval            : std_logic;
   signal diag_ch1_fifo_dval           : std_logic;
   signal diag_ch2_fifo_dval           : std_logic;
   signal diag_ch3_fifo_dval           : std_logic;
   signal fpa_pix1_data                : std_logic_vector(15 downto 0);
   signal fpa_ch1_fifo_dout            : std_logic_vector(27 downto 0);
   signal fpa_pix2_data                : std_logic_vector(15 downto 0);
   signal fpa_ch2_fifo_dout            : std_logic_vector(27 downto 0);
   signal fpa_pix3_data                : std_logic_vector(15 downto 0);
   signal fpa_ch3_fifo_dout            : std_logic_vector(27 downto 0);
   signal fpa_pix4_data                : std_logic_vector(15 downto 0);
   signal fpa_header                   : std_logic;
   signal fpa_lval                     : std_logic;
   signal fpa_dval                     : std_logic;
   signal acq_hder_last                : std_logic;
   signal fpa_fval                     : std_logic;
   signal fpa_fval_last                : std_logic;                                                                         
   signal diag_pix1_data               : std_logic_vector(15 downto 0);                                                     
   signal diag_ch1_fifo_dout           : std_logic_vector(27 downto 0);
   signal diag_pix2_data               : std_logic_vector(15 downto 0);
   signal diag_ch2_fifo_dout           : std_logic_vector(27 downto 0); 
   signal diag_pix3_data               : std_logic_vector(15 downto 0);
   signal diag_ch3_fifo_dout           : std_logic_vector(27 downto 0);
   signal diag_pix4_data               : std_logic_vector(15 downto 0);
   signal diag_header                  : std_logic;
   signal diag_lval                    : std_logic;
   signal diag_dval                    : std_logic;
   signal diag_fval                    : std_logic;
   signal fpa_ch2_header               : std_logic; 
   signal fpa_ch3_header               : std_logic;
   signal fpa_fifo_rd                  : std_logic;
   signal fpa_ch1_fifo_ovfl            : std_logic;
   signal fpa_ch2_fifo_ovfl            : std_logic;
   signal fpa_ch3_fifo_ovfl            : std_logic;
   signal diag_fifo_rd                 : std_logic;
   signal diag_ch1_fifo_ovfl           : std_logic;
   signal diag_ch2_fifo_ovfl           : std_logic;
   signal diag_ch3_fifo_ovfl           : std_logic;
   signal acq_hder_fifo_din            : std_logic_vector(64 downto 0);
   signal acq_hder_fifo_wr             : std_logic;
   signal acq_hder_fifo_rd             : std_logic;
   signal acq_hder_fifo_dout           : std_logic_vector(64 downto 0);
   signal acq_hder_fifo_dval           : std_logic;
   signal acq_hder_fifo_ovfl           : std_logic;
   signal acq_int_last                 : std_logic;
   signal acq_eof                      : std_logic;
   signal readout_i                    : std_logic;
   signal acq_hder                     : std_logic;
   signal frame_id_i                   : std_logic_vector(31 downto 0);
   signal fpa_acq_eof                  : std_logic;
   signal diag_img_dval                : std_logic;
   signal diag_hder_dval               : std_logic;
   signal diag_acq_eof                 : std_logic;
   signal fpa_hder_assump_err          : std_logic;
   signal fpa_int_time_assump_err      : std_logic;
   signal fpa_gain_assump_err          : std_logic;
   signal fpa_mode_assump_err          : std_logic;
   signal pix_dval_i                   : std_logic;
   signal pix_dval_temp                : std_logic;
   signal pix_data_i                   : std_logic_vector(63 downto 0);
   signal pix1_data_temp               : std_logic_vector(15 downto 0);
   signal pix2_data_temp               : std_logic_vector(15 downto 0);
   signal pix3_data_temp               : std_logic_vector(15 downto 0);
   signal pix4_data_temp               : std_logic_vector(15 downto 0);
   signal fpa_pix_max                  : unsigned(15 downto 0);
   signal fpa_temp_reg_dval            : std_logic;
   signal hder_cnt                     : unsigned(7 downto 0) := (others => '0');
   signal int_time_mismatch            : std_logic;
   signal xsize_mismatch               : std_logic;
   signal ysize_mismatch               : std_logic;
   signal gain_mismatch                : std_logic;
   signal fpa_temp_pos                 : unsigned(15 downto 0);
   signal fpa_temp_neg                 : unsigned(15 downto 0);
   signal fpa_ysize                    : unsigned(FPA_INTF_CFG.SCD_OP.SCD_YSIZE'LENGTH-1 downto 0);
   signal fpa_xsize                    : unsigned(FPA_INTF_CFG.SCD_OP.SCD_XSIZE'LENGTH-1 downto 0);
   signal fpa_temp_reg                 : std_logic_vector(15 downto 0);
   signal fpa_gain                     : std_logic_vector(FPA_INTF_CFG.SCD_OP.SCD_GAIN'LENGTH-1 downto 0);
   signal fpa_temp_i                   : fpa_temp_stat_type;
   signal fpa_int_mode                 : std_logic_vector(SCD_ITR'range);
   signal diag_header_last             : std_logic;
   signal fpa_header_last              : std_logic;
   signal hder_mosi_i                  : t_axi4_lite_mosi;
   signal pix_mosi_i, pix_mosi_temp    : t_axi4_stream_mosi64;
   signal pix_mosi32                   : t_axi4_stream_mosi32;
   signal pix_miso32                   : t_axi4_stream_miso;
   signal pix_link_rdy                 : std_logic;
   signal hder_link_rdy                : std_logic;
   signal acq_eof_pipe                 : std_logic_vector(2 downto 0);
   signal dispatch_info_i              : img_info_type;
   signal hder_param                   : hder_param_type;
   signal hcnt                         : unsigned(7 downto 0);
   signal hder_in_progress_i           : std_logic;
   signal acq_finge_assump_err         : std_logic;
   signal int_indx_i                   : std_logic_vector(7 downto 0);
   signal fpa_ch1_fifo_ovfl_sync       : std_logic;
   signal fpa_ch2_fifo_ovfl_sync       : std_logic; 
   signal fpa_ch3_fifo_ovfl_sync       : std_logic;
   signal acq_eof_i                    : std_logic;
   signal frame_start_id               : std_logic_vector(7 downto 0);
   signal last_cmd_id                  : std_logic_vector(15 downto 0);
   signal byte_18                      : std_logic_vector(7 downto 0);
   signal byte_19                      : std_logic_vector(7 downto 0);
   signal byte_20                      : std_logic_vector(7 downto 0);
   
   signal int_fifo_rd                  : std_logic;
   signal int_fifo_din                 : std_logic_vector(2 downto 0) := (others => '0'); -- non utilisé
   signal int_fifo_wr                  : std_logic;
   signal int_fifo_dval                : std_logic;
   signal int_fifo_dval_last           : std_logic;
   signal int_fifo_dout                : std_logic_vector(2 downto 0);

   signal true_fpa_int_i               : std_logic;
   signal true_fpa_int_last            : std_logic;
   signal true_fpa_int_re              : std_logic;
   signal itr_int_fifo_wr              : std_logic;
   signal iwr_int_fifo_wr1             : std_logic;
   signal iwr_int_fifo_wr2             : std_logic;
   
   signal int_time_i                   : unsigned(FPA_INTF_CFG.SCD_INT.SCD_INT_TIME 'LENGTH-1 downto 0);
   constant HDR_SEND_CLK_DELAY         : integer := 6;
   signal exp_dval_pipe                : std_logic_vector(HDR_SEND_CLK_DELAY -1 downto 0) := (others => '0');
   signal int_time_100MHz_dval         : std_logic;
   
   signal acq_mode_first_int           : std_logic; 
   signal nacq_mode_first_int          : std_logic;
   signal acq_mode                     : std_logic;
   signal fpa_trig_pipe                : std_logic_vector(1 downto 0); 
   signal int_fifo_wr_source_i         : std_logic;
      
--  attribute keep                                   : string;
--  attribute keep of mode_fsm                       : signal is "true";
--  attribute keep of fast_hder_sm                   : signal is "true";
--  attribute keep of pix_out_sm                     : signal is "true";
--  attribute keep of frame_fsm                      : signal is "true"; 
--  attribute keep of acq_hder_fifo_wr               : signal is "true";
--  attribute keep of acq_hder_fifo_rd               : signal is "true";
--  attribute keep of acq_hder_fifo_dval             : signal is "true";                       
--  attribute keep of int_fifo_wr                    : signal is "true";
--  attribute keep of int_fifo_rd                    : signal is "true";
--  attribute keep of int_fifo_dval                  : signal is "true";    
--  attribute keep of diag_ch1_fifo_dval             : signal is "true";
--  attribute keep of diag_ch2_fifo_dval             : signal is "true";
--  attribute keep of diag_ch3_fifo_dval             : signal is "true";  
--  attribute keep of diag_fifo_rd                   : signal is "true";  
--  attribute keep of diag_fifo_dval                 : signal is "true";
--  attribute keep of fpa_fifo_dval                  : signal is "true";
--  attribute keep of fpa_fifo_rd                    : signal is "true";
--  attribute keep of hder_link_rdy                  : signal is "true";
--  attribute keep of diag_mode_en_i                 : signal is "true";
--  attribute keep of readout_i                      : signal is "true";
--  attribute keep of acq_mode                       : signal is "true";
--  attribute keep of acq_mode_first_int             : signal is "true";
--  attribute keep of nacq_mode_first_int            : signal is "true"; 
--  attribute keep of diag_header                    : signal is "true";
--  attribute keep of diag_fval                      : signal is "true";
--  attribute keep of diag_lval                      : signal is "true";  
--  attribute keep of diag_dval                      : signal is "true";
--  attribute keep of fpa_header                     : signal is "true";
--  attribute keep of fpa_fval                       : signal is "true";
--  attribute keep of fpa_lval                       : signal is "true";  
--  attribute keep of fpa_dval                       : signal is "true";  
--  attribute keep of int_fifo_wr_source_i           : signal is "true";
--  attribute keep of pix_mosi_i                     : signal is "true";
  
 
begin

   HDER_MOSI <= hder_mosi_i;
   DISPATCH_INFO <= dispatch_info_i;
   
   READOUT <= readout_i;
   DIAG_MODE_EN <= diag_mode_en_i; 
   hder_link_rdy <= HDER_MISO.WREADY and HDER_MISO.AWREADY;
   
   fpa_fifo_dval <= fpa_ch1_fifo_dval and fpa_ch2_fifo_dval and fpa_ch3_fifo_dval;     -- il le faut pour s'assurer de la synchron des 3 canaux avant de lire le fifo
   diag_fifo_dval <= diag_ch1_fifo_dval and diag_ch2_fifo_dval and diag_ch3_fifo_dval;  -- il le faut pour s'assurer de la synchron des 3 canaux avant de lire le fifo
   
   -- lecture des fifos FPA (toujours laisser en combinatoire pour eviter des bugs)          
   fpa_fifo_rd <= fpa_ch1_fifo_dval and fpa_ch2_fifo_dval and fpa_ch3_fifo_dval; -- lecture synchronisée des 3 fifos tout le temps.        
   -- lecture des fifos DIAG           
   diag_fifo_rd <= diag_ch1_fifo_dval and diag_ch2_fifo_dval and diag_ch3_fifo_dval; -- lecture synchronisée des 3 fifos tout le temps.        
   
   acq_mode_first_int <= TRIG_CTLER_STAT(5);
   acq_mode <= TRIG_CTLER_STAT(4);
   nacq_mode_first_int <= TRIG_CTLER_STAT(1);
   
   ------------------------------------------------------
   -- decodage données sortant du fifo en mode fpa
   ------------------------------------------------------
   fpa_pix1_data(0)  <= fpa_ch1_fifo_dout(0);
   fpa_pix1_data(1)  <= fpa_ch1_fifo_dout(1);
   fpa_pix1_data(2)  <= fpa_ch1_fifo_dout(2);
   fpa_pix1_data(3)  <= fpa_ch1_fifo_dout(3);
   fpa_pix1_data(4)  <= fpa_ch1_fifo_dout(4);
   fpa_pix1_data(5)  <= fpa_ch1_fifo_dout(6);
   fpa_pix1_data(6)  <= fpa_ch1_fifo_dout(27);
   fpa_pix1_data(7)  <= fpa_ch1_fifo_dout(5);
   fpa_pix1_data(8)  <= fpa_ch1_fifo_dout(7);
   fpa_pix1_data(9)  <= fpa_ch1_fifo_dout(8);
   fpa_pix1_data(10) <= fpa_ch1_fifo_dout(9);
   fpa_pix1_data(11) <= fpa_ch1_fifo_dout(12);
   fpa_pix1_data(12) <= fpa_ch1_fifo_dout(13);
   fpa_pix1_data(13) <= fpa_ch1_fifo_dout(14);
   fpa_pix1_data(14) <= fpa_ch1_fifo_dout(10);
   fpa_pix1_data(15) <= fpa_ch1_fifo_dout(11);
   fpa_header        <= fpa_ch1_fifo_dout(23); -- Header pris sur canal 1 uniquement (on suppose que les données sont synchronisées sur les deux canaux)
   fpa_lval          <= fpa_ch1_fifo_dout(24);  -- Lval pris sur canal 1 uniquement
   fpa_fval          <= fpa_ch1_fifo_dout(25);  -- Fval pris sur canal 1 uniquement
   fpa_dval          <= fpa_ch1_fifo_dout(26);  -- Dval pris sur canal 1 uniquement
   
   fpa_pix2_data(0)  <= fpa_ch1_fifo_dout(15);
   fpa_pix2_data(1)  <= fpa_ch1_fifo_dout(18);
   fpa_pix2_data(2)  <= fpa_ch1_fifo_dout(19);
   fpa_pix2_data(3)  <= fpa_ch1_fifo_dout(20);
   fpa_pix2_data(4)  <= fpa_ch1_fifo_dout(21);
   fpa_pix2_data(5)  <= fpa_ch1_fifo_dout(22);
   fpa_pix2_data(6)  <= fpa_ch1_fifo_dout(16);
   fpa_pix2_data(7)  <= fpa_ch1_fifo_dout(17);
   fpa_pix2_data(8)  <= fpa_ch2_fifo_dout(0);
   fpa_pix2_data(9)  <= fpa_ch2_fifo_dout(1);
   fpa_pix2_data(10) <= fpa_ch2_fifo_dout(2);
   fpa_pix2_data(11) <= fpa_ch2_fifo_dout(3);
   fpa_pix2_data(12) <= fpa_ch2_fifo_dout(4);
   fpa_pix2_data(13) <= fpa_ch2_fifo_dout(6);
   fpa_pix2_data(14) <= fpa_ch2_fifo_dout(27);
   fpa_pix2_data(15) <= fpa_ch2_fifo_dout(5);
   fpa_ch2_header    <= fpa_ch2_fifo_dout(23); -- Header du canal 2 pour fin de generation d'erreur seulement

   fpa_pix3_data(0)  <= fpa_ch2_fifo_dout(7);
   fpa_pix3_data(1)  <= fpa_ch2_fifo_dout(8);
   fpa_pix3_data(2)  <= fpa_ch2_fifo_dout(9);
   fpa_pix3_data(3)  <= fpa_ch2_fifo_dout(12);
   fpa_pix3_data(4)  <= fpa_ch2_fifo_dout(13);
   fpa_pix3_data(5)  <= fpa_ch2_fifo_dout(14);
   fpa_pix3_data(6)  <= fpa_ch2_fifo_dout(10);
   fpa_pix3_data(7)  <= fpa_ch2_fifo_dout(11);
   fpa_pix3_data(8)  <= fpa_ch2_fifo_dout(15);
   fpa_pix3_data(9)  <= fpa_ch2_fifo_dout(18);
   fpa_pix3_data(10) <= fpa_ch2_fifo_dout(19);
   fpa_pix3_data(11) <= fpa_ch2_fifo_dout(20);
   fpa_pix3_data(12) <= fpa_ch2_fifo_dout(21);
   fpa_pix3_data(13) <= fpa_ch2_fifo_dout(22);
   fpa_pix3_data(14) <= fpa_ch2_fifo_dout(16);
   fpa_pix3_data(15) <= fpa_ch2_fifo_dout(17);
   
   fpa_pix4_data(0)  <= fpa_ch3_fifo_dout(0);
   fpa_pix4_data(1)  <= fpa_ch3_fifo_dout(1);
   fpa_pix4_data(2)  <= fpa_ch3_fifo_dout(2);
   fpa_pix4_data(3)  <= fpa_ch3_fifo_dout(3);
   fpa_pix4_data(4)  <= fpa_ch3_fifo_dout(4);
   fpa_pix4_data(5)  <= fpa_ch3_fifo_dout(6);
   fpa_pix4_data(6)  <= fpa_ch3_fifo_dout(27);
   fpa_pix4_data(7)  <= fpa_ch3_fifo_dout(5);
   fpa_pix4_data(8)  <= fpa_ch3_fifo_dout(7);
   fpa_pix4_data(9)  <= fpa_ch3_fifo_dout(8);
   fpa_pix4_data(10) <= fpa_ch3_fifo_dout(9);
   fpa_pix4_data(11) <= fpa_ch3_fifo_dout(12);
   fpa_pix4_data(12) <= fpa_ch3_fifo_dout(13);
   fpa_pix4_data(13) <= fpa_ch3_fifo_dout(14);
   fpa_pix4_data(14) <= fpa_ch3_fifo_dout(10);
   fpa_pix4_data(15) <= fpa_ch3_fifo_dout(11);
   fpa_ch3_header    <= fpa_ch3_fifo_dout(23); -- Header du canal 3 pour fin de generation d'erreur seulement
  
   
   ----------------------------------------------------
   -- decodage données sortant du fifo en mode diag
   ----------------------------------------------------
   diag_pix1_data(0)  <= diag_ch1_fifo_dout(0);
   diag_pix1_data(1)  <= diag_ch1_fifo_dout(1);
   diag_pix1_data(2)  <= diag_ch1_fifo_dout(2);
   diag_pix1_data(3)  <= diag_ch1_fifo_dout(3);
   diag_pix1_data(4)  <= diag_ch1_fifo_dout(4);
   diag_pix1_data(5)  <= diag_ch1_fifo_dout(6);
   diag_pix1_data(6)  <= diag_ch1_fifo_dout(27);
   diag_pix1_data(7)  <= diag_ch1_fifo_dout(5);
   diag_pix1_data(8)  <= diag_ch1_fifo_dout(7);
   diag_pix1_data(9)  <= diag_ch1_fifo_dout(8);
   diag_pix1_data(10) <= diag_ch1_fifo_dout(9);
   diag_pix1_data(11) <= diag_ch1_fifo_dout(12);
   diag_pix1_data(12) <= diag_ch1_fifo_dout(13);
   diag_pix1_data(13) <= diag_ch1_fifo_dout(14);
   diag_pix1_data(14) <= diag_ch1_fifo_dout(10);
   diag_pix1_data(15) <= diag_ch1_fifo_dout(11);
   diag_header        <= diag_ch1_fifo_dout(23); -- Header
   diag_lval          <= diag_ch1_fifo_dout(24);  -- Lval
   diag_fval          <= diag_ch1_fifo_dout(25);  -- Fval
   diag_dval          <= diag_ch1_fifo_dout(26);  -- Dval 
   
   diag_pix2_data(0)  <= diag_ch1_fifo_dout(15);
   diag_pix2_data(1)  <= diag_ch1_fifo_dout(18);
   diag_pix2_data(2)  <= diag_ch1_fifo_dout(19);
   diag_pix2_data(3)  <= diag_ch1_fifo_dout(20);
   diag_pix2_data(4)  <= diag_ch1_fifo_dout(21);
   diag_pix2_data(5)  <= diag_ch1_fifo_dout(22);
   diag_pix2_data(6)  <= diag_ch1_fifo_dout(16);
   diag_pix2_data(7)  <= diag_ch1_fifo_dout(17);
   diag_pix2_data(8)  <= diag_ch2_fifo_dout(0);
   diag_pix2_data(9)  <= diag_ch2_fifo_dout(1);
   diag_pix2_data(10) <= diag_ch2_fifo_dout(2);
   diag_pix2_data(11) <= diag_ch2_fifo_dout(3);
   diag_pix2_data(12) <= diag_ch2_fifo_dout(4);
   diag_pix2_data(13) <= diag_ch2_fifo_dout(6);
   diag_pix2_data(14) <= diag_ch2_fifo_dout(27);
   diag_pix2_data(15) <= diag_ch2_fifo_dout(5);
    
   diag_pix3_data(0)  <= diag_ch2_fifo_dout(7);
   diag_pix3_data(1)  <= diag_ch2_fifo_dout(8);
   diag_pix3_data(2)  <= diag_ch2_fifo_dout(9);
   diag_pix3_data(3)  <= diag_ch2_fifo_dout(12);
   diag_pix3_data(4)  <= diag_ch2_fifo_dout(13);
   diag_pix3_data(5)  <= diag_ch2_fifo_dout(14);
   diag_pix3_data(6)  <= diag_ch2_fifo_dout(10);
   diag_pix3_data(7)  <= diag_ch2_fifo_dout(11);
   diag_pix3_data(8)  <= diag_ch2_fifo_dout(15);
   diag_pix3_data(9)  <= diag_ch2_fifo_dout(18);
   diag_pix3_data(10) <= diag_ch2_fifo_dout(19);
   diag_pix3_data(11) <= diag_ch2_fifo_dout(20);
   diag_pix3_data(12) <= diag_ch2_fifo_dout(21);
   diag_pix3_data(13) <= diag_ch2_fifo_dout(22);
   diag_pix3_data(14) <= diag_ch2_fifo_dout(16);
   diag_pix3_data(15) <= diag_ch2_fifo_dout(17);
    
   diag_pix4_data(0)  <= diag_ch3_fifo_dout(0);
   diag_pix4_data(1)  <= diag_ch3_fifo_dout(1);
   diag_pix4_data(2)  <= diag_ch3_fifo_dout(2);
   diag_pix4_data(3)  <= diag_ch3_fifo_dout(3);
   diag_pix4_data(4)  <= diag_ch3_fifo_dout(4);
   diag_pix4_data(5)  <= diag_ch3_fifo_dout(6);
   diag_pix4_data(6)  <= diag_ch3_fifo_dout(27);
   diag_pix4_data(7)  <= diag_ch3_fifo_dout(5);
   diag_pix4_data(8)  <= diag_ch3_fifo_dout(7);
   diag_pix4_data(9)  <= diag_ch3_fifo_dout(8);
   diag_pix4_data(10) <= diag_ch3_fifo_dout(9);
   diag_pix4_data(11) <= diag_ch3_fifo_dout(12);
   diag_pix4_data(12) <= diag_ch3_fifo_dout(13);
   diag_pix4_data(13) <= diag_ch3_fifo_dout(14);
   diag_pix4_data(14) <= diag_ch3_fifo_dout(10);
   diag_pix4_data(15) <= diag_ch3_fifo_dout(11);
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   sresetn <= not sreset;
   --------------------------------------------------
   -- double sync 
   --------------------------------------------------   
   U1A: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => fpa_ch1_fifo_ovfl, CLK => CLK, Q => fpa_ch1_fifo_ovfl_sync);
   U1B: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => fpa_ch2_fifo_ovfl, CLK => CLK, Q => fpa_ch2_fifo_ovfl_sync);
   U1C: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => fpa_ch3_fifo_ovfl, CLK => CLK, Q => fpa_ch3_fifo_ovfl_sync);
   
   sgen_pelican_or_hercule : if (IsBlackbird1280D = '0') generate
   begin  

      diag_ch3_fifo_dout <= (others => '0');
      diag_ch3_fifo_dval <= '1';
      diag_ch3_fifo_ovfl <= '0'; 
      
      fpa_ch3_fifo_dout <= (others => '0');
      fpa_ch3_fifo_dval <= '1';  
      fpa_ch3_fifo_ovfl <= '0'; 
      
      pix_mosi32.tvalid <= pix_mosi_i.tvalid;
      pix_mosi32.tdata  <= pix_mosi_i.tdata(31 downto 0);
      pix_mosi32.tstrb  <= pix_mosi_i.tstrb(3 downto 0);
      pix_mosi32.tkeep  <= pix_mosi_i.tkeep(3 downto 0); 
      pix_mosi32.tlast  <= pix_mosi_i.tlast;
      pix_mosi32.tid    <= pix_mosi_i.tid; 
      pix_mosi32.tdest  <= pix_mosi_i.tdest;
      pix_mosi32.tuser  <= pix_mosi_i.tuser(7 downto 0);
      pix_link_rdy      <= pix_miso32.tready;
      
      U2 : axis_32_to_64_wrap
      port map (
      ARESETN => sresetn,
      CLK     => CLK,
      RX_MOSI => pix_mosi32,      
      RX_MISO => pix_miso32,       
      
      TX_MOSI => PIX_MOSI,       
      TX_MISO => PIX_MISO       
      ); 
      
      -- Pelican & Hercule : integration N always start before the readout N-1 and there is an integration feedback from the proxy.
      int_fifo_wr_source_i <= FPA_INT;
      
   end generate;
   sgen_bb1280 : if (IsBlackbird1280D = '1') generate
   begin 
      
      --------------------------------------------------
      -- fifo fwft FPA_CH3_DATA 
      -------------------------------------------------- 
      U3C : fwft_afifo_w28_d16
      port map (
         rst => FPA_CH3_RST,
         wr_clk => FPA_CH3_CLK,
         rd_clk => CLK,
         din => FPA_CH3_DATA,
         wr_en => FPA_CH3_DVAL,
         rd_en => fpa_fifo_rd,
         dout => fpa_ch3_fifo_dout,
         valid  => fpa_ch3_fifo_dval,
         full => open,
         overflow => fpa_ch3_fifo_ovfl,
         empty => open,
         wr_rst_busy => open,
         rd_rst_busy => open
      );
      --------------------------------------------------
      -- fifo fwft DIAG_CH3_DATA 
      --------------------------------------------------
      U4C : fwft_afifo_w28_d16
      port map (
         rst => ARESET,
         wr_clk => FPA_DIAG_CLK, 
         rd_clk => CLK, 
         din => DIAG_CH3_DATA,
         wr_en => DIAG_CH3_DVAL,
         rd_en => diag_fifo_rd,
         dout => diag_ch3_fifo_dout,
         valid  => diag_ch3_fifo_dval,
         full => open,
         overflow => diag_ch3_fifo_ovfl,
         empty => open,
         wr_rst_busy => open,
         rd_rst_busy => open
      );
      
      PIX_MOSI      <= pix_mosi_i;
      pix_link_rdy  <= PIX_MISO.TREADY; 
      
      -- BB1280 : integration N can start after the readout N-1 and there is no integration feedback from the proxy. 
      -- We use the trig signal instead of the integration one. 
      U2: process(CLK)
      begin          
         if rising_edge(CLK) then 
            if sreset = '1' then
               fpa_trig_pipe <= (others => '0');
               int_fifo_wr_source_i <= '0';
            else
               fpa_trig_pipe(0)       <= FPA_TRIG;      
               fpa_trig_pipe(1)       <= fpa_trig_pipe(0);
               int_fifo_wr_source_i   <= fpa_trig_pipe(1);   
            end if;         
         end if;
      end process;
   end generate;  

   --------------------------------------------------
   -- fifo fwft FPA_CH1_DATA 
   -------------------------------------------------- 
   U3A : fwft_afifo_w28_d16
   port map (
      rst => FPA_CH1_RST,
      wr_clk => FPA_CH1_CLK,
      rd_clk => CLK,
      din => FPA_CH1_DATA,
      wr_en => FPA_CH1_DVAL,
      rd_en => fpa_fifo_rd,
      dout => fpa_ch1_fifo_dout,
      valid  => fpa_ch1_fifo_dval,
      full => open,
      overflow => fpa_ch1_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
   
   --------------------------------------------------
   -- fifo fwft FPA_CH2_DATA 
   -------------------------------------------------- 
   U3B : fwft_afifo_w28_d16
   port map (
      rst => FPA_CH2_RST,
      wr_clk => FPA_CH2_CLK,
      rd_clk => CLK,
      din => FPA_CH2_DATA,
      wr_en => FPA_CH2_DVAL,
      rd_en => fpa_fifo_rd,
      dout => fpa_ch2_fifo_dout,
      valid  => fpa_ch2_fifo_dval,
      full => open,
      overflow => fpa_ch2_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
      
   -------------------------------------------------
   -- fifo fwft DIAG_CH0_DATA 
   -------------------------------------------------- 
   U4A : fwft_afifo_w28_d16
   port map (
      rst => ARESET,                                           
      wr_clk => FPA_DIAG_CLK, 
      rd_clk => CLK,     
      din => DIAG_CH1_DATA,                                        
      wr_en => DIAG_CH1_DVAL,                        
      rd_en => diag_fifo_rd,                         
      dout => diag_ch1_fifo_dout,                    
      valid  => diag_ch1_fifo_dval,                  
      full => open,                                  
      overflow => diag_ch1_fifo_ovfl,                
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open                                  
      );                                             
   
   --------------------------------------------------
   -- fifo fwft DIAG_CH2_DATA 
   --------------------------------------------------
   U4B : fwft_afifo_w28_d16
   port map (
      rst => ARESET,
      wr_clk => FPA_DIAG_CLK, 
      rd_clk => CLK, 
      din => DIAG_CH2_DATA,
      wr_en => DIAG_CH2_DVAL,
      rd_en => diag_fifo_rd,
      dout => diag_ch2_fifo_dout,
      valid  => diag_ch2_fifo_dval,
      full => open,
      overflow => diag_ch2_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
      
   --------------------------------------------------
   -- fifo fwft pour acq fringe et l'index de intTime
   --------------------------------------------------
   U5 : fwft_sfifo_w65_d16
   port map (
      srst => sreset,
      clk => CLK,
      din => acq_hder_fifo_din,
      wr_en => acq_hder_fifo_wr,
      rd_en => acq_hder_fifo_rd,
      dout => acq_hder_fifo_dout,
      valid  => acq_hder_fifo_dval,
      full => open,
      overflow => acq_hder_fifo_ovfl,
      empty => open
      );
   
      
   --------------------------------------------------
   -- fifo fwft pour edge de l'intégration
   --------------------------------------------------
   U6 : fwft_sfifo_w3_d16
   port map (
      clk         => CLK,
      srst        => sreset,
      din         => int_fifo_din,    
      wr_en       => int_fifo_wr,
      rd_en       => int_fifo_rd,
      dout        => int_fifo_dout,   
      full        => open,
      almost_full => open,
      overflow    => open,
      empty       => open,
      valid       => int_fifo_dval
      );
      
   -------------------------------------------------------------------
   -- generation de acq_hder et stockage dans un fifo fwft  
   -------------------------------------------------------------------   
   -- il faut ecrire dans un fifo fwft le FRAME_ID, que lorsque l'image est prise avec ACQ_TRIG (image à envoyer dans la chaine) 
   -- a) Fifo vide pendant qu'une image rentre dans le présent module => image à ne pas envoyer dans la chaine
   -- b) Fifo contient une donnée pendant qu'une image rentre => image à envoyer dans la chaine avec FRAME_ID contenu dans le fifo
   U7: process(CLK)
   begin          
      if rising_edge(CLK) then         
         if sreset = '1' then 
            frame_fsm <= init_st;
            acq_hder_fifo_wr <= '0';
            acq_hder_fifo_rd <= '0';
            acq_hder <= '0';
            readout_i <= '0';
            acq_finge_assump_err <= '0';
            
            int_fifo_wr <= '0';
            int_fifo_rd <= '0';
            true_fpa_int_i    <= '0';
            true_fpa_int_last <= '0'; 
            true_fpa_int_re   <= '0'; 
            itr_int_fifo_wr  <= '0';
            iwr_int_fifo_wr1 <= '0';
            iwr_int_fifo_wr2 <= '0';
            
         else         
            
            acq_int_last <= ACQ_INT;
            
            -- ecriture de FRAME_ID dans le acq fringe fifo
            acq_hder_fifo_din <= INT_INDX & INT_TIME & FRAME_ID; -- le frame_id est écrit dans le fifo que s'il s'agit d'une image à envoyer dans la chaine
            acq_hder_fifo_wr <= not acq_int_last and ACQ_INT;
            
            -- ecriture du data fifo
            true_fpa_int_i    <= int_fifo_wr_source_i; 
            true_fpa_int_last <= true_fpa_int_i;
            true_fpa_int_re   <= (not true_fpa_int_last and true_fpa_int_i);
            
            itr_int_fifo_wr   <= true_fpa_int_re and acq_mode and not FPA_INTF_CFG.scd_op.scd_int_mode(0);                                 -- en mode itr, on ecrit les RE des true_fpa_acq_int dans le fifo
            iwr_int_fifo_wr1  <= true_fpa_int_re and acq_mode and not acq_mode_first_int and FPA_INTF_CFG.scd_op.scd_int_mode(0);  -- en mode iwr, on ecrit les RE des true_fpa_acq_int dans le fifo, sauf le premier
            iwr_int_fifo_wr2  <= true_fpa_int_re and nacq_mode_first_int and FPA_INTF_CFG.scd_op.scd_int_mode(0);              -- en mode iwr, on ecrit le RE de l'integration resultant du premier xtra_trig/prog_trig.
            
            int_fifo_wr <= itr_int_fifo_wr or iwr_int_fifo_wr1 or iwr_int_fifo_wr2;
            
            
            -- generation de acq_hder et readout_i
            case frame_fsm is 
               
               when init_st => -- cet état est celui d'une verification des conditions initiales pour que la fsm marche comme prévu
                  if acq_hder_fifo_dval = '0' then 
                     if fpa_fval = '0' and  diag_fval = '0' then 
                        frame_fsm <= idle;
                     end if;
                  else                     
                     acq_finge_assump_err <= '1'; -- erreur grave s'il y a déjà qque chose dans le fifo juste après un reset
                  end if;
               
               when idle =>
                  acq_hder_fifo_rd <= '0';
                  int_fifo_rd <= '0';
                  readout_i <= '0';
                  acq_hder <= acq_hder_fifo_dval; -- ACQ_INT de l'image k vient toujours avant le readout de l'image k. Ainsi le fifo contiendra une donnée avant le readout si l'image est à envoyer dans la chaine. 
                  if acq_hder_fifo_dval = '1' then  
                     frame_id_i <= acq_hder_fifo_dout(31 downto 0);
                     int_time_i <= unsigned(acq_hder_fifo_dout(56 downto 32));
                     int_indx_i <= acq_hder_fifo_dout(64 downto 57);
                  else
                     frame_id_i <= FRAME_ID; -- id farfelue d'une extra_fringe provenant du module hw_driver (de toute façon, non envoyée dans la chaine)
                  end if;
                  
                  if real_data_mode = '1' then 
                     if fpa_fval = '1' then     -- en quittant idle, frame_id_i et acq_hder sont implicitement latchés, donc pas besoin de latchs explicites
                        frame_fsm <= wait_fpa_fval_st;
                        acq_hder_fifo_rd <= int_fifo_dval; -- mis à jour de la sortie du fwft pour le prochain frame
                        readout_i <= '1'; -- signal de readout, à sortir même en mode xtra_trig 
                     end if;
                  else
                     if diag_fval = '1' then
                        frame_fsm <= wait_diag_fval_st;
                        acq_hder_fifo_rd <= int_fifo_dval; -- mis à jour de la sortie du fwft pour le prochain frame
                        readout_i <= '1'; -- signal de readout, à sortir même en mode xtra_trig
                     end if;
                  end if;
               
               when wait_fpa_fval_st =>
                  acq_hder_fifo_rd <= '0';
                  if fpa_fval = '0' then
                     readout_i <= '0';
                     if acq_hder = '1' and int_fifo_dval = '1' then
                        acq_hder <= '0';
                        int_fifo_rd <= '1';
                     end if;
                     frame_fsm <= idle;
                  end if;
               
               when wait_diag_fval_st =>
                  acq_hder_fifo_rd <= '0';
                  if diag_fval = '0' then
                     readout_i <= '0'; 
                     if acq_hder = '1' and int_fifo_dval = '1' then
                        acq_hder <= '0';
                        int_fifo_rd <= '1';
                     end if;
                     frame_fsm <= idle;
                  end if;              
               
               when others =>
               
            end case;
            
         end if;         
      end if;
   end process;
 
   -------------------------------------------------------------------
   -- gestion des differents modes
   -------------------------------------------------------------------  
   U8: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then
            real_data_mode <= '0';
            diag_mode_en_i <= '0';
            mode_fsm <= idle;
         else
            
            case mode_fsm is 
               
               when idle =>                  
                  if  FPA_INTF_CFG.COMN.FPA_DIAG_MODE = '1' then   -- mode diag
                     mode_fsm <= wait_diag_fval_st;
                  else
                     mode_fsm <= wait_fpa_fval_st;
                  end if;        
               
               when wait_diag_fval_st => -- attendre la fin de fval avant de sortir le changement de mode. Cette fin arrivera à coup sûr à cause du module en amont!
                  if diag_fval = '0' then 
                     real_data_mode <= '0';
                     diag_mode_en_i <= '1';
                     mode_fsm <= idle;
                  end if;
               
               when wait_fpa_fval_st =>  -- attendre la fin de fval avant de sortir le changement de mode. Cette fin arrivera à coup sûr à cause du module en amont!
                  if fpa_fval = '0' then 
                     real_data_mode <= '1';
                     diag_mode_en_i <= '0';
                     mode_fsm <= idle;
                  end if;
               
               when others =>                 
               
            end case;
            
         end if;         
      end if;
   end process;
   
   --------------------------------------------------
   -- dispatching données 
   --------------------------------------------------   
   --
   U9: process(CLK)
      variable fpa_pix_res_bit_shift : integer range 0 to fpa_pix_max'high;
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            fpa_acq_eof <= '0'; 
            diag_img_dval <= '0';
            diag_hder_dval <= '0';
            diag_acq_eof <= '0';
            fpa_hder_assump_err <= '0';
            diag_acq_eof <= '0';
            fpa_acq_eof <= '0';
            acq_eof <= '0';            
            
         else             
            
            int_fifo_dval_last <= int_fifo_dval;
            
            fpa_hder_assump_err <= '0';
            fpa_pix_res_bit_shift := to_integer(unsigned(FPA_INTF_CFG.scd_op.scd_pix_res));
            fpa_pix_max <= x"7FFF" srl fpa_pix_res_bit_shift;
            
            -- dispatching des données et header en mode DIAG et REEL (ou FPA)
            pix_dval_i <= pix_dval_temp;
            pix_data_i <= pix4_data_temp & pix3_data_temp & pix2_data_temp & pix1_data_temp;
            if real_data_mode = '1' then 
               pix_dval_temp <= fpa_fifo_rd and fpa_fifo_dval and not fpa_header and fpa_dval and int_fifo_dval;
               -- verify overflow on the number of bits corresponding to resolution
               if unsigned(fpa_pix1_data) > fpa_pix_max then
                  pix1_data_temp <= std_logic_vector(fpa_pix_max);
               else
                  pix1_data_temp <= fpa_pix1_data;
               end if;
               if unsigned(fpa_pix2_data) > fpa_pix_max then
                  pix2_data_temp <= std_logic_vector(fpa_pix_max);
               else
                  pix2_data_temp <= fpa_pix2_data;
               end if;
               if unsigned(fpa_pix3_data) > fpa_pix_max then
                  pix3_data_temp <= std_logic_vector(fpa_pix_max);
               else
                  pix3_data_temp <= fpa_pix3_data;
               end if;
               if unsigned(fpa_pix4_data) > fpa_pix_max then
                  pix4_data_temp <= std_logic_vector(fpa_pix_max);
               else
                  pix4_data_temp <= fpa_pix4_data;
               end if;
            else
               pix_dval_temp <= diag_fifo_rd and diag_fifo_dval and not diag_header and diag_dval and int_fifo_dval;
               pix1_data_temp <= diag_pix1_data;
               pix2_data_temp <= diag_pix2_data;
               pix3_data_temp <= diag_pix3_data;
               pix4_data_temp <= diag_pix4_data;
            end if;
                   
            -- generation de EOF (pas forcement synchro sur la derniere donnee mais ce n'est pas grave)
            fpa_acq_eof <= (int_fifo_dval_last and not int_fifo_dval) and real_data_mode;   -- generé seulement en mode non xtratrig
            diag_acq_eof <= (int_fifo_dval_last and not int_fifo_dval) and not real_data_mode; -- generé seulement en mode non xtratrig
            acq_eof <= fpa_acq_eof or diag_acq_eof;
            
         end if;
      end if;
   end process;
 
   -------------------------------------------------------------------
   -- Sorties des données
   -------------------------------------------------------------------   
   U11: process(CLK)
   begin          
      if rising_edge(CLK) then         
         if sreset = '1' then
            fast_hder_sm <= idle;
            pix_out_sm <= idle;
            diag_header_last <= diag_header;
            fpa_header_last <= fpa_header;          
            acq_hder_last <= '0';
            
            hder_mosi_i.awvalid <= '0';                
            hder_mosi_i.wvalid <= '0';
            hder_mosi_i.wstrb <= (others => '0');
            hder_mosi_i.awprot <= (others => '0');
            hder_mosi_i.arvalid <= '0';
            hder_mosi_i.bready <= '1';
            hder_mosi_i.rready <= '0';
            hder_mosi_i.arprot <= (others => '0');
            
            pix_mosi_temp.tvalid <= '0';
            pix_mosi_temp.tstrb <= (others => '0');
            pix_mosi_temp.tkeep <= (others => '0');
            pix_mosi_temp.tlast <= '0';
            pix_mosi_temp.tid <= (others => '0');   -- tid = '0' dans ce module. Le header Inserter chagrea cela plus loin dans la chaine.
            pix_mosi_temp.tdest <= (others => '0');
            pix_mosi_temp.tuser <= (others => '0'); -- pour le module fpa, tous à zeros sauf tuser qui sera definit plus bas.
            -- synthesis translate_off
            pix_mosi_temp.tuser(2) <= ('1'); -- fait expres
            -- synthesis translate_on
            
            pix_mosi_i.tvalid <= '0';
            pix_mosi_i.tstrb <= (others => '0');
            pix_mosi_i.tkeep <= (others => '0');
            pix_mosi_i.tlast <= '0';
            pix_mosi_i.tid <= (others => '0');  
            pix_mosi_i.tdest <= (others => '0');
            pix_mosi_i.tuser <= (others => '0');       
            
            acq_eof_pipe <= (others => '0');
            acq_eof_i <= '0';
            dispatch_info_i.exp_feedbk <= '0';
            dispatch_info_i.exp_info.exp_dval <= '0'; 
            
            exp_dval_pipe <= (others => '0');
         else            
            
            acq_hder_last <= acq_hder;
            
            exp_dval_pipe(0) <= acq_hder and not acq_hder_last;
            for i in 1 to HDR_SEND_CLK_DELAY-1 loop
                exp_dval_pipe(i) <= exp_dval_pipe(i-1);        
            end loop;
            
            -- pipe de eof : fait pour tenir compte des delais dans le module.
            acq_eof_pipe(0) <= acq_eof;      
            acq_eof_pipe(1) <= acq_eof_pipe(0);
            acq_eof_pipe(2) <= acq_eof_pipe(1);
            acq_eof_i <= acq_eof_pipe(2);
            
            -- construction des données hder fast
            diag_header_last <= diag_header;
            fpa_header_last <= fpa_header;            
            
            if real_data_mode = '1' then -- en mode réel 
               hder_param.exp_time <= resize(int_time_i, 32); 
               hder_param.frame_id <= unsigned(frame_id_i);
               hder_param.sensor_temp_raw <= (others => '0');
               hder_param.exp_index <= unsigned(int_indx_i);
               hder_param.rdy <= exp_dval_pipe(HDR_SEND_CLK_DELAY-1);
            else                        -- en mode diag  
               hder_param.exp_time <= resize(int_time_i, 32);
               hder_param.frame_id <= unsigned(frame_id_i);
               hder_param.sensor_temp_raw <= (others => '0'); -- temp_raw non necessaire pour les iddcas numeriques
               hder_param.exp_index <= unsigned(int_indx_i);
               hder_param.rdy <= exp_dval_pipe(HDR_SEND_CLK_DELAY-1);
            end if;
            
            --  generation des données de l'image info (exp_feedbk et frame_id proviennent de hw_driver pour eviter d'ajouter un clk supplementaire dans le présent module)
            dispatch_info_i.exp_info.exp_time <= hder_param.exp_time;
            dispatch_info_i.exp_info.exp_indx <= int_indx_i;

            -- sortie des pixels
            case pix_out_sm is 
               
               when idle =>
                  pix_mosi_temp.tvalid <= '0';
                  pix_mosi_temp.tstrb  <= (others => '1');
                  pix_mosi_temp.tkeep  <= (others => '1');
                  pix_mosi_temp.tlast <= '0';
                  pix_mosi_temp.tuser <= (others => '0'); -- pour le module fpa, tous à zeros sauf tuser qui sera definit plus bas.
                  pix_mosi_i.tvalid <= '0';
                  pix_mosi_i.tstrb  <= pix_mosi_temp.tstrb;
                  pix_mosi_i.tkeep  <= pix_mosi_temp.tkeep;
                  pix_mosi_i.tlast <= '0';
                  pix_mosi_i.tuser <= (others => '0');                     
                  if int_fifo_dval = '1' then
                     pix_out_sm <= send_pix_st;                     
                  end if;
               
               when send_pix_st =>                        -- utilisation de pipe pour eviter emploi de gros compteurs et être obligé de decoder le header                   
                  if pix_dval_i = '1' or acq_eof_i = '1' then -- un nouveau pix_dval_i ou un acq_eof_i pousse la donnée précédente dans le pipe vers la sortie
                     pix_mosi_temp.tvalid <= pix_dval_i;
                     -- pipe 1
                     pix_mosi_temp.tdata  <= pix_data_i;  -- pas d'inversion pour que l'image soit en ordre                 
                     pix_mosi_temp.tuser(2)  <= '0';      -- L'index ne suit plusle pixel. -- selon le doc de PDA, l'index occupe le bit 2 de Tuser       
                     -- pipe 2
                     pix_mosi_i.tdata  <= pix_mosi_temp.tdata;                     
                     pix_mosi_i.tuser(2)  <= pix_mosi_temp.tuser(2);  
                  end if;
                  pix_mosi_i.tvalid <= pix_mosi_temp.tvalid and (pix_dval_i or acq_eof_i);
                  if acq_eof_i = '1' then 
                     pix_mosi_i.tlast  <= '1'; -- parfaitement synchro avec le pixel précédent acq_eof_i
                     pix_out_sm <= idle; 
                  end if;
               
               when others =>
               
            end case;        
            
            
            -- sortie de la partie header fast provenant du module
            case fast_hder_sm is
               
               when idle =>
                  hder_mosi_i.awvalid <= '0';
                  hder_mosi_i.wvalid <= '0';
                  hder_mosi_i.wstrb <= (others => '0');
                  hcnt <= to_unsigned(1, hcnt'length);
                  dispatch_info_i.exp_info.exp_dval <= '0';
                  if hder_param.rdy = '1' and acq_hder = '1' then
                     fast_hder_sm <= send_hder_st;                     
                  end if;
               
               when send_hder_st =>
                  dispatch_info_i.exp_info.exp_dval <= '1';  -- il durera au moins 3 CLK
                  if hder_link_rdy = '1' then 
                     if hcnt = 1 then    -- exp_time
                        hder_mosi_i.awaddr <= x"0000" & std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(ExposureTimeAdd32, 8));--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(hder_param.exp_time);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= ExposureTimeBWE;
                        
                     elsif hcnt = 2 then -- frame_id 
                        hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(FrameIDAdd32, 8));--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(hder_param.frame_id);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= FrameIDBWE;
                        
                     elsif hcnt = 3 then -- sensor_temp_raw
                        hder_mosi_i.awaddr <= x"FFFF" &  std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(SensorTemperatureRawAdd32, 8));--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_param.sensor_temp_raw), 32), SensorTemperatureRawShift)); --resize(hder_param.sensor_temp_raw, 32);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= SensorTemperatureRawBWE;
                        fast_hder_sm <= wait_acq_hder_st;
                        
                     end if;
                     
                     
                     hcnt <= hcnt + 1;
                  end if;
                  
               when wait_acq_hder_st =>  
               
                  hder_mosi_i.awvalid <= '0';
                  hder_mosi_i.wvalid <= '0';
                  hder_mosi_i.wstrb <= (others => '0');
                  if acq_hder = '0' then
                     fast_hder_sm <= idle;
                  end if;
               when others =>
               
            end case;               
            
         end if;  
      end if;
   end process; 
   
   -------------------------------------------------------------------
   -- generation misc signaux
   -------------------------------------------------------------------   
   U12: process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' then
            SPEED_ERR <= '0';  
            FPA_ASSUMP_ERR <= '0'; 
            CFG_MISMATCH <= '0'; 
            FIFO_ERR <= '0';
            DONE <= '0';
            HDER_PROGRESS <= '0';
            
         else
            
            -- erreur grave de vitesse
            SPEED_ERR <= pix_mosi_i.tvalid and not pix_link_rdy;
            
            -- erreur sur mes hypothèses (erreurs à ne jamais avoir)
            --FPA_ASSUMP_ERR <= fpa_hder_assump_err or fpa_int_time_assump_err or fpa_gain_assump_err or fpa_mode_assump_err or acq_finge_assump_err; 
            FPA_ASSUMP_ERR <= '0'; -- tant que le lien CLINK_IN ne sera pas fiable 100%, les données du header SCD sont pas fiables. Donc aucune erreur à generer.
            
            -- difference de config
            CFG_MISMATCH <= int_time_mismatch or  ysize_mismatch or ysize_mismatch or xsize_mismatch or gain_mismatch;
            
            -- errer de fifo
            FIFO_ERR <= fpa_ch1_fifo_ovfl_sync or fpa_ch2_fifo_ovfl_sync or fpa_ch3_fifo_ovfl_sync or diag_ch1_fifo_ovfl or diag_ch2_fifo_ovfl or diag_ch3_fifo_ovfl or acq_hder_fifo_ovfl;
            
            -- done
            DONE <= (not fpa_fval and real_data_mode) or (not diag_fval and not real_data_mode); 
            
            -- pour avertir de la progression du decodage du header     
            HDER_PROGRESS <= (fpa_header and real_data_mode) or (diag_header and not real_data_mode);
            
         end if;
         
      end if;
   end process; 
   
end rtl;
