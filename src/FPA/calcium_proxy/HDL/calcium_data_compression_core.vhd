------------------------------------------------------------------
--!   @file : calcium_data_compression_core
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
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.proxy_define.all;
use work.tel2000.all;

entity calcium_data_compression_core is
   port (
      ARESETN           : in std_logic;
      CLK               : in std_logic;
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      RX_MOSI           : in  t_axi4_stream_mosi32;
      RX_MISO           : out t_axi4_stream_miso;
      
      TX_MOSI           : out t_axi4_stream_mosi32;
      TX_MISO           : in t_axi4_stream_miso;
      
      ERR               : out std_logic_vector(4 downto 0)
   );
end calcium_data_compression_core;

architecture rtl of calcium_data_compression_core is
   
   component sync_resetn is
      port (
         ARESETN : in std_logic;
         CLK     : in std_logic;
         SRESETN : out std_logic := '0'
      );
   end component;
   
   component fi32_axis_power is
      generic (
         BASE_SIGNED : boolean := FALSE;
         BASE_FP     : boolean := FALSE;
         POW_FP      : boolean := FALSE
      );
      port (
         ARESETN     : in std_logic;
         CLK         : in std_logic;
         EXPN        : in std_logic_vector(31 downto 0);
         BASE_MOSI   : in t_axi4_stream_mosi32;
         BASE_MISO   : out t_axi4_stream_miso;
         POW_MOSI    : out t_axi4_stream_mosi32;
         POW_MISO    : in t_axi4_stream_miso;
         ERR         : out std_logic_vector(4 downto 0)
      );
   end component;
   
   signal sresetn             : std_logic;
   signal rx_mosi_i           : t_axi4_stream_mosi32;
   signal rx_miso_i           : t_axi4_stream_miso;
   signal tx_mosi_i           : t_axi4_stream_mosi32;
   signal tx_miso_i           : t_axi4_stream_miso;
   signal compr_rx_mosi       : t_axi4_stream_mosi32;
   signal compr_rx_miso       : t_axi4_stream_miso;
   signal compr_tx_mosi       : t_axi4_stream_mosi32;
   signal compr_tx_miso       : t_axi4_stream_miso;
   signal bypass_rx_mosi      : t_axi4_stream_mosi32;
   signal bypass_rx_miso      : t_axi4_stream_miso;
   signal bypass_tx_mosi      : t_axi4_stream_mosi32;
   signal bypass_tx_miso      : t_axi4_stream_miso;
   signal compr_en_rx         : std_logic;
   signal compr_en_tx         : std_logic;
   signal bypass_shift        : natural range 0 to 2**FPA_INTF_CFG.compr_bypass_shift'length-1;
   
begin

   --------------------------------------------------
   -- RX mapping
   --------------------------------------------------
   -- MOSI is connected to compression and bypass modules
   rx_mosi_i <= RX_MOSI;
   compr_rx_mosi <= rx_mosi_i;
   bypass_rx_mosi <= rx_mosi_i;
   -- MISO is selected from the active module
   RX_MISO <= rx_miso_i;
   rx_miso_i <= compr_rx_miso when compr_en_rx = '1' else bypass_rx_miso;
   
   --------------------------------------------------
   -- TX mapping
   --------------------------------------------------
   -- MOSI is selected from the active module
   TX_MOSI <= tx_mosi_i;
   tx_mosi_i <= compr_tx_mosi when compr_en_tx = '1' else bypass_tx_mosi;
   -- MISO is connected to compression and bypass modules
   tx_miso_i <= TX_MISO;
   compr_tx_miso <= tx_miso_i;
   bypass_tx_miso <= tx_miso_i;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------
   U1 : sync_resetn
   port map (
      ARESETN => ARESETN,
      CLK     => CLK,
      SRESETN => sresetn
   );
   
   --------------------------------------------------
   -- Compression module using power law
   --------------------------------------------------
   U2 : fi32_axis_power
   generic map (
      BASE_SIGNED => FALSE,
      BASE_FP     => FALSE,
      POW_FP      => FALSE
   )
   port map (
      ARESETN     => ARESETN,
      CLK         => CLK,
      EXPN        => FPA_INTF_CFG.compr_ratio_fp32,
      BASE_MOSI   => compr_rx_mosi,
      BASE_MISO   => compr_rx_miso,
      POW_MOSI    => compr_tx_mosi,
      POW_MISO    => compr_tx_miso,
      ERR         => ERR
   );
   
   --------------------------------------------------
   -- Bypass module using bit shift
   --------------------------------------------------
   bypass_tx_mosi.tvalid <= bypass_rx_mosi.tvalid;
   bypass_tx_mosi.tdata  <= resize(bypass_rx_mosi.tdata(bypass_shift+15 downto bypass_shift), bypass_tx_mosi.tdata'length);
   bypass_tx_mosi.tstrb  <= bypass_rx_mosi.tstrb;
   bypass_tx_mosi.tkeep  <= bypass_rx_mosi.tkeep;
   bypass_tx_mosi.tlast  <= bypass_rx_mosi.tlast;
   bypass_tx_mosi.tid    <= bypass_rx_mosi.tid;
   bypass_tx_mosi.tdest  <= bypass_rx_mosi.tdest;
   bypass_tx_mosi.tuser  <= bypass_rx_mosi.tuser;
   bypass_rx_miso <= bypass_tx_miso;
   
   --------------------------------------------------
   -- Config parameters synchronization
   --------------------------------------------------
   U3 : process(CLK)
      variable sync_param_rx : std_logic;
      variable sync_param_tx : std_logic;
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            compr_en_rx <= '1';
            compr_en_tx <= '1';
            sync_param_rx := '1';
            sync_param_tx := '1';
            bypass_shift <= 0;
         else
            
            -- Synchronize RX parameters when a tlast passes at RX. Stop synchronizing at the first transaction that is not a tlast
            if rx_mosi_i.tvalid = '1' and rx_miso_i.tready = '1' then
               if rx_mosi_i.tlast = '1' then
                  sync_param_rx := '1';
               else
                  sync_param_rx := '0';
               end if;
            end if;
            
            if sync_param_rx = '1' then
               compr_en_rx <= FPA_INTF_CFG.compr_en;
            end if;
            
            -- Synchronize TX parameters when a tlast passes at TX. Stop synchronizing at the first transaction that is not a tlast
            if tx_mosi_i.tvalid = '1' and tx_miso_i.tready = '1' then
               if tx_mosi_i.tlast = '1' then
                  sync_param_tx := '1';
               else
                  sync_param_tx := '0';
               end if;
            end if;
            
            if sync_param_tx = '1' then
               compr_en_tx <= FPA_INTF_CFG.compr_en;
               bypass_shift <= to_integer(FPA_INTF_CFG.compr_bypass_shift);
            end if;
            
         end if;
      end if;
   end process;
   
   
end rtl;
