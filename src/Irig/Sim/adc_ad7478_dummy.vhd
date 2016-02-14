-------------------------------------------------------------------------------
--
-- Title       : adc_ad7478_dummy
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\adc_ad7478_dummy.vhd
-- Generated   : Sun Sep 18 13:33:22 2011
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

entity adc_ad7478_dummy is
   port(
      ADC_IN         : in std_logic_vector(7 downto 0);
      ARESET         : in std_logic;
      CLK            : in std_logic;
      ADC_CS_N       : in std_logic;
      ADC_SDO        : out std_logic;
      ADC_SCLK       : in std_logic
      );
end adc_ad7478_dummy;


architecture adc_ad7478_dummy of adc_ad7478_dummy is
   
   type adc_fsm_type  is (idle, send_st);
   signal adc_fsm        : adc_fsm_type;
   signal count          : integer;
   signal adc_cs_n_last  : std_logic;
   signal data_sampled   : std_logic_vector(15 downto 0);
   signal  adc_sclk_last : std_logic;
   
begin
   
   -- la porteuse sinusoidale de 1KHz
   U1: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            adc_fsm <= idle;  
            adc_cs_n_last <= ADC_CS_N;
            adc_sclk_last <= ADC_SCLK;
            ADC_SDO <= 'Z';
         else
            adc_cs_n_last <= ADC_CS_N;
            adc_sclk_last <= ADC_SCLK;
            
            case adc_fsm is
               
               when idle => 
                  ADC_SDO <= 'Z';
                  if adc_cs_n_last = '1' and ADC_CS_N = '0' then 
                     data_sampled <= "000" & ADC_IN & "00000"; -- 3 zeros en tete et 5 zeros à la fin
                     adc_fsm <= send_st;
                     count <= 15;
                  end if;
               
               when send_st =>
                  if adc_sclk_last = '1' and ADC_SCLK = '0' then 
                     count <= count - 1;
                     ADC_SDO <= data_sampled(count); 
                  end if;
                  
                  if ADC_CS_N = '1' then 
                     adc_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;                                  
      end if;   
   end process;  
   
   
   
   
   
end adc_ad7478_dummy;
