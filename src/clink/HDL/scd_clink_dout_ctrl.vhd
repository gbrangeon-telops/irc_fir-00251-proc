--------------------------------------------------------------------
--!   @file : scd_clink_dout_ctrl
--!   @brief : Reorder data of the SCD Camera Link channels
--!   @details
--!
--!   $Rev: 23386 $
--!   $Author: odionne $
--!   $Date: 2019-04-25 15:01:20 -0400 (jeu., 25 avr. 2019) $
--!   $Id: scd_clink_dout_ctrl.vhd 23386 2019-04-25 19:01:20Z odionne $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/clink/HDL/scd_clink_dout_ctrl.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.proxy_define.all;
use work.fpa_define.all;

entity scd_clink_dout_ctrl is
   port(
      CH0_ARESET      : in  std_logic;
      CH0_CLK         : in  std_logic;
      CH0_DVAL_IN     : in  std_logic;
      CH0_DIN         : in  std_logic_vector(27 downto 0);
      CH0_DOUT        : out std_logic_vector(27 downto 0) := (others => '0'); -- when channel is unused
      
      CH1_ARESET      : in  std_logic;
      CH1_CLK         : in  std_logic;
      CH1_DVAL_IN     : in  std_logic;
      CH1_DIN         : in  std_logic_vector(27 downto 0);
      CH1_DOUT        : out std_logic_vector(27 downto 0) := (others => '0')  -- when channel is unused
      );
end scd_clink_dout_ctrl;

