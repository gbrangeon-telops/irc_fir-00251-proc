-------------------------------------------------------------------------------
--
-- Title       : data_mover_wrapper
-- Design      : tb_frame_buffer
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\data_mover_wrapper.vhd
-- Generated   : Mon Aug 10 13:36:32 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.TEL2000.all;

entity data_mover_wrapper is
   Port ( 
   
    m_axi_mm2s_aclk            : in STD_LOGIC;
    m_axi_mm2s_aresetn         : in STD_LOGIC;
    mm2s_err                   : out STD_LOGIC;
    m_axis_mm2s_cmdsts_aclk    : in STD_LOGIC;
    m_axis_mm2s_cmdsts_aresetn : in STD_LOGIC;
    
    AXIS_MM2S_CMD_MOSI         : in t_axi4_stream_mosi_cmd32;
    AXIS_MM2S_CMD_MISO         : out t_axi4_stream_miso;

    AXIS_MM2S_STS_MOSI         : out t_axi4_stream_mosi_status;
    AXIS_MM2S_STS_MISO         : in t_axi4_stream_miso; 
    
    AXI_MM2S_DATA_MOSI         : out t_axi4_a32_d128_mosi;
    AXI_MM2S_DATA_MISO         : in t_axi4_a32_d128_miso;
    
    AXIS_MM2S_DATA_MOSI        : out t_axi4_stream_mosi64;
    AXIS_MM2S_DATA_MISO        : in t_axi4_stream_miso;

    m_axi_s2mm_aclk            : in STD_LOGIC;
    m_axi_s2mm_aresetn         : in STD_LOGIC;
    s2mm_err                   : out STD_LOGIC;
    m_axis_s2mm_cmdsts_awclk   : in STD_LOGIC;
    m_axis_s2mm_cmdsts_aresetn : in STD_LOGIC;
 
    AXIS_S2MM_CMD_MOSI         : in t_axi4_stream_mosi_cmd32;   
    AXIS_S2MM_CMD_MISO         : out t_axi4_stream_miso;

    AXIS_S2MM_STS_MOSI         : out t_axi4_stream_mosi_status;
    AXIS_S2MM_STS_MISO         : in t_axi4_stream_miso;

    AXI_S2MM_DATA_MOSI         : out t_axi4_a32_d128_mosi;
    AXI_S2MM_DATA_MISO         : in t_axi4_a32_d128_miso;
    
    AXIS_S2MM_DATA_MOSI        : in t_axi4_stream_mosi64;
    AXIS_S2MM_DATA_MISO        : out t_axi4_stream_miso

   );
end data_mover_wrapper;

--}} End of automatically maintained section

