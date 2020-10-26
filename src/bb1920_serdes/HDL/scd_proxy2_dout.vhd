------------------------------------------------------------------
--!   @file : scd_proxy2_dout
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

entity scd_proxy2_dout is
	 port(
		 ARESET        : in std_logic;
		 CLK           : in std_logic;
       
		 DIN           : in std_logic_vector(31 downto 0);
       SUCCESS       : in std_logic;
		 
       FVAL          : out std_logic_vector(7 downto 0);
		 LVAL          : out std_logic_vector(7 downto 0);
		 DOUT          : out std_logic_vector(71 downto 0);
		 DOUT_DVAL     : out std_logic
	     );
end scd_proxy2_dout;


architecture rtl of scd_proxy2_dout is
begin

	 -- enter your statements here --

end rtl;
