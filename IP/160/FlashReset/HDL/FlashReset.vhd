------------------------------------------------------------------
--!   @file FlashReset.vhd
--!   @brief Main Flash reset module for the block design 
--!   @details This module implements the top-level interface to the block design
--!            for the flash reset IP and the higher operational logic. It integrates the 
--!            AXI Lite slave/master interfaces from lower modules, and the SPI state machine. 
--!
--!   $Rev: 23236 $
--!   $Author: elarouche $
--!   $Date: 2019-04-10 15:08:01 -0400 (mer., 10 avr. 2019) $
--!   $Id: FlashReset.vhd 23236 2019-04-10 19:08:01Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/IP/160/FlashReset/HDL/FlashReset.vhd $
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.FRPKG.all;

entity FlashReset is
   generic (
        CLOCK_FREQ : natural := 100000000;          -- AXI clock frequency (in Hz)
        INTR_MASK_PERIOD : natural := 5;            -- Interrupt suppression period (in seconds)
        FLASH_RESET_BUTTON_COUNT : natural := 3;    -- Number of button press to initiate flash reset
        FLASH_RESET_SECTOR_ADDR : std_logic_vector(23 downto 0) := X"FF0000"; -- Flash Sector Address of GC Store
        QSPI_BASE_ADDR : std_logic_vector(31 downto 0) := X"44B6_0000" -- Flash controller base address        
    );
	port (
		button : in std_logic;

		-- Ports of Axi Slave Bus Interface S_AXI
		s_axi_aclk	: in std_logic;
		s_axi_aresetn	: in std_logic;
		s_axi_awaddr	: in std_logic_vector(0 downto 0);
		s_axi_awprot	: in std_logic_vector(2 downto 0);
		s_axi_awvalid	: in std_logic;
		s_axi_awready	: out std_logic;
		s_axi_wdata	: in std_logic_vector(31 downto 0);
		s_axi_wstrb	: in std_logic_vector(3 downto 0);
		s_axi_wvalid	: in std_logic;
		s_axi_wready	: out std_logic;
		s_axi_bresp	: out std_logic_vector(1 downto 0);
		s_axi_bvalid	: out std_logic;
		s_axi_bready	: in std_logic;
		s_axi_araddr	: in std_logic_vector(0 downto 0);
		s_axi_arprot	: in std_logic_vector(2 downto 0);
		s_axi_arvalid	: in std_logic;
		s_axi_arready	: out std_logic;
		s_axi_rdata	: out std_logic_vector(31 downto 0);
		s_axi_rresp	: out std_logic_vector(1 downto 0);
		s_axi_rvalid	: out std_logic;
		s_axi_rready	: in std_logic;

        ip2intc_irpt : out std_logic;
		
		-- Ports of Axi Master Bus Interface M_AXI
        m_axi_aclk    : in std_logic;
        m_axi_aresetn    : in std_logic;
        m_axi_awaddr    : out std_logic_vector(31 downto 0);
        m_axi_awprot    : out std_logic_vector(2 downto 0);
        m_axi_awvalid    : out std_logic;
        m_axi_awready    : in std_logic;
        m_axi_wdata    : out std_logic_vector(31 downto 0);
        m_axi_wstrb    : out std_logic_vector(3 downto 0);
        m_axi_wvalid    : out std_logic;
        m_axi_wready    : in std_logic;
        m_axi_bresp    : in std_logic_vector(1 downto 0);
        m_axi_bvalid    : in std_logic;
        m_axi_bready    : out std_logic;
        m_axi_araddr    : out std_logic_vector(31 downto 0);
        m_axi_arprot    : out std_logic_vector(2 downto 0);
        m_axi_arvalid    : out std_logic;
        m_axi_arready    : in std_logic;
        m_axi_rdata    : in std_logic_vector(31 downto 0);
        m_axi_rresp    : in std_logic_vector(1 downto 0);
        m_axi_rvalid    : in std_logic;
        m_axi_rready    : out std_logic
	);
end FlashReset;

architecture rtl of FlashReset is

-- Flash commands
constant FLASH_CMD_WRITE_ENABLE : t_byte_array(0 to 3) :=  (X"06", X"00", X"00", X"00");
constant FLASH_CMD_ERASE_SECTOR : t_byte_array(0 to 3) :=  (X"D8", FLASH_RESET_SECTOR_ADDR(23 downto 16),
                                                                   FLASH_RESET_SECTOR_ADDR(15 downto 8),
                                                                   FLASH_RESET_SECTOR_ADDR(7 downto 0) );

component double_sync
  generic(
       INIT_VALUE : BIT := '0'
  );
  port (
       CLK : in STD_LOGIC;
       D : in STD_LOGIC;
       RESET : in STD_LOGIC;
       Q : out STD_LOGIC := '0'
  );
end component;

