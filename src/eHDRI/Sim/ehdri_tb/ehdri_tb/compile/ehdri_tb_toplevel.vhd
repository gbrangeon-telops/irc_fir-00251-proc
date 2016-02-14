-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : ehdri_tb
-- Author      : TELOPS
-- Company     : TELOPS
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\eHDRI\Sim\ehdri_tb\ehdri_tb\compile\ehdri_tb_toplevel.vhd
-- Generated   : Thu Apr  9 08:49:46 2015
-- From        : D:\Telops\FIR-00251-Proc\src\eHDRI\Sim\ehdri_tb\ehdri_tb\src\ehdri_tb_toplevel.bde
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

library ehdri_tb;
use ehdri_tb.tel2000.all;

entity ehdri_tb_toplevel is 
end ehdri_tb_toplevel;

architecture ehdri_tb_toplevel of ehdri_tb_toplevel is

---- Component declarations -----

component t_axi4_lite32_w_fifo
  generic(
       ASYNC : BOOLEAN := false;
       FifoSize : INTEGER := 16
  );
  port (
       ARESETN : in STD_LOGIC;
       RX_CLK : in STD_LOGIC;
       RX_MOSI : in T_AXI4_LITE_MOSI;
       TX_CLK : in STD_LOGIC;
       TX_MISO : in T_AXI4_LITE_MISO;
       OVFL : out STD_LOGIC;
       RX_MISO : out T_AXI4_LITE_MISO;
       TX_MOSI : out T_AXI4_LITE_MOSI
  );
end component;
component EHDRI_toplevel
  port (
       AResetN : in STD_LOGIC;
       Axil_Mosi : in t_axi4_lite_mosi;
       Clk_Ctrl : in STD_LOGIC;
       Clk_Data : in STD_LOGIC;
       EXP_Ctrl_Busy : in STD_LOGIC;
       FPA_Img_Info : in img_info_type;
       Hder_Axil_Miso : in t_axi4_lite_miso;
       Axil_Miso : out t_axi4_lite_miso;
       FPA_Exp_Info : out exp_info_type;
       Hder_Axil_Mosi : out t_axi4_lite_mosi
  );
end component;
component ublaze_sim
  port (
       AXIL_MISO : in T_AXI4_LITE_MISO;
       FPA_Exp_Info : in EXP_INFO_TYPE;
       AXIL_MOSI : out T_AXI4_LITE_MOSI;
       CLK100 : out STD_LOGIC;
       CLK160 : out STD_LOGIC;
       EXP_Ctrl_Busy : out STD_LOGIC;
       Feedback_FPA_Info : out IMG_INFO_TYPE;
       Rstn : out STD_LOGIC
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Signal declarations used on the diagram ----

signal axil_miso : t_axi4_lite_miso;
signal axil_mosi : t_axi4_lite_mosi;
signal clk100 : STD_LOGIC;
signal fpa_exp : exp_info_type;
signal fpa_feedback : img_info_type;
signal header_miso : t_axi4_lite_miso;
signal header_mosi : t_axi4_lite_mosi;
signal NET324 : STD_LOGIC;
signal NET851 : STD_LOGIC;
signal out_miso : t_axi4_lite_miso;

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

---- User Signal Assignments ----
out_miso.awready <= '0';
out_miso.wready <= '0';
out_miso.bvalid <= '0';
out_miso.bresp <= "00";

----  Component instantiations  ----

U1 : ublaze_sim
  port map(
       AXIL_MISO => axil_miso,
       AXIL_MOSI => axil_mosi,
       CLK100 => clk100,
       EXP_Ctrl_Busy => NET324,
       FPA_Exp_Info => fpa_exp,
       Feedback_FPA_Info => fpa_feedback,
       Rstn => NET851
  );

U2 : EHDRI_toplevel
  port map(
       AResetN => NET851,
       Axil_Miso => axil_miso,
       Axil_Mosi => axil_mosi,
       Clk_Ctrl => clk100,
       Clk_Data => clk100,
       EXP_Ctrl_Busy => NET324,
       FPA_Exp_Info => fpa_exp,
       FPA_Img_Info => fpa_feedback,
       Hder_Axil_Miso => header_miso,
       Hder_Axil_Mosi => header_mosi
  );

U3 : t_axi4_lite32_w_fifo
  generic map (
       ASYNC => true
  )
  port map(
       ARESETN => Dangling_Input_Signal,
       RX_CLK => clk100,
       RX_MISO => header_miso,
       RX_MOSI => header_mosi,
       TX_CLK => clk100,
       TX_MISO => out_miso
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end ehdri_tb_toplevel;
