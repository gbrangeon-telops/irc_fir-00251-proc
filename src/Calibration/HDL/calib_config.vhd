------------------------------------------------------------------
--!   @file : calib_config
--!   @brief
--!   @details
--!
--!   $Rev: $
--!   $Author: $
--!   $Date: $
--!   $Id: $
--!   $URL: $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.calib_define.all;

entity calib_config is
   
   port( 
      ARESETN                     : in std_logic;
      CLK_CAL                     : in std_logic;
      CLK_DATA                    : in std_logic;
      
      -- µBlaze Intf              
      MB_CLK                      : in std_logic;       
      MB_MOSI                     : in t_axi4_lite_mosi;
      MB_MISO                     : out t_axi4_lite_miso;
      
      -- Memory configs
      CALIB_RAM_BLOCK_OFFSET      : out std_logic_vector(7 downto 0);
      PIXEL_DATA_BASE_ADDR        : out std_logic_vector(31 downto 0);
      
      -- Max block index value
      CAL_BLOCK_INDEX_MAX         : out cal_block_index_type;
      
      -- Calib block selector
      CALIB_BLOCK_INFO_ARRAY      : out calib_block_array_type;
      CALIB_BLOCK_INFO_DVAL       : out std_logic;
      CALIB_BLOCK_SEL_MODE        : out calib_block_sel_mode_type;    

      -- Calib LUT switch
      NLC_LUT_SWITCH              : out std_logic;
      RQC_LUT_SWITCH              : out std_logic;

      -- Calib data flow config       
      CALIB_FLOW_CONFIG           : out calib_flow_config_type;
      
      -- AOI                      
      AOI_PARAM                   : out aoi_param_type;
      AOI_PARAM_DVAL              : out std_logic;
      
      -- XCROPPER
      CAL_XCROPPING_PARAM         : out calib_xcropping_type;
      CAL_XCROPPING_DVAL          : out std_logic;
      
      -- Exposure time
      EXP_TIME_MULT_FP32          : out std_logic_vector(31 downto 0);  
      EXP_TIME_MULT_FP32_DVAL     : out std_logic;
      
      -- Video
      VIDEO_BPR_MODE          	 : out bpr_mode_type;
      
      -- Flush Pipe               
      FLUSH_PIPE                  : out std_logic;
      
      -- status
      RESET_ERR                   : out std_logic;
      STAT                        : in calib_stat_type
      
      );
   
end calib_config;


