------------------------------------------------------------------
--!   @file : adc_readout
--!   @brief
--!   @details
--!
--!   $Rev: 20830 $
--!   $Author: odionne $
--!   $Date: 2017-09-01 15:29:17 -0400 (ven., 01 sept. 2017) $
--!   $Id: adc_readout.vhd 20830 2017-09-01 19:29:17Z odionne $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/ADCReadout/HDL/adc_readout_generic.vhd $
------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.tel2000.all;
use work.img_header_define.all;

entity adc_readout is
   port(
      ARESET            : in std_logic;
      
      CLK               : in std_logic;
      CLK_DATA          : in std_logic;
      
      ENABLE            : in std_logic;
      
      IMG_INFO          : in img_info_type; -- CLK_DATA domain
      
      -- conversion parameters sent by the µblaze
      ADC_CALIB_R       : in std_logic_vector(31 downto 0);
      ADC_CALIB_Q       : in std_logic_vector(31 downto 0);
      
      -- ADC value sent by the AD787x controler
      ADC_DVAL	  	      : in std_logic;
      ADC_DATA	         : in std_logic_vector(15 downto 0); -- raw value from adc (up to 16 bit samples)
      
      VALUE_OUT         : out std_logic_vector(15 downto 0); -- average of 16 values in mV
      DVAL_OUT	         : out std_logic;
      
      -- fast header data
      ADC_RDOUT_MOSI    : out t_axi4_lite_mosi;
      ADC_RDOUT_MISO    : in t_axi4_lite_miso
      );
end adc_readout;


architecture rtl of adc_readout is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;  
   
   component double_sync
      generic(
         INIT_VALUE : BIT := '0');
      port(
         D : in STD_LOGIC;
         Q : out STD_LOGIC;
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC);
   end component; 
   
   component gh_edge_det 
      port(
         clk : in STD_LOGIC;
         rst : in STD_LOGIC;
         D   : in STD_LOGIC;
         re  : out STD_LOGIC; -- rising edge (need sync source at D)
         fe  : out STD_LOGIC; -- falling edge (need sync source at D)
         sre : out STD_LOGIC; -- sync'd rising edge
         sfe : out STD_LOGIC  -- sync'd falling edge
         );
   end component;
   
   component data_cdc_sync
      port(
         ARESET : in std_logic;
         D : in std_logic_vector;
         WR : in std_logic;
         Q : out std_logic_vector;
         DVAL: out std_logic;
         WCLK : in std_logic;
         RCLK : in std_logic;
         ERR : out std_logic
         );
   end component;
   
   signal sreset	                  : std_logic;
   
   signal axil_mosi_i : t_axi4_lite_mosi;
   signal axil_miso_i : t_axi4_lite_miso;
   
   type hder_write_state_t is (write_standby, wait_write_ready, wait_write_completed, write_finish );
   signal write_state : hder_write_state_t := write_standby;
   
   
   constant running_sum_size    : integer := 21; --1 pour bit signer, 4 pour SR de 16
   signal running_sum          : signed(running_sum_size-1 downto 0);
   signal running_sum_hold          : signed(running_sum_size-1 downto 0);
   signal delta               : signed(16 downto 0);
   type data_shift_register is array (16 downto 1) of signed(16 downto 0);
   signal shift_register        : data_shift_register;
   
   signal adc_calib_q_S16Q4_i       : signed(20 downto 0);
   signal adc_calib_r_S3Q16_i       : signed(19 downto 0);
   
   signal millivolt_data_S15Q16 : signed(31 downto 0);
   signal millivolt_data_out : std_logic_vector(15 downto 0);
   
   signal raw_data_S16Q4 : signed(20 downto 0);
   signal temp_S16Q4 : signed(20 downto 0);
   signal product_SS19Q20 : signed(40 downto 0);
   
   signal millivolt_data_out_sync : std_logic_vector(15 downto 0);
   signal millivolt_data_out_sync_hold : std_logic_vector(15 downto 0);
   signal dout_valid_sync : std_logic;
   
   signal adc_dval_i : std_logic;
   signal adc_data_i : std_logic_vector(15 downto 0); -- raw value from adc
   
   signal new_adc_data : std_logic;
   signal new_sum_data : std_logic;
   signal dout_valid : std_logic;
   signal start_transaction : std_logic;
   
   signal frame_id_i : std_logic_vector(31 downto 0);
   
   signal int_sync : std_logic;
   
   signal cdc_err : std_logic;
   
   type state_type is (IDLE, APPLY_OFFSET, APPLY_GAIN, FINISH);
   signal conv_state : state_type := IDLE;
   
   attribute dont_touch : string; 
   attribute dont_touch of start_transaction : signal is "true";
   attribute dont_touch of millivolt_data_out : signal is "true";
   attribute dont_touch of raw_data_S16Q4 : signal is "true";
   attribute dont_touch of temp_S16Q4 : signal is "true";
   attribute dont_touch of product_SS19Q20 : signal is "true";
   attribute dont_touch of adc_calib_q_S16Q4_i : signal is "true";
   attribute dont_touch of adc_calib_r_S3Q16_i : signal is "true";
   attribute dont_touch of running_sum : signal is "true";
   attribute dont_touch of dout_valid : signal is "true";
   attribute dont_touch of adc_data_i : signal is "true";
   attribute dont_touch of adc_dval_i : signal is "true";
   attribute dont_touch of axil_mosi_i : signal is "true";
   attribute dont_touch of axil_miso_i : signal is "true";
   attribute dont_touch of dout_valid_sync : signal is "true";
   attribute dont_touch of write_state : signal is "true";
   attribute dont_touch of IMG_INFO : signal is "true";
   attribute dont_touch of frame_id_i : signal is "true";
   
