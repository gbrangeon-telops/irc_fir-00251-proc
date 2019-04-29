------------------------------------------------------------------
--!   @file : isc0207A_3k_bitstream_gen
--!   @brief
--!   @details
--!
--!   $Rev: 22020 $
--!   $Author: enofodjie $
--!   $Date: 2018-07-16 16:43:46 -0400 (lun., 16 juil. 2018) $
--!   $Id: isc0207A_3k_bitstream_gen.vhd 22020 2018-07-16 20:43:46Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/isc0207A_3k/HDL/isc0207A_3k_bitstream_gen.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.fpa_define.all;
use work.tel2000.all;


entity isc0207A_3k_bitstream_gen is
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
end isc0207A_3k_bitstream_gen;

architecture rtl of isc0207A_3k_bitstream_gen is
   
   constant C_FPA_BITSTREAM_BYTE_NUM_M1 : natural := DEFINE_FPA_BITSTREAM_BYTE_NUM - 1;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   type reset_fsm_type  is (assert_rst_st, desassert_rst_st, done_st);  
   type cfg_fsm_type is (idle, check_done_st, rqst_st, check_init_st, send_roic_cfg_st, wait_err_st, check_roic_err_st, wait_end_st, update_roic_st, update_aoi_st, pause_st, update_cfg_num_st);
   
   signal cfg_fsm        : cfg_fsm_type;
   signal reset_fsm           : reset_fsm_type;
   signal spi_en_i            : std_logic;
   signal spi_data_i          : std_logic_vector(63 downto 0);
   signal new_roic_cfg        : std_logic_vector(63 downto 0) := (others => '0');
   signal sreset              : std_logic;
   signal actual_roic_cfg     : std_logic_vector(63 downto 0);
   signal roic_cfg_changed    : std_logic_vector(7 downto 0);
   signal new_roic_cfg_pending: std_logic;
   signal done_i              : std_logic;
   signal rqst_i              : std_logic;
   signal pause_cnt           : unsigned(7 downto 0);
   signal en_i                : std_logic;
   signal roic_reset_done     : std_logic;
   signal roic_reset_n        : std_logic;
   signal mclk_cnt            : unsigned(7 downto 0);
   signal fpa_mclk_last       : std_logic;
   signal mclk_falling_edge   : std_logic;
   
   signal new_aoi_cfg         : area_cfg_type;
   signal actual_aoi_cfg      : area_cfg_type;
   signal aoi_cfg_changed     : std_logic_vector(1 downto 0);
   signal new_aoi_cfg_pending : std_logic;
   signal new_cfg_pending     : std_logic; 
   
   signal new_cfg_num         : unsigned(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal actual_cfg_num      : unsigned(USER_CFG.CFG_NUM'LENGTH-1 downto 0);
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
   --  bistream builder
   --------------------------------------------------
   --bit stream POFIMI
   U2A : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         -- Start bit always = 1
         new_roic_cfg(57)<= '1';	
         -- Value / 32 =(WAX)
         new_roic_cfg(56 downto 53) <= std_logic_vector(USER_CFG.ROIC.XSTART(8 downto 5));
         -- Value / 2 =(WAY)
         new_roic_cfg(52 downto 46) <= std_logic_vector(USER_CFG.ROIC.YSTART(7 downto 1));
         -- Value / 32 =(WSX)
         new_roic_cfg(45 downto 42) <= std_logic_vector(USER_CFG.ROIC.XSIZE(8 downto 5));
         -- (Value / 2) - 1 =(WSY)
         new_roic_cfg(41 downto 35) <= std_logic_vector(USER_CFG.ROIC.YSIZE_DIV2_M1(6 downto 0)); 
         
         -- valeur en mode non boosté 
         
         -- IM[2:0] 		Master Bias Current Ajust  : "001" 
         new_roic_cfg(34 downto 32) <= "001";    
         -- UCP[2:0]  	Unit Cell CTIA Bias Ajust : "111" 
         new_roic_cfg(31 downto 29) <= "111";
         -- CMP[1:0] 	Column, Mux Buffer Bias Ajust  : "10"
         new_roic_cfg(28 downto 27) <= "10";
         -- ODP[1:0] 	Output Driver Bias Ajust: "10" 
         new_roic_cfg(26 downto 25) <= "10";
         -- Integration Capacitor (GC) // choix de Cint '0' pour Cint= 10 fF
         new_roic_cfg(24)<= USER_CFG.GAIN; 		
         new_roic_cfg(23 downto 22) <= "00";--BW;  	
         new_roic_cfg(21 downto 18) <= "0100";  
         -- UCRF[1:0]  Unit Cell Clock rise/Fall Time Ajust: "01"
         -- RSTR[1:0] Unit Cell Reset Clock rise/Fall Time Ajust : "00"            
         
         -- test en mode boost ou un nouveau bistream est appliqué.
         if USER_CFG.BOOST_MODE = '1' then 
            -- IM[2:0] 		Master Bias Current Ajust  : "100" 
            --new_roic_cfg(34 downto 32) <= "100";    
            -- UCP[2:0]  	Unit Cell CTIA Bias Ajust : "111" 
            --new_roic_cfg(31 downto 29) <= "111";
            -- CMP[1:0] 	Column, Mux Buffer Bias Ajust  : "11"
            new_roic_cfg(28 downto 27) <= "11";
            -- ODP[1:0] 	Output Driver Bias Ajust: "11" 
            new_roic_cfg(26 downto 25) <= "11";
            -- Integration Capacitor (GC) // choix de Cint '0' pour Cint= 10 fF
            --new_roic_cfg(24)<= USER_CFG.GAIN; 		
            --new_roic_cfg(23 downto 22) <= "00";--BW;  	
            --new_roic_cfg(21 downto 18) <= "1110";  
            -- UCRF[1:0]  Unit Cell Clock rise/Fall Time Ajust: "11"
            -- RSTR[1:0] Unit Cell Reset Clock rise/Fall Time Ajust : "10"
         end if;    
         
         new_roic_cfg(17 downto 16) <= '1' & USER_CFG.INTERNAL_OUTR; -- REF
         -- NDRO  Selects Non-Destructive Readout Operation :'0'
         -- IMRO  Selects Non-Destructive Readout Operation :'0'
         new_roic_cfg(15 downto 14) <= "00"; 
         --skimming_enable;
         new_roic_cfg(13) <= '0';
         -- ZDT_MODE  
         new_roic_cfg(12) <= '1';
         -- readout dir (inverted), non supporté en ZDT 
         new_roic_cfg(11) <= '0';
         --readout dir ( reverted), non supporté en ZDT
         new_roic_cfg(10) <= '0'; 
         -- "00" mode normal ,  "01" 2x2 on-chip binning 
         new_roic_cfg(9 downto 8) <= "00";	        
         --Test Row 
         new_roic_cfg(7)<= '0';  
         -- VET[4:0] 	Factory Test  : "00000"
         -- SPARE   		Not used : '0'
         -- MRST         Global Synchronous Reset : '0'
         new_roic_cfg(6 downto 0) <= (others =>'0');     
         
         -- detection du changement
         for ii in 0 to C_FPA_BITSTREAM_BYTE_NUM_M1 loop
            roic_cfg_changed(ii) <= '0';
            if actual_roic_cfg(8*ii + 7 downto 8*ii) /= new_roic_cfg(8*ii + 7 downto 8*ii) then
               roic_cfg_changed(ii) <= '1';
            end if;
         end loop;
         
         -- new_roic_cfg_pending 
         new_roic_cfg_pending <= '0';
         if roic_cfg_changed /= x"00" then 
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
         if actual_aoi_cfg.sol_posl_pclk /= new_aoi_cfg.sol_posl_pclk then
            aoi_cfg_changed(0) <= '1';
         else
            aoi_cfg_changed(0) <= '0';
         end if;
         if actual_aoi_cfg.eol_posl_pclk /= new_aoi_cfg.eol_posl_pclk then
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
         if actual_cfg_num /= new_cfg_num then
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
            
            case  reset_fsm is         
               
               when assert_rst_st => 
                  roic_reset_n <= '0';    -- le reset du ROIC est actif bas durant au moins 7 mclk apres sortie du reset;  
                  if mclk_cnt(3) = '1' then
                     reset_fsm <= desassert_rst_st; 
                  end if; 
               
               when desassert_rst_st =>
                  roic_reset_n <= '1';
                  if mclk_cnt(7) = '1' then  -- un seul bit suffit pour le delai 
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
            actual_roic_cfg(57) <= '0';   -- le bit 57 seul forcé à '0'  suffit pour eviter des bugs en power management. En fait cela force la reprogrammation après un reset
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
                  pause_cnt <= (others => '0');
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
                  actual_roic_cfg <= spi_data_i;
                  cfg_fsm <= update_aoi_st;
               
               when update_aoi_st =>
                  actual_aoi_cfg <= new_aoi_cfg;
                  cfg_fsm <= update_cfg_num_st;
               
               when update_cfg_num_st =>
                  actual_cfg_num <= new_cfg_num;
                  cfg_fsm <= pause_st;
               
               when  pause_st =>
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt = 7 then   --  largenment le temps pour que new_roic_cfg_pending retombe avant d'aller à idle
                     cfg_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
end rtl;
