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
      
      ARESET        : in std_logic;
      CLK           : in std_logic;
      
      FPA_INTF_CFG  : in fpa_intf_cfg_type;
      
      READOUT       : in std_logic;
      FPA_DIN       : in std_logic_vector(57 downto 0);
      FPA_DIN_DVAL  : in std_logic;
      
      ENABLE        : in std_logic;
      
      FPA_DOUT_FVAL : out std_logic;
      FPA_DOUT      : out std_logic_vector(95 downto 0);
      FPA_DOUT_DVAL : out std_logic;
      
      STAT           : out std_logic_vector(7 downto 0)
      );
end scd_proxy2_real_data;


architecture rtl of scd_proxy2_real_data is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   
   type din_pipe_type is array (0 to 1) of t_ll_ext_mosi56;
   
   constant C_AOI_LSYNC_POS   : natural := 56;
   constant C_AOI_FSYNC_POS   : natural := 57; 
   constant C_NAOI_START_POS  : natural := 58;
   
   signal din_pipe_i          : din_pipe_type;
   
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------
   FPA_DOUT_FVAL <= dout_fval_o;
   FPA_DOUT_DVAL <= dout_wr_en_o; 
   FPA_DOUT <= dout_o; --
   STAT(2) <= '0';
   STAT(1) <= '0';
   STAT(0) <= '1'; 
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------
   U1: sync_reset
   port map(
      ARESET => global_areset,
      CLK    => CLK,
      SRESET => sreset
      ); 
   global_areset <= ARESET or not ENABLE;   -- tout le module sera en reset tant qu'on est en mode diag    
   
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
         if sreset = '1' then      -- tant qu'on est en mode diag, la fsm est en reset.      
            
            first_data_en <= '1';
            
         else      
            
            
            
            
            
            -----------------------------------------------
            -- pipe (1) : generation de sof et sol  et eol                                         
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
            -- pipe (2) : generation de eol                                         
            -----------------------------------------------
            fval_pipe(2)  <= fval_pipe(1);
            lval_pipe(2)  <= lval_pipe(1);
            din_pipe_i(2) <= din_pipe_i(1); 
            din_pipe_i(2).eol <= '0';
            if lval_pipe(1) = '1' and lval_pipe(0) = '0' then 
               din_pipe_i(2).eol <= '1';
            end if;
            
            -----------------------------------------------
            -- pipe (3) : generation de eol                                         
            -----------------------------------------------
            fval_pipe(3)  <= fval_pipe(2);
            lval_pipe(3)  <= lval_pipe(2);
            
            din_pipe_i(2).eol <= '0';
            if lval_pipe(1) = '1' and lval_pipe(0) = '0' then 
               din_pipe_i(2).eol <= '1';
            end if;
            if din_pipe_i(2).dval = '1' or eof_i = '1' then -- un nouveau pix_dval_i ou un acq_eof_i pousse la donnée précédente dans le pipe vers la sortie
               -- pipe 1
               din_pipe_i(3) <= din_pipe_i(2);   -- L'index ne suit plusle pixel. -- selon le doc de PDA, l'index occupe le bit 2 de Tuser       
               -- pipe 2
               din_pipe_i(4) <= din_pipe_i(3);   
            end if;
            din_pipe_i(4).dval <= din_pipe_i(3).dval or eof_i;
            if eof_i = '1' then 
               din_pipe_i(4).eof  <= '1'; -- parfaitement synchro avec le pixel précédent eof_i
            end if;            
            
            
            ------------
            -- zone AOI                                                           
            -------------
            dout_dval_o <= din_pipe_i(4).dval;      -- 
            -- données écrites en aval 
            dout_o(55 downto 0) <= din_pipe_i(4).data;   
            
            -- aoi_sol
            dout_o(56)           <= din_pipe_i(4).sol ;  
            
            -- aoi_eol                      
            dout_o(57)           <= din_pipe_i(4).eol;        
            
            -- fval   
            dout_fval_o          <= din_pipe_i(4).fval;                                                     
            dout_o(58)           <= din_pipe_i(4).fval;         
            
            -- aoi_sof
            dout_o(59)           <= din_pipe_i(4).sof; 
            
            -- aoi_eof                       
            dout_o(60)           <= din_pipe_i(4).eof;    
            
            -- aoi_dval    (nouvel ajout)                              
            dout_o(61)           <= din_pipe_i(4).dval; 
            
            -- aoi_spares  (nouvel ajout)    
            dout_o(76 downto 62) <= (others => '0');                                         
            
            ------------------
            -- Zone NON AOI                                                       
            ------------------
            dout_o(77)           <= '0';   -- naoi_dval    
            dout_o(78)           <= '0';   -- naoi_start
            dout_o(79)           <= '0';   -- naoi_stop            
            dout_o(81 downto 80) <= '0';   -- naoi_ref_valid
            dout_o(94 downto 82) <= '0';   -- naoi_spares
            
            -- non utilisé                                                                    
            dout_o(95)           <= '0'; 
            
         end if;
      end if;
   end process;
   
end rtl;

