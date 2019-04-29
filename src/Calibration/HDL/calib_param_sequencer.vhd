------------------------------------------------------------------
--!   @file : calib_param_sequencer
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.calib_define.all;

entity calib_param_sequencer is
   generic(
      IMG_WIDTH_MAX  : integer := 640;
      IMG_HEIGHT_MAX : integer := 512
      );
   port( 
      ARESETN                     : in std_logic;
      CLK                         : in std_logic;
      
      -- Header Extractor
      EXTRACTED_INFO_VALID        : in std_logic;
      EXTRACTED_BLOCK_INDEX       : in cal_block_index_type;
      
      -- Calibration RAM
      RAM_RD_EN                   : out std_logic;
      RAM_RD_ADD                  : out std_logic_vector(7 downto 0);      
      RAM_RD_DATA                 : in std_logic_vector(31 downto 0);
      
      -- Calibration Config
      RAM_BLOCK_OFFSET            : in std_logic_vector(7 downto 0);
      PIXEL_DATA_BASE_ADDR        : in std_logic_vector(31 downto 0);
      CAL_BLOCK_INDEX_MAX         : in cal_block_index_type;
      
      -- DDR
      DDR_ADDR_OFFSET             : out std_logic_vector(31 downto 0);  --in bytes
      DDR_READ_START              : out std_logic;
      
      -- Saturation
      SATURATION_THRESHOLD        : out std_logic_vector(31 downto 0); 
      SATURATION_THRESHOLD_WR_EN  : out std_logic;
      
      -- NLC                      
      NLC_LUT_PARAM               : out lut_param_type;
      NLC_LUT_PARAM_WR_EN         : out std_logic;
      
      RANGE_OFS_FP32              : out std_logic_vector(31 downto 0);
      RANGE_OFS_FP32_WR_EN        : out std_logic;
      
      POW2_OFFSET_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      POW2_OFFSET_EXP_FP32_WR_EN  : out std_logic;  
      
      POW2_RANGE_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      POW2_RANGE_EXP_FP32_WR_EN   : out std_logic;  
      
      NLC_POW2_M_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      NLC_POW2_M_EXP_FP32_WR_EN   : out std_logic;  
      
      NLC_POW2_B_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      NLC_POW2_B_EXP_FP32_WR_EN   : out std_logic;  
      
      -- FSU                      
      DELTA_TEMP_FP32             : out std_logic_vector(31 downto 0);
      DELTA_TEMP_FP32_WR_EN       : out std_logic;
      
      ALPHA_OFFSET_FP32           : out std_logic_vector(31 downto 0);
      ALPHA_OFFSET_FP32_WR_EN     : out std_logic;
      
      POW2_ALPHA_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      POW2_ALPHA_EXP_FP32_WR_EN   : out std_logic;  
      
      POW2_BETA0_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      POW2_BETA0_EXP_FP32_WR_EN	 : out std_logic;  
      
      POW2_KAPPA_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      POW2_KAPPA_EXP_FP32_WR_EN	 : out std_logic;      
      
      -- FCC                      
      NUC_MULT_FACTOR_FP32     	 : out std_logic_vector(31 downto 0);
      NUC_MULT_FACTOR_FP32_WR_EN	 : out std_logic;
      
      -- RQC
      RQC_LUT_PARAM               : out lut_param_type;
      RQC_LUT_PARAM_WR_EN         : out std_logic;
      
      RQC_LUT_PAGE_ID             : out std_logic_vector(31 downto 0); --same as calib block index
      RQC_LUT_PAGE_WR_EN          : out std_logic;   
      
      RQC_POW2_M_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      RQC_POW2_M_EXP_FP32_WR_EN   : out std_logic;  
      
      RQC_POW2_B_EXP_FP32			 : out std_logic_vector(31 downto 0);  
      RQC_POW2_B_EXP_FP32_WR_EN   : out std_logic;  
      
      -- CFF                      
      OFFSET_FP32                 : out std_logic_vector(31 downto 0);
      OFFSET_FP32_WR_EN           : out std_logic;
      
      POW2_LSB_FP32               : out std_logic_vector(31 downto 0);
      POW2_LSB_FP32_WR_EN         : out std_logic;
      
      ERR                         : out std_logic
      
      );
   
