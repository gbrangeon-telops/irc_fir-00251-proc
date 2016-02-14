library ieee;
use ieee.std_logic_1164.all;

library work;
use work.tel2000.all;

entity flash_ctrl is
  port (
    Sys_clk          : in  std_logic;   -- Sys clock
    Rst              : in  std_logic;   -- sys reset
    
   -- AXI signals
    Axi_Mosi : in t_axi4_a32_d32_mosi;
    Axi_Miso : out t_axi4_a32_d32_miso;

   -- BRAM signals
    BRAM_Mosi : out t_axi4_a32_d32_mosi;
    BRAM_Miso : in t_axi4_a32_d32_miso;
	
	-- State Machine signals
	NAND_SM			 	 : out std_logic_vector(3 downto 0);
	ReadyBusyN           : in std_logic_vector(3 downto 0);
	
	-- Output signals
    Flash_Command_In       : in std_logic_vector(5 downto 0);
    Flash_Command_Out      : out std_logic_vector(5 downto 0);
    Flash_Command_Ctrl     : out std_logic_vector(5 downto 0);
    
	Flash_Data_In          : in std_logic_vector(7 downto 0);
    Flash_Data_Out         : out std_logic_vector(7 downto 0);
    Flash_Data_Ctrl        : out std_logic_vector(7 downto 0)		    
);
end flash_ctrl;

architecture implementation of flash_ctrl is

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------
   signal cfg_waddr	               : std_logic_vector(11 downto 0);
   signal cfg_raddr	               : std_logic_vector(11 downto 0);
   signal cfg_read_data             : std_logic_vector(31 downto 0);
   signal cfg_wren   	            : std_logic;
   signal cfg_rden   	            : std_logic;

   signal axi_mosi_i                : t_axi4_a32_d32_mosi;
   signal axi_miso_i                : t_axi4_a32_d32_miso;

   signal nand_sm_i	 	           : std_logic_vector(3 downto 0);
   signal flash_command_out_i      : std_logic_vector(5 downto 0);
   signal flash_command_ctrl_i     : std_logic_vector(5 downto 0);
   signal flash_data_out_i         : std_logic_vector(7 downto 0);
   signal flash_data_ctrl_i        : std_logic_vector(7 downto 0);
   
