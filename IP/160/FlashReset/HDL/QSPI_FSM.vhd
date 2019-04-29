------------------------------------------------------------------
--!   @file QSPI_FSM.vhd
--!   @brief   QSPI State Machine
--!   @details This module implements a state machine for intefacing to the AXI Quad SPI IP block. 
--!            It produces the right programming sequence for the SPI core. 
--!            It supports generic data commands with a simplified user interface.
--!
--!   $Rev: 22950 $
--!   $Author: elarouche $
--!   $Date: 2019-02-28 14:27:55 -0500 (jeu., 28 févr. 2019) $
--!   $Id: QSPI_FSM.vhd 22950 2019-02-28 19:27:55Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/IP/160/FlashReset/HDL/QSPI_FSM.vhd $
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.FRPKG.all;


entity QSPI_FSM is
  Generic (
    QSPI_BASE_ADDR : std_logic_vector(31 downto 0)
  );
  Port (
          -- AXI Interface 
		  m_axi_aclk : in std_logic;                  -- AXI clock
          m_axi_aresetn : in std_logic;		          -- AXI reset  
          
          -- User interface
          qspi_data : in t_byte_array(0 to 3);         -- input data byte array
          qspi_data_len : in natural range 1 to 4;     -- input data count (in bytes)          
          qspi_start : in std_logic;                   -- start transaction handshake signal
          qspi_done : out std_logic;                   -- transaction termination handshake signal
          
          -- FlashReset Master interface
          axi_txn_addr : out std_logic_vector(31 downto 0);
          axi_txn_wdata : out std_logic_vector(31 downto 0);
          axi_txn_wstart : out std_logic;
          axi_txn_rdata : in std_logic_vector(31 downto 0);
          axi_txn_rstart : out std_logic;
          axi_txn_done : in std_logic;
          axi_txn_error : in std_logic
  );
end QSPI_FSM;

architecture rtl of QSPI_FSM is

-- Hardware delay (for Slave Select deassertion)
constant DELAY_COUNT_MAX : natural := 10;

-- Data byte maximum count
constant DATA_COUNT_MAX : natural := 3;

-- Addresses of the QSPI AXI IP registers
constant QSPI_SPICR_OFF : integer := 16#60#;
constant QSPI_SPISR_OFF : integer := 16#64#;
constant QSPI_DTR_OFF : integer := 16#68#;
constant QSPI_DGIER_OFF : integer := 16#1C#;
constant QSPI_SPISSR_OFF : integer := 16#70#;
constant QSPI_SPICR_ADDR : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(QSPI_BASE_ADDR) + QSPI_SPICR_OFF);
constant QSPI_SPISR_ADDR : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(QSPI_BASE_ADDR) + QSPI_SPISR_OFF);
constant QSPI_DGIER_ADDR : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(QSPI_BASE_ADDR) + QSPI_DGIER_OFF);
constant QSPI_DTR_ADDR : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(QSPI_BASE_ADDR) + QSPI_DTR_OFF);
constant QSPI_SPISSR_ADDR : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(QSPI_BASE_ADDR) + QSPI_SPISSR_OFF);

-- Command/mask constants
constant CMD_RESET_SPICR : std_logic_vector(31 downto 0) := X"000001E6";            -- reset control register
constant CMD_ENABLE_MASTER_TXN : std_logic_vector(31 downto 0) := X"00000086";      -- enable master transaction
constant CMD_DISABLE_MASTER_TXN : std_logic_vector(31 downto 0) := X"00000186";     -- disable master transaction
constant CMD_DISABLE_INTR : std_logic_vector(31 downto 0) := X"00000000";           -- disable interrupts
constant CMD_ENABLE_INTR : std_logic_vector(31 downto 0) := X"80000000";            -- enable interrupts
constant CMD_ASSERT_SS : std_logic_vector(31 downto 0) := X"00000000";              -- assert slave select
constant CMD_DEASSERT_SS : std_logic_vector(31 downto 0) := X"00000001";            -- deassert slave select
constant SR_TX_FIFO_EMPTY_BIT : natural := 2;                                       -- Tx FIFO empty status bit

-- FSM state
type state_t is ( IDLE, INIT_SPICR, RESET_DGIER, WRITE_DTR, ASSERT_SS, ENABLE_MASTER_TXN,
                  READ_STATUS, VERIFY_FIFO, DELAY, DEASSERT_SS, DISABLE_MASTER_TXN, RESET_FIFO, 
                  ENABLE_INTERRUPT, SIGNAL_DONE );
signal state  : state_t := IDLE;

-- Data counter
signal data_cnt : integer range 0 to DATA_COUNT_MAX := 0;
signal data_cnt_ce : std_logic := '0';
signal data_cnt_reset : std_logic := '0';

-- Delay counter
signal delay_cnt : integer range 0 to DELAY_COUNT_MAX := 0;
signal delay_cnt_ce : std_logic := '0';
signal delay_cnt_reset : std_logic := '0';

