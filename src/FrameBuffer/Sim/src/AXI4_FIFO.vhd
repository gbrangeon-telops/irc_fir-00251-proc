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

entity AXI4_FIFO is
  Port ( 
  
    s_aclk : in STD_LOGIC; 
    m_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
   
    AXI_RX_MOSI                : in t_axi4_a32_d128_mosi;
    AXI_RX_MISO                : out t_axi4_a32_d128_miso; 
    
    AXI_TX_MOSI                : out t_axi4_a32_d128_mosi;
    AXI_TX_MISO                : in t_axi4_a32_d128_miso 

  );

end AXI4_FIFO;

architecture AXI4_FIFO of AXI4_FIFO is


component fifo_generator_0 is
  Port ( 
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC);

end component;

begin
   AXI4_FIFO_wrapper  : component fifo_generator_0
   port map (
   
    m_aclk => m_aclk,
    s_aclk => s_aclk,
    s_aresetn => s_aresetn,
    
    
    s_axi_araddr  => AXI_RX_MOSI.araddr,
    s_axi_arlen => AXI_RX_MOSI.arlen,
    s_axi_arsize => AXI_RX_MOSI.arsize,
    s_axi_arburst  => AXI_RX_MOSI.arburst,
    s_axi_arlock => (others => '0'),
    s_axi_arcache => AXI_RX_MOSI.arcache,
    s_axi_arprot => AXI_RX_MOSI.arprot,
    s_axi_arqos => (others => '0'),
    s_axi_arregion => (others => '0'),
    s_axi_arvalid => AXI_RX_MOSI.arvalid,
    s_axi_arready => AXI_RX_MISO.arready,
    s_axi_rdata => AXI_RX_MISO.rdata,
    s_axi_rresp => AXI_RX_MISO.rresp,
    s_axi_rlast => AXI_RX_MISO.rlast,
    s_axi_rvalid => AXI_RX_MISO.rvalid,
    s_axi_rready  => AXI_RX_MOSI.rready,    
    
    m_axi_araddr  => AXI_TX_MOSI.araddr,
    m_axi_arlen => AXI_TX_MOSI.arlen,
    m_axi_arsize => AXI_TX_MOSI.arsize,
    m_axi_arburst  => AXI_TX_MOSI.arburst,
    m_axi_arlock => open,
    m_axi_arcache => AXI_TX_MOSI.arcache,
    m_axi_arprot => AXI_TX_MOSI.arprot,
    m_axi_arqos => open,
    m_axi_arregion => open,
    m_axi_arvalid => AXI_TX_MOSI.arvalid,
    m_axi_arready => AXI_TX_MISO.arready,
    m_axi_rdata => AXI_TX_MISO.rdata,
    m_axi_rresp => AXI_TX_MISO.rresp,
    m_axi_rlast => AXI_TX_MISO.rlast,
    m_axi_rvalid => AXI_TX_MISO.rvalid,
    m_axi_rready  => AXI_TX_MOSI.rready
    
   );
end;
