------------------------------------------------------------------
--!   @file : scd_proxy2_real_data
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

-- ENO 27 sept 2017 :  
--    revision en profondeur pour tenir compte de le necessité de sortir les données hors AOI.
--    le flushing des fifos est abandonné. le frame sync ne sert qu'à l'initialisation. Ainsi, le mode IWR sera facilité puisque frame_sync aurait été une entrave.  

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.proxy_define.all;
use work.fpa_common_pkg.all;

entity scd_proxy2_real_data is
   port(
      
      ARESET              : in std_logic;      
      CLK                 : in std_logic;
      
      QUAD_DATA           : in std_logic_vector(71 downto 0);
      QUAD_DVAL           : in std_logic;
      
      DOUT                : out std_logic_vector(95 downto 0);
      DOUT_FVAL           : out std_logic;     
      DOUT_DVAL           : out std_logic;
      
      FPA_INTF_CFG        : in fpa_intf_cfg_type;
      ENABLE              : in std_logic;
      
      FPA_INT             : in std_logic;      
      READOUT             : in std_logic;
      ACQ_MODE            : in std_logic;
      ACQ_MODE_FIRST_INT  : in std_logic;
      NACQ_MODE_FIRST_INT : in std_logic;
      
      STAT                : out std_logic_vector(7 downto 0)
      );
end scd_proxy2_real_data;


