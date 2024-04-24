------------------------------------------------------------------
--!   @file : calcium_data_dispatcher
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
use work.Fpa_Common_Pkg.all;
use work.FPA_Define.all;
use work.proxy_define.all;
use work.tel2000.all;
use work.img_header_define.all;

entity calcium_data_dispatcher is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      FPA_INT           : in std_logic;
      ACQ_INT           : in std_logic;  -- ACQ_INT et FRAME_ID sont parfaitement synchronisés
      FRAME_ID          : in std_logic_vector(31 downto 0);
      INT_TIME          : in std_logic_vector(31 downto 0);
      INT_INDX          : in std_logic_vector(7 downto 0);
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      RX_QUAD_DATA      : in calcium_quad_data_type;
      
      READOUT           : out std_logic;   -- ENO: 06 mars 2021.  READOUT monte à '1' avec SOF et tombe à '0' juste après EOF. Donc en tenir compte lorsqu'on utilise le mode READOUT_END_TO_TRIG_START 
      
      TX_QUAD_DATA      : out calcium_quad_data_type;
      
      HDER_MOSI         : out t_axi4_lite_mosi;
      HDER_MISO         : in t_axi4_lite_miso;
      
      DISPATCH_INFO     : out img_info_type;
      FPA_TEMP_STAT     : in fpa_temp_stat_type;
      
      FIFO_ERR          : out std_logic;
      SPEED_ERR         : out std_logic;
      CFG_MISMATCH      : out std_logic;
      ASSUMP_ERR        : out std_logic;
      DONE              : out std_logic
   );
end calcium_data_dispatcher;

architecture rtl of calcium_data_dispatcher is 
   
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS       : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR
   constant C_EXP_TIME_CONV_NUMERATOR_BITLEN          : integer := C_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 5;
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_27  : natural := C_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 27; --pour un total de 27 bits pour le temps d'integration
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1   : natural := C_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1; 
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;
   
   component fwft_sfifo_w72_d16
      port (
         clk       : in std_logic;
         srst      : in std_logic;
         din       : in std_logic_vector(71 downto 0);
         wr_en     : in std_logic;
         rd_en     : in std_logic;
         dout      : out std_logic_vector(71 downto 0);
         valid     : out std_logic;
         full      : out std_logic;
         overflow  : out std_logic;
         empty     : out std_logic
      );
   end component;
   
   type frame_fsm_type is (idle, img_start_st, img_end_st);
   type fast_hder_sm_type is (idle, exp_info_dval_st, send_hder_st, wait_acq_hder_st);
   
   signal exp_dval_pipe                : std_logic_vector(2 downto 0) := (others => '0');
   signal fast_hder_sm                 : fast_hder_sm_type;
   signal frame_fsm                    : frame_fsm_type;
   signal sreset                       : std_logic;
   signal acq_hder_fifo_din            : std_logic_vector(71 downto 0);
   signal acq_hder_fifo_wr             : std_logic;
   signal acq_hder_fifo_rd             : std_logic;
   signal acq_hder_fifo_dout           : std_logic_vector(71 downto 0);
   signal acq_hder_fifo_dval           : std_logic;
   signal acq_hder_fifo_ovfl           : std_logic;
   signal readout_i                    : std_logic;
   signal acq_hder                     : std_logic;
   signal acq_hder_last                : std_logic;
   signal frame_id_i                   : std_logic_vector(31 downto 0);
   signal hder_cnt                     : unsigned(7 downto 0) := (others => '0');
   signal int_time_i                   : unsigned(31 downto 0);
   signal hder_mosi_i                  : t_axi4_lite_mosi;
   signal hder_link_rdy                : std_logic;
   signal dispatch_info_i              : img_info_type;
   signal hder_param                   : hder_param_type;
   signal hcnt                         : unsigned(7 downto 0);
   signal int_indx_i                   : std_logic_vector(7 downto 0);
   signal pause_cnt                    : unsigned(7 downto 0);
   signal acq_data                     : std_logic;
   signal acq_int_last                 : std_logic;
   
   
