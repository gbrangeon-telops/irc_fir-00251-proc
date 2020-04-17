
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use work.TEL2000.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all;
use work.Proxy_define.all;
use work.trig_define.all;
use work.pelicand_testbench_pkg.all; 

-- Add your library and packages declaration here ...

entity pelicand_top_tb_tB is
end pelicand_top_tb_tB;

architecture TB_ARCHITECTURE of pelicand_top_tb_tB is 
   -- Component declaration of the tested unit
   component pelicand_top_tb
      generic (
      FIG1_FIG2_T4_SEC : real := 0.000001;
      NO_FIRST_READOUT : boolean := true
      );
      port(
         ARESETN        : in std_logic;
         CLK_100M       : in std_logic;
         
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
         ACQ_TRIG        : in std_logic;
         XTRA_TRIG        : in std_logic;
         CONFIG     :  in TRIG_CFG_TYPE;
         SERDES_TRIG     : in std_logic; 
         
         -- microblaze CLK
         MB_CLK         : in std_logic; 
         MB_MISO        : out t_axi4_lite_miso;
         MB_MOSI        : in  t_axi4_lite_mosi;
         -- erreur 
         ERR_FOUND      : out std_logic
         );
   end component;
   
   --------------------------------------------------------------
   -----------------    Simulation Config   --------------------------
   --------------------------------------------------------------
   constant EXP_TIME          : integer := 120; -- us
   constant WIDTH             : integer := 64; 
   constant HEIGHT            : integer := 8;
   constant INTEGRATION_MODE  : integer := 1;      -- 0 : IM_IntegrateThenRead, 1:   IM_IntegrateWhileRead  
   constant FRAME_RATE        : integer := 1000; -- Hz 
   
   constant NO_FIRST_READOUT  : boolean := false;
   constant NB_ACQ_TRIG       : integer := 30;
   constant NB_XTRA_TRIG      : integer := 0;
   
   
   
   
   --------------------------------------------------------------
   -----------------    CLOCKS CONFIG   --------------------------
   --------------------------------------------------------------   
   constant MB_CLK_PERIOD      : time := 10ns;
   constant DET_FREQ_ID_PERIOD : time := 0.333ms;
   constant DOUT_CLK_PERIOD    : time := 6.25ns;
   constant BASE_CLOCK_FREQ_HZ         : integer                := 100000000; 
   constant SCD_DIAG_CMD_ID            : unsigned(31 downto  0) := x"00008004";
   constant SCD_OP_CMD_ID              : unsigned(31 downto  0) := x"00008002"; 
      
   constant TRIG_PERIOD         : integer := integer(1.0/real(FRAME_RATE)*FPA_VHD_INTF_CLK_RATE_HZ);
   constant TRIG_DURATION       : integer := 3;

   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   
   signal MB_MISO                      : t_axi4_lite_miso;
   signal MB_MOSI                      : t_axi4_lite_mosi;
   signal diag_cfg_vector              : unsigned(33*32-1 downto 0);
   signal op_cfg_vector                : unsigned(33*32-1 downto 0);
   signal op_cfg_vector1               : unsigned(33*32-1 downto 0);
   signal op_cfg_vector2               : unsigned(33*32-1 downto 0);
   signal op_cfg_vector3               : unsigned(33*32-1 downto 0);
   signal op_cfg_vector4               : unsigned(33*32-1 downto 0);
   
   signal fpa_softw_stat_i             : fpa_firmw_stat_type;
   signal trig_cnt                     : integer := 0;  
   signal cnt                          : integer := 0;
   type trig_sm_type   is (idle, trig_gen);
   signal trig_sm          : trig_sm_type := idle;
   signal trig_mode        : std_logic := '0';

   
   signal STIM_CFG      : fpa_intf_cfg_type;
   signal SERDES_TRIG   : std_logic;
   signal ACQ_TRIG      : std_logic := '0'; 
   signal XTRA_TRIG     : std_logic := '0';
   signal CONFIG        : TRIG_CFG_TYPE;
   signal ARESETN       : std_logic;
   signal CLK_100M      :  std_logic;
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
   signal SER_TFG_N     : std_logic;
   signal SER_TFG_P     : std_logic;
   signal DOUT_MISO     : t_axi4_stream_miso;
   signal FPA_CH1_DATA  : std_logic_vector(27 downto 0);
   signal FPA_CH2_DATA  : std_logic_vector(27 downto 0);
   signal HDER_MISO     : t_axi4_lite_miso;
   -- Observed signals - signals mapped to the output ports of tested entity
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
   
   -- ARESETN
   U0: process
   begin
      ARESETN <= '0'; 
      wait for 250 ns;
      ARESETN <= '1';
      wait;
   end process;
   
   U2: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         
         case trig_sm  is 
            
            when idle  => 
            
               if cnt < (TRIG_PERIOD - TRIG_DURATION) then 
                  cnt <= cnt + 1;
                  trig_sm <= idle;
               else
                  cnt <= 0; 
                  trig_sm <= trig_gen;
               end if;

            when trig_gen  =>
               if cnt < 3 then 
                 ACQ_TRIG <= trig_mode;
                 --ACQ_TRIG <='0';
                 --XTRA_TRIG <= not trig_mode;
                 XTRA_TRIG <= '0';
                 cnt <= cnt + 1;
                 trig_sm <= trig_gen;
               else
                 cnt <= 0;
                 ACQ_TRIG <= '0';
                 XTRA_TRIG <= '0'; 
                 
                 if trig_mode = '0' and (trig_cnt < NB_XTRA_TRIG -1)  then
                    trig_cnt <= trig_cnt + 1;
                 
                 elsif trig_mode = '1' and (trig_cnt < NB_ACQ_TRIG -1) then
                    trig_cnt <= trig_cnt + 1;
                 else                          
                    trig_cnt <= 0;
                    trig_mode <= not trig_mode;  
                 end if;

                 trig_sm <= idle;
               end if;
   
            when others =>
         
         end case;
      end if;
      
   end process; 
  
   
   -- MB Clk
   U1: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after MB_CLK_PERIOD/2; 
   end process;
   CLK_100M <= transport MB_CLK after 2ns;
  
   -- DET_FREQ_ID
   U3: process(DET_FREQ_ID)                     
   begin                                   
      DET_FREQ_ID <= not DET_FREQ_ID after DET_FREQ_ID_PERIOD/2;
   end process;
   
   -- SER_TFG   
   SER_TFG_N <= SER_TC_N when SER_TC_N /= 'Z' else '0';
   SER_TFG_P <= SER_TC_P when SER_TC_N /= 'Z' else '1';
      
   -- DOUT_CLK
   U4: process(DOUT_CLK)
   begin
      DOUT_CLK <= not DOUT_CLK after DOUT_CLK_PERIOD/2; 
   end process;
   
   -- DOUT_MISO
   DOUT_MISO.TREADY <= '1';
   
   -- HDER_MISO
   HDER_MISO.AWREADY <= '1';
   HDER_MISO.WREADY <= '1';
   
   SERDES_TRIG <= '0';
   
   process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         
         fpa_softw_stat_i.fpa_roic     <= FPA_ROIC_ISC0804;
         fpa_softw_stat_i.fpa_output   <= OUTPUT_ANALOG;    
         fpa_softw_stat_i.fpa_input    <= LVCMOS33;        

         -- cfg usager
         diag_cfg_vector <= to_intf_cfg('0', INTEGRATION_MODE, WIDTH , HEIGHT, FRAME_RATE, real(EXP_TIME)/1000000.0 , x"00000001", SCD_DIAG_CMD_ID); 
         op_cfg_vector <= to_intf_cfg('0', INTEGRATION_MODE, WIDTH , HEIGHT, FRAME_RATE, real(EXP_TIME)/1000000.0,   x"00000002", SCD_OP_CMD_ID);
         op_cfg_vector1 <= to_intf_cfg('0', INTEGRATION_MODE, WIDTH , HEIGHT, FRAME_RATE, real(EXP_TIME)/1000000.0,  x"00000003" , SCD_OP_CMD_ID);
         op_cfg_vector2 <= to_intf_cfg('0', INTEGRATION_MODE, WIDTH , HEIGHT, FRAME_RATE, real(EXP_TIME)/1000000.0,  x"00000004" , SCD_OP_CMD_ID);
         op_cfg_vector3 <= to_intf_cfg('0', INTEGRATION_MODE, WIDTH , HEIGHT, FRAME_RATE, real(EXP_TIME)/1000000.0,  x"00000005" , SCD_OP_CMD_ID);
         op_cfg_vector4 <= to_intf_cfg('0', INTEGRATION_MODE, WIDTH , HEIGHT, FRAME_RATE, real(EXP_TIME)/1000000.0,  x"00000006" , SCD_OP_CMD_ID);
         
      end if;
   end process;
   
   fpa_softw_stat_i.fpa_roic     <= FPA_ROIC_PELICAND;
   fpa_softw_stat_i.fpa_output   <= OUTPUT_DIGITAL;    
   fpa_softw_stat_i.fpa_input    <= LVDS25;   
   
   ublaze_sim: process is
      
      variable start_pos : integer;
      variable end_pos   : integer;
      
   begin
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
   
      FPA_EXP_INFO.exp_dval <= '0';
      
      
      wait for 30 ns;
      
      -- COnfiguration du module de stimulation
      start_pos := op_cfg_vector'length -1 - 32*1;
      end_pos   := start_pos - 31;
      STIM_CFG.COMN.FPA_DIAG_TYPE <= resize(std_logic_vector(op_cfg_vector(start_pos downto end_pos)), 8);
      
      start_pos := op_cfg_vector'length -1 - 32*15;
      end_pos   := start_pos - 31;
      STIM_CFG.SCD_OP.SCD_INT_MODE <=  resize(std_logic_vector(op_cfg_vector(start_pos downto end_pos)), 8); 
      
      
      start_pos := op_cfg_vector'length -1 - 32*20;
      end_pos   := start_pos - 31;
      STIM_CFG.SCD_MISC.SCD_FIG1_OR_FIG2_T6_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16); 
      
      start_pos := op_cfg_vector'length -1 - 32*22;
      end_pos   := start_pos - 31;
      STIM_CFG.SCD_MISC.SCD_FIG4_T2_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16);
      
      start_pos := op_cfg_vector'length -1 - 32*23;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_MISC.SCD_FIG4_T6_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16); 
      
      start_pos := op_cfg_vector'length -1 - 32*24;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_MISC.SCD_FIG4_T3_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16);
      
      start_pos := op_cfg_vector'length -1 - 32*25;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_MISC.SCD_FIG4_T5_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16); 
      
      STIM_CFG.SCD_INT.SCD_INT_TIME     <= resize(sec_to_clks(real(EXP_TIME)/1000000.0), 24);                   
      
      start_pos := op_cfg_vector'length -1 - 32*11;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_OP.SCD_YSIZE <= resize(op_cfg_vector(start_pos downto end_pos), 11); 
      
      start_pos := op_cfg_vector'length -1 - 32*10;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_OP.SCD_XSIZE <= resize(op_cfg_vector(start_pos downto end_pos), 11); 
      
      start_pos := op_cfg_vector'length -1 - 32*29;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_MISC.SCD_XSIZE_DIV2 <= resize(op_cfg_vector(start_pos downto end_pos), 10); 
      
      start_pos := op_cfg_vector'length -1 - 32*26;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_MISC.SCD_FIG4_T4_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16); 
      
      start_pos := op_cfg_vector'length -1 - 32*27;
      end_pos   := start_pos - 31;      
      STIM_CFG.SCD_MISC.SCD_FIG1_OR_FIG2_T5_DLY <= resize(op_cfg_vector(start_pos downto end_pos), 16);      
      
      
      wait until ARESETN = '1';  
      wait for 150 ns;
      write_axi_lite (MB_CLK, resize(X"F0",32), (others => '1'), MB_MISO,  MB_MOSI);
      wait for 150 ns;
      write_axi_lite (MB_CLK, resize(X"F0",32), (others => '0'), MB_MISO,  MB_MOSI);
      wait for 150 ns;      
            
            
      write_axi_lite (MB_CLK, resize(X"AE0",32), resize('0'&fpa_softw_stat_i.fpa_roic, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, resize(X"AE4",32), resize('0'&fpa_softw_stat_i.fpa_output, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, resize(X"AE8",32), resize('0'&fpa_softw_stat_i.fpa_input, 32), MB_MISO,  MB_MOSI);
      wait for 500 ns;
          
      for ii in 0 to 33-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := diag_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(diag_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      
      write_axi_lite (MB_CLK, resize(X"4FC",32), (others => '0'), MB_MISO,  MB_MOSI); -- On simule la fin de l'envoi de config. serielle 
      wait for  30 ns;
      write_axi_lite (MB_CLK, resize(X"4FC",32), (others => '1'), MB_MISO,  MB_MOSI); -- On simule la fin de l'envoi de config. serielle 
      wait for 30 ns; 
      
      for ii in 0 to 33-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := op_cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      
      wait for  500 ns;                                                               -- Simulation du délai de réponse de PROXY_POWERED 
      write_axi_lite (MB_CLK, resize(X"08",32), (others => '1'), MB_MISO,  MB_MOSI); -- fpa_pwr_on (= PROXY_POWERED en simulation)
      wait for 30 ns;
      
      write_axi_lite (MB_CLK, resize(X"4FC",32), (others => '0'), MB_MISO,  MB_MOSI); -- On simule la fin de l'envoi de config. serielle 
      wait for  10 us;
      write_axi_lite (MB_CLK, resize(X"4FC",32), (others => '1'), MB_MISO,  MB_MOSI); -- On simule la fin de l'envoi de config. serielle 
      wait for 30 ns;
      

      CONFIG.acq_window <= '1';
      CONFIG.force_high <= '0';
      CONFIG.fpatrig_dly <= (others => '0');
      CONFIG.high_time <= (others => '0');
      CONFIG.mode <= x"04";
      CONFIG.period <= to_unsigned(integer(100000000.0/real(FRAME_RATE)),32); 
      CONFIG.run <= '1';
      CONFIG.seq_trigsource <= '1';
      CONFIG.seq_framecount <= x"00000001";
      CONFIG.trig_activ <= (others => '0');
      
      
      FPA_EXP_INFO.exp_time <= to_unsigned(EXP_TIME*100, FPA_EXP_INFO.exp_time'length);  
      FPA_EXP_INFO.exp_indx <= (others =>'0');
      FPA_EXP_INFO.exp_dval <= '1';
      CONFIG.high_time <= FPA_EXP_INFO.exp_time;   -- trig_cfg_i.high_time;     -- le soin est donné au contrôleur de savoir quand rendre cela effectif

      wait for 30 ns;
      FPA_EXP_INFO.exp_dval <= '0'; 
      
--      ---------------------------
--      wait for 20 ms;
--      
--      for ii in 0 to 33-1 loop 
--         wait until rising_edge(MB_CLK);      
--         start_pos := op_cfg_vector1'length -1 - 32*ii;
--         end_pos   := start_pos - 31;
--         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(op_cfg_vector1(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
--         wait for 30 ns;
--      end loop; 
--      
--      write_axi_lite (MB_CLK, resize(X"4FC",32), (others => '0'), MB_MISO,  MB_MOSI); -- On simule la fin de l'envoi de config. serielle 
--      wait for  30 ns;
--      write_axi_lite (MB_CLK, resize(X"4FC",32), (others => '1'), MB_MISO,  MB_MOSI); -- On simule la fin de l'envoi de config. serielle 
--      wait for 30 ns;
     
      report "FCR written"; 
      
      report "END OF SIMULATION" 
      severity error;
   end process ublaze_sim;   
   
   
   -- Unit Under Test port map
   UUT : pelicand_top_tb 
   Generic map(
   FIG1_FIG2_T4_SEC => FIG1_FIG2_T4_SEC,
   NO_FIRST_READOUT => NO_FIRST_READOUT
   )
   port map (
      ARESETN => ARESETN,
      CLK_100M => CLK_100M,
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
      ACQ_TRIG => ACQ_TRIG,
      XTRA_TRIG => XTRA_TRIG,  
      CONFIG => CONFIG, 
      STIM_CFG => STIM_CFG,
      SERDES_TRIG => SERDES_TRIG
      );

   
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pelicand_top_tb of pelicand_top_tb_tB is
   for TB_ARCHITECTURE
      for UUT : pelicand_top_tb
         use entity work.pelicand_top_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_pelicand_top_tb;

