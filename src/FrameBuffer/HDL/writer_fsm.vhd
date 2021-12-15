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
    
    FB_CFG                    : in frame_buffer_cfg_type;  
    STALL_WRITER              : in STD_LOGIC;
    WRITER_DONE               : out STD_LOGIC;

    AXIS_RX_DATA_MOSI         : in t_axi4_stream_mosi64;
    AXIS_RX_DATA_MISO         : out t_axi4_stream_miso;
    
    AXIS_S2MM_DATA_MOSI       : out t_axi4_stream_mosi64;
    AXIS_S2MM_DATA_MISO       : in t_axi4_stream_miso;
    
    AXIS_S2MM_CMD_MOSI        : out t_axi4_stream_mosi_cmd32;
    AXIS_S2MM_CMD_MISO        : in t_axi4_stream_miso;
        
    AXIS_S2MM_STS_MOSI        : in t_axi4_stream_mosi_status;
    AXIS_S2MM_STS_MISO        : out t_axi4_stream_miso;

    WR_BUFFER_STATUS          : in buffer_status_type;    
    WR_BUFFER_STATUS_UPDATE   : out STD_LOGIC;
    
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

   signal areset_i                       : std_logic; 
   signal sreset                         : std_logic;    
   signal fb_cfg_i                       : frame_buffer_cfg_type;
   signal sof_i                          : std_logic;
   signal eof_i                          : std_logic;
   signal sof_last                       : std_logic;
   signal wr_next_incoming_frame         : std_logic;
   signal wr_next_incoming_frame_last    : std_logic;
   signal done                           : std_logic;
   signal buf_sts_update                 : std_logic;
   signal mask_tlast                     : std_logic;
   signal sts_ack_i                      : std_logic;
   signal buf_sts_i                      : buffer_status_type;
   signal s2mm_cmd_mosi                  : t_axi4_stream_mosi_cmd32;
   signal s2mm_cmd_miso                  : t_axi4_stream_miso;
   signal s2mm_sts_mosi                  : t_axi4_stream_mosi_status;
   signal s2mm_sts_miso                  : t_axi4_stream_miso;
   signal axis_rx_data_miso_i            : t_axi4_stream_miso;
   signal s2mm_data_mosi_pipe            : axis64_mosi_pipe;
   signal s2mm_addr                      : std_logic_vector(31 downto 0) := (others => '0');
   signal s2mm_eof                       : std_logic := '0';
   signal s2mm_btt                       : std_logic_vector(22 downto 0) := (others => '0');   
   signal s2mm_err_o                     : std_logic_vector(2 downto 0); -- (SLVERR & DECERR & INTERR)
      
   type writer_sm_type is (standby_wr, wait_wr_cmd_ack, wait_buf_sts_update_ack, wait_wr_sts_ack); 
   signal writer_sm                      : writer_sm_type;

   type switch_sm_type is (fall_st, wr_st); 
   signal switch_sm                      : switch_sm_type; 
   
