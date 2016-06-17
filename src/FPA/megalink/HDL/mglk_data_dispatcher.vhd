-------------------------------------------------------------------------------
--
-- Title       : SCPIO_data_dispatcher
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\SCPIO_Hercules\src\SCPIO_data_dispatcher.vhd
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


entity mglk_data_dispatcher is
   
   
   port(
      
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      ACQ_INT           : in std_logic;  -- ACQ_INT et FRAME_ID sont parfaitement synchronisés
      FRAME_ID          : in std_logic_vector(31 downto 0);
      INT_INDX          : in std_logic_vector(7 downto 0);
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      FPA_CH1_RST       : in std_logic;
      FPA_CH1_CLK       : in std_logic;
      FPA_CH1_DATA      : in std_logic_vector(27 downto 0);      
      FPA_CH1_DVAL      : in std_logic;
      
      FPA_CH2_RST       : in std_logic;
      FPA_CH2_CLK       : in std_logic;
      FPA_CH2_DATA      : in std_logic_vector(27 downto 0);      
      FPA_CH2_DVAL      : in std_logic;
      
      DIAG_DATA_CLK     : in std_logic;
      
      DIAG_CH1_DATA     : in std_logic_vector(27 downto 0);      
      DIAG_CH1_DVAL     : in std_logic;
      
      DIAG_CH2_DATA     : in std_logic_vector(27 downto 0);      
      DIAG_CH2_DVAL     : in std_logic;
      
      DIAG_MODE_EN      : out std_logic;      
      HDER_PROGRESS     : out std_logic;      
      READOUT           : out std_logic;
      
      PIX_MOSI          : out t_axi4_stream_mosi32;
      PIX_MISO          : in t_axi4_stream_miso;
      
      HDER_MOSI         : out t_axi4_lite_mosi;
      HDER_MISO         : in t_axi4_lite_miso;
      
      DISPATCH_INFO     : out img_info_type;
      
      FPA_ASSUMP_ERR    : out std_logic;
      FIFO_ERR          : out std_logic;
      SPEED_ERR         : out std_logic;
      CFG_MISMATCH      : out std_logic;
      DONE              : out std_logic
      
      );
end mglk_data_dispatcher;

