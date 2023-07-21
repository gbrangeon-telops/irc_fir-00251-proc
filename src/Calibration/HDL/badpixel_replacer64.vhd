-------------------------------------------------------------------------------
--
-- Title       : badpixel_replacer
-- Author      : Olivier Dionne
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author: odionne $
-- $LastChangedDate: 2017-04-10 16:00:05 -0400 (lun., 10 avr. 2017) $
-- $Revision: 20321 $ 
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

entity badpixel_replacer64 is
   port(
      CLK         : in  std_logic;
      ARESETN     : in  std_logic;
      REPL_MODE   : in  bpr_mode_type;
   
      RX_MOSI     : in  t_axi4_stream_mosi64;      
      RX_MISO     : out t_axi4_stream_miso;  
      
      TX_MOSI     : out t_axi4_stream_mosi64;
      TX_MISO     : in  t_axi4_stream_miso  
   );
end badpixel_replacer64;

architecture RTL of badpixel_replacer64 is

   component sync_resetn
      port(
         ARESETN: in std_logic;
         SRESETN: out std_logic;
         CLK    : in std_logic);
   end component;
   
   signal sresetn           : std_logic; 
   signal frame_in_progress : std_logic; 
   signal repl_mode_i       : bpr_mode_type;
   signal last_valid_pix    : std_logic_vector(15 downto 0);
   
