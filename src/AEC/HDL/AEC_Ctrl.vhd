-------------------------------------------------------------------------------
--
-- Title       : AEC_Ctrl
-- Author      : Jean-Alexis Boulet
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : This file implement the axi_lite communication and interrupt gen to the micro blaze
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;

entity AEC_Ctrl is
   port(     
      --------------------------------
      -- CUM SUM & Histogram Interface
      --------------------------------                       
      CUMSUM_READY         : in  std_logic;
      LOWERCUMSUM          : in  std_logic_vector(23 downto 0);
      UPPERCUMSUM          : in  std_logic_vector(23 downto 0);
      LOWERBINID           : in  std_logic_vector(15 downto 0);
      IMAGE_FRACTION_FBCK  : in  std_logic_vector(23 downto 0); -- in pixel
      H_NB_PIXEL           : in  std_logic_vector(23 downto 0);
      H_TIMESTAMP          : in  std_logic_vector(31 downto 0);
      H_EXPTIME            : in  std_logic_vector(31 downto 0);
      H_FWPOSITION         : in  std_logic_vector(7 downto 0);
      CUMSUM_ERROR         : in  std_logic_vector(0 downto 0);
      
      --------------------------------
      -- AEC+ Interface
      --------------------------------                       
      EXP_TIME_AECPLUS : in STD_LOGIC_VECTOR(31 downto 0);
      SUM_CNT_AECPLUS : in STD_LOGIC_VECTOR(41 downto 0);
      NB_PIXELS_AECPLUS : in STD_LOGIC_VECTOR(31 downto 0);
      DATA_VALID_AECPLUS : in STD_LOGIC;
      
      
      IMAGE_FRACTION : out std_logic_vector(23 downto 0); -- in pixel
      MSB_POS        : out std_logic_vector(1 downto 0);
      NB_BIN         : out std_logic_vector(15 downto 0);
      CLEAR_MEM     : out std_logic;
      AEC_MODE      : out std_logic_vector(1 downto 0);  -- "00" off, "01" on, "1X" futur use   

      

      --------------------------------
      -- PowerPC Interface
      -------------------------------- 
      AXI4_LITE_MOSI : in t_axi4_lite_mosi;
      AXI4_LITE_MISO : out t_axi4_lite_miso;   
      INTERRUPT : out std_logic; 

      --------------------------------
      -- MISC
      --------------------------------   
      ARESETN         : in  std_logic;
      CLK_CTRL       : in  std_logic;
      CLK_DATA       : in  std_logic
      );
end AEC_Ctrl;

