------------------------------------------------------------------
--!   @file : calcium_prog_ctrler_core
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
use IEEE.numeric_std.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.proxy_define.all;
use work.tel2000.all;

entity calcium_prog_ctrler_core is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      -- config
      USER_CFG          : in fpa_intf_cfg_type;
      ROIC_RX_NB_DATA   : out std_logic_vector(7 downto 0);    -- feedback du nombre de données reçues disponibles dans la RAM
      
      -- interface avec le contrôleur principal
      PROG_EN           : in std_logic;
      PROG_RQST         : out std_logic;
      PROG_DONE         : out std_logic;
      ROIC_INIT_DONE    : out std_logic;
      
      -- interface RAM
      RAM_BUSY          : in std_logic;
      RAM_RD_EN         : out std_logic;
      RAM_RD_ADD        : out std_logic_vector(8 downto 0);
      RAM_RD_DATA       : in std_logic_vector(15 downto 0);
      RAM_RD_DVAL       : in std_logic;
      RAM_WR_EN         : out std_logic;
      RAM_WR_ADD        : out std_logic_vector(8 downto 0);
      RAM_WR_DATA       : out std_logic_vector(15 downto 0);
      
      -- interface PROG TX
      TX_DVAL           : out std_logic;
      TX_DATA           : out std_logic_vector(15 downto 0);
      TX_TLAST          : out std_logic;
      TX_DONE           : in std_logic;
      
      -- interface PROG RX
      RX_DVAL           : in std_logic;
      RX_DATA           : in std_logic_vector(15 downto 0)
   );
end calcium_prog_ctrler_core;

