------------------------------------------------------------------
--!   @file mgt_wrapper_stim.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
--library TEL2000;
use work.TEL2000.all;

entity mgt_wrapper_stim is
port(
   ARESETN : out std_logic;
   CLK_100MHZ : out std_logic;
   CLK_160MHZ : out std_logic;
   INIT_CLK : out std_logic;
   
   AURORA_1_CLK_P0 : out std_logic;
   AURORA_1_CLK_N0 : out std_logic;
   
   AURORA_1_CLK_P1 : out std_logic;
   AURORA_1_CLK_N1 : out std_logic;
   
   AURORA_2_CLK_P0 : out std_logic;
   AURORA_2_CLK_N0 : out std_logic;
   
   AURORA_2_CLK_P1 : out std_logic;
   AURORA_2_CLK_N1 : out std_logic;
   
   AXI4_LITE_MOSI_1 : out t_axi4_lite_mosi;
   AXI4_LITE_MISO_1 : in t_axi4_lite_miso;
   
   AXI4_LITE_MOSI_2 : out t_axi4_lite_mosi;
   AXI4_LITE_MISO_2 : in t_axi4_lite_miso;

   DATA_TEST_mosi_1 : out t_axi4_stream_mosi32;
   DATA_TEST_miso_1 : in t_axi4_stream_miso;
   
   DATA_TEST_mosi_2 : out t_axi4_stream_mosi32;
   DATA_TEST_miso_2 : in t_axi4_stream_miso;

   VIDEO_TEST_mosi_1 : out t_axi4_stream_mosi32;
   VIDEO_TEST_miso_1 : in t_axi4_stream_miso;

   VIDEO_TEST_mosi_2 : out t_axi4_stream_mosi32;
   VIDEO_TEST_miso_2 : in t_axi4_stream_miso;

   EXP_TEST_mosi_1 : out t_axi4_stream_mosi32;
   EXP_TEST_miso_1 : in t_axi4_stream_miso;

   EXP_TEST_mosi_2 : out t_axi4_stream_mosi32;
   EXP_TEST_miso_2 : in t_axi4_stream_miso;

   DATA_VERIF_miso_1 : out t_axi4_stream_miso;
   DATA_VERIF_miso_2 : out t_axi4_stream_miso;
  
   VIDEO_VERIF_miso_1 : out t_axi4_stream_miso;
   VIDEO_VERIF_miso_2 : out t_axi4_stream_miso;

   EXP_VERIF_miso_1 : out t_axi4_stream_miso;
   EXP_VERIF_miso_2 : out t_axi4_stream_miso
   
   );
end mgt_wrapper_stim;

--}} End of automatically maintained section

architecture sim of mgt_wrapper_stim is

constant clk_100Mhz_period : time := 10ns;
constant clk_160Mhz_period : time := 6.25ns;
constant clk_init_period : time := 20ns;
constant aurora_clk_period : time := 8ns;
constant RESET_LENGTH : time := 200ns;

constant DATA_TO_SEND : natural := 1000;

signal CLK_100MHZ_i : std_logic := '0';
signal CLK_160MHZ_i : std_logic := '0';
signal INIT_CLK_i : std_logic := '0';
signal aurora_clk_i : std_logic := '0';

signal ReadValue : std_logic_vector(31 downto 0);

begin

CLK_100MHZ <= CLK_100MHZ_i;  
CLK_160MHZ <= CLK_160MHZ_i;
INIT_CLK <= INIT_CLK_i;  

AURORA_1_CLK_P0 <= aurora_clk_i;
AURORA_1_CLK_N0 <= not aurora_clk_i;

AURORA_1_CLK_P1 <= aurora_clk_i;
AURORA_1_CLK_N1 <= not aurora_clk_i;

AURORA_2_CLK_P0 <= aurora_clk_i;
AURORA_2_CLK_N0 <= not aurora_clk_i;

