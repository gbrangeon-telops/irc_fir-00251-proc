
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use work.TEL2000.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all;
use work.Proxy_define.all;
use work.trig_define.all;
use work.blackbird1280D_testbench_pkg.all; 

-- Add your library and packages declaration here ...

entity blackbird1280D_top_tb_tB is
end blackbird1280D_top_tb_tB;

architecture TB_ARCHITECTURE of blackbird1280D_top_tb_tB is 
   -- Component declaration of the tested unit
   component blackbird1280D_top_tb
      generic (
      FIG1_FIG2_T4_SEC : real := 0.000001;
      NO_FIRST_READOUT : boolean := true
      );
      port(
         ARESETN        : in std_logic;
         CLK_100M       : in std_logic;
         CLK_85M         : in std_logic;
         
         -- reconnaissance ddc et allumage detecteur
         DET_FREQ_ID    : in std_logic;
         DET_FPA_ON     : out std_logic;
         
         -- contrôle proxy                   
         DET_SPARE_N0   : in std_logic;
         DET_SPARE_N1   : in std_logic;
         DET_SPARE_N2   : in std_logic;
         DET_SPARE_P0   : in std_logic;
         DET_SPARE_P1   : in std_logic;
         DET_SPARE_P2   : in std_logic;
         DET_CC_N1      : out std_logic;
         DET_CC_N2      : out std_logic;
         DET_CC_N3      : out std_logic;
         DET_CC_N4      : out std_logic;
         DET_CC_P1      : out std_logic;
         DET_CC_P2      : out std_logic;
         DET_CC_P3      : out std_logic;
         DET_CC_P4      : out std_logic;
         SER_TFG_N      : in std_logic;
         SER_TFG_P      : in std_logic;
         FSYNC_N        : out std_logic;
         FSYNC_P        : out std_logic;
         SER_TC_N       : out std_logic;
         SER_TC_P       : out std_logic;
         
         -- entree des données
         DOUT_CLK       : in std_logic; 

         -- temps d'intégration
         FPA_EXP_INFO   : in exp_info_type;
         
         STIM_CFG       : in fpa_intf_cfg_type;
         
         -- sortie pixels                 
         DOUT_MOSI      : out t_axi4_stream_mosi64;
         DOUT_MISO      : in t_axi4_stream_miso;
         
         -- header part
         HDER_MOSI      : out t_axi4_lite_mosi;
         HDER_MISO      : in t_axi4_lite_miso;  
         
         --FPA_INTF_CFG    : in fpa_intf_cfg_type;  
         TRIG_CONFIG     :  in TRIG_CFG_TYPE;
         SERDES_TRIG     : in std_logic; 
         
         -- microblaze CLK
         MB_CLK         : in std_logic;
         DATA_CLK       : in std_logic; 
         MB_MISO        : out t_axi4_lite_miso;
         MB_MOSI        : in  t_axi4_lite_mosi;
         -- erreur 
         ERR_FOUND      : out std_logic
         );
   end component;
   
   -- MISC 
   constant NO_FIRST_READOUT  : boolean := false;
   constant NB_ACQ_TRIG       : integer := 30;
   constant NB_XTRA_TRIG      : integer := 0;    
   
   --------------------------------------------------------------
   -----------------    CLOCKS CONFIG   --------------------------
   --------------------------------------------------------------   
   constant MB_CLK_PERIOD              : time := 10ns;
   constant DATA_CLK_PERIOD            : time := 11.764705882352941176470588235294ns;
   constant DET_FREQ_ID_PERIOD         : time := 0.333ms;
   constant DOUT_CLK_PERIOD            : time := 6.25ns;
   constant BASE_CLOCK_FREQ_HZ         : integer                := 100000000; 
   signal sim_cfg_i                     : sim_cfg_type;
   signal MB_MISO                      : t_axi4_lite_miso;
   signal MB_MOSI                      : t_axi4_lite_mosi;
   signal diag_cfg_vector              : unsigned(NB_PARAM_CFG*32-1 downto 0);
   signal op_cfg_vector                : unsigned(NB_PARAM_CFG*32-1 downto 0);
   signal fpa_softw_stat_i             : fpa_firmw_stat_type;
   signal fpa_intf_cfg_i     : fpa_intf_cfg_type;
   signal SERDES_TRIG   : std_logic;
   signal trig_config   : TRIG_CFG_TYPE;
   signal ARESETN       : std_logic;
   signal CLK_100M      :  std_logic;
   signal CLK_85M      :  std_logic;
   signal DET_FREQ_ID   : std_logic := '0';
   signal DET_SPARE_N0  : std_logic;
   signal DET_SPARE_N1  : std_logic;
   signal DET_SPARE_N2  : std_logic;
   signal DET_SPARE_P0  : std_logic;
   signal DET_SPARE_P1  : std_logic;
   signal DET_SPARE_P2  : std_logic;
   signal DOUT_CLK      : std_logic := '0';
   signal FPA_CH1_CLK   : std_logic;
   signal FPA_CH2_CLK   : std_logic;
   signal FPA_EXP_INFO  : exp_info_type;
   signal MB_CLK        : std_logic := '0';
   signal DATA_CLK        : std_logic := '0';
   signal SER_TFG_N     : std_logic;
   signal SER_TFG_P     : std_logic;
   signal DOUT_MISO     : t_axi4_stream_miso;
   signal FPA_CH1_DATA  : std_logic_vector(27 downto 0);
   signal FPA_CH2_DATA  : std_logic_vector(27 downto 0);
   signal HDER_MISO     : t_axi4_lite_miso;
   signal DET_CC_N1     : std_logic;
   signal DET_CC_N2     : std_logic;
   signal DET_CC_N3     : std_logic;
   signal DET_CC_N4     : std_logic;
   signal DET_CC_P1     : std_logic;
   signal DET_CC_P2     : std_logic;
   signal DET_CC_P3     : std_logic;
   signal DET_CC_P4     : std_logic;
   signal DET_FPA_ON    : std_logic;
   signal ERR_FOUND     : std_logic;
   signal FSYNC_N       : std_logic;
   signal FSYNC_P       : std_logic;
   signal SER_TC_N      : std_logic;
   signal SER_TC_P      : std_logic;
   signal DOUT_MOSI     : t_axi4_stream_mosi64;
   signal HDER_MOSI     : t_axi4_lite_mosi;
   -- Add your code here ...
   signal flag      : std_logic := '0';
