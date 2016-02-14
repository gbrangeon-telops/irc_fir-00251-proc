----------------------------------------------------------------
--!   @file XADC_wrapper.vhd
--!   @brief Wrapper for the XADC.
--!   @details This component package the XADC Core.
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

entity XADC_wrapper is
port(

   ACLK : in std_logic; --! Clock for core logic
   ARESETN : in std_logic; --! Reset active low for core logic
   
   XADC_MOSI : in t_axi4_lite_mosi;
   XADC_MISO : out t_axi4_lite_miso
   
   );
end XADC_wrapper;

architecture RTL of XADC_wrapper is

	component core_xadc_wiz_1_0
	port(
		s_axi_aclk : in STD_LOGIC;
		s_axi_aresetn : in STD_LOGIC;
		s_axi_awaddr : in STD_LOGIC_VECTOR(10 downto 0);
		s_axi_awvalid : in STD_LOGIC;
		s_axi_awready : out STD_LOGIC;
		s_axi_wdata : in STD_LOGIC_VECTOR(31 downto 0);
		s_axi_wstrb : in STD_LOGIC_VECTOR(3 downto 0);
		s_axi_wvalid : in STD_LOGIC;
		s_axi_wready : out STD_LOGIC;
		s_axi_bresp : out STD_LOGIC_VECTOR(1 downto 0);
		s_axi_bvalid : out STD_LOGIC;
		s_axi_bready : in STD_LOGIC;
		s_axi_araddr : in STD_LOGIC_VECTOR(10 downto 0);
		s_axi_arvalid : in STD_LOGIC;
		s_axi_arready : out STD_LOGIC;
		s_axi_rdata : out STD_LOGIC_VECTOR(31 downto 0);
		s_axi_rresp : out STD_LOGIC_VECTOR(1 downto 0);
		s_axi_rvalid : out STD_LOGIC;
		s_axi_rready : in STD_LOGIC;
		ip2intc_irpt : out STD_LOGIC;
		busy_out : out STD_LOGIC;
		channel_out : out STD_LOGIC_VECTOR(4 downto 0);
		eoc_out : out STD_LOGIC;
		eos_out : out STD_LOGIC;
		ot_out : out STD_LOGIC;
		vccaux_alarm_out : out STD_LOGIC;
		vccint_alarm_out : out STD_LOGIC;
		user_temp_alarm_out : out STD_LOGIC;
		alarm_out : out STD_LOGIC;
		muxaddr_out : out STD_LOGIC_VECTOR(4 downto 0);
		temp_out : out STD_LOGIC_VECTOR(11 downto 0);
		vp_in : in STD_LOGIC;
		vn_in : in STD_LOGIC);
	end component;
 
   

begin

XADC : core_xadc_wiz_1_0
   port map(
      s_axi_aclk => ACLK,
      s_axi_aresetn => ARESETN,
      s_axi_awaddr => XADC_MOSI.awaddr(10 downto 0),
      s_axi_awvalid => XADC_MOSI.awvalid,
      s_axi_awready => XADC_MISO.awready,
      s_axi_wdata => XADC_MOSI.wdata,
      s_axi_wstrb => XADC_MOSI.wstrb,
      s_axi_wvalid => XADC_MOSI.wvalid,
      s_axi_wready => XADC_MISO.wready,
      s_axi_bresp => XADC_MISO.bresp,
      s_axi_bvalid => XADC_MISO.bvalid,
      s_axi_bready => XADC_MOSI.bready,
      s_axi_araddr => XADC_MOSI.araddr(10 downto 0),
      s_axi_arvalid => XADC_MOSI.arvalid,
      s_axi_arready => XADC_MISO.arready,
      s_axi_rdata => XADC_MISO.rdata,
      s_axi_rresp => XADC_MISO.rresp,
      s_axi_rvalid => XADC_MISO.rvalid,
      s_axi_rready => XADC_MOSI.rready,
      ip2intc_irpt => open,
      busy_out => open,
      channel_out => open,
      eoc_out => open,
      eos_out => open,
      ot_out => open,
      vccaux_alarm_out => open,
      vccint_alarm_out => open,
      user_temp_alarm_out => open,
      alarm_out => open,
      muxaddr_out => open,
      temp_out => open,
      vp_in => '0',
      vn_in => '0'
   );

end RTL;