AURORA_2_CLK_P1 <= aurora_clk_i;
AURORA_2_CLK_N1 <= not aurora_clk_i;

   -- enter your statements here --        
CLK100MHZ_GEN: process(CLK_100MHZ_i)
begin
	CLK_100MHZ_i<= not CLK_100MHZ_i after clk_100Mhz_period/2; 
end process;

CLK160MHz_GEN: process(CLK_160MHZ_i)
begin
	CLK_160MHZ_i<= not CLK_160MHZ_i after clk_160Mhz_period/2; 
end process;

INIT_CLK_GEN: process(INIT_CLK_i)
begin
	INIT_CLK_i<= not INIT_CLK_i after clk_init_period/2; 
end process;

AURORO_CLK : process(aurora_clk_i)
begin
	aurora_clk_i<= not aurora_clk_i after aurora_clk_period/2; 
end process;

RES: process
begin
	ARESETN<='0';  -- reset of the counter
	wait for RESET_LENGTH;
	ARESETN<='1';
	wait;
end process;

AXI4_LITE : process
begin
   wait for RESET_LENGTH;
   wait for clk_100Mhz_period * 10;
   
   write_axi_lite(x"00000008", x"00000007", AXI4_LITE_MISO_1, AXI4_LITE_MOSI_1);
   wait for clk_100Mhz_period * 10;
   read_axi_lite (x"00000008",  AXI4_LITE_MISO_1, AXI4_LITE_MOSI_1, ReadValue);
   wait for clk_100Mhz_period * 10;
   write_axi_lite(x"00000008", x"00000000", AXI4_LITE_MISO_1, AXI4_LITE_MOSI_1);
   wait;
end process;


