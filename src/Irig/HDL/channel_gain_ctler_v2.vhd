-------------------------------------------------------------------------------
--
-- Title       : channel_gain_ctler_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\channel_gain_ctler_v2.vhd
-- Generated   : Mon Sep 12 11:58:15 2011
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
use IEEE.NUMERIC_STD.all;
--library COMMON_HDL;
--use COMMON_HDL.Telops.all;
use work.IRIG_define_v2.all;

entity channel_gain_ctler_v2 is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      SIG_COND_CFG  : in conditioner_cfg_type;
      OPAMP_GAIN    : out std_logic_vector(2 downto 0);
      GAIN_OVERFL   : out std_logic;
      GAIN_UNDERFL  : out std_logic
      );
end channel_gain_ctler_v2;


architecture RTL of channel_gain_ctler_v2 is 
   
   component sync_reset
      port (
         ARESET  : in std_logic;
         CLK     : in std_logic;
         SRESET  : out std_logic := '1'
         );
   end component;  
   
   signal sreset          : std_logic;
   signal gain_overfl_i   : std_logic;
   signal gain_underfl_i  : std_logic;
   signal opamp_gain_i    : unsigned(2 downto 0);
   signal opamp_gain_iob  : std_logic_vector(2 downto 0);
   
   attribute equivalent_register_removal : string;      
   attribute equivalent_register_removal of opamp_gain_i : signal is "NO"; 
   
   attribute IOB : string;
   --attribute IOB of opamp_gain_iob                       : signal is "FORCE";  
begin  
   
   --------------------------------------------------
   -- sorties 
   --------------------------------------------------     
   GAIN_OVERFL <= gain_overfl_i;
   GAIN_UNDERFL <= gain_underfl_i;
   
   --------------------------------------------------
   -- interfaçage 
   -------------------------------------------------- 
   -- le design sur EFA-00229-00X donne 3.3V lorsque la sortie 
   -- du FPGA est à l'etat '1'.cela est insuffisant pour l'opamp. Ainsi, on s'aide avec les pull-ups de 5V.
   -- 
   gen : for j in OPAMP_GAIN'LENGTH-1 downto 0 generate      
      OPAMP_GAIN(j) <= '0' when opamp_gain_iob(j) = '0' else 'Z';
   end generate;     
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   
   --------------------------------------------------
   -- contrôle 
   -------------------------------------------------- 
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            gain_overfl_i <= '0';
            gain_underfl_i <= '0'; 
            opamp_gain_i <= (others => '0');
         else
            
            if SIG_COND_CFG.RESET_GAIN = '1' then                 
               opamp_gain_i <= (others => '0');     -- reset du gain
            else                                                  
               if SIG_COND_CFG.INC_GAIN = '1' then
                  if opamp_gain_i = "111" then
                     gain_overfl_i <= '1';
                  else
                     opamp_gain_i <= opamp_gain_i + 1;  -- augmentation du gain
                  end if;
               end if;                             
               
               if SIG_COND_CFG.DEC_GAIN = '1' then
                  if opamp_gain_i = 0 then 
                     gain_underfl_i <= '1';
                  else                  
                     opamp_gain_i <= opamp_gain_i - 1;  -- diminution du gain
                  end if;
               end if;          
            end if;    
            
            if SIG_COND_CFG.RESET_ERR = '1' then     -- réinitialisation des erreurs
               gain_overfl_i <= '0';
               gain_underfl_i <= '0';
            end if;   
            
            opamp_gain_iob <= std_logic_vector(opamp_gain_i);
            
         end if;
      end if;
      
   end process;   
   
end RTL;
