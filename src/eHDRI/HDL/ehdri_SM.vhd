library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;
use work.img_header_define.all;

entity ehdri_SM is
   port(
      --clk and reset
      Clk_Data         : in std_logic; -- at 160 MHz
      AReset          : in std_logic;
      
      -- Hder AXI signals
      Hder_Axil_Mosi : out t_axi4_lite_mosi;
      Hder_Axil_Miso : in t_axi4_lite_miso;
      FPA_Img_Info : in img_info_type;
      
      -- Exposure Time
      ExpTime0 : in std_logic_vector(31 downto 0);
      ExpTime1 : in std_logic_vector(31 downto 0);
      ExpTime2 : in std_logic_vector(31 downto 0);
      ExpTime3 : in std_logic_vector(31 downto 0);
      
      -- Mem interface
      Mem_Address : out std_logic_vector(9 downto 0);
      Mem_Data : in std_logic_vector(1 downto 0);
      
      FPA_Exp_Info : out exp_info_type;
      EXP_Ctrl_Busy : in std_logic;
      Enable : in std_logic
      
      );
end ehdri_SM;

architecture implementation of ehdri_SM is
   attribute keep: string;
   signal fpa_img_info_i : img_info_type;
   attribute keep of fpa_img_info_i : signal is "TRUE";  
   
   -------------------------------------------------------------------------------
   -- Signal Declarations
   -------------------------------------------------------------------------------
   signal fpa_exp_info_i : exp_info_type;
   attribute keep of fpa_exp_info_i : signal is "TRUE";  
   signal mem_address_i : unsigned(9 downto 0);
   attribute keep of mem_address_i : signal is "TRUE";  
   signal exp_time_i : unsigned(31 downto 0);
   attribute keep of exp_time_i : signal is "TRUE";  
   signal max_exptime : unsigned(31 downto 0);
   signal min_exptime : unsigned(31 downto 0);
   signal sreset : std_logic;
   
   signal axil_mosi_i : t_axi4_lite_mosi;
   signal axil_miso_i : t_axi4_lite_miso;
   
   signal exp_feedbk_last : std_logic;
   signal exp_info_dval_last : std_logic;
   
   signal exp_indx_latch : std_logic_vector(FPA_Img_Info.exp_info.exp_indx'length-1 downto 0);
   signal exp_dval_latch : std_logic;
   
   type hder_write_state_t is (write_standby, write_info, wait_write_ready, wait_write_completed, wait_next_feedfbk );
   signal write_state : hder_write_state_t := write_standby;
   
   component sync_reset is
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1';
         CLK    : in STD_LOGIC
         );
   end component sync_reset;
   
   constant INDEX_EXPTIME0 : unsigned(1 downto 0) := "00";
   constant INDEX_EXPTIME1 : unsigned(1 downto 0) := "01";
   constant INDEX_EXPTIME2 : unsigned(1 downto 0) := "10";
   constant INDEX_EXPTIME3 : unsigned(1 downto 0) := "11";
   
