-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : flashctrl_testbench
-- Author      : TELOPS
-- Company     : TELOPS
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\Sim\flashctrl_testbench\flashctrl_testbench\compile\flashintf_testbench.vhd
-- Generated   : Thu Dec 11 14:52:10 2014
-- From        : D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\Sim\flashintf_testbench.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;
library flashctrl_testbench;
use flashctrl_testbench.tel2000.all;

entity flashintf_testbench is 
end flashintf_testbench;

architecture flashintf_testbench of flashintf_testbench is

---- Component declarations -----

component Flash_intf
  port (
       AxiL_Mosi : in t_axi4_a32_d32_mosi;
       FlashReadyBusy : in STD_LOGIC_VECTOR(1 downto 0);
       Rst : in STD_LOGIC;
       Sys_clk : in STD_LOGIC;
       AxiL_Miso : out t_axi4_a32_d32_miso;
       CmdIO : inout STD_LOGIC_VECTOR(5 downto 0);
       DataIO : inout STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component ublaze_sim
  port (
       AXIL_MISO : in T_AXI4_A32_D32_MISO;
       AXIL_MOSI : out T_AXI4_A32_D32_MOSI;
       CLK100 : out STD_LOGIC;
       FlashReadyBusy : out STD_LOGIC_VECTOR(1 downto 0);
       Rst : out STD_LOGIC;
       CmdIO : inout STD_LOGIC_VECTOR(5 downto 0);
       DataIO : inout STD_LOGIC_VECTOR(7 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal axi_miso : t_axi4_a32_d32_miso;
signal axi_mosi : t_axi4_a32_d32_mosi;
signal NET126 : STD_LOGIC;
signal NET135 : STD_LOGIC;
signal CmdIO : STD_LOGIC_VECTOR (5 downto 0);
signal DataIO : STD_LOGIC_VECTOR (7 downto 0);
signal FlashReadyBusy : STD_LOGIC_VECTOR (1 downto 0);

begin

----  Component instantiations  ----

U1 : Flash_intf
  port map(
       AxiL_Miso => axi_miso,
       AxiL_Mosi => axi_mosi,
       CmdIO => CmdIO,
       DataIO => DataIO,
       FlashReadyBusy => FlashReadyBusy,
       Rst => NET135,
       Sys_clk => NET126
  );

U2 : ublaze_sim
  port map(
       AXIL_MISO => axi_miso,
       AXIL_MOSI => axi_mosi,
       CLK100 => NET126,
       CmdIO => CmdIO,
       DataIO => DataIO,
       FlashReadyBusy => FlashReadyBusy,
       Rst => NET135
  );


end flashintf_testbench;
