-------------------------------------------------------------------------------
--
-- Title       : irig_alphab_detector_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_alphab_detector_v2.vhd
-- Generated   : Tue Sep 13 12:22:28 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--library Common_HDL;
use work.tel2000.all;
use work.IRIG_define_v2.all;

entity irig_alphab_detector_v2 is
   port(
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      CARRIER_REFPULSE : in std_logic;
      
      RX_MOSI          : in t_ll_mosi1;
      RX_MISO          : out t_ll_miso;
      BIT_MISO         : in t_ll_miso;
      BIT_MOSI         : out t_ll_mosi1;
      POS_IDENTIFIER   : out std_logic;
      SYNC_FOUND       : out std_logic;              -- sortie d'une bascule redeclenchable qui monte à '1' lorsqu'un element de synchronisation '001' est trouvé et reste à '1' pendant la durée de 11 elements binaires puis retombe à '0' si aucun autre element de synchronisation n'est trouvé.
      ERR              : out std_logic_vector(7 downto 0)
      );
end irig_alphab_detector_v2;



architecture RTL of irig_alphab_detector_v2 is 
   
   constant SYNC_FOUND_DURATION    : integer := IRIG_MORPHEME_RATE_FACTOR + 2;
   constant IRIG_ALPHABET_ONE_M_1  : integer := IRIG_ALPHABET_ONE - 1;
   constant IRIG_ALPHABET_ONE_P_1  : integer := IRIG_ALPHABET_ONE + 1;
   constant IRIG_ALPHABET_ZERO_M_1 : integer := IRIG_ALPHABET_ZERO - 1;
   constant IRIG_ALPHABET_ZERO_P_1 : integer := IRIG_ALPHABET_ZERO + 1;
   constant IRIG_ALPHABET_P_M_1    : integer := IRIG_ALPHABET_P - 1;
   constant IRIG_ALPHABET_P_P_1    : integer := IRIG_ALPHABET_P + 1;
   
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   type alphab_fsm_type is (idle, grab_bit_st, gen_morpheme_st);     
   
   signal alphab_fsm            :alphab_fsm_type;
   
   
   signal sreset                 : std_logic;
   signal sync_found_i           : std_logic;
   signal bit_reg                : std_logic;
   signal bit_reg_dval           : std_logic;
   signal pos_identifier_reg     : std_logic;
   signal din_pipe_i             : std_logic_vector(2 downto 0);
   signal sync_stream            : std_logic;
   signal sum_of_ones            : unsigned(log2(IRIG_MORPHEME_RATE_FACTOR)+1 downto 0);
   signal bit_cnt                : unsigned(log2(IRIG_MORPHEME_RATE_FACTOR)+1 downto 0); 
   signal carrier_cnt            : unsigned(log2(IRIG_MORPHEME_RATE_FACTOR)+1 downto 0);
   signal sync_stream_last       : std_logic;
   signal speed_err              : std_logic;
   signal signal_integrity_err   : std_logic;
   
   attribute keep : string; 
   attribute keep of signal_integrity_err   : signal is "YES";  
   
   
