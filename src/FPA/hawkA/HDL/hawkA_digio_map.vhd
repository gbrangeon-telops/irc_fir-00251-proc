------------------------------------------------------------------
--!   @file : hawkA_digio_map
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
use IEEE.STD_LOGIC_1164.all;           
use IEEE.numeric_std.ALL;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.fleg_brd_define.all;

entity hawkA_digio_map is
   port(
      
      MCLK_SOURCE   : in std_logic;
      ARESET        : in std_logic;      
      
      PROG_EN       : in std_logic;    
      FPA_INT       : in std_logic;
      READOUT_INFO  : in readout_info_type;
      
      FPA_INTF_CFG  : in fpa_intf_cfg_type;
      
      PROG_CSN      : in std_logic;  
      PROG_MCLK     : in std_logic;
      PROG_SD       : in std_logic;
      
      DAC_CSN       : in std_logic;  
      DAC_SCLK      : in std_logic;
      DAC_SD        : in std_logic;
      
      FPA_FDEM      : in std_logic;
      FPA_RD_MCLK   : in  std_logic;
      
      FPA_PWR       : in std_logic;      
      FPA_POWERED   : out std_logic;      
      DAC_POWERED   : out std_logic;
      
      FPA_ON        : out std_logic;
      FPA_DIGIO1    : out std_logic;
      FPA_DIGIO2    : out std_logic;
      FPA_DIGIO3    : out std_logic;
      FPA_DIGIO4    : out std_logic;
      FPA_DIGIO5    : out std_logic;
      FPA_DIGIO6    : out std_logic;
      FPA_DIGIO7    : out std_logic;
      FPA_DIGIO8    : out std_logic;
      FPA_DIGIO9    : out std_logic;
      FPA_DIGIO10   : out std_logic;
      FPA_DIGIO11   : in std_logic;
      FPA_DIGIO12   : in std_logic;
      
      
      DCR_OUT       : out std_logic_vector(7 downto 0);
      MCR_OUT       : out std_logic_vector(7 downto 0); 
      DDR_OUT       : out std_logic_vector(15 downto 0); 
      BIT_OUT       : out std_logic_vector(15 downto 0) 
      );
end hawkA_digio_map;


architecture rtl of hawkA_digio_map is
   
   component sync_reset
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC;
         CLK    : in STD_LOGIC);
   end component;
   
   type fpa_digio_fsm_type   is (idle, ldo_pwr_pause_st, rst_cnt_st, fpa_pwr_pause_st, wait_trig_stop_st, passthru_st, fpa_pwred_st); 
   type dac_digio_fsm_type   is (dac_pwr_pause_st, dac_pwred_st); 
   signal fpa_digio_fsm    : fpa_digio_fsm_type;
   signal dac_digio_fsm    : dac_digio_fsm_type;
   signal sreset           : std_logic;
   signal dac_timer_cnt    : natural;
   signal fpa_timer_cnt    : natural;
   signal fpa_powered_i    : std_logic;
   signal dac_powered_i    : std_logic;
   
   signal fpa_on_i         : std_logic;
   signal ncs_i            : std_logic;
   signal mdin_i           : std_logic;
   signal fdem_i           : std_logic;
   signal digen_i          : std_logic;
   signal mclk_i           : std_logic;
   signal dac_csn_i        : std_logic;
   signal dac_sd_i         : std_logic;
   signal dac_sclk_i       : std_logic;
   
   signal fpa_on_iob       : std_logic;
   signal ncs_iob          : std_logic;
   signal mdin_iob         : std_logic;
   signal fdem_iob         : std_logic;
   signal digen_iob        : std_logic;
   signal mclk_iob         : std_logic;
   signal dac_csn_iob      : std_logic;
   signal dac_sd_iob       : std_logic;
   signal dac_sclk_iob     : std_logic;
   signal fsm_sreset       : std_logic;
   signal fpa_rd_mclk_i    : std_logic;
   
   signal prog_mclk_i      : std_logic;
   signal prog_mclk_pipe   : std_logic_vector(7 downto 0);
   
   signal sync_iob         : std_logic;
   signal mclk_last        : std_logic;
   signal bit_cnt          : unsigned(5 downto 0);
   signal cbit_in_progress : std_logic;
   signal cbit_rdy_last    : std_logic;
   signal rst_line_pipe    : std_logic_vector(63 downto 0);
   signal fpa_reg_out      : std_logic_vector(1 to 48);
   
   attribute IOB : string;
   -- attribute dont_touch : string;
   
   attribute IOB of fpa_on_iob   : signal is "TRUE";
   attribute IOB of ncs_iob      : signal is "TRUE";
   attribute IOB of mdin_iob     : signal is "TRUE";
   attribute IOB of fdem_iob     : signal is "TRUE";
   attribute IOB of digen_iob    : signal is "TRUE";
   attribute IOB of mclk_iob     : signal is "TRUE";
   attribute IOB of dac_csn_iob  : signal is "TRUE";
   attribute IOB of dac_sd_iob   : signal is "TRUE";
   attribute IOB of dac_sclk_iob : signal is "TRUE";
   attribute IOB of sync_iob     : signal is "TRUE";
   
   -- attribute dont_touch of fpa_timer_cnt : signal is "TRUE";
   -- attribute dont_touch of dac_timer_cnt : signal is "TRUE"; 
   -- attribute dont_touch of fpa_powered_i : signal is "TRUE";
   -- attribute dont_touch of dac_powered_i : signal is "TRUE";
   -- attribute dont_touch of fpa_on_i      : signal is "TRUE";
   -- attribute dont_touch of ncs_i         : signal is "TRUE";
   -- attribute dont_touch of mdin_i        : signal is "TRUE";
   -- attribute dont_touch of fdem_i        : signal is "TRUE";
   -- attribute dont_touch of digen_i       : signal is "TRUE";
   -- attribute dont_touch of mclk_i        : signal is "TRUE";
   -- attribute dont_touch of dac_csn_i     : signal is "TRUE";
   -- attribute dont_touch of dac_sd_i      : signal is "TRUE";
   -- attribute dont_touch of dac_sclk_i    : signal is "TRUE";
   -- attribute dont_touch of fsm_sreset    : signal is "TRUE";
   