architecture data_mover_wrapper of data_mover_wrapper is

 component datamover_frame_buffer is
   port (
    m_axi_mm2s_aclk             : in STD_LOGIC;
    m_axi_mm2s_aresetn          : in STD_LOGIC;
    mm2s_err                    : out STD_LOGIC;
    m_axis_mm2s_cmdsts_aclk     : in STD_LOGIC;
    m_axis_mm2s_cmdsts_aresetn  : in STD_LOGIC; 
    s_axis_mm2s_cmd_tvalid      : in STD_LOGIC;
    s_axis_mm2s_cmd_tready      : out STD_LOGIC;
    s_axis_mm2s_cmd_tdata       : in STD_LOGIC_VECTOR ( 71 downto 0 );
    m_axis_mm2s_sts_tvalid      : out STD_LOGIC;
    m_axis_mm2s_sts_tready      : in STD_LOGIC;
    m_axis_mm2s_sts_tdata       : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_mm2s_sts_tkeep       : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_mm2s_sts_tlast       : out STD_LOGIC; 
    
    
    --m_axi_mm2s_arid             : out STD_LOGIC_VECTOR ( 0 downto 0 );
    m_axi_mm2s_araddr           : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen            : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize           : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst          : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot           : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache          : out STD_LOGIC_VECTOR ( 3 downto 0 );
    
    m_axi_mm2s_aruser           : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid          : out STD_LOGIC;
    m_axi_mm2s_arready          : in STD_LOGIC;
    
    m_axi_mm2s_rdata            : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_mm2s_rresp            : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast            : in STD_LOGIC;
    m_axi_mm2s_rvalid           : in STD_LOGIC;
    m_axi_mm2s_rready           : out STD_LOGIC;
    
    m_axis_mm2s_tdata           : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_mm2s_tkeep           : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_mm2s_tlast           : out STD_LOGIC;
    m_axis_mm2s_tvalid          : out STD_LOGIC;
    m_axis_mm2s_tready          : in STD_LOGIC;
    
    
    m_axi_s2mm_aclk             : in STD_LOGIC;
    m_axi_s2mm_aresetn          : in STD_LOGIC;
    s2mm_err                    : out STD_LOGIC;
    m_axis_s2mm_cmdsts_awclk    : in STD_LOGIC;
    m_axis_s2mm_cmdsts_aresetn  : in STD_LOGIC;  
    s_axis_s2mm_cmd_tvalid      : in STD_LOGIC;
    s_axis_s2mm_cmd_tready      : out STD_LOGIC;
    s_axis_s2mm_cmd_tdata       : in STD_LOGIC_VECTOR ( 71 downto 0 );
    m_axis_s2mm_sts_tvalid      : out STD_LOGIC;
    m_axis_s2mm_sts_tready      : in STD_LOGIC;
    m_axis_s2mm_sts_tdata       : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_s2mm_sts_tkeep       : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_s2mm_sts_tlast       : out STD_LOGIC;
   
    m_axi_s2mm_awaddr           : out STD_LOGIC_VECTOR ( 31 downto 0 );
    --m_axi_s2mm_awid             : out STD_LOGIC_VECTOR ( 0 downto 0 );
    m_axi_s2mm_awlen            : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_s2mm_awsize           : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_s2mm_awburst          : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_s2mm_awprot           : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_s2mm_awcache          : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    m_axi_s2mm_awuser           : out STD_LOGIC_VECTOR ( 3 downto 0 );-- non défini sur le ctler bram
    m_axi_s2mm_awvalid          : out STD_LOGIC;
    m_axi_s2mm_awready          : in STD_LOGIC;
    m_axi_s2mm_wdata            : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_s2mm_wstrb            : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axi_s2mm_wlast            : out STD_LOGIC;
    m_axi_s2mm_wvalid           : out STD_LOGIC;
    m_axi_s2mm_wready           : in STD_LOGIC;
    m_axi_s2mm_bresp            : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_s2mm_bvalid           : in STD_LOGIC;
    m_axi_s2mm_bready           : out STD_LOGIC;
    
    s_axis_s2mm_tdata           : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_s2mm_tkeep           : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_s2mm_tlast           : in STD_LOGIC;
    s_axis_s2mm_tvalid          : in STD_LOGIC;
    s_axis_s2mm_tready          : out STD_LOGIC);
   end component;
   
   
