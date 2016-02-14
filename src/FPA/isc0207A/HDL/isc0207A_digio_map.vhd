------------------------------------------------------------------
--!   @file : isc0207A_digio_map
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
use work.Tel2000.all;

entity isc0207A_digio_map is
   port(
      
      MCLK_SOURCE   : in std_logic;
      ARESET        : in std_logic; 
      
      
      FPA_INT       : in std_logic;
      
      ROIC_RESET_B  : in std_logic;
      FPA_MCLK      : in std_logic;
      
      SPI_CSN       : in std_logic;  
      SPI_DATA      : in std_logic;
      
      FPA_PWR       : in std_logic;
      FPA_ON        : out std_logic;
      FPA_POWERED   : out std_logic;      
      
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
end isc0207A_digio_map;


architecture rtl of isc0207A_digio_map is
   
   component sync_reset
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC;
         CLK    : in STD_LOGIC);
   end component;
   
   type digio_fsm_type   is (idle, power_pause_st, fpa_pwred_st, check_mclk_st, check_pause_end_st);   
   signal digio_fsm        : digio_fsm_type;
   signal sreset           : std_logic;
   signal fpa_on_i         : std_logic;
   signal roic_reset_b_i   : std_logic;
   signal roic_fsync_i     : std_logic;
   signal roic_mclk_i      : std_logic;
   signal roic_data_i      : std_logic;
   signal synchro_err      : std_logic;
   signal timer_cnt        : natural range 0 to DEFINE_FPA_POWER_WAIT_FACTOR + 2;
   signal fpa_powered_i    : std_logic;
   signal fpa_on_iob       : std_logic;
   signal roic_reset_b_iob : std_logic;
   signal roic_fsync_iob   : std_logic;
   signal roic_mclk_iob    : std_logic;
   signal roic_data_iob    : std_logic;
   
   attribute IOB : string;
   attribute IOB of fpa_on_iob          : signal is "TRUE";
   attribute IOB of roic_reset_b_iob    : signal is "TRUE";
   attribute IOB of roic_fsync_iob      : signal is "TRUE";
   attribute IOB of roic_mclk_iob       : signal is "TRUE";
   attribute IOB of roic_data_iob       : signal is "TRUE";
   
begin
   
   --------------------------------------------------------
   -- maps
   --------------------------------------------------------
   
   FPA_POWERED <= fpa_powered_i;
   FPA_ON      <= fpa_on_iob;   
   
   FPA_DIGIO1  <= '0';
   FPA_DIGIO2  <= '0'; 
   FPA_DIGIO3  <= roic_data_iob;
   FPA_DIGIO4  <= roic_reset_b_iob; 
   FPA_DIGIO5  <= '0';            
   FPA_DIGIO6  <= roic_fsync_iob;   
   FPA_DIGIO7  <= roic_mclk_iob;    
   FPA_DIGIO8  <= '0'; 
   FPA_DIGIO9  <= '0'; 
   FPA_DIGIO10 <= '0'; 
   
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
      end if;   
   end process; 
   
   
   --------------------------------------------------------- 
   -- registres dans iob
   --------------------------------------------------------- 
   UIOB: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         fpa_on_iob      <= fpa_on_i; 
         roic_data_iob  <= roic_data_i;
         roic_reset_b_iob  <= roic_reset_b_i;           
         roic_fsync_iob  <= roic_fsync_i;   
         roic_mclk_iob <= roic_mclk_i;  
      end if;   
   end process;  
   
   
   --------------------------------------------------------- 
   -- gestion du signal RDY                                 
   ---------------------------------------------------------
   U12: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if sreset = '1' then
            roic_data_i    <= '0';
            roic_reset_b_i <= '0';
            roic_fsync_i   <= '0';
            roic_mclk_i    <= '0';
            synchro_err    <= '0'; 
            digio_fsm      <=  idle;
            timer_cnt      <=  0;
            fpa_powered_i  <= '0';
            
         else
            
            case digio_fsm is          
               
               -- attente du signal d'allumage du proxy
               when idle =>
                  fpa_powered_i  <= '0';
                  timer_cnt      <=  0;
                  if FPA_PWR = '1' then
                     digio_fsm <= power_pause_st;
                  end if;                  
                  
               -- incrementation compteur de pause
               when power_pause_st =>
                  if FPA_PWR = '1' then
                     timer_cnt <=  timer_cnt + 2;  -- +2 pour tenir compte de l'état check_pause_end_st qui induit un coup d'horloge
                     digio_fsm <= check_pause_end_st;
                  else
                     digio_fsm <= idle;
                  end if;                   
                  
               -- regarder si fin de la pause  
               when check_pause_end_st =>
                  if timer_cnt > DEFINE_FPA_POWER_WAIT_FACTOR then
                     digio_fsm <= check_mclk_st;
                  else
                     digio_fsm <= power_pause_st;
                  end if;
                  -- pragma translate_off
                  digio_fsm <= check_mclk_st;                 
                  -- pragma translate_on
                  
               -- proxy est pret à recevoir des contrôles 
               when check_mclk_st =>
                  if FPA_MCLK = '0' and FPA_INT = '0' then  -- pour eviter troncature sur ces signaux
                     digio_fsm <= fpa_pwred_st;
                  end if;                   
               
               when fpa_pwred_st =>
                  fpa_powered_i <= '1';
                  roic_data_i <= SPI_DATA;
                  roic_reset_b_i <= ROIC_RESET_B;
                  roic_fsync_i <= not FPA_INT and SPI_CSN;
                  roic_mclk_i <= FPA_MCLK;           
                  if FPA_PWR = '0' then
                     digio_fsm <= idle;
                  end if;      
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process;  
   
end rtl;
