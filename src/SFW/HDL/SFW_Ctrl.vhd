-------------------------------------------------------------------------------
--
-- Title       : SFW_Ctrl
-- Author      : Julien Roy
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;
use work.sfw_define.all;


entity SFW_Ctrl is
    generic(
        SPEED_PRECISION_BIT : integer := 4
    );
    port(     
        --------------------------------
        -- PowerPC Interface
        --------------------------------
        AXIL_MOSI           : in  t_axi4_lite_mosi;
        AXIL_MISO           : out t_axi4_lite_miso;

        --------------------------------
        -- fw_decoder
        --------------------------------
        NB_ENCODER_COUNTS : out std_logic_vector(15 downto 0);
        RPM_FACTOR        : out std_logic_vector(31 downto 0);

        --------------------------------
        -- sfw_processing
        --------------------------------
        MIN_POSITIONS   : out position_array_t;
        MAX_POSITIONS   : out position_array_t;
        CLEAR_ERR       : out STD_LOGIC;       
        VALID_PARAM     : out STD_LOGIC;
        WHEEL_STATE     : out STD_LOGIC_VECTOR(1 downto 0);
        POSITION_SETPOINT   : out STD_LOGIC_VECTOR(7 downto 0);
        RPM_MAX         : out STD_LOGIC_VECTOR(15 downto 0);
        
        HOME_LOCK     : IN STD_LOGIC;
        POSITION        : IN STD_LOGIC_VECTOR(15 downto 0);
        RPM             : IN STD_LOGIC_VECTOR(19 downto 0);
        ERROR_SPEED     : IN STD_LOGIC;   
        

        --------------------------------
        -- Misc
        --------------------------------   
        MB_CLK             : in  std_logic;
        ARESETN            : in  std_logic
    );
end SFW_Ctrl;


