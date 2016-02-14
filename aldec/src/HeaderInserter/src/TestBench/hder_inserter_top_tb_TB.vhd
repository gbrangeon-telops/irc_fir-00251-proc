library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.img_header_define.all;


-- Add your library and packages declaration here ...

entity hder_inserter_top_tb_TB is
end hder_inserter_top_tb_TB;

architecture TB_ARCHITECTURE of hder_inserter_top_tb_TB is
   -- Component declaration of the tested unit
   component hder_inserter_top_tb
      port(
         ARESETN        : in STD_LOGIC;
         MB_CLK         : in STD_LOGIC;
         
         FPA_HDER_CLK   : in STD_LOGIC;
         FPA_HDER_MOSI  : in t_axi4_lite_mosi;
         FPA_HDER_MISO  : out t_axi4_lite_miso;
         
         FW_HDER_CLK    : in STD_LOGIC;
         FW_HDER_MOSI   : in t_axi4_lite_mosi;
         FW_HDER_MISO   : out t_axi4_lite_miso;
         
         TRIG_HDER_CLK  : in STD_LOGIC;
         TRIG_HDER_MOSI : in t_axi4_lite_mosi;
         TRIG_HDER_MISO : out t_axi4_lite_miso;
         
         
         DCLK           : in STD_LOGIC;
         DIN_MOSI       : in t_axi4_stream_mosi32;
         DIN_MISO       : out t_axi4_stream_miso;
         
         FPA_IMG_INFO   : in img_info_type;
         
         OUT_MOSI       : out t_axi4_stream_mosi32;
         OUT_MISO       : in t_axi4_stream_miso;
         
         ERR            : out STD_LOGIC
         );
   end component;
   
   constant CLK_PERIOD         : time := 10 ns;
   constant EXP_FEEDBK_PERIOD  : time := 1 ms ;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   type fast_hder_sm_type is (idle, send_hder_st);
   
   signal fpa_fast_hder_sm      : fast_hder_sm_type;
   signal trig_fast_hder_sm          : fast_hder_sm_type;
   signal ARESETN               : STD_LOGIC;
   signal DCLK                  : STD_LOGIC;
   signal DIN_MOSI              : t_axi4_stream_mosi32;
   signal FPA_HDER_CLK          : STD_LOGIC;
   signal FPA_HDER_MOSI         : t_axi4_lite_mosi;
   signal FPA_IMG_INFO          : img_info_type;
   signal FW_HDER_CLK           : STD_LOGIC;
   signal FW_HDER_MOSI          : t_axi4_lite_mosi;
   signal MB_CLK                : STD_LOGIC := '0';
   signal OUT_MISO              : t_axi4_stream_miso;
   signal TRIG_HDER_CLK         : STD_LOGIC;
   signal TRIG_HDER_MOSI        : t_axi4_lite_mosi;
   -- Observed signals -         signals mapped to the output ports of tested entity
   signal DIN_MISO              : t_axi4_stream_miso;
   signal ERR                   : STD_LOGIC;
   signal FPA_HDER_MISO         : t_axi4_lite_miso;
   signal FW_HDER_MISO          : t_axi4_lite_miso;
   signal OUT_MOSI              : t_axi4_stream_mosi32;
   signal TRIG_HDER_MISO        : t_axi4_lite_miso;
   signal exp_feedback          : STD_LOGIC := '0';
   signal exp_feedback_sync1    : STD_LOGIC;
   signal exp_feedback_sync_last1  : STD_LOGIC := '0';
   signal frame_id              : unsigned(31 downto 0) := (others => '0');
   signal areset                : STD_LOGIC;
   signal trig_hder_link_rdy         : STD_LOGIC;
   signal hcnt                  : unsigned(7 downto 0);
   signal exp_feedback_sync2     : STD_LOGIC;
   signal exp_feedback_sync_last2     : STD_LOGIC := '0';
   
   signal fpa_hder_link_rdy         : STD_LOGIC;
   signal fpa_hcnt                  : unsigned(7 downto 0);
   signal exp_feedback_sync3     : STD_LOGIC;
   signal exp_feedback_sync_last3    : STD_LOGIC := '0';
   -- Add your code here ...
   