begin
   
   --------------------------------------------------
   -- outputs maps
   --------------------------------------------------   
   RX_MISO <= ('0','0');
   SYNC_FOUND <= sync_found_i;
   BIT_MOSI.DATA <= bit_reg;
   BIT_MOSI.DVAL <= bit_reg_dval; 
   POS_IDENTIFIER <= pos_identifier_reg;
   
   ERR(7 downto 2) <= (others => '0');
   ERR(1) <= signal_integrity_err;
   ERR(0) <= speed_err;
   
   --------------------------------------------------
   -- sync reset 
   --------------------------------------------------
   U1 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK); 
   
   
   --------------------------------------------------
   -- proc
   --------------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            alphab_fsm <= idle; 
            bit_reg_dval <= '0'; 
            pos_identifier_reg <= '0'; 
            sync_stream <= '0';
            signal_integrity_err <= '0';
            speed_err <= '0';
         else  
            
            -- pipe d'entrée
            if RX_MOSI.DVAL = '1' then 
               din_pipe_i(0) <= RX_MOSI.DATA;
               din_pipe_i(2 downto 1) <= din_pipe_i(1 downto 0);               
            end if;
            
            -- detection du caractere de synchro dans le pipe
            if din_pipe_i = "001" then 
               sync_stream <= '1';
            else
               sync_stream <= '0';   
            end if;                                          
            
            -- machine à etats 
            case alphab_fsm is 
               
               when idle =>
                  
                  if sync_stream = '1' then 
                     sum_of_ones <= to_unsigned(1, sum_of_ones'length); -- initialisation à '1' car le premier 1 du morpheme est dejà passé et se retrouve dans le pipe de synchro.
                     bit_cnt <= to_unsigned(1, sum_of_ones'length); 
                     alphab_fsm <= grab_bit_st; 
                  end if;
                  bit_reg_dval <= '0'; 
                  pos_identifier_reg <= '0';
                  signal_integrity_err <= '0';
               
               when grab_bit_st => 
                  
                  if RX_MOSI.DVAL = '1' then
                     if RX_MOSI.DATA = '1' then 
                        sum_of_ones <=  sum_of_ones + 1;  -- on compte le nombre de '1'
                     end if;
                     bit_cnt <= bit_cnt + 1;
                  end if;
                  if bit_cnt = IRIG_MORPHEME_RATE_FACTOR then 
                     alphab_fsm <= gen_morpheme_st;
                  end if;
               
               when gen_morpheme_st =>
                  
                  if sum_of_ones >= IRIG_ALPHABET_ONE_M_1 and sum_of_ones <= IRIG_ALPHABET_ONE_P_1 then
                     bit_reg <= '1';
                     bit_reg_dval <= '1'; 
                     pos_identifier_reg <= '0';                   
                  elsif  sum_of_ones >= IRIG_ALPHABET_ZERO_M_1 and sum_of_ones <= IRIG_ALPHABET_ZERO_P_1  then
                     bit_reg <= '0';
                     bit_reg_dval <= '1'; 
                     pos_identifier_reg <= '0';                     
                  elsif  sum_of_ones >= IRIG_ALPHABET_P_M_1 and sum_of_ones <= IRIG_ALPHABET_P_P_1 then
                     bit_reg_dval <= '0'; 
                     pos_identifier_reg <= '1';
                  else
                     bit_reg_dval <= '0'; 
                     pos_identifier_reg <= '0';
                  end if;
                  
                  if sum_of_ones /= IRIG_ALPHABET_ONE and sum_of_ones /= IRIG_ALPHABET_ZERO and sum_of_ones /= IRIG_ALPHABET_P then 
                     signal_integrity_err <= '1';
                  end if;
                  
                  alphab_fsm <= idle;
               
               when others =>
               
            end case;     
            
            speed_err <= RX_MOSI.DVAL and  BIT_MISO.BUSY;
         end if; 
      end if;       
      
   end process;   
   
   
   --------------------------------------------------
   -- Sync_found generation
   --------------------------------------------------   
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            sync_stream_last <= '0';
            sync_found_i <= '0';
            carrier_cnt <= (others => '0');
         else
            sync_stream_last <= sync_stream;
            if sync_stream_last = '0' and sync_stream = '1' then 
               carrier_cnt <= to_unsigned(SYNC_FOUND_DURATION, carrier_cnt'LENGTH);
            else
               if CARRIER_REFPULSE = '1' and carrier_cnt > 0 then 
                  carrier_cnt <= carrier_cnt - 1;
               end if;
            end if;
            
            if carrier_cnt = 0 then
               sync_found_i <= '0';
            else
               sync_found_i <= '1';
            end if;            
            
         end if;
      end if;
      
   end process;
   
   
end RTL;
