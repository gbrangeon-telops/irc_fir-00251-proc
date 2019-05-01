-------------------------------------------------------------------------------
--
-- Title       : dig_ctrl_reg
-- Design      : hawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\Hawk\src\hawkA_dig_data_reg.vhd
-- Generated   : Mon Dec 20 13:46:24 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-- DDR 



--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.FPA_define.all;


entity hawkA_dig_data_reg is
   port(
      ARESET       : in std_logic;
      CLK          : in std_logic;
      USER_CFG     : in fpa_intf_cfg_type;
      TX_MISO      : in t_ll_ext_miso;
      TX_MOSI      : out t_ll_ext_mosi8;
      TX_DREM      : out std_logic_vector(3 downto 0);
      ERR          : out std_logic
      );
end hawkA_dig_data_reg;

architecture RTL of hawkA_dig_data_reg is
   constant REG_BYTE_NUM : integer := 2;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type  ddr_fsm_type is (idle, pause_st1, pause_st2, rqst_and_send);
   type  ddr_reg_type is array (1 to 2) of std_logic_vector(7 downto 0);
   signal ddr_fsm             : ddr_fsm_type;  
   signal tx_mosi_i           : t_ll_ext_mosi8;
   signal sreset              : std_logic;
   signal ddr_reg             : ddr_reg_type;
   signal ddr_reg_last        : std_logic_vector(15 downto 0); 
   signal err_i               : std_logic;
   signal byte_cnt            : integer range 1 to 3;
   
begin  
   
   --------------------------------------------------
   -- map
   -------------------------------------------------- 
   TX_MOSI.SOF  <= tx_mosi_i.sof;
   TX_MOSI.EOF  <= tx_mosi_i.eof;            
   TX_MOSI.DVAL <= tx_mosi_i.dval; 
   TX_MOSI.DATA <= tx_mosi_i.data;
   TX_DREM <= "1000";             -- la taille de ce registre est un multiple de 8 bits
   TX_MOSI.SUPPORT_BUSY <= tx_mosi_i.support_busy;
   ERR <= '0';
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   --------------------------------------------------
   -- batir le Registre DDR
   -------------------------------------------------- 
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            err_i <= '0'; 
         else 
            --valeur de dig lors des tests du fabricant = x"0138" pour HAWK_MW et x"0116" pour HAWK_LW  
            ddr_reg(1) <= std_logic_vector(USER_CFG.DIG_CODE(15 downto 8));--x"01";   -- (15 dwonto 8)->MSB 
            ddr_reg(2) <= std_logic_vector(USER_CFG.DIG_CODE(7 downto 0)); --x"38";   -- (7 dwonto 0) 
            if unsigned(ddr_reg(1)(7 downto 1)) /= 0 then  --erreur defini dans le manuel de l'usager de Hawk
               err_i <= '1';
            end if;
         end if;
      end if;      
   end process;
   
   
   --------------------------------------------------
   -- envoyer le Registre DDR
   --------------------------------------------------  
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            ddr_reg_last <= not (ddr_reg(1)&ddr_reg(2));   -- pour forcer l'ecriture de ddr_reg =  0x00
            ddr_fsm <= pause_st1;
            tx_mosi_i.dval <= '0'; 
            tx_mosi_i.support_busy <= '1';
            byte_cnt  <= 1;
            
         else
            
            case ddr_fsm is
               
               when pause_st1 =>           -- en revenant de sreset, permet de donner du temps pour le batisseur de registre MCR
                  ddr_fsm <= pause_st2; 
               
               when pause_st2 =>           -- permet de donner du temps pour le batisseur de registre MCR
                  ddr_fsm <= idle;
               
               when idle => 
                  tx_mosi_i.dval <= '0';
                  byte_cnt  <= 1;
                  if  ddr_reg_last /= (ddr_reg(1) & ddr_reg(2)) then 
                     tx_mosi_i.data <= ddr_reg(byte_cnt);
                     ddr_fsm <= rqst_and_send;
                  end if;
               
               when rqst_and_send => 
                  tx_mosi_i.dval <= '1';          -- demande d'envoi, meme si le downstream_busy est à '1'
                  
                  -- sof
                  if byte_cnt = 1 then
                     tx_mosi_i.sof <= '1';
                  else
                     tx_mosi_i.sof <= '0';
                  end if;                 
                  
                  -- eof
                  if byte_cnt = REG_BYTE_NUM then
                     tx_mosi_i.eof <= '1';
                  else
                     tx_mosi_i.eof <= '0';
                  end if;  
                  
                  -- data                  
                  tx_mosi_i.data <=  ddr_reg(byte_cnt); 
                  
                  --  l'envoi se poursuit tant que le downstream n'est pas busy
                  if TX_MISO.BUSY = '0' then     -- 
                     byte_cnt <= byte_cnt + 1;
                     ddr_reg_last <= (ddr_reg(1) & ddr_reg(2));
                     if byte_cnt = REG_BYTE_NUM then 
                        ddr_fsm <= idle;
                     end if;
                  end if;                              
               
               when others =>          
               
            end case;        
            
         end if;
      end if;      
   end process;    
   
end RTL;