begin
    
    --
    -- AXI Quad SPI IP State Machine
    --
    FSM_STATE_PROC : process(m_axi_aclk)
    begin
        if rising_edge(m_axi_aclk) then
            if (m_axi_aresetn = '0') then
                state <= IDLE;
                axi_txn_addr <= (others => '0');
                axi_txn_wdata <= (others => '0');
                axi_txn_wstart <= '0';
                data_cnt_ce <= '0';
                data_cnt_reset <= '0';
                delay_cnt_ce <= '0';
                delay_cnt_reset <= '0';
                qspi_done <= '0';
            else
                case (state) is                                                                    
                    when IDLE => -- Idle state: waiting for a command
                        if (qspi_start = '1') then
                            axi_txn_addr <= QSPI_SPICR_ADDR;
                            axi_txn_wdata <= CMD_RESET_SPICR;
                            axi_txn_wstart <= '1';
                            state <= INIT_SPICR;
                        end if;
                        
                    when INIT_SPICR => -- Eeset the SPI control register
                        axi_txn_wstart <= '0'; 
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_DGIER_ADDR;
                            axi_txn_wdata <= CMD_DISABLE_INTR;
                            axi_txn_wstart <= '1';
                            state <= RESET_DGIER;
                        end if;       
                        
                    when RESET_DGIER => -- Global disable interrupts
                        axi_txn_wstart <= '0';                    
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_DTR_ADDR;
                            axi_txn_wdata <= X"000000" & qspi_data(0);
                            axi_txn_wstart <= '1';
                            data_cnt_reset <= '1';
                            state <= WRITE_DTR;
                        end if;       

                    when WRITE_DTR => -- Write data to Tx FIFO
                        axi_txn_wstart <= '0';                    
                        data_cnt_reset <= '0';
                        data_cnt_ce <= '0';
                        if (axi_txn_done = '1') then
                            if (data_cnt = qspi_data_len - 1) then
                                axi_txn_addr <= QSPI_SPISSR_ADDR;
                                axi_txn_wdata <= CMD_ASSERT_SS;
                                axi_txn_wstart <= '1';
                                state <= ASSERT_SS;
                            else
                                axi_txn_wdata <= X"000000" & qspi_data(data_cnt + 1);
                                axi_txn_wstart <= '1';
                                data_cnt_ce <= '1';        
                            end if;
                        end if;
                        
                    when ASSERT_SS => -- Assert Slave Select
                        axi_txn_wstart <= '0';                    
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_SPICR_ADDR;
                            axi_txn_wdata <= CMD_ENABLE_MASTER_TXN;
                            axi_txn_wstart <= '1';
                            state <= ENABLE_MASTER_TXN;
                        end if;
                    
                    when ENABLE_MASTER_TXN => -- Enable master transaction, start the SPI clock
                        axi_txn_wstart <= '0';
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_SPISR_ADDR;
                            axi_txn_rstart <= '1';
                            state <= READ_STATUS;
                        end if;
                    
                    when READ_STATUS => -- Read status register
                        if (axi_txn_done = '1') then
                            state <= VERIFY_FIFO;
                        else
                            axi_txn_rstart <= '0';
                        end if;
                        
                    when VERIFY_FIFO => -- Verify Tx FIFO occupancy
                        if (axi_txn_rdata(SR_TX_FIFO_EMPTY_BIT) = '0') then
                            axi_txn_rstart <= '1';
                            state <= READ_STATUS;
                        else
                            delay_cnt_reset <= '1';
                            delay_cnt_ce <= '1';
                            state <= DELAY;
                        end if;
                     
                   when DELAY => -- Hardware delay (for Slave Select)
                        delay_cnt_reset <= '0';
                        if (delay_cnt = DELAY_COUNT_MAX) then
                            delay_cnt_reset <= '1';
                            delay_cnt_ce <= '0';
                            axi_txn_addr <= QSPI_SPISSR_ADDR;
                            axi_txn_wdata <= CMD_DEASSERT_SS;
                            axi_txn_wstart <= '1';
                            state <= DEASSERT_SS;
                        end if;
                        
                    when DEASSERT_SS => -- Deassert Slave Select
                        axi_txn_wstart <= '0';                    
                        delay_cnt_reset <= '0';
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_SPICR_ADDR;
                            axi_txn_wdata <= CMD_DISABLE_MASTER_TXN;
                            axi_txn_wstart <= '1';
                            state <= DISABLE_MASTER_TXN;
                        end if;                       

                    when DISABLE_MASTER_TXN => -- Disable master transaction
                        axi_txn_wstart <= '0';
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_SPICR_ADDR;
                            axi_txn_wdata <= CMD_RESET_SPICR;
                            axi_txn_wstart <= '1';
                            state <= RESET_FIFO;
                        end if;         

                    when RESET_FIFO => -- Reset FIFOs
                        axi_txn_wstart <= '0';                    
                        if (axi_txn_done = '1') then
                            axi_txn_addr <= QSPI_DGIER_ADDR;
                            axi_txn_wdata <= CMD_ENABLE_INTR;
                            axi_txn_wstart <= '1';
                            state <= ENABLE_INTERRUPT;
                        end if;         

                    when ENABLE_INTERRUPT => -- enable interrupts
                        axi_txn_wstart <= '0';                    
                        if (axi_txn_done = '1') then
                            qspi_done <= '1';
                            state <= SIGNAL_DONE;
                        end if;         
                    
                    when SIGNAL_DONE => -- Signal done
                        qspi_done <= '0';
                        state <= IDLE;

                    when others  =>                                                                           
                        state <= IDLE;
                end case;                                                      
            end if;
        end if;
    end process FSM_STATE_PROC;

    
    --
    -- Data counter
    --
    DATA_COUNT_PROC : process(m_axi_aclk)
    begin
        if rising_edge(m_axi_aclk) then
            if (m_axi_aresetn = '0' or data_cnt_reset = '1') then
                data_cnt <= 0;
            elsif (data_cnt_ce = '1') then 
                data_cnt <= data_cnt + 1;
            end if;
        end if;
    end process DATA_COUNT_PROC;


    --
    -- Delay counter
    --
    DELAY_PROC : process(m_axi_aclk)
    begin
        if rising_edge(m_axi_aclk) then
            if (m_axi_aresetn = '0' or delay_cnt_reset = '1') then
                delay_cnt <= 0;
            elsif (delay_cnt_ce = '1') then 
                delay_cnt <= delay_cnt + 1;
            end if;
        end if;
    end process DELAY_PROC;

end rtl;
