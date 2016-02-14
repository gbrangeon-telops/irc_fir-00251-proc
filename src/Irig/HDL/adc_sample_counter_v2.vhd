-------------------------------------------------------------------------------
--
-- Title       : adc_sample_counter_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\adc_sample_counter_v2.vhd
-- Generated   : Mon Sep 12 13:24:40 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--library Common_HDL;
use work.IRIG_define_v2.all;

entity adc_sample_counter_v2 is
   port (
      CLK 			      : in std_logic;
      ARESET 				: in std_logic;
      
      IRIG_CARRIER_RE  	: in std_logic;       -- montée de l,'horloge irig qui est parfaitement synchronisé avec les données.
      ADC_DATA_DVAL		: in std_logic;
      ADC_DATA 			: in std_logic_vector(7 downto 0); 
      
      SAMP_MOSI         : out t_ll_mosi8;     -- sortie des echantillons
      SAMP_CNT_MOSI     : out t_ll_mosi8;     -- sortie des numeros associés aux echantillons
      SAMP_MISO         : in t_ll_miso      
      );   
   
   
end adc_sample_counter_v2;


architecture RTL of adc_sample_counter_v2 is
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;   
   
   type re_delay_fsm_type is (idle, delay_st); 
   
   signal re_delay_fsm         : re_delay_fsm_type;
   signal sreset               : std_logic;
   signal samp_mosi_i          : t_ll_mosi8; 
   signal samp_cnt             : unsigned(SAMP_CNT_MOSI.DATA'LENGTH-1 downto 0); 
   signal samp_cnt_valid       : std_logic; 
   signal err_i                : std_logic;
   signal irig_carrier_re_last : std_logic;
   --signal irig_clk_i      : std_logic;
   --signal irig_clk_i_last : std_logic;
   --signal irig_clk_rising : std_logic; 
   --signal re_delay_cnt    : unsigned(15 downto 0); -- permet de decaler le rising_edge de l'horloge IRIG pour se synchroniser sur les données
   
begin 
   
   
   ------------------------------------------------------
   -- sorties
   ------------------------------------------------------ 
   SAMP_MOSI <= samp_mosi_i;
   SAMP_CNT_MOSI.DATA <= std_logic_vector(samp_cnt);    
   
   
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      );
   
   -----------------------------------------------------
   -- numerotation des echantillons
   -----------------------------------------------------    
   U2: process(CLK)
   begin  
      if rising_edge(CLK) then 
         if sreset = '1' then 
            samp_mosi_i.dval <= '0';
            samp_mosi_i.support_busy <= '1';   -- pour que le downstream envoie des busy. Mais si cela arrive, c'est qu'il y a un gros problème de vitesse
            samp_cnt <= (others => '0'); 
            err_i <= '0';
            irig_carrier_re_last <= IRIG_CARRIER_RE;
         else 
            
            irig_carrier_re_last <= IRIG_CARRIER_RE; -- on s'assure que le pulse ne dure que 1CLK
            -- sortie des données synchro avec samp_cnt_mosi_i.dval
            samp_mosi_i.data <= ADC_DATA;            
            
            -- sortie des numeros des echantillons 
            if irig_carrier_re_last = '0' and IRIG_CARRIER_RE = '1' then 
               samp_cnt <= (others => '0');
               samp_mosi_i.dval <= '0';
            else
               if ADC_DATA_DVAL = '1' then 
                  samp_cnt <= samp_cnt + 1;               
                  samp_mosi_i.dval  <= '1';
               else
                  samp_mosi_i.dval  <= '0';
                  samp_cnt_valid  <= '0'; 
               end if;
            end if;    
            
            -- sortie de SOF
            if samp_cnt = 0 then
               samp_mosi_i.sof  <= '1';
            else
               samp_mosi_i.sof  <= '0';
            end if;              
            
            -- sortie de EOF n'est pas necessaire
            samp_mosi_i.eof  <= '0';
            
            -- erreur
            err_i <= SAMP_MISO.BUSY and samp_mosi_i.dval;
            
         end if;           
      end if;			
   end process;
   
   
end RTL;
