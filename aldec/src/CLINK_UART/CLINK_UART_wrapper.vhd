----------------------------------------------------------------
--!   @file CLINK_UART_wrapper.vhd
--!   @brief Wrapper for the CLINK Uart.
--!   @details This component package the CLINK Uart.
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

library axi_uart16550_v1_01_a;
use axi_uart16550_v1_01_a.all;

entity CLINK_UART_wrapper is
port(

   ACLK : in std_logic; --! Clock for core logic
   ARESETN : in std_logic; --! Reset active low for core logic
   
   AXI4_LITE_MOSI : in t_axi4_lite_mosi;
   AXI4_LITE_MISO : out t_axi4_lite_miso;
   
   RX : in std_logic;
   TX : out std_logic;
   
   INTERRUPT : out std_logic
   
   );
end CLINK_UART_wrapper;

architecture RTL of CLINK_UART_wrapper is

   -- Component declaration of the "core_clink_uart_1(core_clink_uart_1_arch)" unit defined in
   -- file: "./../../../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_clink_uart_1/sim/core_clink_uart_1.vhd"
--   component core_clink_uart_1
--   port(
--      s_axi_aclk : in STD_LOGIC;
--      s_axi_aresetn : in STD_LOGIC;
--      ip2intc_irpt : out STD_LOGIC;
--      freeze : in STD_LOGIC;
--      s_axi_awaddr : in STD_LOGIC_VECTOR(12 downto 0);
--      s_axi_awvalid : in STD_LOGIC;
--      s_axi_awready : out STD_LOGIC;
--      s_axi_wdata : in STD_LOGIC_VECTOR(31 downto 0);
--      s_axi_wstrb : in STD_LOGIC_VECTOR(3 downto 0);
--      s_axi_wvalid : in STD_LOGIC;
--      s_axi_wready : out STD_LOGIC;
--      s_axi_bresp : out STD_LOGIC_VECTOR(1 downto 0);
--      s_axi_bvalid : out STD_LOGIC;
--      s_axi_bready : in STD_LOGIC;
--      s_axi_araddr : in STD_LOGIC_VECTOR(12 downto 0);
--      s_axi_arvalid : in STD_LOGIC;
--      s_axi_arready : out STD_LOGIC;
--      s_axi_rdata : out STD_LOGIC_VECTOR(31 downto 0);
--      s_axi_rresp : out STD_LOGIC_VECTOR(1 downto 0);
--      s_axi_rvalid : out STD_LOGIC;
--      s_axi_rready : in STD_LOGIC;
--      baudoutn : out STD_LOGIC;
--      ctsn : in STD_LOGIC;
--      dcdn : in STD_LOGIC;
--      ddis : out STD_LOGIC;
--      dsrn : in STD_LOGIC;
--      dtrn : out STD_LOGIC;
--      out1n : out STD_LOGIC;
--      out2n : out STD_LOGIC;
--      rin : in STD_LOGIC;
--      rtsn : out STD_LOGIC;
--      rxrdyn : out STD_LOGIC;
--      sin : in STD_LOGIC;
--      sout : out STD_LOGIC;
--      txrdyn : out STD_LOGIC);
--   end component;

	-- Component declaration of the "axi_uart16550(rtl)" unit defined in
	-- file: "./../../src/edk/hw/XilinxProcessorIPLib/pcores/axi_uart16550_v1_01_a/hdl/vhdl/axi_uart16550.vhd"
	component axi_uart16550
	generic(
		C_FAMILY : STRING := "virtex6";
		C_S_AXI_ACLK_FREQ_HZ : INTEGER := 100000000;
		C_S_AXI_ADDR_WIDTH : INTEGER := 13;
		C_S_AXI_DATA_WIDTH : INTEGER range 32 to 128 := 32;
		C_IS_A_16550 : INTEGER range 0 to 1 := 1;
		C_HAS_EXTERNAL_XIN : INTEGER range 0 to 1 := 0;
		C_HAS_EXTERNAL_RCLK : INTEGER range 0 to 1 := 0;
		C_EXTERNAL_XIN_CLK_HZ : INTEGER := 25000000;
		C_INSTANCE : STRING := "axi_uart16550_inst");
	port(
		S_AXI_ACLK : in STD_LOGIC;
		S_AXI_ARESETN : in STD_LOGIC;
		IP2INTC_Irpt : out STD_LOGIC;
		Freeze : in STD_LOGIC;
		S_AXI_AWADDR : in STD_LOGIC_VECTOR(12 downto 0);
		S_AXI_AWVALID : in STD_LOGIC;
		S_AXI_AWREADY : out STD_LOGIC;
		S_AXI_WDATA : in STD_LOGIC_VECTOR(31 downto 0);
		S_AXI_WSTRB : in STD_LOGIC_VECTOR(3 downto 0);
		S_AXI_WVALID : in STD_LOGIC;
		S_AXI_WREADY : out STD_LOGIC;
		S_AXI_BRESP : out STD_LOGIC_VECTOR(1 downto 0);
		S_AXI_BVALID : out STD_LOGIC;
		S_AXI_BREADY : in STD_LOGIC;
		S_AXI_ARADDR : in STD_LOGIC_VECTOR(12 downto 0);
		S_AXI_ARVALID : in STD_LOGIC;
		S_AXI_ARREADY : out STD_LOGIC;
		S_AXI_RDATA : out STD_LOGIC_VECTOR(31 downto 0);
		S_AXI_RRESP : out STD_LOGIC_VECTOR(1 downto 0);
		S_AXI_RVALID : out STD_LOGIC;
		S_AXI_RREADY : in STD_LOGIC;
		BaudoutN : out STD_LOGIC;
		CtsN : in STD_LOGIC;
		DcdN : in STD_LOGIC;
		Ddis : out STD_LOGIC;
		DsrN : in STD_LOGIC;
		DtrN : out STD_LOGIC;
		Out1N : out STD_LOGIC;
		Out2N : out STD_LOGIC;
		Rclk : in STD_LOGIC;
		RiN : in STD_LOGIC;
		RtsN : out STD_LOGIC;
		RxrdyN : out STD_LOGIC;
		Sin : in STD_LOGIC;
		Sout : out STD_LOGIC;
		TxrdyN : out STD_LOGIC;
		Xin : in STD_LOGIC;
		Xout : out STD_LOGIC);
	end component;
	--for all: axi_uart16550 use entity axi_uart16550_v1_01_a.axi_uart16550(rtl);


