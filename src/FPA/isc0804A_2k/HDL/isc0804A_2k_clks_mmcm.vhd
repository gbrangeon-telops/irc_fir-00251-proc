------------------------------------------------------------------
--!   @file : isc0804A_2k_clks_mmcm
--!   @brief
--!   @details
--!
--!   $Rev: 27287 $
--!   $Author: enofodjie $
--!   $Date: 2022-04-04 14:44:12 -0400 (lun., 04 avr. 2022) $
--!   $Id: isc0804A_2k_clks_mmcm.vhd 27287 2022-04-04 18:44:12Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/isc0804A/HDL/isc0804A_2k_clks_mmcm.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_Define.all; 
use work.fpa_common_pkg.all;  
use work.plle2_drp_define.all;

use work.Tel2000.all;

entity isc0804A_2k_clks_mmcm is 
   
   port(
      ARESET           : in std_logic;
      CLK_100M_IN      : in std_logic;
      
      FPA_INT_CFG      : in fpa_intf_cfg_type;
      
      MCLK_SOURCE      : out std_logic;
      ADC_CLK1_SOURCE  : out std_logic;
      ADC_CLK2_SOURCE  : out std_logic;
      ADC_CLK3_SOURCE  : out std_logic;
      ADC_CLK4_SOURCE  : out std_logic;
      MMCM_LOCKED      : out std_logic
      );
end isc0804A_2k_clks_mmcm;

