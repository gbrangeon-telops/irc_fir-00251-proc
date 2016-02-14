-------------------------------------------------------------------------------
--
-- Title       : EHDRI_toplevel
-- Design      : ehdri_tb
-- Author      : Unknown
-- Company     : Unknown
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\eHDRI\Sim\ehdri_tb\ehdri_tb\compile\ehdri_toplevel.vhd
-- Generated   : Thu Apr  9 09:32:24 2015
-- From        : D:\Telops\FIR-00251-Proc\src\eHDRI\hdl\ehdri_toplevel.bde
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

library work;
use work.tel2000.all;

entity EHDRI_toplevel is
  port(
       AResetN : in STD_LOGIC;
       Clk_Ctrl : in STD_LOGIC;
       Clk_Data : in STD_LOGIC;
       EXP_Ctrl_Busy : in STD_LOGIC;
       Axil_Mosi : in t_axi4_lite_mosi;
       FPA_Img_Info : in img_info_type;
       Hder_Axil_Miso : in t_axi4_lite_miso;
       Axil_Miso : out t_axi4_lite_miso;
       FPA_Exp_Info : out exp_info_type;
       Hder_Axil_Mosi : out t_axi4_lite_mosi
  );
end EHDRI_toplevel;

architecture EHDRI_toplevel of EHDRI_toplevel is

---- Component declarations -----

