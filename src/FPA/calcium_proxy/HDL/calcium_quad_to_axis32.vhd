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
      
      TX0_MOSI       : out t_axi4_stream_mosi32;
      TX0_MISO       : in t_axi4_stream_miso;
      
      TX1_MOSI       : out t_axi4_stream_mosi32;
      TX1_MISO       : in t_axi4_stream_miso;
      
      TX2_MOSI       : out t_axi4_stream_mosi32;
      TX2_MISO       : in t_axi4_stream_miso;
      
      TX3_MOSI       : out t_axi4_stream_mosi32;
      TX3_MISO       : in t_axi4_stream_miso;
      
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
   TX0_MOSI.TDATA    <= resize(RX_QUAD_DATA.PIX_DATA(1), TX0_MOSI.TDATA'length);
   TX0_MOSI.TVALID   <= RX_QUAD_DATA.AOI_DVAL;     -- only pixel data
   TX0_MOSI.TSTRB    <= (others => '1');
   TX0_MOSI.TKEEP    <= (others => '1');
   TX0_MOSI.TLAST    <= RX_QUAD_DATA.AOI_LAST;
   TX0_MOSI.TID      <= (others => '0');
   TX0_MOSI.TDEST    <= (others => '0');
   TX0_MOSI.TUSER    <= (others => '0');
   
   TX1_MOSI.TDATA    <= resize(RX_QUAD_DATA.PIX_DATA(2), TX1_MOSI.TDATA'length);
   TX1_MOSI.TVALID   <= RX_QUAD_DATA.AOI_DVAL;     -- only pixel data
   TX1_MOSI.TSTRB    <= (others => '1');
   TX1_MOSI.TKEEP    <= (others => '1');
   TX1_MOSI.TLAST    <= RX_QUAD_DATA.AOI_LAST;
   TX1_MOSI.TID      <= (others => '0');
   TX1_MOSI.TDEST    <= (others => '0');
   TX1_MOSI.TUSER    <= (others => '0');
   
   TX2_MOSI.TDATA    <= resize(RX_QUAD_DATA.PIX_DATA(3), TX2_MOSI.TDATA'length);
   TX2_MOSI.TVALID   <= RX_QUAD_DATA.AOI_DVAL;     -- only pixel data
   TX2_MOSI.TSTRB    <= (others => '1');
   TX2_MOSI.TKEEP    <= (others => '1');
   TX2_MOSI.TLAST    <= RX_QUAD_DATA.AOI_LAST;
   TX2_MOSI.TID      <= (others => '0');
   TX2_MOSI.TDEST    <= (others => '0');
   TX2_MOSI.TUSER    <= (others => '0');
   
   TX3_MOSI.TDATA    <= resize(RX_QUAD_DATA.PIX_DATA(4), TX3_MOSI.TDATA'length);
   TX3_MOSI.TVALID   <= RX_QUAD_DATA.AOI_DVAL;     -- only pixel data
   TX3_MOSI.TSTRB    <= (others => '1');
   TX3_MOSI.TKEEP    <= (others => '1');
   TX3_MOSI.TLAST    <= RX_QUAD_DATA.AOI_LAST;
   TX3_MOSI.TID      <= (others => '0');
   TX3_MOSI.TDEST    <= (others => '0');
   TX3_MOSI.TUSER    <= (others => '0');
   
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
            if RX_QUAD_DATA.AOI_DVAL = '1' and (TX0_MISO.TREADY = '0' or TX1_MISO.TREADY = '0' or TX2_MISO.TREADY = '0' or TX3_MISO.TREADY = '0') then
               error_o <= '1';
            end if;
            
         end if;
      end if;
   end process;
   
end rtl;
