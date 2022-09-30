-------------------------------------------------------------------------------
--
-- Title       : adc_sample_en_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\adc_sample_en_v2.vhd
-- Generated   : Mon Sep 12 09:57:04 2011
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
--library Common_HDL;
--use Common_HDL.telops.all;
use work.IRIG_define_v2.all;

entity adc_sample_en_v2 is
   port(
      ARESET    : in STD_LOGIC;
      CLK       : in STD_LOGIC;
      IRIG_CARRIER_RE  	: in STD_LOGIC;       -- montée de l,'horloge irig qui est parfaitement synchronisé avec les données.
      SAMPLE_EN : out STD_LOGIC
      );
end adc_sample_en_v2; 

architecture RTL of adc_sample_en_v2 is  
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component; 
  
   signal sreset                       : std_logic; 
   signal clk_cnt                      : unsigned(ADC_SAMPLE_CLK_DIV_BIT downto 0);
   signal clk_bit_last                 : std_logic;
   signal irig_carrier_re_last         : std_logic;
   
begin
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
   -- diviseur d'horloge
   --------------------------------------------------    
   U2 : process(CLK)   
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            clk_cnt <= (others => '0');
            SAMPLE_EN <= '0';
            clk_bit_last <= '0';
            irig_carrier_re_last <= IRIG_CARRIER_RE;
         else
            irig_carrier_re_last <= IRIG_CARRIER_RE;
            -- Resync adc sample clock on each rising edge of irig clock
            if irig_carrier_re_last = '0' and IRIG_CARRIER_RE = '1' then 
               clk_cnt <= (others => '0');
            else
               clk_cnt <= clk_cnt + 1;
            end if;  
            clk_bit_last <= std_logic(clk_cnt(ADC_SAMPLE_CLK_DIV_BIT));              -- simple divison de l'horloge de 20MHz par ADC_SAMPLE_CLK_DIV_FACTOR 
            SAMPLE_EN <= not clk_bit_last and clk_cnt(ADC_SAMPLE_CLK_DIV_BIT); 
         end if;
      end if;
   end process;   
   
end RTL;
