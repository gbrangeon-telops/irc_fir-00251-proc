------------------------------------------------------------------
--!   @file : calib_block_sel
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

entity calib_block_sel is
   
   port( 
      ARESETN                     : in std_logic;
      CLK                         : in std_logic;  
      
      -- Config
      CAL_BLOCK_INDEX_MAX         : in cal_block_index_type;
      CALIB_BLOCK_INFO_ARRAY      : in calib_block_array_type;
      CALIB_BLOCK_INFO_DVAL       : in std_logic;
      
      -- Block selection
      CALIB_BLOCK_SEL_MODE        : in calib_block_sel_mode_type;
      FPA_IMG_INFO                : in img_info_type;
      FW_POSITION                 : in std_logic_vector(2 downto 0);
      NDF_POSITION                : in std_logic_vector(1 downto 0);
      
      -- Header
      FRAME_ID                    : out std_logic_vector(7 downto 0);
      HDER_INFO                   : out calib_hder_type;
      HDER_SEND_START             : out std_logic;
      
      ERR                         : out std_logic_vector(4 downto 0)
      
      );
   
end calib_block_sel;


architecture rtl of calib_block_sel is

   -- Component declarations
   component sync_resetn
      port(
         ARESETN : in STD_LOGIC;
         SRESETN : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;
   
   -- Error bit definitions
   constant ERR_INVALID_INDEX_FOUND : integer := 0;
   constant ERR_EXP_TIME_NOT_FOUND  : integer := 1;
   constant ERR_FW_POS_NOT_FOUND    : integer := 2;
   constant ERR_NDF_POS_NOT_FOUND   : integer := 3;
   constant ERR_INVALID_SEL_MODE    : integer := 4;
   
   type sel_state_type is (STANDBY, SEL_INDEX, WRITE_HEADER);
   
   -- Signal declarations
   signal sresetn                   : std_logic;
   signal error                     : unsigned(ERR'range);
   signal exp_dval_i                : std_logic;
   signal exp_dval_last             : std_logic;
   signal frame_id_i                : std_logic_vector(FRAME_ID'range);
   signal exposure_time             : std_logic_vector(calib_block_info_type.sel_value'range);
   signal fw_position_i             : std_logic_vector(calib_block_info_type.sel_value'range);
   signal ndf_position_i            : std_logic_vector(calib_block_info_type.sel_value'range);
   signal cal_block_index_max_i     : cal_block_index_type;
   signal calib_block_array         : calib_block_array_type;
   signal block_index_found         : cal_block_index_type;
   signal calib_block_sel_mode_i    : calib_block_sel_mode_type;
   signal sel_state                 : sel_state_type;
   
begin
   
   U0: sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK);
   
   --------------------------------------------
   -- State machine
   --------------------------------------------
   U1 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            ERR <= (others => '0');
            exp_dval_i <= '0';
            exp_dval_last <= '0';
            calib_block_array <= CALIB_BLOCK_ARRAY_TYPE_DEF;
            FRAME_ID <= (others => '0');
            HDER_INFO <= calib_block_array(0).hder_info;
            HDER_SEND_START <= '0';
            sel_state <= STANDBY;
         else
            
            exp_dval_i <= FPA_IMG_INFO.exp_info.exp_dval;
            exp_dval_last <= exp_dval_i;
            
            case sel_state is
               when STANDBY =>
                  cal_block_index_max_i <= CAL_BLOCK_INDEX_MAX;
                  calib_block_sel_mode_i <= CALIB_BLOCK_SEL_MODE;
                  frame_id_i <= std_logic_vector(FPA_IMG_INFO.frame_id(7 downto 0));
                  exposure_time <= std_logic_vector(resize(FPA_IMG_INFO.exp_info.exp_time, exposure_time'length));
                  fw_position_i <= resize(FPA_IMG_INFO.exp_info.exp_indx, fw_position_i'length);
                  ndf_position_i <= resize(NDF_POSITION, ndf_position_i'length);
                  HDER_SEND_START <= '0';
                  if CALIB_BLOCK_INFO_DVAL = '1' then
                     calib_block_array <= CALIB_BLOCK_INFO_ARRAY;
                  end if;
                  if exp_dval_i = '1' and exp_dval_last = '0' then
                     sel_state <= SEL_INDEX;
                  end if;
               
               when SEL_INDEX =>
                  -- Delay for block index selection
                  sel_state <= WRITE_HEADER;
               
               when WRITE_HEADER =>
                  -- Verify index is valid
                  if block_index_found > cal_block_index_max_i or error /= to_unsigned(0, error'length) then
                     HDER_INFO <= calib_block_array(0).hder_info;
                     ERR <= std_logic_vector(error or resize((ERR_INVALID_INDEX_FOUND => '1'), error'length));     -- ERR output is latched until next header
                  else
                     HDER_INFO <= calib_block_array(to_integer(block_index_found)).hder_info;
                     ERR <= std_logic_vector(error);     -- ERR output is latched until next header
                  end if;
                  FRAME_ID <= frame_id_i;
                  HDER_SEND_START <= '1';
                  sel_state <= STANDBY;
               
               when others =>
                  sel_state <= STANDBY;
                  
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------
   -- Block index selection
   --------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            error <= (others => '0');
            block_index_found <= CAL_BLOCK_INDEX_0;
         else
            -- Determine index depending on mode
            case calib_block_sel_mode_i is
               when CBSM_USER_SEL_0 =>
                  block_index_found <= CAL_BLOCK_INDEX_0;
                  error <= (others => '0');
               when CBSM_USER_SEL_1 =>
                  block_index_found <= CAL_BLOCK_INDEX_1;
                  error <= (others => '0');
               when CBSM_USER_SEL_2 =>
                  block_index_found <= CAL_BLOCK_INDEX_2;
                  error <= (others => '0');
               when CBSM_USER_SEL_3 =>
                  block_index_found <= CAL_BLOCK_INDEX_3;
                  error <= (others => '0');
               when CBSM_USER_SEL_4 =>
                  block_index_found <= CAL_BLOCK_INDEX_4;
                  error <= (others => '0');
               when CBSM_USER_SEL_5 =>
                  block_index_found <= CAL_BLOCK_INDEX_5;
                  error <= (others => '0');
               when CBSM_USER_SEL_6 =>
                  block_index_found <= CAL_BLOCK_INDEX_6;
                  error <= (others => '0');
               when CBSM_USER_SEL_7 =>
                  block_index_found <= CAL_BLOCK_INDEX_7;
                  error <= (others => '0');
               
               when CBSM_EXPOSURE_TIME =>
                  if exposure_time = calib_block_array(0).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_0;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(1).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_1;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(2).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_2;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(3).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_3;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(4).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_4;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(5).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_5;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(6).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_6;
                     error <= (others => '0');
                  elsif exposure_time = calib_block_array(7).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_7;
                     error <= (others => '0');
                  else
                     block_index_found <= CAL_BLOCK_INDEX_0;
                     error <= (ERR_EXP_TIME_NOT_FOUND => '1', others => '0');
                  end if;
               
               when CBSM_FW_POSITION =>
                  if fw_position_i = calib_block_array(0).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_0;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(1).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_1;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(2).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_2;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(3).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_3;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(4).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_4;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(5).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_5;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(6).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_6;
                     error <= (others => '0');
                  elsif fw_position_i = calib_block_array(7).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_7;
                     error <= (others => '0');
                  else
                     block_index_found <= CAL_BLOCK_INDEX_0;
                     error <= (ERR_FW_POS_NOT_FOUND => '1', others => '0');
                  end if;
               
               when CBSM_NDF_POSITION =>
                  if ndf_position_i = calib_block_array(0).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_0;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(1).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_1;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(2).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_2;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(3).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_3;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(4).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_4;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(5).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_5;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(6).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_6;
                     error <= (others => '0');
                  elsif ndf_position_i = calib_block_array(7).sel_value then
                     block_index_found <= CAL_BLOCK_INDEX_7;
                     error <= (others => '0');
                  else
                     block_index_found <= CAL_BLOCK_INDEX_0;
                     error <= (ERR_NDF_POS_NOT_FOUND => '1', others => '0');
                  end if;
               
               when others => 
                  block_index_found <= CAL_BLOCK_INDEX_0;
                  error <= (ERR_INVALID_SEL_MODE => '1', others => '0');
               
            end case;
            
         end if;
      end if;
   end process;
   
end rtl;
