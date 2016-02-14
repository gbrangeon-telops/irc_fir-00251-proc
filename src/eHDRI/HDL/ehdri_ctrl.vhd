library ieee;
use ieee.std_logic_1164.all;

library work;
use work.tel2000.all;

entity ehdri_ctrl is
  port (
    Sys_clk   : in  std_logic;   -- Sys clock
    ARESET    : in  std_logic;   -- sys reset
    
   -- AXI signals
    Axil_Mosi : in t_axi4_lite_mosi;
    Axil_Miso : out t_axi4_lite_miso;

   -- Memory signals
    Mem_Mosi : out t_axi4_lite_mosi;
    Mem_Miso : in t_axi4_lite_miso;
    
    -- Exposure Time
    ExpTime0 : out std_logic_vector(31 downto 0);
    ExpTime1 : out std_logic_vector(31 downto 0);
    ExpTime2 : out std_logic_vector(31 downto 0);
    ExpTime3 : out std_logic_vector(31 downto 0);
	
	-- SM Enable
	SM_Enable : out std_logic
);
end ehdri_ctrl;

architecture implementation of ehdri_ctrl is

 component sync_reset is
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1';
         CLK    : in STD_LOGIC
         );
   end component sync_reset;
-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------
   signal cfg_waddr	               : std_logic_vector(7 downto 0);
   signal cfg_raddr	               : std_logic_vector(7 downto 0);
   signal cfg_read_data             : std_logic_vector(31 downto 0);
   signal cfg_wren   	            : std_logic;
   signal cfg_rden   	            : std_logic;

   signal axi_mosi_i                : t_axi4_lite_mosi;
   signal axi_miso_i                : t_axi4_lite_miso;

   signal exptime0_i : std_logic_vector(31 downto 0);
   signal exptime1_i : std_logic_vector(31 downto 0);
   signal exptime2_i : std_logic_vector(31 downto 0);
   signal exptime3_i : std_logic_vector(31 downto 0);

   signal sm_enable_i   	            : std_logic;
   
   signal sreset : std_logic := '0';

   constant ADDR_EXPTIME0 : std_logic_vector(7 downto 0) := x"00";
   constant ADDR_EXPTIME1 : std_logic_vector(7 downto 0) := x"04";
   constant ADDR_EXPTIME2 : std_logic_vector(7 downto 0) := x"08";
   constant ADDR_EXPTIME3 : std_logic_vector(7 downto 0) := x"0C";
   constant ADDR_ENABLE   : std_logic_vector(7 downto 0) := x"10";
   
