----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2014 09:26:29 AM
-- Design Name: 
-- Module Name: ublaze_sim - Behavioral
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
use IEEE.NUMERIC_STD.all;

use work.tel2000.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ublaze_sim is
port(
 AXIL_MOSI : out t_axi4_lite_mosi;
 AXIL_MISO : in t_axi4_lite_miso;
 CLK100 : out STD_LOGIC;
 CLK160 : out STD_LOGIC;
 Rstn : out std_logic;
 EXP_Ctrl_Busy : out STD_LOGIC;
 FPA_Exp_Info : in exp_info_type;
 Feedback_FPA_Info : out img_info_type
 );
end ublaze_sim;

architecture Behavioral of ublaze_sim is

signal TestReadValue : std_logic_vector(31 downto 0);
signal rstn_i : std_logic := '0';
signal clk100_i : std_logic;
signal clk160_i : std_logic;

signal exp_time : unsigned(31 downto 0);
signal exp_indx : std_logic;
signal exp_dval : std_logic;

signal busy_vector : unsigned(31 downto 0) := x"00000000";
signal feedback_fpa_info_i : img_info_type;

begin

--! Reset Generation
rstn_i <= '1' after 500 ns;
Rstn <= rstn_i;

   CLK100_GEN : process
   begin          
      clk100_i <= '1';
   wait for 5 ns;
      clk100_i <= '0'; 
   wait for 5 ns;
   end process;    
   CLK100 <= clk100_i;

   CLK160_GEN : process
   begin          
      clk160_i <= '1';
   wait for 3.125 ns;
      clk160_i <= '0'; 
   wait for 3.125 ns;
   end process; 

   CLK160 <= clk160_i;
   EXP_Ctrl_Busy <= busy_vector(31);
   
EXPCTRL_SIM : process (clk100_i)
    begin
        if rising_edge(clk100_i) then
			if FPA_Exp_Info.exp_dval = '1' and busy_vector(31) = '0' then
				busy_vector <= x"FFFFFFFE";
				exp_time <= FPA_Exp_Info.exp_time;
				exp_indx <= FPA_Exp_Info.exp_indx;
				exp_dval <= FPA_Exp_Info.exp_dval;
			else
				busy_vector <= shift_left(unsigned(busy_vector),1);
			end if;
		end if;
end process EXPCTRL_SIM;

Feedback_FPA_Info <= feedback_fpa_info_i;

FEEDBACK_FPA : process (clk100_i)
    begin
        if rising_edge(clk100_i) then
			if (rstn_i = '0') then
				feedback_fpa_info_i.exp_feedbk <= '0';
				feedback_fpa_info_i.exp_info.exp_dval <= '0';
				feedback_fpa_info_i.frame_id <= (others => '0');
				feedback_fpa_info_i.exp_info.exp_time <= (others => '0');
				feedback_fpa_info_i.exp_info.exp_indx	<= '0';
			else
				if busy_vector(1) = '1' and feedback_fpa_info_i.exp_feedbk <= '0' then
					feedback_fpa_info_i.exp_feedbk <= '1';
					feedback_fpa_info_i.exp_info.exp_dval <= '1';
					feedback_fpa_info_i.frame_id <= feedback_fpa_info_i.frame_id + 1;
					feedback_fpa_info_i.exp_info.exp_time <= exp_time;
					feedback_fpa_info_i.exp_info.exp_indx <= exp_indx;
				elsif busy_vector(31) = '0' and feedback_fpa_info_i.exp_feedbk <= '1' then
					feedback_fpa_info_i.exp_feedbk <= '0';
					feedback_fpa_info_i.exp_info.exp_dval <= '0';
				end if;	
			end if;
				
		end if;
end process FEEDBACK_FPA;

ublaze_stim: process is
   begin
      AXIL_MOSI.awaddr <= (others => '0');
      AXIL_MOSI.awprot <= (others => '0');
      AXIL_MOSI.wdata <= (others => '0');
      AXIL_MOSI.wstrb <= (others => '0');
      AXIL_MOSI.araddr <= (others => '0');
      AXIL_MOSI.arprot <= (others => '0');

      AXIL_MOSI.awvalid <= '0';
      AXIL_MOSI.wvalid <= '0';
      AXIL_MOSI.bready <= '0';
      AXIL_MOSI.arvalid <= '0';
      AXIL_MOSI.rready <= '0';
	  
	  
      wait until rstn_i = '1';

      wait until rising_edge(clk100_i);
   
  	  --Write AXI config   FULL
      for j in 0 to 64 loop
	      write_axi_lite (clk100_i, std_logic_vector(to_unsigned(j*4,32)), x"E4E4E4E4", AXIL_MISO,  AXIL_MOSI);
	      wait until rising_edge(clk100_i);
      end loop;
      
	  write_axi_lite (clk100_i, x"00000400", x"11111111", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);

	  write_axi_lite (clk100_i, x"00000404", x"22222222", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);
	  
	  write_axi_lite (clk100_i, x"00000408", x"33333333", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);

	  write_axi_lite (clk100_i, x"0000040C", x"44444444", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);

	  wait for 100 ns;
	  write_axi_lite (clk100_i, x"00000410", x"00000001", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);
	  
	  wait for 5.127 ms;
	  write_axi_lite (clk100_i, x"00000410", x"00000000", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);
	  
	  wait for 1 ms;
	  write_axi_lite (clk100_i, x"00000410", x"00000001", AXIL_MISO,  AXIL_MOSI);
      wait until rising_edge(clk100_i);
	  
	  report "FCR written"; 

      report "END OF SIMULATION" 
      severity error;
end process ublaze_stim;

 
end Behavioral;
