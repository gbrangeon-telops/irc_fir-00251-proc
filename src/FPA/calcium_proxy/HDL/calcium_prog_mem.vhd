------------------------------------------------------------------
--!   @file : calcium_prog_mem
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_define.all;
use work.proxy_define.all;

entity calcium_prog_mem is
   port (
      ARESET       : in std_logic;
      A_CLK        : in std_logic;  -- MB_CLK
      B_CLK        : in std_logic;  -- PROG_CLK
      A_RST_BUSY   : out std_logic;
      B_RST_BUSY   : out std_logic;
      
      -- port A_WR: réservé au MB pour ecrire la config à envoyer au ROIC (zone TX de la ram)
      A_WR         : in std_logic;
      A_WR_ADD     : in std_logic_vector(8 downto 0);
      A_WR_DATA    : in std_logic_vector(15 downto 0);
      
      -- port A_RD: réservé au MB pour lire les données en provenance du ROIC (zone RX de la ram)
      A_RD         : in std_logic;
      A_RD_ADD     : in std_logic_vector(8 downto 0);
      A_RD_DATA    : out std_logic_vector(15 downto 0);
      A_RD_DVAL    : out std_logic;
      A_ERR        : out std_logic;
      
      -- port B_WR: réservé au PROG pour ecrire les données en provenance du ROIC (zone RX de la ram)
      B_WR         : in std_logic;
      B_WR_ADD     : in std_logic_vector(8 downto 0);
      B_WR_DATA    : in std_logic_vector(15 downto 0);
      
      -- port B_RD: réservé au PROG pour lire la config à envoyer au ROIC (zone TX de la ram)
      B_RD         : in std_logic;
      B_RD_ADD     : in std_logic_vector(8 downto 0);
      B_RD_DATA    : out std_logic_vector(15 downto 0);
      B_RD_DVAL    : out std_logic;
      B_ERR        : out std_logic
   );
end calcium_prog_mem;

architecture rtl of calcium_prog_mem is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;

   component calciumD_prog_ram
      port (
         clka : in std_logic;
         rsta : in std_logic;
         wea : in std_logic_vector(0 downto 0);
         addra : in std_logic_vector(8 downto 0);
         dina : in std_logic_vector(15 downto 0);
         douta : out std_logic_vector(15 downto 0);
         clkb : in std_logic;
         web : in std_logic_vector(0 downto 0);
         addrb : in std_logic_vector(8 downto 0);
         dinb : in std_logic_vector(15 downto 0);
         doutb : out std_logic_vector(15 downto 0);
         rsta_busy : out std_logic;
         rstb_busy : out std_logic
      );
   end component;
   
   signal sreset_A_CLK        : std_logic;
   signal sreset_B_CLK        : std_logic;
   signal a_dval_pipe         : std_logic_vector(1 downto 0);
   signal b_dval_pipe         : std_logic_vector(1 downto 0);
   signal a_wr_i              : std_logic_vector(0 downto 0);
   signal b_wr_i              : std_logic_vector(0 downto 0);
   signal a_add_i             : std_logic_vector(A_RD_ADD'length-1 downto 0);
   signal b_add_i             : std_logic_vector(B_RD_ADD'length-1 downto 0);
   
begin
   
   --------------------------------------------------
   -- Resets
   --------------------------------------------------
   U1A : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => A_CLK,
      SRESET => sreset_A_CLK
   );
   
   U1B : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => B_CLK,
      SRESET => sreset_B_CLK
   );
   
   --------------------------------------------------
   -- Gestion port A de la RAM
   --------------------------------------------------
   U2A : process(A_CLK)
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
            else
               a_wr_i(0) <= '0';
            end if;
            
            -- erreur à eviter par design
            if (A_RD and A_WR) = '1' then
               A_ERR <= '1';  -- latch
            end if;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- Gestion port B de la RAM
   --------------------------------------------------
   U2B : process(B_CLK)
   begin
      if rising_edge(B_CLK) then
         if sreset_B_CLK = '1' then
            B_RD_DVAL <= '0';
            b_dval_pipe <= (others =>'0');
            b_wr_i(0) <= '0';
            B_ERR <= '0';
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
            else
               b_wr_i(0) <= '0';
            end if;
            
            -- erreur à eviter par design
            if (B_RD and B_WR) = '1' then
               B_ERR <= '1';  -- latch
            end if;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- BRAM
   --------------------------------------------------
   U3 : calciumD_prog_ram
   port map (
      rsta => ARESET,
      clka => A_CLK,
      wea => a_wr_i,
      addra => a_add_i,
      dina => A_WR_DATA,
      douta => A_RD_DATA,
      clkb => B_CLK,
      web => b_wr_i,
      addrb => b_add_i,
      dinb => B_WR_DATA,
      doutb => B_RD_DATA,
      rsta_busy => A_RST_BUSY,
      rstb_busy => B_RST_BUSY
   );
   
end rtl;
