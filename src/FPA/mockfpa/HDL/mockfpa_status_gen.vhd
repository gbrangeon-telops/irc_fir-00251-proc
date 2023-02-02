------------------------------------------------------------------
--!   @file fpa_status_gen
--!   @brief collecteur des statuts des sous-modules
--!   @details ce module collecte les statuts de tous les sous modules et en génère des statuts standards
--! 
--!   $Rev: 25818 $
--!   $Author: pcouture $
--!   $Date: 2020-10-19 15:09:27 -0400 (Mon, 19 Oct 2020) $
--!   $Id: mockfpa_status_gen.vhd 25818 2020-10-19 19:09:27Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/Merged/2020-10-19%20-%20Gestion%20Fenetre%201920x1536/src/FPA/mockfpa/HDL/mockfpa_status_gen.vhd $

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_misc.all;
use work.fpa_common_pkg.all;
use work.fpa_define.all;
use work.proxy_define.all;
use work.fpa_serdes_define.all;
use work.tel2000.all;   


entity mockfpa_status_gen is
   port(
      
      ARESET           : in std_logic;
      MB_CLK           : in std_logic;
      
      DATA_PATH_STAT   : in std_logic_vector(15 downto 0);
      MISC_STAT        : in misc_stat_type;
            
      STATUS_MOSI      : in t_axi4_lite_mosi;
      STATUS_MISO      : out t_axi4_lite_miso
      );
end mockfpa_status_gen;


architecture rtl of mockfpa_status_gen is
   signal sreset_mb_clk                : std_logic;
   signal error_latch                  : std_logic_vector(31 downto 0);  
   signal dpath_dout_fifo_err          : std_logic;
   signal stat_read_add                : std_logic_vector(15 downto 0);
   signal stat_read_reg                : std_logic_vector(31 downto 0);
   signal stat_read_dval               : std_logic;
   signal stat_read_err                : std_logic;


   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
      
begin                 
   
   
   
   -- MISO
   STATUS_MISO.ARREADY <= '1';
   STATUS_MISO.RRESP   <= AXI_OKAY;         
   STATUS_MISO.RVALID  <= stat_read_dval;
   STATUS_MISO.RDATA   <= stat_read_reg;
   
   --------------------------------------------
   -- SYNC_RESET
   --------------------------------------------
   --U1A : sync_reset
   --port map(ARESET => ARESET, SRESET => sreset_fpa_intf_clk, CLK => FPA_INTF_CLK); 	
   U1B : sync_reset
   port map(ARESET => ARESET, SRESET => sreset_mb_clk, CLK => MB_CLK); 	
   -----------------------------------------------
   -- Inputs maps:  DATA_PATH_STAT
   -----------------------------------------------
   dpath_dout_fifo_err        <= DATA_PATH_STAT(7);   -- dfpa and afpa
   
   error_latch(5)  <= dpath_dout_fifo_err;
   
   -----------------------------------------------
   -- Adresses des statuts
   -----------------------------------------------
   -- MOSI
   stat_read_add <= STATUS_MOSI.ARADDR(15 downto 0);
   
   U4 : process(MB_CLK) 
   begin
      if rising_edge(MB_CLK) then
         if sreset_mb_clk = '1' then 
            stat_read_err <= '0';
            stat_read_dval <= '0';
         else
            
            stat_read_dval <= STATUS_MOSI.ARVALID;
            
            -- erreur grave
            stat_read_err <= stat_read_dval and not STATUS_MOSI.RREADY; -- le microblaze n'a pas écouté la réponse.
            
            case  stat_read_add is	
		
               when  x"003C" =>   -- erreurs latchées
                  stat_read_reg <= error_latch;
                  
                  
               -- watchdog data
               when  x"0094" =>   -- 
			      stat_read_reg <= resize(MISC_STAT.acq_trig_cnt, 32);
               
               when  x"0098" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.acq_int_cnt, 32);                        
               
               when  x"009C" =>   --                                                           
                  stat_read_reg <= resize(MISC_STAT.fpa_readout_cnt, 32);                     
               
               when  x"00A0" =>   --                                                           
                  stat_read_reg <= resize(MISC_STAT.acq_readout_cnt, 32);
               
               when  x"00A4" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.out_pix_cnt_min, 32);
               
               when  x"00A8" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.out_pix_cnt_max, 32);
               
               when  x"00AC" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.trig_to_int_delay_min, 32);
               
               when  x"00B0" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.trig_to_int_delay_max, 32);
               
               when  x"00B4" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.int_to_int_delay_min, 32);
               
               when  x"00B8" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.int_to_int_delay_max, 32);
               
               when  x"00BC" =>   -- 
                  stat_read_reg <= resize(MISC_STAT.fast_hder_cnt, 32);
                  
               when others  => stat_read_reg <= (others => '0');
               
            end case;
            
         end if;
      end if;
   end process;

end rtl;














