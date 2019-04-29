-------------------------------------------------------------------------------
--
-- Title       : AEC_Ctrl
-- Author      : Jean-Alexis Boulet
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : This file implement the axi_lite communication and interrupt gen to the micro blaze
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;
use work.BufferingDefine.all;

entity Buffering_Ctrl is
    port(

    --------------------------------
    -- PowerPC Interface
    -------------------------------- 
    AXI4_LITE_MOSI : in t_axi4_lite_mosi;
    AXI4_LITE_MISO : out t_axi4_lite_miso;   
      
    --------------------------------
    -- BUFFER_FSM_CTRL
    --------------------------------
    MEMORY_BASE_ADDR  : out std_logic_vector(31 downto 0);
    NB_SEQUENCE_MAX   : out unsigned(7 downto 0); -- Sequence
    SEQ_IMG_TOTAL     : out unsigned(31 downto 0);
    FRAME_SIZE        : out unsigned(31 downto 0);
    HDR_BYTESSIZE        : out unsigned(31 downto 0);
    IMG_BYTESSIZE        : out unsigned(31 downto 0);
    RD_MIN_FRAME_TIME : out unsigned(31 downto 0);
    BUFFER_MODE       : out BufferMode;
    CONFIG_VALID      : out std_logic;    

    --------------------------------
    -- BUFFER_FSM_CTRL - WRITE MODE
    --------------------------------
    NB_IMG_PRE        : out unsigned(31 downto 0);
    NB_IMG_POST       : out unsigned(31 downto 0); 

    --------------------------------
    -- BUFFER_FSM_CTRL - READ MODE
    --------------------------------
    NB_SEQ_IN_MEM     : in unsigned(7 downto 0);
    RD_SEQ_ID         : out unsigned(7 downto 0);
    RD_START_ID       : out unsigned(31 downto 0); 
    RD_STOP_ID        : out unsigned(31 downto 0); 

    --------------------------------
    -- BUFFER_FSM_CTRL - CLEAR
    --------------------------------
    CLEAR_MEMORY_CONTENT : out std_logic;

    --------------------------------
    -- BUFFERING DATA PATH
    --------------------------------
    BUFFER_SWITCH   : out std_logic_vector(3 downto 0); -- Bit 0 => SW0, Bit 1 => SW1 Bit 2 => SW2
    MOI_MODE        : out MOI_MODE;
    EXT_EDGE        : out EDGE_TYPE;
    SKIP_DATA       : out std_logic;
    
    
    --------------------------------
    -- MISC
    -------------------------------- 
    FSM_ERROR       : in std_logic_vector(7 downto 0);
    SOFT_MOI        : out std_logic;
    ACQ_STOP        : out std_logic;
    EXT_BUF_PRSNT_N : in  std_logic;

    -- CLK_CTRL
    ARESETN         : in  std_logic;
    CLK_CTRL       : in  std_logic;

    -- CLK_DATA
    CLK_DATA       : in  std_logic
    );
end Buffering_Ctrl;

