------------------------------------------------------------------
--!   @file : pixel_saturation_repl
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

entity pixel_saturation_repl is   
   generic(
   		tuser_index	  : integer := TUSER_SATURATED_PIX_BIT;	  
   		VALUE_REPLACE : std_logic_vector(15 downto 0) := TAG_SATURATED_PIX
   	);
   port(
      ARESETN         : in std_logic;
      CLK             : in std_logic;
      
      RX_MOSI         : in t_axi4_stream_mosi16;
      RX_MISO         : out t_axi4_stream_miso;
      
      TX_MOSI         : out t_axi4_stream_mosi16;  
      TX_MISO         : in t_axi4_stream_miso
      
      );
end pixel_saturation_repl;

architecture rtl of pixel_saturation_repl is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component; 
   
   signal areset             : std_logic;
   signal sreset             : std_logic;
   
begin  
   
   
   areset <= not ARESETN;
   
   -- synchro reset   
   U0: sync_reset
   port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   RX_MISO <= TX_MISO;   
   
   
   -- recodage des pixels saturés via TUSER(1)  
   U1: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            TX_MOSI.TVALID <= '0';
         else
            
            if TX_MISO.TREADY = '1' then 
               TX_MOSI <= RX_MOSI;
               if RX_MOSI.TUSER(tuser_index)= '1' then 
                  TX_MOSI.TDATA <= VALUE_REPLACE;
               end if;
            end if;          
            
         end if; 
      end if; 
   end process;
   
end rtl;

