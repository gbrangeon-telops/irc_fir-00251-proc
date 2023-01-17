library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity isc0209a_intf_testbench_tb is
end isc0209a_intf_testbench_tb;

architecture TB_ARCHITECTURE of isc0209a_intf_testbench_tb is
   -- Component declaration of the tested unit
   component isc0209a_intf_testbench
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
   constant ACQ_TRIG_PERIOD         : time := 3 ms;
   
   constant EXP_TIME_US    : integer := 2000;
   
   constant PAUSE_SIZE     : integer := 16;
   constant TAP_NUM        : integer := 4;
   constant xsize : natural := 320;
   constant ysize : natural := 256;
   
   -- Electrical correction : embedded switches control
   constant ELCORR_SW_TO_PATH1             : std_logic_vector(1 downto 0) :=   "01";
   constant ELCORR_SW_TO_PATH2             : std_logic_vector(1 downto 0) :=   "10";
   constant ELCORR_SW_TO_NORMAL_OP         : std_logic_vector(1 downto 0) :=   "11";
   
   -- Electrical correction : modes
   constant ELCORR_MODE_OFF                            : integer := 0;
   constant ELCORR_MODE_REF1_IMG                       : integer := 1;
   constant ELCORR_MODE_REF2_IMG                       : integer := 2;
   constant ELCORR_MODE_OFFSET_AND_GAIN_CORR           : integer := 7;
   
   signal elcorr_reg : integer := ELCORR_MODE_OFFSET_AND_GAIN_CORR;
   
   
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
   U4: process(ACQ_TRIG)
   begin
      ACQ_TRIG <= not ACQ_TRIG after ACQ_TRIG_PERIOD/2; 
   end process;
   XTRA_TRIG <= '0';
   
   DOUT_MISO.TREADY <= '1';
   
   
   process
   begin
      FPA_EXP_INFO.exp_time <= to_unsigned(510, FPA_EXP_INFO.exp_time'length);     -- convert µs to 10ns (100MHz)
      FPA_EXP_INFO.exp_indx <= x"05";
      FPA_EXP_INFO.exp_dval <= '1';
      wait for 15 ms;
      FPA_EXP_INFO.exp_dval <= '0';
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_time <= to_unsigned((6 * 100), FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_dval <= '1';
      wait;
   end process;
   
   
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   
   process(MB_CLK)
      variable ref0_samp_num_per_ch : integer;
      variable ref1_samp_num_per_ch : integer;
   begin
      if rising_edge(MB_CLK) then 
         user_cfg_i.COMN.FPA_DIAG_MODE <= '0';
         user_cfg_i.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_DEGR;
         user_cfg_i.COMN.fpa_pwr_on <= '1';
         user_cfg_i.COMN.fpa_acq_trig_mode <= MODE_TRIG_START_TO_TRIG_START;--MODE_READOUT_END_TO_TRIG_START;
         user_cfg_i.COMN.fpa_acq_trig_ctrl_dly <= to_unsigned(289130, user_cfg_i.COMN.fpa_acq_trig_ctrl_dly'length);    -- delay + readout (full window)
         user_cfg_i.COMN.fpa_xtra_trig_mode <= MODE_TRIG_START_TO_TRIG_START;
         user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly <= to_unsigned(289130, user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly'length);
         user_cfg_i.COMN.fpa_trig_ctrl_timeout_dly <= to_unsigned(289130, user_cfg_i.COMN.fpa_trig_ctrl_timeout_dly'length);  
         user_cfg_i.XSTART <= (others => '0');
         user_cfg_i.YSTART <= (others => '0');
         user_cfg_i.XSIZE  <= to_unsigned(xsize, user_cfg_i.XSIZE'length);
         user_cfg_i.YSIZE  <= to_unsigned(ysize, user_cfg_i.YSIZE'length);
         user_cfg_i.GAIN <= "00";  
         user_cfg_i.INVERT <= '0';
         user_cfg_i.REVERT <= '0'; 
         user_cfg_i.detpol_code  <= std_logic_vector(to_unsigned(41, user_cfg_i.detpol_code'length)); 
         user_cfg_i.skimming_en  <= '0';   
         user_cfg_i.real_mode_active_pixel_dly  <= to_unsigned(13, user_cfg_i.real_mode_active_pixel_dly'length);
         user_cfg_i.adc_quad2_en  <= '0';
         user_cfg_i.chn_diversity_en  <= '0'; 
         
         user_cfg_i.line_period_pclk <= to_unsigned((XSIZE/(2*TAP_NUM) + PAUSE_SIZE)*2, user_cfg_i.line_period_pclk'length);
         user_cfg_i.readout_pclk_cnt_max   <= to_unsigned((XSIZE/(2*TAP_NUM) + PAUSE_SIZE)*(YSIZE + 2)*2 + 1, user_cfg_i.readout_pclk_cnt_max'length);
         
         user_cfg_i.active_line_start_num            <= to_unsigned(3, user_cfg_i.active_line_start_num'length); 
         user_cfg_i.active_line_end_num         <= to_unsigned(YSIZE + to_integer(user_cfg_i.active_line_start_num) - 1, user_cfg_i.active_line_end_num'length);
         user_cfg_i.window_lsync_num    <= to_unsigned(YSIZE + to_integer(user_cfg_i.active_line_start_num) - 1, user_cfg_i.window_lsync_num'length);
         
         user_cfg_i.pix_samp_num_per_ch   <= to_unsigned(1, user_cfg_i.pix_samp_num_per_ch'length);
         
         user_cfg_i.sof_posf_pclk   <= resize(user_cfg_i.line_period_pclk*(to_integer(user_cfg_i.active_line_start_num) - 1) + 1, user_cfg_i.sof_posf_pclk'length);
         user_cfg_i.eof_posf_pclk   <= resize(user_cfg_i.active_line_end_num* user_cfg_i.line_period_pclk - PAUSE_SIZE*2, user_cfg_i.eof_posf_pclk'length);
         user_cfg_i.sol_posl_pclk   <= to_unsigned(1, user_cfg_i.sol_posl_pclk'length);
         user_cfg_i.eol_posl_pclk   <= to_unsigned((XSIZE/(2*TAP_NUM))*2, user_cfg_i.eol_posl_pclk'length);
         user_cfg_i.eol_posl_pclk_p1   <= user_cfg_i.eol_posl_pclk + 1;
         
         
         user_cfg_i.hgood_samp_sum_num          		<= to_unsigned(1, user_cfg_i.hgood_samp_sum_num'length); 
         user_cfg_i.hgood_samp_mean_numerator   		<= to_unsigned(2**21, user_cfg_i.hgood_samp_mean_numerator'length); 
         user_cfg_i.vgood_samp_sum_num          		<= to_unsigned(1, user_cfg_i.vgood_samp_sum_num'length); 
         user_cfg_i.vgood_samp_mean_numerator   		<= to_unsigned(2**21, user_cfg_i.vgood_samp_mean_numerator'length); 
         user_cfg_i.good_samp_first_pos_per_ch  		<= to_unsigned(1, user_cfg_i.good_samp_first_pos_per_ch'length); 
         user_cfg_i.good_samp_last_pos_per_ch   		<= to_unsigned(1, user_cfg_i.good_samp_last_pos_per_ch'length); 
         user_cfg_i.xsize_div_tapnum            		<= to_unsigned(xsize/4, user_cfg_i.xsize_div_tapnum'length);
         
         user_cfg_i.adc_clk_source_phase              <= to_unsigned(1000, user_cfg_i.adc_clk_source_phase'length);
         user_cfg_i.adc_clk_pipe_sel          		   <= to_unsigned(3, user_cfg_i.adc_clk_pipe_sel'length);
         user_cfg_i.cfg_num          		            <= to_unsigned(1, user_cfg_i.cfg_num'length);
         user_cfg_i.comn.fpa_stretch_acq_trig         <= '0';
         user_cfg_i.comn.fpa_intf_data_source         <= '0';
         
         
         -- Electronic chain correction
         
         if (user_cfg_i.COMN.FPA_DIAG_MODE = '1') then 
            elcorr_reg <= ELCORR_MODE_OFF;
         end if;
         
         if (elcorr_reg = ELCORR_MODE_OFFSET_AND_GAIN_CORR) then
            user_cfg_i.elcorr_enabled                       <= '1';
            user_cfg_i.elcorr_ref0_op_sel                   <= ELCORR_SW_TO_NORMAL_OP;
            user_cfg_i.elcorr_ref1_op_sel                   <= ELCORR_SW_TO_NORMAL_OP;
            user_cfg_i.elcorr_mult_op_sel                   <= ELCORR_SW_TO_NORMAL_OP;
            user_cfg_i.elcorr_div_op_sel                    <= ELCORR_SW_TO_NORMAL_OP;
            user_cfg_i.elcorr_add_op_sel                    <= ELCORR_SW_TO_NORMAL_OP;
         elsif (elcorr_reg = ELCORR_MODE_REF1_IMG) then
            user_cfg_i.elcorr_enabled                       <= '1';
            user_cfg_i.elcorr_ref0_op_sel                   <= ELCORR_SW_TO_PATH2;
            user_cfg_i.elcorr_ref1_op_sel                   <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_mult_op_sel                   <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_div_op_sel                    <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_add_op_sel                    <= ELCORR_SW_TO_PATH1;
         elsif (elcorr_reg = ELCORR_MODE_REF2_IMG) then
            user_cfg_i.elcorr_enabled                       <= '1';
            user_cfg_i.elcorr_ref0_op_sel                   <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_ref1_op_sel                   <= ELCORR_SW_TO_PATH2;
            user_cfg_i.elcorr_mult_op_sel                   <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_div_op_sel                    <= ELCORR_SW_TO_PATH2;
            user_cfg_i.elcorr_add_op_sel                    <= ELCORR_SW_TO_PATH1;
         else  --ELCORR_MODE_OFF
            user_cfg_i.elcorr_enabled                       <= '0';
            user_cfg_i.elcorr_ref0_op_sel                   <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_ref1_op_sel                   <= ELCORR_SW_TO_PATH2;
            user_cfg_i.elcorr_mult_op_sel                   <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_div_op_sel                    <= ELCORR_SW_TO_PATH1;
            user_cfg_i.elcorr_add_op_sel                    <= ELCORR_SW_TO_PATH1;
         end if;
         
         user_cfg_i.elcorr_spare1                           <= '0';  -- not used
         user_cfg_i.elcorr_spare2                           <= (others => '0');  -- not used
         
         ref0_samp_num_per_ch := 49 - 1;
         user_cfg_i.elcorr_ref_cfg(0).ref_enabled           <= '1';
         user_cfg_i.elcorr_ref_cfg(0).ref_cont_meas_mode    <= '0';  -- not used
         user_cfg_i.elcorr_ref_cfg(0).start_dly_sampclk     <= to_unsigned(0, user_cfg_i.elcorr_ref_cfg(0).start_dly_sampclk'length);
         user_cfg_i.elcorr_ref_cfg(0).samp_num_per_ch       <= to_unsigned(ref0_samp_num_per_ch, user_cfg_i.elcorr_ref_cfg(0).samp_num_per_ch'length);
         user_cfg_i.elcorr_ref_cfg(0).samp_mean_numerator   <= to_unsigned(2**21/ref0_samp_num_per_ch, user_cfg_i.elcorr_ref_cfg(0).samp_mean_numerator'length);
         user_cfg_i.elcorr_ref_cfg(0).ref_value             <= (others => '0');  -- not used
         user_cfg_i.elcorr_ref_cfg(0).forced_val_enabled    <= '1';  -- use forced value in testbench since we don't have real reference value
         user_cfg_i.elcorr_ref_cfg(0).forced_val            <= to_unsigned(300, user_cfg_i.elcorr_ref_cfg(1).forced_val'length);
         
         ref1_samp_num_per_ch := xsize/4 - 1;
         user_cfg_i.elcorr_ref_cfg(1).ref_enabled           <= '1';
         user_cfg_i.elcorr_ref_cfg(1).ref_cont_meas_mode    <= '0';  -- not used
         user_cfg_i.elcorr_ref_cfg(1).start_dly_sampclk     <= to_unsigned(0, user_cfg_i.elcorr_ref_cfg(1).start_dly_sampclk'length);
         user_cfg_i.elcorr_ref_cfg(1).samp_num_per_ch       <= to_unsigned(ref1_samp_num_per_ch, user_cfg_i.elcorr_ref_cfg(1).samp_num_per_ch'length);
         user_cfg_i.elcorr_ref_cfg(1).samp_mean_numerator   <= to_unsigned(2**21/ref1_samp_num_per_ch, user_cfg_i.elcorr_ref_cfg(1).samp_mean_numerator'length);
         user_cfg_i.elcorr_ref_cfg(1).ref_value             <= (others => '0');  -- not used
         user_cfg_i.elcorr_ref_cfg(1).forced_val_enabled    <= '1';  -- use forced value in testbench since we don't have real reference value
         user_cfg_i.elcorr_ref_cfg(1).forced_val            <= to_unsigned(100, user_cfg_i.elcorr_ref_cfg(1).forced_val'length);
         
         user_cfg_i.elcorr_ref_dac_id                       <= (others => '0');  -- not used
         user_cfg_i.elcorr_atemp_gain                       <= to_signed(2, user_cfg_i.elcorr_atemp_gain'length);
         user_cfg_i.elcorr_atemp_ofs                        <= to_signed(1, user_cfg_i.elcorr_atemp_ofs'length);
         user_cfg_i.sat_ctrl_en                             <= '1'; 
         
         user_cfg_i.roic_cst_output_mode                    <= '0';
         user_cfg_i.elcorr_spare3                           <= '0'; -- not used
         user_cfg_i.elcorr_spare4                           <= '0'; -- not used 
      
         user_cfg_i.vdac_value(1)               <= to_unsigned(11630, user_cfg_i.vdac_value(1)'length); 
         user_cfg_i.vdac_value(2)               <= to_unsigned(11630, user_cfg_i.vdac_value(2)'length); 
         user_cfg_i.vdac_value(3)               <= to_unsigned(11630, user_cfg_i.vdac_value(3)'length);
         user_cfg_i.vdac_value(4)               <= to_unsigned(11630, user_cfg_i.vdac_value(4)'length); 
         user_cfg_i.vdac_value(5)               <= to_unsigned(11630, user_cfg_i.vdac_value(5)'length); 
         user_cfg_i.vdac_value(6)               <= to_unsigned(11630, user_cfg_i.vdac_value(6)'length); 
         user_cfg_i.vdac_value(7)               <= to_unsigned(11630, user_cfg_i.vdac_value(7)'length); 
         user_cfg_i.vdac_value(8)               <= to_unsigned(11630, user_cfg_i.vdac_value(8)'length);
      end if;
   end process;
   
   
   fpa_softw_stat_i.fpa_roic <= FPA_ROIC_ISC0209;
   fpa_softw_stat_i.fpa_output <= OUTPUT_ANALOG;    
   fpa_softw_stat_i.fpa_input <= LVTTL50;
   
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
      write_axi_lite (MB_CLK, x"0000000C", resize('0'&user_cfg_i.COMN.fpa_acq_trig_mode, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"00000010", std_logic_vector(resize(user_cfg_i.COMN.fpa_acq_trig_ctrl_dly, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"00000014", std_logic_vector(resize(user_cfg_i.COMN.fpa_xtra_trig_mode, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"00000018", std_logic_vector(resize(user_cfg_i.COMN.fpa_xtra_trig_ctrl_dly, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"0000001C", std_logic_vector(resize(user_cfg_i.COMN.fpa_trig_ctrl_timeout_dly, 32)), MB_MISO,  MB_MOSI);
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
      
      write_axi_lite (MB_CLK, x"0000003C", resize('0'&user_cfg_i.detpol_code, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000040", std_logic_vector(resize('0'&user_cfg_i.skimming_en, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000044", std_logic_vector(resize(user_cfg_i.real_mode_active_pixel_dly, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000048", std_logic_vector(resize('0'& user_cfg_i.adc_quad2_en, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"0000004C", std_logic_vector(resize('0'& user_cfg_i.chn_diversity_en, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000050", std_logic_vector(resize(user_cfg_i.line_period_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000054", std_logic_vector(resize(user_cfg_i.readout_pclk_cnt_max, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000058", std_logic_vector(resize('0'&user_cfg_i.active_line_start_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"0000005C", std_logic_vector(resize(user_cfg_i.active_line_end_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;  
      write_axi_lite (MB_CLK, x"00000060", std_logic_vector(resize('0'&user_cfg_i.window_lsync_num, 32)), MB_MISO,  MB_MOSI);
      
      
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000064", std_logic_vector(resize('0'&user_cfg_i.pix_samp_num_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"00000068", std_logic_vector(resize(user_cfg_i.sof_posf_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"0000006C", std_logic_vector(resize(user_cfg_i.eof_posf_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000070", std_logic_vector(resize(user_cfg_i.sol_posl_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, x"00000074", std_logic_vector(resize(user_cfg_i.eol_posl_pclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000078", std_logic_vector(resize(user_cfg_i.eol_posl_pclk_p1, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      
      write_axi_lite (MB_CLK, x"0000007C", std_logic_vector(resize(user_cfg_i.hgood_samp_sum_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000080", std_logic_vector(resize(user_cfg_i.hgood_samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000084", std_logic_vector(resize(user_cfg_i.vgood_samp_sum_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, x"00000088", std_logic_vector(resize(user_cfg_i.vgood_samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000008C", std_logic_vector(resize(user_cfg_i.good_samp_first_pos_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000090", std_logic_vector(resize(user_cfg_i.good_samp_last_pos_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000094", std_logic_vector(resize(user_cfg_i.xsize_div_tapnum, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000098", std_logic_vector(resize(user_cfg_i.adc_clk_source_phase, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000009C", std_logic_vector(resize(user_cfg_i.adc_clk_pipe_sel, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000A0", std_logic_vector(resize(user_cfg_i.cfg_num, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000A4", std_logic_vector(resize('0'&user_cfg_i.comn.fpa_stretch_acq_trig, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000A8", std_logic_vector(resize('0'&user_cfg_i.comn.fpa_intf_data_source, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, x"000000AC", std_logic_vector(resize(user_cfg_i.elcorr_enabled, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000B0", std_logic_vector(resize(user_cfg_i.elcorr_spare1, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000B4", std_logic_vector(resize(user_cfg_i.elcorr_spare2, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000B8", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).ref_enabled, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000BC", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).ref_cont_meas_mode, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000C0", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).start_dly_sampclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000C4", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).samp_num_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000C8", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000CC", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).ref_value, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000D0", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).ref_enabled, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000D4", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).ref_cont_meas_mode, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000D8", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).start_dly_sampclk, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000DC", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).samp_num_per_ch, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000E0", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).samp_mean_numerator, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000E4", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).ref_value, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000E8", std_logic_vector(resize(user_cfg_i.elcorr_ref_dac_id, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000EC", std_logic_vector(resize(user_cfg_i.elcorr_atemp_gain, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000F0", std_logic_vector(resize(user_cfg_i.elcorr_atemp_ofs, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000F4", std_logic_vector(resize(user_cfg_i.elcorr_ref0_op_sel, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000F8", std_logic_vector(resize(user_cfg_i.elcorr_ref1_op_sel, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"000000FC", std_logic_vector(resize(user_cfg_i.elcorr_mult_op_sel, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000100", std_logic_vector(resize(user_cfg_i.elcorr_div_op_sel, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000104", std_logic_vector(resize(user_cfg_i.elcorr_add_op_sel, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000108", std_logic_vector(resize(user_cfg_i.elcorr_spare3, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000010C", std_logic_vector(resize(user_cfg_i.sat_ctrl_en, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000110", std_logic_vector(resize(user_cfg_i.roic_cst_output_mode, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000114", std_logic_vector(resize(user_cfg_i.elcorr_spare4, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000118", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).forced_val_enabled, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"0000011C", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(0).forced_val, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000120", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).forced_val_enabled, 32)), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, x"00000124", std_logic_vector(resize(user_cfg_i.elcorr_ref_cfg(1).forced_val, 32)), MB_MISO,  MB_MOSI);
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
      
      write_axi_lite (MB_CLK, resize(X"AE0",32), resize('0'&fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, resize(X"AE4",32), resize('0'&fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      write_axi_lite (MB_CLK, resize(X"AE8",32), resize('0'&fpa_softw_stat_i.fpa_input, 32), MB_MISO,  MB_MOSI);
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
   UUT : isc0209a_intf_testbench
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

configuration TESTBENCH_FOR_isc0209a_intf_testbench of isc0209a_intf_testbench_tb is
   for TB_ARCHITECTURE
      for UUT : isc0209a_intf_testbench
         use entity work.isc0209a_intf_testbench(sch);
      end for;
   end for;
end TESTBENCH_FOR_isc0209a_intf_testbench;

