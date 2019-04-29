---------------------------------------------------------------------------------------------------
--
-- Title       : ddr_aoi_add_gen
-- Author      : Edem Nofodjie
-- Company     : Telops Inc.
--
---------------------------------------------------------------------------------------------------
-- $Author:  $
-- $LastChangedDate: 2012-07-06 15:46:21 -0400 (ven., 06 juil. 2012) $
-- $Revision: 11540 $ 
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;
use work.calib_define.all;

entity ddr_aoi_add_gen is
   generic(
      IMG_WIDTH_MAX  : integer := 640;
      IMG_HEIGHT_MAX : integer := 512
      );      
   port(   
      --
      ARESET         : in std_logic; 
      CLK            : in std_logic;         
      
      NEW_IMG        : in std_logic;
      
      AOI_PARAM      : in aoi_param_type; 
      AOI_PARAM_DVAL : in std_logic;
      
      ADD_OFFSET     : in  std_logic_vector(31 downto 0); -- tous les offset à ajouter à l'adresse generée
      
      -- Outgoing Addresses   
      ADD_MOSI       : out t_axi4_stream_mosi72;
      ADD_MISO       : in t_axi4_stream_miso
      );
end ddr_aoi_add_gen;

architecture RTL of ddr_aoi_add_gen is      
   
   
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic);
   end component; 
   
   type add_gen_fsm_type is (idle, init_st1, init_st2, init_st3, line_addgen_st, count_inc_st);
   
   signal add_gen_fsm  : add_gen_fsm_type;
   --signal dmver_xCache : std_logic_vector(3 downto 0);
   --signal dmver_xUser  : std_logic_vector(3 downto 0);
   signal dmver_RSVD   : std_logic_vector(3 downto 0);
   signal dmver_DRR    : std_logic;
   signal dmver_DSA    : std_logic_vector(5 downto 0);
   signal dmver_TYPE   : std_logic;
   signal dmver_TAG    : std_logic_vector(3 downto 0);
   signal dmver_SADDR  : std_logic_vector(31 downto 0);
   signal dmver_EOF    : std_logic;
   signal dmver_BTT    : std_logic_vector(22 downto 0);
   signal dmver_dval   : std_logic;
   signal sreset       : std_logic;
   signal add_dval     : std_logic;
   signal line_cnt     : unsigned(15 downto 0);
   signal add          : integer;
   signal add_eof      : std_logic;
   signal img_offsetx  : integer range 0 to IMG_WIDTH_MAX;
   signal img_offsety  : integer range 0 to IMG_HEIGHT_MAX;
   signal img_width    : integer range 0 to IMG_WIDTH_MAX;
   signal img_height   : integer range 0 to IMG_HEIGHT_MAX;
   signal add_offset_u : unsigned(ADD_OFFSET'range);
   
begin                      
   
   ----------------------------------------
   -- datamover constants
   ----------------------------------------
   --dmver_xCache <= "0011";
   --dmver_xUser  <= "0000";
   dmver_RSVD   <= (others => '0');       
   dmver_DRR    <= '0';
   dmver_DSA    <= (others => '0');
   dmver_TYPE   <= '1'; 
   
   ----------------------------------------
   -- sync reset
   ----------------------------------------
   U1 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK);
   
   ----------------------------------------
   -- add_gen
   ----------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            add_gen_fsm <= idle;
            add_dval <= '0';
            add_eof <= '0';
            add_offset_u <= (others => '0');
         else      
            
            if ADD_MISO.TREADY = '1' then 
               case add_gen_fsm is
                  
                  when idle => 
                     add_dval <= '0';
                     line_cnt <= to_unsigned(1, line_cnt'length);
                     add_eof <= '0';
                     if AOI_PARAM_DVAL = '1' then
                        img_width   <= to_integer(AOI_PARAM.WIDTH);
                        img_height  <= to_integer(AOI_PARAM.HEIGHT);
                        img_offsetx <= to_integer(AOI_PARAM.OFFSETX);
                        img_offsety <= to_integer(AOI_PARAM.OFFSETY);                        
                     end if;
                     if NEW_IMG = '1' then            -- generer les adresses seulement si une image est entrain de rentrer dans la chaine
                        add_offset_u <= unsigned(ADD_OFFSET);
                        add_gen_fsm <= init_st1; 
                     end if;
                  
                  when init_st1 =>
                     add <= img_offsety * IMG_WIDTH_MAX; 
                     add_gen_fsm <= init_st2;
                  
                  when init_st2 =>
                     add <= add + img_offsetx;
                     add_gen_fsm <= init_st3;
                  
                  when init_st3 =>
                     add <= add - IMG_WIDTH_MAX;    -- pour tenir compte de l'ajout de IMG_WIDTH_MAX dans le prochain etat 
                     add_gen_fsm <= line_addgen_st;
                  
                  when line_addgen_st =>
                     add <= add + IMG_WIDTH_MAX;
                     add_dval <= '1';
                     if line_cnt = img_height then
                        add_eof <= '1';
                        add_gen_fsm <= idle;
                     else
                        add_gen_fsm <= count_inc_st;
                     end if;
                  
                  when count_inc_st =>
                     add_dval <= '0';
                     line_cnt <= line_cnt + 1;                  
                     add_gen_fsm <= line_addgen_st;
                  
                  when others =>                                
                  
               end case;
            end if;
         end if;
         
      end if;
   end process;                            
   
   ----------------------------------------
   -- outputs
   ----------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then         
         
         if ADD_MISO.TREADY = '1' then 
            -- 
            dmver_TAG    <= resize('0' & std_logic(line_cnt(0)), dmver_TAG'length);  -- change à chaque changement de ligne.
            if add_dval = '1' then -- pour éviter des problèmes vus en simulation
               dmver_SADDR  <= std_logic_vector(to_unsigned(8*add, 32) + add_offset_u);
            end if;
            dmver_EOF    <= add_eof;
            dmver_BTT    <= std_logic_vector(to_unsigned(8*img_width, dmver_BTT'length));
            dmver_dval   <= add_dval;            
            --
            ADD_MOSI.TDATA  <= dmver_RSVD & dmver_TAG & dmver_SADDR & dmver_DRR & dmver_EOF & dmver_DSA & dmver_TYPE & dmver_BTT;
            ADD_MOSI.TVALID <= dmver_dval;
            ADD_MOSI.TSTRB  <= (others => '1');
            ADD_MOSI.TKEEP  <= (others => '1');
            ADD_MOSI.TLAST  <= '0';
            ADD_MOSI.TID    <= (others => '0');
            ADD_MOSI.TDEST  <= (others => '0');
            ADD_MOSI.TUSER  <= (others => '0'); 
         end if;
      end if;
   end process;
   
end RTL;
