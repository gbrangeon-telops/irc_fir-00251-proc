------------------------------------------------------------------
--!   @file : calcium_services_ctrl
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.proxy_define.all;


entity calcium_services_ctrl is
   
   port(
      
      -- signaux generaux
      CLK                     : in std_logic;
      ARESET                  : in std_logic;
      
      -- interface avec la switch      
      SWITCH_PROG             : out std_logic;
      SWITCH_DONE             : in std_logic;
      
      -- interface avec monitoring adc
      FPA_TEMP                : in t_ll_ext_mosi16;
      FPA_DIGIOV              : in t_ll_ext_mosi16;      -- en milliVolt
      FLEX_PSP                : in t_ll_ext_mosi16;      -- en milliVolt
      MEAS_TP                 : in t_ll_ext_mosi16;
      
      -- interface avec ddc_brd_id_reader
      DDC_BRD_INFO            : in ddc_brd_info_type;
      
      -- erreurs entrantes
      ERR                     : in std_logic_vector(3 downto 0);
      
      -- statuts
      FPA_HARDW_STAT          : out fpa_hardw_stat_type;
      FPA_TEMP_STAT           : out fpa_temp_stat_type
      );
end calcium_services_ctrl;


architecture rtl of calcium_services_ctrl is
   
   constant C_ADC_DATA_RDY_DLY_FACTOR   : natural := 50_000_000;   -- ce qui donne un temps de 500ms pour une hrologe de 100MHz
   constant C_TEMP_ADC_TIMEOUT_FACTOR   : natural := 200_000_000; -- ce qui donne un temps de 2sec au ADC pour rafraichir ses donn�es de temp�rature d�tecteur.
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   type services_ctrl_sm_type  is (wait_ddc_brd_id_st, check_ddc_brd_data_st1, check_ddc_brd_data_st2, launch_decision_maker_st);
   type decision_sm_type is (idle, prog_sw_st, wait_sw_st1, wait_sw_st2, wait_timeout_st, wait_feedback_st1, wait_feedback_st2, 
      check_feedback_st1, check_feedback_st2, success_status_st, failure_status_st, check_sw_reprogr_st, reset_param_st);
   type fpa_temp_sm_type is (idle, check_temp_max_st, check_temp_min_st, temp_rdy_st);
   type adc_alive_sm_type is (check_rate_st, timeout_st);
   
   signal timeout_cnt                : natural range 0 to C_TEMP_ADC_TIMEOUT_FACTOR;
   signal sreset                     : std_logic;
   signal services_ctrl_sm           : services_ctrl_sm_type;
   signal decision_sm                : decision_sm_type;
   signal ddc_brd_err                : std_logic;
   signal decision_maker             : std_logic;
   signal rdy_dly_cnt                : natural range 0 to C_ADC_DATA_RDY_DLY_FACTOR;
   signal fpa_input_type_meas        : std_logic_vector(7 downto 0);
   signal flex_psp_meas              : natural range 0 to 8000;
   signal brd_feedback_err           : std_logic;
   signal prog_cnt                   : unsigned(2 downto 0);
   signal fpa_temp_stat_i            : fpa_temp_stat_type;
   signal fpa_temp_sm                : fpa_temp_sm_type;
   signal adc_alive                  : std_logic;
   signal adc_alive_sm               : adc_alive_sm_type;
   signal temp_reached               : std_logic;
   
   ---- attribute dont_touch              : string;
   ---- attribute dont_touch of ddc_brd_err                   : signal is "true";
   ---- attribute dont_touch of decision_maker                : signal is "true";
   ---- attribute dont_touch of fpa_input_type_meas           : signal is "true"; 
   ---- attribute dont_touch of flex_psp_meas                 : signal is "true";
   