begin
   U1: sync_reset
   port map(
      ARESET => AReset,
      SRESET => sreset,
      CLK => Clk_Data
      );
   
   fpa_img_info_i <= FPA_Img_Info;
   
   Mem_Address <= std_logic_vector(mem_address_i);
   FPA_Exp_Info <= fpa_exp_info_i;
   
   WRITE_DATA : process (Clk_Data)
   begin
      if rising_edge(Clk_Data) then 
         if sreset = '1' or Enable = '0' then
            fpa_exp_info_i.exp_time <= (others => '0');
            fpa_exp_info_i.exp_dval <= '0';
            fpa_exp_info_i.exp_indx <= x"00";
            mem_address_i <= "0000000000";
         else
            if EXP_Ctrl_Busy = '0' and fpa_exp_info_i.exp_dval = '0' then -- Busy only one clock low in exp time ctrl
               case (Mem_Data) is
                  when "00" => fpa_exp_info_i.exp_time <= unsigned(ExpTime0);
                  when "01" => fpa_exp_info_i.exp_time <= unsigned(ExpTime1);
                  when "10" => fpa_exp_info_i.exp_time <= unsigned(ExpTime2);
                  when "11" => fpa_exp_info_i.exp_time <= unsigned(ExpTime3);
                  when others => 
               end case;
               
               fpa_exp_info_i.exp_indx <= "000000" & Mem_Data;
               fpa_exp_info_i.exp_dval <= '1';
               mem_address_i <= mem_address_i + 1;
            elsif EXP_Ctrl_Busy = '1' then
               fpa_exp_info_i.exp_dval <= '0';
            end if;
         end if;
      end if;
   end process WRITE_DATA; 
   
   Hder_Axil_Mosi <= axil_mosi_i;
   axil_miso_i <= Hder_Axil_Miso;
   
   WRITE_HDER : process (Clk_Data)
   begin
      if rising_edge(Clk_Data) then 
         if sreset = '1' or Enable = '0' then
            axil_mosi_i.awvalid <= '0';
            axil_mosi_i.wvalid <= '0';
            axil_mosi_i.wstrb <= (others => '0');
            axil_mosi_i.bready <= '1';
            write_state <= write_standby;
            --exp_feedbk_last <= '0';
            exp_info_dval_last <= '0';
            --exp_dval_latch <= '0';
         else
            
            
            -- ENO: 10 ocobre 2016 : le FPA_Img_Info.exp_info.exp_dval peut devancer FPA_Img_Info.exp_feedbk (par exemple dans les scorpiomA) d'òu un latch 
            --if (FPA_Img_Info.exp_info.exp_dval = '1') then
            --   exp_indx_latch <= FPA_Img_Info.exp_info.exp_indx;
            --   exp_dval_latch <= '1';
            --end if;
            
            
            case write_state is
               when write_standby =>
                  --if FPA_Img_Info.exp_feedbk = '1' and exp_feedbk_last = '0' then
                  if FPA_Img_Info.exp_info.exp_dval = '1' then 
                     axil_mosi_i.awaddr <= x"FFFF" &  std_logic_vector(FPA_Img_Info.frame_id(7 downto 0)) &  std_logic_vector(resize(EHDRIExposureIndexAdd32, 8));
                    -- exp_feedbk_last <= '1';
                     write_state <= write_info;
                  end if;
                  --elsif exp_feedbk_last = '0' then
                  --   exp_feedbk_last <= FPA_Img_Info.exp_feedbk;
                  --end if;
               
               when write_info =>
                  --if exp_dval_latch = '1' and FPA_Img_Info.exp_info.exp_dval = '0' then
                  axil_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(FPA_Img_Info.exp_info.exp_indx), 32), EHDRIExposureIndexShift));
                  axil_mosi_i.wstrb <= EHDRIExposureIndexBWE;
                  write_state <= wait_write_ready;
                  --end if;
               
               when wait_write_ready =>
                  --exp_dval_latch <= '0';
                  if axil_miso_i.awready = '1' and axil_miso_i.wready = '1' then
                     axil_mosi_i.awvalid <= '1';
                     axil_mosi_i.wvalid <= '1';
                     write_state <= wait_write_completed;
                  end if;
               
               when wait_write_completed =>
                  axil_mosi_i.awvalid <= '0';
                  axil_mosi_i.wvalid <= '0';
                  axil_mosi_i.wstrb <= (others => '0');                  
                  if axil_miso_i.bvalid = '1' then
                     write_state <= wait_next_feedfbk;
                  end if;
               
               when wait_next_feedfbk =>
                  if FPA_Img_Info.exp_info.exp_dval = '0' then
                     write_state <= write_standby;
                     --exp_feedbk_last <= '0';
                     exp_info_dval_last <= '0';
                  end if;
               
               when others =>
               write_state <= write_standby;
            end case;
         end if;
      end if;
   end process WRITE_HDER; 
   
end implementation;
