------------------------------------------------------------------
--!   @file : axil_channels_ctrl
--!   @brief
--!   @details : ce module permet d'aiguiller le demux en aval
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;           
use IEEE.numeric_std.ALL;
use work.Tel2000.all;

entity axil_channels_ctrl is
   port(
      ARESETN       : in std_logic;
      CLK           : in std_logic;    
      
      AXIL_RX_MOSI  : in t_axi4_lite_mosi;
      AXIL_RX_MISO  : out t_axi4_lite_miso;
      
      DEMUX_SEL     : out std_logic_vector(1 downto 0); 
      LUT_PAGE_ID   : out std_logic_vector(7 downto 0); 
      
      AXIL_TX_MOSI  : out t_axi4_lite_mosi;
      AXIL_TX_MISO  : in t_axi4_lite_miso
      );
end axil_channels_ctrl;



architecture rtl of axil_channels_ctrl is                
   
   constant A_AXIL_DEMUX_REG   : std_logic_vector(7 downto 0) := x"00";
   constant A_LUT_PAGE_ID_REG  : std_logic_vector(7 downto 0) := x"04";
   
   signal demux_sel_i     : std_logic_vector(1 downto 0);
   signal areset, sreset  : std_logic;
   signal lut_page_id_i   : std_logic_vector(7 downto 0);
   signal channel_ctrl_en : std_logic := '0';
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;  
   
begin
   
   areset <= not ARESETN;
   DEMUX_SEL <= demux_sel_i;
   LUT_PAGE_ID <= lut_page_id_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   -- Process 
   --------------------------------------------------   
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then    
         
         -- par defaut, les données sont envoyées à l'exterieur diu module
         channel_ctrl_en <= '0';
         AXIL_TX_MOSI <= AXIL_RX_MOSI;
         AXIL_RX_MISO <= AXIL_TX_MISO;  
         
         
         -- sauf si le MB s'adresse au module-ci. dans ce cas, ce dernier bloque la sortie   
         if (AXIL_RX_MOSI.WVALID and AXIL_RX_MOSI.AWVALID) = '1' then  
            
            if AXIL_RX_MOSI.AWADDR(14) = '1' then       -- permet de s'addresser au présent contrôleur  
               channel_ctrl_en <= '1';
               -- on envoie rien en sortie
               AXIL_TX_MOSI.AWVALID <= '0';
               AXIL_TX_MOSI.AWPROT <= (others => '0');  
               AXIL_TX_MOSI.WVALID <= '0';
               AXIL_TX_MOSI.BREADY <= '0';
               AXIL_TX_MOSI.ARVALID <= '0';
               AXIL_TX_MOSI.RREADY <= '0';
               AXIL_TX_MOSI.WSTRB  <= (others => '0');               
               
               AXIL_RX_MISO.AWREADY <= '1';
               AXIL_RX_MISO.WREADY  <= '1';
               AXIL_RX_MISO.ARREADY <= '1';
               
               case AXIL_RX_MOSI.AWADDR(7 downto 0) is
                  when A_AXIL_DEMUX_REG =>
                     demux_sel_i <=  AXIL_RX_MOSI.WDATA(demux_sel_i'length-1 downto 0);
                  
                  when A_LUT_PAGE_ID_REG =>
                     lut_page_id_i <=  AXIL_RX_MOSI.WDATA(lut_page_id_i'length-1 downto 0);                  
                  
                  when others =>
               end case;
               -- WR feedback          : à ameliorer  
               if AXIL_RX_MOSI.BREADY = '1' then 
                  AXIL_RX_MISO.BVALID <= AXIL_RX_MOSI.WVALID and AXIL_RX_MOSI.AWVALID;
                  AXIL_RX_MISO.BRESP <= AXI_OKAY;
               end if;
            end if;
            
            
            
            
         end if;                        
         
      end if;
   end process; 
   
   
   
   
end rtl;