begin
   ExpTime0 <= exptime0_i;
   ExpTime1 <= exptime1_i;
   ExpTime2 <= exptime2_i;
   ExpTime3 <= exptime3_i;
   SM_Enable <= sm_enable_i;
   
   axi_mosi_i <= Axil_Mosi;
   
   Mem_Mosi.AWADDR <= Axil_Mosi.AWADDR;
   Mem_Mosi.AWPROT <= Axil_Mosi.AWPROT;
   Mem_Mosi.WDATA <= Axil_Mosi.WDATA;
   Mem_Mosi.WSTRB <= Axil_Mosi.WSTRB;
   Mem_Mosi.BREADY <= Axil_Mosi.BREADY;
   Mem_Mosi.ARVALID <= '0';
   Mem_Mosi.ARADDR <= (others => '0');
   Mem_Mosi.ARPROT <= (others => '0');
   Mem_Mosi.ARPROT <= (others => '0');
   Mem_Mosi.RREADY <= '0';

   Mem_Mosi.AWVALID <= Axil_Mosi.AWVALID when (Axil_Mosi.awaddr(8) = '0') else '0';
   Mem_Mosi.WVALID <= Axil_Mosi.WVALID when (Axil_Mosi.awaddr(8) = '0') else '0';
   
   Axil_Miso.AWREADY <= Mem_Miso.awready when (Axil_Mosi.awaddr(8) = '0') else axi_miso_i.AWREADY;
   Axil_Miso.WREADY <= Mem_Miso.wready when (Axil_Mosi.awaddr(8) = '0') else axi_miso_i.WREADY;
   Axil_Miso.BVALID <= Mem_Miso.bvalid when (Axil_Mosi.awaddr(8) = '0') else axi_miso_i.BVALID ;
   Axil_Miso.BRESP <= Mem_Miso.bresp when (Axil_Mosi.awaddr(8) = '0') else axi_miso_i.BRESP ;
   Axil_Miso.ARREADY <= '1' when (Axil_Mosi.araddr(8) = '0') else axi_miso_i.ARREADY ;
   Axil_Miso.RVALID <= '1' when (Axil_Mosi.araddr(8) = '0') else axi_miso_i.RVALID ;
   Axil_Miso.RDATA <= (others => '1') when (Axil_Mosi.araddr(8) = '0') else axi_miso_i.RDATA ;
   Axil_Miso.RRESP <= (others => '0') when (Axil_Mosi.araddr(8) = '0') else axi_miso_i.RRESP ;

   U1: sync_reset
   port map(
      ARESET => ARESET,
      SRESET => sreset,
      CLK => Sys_clk
      ); 
            
   AWREADY_PROC : process (Sys_clk)
   begin
      if rising_edge(Sys_clk) then 
         if sreset = '1' then
            axi_miso_i.awready <= '0';
         else
            if (axi_miso_i.awready = '0' and axi_mosi_i.awvalid = '1' and axi_mosi_i.wvalid = '1' and axi_mosi_i.awaddr(8) = '1') then
               axi_miso_i.awready <= '1';
            else
               axi_miso_i.awready <= '0';
            end if;
         end if;
      end if;
   end process AWREADY_PROC; 
    
   WREADY_PROC : process (Sys_clk)
   begin
      if rising_edge(Sys_clk) then 
         if sreset = '1' then
            axi_miso_i.wready <= '0';
         else
            if (axi_miso_i.wready = '0' and axi_mosi_i.awvalid = '1' and axi_mosi_i.wvalid = '1'and axi_mosi_i.awaddr(8) = '1') then
               axi_miso_i.wready <= '1';
            else
               axi_miso_i.wready <= '0';
            end if;
         end if;
      end if;
   end process WREADY_PROC; 

   CFG_WADDR_PROC : process (Sys_clk)
   begin
      if rising_edge(Sys_clk) then 
         if sreset = '1' then
            cfg_waddr <= (others => '0');
         else
            if (axi_miso_i.wready = '0' and axi_mosi_i.awvalid = '1' and axi_mosi_i.wvalid = '1') then
               cfg_waddr <= axi_mosi_i.awaddr(7 downto 0);
            end if;
         end if;
      end if;
   end process CFG_WADDR_PROC; 

	cfg_wren <= axi_miso_i.wready and axi_mosi_i.wvalid and axi_miso_i.awready and axi_mosi_i.awvalid and axi_mosi_i.awaddr(8);
   
	WRITE_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then 
	    if sreset = '1' then
         exptime0_i <= (others => '0');
         exptime1_i <= (others => '0');
         exptime2_i <= (others => '0');
         exptime3_i <= (others => '0');
		 sm_enable_i <= '0';
	    else
	      if (cfg_wren = '1') then
	        case (cfg_waddr) is
	          when ADDR_EXPTIME0 =>
                exptime0_i <= axi_mosi_i.wdata;

             when ADDR_EXPTIME1 =>
                exptime1_i <= axi_mosi_i.wdata;

             when ADDR_EXPTIME2 =>
                exptime2_i <= axi_mosi_i.wdata;
                
             when ADDR_EXPTIME3 =>
                exptime3_i <= axi_mosi_i.wdata;
                
             when ADDR_ENABLE =>
			 	sm_enable_i <= axi_mosi_i.wdata(0);
			 
	         when others =>

             end case;
	      end if;
	    end if;
	  end if;                   
	end process WRITE_PROC; 
   
	BVALID_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then 
	    if sreset = '1' then
	      axi_miso_i.bvalid  <= '0';
	      axi_miso_i.bresp   <= "00";
	    else
	      if (axi_miso_i.awready = '1' and axi_mosi_i.awvalid = '1' and axi_miso_i.wready = '1' and axi_mosi_i.wvalid = '1' and axi_miso_i.bvalid = '0' and axi_mosi_i.awaddr(8) = '1') then
	        axi_miso_i.bvalid <= '1';
	        axi_miso_i.bresp  <= "00"; 
	      elsif (axi_mosi_i.bready = '1' and axi_miso_i.bvalid = '1') then
	        axi_miso_i.bvalid <= '0';                                 
	      end if;
	    end if;
	  end if;                   
	end process BVALID_PROC; 

	CFG_RADDR_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then 
	    if sreset = '1' then
	      axi_miso_i.arready <= '0';
	      cfg_raddr  <= (others => '1');
	    else
	      if (axi_miso_i.arready = '0' and axi_mosi_i.arvalid = '1' and axi_mosi_i.araddr(8) = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_miso_i.arready <= '1';
	        -- Read Address latching 
	        cfg_raddr  <= axi_mosi_i.araddr(7 downto 0);           
	      else
	        axi_miso_i.arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process CFG_RADDR_PROC; 
   
	RVALID_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then
	    if sreset = '1' then
	      axi_miso_i.rvalid <= '0';
	      axi_miso_i.rresp  <= "00";
	    else
	      if (axi_miso_i.arready = '1' and axi_mosi_i.arvalid = '1' and axi_miso_i.rvalid = '0' and axi_mosi_i.araddr(8) = '1') then
	        axi_miso_i.rvalid <= '1';
	        axi_miso_i.rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_miso_i.rvalid = '1' and axi_mosi_i.rready = '1') then
	        -- Read data is accepted by the master
	        axi_miso_i.rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process RVALID_PROC;

	cfg_rden <= axi_miso_i.arready and axi_mosi_i.arvalid and (not axi_miso_i.rvalid) ;

	READ_PROC : process (exptime0_i, exptime1_i, exptime2_i, exptime3_i, sm_enable_i, cfg_raddr)
	begin
	    -- Address decoding for reading registers
	    case cfg_raddr is
	      when ADDR_EXPTIME0 =>
	        cfg_read_data <= exptime0_i;
	      when ADDR_EXPTIME1 =>
	        cfg_read_data <= exptime1_i;
	      when ADDR_EXPTIME2 =>
	        cfg_read_data <= exptime2_i;
	      when ADDR_EXPTIME3 =>
	        cfg_read_data <= exptime3_i;
	      when ADDR_ENABLE =>
	        cfg_read_data <= x"0000000" & "000" & sm_enable_i;
	      when others =>
	        cfg_read_data  <= (others => '0');
	    end case;
	end process; 

	OUTPUT_READ_PROC : process( Sys_clk ) is
	begin
	  if (rising_edge (Sys_clk)) then
	    if ( sreset = '1' ) then
	      axi_miso_i.rdata  <= (others => '0'); -- reset pas vraiment nécessaire...
	    else
	      if (cfg_rden = '1') then
	          axi_miso_i.rdata <= cfg_read_data;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;
   
end implementation;
