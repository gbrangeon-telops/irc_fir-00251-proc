-------------------------------------------------------------------------------
--
-- Title       : write_fsm
-- Design      : tb_frame_buffer
-- Author      : Philippe Couture   
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\write_fsm.vhd
-- Generated   : Mon Aug 10 13:21:40 2020
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

entity writer_fsm is
   Port ( 
   
    CLK                       : in STD_LOGIC;
    ARESETN                   : in STD_LOGIC;
    
    USER_CFG                  : in frame_buffer_cfg_type;
    
    FB_CFG                    : out frame_buffer_cfg_type; 
    CFG_UPDATE_PENDING        : out STD_LOGIC;
    FLUSH                     : out STD_LOGIC;
    RD_IN_PROGRESS            : in  STD_LOGIC; 
    
    NEXT_RD_BUFFER            : out buffer_status_type;  
    CURRENT_RD_BUFFER         : in  buffer_status_type;
    CURRENT_WR_BUFFER         : out buffer_status_type;
    
    AXIS_RX_DATA_MOSI         : in  t_axi4_stream_mosi64;
    AXIS_RX_DATA_MISO         : out t_axi4_stream_miso;
    
    AXIS_S2MM_DATA_MOSI       : out t_axi4_stream_mosi64;
    AXIS_S2MM_DATA_MISO       : in  t_axi4_stream_miso;
    
    AXIS_S2MM_CMD_MOSI        : out t_axi4_stream_mosi_cmd32;
    AXIS_S2MM_CMD_MISO        : in  t_axi4_stream_miso;
        
    AXIS_S2MM_STS_MOSI        : in  t_axi4_stream_mosi_status;
    AXIS_S2MM_STS_MISO        : out t_axi4_stream_miso;
    
    STATUS                    : out std_logic_vector(7 downto 0);
    ERROR                     : out std_logic_vector(2 downto 0) 
   );
end writer_fsm;


architecture writer_fsm of writer_fsm is
  
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
   
   component gh_stretch 
	GENERIC (stretch_count: integer :=1023);
	 port(
		 CLK : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC
	     );
   end component;
   
   signal areset_i                       : std_logic; 
   signal sreset                         : std_logic;    
   signal fb_cfg_i                       : frame_buffer_cfg_type; 
   signal flush_i                        : std_logic;
   signal sof_i                          : std_logic;
   signal eof_i                          : std_logic;
   signal sof_last                       : std_logic;
   signal wr_next_incoming_frame         : std_logic;
   signal wr_next_incoming_frame_last    : std_logic;
   signal done                           : std_logic; 
   signal write_in_progress              : std_logic;
   signal read_in_progress               : std_logic;   
   signal mask_tlast                     : std_logic;
   signal next_read_buffer               : buffer_status_type := buf_sts_default;
   signal next_write_buffer              : buffer_status_type := buf_sts_default;
   signal current_read_buffer_sync       : buffer_status_type := buf_sts_default;
   signal current_write_buffer           : buffer_status_type := buf_sts_default;
   signal current_read_buffer_valid      : std_logic;
   signal s2mm_cmd_mosi                  : t_axi4_stream_mosi_cmd32;
   signal s2mm_cmd_miso                  : t_axi4_stream_miso;
   signal s2mm_sts_mosi                  : t_axi4_stream_mosi_status;
   signal s2mm_sts_miso                  : t_axi4_stream_miso;
   signal axis_rx_data_miso_i            : t_axi4_stream_miso;
   signal s2mm_data_mosi_pipe            : axis64_mosi_pipe;
   signal s2mm_addr                      : std_logic_vector(31 downto 0) := (others => '0');
   signal s2mm_eof                       : std_logic := '0';
   signal s2mm_btt                       : std_logic_vector(22 downto 0) := (others => '0'); 
   signal s2mm_tag                       : std_logic_vector(3 downto 0) := (others => '0');
   signal s2mm_err_o                     : std_logic_vector(2 downto 0); -- (SLVERR & DECERR & INTERR)  
   signal cfg_dval_last                  : std_logic;
   signal init_cfg_done                  : std_logic;
   signal cfg_update_done                : std_logic;
   signal cfg_update_done_last           : std_logic;
   signal fall_i                         : std_logic; 
   signal s2mm_miso_pipe                 : std_logic_vector(NB_PIPE_STAGE-1 downto 0);
   signal user_cfg_dval                  : std_logic;
   signal cnt                            : unsigned(3 downto 0);
    
   type cfg_updater_sm_type is (idle_st, wait_empty_fb_st, cfg_updater_rqst_st); 
   signal cfg_updater_sm             : cfg_updater_sm_type;
   
   type writer_sm_type is (standby_wr, wait_wr_cmd_ack, update_write_pointer, error_wr); 
   signal writer_sm                      : writer_sm_type;

   type switch_sm_type is (fall_st, wr_st); 
   signal switch_sm                      : switch_sm_type; 
   
