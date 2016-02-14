-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : flagging_tb
-- Author      : Telops
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\Flagging\Sim\compile\flagging_tb.vhd
-- Generated   : Thu Aug  6 15:53:36 2015
-- From        : D:\Telops\FIR-00251-Proc\src\Flagging\Sim\src\flagging_tb.bde
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
use IEEE.numeric_std.all;
use work.tel2000.all;
library work;
use work.flag_define.all;
library flagging_tb;
use flagging_tb.tel2000.all;

entity flagging_tb is
  port(
       ARESETN : in STD_LOGIC
  );
end flagging_tb;

architecture flagging_tb of flagging_tb is

---- Component declarations -----

component flagging_top
  port (
       ARESETN : in STD_LOGIC;
       CLK_MB : in STD_LOGIC;
       EXT_TRIG : in STD_LOGIC;
       FPA_IMG_INFO : in IMG_INFO_TYPE;
       HDER_MISO : in T_AXI4_LITE_MISO;
       MB_MOSI : in T_AXI4_LITE_MOSI;
       HDER_MOSI : out T_AXI4_LITE_MOSI;
       MB_MISO : out T_AXI4_LITE_MISO
  );
end component;
component ublaze_sim
  port (
       AXIL_MISO : in T_AXI4_LITE_MISO;
       AXIL_MOSI : out T_AXI4_LITE_MOSI;
       CLK100 : out STD_LOGIC;
       Feedback_FPA_Info : out IMG_INFO_TYPE;
       Rstn : out STD_LOGIC;
       Trig_HW : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal ARESET : STD_LOGIC;
signal clk_100 : STD_LOGIC;
signal hder_miso : t_axi4_lite_miso;
signal img_info : img_info_type;
signal miso : t_axi4_lite_miso;
signal mosi : t_axi4_lite_mosi;
signal reset_i : STD_LOGIC;
signal trig_i : STD_LOGIC;

begin

---- User Signal Assignments ----
hder_miso.AWREADY <= '1';
hder_miso.WREADY <= '1';
hder_miso.BVALID <= '1';

----  Component instantiations  ----

U1 : flagging_top
  port map(
       ARESETN => reset_i,
       CLK_MB => clk_100,
       EXT_TRIG => trig_i,
       FPA_IMG_INFO => img_info,
       HDER_MISO => hder_miso,
       MB_MISO => miso,
       MB_MOSI => mosi
  );

U2 : ublaze_sim
  port map(
       AXIL_MISO => miso,
       AXIL_MOSI => mosi,
       CLK100 => clk_100,
       Feedback_FPA_Info => img_info,
       Rstn => reset_i,
       Trig_HW => trig_i
  );

ARESET <= not(ARESETN);


end flagging_tb;