architecture rtl of isc0804A_2k_clks_mmcm is 

   component SYNC_RESET is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   component double_sync_vector is
      port(
         D : in STD_LOGIC_vector;
		   Q : out STD_LOGIC_vector;
		   CLK : in STD_LOGIC
      );
   end component;
   
   component gh_gray2binary IS
	   GENERIC (size: INTEGER := 8);
	   PORT(	
		   G   : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);	-- gray code in
		   B   : out STD_LOGIC_VECTOR(size-1 DOWNTO 0) -- binary value out
		);
   end component;
   
   component isc0804A_17_5_MHz_mmcm_v3
      port(
         -- Clock out ports
         mclk_source       : out    std_logic;
         quad1_clk_source  : out    std_logic;
         quad2_clk_source  : out    std_logic;
         quad3_clk_source  : out    std_logic;
         quad4_clk_source  : out    std_logic;
         -- Dynamic reconfiguration ports
         daddr             : in     std_logic_vector(6 downto 0);
         dclk              : in     std_logic;
         den               : in     std_logic;
         din               : in     std_logic_vector(15 downto 0);
         dout              : out    std_logic_vector(15 downto 0);
         dwe               : in     std_logic;
         drdy              : out    std_logic;
         -- Status and control signals
         reset             : in     std_logic;
         locked            : out    std_logic;
         -- Clock in ports
         clk_in            : in     std_logic
      );
   end component;
   
   component pll_drp_ctrler
      port(
         -- User interface
         SRESET      : in std_logic;                             
         CLK         : in std_logic;                             
         RSTROBE     : in std_logic;                             
         RADDR       : in std_logic_vector(6 downto 0);          
         RDOUT       : out std_logic_vector(15 downto 0);        
         RDVAL       : out std_logic;                            
         NEW_CFG     : in std_logic;                             
         PHASES      : in phase_array_t(0 to 4);                 
         PLL_RDY     : out std_logic;                            
         -- PLL status and control signals
         PLL_RESET  : out std_logic;                             
         PLL_LOCKED : in std_logic;                              
         -- DRP interface
         DRP_DADDR : out std_logic_vector(6 downto 0);           
         DRP_DCLK  : out std_logic;                              
         DRP_DEN   : out std_logic;                              
         DRP_DIN   : out std_logic_vector(15 downto 0);          
         DRP_DOUT  : in std_logic_vector(15 downto 0);           
         DRP_DWE   : out std_logic;                              
         DRP_DRDY  : in std_logic                                
      );
   end component;

   constant CNT_BIT_MAX : natural := 9;
   
   type cfg_sm_type is(idle, check_phases, new_cfg, pause, wait_lock); 
   
   signal cfg_sm              : cfg_sm_type := idle;
   signal sreset              : std_logic;
   signal pll_locked_i        : std_logic;
   signal pll_rdy_i           : std_logic;
   signal phases_i            : phase_array_t(0 to 4) := (others=>(others=>'0'));
   signal present_phases_i    : phase_array_t(1 to 4) := (others=>(others=>'0'));
   signal drp_dclk_i          : std_logic;
   signal drp_daddr_i         : std_logic_vector(6 downto 0);  
   signal drp_en_i            : std_logic;
   signal drp_dwe_i           : std_logic;
   signal drp_din_i           : std_logic_vector(15 downto 0);  
   signal drp_dout_i          : std_logic_vector(15 downto 0);
   signal drp_drdy_i          : std_logic;
   signal pll_rst_i           : std_logic;
   signal new_cfg_i           : std_logic := '0';
   signal new_cfg_num         : std_logic_vector(FPA_INT_CFG.CFG_NUM'length-1 downto 0) := (others=>'0');
   signal present_cfg_num     : std_logic_vector(FPA_INT_CFG.CFG_NUM'length-1 downto 0) := (others=>'0');
   signal new_cfg_gray        : std_logic_vector(FPA_INT_CFG.CFG_NUM'length-1 downto 0) := (others=>'0');
   signal new_cfg_bin         : std_logic_vector(FPA_INT_CFG.CFG_NUM'length-1 downto 0);
   signal cnt                 : unsigned(CNT_BIT_MAX downto 0) := (others=>'0');
   
begin

   U0A : sync_reset 
   port map(
      ARESET => ARESET, 
      SRESET => sreset, 
      CLK    => CLK_100M_IN
      );
   
   -----------------
   -- Output Mapping
   -----------------
   MMCM_LOCKED <= pll_rdy_i;

   -----------------
   -- Input Mapping
   -----------------
   U0B : process(CLK_100M_IN)
   begin
      if rising_edge(CLK_100M_IN) then
         
         phases_i(0) <= (others=>'0');
         
         if sreset = '1' then
            phases_i(1) <= (others=>'0');
            phases_i(2) <= (others=>'0');
            phases_i(3) <= (others=>'0');
            phases_i(4) <= (others=>'0');
         else
            phases_i(1) <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE1(8 downto 0));
            phases_i(2) <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE2(8 downto 0));
            phases_i(3) <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE3(8 downto 0));
            phases_i(4) <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE4(8 downto 0));
         end if;
      end if;
   end process;
   
   -----------------------------------------------------------------
   -- New Config Detection
   -----------------------------------------------------------------     
   
   -- Gray-coded Config Num Sync
   U1A : double_sync_vector port map(D => std_logic_vector(FPA_INT_CFG.CFG_NUM), Q => new_cfg_gray, CLK => CLK_100M_IN);
   
   -- Gray to Binary Decoding 
   U1B : gh_gray2binary
      generic map (size => FPA_INT_CFG.CFG_NUM'LENGTH)
      port map (G => new_cfg_gray, B => new_cfg_bin);

   -- Binary-coded Config Num Registration
   U1C : process(CLK_100M_IN)
   begin
      if rising_edge(CLK_100M_IN) then
         new_cfg_num <= new_cfg_bin;
      end if;
   end process;
   
   -- Config FSM
   U1D : process(CLK_100M_IN)
   begin
      if rising_edge(CLK_100M_IN) then
         if sreset = '1' then
            new_cfg_i <= '0';
            cnt <= (others=>'0');
            cfg_sm <= idle;
         else
            
            new_cfg_i <= '0'; -- default value 
            
            case cfg_sm is
               when idle =>
                  cnt <= (others=>'0');
                  if new_cfg_num /= present_cfg_num then
                     present_cfg_num <= new_cfg_num;   
                     cfg_sm <= check_phases;
                  end if;
               
               when check_phases =>
                  if phases_i(1) /= present_phases_i(1) or phases_i(2) /= present_phases_i(2) or
                     phases_i(3) /= present_phases_i(3) or phases_i(4) /= present_phases_i(4) then
                     present_phases_i <= phases_i(1 to 4);
                     cfg_sm <= new_cfg;
                  else
                     cfg_sm <= idle;
                  end if;
               
               when new_cfg =>
                  new_cfg_i <= '1';
                  cfg_sm <= pause;

               when pause =>  -- pause ~5 µs
                  if cnt(CNT_BIT_MAX) = '1' then
                     cfg_sm <= wait_lock;   
                  else
                     cnt <= cnt + 1;                  
                  end if;
                  
               when wait_lock =>
                  if pll_rdy_i = '1' then
                     cfg_sm <= idle;
                  end if;  
                  
               when others =>
                  null;
            end case;
         end if;
      end if;
   end process;
     
   -----------------------------------------------------------------
   -- PLL DRP Interface Controller
   -----------------------------------------------------------------     
   U2 : pll_drp_ctrler
   port map ( 
      -- User interface
      SRESET            => sreset,
      CLK               => CLK_100M_IN,
      RSTROBE           => '0',
      RADDR             => (others=>'0'),
      RDOUT             => open,
      RDVAL             => open,
      NEW_CFG           => new_cfg_i,
      PHASES            => phases_i,
      PLL_RDY           => pll_rdy_i,
      -- PLL status and control signals
      PLL_RESET         => pll_rst_i,
      PLL_LOCKED        => pll_locked_i,
      -- DRP interface
      DRP_DADDR         => drp_daddr_i,
      DRP_DCLK          => drp_dclk_i,
      DRP_DEN           => drp_en_i,
      DRP_DIN           => drp_din_i,
      DRP_DOUT          => drp_dout_i,
      DRP_DWE           => drp_dwe_i,
      DRP_DRDY          => drp_drdy_i
   );
   
   -----------------------------------------------------------------
   -- MMCM/PLL
   -----------------------------------------------------------------
   U3 : isc0804A_17_5_MHz_mmcm_v3
   port map (   
      clk_in            => CLK_100M_IN,
      reset             => pll_rst_i,
      locked            => pll_locked_i,
      -- DRP Inteface
      daddr             => drp_daddr_i,
      dclk              => drp_dclk_i,
      den               => drp_en_i,
      dwe               => drp_dwe_i,
      din               => drp_din_i,
      dout              => drp_dout_i,
      drdy              => drp_drdy_i,
      -- outputs
      mclk_source       => MCLK_SOURCE,      
      quad1_clk_source  => ADC_CLK1_SOURCE,
      quad2_clk_source  => ADC_CLK2_SOURCE,
      quad3_clk_source  => ADC_CLK3_SOURCE,
      quad4_clk_source  => ADC_CLK4_SOURCE
   );      
   
end rtl;

