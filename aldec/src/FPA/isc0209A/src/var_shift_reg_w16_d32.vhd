------------------------------------------------------------------
--!   @file : var_shift_reg_w16_d32
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
use IEEE.NUMERIC_STD.all;

entity var_shift_reg_w16_d32 is
   port(
      A    : in std_logic_vector(4 downto 0);
      D    : in std_logic_vector(15 downto 0);
      CLK  : in std_logic;
      CE   : in std_logic;
      SCLR : in std_logic;
      Q    : out std_logic_vector(15 downto 0)
      );
end var_shift_reg_w16_d32;

architecture sim of var_shift_reg_w16_d32 is 
   
   type q_pipe_type is array (31 downto 0) of std_logic_vector(15 downto 0);
   signal q_pipe : q_pipe_type;
   signal q_i    : std_logic_vector(15 downto 0);
   
begin   
   
   Q <= q_i;
   
   
   U1: process(CLK)
   begin
      if rising_edge(CLK) then
         if CE = '1' then           
            q_pipe(0) <= D;
            q_pipe(31 downto 1) <= q_pipe(30 downto 0); 
            q_i <= q_pipe(to_integer(unsigned(A)));
         end if;
         
         if SCLR = '1' then 
            q_i <= (others => '0');
            for ii in 0 to 31 loop
             q_pipe(ii) <= (others => '0');  
            end loop;           
         end if;
         
      end if;        
   end process;
   
   
end sim;
