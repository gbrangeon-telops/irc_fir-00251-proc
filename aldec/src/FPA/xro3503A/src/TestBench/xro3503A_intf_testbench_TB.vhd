library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity xro3503a_intf_testbench_tb is
end xro3503a_intf_testbench_tb;

architecture TB_ARCHITECTURE of xro3503a_intf_testbench_tb is
   -- Component declaration of the tested unit
   component xro3503a_intf_testbench
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
         DOUT_MOSI : out t_axi4_stream_mosi64;
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
   constant ACQ_TRIG_PERIOD         : time := 4 ms;
   
   constant TAP_NUM        : integer := 16;  
   constant XSIZE          : integer := 640;
   constant YSIZE          : integer := 512;
   constant OFFSETX        : integer := 0;
   constant OFFSETY        : integer := 0;
   constant LOVH_27MHz     : integer := 12;  --Spec XRO3503 for full size frame
   constant LOVH_40MHz     : integer := 36;  --Throughput must be reduced to fit data chain capacity
   constant FOVH           : integer := 1;
   constant FPA_TEMP_PWROFF_CORRECTION : integer := 1000; -- correction de saut de lecture de température FPA
   
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
   signal DOUT_MOSI : t_axi4_stream_mosi64;
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
   signal fpa_softw_stat_i : fpa_firmw_stat_type;
   signal user_cfg_i : fpa_intf_cfg_type;
   signal add : unsigned(31 downto 0) := (others => '0');
   signal status : std_logic_vector(31 downto 0);
   -- Add your code here ...
   
   signal addr : unsigned(31 downto 0);
   signal LOVH : integer;
   signal ROIC_OFFSETX : integer;
   signal ROIC_XSIZE : integer;
   signal SOF : integer;
   signal SOL : integer;
   
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
   U4: process
   begin
      ACQ_TRIG <= '0';
      wait for (ACQ_TRIG_PERIOD - 100 ns);
      ACQ_TRIG <= '1';
      wait for 100 ns;
   end process;
   XTRA_TRIG <= '0';
   
   DOUT_MISO.TREADY <= '1';
   
   
   process
   begin
      FPA_EXP_INFO.exp_time <= to_unsigned(50, FPA_EXP_INFO.exp_time'length);     -- in clk cycle of 10ns (100MHz)
      FPA_EXP_INFO.exp_indx <= x"05";
      FPA_EXP_INFO.exp_dval <= '1';
      wait for 15 ms;
      FPA_EXP_INFO.exp_dval <= '0';
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_time <= to_unsigned(90000, FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_dval <= '1';
      wait;
   end process;
   
   
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   
   LOVH <= LOVH_27MHz when (DEFINE_FPA_MCLK_RATE_KHZ <= 27_000) else LOVH_40MHz;
   
   -- Pour corriger la calibration en sous-fenetre on lit les 16 colonnes précédentes
   ROIC_OFFSETX <= OFFSETX when (OFFSETX = 0) else OFFSETX - TAP_NUM;
   ROIC_XSIZE   <= XSIZE   when (OFFSETX = 0) else XSIZE + TAP_NUM;
   SOF          <= 1       when (OFFSETX = 0) else 2;
   SOL          <= 1       when (OFFSETX = 0) else 2;
   
   
   process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         user_cfg_i.COMN.FPA_DIAG_MODE <= '0';
         user_cfg_i.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_DEGR;
         user_cfg_i.COMN.fpa_pwr_on <= '1';
         user_cfg_i.COMN.fpa_trig_ctrl_mode <= MODE_TRIG_START_TO_TRIG_START;--MODE_READOUT_END_TO_TRIG_START;
         user_cfg_i.COMN.fpa_acq_trig_ctrl_dly <= to_unsigned((DEFINE_FPA_INT_END_TO_LSYNC + (ROIC_XSIZE/TAP_NUM + LOVH) * (YSIZE + FOVH)) * DEFINE_FPA_MCLK_RATE_FACTOR_100M, user_cfg_i.COMN.fpa_acq_trig_ctrl_dly'length);    -- delay + readout (full window)
         user_cfg_i.COMN.fpa_spare <= (others => '0');
         user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly <= resize(user_cfg_i.COMN.fpa_acq_trig_ctrl_dly, user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly'length);
         user_cfg_i.COMN.fpa_trig_ctrl_timeout_dly <= to_unsigned(0, user_cfg_i.COMN.fpa_trig_ctrl_timeout_dly'length);
         user_cfg_i.comn.fpa_stretch_acq_trig <= '0';
         user_cfg_i.comn.fpa_intf_data_source <= '0';
         
         user_cfg_i.diag.ysize <= to_unsigned(YSIZE, user_cfg_i.diag.ysize'length);
         user_cfg_i.diag.xsize_div_tapnum <= to_unsigned(XSIZE/TAP_NUM, user_cfg_i.diag.xsize_div_tapnum'length);
         
         user_cfg_i.xstart <= to_unsigned(ROIC_OFFSETX/TAP_NUM, user_cfg_i.xstart'length);
         user_cfg_i.ystart <= to_unsigned(OFFSETY/4, user_cfg_i.ystart'length);
         user_cfg_i.xstop  <= to_unsigned((ROIC_OFFSETX+ROIC_XSIZE-1)/TAP_NUM, user_cfg_i.xstop'length);
         user_cfg_i.ystop  <= to_unsigned((OFFSETY+YSIZE-1)/4, user_cfg_i.ystop'length);
         user_cfg_i.sub_window_mode <= '1';  
         user_cfg_i.read_dir_down <= '0';
         user_cfg_i.read_dir_left <= '0';
         user_cfg_i.gain <= '0';
         user_cfg_i.ctia_bias_current  <= (others => '1');
         
         user_cfg_i.real_mode_active_pixel_dly  <= to_unsigned(12, user_cfg_i.real_mode_active_pixel_dly'length);
         
         user_cfg_i.line_period_pclk <= to_unsigned((ROIC_XSIZE/TAP_NUM + LOVH), user_cfg_i.line_period_pclk'length);
         user_cfg_i.window_lsync_num <= to_unsigned((YSIZE + FOVH), user_cfg_i.window_lsync_num'length);
         user_cfg_i.readout_pclk_cnt_max <= resize(user_cfg_i.window_lsync_num * user_cfg_i.line_period_pclk + 1, user_cfg_i.readout_pclk_cnt_max'length);
         
         user_cfg_i.active_line_start_num <= to_unsigned(1, user_cfg_i.active_line_start_num'length); 
         user_cfg_i.active_line_end_num <= to_unsigned(to_integer(user_cfg_i.active_line_start_num) + YSIZE - 1, user_cfg_i.active_line_end_num'length);
         
         user_cfg_i.sof_posf_pclk <= to_unsigned(SOF, user_cfg_i.sof_posf_pclk'length);
         user_cfg_i.eof_posf_pclk <= resize(user_cfg_i.active_line_end_num * user_cfg_i.line_period_pclk - LOVH, user_cfg_i.eof_posf_pclk'length);
         user_cfg_i.sol_posl_pclk <= to_unsigned(SOL, user_cfg_i.sol_posl_pclk'length);
         user_cfg_i.eol_posl_pclk <= to_unsigned(to_integer(user_cfg_i.sol_posl_pclk) + (XSIZE/TAP_NUM) - 1, user_cfg_i.eol_posl_pclk'length);
         user_cfg_i.eol_posl_pclk_p1 <= user_cfg_i.eol_posl_pclk + 1;
         
         user_cfg_i.pix_samp_num_per_ch               <= to_unsigned(1, user_cfg_i.pix_samp_num_per_ch'length);
         user_cfg_i.hgood_samp_sum_num          		<= to_unsigned(1, user_cfg_i.hgood_samp_sum_num'length); 
         user_cfg_i.hgood_samp_mean_numerator   		<= to_unsigned(2**21, user_cfg_i.hgood_samp_mean_numerator'length); 
         user_cfg_i.vgood_samp_sum_num          		<= to_unsigned(1, user_cfg_i.vgood_samp_sum_num'length); 
         user_cfg_i.vgood_samp_mean_numerator   		<= to_unsigned(2**21, user_cfg_i.vgood_samp_mean_numerator'length); 
         user_cfg_i.good_samp_first_pos_per_ch  		<= to_unsigned(1, user_cfg_i.good_samp_first_pos_per_ch'length); 
         user_cfg_i.good_samp_last_pos_per_ch   		<= to_unsigned(1, user_cfg_i.good_samp_last_pos_per_ch'length);
         
         user_cfg_i.adc_clk_source_phase              <= to_unsigned(0, user_cfg_i.adc_clk_source_phase'length);
         user_cfg_i.adc_clk_pipe_sel          		   <= to_unsigned(0, user_cfg_i.adc_clk_pipe_sel'length);
         
         user_cfg_i.offsetx                           <= to_unsigned(OFFSETX, user_cfg_i.offsetx'length);
         user_cfg_i.offsety                           <= to_unsigned(OFFSETY, user_cfg_i.offsety'length);
         user_cfg_i.width                             <= to_unsigned(XSIZE, user_cfg_i.width'length);
         user_cfg_i.height                            <= to_unsigned(YSIZE, user_cfg_i.height'length);
         
         user_cfg_i.roic_cst_output_mode              <= '0';
         user_cfg_i.fpa_pwr_override_mode             <= '0';
         
         user_cfg_i.diag.lovh_mclk_source             <= to_unsigned(LOVH * DEFINE_FPA_MCLK_RATE_FACTOR, user_cfg_i.diag.lovh_mclk_source'length);
		 
		 user_cfg_i.fpa_temp_pwroff_correction        <= to_unsigned(FPA_TEMP_PWROFF_CORRECTION, user_cfg_i.fpa_temp_pwroff_correction'length);
         
         user_cfg_i.cfg_num          		            <= to_unsigned(1, user_cfg_i.cfg_num'length);
      
         user_cfg_i.vdac_value(1)               		<= to_unsigned(11630, user_cfg_i.vdac_value(1)'length); 
         user_cfg_i.vdac_value(2)               		<= to_unsigned(11630, user_cfg_i.vdac_value(2)'length); 
         user_cfg_i.vdac_value(3)               		<= to_unsigned(11630, user_cfg_i.vdac_value(3)'length);
         user_cfg_i.vdac_value(4)               		<= to_unsigned(11630, user_cfg_i.vdac_value(4)'length); 
         user_cfg_i.vdac_value(5)               		<= to_unsigned(11630, user_cfg_i.vdac_value(5)'length); 
         user_cfg_i.vdac_value(6)               		<= to_unsigned(11630, user_cfg_i.vdac_value(6)'length); 
         user_cfg_i.vdac_value(7)               		<= to_unsigned(11630, user_cfg_i.vdac_value(7)'length); 
         user_cfg_i.vdac_value(8)               		<= to_unsigned(11630, user_cfg_i.vdac_value(8)'length);
         
      end if;
   end process;
   
   
   fpa_softw_stat_i.fpa_roic <= FPA_ROIC_XRO3503;
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
      
      addr <= (others => '0');
      
      wait until areset = '0';
      
      wait until rising_edge(MB_CLK);
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.COMN.FPA_DIAG_MODE, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.COMN.FPA_DIAG_TYPE, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.COMN.fpa_pwr_on, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.COMN.fpa_trig_ctrl_mode, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.COMN.fpa_acq_trig_ctrl_dly, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.COMN.fpa_spare, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.COMN.fpa_trig_ctrl_timeout_dly, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;        
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.comn.fpa_stretch_acq_trig, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.comn.fpa_intf_data_source, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.diag.ysize, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.diag.xsize_div_tapnum, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.xstart, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.ystart, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.xstop, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.ystop, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.sub_window_mode, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.read_dir_down, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.read_dir_left, 32), MB_MISO,  MB_MOSI);       
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.gain, 32), MB_MISO,  MB_MOSI);       
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), resize(user_cfg_i.ctia_bias_current, 32), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.real_mode_active_pixel_dly, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.line_period_pclk, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.readout_pclk_cnt_max, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.active_line_start_num, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.active_line_end_num, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;  
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.window_lsync_num, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.sof_posf_pclk, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.eof_posf_pclk, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.sol_posl_pclk, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.eol_posl_pclk, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.eol_posl_pclk_p1, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.pix_samp_num_per_ch, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.hgood_samp_sum_num, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.hgood_samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.vgood_samp_sum_num, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.vgood_samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.good_samp_first_pos_per_ch, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.good_samp_last_pos_per_ch, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.adc_clk_source_phase, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.adc_clk_pipe_sel, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.offsetx, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.offsety, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.width, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.height, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.roic_cst_output_mode, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.fpa_pwr_override_mode, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.diag.lovh_mclk_source, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;

      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.fpa_temp_pwroff_correction, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
	  
      write_axi_lite (MB_CLK, std_logic_vector(addr), std_logic_vector(resize(user_cfg_i.cfg_num, 32)), MB_MISO,  MB_MOSI);
      addr <= addr + 4;
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000D00", std_logic_vector(resize(user_cfg_i.vdac_value(1), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000D04", std_logic_vector(resize(user_cfg_i.vdac_value(2), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000D08", std_logic_vector(resize(user_cfg_i.vdac_value(3), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000D0C", std_logic_vector(resize(user_cfg_i.vdac_value(4), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000D10", std_logic_vector(resize(user_cfg_i.vdac_value(5), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"00000D14", std_logic_vector(resize(user_cfg_i.vdac_value(6), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000D18", std_logic_vector(resize(user_cfg_i.vdac_value(7), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000D1C", std_logic_vector(resize(user_cfg_i.vdac_value(8), 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, resize(X"AE0",32), resize(fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, resize(X"AE4",32), resize(fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, resize(X"AE8",32), resize(fpa_softw_stat_i.fpa_input, 32), MB_MISO,  MB_MOSI);
      wait for 4 ns; 
      
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
   UUT : xro3503a_intf_testbench
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

configuration TESTBENCH_FOR_xro3503a_intf_testbench of xro3503a_intf_testbench_tb is
   for TB_ARCHITECTURE
      for UUT : xro3503a_intf_testbench
         use entity work.xro3503a_intf_testbench(sch);
      end for;
   end for;
end TESTBENCH_FOR_xro3503a_intf_testbench;

