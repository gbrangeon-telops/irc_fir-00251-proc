------------------------------------------------------------------
--!   @file fpa_trig_precontroller.vhd
--!   @brief contrôleur de trigs d'intégration
--!   @details ce module poermet de rejeter de images à venir dans la chaine en forçant le mode XYTRA_TRIG sous certaines conditions 
--! 
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

--!   Use IEEE standard library.
library IEEE;
--!   Use logic elements package from IEEE library.
use IEEE.STD_LOGIC_1164.all;					   
--!   Use numeric package package from IEEE library.
use IEEE.numeric_std.all; 
use work.FPA_Common_pkg.all;
--!   Use work FPA package.
use work.FPA_define.all;
use work.Proxy_define.all;

entity fpa_trig_precontroller is
   port(
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      -- configuration
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      -- premier Xtra trig mode  
      PRIM_XTRA_TRIG_ACTIVE: in std_logic;  -- le front montant de ce signal permet de rentrer en mode xtra trig 1
      
      -- trigs d'acquisition ou xtra trig du generateur de trig
      ACQ_TRIG_IN      : in std_logic;
      XTRA_TRIG_IN     : in std_logic;
      
      -- trigs d'acquisition ou xtra trig envoyés au fpa
      ACQ_TRIG_OUT     : out std_logic;
      XTRA_TRIG_OUT    : out std_logic;
      
      -- signal readout
      FPA_READOUT      : in std_logic       
      
      );
end fpa_trig_precontroller;


architecture RTL of fpa_trig_precontroller is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;
   
   component gh_stretch 
      generic (stretch_count: integer := 3072);
      port(
         CLK : in STD_LOGIC;
         rst : in STD_LOGIC;
         D : in STD_LOGIC;
         Q : out STD_LOGIC
         );
   end component;
   
   type trig_prectrl_sm_type is (idle, init_st, wait_xtra_img_st, prim_xtra_st, second_xtra_st);
   signal trig_prectrl_sm              : trig_prectrl_sm_type;
   signal sreset                       : std_logic;
   signal acq_trig_in_i                : std_logic; 
   signal xtra_trig_in_i               : std_logic;
   signal acq_trig_temp                : std_logic;
   signal xtra_trig_temp               : std_logic;
   signal acq_trig_stretch             : std_logic;
   signal xtra_trig_stretch            : std_logic;
   signal acq_trig_o                   : std_logic;
   signal xtra_trig_o                  : std_logic;
   signal done                         : std_logic;
   signal fpa_readout_i                : std_logic;
   signal fpa_readout_last             : std_logic;
   signal xtra_img_cnt                 : unsigned(7 downto 0);
   signal acq_trig_last                : std_logic;
   signal xtra_trig_last               : std_logic;
   signal diag_mode_i                  : std_logic := '1'; 
   
   ---- attribute dont_touch                : string;
   ---- attribute dont_touch of acq_trig_temp  : signal is "true";
   ---- attribute dont_touch of xtra_trig_o : signal is "true";
   ---- attribute dont_touch of fpa_readout_last  : signal is "true";
   
   