begin  
   
   OUT_MISO.TREADY <= '1'; 
   
   FW_HDER_MOSI.AWVALID <= '0';
   FW_HDER_MOSI.ARVALID <= '0';
   FW_HDER_MOSI.WVALID <= '0';
   
   DIN_MOSI.TVALID <= '0';
   
   U1: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after CLK_PERIOD/2; 
   end process;
   
   reset_gen: process
   begin
      aresetn <= '0'; 
      wait for 250 ns;
      aresetn <= '1';
      wait;
   end process;
   areset <= not aresetn;
   
   FPA_HDER_CLK <= transport MB_CLK after 2ns;
   FW_HDER_CLK <= transport MB_CLK after 3ns;
   TRIG_HDER_CLK <= transport MB_CLK after 5ns;
   DCLK <= transport MB_CLK after 1ns;
   
   
   U2: process(exp_feedback)
   begin
      exp_feedback <= not exp_feedback after EXP_FEEDBK_PERIOD/2;
   end process;                                                  
   
   
   U3: process(FPA_HDER_CLK)
   begin
      if rising_edge(FPA_HDER_CLK) then
         exp_feedback_sync1 <= exp_feedback; 
         exp_feedback_sync_last1 <= exp_feedback_sync1;
         if exp_feedback_sync1 = '1' and exp_feedback_sync_last1 = '0' then
            frame_id <= frame_id + 1;
         end if;        
         FPA_IMG_INFO.FRAME_ID <= (frame_id);
         FPA_IMG_INFO.EXP_FEEDBK <= exp_feedback_sync1;
      end if;		  
   end process;
   
   trig_hder_link_rdy <= TRIG_HDER_MISO.WREADY and TRIG_HDER_MISO.AWREADY;
   TrigHderGen: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if areset = '1' then
            TRIG_HDER_MOSI.awvalid <= '0';
            TRIG_HDER_MOSI.wvalid <= '0';
            TRIG_HDER_MOSI.wstrb <= (others => '0');
            TRIG_HDER_MOSI.awprot <= (others => '0');
            TRIG_HDER_MOSI.arvalid <= '0';
            TRIG_HDER_MOSI.bready <= '1';
            TRIG_HDER_MOSI.rready <= '0';
            TRIG_HDER_MOSI.arprot <= (others => '0');
            trig_fast_hder_sm <= idle;
            exp_feedback_sync2 <= exp_feedback;            
            exp_feedback_sync_last2 <= exp_feedback_sync2; 
         else
            
            exp_feedback_sync2 <= exp_feedback;                               
            exp_feedback_sync_last2 <= exp_feedback_sync2;                    
            
            -- sortie de la partie header fast provenant du module
            case trig_fast_hder_sm is
               
               when idle =>
                  TRIG_HDER_MOSI.awvalid <= '0';
                  TRIG_HDER_MOSI.wvalid <= '0';
                  TRIG_HDER_MOSI.wstrb <= (others => '0');
                  hcnt <= to_unsigned(1, hcnt'length);
                  if exp_feedback_sync2 = '1' and exp_feedback_sync_last2 = '0' then
                     trig_fast_hder_sm <= send_hder_st;                     
                  end if;
               
               when send_hder_st =>
                  if trig_hder_link_rdy = '1' then 
                     if hcnt = 1 then    -- Posix Time seconds
                        TRIG_HDER_MOSI.awaddr <= x"0000" & std_logic_vector(frame_id(7 downto 0)) & resize(POSIXTimeAdd32, 8);--
                        TRIG_HDER_MOSI.awvalid <= '1';
                        TRIG_HDER_MOSI.wdata <= x"5EC05EC0";
                        TRIG_HDER_MOSI.wvalid <= '1';
                        TRIG_HDER_MOSI.wstrb <= POSIXTimeBWE;                        
                     elsif hcnt = 2 then -- Posix Time Subseconds et x"FFFF" pour signaler la fin
                        TRIG_HDER_MOSI.awaddr <= x"FFFF" & std_logic_vector(frame_id(7 downto 0)) & resize(SubSecondTimeAdd32, 8);--
                        TRIG_HDER_MOSI.awvalid <= '1';
                        TRIG_HDER_MOSI.wdata <= x"5AB5EC0D";
                        TRIG_HDER_MOSI.wvalid <= '1';
                        TRIG_HDER_MOSI.wstrb <= SubSecondTimeBWE;
                        trig_fast_hder_sm <= idle;
                     end if;
                     hcnt <= hcnt + 1;
                  end if;
               
               when others =>
               
            end case;               
            
         end if;       
      end if;		  
   end process;
   
   fpa_hder_link_rdy <= FPA_HDER_MISO.WREADY and FPA_HDER_MISO.AWREADY;
   fpaHderGen: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if areset = '1' then
            FPA_HDER_MOSI.awvalid <= '0';
            FPA_HDER_MOSI.wvalid <= '0';
            FPA_HDER_MOSI.wstrb <= (others => '0');
            FPA_HDER_MOSI.awprot <= (others => '0');
            FPA_HDER_MOSI.arvalid <= '0';
            FPA_HDER_MOSI.bready <= '1';
            FPA_HDER_MOSI.rready <= '0';
            FPA_HDER_MOSI.arprot <= (others => '0');
            fpa_fast_hder_sm <= idle;
            exp_feedback_sync3 <= exp_feedback;            
            exp_feedback_sync_last3 <= exp_feedback_sync3; 
         else
            
            exp_feedback_sync3 <= exp_feedback;                               
            exp_feedback_sync_last3 <= exp_feedback_sync3;                    
            
            -- sortie de la partie header fast provenant du module
            case fpa_fast_hder_sm is
               
               when idle =>
                  FPA_HDER_MOSI.awvalid <= '0';
                  FPA_HDER_MOSI.wvalid <= '0';
                  FPA_HDER_MOSI.wstrb <= (others => '0');
                  fpa_hcnt <= to_unsigned(1, hcnt'length);
                  if exp_feedback_sync3 = '1' and exp_feedback_sync_last3 = '0' then
                     fpa_fast_hder_sm <= send_hder_st;                     
                  end if;
               
               when send_hder_st =>
                  if fpa_hder_link_rdy = '1' then 
                     if hcnt = 1 then    -- ExposureTimeAdd32
                        FPA_HDER_MOSI.awaddr <= x"0000" & std_logic_vector(frame_id(7 downto 0)) & resize(ExposureTimeAdd32, 8);--
                        FPA_HDER_MOSI.awvalid <= '1';
                        FPA_HDER_MOSI.wdata <= x"FA111111";
                        FPA_HDER_MOSI.wvalid <= '1';
                        FPA_HDER_MOSI.wstrb <= ExposureTimeBWE;                        
                     elsif hcnt = 2 then -- FrameIDAdd32
                        FPA_HDER_MOSI.awaddr <= x"0000" & std_logic_vector(frame_id(7 downto 0)) & resize(FrameIDAdd32, 8);--
                        FPA_HDER_MOSI.awvalid <= '1';
                        FPA_HDER_MOSI.wdata <= std_logic_vector(frame_id);
                        FPA_HDER_MOSI.wvalid <= '1';
                        FPA_HDER_MOSI.wstrb <= FrameIDBWE;
                     elsif hcnt = 3 then -- sensor_temp_raw
                        FPA_HDER_MOSI.awaddr <= x"FFFF" & std_logic_vector(frame_id(7 downto 0)) & resize(SensorTemperatureRawAdd32, 8);--
                        FPA_HDER_MOSI.awvalid <= '1';
                        FPA_HDER_MOSI.wdata <= std_logic_vector(frame_id);
                        FPA_HDER_MOSI.wvalid <= '1';
                        FPA_HDER_MOSI.wstrb <= SensorTemperatureRawBWE;
                        fpa_fast_hder_sm <= idle;
                     end if;
                     fpa_hcnt <= fpa_hcnt + 1;
                  end if;
               
               when others =>
               
            end case;               
            
         end if;       
      end if;		  
   end process; 
   
   -- Unit Under Test port map
   UUT : hder_inserter_top_tb
   port map (
      ARESETN => ARESETN,
      DCLK => DCLK,
      DIN_MOSI => DIN_MOSI,
      FPA_HDER_CLK => FPA_HDER_CLK,
      FPA_HDER_MOSI => FPA_HDER_MOSI,
      FPA_IMG_INFO => FPA_IMG_INFO,
      FW_HDER_CLK => FW_HDER_CLK,
      FW_HDER_MOSI => FW_HDER_MOSI,
      MB_CLK => MB_CLK,
      OUT_MISO => OUT_MISO,
      TRIG_HDER_CLK => TRIG_HDER_CLK,
      TRIG_HDER_MOSI => TRIG_HDER_MOSI,
      DIN_MISO => DIN_MISO,
      ERR => ERR,
      FPA_HDER_MISO => FPA_HDER_MISO,
      FW_HDER_MISO => FW_HDER_MISO,
      OUT_MOSI => OUT_MOSI,
      TRIG_HDER_MISO => TRIG_HDER_MISO
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_hder_inserter_top_tb of hder_inserter_top_tb_TB is
   for TB_ARCHITECTURE
      for UUT : hder_inserter_top_tb
         use entity work.hder_inserter_top_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_hder_inserter_top_tb;

