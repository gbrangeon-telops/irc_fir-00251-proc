------------------------------------------------------------------
--!   @file : brd_mux_dummy
--!   @brief
--!   @details
--!
--!   $Rev: 19529 $
--!   $Author: enofodjie $
--!   $Date: 2016-11-19 19:01:16 -0500 (sam., 19 nov. 2016) $
--!   $Id: brd_mux_dummy.vhd 19529 2016-11-20 00:01:16Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0207A_3k/src/brd_mux_dummy.vhd $
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