architecture RTL of AEC_Ctrl is

  constant C_S_AXI_DATA_WIDTH : integer := 32;
  constant C_S_AXI_ADDR_WIDTH : integer := 32;
  constant ADDR_LSB           : integer := 2;   -- 4 bytes access
  constant OPT_MEM_ADDR_BITS  : integer := 5;   -- Number of supplement bit
   
   ----------------------------   
   -- Address of registers
   ----------------------------   
   constant IMAGE_FRACTION_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant AECMODE_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_BIN_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant MSB_POS_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant CLEARMEM_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HIST_UPPERCUMSUM_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HIST_LOWERBIN_ID_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HIST_LOWERCUMSUM_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HIST_EXPOSURETIME_ADDR    : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(32,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HIST_TIMESTAMP_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(36,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HIST_NB_PIXEL_ADDR        : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(40,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant CUMSUM_ERROR_ADDR         : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(44,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant IMAGE_FRACTION_FBCK_ADDR  : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(48,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant IMAGE_FWPOSITION_ADDR  	  : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(52,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant AECPLUS_EXPTIME_ADDR  	  : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(56,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant AECPLUS_SUMCNT_MSB_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(60,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant AECPLUS_SUMCNT_LSB_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(64,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant AECPLUS_NBPIXELS_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(68,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant AECPLUS_DATAVALID_ADDR 	  : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(72,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   
   ----------------------------   
   -- Component Declaration
   ----------------------------   
   component double_sync
   generic(
      INIT_VALUE : bit := '0'
   );
	port(
		D : in STD_LOGIC;
		Q : out STD_LOGIC := '0';
		RESET : in STD_LOGIC;
		CLK : in STD_LOGIC
		);
   end component;
   
   component double_sync_vector
	port(
		D : in STD_LOGIC_vector;
		Q : out STD_LOGIC_vector;
		CLK : in STD_LOGIC
		);
   end component;
   
   component sync_resetn is
      port(
         ARESETN : in STD_LOGIC;
         SRESETN : out STD_LOGIC;
         CLK : in STD_LOGIC
         );
   end component;
   
   
   signal sresetn      : std_logic;
   signal sreset        :std_logic;
   
   
   --! User Input Register Declarations
   signal cumsum_error_i         : std_logic_vector(0 downto 0); --! 
   signal h_lowercumsum_i   : std_logic_vector(23 downto 0); --! h_lowercumsum_reg
   signal h_uppercumsum_i   : std_logic_vector(23 downto 0); --! h_uppercumsum_reg
   signal h_lowerbin_id_i   : std_logic_vector(15 downto 0); --! h_lowerbin_id_reg
   signal h_imagefraction_fbck_i   : std_logic_vector(23 downto 0); --! h_imagefraction_fbck_reg
   signal h_timestamp_i     : std_logic_vector(31 downto 0); --! h_timestamp_reg
   signal h_exptime_i       : std_logic_vector(31 downto 0); --! h_exptime_reg
   signal h_img_nb_pix_i    : std_logic_vector(23 downto 0); --! h_exptime_reg
   signal h_fwposition_i    : std_logic_vector(7 downto 0); --! h_fwposition_reg

   --! User Output Register Declarations
   signal ImageFraction_o  : std_logic_vector(23 downto 0); 
   signal msb_pos_o        : std_logic_vector(1 downto 0); 
   signal nb_bin_o         : std_logic_vector(15 downto 0);   
   signal clear_mem_o      : std_logic;
   signal aec_mode_o       : std_logic_vector(1 downto 0);

    
   -- AXI4LITE signals
   signal axi_awaddr	  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
   signal axi_awready  : std_logic;
   signal axi_wready	  : std_logic;
   signal axi_bresp	  : std_logic_vector(1 downto 0);
   signal axi_bvalid	  : std_logic;
   signal axi_araddr	  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
   signal axi_arready  : std_logic;
   signal axi_rdata	  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal axi_rresp	  : std_logic_vector(1 downto 0);
   signal axi_rvalid	  : std_logic;
   signal axi_wstrb    : std_logic_vector(3 downto 0);
   
   signal slv_reg_rden : std_logic;
   signal slv_reg_wren : std_logic;
   signal reg_data_out : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   
   signal exptime_aecplus_i : std_logic_vector(31 downto 0);
   signal sumcnt_aecplus_i : std_logic_vector(41 downto 0);
   signal nbpixels_aecplus_i : std_logic_vector(31 downto 0);
   signal aecplus_dval_i : std_logic;
   
begin
  
   sreset <= not  sresetn;
   INTERRUPT <= CUMSUM_READY;

   -- enter your statements here --
   U0A : sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK_CTRL);   
   h_lowercumsum_i <= LOWERCUMSUM;                                -- U1B : double_sync_vector port map(D => LOWERCUMSUM, Q => h_lowercumsum_i ,  CLK => CLK_CTRL);   
   h_uppercumsum_i <= UPPERCUMSUM;                                -- U1C : double_sync_vector port map(D => UPPERCUMSUM, Q => h_uppercumsum_i,   CLK => CLK_CTRL);
   h_lowerbin_id_i <= LOWERBINID;                                 -- U1D : double_sync_vector port map(D => LOWERBINID,  Q => h_lowerbin_id_i ,  CLK => CLK_CTRL);
   h_imagefraction_fbck_i <= IMAGE_FRACTION_FBCK;                 -- U1N : double_sync_vector port map(D => IMAGE_FRACTION_FBCK, Q => h_imagefraction_fbck_i ,  CLK => CLK_CTRL);
   h_timestamp_i <= H_TIMESTAMP;                                  -- U1E : double_sync_vector port map(D => H_TIMESTAMP,   Q => h_timestamp_i,  CLK => CLK_CTRL); 
   h_exptime_i <= H_EXPTIME;                                      -- U1F : double_sync_vector port map(D => H_EXPTIME,     Q => h_exptime_i ,   CLK => CLK_CTRL);
   h_img_nb_pix_i <= H_NB_PIXEL;                                  -- U1L : double_sync_vector port map(D => H_NB_PIXEL,     Q => h_img_nb_pix_i ,   CLK => CLK_CTRL);
   cumsum_error_i <= CUMSUM_ERROR;                                -- U1M : double_sync_vector port map(D => CUMSUM_ERROR,   Q => cumsum_error_i ,   CLK => CLK_CTRL);
   h_fwposition_i <= H_FWPOSITION;                                -- U1P : double_sync_vector port map(D => H_FWPOSITION,   Q => h_fwposition_i ,   CLK => CLK_CTRL);
   
   IMAGE_FRACTION <= ImageFraction_o;                             -- U1G : double_sync_vector port map(D => ImageFraction_o,  Q => IMAGE_FRACTION, CLK => CLK_DATA);
   MSB_POS <= msb_pos_o;                                          -- U1H : double_sync_vector port map(D => msb_pos_o,        Q => MSB_POS,        CLK => CLK_DATA); 
   NB_BIN <= nb_bin_o;                                            -- U1I : double_sync_vector port map(D => nb_bin_o,         Q => NB_BIN ,        CLK => CLK_DATA);
   CLEAR_MEM <= clear_mem_o;                                      -- U1J : double_sync port map(D => clear_mem_o,   Q => CLEAR_MEM , RESET => sreset,  CLK => CLK_DATA);
   AEC_MODE <= aec_mode_o;                                        -- U1K : double_sync_vector port map(D => aec_mode_o,   Q => AEC_MODE ,  CLK => CLK_DATA); 
 
   exptime_aecplus_i <= EXP_TIME_AECPLUS;                         -- U1Q : double_sync_vector port map(D => EXP_TIME_AECPLUS,   Q => exptime_aecplus_i,  CLK => CLK_DATA); 
   sumcnt_aecplus_i <= SUM_CNT_AECPLUS;                           -- U1R : double_sync_vector port map(D => SUM_CNT_AECPLUS,   Q => sumcnt_aecplus_i,  CLK => CLK_DATA); 
   nbpixels_aecplus_i <= NB_PIXELS_AECPLUS;                       -- U1S : double_sync_vector port map(D => NB_PIXELS_AECPLUS,   Q => nbpixels_aecplus_i,  CLK => CLK_DATA); 
   aecplus_dval_i <= DATA_VALID_AECPLUS;                          -- U1T : double_sync port map(D => DATA_VALID_AECPLUS,   Q => aecplus_dval_i, RESET => sreset, CLK => CLK_DATA); 

   -- I/O Connections assignments
   AXI4_LITE_MISO.AWREADY  <= axi_awready;
   AXI4_LITE_MISO.WREADY   <= axi_wready;
   AXI4_LITE_MISO.BRESP	   <= axi_bresp;
   AXI4_LITE_MISO.BVALID   <= axi_bvalid;
   AXI4_LITE_MISO.ARREADY  <= axi_arready;
   AXI4_LITE_MISO.RDATA	   <= axi_rdata;
   AXI4_LITE_MISO.RRESP	   <= axi_rresp;
   AXI4_LITE_MISO.RVALID   <= axi_rvalid;
   

   ----------------------------------------------------------------------------
   -- AXI WR : contr?du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait ?u max 1 CLK sur 2 
   U2: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else
            
            if (axi_awready = '0' and AXI4_LITE_MOSI.AWVALID = '1' and AXI4_LITE_MOSI.WVALID = '1') then
               axi_awready <= '1';
               axi_awaddr <= AXI4_LITE_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;
            
            if (axi_wready = '0' and AXI4_LITE_MOSI.WVALID = '1' and AXI4_LITE_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';               
            end if;              
            
         end if;
      end if;
   end process;   
   slv_reg_wren <= axi_wready and AXI4_LITE_MOSI.WVALID and axi_awready and AXI4_LITE_MOSI.AWVALID ;
   axi_wstrb <= AXI4_LITE_MOSI.WSTRB; 
   
   ----------------------------------------------------------------------------
   -- AXI WR : reception configuration
   ----------------------------------------------------------------------------
   U3: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            ImageFraction_o <= (others => '0');
            msb_pos_o <= (others => '0');
            nb_bin_o <= (others => '0');
            clear_mem_o <='0';
            aec_mode_o <= (others => '0');
         else
            if (slv_reg_wren = '1') and axi_wstrb = "1111" then
               case axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) is      
                  when IMAGE_FRACTION_ADDR   =>  ImageFraction_o  <= AXI4_LITE_MOSI.WDATA(ImageFraction_o'length-1 downto 0);
                  when CLEARMEM_ADDR         =>  clear_mem_o      <= AXI4_LITE_MOSI.WDATA(0);
                  when NB_BIN_ADDR           =>  nb_bin_o         <= AXI4_LITE_MOSI.WDATA(nb_bin_o'length-1 downto 0); 
                  when MSB_POS_ADDR          =>  msb_pos_o        <= AXI4_LITE_MOSI.WDATA(msb_pos_o'length-1 downto 0);
                  when AECMODE_ADDR          =>  aec_mode_o       <= AXI4_LITE_MOSI.WDATA(aec_mode_o'length-1 downto 0);
                  when others  =>                  
               end case;                                                                                          
            end if;                                        
         end if;
      end if;
   end process; 
   

   ----------------------------------------------------------------------------
   -- AXI WR : WR response
   ----------------------------------------------------------------------------
   U4: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
         else
            if (axi_awready = '1' and AXI4_LITE_MOSI.AWVALID = '1' and axi_wready = '1' and AXI4_LITE_MOSI.WVALID = '1' and axi_bvalid = '0'  ) then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif (AXI4_LITE_MOSI.BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------------------------------
   -- RD : contr?du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait ?u max 1 CLK sur 2   
   U5: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then 
         if sresetn = '0' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if axi_arready = '0' and AXI4_LITE_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= AXI4_LITE_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;            
            if axi_arready = '1' and AXI4_LITE_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and AXI4_LITE_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   
   
   ---------------------------------------------------------------------------- 
   -- RD : donn? vers ?Blaze                                       
   ---------------------------------------------------------------------------- 
   U6: process(CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then         
         case axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) is
            when  HIST_LOWERCUMSUM_ADDR     => reg_data_out <= std_logic_vector(resize(h_lowercumsum_i     , reg_data_out'length));                  
            when  HIST_UPPERCUMSUM_ADDR     => reg_data_out <= std_logic_vector(resize(h_uppercumsum_i , reg_data_out'length));           
            when  HIST_LOWERBIN_ID_ADDR     => reg_data_out <= std_logic_vector(resize(h_lowerbin_id_i     , reg_data_out'length));       
            when  HIST_TIMESTAMP_ADDR       => reg_data_out <= std_logic_vector(resize(h_timestamp_i, reg_data_out'length));    
            when  HIST_EXPOSURETIME_ADDR    => reg_data_out <= std_logic_vector(resize(h_exptime_i, reg_data_out'length));
            when  HIST_NB_PIXEL_ADDR        => reg_data_out <= std_logic_vector(resize(h_img_nb_pix_i, reg_data_out'length));
            when  CUMSUM_ERROR_ADDR         => reg_data_out <= std_logic_vector(resize(cumsum_error_i, reg_data_out'length));
            when  IMAGE_FRACTION_FBCK_ADDR  => reg_data_out <= std_logic_vector(resize(h_imagefraction_fbck_i     , reg_data_out'length));
            when  IMAGE_FWPOSITION_ADDR     => reg_data_out <= std_logic_vector(resize(h_fwposition_i     , reg_data_out'length));
            when  AECPLUS_EXPTIME_ADDR      => reg_data_out <= std_logic_vector(resize(exptime_aecplus_i     , reg_data_out'length));
            when  AECPLUS_SUMCNT_MSB_ADDR   => reg_data_out <= std_logic_vector(resize(sumcnt_aecplus_i(41 downto 32), reg_data_out'length));
            when  AECPLUS_SUMCNT_LSB_ADDR   => reg_data_out <= std_logic_vector(resize(sumcnt_aecplus_i(31 downto 0), reg_data_out'length));
            when  AECPLUS_NBPIXELS_ADDR     => reg_data_out <= std_logic_vector(resize(nbpixels_aecplus_i, reg_data_out'length));
            when  AECPLUS_DATAVALID_ADDR    => reg_data_out <= x"0000000" & "000" & aecplus_dval_i;
            when others                     => reg_data_out <= (others => '0');
         end case;        
      end if;     
   end process;  

   ---------------------------------------------------------------------------- 
   -- Axi RD responses                                      
   ---------------------------------------------------------------------------- 
   U7: process (CLK_CTRL)
   begin
      if rising_edge(CLK_CTRL) then
         if sresetn = '0' then
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if (axi_arready = '1' and AXI4_LITE_MOSI.ARVALID = '1' and axi_rvalid = '0') then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif (axi_rvalid = '1' and AXI4_LITE_MOSI.RREADY = '1') then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
         end if;
      end if;
   end process;
   
   -- Implement memory mapped register select and read logic generation
   -- Slave register read enable is asserted when valid address is available
   -- and the slave is ready to accept the read address.
   slv_reg_rden <= axi_arready and AXI4_LITE_MOSI.ARVALID and (not axi_rvalid) ; 
   -- Read address mux
   axi_rdata <= reg_data_out;     -- register read data
   
end RTL;