begin


UART : axi_uart16550
   port map(
      s_axi_aclk => ACLK,
      s_axi_aresetn => ARESETN,
      ip2intc_irpt => INTERRUPT,
      freeze => '0',
      s_axi_awaddr => AXI4_LITE_MOSI.awaddr(12 downto 0),
      s_axi_awvalid => AXI4_LITE_MOSI.awvalid,
      s_axi_awready => AXI4_LITE_MISO.awready,
      s_axi_wdata => AXI4_LITE_MOSI.wdata,
      s_axi_wstrb => AXI4_LITE_MOSI.wstrb,
      s_axi_wvalid => AXI4_LITE_MOSI.wvalid,
      s_axi_wready => AXI4_LITE_MISO.wready,
      s_axi_bresp => AXI4_LITE_MISO.bresp,
      s_axi_bvalid => AXI4_LITE_MISO.bvalid,
      s_axi_bready => AXI4_LITE_MOSI.bready,
      s_axi_araddr => AXI4_LITE_MOSI.araddr(12 downto 0),
      s_axi_arvalid => AXI4_LITE_MOSI.arvalid,
      s_axi_arready => AXI4_LITE_MISO.arready,
      s_axi_rdata => AXI4_LITE_MISO.rdata,
      s_axi_rresp => AXI4_LITE_MISO.rresp,
      s_axi_rvalid => AXI4_LITE_MISO.rvalid,
      s_axi_rready => AXI4_LITE_MOSI.rready,
      baudoutn => open,
      ctsn => '0',
      dcdn => '0',
      ddis => open,
      dsrn => '0',
      dtrn => open,
      out1n => open,
      out2n => open,
      rin => '0',
      rtsn => open,
      rxrdyn => open,
      sin => RX,
      sout => TX,
      Rclk => '0',
      Xin => '0',
      txrdyn => open
   );
end RTL;