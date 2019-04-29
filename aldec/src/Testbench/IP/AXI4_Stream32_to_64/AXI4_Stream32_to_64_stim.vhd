------------------------------------------------------------------
--!   @file AXI4_Stream32_to_64.vhd
--!   @brief Simulation file for AXI4_Stream32_to_64 component.
--!   @details This file test de AXI4_Stream32_to_64 component.
--!
--!   $Rev: 12881 $
--!   $Author: pdaraiche $
--!   $Date: 2014-01-17 15:09:18 -0500 (ven., 17 janv. 2014) $
--!   $Id: AXI4_Stream32_to_64_stim.vhd 12881 2014-01-17 20:09:18Z pdaraiche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/IP/AXI4_Stream32_to_64/AXI4_Stream32_to_64_stim.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
--library TEL2000;
use work.TEL2000.all;

entity AXI4_Stream32_to_64_stim is
port(
   ARESET : out std_logic;
   ACLK : out std_logic;
   
   S_ACLK : out std_logic;
   S_ARESET : out std_logic;
   
   M_ACLK : out std_logic;
   M_ARESET : out std_logic;
   
   DATA_TEST_mosi : out t_axi4_stream_mosi32;
   DATA_TEST_miso : in t_axi4_stream_miso;
   
   DATA_VERIF_mosi : in t_axi4_stream_mosi64;
   DATA_VERIF_miso : out t_axi4_stream_miso
   );
end AXI4_Stream32_to_64_stim;

--}} End of automatically maintained section

architecture sim of AXI4_Stream32_to_64_stim is

constant ACLK_PERIOD : time := 6.25ns;
constant S_ACLK_PERIOD : time := 6.25ns;
constant M_ACLK_PERIOD : time := 10ns;
constant ARESET_LENGTH : time := 200ns;
constant S_ARESET_LENGTH : time:= 200 ns;
constant M_ARESET_LENGTH : time:= 200 ns;


signal ACLK_i : std_logic := '0';
signal S_ACLK_i : std_logic := '0';
signal M_ACLK_i : std_logic := '0';

begin

ACLK <= ACLK_i;  
S_ACLK <= S_ACLK_i;
M_ACLK <= M_ACLK_i;


   -- enter your statements here --        
ACLK_GEN: process(ACLK_i)
begin
	ACLK_i<= not ACLK_i after ACLK_PERIOD/2; 
end process;

S_ACLK_GEN: process(S_ACLK_i)
begin
	S_ACLK_i<= not S_ACLK_i after S_ACLK_PERIOD/2; 
end process;

M_ACLK_GEN: process(M_ACLK_i)
begin
	M_ACLK_i<= not M_ACLK_i after M_ACLK_PERIOD/2; 
end process;


ARES: process
begin
	ARESET<='0';  -- reset of the counter
	wait for ARESET_LENGTH;
	ARESET<='1';
	wait;
end process;

S_ARES: process
begin
	S_ARESET<='0';  -- reset of the counter
	wait for S_ARESET_LENGTH;
	S_ARESET<='1';
	wait;
end process;

M_ARES: process
begin
	M_ARESET<='0';  -- reset of the counter
	wait for M_ARESET_LENGTH;
	M_ARESET<='1';
	wait;
end process;

STIM : process
begin
   DATA_TEST_mosi.TDATA <= (others => '0');
   DATA_TEST_mosi.TVALID <= '0';
   DATA_TEST_mosi.TSTRB <= (others => '0');
   DATA_TEST_mosi.TKEEP <= (others => '0');
   DATA_TEST_mosi.TLAST <= '0';
   DATA_TEST_mosi.TID   <= (others => '0');
   DATA_TEST_mosi.TDEST <= (others => '0');
   DATA_TEST_mosi.TUSER <= (others => '0');
   
   
   DATA_VERIF_miso.TREADY <= '1';
   
   wait for 10 us;
   
   for i in 1 to 10000 loop
      wait until S_ACLK_i = '1';
      if DATA_TEST_miso.TREADY = '1' then
         DATA_TEST_mosi.TVALID <= '1';
         DATA_TEST_mosi.TDATA <= std_logic_vector(to_unsigned(i*100,DATA_TEST_mosi.TDATA'length));
         DATA_TEST_mosi.TSTRB <= (others => '1');
         DATA_TEST_mosi.TKEEP <= (others => '1');
         if i = 10000 - 1 then
            DATA_TEST_mosi.TLAST <= '1';
         else
            DATA_TEST_mosi.TLAST <= '0';
         end if;
      end if;
   end loop;
   
end process;

end sim;
