
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity adc_iserdes_wrapper is
   generic
      (IOBDELAY       : STRING := "NONE"   -- "IBUF", "IFD" or "NONE"
      );
   port
      (
      -- From the system into the device
      D       : in    std_logic;
      DDLY       : in    std_logic;
      Q       : out   std_logic_vector(13 downto 0);
      O       : out std_logic;
      
      bitslip                 : in    std_logic;                    -- Bitslip module is enabled in NETWORKING mode
      -- User should tie it to '0' if not needed
      
      -- Clock and reset signals
      clk_in                  : in    std_logic;                    -- Fast clock from PLL/MMCM 
      clk_div_in              : in    std_logic;                    -- Slow clock from PLL/MMCM
      reset                : in    std_logic);                   -- Reset signal for IO circuit
end adc_iserdes_wrapper;

architecture simulation of adc_iserdes_wrapper is
   
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
      
   signal clk_in_inv           : std_ulogic;
   signal sreset : std_ulogic := '0';
   
   signal q_reg_s, q_reg_out, q_reg_old : std_ulogic_vector(13 downto 0) := (others => '0');
   signal q_reg_slip : std_ulogic_vector(27 downto 0) := (others => '0');
   
   signal bitslip_dir : std_ulogic := '0';
   
   signal data_in : std_ulogic;
   signal d_i, ddly_i : std_ulogic;
   
   signal slip_pos : integer range 0 to 13 := 0;
   
