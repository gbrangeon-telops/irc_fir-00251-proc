------------------------------------------------------------------
--!   @file : isc0207A_digio_map
--!   @brief
--!   @details
--!
--!   $Rev: 20019 $
--!   $Author: enofodjie $
--!   $Date: 2017-01-30 09:25:16 -0500 (lun., 30 janv. 2017) $
--!   $Id: isc0207A_digio_map.vhd 20019 2017-01-30 14:25:16Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2016-11-08%20Forrest%20Gump/src/FPA/isc0207A_3k/HDL/isc0207A_digio_map.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;           
use IEEE.numeric_std.ALL;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.fleg_brd_define.all;

entity isc0207A_digio_map is
   port(
      
      MCLK_SOURCE       : in std_logic;
      ARESET            : in std_logic; 
      
      FPA_INT           : in std_logic;
      PROXIM_IS_FLEGX   : in std_logic;
      
      ROIC_RESET_B      : in std_logic;
      FPA_MCLK          : in std_logic;
                        
      --PROG_EN           : in std_logic;
      PROG_CSN          : in std_logic;  
      PROG_SD           : in std_logic;
                        
      DAC_CSN           : in std_logic;  
      DAC_SCLK          : in std_logic;
      DAC_SD            : in std_logic;
      DAC_POWERED       : out std_logic;
                        
      FPA_PWR           : in std_logic;
      FPA_ON            : out std_logic;
      FPA_POWERED       : out std_logic;      
                        
      FPA_DIGIO1        : out std_logic;
      FPA_DIGIO2        : out std_logic;
      FPA_DIGIO3        : out std_logic;
      FPA_DIGIO4        : out std_logic;
      FPA_DIGIO5        : out std_logic;
      FPA_DIGIO6        : out std_logic;
      FPA_DIGIO7        : out std_logic;
      FPA_DIGIO8        : out std_logic;
      FPA_DIGIO9        : out std_logic;
      FPA_DIGIO10       : out std_logic;
      FPA_DIGIO11       : in std_logic;
      FPA_DIGIO12       : in std_logic
      
      );
end isc0207A_digio_map;


architecture rtl of isc0207A_digio_map is
   
   constant C_FLEG_DLY_FACTOR         : integer := DEFINE_FLEG_LDO_DLY_FACTOR - DEFINE_FLEG_DAC_PWR_WAIT_FACTOR;
   
   component sync_reset
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC;
         CLK    : in STD_LOGIC);
   end component;
   
   type digio_fsm_type   is (idle, ldo_pwr_pause_st, rst_cnt_st, check_mclk_st, fpa_pwr_pause_st, fpa_pwred_st);
   type dac_digio_fsm_type   is (dac_pwr_pause_st, dac_pwred_st);
   signal digio_fsm        : digio_fsm_type;
   signal dac_digio_fsm    : dac_digio_fsm_type;
   signal sreset           : std_logic;
   signal fpa_on_i         : std_logic;
   signal fpa_digio2_i     : std_logic;
   signal fpa_digio6_i     : std_logic;
   signal fpa_digio7_i     : std_logic;
   signal fpa_digio3_i     : std_logic;
   signal fpa_digio4_i     : std_logic;
   signal synchro_err      : std_logic;
   signal timer_cnt        : natural;--range 0 to DEFINE_FPA_POWER_WAIT_FACTOR + 2;
   signal fpa_powered_i    : std_logic;
   signal fpa_on_iob       : std_logic;
   signal fpa_digio4_iob   : std_logic;
   signal fpa_digio6_iob   : std_logic;
   signal fpa_digio7_iob   : std_logic;
   signal fpa_digio3_iob   : std_logic;
   signal fpa_digio2_iob   : std_logic;
   signal fsm_sreset       : std_logic;
   signal dac_powered_i    : std_logic;
   
   signal dac_csn_i        : std_logic;
   signal dac_sd_i         : std_logic;
   signal dac_sclk_i       : std_logic;
   signal dac_csn_iob      : std_logic;
   signal dac_sd_iob       : std_logic;
   signal dac_sclk_iob     : std_logic;
   signal dac_timer_cnt    : natural;
   
   signal mclk_reg         : std_logic;
   signal mclk_pipe        : std_logic_vector(7 downto 0);
   
   attribute IOB : string;
   attribute IOB of fpa_on_iob           : signal is "TRUE";
   attribute IOB of fpa_digio2_iob       : signal is "TRUE";
   attribute IOB of fpa_digio3_iob       : signal is "TRUE";
   attribute IOB of fpa_digio4_iob       : signal is "TRUE";
   attribute IOB of fpa_digio6_iob       : signal is "TRUE";
   attribute IOB of fpa_digio7_iob       : signal is "TRUE";
   
   
