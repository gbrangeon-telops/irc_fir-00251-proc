library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;
use work.BB1920D_intf_testbench_pkg.all;

-- Add your library and packages declaration here ...

entity BB1920D_intf_testbench_tb is
end BB1920D_intf_testbench_tb;

architecture TB_ARCHITECTURE of BB1920D_intf_testbench_tb is
   -- Component declaration of the tested unit
   component BB1920D_intf_testbench
      
      generic(
         G_FPA_TAP_NUMBER : integer := 4
         );
      
      port(
         ARESETN        : in STD_LOGIC;
         CLK_100M       : in STD_LOGIC;
         ACQ_TRIG       : in STD_LOGIC;
         XTRA_TRIG      : in STD_LOGIC;
         DET_SPARE_N0   : in STD_LOGIC;
         DET_SPARE_N1   : out STD_LOGIC;
         DET_SPARE_N2   : out STD_LOGIC;
         DET_SPARE_P0   : in STD_LOGIC;
         DET_SPARE_P1   : out STD_LOGIC;
         DET_SPARE_P2   : out STD_LOGIC;
         FPA_EXP_INFO   : in exp_info_type;
         HDER_MISO      : in t_axi4_lite_miso;
         MCLK_SOURCE    : in STD_LOGIC;
         SERDES_TRIG    : in STD_LOGIC;
         SER_TFG_N      : in STD_LOGIC;
         SER_TFG_P      : in STD_LOGIC;
         MB_MOSI        : in t_axi4_lite_mosi;
         DET_CC_N1      : out STD_LOGIC;
         DET_CC_N2      : out STD_LOGIC;
         DET_CC_N3      : out STD_LOGIC;
         DET_CC_N4      : out STD_LOGIC;
         DET_CC_P1      : out STD_LOGIC;
         DET_CC_P2      : out STD_LOGIC;
         DET_CC_P3      : out STD_LOGIC;
         DET_CC_P4      : out STD_LOGIC;
         DET_FPA_ON     : out STD_LOGIC;
         DOUT_MOSI      : out t_axi4_stream_mosi64;
         ERR_FOUND      : out STD_LOGIC;
         FSYNC_N        : out STD_LOGIC;
         FSYNC_P        : out STD_LOGIC;
         HDER_MOSI      : out t_axi4_lite_mosi;
         SER_TC_N       : out STD_LOGIC;
         SER_TC_P       : out STD_LOGIC;
         MB_MISO        : out t_axi4_lite_miso);
   end component;
   
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant CLK_85M_PERIOD          : time := 11.765 ns;
   constant ACQ_TRIG_PERIOD         : time := 100 us;
   constant DOUT_CLK_PERIOD         : time := 11.765 ns;
   constant ADC_CLK_PERIOD          : time := 100.0 ns;
   constant MCLK_SOURCE_PERIOD      : time := 14.3 ns;
   
   --  constant USER_FIRST_LINE_NUM : integer := 1;
   
   --   constant PAUSE_SIZE     : integer := 0;
   --   constant TAP_NUM        : integer := 16;  
   --   constant TRIG_PERIOD    : time := 100 us;
   
   
   --   constant C_ROIC_XSIZE1   : natural := MIN(C_USER_XSIZE1 + 64, 320);
   --   constant C_ROIC_YSIZE1   : natural := C_USER_YSIZE1;
   --   
   --   constant C_ROIC_XSIZE2   : natural := MIN(C_USER_XSIZE2 + 64, 320);
   --   constant C_ROIC_YSIZE2   : natural := C_USER_YSIZE2; 
   
   
   
   --   constant STRETCH_LINE_LENGTH_MCLK : natural := 1;   
   
   
   -- constant OP_CFG_BASE_ADD : natural := 3072;
   
   
   --   constant user_sol_posl_pclk : natural := ((C_ROIC_XSIZE1 - C_USER_XSIZE1)/2)/TAP_NUM + 1; 
   
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_TRIG      : STD_LOGIC := '0';
   signal ARESETN       : STD_LOGIC;
   signal CLK_100M      : STD_LOGIC := '0';
   signal CLK_85M       : STD_LOGIC  := '0';
   signal DOUT_CLK      : STD_LOGIC := '0';
   signal MCLK_SOURCE   : std_logic := '0';
   --signal DOUT_MISO : t_axi4_stream_miso;
   signal FPA_EXP_INFO : exp_info_type;
   signal HDER_MISO : t_axi4_lite_miso;
   signal MB_CLK : STD_LOGIC;
   signal MB_MOSI : t_axi4_lite_mosi;
   signal XTRA_TRIG : STD_LOGIC;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ADC_SYNC_FLAG : STD_LOGIC;
   --signal DOUT_MOSI : t_axi4_stream_mosi64;
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
   signal ADC_CLK_INT : STD_LOGIC := '0';   
   signal user_xsize1 : natural;
   signal user_ysize1 : natural;
   signal user_xsize2 : natural;
   signal user_ysize2 : natural;
   signal user_xsize3 : natural;
   signal user_ysize3 : natural;
   signal cnt         : integer := 0;
   
   
   signal user_cfg_vector1              : unsigned(QWORDS_NUM*32-1 downto 0);
   signal user_cfg_vector2              : unsigned(user_cfg_vector1'length-1 downto 0);
   signal user_cfg_vector3              : unsigned(user_cfg_vector1'length-1 downto 0);
   signal vdac_value_1                  : unsigned(31 downto  0);
   signal vdac_value_2                  : unsigned(31 downto  0);
   signal vdac_value_3                  : unsigned(31 downto  0);
   signal vdac_value_4                  : unsigned(31 downto  0);
   signal vdac_value_5                  : unsigned(31 downto  0);
   signal vdac_value_6                  : unsigned(31 downto  0);
   signal vdac_value_7                  : unsigned(31 downto  0);
   signal vdac_value_8                  : unsigned(31 downto  0);
   
   signal dac_cfg_vector                : unsigned(8*32-1 downto 0);
   
   signal add                           : unsigned(31 downto 0) := (others => '0');
   signal status                        : std_logic_vector(31 downto 0);
   -- Add your code here _..
   
begin
   
   
   -- reset
   U0: process
   begin
      ARESETN <= '0'; 
      wait for 350 ns;
      ARESETN <= '1';
      wait;
   end process;
   
   -- clk
   U1a: process(CLK_100M)
   begin
      CLK_100M <= not CLK_100M after CLK_100M_PERIOD/2; 
   end process;
   MB_CLK <= CLK_100M;
   
   -- clk
   U1b: process(MCLK_SOURCE)
   begin
      MCLK_SOURCE <= not MCLK_SOURCE after MCLK_SOURCE_PERIOD/2; 
   end process;
   
   -- clk
   U2: process(CLK_85M)
   begin
      CLK_85M <= not CLK_85M after CLK_85M_PERIOD/2; 
   end process;
   
   -- clk
   U3: process(DOUT_CLK)
   begin
      DOUT_CLK <= not DOUT_CLK after DOUT_CLK_PERIOD/2; 
   end process;
   
   UADC: process(ADC_CLK_INT)
   begin
      ADC_CLK_INT <= not ADC_CLK_INT after ADC_CLK_PERIOD/2; 
   end process;
   
   -- clk
   U4: process(ACQ_TRIG)
   begin
      ACQ_TRIG <= '1'; 
   end process;
   XTRA_TRIG <= '0';
   
   -- DOUT_MISO.TREADY <= '1';
   
   
   process(CLK_100M)
   begin
      if rising_edge(CLK_100M) then
         FPA_EXP_INFO.exp_time <= to_unsigned(100, FPA_EXP_INFO.exp_time'length);
         FPA_EXP_INFO.exp_indx <= x"05";
         
         
         cnt <= cnt + 1;
         
         case cnt is
            
            when 0 => 
               FPA_EXP_INFO.exp_dval <= '0';
            
            when 200 => 
               FPA_EXP_INFO.exp_dval <= '1';
            
            when 202 =>
               FPA_EXP_INFO.exp_dval <= '0';
            
            when 700 => 
               FPA_EXP_INFO.exp_dval <= '1';
            
            when 702 =>
               FPA_EXP_INFO.exp_dval <= '0';
               cnt <= 702;
            
            when others =>
            
         end case;   
         
      end if;
      
   end process;
   
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   
   process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         
         fpa_softw_stat_i.fpa_roic     <= FPA_ROIC_BLACKBIRD1920;
         fpa_softw_stat_i.fpa_output   <= OUTPUT_DIGITAL;    
         fpa_softw_stat_i.fpa_input    <= LVDS25;        
         
         -- cfg usager
         user_xsize1 <= 128;
         user_ysize1 <= 64;
         user_cfg_vector1 <= to_intf_cfg('1', user_xsize1, user_ysize1, 1); 
         
         user_xsize2 <= 128;
         user_ysize2 <= 64;
         user_cfg_vector2 <= to_intf_cfg('0', user_xsize2, user_ysize2, 2);
         
         user_xsize3 <= 64;
         user_ysize3 <= 64;
         user_cfg_vector3 <= to_intf_cfg('0', user_xsize3, user_ysize3, 3);
         
         -- dac       
         vdac_value_1               	<= to_unsigned(0, 32); 
         vdac_value_2               	<= to_unsigned(0, 32); 
         vdac_value_3               	<= to_unsigned(0, 32);
         vdac_value_4               	<= to_unsigned(0, 32); 
         vdac_value_5               	<= to_unsigned(0, 32); 
         vdac_value_6               	<= to_unsigned(0, 32); 
         vdac_value_7               	<= to_unsigned(0, 32); 
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
      
      wait until ARESETN = '1'; 
      
      wait for 500 ns; 
      --      write_axi_lite (MB_CLK, resize(X"AE0",32), resize("00", 32), MB_MISO,  MB_MOSI); -- pour faire semblant d'envoyer une cfg serielle
      --      wait for 30 ns;      
      
      write_axi_lite (MB_CLK, resize(X"AE0",32), resize('0'&fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, resize(X"AE4",32), resize('0'&fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, resize(X"AE8",32), resize('0'&fpa_softw_stat_i.fpa_input, 32), MB_MISO,  MB_MOSI);
      wait for 500 ns;
      
      -- la cfg des dacs fait office ici de cfg serielle operationnelle
      for ii in 0 to 8-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := dac_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(AW_SERIAL_OP_CMD_RAM_ADD + 4*ii, 32)), std_logic_vector(dac_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;      
      
      
      for ii in 0 to QWORDS_NUM-1 loop 
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
      
      wait for 2 ms;
      
      for ii in 0 to QWORDS_NUM-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := user_cfg_vector2'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector2(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      --      
      wait for 2 ms;
      --      
      for ii in 0 to QWORDS_NUM-1 loop 
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
   UUT : BB1920D_intf_testbench
   
   generic map (
      G_FPA_TAP_NUMBER   => TAP_NUM
      )
   
   port map (
      ARESETN              =>     ARESETN,        
      CLK_100M             =>     CLK_100M,
      ACQ_TRIG             =>     ACQ_TRIG,
      XTRA_TRIG            =>     XTRA_TRIG,
      DET_SPARE_N0         =>     '0',   
      DET_SPARE_N1         =>     open,   
      DET_SPARE_N2         =>     open,   
      DET_SPARE_P0         =>     '1',   
      DET_SPARE_P1         =>     open,   
      DET_SPARE_P2         =>     open,   
      FPA_EXP_INFO         =>     FPA_EXP_INFO,   
      HDER_MISO            =>     HDER_MISO,      
      MCLK_SOURCE          =>     MCLK_SOURCE,    
      SERDES_TRIG          =>     '0',    
      SER_TFG_N            =>     '1',      
      SER_TFG_P            =>     '0',      
      MB_MOSI              =>     MB_MOSI,        
      DET_CC_N1            =>     open,      
      DET_CC_N2            =>     open,      
      DET_CC_N3            =>     open,      
      DET_CC_N4            =>     open,      
      DET_CC_P1            =>     open,      
      DET_CC_P2            =>     open,      
      DET_CC_P3            =>     open,      
      DET_CC_P4            =>     open,      
      DET_FPA_ON           =>     open,     
      DOUT_MOSI            =>     open,      
      ERR_FOUND            =>     ERR_FOUND,      
      FSYNC_N              =>     open,        
      FSYNC_P              =>     open,        
      HDER_MOSI            =>     open,      
      SER_TC_N             =>     open,       
      SER_TC_P             =>     open,       
      MB_MISO              =>     MB_MISO       
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_BB1920D_intf_testbench of BB1920D_intf_testbench_tb is
   for TB_ARCHITECTURE
      for UUT : BB1920D_intf_testbench
         use entity work.BB1920D_intf_testbench(sch);
      end for;
   end for;
end TESTBENCH_FOR_BB1920D_intf_testbench;



















