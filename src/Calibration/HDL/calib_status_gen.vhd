------------------------------------------------------------------
--!   @file : calib_status_gen
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
use work.tel2000.all;
use work.calib_define.all;

entity calib_status_gen is
   port(
      ARESET     : in std_logic;
      CLK        : in std_logic;
      DINi_MOSI  : in t_axi4_stream_mosi64;
      DINi_MISO  : in t_axi4_stream_miso;
      DOUTi_MISO : in t_axi4_stream_miso;       
      DOUTi_MOSI : in t_axi4_stream_mosi64;
      NEW_IMG    : out std_logic;            -- pulse pour signifier l'entrée d'une nouvelle image dans la chaine
      STAT       : out calib_stat_type;
      RESET_ERR  : in std_logic;
      ERROR      : in std_logic_vector(159 downto 0)
      );
end calib_status_gen;

architecture rtl of calib_status_gen is 
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   signal sreset                   : std_logic;
   signal dval_in                  : std_logic;
   signal dval_out                 : std_logic;
   signal data_count               : integer;
   signal done_i                   : std_logic;
   signal image_in_progress        : std_logic;
   signal image_in_progress_last   : std_logic;
   signal new_img_i                : std_logic;
   signal error_latch              : std_logic_vector(159 downto 0) := (others => '0');
   signal error_found              : std_logic;
   
begin
   
   
   NEW_IMG <= new_img_i;
   STAT.DONE <= done_i; 
   STAT.ERROR_REG(0) <= error_latch(31 downto 0); 
   STAT.ERROR_REG(1) <= error_latch(63 downto 32);
   STAT.ERROR_REG(2) <= error_latch(95 downto 64);
   STAT.ERROR_REG(3) <= error_latch(127 downto 96);
   STAT.ERROR_REG(4) <= error_latch(159 downto 128);
   -------------------------------------------------
   -- synchronisation : reset                                
   -------------------------------------------------
   U1 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK);
   
   -------------------------------------------------
   -- generation du done                            
   -------------------------------------------------
   done_gen_proc: process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' then
            dval_in <= '0'; 
            dval_out <= '0';
            data_count <= 0;
            done_i <= '1';  -- fait expres pour que la config puisse rentrer
            image_in_progress <= '0';
            image_in_progress_last <= '0';
            new_img_i <= '0';
            error_found <= '0';
            
         else                                           
            -- pulse pour traquer le premier pixel d'une trame  qui est entré dans la chaine
            dval_in <= DINi_MOSI.TVALID and DINi_MISO.TREADY;
            
            -- pulse pour traquer le dernier pixel d'une trame sortant de la chaine   
            dval_out <= DOUTi_MOSI.TVALID and DOUTi_MISO.TREADY;
            
            -- compteur de pixel en transit
            if DINi_MOSI.TVALID = '1' and DINi_MISO.TREADY = '1' then
               -- pixel in
               if DOUTi_MOSI.TVALID = '0' or DOUTi_MISO.TREADY = '0' then
                  -- no pixel out
                  data_count <= data_count + 1;
               end if;
            end if;
            
            if DOUTi_MOSI.TVALID = '1' and DOUTi_MISO.TREADY = '1' and data_count /= 0 then
               -- pixel out
               if DINi_MOSI.TVALID = '0' or DINi_MISO.TREADY = '0' then
                  -- no pixel in
                  data_count <= data_count - 1;
               end if;
            end if;
            
            -- detection de l'entrée d'une nouvelle image (s'il n'y a pas de corruption) 
            image_in_progress_last <= image_in_progress;
            if DINi_MOSI.TVALID = '1' and DINi_MOSI.TID = (0 downto 0 => '1') and DINi_MISO.TREADY = '1' then --detection d'un header entrant
               image_in_progress <= '1';
            end if;
            if DINi_MOSI.TVALID = '1' and DINi_MOSI.TID = (0 downto 0 => '0') and DINi_MISO.TREADY = '1' and DINi_MOSI.TLAST = '1' then
               image_in_progress <= '0';
            end if; 
            
            -- s'assurer que le compte des pixels est bon        
            if data_count = 0 then
               done_i <= not image_in_progress;               
            else
               done_i <= '0';
            end if;      
            
            new_img_i <= image_in_progress and not image_in_progress_last;
            
            -- latch des erreurs
            -- latch des erreurs
            for i in 0 to ERROR'LENGTH-1 loop
               if ERROR(i) = '1'  then  
                  error_latch(i)  <=  '1';
               end if;                                 
            end  loop;
            
            -- gestion du latch
            if RESET_ERR = '1' then 
               error_found <= '0';
               error_latch <= (others => '0');
            else
               if ERROR /= (ERROR'LENGTH-1 downto 0 => '0') then
                  error_found <= '1';         
               end if;
            end if;            
            
         end if;     
      end if;    
   end process;  
   
   
   
end rtl;
