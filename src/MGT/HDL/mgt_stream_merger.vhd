 -------------------------------------------------------------------------------
--
-- Title       : mgt_stream_merger
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Wed Aug 15 07:58:26 2018
-- From        : interface description file
-- By          : Philippe Couture
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.Tel2000.all;
use work.calib_define.all;

entity mgt_stream_merger is 
   generic(
      MGT_2CH  : boolean := false 
   );
   port(
      RX_MOSI_DATA  : in  t_axi4_stream_mosi64;
      RX_MISO_DATA  : out t_axi4_stream_miso; 
      RX_MOSI_VIDEO  : in  t_axi4_stream_mosi64;
      RX_MISO_VIDEO  : out t_axi4_stream_miso;
      RX_MOSI_EXP  : in  t_axi4_stream_mosi128;
      RX_MISO_EXP  : out t_axi4_stream_miso; 
      
      TX_MOSI_DATA  : out  t_axi4_stream_mosi64;
      TX_MISO_DATA  : in t_axi4_stream_miso;
      TX_MOSI_VIDEO  : out  t_axi4_stream_mosi64;
      TX_MISO_VIDEO  : in t_axi4_stream_miso; 
      TX_MOSI_EXP  : out  t_axi4_stream_mosi128;
      TX_MISO_EXP  : in t_axi4_stream_miso;
      
      ARESETN  : in  std_logic;
      
      DATA_TX_RESET_DONE  : in  std_logic;
      VIDEO_TX_RESET_DONE  : in  std_logic;
      EXP_TX_RESET_DONE  : in  std_logic;  
      
      DATA_FIFO_OVFL : out  std_logic;
      VIDEO_FIFO_OVFL : out  std_logic;
      EXP_FIFO_OVFL : out  std_logic; 
      
      MBSDM : in STD_LOGIC_VECTOR(0 downto 0); -- Memory Buffer Sequence Download Mode

      DCLK      : in  std_logic;  
      TX_CLK      : in  std_logic;
      RX_CLK      : in  std_logic;  
      EXP_CLK      : in  std_logic
   );  
end mgt_stream_merger;

architecture rtl of mgt_stream_merger is

------------------------------------------------------------------------ 
-- Reset synchronization
   signal sresetn       : std_logic;
   
   component sync_resetn
      port(
         ARESETN : in std_logic;
         SRESETN : out std_logic;
         CLK    : in std_logic);
   end component; 
------------------------------------------------------------------------  
-- FWFT Fifo   

   signal tx_mosi_fifo_data : t_axi4_stream_mosi32;
   signal tx_miso_fifo_data : t_axi4_stream_miso;
   signal data_overflow    : std_logic;
   signal aresetn_data   : std_logic;
   
   signal tx_mosi_fifo_video : t_axi4_stream_mosi32;
   signal tx_miso_fifo_video : t_axi4_stream_miso; 
   signal video_overflow    : std_logic;
   signal aresetn_video   : std_logic;
   
   signal aresetn_exp   : std_logic;
   signal exp_overflow    : std_logic;
   
   component t_axi4_stream_wr64_rd32_fifo
   generic( 
   WR_FIFO_DEPTH : integer := 512;
   ASYNC          : boolean := false 
   );
   Port (  
      ARESETN  : in std_logic;
      RX_CLK   : in std_logic;
      RX_MOSI  : in t_axi4_stream_mosi64;
      RX_MISO  : out t_axi4_stream_miso;
      TX_CLK   : in std_logic;
      TX_MOSI  : out t_axi4_stream_mosi32;
      TX_MISO  : in t_axi4_stream_miso;
      OVFL     : out std_logic
         );
   end component; 
   
   
   component t_axi4_stream_wr64_rd64_fifo
   generic( 
   WR_FIFO_DEPTH : integer := 512;
   ASYNC          : boolean := false 
   );
   Port (  
      ARESETN  : in std_logic;
      RX_CLK   : in std_logic;
      RX_MOSI  : in t_axi4_stream_mosi64;
      RX_MISO  : out t_axi4_stream_miso;
      TX_CLK   : in std_logic;
      TX_MOSI  : out t_axi4_stream_mosi64;
      TX_MISO  : in t_axi4_stream_miso;
      OVFL     : out std_logic
         );
   end component;
   
   component t_axi4_stream_wr128_rd128_fifo
   generic( 
   WR_FIFO_DEPTH : integer := 512;
   ASYNC          : boolean := false 
   );
   Port (  
      ARESETN  : in std_logic;
      RX_CLK   : in std_logic;
      RX_MOSI  : in t_axi4_stream_mosi128;
      RX_MISO  : out t_axi4_stream_miso;
      TX_CLK   : in std_logic;
      TX_MOSI  : out t_axi4_stream_mosi128;
      TX_MISO  : in t_axi4_stream_miso;
      OVFL     : out std_logic
         );
   end component;