begin 
   
   FPA_TEMP_STAT  <= fpa_temp_stat_i;
   
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   
   --ETAPE1 : lire ID DDC
   --ETAPE2 : programmer les switches selon ID et FPA_Define
   --ETAPE3 : lancer monitoring_adc pour relire valeurs programm�es   
   --ETAPE4 : relancer la programmation max 3 fois si non concordance
   --ETAPE5 : compiller tout et sortir les statuts
   --ETAPE6 : lancer monitoring ADC pour la temp�rature du detecteur et la sortir en mode continuel
   --ETAPE7 : allumer Led erreur si Erreur                                    
   
   ----------------------------------------------------------------------------
   -- Recueil d'informations sur DDC Board
   ----------------------------------------------------------------------------
   U1: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            services_ctrl_sm <= wait_ddc_brd_id_st;
            ddc_brd_err <= '0';
            decision_maker <= '0';  			
         else 
            
            case services_ctrl_sm is
               
               when wait_ddc_brd_id_st =>           -- detection du DDC
                  if DDC_BRD_INFO.DVAL = '1' then
                     services_ctrl_sm <= check_ddc_brd_data_st1;
                  end if;
               
               when check_ddc_brd_data_st1 =>      -- v�rification si DDC conforme au FPA attendu pour bien programmer le generateur de courant de la diode de lecture de temperature
                  if DDC_BRD_INFO.FPA_ROIC /= DEFINE_FPA_ROIC then     -- condition verifi�e m�me si aucune carte DDC n'est pas d�tect�e 
                     ddc_brd_err <= '1';                     
                  end if;
                  services_ctrl_sm <= check_ddc_brd_data_st2;
               
               when check_ddc_brd_data_st2 =>     -- v�rification si DDC conforme au FPA attendu pour bien programmer le translateur FPA_DIGIO
                  if DDC_BRD_INFO.FPA_INPUT /= DEFINE_FPA_INPUT then 
                     ddc_brd_err <= '1';                     
                  end if;
                  services_ctrl_sm <= launch_decision_maker_st;
               
               when launch_decision_maker_st =>         -- on lance une prise de d�cision avec les infos recueillies et on ne sort plus de cet �tat
                  decision_maker <= '1';   
               
               when others =>
               
            end case;
         end if;
      end if;
   end process;   
   
   
   ----------------------------------------------------------------------------
   -- Prise de d�cisions
   ----------------------------------------------------------------------------
   U2: process(CLK) 
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            decision_sm <= idle;
            SWITCH_PROG <= '0';
            brd_feedback_err <= '0';
            FPA_HARDW_STAT.DVAL <= '0';
         else
            
            case decision_sm is
               
               when idle =>
                  prog_cnt <= (others => '0');
                  if decision_maker = '1' then
                     decision_sm <= prog_sw_st; 
                  end if;
                  
               -- etape 1: programmation de la switch   
               when prog_sw_st =>          -- on programme la switch avec la configuration source-courant, FPA_DIGIO requise pour le DDC d�tect�. Bien evidemment si aucune erreur d�tect�e sur carte DDC
                  if ddc_brd_err = '0' then
                     if SWITCH_DONE = '1' then
                        SWITCH_PROG <= '1';   
                        decision_sm <= wait_sw_st1;
                     end if;
                  else
                     decision_sm <= failure_status_st;
                  end if;
               
               when wait_sw_st1 =>         -- on attend que le contr�leur lance la programmation de la switch
                  if SWITCH_DONE = '0' then
                     decision_sm <= wait_sw_st2;
                     SWITCH_PROG <= '0';
                  end if;
               
               when wait_sw_st2 =>          -- on attend la fin de la programmation de la switch
                  rdy_dly_cnt <= 0;
                  if SWITCH_DONE = '1' then
                     decision_sm <= wait_timeout_st;
                     SWITCH_PROG <= '0';
                  end if;
               
               when wait_timeout_st =>   -- attendre que les mesures soient � jour sur les composants reprogramm�s
                  rdy_dly_cnt <= rdy_dly_cnt + 1;
                  if rdy_dly_cnt = C_ADC_DATA_RDY_DLY_FACTOR then   -- 500 ms de delai sugg�r�
                     decision_sm <= wait_feedback_st1;
                  end if;
                  -- pragma translate_off  
                  decision_sm <= wait_feedback_st1;
                  -- pragma translate_on  
                  
               -- etape 2: feedback  
               when wait_feedback_st1 =>  -- attendre feedback  FPA_DIGIOV
                  fpa_input_type_meas <= digio_voltage_to_fpa_input_type(unsigned(FPA_DIGIOV.DATA)); -- FPA_DIGIOV.DATA doit �tre en mV
                  if FPA_DIGIOV.DVAL = '1' then
                     decision_sm <= wait_feedback_st2;
                  end if;
               
               when wait_feedback_st2 =>  -- attendre feedback FLEX_PSP
                  flex_psp_meas <= voltage_to_flex_psp_mV(unsigned(FLEX_PSP.DATA));                  -- FLEX_PSP.DATA doit �tre en mV
                  if FLEX_PSP.DVAL = '1' then
                     decision_sm <= check_feedback_st1;                     
                  end if;
               
               when check_feedback_st1 => -- verifier le 1er element de feedback
                  if fpa_input_type_meas /= DEFINE_FPA_INPUT then
                     brd_feedback_err <= '1';
                  end if;
                  decision_sm <= check_feedback_st2;
               
               when check_feedback_st2 => -- verifier le 2e element de feedback
                  if flex_psp_meas /= DEFINE_FLEX_VOLTAGEP_mV then
                     brd_feedback_err <= '1';
                  end if;   
                  decision_sm <= check_sw_reprogr_st;                  
               
               when check_sw_reprogr_st => 
                  if brd_feedback_err = '1' then
                     if prog_cnt = 3 then 
                        decision_sm <= failure_status_st;
                     else
                        decision_sm <= reset_param_st; 
                     end if;
                  else
                     decision_sm <= success_status_st;
                  end if;                 
               
               when reset_param_st =>
                  brd_feedback_err <= '0';
                  prog_cnt <= prog_cnt + 1;                  
                  decision_sm <= prog_sw_st; 
                  
                  -- etape 3: sortie des statuts
               -- en cas d'�chec
               when failure_status_st =>
                  FPA_HARDW_STAT.DDC_BRD_INFO <= DDC_BRD_INFO_UNKNOWN;
                  FPA_HARDW_STAT.IDDCA_INFO <= IDDCA_INFO_UNKNOWN;
                  FPA_HARDW_STAT.DVAL <= '1';
                  
               --en cas de succ�s
               when success_status_st =>
                  FPA_HARDW_STAT.DDC_BRD_INFO <= DDC_BRD_INFO;
                  FPA_HARDW_STAT.IDDCA_INFO <= ddc_brd_info_to_iddca_info(DDC_BRD_INFO);
                  FPA_HARDW_STAT.DVAL <= '1';
               
               when others =>
               
            end case;        
            
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------------------------------
   -- Envoi de la Temp�rature du d�tecteur
   ----------------------------------------------------------------------------
   -- fsm dans le but de reduire les contraintes de timings
   U3: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            fpa_temp_stat_i.fpa_pwr_on_temp_reached <= '0';
            temp_reached <= '0';
            fpa_temp_stat_i.temp_dval <= '0';
            fpa_temp_sm <= idle;
         else
            
            fpa_temp_stat_i.fpa_pwr_on_temp_reached <= temp_reached and adc_alive;
            
            case fpa_temp_sm is       -- pour generer le fpa_temp_stat_i.fpa_pwr_on_temp_reached
               
               when idle =>                  
                  if FPA_TEMP.DVAL = '1' then
                     fpa_temp_sm <= check_temp_max_st;
                     fpa_temp_stat_i.temp_data <= std_logic_vector(resize(unsigned(FPA_TEMP.DATA), fpa_temp_stat_i.temp_data'length)); -- ENO: faut pas deplacer cette ligne
                  end if;
               
               when check_temp_max_st =>  
                  fpa_temp_stat_i.temp_dval <= '1';
                  if unsigned(fpa_temp_stat_i.temp_data(15 downto 0)) < DEFINE_FPA_TEMP_RAW_MAX then
                     fpa_temp_sm <= check_temp_min_st;
                  else
                     fpa_temp_sm <= idle;
                     temp_reached <= '0';    -- ainsi lorsque FPA_TEMP> DEFINE_FPA_TEMP_RAW_MAX, fpa_pwr_on_temp_reached tombe � '0' ce qui permet au sequenceur d'eteindre le d�tecteur 
                  end if;
               
               when check_temp_min_st =>
                  if unsigned(fpa_temp_stat_i.temp_data(15 downto 0)) > DEFINE_FPA_TEMP_RAW_MIN then
                     fpa_temp_sm <= temp_rdy_st;
                  else
                     fpa_temp_sm <= idle;
                     temp_reached <= '0';    -- ainsi lorsque FPA_TEMP < DEFINE_FPA_TEMP_RAW_MIN, fpa_pwr_on_temp_reached tombe � '0' ce qui permet au sequenceur d'eteindre le d�tecteur
                  end if;
               
               when temp_rdy_st =>
                  temp_reached <= '1';
                  fpa_temp_sm <= idle;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   
   ---------------------------------------------------------------------------------------
   -- V�rification de l'�tat de l'ADC lisant la temp�rature du FPA 
   ---------------------------------------------------------------------------------------
   --en l'absence de donn�es provenant de l'ADC durant 2sec, on eteint le d�tecteur.Sinon la temperature peut sortir des limites tolerables, sans qu,on ne le sache
   U4: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            adc_alive <= '0';
            adc_alive_sm <= check_rate_st;
            timeout_cnt <= C_TEMP_ADC_TIMEOUT_FACTOR;
         else          
            
            case adc_alive_sm is       
               
               when check_rate_st =>
                  adc_alive <= '1'; 
                  timeout_cnt <= timeout_cnt - 1;
                  if FPA_TEMP.DVAL = '1' then
                     timeout_cnt <= C_TEMP_ADC_TIMEOUT_FACTOR;
                  end if;                  
                  if timeout_cnt = 0 then 
                     adc_alive_sm <= timeout_st;
                  end if;
               
               when timeout_st =>     -- on en sort plus. En effet cette erreur ne doit jamais se produire. Si cela arrivait, on eteint le d�tecteur pour de bon!!!! Un diagostic doit �tre effectu�.
                  adc_alive <= '0';
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
   
end rtl;
