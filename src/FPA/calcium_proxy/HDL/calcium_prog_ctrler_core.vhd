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
      ARESET                     : in std_logic;
      CLK                        : in std_logic;
      
      -- config
      USER_CFG                   : in fpa_intf_cfg_type;
      ROIC_EXP_TIME_CFG          : in roic_exp_time_cfg_type;           -- paramètres reliés au temps d'intégration à programmer dans le ROIC
      ROIC_EXP_TIME_CFG_EN       : in std_logic;
      ROIC_EXP_TIME_CFG_DONE     : out std_logic;
      ROIC_RX_NB_DATA            : out std_logic_vector(7 downto 0);    -- feedback du nombre de données reçues disponibles dans la RAM
      RESET_ROIC_RX_DATA         : in std_logic;
      
      -- interface avec le contrôleur principal
      PROG_EN                    : in std_logic;
      PROG_RQST                  : out std_logic;
      PROG_DONE                  : out std_logic;
      ROIC_INIT_DONE             : out std_logic;
      
      -- interface RAM
      RAM_BUSY                   : in std_logic;
      RAM_RD_EN                  : out std_logic;
      RAM_RD_ADD                 : out std_logic_vector(8 downto 0);
      RAM_RD_DATA                : in std_logic_vector(15 downto 0);
      RAM_RD_DVAL                : in std_logic;
      RAM_WR_EN                  : out std_logic;
      RAM_WR_ADD                 : out std_logic_vector(8 downto 0);
      RAM_WR_DATA                : out std_logic_vector(15 downto 0);
      
      -- interface PROG TX
      TX_DVAL                    : out std_logic;
      TX_DATA                    : out std_logic_vector(15 downto 0);
      TX_TLAST                   : out std_logic;
      TX_DONE                    : in std_logic;
      
      -- interface PROG RX
      RX_DVAL                    : in std_logic;
      RX_DATA                    : in std_logic_vector(15 downto 0)
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
   
   component double_sync
      generic (
         INIT_VALUE : bit := '0'
      );
      port (
         D     : in STD_LOGIC;
         Q     : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK   : in STD_LOGIC
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
   
   type cfg_prog_fsm_type is (idle, forward_rqst_st, check_nb_data_st, wait_cfg_in_progress_st, read_ram_st, wait_copy_data_st,
                              transmit_data_done_st, check_last_data_st, wait_prog_end_st);
   type exp_prog_fsm_type is (idle, wait_exp_in_progress_st, wait_prog_end_st);
   type prog_fsm_type is (idle, wait_cfg_data_st, wait_exp_data_st, transmit_data_st, transmit_data_done_st, check_last_data_st,
                          transmit_extra_data_st, transmit_extra_data_done_st, check_last_extra_data_st, wait_prog_end_st, pause_st);
   type feedback_fsm_type is (idle, skip_data_st, wait_data_st, write_data_st, check_last_data_st);
   
   signal cfg_prog_fsm              : cfg_prog_fsm_type;
   signal exp_prog_fsm              : exp_prog_fsm_type;
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
   signal roic_exp_time_cfg_en_sync : std_logic;
   signal roic_exp_time_cfg_done_i  : std_logic;
   signal ram_rd_en_i               : std_logic;
   signal ram_rd_add_i              : unsigned(RAM_RD_ADD'length-1 downto 0);
   signal ram_wr_en_i               : std_logic;
   signal ram_wr_add_i              : unsigned(RAM_WR_ADD'length-1 downto 0);
   signal ram_wr_data_i             : std_logic_vector(RAM_WR_DATA'length-1 downto 0);
   signal roic_rx_nb_data_i         : unsigned(ROIC_RX_NB_DATA'length-1 downto 0);
   signal reset_roic_rx_data_sync   : std_logic;
   signal cfg_data_cnt              : natural range 0 to 2**USER_CFG.ROIC_TX_NB_DATA'length-1;
   signal tx_data_cnt               : natural range 0 to 2**USER_CFG.ROIC_TX_NB_DATA'length-1;
   signal rx_data_cnt               : natural range 0 to 2**USER_CFG.ROIC_TX_NB_DATA'length-1;
   signal total_rx_data_cnt         : natural range 0 to 2**USER_CFG.ROIC_TX_NB_DATA'length-1;
   signal rx_start                  : std_logic;
   signal cfg_rqst                  : std_logic;
   signal exp_rqst                  : std_logic;
   signal cfg_in_progress           : std_logic;
   signal exp_in_progress           : std_logic;
   
   --------------------------------------------------
   -- Exposure time config
   --------------------------------------------------
   constant EXP_NUM_REGS      : natural  := 9;
   --                                                     sync word / write / frm (not used) / page id (not used) / number of words (header excluded)
   constant EXP_HEADER        : unsigned(15 downto 0) :=  "010"     & '1'   & '0'            & "000"              & to_unsigned(EXP_NUM_REGS, 8);
   type roic_reg_type is
   record
      addr     : unsigned(7 downto 0);    -- MSB
      data     : unsigned(7 downto 0);    -- LSB
   end record;
   type exp_reg_array_type is array (1 to EXP_NUM_REGS+1) of roic_reg_type;   -- +1 header
   signal exp_reg_ary         : exp_reg_array_type;
   
   function convert_exp_cfg_to_reg(EXP_TIME_CFG : roic_exp_time_cfg_type) return exp_reg_array_type is
      variable exp_reg_ary : exp_reg_array_type;
   begin
      -- exp_reg_ary is accessed with a countdown so last index is sent first
      -- header
      exp_reg_ary(10).addr := EXP_HEADER(15 downto 8);
      exp_reg_ary(10).data := EXP_HEADER(7 downto 0);
      -- bIntCnt
      exp_reg_ary(9).addr := to_unsigned(22, roic_reg_type.addr'length);
      exp_reg_ary(9).data := resize(EXP_TIME_CFG.bIntCnt(7 downto 0), roic_reg_type.data'length);
      exp_reg_ary(8).addr := to_unsigned(23, roic_reg_type.addr'length);
      exp_reg_ary(8).data := resize(EXP_TIME_CFG.bIntCnt(15 downto 8), roic_reg_type.data'length);
      exp_reg_ary(7).addr := to_unsigned(24, roic_reg_type.addr'length);
      exp_reg_ary(7).data := resize(EXP_TIME_CFG.bIntCnt(19 downto 16), roic_reg_type.data'length);
      -- bDSMCycles
      exp_reg_ary(6).addr := to_unsigned(30, roic_reg_type.addr'length);
      exp_reg_ary(6).data := resize(EXP_TIME_CFG.bDSMCycles(7 downto 0), roic_reg_type.data'length);
      exp_reg_ary(5).addr := to_unsigned(31, roic_reg_type.addr'length);
      exp_reg_ary(5).data := resize(EXP_TIME_CFG.bDSMCycles(15 downto 8), roic_reg_type.data'length);
      -- bDSMDelayCnt
      exp_reg_ary(4).addr := to_unsigned(35, roic_reg_type.addr'length);
      exp_reg_ary(4).data := resize(EXP_TIME_CFG.bDSMDelayCnt(7 downto 0), roic_reg_type.data'length);
      exp_reg_ary(3).addr := to_unsigned(36, roic_reg_type.addr'length);
      exp_reg_ary(3).data := resize(EXP_TIME_CFG.bDSMDelayCnt(15 downto 8), roic_reg_type.data'length);
      -- bDSMInitDelayCnt
      exp_reg_ary(2).addr := to_unsigned(37, roic_reg_type.addr'length);
      exp_reg_ary(2).data := resize(EXP_TIME_CFG.bDSMInitDelayCnt(7 downto 0), roic_reg_type.data'length);
      exp_reg_ary(1).addr := to_unsigned(38, roic_reg_type.addr'length);
      exp_reg_ary(1).data := resize(EXP_TIME_CFG.bDSMInitDelayCnt(15 downto 8), roic_reg_type.data'length);
      return exp_reg_ary;
   end convert_exp_cfg_to_reg;
   
begin

   -- Output mapping
   PROG_RQST <= prog_rqst_i;
   PROG_DONE <= prog_done_i;
   ROIC_EXP_TIME_CFG_DONE <= roic_exp_time_cfg_done_i;
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
   -- Gray encoding and double sync of CFG_NUM 
   --------------------------------------------------
   U2A : gh_binary2gray
   generic map (
      SIZE => USER_CFG.CFG_NUM'length
   )
   port map (
      B => std_logic_vector(USER_CFG.CFG_NUM),
      G => cfg_num_gray
   );
   
   U2B : double_sync_vector
   port map (
      D => cfg_num_gray,
      CLK => CLK,
      Q => cfg_num_i
   );
   
   --------------------------------------------------
   -- Double sync 
   --------------------------------------------------   
   U3A : double_sync
   generic map (
      INIT_VALUE => '0'
   )
   port map (
      RESET => sreset,
      D => ROIC_EXP_TIME_CFG_EN,
      CLK => CLK,
      Q => roic_exp_time_cfg_en_sync
   );
   
   U3B : double_sync
   generic map (
      INIT_VALUE => '0'
   )
   port map (
      RESET => sreset,
      D => RESET_ROIC_RX_DATA,
      CLK => CLK,
      Q => reset_roic_rx_data_sync
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
   -- Programmation de cfg contenue dans RAM
   --------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            cfg_prog_fsm <= idle;
            prog_done_i <= '0';
            prog_rqst_i <= '0';
            present_cfg_num <= not new_cfg_num;
            cfg_rqst <= '0';
            roic_init_done_i <= '0';
            ram_rd_en_i <= '0';
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings
            case cfg_prog_fsm is
               
               -- attente d'une demande
               when idle =>      
                  prog_done_i <= '1';
                  prog_rqst_i <= '0';
                  ram_rd_en_i <= '0';
                  ram_rd_add_i <= to_unsigned(C_TX_RAM_BASE_ADDR, ram_rd_add_i'length);
                  if new_cfg_num_pending = '1' then
                     present_cfg_num <= new_cfg_num;  -- mis à jour le plus tôt possible pour qu'un changement de cfg pendant une prog déclenche une 2e prog
                     cfg_data_cnt <= to_integer(USER_CFG.ROIC_TX_NB_DATA);
                     cfg_prog_fsm <= forward_rqst_st;
                  end if;
                  
               -- demande envoyée au contrôleur principal
               when forward_rqst_st =>
                  prog_rqst_i <= '1';
                  if PROG_EN = '1' then
                     prog_done_i <= '0';
                     prog_rqst_i <= '0';
                     cfg_prog_fsm <= check_nb_data_st;
                  end if;
               
               -- accès accordé au programmeur du détecteur, on vérifie s'il y a une prog à faire au ROIC
               when check_nb_data_st =>
                  if cfg_data_cnt = 0 then
                     -- s'il n'y a rien à envoyer au ROIC on retourne en idle ce qui permet de mettre à jour la FPA INTF CFG
                     cfg_prog_fsm <= idle;
                  else
                     -- on fait la demande d'utiliser la fsm de programmation
                     cfg_rqst <= '1';        -- reste à 1 tant que la requête n'a pas été approuvée
                     cfg_prog_fsm <= wait_cfg_in_progress_st;
                  end if;
               
               -- attendre la confirmation de la fsm de programmation
               when wait_cfg_in_progress_st =>
                  if cfg_in_progress = '1' then
                     cfg_rqst <= '0';
                     cfg_prog_fsm <= read_ram_st;
                  end if;
               
               -- lire la ram
               when read_ram_st =>
                  if RAM_BUSY = '0' then
                     ram_rd_en_i <= '1';
                     cfg_prog_fsm <= wait_copy_data_st;
                  end if;
               
               -- attendre la copie de la donnée par la fsm de programmation
               when wait_copy_data_st =>
                  ram_rd_en_i <= '0';
                  if tx_dval_i = '1' then
                     cfg_prog_fsm <= transmit_data_done_st;
                  end if; 
                  
               -- on attend que la donnée soit transmise par la fsm de programmation
               when transmit_data_done_st =>
                  if tx_dval_i = '0' then
                     cfg_prog_fsm <= check_last_data_st;
                  end if; 
                  
               -- on vérifie si la dernière donnée a été envoyée 
               when check_last_data_st =>
                  if tx_data_cnt = 0 then
                     cfg_prog_fsm <= wait_prog_end_st;
                  else
                     -- on incrémente l'adresse pour la prochaine donnée
                     ram_rd_add_i <= ram_rd_add_i + 1;
                     cfg_prog_fsm <= read_ram_st;
                  end if;
               
               -- on attend que la fsm de programmation ait fini
               when wait_prog_end_st =>
                  if cfg_in_progress = '0' then
                     roic_init_done_i <= '1';   -- l'init du roic est terminée lorsque la 1re config est transmise
                     cfg_prog_fsm <= idle;
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- Programmation de exp cfg provenant de ROIC_EXP_TIME_CFG
   --------------------------------------------------
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            exp_prog_fsm <= idle;
            roic_exp_time_cfg_done_i <= '0';
            exp_rqst <= '0';
            
         else    
            
            -- conversion de la exp cfg en array de registres
            exp_reg_ary <= convert_exp_cfg_to_reg(ROIC_EXP_TIME_CFG);
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings
            case exp_prog_fsm is
               
               -- attente d'une demande
               when idle =>      
                  roic_exp_time_cfg_done_i <= '1';    -- prêt à recevoir une exp cfg
                  if roic_exp_time_cfg_en_sync = '1' then
                     roic_exp_time_cfg_done_i <= '0';       -- la exp cfg est en traitement
                     -- on fait la demande d'utiliser la fsm de programmation
                     exp_rqst <= '1';        -- reste à 1 tant que la requête n'a pas été approuvée
                     exp_prog_fsm <= wait_exp_in_progress_st;
                  end if;
               
               -- on attend la confirmation de la fsm de programmation
               when wait_exp_in_progress_st =>
                  if exp_in_progress = '1' then
                     exp_rqst <= '0';
                     exp_prog_fsm <= wait_prog_end_st;
                  end if;
               
               -- on attend que la fsm de programmation ait fini
               when wait_prog_end_st =>
                  if exp_in_progress = '0' then
                     exp_prog_fsm <= idle;
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- ROIC programmation
   --------------------------------------------------
   U7 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            prog_fsm <= idle;
            tx_dval_i <= '0';
            rx_start <= '0';
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings
            case prog_fsm is
               
               -- attente d'une demande
               when idle =>
                  cfg_in_progress <= '0';
                  exp_in_progress <= '0';
                  tx_tlast_i <= '0';
                  -- demande de programmation de cfg
                  if cfg_rqst = '1' then
                     cfg_in_progress <= '1';
                     tx_data_cnt <= cfg_data_cnt;    -- countdown des données à envoyer
                     rx_start <= '1';     -- active la fsm de RX
                     prog_fsm <= wait_cfg_data_st;
                  -- demande de programmation de exp
                  elsif exp_rqst = '1' then
                     exp_in_progress <= '1';
                     tx_data_cnt <= exp_reg_ary'length;    -- countdown des données à envoyer
                     --rx_start <= '1';     -- n'active pas la fsm de RX
                     prog_fsm <= wait_exp_data_st;
                  end if;
               
               -- attendre la donnée de cfg qui vient de la ram
               when wait_cfg_data_st =>
                  rx_start <= '0';
                  tx_data_i <= RAM_RD_DATA;
                  if RAM_RD_DVAL = '1' then
                     tx_dval_i <= '1';       -- reste à 1 tant que la donnée n'a pas été prise par le driver
                     prog_fsm <= transmit_data_st;
                  end if;
               
               -- attendre la donnée de exp
               when wait_exp_data_st =>
                  --rx_start <= '0';
                  tx_data_i <= std_logic_vector(exp_reg_ary(tx_data_cnt).addr & exp_reg_ary(tx_data_cnt).data);
                  tx_dval_i <= '1';       -- reste à 1 tant que la donnée n'a pas été prise par le driver
                  prog_fsm <= transmit_data_st;
               
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
                     tx_data_cnt <= C_NB_EXTRA_DATA;    -- countdown des données d'extra à envoyer
                     prog_fsm <= transmit_extra_data_st;
                  else
                     -- on vérifie si la demande courante est une programmation de cfg, sinon c'est nécessairement une programmation de exp
                     if cfg_in_progress = '1' then
                        prog_fsm <= wait_cfg_data_st;
                     else
                        prog_fsm <= wait_exp_data_st;
                     end if;
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
   U8 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            feedback_fsm <= idle;
            ram_wr_en_i <= '0';
            roic_rx_nb_data_i <= (others => '0');
         else 
            
            -- on efface la réponse reçue pour s'assurer qu'il n'y a pas de mismatch dans les requêtes
            if reset_roic_rx_data_sync = '1' then
               roic_rx_nb_data_i <= (others => '0');
            end if;
            
            case feedback_fsm is
               
               -- on attend le début du message
               when idle =>
                  ram_wr_add_i <= to_unsigned(C_RX_RAM_BASE_ADDR, ram_wr_add_i'length);
                  ram_wr_en_i <= '0';
                  rx_data_cnt <= 0;             -- on reset le compteur pour les données d'extra reçues
                  if rx_start = '1' then
                     total_rx_data_cnt <= tx_data_cnt;         -- TX et RX ont le même nombre de données
                     feedback_fsm <= skip_data_st;
                  end if;
               
               -- on ignore les premières données puisque le RX est en retard sur le TX
               when skip_data_st =>
                  -- on vérifie que toutes les données d'extra ont été reçues
                  if rx_data_cnt = C_NB_EXTRA_DATA then
                     rx_data_cnt <= 0;             -- on reset le compteur pour les données reçues
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
                     roic_rx_nb_data_i <= to_unsigned(rx_data_cnt, roic_rx_nb_data_i'length);  -- on retourne le nombre de données reçues
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
