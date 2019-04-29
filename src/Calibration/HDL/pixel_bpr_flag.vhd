------------------------------------------------------------------
--!   @file : pixel_saturation_flag
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity pixel_bpr_flag is   
   
   port(
      ARESETN         : in std_logic;
      CLK             : in std_logic;
      
      RX_MOSI         : in t_axi4_stream_mosi16;
      RX_MISO         : out t_axi4_stream_miso;
      
      BPR_INFO_MOSI     : in t_axi4_stream_mosi8;   
      BPR_INFO_MISO     : out t_axi4_stream_miso;
      
      TX_MOSI         : out t_axi4_stream_mosi16;  
      TX_MISO         : in t_axi4_stream_miso;
      
      ERR               : out std_logic

      
      );
end pixel_bpr_flag;

architecture rtl of pixel_bpr_flag is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component; 
   
   component axis_sync_flow
   port(           
      RX0_TVALID    : in std_logic;
      RX0_TREADY    : out std_logic;
      
      RX1_TVALID    : in std_logic;
      RX1_TREADY    : out std_logic;
      
      SYNC_TREADY   : in std_logic;      
      SYNC_TVALID   : out std_logic);
    end component axis_sync_flow;
   
   signal areset             : std_logic;
   signal sreset             : std_logic;
   signal sync_valid   : std_logic := '0';
   
begin  
   
   
   areset <= not ARESETN;
   
   -- synchro reset   
   U0: sync_reset
   port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
      );
      
   U1: axis_sync_flow
   port map(         
      RX0_TVALID    => RX_MOSI.TVALID,
      RX0_TREADY    => RX_MISO.TREADY,
      RX1_TVALID    => BPR_INFO_MOSI.TVALID,
      RX1_TREADY    => BPR_INFO_MISO.TREADY,
      SYNC_TVALID   => sync_valid,
      SYNC_TREADY   => TX_MISO.TREADY
   );    
       
  -- flag des pixels bad via TUSER(0)  
   BPR_FLAGGING: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            TX_MOSI.TVALID <= '0';
            ERR <= '0';
         else
            ERR <= '0'; --ERROR NOT SET
            
            if TX_MISO.TREADY = '1' then 
               if sync_valid = '1' then
                  TX_MOSI.TVALID  <= '1';
                  TX_MOSI.TSTRB   <= RX_MOSI.TSTRB;
                  TX_MOSI.TKEEP   <= RX_MOSI.TKEEP;
                  TX_MOSI.TLAST   <= RX_MOSI.TLAST;
                  TX_MOSI.TID     <= RX_MOSI.TID;
                  TX_MOSI.TDEST   <= RX_MOSI.TDEST;
                  TX_MOSI.TDATA   <= RX_MOSI.TDATA;
                  TX_MOSI.TUSER   <= RX_MOSI.TUSER;
                  
                   if BPR_INFO_MOSI.TDATA(0) = '1' then 
                       TX_MOSI.TUSER(TUSER_BAD_PIX_BIT)<= '0'; --pixel is not Bad 
                   else
                       TX_MOSI.TUSER(TUSER_BAD_PIX_BIT)<= '1'; --pixel is Bad
                   end if;
               else
                  TX_MOSI.TVALID  <= '0';
               end if;
            end if;      
            
         end if; 
      end if; 
   end process;
   
end rtl;