begin
   -- MB Clk
   U1A: process(MB_CLK)
   begin
   MB_CLK <= not MB_CLK after MB_CLK_PERIOD/2; 
   end process;
   CLK_100M <= transport MB_CLK after 2ns;

   U1B: process(DATA_CLK)
   begin
   DATA_CLK <= not DATA_CLK after DATA_CLK_PERIOD/2; 
   end process;
   CLK_85M <= transport DATA_CLK after 2ns;
   
   
   -- DET_FREQ_ID
   U3: process(DET_FREQ_ID)                     
   begin                                   
      DET_FREQ_ID <= not DET_FREQ_ID after DET_FREQ_ID_PERIOD/2;
   end process;
   -- SER_TFG   
   SER_TFG_N <= SER_TC_N when SER_TC_N /= 'Z' else '0';
   SER_TFG_P <= SER_TC_P when SER_TC_N /= 'Z' else '1';

   ublaze_sim: process is
      variable start_pos : integer;
      variable end_pos   : integer; 
      variable scd_exp_time_conv_numerator : real;
   begin 
      
      
      --------- Définition des conditions initiales ------------------
      ARESETN <= '0';
      
      MB_MOSI.awaddr <= (others => '0');
      MB_MOSI.awprot <= (others => '0');
      MB_MOSI.wdata <= (others => '0');
      MB_MOSI.wstrb <= (others => '0');
      MB_MOSI.araddr <= (others => '0');
      MB_MOSI.arprot <= (others => '0');
      
      MB_MOSI.awvalid <= '0';
      MB_MOSI.wvalid <= '0';
      MB_MOSI.bready <= '0';
      MB_MOSI.arvalid <= '0';
      MB_MOSI.rready <= '0';

      -- Generation de la config initiale
      sim_cfg_i.framerate <= 2000.0; 
      sim_cfg_i.height <= 256; -- heigth/2
      sim_cfg_i.width <= 160; -- width/4
      sim_cfg_i.offsety <= 0;
      sim_cfg_i.offsetx <= 0;
      sim_cfg_i.exp_time <= 18; -- 0.5 us
      sim_cfg_i.frame_res <= 2; -- 2*(1/70MHz)
      
      sim_cfg_i.fpa_stretch_acq_trig <= '0'; -- don't care
      sim_cfg_i.cmd_to_update_id <= SCD_OP_CMD_ID;
      
      -- Generation de la config du module de trig
      trig_config.acq_window <= '0'; -- par défaut, a l'init on envoi des xtra_trig.
      trig_config.force_high <= '0';
      trig_config.fpatrig_dly <= (others => '0');
      trig_config.high_time <= (others => '0');
      trig_config.mode <= x"04";
      wait for 30 ns;
      trig_config.period <= resize(sec_to_clks(1.0/sim_cfg_i.framerate),trig_config.period'length); 
      trig_config.run <= '1';
      trig_config.seq_trigsource <= '1';
      trig_config.seq_framecount <= x"00000001";
      trig_config.trig_activ <= (others => '0');
      
      scd_exp_time_conv_numerator := ((70.0E6/(real(FPA_INTF_CLK_RATE_MHZ)*1.0E6))/real(sim_cfg_i.frame_res))*(2.0**SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS);

      -- Initialisation du feedback de temps d'exposition
      FPA_EXP_INFO.exp_dval <= '0';
      FPA_EXP_INFO.exp_time <= resize(sec_to_clks(real(sim_cfg_i.exp_time)*real(sim_cfg_i.frame_res)*(1.0/(70.0E6))), FPA_EXP_INFO.exp_time'length);

      FPA_EXP_INFO.exp_indx <= (others =>'0');
      trig_config.high_time <= FPA_EXP_INFO.exp_time;  

      -- Hole at fpa module output
      DOUT_MISO.TREADY <= '1';
     
      -- HDER_MISO
      HDER_MISO.AWREADY <= '1';
      HDER_MISO.WREADY <= '1'; 

      SERDES_TRIG <= '0'; -- On néglige l'init des SERDES
      wait for 100 ns;
      ARESETN <= '1';  
      wait for 1 us; 
      
      --Initialisation faite par le uB dans FPA_Init()

      -- 1. FPA_Reset()
      wait for 150 ns;
      write_axi_lite (MB_CLK, resize(X"F0",32), (others => '1'), MB_MISO,  MB_MOSI);
      wait for 150 ns;
      write_axi_lite (MB_CLK, resize(X"F0",32), (others => '0'), MB_MISO,  MB_MOSI);
      wait for 150 ns;  
      -- 2. FPA_ClearErr()
      write_axi_lite (MB_CLK, resize(X"EC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 150 ns;
      write_axi_lite (MB_CLK, resize(X"EC",32), (others => '0'), MB_MISO,  MB_MOSI); 
      wait for 150 ns; 
      -- 3. FPA_SoftwType()
      write_axi_lite (MB_CLK, resize(X"E0",32), resize(FPA_ROIC_SCD_PROXY1, 32), MB_MISO,  MB_MOSI);
      wait for 150 ns;
      write_axi_lite (MB_CLK, resize(X"E4",32), resize(OUTPUT_DIGITAL, 32), MB_MISO,  MB_MOSI);
      wait for 150 ns;
      -- 4. FPA_GetTemperature()   -- On néglige la lecture de température 

      -- 5.  Envoi de la commande de frame resolution.
      write_axi_lite (MB_CLK, resize(X"A0",32),  std_logic_vector(to_unsigned(integer(scd_exp_time_conv_numerator),32)), MB_MISO,  MB_MOSI);   
      wait for 500 ns;    
      write_axi_lite (MB_CLK, resize(X"C00",32), resize(x"AA", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C04",32), resize(x"10", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C08",32), resize(x"80", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C0C",32), resize(x"02", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C10",32), resize(x"00", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C14",32), resize(x"02", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C18",32), resize(x"00", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C1C",32), resize(x"CC", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 100 us;
      -- 6. FPA_SendConfigGC() (Lors de la configuration pendant l'init, le mode de patron test est activé) 
      -- 6.1 Envoi de la commande synthétique 
      sim_cfg_i.cmd_to_update_id <= SCD_DIAG_CMD_ID; 
      sim_cfg_i.test_ptrn_on <= '1';
      sim_cfg_i.cfg_num <= x"01";
      wait for 30 ns;
      fpa_intf_cfg_i <= mediumGainIWR_SpecificParams(sim_cfg_i);
      wait for 30 ns;
      op_cfg_vector <= to_intf_cfg(fpa_intf_cfg_i);
      wait for 30 ns; 
      
      for ii in 0 to NB_PARAM_CFG-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;  
      
      -- Simulation du debut de l'envoi de la config. serielle     
      write_axi_lite (MB_CLK, resize(X"800",32), (others => '1'), MB_MISO,  MB_MOSI);  
      wait for  500 ns;
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 30 ns; 
      
      -- 6.2 Envoi de la commande operationnelle 
      sim_cfg_i.cmd_to_update_id <= SCD_OP_CMD_ID;
      wait for 30 ns;
      fpa_intf_cfg_i <= mediumGainIWR_SpecificParams(sim_cfg_i);
      wait for 30 ns;
      op_cfg_vector <= to_intf_cfg(fpa_intf_cfg_i);
      wait for 30 ns; 
      
      for ii in 0 to NB_PARAM_CFG-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;  
      
      -- Simulation du debut de l'envoi de la config. serielle     
      write_axi_lite (MB_CLK, resize(X"800",32), (others => '1'), MB_MISO,  MB_MOSI);  
      wait for  500 ns;
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 30 ns; 
      

      ----------------------------- Fin de l'initialisation (prend environ 1.15 ms à exécuter)---------------------------  
      -- 1. A la suite la suite de l'init, CLINK_RST_N lève et des acq_trig commence a être génénés. 
      -- 2. On néglige l'initialisation des SERDES (SERDES_TRIG ne monte pas a '1' suite à la montée de CLINK_RST_N)
      -------------------------------------------------------------------------------------------------------------------
      
      FPA_EXP_INFO.exp_dval <= '1';
      wait for 30 ns;
      FPA_EXP_INFO.exp_dval <= '0';
      
      
      wait for 1.5 ms; 

      ----------------------------- Activation du mode normale (pas en test patern)--------------------------- 
      -- 5  Envoi de la commande de frame resolution.
      write_axi_lite (MB_CLK, resize(X"A0",32),  std_logic_vector(to_unsigned(integer(scd_exp_time_conv_numerator),32)), MB_MISO,  MB_MOSI);   
      wait for 500 ns;    
      write_axi_lite (MB_CLK, resize(X"C00",32), resize(x"AA", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C04",32), resize(x"10", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C08",32), resize(x"80", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C0C",32), resize(x"02", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C10",32), resize(x"00", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C14",32), resize(x"02", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C18",32), resize(x"00", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C1C",32), resize(x"CC", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 100 us;
      
      -- 6. FPA_SendConfigGC() (Lors de la configuration pendant l'init, le mode de patron test est activé)      
      -- 6.1 Envoi de la commande synthétique 
      sim_cfg_i.cmd_to_update_id <= SCD_DIAG_CMD_ID; 
      --sim_cfg_i.test_ptrn_on <= '0';
      sim_cfg_i.cfg_num <= x"02";
      wait for 30 ns;
      fpa_intf_cfg_i <= mediumGainIWR_SpecificParams(sim_cfg_i);
      wait for 30 ns;
      op_cfg_vector <= to_intf_cfg(fpa_intf_cfg_i);
      wait for 30 ns; 
      
      for ii in 0 to NB_PARAM_CFG-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;  
      
      -- Simulation du debut de l'envoi de la config. serielle     
      write_axi_lite (MB_CLK, resize(X"800",32), (others => '1'), MB_MISO,  MB_MOSI);  
      wait for  500 ns;
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 30 ns; 
      
      -- 6.2 Envoi de la commande operationnelle 
      sim_cfg_i.cmd_to_update_id <= SCD_OP_CMD_ID;
      wait for 30 ns;
      fpa_intf_cfg_i <= mediumGainIWR_SpecificParams(sim_cfg_i);
      wait for 30 ns;
      op_cfg_vector <= to_intf_cfg(fpa_intf_cfg_i);
      wait for 30 ns; 
      
      for ii in 0 to NB_PARAM_CFG-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;  
      
      -- Simulation du debut de l'envoi de la config. serielle     
      write_axi_lite (MB_CLK, resize(X"800",32), (others => '1'), MB_MISO,  MB_MOSI);  
      wait for  500 ns;
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 30 ns;          
      
      ----------------------------- Activation du mode normale (pas en test patern)--------------------------- 
      
      wait for 1.5 ms;
      trig_config.acq_window <= '1'; -- Acquisition start
      wait for 3 ms; 
      
          
      --5.  Envoi de la commande de frame resolution.
      write_axi_lite (MB_CLK, resize(X"A0",32),  std_logic_vector(to_unsigned(integer(scd_exp_time_conv_numerator),32)), MB_MISO,  MB_MOSI);   
      wait for 500 ns;    
      write_axi_lite (MB_CLK, resize(X"C00",32), resize(x"AA", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C04",32), resize(x"10", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C08",32), resize(x"80", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C0C",32), resize(x"02", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C10",32), resize(x"00", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C14",32), resize(x"02", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C18",32), resize(x"00", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"C1C",32), resize(x"CC", 32), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 50 ns; 
      -- 6. FPA_SendConfigGC() (Lors de la configuration pendant l'init, le mode de patron test est activé)      
      -- 6.1 Envoi de la commande synthétique 
      sim_cfg_i.cmd_to_update_id <= SCD_DIAG_CMD_ID; 
      --sim_cfg_i.test_ptrn_on <= '0';
      sim_cfg_i.cfg_num <= x"03";
      wait for 30 ns;
      fpa_intf_cfg_i <= mediumGainIWR_SpecificParams(sim_cfg_i);
      wait for 30 ns;
      op_cfg_vector <= to_intf_cfg(fpa_intf_cfg_i);
      wait for 30 ns; 
      
      for ii in 0 to NB_PARAM_CFG-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;  
      
      -- Simulation du debut de l'envoi de la config. serielle     
      write_axi_lite (MB_CLK, resize(X"800",32), (others => '1'), MB_MISO,  MB_MOSI);  
      wait for  500 ns;
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 30 ns; 
      
      -- 6.2 Envoi de la commande operationnelle 
      sim_cfg_i.cmd_to_update_id <= SCD_OP_CMD_ID;
      wait for 30 ns;
      fpa_intf_cfg_i <= mediumGainIWR_SpecificParams(sim_cfg_i);
      wait for 30 ns;
      op_cfg_vector <= to_intf_cfg(fpa_intf_cfg_i);
      wait for 30 ns; 
      
      for ii in 0 to NB_PARAM_CFG-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;  
      
      -- Simulation du debut de l'envoi de la config. serielle     
      write_axi_lite (MB_CLK, resize(X"800",32), (others => '1'), MB_MISO,  MB_MOSI);  
      wait for  500 ns;
      -- Simulation de la fin de l'envoi de la config. serielle 
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '0'), MB_MISO,  MB_MOSI);  
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"8FC",32), (others => '1'), MB_MISO,  MB_MOSI); 
      wait for 30 ns;          
      
      ----------------------------- Activation du mode normale (pas en test patern)--------------------------- 
      wait for 3 ms; 
      trig_config.acq_window <= '0'; -- Acquisition start
      wait for 5 ms; 
      trig_config.acq_window <= '1'; -- Acquisition start
      wait;
      report "FCR written"; 
      
      report "END OF SIMULATION" 
      severity error;
   end process ublaze_sim;   
   
   
   -- Unit Under Test port map
   UUT : blackbird1280D_top_tb 
   Generic map(
   NO_FIRST_READOUT => NO_FIRST_READOUT
   )
   port map (
      ARESETN => ARESETN,
      CLK_100M => CLK_100M,
      CLK_85M => CLK_85M,
      DET_FREQ_ID => DET_FREQ_ID,
      DET_SPARE_N0 => DET_SPARE_N0,
      DET_SPARE_N1 => DET_SPARE_N1,
      DET_SPARE_N2 => DET_SPARE_N2,
      DET_SPARE_P0 => DET_SPARE_P0,
      DET_SPARE_P1 => DET_SPARE_P1,
      DET_SPARE_P2 => DET_SPARE_P2,
      DOUT_CLK => DOUT_CLK,
      DOUT_MISO => DOUT_MISO,
      FPA_EXP_INFO => FPA_EXP_INFO,
      HDER_MISO => HDER_MISO,
      MB_CLK => MB_CLK,
      DATA_CLK => DATA_CLK,
      MB_MOSI => MB_MOSI,
      MB_MISO => MB_MISO,
      SER_TFG_N => SER_TFG_N,
      SER_TFG_P => SER_TFG_P,
      DET_CC_N1 => DET_CC_N1,
      DET_CC_N2 => DET_CC_N2,
      DET_CC_N3 => DET_CC_N3,
      DET_CC_N4 => DET_CC_N4,
      DET_CC_P1 => DET_CC_P1,
      DET_CC_P2 => DET_CC_P2,
      DET_CC_P3 => DET_CC_P3,
      DET_CC_P4 => DET_CC_P4,
      DET_FPA_ON => DET_FPA_ON,
      DOUT_MOSI => DOUT_MOSI,
      ERR_FOUND => ERR_FOUND,
      FSYNC_N => FSYNC_N,
      FSYNC_P => FSYNC_P,
      HDER_MOSI => HDER_MOSI,
      SER_TC_N => SER_TC_N,
      SER_TC_P => SER_TC_P, 
      TRIG_CONFIG => trig_config, 
      STIM_CFG => fpa_intf_cfg_i,
      SERDES_TRIG => SERDES_TRIG
      );

   
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_blackbird1280D_top_tb of blackbird1280D_top_tb_tB is
   for TB_ARCHITECTURE
      for UUT : blackbird1280D_top_tb
         use entity work.blackbird1280D_top_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_blackbird1280D_top_tb;
