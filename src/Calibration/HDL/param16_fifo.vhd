---------------------------------------------------------------------------------------------------
--  Copyright (c) Telops Inc. 2015
--
--  File: param_fifo.vhd
--  By: Olivier Dionne
--
--  $Revision: 17698 $
--  $Author: jboulet $
--  $LastChangedDate: 2015-12-15 15:21:03 -0500 (mar., 15 déc. 2015) $
--
---------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity param16_fifo is
    generic(
       fifo_size : integer := 16
    );
    port(
      -- General
      SYNC_MOSI     : in t_axi4_stream_mosi16;
      SYNC_MISO     : in t_axi4_stream_miso;
      CLK_DATA      : in std_logic;
      ARESETN       : in std_logic;
      
      ERROR         : out std_logic;

      -- Fifo-wise
      -- Write
      DIN0      : in std_logic_vector(31 downto 0);
      WR_EN0    : in std_logic;
      -- Read
      DOUT0         : out t_axi4_stream_mosi32;
      DOUT0_READY   : in t_axi4_stream_miso   
      
   );
end param16_fifo;

architecture rtl of param16_fifo is


   COMPONENT param_fifo_block
    generic(
       fifo_size : integer := 16
    );
    port(
       ARESETN : in STD_LOGIC;
       CLK_DATA : in STD_LOGIC;
       PARAM_WR_EN : in STD_LOGIC;
       PARAM_DATA : in STD_LOGIC_VECTOR(31 downto 0);
       PARAM_MISO : in t_axi4_stream_miso;
       SYNC_INPUT_MISO : in t_axi4_stream_miso;
       SYNC_INPUT_MOSI : in t_axi4_stream_mosi32;
       ERROR : out STD_LOGIC;
       PARAM_MOSI : out t_axi4_stream_mosi32
    );
    end component;

   --signal error_o         : STD_LOGIC_VECTOR(2 downto 0);
   signal sync_32_mosi    : t_axi4_stream_mosi32;

begin
   
    --ERROR <= error_o(1);
    sync_32_mosi.TVALID <= SYNC_MOSI.TVALID;
    sync_32_mosi.TLAST <= SYNC_MOSI.TLAST;

   
   blk_param_fifo0 : param_fifo_block
   generic map(
    fifo_size => fifo_size
   )
   PORT MAP (
         CLK_DATA => CLK_DATA,
         ARESETN => ARESETN,
         PARAM_DATA => DIN0,
         PARAM_WR_EN => WR_EN0,
         SYNC_INPUT_MOSI => sync_32_mosi,
         SYNC_INPUT_MISO => SYNC_MISO,
         PARAM_MOSI => DOUT0,
         PARAM_MISO => DOUT0_READY,
         ERROR => ERROR
   );

end rtl;

