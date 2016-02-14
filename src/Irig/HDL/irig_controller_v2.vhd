-------------------------------------------------------------------------------
--
-- Title       : irig_controller_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_controller_v2.vhd
-- Generated   : Thu Sep 15 13:15:54 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--library Common_HDL;
--use Common_HDL.Telops.all;
use work.IRIG_define_v2.all;

entity irig_controller_v2 is
   port(                          
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      -- config du module IRIG
      IRIG_ENABLE       : in std_logic;
      --RESET_IRIG_ERR    : in std_logic;
      
      -- config des sous-modules      
      SIG_COND_CFG      : out conditioner_cfg_type;
      ALPHAB_DEC_CFG    : out alphab_decoder_cfg_type;
      FRM_DEC_CFG       : out frame_decoder_cfg_type;  
      
      -- statut des sous-modules
      SIG_COND_STAT     : in std_logic_vector(7 downto 0);
      ALPHAB_STAT       : in std_logic_vector(7 downto 0);
      FRM_DEC_STAT      : in std_logic_vector(7 downto 0);
      IRIG_CLK_PRESENT  : in std_logic;
      
      -- statut global envoyé vers ROIC      
      GLOBAL_STATUS     : out std_logic_vector(15 downto 0);
      
      -- irig valid source
      IRIG_VALID_SOURCE : out std_logic   
      );
end irig_controller_v2;



architecture RTL of irig_controller_v2 is  
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D : in STD_LOGIC;
         Q : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;   
   
   type calib_fsm_type is (idle, init_calib_st, pause_st, inc_gain_st, init_alphab_dec_st, wait_alphab_dec_st, check_result_st, calib_success_st);     
   
   signal calib_fsm                : calib_fsm_type;
   
   
   signal design_warning_latch     : std_logic;
   signal no_valid_input_latch     : std_logic;
   signal cond_avg_err             : std_logic;
   signal cond_samp_sel_err        : std_logic;
   signal cond_gain_underfl        : std_logic;
   signal cond_gain_overfl         : std_logic; 
   signal cond_samp_speed_err      : std_logic;  
   signal cond_adc_err             : std_logic; 
   signal cond_done                : std_logic;
   signal alphab_comparator_err    : std_logic;
   signal alphab_speed_err         : std_logic;
   signal alphab_decoder_success   : std_logic;
   signal alphab_init_done         : std_logic;
   signal frm_speed_err            : std_logic; 
   signal frm_pps_gen_err          : std_logic;
   signal frm_sequence_err         : std_logic;
   signal frm_sync_lost            : std_logic;
   signal frm_received             : std_logic;
   signal frm_in_progress          : std_logic; 
   signal sreset                   : std_logic;
   signal irig_enable_i            : std_logic;
   signal alphab_init_done_last    : std_logic;
   signal calib_success            : std_logic;
   signal unknown_alphab           : std_logic;
   signal cond_soft_err            : std_logic;
   signal alphab_soft_err          : std_logic;
   signal design_warning           : std_logic;
   signal no_valid_input           : std_logic;
   signal frm_soft_err             : std_logic; 
   signal reset_irig_err_i         : std_logic;
   signal frm_in_progress_last     : std_logic; 
   signal frm_valid_detected       : std_logic;
   signal alphab_sig_integrity_err : std_logic;  
   signal valid_input              : std_logic;
   
   attribute keep : string; 
   attribute keep of cond_avg_err, cond_samp_sel_err, cond_samp_speed_err, cond_adc_err : signal is "YES";  
   attribute keep of alphab_sig_integrity_err, alphab_comparator_err, alphab_speed_err  : signal is "YES";  
   attribute keep of frm_speed_err, frm_pps_gen_err, frm_sequence_err, frm_sync_lost    : signal is "YES"; 
   attribute keep of frm_in_progress, frm_valid_detected                                : signal is "YES"; 
   attribute keep of cond_soft_err, alphab_soft_err, frm_soft_err                       : signal is "YES"; 
   attribute keep of design_warning, no_valid_input                                     : signal is "YES"; 
   attribute keep of design_warning_latch, no_valid_input_latch                         : signal is "YES"; 
   
