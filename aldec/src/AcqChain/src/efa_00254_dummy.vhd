------------------------------------------------------------------
--!   @file : efa_00254_dummy
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {efa_00254_dummy} architecture {efa_00254_dummy}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity efa_00254_dummy is
   port(
      INT_FBK_Ni : in STD_LOGIC;
      INT_FBK_Pi : in STD_LOGIC;
      SER_TFG_Ni : in STD_LOGIC;
      SER_TFG_Pi : in STD_LOGIC;
      SER_TC_Ni : in STD_LOGIC;
      SER_TC_Pi : in STD_LOGIC;
      FSYNC_Ni : in STD_LOGIC;
      FSYNC_Pi : in STD_LOGIC;
      CH1_DATAi : in STD_LOGIC_VECTOR(27 downto 0);
      CH2_DATAi : in STD_LOGIC_VECTOR(27 downto 0);
      CH2_CLKi : in STD_LOGIC;
      CH1_CLKi : in STD_LOGIC;
      ARESETN : in STD_LOGIC;
      FSYNC_No : out STD_LOGIC;
      FSYNC_Po : out STD_LOGIC;
      INT_FBK_No : out STD_LOGIC;
      INT_FBK_Po : out STD_LOGIC;
      SER_TC_No : out STD_LOGIC;
      SER_TC_Po : out STD_LOGIC;
      SER_TFG_No : out STD_LOGIC;
      SER_TFG_Po : out STD_LOGIC;
      CH1_CLKo : out STD_LOGIC;
      CH1_DATAo : out STD_LOGIC_VECTOR(27 downto 0);
      CH2_CLKo : out STD_LOGIC;
      CH2_DATAo : out STD_LOGIC_VECTOR(27 downto 0);
      DET_FREQ_ID : out std_logic
      );
end efa_00254_dummy;

--}} End of automatically maintained section

architecture rtl of efa_00254_dummy is

constant DET_FREQ_ID_PERIOD : time := 0.333ms;
signal det_freq_id_i : std_logic := '0';

begin
   
   
   DET_FREQ_ID <= det_freq_id_i;
   FSYNC_No    <=  FSYNC_Ni;  
   FSYNC_Po    <=  FSYNC_Pi;  
   INT_FBK_No  <=  INT_FBK_Ni;
   INT_FBK_Po  <=  INT_FBK_Pi;
   SER_TC_No   <=  SER_TC_Ni when SER_TC_Ni /= 'Z' else '0'; 
   SER_TC_Po   <=  SER_TC_Pi when SER_TC_Pi /= 'Z' else '1'; 
   SER_TFG_No  <=  SER_TFG_Ni when SER_TFG_Ni /= 'Z' else '0';
   SER_TFG_Po  <=  SER_TFG_Pi when SER_TFG_Pi /= 'Z' else '1';
   CH1_CLKo    <=  CH1_CLKi;  
   CH1_DATAo   <=  CH1_DATAi; 
   CH2_CLKo    <=  CH2_CLKi;  
   CH2_DATAo   <=  CH2_DATAi;  

    U3: process(det_freq_id_i)                     
   begin                                   
      det_freq_id_i <= not det_freq_id_i after DET_FREQ_ID_PERIOD/2;
   end process;

  
end rtl;
