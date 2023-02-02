-------------------------------------------------------------------------------
--
-- Title       : mockfpa_data_gen
-- Design      : FIR_00251
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\aldec\src\FPA\mockfpa\mockfpa_datagen.vhd
-- Generated   : Mon Aug 17 10:52:46 2020
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
use IEEE.numeric_std.all;
use work.fpa_common_pkg.all;
use work.fpa_define.all;
use work.img_header_define.all;
use work.tel2000.all;   

entity mockfpa_data_gen is
	port(
      ARESET           : in std_logic;
      CLK100           : in std_logic;
      CLK200           : in std_logic;
	  ACQ_INT          : in std_logic;
      FPA_INTF_CFG     : in fpa_intf_cfg_type;
      IMAGE_INFO       : out img_info_type;
	  HDER_MISO 	   : in t_axi4_lite_miso;
	  HDER_MOSI 	   : out t_axi4_lite_mosi;
	  FPA_HDER_CLK     : out STD_LOGIC;
	  DOUT_MISO        : in t_axi4_stream_miso;
	  DOUT_MOSI        : out t_axi4_stream_mosi128;
	  DOUT_CLK         : out STD_LOGIC
     );     
end mockfpa_data_gen;

architecture rtl of mockfpa_data_gen is

constant HDER_PAUSE : natural := 40;
constant PIX_DELAY : natural := 40;
constant DVAL_PAUSE : natural := 3; -- Debit moyen inter ligne ajusté a 16/19*340MP/s =  286 MP/s (plus grand que 280 pour être conservateur)
constant LVAL_PAUSE : natural := 25; -- Debit moyen inter frame : 115/(115+480)*340 =  274 MP/s (conservateur pcq plus grand que 91*1920*1536/1E6=268MP/s), Pause par ligne = (1920/64)*3+25=115clks, Nb clk de transfert de pixel = 1920/4 = 480. 
constant FISRT_TRANSACTION_VALUE : std_logic_vector := x"00080007000600050004000300020001";
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
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

type fast_hder_sm_type is (idle, delay_st, send_hder_st, wait_acq_hder_st);
type pix_sm_type is (idle, delay_st, int_st, send_pix_st );

signal clk               :  std_logic;
signal sreset            : std_logic;
signal fpa_int_cfg_i     : fpa_intf_cfg_type;
signal acq_int_sync      : std_logic;
signal acq_int_sync_last : std_logic;
signal acq_hder          : std_logic;
signal hder_link_rdy     : std_logic;
signal frame_id          : unsigned(31 downto 0) := to_unsigned(0, 32);
signal fast_hder_sm      : fast_hder_sm_type;
signal hder_mosi_i       : t_axi4_lite_mosi;
signal hcnt              : unsigned(7 downto 0);
signal hder_param        : hder_param_type;
signal hpause_cnt        : unsigned(7 downto 0);
signal image_info_i      : img_info_type;
signal pix_sm            : pix_sm_type;
signal dout_mosi_i       : t_axi4_stream_mosi128;
signal pix_delay_cnt     : unsigned(7 downto 0);
signal int_cnt           : unsigned(31 downto 0);
signal rowpix_cnt        : unsigned(11 downto 0);
signal line_cnt          : unsigned(11 downto 0);
signal dval_pause_cnt    : unsigned(7 downto 0);
signal lval_pause_cnt    : unsigned(7 downto 0);
signal dval              : std_logic;  
signal pixel_index       : unsigned(15 downto 0);