component FlashReset_Slave is
  generic (
     CLOCK_FREQ : natural;
     INTR_MASK_PERIOD : natural
   );
   port (
        button : in std_logic;
        timer_exp : out std_logic;
		s_axi_aclk	: in std_logic;
		s_axi_aresetn	: in std_logic;
		s_axi_mosi : in t_axi4_lite_mosi;
		s_axi_miso : out t_axi4_lite_miso;
		ip2intc_irpt : out std_logic
	);
end component FlashReset_Slave;

component FlashReset_Master is
	port (
        txn_addr : in std_logic_vector(31 downto 0);
        txn_wdata : in std_logic_vector(31 downto 0);
        txn_wstart : in std_logic;
        txn_rdata : out std_logic_vector(31 downto 0);
        txn_rstart : in std_logic;
        txn_done : out std_logic;
        txn_error : out std_logic;         
		m_axi_aclk    : in std_logic;
        m_axi_aresetn : in std_logic;
        m_axi_mosi : out t_axi4_lite_mosi;
        m_axi_miso : in t_axi4_lite_miso
	);
end component FlashReset_Master;

component QSPI_FSM is
  Generic (
    QSPI_BASE_ADDR : std_logic_vector(31 downto 0)
  );
  Port ( 
		  m_axi_aclk : in std_logic;
		  m_axi_aresetn : in std_logic;
          qspi_data : in t_byte_array(0 to 3);
          qspi_data_len : in integer range 1 to 4;          
          qspi_start : in std_logic;
          qspi_done : out std_logic;
          axi_txn_addr : out std_logic_vector(31 downto 0);
          axi_txn_wdata : out std_logic_vector(31 downto 0);
          axi_txn_wstart : out std_logic;
          axi_txn_rdata : in std_logic_vector(31 downto 0);
          axi_txn_rstart : out std_logic;
          axi_txn_done : in std_logic;
          axi_txn_error : in std_logic          
  );
end component QSPI_FSM;


-- Internal signals
signal reset : std_logic;
signal button_i : std_logic;
signal button_p : std_logic;
signal button_neg_edge : std_logic;
signal count : integer range 0 to FLASH_RESET_BUTTON_COUNT := 0;
signal count_reset : std_logic;
signal count_reset1 : std_logic;
signal count_reset2 : std_logic;
signal timer_exp : std_logic;
signal reset_flash : std_logic := '0';
signal txn_addr : std_logic_vector(31 downto 0);
signal txn_wdata : std_logic_vector(31 downto 0);
signal txn_wstart : std_logic;
signal txn_rdata : std_logic_vector(31 downto 0);
signal txn_rstart : std_logic;
signal txn_done : std_logic;
signal txn_error : std_logic;
signal qspi_data : t_byte_array(0 to 3); 
signal qspi_data_len : integer range 1 to 4;          
signal qspi_start : std_logic;
signal qspi_done : std_logic;

-- FSM state
type state_t is ( IDLE, WRITE_ENABLE, ERASE_SECTOR );
signal state  : state_t := IDLE;


