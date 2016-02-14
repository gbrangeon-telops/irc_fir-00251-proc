-------------------------------------------------------------------------------
--
-- Title       : SFW_Ctrl
-- Author      : Julien Roy
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;
use work.sfw_define.all;


entity SFW_Processing is
   generic(
      SPEED_PRECISION_BIT  : integer := 4       -- Number of bits added to increase precision to the RPM
      );
   port(
      --------------------------------
      -- MB Interface
      --------------------------------
        MIN_POSITIONS   : in position_array_t;
        MAX_POSITIONS   : in position_array_t;
        WHEEL_STATE     : in STD_LOGIC_VECTOR(1 downto 0);
        POSITION_SETPOINT   : in STD_LOGIC_VECTOR(7 downto 0);
        RPM_MAX         : in STD_LOGIC_VECTOR(15 downto 0);
        CLEAR_ERR       : in STD_LOGIC;       
        VALID_PARAM     : in STD_LOGIC;
        
        FILTER_NUM_LOCKED   :out STD_LOGIC;
        ERROR_SPD : out  STD_LOGIC;

      --------------------------------
      -- SFW Encoder Interface
      --------------------------------
      LOCKED            : in  std_logic;
      POSITION          : in  std_logic_vector(15 downto 0);
      DIR               : in  std_logic;
      RPM               : in  std_logic_vector(15+SPEED_PRECISION_BIT downto 0);
      --------------------------------
      -- Header Data
      --------------------------------
      INTEGRATION             : in  std_logic;
      RISING_POSITION         : out std_logic_vector(15 downto 0);   -- encoder position at when INTEGRATION rises
      FALLING_POSITION        : out std_logic_vector(15 downto 0);   -- encoder position at when INTEGRATION falls
      ACQ_FILTER_NUMBER       : out std_logic_vector(7 downto 0);    -- Number of the filter (if valid) after the integration is done
      CURRENT_FILTER_NUMBER   : out std_logic_vector(7 downto 0);    -- Number of the filter in front of the lens
      NEXT_FILTER_NUMBER      : out std_logic_vector(7 downto 0);    -- Number of the next filter in front of the lens
      --------------------------------
      -- Trigger
      --------------------------------
      SYNC_TRIG         : out std_logic;  -- Assert SYNC_TRIG when a new filter is valid in front of the lens

      --------------------------------
      -- Misc
      --------------------------------   
      CLK               : in  std_logic;
      ARESETN            : in  std_logic
      );
end SFW_Processing;


architecture RTL of SFW_Processing is
   -- Component declaration
    component sync_resetn
      port(
         ARESETN                 : in std_logic;
         SRESETN                 : out std_logic;
         CLK                    : in std_logic);
    end component;
   
    component double_sync
    generic(
        INIT_VALUE : bit := '0'
    );
    port(
        D : in STD_LOGIC;
        Q : out STD_LOGIC := '0';
        RESET : in STD_LOGIC;
        CLK : in STD_LOGIC
    );
    end component;

   -- Signals
   signal sresetn               : std_logic;

   -- Array containing min and max positions for each filter
   signal minimal_positions   : position_array_t;
   signal maximal_positions   : position_array_t;
   
   signal valid_parameters    : std_logic; -- Tells if filter positions are valid 

   signal wheel_state_i         : std_logic_vector(1 downto 0);
   signal position_setpoint_i   : std_logic_vector(7 downto 0);
   
   signal next_filter_number_i      : unsigned(2 downto 0); 
   signal current_filter_number_i   : unsigned(2 downto 0); 
   signal valid_filter              : std_logic; -- Is asserted when a filter is at a valid position
   signal valid_filter_q1           : std_logic;
   signal next_position_invalid     : std_logic; -- Is asserted when maximal filter position is reached
   signal valid_integration         : std_logic; -- Is asserted when the rising of INTEGRATION is done on valid filter
   signal filter_number_locked      : std_logic; -- Is asserted when the current filter position correspond to the good one

   signal integration_i      : std_logic;
   signal integration_r1      : std_logic;
   
   signal clear_errors        : std_logic;   -- reset the error flags when clear_errors is asserted
   signal error_speed         : std_logic;   -- error flag asserted when speed > MAX_RPM
   

   signal rpm_max_i             : std_logic_vector(15 downto 0); -- The maximum speed before error flag is rised
   signal position_i          : std_logic_vector(15 downto 0); -- actual position

 
