-------------------------------------------------------------------------------
--
-- Title       : ICU_SM
-- Author      : Simon Savary
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $CALIBision: 14833 $ 
-------------------------------------------------------------------------------
--
-- Description : This file implements the state machine for the 
-- internal calibration unit (ICU)
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;

entity ICU_SM is
   port(     
      PULSE_WIDTH         : in std_logic_vector(31 downto 0); -- [CLK ticks]
      PERIOD              : in std_logic_vector(31 downto 0); -- [CLK ticks]
      TRANSITION_DURATION : in std_logic_vector(31 downto 0); -- [CLK ticks]
      CMD                 : in std_logic_vector(1 downto 0); -- "00", OFF "01", SCENE, "10" CALIB
      MODE                : in std_logic_vector(1 downto 0);  -- "00" ONE-SHOT, "01" REPEAT
      CALIB_POLARITY      : in std_logic; -- '0' forward, '1' reverse
      
      POSITION              : out std_logic_vector(1 downto 0); -- "00", off, "01" SCENE, "10" CALIB, "11" moving
      
      NEW_CONFIG : in std_logic;
      
      -- H-bridge control
      IN_A                : out std_logic;
      IN_B                : out std_logic;
      
      ARESETn          : in  std_logic;
      CLK             : in  std_logic
      );
end ICU_SM;

