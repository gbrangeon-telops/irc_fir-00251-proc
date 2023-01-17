------------------------------------------------------------------
--!   @file : isc0209A_digio_map
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
use IEEE.numeric_std.ALL;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.fleg_brd_define.all;

entity isc0209A_digio_map is
   port(
      
      MCLK_SOURCE   : in std_logic;
      ARESET        : in std_logic;      
      
      FPA_INT       : in std_logic;
      FPA_MCLK      : in std_logic;
      
      READOUT       : in std_logic;
      FPA_INTF_CFG  : in fpa_intf_cfg_type;
      
      PROG_CSN      : in std_logic;  
      PROG_SD       : in std_logic;
      PROG_EN       : in std_logic;
      
      DAC_CSN       : in std_logic;  
      DAC_SCLK      : in std_logic;
      DAC_SD        : in std_logic;
      
      FPA_LSYNC     : in std_logic;
      
      FPA_PWR       : in std_logic;      
      FPA_POWERED   : out std_logic;      
      DAC_POWERED   : out std_logic;
      
      FPA_ON        : out std_logic;
      FPA_DIGIO1    : out std_logic;
      FPA_DIGIO2    : out std_logic;
      FPA_DIGIO3    : out std_logic;
      FPA_DIGIO4    : out std_logic;
      FPA_DIGIO5    : out std_logic;
      FPA_DIGIO6    : out std_logic;
      FPA_DIGIO7    : out std_logic;
      FPA_DIGIO8    : out std_logic;
      FPA_DIGIO9    : out std_logic;
      FPA_DIGIO10   : out std_logic;
      FPA_DIGIO11   : in std_logic;
      FPA_DIGIO12   : in std_logic
      );
end isc0209A_digio_map;


architecture rtl of isc0209A_digio_map is
   
   component sync_reset
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC;
         CLK    : in STD_LOGIC);
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;
   
   type fpa_digio_fsm_type   is (idle, ldo_pwr_pause_st, rst_cnt_st, fpa_pwr_pause_st, wait_trig_stop_st, fpa_pwred_st, passthru_st, fpa_cst_output_st); 
   type dac_digio_fsm_type   is (dac_pwr_pause_st, dac_pwred_st); 
   signal fpa_digio_fsm    : fpa_digio_fsm_type;
   signal dac_digio_fsm    : dac_digio_fsm_type;
   signal sreset           : std_logic;
   signal dac_timer_cnt    : natural;
   signal fpa_timer_cnt    : natural;
   signal fpa_powered_i    : std_logic;
   signal dac_powered_i    : std_logic;
   signal readout_i        : std_logic;
   
   signal fpa_on_i         : std_logic;
   signal prog_data_i      : std_logic;
   signal lsync_i          : std_logic;
   signal fsync_i          : std_logic;
   signal mclk_i           : std_logic;
   signal dac_csn_i        : std_logic;
   signal dac_sd_i         : std_logic;
   signal dac_sclk_i       : std_logic;
   
   signal fpa_on_iob       : std_logic;
   signal prog_data_iob    : std_logic;
   signal lsync_iob         : std_logic;
   signal fsync_iob        : std_logic;
   signal mclk_iob         : std_logic;
   signal dac_csn_iob      : std_logic;
   signal dac_sd_iob       : std_logic;
   signal dac_sclk_iob     : std_logic;
   signal fsm_sreset       : std_logic;
   
   signal prog_mclk_i      : std_logic;
   signal prog_mclk_pipe   : std_logic_vector(7 downto 0);
   
   attribute IOB : string;
   attribute IOB of fpa_on_iob   : signal is "TRUE";
   attribute IOB of prog_data_iob: signal is "TRUE";
   attribute IOB of lsync_iob    : signal is "TRUE";
   attribute IOB of fsync_iob    : signal is "TRUE";
   attribute IOB of mclk_iob     : signal is "TRUE";
   attribute IOB of dac_csn_iob  : signal is "TRUE";
   attribute IOB of dac_sd_iob   : signal is "TRUE";
   attribute IOB of dac_sclk_iob : signal is "TRUE";
   
   
