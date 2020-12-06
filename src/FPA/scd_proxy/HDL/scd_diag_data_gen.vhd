-------------------------------------------------------------------------------
--
-- Title       : scd_diag_data_gen
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\SCD_Hercules\src\scd_diag_data_gen.vhd
-- Generated   : Mon Jan 10 13:16:11 2011
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
use work.FPA_define.all;
use work.Proxy_define.all;
use work.fpa_common_pkg.all;


entity scd_diag_data_gen is
   
   port(
      
      ARESET       : in std_logic;
      CLK          : in std_logic;
      
      FPA_INTF_CFG : fpa_intf_cfg_type;
      DIAG_MODE_EN : in std_logic;
      
      FPA_INT      : in std_logic;
      FPA_TRIG     : in std_logic;
      
      CH1_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH1    
      CH2_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH2 
      CH3_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH2
      
      DIAG_HDER    : out std_logic; --! 'à 1 pour signmifier la sortie du header
      DIAG_LINE    : out std_logic; --! 'à 1 pour signmifier la sortie des données d'une ligne
      DIAG_FRAME   : out std_logic
      
      );
end scd_diag_data_gen;


architecture rtl of scd_diag_data_gen is
   
   constant spare : std_logic := 'Z';
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port ( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   component fpa_diag_line_gen
      generic (
         ANALOG_IDDCA           : boolean := false;
         SAMP_NUM_PER_PIX       : natural range 0 to 15 := 5;
         ADC_QUAD_CLK_FACTOR    : natural range 0 to 15 := 5
         );
      port(
         CLK                : in std_logic;
         ARESET             : in std_logic;
         LINE_SIZE          : in std_logic_vector(15 downto 0);
         START_PULSE        : in std_logic;
         FIRST_VALUE        : in std_logic_vector(15 downto 0); 
         INCR_VALUE         : in std_logic_vector(15 downto 0);
         PIX_SAMP_TRIG      : in std_logic;
         DIAG_DATA          : out std_logic_vector(15 downto 0);
         DIAG_DVAL          : out std_logic; 
         DIAG_SOL           : out std_logic;
         DIAG_EOL           : out std_logic;   
         DIAG_DONE          : out std_logic
         );
   end component;
   
   type diag_fsm_type is (idle, x_to_readout_start_dly_st, rst_cnt_st, fval_on_st,fval_re_to_dval_re_dly_st, hder_st,
   start_line_gen_st, wait_line_gen_end_st, line_pause_st, x_to_next_fsync_re_dly_st );
   type img_change_sm_type is (idle, change_st);
   
   signal diag_fsm          : diag_fsm_type;
   signal img_change_sm     : img_change_sm_type;
   signal pix0_data_i       : std_logic_vector(15 downto 0);
   signal pix1_data_i       : std_logic_vector(15 downto 0); 
   signal pix2_data_i       : std_logic_vector(15 downto 0);
   signal pix3_data_i       : std_logic_vector(15 downto 0);
   signal hder_i            : std_logic;
   signal fval_i            : std_logic;
   signal lval_i            : std_logic;
   signal dval_i            : std_logic;    
   signal sreset            : std_logic;
   signal line_size_i       : std_logic_vector(15 downto 0);
   signal diag_line_gen_en  : std_logic;
   signal pix0_first_value  : std_logic_vector(15 downto 0);
   signal pix1_first_value  : std_logic_vector(15 downto 0);   
   signal pix2_first_value  : std_logic_vector(15 downto 0);
   signal pix3_first_value  : std_logic_vector(15 downto 0);
   signal incr_value        : std_logic_vector(15 downto 0);
   signal pix0_diag_data    : std_logic_vector(15 downto 0);
   signal pix1_diag_data    : std_logic_vector(15 downto 0);  
   signal pix2_diag_data    : std_logic_vector(15 downto 0);
   signal pix3_diag_data    : std_logic_vector(15 downto 0);
   signal pix0_diag_dval    : std_logic;
   signal pix1_diag_dval    : std_logic;
   signal pix2_diag_dval    : std_logic;
   signal pix3_diag_dval    : std_logic;
   signal diag_done_i       : std_logic;
   signal dly_cnt           : unsigned(15 downto 0);
   signal hder_dcnt         : unsigned(15 downto 0);
   signal line_cnt          : unsigned(15 downto 0);
   signal fpa_int_i         : std_logic;
   signal fpa_trig_i        : std_logic;
   signal fpa_int_last      : std_logic;
   signal revert_img        : std_logic;
   signal clk_div_i         : std_logic;
   signal clk_div_last      : std_logic;
   signal hder_data_id      : unsigned(7 downto 0);
   signal diag_clk_i        : std_logic;
   signal diag_clk_last_i   : std_logic;
   signal pix_samp_trig_i   : std_logic;
   signal fpa_trig_last : std_logic;
   
  --attribute keep                                   : string;
  --attribute keep of diag_fsm                       : signal is "true";
  --attribute keep of hder_i                         : signal is "true";
  --attribute keep of fval_i                         : signal is "true";
  --attribute keep of lval_i                         : signal is "true"; 
  --attribute keep of dval_i                         : signal is "true";
  --attribute keep of fpa_int_i                      : signal is "true";
  --attribute keep of fpa_trig_i                     : signal is "true";                       

  
begin
   
-- Output mapping for BB1280
-- BB1280 : se raporter à la page 57 (table 52) du document Communication protocol (D15F0002 REV2.pdf)
-- Pelican : se raporter à la page 23 (table 14) du document Communication protocol (d1k3008-rev1.pdf) 
   CH1_DATA(0)  <=  pix0_data_i(0);  
   CH1_DATA(1)  <=  pix0_data_i(1);  
   CH1_DATA(2)  <=  pix0_data_i(2);  
   CH1_DATA(3)  <=  pix0_data_i(3);  
   CH1_DATA(4)  <=  pix0_data_i(4);  
   CH1_DATA(5)  <=  pix0_data_i(7);
   CH1_DATA(6)  <=  pix0_data_i(5);  
   CH1_DATA(7)  <=  pix0_data_i(8);
   CH1_DATA(8)  <=  pix0_data_i(9);  
   CH1_DATA(9)  <=  pix0_data_i(10); 
   CH1_DATA(10) <=  pix0_data_i(14);
   CH1_DATA(11) <=  pix0_data_i(15);
   CH1_DATA(12) <=  pix0_data_i(11); 
   CH1_DATA(13) <=  pix0_data_i(12); 
   CH1_DATA(14) <=  pix0_data_i(13);
   CH1_DATA(15) <=  pix1_data_i(0);
   CH1_DATA(16) <=  pix1_data_i(6);
   CH1_DATA(17) <=  pix1_data_i(7);  
   CH1_DATA(18) <=  pix1_data_i(1);
   CH1_DATA(19) <=  pix1_data_i(2);
   CH1_DATA(20) <=  pix1_data_i(3);
   CH1_DATA(21) <=  pix1_data_i(4);
   CH1_DATA(22) <=  pix1_data_i(5);   
   CH1_DATA(23) <=  hder_i;         
   CH1_DATA(24) <=  lval_i;           
   CH1_DATA(25) <=  fval_i;           
   CH1_DATA(26) <=  dval_i;
   CH1_DATA(27) <=  pix0_data_i(6); 
   
   CH2_DATA(0)  <=  pix1_data_i(8);
   CH2_DATA(1)  <=  pix1_data_i(9);
   CH2_DATA(2)  <=  pix1_data_i(10);
   CH2_DATA(3)  <=  pix1_data_i(11);
   CH2_DATA(4)  <=  pix1_data_i(12);
   CH2_DATA(5)  <=  pix1_data_i(15);
   CH2_DATA(6)  <=  pix1_data_i(13);
   CH2_DATA(7)  <=  pix2_data_i(0);
   CH2_DATA(8)  <=  pix2_data_i(1);  
   CH2_DATA(9)  <=  pix2_data_i(2); 
   CH2_DATA(10) <=  pix2_data_i(6);
   CH2_DATA(11) <=  pix2_data_i(7);
   CH2_DATA(12) <=  pix2_data_i(3); 
   CH2_DATA(13) <=  pix2_data_i(4); 
   CH2_DATA(14) <=  pix2_data_i(5);
   CH2_DATA(15) <=  pix2_data_i(8);
   CH2_DATA(16) <=  pix2_data_i(14);
   CH2_DATA(17) <=  pix2_data_i(15);  
   CH2_DATA(18) <=  pix2_data_i(9);
   CH2_DATA(19) <=  pix2_data_i(10);
   CH2_DATA(20) <=  pix2_data_i(11);
   CH2_DATA(21) <=  pix2_data_i(12);
   CH2_DATA(22) <=  pix2_data_i(13);   
   CH2_DATA(23) <=  hder_i;
   CH2_DATA(24) <=  lval_i; 
   CH2_DATA(25) <=  fval_i;  
   CH2_DATA(26) <=  dval_i;
   CH2_DATA(27) <=  pix1_data_i(14); 
   
   CH3_DATA(0)  <=  pix3_data_i(0);
   CH3_DATA(1)  <=  pix3_data_i(1);
   CH3_DATA(2)  <=  pix3_data_i(2);
   CH3_DATA(3)  <=  pix3_data_i(3);
   CH3_DATA(4)  <=  pix3_data_i(4);
   CH3_DATA(5)  <=  pix3_data_i(7);
   CH3_DATA(6)  <=  pix3_data_i(5);
   CH3_DATA(7)  <=  pix3_data_i(8);
   CH3_DATA(8)  <=  pix3_data_i(9);  
   CH3_DATA(9)  <=  pix3_data_i(10); 
   CH3_DATA(10) <=  pix3_data_i(14);
   CH3_DATA(11) <=  pix3_data_i(15);
   CH3_DATA(12) <=  pix3_data_i(11); 
   CH3_DATA(13) <=  pix3_data_i(12); 
   CH3_DATA(14) <=  pix3_data_i(13);
   CH3_DATA(15) <=  spare;
   CH3_DATA(16) <=  spare;
   CH3_DATA(17) <=  spare;  
   CH3_DATA(18) <=  spare;
   CH3_DATA(19) <=  spare;
   CH3_DATA(20) <=  spare;
   CH3_DATA(21) <=  spare;
   CH3_DATA(22) <=  spare;   
   CH3_DATA(23) <=  hder_i;
   CH3_DATA(24) <=  lval_i; 
   CH3_DATA(25) <=  fval_i;  
   CH3_DATA(26) <=  dval_i;
   CH3_DATA(27) <=  pix3_data_i(6);      
   
   
   DIAG_HDER  <= hder_i;
   DIAG_LINE  <= lval_i;
   DIAG_FRAME <= fval_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- clock divider
   -------------------------------------------------- 
   -- sampling clk enable
   genA: if DEFINE_DIAG_DATA_CLK_FACTOR > 1 generate     
      UCa: Clk_Divider
      Generic map(
         Factor => DEFINE_DIAG_DATA_CLK_FACTOR
         )
      Port map( 
         Clock   => CLK, 
         Reset   => sreset, 
         Clk_div => diag_clk_i   -- attention, c'est en realité un clock enable.
         );  
      
      -- sampling trig en mode diag
      UCb : process(CLK)
      begin
         if rising_edge(CLK) then
            diag_clk_last_i <= diag_clk_i;
            pix_samp_trig_i <= not diag_clk_last_i and diag_clk_i;
         end if;
      end process;
   end generate;
   
   genB: if DEFINE_DIAG_DATA_CLK_FACTOR <= 1 generate 
      pix_samp_trig_i <= '1'; 
   end generate;   
   
   
   --------------------------------------------------
   -- Pixel 0 data gen 
   --------------------------------------------------   
   U1: fpa_diag_line_gen
   generic map(
      ANALOG_IDDCA => false,      
      SAMP_NUM_PER_PIX => 1,
      ADC_QUAD_CLK_FACTOR => 1
      )
   port map(
      CLK => CLK,
      ARESET => ARESET,
      LINE_SIZE => line_size_i,
      START_PULSE => diag_line_gen_en,
      FIRST_VALUE => pix0_first_value,
      INCR_VALUE => incr_value,
      PIX_SAMP_TRIG => pix_samp_trig_i,
      DIAG_DATA => pix0_diag_data,
      DIAG_DVAL => pix0_diag_dval,
      DIAG_SOL => open,
      DIAG_EOL => open,    
      DIAG_DONE => diag_done_i
      );
   
   --------------------------------------------------
   -- Pixel 1 data gen 
   --------------------------------------------------   
   U2: fpa_diag_line_gen
   generic map(
      ANALOG_IDDCA => false,      
      SAMP_NUM_PER_PIX => 1,
      ADC_QUAD_CLK_FACTOR => 1
      )
   port map(
      CLK => CLK,
      ARESET => ARESET,
      LINE_SIZE => line_size_i,
      START_PULSE => diag_line_gen_en,
      FIRST_VALUE => pix1_first_value,
      INCR_VALUE => incr_value,
      PIX_SAMP_TRIG => pix_samp_trig_i,
      DIAG_DATA => pix1_diag_data,
      DIAG_DVAL => pix1_diag_dval,
      DIAG_SOL => open,
      DIAG_EOL => open,   
      DIAG_DONE => open
      ); 
      
   CH2_INPUT : if (PROXY_CLINK_CHANNEL_NUM = 2) generate
   begin  
      pix2_diag_data <= (others => '0');
      pix2_diag_dval <= '0';
      pix3_diag_data <= (others => '0');
      pix3_diag_dval <= '0';
   end generate;
   
   CH3_INPUT : if (PROXY_CLINK_CHANNEL_NUM = 3) generate
   begin 
      --------------------------------------------------
      -- Pixel 2 data gen 
      --------------------------------------------------   
      U3: fpa_diag_line_gen
      generic map(
         ANALOG_IDDCA => false,      
         SAMP_NUM_PER_PIX => 1,
         ADC_QUAD_CLK_FACTOR => 1
         )
      port map(
         CLK => CLK,
         ARESET => ARESET,
         LINE_SIZE => line_size_i,
         START_PULSE => diag_line_gen_en,
         FIRST_VALUE => pix2_first_value,
         INCR_VALUE => incr_value,
         PIX_SAMP_TRIG => pix_samp_trig_i,
         DIAG_DATA => pix2_diag_data,
         DIAG_DVAL => pix2_diag_dval,
         DIAG_SOL => open,
         DIAG_EOL => open,    
         DIAG_DONE => open
         );
      
      --------------------------------------------------
      -- Pixel 3 data gen 
      --------------------------------------------------   
      U4: fpa_diag_line_gen
      generic map(
         ANALOG_IDDCA => false,      
         SAMP_NUM_PER_PIX => 1,
         ADC_QUAD_CLK_FACTOR => 1
         )
      port map(
         CLK => CLK,
         ARESET => ARESET,
         LINE_SIZE => line_size_i,
         START_PULSE => diag_line_gen_en,
         FIRST_VALUE => pix3_first_value,
         INCR_VALUE => incr_value,
         PIX_SAMP_TRIG => pix_samp_trig_i,
         DIAG_DATA => pix3_diag_data,
         DIAG_DVAL => pix3_diag_dval,
         DIAG_SOL => open,
         DIAG_EOL => open,   
         DIAG_DONE => open
         );
   end generate;   
   
    
   -------------------------------------------------------------------
   -- generation des données du mode diag   
   -------------------------------------------------------------------   
   U5: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            diag_fsm <=  idle;
            fval_i <= '0';
            dval_i <= '0';
            lval_i <= '0';
            hder_i <= '0';
            fpa_int_last <= fpa_int_i;  
            fpa_trig_last <= fpa_trig_i;
         else   
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i;
            fpa_trig_i <= FPA_TRIG;  
            fpa_trig_last <= fpa_trig_i;

            -- configuration des generateurs de lignes
            if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_CNST then         -- constant               
               pix0_first_value <= std_logic_vector(to_unsigned(4096, pix0_first_value'length)); 
               pix1_first_value <= std_logic_vector(to_unsigned(4096, pix1_first_value'length));
               pix2_first_value <= std_logic_vector(to_unsigned(4096, pix2_first_value'length)); 
               pix3_first_value <= std_logic_vector(to_unsigned(4096, pix3_first_value'length));
               incr_value <= (others => '0');
               
            else                                                               -- degradé lineaire constant et dégradé linéaire dynamique
               pix0_first_value <= std_logic_vector(to_unsigned(0, pix0_first_value'length)); 
               pix1_first_value <= std_logic_vector(to_unsigned(0 + 1*DIAG_DATA_INC, pix1_first_value'length));  
               pix2_first_value <= std_logic_vector(to_unsigned(0 + 2*DIAG_DATA_INC, pix2_first_value'length)); 
               pix3_first_value <= std_logic_vector(to_unsigned(0 + 3*DIAG_DATA_INC, pix3_first_value'length));
               incr_value <= std_logic_vector(to_unsigned(PROXY_CLINK_PIXEL_NUM*DIAG_DATA_INC, incr_value'length));           
            end if;
           
            -- Pelican : Se raporter a la figure 5 (d1k3008-rev1)  
            -- BB1280  : Se raporter a la figure 8 (D15F0002 REV2)
            -- Le delai x_to_readout_start prend une signification différente selon les cas suivants :
            --     Cas 1 : Pour le BB1280, ce délai est directement le paramètre FR_DLY de la commande opérationelle + Tframe_init (x se réfère au rising edge du FSYNC).
            --     Cas 2 : Pour le Pelican/Hercule en ITR, ce délai est T6 et x se réfère à la fin de l'intégration.   
            --     Cas 3 : Pour le Pelican/Hercule en IWR, ce délai est T6 et x se réfère au début de l'intégration.
            case diag_fsm is 
               
               when idle =>
                  dly_cnt <= (others => '0');
                  hder_dcnt <= to_unsigned(1, hder_dcnt'length);
                  hder_data_id <= (others => '0');
                  line_cnt <= (others => '0');
                  dval_i <= '0';
                  lval_i <= '0';
                  fval_i <= '0';
                  diag_line_gen_en <= '0'; 
                  if DIAG_MODE_EN = '1' then 
                     if SCD_TRIG_REFERENCED = '1'  then -- BB1280 only
                        if fpa_trig_last = '0' and fpa_trig_i = '1' then   
                           diag_fsm <=  x_to_readout_start_dly_st;              
                        end if;
                     elsif FPA_INTF_CFG.SCD_OP.SCD_INT_MODE = SCD_IWR then -- Pelican/Hercule only
                        if fpa_int_last = '0' and fpa_int_i = '1' then   
                           diag_fsm <=  x_to_readout_start_dly_st;           
                        end if;
                     else
                        if fpa_int_last = '1' and fpa_int_i = '0' then -- Pelican/Hercule only  
                           diag_fsm <=  x_to_readout_start_dly_st;              
                        end if;
                     end if;
                  end if;
               
               when x_to_readout_start_dly_st =>    
                  if dly_cnt >= FPA_INTF_CFG.SCD_MISC.scd_x_to_readout_start_dly then 
                     diag_fsm <=  fval_on_st;                   
                  else
                     dly_cnt <= dly_cnt + 1; 
                  end if;

               when fval_on_st => 
                  fval_i <= '1';
                  diag_fsm <=  fval_re_to_dval_re_dly_st; 
                  dly_cnt <= (others => '0');
               
               when fval_re_to_dval_re_dly_st =>   
                  if dly_cnt = FPA_INTF_CFG.SCD_MISC.scd_fval_re_to_dval_re_dly then 
                     diag_fsm <=  hder_st;
                  else
                     dly_cnt <= dly_cnt + 1; 
                  end if;  

               when hder_st =>
                  lval_i <= '1';
                  dval_i <= '1';
                  hder_i <= '1';
                  hder_dcnt <= hder_dcnt + 1;
                  hder_data_id <= hder_data_id + 1;

                  if hder_dcnt > FPA_INTF_CFG.SCD_MISC.scd_hdr_high_duration then
                     hder_i <= '0';                     
                  end if;
                  if hder_dcnt > FPA_INTF_CFG.SCD_MISC.scd_lval_high_duration and hder_i = '0' then
                     lval_i <= '0';
                     dval_i <= '0';
                  end if;
                  if hder_dcnt = FPA_INTF_CFG.SCD_MISC.scd_hdr_start_to_lval_re_dly then
                     diag_fsm <=  start_line_gen_st;
                  end if;
                  
                  pix0_data_i <= (others => '0');
                  pix1_data_i <= (others => '0');
                  pix2_data_i <= (others => '0');
                  pix3_data_i <= (others => '0');

               when start_line_gen_st =>
                  diag_line_gen_en <= '1';   -- on active le module généateur des données diag
                  line_size_i <= std_logic_vector(resize(FPA_INTF_CFG.SCD_MISC.scd_xsize_div_per_pixel_num, line_size_i'length)); 
                  dly_cnt <= (others => '0');
                  if diag_done_i = '0' then
                     diag_line_gen_en <= '0';
                     line_cnt <= line_cnt + 1;
                     diag_fsm <=  wait_line_gen_end_st;
                  end if;
               
               when wait_line_gen_end_st =>
                  lval_i <= '1';   
                  dval_i <= pix0_diag_dval; -- on se branche sur le module generateur de données diag
                  if revert_img = '1' then 
                     pix0_data_i <= not pix0_diag_data; -- dégradé vers la gauche 
                     pix1_data_i <= not pix1_diag_data;     
                     pix2_data_i <= not pix2_diag_data;     
                     pix3_data_i <= not pix3_diag_data;     
                  else
                     pix0_data_i <= pix0_diag_data; -- dégradé vers la droite 
                     pix1_data_i <= pix1_diag_data;  
                     pix2_data_i <= pix2_diag_data;  
                     pix3_data_i <= pix3_diag_data; 
                  end if;
                  if diag_done_i = '1' then  
                     diag_fsm <=  line_pause_st;
                     dly_cnt <= to_unsigned(6, dly_cnt'length); -- pour tenir compte des delais supplémentaires (vus en simulation)
                  end if;
               
               when line_pause_st =>
                  lval_i <= '0';  
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt >= FPA_INTF_CFG.SCD_MISC.scd_lval_pause_dly then
                     diag_fsm <=  start_line_gen_st;
                  end if;
                  if line_cnt >= FPA_INTF_CFG.SCD_OP.SCD_YSIZE then
                     diag_fsm <=  rst_cnt_st;
                  end if;
               
               when rst_cnt_st =>
                  dly_cnt <= (others => '0');
                  diag_fsm <=  x_to_next_fsync_re_dly_st ; 
               
               when x_to_next_fsync_re_dly_st  =>
                  dly_cnt <= dly_cnt + 1;                                                                             
                  if dly_cnt = FPA_INTF_CFG.SCD_MISC.scd_x_to_next_fsync_re_dly then
                     diag_fsm <= idle; 
                  end if;
               
               when others =>
               
            end case;
            
         end if;         
      end if;
   end process;
   
   --------------------------------------------------------
   -- Genereteur d'impulsion de 2 secondes de periode
   -------------------------------------------------------- 
   U6: Clk_Divider
   Generic map(
      Factor=> 200_000_000
      -- pragma translate_off
      /10_000
      -- pragma translate_on
      )
   Port map( 
      Clock => CLK, 
      Reset => sreset, 
      Clk_div => clk_div_i
      );
   
   ----------------------------------------------------------
   -- contrôle du basculement de l'image en mode dynamique
   ---------------------------------------------------------- 
   U7: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            img_change_sm <= idle;
            revert_img <= '0';
         else 
            
            clk_div_last <= clk_div_i;
            
            case img_change_sm is
               
               when idle =>
                  if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_DEGR_DYN then --  mode degradé dynamique
                     if clk_div_last = '0' and clk_div_i = '1' then    -- il faut attendre 2 secondes avant de changer d'état
                        img_change_sm <= change_st;
                     end if;
                  else
                     revert_img <= '0';
                  end if;
               
               when change_st =>
                  if hder_i = '1' then    -- on attend le debut d'une nouvelle image pour que le chagement d'état soit effectif
                     revert_img <= not revert_img;
                     img_change_sm <= idle;
                  end if;
               
               when others =>
               
            end case;        
            
         end if;
      end if;
   end process; 
   
end rtl;
