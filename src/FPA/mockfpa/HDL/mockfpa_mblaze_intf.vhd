------------------------------------------------------------------
--!   @file : mockfpa_mblaze_intf
--!   @brief
--!   @details
--!
--!   $Rev: 25818 $
--!   $Author: pcouture $
--!   $Date: 2020-10-19 15:09:27 -0400 (Mon, 19 Oct 2020) $
--!   $Id: mockfpa_mblaze_intf.vhd 25818 2020-10-19 19:09:27Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/Merged/2020-10-19%20-%20Gestion%20Fenetre%201920x1536/src/FPA/mockfpa/HDL/mockfpa_mblaze_intf.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.FPA_define.all;
use work.fpa_common_pkg.all;
use work.fleg_brd_define.all;
use work.BufferingDefine.all;


entity mockfpa_mblaze_intf is
   port(
      
      ARESET                : in std_logic;
      MB_CLK                : in std_logic;
      
      FPA_EXP_INFO          : in exp_info_type;
      
      MB_MOSI               : in t_axi4_lite_mosi;
      MB_MISO               : out t_axi4_lite_miso;
      
      STATUS_MOSI           : out t_axi4_lite_mosi;
      STATUS_MISO           : in t_axi4_lite_miso;
      CTRLED_RESET          : out std_logic; 
	  
	  FLOW_CTRLER_CFG       : out flow_ctrler_config_type; 
      
      USER_CFG              : out fpa_intf_cfg_type
      
      );
end mockfpa_mblaze_intf; 

architecture rtl of mockfpa_mblaze_intf is  
   
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26  : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 26; --pour un total de 26 bits pour le temps d'integration de 0207
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1   : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1;   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   type exp_indx_pipe_type is array (0 to 4) of std_logic_vector(7 downto 0);
   type exp_time_pipe_type is array (0 to 4) of unsigned(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto 0);
   
   signal exp_time_pipe                : exp_time_pipe_type; 
   signal axi_awaddr	                  : std_logic_vector(31 downto 0);
   signal axi_awready	               : std_logic;
   signal axi_wready	                  : std_logic;
   signal axi_bresp	                  : std_logic_vector(1 downto 0);
   signal axi_bvalid	                  : std_logic;
   signal axi_araddr	                  : std_logic_vector(31 downto 0);
   signal axi_arready	               : std_logic;
   signal axi_rdata	                  : std_logic_vector(31 downto 0);
   signal axi_rresp	                  : std_logic_vector(1 downto 0);
   signal axi_rvalid	                  : std_logic;
   signal axi_wstrb                    : std_logic_vector(3 downto 0);  

   signal slv_reg_rden                 : std_logic;
   signal slv_reg_wren                 : std_logic;
   signal user_init_cfg_i               : fpa_intf_cfg_type;
   signal data_i                       : std_logic_vector(31 downto 0);

   signal update_cfg                   : std_logic;
   signal user_cfg_in_progress         : std_logic := '0';
   signal user_cfg_i                   : fpa_intf_cfg_type;
   signal int_dval_i                   : std_logic := '0';
   signal int_time_i                   : unsigned(31 downto 0);
   signal int_indx_i                   : std_logic_vector(7 downto 0);
   signal exp_indx_pipe                : exp_indx_pipe_type;
   signal exp_dval_pipe                : std_logic_vector(7 downto 0) := (others => '0');
   signal ctrled_reset_i               : std_logic;
   signal sreset                       : std_logic;
   signal user_cfg_rdy_pipe            : std_logic_vector(7 downto 0) := (others => '0');
   signal user_cfg_rdy                 : std_logic := '0';

   signal exp_time_reg                 : unsigned(30 downto 0);
   signal valid_cfg_received           : std_logic := '0';
   signal mb_ctrled_reset_i            : std_logic := '0';

   
