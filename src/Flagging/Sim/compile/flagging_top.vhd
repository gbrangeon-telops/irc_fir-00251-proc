-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : flagging_tb
-- Author      : Telops
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\Flagging\Sim\compile\flagging_top.vhd
-- Generated   : Mon Aug 10 09:47:41 2015
-- From        : D:\Telops\FIR-00251-Proc\src\Flagging\HDL\flagging_top.bde
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

entity flagging_top is
  port(
       ARESETN : in STD_LOGIC;
       CLK_MB : in STD_LOGIC;
       EXT_TRIG : in STD_LOGIC;
       FPA_IMG_INFO : in img_info_type;
       HDER_MISO : in t_axi4_lite_miso;
       MB_MOSI : in t_axi4_lite_mosi;
       HDER_MOSI : out t_axi4_lite_mosi;
       MB_MISO : out t_axi4_lite_miso
  );
end flagging_top;

architecture flagging_top of flagging_top is

---- Component declarations -----

component double_sync
  generic(
       INIT_VALUE : BIT := '0'
  );
  port (
       CLK : in STD_LOGIC;
       D : in STD_LOGIC;
       RESET : in STD_LOGIC;
       Q : out STD_LOGIC := '0'
  );
end component;
component flagging_mblaze_intf
  port (
       ARESET : in STD_LOGIC;
       CLK : in STD_LOGIC;
       MB_MOSI : in T_AXI4_LITE_MOSI;
       FLAG_CFG : out FLAG_CFG_TYPE;
       MB_MISO : out T_AXI4_LITE_MISO;
       SOFT_TRIG : out STD_LOGIC
  );
end component;
component flagging_SM
  port (
       ARESET : in STD_LOGIC;
       CLK : in STD_LOGIC;
       FLAG_CFG : in FLAG_CFG_TYPE;
       HARD_TRIG : in STD_LOGIC;
       Hder_Axil_Miso : in T_AXI4_LITE_MISO;
       IMG_INFO : in IMG_INFO_TYPE;
       SOFT_TRIG : in STD_LOGIC;
       Hder_Axil_Mosi : out T_AXI4_LITE_MOSI
  );
end component;
component sync_reset
  port (
       ARESET : in STD_LOGIC;
       CLK : in STD_LOGIC;
       SRESET : out STD_LOGIC := '1'
  );
end component;

---- Signal declarations used on the diagram ----

signal ARESET : STD_LOGIC;
signal flag_cfg_i : flag_cfg_type;
signal hard_trig_i : STD_LOGIC;
signal NET4124 : STD_LOGIC;
signal RECORD1965 : img_info_type;
signal RECORD4232 : t_axi4_lite_mosi;
signal RECORD4236 : t_axi4_lite_miso;
signal RECORD6122 : t_axi4_lite_mosi;
signal RECORD6126 : t_axi4_lite_miso;
signal soft_trig_i : STD_LOGIC;

begin

----  Component instantiations  ----

U1 : flagging_mblaze_intf
  port map(
       ARESET => ARESET,
       CLK => CLK_MB,
       FLAG_CFG => flag_cfg_i,
       MB_MISO => RECORD4236,
       MB_MOSI => RECORD4232,
       SOFT_TRIG => soft_trig_i
  );

U3 : flagging_SM
  port map(
       ARESET => ARESET,
       CLK => CLK_MB,
       FLAG_CFG => flag_cfg_i,
       HARD_TRIG => hard_trig_i,
       Hder_Axil_Miso => RECORD6126,
       Hder_Axil_Mosi => RECORD6122,
       IMG_INFO => RECORD1965,
       SOFT_TRIG => soft_trig_i
  );

ARESET <= not(ARESETN);

U8 : sync_reset
  port map(
       ARESET => ARESET,
       CLK => CLK_MB,
       SRESET => NET4124
  );

U9 : double_sync
  port map(
       CLK => CLK_MB,
       D => EXT_TRIG,
       Q => hard_trig_i,
       RESET => NET4124
  );


---- Terminal assignment ----

    -- Inputs terminals
	RECORD1965 <= FPA_IMG_INFO;
	RECORD6126 <= HDER_MISO;
	RECORD4232 <= MB_MOSI;

    -- Output\buffer terminals
	HDER_MOSI <= RECORD6122;
	MB_MISO <= RECORD4236;


end flagging_top;
