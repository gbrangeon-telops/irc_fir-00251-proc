---------------------------------------------------------------------------------------------------
--  Copyright (c) Telops Inc. 2007
--
--  File: FW_Decoder.vhd
--  Use: Decoding of Filter wheel quadrature signals into position, velocity and direction
--  By: Olivier Bourgois
--
--  $Revision$
--  $Author$
--  $LastChangedDate$
---------------------------------------------------------------------------------------------------
library ieee;
library common_hdl;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity fw_decoder is
   generic(
      CLOCK_FREQUENCY      : integer := 100_000_000;
      ZERO_PHASE           : std_logic_vector(1 downto 0) := "00";
      SPEED_PRECISION_BIT  : integer := 4                                  -- Number of bits added to increase precision to the RPM
   );
   port(
      CLK      : in std_logic;                                             -- System clock
      ARESETN   : in std_logic;                                             -- System async reset
      CHAN_A   : in std_logic;                                             -- Channel A quadrature signal
      CHAN_B   : in std_logic;                                             -- Channel B quadrature signal
      CHAN_I   : in std_logic;                                             -- Channel I zero signal
      NB_ENCODER_COUNTS : in std_logic_vector(15 downto 0);
      RPM_FACTOR        : in std_logic_vector(31 downto 0);
      LOCK     : out std_logic;                                            -- Goes low on reset, goes high once wheel is synced
      POS      : out std_logic_vector(15 downto 0);                        -- Absolute wheel position
      DIR      : out std_logic;
      RPM_MEAS : out std_logic_vector(15+SPEED_PRECISION_BIT  downto 0);    -- wheel velocity in RPM (signed value)
      INDEX_MODE : in std_logic                                           -- 0 - Encoder index, 1- Optoswitch 
      );
end entity fw_decoder;

