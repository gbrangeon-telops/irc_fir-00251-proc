------------------------------------------------------------------
--!   @file : calcium_io_intf
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
use work.FPA_define.all;
use work.Proxy_define.all;
use work.fleg_brd_define.all;

-- synopsys translate_off 
library KINTEX7;
library IEEE;
use IEEE.vital_timing.all;
-- synopsys translate_on 

entity calcium_io_intf is
   port (
      CLK            : in std_logic;
      ARESET         : in std_logic;
      
      -- hw_driver side
      FPA_PWR        : in std_logic;
      FPA_POWERED    : out std_logic;
      DAC_POWERED    : out std_logic;
      
      DAC_CSN_I      : in std_logic;
      DAC_SCLK_I     : in std_logic;
      DAC_SD_I       : in std_logic;
      
      PROG_EN        : in std_logic;
      PROG_SCLK      : in std_logic;
      PROG_MOSI      : in std_logic;
      PROG_MISO      : out std_logic;
      PROG_INIT_DONE : in std_logic;
      
      CLK_DDR        : in std_logic;
      
      FPA_INT        : in std_logic;
      
      -- proxy side
      DAC_CSN_O      : out std_logic;
      DAC_SCLK_O     : out std_logic;
      DAC_SD_O       : out std_logic;
      
      FPA_ON         : out std_logic;
      PIXQNB_EN      : out std_logic;
      
      POCAN_RESET    : out std_logic;
      
      ROIC_SCLK      : out std_logic;
      ROIC_MOSI      : out std_logic;
      ROIC_MISO      : in std_logic;
      
      CLK_DDR_N      : out std_logic;
      CLK_DDR_P      : out std_logic;
      
      CLK_FRM        : out std_logic;
      
      CLK_RD         : out std_logic
   );
end calcium_io_intf;

architecture rtl of calcium_io_intf is

   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;
   
   component OBUFT is
      -- synopsys translate_off
      generic (
         CAPACITANCE : string     := "DONT_CARE";
         DRIVE       : integer    := 12;
         IOSTANDARD  : string     := "DEFAULT";
         SLEW        : string     := "SLOW"
      );
      -- synopsys translate_on
      port (
         O : out std_ulogic;
         I : in  std_ulogic;
         T : in  std_ulogic
      );
   end component;
   
   component OBUFTDS is
      -- synopsys translate_off
      generic (
         CAPACITANCE : string     := "DONT_CARE";
         IOSTANDARD  : string     := "DEFAULT";
         SLEW        : string     := "SLOW"
      );
      -- synopsys translate_on
      port (
         O  : out std_ulogic;
         OB : out std_ulogic;
         I  : in std_ulogic;
         T  : in std_ulogic
      );
   end component;
   
   type fpa_digio_fsm_type   is (idle, ldo_pwr_pause_st, fpa_pwr_on_st, fpa_pwr_pause_st, fpa_pwred_st, fpa_prog_st, passthru_st);
   type dac_digio_fsm_type   is (dac_pwr_pause_st, dac_pwred_st);
   
   signal fpa_digio_fsm    : fpa_digio_fsm_type;
   signal dac_digio_fsm    : dac_digio_fsm_type;
   signal sreset           : std_logic;
   signal fsm_sreset       : std_logic;
   signal dac_timer_cnt    : natural;
   signal fpa_timer_cnt    : natural;
   signal fpa_powered_i    : std_logic;
   signal dac_powered_i    : std_logic;
   signal dac_output_disabled : std_logic;
   signal clk_ddr_disabled : std_logic;
   
   signal fpa_on_i         : std_logic;
   signal pixqnb_en_i      : std_logic;
   signal pocan_reset_i    : std_logic;
   
   signal dac_csn_iob      : std_logic;
   signal dac_sclk_iob     : std_logic;
   signal dac_sd_iob       : std_logic;
   signal roic_sclk_iob    : std_logic;
   signal roic_mosi_iob    : std_logic;
   signal roic_miso_iob    : std_logic;
   signal clk_frm_iob      : std_logic;
   signal clk_rd_iob       : std_logic;
   
   attribute IOB : string;
   attribute IOB of dac_csn_iob     : signal is "TRUE";
   attribute IOB of dac_sclk_iob    : signal is "TRUE";
   attribute IOB of dac_sd_iob      : signal is "TRUE";
   attribute IOB of roic_sclk_iob   : signal is "TRUE";
   attribute IOB of roic_mosi_iob   : signal is "TRUE";
   attribute IOB of roic_miso_iob   : signal is "TRUE";
   attribute IOB of clk_frm_iob     : signal is "TRUE";
   attribute IOB of clk_rd_iob      : signal is "TRUE";
   