DATA_STIM_1 : process
begin
   DATA_TEST_mosi_1.TDATA <= (others => '0');
   DATA_TEST_mosi_1.TVALID <= '0';
   DATA_TEST_mosi_1.TSTRB <= (others => '0');
   DATA_TEST_mosi_1.TKEEP <= (others => '0');
   DATA_TEST_mosi_1.TLAST <= '0';
   DATA_TEST_mosi_1.TID <= (others => '0');
   DATA_TEST_mosi_1.TUSER <= (others => '0');
   DATA_TEST_mosi_1.TDEST <= (others => '0');
   
   DATA_VERIF_miso_1.TREADY <= '1';
   
   wait for 60 us;
   
   for i in 1 to DATA_TO_SEND - 1 loop
      wait until CLK_160MHZ_i = '1';
      if DATA_TEST_miso_1.TREADY = '0' then
         wait until DATA_TEST_miso_1.TREADY = '1';
      end if;
      DATA_TEST_mosi_1.TVALID <= '1';
      DATA_TEST_mosi_1.TDATA <= std_logic_vector(to_unsigned(i*100,DATA_TEST_mosi_1.TDATA'length));
      DATA_TEST_mosi_1.TSTRB <= (others => '1');
      DATA_TEST_mosi_1.TKEEP <= (others => '1');
      if i = DATA_TO_SEND - 1 then
         DATA_TEST_mosi_1.TLAST <= '1';
      else
         DATA_TEST_mosi_1.TLAST <= '0';
      end if;
   end loop;
   
   wait until CLK_160MHZ_i = '1';
   
end process;

DATA_STIM_2 : process
begin
   DATA_TEST_mosi_2.TDATA <= (others => '0');
   DATA_TEST_mosi_2.TVALID <= '0';
   DATA_TEST_mosi_2.TSTRB <= (others => '0');
   DATA_TEST_mosi_2.TKEEP <= (others => '0');
   DATA_TEST_mosi_2.TLAST <= '0';
   DATA_TEST_mosi_2.TID <= (others => '0');
   DATA_TEST_mosi_2.TUSER <= (others => '0');
   DATA_TEST_mosi_2.TDEST <= (others => '0');

   DATA_VERIF_miso_2.TREADY <= '1';
   
   wait for 60 us;
   
   for i in 1 to DATA_TO_SEND loop
      wait until CLK_160MHZ_i = '1';
      if DATA_TEST_miso_2.TREADY = '0' then
         wait until DATA_TEST_miso_2.TREADY = '1';
      end if;
      DATA_TEST_mosi_2.TVALID <= '1';
      DATA_TEST_mosi_2.TDATA <= std_logic_vector(to_unsigned(i*100,DATA_TEST_mosi_1.TDATA'length));
      DATA_TEST_mosi_2.TSTRB <= (others => '1');
      DATA_TEST_mosi_2.TKEEP <= (others => '1');
      if i = DATA_TO_SEND then
         DATA_TEST_mosi_2.TLAST <= '1';
      else
         DATA_TEST_mosi_2.TLAST <= '0';
      end if;
   end loop;
   
   wait until CLK_160MHZ_i = '1';
   
end process;

VIDEO_STIM_1 : process
begin
   VIDEO_TEST_mosi_1.TDATA <= (others => '0');
   VIDEO_TEST_mosi_1.TVALID <= '0';
   VIDEO_TEST_mosi_1.TSTRB <= (others => '0');
   VIDEO_TEST_mosi_1.TKEEP <= (others => '0');
   VIDEO_TEST_mosi_1.TLAST <= '0';
   VIDEO_TEST_mosi_1.TID <= (others => '0');
   VIDEO_TEST_mosi_1.TUSER <= (others => '0');
   VIDEO_TEST_mosi_1.TDEST <= (others => '0');
   
   VIDEO_VERIF_miso_1.TREADY <= '1';
   
   wait for 60 us;
   
   for i in 1 to DATA_TO_SEND - 2 loop
      wait until CLK_160MHZ_i = '1';
      if VIDEO_TEST_miso_1.TREADY = '0' then
         wait until VIDEO_TEST_miso_1.TREADY = '1';
      end if;
      VIDEO_TEST_mosi_1.TVALID <= '1';
      VIDEO_TEST_mosi_1.TDATA <= std_logic_vector(to_unsigned(i*100,VIDEO_TEST_mosi_1.TDATA'length));
      VIDEO_TEST_mosi_1.TSTRB <= (others => '1');
      VIDEO_TEST_mosi_1.TKEEP <= (others => '1');
      if i = DATA_TO_SEND - 2 then
         VIDEO_TEST_mosi_1.TLAST <= '1';
      else
         VIDEO_TEST_mosi_1.TLAST <= '0';
      end if;
   end loop;
   
   wait until CLK_160MHZ_i = '1';
   
end process;

VIDEO_STIM_2 : process
begin
   VIDEO_TEST_mosi_2.TDATA <= (others => '0');
   VIDEO_TEST_mosi_2.TVALID <= '0';
   VIDEO_TEST_mosi_2.TSTRB <= (others => '0');
   VIDEO_TEST_mosi_2.TKEEP <= (others => '0');
   VIDEO_TEST_mosi_2.TLAST <= '0';
   VIDEO_TEST_mosi_2.TID <= (others => '0');
   VIDEO_TEST_mosi_2.TUSER <= (others => '0');
   VIDEO_TEST_mosi_2.TDEST <= (others => '0');

   VIDEO_VERIF_miso_2.TREADY <= '1';
   
   wait for 60 us;
   
   for i in 1 to DATA_TO_SEND loop
      wait until CLK_160MHZ_i = '1';
      if VIDEO_TEST_miso_1.TREADY = '0' then
         wait until VIDEO_TEST_miso_1.TREADY = '1';
      end if;
      VIDEO_TEST_mosi_2.TVALID <= '1';
      VIDEO_TEST_mosi_2.TDATA <= std_logic_vector(to_unsigned(i*100,VIDEO_TEST_mosi_1.TDATA'length));
      VIDEO_TEST_mosi_2.TSTRB <= (others => '1');
      VIDEO_TEST_mosi_2.TKEEP <= (others => '1');
      if i = DATA_TO_SEND then
         VIDEO_TEST_mosi_2.TLAST <= '1';
      else
         VIDEO_TEST_mosi_2.TLAST <= '0';
      end if;

   end loop;
   
   wait until CLK_160MHZ_i = '1';
   
end process;

EXP_STIM_1 : process
begin
   EXP_TEST_mosi_1.TDATA <= (others => '0');
   EXP_TEST_mosi_1.TVALID <= '0';
   EXP_TEST_mosi_1.TSTRB <= (others => '0');
   EXP_TEST_mosi_1.TKEEP <= (others => '0');
   EXP_TEST_mosi_1.TLAST <= '0';
   EXP_TEST_mosi_1.TID <= (others => '0');
   EXP_TEST_mosi_1.TUSER <= (others => '0');
   EXP_TEST_mosi_1.TDEST <= (others => '0');
   
   EXP_VERIF_miso_1.TREADY <= '1';
   
   wait for 60 us;
   
   for i in 1 to DATA_TO_SEND - 3 loop
      wait until CLK_160MHZ_i = '1';
      if EXP_TEST_miso_1.TREADY = '0' then
         wait until EXP_TEST_miso_1.TREADY = '1';
      end if;
      EXP_TEST_mosi_1.TVALID <= '1';
      EXP_TEST_mosi_1.TDATA <= std_logic_vector(to_unsigned(i*100,EXP_TEST_mosi_1.TDATA'length));
      EXP_TEST_mosi_1.TSTRB <= (others => '1');
      EXP_TEST_mosi_1.TKEEP <= (others => '1');
      if i = DATA_TO_SEND - 3 then
         EXP_TEST_mosi_1.TLAST <= '1';
      else
         EXP_TEST_mosi_1.TLAST <= '0';
      end if;
   end loop;
   
   wait until CLK_160MHZ_i = '1';
   
end process;

EXP_STIM_2 : process
begin
   EXP_TEST_mosi_2.TDATA <= (others => '0');
   EXP_TEST_mosi_2.TVALID <= '0';
   EXP_TEST_mosi_2.TSTRB <= (others => '0');
   EXP_TEST_mosi_2.TKEEP <= (others => '0');
   EXP_TEST_mosi_2.TLAST <= '0';
   EXP_TEST_mosi_2.TID <= (others => '0');
   EXP_TEST_mosi_2.TUSER <= (others => '0');
   EXP_TEST_mosi_2.TDEST <= (others => '0');

   EXP_VERIF_miso_2.TREADY <= '1';
   
   wait for 60 us;
   
   for i in 1 to DATA_TO_SEND loop
      wait until CLK_160MHZ_i = '1';
      if EXP_TEST_miso_2.TREADY = '0' then
         wait until EXP_TEST_miso_2.TREADY = '1';
      end if;
      EXP_TEST_mosi_2.TVALID <= '1';
      EXP_TEST_mosi_2.TDATA <= std_logic_vector(to_unsigned(i*100,EXP_TEST_mosi_1.TDATA'length));
      EXP_TEST_mosi_2.TSTRB <= (others => '1');
      EXP_TEST_mosi_2.TKEEP <= (others => '1');
      if i = DATA_TO_SEND then
         EXP_TEST_mosi_2.TLAST <= '1';
      else
         EXP_TEST_mosi_2.TLAST <= '0';
      end if;
   end loop;
   
   wait until CLK_160MHZ_i = '1';
   
end process;

--AXI4_LITE_2: process 
--begin
   AXI4_LITE_MOSI_2.AWVALID <= '0';
   AXI4_LITE_MOSI_2.WVALID <= '0';
   AXI4_LITE_MOSI_2.ARVALID <= '0';
   AXI4_LITE_MOSI_2.BREADY <= '1';
   AXI4_LITE_MOSI_2.RREADY <= '1';
--end process;

end sim;
