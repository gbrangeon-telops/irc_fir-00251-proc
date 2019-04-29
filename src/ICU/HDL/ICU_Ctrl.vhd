-------------------------------------------------------------------------------
--
-- Title       : ICU_Ctrl
-- Author      : Simon Savary
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$
-------------------------------------------------------------------------------
--
-- Description : This file implements the axi_lite communication for the ICU
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;

entity ICU_Ctrl is
   port(

      PULSE_WIDTH         : out std_logic_vector(31 downto 0); -- [CLK ticks]
      PERIOD              : out std_logic_vector(31 downto 0); -- [CLK ticks]
      TRANSITION_DURATION : out std_logic_vector(31 downto 0); -- [CLK ticks]
      CMD                 : out std_logic_vector(1 downto 0); -- "00", OFF "01", move SCENE, "10" CALIB
      MODE                : out std_logic_vector(1 downto 0);  -- "00" one-shot, "01" repeat
      CALIB_POLARITY      : out std_logic; -- '0' forward, '1' reverse
      BRAKE_POLARITY      : out std_logic;

      POSITION              : in std_logic_vector(1 downto 0); -- "00", SCENE, "01" CALIB, "10" MOVING, "11" OFF (N/A)

      AXI4_LITE_MOSI : in t_axi4_lite_mosi;
      AXI4_LITE_MISO : out t_axi4_lite_miso;

      NEW_CONFIG : out std_logic;
      --------------------------------
      -- MISC
      --------------------------------
      -- CLK
      ARESETn         : in  std_logic;
      CLK             : in  std_logic
      );
end ICU_Ctrl;

