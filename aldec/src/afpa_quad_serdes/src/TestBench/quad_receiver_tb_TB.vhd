library afpa_quad_serdes;
use afpa_quad_serdes.fpa_serdes_define.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity quad_receiver_tb_tb is
end quad_receiver_tb_tb;

architecture TB_ARCHITECTURE of quad_receiver_tb_tb is
   -- Component declaration of the tested unit
   component quad_receiver_tb
      port(
         ARESET : in STD_LOGIC;
         CLK_DIV : in STD_LOGIC;
         EN : in STD_LOGIC;
         TEST_PATTERN : in STD_LOGIC_VECTOR(13 downto 0);
         adc0_data_i : in STD_LOGIC_VECTOR(13 downto 0);
         adc1_data_i : in STD_LOGIC_VECTOR(13 downto 0);
         adc2_data_i : in STD_LOGIC_VECTOR(13 downto 0);
         adc3_data_i : in STD_LOGIC_VECTOR(13 downto 0);
         DONE : out STD_LOGIC;
         SUCCESS : out STD_LOGIC;
         BSLIP_CNT : out STD_LOGIC_VECTOR(3 downto 0);
         DLY_VALUE : out STD_LOGIC_VECTOR(4 downto 0);
         EDGES : out STD_LOGIC_VECTOR(31 downto 0) );
   end component;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESET : STD_LOGIC;
   signal CLK_DIV : STD_LOGIC := '0';
   signal EN : STD_LOGIC;
   signal TEST_PATTERN : STD_LOGIC_VECTOR(13 downto 0);
   signal adc0_data_i : STD_LOGIC_VECTOR(13 downto 0);
   signal adc1_data_i : STD_LOGIC_VECTOR(13 downto 0);
   signal adc2_data_i : STD_LOGIC_VECTOR(13 downto 0);
   signal adc3_data_i : STD_LOGIC_VECTOR(13 downto 0);
   -- Observed signals - signals mapped to the output ports of tested entity
   signal DONE : STD_LOGIC;
   signal SUCCESS : STD_LOGIC;
   signal BSLIP_CNT : STD_LOGIC_VECTOR(3 downto 0);
   signal DLY_VALUE : STD_LOGIC_VECTOR(4 downto 0);
   signal EDGES : STD_LOGIC_VECTOR(31 downto 0);
   signal cnt : unsigned(15 downto 0);
   
   -- Add your code here ... 
   
   constant CLK_DIV_PERIOD         : time := 100 ns;
   
begin
   
   -- reset
   U0: process
   begin
      areset <= '1'; 
      wait for 250 ns;
      areset <= '0';
      wait;
   end process; 
   
   
   U1: process
   begin
      EN <= '0'; 
      wait for 2000 ns;
      EN <= '1';
      wait for 2100 ns;
      EN <= '0';
   end process;
   
   -- clk
   U2: process(CLK_DIV)
   begin
      CLK_DIV <= not CLK_DIV after CLK_DIV_PERIOD/2; 
   end process;  
   
   TEST_PATTERN <= std_logic_vector(to_unsigned(5623, 14));
   adc0_data_i <= std_logic_vector(to_unsigned(5623, 14));
   adc1_data_i <= std_logic_vector(to_unsigned(5623, 14));
   adc2_data_i <= std_logic_vector(to_unsigned(5623, 14));
   
   
   Ue: process(CLK_DIV)
   begin
      if rising_edge(CLK_DIV) then
         if areset = '1' then 
            cnt <= (others => '0');  
         else 
            if cnt > 7_000 then
               adc3_data_i <= std_logic_vector(to_unsigned(5623, 14));
            elsif cnt > 5_000 then
               adc3_data_i <= std_logic_vector(to_unsigned(0, 14));
               cnt <= cnt + 1;
            else
               adc3_data_i <= std_logic_vector(to_unsigned(5623, 14));
               cnt <= cnt + 1;
            end if;
         end if;
      end if;
   end process;
   
   -- Unit Under Test port map
   UUT : quad_receiver_tb
   port map (
      ARESET => ARESET,
      CLK_DIV => CLK_DIV,
      EN => EN,
      TEST_PATTERN => TEST_PATTERN,
      adc0_data_i => adc0_data_i,
      adc1_data_i => adc1_data_i,
      adc2_data_i => adc2_data_i,
      adc3_data_i => adc3_data_i,
      DONE => DONE,
      SUCCESS => SUCCESS,
      BSLIP_CNT => BSLIP_CNT,
      DLY_VALUE => DLY_VALUE,
      EDGES => EDGES
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_quad_receiver_tb of quad_receiver_tb_tb is
   for TB_ARCHITECTURE
      for UUT : quad_receiver_tb
         use entity work.quad_receiver_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_quad_receiver_tb;

