-------------------------------------------------------------------------------
--
-- Title       : adc TB STIM
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : 
-- From        : interface description file
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;                                             
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity adc_tb_stim is
   port(
      --------------------------------
      -- PowerPC Interface
      -------------------------------- 
      AXIL_MOSI : out t_axi4_lite_mosi;
      AXIL_MISO : in t_axi4_lite_miso;  
      
      CLK   : out STD_LOGIC;
      ARESET   : out STD_LOGIC
      );
end adc_tb_stim;

architecture rtl of adc_tb_stim is
   
   -- CLK and RESET
   signal clk_o : std_logic := '0';
   signal rst_i : std_logic := '0';
   
   signal r_i	: std_logic_vector(31 downto 0) := (others => '0'); 
   signal q_i   : std_logic_vector(31 downto 0) := (others => '0');  
   signal cfg_i	: std_logic_vector(31 downto 0) := (others => '0');  
   signal switch_i	: std_logic_vector(31 downto 0) := (others => '0');   
   
   signal read_value: std_logic_vector(31 downto 0) := (others => '0');

   signal lock : std_logic_vector(31 downto 0) := (others => '0');
   
   constant C_S_AXI_DATA_WIDTH : integer := 32;
   constant C_S_AXI_ADDR_WIDTH : integer := 32;
   constant ADDR_LSB           : integer := 2;   -- 4 bytes access
   constant OPT_MEM_ADDR_BITS  : integer := 5;   -- Number of supplement bit
   constant ADDR_LENGTH        : integer := ADDR_LSB + 1 + OPT_MEM_ADDR_BITS;
   
   ----------------------------   
   -- Address of registers
   ---------------------------- 
	
   constant ADC_ENABLE_OFFSET          	  : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(0,ADDR_LENGTH));
   constant ADC_R_OFFSET                  : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(4,ADDR_LENGTH));
   constant ADC_Q_OFFSET                  : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(8,ADDR_LENGTH));
   constant ADC_CFG_VALID                 : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(12,ADDR_LENGTH));
  
   --constant r_i : UNSIGNED := to_unsigned(1, 32);
   -- CLK and RESET
   constant CLK_per : time := 10 ns;

begin
   -- Assign clock
   CLK <= clk_o;
   ARESET <= rst_i;
   
   CLK_GEN: process(clk_o)
   begin
      clk_o <= not clk_o after CLK_per/2;                          
   end process;
   
   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for 5 us;
      rst_i <= '0'; 
      wait;
   end process;
   
	MB_PROCESS : process 
	variable j : integer := 0; 
	
	begin     
		r_i <= std_logic_vector(to_unsigned(65536, 32));		-- ri = 1.0f/m pre calib m = 1.0f donc ri 1.0f = 65536 au format S15Q16
		q_i <= std_logic_vector(to_unsigned(491510, 32));   	-- qi = 
		--q_i <= std_logic_vector(to_unsigned(65536, 32));   	-- qi =
		cfg_i <= std_logic_vector(to_unsigned(0, 32)); 
		switch_i <= std_logic_vector(to_unsigned(1, 32)); 
	  
		AXIL_MOSI.ARVALID   <= '0';
		AXIL_MOSI.ARADDR    <= (others => '0');
		AXIL_MOSI.ARPROT    <= (others => '0');
		AXIL_MOSI.RREADY    <= '0';
		AXIL_MOSI.AWADDR    <= (others => '0');
		AXIL_MOSI.AWVALID	<= '0';
		AXIL_MOSI.AWPROT    <= (others => '0');
		AXIL_MOSI.BREADY	   <='0';
		AXIL_MOSI.WDATA	   <= (others => '0');
		AXIL_MOSI.WVALID	   <= '0';
		AXIL_MOSI.WSTRB	   <= (others =>'0');
		AXIL_MOSI.ARVALID	<= '0';
		AXIL_MOSI.RREADY	   <= '0';
		
		lock <=  (others =>'0');
      
		wait until rst_i = '0';
		wait for 1 us;
      
		-- send initial config : ri et qi	   
		wait until rising_edge(clk_o);
		write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ADC_CFG_VALID'length))& ADC_CFG_VALID, cfg_i, AXIL_MISO, AXIL_MOSI); 
		wait for 20 ns; 
		wait until rising_edge(clk_o);
      	write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ADC_R_OFFSET'length))& ADC_R_OFFSET, r_i, AXIL_MISO, AXIL_MOSI);   
		wait for 20 ns; 
		wait until rising_edge(clk_o);
      	write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ADC_Q_OFFSET'length))& ADC_Q_OFFSET, q_i, AXIL_MISO, AXIL_MOSI);
		wait for 20 ns; 
		wait until rising_edge(clk_o);
      	write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ADC_ENABLE_OFFSET'length)) & ADC_ENABLE_OFFSET,  switch_i, AXIL_MISO, AXIL_MOSI);   -- switch to adc readout
		wait for 20 ns; 
		wait until rising_edge(clk_o);
      	write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ADC_CFG_VALID'length)) & ADC_CFG_VALID, switch_i, AXIL_MISO, AXIL_MOSI);
		wait for 20 ns; 
		wait until rising_edge(clk_o);
	 
		--READ axi register
		read_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32)), AXIL_MISO, AXIL_MOSI, read_value);
		wait for 20ns;
		wait until rising_edge(clk_o);	
		
		read_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32)), AXIL_MISO, AXIL_MOSI, read_value);
		wait for 1 ms;
      
   end process MB_PROCESS;
   
   
end rtl;
