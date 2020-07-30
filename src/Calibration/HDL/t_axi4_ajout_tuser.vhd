------------------------------------------------------------------
--!   @file : t_axi4_ajout_tuser
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
use IEEE.numeric_std.all; 
use work.tel2000.all;

entity t_axi4_ajout_tuser is
   generic(                            
      FifoSize		   : integer := 16;     -- 
      ASYNC          : boolean := false);	-- Use asynchronous fifos
   
   port(
   	  ARESETN  : in std_logic;
      
      -- Input of fifo
      RX_CLK   : in std_logic;
      RX_MOSI  : in t_axi4_stream_mosi32;
      RX_MISO  : out t_axi4_stream_miso;
      
      -- Input of data
      RXA_CLK      : in std_logic;
      RXA_MOSI     : in t_axi4_stream_mosi32;
      RXA_MISO     : out t_axi4_stream_miso;
      
      -- Output of data with tuser of fifo
      TX_MOSI  : out t_axi4_stream_mosi32;
      TX_MISO  : in t_axi4_stream_miso;
      
      -- overflow
      OVFL     : out std_logic
      
      );
end t_axi4_ajout_tuser;

architecture rtl of t_axi4_ajout_tuser is
   
component t_axi4_stream32_fifo
   generic(                            
      FifoSize		   : integer := 16;     -- 
      ASYNC          : boolean := false);	-- Use asynchronous fifos
   
   port(
      ARESETN  : in std_logic;
      
      -- slave side (write channel only)
      RX_CLK   : in std_logic;
      RX_MOSI  : in t_axi4_stream_mosi32;
      RX_MISO  : out t_axi4_stream_miso;
      
      -- master side 
      TX_CLK   : in std_logic;
      TX_MOSI  : out t_axi4_stream_mosi32;
      TX_MISO  : in t_axi4_stream_miso;
      
      -- overflow
      OVFL     : out std_logic
      
      );
end component;

signal exchange_valid : std_logic;		 
signal fifo_valid : t_axi4_stream_miso;
signal fifo_out : t_axi4_stream_mosi32;	   
signal fifo_in : t_axi4_stream_mosi32;
   
begin

exchange_valid <= RXA_MOSI.TVALID and TX_MISO.TREADY;					 
fifo_valid.TREADY <= exchange_valid; 

RXA_MISO <= TX_MISO;
TX_MOSI.TVALID <= RXA_MOSI.TVALID;
TX_MOSI.TDATA <= RXA_MOSI.TDATA;
TX_MOSI.TSTRB <= RXA_MOSI.TSTRB;
TX_MOSI.TKEEP <= RXA_MOSI.TKEEP;
TX_MOSI.TLAST <= RXA_MOSI.TLAST;
TX_MOSI.TID <= RXA_MOSI.TID;
TX_MOSI.TDEST <= RXA_MOSI.TDEST;
TX_MOSI.TUSER <=fifo_out.TUSER;

fifo :  t_axi4_stream32_fifo
   generic map(                            
      FifoSize		   => FifoSize,
      ASYNC          => ASYNC)
   port map(
      ARESETN  => ARESETN,
      
      -- slave side (write channel only)
      RX_CLK   => RX_CLK,
      RX_MOSI  => RX_MOSI,
      RX_MISO  => RX_MISO,
      
      -- master side 
      TX_CLK   => RXA_CLK,
      TX_MOSI  => fifo_out,
      TX_MISO  => fifo_valid,
      
      -- overflow
      OVFL     => OVFL
      );
   
   
end rtl;
