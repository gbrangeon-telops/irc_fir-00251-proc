------------------------------------------------------------------
--!   @file : mglk_DOUT_DVALiter
--!   @brief
--!   @details
--!
--!   $Rev: 22861 $
--!   $Author: enofodjie $
--!   $Date: 2019-02-13 17:51:56 -0500 (mer., 13 fÃ©vr. 2019) $
--!   $Id: suphawkA_readout_ctrler.vhd 22861 2019-02-13 22:51:56Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/suphawkA/HDL/suphawkA_readout_ctrler.vhd $
------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all; 

entity suphawkA_readout_ctrler is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic; 
      
      FPA_PCLK          : in std_logic;  -- FPA_PCLK est l'horloge des pixels. Il peut valoir soit 1xMCLK (par ex. suphawk) ou 2xMCLK (par ex. Indigo).    
      FPA_MCLK          : in std_logic;  -- 
      FPA_INTF_CFG      : in fpa_intf_cfg_type;      
      FPA_INT           : in std_logic;  -- 
      FPA_INT_FDBK      : in std_logic;  --     
      
      QUAD_CLK_COPY     : in std_logic;
      
      FPA_FDEM          : out std_logic;
      FPA_RD_MCLK       : out std_logic;         
      READOUT_INFO      : out readout_info_type;
      ADC_SYNC_FLAG     : out std_logic_vector(15 downto 0);
      READOUT_AOI_FVAL  : out std_logic;
      
      REF_VALID         : in std_logic_vector(1 downto 0)
      );  
end suphawkA_readout_ctrler;


