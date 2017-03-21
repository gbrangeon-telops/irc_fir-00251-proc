------------------------------------------------------------------
--!   @file : No Title
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
use work.trig_define.all;

entity trig_conditioner is 
   port (
      ARESET      : in std_logic;
      CLK         : in std_logic;
      PARAM       : in trig_conditioner_type;
      TRIG_IN     : in std_logic;
      ACQ_TRIG    : out std_logic;
      RAW_TRIG    : out std_logic;
      STATUS      : out std_logic_vector (7 downto 0);
      XTRA_TRIG   : out std_logic);
end trig_conditioner;

architecture rtl of trig_conditioner is
   
   type trig_gen_sm_type is (idle, out_on_st, pause_st);
   signal trig_gen_sm            : trig_gen_sm_type;
   signal sreset                 : std_logic;
   signal done                   : std_logic;
   signal cnt                    : unsigned(PARAM.HIGH_TIME'LENGTH-1 downto 0); -- ne pas changer la taille du cnt
   signal cnt_trigout            : unsigned(PARAM.HIGH_TIME'LENGTH-1 downto 0); -- ne pas changer la taille du cnt
   signal acq_window_last        : std_logic;
   signal acq_window_change      : std_logic;
   signal raw_trig_i             : std_logic;
   signal raw_acq_trig_i         : std_logic;
   signal raw_xtra_trig_i        : std_logic;
   signal raw_acq_trig_pipe      : std_logic_vector(2 downto 0);
   signal raw_xtra_trig_pipe     : std_logic_vector(2 downto 0);
   signal acq_trig_i             : std_logic;
   signal xtra_trig_i            : std_logic;
   signal trig_out_i             : std_logic;
   signal Allow_HighTimeChange   : std_logic;
   signal acq_window_i           : std_logic;
   
   -------------
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   
   
begin                                                
   
   --------------------------------------------------
   -- Sortie
   --------------------------------------------------
   RAW_TRIG <= trig_out_i;
   ACQ_TRIG <= acq_trig_i;
   XTRA_TRIG <= xtra_trig_i;                         
   
   --------------------------------------------------
   -- Synchronisation reset
   --------------------------------------------------
   U1: sync_reset
   Port map(
      ARESET   => ARESET,
      SRESET   => sreset,
      CLK   => CLK);                                 
   
   --------------------------------------------------   
   -- Statuts                                        
   --------------------------------------------------
   STATUS(7) <= '0';
   STATUS(6) <= '0';
   STATUS(5) <= '0';
   STATUS(4) <= '0';
   STATUS(3) <= '0';
   STATUS(2) <= '0';
   STATUS(1) <= Allow_HighTimeChange;
   STATUS(0) <= done;
   
   --------------------------------------------------
   -- acq_trig et xtra_trig à l'état raw.            
   --------------------------------------------------
   U2: process(CLK)
   begin
      if rising_edge(CLK) then
         raw_acq_trig_i <= raw_trig_i and acq_window_i;
         raw_xtra_trig_i <= raw_trig_i and not acq_window_i;
         -- pour que le changement de acq_window signifie un retour à idle
         -- afin de regler bug du pull-up ou de DC sur trig externe
         acq_window_last <= PARAM.ACQ_WINDOW;
         acq_window_change <= PARAM.ACQ_WINDOW xor acq_window_last;
      end if;
   end process;
   
   --------------------------------------------------
   -- Trigger activation                             
   --------------------------------------------------
   --ici on regarde le rising_edge, falling_edge etc du trig pour decelencher els intégration sur le fpa local uniquement
   U3: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            acq_trig_i <= '0';
            xtra_trig_i <= '0';
            raw_acq_trig_pipe <= (others =>'0');
            raw_xtra_trig_pipe <= (others =>'0');
            trig_out_i <= '0';
            cnt_trigout <= to_unsigned(0, cnt_trigout'length);
         else
            --la duree du pipe definit la largeur de activation_trig_i
            -- comme il sera envoyé au FPA local qui est dans le domaine ADC_CLK
            -- une durée de 1 ADC_CLK suffit deja
            raw_acq_trig_pipe(0) <= raw_acq_trig_i;
            raw_acq_trig_pipe(1) <= raw_acq_trig_pipe(0);
            raw_acq_trig_pipe(2) <= raw_acq_trig_pipe(1);
            -- pour raison de synchro, même pipe pour raw_xtra_trig_i
            raw_xtra_trig_pipe(0) <= raw_xtra_trig_i;
            raw_xtra_trig_pipe(1) <= raw_xtra_trig_pipe(0);
            raw_xtra_trig_pipe(2) <= raw_xtra_trig_pipe(1);

            acq_trig_i <= raw_acq_trig_i and not raw_acq_trig_pipe(2);
            xtra_trig_i <= raw_xtra_trig_i and not raw_xtra_trig_pipe(2);
            
            -- Trig Out
            if (raw_acq_trig_i = '1' and raw_acq_trig_pipe(2) = '0' and cnt_trigout = to_unsigned(0, cnt_trigout'length)) then -- synchro avec acq_trig_i
               trig_out_i <= '1';
               cnt_trigout <= to_unsigned(1, cnt_trigout'length);
            end if;
            
            if (trig_out_i = '1') then
               if (cnt_trigout >= PARAM.HIGH_TIME) then
                  trig_out_i <= '0';
                  cnt_trigout <= to_unsigned(0, cnt_trigout'length);
               else
                  trig_out_i <= trig_out_i;
                  cnt_trigout <= cnt_trigout + 1;
               end if;
            end if;

         end if;
      end if;
   end process;
   
      ----------------------------------------------------------------------
   -- Machine: trig_gen_sm
   ----------------------------------------------------------------------
   U4: process (CLK)
   begin
      if CLK'event and CLK = '1' then
         if sreset ='1' then	
            done <= '0';
            raw_trig_i <= '0';
            Allow_HighTimeChange <= '1';
            acq_window_i <= '0';
            trig_gen_sm <= idle;
         else
            
            case trig_gen_sm is
               when idle =>
                  raw_trig_i <= '0';
                  Cnt <= to_unsigned(0, cnt'length);
                  done <= '1';
                  Allow_HighTimeChange <= '1';
                  if PARAM.RUN = '1' and TRIG_IN = '1' then	
                     trig_gen_sm <= out_on_st;
                     done <= '0';
                     raw_trig_i <= '1';
                     Allow_HighTimeChange <= '0';                     
                     acq_window_i <= PARAM.ACQ_WINDOW; -- (synchro avec raw_trig_i)
                  end if;  
               
               when out_on_st =>
                  Cnt <= Cnt + 1;
                  if Cnt > raw_acq_trig_pipe'length  or PARAM.RUN = '0' or acq_window_change = '1' then	
                     trig_gen_sm <= pause_st;
                     done <= '1';
                     raw_trig_i <= '0';
                     Allow_HighTimeChange <= '1';
                  end if;
               
               when pause_st =>				-- necessaire pour le single trig.
                  trig_gen_sm <= idle;                 
               
               when others =>
               
            end case;
         end if;
      end if;
   end process;
   
end rtl;
