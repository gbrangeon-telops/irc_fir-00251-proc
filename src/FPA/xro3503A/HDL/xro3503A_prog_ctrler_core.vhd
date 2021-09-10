------------------------------------------------------------------
--!   @file : xro3503A_prog_ctrler_core
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
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity xro3503A_prog_ctrler_core is
   port(
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      -- config
      USER_CFG         : in fpa_intf_cfg_type;
      
      -- io détecteur
      ROIC_RESETN      : out std_logic;
      
      -- interfaçage avec le contrôleur principal
      PROG_EN          : in std_logic;
      PROG_RQST        : out std_logic;
      PROG_DONE        : out std_logic; 
      
      -- sortie vers spi
      SPI_DATA         : out std_logic_vector(15 downto 0);
      SPI_EN           : out std_logic;
      SPI_DONE         : in std_logic
      );
end xro3503A_prog_ctrler_core;

architecture rtl of xro3503A_prog_ctrler_core is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   constant C_ROIC_RESET_DURATION_FACTOR  : positive := integer(ceil(real(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ) / 1000.0));   -- 1µs de reset. Reset tenu pendant le plus grand de 6 MCLK ou 1µs.
   constant C_PRE_ROIC_RESET_WAIT_FACTOR  : positive := 6 * DEFINE_FPA_MCLK_RATE_FACTOR;     -- min 6 MCLK
   constant C_POST_ROIC_RESET_WAIT_FACTOR : positive := 6 * DEFINE_FPA_MCLK_RATE_FACTOR;     -- min 6 MCLK
   
   constant WIND1_ROW_START_HEADER_REG : std_logic_vector(7 downto 0) := '1' & '0' & b"00_0001";   -- Write Enabled / Read Disabled / Window1 Row Start Address
   constant WIND1_ROW_STOP_HEADER_REG  : std_logic_vector(7 downto 0) := '1' & '0' & b"00_0010";   -- Write Enabled / Read Disabled / Window1 Row Stop Address
   constant WIND1_COL_START_HEADER_REG : std_logic_vector(7 downto 0) := '1' & '0' & b"00_0011";   -- Write Enabled / Read Disabled / Window1 Column Start Address
   constant WIND1_COL_STOP_HEADER_REG  : std_logic_vector(7 downto 0) := '1' & '0' & b"00_0100";   -- Write Enabled / Read Disabled / Window1 Column Stop Address
   constant PIXEL_MODE_HEADER_REG      : std_logic_vector(7 downto 0) := '1' & '0' & b"01_0001";   -- Write Enabled / Read Disabled / Pixel Mode Address
   constant READOUT_MODE_HEADER_REG    : std_logic_vector(7 downto 0) := '1' & '0' & b"01_0010";   -- Write Enabled / Read Disabled / Readout Mode Address
   
   constant NUM_REGS : integer := 6;
   
   type reg_array_type is array (1 to NUM_REGS) of std_logic_vector(7 downto 0);
   signal header_reg_ary : reg_array_type := (WIND1_ROW_START_HEADER_REG, WIND1_ROW_STOP_HEADER_REG, WIND1_COL_START_HEADER_REG, 
                                              WIND1_COL_STOP_HEADER_REG, PIXEL_MODE_HEADER_REG, READOUT_MODE_HEADER_REG);
   signal data_reg_ary   : reg_array_type;
   signal reg_idx        : integer range 1 to NUM_REGS;
   
   type   prog_fsm_type is (idle, forward_rqst_st, wait_pre_reset_st, reset_roic_st, wait_post_reset_st, prog_st, wait_prog_end_st, pause_st, check_end_st);
   signal prog_fsm                  : prog_fsm_type;
   signal sreset                    : std_logic;
   signal pause_cnt                 : unsigned(7 downto 0);
   signal prog_rqst_i               : std_logic;
   signal prog_done_i               : std_logic;
   signal spi_en_i                  : std_logic;
   signal spi_data_i                : std_logic_vector(SPI_DATA'length-1 downto 0);
   signal first_prog_done           : std_logic;
   signal roic_resetn_i             : std_logic;
   signal new_cfg_num               : unsigned(USER_CFG.CFG_NUM'length-1 downto 0);
   signal present_cfg_num           : unsigned(USER_CFG.CFG_NUM'length-1 downto 0);
   signal new_cfg_num_pending       : std_logic;
   
begin
   
   PROG_RQST <= prog_rqst_i;
   PROG_DONE <= prog_done_i;
   
   SPI_DATA <= spi_data_i;
   SPI_EN <= spi_en_i;
   
   ROIC_RESETN <= roic_resetn_i;
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   --------------------------------------------------
   --  cfg_num
   --------------------------------------------------
   -- ENO: 26 nov 2018: Pour eviter bugs , reprogrammer le ROIC, dès qu'une config est reçue du MB.
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         -- nouvelle config lorsque cfg_num change
         new_cfg_num <= USER_CFG.CFG_NUM;    
         
         -- detection du changement
         if present_cfg_num /= new_cfg_num then
            new_cfg_num_pending <= '1';
         else
            new_cfg_num_pending <= '0';
         end if;         
         
      end if;
   end process;       
   
   --------------------------------------------------
   --  data reg builder
   --------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then
         -- Window1 Row Start Data Register
         data_reg_ary(1) <= std_logic_vector(USER_CFG.YSTART);
         -- Window1 Row Stop Data Register
         data_reg_ary(2) <= std_logic_vector(USER_CFG.YSTOP);
         -- Window1 Column Start Data Register
         data_reg_ary(3) <= std_logic_vector(USER_CFG.XSTART);
         -- Window1 Column Stop Data Register
         data_reg_ary(4) <= std_logic_vector(USER_CFG.XSTOP);
         -- Pixel Mode Data Register
         data_reg_ary(5)(7)          <= '0';  -- Integration control from FSYNC. La spec dit de le mettre à 1 mais c'est une erreur
         data_reg_ary(5)(6)          <= '0';  -- Reserved
         data_reg_ary(5)(5)          <= '0';  -- Reserved
         data_reg_ary(5)(4)          <= USER_CFG.GAIN;
         data_reg_ary(5)(3 downto 0) <= USER_CFG.CTIA_BIAS_CURRENT;
         -- Readout Mode Data Register
         data_reg_ary(6)(7)          <= '0';  -- Reserved
         data_reg_ary(6)(6)          <= '0';  -- Reserved
         data_reg_ary(6)(5)          <= '0';  -- 16 Outputs
         data_reg_ary(6)(4)          <= USER_CFG.READ_DIR_LEFT;
         data_reg_ary(6)(3)          <= USER_CFG.READ_DIR_DOWN;
         data_reg_ary(6)(2)          <= USER_CFG.SUB_WINDOW_MODE;
         data_reg_ary(6)(1 downto 0) <= "00"; -- 1 Window
      end if;
   end process;
   
   
   ------------------------------------------------
   -- Voir s'il faut programmer le détecteur
   ------------------------------------------------
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            prog_fsm <= idle;
            prog_done_i <= '0';
            prog_rqst_i <= '0';
            spi_en_i <= '0';
            first_prog_done <= '0';
            roic_resetn_i <= '1';   -- not in reset by default: power-up reset sequence managed in digio_map module
            present_cfg_num <= not new_cfg_num;
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings	
            case prog_fsm is            
               
               -- attente d'une demande
               when idle =>      
                  prog_done_i <= '1';                    
                  prog_rqst_i <= '0';
                  reg_idx <= 1;
                  if new_cfg_num_pending = '1' and SPI_DONE = '1' then
                     present_cfg_num <= new_cfg_num;  -- mis à jour le plus tôt possible pour qu'un changement de cfg pendant une prog déclenche une 2e prog
                     prog_fsm <= forward_rqst_st;
                  end if;
                  
               -- demande envoyée au contrôleur principal
               when forward_rqst_st =>
                  prog_rqst_i <= '1';                                
                  if PROG_EN = '1' then
                     prog_done_i <= '0';
					 prog_rqst_i <= '0';
                     if first_prog_done = '0' then
                        pause_cnt <= (others => '0');
                        prog_fsm <= wait_pre_reset_st;
                     else
                        prog_fsm <= prog_st;
                     end if;
                  end if;
               
               -- attente avant que le reset soit désactivé
               when wait_pre_reset_st =>
                  roic_resetn_i <= '1';      -- deactivate reset
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt >= C_PRE_ROIC_RESET_WAIT_FACTOR then
                     pause_cnt <= (others => '0');
                     prog_fsm <= reset_roic_st;
                  end if;
                  
               -- attente pendant que le reset est activé
               when reset_roic_st =>
                  roic_resetn_i <= '0';      -- activate reset
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt >= C_ROIC_RESET_DURATION_FACTOR then
                     pause_cnt <= (others => '0');
                     prog_fsm <= wait_post_reset_st;
                  end if;
               
               -- attente après que le reset soit désactivé
               when wait_post_reset_st =>
                  roic_resetn_i <= '1';      -- deactivate reset
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt >= C_POST_ROIC_RESET_WAIT_FACTOR then
                     prog_fsm <= prog_st;
                  end if;               
                  
               -- accès accordé au programmeur du détecteur
               when prog_st =>
                  spi_data_i <= header_reg_ary(reg_idx) & data_reg_ary(reg_idx);
                  spi_en_i <= '1';
                  if SPI_DONE = '0' then
                     prog_fsm <= wait_prog_end_st;
                  end if; 
                  
               -- attente de la fin de transaction pour le programmeur du détecteur
               when wait_prog_end_st =>
                  spi_en_i <= '0';
                  if SPI_DONE = '1' then
                     pause_cnt <= (others => '0');
                     prog_fsm <= pause_st;
                  end if;   
                  
               -- on fait une pause entre 2 registres ou à la fin
               when pause_st =>
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt >= C_POST_ROIC_RESET_WAIT_FACTOR then   -- le délai entre 2 commandes n'est pas spécifié par le fabricant
                     prog_fsm <= check_end_st;
                  end if;
               
               -- vérifier si la programmation est terminée
               when check_end_st => 
                  if reg_idx = NUM_REGS then
                     first_prog_done <= '1';
                     prog_fsm <= idle;
                  else
                     reg_idx <= reg_idx + 1;
                     prog_fsm <= prog_st;
                  end if;                  
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   
end rtl;