begin
   ----------------------------------------
   -- CLK
   ----------------------------------------
   sreset_ctrl_gen : sync_resetN
   port map(
      ARESETN => ARESETN,
      CLK    => CLK,
      SRESETN => sresetn
      );
   --integration_i <= INTEGRATION;
   doube_sync_gen : double_sync port map( D => INTEGRATION, Q => integration_i, RESET => sresetn , CLK => CLK );
   
   --------------------------
   -- input signal
   --------------------------
   minimal_positions    <=  MIN_POSITIONS;  
   maximal_positions    <=  MAX_POSITIONS;
   wheel_state_i        <= WHEEL_STATE;
   position_setpoint_i  <= POSITION_SETPOINT;
   rpm_max_i        <= RPM_MAX;
   clear_errors     <= CLEAR_ERR;
   valid_parameters <= VALID_PARAM;
   
   --------------------------
   -- output signal
   --------------------------
   FILTER_NUM_LOCKED <= filter_number_locked;
   ERROR_SPD <= error_speed;
   
   --------------------------
   -- SFW CONTROLLER
   --------------------------
   
   CURRENT_FILTER_NUMBER   <= std_logic_vector(resize(current_filter_number_i,CURRENT_FILTER_NUMBER'length))   when wheel_state_i = ROTATING_WHEEL
                        else  position_setpoint_i;
   NEXT_FILTER_NUMBER      <= std_logic_vector(resize(next_filter_number_i,NEXT_FILTER_NUMBER'length))         when wheel_state_i = ROTATING_WHEEL
                        else  position_setpoint_i;
   
   integration_process : process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if sresetn = '0' then
            integration_r1    <= '0';
            RISING_POSITION   <= (others => '0');
            FALLING_POSITION  <= (others => '0');
            ACQ_FILTER_NUMBER <= X"09";
            valid_integration      <= '0';
            
         else
            integration_r1 <= integration_i;
            
            if integration_r1 = '0' and integration_i = '1' then
               -- If integration_i become high, latch the POSITION and verify is the filter is valid
               RISING_POSITION      <= POSITION;
               valid_integration    <= valid_filter;

            elsif integration_i = '1' then
               -- During integration, verify that the filter is still valid
               valid_integration    <= valid_integration and valid_filter;
               
            elsif integration_r1 = '1' and integration_i = '0' then
               -- If integration_i become low, latch the POSITION and verify is the filter is valid
               FALLING_POSITION  <= POSITION;
               if wheel_state_i /= NOT_IMPLEMENTED then
                  -- Verify that RISING_POSITION and FALLING_POSITION are in a filter range 
                  -- "and (not next_position_invalid or next_filter_ends)" has been added to the condition because valid_filter has a lentency of 1 clock cycle
                  --if valid_filter = '1' and valid_integration = '1' and (next_position_invalid = '0') then
                  if valid_filter = '1' and valid_integration = '1' then
                     ACQ_FILTER_NUMBER <= std_logic_vector(resize(current_filter_number_i,CURRENT_FILTER_NUMBER'length));
                  else
                     -- ACQ_FILTER_NUMBER must be set to 8 when the integration isn't done during a valid filter range
                     -- This will put the tag in the  image header : SFW "In Transition"
                     ACQ_FILTER_NUMBER <= std_logic_vector(to_unsigned(8,ACQ_FILTER_NUMBER'length));
                  end if;
               else
                  ACQ_FILTER_NUMBER <= std_logic_vector(to_unsigned(0,ACQ_FILTER_NUMBER'length));
               end if;
            end if;
            
         end if;
      end if;
   end process integration_process;
   

      
   next_filter_number_i    <= 
      current_filter_number_i + 1 when DIR = '0' else
      current_filter_number_i - 1;
   
   -- Generate TRIG, the filter number and valid_filter
   filter_process : process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if sresetn = '0' then
            filter_number_locked    <= '0';        
            SYNC_TRIG      <= '0';
            next_position_invalid   <= '0';
         else
            SYNC_TRIG <= '0';
            if LOCKED = '1' and valid_parameters = '1' then
               if valid_filter = '1' then
                  filter_number_locked    <= '1';
               
                  if valid_filter_q1 = '0' then
                     SYNC_TRIG               <= '1';
                  else
                     SYNC_TRIG               <= '0';
                  end if;
                  next_position_invalid   <= '0';
               else
                  next_position_invalid   <= '1';               
               end if;
            end if;
            
         end if;
         
      end if; 
   end process filter_process;
   
   --------------------------
   -- Error verifications
   --------------------------
   
   -- Verify that the speed do not exceed a certain limit
   verify_velocity : process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if sresetn = '0' then
            error_speed <= '0';      
         else
            if clear_errors = '1' then
               error_speed <= '0'; 
               
            elsif abs(signed(RPM(15+SPEED_PRECISION_BIT downto SPEED_PRECISION_BIT))) > signed(rpm_max_i) then
               error_speed <= '1'; 
               
            end if; 
         end if;
      end if;
   end process verify_velocity;

   process(CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            valid_filter <= '0';
            valid_filter_q1 <= '0';
            current_filter_number_i <= to_unsigned(0,current_filter_number_i'length);
            position_i <= POSITION;
         else
            position_i <= POSITION;
            valid_filter_q1 <= valid_filter;
            valid_filter <= '0';
            current_filter_number_i <= current_filter_number_i;
            
            -- FILTER 0
            if(minimal_positions(0) < maximal_positions(0)) then
               if position_i >= minimal_positions(0) and  position_i <= maximal_positions(0) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(0,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(0) or  position_i <= maximal_positions(0) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(0,current_filter_number_i'length);
               end if;
            end if;
            
            -- FILTER 1
            if(minimal_positions(1) < maximal_positions(1)) then
               if position_i >= minimal_positions(1) and  position_i <= maximal_positions(1) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(1,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(1) or  position_i <= maximal_positions(1) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(1,current_filter_number_i'length);
               end if;
            end if;
            
            -- FILTER 2
            if(minimal_positions(2) < maximal_positions(2)) then
               if position_i >= minimal_positions(2) and  position_i <= maximal_positions(2) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(2,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(2) or  position_i <= maximal_positions(2) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(2,current_filter_number_i'length);
                end if;
           end if;
            
            -- FILTER 3
            if(minimal_positions(3) < maximal_positions(3)) then
               if position_i >= minimal_positions(3) and  position_i <= maximal_positions(3) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(3,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(3) or  position_i <= maximal_positions(3) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(3,current_filter_number_i'length);
               end if;
            end if;
            
            -- FILTER 4
            if(minimal_positions(4) < maximal_positions(4)) then
               if position_i >= minimal_positions(4) and  position_i <= maximal_positions(4) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(4,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(4) or  position_i <= maximal_positions(4) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(4,current_filter_number_i'length);
               end if;
            end if;
            
            -- FILTER 5
            if(minimal_positions(5) < maximal_positions(5)) then
               if position_i >= minimal_positions(5) and  position_i <= maximal_positions(5) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(5,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(5) or  position_i <= maximal_positions(5) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(5,current_filter_number_i'length);
               end if;
            end if;
            
            -- FILTER 6
            if(minimal_positions(6) < maximal_positions(6)) then
               if position_i >= minimal_positions(6) and  position_i <= maximal_positions(6) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(6,current_filter_number_i'length);
                end if;
           else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(6) or  position_i <= maximal_positions(6) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(6,current_filter_number_i'length);
               end if;
            end if;

            -- FILTER 7
            if(minimal_positions(7) < maximal_positions(7)) then
               if position_i >= minimal_positions(7) and  position_i <= maximal_positions(7) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(7,current_filter_number_i'length);
               end if;
            else -- position value wrap arround (min > max)
               if position_i >= minimal_positions(7) or  position_i <= maximal_positions(7) then
                  valid_filter <= '1';
                  current_filter_number_i <= to_unsigned(7,current_filter_number_i'length);
               end if;
            end if;

            
         end if;
      end if;
   end process;

end RTL;

