------------------------------------------------------------------
--!   @file : hdr_reorder
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
use work.hder_define.all;

entity hder_reorder is
   generic(
      MATROX_INVERT : boolean := true);
   port(      
      ARESET       : in std_logic;
      CLK_FAST     : in std_logic;      
      WR_ADD_FAST  : in std_logic_vector(5 downto 0);
      WR_DATA_FAST : in std_logic_vector(31 downto 0);      
      BWE_FAST     : in std_logic_vector(3 downto 0); -- byte write enable
      CLK_SLOW     : in std_logic;      
      WR_ADD_SLOW  : in std_logic_vector(5 downto 0);
      WR_DATA_SLOW : in std_logic_vector(31 downto 0);      
      BWE_SLOW     : in std_logic_vector(3 downto 0); -- byte write enable
      RD           : in std_logic;                    -- sert juste à generer DVAL
      RD_ADD       : in std_logic_vector(5 downto 0);
      RD_DATA      : out std_logic_vector(31 downto 0);
      RD_DVAL      : out std_logic       
      );
end hder_reorder;                           

architecture RTL of hder_reorder is 
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component; 
      
   component dp_ram_byte_w32_d64 is
      port (
         clka : in std_logic;
         rsta : in std_logic;
         ena : in std_logic;
         wea : in std_logic_vector(3 downto 0);
         addra : in std_logic_vector(5 downto 0);
         dina : in std_logic_vector(31 downto 0);
         douta : out std_logic_vector(31 downto 0);
         clkb : in std_logic;
         rstb : in std_logic;
         enb : in std_logic;
         web : in std_logic_vector(3 downto 0);
         addrb : in std_logic_vector(5 downto 0);
         dinb : in std_logic_vector(31 downto 0);
         doutb : out std_logic_vector(31 downto 0)
         );
   end component;
   
   signal sreset    : std_logic;   
   signal dval_i    : std_logic;   
   signal dval_pipe : std_logic_vector(5 downto 0);  
   signal ram_dout : std_logic_vector(RD_DATA'length-1 downto 0);
   signal ram_wea, ram_wea_buf   : std_logic_vector(BWE_FAST'range);
   signal ram_dina, ram_dina_buf : std_logic_vector(WR_DATA_FAST'range);
   signal ram_adda, ram_adda_buf : std_logic_vector(RD_ADD'range);
   
   signal ram_web, ram_web_buf   : std_logic_vector(BWE_SLOW'range);
   signal ram_dinb, ram_dinb_buf : std_logic_vector(WR_DATA_SLOW'range);
   signal ram_addb, ram_addb_buf : std_logic_vector(RD_ADD'range);
   
   attribute dont_touch : string;                                   
   attribute dont_touch of ram_dina  : signal is "true";  
   attribute dont_touch of ram_adda  : signal is "true";  
   attribute dont_touch of ram_wea   : signal is "true";  
   attribute dont_touch of ram_dinb  : signal is "true";  
   attribute dont_touch of ram_addb  : signal is "true";  
   attribute dont_touch of ram_web   : signal is "true";  
   attribute dont_touch of RD_DATA   : signal is "true";  
   attribute dont_touch of RD_DVAL   : signal is "true";  
   
begin
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset,
      CLK   => CLK_FAST);
   
   ------------------------------------------------------
   -- contrôle écriture et lecture
   ------------------------------------------------------	
   U2: process(CLK_FAST)
   begin
      if rising_edge(CLK_FAST) then 
         if sreset ='1' then	
            RD_DVAL <= '0';
            dval_pipe <= (others =>'0');            
         else									
            -- commutateur pour adresse 
            ram_wea_buf <= BWE_FAST;   -- pour parfaite synchro entre  bwe_i et add_i
            ram_dina_buf <= WR_DATA_FAST;
            if RD = '1' then 
               ram_adda_buf <= RD_ADD;
            else
               ram_adda_buf <= WR_ADD_FAST; 
            end if;     
            
            -- generation de DVAL            
            dval_pipe(0) <= RD; 
            dval_pipe(1) <= dval_pipe(0);
            dval_pipe(2) <= dval_pipe(1);
            dval_pipe(3) <= dval_pipe(2);
            RD_DVAL <= dval_pipe(3);           
            
            -- données en sortie
            RD_DATA <= ram_dout;	
            
         end if;
      end if;		
   end process;
      
   ----------------------------------------------------------------
   -- mapping special pour supporter Carte Matrox
   -----------------------------------------------------------------
   gen_matrox_invert: if MATROX_INVERT generate      
      begin
      
      U3_invert_A : process(CLK_FAST)
      begin       
         if rising_edge(CLK_FAST) then
            
            -- assignations par defaut
            ram_adda <= ram_adda_buf;
            ram_wea <= ram_wea_buf;
            
            --Carte Matrox(les entitées à largeur de 4 bytes doivent etre inversés)
            if ram_wea_buf = "1111"  then
               ram_dina <= ram_dina_buf(15 downto 0) & ram_dina_buf(31 downto 16);
            else
               ram_dina <= ram_dina_buf;
            end if;   
            
            --Carte Matrox(les entitées à largeur de 1 byte doivent etre inversés)
            case ram_wea_buf is            
               when "1000" => 
                  ram_dina(23 downto 16) <= ram_dina_buf(31 downto 24);
               ram_wea <= "0100";            
               when "0100" =>
                  ram_dina(31 downto 24) <= ram_dina_buf(23 downto 16);
               ram_wea <= "1000";           
               when "0010" =>
                  ram_dina(7 downto 0) <= ram_dina_buf(15 downto 8);
               ram_wea <= "0001";           
               when "0001" =>
                  ram_dina(15 downto 8) <= ram_dina_buf(7 downto 0);
               ram_wea <= "0010";           
               when others =>            
            end case;
            
         end if;         
      end process;
      
      U3_invert_B : process(CLK_SLOW)
      begin       
         if rising_edge(CLK_SLOW) then
            
            ram_web_buf <= BWE_SLOW;   -- pour parfaite synchro entre  bwe_i et add_i
            ram_dinb_buf <= WR_DATA_SLOW;
            ram_addb_buf <= WR_ADD_SLOW; 
            
            -- assignations par defaut
            ram_addb <= ram_addb_buf;
            ram_web <= ram_web_buf;
            
            --Carte Matrox(les entitées à largeur de 4 bytes doivent etre inversés)
            if ram_web_buf = "1111"  then
               ram_dinb <= ram_dinb_buf(15 downto 0) & ram_dinb_buf(31 downto 16);
            else
               ram_dinb <= ram_dinb_buf;
            end if;   
            
            --Carte Matrox(les entitées à largeur de 1 byte doivent etre inversés)
            case ram_web_buf is            
               when "1000" => 
                  ram_dinb(23 downto 16) <= ram_dinb_buf(31 downto 24);
               ram_web <= "0100";            
               when "0100" =>
                  ram_dinb(31 downto 24) <= ram_dinb_buf(23 downto 16);
               ram_web <= "1000";           
               when "0010" =>
                  ram_dinb(7 downto 0) <= ram_dinb_buf(15 downto 8);
               ram_web <= "0001";           
               when "0001" =>
                  ram_dinb(15 downto 8) <= ram_dinb_buf(7 downto 0);
               ram_web <= "0010";           
               when others =>            
            end case;
            
         end if;         
      end process;
   end generate; 
   
   ----------------------------------------------------------------
   -- aucune inversion
   -----------------------------------------------------------------
   gen_matrox_no_invert: if not MATROX_INVERT generate      
      begin
      
      U3_normal_A : process(CLK_FAST)
      begin       
         if rising_edge(CLK_FAST) then
            
            -- assignations par defaut
            ram_adda <= ram_adda_buf;
            ram_wea <= ram_wea_buf;
            ram_dina <= ram_dina_buf;
         end if;
      end process;
      
      U3_normal_B : process(CLK_SLOW)
      begin       
         if rising_edge(CLK_SLOW) then
            
            -- assignations par defaut
            ram_addb <= ram_addb_buf;
            ram_web <= ram_web_buf;
            ram_dinb <= ram_dinb_buf;
         end if;
         
      end process;
   end generate; 
   
   ------------------------------------------------------
   -- mapping avec la ram
   ------------------------------------------------------
   U4 : dp_ram_byte_w32_d64
   port map (
      clka  => CLK_FAST,
      rsta  => sreset,
      ena   => '1',
      wea   => ram_wea,
      addra => ram_adda,
      dina  => ram_dina,
      douta => ram_dout,
      clkb  => CLK_SLOW,
      rstb  => '0',
      enb   => '1',
      web   => ram_web,
      addrb => ram_addb,
      dinb  => ram_dinb,
      doutb => open
      );
   
end RTL;
