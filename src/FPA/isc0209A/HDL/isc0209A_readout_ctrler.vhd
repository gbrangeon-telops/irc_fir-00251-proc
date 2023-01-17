------------------------------------------------------------------
--!   @file : mglk_DOUT_DVALiter
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all; 

entity isc0209A_readout_ctrler is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic; 
      
      FPA_PCLK          : in std_logic;  -- FPA_PCLK est l'horloge des pixels. Il peut valoir soit 1xMCLK (par ex. Hawk) ou 2xMCLK (par ex. Indigo).    
      FPA_MCLK          : in std_logic;  -- 
      FPA_INTF_CFG      : in fpa_intf_cfg_type;      
      FPA_INT           : in std_logic;  -- requis pour ISC0209A puisque les signaux LSYNC et autres sont generés à la fin de la consigne d'integration (Montée de FSYNC)
      ACQ_INT           : in std_logic;  -- requis pour determiner ACQ_FRINGE
      FPA_INT_FDBK      : in std_logic;  -- requis pour ISC0209A puisque l'offset se calcule lorsque se fait l'integration du ROIC, donc à l'intérieur le feedback d'integration
      
      QUAD_CLK_COPY     : in std_logic;
      
      FPA_LSYNC         : out std_logic;         
      READOUT_INFO      : out readout_info_type;
      ADC_SYNC_FLAG     : out std_logic_vector(15 downto 0);
      IMG_IN_PROGRESS   : out std_logic
      );  
end isc0209A_readout_ctrler;


