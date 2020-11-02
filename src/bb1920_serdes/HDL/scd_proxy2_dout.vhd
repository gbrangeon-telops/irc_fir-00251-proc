------------------------------------------------------------------
--!   @file : scd_proxy2_dout
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

entity scd_proxy2_dout is
	 port(
		 ARESET        : in std_logic;
		 CLK           : in std_logic;
       
		 DIN           : in std_logic_vector(31 downto 0);
         SUCCESS       : in std_logic;
		 
         FVAL          : out std_logic_vector(7 downto 0);
		 LVAL          : out std_logic_vector(7 downto 0);
		 DOUT          : out std_logic_vector(71 downto 0);
		 DOUT_DVAL     : out std_logic
	     );
end scd_proxy2_dout;

architecture rtl of scd_proxy2_dout is

   	component sync_reset
   	port (
        ARESET : in std_logic;
        CLK    : in std_logic;
        SRESET : out std_logic := '1'
		);
   	end component;
   
   	signal sreset           : std_logic;	
   	signal fval_last		: std_logic_vector(7 downto 0);
   	signal fval_in			: std_logic_vector(7 downto 0);	
	signal fval_i			: std_logic_vector(7 downto 0);	  
	signal dval_i			: std_logic;
	signal dout_i			: std_logic_vector(71 downto 0);
	signal din_i			: std_logic_vector(31 downto 0);
	signal compteur_dout	: std_logic := '0';
	
	type fsm_type is (idle, fval_high_st); 
   	signal fval_fsm	     	: fsm_type; 
   
begin
	
	--On cherche un 0xE
	LVAL(7) <= DIN(31) and DIN(30) and DIN(29) and not(DIN(28)); 
	LVAL(6) <= DIN(27) and DIN(26) and DIN(25) and not(DIN(24));
	LVAL(5) <= DIN(23) and DIN(22) and DIN(21) and not(DIN(20));
	LVAL(4) <= DIN(19) and DIN(18) and DIN(17) and not(DIN(16));
	LVAL(3) <= DIN(15) and DIN(14) and DIN(13) and not(DIN(12));
	LVAL(2) <= DIN(11) and DIN(10) and DIN(9) and not(DIN(8));
	LVAL(1) <= DIN(7) and DIN(6) and DIN(5) and not(DIN(4));
	LVAL(0) <= DIN(3) and DIN(2) and DIN(1) and not(DIN(0));	
	
	FVAL <= fval_i;
	
	DOUT <= dout_i;   
	DOUT_DVAL <= dval_i and compteur_dout = '1';
	--------------------------------------------------
    -- synchro reset 
    --------------------------------------------------   
    U1 : sync_reset
    port map(
       ARESET => ARESET,
       CLK    => CLK,
       SRESET => sreset);
   
	
	process(CLK)
	begin
		if rising_edge(CLK) then         
        	if sreset = '1' then  
			
			else		 
				
				fval_in(7) <= not(DIN(31)) and not(DIN(30)) and DIN(29) and DIN(28); 
				fval_in(6) <= not(DIN(27)) and not(DIN(26)) and DIN(25) and DIN(24);
				fval_in(5) <= not(DIN(23)) and not(DIN(22)) and DIN(21) and DIN(20);
				fval_in(4) <= not(DIN(19)) and not(DIN(18)) and DIN(17) and DIN(16);
				fval_in(3) <= not(DIN(15)) and not(DIN(14)) and DIN(13) and DIN(12);
				fval_in(2) <= not(DIN(11)) and not(DIN(10)) and DIN(9) and DIN(8);
				fval_in(1) <= not(DIN(7)) and not(DIN(6)) and DIN(5) and DIN(4);
				fval_in(0) <= not(DIN(3)) and not(DIN(2)) and DIN(1) and DIN(0);
				fval_last <= fval_in;
				
				for I in fval_in'low to fval_in'high loop
					--Pourrait aussi faire if fval_last(I) xor fval_in(I) then fval_i <= not(fval_i)
					if fval_last(I)='0' and fval_in(I)='1' then
						fval_i(I) <= '1';
					elsif fval_last(I)='1' and fval_in(I)='1' then
						fval_i(I) <= '0';
					else
						fval_i(I) <= fval_i(I);
					end if;	 
				end loop;
				
				
				dval_i <= SUCCESS = '1' and DIN(3) and DIN(2) and DIN(1) and not(DIN(0));
				din_i <= DIN;							
				--Règle comme quoi il y a toujours un nombre de pixel divisible par 4 par ligne
				if dval_i = '1' and compteur_dout = '0' then
					dout_i(31 downto 0) <= din_i;		  
					compteur_dout <= '1';
				elsif dval_i = '1' and compteur_dout = '1' then
					dout_i(71 downto 32) <= din_i;
					compteur_dout <= '0';
				end if;	
			end if;
		end if;	
	end process;
		
	

end rtl;