begin   
   
   CTRLED_RESET <= ctrled_reset_i;

   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => MB_CLK, SRESET => sreset); 
   
   ------------------------------------------------  
   -- sortie de la config                              
   -------------------------------------------------  
   U2: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then

         update_cfg <= user_cfg_rdy;         
         
         -- configuration
         if update_cfg = '1' then 
            USER_CFG <= user_cfg_i;
            valid_cfg_received <= '1';
         end if;
         
      end if;  
   end process;   
   
   -------------------------------------------------  
   -- liens axil                           
   -------------------------------------------------  
   -- I/O Connections assignments
   MB_MISO.AWREADY     <= axi_awready;
   MB_MISO.WREADY      <= axi_wready;
   MB_MISO.BRESP	     <= axi_bresp;
   MB_MISO.BVALID      <= axi_bvalid;
   MB_MISO.ARREADY     <= axi_arready;
   MB_MISO.RDATA	     <= axi_rdata;
   MB_MISO.RRESP	     <= axi_rresp;
   MB_MISO.RVALID      <= axi_rvalid; 
   
   -- STATUS_MOSI toujours envoyé au fpa_status_gen pour eviter des delais
   STATUS_MOSI.AWVALID <= '0';   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWADDR  <= (others => '0');   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWPROT  <= (others => '0'); -- registres de statut en mode lecture seulement
   STATUS_MOSI.WVALID  <= '0'; -- registres de statut en mode lecture seulement    
   STATUS_MOSI.WDATA   <= (others => '0'); -- registres de statut en mode lecture seulement 
   STATUS_MOSI.WSTRB   <= (others => '0'); -- registres de statut en mode lecture seulement 
   STATUS_MOSI.BREADY  <= '0'; -- registres de statut en mode lecture seulement
   STATUS_MOSI.ARVALID <= MB_MOSI.ARVALID;
   STATUS_MOSI.ARADDR  <= resize(MB_MOSI.ARADDR(9 downto 0), 32); -- (9 downto 0) permet d'adresser tous les registres de statuts 
   STATUS_MOSI.ARPROT  <= MB_MOSI.ARPROT; 
   STATUS_MOSI.RREADY  <= MB_MOSI.RREADY;    
   
   FLOW_CTRLER_CFG.stalled_cnt    <= user_cfg_i.flow_ctler_stalled_cnt;
   FLOW_CTRLER_CFG.valid_cnt	  <= user_cfg_i.flow_ctler_valid_cnt;
   FLOW_CTRLER_CFG.width		  <= resize(user_cfg_i.flow_ctler_width,FLOW_CTRLER_CFG.width'length);
   FLOW_CTRLER_CFG.lval_pause_min <= user_cfg_i.flow_ctler_lval_pause_cnt;
   FLOW_CTRLER_CFG.fval_pause_min <= user_cfg_i.flow_ctler_fval_pause_cnt;
   FLOW_CTRLER_CFG.memory_buffer_download_output <='0';
   FLOW_CTRLER_CFG.dval 		  <= user_cfg_i.flow_ctler_dval;
   
   -------------------------------------------------  
   -- reception Config                                
   -------------------------------------------------   
   U3: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            ctrled_reset_i <= '1';
            user_cfg_in_progress <= '1';                         
            mb_ctrled_reset_i <= '0';
            
         else                   
            
            ctrled_reset_i <= mb_ctrled_reset_i or not valid_cfg_received;            
            
            -- temps d'exposition  en mclk
            if int_dval_i = '1' then
               user_cfg_i.int_time <= int_time_i;
               user_cfg_i.int_indx <= int_indx_i;
            end if; 
            
            ------------------------------------------------------------------------------------------------------
            -- reste de la config     xsize                                                                            
            -----------------------------------------------------------------------------------------------------
            if slv_reg_wren = '1' then  
               case axi_awaddr(11 downto 0) is             
                  
                  -- comn  
				  
				  when X"000" =>    user_cfg_i.flow_ctler_dval                 <= data_i(0); user_cfg_in_progress <= '1'; 
				  when X"004" =>    user_cfg_i.flow_ctler_stalled_cnt          <= unsigned(data_i(user_cfg_i.flow_ctler_stalled_cnt'length-1 downto 0)); 
				  when X"008" =>    user_cfg_i.flow_ctler_valid_cnt            <= unsigned(data_i(user_cfg_i.flow_ctler_valid_cnt'length-1 downto 0));
				  when X"01C" =>    user_cfg_i.flow_ctler_lval_pause_cnt       <= unsigned(data_i(user_cfg_i.flow_ctler_lval_pause_cnt'length-1 downto 0)); 
				  when X"020" =>    user_cfg_i.flow_ctler_fval_pause_cnt       <= unsigned(data_i(user_cfg_i.flow_ctler_fval_pause_cnt'length-1 downto 0));
				  when X"024" =>    user_cfg_i.flow_ctler_width                <= unsigned(data_i(user_cfg_i.flow_ctler_width'length-1 downto 0));
                  when X"028" =>    user_cfg_i.fpa_height                      <= unsigned(data_i(user_cfg_i.fpa_height'length-1 downto 0));                                 
                  when X"02C" =>    user_cfg_i.fpa_width                       <= unsigned(data_i(user_cfg_i.fpa_width'length-1 downto 0));   user_cfg_in_progress <= '0';                              
	
                  when X"AF0" =>   mb_ctrled_reset_i                           <= data_i(0); 

                  when others =>
                  
               end case;     
               
            end if;

			
         end if; 
      end if; 
   end process;
   
   ------------------------------------------------  
   -- calcul du temps d'integratuion en coups de MCLK                               
   -------------------------------------------------
   U4: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         -- pipe pour le calcul du temps d'integration en mclk
         exp_time_pipe(0) <= resize(FPA_EXP_INFO.EXP_TIME, exp_time_pipe(0)'length) ;
         exp_time_pipe(1) <= exp_time_pipe(0);      
         exp_time_pipe(2) <= exp_time_pipe(1);
         exp_time_pipe(3) <= exp_time_pipe(2);
         int_time_i <= exp_time_pipe(3)(int_time_i'length-1 downto 0);
         
         -- pipe de synchro pour l'index           
         exp_indx_pipe(0) <= FPA_EXP_INFO.EXP_INDX;
         exp_indx_pipe(1) <= exp_indx_pipe(0); 
         exp_indx_pipe(2) <= exp_indx_pipe(1); 
         exp_indx_pipe(3) <= exp_indx_pipe(2); 
         exp_indx_pipe(4) <= exp_indx_pipe(3);
         int_indx_i       <= exp_indx_pipe(4);
         
         -- pipe pour rendre valide la donnée qques CLKs apres sa sortie
         exp_dval_pipe(0) <= FPA_EXP_INFO.EXP_DVAL;
         exp_dval_pipe(1) <= exp_dval_pipe(0); 
         exp_dval_pipe(2) <= exp_dval_pipe(1); 
         exp_dval_pipe(3) <= exp_dval_pipe(2);
         exp_dval_pipe(4) <= exp_dval_pipe(3);
         exp_dval_pipe(5) <= exp_dval_pipe(4);
         exp_dval_pipe(6) <= exp_dval_pipe(5);
         int_dval_i       <= exp_dval_pipe(6);                 
         
      end if;
   end process; 
   
   ------------------------------------------------  
   -- calcul des parametres de frame rate
   -------------------------------------------------
   U4B: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         if FPA_EXP_INFO.EXP_DVAL = '1' then
            exp_time_reg <= FPA_EXP_INFO.EXP_TIME(exp_time_reg'length-1 downto 0);
         end if;
         
         -- user_cfg_rdy
         user_cfg_rdy_pipe(0) <= not user_cfg_in_progress;
         user_cfg_rdy_pipe(7 downto 1) <= user_cfg_rdy_pipe(6 downto 0);
         user_cfg_rdy <= not user_cfg_in_progress and user_cfg_rdy_pipe(7); 
         
      end if;
   end process;
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U5: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if axi_arready = '0' and MB_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= MB_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;            
            if axi_arready = '1' and MB_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and MB_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   slv_reg_rden <= axi_arready and MB_MOSI.ARVALID and (not axi_rvalid);
   
   ---------------------------------------------------------------------------- 
   -- CFG MB AXI RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U6: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then         
         
         --if MB_MOSI.ARADDR(10) = '1' then    -- adresse de base pour la lecture des statuts
         axi_rdata <= STATUS_MISO.RDATA; -- la donnée de statut est valide 1CLK après MB_MOSI.ARVALID            
         --else 
         --	axi_rdata <= (others =>'1'); 
         --end if;
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U7: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else            
            
            if (axi_awready = '0' and MB_MOSI.AWVALID = '1' and MB_MOSI.WVALID = '1') then -- 
               axi_awready <= '1';
               axi_awaddr <= MB_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;            
            if (axi_wready = '0' and MB_MOSI.WVALID = '1' and MB_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';
            end if;           			
            
         end if;
      end if;
   end process;
   slv_reg_wren <= axi_wready and MB_MOSI.WVALID and axi_awready and MB_MOSI.AWVALID ;
   data_i <= MB_MOSI.WDATA;
   axi_wstrb <= MB_MOSI.WSTRB;  -- requis car le MB envoie des chmps de header avec des strobes differents de "1111"; 
   
   -----------------------------------------------------
   -- CFG MB AXI WR  : WR feedback envoyé au MB
   -----------------------------------------------------
   U8: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; -- need to work more on the responses
         else
            if slv_reg_wren = '1' and axi_bvalid = '0' then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif MB_MOSI.BREADY = '1' and axi_bvalid = '1' then   -- check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                  -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process;
   
end rtl;