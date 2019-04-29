------------------------------------------------------------------
--!   @file : isc0207A_3k_clks_mmcm
--!   @brief
--!   @details
--!
--!   $Rev: 22554 $
--!   $Author: enofodjie $
--!   $Date: 2018-11-28 14:25:12 -0500 (mer., 28 nov. 2018) $
--!   $Id: isc0207A_3k_clks_mmcm.vhd 22554 2018-11-28 19:25:12Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/isc0207A_3k/HDL/isc0207A_3k_clks_mmcm.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_Define.all; 
use work.fpa_common_pkg.all;
use work.Tel2000.all;

entity isc0207A_3k_clks_mmcm is 
   generic(
      DYNAMIC_CFG_ENABLED : std_logic := '0'
      );   
   port(
      ARESET           : in std_logic;
      CLK_100M_IN      : in std_logic;
      
      FPA_INT_CFG      : fpa_intf_cfg_type;
      
      MCLK_SOURCE      : out std_logic;
      ADC_CLK_SOURCE   : out std_logic;
      MMCM_LOCKED      : out std_logic;
      
      CFG_IN_PROGRESS  : out std_logic      
      );
end isc0207A_3k_clks_mmcm;

architecture rtl of isc0207A_3k_clks_mmcm is 
   
   component SYNC_RESET is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   component native_to_axil32
      port (
         ARESET       : in std_logic;
         CLK          : in std_logic;      
         
         WR_ADD       : in std_logic_vector(31 downto 0);
         WR_DATA      : in std_logic_vector(31 downto 0);
         WR_STRB      : in std_logic_vector(3 downto 0);  
         WR_EN        : in std_logic;
         WR_BUSY      : out std_logic;
         
         RD_ADD       : in std_logic_vector(31 downto 0);      
         RD_DATA      : out std_logic_vector(31 downto 0);
         RD_EN        : in std_logic;
         RD_DVAL      : out std_logic;
         RD_BUSY      : out std_logic;       
         
         AXIL_MOSI    : out t_axi4_lite_mosi;
         AXIL_MISO    : in t_axi4_lite_miso;
         
         ERR          : out std_logic          
         );
   end component;   
   
   component isc0207A_3k_8_3_MHz_mmcm
      port (
         -- System interface
         s_axi_aclk      : in  std_logic;                                      
         s_axi_aresetn   : in  std_logic;                                      
         -- AXI Write address channel signals                                        
         s_axi_awaddr    : in  std_logic_vector(10 downto 0);                  
         s_axi_awvalid   : in  std_logic;                                      
         s_axi_awready   : out std_logic;                                      
         -- AXI Write data channel signals                                           
         s_axi_wdata     : in  std_logic_vector(31 downto 0);                  
         s_axi_wstrb     : in  std_logic_vector(3 downto 0);              
         s_axi_wvalid    : in  std_logic;                                      
         s_axi_wready    : out std_logic;                                      
         -- AXI Write response channel signals                                       
         s_axi_bresp     : out std_logic_vector(1 downto 0);                   
         s_axi_bvalid    : out std_logic;                                      
         s_axi_bready    : in  std_logic;                                      
         -- AXI Read address channel signals                                         
         s_axi_araddr    : in  std_logic_vector(10 downto 0);                  
         s_axi_arvalid   : in  std_logic;                                      
         s_axi_arready   : out std_logic;                                      
         -- AXI Read address channel signals                                         
         s_axi_rdata     : out std_logic_vector(31 downto 0);                  
         s_axi_rresp     : out std_logic_vector(1 downto 0);                   
         s_axi_rvalid    : out std_logic;                                      
         s_axi_rready    : in  std_logic;                                      
         -- Clock out ports
         mclk_source     : out    std_logic;
         quad_clk_source : out    std_logic;
         -- Status and control signals
         locked           : out    std_logic;
         -- Clock in ports
         clk_in           : in     std_logic
         );
   end component;
   
   type cfg_sm_type is(idle, wr_phase_st, read_status_st, check_status_st, pause_st, reg23_st1, reg23_st2, wait_locked_st, update_cfg_st);
   
   signal cfg_sm              : cfg_sm_type;
   signal mmcm_locked_i       : std_logic;
   signal wr_add_i            : std_logic_vector(31 downto 0);   
   signal wr_data_i           : std_logic_vector(31 downto 0);  
   signal wr_strb_i           : std_logic_vector(3 downto 0); 
   signal wr_en_i             : std_logic;  
   signal wr_busy_i           : std_logic;  
   signal rd_add_i            : std_logic_vector(31 downto 0);   
   signal rd_data_i           : std_logic_vector(31 downto 0);  
   signal rd_en_i             : std_logic;    
   signal rd_dval_i           : std_logic;  
   signal rd_busy_i           : std_logic;  
   signal cfg_miso_i          : t_axi4_lite_miso;
   signal cfg_mosi_i          : t_axi4_lite_mosi;
   signal sreset              : std_logic;
   signal clk_rdy_i           : std_logic;
   signal aresetn             : std_logic;
   signal new_cfg_pending     : std_logic;
   signal actual_adc_clk_phase: std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE'LENGTH-1 downto 0);
   signal pause_cnt           : unsigned(3 downto 0);
   signal cfg_in_progress_i   : std_logic;
   
