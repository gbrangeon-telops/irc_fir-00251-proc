-------------------------------------------------------------------------------
--
-- Title       : read_fsm
-- Design      : tb_frame_buffer
-- Author      : Philippe Couture   
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\read_fsm.vhd
-- Generated   : Mon Aug 10 13:21:08 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.fbuffer_define.all;


    
entity reader_fsm is
   Port ( 
   
    CLK                       : in  STD_LOGIC;    --CLK_DATA
    ARESETN                   : in  STD_LOGIC; 
    
    FB_CFG                    : in  frame_buffer_cfg_type;
    
    CFG_UPDATE_PENDING        : in  STD_LOGIC;
    FLUSH                     : in  STD_LOGIC;
    RD_IN_PROGRESS            : out STD_LOGIC;
    
    
    AXIS_MM2S_CMD_MOSI        : out t_axi4_stream_mosi_cmd32;
    AXIS_MM2S_CMD_MISO        : in  t_axi4_stream_miso;
        
    AXIS_MM2S_STS_MOSI        : in  t_axi4_stream_mosi_status;
    AXIS_MM2S_STS_MISO        : out t_axi4_stream_miso;
    
    AXIS_MM2S_DATA_MOSI       : in  t_axi4_stream_mosi64;
    AXIS_MM2S_DATA_MISO       : out t_axi4_stream_miso;
    
    AXIS_TX_DATA_MOSI         : out t_axi4_stream_mosi64;
    AXIS_TX_DATA_MISO         : in  t_axi4_stream_miso;
    
    CURRENT_RD_BUFFER         : out buffer_status_type;
    CURRENT_WR_BUFFER         : in  buffer_status_type;
    NEXT_RD_BUFFER            : in  buffer_status_type;
    
    ERROR                     : out std_logic_vector(2 downto 0)
        
   );
end reader_fsm;

architecture reader_fsm of reader_fsm is

  component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;
   
  component t_axi4_stream64_fifo
  generic(
       ASYNC : BOOLEAN := false;
       FifoSize : INTEGER := 16;
       PACKET_MODE : BOOLEAN := false
  );
  port (
       ARESETN : in STD_LOGIC;
       RX_CLK : in STD_LOGIC;
       RX_MOSI : in T_AXI4_STREAM_MOSI64;
       TX_CLK : in STD_LOGIC;
       TX_MISO : in T_AXI4_STREAM_MISO;
       OVFL : out STD_LOGIC;
       RX_MISO : out T_AXI4_STREAM_MISO;
       TX_MOSI : out T_AXI4_STREAM_MOSI64
  ); 
  
end component;

   signal areset_i                   : std_logic; 
   signal sreset                     : std_logic; 
   signal flush_i                    : std_logic;
   signal fb_cfg_i                   : frame_buffer_cfg_type;
   signal gen_tlast                  : std_logic;
   signal gen_tid                    : std_logic;
   signal read_in_progress           : std_logic;
   signal next_read_buffer_valid     : std_logic;
   signal current_write_buffer_valid : std_logic;
   signal cfg_update_pending_i       : std_logic;
  
   signal next_read_buffer_sync      : buffer_status_type := buf_sts_default;   
   signal current_read_buffer        : buffer_status_type := buf_sts_default; 
   signal current_write_buffer_sync  : buffer_status_type := buf_sts_default;
   
   signal pix_cnt                    : unsigned(31 downto 0);
   signal lval_cnt                   : unsigned(31 downto 0);
   signal lval_pause_cnt             : unsigned(31 downto 0);
   signal width                      : unsigned(31 downto 0);                                                                    
   signal cmd_cnt                    : unsigned(31 downto 0); 
                                    
   signal mm2s_cmd_tvalid_last       : std_logic; 
   signal stall_i                    : std_logic; 
   signal discard_cmd                : std_logic;
   signal mm2s_cmd_mosi              : t_axi4_stream_mosi_cmd32;
   signal mm2s_cmd_miso              : t_axi4_stream_miso;
   signal mm2s_sts_mosi              : t_axi4_stream_mosi_status;
   signal mm2s_sts_miso              : t_axi4_stream_miso; 
   signal axis_mm2s_fifo_in_miso     : t_axi4_stream_miso;
   signal axis_mm2s_fifo_in_mosi     : t_axi4_stream_mosi64; 
   
   signal axis_output_fifo_in_miso   : t_axi4_stream_miso;
   signal axis_output_fifo_in_mosi   : t_axi4_stream_mosi64; 
   
   signal axis_mm2s_fifo_out_miso    : t_axi4_stream_miso;
   signal axis_mm2s_fifo_out_mosi    : t_axi4_stream_mosi64;
     
   signal mm2s_addr                  : std_logic_vector(31 downto 0) := (others => '0');
   signal mm2s_eof                   : std_logic                     := '0';
   signal mm2s_btt                   : std_logic_vector(22 downto 0) := (others => '0'); 
   signal mm2s_tag                   : std_logic_vector(3 downto 0)  := (others => '0');
   signal mm2s_err_o                 : std_logic_vector(2 downto 0); -- (SLVERR & DECERR & INTERR)

   type reader_sm_type is (standby_rd, wait_rd_cmd_ack, validate_rd_frame, error_rd); 
   signal reader_sm                 : reader_sm_type; 
   
   type output_sm_type is (hdr_st, img_st); 
   signal output_sm                 : output_sm_type;
   
   
   type throttle_sm_type is (idle_st, stall_st); 
   signal throttle_sm                 : throttle_sm_type; 
   
