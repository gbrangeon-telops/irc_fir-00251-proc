------------------------------------------------------------------
--!   @file : fpa_temp_dummy
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fpa_temp_dummy is
	 port(
		 FPA_TEMP : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end fpa_temp_dummy;



architecture rtl of fpa_temp_dummy is

constant FPA_TEMPERATURE_V        : real := 1030.0;  
constant BRD_GAIN                 : real := 1.0;
constant ADC_RANGE_V              : real := 2048.0;
constant ADC_RESOLUTION           : integer := 15; 


begin 
   
   FPA_TEMP <=   std_logic_vector(to_unsigned(integer(BRD_GAIN*FPA_TEMPERATURE_V*real(2**ADC_RESOLUTION)/(ADC_RANGE_V)), FPA_TEMP'length)); 
   
   
end rtl;
