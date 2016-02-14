----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2014 09:26:29 AM
-- Design Name: 
-- Module Name: ublaze_sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

use work.tel2000.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ublaze_sim is
port(
 AXIL_MOSI : out T_AXI4_A32_D32_MOSI;
 AXIL_MISO : in T_AXI4_A32_D32_MISO;
 FlashReadyBusy : out std_logic_vector(1 downto 0);
 CmdIO : inout std_logic_vector(5 downto 0);
 DataIO : inout std_logic_vector(7 downto 0);
 CLK100 : out STD_LOGIC;
 Rst : out std_logic
 );
end ublaze_sim;

architecture Behavioral of ublaze_sim is

signal TestReadValue : std_logic_vector(31 downto 0);
signal rst_i : std_logic := '1';
signal clk_i : std_logic;

begin

--! Reset Generation
rst_i <= '0' after 500 ns;
Rst <= rst_i;

   CLK100_GEN : process
   begin          
      clk_i <= '1';
   wait for 50 ns;
      clk_i <= '0'; 
   wait for 50 ns;
   end process; 

CLK100 <= clk_i;

   FlashReadyBusy <= "11";
   CmdIO <= "101011";
   DataIO <= "11100111";

ublaze_stim: process is
   begin
      AXIL_MOSI.awaddr <= (others => '0');
      AXIL_MOSI.awburst <= (others => '0');
      AXIL_MOSI.awcache <= (others => '0');
      AXIL_MOSI.awlen <= (others => '0');
      AXIL_MOSI.awlock <= (others => '0');
      AXIL_MOSI.awprot <= (others => '0');
      AXIL_MOSI.awqos <= (others => '0');
      AXIL_MOSI.awregion <= (others => '0');
      AXIL_MOSI.awsize <= (others => '0');
      AXIL_MOSI.wdata <= (others => '0');
      AXIL_MOSI.wstrb <= (others => '0');
      AXIL_MOSI.araddr <= (others => '0');
      AXIL_MOSI.arburst <= (others => '0');
      AXIL_MOSI.arcache <= (others => '0');
      AXIL_MOSI.arlen <= (others => '0');
      AXIL_MOSI.arlock <= (others => '0');
      AXIL_MOSI.arprot <= (others => '0');
      AXIL_MOSI.arqos <= (others => '0');
      AXIL_MOSI.arregion <= (others => '0');
      AXIL_MOSI.arsize <= (others => '0');

      AXIL_MOSI.awvalid <= '0';
      AXIL_MOSI.wlast <= '0';
      AXIL_MOSI.wvalid <= '0';
      AXIL_MOSI.bready <= '0';
      AXIL_MOSI.arvalid <= '0';
      AXIL_MOSI.rready <= '0';
	  
	  
      wait until rst_i = '0';

      wait until rising_edge(clk_i);
   
      --Write AXI config   FULL
      wait for 50 ns;
      write_axi_lite (clk_i, X"00002000", X"00000004", AXIL_MISO,  AXIL_MOSI);
      wait for 31000 ns;
      write_axi_lite (clk_i, X"00002000", X"00000000", AXIL_MISO,  AXIL_MOSI);
      wait for 100 ns;
      read_axi_lite (X"00000000", AXIL_MISO,  AXIL_MOSI, TestReadValue);
      wait for 100 ns;
      read_axi_lite (X"00000004", AXIL_MISO,  AXIL_MOSI, TestReadValue);
      wait for 100 ns;
      read_axi_lite (X"00000008", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      write_axi_lite (clk_i, X"00002000", X"00000000", AXIL_MISO,  AXIL_MOSI);
--      wait for 100 ns;
--      write_axi_lite (clk_i, X"00002010", X"00000000", AXIL_MISO,  AXIL_MOSI);
--      wait for 100 ns;
--      write_axi_lite (clk_i, X"00002018", X"00000004", AXIL_MISO,  AXIL_MOSI);
--      wait for 100 ns;
--      write_axi_lite (clk_i, X"0000201C", X"00000000", AXIL_MISO,  AXIL_MOSI);
--      wait for 100 ns;
--      read_axi_lite (X"00002000", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"00002004", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"00002008", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"0000200C", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"00002010", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"00002014", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"00002018", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
--      read_axi_lite (X"0000201C", AXIL_MISO,  AXIL_MOSI, TestReadValue);
--      wait for 100 ns;
      report "FCR written"; 

      report "END OF SIMULATION" 
      severity error;
end process ublaze_stim;

 
end Behavioral;
