------------------------------------------------------------------
--!   @file : adc_switch
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity adc_switch is
   port(
      ADC_SEL	   	: in std_logic;
      
      ADC_SCLK_0     : in std_logic;
      ADC_CSn_0 	   : in std_logic;
      ADC_SDO_0		: out std_logic;
      
      ADC_SCLK_1     : in std_logic;
      ADC_CSn_1 	   : in std_logic;
      ADC_SDO_1		: out std_logic;
      
      ADC_SCLK       : out std_logic;
      ADC_CSn        : out std_logic;
      ADC_SDO		   : in std_logic
      );
end adc_switch;


architecture rtl of adc_switch is
   
begin
   
   ADC_SCLK <= ADC_SCLK_1 when ADC_SEL = '1' else ADC_SCLK_0;
   ADC_CSn <= ADC_CSn_1 when ADC_SEL = '1' else ADC_CSn_0;
   
   ADC_SDO_0 <= ADC_SDO;
   ADC_SDO_1 <= ADC_SDO;
   
end rtl;
