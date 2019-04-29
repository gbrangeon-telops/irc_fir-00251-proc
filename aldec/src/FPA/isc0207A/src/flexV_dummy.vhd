------------------------------------------------------------------
--!   @file : flexV_dummy
--!   @brief
--!   @details
--!
--!   $Rev: 22596 $
--!   $Author: enofodjie $
--!   $Date: 2018-12-04 12:05:46 -0500 (mar., 04 déc. 2018) $
--!   $Id: flexV_dummy.vhd 22596 2018-12-04 17:05:46Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0207A/src/flexV_dummy.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flexV_dummy is
	 port(
		 FLEX_V : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end flexV_dummy;



architecture rtl of flexV_dummy is

constant FPA_FLEX_V               : real := 7950.0;  
constant BRD_GAIN                 : real := 332.0/(1000.0 + 332.0);
constant ADC_RANGE_V              : real := 2048.0;
constant ADC_RESOLUTION           : integer := 15; 


begin 
   
   FLEX_V <=   std_logic_vector(to_unsigned(integer(BRD_GAIN*FPA_FLEX_V*real(2**ADC_RESOLUTION)/(ADC_RANGE_V)), FLEX_V'length)); 
   
   
end rtl;
