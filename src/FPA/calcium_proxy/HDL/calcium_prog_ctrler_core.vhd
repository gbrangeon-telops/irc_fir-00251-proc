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
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      -- config
      USER_CFG         : in fpa_intf_cfg_type;
      
      -- interfaçage avec le contrôleur principal
      PROG_EN          : in std_logic;
      PROG_RQST        : out std_logic;
      PROG_DONE        : out std_logic;
      ROIC_INIT_DONE   : out std_logic;
      
      -- interface TX
      TX_DVAL     : out std_logic;
      TX_DATA     : out std_logic_vector(15 downto 0);
      TX_TLAST    : out std_logic;
      TX_DONE     : in std_logic;
      
      -- interface RX
      RX_DVAL     : in std_logic;
      RX_DATA     : in std_logic_vector(15 downto 0)
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
   
   constant C_END_OF_TRANSMISSION_WAIT_FACTOR  : positive := 16 * DEFINE_FPA_PROG_SCLK_RATE_FACTOR;   -- Must wait 16 SCLK before allowing a new transmission
   constant C_END_OF_TRANSMISSION_WAIT_NB_BITS  : positive := log2(C_END_OF_TRANSMISSION_WAIT_FACTOR)+1;
   
   type prog_fsm_type is (idle, forward_rqst_st, prog_st, wait_prog_end_st, check_end_st, pause_st);
   
   signal prog_fsm                  : prog_fsm_type;
   signal sreset                    : std_logic;
   signal pause_cnt                 : unsigned(C_END_OF_TRANSMISSION_WAIT_NB_BITS-1 downto 0);
   signal prog_rqst_i               : std_logic;
   signal prog_done_i               : std_logic;
   signal roic_init_done_i          : std_logic;
   signal tx_dval_i                 : std_logic;
   signal tx_data_i                 : std_logic_vector(TX_DATA'length-1 downto 0);
   signal cfg_num_gray              : std_logic_vector(USER_CFG.CFG_NUM'length-1 downto 0);
   signal cfg_num_i                 : std_logic_vector(USER_CFG.CFG_NUM'length-1 downto 0);
   signal new_cfg_num               : unsigned(USER_CFG.CFG_NUM'length-1 downto 0);
   signal present_cfg_num           : unsigned(USER_CFG.CFG_NUM'length-1 downto 0);
   signal new_cfg_num_pending       : std_logic;
   
   constant NUM_REGS : integer := 6;
   signal reg_idx : integer range 1 to NUM_REGS;
   
begin

   -- Output mapping
   PROG_RQST <= prog_rqst_i;
   PROG_DONE <= prog_done_i;
   ROIC_INIT_DONE <= roic_init_done_i;
   TX_DATA <= tx_data_i;
   TX_DVAL <= tx_dval_i;
   
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
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings
            case prog_fsm is
               
               -- attente d'une demande
               when idle =>      
                  prog_done_i <= '1';
                  prog_rqst_i <= '0';
                  reg_idx <= 1;
                  if new_cfg_num_pending = '1' and TX_DONE = '1' then
                     present_cfg_num <= new_cfg_num;  -- mis à jour le plus tôt possible pour qu'un changement de cfg pendant une prog déclenche une 2e prog
                     prog_fsm <= forward_rqst_st;
                  end if;
                  
               -- demande envoyée au contrôleur principal
               when forward_rqst_st =>
                  prog_rqst_i <= '1';
                  if PROG_EN = '1' then
                     prog_done_i <= '0';
                     prog_rqst_i <= '0';
                     prog_fsm <= prog_st;
                  end if;
                  
               -- accès accordé au programmeur du détecteur
               when prog_st =>
                  tx_data_i <= std_logic_vector(to_unsigned(reg_idx, tx_data_i'length/2) & to_unsigned(reg_idx, tx_data_i'length/2));
                  tx_dval_i <= '1';
                  if TX_DONE = '0' then
                     prog_fsm <= wait_prog_end_st;
                  end if; 
                  
               -- attente de la fin de transaction pour le programmeur du détecteur
               when wait_prog_end_st =>
                  tx_dval_i <= '0';
                  if TX_DONE = '1' then
                     prog_fsm <= check_end_st;
                  end if;
               
               -- vérifier si la programmation est terminée
               when check_end_st => 
                  if reg_idx = NUM_REGS then
                     pause_cnt <= (others => '0');
                     prog_fsm <= pause_st;
                  else
                     reg_idx <= reg_idx + 1;
                     prog_fsm <= prog_st;
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
   
   
end rtl;
