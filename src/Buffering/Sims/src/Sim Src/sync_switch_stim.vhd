-------------------------------------------------------------------------------
--
-- Title       : Buffering TB STIM
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        :
-- Generated   : 
-- From        : 
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description :  Stim file for Buffering simulation
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity sync_switch_tb_stim is
   port(
      RX_MOSI : in t_axi4_stream_mosi32;
      RX_MISO : in t_axi4_stream_miso;
      
      STALL : out std_logic;
      
      SEL1 : out std_logic_vector(1 downto 0); 
      
      DONE : out std_logic;
      
      CLK160   : out STD_LOGIC;
      CLK100   : out STD_LOGIC;
      ARESETN   : out STD_LOGIC
      );
end sync_switch_tb_stim;



architecture rtl of sync_switch_tb_stim is
   
   -- CLK and RESET
   signal clk160_o : std_logic := '0';
   signal clk100_o : std_logic := '0';
   signal rstn_i : std_logic := '0';
   
   signal ReadValue : std_logic_vector(31 downto 0) := (others => '0');
   signal read_value : std_logic_vector(31 downto 0) := (others => '0');
   signal write_value : std_logic_vector(31 downto 0) := (others => '0');
   signal write_value_u : unsigned(31 downto 0) := (others => '0');
   
   signal sel1_s : unsigned(1 downto 0) := (others => '0');
   
   constant NB_OF_FRAME : integer := 10;
   constant IMG_WIDTH  :integer := 320;
   constant IMG_HEIGTH  :integer := 256;
   
   -- CLK and RESET
   constant clk160_per : time := 6.25 ns;
   constant clk100_per : time := 10 ns;
   
   component axis32_img_boundaries is
      port(
         RX_MOSI  : in  t_axi4_stream_mosi32;
         RX_MISO  : in t_axi4_stream_miso;
         
         SOF      : out std_logic; -- pulse at the beginning of a frame
         EOF      : out std_logic; -- indicates if a frame is done (held at the end of the image)
         
         ARESETN  : in  std_logic;
         CLK      : in  std_logic     
         );
   end component;
   
   signal img_cnt : unsigned(31 downto 0) := (others => '0');
   signal eof_i, sof_i : std_logic;
   
begin
   -- Assign clock
   CLK160 <= clk160_o;
   CLK100 <= clk100_o;
   ARESETN <= rstn_i;
   
   --! Clock 160MHz generation                   
   CLK160_GEN: process(clk160_o)
   begin
      clk160_o <= not clk160_o after clk160_per/2;                          
   end process;
   
   CLK100_GEN: process(clk100_o)
   begin
      clk100_o <= not clk100_o after clk100_per/2;                          
   end process;
   
   --! Reset Generation
   RST_GEN : process
   begin          
      rstn_i <= '0';
      wait for 5 us;
      rstn_i <= '1'; 
      wait;
   end process;
   
   
   MB_PROCESS : process 
      variable j : integer := 0;
      variable nb_seq_mem : unsigned (31 downto 0) := to_unsigned(0,32) ;
      
   begin
      
      --sel1_s <= "00";
      wait until rstn_i = '1';
      wait for 1 us;
      
      loop
         wait for 17 us;
         wait until rising_edge(clk100_o);
         --sel1_s <= (sel1_s + 1) mod 2;
         
         wait for 5 ns; 
         wait until rising_edge(clk100_o);
         
      end loop;   
   end process MB_PROCESS;
   
   SEL1 <= std_logic_vector(sel1_s);
   
   detect_frame_done1 : axis32_img_boundaries
   port map (
      RX_MOSI => RX_MOSI, 
      RX_MISO => RX_MISO,
      EOF => eof_i,
      SOF => sof_i,
      ARESETN => ARESETN,
      CLK => clk160_o);
   
   cnt_img : process(clk160_o) 
      variable started : std_logic := '0';
   begin
      if rising_edge(clk160_o) then
         if rstn_i = '0' then
            img_cnt <= (others => '0');
            DONE <= '0';
            started := '0';
            sel1_s <= "11";
         else
            if sof_i = '1' then
               started := '1';
            end if;
            
            if started = '1' and eof_i = '1' then
               img_cnt <= img_cnt + 1;
            end if;
            
            if img_cnt >= 19 then
               sel1_s <= "01";
            else
               sel1_s <= "00";
            end if;
            
            if img_cnt >= 120 then
               DONE <= '1';
            else
               DONE <= '0';
            end if;
         end if;
      end if;
   end process;
   
   
   STALL_PROCESS : process
   begin
      STALL <= '1';
      wait for 7 us;
      STALL <= '0';
      report "START OF LOOP";  
      while true loop
         wait for 2.5 us;
         STALL <= '1';
         wait for 50 ns;
         STALL <= '0';
      end loop;
      report "END OF LOOP";    
      wait;
   end process STALL_PROCESS;
   
end rtl;