end calib_param_sequencer;


architecture rtl of calib_param_sequencer is
   
   -- Component declarations
   component sync_resetn
      port(
         ARESETN : in STD_LOGIC;
         SRESETN : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;
   
   subtype ram_info_index_type is unsigned(4 downto 0);  --Must hold RAM_INFO_LAST_INDEX
   
   -- Constant declarations
   constant SATURATION_THRESHOLD_INDEX          : ram_info_index_type   := to_unsigned(0, ram_info_index_type'length);
   constant NLC_LUT_PARAM_X_MIN_INDEX           : ram_info_index_type   := to_unsigned(1, ram_info_index_type'length);
   constant NLC_LUT_PARAM_X_RANGE_INDEX         : ram_info_index_type   := to_unsigned(2, ram_info_index_type'length);
   constant NLC_LUT_PARAM_LUT_SIZE_INDEX        : ram_info_index_type   := to_unsigned(3, ram_info_index_type'length);
   constant NLC_LUT_PARAM_LUT_START_ADD_INDEX   : ram_info_index_type   := to_unsigned(4, ram_info_index_type'length);
   constant NLC_LUT_PARAM_LUT_END_ADD_INDEX     : ram_info_index_type   := to_unsigned(5, ram_info_index_type'length);
   constant NLC_LUT_PARAM_LUT_FACTOR_INDEX      : ram_info_index_type   := to_unsigned(6, ram_info_index_type'length);
   constant NLC_LUT_PARAM_LUT_FACTOR_INV_INDEX  : ram_info_index_type   := to_unsigned(7, ram_info_index_type'length);
   constant RANGE_OFS_FP32_INDEX                : ram_info_index_type   := to_unsigned(8, ram_info_index_type'length);
   constant POW2_OFFSET_EXP_FP32_INDEX          : ram_info_index_type   := to_unsigned(9, ram_info_index_type'length);
   constant POW2_RANGE_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(10, ram_info_index_type'length);
   constant NLC_POW2_M_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(11, ram_info_index_type'length);
   constant NLC_POW2_B_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(12, ram_info_index_type'length);
   constant DELTA_TEMP_FP32_INDEX               : ram_info_index_type   := to_unsigned(13, ram_info_index_type'length);
   constant ALPHA_OFFSET_FP32_INDEX             : ram_info_index_type   := to_unsigned(14, ram_info_index_type'length);
   constant POW2_ALPHA_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(15, ram_info_index_type'length);
   constant POW2_BETA0_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(16, ram_info_index_type'length);
   constant POW2_KAPPA_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(17, ram_info_index_type'length);
   constant NUC_MULT_FACTOR_FP32_INDEX          : ram_info_index_type   := to_unsigned(18, ram_info_index_type'length);
   constant RQC_LUT_PARAM_X_MIN_INDEX           : ram_info_index_type   := to_unsigned(19, ram_info_index_type'length);
   constant RQC_LUT_PARAM_X_RANGE_INDEX         : ram_info_index_type   := to_unsigned(20, ram_info_index_type'length);
   constant RQC_LUT_PARAM_LUT_SIZE_INDEX        : ram_info_index_type   := to_unsigned(21, ram_info_index_type'length);
   constant RQC_LUT_PARAM_LUT_START_ADD_INDEX   : ram_info_index_type   := to_unsigned(22, ram_info_index_type'length);
   constant RQC_LUT_PARAM_LUT_END_ADD_INDEX     : ram_info_index_type   := to_unsigned(23, ram_info_index_type'length);
   constant RQC_LUT_PARAM_LUT_FACTOR_INDEX      : ram_info_index_type   := to_unsigned(24, ram_info_index_type'length);
   constant RQC_LUT_PARAM_LUT_FACTOR_INV_INDEX  : ram_info_index_type   := to_unsigned(25, ram_info_index_type'length);
   constant RQC_POW2_M_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(26, ram_info_index_type'length);
   constant RQC_POW2_B_EXP_FP32_INDEX           : ram_info_index_type   := to_unsigned(27, ram_info_index_type'length);
   constant OFFSET_FP32_INDEX                   : ram_info_index_type   := to_unsigned(28, ram_info_index_type'length);
   constant POW2_LSB_FP32_INDEX                 : ram_info_index_type   := to_unsigned(29, ram_info_index_type'length);
   constant RAM_INFO_LAST_INDEX                 : ram_info_index_type   := POW2_LSB_FP32_INDEX;
   
   constant RAM_INFO_READ_LATENCY : ram_info_index_type := to_unsigned(2, ram_info_index_type'length);   --Read latency is 2 clock cycles
   constant DDR_BLOCK_OFFSET : unsigned(23 downto 0) := to_unsigned(IMG_WIDTH_MAX * IMG_HEIGHT_MAX * 8, 24);   --PIXEL DATA is 8 bytes/pixel
   
   type read_state_type is (STANDBY, VERIFY_INDEX, READ_RAM);
   
   -- Signal declarations
   signal sresetn : std_logic;
   signal extracted_info_valid_i : std_logic;
   signal extracted_info_valid_prev : std_logic;
   signal extracted_block_index_i : cal_block_index_type;
   signal ram_block_offset_i : unsigned(RAM_BLOCK_OFFSET'range);
   signal pixel_data_base_addr_i : unsigned(PIXEL_DATA_BASE_ADDR'range);
   signal cal_block_index_max_i : cal_block_index_type;
   signal calib_block_index : cal_block_index_type;
   signal ddr_addr_offset_i : unsigned(DDR_ADDR_OFFSET'range);
   signal ram_info_base_addr : unsigned(RAM_RD_ADD'range);
   signal ram_info_addr_index : ram_info_index_type;
   signal ram_info_data_index : ram_info_index_type;
   signal ram_info : std_logic_vector(RAM_RD_DATA'range);
   signal output_en : std_logic;
   signal read_state : read_state_type;
   
   attribute KEEP: string;
   attribute KEEP of output_en : signal is "TRUE";
   attribute KEEP of ram_info_data_index : signal is "TRUE";
   attribute KEEP of ram_info : signal is "TRUE";
   
   
begin
   
   extracted_info_valid_i <= EXTRACTED_INFO_VALID;
   ram_block_offset_i <= unsigned(RAM_BLOCK_OFFSET);
   pixel_data_base_addr_i <= unsigned(PIXEL_DATA_BASE_ADDR);
   cal_block_index_max_i <= CAL_BLOCK_INDEX_MAX;
   
   U0: sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK);
   
   --------------------------------------------
   -- Read RAM process
   --------------------------------------------
   U1: process(CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            extracted_info_valid_prev <= '0';
            calib_block_index <= CAL_BLOCK_INDEX_0;
            ddr_addr_offset_i <= (others => '0');
            ram_info_base_addr <= (others => '0');
            RAM_RD_EN <= '0';
            RAM_RD_ADD <= (others => '0');
            ram_info_addr_index <= (others => '0');
            ram_info_data_index <= (others => '0');
            ram_info <= (others => '0');
            output_en <= '0';
            ERR <= '0';
            read_state <= STANDBY;
         else
            
            extracted_info_valid_prev <= extracted_info_valid_i;
            
            case read_state is
               when STANDBY =>
                  RAM_RD_EN <= '0';
                  ram_info_addr_index <= (others => '0');
                  ram_info_data_index <= (others => '0');
                  output_en <= '0';
                  ERR <= '0';
                  -- Wait for rising edge of EXTRACTED_INFO_VALID
                  if extracted_info_valid_i = '1' and extracted_info_valid_prev = '0' then
                     extracted_block_index_i <= EXTRACTED_BLOCK_INDEX;
                     read_state <= VERIFY_INDEX;
                  end if;
               
               when VERIFY_INDEX =>
                  if extracted_block_index_i <= cal_block_index_max_i then
                     calib_block_index <= extracted_block_index_i;
                     ddr_addr_offset_i <= resize(extracted_block_index_i * DDR_BLOCK_OFFSET, ddr_addr_offset_i'length);
                     ram_info_base_addr <= resize(extracted_block_index_i * ram_block_offset_i, ram_info_base_addr'length);
                  else
                     calib_block_index <= CAL_BLOCK_INDEX_0;
                     ddr_addr_offset_i <= resize(CAL_BLOCK_INDEX_0 * DDR_BLOCK_OFFSET, ddr_addr_offset_i'length);
                     ram_info_base_addr <= resize(CAL_BLOCK_INDEX_0 * ram_block_offset_i, ram_info_base_addr'length);
                     ERR <= '1';
                  end if;
                  read_state <= READ_RAM;
               
               when READ_RAM =>
                  -- RAM address handler
                  RAM_RD_EN <= '1';
                  RAM_RD_ADD <= std_logic_vector(resize(ram_info_base_addr + ram_info_addr_index, RAM_RD_ADD'length));
                  if ram_info_addr_index < RAM_INFO_LAST_INDEX then
                     ram_info_addr_index <= ram_info_addr_index + 1;
                  end if;
                  
                  -- RAM data handler
                  ram_info <= RAM_RD_DATA;
                  if ram_info_addr_index = RAM_INFO_READ_LATENCY+1 then    -- +1 because ram_info_addr_index is 1 clk cycle ahead of RAM_RD_ADD
                     output_en <= '1';
                     ram_info_data_index <= (others => '0');
                  elsif ram_info_addr_index > RAM_INFO_READ_LATENCY+1 then
                     if ram_info_data_index < RAM_INFO_LAST_INDEX then
                        ram_info_data_index <= ram_info_data_index + 1;
                     else
                        RAM_RD_EN <= '0';
                        output_en <= '0';
                        read_state <= STANDBY;
                     end if;
                  end if;
               
               when others =>
                  read_state <= STANDBY;
                  
            end case;
         end if;
      end if;
   end process;
   
   --------------------------------------------
   -- Output process
   --------------------------------------------
   U2: process(CLK)
   begin
      if rising_edge(CLK) then
         -- Reset all WR_EN by default
         SATURATION_THRESHOLD_WR_EN     <= '0';
         DDR_READ_START                 <= '0';
         NLC_LUT_PARAM_WR_EN            <= '0';
         RANGE_OFS_FP32_WR_EN           <= '0';
         POW2_OFFSET_EXP_FP32_WR_EN     <= '0';  
         POW2_RANGE_EXP_FP32_WR_EN      <= '0';  
         NLC_POW2_M_EXP_FP32_WR_EN      <= '0';  
         NLC_POW2_B_EXP_FP32_WR_EN      <= '0';  
         DELTA_TEMP_FP32_WR_EN          <= '0';
         ALPHA_OFFSET_FP32_WR_EN        <= '0';
         POW2_ALPHA_EXP_FP32_WR_EN      <= '0';  
         POW2_BETA0_EXP_FP32_WR_EN	    <= '0';  
         POW2_KAPPA_EXP_FP32_WR_EN	    <= '0';      
         NUC_MULT_FACTOR_FP32_WR_EN	    <= '0';
         RQC_LUT_PARAM_WR_EN            <= '0';
         RQC_LUT_PAGE_WR_EN             <= '0';
         RQC_POW2_M_EXP_FP32_WR_EN      <= '0';  
         RQC_POW2_B_EXP_FP32_WR_EN      <= '0';  
         OFFSET_FP32_WR_EN              <= '0';
         POW2_LSB_FP32_WR_EN            <= '0';
         
         -- Output corresponding param and its WR_EN
         if output_en = '1' then
            
            case ram_info_data_index is
               when SATURATION_THRESHOLD_INDEX => 
                  SATURATION_THRESHOLD <= ram_info;
                  SATURATION_THRESHOLD_WR_EN <= '1';
                  -- Update DDR_ADDR_OFFSET at the same time
                  DDR_ADDR_OFFSET <= std_logic_vector(ddr_addr_offset_i + pixel_data_base_addr_i);
                  DDR_READ_START <= '1';
                  
               when NLC_LUT_PARAM_X_MIN_INDEX => 
                  NLC_LUT_PARAM.x_min <= ram_info;
                  -- NLC_LUT_PARAM_WR_EN set once all NLC_LUT_PARAM is updated
                  
               when NLC_LUT_PARAM_X_RANGE_INDEX => 
                  NLC_LUT_PARAM.x_range <= ram_info;
                  -- NLC_LUT_PARAM_WR_EN set once all NLC_LUT_PARAM is updated
                  
               when NLC_LUT_PARAM_LUT_SIZE_INDEX => 
                  NLC_LUT_PARAM.lut_size <= ram_info;
                  -- NLC_LUT_PARAM_WR_EN set once all NLC_LUT_PARAM is updated
                  
               when NLC_LUT_PARAM_LUT_START_ADD_INDEX => 
                  NLC_LUT_PARAM.lut_start_add <= resize(unsigned(ram_info), NLC_LUT_PARAM.lut_start_add'length);
                  -- NLC_LUT_PARAM_WR_EN set once all NLC_LUT_PARAM is updated
                  
               when NLC_LUT_PARAM_LUT_END_ADD_INDEX => 
                  NLC_LUT_PARAM.lut_end_add <= resize(unsigned(ram_info), NLC_LUT_PARAM.lut_end_add'length);
                  -- NLC_LUT_PARAM_WR_EN set once all NLC_LUT_PARAM is updated
                  
               when NLC_LUT_PARAM_LUT_FACTOR_INDEX => 
                  NLC_LUT_PARAM.lut_factor <= ram_info;
                  -- NLC_LUT_PARAM_WR_EN set once all NLC_LUT_PARAM is updated
                  
               when NLC_LUT_PARAM_LUT_FACTOR_INV_INDEX => 
                  NLC_LUT_PARAM.lut_factor_inv <= ram_info;
                  NLC_LUT_PARAM_WR_EN <= '1';
                  
               when RANGE_OFS_FP32_INDEX => 
                  RANGE_OFS_FP32 <= ram_info;
                  RANGE_OFS_FP32_WR_EN <= '1';
                  
               when POW2_OFFSET_EXP_FP32_INDEX => 
                  POW2_OFFSET_EXP_FP32 <= ram_info;
                  POW2_OFFSET_EXP_FP32_WR_EN <= '1';
                  
               when POW2_RANGE_EXP_FP32_INDEX => 
                  POW2_RANGE_EXP_FP32 <= ram_info;
                  POW2_RANGE_EXP_FP32_WR_EN <= '1';
                  
               when NLC_POW2_M_EXP_FP32_INDEX => 
                  NLC_POW2_M_EXP_FP32 <= ram_info;
                  NLC_POW2_M_EXP_FP32_WR_EN <= '1';
                  
               when NLC_POW2_B_EXP_FP32_INDEX => 
                  NLC_POW2_B_EXP_FP32 <= ram_info;
                  NLC_POW2_B_EXP_FP32_WR_EN <= '1';
                  
               when DELTA_TEMP_FP32_INDEX => 
                  DELTA_TEMP_FP32 <= ram_info;
                  DELTA_TEMP_FP32_WR_EN <= '1';
                  
               when ALPHA_OFFSET_FP32_INDEX => 
                  ALPHA_OFFSET_FP32 <= ram_info;
                  ALPHA_OFFSET_FP32_WR_EN <= '1';
                  
               when POW2_ALPHA_EXP_FP32_INDEX => 
                  POW2_ALPHA_EXP_FP32 <= ram_info;
                  POW2_ALPHA_EXP_FP32_WR_EN <= '1';
                  
               when POW2_BETA0_EXP_FP32_INDEX => 
                  POW2_BETA0_EXP_FP32 <= ram_info;
                  POW2_BETA0_EXP_FP32_WR_EN <= '1';
                  
               when POW2_KAPPA_EXP_FP32_INDEX => 
                  POW2_KAPPA_EXP_FP32 <= ram_info;
                  POW2_KAPPA_EXP_FP32_WR_EN <= '1';
                  
               when NUC_MULT_FACTOR_FP32_INDEX => 
                  NUC_MULT_FACTOR_FP32 <= ram_info;
                  NUC_MULT_FACTOR_FP32_WR_EN <= '1';
                  
               when RQC_LUT_PARAM_X_MIN_INDEX => 
                  RQC_LUT_PARAM.x_min <= ram_info;
                  -- RQC_LUT_PARAM_WR_EN set once all RQC_LUT_PARAM is updated
                  
               when RQC_LUT_PARAM_X_RANGE_INDEX => 
                  RQC_LUT_PARAM.x_range <= ram_info;
                  -- RQC_LUT_PARAM_WR_EN set once all RQC_LUT_PARAM is updated
                  
               when RQC_LUT_PARAM_LUT_SIZE_INDEX => 
                  RQC_LUT_PARAM.lut_size <= ram_info;
                  -- RQC_LUT_PARAM_WR_EN set once all RQC_LUT_PARAM is updated
                  
               when RQC_LUT_PARAM_LUT_START_ADD_INDEX => 
                  RQC_LUT_PARAM.lut_start_add <= resize(unsigned(ram_info), RQC_LUT_PARAM.lut_start_add'length);
                  -- RQC_LUT_PARAM_WR_EN set once all RQC_LUT_PARAM is updated
                  
               when RQC_LUT_PARAM_LUT_END_ADD_INDEX => 
                  RQC_LUT_PARAM.lut_end_add <= resize(unsigned(ram_info), RQC_LUT_PARAM.lut_end_add'length);
                  -- RQC_LUT_PARAM_WR_EN set once all RQC_LUT_PARAM is updated
                  
               when RQC_LUT_PARAM_LUT_FACTOR_INDEX => 
                  RQC_LUT_PARAM.lut_factor <= ram_info;
                  -- RQC_LUT_PARAM_WR_EN set once all RQC_LUT_PARAM is updated
                  
               when RQC_LUT_PARAM_LUT_FACTOR_INV_INDEX => 
                  RQC_LUT_PARAM.lut_factor_inv <= ram_info;
                  RQC_LUT_PARAM_WR_EN <= '1';
                  -- Update RQC_LUT_PAGE_ID at the same time
                  RQC_LUT_PAGE_ID <= std_logic_vector(resize(calib_block_index, RQC_LUT_PAGE_ID'length));
                  RQC_LUT_PAGE_WR_EN <= '1';
                  
               when RQC_POW2_M_EXP_FP32_INDEX => 
                  RQC_POW2_M_EXP_FP32 <= ram_info;
                  RQC_POW2_M_EXP_FP32_WR_EN <= '1';
                  
               when RQC_POW2_B_EXP_FP32_INDEX => 
                  RQC_POW2_B_EXP_FP32 <= ram_info;
                  RQC_POW2_B_EXP_FP32_WR_EN <= '1';
                  
               when OFFSET_FP32_INDEX => 
                  OFFSET_FP32 <= ram_info;
                  OFFSET_FP32_WR_EN <= '1';
                  
               when POW2_LSB_FP32_INDEX => 
                  POW2_LSB_FP32 <= ram_info;
                  POW2_LSB_FP32_WR_EN <= '1';
                  
               when others => 
         
            end case;
         end if;
      end if;
   end process;

end rtl;
