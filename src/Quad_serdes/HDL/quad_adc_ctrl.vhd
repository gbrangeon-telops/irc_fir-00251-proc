-------------------------------------------------------------------------------
--
-- Title       : quad_adc_ctrl
-- Design      : isc0207A
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\telops\FIR-00251-Proc\src\QuadADC\quad_adc_ctrl.vhd
-- Generated   : Tue Jun  2 12:08:50 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- pragma translate_off
library unisim;
use unisim.vcomponents.all;
-- pragma translate_on

entity quad_adc_ctrl is
   generic(
      SCLK_DIV : integer := 4
      );
   port(
      CLK : in std_logic;
      ARESET : in std_logic;
      EN : in std_logic; -- input from spi mux following a RQST signal
      PTRN_EN : in std_logic;
      PTRN_DATA : in std_logic_vector(13 downto 0);
      PTRN_ON : out std_logic;
      RQST : out std_logic;
      MISO : in std_logic;
      CS_N : out std_logic;
      SCLK : out std_logic;
      MOSI : out std_logic;
      ERR : out std_logic;
      DONE : out std_logic -- asserted when all the ADC registers are programmed
      );
end quad_adc_ctrl;

architecture quad_adc_ctrl of quad_adc_ctrl is
   
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   component spi_tx
      generic(
         CLKDIV : natural := 4;
         BITWIDTH : natural := 12);
      port(
         CLK : in std_logic;
         DIN : in std_logic_vector(BITWIDTH-1 downto 0);
         STB : in std_logic;
         ACK : out std_logic;
         CSn : out std_logic;
         SDA : out std_logic;
         SCL : out std_logic);
   end component;
   
   component spi_rx
      generic(
         BITWIDTH : natural := 12);
      port(
         CLK  : in std_logic;
         DOUT : out std_logic_vector(BITWIDTH-1 downto 0);
         DVAL : out std_logic;
         CSn  : in std_logic;
         SDA  : in std_logic;
         SCL  : in std_logic);
   end component;
   
   component BUFR
      generic(
         -- synthesis translate_off
         SIM_DEVICE : STRING := "7SERIES";
         -- synthesis translate_on
         BUFR_DIVIDE : STRING := "BYPASS"
         );
      port (
         CE : in std_ulogic;
         CLR : in std_ulogic;
         I : in std_ulogic;
         O : out std_ulogic
         );
   end component;
   
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
   
   constant DEFAULT_PATTERN : std_ulogic_vector(13 downto 0) := "01" & x"CAB";
   
   constant SOFTWARE_RST_REG_DATA : std_logic_vector(7 downto 0) := x"FF";
   constant POWERDOWN_REG_DATA : std_logic_vector(7 downto 0) := '0' & '0' & '0' & "00000"; -- duty cycle stab. on, random off, offset binary, normal operation
   constant OUTPUT_MODE_REG_DATA : std_logic_vector(7 downto 0) := "110" & '0' & '0' & "101"; -- 2.1 mA LVDS / no internal termination / outputs enabled / 1-lane, 14 bits serialization
   
   constant SOFTWARE_RST_REG_ADDR : std_logic_vector(6 downto 0) := "000" & x"0";
   constant POWERDOWN_REG_ADDR : std_logic_vector(6 downto 0) := "000" & x"1";
   constant OUTPUT_MODE_REG_ADDR : std_logic_vector(6 downto 0) := "000" & x"2";
   constant TEST_PATTERN_MSB_REG_ADDR : std_logic_vector(6 downto 0) := "000" & x"3";
   constant TEST_PATTERN_LSB_REG_ADDR : std_logic_vector(6 downto 0) := "000" & x"4";
   constant READ_MODE : std_logic := '1';
   constant WRITE_MODE : std_logic := '0';
   
   constant TEST_PATTERN_OFF : std_logic_vector(1 downto 0) := "00";
   constant TEST_PATTERN_ON : std_logic_vector(1 downto 0) := "10";
   
   constant NUM_REGS : integer := 5;
   
   type addr_ary is array (0 to NUM_REGS-1) of std_logic_vector(6 downto 0);
   type data_ary is array (0 to NUM_REGS-1) of std_logic_vector(7 downto 0);
   
   signal sreset : std_ulogic := '0';
   
   signal test_pattern_hold : std_ulogic_vector(13 downto 0) := DEFAULT_PATTERN;
   signal enable_test_pattern : std_ulogic := '0';
   signal test_pattern_enabled : std_ulogic := '0';
   signal cfg_word, data_spi_rx : std_logic_vector(15 downto 0) := (others => '0'); -- word that gets sent
   signal dval_spi_tx, dval_spi_rx : std_ulogic := '0';
   signal dval_rx : std_ulogic := '0'; -- dval_spi_rx gated with the read mode
   signal ack_i, cs_n_i, rx_cs_n_i, sclk_i, sclk_i_bufr : std_ulogic := '0';
   signal enable_pattern : std_ulogic := '0';
   signal ptrn_en_sync : std_ulogic := '0';
   signal index, next_index : integer range 0 to 7 := 0; -- index of the configuration word
   signal err_i, ptrn_on_i, done_i : std_ulogic;
   signal rw_n : std_ulogic;
   
   signal config_addr : addr_ary := (SOFTWARE_RST_REG_ADDR, POWERDOWN_REG_ADDR, OUTPUT_MODE_REG_ADDR, TEST_PATTERN_MSB_REG_ADDR, TEST_PATTERN_LSB_REG_ADDR);
   signal config_data : data_ary := (SOFTWARE_RST_REG_DATA, POWERDOWN_REG_DATA, OUTPUT_MODE_REG_DATA, (others => '0'), (others => '0'));
   signal config_data_readback_reg : data_ary := ((others => '0'), (others => '0'), (others => '0'), (others => '0'), (others => '0'));
   
   signal readback_cfg_a1, readback_cfg_a2, readback_cfg_a3, readback_cfg_a4: std_logic_vector(7 downto 0) := (others => '0');
   
   --   -- attribute dont_touch : string; 
   --   -- attribute dont_touch of readback_cfg_a1 : signal is "true";  
   --   -- attribute dont_touch of readback_cfg_a2 : signal is "true";  
   --   -- attribute dont_touch of readback_cfg_a3 : signal is "true";  
   --   -- attribute dont_touch of readback_cfg_a4 : signal is "true";  
   --   -- attribute dont_touch of dval_rx : signal is "true";
   --   -- attribute dont_touch of done_i : signal is "true";
   --   -- attribute dont_touch of ptrn_on_i : signal is "true";
   --   -- attribute dont_touch of sclk_i : signal is "true";
   
