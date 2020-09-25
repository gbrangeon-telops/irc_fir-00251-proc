------------------------------------------------------------------
--!   @file : scd_proxy2_bridge
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.FPA_Define.all;
use work.fpa_common_pkg.all;

entity scd_proxy2_bridge is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      
      RX_MOSI       : in t_ll_area_mosi72;
      RX_MISO       : out t_ll_area_miso;
      
      PIX_MOSI      : out t_ll_ext_mosi72;
      PIX_MISO      : in t_ll_ext_miso      
      );
end scd_proxy2_bridge;

architecture rtl of scd_proxy2_bridge is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   signal sreset			      : std_logic;
   
begin
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   sync_reset_map : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      ); 
   
   ------------------------------------------------------
   -- AOI
   ------------------------------------------------------ 
   PIX_MOSI.DATA <= RX_MOSI.DATA;
   PIX_MOSI.SOF  <= RX_MOSI.AOI_SOF;
   PIX_MOSI.EOF  <= RX_MOSI.AOI_EOF;
   PIX_MOSI.SOL  <= RX_MOSI.AOI_SOL;
   PIX_MOSI.EOL  <= RX_MOSI.AOI_EOL;
   PIX_MOSI.DVAL <= RX_MOSI.AOI_DVAL;
   PIX_MOSI.MISC <= '0'&RX_MOSI.AOI_SPARE;
   PIX_MOSI.SUPPORT_BUSY  <= RX_MOSI.SUPPORT_BUSY;
   RX_MISO.AFULL <= '0'; --PIX_MISO.AFULL;
   RX_MISO.BUSY  <= '0'; --PIX_MISO.BUSY;
      
end rtl;
