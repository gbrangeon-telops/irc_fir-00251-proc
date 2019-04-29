------------------------------------------------------------------
--!   @file FlashReset_Slave.vhd
--!   @brief Flash reset AXI slave interface
--!   @details This module implements the AXI slave interface to the power button 
--!            and interrupt management. 
--!
--!   $Rev: 23236 $
--!   $Author: elarouche $
--!   $Date: 2019-04-10 15:08:01 -0400 (mer., 10 avr. 2019) $
--!   $Id: FlashReset_Slave.vhd 23236 2019-04-10 19:08:01Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/IP/325/FlashReset/HDL/FlashReset_Slave.vhd $
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;

entity FlashReset_Slave is
   generic (
     CLOCK_FREQ : natural;                     -- AXI clock frequency (in Hz)
     INTR_MASK_PERIOD : natural                -- interrupt suppression period (in seconds)
    );
	port (
        button : in std_logic;                 -- power button
        timer_exp : out std_logic;             -- timer expiration 

		-- Ports of AXI Lite Slave Bus Interface
		s_axi_aclk	: in std_logic;            -- AXI clock
        s_axi_aresetn : in std_logic;          -- AXI reset
		s_axi_mosi : in t_axi4_lite_mosi;      -- AXI MOSI
		s_axi_miso : out t_axi4_lite_miso;     -- AXI MISO
		
		ip2intc_irpt : out std_logic           -- interrupt line
	);
end FlashReset_Slave;

architecture rtl of FlashReset_Slave is

-- Constants
constant INTR_COUNTER_MAX : natural := CLOCK_FREQ * INTR_MASK_PERIOD - 1; -- maximal count

-- Interrupt port
ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_INFO of ip2intc_irpt: SIGNAL is "xilinx.com:signal:interrupt:1.0 ip2intc_irpt INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER of ip2intc_irpt: SIGNAL is "SENSITIVITY EDGE_RISING";

-- AXI4LITE signals
signal axi_arready	: std_logic;
signal axi_rdata	: std_logic_vector(31 downto 0);
signal axi_rvalid	: std_logic;

-- Input logic
signal slv_reg_rden	: std_logic;
signal reg_data_out	:std_logic_vector(31 downto 0);
signal button_p : std_logic := '1';
signal button_pos_edge : std_logic;
signal button_change : std_logic;

-- Interrupt mask counter
signal intr_cnt : integer range 0 to INTR_COUNTER_MAX := 0;
signal intr_cnt_ce : std_logic := '0';

begin

	-- I/O Connections
	S_AXI_MISO.ARREADY <= axi_arready;
	S_AXI_MISO.RDATA <= axi_rdata;
	S_AXI_MISO.RVALID <= axi_rvalid;
	
    -- Write and response channels: do nothing
    S_AXI_MISO.AWREADY <= '0';
	S_AXI_MISO.WREADY <= '0';
	S_AXI_MISO.BVALID <= '0';
    S_AXI_MISO.BRESP <= "00";
    
    -- Data response
    S_AXI_MISO.RRESP <= "00";
    
	-- Read address ready signal generation
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	    else
	      if (axi_arready <= '0' and S_AXI_MOSI.ARVALID = '1') then
	        axi_arready <= '1';
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process;
	 
	-- Read data valid signal generation
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	    else
	      if slv_reg_rden = '1' then
	        axi_rvalid <= '1';
	      elsif (axi_rvalid = '1' and S_AXI_MOSI.RREADY = '1') then
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;
	
	-- Read logic generation and register mapping
	slv_reg_rden <= axi_arready and (not axi_rvalid) ;
	reg_data_out(0) <= button;
	reg_data_out(31 downto 1) <= (others => '0'); 
	
	-- Output register or memory read data
	process( S_AXI_ACLK ) is
	begin
	  if (rising_edge (S_AXI_ACLK)) then
	    if ( S_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_reg_rden = '1') then
	          axi_rdata <= reg_data_out;
	      end if;   
	    end if;
	  end if;
	end process;
    
    -- Latch button state
    BUTTON_PROC : process(S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            button_p <= button;
        end if;
    end process BUTTON_PROC;
    

    --
    -- Interrupt generation
    --
    
    -- Interrupt mask counter
    COUNTER_PROC : process(S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if (S_AXI_ARESETN = '0') then
                intr_cnt <= 0;
            elsif (intr_cnt_ce = '1') then
                if (intr_cnt = INTR_COUNTER_MAX) then
                    intr_cnt <= 0;
                else
                    intr_cnt <= intr_cnt + 1;
                end if;
            end if;  
        end if;
    end process COUNTER_PROC;
    
    -- Interrupt mask counter enable
    COUNTER_CE_PROC : process(S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if (S_AXI_ARESETN = '0') then
                intr_cnt_ce <= '0';
            else
                if (intr_cnt_ce = '0' and button_pos_edge = '1') then
                    intr_cnt_ce <= '1';
                elsif (intr_cnt_ce = '1' and intr_cnt = INTR_COUNTER_MAX) then
                    intr_cnt_ce <= '0';
                end if;
            end if;    
        end if;
    end process COUNTER_CE_PROC;
    
    -- Timer expiration signal for button press counter
    timer_exp <= '1' when intr_cnt = INTR_COUNTER_MAX else '0';
    
    -- button change detection
    button_change <= button xor button_p;
    button_pos_edge <= not button_p and button;
    
    -- Interrupt with mask
    ip2intc_irpt <= button_change and not intr_cnt_ce;

end rtl;
