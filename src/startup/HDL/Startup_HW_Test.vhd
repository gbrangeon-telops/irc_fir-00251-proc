
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.tel2000.all;

entity Startup_HW_Test is  
   
   port(
      -- Misc
      ARESETN           :     in std_logic;
      CLK               :     in std_logic;
      
      -- Signal probes
      SFW_ENCA          :     in std_logic;
      SFW_ENCB          :     in std_logic;
      SFW_INDEX         :     in std_logic;
      TRIG_IN_BUF       :     in std_logic;
      
      -- Comm Interface
      AXI4_LITE_MOSI    :     in t_axi4_lite_mosi;
      AXI4_LITE_MISO    :     out t_axi4_lite_miso
      );   
      
end Startup_HW_Test;

architecture implementation of Startup_HW_Test is

   constant AXI_DATA_WIDTH    : integer := 32;
   constant AXI_ADDR_WIDTH    : integer := 32;
   constant ADDR_LSB          : integer := 2;   -- 4-byte access
   constant OPT_MEM_ADDR_BITS : integer := 2;

   constant DEVICE_READ_DATA_ADDR  : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0, ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant DEVICE_RESET_ADDR      : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4, ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   
   component sync_resetn is
      port(
         ARESETN : in STD_LOGIC;
         SRESETN : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;
   
   -- DATA signals
   signal sfw_enca_latch      : std_logic;
   signal sfw_encb_latch      : std_logic;
   signal sfw_index_latch     : std_logic;
   signal trig_in_latch       : std_logic;
   signal data_o              : std_logic_vector (3 downto 0);
   
   signal register_rstn       : std_logic;
   
   -- RESET signals
   signal sresetn             : std_logic;
   signal sreset              : std_logic;
   signal areset              : std_logic;
   
   -- AXI4LITE signals
   signal axi_awaddr	      : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);
   signal axi_awready         : std_logic;
   signal axi_wready	      : std_logic;
   signal axi_bresp	          : std_logic_vector(1 downto 0);
   signal axi_bvalid	      : std_logic;
   signal axi_araddr	      : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);
   signal axi_arready         : std_logic;
   signal axi_rdata	          : std_logic_vector(AXI_DATA_WIDTH-1 downto 0);
   signal axi_rresp	          : std_logic_vector(1 downto 0);
   signal axi_rvalid	      : std_logic;
   signal axi_wstrb           : std_logic_vector(3 downto 0);
            
   signal slv_reg_rden        : std_logic;
   signal slv_reg_wren        : std_logic;
   signal reg_data_out        : std_logic_vector(AXI_DATA_WIDTH-1 downto 0);
   
   

begin

   sreset <= NOT sresetn;
   
   U0 : sync_resetn port map (ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK);

   -- I/O Connections assignments
   AXI4_LITE_MISO.AWREADY  <= axi_awready;
   AXI4_LITE_MISO.WREADY   <= axi_wready;
   AXI4_LITE_MISO.BRESP	   <= axi_bresp;
   AXI4_LITE_MISO.BVALID   <= axi_bvalid;
   AXI4_LITE_MISO.ARREADY  <= axi_arready;
   AXI4_LITE_MISO.RDATA	   <= axi_rdata;
   AXI4_LITE_MISO.RRESP	   <= axi_rresp;
   AXI4_LITE_MISO.RVALID   <= axi_rvalid;
   
   -- Output data assignment
   data_o(0) <= sfw_enca_latch;
   data_o(1) <= sfw_encb_latch;
   data_o(2) <= sfw_index_latch;
   data_o(3) <= trig_in_latch;
   

   Latch : process (CLK)
   begin
      if rising_edge(CLK) then
         if (sresetn = '0' OR register_rstn = '0') then
            sfw_enca_latch <= '0';
            sfw_encb_latch <= '0';
            sfw_index_latch <= '0';
            trig_in_latch <= '0';
         else  
            if (SFW_ENCA = '1') then
               sfw_enca_latch <= '1';
            end if;
            
            if (SFW_ENCB = '1') then
               sfw_encb_latch <= '1';
            end if;

            if (SFW_INDEX = '1') then
               sfw_index_latch <= '1';
            end if;
            
            if (TRIG_IN_BUF = '1') then
               trig_in_latch <= '1';
            end if;
         end if; 
      end if;           
   end process Latch;
   
   ----------------------------------------------------------------------------
   -- AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U1: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sresetn = '0' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else
            
            if (axi_awready = '0' and AXI4_LITE_MOSI.AWVALID = '1' and AXI4_LITE_MOSI.WVALID = '1') then
               axi_awready <= '1';
               axi_awaddr <= AXI4_LITE_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;
            
            if (axi_wready = '0' and AXI4_LITE_MOSI.WVALID = '1' and AXI4_LITE_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';               
            end if;              
            
         end if;
      end if;
   end process;   
   slv_reg_wren <= axi_wready and AXI4_LITE_MOSI.WVALID and axi_awready and AXI4_LITE_MOSI.AWVALID ;
   axi_wstrb <= AXI4_LITE_MOSI.WSTRB; 
   
   ----------------------------------------------------------------------------
   -- AXI WR : reception configuration
   ----------------------------------------------------------------------------
   U2: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sresetn = '0' then
            register_rstn <= '1';
         else
            register_rstn <= '1';
            if (slv_reg_wren = '1') and axi_wstrb = "1111" then
               case axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) is 
                  when DEVICE_RESET_ADDR => register_rstn <= AXI4_LITE_MOSI.WDATA(0);
                  when others  =>                  
               end case;                                                                                          
            end if;                                        
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------------------------------
   -- AXI WR : WR response
   ----------------------------------------------------------------------------
   U3: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sresetn = '0' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
         else
            if (axi_awready = '1' and AXI4_LITE_MOSI.AWVALID = '1' and axi_wready = '1' and AXI4_LITE_MOSI.WVALID = '1' and axi_bvalid = '0'  ) then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif (AXI4_LITE_MOSI.BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U4: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sresetn = '0' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if axi_arready = '0' and AXI4_LITE_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= AXI4_LITE_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;            
            if axi_arready = '1' and AXI4_LITE_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and AXI4_LITE_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   
   ---------------------------------------------------------------------------- 
   -- RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U5: process(CLK)
   begin
      if rising_edge(CLK) then         
         case axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) is
            when  DEVICE_READ_DATA_ADDR => reg_data_out <= std_logic_vector(resize(data_o, reg_data_out'length));
            when  others                     => reg_data_out <= (others => '0');
         end case;        
      end if;     
   end process;
   
   ---------------------------------------------------------------------------- 
   -- Axi RD responses                                      
   ---------------------------------------------------------------------------- 
   U6: process (CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if (axi_arready = '1' and AXI4_LITE_MOSI.ARVALID = '1' and axi_rvalid = '0') then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif (axi_rvalid = '1' and AXI4_LITE_MOSI.RREADY = '1') then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
         end if;
      end if;
   end process;
   
   -- Implement memory mapped register select and read logic generation
   -- Slave register read enable is asserted when valid address is available
   -- and the slave is ready to accept the read address.
   slv_reg_rden <= axi_arready and AXI4_LITE_MOSI.ARVALID and (not axi_rvalid) ; 
   -- Read address mux
   axi_rdata <= reg_data_out;     -- register read data
   
end implementation;