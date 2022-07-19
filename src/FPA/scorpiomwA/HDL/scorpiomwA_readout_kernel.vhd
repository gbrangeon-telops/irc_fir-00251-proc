------------------------------------------------------------------
--!   @file : isc0804A_readout_kernel
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
use work.fastrd2_define.all;

entity scorpiomwA_readout_kernel is
   port(
      
      ARESET             : in std_logic;
      CLK                : in std_logic;     
      
      FPA_INTF_CFG       : in fpa_intf_cfg_type;
      
      -- statut de l'integrateur
      FPA_INT            : in std_logic;  -- requis pour ScorpioMW puisque les signaux LSYNC et autres sont generés à la fin de la consigne d'integration (Montée de FSYNC)
      ACQ_INT            : in std_logic;  -- requis pour determiner ACQ_DATA
      
      -- statut du trig controller pour RWI
      ACQ_MODE           : in std_logic;
      ACQ_MODE_FIRST_INT : in std_logic;
      NACQ_MODE_FIRST_INT: in std_logic;
      
      -- correction electronique
      ELCORR_REF_VALID   : in std_logic_vector(1 downto 0);
      
      -- horloges brutes non contrôlée
      NOMINAL_MCLK_RAW   : in std_logic;
      PROG_MCLK_RAW      : in std_logic;
      
      -- statut du detecteur
      FPA_DATA_VALID     : in std_logic;
      
      -- horloge adc    
      ADC_REF_CLK        : in std_logic;
      
      -- fifo des données et horloges      
      AREA_FIFO_EMPTY    : in std_logic;
      AREA_FIFO_RD       : out std_logic;
      AREA_FIFO_DATA     : in area_info_type;
      AREA_FIFO_DVAL     : in std_logic;
      
      -- outputs
      ADC_SYNC_FLAG      : out std_logic_vector(15 downto 0);      
      FPA_MCLK           : out std_logic;
      READOUT_INFO       : out readout_info_type;
      
      GEN_START          : out std_logic;
      GEN_DONE           : in std_logic;
      GEN_RST            : out std_logic;
      
      RAW_WINDOW         : out area_type;                        
      IMG_IN_PROGRESS    : out std_logic;
      FPA_INACTIVE_INT   : out std_logic;
      FPA_POWERED        : in std_logic;
      
      FPA_PROG_MODE      : in std_logic;
      
      CLK_AREA_CFG_B 	 : out area_cfg_type; 
      
      ERR                : out std_logic_vector(1 downto 0)  
      );
end scorpiomwA_readout_kernel;

