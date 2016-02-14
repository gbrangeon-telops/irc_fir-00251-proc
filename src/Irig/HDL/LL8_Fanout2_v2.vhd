-------------------------------------------------------------------------------
--
-- Title       : LL8_Fanout2_v2
-- Author      : Patrick
-- Company     : Telops/COPL
--
-------------------------------------------------------------------------------
--
-- Description : This module is used to create a fanout of 2 from one LocalLink
--               signal. The same signal can thus feed two receivers.
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.IRIG_define_v2.all;

entity LL8_Fanout2_v2 is
   generic(
      use_fifos   : boolean := false
      );
   port(
      RX_MOSI  : in  t_ll_mosi8;
      RX_MISO  : out t_ll_miso;
      
      TX1_MOSI : out t_ll_mosi8;
      TX1_MISO : in  t_ll_miso;
      
      TX2_MOSI : out t_ll_mosi8;
      TX2_MISO : in  t_ll_miso;
      
      ARESET   : in  STD_LOGIC;
      CLK      : in  STD_LOGIC
      );
end LL8_Fanout2_v2;

architecture RTL of LL8_Fanout2_v2 is
signal RX_BUSYi : std_logic; 
   signal fifo_ll_mosi : t_ll_mosi8;
   signal fifo1_ll_miso : t_ll_miso;
   signal fifo2_ll_miso : t_ll_miso;   
begin
   
   no_fifos : if not use_fifos generate            
      RX_MISO.AFULL <= TX1_MISO.AFULL or TX2_MISO.AFULL;
      RX_BUSYi <= TX1_MISO.BUSY or TX2_MISO.BUSY;
      RX_MISO.BUSY <= RX_BUSYi; 
      
      TX1_MOSI.SUPPORT_BUSY <= '1';
      TX1_MOSI.SOF <= RX_MOSI.SOF;
      TX1_MOSI.EOF <= RX_MOSI.EOF;
      TX1_MOSI.DATA <= RX_MOSI.DATA;
      --TX1_MOSI.DREM <= RX_MOSI.DREM;
      TX1_MOSI.DVAL <= RX_MOSI.DVAL and not RX_BUSYi;
      
      TX2_MOSI.SUPPORT_BUSY <= '1';
      TX2_MOSI.SOF <= RX_MOSI.SOF;
      TX2_MOSI.EOF <= RX_MOSI.EOF;
      TX2_MOSI.DATA <= RX_MOSI.DATA;
      --TX2_MOSI.DREM <= RX_MOSI.DREM;
      TX2_MOSI.DVAL <= RX_MOSI.DVAL and not RX_BUSYi;  
   end generate no_fifos;
   
     
   -- pragma translate_off 
   assert_proc : process(ARESET)
   begin       
      if ARESET = '0' then
         assert (RX_MOSI.SUPPORT_BUSY = '1') report "RX Upstream module must support the BUSY signal" severity FAILURE;          
      end if;
   end process;
   -- pragma translate_on   
   
end RTL;