begin
   
   --AXI_S2MM_DATA_MOSI.arid <= (others => '0');
   AXI_S2MM_DATA_MOSI.araddr <= (others => '0');
   AXI_S2MM_DATA_MOSI.arlen <= (others => '0');
   AXI_S2MM_DATA_MOSI.arsize <= (others => '0');
   AXI_S2MM_DATA_MOSI.arburst <= (others => '0');
   AXI_S2MM_DATA_MOSI.arprot <= (others => '0');
   AXI_S2MM_DATA_MOSI.arcache <= (others => '0');
   AXI_S2MM_DATA_MOSI.arvalid <= '0';
   AXI_S2MM_DATA_MOSI.rready <= '0';

   
   --AXI_MM2S_DATA_MOSI.awid <= (others => '0');
   AXI_MM2S_DATA_MOSI.awaddr <= (others => '0');
   AXI_MM2S_DATA_MOSI.awlen <= (others => '0');
   AXI_MM2S_DATA_MOSI.awsize <= (others => '0');
   AXI_MM2S_DATA_MOSI.awburst <= (others => '0');
   AXI_MM2S_DATA_MOSI.awprot <= (others => '0');
   AXI_MM2S_DATA_MOSI.awcache <= (others => '0');
   AXI_MM2S_DATA_MOSI.awvalid <= '0';
   
   AXI_MM2S_DATA_MOSI.wdata <= (others => '0');
   AXI_MM2S_DATA_MOSI.wstrb <= (others => '0');
   AXI_MM2S_DATA_MOSI.wlast <= '0';
   AXI_MM2S_DATA_MOSI.wvalid <= '0'; 
   AXI_MM2S_DATA_MOSI.bready <= '0';
   
   data_mover_wrapper_i : component datamover_frame_buffer
   port map (	  
   
   m_axi_mm2s_aclk             => m_axi_mm2s_aclk,
   m_axi_mm2s_aresetn          => m_axi_mm2s_aresetn,
   mm2s_err                    => mm2s_err,
   m_axis_mm2s_cmdsts_aclk     => m_axis_mm2s_cmdsts_aclk,
   m_axis_mm2s_cmdsts_aresetn  => m_axis_mm2s_cmdsts_aresetn,
   
   -- AXI-STREAM - Read path command channel 
   s_axis_mm2s_cmd_tvalid      =>   AXIS_MM2S_CMD_MOSI.TVALID,
   s_axis_mm2s_cmd_tdata       =>   AXIS_MM2S_CMD_MOSI.TDATA,
   s_axis_mm2s_cmd_tready      =>   AXIS_MM2S_CMD_MISO.TREADY,
  
   -- AXI-STREAM  - Read path status channel 
   m_axis_mm2s_sts_tvalid     => AXIS_MM2S_STS_MOSI.TVALID,
   m_axis_mm2s_sts_tdata      => AXIS_MM2S_STS_MOSI.TDATA,
   m_axis_mm2s_sts_tlast      => AXIS_MM2S_STS_MOSI.TLAST,
   m_axis_mm2s_sts_tkeep      => AXIS_MM2S_STS_MOSI.TKEEP,
   m_axis_mm2s_sts_tready     => AXIS_MM2S_STS_MISO.TREADY,
   
   -- AXI4-FULL - Read address channel (mosi)
   --m_axi_mm2s_arid            => AXI_MM2S_DATA_MOSI.arid(0 downto 0),
   m_axi_mm2s_araddr          => AXI_MM2S_DATA_MOSI.araddr,
   m_axi_mm2s_arlen           => AXI_MM2S_DATA_MOSI.arlen,
   m_axi_mm2s_arsize          => AXI_MM2S_DATA_MOSI.arsize,
   m_axi_mm2s_arburst         => AXI_MM2S_DATA_MOSI.arburst,
   m_axi_mm2s_arprot          => AXI_MM2S_DATA_MOSI.arprot,
   --m_axi_mm2s_arprot          => (others => '0'),
   m_axi_mm2s_arcache         => AXI_MM2S_DATA_MOSI.arcache,
   m_axi_mm2s_arvalid         => AXI_MM2S_DATA_MOSI.arvalid,

   
   
   
   -- AXI4-FULL - Read address channel(miso)
   m_axi_mm2s_arready         => AXI_MM2S_DATA_MISO.arready,
  
   -- AXI4-FULL - Read data channel (miso)
   m_axi_mm2s_rdata           => AXI_MM2S_DATA_MISO.rdata,
   m_axi_mm2s_rresp           => AXI_MM2S_DATA_MISO.rresp,
   m_axi_mm2s_rlast           => AXI_MM2S_DATA_MISO.rlast,
   m_axi_mm2s_rvalid          => AXI_MM2S_DATA_MISO.rvalid,

   
   
   -- AXI4-FULL - Read data channel (mosi)
   m_axi_mm2s_rready          => AXI_MM2S_DATA_MOSI.rready,
   
   -- AXI-STREAM - Read data path (mosi)
   m_axis_mm2s_tdata          => AXIS_MM2S_DATA_MOSI.TDATA,
   m_axis_mm2s_tvalid         => AXIS_MM2S_DATA_MOSI.TVALID,
   m_axis_mm2s_tlast          => AXIS_MM2S_DATA_MOSI.TLAST,
   m_axis_mm2s_tkeep          => AXIS_MM2S_DATA_MOSI.TKEEP,
   -- AXI-STREAM - Read data path (miso)
   m_axis_mm2s_tready         => AXIS_MM2S_DATA_MISO.TREADY,

   m_axi_s2mm_aclk            => m_axi_s2mm_aclk,
   m_axi_s2mm_aresetn         => m_axi_s2mm_aresetn,
   s2mm_err                   => s2mm_err,
   m_axis_s2mm_cmdsts_awclk   => m_axis_s2mm_cmdsts_awclk,
   m_axis_s2mm_cmdsts_aresetn => m_axis_s2mm_cmdsts_aresetn,
    
   -- AXI-STREAM  - Write path command channel      
   s_axis_s2mm_cmd_tvalid     => AXIS_S2MM_CMD_MOSI.TVALID,
   s_axis_s2mm_cmd_tdata      => AXIS_S2MM_CMD_MOSI.TDATA,
   s_axis_s2mm_cmd_tready     => AXIS_S2MM_CMD_MISO.TREADY,
   
   -- AXI-STREAM  - Write path status channel     
   m_axis_s2mm_sts_tvalid     => AXIS_S2MM_STS_MOSI.TVALID,
   m_axis_s2mm_sts_tdata      => AXIS_S2MM_STS_MOSI.TDATA,
   m_axis_s2mm_sts_tlast      => AXIS_S2MM_STS_MOSI.TLAST,
   m_axis_s2mm_sts_tkeep      => AXIS_S2MM_STS_MOSI.TKEEP,
   m_axis_s2mm_sts_tready     => AXIS_S2MM_STS_MISO.TREADY,
   
   -- AXI4-FULL - Write address channel (mosi)
   --m_axi_s2mm_awid            => AXI_S2MM_DATA_MOSI.awid(0 downto 0),
   m_axi_s2mm_awaddr          => AXI_S2MM_DATA_MOSI.awaddr,
   m_axi_s2mm_awlen           => AXI_S2MM_DATA_MOSI.awlen,
   m_axi_s2mm_awsize          => AXI_S2MM_DATA_MOSI.awsize,
   m_axi_s2mm_awburst         => AXI_S2MM_DATA_MOSI.awburst,
   m_axi_s2mm_awprot          => AXI_S2MM_DATA_MOSI.awprot,
   m_axi_s2mm_awcache         => AXI_S2MM_DATA_MOSI.awcache,
   m_axi_s2mm_awvalid         => AXI_S2MM_DATA_MOSI.awvalid,
   
   -- AXI4-FULL - Write address channel (miso)
   m_axi_s2mm_awready         => AXI_S2MM_DATA_MISO.awready,
  
   -- AXI4-FULL - Write data channel (mosi)
   m_axi_s2mm_wdata           => AXI_S2MM_DATA_MOSI.wdata,
   m_axi_s2mm_wstrb           => AXI_S2MM_DATA_MOSI.wstrb,
   m_axi_s2mm_wlast           => AXI_S2MM_DATA_MOSI.wlast,
   m_axi_s2mm_wvalid          => AXI_S2MM_DATA_MOSI.wvalid,  
   
   -- AXI4-FULL - Write data channel (miso)
   m_axi_s2mm_wready          => AXI_S2MM_DATA_MISO.wready,
   
   -- AXI4-FULL - Write response channel (mosi)
   m_axi_s2mm_bready          => AXI_S2MM_DATA_MOSI.bready,
   
   -- AXI4-FULL - Write response channel (miso)
   m_axi_s2mm_bresp           => AXI_S2MM_DATA_MISO.bresp,
   m_axi_s2mm_bvalid          => AXI_S2MM_DATA_MISO.bvalid,
   
   -- AXI-STREAM - Write data path (mosi)
   s_axis_s2mm_tdata         => AXIS_S2MM_DATA_MOSI.TDATA,
   s_axis_s2mm_tvalid        => AXIS_S2MM_DATA_MOSI.TVALID,
   s_axis_s2mm_tlast         => AXIS_S2MM_DATA_MOSI.TLAST,
   s_axis_s2mm_tkeep         => AXIS_S2MM_DATA_MOSI.TKEEP,
   
   -- AXI-STREAM - Write data path (miso)
   s_axis_s2mm_tready        => AXIS_S2MM_DATA_MISO.TREADY

      );

end data_mover_wrapper;
