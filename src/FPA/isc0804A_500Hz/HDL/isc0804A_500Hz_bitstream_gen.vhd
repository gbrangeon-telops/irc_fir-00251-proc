------------------------------------------------------------------
--!   @file : isc0804A_500Hz_bitstream_gen
--!   @brief
--!   @details
--!
--!   $Rev: 22144 $
--!   $Author: enofodjie $
--!   $Date: 2018-09-05 11:00:55 -0400 (mer., 05 sept. 2018) $
--!   $Id: isc0804A_500Hz_bitstream_gen.vhd 22144 2018-09-05 15:00:55Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/isc0804A_500Hz/HDL/isc0804A_500Hz_bitstream_gen.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.fpa_define.all;
use work.tel2000.all;


entity isc0804A_500Hz_bitstream_gen is
   port(
      ARESET               : in std_logic;
      CLK                  : in std_logic;
      
      -- cfg
      USER_CFG             : in fpa_intf_cfg_type;  -- la cfg valide envoyée par l'usager est ici
      FPA_MCLK             : in std_logic;
      
      -- spi     
      SPI_DATA             : out std_logic_vector(63 downto 0);
      SPI_EN               : out std_logic;
      SPI_DONE             : in std_logic;
      
      -- io
      ROIC_RESET_B         : out std_logic;
      
      -- from main ctrler
      DONE                 : out std_logic;
      RQST                 : out std_logic;
      EN                   : in std_logic      
      );                 
end isc0804A_500Hz_bitstream_gen;

