-------------------------------------------------------------------------------
--
-- Title       : opamp
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\opamp.vhd
-- Generated   : Sun Sep 18 13:16:25 2011
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
--library COMMON_HDL;
--use COMMON_HDL.Telops.all;

entity opamp is
   port(
      ARESET       : in std_logic;
      CLK          : in std_logic;
      OPAMP_IN     : in std_logic_vector(7 downto 0);
      OPAMP_GAIN   : in std_logic_vector(2 downto 0);
      OPAMP_OUT    : out std_logic_vector(7 downto 0)
      );
end opamp;

architecture RTL of opamp is
   type real_opam_gain_type is array (0 to 7) of integer;
   constant real_opam_gain : real_opam_gain_type := (0, 1, 2, 5, 10, 20, 50, 100);
   signal opamp_out_i      : natural;
   
   
   
begin
   
   OPAMP_OUT <= std_logic_vector(to_unsigned(opamp_out_i,8));
   
   U0: process(CLK)
      variable opamp_temp   : integer;
      variable opamp_gain_sel : std_logic_vector(2 downto 0);
   begin
      if rising_edge(CLK) then
         if ARESET = '1' then 
            opamp_out_i <= 0; 
            opamp_temp := 0;
         else
            
            for kk in 0 to 2 loop
               if OPAMP_GAIN(kk) =  'Z' then
                  opamp_gain_sel(kk) :=  '1';
               else
                  opamp_gain_sel(kk) :=  OPAMP_GAIN(kk);
               end if;
            end loop;
            
            opamp_temp := to_integer(unsigned(OPAMP_IN))* real_opam_gain(to_integer(unsigned(opamp_gain_sel)));
            if opamp_temp > 255  then
               opamp_out_i <= 255;  -- saturation de la sortie
            else
               opamp_out_i <=opamp_temp;
            end if;
         end if;                                  
      end if;   
   end process; 
   
   
end RTL;
