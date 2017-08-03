library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity hawkA_intf_testbench_tb is
end hawkA_intf_testbench_tb;

architecture TB_ARCHITECTURE of hawkA_intf_testbench_tb is
   -- Component declaration of the tested unit
   component hawkA_intf_testbench
      port(
         ACQ_TRIG : in STD_LOGIC;
         ARESET : in STD_LOGIC;
         CLK_100M : in STD_LOGIC;
         --CLK_80M : in STD_LOGIC;
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
         QUAD2_CLK : out STD_LOGIC);
   end component;
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant CLK_80M_PERIOD          : time := 12.5 ns;
   constant ACQ_TRIG_PERIOD         : time := 700 us;
   constant DOUT_CLK_PERIOD         : time := 6.25 ns;
   constant PAUSE_SIZE              : integer := 8;
   constant TAP_NUM                 : integer := 4;
   
   
   constant user_xsize : natural := 640;
   constant user_ysize : natural := 512;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_TRIG : STD_LOGIC := '0';
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal CLK_80M : STD_LOGIC  := '0';
   signal DOUT_CLK : STD_LOGIC := '0';
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
   --signal QUAD3_CLK : STD_LOGIC;
   --signal QUAD4_CLK : STD_LOGIC;
   signal fpa_softw_stat_i               : fpa_firmw_stat_type;
   signal user_cfg_i                     : fpa_intf_cfg_type;
   signal add                            : unsigned(31 downto 0) := (others => '0');
   signal status                         : std_logic_vector(31 downto 0);
   signal ACQ_TRIG_i                     : std_logic := '0';
   signal ACQ_TRIG_Last                  : std_logic := '0';
   
   signal comn_fpa_diag_mode             : unsigned(31 downto 0);
   signal comn_fpa_diag_type             : unsigned(31 downto 0);
   signal comn_fpa_pwr_on                : unsigned(31 downto 0);
   signal comn_fpa_trig_ctrl_mode        : unsigned(31 downto 0);
   signal comn_fpa_acq_trig_ctrl_dly     : unsigned(31 downto 0);
   signal comn_fpa_acq_trig_period_min   : unsigned(31 downto 0);
   signal comn_fpa_xtra_trig_ctrl_dly    : unsigned(31 downto 0);
   signal comn_fpa_xtra_trig_period_min  : unsigned(31 downto 0);                                     
   signal xstart                         : unsigned(31 downto 0);
   signal ystart                         : unsigned(31 downto 0);
   signal xsize                          : unsigned(31 downto 0);
   signal ysize                          : unsigned(31 downto 0);
   signal gain                           : unsigned(31 downto 0);
   signal invert                         : unsigned(31 downto 0);
   signal revert                         : unsigned(31 downto 0);
   signal cbit_en                        : unsigned(31 downto 0);
   signal dig_code                       : unsigned(31 downto 0);
   signal jpos                           : unsigned(31 downto 0);
   signal kpos                           : unsigned(31 downto 0);
   signal lpos                           : unsigned(31 downto 0);
   signal mpos                           : unsigned(31 downto 0);
   signal wdr_len                        : unsigned(31 downto 0);
   signal full_window                    : unsigned(31 downto 0);
   signal real_mode_active_pixel_dly     : unsigned(31 downto 0);
   signal adc_quad2_en                   : unsigned(31 downto 0);
   signal chn_diversity_en               : unsigned(31 downto 0);           
   signal line_period_pclk               : unsigned(31 downto 0);
   signal readout_pclk_cnt_max           : unsigned(31 downto 0);
   signal active_line_start_num          : unsigned(31 downto 0);
   signal active_line_end_num            : unsigned(31 downto 0);
   signal pix_samp_num_per_ch            : unsigned(31 downto 0);
   signal sof_posf_pclk                  : unsigned(31 downto 0);
   signal eof_posf_pclk                  : unsigned(31 downto 0);
   signal sol_posl_pclk                  : unsigned(31 downto 0);
   signal eol_posl_pclk                  : unsigned(31 downto 0);
   signal eol_posl_pclk_p1               : unsigned(31 downto 0);      
   signal good_samp_first_pos_per_ch     : unsigned(31 downto 0);
   signal good_samp_last_pos_per_ch      : unsigned(31 downto 0);
   signal hgood_samp_sum_num             : unsigned(31 downto 0);
   signal hgood_samp_mean_numerator      : unsigned(31 downto 0);
   signal vgood_samp_sum_num             : unsigned(31 downto 0);
   signal vgood_samp_mean_numerator      : unsigned(31 downto 0);  
   signal xsize_div_tapnum               : unsigned(31 downto 0);
   signal vdac_value_1                   : unsigned(31 downto 0);
   signal vdac_value_2                   : unsigned(31 downto 0); 
   signal vdac_value_3                   : unsigned(31 downto 0); 
   signal vdac_value_4                   : unsigned(31 downto 0); 
   signal vdac_value_5                   : unsigned(31 downto 0); 
   signal vdac_value_6                   : unsigned(31 downto 0); 
   signal vdac_value_7                   : unsigned(31 downto 0); 
   signal vdac_value_8                   : unsigned(31 downto 0); 
   signal adc_clk_phase                  : unsigned(31 downto 0);
   signal comn_fpa_stretch_acq_trig      : unsigned(31 downto 0);
   
   signal user_cfg_vector                : unsigned(53*32-1 downto 0);
   
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
   U4: process(ACQ_TRIG_i)
   begin
      ACQ_TRIG_i <= not ACQ_TRIG_i after ACQ_TRIG_PERIOD/2; 
   end process;
   ACQ_TRIG_last <= transport ACQ_TRIG_i after 1 us;
   ACQ_TRIG <= ACQ_TRIG_i and not ACQ_TRIG_last;
   
   
   XTRA_TRIG <= '0';
   
   DOUT_MISO.TREADY <= '1';
   
   
   process
   begin
      FPA_EXP_INFO.exp_time <= to_unsigned(100, FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_indx <= x"05";
      --FPA_EXP_INFO.exp_dval <='0';
      --wait for 300 ns;
      --FPA_EXP_INFO.exp_time <= to_unsigned(10,FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_dval <= '1'; 
      
      wait;
   end process;
   
   
   
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   comn_fpa_diag_mode              <=  (others =>'0');                                               
   comn_fpa_diag_type              <=  resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
   comn_fpa_pwr_on                 <=  (others =>'1');                                               
   comn_fpa_trig_ctrl_mode         <=  resize(unsigned(MODE_INT_END_TO_TRIG_START),32);          
   comn_fpa_acq_trig_ctrl_dly      <=  to_unsigned(0, comn_fpa_acq_trig_ctrl_dly'length);            
   comn_fpa_acq_trig_period_min    <=  to_unsigned(100, comn_fpa_acq_trig_period_min'length);        
   comn_fpa_xtra_trig_ctrl_dly     <=  to_unsigned(600, comn_fpa_xtra_trig_ctrl_dly'length);         
   comn_fpa_xtra_trig_period_min   <=  to_unsigned(100, comn_fpa_xtra_trig_period_min'length);       
   
   
   xstart                          <= to_unsigned(0, 32);  
   ystart                          <= to_unsigned(0, 32);  
   xsize                           <= to_unsigned(user_xsize, 32);  
   ysize                           <= to_unsigned(user_ysize, 32);  
   gain                            <= (others => '0');
   invert                          <= (others => '0');
   revert                          <= (others => '0');
   cbit_en                         <= (others => '0');
   dig_code                        <= (others => '0');
   jpos                            <= to_unsigned(1185, 32);  
   kpos                            <= to_unsigned(1184, 32);  
   lpos                            <= to_unsigned(513, 32);  
   mpos                            <= to_unsigned(512, 32);  
   wdr_len                         <= to_unsigned(1344, 32); 
   full_window                     <= (others => '0');
   real_mode_active_pixel_dly      <= to_unsigned(6, 32);
   adc_quad2_en                    <= (others => '1');
   chn_diversity_en                <= (others => '0'); 
   
   line_period_pclk                <= to_unsigned(user_xsize/TAP_NUM + PAUSE_SIZE, 32);
   readout_pclk_cnt_max            <= to_unsigned((user_xsize/TAP_NUM + PAUSE_SIZE)*(user_ysize + 1) + 3, 32);   
   active_line_start_num           <= to_unsigned(1, 32);
   active_line_end_num             <= active_line_start_num + to_unsigned(user_ysize - 1, 32);
   pix_samp_num_per_ch             <= to_unsigned(1, 32);
   sof_posf_pclk                   <= to_unsigned(PAUSE_SIZE, 32);
   eof_posf_pclk                   <= to_unsigned(user_ysize * (user_xsize/TAP_NUM + PAUSE_SIZE) - 1, 32);
   sol_posl_pclk                   <= to_unsigned(PAUSE_SIZE, 32);
   eol_posl_pclk                   <= line_period_pclk - 1;
   eol_posl_pclk_p1                <= eol_posl_pclk + 1;
   
   good_samp_first_pos_per_ch      <= to_unsigned(1, 32);
   good_samp_last_pos_per_ch       <= to_unsigned(1, 32);   
   hgood_samp_sum_num              <= to_unsigned(1, 32); 
   hgood_samp_mean_numerator       <= to_unsigned(2**22/1, 32);
   vgood_samp_sum_num              <= 1 + chn_diversity_en;
   vgood_samp_mean_numerator       <= to_unsigned(2**22/1, 32);
   
   xsize_div_tapnum                <=  to_unsigned(user_xsize/TAP_NUM, 32);
   vdac_value_1                    <=  (others => '0'); 
   vdac_value_2                    <=  (others => '0'); 
   vdac_value_3                    <=  (others => '0'); 
   vdac_value_4                    <=  (others => '0'); 
   vdac_value_5                    <=  (others => '0'); 
   vdac_value_6                    <=  (others => '0'); 
   vdac_value_7                    <=  (others => '0'); 
   vdac_value_8                    <=  (others => '0'); 
   adc_clk_phase                   <=  (others => '0'); 
   comn_fpa_stretch_acq_trig       <=  (others => '0'); 
   
   
   
   user_cfg_vector <=  comn_fpa_diag_mode              
   & comn_fpa_diag_type              
   & comn_fpa_pwr_on                 
   & comn_fpa_trig_ctrl_mode         
   & comn_fpa_acq_trig_ctrl_dly      
   & comn_fpa_acq_trig_period_min    
   & comn_fpa_xtra_trig_ctrl_dly     
   & comn_fpa_xtra_trig_period_min   
   
   & xstart                              
   & ystart                              
   & xsize                               
   & ysize                               
   & gain                                
   & invert                              
   & revert                              
   & cbit_en                             
   & dig_code                            
   & jpos                                
   & kpos                                
   & lpos                                
   & mpos                                
   & wdr_len                             
   & full_window                         
   & real_mode_active_pixel_dly          
   & adc_quad2_en                        
   & chn_diversity_en                    
   & readout_pclk_cnt_max                
   & line_period_pclk                    
   & active_line_start_num               
   & active_line_end_num
   & pix_samp_num_per_ch
   & sof_posf_pclk                       
   & eof_posf_pclk                       
   & sol_posl_pclk                       
   & eol_posl_pclk                       
   & eol_posl_pclk_p1                    
   & hgood_samp_sum_num                  
   & hgood_samp_mean_numerator           
   & vgood_samp_sum_num                  
   & vgood_samp_mean_numerator           
   & good_samp_first_pos_per_ch          
   & good_samp_last_pos_per_ch           
   & xsize_div_tapnum                                        
   & vdac_value_1                       
   & vdac_value_2
   & vdac_value_3 
   & vdac_value_4                       
   & vdac_value_5                       
   & vdac_value_6                       
   & vdac_value_7                       
   & vdac_value_8                        
   & adc_clk_phase                       
   & comn_fpa_stretch_acq_trig;      
   
   
   fpa_softw_stat_i.fpa_roic <= FPA_ROIC_HAWK;
   fpa_softw_stat_i.fpa_output <= OUTPUT_ANALOG;    
   fpa_softw_stat_i.fpa_input <= LVTTL50;
   
   -- envoyer cfg
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
      
      for ii in 0 to 52 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := user_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      
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
   UUT : hawkA_intf_testbench
   port map (
      ACQ_TRIG => ACQ_TRIG,
      ARESET => ARESET,
      CLK_100M => CLK_100M,
      --CLK_80M => CLK_80M,
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
      QUAD2_CLK => QUAD2_CLK
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_hawkA_intf_testbench of hawkA_intf_testbench_tb is
   for TB_ARCHITECTURE
      for UUT : hawkA_intf_testbench
         use entity work.hawkA_intf_testbench(sch);
      end for;
   end for;
end TESTBENCH_FOR_hawkA_intf_testbench;

