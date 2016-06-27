---------------------------------------------------------------------------------------------------
--  Copyright (c) Telops Inc. 2014
--
--  File: buffering_fsm.vhd
--  Use: MAnage cmd for the Datamover to read and write sequence to the DDR with the requiered Behavior
--  By: Jean-Alexis Boulet
--
--  $Revision$
--  $Author$
--  $LastChangedDate$
--
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;
use work.BufferingDefine.all;

entity BUFFERING_FSM is
   port(
      --clk and reset
      --CLK_CTRL         : in std_logic; -- at 100 MHZ
      CLK_DATA         : in std_logic; -- at 160 MHZ
      ARESETN          : in std_logic;
      
      --DataMover interface
      AXIS_MM2S_CMD_MOSI  : out t_axi4_stream_mosi72;
      AXIS_MM2S_CMD_MISO  : in t_axi4_stream_miso;
      
      AXIS_MM2S_STS_MOSI  : in t_axi4_stream_mosi_status;
      AXIS_MM2S_STS_MISO  : out t_axi4_stream_miso;
      
      AXIS_S2MM_CMD_MOSI  : out t_axi4_stream_mosi72;
      AXIS_S2MM_CMD_MISO  : in t_axi4_stream_miso;
      
      AXIS_S2MM_STS_MOSI  : in t_axi4_stream_mosi_status;
      AXIS_S2MM_STS_MISO  : out t_axi4_stream_miso;
      
      --CTRL INTF
      BUFFER_MODE         : in BufferMode;
      NEW_IMAGE_DETECT    : in std_logic;
      ACQUISITION_STOP    : in std_logic;
      MOI                 : in std_logic;
      FULL                : out std_logic;
      
      --WRITE MODE
      CONFIG_VALID        : in STD_LOGIC;        
      NB_SEQUENCE         : in unsigned(7 downto 0);
      FRAME_SIZE          : in unsigned(31 DOWNTO 0);         -- in pixels
      HDR_BYTESSIZE       : in unsigned(31 downto 0);         -- in bytes
      IMG_BYTESSIZE       : in unsigned(31 downto 0);         -- in bytes
      MEMORY_BASED_ADDR   : in std_logic_vector(31 downto 0); -- START of DDR buffering memory location
      SEQ_IMG_TOTAL       : in unsigned(31 downto 0);
      NB_IMG_PRE          : in unsigned(31 downto 0); 
      NB_IMG_POST         : in unsigned(31 downto 0); -- including MOI
      
      --READ MODE
      NB_SEQUENCE_IN_MEM  : out unsigned(7 downto 0); -- including MOI        
      READ_SEQUENCE_ID    : in unsigned(7 downto 0);
      READ_START_ID       : in unsigned(31 downto 0);
      READ_STOP_ID        : in unsigned(31 downto 0);
      RD_MIN_FRAME_TIME   : in unsigned(31 downto 0);
      WATER_LEVEL         : in std_logic;
      IMG_READ_EOF        : in std_logic;
      
      --CLEAR MODE
      CLEAR_MEMORY_CONTENT    : in std_logic;
      
      --TABLE INFORMATION TO STORE BUFFER INFORMATION
      BM_TABLE_ADDR       : out std_logic_Vector(7 downto 0); --256 sequence max
      BM_TABLE_WR_DATA         : out std_logic_vector( 95 downto 0); -- [ START_LOC & MOI_LOC & END_IMG_LOC ]
      BM_TABLE_WREN       : out std_logic;
      BM_TABLE_REN        : out std_logic;
      BM_TABLE_RD_DATA        : in std_logic_vector( 95 downto 0); -- [ START_LOC & MOI_LOC & END_IMG_LOC ]
      BM_TABLE_R_DVAL     : in std_logic; 
      
      --ERROR MONITORING
      WRITE_ERR : out std_logic_vector(3 downto 0);
      READ_ERR : out std_logic_vector(3 downto 0)      
      );
end BUFFERING_FSM;

