------------------------------------------------------------------
--!   @file : adc_readout_mb_intf
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

entity adc_readout_mb_intf is
   port(
      ARESET            : in std_logic;
      
      CLK               : in std_logic;
      MB_CLK            : in std_logic;     
      
      ADC_CFG        : out std_logic_vector(1 downto 0);
      ADC_CALIB_R       : out std_logic_vector(31 downto 0);
      ADC_CALIB_Q       : out std_logic_vector(31 downto 0);
      
      MB_MOSI           : in t_axi4_lite_mosi;
      MB_MISO           : out t_axi4_lite_miso
      );
end adc_readout_mb_intf;


architecture rtl of adc_readout_mb_intf is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;  
   
   component double_sync
      generic(
         INIT_VALUE : BIT := '0');
      port(
         D : in STD_LOGIC;
         Q : out STD_LOGIC;
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC);
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
   
   signal adc_cfg_i                  : std_logic_vector(1 downto 0);
   signal adc_calib_r_i             : std_logic_vector(31 downto 0);
   signal adc_calib_q_i              : std_logic_vector(31 downto 0);
   signal adc_cfg_valid_i            : std_logic;
   signal adc_cfg_valid_sync         : std_logic;
   
   signal adc_calib_r_hold          : std_logic_vector(31 downto 0);
   signal adc_calib_q_hold          : std_logic_vector(31 downto 0);
   signal adc_cfg_hold               : std_logic_vector(1 downto 0);
   
   attribute dont_touch : string; 
   attribute dont_touch of adc_calib_r_hold : signal is "true";
   attribute dont_touch of adc_calib_q_hold : signal is "true";
   attribute dont_touch of adc_cfg_hold : signal is "true";
   
begin
   
   ADC_CFG <= adc_cfg_hold;
   ADC_CALIB_R <= adc_calib_r_hold;
   ADC_CALIB_Q <= adc_calib_q_hold;
   
   -- I/O Connections assignments
   MB_MISO.AWREADY  <= axi_awready;
   MB_MISO.WREADY   <= axi_wready;
   MB_MISO.BRESP	  <= axi_bresp;
   MB_MISO.BVALID   <= axi_bvalid;
   MB_MISO.ARREADY  <= axi_arready;
   MB_MISO.RDATA	  <= axi_rdata;
   MB_MISO.RRESP	  <= axi_rresp;
   MB_MISO.RVALID   <= axi_rvalid;
   
   sync_cfg_valid : double_sync port map(D => adc_cfg_valid_i, Q => adc_cfg_valid_sync, RESET => sreset, CLK => CLK);
   
   -- on considère que les bus de données sont stabilisés quand on détecte un RE sur adc_cfg_valid_sync
   hold_data: process(CLK)
      variable adc_cfg_valid_sync_pipe : std_logic_vector(1 downto 0) := (others => '0');
   begin
      if rising_edge(CLK) then 
         if adc_cfg_valid_sync_pipe = "01" then
            adc_calib_r_hold <= adc_calib_r_i;
            adc_calib_q_hold <= adc_calib_q_i;
            adc_cfg_hold <= adc_cfg_i;
         end if;
         
         adc_cfg_valid_sync_pipe := adc_cfg_valid_sync_pipe(0) & adc_cfg_valid_sync;
      end if;
   end process;
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => MB_CLK,
      SRESET => sreset
      );
   
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
         case axi_araddr(7 downto 0) is    
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
            adc_cfg_i <= "00";
            adc_calib_r_i <= (others => '0');
            adc_calib_q_i <= (others => '0');
            adc_cfg_valid_i <= '0';
         else			                    
            if slv_reg_wren = '1' and MB_MOSI.WSTRB =  "1111" then -- Master write, toutes les transcations à 32 bits !!! comme dans IRCDEV 					
               case axi_awaddr(7 downto 0) is 
                  when X"00" =>  adc_cfg_i <= data_i(1 downto 0);
                  when X"04" =>  adc_calib_r_i <= data_i;
                  when X"08" =>  adc_calib_q_i <= data_i;
                  when X"0C" =>  adc_cfg_valid_i <= data_i(0);
                  when others => --do nothing                  
               end case;               
            end if;                      
         end if;
      end if;
   end process;
   
   --------------------------------
   -- WR  : WR feedback envoyé au PPC
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
