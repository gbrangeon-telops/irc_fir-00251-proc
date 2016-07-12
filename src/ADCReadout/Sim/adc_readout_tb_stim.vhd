-------------------------------------------------------------------------------
--
-- Title       : adc_readout_tb_stim
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Thu Jan 30 13:26:14 2014
-- From        : interface description file
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;                                             
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity adc_readout_tb_stim is
   port(
      CLK    : out STD_LOGIC;
      MBCLK  : out STD_LOGIC;
      ARESET : out STD_LOGIC;
      FPA_Img_Info : out img_info_type;
      R      : out std_logic_vector(31 downto 0);
      Q      : out std_logic_vector(31 downto 0);
      DVAL   : out std_logic;
      DATA   : out std_logic_vector(11 downto 0)
      );
end adc_readout_tb_stim;

architecture rtl of adc_readout_tb_stim is
   
   component AXIS_file_input_16
      generic(
         Signed_Data : boolean := false);
      port(                   
         FILENAME    : string(1 to 255);
         TX_MOSI     : out t_axi4_stream_mosi16;
         TX_MISO     : in  t_axi4_stream_miso;    
         STALL       : in STD_LOGIC; -- This is to introduce "stalling" or pause in the dataflow.
         RESET       : in std_logic; 
         CLK         : in STD_LOGIC
         );
   end component;
   
   -- CLK and RESET
   signal clk_o : std_logic := '0';
   signal clk1M_o : std_logic := '0';
   signal mb_clk_o : std_logic := '0';
   signal rst_i : std_logic := '0';
   
   signal data_mosi : t_axi4_stream_mosi16;
   signal data_miso : t_axi4_stream_miso;
   
   signal filename : string(1 to 255) := (others => ' ');
   
   signal int_i : std_logic;
   signal frame_id : unsigned(31 downto 0);
   
   signal stall_i : std_logic := '0';
   
   -- CLK and RESET
   constant CLK_per : time := 50 ns;
   constant MBCLK_per : time := 10 ns;
   constant CLK_SAMPLES_per : time := 1 us;
   
   constant CLK_PER_MSEC : integer := 100000;
   
begin
   
   CLK <= clk_o;
   MBCLK <= mb_clk_o;
   ARESET <= rst_i;
   
   CLK_GEN: process(clk_o)
   begin
      clk_o <= not clk_o after CLK_per/2;                          
   end process;
   
   CLK1M_GEN: process(clk1M_o)
   begin
      clk1M_o <= not clk1M_o after CLK_SAMPLES_per/2;                          
   end process;
   
   MBCLK_GEN: process
   begin
      wait for 2/3 * CLK_per;
      
      while true loop
         if mb_clk_o /= '1' then
            mb_clk_o <= '1';
         else
            mb_clk_o <= '0';
         end if;
         wait for MBCLK_per/2; 
      end loop;
   end process;
   
   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for 5 us;
      rst_i <= '0'; 
      wait;
   end process;
   
   filename(1 to 52) <= "D:\telops\FIR-00251-Proc\src\ADCReadout\Sim\data.dat";
   
   --data_input : AXIS_file_input_16
   --   port map(
   --      FILENAME => filename,
   --      TX_MOSI => data_mosi, 
   --      TX_MISO => data_miso,
   --      STALL => stall_i,    
   --      RESET => rst_i, 
   --      CLK => clk_o
   --      );
   --   
   --   process(clk_o)
   --      variable cnt : integer range 0 to 1024 := 0;
   --      variable stall_v : std_logic := '0';
   --   begin
   --      if rising_edge(clk_o) then
   --         if cnt = 0 then
   --            stall_v := '0';
   --         else
   --            stall_v := '1';
   --         end if;
   --         
   --         cnt := cnt + 1;
   --         if cnt = 20 then
   --            cnt := 0;
   --         end if;
   --         
   --         if data_mosi.TVALID = '1' then
   --            DVAL <= '1';
   --            DATA <= data_mosi.TDATA(15 downto 4);
   --         else
   --            DVAL <= '0';
   --            DATA <= (others => 'Z');
   --         end if;
   --         
   --         data_miso.TREADY <= not stall_v;
   --         stall_i <= stall_v;
   --      end if;
   --   end process;
   
   
   process(clk_o)
      variable cnt : integer range 0 to 1024 := 0;
      variable data_i : integer range 0 to 4095 := 4095;
   begin
      if rising_edge(clk_o) then
         if rst_i = '1' then
            DVAL <= '0';
            cnt := 0;
         else
            if cnt = 0 then
               DVAL <= '1';
               DATA <= std_logic_vector(to_signed(data_i, DATA'length));
               data_i := 4095;--data_i - 1;
            else
               DVAL <= '0';
            end if;
            
            cnt := cnt + 1;
            if cnt = 20 then
               cnt := 0;
            end if;
         end if;
      end if;
   end process;
   
   process(mb_clk_o)
      variable cnt : integer range 0 to 2**30 := 0;
   begin
      if rising_edge(mb_clk_o) then
         if rst_i = '1' then
            cnt := 21;
            int_i <= '0';
            frame_id <= (others => '0');
         else
            if cnt <= 20 then
               int_i <= '1';
            else
               int_i <= '0';
            end if;
            
            if cnt = 0 then
               frame_id <= frame_id + 1;
            end if;
            
            cnt := cnt + 1;
            if cnt = 1_000 then
               cnt := 0;
            end if;
         end if ;
      end if;
   end process;
   
   FPA_Img_Info.exp_feedbk <= int_i;
   FPA_Img_Info.frame_id <= frame_id;
   
   --DATA <= data_mosi.TDATA(15 downto 4);
   --DVAL <= data_mosi.TVALID;
   
   --R <= x"00000532"; -- decimal 1330 -> 0.324735
   --R <= x"FFFFFACE"; -- decimal -1330 -> -0.324735
   R <= x"00001000"; -- decimal 4096 -> 1.0
   Q <= x"00008000"; -- decimal 2048.0
   
end rtl;