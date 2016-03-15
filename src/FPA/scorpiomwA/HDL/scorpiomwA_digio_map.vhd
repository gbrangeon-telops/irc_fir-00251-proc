------------------------------------------------------------------
--!   @file : scorpiomwA_digio_map
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

entity scorpiomwA_digio_map is
   port(
      
      MCLK_SOURCE    : in std_logic;
      ARESET         : in std_logic;      
                     
      FPA_INT        : in std_logic;
      FPA_MCLK       : in std_logic;
                     
      PROG_CSN       : in std_logic;  
      PROG_SD        : in std_logic;
                     
      DAC_CSN        : in std_logic;  
      DAC_SCLK       : in std_logic;
      DAC_SD         : in std_logic;
                     
      SIZEA_SIZEB    : in std_logic;
      UPROW_UPCOL    : in std_logic;
      ITR            : in std_logic;
                     
      FPA_PWR        : in std_logic;      
      FPA_POWERED    : out std_logic;      
      DAC_POWERED    : out std_logic;                     
                     
      FPA_ERROR      : out std_logic;
      FPA_DATA_VALID : out std_logic;                     
                     
      FPA_ON         : out std_logic;
      FPA_DIGIO1     : out std_logic;
      FPA_DIGIO2     : out std_logic;
      FPA_DIGIO3     : out std_logic;
      FPA_DIGIO4     : out std_logic;
      FPA_DIGIO5     : out std_logic;
      FPA_DIGIO6     : out std_logic;
      FPA_DIGIO7     : out std_logic;
      FPA_DIGIO8     : out std_logic;
      FPA_DIGIO9     : out std_logic;
      FPA_DIGIO10    : out std_logic;
      FPA_DIGIO11    : in std_logic;
      FPA_DIGIO12    : in std_logic
      );
end scorpiomwA_digio_map;


architecture rtl of scorpiomwA_digio_map is
   
   constant C_FPA_MCLK_RATE_FACTOR_M1 : integer := DEFINE_FPA_MCLK_RATE_FACTOR - 1;
   
   component sync_reset
      port(
         ARESET : in STD_LOGIC;
         SRESET : out STD_LOGIC;
         CLK    : in STD_LOGIC);
   end component;
   
   type fpa_digio_fsm_type   is (idle, ldo_pwr_pause_st, rst_cnt_st, fpa_pwr_pause_st, check_mclk_st, fpa_pwred_st); 
   type dac_digio_fsm_type   is (dac_pwr_pause_st, dac_pwred_st); 
   type serclr_fsm_type is (idle, wait_spi_csn_st, signal_length_st); 
   signal fpa_digio_fsm    : fpa_digio_fsm_type;
   signal dac_digio_fsm    : dac_digio_fsm_type;
   signal serclr_fsm       : serclr_fsm_type;
   signal sreset           : std_logic;
   signal dac_timer_cnt    : natural;
   signal fpa_timer_cnt    : natural;
   signal fpa_powered_i    : std_logic;
   signal dac_powered_i    : std_logic;
   
   signal fpa_on_i         : std_logic;
   signal prog_data_i      : std_logic;
   signal sizea_sizeb_i    : std_logic;
   signal int_i            : std_logic;
   signal mclk_i           : std_logic;
   signal dac_csn_i        : std_logic;
   signal dac_sd_i         : std_logic;
   signal dac_sclk_i       : std_logic;
   signal error_i          : std_logic;
   signal data_valid_i     : std_logic;
   signal serclr_i         : std_logic;
   signal uprow_upcol_i    : std_logic;
   
   signal fpa_on_iob       : std_logic;
   signal prog_data_iob    : std_logic;
   signal sizea_sizeb_iob  : std_logic;
   signal int_iob          : std_logic;
   signal mclk_iob         : std_logic;
   signal dac_csn_iob      : std_logic;
   signal dac_sd_iob       : std_logic;
   signal dac_sclk_iob     : std_logic;
   signal itr_iob          : std_logic;
   signal serclr_iob       : std_logic;
   signal uprow_upcol_iob  : std_logic;
   signal error_iob        : std_logic;
   signal data_valid_iob   : std_logic;
   signal itr_i            : std_logic;
   signal prog_csn_last    : std_logic;
   
   signal fsm_sreset       : std_logic;
   signal cnter            : integer range 0 to DEFINE_FPA_MCLK_RATE_FACTOR;
   
   signal prog_mclk_i      : std_logic;
   signal prog_mclk_pipe   : std_logic_vector(7 downto 0);
   
   attribute IOB : string;
   attribute IOB of fpa_on_iob         : signal is "TRUE";
   attribute IOB of prog_data_iob      : signal is "TRUE";
   attribute IOB of sizea_sizeb_iob    : signal is "TRUE";
   attribute IOB of int_iob            : signal is "TRUE";
   attribute IOB of itr_iob            : signal is "TRUE";
   attribute IOB of mclk_iob           : signal is "TRUE";
   attribute IOB of dac_csn_iob        : signal is "TRUE";
   attribute IOB of dac_sd_iob         : signal is "TRUE";
   attribute IOB of dac_sclk_iob       : signal is "TRUE";
   attribute IOB of serclr_iob         : signal is "TRUE";
   
   
