------------------------------------------------------------------
--!   @file : brd_mux_dummy
--!   @brief
--!   @details
--!
--!   $Rev: 22650 $
--!   $Author: pcouture $
--!   $Date: 2018-12-13 15:30:18 -0500 (jeu., 13 déc. 2018) $
--!   $Id: brd_mux_dummy.vhd 22650 2018-12-13 20:30:18Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0209A/src/brd_mux_dummy.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity brd_mux_dummy is
	 port(
		 SPI_MUX0 : in STD_LOGIC;
		 SPI_MUX1 : in STD_LOGIC;
		 SPI_CSN    : in std_logic;
		 SPI_SDI    : in STD_LOGIC;
		 SPI_SCLK : in STD_LOGIC;
		 SPI_SDO : out STD_LOGIC;
		 CLK : in STD_LOGIC;
		 ARESET : in STD_LOGIC;
		 SDO : in STD_LOGIC_VECTOR(3 downto 0);
		 CSN : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end brd_mux_dummy;



architecture rtl of brd_mux_dummy is 

signal client_id : integer range 0 to 3 := 3;

begin
   client_id <= to_integer(unsigned(SPI_MUX1&SPI_MUX0));
   SPI_SDO <= SDO(client_id);
   CSN(client_id) <= SPI_CSN;
end rtl;
