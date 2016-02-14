------------------------------------------------------------------
--!   @file : ddr_data_decoder_core
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
use ieee.numeric_std.all;
use work.tel2000.all;

entity ddr_data_decoder_core is
   port(
      CLK              : in std_logic;
      ARESETN          : in std_logic;
      
      DDR_DATA_MOSI    : in t_axi4_stream_mosi64;
      DDR_DATA_MISO    : out t_axi4_stream_miso; 
      
      OFFSETi          : out std_logic_vector(31 downto 0);
      RANGEi           : out std_logic_vector(31 downto 0);
      Ki               : out std_logic_vector(31 downto 0);
      KAPPAi           : out std_logic_vector(31 downto 0);
      BETA0i           : out std_logic_vector(31 downto 0);
      ALPHAi           : out std_logic_vector(31 downto 0);
      BADPIXELi        : out std_logic_vector(31 downto 0);
      DVAL             : out std_logic;
      EOF              : out std_logic;
      BUSY             : in std_logic
      
      );
end ddr_data_decoder_core;



architecture rtl of ddr_data_decoder_core is
   
begin
   
   DDR_DATA_MISO.TREADY <= not BUSY;
   
   OFFSETi   <=   std_logic_vector(to_unsigned(to_integer(unsigned(DDR_DATA_MOSI.TDATA(11 downto 0))),32));   -- unsigned
   RANGEi    <=   std_logic_vector(to_unsigned(to_integer(unsigned(DDR_DATA_MOSI.TDATA(23 downto 12))),32));  -- unsigned
   Ki        <=   std_logic_vector(to_unsigned(to_integer(unsigned(DDR_DATA_MOSI.TDATA(29 downto 24))),32));  -- unsigned   
   KAPPAi    <=   std_logic_vector(to_unsigned(to_integer(unsigned(DDR_DATA_MOSI.TDATA(39 downto 30))),32));  -- unsigned
   BETA0i    <=   std_logic_vector(to_signed(to_integer(signed(DDR_DATA_MOSI.TDATA(50 downto 40))),32));      -- signed
   ALPHAi    <=   std_logic_vector(to_unsigned(to_integer(unsigned(DDR_DATA_MOSI.TDATA(62 downto 51))),32));  -- unsigned
   BADPIXELi <=   resize('0' & DDR_DATA_MOSI.TDATA(63), 32);
   EOF       <=   DDR_DATA_MOSI.TLAST;
   DVAL      <=   DDR_DATA_MOSI.TVALID and not BUSY;
   
end rtl;
