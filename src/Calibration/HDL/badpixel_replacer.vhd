-------------------------------------------------------------------------------
--
-- Title       : badpixel_replacer
-- Author      : Olivier Dionne
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author: odionne $
-- $LastChangedDate: 2015-04-28 17:31:53 -0400 (mar., 28 avr. 2015) $
-- $Revision: 15522 $ 
-------------------------------------------------------------------------------
--
-- Description : Replacement of the bad pixel tag
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.TEL2000.all;
use work.calib_define.all;

entity badpixel_replacer is
   port(
      CLK         : in  std_logic;
      ARESETN     : in  std_logic;
      REPL_MODE   : in  bpr_mode_type;
   
      RX_MOSI     : in  t_axi4_stream_mosi16;      
      RX_MISO     : out t_axi4_stream_miso;  
      
      TX_MOSI     : out t_axi4_stream_mosi16;
      TX_MISO     : in  t_axi4_stream_miso  
   );
end badpixel_replacer;

architecture RTL of badpixel_replacer is

   component sync_resetn
      port(
         ARESETN: in std_logic;
         SRESETN: out std_logic;
         CLK    : in std_logic);
   end component;
   
   signal sresetn          : std_logic;
   signal last_valid_pix   : std_logic_vector(TX_MOSI.TDATA'range);

begin
   
   U0 : sync_resetn
   port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK);
   
   RX_MISO.TREADY <= TX_MISO.TREADY;
   
   TX_MOSI.TVALID <= RX_MOSI.TVALID;
   TX_MOSI.TDATA  <= last_valid_pix when (RX_MOSI.TDATA = TAG_BAD_PIX and REPL_MODE = BPR_MODE_LAST_VALID) else 
                     --signal when (RX_MOSI.TDATA = TAG_BAD_PIX and REPL_MODE = mode) else 
                     RX_MOSI.TDATA;
   TX_MOSI.TSTRB  <= RX_MOSI.TSTRB;  
   TX_MOSI.TKEEP  <= RX_MOSI.TKEEP;  
   TX_MOSI.TLAST  <= RX_MOSI.TLAST;  
   TX_MOSI.TID    <= RX_MOSI.TID;    
   TX_MOSI.TDEST  <= RX_MOSI.TDEST;  
   TX_MOSI.TUSER  <= RX_MOSI.TUSER;
   
   process(CLK)
   begin          
      if rising_edge(CLK) then
         
         if sresetn = '0' then 
            last_valid_pix <= (last_valid_pix'high => '1', others => '0'); -- Reset value is the median
         
         elsif (TX_MISO.TREADY = '1' and RX_MOSI.TVALID = '1' and RX_MOSI.TDATA /= TAG_BAD_PIX) then
            -- Update last valid pixel value
            last_valid_pix <= RX_MOSI.TDATA;
         end if;
         
      end if;
   end process;
   

end RTL;