architecture RTL of Buffering_Ctrl is

  constant C_S_AXI_DATA_WIDTH : integer := 32;
  constant C_S_AXI_ADDR_WIDTH : integer := 32;
  constant ADDR_LSB           : integer := 2;   -- 4 bytes access
  constant OPT_MEM_ADDR_BITS  : integer := 6;   -- Number of supplement bit
   
   ----------------------------   
   -- Address of registers
   ----------------------------   
   constant MEMORY_BASE_ADDR_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_SEQUENCE_MAX_ADDR        : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant SEQ_IMG_TOTAL_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant FRAME_SIZE_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant BUFFER_MODE_ADDR            : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HDR_BYTESSIZE_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant IMG_BYTESSIZE_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_IMG_PRE_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_IMG_POST_ADDR            : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(32,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_SEQ_ID_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(36,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_START_ID_ADDR            : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(40,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_STOP_ID_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(44,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant CLEAR_MEMORY_CONTENT_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(48,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant BUFFER_SWITCH_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(52,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant MOI_SOURCE_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(56,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant MOI_ACTIVATION_ADDR         : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(60,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant SOFT_MOI_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(64,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant ACQ_STOP_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(68,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant CONFIG_VALID_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(72,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_SEQ_IN_MEM_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(76,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant FSM_ERROR_WR_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(80,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant FSM_ERROR_RD_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(84,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant EXT_BUF_PRSNT_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(88,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_MIN_FRAME_TIME_ADDR      : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(92,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));

   
   ----------------------------   
   -- Component Declaration
   ----------------------------   
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
   
   component double_sync_vector
	port(
		D : in STD_LOGIC_vector;
		Q : out STD_LOGIC_vector;
		CLK : in STD_LOGIC
		);
   end component;
   
   component sync_resetn is
      port(
         ARESETN : in STD_LOGIC;
         SRESETN : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;
   
   
   signal sresetn       : std_logic;
   signal sreset        : std_logic;
   signal sresetn_160   : std_logic;
   
   
    --! User Input Register Declarations
    --signal h_lowercumsum_i   : std_logic_vector(23 downto 0); --! h_lowercumsum_reg
    signal nb_seq_in_mem_b  : std_logic_vector(7 downto 0);
    signal nb_seq_in_mem_i  : std_logic_vector(7 downto 0); --! nb_seq_in_mem_register
    signal fsm_wr_err_i     : std_logic_vector(3 downto 0); --! nb_seq_in_mem_register
    signal fsm_rd_err_i     : std_logic_vector(3 downto 0); --! nb_seq_in_mem_register

    --! User Output Register Declarations
    signal memorybaseaddr_o  : std_logic_vector(31 downto 0);     
    signal nb_seq_max_o  : std_logic_vector(7 downto 0);
    signal nb_seq_max_b  : std_logic_vector(7 downto 0);
    
    signal seq_img_total_o  : std_logic_vector(31 downto 0);
    signal seq_img_total_b  : std_logic_vector(31 downto 0);
    
    signal framesize_o  : std_logic_vector(31 downto 0);
    signal framesize_b  : std_logic_vector(31 downto 0);
    
    signal hdr_bytessize_o  : std_logic_vector(31 downto 0);
    signal hdr_bytessize_b  : std_logic_vector(31 downto 0);
    
    signal img_bytessize_o  : std_logic_vector(31 downto 0);
    signal img_bytessize_b  : std_logic_vector(31 downto 0);
    
    signal buffermode_o  : std_logic_vector(3 downto 0);
    signal buffermode_b  : std_logic_vector(3 downto 0);
    
    signal bufferswitch_o  : std_logic_vector(31 downto 0);
    
    signal moi_mode_o   : std_logic_vector(1 downto 0);
    signal moi_mode_b   : std_logic_vector(1 downto 0);
    signal ext_edge_o   : std_logic_vector(1 downto 0);
    signal ext_edge_b   : std_logic_vector(1 downto 0);
    
    signal nb_img_pre_o  : std_logic_vector(31 downto 0);
    signal nb_img_pre_b  : std_logic_vector(31 downto 0);
    
    signal nb_img_post_o  : std_logic_vector(31 downto 0);
    signal nb_img_post_b  : std_logic_vector(31 downto 0);
    
    signal rd_seq_id_o  : std_logic_vector(7 downto 0);
    signal rd_seq_id_b  : std_logic_vector(7 downto 0);
    signal rd_start_id_o  : std_logic_vector(31 downto 0);
    signal rd_start_id_b  : std_logic_vector(31 downto 0);
    signal rd_stop_id_o  : std_logic_vector(31 downto 0);
    signal rd_stop_id_b  : std_logic_vector(31 downto 0);
    
    signal clear_mem_o  : std_logic;
    signal config_valid_o  : std_logic;
    signal soft_moi_o    : std_logic;
    signal acq_stop_o    : std_logic;

    signal rd_min_frame_time_o  : std_logic_vector(31 downto 0);

 
    -- AXI4LITE signals
    signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal axi_awready   : std_logic;
    signal axi_wready	: std_logic;
    signal axi_bresp	    : std_logic_vector(1 downto 0);
    signal axi_bvalid	: std_logic;
    signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal axi_arready   : std_logic;
    signal axi_rdata	    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal axi_rresp	    : std_logic_vector(1 downto 0);
    signal axi_rvalid	: std_logic;
    signal axi_wstrb     : std_logic_vector(3 downto 0);
    
    signal slv_reg_rden  : std_logic;
    signal slv_reg_wren  : std_logic;
    signal reg_data_out  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal byte_index	: integer;
   
begin
  
    sreset <= not  sresetn;
    
    --Explicit TYPE CONVERSION
    nb_seq_in_mem_b <= std_logic_vector(NB_SEQ_IN_MEM);
    
    NB_SEQUENCE_MAX <= unsigned(nb_seq_max_b);
    SEQ_IMG_TOTAL   <= unsigned(seq_img_total_b);
    FRAME_SIZE      <= unsigned(framesize_b);
    HDR_BYTESSIZE      <= unsigned(hdr_bytessize_b);
    IMG_BYTESSIZE      <= unsigned(img_bytessize_b);
    NB_IMG_PRE      <= unsigned(nb_img_pre_b);
    NB_IMG_POST     <= unsigned(nb_img_post_b);
    RD_SEQ_ID      <= unsigned(rd_seq_id_b);
    RD_START_ID     <= unsigned(rd_start_id_b);
    RD_STOP_ID     <= unsigned(rd_stop_id_b);
    RD_MIN_FRAME_TIME <= unsigned(rd_min_frame_time_o);



    --BufferMode Assignment


    --BUFFER_MODE <= BUF_OFF ;

    -- enter your statements here --
    U0A : sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK_CTRL);
    
    -- Input ctrl double Sync
    U1A : double_sync_vector port map(D => nb_seq_in_mem_b, Q => nb_seq_in_mem_i ,  CLK => CLK_CTRL);
    U1B : double_sync_vector port map(D => FSM_ERROR(3 downto 0), Q => fsm_wr_err_i ,  CLK => CLK_CTRL);   
    U1C : double_sync_vector port map(D => FSM_ERROR(7 downto 4), Q => fsm_rd_err_i,   CLK => CLK_CTRL);
    
    -- Output ctrl double Sync
    U2A : double_sync_vector port map(D => memorybaseaddr_o,Q => MEMORY_BASE_ADDR,  CLK => CLK_DATA);
    U2B : double_sync_vector port map(D => nb_seq_max_o,    Q => nb_seq_max_b,      CLK => CLK_DATA); 
    U2C : double_sync_vector port map(D => seq_img_total_o, Q => seq_img_total_b ,  CLK => CLK_DATA);
    U2D : double_sync_vector port map(D => framesize_o,     Q => framesize_b ,      CLK => CLK_DATA);
    U2E : double_sync_vector port map(D => bufferswitch_o(3 downto 0),  Q => BUFFER_SWITCH ,    CLK => CLK_DATA); 
    U2F : double_sync_vector port map(D => nb_img_pre_o,    Q => nb_img_pre_b,      CLK => CLK_DATA);
    U2G : double_sync_vector port map(D => nb_img_post_o,   Q => nb_img_post_b,     CLK => CLK_DATA); 
    U2H : double_sync_vector port map(D => rd_seq_id_o,     Q => rd_seq_id_b ,        CLK => CLK_DATA);
    U2I : double_sync_vector port map(D => rd_start_id_o,     Q => rd_start_id_b ,        CLK => CLK_DATA);
    U2J : double_sync_vector port map(D => buffermode_o,  Q => buffermode_b ,    CLK => CLK_DATA);
    U2K : double_sync_vector port map(D => moi_mode_o,  Q => moi_mode_b ,    CLK => CLK_DATA);
    U2L : double_sync_vector port map(D => ext_edge_o,  Q => ext_edge_b ,    CLK => CLK_DATA);
    U2M : double_sync_vector port map(D => rd_stop_id_o,     Q => rd_stop_id_b ,        CLK => CLK_DATA);
    U2N : double_sync_vector port map(D => hdr_bytessize_o,     Q => hdr_bytessize_b ,      CLK => CLK_DATA);
    U2O : double_sync_vector port map(D => img_bytessize_o,     Q => img_bytessize_b ,      CLK => CLK_DATA);
    
    U3A : double_sync port map(D => clear_mem_o,            Q => CLEAR_MEMORY_CONTENT , RESET => sreset,    CLK => CLK_DATA);
    U3B : double_sync port map(D => config_valid_o,         Q => CONFIG_VALID ,         RESET => sreset,    CLK => CLK_DATA);    
    U3C : double_sync port map(D => soft_moi_o,              Q => SOFT_MOI ,         RESET => sreset,    CLK => CLK_DATA);    
    U3D : double_sync port map(D => acq_stop_o,              Q => ACQ_STOP ,         RESET => sreset,    CLK => CLK_DATA);


   -- I/O Connections assignments
   AXI4_LITE_MISO.AWREADY  <= axi_awready;
   AXI4_LITE_MISO.WREADY   <= axi_wready;
   AXI4_LITE_MISO.BRESP	   <= axi_bresp;
   AXI4_LITE_MISO.BVALID   <= axi_bvalid;
   AXI4_LITE_MISO.ARREADY  <= axi_arready;
   AXI4_LITE_MISO.RDATA	   <= axi_rdata;
   AXI4_LITE_MISO.RRESP	   <= axi_rresp;
   AXI4_LITE_MISO.RVALID   <= axi_rvalid;
   

--BUFFER MODE ASSIGNMENT
buf_mode : process(buffermode_b)
begin
    case buffermode_b is
        when "0000" => 
            BUFFER_MODE <= BUF_OFF;
            SKIP_DATA <= '1';
        when "0001" => 
            BUFFER_MODE <= BUF_WR_SEQ;
            SKIP_DATA <= '0';
        when "0010" => 
            BUFFER_MODE <= BUF_RD_IMG;
            SKIP_DATA <= '0';
        when others => 
            BUFFER_MODE <= BUF_OFF;
            SKIP_DATA <= '1';
    end case;
end process;

--BUFFER MODE ASSIGNMENT
moi_mode_Sel : process(moi_mode_b)
begin
    case moi_mode_b is
        when "00" => MOI_MODE <= EXT_SRC;
        when "01" => MOI_MODE <= SOFT_SRC;
        when "10" => MOI_MODE <= NO_SRC;
        when others => MOI_MODE <= SOFT_SRC;
    end case;
end process;

--BUFFER MODE ASSIGNMENT
edge_mode : process(ext_edge_b)
begin
    case ext_edge_b is
        when "00" => EXT_EDGE <= RISING;
        when "01" => EXT_EDGE <= FALLING;
        when "10" => EXT_EDGE <= ANY;
        when others => EXT_EDGE <= RISING;
    end case;
end process;

   
   ----------------------------------------------------------------------------
   -- AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   AXI_WR_FLOW: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else
            
            if (axi_awready = '0' and AXI4_LITE_MOSI.AWVALID = '1' and AXI4_LITE_MOSI.WVALID = '1') then
               axi_awready <= '1';
               axi_awaddr <= AXI4_LITE_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;
            
            if (axi_wready = '0' and AXI4_LITE_MOSI.WVALID = '1' and AXI4_LITE_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';               
            end if;              
            
         end if;
      end if;
   end process;   
   
   slv_reg_wren <= axi_wready and AXI4_LITE_MOSI.WVALID and axi_awready and AXI4_LITE_MOSI.AWVALID ;
   axi_wstrb <= AXI4_LITE_MOSI.WSTRB; 
   
   ----------------------------------------------------------------------------
   -- AXI WR : reception configuration
   ----------------------------------------------------------------------------
   AXI_WR : process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            memorybaseaddr_o <= (others => '0');
            nb_seq_max_o <= std_logic_vector(to_unsigned(1,nb_seq_max_o'length));
            seq_img_total_o <= (others => '0');
            framesize_o <= (others => '0');
            hdr_bytessize_o <= (others => '0');
            img_bytessize_o <= (others => '0');
            buffermode_o <= (others => '0');
            nb_img_pre_o <= (others => '0');
            nb_img_post_o <= (others => '0');
            rd_seq_id_o <= (others => '0');
            rd_start_id_o <= (others => '0');
            rd_stop_id_o <= (others => '0');
            bufferswitch_o <= (others => '0');
            moi_mode_o <= "01"; -- software
            ext_edge_o <= (others => '0');
            clear_mem_o <= '0';
            config_valid_o <='0';
            soft_moi_o         <= '0';
            acq_stop_o      <='0';
            rd_min_frame_time_o <= (others => '0');
         else
            if (slv_reg_wren = '1') and axi_wstrb = "1111" then
               case axi_awaddr(OPT_MEM_ADDR_BITS+ADDR_LSB downto 0) is      
                  when MEMORY_BASE_ADDR_ADDR    =>  memorybaseaddr_o  <= AXI4_LITE_MOSI.WDATA(memorybaseaddr_o'length-1 downto 0);
                  when NB_SEQUENCE_MAX_ADDR     =>  nb_seq_max_o      <= AXI4_LITE_MOSI.WDATA(nb_seq_max_o'length-1 downto 0);
                  when SEQ_IMG_TOTAL_ADDR       =>  seq_img_total_o   <= AXI4_LITE_MOSI.WDATA(seq_img_total_o'length-1 downto 0); 
                  when FRAME_SIZE_ADDR          =>  framesize_o       <= AXI4_LITE_MOSI.WDATA(framesize_o'length-1 downto 0);
                  when HDR_BYTESSIZE_ADDR          =>  hdr_bytessize_o       <= AXI4_LITE_MOSI.WDATA(hdr_bytessize_o'length-1 downto 0);
                  when IMG_BYTESSIZE_ADDR          =>  img_bytessize_o       <= AXI4_LITE_MOSI.WDATA(img_bytessize_o'length-1 downto 0);
                  when BUFFER_MODE_ADDR         =>  buffermode_o      <= AXI4_LITE_MOSI.WDATA(buffermode_o'length-1 downto 0);
                  when NB_IMG_PRE_ADDR          =>  nb_img_pre_o        <= AXI4_LITE_MOSI.WDATA(nb_img_pre_o'length-1 downto 0);
                  when NB_IMG_POST_ADDR         =>  nb_img_post_o       <= AXI4_LITE_MOSI.WDATA(nb_img_post_o'length-1 downto 0);
                  when RD_SEQ_ID_ADDR           =>  rd_seq_id_o         <= AXI4_LITE_MOSI.WDATA(rd_seq_id_o'length-1 downto 0); 
                  when RD_START_ID_ADDR             =>  rd_start_id_o         <= AXI4_LITE_MOSI.WDATA(rd_start_id_o'length-1 downto 0);
                  when RD_STOP_ID_ADDR               =>  rd_stop_id_o         <= AXI4_LITE_MOSI.WDATA(rd_stop_id_o'length-1 downto 0);
                  when CLEAR_MEMORY_CONTENT_ADDR    =>  clear_mem_o     <= AXI4_LITE_MOSI.WDATA(0);
                  when BUFFER_SWITCH_ADDR           =>  bufferswitch_o  <= AXI4_LITE_MOSI.WDATA(bufferswitch_o'length-1 downto 0); 
                  when CONFIG_VALID_ADDR            =>  config_valid_o  <= AXI4_LITE_MOSI.WDATA(0);
                  when SOFT_MOI_ADDR                =>  soft_moi_o  <= AXI4_LITE_MOSI.WDATA(0);
                  when MOI_SOURCE_ADDR              =>  moi_mode_o  <= AXI4_LITE_MOSI.WDATA(moi_mode_o'length-1 downto 0);
                  when MOI_ACTIVATION_ADDR          =>  ext_edge_o  <= AXI4_LITE_MOSI.WDATA(ext_edge_o'length-1 downto 0);
                  when ACQ_STOP_ADDR            =>  acq_stop_o  <= AXI4_LITE_MOSI.WDATA(0);
                  when RD_MIN_FRAME_TIME_ADDR       =>  rd_min_frame_time_o         <= AXI4_LITE_MOSI.WDATA(rd_min_frame_time_o'length-1 downto 0);
                  when others  =>                  
               end case;                                                                                          
            end if;                                        
         end if;
      end if;
   end process; 

   
   ----------------------------------------------------------------------------
   -- AXI WR : WR response
   ----------------------------------------------------------------------------
   U4: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
         else
            if (axi_awready = '1' and AXI4_LITE_MOSI.AWVALID = '1' and axi_wready = '1' and AXI4_LITE_MOSI.WVALID = '1' and axi_bvalid = '0'  ) then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif (AXI4_LITE_MOSI.BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U5: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if axi_arready = '0' and AXI4_LITE_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= AXI4_LITE_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;            
            if axi_arready = '1' and AXI4_LITE_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and AXI4_LITE_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   slv_reg_rden <= axi_arready and AXI4_LITE_MOSI.ARVALID and (not axi_rvalid);
   
   ---------------------------------------------------------------------------- 
   -- RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U6: process(CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then         
         case axi_araddr(OPT_MEM_ADDR_BITS+ADDR_LSB downto 0) is
            when  NB_SEQ_IN_MEM_ADDR     => reg_data_out <= std_logic_vector(resize(nb_seq_in_mem_i     , reg_data_out'length));                  
            when  FSM_ERROR_WR_ADDR     => reg_data_out <= std_logic_vector(resize(fsm_wr_err_i , reg_data_out'length));           
            when  FSM_ERROR_RD_ADDR     => reg_data_out <= std_logic_vector(resize(fsm_rd_err_i     , reg_data_out'length));       
            when  EXT_BUF_PRSNT_ADDR     => reg_data_out <= (0 => not(EXT_BUF_PRSNT_N), others => '0');
            when others                     => reg_data_out <= (others => '0');
         end case;        
      end if;     
   end process;  

   
   
   ---------------------------------------------------------------------------- 
   -- Axi RD responses                                      
   ---------------------------------------------------------------------------- 
   U7: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then
         if sresetn = '0' then
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if (axi_arready = '1' and AXI4_LITE_MOSI.ARVALID = '1' and axi_rvalid = '0') then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif (axi_rvalid = '1' and AXI4_LITE_MOSI.RREADY = '1') then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
         end if;
      end if;
   end process;
   
   -- Implement memory mapped register select and read logic generation
   -- Slave register read enable is asserted when valid address is available
   -- and the slave is ready to accept the read address.
   slv_reg_rden <= axi_arready and AXI4_LITE_MOSI.ARVALID and (not axi_rvalid) ; 
   -- Read address mux
   axi_rdata <= reg_data_out;     -- register read data
   
end RTL;
