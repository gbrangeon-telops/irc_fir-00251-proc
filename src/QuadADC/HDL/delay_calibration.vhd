-------------------------------------------------------------------------------
--
-- Title       : delay_calibration
-- Design      : adc_intf_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\QuadADC\HDL\delay_calibration.vhd
-- Generated   : Wed May 27 09:14:02 2015
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity delay_calibration is
   port(
      CLK : in std_logic; -- same as output clock of the iserdes
      ARESET : in std_logic;
      EN : std_logic;
      DATA : in std_logic_vector(13 downto 0); -- parallel data from the iserdes
      PATTERN_VALID : in std_logic; -- control signal from the test pattern validator block
      TEST_DONE : in std_logic; -- control signal from the test pattern validator block
      START_TEST : out std_logic; -- control signal to a test pattern validator block
      BITSLIP : out std_logic; -- control signal to the iserdes
      DELAY : out std_logic_vector(4 downto 0); -- control signal to the idelay
      LD : out std_logic; -- control signal to the idelay
      DONE : out std_logic; -- asserted when the calibration is finished
      SUCCESS : out std_logic; -- valid when DONE is high
      -- debugging section
      BITSLIP_CNT : out std_logic_vector(3 downto 0); -- number of bitslips
      EDGES : out std_logic_vector(31 downto 0) -- bit vector with '1' where a data transition was seen, '0' being stable positions
      );
end delay_calibration;

