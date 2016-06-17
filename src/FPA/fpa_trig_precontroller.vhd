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
      CLK_100M         : in std_logic;
      
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
   
   type trig_prectrl_sm_type is (idle, init_st, wait_xtra_img_st, prim_xtra_st, second_xtra_st);
   signal trig_prectrl_sm              : trig_prectrl_sm_type;
   signal sreset                       : std_logic;
   signal acq_trig_o                   : std_logic;
   signal xtra_trig_o                  : std_logic;
   signal done                         : std_logic;
   signal fpa_readout_last             : std_logic;
   signal xtra_img_cnt                 : unsigned(7 downto 0);
   signal acq_trig_last                : std_logic;
   signal xtra_trig_last               : std_logic; 
   
   -- attribute dont_touch                : string;
   -- attribute dont_touch of acq_trig_o  : signal is "true";
   -- attribute dont_touch of xtra_trig_o : signal is "true";
   -- attribute dont_touch of fpa_readout_last  : signal is "true";
   
   
begin
   --------------------------------------------------
   -- mapping des sorties
   --------------------------------------------------  
   ACQ_TRIG_OUT <=  acq_trig_o; --! '1' ssi l'image suivant l'integration en court doit être envoyée dans la chaine. Sinon, à '0'.
   XTRA_TRIG_OUT <=  xtra_trig_o; --! '1' si l'image suivant l'integration en court doit être envoyée ou non dans la chaine.
   
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK_100M,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   -- fsm de contrôle/filtrage des trigs 
   -------------------------------------------------- 
   -- et de suivi du mode d'integration
   U2: process(CLK_100M)
   begin
      if rising_edge(CLK_100M) then 
         if sreset = '1' then 
            acq_trig_o <= '0';
            xtra_trig_o <= '0';
            done <= '0';
            trig_prectrl_sm <= init_st;
            fpa_readout_last <= '0';
            xtra_img_cnt <= (others => '0');
            
         else
            
            -- pour detection front de FPA_readout
            fpa_readout_last <= FPA_READOUT;
            
            -- séquenceur
            case trig_prectrl_sm is 
               
               -- etat init_st : oin envoie les trigs tels qu,on les reçoit et on attend que l'idDCA soit fonctionnel.
               when init_st =>
                  acq_trig_o <= ACQ_TRIG_IN;
                  xtra_trig_o <= XTRA_TRIG_IN;
                  if FPA_READOUT = '1' and FPA_INTF_CFG.COMN.FPA_DIAG_MODE = '0' and PRIM_XTRA_TRIG_ACTIVE = '0' then -- donc l'IDDCA est actif et on veut se synchroniser sur le prochain PRIM_XTRA_TRIG_ACTIVE = '1'
                     trig_prectrl_sm <= idle;
                  end if;                   
                  
               -- etat idle
               when idle => 
                  acq_trig_o <= ACQ_TRIG_IN;
                  xtra_trig_o <= XTRA_TRIG_IN;
                  done <= '1'; 
                  xtra_img_cnt <= (others => '0');
                  if PRIM_XTRA_TRIG_ACTIVE = '1' then
                     xtra_trig_o <= '1';    -- permet de lancer le détecteur en mode xtraTrig à vitesse max possible  
                     acq_trig_o <= '0';
                     trig_prectrl_sm <= prim_xtra_st;                        
                  end if;                     
                  
               -- mode xtra_trig 1. on y reste tant que  PRIM_XTRA_TRIG_ACTIVE reste à '1'
               when prim_xtra_st => 
                  xtra_trig_o <= '1';    -- permet de lancer le détecteur en mode xtraTrig à vitesse max possible  
                  acq_trig_o <= '0';
                  if fpa_readout_last = '1' and  FPA_READOUT = '0' then --! fin du readout.
                     trig_prectrl_sm <= wait_xtra_img_st;
                  end if;
               
               when wait_xtra_img_st =>  -- je m'assure qu'au moins une image est passée en xtraTrig puis j'attends PRIM_XTRA_TRIG_ACTIVE = '0'              
                  if PRIM_XTRA_TRIG_ACTIVE = '0' and (fpa_readout_last = '1' and  FPA_READOUT = '0') then 
                     trig_prectrl_sm <= second_xtra_st;                        
                  end if;                     
                  
               -- second_xtra_st.
               when second_xtra_st => 
                  if fpa_readout_last = '1' and  FPA_READOUT = '0' then --! fin du readout.
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
