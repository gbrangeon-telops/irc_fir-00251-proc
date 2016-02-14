------------------------------------------------------------------
--!   @file : dfpa_cfg_dpram
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
use IEEE.numeric_std.ALL;


entity dfpa_cfg_dpram is
   port(
      ARESET       : in std_logic;
      A_CLK        : in std_logic;
      B_CLK        : in std_logic;
      
      -- port A : WR: réservé au MB pour y ecrire continuellement dans la zone A de la ram, la config à envoyer au détecteur 
      A_WR         : in std_logic;
      A_WR_ADD     : in std_logic_vector(10 downto 0);
      A_WR_DATA    : in std_logic_vector(7 downto 0);
      
      -- port A : RD: réservé au MB pour y lire les données en provenance du proxy 
      A_RD         : in std_logic;
      A_RD_ADD     : in std_logic_vector(10 downto 0);
      A_RD_DATA    : out std_logic_vector(7 downto 0);
      A_RD_DVAL    : out std_logic;
      A_ERR        : out std_logic;
      
      -- port B : WR pour réecrire la config du MB dans une zone sécurisée B de la memoire. Et aussi pour ecrire le feedback à envoyer au MB.
      B_WR         : in std_logic;
      B_WR_ADD     : in std_logic_vector(10 downto 0);      
      B_WR_DATA    : in std_logic_vector(7 downto 0);
      
      -- port B : RD pour la recopie et aussi pour lire la config de façon securisée dans la zone B  
      B_RD         : in std_logic;
      B_RD_ADD     : in std_logic_vector(10 downto 0);
      B_RD_DATA    : out std_logic_vector(7 downto 0);
      B_RD_DVAL    : out std_logic;
      B_ERR        : out std_logic
      
      );
end dfpa_cfg_dpram;


architecture rtl of dfpa_cfg_dpram is
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;   
   
   component tdp_ram_w8_d2048   -- le true dual port ram n'est disponible qu'en version block ram. Tant què utiliser un block ram, mieux vaut l'utiliser en entier
      port (
         clka  : in std_logic;
         rsta  : in std_logic;
         ena   : in std_logic;
         wea   : in std_logic_vector(0 downto 0);
         addra : in std_logic_vector(10 downto 0);
         dina  : in std_logic_vector(7 downto 0);
         douta : out std_logic_vector(7 downto 0);
         clkb  : in std_logic;
         rstb  : in std_logic;
         enb   : in std_logic;
         web   : in std_logic_vector(0 downto 0);
         addrb : in std_logic_vector(10 downto 0);
         dinb  : in std_logic_vector(7 downto 0);
         doutb : out std_logic_vector(7 downto 0)
         );
   end component;
   
   signal sreset         : std_logic;   
   signal dval_i         : std_logic;   
   signal a_dval_pipe    : std_logic_vector(5 downto 0);
   signal b_dval_pipe    : std_logic_vector(5 downto 0);
   signal a_rd_data_i    : std_logic_vector(A_RD_DATA'length-1 downto 0);
   signal b_rd_data_i    : std_logic_vector(B_RD_DATA'length-1 downto 0);
   signal sreset_A_CLK   : std_logic;
   signal sreset_B_CLK   : std_logic;
   signal a_wr_i         : std_logic_vector(0 downto 0);
   signal b_wr_i         : std_logic_vector(0 downto 0);
   signal a_add_i        : std_logic_vector(A_RD_ADD'length-1 downto 0);
   signal b_add_i        : std_logic_vector(B_RD_ADD'length-1 downto 0);
   signal a_wr_data_i    : std_logic_vector(A_WR_DATA'length-1 downto 0);
   signal b_wr_data_i    : std_logic_vector(B_WR_DATA'length-1 downto 0);
   
   
   
begin
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1A: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset_A_CLK,
      CLK   => A_CLK);
   
   U1B: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset_B_CLK,
      CLK   => B_CLK);
   
   ------------------------------------------------------
   -- lecture de la RAM : generation de A_RD_DVAL
   ------------------------------------------------------	
   U2A: process(A_CLK)
   begin
      if rising_edge(A_CLK) then 
         if sreset_A_CLK = '1' then	
            A_RD_DVAL <= '0';
            a_dval_pipe <= (others =>'0');
            a_wr_i(0) <= '0';
            A_ERR <= '0';
         else
            
            -- generation de A_RD_DVAL            
            a_dval_pipe(0) <= A_RD; 
            a_dval_pipe(1) <= a_dval_pipe(0);
            A_RD_DVAL <= a_dval_pipe(1);
            
            -- arbitreur 
            if A_RD = '1' then
               a_add_i <= A_RD_ADD;
               a_wr_i(0) <= '0';
            elsif A_WR = '1' then 
               a_add_i <= A_WR_ADD;
               a_wr_i(0) <= '1';
               a_wr_data_i <= A_WR_DATA;
            else
               a_wr_i(0) <= '0';
            end if;
            
            -- erreur à eviter par design 
            if (A_RD and A_WR) = '1' then
               A_ERR <='1';  -- latch
            end if;
            
         end if;
      end if;		
   end process;
   
   ------------------------------------------------------
   -- lecture de la RAM : generation de B_RD_DVAL
   ------------------------------------------------------	
   U2B: process(B_CLK)
   begin
      if rising_edge(B_CLK) then 
         if sreset_B_CLK = '1' then	
            B_RD_DVAL <= '0';
            b_dval_pipe <= (others =>'0');
            b_wr_i(0) <= '0';
            B_ERR <='0';
         else
            
            -- generation de B_RD_DVAL            
            b_dval_pipe(0) <= B_RD; 
            b_dval_pipe(1) <= b_dval_pipe(0);
            B_RD_DVAL <= b_dval_pipe(1);
            
            -- arbitreur 
            if B_RD = '1' then
               b_add_i <= B_RD_ADD;
               b_wr_i(0) <= '0';
            elsif B_WR = '1' then 
               b_add_i <= B_WR_ADD;
               b_wr_i(0) <= '1';
               b_wr_data_i <= B_WR_DATA;
            else
               b_wr_i(0) <= '0';
            end if;
            
            -- erreur à eviter par design 
            if (B_RD and B_WR) = '1' then
               B_ERR <='1';  -- latch
            end if;
            
         end if;
      end if;		
   end process;
   
   ------------------------------------------------------
   -- mapping  RAM
   ------------------------------------------------------   
   U3 : tdp_ram_w8_d2048
   port map (
      -- port A reservé au MB pour ecrire serial config dans la zone A non sécurisée de la RAM
      clka  => A_CLK,
      rsta  => ARESET,
      ena   => '1',
      wea   => a_wr_i,
      addra => a_add_i,
      dina  => a_wr_data_i,
      douta => A_RD_DATA,       
      -- port B reservé au serialiser pour recopier la config de la zone A vers la zone B sécurisée et la lire
      clkb  => B_CLK,
      rstb  => ARESET,
      enb   => '1',
      web   => b_wr_i,
      addrb => b_add_i,
      dinb  => b_wr_data_i,
      doutb => B_RD_DATA
      );
   
end rtl;
