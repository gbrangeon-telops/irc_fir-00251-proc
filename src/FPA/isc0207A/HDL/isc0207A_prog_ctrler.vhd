------------------------------------------------------------------
--!   @file : isc0207A_prog_ctrler
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
use work.fpa_define.all;
use work.tel2000.all;


entity isc0207A_prog_ctrler is
   port(
      ARESET               : in std_logic;
      MCLK_SOURCE          : in std_logic;
      
      FPA_INTF_CFG         : in fpa_intf_cfg_type;  -- la cfg valide envoyée par l'usager est ici
      --FPA_INTF_CFG_IN_PROGRESS : in std_logic;          -- à '1' lorsque FPA_INTF_CFG est en cours d'envoi
      
      ACQ_TRIG             : in std_logic;
      PERMIT_INT_CHANGE    : in std_logic;
      
      READOUT              : in std_logic;
      
      FPA_POWER            : in std_logic;          -- recpetion ordre d'allumage du FPA
      FPA_DRIVER_EN        : in std_logic;
      DIAG_MODE_ONLY       : in std_logic;
      
      FPA_MCLK             : in std_logic;
      
      FPA_POWERED          : in std_logic;          -- à '1' ssi le FPA est allumé et prêt à recevoir des commandes
      
      SPI_DATA             : out std_logic_vector(63 downto 0);
      SPI_EN               : out std_logic;
      SPI_DONE             : in std_logic;
      ROIC_RESET_B         : out std_logic;
      
      FPA_PWR              : out std_logic;         -- envoi de l'ordre d'allumage du FPA
      PROG_TRIG            : out std_logic;         -- pour la prise d'images post_programmation
      FPA_DRIVER_STAT      : out std_logic_vector(15 downto 0)    
      
      );                 
end isc0207A_prog_ctrler;

