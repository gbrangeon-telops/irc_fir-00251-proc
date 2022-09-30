------------------------------------------------------------------
--!   @file : irig_mb_intf
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
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.irig_define_v2.all;

entity irig_mb_intf is
   port(
      ARESET            : in std_logic;
      
      MB_CLK            : in std_logic;     
      
      IRIG_PPS_IN       : in std_logic;
      PPS_ACQ_WINDOW    : out std_logic;      
      IRIG_PPS_OUT      : out std_logic;
      IRIG_DATA         : in irig_data_type;
      
      IRIG_VALID_SOURCE : in std_logic;
      
      MB_MOSI           : in t_axi4_lite_mosi;
      MB_MISO           : out t_axi4_lite_miso;
      
	   DELAY             : out std_logic_vector(31 downto 0)
      );
end irig_mb_intf;


architecture rtl of irig_mb_intf is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
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
   
   component gh_edge_det
      port(
         clk   : in STD_LOGIC;
         rst   : in STD_LOGIC;
         D     : in STD_LOGIC;
         re    : out STD_LOGIC;
         fe    : out STD_LOGIC;
         sre   : out STD_LOGIC;
         sfe   : out STD_LOGIC);
   end component;
   
   signal sreset	                  : std_logic;
   signal axi_awaddr	               : std_logic_vector(31 downto 0);
   signal axi_awready	            : std_logic;
   signal axi_wready	               : std_logic;
   signal axi_bresp	               : std_logic_vector(1 downto 0);
   signal axi_bvalid	               : std_logic;
   signal axi_araddr	               : std_logic_vector(31 downto 0);
   signal axi_arready	            : std_logic;
   signal axi_rdata	               : std_logic_vector(31 downto 0);
   signal axi_rresp	               : std_logic_vector(1 downto 0);
   signal axi_rvalid	               : std_logic;
   signal data_i, data_o            : std_logic_vector(31 downto 0);
   signal slv_reg_rden	            : std_logic;
   signal slv_reg_wren	            : std_logic;
   signal irig_en_i                 : std_logic;
   signal irig_en_last              : std_logic;
   signal irig_data_latch           : irig_data_type;
   signal pps_acq_window_pipe       : std_logic_vector(7 downto 0);
   signal mb_speed_err_i            : std_logic;  
   signal irig_reg_read_by_mb       : std_logic;
   signal mb_read_irig_status       : std_logic;
   signal mb_on_time                : std_logic;
   signal irig_data_rdy             : std_logic; 
   signal irig_data_rdy_last        : std_logic;
   signal irig_data_available       : std_logic;
   signal irig_pps_sync             : std_logic;
   signal irig_valid_pps            : std_logic;
   signal irig_valid_source_sync    : std_logic;
   signal delay_i                   : std_logic_vector(31 downto 0) := x"000002EE";
   signal time_dval_sre             : std_logic; 
   signal time_dval_sync            : std_logic;
   signal status_dval_sync          : std_logic;
   
   attribute keep : string; 
   attribute keep of irig_data_rdy          : signal is "true";
   attribute keep of irig_data_available          : signal is "true";
   attribute keep of irig_reg_read_by_mb          : signal is "true";
   attribute keep of irig_pps_sync          : signal is "true";
   attribute keep of irig_valid_pps          : signal is "true";
   