begin 
   
  -- I/O Connections assignments
   areset_i                    <= not ARESETN;   
   s2mm_cmd_miso               <= AXIS_S2MM_CMD_MISO;
   s2mm_sts_mosi               <= AXIS_S2MM_STS_MOSI; 
   s2mm_cmd_mosi.TDATA         <= std_logic_vector(RSVD & TAG & s2mm_addr & DRR & s2mm_eof & DSA & CTYPE & s2mm_btt);
   fb_cfg_i                    <= FB_CFG when FB_CFG.dval = '1' else fb_cfg_default;
   AXIS_RX_DATA_MISO.TREADY    <= axis_rx_data_miso_i.TREADY;
   axis_rx_data_miso_i.TREADY  <= AXIS_S2MM_DATA_MISO.TREADY when wr_next_incoming_frame = '1' else '1';
   AXIS_S2MM_DATA_MOSI.TDATA   <= s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TDATA;  
   AXIS_S2MM_DATA_MOSI.TSTRB   <= (others => '1');  
   AXIS_S2MM_DATA_MOSI.TKEEP   <= (others => '1'); 
   AXIS_S2MM_DATA_MOSI.TID     <= s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TID; 
   AXIS_S2MM_DATA_MOSI.TLAST   <= s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TLAST when mask_tlast = '0' else '0';     
   AXIS_S2MM_DATA_MOSI.TDEST   <= (others => '0');  
   AXIS_S2MM_DATA_MOSI.TUSER   <= (others => '0');    
   AXIS_S2MM_DATA_MOSI.TVALID  <=  s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TVALID when wr_next_incoming_frame = '1' else '0';
   AXIS_S2MM_CMD_MOSI          <= s2mm_cmd_mosi;
   AXIS_S2MM_STS_MISO          <= s2mm_sts_miso; 
   WRITER_DONE                 <= done;   
   WR_BUFFER_STATUS_UPDATE     <= buf_sts_update;
   ERROR                       <= s2mm_err_o;
   
   U0: sync_reset
   port map(ARESET => areset_i, CLK    => CLK, SRESET => sreset );  
   
   U1: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => WR_BUFFER_STATUS.ack, Q => sts_ack_i, RESET => sreset, CLK => CLK ); 
   
   U2 : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            buf_sts_i <= buf_sts_default;
         else    
            if sts_ack_i = '1' then 
               buf_sts_i <= WR_BUFFER_STATUS;
            else
               buf_sts_i <= buf_sts_i;
            end if;
         end if;     
      end if;
   end process;
   
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            writer_sm <= standby_wr;
            buf_sts_update <= '0';
            s2mm_addr <= (others => '0');
            s2mm_eof <='1'; 
            s2mm_btt <= (others => '0');
            s2mm_cmd_mosi.tvalid <= '0';
            s2mm_sts_miso.tready <= '0';
            wr_next_incoming_frame_last <= '1';
            done <= '0';
         else

               wr_next_incoming_frame_last <= wr_next_incoming_frame;
               
               case writer_sm is 
                  when standby_wr => 
                     done <= '1';
                     if wr_next_incoming_frame = '1' and wr_next_incoming_frame_last = '0' then
                        done <= '0';
                        -- Send cmd to data mover's write engine
                        s2mm_addr <= resize(std_logic_vector(buf_sts_i.pbuf), s2mm_addr'length); 
                        s2mm_eof <=  '1';
                        s2mm_btt <= resize(std_logic_vector(fb_cfg_i.frame_byte_size),s2mm_btt'length);
                        s2mm_cmd_mosi.tvalid <= '1';
                        writer_sm <= wait_wr_cmd_ack; 
                     end if;
                  
                  when wait_wr_cmd_ack =>  
                     -- Wait for write cmd to be acknoledge by data mover
                     if s2mm_cmd_miso.tready = '1' then                  
                        s2mm_cmd_mosi.tvalid <= '0';
                        s2mm_sts_miso.tready <= '1'; 
                        writer_sm <= wait_wr_sts_ack;
                    end if; 
                    
                  when wait_wr_sts_ack =>
                     -- Wait for end of data mover transfer
                     if s2mm_sts_mosi.tvalid = '1' then 
                       s2mm_sts_miso.tready <= '0';
                       buf_sts_update <= '1'; 
                       writer_sm <= wait_buf_sts_update_ack;
                     end if;
                  
                  when wait_buf_sts_update_ack =>   
                      -- Wait for buffer manager to update current pointed buffer status & write pointer 
                      if sts_ack_i = '1' then
                       buf_sts_update <= '0';
                       done <= '1';
                       writer_sm <= standby_wr;
                     end if;
                  when others =>
                  
               end case;
         end if;
      end if;     
   end process; 
   
     
   U4 : process(CLK)        
   begin
      if rising_edge(CLK) then 
            s2mm_data_mosi_pipe(0) <= AXIS_RX_DATA_MOSI;
            for i in 1 to NB_PIPE_STAGE-1 loop
                s2mm_data_mosi_pipe(i) <= s2mm_data_mosi_pipe(i-1);        
            end loop;         
      end if;
   end process;    
      
   
   U5 : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            switch_sm <= fall_st;
            wr_next_incoming_frame <= '0';
            mask_tlast <= '0';
         else    
               case switch_sm is 
                  
                  when fall_st =>
                     
                     if sof_i = '1' and buf_sts_i.full = '0' and done = '1' and STALL_WRITER = '0' then 
                        mask_tlast <= '1';
                        wr_next_incoming_frame <= '1';
                        switch_sm <= wr_st;
                     end if;

                  when wr_st =>  
               
                     if s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).TID(0) = '0' then
                        mask_tlast <= '0';    
                     end if;

                     if s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).tvalid = '1' and AXIS_S2MM_DATA_MISO.TREADY = '1' and s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).tlast = '1' and s2mm_data_mosi_pipe(NB_PIPE_STAGE-1).tid(0) = '0' then
                        wr_next_incoming_frame <= '0';
                        switch_sm <= fall_st;
                     end if;
                     
                  when others =>
                  
               end case;
         end if;     
      end if;
   end process;
   
   U6 : process(CLK)
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
   
   
   U7 : process(CLK)
   begin
       if rising_edge(CLK) then
            if sreset = '1' then
               s2mm_err_o <= (others => '0');
            else
               if( s2mm_sts_mosi.tvalid = '1') then

                   if(s2mm_sts_mosi.tdata(6 downto 4) /= "000") then
                       s2mm_err_o(2 downto 0) <= s2mm_sts_mosi.tdata(6 downto 4);
                   end if;
               else
                   s2mm_err_o <= s2mm_err_o;
               end if;
            end if;
       end if;
   end process;

end writer_fsm;