--   attribute KEEP : string;
--   attribute KEEP of throttle_sm      : signal is "true";
--   attribute KEEP of output_sm        : signal is "true";
--   attribute KEEP of reader_sm        : signal is "true";
begin      
   
   -- I/O Connections assignments
   areset_i                       <= not ARESETN; 
   ERROR                          <= mm2s_err_o;

   mm2s_sts_mosi                  <= AXIS_MM2S_STS_MOSI;
   AXIS_MM2S_STS_MISO             <= mm2s_sts_miso;
   mm2s_cmd_mosi.TDATA            <= std_logic_vector(RSVD & mm2s_tag & mm2s_addr & DRR & mm2s_eof & DSA & CTYPE & mm2s_btt);
   AXIS_MM2S_CMD_MOSI             <= mm2s_cmd_mosi;
   mm2s_cmd_miso                  <= AXIS_MM2S_CMD_MISO;
   
   
   CURRENT_RD_BUFFER              <= current_read_buffer;
    
   axis_mm2s_fifo_in_mosi.TDATA   <= AXIS_MM2S_DATA_MOSI.TDATA;  
   axis_mm2s_fifo_in_mosi.TLAST   <= AXIS_MM2S_DATA_MOSI.TLAST when gen_tlast = '0' else '1';
   axis_mm2s_fifo_in_mosi.TID     <= (others => '0') when gen_tid = '0' else (others => '1');
   axis_mm2s_fifo_in_mosi.TSTRB   <= AXIS_MM2S_DATA_MOSI.TSTRB;
   axis_mm2s_fifo_in_mosi.TKEEP   <= AXIS_MM2S_DATA_MOSI.TKEEP;
   axis_mm2s_fifo_in_mosi.TDEST   <= AXIS_MM2S_DATA_MOSI.TDEST;
   axis_mm2s_fifo_in_mosi.TUSER   <= AXIS_MM2S_DATA_MOSI.TUSER;
   axis_mm2s_fifo_in_mosi.TVALID  <= AXIS_MM2S_DATA_MOSI.TVALID;
   AXIS_MM2S_DATA_MISO.TREADY     <= axis_mm2s_fifo_in_miso.tready;
   
   axis_output_fifo_in_mosi.TDATA  <= axis_mm2s_fifo_out_mosi.TDATA;   
   axis_output_fifo_in_mosi.TLAST  <= axis_mm2s_fifo_out_mosi.TLAST;  
   axis_output_fifo_in_mosi.TID    <= axis_mm2s_fifo_out_mosi.TID;
   axis_output_fifo_in_mosi.TSTRB  <= (others => '1');
   axis_output_fifo_in_mosi.TKEEP  <= (others => '1');
   axis_output_fifo_in_mosi.TDEST  <= (others => '0');
   axis_output_fifo_in_mosi.TUSER  <= (others => '0');
   axis_output_fifo_in_mosi.TVALID <= axis_mm2s_fifo_out_mosi.TVALID and not stall_i;   
   axis_mm2s_fifo_out_miso.tready  <= axis_output_fifo_in_miso.TREADY and not stall_i;

   RD_IN_PROGRESS                  <= read_in_progress;
      
   U0: sync_reset
   port map(ARESET => areset_i, CLK    => CLK, SRESET => sreset ); 
   
   U1A: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => NEXT_RD_BUFFER.valid, Q => next_read_buffer_valid, RESET => sreset, CLK => CLK ); 
   
   U1B: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => CURRENT_WR_BUFFER.valid, Q => current_write_buffer_valid, RESET => sreset, CLK => CLK ); 
     
   U1C: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => CFG_UPDATE_PENDING, Q => cfg_update_pending_i, RESET => sreset, CLK => CLK ); 
     
   U1D: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => FLUSH, Q => flush_i, RESET => sreset, CLK => CLK ); 
   
   
   -- This process update the next read buffer status
   U2A : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            next_read_buffer_sync <= buf_sts_default;
         else    
           
            if flush_i = '1' then 
               next_read_buffer_sync <= buf_sts_default;     
            elsif next_read_buffer_valid = '1' then 
               next_read_buffer_sync <= NEXT_RD_BUFFER;
            else  
               next_read_buffer_sync <= next_read_buffer_sync;
            end if;
         end if;     
      end if;
   end process;  
   
    -- This process update the ublaze config.
   U2B : process(CLK)        
   begin
      if rising_edge(CLK) then
         if flush_i = '1' then 
            fb_cfg_i <= FB_CFG;     
         else  
            fb_cfg_i <= fb_cfg_i;
         end if;    
      end if;
   end process;  
   
   
   
   -- This process update the current write buffer status 
   U2C : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            current_write_buffer_sync <= buf_sts_default;
         else    
            if flush_i = '1' then
               current_write_buffer_sync <= buf_sts_default;     
            elsif current_write_buffer_valid = '1' then 
               current_write_buffer_sync <= CURRENT_WR_BUFFER;
            else
               current_write_buffer_sync <= current_write_buffer_sync;
            end if;
         end if;     
      end if;
   end process;
  
   
      
   U3 : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            cmd_cnt <= (others => '0'); 
            read_in_progress <= '0'; 
            mm2s_cmd_tvalid_last <= '1';
            discard_cmd <= '0';
         else    
            
            mm2s_cmd_tvalid_last <= mm2s_cmd_mosi.tvalid;
            
            if mm2s_cmd_mosi.tvalid = '1' and mm2s_cmd_tvalid_last = '0' and axis_output_fifo_in_miso.tready = '1' and axis_output_fifo_in_mosi.TVALID = '1' and axis_output_fifo_in_mosi.TLAST = '1'  and axis_output_fifo_in_mosi.TID(0) = '0' then
               cmd_cnt <= cmd_cnt;
            elsif mm2s_cmd_mosi.tvalid = '1' and mm2s_cmd_tvalid_last = '0' then
               cmd_cnt <= cmd_cnt + 1;     
            elsif axis_output_fifo_in_miso.tready = '1' and axis_output_fifo_in_mosi.TVALID = '1' and axis_output_fifo_in_mosi.TLAST = '1' and axis_output_fifo_in_mosi.TID(0) = '0' then
               cmd_cnt <= cmd_cnt - 1;     
            end if;  
            
            if cmd_cnt > 0 then
               read_in_progress <= '1';
            else
               read_in_progress <= '0';
            end if;
            
            if cmd_cnt > (RD_NB_CMD_QUEUE - 1) then
               discard_cmd <= '1';
            else
               discard_cmd <= '0';
            end if;
            
            
         end if;     
      end if;
   end process;

   -- This process manage the command & status interface of the data mover
   U4: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            reader_sm              <= standby_rd;
            mm2s_addr              <= (others => '0');
            mm2s_eof               <='1'; 
            mm2s_btt               <= (others => '0');
            mm2s_cmd_mosi.tvalid   <= '0';
            mm2s_sts_miso.tready   <= '0';
            current_read_buffer    <=  buf_sts_default;
            mm2s_err_o(2 downto 0) <= (others =>'0');
         else
            
            if flush_i = '1' then  
               current_read_buffer <=  buf_sts_default;
            end if;
            
            case reader_sm is 
               when standby_rd => 
                  if (next_read_buffer_sync.tag /= "00") and (current_read_buffer.tag /= next_read_buffer_sync.tag) and next_read_buffer_valid = '0' and current_write_buffer_valid = '0' and cfg_update_pending_i = '0' and discard_cmd = '0' then  
                     current_read_buffer.pbuf  <= next_read_buffer_sync.pbuf;
                     current_read_buffer.tag   <= next_read_buffer_sync.tag;
                     current_read_buffer.valid <= '1';
                     mm2s_addr                 <= resize(std_logic_vector(next_read_buffer_sync.pbuf), mm2s_addr'length);
                     mm2s_eof                  <= '1';
                     mm2s_btt                  <= resize(std_logic_vector(fb_cfg_i.frame_byte_size),mm2s_btt'length); 
                     mm2s_tag                  <= "00" & std_logic_vector(next_read_buffer_sync.tag);
                     mm2s_cmd_mosi.tvalid      <= '1';
                     mm2s_sts_miso.tready      <= '0';
                     reader_sm                 <= wait_rd_cmd_ack;
                  else
                     mm2s_sts_miso.tready      <= '0';
                     mm2s_cmd_mosi.tvalid      <= '0';
                  end if;
                  
               when wait_rd_cmd_ack =>
                  current_read_buffer.valid <= '0';
                  if mm2s_cmd_miso.tready = '1' then  
                     mm2s_cmd_mosi.tvalid <= '0';
                     mm2s_sts_miso.tready <= '1';
                     reader_sm            <= validate_rd_frame; 
                  else
                     mm2s_sts_miso.tready <= '0';
                     mm2s_cmd_mosi.tvalid <= '1';                        
                  end if;
               
               when validate_rd_frame =>   
                  
                  if mm2s_sts_mosi.tvalid = '1' then
                     mm2s_sts_miso.tready <= '0';
                     mm2s_cmd_mosi.tvalid <= '0';
                     if ( (mm2s_sts_mosi.tdata(7) = '1') and (mm2s_sts_mosi.tdata(6 downto 2) = "00000") and (mm2s_sts_mosi.tdata(1 downto 0) = std_logic_vector(current_read_buffer.tag)) ) then --transmit valid
                        reader_sm <= standby_rd;
                     else   
                        mm2s_err_o(2 downto 0) <= mm2s_sts_mosi.tdata(6 downto 4);
                        reader_sm <= error_rd;
                     end if;

                   else   
                      mm2s_cmd_mosi.tvalid <= '0';
                      mm2s_sts_miso.tready <= '1';
                   end if;

               when error_rd =>
                  mm2s_err_o <= mm2s_err_o;
                  reader_sm  <= error_rd;
               
               when others =>
                  reader_sm <= error_rd;
            end case;
         end if;
         
      end if;     
   end process;    

   -- This process reconstruct some AXI-STREAM signals : 
      --> TID (1 = hdr, 0 = img)
      --> TLAST associated with end of header.     
   U5: process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            output_sm <= hdr_st;
            pix_cnt <= (others => '0');
            gen_tid <= '1';
            gen_tlast <= '0';
         else 
           
            case output_sm is 
               
               when hdr_st =>
                  gen_tid <= '1';  
                  if axis_mm2s_fifo_in_miso.tready = '1' and axis_mm2s_fifo_in_mosi.TVALID = '1' then
                     
                     pix_cnt <= pix_cnt + STREAM_PIXEL_WIDTH;  
                     gen_tlast <= '0';
                     if pix_cnt = (fb_cfg_i.hdr_pix_size-STREAM_PIXEL_WIDTH) then  
                        pix_cnt <= (others => '0');
                        gen_tid <= '0';
                        output_sm <= img_st;
                     elsif pix_cnt = (fb_cfg_i.hdr_pix_size-2*STREAM_PIXEL_WIDTH) then
                        gen_tlast <= '1';  
                     end if;   
                  end if;   
                  
               when img_st =>  
                  if axis_mm2s_fifo_in_miso.tready = '1' and axis_mm2s_fifo_in_mosi.TVALID = '1' and axis_mm2s_fifo_in_mosi.TLAST = '1'then 
                     gen_tid <= '1';
                     output_sm <= hdr_st;
                  end if;
                  
               when others =>
               
            end case;
   
         end if;     
      end if;
   end process;  
 
 U6 : t_axi4_stream64_fifo
 generic map (
      ASYNC => false,
      FifoSize => 16,
      PACKET_MODE => false
 )  
 port map(
      ARESETN => ARESETN,
      OVFL => open,
      RX_CLK => CLK,
      RX_MISO => axis_mm2s_fifo_in_miso,
      RX_MOSI => axis_mm2s_fifo_in_mosi,
      TX_CLK => CLK,
      TX_MISO => axis_mm2s_fifo_out_miso,
      TX_MOSI => axis_mm2s_fifo_out_mosi
 );
 
 -- This process throttle the axis stream throughtput to impose a minimum pause 
 -- between lines (the pause must be configure to be greater or equal to clink LVAL_PAUSE in output fpga)
 U7 : process(CLK)
   begin
       if rising_edge(CLK) then
            if sreset = '1' then
               lval_cnt <= to_unsigned(0,lval_cnt'length);
               throttle_sm <= idle_st; 
               stall_i <= '0';    
            else
               width <= resize(shift_right(fb_cfg_i.hdr_pix_size, 3), width'length);
               case throttle_sm is 
                  when idle_st => 
                     if axis_mm2s_fifo_out_mosi.tvalid = '1' and axis_mm2s_fifo_out_miso.tready = '1' then
                        if lval_cnt = width-1  then
                           
                           lval_cnt <= to_unsigned(0,lval_cnt'length);
                           
                           if axis_mm2s_fifo_out_mosi.tlast = '1' then --eof or "end of header"
                              lval_pause_cnt <= fb_cfg_i.fval_pause_min; 
                              if fb_cfg_i.fval_pause_min > 0 then
                                 stall_i <= '1';
                                 throttle_sm <= stall_st;
                              else
                                 stall_i <= '0';
                                 throttle_sm <= idle_st;
                              end if;
                              
                           else --eol
                              lval_pause_cnt <= fb_cfg_i.lval_pause_min; 
                              if fb_cfg_i.lval_pause_min > 0 then
                                 stall_i <= '1';
                                 throttle_sm <= stall_st;
                              else
                                 stall_i <= '0';
                                 throttle_sm <= idle_st;
                              end if; 
                           end if; 

                        else
                           lval_cnt <= lval_cnt +1;
                        end if;
                     end if;
                                         
                  when stall_st => 
                  
                     if lval_cnt = lval_pause_cnt-1 then 
                        lval_cnt <= to_unsigned(0,lval_cnt'length);
                        stall_i <= '0'; 
                        throttle_sm <= idle_st;
                     else
                        lval_cnt <= lval_cnt +1;
                     end if;
                     
                  when others =>  
                  
               end case;
               
            end if;
       end if;
   end process;
 
 -- Output fifo
 U8 : t_axi4_stream64_fifo
 generic map (
      ASYNC => false,
      FifoSize => 16,
      PACKET_MODE => false
 )  
 port map(
      ARESETN => ARESETN,
      OVFL => open,
      RX_CLK => CLK,
      RX_MISO => axis_output_fifo_in_miso,
      RX_MOSI => axis_output_fifo_in_mosi,
      TX_CLK => CLK,
      TX_MISO => AXIS_TX_DATA_MISO,
      TX_MOSI => AXIS_TX_DATA_MOSI
 );
 
end reader_fsm;