------------------------------------------------------------------------ 
-- Axis stream combiner (32 -> 64)
   
   signal rx_mosi_combiner        : t_axi4_stream_mosi32;
   signal rx_miso_combiner        : t_axi4_stream_miso;
   
   signal cmbr_rx_tvalid  : STD_LOGIC_VECTOR ( 1 downto 0 );
   signal cmbr_rx_tdata  : STD_LOGIC_VECTOR ( 63 downto 0 );
   signal cmbr_rx_tkeep  : STD_LOGIC_VECTOR ( 7 downto 0 );
   signal cmbr_rx_tlast  : STD_LOGIC_VECTOR ( 1 downto 0 ); 
   signal cmbr_rx_tready  : STD_LOGIC_VECTOR ( 1 downto 0 ); 
          
  component axis32_to_64_combiner
   Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tlast : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC
   );
  end component;
begin  

   merge_streams : 
   if MGT_2CH = false generate
   begin 
      
      aresetn_data <= ARESETN and DATA_TX_RESET_DONE;
      DATA_FIFO_OVFL <= data_overflow;
      VIDEO_FIFO_OVFL <= video_overflow;
      
      --MGT video stream is disabled
      TX_MOSI_VIDEO.TVALID <='0';
      TX_MOSI_VIDEO.TDATA <=  (others => '0');
      TX_MOSI_VIDEO.TKEEP <=  (others => '0');
      TX_MOSI_VIDEO.TSTRB <= (others => '0');
      TX_MOSI_VIDEO.TID <= (others => '0');
      TX_MOSI_VIDEO.TDEST <= (others => '0');
      TX_MOSI_VIDEO.TUSER <= (others => '0');
      TX_MOSI_VIDEO.TLAST <=  '0';

      -- Reset synchronization  
      U1: sync_resetn
      port map(
      ARESETN => ARESETN,
      CLK    => TX_CLK,
      SRESETN => sresetn
      ); 

      -- Fifo for calibrated data stream   
       DATA_FIFO : t_axi4_stream_wr64_rd32_fifo
       generic map (WR_FIFO_DEPTH => 512, ASYNC => true)
       port map(
            ARESETN  => aresetn_data,
            -- slave side (write channel only)
            RX_CLK   => RX_CLK,
            RX_MOSI  => RX_MOSI_DATA,
            RX_MISO  => RX_MISO_DATA,
            -- master side 
            TX_CLK   => TX_CLK,
            TX_MOSI   => tx_mosi_fifo_data,
            TX_MISO   => tx_miso_fifo_data,
            -- overflow
            OVFL    => data_overflow
       );                                             

       -- Fifo for video stream       
       VIDEO_FIFO : t_axi4_stream_wr64_rd32_fifo  
       generic map (WR_FIFO_DEPTH => 512, ASYNC => true)
       port map(
            ARESETN  => aresetn_data,
            -- slave side (write channel only)
            RX_CLK   => RX_CLK,
            RX_MOSI  => RX_MOSI_VIDEO,
            RX_MISO  => RX_MISO_VIDEO,
            -- master side 
            TX_CLK   => TX_CLK,
            TX_MOSI   => tx_mosi_fifo_video,
            TX_MISO   => tx_miso_fifo_video,
            -- overflow
            OVFL    => video_overflow
       ); 
       
       
      -- Axis stream combiner (32 -> 64)  
       COMBINER : axis32_to_64_combiner
       port map(
          aclk => TX_CLK,
          aresetn => sresetn,
          s_axis_tvalid => cmbr_rx_tvalid,
          s_axis_tready => cmbr_rx_tready,
          s_axis_tdata => cmbr_rx_tdata,
          s_axis_tkeep => cmbr_rx_tkeep,
          s_axis_tlast => cmbr_rx_tlast,
          
          m_axis_tvalid => TX_MOSI_DATA.TVALID,
          m_axis_tready => TX_MISO_DATA.TREADY,
          m_axis_tdata => TX_MOSI_DATA.TDATA,
          m_axis_tkeep => TX_MOSI_DATA.TKEEP,
          m_axis_tlast => TX_MOSI_DATA.TLAST
       ); 
       
      tx_miso_fifo_data.TREADY <= cmbr_rx_tready(0);
      tx_miso_fifo_video.TREADY <= cmbr_rx_tready(1);
      
      cmbr_rx_tvalid(0) <= tx_mosi_fifo_data.TVALID;
      cmbr_rx_tvalid(1) <= tx_mosi_fifo_video.TVALID when MBSDM(0) = '0' else tx_mosi_fifo_data.TVALID; 
      
      cmbr_rx_tdata(31 downto  0) <= tx_mosi_fifo_data.TDATA; 
      cmbr_rx_tdata(63 downto  32) <= tx_mosi_fifo_video.TDATA when MBSDM(0) = '0' else (others => '0');   
      
      
      cmbr_rx_tkeep(3 downto  0) <= tx_mosi_fifo_data.TKEEP; 
      cmbr_rx_tkeep(7 downto  4) <= tx_mosi_fifo_video.TKEEP when MBSDM(0) = '0' else tx_mosi_fifo_data.TKEEP;  
         
      cmbr_rx_tlast(0) <= tx_mosi_fifo_data.TLAST;
      cmbr_rx_tlast(1) <= tx_mosi_fifo_video.TLAST when MBSDM(0) = '0' else tx_mosi_fifo_data.TLAST;    
      

   end generate;
   
   dont_merge_streams : 
   if MGT_2CH = true generate
   begin   
      
       aresetn_data <= ARESETN and DATA_TX_RESET_DONE;
       DATA_FIFO_OVFL <= data_overflow;
    
    
       aresetn_video <= ARESETN and VIDEO_TX_RESET_DONE; 
       VIDEO_FIFO_OVFL <= video_overflow;
       
      
      

       -- Fifo for calibrated data stream   
       DATA_FIFO : t_axi4_stream_wr64_rd64_fifo
       generic map (WR_FIFO_DEPTH => 512, ASYNC => true)
       port map(
            ARESETN  => aresetn_data,
            -- slave side (write channel only)
            RX_CLK   => RX_CLK,
            RX_MOSI  => RX_MOSI_DATA,
            RX_MISO  => RX_MISO_DATA,
            -- master side 
            TX_CLK   => TX_CLK,
            TX_MOSI   => TX_MOSI_DATA,
            TX_MISO   => TX_MISO_DATA,
            -- overflow
            OVFL    => data_overflow
       );
       

       -- Fifo for video stream       
       VIDEO_FIFO : t_axi4_stream_wr64_rd64_fifo  
       generic map (WR_FIFO_DEPTH => 512, ASYNC => true)
       port map(
            ARESETN  => aresetn_video,
            -- slave side (write channel only)
            RX_CLK   => RX_CLK,
            RX_MOSI  => RX_MOSI_VIDEO,
            RX_MISO  => RX_MISO_VIDEO,
            -- master side 
            TX_CLK   => TX_CLK,
            TX_MOSI   => TX_MOSI_VIDEO,
            TX_MISO   => TX_MISO_VIDEO,
            -- overflow
            OVFL    => video_overflow
       );   
       end generate; 
       
       aresetn_exp <= ARESETN and EXP_TX_RESET_DONE;
       EXP_FIFO_OVFL <= exp_overflow; 
    
           -- Fifo for exp     
       EXP_FIFO : t_axi4_stream_wr128_rd128_fifo  
       generic map (WR_FIFO_DEPTH => 512, ASYNC => true)
       port map(
            ARESETN  => aresetn_exp,
            -- slave side (write channel only)
            RX_CLK   => DCLK,
            RX_MOSI  => RX_MOSI_EXP,
            RX_MISO  => RX_MISO_EXP,
            -- master side 
            TX_CLK   => EXP_CLK,
            TX_MOSI   => TX_MOSI_EXP,
            TX_MISO   => TX_MISO_EXP,
            -- overflow
            OVFL    => exp_overflow
       );
       

       
 end rtl;