component axil32_to_native
  port (
       ARESET : in STD_LOGIC;
       AXIL_MOSI : in T_AXI4_LITE_MOSI;
       CLK : in STD_LOGIC;
       RD_BUSY : in STD_LOGIC;
       RD_DATA : in STD_LOGIC_VECTOR(31 downto 0);
       RD_DVAL : in STD_LOGIC;
       WR_BUSY : in STD_LOGIC;
       AXIL_MISO : out T_AXI4_LITE_MISO;
       ERR : out STD_LOGIC;
       RD_ADD : out STD_LOGIC_VECTOR(31 downto 0);
       RD_EN : out STD_LOGIC;
       WR_ADD : out STD_LOGIC_VECTOR(31 downto 0);
       WR_DATA : out STD_LOGIC_VECTOR(31 downto 0);
       WR_EN : out STD_LOGIC;
       WR_STRB : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component ehdri_ctrl
  port (
       Axil_Mosi : in T_AXI4_LITE_MOSI;
       Mem_Miso : in T_AXI4_LITE_MISO;
       Rst : in STD_LOGIC;
       Sys_clk : in STD_LOGIC;
       Axil_Miso : out T_AXI4_LITE_MISO;
       ExpTime0 : out STD_LOGIC_VECTOR(31 downto 0);
       ExpTime1 : out STD_LOGIC_VECTOR(31 downto 0);
       ExpTime2 : out STD_LOGIC_VECTOR(31 downto 0);
       ExpTime3 : out STD_LOGIC_VECTOR(31 downto 0);
       Mem_Mosi : out T_AXI4_LITE_MOSI;
       SM_Enable : out STD_LOGIC
  );
end component;
component ehdri_index_mem
  port (
       addra : in STD_LOGIC_VECTOR(5 downto 0);
       addrb : in STD_LOGIC_VECTOR(9 downto 0);
       clka : in STD_LOGIC;
       clkb : in STD_LOGIC;
       dina : in STD_LOGIC_VECTOR(31 downto 0);
       enb : in STD_LOGIC;
       wea : in STD_LOGIC_VECTOR(0 to 0);
       doutb : out STD_LOGIC_VECTOR(1 downto 0)
  );
end component;
component EHDRI_SM
  port (
       AReset : in STD_LOGIC;
       Clk_Data : in STD_LOGIC;
       EXP_Ctrl_Busy : in STD_LOGIC;
       Enable : in STD_LOGIC;
       ExpTime0 : in STD_LOGIC_VECTOR(31 downto 0);
       ExpTime1 : in STD_LOGIC_VECTOR(31 downto 0);
       ExpTime2 : in STD_LOGIC_VECTOR(31 downto 0);
       ExpTime3 : in STD_LOGIC_VECTOR(31 downto 0);
       FPA_Img_Info : in IMG_INFO_TYPE;
       Hder_Axil_Miso : in T_AXI4_LITE_MISO;
       Mem_Data : in STD_LOGIC_VECTOR(1 downto 0);
       FPA_Exp_Info : out EXP_INFO_TYPE;
       Hder_Axil_Mosi : out T_AXI4_LITE_MOSI;
       Mem_Address : out STD_LOGIC_VECTOR(9 downto 0)
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';
constant GND_CONSTANT   : STD_LOGIC := '0';

---- Signal declarations used on the diagram ----

signal AReset : STD_LOGIC;
signal enable_i : STD_LOGIC;
signal GND : STD_LOGIC;
signal mem_miso_i : t_axi4_lite_miso;
signal mem_mosi_i : t_axi4_lite_mosi;
signal wr_en : STD_LOGIC;
signal exptime0_i : STD_LOGIC_VECTOR (31 downto 0);
signal exptime1_i : STD_LOGIC_VECTOR (31 downto 0);
signal exptime2_i : STD_LOGIC_VECTOR (31 downto 0);
signal exptime3_i : STD_LOGIC_VECTOR (31 downto 0);
signal mem_address_i : STD_LOGIC_VECTOR (9 downto 0);
signal mem_data_i : STD_LOGIC_VECTOR (1 downto 0);
signal wr_add : STD_LOGIC_VECTOR (31 downto 0);
signal wr_data : STD_LOGIC_VECTOR (31 downto 0);

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

----  Component instantiations  ----

U1 : ehdri_index_mem
  port map(
       addra(0) => wr_add(2),
       addra(1) => wr_add(3),
       addra(2) => wr_add(4),
       addra(3) => wr_add(5),
       addra(4) => wr_add(6),
       addra(5) => wr_add(7),
       wea(0) => wr_en,
       addrb => mem_address_i,
       clka => Clk_Ctrl,
       clkb => Clk_Data,
       dina => wr_data,
       doutb => mem_data_i,
       enb => enable_i
  );

U2 : axil32_to_native
  port map(
       ARESET => AReset,
       AXIL_MISO => mem_miso_i,
       AXIL_MOSI => mem_mosi_i,
       CLK => Clk_Ctrl,
       RD_BUSY => GND,
       RD_DATA(0) => Dangling_Input_Signal,
       RD_DATA(1) => Dangling_Input_Signal,
       RD_DATA(2) => Dangling_Input_Signal,
       RD_DATA(3) => Dangling_Input_Signal,
       RD_DATA(4) => Dangling_Input_Signal,
       RD_DATA(5) => Dangling_Input_Signal,
       RD_DATA(6) => Dangling_Input_Signal,
       RD_DATA(7) => Dangling_Input_Signal,
       RD_DATA(8) => Dangling_Input_Signal,
       RD_DATA(9) => Dangling_Input_Signal,
       RD_DATA(10) => Dangling_Input_Signal,
       RD_DATA(11) => Dangling_Input_Signal,
       RD_DATA(12) => Dangling_Input_Signal,
       RD_DATA(13) => Dangling_Input_Signal,
       RD_DATA(14) => Dangling_Input_Signal,
       RD_DATA(15) => Dangling_Input_Signal,
       RD_DATA(16) => Dangling_Input_Signal,
       RD_DATA(17) => Dangling_Input_Signal,
       RD_DATA(18) => Dangling_Input_Signal,
       RD_DATA(19) => Dangling_Input_Signal,
       RD_DATA(20) => Dangling_Input_Signal,
       RD_DATA(21) => Dangling_Input_Signal,
       RD_DATA(22) => Dangling_Input_Signal,
       RD_DATA(23) => Dangling_Input_Signal,
       RD_DATA(24) => Dangling_Input_Signal,
       RD_DATA(25) => Dangling_Input_Signal,
       RD_DATA(26) => Dangling_Input_Signal,
       RD_DATA(27) => Dangling_Input_Signal,
       RD_DATA(28) => Dangling_Input_Signal,
       RD_DATA(29) => Dangling_Input_Signal,
       RD_DATA(30) => Dangling_Input_Signal,
       RD_DATA(31) => Dangling_Input_Signal,
       RD_DVAL => GND,
       WR_ADD => wr_add,
       WR_BUSY => GND,
       WR_DATA => wr_data,
       WR_EN => wr_en
  );

U3 : ehdri_ctrl
  port map(
       Axil_Miso => Axil_Miso,
       Axil_Mosi => Axil_Mosi,
       ExpTime0 => exptime0_i,
       ExpTime1 => exptime1_i,
       ExpTime2 => exptime2_i,
       ExpTime3 => exptime3_i,
       Mem_Miso => mem_miso_i,
       Mem_Mosi => mem_mosi_i,
       Rst => AReset,
       SM_Enable => enable_i,
       Sys_clk => Clk_Ctrl
  );

U4 : EHDRI_SM
  port map(
       AReset => AReset,
       Clk_Data => Clk_Data,
       EXP_Ctrl_Busy => EXP_Ctrl_Busy,
       Enable => enable_i,
       ExpTime0 => exptime0_i,
       ExpTime1 => exptime1_i,
       ExpTime2 => exptime2_i,
       ExpTime3 => exptime3_i,
       FPA_Exp_Info => FPA_Exp_Info,
       FPA_Img_Info => FPA_Img_Info,
       Hder_Axil_Miso => Hder_Axil_Miso,
       Hder_Axil_Mosi => Hder_Axil_Mosi,
       Mem_Address => mem_address_i,
       Mem_Data => mem_data_i
  );

AReset <= not(AResetN);


---- Power , ground assignment ----

GND <= GND_CONSTANT;

---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end EHDRI_toplevel;
