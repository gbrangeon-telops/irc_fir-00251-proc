----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2023 10:31:46 AM
-- Design Name: 
-- Module Name: nbits_deserializer_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library WORK;
use WORK.PROXY_DEFINE.ALL;

entity nbits_deserializer_tb is
    Generic (
        PIXEL_CLK_PERIOD : time := 30.0 ns;
        PIPE_CLK_PERIOD  : time := 10.0 ns;
        BIT_CLK_PERIOD   : time := 1.25 ns;
        LVAL_LENGTH : positive := 16;
        LVAL_NUM    : positive := 16;
        CLOCK_DELAY : time := BIT_CLK_PERIOD * 1
    );
--  Port ( );
end nbits_deserializer_tb;

architecture Behavioral of nbits_deserializer_tb is
    component nbits_serdes_clk_wrapper is
       generic(
          NBITS_PIXEL_CLK_PERIOD : time := 30 ns;
          NBITS_PIPE_CLK_PERIOD  : time := 10 ns;
          NBITS_BIT_CLK_PERIOD   : time := 1.25 ns
          );
       port(
          -- Clock in ports
          PIXEL_CLK_IN  : in std_logic;
          -- Clock out ports
          PIXEL_CLK_OUT : out std_logic;
          PIPE_CLK_OUT  : out std_logic;
          BIT_CLK_OUT   : out std_logic;
          -- Status and control signals
          ARESET        : in std_logic;
          LOCKED        : out std_logic
          );
    end component;
    
    component frame_generator is
        Generic (
            XSIZE     : positive := 10;
            YSIZE     : positive := 10;
            PIXELSIZE : positive := 24;
            FVAL      : boolean  := FALSE
        );
        Port (
            clk : in  std_logic;
            o   : out std_logic
        );
    end component;
    
    component nbits_deserializer is
      generic(
           CLK_PERIOD_NS : real := 12.5;
           FRAME_RATE_MIN : real := 0.1; -- Hz
           DATA_WIDTH : positive := 7; -- largeur des donnees du serdes
           IODELAY_GROUP_NAME : string := "name";
           STAB_AREA_WIDTH_MIN : natural := 14
      );
      port(
           BIT_CLK : in STD_LOGIC;
           ISERDES_RST : in STD_LOGIC;
           PIPE_CLK : in STD_LOGIC;
           PIXEL_CLK : in STD_LOGIC;
           CH_DATA_N : in STD_LOGIC_VECTOR(1 downto 0);
           CH_DATA_P : in STD_LOGIC_VECTOR(1 downto 0);
           FPA_INTF_CFG : in fpa_intf_cfg_type;
           CH_DONE : out STD_LOGIC;
           CH_SUCCESS : out STD_LOGIC;
           CH_DELAY : out STD_LOGIC_VECTOR(4 downto 0);
           CH_DOUT : out STD_LOGIC_VECTOR(2*DATA_WIDTH-1 downto 0);
           CH_EDGES : out STD_LOGIC_VECTOR(31 downto 0)
      );
    end component;
    
    signal pixel_clk_in : std_logic := '1';
    
    signal pixel_clk_out : std_logic;
    signal pipe_clk_out  : std_logic;
    signal bit_clk_out   : std_logic;
    
    signal bit_clk_out_dly : std_logic := '0';
    
    signal nreset : std_logic;
    
    signal channel_1 : std_logic;
    signal channel_2 : std_logic;
    
    signal config : fpa_intf_cfg_type;
    
    signal ch_done    : std_logic;
    signal ch_success : std_logic;
    signal ch_delay   : std_logic_vector(4 downto 0);
    signal ch_dout    : std_logic_vector(2*PIXEL_CLK_PERIOD/BIT_CLK_PERIOD-1 downto 0);
    signal ch_edges   : std_logic_vector(31 downto 0);
begin
    pixel_clk_in <= not pixel_clk_in after PIXEL_CLK_PERIOD / 2;
    
    bit_clk_out_dly <= transport bit_clk_out after CLOCK_DELAY;
    
    config.fpa_serdes_lval_len <= to_unsigned(LVAL_LENGTH, config.fpa_serdes_lval_len'LENGTH);
    config.fpa_serdes_lval_num <= to_unsigned(LVAL_NUM, config.fpa_serdes_lval_num'LENGTH);
    
    -- Breakpoint process
    process(ch_done, ch_dout)
    begin
        -- Calibration done
        if rising_edge(ch_done) then
            NULL;
        end if;
        
        -- Line completed
        if falling_edge(ch_dout(ch_dout'LENGTH / 1 - 1)) then
            NULL;
        end if;
        
        -- Frame completed
        if falling_edge(ch_dout(ch_dout'LENGTH / 2 - 1)) then
            NULL;
        end if;
    end process;

    nbits_serdes_clk_wrapper_inst : nbits_serdes_clk_wrapper
       generic map(
          NBITS_PIXEL_CLK_PERIOD => PIXEL_CLK_PERIOD,
          NBITS_PIPE_CLK_PERIOD  => PIPE_CLK_PERIOD,
          NBITS_BIT_CLK_PERIOD   => BIT_CLK_PERIOD
          )
       port map(
          -- Clock in ports
          PIXEL_CLK_IN  => pixel_clk_in,
          -- Clock out ports
          PIXEL_CLK_OUT => pixel_clk_out,
          PIPE_CLK_OUT  => pipe_clk_out,
          BIT_CLK_OUT   => bit_clk_out,
          -- Status and control signals
          ARESET        => '0',
          LOCKED        => nreset
          );
    
    channel_1_inst : frame_generator
        Generic map (
            XSIZE     => LVAL_LENGTH,
            YSIZE     => LVAL_NUM,
            PIXELSIZE => PIXEL_CLK_PERIOD / BIT_CLK_PERIOD,
            FVAL      => TRUE
        )
        Port map (
            clk => bit_clk_out_dly,
            o   => channel_1
        );
    channel_2_inst : frame_generator
        Generic map (
            XSIZE     => LVAL_LENGTH,
            YSIZE     => LVAL_NUM,
            PIXELSIZE => PIXEL_CLK_PERIOD / BIT_CLK_PERIOD,
            FVAL      => FALSE
        )
        Port map (
            clk => bit_clk_out_dly,
            o   => channel_2
        );
    
    nbits_deserializer_inst : nbits_deserializer
      generic map(
           CLK_PERIOD_NS => real(PIXEL_CLK_PERIOD / 1 ns),
           FRAME_RATE_MIN => 0.1,
           DATA_WIDTH => PIXEL_CLK_PERIOD / BIT_CLK_PERIOD,
           IODELAY_GROUP_NAME => "name",
           STAB_AREA_WIDTH_MIN => 14
      )
      port map(
           BIT_CLK => bit_clk_out,
           ISERDES_RST => not nreset,
           PIPE_CLK => pipe_clk_out,
           PIXEL_CLK => pixel_clk_out,
           CH_DATA_N => (not channel_2) & (not channel_1),
           CH_DATA_P => (channel_2) & (channel_1),
           FPA_INTF_CFG => config,
           CH_DONE => ch_done,
           CH_SUCCESS => ch_success,
           CH_DELAY => ch_delay,
           CH_DOUT => ch_dout,
           CH_EDGES => ch_edges
      );
end Behavioral;