architecture rtl of scorpiomwA_readout_kernel is
   
   constant C_FLAG_PIPE_LEN   : integer := DEFINE_ADC_QUAD_CLK_FACTOR;   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component fwft_sfifo_w3_d256
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
   
   type ctrl_fsm_type is (idle, wait_int_end_st, tir_dly_st, wait_flows_st, active_flow_st, sync_flow_st, adc_sync_st, prog_clk_st, gen_rst_st, wait_dvalid_st, nominal_clk_st);   
   type int_reset_fsm_type is (idle, active_rst_st, wait_int_end_st);
   
   signal nominal_mclk_raw_last  : std_logic;
   signal fpa_mclk_i             : std_logic;
   signal nominal_mclk_raw_en    : std_logic;
   signal prog_mclk_raw_en       : std_logic;
   signal adc_frame_flag_i       : std_logic;
   signal adc_line_flag_i        : std_logic;
   signal readout_info_i         : readout_info_type;
   signal sreset                 : std_logic;
   signal err_i                  : std_logic_vector(ERR'LENGTH - 1 downto 0);
   signal adc_ref_clk_i          : std_logic;
   signal adc_ref_clk_last       : std_logic;
   signal ctrl_fsm               : ctrl_fsm_type;
   signal int_reset_fsm          : int_reset_fsm_type;
   signal raw_window_i           : area_type; 
   signal area_fifo_rd_i         : std_logic;
   signal imm_clk_sync_err       : std_logic;
   signal imm_sol_sync_err       : std_logic;
   signal gen_start_i            : std_logic;
   signal fpa_int_i              : std_logic := '0';
   signal fpa_int_last           : std_logic := '0';
   signal fpa_mclk_re            : std_logic;
   signal fpa_mclk_last          : std_logic;
   signal user_area_err          : std_logic;
   signal data_sync_err          : std_logic;
   signal line_pclk_cnt_last     : unsigned(AREA_FIFO_DATA.RAW.LINE_PCLK_CNT'length-1 downto 0);
   -- signal mclk_pause_cnt      : natural range 0 to DEFINE_FPA_PCLK_RATE_FACTOR + 1;
   signal raw_fval_i             : std_logic := '0';
   signal raw_fval_last          : std_logic := '0';
   signal readout_info_valid     : std_logic;
   signal elcorr_ref_start_pipe  : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_pipe    : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_i       : std_logic;
   signal elcorr_ref_start_i     : std_logic;
   signal adc_ref_fe_pipe        : std_logic_vector(15 downto 0) := (others => '0');
   signal elcorr_ref_fval_i      : std_logic;
   signal rst_cnt_i              : unsigned(4 downto 0);
   signal gen_rst_i              : std_logic;
   signal elcorr_ref_enabled     : std_logic;
   signal fpa_mclk_fe            : std_logic;
   signal read_end_last          : std_logic;
   signal read_start_last        : std_logic;
   signal adc_sync_flag_i        : std_logic_vector(15 downto 0) := (others => '0');
   signal img_in_progress_i      : std_logic;
   signal acq_data_i             : std_logic;  -- dit si les données associées aux flags sont à envoyer dans la chaine ou pas.
   signal flow_err               : std_logic;
   signal wait_cnt               : unsigned(7 downto 0);
   signal elcorr_tic             : std_logic;
   signal elcorr_tac             : std_logic;
   
   signal fpa_inactive_int_i     : std_logic;
   signal fpa_int_re             : std_logic;
   signal fifo_ovfl              : std_logic := '0';
   signal mclk_cnt               : integer range 0 to 16383;
   signal fpa_data_valid_i       : std_logic;
   signal fpa_data_valid_last    : std_logic;
   
   signal fpa_data_valid_re      : std_logic;
   signal incoming_diag_data     : std_logic;
   signal incoming_fpa_data      : std_logic; 
   signal incoming_data          : std_logic;
   signal fpa_int_fe             : std_logic;
   
   signal tir_dly_cnt            : unsigned(FPA_INTF_CFG.TIR_DLY_ADC_CLK'LENGTH-1 downto 0);
   signal ignore_fpa_dvalid      : std_logic;
   
   signal prog_mclk_raw_last     : std_logic;
   signal clk_area_b_i           : area_cfg_type;
   signal init_mclk_done         : std_logic;
   
   
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------
   FPA_MCLK          <= fpa_mclk_i;
   GEN_RST           <= gen_rst_i;
   
   -- ADC_SYNC_FLAG   
   ADC_SYNC_FLAG     <= adc_sync_flag_i;   -- non utilisé
   
   READOUT_INFO      <= readout_info_i;
   AREA_FIFO_RD      <= area_fifo_rd_i;
   GEN_START         <= gen_start_i;
   ERR               <= err_i;
   IMG_IN_PROGRESS   <= img_in_progress_i;
   FPA_INACTIVE_INT  <= fpa_inactive_int_i;
   CLK_AREA_CFG_B    <= clk_area_b_i;
   
   -- pragma translate_off
   RAW_WINDOW <= raw_window_i;
   -- pragma translate_on
   
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
   -- misc
   --------------------------------------------------
   fpa_data_valid_i <= FPA_DATA_VALID;
   
   U3: process(CLK)
      variable pclk_cnt_incr : std_logic_vector(1 downto 0);  
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            fpa_int_re    <= '0';
            fpa_int_fe    <= '0';
            incoming_diag_data <= '0';
            incoming_fpa_data  <= '0';
            incoming_data <= '0';
            fpa_data_valid_last <= fpa_data_valid_i;
            
         else  
            
            fpa_int_re              <= (not fpa_int_last and fpa_int_i);
            fpa_int_fe              <= (fpa_int_last and not fpa_int_i);
            
            fpa_data_valid_last     <= fpa_data_valid_i;
            fpa_data_valid_re       <= not fpa_data_valid_last and fpa_data_valid_i;
            
            -- incoming_diag_data      <= FPA_INTF_CFG.COMN.FPA_DIAG_MODE and fpa_int_fe;
            incoming_fpa_data       <= fpa_data_valid_re;
            
            -- incoming_data           <= incoming_diag_data or incoming_fpa_data; --fpa_int_fe; --  
            
         end if;
      end if;                           
   end process;  
   
   
   ----------------  ----------------------------------
   --  lecture des fifos et synchronisation
   --------------------------------------------------
   U3B: process(CLK)
      variable inc : unsigned(1 downto 0);
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            area_fifo_rd_i <= '0';
            ctrl_fsm <= idle;
            imm_sol_sync_err <= '0';
            imm_clk_sync_err <= '0';
            user_area_err <= '0';
            gen_start_i <= '0';
            readout_info_valid <= '0';
            gen_rst_i <= '1';
            nominal_mclk_raw_en <= '0';     -- 21 mars 2021: on active mclk_raw par defaut en vue d'eviter des bugs 
            prog_mclk_raw_en <= '0';   
            elcorr_ref_enabled <= '0';
            img_in_progress_i <= '0'; 
            acq_data_i <= '0';
            data_sync_err <= '0';
            nominal_mclk_raw_last <= '0';
            prog_mclk_raw_last <= '0';
            line_pclk_cnt_last <= (others => '0'); 
            elcorr_tic <= '0';
            elcorr_tac <= '0';
            fpa_int_i       <= '0';
            fpa_int_last    <= '0';
            err_i <= (others => '0');
            ignore_fpa_dvalid <= '0';
            init_mclk_done <= '0';
            
         else   
            
            
            fpa_int_i       <= FPA_INT;
            fpa_int_last    <= fpa_int_i;
            
            nominal_mclk_raw_last <= NOMINAL_MCLK_RAW;
            prog_mclk_raw_last <= PROG_MCLK_RAW;
            
            fpa_mclk_re <= not fpa_mclk_last and fpa_mclk_i;
            fpa_mclk_fe <= fpa_mclk_last and not fpa_mclk_i; 
            
            ignore_fpa_dvalid <= FPA_INTF_CFG.COMN.FPA_DIAG_MODE or FPA_PROG_MODE or not FPA_POWERED;
            
            -----------------------------------------------------------------
            -- activation des flows de synchronisation                       
            -----------------------------------------------------------------
            case ctrl_fsm is
               
               when idle =>                  
                  flow_err   <= '0';
                  elcorr_tic <= '0';
                  elcorr_tac <= '0';
                  gen_rst_i  <= '0';
                  area_fifo_rd_i <= '0';
                  gen_start_i <= '0';
                  rst_cnt_i <= (others => '0');
                  wait_cnt <= (others => '0');
                  tir_dly_cnt <= (others => '0');
                  
                  -- horloge nominale par defaut
                  nominal_mclk_raw_en <= '1';
                  prog_mclk_raw_en    <= '0';
                  clk_area_b_i <= FPA_INTF_CFG.CLK_AREA_B;
                  if FPA_PROG_MODE = '1' then
                     nominal_mclk_raw_en <= '0';
                     prog_mclk_raw_en    <= '1';
                     clk_area_b_i.clk_id <= to_unsigned(DEFINE_FPA_MCLK1_ID, clk_area_b_i.clk_id'length);                   
                  end if;         
                  
                  -- integration
                  if FPA_INT = '1' then
                     gen_start_i <= '1';
                     acq_data_i  <= ACQ_INT;
                     img_in_progress_i <= '1';
                     ctrl_fsm <= wait_int_end_st;
                  end if;                  
               
               when wait_int_end_st =>                  
                  elcorr_tac <= '0';
                  if FPA_INT = '0' then 
                     gen_start_i <= '0';
                     if ignore_fpa_dvalid = '1' then
                        ctrl_fsm <= tir_dly_st;
                     else
                        ctrl_fsm <= wait_dvalid_st;
                     end if;
                     elcorr_tac <= '1'; 
                  end if;                  
               
               when wait_dvalid_st =>
                  if incoming_fpa_data = '1' then 
                     ctrl_fsm <= wait_flows_st;
                  end if;
               
               when tir_dly_st => 
                  if adc_ref_fe_pipe(0) = '1' then
                     tir_dly_cnt <= tir_dly_cnt + 1;
                  end if;
                  if tir_dly_cnt >= to_integer(FPA_INTF_CFG.TIR_DLY_ADC_CLK) then
                     ctrl_fsm <= wait_flows_st; 
                  end if;                     
               
               when wait_flows_st =>
                  if AREA_FIFO_EMPTY = '1' and fpa_mclk_fe = '1'  then    
                     flow_err <= '1';                                  -- aucune attente n'est autorisée ici
                  end if;
                  if AREA_FIFO_EMPTY = '0' and fpa_mclk_fe = '1' then  -- fpa_mclk_re assure une synchro
                     nominal_mclk_raw_en <= '0';    -- arrêt des horloges raw
                     ctrl_fsm <= active_flow_st;
                  end if;
               
               when active_flow_st => 
                  if adc_ref_fe_pipe(0) = '1' then -- pour une bonne synchronisation
                     elcorr_ref_enabled <= FPA_INTF_CFG.ELCORR_ENABLED; 
                     flow_err <= '0'; 
                     area_fifo_rd_i <= '1';                                -- lancement du window fifo   
                     readout_info_valid <= '1';
                     ctrl_fsm <= sync_flow_st;
                  end if;
               
               when sync_flow_st =>  -- ne pas changer l'ordre des étapes 1 et 2 car en cas de simulatneité la condition 2 doit prevaloir 
                  if AREA_FIFO_DATA.RAW.IMMINENT_AOI = '1'  then        -- etape2: l'entrée dans la zone user se fera à phase constante par rapport à l'horloge des ADCs
                     if adc_ref_fe_pipe(0) = '0' then                              -- si on n'est pas synchro déjà alors on s'en va se synchroniser sur adc_ref_fe_pipe(0) avant de sortir SOL
                        area_fifo_rd_i <= '0';
                        ctrl_fsm <= adc_sync_st;
                     else                                                           -- sinon, c'est qu'on est déjà synchro avec adc_ref_fe_pipe(FASTRD_SYNC_POS), alors on ne fait rien de particulier
                     end if;
                  end if;                     
                  if readout_info_i.aoi.read_end = '1' then                 -- etape3: détecter la fin de la fenetre 
                     ctrl_fsm <= nominal_clk_st;
                     readout_info_valid <= '0';
                  end if;
               
               when adc_sync_st =>      -- synchro avec adc_ref_clk_i et donc avec l'horloge des ADCs. Attention ne marchera parfiatement que si on prend un échantillon par pixel!!
                  if adc_ref_fe_pipe(0) = '1' then   -- la valeur de delai (x) vient de la simulation en vue de reduire les delais
                     ctrl_fsm <= sync_flow_st;
                     area_fifo_rd_i <= '1';
                  end if;               
               
               when nominal_clk_st =>  
                  area_fifo_rd_i <= '0';
                  if NOMINAL_MCLK_RAW = '0' and nominal_mclk_raw_last = '1' then 
                     nominal_mclk_raw_en <= '1';
                     prog_mclk_raw_en    <= '0'; 
                     ctrl_fsm <= gen_rst_st;
                  end if;
               
               when gen_rst_st =>    -- 
                  img_in_progress_i <= '0';
                  gen_rst_i <= '1';                          -- le upstream subit un reset 
                  rst_cnt_i <= rst_cnt_i + 1;
                  elcorr_tic <= '0'; 
                  init_mclk_done <= '1';
                  if rst_cnt_i(4) = '1' then
                     ctrl_fsm <= idle;
                  end if;                  
               
               when others =>
               
            end case;
            
            --------------------------------------------------------------
            -- error
            -------------------------------------------------------------- 
            line_pclk_cnt_last <= AREA_FIFO_DATA.RAW.LINE_PCLK_CNT;
            if AREA_FIFO_DATA.RAW.LINE_PCLK_CNT /= line_pclk_cnt_last then   -- le CLK_INFO.SOF arrive sur le front montant des pixels impairs 
               data_sync_err <= (area_fifo_rd_i and not AREA_FIFO_DATA.CLK_INFO.SOF);  -- SuperHawk: les changements de LINE_PCLK_CNT se font toujours sur le SOF d'un MCLK 
            end if; 
            err_i(0) <= data_sync_err or flow_err;  -- erreur qui ne doit jamais arriver
            if fifo_ovfl = '1' then
               err_i(1) <= '1'; 
            end if;
            
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------
   --  sortie des données
   --------------------------------------------------
   U4: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            elcorr_ref_fval_i <= '0';
            elcorr_ref_start_pipe <= (others => '0');
            elcorr_ref_end_pipe <= (others => '0');
            elcorr_ref_start_i <= '0';
            elcorr_ref_end_i <= '0';
            
            -- pragma translate_off                
            raw_window_i <= AREA_FIFO_DATA.RAW;          
            readout_info_i.aoi.samp_pulse <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            adc_ref_clk_last <= '0';
            adc_ref_clk_i <= '0';
            adc_ref_fe_pipe <= (others => '0');
            -- pragma translate_on
            
            read_start_last <= '0';
            read_end_last <= '0';
            fpa_mclk_i <= '0';
            
         else 
            
            -- pragma translate_off 
            raw_window_i <= AREA_FIFO_DATA.RAW; 
            -- pragma translate_on
            
            -- Clocks 
            fpa_mclk_i <= (AREA_FIFO_DATA.CLK_INFO.CLK and area_fifo_rd_i) or (NOMINAL_MCLK_RAW and nominal_mclk_raw_en) or (PROG_MCLK_RAW and prog_mclk_raw_en); 
            fpa_mclk_last <= fpa_mclk_i;
            
            -- 
            read_end_last <= readout_info_i.aoi.read_end;
            read_start_last <= readout_info_i.aoi.sof;
            
            -- elcorr_ref_start_i dure 1 PCLK             
            elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-2 downto 0) & elcorr_tic; -- Attention! le rd_end = debut de elc_ofs.
            if unsigned(elcorr_ref_start_pipe) /= 0 then
               elcorr_ref_start_i <= '1';
               elcorr_ref_fval_i  <= '1'; 
            else
               elcorr_ref_start_i <= '0';
            end if;
            
            -- elcorr_ref_end_i dure 1 PCLK
            elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-2 downto 0) & elcorr_tac; -- Attention! le sof  = fin de elc_ofs.
            if unsigned(elcorr_ref_end_pipe) /= 0 then
               elcorr_ref_end_i <= '1';
            else
               elcorr_ref_end_i  <= '0';
               if elcorr_ref_end_i = '1' then 
                  elcorr_ref_fval_i <= '0';
               end if;
            end if;
            
            -- samp_pulse_i 
            adc_ref_clk_i <= ADC_REF_CLK;
            adc_ref_clk_last <= adc_ref_clk_i;
            adc_ref_fe_pipe(0) <= adc_ref_clk_last and not adc_ref_clk_i;
            adc_ref_fe_pipe(15 downto 1) <= adc_ref_fe_pipe(14 downto 0);
            
            -- definition de read_end à la fin de RAW.FVAL et non USER.FVAL
            raw_fval_i    <= AREA_FIFO_DATA.RAW.FVAL;
            raw_fval_last <= raw_fval_i;         
            
            -- READOUT_INFO
            -- aoi
            readout_info_i.aoi.sof           <= AREA_FIFO_DATA.USER.SOF and area_fifo_rd_i;
            readout_info_i.aoi.eof           <= AREA_FIFO_DATA.USER.EOF and area_fifo_rd_i;
            readout_info_i.aoi.sol           <= AREA_FIFO_DATA.USER.SOL and area_fifo_rd_i;
            readout_info_i.aoi.eol           <= AREA_FIFO_DATA.USER.EOL and area_fifo_rd_i;
            readout_info_i.aoi.fval          <= AREA_FIFO_DATA.USER.FVAL and readout_info_valid;                -- pas de area_fifo_rd_i  sur fval sinon pb.
            readout_info_i.aoi.lval          <= AREA_FIFO_DATA.USER.LVAL and area_fifo_rd_i;
            readout_info_i.aoi.dval          <= AREA_FIFO_DATA.USER.DVAL and area_fifo_rd_i;
            readout_info_i.aoi.read_end      <= raw_fval_last and not raw_fval_i;                               -- raw_fval_i pour etre certain d'avoir détecté la fin de la fenetre raw. Sinon, l'offset dynamique pourrait se calculer durant le passage de l'horloge rapide. Et ce sera la catastrophe.
            readout_info_i.aoi.samp_pulse    <= adc_ref_fe_pipe(0) and AREA_FIFO_DATA.USER.FVAL and readout_info_valid;
            readout_info_i.aoi.spare(0)      <= acq_data_i;
            
            if FPA_INTF_CFG.SINGLE_SAMP_MODE_EN = '1' then 
               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_NOMINAL_MCLK_ID then
                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.NOMINAL_CLK_ID_SAMPLE_POS) then     -- on ne considere que le premier echantillon 
                     readout_info_i.aoi.dval    <= '0';
                  end if;
               end if;
               
               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_MCLK1_ID then
                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.FAST1_CLK_ID_SAMPLE_POS) then     -- on ne considere que le premier echantillon 
                     readout_info_i.aoi.dval    <= '0';
                  end if;
               end if;
               
               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_MCLK2_ID then
                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.FAST2_CLK_ID_SAMPLE_POS) then     -- on ne considere que le premier echantillon 
                     readout_info_i.aoi.dval    <= '0';
                  end if;
               end if;
            end if;
            
            -- naoi (contenu aussi dans readout_info)
            readout_info_i.naoi.ref_valid(1) <= ELCORR_REF_VALID(1);        -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= ELCORR_REF_VALID(0);        -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)
            readout_info_i.naoi.start        <= elcorr_ref_start_i;         -- start global de zone naoi
            readout_info_i.naoi.stop         <= elcorr_ref_end_i;           -- end global de zone naoi
            readout_info_i.naoi.dval         <= elcorr_ref_fval_i;
            readout_info_i.naoi.samp_pulse   <= adc_ref_fe_pipe(0) and elcorr_ref_fval_i;
            readout_info_i.samp_pulse        <= adc_ref_fe_pipe(0);    -- ENO: 25 mars 2021: samp_pulse doit toujoursêtre un pulse correspondant au Front Montant ou descendant de ADC_REF_CLK
            
         end if; 
      end if;
   end process; 
   
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
   -- generation fpa_inactive_int_i
   --------------------------------------------------
   UoB: process(CLK)
      
      variable mclk_cnt_inc : std_logic_vector(1 downto 0);
      
   begin
      if rising_edge(CLK) then
         if sreset = '1' then            
            int_reset_fsm <= idle;
            fpa_inactive_int_i <= '1'; 
            mclk_cnt_inc :=  (others => '0');
            
         else  
            
            mclk_cnt_inc := '0' & fpa_mclk_re;
            
            -- contrôleur
            case int_reset_fsm is           
               
               when idle =>   
                  fpa_inactive_int_i <= '1';
                  mclk_cnt <= 0;
                  if FPA_INT = '1' then        
                     int_reset_fsm <= active_rst_st;
                  end if; 
               
               when active_rst_st =>
                  mclk_cnt <= mclk_cnt + to_integer(unsigned(mclk_cnt_inc));
                  if mclk_cnt >= to_integer(FPA_INTF_CFG.ROIC.RESET_TIME_MCLK) then 
                     fpa_inactive_int_i <= '0';
                     int_reset_fsm <= wait_int_end_st;        
                  end if;
               
               when wait_int_end_st =>  -- on s'assure que l'integration est terminée 
                  if FPA_INT = '0' then  
                     int_reset_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
         
      end if;
   end process;    
   
end rtl;