begin
   
   --------------------------------------------------
   -- statuts envoyés au PPC du ROIC                          
   --------------------------------------------------   
   
   GLOBAL_STATUS(15 downto 3) <= (others => '0');
   GLOBAL_STATUS(2) <= design_warning_latch;
   GLOBAL_STATUS(1) <= valid_input;  --  permet de savoir si generateur IRIG B12x est connecté   
   GLOBAL_STATUS(0) <= '0';                       --  valide les données des registres, est generé dans le ROIC. Permet de savoir si les données sont valides
   
   
   --------------------------------------------------
   -- input mapping                           
   --------------------------------------------------   
   -- statuts du conditionneur
   cond_avg_err             <= SIG_COND_STAT(6);  -- soft_error qui ne doit jamais se produire
   cond_samp_sel_err        <= SIG_COND_STAT(5);  -- soft_error qui ne doit jamais se produire
   cond_gain_underfl        <= SIG_COND_STAT(4);
   cond_gain_overfl         <= SIG_COND_STAT(3);
   cond_samp_speed_err      <= SIG_COND_STAT(2);  -- soft_error qui ne doit jamais se produire
   cond_adc_err             <= SIG_COND_STAT(1);  -- soft_error qui ne doit jamais se produire
   cond_done                <= SIG_COND_STAT(0);
   
   -- statuts du decodeur d'alphabet
   alphab_sig_integrity_err <= ALPHAB_STAT(4);      -- soft error qui ne doit jamais se produire
   alphab_comparator_err    <= ALPHAB_STAT(3);     -- soft_error qui ne doit jamais se produire
   alphab_speed_err         <= ALPHAB_STAT(2);     -- soft_error qui ne doit jamais se produire
   alphab_decoder_success   <= ALPHAB_STAT(1);
   alphab_init_done         <= ALPHAB_STAT(0);
   
   -- status du decodeur de trame
   frm_speed_err            <= FRM_DEC_STAT(6);    -- soft_error qui ne doit jamais se produire
   frm_pps_gen_err          <= FRM_DEC_STAT(5);    -- hard err
   frm_sequence_err         <= FRM_DEC_STAT(4);    -- hard err
   frm_sync_lost            <= FRM_DEC_STAT(3);    -- hard err
   frm_received             <= FRM_DEC_STAT(2);
   frm_in_progress          <= FRM_DEC_STAT(1);
   frm_valid_detected       <= FRM_DEC_STAT(0);
   
   --------------------------------------------------
   -- sync reset 
   --------------------------------------------------
   U1 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK);  
   
   
   --------------------------------------------------
   -- signal d'activation du IRIG 
   --------------------------------------------------
   U2 : double_sync
   generic map( INIT_VALUE => '0')
   port map(D => IRIG_ENABLE, Q => irig_enable_i,  RESET => sreset,  CLK => CLK);  
   
   
   --------------------------------------------------
   -- fsm de calibration de la chaine 
   --------------------------------------------------
   -- But: cette FSM configure le gain de la chaine en ecoutant la sortie du decodeur d'alphabet
   -- Fonctionnement: tant qu'une horloge valide le permet, il scrute indefiniment l'entrée en balayant la plage de gain
   U3 : process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' or IRIG_CLK_PRESENT = '0' then    -- tant qu'on ne connecte rien en entrée, on est en reset
            calib_fsm <= idle;
            SIG_COND_CFG.DEC_GAIN <= '0'; -- finalement la decrementation du gain est inutile car le threshold est valide si le max(V) occupe au moins 30% de l'ADC
            alphab_init_done_last <= '0';
            calib_success <= '0';
            unknown_alphab <= '0';
         else 
            
            alphab_init_done_last <= alphab_init_done;
            
            case calib_fsm is
               when idle =>       
                  if irig_enable_i = '1' then
                     calib_fsm <= init_calib_st;                                                             
                  end if;   
                  calib_success <= '0';
                  unknown_alphab <= '0';
               
               when init_calib_st => 
                  SIG_COND_CFG.RESET_GAIN <= '1';  -- on remet le gain à '0'
                  SIG_COND_CFG.RESET_ERR <= '1';   -- on réinitialise les registres d'erreurs 
                  calib_fsm <= pause_st;
               
               when pause_st =>
                  SIG_COND_CFG.RESET_GAIN <= '0';  
                  SIG_COND_CFG.RESET_ERR <= '0';
                  calib_fsm <= inc_gain_st;         -- après une RAZ du gain on ne peut que l'incrementer
               
               when inc_gain_st =>                  
                  SIG_COND_CFG.INC_GAIN <= '1';     -- on incremente donc le gain                   
                  calib_fsm <= init_alphab_dec_st;
               
               when init_alphab_dec_st =>    
                  SIG_COND_CFG.INC_GAIN <= '0';      -- l'incrementation doit etre une pulse 
                  if alphab_init_done = '1' then    -- on attend que le decodeur de l'alphabet soit à l'ecoute 
                     ALPHAB_DEC_CFG.INIT <= '1';    --  puis on lance son initialisation
                  end if;
                  calib_fsm <= wait_alphab_dec_st;
               
               when wait_alphab_dec_st =>                         
                  if alphab_init_done  = '0' then
                     ALPHAB_DEC_CFG.INIT <= '0';
                  end if;   
                  if alphab_init_done = '1' and alphab_init_done_last = '0' then   -- on attend la fin de l'initilisation du decodeur d'alphabet  
                     calib_fsm <= check_result_st;  -- puis on s'en va analyser les resultats
                  end if;
               
               when check_result_st =>   
                  if  alphab_decoder_success = '0' then
                     if cond_gain_overfl = '0' then
                        calib_fsm <= inc_gain_st;      -- tant que le gain max n'Est pas atteint on augmente le gain
                     else
                        calib_fsm <= idle;              -- aucun signal valide n'est en entrée on retourne pour scruter encore et encore l'entrée meme si IRIG_CLCK_PRESENT = '1' car il peut y avoir changement de gain de la source iRIG
                        unknown_alphab <= '1';
                     end if;
                  else
                     calib_fsm <= calib_success_st;
                  end if;                  
               
               when calib_success_st =>                 -- tant que le decodeur d'alphabet signale un succès, le gain est correct, alors on ne fait plus rien
                  calib_success <= '1';
                  if alphab_decoder_success = '0' then  -- sinon, on a perdu le signal, il faut avertir l'usager 
                     calib_fsm <= idle;                                                                        
                     unknown_alphab <= '1';
                  end if; 
               
               when others =>
               
            end case;
            
            
         end if;
      end if;         
   end process;
   
   
   --------------------------------------------------
   -- fsm de contrôle du decodeur de trame 
   --------------------------------------------------
   -- But: cette FSM contôle le decodeur de trame
   -- Fonctionnement: tant que le permet de decodeur d'alphabet, 
   U4 : process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' then 
            FRM_DEC_CFG.ENABLE <= '0';            
         else              
            FRM_DEC_CFG.ENABLE <= calib_success;
         end if;
      end if;     
   end process;
   
   
   --------------------------------------------------
   -- statuts
   --------------------------------------------------
   U5 : process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' then 
            cond_soft_err <= '0';
            alphab_soft_err <= '0';
            design_warning <= '0'; 
            no_valid_input <= '0'; 
            frm_soft_err <= '0';
            reset_irig_err_i <= '0';
            frm_in_progress_last <= '0'; 
            design_warning_latch <= '0';
            no_valid_input_latch <= '0';
            IRIG_VALID_SOURCE <= '0';
         else              
            cond_soft_err <= cond_avg_err or cond_samp_sel_err  or cond_samp_speed_err or cond_adc_err;
            alphab_soft_err <= alphab_comparator_err or alphab_speed_err or alphab_sig_integrity_err;
            frm_soft_err <=  frm_speed_err;
            
            design_warning <= cond_soft_err or alphab_soft_err or frm_soft_err;  -- ce sont des warnong qui montrent que notre design n'est pas bien fait
            no_valid_input <= unknown_alphab or frm_pps_gen_err or frm_sequence_err or not IRIG_CLK_PRESENT or not frm_valid_detected;
            
            frm_in_progress_last <= frm_in_progress;
            reset_irig_err_i <= frm_in_progress and frm_in_progress_last ; -- on fait un reset des erreurs avant de se lancer dans le decodage de la trame
            
            if design_warning = '1' then
               design_warning_latch <= '1';
            elsif reset_irig_err_i = '1' then 
               design_warning_latch <= '0'; 
            end if;
            
            if no_valid_input = '1' then
               no_valid_input_latch <= '1';
            elsif reset_irig_err_i = '1' then 
               no_valid_input_latch <= '0'; 
            end if;
            
            valid_input <= not no_valid_input_latch and frm_valid_detected ;
            IRIG_VALID_SOURCE <= valid_input;
         end if;
      end if;     
   end process;  
   
   
end RTL;