architecture rtl of suphawkA_readout_ctrler is
   
   constant C_FLAG_PIPE_LEN : integer := DEFINE_ADC_QUAD_CLK_FACTOR;
   constant C_PIPE_POS      : integer := 3;
   
   type sync_flag_fsm_type is (idle, sync_flag_on_st, sync_flag_off_st, wait_img_begin_st, wait_img_end_st);
   type readout_fsm_type is (idle, readout_st, wait_mclk_fe_st1, wait_mclk_fe_st2, wait_readout_end_st);
   type line_cnt_pipe_type is array (0 to 3) of unsigned(10 downto 0);
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   signal sreset               : std_logic;
   
   signal sync_flag_fsm        : sync_flag_fsm_type;
   signal readout_fsm          : readout_fsm_type;
   signal fpa_int_last         : std_logic;
   signal fpa_pclk_last        : std_logic;
   signal fpa_int_fdbk_last    : std_logic;
   signal pclk_fall            : std_logic;
   signal pclk_rise            : std_logic;
   signal fval_pclk_cnt        : unsigned(FPA_INTF_CFG.READOUT_PCLK_CNT_MAX'LENGTH-1 downto 0); 
   signal lval_pclk_cnt        : unsigned(FPA_INTF_CFG.LINE_PERIOD_PCLK'LENGTH-1 downto 0);
   signal quad_clk_copy_i      : std_logic;
   signal quad_clk_copy_last   : std_logic;
   signal adc_sync_flag_i      : std_logic_vector(ADC_SYNC_FLAG'LENGTH-1 downto 0);
   signal fdem_i               : std_logic;
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
   signal flags_reset         : std_logic;
   signal lsync_pipe           : std_logic_vector(7 downto 0);
   signal line_cnt             : unsigned(FPA_INTF_CFG.ACTIVE_LINE_END_NUM'LENGTH-1 downto 0);
   signal fpa_mclk_last        : std_logic;
   signal sol_pipe_pclk        : std_logic_vector(1 downto 0); 
   signal rd_mclk_i            : std_logic;
   signal line_cnt_pipe        : line_cnt_pipe_type;
   signal fpa_int_fdbk_i       : std_logic;
   signal fpa_int_i            : std_logic;
   
   signal elcorr_start_pipe    : std_logic_vector(15 downto 0);
   signal elcorr_end_pipe      : std_logic_vector(15 downto 0);
   signal elcorr_end_i         : std_logic;
   signal elcorr_start_i       : std_logic;
   signal readout_info_i       : readout_info_type;
   signal eof_pulse            : std_logic;
   signal eof_pulse_last       : std_logic;
   signal elcorr_fval_i        : std_logic;
   signal ref_valid_i          : std_logic_vector(1 downto 0);
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------  
   FPA_RD_MCLK <= rd_mclk_i;              
   ADC_SYNC_FLAG <= adc_sync_flag_i;    -- non utilisé  
   READOUT_INFO  <= readout_info_i;      
   FPA_FDEM <= fdem_i;
   READOUT_AOI_FVAL <= readout_info_i.aoi.fval;
   
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
         adc_sync_flag_i(3)  <= readout_info_i.naoi.stop and readout_info_i.naoi.dval;
         adc_sync_flag_i(2)  <= readout_info_i.naoi.start and readout_info_i.naoi.dval;
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
            sync_flag_fsm <= idle;
            fdem_i <= '0';
            fpa_int_fdbk_last <= fpa_int_fdbk_i;
            elcorr_start_pipe <= (others => '0');
            elcorr_end_pipe <= (others => '0');
            elcorr_start_i <= '0';
            elcorr_fval_i <= '0';
            elcorr_end_i <= '0';
            readout_info_i.aoi.dval <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            readout_info_i.naoi.start <= '0';
            readout_info_i.naoi.stop <= '0';
            fpa_int_i <= FPA_INT;            
            fpa_int_last <= fpa_int_i;
            eof_pulse <= '0';
            eof_pulse_last <= '0';
            ref_valid_i <= (others => '0');
            
         else           
            
            fpa_int_fdbk_i <= FPA_INT_FDBK;            
            fpa_int_fdbk_last <= fpa_int_fdbk_i;
            
            fpa_int_i <= FPA_INT;            
            fpa_int_last <= fpa_int_i;
            
            
            fpa_pclk_last <= FPA_PCLK;
            pclk_rise <= not fpa_pclk_last and FPA_PCLK; 
            pclk_fall <= fpa_pclk_last and not FPA_PCLK;
            
            fpa_mclk_last <= FPA_MCLK;             
            
            -- contrôleur
            case sync_flag_fsm is           
               
               when idle =>   
                  fdem_i <= '0';
                  if fpa_int_last = '1' and fpa_int_i = '0' then -- fin d'une integration
                     sync_flag_fsm <= sync_flag_on_st;
                  end if;                        
               
               when sync_flag_on_st =>
                  if pclk_fall = '1' then 
                     fdem_i <= '1';
                     sync_flag_fsm <= sync_flag_off_st;
                  end if;
               
               when sync_flag_off_st =>
                  if pclk_fall = '1' then 
                     fdem_i <= '0';
                     sync_flag_fsm <= wait_img_end_st;
                  end if;
               
               when wait_img_end_st =>
                  if rd_end_pipe(0) = '1' then
                     sync_flag_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;            
            
            -- elcorr_start_i dure 1 PCLK
            eof_pulse <= eof_pipe(C_PIPE_POS) and dval_pipe(C_PIPE_POS);
            eof_pulse_last <= eof_pulse;
            elcorr_start_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_start_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (eof_pulse_last and not eof_pulse); 
            if unsigned(elcorr_start_pipe(C_FLAG_PIPE_LEN-1 downto 0)) /= 0 then
               elcorr_start_i <= '1';
               elcorr_fval_i  <= '1'; 
            else
               elcorr_start_i <= '0';
            end if;
            
            -- elcorr_end_i dure 1 PCLK
            elcorr_end_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_end_pipe(C_FLAG_PIPE_LEN-2 downto 0) & rd_end_pipe(0); -- Attention! le rd_end = fin de elcorr. Cela ne marchera qu'en ITR 
            if unsigned(elcorr_end_pipe(C_FLAG_PIPE_LEN-1 downto 0)) /= 0 then
               elcorr_end_i <= '1';
            else
               elcorr_end_i  <= '0';
               if elcorr_end_i = '1' then 
                  elcorr_fval_i <= '0';
               end if;
            end if;
            
            -- elcorr calculé uniquement avec les données de la ligne de reset
            if eof_pulse = '1' then
               ref_valid_i <= REF_VALID;
            elsif rd_end_pipe(0) = '1' then
               ref_valid_i <= (others => '0');
            end if;
            
            --            -- ref_valid_i(0)
            --            if eof_pulse = '1' then 
            --               ref_valid_i(0) <= '1';
            --            elsif rd_end_pipe(0) = '1' then
            --               ref_valid_i(0) <= '0'; 
            --            end if;  
            --            
            --            -- ref_valid_i(1)                      -- ne marche qu'en ITR
            --            if fpa_int_i = '1' then 
            --               ref_valid_i(1) <= '0';
            --            elsif rd_end_pipe(0) = '1' then
            --               ref_valid_i(1) <= '1'; 
            --            end if;
            
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
            
            -- naoi
            readout_info_i.naoi.ref_valid(1) <= ref_valid_i(1) and DEFINE_GENERATE_ELCORR_CHAIN;         -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= ref_valid_i(0) and DEFINE_GENERATE_ELCORR_CHAIN;         -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)            
            readout_info_i.naoi.start        <= elcorr_start_i and DEFINE_GENERATE_ELCORR_CHAIN;         -- start du naoi correspond au debut de la ligne de reset pour un superhawk
            readout_info_i.naoi.stop         <= elcorr_end_i and DEFINE_GENERATE_ELCORR_CHAIN;           -- end du naoi correspond à la fin de la ligne de reset pour un superhawk
            readout_info_i.naoi.dval         <= elcorr_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            readout_info_i.naoi.samp_pulse   <= (quad_clk_copy_last and not quad_clk_copy_i) and elcorr_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            
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
            rd_mclk_i <= '0';
            flags_reset <= '1';
            
         else  
            
            
            if pclk_fall = '1' then
               sol_pipe_pclk(0) <= sol_pipe(0);
               sol_pipe_pclk(1) <= sol_pipe_pclk(0);
            end if;
            
            lsync_pipe(7 downto 1) <= lsync_pipe(6 downto 0); 
            
            rd_mclk_i <= FPA_MCLK and readout_in_progress; 
            
            -- contrôleur
            case readout_fsm is           
               
               when idle =>   
                  readout_in_progress <= '0';
                  flags_reset <= '1';
                  if fpa_int_last = '1' and fpa_int_i = '0' then -- fin d'une integration
                     readout_fsm <= wait_mclk_fe_st1;
                     flags_reset <= '0';
                  end if;
               
               when wait_mclk_fe_st1 => 
                  if pclk_fall = '1' then  -- on attend la tombée de la MCLK pour eviter des troncatures 
                     readout_fsm <= readout_st;
                  end if;                           
               
               when readout_st =>                    --
                  readout_in_progress <= '1';
                  if rd_end_pipe(0) = '1' then 
                     readout_fsm <= wait_mclk_fe_st2;
                  end if;
               
               when wait_mclk_fe_st2 => 
                  if pclk_fall = '1' then  -- on attend la tombée de la MCLK pour eviter des troncatures 
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
         if  line_cnt_pipe(1) >= FPA_INTF_CFG.ACTIVE_LINE_START_NUM then 
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
         if line_cnt_pipe(2) <= FPA_INTF_CFG.ACTIVE_LINE_END_NUM then  
            dval_pipe(3)   <= active_line_en1 and lval_pipe(2);
         else
            dval_pipe(3)   <= '0';
         end if;
         
         -- generation de samp_pulse_i : on echantillonne les signaux fval, lval etc avec samp_pulse_i
         quad_clk_copy_i <= QUAD_CLK_COPY;
         quad_clk_copy_last <= quad_clk_copy_i;
         samp_pulse_pipe(3) <= ((not quad_clk_copy_last and quad_clk_copy_i)and fval_pipe(3)); 
         
         -------------------------
         -- reset des identificateurs
         -------------------------
         if flags_reset = '1' then
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