architecture rtl of mglk_data_dispatcher is
   
   
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
         rst      : in std_logic;
         wr_clk   : in std_logic;
         rd_clk   : in std_logic;
         din      : in std_logic_vector(27 downto 0);
         wr_en    : in std_logic;
         rd_en    : in std_logic;
         dout     : out std_logic_vector(27 downto 0);
         valid    : out std_logic;
         full     : out std_logic;
         overflow : out std_logic;
         empty    : out std_logic
         );
   end component;
   
   component fwft_sfifo_w28_d16
      port (
         clk       : in std_logic;
         rst       : in std_logic;
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
   
   component fwft_sfifo_w40_d16
      port (
         clk       : in std_logic;
         rst       : in std_logic;
         din       : in std_logic_vector(39 downto 0);
         wr_en     : in std_logic;
         rd_en     : in std_logic;
         dout      : out std_logic_vector(39 downto 0);
         valid     : out std_logic;
         full      : out std_logic;
         overflow  : out std_logic;
         empty     : out std_logic
         );
   end component;
   
   
   type mode_fsm_type is (idle, wait_fpa_fval_st, wait_diag_fval_st);
   type fast_hder_sm_type is (idle, send_hder_st);                   
   type pix_out_sm_type is (idle, send_pix_st); 
   type acq_fringe_fsm_type is (init_st, idle, wait_fpa_fval_st, wait_diag_fval_st);
   type byte_array is array (0 to 3) of std_logic_vector(7 downto 0);
   
   signal mode_fsm                     : mode_fsm_type;
   signal fast_hder_sm                 : fast_hder_sm_type;
   signal pix_out_sm                   : pix_out_sm_type;
   signal acq_fringe_fsm               : acq_fringe_fsm_type;
   signal sreset                       : std_logic;
   signal real_data_mode               : std_logic;
   signal diag_mode_en_i               : std_logic;
   signal fpa_hder_data                : byte_array;
   signal img_cnt                      : unsigned(31 downto 0);
   signal fpa_fifo_dval                : std_logic;
   signal diag_fifo_dval               : std_logic;
   signal fpa_ch1_fifo_dval            : std_logic;
   signal fpa_ch2_fifo_dval            : std_logic;
   signal diag_ch1_fifo_dval           : std_logic;
   signal diag_ch2_fifo_dval           : std_logic;
   signal fpa_pix1_data                : std_logic_vector(15 downto 0);
   signal fpa_ch1_fifo_dout            : std_logic_vector(27 downto 0);
   signal fpa_pix2_data                : std_logic_vector(15 downto 0);
   signal fpa_ch2_fifo_dout            : std_logic_vector(27 downto 0);
   signal fpa_lval                     : std_logic;
   signal fpa_dval                     : std_logic;
   signal acq_fringe_last              : std_logic;
   signal fpa_fval                     : std_logic;
   signal diag_pix1_data               : std_logic_vector(15 downto 0);
   signal diag_ch1_fifo_dout           : std_logic_vector(27 downto 0);
   signal diag_pix2_data               : std_logic_vector(15 downto 0);
   signal diag_ch2_fifo_dout           : std_logic_vector(27 downto 0);
   signal diag_lval                    : std_logic;
   signal diag_dval                    : std_logic;
   signal diag_fval                    : std_logic;
   signal fpa_ch2_lval                 : std_logic;
   signal fpa_ch2_fval                 : std_logic;
   signal fpa_fifo_rd                  : std_logic;
   signal fpa_ch1_fifo_ovfl            : std_logic;
   signal fpa_ch2_fifo_ovfl            : std_logic;
   signal diag_fifo_rd                 : std_logic;
   signal diag_ch1_fifo_ovfl           : std_logic;
   signal diag_ch2_fifo_ovfl           : std_logic;
   signal fringe_fifo_din              : std_logic_vector(39 downto 0);
   signal fringe_fifo_wr               : std_logic;
   signal fringe_fifo_rd               : std_logic;
   signal fringe_fifo_dout             : std_logic_vector(39 downto 0);
   signal fringe_fifo_dval             : std_logic;
   signal fringe_fifo_ovfl             : std_logic;
   signal acq_int_last                 : std_logic;
   signal acq_eof                      : std_logic;
   signal readout_i                    : std_logic;
   signal acq_fringe                   : std_logic;
   signal frame_id_i                   : std_logic_vector(31 downto 0);
   signal fpa_acq_eof                  : std_logic;
   signal diag_img_dval                : std_logic;
   signal diag_acq_eof                 : std_logic;
   signal fpa_int_time_assump_err      : std_logic;
   signal fpa_gain_assump_err          : std_logic;
   signal fpa_mode_assump_err          : std_logic;
   signal pix_dval_i                   : std_logic;
   signal pix_data_i                   : std_logic_vector(31 downto 0);
   signal fpa_temp_reg_dval            : std_logic;
   signal hder_cnt                     : unsigned(7 downto 0) := (others => '0');
   signal int_time_mismatch            : std_logic;
   signal xsize_mismatch               : std_logic;
   signal ysize_mismatch               : std_logic;
   signal gain_mismatch                : std_logic;
   signal fpa_int_time                 : unsigned(23 downto 0);
   signal fpa_temp_pos                 : unsigned(15 downto 0);
   signal fpa_temp_neg                 : unsigned(15 downto 0);
   signal fpa_temp_reg                 : std_logic_vector(15 downto 0);
   signal fpa_temp_i                   : fpa_temp_stat_type;
   signal hder_mosi_i                  : t_axi4_lite_mosi;
   signal pix_mosi_i, pix_mosi_temp    : t_axi4_stream_mosi32;
   signal pix_link_rdy                 : std_logic;
   signal hder_link_rdy                : std_logic;
   signal acq_eof_pipe                 : std_logic_vector(2 downto 0);
   signal fpa_int_time_100MHz          : unsigned(31 downto 0);
   signal diag_int_time_100MHz         : unsigned(31 downto 0);
   signal fpa_int_time_100MHz_corr     : unsigned(31 downto 0);
   signal dispatch_info_i              : img_info_type;
   signal hder_param                   : hder_param_type;
   signal hcnt                         : unsigned(7 downto 0);
   signal hder_in_progress_i           : std_logic;
   signal acq_finge_assump_err         : std_logic;
   signal int_indx_i                   : std_logic_vector(7 downto 0);
   signal fpa_ch1_fifo_ovfl_sync       : std_logic;
   signal fpa_ch2_fifo_ovfl_sync       : std_logic;
   signal acq_eof_i                    : std_logic;
   signal frame_start_id               : std_logic_vector(7 downto 0);
   signal last_cmd_id                  : std_logic_vector(15 downto 0);
   signal byte_18                      : std_logic_vector(7 downto 0);
   signal byte_19                      : std_logic_vector(7 downto 0);
   signal byte_20                      : std_logic_vector(7 downto 0);
   signal pix_count                    : unsigned(31 downto 0);
   signal proxy_int_time               : unsigned(23 downto 0);
   
   -- attribute dont_touch                         : string;
   -- attribute dont_touch of frame_start_id       : signal is "true";
   -- attribute dont_touch of last_cmd_id          : signal is "true"; 
   -- attribute dont_touch of fpa_int_time         : signal is "true"; 
   -- attribute dont_touch of byte_18              : signal is "true";
   -- attribute dont_touch of byte_19              : signal is "true";
   -- attribute dont_touch of byte_20              : signal is "true";
   -- attribute dont_touch of fpa_int_time_100MHz  : signal is "true";
   
begin
   
   HDER_MOSI <= hder_mosi_i;
   PIX_MOSI <= pix_mosi_i;
   DISPATCH_INFO <= dispatch_info_i;
   
   READOUT <= readout_i;
   DIAG_MODE_EN <= diag_mode_en_i;
   hder_link_rdy <= HDER_MISO.WREADY and HDER_MISO.AWREADY;
   pix_link_rdy <= PIX_MISO.TREADY;
   
   fpa_fifo_dval <= fpa_ch1_fifo_dval and fpa_ch2_fifo_dval;     -- il le faut pour s'assurer de la synchron des deux canaux avant de lire le fifo
   diag_fifo_dval <= diag_ch1_fifo_dval and diag_ch2_fifo_dval;  -- il le faut pour s'assurer de la synchron des deux canaux avant de lire le fifo
   
   -- lecture des fifos FPA (toujours laisser en combinatoire pour eviter des bugs)          
   fpa_fifo_rd <= fpa_ch1_fifo_dval and fpa_ch2_fifo_dval; -- lecture synchronisée des 2 fifos tout le temps. (ssi les donn fpa_ch1_fifo_dval ='1' ET  fpa_ch2_fifo_dval ='1')        
   -- lecture des fifos DIAG           
   diag_fifo_rd <= diag_ch1_fifo_dval and diag_ch2_fifo_dval; -- lecture synchronisée des 2 fifos tout le temps. (ssi les donn diag_ch1_fifo_dval ='1' ET  diag_ch2_fifo_dval ='1')        
   
   
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
   fpa_lval <= fpa_ch1_fifo_dout(24);  -- Lval pris sur canal 1 uniquement
   fpa_fval <= fpa_ch1_fifo_dout(25);  -- Fval pris sur canal 1 uniquement
   fpa_dval <= fpa_ch1_fifo_dout(26);  -- Dval pris sur canal 1 uniquement
   
   fpa_pix2_data(0)  <= fpa_ch2_fifo_dout(0);
   fpa_pix2_data(1)  <= fpa_ch2_fifo_dout(1);
   fpa_pix2_data(2)  <= fpa_ch2_fifo_dout(2);
   fpa_pix2_data(3)  <= fpa_ch2_fifo_dout(3);
   fpa_pix2_data(4)  <= fpa_ch2_fifo_dout(4);
   fpa_pix2_data(5)  <= fpa_ch2_fifo_dout(6);
   fpa_pix2_data(6)  <= fpa_ch2_fifo_dout(27);
   fpa_pix2_data(7)  <= fpa_ch2_fifo_dout(5);
   fpa_pix2_data(8)  <= fpa_ch2_fifo_dout(7);
   fpa_pix2_data(9)  <= fpa_ch2_fifo_dout(8);
   fpa_pix2_data(10) <= fpa_ch2_fifo_dout(9);
   fpa_pix2_data(11) <= fpa_ch2_fifo_dout(12);
   fpa_pix2_data(12) <= fpa_ch2_fifo_dout(13);
   fpa_pix2_data(13) <= fpa_ch2_fifo_dout(14);
   fpa_pix2_data(14) <= fpa_ch2_fifo_dout(10);
   fpa_pix2_data(15) <= fpa_ch2_fifo_dout(11);
   --fpa_lval <= fpa_ch2_fifo_dout(24);  -- Lval pris sur canal 1 uniquement
   --fpa_fval <= fpa_ch2_fifo_dout(25);  -- Fval pris sur canal 1 uniquement
   --fpa_dval <= fpa_ch2_fifo_dout(26);  -- Dval pris sur canal 1 uniquement
   
   
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
   diag_lval <= diag_ch1_fifo_dout(24);  -- Lval
   diag_fval <= diag_ch1_fifo_dout(25);  -- Fval
   diag_dval <= diag_ch1_fifo_dout(26);  -- Dval
   
   diag_pix2_data(0)  <= diag_ch2_fifo_dout(0);
   diag_pix2_data(1)  <= diag_ch2_fifo_dout(1);
   diag_pix2_data(2)  <= diag_ch2_fifo_dout(2);
   diag_pix2_data(3)  <= diag_ch2_fifo_dout(3);
   diag_pix2_data(4)  <= diag_ch2_fifo_dout(4);
   diag_pix2_data(5)  <= diag_ch2_fifo_dout(6);
   diag_pix2_data(6)  <= diag_ch2_fifo_dout(27);
   diag_pix2_data(7)  <= diag_ch2_fifo_dout(5);
   diag_pix2_data(8)  <= diag_ch2_fifo_dout(7);
   diag_pix2_data(9)  <= diag_ch2_fifo_dout(8);
   diag_pix2_data(10) <= diag_ch2_fifo_dout(9);
   diag_pix2_data(11) <= diag_ch2_fifo_dout(12);
   diag_pix2_data(12) <= diag_ch2_fifo_dout(13);
   diag_pix2_data(13) <= diag_ch2_fifo_dout(14);
   diag_pix2_data(14) <= diag_ch2_fifo_dout(10);
   diag_pix2_data(15) <= diag_ch2_fifo_dout(11);
   --diag_lval <= diag_ch1_fifo_dout(24);  -- Lval pris sur canal 1 uniquement  
   --diag_fval <= diag_ch1_fifo_dout(25);  -- Fval pris sur canal 1 uniquement  
   --diag_dval <= diag_ch1_fifo_dout(26);  -- Dval pris sur canal 1 uniquement  
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- double sync 
   --------------------------------------------------   
   U1A: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => fpa_ch1_fifo_ovfl, CLK => CLK, Q => fpa_ch1_fifo_ovfl_sync);
   U1B: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => fpa_ch2_fifo_ovfl, CLK => CLK, Q => fpa_ch2_fifo_ovfl_sync);
   
   --------------------------------------------------
   -- fifo fwft FPA_CH1_DATA 
   -------------------------------------------------- 
   U2 : fwft_afifo_w28_d16
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
      empty => open
      );
   
   --------------------------------------------------
   -- fifo fwft FPA_CH2_DATA 
   -------------------------------------------------- 
   U3 : fwft_afifo_w28_d16
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
      empty => open
      );
   
   -------------------------------------------------
   -- fifo fwft DIAG_CH0_DATA 
   -------------------------------------------------- 
   U4 : fwft_afifo_w28_d16
   port map (
      rst => ARESET,                                           
      wr_clk => DIAG_DATA_CLK, 
      rd_clk => CLK,     
      din => DIAG_CH1_DATA,                                        
      wr_en => DIAG_CH1_DVAL,                        
      rd_en => diag_fifo_rd,                         
      dout => diag_ch1_fifo_dout,                    
      valid  => diag_ch1_fifo_dval,                  
      full => open,                                  
      overflow => diag_ch1_fifo_ovfl,                
      empty => open                                  
      );                                             
   
   --------------------------------------------------
   -- fifo fwft DIAG_CH2_DATA 
   --------------------------------------------------
   U5 : fwft_afifo_w28_d16
   port map (
      rst => ARESET,
      wr_clk => DIAG_DATA_CLK, 
      rd_clk => CLK, 
      din => DIAG_CH2_DATA,
      wr_en => DIAG_CH2_DVAL,
      rd_en => diag_fifo_rd,
      dout => diag_ch2_fifo_dout,
      valid  => diag_ch2_fifo_dval,
      full => open,
      overflow => diag_ch2_fifo_ovfl,
      empty => open
      );
   
   --------------------------------------------------
   -- fifo fwft pour acq fringe et l'index de intTime
   --------------------------------------------------
   U6 : fwft_sfifo_w40_d16
   port map (
      rst => ARESET,
      clk => CLK,
      din => fringe_fifo_din,
      wr_en => fringe_fifo_wr,
      rd_en => fringe_fifo_rd,
      dout => fringe_fifo_dout,
      valid  => fringe_fifo_dval,
      full => open,
      overflow => fringe_fifo_ovfl,
      empty => open
      );
   
   -------------------------------------------------------------------
   -- generation de acq_fringe et stockage dans un fifo fwft  
   -------------------------------------------------------------------   
   -- il faut ecrire dans un fifo fwft le FRAME_ID, que lorsque l'image est prise avec ACQ_TRIG (image à envoyer dans la chaine) 
   -- a) Fifo vide pendant qu'une image rentre dans le présent module => image à ne pas envoyer dans la chaine
   -- b) Fifo contient une donnée pendant qu'une image rentre => image à envoyer dans la chaine avec FRAME_ID contenu dans le fifo
   U7: process(CLK)
   begin          
      if rising_edge(CLK) then         
         if sreset = '1' then 
            acq_fringe_fsm <= init_st;
            fringe_fifo_wr <= '0';
            fringe_fifo_rd <= '0';
            acq_fringe <= '0';
            readout_i <= '0';
            acq_finge_assump_err <= '0';
            
         else         
            
            acq_int_last <= ACQ_INT;
            
            -- ecriture de FRAME_ID dans le acq fringe fifo
            if ACQ_INT = '1' and acq_int_last = '0' then
               fringe_fifo_din <= INT_INDX & FRAME_ID; -- le frame_id est écrit dans le fifo que s'il s'agit d'une image à envoyer dans la chaine
               fringe_fifo_wr <= '1';
            else
               fringe_fifo_wr <= '0';
            end if;
            
            -- generation de acq_fringe et readout_i
            
            case acq_fringe_fsm is 
               
               when init_st => -- cet état est celui d'une verification des conditions initiales pour que la fsm marche comme prévu
                  if fringe_fifo_dval = '0' then 
                     if fpa_fval = '0' and  diag_fval = '0' then 
                        acq_fringe_fsm <= idle;
                     end if;
                  else                     
                     acq_finge_assump_err <= '1'; -- erreur grave s'il y a déjà qque chose dans le fifo juste après un reset
                  end if;
               
               when idle =>
                  fringe_fifo_rd <= '0';
                  readout_i <= '0';
                  acq_fringe <= fringe_fifo_dval; -- ACQ_INT de l'image k vient toujours avant le readout de l'image k. Ainsi le fifo contiendra une donnée avant le readout si l'image est à envoyer dans la chaine. Sinon, c'est une XTRA_FRINGE 
                  if fringe_fifo_dval = '1' then  
                     frame_id_i <= fringe_fifo_dout(FRAME_ID'length-1 downto 0);
                     int_indx_i <= fringe_fifo_dout(FRAME_ID'length+7 downto FRAME_ID'length);
                  else
                     frame_id_i <= FRAME_ID; -- id farfelue d'une extra_fringe provenant du module hw_driver (de toute façon, non envoyée dans la chaine)
                     --int_indx_i <= INT_INDX; -- pour eviter bug index
                  end if;
                  if real_data_mode = '1' then 
                     if fpa_fval = '1' then     -- en quittant idle, frame_id_i et acq_fringe sont implicitement latchés, donc pas besoin de latchs explicites
                        acq_fringe_fsm <= wait_fpa_fval_st;
                        fringe_fifo_rd <= '1'; -- mis à jour de la sortie du fwft pour le prochain frame
                        readout_i <= '1'; -- signal de readout, à sortir même en mode xtra_trig
                     end if;
                  else
                     if diag_fval = '1' then
                        acq_fringe_fsm <= wait_diag_fval_st;
                        fringe_fifo_rd <= '1'; -- mis à jour de la sortie du fwft pour le prochain frame
                        readout_i <= '1'; -- signal de readout, à sortir même en mode xtra_trig
                     end if;
                  end if;
               
               when wait_fpa_fval_st =>
                  fringe_fifo_rd <= '0';
                  if fpa_fval = '0' then
                     readout_i <= '0';
                     acq_fringe <= '0';
                     acq_fringe_fsm <= idle;
                  end if;
               
               when wait_diag_fval_st =>
                  fringe_fifo_rd <= '0';
                  if diag_fval = '0' then
                     readout_i <= '0';
                     acq_fringe <= '0';
                     acq_fringe_fsm <= idle;
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
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            fpa_acq_eof <= '0'; 
            diag_img_dval <= '0';
            diag_acq_eof <= '0';
            acq_fringe_last <= '0';
            diag_acq_eof <= '0';
            fpa_acq_eof <= '0';
            acq_eof <= '0';            
            
         else             
            
            acq_fringe_last <= acq_fringe;
            
            -- dispatching des données et header en mode DIAG et REEL (ou FPA)
            if real_data_mode = '1' then 
               pix_dval_i <= fpa_fifo_rd and fpa_fifo_dval and fpa_dval and acq_fringe;
               pix_data_i <= resize(fpa_pix1_data(15 downto 2),16) & resize(fpa_pix2_data(15 downto 2),16) ;--reverse_bit_func(fpa_pix1_data) & reverse_bit_func(fpa_pix2_data); -- inverser l'ordre des bits de Megalink             
            else
               pix_dval_i <= diag_fifo_rd and diag_fifo_dval and diag_dval and acq_fringe;
               pix_data_i <= diag_pix1_data & diag_pix2_data;
            end if;
            
            -- le header en provenance du fpa doit sortir en tout temps pour aller vers l'extracteur de données. On mettra ainsi à jour les signes vitaux du détecteur (la température etc...) si possible
            -- le hder ne sport pas identique sur les deux canaux
            fpa_hder_data(0) <= fpa_pix1_data(7 downto 0);               
            fpa_hder_data(1) <= fpa_pix1_data(15 downto 8);
            fpa_hder_data(2) <= fpa_pix2_data(7 downto 0);
            fpa_hder_data(3) <= fpa_pix2_data(15 downto 8);     
            
            -- generation de EOF (pas forcement synchro sur la derniere donnee mais ce n'est pas grave)
            fpa_acq_eof <= (acq_fringe_last and not acq_fringe) and real_data_mode;   -- generé seulement en mode non xtratrig
            diag_acq_eof <= (acq_fringe_last and not acq_fringe) and not real_data_mode; -- generé seulement en mode non xtratrig
            acq_eof <= fpa_acq_eof or diag_acq_eof;
            
         end if;
      end if;
   end process;
   
   -------------------------------------------------------------------
   -- fpa header extractor (juste en mode réel)
   -------------------------------------------------------------------   
   U10: process(CLK)
   begin          
      if rising_edge(CLK) then         
         
         fpa_temp_reg_dval <= '0';
         fpa_int_time_assump_err <= '0';
         fpa_gain_assump_err <= '0';
         fpa_mode_assump_err <= '0';
         int_time_mismatch <= '0';
         ysize_mismatch <= '0';
         xsize_mismatch <= '0';
         gain_mismatch <= '0';
         fpa_temp_i.temp_dval <= '0';      
         
         -- latch de la température du détecteur
         if fpa_temp_reg_dval = '1' then  
            fpa_temp_i.temp_data <= resize(fpa_temp_reg,32);
            fpa_temp_i.temp_dval <= '1';
         end if;
         
         -- pragma translate_off
         fpa_temp_i.fpa_pwr_on_temp_reached <= '1';
         -- pragma translate_on        
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
            
         else            
            
            -- pipe de eof : fait pour tenir compte des delais dans le module.
            acq_eof_pipe(0) <= acq_eof;      
            acq_eof_pipe(1) <= acq_eof_pipe(0);
            acq_eof_pipe(2) <= acq_eof_pipe(1);
            acq_eof_i <= acq_eof_pipe(2);
            
            -- construction des données hder fast
            fpa_int_time_100MHz <= to_unsigned(to_integer(FPA_INTF_CFG.PROXY_INT.PROXY_INT_TIME)*FPA_MCLK_RATE_FACTOR, 32);
            if fpa_int_time_100MHz < FPA_INT_TIME_MIN_FACTOR then                   -- 25 mai 2015: sur demande de PTR et RFO, on impose 500 ns comme int_time_min au mars même si c'Est moins que cela.
               fpa_int_time_100MHz_corr <= to_unsigned(FPA_INT_TIME_MIN_FACTOR, fpa_int_time_100MHz_corr'length);
            else
               fpa_int_time_100MHz_corr <= fpa_int_time_100MHz; 
            end if;
            
            -- en mode diag  
            hder_param.exp_time <= fpa_int_time_100MHz_corr;
            hder_param.frame_id <= unsigned(frame_id_i);
            hder_param.sensor_temp_raw <= fpa_temp_i.temp_data(15 downto 0); -- meme en mode diag, la température raw provient du détecteur
            hder_param.exp_index <= unsigned(int_indx_i);
            hder_param.rdy <= acq_fringe and not acq_fringe_last;
            
            --  generation des données de l'image info (exp_feedbk et frame_id proviennent de hw_driver pour eviter d'ajouter un clk supplementaire dans le présent module)
            dispatch_info_i.exp_info.exp_time <= hder_param.exp_time;
            dispatch_info_i.exp_info.exp_indx <= int_indx_i;
            
            -- pragma translate_off
            if pix_mosi_i.tvalid = '1' then 
               pix_count <= pix_count + 2;
            else
               if pix_out_sm = idle then
                  pix_count <= (others => '0');
               end if;
            end if;
            -- pragma translate_on
            
            -- sortie des pixels
            case pix_out_sm is 
               
               when idle =>
                  pix_mosi_temp.tvalid <= '0';
                  pix_mosi_temp.tstrb  <= "1111";
                  pix_mosi_temp.tkeep  <= "1111";
                  pix_mosi_temp.tlast <= '0';
                  pix_mosi_temp.tuser <= (others => '0'); -- pour le module fpa, tous à zeros sauf tuser qui sera definit plus bas.
                  pix_mosi_i.tvalid <= '0';
                  pix_mosi_i.tstrb  <= pix_mosi_temp.tstrb;
                  pix_mosi_i.tkeep  <= pix_mosi_temp.tkeep;
                  pix_mosi_i.tlast <= '0';
                  pix_mosi_i.tuser <= (others => '0');                     
                  if acq_fringe = '1' then
                     pix_out_sm <= send_pix_st;                     
                  end if;
               
               when send_pix_st =>                        -- utilisation de pipe pour eviter emploi de gros compteurs et être obligé de decoder le header                   
                  if pix_dval_i = '1' or acq_eof_i = '1' then -- un nouveau pix_dval_i ou un acq_eof_i pousse la donnée précédente dans le pipe vers la sortie
                     pix_mosi_temp.tvalid <= pix_dval_i;
                     -- pipe 1
                     pix_mosi_temp.tdata  <= pix_data_i; -- pas d'inversion pour que l'image soit en ordre                 
                     pix_mosi_temp.tuser(2)  <= '0';-- on n'écrit plus l'index--int_indx_i;  -- selon le doc de PDA, l'index occupe le bit 2 de Tuser       
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
                  if hder_param.rdy = '1' and acq_fringe = '1' then
                     fast_hder_sm <= send_hder_st;                     
                  end if;
               
               when send_hder_st =>
                  dispatch_info_i.exp_info.exp_dval <= '1';  -- il durera au moins 3 CLK
                  if hder_link_rdy = '1' then                         
                     if hcnt = 1 then -- frame_id 
                        hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(FrameIDAdd32, 8));--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(hder_param.frame_id);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= FrameIDBWE;
                        
                     elsif hcnt = 2 then -- sensor_temp_raw
                        hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(SensorTemperatureRawAdd32, 8));--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_param.sensor_temp_raw), 32), SensorTemperatureRawShift)); --resize(hder_param.sensor_temp_raw, 32);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= SensorTemperatureRawBWE;
                        
                     elsif hcnt = 3 then    -- exp_time -- en troisieme position pour donner du temps au calcul de hder_param.exp_time
                        hder_mosi_i.awaddr <= x"FFFF" & std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(ExposureTimeAdd32, 8));--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(hder_param.exp_time);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= ExposureTimeBWE;
                        fast_hder_sm <= idle;
                     end if;
                     
                     hcnt <= hcnt + 1;
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
            FPA_ASSUMP_ERR <= '0'; 
            
            -- difference de config
            CFG_MISMATCH <= int_time_mismatch or  ysize_mismatch or ysize_mismatch or xsize_mismatch or gain_mismatch;
            
            -- errer de fifo
            FIFO_ERR <= fpa_ch1_fifo_ovfl_sync or fpa_ch2_fifo_ovfl_sync or diag_ch1_fifo_ovfl or diag_ch2_fifo_ovfl or fringe_fifo_ovfl;
            
            -- done
            DONE <= (not fpa_fval and real_data_mode) or (not diag_fval and not real_data_mode); 
            
            -- pour avertir de la progression du decodage du header     
            HDER_PROGRESS <= '0';
            
         end if;
         
      end if;
   end process; 
   
end rtl;
