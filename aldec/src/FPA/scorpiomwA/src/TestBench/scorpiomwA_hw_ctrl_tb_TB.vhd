library scorpiomwA;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity scorpiomwa_hw_ctrl_tb_tb is
end scorpiomwa_hw_ctrl_tb_tb;

architecture TB_ARCHITECTURE of scorpiomwa_hw_ctrl_tb_tb is
   -- Component declaration of the tested unit
   component scorpiomwa_hw_ctrl_tb
      port(
         
         ARESET         : in STD_LOGIC;
         CLK_80M        : in STD_LOGIC;
         FPA_DIGIO11    : in STD_LOGIC;
         FPA_DIGIO12    : in STD_LOGIC;
         FPA_EXP_INFO   : in exp_info_type;
         MB_CLK         : in STD_LOGIC;
         MB_MOSI        : in t_axi4_lite_mosi;
         
         ACQ_TRIG       : in STD_LOGIC;
         XTRA_TRIG      : in STD_LOGIC;
         READOUT        : in STD_LOGIC;
         
         ADC_DESERIALIZER_RST : out STD_LOGIC;
         ADC_SYNC_FLAG  : out STD_LOGIC;
         FPA_DIGIO1     : out STD_LOGIC;
         FPA_DIGIO10    : out STD_LOGIC;
         FPA_DIGIO2     : out STD_LOGIC;
         FPA_DIGIO3     : out STD_LOGIC;
         FPA_DIGIO4     : out STD_LOGIC;
         FPA_DIGIO5 : out STD_LOGIC;
         FPA_DIGIO6 : out STD_LOGIC;
         FPA_DIGIO7 : out STD_LOGIC;
         FPA_DIGIO8 : out STD_LOGIC;
         FPA_DIGIO9 : out STD_LOGIC;
         FPA_ON     : out STD_LOGIC;
         QUAD1_CLK  : out STD_LOGIC;
         QUAD2_CLK  : out STD_LOGIC;
         MB_MISO    : out t_axi4_lite_miso );
   end component;
   
   constant CLK_80M_PERIOD : time := 12.5 ns;
   constant MB_CLK_PERIOD  : time := 10.0 ns;
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant ACQ_TRIG_PERIOD         : time := 700 us;
   constant DOUT_CLK_PERIOD         : time := 6.25 ns;                    
   
   constant PAUSE_SIZE     : integer := 0;
   
   constant xsize : natural := 640;
   constant ysize : natural := 512; 
   constant TRIG_PERIOD : time := 100 us;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESET       : STD_LOGIC  := '1';
   signal CLK_80M      : STD_LOGIC  := '1';
   signal FPA_DIGIO11  : STD_LOGIC;
   signal FPA_DIGIO12  : STD_LOGIC;
   signal FPA_EXP_INFO : exp_info_type;
   signal MB_CLK       : STD_LOGIC:= '1';
   signal MB_MOSI      : t_axi4_lite_mosi;
   signal ACQ_TRIG     : STD_LOGIC;
   
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ADC_DESERIALIZER_RST : STD_LOGIC;
   signal ADC_SYNC_FLAG : STD_LOGIC;
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
   signal QUAD1_CLK : STD_LOGIC;
   signal QUAD2_CLK : STD_LOGIC;
   signal MB_MISO : t_axi4_lite_miso;
   signal trig : std_logic := '0';
   signal XTRA_TRIG : STD_LOGIC;
   
   signal fpa_softw_stat_i               : fpa_firmw_stat_type;
   signal user_cfg_i                     : fpa_intf_cfg_type;
   signal add                            : unsigned(31 downto 0) := (others => '0');
   signal status                         : std_logic_vector(31 downto 0);
   signal READOUT  : STD_LOGIC;
   
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
   U2: process(CLK_80M)
   begin
      CLK_80M <= not CLK_80M after CLK_80M_PERIOD/2; 
   end process;
   
   -- clk
   U3: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after MB_CLK_PERIOD/2; 
   end process; 
   
   U4: process(trig)
   begin
      trig <= not trig after TRIG_PERIOD/2; 
   end process;
   ACQ_TRIG <= trig;
   
   FPA_EXP_INFO.exp_time <=  to_unsigned(1, 32);
   FPA_EXP_INFO.exp_indx <=  x"05";
   FPA_EXP_INFO.exp_dval <= '1';
   XTRA_TRIG <= '0'; 
   READOUT <=  trig; 
   
   
   
   FPA_DIGIO11 <= '0';
   FPA_DIGIO12 <= '0';
   
   -- batir cfg
   
   --HDER_MISO.WREADY  <= '1';
   --HDER_MISO.AWREADY <= '1';
   
   user_cfg_i.COMN.FPA_DIAG_MODE <= '0';
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
   
   user_cfg_i.windcfg_part1  <= to_unsigned(1, user_cfg_i.windcfg_part1'length);
   user_cfg_i.windcfg_part2  <= to_unsigned(2, user_cfg_i.windcfg_part2'length);
   user_cfg_i.windcfg_part3  <= to_unsigned(3, user_cfg_i.windcfg_part3'length);
   user_cfg_i.windcfg_part4  <= to_unsigned(4, user_cfg_i.windcfg_part4'length);
   
   user_cfg_i.uprow_upcol    <= '0';
   user_cfg_i.sizea_sizeb    <= '0';
   user_cfg_i.itr            <= '1';
   user_cfg_i.gain           <= '0';
   
   user_cfg_i.gpol_code      <=  std_logic_vector(to_unsigned(2, user_cfg_i.gpol_code'length));
   
   
   user_cfg_i.real_mode_active_pixel_dly  <= to_unsigned(0, user_cfg_i.real_mode_active_pixel_dly'length);
   user_cfg_i.adc_quad2_en  <= '1';
   user_cfg_i.chn_diversity_en  <= '1'; 
   
   user_cfg_i.line_period_pclk <= to_unsigned((XSIZE/4 + PAUSE_SIZE), user_cfg_i.line_period_pclk'length);
   user_cfg_i.readout_pclk_cnt_max   <= to_unsigned((XSIZE/4 + PAUSE_SIZE)*(YSIZE + 1) + 1, user_cfg_i.readout_pclk_cnt_max'length);
   
   user_cfg_i.active_line_start_num            <= to_unsigned(1, user_cfg_i.active_line_start_num'length); 
   user_cfg_i.active_line_end_num         <= to_unsigned(YSIZE + to_integer(user_cfg_i.active_line_start_num) - 1, user_cfg_i.active_line_end_num'length);
   
   user_cfg_i.pix_samp_num_per_ch   <= to_unsigned(2, user_cfg_i.pix_samp_num_per_ch'length);
   
   user_cfg_i.sof_posf_pclk   <= resize(user_cfg_i.line_period_pclk*(to_integer(user_cfg_i.active_line_start_num) - 1) + 1, user_cfg_i.sof_posf_pclk'length);
   user_cfg_i.eof_posf_pclk   <= resize(user_cfg_i.active_line_end_num* user_cfg_i.line_period_pclk - PAUSE_SIZE*2, user_cfg_i.eof_posf_pclk'length);
   user_cfg_i.sol_posl_pclk   <= to_unsigned(1, user_cfg_i.sol_posl_pclk'length);
   user_cfg_i.eol_posl_pclk   <= to_unsigned((XSIZE/4), user_cfg_i.eol_posl_pclk'length);
   user_cfg_i.eol_posl_pclk_p1   <= user_cfg_i.eol_posl_pclk + 1;
   
   
   user_cfg_i.hgood_samp_sum_num          		<= to_unsigned(1, user_cfg_i.hgood_samp_sum_num'length); 
   user_cfg_i.hgood_samp_mean_numerator   		<= to_unsigned(2**21/2, user_cfg_i.hgood_samp_mean_numerator'length); 
   user_cfg_i.vgood_samp_sum_num          		<= to_unsigned(2, user_cfg_i.vgood_samp_sum_num'length); 
   user_cfg_i.vgood_samp_mean_numerator   		<= to_unsigned(2**21/2, user_cfg_i.vgood_samp_mean_numerator'length); 
   user_cfg_i.good_samp_first_pos_per_ch  		<= to_unsigned(2, user_cfg_i.good_samp_first_pos_per_ch'length); 
   user_cfg_i.good_samp_last_pos_per_ch   		<= to_unsigned(2, user_cfg_i.good_samp_last_pos_per_ch'length); 
   user_cfg_i.xsize_div_tapnum            		<= to_unsigned(xsize/4, user_cfg_i.xsize_div_tapnum'length); 
   user_cfg_i.vdac_value(1)               		<= to_unsigned(11630, user_cfg_i.vdac_value(1)'length); 
   user_cfg_i.vdac_value(2)               		<= to_unsigned(11630, user_cfg_i.vdac_value(2)'length); 
   user_cfg_i.vdac_value(3)               		<= to_unsigned(11630, user_cfg_i.vdac_value(3)'length);
   user_cfg_i.vdac_value(4)               		<= to_unsigned(11630, user_cfg_i.vdac_value(4)'length); 
   user_cfg_i.vdac_value(5)               		<= to_unsigned(11630, user_cfg_i.vdac_value(5)'length); 
   user_cfg_i.vdac_value(6)               		<= to_unsigned(11630, user_cfg_i.vdac_value(6)'length); 
   user_cfg_i.vdac_value(7)               		<= to_unsigned(11630, user_cfg_i.vdac_value(7)'length); 
   user_cfg_i.vdac_value(8)               		<= to_unsigned(11630, user_cfg_i.vdac_value(8)'length);
   user_cfg_i.adc_clk_phase                     <= to_unsigned(2, user_cfg_i.adc_clk_phase'length);
   
   fpa_softw_stat_i.fpa_roic <= FPA_ROIC_SCORPIO_MW;
   fpa_softw_stat_i.fpa_output <= OUTPUT_ANALOG;    
   fpa_softw_stat_i.fpa_input <= LVCMOS33;
   
   -- envoyer cfg
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
      
      write_axi_lite (MB_CLK, x"00000030", std_logic_vector(resize(user_cfg_i.windcfg_part1, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000034", std_logic_vector(resize(user_cfg_i.windcfg_part2, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000038", std_logic_vector(resize(user_cfg_i.windcfg_part3, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"0000003C", std_logic_vector(resize(user_cfg_i.windcfg_part4, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000040", (resize('0'&user_cfg_i.uprow_upcol, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000044", (resize('0'&user_cfg_i.sizea_sizeb, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000048", (resize('0'&user_cfg_i.itr, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"0000004C", (resize('0'&user_cfg_i.gain, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000050", std_logic_vector(resize(user_cfg_i.gpol_code, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;     
      
      write_axi_lite (MB_CLK, x"00000054", std_logic_vector(resize(user_cfg_i.real_mode_active_pixel_dly, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000058", std_logic_vector(resize('0'& user_cfg_i.adc_quad2_en, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"0000005C", std_logic_vector(resize('0'& user_cfg_i.chn_diversity_en, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000060", std_logic_vector(resize(user_cfg_i.line_period_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;                 
      write_axi_lite (MB_CLK, x"00000064", std_logic_vector(resize(user_cfg_i.readout_pclk_cnt_max, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;                 
      write_axi_lite (MB_CLK, x"00000068", std_logic_vector(resize('0'&user_cfg_i.active_line_start_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;                 
      write_axi_lite (MB_CLK, x"0000006C", std_logic_vector(resize(user_cfg_i.active_line_end_num, 32)), MB_MISO,  MB_MOSI);    
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000070", std_logic_vector(resize('0'&user_cfg_i.pix_samp_num_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000074", std_logic_vector(resize(user_cfg_i.sof_posf_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000078", std_logic_vector(resize(user_cfg_i.eof_posf_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000007C", std_logic_vector(resize(user_cfg_i.sol_posl_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000080", std_logic_vector(resize(user_cfg_i.eol_posl_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000084", std_logic_vector(resize(user_cfg_i.eol_posl_pclk_p1, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"00000088", std_logic_vector(resize(user_cfg_i.hgood_samp_sum_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000008C", std_logic_vector(resize(user_cfg_i.hgood_samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000090", std_logic_vector(resize(user_cfg_i.vgood_samp_sum_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"00000094", std_logic_vector(resize(user_cfg_i.vgood_samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000098", std_logic_vector(resize(user_cfg_i.good_samp_first_pos_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000009C", std_logic_vector(resize(user_cfg_i.good_samp_last_pos_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000A0", std_logic_vector(resize(user_cfg_i.xsize_div_tapnum, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000A4", std_logic_vector(resize(user_cfg_i.vdac_value(1), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000A8", std_logic_vector(resize(user_cfg_i.vdac_value(2), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000AC", std_logic_vector(resize(user_cfg_i.vdac_value(3), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000B0", std_logic_vector(resize(user_cfg_i.vdac_value(4), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000B4", std_logic_vector(resize(user_cfg_i.vdac_value(5), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"000000B8", std_logic_vector(resize(user_cfg_i.vdac_value(6), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000BC", std_logic_vector(resize(user_cfg_i.vdac_value(7), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000C0", std_logic_vector(resize(user_cfg_i.vdac_value(8), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000C4", std_logic_vector(resize(user_cfg_i.adc_clk_phase, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      
      write_axi_lite (MB_CLK, resize(X"E0",32), resize('0'&fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, resize(X"E4",32), resize('0'&fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 4 ns; 
      
      read_axi_lite (MB_CLK, x"00000400", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      read_axi_lite (MB_CLK, x"00000404", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      read_axi_lite (MB_CLK, x"00000400", MB_MISO, MB_MOSI, status);
      --wait for 10 ns;
      
      report "FCR written"; 
      
      ----report "END OF SIMULATION" 
      --severity error;
   end process ublaze_sim;
   
   
   -- Unit Under Test port map
   UUT : scorpiomwa_hw_ctrl_tb
   port map (
      ARESET => ARESET,
      CLK_80M => CLK_80M,
      FPA_DIGIO11 => FPA_DIGIO11,
      FPA_DIGIO12 => FPA_DIGIO12,
      FPA_EXP_INFO => FPA_EXP_INFO,
      MB_CLK => MB_CLK, 
      XTRA_TRIG => XTRA_TRIG,
      ACQ_TRIG => ACQ_TRIG,
      READOUT => READOUT,
      MB_MOSI => MB_MOSI,
      ADC_DESERIALIZER_RST => ADC_DESERIALIZER_RST,
      ADC_SYNC_FLAG => ADC_SYNC_FLAG,
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
      QUAD1_CLK => QUAD1_CLK,
      QUAD2_CLK => QUAD2_CLK,
      MB_MISO => MB_MISO
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_scorpiomwa_hw_ctrl_tb of scorpiomwa_hw_ctrl_tb_tb is
   for TB_ARCHITECTURE
      for UUT : scorpiomwa_hw_ctrl_tb
         use entity work.scorpiomwa_hw_ctrl_tb(scorpiomwa_hw_ctrl_tb);
      end for;
   end for;
end TESTBENCH_FOR_scorpiomwa_hw_ctrl_tb;

