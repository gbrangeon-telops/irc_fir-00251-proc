------------------------------------------------------------------
--!   @file : pelicanD_core_dummy
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
library common_HDL;
use work.tel2000.all;
use work.FPA_define.all;
use work.fpa_common_pkg.all;

entity pelicanD_core_dummy is
   port(
      
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      FPA_TRIG          : in std_logic;  
      
      INTF_CFG_FOR_SIM  : in fpa_intf_cfg_type;
      FPA_INT           : out std_logic;	
      
      TX_DATA           : out std_logic_vector(7 downto 0);
      TX_AFULL          : in std_logic;
      TX_DVAL           : out std_logic;
      TX_EMPTY          : out std_logic;
      
      RX_DVAL           : in std_logic;
      RX_RD_EN          : out std_logic;
      RX_EMPTY          : in std_logic;
      RX_DATA           : in std_logic_vector(7 downto 0);
      
      DATA_EN           : out std_logic;
      FRAME_VALID       : in  std_logic;        
      
      
      SCD_DUMMY_CFG     : out fpa_intf_cfg_type;
      CMD_ERR           : out std_logic
      );
   
end pelicanD_core_dummy;

architecture rtl of pelicanD_core_dummy is
   constant temp_pos : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(65000, 16));
   constant temp_neg : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(10000, 16));
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   type cmd_fsm_type is (wait_cmd_hder_st, rd_rx_fifo_st, decode_byte_st, check_cmd_st, fpa_temp_cmd_st, pause_st, resp_en_st, resp_end_st);
   type com_data_array_type  is array (0 to SCD_LONGEST_CMD_BYTES_NUM) of std_logic_vector(7 downto 0);
   type resp_gen_fsm_type is (idle,failure_resp_st, success_resp_st, temp_resp_st);
   type int_gen_fsm_type is (idle, int_dly_st, int_gen_st, pause_st);
   signal resp_gen_fsm            : resp_gen_fsm_type;
   signal cmd_fsm                 : cmd_fsm_type;
   signal cmd_data                : com_data_array_type;
   signal sreset                  : std_logic;
   signal rx_data_cnt             : unsigned(15 downto 0);
   signal rx_data_total           : unsigned(15 downto 0);
   signal cmd_done                : std_logic;
   signal cmd_hder                : std_logic_vector(SCD_CMD_HDER'range);
   signal cmd_id                  : std_logic_vector(SCD_INT_CMD_ID'range);
   signal cmd_payload             : std_logic_vector(15 downto 0);
   signal cmd_dcnt                : unsigned(7 downto 0);
   signal tx_data_i               : std_logic_vector(7 downto 0);
   signal rx_rd_en_i              : std_logic;
   signal found_scd_op_cmd        : std_logic;
   signal found_scd_int_cmd       : std_logic;
   signal found_scd_temp_cmd      : std_logic;
   signal found_scd_diag_cmd      : std_logic;
   signal decode_cmd_en           : std_logic;
   signal cmd_err_i               : std_logic;
   signal dly_cnt                 : unsigned(15 downto 0);
   signal resp_en                 : std_logic;
   signal resp_done               : std_logic;
   signal tx_checksum             : unsigned(7 downto 0);
   signal tx_byte_cnt             : unsigned(7 downto 0);
   signal scd_op_reserved_5_3     : std_logic_vector(23 downto 0);
   signal scd_op_Tframe           : std_logic_vector(23 downto 0);
   signal scd_op_display_mode     : std_logic_vector(3 downto 0);
   signal scd_op_ms_sync          : std_logic;
   signal scd_op_left_rigth       : std_logic;
   signal scd_op_up_down          : std_logic;
   signal scd_op_reserved_20      : std_logic_vector(5 downto 0);
   signal scd_int_reserved_5_3    : std_logic_vector(23 downto 0);
   signal scd_diag_reserved_0     : std_logic_vector(4 downto 0);
   signal scd_diag_reserved_15_1  : com_data_array_type;
   signal cnt                     : unsigned(31 downto 0);
   signal int_gen_fsm             : int_gen_fsm_type;
   signal fpa_int_i               : std_logic;
   signal scd_dummy_cfg_i         : fpa_intf_cfg_type;
   signal scd_at_least_one_cfg_received : std_logic;
   signal frame_valid_last        : std_logic;
   
begin
   
   TX_DATA <= tx_data_i;
   RX_RD_EN <= rx_rd_en_i;
   CMD_ERR <= cmd_err_i;
   SCD_DUMMY_CFG <= scd_dummy_cfg_i;
   FPA_INT <= fpa_int_i;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
      );    
   
   --------------------------------------------------  
   -- reception des commandes                                
   --------------------------------------------------
   U2 : process(CLK)
      variable temp_diode : unsigned(15 downto 0);
      variable temp_gnd   : unsigned(15 downto 0);
      
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then  
            cmd_fsm <= wait_cmd_hder_st;
            rx_data_cnt <= (others => '0');
            cmd_err_i <= '0';
            rx_rd_en_i <= '0';
            cmd_done <= '0';
            cmd_dcnt <= (others => '0');
            cmd_err_i <= '0'; 
            found_scd_op_cmd <= '0';
            found_scd_int_cmd <= '0';
            found_scd_diag_cmd <= '0';
            found_scd_temp_cmd <= '0';
            decode_cmd_en <= '0';
         else
            
            rx_rd_en_i <= not RX_EMPTY; -- par defaut
            
            case cmd_fsm is               
               
               when wait_cmd_hder_st =>   -- on cherche l'entête du header et on se synchronise dessus 
                  found_scd_op_cmd <= '0';
                  found_scd_int_cmd <= '0';
                  found_scd_diag_cmd <= '0';
                  found_scd_temp_cmd <= '0';
                  cmd_err_i <= '0';
                  rx_data_cnt <= to_unsigned(1,rx_data_cnt'length);
                  rx_data_total <= (others => '1'); -- fait expres. Valeur mise à jour dans l'état decode_byte_st 
                  cmd_done <= '1';
                  decode_cmd_en <= '0';
                  dly_cnt <= (others => '0');
                  resp_en <= '0';
                  for ii in 0 to SCD_LONGEST_CMD_BYTES_NUM loop
                     cmd_data(ii) <= (others =>'0');    -- fait expres pour verifier que les données rentrent bien
                  end loop;
                  
                  if RX_DVAL = '1' then                       
                     if  RX_DATA = SCD_CMD_HDER then
                        cmd_fsm <= decode_byte_st;
                        cmd_hder <= RX_DATA;
                        rx_data_cnt <= to_unsigned(2,rx_data_cnt'length);
                     else
                        cmd_err_i <= '1';  
                     end if;
                  end if;
               
               when decode_byte_st =>
                  cmd_done <= '0';
                  if RX_DVAL = '1' then
                     rx_data_cnt <= rx_data_cnt + 1;                   
                     if rx_data_cnt = 1 then                         -- Header
                        cmd_hder <= RX_DATA;
                     elsif rx_data_cnt = 2 then                      -- id
                        cmd_id(7 downto 0) <= RX_DATA;
                     elsif rx_data_cnt = 3 then                      -- id
                        cmd_id(15 downto 8) <= RX_DATA;
                     elsif rx_data_cnt = 4 then                      -- payload
                        cmd_payload(7 downto 0) <= RX_DATA;
                     elsif rx_data_cnt = 5 then                      -- payload
                        cmd_payload(15 downto 8) <= RX_DATA;
                        rx_data_total <=  unsigned(RX_DATA & cmd_payload(7 downto 0)) + SCD_CMD_OVERHEAD_BYTES_NUM;
                        cmd_dcnt <= (others => '0');
                     elsif rx_data_cnt = rx_data_total then          -- checksum                                               
                        cmd_fsm <= check_cmd_st;                        
                     else                                            -- data
                        cmd_data(to_integer(cmd_dcnt)) <= RX_DATA;
                        cmd_dcnt <= cmd_dcnt + 1;
                     end if;                  
                  end if; 
               
               when check_cmd_st =>   
                  rx_rd_en_i <= '0';   
                  if cmd_hder = SCD_CMD_HDER then 
                     if cmd_id = SCD_OP_CMD_ID then
                        decode_cmd_en <= '1';
                        cmd_fsm <= pause_st;
                        found_scd_op_cmd <= '1';
                        --cmd_err_i <= '1';
                     elsif cmd_id = SCD_INT_CMD_ID then
                        decode_cmd_en <= '1';
                        cmd_fsm <= pause_st;
                        found_scd_int_cmd <= '1';
                     elsif cmd_id = SCD_DIAG_CMD_ID then
                        decode_cmd_en <= '1';
                        cmd_fsm <= pause_st;
                        found_scd_diag_cmd <= '1';
                     elsif cmd_id = SCD_TEMP_CMD_ID then                        
                        cmd_fsm <= pause_st;
                        found_scd_temp_cmd <= '1';
                     else
                        cmd_err_i <= '1';
                     end if;                     
                  else
                     cmd_err_i <= '1';                     
                  end if;
                  cmd_fsm <= pause_st;
               
               when pause_st =>              
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt = 4_400 then  -- 55 usec environ
                     cmd_fsm <= resp_en_st; 
                  end if;
               
               when resp_en_st => 
                  resp_en <= '1';
                  if resp_done = '0' then 
                     cmd_fsm <= resp_end_st; 
                  end if;
               
               when resp_end_st =>
                  resp_en <= '0';
                  if resp_done = '1' then 
                     cmd_fsm <= wait_cmd_hder_st; 
                  end if;
               
               when others =>
               
            end case;  
            
            
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------  
   -- envoi des reponses                               
   --------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            resp_gen_fsm <= idle;
            tx_checksum <= (others => '0');
            resp_done <= '0';
            TX_DVAL <= '0';
            tx_data_i <= (others => '0');
            
         else
            
            case resp_gen_fsm is
               
               when idle  =>
                  resp_done <= '1'; 
                  tx_checksum <= (others => '0');
                  tx_byte_cnt <= to_unsigned(1, tx_byte_cnt'length); --
                  TX_DVAL <= '0';
                  tx_data_i <= (others => '0');
                  if resp_en = '1' then
                     resp_done <= '0';
                     if cmd_err_i = '1' then 
                        resp_gen_fsm <= failure_resp_st;
                     else
                        if cmd_id = SCD_TEMP_CMD_ID then 
                           resp_gen_fsm <= temp_resp_st;
                        else
                           resp_gen_fsm <= success_resp_st;
                        end if;
                     end if;
                  end if;
               
               when success_resp_st =>             
                  if TX_AFULL = '0' then
                     TX_DVAL <= '1'; 
                     tx_byte_cnt <= tx_byte_cnt + 1;
                     tx_checksum <= tx_checksum + unsigned(tx_data_i); 
                     if    tx_byte_cnt = 1  then tx_data_i <= SCD_COM_RESP_HDER;                     
                     elsif tx_byte_cnt = 2  then tx_data_i <= cmd_id(7 downto 0);                     
                     elsif tx_byte_cnt = 3  then tx_data_i <= cmd_id(15 downto 8);                  
                     elsif tx_byte_cnt = 4  then tx_data_i <= x"00";                 
                     elsif tx_byte_cnt = 5  then tx_data_i <= x"00"; 
                     elsif tx_byte_cnt = 6  then tx_data_i <= std_logic_vector(unsigned(not std_logic_vector(tx_checksum)) + 1);                         
                     else
                        TX_DVAL <= '0';
                        resp_gen_fsm <= idle;
                     end if;
                  else
                     TX_DVAL <= '0';
                  end if;
               
               when failure_resp_st =>             
                  if TX_AFULL = '0' then
                     TX_DVAL <= '1'; 
                     tx_byte_cnt <= tx_byte_cnt + 1;
                     tx_checksum <= tx_checksum + unsigned(tx_data_i); 
                     if    tx_byte_cnt = 1  then tx_data_i <= SCD_COM_RESP_HDER;                     
                     elsif tx_byte_cnt = 2  then tx_data_i <= x"FF";                     
                     elsif tx_byte_cnt = 3  then tx_data_i <= x"FF";                  
                     elsif tx_byte_cnt = 4  then tx_data_i <= x"04";                 
                     elsif tx_byte_cnt = 5  then tx_data_i <= x"00";     
                     elsif tx_byte_cnt = 6  then tx_data_i <= x"00"; 
                     elsif tx_byte_cnt = 7  then tx_data_i <= x"00"; 
                     elsif tx_byte_cnt = 8  then tx_data_i <= x"00"; 
                     elsif tx_byte_cnt = 9  then tx_data_i <= x"00"; 
                     elsif tx_byte_cnt = 10 then tx_data_i <= std_logic_vector(unsigned(not std_logic_vector(tx_checksum)) + 1);                         
                     else
                        TX_DVAL <= '0';
                        resp_gen_fsm <= idle;
                     end if;
                  else
                     TX_DVAL <= '0';
                  end if;
               
               when temp_resp_st =>
                  if TX_AFULL = '0' then
                     TX_DVAL <= '1'; 
                     tx_byte_cnt <= tx_byte_cnt + 1;
                     tx_checksum <= tx_checksum + unsigned(tx_data_i); 
                     if    tx_byte_cnt = 1   then tx_data_i <= SCD_COM_RESP_HDER;                     
                     elsif tx_byte_cnt = 2   then tx_data_i <= x"21";                     
                     elsif tx_byte_cnt = 3   then tx_data_i <= x"80";                  
                     elsif tx_byte_cnt = 4   then tx_data_i <= x"06";                 
                     elsif tx_byte_cnt = 5   then tx_data_i <= x"00";     
                     elsif tx_byte_cnt = 6   then tx_data_i <= temp_pos(7 downto 0); 
                     elsif tx_byte_cnt = 7   then tx_data_i <= temp_pos(15 downto 8); 
                     elsif tx_byte_cnt = 8   then tx_data_i <= temp_neg(7 downto 0);  
                     elsif tx_byte_cnt = 9   then tx_data_i <= temp_neg(15 downto 8);
                     elsif tx_byte_cnt = 10  then tx_data_i <= x"00";
                     elsif tx_byte_cnt = 11  then tx_data_i <= x"00";
                     elsif tx_byte_cnt = 12  then tx_data_i <= std_logic_vector(unsigned(not std_logic_vector(tx_checksum)) + 1);                         
                     else
                        TX_DVAL <= '0';
                        resp_gen_fsm <= idle;
                     end if;
                  else
                     TX_DVAL <= '0';
                  end if;
                  
               
               when others =>                  
               
            end case;        
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------  
   -- decodage des commandes                                 
   --------------------------------------------------
   U4 : process(CLK)      
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            scd_at_least_one_cfg_received  <= '0';
            
         else                          
            
            if decode_cmd_en = '1' then               
               scd_dummy_cfg_i.scd_misc <= INTF_CFG_FOR_SIM.SCD_MISC;       
               scd_dummy_cfg_i.comn.fpa_diag_mode  <= '1';  
               scd_dummy_cfg_i.comn.fpa_diag_type  <= TELOPS_DIAG_DEGR; 
               
               case cmd_id is          
                  
                  when SCD_OP_CMD_ID =>        -- decodage cmd operationnelle             
                     scd_dummy_cfg_i.scd_int.scd_int_time     <= resize(unsigned(cmd_data(2)&cmd_data(1)&cmd_data(0)), scd_dummy_cfg_i.scd_int.scd_int_time'length);                  
                     scd_op_reserved_5_3                      <= cmd_data(5)&cmd_data(4)&cmd_data(3);                                                                            
                     scd_dummy_cfg_i.scd_op.scd_ystart        <= resize(unsigned(cmd_data(7)&cmd_data(6))  , scd_dummy_cfg_i.scd_op.scd_ystart'length);        
                     scd_dummy_cfg_i.scd_op.scd_ysize         <= resize(unsigned(cmd_data(9)&cmd_data(8))  , scd_dummy_cfg_i.scd_op.scd_ysize'length);        
                     scd_dummy_cfg_i.scd_op.scd_xsize         <= resize(unsigned(cmd_data(11)&cmd_data(10)), scd_dummy_cfg_i.scd_op.scd_xsize'length); 
                     scd_dummy_cfg_i.scd_op.scd_xstart        <= resize(unsigned(cmd_data(13)&cmd_data(12)), scd_dummy_cfg_i.scd_op.scd_xstart'length);                   
                     scd_dummy_cfg_i.scd_op.scd_hder_disable  <= cmd_data(14)(7);
                     scd_dummy_cfg_i.scd_op.scd_diode_bias    <= cmd_data(14)(6 downto 3);               
                     scd_dummy_cfg_i.scd_op.scd_gain          <= resize(cmd_data(14)(2 downto 0), scd_dummy_cfg_i.scd_op.scd_gain'length);                  
                     scd_op_Tframe                            <= cmd_data(17)&cmd_data(16)&cmd_data(15);                  
                     scd_dummy_cfg_i.scd_op.scd_out_chn       <= cmd_data(18)(7);
                     scd_op_display_mode                      <= cmd_data(18)(6 downto 3);
                     scd_op_ms_sync                           <= cmd_data(18)(2);
                     scd_op_left_rigth                        <= cmd_data(18)(1);
                     scd_op_up_down                           <= cmd_data(18)(0);                  
                     scd_dummy_cfg_i.scd_op.scd_int_mode      <= cmd_data(19);                  
                     scd_op_reserved_20                       <= cmd_data(20)(7 downto 2);                  
                     scd_dummy_cfg_i.scd_op.scd_pix_res       <= cmd_data(20)(1 downto 0);
                     scd_dummy_cfg_i.scd_misc.scd_xsize_div2  <= resize(unsigned(cmd_data(11)&cmd_data(10))/2  , scd_dummy_cfg_i.scd_misc.scd_xsize_div2'length); 
                     scd_at_least_one_cfg_received            <= '1';
                  
                  when SCD_INT_CMD_ID =>      -- decodage cmd temps d'intégration           
                     scd_dummy_cfg_i.scd_int.scd_int_time     <= resize(unsigned(cmd_data(2)&cmd_data(1)&cmd_data(0)), scd_dummy_cfg_i.scd_int.scd_int_time'length);
                     scd_int_reserved_5_3                     <= cmd_data(5)&cmd_data(4)&cmd_data(3);
                  
                  when SCD_DIAG_CMD_ID =>     -- decodage cmd diag mode  
                     scd_diag_reserved_0                      <= cmd_data(0)(7 downto 3);
                     scd_dummy_cfg_i.scd_diag.scd_bit_pattern <= cmd_data(0)(2 downto 0);
                     for ii in 1 to 15 loop
                        scd_diag_reserved_15_1(ii)            <= cmd_data(ii);
                     end loop;
                  
                  when others =>               
                  
               end case;    
               
            end if;
         end if;
      end if;
   end process; 
   
   --------------------------------------------------  
   -- decodage des commandes                                 
   --------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            int_gen_fsm <= idle;
            fpa_int_i <= '0'; 
            cnt <= (others => '0');
            DATA_EN <= '0';
            frame_valid_last <= '0';
         else
            
            DATA_EN <= scd_at_least_one_cfg_received;
            frame_valid_last <= FRAME_VALID;
            -- fsm de generation de fpa_int_i           
            case  int_gen_fsm is 
               
               when idle =>
                  cnt <= (others => '0');                 
                  fpa_int_i <= '0';
                  --DATA_EN <= '0'; 
                  if FPA_TRIG = '1' and scd_at_least_one_cfg_received = '1' then               
                     int_gen_fsm <= int_dly_st;
                  end if;
               
               when int_dly_st => 
                  if cnt >= 30 then    
                     int_gen_fsm <= int_gen_st;
                     cnt <= (others  => '0');
                  else                        
                     cnt <= cnt + 1;                
                  end if;   
               
               when int_gen_st =>           
                  fpa_int_i <= '1';
                  if cnt >= scd_dummy_cfg_i.scd_int.scd_int_time then    -- 
                     int_gen_fsm <= pause_st;
                     
                     cnt <= (others  => '0');
                  else                        
                     cnt <= cnt + 1;                
                  end if;
               
               when pause_st =>
                  fpa_int_i <= '0';
                  if FRAME_VALID = '0' and frame_valid_last = '1' then
                     int_gen_fsm <= idle;
                  end if;   
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
end rtl;