architecture rtl of delay_calibration is
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   signal sreset : std_ulogic;
   
   signal delay_i : unsigned(DELAY'length-1 downto 0) := (others => '0');
   signal data_i, data_1p, data_hold : std_ulogic_vector(DATA'length-1 downto 0) := (others => '0');
   
   constant INITIAL_DELAY : unsigned(DELAY'length-1 downto 0) := to_unsigned(23, DELAY'length); -- f = 560 Mbps => T = 1785 ps ~= 23 * 78ps
   constant HALF_BIT : unsigned(DELAY'length-1 downto 0) := to_unsigned(11, DELAY'length); -- 11 * 78 ps = 858 ps
   constant N_WAIT : integer := 3; -- number of wait state clock cycles during the bit slip process
   
   type DelayCalibState is (DLY_INIT, DLY_LOAD_INIT, DLY_WAIT_INIT, DLY_LOAD, DLY_WAIT, DLY_ADJUST, DLY_DETECT_EDGE, DLY_FINAL_ADJUST, DLY_DONE);
   type BitSlipCalibState is (BS_INIT, BS_ADJUST, BS_WAIT, BS_START_TEST, BS_VALIDATE, BS_DONE);
   
   signal bs_state, bs_next_state : BitSlipCalibState := BS_INIT;
   signal dly_state, dly_next_state : DelayCalibState := DLY_INIT;
   signal ld_out : std_ulogic := '0';
   signal start_test_out : std_ulogic := '0';
   signal calibration_done : std_ulogic := '0';
   signal bitslip_out : std_ulogic := '0';
   signal bitslip_cnt_i : unsigned(3 downto 0) := (others => '0');
   signal wait_done, detect_done : std_ulogic := '0';
   signal start_calibration : std_ulogic := '1'; -- not used
   signal edges_i : std_ulogic_vector(31 downto 0) := (others => '0');
   signal delay_success_i, bitslip_success_i : std_ulogic := '0';
   signal success_i, done_i : std_ulogic := '0';
   
   attribute fsm_encoding : string;
   attribute fsm_encoding of dly_state : signal is "one_hot";
   attribute fsm_encoding of dly_next_state : signal is "one_hot";
   attribute fsm_encoding of bs_state : signal is "one_hot";
   attribute fsm_encoding of bs_next_state : signal is "one_hot";
   
   attribute dont_touch : string;
   
   attribute dont_touch of bitslip_cnt_i : signal is "true";
   attribute dont_touch of delay_i : signal is "true";
   attribute dont_touch of bs_state : signal is "true";
   attribute dont_touch of dly_state : signal is "true";
   attribute dont_touch of calibration_done : signal is "true";
   attribute dont_touch of data_1p : signal is "true";
   attribute dont_touch of edges_i : signal is "true";
   
begin
   
   DELAY <= std_logic_vector(delay_i);
   LD <= ld_out;
   DONE <= done_i;
   START_TEST <= start_test_out;
   
   SUCCESS <= success_i;
   
   reset_sync : sync_reset
   port map (
      clk => CLK,
      areset => ARESET,
      sreset => sreset);
   
   BITSLIP <= bitslip_out;--bitslip_i;
   
   BITSLIP_CNT <= std_logic_vector(bitslip_cnt_i);
   EDGES <= std_logic_vector(edges_i);
   
   data_i <= std_ulogic_vector(DATA);
   
   output_reg : process(CLK)
   begin
      if rising_edge(CLK) then
         success_i <= calibration_done and delay_success_i and bitslip_success_i;
         done_i <= calibration_done;
      end if;
   end process;
   
   bitslip_calib_sm :  process(CLK, bs_state, TEST_DONE, PATTERN_VALID, dly_state, bitslip_cnt_i)
      variable cnt, next_cnt : integer range 0 to N_WAIT := 0; -- counter for the waiting period (BS_WAIT)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            bs_state <= BS_INIT;
            bitslip_cnt_i <= (others => '0');
            cnt := 0;
         else
            if EN = '1' then
               bs_state <= bs_next_state;
               cnt := next_cnt;
            end if;
            
            if bitslip_out = '1' then
               bitslip_cnt_i <= bitslip_cnt_i + 1;
            end if;
            
            if bitslip_cnt_i = DATA'LENGTH+1 then
               bitslip_success_i <= '0';
            else
               bitslip_success_i <= '1';
            end if;
            
         end if;
      end if;
      
      case bs_state is 
         when BS_INIT => 
            start_test_out <= '0';
            bitslip_out <= '0';
            calibration_done <= '0';
            next_cnt := 0;
            if dly_state = DLY_DONE then
               bs_next_state <= BS_START_TEST;
            else
               bs_next_state <= BS_INIT;
            end if;
         
         when BS_ADJUST =>
            bitslip_out <= '1';
            start_test_out <= '0';
            calibration_done <= '0';
            next_cnt := 0;
            bs_next_state <= BS_WAIT;
         
         when BS_WAIT => 
            bitslip_out <= '0';
            start_test_out <= '0';
            calibration_done <= '0';
            if cnt = N_WAIT-1 then
               next_cnt := 0;
               bs_next_state <= BS_START_TEST;
            else
               next_cnt := cnt + 1;
               bs_next_state <= BS_WAIT;
            end if;
         
         when BS_START_TEST =>
            bitslip_out <= '0';
            start_test_out <= '1';
            calibration_done <= '0';
            next_cnt := 0;
            bs_next_state <= BS_VALIDATE;
         
         when BS_VALIDATE =>
            bitslip_out <= '0';
            start_test_out <= '0';
            calibration_done <= '0';
            next_cnt := 0;
            if TEST_DONE = '1' then
               if PATTERN_VALID = '1' or bitslip_cnt_i = DATA'LENGTH+1 then
                  bs_next_state <= BS_DONE;
               else
                  bs_next_state <= BS_ADJUST;
               end if;
            else
               bs_next_state <= BS_VALIDATE;
            end if;
         
         when BS_DONE =>
            bitslip_out <= '0';
            start_test_out <= '0';
            calibration_done <= '1';
            next_cnt := 0;
            bs_next_state <= BS_DONE;
         
         when others =>
            bitslip_out <= '0';
            start_test_out <= '0';
            calibration_done <= '0';
            next_cnt := 0;
            bs_next_state <= BS_INIT;
         
      end case;
   end process;
   
   -- machine a etats servant à identifier le délai optimal en s'alignant sur un changement du data parallèle ; alors on déphase d'un demi bit pour être centré sur "l'oeil" du data.
   delay_calib_sm :  process(CLK, dly_state, wait_done, detect_done, data_1p, delay_i, data_hold, delay_success_i)
      variable next_delay_v : unsigned(DELAY'length-1 downto 0) := (others => '0');
      variable edge_found : std_ulogic := '0';
      variable all_delays_visited : std_ulogic := '0';
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            delay_i <= INITIAL_DELAY;
            dly_state <= DLY_INIT;
            edges_i <= (others => '0');
            all_delays_visited := '0';
            delay_success_i <= '0';
         else
            if EN = '1' then
               dly_state <= dly_next_state;
               delay_i <= next_delay_v;
               if ld_out = '1' then
                  data_hold <= data_i;
               end if;
            end if;
         end if;
         
         if edge_found = '1' then
            edges_i(to_integer(delay_i)) <= '1';
         end if;
         
         -- when all delays have been visited, then we have filled the 'edges_i' vector. Restart the SM
         if detect_done = '1' or edge_found = '1' then 
            if all_delays_visited = '0' then
               if delay_i = INITIAL_DELAY+1 then
                  all_delays_visited := '1';
                  delay_i <= INITIAL_DELAY;
                  dly_state <= DLY_INIT;
               end if;
            end if; 
         end if;
         
         -- success is true as soon as we've found an edge
         if edge_found = '1' then
            delay_success_i <= '1';
         end if;
         
         data_1p <= data_i;
      end if;
      
      case dly_state is                
         when DLY_INIT =>
            edge_found := '0';
            ld_out <= '0';
            next_delay_v := delay_i;
            dly_next_state <= DLY_LOAD_INIT;
         
         when DLY_LOAD_INIT => 
            edge_found := '0';
            ld_out <= '1';
            next_delay_v := delay_i;
            dly_next_state <= DLY_WAIT_INIT;
         
         when DLY_WAIT_INIT => 
            edge_found := '0';
            ld_out <= '0';
            next_delay_v := delay_i;
            if wait_done = '1' then
               dly_next_state <= DLY_ADJUST;
            else
               dly_next_state <= DLY_WAIT_INIT;
            end if;
         
         when DLY_LOAD => 
            edge_found := '0';
            next_delay_v := delay_i;
            ld_out <= '1';
            dly_next_state <= DLY_WAIT;
         
         when DLY_WAIT =>
            edge_found := '0';
            ld_out <= '0';
            next_delay_v := delay_i;
            if wait_done = '1' then
               dly_next_state <= DLY_DETECT_EDGE;
            else
               dly_next_state <= DLY_WAIT;
            end if;
         
         when DLY_ADJUST =>
            edge_found := '0';
            ld_out <= '0';
            dly_next_state <= DLY_LOAD;
            next_delay_v := delay_i - 1;
         
         when DLY_DETECT_EDGE =>
            edge_found := '0';
            ld_out <= '0';
            next_delay_v := delay_i;
            if data_hold /= data_1p then
               edge_found := '1';
               
               if all_delays_visited = '1' then
                  if delay_i <= HALF_BIT then
                     next_delay_v := delay_i + HALF_BIT;
                  else
                     next_delay_v := delay_i - HALF_BIT;
                  end if;
                  dly_next_state <= DLY_FINAL_ADJUST;
               else
                  dly_next_state <= DLY_ADJUST;
               end if;
            else
               next_delay_v := delay_i;
               if detect_done = '1' then
                  dly_next_state <= DLY_ADJUST;
               else
                  dly_next_state <= DLY_DETECT_EDGE;
               end if;
               if all_delays_visited = '1' and delay_success_i = '0' then
                  dly_next_state <= DLY_DONE; -- fail when no transition have been detected after all delays have been visited
               end if;
            end if;
         
         when DLY_FINAL_ADJUST => 
            edge_found := '0';
            ld_out <= '1';
            next_delay_v := delay_i;
            dly_next_state <= DLY_DONE;
         
         when DLY_DONE =>
            edge_found := '0';
            ld_out <= '0';
            next_delay_v := delay_i;
            dly_next_state <= DLY_DONE;
         
         when others =>
            edge_found := '0';
            ld_out <= '0';
            next_delay_v := delay_i;
            dly_next_state <= DLY_INIT;
         
      end case;
   end process;
   
   wait_counter : process(CLK)
      variable wait_cnt : unsigned(2 downto 0) := (others => '0');
      variable detect_cnt : unsigned(9 downto 0) := (others => '0');
      constant FINAL_VALUE_WAIT : unsigned(wait_cnt'length-1 downto 0) := (others => '1');
      constant FINAL_VALUE_DETECT : unsigned(detect_cnt'length-1 downto 0) := (others => '1');
   begin
      if rising_edge(CLK) then
         wait_done <= '0';
         detect_done <= '0';
         
         if dly_state = DLY_WAIT or dly_state = DLY_WAIT_INIT then
            if wait_cnt = FINAL_VALUE_WAIT then
               wait_done <= '1';
            else
               wait_cnt := wait_cnt + 1;
            end if;
         else
            wait_cnt := (others => '0');
         end if;
         
         if dly_state = DLY_DETECT_EDGE then
            if detect_cnt = FINAL_VALUE_DETECT then
               detect_done <= '1';
            else
               detect_cnt := detect_cnt + 1;
            end if;
         else
            detect_cnt := (others => '0');
         end if;
         
      end if;
   end process;
   
end rtl;
