------------------------------------------------------------------
--!   @file : suphawkA_readout_kernel
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
use work.fastrd2_define.all; 

entity suphawkA_readout_kernel is
   port(
      
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      FPA_INT           : in std_logic;
      START_GEN         : out std_logic; 
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type; 
      
      -- horloges brutes et libres
      RAW_FPA_CLK       : in fpa_clk_info_type;
      
      -- fifos des horloges traitées et contrôlées      
      CLK_FIFO_EMPTY    : in std_logic;
      CLK_FIFO_EN       : out std_logic;
      CLK_FIFO_DATA     : in fpa_clk_base_info_type;
      CLK_FIFO_DVAL     : in std_logic;
      
      -- info adc
      ADC_REF_CLK       : in std_logic;
      ADC_SYNC_FLAG     : out std_logic_vector(15 downto 0); -- ENO : 05 oct 2017: divers flags à synchroniser sur donnnées ADC même si READOUT_INFO est absent. Utile par exemple pour calculer offset dynamique
      
      -- elcorr ref
      ELCORR_REF_VALID  : in std_logic_vector(1 downto 0);      
      
      -- outputs
      FPA_MCLK          : out std_logic;
      FPA_FDEM          : out std_logic;
      FPA_RD_MCLK       : out std_logic;         
      READOUT_INFO      : out readout_info_type;
      ADC_SYNC_FLAG     : out std_logic_vector(15 downto 0);
      READOUT_AOI_FVAL  : out std_logic;         
      
      AREA_FIFO_EMPTY   : in std_logic;
      AREA_FIFO_EN      : out std_logic;
      AREA_FIFO_DATA    : in window_info_type;
      AREA_FIFO_DVAL    : in std_logic;
      
      RST_AREA_GEN      : out std_logic;
      RAW_WINDOW        : out raw_area_type
      
      );
end suphawkA_readout_kernel;