begin
   
   --------------------------------------------------------
   -- maps
   --------------------------------------------------------   
   FPA_POWERED <= fpa_powered_i;
   DAC_POWERED <= dac_powered_i;
   
   FPA_ON      <= fpa_on_iob;
   FPA_DIGIO1  <= '0';
   FPA_DIGIO2  <= ncs_iob; 
   FPA_DIGIO3  <= mdin_iob;
   FPA_DIGIO4  <= fdem_iob; 
   FPA_DIGIO5  <= '0';            
   FPA_DIGIO6  <= digen_iob;   
   FPA_DIGIO7  <= mclk_iob;    
   FPA_DIGIO8  <= dac_sclk_iob;
   FPA_DIGIO9  <= dac_sd_iob; 
   FPA_DIGIO10 <= dac_csn_iob;  
   
   --------------------------------------------------------
   -- Sync reset
   -------------------------------------------------------- 
   U0 : sync_reset
   port map(ARESET => ARESET, CLK => MCLK_SOURCE, SRESET => sreset); 
   
   
   --------------------------------------------------------- 
   -- gestion de l'allumage du proxy (process indépendant)
   --------------------------------------------------------- 
   U1: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         fpa_on_i <= not ARESET and FPA_PWR;
         fsm_sreset <= sreset or not FPA_PWR; 
      end if;   
   end process; 
   
   
   --------------------------------------------------------- 
   -- registres dans iob
   --------------------------------------------------------- 
   UIOB: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         -- allumage tensions
         fpa_on_iob <= fpa_on_i; 
         
         -- contrôle detecteur
         ncs_iob <= ncs_i;
         mdin_iob <= mdin_i;           
         fdem_iob <= fdem_i;   
         digen_iob <= digen_i;
         mclk_iob <= mclk_i;  
         
         -- contrôle DAC
         dac_csn_iob <= dac_csn_i;
         dac_sd_iob <= dac_sd_i;
         dac_sclk_iob <= dac_sclk_i; 
         
         -- input SYNC
         sync_iob <= FPA_DIGIO12;
         
      end if;   
   end process;  
   
   
   --------------------------------------------------------- 
   -- fsm fpa digio                                 
   ---------------------------------------------------------
   U12: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            fpa_digio_fsm <= idle; 
            fpa_timer_cnt <= 0;
            fpa_powered_i <= '0';
            ncs_i <= '0';
            mdin_i <= '0';
            fdem_i <= '0';
            digen_i <= '0';
            prog_mclk_pipe <= (others => '0');
            prog_mclk_i <= '0';
            mclk_i <= '0';
            fpa_rd_mclk_i <= '0';
            
         else
            
            prog_mclk_pipe(0) <= PROG_MCLK and not PROG_CSN;
            prog_mclk_pipe(5 downto 1) <= prog_mclk_pipe(4 downto 0);
            prog_mclk_i <= prog_mclk_pipe(2);
            
            fpa_rd_mclk_i <=  FPA_RD_MCLK and PROG_CSN;
            
            case fpa_digio_fsm is          
               
               -- delai
               when idle =>
                  if dac_powered_i = '1' then 
                     fpa_digio_fsm <= ldo_pwr_pause_st;
                  end if;
                  
               -- delai du monostable sur le fleg
               when ldo_pwr_pause_st =>
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt = DEFINE_FLEG_LDO_DLY_FACTOR then  -- delai implanté via U14 (LTC6994IS6-1#TRMPBF) du fleG. Enq uittant cet etat, le détecteur est allumé avec les IOs dans l'état définis dans le fsm_sreset
                     fpa_digio_fsm <= rst_cnt_st;
                  end if;
                  -- pragma translate_off
                  if fpa_timer_cnt = 10 then  
                     fpa_digio_fsm <= rst_cnt_st;
                  end if;                
                  -- pragma translate_on
                  
               -- reset compteur
               when rst_cnt_st =>
                  fpa_timer_cnt <= 0;
                  fpa_digio_fsm <= fpa_pwr_pause_st;
                  
               -- observer le delai FPA_POWER_WAIT  
               when fpa_pwr_pause_st =>
                  ncs_i <= '1';                 
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt > DEFINE_FPA_POWER_WAIT_FACTOR then
                     fpa_digio_fsm <= fpa_pwred_st;
                  end if;
                  -- pragma translate_off
                  if fpa_timer_cnt = 30 then  
                     fpa_digio_fsm <= fpa_pwred_st;
                  end if;                
                  -- pragma translate_on
                  
               -- annoncer la bonne nouvelle relative à l'allumage du détecteur
               when fpa_pwred_st =>
                  fpa_powered_i <= '1';        -- permet au driver de placer une requete de programmation              
                  fpa_digio_fsm <= wait_trig_stop_st;                
                  
               -- attendre que le programmateur du FPA soit activée => trig arrêté
               when wait_trig_stop_st =>                  
                  if PROG_EN = '1'  then  -- si cela se produit, on est certain que le gestionnaire de trig est bloqué. Quitter rapidement pour ne pas manquer la communication
                     fpa_digio_fsm <= passthru_st;
                  end if;                   
                  
               -- venir ici rapidement pour ne pas manquer la communication du programmateur
               when passthru_st =>           -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  ncs_i <= PROG_CSN;
                  mdin_i <= PROG_SD;
                  fdem_i <= FPA_FDEM;
                  digen_i <= FPA_INT;
                  mclk_i <= prog_mclk_i or fpa_rd_mclk_i;  -- les deux clks sont disjoints        
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process; 
   
   
   --------------------------------------------------------- 
   -- fsm dac                                 
   ---------------------------------------------------------
   U13: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            dac_digio_fsm <= dac_pwr_pause_st;
            dac_csn_i <= '1';
            dac_sd_i <= '0';
            dac_sclk_i <= '0';
            dac_powered_i <= '0';
            dac_timer_cnt <= 0;
            
         else
            
            case dac_digio_fsm is          
               
               -- delai
               when dac_pwr_pause_st =>
                  dac_timer_cnt <= dac_timer_cnt + 1;
                  if dac_timer_cnt = DEFINE_FLEG_DAC_PWR_WAIT_FACTOR then
                     dac_digio_fsm <= dac_pwred_st;
                  end if;
                  
                  -- pragma translate_off
                  if dac_timer_cnt = 50 then 
                     dac_digio_fsm <= dac_pwred_st;
                  end if;                
                  -- pragma translate_on
                  
               -- dac rdy
               when dac_pwred_st =>           -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  dac_powered_i <= '1';
                  dac_csn_i <= DAC_CSN;
                  dac_sd_i <= DAC_SD;
                  dac_sclk_i <= DAC_SCLK;      
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process;
   
   --------------------------------------------------
   -- capture et decodage de SYNC
   -------------------------------------------------- 
   U3 : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if sreset = '1' then 
            mclk_last <= mclk_i; 
            bit_cnt <= (others => '0');
            cbit_in_progress <= '0';            
         else                                   
            
            -- pour detection front montant 
            mclk_last <= mclk_i;
            
            -- reset_line pipe
            rst_line_pipe(63 downto 0) <= rst_line_pipe(62 downto 0) & (READOUT_INFO.AOI.LVAL and not READOUT_INFO.AOI.DVAL);   -- laligne de reset est active lorsque LVAL est à '1' et que DVAL = '0' 
            
            -- registre de stockage
            if  rst_line_pipe(to_integer(FPA_INTF_CFG.CBIT_PIPE_DLY)) = '1' then  
               if  mclk_last = '1' and mclk_i = '0' and bit_cnt <= 48 then   -- les données se capturent sur le front descendant de mclk puisqu'elles sortent sur son front montant.
                  fpa_reg_out(48) <= sync_iob;
                  fpa_reg_out(1 to 47) <= fpa_reg_out(2 to 48);
                  bit_cnt <=  bit_cnt + 1;
                  cbit_in_progress <= '1';
               end if;  
            else
               bit_cnt <= (others => '0'); 
               cbit_in_progress <= '0';
            end if;     
            
            -- decodage
            if  unsigned(rst_line_pipe) = 0 then
               for ii in 0 to 7 loop                                                          
                  DCR_OUT(ii) <= fpa_reg_out(8-ii);                                                     -- DCR_OUT <= fpa_reg_out(1 to 8); 
                  MCR_OUT(ii) <= fpa_reg_out(16-ii);                                                    -- MCR_OUT <= fpa_reg_out(9 to 16);
               end loop;                                                                                 
               for ii in 0 to 15 loop                                                                                                  
                  DDR_OUT(ii) <= fpa_reg_out(32-ii);                                                   -- DDR_OUT <= fpa_reg_out(17 to 32); 
                  BIT_OUT(ii) <= fpa_reg_out(48-ii);                                                   -- BIT_OUT <= fpa_reg_out(33 to 48); 
               end loop;
            end if;
            
         end if;         
      end if;
      
      
   end process;
   
end rtl;
