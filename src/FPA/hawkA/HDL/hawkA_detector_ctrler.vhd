-------------------------------------------------------------------------------
--
-- Title       : hawkA_detector_ctrler
-- Design      : hawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\Hawk\src\hawkA_detector_ctrler.vhd
-- Generated   : Fri Feb 18 15:34:40 2011
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
use work.FPA_define.all;
use work.fpa_common_pkg.all;

entity hawkA_detector_ctrler is
   port(
      
      -- signaux generaux
      CLK           : in std_logic;
      ARESET        : in std_logic;
      USER_CFG      : in fpa_intf_cfg_type;
      
      -- entrée pour MCR
      MCR_ERR       : in std_logic;      
      MCR_MOSI      : in t_ll_ext_mosi8;
      MCR_MISO      : out t_ll_ext_miso;
      MCR_DREM      : in std_logic_vector(3 downto 0);
      
      -- entrée pour WCR
      WCR_ERR       : in std_logic;
      WCR_MOSI      : in t_ll_ext_mosi8;
      WCR_MISO      : out t_ll_ext_miso;
      WCR_DREM      : in std_logic_vector(3 downto 0);
      
      -- entrée pour DDR
      DDR_ERR       : in std_logic;      
      DDR_MOSI      : in t_ll_ext_mosi8;
      DDR_MISO      : out t_ll_ext_miso;
      DDR_DREM      : in std_logic_vector(3 downto 0);
      
      -- entrée pour WDR
      WDR_ERR       : in std_logic;      
      WDR_MOSI      : in t_ll_ext_mosi8;
      WDR_MISO      : out t_ll_ext_miso;
      WDR_FIFO_EMPTY: in std_logic; -- requis car le ffo LL8 ne reagit pas comme un fifo fwft
      WDR_DREM      : in std_logic_vector(3 downto 0);
      
      -- lien avec le module SPI 
      TX_MOSI       : out t_ll_ext_mosi8;
      TX_MISO       : in t_ll_ext_miso;
      TX_DREM       : out std_logic_vector(3 downto 0);
      SPI_DONE      : in std_logic;  
      
      --contrôle
      EN            : in std_logic;
      DONE          : out std_logic;
      RQST          : out std_logic;
      
      -- debug purpose
      REGISTER_EN   : out std_logic_vector(2 downto 0)
      
      );
end hawkA_detector_ctrler;


