-------------------------------------------------------------------------------
--
-- Title       : adc_readout_tb_stim
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Thu Jan 30 13:26:14 2014
-- From        : interface description file
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;                                             
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.tel2000.all;

entity ad7980_emulator is
    generic(
        ADC_NBITS         : integer := 16; -- legal values are 14, 16, 18
        CHAIN_MODE         : boolean := false;
        WIRE_3_MODE        : boolean := true;
        BUSY_INDICATOR     : boolean := true;
        CLK_PERIOD         : time := 50 ns
    );
   port(
      -- CLK AND CONTROL
      CLK                   : in std_logic;
      SRESET 				: in std_logic;
      
      -- Analog _in
      ANALOG_IN             : in unsigned(15 downto 0);
      
      -- ADC INTF
      ADC_CNV               : in std_logic;
      ADC_SCLK		        : in std_logic;
      ADC_SDI				: in std_logic; --FROM FPGA SDO
      ADC_SDO				: out std_logic --TO FPGA SDI
      );
end ad7980_emulator;

architecture sim of ad7980_emulator is

function To_Std_Logic(L: BOOLEAN) return std_ulogic is 
begin 
    if L then 
        return('1'); 
    else 
        return('0'); 
    end if; 
end function To_Std_Logic; 

-- For now only 1 mode is supported: cs_busy_3w
type adc_mode_t is (cs_busy_3w, cs_busy_4w, cs_nbusy_3w, cs_nbusy_4w, chain_busy,chain_nbusy);
signal adc_mode : adc_mode_t;
constant config : std_logic_vector(2 downto 0) := std_logic_vector( To_Std_Logic(CHAIN_MODE) & To_Std_Logic(BUSY_INDICATOR) & To_Std_Logic(WIRE_3_MODE));

type adc_state_t is (wait_st, conv_st, acq_st);
signal adc_state,adc_state_d1 : adc_state_t := wait_st;

signal conv_cnt : unsigned(15 downto 0);
constant CONV_TIME_REQ : time := 750 ns;
constant conv_time_u : unsigned(15 downto 0) := to_unsigned(natural(CONV_TIME_REQ/CLK_PERIOD),16);

signal acq_cnt : unsigned(15 downto 0);
constant ACQ_LEN : unsigned(7 downto 0) := to_unsigned(17,8);

signal vin : unsigned(15 downto 0);

--Timing parameter
constant thsdo : time := 9.5 ns;
constant tdsdo : time := 3 ns;

begin
    
adc_sm : process(CLK)
begin
    if rising_edge(CLK) then
        if SRESET = '1' then
            adc_state <= wait_st;
            conv_cnt <= to_unsigned(0,16);
        else
            adc_state_d1 <= adc_state;
            if ( adc_state = wait_st) then
                if(ADC_CNV = '1') then
                    adc_state <= conv_st;    
                end if;
            elsif ( adc_state = conv_st) then                
                if( conv_cnt = conv_time_u) then
                    adc_state <= acq_st;
                    conv_cnt <= to_unsigned(0,16);
                else
                    conv_cnt <= conv_cnt + 1;
                end if;
            elsif ( adc_state = acq_st) then
                if( acq_cnt = ACQ_LEN) then
                    adc_state <= wait_st;  
                end if;    
            else 
                adc_state <= wait_st;
            end if;
            
        end if;
    end if;
end process adc_sm;


TRACK_HOLD : process(CLK)
begin
    if rising_edge(CLK) then
        if SRESET = '1' then
            vin <= to_unsigned(0,16);
        else
            if(adc_state = conv_st and adc_state_d1 = wait_st) then
                vin <= ANALOG_IN;
            end if;
        end if;
    end if;
end process;


SERIAL_OUTPUT : process
begin
    --INIT
    ADC_SDO <= 'Z';
    acq_cnt <= to_unsigned(0,16);
    --Conversion Phase
    wait until adc_state = conv_st;
    --Acquisition Phase
    wait until adc_state = acq_st;
    ADC_SDO <= '0';
    
    wait until falling_edge(ADC_SCLK);
    acq_cnt <= acq_cnt + 1;
    for i in 15 downto 0 loop
        wait for thsdo;
        ADC_SDO <= vin(i);
        wait until falling_edge(ADC_SCLK);
        acq_cnt <= acq_cnt + 1;
    end loop;
    wait for thsdo;
    ADC_SDO <= 'Z';
    wait until adc_state = wait_st;
end process SERIAL_OUTPUT; 

end sim;