architecture rtl of BUFFERING_FSM is
   
   -- declaring components explicitly eases synthesis file ordering mess!
   component SYNC_RESETN is
      port(
         --clk and reset
         CLK    : in std_logic;
         ARESETN : in std_logic;
         SRESETN : out std_logic
         );
   end component;
   
   component SYNC_RESET is
      port(
         --clk and reset
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
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
   
   --RESET
   signal sresetn     : std_logic;
   signal sreset      : std_logic;
   signal img_write_reset : std_logic := '1'; 
   signal areset      : std_logic;
   
   --Config
   signal buffer_mode_s : BufferMode;
   signal frame_size_u :unsigned(FRAME_SIZE'length-1 downto 0);
   signal img_bytessize_u :unsigned(IMG_BYTESSIZE'length-1 downto 0);
   signal hdr_bytessize_u :unsigned(HDR_BYTESSIZE'length-1 downto 0);
   signal baseaddr_s : std_logic_vector(MEMORY_BASED_ADDR'length-1 downto 0);
   signal baseaddr_u : unsigned(MEMORY_BASED_ADDR'length-1 downto 0);
   signal nb_sequence_u : unsigned(NB_SEQUENCE'length-1 downto 0);
   signal total_img_per_seq_u : unsigned(SEQ_IMG_TOTAL'length-1 downto 0);
   signal config_valid_s : std_logic; 
   
   --WR CONFIG
   signal nb_img_pre_u : unsigned(NB_IMG_PRE'length-1 downto 0);
   signal nb_img_post_u : unsigned(NB_IMG_POST'length-1 downto 0);
   signal SeqSizeMax_bytes_u : unsigned (31 downto 0); 
   signal wr_sequence_offset : unsigned(31 downto 0);
   signal wr_frame_offset : unsigned(31 downto 0);
   signal wr_frame_offset_temp : unsigned(31 downto 0);
   signal wr_memory_offset_temp : unsigned(31 downto 0);
   signal wr_memory_offset : unsigned(31 downto 0);
   signal wr_img_memory_offset : unsigned(31 downto 0);
   
   signal rd_sequence_offset : unsigned(31 downto 0);
   signal rd_image_offset : unsigned(31 downto 0);
   signal rd_image_offset_temp : unsigned(31 downto 0);
   signal rd_memory_offset_temp : unsigned(31 downto 0);
   signal rd_memory_offset : unsigned(31 downto 0);
   signal rd_img_memory_offset : unsigned(31 downto 0);
   
   --RD CONFIG
   signal nb_seq_in_mem_u : unsigned(NB_SEQUENCE_IN_MEM'length-1 downto 0) := to_unsigned(0,NB_SEQUENCE_IN_MEM'length);
   signal read_seq_id_u : unsigned(READ_SEQUENCE_ID'length-1 downto 0);   
   --signal read_img_id_u : unsigned(READ_IMG_ID'length-1 downto 0);
   signal read_start_id_u : unsigned(READ_START_ID'length-1 downto 0);
   signal read_stop_id_u : unsigned(READ_STOP_ID'length-1 downto 0);
   signal water_level_i : std_logic;
   signal img_read_eof_i : std_logic;
   
   signal rd_delay_cnt : unsigned(31 downto 0);
   signal rd_min_frame_time_hold : unsigned(31 downto 0);
   
   -- buffertable management
   signal seq_id : unsigned(NB_SEQUENCE_IN_MEM'length-1 downto 0) := to_unsigned(0,NB_SEQUENCE_IN_MEM'length);
   signal start_loc_s : unsigned(SEQ_IMG_TOTAL'length-1 downto 0);
   signal moi_loc_s : unsigned(SEQ_IMG_TOTAL'length-1 downto 0);
   signal end_loc_s : unsigned(SEQ_IMG_TOTAL'length-1 downto 0);
   signal write_buftable : std_logic;
   
   -- buffer ctrl
   signal moi_i : std_logic;
   
   --CMD constant
   constant c_xCACHE : std_logic_vector(3 downto 0) := "0011"; -- Recommended dflt value
   constant c_xUSER : std_logic_vector(3 downto 0) := "0000"; -- Not used
   constant c_RSVD : std_logic_vector(3 downto 0) := "0000"; -- Not used
   constant c_DRR : std_logic := '0'; -- Not used
   constant c_DSA : std_logic_vector(5 downto 0) := "000000"; -- Not used
   constant c_TYPE : std_logic := '1'; -- FIXED=0 , INCR=1 
   
   --CMD Signal
   signal s_mm2s_cmd_tag : std_logic_vector(3 downto 0) :="0000";
   signal s_s2mm_cmd_tag : std_logic_vector(3 downto 0) :="0000";
   signal s_mm2s_saddr : std_logic_vector(31 downto 0) := x"00000000";
   signal s_s2mm_saddr : std_logic_vector(31 downto 0) := x"00000000";
   signal s_mm2s_eof : std_logic := '0';
   signal s_s2mm_eof : std_logic := '0';
   signal s_mm2s_btt : std_logic_vector(22 downto 0) := x"00000" & b"000";
   signal s_s2mm_btt : std_logic_vector(22 downto 0) := x"00000" & b"000";  
   
   --OUTPUT Signal
   signal mm2s_err_o : std_logic_vector(3 downto 0); -- (SLVERR & DECERR &INTERR &TAGERR )
   signal s2mm_err_o : std_logic_vector(3 downto 0); -- (SLVERR & DECERR &INTERR &TAGERR )
   
   --Type definition
   signal write_state : BufferWrState := STANDBY_WR;
   signal next_write_state : BufferWrState := STANDBY_WR;
   signal read_state  : BufferRdState := STANDBY_RD;
   signal next_read_state  : BufferRdState := STANDBY_RD;
   
   --signal next_img_write_loc : unsigned(SEQ_IMG_TOTAL'length-1 downto 0) := to_unsigned(0,SEQ_IMG_TOTAL'length); -- Location of the next image to write (ex: loc =0 , loc = 1 etc...)
   --signal next_img_read_loc : unsigned(SEQ_IMG_TOTAL'length-1 downto 0) := to_unsigned(0,SEQ_IMG_TOTAL'length); -- Location of the next image to read (ex: loc =0 , loc = 1 etc...)
   
   signal write_img_loc : unsigned(SEQ_IMG_TOTAL'length-1 downto 0) := to_unsigned(0,SEQ_IMG_TOTAL'length); -- Location of the img write
   signal read_img_loc : unsigned(SEQ_IMG_TOTAL'length-1 downto 0) := to_unsigned(0,SEQ_IMG_TOTAL'length); -- Location of the img read 
   
   
   signal s2mm_cmd_mosi : t_axi4_stream_mosi72 := axi4_stream_mosi72_dflt;
   signal mm2s_cmd_mosi : t_axi4_stream_mosi72 := axi4_stream_mosi72_dflt;
   signal s2mm_cmd_miso : t_axi4_stream_miso;
   signal mm2s_cmd_miso : t_axi4_stream_miso;
   
   signal s2mm_sts_mosi : t_axi4_stream_mosi_status;
   signal mm2s_sts_mosi : t_axi4_stream_mosi_status;
   signal s2mm_sts_miso : t_axi4_stream_miso;
   signal mm2s_sts_miso : t_axi4_stream_miso;
   
begin
   
   areset <= not  ARESETN;
   
   -- resync reset
   inst_sync_reset_n : sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK_DATA);
   inst_sync_reset   : sync_reset port map(ARESET => areset, SRESET => sreset, CLK => CLK_DATA);
   
   WL_sync : double_sync port map(D => WATER_LEVEL, Q => water_level_i, RESET => sreset, CLK => CLK_DATA);
   
   baseaddr_s <= MEMORY_BASED_ADDR;
   baseaddr_u <= unsigned(baseaddr_s);
   
   frame_size_u <= FRAME_SIZE;
   hdr_bytessize_u <= HDR_BYTESSIZE;
   img_bytessize_u <= IMG_BYTESSIZE;
   nb_sequence_u <= NB_SEQUENCE;
   total_img_per_seq_u <= SEQ_IMG_TOTAL;
   
   nb_img_pre_u <= NB_IMG_PRE;
   nb_img_post_u <= NB_IMG_POST;
   
   config_valid_s <= CONFIG_VALID;
   buffer_mode_s  <= BUFFER_MODE;
   
   
   read_seq_id_u <= READ_SEQUENCE_ID;
   read_start_id_u <= READ_START_ID;
   read_stop_id_u <= READ_STOP_ID;
   
   
   
   -- MAP OUTPUTS
   --Cmd structure generation
   mm2s_cmd_mosi.TDATA <= (c_RSVD & s_mm2s_cmd_tag & s_mm2s_saddr & c_DRR & s_mm2s_eof & c_DSA & c_TYPE & s_mm2s_btt);
   s2mm_cmd_mosi.TDATA <= (c_RSVD & s_s2mm_cmd_tag & s_s2mm_saddr & c_DRR & s_s2mm_eof & c_DSA & c_TYPE & s_s2mm_btt);
   
   mm2s_cmd_mosi.TKEEP <= (others => '0');
   mm2s_cmd_mosi.TUSER <= (others => '0');
   mm2s_cmd_mosi.TID <= (others => '0');
   mm2s_cmd_mosi.TSTRB <= (others => '0');
   mm2s_cmd_mosi.TDEST <= (others => '0');
   
   s2mm_cmd_mosi.TKEEP <= (others => '0');
   s2mm_cmd_mosi.TUSER <= (others => '0');
   s2mm_cmd_mosi.TID <= (others => '0');
   s2mm_cmd_mosi.TSTRB <= (others => '0');
   s2mm_cmd_mosi.TDEST <= (others => '0');
   
   
   AXIS_MM2S_CMD_MOSI <= mm2s_cmd_mosi;
   AXIS_MM2S_STS_MISO <= mm2s_sts_miso;
   AXIS_S2MM_CMD_MOSI <= s2mm_cmd_mosi;
   AXIS_S2MM_STS_MISO <= s2mm_sts_miso;
   
   NB_SEQUENCE_IN_MEM <= nb_seq_in_mem_u;
   
   
   --map input
   mm2s_cmd_miso <= AXIS_MM2S_CMD_MISO;
   mm2s_sts_mosi <= AXIS_MM2S_STS_MOSI;
   s2mm_cmd_miso <= AXIS_S2MM_CMD_MISO;
   s2mm_sts_mosi <= AXIS_S2MM_STS_MOSI;
   
   FULL <= '1' when (nb_seq_in_mem_u = nb_sequence_u) else '0';
   
   WRITE_ERR <= s2mm_err_o;
   READ_ERR  <= mm2s_err_o;
   --TODO DEBUG
   
   
   
   -- Synchronous calculation for timing closure with the DSP48 bloc in the FSM
   Synchronous_calc : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         if sresetn = '0' then
            SeqSizeMax_bytes_u <= to_unsigned(0,32);
            
            wr_sequence_offset <= to_unsigned(0,32);
            wr_frame_offset <= to_unsigned(0,32);
            wr_frame_offset_temp <= to_unsigned(0,32);
            
            rd_sequence_offset <= to_unsigned(0,32);
            rd_image_offset <= to_unsigned(0,32);
            rd_image_offset_temp <= to_unsigned(0,32);
         else
            SeqSizeMax_bytes_u <= resize(shift_left(frame_size_u,1) * total_img_per_seq_u,32);
            
            wr_sequence_offset <= resize( (nb_seq_in_mem_u * SeqSizeMax_bytes_u),32);
            wr_frame_offset_temp <= resize( (write_img_loc * shift_left(unsigned(frame_size_u),1)), 32);
            wr_frame_offset <= wr_frame_offset_temp;
            
            rd_sequence_offset <= resize( (read_seq_id_u * SeqSizeMax_bytes_u),32);
            rd_image_offset_temp <= resize( (read_img_loc * shift_left(unsigned(frame_size_u),1)), 32);
            rd_image_offset <= rd_image_offset_temp;
            
            wr_memory_offset_temp <= resize(baseaddr_u + wr_sequence_offset,32);
            wr_memory_offset <= resize(wr_memory_offset_temp +  wr_frame_offset,32);
            wr_img_memory_offset <= resize(wr_memory_offset +  hdr_bytessize_u,32);
            
            rd_memory_offset_temp <= resize(baseaddr_u + rd_sequence_offset,32);
            rd_memory_offset <= resize(rd_memory_offset_temp + rd_image_offset,32);
            rd_img_memory_offset <= resize(rd_memory_offset + hdr_bytessize_u,32);
         end if;
         
         
      end if;
   end process Synchronous_calc;
   
   
   img_write : process(CLK_DATA)
      --  ENO 4 avril 2016. Problème potentiel de timings: niveau logique extrêmement élevé dans cette machine à états.
      --  il aurait été préférbale de le scinder en plusieurs petites machines à états.
   begin
      if rising_edge(CLK_DATA) then

         img_write_reset <= sreset or not config_valid_s;
         
         if img_write_reset = '1' then
            write_state <= STANDBY_WR;
            next_write_state <= STANDBY_WR;
            --signal/output to assigned during the process
            s_s2mm_cmd_tag <= (others => '0');
            s_s2mm_saddr <= (others => '0');
            s_s2mm_eof <=  '0';
            s_s2mm_btt <= (others => '0');
            s2mm_cmd_mosi.tvalid <= '0';
            
            write_img_loc <= (others => '0');
            
            if (sresetn = '0' or CLEAR_MEMORY_CONTENT = '1') then
               nb_seq_in_mem_u <= to_unsigned(0,nb_seq_in_mem_u'length);
            else
               nb_seq_in_mem_u <= nb_seq_in_mem_u;
            end if;
            
            write_buftable <= '0';
            moi_i <= '0';
            seq_id <= (others => '0');
         else
            --CHECK MOI
            if(ACQUISITION_STOP = '1') then
               moi_i <= '0';
            elsif(MOI = '1') then
               moi_i <= '1';
            end if;
            
            --Process state machine
            case write_state is
               --type BufferMode is (BUF_OFF, BUF_WR_SEQ, BUF_RD_SEQ, BUF_RD_IMG);
               --type BufferWrState is (STANDBY_WR, WR_PRE_MOI, WR_WAIT_MOI, WR_POST_MOI, ERROR_WR);
               when STANDBY_WR =>
                  if(buffer_mode_s = BUF_WR_SEQ and NEW_IMAGE_DETECT = '1' and nb_seq_in_mem_u < nb_sequence_u and ACQUISITION_STOP = '0') then --Mode Gige standard
                     --change state
                     if(moi_i = '1') then
                        next_write_state <= WR_POST_MOI;
                        moi_loc_s  <= to_unsigned(0,moi_loc_s'length);
                        start_loc_s <= to_unsigned(0,start_loc_s'length);
                        end_loc_s <= total_img_per_seq_u-1;
                        moi_i <= '0';
                     else
                        next_write_state <= WR_PRE_MOI;    
                     end if;
                     write_state <= WAIT_WR_HDR_CMD_ACK;
                     --fill the tag with the img position
                     s_s2mm_cmd_tag <= resize(std_logic_vector(write_img_loc),4);                        
                     s_s2mm_saddr <= resize(std_logic_vector(wr_memory_offset),32); -- base +sequenceoffset + imageoffset
                     s_s2mm_eof <=  '1';
                     s_s2mm_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- in Bytes 
                     s2mm_cmd_mosi.tvalid <= '1';
                     
                     write_img_loc <= write_img_loc + 1;
                     --s2mm_err_o <= s2mm_err_o;
                  else
                     write_state <= STANDBY_WR;
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= (others => '0');
                     s_s2mm_saddr <= (others => '0');
                     s_s2mm_eof <='0'; 
                     s_s2mm_btt <= (others => '0');
                     s2mm_cmd_mosi.tvalid <= '0';
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                  end if;
                  write_buftable <= '0';
               
               when WAIT_WR_HDR_CMD_ACK =>
                  if(s2mm_cmd_miso.tready = '1') then -- CMD transaction completed
                     --end wr_cmd transaction and move to next state
                     write_state <= WAIT_WR_IMG_CMD_ACK;
                     s2mm_cmd_mosi.tvalid <= '1';
                     --fill the tag with the img position
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;                        
                     s_s2mm_saddr <= std_logic_vector(unsigned(wr_img_memory_offset)); -- base +sequenceoffset + imageoffset
                     s_s2mm_eof <=  '1';
                     s_s2mm_btt <= resize(std_logic_vector(img_bytessize_u),s_s2mm_btt'length);
                     
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                     
                  else
                     write_state <= write_state;
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <= s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                  end if;
                  write_buftable <= '0';
               
               when WAIT_WR_IMG_CMD_ACK =>
                  if(s2mm_cmd_miso.tready = '1') then -- CMD transaction completed
                     --end wr_cmd transaction and move to next state
                     write_state <= next_write_state;
                     s2mm_cmd_mosi.tvalid <= '0';
                     --fill the tag with the img position
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;                        
                     s_s2mm_saddr <= s_s2mm_saddr; -- base +sequenceoffset + imageoffset
                     s_s2mm_eof <=  s_s2mm_eof;
                     s_s2mm_btt <= s_s2mm_btt;
                     
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                     
                  else
                     write_state <= write_state;
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                  end if;
                  write_buftable <= '0';                    
               
               when WR_PRE_MOI =>
                  --Send a write cmd
                  --ATTENTION AU CAS PAS DE MOI POUR LE RETOUR A STANDBY
                  --wait for the last cmd to be process then send the next cmd(write_img)
                  --change state
                  if( ACQUISITION_STOP = '1') then
                     write_state <= STANDBY_WR;
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= to_unsigned(0,write_img_loc'length);
                     --s2mm_err_o <= s2mm_err_o;
                  elsif(NEW_IMAGE_DETECT = '1') then
                     if(moi_i = '1') then
                        next_write_state <= WR_POST_MOI;
                        start_loc_s <= to_unsigned(0,start_loc_s'length);
                        moi_loc_s  <= write_img_loc;
                        end_loc_s <= total_img_per_seq_u-1;
                        moi_i <= '0';
                     elsif(write_img_loc >= nb_img_pre_u) then
                        next_write_state <= WR_WAIT_MOI;
                     else
                        next_write_state <= WR_PRE_MOI;
                     end if;
                     write_state <= WAIT_WR_HDR_CMD_ACK;
                     
                     --fill the tag with the img position
                     s_s2mm_cmd_tag <= resize(std_logic_vector(write_img_loc),4); 
                     s_s2mm_saddr <= resize(std_logic_vector(wr_memory_offset),32); -- base +sequenceoffset + imageoffset
                     s_s2mm_eof <=  '1';
                     s_s2mm_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- in Bytes
                     s2mm_cmd_mosi.tvalid <= '1'; --invalidate de data
                     
                     if ( (write_img_loc + 1) = total_img_per_seq_u) then -- write loc from 0 to total_img_per_seq_u-1   ENO 4 avril 2016. Operation mathematique couplée à une comparaison. À éviter si possible
                        write_img_loc <= to_unsigned(0,write_img_loc'length);
                     else 
                        write_img_loc <= write_img_loc + 1;
                     end if;
                     --s2mm_err_o <= s2mm_err_o;
                  else
                     write_state <= write_state;
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                  end if;
                  write_buftable <= '0';
               
               when WR_WAIT_MOI =>
                  --Send a write cmd
                  if( ACQUISITION_STOP = '1') then
                     write_state <= STANDBY_WR;
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= to_unsigned(0,write_img_loc'length);
                     --s2mm_err_o <= s2mm_err_o;
                     write_buftable <= '0';
                  elsif(NEW_IMAGE_DETECT = '1') then
                     --wait for the last cmd to be process then wait for the 2 cmd sts
                     --change state
                     if(moi_i = '1') then
                        moi_i <= '0';
                        
                        moi_loc_s  <= write_img_loc;
                        if(nb_img_pre_u = total_img_per_seq_u-1) then --Buf lin, MOI end of seq     --  ENO 4 avril 2016. Problème potentiel de timings: niveau logique élevé
                           next_write_state <= STANDBY_WR;
                           write_img_loc <=  to_unsigned(0,write_img_loc'length);
                           write_buftable <= '1';
                           seq_id <= nb_seq_in_mem_u;
                           nb_seq_in_mem_u <= nb_seq_in_mem_u + 1;
                           
                           end_loc_s <= write_img_loc;
                           if(write_img_loc > nb_img_pre_u) then                                   --  ENO 4 avril 2016. Problème potentiel de timings: niveau logique élevé
                              start_loc_s <= write_img_loc - nb_img_pre_u;
                           elsif(write_img_loc = nb_img_pre_u) then
                              start_loc_s <= to_unsigned(0,start_loc_s'length);
                           elsif(write_img_loc < nb_img_pre_u) then
                              start_loc_s <= total_img_per_seq_u + write_img_loc - nb_img_pre_u;
                           end if;
                           
                           
                        else
                           next_write_state <= WR_POST_MOI;
                           
                           if ( (write_img_loc + 1) = total_img_per_seq_u) then -- write loc from 0 to total_img_per_seq_u-1
                              write_img_loc <= to_unsigned(0,write_img_loc'length);
                           else 
                              write_img_loc <= write_img_loc + 1;
                           end if;
                           
                           if(write_img_loc > nb_img_pre_u) then
                              start_loc_s <= write_img_loc - nb_img_pre_u;
                              end_loc_s <= write_img_loc - nb_img_pre_u -1;
                           elsif(write_img_loc = nb_img_pre_u) then
                              start_loc_s <= to_unsigned(0,start_loc_s'length);
                              end_loc_s <= total_img_per_seq_u-1;
                           elsif(write_img_loc < nb_img_pre_u) then
                              start_loc_s <= total_img_per_seq_u + write_img_loc - nb_img_pre_u;
                              end_loc_s <= write_img_loc + nb_img_post_u - 1;
                           end if;
                           write_buftable <= '0';
                        end if;
                        
                     else
                        next_write_state <= WR_WAIT_MOI;
                        write_buftable <= '0';
                        if ( (write_img_loc + 1) = total_img_per_seq_u) then -- write loc from 0 to total_img_per_seq_u-1
                           write_img_loc <= to_unsigned(0,write_img_loc'length);
                        else 
                           write_img_loc <= write_img_loc + 1;
                        end if;
                     end if;
                     write_state <= WAIT_WR_HDR_CMD_ACK;
                     
                     --fill the tag with the img position
                     s_s2mm_cmd_tag <= resize(std_logic_vector(write_img_loc),4); 
                     s_s2mm_saddr <= resize(std_logic_vector(wr_memory_offset),32); -- base +sequenceoffset + imageoffset
                     s_s2mm_eof <=  '1';
                     s_s2mm_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- in Bytes
                     s2mm_cmd_mosi.tvalid <= '1'; --invalidate de data
                     
                     --s2mm_err_o <= s2mm_err_o;
                  else
                     write_state <= write_state;
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                     write_buftable <= '0';
                  end if;
               
               when WR_POST_MOI =>
                  moi_i <= '0';
                  if(NEW_IMAGE_DETECT = '1') then
                     
                     if( write_img_loc = end_loc_s or ACQUISITION_STOP = '1') then
                        next_write_state <= STANDBY_WR;
                        end_loc_s <= write_img_loc;
                        write_buftable <= '1';
                        seq_id <= nb_seq_in_mem_u;
                        nb_seq_in_mem_u <= nb_seq_in_mem_u + 1;
                        write_img_loc <= to_unsigned(0,write_img_loc'length);
                     else
                        next_write_state <= WR_POST_MOI;
                        write_buftable <= '0';
                        
                        if ( (write_img_loc + 1) = total_img_per_seq_u or ACQUISITION_STOP = '1') then -- write loc from 0 to total_img_per_seq_u-1
                           write_img_loc <= to_unsigned(0,write_img_loc'length);
                        else 
                           write_img_loc <= write_img_loc + 1;
                        end if;
                        
                     end if;
                     write_state <= WAIT_WR_HDR_CMD_ACK;
                     
                     --fill the tag with the img position
                     s_s2mm_cmd_tag <= resize(std_logic_vector(write_img_loc),4); 
                     s_s2mm_saddr <= resize(std_logic_vector(wr_memory_offset),32); -- base +sequenceoffset + imageoffset
                     s_s2mm_eof <=  '1';
                     s_s2mm_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- in Bytes 
                     s2mm_cmd_mosi.tvalid <= '1'; --invalidate de data
                     
                     
                     --s2mm_err_o <= s2mm_err_o;
                  elsif(ACQUISITION_STOP = '1') then
                     write_state <= STANDBY_WR;
                     if (write_img_loc /= 0) then
                        end_loc_s <= write_img_loc - 1;
                     else
                        end_loc_s <= total_img_per_seq_u-1;
                     end if;
                     
                     write_buftable <= '1';
                     seq_id <= nb_seq_in_mem_u;
                     nb_seq_in_mem_u <= nb_seq_in_mem_u + 1;
                     write_img_loc <= to_unsigned(0,write_img_loc'length);
                     
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                  else
                     write_state <= write_state;
                     --signal/output to assigned during the process
                     s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                     s_s2mm_saddr <= s_s2mm_saddr;
                     s_s2mm_eof <=s_s2mm_eof; 
                     s_s2mm_btt <= s_s2mm_btt;
                     s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                     
                     write_img_loc <= write_img_loc;
                     --s2mm_err_o <= s2mm_err_o;
                     write_buftable <= '0';
                  end if;
               
               when ERROR_WR =>
                  if( s2mm_sts_mosi.tvalid = '1') then --wait for the transmision status
                     --Check if the reception is valid
                     if ( (s2mm_sts_mosi.tdata(7) = '1') and (s2mm_sts_mosi.tdata(6 downto 4) = "000") and (unsigned(s2mm_sts_mosi.tdata(3 downto 0)) = write_img_loc) ) then --transmit valid
                        
                        --We move to the next state
                        write_state <= Standby_wr;
                        --fill the tag with the img position
                        s_s2mm_cmd_tag <= (others => '0');                        
                        s_s2mm_saddr <= (others => '0');
                        s_s2mm_eof <=  '0';
                        s_s2mm_btt <= (others => '0'); -- Transfert the entire img in 1 cmd
                        s2mm_cmd_mosi.tvalid <= '0';
                        
                        write_img_loc <= write_img_loc;
                        
                        --s2mm_err_o <= s2mm_err_o;
                     else -- there was an transmit error
                        write_state <= ERROR_WR;
                        --signal/output to assigned during the process
                        s_s2mm_cmd_tag <= (others => '0');
                        s_s2mm_saddr <= (others => '0');
                        s_s2mm_eof <=  '0';
                        s_s2mm_btt <= (others => '0');
                        s2mm_cmd_mosi.tvalid <= '0';
                        
                        write_img_loc <= to_unsigned(0,write_img_loc'length);
                        
                        
                        --s2mm_err_o(3 downto 1) <= s2mm_sts_mosi.tdata(6 downto 4);
                        
                        
                     end if;     
                  else --wait until transmis is over
                     write_state <= write_state;
                     s_s2mm_cmd_tag <= (others => '0');
                     s_s2mm_saddr <= (others => '0');
                     s_s2mm_eof <='0'; 
                     s_s2mm_btt <= (others => '0');
                     s2mm_cmd_mosi.tvalid <= '0';
                     
                     write_img_loc <= write_img_loc;
                     
                     --s2mm_err_o <= s2mm_err_o;
                  end if;
               write_buftable <= '0';
               when others =>
                  write_state <= write_state;
                  --signal/output to assigned during the process
                  s_s2mm_cmd_tag <= s_s2mm_cmd_tag;
                  s_s2mm_saddr <= s_s2mm_saddr;
                  s_s2mm_eof <=s_s2mm_eof; 
                  s_s2mm_btt <= s_s2mm_btt;
                  s2mm_cmd_mosi.tvalid <= s2mm_cmd_mosi.tvalid;
                  
                  write_img_loc <= write_img_loc;
               --s2mm_err_o <= s2mm_err_o;
            end case;
            
         end if;
      end if;
      
   end process img_write;
   
   write_buffer_table : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         if(write_buftable = '1') then
            BM_TABLE_ADDR       <= std_logic_vector(seq_id);
            BM_TABLE_WREN       <= '1';
            BM_TABLE_WR_DATA    <= std_logic_vector(end_loc_s  & moi_loc_s & start_loc_s);
            BM_TABLE_REN        <= '0';
         else
            BM_TABLE_ADDR       <= std_logic_vector(seq_id);
            BM_TABLE_WREN       <= '0';
            BM_TABLE_WR_DATA    <= std_logic_vector( end_loc_s & moi_loc_s & start_loc_s );
            BM_TABLE_REN        <= '0';
         end if;
      end if;
   end process;
   --We read the image frame by frame not hdr and img split in 2 for gige
   
   img_read : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         if img_write_reset = '1' then
            read_state <= STANDBY_RD;
            --signal/output to assigned during the process
            s_mm2s_cmd_tag <= (others => '0');
            s_mm2s_saddr <= (others => '0');
            s_mm2s_eof <=  '0';
            s_mm2s_btt <= (others => '0');
            mm2s_cmd_mosi.tvalid <= '0';
            read_img_loc <= read_start_id_u;
            mm2s_err_o <= (others => '0');
            mm2s_sts_miso.tready <= '0';
            
            rd_delay_cnt <= (others => '0');       
            rd_min_frame_time_hold <= RD_MIN_FRAME_TIME;
         else
            rd_delay_cnt <= rd_delay_cnt + 1;
            
            case read_state is
               when STANDBY_RD =>
                  
                  rd_min_frame_time_hold <= RD_MIN_FRAME_TIME;
                  
                  if(buffer_mode_s = BUF_RD_IMG and water_level_i = '0') then --Mode Gige standard and image available
                     --change state
                     read_state <= WAIT_RD_HDR_ACK;
                     
                     --fill the tag with the img position
                     s_mm2s_cmd_tag <= resize(std_logic_vector(read_img_loc),4);                        
                     s_mm2s_saddr <= resize(std_logic_vector(rd_memory_offset),32);
                     s_mm2s_eof <=  '1';
                     s_mm2s_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- Transfert of the hdr data 
                     mm2s_cmd_mosi.tvalid <= '1';
                     mm2s_sts_miso.tready <= '0';
                     
                     
                     if(read_img_loc = read_stop_id_u) then -- only one image to read
                        next_read_state <= RD_SEQ_END;
                        read_img_loc <= read_start_id_u;
                     elsif(read_img_loc = total_img_per_seq_u-1 ) then
                        next_read_state <= RD_IMG;
                        read_img_loc <= to_unsigned(0,read_img_loc'length); -- counter reset at 0
                     else
                        next_read_state <= RD_IMG;
                        read_img_loc <= read_img_loc + 1; --increase counter position
                     end if;
                     
                     
                  else
                     read_state <= STANDBY_RD;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= (others => '0');
                     s_mm2s_saddr <= (others => '0');
                     s_mm2s_eof <='0'; 
                     s_mm2s_btt <= (others => '0');
                     mm2s_cmd_mosi.tvalid <= '0';
                     mm2s_sts_miso.tready <= '0';
                     
                     read_img_loc <= read_start_id_u;
                     
                  end if;
               
               when RD_IMG =>
                  if(buffer_mode_s = BUF_RD_IMG and water_level_i = '0') then --Mode Gige standard and image available
                     read_state <= WAIT_RD_HDR_ACK;
                     
                     --fill the tag with the img position
                     s_mm2s_cmd_tag <= resize(std_logic_vector(read_img_loc),4);                        
                     s_mm2s_saddr <= resize(std_logic_vector(rd_memory_offset),32);
                     s_mm2s_eof <=  '1';
                     s_mm2s_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- Transfert of the hdr data 
                     mm2s_cmd_mosi.tvalid <= '1';
                     mm2s_sts_miso.tready <= '0';
                     
                     
                     
                     if(read_img_loc = read_stop_id_u) then -- only one image to read
                        next_read_state <= RD_SEQ_END;
                        read_img_loc <= read_start_id_u;
                     elsif(read_img_loc = total_img_per_seq_u-1 ) then
                        next_read_state <= RD_IMG;
                        read_img_loc <= to_unsigned(0,read_img_loc'length); -- counter reset at 0
                     else
                        next_read_state <= RD_IMG;
                        read_img_loc <= read_img_loc + 1; --increase counter position
                     end if;
                  else
                     if(water_level_i = '1') then
                        read_state <= RD_WAIT_SINK_RDY;
                     else
                        read_state <= read_state;
                     end if;
                     
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <=s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= mm2s_cmd_mosi.tvalid;
                     mm2s_sts_miso.tready <= '0';
                     
                     read_img_loc <= read_img_loc;
                     
                  end if; 
               
               when RD_WAIT_SINK_RDY =>
                  if(buffer_mode_s = BUF_RD_IMG and water_level_i = '0') then -- EXIT PAUSE MODE
                     read_state <= WAIT_RD_HDR_ACK;
                     
                     --fill the tag with the img position
                     s_mm2s_cmd_tag <= resize(std_logic_vector(read_img_loc),4);                        
                     s_mm2s_saddr <= resize(std_logic_vector(rd_memory_offset),32);
                     s_mm2s_eof <=  '1';
                     s_mm2s_btt <= resize(std_logic_vector(hdr_bytessize_u),s_s2mm_btt'length); -- Transfert of the hdr data 
                     mm2s_cmd_mosi.tvalid <= '1';
                     mm2s_sts_miso.tready <= '0';
                     
                     
                     
                     if(read_img_loc = read_stop_id_u) then -- only one image to read
                        next_read_state <= RD_SEQ_END;
                        read_img_loc <= read_start_id_u;
                     elsif(read_img_loc = total_img_per_seq_u-1 ) then
                        next_read_state <= RD_IMG;
                        read_img_loc <= to_unsigned(0,read_img_loc'length); -- counter reset at 0
                     else
                        next_read_state <= RD_IMG;
                        read_img_loc <= read_img_loc + 1; --increase counter position
                     end if;
                  else
                     read_state <= read_state;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <=s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= mm2s_cmd_mosi.tvalid;
                     mm2s_sts_miso.tready <= '0';
                     
                     read_img_loc <= read_img_loc;
                     
                  end if;
               
               when WAIT_RD_HDR_ACK =>
                  if(mm2s_cmd_miso.tready = '1') then --Mode Gige standard and image available
                     read_state <= WAIT_RD_IMG_ACK;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= std_logic_vector(unsigned(rd_img_memory_offset));
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <= resize(std_logic_vector(img_bytessize_u),s_s2mm_btt'length); -- Transfert of the hdr data 
                     mm2s_cmd_mosi.tvalid <= '1';
                     mm2s_sts_miso.tready <= '0';
                     
                     read_img_loc <= read_img_loc;
                     
                  else
                     read_state <= read_state;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <=s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <=s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= mm2s_cmd_mosi.tvalid;
                     mm2s_sts_miso.tready <= '0';
                     
                     read_img_loc <= read_img_loc;
                     
                  end if;
               
               when WAIT_RD_IMG_ACK =>
                  if(mm2s_cmd_miso.tready = '1') then --Mode Gige standard and image available
                     read_state <= WAIT_RD_HDR_STS_ACK;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <= s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= '0';
                     mm2s_sts_miso.tready <= '1';
                     
                     read_img_loc <= read_img_loc;
                     
                  else
                     read_state <= read_state;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <=s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= mm2s_cmd_mosi.tvalid;
                     
                     read_img_loc <= read_img_loc;
                     
                  end if;
               
               when WAIT_RD_HDR_STS_ACK =>
                  if(mm2s_sts_mosi.tvalid = '1') then --Mode Gige standard and image available
                     read_state <= WAIT_RD_IMG_STS_ACK;
                     -- Check for error
                     if(mm2s_sts_mosi.tdata(6 downto 4) /= "000") then
                        mm2s_err_o(2 downto 0) <=  mm2s_sts_mosi.tdata(6 downto 4);
                     else
                        mm2s_err_o <=  mm2s_err_o;
                     end if;
                     
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <= s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= '0';
                     mm2s_sts_miso.tready <= '0';
                     
                     read_img_loc <= read_img_loc;
                     
                  else
                     read_state <= read_state;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <=s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= mm2s_cmd_mosi.tvalid;
                     
                     read_img_loc <= read_img_loc;
                     
                  end if;
               
               when WAIT_RD_IMG_STS_ACK =>
                  if(mm2s_sts_mosi.tvalid = '1') then --Mode Gige standard and image available
                     if rd_delay_cnt >= rd_min_frame_time_hold or next_read_state = RD_SEQ_END then
                        read_state <= next_read_state;
                        rd_delay_cnt <= (others => '0');
                        rd_min_frame_time_hold <= RD_MIN_FRAME_TIME;
                        mm2s_sts_miso.tready <= '1';
                     else
                        read_state <= read_state;
                        mm2s_sts_miso.tready <= '0';
                     end if;
                     
                     -- Check for error
                     if(mm2s_sts_mosi.tdata(6 downto 4) /= "000") then
                        mm2s_err_o(2 downto 0) <=  mm2s_sts_mosi.tdata(6 downto 4);
                     else
                        mm2s_err_o <=  mm2s_err_o;
                     end if;
                     
                     -- react on an stop acquisition command before the download was complete
                     if ACQUISITION_STOP = '1' then
                        read_state <= RD_SEQ_END;
                        mm2s_sts_miso.tready <= '1';
                     end if;
                     
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <= s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= '0';
                     
                     read_img_loc <= read_img_loc;
                     
                  else
                     read_state <= read_state;
                     --signal/output to assigned during the process
                     s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                     s_mm2s_saddr <= s_mm2s_saddr;
                     s_mm2s_eof <=s_mm2s_eof; 
                     s_mm2s_btt <=s_mm2s_btt;
                     mm2s_cmd_mosi.tvalid <= mm2s_cmd_mosi.tvalid;
                     
                     read_img_loc <= read_img_loc;
                     
                  end if;
               
               when RD_SEQ_END =>
                  read_state <= read_state;
                  --signal/output to assigned during the process
                  s_mm2s_cmd_tag <= s_mm2s_cmd_tag;
                  s_mm2s_saddr <= s_mm2s_saddr;
                  s_mm2s_eof <=s_mm2s_eof; 
                  s_mm2s_btt <=s_mm2s_btt;
                  mm2s_cmd_mosi.tvalid <= '0';
                  
                  read_img_loc <= read_start_id_u;
                  
               
               when ERROR_RD =>
                  read_state <= STANDBY_RD;
               read_img_loc <= read_start_id_u;
               when others =>
            end case;
         end if;
      end if;
      
   end process img_read;
   
   img_write_status : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         if sresetn = '0' then
            s2mm_err_o <= (others => '0');
            s2mm_sts_miso.tready <= '1' ;
         else
            s2mm_sts_miso.tready <= '1';
            if( s2mm_sts_mosi.tvalid = '1') then
               
               if(s2mm_sts_mosi.tdata(6 downto 4) /= "000") then
                  s2mm_err_o(2 downto 0) <= s2mm_sts_mosi.tdata(6 downto 4);
               end if;
            else
               s2mm_err_o <= s2mm_err_o;
            end if;
         end if;
      end if;
   end process img_write_status;
   
   
   
end rtl;