begin   
   
   
   --------------------------------------------------------
   -- maps
   --------------------------------------------------------
   DAC_POWERED <= dac_powered_i;
   
   FPA_POWERED <= fpa_powered_i;
   FPA_ON      <= fpa_on_iob;   
   
   FPA_DIGIO1  <= '0';
   FPA_DIGIO2  <= fpa_digio2_iob;               -- flegx  reset_B
   FPA_DIGIO3  <= fpa_digio3_iob;               -- flegx  data
   FPA_DIGIO4  <= fpa_digio4_iob;               -- flegx  '0'
   FPA_DIGIO5  <= '0';                          -- flegx  '0'
   FPA_DIGIO6  <= fpa_digio6_iob;               -- flegx  fsync
   FPA_DIGIO7  <= fpa_digio7_iob;               -- flegx  mclk
   
   -- dac_digio
   FPA_DIGIO8  <= dac_sclk_iob;
   FPA_DIGIO9  <= dac_sd_iob; 
   FPA_DIGIO10 <= dac_csn_iob; 
   
   --------------------------------------------------------
   -- Sync reset
   -------------------------------------------------------- 
   U0 : sync_reset
   port map(ARESET => ARESET, CLK => MCLK_SOURCE, SRESET => sreset); 
   
   
   --------------------------------------------------------- 
   -- gestion de l'allumage du proxy (process indépendant)
   --------------------------------------------------------- 
   U1: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         fpa_on_i <= not ARESET and FPA_PWR;
         fsm_sreset <= sreset or not FPA_PWR;
      end if;   
   end process; 
   
   --------------------------------------------------------- 
   -- Ajustement de la phase de MCLK
   ---------------------------------------------------------
   U10M :  process(MCLK_SOURCE)
   begin  
      if rising_edge(MCLK_SOURCE) then 
         mclk_pipe(0) <= FPA_MCLK;
         mclk_pipe(7 downto 1) <= mclk_pipe(6 downto 0);
         mclk_reg <= mclk_pipe(0);                          -- ajusté via simulation
      end if;
   end process;
   
   --------------------------------------------------------- 
   -- registres dans iob
   --------------------------------------------------------- 
   UIOB: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         
         fpa_on_iob      <= fpa_on_i; 
         
         -- fpa                   
         fpa_digio2_iob  <= fpa_digio2_i;            
         fpa_digio3_iob  <= fpa_digio3_i;
         fpa_digio4_iob  <= fpa_digio4_i;
         fpa_digio6_iob  <= fpa_digio6_i;   
         fpa_digio7_iob  <= fpa_digio7_i;
         
         -- contrôle DAC
         dac_csn_iob <= dac_csn_i;
         dac_sd_iob <= dac_sd_i;
         dac_sclk_iob <= dac_sclk_i;
      end if;   
   end process;  
   
   
   --------------------------------------------------------- 
   -- gestion du signal RDY                                 
   ---------------------------------------------------------
   U12: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then
            fpa_digio3_i    <= '0';            
            fpa_digio2_i <= '0';
            fpa_digio6_i   <= '0';
            fpa_digio7_i    <= '0';
            synchro_err    <= '0'; 
            digio_fsm      <=  idle;
            timer_cnt      <=  0;
            fpa_powered_i  <= '0';
            
         else
            
            case digio_fsm is          
               -- idle
               when idle =>
                  if dac_powered_i = '1' then 
                     digio_fsm <= ldo_pwr_pause_st;
                  end if;
                  
               -- delai du monostable sur le fleg
               when ldo_pwr_pause_st =>
                  timer_cnt <= timer_cnt + 1;
                  if timer_cnt = C_FLEG_DLY_FACTOR then    -- soit DEFINE_FLEG_LDO_DLY_FACTOR de coups d'horloge après l'ordre d'allumage, la fsm quitte cet état
                     digio_fsm <= rst_cnt_st;
                  end if; 
                  -- pragma translate_off
                  if timer_cnt = 10 then  
                     digio_fsm <= rst_cnt_st;
                  end if;                
                  -- pragma translate_on
                  
               -- reset compteur
               when rst_cnt_st =>
                  timer_cnt <= 0;
                  digio_fsm <= fpa_pwr_pause_st;
                  
               -- observer le delai FPA_POWER_WAIT  
               when fpa_pwr_pause_st =>              
                  timer_cnt <= timer_cnt + 1;
                  if timer_cnt > DEFINE_FPA_POWER_WAIT_FACTOR then
                     digio_fsm <= check_mclk_st;
                  end if;
                  -- pragma translate_off
                  if timer_cnt = 30 then  
                     digio_fsm <= check_mclk_st;
                  end if;                
                  -- pragma translate_on
                  
               -- proxy est pret à recevoir des contrôles 
               when check_mclk_st =>
                  if FPA_MCLK = '0' and FPA_INT = '0' then  -- pour eviter troncature sur ces signaux
                     digio_fsm <= fpa_pwred_st;
                  end if;                   
               
               when fpa_pwred_st =>
                  fpa_powered_i <= '1';
                  fpa_digio2_i <= PROXIM_IS_FLEGX and ROIC_RESET_B;
                  fpa_digio3_i <= PROG_SD;
                  fpa_digio4_i <= not PROXIM_IS_FLEGX and ROIC_RESET_B;
                  fpa_digio6_i <= not FPA_INT and PROG_CSN;
                  fpa_digio7_i <= mclk_reg;                
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process;  
   
   --------------------------------------------------------- 
   -- fsm dac                                 
   ---------------------------------------------------------
   U13: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            dac_digio_fsm <= dac_pwr_pause_st;
            dac_csn_i <= '1';
            dac_sd_i <= '0';
            dac_sclk_i <= '0';
            dac_powered_i <= '0';
            dac_timer_cnt <= 0;
            
         else
            
            case dac_digio_fsm is          
               
               -- delai
               when dac_pwr_pause_st =>
                  dac_timer_cnt <= dac_timer_cnt + 1;
                  if dac_timer_cnt = DEFINE_FLEG_DAC_PWR_WAIT_FACTOR then
                     dac_digio_fsm <= dac_pwred_st;
                  end if;
                  
                  -- pragma translate_off
                  if dac_timer_cnt = 50 then 
                     dac_digio_fsm <= dac_pwred_st;
                  end if;                
                  -- pragma translate_on
                  
               -- dac rdy
               when dac_pwred_st =>           -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  dac_powered_i <= '1';
                  dac_csn_i <= DAC_CSN;
                  dac_sd_i <= DAC_SD;
                  dac_sclk_i <= DAC_SCLK;      
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process;  
   
end rtl;
