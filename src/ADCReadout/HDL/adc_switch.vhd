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
      ADC_SEL	   	: in std_logic_vector(1 downto 0);

      ADC_SCLK_0     : in std_logic;
      ADC_CSn_0 	   : in std_logic;
      ADC_SDO_0		: out std_logic;
      ADC_SDI_0		: in std_logic;
      
      ADC_SCLK_1     : in std_logic;
      ADC_CSn_1 	   : in std_logic;
      ADC_SDO_1		: out std_logic;
      ADC_SDI_1		: in std_logic;
      
      --Legacy ADC 
      ADC747x_SCLK       : out std_logic;
      ADC747x_CSn        : out std_logic;
      ADC747x_SDO		   : in std_logic;
      
      --AD798x  
      ADC798x_SCLK       : out std_logic;
      ADC798x_Cnv        : out std_logic;
      ADC798x_SDO		   : in std_logic;
      ADC798x_SDI		   : out std_logic
      );
end adc_switch;


architecture rtl of adc_switch is
   
begin
   
ADC747x_SCLK  <= ADC_SCLK_0 when (ADC_SEL = "00" or ADC_SEL = "10") else ADC_SCLK_1;
ADC747x_CSn   <= ADC_CSn_0 when (ADC_SEL = "00" or ADC_SEL = "10") else ADC_CSn_1;    

ADC798x_SCLK  <= ADC_SCLK_1 when ADC_SEL = "10" else '0';
ADC798x_Cnv   <= ADC_CSn_1 when ADC_SEL = "10" else '0';
ADC798x_SDI   <= ADC_SDI_1 when ADC_SEL = "10" else '0';
    
ADC_SDO_0 <= ADC747x_SDO when (ADC_SEL = "00" or ADC_SEL = "10") else '0';     
ADC_SDO_1 <= ADC798x_SDO when ADC_SEL = "10" else 
             ADC747x_SDO when ADC_SEL = "01" else 
             '0';
    
end rtl;