architecture rtl of isc0207A_prog_ctrler is
   
   constant C_FPA_BITSTREAM_BYTE_NUM_M1 : natural := DEFINE_FPA_BITSTREAM_BYTE_NUM - 1;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   type driver_seq_fsm_type  is (idle, wait_fpa_power_st, assert_rst_st, desassert_rst_st, check_assert_end_st, check_desassert_end_st, fpa_prog_rqst_st, fpa_prog_en_st,
   wait_fpa_prog_end_st, wait_fpa_prog_start_st, cfg_latch_st, post_prog_img_start_st, post_prog_img_end_st, check_post_prog_mode_end_st, wait_updater_rdy_st, wait_updater_run_st, wait_updater_end_st);
   type new_cfg_pending_fsm_type is(idle, count_inc_st, count_limit_st, check_new_cfg_st, new_cfg_pending_st, launch_prog_st, wait_prog_end_st, update_fpa_word_st);
   
   type byte_array_type is array (0 to C_FPA_BITSTREAM_BYTE_NUM_M1) of std_logic_vector(7 downto 0); 
   
   signal driver_seq_fsm            : driver_seq_fsm_type;
   signal new_cfg_pending_fsm       : new_cfg_pending_fsm_type;
   
   signal fpa_powered_i             : std_logic;
   signal fpa_driver_seq_err        : std_logic;
   signal fpa_cfg_err               : std_logic;
   signal fpa_driver_rqst           : std_logic;
   signal fpa_driver_done           : std_logic;
   signal sreset                    : std_logic;
   signal fpa_new_cfg_pending       : std_logic;
   --signal fpa_intf_cfg_in_progress_i    : std_logic;
   signal fpa_new_cfg_word          : std_logic_vector(DEFINE_FPA_BITSTREAM_BYTE_NUM*8 - 1 downto 0)    := (others => '0');
   signal fpa_actual_cfg_word       : std_logic_vector(fpa_new_cfg_word'length-1 downto 0) := (others => '0');
   signal fpa_new_cfg_word_latch    : std_logic_vector(fpa_new_cfg_word'length-1 downto 0);
   signal spi_en_i                  : std_logic;
   signal ram_err                   : std_logic := '0';
   signal fpa_driver_trig_err       : std_logic;
   signal byte_cnt                  : natural range 0 to DEFINE_FPA_BITSTREAM_BYTE_NUM;
   signal roic_reset_n              : std_logic;
   signal mclk_cnt                  : unsigned(3 downto 0);
   signal mclk_falling_edge         : std_logic;
   signal fpa_mclk_last             : std_logic;
   signal img_cnt                   : natural range 0 to DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP;
   signal spi_done_i                : std_logic;
   signal readout_i                 : std_logic;
   signal prog_trig_i               : std_logic;
   signal fpa_new_cfg_byte          : byte_array_type;
   signal fpa_actual_cfg_byte       : byte_array_type;
   
   --attribute TIG: string; 
   --attribute TIG of fpa_new_cfg_word_latch   : signal is "yes";
   --attribute TIG of fpa_actual_cfg_word      : signal is "yes";
   
   
begin    
   
   -------------------------------------------------
   -- mappings                                                   
   -------------------------------------------------
   SPI_EN <= spi_en_i;
   SPI_DATA <= fpa_new_cfg_word_latch(SPI_DATA'LENGTH-1 downto 0);
   ROIC_RESET_B <=  roic_reset_n;
   PROG_TRIG <= prog_trig_i;
   
   --FPA_INTF_CFG_PRELIM <= fpa_intf_cfg_prelim_i;   -- sortie de la fpa_intf_cfg.  Elle passera dans le module de generation du temps d'exprotion pour etre complete  
   FPA_DRIVER_STAT(7)  <= PERMIT_INT_CHANGE;         --  on permet les changements de tems p'integration si ce signal est high
   FPA_DRIVER_STAT(6)  <= fpa_driver_trig_err; 
   FPA_DRIVER_STAT(5)  <= ram_err;                  -- erreur de colision dans la ram (s/o pour le 0207)
   FPA_DRIVER_STAT(4)  <= fpa_powered_i; 
   FPA_DRIVER_STAT(3)  <= fpa_driver_seq_err;       -- 
   FPA_DRIVER_STAT(2)  <= fpa_cfg_err;              -- fpa_cfg_err toute erreur de programmation retournée par le détecteur
   FPA_DRIVER_STAT(1)  <= fpa_driver_rqst;          --
   FPA_DRIVER_STAT(0)  <= fpa_driver_done;          --
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => MCLK_SOURCE,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   --  Allumage du Proxy 
   --------------------------------------------------
   -- doit être dans un process indépendant 
   U2 : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then 
         FPA_PWR <= FPA_POWER and not sreset; 
         fpa_powered_i <= FPA_POWERED and not sreset;                 
      end if;
   end process;
   
   --------------------------------------------------
   --  bistream builder
   --------------------------------------------------
   --bit stream champion donnat la plus grande vitesse possible
   -- Start bit always = 1
   fpa_new_cfg_word(57)<= '1';	
   -- Value / 32 =(WAX)
   fpa_new_cfg_word(56 downto 53) <= std_logic_vector(FPA_INTF_CFG.XSTART(8 downto 5));
   -- Value / 2 =(WAY)
   fpa_new_cfg_word(52 downto 46) <= std_logic_vector(FPA_INTF_CFG.YSTART(7 downto 1));
   -- Value / 32 =(WSX)
   fpa_new_cfg_word(45 downto 42) <= std_logic_vector(FPA_INTF_CFG.XSIZE(8 downto 5));
   -- (Value / 2) - 1 =(WSY)
   fpa_new_cfg_word(41 downto 35) <= std_logic_vector(FPA_INTF_CFG.YSIZE_DIV2_M1(6 downto 0)); 
   -- IM[2:0] 		Master Bias Current Ajust  : "001" 
   fpa_new_cfg_word(34 downto 32) <= "001";    
   -- UCP[2:0]  	Unit Cell CTIA Bias Ajust : "111" 
   fpa_new_cfg_word(31 downto 29) <= "111";
   -- CMP[1:0] 	Column, Mux Buffer Bias Ajust  : "10"
   fpa_new_cfg_word(28 downto 27) <= "10";
   -- ODP[1:0] 	Output Driver Bias Ajust: "10" 
   fpa_new_cfg_word(26 downto 25) <= "10";
   -- Integration Capacitor (GC) // choix de Cint '0' pour Cint= 10 fF
   fpa_new_cfg_word(24)<= FPA_INTF_CFG.GAIN; 		
   fpa_new_cfg_word(23 downto 22) <= "00";--BW;  	
   fpa_new_cfg_word(21 downto 18) <= "0100";  
   -- UCRF[1:0]  Unit Cell Clock rise/Fall Time Ajust: "01"
   -- RSTR[1:0] Unit Cell Reset Clock rise/Fall Time Ajust : "00"
   fpa_new_cfg_word(17 downto 16) <= "10"; -- REF
   -- NDRO  Selects Non-Destructive Readout Operation :'0'
   -- IMRO  Selects Non-Destructive Readout Operation :'0'
   fpa_new_cfg_word(15 downto 14) <= "00"; 
   --skimming_enable;
   fpa_new_cfg_word(13) <= '0';
   -- ZDT_MODE  
   fpa_new_cfg_word(12) <= '1';
   -- readout dir (inverted), non supporté en ZDT 
   fpa_new_cfg_word(11) <= '0';
   --readout dir ( reverted), non supporté en ZDT
   fpa_new_cfg_word(10) <= '0'; 
   -- "00" mode normal ,  "01" 2x2 on-chip binning 
   fpa_new_cfg_word(9 downto 8) <= '0' & (FPA_INTF_CFG.ONCHIP_BIN_256 or FPA_INTF_CFG.ONCHIP_BIN_128);	        
   --Test Row 
   fpa_new_cfg_word(7)<= '0';  
   -- VET[4:0] 	Factory Test  : "00000"
   -- SPARE   		Not used : '0'
   -- MRST         Global Synchronous Reset : '0'
   fpa_new_cfg_word(6 downto 0) <= (others =>'0');  
   
   ------------------------------------------------
   -- determination des bytes
   ------------------------------------------------
   Ub : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then 
         for ii in 0 to C_FPA_BITSTREAM_BYTE_NUM_M1 loop 
            fpa_new_cfg_byte(ii) <= fpa_new_cfg_word(8*ii + 7 downto 8*ii);
            fpa_actual_cfg_byte(ii) <= fpa_actual_cfg_word(8*ii + 7 downto 8*ii);
         end loop;
      end if;
   end process;
   
   
   ------------------------------------------------
   -- Voir s'il faut programmer le détecteur
   ------------------------------------------------
   U3 : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then 
         if sreset = '1' then
            fpa_new_cfg_pending <= '0';
            new_cfg_pending_fsm <= idle;
            fpa_actual_cfg_word(57) <= '0';   -- le bit 57 seul forcé à '0'  suffit pour eviter des bugs en power management. En fait cela force la reprogrammation après un reset
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings	
            case new_cfg_pending_fsm is            
               
               when idle =>                -- en attente que le programmateur soit à l'écoute
                  fpa_new_cfg_pending <= '0';
                  if fpa_driver_done = '1' then
                     new_cfg_pending_fsm <= count_inc_st; 
                  end if;
               
               when count_inc_st =>        -- ce compteur permet de balayer lentement le mot de configuraion du detecteur 
                  byte_cnt <= byte_cnt + 1;
                  new_cfg_pending_fsm <= count_limit_st;
               
               when count_limit_st =>      -- RAZ 
                  if byte_cnt > C_FPA_BITSTREAM_BYTE_NUM_M1 then
                     byte_cnt <= 0;
                  end if;
                  new_cfg_pending_fsm <= check_new_cfg_st;
               
               when check_new_cfg_st =>  -- on balaie par mot de 8 bits les registres à la recherche de différence entre la config déjà présente dans le détecteur et celle entrante.
                  if fpa_new_cfg_byte(byte_cnt) /= fpa_actual_cfg_byte(byte_cnt) then
                     new_cfg_pending_fsm <= new_cfg_pending_st;					 
                  else
                     new_cfg_pending_fsm <= count_inc_st;
                  end if;
               
               when new_cfg_pending_st =>                                     
                  new_cfg_pending_fsm <= launch_prog_st;
               
               when launch_prog_st =>
                  fpa_new_cfg_pending <= '1';  
                  if fpa_driver_done = '0' then
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when wait_prog_end_st =>
                  fpa_new_cfg_pending <= '0';
                  if fpa_driver_done = '1' then
                     new_cfg_pending_fsm <= update_fpa_word_st;
                  end if;  
               
               when update_fpa_word_st =>
                  fpa_actual_cfg_word(fpa_new_cfg_word_latch'length-1 downto 0) <= fpa_new_cfg_word_latch;
                  new_cfg_pending_fsm <= idle;
                  
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   -----------------------------------------------------------------
   --  Séquençage des operations de programmation du détecteur 
   ----------------------------------------------------------------   
   U4 : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then 
         if sreset = '1' then 
            driver_seq_fsm <=  wait_fpa_power_st;
            fpa_driver_done <= '0';
            fpa_driver_rqst <= '0';
            spi_en_i <= '0';
            fpa_cfg_err <= '0';
            fpa_driver_seq_err <= '0';
            prog_trig_i <= '0';
            fpa_driver_trig_err <= '0';
            
         else                       
            
            fpa_driver_trig_err <=  not fpa_driver_done and ACQ_TRIG; -- erreur grave. ACQ_TRIG pendant une programmation du detecteur. Ne doit jamais arriver
            fpa_mclk_last <= FPA_MCLK;
            mclk_falling_edge <= fpa_mclk_last and not FPA_MCLK;
            spi_done_i <= SPI_DONE;
            readout_i <=  READOUT;
            
            --fsm de contrôle de la partie de config demandant la reprogrammarion du fpa  
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings			
            case  driver_seq_fsm is 
               
               -- gestion du RESET_B du ISC0207 ----------------
               when wait_fpa_power_st =>  
                  roic_reset_n <= '1';
                  mclk_cnt <= (others => '0');
                  fpa_driver_trig_err <= '0';
                  if fpa_powered_i = '1' then
                     driver_seq_fsm <= assert_rst_st; 
                  end if;                 
               
               when assert_rst_st => 
                  roic_reset_n <= '0';    -- le reset du ROIC est actif bas durant au moins 5 mclk;  
                  if mclk_falling_edge = '1' then
                     mclk_cnt <=  mclk_cnt + 1;
                     driver_seq_fsm <= check_assert_end_st; 
                  end if;
               
               when check_assert_end_st =>
                  if mclk_cnt = 7 then
                     driver_seq_fsm <= desassert_rst_st; 
                  else
                     driver_seq_fsm <= assert_rst_st; 
                  end if;
               
               when desassert_rst_st =>
                  roic_reset_n <= '1';  
                  if mclk_falling_edge = '1' then
                     mclk_cnt <=  mclk_cnt - 1;    -- en arrivant dans cet etat, le compteur vaut 7
                     driver_seq_fsm <= check_desassert_end_st; 
                  end if; 
               
               when check_desassert_end_st =>
                  if mclk_cnt = 0 then
                     driver_seq_fsm <= idle; 
                  else
                     driver_seq_fsm <= desassert_rst_st; 
                  end if;
                  
               -- idle --------------------------------------------
               when idle =>
                  img_cnt <= 0;
                  fpa_driver_done <= '1'; 
                  fpa_driver_rqst <= '0';
                  prog_trig_i <= '0';
                  if fpa_new_cfg_pending = '1' then --
                     driver_seq_fsm <= fpa_prog_rqst_st;
                  end if;
               
               when fpa_prog_rqst_st =>                  -- demande pour programmer le fpa
                  fpa_driver_rqst <= '1'; 
                  if FPA_DRIVER_EN = '1' then
                     driver_seq_fsm <= cfg_latch_st;                     
                  end if;                  
               
               when cfg_latch_st =>                      -- ordre de programmation du fpa       
                  fpa_driver_done <= '0';             
                  fpa_driver_rqst <= '0';
                  fpa_new_cfg_word_latch <= fpa_new_cfg_word;           
                  driver_seq_fsm <= wait_fpa_prog_start_st;                        
               
               when wait_fpa_prog_start_st =>                   -- ordre de programmation du fpa  
                  spi_en_i <= '1';     
                  if spi_done_i = '0' then 
                     driver_seq_fsm <= wait_fpa_prog_end_st;                        
                  end if;
               
               when wait_fpa_prog_end_st =>               -- attente de la fin de la programmation      
                  spi_en_i <= '0';
                  if spi_done_i = '1' then 
                     driver_seq_fsm <= post_prog_img_start_st;
                  end if;
               
               when post_prog_img_start_st =>              -- prise des images post programmation piour s'assurer que la config est bien exécutée
                  prog_trig_i <= '1';
                  if readout_i = '1' then
                     driver_seq_fsm <= post_prog_img_end_st;
                     prog_trig_i <= '0';                   
                  end if;                  
               
               when post_prog_img_end_st =>
                  if readout_i = '0' then
                     img_cnt <= img_cnt + 1;
                     driver_seq_fsm <= check_post_prog_mode_end_st;
                  end if;
               
               when check_post_prog_mode_end_st =>                  
                  if img_cnt = DEFINE_FPA_XTRA_IMAGE_NUM_TO_SKIP then 
                     driver_seq_fsm <= idle;
                  else
                     driver_seq_fsm <= post_prog_img_start_st;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
end rtl;