--   attribute KEEP : string;
--   attribute KEEP of writer_sm                : signal is "true";
--   attribute KEEP of switch_sm                : signal is "true";
--   attribute KEEP of wr_next_incoming_frame   : signal is "true";
--   attribute KEEP of write_in_progress        : signal is "true";
       
begin 
   
  -- I/O Connections assignments
   areset_i                    <= not ARESETN;   
   s2mm_cmd_miso               <= AXIS_S2MM_CMD_MISO;
   s2mm_sts_mosi               <= AXIS_S2MM_STS_MOSI; 
   s2mm_cmd_mosi.TDATA         <= std_logic_vector(RSVD & s2mm_tag & s2mm_addr & DRR & s2mm_eof & DSA & CTYPE & s2mm_btt);
   FB_CFG                      <= fb_cfg_i;
   CFG_UPDATE_PENDING          <= not cfg_update_done;
   AXIS_RX_DATA_MISO.TREADY    <= axis_rx_data_miso_i.TREADY;
   axis_rx_data_miso_i.TREADY  <= AXIS_S2MM_DATA_MISO.TREADY when fall_i = '0' else '1';
   AXIS_S2MM_DATA_MOSI.TDATA   <= s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TDATA;  
   AXIS_S2MM_DATA_MOSI.TSTRB   <= (others => '1');  
   AXIS_S2MM_DATA_MOSI.TKEEP   <= (others => '1'); 
   AXIS_S2MM_DATA_MOSI.TID     <= s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TID; 
   AXIS_S2MM_DATA_MOSI.TLAST   <= s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TLAST when mask_tlast = '0' else '0';     
   AXIS_S2MM_DATA_MOSI.TDEST   <= (others => '0');  
   AXIS_S2MM_DATA_MOSI.TUSER   <= (others => '0');    
   AXIS_S2MM_DATA_MOSI.TVALID  <=  s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TVALID when fall_i = '0' else '0';
   AXIS_S2MM_CMD_MOSI          <= s2mm_cmd_mosi;
   AXIS_S2MM_STS_MISO          <= s2mm_sts_miso; 
   FLUSH                       <= flush_i;
   ERROR                       <= s2mm_err_o;
   STATUS                      <= "000000" & cfg_update_done & init_cfg_done;
   
   U0: sync_reset
   port map(ARESET => areset_i, CLK    => CLK, SRESET => sreset );  
    
   U1A: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => CURRENT_RD_BUFFER.valid, Q => current_read_buffer_valid, RESET => sreset, CLK => CLK ); 
   
   U1B: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => RD_IN_PROGRESS, Q => read_in_progress, RESET => sreset, CLK => CLK ); 

   U1C: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => USER_CFG.dval, Q => user_cfg_dval, RESET => sreset, CLK => CLK ); 
   
   -- This process update the current read buffer status
   U2 : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            current_read_buffer_sync <= buf_sts_default;
         else    
            
            if flush_i = '1' then
               current_read_buffer_sync <= buf_sts_default;     
            elsif current_read_buffer_valid = '1' then 
               current_read_buffer_sync <= CURRENT_RD_BUFFER;
            else
               current_read_buffer_sync <= current_read_buffer_sync;
            end if;
         end if;     
      end if;
   end process; 
   
   NEXT_RD_BUFFER.pbuf    <= next_read_buffer.pbuf;
   NEXT_RD_BUFFER.tag     <= next_read_buffer.tag;
   U3A: gh_stretch generic map (stretch_count => 10) port map(CLK => CLK, rst => sreset, D => next_read_buffer.valid , Q => NEXT_RD_BUFFER.valid);
   
   CURRENT_WR_BUFFER.pbuf <=  current_write_buffer.pbuf;
   CURRENT_WR_BUFFER.tag  <=  current_write_buffer.tag;
   U3B: gh_stretch generic map (stretch_count => 10) port map(CLK => CLK, rst => sreset, D => current_write_buffer.valid , Q => CURRENT_WR_BUFFER.valid);

   -- This process manage the command & status interface of the data mover
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            writer_sm                   <= standby_wr;
            s2mm_addr                   <= (others => '0');
            s2mm_eof                    <='1'; 
            s2mm_btt                    <= (others => '0');
            s2mm_cmd_mosi.tvalid        <= '0';
            wr_next_incoming_frame_last <= '1';
            done                        <= '1';  
            s2mm_sts_miso.tready        <= '1';     
            next_write_buffer           <= buf_sts_default;
            current_write_buffer        <= buf_sts_default;
         else
            
               if flush_i = '1' then
                  next_write_buffer.tag  <= BUFFER_A_TAG;
                  next_write_buffer.pbuf <= fb_cfg_i.buffer_a_addr;
                  current_write_buffer   <= buf_sts_default;
               end if;
         
               wr_next_incoming_frame_last <= wr_next_incoming_frame;
               
               case writer_sm is 
                  when standby_wr => 
                  
                     done                       <= '1';  
                     current_write_buffer.valid <= '0';
                     
                     if  wr_next_incoming_frame = '1' and  wr_next_incoming_frame_last = '0' then
                        done                       <= '0'; 
                        current_write_buffer.pbuf  <= next_write_buffer.pbuf;
                        current_write_buffer.tag   <= next_write_buffer.tag;
                        current_write_buffer.valid <= '1';
                        s2mm_addr                  <= resize(std_logic_vector(next_write_buffer.pbuf), s2mm_addr'length); 
                        s2mm_eof                   <= '1';
                        s2mm_btt                   <= resize(std_logic_vector(fb_cfg_i.frame_byte_size),s2mm_btt'length);
                        s2mm_tag                   <= "00" & std_logic_vector(next_write_buffer.tag);
                        s2mm_cmd_mosi.tvalid       <= '1';
                        
                        if s2mm_err_o /= "000" then
                           writer_sm                  <= error_wr; 
                        else
                           writer_sm                  <= wait_wr_cmd_ack;
                        end if;
                        
                     else
                        s2mm_cmd_mosi.tvalid <= '0'; 
                     end if;
                  
                  when wait_wr_cmd_ack => 
                  
                     current_write_buffer.valid <= '0';
                  
                     if s2mm_cmd_miso.tready = '1' then                  
                        s2mm_cmd_mosi.tvalid <= '0';
                        writer_sm            <= update_write_pointer; 
                    end if; 
                  
                  when update_write_pointer =>  
                  
                     if current_write_buffer.tag = BUFFER_A_TAG then
                        next_write_buffer.pbuf <= fb_cfg_i.buffer_b_addr;
                        next_write_buffer.tag  <= BUFFER_B_TAG;
                     elsif current_write_buffer.tag = BUFFER_B_TAG then 
                        next_write_buffer.pbuf <= fb_cfg_i.buffer_c_addr;
                        next_write_buffer.tag  <= BUFFER_C_TAG;
                     elsif current_write_buffer.tag = BUFFER_C_TAG then 
                        next_write_buffer.pbuf <= fb_cfg_i.buffer_a_addr;
                        next_write_buffer.tag  <= BUFFER_A_TAG;
                     else
                        next_write_buffer.pbuf <= fb_cfg_i.buffer_a_addr;
                        next_write_buffer.tag  <= (others => '0'); 
                     end if;
                       
                     writer_sm <= standby_wr;  
                     
                  when error_wr =>  
                     writer_sm  <= error_wr;  
                     
                  when others =>
                     writer_sm <= error_wr;
                  
               end case;
         end if;
      end if;     
   end process; 
   
   -- This process update the read buffer pointer.
   U5A : process(CLK)        
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            s2mm_err_o       <= (others => '0');
            next_read_buffer <= buf_sts_default;
         else 
            
            next_read_buffer.valid     <= '0';
            
            if flush_i = '1' then
               next_read_buffer       <= buf_sts_default; 
            end if;
               
            if( s2mm_sts_mosi.tvalid = '1') then 
                     
               if(s2mm_sts_mosi.tdata(6 downto 4) /= "000") then
                  s2mm_err_o(2 downto 0) <= s2mm_sts_mosi.tdata(6 downto 4);
               else
                  next_read_buffer.tag <= unsigned(s2mm_sts_mosi.tdata(1 downto 0)); 
                  next_read_buffer.valid <= '1';
                  
                  if unsigned(s2mm_sts_mosi.tdata(1 downto 0)) = BUFFER_A_TAG then
                     next_read_buffer.pbuf  <= fb_cfg_i.buffer_a_addr;
                  elsif unsigned(s2mm_sts_mosi.tdata(1 downto 0)) = BUFFER_B_TAG then 
                     next_read_buffer.pbuf  <= fb_cfg_i.buffer_b_addr;
                  elsif unsigned(s2mm_sts_mosi.tdata(1 downto 0)) = BUFFER_C_TAG then 
                     next_read_buffer.pbuf  <= fb_cfg_i.buffer_c_addr;
                  else
                     next_read_buffer.pbuf  <= fb_cfg_i.buffer_a_addr;
                     next_read_buffer       <= buf_sts_default;
                  end if; 
                  
               end if; 
            else
               s2mm_err_o <= s2mm_err_o;
            end if;             
         end if; 
      end if;
   end process;    
   
   -- Input stage pipe for pixels stream. 
   U6 : process(CLK)        
   begin
      if rising_edge(CLK) then 
            s2mm_data_mosi_pipe(0) <= AXIS_RX_DATA_MOSI;
            for i in 1 to NB_PIPE_STAGE-1 loop
                s2mm_data_mosi_pipe(i) <= s2mm_data_mosi_pipe(i-1);        
            end loop;  
            
            s2mm_miso_pipe(0) <= AXIS_S2MM_DATA_MISO.TREADY;
            for i in 1 to NB_PIPE_STAGE-1 loop
                s2mm_miso_pipe(i) <= s2mm_miso_pipe(i-1);        
            end loop; 
            
           
      end if;
   end process; 
    
   -- This process decide whether a frame should be writen to the frame buffer or flushed. 
 
   -- Required conditions to write a new incomming frame in the frame buffer :
   -- 1. A start of frame condition is detected and the writer_sm is ready to send a new command to the data mover.
   -- 2. The next buffer to be written to is not the buffer that is currently being read ** See note for justification**.
   -- 3. The frame buffer as been configured at least once.
   -- 4. The frame buffer isn't currently being configured.
   -- 5. No error has been return by the data mover.
   -- 6. Explanation on the following condition "not (current_read_buffer_sync.tag = "00" and current_write_buffer.tag = BUFFER_C_TAG)" : 
   --    For write speed far greater than read speed, if all 3 buffers have been writen to before a first read has begin, 
   --    we have to stall the write operation :   
   
   --    ** Note : The present algorithm allow the write operation to be stalled by the read one. 
   --              The frame buffer aim to limit stream throughtput to respect the camera link limit.
   --              We work under the hypothesis that the clink output is only a visual preview and 
   --              that frame are being discard only for very high frame rate. It doesn't matter if 
   --              we don't always write to most recent incomming frame.
   --              This have the advandtage of limiting the DDR bandwith used. 
     
   U7 : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            switch_sm <= fall_st;
            wr_next_incoming_frame <= '0'; 
            fall_i <= '1';
            mask_tlast <= '0';
            sof_last <= '0';
         else  
            
               sof_last <= sof_i;
            
               case switch_sm is 
                  
                  when fall_st =>
                     
                     if sof_i = '1' and done = '1' and (current_read_buffer_sync.tag /= next_write_buffer.tag) and (not (current_read_buffer_sync.tag = "00" and current_write_buffer.tag = BUFFER_C_TAG)) and current_read_buffer_valid = '0'  and cfg_update_done = '1' and init_cfg_done = '1' and s2mm_err_o = "000" then 
                        mask_tlast             <= '1';
                        wr_next_incoming_frame <= '1';
                        fall_i                 <= '0';
                        switch_sm              <= wr_st;
                     end if;

                  when wr_st =>  
                  
                     wr_next_incoming_frame <= '1';

                     if s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TID(0) = '0' then
                        mask_tlast <= '0';    
                     end if;

                     if s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).tvalid = '1' and s2mm_miso_pipe(NB_PIPE_STAGE-1) = '1' and s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).tlast = '1' and s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).tid(0) = '0' then
                        wr_next_incoming_frame <= '0';
                        -- Gestion du cas ou il n'y a aucune pause entre la fin d'un frame et l'envoi du hder du frame suivant (ce cas peut arriver en IWR).
                        if sof_last = '1' and done = '1' and (current_read_buffer_sync.tag /= next_write_buffer.tag) and (not (current_read_buffer_sync.tag = "00" and current_write_buffer.tag = BUFFER_C_TAG)) and current_read_buffer_valid = '0'  and cfg_update_done = '1' and init_cfg_done = '1' and s2mm_err_o = "000"  then
                           fall_i                 <= '0'; 
                           mask_tlast             <= '1'; 
                           switch_sm              <= wr_st;  
                        else  
                           fall_i                 <= '1';
                           switch_sm              <= fall_st; 
                        end if;
                     
                     end if;
                     
                  when others =>
                     switch_sm <= fall_st;    
                  
               end case;
         end if;     
      end if;
   end process;
   
   -- EOF & SOF flags generation.
   U8 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then            
            eof_i <= '1';
            sof_i <= '0';
         else
            if(eof_i = '0' and AXIS_RX_DATA_MOSI.TVALID = '1' and AXIS_RX_DATA_MOSI.TLAST = '1' and AXIS_RX_DATA_MOSI.TID = "0" and axis_rx_data_miso_i.TREADY = '1') then
               eof_i <= '1';
               sof_i <= '0';
            elsif(eof_i = '1' and AXIS_RX_DATA_MOSI.TVALID = '1' and AXIS_RX_DATA_MOSI.TLAST = '0' and AXIS_RX_DATA_MOSI.TID = "1" and axis_rx_data_miso_i.TREADY = '1') then 
               eof_i <= '0';
               sof_i <= '1';
            else
               eof_i <= eof_i;
               sof_i <= '0';
            end if;
         end if;
      end if;
   end process; 

   -- This process manage the configuration update.
   -- Any new config received will flush the frame buffer.
   U9: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            cfg_update_done      <= '0'; 
            fb_cfg_i             <= fb_cfg_default;
            cfg_updater_sm       <= idle_st; 
            cfg_dval_last        <= '0'; 
            init_cfg_done        <= '0';
            cfg_update_done_last <= '0';
            cnt                  <= (others => '0');
            flush_i              <= '0';
            write_in_progress    <= '0';
         else              
            
            cfg_dval_last <= user_cfg_dval;
            cfg_update_done_last <= cfg_update_done;
            
            if next_read_buffer.tag = current_write_buffer.tag and done = '1' then 
               write_in_progress <= '0';
            elsif next_read_buffer.tag /= current_write_buffer.tag and done = '0' then 
               write_in_progress <= '1';
            end if;

            case cfg_updater_sm is 
               when idle_st => 
                  fb_cfg_i        <= fb_cfg_i;
                  cfg_update_done <= '1';
                  flush_i         <= '0';
                  if user_cfg_dval = '1' and cfg_dval_last = '0' then 
                     cfg_update_done <= '0';
                     cfg_updater_sm  <= wait_empty_fb_st;    
                  end if;  
               
               when wait_empty_fb_st => 
                  if read_in_progress = '0' and write_in_progress = '0' and user_cfg_dval = '1' then 
                     fb_cfg_i       <= USER_CFG;
                     flush_i        <= '1';
                     cnt            <= (others => '0');
                     cfg_updater_sm <= cfg_updater_rqst_st;
                  end if;
               
               when cfg_updater_rqst_st =>
                  init_cfg_done <= '1';  
                  cnt           <= cnt + 1;
                  if cnt = 15 then 
                     cfg_updater_sm <= idle_st; 
                  end if;
                  
               when others =>    
                  cfg_updater_sm <= idle_st;
            end case;      
         end if;
      end if;     
   end process;
   
   
end writer_fsm;