begin
   
   HDER_MOSI <= hder_mosi_i;
   DISPATCH_INFO <= dispatch_info_i;
   
   READOUT <= readout_i;
   hder_link_rdy <= HDER_MISO.WREADY and HDER_MISO.AWREADY;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
   );
   
   --------------------------------------------------
   -- fifo fwft pour acq header info
   --------------------------------------------------
   U2 : fwft_sfifo_w72_d16  
   port map (
      srst => sreset,
      clk => CLK,
      din => acq_hder_fifo_din,
      wr_en => acq_hder_fifo_wr,
      rd_en => acq_hder_fifo_rd,
      dout => acq_hder_fifo_dout,
      valid  => acq_hder_fifo_dval,
      full => open,
      overflow => acq_hder_fifo_ovfl,
      empty => open
   );
   
   --------------------------------------------------
   -- Gestion des intégrations  
   --------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            frame_fsm <= idle;
            acq_hder_fifo_wr <= '0';
            acq_hder_fifo_rd <= '0';
            acq_hder <= '0';
            acq_data <= '0';
            readout_i <= '0';
            acq_int_last <= '0';
            
         else
            
            acq_int_last <= ACQ_INT;
            
            -- Au début de l'intégration, on écrit dans le fifo les infos du header.
            -- Seules les images acq int ont une valeur associée dans le fifo.
            acq_hder_fifo_din <= resize(INT_INDX & INT_TIME & FRAME_ID, acq_hder_fifo_din'length);
            acq_hder_fifo_wr <= not acq_int_last and ACQ_INT;
            
            -- Dès que la sortie du fifo est valide on latche les infos du header.
            -- acq_hder est utilisé par fast_hder_sm pour envoyer le header, donc on 
            -- lance l'écriture du header dès qu'on sait que la prochaine image reçue
            -- correspond à une acq int.
            -- acq_data est utilisé pour masquer la sortie des pixels quand l'image
            -- n'est pas une acq int.
            if acq_hder_fifo_dval = '1' then
               int_indx_i <= acq_hder_fifo_dout(71 downto 64);
               int_time_i <= unsigned(acq_hder_fifo_dout(63 downto 32));
               frame_id_i <= acq_hder_fifo_dout(31 downto 0);
               acq_hder <= '1';
               acq_data <= '1';
            end if;
            
            -- generation de acq_hder et readout_i
            case frame_fsm is 
               
               when idle =>
                  acq_hder_fifo_rd <= '0';
                  readout_i <= '0';
                  -- On attend le début du frame
                  if RX_QUAD_DATA.FVAL = '1' then
                     acq_hder_fifo_rd <= acq_hder_fifo_dval; -- mise à jour de la sortie du fwft pour la prochaine acq int
                     readout_i <= '1';                 -- signal de readout, à sortir même en mode xtra_trig
                     frame_fsm <= img_start_st;
                  end if;
               
               when img_start_st =>
                  acq_hder_fifo_rd <= '0';
                  -- acq_hder redescend à 0 dès que le frame correspondant à l'acq int a commencé.
                  -- Comme ça on est prêt à recevoir la prochaine acq int avant la fin du frame (mode IWR). 
                  acq_hder <= '0';
                  frame_fsm <= img_end_st;
               
               when img_end_st =>
                  -- On attend la fin du frame pour redescendre les signaux de acq_data et de readout
                  if RX_QUAD_DATA.FVAL = '0' then
                     readout_i <= '0';
                     acq_data <= '0';
                     frame_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- Sortie des pixels
   --------------------------------------------------
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then 
         -- données
         TX_QUAD_DATA.PIX_DATA      <= RX_QUAD_DATA.PIX_DATA;
         -- signaux de controle
         TX_QUAD_DATA.FVAL          <= RX_QUAD_DATA.FVAL and acq_data;
         TX_QUAD_DATA.LVAL          <= RX_QUAD_DATA.LVAL and acq_data;
         TX_QUAD_DATA.DVAL          <= RX_QUAD_DATA.DVAL and acq_data;
         TX_QUAD_DATA.AOI_DVAL      <= RX_QUAD_DATA.AOI_DVAL and acq_data;
         TX_QUAD_DATA.AOI_LAST      <= RX_QUAD_DATA.AOI_LAST and acq_data;
      end if;
   end process;
   
   --------------------------------------------------
   -- Sorties du header fast
   --------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            fast_hder_sm <= idle;
            hder_mosi_i.awvalid <= '0';
            hder_mosi_i.wvalid <= '0';
            hder_mosi_i.wstrb <= (others => '0');
            hder_mosi_i.awprot <= (others => '0');
            hder_mosi_i.arvalid <= '0';
            hder_mosi_i.bready <= '1';
            hder_mosi_i.rready <= '0';
            hder_mosi_i.arprot <= (others => '0');
            
            dispatch_info_i.exp_info.exp_dval <= '0';
            acq_hder_last <= '0';
            exp_dval_pipe <= (others => '0');
            
         else
            
            acq_hder_last <= acq_hder;
            
            -- pipe pour rendre valide la donnée qques CLKs apres sa sortie
            exp_dval_pipe(0)           <= acq_hder and not acq_hder_last;
            exp_dval_pipe(1)           <= exp_dval_pipe(0);
            exp_dval_pipe(2)           <= exp_dval_pipe(1);
            
            -- construction des données hder fast
            hder_param.exp_time <= int_time_i;
            hder_param.frame_id <= unsigned(frame_id_i);
            hder_param.sensor_temp_raw <= resize(FPA_TEMP_STAT.TEMP_DATA, hder_param.sensor_temp_raw'length);
            hder_param.exp_index <= unsigned(int_indx_i);
            hder_param.rdy <= exp_dval_pipe(2);
            
            --  generation des données de l'image info (exp_feedbk et frame_id proviennent de hw_driver pour eviter d'ajouter un clk supplementaire dans le présent module)
            dispatch_info_i.exp_info.exp_time <= hder_param.exp_time;
            dispatch_info_i.exp_info.exp_indx <= std_logic_vector(hder_param.exp_index);
            
            -- sortie de la partie header fast provenant du module
            case fast_hder_sm is
               
               when idle =>
                  --                  hder_mosi_i.awvalid <= '0';
                  --                  hder_mosi_i.wvalid <= '0';
                  --                  hder_mosi_i.wstrb <= (others => '0');
                  hcnt <= to_unsigned(1, hcnt'length);
                  dispatch_info_i.exp_info.exp_dval <= '0';
                  pause_cnt <= (others => '0');
                  if hder_param.rdy = '1' and acq_hder = '1' then
                     fast_hder_sm <= exp_info_dval_st;
                  end if;
               
               when exp_info_dval_st =>
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt = 4 then 
                     dispatch_info_i.exp_info.exp_dval <= '1';  -- sortira après dispatch_info_i.exp_info afin de reduire les risques d'aleas de séquences sur les regitres
                  end if;
                  if pause_cnt = 12 then                         -- ainsi dispatch_info_i.exp_info.exp_dval durera au moins 12-4 = 8 CLK
                     dispatch_info_i.exp_info.exp_dval <= '0';
                     fast_hder_sm <= send_hder_st;
                  end if;
               
               when send_hder_st =>
                  if hder_link_rdy = '1' then
                     if hcnt = 1 then -- frame_id 
                        hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) & std_logic_vector(resize(FrameIDAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(hder_param.frame_id);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= FrameIDBWE;
                        
                     elsif hcnt = 2 then -- sensor_temp_raw
                        hder_mosi_i.awaddr <= x"0000" &  std_logic_vector(hder_param.frame_id(7 downto 0)) & std_logic_vector(resize(SensorTemperatureRawAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_param.sensor_temp_raw), 32), SensorTemperatureRawShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= SensorTemperatureRawBWE;
                        
                     elsif hcnt = 3 then    -- exp_time -- en troisieme position pour donner du temps au calcul de hder_param.exp_time
                        hder_mosi_i.awaddr <= x"FFFF" & std_logic_vector(hder_param.frame_id(7 downto 0)) & std_logic_vector(resize(ExposureTimeAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(hder_param.exp_time);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= ExposureTimeBWE;
                        fast_hder_sm <= wait_acq_hder_st;
                     end if;
                     hcnt <= hcnt + 1;
                     --                  else
                     --                     hder_mosi_i.awvalid <= '0';
                     --                     hder_mosi_i.wvalid <= '0';
                  end if;
               
               when wait_acq_hder_st =>
                  hder_mosi_i.awvalid <= '0';
                  hder_mosi_i.wvalid <= '0';
                  hder_mosi_i.wstrb <= (others => '0');
                  if acq_hder = '0' then
                     fast_hder_sm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
   -----------------------------------------------------
   -- generation misc signaux
   -----------------------------------------------------
   U6 : process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' then
            SPEED_ERR <= '0';
            CFG_MISMATCH <= '0';
            FIFO_ERR <= '0';
            ASSUMP_ERR <= '0';
            DONE <= '0';
            
         else
            
            -- errer de fifo
            if acq_hder_fifo_ovfl = '1' then
               FIFO_ERR <= '1';
            end if;
            
            -- done
            DONE <= not readout_i;
            
         end if;
         
      end if;
   end process;
   
end rtl;
