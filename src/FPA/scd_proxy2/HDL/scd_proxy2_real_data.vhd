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
      
      ARESET             : in std_logic;
      CLK                : in std_logic;
                         
      FPA_INTF_CFG       : in fpa_intf_cfg_type;
                         
      FPA_INT            : in std_logic;
                         
      READOUT            : in std_logic;
      FPA_DIN            : in std_logic_vector(57 downto 0);
      FPA_DIN_DVAL       : in std_logic;
      
      ACQ_MODE           : in std_logic;
      ACQ_MODE_FIRST_INT : in std_logic;
      NACQ_MODE_FIRST_INT: in std_logic;
      
      ENABLE             : in std_logic;
                         
      FPA_DOUT_FVAL      : out std_logic;
      FPA_DOUT           : out std_logic_vector(95 downto 0);
      FPA_DOUT_DVAL      : out std_logic;
                         
      STAT               : out std_logic_vector(7 downto 0)
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
   
   type readout_fsm_type is (idle, wait_img_end_st);
   
   type din_pipe_type is array (0 to C_PIPE_NMAX) of t_ll_ext_mosi56;
   
   signal din_pipe_i          : din_pipe_type;
   signal first_data_en       : std_logic;
   signal fval_pipe           : std_logic_vector(C_PIPE_NMAX downto 0);
   signal lval_pipe           : std_logic_vector(C_PIPE_NMAX downto 0);
   signal dout_fval_o         : std_logic;
   signal dout_dval_o         : std_logic;
   signal dout_o              : std_logic_vector(FPA_DOUT'LENGTH-1 downto 0);
   signal global_areset       : std_logic;
   signal global_sreset       : std_logic;
   signal fval_fe             : std_logic;
   signal fval_last           : std_logic;
   signal signal_rst          : std_logic;
   
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
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------
   FPA_DOUT_FVAL <= dout_fval_o;
   FPA_DOUT_DVAL <= dout_dval_o; 
   FPA_DOUT <= dout_o; --
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
   
   din_pipe_i(0).sof  <= '0';
   din_pipe_i(0).eof  <= '0';
   din_pipe_i(0).sol  <= '0';
   din_pipe_i(0).eol  <= '0';
   din_pipe_i(0).dval <= FPA_DIN_DVAL;
   din_pipe_i(0).data <= FPA_DIN(55 downto 0);
   
   lval_pipe(0)       <= FPA_DIN(56);
   fval_pipe(0)       <= FPA_DIN(57); 
   
   --------------------------------------------------
   -- synchronisateur des données sortantes
   --------------------------------------------------
   U4: process(CLK)
      
   begin
      if rising_edge(CLK) then         
         if global_sreset = '1' then         
            first_data_en <= '1'; 
            signal_rst <= '1';
            fval_last <= '0';
            dout_fval_o <= '0';
            dout_dval_o <= '0';
            -- pragma translate_off
            fval_pipe <= (others =>'0');
            dout_fval_o <= '0';
            fval_fe <= '0';
            -- pragma translate_on
         else        
            
            -----------------------------------------------
            -- pipe(1) : generation de sof et sol  et eol                                         
            -----------------------------------------------
            fval_pipe(1)  <= fval_pipe(0);
            lval_pipe(1)  <= lval_pipe(0);
            din_pipe_i(1) <= din_pipe_i(0);
            din_pipe_i(1).sol <= '0';
            din_pipe_i(1).sof <= '0';
            if lval_pipe(1) = '0' and lval_pipe(0) = '1' then 
               din_pipe_i(1).sol <= '1';
               din_pipe_i(1).sof <= first_data_en;
               first_data_en <= '0';
            end if;            
            
            -----------------------------------------------
            -- pipe(2) : generation de eol                                         
            -----------------------------------------------
            fval_pipe(2)  <= fval_pipe(1);
            lval_pipe(2)  <= lval_pipe(1);
            din_pipe_i(2) <= din_pipe_i(1); 
            din_pipe_i(2).eol <= '0';
            if lval_pipe(1) = '1' and lval_pipe(0) = '0' then 
               din_pipe_i(2).eol <= '1';
            end if;
            
            -----------------------------------------------
            -- pipe(3) et pipe(4) : generation de eof                                         
            -----------------------------------------------
            fval_pipe(3) <= fval_pipe(2);
            lval_pipe(3) <= lval_pipe(2);
            fval_fe <= not fval_pipe(2) and fval_pipe(3);     -- detection de la tombée de fval
            if din_pipe_i(2).dval = '1' or fval_fe = '1' then -- un nouveau pix_dval_i ou un fval_fe poussent la donnée précédente dans le pipe vers la sortie
               -- pipe 1
               din_pipe_i(3) <= din_pipe_i(2);                --     
               -- pipe 2
               din_pipe_i(4) <= din_pipe_i(3);   
            end if;
            if fval_fe = '1' then 
               din_pipe_i(4).eof  <= '1'; -- parfaitement synchro avec le pixel précédent fval_fe
            end if; 
            din_pipe_i(4).dval <= din_pipe_i(3).dval or fval_fe;           
            fval_pipe(4)  <= fval_pipe(3);
            lval_pipe(4)  <= lval_pipe(3);    
            
            --------------------------------------------------------
            -- les sorties
            --------------------------------------------------------
            dout_dval_o          <= din_pipe_i(4).dval or (fval_last and not dout_fval_o);           -- wr_en des fifos en ava. On ecrit aussi la tombée de fval pour que le système en avl le remarque  
            dout_fval_o          <= fval_pipe(4);                                   -- fval          
            dout_o(55 downto 0)  <= din_pipe_i(4).data;                             -- données écrites en aval           
            dout_o(56)           <= din_pipe_i(4).sol ;                             -- aoi_sol                              
            dout_o(57)           <= din_pipe_i(4).eol;                              -- aoi_eol       
            dout_o(58)           <= fval_pipe(4);                                   
            dout_o(59)           <= din_pipe_i(4).sof;                              -- aoi_sof
            dout_o(60)           <= din_pipe_i(4).eof;                              -- aoi_eof 
            dout_o(61)           <= din_pipe_i(4).dval and lval_pipe(4);            -- aoi_dval    (nouvel ajout) 
            dout_o(62)           <= acq_data_i;                                     -- requis pour savoir si image à rejeter ou non
            dout_o(76 downto 63) <= (others => '0');                                -- aoi_spares  (nouvel ajout)                                                                                
            
            dout_o(77)           <= '0';                                            -- naoi_dval    
            dout_o(78)           <= '0';                                            -- naoi_start
            dout_o(79)           <= '0';                                            -- naoi_stop            
            dout_o(81 downto 80) <= (others => '0');                                -- naoi_ref_valid
            dout_o(94 downto 82) <= (others => '0');                                -- naoi_spares
            dout_o(95)           <= '0';                                            -- non utilisé
            
            -----------------------------------------------
            -- RAZ
            -----------------------------------------------
            fval_last  <= dout_fval_o;
            signal_rst <= fval_last and not dout_fval_o;  
            
            if signal_rst = '1' then 
               first_data_en <= '1';
            end if;
            
            
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