begin
   
   --------------------------------------------------------
   -- maps
   --------------------------------------------------------   
   FPA_POWERED <= fpa_powered_i;
   DAC_POWERED <= dac_powered_i;
   
   FPA_ON      <= fpa_on_iob;
   
   -- fpa_digio
   FPA_DIGIO1  <= itr_iob;
   FPA_DIGIO2  <= uprow_upcol_iob; 
   FPA_DIGIO3  <= prog_data_iob;
   FPA_DIGIO4  <= serclr_iob; 
   FPA_DIGIO5  <= sizea_sizeb_iob;            
   FPA_DIGIO6  <= int_iob;   
   FPA_DIGIO7  <= mclk_iob;
   
   FPA_ERROR <= error_i;
   FPA_DATA_VALID <= data_valid_i;
   
   -- dac_digio
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
         serclr_iob <= serclr_i;
         prog_data_iob <= prog_data_i;           
         sizea_sizeb_iob <= sizea_sizeb_i;   
         int_iob <= int_i;
         mclk_iob <= mclk_i;
         itr_iob <= itr_i;
         uprow_upcol_iob <= uprow_upcol_i;
         
         -- contrôle DAC
         dac_csn_iob <= dac_csn_i;
         dac_sd_iob <= dac_sd_i;
         dac_sclk_iob <= dac_sclk_i;
         
         -- en provenance du détecteur
         error_iob <= FPA_DIGIO12;
         data_valid_iob <= FPA_DIGIO11;
      end if;   
   end process;  
   
   
   --------------------------------------------------------- 
   -- fsm de generation de serclr_i                               
   ---------------------------------------------------------
   U12A: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            serclr_fsm <= idle; 
            prog_csn_last <= '1';
            serclr_i <= '0';
            
         else
            
            prog_csn_last <= PROG_CSN;             
            
            case serclr_fsm is          
               
               -- idle
               when idle =>
                  serclr_i <= '0';
                  cnter <= 1;
                  if fpa_powered_i = '1' then 
                     serclr_fsm <= wait_spi_csn_st;
                  end if;
                  
               -- detecter la tombée de PROG_CSN et lancer la generation de serclr_i
               when wait_spi_csn_st =>
                  if PROG_CSN = '0' and prog_csn_last = '1' then 
                     serclr_i <= '1'; 
                     serclr_fsm <= signal_length_st;
                  end if; 
               
               when signal_length_st =>
                  cnter <=  cnter + 1;
                  if cnter = C_FPA_MCLK_RATE_FACTOR_M1 then
                     serclr_fsm <= idle; 
                  end if;
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process; 
   
   --------------------------------------------------------- 
   -- fsm fpa digio                                 
   ---------------------------------------------------------
   U12B: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            fpa_digio_fsm <= idle; 
            fpa_timer_cnt <= 0;
            fpa_powered_i <= '0';
            prog_data_i <= '0';
            sizea_sizeb_i <= '1';
            int_i <= '0';
            prog_data_i <= '0';
            mclk_i <= '0';
            error_i <= '0';
            data_valid_i <= '0';
            
         else
            
            case fpa_digio_fsm is          
               
               -- idle
               when idle =>
                  if dac_powered_i = '1' then 
                     fpa_digio_fsm <= ldo_pwr_pause_st;
                  end if;
                  
               -- delai du monostable sur le fleg
               when ldo_pwr_pause_st =>
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt = DEFINE_FLEG_LDO_DLY_FACTOR then  -- delai implanté via U14 (LTC6994IS6-1#TRMPBF) du fleG
                     fpa_digio_fsm <= rst_cnt_st;
                  end if; 
                  -- pragma translate_off
                  if fpa_timer_cnt = 10 then  -- delai implanté via U14 (LTC6994IS6-1#TRMPBF) du fleG
                     fpa_digio_fsm <= rst_cnt_st;
                  end if;                
                  -- pragma translate_on
               
               when rst_cnt_st =>
                  fpa_timer_cnt <= 0;
                  fpa_digio_fsm <= fpa_pwr_pause_st;
                  
               -- regarder si fin de la pause  
               when fpa_pwr_pause_st =>
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt > DEFINE_FPA_POWER_WAIT_FACTOR then
                     fpa_digio_fsm <= check_mclk_st;
                  end if;
                  -- pragma translate_off
                  if fpa_timer_cnt = 380000 then  -- delai implanté via U14 (LTC6994IS6-1#TRMPBF) du fleG
                     fpa_digio_fsm <= check_mclk_st;
                  end if;                
                  -- pragma translate_on
               
               when check_mclk_st =>
                  if FPA_MCLK = '0' and FPA_INT = '0' then  -- pour eviter troncature sur ces signaux
                     fpa_digio_fsm <= fpa_pwred_st;
                  end if;                   
               
               when fpa_pwred_st =>           -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  fpa_powered_i <= '1';
                  prog_data_i <= PROG_SD;
                  sizea_sizeb_i <= SIZEA_SIZEB;
                  int_i <= FPA_INT;            
                  mclk_i <= FPA_MCLK;  --
                  itr_i <= ITR;
                  uprow_upcol_i <= UPROW_UPCOL;
                  error_i <= error_iob;
                  data_valid_i <= data_valid_iob;
                  
                  -- pragma translate_off
                  int_i <= PROG_CSN;              
                  -- pragma translate_on              
               
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
   
end rtl;