architecture rtl of suphawkA_readout_kernel is
   
   constant C_FLAG_PIPE_LEN  : integer := DEFINE_ADC_QUAD_CLK_FACTOR;
   constant C_LSYNC_PIPE_LEN : integer := DEFINE_ADC_QUAD_CLK_FACTOR;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port ( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   type ctrl_fsm_type is (idle, chck_lsydel_speed_st, speedup_lsydel_clk_st, lsydel_dly_st, wait_flows_st, stop_raw_clk_st, mclk_pause_st, active_flow_st, sync_flow_st, adc_sync_st, prep_slow_clk_st, prep_fast_clk_st, default_clk_st, RST_AREA_GEN_st);   
   type adc_time_stamp_type is
   record
      naoi_stop  : std_logic;
      naoi_start : std_logic;  
      aoi_sof    : std_logic;  
      aoi_sol    : std_logic;     
   end record;  
   
begin    
   
   ----------------  ----------------------------------
   --  lecture des fifos et synchronisation
   --------------------------------------------------
   U3: process(CLK)
      variable inc : unsigned(1 downto 0);
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            ctrl_fsm <= idle;
            fdem_i <= '0';
            
         else  
            
            fpa_int_i <= FPA_INT;            
            fpa_int_last <= fpa_int_i;
            
            -----------------------------------------------------------------
            -- activation des flows de synchronisation                       
            -----------------------------------------------------------------
            case ctrl_fsm is
               
               when idle => 
                  fdem_i <= '0';
                  if fpa_int_last = '1' and fpa_int_i = '0' then -- fin d'une integration
                     ctrl_fsm <= wait_flows_st;
                  end if; 
               
               when wait_flows_st =>
                  if AREA_FIFO_DVAL = '1' and CLK_FIFO_DVAL = '1' then
                     ctrl_fsm <= sync_flow_st;  
                  end if;
               
               when sync_flow_st =>  -- ne pas changer l'ordre des étapes 1 et 2 car en cas de simulatneité la condition 2 doit prevaloir 
                  fifo_rd_i <= '1';
                  if AREA_FIFO_DATA.RAW.IMMINENT_CLK_CHANGE = '1' then      -- voir changement d'horloge
                     if adc_ref_fe_pipe(0) = '0' then                                     -- ETAPE 1 : si on n'est pas synchro déjà alors on s'en va se synchroniser sur adc_ref_fe_pipe(x)
                        fifo_rd_i <= '0';
                        ctrl_fsm  <= adc_sync_st;
                     else                                                                                -- sinon, c'est qu'on est déjà synchro avec adc_ref_fe_pipe(x), alors on ne fait rien de particulier
                     end if;
                     if AREA_FIFO_DATA.USER.DVAL = '1'  then                              -- ETAPE 2 : ne faire aucune resynchronisation dans la zone AOI même si un changement d'horloge est imminent puisque les changements dans la zone AOI se font en multiple entier de la periode nominale.
                        ctrl_fsm <= sync_flow_st;
                     end if;  
                  end if;
                  
                  if AREA_FIFO_DATA.RAW.RD_END = '1' and CLK_FIFO_DATA.EOF = '1' then     -- ETAPE 3 : détecter la fin d'une trame
                     ctrl_fsm <= default_clk_st;
                     fifo_rd_i <= '0';
                  end if;
               
               when adc_sync_st =>      
                  if adc_ref_fe_pipe(0) = '1' then   -- la valeur de x de adc_ref_fe_pipe (x) vient de la simulation en vue de reduire les delais
                     ctrl_fsm <= sync_flow_st;
                     fifo_rd_i <= '1'; 
                  end if;
               
               when default_clk_st =>
                  fifo_rd_i <= '0';                       -- tous les fifos sont arrêtés
                  if SLOW_MCLK_RAW = '0' and slow_mclk_raw_last = '1' then -- on s'assure qu'il n y a pas de pulse "tronqué" 
                     slow_mclk_raw_en_i <= '1';
                     ctrl_fsm <= rst_gen_st;
                  end if;
               
               when rst_gen_st =>    --                  
                  rst_gen <= '1';                          -- le upstream subit un reset de 16 CLK
                  rst_cnt_i <= rst_cnt_i + 1;
                  if rst_cnt_i(4) = '1' then
                     ctrl_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
            --------------------------------------------------------------
            -- misc
            --------------------------------------------------------------           
            err_i <= '0';  -- erreur qui ne doit jamais arriver
            
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
            readout_info_i.aoi.samp_pulse <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            adc_ref_clk_last <= '0';          
            adc_ref_clk_i <= '0';
            line_pclk_cnt_last <= (others => '0');
            data_sync_err <= '0';
            adc_ref_fe_pipe <= (others => '0');
            -- pragma translate_on
            
         else 
            
            -- pragma translate_off 
            raw_window_i <= AREA_FIFO_DATA.RAW;
            -- pragma translate_on
            
            line_pclk_cnt_last <= AREA_FIFO_DATA.RAW.LINE_PCLK_CNT;
            if AREA_FIFO_DATA.RAW.LINE_PCLK_CNT /= line_pclk_cnt_last then
               data_sync_err <= (slow_clk_fifo_rd_i and not slow_pclk_sof) or (fifo_rd_i and not fast_pclk_sof);
            end if;
            
            -- Clocks 
            fpa_mclk_i <= (slow_mclk and slow_clk_fifo_rd_i) or (fast_mclk and fifo_rd_i) or (SLOW_MCLK_RAW and slow_mclk_raw_en_i) or (FAST_MCLK_RAW and fast_mclk_raw_en_i) or (fast_lsydel_clk and fast_lsydel_clk_en_i); 
             
            fpa_mclk_last <= fpa_mclk_i;
            
            if fpa_int_i = '1' then 
               imminent_well_rst_i <= '0';
            else
               if AREA_FIFO_DATA.RAW.EOF = '1' and window_fifo_rd_i = '1' then 
                  imminent_well_rst_i <= '1';
               end if;
            end if;
            
            -- LSYNC
            last_lsync_pipe(C_LSYNC_PIPE_LEN-1 downto 0) <= last_lsync_pipe(C_LSYNC_PIPE_LEN-2 downto 0) & (AREA_FIFO_DATA.RAW.LSYNC and window_fifo_rd_i and imminent_well_rst_i); 
            last_lsync_i <= last_lsync_pipe(C_LSYNC_PIPE_LEN-2);
            
            fpa_lsync_i <= (AREA_FIFO_DATA.RAW.LSYNC and window_fifo_rd_i and not imminent_well_rst_i) or last_lsync_i;         
            
            -- 
            read_end_last <= readout_info_i.aoi.read_end;
            
            -- elcorr_ref_start_i dure 1 PCLK             
            elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (not read_end_last and readout_info_i.aoi.read_end); 
            if unsigned(elcorr_ref_start_pipe) /= 0 then
               elcorr_ref_start_i <= '1';
               elcorr_ref_fval_i  <= '1'; 
            else
               elcorr_ref_start_i <= '0';
            end if;
            
            -- elcorr_ref_end_i dure 1 PCLK
            elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (not fpa_int_last and fpa_int_i); -- Attention! le rising_Edge de Int = fin de elc_ofs. Cela ne marchera qu'en ITR 
            if unsigned(elcorr_ref_end_pipe) /= 0 then
               elcorr_ref_end_i <= '1';
            else
               elcorr_ref_end_i  <= '0';
               if elcorr_ref_end_i = '1' then 
                  elcorr_ref_fval_i <= '0';
               end if;
            end if;
            
            -- samp_pulse_i 
            adc_ref_clk_i <= QUAD_CLK_COPY;
            adc_ref_clk_last <= adc_ref_clk_i;
            adc_ref_fe_pipe(0) <= adc_ref_clk_last and not adc_ref_clk_i;
            adc_ref_fe_pipe(15 downto 1) <= adc_ref_fe_pipe(14 downto 0);
            
            -- definition de read_end à la fin de RAW.FVAL et non USER.FVAL
            raw_fval_i    <= AREA_FIFO_DATA.RAW.FVAL;
            raw_fval_last <= raw_fval_i;         
            
            -- READOUT_INFO
            -- aoi
            readout_info_i.aoi.sof           <= AREA_FIFO_DATA.USER.SOF and window_fifo_rd_i;
            readout_info_i.aoi.eof           <= AREA_FIFO_DATA.USER.EOF and window_fifo_rd_i;
            readout_info_i.aoi.sol           <= AREA_FIFO_DATA.USER.SOL and window_fifo_rd_i;
            readout_info_i.aoi.eol           <= AREA_FIFO_DATA.USER.EOL and window_fifo_rd_i;
            readout_info_i.aoi.fval          <= AREA_FIFO_DATA.USER.FVAL and readout_info_valid;                -- pas de window_fifo_rd_i  sur fval sinon pb.
            readout_info_i.aoi.lval          <= AREA_FIFO_DATA.USER.LVAL and window_fifo_rd_i;
            readout_info_i.aoi.dval          <= AREA_FIFO_DATA.USER.DVAL and window_fifo_rd_i;
            readout_info_i.aoi.read_end      <= raw_fval_last and not raw_fval_i;                               -- raw_fval_i pour etre certain d'avoir détecté la fin de la fenetre raw. Sinon, l'offset dynamique pourrait se calculer durant le passage de l'horloge rapide. Et ce sera la catastrophe.
            readout_info_i.aoi.samp_pulse    <= adc_ref_fe_pipe(0) and AREA_FIFO_DATA.USER.FVAL and readout_info_valid;
            
            -- naoi (contenu aussi dans readout_info)
            readout_info_i.naoi.ref_valid(1) <= REF_VALID(1);        -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= REF_VALID(0);        -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)
            readout_info_i.naoi.start        <= elcorr_ref_start_i;  -- start global de zone naoi
            readout_info_i.naoi.stop         <= elcorr_ref_end_i;    -- end global de zone naoi
            readout_info_i.naoi.dval         <= elcorr_ref_fval_i;
            readout_info_i.naoi.samp_pulse   <= adc_ref_fe_pipe(0) and elcorr_ref_fval_i;
            
            readout_info_i.samp_pulse        <= adc_ref_fe_pipe(0);
            
            -- ADC_FLAGS
            -- flags temps reel enovoyés vers le synchronisateur d'adc pour time stamping des données ADC
            adc_time_stamp.naoi_start        <= elcorr_ref_start_i;
            adc_time_stamp.naoi_stop         <= elcorr_ref_end_i;
            adc_time_stamp.aoi_sof           <= AREA_FIFO_DATA.USER.SOF and window_fifo_rd_i;
            adc_time_stamp.aoi_sol           <= AREA_FIFO_DATA.USER.SOL and window_fifo_rd_i;
            
            -- well rst
            well_rst_start_i <= last_lsync_i;
            
         end if; 
      end if;
   end process;    
   
end rtl;