architecture RTL of ICU_Ctrl is

   constant C_S_AXI_DATA_WIDTH : integer := 32;
   constant C_S_AXI_ADDR_WIDTH : integer := 32;
   constant ADDR_LSB           : integer := 2;   -- 4 bytes access
   constant OPT_MEM_ADDR_BITS  : integer := 5;   -- Number of supplement bit
   constant ADDR_LENGTH        : integer := ADDR_LSB + 1 + OPT_MEM_ADDR_BITS;

   ----------------------------
   -- Address of registers
   ----------------------------
   constant ICU_MODE_ADDR                 : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(0,ADDR_LENGTH));
   constant ICU_PULSE_WIDTH_ADDR          : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(4,ADDR_LENGTH));
   constant ICU_PERIOD_ADDR               : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(8,ADDR_LENGTH));
   constant ICU_CALIB_POLARITY_ADDR       : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(12,ADDR_LENGTH));
   constant ICU_TRANSITION_DURATION_ADDR  : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(16,ADDR_LENGTH));
   constant ICU_PULSE_CMD_ADDR            : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(20,ADDR_LENGTH));
   constant ICU_STATUS_ADDR               : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(24,ADDR_LENGTH));
   constant ICU_BRAKEPOLARITY_ADDR        : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(28,ADDR_LENGTH));

   ----------------------------
   -- Component Declaration
   ----------------------------
   component sync_resetn is
      port(
         ARESETn : in STD_LOGIC;
         SRESETN : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;

   signal sresetn      : std_logic;
   signal sreset        :std_logic;

   --! User Input Register Declarations
   signal pulse_width_out         : std_logic_vector(PULSE_WIDTH'length-1 downto 0);
   signal period_out              : std_logic_vector(PERIOD'length-1 downto 0);
   signal transition_duration_out : std_logic_vector(TRANSITION_DURATION'length-1 downto 0);
   signal cmd_out                 : std_logic_vector(CMD'length-1 downto 0);
   signal mode_out                : std_logic_vector(MODE'length-1 downto 0);
   signal polarity_out            : std_logic;
   signal brake_polarity_out          : std_logic;


   --! User Output Register Declarations
   signal position_in  : std_logic_vector(POSITION'length-1 downto 0);

   signal new_config_out : std_logic;

   -- AXI4LITE signals
   signal axi_awaddr	  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
   signal axi_awready  : std_logic;
   signal axi_wready	  : std_logic;
   signal axi_bresp	  : std_logic_vector(1 downto 0);
   signal axi_bvalid	  : std_logic;
   signal axi_araddr	  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
   signal axi_arready  : std_logic;
   signal axi_rdata	  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal axi_rresp	  : std_logic_vector(1 downto 0);
   signal axi_rvalid	  : std_logic;
   signal axi_wstrb    : std_logic_vector(3 downto 0);

   signal slv_reg_rden : std_logic;
   signal slv_reg_wren : std_logic;
   signal reg_data_out : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);

begin

   sreset <= not sresetn;

   U0A : sync_resetn port map(ARESETn => ARESETn, SRESETN => sresetn, CLK => CLK);

   PULSE_WIDTH <= pulse_width_out;
   PERIOD <= period_out;
   TRANSITION_DURATION <= transition_duration_out;
   CMD <= cmd_out;
   MODE <= mode_out;
   CALIB_POLARITY <= polarity_out;
   NEW_CONFIG <= new_config_out;
   BRAKE_POLARITY <= brake_polarity_out;
   position_in <= POSITION;

   -- I/O Connections assignments
   AXI4_LITE_MISO.AWREADY  <= axi_awready;
   AXI4_LITE_MISO.WREADY   <= axi_wready;
   AXI4_LITE_MISO.BRESP	   <= axi_bresp;
   AXI4_LITE_MISO.BVALID   <= axi_bvalid;
   AXI4_LITE_MISO.ARREADY  <= axi_arready;
   AXI4_LITE_MISO.RDATA	   <= axi_rdata;
   AXI4_LITE_MISO.RRESP	   <= axi_rresp;
   AXI4_LITE_MISO.RVALID   <= axi_rvalid;

   ----------------------------------------------------------------------------
   -- AXI WR : reception configuration
   ----------------------------------------------------------------------------
   U3: process (CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            pulse_width_out <= (others => '0');
            period_out <= (others => '0');
            transition_duration_out <= (others => '0');
            cmd_out <= (others => '0');
            mode_out <= (others => '0');
            new_config_out <= '0';
            polarity_out <= '0';
            brake_polarity_out <= '0';
         else
            if (slv_reg_wren = '1') and axi_wstrb = "1111" then
               new_config_out <= '1';
               case axi_awaddr(7 downto 0) is
                  when ICU_MODE_ADDR                =>  mode_out                <= AXI4_LITE_MOSI.WDATA(MODE'length-1 downto 0);
                  when ICU_PULSE_WIDTH_ADDR         =>  pulse_width_out         <= AXI4_LITE_MOSI.WDATA(PULSE_WIDTH'length-1 downto 0);
                  when ICU_PERIOD_ADDR              =>  period_out              <= AXI4_LITE_MOSI.WDATA(PERIOD'length-1 downto 0);
                  when ICU_CALIB_POLARITY_ADDR      =>  polarity_out            <= AXI4_LITE_MOSI.WDATA(0);
                  when ICU_TRANSITION_DURATION_ADDR =>  transition_duration_out <= AXI4_LITE_MOSI.WDATA(TRANSITION_DURATION'length-1 downto 0);
                  when ICU_PULSE_CMD_ADDR           =>  cmd_out                 <= AXI4_LITE_MOSI.WDATA(CMD'length-1 downto 0);
                  when ICU_BRAKEPOLARITY_ADDR       =>  brake_polarity_out      <= AXI4_LITE_MOSI.WDATA(0);
                  when others  => new_config_out <= '0';
               end case;
            else
               new_config_out <= '0';
            end if;
         end if;
      end if;
   end process;

   ----------------------------------------------------------------------------
   -- RD : données vers µBlaze                                       
   ----------------------------------------------------------------------------
   U6: process(CLK)
   begin
      if rising_edge(CLK) then
         case axi_araddr(7 downto 0) is
            when ICU_STATUS_ADDR => reg_data_out <= std_logic_vector(resize(position_in, reg_data_out'length));
            when others => reg_data_out <= (others => '0');
         end case;
      end if;
   end process;

   ----------------------------------------------------------------------------
   -- AXI WR : contrôle du flow 
   -- CR_WARNING this code comes from AEC_ctrl.vhd. It should be made into a
   -- standalone common block (U2, U4, U5 & U7)
   ----------------------------------------------------------------------------
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U2: process (CLK)
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
   -- AXI WR : WR response
   -- CR_WARNING this code comes from AEC_ctrl.vhd. see U2
   ----------------------------------------------------------------------------
   U4: process (CLK)
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
   -- CR_WARNING this code comes from AEC_ctrl.vhd. see U2
   ----------------------------------------------------------------------------
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U5: process (CLK)
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
   slv_reg_rden <= axi_arready and AXI4_LITE_MOSI.ARVALID and (not axi_rvalid);

   ----------------------------------------------------------------------------
   -- Axi RD responses
   -- CR_WARNING this code comes from AEC_ctrl.vhd. see U2
   ----------------------------------------------------------------------------
   U7: process (CLK)
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

end RTL;
