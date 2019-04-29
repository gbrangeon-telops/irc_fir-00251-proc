-------------------------------------------------------------------------------
--
-- Title       : suphawkA_wdw_data_reg
-- Design      : suphawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\suphawk\src\suphawkA_wdw_data_reg.vhd
-- Generated   : Mon Dec 20 13:46:24 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.FPA_define.all;


entity suphawkA_wdw_data_reg is
   port(
      ARESET         : in std_logic;
      CLK            : in std_logic;
      USER_CFG       : in fpa_intf_cfg_type;
      TX_MISO        : in t_ll_ext_miso;
      TX_MOSI        : out t_ll_ext_mosi8;
      TX_DREM        : out std_logic_vector(3 downto 0);
      ACTIVE_SUBWDW  : out std_logic;
      ERR            : out std_logic
      );
end suphawkA_wdw_data_reg;

architecture RTL of suphawkA_wdw_data_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type wdr_fsm_type is (idle, pause_st1, pause_st2, pause_st3, pause_st4, rqst_and_send);
   signal wdr_fsm             : wdr_fsm_type;  
   signal tx_mosi_i           : t_ll_ext_mosi8;
   signal sreset              : std_logic;
   signal wdr_reg             : std_logic_vector(39 downto 0) := (others => '0');
   signal wdr_reg_last        : std_logic_vector(wdr_reg'length-1 downto 0);
   signal byte_cnt            : integer range 0 to 5;
   signal high_idx            : integer range 0 to 39;
   signal low_idx             : integer range 0 to 39;
   signal active_subwindow_i  : std_logic;
   
begin  
   
   --------------------------------------------------
   -- map
   -------------------------------------------------- 
   TX_MOSI.SOF   <= tx_mosi_i.sof; 
   TX_MOSI.EOF   <= tx_mosi_i.eof;
   TX_MOSI.DVAL  <= tx_mosi_i.dval; 
   TX_MOSI.DATA  <= tx_mosi_i.data;
   TX_DREM <= "1000";             -- ce registre comporte 8 bits
   TX_MOSI.SUPPORT_BUSY <= tx_mosi_i.support_busy;
   ACTIVE_SUBWDW <= active_subwindow_i;   
   ERR <= '0';
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   --------------------------------------------------
   -- building wdr register
   -------------------------------------------------- 
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         wdr_reg(39 downto 29) <= std_logic_vector(USER_CFG.ROWSTOP);    
         wdr_reg(28 downto 18) <= std_logic_vector(USER_CFG.ROWSTART); 
         wdr_reg(17 downto 9)  <= std_logic_vector(USER_CFG.COLSTOP); 
         wdr_reg(8 downto 0)   <= std_logic_vector(USER_CFG.COLSTART); 
      end if;
   end process;
   
   
   --------------------------------------------------
   -- sending wdr register
   --------------------------------------------------  
    U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            wdr_reg_last(8 downto 0) <= (others => '1'); --
            wdr_fsm <= pause_st1;
            tx_mosi_i.dval <= '0'; 
            tx_mosi_i.support_busy <= '1';
            
         else
            
            case wdr_fsm is
               
               when pause_st1 =>           -- en revenant de sreset, permet de donner du temps pour le batisseur de registre MCR
                  wdr_fsm <= pause_st2; 
               
               when pause_st2 =>           -- permet de donner du temps pour le batisseur de registre MCR
                  wdr_fsm <= idle;
               
               when idle => 
                  tx_mosi_i.dval <= '0';
                  byte_cnt  <= 5;
                  high_idx <= 39;
                  low_idx <= 32;
                  if  wdr_reg_last /= wdr_reg then 
                     tx_mosi_i.data <= wdr_reg(39 downto 32);
                     wdr_fsm <= rqst_and_send;
                  end if;
               
               when rqst_and_send => 
                  tx_mosi_i.dval <= '1';          -- demande d'envoi, meme si le downstream_busy est à '1'
                  active_subwindow_i <= USER_CFG.ACTIVE_SUBWINDOW;
                  -- sof
                  if byte_cnt = 5 then
                     tx_mosi_i.sof <= '1';
                  else
                     tx_mosi_i.sof <= '0';
                  end if;                 
                  
                  -- eof
                  if byte_cnt = 1 then
                     tx_mosi_i.eof <= '1';
                  else
                     tx_mosi_i.eof <= '0';
                  end if;  
                  
                  -- data                  
                  tx_mosi_i.data <=  wdr_reg((8*byte_cnt - 1) downto (8*byte_cnt - 8)); 
                  
                  --  l'envoi se poursuit tant que le downstream n'est pas busy
                  if TX_MISO.BUSY = '0' then     -- 
                     byte_cnt <= byte_cnt - 1;
                     --high_idx <= 8*byte_cnt - 9;
                     --low_idx <= 8*byte_cnt - 16;             
                     wdr_reg_last <= wdr_reg;
                     if byte_cnt = 1 then 
                        wdr_fsm <= idle;
                     end if;
                  end if;                              
               
               when others =>          
               
            end case;        
            
         end if;
      end if;      
   end process;    
   
end RTL;
