------------------------------------------------------------------
--!   @file : scorpiolwD_clink_receiver_top
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity scorpiolwD_clink_receiver_top is
   
   generic (
      RESET200ms : boolean := true
      );
   
   port(
      
      -- reset
      ARESETN          : in std_logic;      
      IO_RESET         : in std_logic;
      REF_CLK_RESET    : in std_logic;
      RST_CLINK_N      : in std_logic;
      CLK100           : in std_logic;
      -- powerdown
      PWR_DOWN         : in std_logic;
      
      -- bitslip
      BITSLIP          : in std_logic;  
      
      -- idelay
      REFCLK           : in std_logic;
      IDELAYCTRL_RDY   : out std_logic;
      
      -- ch0 data in
      CH0_CLK_N        : in std_logic;
      CH0_CLK_P        : in std_logic;
      CH0_DATA_N       : in std_logic_vector(3 downto 0);
      CH0_DATA_P       : in std_logic_vector(3 downto 0);
      
      -- ch1 data in
      CH1_CLK_N        : in std_logic;
      CH1_CLK_P        : in std_logic;
      CH1_DATA_N       : in std_logic_vector(3 downto 0);
      CH1_DATA_P       : in std_logic_vector(3 downto 0); 
      
      -- ch2 data in
      CH2_CLK_N        : in std_logic;
      CH2_CLK_P        : in std_logic;
      CH2_DATA_N       : in std_logic_vector(3 downto 0);
      CH2_DATA_P       : in std_logic_vector(3 downto 0);
      
      -- ch3 data in
      CH3_CLK_N        : in std_logic;
      CH3_CLK_P        : in std_logic;
      CH3_DATA_N       : in std_logic_vector(3 downto 0);
      CH3_DATA_P       : in std_logic_vector(3 downto 0);
      
      -- ch0 data out
      CH0_DOUT         : out std_logic_vector(27 downto 0);
      CH0_DOUT_CLK     : out std_logic;
      CH0_RDY          : out std_logic;
      
      -- ch1 data out
      CH1_DOUT         : out std_logic_vector(27 downto 0);
      CH1_DOUT_CLK     : out std_logic;
      CH1_RDY          : out std_logic;
      
      -- ch2 data out
      CH2_DOUT         : out std_logic_vector(27 downto 0);
      CH2_DOUT_CLK     : out std_logic;
      --CH2_RDY          : out std_logic;
      
      -- ch3 data out
      CH3_DOUT         : out std_logic_vector(27 downto 0);
      CH3_DOUT_CLK     : out std_logic
      --CH3_RDY          : out std_logic
      );
end scorpiolwD_clink_receiver_top;

architecture SCH of scorpiolwD_clink_receiver_top is
   
   signal global_rst_n : std_logic;
   
   component scorpiolwD_clink_receiver_2ch
      generic (
         RESET200ms : boolean := true
         );
      
      port (
         ARESETN          : in std_logic;      
         IO_RESET         : in std_logic;
         PWR_DOWN         : in std_logic;
         BITSLIP          : in std_logic;  
         REF_CLK_RESET    : in std_logic;
         CLK100           : in std_logic;
         REFCLK           : in std_logic;         
         IDELAYCTRL_RDY   : out std_logic;
         CH0_CLK_N        : in std_logic;
         CH0_CLK_P        : in std_logic;
         CH0_DATA_N       : in std_logic_vector(3 downto 0);
         CH0_DATA_P       : in std_logic_vector(3 downto 0);
         CH1_CLK_N        : in std_logic;
         CH1_CLK_P        : in std_logic;
         CH1_DATA_N       : in std_logic_vector(3 downto 0);
         CH1_DATA_P       : in std_logic_vector(3 downto 0);
         CH0_DOUT         : out std_logic_vector(27 downto 0);
         CH0_DOUT_CLK     : out std_logic;
         CH0_RDY          : out std_logic;
         CH1_DOUT         : out std_logic_vector(27 downto 0);
         CH1_DOUT_CLK     : out std_logic;
         CH1_RDY          : out std_logic
         );
   end component;
   
   signal serdes0_dout_i  : std_logic_vector(27 downto 0);
   signal serdes1_dout_i  : std_logic_vector(27 downto 0);
   signal ch0_dout_clk_i  : std_logic;
   signal ch1_dout_clk_i  : std_logic;
   
   attribute dont_touch   : string;
   attribute dont_touch of serdes0_dout_i  : signal is "true";
   attribute dont_touch of serdes1_dout_i  : signal is "true";
   
   
   