begin
   
   MMCM_LOCKED <= mmcm_locked_i;
   aresetn <=  not ARESET;
   CFG_IN_PROGRESS <= cfg_in_progress_i;
   
   U0 : sync_reset 
   port map(
      ARESET => ARESET, 
      SRESET => sreset, 
      CLK    => CLK_100M_IN
      );
   
   -----------------------------------------------------------------
   -- Sans configuration dynamique
   ----------------------------------------------------------------- 
   DYN0 : if DYNAMIC_CFG_ENABLED = '0' generate      
      cfg_mosi_i.awvalid <= '0';
      cfg_mosi_i.wvalid  <= '0';
      cfg_mosi_i.bready  <= '1';
      cfg_mosi_i.arvalid <= '0';
      cfg_mosi_i.rready  <= '0';
      wr_en_i <= '0';
      rd_en_i <= '0';
      mmcm_locked_i <= clk_rdy_i;
   end generate;
   
   -----------------------------------------------------------------
   -- Avec configuration dynamique
   -----------------------------------------------------------------   
   DYN1 : if DYNAMIC_CFG_ENABLED = '1' generate
      
      U2 : native_to_axil32
      port map(
         ARESET     => ARESET,   
         CLK        => CLK_100M_IN,     
         WR_ADD     => wr_add_i, 
         WR_DATA    => wr_data_i, 
         WR_STRB    => wr_strb_i, 
         WR_EN      => wr_en_i, 
         WR_BUSY    => wr_busy_i,      
         RD_ADD     => rd_add_i, 
         RD_DATA    => rd_data_i, 
         RD_EN      => rd_en_i, 
         RD_DVAL    => rd_dval_i, 
         RD_BUSY    => rd_busy_i,
         AXIL_MISO  => cfg_miso_i,
         AXIL_MOSI  => cfg_mosi_i, 
         ERR        => open      
         );      
      
      U6: process(CLK_100M_IN)
      begin          
         if rising_edge(CLK_100M_IN) then         
            if sreset = '1' then
               cfg_sm <= idle;
               wr_en_i <= '0';
               rd_en_i <= '0';
               wr_strb_i <= (others => '1');
               new_cfg_pending <= '0';
               cfg_in_progress_i <= '0';
               mmcm_locked_i <= '0';
               actual_adc_clk_phase <= (others => '0');
               
            else                      
               
               mmcm_locked_i <= clk_rdy_i; 
               
               if std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE) /= actual_adc_clk_phase then 
                  new_cfg_pending <= '1';
               else
                  new_cfg_pending <= '0';
               end if;               
               
               -- fsm de prog de phase
               case cfg_sm is
                  
                  when idle =>
                     wr_en_i <= '0';
                     rd_en_i <= '0';
                     pause_cnt <= (others => '0');
                     cfg_in_progress_i <= '0';
                     if (new_cfg_pending = '1' and wr_busy_i = '0') and clk_rdy_i = '1' then
                        cfg_sm <= wr_phase_st;
                        cfg_in_progress_i <= '1';
                     end if;
                  
                  when wr_phase_st =>
                     wr_add_i <= resize(x"218", wr_add_i'length);
                     wr_data_i <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE);                  
                     wr_en_i <= '1';
                     cfg_sm <= read_status_st;
                  
                  when read_status_st =>
                     wr_en_i <= '0';
                     if rd_busy_i = '0' then                   
                        rd_add_i <=  resize(x"04", rd_add_i'length); 
                        rd_en_i  <= '1';
                        cfg_sm <= check_status_st; 
                     end if;
                  
                  when check_status_st => 
                     rd_en_i  <= '0';
                     if rd_dval_i = '1' then 
                        if unsigned(rd_data_i) = 1 then
                           cfg_sm <= reg23_st1;
                        else
                           cfg_sm <= wr_phase_st; --si status pas correcte, on reprend tout
                        end if;
                     end if;
                  
                  when reg23_st1 =>
                     wr_add_i    <=   resize(x"25C", wr_add_i'length);
                     wr_data_i   <=   resize(x"07", wr_data_i'length);                  
                     if wr_busy_i = '0' then 
                        wr_en_i     <=   '1';
                        cfg_sm <= pause_st;
                     end if;
                  
                  when pause_st =>
                     wr_en_i <= '0';
                     cfg_sm <= reg23_st2;                 
                  
                  when reg23_st2 =>                  
                     wr_add_i    <=   resize(x"25C", wr_add_i'length);
                     wr_data_i   <=   resize(x"02", wr_data_i'length);                  
                     if wr_busy_i = '0' then
                        wr_en_i     <=   '1';
                        cfg_sm <= wait_locked_st;
                     end if;                  
                  
                  when wait_locked_st =>
                     wr_en_i <= '0';
                     if clk_rdy_i = '1' then
                        cfg_sm <= update_cfg_st;
                     end if;
                  
                  when update_cfg_st =>
                     actual_adc_clk_phase <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE);
                     pause_cnt <= pause_cnt + 1;
                     if pause_cnt(3) = '1' then 
                        cfg_sm <= idle; 
                     end if;
                  
                  when others =>
                  
               end case;               
               
            end if;  
         end if;
      end process;      
   end generate;
   
   
   U10M :  isc0207A_3k_8_3_MHz_mmcm
   port map ( 
      s_axi_aclk                => CLK_100M_IN,                -- in
      s_axi_aresetn             => aresetn,                    -- in
      
      s_axi_awaddr              => cfg_mosi_i.awaddr(10 downto 0),          -- in
      s_axi_awvalid             => cfg_mosi_i.awvalid,         -- in
      s_axi_awready             => cfg_miso_i.awready,         -- out
      s_axi_wdata               => cfg_mosi_i.wdata,          -- in
      s_axi_wstrb               => cfg_mosi_i.wstrb,          -- in
      s_axi_wvalid              => cfg_mosi_i.wvalid,         -- in
      s_axi_wready              => cfg_miso_i.wready,         -- out
      s_axi_bresp               => cfg_miso_i.bresp,          -- out
      s_axi_bvalid              => cfg_miso_i.bvalid,         -- out
      s_axi_bready              => cfg_mosi_i.bready,         -- in
      
      s_axi_araddr              => cfg_mosi_i.araddr(10 downto 0),         -- in
      s_axi_arvalid             => cfg_mosi_i.arvalid,        -- in
      s_axi_arready             => cfg_miso_i.arready,        -- out
      s_axi_rdata               => cfg_miso_i.rdata,          -- out
      s_axi_rresp               => cfg_miso_i.rresp,          -- out
      s_axi_rvalid              => cfg_miso_i.rvalid,         -- out
      s_axi_rready              => cfg_mosi_i.rready,         -- in
      -- Clock out ports  
      mclk_source => MCLK_SOURCE,
      quad_clk_source => ADC_CLK_SOURCE,
      -- Status and control signals                
      locked => clk_rdy_i,
      -- Clock in ports
      clk_in => CLK_100M_IN
      );     
   
end rtl;