architecture rtl of calcium_prog_ctrler_core is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;

   component double_sync_vector is
      port (
         D : in std_logic_vector;
         Q : out std_logic_vector;
         CLK : in std_logic
      );
   end component;
   
   component gh_binary2gray
      generic (
         SIZE : integer := 8
      );
      port (
         B : in std_logic_vector(SIZE-1 downto 0);
         G : out std_logic_vector(SIZE-1 downto 0)
      );
   end component;
   
   constant C_END_OF_TRANSMISSION_WAIT_FACTOR   : positive := 16 * DEFINE_FPA_PROG_SCLK_RATE_FACTOR;   -- Must wait 16 SCLK before allowing a new transmission
   constant C_END_OF_TRANSMISSION_WAIT_NB_BITS  : positive := log2(C_END_OF_TRANSMISSION_WAIT_FACTOR)+1;
   constant C_RAM_NB_ADDR                       : natural  := 2**(RAM_RD_ADD'length);
   constant C_TX_RAM_BASE_ADDR                  : natural  := 0;                 -- TX ram starts at 0
   constant C_RX_RAM_BASE_ADDR                  : natural  := C_RAM_NB_ADDR/2;   -- RX ram starts at total size / 2
   constant C_NB_EXTRA_DATA                     : positive := 2;   -- RX is 32 SCLK delayed from TX (0 is not supported)
   constant C_TX_EXTRA_DATA_VALUE               : std_logic_vector(TX_DATA'length-1 downto 0) := (others => '1');    -- same as idle MOSI
   
   type prog_fsm_type is (idle, forward_rqst_st, check_nb_data_st, read_ram_st, wait_ram_data_st, transmit_data_st, transmit_data_done_st, check_last_data_st,
                          transmit_extra_data_st, transmit_extra_data_done_st, check_last_extra_data_st, wait_prog_end_st, pause_st);
   type feedback_fsm_type is (idle, skip_data_st, wait_data_st, write_data_st, check_last_data_st);
   
   signal prog_fsm                  : prog_fsm_type;
   signal feedback_fsm              : feedback_fsm_type;
   signal sreset                    : std_logic;
   signal pause_cnt                 : unsigned(C_END_OF_TRANSMISSION_WAIT_NB_BITS-1 downto 0);
   signal prog_rqst_i               : std_logic;
   signal prog_done_i               : std_logic;
   signal roic_init_done_i          : std_logic;
   signal tx_dval_i                 : std_logic;
   signal tx_data_i                 : std_logic_vector(TX_DATA'length-1 downto 0);
   signal tx_tlast_i                : std_logic;
   signal cfg_num_gray              : std_logic_vector(USER_CFG.CFG_NUM'length-1 downto 0);
   signal cfg_num_i                 : std_logic_vector(USER_CFG.CFG_NUM'length-1 downto 0);
   signal new_cfg_num               : unsigned(USER_CFG.CFG_NUM'length-1 downto 0);
   signal present_cfg_num           : unsigned(USER_CFG.CFG_NUM'length-1 downto 0);
   signal new_cfg_num_pending       : std_logic;
   signal ram_rd_en_i               : std_logic;
   signal ram_rd_add_i              : unsigned(RAM_RD_ADD'length-1 downto 0);
   signal ram_wr_en_i               : std_logic;
   signal ram_wr_add_i              : unsigned(RAM_WR_ADD'length-1 downto 0);
   signal ram_wr_data_i             : std_logic_vector(RAM_WR_DATA'length-1 downto 0);
   signal roic_rx_nb_data_i         : unsigned(ROIC_RX_NB_DATA'length-1 downto 0);
   signal tx_data_cnt               : unsigned(USER_CFG.ROIC_TX_NB_DATA'length-1 downto 0);
   signal rx_data_cnt               : unsigned(USER_CFG.ROIC_TX_NB_DATA'length-1 downto 0);
   signal total_rx_data_cnt         : unsigned(USER_CFG.ROIC_TX_NB_DATA'length-1 downto 0);
   signal rx_start                  : std_logic;
   
begin

   -- Output mapping
   PROG_RQST <= prog_rqst_i;
   PROG_DONE <= prog_done_i;
   ROIC_INIT_DONE <= roic_init_done_i;
   TX_DATA <= tx_data_i;
   TX_DVAL <= tx_dval_i;
   TX_TLAST <= tx_tlast_i;
   RAM_RD_EN <= ram_rd_en_i;
   RAM_RD_ADD <= std_logic_vector(ram_rd_add_i);
   RAM_WR_EN <= ram_wr_en_i;
   RAM_WR_ADD <= std_logic_vector(ram_wr_add_i);
   RAM_WR_DATA <= ram_wr_data_i;
   ROIC_RX_NB_DATA <= std_logic_vector(roic_rx_nb_data_i);
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
   );
   
   --------------------------------------------------
   -- Gray encoding of CFG_NUM 
   --------------------------------------------------
   U2 : gh_binary2gray
   generic map (
      SIZE => USER_CFG.CFG_NUM'length
   )
   port map (
      B => std_logic_vector(USER_CFG.CFG_NUM),
      G => cfg_num_gray
   );
   
   --------------------------------------------------
   -- Double sync of Gray encoded CFG_NUM
   --------------------------------------------------
   U3 : double_sync_vector
   port map (
      D => cfg_num_gray,
      CLK => CLK,
      Q => cfg_num_i
   );
   
   --------------------------------------------------
   -- New config detection
   --------------------------------------------------
   -- ENO: 26 nov 2018: Pour eviter bugs , reprogrammer le ROIC, dès qu'une config est reçue du MB.
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then
         
         -- nouvelle config lorsque cfg_num change
         new_cfg_num <= unsigned(cfg_num_i);
         
         -- detection du changement
         if present_cfg_num /= new_cfg_num then
            new_cfg_num_pending <= '1';
         else
            new_cfg_num_pending <= '0';
         end if;
         
      end if;
   end process;
   
   --------------------------------------------------
   -- ROIC programmation
   --------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            prog_fsm <= idle;
            prog_done_i <= '0';
            prog_rqst_i <= '0';
            tx_dval_i <= '0';
            present_cfg_num <= not new_cfg_num;
            roic_init_done_i <= '0';
            ram_rd_en_i <= '0';
            rx_start <= '0';
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings
            case prog_fsm is
               
               -- attente d'une demande
               when idle =>      
                  prog_done_i <= '1';
                  prog_rqst_i <= '0';
                  tx_dval_i <= '0';
                  tx_tlast_i <= '0';
                  ram_rd_en_i <= '0';
                  ram_rd_add_i <= to_unsigned(C_TX_RAM_BASE_ADDR, ram_rd_add_i'length);
                  if new_cfg_num_pending = '1' then
                     present_cfg_num <= new_cfg_num;  -- mis à jour le plus tôt possible pour qu'un changement de cfg pendant une prog déclenche une 2e prog
                     tx_data_cnt <= USER_CFG.ROIC_TX_NB_DATA;    -- countdown des données à envoyer
                     prog_fsm <= forward_rqst_st;
                  end if;
                  
               -- demande envoyée au contrôleur principal
               when forward_rqst_st =>
                  prog_rqst_i <= '1';
                  if PROG_EN = '1' then
                     prog_done_i <= '0';
                     prog_rqst_i <= '0';
                     prog_fsm <= check_nb_data_st;
                  end if;
               
               -- accès accordé au programmeur du détecteur, on vérifie s'il y a une prog à faire au ROIC
               when check_nb_data_st =>
                  if tx_data_cnt = 0 then
                     -- S'il n'y a rien à envoyer au ROIC on retourne en idle ce qui permet de mettre à jour la fpa cfg
                     prog_fsm <= idle;
                  else
                     rx_start <= '1';     -- active la fsm de RX
                     prog_fsm <= read_ram_st;
                  end if;
               
               -- lire la ram
               when read_ram_st =>
                  rx_start <= '0';
                  if RAM_BUSY = '0' then
                     ram_rd_en_i <= '1';
                     prog_fsm <= wait_ram_data_st;
                  end if;
               
               -- attendre la donnée de la ram
               when wait_ram_data_st =>
                  ram_rd_en_i <= '0';
                  tx_data_i <= RAM_RD_DATA;
                  if RAM_RD_DVAL = '1' then
                     tx_dval_i <= '1';       -- reste à 1 tant que la donnée n'a pas été prise par le driver
                     prog_fsm <= transmit_data_st;
                  end if;
               
               -- transmission de la donnée au driver
               when transmit_data_st =>
                  -- on attend que le driver soit prêt
                  if TX_DONE = '1' then
                     prog_fsm <= transmit_data_done_st;
                  end if; 
                  
               -- on attend que la donnée soit prise par le driver
               when transmit_data_done_st =>
                  if TX_DONE = '0' then
                     tx_dval_i <= '0';
                     tx_data_cnt <= tx_data_cnt - 1;
                     prog_fsm <= check_last_data_st;
                  end if; 
                  
               -- on vérifie si la dernière donnée a été envoyée 
               when check_last_data_st =>
                  if tx_data_cnt = 0 then
                     tx_data_cnt <= to_unsigned(C_NB_EXTRA_DATA, tx_data_cnt'length);    -- countdown des données d'extra à envoyer
                     prog_fsm <= transmit_extra_data_st;
                  else
                     -- on incrémente l'adresse pour la prochaine donnée
                     ram_rd_add_i <= ram_rd_add_i + 1;
                     prog_fsm <= read_ram_st;
                  end if;
               
               -- transmission de la donnée d'extra au driver
               when transmit_extra_data_st =>
                  tx_data_i <= C_TX_EXTRA_DATA_VALUE;
                  -- on vérifie si cette donnée d'extra est la dernière
                  if tx_data_cnt = 1 then
                     tx_tlast_i <= '1';
                  end if;
                  tx_dval_i <= '1';       -- reste à 1 tant que la donnée n'a pas été prise par le driver
                  if TX_DONE = '1' then
                     prog_fsm <= transmit_extra_data_done_st;
                  end if; 
                  
               -- on attend que la donnée d'extra soit prise par le driver
               when transmit_extra_data_done_st =>
                  if TX_DONE = '0' then
                     tx_dval_i <= '0';
                     tx_data_cnt <= tx_data_cnt - 1;
                     prog_fsm <= check_last_extra_data_st;
                  end if; 
                  
               -- on vérifie si cette donnée d'extra était la dernière
               when check_last_extra_data_st =>
                  if tx_tlast_i = '1' then
                     prog_fsm <= wait_prog_end_st;
                  else
                     prog_fsm <= transmit_extra_data_st;
                  end if;
               
               -- on attend que le driver ait fini la dernière transmission
               when wait_prog_end_st =>
                  if TX_DONE = '1' then
                     pause_cnt <= (others => '0');
                     prog_fsm <= pause_st;
                  end if;
                  
               -- on fait une pause avant de permettre la prochaine commande
               when pause_st =>
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt >= C_END_OF_TRANSMISSION_WAIT_FACTOR then
                     roic_init_done_i <= '1';   -- l'init du roic est terminée lorsque la 1re config est transmise
                     prog_fsm <= idle;
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- ROIC feedback
   --------------------------------------------------
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            feedback_fsm <= idle;
            ram_wr_en_i <= '0';
            roic_rx_nb_data_i <= (others => '0');
         else 
            
            case feedback_fsm is
               
               -- on attend le début du message
               when idle =>
                  ram_wr_add_i <= to_unsigned(C_RX_RAM_BASE_ADDR, ram_wr_add_i'length);
                  ram_wr_en_i <= '0';
                  rx_data_cnt <= (others => '0');     -- on reset le compteur pour les données d'extra reçues
                  if rx_start = '1' then
                     total_rx_data_cnt <= tx_data_cnt;         -- TX et RX ont le même nombre de données
                     roic_rx_nb_data_i <= (others => '0');     -- le dernier message n'est plus disponible
                     feedback_fsm <= skip_data_st;
                  end if;
               
               -- on ignore les premières données puisque le RX est en retard sur le TX
               when skip_data_st =>
                  -- on vérifie que toutes les données d'extra ont été reçues
                  if rx_data_cnt = C_NB_EXTRA_DATA then
                     rx_data_cnt <= (others => '0');     -- on reset le compteur pour les données reçues
                     feedback_fsm <= wait_data_st;
                  end if;
                  if RX_DVAL = '1' then
                     rx_data_cnt <= rx_data_cnt + 1;
                  end if;
               
               -- on attend la donnée du driver
               when wait_data_st =>
                  ram_wr_data_i <= RX_DATA;
                  if RX_DVAL = '1' then
                     feedback_fsm <= write_data_st;
                  end if;
               
               -- on écrit la donnée dans la ram
               when write_data_st =>
                  -- on vérifie que la ram n'est pas déjà en lecture ou busy
                  if ram_rd_en_i = '0' and RAM_BUSY = '0' then
                     ram_wr_en_i <= '1';
                     rx_data_cnt <= rx_data_cnt + 1;
                     feedback_fsm <= check_last_data_st;
                  end if;
               
               -- on vérifie si cette donnée était la dernière
               when check_last_data_st =>
                  ram_wr_en_i <= '0';
                  if rx_data_cnt = total_rx_data_cnt then
                     roic_rx_nb_data_i <= resize(rx_data_cnt, roic_rx_nb_data_i'length);  -- on retourne le nombre de données reçues
                     feedback_fsm <= idle;
                  else
                     -- on incrémente l'adresse pour la prochaine donnée
                     ram_wr_add_i <= ram_wr_add_i + 1;
                     feedback_fsm <= wait_data_st;
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   
end rtl;
