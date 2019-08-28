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
      CLK_FIFO_RD       : out std_logic;
      CLK_FIFO_DATA     : in fpa_clk_base_info_type;
      CLK_FIFO_DVAL     : in std_logic;
      
      -- info adc
      ADC_REF_CLK       : in std_logic;
      
      -- elcorr ref
      ELCORR_REF_VALID  : in std_logic_vector(1 downto 0);      
      
      AREA_FIFO_EMPTY   : in std_logic;
      AREA_FIFO_RD      : out std_logic;
      AREA_FIFO_DATA    : in area_info_type;
      AREA_FIFO_DVAL    : in std_logic;
      
      -- outputs
      FPA_FDEM          : out std_logic;
      FPA_RD_MCLK       : out std_logic;         
      READOUT_INFO      : out readout_info_type;
      READOUT_AOI_FVAL  : out std_logic;
      ADC_SYNC_FLAG     : out std_logic_vector(15 downto 0); -- ENO : 05 oct 2017: divers flags à synchroniser sur donnnées ADC même si READOUT_INFO est absent. Utile par exemple pour calculer offset dynamique
      
      ERR               : out std_logic;
      RST_GEN           : out std_logic;
      RAW_AREA          : out area_type
      
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
   
   type ctrl_fsm_type is (idle, wait_flows_st, sync_flow_st, adc_sync_st, rst_gen_st);   
   type adc_time_stamp_type is
   record
      naoi_stop  : std_logic;
      naoi_start : std_logic;  
      aoi_sof    : std_logic;  
      aoi_sol    : std_logic;     
   end record;
   
   signal ctrl_fsm               : ctrl_fsm_type;
   signal sreset                 : std_logic;
   signal fdem_i                 : std_logic;
   signal fpa_rd_mclk_i          : std_logic;
   signal fpa_rd_mclk_last       : std_logic;
   signal fifo_rd_i              : std_logic;
   signal data_sync_err          : std_logic;
   signal line_pclk_cnt_last     : unsigned(AREA_FIFO_DATA.RAW.LINE_PCLK_CNT'LENGTH-1 downto 0);
   signal raw_area_i             : area_type;
   signal adc_ref_fe_pipe        : std_logic_vector(63 downto 0) := (others => '0');
   signal err_i                  : std_logic;
   signal start_gen_i            : std_logic;
   signal readout_info_valid     : std_logic;
   signal fpa_int_i              : std_logic;
   signal fpa_int_last           : std_logic;
   signal rst_gen_i              : std_logic;
   signal rst_cnt_i              : unsigned(7 downto 0);
   
   signal elcorr_ref_start_pipe  : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_pipe    : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_i       : std_logic;
   signal elcorr_ref_start_i     : std_logic;
   signal readout_info_i         : readout_info_type;
   signal eof_pulse              : std_logic;
   signal eof_pulse_last         : std_logic;
   signal elcorr_ref_fval_i      : std_logic;
   signal elcorr_ref_valid_i     : std_logic_vector(1 downto 0);
   signal adc_ref_clk_i          : std_logic;
   signal adc_ref_clk_last       : std_logic;
   signal adc_sync_flag_i        : std_logic_vector(ADC_SYNC_FLAG'LENGTH-1 downto 0);
   signal raw_area_rd_end        : std_logic;
   
begin    
   
   ---------------------------------------------------
   --  outputs maps
   -------------------------------------------------- 
   CLK_FIFO_RD       <= fifo_rd_i;
   AREA_FIFO_RD      <= fifo_rd_i;
   START_GEN         <= start_gen_i;
   RST_GEN           <= rst_gen_i;
   
   FPA_FDEM          <= fdem_i;
   FPA_RD_MCLK       <= fpa_rd_mclk_i;
   READOUT_INFO      <= readout_info_i;
   ADC_SYNC_FLAG     <= adc_sync_flag_i;
   READOUT_AOI_FVAL  <= readout_info_i.aoi.fval;
   RAW_AREA          <= raw_area_i;
   
   
   
   ---------------------------------------------------
   --  lecture des fifos et synchronisation
   --------------------------------------------------
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            ctrl_fsm <= idle;
            fdem_i <= '0';
            fifo_rd_i <= '0';
            readout_info_valid <= '0';
            rst_gen_i <= '1';
         else  
            
            fpa_int_i <= FPA_INT;            
            fpa_int_last <= fpa_int_i; 
            
            -----------------------------------------------------------------
            -- activation des flows area et clk                      
            -----------------------------------------------------------------
            case ctrl_fsm is
               
               when idle => 
                  fdem_i <= '0';
                  fifo_rd_i <= '0';
                  readout_info_valid <= '0';
                  rst_gen_i <= '0';
                  start_gen_i <= fpa_int_i;
                  rst_cnt_i <= (others => '0'); 
                  if fpa_int_last = '1' and fpa_int_i = '0' then -- fin d'une integration
                     ctrl_fsm <= wait_flows_st;
                  end if; 
               
               when wait_flows_st =>
                  start_gen_i <= '0';
                  if AREA_FIFO_DVAL = '1' and CLK_FIFO_DVAL = '1' then
                     ctrl_fsm <= sync_flow_st;
                     readout_info_valid <= '1';
                  end if;
               
               when sync_flow_st =>  -- ne pas changer l'ordre des étapes 1 et 2 car en cas de simulatneité la condition 2 doit prevaloir 
                  fifo_rd_i <= '1';                  
                  
                  if AREA_FIFO_DATA.RAW.IMMINENT_AOI = '1' then      -- voir changement d'horloge
                     if adc_ref_fe_pipe(0) = '0' then                                     -- ETAPE 1 : si on n'est pas synchro déjà alors on s'en va se synchroniser sur adc_ref_fe_pipe(x)
                        fifo_rd_i <= '0';
                        ctrl_fsm  <= adc_sync_st;
                     else                                                                                -- sinon, c'est qu'on est déjà synchro avec adc_ref_fe_pipe(x), alors on ne fait rien de particulier
                     end if;
                  end if;
                  
                  if AREA_FIFO_DATA.RAW.RD_END = '1' and CLK_FIFO_DATA.EOF = '1' then     -- ETAPE 2 : détecter la fin d'une trame
                     ctrl_fsm <= rst_gen_st;                          -- pour un suphawk, pas besoin d'envoyer de clock apres le reset des puits
                     fifo_rd_i <= '0';
                     readout_info_valid <= '0';
                  end if;
               
               when adc_sync_st =>      
                  if adc_ref_fe_pipe(0) = '1' then                    -- la valeur de x de adc_ref_fe_pipe (x) vient de la simulation en vue de reduire les delais
                     ctrl_fsm <= sync_flow_st;
                     fifo_rd_i <= '1'; 
                  end if;
               
               when rst_gen_st =>    --                  
                  rst_gen_i <= '1';                                      -- le upstream subit un reset de 16 CLK
                  rst_cnt_i <= rst_cnt_i + 1;
                  if rst_cnt_i(4) = '1' then
                     ctrl_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
            --------------------------------------------------------------
            -- misc
            --------------------------------------------------------------           
            err_i <= data_sync_err;  -- erreur qui ne doit jamais arriver
            
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
            elcorr_ref_start_pipe <= (others => '0');
            elcorr_ref_end_pipe <= (others => '0');
            elcorr_ref_start_i <= '0';
            elcorr_ref_fval_i <= '0';
            elcorr_ref_end_i <= '0';
            readout_info_i.aoi.dval <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            readout_info_i.naoi.start <= '0';
            readout_info_i.naoi.stop <= '0';
            fpa_int_i <= FPA_INT;            
            fpa_int_last <= fpa_int_i;
            eof_pulse <= '0';
            eof_pulse_last <= '0';
            elcorr_ref_valid_i <= (others => '0');
            raw_area_rd_end <= '0';
            
            -- pragma translate_off                
            adc_ref_clk_last <= '0';          
            adc_ref_clk_i <= '0';
            line_pclk_cnt_last <= (others => '0');
            data_sync_err <= '0';
            adc_ref_fe_pipe <= (others => '0');
            -- pragma translate_on
            
         else 
            
            -- pragma translate_off 
            raw_area_i <= AREA_FIFO_DATA.RAW;
            -- pragma translate_on
            
            line_pclk_cnt_last <= AREA_FIFO_DATA.RAW.LINE_PCLK_CNT;
            if AREA_FIFO_DATA.RAW.LINE_PCLK_CNT /= line_pclk_cnt_last then
               data_sync_err <= (fifo_rd_i and not CLK_FIFO_DATA.SOF);  -- SuperHawk: les changements de LINE_PCLK_CNT se font toujours sur le SOF d'un MCLK 
            end if;
            
            -- Clocks 
            fpa_rd_mclk_i <=  CLK_FIFO_DATA.CLK and fifo_rd_i;            
            fpa_rd_mclk_last <= fpa_rd_mclk_i;
            
            -- elcorr_ref_start_i dure 1 PCLK             
            elcorr_ref_start_i <= readout_info_i.aoi.read_end;
            if readout_info_i.aoi.read_end = '1' then 
               elcorr_ref_fval_i  <= '1'; 
            end if;
            
            -- elcorr_ref_end_i dure 1 PCLK
            elcorr_ref_end_i <= raw_area_rd_end;
            if elcorr_ref_end_i = '1' and raw_area_rd_end = '0' then 
               elcorr_ref_fval_i <= '0';
            end if;
            
            -- elcorr calculé uniquement avec les données de la ligne de reset
            if elcorr_ref_start_i = '1' then
               elcorr_ref_valid_i <= ELCORR_REF_VALID;
            elsif raw_area_rd_end = '1' then
               elcorr_ref_valid_i <= (others => '0');
            end if;
            
            
            raw_area_rd_end <= AREA_FIFO_DATA.RAW.RD_END and fifo_rd_i;
            
            -- aoi
            readout_info_i.aoi.sof           <= AREA_FIFO_DATA.USER.SOF and fifo_rd_i;
            readout_info_i.aoi.eof           <= AREA_FIFO_DATA.USER.EOF and fifo_rd_i;
            readout_info_i.aoi.sol           <= AREA_FIFO_DATA.USER.SOL and fifo_rd_i;
            readout_info_i.aoi.eol           <= AREA_FIFO_DATA.USER.EOL and fifo_rd_i;
            readout_info_i.aoi.fval          <= AREA_FIFO_DATA.USER.FVAL and readout_info_valid;                -- pas de fifo_rd_i  sur fval sinon pb.
            readout_info_i.aoi.lval          <= AREA_FIFO_DATA.USER.LVAL and fifo_rd_i;
            readout_info_i.aoi.dval          <= AREA_FIFO_DATA.USER.DVAL and fifo_rd_i;
            readout_info_i.aoi.read_end      <= AREA_FIFO_DATA.USER.RD_END and fifo_rd_i;                               -- raw_fval_i pour etre certain d'avoir détecté la fin de la fenetre raw. Sinon, l'offset dynamique pourrait se calculer durant le passage de l'horloge rapide. Et ce sera la catastrophe.
            readout_info_i.aoi.samp_pulse    <= adc_ref_fe_pipe(0) and AREA_FIFO_DATA.USER.FVAL and readout_info_valid;
                        
            -- naoi
            readout_info_i.naoi.ref_valid(1) <= elcorr_ref_valid_i(1) and DEFINE_GENERATE_ELCORR_CHAIN;         -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= elcorr_ref_valid_i(0) and DEFINE_GENERATE_ELCORR_CHAIN;         -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)            
            readout_info_i.naoi.start        <= elcorr_ref_start_i and DEFINE_GENERATE_ELCORR_CHAIN;         -- start du naoi correspond au debut de la ligne de reset pour un superhawk
            readout_info_i.naoi.stop         <= elcorr_ref_end_i and DEFINE_GENERATE_ELCORR_CHAIN;           -- end du naoi correspond à la fin de la ligne de reset pour un superhawk
            readout_info_i.naoi.dval         <= elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            readout_info_i.naoi.samp_pulse   <= adc_ref_fe_pipe(0) and elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            
            readout_info_i.samp_pulse         <= adc_ref_fe_pipe(0);             
            
            -- samp_pulse_i 
            adc_ref_clk_i <= ADC_REF_CLK;
            adc_ref_clk_last <= adc_ref_clk_i;
            adc_ref_fe_pipe(0) <= adc_ref_clk_last and not adc_ref_clk_i;
            adc_ref_fe_pipe(15 downto 1) <= adc_ref_fe_pipe(14 downto 0);
            --            
            
         end if; 
      end if;
   end process;
   
   --------------------------------------------------
   -- definition sync_flag
   --------------------------------------------------
   Ud: process(CLK)
   begin
      if rising_edge(CLK) then 
         adc_sync_flag_i(15 downto 4)  <= (others => '0');    -- non utilisé
         adc_sync_flag_i(3)  <= readout_info_i.naoi.stop and readout_info_i.naoi.dval;
         adc_sync_flag_i(2)  <= readout_info_i.naoi.start and readout_info_i.naoi.dval;
         adc_sync_flag_i(1)  <= readout_info_i.aoi.sof and readout_info_i.aoi.dval;                                    -- frame_flag(doit durer 1 CLK ADC au minimum). Dval_pipe permet de s'assurer que seuls les sol de la zone usager sont envoyés. Sinon, bjr les problèmes.   
         adc_sync_flag_i(0)  <= readout_info_i.aoi.sol and readout_info_i.aoi.dval;               -- line_flag (doit durer 1 CLK ADC au minimum). Dval_pipe permet de s'assurer que seuls les sol de la zone usager sont envoyés. Sinon, bjr les problèmes.   
      end if;
   end process;
   
end rtl;
