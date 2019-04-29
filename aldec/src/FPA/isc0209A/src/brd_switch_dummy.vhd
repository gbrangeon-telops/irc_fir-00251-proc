------------------------------------------------------------------
--!   @file : brd_switch_dummy
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

entity brd_switch_dummy is
   port(
      CLK      : in STD_LOGIC;
      ARESET   : in STD_LOGIC;
      SPI_SDI  : in std_logic;
      SPI_CSN  : in std_logic;
      SPI_SDO  : out std_logic;
      SPI_CLK  : in std_logic;
      DOUT     : out std_logic_vector(7 downto 0);
      DVAL     : out std_logic      
      );
end brd_switch_dummy;


architecture rtl of brd_switch_dummy is
   
   
   component spi_rx
      generic(
         BITWIDTH : NATURAL := 12
         );
      port (
         CLK : in STD_LOGIC;
         CSn : in STD_LOGIC;
         SCL : in STD_LOGIC;
         SDA : in STD_LOGIC;
         DOUT : out STD_LOGIC_VECTOR(BITWIDTH-1 downto 0);
         DVAL : out STD_LOGIC
         );
   end component;
   
   signal sclk_i : std_logic;
   
begin
   
   sclk_i <=  transport SPI_CLK after 20ns;
   
   U5 : spi_rx
   generic map (
      BITWIDTH => 8
      )
   port map(
      CLK  => CLK,
      CSn  => SPI_CSN,
      SCL  => sclk_i,
      SDA  => SPI_SDI,
      DOUT => DOUT,
      DVAL => DVAL
      );
   
end rtl;
