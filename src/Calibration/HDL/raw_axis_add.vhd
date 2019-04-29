------------------------------------------------------------------
--!   @file : fu16_axis_add
--!   @brief
--!   @details ce module additionne  2 flow en entrée et sort le résultat sur 32 bits unsigned.  
--!   => La lageur effective des données en entrée ne doit donc pas depasser 16 bits
--!
--!   $Rev: 20321 $
--!   $Author: odionne $
--!   $Date: 2017-04-10 16:00:05 -0400 (lun., 10 avr. 2017) $
--!   $Id: raw_axis_add.vhd 20321 2017-04-10 20:00:05Z odionne $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/Calibration/HDL/raw_axis_add.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity raw_axis_add is
   port(
      ARESETN    : in std_logic;
      CLK        : in std_logic;
      
      RXA_MOSI   : in t_axi4_stream_mosi32;
      RXA_MISO   : out t_axi4_stream_miso;
      
      RXB_MOSI   : in t_axi4_stream_mosi32;
      RXB_MISO   : out t_axi4_stream_miso;
      
      TX_MOSI    : out t_axi4_stream_mosi32;  
      TX_MISO    : in t_axi4_stream_miso;
      
      ERR        : out std_logic
      );
end raw_axis_add;

architecture rtl of raw_axis_add is
   component axis_sync_flow
      port(                      
         RX0_TVALID    : in std_logic;
         RX0_TREADY    : out std_logic;      
         RX1_TVALID    : in std_logic;
         RX1_TREADY    : out std_logic;      
         SYNC_TREADY   : in std_logic;      
         SYNC_TVALID   : out std_logic    
         );
   end component; 
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component; 
   
   

   signal sync_tready        : std_logic;
   signal sync_tvalid        : std_logic  := '0';
   signal areset             : std_logic;
   signal sreset             : std_logic;
   
begin  
   
   sync_tready <= TX_MISO.TREADY;
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
      RX0_TVALID  => RXA_MOSI.TVALID,
      RX0_TREADY  => RXA_MISO.TREADY,
      RX1_TVALID  => RXB_MOSI.TVALID,
      RX1_TREADY  => RXB_MISO.TREADY,
      SYNC_TREADY => sync_tready,
      SYNC_TVALID => sync_tvalid   
      );

      
TX_MOSI.TID    <= (others => '0');   -- non supporté
TX_MOSI.TDEST  <= (others => '0');   -- non supporté	 
TX_MOSI.TSTRB    <= (others => '1'); -- non supporté
TX_MOSI.TKEEP   <= (others => '1'); -- non supporté
TX_MOSI.TUSER   <= (others => '0'); -- non supporté


   process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            TX_MOSI.TVALID <= '0';
         else
             -- erreur si entrée valide sur plus que 31 bits

             if TX_MISO.TREADY = '1' then 
                TX_MOSI.TLAST <= RXA_MOSI.TLAST;
                TX_MOSI.TDATA <= std_logic_vector(unsigned(RXA_MOSI.TDATA) + unsigned(RXB_MOSI.TDATA));
                if sync_tvalid = '1' then 
                    TX_MOSI.TVALID <= '1'; 
                else
                    TX_MOSI.TVALID <= '0'; 
                end if;
             end if;
        end if;
      end if; 
   end process;
   
end rtl;
