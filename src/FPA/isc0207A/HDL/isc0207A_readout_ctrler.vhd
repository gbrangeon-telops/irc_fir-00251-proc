------------------------------------------------------------------
--!   @file : mglk_DOUT_DVALiter
--!   @brief
--!   @details
--!
--!   $Rev: 23358 $
--!   $Author: enofodjie $
--!   $Date: 2019-04-22 09:21:28 -0400 (lun., 22 avr. 2019) $
--!   $Id: isc0207A_readout_ctrler.vhd 23358 2019-04-22 13:21:28Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/isc0207A/HDL/isc0207A_readout_ctrler.vhd $
------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all; 

entity isc0207A_readout_ctrler is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic; 
      
      FPA_PCLK          : in std_logic;  -- FPA_PCLK est l'horloge des pixels. Il peut valoir soit 1xMCLK (par ex. Hawk) ou 2xMCLK (par ex. Indigo).    
      FPA_MCLK          : in std_logic;  -- 
      FPA_INTF_CFG      : in fpa_intf_cfg_type;      
      FPA_INT           : in std_logic;  -- 
      --FPA_INT_FDBK      : in std_logic;  -- 
      
      
      QUAD_CLK_COPY     : in std_logic;
      REF_VALID         : in std_logic_vector(1 downto 0);
      
      READOUT_INFO      : out readout_info_type;
      ADC_SYNC_FLAG     : out std_logic_vector(15 downto 0)      
      );  
end isc0207A_readout_ctrler;


