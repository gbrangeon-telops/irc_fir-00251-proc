------------------------------------------------------------------
--!   @file : isc0207A_pixel_reorder
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
use work.Fpa_Common_Pkg.all;
use work.tel2000.all;

entity isc0207A_pixel_reorder is
   port(		 
      ARESET        : in std_logic;
      CLK           : in std_logic;
      
      QUAD1_MOSI    : in t_ll_ext_mosi72;
      QUAD1_MISO    : out t_ll_ext_miso;
      
      QUAD2_MOSI    : in t_ll_ext_mosi72;
      QUAD2_MISO    : out t_ll_ext_miso;
      
      QUAD3_MOSI    : in t_ll_ext_mosi72;
      QUAD3_MISO    : out t_ll_ext_miso;
      
      QUAD4_MOSI    : in t_ll_ext_mosi72;
      QUAD4_MISO    : out t_ll_ext_miso;
      
      DOUT_MOSI     : out t_axi4_stream_mosi32; 
      DOUT_MISO     : in t_axi4_stream_miso;
      
      ERR           : out std_logic   
      
      );
end isc0207A_pixel_reorder;


architecture rtl of isc0207A_pixel_reorder is
   
   component fwft_sfifo_w33_d16
      port (
         clk   : in std_logic;
         rst   : in std_logic;
         din   : in std_logic_vector(32 downto 0);
         wr_en : in std_logic;
         rd_en : in std_logic;
         dout  : out std_logic_vector(32 downto 0);
         full  : out std_logic;
         overflow : out std_logic;
         empty : out std_logic;
         valid : out std_logic
         );
   end component;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   --type reorder_sm_type is (idle, samp_on_st, samp_off_st);
   type fifo_data_type is array (1 to 8) of std_logic_vector(32 downto 0);
   
   --signal reorder_sm       : reorder_sm_type;
   signal sreset           : std_logic;
   signal fifo_din         : fifo_data_type;
   signal fifo_dout        : fifo_data_type;
   signal fifo_wr_en       : std_logic_vector(1 to 8);
   signal fifo_rd_en       : std_logic_vector(1 to 8);
   signal fifo_dval        : std_logic_vector(1 to 8);
   signal fifo_full        : std_logic_vector(1 to 8);
   signal dout             : std_logic_vector(31 downto 0);
   signal dout_dval        : std_logic;
   signal dout_eof         : std_logic;
   signal count            : integer range 1 to 8;
   signal err_i            : std_logic;
   
   
begin
   
   
   
   --------------------------------------------------
   -- outputs maps
   -------------------------------------------------- 
   DOUT_MOSI.TDATA <=  dout(15 downto 0) & dout(31 downto 16); -- inversion pour compenser celle dans le header inserter
   DOUT_MOSI.TVALID<=  dout_dval;
   DOUT_MOSI.TSTRB <=  dout_dval & dout_dval & dout_dval & dout_dval;
   DOUT_MOSI.TKEEP <=  dout_dval & dout_dval & dout_dval & dout_dval;
   DOUT_MOSI.TLAST <=  dout_eof;
   DOUT_MOSI.TUSER <=  (others => '0');
   DOUT_MOSI.TID   <=  (others => '0');
   DOUT_MOSI.TDEST <=  (others => '0');
   
   QUAD1_MISO.BUSY  <=  fifo_full(1) or fifo_full(2);--not DOUT_MISO.TREADY;     -- on repartir les fifo_full.
   QUAD1_MISO.AFULL <=  '0';
   
   QUAD2_MISO.BUSY  <=  fifo_full(3) or fifo_full(4);--not DOUT_MISO.TREADY;
   QUAD2_MISO.AFULL <=  '0';
   
   QUAD3_MISO.BUSY  <=  fifo_full(5) or fifo_full(6);--not DOUT_MISO.TREADY;
   QUAD3_MISO.AFULL <=  '0';
   
   QUAD4_MISO.BUSY  <=  fifo_full(7) or fifo_full(8);--not DOUT_MISO.TREADY;
   QUAD4_MISO.AFULL <=  '0';
   
   ERR <= err_i;
   
   --------------------------------------------------
   -- inputs maps
   --------------------------------------------------   
   fifo_din(8)   <= QUAD4_MOSI.EOF & QUAD4_MOSI.DATA(69 downto 54) & QUAD4_MOSI.DATA(51 downto 36);
   fifo_wr_en(8) <= QUAD4_MOSI.DVAL;
   
   fifo_din(7)   <= '0' & QUAD4_MOSI.DATA(33 downto 18) & QUAD4_MOSI.DATA(15 downto 0);
   fifo_wr_en(7) <= QUAD4_MOSI.DVAL;
   
   fifo_din(6)   <= '0' & QUAD3_MOSI.DATA(69 downto 54) & QUAD3_MOSI.DATA(51 downto 36);
   fifo_wr_en(6) <= QUAD3_MOSI.DVAL;
   
   fifo_din(5)   <= '0' & QUAD3_MOSI.DATA(33 downto 18) & QUAD3_MOSI.DATA(15 downto 0);
   fifo_wr_en(5) <= QUAD3_MOSI.DVAL;
   
   fifo_din(4)   <= '0' & QUAD2_MOSI.DATA(69 downto 54) & QUAD2_MOSI.DATA(51 downto 36); 
   fifo_wr_en(4) <= QUAD2_MOSI.DVAL;
   
   fifo_din(3)   <= '0' & QUAD2_MOSI.DATA(33 downto 18) & QUAD2_MOSI.DATA(15 downto 0);
   fifo_wr_en(3) <= QUAD2_MOSI.DVAL;
   
   fifo_din(2)   <= '0' & QUAD1_MOSI.DATA(69 downto 54) & QUAD1_MOSI.DATA(51 downto 36); 
   fifo_wr_en(2) <= QUAD1_MOSI.DVAL;
   
   fifo_din(1)   <= '0' & QUAD1_MOSI.DATA(33 downto 18) & QUAD1_MOSI.DATA(15 downto 0); 
   fifo_wr_en(1) <= QUAD1_MOSI.DVAL;                                              
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- 8 fifos de 32 bits pour les donn�es 
   --------------------------------------------------   
   U2 : for ii in 1 to 8 generate
      dfifo_ii : fwft_sfifo_w33_d16 
      port map(
         clk      =>  CLK,
         rst      =>  ARESET,
         din      =>  fifo_din(ii),
         wr_en    =>  fifo_wr_en(ii), 
         rd_en    =>  fifo_rd_en(ii),
         dout     =>  fifo_dout(ii),
         full     =>  fifo_full(ii),
         overflow =>  open,
         empty    =>  open,
         valid    =>  fifo_dval(ii)      
         );
   end generate;  
   
   --------------------------------------------------
   -- multiplexage
   -------------------------------------------------- 
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            count <=  1;
            fifo_rd_en <= (others => '0');
            dout_dval <= '0';
            err_i <= '0';
            
         else          
            
            err_i <= dout_dval and not DOUT_MISO.TREADY;   -- j'ai horreur du busy. Erreur grave de vitesse 
            
            fifo_rd_en <= (others => '0');             -- par defaut on ne lit aucun fifo
            
            if fifo_dval(count) = '1' then
               fifo_rd_en(count) <= '1';
               count <= (count mod 8) + 1;
               dout_dval <= '1';
            else
               dout_dval <= '0';
            end if; 
            dout     <= fifo_dout(count)(31 downto 0);
            dout_eof <= fifo_dout(count)(32);
            
            
         end if;                             
      end if;
   end process; 
end rtl;
