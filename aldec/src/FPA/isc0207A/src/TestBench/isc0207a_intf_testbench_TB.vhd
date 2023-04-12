library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;
use work.isc0207a_intf_testbench_pkg.all;

-- Add your library and packages declaration here ...

entity isc0207a_intf_testbench_tb is
end isc0207a_intf_testbench_tb;

architecture TB_ARCHITECTURE of isc0207a_intf_testbench_tb is
   -- Component declaration of the tested unit
   component isc0207a_intf_testbench
      port(
         ACQ_TRIG : in STD_LOGIC;
         ARESET : in STD_LOGIC;
         CLK_100M : in STD_LOGIC;
         DOUT_MISO : in t_axi4_stream_miso;
         FPA_EXP_INFO : in exp_info_type;
         HDER_MISO : in t_axi4_lite_miso;
         MB_CLK : in STD_LOGIC;
         MB_MOSI : in t_axi4_lite_mosi;
         XTRA_TRIG : in STD_LOGIC;
         ADC_SYNC_FLAG : out STD_LOGIC;
         DOUT_CLK : out STD_LOGIC;
         DOUT_MOSI : out t_axi4_stream_mosi128;
         ERR_FOUND : out STD_LOGIC;
         FPA_DIGIO1 : out STD_LOGIC;
         FPA_DIGIO10 : out STD_LOGIC;
         FPA_DIGIO2 : out STD_LOGIC;
         FPA_DIGIO3 : out STD_LOGIC;
         FPA_DIGIO4 : out STD_LOGIC;
         FPA_DIGIO5 : out STD_LOGIC;
         FPA_DIGIO6 : out STD_LOGIC;
         FPA_DIGIO7 : out STD_LOGIC;
         FPA_DIGIO8 : out STD_LOGIC;
         FPA_DIGIO9 : out STD_LOGIC;
         FPA_ON : out STD_LOGIC;
         HDER_MOSI : out t_axi4_lite_mosi;
         IMAGE_INFO : out img_info_type;
         MB_MISO : out t_axi4_lite_miso;
         QUAD1_CLK : out STD_LOGIC;
         QUAD2_CLK : out STD_LOGIC;
         QUAD3_CLK : out STD_LOGIC;
         QUAD4_CLK : out STD_LOGIC );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant ACQ_TRIG_PERIOD         : time := 700 us;
   
   constant DAC_CFG_BASE_ADD        : natural := to_integer(unsigned(x"D00"));
   constant DAC_CFG_VECTOR_SIZE     : natural := 8;
   
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_TRIG : STD_LOGIC := '0';
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal DOUT_CLK : STD_LOGIC := '0';
   signal DOUT_MISO : t_axi4_stream_miso;
   signal FPA_EXP_INFO : exp_info_type;
   signal HDER_MISO : t_axi4_lite_miso;
   signal MB_CLK : STD_LOGIC;
   signal MB_MOSI : t_axi4_lite_mosi;
   signal XTRA_TRIG : STD_LOGIC;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ADC_SYNC_FLAG : STD_LOGIC;
   signal DOUT_MOSI : t_axi4_stream_mosi128;
   signal ERR_FOUND : STD_LOGIC;
   signal FPA_DIGIO1 : STD_LOGIC;
   signal FPA_DIGIO10 : STD_LOGIC;
   signal FPA_DIGIO2 : STD_LOGIC;
   signal FPA_DIGIO3 : STD_LOGIC;
   signal FPA_DIGIO4 : STD_LOGIC;
   signal FPA_DIGIO5 : STD_LOGIC;
   signal FPA_DIGIO6 : STD_LOGIC;
   signal FPA_DIGIO7 : STD_LOGIC;
   signal FPA_DIGIO8 : STD_LOGIC;
   signal FPA_DIGIO9 : STD_LOGIC;
   signal FPA_ON : STD_LOGIC;
   signal HDER_MOSI : t_axi4_lite_mosi;
   signal IMAGE_INFO : img_info_type;
   signal MB_MISO : t_axi4_lite_miso;
   signal QUAD1_CLK : STD_LOGIC;
   signal QUAD2_CLK : STD_LOGIC;
   signal QUAD3_CLK : STD_LOGIC;
   signal QUAD4_CLK : STD_LOGIC;
   signal fpa_softw_stat_i               : fpa_firmw_stat_type;
   
   signal user_xsize1 : natural;
   signal user_ysize1 : natural;
   signal user_xsize2 : natural;
   signal user_ysize2 : natural;
   signal user_xsize3 : natural;
   signal user_ysize3 : natural;
   
   
   signal user_cfg_vector1              : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0);
   signal user_cfg_vector2              : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0);
   signal user_cfg_vector3              : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0);
   signal vdac_value_1                  : unsigned(31 downto  0);
   signal vdac_value_2                  : unsigned(31 downto  0);
   signal vdac_value_3                  : unsigned(31 downto  0);
   signal vdac_value_4                  : unsigned(31 downto  0);
   signal vdac_value_5                  : unsigned(31 downto  0);
   signal vdac_value_6                  : unsigned(31 downto  0);
   signal vdac_value_7                  : unsigned(31 downto  0);
   signal vdac_value_8                  : unsigned(31 downto  0);
   
   signal dac_cfg_vector                : unsigned(DAC_CFG_VECTOR_SIZE*32-1 downto 0);
   
   signal add                           : unsigned(31 downto 0) := (others => '0');
   signal status                        : std_logic_vector(31 downto 0);
   -- Add your code here _..
   
