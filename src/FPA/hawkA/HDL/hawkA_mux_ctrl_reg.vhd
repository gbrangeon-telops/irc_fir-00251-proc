-------------------------------------------------------------------------------
--
-- Title       : hawkA_mux_ctrl_reg
-- Design      : hawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\Hawk\src\hawkA_mux_ctrl_reg.vhd
-- Generated   : Mon Dec 20 13:46:24 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-- MCR(7) : CBIT_EN
-- MCR(6) : reserved       (set low)
-- MCR(5) : CAPSEL2        (choisit puits d'integration)
-- MCR(4) : CAPSEL1        (choisit puits d'integration)  
-- MCR(3) : MRS            (Memory reset) 
-- MCR(2) : FRAMESIZE      (0 --> Ymax = 480,  1--> Ymax = 512)
-- MCR(1) : REVERT         
-- MCR(0) : INVERT



--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity hawkA_mux_ctrl_reg is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      USER_CFG      : in fpa_intf_cfg_type;
      TX_MISO       : in t_ll_ext_miso;
      TX_MOSI       : out t_ll_ext_mosi8;
      TX_DREM       : out std_logic_vector(3 downto 0); 
      WINDOW_CHANGE : in std_logic;
      ERR           : out std_logic
      );
end hawkA_mux_ctrl_reg;

architecture RTL of hawkA_mux_ctrl_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type mcr_fsm_type is (idle, pause_st1, pause_st2, pause_st3, pause_st4, rqst_and_send);
   signal mcr_fsm             : mcr_fsm_type;  
   signal tx_mosi_i           : t_ll_ext_mosi8;
   signal sreset              : std_logic;
   signal mcr_reg             : std_logic_vector(7 downto 0) := (others => '0');
   signal mcr_reg_last        : std_logic_vector(7 downto 0);
   signal window_change_last  : std_logic;
   signal MRS_clear           : std_logic;
   signal MRS_latch           : std_logic;
   
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
   -- batir le Registre MCR
   -------------------------------------------------- 
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            window_change_last <= '0';            
         else                                   
            
            window_change_last <= WINDOW_CHANGE;         
            
            mcr_reg(0) <= USER_CFG.INVERT;    -- invert  ligne 1 to 512 OU ligne 512 to 1        
            mcr_reg(1) <= USER_CFG.REVERT;    -- revert  colonne 1 to 640 OU colonne 640 to 1 
            
            if YSIZE_MAX  = 512 then                      -- frame Ysize
               mcr_reg(2) <= '1'; 
            else
               mcr_reg(2) <= '0';
            end if;
            
            if WINDOW_CHANGE = '1' and window_change_last = '0' then 
               mcr_reg(3) <= '1';                            -- MRS
            elsif MRS_clear = '1' then 
               mcr_reg(3) <= '0';   
            end if; 
            
            mcr_reg(4) <= USER_CFG.GAIN(0);       -- LSB gain
            mcr_reg(5) <= USER_CFG.GAIN(1);       -- MSB gain
            mcr_reg(6) <= '0';                            -- reserved (set low)
            mcr_reg(7) <= USER_CFG.CBIT_EN;       -- CBIT (enabled pour l'instant)  
            
         end if;  
      end if;
   end process;
   
   
   --------------------------------------------------
   -- envoyer le Registre MCR
   --------------------------------------------------  
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            mcr_reg_last <= (others => '0');      -- permet d'envoyer la config par defaut se trouvant sur USER_CFG
            mcr_fsm <= idle;
            tx_mosi_i.dval <= '0'; 
            tx_mosi_i.support_busy <= '1'; 
            MRS_clear <= '0';
         else
            
            case mcr_fsm is 
               
               --when pause_st1 =>           -- en revenant de sreset, permet de donner du temps pour le batisseur de registre MCR
--                  mcr_fsm <= pause_st2; 
--               
--               when pause_st2 =>           -- permet de donner du temps pour le batisseur de registre MCR
--                  mcr_fsm <= pause_st3;
--               
--               when pause_st3 =>           -- permet de donner du temps pour le batisseur de registre MCR
--                  mcr_fsm <= pause_st4;
--               
--               when pause_st4 =>           -- permet de donner du temps pour le batisseur de registre MCR
--                  mcr_fsm <= idle;
               
               when idle => 
                  tx_mosi_i.dval <= '0';
                  MRS_clear <= '0';
                  if  mcr_reg_last /= mcr_reg then 
                     tx_mosi_i.data <= mcr_reg;
                     MRS_latch <= mcr_reg(3);    -- on retient l'etat de MRS
                     mcr_fsm <= rqst_and_send;
                  end if;
               
               when rqst_and_send => 
                  tx_mosi_i.dval <= '1';         -- demande d'envoi, meme si le downstream_busy est à '1'
                  tx_mosi_i.sof <= '1';           
                  tx_mosi_i.eof <= '1';
                  if TX_MISO.BUSY = '0' then     -- 
                     mcr_fsm <= idle;
                     tx_mosi_i.dval <= '0';
                     MRS_clear <= MRS_latch;     -- ceci assure que MRS revient à '0' après qu'il soit effectivement envoyé à '1' 
                     mcr_reg_last <= tx_mosi_i.data;
                  end if;                              
               
               when others =>          
               
            end case;        
            
         end if;
      end if;      
   end process;    
   
end RTL;
