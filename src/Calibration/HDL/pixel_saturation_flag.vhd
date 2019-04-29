------------------------------------------------------------------
--!   @file : pixel_saturation_flag
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

entity pixel_saturation_flag is   
   
   port(
      ARESETN         : in std_logic;
      CLK             : in std_logic;
      
      RX_MOSI         : in t_axi4_stream_mosi16;
      RX_MISO         : out t_axi4_stream_miso;
      
      THRESHOLD_MOSI       : in t_axi4_stream_mosi32;   -- calib param are all on 32b (only 16-LSB used)
      THRESHOLD_MISO  : out t_axi4_stream_miso;
      
      TX_MOSI         : out t_axi4_stream_mosi16;  
      TX_MISO         : in t_axi4_stream_miso;
      
      ERR               : out std_logic

      
      );
end pixel_saturation_flag;

architecture rtl of pixel_saturation_flag is
   
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
      RX1_TVALID    => THRESHOLD_MOSI.TVALID,
      RX1_TREADY    => THRESHOLD_MISO.TREADY,
      SYNC_TVALID   => sync_valid,
      SYNC_TREADY   => TX_MISO.TREADY
   );    
       
  -- flag des pixels staurés vui TUSER(1)  
   SAT_FLAGGING: process(CLK)
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
                  
                   if unsigned(RX_MOSI.TDATA) >=  resize(unsigned(THRESHOLD_MOSI.TDATA), RX_MOSI.TDATA'length) then 
                      TX_MOSI.TUSER(TUSER_SATURATED_PIX_BIT)<= '1'; --pixel is saturated
                   else
                      TX_MOSI.TUSER(TUSER_SATURATED_PIX_BIT)<= '0'; --pixel is not saturated 
                   end if;
               else
                  TX_MOSI.TVALID  <= '0';
               end if;
            end if;      
            
         end if; 
      end if; 
   end process;
   
end rtl;

