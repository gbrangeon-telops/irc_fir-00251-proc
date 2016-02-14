-------------------------------------------------------------------------------
--
-- Title       : adc_sample_sel_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\adc_sample_en_v2.vhd
-- Generated   : Mon Sep 12 14:50:37 2011
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
--use COMMON_HDL.Telops.all;
use work.IRIG_define_v2.all;

entity adc_sample_sel_v2 is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      SAMP_MISO     : out t_ll_miso;
      SAMP_MOSI     : in t_ll_mosi8;
      SAMP_CNT_MOSI : in t_ll_mosi8;
      SAMP_SEL_MOSI : out t_ll_mosi8;
      SAMP_SEL_MISO : in t_ll_miso;
      ERR           : out std_logic
      );
end adc_sample_sel_v2;



architecture RTL of adc_sample_sel_v2 is
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   signal sreset             : std_logic;
   signal samp_sel_mosi_i    : t_ll_mosi8;
   signal samp_cnt           : unsigned(SAMP_CNT_MOSI.DATA'LENGTH-1 downto 0);     
   
   
begin                                                                           
   
   ------------------------------------------------------
   -- sorties
   ------------------------------------------------------   
   SAMP_SEL_MOSI <= samp_sel_mosi_i;
   SAMP_MISO <= SAMP_SEL_MISO;
   samp_cnt <= unsigned(SAMP_CNT_MOSI.DATA);
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      );
   
   
   ------------------------------------------------------
   -- processus
   ------------------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            samp_sel_mosi_i.dval <= '0'; 
            samp_sel_mosi_i.support_busy <= '1';
         else
            
            samp_sel_mosi_i.data <= SAMP_MOSI.DATA; 
            
            case to_integer(samp_cnt) is         
               
               when 8 => 
                  samp_sel_mosi_i.dval <= SAMP_MOSI.DVAL;
                  samp_sel_mosi_i.sof <= '1';
                  samp_sel_mosi_i.eof <= '0';
               
               when 9 | 10  => 
                  samp_sel_mosi_i.dval <= SAMP_MOSI.DVAL;
                  samp_sel_mosi_i.sof <= '0';
                  samp_sel_mosi_i.eof <= '0';
               
               when 11 => 
                  samp_sel_mosi_i.dval <= SAMP_MOSI.DVAL;
                  samp_sel_mosi_i.sof <= '0';
                  samp_sel_mosi_i.eof <= '1';
               
               when others =>       
                  samp_sel_mosi_i.dval <= '0';
                  samp_sel_mosi_i.sof <= '0'; 
                  samp_sel_mosi_i.eof <= '0';
               
            end case;
            
            ERR <= SAMP_SEL_MISO.BUSY and SAMP_MOSI.DVAL;            
            
         end if;
      end if;
      
      
   end process;   
   
end RTL;
