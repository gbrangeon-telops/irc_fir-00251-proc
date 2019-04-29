------------------------------------------------------------------
--!   @file : digio_dummy
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

entity digio_dummy is
	 port(
		 DIGIO_V : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end digio_dummy;



architecture rtl of digio_dummy is

constant FPA_DIGIO_V              : real := 4950.0;  
constant BRD_GAIN                 : real := 590.0/(1000.0 + 590.0);
constant ADC_RANGE_V              : real := 2048.0;
constant ADC_RESOLUTION           : integer := 15; 


begin 
   
   DIGIO_V <=   std_logic_vector(to_unsigned(integer(BRD_GAIN*FPA_DIGIO_V*real(2**ADC_RESOLUTION)/(ADC_RANGE_V)), DIGIO_V'length)); 
   
   
end rtl;