begin
   
   U0 : sync_resetn
   port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK);
   
   RX_MISO.TREADY <= TX_MISO.TREADY;
   
   TX_MOSI.TVALID <= RX_MOSI.TVALID;
   --signal when (RX_MOSI.TDATA = TAG_BAD_PIX and REPL_MODE = mode) else 
   TX_MOSI.TSTRB  <= RX_MOSI.TSTRB;  
   TX_MOSI.TKEEP  <= RX_MOSI.TKEEP;  
   TX_MOSI.TLAST  <= RX_MOSI.TLAST;  
   TX_MOSI.TID    <= RX_MOSI.TID;    
   TX_MOSI.TDEST  <= RX_MOSI.TDEST;  
   TX_MOSI.TUSER  <= RX_MOSI.TUSER;
   
   
     sync_cfg :process(CLK)
     begin          
        if rising_edge(CLK) then        
            if sresetn = '0' then 
               repl_mode_i        <= BPR_MODE_LAST_VALID;
               frame_in_progress  <= '0';    
            else   
               
               if(RX_MOSI.TVALID = '1' and RX_MOSI.TLAST = '1' and TX_MISO.TREADY = '1') then
                  frame_in_progress <= '0'; 
               elsif(RX_MOSI.TVALID = '1' and RX_MOSI.TLAST = '0' and TX_MISO.TREADY = '1') then
                  frame_in_progress <= '1';
               end if;
               
               if(frame_in_progress = '0') then
                  repl_mode_i <= REPL_MODE;
               else
                  repl_mode_i <= repl_mode_i;
               end if;
               
            end if;        
        end if;
    end process;
    
    last_valid_value :process(CLK)
        begin          
        if rising_edge(CLK) then        
            if sresetn = '0' then 
                last_valid_pix <= (last_valid_pix'high => '1', others => '0'); -- Reset value is the median
                -- Update last valid pixel value
            elsif (TX_MISO.TREADY = '1' and RX_MOSI.TVALID = '1' and RX_MOSI.TDATA(63 downto 48) /= TAG_BAD_PIX and RX_MOSI.TID = "0") then
                last_valid_pix <= RX_MOSI.TDATA(63 downto 48);
            elsif (TX_MISO.TREADY = '1' and RX_MOSI.TVALID = '1' and RX_MOSI.TDATA(47 downto 32) /= TAG_BAD_PIX and RX_MOSI.TID = "0") then
                last_valid_pix <= RX_MOSI.TDATA(47 downto 32);
            elsif (TX_MISO.TREADY = '1' and RX_MOSI.TVALID = '1' and RX_MOSI.TDATA(31 downto 16) /= TAG_BAD_PIX and RX_MOSI.TID = "0") then
                last_valid_pix <= RX_MOSI.TDATA(31 downto 16);
            elsif (TX_MISO.TREADY = '1' and RX_MOSI.TVALID = '1' and RX_MOSI.TDATA(15 downto 0) /= TAG_BAD_PIX and RX_MOSI.TID = "0") then
                last_valid_pix <= RX_MOSI.TDATA(15 downto 0);
            else
                last_valid_pix  <=  last_valid_pix; -- Keep last VALUE IF ALL BAD
            end if;        
        end if;
    end process;
    
    
    Pix0_replacer : process
    begin          
        if(RX_MOSI.TDATA(15 downto 0) = TAG_BAD_PIX and REPL_MODE = BPR_MODE_LAST_VALID and RX_MOSI.TID = "0") then
            TX_MOSI.TDATA(15 downto 0) <= last_valid_pix;    
        else
            TX_MOSI.TDATA(15 downto 0) <= RX_MOSI.TDATA(15 downto 0);
        end if;
    end process Pix0_replacer;
    
    Pix1_replacer : process
    begin          
        if(RX_MOSI.TDATA(31 downto 16) = TAG_BAD_PIX and REPL_MODE = BPR_MODE_LAST_VALID and RX_MOSI.TID = "0") then
            TX_MOSI.TDATA(31 downto 16) <= RX_MOSI.TDATA(15 downto 0);
            
            if(RX_MOSI.TDATA(15 downto 0) = TAG_BAD_PIX) then
                TX_MOSI.TDATA(31 downto 16) <= last_valid_pix;        
            end if;
            
         else
            TX_MOSI.TDATA(31 downto 16) <= RX_MOSI.TDATA(31 downto 16);
        end if;
    end process Pix1_replacer;
    
    Pix2_replacer : process
    begin          
        if(RX_MOSI.TDATA(47 downto 32) = TAG_BAD_PIX and REPL_MODE = BPR_MODE_LAST_VALID and RX_MOSI.TID = "0") then
            TX_MOSI.TDATA(47 downto 32) <= RX_MOSI.TDATA(31 downto 16);
            
            if(RX_MOSI.TDATA(31 downto 16) = TAG_BAD_PIX) then
                TX_MOSI.TDATA(47 downto 32) <= RX_MOSI.TDATA(15 downto 0); 
                
                if(RX_MOSI.TDATA(15 downto 0) = TAG_BAD_PIX) then
                    TX_MOSI.TDATA(47 downto 32) <= last_valid_pix;    
                end if;
            end if;
            
            
         else
            TX_MOSI.TDATA(47 downto 32) <= RX_MOSI.TDATA(47 downto 32);
        end if;
    end process Pix2_replacer;
    
    Pix3_replacer : process
    begin          
        if(RX_MOSI.TDATA(63 downto 48) = TAG_BAD_PIX and REPL_MODE = BPR_MODE_LAST_VALID and RX_MOSI.TID = "0") then
            TX_MOSI.TDATA(63 downto 48) <= RX_MOSI.TDATA(47 downto 32);
            
            if(RX_MOSI.TDATA(47 downto 32) = TAG_BAD_PIX) then
                TX_MOSI.TDATA(63 downto 48) <= RX_MOSI.TDATA(31 downto 16);
            
                if(RX_MOSI.TDATA(31 downto 16) = TAG_BAD_PIX) then
                    TX_MOSI.TDATA(63 downto 48) <= RX_MOSI.TDATA(15 downto 0); 
                    
                    if(RX_MOSI.TDATA(15 downto 0) = TAG_BAD_PIX) then
                        TX_MOSI.TDATA(63 downto 48) <= last_valid_pix;    
                    end if;
                end if;
            end if;
        else
            TX_MOSI.TDATA(63 downto 48) <= RX_MOSI.TDATA(63 downto 48);
        end if;
    end process Pix3_replacer;

end RTL;