begin
   
   
   -- reset
   U0: process
   begin
      areset <= '1'; 
      wait for 250 ns;
      areset <= '0';
      wait;
   end process;
   
   -- clk
   U1: process(CLK_100M)
   begin
      CLK_100M <= not CLK_100M after CLK_100M_PERIOD/2; 
   end process;
   MB_CLK <= CLK_100M;
   
   -- clk
   U4: process(ACQ_TRIG)
   begin
      ACQ_TRIG <= not ACQ_TRIG after ACQ_TRIG_PERIOD/2; 
   end process;
   XTRA_TRIG <= '0';
   
   DOUT_MISO.TREADY <= '1';
   
   
   process
   begin
      FPA_EXP_INFO.exp_time <= to_unsigned(100, FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_indx <= x"05";
      FPA_EXP_INFO.exp_dval <= '1';
      wait for 3 ms;
      FPA_EXP_INFO.exp_dval <='0';
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_time <= to_unsigned(1000,FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_dval <= '1';
      wait;
   end process;
   
   
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   
   process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then        
         
         -- cfg usager
         user_xsize1 <= 320;
         user_ysize1 <= 256;
         user_cfg_vector1 <= to_intf_cfg('1', user_xsize1, user_ysize1, 1); 
         
         user_xsize2 <= 320;
         user_ysize2 <= 256;
         user_cfg_vector2 <= to_intf_cfg('0', user_xsize2, user_ysize2, 2); 
         
         user_xsize3 <= 64;
         user_ysize3 <= 64;
         user_cfg_vector3 <= to_intf_cfg('0', user_xsize3, user_ysize3, 3);
         
         --         user_xsize3 <= 320;
         --         user_ysize3 <= 256;
         --         user_cfg_vector3 <= to_intf_cfg('0', user_xsize3, user_ysize3, 3);
         
         -- dac       
         vdac_value_1               	<= to_unsigned(11630, 32); 
         vdac_value_2               	<= to_unsigned(11630, 32); 
         vdac_value_3               	<= to_unsigned(11630, 32);
         vdac_value_4               	<= to_unsigned(11630, 32); 
         vdac_value_5               	<= to_unsigned(11630, 32); 
         vdac_value_6               	<= to_unsigned(11630, 32); 
         vdac_value_7               	<= to_unsigned(11630, 32); 
         vdac_value_8               	<= to_unsigned(11630, 32); 
         
         -- fleg dac
         dac_cfg_vector <= vdac_value_1               
         & vdac_value_2                   
         & vdac_value_3                   
         & vdac_value_4                   
         & vdac_value_5                   
         & vdac_value_6                   
         & vdac_value_7                   
         & vdac_value_8;       
         
         --
         
      end if;
   end process;   
   
   fpa_softw_stat_i.fpa_roic <= FPA_ROIC_ISC0207;
   fpa_softw_stat_i.fpa_output <= OUTPUT_ANALOG;    
   fpa_softw_stat_i.fpa_input <= LVTTL50;
   
   ublaze_sim: process is
      
      variable start_pos : integer;
      variable end_pos   : integer;
      
   begin
      MB_MOSI.awaddr <= (others => '0');
      MB_MOSI.awprot <= (others => '0');
      MB_MOSI.wdata <= (others => '0');
      MB_MOSI.wstrb <= (others => '0');
      MB_MOSI.araddr <= (others => '0');
      MB_MOSI.arprot <= (others => '0');
      
      MB_MOSI.awvalid <= '0';
      MB_MOSI.wvalid <= '0';
      MB_MOSI.bready <= '0';
      MB_MOSI.arvalid <= '0';
      MB_MOSI.rready <= '0';
      
      wait until areset = '0'; 
      
      wait for 500 ns;
      
      wait until rising_edge(MB_CLK);
      write_axi_lite (MB_CLK, resize(X"AE0",32), resize('0'&fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, resize(X"AE4",32), resize('0'&fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, resize(X"AE8",32), resize('0'&fpa_softw_stat_i.fpa_input, 32), MB_MISO,  MB_MOSI);
      wait for 500 ns;
      
      for ii in 0 to DAC_CFG_VECTOR_SIZE-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := dac_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(DAC_CFG_BASE_ADD + 4*ii, 32)), std_logic_vector(dac_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;      
      
      
      for ii in 0 to USER_CFG_VECTOR_SIZE-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := user_cfg_vector1'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector1(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      
      read_axi_lite (MB_CLK, x"00000400", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      read_axi_lite (MB_CLK, x"00000404", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      read_axi_lite (MB_CLK, x"00000400", MB_MISO, MB_MOSI, status);
      --wait for 10 ns; 
      
      wait for 500 us;
      write_axi_lite (MB_CLK, x"00000AF0", std_logic_vector(to_unsigned(1, 32)), MB_MISO,  MB_MOSI);
      wait for 50 ns;
      write_axi_lite (MB_CLK, x"00000AF0", std_logic_vector(to_unsigned(0, 32)), MB_MISO,  MB_MOSI);
      wait for 50 ns;
      
      
      wait for 5 ms;
      
      for ii in 0 to USER_CFG_VECTOR_SIZE-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := user_cfg_vector2'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector2(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      
      wait for 5 ms;
      
      for ii in 0 to USER_CFG_VECTOR_SIZE-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := user_cfg_vector3'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector3(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;
      
      
      
      report "FCR written"; 
      
      report "END OF SIMULATION" 
      severity error;
   end process ublaze_sim;   
   
   -- Unit Under Test port map
   UUT : isc0207a_intf_testbench
   port map (
      ACQ_TRIG => ACQ_TRIG,
      ARESET => ARESET,
      CLK_100M => CLK_100M,
      DOUT_CLK => DOUT_CLK,
      DOUT_MISO => DOUT_MISO,
      FPA_EXP_INFO => FPA_EXP_INFO,
      HDER_MISO => HDER_MISO,
      MB_CLK => MB_CLK,
      MB_MOSI => MB_MOSI,
      XTRA_TRIG => XTRA_TRIG,
      ADC_SYNC_FLAG => ADC_SYNC_FLAG,
      DOUT_MOSI => DOUT_MOSI,
      ERR_FOUND => ERR_FOUND,
      FPA_DIGIO1 => FPA_DIGIO1,
      FPA_DIGIO10 => FPA_DIGIO10,
      FPA_DIGIO2 => FPA_DIGIO2,
      FPA_DIGIO3 => FPA_DIGIO3,
      FPA_DIGIO4 => FPA_DIGIO4,
      FPA_DIGIO5 => FPA_DIGIO5,
      FPA_DIGIO6 => FPA_DIGIO6,
      FPA_DIGIO7 => FPA_DIGIO7,
      FPA_DIGIO8 => FPA_DIGIO8,
      FPA_DIGIO9 => FPA_DIGIO9,
      FPA_ON => FPA_ON,
      HDER_MOSI => HDER_MOSI,
      IMAGE_INFO => IMAGE_INFO,
      MB_MISO => MB_MISO,
      QUAD1_CLK => QUAD1_CLK,
      QUAD2_CLK => QUAD2_CLK,
      QUAD3_CLK => QUAD3_CLK,
      QUAD4_CLK => QUAD4_CLK
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_isc0207a_intf_testbench of isc0207a_intf_testbench_tb is
   for TB_ARCHITECTURE
      for UUT : isc0207a_intf_testbench
         use entity work.isc0207a_intf_testbench(sch);
      end for;
   end for;
end TESTBENCH_FOR_isc0207a_intf_testbench;

