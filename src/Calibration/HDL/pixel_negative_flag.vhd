------------------------------------------------------------------
--!   @file : pixel_negative_flag
--!   @brief
--!   @details
--!
--!   $Rev: 20321 $
--!   $Author: odionne $
--!   $Date: 2017-04-10 16:00:05 -0400 (lun., 10 avr. 2017) $
--!   $Id: pixel_bpr_flag.vhd 20321 2017-04-10 20:00:05Z odionne $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/Calibration/HDL/pixel_bpr_flag.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity pixel_negative_flag is
   port(
      ARESETN    : in  std_logic;
      CLK        : in  std_logic;
      RX_MOSI    : in  t_axi4_stream_mosi32;
      RX_MISO    : out t_axi4_stream_miso;
      TX_MOSI    : out t_axi4_stream_mosi32;
      TX_MISO    : in t_axi4_stream_miso
      );
end pixel_negative_flag;


architecture RTL of pixel_negative_flag is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   signal pipe_rx_mosi           : t_axi4_stream_mosi32;
   signal sreset                 : std_logic;
   signal areset                 : std_logic;
   
begin
   
   RX_MISO <= TX_MISO;
   
   areset <= not ARESETN;
   
   U0 : sync_reset
   port map(ARESET => areset, SRESET => sreset, CLK => CLK);
   
   U1: process(CLK)
   begin
      if rising_edge(CLK) then
         
         if sreset = '1' then 
            pipe_rx_mosi.tvalid <= '0';
            TX_MOSI.TVALID <= '0';
            
         else
            
            if TX_MISO.TREADY = '1' then
               
               -- Pipe RX MOSI and check for negative value.
               -- Sign bit is most significant bit in IEEE 754 ('1' = negative, '0' = positive)
               pipe_rx_mosi <= RX_MOSI;
               if RX_MOSI.TDATA(RX_MOSI.TDATA'high) = '1' then
                  pipe_rx_mosi.tuser(TUSER_LDS_PIX_BIT) <= '1';   -- Flag pixel as LDS
               end if;
               
               -- Output pipe
               TX_MOSI <= pipe_rx_mosi;
               
            end if;
            
         end if;
         
      end if;
   end process;
   
end RTL;