architecture RTL of hawkA_detector_ctrler is
   
   -- definition des adresses du mux
   constant NONE : std_logic_vector(2 downto 0) := "000";
   constant DCR  : std_logic_vector(2 downto 0) := "001";
   constant MCR  : std_logic_vector(2 downto 0) := "010";
   constant WCR  : std_logic_vector(2 downto 0) := "011";
   constant DDR  : std_logic_vector(2 downto 0) := "100";
   constant WDR  : std_logic_vector(2 downto 0) := "101";
   
   -- definition du delay de redescente de NSC
   constant HAWK_TNH_DLY : integer :=  40; -- 500 ns après remontée de NCS (le manuel demande 100ns min pour la valeur de tNH)
   
   -- sync_reset
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   -- double_sync_vector
   component double_sync_vector
	  port(
	 	 D : in STD_LOGIC_vector;
		 Q : out STD_LOGIC_vector;
		 CLK : in STD_LOGIC
         );
   end component;
   
   type dcr_fsm_type is (idle, check_st, first_dcr_wr, wait_first_dcr_wr_end, first_tnh_dly, reg_wr_st, second_dcr_wr, wait_second_dcr_wr_end, second_tnh_dly, what_else_st, dcr_rqst_st);
   signal dcr_fsm        : dcr_fsm_type;
   signal reg_en         : std_logic_vector(2 downto 0);
   signal reg_en_latch   : std_logic_vector(2 downto 0);
   signal dcr_mosi_i     : t_ll_ext_mosi8;
   signal input_mosi     : t_ll_ext_mosi8; 
   signal sreset         : std_logic;
   signal cnt            : unsigned(7 downto 0);
   signal done_i         : std_logic;
   signal rqst_i         : std_logic;
   signal reg_rqst       : std_logic;
   signal spi_done_last  : std_logic;
   signal dcr_drem       : std_logic_vector(3 downto 0);
   
   signal new_cfg_num    : unsigned(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal present_cfg_num: unsigned(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal new_cfg_num_sync : std_logic_vector(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal new_cfg_num_pending : std_logic;
   
   
begin
   
   
   REGISTER_EN  <=  reg_en; 
   
   ----------------------------------------------------------------
   --  input MUX
   ----------------------------------------------------------------
   U1: with reg_en select input_mosi <=
   MCR_MOSI when MCR,
   WCR_MOSI when WCR,
   DDR_MOSI when DDR, 
   WDR_MOSI when WDR,
   ('0','0','0','0',(others =>'0'),'0','1') when others; 
   
   
   ----------------------------------------------------------------
   --  OUTPUT MAP
   ----------------------------------------------------------------
   -- entrée MOSI vers la sortie puis strip EOF
   U2A: with reg_en select TX_MOSI <=
   dcr_mosi_i when DCR,
   (input_mosi.sof,'0','0','0',input_mosi.data, input_mosi.dval, input_mosi.support_busy) when MCR,
   (input_mosi.sof,'0','0','0',input_mosi.data, input_mosi.dval, input_mosi.support_busy) when WCR,
   (input_mosi.sof,'0','0','0',input_mosi.data, input_mosi.dval, input_mosi.support_busy) when DDR, 
   (input_mosi.sof,'0','0','0',input_mosi.data, input_mosi.dval, input_mosi.support_busy) when WDR,
   ('0','0','0','0',(others =>'0'),'0','1') when others;
   
   -- drem
   U2B: with reg_en select TX_DREM <=
   dcr_drem when DCR,
   MCR_DREM when MCR,
   WCR_DREM when WCR,
   DDR_DREM when DDR, 
   WDR_DREM when WDR,
   "1000"   when others;
   
   
   -- miso 
   MCR_MISO <= TX_MISO when reg_en = MCR else ('1','1'); 
   WCR_MISO <= TX_MISO when reg_en = WCR else ('1','1'); 
   DDR_MISO <= TX_MISO when reg_en = DDR else ('1','1');
   WDR_MISO <= TX_MISO when reg_en = WDR else ('1','1'); 
   
   -- autorisation   
   RQST <= rqst_i; 
   DONE <= done_i;
   
    
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U3A: sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset);
   
   --------------------------------------------------
   -- Sync cfg_num
   --------------------------------------------------
   U3B : double_sync_vector  
   port map(
      D => std_logic_vector(USER_CFG.CFG_NUM),
      Q => new_cfg_num_sync,
      CLK => CLK); 
   
   --------------------------------------------------
   --  cfg_num
   --------------------------------------------------
   -- ENO: 26 nov 2018: Pour eviter bugs , reprogrammer le ROIC, dès qu'une config est reçue du MB.
   
   U2C : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         -- nouvelle config lorsque cfg_num change
		 new_cfg_num <= unsigned(new_cfg_num_sync);
         
         -- detection du changement
         if present_cfg_num /= new_cfg_num then
            new_cfg_num_pending <= '1';
         else
            new_cfg_num_pending <= '0';
         end if;         
         
      end if;
   end process;       
   
   
   --------------------------------------------------
   -- reg_ctler
   -------------------------------------------------- 
   -- permet de programmer les registre du detecteur
   U4: process(CLK)   
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            dcr_fsm <=  idle;
            dcr_mosi_i.dval <= '0'; 
            reg_en <= NONE;
            done_i <= '0'; 
            rqst_i <= '0';
            dcr_mosi_i.support_busy <= '1';
            reg_rqst <= '0'; 
            dcr_drem <= "1000"; -- DCR est un registre à 8 bits 
            present_cfg_num <= not new_cfg_num;
         else                   
            -- demande de programmtion en provenance des registres
            reg_rqst <= MCR_MOSI.DVAL or WCR_MOSI.DVAL or DDR_MOSI.DVAL or WDR_MOSI.DVAL; 
            
            -- pour detecter la remontée de SPI_DONE
            spi_done_last <= SPI_DONE;
            
            --fsm de contrôle
            if TX_MISO.BUSY = '0' then 
               
               case  dcr_fsm is 
                  
                  when idle =>
                     dcr_mosi_i.dval <= '0'; 
                     reg_en <= NONE; 
                     done_i <= '1';     -- done à '1' ssi aucune demande 
                     if SPI_DONE = '1' and (reg_rqst = '1' or new_cfg_num_pending = '1') then 
                        dcr_fsm <= dcr_rqst_st;
                     end if;
                     
                  when dcr_rqst_st =>  -- demande pour programmer le fpa. Cela perfmet d'arreter les integrations
                     rqst_i <= '1'; 
                     if EN = '1' then
                        dcr_fsm <= check_st;
                        rqst_i <= '0';
                        done_i <= '0';
                     end if;
                  
                  when check_st =>     -- recherche des registres ayant fait la demande de programmation
                     if MCR_MOSI.DVAL = '1' and MCR_ERR = '0' then     
                        dcr_mosi_i.data <= x"10";   -- registre MCR à programmer (voir manuel)
                        reg_en_latch <= MCR; 
                        dcr_fsm <= first_dcr_wr;
                     elsif WCR_MOSI.DVAL = '1' and WCR_ERR = '0' then 
                        dcr_mosi_i.data <= x"40";     -- registre WCR à programmer (voir manuel)
                        reg_en_latch <= WCR;
                        dcr_fsm <= first_dcr_wr;
                     elsif DDR_MOSI.DVAL = '1' and DDR_ERR = '0' then 
                        dcr_mosi_i.data <= x"80";     -- registre DDR à programmer (voir manuel)
                        reg_en_latch <= DDR; 
                        dcr_fsm <= first_dcr_wr;
                     elsif WDR_MOSI.DVAL = '1' and WDR_ERR = '0' then 
                        dcr_mosi_i.data <= x"20";     -- registre WDR à programmer (voir manuel)                         
                        reg_en_latch <= WDR;
                        dcr_fsm <= first_dcr_wr;
                     else                                -- aucun registre à programmer.  new_cfg_num_pending est à '1'
                        reg_en_latch <= NONE;
                        dcr_fsm <= second_tnh_dly;      -- il faut feindre programmer un registre et on retourne à idle. Cela permet de faire de la correction electronique en mode evenementiel par exemple.
                     end if;
                     dcr_mosi_i.data(3) <= not USER_CFG.FULL_WINDOW;
                     cnt <= (others => '0');
                  
                  when first_dcr_wr =>          -- ecrire d'abord le DCR pour activer le registre choisi
                     reg_en <= DCR;
                     dcr_mosi_i.sof <= '1';       -- permet d'activer NCS à LOW
                     dcr_mosi_i.eof <= '1';       -- permet de desactiver NCS (revient à HIGH)
                     dcr_mosi_i.dval <= '1';
                     dcr_fsm <=  wait_first_dcr_wr_end;
                  
                  when wait_first_dcr_wr_end =>   
                     dcr_mosi_i.sof <= '0'; 
                     dcr_mosi_i.eof <= '0'; 
                     dcr_mosi_i.dval <= '0';
                     cnt <= (others => '0');
                     if SPI_DONE = '1'  and spi_done_last = '0' then   -- attendre la fin de la communication SPI
                        dcr_fsm <=  first_tnh_dly;
                     end if;
                  
                  when first_tnh_dly =>                   -- on observe le delai tNH du manuel
                     cnt <= cnt + 1;
                     if cnt =  HAWK_TNH_DLY then      
                        dcr_fsm <= reg_wr_st;             -- on branche l'entrée à la sortie
                     end if;
                  
                  when reg_wr_st =>                       -- le SPI_DONE ne retourne à '1' que si la trame est terminée par EOF
                     reg_en <= reg_en_latch;              -- les trames des 4 registres autres que DCR sont depourvues de EOF
                     if  input_mosi.eof = '1' and input_mosi.dval = '1' and TX_MISO.BUSY = '0' then  -- attendre la fin le dernier byte du registre choisi
                        reg_en <= NONE;                  -- blocage des entrées
                        dcr_fsm <=  second_dcr_wr;                        
                     end if;                     
                  
                  when second_dcr_wr =>                  -- envoyer le registre DCR specifiant 
                     reg_en <= DCR; 
                     dcr_mosi_i.data <= x"00";           -- active mode ITR (voir manuel)
                     dcr_mosi_i.data(3) <= not USER_CFG.FULL_WINDOW;
                     dcr_mosi_i.sof <= '0';  
                     dcr_mosi_i.eof <= '1';              -- permet de desactiver NCS (revient à HIGH)
                     dcr_mosi_i.dval <= '1';
                     if TX_MISO.BUSY = '0' then          -- assure que le contenu actuel de DCR est envoyé
                        dcr_fsm <=  wait_second_dcr_wr_end;   
                     end if;
                  
                  when wait_second_dcr_wr_end =>         -- attendre la fin de la communication SPI
                     dcr_mosi_i.eof <= '0';         
                     dcr_mosi_i.dval <= '0';
                     reg_en <= DCR;
                     cnt <= (others => '0');
                     if SPI_DONE = '1' then
                        dcr_fsm <=  second_tnh_dly;      
                     end if;   
                  
                  when second_tnh_dly =>                 -- on observe le delai tNH du manuel
                     cnt <= cnt + 1;
                     present_cfg_num <= new_cfg_num;
                     if cnt =  HAWK_TNH_DLY then
                        dcr_fsm <= what_else_st;
                     end if;
                  
                  when what_else_st =>
                     if reg_rqst = '1' then           -- on n'a pas terminé de programmer tous les registres qui ont fait la demande de programmation
                        dcr_fsm <= check_st;          -- done_i ne doit pas retourner à '1' 
                     else
                        dcr_fsm <= idle;              -- done_i peut retourner à '1'
                     end if;
                  
                  when others =>
                  
               end case;
               
            end if;
         end if;
      end if;     
   end process;
end  RTL;