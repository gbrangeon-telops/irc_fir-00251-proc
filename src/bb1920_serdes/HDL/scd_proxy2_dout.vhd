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
library work;
use work.proxy_define.all;
use IEEE.std_logic_misc.all;

entity scd_proxy2_dout is
   port(   
      
      --
      ARESET             : in std_logic;
      CLK                : in std_logic;
      
      --inputs
      DIN                : in std_logic_vector(31 downto 0);
      SUCCESS            : in std_logic;
      
      -- delay calibration side
      FVALS              : out std_logic_vector(7 downto 0);
      LVALS              : out std_logic_vector(7 downto 0);
      
      -- downstream side
      DOUT               : out std_logic_vector(35 downto 0);
      DOUT_DVAL          : out std_logic;
      
      PROXY_ALONE_MODE   : in std_logic 
      
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
   
   signal sreset             : std_logic;	
   signal fvals_i 	        : std_logic_vector(7 downto 0);
   signal lvals_i 	        : std_logic_vector(7 downto 0);
   signal ctrl_words         : array_type;
   signal ctrl_words_last    : array_type;
   signal dual_data_i        : std_logic_vector(27 downto 0) := (others => '0');
   signal dout_reg           : std_logic_vector(35 downto 0) := (others => '0');
   signal dout_dval_i        : std_logic := '0';
   signal output_en          : std_logic;
   signal lval_last          : std_logic;
   signal frame_init_tag     : std_logic_vector(3 downto 0) := CBITS_FRM_IDLE_ID;
   
   constant C_FVAL_TRANSITION_LEN  : integer := 3;
   signal fval_pipe 	              : std_logic_vector(C_FVAL_TRANSITION_LEN-1 downto 0) := (others => '0'); 
   
begin
   
   --------------------------------------------------
   -- outputs mapping 
   --------------------------------------------------    
   FVALS                <= fvals_i;
   LVALS                <= lvals_i;   
   DOUT_DVAL            <= dout_dval_i;
   DOUT                 <= dout_reg;                  
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
            ctrl_words_last <= ctrl_words;    -- valeur pr�c�dente de ctrl_words
            
            for jj in 0 to 7 loop
               
               ---------------------------------------
               -- fval                                
               ---------------------------------------
               -- mont�e
               if ctrl_words_last(jj) = frame_init_tag and ctrl_words(jj) /= frame_init_tag then            
                  fvals_i(jj) <= '1';                                                
               end if;               
               -- descente
               if ctrl_words_last(jj) /= frame_init_tag and ctrl_words(jj) = frame_init_tag then
                  fvals_i(jj) <= '0';
               end if;               
               
               ---------------------------------------
               -- lval                                
               ---------------------------------------
               -- mont�e
               if ctrl_words_last(jj) /= CBITS_PIXEL_ID and ctrl_words(jj) = CBITS_PIXEL_ID then
                  lvals_i(jj) <= '1';
               end if;               
               -- descente
               if ctrl_words_last(jj) = CBITS_PIXEL_ID and ctrl_words(jj) /= CBITS_PIXEL_ID then
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
            dout_reg <= (others => '0');
            output_en <= '0';
            lval_last <= '0';
         else		 

            lval_last <= lvals_i(7);
            fval_pipe(0) <= fvals_i(7);
            for i in 1 to C_FVAL_TRANSITION_LEN-1 loop
                fval_pipe(i) <= fval_pipe(i-1);        
            end loop;

            -- generation d'un signal de synhcro de la sortie des donn�es
            if SUCCESS = '1' and fval_pipe(0) = '0' and fvals_i(7) = '1' then
               output_en <= '1';                 
            end if;  

            ---------------------------------------
            -- definition des sorties                               
            ---------------------------------------
            
            -- Explications sur dout_dval_i : On ins�re quelques donn�es invalides aux transitions de fval et une seule donn�e invalide aux descentes de lval.     
            -- Il faut que le nombre de donn�es invalides aux transitions de fval soit assez grand pour qu'� la fin d'un frame le FVAL
            -- � la sortie du fifo du "pr�sent" dans le scd_proxy2_real_data tombe � z�ro. 
            -- Une transisiton minimale de 3 donn�es invalides est requise puisque dans le scd_proxy2_real_data on regarde 2 transactions dans le future. 
            -- Il est aussi important d'ins�rer au plus une seule donn�e invalide entre les lignes.
            dout_dval_i <= output_en and (lvals_i(7) or (not and_reduce(fval_pipe & fvals_i(7)) and or_reduce(fval_pipe & fvals_i(7))) or (lval_last and not lvals_i(7)));   
           
            dual_data_i(27 downto 14) <= DIN(27 downto 14); -- pixel 1  
            dual_data_i(13 downto 0)  <= DIN(13 downto 0);  -- pixel 0
            
            dout_reg(35)             <= '0';              -- non utilis�
            dout_reg(34  downto  31) <= ctrl_words(7);    -- les controlBits. Ils sont en avance de 1 CLK sur les dual_data_i et c'est voulu ainsi.
            dout_reg(30)             <= fvals_i(7);
            dout_reg(29)             <= lvals_i(7);
            dout_reg(28)             <= lvals_i(7);       -- dval identique � lval
            dout_reg(27 downto  0)   <= dual_data_i;      -- les deux pixels. Ils sont en retard de 1 CLK sur les controlBits

         end if;
      end if;	
   end process;
   
      
   U5: process(CLK)
   begin
      if rising_edge(CLK) then         
         if sreset = '1' then             
            frame_init_tag <= CBITS_FRM_IDLE_ID;
         else		 
            if PROXY_ALONE_MODE = '1' then 
               frame_init_tag <= CBITS_FRM_IDLE_TST_PTRN_ID;
            else  
               frame_init_tag <= CBITS_FRM_IDLE_ID;
            end if;
         end if;
      end if;	
   end process;
   
end rtl;