begin

    -- IO Mapping
    HDER_MOSI <= hder_mosi_i;
    IMAGE_INFO <= image_info_i;
    DOUT_MOSI <= dout_mosi_i;
    fpa_int_cfg_i <= FPA_INTF_CFG;
    -- Handshake
    hder_link_rdy <= HDER_MISO.WREADY and HDER_MISO.AWREADY;

    -- Clocks
    clk <= clk100;
    --clk <= clk200;
    FPA_HDER_CLK <= clk;
    DOUT_CLK <= clk;

   --------------------------------------------------
   -- synchro 
   --------------------------------------------------   
   U0A: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );

   U0B: double_sync
   port map(
      CLK => CLK,
      D   => ACQ_INT,
      Q   => acq_int_sync,
      RESET => sreset
      );

   -----------------------------------------------------------------
   -- Sortie du header fast
   -------------------------------------------------------------------   
   U1: process(CLK)
   begin          
      if rising_edge(CLK) then         
         if sreset = '1' then
            fast_hder_sm <= idle;
            hder_mosi_i.awaddr <= (others => '0');
            hder_mosi_i.awvalid <= '0';
            hder_mosi_i.wdata <= (others => '0');
            hder_mosi_i.wvalid <= '0';
            hder_mosi_i.wstrb <= (others => '0');
            hder_mosi_i.awprot <= (others => '0');
            hder_mosi_i.araddr <= (others => '0');
            hder_mosi_i.arvalid <= '0';
            hder_mosi_i.bready <= '1';
            hder_mosi_i.rready <= '0';
            hder_mosi_i.arprot <= (others => '0');
            acq_int_sync_last <= '0';
            image_info_i.exp_feedbk <= '0';
            image_info_i.exp_info.exp_dval <= '0';

         else
            -- Integration signal
            acq_int_sync_last <= acq_int_sync;
            acq_hder <= not acq_int_sync_last and acq_int_sync;
            
            -- construction des données hder fast
			hder_param.exp_time <= fpa_int_cfg_i.int_time; 
            hder_param.frame_id <= unsigned(frame_id);
            hder_param.sensor_temp_raw <= (others => '0'); 
            hder_param.exp_index <= unsigned(fpa_int_cfg_i.int_indx);
            hder_param.rdy <= '1';
            
            -- construction de image info
            image_info_i.frame_id <= frame_id;
            image_info_i.ref_feedbk <= (others => '0');
            image_info_i.dval_gen_stat <= (others => '0');
            image_info_i.offsetx <= (others => '0'); -- non géré
            image_info_i.offsety <= (others => '0'); -- non géré
            image_info_i.width <= fpa_int_cfg_i.fpa_width;
            image_info_i.height <= fpa_int_cfg_i.fpa_height;
            image_info_i.exp_info.exp_time <= hder_param.exp_time;
            image_info_i.exp_info.exp_indx <= std_logic_vector(hder_param.exp_index);
         
            case fast_hder_sm is
                when idle =>
                    hcnt <= to_unsigned(1, hcnt'length);
                    hpause_cnt <= (others => '0');
                    image_info_i.exp_feedbk <= '0';
                    image_info_i.exp_info.exp_dval <= '0';
                    
                    if acq_hder = '1' then
                       frame_id <= frame_id + 1;
                       fast_hder_sm <= delay_st;                     
                    end if;

                when delay_st =>
                    hpause_cnt <= hpause_cnt + 1;
                    if hpause_cnt = HDER_PAUSE then
                        fast_hder_sm <= send_hder_st;
                    end if;

                when send_hder_st =>
                    image_info_i.exp_feedbk <= '1';
                    image_info_i.exp_info.exp_dval <= '1';
    
                    if hder_link_rdy = '1' then                         
                        if hcnt = 1 then -- frame_id 
                            hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(FrameIDAdd32, 8));--
                            hder_mosi_i.awvalid <= '1';
                            hder_mosi_i.wdata <=  std_logic_vector(hder_param.frame_id);
                            hder_mosi_i.wvalid <= '1';
                            hder_mosi_i.wstrb <= FrameIDBWE;
                      
                        elsif hcnt = 2 then -- sensor_temp_raw
                            hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(SensorTemperatureRawAdd32, 8));--
                            hder_mosi_i.awvalid <= '1';
                            hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_param.sensor_temp_raw), 32), SensorTemperatureRawShift)); --resize(hder_param.sensor_temp_raw, 32);
                            hder_mosi_i.wvalid <= '1';
                            hder_mosi_i.wstrb <= SensorTemperatureRawBWE;
                      
                        elsif hcnt = 3 then    -- exp_time -- en troisieme position pour donner du temps au calcul de hder_param.exp_time
                            hder_mosi_i.awaddr <= x"FFFF" & std_logic_vector(hder_param.frame_id(7 downto 0)) &  std_logic_vector(resize(ExposureTimeAdd32, 8));--
                            hder_mosi_i.awvalid <= '1';
                            hder_mosi_i.wdata <=  std_logic_vector(hder_param.exp_time);
                            hder_mosi_i.wvalid <= '1';
                            hder_mosi_i.wstrb <= ExposureTimeBWE;
                            fast_hder_sm <= wait_acq_hder_st;
                        end if;                     
                        hcnt <= hcnt + 1;
                    end if;

                when wait_acq_hder_st =>
                    hder_mosi_i.awvalid <= '0';
                    hder_mosi_i.wvalid <= '0';
                    hder_mosi_i.wstrb <= (others => '0');
                    if acq_hder = '0' then
                        fast_hder_sm <= idle;
                    end if;

                when others =>
                    null;
             end case;               
         end if;  
      end if;
   end process; 


   -----------------------------------------------------------------
   -- Sortie des pixels
   -------------------------------------------------------------------   
   dout_mosi_i.TVALID <= dval and DOUT_MISO.TREADY;
   dout_mosi_i.TID    <= (others => '0');
   dout_mosi_i.TDEST  <= (others => '0');
   dout_mosi_i.TUSER  <= (others => '0');
   dout_mosi_i.TSTRB  <= (others => '1');
   dout_mosi_i.TKEEP  <= (others => '1');


   U2: process(CLK)
   begin          
      if rising_edge(CLK) then         
         if sreset = '1' then
			dout_mosi_i.TDATA  <= FISRT_TRANSACTION_VALUE; 
            pix_sm <= idle;
            dval <= '0';
            dout_mosi_i.TLAST <= '0';
			pix_delay_cnt <= (others => '0'); 
			int_cnt <= to_unsigned(1, int_cnt'length);	
			line_cnt <= to_unsigned(1, line_cnt'length); 
			rowpix_cnt     <= to_unsigned(8, rowpix_cnt'length); 
			lval_pause_cnt <= (others => '0'); 
			pixel_index    <= to_unsigned(8,pixel_index'length);
         else
         
            case pix_sm is
              when idle =>
                pix_delay_cnt  <= (others => '0');
                int_cnt        <= to_unsigned(1, int_cnt'length);
                line_cnt       <= to_unsigned(1, line_cnt'length);
                rowpix_cnt     <= to_unsigned(8, rowpix_cnt'length);
                lval_pause_cnt <= (others => '0');
                pixel_index    <= to_unsigned(8,pixel_index'length); 
				dout_mosi_i.TDATA  <= FISRT_TRANSACTION_VALUE; 
                if acq_hder = '1' then
                   pix_sm <= delay_st;                     
                end if;

              when delay_st => 
			  
                pix_delay_cnt <= pix_delay_cnt + 1;
                if pix_delay_cnt = PIX_DELAY then
                    pix_sm <= int_st;
                end if;
                
              when int_st =>
                int_cnt <= int_cnt + 1;
                --if int_cnt = (hder_param.exp_time sll 1) then
					if int_cnt = hder_param.exp_time then
                    pix_sm <= send_pix_st;
                    dval <= '1';
                end if;

              when send_pix_st =>
			  if DOUT_MISO.TREADY = '1' then
			        dout_mosi_i.TDATA(15 downto 0)    <= std_logic_vector(pixel_index + 1);
                    dout_mosi_i.TDATA(31 downto 16)   <= std_logic_vector(pixel_index + 2);
                    dout_mosi_i.TDATA(47 downto 32)   <= std_logic_vector(pixel_index + 3);
                    dout_mosi_i.TDATA(63 downto 48)   <= std_logic_vector(pixel_index + 4);
					dout_mosi_i.TDATA(79 downto 64)   <= std_logic_vector(pixel_index + 5);
                    dout_mosi_i.TDATA(95 downto 80)   <= std_logic_vector(pixel_index + 6);
                    dout_mosi_i.TDATA(111 downto 96)  <= std_logic_vector(pixel_index + 7);
                    dout_mosi_i.TDATA(127 downto 112) <= std_logic_vector(pixel_index + 8);
				    pixel_index <= pixel_index + 8;
                    -- EOF
                    if (line_cnt = image_info_i.height and rowpix_cnt = image_info_i.width) then
                        pix_sm <= idle;									  
                        dval <= '0';
                        dout_mosi_i.TLAST <= '0';

                    -- EOL
                    elsif rowpix_cnt = image_info_i.width then
                        rowpix_cnt <= to_unsigned(8, rowpix_cnt'length);
                        line_cnt <= line_cnt + 1;
						dval <= '1'; 
						

                    else
                        rowpix_cnt <= rowpix_cnt + 8;
                        
                        -- Last pixels on next cycle
                        if (line_cnt = image_info_i.height and rowpix_cnt = image_info_i.width - 8) then
                            dout_mosi_i.TLAST <= '1';
 
                        end if;
                    end if;
                end if;  
                
                when others =>
                    null;
             end case;
         end if;
      end if;
   end process;
end rtl;