begin
   --------------------------------------------------
   -- mapping des sorties
   --------------------------------------------------  
   ACQ_TRIG_OUT <=  acq_trig_o; --! '1' ssi l'image suivant l'integration en court doit être envoyée dans la chaine. Sinon, à '0'.
   XTRA_TRIG_OUT <=  xtra_trig_o; --! '1' si l'image suivant l'integration en court doit être envoyée ou non dans la chaine.
   
   
   
   U0A : gh_stretch 
   generic map (stretch_count => 3072)   -- sur demande de MDA, acq_trig étiré de 30 usec pour supporter instabilité de la roue à filtres en mode synchrone uniquement et ce, pour les SCD 
   port map(
      CLK  => CLK,
      rst  => sreset,
      D    => acq_trig_temp,
      Q    => acq_trig_stretch
      );
   
   U0B : gh_stretch 
   generic map (stretch_count => 3072)   -- ODI: xtra_trig est étiré comme acq_trig
   port map(
      CLK  => CLK,
      rst  => sreset,
      D    => xtra_trig_temp,
      Q    => xtra_trig_stretch
      );
   
   --------------------------------------------------
   -- synchro 
   --------------------------------------------------   
   U1A : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   U1B : double_sync
   port map(
      CLK => CLK,
      D   => FPA_READOUT,
      Q   => fpa_readout_i,
      RESET => sreset
      );
   
   U1C : double_sync
   port map(
      CLK => CLK,
      D   => ACQ_TRIG_IN,
      Q   => acq_trig_in_i,
      RESET => sreset
      );
   
   U1D : double_sync
   port map(
      CLK => CLK,
      D   => XTRA_TRIG_IN,
      Q   => xtra_trig_in_i,
      RESET => sreset
      );

   U1E : double_sync
   generic map (INIT_VALUE => '1')
   port map(
      CLK => CLK,
      D   => FPA_INTF_CFG.COMN.FPA_DIAG_MODE,
      Q   => diag_mode_i,
      RESET => sreset
      );
      
      
   --------------------------------------------------
   -- fsm de contrôle/filtrage des trigs 
   -------------------------------------------------- 
   -- et de suivi du mode d'integration
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            acq_trig_o <= '0';
            xtra_trig_o <= '0';
            done <= '0';
            trig_prectrl_sm <= init_st;
            fpa_readout_last <= '0';
            xtra_img_cnt <= (others => '0');
            acq_trig_temp <= '0';
            xtra_trig_temp <= '0';
            
         else
            
            -- étirement ou non 
            if FPA_INTF_CFG.comn.fpa_stretch_acq_trig = '1' then 
               acq_trig_o <= acq_trig_stretch;
               xtra_trig_o <= xtra_trig_stretch;
            else
               acq_trig_o <= acq_trig_temp;
               xtra_trig_o <= xtra_trig_temp;
            end if;
            
            
            -- pour detection front de FPA_readout
            fpa_readout_last <= fpa_readout_i;
            
            -- séquenceur
            case trig_prectrl_sm is 
               
               -- etat init_st : oin envoie les trigs tels qu,on les reçoit et on attend que l'idDCA soit fonctionnel.
               when init_st =>
                  acq_trig_temp <= acq_trig_in_i;
                  xtra_trig_temp <= xtra_trig_in_i;
                  if fpa_readout_i = '1' and diag_mode_i = '0' and PRIM_XTRA_TRIG_ACTIVE = '0' then -- donc l'IDDCA est actif et on veut se synchroniser sur le prochain PRIM_XTRA_TRIG_ACTIVE = '1'
                     trig_prectrl_sm <= idle;
                  end if;                   
                  
               -- etat idle
               when idle => 
                  acq_trig_temp <= acq_trig_in_i;
                  xtra_trig_temp <= xtra_trig_in_i;
                  done <= '1'; 
                  xtra_img_cnt <= (others => '0');
                  if PRIM_XTRA_TRIG_ACTIVE = '1' then
                     xtra_trig_temp <= '1';    -- permet de lancer le détecteur en mode xtraTrig à vitesse max possible  
                     acq_trig_temp <= '0';
                     trig_prectrl_sm <= prim_xtra_st;                        
                  end if;                     
                  
               -- mode xtra_trig 1. on y reste tant que  PRIM_XTRA_TRIG_ACTIVE reste à '1'
               when prim_xtra_st => 
                  xtra_trig_temp <= '1';    -- permet de lancer le détecteur en mode xtraTrig à vitesse max possible  
                  acq_trig_temp <= '0';
                  if fpa_readout_last = '1' and  fpa_readout_i = '0' then --! fin du readout.
                     trig_prectrl_sm <= wait_xtra_img_st;
                  end if;
               
               when wait_xtra_img_st =>  -- je m'assure qu'au moins une image est passée en xtraTrig puis j'attends PRIM_XTRA_TRIG_ACTIVE = '0'              
                  if PRIM_XTRA_TRIG_ACTIVE = '0' and (fpa_readout_last = '1' and  fpa_readout_i = '0') then 
                     trig_prectrl_sm <= second_xtra_st;                        
                  end if;                     
                  
               -- second_xtra_st.
               when second_xtra_st => 
                  if fpa_readout_last = '1' and  fpa_readout_i = '0' then --! fin du readout.
                     xtra_img_cnt <= xtra_img_cnt + 1;
                  end if;
                  if xtra_img_cnt >= FPA_XTRA_IMAGE_NUM_TO_SKIP then
                     trig_prectrl_sm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;         
      end if;
      
   end process;
   
   
end RTL;