architecture rtl of isc0209A_readout_ctrler is
   
   constant C_FLAG_PIPE_LEN : integer := DEFINE_ADC_QUAD_CLK_FACTOR;
   constant C_PIPE_POS      : integer := 3;
   
   type sync_flag_fsm_type is (idle, sync_flag_on_st, sync_flag_off_st, wait_img_begin_st, wait_img_end_st);
   type readout_fsm_type is (idle, readout_st, wait_mclk_fe_st, wait_readout_end_st);
   type line_cnt_pipe_type is array (0 to 3) of unsigned(FPA_INTF_CFG.WINDOW_LSYNC_NUM'LENGTH-1 downto 0);
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   
   signal sreset               : std_logic;   
   signal sync_flag_fsm        : sync_flag_fsm_type;
   signal readout_fsm          : readout_fsm_type;
   signal fpa_pclk_last        : std_logic;
   signal pclk_fall            : std_logic;
   signal pclk_rise            : std_logic;
   signal fval_pclk_cnt        : unsigned(FPA_INTF_CFG.READOUT_PCLK_CNT_MAX'LENGTH-1 downto 0); 
   signal lval_pclk_cnt        : unsigned(FPA_INTF_CFG.LINE_PERIOD_PCLK'LENGTH-1 downto 0);
   signal quad_clk_copy_i      : std_logic;
   signal quad_clk_copy_last   : std_logic;
   signal adc_sync_flag_i      : std_logic_vector(ADC_SYNC_FLAG'LENGTH-1 downto 0);
   signal eol_pipe             : std_logic_vector(3 downto 0);
   signal sol_pipe             : std_logic_vector(3 downto 0);
   signal eof_pipe             : std_logic_vector(3 downto 0);
   signal sof_pipe             : std_logic_vector(3 downto 0);
   signal fval_pipe            : std_logic_vector(3 downto 0);
   signal lval_pipe            : std_logic_vector(3 downto 0);
   signal rd_end_pipe          : std_logic_vector(3 downto 0);
   signal samp_pulse_pipe      : std_logic_vector(3 downto 0);
   signal dval_pipe            : std_logic_vector(3 downto 0);
   signal readout_in_progress  : std_logic;
   signal active_line_en1      : std_logic;
   signal global_reset         : std_logic;
   signal lsync_pipe           : std_logic_vector(7 downto 0);
   signal lsync_cnt            : unsigned(FPA_INTF_CFG.WINDOW_LSYNC_NUM'LENGTH-1 downto 0);
   signal line_cnt_pipe        : line_cnt_pipe_type;
   signal fpa_mclk_last        : std_logic;
   signal sol_pipe_pclk        : std_logic_vector(1 downto 0);
   signal readout_info_i       : readout_info_type;
   signal eof_pulse            : std_logic;
   signal eof_pulse_last       : std_logic;
   signal acq_int_pipe         : std_logic_vector(7 downto 0);
   signal acq_data_i           : std_logic;
   signal acq_int_i            : std_logic;
   signal acq_int_last         : std_logic;
   signal fpa_int_i            : std_logic;
   signal fpa_int_last         : std_logic;
   signal img_in_progress_i    : std_logic;
   
   signal eof_posf_pclk_p1     : unsigned(FPA_INTF_CFG.EOF_POSF_PCLK'length-1 downto 0);
   signal pre_fval_active      : std_logic;
   signal elcorr_ref0_start_pipe, elcorr_ref1_start_pipe : std_logic_vector(3 downto 0);
   signal elcorr_ref0_stop_pipe, elcorr_ref1_stop_pipe : std_logic_vector(3 downto 0);
   signal elcorr_ref0_dval_pipe, elcorr_ref1_dval_pipe : std_logic_vector(3 downto 0);
   
begin                                     
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------  
   FPA_LSYNC <= lsync_pipe(6);                        -- pipe(6) choisi apres simulation pour avoir 1 clk de delai avec FPA_MCLK (meme delai  que le signal d'integration). Ainsi le dodule io_interface aura juste à decaler l'horloge FPA_MCLK de 2 clk et tout sera ok
   ADC_SYNC_FLAG <= adc_sync_flag_i;    -- non utilisé  
   READOUT_INFO  <= readout_info_i;
   IMG_IN_PROGRESS <= img_in_progress_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- definition sync_flag
   --------------------------------------------------
   Ud: process(CLK)
   begin
      if rising_edge(CLK) then 
         adc_sync_flag_i(15 downto 6)  <= (others => '0');    -- non utilisé
         adc_sync_flag_i(5)  <= readout_info_i.samp_pulse;    -- clk_enable
         adc_sync_flag_i(4)  <= readout_info_i.aoi.eof and readout_info_i.aoi.dval;
         adc_sync_flag_i(3)  <= readout_info_i.naoi.stop;
         adc_sync_flag_i(2)  <= readout_info_i.naoi.start;
         adc_sync_flag_i(1)  <= readout_info_i.aoi.sof and readout_info_i.aoi.dval;                                    -- frame_flag(doit durer 1 CLK ADC au minimum). Dval_pipe permet de s'assurer que seuls les sol de la zone usager sont envoyés. Sinon, bjr les problèmes.   
         adc_sync_flag_i(0)  <= readout_info_i.aoi.sol and readout_info_i.aoi.dval;               -- line_flag (doit durer 1 CLK ADC au minimum). Dval_pipe permet de s'assurer que seuls les sol de la zone usager sont envoyés. Sinon, bjr les problèmes.   
      end if;
   end process;
   
   --------------------------------------------------
   -- generation sync_flag
   --------------------------------------------------
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            readout_info_i.aoi.dval <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            readout_info_i.naoi.start <= '0';
            readout_info_i.naoi.stop <= '0';
            eof_pulse <= '0';
            eof_pulse_last <= '0';
            
         else           
            
            
            fpa_pclk_last <= FPA_PCLK;
            pclk_rise <= not fpa_pclk_last and FPA_PCLK; 
            pclk_fall <= fpa_pclk_last and not FPA_PCLK;
            
            fpa_mclk_last <= FPA_MCLK;             
            
            -- READOUT_INFO
            -- aoi
            readout_info_i.aoi.sof           <= sof_pipe(C_PIPE_POS); 
            readout_info_i.aoi.eof           <= eof_pipe(C_PIPE_POS); 
            readout_info_i.aoi.sol           <= sol_pipe(C_PIPE_POS); 
            readout_info_i.aoi.eol           <= eol_pipe(C_PIPE_POS); 
            readout_info_i.aoi.fval          <= fval_pipe(C_PIPE_POS);
            readout_info_i.aoi.lval          <= lval_pipe(C_PIPE_POS);
            readout_info_i.aoi.dval          <= dval_pipe(C_PIPE_POS);
            readout_info_i.aoi.read_end      <= rd_end_pipe(C_PIPE_POS);
            readout_info_i.aoi.samp_pulse    <= samp_pulse_pipe(C_PIPE_POS);
            readout_info_i.aoi.spare(0)      <= acq_data_i;
            
            -- naoi
            readout_info_i.naoi.ref_valid(1) <= elcorr_ref1_dval_pipe(C_PIPE_POS);--REF_VALID(1);        -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= elcorr_ref0_dval_pipe(C_PIPE_POS);--REF_VALID(0);        -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)
            readout_info_i.naoi.start        <= elcorr_ref0_start_pipe(C_PIPE_POS) or elcorr_ref1_start_pipe(C_PIPE_POS);  -- start global de zone naoi
            readout_info_i.naoi.stop         <= elcorr_ref0_stop_pipe(C_PIPE_POS) or elcorr_ref1_stop_pipe(C_PIPE_POS);    -- end global de zone naoi
            readout_info_i.naoi.dval         <= elcorr_ref0_dval_pipe(C_PIPE_POS) or elcorr_ref1_dval_pipe(C_PIPE_POS);
            readout_info_i.naoi.samp_pulse   <= (quad_clk_copy_last and not quad_clk_copy_i); 
            
            readout_info_i.samp_pulse        <= (quad_clk_copy_last and not quad_clk_copy_i);
            
         end if;
      end if;
   end process;  
   
   --------------------------------------------------
   -- generation de readout_in_progress
   --------------------------------------------------
   U3: process(CLK)
      variable pclk_cnt_incr : std_logic_vector(1 downto 0);  
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            readout_fsm <= idle;
            readout_in_progress <= '0';
            lsync_pipe <=  (others =>'0');
            -- pragma translate_off
            lsync_cnt <=  (others => '0');
            -- pragma translate_on 
            acq_data_i <= '0';
            fpa_int_i <= FPA_INT;            
            fpa_int_last <= fpa_int_i;
            acq_int_i <= ACQ_INT;            
            acq_int_last <= acq_int_i;
            img_in_progress_i <= '0';
            pre_fval_active <= '0';
            
         else  
            
            
            if pclk_fall = '1' then
               sol_pipe_pclk(0) <= sol_pipe(0);
               sol_pipe_pclk(1) <= sol_pipe_pclk(0);
               pre_fval_active <= '0';    -- il est toujours à 0 sauf si mis à 1 plus bas
            end if;
            
            lsync_pipe(7 downto 1) <= lsync_pipe(6 downto 0);
            
            fpa_int_i       <= FPA_INT;
            fpa_int_last    <= fpa_int_i;
            acq_int_i       <= ACQ_INT;
            acq_int_last    <= acq_int_i;
            
            -- contrôleur
            case readout_fsm is           
               
               when idle =>   
                  readout_in_progress <= '0';
                  lsync_cnt <=  (others => '0');
                  lsync_pipe(0) <= '0';
                  img_in_progress_i <= fpa_int_last;                -- ENO 29 janv 2020: on s'assure que img_in_progress_i ne tombe à zero que si aucune image n'est en transaction. ENO: 14 juin 2022: il faut  qu'en mode XTRA_TRIG/PROG_TRIG qu'il y ait un delai suffisant d'une image à l'autre sinon bug car la mise à jour des cfgs ne se fera pas.
                  acq_data_i <= '0';                 
                  if fpa_int_last = '1' and  fpa_int_i = '0' then   -- front descendant de int                     
                     acq_data_i <= acq_int_last;
                     readout_fsm <= wait_mclk_fe_st;
                  end if; 
               
               when wait_mclk_fe_st => 
                  if pclk_fall = '1' then  -- on attend la tombée de la MCLK pour eviter des troncatures 
                     readout_fsm <= readout_st;
                     pre_fval_active <= '1';    -- mis à 1 jusqu'au prochain pclk_fall qui correspond à la montée du fval (fval_pclk_cnt = 1)
                  end if;                           
               
               when readout_st =>                    --
                  readout_in_progress <= '1';
                  lsync_pipe(0) <= sol_pipe_pclk(0) or sol_pipe_pclk(1);  --           
                  if lsync_pipe(1) = '1' and lsync_pipe(0) = '0' then    -- on compte les lsync
                     lsync_cnt <= lsync_cnt + 1; 
                  end if;
                  if lsync_cnt >= FPA_INTF_CFG.WINDOW_LSYNC_NUM then 
                     readout_fsm <= wait_readout_end_st;
                  end if;                  
               
               when wait_readout_end_st =>                  
                  if rd_end_pipe(0) = '1' then 
                     readout_fsm <= idle;
                  end if;         
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- referentiel image et referentiel ligne
   --------------------------------------------------
   U4: process(CLK)
   begin
      if rising_edge(CLK) then 
         
         if readout_in_progress = '1' then
            if pclk_fall = '1' then 
               fval_pclk_cnt <= fval_pclk_cnt + 1;  -- referentiel trame  : compteur temporel sur toute l'image
               lval_pclk_cnt <= lval_pclk_cnt + 1;  -- referentiel ligne  : compteur temporel sur ligne synchronisé sur celui de trame. 
            end if;
         else
            fval_pclk_cnt <= to_unsigned(0, fval_pclk_cnt'length);
            lval_pclk_cnt <= (others => '0'); 
         end if;         
         
         if lval_pclk_cnt = FPA_INTF_CFG.LINE_PERIOD_PCLK and pclk_fall = '1' then       -- periode du referentiel ligne
            lval_pclk_cnt <= to_unsigned(1, lval_pclk_cnt'length);   
         end if;
         
      end if;
   end process;   
   
   --------------------------------------------------
   --  generation des identificateurs de trames 
   --------------------------------------------------
   U5: process(CLK)
   begin
      if rising_edge(CLK) then         
         
         eof_posf_pclk_p1 <= FPA_INTF_CFG.EOF_POSF_PCLK + 1;
         
         -------------------------
         -- pipe 0 pour generation identificateurs 
         -------------------------
         if fval_pclk_cnt = 1 then                                   -- fval
            fval_pipe(0) <= '1';
         elsif fval_pclk_cnt = FPA_INTF_CFG.READOUT_PCLK_CNT_MAX then
            fval_pipe(0) <= '0';
         end if;
         
         if lval_pclk_cnt = FPA_INTF_CFG.SOL_POSL_PCLK then          -- lval
            lval_pipe(0) <= '1';
         elsif lval_pclk_cnt = FPA_INTF_CFG.EOL_POSL_PCLK_P1 then
            lval_pipe(0) <= '0';
         end if;    
         
         if lval_pclk_cnt = FPA_INTF_CFG.SOL_POSL_PCLK then          -- sol
            sol_pipe(0) <= '1';                                  
         else
            sol_pipe(0) <= '0';
         end if;
         
         if lval_pclk_cnt = FPA_INTF_CFG.EOL_POSL_PCLK then         -- eol
            eol_pipe(0) <= '1';
         else
            eol_pipe(0) <= '0';
         end if;
         
         if fval_pclk_cnt = FPA_INTF_CFG.SOF_POSF_PCLK then         -- sof
            sof_pipe(0) <= '1';
         else
            sof_pipe(0) <= '0';
         end if;
         
         if fval_pclk_cnt = FPA_INTF_CFG.EOF_POSF_PCLK then         -- eof
            eof_pipe(0) <= '1';
         else
            eof_pipe(0) <= '0';        
         end if;
         
         rd_end_pipe(0) <= fval_pipe(1) and not fval_pipe(0); -- read_end se trouve en dehors de fval. C'est voulu. le suivre pour comprendre ce qu'il fait.
         
         -- reference 0 pour la correction electronique: on utilise la periode entre 2 readouts
         -- le start est le pixel suivant le eof
         if fval_pclk_cnt = eof_posf_pclk_p1 then
            elcorr_ref0_start_pipe(0) <= '1';
         else
            elcorr_ref0_start_pipe(0) <= '0';
         end if;
         -- le stop est le dernier pixel avant le readout suivant
         if pre_fval_active = '1' then
            elcorr_ref0_stop_pipe(0) <= '1';
         else
            elcorr_ref0_stop_pipe(0) <= '0';
         end if;
         
         -------------------------
         -- pipe 1 pour generation premisse dval
         -------------------------
         fval_pipe(1)   <= fval_pipe(0);
         lval_pipe(1)   <= lval_pipe(0)and fval_pipe(0);
         sol_pipe(1)    <= sol_pipe(0)and fval_pipe(0);
         eol_pipe(1)    <= eol_pipe(0)and fval_pipe(0);
         sof_pipe(1)    <= sof_pipe(0)and fval_pipe(0);
         eof_pipe(1)    <= eof_pipe(0)and fval_pipe(0);
         rd_end_pipe(1) <= rd_end_pipe(0);
         if sol_pipe(1) = '0' and sol_pipe(0) = '1' then 
            line_cnt_pipe(1) <= line_cnt_pipe(1) + 1;
         end if;
         elcorr_ref0_start_pipe(1) <= elcorr_ref0_start_pipe(0);
         elcorr_ref0_stop_pipe(1) <= elcorr_ref0_stop_pipe(0);
         
         -------------------------
         -- pipe 2 pour generation premisse dval
         -------------------------
         fval_pipe(2)   <= fval_pipe(1);
         lval_pipe(2)   <= lval_pipe(1);
         sol_pipe(2)    <= sol_pipe(1);
         eol_pipe(2)    <= eol_pipe(1);
         sof_pipe(2)    <= sof_pipe(1);
         eof_pipe(2)    <= eof_pipe(1);
         rd_end_pipe(2) <= rd_end_pipe(1);
         line_cnt_pipe(2) <= line_cnt_pipe(1);
         if  line_cnt_pipe(1) >= FPA_INTF_CFG.ACTIVE_LINE_START_NUM then 
            active_line_en1 <= '1';
         else
            active_line_en1 <= '0';
         end if;                  
         elcorr_ref0_start_pipe(2) <= elcorr_ref0_start_pipe(1);
         elcorr_ref0_stop_pipe(2) <= elcorr_ref0_stop_pipe(1);
         
         -------------------------
         -- pipe 3 pour generation dval         
         -------------------------
         fval_pipe(3)   <= fval_pipe(2);
         lval_pipe(3)   <= lval_pipe(2);
         sol_pipe(3)    <= sol_pipe(2);
         eol_pipe(3)    <= eol_pipe(2);
         sof_pipe(3)    <= sof_pipe(2);
         eof_pipe(3)    <= eof_pipe(2);
         rd_end_pipe(3) <= rd_end_pipe(2);
         line_cnt_pipe(3) <= line_cnt_pipe(2);
         if line_cnt_pipe(2) <= FPA_INTF_CFG.ACTIVE_LINE_END_NUM then  
            dval_pipe(3)   <= active_line_en1 and lval_pipe(2); 
         else
            dval_pipe(3)   <= '0';
         end if;
         -- reference 1 pour la correction electronique: on utilise la ligne 2 au complet
         if line_cnt_pipe(2) = 2 then
            elcorr_ref1_dval_pipe(3) <= lval_pipe(2); -- le dval dure toute la ligne 2
            elcorr_ref1_start_pipe(3) <= sol_pipe(2); -- start synchronisé avec sol
            elcorr_ref1_stop_pipe(3) <= eol_pipe(2);  -- stop synchronisé avec eol
         else
            elcorr_ref1_dval_pipe(3) <= '0';
            elcorr_ref1_start_pipe(3) <= '0';
            elcorr_ref1_stop_pipe(3) <= '0';
         end if;
         -- reference 0 pour la correction electronique
         elcorr_ref0_start_pipe(3) <= elcorr_ref0_start_pipe(2);
         elcorr_ref0_stop_pipe(3) <= elcorr_ref0_stop_pipe(2);
         if elcorr_ref0_start_pipe(3) = '0' and elcorr_ref0_start_pipe(2) = '1' then
            elcorr_ref0_dval_pipe(3) <= '1'; -- le dval monte en meme temps que le start
         elsif elcorr_ref0_stop_pipe(3) = '1' and elcorr_ref0_stop_pipe(2) = '0' then
            elcorr_ref0_dval_pipe(3) <= '0'; -- le dval descend en meme temps que le stop
         end if;
         
         global_reset <= sreset or rd_end_pipe(2);
         
         -- generation de samp_pulse_i : on echantillonne les signaux fval, lval etc avec samp_pulse_i
         quad_clk_copy_i <= QUAD_CLK_COPY;
         quad_clk_copy_last <= quad_clk_copy_i;
         samp_pulse_pipe(3) <= (quad_clk_copy_last and not quad_clk_copy_i) and fval_pipe(3);
         
         -------------------------
         -- reset des identificateurs
         -------------------------
         if global_reset = '1' then
            active_line_en1 <= '0';
            dval_pipe   <= (others => '0');
            fval_pipe   <= (others => '0');
            lval_pipe   <= (others => '0');
            sol_pipe    <= (others => '0');
            eol_pipe    <= (others => '0');
            sof_pipe    <= (others => '0');
            eof_pipe    <= (others => '0');
            rd_end_pipe <= (others => '0');
            samp_pulse_pipe <= (others => '0');
            quad_clk_copy_last <= '0';
            quad_clk_copy_i <= '0';
            for ii in 0 to lval_pipe'length-1 loop
               line_cnt_pipe(ii) <= (others => '0'); 
            end loop;
         end if;
         if sreset = '1' then
            elcorr_ref0_start_pipe <= (others => '0');
            elcorr_ref1_start_pipe <= (others => '0');
            elcorr_ref0_stop_pipe <= (others => '0');
            elcorr_ref1_stop_pipe <= (others => '0');
            elcorr_ref0_dval_pipe <= (others => '0');
            elcorr_ref1_dval_pipe <= (others => '0');
         end if;   
      end if;
   end process; 
   
end rtl;