architecture rtl of scd_clink_dout_ctrl is
   
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   signal ch0_sreset    : std_logic;
   signal ch0_din_i     : std_logic_vector(CH0_DIN'range);
   signal ch0_fval      : std_logic;
   signal ch0_output_en : std_logic := '0';
   signal ch1_sreset    : std_logic;
   signal ch1_din_i     : std_logic_vector(CH1_DIN'range);
   signal ch1_fval      : std_logic;
   signal ch1_output_en : std_logic := '0';
   signal g_output_en   : std_logic := '0';
   
begin
   
   ch0_reset_sync : sync_reset port map(CLK => CH0_CLK, ARESET => CH0_ARESET, SRESET => ch0_sreset);
   CH1_RESET : if PROXY_CLINK_CHANNEL_NUM = 2 generate	
   begin
      ch1_reset_sync : sync_reset port map(CLK => CH1_CLK, ARESET => CH1_ARESET, SRESET => ch1_sreset);
   end generate;
   
   -------------------
   -- Input signals --
   -------------------
   ch0_din_i <= CH0_DIN;
   ch0_fval  <= CH0_DIN(6);
   
   CH1_INPUTS : if PROXY_CLINK_CHANNEL_NUM = 2 generate	
   begin
      ch1_din_i <= CH1_DIN;
      ch1_fval  <= CH1_DIN(6);
   end generate;
   
   
   -----------------------------
   -- Output enable processes --
   -----------------------------
   CH0_ENABLE : process(CH0_CLK)
   begin
      if rising_edge(CH0_CLK) then
         if ch0_sreset = '1' then
            ch0_output_en <= '0';
         else
            -- Output is enabled/disabled only when FVAL is low to make sure frames are complete
            if ch0_fval = '0' then
               ch0_output_en <= CH0_DVAL_IN;
            end if;
         end if;
      end if;
   end process;
   
   CH1_ENABLE : if PROXY_CLINK_CHANNEL_NUM = 2 generate	
   begin
      process(CH1_CLK)
      begin
         if rising_edge(CH1_CLK) then
            if ch1_sreset = '1' then
               ch1_output_en <= '0';
            else
               -- Output is enabled/disabled only when FVAL is low to make sure frames are complete
               if ch1_fval = '0' then
                  ch1_output_en <= CH1_DVAL_IN;
               end if;
            end if;
         end if;
      end process;
   
      Usync: process(CH0_CLK)
      begin
         if rising_edge(CH0_CLK) then
            g_output_en <= ch0_output_en and ch1_output_en;
         end if;
      end process;
   
   end generate;
   
   CH1_DISABLE : if PROXY_CLINK_CHANNEL_NUM = 1 generate	
   begin
      g_output_en <= ch0_output_en;
   end generate;
   
   ----------------------
   -- Output processes --
   ----------------------
   CH0_OUTPUT : process(CH0_CLK)
   begin
      if rising_edge(CH0_CLK) then
         CH0_DOUT(0)  <=  ch0_din_i(24); --Video1(0)	
         CH0_DOUT(1)  <=  ch0_din_i(20); --Video1(1) 		
         CH0_DOUT(2)  <=  ch0_din_i(16); --Video1(2) 		
         CH0_DOUT(3)  <=  ch0_din_i(12); --Video1(3) 		
         CH0_DOUT(4)  <=  ch0_din_i(8);  --Video1(4) 		
         CH0_DOUT(5)  <=  ch0_din_i(23); --Video1(7) 		
         CH0_DOUT(6)  <=  ch0_din_i(4);  --Video1(5) 		
         CH0_DOUT(7)  <=  ch0_din_i(0);  --Video1(8) 		
         CH0_DOUT(8)  <=  ch0_din_i(25); --Video1(9) 		
         CH0_DOUT(9)  <=  ch0_din_i(21); --Video1(10) 		
         CH0_DOUT(10) <=  ch0_din_i(19); --Video1(14) 		
         CH0_DOUT(11) <=  ch0_din_i(15); --Video1(15) 		
         CH0_DOUT(12) <=  ch0_din_i(17); --Video1(11) 		
         CH0_DOUT(13) <=  ch0_din_i(13); --Video1(12) 		
         CH0_DOUT(14) <=  ch0_din_i(9);  --Video1(13) 		
         CH0_DOUT(15) <=  ch0_din_i(5);  --Video2(0) 			
         CH0_DOUT(16) <=  ch0_din_i(11); --Video2(6) 			
         CH0_DOUT(17) <=  ch0_din_i(7);  --Video2(7) 			
         CH0_DOUT(18) <=  ch0_din_i(1);  --Video2(1) 			
         CH0_DOUT(19) <=  ch0_din_i(26); --Video2(2) 			
         CH0_DOUT(20) <=  ch0_din_i(22); --Video2(3) 			
         CH0_DOUT(21) <=  ch0_din_i(18); --Video2(4)	 		
         CH0_DOUT(22) <=  ch0_din_i(14); --Video2(5)
         -- Enable/disable only the control signals
         if g_output_en = '1' then
            CH0_DOUT(23) <=  ch0_din_i(3);  --HDER/Spare 				
            CH0_DOUT(24) <=  ch0_din_i(10); --Lval 				
            CH0_DOUT(25) <=  ch0_din_i(6);  --Fval 				
            CH0_DOUT(26) <=  ch0_din_i(2);  --Dval
         else
            CH0_DOUT(26 downto 23) <= (others => '0');
         end if;
         CH0_DOUT(27) <=  ch0_din_i(27); --Video1(6)
      end if;
   end process;
   
   CH1_OUTPUT : if PROXY_CLINK_CHANNEL_NUM = 2 generate	
   begin
      process(CH1_CLK)
      begin
         if rising_edge(CH1_CLK) then
            CH1_DOUT(0)  <=  ch1_din_i(24); --Video2(8)  
            CH1_DOUT(1)  <=  ch1_din_i(20); --Video2(9)         
            CH1_DOUT(2)  <=  ch1_din_i(16); --Video2(10)        
            CH1_DOUT(3)  <=  ch1_din_i(12); --Video2(11)        
            CH1_DOUT(4)  <=  ch1_din_i(8); --Video2(12)        
            CH1_DOUT(5)  <=  ch1_din_i(23); --Video2(15)        
            CH1_DOUT(6)  <=  ch1_din_i(4); --Video2(13)        
            CH1_DOUT(7)  <=  '0'; --Spare             
            CH1_DOUT(8)  <=  '0'; --Spare             
            CH1_DOUT(9)  <=  '0'; --Spare             
            CH1_DOUT(10) <=  '0'; --Spare             
            CH1_DOUT(11) <=  '0'; --Spare             
            CH1_DOUT(12) <=  '0'; --Spare             
            CH1_DOUT(13) <=  '0'; --Spare             
            CH1_DOUT(14) <=  '0'; --Spare             
            CH1_DOUT(15) <=  '0'; --Spare             
            CH1_DOUT(16) <=  '0'; --Spare             
            CH1_DOUT(17) <=  '0'; --Spare             
            CH1_DOUT(18) <=  '0'; --Spare             
            CH1_DOUT(19) <=  '0'; --Spare             
            CH1_DOUT(20) <=  '0'; --Spare             
            CH1_DOUT(21) <=  '0'; --Spare             
            CH1_DOUT(22) <=  '0'; --Spare
            -- Enable/disable only the control signals
            if g_output_en = '1' then
               CH1_DOUT(23) <=  ch1_din_i(3); --Spare/Header   
               CH1_DOUT(24) <=  ch1_din_i(10); --Lval           
               CH1_DOUT(25) <=  ch1_din_i(6); --Fval           
               CH1_DOUT(26) <=  ch1_din_i(2); --Dval
            else
               CH1_DOUT(26 downto 23) <= (others => '0');
            end if;
            CH1_DOUT(27) <=  ch1_din_i(27); --Video2(14)
         end if;
      end process;
   end generate;
   
   
end rtl;