architecture RTL of ICU_SM is
   
   constant ONE_MSEC_CLK_TICKS : integer range 0 to (2**31)-1 := 100000; -- number of CLK ticks in 1 ms
         
   component sync_resetn is
      port(
         ARESETn : in STD_LOGIC;
         SRESETn : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;
   
   component gh_PWM 
      generic(
         size : INTEGER := 8
         );
      port(
         clk      : in STD_LOGIC;
         rst      : in STD_LOGIC;
         d_format : in STD_LOGIC:='0'; -- '0' = two's comp   '1' = offset binary
         DATA     : in STD_LOGIC_VECTOR(size-1 downto 0);
         PWMo     : out STD_LOGIC;
         ND       : out STD_LOGIC -- New Data sample strobe
         );
   end component;
   
   signal sreset : std_logic;
   signal sresetn : std_logic;
   
   signal pulse_width_1p         : std_logic_vector(PULSE_WIDTH'length-1 downto 0);
   signal period_1p              : std_logic_vector(PERIOD'length-1 downto 0);
   signal transition_duration_1p : std_logic_vector(TRANSITION_DURATION'length-1 downto 0);
   signal cmd_1p                 : std_logic_vector(CMD'length-1 downto 0);
   signal mode_1p                : std_logic_vector(MODE'length-1 downto 0);
   signal polarity_1p            : std_logic;
   signal new_config_1p          : std_logic;
   
   signal pulse_width_hold         : std_logic_vector(PULSE_WIDTH'length-1 downto 0);
   signal period_hold              : std_logic_vector(PERIOD'length-1 downto 0);
   signal transition_duration_hold : std_logic_vector(TRANSITION_DURATION'length-1 downto 0);
   signal cmd_hold                 : std_logic_vector(CMD'length-1 downto 0);
   signal mode_hold                : std_logic_vector(MODE'length-1 downto 0);
   signal polarity_hold            : std_logic;
   
   signal position_out : std_logic_vector(POSITION'length-1 downto 0);
   
   signal new_cmd : std_logic;
   
   signal in_a_out : std_logic;
   signal in_b_out : std_logic;
   
   signal pulse : std_logic;
   signal in_transition : std_logic;
   signal issue_move : std_logic;
   
   TYPE state_type is (CFG, OFF, SCENE, CALIB, MOVE, MOVING);
   TYPE ostate_type is (HB_OFF, HB_SCENE, HB_CALIB);
   signal state : state_type; -- state of the controller
   signal ostate : ostate_type; -- state of the pin output to H-bridge
   
   constant CMD_SCENE : std_logic_vector(CMD'length-1 downto 0) := "01";
   constant CMD_CALIB : std_logic_vector(CMD'length-1 downto 0) := "10";
   constant CMD_OFF : std_logic_vector(CMD'length-1 downto 0) := "00";
   
   constant POSITION_OFF : std_logic_vector(CMD'length-1 downto 0) := "00";
   constant POSITION_SCENE : std_logic_vector(CMD'length-1 downto 0) := "01";
   constant POSITION_CALIB : std_logic_vector(CMD'length-1 downto 0) := "10";
   constant POSITION_MOV : std_logic_vector(CMD'length-1 downto 0) := "11";
   
   constant counters_length : integer := 32;
   constant counters_max : unsigned(counters_length-1 downto 0) := (others => '1');
   signal period_cnt : unsigned(counters_length-1 downto 0) := (others => '0'); -- counter [ms] for the repeat period
   signal in_transition_cnt : unsigned(counters_length-1 downto 0) := (others => '0'); -- counter [ms] for the transi
   signal PULSE_CNT_MAX_s : unsigned(counters_length-1 downto 0);
   signal TRANSITION_CNT_MAX_s : unsigned(counters_length-1 downto 0);
   
begin
   
   POSITION <= position_out;
   IN_A <= in_a_out;
   IN_B <= in_b_out;
   
   sreset <= not sresetn;
   
   U0A : sync_resetn port map(ARESETn => ARESETn, SRESETn => sresetn, CLK => CLK);
   
   hold_inputs : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            pulse_width_1p <= (others => '0');
            period_1p <= (others => '0');
            transition_duration_1p <= (others => '0');
            cmd_1p <= (others => '0');
            mode_1p <= (others => '0');
            polarity_1p <= '0';
            new_config_1p <= '0';
            
            pulse_width_hold <= (others => '0');
            period_hold <= (others => '0');
            transition_duration_hold <= (others => '0');
            cmd_hold <= (others => '0');
            mode_hold <= (others => '0');
            polarity_hold <= '0';
         else
            pulse_width_1p <= PULSE_WIDTH;
            period_1p <= PERIOD;
            transition_duration_1p <= TRANSITION_DURATION;
            cmd_1p <= CMD;
            mode_1p <= MODE;
            polarity_1p <= CALIB_POLARITY;
            new_config_1p <= NEW_CONFIG;
            
            if new_config_1p = '1' then
               cmd_hold <= cmd_1p;
               pulse_width_hold <= pulse_width_1p;
               transition_duration_hold <= transition_duration_1p;
               mode_hold <= mode_1p;
               period_hold <= period_1p;
               polarity_hold <= polarity_1p;
            end if;
         end if;
      end if;
   end process;
   
   ICU_SM : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            new_cmd <= '0';
            state <= OFF;
            issue_move <= '0';
            position_out <= (others => '0');
         else
            
            case state is
               when CFG => 
                  position_out <= POSITION_OFF;
                  issue_move <= '0';
                  state <= OFF;     
                  ostate <= HB_OFF;
               
               when OFF => 
                  
                  case cmd_hold is 
                     when CMD_SCENE => 
                        state <= MOVE; 
                        issue_move <= '1';
                        position_out <= POSITION_MOV;
                        ostate <= HB_SCENE;
                     
                     when CMD_CALIB => 
                        state <= MOVE; 
                        issue_move <= '1';
                        position_out <= POSITION_MOV;
                        ostate <= HB_CALIB;
                     
                     when others => 
                        state <= OFF; 
                        issue_move <= '0';
                        position_out <= POSITION_OFF;
                        ostate <= HB_OFF;
                     
                  end case;
               
               when SCENE =>
                  if cmd_hold = CMD_CALIB then
                     state <= MOVE;
                     issue_move <= '1';
                     position_out <= POSITION_MOV;
                     ostate <= HB_CALIB;
                  elsif cmd_hold = CMD_OFF then
                     state <= OFF;
                     issue_move <= '0';
                     position_out <= POSITION_OFF;
                     ostate <= HB_OFF;
                  else
                     state <= SCENE;
                     issue_move <= '0';
                     position_out <= POSITION_SCENE;
                     ostate <= HB_SCENE;
                  end if;
               
               when CALIB =>
                  if cmd_hold = CMD_SCENE then
                     state <= MOVE;
                     issue_move <= '1';
                     position_out <= POSITION_MOV;
                     ostate <= HB_SCENE;
                  elsif cmd_hold = CMD_OFF then
                     state <= OFF;
                     issue_move <= '0';
                     position_out <= POSITION_OFF;
                     ostate <= HB_OFF;
                  else
                     state <= CALIB;
                     issue_move <= '0';
                     position_out <= POSITION_CALIB;
                     ostate <= HB_CALIB;
                  end if;
               
               when MOVE =>
                  state <= MOVING;
                  issue_move <= '0';
                  position_out <= POSITION_MOV;
               
               when MOVING =>
                  if new_config_1p = '1' then
                     state <= OFF;
                     issue_move <= '0';
                     position_out <= POSITION_OFF;
                     ostate <= HB_OFF;
                  else
                     if in_transition = '0' then
                        issue_move <= '0';
                        if cmd_hold = CMD_SCENE then
                           state <= SCENE;
                           position_out <= POSITION_SCENE;
                        elsif cmd_hold = CMD_OFF then
                           state <= OFF;
                           position_out <= POSITION_OFF;
                           ostate <= HB_OFF;
                        elsif cmd_hold = CMD_CALIB then
                           state <= CALIB;
                           position_out <= POSITION_CALIB;
                        end if;
                     else
                        position_out <= POSITION_MOV;
                     end if;
                  end if;
               
               when others => 
                  state <= OFF;
                  position_out <= POSITION_OFF;
                  issue_move <= '0';
                  ostate <= HB_OFF;
               
            end case;
            
         end if;
      end if;
   end process;
   
   -- generate a pulse of width PULSE_WIDTH and length PERIOD
   pulse_gen : process(CLK)
      variable PERIOD_CNT_MAX : unsigned(counters_length-1 downto 0);
      
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            period_cnt <= (others => '0');
            in_transition_cnt <= (others => '1');
         else
            PERIOD_CNT_MAX := unsigned(std_logic_vector(to_unsigned(0,PERIOD_CNT_MAX'length-period_hold'length)) & period_hold);

            if period_cnt /= counters_max then
               period_cnt <= period_cnt + 1;
            end if;
            
            if in_transition_cnt /= counters_max then
               in_transition_cnt <= in_transition_cnt + 1;
            end if;
            
            if issue_move = '1' then
               -- restart the pulse only if mode is ONE_SHOT
               if mode_hold = "00" then
                  period_cnt <= (others => '0');
               end if;
               in_transition_cnt <= (others => '0');
            end if;
            
            -- only restart a period when mode is set to REPEAT
            if period_cnt >= PERIOD_CNT_MAX-1 and mode_hold = "01" then
               period_cnt <= (others => '0');
            end if;
            
         end if;
      end if;
   end process;
   
   PULSE_CNT_MAX_s <= unsigned(std_logic_vector(to_unsigned(0,PULSE_CNT_MAX_s'length-pulse_width_hold'length)) & pulse_width_hold);
   TRANSITION_CNT_MAX_s <= unsigned(std_logic_vector(to_unsigned(0,TRANSITION_CNT_MAX_s'length-transition_duration_hold'length)) & transition_duration_hold);
   pulse <= '1' when period_cnt < PULSE_CNT_MAX_s else '0';
   in_transition <= '1' when in_transition_cnt < TRANSITION_CNT_MAX_s else '0';
   
   -- manage the H-bridge state actions
   outputs: process(ostate,pulse,polarity_hold)
   begin
      case ostate is
         when HB_OFF => 
            in_a_out <= '0';
            in_b_out <= '0';
         
         when HB_SCENE => 
            in_a_out <= polarity_hold and pulse;
            in_b_out <= not polarity_hold and pulse;
         
         when HB_CALIB => 
            in_a_out <= not polarity_hold and pulse;
            in_b_out <= polarity_hold and pulse;
         
         when others => 
            in_a_out <= '0';
            in_b_out <= '0';
         
      end case;
   end process;
   
end RTL;