architecture rtl of isc0207A_readout_ctrler is
   
   constant C_FLAG_PIPE_LEN : integer := DEFINE_ADC_QUAD_CLK_FACTOR;
   constant C_PIPE_POS      : integer := 3;
   
   type readout_fsm_type is (idle, readout_st, wait_mclk_fe_st, wait_readout_end_st);
   type line_cnt_pipe_type is array (0 to 3) of unsigned(10 downto 0);
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   signal sreset               : std_logic;
   
   signal readout_fsm          : readout_fsm_type;
   signal fpa_int_i            : std_logic;
   signal fpa_int_last         : std_logic;
   signal fpa_pclk_last        : std_logic;
   signal adc_sync_flag_i      : std_logic_vector(ADC_SYNC_FLAG'LENGTH-1 downto 0);
   signal pclk_fall            : std_logic;
   signal pclk_rise            : std_logic;
   signal fval_pclk_cnt        : unsigned(FPA_INTF_CFG.RAW_AREA.READOUT_PCLK_CNT_MAX'LENGTH-1 downto 0); 
   signal lval_pclk_cnt        : unsigned(FPA_INTF_CFG.RAW_AREA.LINE_PERIOD_PCLK'LENGTH-1 downto 0);
   signal quad_clk_copy_i      : std_logic;
   signal quad_clk_copy_last   : std_logic;
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
   signal line_cnt             : unsigned(FPA_INTF_CFG.RAW_AREA.WINDOW_LSYNC_NUM'LENGTH-1 downto 0);
   signal line_cnt_pipe        : line_cnt_pipe_type;
   signal fpa_mclk_last        : std_logic;
   signal sol_pipe_pclk        : std_logic_vector(1 downto 0);
   --signal fpa_int_fdbk_i       : std_logic;
   
   signal elcorr_ref_start_pipe  : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_pipe    : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_i       : std_logic;
   signal elcorr_ref_start_i     : std_logic;
   signal readout_info_i       : readout_info_type;
   signal eof_pulse            : std_logic;
   signal eof_pulse_last       : std_logic;
   signal elcorr_ref_fval_i      : std_logic;
   
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------  
   ADC_SYNC_FLAG <= adc_sync_flag_i;        -- 
   READOUT_INFO  <= readout_info_i; 
   
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
         adc_sync_flag_i(15 downto 4)  <= (others => '0');    -- non utilisé
         adc_sync_flag_i(3)  <= readout_info_i.naoi.stop;
         adc_sync_flag_i(2)  <= readout_info_i.naoi.start;
         adc_sync_flag_i(1)  <= readout_info_i.aoi.sof;                                    -- frame_flag(doit durer 1 CLK ADC au minimum). Dval_pipe permet de s'assurer que seuls les sol de la zone usager sont envoyés. Sinon, bjr les problèmes.   
         adc_sync_flag_i(0)  <= readout_info_i.aoi.sol;               -- line_flag (doit durer 1 CLK ADC au minimum). Dval_pipe permet de s'assurer que seuls les sol de la zone usager sont envoyés. Sinon, bjr les problèmes.   
      end if;
   end process;   
   
   --------------------------------------------------
   -- generation sync_flag
   --------------------------------------------------
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then                  
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i;
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
            
         else           
            
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i;
            
            fpa_pclk_last <= FPA_PCLK;
            
            pclk_rise <= not fpa_pclk_last and FPA_PCLK; 
            pclk_fall <= fpa_pclk_last and not FPA_PCLK;
            
            fpa_mclk_last <= FPA_MCLK;             
            
            -- elcorr_ref_start_i dure 1 PCLK
            eof_pulse <= eof_pipe(C_PIPE_POS) and dval_pipe(C_PIPE_POS);
            eof_pulse_last <= eof_pulse;
            elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (eof_pulse_last and not eof_pulse); 
            if unsigned(elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-1 downto 0)) /= 0 then
               elcorr_ref_start_i <= '1';
               elcorr_ref_fval_i  <= '1'; 
            else
               elcorr_ref_start_i <= '0';
            end if;
            
            -- elcorr_ref_end_i dure 1 PCLK
            elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (not fpa_int_last and fpa_int_i); -- Attention! le rising_Edge de Int = fin de elc_ofs. Cela ne marchera qu'en ITR 
            if unsigned(elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-1 downto 0)) /= 0 then
               elcorr_ref_end_i <= '1';
            else
               elcorr_ref_end_i  <= '0';
               if elcorr_ref_end_i = '1' then 
                  elcorr_ref_fval_i <= '0';
               end if;
            end if;
            
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
            
            -- naoi : ENO: 22 avril 2019: dans les flags importants du naoi, rajouter toujours DEFINE_GENERATE_ELCORR_CHAIN pour eviter des bugs de non sortie d'images
            -- en clair ne jamais generer les signaux naoi si DEFINE_GENERATE_ELCORR_CHAIN = 0.
            -- REF_VALID n'est pas generé si DEFINE_GENERATE_ELCORR_CHAIN = 0 donc initule de rajouter DEFINE_GENERATE_ELCORR_CHAIN 
            readout_info_i.naoi.ref_valid(1) <= REF_VALID(1);        -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= REF_VALID(0);        -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)
            readout_info_i.naoi.start        <= elcorr_ref_start_i and DEFINE_GENERATE_ELCORR_CHAIN;
            readout_info_i.naoi.stop         <= elcorr_ref_end_i and DEFINE_GENERATE_ELCORR_CHAIN;
            readout_info_i.naoi.dval         <= elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            readout_info_i.naoi.samp_pulse   <= (quad_clk_copy_last and not quad_clk_copy_i) and elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;      
            
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
            
         else  
            
            -- contrôleur
            case readout_fsm is           
               
               when idle =>   
                  readout_in_progress <= '0';
                  if fpa_int_i = '0' and fpa_int_last = '1' then -- debut readout image = fin de l'integration
                     readout_fsm <= wait_mclk_fe_st;
                  end if;
               
               when wait_mclk_fe_st => 
                  if pclk_rise = '1' then                                      -- on attend la tombée de la MCLK pour eviter des troncatures 
                     readout_fsm <= readout_st;
                  end if;                           
               
               when readout_st =>                   
                  readout_in_progress <= '1';
                  readout_fsm <= wait_readout_end_st;          
               
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
         
         if lval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.LINE_PERIOD_PCLK and pclk_fall = '1' then       -- periode du referentiel ligne
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
         -------------------------
         -- pipe 0 pour generation identificateurs 
         -------------------------
         if fval_pclk_cnt = 1 then                                   -- fval
            fval_pipe(0) <= '1';
         elsif fval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.READOUT_PCLK_CNT_MAX then
            fval_pipe(0) <= '0';
         end if;
         
         if lval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.SOL_POSL_PCLK then          -- lval
            lval_pipe(0) <= '1';
         elsif lval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.EOL_POSL_PCLK_P1 then
            lval_pipe(0) <= '0';
         end if;    
         
         if lval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.SOL_POSL_PCLK then          -- sol
            sol_pipe(0) <= '1';                                  
         else
            sol_pipe(0) <= '0';
         end if;
         
         if lval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.EOL_POSL_PCLK then         -- eol
            eol_pipe(0) <= '1';
         else
            eol_pipe(0) <= '0';
         end if;
         
         if fval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.SOF_POSF_PCLK then         -- sof
            sof_pipe(0) <= '1';
         else
            sof_pipe(0) <= '0';
         end if;
         
         if fval_pclk_cnt = FPA_INTF_CFG.RAW_AREA.EOF_POSF_PCLK then         -- eof
            eof_pipe(0) <= '1';
         else
            eof_pipe(0) <= '0';        
         end if;
         
         rd_end_pipe(0) <= fval_pipe(1) and not fval_pipe(0); -- read_end se trouve en dehors de fval. C'est voulu. le suivre pour comprendre ce qu'il fait.
         
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
         if  line_cnt_pipe(1) >= FPA_INTF_CFG.USER_AREA.LINE_START_NUM then 
            active_line_en1 <= '1';
         else
            active_line_en1 <= '0';
         end if;                  
         
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
         if line_cnt_pipe(2) <= FPA_INTF_CFG.RAW_AREA.WINDOW_LSYNC_NUM then  
            dval_pipe(3)   <= active_line_en1 and lval_pipe(2); 
         else
            dval_pipe(3)   <= '0';
         end if;
         
         global_reset <= sreset or rd_end_pipe(2);
         
         -- generation de samp_pulse_i : on echantillonne les signaux fval, lval etc avec samp_pulse_i
         quad_clk_copy_i <= QUAD_CLK_COPY;
         quad_clk_copy_last <= quad_clk_copy_i;
         samp_pulse_pipe(3) <= ((quad_clk_copy_last and not quad_clk_copy_i)and fval_pipe(2)); 
         
         -------------------------
         -- reset des identificateurs
         -------------------------
         if global_reset = '1' then
            line_cnt <= (others => '0');
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
      end if;
   end process; 
   
end rtl;
