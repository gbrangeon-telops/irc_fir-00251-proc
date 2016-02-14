----------------------------------------------------------------
--!   @file INTC_wrapper.vhd
--!   @brief Wrapper for the Interrupt Controller.
--!   @details This component package the Interrupt Controller.
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

entity INTC_wrapper is
port(

   ACLK : in std_logic; --! Clock for core logic
   ARESETN : in std_logic; --! Reset active low for core logic
   PROCESSOR_CLK : in std_logic;
   PROCESSOR_RST : in std_logic;
   
   AXI4_LITE_MOSI : in t_axi4_lite_mosi;
   AXI4_LITE_MISO : out t_axi4_lite_miso;
   
   INTERRUPT : in std_logic_vector(7 downto 0);
   PROCESSOR_ACK : in std_logic_vector(1 downto 0);
   
   IRQ : out std_logic;
   
   INTERRUPT_ADDRESS : out std_logic_vector(31 downto 0)
   
   );
end INTC_wrapper;

architecture RTL of INTC_wrapper is

   -- Component declaration of the "core_microblaze_1_axi_intc_0(core_microblaze_1_axi_intc_0_arch)" unit defined in
   -- file: "./../../../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_microblaze_1_axi_intc_0/sim/core_microblaze_1_axi_intc_0.vhd"
   component core_microblaze_1_axi_intc_0
   port(
      s_axi_aclk : in STD_LOGIC;
      s_axi_aresetn : in STD_LOGIC;
      s_axi_awaddr : in STD_LOGIC_VECTOR(8 downto 0);
      s_axi_awvalid : in STD_LOGIC;
      s_axi_awready : out STD_LOGIC;
      s_axi_wdata : in STD_LOGIC_VECTOR(31 downto 0);
      s_axi_wstrb : in STD_LOGIC_VECTOR(3 downto 0);
      s_axi_wvalid : in STD_LOGIC;
      s_axi_wready : out STD_LOGIC;
      s_axi_bresp : out STD_LOGIC_VECTOR(1 downto 0);
      s_axi_bvalid : out STD_LOGIC;
      s_axi_bready : in STD_LOGIC;
      s_axi_araddr : in STD_LOGIC_VECTOR(8 downto 0);
      s_axi_arvalid : in STD_LOGIC;
      s_axi_arready : out STD_LOGIC;
      s_axi_rdata : out STD_LOGIC_VECTOR(31 downto 0);
      s_axi_rresp : out STD_LOGIC_VECTOR(1 downto 0);
      s_axi_rvalid : out STD_LOGIC;
      s_axi_rready : in STD_LOGIC;
      intr : in STD_LOGIC_VECTOR(7 downto 0);
      processor_clk : in STD_LOGIC;
      processor_rst : in STD_LOGIC;
      irq : out STD_LOGIC;
      processor_ack : in STD_LOGIC_VECTOR(1 downto 0);
      interrupt_address : out STD_LOGIC_VECTOR(31 downto 0));
   end component;

begin


INTC : core_microblaze_1_axi_intc_0
   port map(
      s_axi_aclk => ACLK,
      s_axi_aresetn => ARESETN,
      s_axi_awaddr => AXI4_LITE_MOSI.awaddr(8 downto 0),
      s_axi_awvalid => AXI4_LITE_MOSI.awvalid,
      s_axi_awready => AXI4_LITE_MISO.awready,
      s_axi_wdata => AXI4_LITE_MOSI.wdata,
      s_axi_wstrb => AXI4_LITE_MOSI.wstrb,
      s_axi_wvalid => AXI4_LITE_MOSI.wvalid,
      s_axi_wready => AXI4_LITE_MISO.wready,
      s_axi_bresp => AXI4_LITE_MISO.bresp,
      s_axi_bvalid => AXI4_LITE_MISO.bvalid,
      s_axi_bready => AXI4_LITE_MOSI.bready,
      s_axi_araddr => AXI4_LITE_MOSI.araddr(8 downto 0),
      s_axi_arvalid => AXI4_LITE_MOSI.arvalid,
      s_axi_arready => AXI4_LITE_MISO.arready,
      s_axi_rdata => AXI4_LITE_MISO.rdata,
      s_axi_rresp => AXI4_LITE_MISO.rresp,
      s_axi_rvalid => AXI4_LITE_MISO.rvalid,
      s_axi_rready => AXI4_LITE_MOSI.rready,
      intr => INTERRUPT,
      processor_clk => PROCESSOR_CLK,
      processor_rst => PROCESSOR_RST,
      irq => IRQ,
      processor_ack => PROCESSOR_ACK,
      interrupt_address => INTERRUPT_ADDRESS
   );
end RTL;