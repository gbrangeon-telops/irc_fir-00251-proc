------------------------------------------------------------------
--!   @file : gating_mblaze_intf
--!   @brief
--!   @details
--!
--!   $Rev: 22668 $
--!   $Author: elarouche $
--!   $Date: 2018-12-18 12:13:33 -0500 (mar., 18 dÃ©c. 2018) $
--!   $Id: gating_mblaze_intf.vhd 22668 2018-12-18 17:13:33Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/Gating/HDL/gating_mblaze_intf.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use work.tel2000.all;
use work.gating_define.all;

----------------------------------------------------------------------
-- copié à partir du flagging puisque les paramètres sont équivalents
----------------------------------------------------------------------

entity gating_mblaze_intf is
   port(
      
      ARESET                    : in std_logic;
      CLK                       : in std_logic;
      
      MB_MOSI                   : in t_axi4_lite_mosi;
      MB_MISO                   : out t_axi4_lite_miso;
      
      SOFT_TRIG                 : out std_logic;
      FLAG_CFG                  : out flag_cfg_type
      
      );
end gating_mblaze_intf;

architecture rtl of gating_mblaze_intf is
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;      
   
   signal sreset                    : std_logic; 
   
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

   signal trig_o	                  : std_logic; 
   signal flag_cfg_o                : flag_cfg_type;

begin
   
   FLAG_CFG <= flag_cfg_o;
   SOFT_TRIG <= trig_o;
   
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
   U2: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U4: process (CLK)
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
   U5: process(CLK)
   begin
      if rising_edge(CLK) then
         
         case axi_araddr(7 downto 0) is
            -- cfg feedback: partie trigger
            when X"00" => axi_rdata <= resize(flag_cfg_o.mode, 32);
            when X"04" => axi_rdata <= resize(std_logic_vector(flag_cfg_o.delay), 32); 
            when X"08" => axi_rdata <= resize(std_logic_vector(flag_cfg_o.frame_count), 32);
            when X"0C" => axi_rdata <= x"0000000" & "000" & flag_cfg_o.trig_source;
            when X"10" => axi_rdata <= x"0000000" & "000" & trig_o;
               
            when others => axi_rdata <= (others =>'1');
         end case;        
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U6: process (CLK)
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
   U7: process(CLK)        -- 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            flag_cfg_o <= flag_cfg_default;
            trig_o <= '0';
         else
            
            if slv_reg_wren = '1' and MB_MOSI.WSTRB =  "1111" then -- Master write, toutes les transcations à 32 bits !!! comme dans IRCDEV 					
               case axi_awaddr(7 downto 0) is 
                  -- cfg partie trigger
                  when X"00" => flag_cfg_o.mode          <= data_i(flag_cfg_o.mode'length-1 downto 0);  flag_cfg_o.dval <= '0';
                  when X"04" => flag_cfg_o.delay         <= unsigned(data_i(flag_cfg_o.delay'length-1 downto 0));  flag_cfg_o.dval <= '0';
                  when X"08" => flag_cfg_o.frame_count   <= unsigned(data_i(flag_cfg_o.frame_count'length-1 downto 0));  flag_cfg_o.dval <= '0';
                  when X"0C" => flag_cfg_o.trig_source   <= data_i(0);  flag_cfg_o.dval <= '1';
                  when X"10" => trig_o                   <= data_i(0);
                  
                  when others => --do nothing
               end case;
            else
               trig_o <= '0';
            end if;
         end if;
      end if;
   end process;
   
   --------------------------------
   -- WR  : WR feedback envoyé au MB
   --------------------------------
   U8: process (CLK)
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
