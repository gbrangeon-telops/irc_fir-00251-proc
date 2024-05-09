------------------------------------------------------------------
--!   @file : calcium_clks_gen
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use WORK.TEL2000.all;

entity calcium_clks_gen is
   port (
      ARESET         : in std_logic;
      CLK_100M       : in std_logic;
      
      GLOBAL_RST     : out std_logic;
      CLK_DDR        : out std_logic;
      
      AXI_RSTN       : in  std_logic;
      AXI_CLK        : in  std_logic;
      AXI_MOSI       : in  t_axi4_lite_mosi;
      AXI_MISO       : out t_axi4_lite_miso
   );
end calcium_clks_gen;

architecture rtl of calcium_clks_gen is
   
   component rst_conditioner is
      generic (
         RESET_PULSE_DELAY : natural := 80; 
         RESET_PULSE_LEN   : natural := 9
      );
      port ( 
         ARESET      : in std_logic;
         SLOWEST_CLK : in std_logic;
         ORST        : out std_logic   
      );
   end component;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;

   component calciumD_clks_mmcm
      port (
         -- System interface
         s_axi_aclk      : in  std_logic;                                      
         s_axi_aresetn   : in  std_logic;                                      
         -- AXI Write address channel signals                                        
         s_axi_awaddr    : in  std_logic_vector(10 downto 0);                  
         s_axi_awvalid   : in  std_logic;                                      
         s_axi_awready   : out std_logic;                                      
         -- AXI Write data channel signals                                           
         s_axi_wdata     : in  std_logic_vector(31 downto 0);                  
         s_axi_wstrb     : in  std_logic_vector(3 downto 0);              
         s_axi_wvalid    : in  std_logic;                                      
         s_axi_wready    : out std_logic;                                      
         -- AXI Write response channel signals                                       
         s_axi_bresp     : out std_logic_vector(1 downto 0);                   
         s_axi_bvalid    : out std_logic;                                      
         s_axi_bready    : in  std_logic;                                      
         -- AXI Read address channel signals                                         
         s_axi_araddr    : in  std_logic_vector(10 downto 0);                  
         s_axi_arvalid   : in  std_logic;                                      
         s_axi_arready   : out std_logic;                                      
         -- AXI Read address channel signals                                         
         s_axi_rdata     : out std_logic_vector(31 downto 0);                  
         s_axi_rresp     : out std_logic_vector(1 downto 0);                   
         s_axi_rvalid    : out std_logic;                                      
         s_axi_rready    : in  std_logic;                                      
         -- Clock out ports
         clk_ddr         : out std_logic;
         -- Status and control signals
         locked          : out std_logic;
         -- Clock in ports
         clk_in          : in  std_logic
      );
   end component;
   
   signal sreset              : std_logic;
   signal cond_reset_in       : std_logic;
   signal mmcm_locked_i       : std_logic;
   
begin
   
   --------------------------------------------------
   -- Resets
   --------------------------------------------------   
   U1A : rst_conditioner
   generic map (
      RESET_PULSE_DELAY => 80,
      RESET_PULSE_LEN   => 9
   )
   port map (
      ARESET      => cond_reset_in,
      SLOWEST_CLK => CLK_100M,
      ORST        => GLOBAL_RST
   );
   cond_reset_in <= (not mmcm_locked_i) or sreset;
   
   U1B : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK_100M,
      SRESET => sreset
   );
   
   --------------------------------------------------
   -- Clock Wizard
   --------------------------------------------------
   U2 : calciumD_clks_mmcm
      port map (
         -- System interface
         s_axi_aclk    => AXI_CLK,
         s_axi_aresetn => AXI_RSTN,
         -- AXI Write address channel signals
         s_axi_awaddr  => AXI_MOSI.awaddr,
         s_axi_awvalid => AXI_MOSI.awvalid,
         s_axi_awready => AXI_MISO.awready,
         -- AXI Write data channel signals
         s_axi_wdata   => AXI_MOSI.wdata,
         s_axi_wstrb   => AXI_MOSI.wstrb,
         s_axi_wvalid  => AXI_MOSI.wvalid,
         s_axi_wready  => AXI_MISO.wready,
         -- AXI Write response channel signals
         s_axi_bresp   => AXI_MISO.bresp,
         s_axi_bvalid  => AXI_MISO.bvalid,
         s_axi_bready  => AXI_MOSI.bready,
         -- AXI Read address channel signals
         s_axi_araddr  => AXI_MOSI.araddr,
         s_axi_arvalid => AXI_MOSI.arvalid,
         s_axi_arready => AXI_MISO.arready,
         -- AXI Read address channel signals
         s_axi_rdata   => AXI_MISO.rdata,
         s_axi_rresp   => AXI_MISO.rresp,
         s_axi_rvalid  => AXI_MISO.rvalid,
         s_axi_rready  => AXI_MOSI.rready,
         -- Clock out ports
         clk_ddr       => CLK_DDR,
         -- Status and control signals
         locked        => mmcm_locked_i,
         -- Clock in ports
         clk_in        => CLK_100M
      );
   
end rtl;