begin
   
   process(CLK)
   begin
      if rising_edge(CLK) then 
         adc_calib_q_S16Q4_i <= signed('0' & ADC_CALIB_Q(19 downto 0));
         adc_calib_r_S3Q16_i <= signed(ADC_CALIB_R(19 downto 0));
         adc_dval_i <= ADC_DVAL;
         adc_data_i <= std_logic_vector(resize(unsigned(ADC_DATA),adc_data_i'length));
      end if;
   end process;
   
   millivolt_data_out <= std_logic_vector(millivolt_data_S15Q16(31 downto 16));
   
   VALUE_OUT <= millivolt_data_out;
   DVAL_OUT <= dout_valid;
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   running_sum_process : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            running_sum <= (others => '0');
            new_sum_data <= '0';
         else
            if new_adc_data = '1' then
               running_sum <= running_sum + delta;
               new_sum_data <= '1';
            else
               new_sum_data <= '0';
            end if;
         end if;
         
      end if;
   end process;
   
   shift_reg_process : process(CLK)
      variable data_signed_ext : signed(16 downto 0);
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            shift_register <= (others => (others => '0'));
            new_adc_data <= '0';
         else
            if adc_dval_i = '1' then
               data_signed_ext := signed("0" & adc_data_i);
               shift_register(16 downto 2) <= shift_register(15 downto 1);
               shift_register(1) <= data_signed_ext;
               
               -- compute the increment to the running sum
               delta <= data_signed_ext - shift_register(16);
               new_adc_data <= '1';
            else
               new_adc_data <= '0';
            end if;
         end if;
         
      end if;
   end process;
   
   --sync_INT : double_sync port map(D => IMG_INFO.exp_feedbk, Q => int_sync, RESET => sreset, CLK => CLK);
   
   conversion_trigger : gh_edge_det
   port map (
      clk => CLK_DATA,
      rst => ARESET,
      D => IMG_INFO.exp_feedbk,
      re => open,
      fe => open,
      sre => start_transaction, 
      sfe => open
   );
   
   conversion_SM : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            millivolt_data_S15Q16 <= (others => '0');
         else
            if new_sum_data = '1' then
               running_sum_hold <= running_sum(running_sum_size-1 downto 0);
            end if;
            
            case conv_state is
               when IDLE =>
                  dout_valid <= '0';
                  if new_sum_data = '1' then
                     raw_data_S16Q4 <= resize(running_sum,raw_data_S16Q4'length);--running_sum_hold;
                     conv_state <= APPLY_OFFSET;
                  end if;
               
               when APPLY_OFFSET =>
                  
                  temp_S16Q4 <= raw_data_S16Q4 - adc_calib_q_S16Q4_i;
                  conv_state <= APPLY_GAIN;
               
               when APPLY_GAIN =>
                  
                  product_SS19Q20 <= temp_S16Q4 * adc_calib_r_S3Q16_i;
                  conv_state <= FINISH;
               
               when FINISH =>
                  
                  millivolt_data_S15Q16 <= product_SS19Q20(39) & product_SS19Q20(34 downto 4);
                  dout_valid <= '1';
                  conv_state <= IDLE;
               
            end case;
         end if;
         
      end if;
   end process;
   
   sync_data_out : data_cdc_sync
   port map (
      ARESET => ARESET,
      D => millivolt_data_out,
      WR => dout_valid,
      Q => millivolt_data_out_sync,
      DVAL => dout_valid_sync,
      WCLK => CLK,
      RCLK => CLK_DATA,
      ERR => cdc_err
      );
   
   ADC_RDOUT_MOSI <= axil_mosi_i;
   axil_miso_i <= ADC_RDOUT_MISO;
   
   process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then 
         frame_id_i <= std_logic_vector(IMG_INFO.frame_id);
      end if;
   end process;
   
   header_write_SM : process(CLK_DATA)     
   begin
      if rising_edge(CLK_DATA) then 
         if sreset = '1' or ENABLE = '0' then
            axil_mosi_i.awvalid <= '0';
            axil_mosi_i.wvalid <= '0';
            axil_mosi_i.wstrb <= (others => '0');
            axil_mosi_i.bready <= '1';
            write_state <= write_standby;
         else
            if dout_valid_sync = '1' then
               millivolt_data_out_sync_hold <= millivolt_data_out_sync;
            end if;
            
            case write_state is
               when write_standby =>
                  if start_transaction = '1' then
                     axil_mosi_i.awaddr <= x"FFFF" & frame_id_i(7 downto 0) &  std_logic_vector(resize(ADCReadoutAdd32, 8));
                     axil_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(millivolt_data_out_sync_hold), 32), ADCReadoutShift));
                     axil_mosi_i.wstrb <= ADCReadoutBWE;
                     write_state <= wait_write_ready;
                  end if;
                 
               when wait_write_ready =>
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
                     write_state <= write_finish;
                  end if;
               
               when write_finish =>
                  if dout_valid_sync = '0' then
                     write_state <= write_standby;
                  end if;
               
               when others =>
               write_state <= write_standby;
            end case;
         end if;
      end if;
   end process; 
   
end rtl;