begin
   
   global_rst_n <= ARESETN or RST_CLINK_N;  
   
   U1 : scorpiolwD_clink_receiver_2ch
   generic map(
      RESET200ms => RESET200ms
      )
   
   port map(                   
      ARESETN        =>  global_rst_n,          
      IO_RESET       =>  IO_RESET,      
      PWR_DOWN       =>  PWR_DOWN,      
      BITSLIP        =>  BITSLIP,       
      REF_CLK_RESET  =>  REF_CLK_RESET,
      REFCLK         =>  REFCLK,        
      IDELAYCTRL_RDY =>  IDELAYCTRL_RDY,
      CLK100         =>  CLK100,  
      
      CH0_CLK_N      =>  CH0_CLK_N,     
      CH0_CLK_P      =>  CH0_CLK_P,     
      CH0_DATA_N     =>  CH0_DATA_N,    
      CH0_DATA_P     =>  CH0_DATA_P,    
      
      CH1_CLK_N      =>  CH1_CLK_N,     
      CH1_CLK_P      =>  CH1_CLK_P,     
      CH1_DATA_N     =>  CH1_DATA_N,    
      CH1_DATA_P     =>  CH1_DATA_P,    
      
      CH0_DOUT       =>  serdes0_dout_i,      
      CH0_DOUT_CLK   =>  ch0_dout_clk_i,
      CH0_RDY        =>  CH0_RDY,
      
      CH1_DOUT       =>  serdes1_dout_i,      
      CH1_DOUT_CLK   =>  ch1_dout_clk_i,
      CH1_RDY        =>  CH1_RDY
      );                 
   
   CH0_DOUT_CLK <= ch0_dout_clk_i; 
   CH1_DOUT_CLK <= ch1_dout_clk_i;
   
   CH2_DOUT_CLK <= '0';
   CH3_DOUT_CLK <= '0';
   
   ---------------------------------------------------------
   -- reorgaination
   ---------------------------------------------------------
   -- pour tenir compte des inversions du serializer
   UR0 : process(ch0_dout_clk_i)
   begin
      if rising_edge(ch0_dout_clk_i) then         
         CH0_DOUT(0)  <=  serdes0_dout_i(24); --Video1(0)	
         CH0_DOUT(1)  <=  serdes0_dout_i(20); --Video1(1) 		
         CH0_DOUT(2)  <=  serdes0_dout_i(16); --Video1(2) 		
         CH0_DOUT(3)  <=  serdes0_dout_i(12); --Video1(3) 		
         CH0_DOUT(4)  <=  serdes0_dout_i(8);  --Video1(4) 		
         CH0_DOUT(5)  <=  serdes0_dout_i(23); --Video1(7) 		
         CH0_DOUT(6)  <=  serdes0_dout_i(4);  --Video1(5) 		
         CH0_DOUT(7)  <=  serdes0_dout_i(0);  --Video1(8) 		
         CH0_DOUT(8)  <=  serdes0_dout_i(25); --Video1(9) 		
         CH0_DOUT(9)  <=  serdes0_dout_i(21); --Video1(10) 		
         CH0_DOUT(10) <=  serdes0_dout_i(19); --Video1(14) 		
         CH0_DOUT(11) <=  serdes0_dout_i(15); --Video1(15) 		
         CH0_DOUT(12) <=  serdes0_dout_i(17); --Video1(11) 		
         CH0_DOUT(13) <=  serdes0_dout_i(13); --Video1(12) 		
         CH0_DOUT(14) <=  serdes0_dout_i(9);  --Video1(13) 		
         CH0_DOUT(15) <=  serdes0_dout_i(5);  --spare			
         CH0_DOUT(16) <=  serdes0_dout_i(11); --spare 			
         CH0_DOUT(17) <=  serdes0_dout_i(7);  --spare 			
         CH0_DOUT(18) <=  serdes0_dout_i(1);  --spare 			
         CH0_DOUT(19) <=  serdes0_dout_i(26); --spare 			
         CH0_DOUT(20) <=  serdes0_dout_i(22); --spare 			
         CH0_DOUT(21) <=  serdes0_dout_i(18); --spare	 		
         CH0_DOUT(22) <=  serdes0_dout_i(14); --spare 			
         CH0_DOUT(23) <=  serdes0_dout_i(3);  --spare 				
         CH0_DOUT(24) <=  serdes0_dout_i(10); --Lval 				
         CH0_DOUT(25) <=  serdes0_dout_i(6);  --Fval 				
         CH0_DOUT(26) <=  serdes0_dout_i(2);  --Dval 				
         CH0_DOUT(27) <=  serdes0_dout_i(27); --Video1(6) 			
      end if;  
   end process; 
   
   
   UR1 : process(ch1_dout_clk_i)
   begin
      if rising_edge(ch1_dout_clk_i) then         
         CH1_DOUT(0)  <=  serdes1_dout_i(24); --Video2(0)
         CH1_DOUT(1)  <=  serdes1_dout_i(20); --Video2(1)      
         CH1_DOUT(2)  <=  serdes1_dout_i(16); --Video2(2)      
         CH1_DOUT(3)  <=  serdes1_dout_i(12); --Video2(3)      
         CH1_DOUT(4)  <=  serdes1_dout_i(8);  --Video2(4)     
         CH1_DOUT(5)  <=  serdes1_dout_i(23); --Video2(7)      
         CH1_DOUT(6)  <=  serdes1_dout_i(4);  --Video2(5)     
         CH1_DOUT(7)  <=  serdes1_dout_i(0);  --Video2(8) 
         CH1_DOUT(8)  <=  serdes1_dout_i(25); --Video2(9) 
         CH1_DOUT(9)  <=  serdes1_dout_i(21); --Video2(10)
         CH1_DOUT(10) <=  serdes1_dout_i(19); --Video2(14)
         CH1_DOUT(11) <=  serdes1_dout_i(15); --Video2(15)
         CH1_DOUT(12) <=  serdes1_dout_i(17); --Video2(11)
         CH1_DOUT(13) <=  serdes1_dout_i(13); --Video2(12)
         CH1_DOUT(14) <=  serdes1_dout_i(9);  --Video2(13)
         CH1_DOUT(15) <=  serdes1_dout_i(5);  --spare		
         CH1_DOUT(16) <=  serdes1_dout_i(11); --spare 	
         CH1_DOUT(17) <=  serdes1_dout_i(7);  --spare 	
         CH1_DOUT(18) <=  serdes1_dout_i(1);  --spare 	
         CH1_DOUT(19) <=  serdes1_dout_i(26); --spare 	
         CH1_DOUT(20) <=  serdes1_dout_i(22); --spare 	
         CH1_DOUT(21) <=  serdes1_dout_i(18); --spare	 	
         CH1_DOUT(22) <=  serdes1_dout_i(14); --spare 	
         CH1_DOUT(23) <=  serdes1_dout_i(3);  --spare 	 
         CH1_DOUT(24) <=  serdes1_dout_i(10); --Lval 		  
         CH1_DOUT(25) <=  serdes1_dout_i(6);  --Fval 		 
         CH1_DOUT(26) <=  serdes1_dout_i(2);  --Dval 		 
         CH1_DOUT(27) <=  serdes1_dout_i(27); --Video2(6) 
      end if;  
   end process;  
   --end generate;
end SCH;