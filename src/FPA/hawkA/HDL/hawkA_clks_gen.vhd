------------------------------------------------------------------
--!   @file : hawkA_clks_gen
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
use IEEE.numeric_std.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity hawkA_clks_gen is
   port(
      ARESET            : in std_logic;
      
      CLK_80M           : in std_logic;
      CLK_160M          : in std_logic;
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      DISABLE_QUAD_CLK_DEFAULT : in std_logic;
      
      FPA_MCLK          : out std_logic;
      FPA_PCLK          : out std_logic;  -- pour le hawk, Pixel clock (PCLK) = master clock (MCLK). C'est le double pour les indigo
      
      QUAD_CLK_COPY     : out std_logic;  -- quad_clk utilisé par le readout_ctrler
      
      QUAD1_CLK         : out std_logic;
      QUAD2_CLK         : out std_logic;
      
      ADC_DESERIALIZER_RST  : out std_logic  -- à '1' si ARESET à '1' ou si aucune carte ADC valide n'est détectée.
      
      );
end hawkA_clks_gen;

architecture rtl of hawkA_clks_gen is   
   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port ( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   signal sreset                         : std_logic;
   signal quad_clk_iob                   : std_logic_vector(2 downto 1);
   signal fpa_mclk_i                     : std_logic;
   signal fpa_pclk_i                     : std_logic;
   signal quad_clk_default               : std_logic;
   signal quad_clk_raw                   : std_logic;
   signal disable_quad_clk_default_i     : std_logic;
   signal quad_clk_pipe                  : std_logic_vector(15 downto 0);
   signal adc_deserializer_rst_i         : std_logic;
   signal quad_clk_copy_i                : std_logic;
   signal quad_clk_r                     : std_logic_vector(2 downto 1);
   
   attribute equivalent_register_removal : string;
   attribute equivalent_register_removal of quad_clk_iob: signal is "no";
   
   attribute iob : string;
   attribute iob of quad_clk_iob: signal is "true";
   
   attribute dont_touch : string;
   attribute dont_touch of quad_clk_iob: signal is "true";
   
begin
   
   QUAD1_CLK <= quad_clk_iob(1);
   QUAD2_CLK <= quad_clk_iob(2);
   QUAD_CLK_COPY <= quad_clk_copy_i;
   
   ADC_DESERIALIZER_RST <= adc_deserializer_rst_i;
   
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1B: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset, CLK => CLK_80M);
   
   
   --------------------------------------------------------
   -- Genereteur master clock enable pour le détecteur
   -------------------------------------------------------- 
   U2A: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_MCLK_RATE_FACTOR
      )
   Port map( 
      Clock   => CLK_80M,     -- choix de 80MHz pour le FPA
      Reset   => sreset, 
      Clk_div => fpa_mclk_i   -- attention, c'est en realité un clock enable. 
      );
   
   
   --------------------------------------------------------
   -- Genereteur pixel clock enable pour les process
   -------------------------------------------------------- 
   U2B: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_PCLK_RATE_FACTOR
      )
   Port map( 
      Clock   => CLK_80M,     -- choix de 80MHz pour le FPA
      Reset   => sreset, 
      Clk_div => fpa_pclk_i   -- attention, c'est en realité un clock enable. 
      );
   
   
   --------------------------------------------------------
   -- passage à travers des registres
   --------------------------------------------------------    
   U2C : process(CLK_80M)
   begin
      if rising_edge(CLK_80M) then
         FPA_MCLK <= fpa_mclk_i;  
         FPA_PCLK <= fpa_pclk_i;    -- pour le hawk, Pixel clock (PCLK) = master clock (MCLK). C'est le double pour les indigo
      end if;
   end process;
   
   
   --------------------------------------------------------
   -- Genereteur clock des adcs quads
   -------------------------------------------------------- 
   -- clock par defaut
   U3A: Clk_Divider
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_DEFAULT_FACTOR
      )
   Port map( 
      Clock   => CLK_80M,    -- choix de la même horloge source que fpa_mclk_i !!!!!
      Reset   => sreset, 
      Clk_div => quad_clk_default   -- attention, c'est en realité un clock enable.
      );   
   
   --   clock reelle utilisable après vérification des limites de la carte ADC
   U3B: Clk_Divider
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_FACTOR
      )
   Port map( 
      Clock   => CLK_80M, 
      Reset   => sreset, 
      Clk_div => quad_clk_raw   -- attention, c'est en realité un clock enable.
      );  
   
   -- horloge des quads .Attention, c'est en realité un clock enable.
   U3C : process(CLK_80M)
   begin
      if rising_edge(CLK_80M) then                                          
         
         adc_deserializer_rst_i <= ARESET or not disable_quad_clk_default_i;
         
         -- signal de basculement entre horloge par defaut et horloge finale
         if quad_clk_raw = '0' and quad_clk_default = '0' then 
            disable_quad_clk_default_i <= DISABLE_QUAD_CLK_DEFAULT;              -- changement seulement à la tombée des deux clocks pour viter des pointes.
         end if;
         
         quad_clk_copy_i <= (quad_clk_default and not disable_quad_clk_default_i) or (quad_clk_raw and disable_quad_clk_default_i);
         
      end if;
   end process;
   
   -- dephaseurs
   U3D : process(CLK_160M)
   begin
      if rising_edge(CLK_160M) then                                          
         
         -- choix de l'horloge des adcs
         quad_clk_pipe(0) <= (quad_clk_default and not disable_quad_clk_default_i) or (quad_clk_raw and disable_quad_clk_default_i);
         quad_clk_pipe(15 downto 1) <= quad_clk_pipe(14 downto 0);
         
         for ii in 1 to 2 loop
            quad_clk_r(ii) <= quad_clk_pipe(to_integer(FPA_INTF_CFG.ADC_CLK_PHASE));
         end loop;
         
      end if;
   end process;
   
   
   -- clocks des ADCS
   U3E : process(CLK_160M)
   begin
      if rising_edge(CLK_160M) then                                          
         
         -- registres des IOBs
         for ii in 1 to 2 loop
            quad_clk_iob(ii) <= quad_clk_r(ii); 
         end loop;
         
      end if;
   end process;
   
end rtl;
