------------------------------------------------------------------
--!   @file : isc0209A_prog_mux
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
use work.fpa_define.all;

entity isc0209A_prog_mux is
   port(                                         
      -- 
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      -- interfaçage avec le contrôleur principal
      PROG_RQST        : out std_logic;
      PROG_EN          : in std_logic;
      PROG_DONE        : out std_logic;
      
      -- programmateur du window du detecteur
      WIND_RQST        : in std_logic;
      WIND_REG         : in std_logic_vector(31 downto 0);
      WIND_DONE        : out std_logic;       
      
      -- programmateur du mode du detecteur
      MODE_RQST        : in std_logic;
      MODE_REG         : in std_logic_vector(31 downto 0);
      MODE_DONE        : out std_logic; 
      
      -- sortie vers spi
      SPI_DATA         : out std_logic_vector(31 downto 0);
      SPI_EN           : out std_logic;
      SPI_DONE         : in std_logic      
      );
end isc0209A_prog_mux;


architecture rtl of isc0209A_prog_mux is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   type prog_mux_fsm_type is (idle, forward_rqst_st, check_rqst_st, mode_prog_st, wind_prog_st, wait_mode_end_st, pause_st, wait_wind_end_st);
   
   signal prog_mux_fsm              : prog_mux_fsm_type;
   signal sreset                    : std_logic;
   signal pause_cnt                 : unsigned(7 downto 0);
   signal prog_rqst_i               : std_logic;
   signal prog_done_i               : std_logic;
   signal rqst_pending              : std_logic;
   signal spi_en_i                  : std_logic;
   signal spi_data_i                : std_logic_vector(31 downto 0);
   signal mode_done_i               : std_logic;
   signal wind_done_i               : std_logic;
   
begin
   
   PROG_RQST <= prog_rqst_i;
   PROG_DONE <= prog_done_i;
   
   SPI_DATA <= spi_data_i;
   SPI_EN <= spi_en_i; 
   
   WIND_DONE <=  wind_done_i;
   MODE_DONE <=  mode_done_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   --  attribution des priorités
   --------------------------------------------------
   U3: process(CLK)   
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            prog_mux_fsm <=  idle;
            prog_done_i <= '0';
            rqst_pending <= '0';
            prog_rqst_i <= '0';
            mode_done_i <= '0';
            wind_done_i <= '0';
            spi_en_i <= '0';
            
         else                   
            
            rqst_pending <= WIND_RQST or MODE_RQST;
            
            
            --fsm de contrôle            
            case  prog_mux_fsm is
               
               -- attente d'une demande
               when idle =>      
                  prog_done_i <= '1';                    
                  prog_rqst_i <= '0';
                  mode_done_i <= '1';
                  wind_done_i <= '1';
                  if rqst_pending = '1' and SPI_DONE = '1' then 
                     prog_mux_fsm <= forward_rqst_st;
                  end if;
                  
               -- demande envoyée au contrôleur principal
               when forward_rqst_st =>
                  prog_rqst_i <= '1';                                
                  if PROG_EN = '1' then
                     prog_mux_fsm <= check_rqst_st;
                  end if;
                  
               -- quel client fait la demande
               when check_rqst_st => 
                  prog_done_i <= '0';
                  prog_rqst_i <= '0'; 
                  pause_cnt <= (others => '0');   
                  if MODE_RQST = '1' then
                     prog_mux_fsm <= mode_prog_st;
                  elsif WIND_RQST = '1' then  
                     prog_mux_fsm <= wind_prog_st;
                  else                   -- si aucune demande c'Est qu'on venait de l'état pause_st, alors on retourne à idle. Donc ne jamais enlever cet état
                     prog_mux_fsm <= idle;
                  end if;                   
                  
               -- accès accordé au mode prog
               when mode_prog_st =>     
                  spi_data_i <= MODE_REG;
                  spi_en_i <= '1';
                  if SPI_DONE = '0' then
                     mode_done_i <= '0';
                     prog_mux_fsm <= wait_mode_end_st;
                  end if;
                  
               -- attente de la fin de transaction pour le mode
               when  wait_mode_end_st =>                      
                  spi_en_i <= '0';
                  if SPI_DONE = '1' then
                     prog_mux_fsm <= pause_st;
                  end if;               
                  
               -- accès accordé au programmateur du détecteur
               when  wind_prog_st =>
                  spi_data_i <= WIND_REG;
                  spi_en_i <= '1';
                  if SPI_DONE = '0' then
                     wind_done_i <= '0';
                     prog_mux_fsm <= wait_wind_end_st;
                  end if; 
                  
               -- attente de la fin de transaction pour le programmateur du détecteur
               when  wait_wind_end_st =>
                  spi_en_i <= '0';
                  if SPI_DONE = '1' then
                     prog_mux_fsm <= pause_st;
                  end if;   
                  
               -- on donne le temps pour voir si une autre demande du mode suit
               when  pause_st =>
                  wind_done_i <= '1';
                  mode_done_i <= '1';
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt = 100 then   -- largement le temps qu'une autre demande du mode soit placée. de plus, cela permet d'avoir un delai reglementaire de 3 MCLK au moins avant une  nouvelle programmation
                     prog_mux_fsm <= check_rqst_st;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;   
   end process; 
   
end rtl;
