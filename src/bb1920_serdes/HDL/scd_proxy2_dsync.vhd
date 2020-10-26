------------------------------------------------------------------
--!   @file : scd_proxy2_dsync
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

entity scd_proxy2_dsync is
	 port(
		 ARESET        : in std_logic;
		 
       DIN_DVAL      : in std_logic;
		 DIN           : in std_logic_vector(71 downto 0);
		 DIN_CLK       : in std_logic;
       
		 DOUT_CLK      : in std_logic;
		 DOUT_DVAL     : out std_logic;
		 DOUT          : out std_logic_vector(71 downto 0)
	     );
end scd_proxy2_dsync;



architecture scd_proxy2_dsync of scd_proxy2_dsync is
begin

	 -- enter your statements here --

end scd_proxy2_dsync;