architecture rtl of isc0804A_500Hz_bitstream_gen is
   
   constant C_FPA_BITSTREAM_BYTE_NUM_M1 : natural := DEFINE_FPA_BITSTREAM_BYTE_NUM - 1;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   component double_sync_vector is       -- ENO : 10 oct 2017: necessaire pour ce module
      port(
         D : in std_logic_vector;
         Q : out std_logic_vector;
         CLK : in std_logic
         );
   end component;
   
   type reset_fsm_type  is (assert_rst_st, desassert_rst_st, done_st);  
   type cfg_fsm_type is (idle, check_done_st, rqst_st, check_init_st, send_roic_cfg_st, wait_err_st, check_roic_err_st, wait_end_st, update_roic_st, update_cfg_num_st, update_aoi_st, pause_st);
   
   signal cfg_fsm             : cfg_fsm_type;
   signal reset_fsm           : reset_fsm_type;
   signal spi_en_i            : std_logic;
   signal spi_data_i          : std_logic_vector(63 downto 0);
   signal new_roic_cfg        : std_logic_vector(63 downto 0) := (others => '0');
   signal sreset              : std_logic;
   signal present_roic_cfg     : std_logic_vector(63 downto 0);
   signal cfg_changed         : std_logic_vector(7 downto 0);
   signal new_roic_cfg_pending: std_logic;
   signal done_i              : std_logic;
   signal rqst_i              : std_logic;
   signal pause_cnt           : natural range 0 to DEFINE_FPA_PROG_END_PAUSE_FACTOR + 1;
   signal en_i                : std_logic;
   signal roic_reset_done     : std_logic;
   signal roic_reset_n        : std_logic;
   signal mclk_cnt            : unsigned(23 downto 0);
   signal fpa_mclk_last       : std_logic;
   signal mclk_falling_edge   : std_logic;
   
   signal new_aoi_cfg         : area_cfg_type;
   signal present_aoi_cfg      : area_cfg_type;
   signal aoi_cfg_changed     : std_logic_vector(1 downto 0);
   signal new_aoi_cfg_pending : std_logic;
   signal new_cfg_pending     : std_logic;
   signal boost_mode_i        : std_logic_vector(USER_CFG.BOOST_MODE'length-1 downto 0);
   
   signal im                  : std_logic_vector(2 downto 0);
   signal bp                  : std_logic_vector(1 downto 0);
   signal lpd                 : std_logic_vector(1 downto 0);
   signal lp                  : std_logic_vector(2 downto 0);
   signal odb_en              : std_logic_vector(0 downto 0);
   signal dp                  : std_logic_vector(2 downto 0);
   signal mp                  : std_logic_vector(2 downto 0);
   signal cp                  : std_logic_vector(2 downto 0);
   
   signal new_cfg_num         : unsigned(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal present_cfg_num      : unsigned(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal new_cfg_num_pending : std_logic;
   
begin    
   
   -------------------------------------------------
   -- mappings                                                   
   -------------------------------------------------
   SPI_EN <= spi_en_i;
   SPI_DATA <= spi_data_i(SPI_DATA'LENGTH-1 downto 0);
   ROIC_RESET_B <= roic_reset_n;
   
   DONE  <= done_i;
   RQST <= rqst_i;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   -- synchro  
   --------------------------------------------------
   sync_en : double_sync_vector  
   port map(
      D => USER_CFG.BOOST_MODE,
      Q => boost_mode_i,
      CLK => CLK); 
   
   --------------------------------------------------
   --  bistream builder
   --------------------------------------------------
   --bit stream
   U2A : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         
         -- input mapping                                                      
         odb_en <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG(31 downto 28)), odb_en'length));
         bp     <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG(27 downto 24)), bp'length));
         lpd    <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG(23 downto 20)), lpd'length));
         lp     <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG(19 downto 16)), lp'length));
         
         im     <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG(15 downto 12)), im'length));
         dp     <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG(11 downto  8)), dp'length));
         mp     <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG( 7 downto  4)), mp'length));
         cp     <= std_logic_vector(resize(unsigned(USER_CFG.ROIC_DBG_REG( 3 downto  0)), cp'length));
         
         -- Start bit always = 1
         new_roic_cfg(61)<= '1';	
         -- Value/4 =(WAY)
         new_roic_cfg(60 downto 54) <= std_logic_vector(USER_CFG.ROIC.YSTART(8 downto 2));
         -- (Value/4)-1 =(WSY)
         new_roic_cfg(53 downto 47) <= std_logic_vector(USER_CFG.ROIC.YSIZE_DIV4_M1(6 downto 0)); 
         -- PT
         new_roic_cfg(46) <= '0';         
         -- IM[2:0] Master Bias Current Ajust  : "011" 
         new_roic_cfg(45 downto 43) <= im;                  --"011";    
         -- CP[2:0] Column Buffer Bias Ajust  : "101" 
         new_roic_cfg(42 downto 40) <= cp;                  --"101";
         -- CL[1:0] Column Bus Clamp Level Ajust  : "011"
         new_roic_cfg(39 downto 37) <= USER_CFG.CLAMPING_LEVEL;
         -- MP[2:0] Mux Buffer Bias Adjust : "101"
         new_roic_cfg(36 downto 34) <= mp;                  -- "101";
         -- DP[2:0] Output Driver Bias Adjust : "101"
         new_roic_cfg(33 downto 31) <= dp;                  -- boost_mode_i(2 downto 0); -- "101";              
         -- ODB_EN  Output Driver Boost Enable : "1"  => the driver operates with improved power efficiency at a lower power level
         new_roic_cfg(30) <= odb_en(0);                        -- boost_mode_i(4); -- '1';   
         -- BP[1:0] Detector Bias & anti-Bllom  Bias Buffer Adjust : "01"
         new_roic_cfg(29 downto 28) <= bp;                  -- "01";
         -- DE[6:0] Detector Bias Adjust : 
         new_roic_cfg(27 downto 21) <= std_logic_vector(USER_CFG.VDET_CODE);
         -- BLM_E  Even Column Tets Enable : "0"
         new_roic_cfg(20) <= '0';
         -- BLM_O  Odd Column Tets Enable : "0"
         new_roic_cfg(19) <= '0';
         -- LP[2:0] Unit Cell Clock Rise /Fall Adjust: "010"
         new_roic_cfg(18 downto 16) <= lp;                  --"010"; 
         -- LPD[1:0] Global Driver Adjust : "01"
         new_roic_cfg(15 downto 14) <= lpd;                 --"01";
         -- REF[1:0] Reference Column / Reference Buffer: ""
         new_roic_cfg(13 downto 12) <= "00";        
         -- NDRO Enable Non-Destructive Readout : '0'
         new_roic_cfg(11) <= '0';
         -- INT  Integration Mode : ''
         new_roic_cfg(10) <= USER_CFG.ITR;
         -- INV Row Readout Direction : '0'
         new_roic_cfg(9) <= '0';
         -- REV Column Readout Direction : '0'
         new_roic_cfg(8) <= '0';
         -- TR REnable Test Row Readout : '0'
         new_roic_cfg(7) <= USER_CFG.ROIC_TEST_ROW_EN;
         -- OM select Number of outputs
         new_roic_cfg(6) <= '1';
         -- RSVED Reserved Bits "00000"
         new_roic_cfg(5 downto 1) <= "00000";
         -- MRST Serial Data Command Reset
         new_roic_cfg(0) <= '0';          
                 
         -- detection du changement
         for ii in 0 to C_FPA_BITSTREAM_BYTE_NUM_M1 loop
            cfg_changed(ii) <= '0';
            if present_roic_cfg(8*ii + 7 downto 8*ii) /= new_roic_cfg(8*ii + 7 downto 8*ii) then
               cfg_changed(ii) <= '1';
            end if;
         end loop;
         
         -- new_roic_cfg_pending 
         new_roic_cfg_pending <= '0';
         if cfg_changed /= x"00" then 
            new_roic_cfg_pending <= '1';
         end if;
         
      end if;
   end process;    
   
   --------------------------------------------------
   --  Fast Windowing
   --------------------------------------------------
   -- ENO: 19 nov 2017: Pour eviter bugs en fast windowing, reprogrammer le ROIC, dès que l'AOI change (même si la cfg ROIC résultante est inchangée),
   -- ainsi le FPA_INTF_CFG se mettra à jour avec et on n'aura plus de bugs 
   U2B : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         -- novelle config AOI
         new_aoi_cfg.sol_posl_pclk <= USER_CFG.USER_AREA.SOL_POSL_PCLK;    
         new_aoi_cfg.eol_posl_pclk <= USER_CFG.USER_AREA.EOL_POSL_PCLK;
         
         -- detection du changement
         if present_aoi_cfg.sol_posl_pclk /= new_aoi_cfg.sol_posl_pclk then
            aoi_cfg_changed(0) <= '1';
         else
            aoi_cfg_changed(0) <= '0';
         end if;
         if present_aoi_cfg.eol_posl_pclk /= new_aoi_cfg.eol_posl_pclk then
            aoi_cfg_changed(1) <= '1';
         else
            aoi_cfg_changed(1) <= '0';
         end if;
         
         -- new_aoi_cfg_pending         
         if unsigned(aoi_cfg_changed) /= 0 then 
            new_aoi_cfg_pending <= '1';
         else
            new_aoi_cfg_pending <= '0';
         end if;
         
      end if;
   end process; 
   
   --------------------------------------------------
   --  cfg_num
   --------------------------------------------------
   -- ENO: 05 july 2018: Pour eviter bugs en pleine fenetre, reprogrammer le ROIC, dès qu'une config est reçue du MB.
   -- cela corrigera egalement le bug du mode evenementiel.
   
   U2C : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         -- nouvelle config lorsque cfg_num change
         new_cfg_num <= USER_CFG.CFG_NUM;    
         
         -- detection du changement
         if present_cfg_num /= new_cfg_num then
            new_cfg_num_pending <= '1';
         else
            new_cfg_num_pending <= '0';
         end if;         
         
      end if;
   end process;       
   
   -----------------------------------------------------------------
   --  Reset du ROIC au demarrage
   ----------------------------------------------------------------   
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then             -- voir level plus haut pour comprendre que sreset vaut '1' tant que fpa_powered vaut '0'
            reset_fsm <= assert_rst_st;
            mclk_cnt <= (others => '0'); 
            roic_reset_n <= '0';
            roic_reset_done <= '0';
            
         else                       
            
            fpa_mclk_last <= FPA_MCLK;
            mclk_falling_edge <= fpa_mclk_last and not FPA_MCLK;                    
            
            if mclk_falling_edge = '1' then
               mclk_cnt <=  mclk_cnt + 1;               
            end if;
            
            -- pragma translate_off
            mclk_cnt <= (others => '1');
            -- pragma translate_on
            
            case  reset_fsm is         
               
               when assert_rst_st => 
                  roic_reset_n <= '0';    -- le reset du ROIC est actif bas  
                  if mclk_cnt(22)= '1' then   -- un seul bit suffit pour le delai.
                     reset_fsm <= desassert_rst_st; 
                  end if; 
               
               when desassert_rst_st => 
                  roic_reset_n <= '1';                  
                  if mclk_cnt(23) = '1' then  -- un seul bit suffit pour le delai 
                     reset_fsm <= done_st; 
                  end if;
               
               when done_st =>        
                  roic_reset_done <= '1'; -- on peut programmer le ROIC à présent
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
   -----------------------------------------------------------------
   --  Programmation
   ----------------------------------------------------------------    
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if roic_reset_done = '0' then
            spi_en_i <= '0';
            done_i <= '0'; 
            rqst_i <= '0';
            cfg_fsm <= idle;
            present_roic_cfg(61) <= '0';   -- le bit 61 seul forcé à '0'  suffit pour eviter des bugs en power management. En fait cela force la reprogrammation après un reset
            new_cfg_pending <= '0';
            
         else    
            
            en_i <= EN;
            new_cfg_pending <= new_roic_cfg_pending or new_aoi_cfg_pending or new_cfg_num_pending;
            
            -- configuration du detecteur	
            case cfg_fsm is           
               
               -- idle --------------------------------------------
               when idle =>                -- en attente que le programmateur soit à l'écoute
                  spi_en_i <= '0';
                  done_i <= '1'; 
                  rqst_i <= '0';
                  pause_cnt <= 0;
                  if new_cfg_pending = '1' then
                     cfg_fsm <= check_done_st;  
                  end if;   
               
               when check_done_st =>
                  if SPI_DONE = '1'  then
                     cfg_fsm <= rqst_st;
                  end if;                  
               
               when rqst_st =>     
                  rqst_i <= '1'; 
                  spi_data_i <= new_roic_cfg;   -- assigné plusieurs clk plus tôt 
                  if en_i = '1' then 
                     cfg_fsm <= send_roic_cfg_st;  
                  end if;
               
               when send_roic_cfg_st =>
                  done_i <= '0'; 
                  rqst_i <= '0';
                  spi_en_i <= '1';
                  if SPI_DONE = '0'  then 
                     cfg_fsm <= wait_end_st;
                  end if;                  
               
               when wait_end_st =>
                  spi_en_i <= '0';
                  if SPI_DONE = '1' then
                     cfg_fsm <= update_roic_st;
                  end if;  
               
               when update_roic_st =>
                  present_roic_cfg <= spi_data_i;
                  cfg_fsm <= update_aoi_st;
               
               when update_aoi_st =>
                  present_aoi_cfg <= new_aoi_cfg;
                  cfg_fsm <= update_cfg_num_st;
               
               when update_cfg_num_st =>
                  present_cfg_num <= new_cfg_num;
                  cfg_fsm <= pause_st;
               
               when  pause_st =>
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt = DEFINE_FPA_PROG_END_PAUSE_FACTOR then   --  largenment le temps pour que new_roic_cfg_pending retombe avant d'aller à idle
                     cfg_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
end rtl;