architecture RTL of SFW_Ctrl is
   -- Component declaration
   component sync_resetn
      port(
         ARESETN                 : in std_logic;
         SRESETN                 : out std_logic;
         CLK                    : in std_logic);
   end component;

   -- Constants
    constant C_S_AXI_DATA_WIDTH : integer := 32;
    constant C_S_AXI_ADDR_WIDTH : integer := 32;
    constant ADDR_LSB           : integer := 2;   -- 4 bytes access
    constant OPT_MEM_ADDR_BITS  : integer := 6;   -- Number of supplement bit
    constant NUMBER_OF_FILTERS  : integer := 8;

    ----------------------------   
    -- Address of registers
    ----------------------------   
    constant FW0_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW1_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW2_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW3_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW4_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW5_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW6_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant FW7_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant CLEAR_ERR_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(32,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant VALID_PARAM_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(36,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant WHEEL_STATE_ADDR                : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(40,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant POSITION_SETPOINT_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(44,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant NB_ENCODER_CNT_ADDR        : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(48,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant RPM_FACTOR_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(52,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant RPM_MAX_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(56,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));

    constant HOME_LOCK_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(60,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant POSITION_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(64,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant RPM_ADDR                   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(68,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant ERROR_SPEED_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(72,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
    constant SPEED_PRECISION_BIT_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(76,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));

   
   -- Signals
   signal sresetn               : std_logic;

   -- Array containing min and max positions for each filter
   signal minimal_positions   : position_array_t;
   signal maximal_positions   : position_array_t;
   
   signal valid_parameters    : std_logic; -- Tells if filter positions are valid 

   signal wheel_state_o         : std_logic_vector(1 downto 0);
   signal position_setpoint_o   : std_logic_vector(7 downto 0);
   signal home_locked      : std_logic; -- Is asserted when the current filter position correspond to the good one
   signal clear_errors        : std_logic;   -- reset the error flags when clear_errors is asserted
   signal error_speed_i         : std_logic;   -- error flag asserted when speed > MAX_RPM
   signal rpm_max_o             : std_logic_vector(15 downto 0); -- The maximum speed before error flag is rised
   signal nb_encoder_counts_o : std_logic_vector(15 downto 0); -- The maximum speed before error flag is rised
   signal rpm_factor_o        : std_logic_vector(31 downto 0); -- The maximum speed before error flag is rised

 
    -- AXI4LITE signals
    signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal axi_awready   : std_logic;
    signal axi_wready	: std_logic;
    signal axi_bresp	    : std_logic_vector(1 downto 0);
    signal axi_bvalid	: std_logic;
    signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal axi_arready   : std_logic;
    signal axi_rdata	    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal axi_rresp	    : std_logic_vector(1 downto 0);
    signal axi_rvalid	: std_logic;
    signal axi_wstrb     : std_logic_vector(3 downto 0);
    
    signal slv_reg_rden  : std_logic;
    signal slv_reg_wren  : std_logic;
    signal reg_data_out  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal byte_index	: integer;
 
begin
   ----------------------------------------
   -- CLK
   ----------------------------------------
   sreset_ctrl_gen : sync_resetN
   port map(
      ARESETN => ARESETN,
      CLK    => MB_CLK,
      SRESETN => sresetn
      );

----------------------------------------
-- fw decoder assigment
----------------------------------------
    NB_ENCODER_COUNTS <= nb_encoder_counts_o;
    RPM_FACTOR        <= rpm_factor_o;

----------------------------------------
-- sfw processing assigment
----------------------------------------
    MIN_POSITIONS <= minimal_positions;
    MAX_POSITIONS <= maximal_positions;
    CLEAR_ERR          <= clear_errors;    
    VALID_PARAM        <= valid_parameters;    
    WHEEL_STATE        <= wheel_state_o;    
    POSITION_SETPOINT  <= position_setpoint_o;    
    RPM_MAX            <= rpm_max_o;
    
    error_speed_i <= ERROR_SPEED;
    home_locked <= HOME_LOCK;

----------------------------------------
-- AXIL Bridge
----------------------------------------
   -- I/O Connections assignments
   AXIL_MISO.AWREADY  <= axi_awready;
   AXIL_MISO.WREADY   <= axi_wready;
   AXIL_MISO.BRESP	  <= axi_bresp;
   AXIL_MISO.BVALID   <= axi_bvalid;
   AXIL_MISO.ARREADY  <= axi_arready;
   AXIL_MISO.RDATA	  <= axi_rdata;
   AXIL_MISO.RRESP	  <= axi_rresp;
   AXIL_MISO.RVALID   <= axi_rvalid;

----------------------------------------------------------------------------
-- AXI WR : reception configuration
----------------------------------------------------------------------------
AXI_WR : process (MB_CLK)
begin
if rising_edge(MB_CLK) then 
    if sresetn = '0' then
        minimal_positions(0) <= (others => '0');
        minimal_positions(1) <= (others => '0');
        minimal_positions(2) <= (others => '0');
        minimal_positions(3) <= (others => '0');
        minimal_positions(4) <= (others => '0');
        minimal_positions(5) <= (others => '0');
        minimal_positions(6) <= (others => '0');
        minimal_positions(7) <= (others => '0');

        maximal_positions(0) <= (others => '0');
        maximal_positions(1) <= (others => '0');
        maximal_positions(2) <= (others => '0');
        maximal_positions(3) <= (others => '0');
        maximal_positions(4) <= (others => '0');
        maximal_positions(5) <= (others => '0');
        maximal_positions(6) <= (others => '0');
        maximal_positions(7) <= (others => '0');

        clear_errors         <= '0';
        valid_parameters     <= '0';
        wheel_state_o          <= FIXED_WHEEL;
        position_setpoint_o    <= (others => '0');
        nb_encoder_counts_o    <= std_logic_vector(to_unsigned(4096,NB_ENCODER_COUNTS'length));
        rpm_factor_o           <= std_logic_vector(to_unsigned(1464844,RPM_FACTOR'length)); -- default value for 100Mhz clock and 4096 counts
        rpm_max_o              <= std_logic_vector(to_unsigned(7000,rpm_max'length));
        
    else
        clear_errors      <= '0';
        
        if (slv_reg_wren = '1') and axi_wstrb = "1111" then
            case axi_awaddr(OPT_MEM_ADDR_BITS+ADDR_LSB downto 0) is      
                when FW0_POSITION_ADDR    =>  
                    minimal_positions(0)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(0)  <= AXIL_MOSI.WDATA(31 downto 16);
                when FW1_POSITION_ADDR    =>                      
                    minimal_positions(1)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(1)  <= AXIL_MOSI.WDATA(31 downto 16);
                when FW2_POSITION_ADDR    =>                      
                    minimal_positions(2)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(2)  <= AXIL_MOSI.WDATA(31 downto 16);                
                when FW3_POSITION_ADDR    =>                       
                    minimal_positions(3)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(3)  <= AXIL_MOSI.WDATA(31 downto 16);                
                when FW4_POSITION_ADDR    =>                       
                    minimal_positions(4)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(4)  <= AXIL_MOSI.WDATA(31 downto 16);                
                when FW5_POSITION_ADDR    =>                       
                    minimal_positions(5)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(5)  <= AXIL_MOSI.WDATA(31 downto 16);                
                when FW6_POSITION_ADDR    =>                       
                    minimal_positions(6)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(6)  <= AXIL_MOSI.WDATA(31 downto 16);
                when FW7_POSITION_ADDR    =>                       
                    minimal_positions(7)  <= AXIL_MOSI.WDATA(15 downto 0);
                    maximal_positions(7)  <= AXIL_MOSI.WDATA(31 downto 16);
                    
                when CLEAR_ERR_ADDR         =>  clear_errors        <= '1';
                when VALID_PARAM_ADDR       =>  valid_parameters    <= AXIL_MOSI.WDATA(0);
                when WHEEL_STATE_ADDR       =>  wheel_state_o         <= AXIL_MOSI.WDATA(wheel_state'range);
                when POSITION_SETPOINT_ADDR =>  position_setpoint_o   <= AXIL_MOSI.WDATA(position_setpoint'range);
                when NB_ENCODER_CNT_ADDR    =>  nb_encoder_counts_o   <= AXIL_MOSI.WDATA(NB_ENCODER_COUNTS'range);
                when RPM_FACTOR_ADDR        =>  rpm_factor_o          <= AXIL_MOSI.WDATA(RPM_FACTOR'range);
                when RPM_MAX_ADDR           =>  rpm_max_o             <= AXIL_MOSI.WDATA(rpm_max'range);
                when others  =>   
            end case;                                                                                          
        end if;                                        
    end if;
end if;
end process; 

----------------------------------------------------------------------------
-- AXI WR : contrôle du flow 
---------------------------------------------------------------------------- 
-- (pour l'instant transaction se fait à au max 1 CLK sur 2 
AXI_WR_FLOW: process (MB_CLK)
begin
    if rising_edge(MB_CLK) then 
        if sresetn = '0' then
            axi_awready <= '0'; 
            axi_wready <= '0';
        else

            if (axi_awready = '0' and AXIL_MOSI.AWVALID = '1' and AXIL_MOSI.WVALID = '1') then
                axi_awready <= '1';
                axi_awaddr <= AXIL_MOSI.AWADDR;
            else
                axi_awready <= '0';
            end if;

            if (axi_wready = '0' and AXIL_MOSI.WVALID = '1' and AXIL_MOSI.AWVALID = '1') then
                axi_wready <= '1';
            else
                axi_wready <= '0';               
            end if;              

        end if;
    end if;
end process;   

slv_reg_wren <= axi_wready and AXIL_MOSI.WVALID and axi_awready and AXIL_MOSI.AWVALID ;
axi_wstrb <= AXIL_MOSI.WSTRB;       
      
----------------------------------------------------------------------------
-- AXI WR : WR response
----------------------------------------------------------------------------
U4: process (MB_CLK)
begin
    if rising_edge(MB_CLK) then 
        if sresetn = '0' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
        else
            if (axi_awready = '1' and AXIL_MOSI.AWVALID = '1' and axi_wready = '1' and AXIL_MOSI.WVALID = '1' and axi_bvalid = '0'  ) then
                axi_bvalid <= '1';
                axi_bresp  <= "00"; 
            elsif (AXIL_MOSI.BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
                axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
            end if;
        end if;
    end if;
end process;       

----------------------------------------------------------------------------
-- RD : contrôle du flow
---------------------------------------------------------------------------- 
-- (pour l'instant transaction se fait à au max 1 CLK sur 2   
U5: process (MB_CLK)
begin
if rising_edge(MB_CLK) then 
    if sresetn = '0' then
        axi_arready <= '0';
        axi_araddr  <= (others => '1');
        axi_rvalid <= '0';
        axi_rresp  <= "00";
    else
        if axi_arready = '0' and AXIL_MOSI.ARVALID = '1' then
            -- indicates that the slave has acceped the valid read address
            axi_arready <= '1';
            -- Read Address latching 
            axi_araddr  <= AXIL_MOSI.ARADDR;
        else
            axi_arready <= '0';
        end if;
        
        if axi_arready = '1' and AXIL_MOSI.ARVALID = '1' and axi_rvalid = '0' then
            -- Valid read data is available at the read data bus
            axi_rvalid <= '1';
            axi_rresp  <= "00"; -- 'OKAY' response
        elsif axi_rvalid = '1' and AXIL_MOSI.RREADY = '1' then
            -- Read data is accepted by the master
            axi_rvalid <= '0';
        end if;
    end if;
end if;
end process; 

   

---------------------------------------------------------------------------- 
-- Axi RD responses                                      
---------------------------------------------------------------------------- 
U7: process (MB_CLK)
begin
if rising_edge(MB_CLK) then
    if sresetn = '0' then
        axi_rvalid <= '0';
        axi_rresp  <= "00";
    else
        if (axi_arready = '1' and AXIL_MOSI.ARVALID = '1' and axi_rvalid = '0') then
            -- Valid read data is available at the read data bus
            axi_rvalid <= '1';
            axi_rresp  <= "00"; -- 'OKAY' response
        elsif (axi_rvalid = '1' and AXIL_MOSI.RREADY = '1') then
            -- Read data is accepted by the master
            axi_rvalid <= '0';
        end if;
    end if;
end if;
end process;

-- Implement memory mapped register select and read logic generation
-- Slave register read enable is asserted when valid address is available
-- and the slave is ready to accept the read address.
slv_reg_rden <= axi_arready and AXIL_MOSI.ARVALID and (not axi_rvalid) ; 
-- Read address mux


---------------------------------------------------------------------------- 
-- RD : données vers µBlaze                                       
---------------------------------------------------------------------------- 
axi_rdata <= reg_data_out;     -- register read data

U6: process(MB_CLK)
begin
if rising_edge(MB_CLK) then
    reg_data_out <= (others => '0');
    case axi_araddr(OPT_MEM_ADDR_BITS+ADDR_LSB downto 0) is
        when  HOME_LOCK_ADDR                => reg_data_out(0) <= home_locked;                  
        when  POSITION_ADDR                 => reg_data_out <= std_logic_vector(resize(POSITION     , reg_data_out'length));
        when  RPM_ADDR                      => reg_data_out <= std_logic_vector(resize(RPM     , reg_data_out'length));
        when  ERROR_SPEED_ADDR              => reg_data_out(0) <= error_speed_i;
        when  SPEED_PRECISION_BIT_ADDR      => reg_data_out <= std_logic_vector(TO_UNSIGNED(2**SPEED_PRECISION_BIT, reg_data_out'length));
        --when  SPEED_PRECISION_BIT_ADDR     => reg_data_out <= std_logic_vector(resize(SPEED_PRECISION_BIT, reg_data_out'length));
        when others                 => reg_data_out <= (others => '0');
    end case;
end if;     
end process;  

end RTL;