begin
   NAND_SM <= nand_sm_i;
   Flash_Command_Out <= flash_command_out_i;
   Flash_Command_Ctrl <= flash_command_ctrl_i;
   Flash_Data_Out <= flash_data_out_i;
   Flash_Data_Ctrl <= flash_data_ctrl_i;

   BRAM_Mosi.awaddr <= Axi_Mosi.awaddr;
   BRAM_Mosi.awburst <= Axi_Mosi.awburst;
   BRAM_Mosi.awcache <= Axi_Mosi.awcache;
   BRAM_Mosi.awlen <= Axi_Mosi.awlen;
   BRAM_Mosi.awlock <= Axi_Mosi.awlock;
   BRAM_Mosi.awprot <= Axi_Mosi.awprot;
   BRAM_Mosi.awqos <= Axi_Mosi.awqos;
   BRAM_Mosi.awregion <= Axi_Mosi.awregion;
   BRAM_Mosi.awsize <= Axi_Mosi.awsize;
   BRAM_Mosi.wdata <= Axi_Mosi.wdata;
   BRAM_Mosi.wlast <= Axi_Mosi.wlast;
   BRAM_Mosi.wstrb <= Axi_Mosi.wstrb;
   BRAM_Mosi.araddr <= Axi_Mosi.araddr;
   BRAM_Mosi.arburst <= Axi_Mosi.arburst;
   BRAM_Mosi.arcache <= Axi_Mosi.arcache;
   BRAM_Mosi.arlen <= Axi_Mosi.arlen;
   BRAM_Mosi.arlock <= Axi_Mosi.arlock;
   BRAM_Mosi.arprot <= Axi_Mosi.arprot;
   BRAM_Mosi.arqos <= Axi_Mosi.arqos;
   BRAM_Mosi.arregion <= Axi_Mosi.arregion;
   BRAM_Mosi.arsize <= Axi_Mosi.arsize;
   
   axi_mosi_i.awaddr <= Axi_Mosi.awaddr;
   axi_mosi_i.awburst <= Axi_Mosi.awburst;
   axi_mosi_i.awcache <= Axi_Mosi.awcache;
   axi_mosi_i.awlen <= Axi_Mosi.awlen;
   axi_mosi_i.awlock <= Axi_Mosi.awlock;
   axi_mosi_i.awprot <= Axi_Mosi.awprot;
   axi_mosi_i.awqos <= Axi_Mosi.awqos;
   axi_mosi_i.awregion <= Axi_Mosi.awregion;
   axi_mosi_i.awsize <= Axi_Mosi.awsize;
   axi_mosi_i.wdata <= Axi_Mosi.wdata;
   axi_mosi_i.wlast <= Axi_Mosi.wlast;
   axi_mosi_i.wstrb <= Axi_Mosi.wstrb;
   axi_mosi_i.araddr <= Axi_Mosi.araddr;
   axi_mosi_i.arburst <= Axi_Mosi.arburst;
   axi_mosi_i.arcache <= Axi_Mosi.arcache;
   axi_mosi_i.arlen <= Axi_Mosi.arlen;
   axi_mosi_i.arlock <= Axi_Mosi.arlock;
   axi_mosi_i.arprot <= Axi_Mosi.arprot;
   axi_mosi_i.arqos <= Axi_Mosi.arqos;
   axi_mosi_i.arregion <= Axi_Mosi.arregion;
   axi_mosi_i.arsize <= Axi_Mosi.arsize;

   BRAM_Mosi.awvalid <= Axi_Mosi.awvalid when (Axi_Mosi.awaddr(13) = '0') else '0';
   BRAM_Mosi.wvalid <= Axi_Mosi.wvalid when (Axi_Mosi.awaddr(13) = '0') else '0';
   BRAM_Mosi.bready <= Axi_Mosi.bready when (Axi_Mosi.awaddr(13) = '0') else '0';
   BRAM_Mosi.arvalid <= Axi_Mosi.arvalid when (Axi_Mosi.araddr(13) = '0') else '0';
   BRAM_Mosi.rready <= Axi_Mosi.rready when (Axi_Mosi.araddr(13) = '0') else '0';

   axi_mosi_i.awvalid <= Axi_Mosi.awvalid when (Axi_Mosi.awaddr(13) = '1') else '0';
   axi_mosi_i.wvalid <= Axi_Mosi.wvalid when (Axi_Mosi.awaddr(13) = '1') else '0';
   axi_mosi_i.bready <= Axi_Mosi.bready when (Axi_Mosi.awaddr(13) = '1') else '0';
   axi_mosi_i.arvalid <= Axi_Mosi.arvalid when (Axi_Mosi.araddr(13) = '1') else '0';
   axi_mosi_i.rready <= Axi_Mosi.rready when (Axi_Mosi.araddr(13) = '1') else '0';

   Axi_Miso.awready <= BRAM_Miso.awready when (Axi_Mosi.awaddr(13) = '0') else axi_miso_i.awready;
   Axi_Miso.wready <= BRAM_Miso.wready when (Axi_Mosi.awaddr(13) = '0') else axi_miso_i.wready;
   Axi_Miso.bresp <= BRAM_Miso.bresp when (Axi_Mosi.awaddr(13) = '0') else axi_miso_i.bresp ;
   Axi_Miso.bvalid <= BRAM_Miso.bvalid when (Axi_Mosi.awaddr(13) = '0') else axi_miso_i.bvalid ;

   Axi_Miso.arready <= BRAM_Miso.arready when (Axi_Mosi.araddr(13) = '0') else axi_miso_i.arready ;
   Axi_Miso.rdata <= BRAM_Miso.rdata when (Axi_Mosi.araddr(13) = '0') else axi_miso_i.rdata ;
   Axi_Miso.rlast <= BRAM_Miso.rlast when (Axi_Mosi.araddr(13) = '0') else axi_miso_i.rlast ;
   Axi_Miso.rvalid <= BRAM_Miso.rvalid when (Axi_Mosi.araddr(13) = '0') else axi_miso_i.rvalid ;
   Axi_Miso.rresp <= BRAM_Miso.rresp when (Axi_Mosi.araddr(13) = '0') else axi_miso_i.rresp ;

   axi_miso_i.rlast <= '0';
   
   AWREADY_PROC : process (Sys_clk)
   begin
      if rising_edge(Sys_clk) then 
         if Rst = '1' then
            axi_miso_i.awready <= '0';
         else
            if (axi_miso_i.awready = '0' and axi_mosi_i.awvalid = '1' and axi_mosi_i.wvalid = '1' and axi_mosi_i.awaddr(13) = '1') then
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
         if Rst = '1' then
            axi_miso_i.wready <= '0';
         else
            if (axi_miso_i.wready = '0' and axi_mosi_i.awvalid = '1' and axi_mosi_i.wvalid = '1') then
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
         if Rst = '1' then
            cfg_waddr <= (others => '0');
         else
            if (axi_miso_i.wready = '0' and axi_mosi_i.awvalid = '1' and axi_mosi_i.wvalid = '1') then
               cfg_waddr <= axi_mosi_i.awaddr(11 downto 0);
            end if;
         end if;
      end if;
   end process CFG_WADDR_PROC; 

	cfg_wren <= axi_miso_i.wready and axi_mosi_i.wvalid and axi_miso_i.awready and axi_mosi_i.awvalid;
   
	WRITE_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then 
	    if Rst = '1' then
         nand_sm_i <= (others => '0');
         flash_command_out_i <= (others => '0');
         flash_command_ctrl_i <= (others => '1');
         flash_data_out_i <= (others => '0');
         flash_data_ctrl_i <= (others => '1');
	    else
	      if (cfg_wren = '1') then
	        case (cfg_waddr) is
	          when X"000" =>
                nand_sm_i <= axi_mosi_i.wdata(3 downto 0);

             when X"00C" =>
                flash_command_out_i <= axi_mosi_i.wdata(5 downto 0);

             when X"010" =>
                flash_command_ctrl_i <= axi_mosi_i.wdata(5 downto 0);
                
             when X"018" =>
                flash_data_out_i <= axi_mosi_i.wdata(7 downto 0);
                
             when X"01C" =>
                flash_data_ctrl_i <= axi_mosi_i.wdata(7 downto 0);

	          when others =>

             end case;
	      end if;
	    end if;
	  end if;                   
	end process WRITE_PROC; 
   
	BVALID_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then 
	    if Rst = '1' then
	      axi_miso_i.bvalid  <= '0';
	      axi_miso_i.bresp   <= "00";
	    else
	      if (axi_miso_i.awready = '1' and axi_mosi_i.awvalid = '1' and axi_miso_i.wready = '1' and axi_mosi_i.wvalid = '1' and axi_miso_i.bvalid = '0'  ) then
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
	    if Rst = '1' then
	      axi_miso_i.arready <= '0';
	      cfg_raddr  <= (others => '1');
	    else
	      if (axi_miso_i.arready = '0' and axi_mosi_i.arvalid = '1' and axi_mosi_i.araddr(13) = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_miso_i.arready <= '1';
	        -- Read Address latching 
	        cfg_raddr  <= axi_mosi_i.araddr(11 downto 0);           
	      else
	        axi_miso_i.arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process CFG_RADDR_PROC; 
   
	RVALID_PROC : process (Sys_clk)
	begin
	  if rising_edge(Sys_clk) then
	    if Rst = '1' then
	      axi_miso_i.rvalid <= '0';
	      axi_miso_i.rresp  <= "00";
	    else
	      if (axi_miso_i.arready = '1' and axi_mosi_i.arvalid = '1' and axi_miso_i.rvalid = '0') then
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

	READ_PROC : process (nand_sm_i, ReadyBusyN, Flash_Command_In, flash_command_out_i, 
                        flash_command_ctrl_i, Flash_Data_In, flash_data_out_i, flash_data_ctrl_i, 
                        cfg_raddr, Rst, cfg_rden)
	begin
	  if Rst = '1' then
	    cfg_read_data  <= (others => '0');
	  else
	    -- Address decoding for reading registers
	    case cfg_raddr is
	      when X"000" =>
	        cfg_read_data <= X"0000000" & nand_sm_i;
	      when X"004" =>
	        cfg_read_data <= "0000000000000000000000000000" & ReadyBusyN;
	      when X"008" =>
	        cfg_read_data <= X"000000" & "00" & Flash_Command_In;
	      when X"00C" =>
	        cfg_read_data <= X"000000" & "00" &  flash_command_out_i;
	      when X"010" =>
	        cfg_read_data <= X"000000" & "00" &  flash_command_ctrl_i;
	      when X"014" =>
	        cfg_read_data <= X"000000" & Flash_Data_In;
	      when X"018" =>
	        cfg_read_data <= X"000000" & flash_data_out_i;
	      when X"01C" =>
	        cfg_read_data <= X"000000" & flash_data_ctrl_i;
	      when others =>
	        cfg_read_data  <= (others => '0');
	    end case;
	  end if;
	end process; 

	OUTPUT_READ_PROC : process( Sys_clk ) is
	begin
	  if (rising_edge (Sys_clk)) then
	    if ( Rst = '1' ) then
	      axi_miso_i.rdata  <= (others => '0');
	    else
	      if (cfg_rden = '1') then
	          axi_miso_i.rdata <= cfg_read_data;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;
   
end implementation;
