------------------------------------------------------------------
--!   @file : calcium_int_signal_gen
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
use work.proxy_define.all;
use work.tel2000.all;

entity calcium_int_signal_gen is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      ACQ_TRIG          : in std_logic;
      XTRA_TRIG         : in std_logic;
      PROG_TRIG         : in std_logic; -- xtra_trig suite à une programmation du detecteur
      
      FRAME_ID          : out std_logic_vector(31 downto 0);
      INT_INDX          : out std_logic_vector(7 downto 0);
      INT_TIME          : out std_logic_vector(31 downto 0);    -- c'est le temps d'integration latché pour l'image dont l'id est FRAME_ID. C'est lui qui doit aller dans le header. Ne jamais se fier au temps d'intégration dans FPA_INTF_CFG  
      
      ACQ_INT           : out std_logic;
      FPA_INT           : out std_logic;    -- consigne d'integration envoyée au détecteur
      ACQ_INT_FDBK      : out std_logic;     -- suposé feedback d'integration du ROIC. Ce signal tient compte des informations du fabricant au sujet des timings internes du ROIC. À utiliser uniquement si lesdites infos sont dispo
      
      PERMIT_INT_CHANGE : out std_logic
   );
end calcium_int_signal_gen;


architecture rtl of calcium_int_signal_gen is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;
   
   type int_gen_fsm_type is (idle, int_param_st, check_int_cnt_st, int_delay_st, int_delay2_st, int_gen_st);
   type int_fdbk_fsm_type is (idle, int_fdbk_dly_st, int_fdbk_gen_st);
   
   signal int_gen_fsm               : int_gen_fsm_type;
   signal int_fdbk_fsm              : int_fdbk_fsm_type;
   signal sreset                    : std_logic;
   signal frame_id_i                : unsigned(FRAME_ID'length-1 downto 0);
   signal int_indx_i                : std_logic_vector(INT_INDX'length-1 downto 0);
   signal int_time_i                : unsigned(INT_TIME'length-1 downto 0);
   signal acq_int_i                 : std_logic;
   signal fpa_int_i                 : std_logic;
   signal acq_int_fdbk_i            : std_logic;
   signal permit_int_change_i       : std_logic;
   signal int_cnt                   : unsigned(FPA_INTF_CFG.INT_SIGNAL_HIGH_TIME'length-1 downto 0);
   signal acq_frame                 : std_logic;
   signal int_time_dval             : std_logic;
   signal int_fdbk_dly_cnt          : unsigned(FPA_INTF_CFG.INT_FDBK_DLY'length-1 downto 0);
   signal int_fdbk_cnt              : unsigned(FPA_INTF_CFG.INT_TIME'length-1 downto 0);
   
begin
   
   -- Output mapping
   FRAME_ID <= std_logic_vector(frame_id_i);  -- synchronisé avec ACQ_INT
   INT_INDX <= int_indx_i;                    -- synchronisé avec ACQ_INT
   INT_TIME <= std_logic_vector(int_time_i);  -- synchronisé avec ACQ_INT et FPA_INT
   ACQ_INT <= acq_int_i;                      -- acq_int_i n'existe pas en extraTrig. De plus il signale à coup sûr une integration. Ainsi toute donnée de detecteur ne faisant pas suite à acq_trig, provient de extra_trig
   FPA_INT <= fpa_int_i;                      -- fpa_int_i existe pour toute integration (que l'image soit à envoyer dans la chaine ou non)
   ACQ_INT_FDBK <= acq_int_fdbk_i;
   PERMIT_INT_CHANGE <= permit_int_change_i;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------   
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
   );   
   
   ---------------------------------------------------
   -- Integration signal and info generation
   ---------------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            int_gen_fsm <= idle;
            acq_int_i <= '0';
            frame_id_i <= (others => '0');
            acq_frame <= '0';
            permit_int_change_i <= '0';
            fpa_int_i <= '0';
            int_time_dval <= '0';
            
         else
            
            case int_gen_fsm is
               
               when idle =>
                  acq_frame <= '0';
                  acq_int_i <= '0';
                  fpa_int_i <= '0';
                  int_time_dval <= '0';
                  permit_int_change_i <= not ACQ_TRIG and not XTRA_TRIG and not PROG_TRIG;
                  if ACQ_TRIG = '1' then        -- ACQ_TRIG uniquement car ne jamais envoyer acq_int_i en mode XTRA_TRIG
                     acq_frame <= '1';
                     int_gen_fsm <= int_param_st;
                  end if;
                  if XTRA_TRIG = '1' then
                     acq_frame <= '0';
                     int_gen_fsm <= int_param_st;
                  end if;
                  if PROG_TRIG = '1' then
                     acq_frame <= '0';
                     int_gen_fsm <= int_param_st;
                  end if;
               
               when int_param_st =>          -- pour ameliorer timings et aussi pour sortir les données avant le signal de validation qu'est acq_int.
                  if acq_frame = '1' then
                     frame_id_i <= frame_id_i + 1;   -- on ne change pas d'ID en xtraTrig pour que le client ne voit aucune discontinuité dans les ID
                  end if;
                  int_indx_i <= resize(FPA_INTF_CFG.INT_INDX, int_indx_i'length);
                  int_time_i <= resize(FPA_INTF_CFG.INT_TIME, int_time_i'length);
                  int_cnt <= resize(FPA_INTF_CFG.INT_SIGNAL_HIGH_TIME, int_cnt'length);
                  int_gen_fsm <= check_int_cnt_st;
               
               when check_int_cnt_st =>
                  if int_cnt = 0 then
                     int_cnt <= to_unsigned(1, int_cnt'length);
                  end if;
                  int_time_dval <= '1';
                  int_gen_fsm <= int_delay_st;
               
               when int_delay_st =>
                  int_time_dval <= '0';
                  int_gen_fsm <= int_delay2_st;
               
               when int_delay2_st =>
                  int_gen_fsm <= int_gen_st;
               
               when int_gen_st =>
                  int_time_dval <= '0';
                  fpa_int_i <= '1';          -- le module digio_intf decidera s'il faille l'envoyer au detecteur ou pas
                  acq_int_i <= acq_frame;
                  int_cnt <= int_cnt - 1;
                  if int_cnt = 0 then        -- INT_SIGNAL_HIGH_TIME est la durée pendant laquelle lever le signal d'integration pour avoir le temps d'integration souhaité. Il depend des offsets de temps d'integration
                     fpa_int_i <= '0';
                     acq_int_i <= '0';
                     int_gen_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
      
   ---------------------------------------------------
   -- Integration feedback generation
   ---------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            int_fdbk_fsm <= idle;
            acq_int_fdbk_i <= '0';
            
         else
            
            case int_fdbk_fsm is
               
               when idle =>
                  acq_int_fdbk_i <= '0';
                  -- feedback for an ACQ_TRIG only
                  if int_time_dval = '1' and acq_frame = '1' then         -- int_time_dval is 3 CLK ahead of FPA_INT
                     int_fdbk_cnt <= resize(int_time_i, int_fdbk_cnt'length);
                     int_fdbk_dly_cnt <= resize(FPA_INTF_CFG.INT_FDBK_DLY, int_fdbk_dly_cnt'length);
                     int_fdbk_fsm <= int_fdbk_dly_st;
                  end if;
               
               when int_fdbk_dly_st =>
                  int_fdbk_dly_cnt <= int_fdbk_dly_cnt - 1;
                  if int_fdbk_dly_cnt = 0 then
                     int_fdbk_fsm <= int_fdbk_gen_st;
                  end if;
               
               when int_fdbk_gen_st =>
                  acq_int_fdbk_i <= '1';
                  int_fdbk_cnt <= int_fdbk_cnt - 1;
                  if int_fdbk_cnt = 0 then
                     acq_int_fdbk_i <= '0';
                     int_fdbk_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
end rtl;