begin
   
   -- Output mapping (hw_driver side)
   FPA_POWERED <= fpa_powered_i;
   DAC_POWERED <= dac_powered_i;
   
   PROG_MISO   <= roic_miso_iob;
   
   -- Output mapping (proxy side)
   FPA_ON      <= fpa_on_i;
   PIXQNB_EN   <= pixqnb_en_i;
   
   POCAN_RESET <= pocan_reset_i;
   
   ROIC_SCLK   <= roic_sclk_iob;
   ROIC_MOSI   <= roic_mosi_iob;
   
   CLK_FRM     <= clk_frm_iob;
   
   CLK_RD      <= clk_rd_iob;
   
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
   -- DAC outputs
   --------------------------------------------------
   U2A : OBUFT
   port map (
      I  => dac_csn_iob,
      T  => dac_output_disabled,
      O  => DAC_CSN_O
   );
   
   U2B : OBUFT
   port map (
      I  => dac_sclk_iob,
      T  => dac_output_disabled,
      O  => DAC_SCLK_O
   );
   
   U2C : OBUFT
   port map (
      I  => dac_sd_iob,
      T  => dac_output_disabled,
      O  => DAC_SD_O
   ); 
   
   --------------------------------------------------
   -- CLK_DDR
   --------------------------------------------------
   U3 : OBUFTDS
   port map (
      I  => CLK_DDR,
      T  => clk_ddr_disabled,
      O  => CLK_DDR_P,
      OB => CLK_DDR_N
   );
   
   --------------------------------------------------
   -- Gestion du reset des FSM (process indépendant)
   --------------------------------------------------
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then
         fsm_sreset <= sreset or not FPA_PWR;
      end if;
   end process;
   
   --------------------------------------------------
   -- Gestion de l'allumage du proxy
   --------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then
         if fsm_sreset = '1' then      -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            fpa_digio_fsm <= idle; 
            fpa_timer_cnt <= 0;
            fpa_powered_i <= '0';
            fpa_on_i <= '0';
            pixqnb_en_i <= '0';
            pocan_reset_i <= '1';      -- reset activated for power-up
            roic_sclk_iob <= '0';
            roic_mosi_iob <= '0';
            roic_miso_iob <= '1';      -- MISO is high when inactive
            clk_ddr_disabled <= '1';   -- signaux CLK_DDR à 'Z' tant qu'il n'est pas configuré
            clk_frm_iob <= '0';
            clk_rd_iob <= '0';
            
         else
            
            case fpa_digio_fsm is
               
               -- Delai de power-on de la proxy
               when idle =>
                  if dac_powered_i = '1' then 
                     fpa_digio_fsm <= ldo_pwr_pause_st;
                  end if;
                  
               -- Delai de programmation du DAC
               when ldo_pwr_pause_st =>
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt = DEFINE_FLEG_LDO_DLY_FACTOR then    -- 800ms avec CLK=100MHz
                     fpa_digio_fsm <= fpa_pwr_on_st;
                  end if;
                  
                  -- pragma translate_off
                  if fpa_timer_cnt = 50 then 
                     fpa_digio_fsm <= fpa_pwr_on_st;
                  end if;
                  -- pragma translate_on 
               
               -- Active les LDO et les outputs du Level Shifter sortent du mode 'Z'
               when fpa_pwr_on_st =>
                  fpa_on_i <= '1';
                  fpa_timer_cnt <= 0;
                  fpa_digio_fsm <= fpa_pwr_pause_st;
                  
               -- Delai de power-on des LDO  
               when fpa_pwr_pause_st =>
                  fpa_timer_cnt <= fpa_timer_cnt + 1;
                  if fpa_timer_cnt > DEFINE_FPA_POWER_WAIT_FACTOR then
                     fpa_digio_fsm <=  fpa_pwred_st;
                  end if;
                  
                  -- pragma translate_off
                  if fpa_timer_cnt = 50 then 
                     fpa_digio_fsm <= fpa_pwred_st;
                  end if;
                  -- pragma translate_on
                  
               -- annoncer la bonne nouvelle relative à l'allumage du détecteur
               when fpa_pwred_st =>
                  fpa_powered_i <= '1';         -- permet au driver de placer une requete de programmation
                  pocan_reset_i <= '0';         -- on sort le roic du reset
                  if PROG_EN = '1'  then        -- attendre que le programmateur du FPA soit activée => trig arrêté
                     fpa_digio_fsm <= fpa_prog_st;
                  end if;
                  
               -- venir ici rapidement pour ne pas manquer la communication du programmateur
               when fpa_prog_st =>
                  roic_sclk_iob <= PROG_SCLK;
                  roic_mosi_iob <= PROG_MOSI;
                  roic_miso_iob <= ROIC_MISO;
                  if PROG_INIT_DONE = '1' then  -- on attend que la 1re programmation du ROIC soit faite
                     fpa_digio_fsm <= passthru_st;
                  end if;
               
               when passthru_st =>              -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  pixqnb_en_i <= '1';           -- on active le LDO vTstPixQNB seulement quand le ROIC a été programmé
                  roic_sclk_iob <= PROG_SCLK;
                  roic_mosi_iob <= PROG_MOSI;
                  roic_miso_iob <= ROIC_MISO;
                  clk_ddr_disabled <= '0';      -- on active CLK_DDR seulement quand le ROIC a été programmé
                  clk_frm_iob <= FPA_INT;
                  clk_rd_iob <= '0';            -- not used for now
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- Gestion des signaux du DAC
   --------------------------------------------------
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then
         if fsm_sreset = '1' then        -- fsm_sreset vaut '1' si sreset ou détecteur non allumé.
            dac_digio_fsm <= dac_pwr_pause_st;
            dac_powered_i <= '0';
            dac_timer_cnt <= 0;
            dac_output_disabled <= '1';   -- signaux du DAC à 'Z' tant qu'il n'a pas de power
            
         else
            
            case dac_digio_fsm is
               
               -- Delai de power-on de la proxy
               when dac_pwr_pause_st =>
                  dac_timer_cnt <= dac_timer_cnt + 1;
                  if dac_timer_cnt = DEFINE_FLEG_DAC_PWR_WAIT_FACTOR then     -- 320ms avec CLK=100MHz
                     dac_digio_fsm <= dac_pwred_st;
                  end if;
                  
                  -- pragma translate_off
                  if dac_timer_cnt = 50 then
                     dac_digio_fsm <= dac_pwred_st;
                  end if;
                  -- pragma translate_on
                  
               -- Le DAC peut maintenant être programmé
               when dac_pwred_st =>           -- on sort de cet état quand fsm_reset = '1' <=> sreset = '1' ou FPA_PWR = '0'
                  dac_powered_i <= '1';
                  dac_output_disabled <= '0';
                  dac_csn_iob <= DAC_CSN_I;
                  dac_sclk_iob <= DAC_SCLK_I;
                  dac_sd_iob <= DAC_SD_I;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
end rtl;