architecture rtl of fw_decoder is
   
   -- for resyncing reset locally
   component sync_resetn is
      port(
         ARESETN : in std_logic;
         SRESETN : out std_logic;
         CLK    : in std_logic);
   end component;
   
   -- encoder states channels I-A-B
   constant PHASE0 : std_logic_vector(1 downto 0) := "00";
   constant PHASE1 : std_logic_vector(1 downto 0) := "01";
   constant PHASE2 : std_logic_vector(1 downto 0) := "11";
   constant PHASE3 : std_logic_vector(1 downto 0) := "10";
   
   -- Fix the previous and next phase value after a phase at ZERO
   signal NEXT_ZERO_PHASE : std_logic_vector(1 downto 0);
   signal PREV_ZERO_PHASE : std_logic_vector(1 downto 0);

   
   constant ENCODER_COUNTS_MAX_BIT : integer := 13; 
   constant ENCODER_COUNTS_MIN_BIT : integer := 8;
   
   type homing_mode_t is (Encoder, Optoswitch);
   signal homing_mode : homing_mode_t :=  Encoder;
   
   
   
   
   signal pos_i  : unsigned(ENCODER_COUNTS_MAX_BIT-1 downto 0);
   signal sresetn : std_logic;
   signal dir_i  : std_logic;
   signal rpm_i  : std_logic_vector(RPM_MEAS'range);
   signal lock_i  : std_logic;
   signal enc_state : std_logic_vector(2 downto 0);   
   signal enc_nxstate : std_logic_vector(2 downto 0);
   signal a_pipe : std_logic_vector(1 downto 0);
   signal b_pipe : std_logic_vector(1 downto 0);
   signal i_pipe : std_logic_vector(1 downto 0);
   signal zeros_next_transition : std_logic := '0';
   
begin
   
   -- output mapping
   POS      <= std_logic_vector(resize(pos_i,POS'length));
   DIR      <= dir_i;
   LOCK     <= lock_i;
   RPM_MEAS <= rpm_i;
   
   -- Fix the previous and next phase value after a phase at ZERO
   NEXT_ZERO_PHASE <= PHASE1 when ZERO_PHASE = PHASE0 else
      PHASE2 when ZERO_PHASE = PHASE1 else
      PHASE3 when ZERO_PHASE = PHASE2 else
      PHASE0 when ZERO_PHASE = PHASE3;
      
   PREV_ZERO_PHASE <= PHASE3 when ZERO_PHASE = PHASE0 else
      PHASE0 when ZERO_PHASE = PHASE1 else
      PHASE1 when ZERO_PHASE = PHASE2 else
      PHASE2 when ZERO_PHASE = PHASE3;
      
      
   --Select the homing mode
   homing_mode <=  Encoder when INDEX_MODE = '0' else Optoswitch;
   
   -- process to determine direction and position from quadrature channels

   pos_dir : process(CLK)
      variable increment_pos : std_logic_vector(1 downto 0);  
   begin
      if (CLK'event and CLK = '1') then
         if sresetn = '0' then
            dir_i <= '0';
            pos_i <= (others => '0');
            enc_state   <= '0' & PHASE0;
            enc_nxstate <= '0' & PHASE0;
            lock_i <= '0';
            zeros_next_transition <= '0';
         else
            -- Check Movement direction
--            if (enc_nxstate(1 downto 0) = ZERO_PHASE) then
--               if enc_state(1 downto 0) = PREV_ZERO_PHASE then
--                  dir_i <= '0';  
--               elsif enc_state(1 downto 0) = NEXT_ZERO_PHASE then
--                  dir_i <= '1';             
--               end if;
--            end if;
--


-- Homming in Encoder Mode
            if enc_state = ('1' & ZERO_PHASE) and homing_mode = Encoder then
               lock_i <= '1'; -- we are in sync once we reach the ZERO state
               
               -- this is the zeroing state
               if enc_nxstate(1 downto 0) = NEXT_ZERO_PHASE then
                  pos_i <= pos_i + to_unsigned(1,pos_i'length);   
               elsif enc_nxstate(1 downto 0) = PREV_ZERO_PHASE then
                  pos_i <= unsigned(NB_ENCODER_COUNTS(pos_i'range)) - 1;  
               end if;                         
               
              
            elsif enc_nxstate = ('1' & ZERO_PHASE) and homing_mode = Encoder  then  
               pos_i <= (others => '0');

-- Homming in Optoswitch Mode
               -- ADD a condition based on the type of index(Encoder or Optoswitch)  OK
               -- IF using optoswitch  reset position on Index and lock the reset process
               -- First next position phase is position 0
               -- Then increment on each phase.
               -- Reset position counter on the next phase transition after the index rising edge.
            elsif enc_nxstate(2) = '1'  and homing_mode = Optoswitch then   
                zeros_next_transition <= '1';   
            
            elsif zeros_next_transition = '1'  and enc_nxstate(1 downto 0) /= enc_state(1 downto 0) and homing_mode = Optoswitch then
                pos_i <= (others => '0');
                zeros_next_transition <= '0';
                lock_i <= '1'; -- we are in sync once we reach the transition state
            else
            
               increment_pos := "00";
               
               case enc_state(1 downto 0) is
                  
                  when PHASE0 =>
                     if enc_nxstate(1 downto 0) = PHASE1 then
                        dir_i <= '0';
                        increment_pos := "01";     
                     elsif enc_nxstate(1 downto 0) = PHASE3 then
                        dir_i <= '1';
                        increment_pos := "11";
                     end if;
                     
                     
                  when PHASE1 =>
                     if enc_nxstate(1 downto 0) = PHASE2 then
                        dir_i <= '0';
                        increment_pos := "01";
                     elsif enc_nxstate(1 downto 0) = PHASE0 then
                        dir_i <= '1';
                        increment_pos := "11";       
                     end if;
                     
                  when PHASE2 =>
                     if enc_nxstate(1 downto 0) = PHASE3 then
                        dir_i <= '0';
                        increment_pos := "01";        
                     elsif enc_nxstate(1 downto 0) = PHASE1 then
                        dir_i <= '1';
                        increment_pos := "11";       
                     end if;
                     
                  when PHASE3 =>
                     if enc_nxstate(1 downto 0) = PHASE0 then
                        dir_i <= '0';
                        increment_pos := "01";       
                     elsif enc_nxstate(1 downto 0) = PHASE2 then
                        dir_i <= '1';
                        increment_pos := "11";        
                     end if;
                     
                  when others => null;
                  
               end case;
               
               if increment_pos = "01" then
                  if pos_i = unsigned(NB_ENCODER_COUNTS(pos_i'range)) - 1 then
                     pos_i <= (others => '0');
                  else
                     pos_i <= pos_i + to_unsigned(1,pos_i'length);
                  end if;
               elsif increment_pos = "11" then
                  if pos_i = to_unsigned(0, pos_i'length) then
                     pos_i <= unsigned(NB_ENCODER_COUNTS(pos_i'range)) - 1;
                  else
                     pos_i <= pos_i - to_unsigned(1,pos_i'length);
                  end if;    
               end if;
               
            end if;
         
            -- state signals
            enc_nxstate <= i_pipe(0) & a_pipe(0) & b_pipe(0);
            enc_state <= enc_nxstate;
            
         end if;
             
         -- double sync encoder signals
         a_pipe(0) <= a_pipe(1);
         a_pipe(1) <= CHAN_B;
         b_pipe(0) <= b_pipe(1);
         b_pipe(1) <= CHAN_A;
         
         if(homing_mode = Encoder) then
            i_pipe(0) <= i_pipe(1);
            i_pipe(1) <= CHAN_I;
         elsif(homing_mode = Optoswitch) then
            i_pipe(0) <= not i_pipe(1) and CHAN_I;
            i_pipe(1) <= CHAN_I; 
         end if;
         
      end if;
   end process pos_dir;

   -- process to calculate the wheel velocity in Hz
calc_velocity : process(CLK)

    constant TIMER_NUMBITS : integer := integer(ceil(LOG2( real(2**SPEED_PRECISION_BIT) * real(CLOCK_FREQUENCY) * 60.0 / (2**( real(ENCODER_COUNTS_MIN_BIT) ) ) ) + 1.0));
    variable timer  : unsigned(TIMER_NUMBITS+SPEED_PRECISION_BIT-1 downto 0); 
    -- Number of encoder counts since the start of the timer
    variable phases         : unsigned(RPM_MEAS'length-2 downto 0); -- Additionnal -1 for the sign
    
begin
    if (CLK'event and CLK = '1') then
        if sresetn = '0' then
            rpm_i <= (others => '0');
            timer := (others => '0');
            phases := (others => '0');
        else
            if timer = resize(unsigned(RPM_FACTOR) & to_unsigned(0,SPEED_PRECISION_BIT),timer'length)   then
                if dir_i = '0' then
                    rpm_i <= std_logic_vector('0' & phases);
                else
                    rpm_i <= std_logic_vector(-signed('0' & phases));
                end if;
                timer := (others => '0');
                phases := (others => '0');
            else
                timer := timer + 1; -- increment the timer
                if enc_nxstate /= enc_state then
                    phases := phases + 1;
                end if;
            end if;
        end if;
    end if;
end process calc_velocity;
   
reset_synchronize : sync_resetn
port map(
    ARESETN => ARESETN,
    SRESETN => sresetn,
    CLK    => CLK);
   
end rtl;
