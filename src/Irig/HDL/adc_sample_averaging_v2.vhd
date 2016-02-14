-------------------------------------------------------------------------------
--
-- Title       : adc_sample_averaging
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\adc_sample_averaging.vhd
-- Generated   : Mon Sep 12 15:49:44 2011
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
use IEEE.NUMERIC_STD.all;
--library COMMON_HDL;
use work.IRIG_define_v2.all;

entity adc_sample_averaging_v2 is
   port(
      ARESET    : in std_logic;
      CLK       : in std_logic;
      SAMP_MOSI : in t_ll_mosi8;
      SAMP_MISO : out t_ll_miso;      
      TX_MISO   : in t_ll_miso;
      TX_MOSI   : out t_ll_mosi8;
      ERR       : out std_logic
      );
end adc_sample_averaging_v2;



architecture RTL of adc_sample_averaging_v2 is 
   
   component sync_reset
      port (
         ARESET  : in std_logic;
         CLK     : in std_logic;
         SRESET  : out std_logic := '1'
         );
   end component;  
   
   signal sreset            : std_logic;
   signal mean_samp_dval    : std_logic; 
   signal samp_sum_i        : unsigned(TX_MOSI.DATA'LENGTH+3 downto 0); 
   signal mean_samp         : unsigned(TX_MOSI.DATA'LENGTH+3 downto 0);
   
begin  
   
   
   TX_MOSI.DVAL <= mean_samp_dval;
   TX_MOSI.DATA <= std_logic_vector(mean_samp(7 downto 0));
   TX_MOSI.SOF <= '0';
   TX_MOSI.EOF <= '0';
   TX_MOSI.SUPPORT_BUSY <= '1';
   
   SAMP_MISO <= TX_MISO;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   
   --------------------------------------------------
   -- contrôle 
   -------------------------------------------------- 
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            mean_samp_dval <= '0';-- valeur par defaut
            samp_sum_i <= (others => '0');
            mean_samp <= (others => '0');
         else
            
            mean_samp_dval <= '0';-- valeur par defaut
            
            if SAMP_MOSI.DVAL = '1' then  
               if SAMP_MOSI.SOF = '1' then          -- permet de se synchroniser automatiquement sur les sof       
                  samp_sum_i <= unsigned(x"0"&SAMP_MOSI.DATA);      
               else           
                  if SAMP_MOSI.EOF = '1' then
                     mean_samp <= (samp_sum_i + unsigned(x"0"&SAMP_MOSI.DATA))/4;   -- division par 4
                     mean_samp_dval <= '1'; 
                  else
                     samp_sum_i <= samp_sum_i + unsigned(x"0"&SAMP_MOSI.DATA); 
                  end if;
               end if;   
            end if; 
            
            ERR <= TX_MISO.BUSY and SAMP_MOSI.DVAL;
            
         end if;
      end if;
      
   end process;       
   
   
   
end RTL;
