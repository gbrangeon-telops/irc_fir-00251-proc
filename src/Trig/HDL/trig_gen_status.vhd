------------------------------------------------------------------
--!   @file : trig_gen_status
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
use IEEE.numeric_std.all;

entity trig_gen_status is
   port(
      ARESET          : in std_logic;
      CLK             : in std_logic;
      TRIG_CTLER_STAT : in std_logic_vector(7 downto 0);
      RESET_ERR       : in std_logic;
      STATUS          : out std_logic_vector(15 downto 0);
      ERROR           : out std_logic
      );
end trig_gen_status;

architecture rtl of trig_gen_status is
   signal sreset                          : std_logic; 
   signal reset_err_i                     : std_logic;
   signal done_i                          : std_logic;
   signal TS_fifo_wr_err_latch            : std_logic;
   signal TS_offset_err_latch             : std_logic;
   signal TSfifo_overflow                 : std_logic; 
   signal TimeOffset_err                  : std_logic; 
   signal TSfifo_cleared                  : std_logic; 
   signal Overwrite_done                  : std_logic; 
   signal TimeStamp_Ready                 : std_logic; 
   signal Trig_ctler_done                 : std_logic;
   signal Gated_image                     : std_logic;
   signal trig_out_Allow_HighTimeChange   : std_logic;
   signal fpa_trig_Allow_HighTimeChange   : std_logic;
   
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
begin 
   
   --output map             
   ERROR <= '0';
   STATUS(15 downto 9) <= (others =>'0');
   STATUS(8) <= trig_out_Allow_HighTimeChange;
   STATUS(7) <= fpa_trig_Allow_HighTimeChange;
   STATUS(6) <= Gated_image;
   STATUS(5) <= '0';    
   STATUS(4) <= '0';
   STATUS(3) <= '0';
   STATUS(2) <= '0';
   STATUS(1) <= '0';
   STATUS(0) <= Trig_ctler_done;	
   
   trig_out_Allow_HighTimeChange <= TRIG_CTLER_STAT(3);  -- pour savoir quand changer en live la durée haute des trigs en accord avec le changement live du temps d'integration
   fpa_trig_Allow_HighTimeChange <= TRIG_CTLER_STAT(2);  -- pour savoir quand changer en live la durée haute des trigs en accord avec le changement live du temps d'integration 
   Gated_image     <= TRIG_CTLER_STAT(1);
   Trig_ctler_done <= TRIG_CTLER_STAT(0); 
   
   
   -- sync reset
   U1 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK); 	
   
   -- synchronisation du reset des erreurs dans le domaine de clk du bloc 
   U2 : process(CLK) 
   begin
      if rising_edge(CLK) then
         reset_err_i <= RESET_ERR; 
      end if;	  
   end process;
   
   -- process pour lacther les erreurs
   U3 : process(CLK) 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            TS_offset_err_latch <='0';
            TS_fifo_wr_err_latch <= '0';
         else
            --            -- erreur :aucun offset d'ecrit avant le debut des acquisitions
            --            if TimeOffset_err = '1' then 
            --               TS_offset_err_latch <= '1';
            --            elsif reset_err_i ='1' then
            --               TS_offset_err_latch <= '0';
            --            end if;
            
            -- erreur :overflow du fifo du timeStamp
            --            if TSfifo_overflow = '1' then 
            --               TS_fifo_wr_err_latch <= '1';
            --            elsif reset_err_i ='1' then
            --               TS_fifo_wr_err_latch <= '0';
            --            end if;
         end if;
      end if;
   end process;
   
end rtl;
