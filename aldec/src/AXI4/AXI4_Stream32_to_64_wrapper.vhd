------------------------------------------------------------------
--!   @file AXI4_Stream32_to_64_wrapper.vhd
--!   @brief Wrapper for IP AXI4_Stream32_to_64_wrapper.
--!   @details This file contains wrapper for the IP AXI4_Stream32_to_64_wrapper.
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

--!   Use IEEE standard library.
library IEEE;
--!   Use logic elements package from IEEE library.
use IEEE.STD_LOGIC_1164.all; 
--!   Use TEL2000 package package from work library. 
use work.TEL2000.all;

entity AXI_Stream32_to_64_wrapper is
port(

   ACLK : in std_logic;
   ARESETN : in std_logic;

   S_ACLK : in std_logic;
   S_ARESETN : in std_logic;
   S_AXI4S_32_MOSI : in t_axi4_stream_mosi32;
   S_AXI4S_32_MISO : out t_axi4_stream_miso;
   
   M_ACLK : in std_logic;
   M_ARESETN : in std_logic;
   M_AXI4S_64_MOSI : out t_axi4_stream_mosi64;
   M_AXI4S_64_MISO : in t_axi4_stream_miso
   );
end AXI_Stream32_to_64_wrapper;

architecture RTL of AXI_Stream32_to_64_wrapper is

	component axi4_stream32_to_64
	port(
		ACLK : in STD_LOGIC;
		ARESETN : in STD_LOGIC;
		S00_AXIS_ACLK : in STD_LOGIC;
		S00_AXIS_ARESETN : in STD_LOGIC;
		S00_AXIS_TVALID : in STD_LOGIC;
		S00_AXIS_TREADY : out STD_LOGIC;
		S00_AXIS_TDATA : in STD_LOGIC_VECTOR(31 downto 0);
		S00_AXIS_TSTRB : in STD_LOGIC_VECTOR(3 downto 0);
		S00_AXIS_TKEEP : in STD_LOGIC_VECTOR(3 downto 0);
		S00_AXIS_TLAST : in STD_LOGIC;
		S00_AXIS_TID : in STD_LOGIC_VECTOR(0 to 0);
		S00_AXIS_TDEST : in STD_LOGIC_VECTOR(3 downto 0);
		S00_AXIS_TUSER : in STD_LOGIC_VECTOR(7 downto 0);
		M00_AXIS_ACLK : in STD_LOGIC;
		M00_AXIS_ARESETN : in STD_LOGIC;
		M00_AXIS_TVALID : out STD_LOGIC;
		M00_AXIS_TREADY : in STD_LOGIC;
		M00_AXIS_TDATA : out STD_LOGIC_VECTOR(63 downto 0);
		M00_AXIS_TSTRB : out STD_LOGIC_VECTOR(7 downto 0);
		M00_AXIS_TKEEP : out STD_LOGIC_VECTOR(7 downto 0);
		M00_AXIS_TLAST : out STD_LOGIC;
		M00_AXIS_TID : out STD_LOGIC_VECTOR(0 to 0);
		M00_AXIS_TDEST : out STD_LOGIC_VECTOR(3 downto 0);
		M00_AXIS_TUSER : out STD_LOGIC_VECTOR(15 downto 0);
		S00_DECODE_ERR : out STD_LOGIC);
	end component;

begin
   
axi4_stream32_to_64_inst : axi4_stream32_to_64
   port map(
      ACLK => ACLK,
      ARESETN => ARESETN,
      S00_AXIS_ACLK => S_ACLK,
      S00_AXIS_ARESETN => S_ARESETN,
      S00_AXIS_TVALID => S_AXI4S_32_MOSI.TVALID,
      S00_AXIS_TREADY => S_AXI4S_32_MISO.TREADY,
      S00_AXIS_TDATA => S_AXI4S_32_MOSI.TDATA,
      S00_AXIS_TSTRB => S_AXI4S_32_MOSI.TSTRB,
      S00_AXIS_TKEEP => S_AXI4S_32_MOSI.TKEEP,
      S00_AXIS_TLAST => S_AXI4S_32_MOSI.TLAST,
      S00_AXIS_TID => S_AXI4S_32_MOSI.TID,
      S00_AXIS_TDEST => S_AXI4S_32_MOSI.TDEST,
      S00_AXIS_TUSER => S_AXI4S_32_MOSI.TUSER,
      M00_AXIS_ACLK => M_ACLK,
      M00_AXIS_ARESETN => M_ARESETN,
      M00_AXIS_TVALID => M_AXI4S_64_MOSI.TVALID,
      M00_AXIS_TREADY => M_AXI4S_64_MISO.TREADY,
      M00_AXIS_TDATA => M_AXI4S_64_MOSI.TDATA,
      M00_AXIS_TSTRB => M_AXI4S_64_MOSI.TSTRB,
      M00_AXIS_TKEEP => M_AXI4S_64_MOSI.TKEEP,
      M00_AXIS_TLAST => M_AXI4S_64_MOSI.TLAST,
      M00_AXIS_TID => M_AXI4S_64_MOSI.TID,
      M00_AXIS_TDEST => M_AXI4S_64_MOSI.TDEST,
      M00_AXIS_TUSER => M_AXI4S_64_MOSI.TUSER,
      S00_DECODE_ERR => open
   );
   
end RTL;