begin
   
   reset_sync : sync_reset
   port map (
      clk => clk_div_in,
      areset => reset,
      sreset => sreset);
   
   d_i <= D;
   ddly_i <= DDLY;
   clk_in_inv <= not clk_in;
   
   ifd_case : if IOBDELAY = "IFD" generate
      data_in <= ddly_i;
      O <= d_i;
   end generate;
   both_case : if IOBDELAY = "BOTH" generate
      data_in <= ddly_i;
      O <= ddly_i;
   end generate;
   ibuf_case : if IOBDELAY = "IBUF" generate
      data_in <= d_i;
      O <= ddly_i;
   end generate;
   none_case : if IOBDELAY = "NONE" generate
      data_in <= d_i;
      O <= d_i;
   end generate;
   
   deserialize : process(clk_in_inv, clk_in)
   begin
      if rising_edge(clk_in) or rising_edge(clk_in_inv) then
         q_reg_slip <= q_reg_slip(q_reg_slip'length-2 downto 0) & data_in;
      end if;
   end process;
   
   sync_output : process(clk_div_in)
   begin
      if rising_edge(clk_div_in) then
         if sreset = '1' then
            q_reg_out <= (others => '0');
         else
            q_reg_out <= q_reg_slip(slip_pos+13 downto slip_pos);
         end if;
      end if;
   end process;
   
   Q <= std_logic_vector(q_reg_out);
   
   -- simulate the DDR-mode bitslip process. The parallel data becomes ready on the 3rd clk event 
   -- following the sampling of the bitslip signal
   -- see p.158, http://www.xilinx.com/support/documentation/user_guides/ug471_7Series_SelectIO.pdf
   bitslip_proc : process(clk_div_in)
      variable state : integer range 0 to 4 := 4;
   begin
      if rising_edge(clk_div_in) then
         if sreset = '1' then
            bitslip_dir <= '0';
            state := 4;
            slip_pos <= 0;
         else
            if bitslip = '1' then
               state := 0;
            end if;
            
            if state <= 2 then
               if state = 2 then
                  if bitslip_dir = '0' then
                     slip_pos <= slip_pos + 1;
                  else
                     if slip_pos >= 3 then
                        slip_pos <= slip_pos - 3;
                     else
                        slip_pos <= 11 + slip_pos; -- 14-(3-slip_pos)
                     end if;
                  end if;
                  bitslip_dir <= not bitslip_dir;
               end if;
               
               state := state + 1;
            end if;
         end if;
      end if;
   end process;
   
end simulation;

architecture rtl of adc_iserdes_wrapper is
   
   component ISERDESE2
      generic(
         DATA_RATE : STRING := "DDR";
         DATA_WIDTH : INTEGER := 4;
         DYN_CLKDIV_INV_EN : STRING := "FALSE";
         DYN_CLK_INV_EN : STRING := "FALSE";
         INIT_Q1 : BIT := '0';
         INIT_Q2 : BIT := '0';
         INIT_Q3 : BIT := '0';
         INIT_Q4 : BIT := '0';
         INTERFACE_TYPE : STRING := "MEMORY";
         IOBDELAY : STRING := "NONE";
         NUM_CE : INTEGER := 2;
         OFB_USED : STRING := "FALSE";
         SERDES_MODE : STRING := "MASTER";
         SRVAL_Q1 : BIT := '0';
         SRVAL_Q2 : BIT := '0';
         SRVAL_Q3 : BIT := '0';
         SRVAL_Q4 : BIT := '0'
         );
      port (
         BITSLIP : in STD_ULOGIC;
         CE1 : in STD_ULOGIC;
         CE2 : in STD_ULOGIC;
         CLK : in STD_ULOGIC;
         CLKB : in STD_ULOGIC;
         CLKDIV : in STD_ULOGIC;
         CLKDIVP : in STD_ULOGIC;
         D : in STD_ULOGIC;
         DDLY : in STD_ULOGIC;
         DYNCLKDIVSEL : in STD_ULOGIC;
         DYNCLKSEL : in STD_ULOGIC;
         OCLK : in STD_ULOGIC;
         OCLKB : in STD_ULOGIC;
         OFB : in STD_ULOGIC;
         RST : in STD_ULOGIC;
         SHIFTIN1 : in STD_ULOGIC;
         SHIFTIN2 : in STD_ULOGIC;
         O : out STD_ULOGIC;
         Q1 : out STD_ULOGIC;
         Q2 : out STD_ULOGIC;
         Q3 : out STD_ULOGIC;
         Q4 : out STD_ULOGIC;
         Q5 : out STD_ULOGIC;
         Q6 : out STD_ULOGIC;
         Q7 : out STD_ULOGIC;
         Q8 : out STD_ULOGIC;
         SHIFTOUT1 : out STD_ULOGIC;
         SHIFTOUT2 : out STD_ULOGIC
         );
   end component;
   
   constant clock_enable            : std_logic := '1';
   signal unused : std_logic;
   signal clk_in_int_buf            : std_logic;
   signal clk_inv_in_int            : std_logic;
   
   -- Between the delay and serdes
   signal D_delay   : std_logic;
   signal ce_in_uc          : std_logic;
   signal inc_in_uc         : std_logic;
   signal regrst_in_uc      : std_logic;
   signal ce_out_uc              : std_logic;
   signal inc_out_uc             : std_logic;
   signal regrst_out_uc          : std_logic;
   constant num_serial_bits         : integer := Q'length;
   type serdarr is array (0 to 13) of std_logic;
   -- Array to use intermediately from the serdes to the internal
   --  devices. bus "0" is the leftmost bus
   -- * fills in starting with 0
   signal iserdes_q                 : serdarr := (( others => '0'));
   signal serdesstrobe             : std_logic;
   signal icascade1                : std_logic;
   signal icascade2                : std_logic;
      
begin
   
   clk_inv_in_int <= not clk_in;
   
   -- Pass through the delay
   -----------------------------------
   D_delay <= D;
   
   -- Instantiate the serdes primitive
   ----------------------------------
   
   -- declare the iserdes
   iserdese2_master : ISERDESE2
   generic map (
      DATA_RATE         => "DDR",
      DATA_WIDTH        => 14,
      INTERFACE_TYPE    => "NETWORKING", 
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN    => "FALSE",
      NUM_CE            => 2,
      OFB_USED          => "FALSE",
      IOBDELAY          => IOBDELAY,                             -- Use input at D to output the data on Q1-Q6
      SERDES_MODE       => "MASTER")
   port map (
      Q1                => iserdes_q(0),
      Q2                => iserdes_q(1),
      Q3                => iserdes_q(2),
      Q4                => iserdes_q(3),
      Q5                => iserdes_q(4),
      Q6                => iserdes_q(5),
      Q7                => iserdes_q(6),
      Q8                => iserdes_q(7),
      SHIFTOUT1         => icascade1,               -- Cascade connection to Slave ISERDES
      SHIFTOUT2         => icascade2,               -- Cascade connection to Slave ISERDES
      BITSLIP           => bitslip,                            -- 1-bit Invoke Bitslip. This can be used with any 
      -- DATA_WIDTH, cascaded or not.
      CE1               => clock_enable,                       -- 1-bit Clock enable input
      CE2               => clock_enable,                       -- 1-bit Clock enable input
      CLK               => clk_in,                             -- Fast clock driven by MMCM
      CLKB              => clk_inv_in_int,                     -- Locally inverted clock
      CLKDIV            => clk_div_in,                         -- Slow clock driven by MMCM
      CLKDIVP           => '0',
      D                 => D_delay, -- 1-bit Input signal from IOB.
      DDLY              => DDLY,
      RST               => reset,                           -- 1-bit Asynchronous reset only.
      SHIFTIN1          => '0',
      SHIFTIN2          => '0',
      -- unused connections
      DYNCLKDIVSEL      => '0',
      DYNCLKSEL         => '0',
      OFB               => '0',
      OCLK              => '0',
      OCLKB             => '0',
      O                 => O);                              -- unregistered output of ISERDESE1
   
   iserdese2_slave : ISERDESE2
   generic map (
      DATA_RATE         => "DDR",
      DATA_WIDTH        => 14,
      INTERFACE_TYPE    => "NETWORKING",
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN    => "FALSE",
      NUM_CE            => 2,
      OFB_USED          => "FALSE",
      IOBDELAY          => IOBDELAY,                             -- Use input at D to output the data on Q1-Q6
      SERDES_MODE       => "SLAVE")
   port map (
      Q1                => open,
      Q2                => open,
      Q3                => iserdes_q(8),
      Q4                => iserdes_q(9),
      Q5                => iserdes_q(10),
      Q6                => iserdes_q(11),
      Q7                => iserdes_q(12),
      Q8                => iserdes_q(13),
      SHIFTOUT1         => open,
      SHIFTOUT2         => open,
      SHIFTIN1          => icascade1,               -- Cascade connections from Master ISERDES
      SHIFTIN2          => icascade2,               -- Cascade connections from Master ISERDES
      BITSLIP           => bitslip,                            -- 1-bit Invoke Bitslip. This can be used with any 
      -- DATA_WIDTH, cascaded or not.
      CE1               => clock_enable,                       -- 1-bit Clock enable input
      CE2               => clock_enable,                       -- 1-bit Clock enable input
      CLK               => clk_in,                             -- Fast clock driven by MMCM
      CLKB              => clk_inv_in_int,                     -- locally inverted clock
      CLKDIV            => clk_div_in,                         -- Slow clock driven by MMCM
      CLKDIVP           => '0',
      D                 => '0',                                -- Slave ISERDES module. No need to connect D, DDLY
      DDLY              => '0',
      RST               => reset,                           -- 1-bit Asynchronous reset only.
      -- unused connections
      DYNCLKDIVSEL      => '0',
      DYNCLKSEL         => '0',
      OFB               => '0',
      OCLK             => '0',
      OCLKB            => '0',
      O                => open);                              -- unregistered output of ISERDESE1
   
   -- Concatenate the serdes outputs together. Keep the timesliced
   --   bits together, and placing the earliest bits on the right
   --   ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7, ...
   --       the output will be 3210, 7654, ...
   -------------------------------------------------------------
    
   in_slices: for slice_count in 0 to num_serial_bits-1 generate begin
      -- bits are already ordered from MSB to LSB
      Q(slice_count) <= iserdes_q(slice_count);
   end generate in_slices;
end rtl;