architecture rtl of calib_config is

   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component double_sync
      generic(
         INIT_VALUE : bit := '0'
      );
      port(
         D : in STD_LOGIC;
         Q : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC
      );
   end component;
   
   component gh_stretch
      generic (stretch_count: integer :=1023);
      port(
         CLK : in STD_LOGIC;
         rst : in STD_LOGIC;
         D : in STD_LOGIC;
         Q : out STD_LOGIC
         );
   end component;
   
   signal areset                       : std_logic;
   signal sreset                       : std_logic;
   
   signal calib_ram_block_offset_i     : std_logic_vector(CALIB_RAM_BLOCK_OFFSET'range) := (others => '0');
   signal pixel_data_base_addr_i       : std_logic_vector(PIXEL_DATA_BASE_ADDR'range) := (others => '0');
   
   signal config_dval_i                : std_logic := '0';      
   signal calib_block_info_dval_i      : std_logic := '0';
   
   signal expTimeMult_dval_i           : std_logic := '0';
   signal expTimeMult_dval_sync        : std_logic := '0';
   signal config_dval_sync             : std_logic := '0';
   signal aoi_param_i                  : aoi_param_type;
   signal cal_xcropping_cfg_i          : calib_xcropping_type;         
   signal exp_time_mult_fp32_i         : std_logic_vector(EXP_TIME_MULT_FP32'range);
   signal cal_block_index_max_i        : cal_block_index_type := CAL_BLOCK_INDEX_7;
   signal calib_block_sel_mode_i       : calib_block_sel_mode_type := CBSM_USER_SEL_0;
   signal calib_block_array            : calib_block_array_type := CALIB_BLOCK_ARRAY_TYPE_DEF;
   
   signal calib_flow_config_i          : calib_flow_config_type;
   
   signal video_config_i               : video_config_type := ("00", x"05", x"00", '0');
   signal video_bpr_mode_i             : bpr_mode_type := BPR_MODE_LAST_VALID;
   
   signal lut_switch_reg               : std_logic_vector(1 downto 0) := (others => '0');
   
   signal flush_pipe_i                  : std_logic := '1';
   signal flush_pipe_sync               : std_logic;
   signal reset_err_i                   : std_logic := '0';
   signal done_i                        : std_logic := '0';
   signal done_sync_clkMB               : std_logic := '0';
   signal done_sync_clkCal              : std_logic := '0';
   
   signal axi_awaddr                    : std_logic_vector(31 downto 0);
   signal axi_awready                   : std_logic;
   signal axi_wready                    : std_logic;
   signal axi_bresp                     : std_logic_vector(1 downto 0);
   signal axi_bvalid                    : std_logic;
   signal axi_araddr                    : std_logic_vector(31 downto 0);
   signal axi_arready                   : std_logic;
   signal axi_rdata                     : std_logic_vector(31 downto 0);
   signal axi_rresp                     : std_logic_vector(1 downto 0);
   signal axi_rvalid                    : std_logic;
   signal axi_wstrb                     : std_logic_vector(3 downto 0);
   signal slv_reg_rden                  : std_logic;
   signal slv_reg_wren                  : std_logic;
   signal cfg_wr_data                   : std_logic_vector(31 downto 0);
   signal mb_cfg_done                   : std_logic := '0';     -- to have a rising edge at start-up
   signal mb_cfg_done_sync_clkCal       : std_logic;
   signal mb_cfg_done_sync_last_clkCal  : std_logic;
   signal mb_cfg_done_sync_clkData      : std_logic;
   signal mb_cfg_done_sync_last_clkData : std_logic;
   signal calib_block_index             : std_logic_vector(2 downto 0);
   
begin
   
   --------------------------------------------
   -- SYNC_RESET
   -------------------------------------------- 
   areset <= not ARESETN;
   U0: sync_reset port map(ARESET => areset, sreset => sreset, CLK => MB_CLK);
   
   --------------------------------------------
   -- Output process sur CLK_CAL
   --------------------------------------------
   U1: process(CLK_CAL)
   begin
      if rising_edge(CLK_CAL) then
         
         
         -- These outputs are updated only when the pipe is empty
         if done_sync_clkCal = '1' then 
            CALIB_RAM_BLOCK_OFFSET  <= calib_ram_block_offset_i;
            PIXEL_DATA_BASE_ADDR    <= pixel_data_base_addr_i;
            
            AOI_PARAM               <= aoi_param_i;
            AOI_PARAM_DVAL          <= config_dval_sync;
            
            CAL_XCROPPING_PARAM     <= cal_xcropping_cfg_i;
            CAL_XCROPPING_DVAL      <= config_dval_sync;
            
            EXP_TIME_MULT_FP32      <= exp_time_mult_fp32_i;
            EXP_TIME_MULT_FP32_DVAL <= expTimeMult_dval_sync;
         end if;
         
         mb_cfg_done_sync_last_clkCal <= mb_cfg_done_sync_clkCal;
         
         -- These outputs are updated everytime (when clk domain crossing is done)
         if mb_cfg_done_sync_clkCal = '1' and mb_cfg_done_sync_last_clkCal = '0' then
            
            flush_pipe_sync   <= flush_pipe_i;
         end if;
      end if;
   end process;
   
   -- Clk domain crossing config signals
   sync_dval   : double_sync port map(D => config_dval_i, Q => config_dval_sync, RESET => '0', CLK => CLK_CAL); 
   
   sync_done_clkMB   : double_sync port map(D => done_i, Q => done_sync_clkMB, RESET => '0', CLK => MB_CLK);
   sync_done_clkCal   : double_sync port map(D => done_i, Q => done_sync_clkCal, RESET => '0', CLK => CLK_CAL);  
   sync_expDval_clkCal   : double_sync port map(D => expTimeMult_dval_i, Q => expTimeMult_dval_sync, RESET => '0', CLK => CLK_CAL);  
   
   sync_mb_cfg_clkCal : double_sync port map(D => mb_cfg_done, Q => mb_cfg_done_sync_clkCal, RESET => '0', CLK => CLK_CAL); 
   
   -- clock domain crossing for lut switch signal
	sync_nlc_lut_switch_clkCal : double_sync port map(D => lut_switch_reg(0), Q => NLC_LUT_SWITCH, RESET => '0', CLK => CLK_CAL);
	sync_rqc_lut_switch_clkCal : double_sync port map(D => lut_switch_reg(1), Q => RQC_LUT_SWITCH, RESET => '0', CLK => CLK_CAL);
   
   -- make sure the flush_pipe pulse is >16 clock pulses wide as per Xilinx requirement for AXIS cores
   fpipe_stretch : gh_stretch
   generic map (stretch_count => 20)
   port map(
      CLK => CLK_CAL,
      rst => areset,
      D => flush_pipe_sync,
      Q => FLUSH_PIPE
      );
   
   --------------------------------------------
   -- Output process sur MB_CLK
   --------------------------------------------
   U2: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         -- These outputs are updated only when the pipe is empty 
         if done_sync_clkMB = '1' then
            CAL_BLOCK_INDEX_MAX     <= cal_block_index_max_i;
            CALIB_BLOCK_INFO_ARRAY  <= calib_block_array;
            CALIB_BLOCK_INFO_DVAL   <= calib_block_info_dval_i;
         end if;
      end if;
   end process;
   -- These outputs are updated everytime (without clk domain change)
   CALIB_BLOCK_SEL_MODE <= calib_block_sel_mode_i;
   
   
      --------------------------------------------
   -- Output process sur CLK_DATA
   --------------------------------------------
  U2_2: process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         
         done_i <= STAT.DONE;
         
         -- These outputs are updated only when the pipe is empty
         if STAT.DONE = '1' then 
            
            CALIB_FLOW_CONFIG       <= calib_flow_config_i;

         end if;
         
         mb_cfg_done_sync_last_clkData <= mb_cfg_done_sync_clkData;
         
         -- These outputs are updated everytime (when clk domain crossing is done)
         if mb_cfg_done_sync_clkData = '1' and mb_cfg_done_sync_last_clkData = '0' then
            VIDEO_BPR_MODE    <= video_bpr_mode_i;
            RESET_ERR         <= reset_err_i;
         end if;
      end if;
   end process;
   
    -- Clk domain crossing config signals
   --sync_done_clkData   : double_sync port map(D => done_i, Q => done_sync_clkData, RESET => '0', CLK => MB_CLK);  
   
   sync_mb_cfg_clkData : double_sync port map(D => mb_cfg_done, Q => mb_cfg_done_sync_clkData, RESET => '0', CLK => CLK_DATA);
    
   -------------------------------------------------  
   -- liens axil                           
   -------------------------------------------------  
   -- I/O Connections assignments
   MB_MISO.AWREADY     <= axi_awready;
   MB_MISO.WREADY      <= axi_wready;
   MB_MISO.BRESP       <= axi_bresp;
   MB_MISO.BVALID      <= axi_bvalid;
   MB_MISO.ARREADY     <= axi_arready;
   MB_MISO.RDATA       <= axi_rdata;
   MB_MISO.RRESP       <= axi_rresp;
   MB_MISO.RVALID      <= axi_rvalid;
   
   -------------------------------------------------  
   -- reception Config                                
   -------------------------------------------------   
   U3: process(MB_CLK)
      variable idx : integer range 0 to 7;
   begin
      if rising_edge(MB_CLK) then
         
         idx := to_integer(unsigned(calib_block_index));
         
         if slv_reg_wren = '1' and axi_wstrb =  "1111" then  
            mb_cfg_done <= '0';
            
            case axi_awaddr(7 downto 0) is             
               
               -- elements de config
               when X"00" => calib_ram_block_offset_i    <= cfg_wr_data(calib_ram_block_offset_i'range); config_dval_i <= '0';
               when X"04" => pixel_data_base_addr_i      <= cfg_wr_data(pixel_data_base_addr_i'range);
               when X"08" => aoi_param_i.width           <= unsigned(cfg_wr_data(aoi_param_i.width'range));
               when X"0C" => aoi_param_i.height          <= unsigned(cfg_wr_data(aoi_param_i.height'range));
               when X"10" => aoi_param_i.offsetx         <= unsigned(cfg_wr_data(aoi_param_i.offsetx'range));
               when X"14" => aoi_param_i.offsety         <= unsigned(cfg_wr_data(aoi_param_i.offsety'range));
               when X"18" => aoi_param_i.width_aligned   <= unsigned(cfg_wr_data(aoi_param_i.width_aligned'range));
               when X"1C" => aoi_param_i.offsetx_aligned <= unsigned(cfg_wr_data(aoi_param_i.offsetx_aligned'range));
               when X"20" => cal_xcropping_cfg_i.full_width <= cfg_wr_data(cal_xcropping_cfg_i.full_width'range);
               when X"24" => cal_xcropping_cfg_i.aoi_fli_pos <= cfg_wr_data(cal_xcropping_cfg_i.aoi_fli_pos'range);
               when X"28" => cal_xcropping_cfg_i.aoi_lli_pos <= cfg_wr_data(cal_xcropping_cfg_i.aoi_lli_pos'range);
               when X"2C" => cal_xcropping_cfg_i.aoi_sol_pos <= cfg_wr_data(cal_xcropping_cfg_i.aoi_sol_pos'range);
               when X"30" => cal_xcropping_cfg_i.aoi_eol_pos <= cfg_wr_data(cal_xcropping_cfg_i.aoi_eol_pos'range);
               when X"34" => exp_time_mult_fp32_i        <= cfg_wr_data(exp_time_mult_fp32_i'range); expTimeMult_dval_i <= '1';
               when X"38" => cal_block_index_max_i       <= unsigned(cfg_wr_data(cal_block_index_max_i'range));               
               when X"3C" => calib_block_sel_mode_i      <= cfg_wr_data(calib_block_sel_mode_i'range);config_dval_i <= '1';               
               when X"40" => calib_block_index           <= cfg_wr_data(calib_block_index'range);
               when X"44" => calib_block_info_dval_i     <= cfg_wr_data(0);

               when X"48" => calib_block_array(idx).sel_value                   <= cfg_wr_data(calib_block_info_type.sel_value'range);               
               when X"4C" => calib_block_array(idx).hder_info.cal_block_posix   <= cfg_wr_data(calib_hder_type.cal_block_posix'range);
               when X"50" => calib_block_array(idx).hder_info.offset_fp32       <= cfg_wr_data(calib_hder_type.offset_fp32'range);
               when X"54" => calib_block_array(idx).hder_info.data_exponent     <= cfg_wr_data(calib_hder_type.data_exponent'range);
               when X"58" => calib_block_array(idx).hder_info.block_act_posix   <= cfg_wr_data(calib_hder_type.block_act_posix'range);
               when X"5C" => calib_block_array(idx).hder_info.low_cut           <= cfg_wr_data(calib_hder_type.low_cut'range);               
               when X"60" => calib_block_array(idx).hder_info.high_cut          <= cfg_wr_data(calib_hder_type.high_cut'range);
               when X"64" => calib_block_array(idx).hder_info.delta_temp_fp32   <= cfg_wr_data(calib_hder_type.delta_temp_fp32'range);
                             
               -- control du data flow
               when X"A4" => calib_flow_config_i.input_sw            <= cfg_wr_data(calib_flow_config_i.input_sw'range);
               when X"A8" => calib_flow_config_i.datatype_sw         <= cfg_wr_data(calib_flow_config_i.datatype_sw'range);
               when X"AC" => calib_flow_config_i.output_sw           <= cfg_wr_data(calib_flow_config_i.output_sw'range);
               when X"B0" => calib_flow_config_i.nlc_fall            <= cfg_wr_data(0);
               when X"B4" => calib_flow_config_i.rqc_fall            <= cfg_wr_data(0);
               when X"B8" => calib_flow_config_i.fcc_fall            <= cfg_wr_data(0);
              
               when X"CC" => video_bpr_mode_i                  <= cfg_wr_data(video_bpr_mode_i'range);
               
               -- flush 
               when X"D0" => flush_pipe_i          <= cfg_wr_data(0);
               
               -- reset errors
               when X"D4" => reset_err_i           <= cfg_wr_data(0);
   
               -- configure calib LUT switch
               when X"DC" => lut_switch_reg <= cfg_wr_data(lut_switch_reg'range);
               when others =>
               
            end case;
         else
            mb_cfg_done <= '1';
         end if; 
      end if;  
   end process;
   
   -------------------------------------------------  
   -- envoi statut                                
   ------------------------------------------------- 
   U4: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then                       
         
            case axi_araddr(7 downto 0) is             
               -- done                                                   
               when X"E8" => axi_rdata <= resize(STAT.DONE, axi_rdata'length);  -- done
   
               --erreurs
               when X"EC" => axi_rdata <= STAT.ERROR_REG(0);  -- 1e  registre des errreurs
               when X"F0" => axi_rdata <= STAT.ERROR_REG(1);  -- 1e  registre des errreurs
               when X"F4" => axi_rdata <= STAT.ERROR_REG(2);  -- 2e  registre des errreurs
               when X"F8" => axi_rdata <= STAT.ERROR_REG(3);  -- 3e  registre des errreurs
               when X"FC" => axi_rdata <= STAT.ERROR_REG(4);  -- 4e  registre des errreurs               
               when others =>

            end case;            

      end if;  
   end process;
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U5: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if axi_arready = '0' and MB_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= MB_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;            
            if axi_arready = '1' and MB_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and MB_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   slv_reg_rden <= axi_arready and MB_MOSI.ARVALID and (not axi_rvalid);
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U7: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else            
            
            if (axi_awready = '0' and MB_MOSI.AWVALID = '1' and MB_MOSI.WVALID = '1') then -- 
               axi_awready <= '1';
               axi_awaddr <= MB_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;            
            if (axi_wready = '0' and MB_MOSI.WVALID = '1' and MB_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';
            end if;           			
            
         end if;
      end if;
   end process;
   slv_reg_wren <= axi_wready and MB_MOSI.WVALID and axi_awready and MB_MOSI.AWVALID ;
   cfg_wr_data <= MB_MOSI.WDATA;
   axi_wstrb <= MB_MOSI.WSTRB;  -- requis car le MB envoie des chmps de header avec des strobes differents de "1111"; 
   
   -----------------------------------------------------
   -- CFG MB AXI WR  : WR feedback envoyé au MB
   -----------------------------------------------------
   U8: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; -- need to work more on the responses
         else
            if slv_reg_wren = '1' and axi_bvalid = '0' then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif MB_MOSI.BREADY = '1' and axi_bvalid = '1' then   -- check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                  -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process;
   
end rtl;