begin
   
   DELAY <= delay_i;
   
   IRIG_PPS_OUT <= irig_valid_pps;  --output only valid pps
   
   -- I/O Connections assignments
   MB_MISO.AWREADY  <= axi_awready;
   MB_MISO.WREADY   <= axi_wready;
   MB_MISO.BRESP	  <= axi_bresp;
   MB_MISO.BVALID   <= axi_bvalid;
   MB_MISO.ARREADY  <= axi_arready;
   MB_MISO.RDATA	  <= axi_rdata;
   MB_MISO.RRESP	  <= axi_rresp;
   MB_MISO.RVALID   <= axi_rvalid;
   
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => MB_CLK,
      SRESET => sreset
      );
   
   
   -- synchronize time_dval
   S1 : double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => IRIG_DATA.TIME_DVAL, CLK => MB_CLK, Q => time_dval_sync);
   E1 : gh_edge_det port map(clk => MB_CLK, rst => sreset, D => time_dval_sync, sre => time_dval_sre, re => open, fe => open, sfe => open);
   
   -- synchronize status_dval
   S2 : double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => IRIG_DATA.STATUS_DVAL, CLK => MB_CLK, Q => status_dval_sync);
   
   -- synchronize IRIG_PPS
   S3 : double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => IRIG_PPS_IN, CLK => MB_CLK, Q => irig_pps_sync);
   
   -- synchronize IRIG_VALID_SOURCE
   S4 : double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => IRIG_VALID_SOURCE, CLK => MB_CLK, Q => irig_valid_source_sync);

   ----------------------------------------------------------------------------
   --  stockage des infos dans des registres 
   ----------------------------------------------------------------------------
   U2: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then                         
         
         -- irig data  
         if time_dval_sre = '1' then      
            irig_data_latch.seconds_reg  <= IRIG_DATA.seconds_reg;
            irig_data_latch.minutes_reg  <= IRIG_DATA.minutes_reg;
            irig_data_latch.hours_reg  <= IRIG_DATA.hours_reg;
            irig_data_latch.dayofyear_reg  <= IRIG_DATA.dayofyear_reg;
            irig_data_latch.tenthsofsec_reg  <= IRIG_DATA.tenthsofsec_reg;
            irig_data_latch.year_reg  <= IRIG_DATA.year_reg;
            irig_data_rdy <= '1';
         end if;
         
         if irig_pps_sync = '1' or irig_valid_source_sync = '0' then       
            irig_data_rdy <= '0';
         end if;
         
         -- irig status
         if status_dval_sync = '1' then  
            irig_data_latch.status_reg <= IRIG_DATA.STATUS_REG;
         end if;
         
      end if;       
   end process; 
   
   ---------------------------------------------------------- 
   -- watchdog  
   ---------------------------------------------------------- 
   U3 : process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            mb_speed_err_i <= '0'; 
            mb_on_time <= '1';
            irig_data_rdy_last <= irig_data_rdy; 
            irig_en_last <= irig_en_i;
            irig_data_available <= '0';
         else    
            
            -- le pps de irig
            irig_valid_pps <= irig_pps_sync and irig_en_i;
            
            -- misc
            irig_en_last <= irig_en_i;
            irig_data_rdy_last <= irig_data_rdy; 
            
            -- fenetre de validité du pps 
            pps_acq_window_pipe(0) <= irig_data_rdy;     -- fenetre de validité de la PPS IRIG
            pps_acq_window_pipe(7 downto 1) <= pps_acq_window_pipe(6 downto 0);               
            if irig_en_i = '1' then 
               PPS_ACQ_WINDOW <= pps_acq_window_pipe(7); -- decalage requis.
            else
               PPS_ACQ_WINDOW <= '1';                    -- si l'IRIG n'est pas activé alors PPS_ACQ_WINDOW = '1' pour ne rien changer à la logique existente
            end if;
            
            -- watchdog sur la lenteur du MB 
            if irig_data_rdy_last = '0' and irig_data_rdy = '1' then              -- le flag  mb_on_time est mis à '0' lorsque des données IRIG sont prête pour le MB
               mb_on_time <= '0';
            end if;
            if irig_reg_read_by_mb = '1' then                                     -- ce flag est à '1' lorsque le MB a pu lire les données
               mb_on_time <= '1';
            end if;            
            if mb_on_time = '0' and irig_valid_pps = '1' then 
               mb_speed_err_i <= '1';                  -- si le MB n'a pas pu lire les données avant le passage de la PPS de synchro alors il est lent !!! Erreur grave!
            end if;            
            if irig_en_last = '0' and irig_en_i = '1' then 
               mb_speed_err_i <='0';                    -- à remetre à '0' lorsqu'on est certain que le MB est à l'ecoute. Il n'est pas à l'ecoute de IRIG au demarrage du système
            end if;
            
            -- manage irig data available
            if irig_data_rdy_last = '0' and irig_data_rdy = '1' then
               irig_data_available <= '1';   -- de nouvelles données sont disponibles
            end if;
            if irig_reg_read_by_mb = '1' or irig_data_rdy = '0' then
               irig_data_available <= '0';   -- les données ont été lues ou invalidées
            end if;
            
         end if;
      end if;    
   end process;
   
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U4: process(MB_CLK)
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
   -- RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U5: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         
         irig_reg_read_by_mb <= '0'; 
         
         case axi_araddr(7 downto 0) is    
            when X"00" =>  axi_rdata <= resize(irig_data_latch.seconds_reg, 32);
            when X"04" =>  axi_rdata <= resize(irig_data_latch.minutes_reg, 32);
            when X"08" =>  axi_rdata <= resize(irig_data_latch.hours_reg, 32);
            when X"0C" =>  axi_rdata <= resize(irig_data_latch.dayofyear_reg, 32);
            when X"10" =>  axi_rdata <= resize(irig_data_latch.tenthsofsec_reg, 32);
            when X"14" =>  axi_rdata <= resize(irig_data_latch.year_reg, 32);          irig_reg_read_by_mb <= '1'; -- ne pas deplacer  irig_reg_read_by_mb de cette ligne  
            when X"18" =>  axi_rdata <= resize('0' & irig_valid_source_sync, 32);   
            when X"1C" =>  axi_rdata <= resize('0' & irig_data_available, 32); 
            when X"20" =>  axi_rdata <= resize(irig_data_latch.status_reg, 32);
            when X"24" =>  axi_rdata <= resize('0' & delay_i, 32);
            when X"28" =>  axi_rdata <= resize('0' & mb_speed_err_i, 32);
            
            when others=>  axi_rdata <= (others =>'1');
         end case;        
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U6: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else 
            
            if (axi_awready = '0' and MB_MOSI.AWVALID = '1' and MB_MOSI.WVALID = '1') then
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
   
   ----------------------------------------------------------------------------
   -- WR : reception configuration
   ----------------------------------------------------------------------------
   U7: process(MB_CLK)        -- 
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            irig_en_i <= '0';      
         else			                    
            if slv_reg_wren = '1' and MB_MOSI.WSTRB =  "1111" then -- Master write, toutes les transcations à 32 bits !!! comme dans IRCDEV 					
               case axi_awaddr(7 downto 0) is 
                  when X"00" =>  irig_en_i <= data_i(0);           -- permet de savoir si le irig est la source de temps à utiliser ou pas.  
                  when X"04" =>  delay_i <= data_i(31 downto 0);				  

                  when others => --do nothing                  
               end case;               
            end if;                      
         end if;
      end if;
   end process;
   
   --------------------------------
   -- WR  : WR feedback envoyé au MB
   --------------------------------
   U8: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
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