begin

	--
	-- Synchronizer
	--
    reset <= not s_axi_aresetn;
    U1 : double_sync
    generic map ( INIT_VALUE => '1' )
    port map(
       CLK => s_axi_aclk,
       D => button,
       Q => button_i,
       RESET => reset
    );

    --
    -- AXI slave side
    --
    U2 : FlashReset_Slave
    generic map ( CLOCK_FREQ => CLOCK_FREQ,
                  INTR_MASK_PERIOD => INTR_MASK_PERIOD )
    port map(
        button => button_i,
        timer_exp => timer_exp,
        s_axi_aclk => s_axi_aclk,
        s_axi_aresetn => s_axi_aresetn,
        s_axi_mosi.awaddr => s_axi_awaddr,
        s_axi_mosi.awprot => s_axi_awprot,
        s_axi_mosi.awvalid => s_axi_awvalid,
        s_axi_mosi.wdata => s_axi_wdata,
        s_axi_mosi.wstrb => s_axi_wstrb,
        s_axi_mosi.wvalid => s_axi_wvalid,
        s_axi_mosi.bready => s_axi_bready,
        s_axi_mosi.araddr => s_axi_araddr, 
        s_axi_mosi.arprot => s_axi_arprot, 
        s_axi_mosi.arvalid => s_axi_arvalid, 
        s_axi_mosi.rready => s_axi_rready,
        s_axi_miso.rvalid => s_axi_rvalid,
        s_axi_miso.awready => s_axi_awready,        
        s_axi_miso.wready => s_axi_wready,
        s_axi_miso.bresp => s_axi_bresp,
        s_axi_miso.bvalid => s_axi_bvalid,
        s_axi_miso.arready => s_axi_arready,
        s_axi_miso.rdata => s_axi_rdata,
        s_axi_miso.rresp => s_axi_rresp,
        ip2intc_irpt => ip2intc_irpt
    );
    

    --
    -- AXI master side
    --
    U3 : FlashReset_Master
    port map(
        txn_addr => txn_addr,
        txn_wdata => txn_wdata,
        txn_wstart => txn_wstart,
        txn_rdata => txn_rdata, 
        txn_rstart => txn_rstart,
        txn_done => txn_done,
        txn_error => txn_error,         
        m_axi_aclk => m_axi_aclk,
        m_axi_aresetn => m_axi_aresetn,
        m_axi_mosi.awaddr => m_axi_awaddr,
        m_axi_mosi.awprot => m_axi_awprot,
        m_axi_mosi.awvalid => m_axi_awvalid,
        m_axi_mosi.wdata => m_axi_wdata,
        m_axi_mosi.wstrb => m_axi_wstrb,
        m_axi_mosi.wvalid => m_axi_wvalid,
        m_axi_mosi.bready => m_axi_bready,
        m_axi_mosi.araddr => m_axi_araddr, 
        m_axi_mosi.arprot => m_axi_arprot, 
        m_axi_mosi.arvalid => m_axi_arvalid,
        m_axi_mosi.rready => m_axi_rready,         
        m_axi_miso.awready => m_axi_awready,
        m_axi_miso.wready => m_axi_wready,
        m_axi_miso.bresp => m_axi_bresp,
        m_axi_miso.bvalid => m_axi_bvalid,
        m_axi_miso.arready => m_axi_arready,
        m_axi_miso.rdata => m_axi_rdata, 
        m_axi_miso.rresp => m_axi_rresp,
        m_axi_miso.rvalid => m_axi_rvalid
    );


    --
    -- QSPI State Machine
    --
    U5 : QSPI_FSM
    generic map ( 
      QSPI_BASE_ADDR => QSPI_BASE_ADDR
    )
    port map(
        m_axi_aclk => m_axi_aclk,
        m_axi_aresetn => m_axi_aresetn,
        qspi_data => qspi_data,
        qspi_data_len => qspi_data_len,
        qspi_start => qspi_start,
        qspi_done => qspi_done,
        axi_txn_addr => txn_addr,
        axi_txn_wdata => txn_wdata,
        axi_txn_wstart => txn_wstart,
        axi_txn_rdata => txn_rdata,
        axi_txn_rstart => txn_rstart,
        axi_txn_done => txn_done,
        axi_txn_error => txn_error        
    );
    

    -- Latch button state
    BUTTON_PROC : process(S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            button_p <= button_i;
        end if;
    end process BUTTON_PROC;

    -- Button negative edge detection
    button_neg_edge <= button_p and not button_i;
    

    -- Button press counter
    count_reset2 <= timer_exp;
    count_reset <= count_reset1 or count_reset2;
    COUNTER_PROC : process(S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if (S_AXI_ARESETN = '0' or count_reset = '1') then
                count <= 0;
            elsif (button_neg_edge = '1') then
                count <= count + 1;
            end if;
        end if;
    end process COUNTER_PROC;


    -- Reset flash signal generation
    RESET_FLASH_PROC : process(S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then
            if (S_AXI_ARESETN = '0') then
                reset_flash <= '0';
            elsif (reset_flash = '0' and count = FLASH_RESET_BUTTON_COUNT) then
                reset_flash <= '1';
                count_reset1 <= '1';
            else
                reset_flash <= '0';
                count_reset1 <= '0';
            end if;
        end if;
    end process RESET_FLASH_PROC;
    

    --
    -- Main State Machine
    --
    FSM_STATE_PROC : process(m_axi_aclk)
    begin
        if rising_edge(m_axi_aclk) then
            if (m_axi_aresetn = '0') then
                state <= IDLE;
            else
                case (state) is                                                                    
                    when IDLE => -- Idle state: waiting for a command
                        if (reset_flash = '1') then
                            qspi_data <= FLASH_CMD_WRITE_ENABLE;
                            qspi_data_len <= 1;
                            qspi_start <= '1';
                            state <= WRITE_ENABLE;
                        end if;
                        
                    when WRITE_ENABLE => -- Send Write enable command to the Flash 
                        qspi_start <= '0';
                        if (qspi_done = '1') then
                            qspi_data <= FLASH_CMD_ERASE_SECTOR;
                            qspi_data_len <= 4;
                            qspi_start <= '1';
                            state <= ERASE_SECTOR;
                        end if;                                                

                    when ERASE_SECTOR => -- Send Erase sector command to the Flash
                        qspi_start <= '0';
                        if (qspi_done = '1') then
                            state <= IDLE;
                        end if;                                                

                    when others  =>                                                                           
                        state <= IDLE;
                end case;                                                      
            end if;
        end if;
    end process FSM_STATE_PROC;

end rtl;
