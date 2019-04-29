-------------------------------------------------------------------------------
--
-- Title       : clink_tb_stim
-- Author      : Olivier Dionne
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : Test bench for Clink delay calibration module
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.proxy_define.all;
use work.fpa_serdes_define.all;

entity clink_tb_stim is
   port(
      --------------------------------
      -- Clink Pattern Validator
      --------------------------------
      FVAL_SIZE      : out unsigned(10 downto 0);   --number of LVAL during one FVAL
      FVAL           : out std_logic;
      LVAL           : out std_logic;
      START          : out std_logic;
      TEST_FEEDBACK  : in  std_logic;
      
      --------------------------------
      -- MISC
      --------------------------------
      CLK80    : out STD_LOGIC;
      ARESET   : out STD_LOGIC
   );
end clink_tb_stim;



architecture rtl of clink_tb_stim is

   -- Constants
   constant CLK80_PER : time := 12.5 ns;
   constant NB_OF_LVAL : integer := 8;
   
   -- CLK and RESET
   signal clk80_o : std_logic := '0';
   signal rst_i : std_logic := '1';

begin
   --! Assign clock and reset
   CLK80  <= clk80_o;
   ARESET <= rst_i;

   --! Clock 80MHz generation                   
   CLK80_GEN: process(clk80_o)
   begin
      clk80_o <= not clk80_o after CLK80_PER/2;                          
   end process;

   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for 1 us;
      rst_i <= '0'; 
      wait;
   end process;
   
   --! Pattern simulation
   PATTERN : process 
   begin
      
      -- Init
      FVAL_SIZE <= to_unsigned(NB_OF_LVAL, FVAL_SIZE'length);
      FVAL <= '0';
      LVAL <= '0';
      START <= '0';
      
      -- Reset
      wait until rst_i = '0';
      wait for 500 ns;
      
      ----------------------
      -- Start valid test --
      ----------------------
      wait until rising_edge(clk80_o);
      START <= '1';
      wait until rising_edge(clk80_o);
      START <= '0';
      
      -- FVAL rises
      FVAL <= '1';
      
      -- LVAL generation
      for lval_cnt in 1 to NB_OF_LVAL loop
         -- 1st LVAL on same edge as FVAL
         if lval_cnt > 1 then
            wait until rising_edge(clk80_o);
         end if;
         -- LVAL rises
         LVAL <= '1';
         -- LVAL falls
         wait until rising_edge(clk80_o);
         LVAL <= '0';
      end loop;
      
      -- FVAL falls (same edge as last LVAL)
      FVAL <= '0';
      
      wait until TEST_FEEDBACK = '1';
      wait for 500 ns;
      
      ----------------------
      -- Start valid test --
      ----------------------
      wait until rising_edge(clk80_o);
      START <= '1';
      wait until rising_edge(clk80_o);
      START <= '0';
      
      -- FVAL rises
      FVAL <= '1';
      
      -- LVAL generation
      for lval_cnt in 1 to NB_OF_LVAL+1 loop    -- "+1" for the header LVAL on SCD detectors
         -- 1st LVAL on same edge as FVAL
         if lval_cnt > 1 then
            wait until rising_edge(clk80_o);
         end if;
         -- LVAL rises
         LVAL <= '1';
         -- LVAL falls
         wait until rising_edge(clk80_o);
         LVAL <= '0';
      end loop;
      
      -- FVAL falls (same edge as last LVAL)
      FVAL <= '0';
      
      wait until TEST_FEEDBACK = '1';
      wait for 500 ns;
      
      ------------------------
      -- Start invalid test --
      ------------------------
      wait until rising_edge(clk80_o);
      START <= '1';
      wait until rising_edge(clk80_o);
      START <= '0';
      
      -- FVAL rises
      FVAL <= '1';
      
      -- LVAL generation (not enough LVAL)
      for lval_cnt in 1 to NB_OF_LVAL/2 loop
         -- 1st LVAL on same edge as FVAL
         if lval_cnt > 1 then
            wait until rising_edge(clk80_o);
         end if;
         -- LVAL rises
         LVAL <= '1';
         -- LVAL falls
         wait until rising_edge(clk80_o);
         LVAL <= '0';
      end loop;
      
      -- FVAL falls (same edge as last LVAL)
      FVAL <= '0';
      
      wait until TEST_FEEDBACK = '1';
      wait for 500 ns;
      
      ------------------------
      -- Start invalid test --
      ------------------------
      wait until rising_edge(clk80_o);
      START <= '1';
      wait until rising_edge(clk80_o);
      START <= '0';
      
      -- FVAL rises
      FVAL <= '1';
      
      -- LVAL generation (variable LVAL length)
      for lval_cnt in 1 to NB_OF_LVAL loop
         -- 1st LVAL on same edge as FVAL
         if lval_cnt > 1 then
            wait until rising_edge(clk80_o);
         end if;
         -- LVAL rises
         LVAL <= '1';
         -- variable LVAL length
         for lval_len in 1 to lval_cnt loop
            wait until rising_edge(clk80_o);
         end loop;
         -- LVAL falls
         LVAL <= '0';
      end loop;
      
      -- FVAL falls (same edge as last LVAL)
      FVAL <= '0';
      
      wait until TEST_FEEDBACK = '1';
      wait for 500 ns;
      
      ------------------------
      -- Start invalid test --
      ------------------------
      -- FVAL always low
      FVAL <= '0';
      
      wait until rising_edge(clk80_o);
      START <= '1';
      wait until rising_edge(clk80_o);
      START <= '0';
      
      wait until TEST_FEEDBACK = '1';
      wait for 500 ns;
      
      ------------------------
      -- Start invalid test --
      ------------------------
      -- FVAL always high
      FVAL <= '1';
      
      wait until rising_edge(clk80_o);
      START <= '1';
      wait until rising_edge(clk80_o);
      START <= '0';
      
      wait until TEST_FEEDBACK = '1';
      
      report "SIMULATION SUCCESSFULL" severity warning;
      
   end process;

end rtl;
