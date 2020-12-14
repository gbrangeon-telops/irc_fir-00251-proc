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
      
      --
      ARESET        : in std_logic;
      CLK           : in std_logic;
      
      --inputs
      DIN           : in std_logic_vector(31 downto 0);
      SUCCESS       : in std_logic;
      
      -- delay calibration side
      FVALS         : out std_logic_vector(7 downto 0);
      LVALS         : out std_logic_vector(7 downto 0);
      
      -- downstream side
      DOUT          : out std_logic_vector(31 downto 0);
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
   
    type array_type is array (0 to 7) of std_logic_vector(3 downto 0);
   
   signal sreset           : std_logic;	
   signal fvals_i 	      : std_logic_vector(7 downto 0);
   signal lvals_i 	      : std_logic_vector(7 downto 0);
   signal ctrl_words       : array_type;
   signal ctrl_words_last  : array_type;
   signal dout_i           : std_logic_vector(DOUT'LENGTH-1 downto 0) := (others => '0');
   signal dout_dval_i      : std_logic;
   signal ctrl_bits_i      : std_logic_vector(3 downto 0);
   signal ctrl_bits_last   : std_logic_vector(3 downto 0);
   signal fval_i           : std_logic;
   signal lval_i           : std_logic;
   signal output_en        : std_logic;
   signal fval_last        : std_logic;
   
begin
   
   --------------------------------------------------
   -- outputs mapping 
   --------------------------------------------------    
   FVALS        <= fvals_i;
   LVALS        <= lvals_i;
   DOUT         <= dout_i;   
   DOUT_DVAL    <= dout_dval_i; 
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset); 
   
   --------------------------------------------------
   -- inputs mapping 
   --------------------------------------------------
   -- toutes les combinaisons de control bits
   U2:
   for jj in 0 to 7 generate 
   ctrl_words(jj) <= DIN(3 + 4*jj downto 0 + 4*jj);
   end generate;
   
   -- successfull ctrl signals 
   ctrl_bits_i <= DIN(31 downto 28);
   fval_i      <= fvals_i(7);
   lval_i      <= lvals_i(7);
   
   --------------------------------------------------
   -- signaux pour calibration 
   --------------------------------------------------   
   U3: process(CLK)
   begin
      if rising_edge(CLK) then         
         if sreset = '1' then             
            lvals_i <= (others => '0');
            fvals_i <= (others => '0');
            for jj in 0 to 7 loop
               ctrl_words_last(jj) <= (others => '0'); 
            end loop;
            
         else		 
            
            -- last control bits
            ctrl_words_last <= ctrl_words;    -- valeur précédente de ctrl_words
            
            for jj in 0 to 7 loop
               
               ---------------------------------------
               -- fval                                
               ---------------------------------------
               -- montée
               if ctrl_words_last(jj) = x"3" and ctrl_words(jj) /= x"3" then
                  fvals_i(jj) <= '1';
               end if;               
               -- descente
               if ctrl_words_last(jj) /= x"3" and ctrl_words(jj) = x"3" then
                  fvals_i(jj) <= '0';
               end if;               
               
               ---------------------------------------
               -- lval                                
               ---------------------------------------
               -- montée
               if ctrl_words_last(jj) /= x"E" and ctrl_words(jj) = x"E" then
                  lvals_i(jj) <= '1';
               end if;               
               -- descente
               if ctrl_words_last(jj) = x"E" and ctrl_words(jj) /= x"E" then
                  lvals_i(jj) <= '0';
               end if;               
               
            end loop;
            
         end if;
      end if;	
   end process;
   
   --------------------------------------------------
   -- signaux de sortie 
   --------------------------------------------------   
   U4: process(CLK)
   begin
      if rising_edge(CLK) then         
         if sreset = '1' then             
            dout_dval_i <= '0';
            output_en <= '0';
            fval_last <= '0';
            
         else		 
            
            fval_last <= fval_i;
            ctrl_bits_last <= ctrl_bits_i;
            
            -- generation d'un signal de synhcro de la sortie des données
            if SUCCESS = '1' and fval_last = '0' and fval_i = '1' then
               output_en <= '1';                 -- synchro parfaite 
            end if;
            
            ---------------------------------------
            -- definition des sorties                               
            ---------------------------------------
            -- dout_dval_i
            dout_dval_i <= output_en and (fval_i or  (fval_last and not fval_i));   -- on envoie aussi la fin de fval à la sortie au moyen de (fval_last and not fval_i)
            
            -- dout_i
            dout_i(31) <= '0';         -- non utilisé
            dout_i(30) <= fval_i;      -- fval  
            dout_i(29) <= lval_i;
            dout_i(28) <= lval_i;
            
            ---- lval and dval
--            if ctrl_bits_last /= x"E" and ctrl_bits_i = x"E" then
--               dout_i(29) <= '1';    -- lval
--               dout_i(28) <= '1';    -- dval
--            end if;               
--            if ctrl_bits_last = x"E" and ctrl_bits_i /= x"E" then
--               dout_i(29) <= '0';    -- lval
--               dout_i(28) <= '0';    -- dval
--            end if;
            
            -- pix data
            dout_i(27 downto 14) <= DIN(27 downto 14); -- pixel 1  
            dout_i(13 downto 0)  <= DIN(13 downto 0);  -- pixel 0             
            
         end if;
      end if;	
   end process;
   
   
end rtl;
