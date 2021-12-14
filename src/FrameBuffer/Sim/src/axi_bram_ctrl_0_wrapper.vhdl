-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Sat Aug 15 12:51:43 2020
-- Host        : TELOPS250 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Telops/FIR-00251-Proc/IP/325/axi_bram_ctrl_0/axi_bram_ctrl_0_stub.vhdl
-- Design      : axi_bram_ctrl_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.TEL2000.all;

entity axi_bram_ctrl_0_wrapper is
  Port ( 
  
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
   
    AXI_BRAM_MOSI         : in t_axi4_a32_d128_mosi;
    AXI_BRAM_MISO         : out t_axi4_a32_d128_miso 

  );

end axi_bram_ctrl_0_wrapper;

architecture axi_bram_ctrl_0_wrapper of axi_bram_ctrl_0_wrapper is


component axi_bram_ctrl_0 is
  Port ( 
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    --s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    
    --s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    
    --s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 13 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;-- non defini sur le data mover 
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    
    s_axi_arready : out STD_LOGIC;
    --s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC);

end component;

begin
   axi_bram_ctrl_0_wrapper_i : component axi_bram_ctrl_0
   port map (
   

   s_axi_aclk  => s_axi_aclk,
   s_axi_aresetn  => s_axi_aresetn,
   --s_axi_awid => AXI_BRAM_MOSI.awid(0 downto 0),
   s_axi_awaddr => AXI_BRAM_MOSI.awaddr(13 downto 0),
   s_axi_awlen => AXI_BRAM_MOSI.awlen,
   s_axi_awsize => AXI_BRAM_MOSI.awsize,
   s_axi_awburst => AXI_BRAM_MOSI.awburst,
   s_axi_awlock => AXI_BRAM_MOSI.awlock(0),
   s_axi_awcache => AXI_BRAM_MOSI.awcache,
   s_axi_awprot => AXI_BRAM_MOSI.awprot,
   s_axi_awvalid => AXI_BRAM_MOSI.awvalid,
   s_axi_awready => AXI_BRAM_MISO.awready,
   s_axi_wdata => AXI_BRAM_MOSI.wdata,
   s_axi_wstrb => AXI_BRAM_MOSI.wstrb,
   s_axi_wlast => AXI_BRAM_MOSI.wlast,
   s_axi_wvalid => AXI_BRAM_MOSI.wvalid,
   s_axi_wready => AXI_BRAM_MISO.wready,
   --s_axi_bid => AXI_BRAM_MISO.bid(0 downto 0),
   s_axi_bready => AXI_BRAM_MOSI.bready,
   s_axi_bresp => AXI_BRAM_MISO.bresp,
   s_axi_bvalid => AXI_BRAM_MISO.bvalid,
   
   -- AXI4-FULL - Read address channel (mosi)
   --s_axi_arid            => AXI_BRAM_MOSI.arid(0 downto 0),
   s_axi_araddr          => AXI_BRAM_MOSI.araddr(13 downto 0),
   s_axi_arlen           => AXI_BRAM_MOSI.arlen,
   s_axi_arsize          => AXI_BRAM_MOSI.arsize,
   s_axi_arburst         => AXI_BRAM_MOSI.arburst,
   s_axi_arprot          => AXI_BRAM_MOSI.arprot,
   s_axi_arcache         => AXI_BRAM_MOSI.arcache,
   s_axi_arvalid         => AXI_BRAM_MOSI.arvalid,
   s_axi_arlock         => AXI_BRAM_MOSI.arlock(0),
   
   -- AXI4-FULL - Read address channel(miso)
   --s_axi_rid             => AXI_BRAM_MISO.rid(0 downto 0),
   s_axi_arready         => AXI_BRAM_MISO.arready,
   -- AXI4-FULL - Read data channel (miso)
   s_axi_rdata           => AXI_BRAM_MISO.rdata,
   s_axi_rresp           => AXI_BRAM_MISO.rresp,
   s_axi_rlast           => AXI_BRAM_MISO.rlast,
   s_axi_rvalid          => AXI_BRAM_MISO.rvalid,
   -- AXI4-FULL - Read data channel (mosi)
   s_axi_rready          => AXI_BRAM_MOSI.rready
   );
end;