begin
   
   --------------------------------------------------------
   -- maps
   --------------------------------------------------------   
   FPA_POWERED <= fpa_powered_i;
   DAC_POWERED <= dac_powered_i;
   
   FPA_ON      <= fpa_on_iob;
   
   -- fpa_digio
   FPA_DIGIO1  <= '0';
   FPA_DIGIO2  <= '0'; 
   FPA_DIGIO3  <= prog_data_iob;
   FPA_DIGIO4  <= lsync_iob; 
   FPA_DIGIO5  <= '0';            
   FPA_DIGIO6  <= fsync_iob;   
   FPA_DIGIO7  <= mclk_iob;
   
   -- dac_digio
   FPA_DIGIO8  <= dac_sclk_iob;
   FPA_DIGIO9  <= dac_sd_iob; 
   FPA_DIGIO10 <= dac_csn_iob; 
   
   --------------------------------------------------------
   -- Sync reset
   -------------------------------------------------------- 
   U0 : sync_reset
   port map(ARESET => ARESET, CLK => MCLK_SOURCE, SRESET => sreset); 
   
   --------------------------------------------------
   -- double sync 
   --------------------------------------------------   
   U1B: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => READOUT, CLK => MCLK_SOURCE, Q => readout_i);
   
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
   -- registres dans iob
   --------------------------------------------------------- 
   UIOB: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         -- allumage tensions
         fpa_on_iob <= fpa_on_i; 
         
         -- contrôle detecteur
         prog_data_iob <= prog_data_i;           
         lsync_iob <= lsync_i;   
         fsync_iob <= fsync_i;
         mclk_iob <= mclk_i;  
         
         -- contrôle DAC
         dac_csn_iob <= dac_csn_i;
         dac_sd_iob <= dac_sd_i;
         dac_sclk_iob <= dac_sclk_i;         
      end if;   
   end process;  
   
   
   --------------------------------------------------------- 
   -- fsm fpa digio                                 
   ---------------------------------------------------------
   U12: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            fpa_digio_fsm <= idle; 
            fpa_timer_cnt <= 0;
            fpa_powered_i <= '0';
            prog_data_i <= '0';
            lsync_i <= '0';
            fsync_i <= '0';
            prog_data_i <= '0';
            mclk_i <= '0';
            
         else
            
            case fpa_digio_fsm is          
               
               -- delai
               when idle =>
                  if dac_powered_i = '1' then 
                     fpa_digio_fsm <= ldo_pwr_pause_st;
                  end if;
                  
               -- delai du monostable sur le fleg
               when ldo_pwr_pause_st =>
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt = DEFINE_FLEG_LDO_DLY_FACTOR then  -- delai implanté via U14 (LTC6994IS6-1#TRMPBF) du fleG
                     fpa_digio_fsm <= rst_cnt_st;
                  end if;
                  
                  -- pragma translate_off
                  if fpa_timer_cnt = 50 then 
                     fpa_digio_fsm <= rst_cnt_st;
                  end if;                
                  -- pragma translate_on 
               
               when rst_cnt_st =>
                  fpa_timer_cnt <= 0;
                  fpa_digio_fsm <= fpa_pwr_pause_st;
                  
               -- observer le delai FPA_POWER_WAIT  
               when fpa_pwr_pause_st =>
                  fsync_i <= '1';
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt > DEFINE_FPA_POWER_WAIT_FACTOR then
                     fpa_digio_fsm <=  fpa_pwred_st;
                  end if;
                  
                  -- pragma translate_off
                  if fpa_timer_cnt = 50 then 
                     fpa_digio_fsm <= fpa_pwred_st;
                  end if;                
                  -- pragma translate_on
                  
               -- annoncer la bonne nouvelle relative à l'allumage du détecteur
               when fpa_pwred_st =>
                  fpa_powered_i <= '1';        -- permet au driver de placer une requete de programmation
                  fpa_digio_fsm <= wait_trig_stop_st;                
                  
               -- attendre que le programmateur du FPA soit activée => trig arrêté
               when wait_trig_stop_st =>                  
                  if PROG_EN = '1'  then  -- si cela se produit, on est certain que le gestionnaire de trig est bloqué. Quitter rapidement pour ne pas manquer la communication
                     fpa_digio_fsm <= passthru_st;
                  end if;                   
                  
               -- venir ici rapidement pour ne pas manquer la communication du programmateur
               when passthru_st =>           -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  prog_data_i <= PROG_SD;
                  lsync_i <= FPA_LSYNC;
                  fsync_i <= not FPA_INT and PROG_CSN;  -- normalement on n'aura jamais FPA_INT à '1' et PROG_CSN à '0' en même temps => un et un seul de ces deux signaux fait baisser fsync_i 
                  mclk_i <= FPA_MCLK; 
                  if readout_i = '0' and FPA_INTF_CFG.ROIC_CST_OUTPUT_MODE = '1' and PROG_CSN = '1' then 
                     fpa_digio_fsm <= fpa_cst_output_st;
                  end if;
               
               when fpa_cst_output_st => -- la sortie du detecteur reste à la valeur de VOUTREF
                  mclk_i <= FPA_MCLK;   -- horloge active
                  lsync_i <= '0';       -- aucun lsync
                  fsync_i <= '1';       -- aucune integration
                  prog_data_i <= '0';
                  if readout_i = '0' and FPA_INTF_CFG.ROIC_CST_OUTPUT_MODE = '0' and PROG_CSN = '1' then 
                     fpa_digio_fsm <= passthru_st;
                  end if;
               
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
