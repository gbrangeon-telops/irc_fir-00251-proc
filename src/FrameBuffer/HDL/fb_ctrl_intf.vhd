-------------------------------------------------------------------------------
--
-- Title       : control_intf
-- Design      : tb_frame_buffer
-- Author      : Philippe Couture   
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_ctrl_intf.vhd
-- Generated   : Mon Aug 10 13:20:42 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.fbuffer_define.all;

entity fb_ctrl_intf is
   port (
   
      ARESETN                   : in std_logic;
      CLK                       : in std_logic;

      MB_MOSI                   : in t_axi4_lite_mosi;
      MB_MISO                   : out t_axi4_lite_miso;
      
      USER_CFG                  : out frame_buffer_cfg_type;
      FB_CFG                    : in frame_buffer_cfg_type;
            
      STATUS                    : in std_logic_vector(7 downto 0); 
      WR_FR_STAT                : in axis_frame_rate_type;
      RD_FR_STAT                : in axis_frame_rate_type;
      ERROR                     : in std_logic_vector(15 downto 0)
   );     
end fb_ctrl_intf;



architecture fb_ctrl_intf of fb_ctrl_intf is
  component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   component gh_stretch 
	GENERIC (stretch_count: integer :=1023);
	 port(
		 CLK : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC
	     );
   end component;

   signal areset_i                  : std_logic; 
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
   signal user_cfg_i                : frame_buffer_cfg_type := fb_cfg_default;
   signal status_i                  : std_logic_vector(7 downto 0);
   signal error_i                   : std_logic_vector(15 downto 0);
  
begin  
   
   -- I/O Connections assignments
   areset_i         <= not ARESETN;
   status_i         <= STATUS;
   error_i          <= ERROR;   
   USER_CFG         <= user_cfg_i;   
   MB_MISO.AWREADY  <= axi_awready;
   MB_MISO.WREADY   <= axi_wready;
   MB_MISO.BRESP	  <= axi_bresp;
   MB_MISO.BVALID   <= axi_bvalid;
   MB_MISO.ARREADY  <= axi_arready;
   MB_MISO.RDATA	  <= axi_rdata;
   MB_MISO.RRESP	  <= axi_rresp;
   MB_MISO.RVALID   <= axi_rvalid;
           
   U2: sync_reset
   port map(
      ARESET => areset_i,
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
      
            when X"00" => axi_rdata                <= resize(FB_CFG.buffer_a_addr,32);
            when X"04" => axi_rdata                <= resize(FB_CFG.buffer_b_addr,32);               
            when X"08" => axi_rdata                <= resize(FB_CFG.buffer_c_addr,32);               
            when X"0C" => axi_rdata                <= resize(std_logic_vector(FB_CFG.frame_byte_size),32);             
            when X"10" => axi_rdata                <= resize(std_logic_vector(FB_CFG.hdr_pix_size),32);                
            when X"14" => axi_rdata                <= resize(std_logic_vector(FB_CFG.img_pix_size),32);                
            when X"18" => axi_rdata                <= resize(std_logic_vector(FB_CFG.fval_pause_min),32);               
            when X"1C" => axi_rdata                <= resize(FB_CFG.flush,32);                       
            when X"20" => axi_rdata                <= resize(status_i,32);
            when X"24" => axi_rdata                <= resize(error_i,32); 
            when X"28" => axi_rdata                <= resize(WR_FR_STAT.frame_rate_min,32);
            when X"2C" => axi_rdata                <= resize(WR_FR_STAT.frame_rate,32);
            when X"30" => axi_rdata                <= resize(WR_FR_STAT.frame_rate_max,32);
            when X"34" => axi_rdata                <= resize(RD_FR_STAT.frame_rate_min,32);
            when X"38" => axi_rdata                <= resize(RD_FR_STAT.frame_rate,32);
            when X"3C" => axi_rdata                <= resize(RD_FR_STAT.frame_rate_max,32);         
            when others=> axi_rdata <= (others =>'1');
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
            user_cfg_i <= fb_cfg_default; 
         else
            if slv_reg_wren = '1' and MB_MOSI.WSTRB =  "1111" then -- Master write, toutes les transcations à 32 bits !!! comme dans IRCDEV 					
               case axi_awaddr(7 downto 0) is 
                  
                  when X"00" => user_cfg_i.buffer_a_addr               <= data_i(user_cfg_i.buffer_a_addr'length-1 downto 0);user_cfg_i.dval <= '0';
                  when X"04" => user_cfg_i.buffer_b_addr               <= data_i(user_cfg_i.buffer_b_addr'length-1 downto 0);
                  when X"08" => user_cfg_i.buffer_c_addr               <= data_i(user_cfg_i.buffer_c_addr'length-1 downto 0);
                  when X"0C" => user_cfg_i.frame_byte_size             <= unsigned(data_i(user_cfg_i.frame_byte_size'length-1 downto 0));
                  when X"10" => user_cfg_i.hdr_pix_size                <= unsigned(data_i(user_cfg_i.hdr_pix_size'length-1 downto 0));
                  when X"14" => user_cfg_i.img_pix_size                <= unsigned(data_i(user_cfg_i.img_pix_size'length-1 downto 0));
                  when X"18" => user_cfg_i.fval_pause_min              <= unsigned(data_i(user_cfg_i.fval_pause_min'length-1 downto 0)); 
                  when X"1C" => user_cfg_i.flush                       <= data_i(0); user_cfg_i.dval <= '1';

                  
                  when others => --do nothing
               end case;  
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

	 -- enter your statements here --

end fb_ctrl_intf;
