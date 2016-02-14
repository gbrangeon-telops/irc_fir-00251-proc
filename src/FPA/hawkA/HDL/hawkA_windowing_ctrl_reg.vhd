-------------------------------------------------------------------------------
--
-- Title       : hawkA_windowing_ctrl_reg
-- Design      : hawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\Hawk\src\hawkA_windowing_ctrl_reg.vhd
-- Generated   : Mon Dec 20 13:46:24 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-- WCR(0) : MCKEN        (memory Clock Enable)
-- WCR(1) : PRESET       (set low)
-- WCR(2) : CCTL0        column resize or nudging operation
-- WCR(3) : CCTL1        column resize or nudging operation 
-- WCR(4) : CCKEN        Column Clock Enable
-- WCR(5) : RCTL0        Row resize or nudging operation
-- WCR(6) : RCTL1        Row resize or nudging operation 
-- WCR(7) : RCKEN        Row Clock Enable



--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity hawkA_windowing_ctrl_reg is
   port(
      ARESET       : in std_logic;
      CLK          : in std_logic;
      FPA_INTF_CFG : in fpa_intf_cfg_type;
      TX_MISO      : in t_ll_ext_miso;
      TX_MOSI      : out t_ll_ext_mosi8;
      TX_DREM      : out std_logic_vector(3 downto 0);
      ERR          : out std_logic
      );
end hawkA_windowing_ctrl_reg;

architecture RTL of hawkA_windowing_ctrl_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type   wcr_fsm_type is (idle, rqst_and_send);
   signal wcr_fsm             : wcr_fsm_type;  
   signal tx_mosi_i           : t_ll_ext_mosi8;
   signal sreset              : std_logic;
   signal wcr_reg             : std_logic_vector(7 downto 0);
   signal wcr_reg_last        : std_logic_vector(7 downto 0);
   
begin  
   
   --------------------------------------------------
   -- map
   -------------------------------------------------- 
   TX_MOSI.SOF  <= tx_mosi_i.sof;      
   TX_MOSI.EOF  <= tx_mosi_i.eof;
   TX_MOSI.DVAL <= tx_mosi_i.dval; 
   TX_MOSI.DATA <= tx_mosi_i.data;
   TX_DREM <= "1000";             -- ce registre comporte 8 bits
   TX_MOSI.SUPPORT_BUSY <= tx_mosi_i.support_busy;
   ERR <= '0';
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   --------------------------------------------------
   -- batir le Registre WCR
   -------------------------------------------------- 
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         wcr_reg(0) <= '0';       -- MCKEN    
         wcr_reg(1) <= '0';       -- PRESET   
         wcr_reg(2) <= '0';       -- CCTL0   
         wcr_reg(3) <= '0';       -- CCTL1    
         wcr_reg(4) <= '0';       -- CCKEN    
         wcr_reg(5) <= '0';       -- RCTL0    
         wcr_reg(6) <= '0';       -- RCTL1    
         wcr_reg(7) <= '0';       -- RCKEN    
      end if;      
   end process;
   
   
   --------------------------------------------------
   -- envoyer le Registre WCR
   --------------------------------------------------  
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            wcr_reg_last <= not wcr_reg;   -- pour forcer l'ecriture de wcr_reg =  0x00
            wcr_fsm <= idle;
            tx_mosi_i.dval <= '0'; 
            tx_mosi_i.support_busy <= '1'; 
         else
            
            case wcr_fsm is 
               
               when idle => 
                  tx_mosi_i.dval <= '0';
                  if  wcr_reg_last /= wcr_reg then 
                     tx_mosi_i.data <= wcr_reg;
                     wcr_fsm <= rqst_and_send;
                  end if;
               
               when rqst_and_send => 
                  tx_mosi_i.dval <= '1';          -- demande d'envoi, meme si le downstream_busy est à '1'
                  tx_mosi_i.sof <= '1';
                  tx_mosi_i.eof <= '1';
                  if TX_MISO.BUSY = '0' then     -- 
                     wcr_fsm <= idle; 
                     wcr_reg_last <= tx_mosi_i.data;
                     tx_mosi_i.dval <= '0';
                  end if;                              
               
               when others =>          
               
            end case;        
            
         end if;
      end if;      
   end process;    
   
end RTL;
