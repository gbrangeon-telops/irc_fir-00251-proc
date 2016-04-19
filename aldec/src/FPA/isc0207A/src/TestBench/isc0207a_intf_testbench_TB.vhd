library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

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
         CLK_80M : in STD_LOGIC;
         DOUT_CLK : in STD_LOGIC;
         DOUT_MISO : in t_axi4_stream_miso;
         FPA_EXP_INFO : in exp_info_type;
         HDER_MISO : in t_axi4_lite_miso;
         MB_CLK : in STD_LOGIC;
         MB_MOSI : in t_axi4_lite_mosi;
         XTRA_TRIG : in STD_LOGIC;
         ADC_SYNC_FLAG : out STD_LOGIC;
         DOUT_MOSI : out t_axi4_stream_mosi32;
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
   constant CLK_80M_PERIOD          : time := 12.5 ns;
   constant ACQ_TRIG_PERIOD         : time := 700 us;
   constant DOUT_CLK_PERIOD         : time := 6.25 ns;
   
   
   
   constant xsize : natural := 320;
   constant ysize : natural := 256;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_TRIG : STD_LOGIC := '0';
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal CLK_80M : STD_LOGIC := '0';
   signal DOUT_CLK : STD_LOGIC;
   signal DOUT_MISO : t_axi4_stream_miso;
   signal FPA_EXP_INFO : exp_info_type;
   signal HDER_MISO : t_axi4_lite_miso;
   signal MB_CLK : STD_LOGIC;
   signal MB_MOSI : t_axi4_lite_mosi;
   signal XTRA_TRIG : STD_LOGIC;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ADC_SYNC_FLAG : STD_LOGIC;
   signal DOUT_MOSI : t_axi4_stream_mosi32;
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
   signal user_cfg_i                     : fpa_intf_cfg_type;
   signal add                            : unsigned(31 downto 0) := (others => '0');
   signal status                         : std_logic_vector(31 downto 0);
   -- Add your code here ...
   
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
   U2: process(CLK_80M)
   begin
      CLK_80M <= not CLK_80M after CLK_80M_PERIOD/2; 
   end process;
   
   -- clk
   U3: process(DOUT_CLK)
   begin
      DOUT_CLK <= not DOUT_CLK after DOUT_CLK_PERIOD/2; 
   end process;
   
   -- clk
   U4: process(ACQ_TRIG)
   begin
      ACQ_TRIG <= not ACQ_TRIG after ACQ_TRIG_PERIOD/2; 
   end process;
   XTRA_TRIG <= '0';
   
   DOUT_MISO.TREADY <= '1';
   
   
   process
   begin
      FPA_EXP_INFO.exp_time <= to_unsigned(134, FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_indx <= x"05";
      FPA_EXP_INFO.exp_dval <='0';
      wait for 300 ns;
      FPA_EXP_INFO.exp_time <= to_unsigned(600,FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_dval <= '1';
      wait;
   end process;
   
   
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   user_cfg_i.COMN.FPA_DIAG_MODE <= '1';
   user_cfg_i.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_DEGR;
   user_cfg_i.COMN.fpa_pwr_on <= '1';
   user_cfg_i.COMN.fpa_trig_ctrl_mode <= MODE_READOUT_END_TO_TRIG_START;
   user_cfg_i.COMN.fpa_acq_trig_ctrl_dly <= to_unsigned(1, user_cfg_i.COMN.fpa_acq_trig_ctrl_dly'length);
   user_cfg_i.COMN.fpa_acq_trig_period_min <= to_unsigned(100, user_cfg_i.COMN.fpa_acq_trig_period_min'length);
   user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly <= to_unsigned(10, user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly'length);
   user_cfg_i.COMN.fpa_xtra_trig_period_min <= to_unsigned(100, user_cfg_i.COMN.fpa_xtra_trig_period_min'length);
   
   
   user_cfg_i.XSTART <= (others => '0');
   user_cfg_i.YSTART <= (others => '0');
   user_cfg_i.XSIZE  <= to_unsigned(xsize, user_cfg_i.XSIZE'length);
   user_cfg_i.YSIZE  <= to_unsigned(ysize, user_cfg_i.YSIZE'length);
   user_cfg_i.GAIN <= '0';  
   user_cfg_i.INVERT <= '0';
   user_cfg_i.REVERT <= '0';
   user_cfg_i.ONCHIP_BIN_256 <= '0';
   user_cfg_i.ONCHIP_BIN_128 <= '0';
   user_cfg_i.PIX_SAMP_NUM_PER_CH <= to_unsigned(4, user_cfg_i.PIX_SAMP_NUM_PER_CH'length);
   user_cfg_i.GOOD_SAMP_FIRST_POS_PER_CH <= to_unsigned(1, user_cfg_i.GOOD_SAMP_FIRST_POS_PER_CH'length); 
   user_cfg_i.GOOD_SAMP_LAST_POS_PER_CH <= to_unsigned(4, user_cfg_i.GOOD_SAMP_LAST_POS_PER_CH'length);
   user_cfg_i.GOOD_SAMP_SUM_NUM <= to_unsigned(4, user_cfg_i.GOOD_SAMP_SUM_NUM'length);
   user_cfg_i.GOOD_SAMP_MEAN_NUMERATOR <= to_unsigned(1, user_cfg_i.GOOD_SAMP_MEAN_NUMERATOR'length);
   user_cfg_i.GOOD_SAMP_MEAN_DIV_BIT_POS <= to_unsigned(2, user_cfg_i.GOOD_SAMP_MEAN_DIV_BIT_POS'length); -- log2(2) pour une division par 2
   user_cfg_i.YSIZE_DIV2_M1 <= to_unsigned(ysize/2-1, user_cfg_i.YSIZE_DIV2_M1'length); 
   user_cfg_i.IMG_SAMP_NUM <= to_unsigned(4*xsize*ysize, user_cfg_i.IMG_SAMP_NUM'length);
   user_cfg_i.IMG_SAMP_NUM_PER_CH <= to_unsigned(4*xsize*ysize/16, user_cfg_i.IMG_SAMP_NUM_PER_CH'length);
   user_cfg_i.FPA_ACTIVE_PIXEL_DLY <= to_unsigned(3, user_cfg_i.FPA_ACTIVE_PIXEL_DLY'length);  --
   user_cfg_i.DIAG_ACTIVE_PIXEL_DLY <= to_unsigned(2, user_cfg_i.DIAG_ACTIVE_PIXEL_DLY'length);  -- ajutsé via simulation
   user_cfg_i.SOF_SAMP_POS_START_PER_CH <= to_unsigned(1, user_cfg_i.SOF_SAMP_POS_START_PER_CH'length);
   user_cfg_i.SOF_SAMP_POS_END_PER_CH <= to_unsigned(4, user_cfg_i.SOF_SAMP_POS_END_PER_CH'length);
   user_cfg_i.EOF_SAMP_POS_START_PER_CH <= to_unsigned(4*xsize*ysize/16-4, user_cfg_i.EOF_SAMP_POS_START_PER_CH'length); 
   user_cfg_i.EOF_SAMP_POS_END_PER_CH <= to_unsigned(4*xsize*ysize/16, user_cfg_i.EOF_SAMP_POS_END_PER_CH'length); 
   user_cfg_i.DIAG_TIR <= to_unsigned(6, user_cfg_i.DIAG_TIR'length);
   user_cfg_i.XSIZE_DIV_TAPNUM <= to_unsigned(xsize/16, user_cfg_i.XSIZE_DIV_TAPNUM'length);
   
   user_cfg_i.readout_plus_delay <= to_unsigned(20*(6 + xsize*ysize/32), user_cfg_i.readout_plus_delay'length);
   user_cfg_i.tri_window_and_intmode_part <= to_unsigned(10, user_cfg_i.tri_window_and_intmode_part'length);
   user_cfg_i.int_time_offset <= to_unsigned(80, user_cfg_i.int_time_offset'length);
   user_cfg_i.tsh_min <= to_unsigned(780, user_cfg_i.tsh_min'length);
   user_cfg_i.tsh_min_minus_int_time_offset <= to_unsigned(700, user_cfg_i.tsh_min_minus_int_time_offset'length);
   
   
   fpa_softw_stat_i.fpa_roic <= FPA_ROIC_ISC0207;
   fpa_softw_stat_i.fpa_output <= OUTPUT_ANALOG;    
   fpa_softw_stat_i.fpa_input <= LVTTL50;
   
   ublaze_sim: process is
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
      
      wait until rising_edge(MB_CLK);
      
      write_axi_lite (MB_CLK, x"00000000", resize('0'&user_cfg_i.COMN.FPA_DIAG_MODE, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK,  x"00000004", resize('0'&user_cfg_i.COMN.FPA_DIAG_TYPE, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK,  x"00000008", resize('0'&user_cfg_i.COMN.fpa_pwr_on, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000000C", resize('0'&user_cfg_i.COMN.fpa_trig_ctrl_mode, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000010", std_logic_vector(resize(user_cfg_i.COMN.fpa_acq_trig_ctrl_dly, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000014", std_logic_vector(resize(user_cfg_i.COMN.fpa_acq_trig_period_min, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000018", std_logic_vector(resize(user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000001C", std_logic_vector(resize(user_cfg_i.COMN.fpa_xtra_trig_period_min, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;  
      
      write_axi_lite (MB_CLK, x"00000020", std_logic_vector(resize(user_cfg_i.XSTART, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000024", std_logic_vector(resize(user_cfg_i.YSTART, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000028", std_logic_vector(resize(user_cfg_i.XSIZE, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000002C", std_logic_vector(resize(user_cfg_i.YSIZE, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000030", resize('0'&user_cfg_i.GAIN, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000034", resize('0'&user_cfg_i.INVERT, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000038", resize('0'&user_cfg_i.REVERT, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000003C", resize('0'&user_cfg_i.ONCHIP_BIN_256, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000040", resize('0'&user_cfg_i.ONCHIP_BIN_128, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000044", std_logic_vector(resize(user_cfg_i.PIX_SAMP_NUM_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000048", std_logic_vector(resize(user_cfg_i.GOOD_SAMP_FIRST_POS_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000004C", std_logic_vector(resize(user_cfg_i.GOOD_SAMP_LAST_POS_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000050", std_logic_vector(resize(user_cfg_i.GOOD_SAMP_SUM_NUM, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000054", std_logic_vector(resize(user_cfg_i.GOOD_SAMP_MEAN_NUMERATOR, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000058", std_logic_vector(resize(user_cfg_i.GOOD_SAMP_MEAN_DIV_BIT_POS, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000005C", std_logic_vector(resize(user_cfg_i.YSIZE_DIV2_M1, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;  
      
      write_axi_lite (MB_CLK, x"00000060", std_logic_vector(resize(user_cfg_i.IMG_SAMP_NUM, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000064", std_logic_vector(resize(user_cfg_i.IMG_SAMP_NUM_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000068", std_logic_vector(resize(user_cfg_i.FPA_ACTIVE_PIXEL_DLY, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000006C", std_logic_vector(resize(user_cfg_i.DIAG_ACTIVE_PIXEL_DLY, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000070", std_logic_vector(resize(user_cfg_i.SOF_SAMP_POS_START_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000074", std_logic_vector(resize(user_cfg_i.SOF_SAMP_POS_END_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000078", std_logic_vector(resize(user_cfg_i.EOF_SAMP_POS_START_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000007C", std_logic_vector(resize(user_cfg_i.EOF_SAMP_POS_END_PER_CH, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000080", std_logic_vector(resize(user_cfg_i.DIAG_TIR, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000084", std_logic_vector(resize(user_cfg_i.XSIZE_DIV_TAPNUM, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000088", std_logic_vector(resize(user_cfg_i.readout_plus_delay, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"0000008C", std_logic_vector(resize(user_cfg_i.tri_window_and_intmode_part, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000090", std_logic_vector(resize(user_cfg_i.int_time_offset, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000094", std_logic_vector(resize(user_cfg_i.tsh_min, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000098", std_logic_vector(resize(user_cfg_i.tsh_min_minus_int_time_offset, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      
      write_axi_lite (MB_CLK, resize(X"E0",32), resize('0'&fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, resize(X"E4",32), resize('0'&fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, resize(X"E8",32), resize('0'&fpa_softw_stat_i.fpa_input, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      read_axi_lite (MB_CLK, x"00000400", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      read_axi_lite (MB_CLK, x"00000404", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      read_axi_lite (MB_CLK, x"00000400", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      
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
      CLK_80M => CLK_80M,
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

