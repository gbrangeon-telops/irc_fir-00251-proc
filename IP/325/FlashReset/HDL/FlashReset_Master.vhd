------------------------------------------------------------------
--!   @file FlashReset_Master.vhd
--!   @brief Flash reset AXI master interface
--!   @details This module implements a generic AXI master interface for data transactions
--!            with a simplified user logic interface with start/done handshaking. 
--!            It supports both read and write transactions. 
--!
--!   $Rev: 23236 $
--!   $Author: elarouche $
--!   $Date: 2019-04-10 15:08:01 -0400 (mer., 10 avr. 2019) $
--!   $Id: FlashReset_Master.vhd 23236 2019-04-10 19:08:01Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/IP/325/FlashReset/HDL/FlashReset_Master.vhd $
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;

entity FlashReset_Master is
	port (
        -- User interface
        txn_addr : in std_logic_vector(31 downto 0);    -- transaction address
        txn_wdata : in std_logic_vector(31 downto 0);   -- write transaction data
        txn_wstart : in std_logic;                      -- start write transaction handshake signal
        txn_rdata : out std_logic_vector(31 downto 0);  -- read transaction data
        txn_rstart : in std_logic;                      -- start read transaction handshake signal
        txn_done : out std_logic;                       -- transaction termination handshake signal
        txn_error : out std_logic;                      -- error flag

		-- Ports of AXI Lite Master Bus Interface
		m_axi_aclk    : in std_logic;                   -- AXI clock
        m_axi_aresetn : in std_logic;                   -- AXI reset
		m_axi_mosi : out t_axi4_lite_mosi;              -- AXI MOSI
        m_axi_miso : in t_axi4_lite_miso                -- AXI MISO
	);
end FlashReset_Master;

architecture rtl of FlashReset_Master is

-- FSM state
type state_t is ( IDLE, WRITE_ADDR, WRITE_DATA, WAIT_WRITE_COMPLETED, READ_DATA,  
                  SIGNAL_DONE, SIGNAL_ERROR);
signal state  : state_t := IDLE;

begin

    --
    -- State Machine
    --
    FSM_STATE_PROC : process(m_axi_aclk)
    begin
        if rising_edge(m_axi_aclk) then
            if (m_axi_aresetn = '0') then
                state <= IDLE;
                m_axi_mosi.awvalid <= '0';   
                m_axi_mosi.wvalid <= '0';
                m_axi_mosi.araddr <= (others => '0');
                m_axi_mosi.arvalid <= '0';
                txn_done <= '0';
                txn_error <= '0';
            else
                case (state) is                                                                    
                    when IDLE => -- Initial state
                        if (txn_wstart = '1') then
                            m_axi_mosi.awvalid <= '1';
                            m_axi_mosi.awaddr <= txn_addr;
                            state <= WRITE_ADDR;
                        elsif (txn_rstart = '1') then
                            m_axi_mosi.arvalid <= '1';
                            m_axi_mosi.araddr <= txn_addr;
                            state <= READ_DATA;
                        end if;
                        
                    when WRITE_ADDR => -- Write AXI address
                        if (m_axi_miso.awready = '1') then
                            m_axi_mosi.awvalid <= '0';
                            m_axi_mosi.wvalid <= '1';
                            m_axi_mosi.wdata <= txn_wdata;
                            state <= WRITE_DATA;                            
                        end if;
                        
                    when WRITE_DATA => -- Write AXI data
                        if (m_axi_miso.wready = '1') then
                            m_axi_mosi.wvalid <= '0';
                            state <= WAIT_WRITE_COMPLETED;                            
                        end if;
                    
                    when WAIT_WRITE_COMPLETED => -- Wait for write response
                        if (m_axi_miso.bvalid = '1') then
                            if (m_axi_miso.bresp = AXI_OKAY) then
                                txn_done <= '1';
                                state <= SIGNAL_DONE;
                            else
                                txn_error <= '1';
                                state <= SIGNAL_ERROR; 
                            end if;
                        end if;    
                        
                    when READ_DATA => -- Read AXI data
                        if (m_axi_miso.rvalid = '1') then
                            m_axi_mosi.arvalid <= '0';
                            txn_rdata <= m_axi_miso.rdata;
                            txn_done <= '1';
                            state <= SIGNAL_DONE;                            
                        end if;

                    when SIGNAL_DONE => -- Pulse done indicator
                        txn_done <= '0';
                        state <= IDLE;    

                    when SIGNAL_ERROR => -- Pulse error indicator
                        txn_error <= '0';
                        state <= IDLE;    

                    when others  =>                                                                           
                        state <= IDLE;
                end case;                                                      
            end if;
        end if;
    end process FSM_STATE_PROC;


    --
    -- Write address channel
    --
    m_axi_mosi.awprot <= "000";
    

    --
    -- Write data channel
    --
    m_axi_mosi.wstrb <= (others => '1');
    

    --
    -- Write response channel
    -- 
    m_axi_mosi.bready <= '1';
    

    --
    -- Read address and data channel
    -- 
    m_axi_mosi.arprot <= "000";
    m_axi_mosi.rready <= '1';

end rtl;
