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
      CLK                         : in std_logic;
      
      -- µBlaze Intf              
      MB_CLK                      : in std_logic;       
      MB_MOSI                     : in t_axi4_lite_mosi;
      MB_MISO                     : out t_axi4_lite_miso;
      
      -- Memory configs
      CALIB_RAM_BLOCK_OFFSET      : out std_logic_vector(7 downto 0);
      PIXEL_DATA_BASE_ADDR        : out std_logic_vector(31 downto 0);
      
      -- AOI                      
      AOI_PARAM                   : out aoi_param_type;
      AOI_PARAM_DVAL              : out std_logic;
      
      -- Exposure time
      EXPOSURE_TIME_MULT_FP32     : out std_logic_vector(31 downto 0);  
      EXPOSURE_TIME_MULT_FP32_DVAL: out std_logic;  
      
      -- Max block index value
      CAL_BLOCK_INDEX_MAX         : out cal_block_index_type;
      
      -- Calib block selector
      CALIB_BLOCK_INFO_ARRAY      : out calib_block_array_type;
      CALIB_BLOCK_INFO_DVAL       : out std_logic;
      CALIB_BLOCK_SEL_MODE        : out calib_block_sel_mode_type;
      
      -- Switches and holes       
      INPUT_SW                    : out std_logic_vector(1 downto 0); 
      DATATYPE_SW                 : out std_logic_vector(1 downto 0);
      OUTPUT_SW                   : out std_logic_vector(1 downto 0);
      NLC_FALL                    : out std_logic;
      RQC_FALL                    : out std_logic; 
      FCC_FALL                    : out std_logic;
      
      -- Video
      VIDEO_EHDRI_INDEX     	    : out std_logic_vector(7 downto 0);
      VIDEO_FWPOSITION_INDEX      : out std_logic_vector(7 downto 0);
      VIDEO_SELECTOR 	          : out std_logic_vector(1 downto 0);
      VIDEO_FREEZE_CMD            : out std_logic;
      VIDEO_BPR_ENABLE         	 : out std_logic;
      
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
   signal config_dval_sync             : std_logic := '0';
   signal aoi_param_i                  : aoi_param_type;
   signal exposure_time_mult_fp32_i    : std_logic_vector(EXPOSURE_TIME_MULT_FP32'range);
   signal cal_block_index_max_i        : cal_block_index_type := CAL_BLOCK_INDEX_7;
   signal calib_block_sel_mode_i       : calib_block_sel_mode_type := CBSM_USER_SEL_0;
   signal calib_block_array            : calib_block_array_type := CALIB_BLOCK_ARRAY_TYPE_DEF;
   
   signal input_sw_i                   : std_logic_vector(1 downto 0) := "11";
   signal datatype_sw_i                : std_logic_vector(1 downto 0) := "11";
   signal output_sw_i                  : std_logic_vector(1 downto 0) := "11";
   signal nlc_fall_i                   : std_logic := '1';
   signal rqc_fall_i                   : std_logic := '1';
   signal fcc_fall_i                   : std_logic := '1';
   
   signal video_ehdriindex_i            : std_logic_vector(7 downto 0) := x"05";
   signal video_fwposition_i            : std_logic_vector(7 downto 0) := x"05";
   signal video_selector_i         : std_logic_vector(7 downto 0) := x"00";
   signal video_selector_hold      : std_logic_vector(7 downto 0) := x"00";
   signal video_freeze_i                 : std_logic := '0';
   signal video_bpr_enable_i             : std_logic := '0';
   
   signal flush_pipe_i                 : std_logic := '1';
   signal flush_pipe_sync              : std_logic;
   signal reset_err_i                  : std_logic := '0';
   signal done_i                       : std_logic := '0';
   signal done_sync                    : std_logic := '0';
   
   signal axi_awaddr	                  : std_logic_vector(31 downto 0);
   signal axi_awready	               : std_logic;
   signal axi_wready	                  : std_logic;
   signal axi_bresp	                  : std_logic_vector(1 downto 0);
   signal axi_bvalid	                  : std_logic;
   signal axi_araddr	                  : std_logic_vector(31 downto 0);
   signal axi_arready	               : std_logic;
   signal axi_rdata	                  : std_logic_vector(31 downto 0);
   signal axi_rresp	                  : std_logic_vector(1 downto 0);
   signal axi_rvalid	                  : std_logic;
   signal axi_wstrb                    : std_logic_vector(3 downto 0);
   signal slv_reg_rden                 : std_logic;
   signal slv_reg_wren                 : std_logic;
   signal cfg_wr_data                  : std_logic_vector(31 downto 0);
   signal mb_cfg_done                  : std_logic;
   signal mb_cfg_done_sync             : std_logic;
   signal calib_block_index            : std_logic_vector(2 downto 0);
   
begin
   
   --------------------------------------------
   -- SYNC_RESET
   -------------------------------------------- 
   areset <= not ARESETN;
   U0: sync_reset port map(ARESET => areset, sreset => sreset, CLK => MB_CLK);
   
   --------------------------------------------
   -- Output process sur CLK
   --------------------------------------------
   U1: process(CLK)
   begin
      if rising_edge(CLK) then
         done_i <= STAT.DONE;
         
         -- These outputs are updated only when the pipe is empty
         if STAT.DONE = '1' then 
            CALIB_RAM_BLOCK_OFFSET  <= calib_ram_block_offset_i;
            PIXEL_DATA_BASE_ADDR    <= pixel_data_base_addr_i;
            
            AOI_PARAM         <= aoi_param_i;
            AOI_PARAM_DVAL    <= config_dval_sync;
            
            EXPOSURE_TIME_MULT_FP32       <= exposure_time_mult_fp32_i;
            EXPOSURE_TIME_MULT_FP32_DVAL  <= config_dval_sync;
            
            INPUT_SW       <= input_sw_i;             
            DATATYPE_SW    <= datatype_sw_i;         
            OUTPUT_SW      <= output_sw_i;        
            NLC_FALL       <= nlc_fall_i;         
            RQC_FALL       <= rqc_fall_i;        
            FCC_FALL       <= fcc_fall_i;
         end if;
      end if;
   end process;
   -- These outputs are updated everytime (with clk domain change)
   U1A: double_sync port map(D => config_dval_i, Q => config_dval_sync, RESET => '0', CLK => CLK);
   U1B: double_sync port map(D => video_freeze_i, Q => VIDEO_FREEZE_CMD, RESET => '0', CLK => CLK);
   U1C: double_sync port map(D => video_bpr_enable_i, Q => VIDEO_BPR_ENABLE, RESET => '0', CLK => CLK);
   U1D: double_sync port map(D => flush_pipe_i, Q => flush_pipe_sync, RESET => '0', CLK => CLK);
   U1E: double_sync port map(D => reset_err_i, Q => RESET_ERR, RESET => '0', CLK => CLK);
   U1F: double_sync port map(D => done_i, Q => done_sync, RESET => '0', CLK => MB_CLK);
   sync_mb_cfg: double_sync port map(D => mb_cfg_done, Q => mb_cfg_done_sync, RESET => '0', CLK => CLK);
   
   VIDEO_SELECTOR <= video_selector_hold(1 downto 0);
   
   -- clock domain crossing of the vector parameters
   video_params_hold: process(CLK)
   begin
      if rising_edge(CLK) then
         if mb_cfg_done_sync = '1' then
            VIDEO_EHDRI_INDEX <= video_ehdriindex_i;
            VIDEO_FWPOSITION_INDEX <= video_fwposition_i;
            video_selector_hold <= video_selector_i;
         end if;
      end if;
   end process;
   
   -- make sure the fluch_pipe pulse is >16 clock pulses wide as per Xilinx requirement for AXIS cores
   fpipe_stretch : gh_stretch
   generic map (stretch_count => 20)
   port map(
      CLK => CLK,
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
         if done_sync = '1' then
            CAL_BLOCK_INDEX_MAX     <= cal_block_index_max_i;
            CALIB_BLOCK_INFO_ARRAY  <= calib_block_array;
            CALIB_BLOCK_INFO_DVAL   <= config_dval_i;
         end if;
      end if;
   end process;
   -- These outputs are updated everytime (without clk domain change)
   CALIB_BLOCK_SEL_MODE <= calib_block_sel_mode_i;
   
   -------------------------------------------------  
   -- liens axil                           
   -------------------------------------------------  
   -- I/O Connections assignments
   MB_MISO.AWREADY     <= axi_awready;
   MB_MISO.WREADY      <= axi_wready;
   MB_MISO.BRESP	     <= axi_bresp;
   MB_MISO.BVALID      <= axi_bvalid;
   MB_MISO.ARREADY     <= axi_arready;
   MB_MISO.RDATA	     <= axi_rdata;
   MB_MISO.RRESP	     <= axi_rresp;
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
               when X"18" => exposure_time_mult_fp32_i   <= cfg_wr_data(exposure_time_mult_fp32_i'range);
               when X"1C" => cal_block_index_max_i       <= unsigned(cfg_wr_data(cal_block_index_max_i'range));
               when X"20" => calib_block_sel_mode_i      <= cfg_wr_data(calib_block_sel_mode_i'range);
               
               when X"24" => calib_block_index <= cfg_wr_data(calib_block_index'range);
               when X"28" => config_dval_i <= '1';
               
               when X"2C" => calib_block_array(idx).sel_value                   <= cfg_wr_data(calib_block_info_type.sel_value'range);
               when X"30" => calib_block_array(idx).hder_info.cal_block_posix   <= cfg_wr_data(calib_hder_type.cal_block_posix'range);            
               when X"34" => calib_block_array(idx).hder_info.offset_fp32       <= cfg_wr_data(calib_hder_type.offset_fp32'range); 
               when X"38" => calib_block_array(idx).hder_info.data_exponent     <= cfg_wr_data(calib_hder_type.data_exponent'range);
               when X"3C" => calib_block_array(idx).hder_info.block_act_posix   <= cfg_wr_data(calib_hder_type.block_act_posix'range);
              
               -- control des switches et des trous
               when X"A4" => input_sw_i            <= cfg_wr_data(input_sw_i'range);
               when X"A8" => datatype_sw_i         <= cfg_wr_data(datatype_sw_i'range);
               when X"AC" => output_sw_i           <= cfg_wr_data(output_sw_i'range);
               when X"B0" => nlc_fall_i            <= cfg_wr_data(0);
               when X"B4" => rqc_fall_i            <= cfg_wr_data(0);
               when X"B8" => fcc_fall_i            <= cfg_wr_data(0);
               
               -- sdi
               when X"BC" => video_ehdriindex_i       <= cfg_wr_data(video_ehdriindex_i'range);
               when X"C0" => video_fwposition_i       <= cfg_wr_data(video_fwposition_i'range);
               when X"C4" => video_selector_i         <= cfg_wr_data(video_selector_i'range);
               when X"C8" => video_freeze_i     	   <= cfg_wr_data(0);
               when X"CC" => video_bpr_enable_i       <= cfg_wr_data(0);
                  
               -- flush 
               when X"D0" => flush_pipe_i          <= cfg_wr_data(0);                  
               
               -- reset errors
               when X"D4" => reset_err_i           <= cfg_wr_data(0);
               
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
               when X"E8" => axi_rdata <= resize('0'& STAT.DONE, axi_rdata'length);  -- done
   
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