begin
   
   CS_N <= cs_n_i;
   SCLK <= sclk_i; -- sclk_i_bufr;
   
   bufr_inst : BUFR
   port map(
      CE => '1',
      CLR => '0',
      I => sclk_i,
      O => sclk_i_bufr
      );
   
   ERR <= err_i;
   DONE <= done_i;
   PTRN_ON <= ptrn_on_i;
   
   reset_sync : sync_reset
   port map (
      clk => CLK,
      areset => ARESET,
      sreset => sreset);
   
   sync_ptren : double_sync
   port map(
      D => PTRN_EN,
      Q => ptrn_en_sync,
      RESET => '0',
      CLK => CLK); 
   
   test_pattern_loading : process(CLK)
      variable ptrn_en_1p : std_ulogic := '0';
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            test_pattern_hold <= DEFAULT_PATTERN;
            ptrn_en_1p := '0';
         else
            if ptrn_en_sync = '1' then
               test_pattern_hold <= std_ulogic_vector(PTRN_DATA);
            end if;
            
            if done_i = '1' and test_pattern_enabled /= ptrn_en_sync then
               enable_test_pattern <= ptrn_en_sync;
            end if; 
            
            ptrn_en_1p := ptrn_en_sync;
         end if;
      end if;
   end process;
   
   config_data(3)(7 downto 6) <= TEST_PATTERN_ON when enable_test_pattern = '1' else TEST_PATTERN_OFF;
   config_data(3)(5 downto 0) <= std_logic_vector(test_pattern_hold(13 downto 8));
   config_data(4) <= std_logic_vector(test_pattern_hold(7 downto 0));
   
   cfg_word <= rw_n & config_addr(index) & config_data(index);
   
   spi_out : spi_tx
   generic map(
      CLKDIV => SCLK_DIV,
      BITWIDTH => 16)
   port map(
      CLK => CLK,
      DIN => cfg_word,
      STB => dval_spi_tx,
      ACK => ack_i,
      CSn => cs_n_i,
      SDA => MOSI,
      SCL => sclk_i);
   
   spi_in : spi_rx
   generic map(
      BITWIDTH => 16)
   port map(
      CLK => CLK,
      DOUT => data_spi_rx,
      DVAL => dval_spi_rx,
      CSn => cs_n_i,
      SDA => MISO,
      SCL => sclk_i_bufr);
   
   configuration_fsm : block
      type ConfigState is (CFG_INIT, CFG_WAIT_EN, CFG_WRITE, CFG_WAIT_ACK, CFG_READ, CFG_WAIT_RD_ACK, CFG_WAIT_RD_DVAL, CFG_DONE, CFG_DONE_TEST_PTRN);
      signal state, next_state : ConfigState := CFG_INIT;
      
      begin
      state_reg : process(CLK)
      begin
         if rising_edge(CLK) then
            if sreset = '1' then
               state <= CFG_INIT;
            else
               state <= next_state;
               index <= next_index;
            end if;
            
            if dval_rx = '1' then
               config_data_readback_reg(index) <= data_spi_rx(7 downto 0);
               case index is
                  when 1 => 
                     readback_cfg_a1 <= data_spi_rx(7 downto 0);
                  
                  when 2 => 
                     readback_cfg_a2 <= data_spi_rx(7 downto 0);
                  
                  when 3 => 
                     readback_cfg_a3 <= data_spi_rx(7 downto 0);
                  
                  when 4 => 
                     readback_cfg_a4 <= data_spi_rx(7 downto 0);
                  
                  when others =>                  
               end case;
               rx_cs_n_i <= '1';
            else
               rx_cs_n_i <= '0';
            end if;
            
         end if;
      end process;
      
      configuration_fsm_outputs : process(EN, state, ack_i, index, enable_test_pattern, config_addr, config_data, dval_spi_rx)
      begin
         case state is
            when CFG_INIT =>
               dval_rx <= '0';
               rw_n <= '0';
               RQST <= '0';
               dval_spi_tx <= '0';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= 0;
               next_state <= CFG_WAIT_EN;
            
            when CFG_WAIT_EN =>
               dval_rx <= '0';
               rw_n <= '0';
               RQST <= '1';
               dval_spi_tx <= '0';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= index;
               if EN = '1' then
                  next_state <= CFG_WRITE;
               else
                  next_state <= CFG_WAIT_EN;
               end if;
            
            when CFG_WRITE =>
               dval_rx <= '0';
               rw_n <= '0';
               RQST <= '1';
               dval_spi_tx <= '1';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= index;
               next_state <= CFG_WAIT_ACK;
            
            when CFG_WAIT_ACK =>
               dval_rx <= '0';
               rw_n <= '0';
               RQST <= '1';
               dval_spi_tx <= '0';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= index;
               if ack_i = '1' then
                  if index = 0 then -- reset register is write only
                     next_state <= CFG_WRITE;
                     next_index <= index + 1;
                  else
                     next_state <= CFG_READ;
                  end if;
               else
                  next_state <= CFG_WAIT_ACK;
               end if;
            
            when CFG_READ =>
               dval_rx <= '0';
               rw_n <= '1';
               RQST <= '1';
               dval_spi_tx <= '1';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= index;
               --next_state <= CFG_WAIT_RD_ACK;
               next_state <= CFG_WAIT_RD_DVAL;
            
            when CFG_WAIT_RD_ACK =>
               dval_rx <= '0';
               rw_n <= '1';
               RQST <= '1';
               dval_spi_tx <= '0';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= index;
               if ack_i = '1' then
                  if index < NUM_REGS-1 then
                     next_state <= CFG_WRITE;
                     next_index <= index + 1;
                  else
                     if enable_test_pattern = '0' then
                        next_state <= CFG_DONE;
                     else
                        next_state <= CFG_DONE_TEST_PTRN;
                     end if;
                  end if;
               else
                  next_state <= CFG_WAIT_RD_ACK;
               end if;
               --if ack_i = '1' then
               --                  next_state <= CFG_WAIT_RD_DVAL;
               --               else
               --                  next_state <= CFG_WAIT_RD_ACK;
               --               end if;
            
            when CFG_WAIT_RD_DVAL =>
               dval_rx <= '0';
               rw_n <= '1';            
               RQST <= '1';
               dval_spi_tx <= '0';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= index;
               --if dval_spi_rx = '1' then
               --                  dval_rx <= '1';
               --                  if index < NUM_REGS-1 then
               --                     next_state <= CFG_WRITE;
               --                     next_index <= index + 1;
               --                  else
               --                     if enable_test_pattern = '0' then
               --                        next_state <= CFG_DONE;
               --                     else
               --                        next_state <= CFG_DONE_TEST_PTRN;
               --                     end if;
               --                  end if;
               --               else
               --                  next_state <= CFG_WAIT_RD_DVAL;
               --               end if;
               
               if dval_spi_rx = '1' then
                  dval_rx <= '1';
                  next_state <= CFG_WAIT_RD_ACK;
               else
                  next_state <= CFG_WAIT_RD_DVAL;
               end if;
            
            when CFG_DONE =>
               dval_rx <= '0';
               rw_n <= '0';
               RQST <= '0';
               dval_spi_tx <= '0';
               done_i <= '1';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= 0;
               
               if enable_test_pattern = '1' then
                  next_index <= 3;
                  next_state <= CFG_WAIT_EN;
               else
                  next_state <= CFG_DONE;
               end if;
            
            when CFG_DONE_TEST_PTRN =>
               dval_rx <= '0';
               rw_n <= '0';              
               RQST <= '0';
               dval_spi_tx <= '0';
               done_i <= '1';
               ptrn_on_i <= '1';
               test_pattern_enabled <= '1';
               next_index <= 0;
               
               if enable_test_pattern = '0' then
                  next_index <= 3;
                  next_state <= CFG_WAIT_EN;
               else
                  next_state <= CFG_DONE_TEST_PTRN;
               end if;
            
            when others =>
               dval_rx <= '0';
               rw_n <= '0';              
               RQST <= '0';
               dval_spi_tx <= '0';
               done_i <= '0';
               ptrn_on_i <= '0';
               test_pattern_enabled <= '0';
               next_index <= 0;
               next_state <= CFG_INIT;
            
         end case;
         -- pragma translate_off
         RQST <= '0';
         -- pragma translate_on
               
      end process;
   end block configuration_fsm;
   
   check_config : process(CLK)
   begin
      if rising_edge(CLK) then        
         if done_i = '1' then
            for i in 1 to 4 loop
               if config_data_readback_reg(i) /= config_data(i) then
                  err_i <= '1';
               end if;
            end loop;
         else
            err_i <= '0';
         end if;
      end if;
   end process;
   
end quad_adc_ctrl;
