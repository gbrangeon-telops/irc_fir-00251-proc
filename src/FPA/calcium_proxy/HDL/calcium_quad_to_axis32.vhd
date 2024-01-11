------------------------------------------------------------------
--!   @file : calcium_quad_to_axis32
--!   @brief
--!   @details : ce module permet de convertir les données natives (quad) en 4 formats axis.
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
use work.Tel2000.all;
use work.FPA_define.all;
use work.proxy_define.all;

entity calcium_quad_to_axis32 is
   port (
      ARESET         : in std_logic;
      CLK            : in std_logic;      
      
      RX_QUAD_DATA   : in calcium_quad_data_type;
      
      TX_MOSI_ARY    : out t_axis4_mosi32_a(1 to 4);
      TX_MISO_ARY    : in t_axis4_miso_a(1 to 4);
      
      ERROR          : out std_logic  
   );
end calcium_quad_to_axis32;



architecture rtl of calcium_quad_to_axis32 is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;  
   
   signal sreset : std_logic;
   signal error_o : std_logic;

begin
   
   -- Error mapping
   ERROR <= error_o;
   
   -- Output data mapping
   Output_gen : for ii in 1 to 4 generate
      TX_MOSI_ARY(ii).TDATA    <= resize(RX_QUAD_DATA.PIX_DATA(ii), TX_MOSI_ARY(ii).TDATA'length);
      TX_MOSI_ARY(ii).TVALID   <= RX_QUAD_DATA.AOI_DVAL;     -- only pixel data
      TX_MOSI_ARY(ii).TSTRB    <= (others => '1');
      TX_MOSI_ARY(ii).TKEEP    <= (others => '1');
      TX_MOSI_ARY(ii).TLAST    <= RX_QUAD_DATA.AOI_LAST;
      TX_MOSI_ARY(ii).TID      <= (others => '0');
      TX_MOSI_ARY(ii).TDEST    <= (others => '0');
      TX_MOSI_ARY(ii).TUSER    <= (others => '0');
   end generate;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------   
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
   );   
   
   --------------------------------------------------
   -- Error
   --------------------------------------------------   
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            error_o <= '0';
         else             
            
            -- Throughput error: this module does not support when tready is low. This error is latched
            if RX_QUAD_DATA.AOI_DVAL = '1' and (TX_MISO_ARY(1).TREADY = '0' or TX_MISO_ARY(2).TREADY = '0' or TX_MISO_ARY(3).TREADY = '0' or TX_MISO_ARY(4).TREADY = '0') then
               error_o <= '1';
            end if;
            
         end if;
      end if;
   end process;
   
end rtl;