architecture rtl of scd_proxy2_real_data is  
   
   constant C_PIPE_NMAX : natural := 4; 
   
   component fwft_sfifo_w3_d256
      port (
         clk         : in std_logic;
         srst        : in std_logic;
         din         : in std_logic_vector(2 downto 0);
         wr_en       : in std_logic;
         rd_en       : in std_logic;
         dout        : out std_logic_vector(2 downto 0);
         full        : out std_logic;
         almost_full : out std_logic;
         overflow    : out std_logic;
         empty       : out std_logic;
         valid       : out std_logic
         );
   end component;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component; 
   
   component fwft_sfifo_w72_d16 is
      port (
         srst       : in std_logic;
         clk        : in std_logic;
         din        : in std_logic_vector (71 downto 0);
         wr_en      : in std_logic;
         rd_en      : in std_logic;
         dout       : out std_logic_vector (71 downto 0);
         full       : out std_logic;         
         overflow   : out std_logic;
         empty      : out std_logic;
         valid      : out std_logic
         );
   end component;
   
   type readout_fsm_type is (idle, wait_img_end_st);
   type fifo_fsm_type is (init_st1, init_st2, init_st3, init_done);
   
   type input_data_type is
   record
      fval     : std_logic;    
      pix_fval : std_logic;
      pix_lval : std_logic;
      pix_dval : std_logic;
      data     : std_logic_vector(55 downto 0);
   end record; 
   
   signal dout_fval_o         : std_logic := '0';
   signal dout_dval_o         : std_logic := '0';
   signal dout_o              : std_logic_vector(DOUT'LENGTH-1 downto 0);
   signal global_areset       : std_logic;
   signal global_sreset       : std_logic;
   
   signal acq_data_i           : std_logic;  -- dit si les données associées aux flags sont à envoyer dans la chaine ou pas.
   signal int_fifo_rd          : std_logic;
   signal int_fifo_din         : std_logic_vector(2 downto 0) := (others => '0'); -- non utilisé
   signal int_fifo_wr          : std_logic;
   signal int_fifo_dval        : std_logic;
   signal int_fifo_dout        : std_logic_vector(2 downto 0);
   
   signal fpa_int_i            : std_logic;
   signal fpa_int_last         : std_logic;
   signal fpa_int_re           : std_logic;
   signal itr_int_fifo_wr      : std_logic;
   signal iwr_int_fifo_wr1     : std_logic;
   signal iwr_int_fifo_wr2     : std_logic;
   signal readout_fsm          : readout_fsm_type;
   
   signal fifo_rd              : std_logic;
   signal past                 : input_data_type;
   signal past_fifo_din        : std_logic_vector(71 downto 0) := (others => '0');
   signal past_fifo_wr         : std_logic;
   signal past_fifo_dval_i     : std_logic;
   signal past_fifo_dout       : std_logic_vector(71 downto 0);
   
   signal present              : input_data_type;
   signal present_fifo_din     : std_logic_vector(71 downto 0) := (others => '0');                    
   signal present_fifo_wr      : std_logic;                    
   signal present_fifo_dval_i  : std_logic;                    
   signal present_fifo_dout    : std_logic_vector(71 downto 0);
   
   signal future               : input_data_type;
   signal future_fifo_din      : std_logic_vector(71 downto 0) := (others => '0');                    
   signal future_fifo_wr       : std_logic;                    
   signal future_fifo_dval_i   : std_logic;                    
   signal future_fifo_dout     : std_logic_vector(71 downto 0);
   
   signal pix_dval_i           : std_logic;
   signal fifo_fsm             : fifo_fsm_type;
   
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------
   DOUT_FVAL <= dout_fval_o;
   DOUT_DVAL <= dout_dval_o; 
   DOUT <= dout_o; --
   STAT(2) <= '0';
   STAT(1) <= '0';
   STAT(0) <= '1'; 
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------
   global_areset <= ARESET or not ENABLE;   -- tout le module sera en reset tant qu'on est en mode diag  
   U1: sync_reset
   port map(
      ARESET => global_areset,
      CLK    => CLK,
      SRESET => global_sreset
      ); 
   
   U2: double_sync
   port map(
      CLK => CLK,
      D   => FPA_INT,
      Q   => fpa_int_i,
      RESET => global_sreset
      );
   
   --------------------------------------------------
   -- fifo du passé
   --------------------------------------------------
   fifo1 : fwft_sfifo_w72_d16
   port map(
      srst        => global_sreset,
      clk         => CLK,
      din         => past_fifo_din,
      wr_en       => past_fifo_wr,
      rd_en       => fifo_rd,
      dout        => past_fifo_dout,
      full        => open,
      overflow    => open,
      empty       => open,
      valid       => past_fifo_dval_i
      );
   
   past.fval      <= past_fifo_dout(67);
   past.pix_fval  <= past_fifo_dout(66);   
   past.pix_lval  <= past_fifo_dout(65);
   past.pix_dval  <= past_fifo_dout(64);
   past.data      <= past_fifo_dout(61 downto 48) & past_fifo_dout(45 downto 32) & past_fifo_dout(29 downto 16) & past_fifo_dout(13 downto 0);
   
   --------------------------------------------------
   -- fifo du present
   --------------------------------------------------
   fifo2 : fwft_sfifo_w72_d16
   port map(
      srst        => global_sreset,
      clk         => CLK,
      din         => present_fifo_din,
      wr_en       => present_fifo_wr,
      rd_en       => fifo_rd,
      dout        => present_fifo_dout,
      full        => open,
      overflow    => open,
      empty       => open,
      valid       => present_fifo_dval_i   
      );
   
   present.fval     <= present_fifo_dout(67);
   present.pix_fval <= present_fifo_dout(66);   
   present.pix_lval <= present_fifo_dout(65);
   present.pix_dval <= present_fifo_dout(64);
   present.data     <= present_fifo_dout(61 downto 48) & present_fifo_dout(45 downto 32) & present_fifo_dout(29 downto 16) & present_fifo_dout(13 downto 0);
   
   --------------------------------------------------
   -- fifo du futur
   --------------------------------------------------
   fifo3 : fwft_sfifo_w72_d16
   port map(
      srst        => global_sreset,
      clk         => CLK,
      din         => future_fifo_din,
      wr_en       => future_fifo_wr,
      rd_en       => fifo_rd,
      dout        => future_fifo_dout,
      full        => open,
      overflow    => open,
      empty       => open,
      valid       => future_fifo_dval_i
      );
   
   future.fval      <= future_fifo_dout(67);
   future.pix_fval  <= future_fifo_dout(66);   
   future.pix_lval  <= future_fifo_dout(65);
   future.pix_dval  <= future_fifo_dout(64);
   future.data      <= future_fifo_dout(61 downto 48) & past_fifo_dout(45 downto 32) & past_fifo_dout(29 downto 16) & past_fifo_dout(13 downto 0);
   
   --------------------------------------------------
   -- synchronisateur des données sortantes
   --------------------------------------------------    
   pix_dval_i <= present.pix_dval and present_fifo_dval_i;                    -- si les données du fifo du present sont OK, c'est que ceux du past et du futur le sont aussi
   fifo_rd <= future_fifo_dval_i;                                             -- past_fifo_dval_i and present_fifo_dval_i and future_fifo_dval_i;
   
   
   U4: process(CLK)
      
   begin
      if rising_edge(CLK) then         
         if global_sreset = '1' then      
            dout_fval_o <= '0';
            dout_dval_o <= '0';
            fifo_fsm <= init_st1;
            past_fifo_wr <= '0';
            present_fifo_wr <= '0';
            future_fifo_wr <= '0';
            
         else        
            
            -- données entrantes
            past_fifo_din <= QUAD_DATA;
            past_fifo_wr  <= QUAD_DVAL;
            
            present_fifo_din <= QUAD_DATA;
            present_fifo_wr  <= QUAD_DVAL;
            
            future_fifo_din <= QUAD_DATA;
            future_fifo_wr  <= QUAD_DVAL;
            
            case fifo_fsm is
               
               when init_st1 =>       -- ici, on fait en sorte que le futur soit en avance de 1CLK sur le présent
                  past_fifo_din(71 downto 64) <= (others => '0');
                  present_fifo_din(71 downto 64) <= (others => '0');
                  past_fifo_wr <= '1';
                  present_fifo_wr <= '1';
                  fifo_fsm <= init_st2;
               
               when init_st2 =>
                  past_fifo_wr <= '1';
                  present_fifo_wr <= '0';
                  fifo_fsm <= init_st3;
               
               when init_st3 =>
                  past_fifo_wr <= '0';
                  fifo_fsm <= init_done;
                  
                when init_done =>  
               
               when others => 
               
            end case;
            
            --------------------------------------------------------
            -- les sorties
            --------------------------------------------------------
            dout_dval_o          <= fifo_rd;                                        -- wr_en des fifos en aval. On ecrit aussi la tombée de fval pour que le système en avl le remarque  
            dout_fval_o          <= present.fval;                                   -- fval          
            dout_o(55 downto 0)  <= present.data;                                   -- données écrites en aval           
            dout_o(56)           <= pix_dval_i and not past.pix_lval and present.pix_lval;                   -- aoi_sol                              
            dout_o(57)           <= pix_dval_i and not future.pix_lval and present.pix_lval;                 -- aoi_eol       
            dout_o(58)           <= present.fval;                                   
            dout_o(59)           <= pix_dval_i and not past.pix_fval and present.pix_fval;                   -- aoi_sof
            dout_o(60)           <= pix_dval_i and not future.pix_fval and present.pix_fval;                 -- aoi_eof 
            dout_o(61)           <= present.pix_dval and fifo_rd;                   -- aoi_dval    (nouvel ajout) 
            dout_o(62)           <= acq_data_i;                                     -- requis pour savoir si image à rejeter ou non
            dout_o(76 downto 63) <= (others => '0');                                -- aoi_spares  (nouvel ajout)                                                                                
            
            dout_o(77)           <= '0';                                            -- naoi_dval    
            dout_o(78)           <= '0';                                            -- naoi_start
            dout_o(79)           <= '0';                                            -- naoi_stop            
            dout_o(81 downto 80) <= (others => '0');                                -- naoi_ref_valid
            dout_o(94 downto 82) <= (others => '0');                                -- naoi_spares
            dout_o(95)           <= '0';                                            -- non utilisé
            
         end if;
      end if;
   end process; 
   
   --------------------------------------------------
   -- fifo fwft pour edge de l'intégration
   --------------------------------------------------
   Ue : fwft_sfifo_w3_d256
   port map (
      clk         => CLK,
      srst        => global_sreset,
      din         => int_fifo_din,    
      wr_en       => int_fifo_wr,
      rd_en       => int_fifo_rd,
      dout        => int_fifo_dout,   
      full        => open,
      almost_full => open,
      overflow    => open,
      empty       => open,
      valid       => int_fifo_dval
      );
   
   --------------------------------------------------
   -- generation de acq_data_i
   --------------------------------------------------
   U3: process(CLK)
      variable pclk_cnt_incr : std_logic_vector(1 downto 0);  
   begin
      if rising_edge(CLK) then 
         if global_sreset = '1' then            
            readout_fsm  <= idle;
            int_fifo_wr  <= '0';
            int_fifo_rd  <= '0';
            acq_data_i   <= '0';
            
            fpa_int_last <= '0'; 
            fpa_int_re   <= '0'; 
            itr_int_fifo_wr  <= '0';
            iwr_int_fifo_wr1 <= '0';
            iwr_int_fifo_wr2 <= '0';
            
         else  
            
            fpa_int_last <= fpa_int_i;
            fpa_int_re   <= (not fpa_int_last and fpa_int_i);
            
            itr_int_fifo_wr   <= fpa_int_re and ACQ_MODE and FPA_INTF_CFG.ITR;                                 -- en mode itr, on ecrit les RE des fpa_acq_int dans le fifo
            iwr_int_fifo_wr1  <= fpa_int_re and ACQ_MODE and not ACQ_MODE_FIRST_INT and not FPA_INTF_CFG.ITR;  -- en mode iwr, on ecrit les RE des fpa_acq_int dans le fifo, sauf le premier
            iwr_int_fifo_wr2  <= fpa_int_re and NACQ_MODE_FIRST_INT and not FPA_INTF_CFG.ITR;                  -- en mode iwr, on ecrit le RE de l'integration resultant du premier xtra_trig/prog_trig.
            
            int_fifo_wr  <= itr_int_fifo_wr or iwr_int_fifo_wr1 or iwr_int_fifo_wr2;          
            
            -- contrôleur
            case readout_fsm is           
               
               when idle => 
                  acq_data_i <= int_fifo_dval;  
                  if dout_fval_o = '1' then          -- debut d'une image
                     int_fifo_rd <= int_fifo_dval;                     
                     readout_fsm <= wait_img_end_st;
                  end if;                                  
               
               when wait_img_end_st =>                  
                  if dout_fval_o = '0' then 
                     readout_fsm <= idle;
                  end if;         
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;  
   
   
end rtl;

