-------------------------------------------------------------------------------
--
-- Title       : irigb_source
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\irigb_source.vhd
-- Generated   : Fri Sep 16 14:30:14 2011
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
use IEEE.math_real.all;
use work.IRIG_define_v2.all;
use work.IRIG_Testbench_define.all;

entity irigb_source is
   port(
      ARESET             : in std_logic;
      CLK                : in std_logic;
      IRIG_SIGNAL        : out std_logic_vector(7 downto 0);
      IRIG_SIGNAL_DVAL   : out std_logic;
      POS_GOING_CROSSING : out std_logic;
      NEG_GOING_CROSSING : out std_logic
      );
end irigb_source;



architecture RTL of irigb_source is
   
   constant W : real := real(2)*MATH_PI/real(IRIG_CARRIER_PERIOD);
   constant ZERO_CROSSING_ERROR : real := 1.0E-7; --0.00000001;
   
   type gen_fsm_type is (idle, gen_0_mark_st, gen_1_mark_st, gen_P_mark_st, gen_blank_st, wait_fedge_st);
   
   signal gen_fsm                   : gen_fsm_type; 
   signal carrier_sig               : real; 
   signal carrier_sig_last          : real; 
   signal time_cnt                  : unsigned(31 downto 0); 
   signal new_carrier_cycle         : std_logic;
   signal char_cnt                  : unsigned(7 downto 0);
   signal cycle_cnt                 : unsigned(7 downto 0);
   signal modulating_sig            : real;
   signal irig_sig_real             : real;
   signal new_carrier_cycle_last    : std_logic;
   signal blank_max                 : integer range 0 to 10;
   signal irig_sig_int              : integer;
   signal irig_sig_real_scaled      : real;
   signal modulating_sig_dval       : std_logic;
   signal positive_going_crossing_i : std_logic;
   signal negative_going_crossing_i : std_logic;
   --signal 
   
   
begin 
   
   POS_GOING_CROSSING <= positive_going_crossing_i;
   NEG_GOING_CROSSING <= negative_going_crossing_i;
   
   
   -- le temps
   U0: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            time_cnt <= (others => '0');            
         else
            time_cnt <= time_cnt + 1;
         end if;                                  
      end if;   
   end process; 
   
   
   -- la porteuse sinusoidale de 1KHz
   U1: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            carrier_sig <= real(0);            
         else
            carrier_sig <= sin(W*real(to_integer(time_cnt)));
         end if;                                  
      end if;   
   end process;
   
   -- detections  des debuts de cycles 
   U2A: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            carrier_sig_last <= real(0);
            new_carrier_cycle <= '0';
         else   
            carrier_sig_last <= carrier_sig; 
            if (carrier_sig_last < carrier_sig) and  (abs(carrier_sig) < ZERO_CROSSING_ERROR) then 
               new_carrier_cycle <= '1';
            else
               new_carrier_cycle <= '0';
            end if;
            
         end if;                                  
      end if;   
   end process; 
   
   -- detections des passages à '0'
   U2B: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            positive_going_crossing_i <= '0';
            negative_going_crossing_i <= '0';
         else            
            positive_going_crossing_i <= '0';
            negative_going_crossing_i <= '0';  
            if (abs(carrier_sig) < ZERO_CROSSING_ERROR) then 
               if carrier_sig_last < carrier_sig then 
                  positive_going_crossing_i <= '1'; 
               else
                  negative_going_crossing_i <= '1'; 
               end if;
            end if;
         end if;                                  
      end if;   
   end process;
   
   -- generation du signal modulant
   U3: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            gen_fsm  <= idle;
            char_cnt <= (others => '0');
            modulating_sig <= real(1); 
            new_carrier_cycle_last <= '0';
            modulating_sig_dval <= '0';
         else            
            
            case gen_fsm is
               
               when idle =>                  
                  if new_carrier_cycle = '1' then 
                     if IRIG_STREAM(to_integer(char_cnt)) = '0' then
                        gen_fsm  <= gen_0_mark_st;
                     elsif IRIG_STREAM(to_integer(char_cnt)) = '1' then
                        gen_fsm  <= gen_1_mark_st;
                     else
                        gen_fsm  <= gen_P_mark_st;
                     end if;                     
                  end if;    
                  modulating_sig <= real(1); 
                  modulating_sig_dval <= '1';
                  cycle_cnt <= to_unsigned(1,cycle_cnt'length); 
               
               when gen_0_mark_st =>
                  if new_carrier_cycle = '1' and new_carrier_cycle_last = '0' then
                     cycle_cnt <= cycle_cnt + 1;
                  end if;
                  if  cycle_cnt = 2 then
                     gen_fsm  <= gen_blank_st;
                     cycle_cnt <= (others => '0');
                     blank_max <= 8;
                  end if;
               
               when gen_1_mark_st =>
                  if new_carrier_cycle = '1' and new_carrier_cycle_last = '0' then
                     cycle_cnt <= cycle_cnt + 1;
                  end if;
                  if  cycle_cnt = 5 then
                     gen_fsm  <= gen_blank_st;
                     cycle_cnt <= (others => '0');
                     blank_max <= 5;
                  end if;                   
               
               when gen_P_mark_st =>
                  if new_carrier_cycle = '1' and new_carrier_cycle_last = '0' then
                     cycle_cnt <= cycle_cnt + 1;
                  end if;
                  if  cycle_cnt = 8 then
                     gen_fsm  <= gen_blank_st;
                     cycle_cnt <= (others => '0');
                     blank_max <= 2;
                  end if; 
               
               when gen_blank_st  => 
                  modulating_sig <= real(1)/3.0;
                  if new_carrier_cycle = '1' and new_carrier_cycle_last = '0' then
                     cycle_cnt <= cycle_cnt + 1;
                  end if;
                  if  cycle_cnt = blank_max  then
                     gen_fsm  <= wait_fedge_st;
                  end if;                     
               
               when wait_fedge_st  =>
                  --if new_carrier_cycle = '0' and new_carrier_cycle_last = '1' then
                  gen_fsm  <= idle;
                  char_cnt <= (char_cnt + 1) mod 100;
                  -- end if;
               
               when others =>
            end case;
         end if;                                  
      end if;   
   end process;  
   
   -- signal modulé
   U4: process(CLK)            
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            irig_sig_real <= real(0);
         else   
            irig_sig_real <= modulating_sig*carrier_sig;
            irig_sig_real_scaled <= 40.0*irig_sig_real;
            irig_sig_int <= integer(irig_sig_real_scaled);       
         end if;                                  
      end if;   
   end process;
   
   IRIG_SIGNAL <= std_logic_vector(to_signed(irig_sig_int, 8));
   IRIG_SIGNAL_DVAL  <=  modulating_sig_dval;
   
end RTL;
