------------------------------------------------------------------
--!   @file : exp_time_mb_intf
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
use work.exposure_define.all;
use work.tel2000.all;

entity exp_time_mb_intf is
   port(
      CLK           : in std_logic;
      ARESET        : in std_logic;
      MB_MOSI       : in t_axi4_lite_mosi;
      MB_MISO       : out t_axi4_lite_miso;
      EXP_CONFIG    : out exp_config_type;
      MB_EXP_INFO   : out exp_info_type
      );
end exp_time_mb_intf;

architecture rtl of exp_time_mb_intf is
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;        
   
   constant EHDRI_INDEX_NOT_ACTIVE    : std_logic_vector(7 downto 0):= x"05";
   
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
   signal exp_config_i              : exp_config_type;
   signal mb_exp_info_i             : exp_info_type;
   signal new_config_valid          : std_logic;
   signal new_config_valid_last     : std_logic;
   
begin
   
   
   -- I/O Connections assignments
   MB_MISO.AWREADY  <= axi_awready;
   MB_MISO.WREADY   <= axi_wready;
   MB_MISO.BRESP	  <= axi_bresp;
   MB_MISO.BVALID   <= axi_bvalid;
   MB_MISO.ARREADY  <= axi_arready;
   MB_MISO.RDATA	  <= axi_rdata;
   MB_MISO.RRESP	  <= axi_rresp;
   MB_MISO.RVALID   <= axi_rvalid;
   
   MB_EXP_INFO <= mb_exp_info_i;
   
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U3: process (CLK)
   begin
      if rising_edge(CLK) then 
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
   U4: process(CLK)
   begin
      if rising_edge(CLK) then
         
         case axi_araddr(7 downto 0) is
            -- feedback
            when X"00" =>  axi_rdata <= resize(exp_config_i.exp_source, 32);
            when X"04" =>  axi_rdata <= std_logic_vector(resize(exp_config_i.exp_time_min, 32));
            when X"08" =>  axi_rdata <= std_logic_vector(resize(exp_config_i.exp_time_max, 32));
            when X"0C" =>  axi_rdata <= std_logic_vector(resize(mb_exp_info_i.exp_time, 32));
            when others=>  axi_rdata <= (others =>'1');
         end case;        
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U5: process (CLK)
   begin
      if rising_edge(CLK) then 
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
   U6: process(CLK)        -- 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            exp_config_i.exp_source <= MB_SOURCE;  -- Par defaut, source = µblaze
            mb_exp_info_i.exp_dval <= '0';
            new_config_valid <= '0'; 
            new_config_valid_last <= '0';
         else			
            
            if slv_reg_wren = '1' and MB_MOSI.WSTRB =  "1111" then -- Master write, toutes les transcations à 32 bits !!! comme dans IRCDEV 					
               
               case axi_awaddr(7 downto 0) is 
                  when X"00" => 
                     exp_config_i.exp_source <= data_i(exp_config_i.exp_source'length-1 downto 0);
                     new_config_valid <= '0'; -- ainsi dval passe à '1' à la fin de la reception et y reste jusqu'au prochain déebut de reception
                  
                  when X"04" => 
                     exp_config_i.exp_time_min <= unsigned(data_i(exp_config_i.exp_time_min'length-1 downto 0));
                  
                  when X"08" => 
                     exp_config_i.exp_time_max <= unsigned(data_i(exp_config_i.exp_time_max'length-1 downto 0));
                  
                  when X"0C" => 
                     mb_exp_info_i.exp_time <= unsigned(data_i( mb_exp_info_i.exp_time'length-1 downto 0));
                     new_config_valid <= '1'; 
                  
                  when others => --do nothing
                  
               end case;  
            end if;
            
            mb_exp_info_i.exp_indx <= EHDRI_INDEX_NOT_ACTIVE;
            mb_exp_info_i.exp_dval <= new_config_valid; -- pour le mblaze, dval sera toujours à '1' (sauf quand la config est en progresss) car elle est asynchrone par rapport aux sequençage du détecteur
            
            -- sortie de la config
            new_config_valid_last <= new_config_valid;
            if new_config_valid = '1' then              
               EXP_CONFIG <= exp_config_i;
            end if;                   
            EXP_CONFIG.EXP_NEW_CFG <= new_config_valid and not new_config_valid_last; -- pulse de nouvelle config            
            
         end if;
      end if;
   end process;
   
   --------------------------------
   -- WR  : WR feedback envoyé au PPC
   --------------------------------
   U7: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
         else
            if slv_reg_wren = '1' and axi_bvalid = '0' then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif MB_MOSI.BREADY = '1' and axi_bvalid = '1' then   --check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process;
   
end rtl;
